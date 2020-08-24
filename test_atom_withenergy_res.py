# python test_atom_classification.py /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind_train /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind_train_label /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/medusa/pdbbind_output/ /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/pdbbind/ 20  /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind_rmsd_srand2 /gpfs/group/mtk2/cyberstar/hzj5142/AtomNet/AtomNet/tmp_data/pdbbind/model_rmsd_srand_5conv_50epoch.h5


from __future__ import absolute_import, division, print_function, unicode_literals
import tensorflow as tf
from tensorflow.keras import backend as K
import math
import numpy as np
import os
import sys
import random
from sklearn import metrics
from tensorflow.keras.layers import Input, Concatenate, Conv3D, Flatten, Dense, Dropout, Add, AveragePooling3D, MaxPooling3D

import dataset_from_file as dff


def eval_atom(result, label):
    true_pos = 0
    true_neg = 0
    false_pos = 0
    false_neg = 0

    #print(result)
    #print(label)
    gt_true = 0
    gt_false = 0
    po_true = 0
    po_false = 0
    ne_true = 0
    ne_false = 0
    tot_rmsd_p = 0.0
    tot_rmsd_n = 0.0
    total_rmsd_pt = 0.0
    total_rmsd_pf = 0.0
    total_rmsd_nt = 0.0
    total_rmsd_nf = 0.0
    for i in range(result.shape[0]):
        #print(i)
        if (result[i,0] > 0.5 and label[i,0] == 1):
            true_neg = true_neg + 1
        if (result[i,1] > 0.5 and label[i,1] == 1):
            true_pos = true_pos + 1
        if (result[i,0] > 0.5 and label[i,1] == 1):
            false_neg = false_neg + 1
        if (result[i,1] > 0.5 and label[i,0] == 1):
            false_pos = false_pos + 1

        rmsd = label[i,2]
        if rmsd == 0:
            if result[i,1] > 0.5:
                gt_true = gt_true + 1
            else:
                gt_false = gt_false + 1
        elif label[i,1] == 1:
            tot_rmsd_p += rmsd
            if result[i,1] > 0.5:
                po_true = po_true + 1
                total_rmsd_pt += rmsd
            else:
                po_false = po_false + 1
                total_rmsd_pf += rmsd
        else:
            tot_rmsd_n += rmsd
            if result[i,0] > 0.5:
                ne_true = ne_true + 1
                total_rmsd_nt += rmsd
            else:
                ne_false = ne_false + 1
                total_rmsd_nf += rmsd


    print("true_pos: "+str(true_pos))
    print("true_neg: "+str(true_neg))
    print("false_pos: "+str(false_pos))
    print("false_neg: "+str(false_neg))
    print('acc: ', float(true_pos+true_neg)/float(false_pos+false_neg+true_pos+true_neg))

    print("gt_true: "+str(gt_true))
    print("gt_false: "+str(gt_false))
    print("po_true: "+str(po_true))
    print("po_false: "+str(po_false))
    print("ne_true: "+str(ne_true))
    print("ne_false: "+str(ne_false))
    precision = 0.0
    if po_true+ne_false != 0:
        precision = po_true/(po_true+ne_false)
    recall = 0.0
    if po_true+po_false != 0:
        recall = po_true/(po_true+po_false)
    print("precision: "+str(precision))
    print("recall: "+str(recall))
    print("multi: "+str(precision*recall))

    print("rmsd:")
    print("tot_rmsd_p: ", tot_rmsd_p / (po_true + po_false))
    print("total_rmsd_pf: ", total_rmsd_pf / po_false)
    print("tot_rmsd_n: ", tot_rmsd_n / (ne_true + ne_false))
    print("total_rmsd_nf: ", total_rmsd_nf / ne_false)


    fpr, tpr, thresholds = metrics.roc_curve(label[:,1], result[:,1], pos_label=1)
    print('auc: ', metrics.auc(fpr, tpr))

    print('evaluate_wo_gt: ')
    print('acc: ', float(po_true+ne_true)/float(po_true+po_false+ne_true+ne_false))
    result_wo = []
    label_wo = []
    tot = 0
    for i in range(result.shape[0]):
        if label[i,2] != 0.0:
            result_wo.append(result[i, 1])
            label_wo.append(label[i, 1])
    tot = len(result_wo)
    fpr, tpr, thresholds = metrics.roc_curve(label_wo, result_wo, pos_label=1)
    print('auc: ', metrics.auc(fpr, tpr))




def eval_rmsd(result, label):
    corrcoef = np.corrcoef(result, label)

    print(corrcoef)
    print(result[:15])
    print(label[:15])

