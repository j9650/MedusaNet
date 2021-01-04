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
MASS     NS    14.00700 ! nitrogen in ring -N<
MASS     NZ    14.00700 ! peptide nitrogen
MASS     NR    14.00700 ! nitrogen in aromatic ring with no hydrogens
MASS     NZNP  14.00700 ! peptide nitrogen
MASS     NZNQ  14.00700 ! nitrogen for asn and glu
MASS     OC    15.99900 ! charged oxygen
MASS     OCC   15.99900 ! oxygen linked to two carbon c-o-c
MASS     OCP   15.99900 ! oxygen linked to carbon and phospate c-o-p
MASS     OZ    15.99900 ! carbonyl and charged oxygen
MASS     OW    15.99900 ! water oxygen
MASS     OZH   15.99900 ! serine
MASS     P     30.97400 ! phospate
MASS     SG    32.06000 ! sulfur
MASS     SGNP  32.06000 ! sulfur S-S bond and met
!===========small molecule tyes==============
MASS     _H    	   1.0008 
MASS     _C        12.01100
MASS     _CR       12.01100
MASS     _CH1E     13.01900
MASS     _CH2E     14.02700
MASS     _CH3E     15.03500
MASS     _CR1E     13.01900
MASS     _OC       15.99900	! carboxyl oxygen
MASS     _O	   15.99900	! carbonyl oxygen
MASS     _OH1	   15.99900	! hydroxyl oxygen
MASS     _OPO	   15.99900	! phosphorous oxygen
MASS     _ONO	   15.99900	! 
MASS     _ON	   15.99900	| 
MASS     _ONH	   15.99900
MASS     _OS	   15.99900
MASS     _OCC	   15.99900
MASS     _OCP	   15.99900
MASS     _OCN	   15.99900
MASS     _NC	   14.00700
MASS     _NC2	   14.00700
MASS     _NH2	   14.00700
MASS     _NH3	   14.00700
MASS     _NNH2	   14.00700
MASS     _NS  	   14.00700
MASS     _NH1	   14.00700
MASS     _NR	   14.00700
MASS     _NCCH2	   14.00700
MASS     _NCN	   14.00700
MASS     _NCNH	   14.00700
MASS     _NNN	   14.00700
MASS     _NXO	   14.00700
MASS     _NXSO	   14.00700
MASS     _NXPO	   14.00700
MASS     _N	   14.00700
MASS     _NOOO	   14.00700
MASS     _NCCCH	   14.00700
MASS     _NXX-     14.00700
MASS     _NXX-H    14.00700
MASS     _NXXSO    14.00700
MASS     _NXXPO    14.00700
MASS     _NXXXX	   14.00700
MASS     _SC	   32.06000
MASS     _SH1E	   32.06000
MASS     _S	   32.06000
MASS     _SOXX	   32.06000
MASS	 _SXXX     32.06000
MASS     _SXXXX	   32.06000
MASS     _PXXXX	   30.97000
MASS     _FX	   19.00000
MASS     _ClX	   35.45300
MASS     _BrX	   79.90400
MASS     _IX	   126.9040
MASS     _Cu       63.55000 !Cu2+
MASS     _Zn       65.40000 !Zn2+
MASS     _Eh       1.0008
MASS     _CGLIP    48.00000 !Coarse grained Lipid GAS
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

!=====================================
!NEXT are RNA residues
!Charge are taken from CHARMM22 (toprna10r_22)
!new types are needed
! OCC:   C-O-C
! OCP:   C-O-P
! NS :   Nitrogen in ring -N<
! FOR RNA, the initial coordiate(IC) is given 
!=====================================
RNA ADE
GROUP
 ATOM P     TYPE=P   CHARge=1.20   IC=(40.880   1.127  47.065) END
 ATOM O1P   TYPE=OC  CHARge=-0.40  IC=(42.360   1.124  46.933) END
 ATOM O2P   TYPE=OC  CHARge=-0.40  IC=(40.142   2.426  47.087) END
GROUP                                  			      
 ATOM C1*   TYPE=CA1  CHARge=0.20  IC=(38.152  -1.879  43.701) END
