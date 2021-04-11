----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
 ----------------------------------------------------------
 ENTITY mires IS

 PORT (
 Clk100:              IN STD_LOGIC;
 tH,tV:                IN std_logic_vector ( 11 downto 0 );
 NewDviFrame   :   IN STD_LOGIC; 
 ReqNewRow      : IN STD_LOGIC; 
 DviFifoRd          :   IN STD_LOGIC; 
 SRst                  : IN STD_LOGIC;
 --change                  : inout STD_LOGIC;
 --resolutionChoix : IN STD_LOGIC_vector (3 downto 0);
 choixMire 		 : in std_logic_vector (3 downto 0);
 HContador        : out std_logic_vector(11 downto 0);
 HVertical            : out std_logic_vector(11 downto 0);
 DatRGB                 :            OUT std_logic_vector(23 downto 0)
 );
 END mires;
 
 
 ARCHITECTURE mires OF mires IS
signal DatR, DatG, DatB : std_logic_vector(7 downto 0);
signal FCnt, HCnt, VCnt : std_logic_vector(11 downto 0);
signal RGB, color : std_logic_vector (23 downto 0):= X"000000";
signal countI : std_logic_vector(4 downto 0);
signal Vertical : integer range 0 to 1024;
signal intVCnt : integer range 0 to 4095;
signal i : integer range 0 to 100;

 BEGIN

--Generate DVI data

pGenMire: process (Clk100)

variable Horizontal : integer range 0 to 1280;

variable Vertical : integer range 0 to 1024;

variable intHCnt :integer range 0 to 4095;

variable intVCnt : integer range 0 to 4095;

--variable i : integer range 0 to 16 := 0;

begin


  if Clk100'event and Clk100='1' then
  
    if SRst = '1' then
      FCnt <= (others => '0');
    elsif NewDviFrame = '1' then    --NewDviFrame == dvi_nf0
      FCnt <= FCnt + '1';
    end if;
	
    if NewDviFrame = '1' then
       VCnt <= (others => '0'); -- devuelve a cero
	  --------------------------------------------------------------------- i <= 0; le hizo contar a la imagen 
       elsif ReqNewRow = '1' then 
      VCnt <= VCnt + '1';
    end if;
	
    if ReqNewRow = '1' then
      HCnt <= (others => '0');
    elsif DviFifoRd = '1' then                --senial importante que viene de DVI410TIming
      HCnt <= HCnt + '1';
    end if;
	
	--------------creacion de integers
	intHCnt := to_integer(unsigned(HCnt));
	intVCnt := to_integer(unsigned(VCnt));
	--intVCnt <= to_integer(unsigned(VCnt));
	-------------------------------------------------------------
	Horizontal := to_integer(unsigned(tH));
	Vertical :=  to_integer(unsigned(tV));
	
	------Vertical <= to_integer(unsigned(tV));
	
	--HContador <= HCnt;
	--HVertical<=VCnt;
								
								--if (change  = '1') then 
								      --change  <= '0';
										      --i <= 0;
								-----------------creacion de integers
									--intHCnt := to_integer(unsigned(HCnt));
									--intVCnt := to_integer(unsigned(VCnt));
									----intVCnt <= to_integer(unsigned(VCnt));
									---------------------------------------------------------------
									--Horizontal := to_integer(unsigned(tH));
									--Vertical :=  if (intVCnt >= (Vertical*i)/17 and  intVCnt  <  (Vertical*(i+1))/17 ) then
								--if ( i= 0) then
								--RGB <= X"FF0000";
								--elsif (i=1) then
								--RGB <= X"0000FF";
								--elsif (i=2) then
								--RGB <= X"00FF00";
								--else
								--RGB <= X"FFFFFF";
								--end if;							
						--RGB <= datR &  datG & datB;
							  
						--elsif(i <= 16) then
							   --i := i+1;
							--i <= i + 1;
							 --datR   <=    datR + X"0F";
							 --datG  <=     datG + X"0F";
							 --datB   <=    datB + X"0F";
							--elsif ( i >16) then
								--i := 0;
							--i <= 0;
							 --datR   <=      X"00";
							 --datG  <=     X"00";
							 --datB   <=     X"00";						 
							   --RGB <= (others => '0');		
							
