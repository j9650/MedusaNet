# python test_converge_NN.py 20 /gpfs/scratch/hzj5142/AtomNet/medusa/pdbbind_output_s /gpfs/scratch/hzj5142/AtomNet/medusa/cal_rmsd/rmsd_res /gpfs/scratch/hzj5142/AtomNet/medusa/tmp_data /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind/model_withenergy_srand_5conv_50epoch_iter26.h5 /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/medusa/run_medusa/pdbbind_listtest100 4
# python test_converge_NN.py 20
# /gpfs/scratch/hzj5142/AtomNet/medusa/pdbbind_output_s
# /gpfs/scratch/hzj5142/AtomNet/medusa/cal_rmsd/rmsd_res
# /gpfs/scratch/hzj5142/AtomNet/medusa/tmp_data
# /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind/model_withenergy_srand_5conv_50epoch_iter26.h5
# /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/medusa/run_medusa/pdbbind_listtest100 4



from __future__ import absolute_import, division, print_function, unicode_literals
import tensorflow as tf
#import keras
from tensorflow.keras import backend as K
import numpy as np
import os
import sys
from sklearn import metrics

import read_tf_input
import dataset_from_file as dff


def find_backup_pose(labels, scores, fix_th, gt_th):
    zipped = zip(labels, scores)
    zipped_tmp = sorted(zipped, key=lambda x: x[1])
    succ = 0
    iters = fix_th
    if iters > len(zipped_tmp):
        iters = len(zipped_tmp)
    for i in range(iters):
        label, score = zipped_tmp[i]
        if float(label) <= gt_th:
            succ = succ + 1
    #if succ > 0:
    #    top_succ = top_succ + 1
    return succ


def geo_mean(iterable):
    a = np.array(iterable)
    return a.prod()**(1.0/len(a))


def avg_mean(iterable):
    a = np.array(iterable)
    return np.sum(a) / len(a)

def init_data(resolution, pdb_dir, rmsd_dir, data_dir, protein_list, start_iter, end_iter, start_pdb, end_pdb):
    proteins = []
    f = open(protein_list,'r')
    for line in f:
        proteins.append(line.strip())
    f.close()
    tot = len(proteins)

    all_rmsd = []
    for protein in proteins:
        global_min_energy = 99999.9
        rmsd_file = open(rmsd_dir+'/sb_'+protein+'.rmsd','r')
        all_rmsd.append([])
        for line in rmsd_file:
            all_rmsd[-1].append(line.strip())
        rmsd_file.close()

    Atoms = ['N', 'C', 'O', 'S', 'Br', 'Cl', 'P', 'F', 'I']
    print("total data: " + str(tot))

    Atoms_new = []
    for atom in Atoms:
        Atoms_new.append('p'+atom)
        Atoms_new.append('l'+atom)
    Atoms = Atoms_new
    Atoms.append('lH')
    print("total atoms: " + str(len(Atoms)))
    print(Atoms)

    tile_size = 512
    tmp_data = np.zeros((tile_size, resolution, resolution, resolution, len(Atoms)))
    tmp_label = np.zeros((tile_size, 4))
    protein_l = []
    ligand_l = []
    file_counter = 0
    this_pose_energy = 0.0
    """Generate 3D data files

    """
    protein_index = 0
    for seed in range(start_iter, end_iter):
        print("seed: "+str(seed))
        protein_index = 0
        for protein_index in range(start_pdb, end_pdb):
        #for protein in proteins:
            protein = proteins[protein_index]
            data_path = data_dir + '/' + protein
            if not os.path.exists(data_path):
                os.makedirs(data_path)

            f = open(pdb_dir+str(seed)+'67/'+protein+'.pdb',"r")
            tot = 0
            # flag_label = 0
            rmsds = all_rmsd[protein_index][seed-8].split()
            for st in f:
                ss = st.split()
                if (ss[0] == 'REMARK') and (ss[1] == 'E_total:'):
                    this_pose_energy = float(ss[2])
                if (ss[0] == 'ENDMDL'):
                    if len(protein_l) == 0 or len(ligand_l) == 0:
                        print("ligand or protein is none: " + str(seed) + " of " + protein)
                        continue
                    tmp_data[tot] = dff.gen_3D_2_split(protein_l, ligand_l, Atoms, 20, resolution, tmp_data[tot])
                    protein_l = []
                    ligand_l = []
                    this_pose_rmsd = float(rmsds[tot])
                    if (this_pose_rmsd <= 3):
                        tmp_label[tot, 0] = 0
                        tmp_label[tot, 1] = 1
                    else:
                        tmp_label[tot, 0] = 1
                        tmp_label[tot, 1] = 0
                    tmp_label[tot, 2] = this_pose_rmsd
                    tmp_label[tot, 3] = this_pose_energy
                    tot = tot + 1
    
                    
                if (ss[0] == 'ATOM'):
                    protein_l.append(st[:-1])
                if (ss[0] == 'HETATM'):
                    ligand_l.append(st[:-1])

            assert tot == len(rmsds)
            dff.write_data_to_file_easy_rmsd(data_path+"/"+str(protein), tmp_data[:tot,:,:,:,:], tmp_label[:tot,:])
            tmp_data.fill(0)
            tmp_label.fill(0)
    
            f.close()
            protein_index = protein_index + 1