GROUP                                  			      
 ATOM C2*   TYPE=CA1  CHARge=0.15  IC=(39.040  -1.513  42.515) END
 ATOM O2*   TYPE=OZH  CHARge=-0.40 IC=(39.482  -2.728  41.931) END
 ATOM H2*   TYPE=H    CHARge=0.25  IC=(40.046  -2.535  41.178) END
GROUP                                  			      
 ATOM C3*   TYPE=CA1  CHARge=0.00  IC=(40.151  -0.757  43.230) END
 ATOM O3*   TYPE=OCP  CHARge=-0.36 IC=(41.341  -0.692  42.454) END
 ATOM C4*   TYPE=CA1  CHARge=0.10  IC=(40.366  -1.667  44.425) END
 ATOM O4*   TYPE=OCC  CHARge=-0.30 IC=(39.018  -2.069  44.794) END
 ATOM C5*   TYPE=CA2  CHARge=0.00  IC=(41.008  -1.008  45.602) END
 ATOM O5*   TYPE=OCP  CHARge=-0.36 IC=(40.317   0.181  45.921) END
GROUP                                  			      
 ATOM N1    TYPE=NR   CHARge=-0.28 IC=(33.626   0.261  42.610) END
 ATOM C2    TYPE=CM1P CHARge=0.26  IC=(34.295  -0.775  42.070) END
 ATOM N3    TYPE=NR   CHARge=-0.26 IC=(35.490  -1.273  42.400) END
 ATOM C4    TYPE=CRNP CHARge=0.19  IC=(36.023  -0.576  43.420) END
 ATOM C5    TYPE=CRNP CHARge=0.02  IC=(35.470   0.514  44.063) END
 ATOM C6    TYPE=CRNP CHARge=0.28  IC=(34.199   0.942  43.622) END
GROUP                                  			      
 ATOM N6    TYPE=NCR  CHARge=-0.42 IC=(33.539   1.981  44.145) END
 ATOM H61   TYPE=HC   CHARge=0.21  IC=(33.948   2.509  44.903) END
 ATOM H62   TYPE=HC   CHARge=0.21  IC=(32.632   2.238  43.782) END
GROUP                                  			      
 ATOM N7    TYPE=NR   CHARge=-0.25 IC=(36.318   0.974  45.059) END
 ATOM C8    TYPE=CM1P CHARge=0.23  IC=(37.343   0.158  45.004) END
 ATOM N9    TYPE=NS   CHARge=-0.19 IC=(37.225  -0.806  44.039) END
!                                      						      
BOND P   O1P    BOND P   O2P    BOND P   O5*
BOND O5* C5*    BOND C5* C4*    BOND C4* O4*
BOND C4* C3*    BOND C3* O3*    BOND C3* C2*
BOND C2* O2*    BOND C2* C1*    BOND C1* O4*
BOND C1* N9     BOND N9  C8     BOND N9  C4
BOND C8  N7     BOND N7  C5     BOND C5  C4
BOND C4  N3     BOND N3  C2     BOND C2  N1
BOND N1  C6     BOND C6  N6     BOND C6  C5
BOND N6  H61    BOND N6  H62    BOND O2* H2*
!                                      
DIHED P    O5*  C5*  C4*
DIHED O5*  C5*  C4*  O4*
DIHED O5*  C5*  C4*  C3*
DIHED O4*  C1*  C2*  C3* ! O-C-C-C, twofold term
DIHED C1*  C2*  C3*  C4*
DIHED C2*  C3*  C4*  O4* ! O-C-C-C, twofold term
DIHED C3*  C4*  O4*  C1*
DIHED C4*  O4*  C1*  C2*
DIHED C5*  C4*  C3*  O3*
DIHED O4*  C4*  C3*  O3*
DIHED C3*  C2*  O2*  H2*
! AND THE SPECIAL GAUCHE TERMS
DIHED O4*  C1*  C2*  O2*
DIHED C1*  C2*  C3*  O3*
DIHED C4*  C3*  C2*  O2*
DIHED O3*  C3*  C2*  O2*
DIHED O4*  C1*  N9   C4 
DIHED C5   C6   N6   H61       
! Dihedrals to keep the two purine rings parallel:
DIHED C8   C4   C5   N1        
DIHED C8   C5   C4   C2
DIHED N3   C4   C5   N7        
DIHED C6   C5   C4   N9
! The ring-spanning impropers have been left out.
IMPRoper C5*  O4*  C3*  C4*       
IMPRoper O3*  C2*  C4*  C3*       
IMPRoper N9   C2*  O4*  C1*
IMPRoper C1*  C4   C8   N9
IMPRoper N9   C4   C5   N7        
IMPRoper C4   C5   N7   C8        
IMPRoper C5   N7   C8   N9
IMPRoper N7   C8   N9   C4        
IMPRoper C8   N9   C4   C5        
IMPRoper N6   N1   C5   C6
IMPRoper C4   N3   C2   N1        
IMPRoper N3   C2   N1   C6
IMPRoper C2   N1   C6   C5        
IMPRoper N1   C6   C5   C4        
IMPRoper C6   C5   C4   N3
IMPRoper C5   C4   N3   C2
IMPRoper C2*  C3*  C1*  O2*
IMPRoper H62  C6   H61  N6
END
!============================================================================

