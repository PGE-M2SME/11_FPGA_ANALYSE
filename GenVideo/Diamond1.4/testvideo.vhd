----------------------------------------------------------
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;
 ----------------------------------------------------------
 ENTITY testvideo IS
 GENERIC (
 Ha: INTEGER := 96; --Hpulse
 Hb: INTEGER := 144; --Hpulse+HBP
 Hc: INTEGER := 784; --Hpulse+HBP+Hactive
 Hd: INTEGER := 800; --Hpulse+HBP+Hactive+HFP
 Va: INTEGER := 2; --Vpulse
 Vb: INTEGER := 35; --Vpulse+VBP
 Vc: INTEGER := 515; --Vpulse+VBP+Vactive
 Vd: INTEGER := 525); --Vpulse+VBP+Vactive+VFP
  
 PORT (
 pixel_clk: IN STD_LOGIC; 
 --red_switch, green_switch, blue_switch: IN STD_LOGIC;
 S_Hsync, S_Vsync, S_dena  : out STD_LOGIC;
 ColoresRGB: OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
 );
 END testvideo;
 ----------------------------------------------------------
 ARCHITECTURE testvideo OF testvideo IS
 SIGNAL Hactive, Vactive, dena: STD_LOGIC;
 SIGNAL  Hsync, Vsync : STD_LOGIC;
 BEGIN
 -------------------------------------------------------
 --Part 1: CONTROL GENERATOR
 -------------------------------------------------------
 --Horizontal signals generation:
 PROCESS (pixel_clk)
 VARIABLE Hcount: INTEGER RANGE 0 TO Hd;
 BEGIN
 IF (pixel_clk'EVENT AND pixel_clk='1') THEN
 Hcount := Hcount + 1;
 IF (Hcount=Ha) THEN
 Hsync <= '1';
 ELSIF (Hcount=Hb) THEN
 Hactive <= '1';
 ELSIF (Hcount=Hc) THEN
 Hactive <= '0';
 ELSIF (Hcount=Hd) THEN
 Hsync <= '0';
 Hcount := 0;
 END IF;
 END IF;
 
 
  END PROCESS;
 --Vertical signals generation:
 PROCESS (Hsync)
 VARIABLE Vcount: INTEGER RANGE 0 TO Vd;
 BEGIN
 IF (Hsync'EVENT AND Hsync='0') THEN
 Vcount := Vcount + 1;
 IF (Vcount=Va) THEN
 Vsync <= '1';
 ELSIF (Vcount=Vb) THEN
 Vactive <= '1';
 ELSIF (Vcount=Vc) THEN
 Vactive <= '0';
 ELSIF (Vcount=Vd) THEN
 Vsync <= '0';
 Vcount := 0;
 END IF;
 END IF;
 END PROCESS;
 
 S_Hsync <= Hsync;
 S_Vsync <= Vsync;
 
 ---Display enable generation:
 dena <= Hactive AND Vactive;
 S_dena <= dena;
 -------------------------------------------------------
 --Part 2: IMAGE GENERATOR
 -------------------------------------------------------
 PROCESS (Hsync, Vsync, Vactive, dena)
 VARIABLE line_counter: INTEGER RANGE 0 TO Vc;
 BEGIN
 IF (Vsync='0') THEN
 line_counter := 0;
 ELSIF (Hsync'EVENT AND Hsync='1') THEN
 IF (Vactive='1') THEN
 line_counter := line_counter + 1;
 END IF;
 END IF;
 IF (dena='1') THEN
 IF (line_counter=1) THEN
 ColoresRGB <= X"FF0000";
 --R <= (OTHERS => '1');
 --G <= (OTHERS => '0');
 --B <= (OTHERS => '0');
 ELSIF (line_counter>1 AND line_counter<=3) THEN
  ColoresRGB <= X"00FF00";
 --R <= (OTHERS => '0');
 --G <= (OTHERS => '1');
 --B <= (OTHERS => '0');
 ELSIF (line_counter>3 AND line_counter<=6) THEN
 ColoresRGB <= X"0000FF";
 --R <= (OTHERS => '0');
 --G <= (OTHERS => '0');
 --B <= (OTHERS => '1');
 ELSE
 ColoresRGB <= X"FFFFFF";
 --R <= (OTHERS => '1');
 --G <= (OTHERS => '1');
 --B <= (OTHERS => '1');
 END IF;
 ELSE
 ColoresRGB <= X"000000";
 --R <= (OTHERS => '0');
 --G <= (OTHERS => '0');
 --B <= (OTHERS => '0');
 END IF;
 END PROCESS;
 END testvideo;
  ----------------------------------------------------------