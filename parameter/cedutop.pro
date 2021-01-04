remarks  Residue Topology File for Proteins Using United Atoms
remarks  FORCEFIELD = CED001
set echo=false end

{ Special rules for making cedar forcefield }
{ IMPROPER TORSIONS must be arranged as follows
    Let C = central atom, B = backchain of C,
	R = reference, and Y = out-of-plane
	B, R and Y are bonded to C, i.e.,
    B<C (Backchain(C)=B) 
    C<R (Backchain(R)=C)
    C<Y (Backchain(Y)=C)
  Then arrange the atoms as follows:
    IMPROPER B C R Y 
  and follow the same order in the parameter file
}

{ CHIRAL CENTERS:
    SigmaX reproduces the chiral center potential of the SigmaC
    program, which charmm/xplor does not have. To flag a chiral center
    for SigmaX (will be OK in XPLOR), use an IMPROPER term with
    a zero force constant and NEGATIVE MULTIPLICITY.

    Arrange the atoms as for an improper
	IMPROPER B C R Y

    EXAMPLE:
	{ Chirality term, central atom = CA }
  in topallh.cedar file:   IMPROPER N CA C CB
  in paramallh.cedar file: IMPROPER (atom n)(atom ca)(atom c)(atom cb) -1.0 0 120
}

!set echo=false end
autogenerate angles=true end

MASS     H      1.00800 !polar hydrogen
MASS     HC     1.00800
MASS     CR    12.01100 !carbonyl carbon
MASS     CRNP  12.01100 !carbonyl carbon
MASS     CA    12.01100 !aliphatic carbon
MASS     CA1   13.01900 !aliphatic carbon with 1 hydrogen
MASS     CA1P  13.01900 !aliphatic carbon with 1 hydrogen
MASS     CA2   14.02700 !aliphatic carbon with 2 hydrogens
MASS     CA2P  14.02700 !aliphatic carbon with 2 hydrogens
MASS     CA3   15.03500 !aliphatic carbon with 3 hydrogens
MASS     CM1   13.01900 !aromatic carbon with 1 hydrogen
MASS     CM1P  13.01900 !aromatic carbon with 1 hydrogen
MASS     NCK   14.00700 ! charged nitrogen for lys
MASS     NCR   14.00700 ! charged nitrogen for arg
MASS     NZ    14.00700 ! peptide nitrogen
MASS     NR    14.00700 ! nitrogen in aromatic ring with no hydrogens
MASS     NZNP  14.00700 ! peptide nitrogen
MASS     NZNQ  14.00700 ! nitrogen for asn and glu
MASS     OC    15.99900 ! charged oxygen
MASS     OZ    15.99900 ! carbonyl and charged oxygen
MASS     OW    15.99900 ! water oxygen
MASS     OZH   15.99900 ! serine
MASS     SG    32.06000 ! sulfur
MASS     SGNP  32.06000 ! sulfur S-S bond and met
END
!======================================================================


RESIdue ACE
GROUP
 ATOM CA   TYPE=CA3 CHARge=0.0000   END
GROUP
 ATOM C    TYPE=CR  CHARge=0.38000  END
 ATOM O    TYPE=OZ  CHARge=-0.380   END

BOND C CA     BOND O C 

END
!======================================================================

RESIdue ALA 
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280  END
 ATOM HN   TYPE=H   CHARge=0.280   END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.000   END
GROUP
 ATOM CB   TYPE=CA3 CHARge=0.000  END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380   END
 ATOM O    TYPE=OZ  CHARge=-0.380  END

BOND CB CA   BOND N  HN    BOND N  CA    BOND O  C 
BOND C  CA

{ Chirality term }
IMPROPER N  CA C  CB

END
!======================================================================

RESIdue GLY  
GROUP
 ATOM N    TYPE=NZ   CHARge=-0.280 END
 ATOM HN   TYPE=H   CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA2 CHARge=0.000 END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END

BOND N HN   BOND N CA  BOND O C   BOND C CA

END
!======================================================================

RESIdue VAL
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280  END { Cedar charges }
 ATOM HN   TYPE=H   CHARge=0.280   END
GROUP 
 ATOM CA   TYPE=CA1  CHARge=0.000  END { Atom type is CA, not CT }
GROUP
 ATOM CB   TYPE=CA1  CHARge=0.000 END
GROUP
 ATOM CG2  TYPE=CA3  CHARge=0.000 END
GROUP
 ATOM CG1  TYPE=CA3  CHARge=0.000 END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380   END
 ATOM O    TYPE=OZ  CHARge=-0.380  END
{ Bonds are the same }
BOND CB CA     BOND CG1 CB     BOND CG2 CB       BOND N HN
BOND N CA      BOND O C        BOND C CA
{ Angles are auto-generated }
IMPROPER N CA C CB { Chirality term }
IMPROPER CA CB CG1 CG2 { Chirality term }
{ reorder the atoms in the dihedrals }
DIHE N    CA   CB   CG1
END
!======================================================================

RESIdue AIB
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280  END { Cedar charges }
 ATOM HN   TYPE=H   CHARge=0.280   END
GROUP
 ATOM CA   TYPE=CA   CHARge=0.000  END { Atom type is CA, not CT }
GROUP
 ATOM CB2  TYPE=CA3  CHARge=0.000 END
GROUP
 ATOM CB1  TYPE=CA3  CHARge=0.000 END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380   END
 ATOM O    TYPE=OZ  CHARge=-0.380  END
{ Bonds are the same }
BOND CB1 CA    BOND CB2 CA     BOND N HN
BOND N CA      BOND O C        BOND C CA
{ Angles are auto-generated }
IMPROPER N  CA CB1 CB2 { Chirality term }
IMPROPER N  CA C   CB2 { Chirality term }
IMPROPER N  CA C   CB1 { Chirality term }
END
!======================================================================