--end if; 
									--RGB <= X"000000";
								--end if;
								
if (choixMire = X"1") then 

 if (  (intHCnt > Horizontal/17 and intHCnt <= (Horizontal*8)/17) and   ( (intVCnt > (Vertical/17) and intVCnt <= (Vertical*8)/17)    or  (  intVCnt > (Vertical*9)/17      and  intVCnt <= (Vertical*16)/17 ))  )   then
	 datR <= X"00";
	 datG <= X"00";
	 datB <= X"00";
 --RED			
 elsif ( (intHCnt > (Horizontal*9)/17 and intHCnt <= (Horizontal*16)/17 ) and ((intVCnt > (Vertical*9)/17 and intVCnt <= (Vertical*16)/17) or (intVCnt > (Vertical/17) and intVCnt <= (Vertical*8)/17)) ) then
	datR <= X"00";
	 datG <= X"00";
	 datB <= X"00";
 --GREEN		
 else
 	datR <= X"FF";
 	datG <= X"FF";
 	datB <= X"FF";
end if;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--elsif (choixMire = X"0") then
                --if (intHCnt >= (Horizontal*i)/99 and  intHCnt  <  (Horizontal*(i+1))/99 ) then
                     ----RGB <= datR &  datG & datB; 
                --elsif (i  < 99) then
                    --i <= i + 1;
                 --elsif ( i >= 99) then
                     --i <= 0;
                 --end if;
				 
                --if (i mod 2 = 0) then
                    --datR <= X"00";
                     --datG <= X"00";
                     --datB <= X"00";
                --else
                    --datR <= X"FF";
                    --datG <= X"FF";
                    --datB <= X"FF";
                --end if;
 -------------------------------------------------------------------------------------MIRE Horizontal Shades Gray----------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------				
			elsif (choixMire = X"4") then
			
			if (intHCnt  <  Horizontal/17 ) then
					datR <= X"00";
			 		datG <= X"00";
			 		datB <= X"00";
				elsif (intHCnt >= (Horizontal)/17 and  intHCnt  <  (Horizontal*2)/17 ) then
					datR <= X"0F";
			 		datG <= X"0F";
			 		datB <= X"0F";
				elsif (intHCnt >= (Horizontal*2)/17 and  intHCnt  <  (Horizontal*3)/17 ) then
					datR <= X"1E";
					datG <= X"1E";
					datB <= X"1E";
				elsif (intHCnt >= (Horizontal*3)/17 and  intHCnt  <  (Horizontal*4)/17 ) then
					datR <= X"2D";
			 		datG <= X"2D";
			 		datB <= X"2D";
				elsif (intHCnt >= (Horizontal*4)/17 and  intHCnt  <  (Horizontal*5)/17 ) then
					datR <= X"3C";
					datG <= X"3C";
					datB <= X"3C";
				elsif (intHCnt >= (Horizontal*5)/17 and  intHCnt  <  (Horizontal*6)/17 ) then
					datR <= X"4B";
			 		datG <= X"4B";
			 		datB <= X"4B";
				elsif (intHCnt >= (Horizontal*6)/17 and  intHCnt  <  (Horizontal*7)/17 ) then
					datR <= X"5A";
					datG <= X"5A";
					datB <= X"5A";
				elsif (intHCnt >= (Horizontal*7)/17 and  intHCnt  <  (Horizontal*8)/17 ) then
					datR <= X"69";
			 		datG <= X"69";
			 		datB <= X"69";
				elsif (intHCnt >= (Horizontal*8)/17 and  intHCnt  <  (Horizontal*9)/17 ) then
					datR <= X"78";
					datG <= X"78";
					datB <= X"78";
				elsif (intHCnt >= (Horizontal*9)/17 and  intHCnt  <  (Horizontal*10)/17 ) then
					datR <= X"87";
			 		datG <= X"87";
			 		datB <= X"87";
				elsif (intHCnt >= (Horizontal*10)/17 and  intHCnt  <  (Horizontal*11)/17 ) then
					datR <= X"96";
					datG <= X"96";
					datB <= X"96";
				elsif (intHCnt >= (Horizontal*11)/17 and  intHCnt  <  (Horizontal*12)/17 ) then
					datR <= X"A5";
			 		datG <= X"A5";
			 		datB <= X"A5";
				elsif (intHCnt >= (Horizontal*12)/17 and  intHCnt  <  (Horizontal*13)/17 ) then
					datR <= X"B4";
					datG <= X"B4";
					datB <= X"B4";
				elsif (intHCnt >= (Horizontal*13)/17 and  intHCnt  <  (Horizontal*14)/17 ) then
					datR <= X"C3";
			 		datG <= X"C3";
			 		datB <= X"C3";
				elsif (intHCnt >= (Horizontal*14)/17 and  intHCnt  <  (Horizontal*15)/17 ) then
					datR <= X"D2";
					datG <= X"D2";
					datB <= X"D2";
				elsif (intHCnt >= (Horizontal*15)/17 and  intHCnt  <  (Horizontal*16)/17 ) then
					datR <= X"E1";
			 		datG <= X"E1";
			 		datB <= X"E1";
				elsif (intHCnt >= (Horizontal*16)/17 and  intHCnt  <  Horizontal ) then
					datR <= X"F0";
					datG <= X"F0";
					datB <= X"F0";
				end if;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 -------------------------------------------------------------------------------------MIRE Vertical Shades Gray----------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