def get_sample_weight(y_train, tot, th):
    gt = 0.0
    n_p = 0.0
    p_p = 0.0
    for i in range(tot):
        if y_train[i, 2] == 0:
            gt += 1
        elif y_train[i, 2] <= th:
            p_p += 1
        else:
            n_p += 1

    return gt, n_p, p_p

def generate_sample_weight(sample_weight, y_train, tot, weight, false_th):
    for i in range(tot):
        if y_train[i, 2] <= false_th:
            sample_weight[i] = weight
            if y_train[i, 2] > 0:
                sample_weight[i] += weight * (math.exp(- (y_train[i, 2] - false_th)**2))
        else:
            sample_weight[i] = 1.0 + math.exp(- (y_train[i, 2] - false_th)**2)

    return sample_weight


def get_weight(y_train, tot):
    pos = 0.0
    neg = 0.0
    for i in range(tot):
        if (y_train[i,1] == 1):
            pos = pos + 1
        if (y_train[i,0] == 1):
            neg = neg + 1
    return neg / pos


def get_model(shape, vec_len):
    input1 = Input((shape[0], shape[1], shape[2], shape[3]))
    input2 = Input((vec_len,))

    conv1 = Conv3D(filters=128, kernel_size=(5,5,5), activation='relu')(input1)  # 30, 30, 30, 19
    conv2 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv1)  # 26, 26, 26, 128
    #conv3 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv2)  # 34, 34, 34, 256
    pool1 = AveragePooling3D(pool_size=(2, 2, 2))(conv2) # 24 24 256
    conv4 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(pool1)  # 12, 12, 12, 256
    conv5 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv4)  # 10, 10, 10, 256
    conv6 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv5)  # 8, 8, 8, 256
    #pool2 = AveragePooling3D(pool_size=(2, 2, 2))(conv6)
    #conv6 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv5)  # 10, 10, 10, 256

    flatten = Flatten()(conv6)

    dense1 = Dense(1024, activation='relu')(flatten)

    dropout1 = Dropout(0.5)(dense1)
    concat=Concatenate()([dropout1,input2])

    dense2 = Dense(1024, activation='relu')(concat)
    dense_add1 = Add()([dense2, dropout1])

    dropout2 = Dropout(0.5)(dense_add1)
    output = Dense(2, activation='softmax')(dropout2)

    model = tf.keras.models.Model(inputs=[input1, input2], outputs=output)
    return model

def get_model_20(shape, vec_len):
    input1 = Input((shape[0], shape[1], shape[2], shape[3]))
    input2 = Input((vec_len,))

    conv1 = Conv3D(filters=128, kernel_size=(5,5,5), activation='relu')(input1)  # 20, 20, 20, 19
    conv2 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv1)  # 16, 16, 16, 128
    conv3 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv2)  # 14, 14, 14, 256
    conv4 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv3)  # 12, 12, 12, 256
    conv5 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv4)  # 10, 10, 10, 256
    conv6 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv5)  # 8, 8, 8, 256
    #pool2 = AveragePooling3D(pool_size=(2, 2, 2))(conv6)
    #conv6 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv5)  # 10, 10, 10, 256

    flatten = Flatten()(conv6)

    dense1 = Dense(1024, activation='relu')(flatten)

    dropout1 = Dropout(0.5)(dense1)
    concat=Concatenate()([dropout1,input2])

    dense2 = Dense(1024, activation='relu')(concat)
    dense_add1 = Add()([dense2, dropout1])

    dropout2 = Dropout(0.5)(dense_add1)
    output = Dense(2, activation='softmax')(dropout2)

    model = tf.keras.models.Model(inputs=[input1, input2], outputs=output)
    return model