RESidue MAM 
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280 END
 ATOM HN   TYPE=H   CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA3 CHARge=0.000  END
     
BOND N HN   BOND N CA

END
!======================================================================

RESidue LEU
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280 END
 ATOM HN   TYPE=H   CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2 CHARge=0.000 END
GROUP
 ATOM CG   TYPE=CA1 CHARge=0.000 END
GROUP
 ATOM CD2  TYPE=CA3 CHARge=0.000 END
GROUP
 ATOM CD1  TYPE=CA3 CHARge=0.000 END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END
BOND CB CA     BOND CG CB    BOND CD1 CG    BOND CD2 CG
BOND N HN      BOND N CA     BOND O C       BOND C CA
IMPRoper N   CA    C    CB  !tetrahedral CA
IMPRoper CB  CG    CD1  CD2
DIHE     N   CA    CB   CG    DIHE CA   CB   CG   CD1
END
!======================================================================
RESI ILE
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280 END
 ATOM HN   TYPE=H   CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA1 CHARge=0.000 END
GROUP
 ATOM CG2  TYPE=CA3 CHARge=0.000 END
GROUP
 ATOM CG1  TYPE=CA2 CHARge=0.000 END
GROUP
 ATOM CD   TYPE=CA3 CHARge=0.000 END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END
BOND CB CA     BOND CG1 CB     BOND CG2 CB      BOND CD CG1
BOND N HN      BOND N CA      BOND O C         BOND C CA
IMPRoper N    CA   C    CB  !tetrahedral CA
IMPRoper CA   CB   CG1  CG2 !tetrahedral CB
DIHE N    CA   CB   CG1   DIHE CA   CB   CG1  CD
END
!======================================================================
RESI ASP
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280 END
 ATOM HN   TYPE=H   CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2 CHARge=0.000  END
GROUP
 ATOM CG   TYPE=CR  CHARge=0.270  END
 ATOM OD2  TYPE=OC  CHARge=-0.635 END
 ATOM OD1  TYPE=OC  CHARge=-0.635 END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END
BOND CB CA     BOND CG CB    BOND OD1 CG     BOND OD2 CG
BOND N HN      BOND N CA     BOND O C        BOND C CA
!
DIHE N    CA   CB   CG       DIHE CA   CB   CG   OD1
IMPR OD1  CG   CB   OD2
!
IMPRoper N    CA   C    CB  !tetrahedral CA
END
!======================================================================
RESI GLU
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280 END
 ATOM HN   TYPE=H   CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2 CHARge=0.000 END
GROUP
 ATOM CG   TYPE=CA2 CHARge=0.000 END
GROUP
 ATOM CD   TYPE=CR  CHARge=0.270  END
 ATOM OE2  TYPE=OC  CHARge=-0.635 END
 ATOM OE1  TYPE=OC  CHARge=-0.635 END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END
BOND CB CA      BOND CG CB     BOND CD CG     BOND OE1 CD     BOND OE2 CD
BOND N HN       BOND N CA      BOND O C       BOND C CA
!
DIHE N   CA   CB   CG    DIHE CA   CB   CG   CD     DIHE CB   CG   CD   OE1
IMPRoper N    CA   C    CB  !tetrahedral CA
IMPR OE1   CD   CG  OE2
END
!======================================================================

RESI ASN
GROUP
 ATOM N    TYPE=NZ   CHARge=-0.280 END
 ATOM HN   TYPE=H    CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1  CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2  CHARge=0.000 END
GROUP
 ATOM CG   TYPE=CR   CHARge=0.380  END
 ATOM OD   TYPE=OZ   CHARge=-0.380 END
GROUP
 ATOM ND  TYPE=NZNQ  CHARge=-0.830 END
 ATOM HND2 TYPE=H    CHARge=0.415  EXCL=( CB OD ) END
 ATOM HND1 TYPE=H    CHARge=0.415  EXCL=( CB OD ) END
GROUP
 ATOM C    TYPE=CR   CHARge=0.380  END
 ATOM O    TYPE=OZ   CHARge=-0.380 END
BOND CB CA    BOND CG CB    BOND OD  CG      BOND ND  CG
BOND N HN     BOND N CA     BOND O C         BOND C CA
BOND ND  HND1   BOND ND  HND2
DIHE N    CA   CB   CG        DIHE CA   CB   CG   ND
!
DIHE CB   CG   ND   HND1      DIHE CB   CG   ND   HND2 
DIHE OD   CG   ND   HND1      DIHE OD   CG   ND   HND2
!
IMPR N    CA   C    CB  !tetrahedral CA
IMPR ND   CG   CB   OD
IMPR HND1 ND   CG   HND2
END
!======================================================================
RESI GLN
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280 END
 ATOM HN   TYPE=H   CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2 CHARge=0.000 END
GROUP
 ATOM CG   TYPE=CA2 CHARge=0.000 END
GROUP
 ATOM CD   TYPE=CR  CHARge=0.380  END
 ATOM OE   TYPE=OZ  CHARge=-0.380 END
GROUP
 ATOM NE   TYPE=NZNQ  CHARge=-0.830 END
 ATOM HNE2 TYPE=H   CHARge=0.415  EXCL=( CG OE ) END
 ATOM HNE1 TYPE=H   CHARge=0.415  EXCL=( CG OE ) END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END