elsif (choixMire = X"9") then
				if (intVCnt  <  Vertical/17 ) then
					datR <= X"00";
			 		datG <= X"00";
			 		datB <= X"00";
				elsif (intVCnt >= (Vertical)/17 and  intVCnt  <  (Vertical*2)/17 ) then
					datR <= X"0F";
			 		datG <= X"0F";
			 		datB <= X"0F";
				elsif (intVCnt >= (Vertical*2)/17 and  intVCnt  <  (Vertical*3)/17 ) then
					datR <= X"1E";
					datG <= X"1E";
					datB <= X"1E";
				elsif (intVCnt >= (Vertical*3)/17 and  intVCnt  <  (Vertical*4)/17 ) then
					datR <= X"2D";
			 		datG <= X"2D";
			 		datB <= X"2D";
				elsif (intVCnt >= (Vertical*4)/17 and  intVCnt  <  (Vertical*5)/17 ) then
					datR <= X"3C";
					datG <= X"3C";
					datB <= X"3C";
				elsif (intVCnt >= (Vertical*5)/17 and  intVCnt  <  (Vertical*6)/17 ) then
					datR <= X"4B";
			 		datG <= X"4B";
			 		datB <= X"4B";
				elsif (intVCnt >= (Vertical*6)/17 and  intVCnt  <  (Vertical*7)/17 ) then
					datR <= X"5A";
					datG <= X"5A";
					datB <= X"5A";
				elsif (intVCnt >= (Vertical*7)/17 and  intVCnt  <  (Vertical*8)/17 ) then
					datR <= X"69";
			 		datG <= X"69";
			 		datB <= X"69";
				elsif (intVCnt >= (Vertical*8)/17 and  intVCnt  <  (Vertical*9)/17 ) then
					datR <= X"78";
					datG <= X"78";
					datB <= X"78";
				elsif (intVCnt >= (Vertical*9)/17 and  intVCnt  <  (Vertical*10)/17 ) then
					datR <= X"87";
			 		datG <= X"87";
			 		datB <= X"87";
				elsif (intVCnt >= (Vertical*10)/17 and  intVCnt  <  (Vertical*11)/17 ) then
					datR <= X"96";
					datG <= X"96";
					datB <= X"96";
				elsif (intVCnt >= (Vertical*11)/17 and  intVCnt  <  (Vertical*12)/17 ) then
					datR <= X"A5";
			 		datG <= X"A5";
			 		datB <= X"A5";
				elsif (intVCnt >= (Vertical*12)/17 and  intVCnt  <  (Vertical*13)/17 ) then
					datR <= X"B4";
					datG <= X"B4";
					datB <= X"B4";
				elsif (intVCnt >= (Vertical*13)/17 and  intVCnt  <  (Vertical*14)/17 ) then
					datR <= X"C3";
			 		datG <= X"C3";
			 		datB <= X"C3";
				elsif (intVCnt >= (Vertical*14)/17 and  intVCnt  <  (Vertical*15)/17 ) then
					datR <= X"D2";
					datG <= X"D2";
					datB <= X"D2";
				elsif (intVCnt >= (Vertical*15)/17 and  intVCnt  <  (Vertical*16)/17 ) then
					datR <= X"E1";
			 		datG <= X"E1";
			 		datB <= X"E1";
				elsif (intVCnt >= (Vertical*16)/17 and  intVCnt  <  Vertical ) then
					datR <= X"F0";
					datG <= X"F0";
					datB <= X"F0";
				end if;

 --------------------------------------------------------------------------------------GREEN RED-------------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
