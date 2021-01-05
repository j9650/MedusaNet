# python convert_data_to_disk.py /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind_ /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind_ /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/medusa/pdbbind_output/ /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/pdbbind/ /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind_rmsd_resolution30 30

#import tensorflow as tf
import numpy as np
import os
import sys
#from sklearn import metrics

import dataset_from_file as dff

# set your seeds here, e.g., seeds are [367, 467, 567, ..., 1367]
seeds = [i*100+67 for i in range(3,14)]

def load_and_save_dataset(input_list, label_list_file, pdbbind_dir, groundtruth_dir, output_dir, resolution):
    tile_size = 1024

    if not os.path.isdir(output_dir):
        os.makedirs(output_dir)

    if not os.path.isdir(output_dir+'/train'):
        os.makedirs(output_dir+'/train')
    dff.read_pdbbind_to_disk_rmsd_split(input_list+'train', label_list_file+'train_label', pdbbind_dir, groundtruth_dir,
      output_dir+'/train', resolution, tile_size)

    if not os.path.isdir(output_dir+'/test'):
        os.makedirs(output_dir+'/test')
    dff.read_pdbbind_to_disk_rmsd_split(input_list+'test', label_list_file+'test_label', pdbbind_dir, groundtruth_dir,
      output_dir+'/test', resolution, tile_size)

def srand_data_load_save(input_list, label_list_file, pdbbind_dir, groundtruth_dir, output_dir, cv, resolution, iteration):
    tile_size = 1024

    if not os.path.isdir(output_dir):
        os.makedirs(output_dir)
    if not os.path.isdir(output_dir+'/train'):
        os.makedirs(output_dir+'/train')
    if not os.path.isdir(output_dir+'/test'):
        os.makedirs(output_dir+'/test')

    output_dir_tmp = output_dir + '_tmp'
    if not os.path.isdir(output_dir_tmp):
        os.makedirs(output_dir_tmp)
    if not os.path.isdir(output_dir_tmp+'/train'):
        os.makedirs(output_dir_tmp+'/train')
    if not os.path.isdir(output_dir_tmp+'/test'):
        os.makedirs(output_dir_tmp+'/test')

    train_file_num = 0
    test_file_num = 0

    for i in seeds:
        dff.read_pdbbind_to_disk_rmsd_energy_split(input_list+'train', label_list_file+'/train_sb_s'+str(i)+'.test', pdbbind_dir+str(i), groundtruth_dir,
          output_dir_tmp+'/train', resolution, tile_size)
        dataset_file_list = os.listdir(output_dir_tmp+'/train')
        print(dataset_file_list)

        n = len(dataset_file_list) // 2
        for j in range(train_file_num, train_file_num + n):
            dataset = output_dir_tmp+'/train/'+str(j-train_file_num)+'_data'
            os.rename(dataset, output_dir+'/train/'+str(j)+'_data')
            label = output_dir_tmp+'/train/'+str(j-train_file_num)+'_label'
            os.rename(label, output_dir+'/train/'+str(j)+'_label')
        train_file_num = train_file_num + n



        dff.read_pdbbind_to_disk_rmsd_energy_split(input_list+'test', label_list_file+'/test_sb_s'+str(i)+'.test', pdbbind_dir+str(i), groundtruth_dir,
          output_dir_tmp+'/test', resolution, tile_size)
        dataset_file_list = os.listdir(output_dir_tmp+'/test')
        print(dataset_file_list)

        n = len(dataset_file_list) // 2
        for j in range(test_file_num, test_file_num + n):
            dataset = output_dir_tmp+'/test/'+str(j-test_file_num)+'_data'
            os.rename(dataset, output_dir+'/test/'+str(j)+'_data')
            label = output_dir_tmp+'/test/'+str(j-test_file_num)+'_label'
            os.rename(label, output_dir+'/test/'+str(j)+'_label')
        test_file_num = test_file_num + n


def split_srand_label(pdb_dir, input_list):

    for i in seeds:
        f = open('/home/mdl/hzj5142/AtomNet/cross_validation/check_rmsd/sb_s' + str(i) + '.test', 'r')
        f_train = open('/home/mdl/hzj5142/AtomNet/cross_validation/cv/train_sb_s' + str(i) + '.test', 'w')
        f_test = open('/home/mdl/hzj5142/AtomNet/cross_validation/cv/test_sb_s' + str(i) + '.test', 'w')



        rec_list = []
        ff = open(pdb_dir, 'r')
        for line in ff:
            # rec_list.append(line.strip()+'.pdb')
            rec_list.append(line.strip())
        ff.close()

        rmsd_list = []
        for j in range(len(rec_list)):
            line = f.readline()
            st = line.split()
            rmsd_list.append(st)

        ff = open(input_list+'train', 'r')
        for line in ff:
            protein = line.strip()
            index = rec_list.index(protein)
            st = rmsd_list[index]
            for sss in st:
                f_train.write(sss+'\n')
        ff.close()

        ff = open(input_list+'test', 'r')
        for line in ff:
            protein = line.strip()
            index = rec_list.index(protein)
            st = rmsd_list[index]
            for sss in st:
                f_test.write(sss+'\n')
        ff.close()




        f.close()
        f_train.close()
        f_test.close()


if __name__ == "__main__":

    pdb_dir = int(sys.argv[1])
    # the path of the labels (rmsd)
    label_list_file = '/home/mdl/hzj5142/AtomNet/cross_validation/cv'
    # set the dir to the output poses
    pdbbind_dir = '/home/mdl/hzj5142/AtomNet/medusa/pdbbind_output_S'
    # set the dir to the pdbbind folder
    groundtruth_dir = '/home/mdl/hzj5142/AtomNet/medusa/pdbbind'

    iteration = 20
    resolution = 20
    # output_dir = '/home/mdl/hzj5142/AtomNet/cross_validation/cv/pdbbind_rmsd_srand'
    output_dir = sys.argv[2]
    # input_list = '/home/mdl/hzj5142/AtomNet/cross_validation/cv/pdb_list_'
    input_list = sys.argv[3]+'_'
    
    split_srand_label(pdb_dir, input_list)
    srand_data_load_save(input_list, label_list_file, pdbbind_dir, groundtruth_dir, output_dir, cv, resolution, iteration)
    # load_and_save_dataset(input_list, label_list_file, pdbbind_dir, groundtruth_dir, output_dir, resolution)