BOND CB CA    BOND CG CB     BOND CD CG    BOND OE  CD     BOND NE  CD
BOND N HN     BOND N CA      BOND O C      BOND C CA
BOND NE  HNE1  BOND NE  HNE2
!
DIHE N    CA   CB   CG     DIHE CA   CB   CG   CD      DIHE CB   CG   CD   NE
!
DIHE CG   CD   NE   HNE1      DIHE CG   CD   NE   HNE2 
DIHE OE   CD   NE   HNE1      DIHE OE   CD   NE   HNE2
!
IMPRoper N   CA   C    CB  !tetrahedral CA
IMPR NE   CD   CG   OE
IMPR HNE1 NE   CD   HNE2
END
!=====================================================================
RESI LYS
GROUP
 ATOM N    TYPE=NZ   CHARge=-0.280 END
 ATOM HN   TYPE=H    CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1  CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2  CHARge=0.000 END
GROUP
 ATOM CG   TYPE=CA2  CHARge=0.000 END
GROUP
 ATOM CD   TYPE=CA2  CHARge=0.000 END
GROUP
 ATOM CE   TYPE=CA2P CHARge=0.127  END
 ATOM NZ   TYPE=NCK  CHARge=0.129 END
 ATOM HZ2  TYPE=H    CHARge=0.248  END
 ATOM HZ3  TYPE=H    CHARge=0.248  END
 ATOM HZ1  TYPE=H    CHARge=0.248  END
GROUP
 ATOM C    TYPE=CR   CHARge=0.380  END
 ATOM O    TYPE=OZ   CHARge=-0.380 END
BOND CB CA    BOND CG CB    BOND CD CG    BOND CE CD    BOND NZ   CE
BOND N HN     BOND N CA     BOND O C      BOND C CA
BOND NZ HZ1   BOND NZ HZ2   BOND NZ HZ3
IMPRoper N    CA   C    CB  !tetrahedral CA
DIHE N    CA   CB   CG     DIHE CA   CB   CG   CD   DIHE CB   CG   CD   CE
DIHE CG   CD   CE   NZ     DIHE CD   CE   NZ   HZ1
END
!======================================================================
RESI ARG           ! Arginine with idealized charges on the guanido
GROUP
 ATOM N    TYPE=NZ   CHARge=-0.280 END
 ATOM HN   TYPE=H    CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1  CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2  CHARge=0.000 END
GROUP
 ATOM CG   TYPE=CA2  CHARge=0.000 END
GROUP
 ATOM CD   TYPE=CA2P CHARge=0.090 END
GROUP
 ATOM NE   TYPE=NZ  CHARge=-0.110 END
 ATOM HE   TYPE=H    CHARge=0.240  END
 ATOM CZ   TYPE=CRNP CHARge=0.340  END
 ATOM NH2  TYPE=NCR  CHARge=-0.260 EXCL=( HE CD ) END
 ATOM HH22 TYPE=HC  CHARge=0.240  EXCL=( NE HE CD ) END
 ATOM HH21 TYPE=HC  CHARge=0.240  EXCL=( NE HE CD ) END
 ATOM NH1  TYPE=NCR  CHARge=-0.260 EXCL=( HH22 HH21 HE CD ) END
 ATOM HH12 TYPE=HC  CHARge=0.240  EXCL=( NH2 HH22 HH21 NE HE CD ) END
 ATOM HH11 TYPE=HC  CHARge=0.240  EXCL=( NH2 HH22 HH21 NE HE CD ) END
GROUP
 ATOM C    TYPE=CR   CHARge=0.380  END
 ATOM O    TYPE=OZ   CHARge=-0.380 END
BOND CB CA     BOND CG CB     BOND CD CG    BOND NE CD     BOND CZ NE
BOND NH1 CZ    BOND NH2 CZ    BOND N HN     BOND N CA
BOND O C       BOND C CA   
BOND NE HE     BOND NH1 HH11  BOND NH1 HH12 BOND NH2 HH21  BOND NH2 HH22
DIHE N    CA   CB   CG     DIHE CA   CB   CG   CD     
DIHE CB   CG   CD   NE     DIHE CG   CD   NE   CZ     
DIHE CD   NE   CZ   NH1    DIHE CD   NE   CZ   NH2
DIHE HE   NE   CZ   NH1    DIHE HE   NE   CZ   NH2
DIHE NE   CZ   NH1  HH11   DIHE NE   CZ   NH1  HH12
DIHE NE   CZ   NH2  HH21   DIHE NE   CZ   NH2  HH22
DIHE NH1  CZ   NH2  HH21   DIHE NH1  CZ   NH2  HH22
DIHE NH2  CZ   NH1  HH11   DIHE NH2  CZ   NH1  HH12
IMPROPER CZ   NE   CD   HE
IMPROPER NH1  CZ   NE   NH2
IMPROPER HH11 NH1  CZ   HH12
IMPROPER HH21 NH2  CZ   HH22

IMPRoper N    CA   C    CB  !tetrahedral CA
END
!======================================================================
RESI HIS     ! Histidine with idealized charges on the ring
GROUP
 ATOM N    TYPE=NZ   CHARge=-0.280 END
 ATOM HN   TYPE=H    CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1  CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2  CHARge=0.000 END
group
 ATOM CG   TYPE=CRNP CHARge=0.000  END
GROUP
 ATOM CD2  TYPE=CM1  CHARge=0.000  END
GROUP
 ATOM ND1  TYPE=NZ   CHARge=0.128 END
 ATOM HD1  TYPE=H    CHARge=0.192  EXCL=( CB ) END
 ATOM CE1  TYPE=CM1P CHARge=0.259  EXCL=( CB ) END
 ATOM NE2  TYPE=NR   CHARge=-0.579 EXCL=( CB HD1 ) END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END
