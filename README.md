# MedusaNet
1. Download PdbBind dataset from http://www.pdbbind.org.cn/. You need to send an email to the admin to obtain the dataset.
The dataset will contains many folders and each folder contains a protein file XXX.pdb and a ligand file XXX.mol2

2. Run MedusaDock to get the output poses (generating the train/test data) with the command:
medusa dock -p parameter -i pdbbind/[XXX]/[XXX].rec.pdb -m pdbbind/[XXX]/[XXX].lig.mol2 -o pdbbind_output_S[XYZ]/XXX.pdb -R -fast -S [XYZ]
