# 11_FPGA_GENERATION

## Entrées

## Trames et registres

### Trame (Entrante)

Trame des information à transmettre au bloc generation.

Octet	|Nom|	Valeur	|Description
------|--------|---------|---------
1	|Nb_Octets|	0x6	|Nbre Octet Trame
2	|ID_Sys|	0x2|	FPGA Gen
3	|ID_Cmd|	0x1| ou 0x2	Gen SDI ou DVI
4	|Mire|	8 bits|	Type de Mire
5<br>6	|Res1<br> Res2|	16 bits|	Type de Résolution

### Registres

Type de Mire|	Valeur
------------|--------
BarreCode|	0x0
ContourBlanc|	0x1
GreenRed|	0x2
HorizontalBandMire|	0x3
HorizontalShadesGray|	0x4
PatchWork|	0x5
RectShadesGray|	0x6
SwitchBlackWhite|	0x7
VerticalBandMire|	0x8
VerticalShadesGray|	0x9

Résolution|	Valeur à recevoir
----------|-----------------
1024_768_100|	X"0110"
1152_864_75|	X"0116"
1152_864_85|	X"0118"
1280_1024_60|	X"011A"
1280_1024_75|	X"011C"
1400_1050_60|	X"0120"
1400_1050_75|	X"0123"
1440_900_60|	X"0125"
1440_900_75|	X"0126"
1600_1024_60|	X"0129"
1600_1024_70|	X"012B"
1680_1050_60|	X"012D"
1024_768_F160|	X"0210"
1152_864_F160|	X"0216"
1280_1024_F160|	X"021C"
1400_1050_F160|	X"0220"
1440_900_F160|	X"0226"
1600_1024_F160|	X"022B"
1680_1050_F160|	X"022D"
640_480_F120|	X"0307"
800_600_F120|	X"030A"
1024_768_F120|	X"0310"
1152_864_F120|	X"0316"
1280_1024_F120|	X"031C"
1400_1050_F120|	X"0320"
1440_900_F120|	X"0326" 
1600_1024_F120|	X"032B"
1680_1050_F120|	X"032D"


	