def get_model_30(shape, vec_len):
    input1 = Input((shape[0], shape[1], shape[2], shape[3]))
    input2 = Input((vec_len,))

    conv1 = Conv3D(filters=128, kernel_size=(5,5,5), activation='relu')(input1)  # 30, 30, 30, 19
    conv2 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv1)  # 26, 26, 26, 128
    conv3 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv2)  # 24, 24, 24, 256
    conv4 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv3)  # 22, 22, 22, 256
    conv5 = Conv3D(filters=512, kernel_size=(3,3,3), activation='relu')(conv4)  # 20, 20, 20, 256
    conv6 = Conv3D(filters=512, kernel_size=(3,3,3), activation='relu')(conv5)  # 18, 18, 18, 512
    pool1 = MaxPooling3D(pool_size=(2, 2, 2))(conv6) # 16, 16, 16, 512
    conv7 = Conv3D(filters=512, kernel_size=(3,3,3), activation='relu')(pool1)  # 8, 8, 8, 512
    #pool2 = AveragePooling3D(pool_size=(2, 2, 2))(conv6)
    #conv6 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv5)  # 10, 10, 10, 256

    flatten = Flatten()(conv7)

    dense1 = Dense(1024, activation='relu')(flatten)

    dropout1 = Dropout(0.5)(dense1)
    concat=Concatenate()([dropout1,input2])

    dense2 = Dense(1024, activation='relu')(concat)
    dense_add1 = Add()([dense2, dropout1])

    dropout2 = Dropout(0.5)(dense_add1)
    output = Dense(2, activation='softmax')(dropout2)

    model = tf.keras.models.Model(inputs=[input1, input2], outputs=output)
    return model

def get_model_40(shape, vec_len):
    input1 = Input((shape[0], shape[1], shape[2], shape[3]))
    input2 = Input((vec_len,))

    conv1 = Conv3D(filters=128, kernel_size=(5,5,5), activation='relu')(input1)  # 40, 40, 40, 19
    conv2 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv1)  # 36, 36, 36, 256
    conv3 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv2)  # 34, 34, 34, 256
    pool1 = MaxPooling3D(pool_size=(2, 2, 2))(conv3) # 32 32 32 256
    conv4 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(pool1)  # 16, 16, 16, 256
    conv5 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv4)  # 14, 14, 14, 256
    #pool1 = MaxPooling3D(pool_size=(2, 2, 2))(conv3) # 32 32 32 256
    conv6 = Conv3D(filters=512, kernel_size=(3,3,3), activation='relu')(conv5)  # 12, 12, 12, 256
    conv7 = Conv3D(filters=512, kernel_size=(3,3,3), activation='relu')(conv6)  # 10, 10, 10, 512
    conv8 = Conv3D(filters=512, kernel_size=(3,3,3), activation='relu')(conv7)  # 8, 8, 8, 512
    #pool2 = AveragePooling3D(pool_size=(2, 2, 2))(conv6)
    #conv6 = Conv3D(filters=256, kernel_size=(3,3,3), activation='relu')(conv5)  # 10, 10, 10, 256

    flatten = Flatten()(conv8)

    dense1 = Dense(1024, activation='relu')(flatten)

    dropout1 = Dropout(0.5)(dense1)
    concat=Concatenate()([dropout1,input2])

    dense2 = Dense(1024, activation='relu')(concat)
    dense_add1 = Add()([dense2, dropout1])

    dropout2 = Dropout(0.5)(dense_add1)
    output = Dense(2, activation='softmax')(dropout2)

    model = tf.keras.models.Model(inputs=[input1, input2], outputs=output)
    return model