RNA GUA
GROUP
 ATOM P     TYPE=P    CHARge=1.20   IC=(37.411   3.100  51.730) END
 ATOM O1P   TYPE=OC   CHARge=-0.40  IC=(38.580   3.948  52.071) END
 ATOM O2P   TYPE=OC   CHARge=-0.40  IC=(36.184   3.727  51.183) END
GROUP                                   		            
 ATOM C1*   TYPE=CA1  CHARge=0.20   IC=(37.553  -1.506  49.212) END
GROUP                                   		            
 ATOM C2*   TYPE=CA1  CHARge=0.15   IC=(38.710  -1.253  48.252) END
 ATOM O2*   TYPE=OZH  CHARge=-0.40  IC=(39.677  -2.262  48.392) END
 ATOM H2*   TYPE=H    CHARge=0.25   IC=(40.307  -2.204  47.670) END
GROUP                                   		            
 ATOM C3*   TYPE=CA1  CHARge=0.00   IC=(39.190   0.102  48.743) END
 ATOM O3*   TYPE=OCP  CHARge=-0.36  IC=(40.533   0.317  48.397)END
 ATOM C4*   TYPE=CA1  CHARge=0.10   IC=(39.090  -0.069  50.239) END
 ATOM O4*   TYPE=OCC  CHARge=-0.30  IC=(37.829  -0.767  50.395) END
 ATOM C5*   TYPE=CA2  CHARge=0.00   IC=(39.079   1.216  51.022) END
 ATOM O5*   TYPE=OCP  CHARge=-0.36  IC=(37.898   1.946  50.744) END
GROUP                                   		            
 ATOM N1    TYPE=NZ    CHARge=-0.26 IC=(34.068  -2.107  45.597) END
 ATOM H1    TYPE=H     CHARge=0.25  IC=(33.492  -2.390  44.817) END
GROUP                                   		            
 ATOM C2    TYPE=CRNP  CHARge=0.50  IC=(35.227  -2.820  45.820) END
GROUP                                   		            
 ATOM N2    TYPE=NCR   CHARge=-0.42 IC=(35.493  -3.820  44.973) END
 ATOM H21   TYPE=HC    CHARge=0.21  IC=(34.857  -4.023  44.215) END
 ATOM H22   TYPE=HC    CHARge=0.21  IC=(36.330  -4.373  45.091) END
GROUP                                   		            
 ATOM N3    TYPE=NR    CHARge=-0.50 IC=(36.066  -2.563  46.806) END
 ATOM C4    TYPE=CRNP  CHARge=0.19  IC=(35.653  -1.517  47.555) END
 ATOM C5    TYPE=CRNP  CHARge=0.02  IC=(34.522  -0.738  47.409) END
 ATOM C6    TYPE=CR    CHARge=0.30  IC=(33.627  -1.027  46.361) END
 ATOM O6    TYPE=OZ    CHARge=-0.30 IC=(32.557  -0.452  46.079) END
 ATOM N7    TYPE=NR    CHARge=-0.25 IC=(34.474   0.250  48.376) END
 ATOM C8    TYPE=CM1P  CHARge=0.23  IC=(35.551   0.055  49.088) END
 ATOM N9    TYPE=NS    CHARge=-0.19 IC=(36.305  -1.006  48.646) END