!
BOND CB  CA   BOND CG CB    BOND ND1 CG     BOND CD2 CG    BOND CE1 ND1
BOND CD2 NE2  BOND N HN     BOND N CA       BOND O C
BOND C CA     BOND NE2 CE1  BOND ND1 HD1
!
DIHE N    CA   CB   CG   DIHE CA   CB   CG   ND1
DIHE NE2  CD2  CG   CB   DIHE NE2  CD2  CG   ND1   
DIHE CB   CG   ND1  HD1  DIHE CB   CG   ND1  CE1
DIHE CD2  CG   ND1  HD1  DIHE CD2  CG   ND1  CE1
DIHE CE1  NE2  CD2  CG
DIHE CG   ND1  CE1  NE2  DIHE HD1  ND1  CE1  NE2
DIHE ND1  CE1  NE2  CD2
!
IMPR ND1 CG   CB  CD2  
IMPR CE1 ND1  CG  HD1  
!
IMPRoper N    CA   C    CB  !tetrahedral CA
END
!======================================================================
RESI SER
GROUP
 ATOM N    TYPE=NZ   CHARge=-0.280 END
 ATOM HN   TYPE=H    CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1  CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2P  CHARge=0.150  END
 ATOM OG   TYPE=OZH  CHARge=-0.548 END
 ATOM HO   TYPE=H    CHARge=0.398  END
GROUP
 ATOM C    TYPE=CR   CHARge=0.380  END
 ATOM O    TYPE=OZ   CHARge=-0.380 END
BOND CB CA      BOND OG CB        BOND N HN     BOND N CA
BOND O C        BOND C CA 
BOND OG HO 
DIHE N    CA   CB   OG         DIHE CA   CB   OG   HO 
IMPRoper N   CA   C   CB   !tetrahedral CA
END
!======================================================================

RESI THR
GROUP
 ATOM N    TYPE=NZ   CHARge=-0.280 END
 ATOM HN   TYPE=H    CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1  CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA1P CHARge=0.150  END
 ATOM CG   TYPE=CA3  CHARge=0.000  END
 ATOM OG   TYPE=OZH  CHARge=-0.548 END
 ATOM HO   TYPE=H    CHARge=0.398  END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END
BOND CB CA    BOND OG  CB    BOND CG  CB     BOND N HN
BOND N CA     BOND O C       BOND C CA 
BOND OG  HO
!
DIHE N    CA   CB   OG      DIHE CA   CB   OG   HO 
!
IMPRoper N    CA   C    CB  !tetrahedral CA
IMPRoper CA   CB   OG   CG  ! chiral center in side chain
END
!=====================================================================
RESI CYS
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280 END
 ATOM HN   TYPE=H   CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2 CHARge=0.000 END
GROUP
 ATOM SG   TYPE=SG  CHARge=-0.064 END 
 ATOM HG1  TYPE=H   CHARge=0.064  END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END
BOND CB CA        BOND SG CB     BOND N HN    BOND N CA
BOND O C          BOND C CA
BOND SG HG1
DIHE N    CA   CB   SG        DIHE CA   CB   SG   HG1
IMPRoper N   CA   C    CB  !tetrahedral CA
END
!==========================================================================
RESI MET
GROUP
 ATOM N    TYPE=NZ   CHARge=-0.280 END
 ATOM HN   TYPE=H    CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1  CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2  CHARge=-0.000 END ! hb2 and hb3 in sigmac
GROUP
 ATOM CG   TYPE=CA2  CHARge=0.000 END
GROUP
 ATOM SD   TYPE=SGNP CHARge=0.000 END
GROUP
 ATOM CE   TYPE=CA3  CHARge=0.000 END
GROUP
 ATOM C    TYPE=CR   CHARge=0.380  END
 ATOM O    TYPE=OZ   CHARge=-0.380 END
BOND CB CA    BOND CG CB     BOND SD CG    BOND CE SD
BOND N HN     BOND N CA      BOND O C      BOND C CA
IMPRoper N    CA   C    CB  !tetrahedral CA
DIHE N    CA   CB   CG    DIHE CA   CB   CG   SD      DIHE CB   CG   SD   CE
END
!============================================================================
RESI PHE
GROUP
 ATOM N    TYPE=NZ      CHARge=-0.280 END
 ATOM HN   TYPE=H       CHARge=0.280 END
GROUP
 ATOM CA   TYPE=CA1     CHARge=0.000 END
GROUP
 ATOM CB   TYPE=CA2     CHARge=0.000 EXCL=( CE1 CE2 CZ ) END
GROUP
 ATOM CG   TYPE=CRNP    CHARge=0.000 EXCL=( CZ )  END
GROUP
 ATOM CD2  TYPE=CM1     CHARge=0.000 EXCL=( CE1 ) END
GROUP
 ATOM CE2  TYPE=CM1     CHARge=0.000 END
GROUP
 ATOM CD1  TYPE=CM1     CHARge=0.000 EXCL=( CE2 ) END
GROUP
 ATOM CE1  TYPE=CM1     CHARge=0.000 END
GROUP
 ATOM CZ   TYPE=CM1     CHARge=0.000 END
GROUP
 ATOM C    TYPE=CR      CHARge=0.380 END
 ATOM O    TYPE=OZ      CHARge=-0.380 END
