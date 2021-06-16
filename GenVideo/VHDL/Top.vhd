library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;



entity Top is port(

     PinClk125, PinPortRx : in std_logic;
     PinLedXv, PinPortTx : out std_logic;

-- DVI generator
     PinClk, PinVSync, PinHSync, PinDe, PinTfpClkP, PinTfpClkN : out std_logic;
     PinDat : out std_logic_vector(23 downto 0);

     PinSda : inout std_logic;
     PinScl : out std_logic;
	 
	 
	 -- SPI
	 
	 SCLK : in  std_logic;    					 -- SPI input clock
     MOSI : in  std_logic;    					 -- SPI serial data input bit to bit          
     SS   : in  std_logic;     					 -- chip select input (active low)
     MISO : out std_logic;    					 -- SPI serial data output bit to bit
     SS_out : out std_logic	   );					 -- active when sending to the master



end Top;


architecture rtl of Top is



component decodage_generation is
port (	PClock       	: out std_logic_vector(3 downto 0);
		Mire_ID         : out std_logic_vector(3 downto 0);
		data_dispo      : out std_logic;
		HLength         : out std_logic_vector(11 downto 0);
		HRes            : out std_logic_vector(11 downto 0);
		HFP             : out std_logic_vector(7 downto 0);
		HSyncPulse      : out std_logic_vector(7 downto 0);
		HBP             : out std_logic_vector(8 downto 0);
		HPolSync        : out std_logic;
		VLength         : out std_logic_vector(11 downto 0);
		VRes            : out std_logic_vector(11 downto 0);
		VFP             : out std_logic_vector(3 downto 0);
		VSyncPulse      : out std_logic_vector(3 downto 0);
		VBP             : out std_logic_vector(5 downto 0);
		VPolSync        : out std_logic;
		data_out        : in std_logic_vector (7 downto 0);
		data_valid_out  : in std_logic;
		clk             : in std_logic
		);
end component;


component Spi_slave is
    Port ( SCLK : in  std_logic;    					 -- SPI input clock
           MOSI : in  std_logic;    					 -- SPI serial data input bit to bit          
           SS   : in  std_logic;     					 -- chip select input (active low)
           Data_in : in std_logic_vector (7 downto 0);   -- byte to send to master 
           Data_valid_in : in  std_logic;				 -- active when the byte in input Data_in is complete and ready to send 
           MISO : out std_logic;    					 -- SPI serial data output bit to bit
           Data_valid_out : out  std_logic;				 -- active when the byte has been receive by MOSI
           Data_out : out std_logic_vector (7 downto 0); -- byte receive by MOSI 
           SS_out : out std_logic						 -- active when sending to the master
          );
end component;



component TestVideoTop  port(

        PinClk125     : in std_logic;
		PinPortRx     : in std_logic;
        PinLedXv      : out std_logic;
		PinPortTx     : out  std_logic;  

-- DVI generator
     PinClk  			: out  std_logic; 
	 PinVSync			: out  std_logic; 
	 PinHSync 			: out  std_logic; 
	 PinDe 				: out  std_logic; 
	 PinTfpClkP 		: out  std_logic; 
	 PinTfpClkN 		: out  std_logic; 
     PinDat 			: out  std_logic_vector(23 downto 0); 

     PinSda 			: inout std_logic;
     PinScl 			: out std_logic;
	 
	 
	 
     HLengthChoix  		        :     in std_logic_vector(11 downto 0);	--	Total number of pixel clocks in a row
	 HResChoix      	            :    in   std_logic_vector(11 downto 0); 		--	Horiztonal display width in pixels
	 HFPChoix     		            :    in  std_logic_vector(7 downto 0);			--	Horiztonal front porch width in pixels
	 HSyncPulseChoix             :    in std_logic_vector(7 downto 0);		--	Horiztonal sync pulse width in pixels
	 HBPChoix    		  	        :    in std_logic_vector(8 downto 0);		--	Horiztonal back porch width in pixels
	 HPolSyncCHoix 		       :    in   std_logic;												--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	 VLengthChoix  			       :    in  std_logic_vector(11 downto 0);		--	Total number of pixel clocks in column
	 VResChoix    		  	       :    in  std_logic_vector(11 downto 0); 		--	Vertical display width in pixels
	 VFPChoix 					:    in std_logic_vector(3 downto 0);				--	Vertical front porch width in pixels
	 VSyncPulseChoix 		    :    in std_logic_vector(3 downto 0);		--	Vertical sync pulse width in pixels
	 VBPCHoix         	 	   		:   in std_logic_vector(5 downto 0);	       --	Vertical back porch width in pixels
	 VPolSyncChoix    		     :   in std_logic;			--	Vertical sync pulse polarity (1 = positive, 0 = negative)
	 relojSistemaChoix      :   in std_logic_vector (3 downto 0);           ----- pixel_clock
	 dataDispo          		     : 	in std_logic;				-----------------pulse lecture
	 mireID                               : 	in std_logic_vector (3 downto 0));--------------------mire choix
	 