!
BOND P    O1P       BOND P    O2P        BOND P    O5*      
BOND O5*  C5*       BOND C5*  C4*        BOND C4*  O4*       
BOND C4*  C3*       BOND O4*  C1*        BOND C1*  N9        
BOND C1*  C2*       BOND N9   C4         BOND N9   C8        
BOND C4   N3        BOND C4   C5         BOND N3   C2        
BOND C2   N2        BOND C2   N1         BOND N1   C6        
BOND C6   O6        BOND C6   C5         BOND C5   N7        
BOND N7   C8        BOND C2*  C3*        BOND C3*  O3*       
BOND C2*  O2*       BOND N2   H21        BOND N2   H22       
BOND N1   H1        BOND O2*  H2*
!
DIHED  P   O5*  C5*  C4*       
DIHED O5*  C5*  C4*  O4*       
DIHED O5*  C5*  C4*  C3*
DIHED O4*  C1*  C2*  C3* ! O-C-C-C, twofold term
DIHED C1*  C2*  C3*  C4* 
DIHED C2*  C3*  C4*  O4* ! O-C-C-C, twofold term
DIHED C3*  C4*  O4*  C1*
DIHED C4*  O4*  C1*  C2*
DIHED C5*  C4*  C3*  O3*
DIHED O4*  C4*  C3*  O3*
DIHED C3*  C2*  O2*  H2*
! AND THE SPECIAL GAUCHE TERMS
DIHED O4*  C1*  C2*  O2*
DIHED C1*  C2*  C3*  O3*
DIHED C4*  C3*  C2*  O2*
DIHED O3*  C3*  C2*  O2*
DIHED O4*  C1*  N9   C4 
DIHED N3   C2   N2   H21       
! Dihedrals to keep the two purine rings parallel:
DIHED C8   C4   C5   N1        
DIHED C8   C5   C4   C2
DIHED N3   C4   C5   N7        
DIHED C6   C5   C4   N9
! The ring-spanning impropers have been left out.
IMPRoper C5*  O4*  C3*  C4*       
IMPRoper O3*  C2*  C4*  C3*       
IMPRoper N9   C2*  O4*  C1*
IMPRoper C1*  C4   C8   N9
IMPRoper N9   C4   C5   N7        
IMPRoper C4   C5   N7   C8        
IMPRoper C5   N7   C8   N9
IMPRoper N7   C8   N9   C4        
IMPRoper C8   N9   C4   C5        
IMPRoper N2   N3   N1   C2
IMPRoper O6   N1   C5   C6        
IMPRoper C4   N3   C2   N1
IMPRoper N3   C2   N1   C6        
IMPRoper C2   N1   C6   C5        
IMPRoper N1   C6   C5   C4
IMPRoper C6   C5   C4   N3        
IMPRoper C5   C4   N3   C2        
IMPRoper C2*  C3*  C1*  O2*
IMPRoper H1   C2   C6   N1
IMPRoper H22  H21  C2   N2  
END
!============================================================================

RNA CYT
GROUP
 ATOM P     TYPE=P    CHARge=1.20  IC=(27.310   5.219  54.943) END
 ATOM O1P   TYPE=OC   CHARge=-0.40 IC=(27.494   6.323  55.918) END
 ATOM O2P   TYPE=OC   CHARge=-0.40 IC=(28.120   5.198  53.699) END
GROUP                                  			       
 ATOM C1*   TYPE=CA1  CHARge=0.20  IC=(29.966   0.854  55.775) END
GROUP                                  			       
 ATOM C2*   TYPE=CA1  CHARge=0.15  IC=(31.117   1.830  55.524) END
 ATOM O2*   TYPE=OZH  CHARge=-0.40 IC=(32.117   1.667  56.508) END
 ATOM H2*   TYPE=H    CHARge=0.25  IC=(32.918   2.116  56.228) END
GROUP                                  			       
 ATOM C3*   TYPE=CA1  CHARge=0.00  IC=(30.400   3.168  55.628) END
 ATOM O3*   TYPE=OCP  CHARge=-0.36 IC=(31.336   4.208  55.900) END
 ATOM C4*   TYPE=CA1  CHARge=0.10  IC=(29.455   2.900  56.793) END
 ATOM O4*   TYPE=OCC  CHARge=-0.30 IC=(28.988   1.551  56.529) END
 ATOM C5*   TYPE=CA2  CHARge=0.00  IC=(28.253   3.801  56.925) END
 ATOM O5*   TYPE=OCP  CHARge=-0.36 IC=(27.530   3.839  55.702) END