BOND CB CA     BOND CG CB    BOND CD1 CG    BOND CD2 CG    BOND CE1 CD1
BOND CE2 CD2   BOND CZ CE1   BOND CZ CE2    BOND N HN
BOND N CA      BOND O C      BOND C CA
!
DIHED  cb  cg  cd2 ce2 DIHED  cd1 cg  cd2 ce2 
DIHED  cb  cg  cd1 ce1 DIHED  cd2 cg  cd1 ce1 
DIHED  cg  cd1 ce1 cz  DIHED  cd1 ce1 cz  ce2 
DIHED  ce1 cz  ce2 cd2 DIHED  cz  ce2 cd2 cg
DIHED  n   ca  cb  cg  DIHED  ca  cb  cg  cd1
!
IMPR  cd1 cg  cb  cd2 
!
IMPRoper N    CA   C    CB  !tetrahedral CA
END
!=====================================================================
RESI TYR
GROUP
 ATOM N    TYPE=NZ     CHARge=-0.280 END
 ATOM HN   TYPE=H      CHARge=0.280 END
GROUP
 ATOM CA   TYPE=CA1    CHARge=0.000 END
GROUP
 ATOM CB   TYPE=CA2    CHARge=0.000 EXCL=( CE1 CE2 CZ OH) END
GROUP
 ATOM CG   TYPE=CRNP   CHARge=0.000 EXCL=( CZ OH ) END
GROUP
 ATOM CD2  TYPE=CM1    CHARge=0.000 EXCL=( CE1 OH ) END
GROUP
 ATOM CE2  TYPE=CM1    CHARge=0.000 END
GROUP
 ATOM CD1  TYPE=CM1    CHARge=0.000 EXCL=( CE2 OH ) END
GROUP
 ATOM CE1  TYPE=CM1    CHARge=0.000 END
GROUP
 ATOM CZ   TYPE=CR     CHARge=0.150 END
 ATOM OH   TYPE=OZH    CHARge=-0.548 END
 ATOM HO   TYPE=H      CHARge=0.398 END
GROUP
 ATOM C    TYPE=CR     CHARge=0.380 END
 ATOM O    TYPE=OZ     CHARge=-0.380 END
BOND CB CA    BOND CG CB   BOND CD1 CG    BOND CD2 CG    BOND CE1 CD1
BOND CE2 CD2  BOND CZ CE1  BOND CZ CE2    BOND OH CZ
BOND N HN     BOND N CA    BOND O C       BOND C CA
BOND OH HO
!
DIHED  cb  cg  cd2 ce2 DIHED  cd1 cg  cd2 ce2 
DIHED  cb  cg  cd1 ce1 DIHED  cd2 cg  cd1 ce1 
DIHED  cg  cd1 ce1 cz  DIHED  cd1 ce1 cz  oh
DIHED  cd1 ce1 cz  ce2 DIHED  ce1 cz  ce2 cd2
DIHED  oh  cz  ce2 cd2 DIHED  cz  ce2 cd2 cg
DIHED  n   ca  cb  cg  DIHED  ca  cb  cg  cd1 DIHED  ce1 cz  oh  ho
!
IMPR  cd1  cg  cb  cd2 
IMPR  ce2  cz  ce1 oh  
!
IMPRoper N    CA   C    CB  !tetrahedral CA
END
!=====================================================================
RESI TRP
GROUP
 ATOM N    TYPE=NZ  CHARge=-0.280 END
 ATOM HN   TYPE=H   CHARge=0.280  END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.000  END
GROUP
 ATOM CB   TYPE=CA2 CHARge=0.000  END
GROUP
 ATOM CG   TYPE=CRNP  CHARge=-0.181 END
 ATOM CD2  TYPE=CRNP  CHARge=-0.037 END
 ATOM CD1  TYPE=CM1P CHARge=0.120  END
 ATOM CE3  TYPE=CM1P CHARge=-0.026 EXCL=( CB CD1 ) END
 ATOM CE2  TYPE=CRNP   CHARge=0.110  EXCL=( CB ) END
 ATOM CZ3  TYPE=CM1P CHARge=-0.039 EXCL=( CE2 CB CG CD1 )END
 ATOM NE1  TYPE=NZ   CHARge=-0.075 EXCL=( CB CE3 CZ3 ) END
 ATOM CZ2  TYPE=CM1P CHARge=-0.029 EXCL=( CB CG CD1 CE3 ) END
 ATOM HE1  TYPE=H    CHARge=0.188  EXCL=( CB CG CD2 CE3 CZ3 CZ2 ) END
 ATOM CH2  TYPE=CM1P CHARge=-0.031 EXCL=( CB CG CD1 NE1 HE1 CD2 )END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END
BOND CB CA     BOND CG CB    BOND CD1 CG    BOND CD2 CG    BOND NE1 CD1
BOND CE2 CD2   BOND CZ2 CE2  BOND CZ3 CE3   BOND CH2 CZ2
BOND N HN      BOND N CA     BOND O C       BOND C CA
BOND CZ3 CH2   BOND CD2 CE3  BOND NE1 CE2   BOND NE1 HE1

DIHED  cb  cg  cd2 ce3  
DIHED  cd1 cg  cd2 ce3  
DIHED  cb  cg  cd2 ce2  DIHED  cd1 cg  cd2 ce2  DIHED  cg  cd2 ce3 cz3 
DIHED  ce2 cd2 ce3 cz3  
DIHED  cg  cd2 ce2 ne1  DIHED  ce3 cd2 ce2 ne1  DIHED  cd2 ce2 ne1 he1 
DIHED  cz2 ce2 ne1 he1  DIHED  cg  cd2 ce2 cz2  DIHED  ce3 cd2 ce2 cz2 
DIHED  cz2 ce2 ne1 cd1  
DIHED  ce2 ne1 cd1 cg   DIHED  ne1 cd1 cg  cb  
DIHED  ne1 cd1 cg  cd2  DIHED  cd2 ce2 cz2 ch2  DIHED  ne1 ce2 cz2 ch2 
DIHED  ce2 cz2 ch2 cz3 
DIHED  cz2 ch2 cz3 ce3  
DIHED  ch2 cz3 ce3 cd2  DIHED  ca  cb  cg  cd1  
DIHED  n   ca  cb  cg   DIHED  he1 ne1 cd1 cg 
DIHED  cd2 ce2 ne1 cd1
!
IMPR  cd1  cg  cb  cd2  IMPR  ce2  cd2 cg  ce3
IMPR  cz2  ce2 cd2 ne1  IMPR  cd1  ne1 ce2 he1
!
IMPRoper N    CA   C    CB  !tetrahedral CA
END
!----------------------------------------------------------------------

