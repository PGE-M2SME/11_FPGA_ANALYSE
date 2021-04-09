----------------------------------------------------------
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;
 ----------------------------------------------------------
 ENTITY vga IS
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
 
 clk: IN STD_LOGIC; --50MHz in our board
 pixel_clk: out STD_LOGIC;
 Hsync, Vsync: out STD_LOGIC;
 DataRGB : out std_logic_vector(23 downto 0);
 dena2 : OUT STD_LOGIC);
 
 END vga;
 ----------------------------------------------------------
 ARCHITECTURE vga OF vga IS
 SIGNAL Hactive, Vactive, dena: STD_LOGIC;
 signal R, G, B : std_logic_vector(7 downto 0);
 signal s_pixel_clk : std_logic;
 signal s_Hsync, s_Vsync: STD_LOGIC;
 
 BEGIN
 -------------------------------------------------------
 --Part 1: CONTROL GENERATOR
 -------------------------------------------------------
 PROCESS (clk)
 BEGIN
 IF (clk'EVENT AND clk='1') THEN
 s_pixel_clk <= NOT s_pixel_clk;
 END IF;
 pixel_clk <= s_pixel_clk;
 END PROCESS;
 
 --Horizontal signals generation:
 PROCESS (s_pixel_clk)
 VARIABLE Hcount: INTEGER RANGE 0 TO Hd;
 BEGIN
 IF (s_pixel_clk'EVENT AND s_pixel_clk='1') THEN
 Hcount := Hcount + 1;
 IF (Hcount=Ha) THEN
 s_Hsync <= '0';                ---cambiado polaridad a 0
 
 ELSIF (Hcount=Hb) THEN
 Hactive <= '1';               
 ELSIF (Hcount=Hc) THEN
 Hactive <= '0';              
 ELSIF (Hcount=Hd) THEN
 s_Hsync <= '1';                 ---cambiado polaridad a 1
 Hcount := 0;
 END IF;
 END IF;
 Hsync <= s_Hsync;
 END PROCESS;
 
 --Vertical signals generation:
 PROCESS (s_Hsync)
 VARIABLE Vcount: INTEGER RANGE 0 TO Vd;
 BEGIN
 IF (s_Hsync'EVENT AND s_Hsync='1') THEN  ---cambiado polaridad a 1 
 Vcount := Vcount + 1;             
 IF (Vcount=Va) THEN
 s_Vsync <= '0';                        ---cambiado polaridad a 0
 ELSIF (Vcount=Vb) THEN
 Vactive <= '1';                      
 ELSIF (Vcount=Vc) THEN
 Vactive <= '0';                      
 ELSIF (Vcount=Vd) THEN
 s_Vsync <= '1';                        ----cambiadp polaridad a 1
 Vcount := 0;
 END IF;
 END IF;
 Vsync<=s_Vsync;
 END PROCESS;
 ---Display enable generation:
 dena <= Hactive AND Vactive;
 dena2 <= Hactive AND Vactive;
 
 -------------------------------------------------------
 --Part 2: IMAGE GENERATOR
 -------------------------------------------------------
 PROCESS (s_Hsync, s_Vsync, Vactive, dena)
 VARIABLE line_counter: INTEGER RANGE 0 TO Vc;
 BEGIN
 IF (s_Vsync='1') THEN                  ----cambiado polaridad a 1 
 line_counter := 0;
 ELSIF (s_Hsync'EVENT AND s_Hsync='0') THEN  ----cambiado polaridad a 0 
 IF (Vactive='1') THEN
 line_counter := line_counter + 1;
 END IF;
 END IF;
 
 IF (dena='1') THEN
 IF (line_counter=1) THEN
 R <= (OTHERS => '1');
 G <= (OTHERS => '0');
 B <= (OTHERS => '0');
 ELSIF (line_counter>1 AND line_counter<=3) THEN
 R <= (OTHERS => '0');
 G <= (OTHERS => '1');
 
 B <= (OTHERS => '0');
 ELSIF (line_counter>3 AND line_counter<=6) THEN
 R <= (OTHERS => '0');
 G <= (OTHERS => '0');
 B <= (OTHERS => '1');
 ELSE
 R <= (OTHERS => '1');
 G <= (OTHERS => '1');
 B <= (OTHERS => '1');
 END IF;
 END IF;
 DataRGB <= R & G & B;
 END PROCESS;
 END vga;