GROUP                                  			       
 ATOM N1    TYPE=NS   CHARge=-0.19 IC=(29.361   0.409  54.514) END
 ATOM C2    TYPE=CR   CHARge=0.30  IC=(29.899  -0.712  53.875) END
 ATOM O2    TYPE=OZ   CHARge=-0.30 IC=(30.841  -1.319  54.415) END
 ATOM N3    TYPE=NR   CHARge=-0.28 IC=(29.382  -1.107  52.691) END
 ATOM C4    TYPE=CRNP CHARge=0.28  IC=(28.365  -0.434  52.152) END
GROUP                                  			       
 ATOM N4    TYPE=NCR  CHARge=-0.42 IC=(27.894  -0.858  50.979) END
 ATOM H41   TYPE=HC   CHARge=0.21  IC=(27.125  -0.374  50.539) END
 ATOM H42   TYPE=HC   CHARge=0.21  IC=(28.307  -1.663  50.530) END
GROUP                                  			       
 ATOM C5    TYPE=CM1  CHARge=0.00  IC=(27.788   0.700  52.788) END
 ATOM C6    TYPE=CM1  CHARge=0.19  IC=(28.309   1.082  53.960) END
!
BOND P    O1P       BOND P    O2P       BOND P    O5*
BOND O5*  C5*       BOND C5*  C4*       BOND C4*  O4*       
BOND C4*  C3*       BOND O4*  C1*       BOND C1*  N1        
BOND C1*  C2*       BOND N1   C2        BOND N1   C6        
BOND C2   O2        BOND C2   N3        BOND N3   C4        
BOND C4   N4        BOND C4   C5        BOND C5   C6        
BOND C2*  C3*       BOND C3*  O3*       BOND C2*  O2*
BOND N4   H41       BOND N4   H42       BOND O2*  H2*
!
DIHED  P   O5*  C5*  C4*       
DIHED O5*  C5*  C4*  O4*       
DIHED O5*  C5*  C4*  C3*
DIHED O4*  C1*  C2*  C3* ! O-C-C-C, twofold term
DIHED C1*  C2*  C3*  C4*
DIHED C2*  C3*  C4*  O4* ! O-C-C-C, twofold term
DIHED C3*  C4*  O4*  C1*
DIHED C4*  O4*  C1*  C2*
DIHED C5*  C4*  C3*  O3*
DIHED O4*  C4*  C3*  O3*
DIHED C3*  C2*  O2*  H2*
! AND THE SPECIAL GAUCHE TERMS
DIHED O4*  C1*  C2*  O2*
DIHED C1*  C2*  C3*  O3*
DIHED C4*  C3*  C2*  O2*
DIHED O3*  C3*  C2*  O2*
DIHED O4*  C1*  N1   C2 
DIHED C5   C4   N4   H41 
!
IMPRoper C5*  O4*  C3*  C4*       
IMPRoper O3*  C2*  C4*  C3*       
IMPRoper N1   C2*  O4*  C1*
IMPRoper C1*  C2   C6   N1        
IMPRoper O2   N1   N3   C2        
IMPRoper N4   N3   C5   C4
IMPRoper N1   C2   N3   C4        
IMPRoper C2   N3   C4   C5        
IMPRoper N3   C4   C5   C6
IMPRoper C4   C5   C6   N1        
IMPRoper C5   C6   N1   C2        
IMPRoper C6   N1   C2   N3
IMPRoper C2*  C3*  C1*  O2*
IMPRoper H42  C4   H41  N4  
END
!===========================================================================

RNA URI
GROUP
 ATOM P     TYPE=P    CHARge=1.20  IC=(41.668   0.630  41.603) END
 ATOM O1P   TYPE=OC   CHARge=-0.40 IC=(42.947   0.349  40.909) END
 ATOM O2P   TYPE=OC   CHARge=-0.40 IC=(41.542   1.833  42.464) END
GROUP                                  			       
 ATOM C1*   TYPE=CA1  CHARge=0.20  IC=(36.977   0.264  39.205) END