elsif (choixMire = X"2") then 

                 if ( intHCnt <= (Horizontal/2) and intVCnt <= (Vertical/2) ) then
                     datR <= X"FF";
                     datG <= X"00";
                     datB <= X"00";
                 --RED
                 elsif ( intHCnt  > (Horizontal/2) and  intVCnt <= (Vertical/2)) then
                    datR <= X"00";
                     datG <= X"FF";
                     datB <= X"00";
                 --GREEN
                 elsif ( intHCnt  <=   (Horizontal/2) and  intVCnt > (Vertical/2) ) then
                     datR <= X"00";
                     datG <= X"FF";
                     datB <= X"00";
                     --RED
                 else
                     datR <= X"FF";
                     datG <= X"00";
                     datB <= X"00";
                     --GREEN
                end if;
 -----------------------------------------------------------------------------------------------------------

 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------SWITCH BLACK WHITE----------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------			
			elsif (choixMire = X"7") then 
					
	    		if ( intHCnt <= (Horizontal/8) ) then
					datR <= X"00";
					datG <= X"00";
					datB <= X"00";
					--RGB <= (others => '0');
					--BLACK			
				elsif ( intHCnt  >= (Horizontal/8) and  intHCnt  <  (Horizontal*2)/8) then
					datR <= X"FF";
					datG <= X"FF";
					datB <= X"FF";
					--RGB <= X"FFFFFF";	
					--WHITE		
				elsif ( intHCnt  >=   (Horizontal*2)/8 and  intHCnt  <  (Horizontal*3)/8 ) then
					datR <= X"33";
					datG <= X"33";
					datB <= X"33";
					--RGB <= X"333333";	
					--DARK GREY
				elsif ( intHCnt  >=   (Horizontal*3)/8 and  intHCnt  <  (Horizontal*4)/8 ) then
					datR <= X"66";
					datG <= X"66";
					datB <= X"66";
					--RGB <= X"666666";	
					--DARK GREY + 
				elsif ( intHCnt  >=   (Horizontal*4)/8 and  intHCnt  <  (Horizontal*5)/8 ) then				
					datR <= X"00";
					datG <= X"00";
					datB <= X"00";
					--RGB <= X"000000";
					--BLACK
				elsif ( intHCnt  >=   (Horizontal*5)/8 and  intHCnt  <  (Horizontal*6)/8 ) then		
					datR <= X"FF";
					datG <= X"FF";
					datB <= X"FF";
					--RGB <= X"FFFFFF";
					--WHITE
				
				elsif ( intHCnt  >=   (Horizontal*6)/8 and  intHCnt  <  (Horizontal*7)/8 ) then	
					datR <= X"CC";
					datG <= X"CC";
					datB <= X"CC";
					--RGB <= X"CCCCCC";
					--DARK GREY ++
				elsif (intHCnt >= (Horizontal*7)/8 and intHCnt <= Horizontal) then
					datR <= X"99";
					datG <= X"99";
					datB <= X"99";
					--RGB <= X"999999";
					--Dark Grey 
				end if;

 ------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------VERTICAL BAND MIRE----------------------------------------------------------------------------------
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 			elsif (choixMire = X"8") then 
			
 				if ( intVCnt <= (Vertical)/7 ) then
	 				datR <= X"FF";
	 				datG <= X"FF";
	 				datB <= X"FF";
	 				---RGB <= (others => '1');
	 				-- Blanc/White			
 				elsif ( intVCnt  > (Vertical)/7  and  intVCnt  <  (Vertical*2)/7) then
	 				datR <= X"FF";
	 				datG <= X"FF";
	 				datB <= X"00";
	 				--RGB <= X"FFFF00";	
	 				--Jaune/Yellow		
 				elsif ( intVCnt  >=   (Vertical*2)/7 and  intVCnt  <  (Vertical*3)/7 ) then
	 				datR <= X"00";
	 				datG <= X"FF";
	 				datB <= X"FF";
	 				--	RGB <= X"00FFFF";	
	 				--	Cyan
				elsif ( intVCnt  >=   (Vertical*3)/7 and  intVCnt  <  (Vertical*4)/7 ) then
	 				datR <= X"00";
	 				datG <= X"FF";
	 				datB <= X"00";
	 				--RGB <= X"00FF00";	
	 				--	Vert/Green
			 	elsif ( intVCnt  >=   (Vertical*4)/7 and  intVCnt  <  (Vertical*5)/7 ) then				
	 				datR <= X"FF";
	 				datG <= X"00";
	 				datB <= X"FF";
	 				--RGB <= X"FF00FF";
	 				--	Magenta
		 
 				elsif ( intVCnt  >=   (Vertical*5)/7 and  intVCnt  <  (Vertical*6)/7 ) then		
	 				datR <= X"FF";
	 				datG <= X"00";
	 				datB <= X"00";
	 				--RGB <= X"FF0000";
	 				--	Rouge/Red
				elsif ( intVCnt  >=   (Vertical*6)/7 and  intVCnt  <=  Vertical) then
	 				datR <= X"00";
	 				datG <= X"00";
			 		datB <= X"FF";
	 				--RGB <= X"0000FF";
	 				------Bleu/Blue
 				end if;		


	elsif (choixMire = X"5") then 
	----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------
	-----	-----------------------------------------------------------------	-----------------------------------------------------------------HORIZONTAL BAND MIRE------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------
	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------
	       if ( intHCnt <= (Horizontal)/7 ) then
		          datR <= X"FF";
					datG <= X"FF";
					datB <= X"FF";
					---RGB <= (others => '1');
					--			Blanc/White			
			elsif ( intHCnt  > (Horizontal)/7  and  intHCnt  <  (Horizontal*2)/7) then
					datR <= X"FF";
					datG <= X"FF";
					datB <= X"00";
					--RGB <= X"FFFF00";	
				--Jaune/Yellow		
				elsif ( intHCnt  >=   (Horizontal*2)/7 and  intHCnt  <  (Horizontal*3)/7 ) then
				     datR <= X"00";
					datG <= X"FF";
					datB <= X"FF";
				--	RGB <= X"00FFFF";	
				--	Cyan
						
			     elsif ( intHCnt  >=   (Horizontal*3)/7 and  intHCnt  <  (Horizontal*4)/7 ) then
				    datR <= X"00";
					datG <= X"FF";
					datB <= X"00";
					--RGB <= X"00FF00";	
				--	Vert/Green
					
				elsif ( intHCnt  >=   (Horizontal*4)/7 and  intHCnt  <  (Horizontal*5)/7 ) then				
				    datR <= X"FF";
					datG <= X"00";
					datB <= X"FF";
				--RGB <= X"FF00FF";
				--	Magenta
					
			   elsif ( intHCnt  >=   (Horizontal*5)/7 and  intHCnt  <  (Horizontal*6)/7 ) then		
					   datR <= X"FF";
					   datG <= X"00";
				    	datB <= X"00";
					---RGB <= X"FF0000";
				--	Rouge/Red
				else
				    datR <= X"00";
					datG <= X"00";
					datB <= X"FF";
					---RGB <= X"0000FF";
					------Bleu/Blue
				end if;
				
	----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------
	-----	-----------------------------------------------------------------	---------------------------------------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------
	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------
	
		-----	--------------------------------RectShadesGray-----------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------
	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------
	
	elsif (choixMire = X"6") then 

 if ( intHCnt < Horizontal/3) then
    DatR <= VCnt(7 downto 0) + (not FCnt(7 downto 0)) + X"11";
    DatG <= VCnt(7 downto 0) + (not FCnt(7 downto 0)) + X"11";
    DatB <= VCnt(7 downto 0) + (not FCnt(7 downto 0)) + X"11";
 elsif ( intHCnt  >= Horizontal/3 and  intHCnt < (Horizontal*2)/3) then
    DatR <= VCnt(7 downto 0) + FCnt(7 downto 0) + X"77";
    DatG <= VCnt(7 downto 0) + FCnt(7 downto 0) + X"77";
    DatB <= VCnt(7 downto 0) + FCnt(7 downto 0) + X"77";
 --GREEN
 elsif ( intHCnt  >= (Horizontal*2)/3 and  intHCnt < Horizontal) then
    DatR <= VCnt(7 downto 0) + FCnt(8 downto 1) + X"CC";
    DatG <= VCnt(7 downto 0) + FCnt(8 downto 1) + X"CC";
    DatB <= VCnt(7 downto 0) + FCnt(8 downto 1) + X"CC";