RESI PRO
GROUP
 ATOM N    TYPE=NZNP CHARge=0.0 END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.0  END
GROUP
 ATOM CB   TYPE=CA2 CHARge=0.0 END
GROUP
 ATOM CG   TYPE=CA2 CHARge=0.0 END
GROUP
 ATOM CD   TYPE=CA2 CHARge=0.0  END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END

BOND CB CA     BOND CG CB     BOND CD CG
BOND N  CA     BOND O C       BOND C CA      BOND N CD
!
DIHED  ca  cb  cg  cd
DIHED  cb  cg  cd  n  
DIHED  n   ca  cb  cg 
!
IMPRoper N    CA   C    CB  !tetrahedral CA
END
!======================================================================

RESI CPRO
GROUP
 ATOM N    TYPE=NZNP CHARge=0.0 END
GROUP
 ATOM CD   TYPE=CA2 CHARge=0.0  END
GROUP
 ATOM CG   TYPE=CA2 CHARge=0.0 END
GROUP
 ATOM CA   TYPE=CA1 CHARge=0.0  END
GROUP
 ATOM CB   TYPE=CA2 CHARge=0.0 END
GROUP
 ATOM C    TYPE=CR  CHARge=0.380  END
 ATOM O    TYPE=OZ  CHARge=-0.380 END

BOND CB CA     BOND CG CB     BOND CD CG
BOND N  CA     BOND O C       BOND C CA      BOND N CD
!
DIHED  ca  cb  cg  cd
DIHED  cb  cg  cd  n  
DIHED  n   ca  cb  cg 
!
IMPRoper N    CA   C    CB  !tetrahedral CA
END
!======================================================================

PRESidue PEPT { PEPTide bond link, for all
          amino acids ...*(-)     (+)*...
                          \ PEPT /

             except the  *(-) - (+)PRO link        }  

 MODIFY atom +CA EXCL ( -CA  -O ) end 
 MODIFY atom +HN EXCL ( -CA  -O ) end 

 ADD BOND +N -C

 ADD ANGLE -CA -C +N
 ADD ANGLE -O  -C +N
 ADD ANGLE -C  +N +CA
 ADD ANGLE -C  +N +HN

 ADD DIHEdral  -C +N +CA +C
 ADD DIHEdral  -N -CA -C +N
 ADD DIHEdral  -CA -C +N +CA
 ADD DIHEdral  -CA -C +N +HN
 ADD DIHEdral  -O  -C +N +CA
 ADD DIHEdral  -O  -C +N +HN

 ADD IMPRoper  +N -C -CA -O  {planar -C}
 ADD IMPRoper  +CA +N -C +HN  {planar +N}

END {PEPT}
!----------------------------------------------------------------------
PRESidue PEPP  { for  ...*(-) - (+)PRO  link
               same as PEPT except replacement H by CD
               and improper +N +CA +CD -C              }

 MODIFY atom +CA EXCL ( -CA  -O ) end 
 MODIFY atom +CD EXCL ( -CA  -O ) end 

 ADD BOND -C +N

 ADD ANGLE -CA -C +N
 ADD ANGLE -O  -C +N
 ADD ANGLE -C  +N +CA
 ADD ANGLE -C  +N +CD

 ADD DIHEdral  -C +N +CD +CG    !!! ADDED
 ADD DIHEdral  -C +N +CA +C
 ADD DIHEdral  -N -CA -C +N
 ADD DIHEdral  -CA -C +N +CA
 ADD DIHEdral  -CA -C +N +CD  
 ADD DIHEdral  -O  -C +N +CA  
 ADD DIHEdral  -O  -C +N +CD

 ADD IMPRoper  +N  -C  -CA -O   {planar -C}
 ADD IMPRoper  +CA +N  -C  +CD  

END {PEPP}

!------------------------------------------------------------------
! SPC WATER
autogenerate angles=false end
RESI H2O
GROUP
 ATOM OW   TYPE=OW  CHARGE=-0.82  END
 ATOM H1   TYPE=H    CHARGE=0.41   END
 ATOM H2   TYPE=H    CHARGE=0.41   END
BOND OW  H1        BOND OW  H2    BOND  H1   H2
END
! 
!------------------------------------------------------------------
!
autogenerate angles=true end
PRESidue DISU       { disulfide bridge  ...CYS      CYS...
                                              \DISU/            }
  DELETE ATOM 1HG1 END
  DELETE ATOM 2HG1 END
  MODIfy ATOM 1SG  TYPE=SGNP CHARge=0.00  END
  MODIfy ATOM 2SG  TYPE=SGNP CHARge=0.00  END

 ADD BOND 1SG 2SG

 ADD ANGLe  1CB 1SG 2SG
 ADD ANGLe  1SG 2SG 2CB

 ADD DIHEdral   2SG 1SG 1CB 1CA
 ADD DIHEdral   2CB 2SG 1SG 1CB
 ADD DIHEdral   2CA 2CB 2SG 1SG