GROUP                                  			       
 ATOM C2*   TYPE=CA1  CHARge=0.15  IC=(37.393   0.833  37.850) END
 ATOM O2*   TYPE=OZH  CHARge=-0.40 IC=(37.111  -0.118  36.848) END
 ATOM H2*   TYPE=H    CHARge=0.25  IC=(37.204   0.290  35.984) END
GROUP                                  			       
 ATOM C3*   TYPE=CA1  CHARge=0.00  IC=(38.890   0.976  38.049) END
 ATOM O3*   TYPE=OCP  CHARge=-0.36 IC=(39.579   0.984  36.819) END
 ATOM C4*   TYPE=CA1  CHARge=0.10  IC=(39.197  -0.309  38.772) END
 ATOM O4*   TYPE=OCC  CHARge=-0.30 IC=(38.112  -0.397  39.734) END
 ATOM C5*   TYPE=CA2  CHARge=0.00  IC=(40.523  -0.302  39.468) END
 ATOM O5*   TYPE=OCP  CHARge=-0.36 IC=(40.529   0.668  40.493) END
GROUP                                  			       
 ATOM N1    TYPE=NS CHARge=-0.19   IC=(36.546   1.299  40.149) END
 ATOM C2    TYPE=CR CHARge=0.35    IC=(35.350   1.926  39.869) END
 ATOM O2    TYPE=OZ CHARge=-0.35   IC=(34.694   1.664  38.888) END
GROUP                                  			       
 ATOM N3    TYPE=NZ CHARge=-0.26   IC=(34.968   2.880  40.764) END
 ATOM H3    TYPE=H  CHARge=0.26    IC=(34.087   3.338  40.580) END
GROUP                                  			       
 ATOM C4    TYPE=CR CHARge=0.30    IC=(35.643   3.289  41.886) END
 ATOM O4    TYPE=OZ CHARge=-0.30   IC=(35.170   4.192  42.573) END
 ATOM C5    TYPE=CM1 CHARge=0.00   IC=(36.885   2.601  42.124) END
 ATOM C6    TYPE=CM1 CHARge=0.19   IC=(37.283   1.645  41.260) END
!                                         		      
BOND P    O1P       BOND P    O2P      BOND P    O5*
BOND O5*  C5*       BOND C5*  C4*      BOND C4*  O4*       
BOND C4*  C3*       BOND O4*  C1*      BOND C1*  N1        
BOND C1*  C2*       BOND N1   C2       BOND N1   C6        
BOND C2   O2        BOND C2   N3       BOND N3   C4        
BOND C4   O4        BOND C4   C5       BOND C5   C6        
BOND C2*  C3*       BOND C3*  O3*      BOND C2*  O2*       
BOND N3   H3        BOND O2*  H2*
!                                      
DIHED  P   O5*  C5*  C4*               
DIHED O5*  C5*  C4*  O4*               
DIHED O5*  C5*  C4*  C3*
DIHED O4*  C1*  C2*  C3* ! O-C-C-C, twofold term
DIHED C1*  C2*  C3*  C4*
DIHED C2*  C3*  C4*  O4* ! O-C-C-C, twofold term
DIHED C3*  C4*  O4*  C1*
DIHED C4*  O4*  C1*  C2*
DIHED C5*  C4*  C3*  O3*
DIHED O4*  C4*  C3*  O3*
DIHED C3*  C2*  O2*  H2*
! AND THE SPECIAL GAUCHE TERMS
DIHED O4*  C1*  C2*  O2*
DIHED C1*  C2*  C3*  O3*
DIHED C4*  C3*  C2*  O2*
DIHED O3*  C3*  C2*  O2*
DIHED O4*  C1*  N1   C2
!
IMPRoper C5*  O4*  C3*  C4*       
IMPRoper O3*  C2*  C4*  C3*       
IMPRoper N1   C2*  O4*  C1*
IMPRoper C1*  C2   C6   N1        
IMPRoper O2   N1   N3   C2        
IMPRoper O4   N3   C5   C4        
IMPRoper N1   C2   N3   C4
IMPRoper C2   N3   C4   C5        
IMPRoper N3   C4   C5   C6        
IMPRoper C4   C5   C6   N1
IMPRoper C5   C6   N1   C2        
IMPRoper C6   N1   C2   N3
IMPRoper C2*  C3*  C1*  O2*
IMPRoper H3   C2   C4   N3
END
!===========================================================================


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