--RED
end if;
	-----	-----------------------------------------------------------------	---------------------------------------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------
	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------	-----------------------------------------------------------------

				
	elsif (choixMire = X"3") then 
	--------------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------
---------------------------------------------------------------------	---------------------------------------------------------------------	---------------------------------------------------------------------	---------------------------------------------------------------------	---------------------------------------------------------------------
---------------------------------------------------------------------	---------------------------------------------------------------------	---------------------------------------------------------------------	-------------------------------------------------------------------------------	---------------------------------------------------------------------	---------------------------------------------------------------------
--------------------------ORIGINAL MODIFICADO CON NUESTRAS VARIABLES----------------------------------	---------------------------------------------------------------------	-------------------------------------------------------------------------------	---------------------------------------------------------------------	---------------------------------------------------------------------
  if (intVCnt < (Vertical)/4) then
  DatR <= HCnt(7 downto 0) + (not FCnt(7 downto 0)) + X"11";
elsif (intVCnt >= (Vertical*3)/4 and  intVCnt  <  (Vertical*4)/4 ) then
  DatR <= HCnt(7 downto 0) + FCnt(7 downto 0);
else
  DatR <= (others => '0');
end if;

if (intVCnt >= (Vertical*1)/4 and  intVCnt  <  (Vertical*2)/4 ) then
  DatG <= HCnt(7 downto 0) + FCnt(7 downto 0) + X"77";
