----------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
 ----------------------------------------------------------
 ENTITY simulacion IS

 PORT (
 
-----------------------------------------------CHANGEMENT AU 02/08/2021------------------------------	
		clk                           :      in std_logic;
        HLengthChoix  		:     out std_logic_vector(11 downto 0);	--	Total number of pixel clocks in a row
	  	HResChoix       	    :    out   std_logic_vector(11 downto 0); 		--	Horiztonal display width in pixels
	  	HFPChoix 	   		    :    out  std_logic_vector(7 downto 0);			--	Horiztonal front porch width in pixels
	     HSyncPulseChoix      :   out std_logic_vector(7 downto 0);		--	Horiztonal sync pulse width in pixels
	  	HBPChoix      		  	:    out std_logic_vector(8 downto 0);		--	Horiztonal back porch width in pixels
	  	HPolSyncCHoix 		:    out   std_logic;												--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	    VLengthChoix 			:    out  std_logic_vector(11 downto 0);		--	Total number of pixel clocks in column
	    VResChoix    		  	:   out  std_logic_vector(11 downto 0); 		--	Vertical display width in pixels
	  	VFPChoix 				 :  out std_logic_vector(3 downto 0);				--	Vertical front porch width in pixels
	  	VSyncPulseChoix 		:   out std_logic_vector(3 downto 0);		--	Vertical sync pulse width in pixels
	  	VBPCHoix           	 	:   out std_logic_vector(5 downto 0);	       --	Vertical back porch width in pixels
	  	VPolSyncChoix   		:   out std_logic;			--	Vertical sync pulse polarity (1 = positive, 0 = negative)
	    relojSistemaChoix 	:   out std_logic_vector (3 downto 0);           ----- pixel_clock
	    dataDispo            		: 	out std_logic;				-----------------pulse lecture
		mireID                      : 	out std_logic_vector (3 downto 0)--------------------mire choix
 );
 END simulacion;
 
 
 
  ARCHITECTURE simulacion OF simulacion IS
  
  signal Reloj1hz : std_logic;

  	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------SENALES PARA GAUTIER en 1280x1024_85hz--------@159 clk------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	signal  HLength1	 			: std_logic_vector(11 downto 0):=X"6D0";		--	Total number of pixel clocks in a row
	signal 	HRes1					: std_logic_vector(11 downto 0):=X"500"; 			--	Horiztonal display width in pixels
	signal 	HFP1						: std_logic_vector(7 downto 0):=X"60";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse1			: std_logic_vector(7 downto 0):=X"88";			--	Horiztonal sync pulse width in pixels
	signal 	HBP1						: std_logic_vector(8 downto 0):= '0'&X"E8";		--	Horiztonal back porch width in pixels
	signal 	HPolSync1				: std_logic:='1';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength1	 			: std_logic_vector(11 downto 0):=X"433";		--	Total number of pixel clocks in column
	signal  VRes1					: std_logic_vector(11 downto 0):=X"400"; 			--	Vertical display width in pixels
	signal 	VFP1						: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	signal 	VSyncPulse1			: std_logic_vector(3 downto 0):=X"3";			--	Vertical sync pulse width in pixels
	signal 	VBP1						: std_logic_vector(5 downto 0):="10"&X"F";		--	Vertical back porch width in pixels
	signal 	VPolSync1				: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------SENALES PARA GAUTIER en 640x480_60hz----------------------@25 clk----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	signal  HLength2	 	: std_logic_vector(11 downto 0):=X"320";		--	Total number of pixel clocks in a row
	signal 	HRes2		: std_logic_vector(11 downto 0):=X"280"; 			--	Horiztonal display width in pixels
	signal 	HFP2			: std_logic_vector(7 downto 0):=X"10";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse2	: std_logic_vector(7 downto 0):=X"60";			--	Horiztonal sync pulse width in pixels
	signal 	HBP2			: std_logic_vector(8 downto 0):= '0'&X"30";		--	Horiztonal back porch width in pixels
	signal 	HPolSync2	: std_logic:='0';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength2	 	: std_logic_vector(11 downto 0):=X"20D";		--	Total number of pixel clocks in column
	signal  VRes2		: std_logic_vector(11 downto 0):=X"1E0"; 			--	Vertical display width in pixels
	signal 	VFP2			: std_logic_vector(3 downto 0):=X"A";				--	Vertical front porch width in pixels
	signal 	VSyncPulse2	: std_logic_vector(3 downto 0):=X"2";			--	Vertical sync pulse width in pixels
	signal 	VBP2			: std_logic_vector(5 downto 0):="10"&X"1";		--	Vertical back porch width in pixels
	signal 	VPolSync2	: std_logic:='0';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------SENALES PARA GAUTIER en 800x600_60hz------------------------@40clk---------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	signal  HLength3	 	: std_logic_vector(11 downto 0):=X"420";		--	Total number of pixel clocks in a row
	signal 	HRes3		: std_logic_vector(11 downto 0):=X"320"; 			--	Horiztonal display width in pixels
	signal 	HFP3			: std_logic_vector(7 downto 0):=X"28";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse3	: std_logic_vector(7 downto 0):=X"80";			--	Horiztonal sync pulse width in pixels
	signal 	HBP3			: std_logic_vector(8 downto 0):= "100110000";   ---'0'&X"58";		--	Horiztonal back porch width in pixels
	signal 	HPolSync3	: std_logic:='1';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength3	 	: std_logic_vector(11 downto 0):=X"274";		--	Total number of pixel clocks in column
	signal  VRes3		: std_logic_vector(11 downto 0):=X"258"; 			--	Vertical display width in pixels
	signal 	VFP3			: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	signal 	VSyncPulse3	: std_logic_vector(3 downto 0):=X"4";			--	Vertical sync pulse width in pixels
	signal 	VBP3			: std_logic_vector(5 downto 0):="010111";--"01" & X"7";		--	Vertical back porch width in pixels
	signal 	VPolSync3	: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  -------------------------------------------------------------------------------------------
  
  -- ------------------------------------------------------------------------------------------1280x720 @60Hz ( 74.25 MHz) -- 720p		-----------						
	signal  HLength4	 	: std_logic_vector(11 downto 0):=X"670";		--	Total number of pixel clocks in a row
	signal 	HRes4		: std_logic_vector(11 downto 0):=X"500"; 			--	Horiztonal display width in pixels
	signal 	HFP4			: std_logic_vector(7 downto 0):=X"48";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse4	: std_logic_vector(7 downto 0):=X"50";			--	Horiztonal sync pulse width in pixels
	signal 	HBP4			: std_logic_vector(8 downto 0):= '0'&X"D8";		--	Horiztonal back porch width in pixels
	signal 	HPolSync4	: std_logic:='1';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength4	 	: std_logic_vector(11 downto 0):=X"2EE";		--	Total number of pixel clocks in column
	signal  VRes4		: std_logic_vector(11 downto 0):=X"2D0"; 			--	Vertical display width in pixels
	signal 	VFP4			: std_logic_vector(3 downto 0):=X"3";				--	Vertical front porch width in pixels
	signal 	VSyncPulse4	: std_logic_vector(3 downto 0):=X"5";			--	Vertical sync pulse width in pixels
	signal 	VBP4			: std_logic_vector(5 downto 0):="01"&X"6";		--	Vertical back porch width in pixels
	signal 	VPolSync4	: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- ------------------------------------------------------------------------------------------1024x768 @60Hz ( 65 MHz) -- 		-----------						
	signal  HLength5	 	: std_logic_vector(11 downto 0):=X"540";		--	Total number of pixel clocks in a row
	signal 	HRes5		: std_logic_vector(11 downto 0):=X"400"; 			--	Horiztonal display width in pixels
	signal 	HFP5			: std_logic_vector(7 downto 0):=X"18";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse5	: std_logic_vector(7 downto 0):=X"88";			--	Horiztonal sync pulse width in pixels
	signal 	HBP5			: std_logic_vector(8 downto 0):= '0'&X"A0";		--	Horiztonal back porch width in pixels
	signal 	HPolSync5	: std_logic:='0';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength5	 	: std_logic_vector(11 downto 0):=X"326";		--	Total number of pixel clocks in column
	signal  VRes5		: std_logic_vector(11 downto 0):=X"300"; 			--	Vertical display width in pixels
	signal 	VFP5			: std_logic_vector(3 downto 0):=X"3";				--	Vertical front porch width in pixels
	signal 	VSyncPulse5	: std_logic_vector(3 downto 0):=X"6";			--	Vertical sync pulse width in pixels
	signal 	VBP5			: std_logic_vector(5 downto 0):="01"&X"D";		--	Vertical back porch width in pixels
	signal 	VPolSync5	: std_logic:='0';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
     ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- ------------------------------------------------------------------------------------------768x576 @60Hz ( 34.96 MHz) -- 		-----------						
	signal  HLength6	 	: std_logic_vector(11 downto 0):=X"3D0";		--	Total number of pixel clocks in a row
	signal 	HRes6		: std_logic_vector(11 downto 0):=X"300"; 			--	Horiztonal display width in pixels
	signal 	HFP6			: std_logic_vector(7 downto 0):=X"18";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse6	: std_logic_vector(7 downto 0):=X"50";			--	Horiztonal sync pulse width in pixels
	signal 	HBP6			: std_logic_vector(8 downto 0):= '0'&X"68";		--	Horiztonal back porch width in pixels
	signal 	HPolSync6	: std_logic:='0';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength6	 	: std_logic_vector(11 downto 0):=X"255";		--	Total number of pixel clocks in column
	signal  VRes6		: std_logic_vector(11 downto 0):=X"240"; 			--	Vertical display width in pixels
	signal 	VFP6			: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	signal 	VSyncPulse6	: std_logic_vector(3 downto 0):=X"3";			--	Vertical sync pulse width in pixels
	signal 	VBP6			: std_logic_vector(5 downto 0):="01"&X"1";		--	Vertical back porch width in pixels
	signal 	VPolSync6	: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
       ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	   
    -- ------------------------------------------------------------------------------------------1152x864 @60Hz ( 81.62MHz) -- 		-----------						
	signal  HLength7	 	: std_logic_vector(11 downto 0):=X"5F0";		--	Total number of pixel clocks in a row
	signal 	HRes7		: std_logic_vector(11 downto 0):=X"480"; 			--	Horiztonal display width in pixels
	signal 	HFP7			: std_logic_vector(7 downto 0):=X"40";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse7	: std_logic_vector(7 downto 0):=X"78";			--	Horiztonal sync pulse width in pixels
	signal 	HBP7			: std_logic_vector(8 downto 0):= '0'&X"B8";		--	Horiztonal back porch width in pixels
	signal 	HPolSync7	: std_logic:='0';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength7	 	: std_logic_vector(11 downto 0):=X"37F";		--	Total number of pixel clocks in column
	signal  VRes7		: std_logic_vector(11 downto 0):=X"360"; 			--	Vertical display width in pixels
	signal 	VFP7			: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	signal 	VSyncPulse7	: std_logic_vector(3 downto 0):=X"3";			--	Vertical sync pulse width in pixels
	signal 	VBP7			: std_logic_vector(5 downto 0):="01"&X"B";		--	Vertical back porch width in pixels
	signal 	VPolSync7	: std_logic:='0';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
      -- ------------------------------------------------------------------------------------------1368x768 @60Hz ( 85.86 MHz) -- 		-----------						
	signal  HLength8	 	: std_logic_vector(11 downto 0):=X"708";		--	Total number of pixel clocks in a row
	signal 	HRes8		: std_logic_vector(11 downto 0):=X"558"; 			--	Horiztonal display width in pixels
	signal 	HFP8			: std_logic_vector(7 downto 0):=X"48";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse8	: std_logic_vector(7 downto 0):=X"90";			--	Horiztonal sync pulse width in pixels
	signal 	HBP8			: std_logic_vector(8 downto 0):= '0'&X"D8";		--	Horiztonal back porch width in pixels
	signal 	HPolSync8	: std_logic:='0';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength8	 	: std_logic_vector(11 downto 0):=X"31D";		--	Total number of pixel clocks in column
	signal  VRes8		: std_logic_vector(11 downto 0):=X"300"; 			--	Vertical display width in pixels
	signal 	VFP8			: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	signal 	VSyncPulse8	: std_logic_vector(3 downto 0):=X"3";			--	Vertical sync pulse width in pixels
	signal 	VBP8			: std_logic_vector(5 downto 0):="01"&X"7";		--	Vertical back porch width in pixels
	signal 	VPolSync8	: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  ---- ------------------------------------------------------------------------------------------1440x900 @60Hz ( 106.47 MHz) -- 		-----------						
	signal  HLength9	 	: std_logic_vector(11 downto 0):=X"770";		--	Total number of pixel clocks in a row
	signal 	HRes9		: std_logic_vector(11 downto 0):=X"5A0"; 			--	Horiztonal display width in pixels
	signal 	HFP9			: std_logic_vector(7 downto 0):=X"50";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse9	: std_logic_vector(7 downto 0):=X"98";			--	Horiztonal sync pulse width in pixels
	signal 	HBP9			: std_logic_vector(8 downto 0):= '0'&X"E8";		--	Horiztonal back porch width in pixels
	signal 	HPolSync9	: std_logic:='0';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength9	 	: std_logic_vector(11 downto 0):=X"3A4";		--	Total number of pixel clocks in column
	signal  VRes9		: std_logic_vector(11 downto 0):=X"384"; 			--	Vertical display width in pixels
	signal 	VFP9			: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	signal 	VSyncPulse9	: std_logic_vector(3 downto 0):=X"3";			--	Vertical sync pulse width in pixels
	signal 	VBP9			: std_logic_vector(5 downto 0):="01"&X"C";		--	Vertical back porch width in pixels
	signal 	VPolSync9	: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
    ---- ------------------------------------------------------------------------------------------1680x1050 @60Hz ( 147.14MHz) -- 		-----------						
	signal  HLength10	 	: std_logic_vector(11 downto 0):=X"8D0";		--	Total number of pixel clocks in a row
	signal 	HRes10		: std_logic_vector(11 downto 0):=X"690"; 			--	Horiztonal display width in pixels
	signal 	HFP10			: std_logic_vector(7 downto 0):=X"68";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse10	: std_logic_vector(7 downto 0):=X"B8";			--	Horiztonal sync pulse width in pixels
	signal 	HBP10			: std_logic_vector(8 downto 0):= '1'&X"20";		--	Horiztonal back porch width in pixels
	signal 	HPolSync10	: std_logic:='0';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength10	 	: std_logic_vector(11 downto 0):=X"43F";		--	Total number of pixel clocks in column
	signal  VRes10		: std_logic_vector(11 downto 0):=X"41A"; 			--	Vertical display width in pixels
	signal 	VFP10			: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	signal 	VSyncPulse10	: std_logic_vector(3 downto 0):=X"3";			--	Vertical sync pulse width in pixels
	signal 	VBP10			: std_logic_vector(5 downto 0):="10"&X"1";		--	Vertical back porch width in pixels
	signal 	VPolSync10	: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
    ---- ------------------------------------------------------------------------------------------1920x1080 @60Hz ( 148.5MHz) -- 		-----------						
	signal  HLength11	 	: std_logic_vector(11 downto 0):=X"898";		--	Total number of pixel clocks in a row
	signal 	HRes11		: std_logic_vector(11 downto 0):=X"780"; 			--	Horiztonal display width in pixels
	signal 	HFP11			: std_logic_vector(7 downto 0):=X"58";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse11	: std_logic_vector(7 downto 0):=X"2C";			--	Horiztonal sync pulse width in pixels
	signal 	HBP11			: std_logic_vector(8 downto 0):= '0'&X"94";		--	Horiztonal back porch width in pixels
	signal 	HPolSync11	: std_logic:='1';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength11	 	: std_logic_vector(11 downto 0):=X"465";		--	Total number of pixel clocks in column
	signal  VRes11		: std_logic_vector(11 downto 0):=X"438"; 			--	Vertical display width in pixels
	signal 	VFP11			: std_logic_vector(3 downto 0):=X"4";				--	Vertical front porch width in pixels
	signal 	VSyncPulse11	: std_logic_vector(3 downto 0):=X"5";			--	Vertical sync pulse width in pixels
	signal 	VBP11			: std_logic_vector(5 downto 0):="10"&X"4";		--	Vertical back porch width in pixels
	signal 	VPolSync11	: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  -------------------------------------------------------------------------
     ---- ------------------------------------------------------------------------------------------1600x1200 @60Hz ( 162 MHz) -- 		-----------						
	signal  HLength12	 	: std_logic_vector(11 downto 0):=X"870";		--	Total number of pixel clocks in a row
	signal 	HRes12		: std_logic_vector(11 downto 0):=X"640"; 			--	Horiztonal display width in pixels
	signal 	HFP12			: std_logic_vector(7 downto 0):=X"40";				--	Horiztonal front porch width in pixels
	signal  HSyncPulse12	: std_logic_vector(7 downto 0):=X"C0";			--	Horiztonal sync pulse width in pixels
	signal 	HBP12			: std_logic_vector(8 downto 0):= '1' & X"30";		--	Horiztonal back porch width in pixels
	signal 	HPolSync12	: std_logic:='1';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength12	 	: std_logic_vector(11 downto 0):=X"4E2";		--	Total number of pixel clocks in column
	signal  VRes12		: std_logic_vector(11 downto 0):=X"4B0"; 			--	Vertical display width in pixels
	signal 	VFP12			: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	signal 	VSyncPulse12	: std_logic_vector(3 downto 0):=X"3";			--	Vertical sync pulse width in pixels
	signal 	VBP12			: std_logic_vector(5 downto 0):="10"&X"E";		--	Vertical back porch width in pixels
	signal 	VPolSync12	: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  
   BEGIN		
										
	    --HLengthChoix 							<= X"320";		--	Total number of pixel clocks in a row
	   	--HResChoix      							<=X"280"; 		--	Horiztonal display width in pixels
	   	--HFPChoix 	   							<=X"10";			--	Horiztonal front porch width in pixels
	    --HSyncPulseChoix     					<=X"60";		--	Horiztonal sync pulse width in pixels
	   	--HBPChoix      							 <= '0'&X"30";		--	Horiztonal back porch width in pixels
	   	--HPolSyncCHoix 						<='1';												--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	    --VLengthChoix 							<=X"20D";		--	Total number of pixel clocks in column
	    --VResChoix      							<= X"1E0"; 		--	Vertical display width in pixels
	   	--VFPChoix 			 					<= X"A";				--	Vertical front porch width in pixels
	   	--VSyncPulseChoix  					<=X"2";		--	Vertical sync pulse width in pixels
	   	--VBPCHoix           						<="10"&X"1";	       --	Vertical back porch width in pixels
	   	--VPolSyncChoix   						<='1';			--	Vertical sync pulse polarity (1 = positive, 0 = negative)
	     --relojSistemaChoix  					<= X"3";				
		-- mireID    		<= X"5";
		 
		 
		 