END {DISU}
!------------------------------------------------------------------------
PRESidue NTER             { can be patched ( as NTER - * ... )
                            to any amino acid except PRO        }
 GROUP
  ADD    ATOM +HA1  TYPE=H    CHARge=0.248  END
  MODIfy ATOM +N    TYPE=NCK  CHARge=0.129  END
  DELETE ATOM +HN                           END
  ADD    ATOM +HA2  TYPE=H    CHARge=0.248  END
  ADD    ATOM +HA3  TYPE=H    CHARge=0.248  END
  MODIfy ATOM +CA   TYPE=CA1P CHARge=0.127  END

 ADD BOND +HA1 +N
 ADD BOND +HA2 +N
 ADD BOND +HA3 +N

 ADD ANGLe +HA1  +N    +HA2
 ADD ANGLe +HA2  +N    +HA3
 ADD ANGLe +HA2  +N    +CA
 ADD ANGLe +HA1  +N    +HA3
 ADD ANGLe +HA1  +N    +CA
 ADD ANGLe +HA3  +N    +CA

 ADD DIHEdral +HA1  +N    +CA   +C

END {NTER}
!------------------------------------------------------------------------
PRESidue NTGLY             { can be patched ( as NTER - * ... )
                            to amino acid gly        }
 GROUP
  ADD    ATOM +HA1  TYPE=H    CHARge=0.248  END
  MODIfy ATOM +N    TYPE=NCK  CHARge=0.129  END
  DELETE ATOM +HN                           END
  ADD    ATOM +HA2  TYPE=H    CHARge=0.248  END
  ADD    ATOM +HA3  TYPE=H    CHARge=0.248  END
  MODIfy ATOM +CA   TYPE=CA2P CHARge=0.127  END

 ADD BOND +HA1 +N
 ADD BOND +HA2 +N
 ADD BOND +HA3 +N

 ADD ANGLe +HA1  +N    +HA2
 ADD ANGLe +HA2  +N    +HA3
 ADD ANGLe +HA2  +N    +CA
 ADD ANGLe +HA1  +N    +HA3
 ADD ANGLe +HA1  +N    +CA
 ADD ANGLe +HA3  +N    +CA

 ADD DIHEdral +HA1  +N    +CA   +C

END {NTgly}
!------------------------------------------------------------------------
PRESidue PROP                { this is the N-terminal for PROlines
                                PROP - PRO or CPRO -...                      }
  GROUp
   ADD    ATOM +HA1  TYPE=H     CHARge=0.248   END
   MODIfy ATOM +N    TYPE=NCR   CHARge=0.129   END
   ADD    ATOM +HA2  TYPE=H     CHARge=0.248   END
   MODIfy ATOM +CD   TYPE=CA2P  CHARge=0.248   END
   MODIfy ATOM +CG              CHARge=0.000   END
   MODIfy ATOM +CA   TYPE=CA1P  CHARge=0.127   END
 
  ADD BOND +HA1  +N
  ADD BOND +HA2  +N
 
  ADD ANGLe +HA1  +N    +HA2
  ADD ANGLe +HA2  +N    +CA
  ADD ANGLe +HA1  +N    +CD
  ADD ANGLe +HA1  +N    +CA
  ADD ANGLe +CD   +N    +HA2
 
  ADD DIHEdral +HA1  +N    +CA   +C
  ADD DIHEdral +HA1  +N    +CD   +CG
  ADD IMPRoper +CD   +HA1  +N    +CA
  
!  ADD DONOr +HA1  +N
!  ADD DONOr +HA2  +N
 
END {PROP}

!------------------------------------------------------------------

PRESidue NH2             { can be patched ( as NH2 - * ... )
                            to any amino acid except PRO        }
 GROUP
  ADD    ATOM +HA1  TYPE=H    CHARge= 0.415  END
  MODIfy ATOM +N    TYPE=NZNQ CHARge=-0.830  END
  ADD    ATOM +HA2  TYPE=H    CHARge= 0.415  END
  DELETE ATOM +HN                            END

 ADD BOND +HA1 +N
 ADD BOND +HA2 +N

 ADD ANGLe +HA1  +N    +HA2
 ADD ANGLe +HA1  +N    +CA
 ADD ANGLe +HA2  +N    +CA

 ADD DIHEdral +HA1  +N    +CA   +C

 ADD IMPROper +CA   +N    +HA1  +HA2

END {NH2}

!------------------------------------------------------------------------

PRESidue NH2P             { can be patched ( as NH2P - * ... )
                            to amino acid PRO/CPRO        }
 GROUP
  ADD    ATOM +HA1  TYPE=H    CHARge= 0.415  END
  MODIfy ATOM +N    TYPE=NZNQ CHARge=-0.415  END

 ADD BOND +HA1 +N

 ADD ANGLe +HA1  +N    +CA
 ADD ANGLe +HA1  +N    +CD

 ADD DIHEdral +HA1  +N    +CA   +C
 ADD DIHEdral +HA1  +N    +CD   +CG

 ADD IMPROper +CA   +N    +HA1  +CD

END {NH2P}

!------------------------------------------------------------------------
 
PRESidue CTER                { C-terminal for all amino acids
                                          ... * - CTER          }
GROUp
  MODIfy ATOM -C            CHARge=0.270   END
  ADD    ATOM -O2  TYPE=OC  CHARge=-0.635  END
  ADD    ATOM -O1  TYPE=OC  CHARge=-0.635  END
  DELETE ATOM -O                           END

 ADD BOND -C    -O1
 ADD BOND -C    -O2

 ADD ANGLe -CA   -C   -O1
 ADD ANGLe -CA   -C   -O2
 ADD ANGLe -O1  -C   -O2

 ADD DIHEdral -N    -CA    -C   -O1

 ADD IMPRoper -O1 -C -CA -O2 