elsif (intVCnt >= (Vertical*3)/4 and  intVCnt  <  (Vertical*4)/4 ) then
  DatG <= HCnt(7 downto 0) + FCnt(7 downto 0);
else
  DatG <= (others => '0');
end if;

if (intVCnt >= (Vertical*2)/4 and  intVCnt  <  (Vertical*3)/4 ) then
  DatB <= HCnt(7 downto 0) + FCnt(8 downto 1) + X"CC";
elsif (intVCnt >= (Vertical*3)/4 and  intVCnt  <  (Vertical*4)/4 ) then
  DatB <= HCnt(7 downto 0) + FCnt(7 downto 0);
else
  DatB <= (others => '0');
end if;
end if;
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--if (intHCnt < (Horizontal)/4) then
  --DatR <= VCnt(7 downto 0) + (not FCnt(7 downto 0)) + X"11";
--elsif (intHCnt >= (Horizontal*3)/4 and  intHCnt  <  (Horizontal*4)/4 ) then
  --DatR <= VCnt(7 downto 0) + FCnt(7 downto 0);
--else
  --DatR <= (others => '0');
--end if;
--if (intHCnt >= (Horizontal*1)/4 and  intHCnt  <  (Horizontal*2)/4 ) then
  --DatG <= VCnt(7 downto 0) + FCnt(7 downto 0) + X"77";
--elsif (intHCnt >= (Horizontal*3)/4 and  intHCnt  <  (Horizontal*4)/4 ) then
  --DatG <= VCnt(7 downto 0) + FCnt(7 downto 0);
--else
  --DatG <= (others => '0');
--end if;
--if (intHCnt >= (Horizontal*2)/4 and  intHCnt  <  (Horizontal*3)/4 ) then
  --DatB <= VCnt(7 downto 0) + FCnt(8 downto 1) + X"CC";
--elsif (intHCnt >= (Horizontal*3)/4 and  intHCnt  <  (Horizontal*4)/4 ) then
  --DatB <= VCnt(7 downto 0) + FCnt(7 downto 0);
--else
  --DatB <= (others => '0');
--end if;
--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
RGB <= DatR & DatG & DatB;
---------------------------------------------------------------------------------------------------------------------------------------------------
 end if;
end process pGenMire;

	DatRGB <= RGB;
 END mires;
 
 
 