---------------------------------------------------------------------------------------
---------------------HORLOGE DE 1HZ-----------------------------------------
  PROCESS (clk)
 variable sumatoria : integer range 0 to 50000000;
 BEGIN
 IF (clk'EVENT AND clk='1') THEN
 	
		if(sumatoria < 50000000) then
		sumatoria := sumatoria + 1;	
		else 
		sumatoria := 0;
		Reloj1hz <= NOT Reloj1hz;
		end if;	
 END IF;
 END PROCESS;
		 
		 
		 process (Reloj1hz)
 variable temporizador : integer range 0 to 30;
  BEGIN
 if(rising_edge(Reloj1Hz)) then

		if(temporizador < 30 ) then
		 	temporizador := temporizador + 1;		
			
				if (temporizador < 15) then
			mireID    	         <= X"4";	             ------------------------------MIRE ID		
			HLengthChoix  	<=  HLength2;
		    HResChoix  			<=      HRes2;
		    HFPChoix 			<=  HFP2;
	        HSyncPulseChoix  <=  HSyncPulse2;
	     	HBPChoix      		<=     HBP2;
	        HPolSyncCHoix   	<= HPolSync2;	
	       VLengthChoix 		<=   VLength2;
	        VResChoix         	<=   VRes2;
	     	VFPChoix 			<=   VFP2;
	 	   VSyncPulseChoix 	<= VSyncPulse2;
	 	   VBPCHoix            	<=   VBP2;
	    	VPolSyncChoix   	<=   VPolSync2;
	        relojSistemaChoix  		<= X"0";	
				
				else 		
			mireID    		<= X"9";                        ------------------------------MIRE ID		
			HLengthChoix  	<=  HLength12;
		    HResChoix  			<=      HRes12;
		    HFPChoix 			<=  HFP12;
	        HSyncPulseChoix  <=  HSyncPulse12;
	     	HBPChoix      		<=     HBP12;
	        HPolSyncCHoix   	<= HPolSync12;	
	       VLengthChoix 		<=   VLength12;
	        VResChoix         	<=   VRes12;
	     	VFPChoix 			<=   VFP12;
	 	   VSyncPulseChoix 	<= VSyncPulse12;
	 	   VBPCHoix            	<=   VBP12;
	    	VPolSyncChoix   	<=   VPolSync12;
	         relojSistemaChoix  		<= X"9";	
   
				end if;
		else 
		temporizador :=0;
		end if;
end if;
end process;

				 
   END simulacion;