END {CTER}


PRESidue COOH                { C-terminal for all amino acids
                                          ... * - CTOH          }
GROUp
  MODIfy ATOM -C            CHARge=0.530   END
  MODIfy ATOM -O   TYPE=OZ  CHARge=-0.380  END
  ADD    ATOM -OHC TYPE=OZH CHARge=-0.550  END
  ADD    ATOM -HOC TYPE=H   CHARge=0.400   END

 ADD BOND -C     -OHC
 ADD BOND -OHC   -HOC

 ADD ANGLe -CA   -C    -OHC
 ADD ANGLe -O    -C    -OHC
 ADD ANGLe -C    -OHC  -HOC

 ADD DIHEdral -N    -CA    -C    -OHC
 ADD DIHEdral -CA   -C     -OHC  -HOC

 ADD IMPRoper -OHC -C -CA -O 

END {COOH}

!-------------------------------------------------------------------
PRESidue CTN                { C-terminal for all amino acids
                                            ... * - CTN CONH2 at end         }
  GROUp
   MODIfy ATOM -C             CHARge= 0.38  END
   MODIFY ATOM -O             CHARge=-0.38  END
  GROUP
   ADD    ATOM  -NT   TYPE=NZNQ CHARge=-0.830 END
   ADD    ATOM  -H1   TYPE=H    CHARGE= 0.415 END
   ADD    ATOM  -H2   TYPE=H    CHARGE= 0.415 END
      
  ADD BOND -C    -NT
  ADD BOND -NT    -H1
  ADD BOND -NT    -H2
      
  ADD ANGLe -CA   -C    -NT
  ADD ANGLe -O    -C    -NT
  ADD ANGLe -CA   -C    -O
  ADD ANGLe -C    -NT   -H1
  ADD ANGLe -C    -NT   -H2 
  ADD ANGLe -H1   -NT   -H2
      
  ADD  DIHE -N    -CA   -C    -NT
 
  ADD  DIHE -CA   -C    -NT   -H1     
  ADD  DIHE -CA   -C    -NT   -H2 
  ADD  DIHE -O    -C    -NT   -H1
  ADD  DIHE -O    -C    -NT   -H2
 
  ADD  IMPR -CA   -C    -NT   -O 
  ADD  IMPR -C    -NT   -H1   -H2
      
 END {CTN}
 
!----------------------------------------------------------------------
!++++++++++++++++++++++++++++++
!======================================================================

PRESidue PEPMAM { PEPTide bond link, from all
          amino acids ...* (-)     (+) mam ... to MAM
                          \ PEPT /
}

 MODIFY atom +CA EXCL ( -CA  -O ) end 
 MODIFY atom +HN EXCL ( -CA  -O ) end 

 ADD BOND +N -C

 ADD ANGLE -CA -C +N
 ADD ANGLE -O  -C +N
 ADD ANGLE -C  +N +CA
 ADD ANGLE -C  +N +HN

 ADD DIHEdral  -N -CA -C +N
 ADD DIHEdral  -CA -C +N +CA
 ADD DIHEdral  -CA -C +N +HN
 ADD DIHEdral  -O  -C +N +CA
 ADD DIHEdral  -O  -C +N +HN

 ADD IMPRoper  +N  -C -CA -O  {planar -C}
 ADD IMPRoper  +CA +N -C  +HN  {planar +N}

END {PEPMAM}
!======================================================================

PRESidue ACEPEP { PEPTide bond link, from ACE to all
          amino acids ...ace (-)     (+)*...
                          \ PEPT /

             except the  ace (-) - (+)PRO link        }  

 MODIFY atom +CA EXCL ( -CA  -O ) end 
 MODIFY atom +HN EXCL ( -CA  -O ) end 

 ADD BOND +N -C

 ADD ANGLE -CA -C +N
 ADD ANGLE -O  -C +N
 ADD ANGLE -C  +N +CA
 ADD ANGLE -C  +N +HN

 ADD DIHEdral  -C +N +CA +C
 ADD DIHEdral  -CA -C +N +CA
 ADD DIHEdral  -CA -C +N +HN
 ADD DIHEdral  -O  -C +N +CA
 ADD DIHEdral  -O  -C +N +HN

 ADD IMPRoper  +N  -C  -CA -O  {planar -C}
 ADD IMPRoper  +CA +N  -C  +HN  {planar +N}

END {ACEPEP}
!----------------------------------------------------------------------
PRESidue ACPRO  { for  ...ACE(-) - (+)PRO  link
               same as PEPP, but with ACE }

 MODIFY atom +CA EXCL ( -CA  -O ) end 
 MODIFY atom +CD EXCL ( -CA  -O ) end 

 ADD BOND -C +N

 ADD ANGLE -CA -C +N
 ADD ANGLE -O  -C +N
 ADD ANGLE -C  +N +CA
 ADD ANGLE -C  +N +CD

 ADD DIHEdral  -C  +N +CD +CG
 ADD DIHEdral  -C  +N +CA +C
 ADD DIHEdral  -CA -C +N  +CA
 ADD DIHEdral  -CA -C +N +CD 
 ADD DIHEdral  -O  -C +N  +CA
 ADD DIHEdral  -O  -C +N +CD
 
 ADD IMPRoper  +N  -C  -CA -O  { planar -C<}
 ADD IMPRoper  +CA +N  -C  +CD { planar -N<}

END {ACPRO}

!------------------------------------------------------------------