end  component;



signal Data_in 						: std_logic_vector (7 downto 0);   -- byte to send to master 
signal Data_valid_in 				: std_logic;				 -- active when the byte in input Data_in is complete and ready to send 
signal Data_valid_out 				:   std_logic;				 -- active when the byte has been receive by MOSI
signal Data_out			 			:  std_logic_vector (7 downto 0); -- byte receive by MOSI 

signal HLengthChoix  		        :  std_logic_vector(11 downto 0);	--	Total number of pixel clocks in a row
signal HResChoix      	            :  std_logic_vector(11 downto 0); 		--	Horiztonal display width in pixels
signal HFPChoix     		        :   std_logic_vector(7 downto 0);			--	Horiztonal front porch width in pixels
signal HSyncPulseChoix             :   std_logic_vector(7 downto 0);		--	Horiztonal sync pulse width in pixels
signal HBPChoix    		  	        :   std_logic_vector(8 downto 0);		--	Horiztonal back porch width in pixels
signal HPolSyncCHoix 		       :    std_logic;												--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
signal VLengthChoix  			    :  std_logic_vector(11 downto 0);		--	Total number of pixel clocks in column
signal VResChoix    		  	    :   std_logic_vector(11 downto 0); 		--	Vertical display width in pixels
signal VFPChoix 					:   std_logic_vector(3 downto 0);				--	Vertical front porch width in pixels
signal VSyncPulseChoix 		        :    std_logic_vector(3 downto 0);		--	Vertical sync pulse width in pixels
signal VBPCHoix         	 	    :   std_logic_vector(5 downto 0);	       --	Vertical back porch width in pixels
signal VPolSyncChoix    		     :    std_logic;			--	Vertical sync pulse polarity (1 = positive, 0 = negative)
signal relojSistemaChoix             :   std_logic_vector (3 downto 0);           ----- pixel_clock
signal dataDispo          		     : 	  std_logic;				-----------------pulse lecture
signal mireID                        : 	  std_logic_vector (3 downto 0);--------------------mire choix

signal data_dispo			 			:  std_logic; -- byte receive by MOSI 











begin




uDecodeur: decodage_generation
port map(	PClock =>relojSistemaChoix  ,
		Mire_ID =>MireID       ,
		data_dispo=>data_dispo    ,
		HLength => HLengthChoix     ,
		HRes=>HResChoix     ,
		HFP =>HFPChoix      ,
		HSyncPulse => HSyncPulseChoix    ,
		HBP => HBPChoix    ,
		HPolSync => HPolSyncCHoix ,
		VLength =>VLengthChoix     ,
		VRes =>VResChoix   ,
		VFP => VFPChoix   ,
		VSyncPulse =>  VSyncPulseChoix ,
		VBP=>VBPChoix  ,
		VPolSync=>VPolSyncChoix   ,
		
		data_out=>data_out     ,
		data_valid_out=> data_valid_out    ,
		clk => PinClk125 
		);


TOPvideo:  TestVideoTop 
port map(

        PinClk125 => PinClk125,
		PinPortRx => PinPortRx, 
        PinLedXv => PinLedXv, 
		PinPortTx  => PinPortTx,  

-- DVI generator
     PinClk => PinClk,
	 PinVSync=> PinVSync, 
	 PinHSync => PinHSync, 
	 PinDe => PinDe, 
	 PinTfpClkP => PinTfpClkP,
	 PinTfpClkN => PinTfpClkN ,
     PinDat => PinDat  ,

     PinSda => PinSda,
     PinScl => PinScl ,
	 
	 
     HLengthChoix => HLengthChoix  ,		  
	 HResChoix => HResChoix ,      	       
	 HFPChoix => HFPChoix	,   		          
	 HSyncPulseChoix => HSyncPulseChoix,              
	 HBPChoix  => HBPChoix  ,  		  	      
	 HPolSyncCHoix => HPolSyncCHoix,		          	
	 VLengthChoix => VLengthChoix, 			     
	 VResChoix => VResChoix ,   		  	     
	 VFPChoix => VFPChoix ,				      
	 VSyncPulseChoix => VSyncPulseChoix, 		    
	 VBPCHoix => VBPCHoix ,          	 	  
	 VPolSyncChoix => VPolSyncChoix,   		       
	 relojSistemaChoix => relojSistemaChoix ,	        
	 dataDispo => dataDispo ,           		  
	 mireID => mireID 
	 
);--------------------mire choix
	 


SPI :  Spi_slave
    Port map ( 
	
	
		   SCLK => SCLK,
           MOSI => MOSI,   
           SS  => SS, 
           Data_in => Data_in, 
           Data_valid_in => Data_valid_in, 
           MISO => MISO, 
           Data_valid_out => Data_valid_out, 
           Data_out => Data_out, 
           SS_out => SS_out
          );









end rtl;