def train_and_infer(resolution, pdb_dir, rmsd_dir, data_dir, model_dir, protein_list, convert_th, gt_th):
    proteins = []
    f = open(protein_list,'r')
    for line in f:
        proteins.append(line.strip())
    f.close()

    #conf = tf.ConfigProto(device_count={'CPU': 12},intra_op_parallelism_threads=12,inter_op_parallelism_threads=12)
    #K.set_session(tf.Session(config=conf))
    

    '''
    init model and test data
    '''
    model = tf.keras.models.load_model(model_dir)

    energy_mode = 1
    if type(model.input_spec) == list:
        energy_mode = 2

    x_test = np.ones((1, resolution, resolution, resolution, 1))
    y_test = np.ones((1,4))




    
    fix_th = convert_th
    success_protein = 0
    success_protein2 = 0
    stop_attemp_list = []
    protein_data_files = {}
    protein_label_files = {}
    for protein in proteins:
        data_path = data_dir + '/' + protein + '/' + protein + '_data'
        protein_data_files[protein] = open(data_path, "r")
        data_path = data_dir + '/' + protein + '/' + protein + '_label'
        protein_label_files[protein] = open(data_path, "r")

    all_selected_rmsds = []
    this_selected_rmsds = []
    for protein in proteins:
        this_selected_rmsds = []
        global_min_energy = 99999.9
        rmsd_file = open(rmsd_dir+'/sb_'+protein+'.rmsd','r')
        #print(rmsd_file)
        stop_attemp = 0
        found_good_pose = 0
        good_pose_num = 0
        convert_th = fix_th

        flag = 0
        found = 0
        found_list = []

        backup_neg_rmsd = []
        backup_neg_energy = []
        for seed in range(8, 2001):
            #print(seed)
            rmsd_line = rmsd_file.readline()
            rmsds = rmsd_line.split()

            data_path = data_dir + '/' + protein + '/' + str(seed)
            if energy_mode == 1:
                x_test, y_test, tot = dff.read_data_from_file_easy_rmsd_th(data_path, x_test, y_test, df=protein_data_files[protein], lf=protein_label_files[protein])
                assert tot == len(rmsds)
                if tot == 0:
                    continue
                result = model.predict(x_test[0:tot,:,:,:,:], batch_size=tot)
            else:
                x_test, y_test, tot = dff.read_data_from_file_withenergy(data_path, x_test, y_test, df=protein_data_files[protein], lf=protein_label_files[protein])
                assert tot == len(rmsds)
                if tot == 0:
                    continue
                # print(data_path)
                # print(x_test[:tot])
                result = model.predict([x_test[0:tot,:,:,:,:], y_test[:tot,3]], batch_size=tot)


            for i in range(tot):
                if result[i,1] > result[i,0]:
                    flag = flag + 1
                    if float(rmsds[i]) <= gt_th:
                        found_good_pose = found_good_pose + 1
                    this_selected_rmsds.append(float(rmsds[i]))
                else:
                    backup_neg_rmsd.append(rmsds[i])
                    backup_neg_energy.append(result[i,1])

                if float(rmsds[i]) <= gt_th:
                    good_pose_num = good_pose_num + 1

            if tot == 0:
                print(protein+" is 0 poses! at iter " + str(seed))

            if flag >= convert_th:
                stop_attemp = seed
                stop_attemp_list.append(seed)
                break;
            # print(result[:,1])

        if stop_attemp == 0 and flag < convert_th:
            found_good_pose += find_backup_pose(backup_neg_rmsd, backup_neg_energy, convert_th-flag, gt_th)
            stop_attemp_list.append(2000)
        print(protein+' stop at '+str(stop_attemp))
        avg_rmsd = 0.0
        if len(this_selected_rmsds) > 0:
            avg_rmsd = sum(this_selected_rmsds) / len(this_selected_rmsds)
            all_selected_rmsds.append(avg_rmsd)
        print('found '+str(found_good_pose)+' good poses, total ' + str(good_pose_num) + ' good poses, avg rmsd is: ' + str(avg_rmsd))
        if found_good_pose>0:
            success_protein = success_protein + 1
        if good_pose_num>0:
            success_protein2 = success_protein2 + 1
        # break

    assert len(stop_attemp_list) == len(proteins)
    print(len(all_selected_rmsds))
    print(sum(all_selected_rmsds) / len(all_selected_rmsds))
    print(str(success_protein)+' proteins success!')
    print('average attemps: '+str(avg_mean(stop_attemp_list)))
    print(str(success_protein2)+' proteins success!')






if __name__ == "__main__":
    resolution = int(sys.argv[1])  # 30
    pdb_dir = sys.argv[2]  # /gpfs/scratch/hzj5142/AtomNet/medusa/pdbbind_output_s
    rmsd_dir = sys.argv[3]  # /gpfs/scratch/hzj5142/AtomNet/medusa/cal_rmsd/rmsd_res
    data_dir = sys.argv[4]  # /gpfs/scratch/hzj5142/AtomNet/medusa/tmp_data_30
    model_dir = sys.argv[5]  # /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind/model_withenergy_srand_5conv_50epoch_iter26.h5
    protein_list = sys.argv[6]  # /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/medusa/run_medusa/pdbbind_listtest100
    convert_th = int(sys.argv[7])  # 4
    start_iter = int(sys.argv[8])
    end_iter = int(sys.argv[9])
    mode = int(sys.argv[10])
    gt_th = float(sys.argv[11])
    start_pdb = int(sys.argv[12])
    end_pdb = int(sys.argv[13])

    if mode == 1:
        #generate the data for iter: start_iter - end_iter
        init_data(resolution, pdb_dir, rmsd_dir, data_dir, protein_list, start_iter, end_iter, start_pdb, end_pdb)

    if mode == 2:
        #compute the result. how many protein can find good pose with threshold 'convert_th'
        train_and_infer(resolution, pdb_dir, rmsd_dir, data_dir, model_dir, protein_list, convert_th, gt_th)




