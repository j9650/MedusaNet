# MedusaNet
1. Download PdbBind dataset from http://www.pdbbind.org.cn/. You need to send an email to the admin to obtain the dataset.
The dataset will contains many folders and each folder contains a protein file XXX.pdb and a ligand file XXX.mol2

2. Run MedusaDock to get the output poses (generating the train/test data) with the command:
medusa dock -p parameter -i pdbbind/[XXX]/[XXX].rec.pdb -m pdbbind/[XXX]/[XXX].lig.mol2 -o pdbbind_output_S[XYZ]/XXX.pdb -R -fast -S [XYZ]

3. Each pose file (XXX.pdb files) contains several poses, run MedusaDock to calculate the RMSD for each pose to the ground truth pose.
medusa complex rmsd -r pdbbind/[XXX]/[XXX].rec.pdb pdbbind/[XXX]/[XXX].lig.mol2 -t pdbbind_output_S[XYZ]/[XXX].pdb -align receptor -object ligand > rmsd/S[XYZ].test

4. Use convert_data_to_disk.py to generate the data for training, make sure "pdbbind_list" contrains the IDs of all proteins, "pdb_list_train" & "pdb_list_test" contains the IDs of all train/test protein.
python convert_data_to_disk.py pdbbind_rmsd_srand pdb_list

The "pdbbind_rmsd_srand" folder will contain the train/test data.

5. Train the model with test_atom_withenergy_res.py