def train_and_infer(resolution, data_dir, model_dir, true_th=3, false_th=3, sw="False"):
    
    use_sample_weight = False
    if sw == "True":
        use_sample_weight = True

    print(data_dir)
    tile_size = 1024
    batch_size = 128

    x_train = np.ones((1, resolution, resolution, resolution, 1))
    y_train = np.ones((1,4))

    x_test = np.ones((1, resolution, resolution, resolution, 1))
    y_test = np.ones((1,4))

    x_train, y_train, tot = dff.read_data_from_file_withenergy(data_dir+'/train/0', x_train, y_train, true_th=true_th, false_th=false_th)
    x_train1 = np.zeros((tile_size,1))
    x_test, y_test, tot = dff.read_data_from_file_withenergy(data_dir+'/test/0', x_test, y_test, true_th=true_th, false_th=false_th)

    print(x_train.shape)
    print(x_test.shape)
    
    
    #1
    model = None
    if resolution == 20:
        model = get_model_20([resolution, resolution, resolution, x_train.shape[4]], 1)
    if resolution == 30:
        model = get_model_30([resolution, resolution, resolution, x_train.shape[4]], 1)
    if resolution == 40:
        model = get_model_40([resolution, resolution, resolution, x_train.shape[4]], 1)
    



    sgd = tf.keras.optimizers.SGD(lr=0.001, decay=1e-6, momentum=0.9)
    metric = tf.keras.metrics.BinaryAccuracy(threshold=0.5)
    #losss = 'sparse_categorical_crossentropy'
    losss = 'binary_crossentropy'
    #losss = 'mean_squared_error'
    adam = tf.keras.optimizers.Adam(lr=0.001, decay=5e-5)
    
    #2
    model.compile(optimizer=sgd,
                  loss=losss,
                  metrics=[metric])
    
    class_weight = {0: 1.0, 1: 1.0}

    train_dataset_num = int(len(os.listdir(data_dir+'/train')) / 2)

    ground_truth = 0.0
    negative_pose = 0.0
    positive_pose = 0.0
    total_pose = 0.0
    
    for j in range(train_dataset_num):
        x_train, y_train, tot = dff.read_data_from_file_withenergy(data_dir+'/train/'+str(j), x_train, y_train, true_th=true_th, false_th=false_th)
        gt, n_p, p_p = get_sample_weight(y_train, tot, false_th)
        ground_truth += gt
        negative_pose += n_p
        positive_pose += p_p
        total_pose += tot

    weight_gt = negative_pose / 2 / ground_truth
    weight_pp = negative_pose / 2 / positive_pose
    print('ground_truth: ', ground_truth)
    print('negative_pose: ', negative_pose)
    print('positive_pose: ', positive_pose)
    weight = negative_pose / (ground_truth + positive_pose)

    weight_np = 1.0
    weight = (negative_pose) / (ground_truth + positive_pose)
    class_weight = {0: weight_np, 1: weight}
    print(class_weight)


    test_dataset_num = int(len(os.listdir(data_dir+'/test')) / 2)
    x_test = np.zeros((tile_size, resolution, resolution, resolution, x_test.shape[4]))
    y_test = np.zeros((test_dataset_num*tile_size,4))
    result = np.zeros((test_dataset_num*tile_size,2))
    print('true_th: ',str(true_th))
    print('false_th: ',str(false_th))
    sample_weight = np.ones((tile_size))
    gt_tot = 0

    random_list = list(range(train_dataset_num))
    for i in range(0, 20):
        gt_tot = 0
        random.shuffle(random_list)
        for j in random_list:
            x_train, y_train, tot = dff.read_data_from_file_withenergy(data_dir+'/train/'+str(j), x_train, y_train, true_th=true_th, false_th=false_th)
            # x_train, y_train, tot, gt_tot = dff.read_data_from_file_withenergy_limitgt(data_dir+'/train/'+str(j), x_train, y_train, true_th=true_th, false_th=false_th, gt_tot = gt_tot)

            if use_sample_weight:
                sample_weight = generate_sample_weight(sample_weight, y_train, tot, weight, false_th)
                # print(tot)
                # print(sample_weight)
                model.fit([x_train[0:tot,:,:,:,:], y_train[0:tot,3]], y_train[0:tot,:2], batch_size=batch_size, epochs=i+1, initial_epoch=i, sample_weight=sample_weight[:tot], verbose=1)
            else:
                model.fit([x_train[0:tot,:,:,:,:], y_train[0:tot,3]], y_train[0:tot,:2], batch_size=batch_size, epochs=i+1, initial_epoch=i, class_weight=class_weight, verbose=1)
            #model.fit([x_train[0:tot,:,:,:,:], y_train[0:tot,3]], y_train[0:tot,:2], batch_size=batch_size, epochs=i+1, initial_epoch=i, sample_weight=sample_weight[:tot], verbose=1)
            #model.fit([x_train[0:tot,:,:,:,:], y_train[0:tot,3]], y_train[0:tot,:2], batch_size=batch_size, epochs=i+1, initial_epoch=i, verbose=1)

        print('evaluate:')
        cc = 0
        for j in range(test_dataset_num):
            x_test, y_test[cc:cc+1024,:], tot = dff.read_data_from_file_withenergy(data_dir+'/test/'+str(j), x_test, y_test[cc:cc+1024,:], true_th=true_th, false_th=false_th)
            result[cc:cc+tot,:] = model.predict([x_test[:tot,:,:,:,:], y_test[cc:cc+tot,3]], batch_size=batch_size)
            cc = cc + tot

        print(result.shape, y_test.shape)
        eval_atom(result[:cc,:], y_test[:cc,:])
        
        dir_model = model_dir+'_iter'+str(i)+'.h5'
        tf.keras.models.save_model(model, dir_model)


    print(result.shape)





if __name__ == "__main__":
    os.environ["CUDA_VISIBLE_DEVICES"]=sys.argv[6]
    resolution = int(sys.argv[1])
    data_dir = sys.argv[2]
    model_dir = sys.argv[3]
    t_th = float(sys.argv[4])
    f_th = float(sys.argv[5])
    sw = "False"
    if len(sys.argv) > 6:
        sw = sys.argv[7]

    train_and_infer(resolution, data_dir, model_dir, true_th=t_th, false_th=f_th, sw=sw)



