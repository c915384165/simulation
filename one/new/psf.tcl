# FIle: bpti_example.tcl
# Requirements: topology file 
#               PDB file
# Create workind directory; remove old output files
# mkdir -p output
# rm -f output/*.*
# (1) Split input PDB file into segments
# grep -v '^HETATM' 6PTI.pdb > output/6PTI_protein.pdb
# grep 'HOH' 6PTI.pdb > output/6PTI_water.pdb
# grep 'PO4' 6PTI.pdb > output/6PTI_po4.pdb

# (2) Embed psfgen commands in this script
psfgen << ENDMOL
puts "2done"
# (3) Read topology file
topology toppar/top_4m4.inp
puts "load topology 4m4.rtf"
# (4) Build protein segment
segment 4M4 {
  pdb out/4m4.pdb 
}
puts "4 done"

# (5) Patch protein segment
# patch DISU BPTI:5 BPTI:55
# patch DISU BPTI:14 BPTI:38
# patch DISU BPTI:30 BPTI:51

# puts "5 done"
# (6) Read protein coordinates from PDB file
# pdbalias atom ILE CD1 CD     ;# formerly "alias atom ..."
coordpdb out/4m4.pdb 4M4
puts "6 done"

# (7) Build water segment
 # pdbalias residue HOH TIP3    ;# formerly "alias residue ..."
# 
 # segment SOLV {
   # auto none
   # pdb output/6PTI-water2.pdb
 # }
 # puts "6 done"
 # (8) Read water coordinaes from PDB file
 # pdbalias atom HOH O OH2      ;# formerly "alias atom ..."
 # coordpdb output/6PTI-water2.pdb SOLV

 # (9) Guess missing coordinates
guesscoord

# (10) Write structure and coordinate files
writepsf out/4m4_fi.psf
writepdb out/4m4_fi.pdb

# End of psfgen commands
ENDMOLL
