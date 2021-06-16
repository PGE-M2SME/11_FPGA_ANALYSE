
--
-- Projet de test Ext10 sur PFX avec Xv
--   Ext10 en slot1
--   Console en slot2
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--library ecp2m;
--use ecp2m.components.all;


entity TestVideoTop is port(

        PinClk125, PinPortRx : in std_logic;
        PinLedXv, PinPortTx : out std_logic;

-- DVI generator
     PinClk, PinVSync, PinHSync, PinDe, PinTfpClkP, PinTfpClkN : out std_logic;
     PinDat : out std_logic_vector(23 downto 0);

     PinSda : inout std_logic;
     PinScl : out std_logic;
	 
	 
	 
     HLengthChoix  		           :     in std_logic_vector(11 downto 0);	--	Total number of pixel clocks in a row
	 HResChoix       	           :    in   std_logic_vector(11 downto 0); 		--	Horiztonal display width in pixels
	 HFPChoix 	   		           :    in  std_logic_vector(7 downto 0);			--	Horiztonal front porch width in pixels
	 HSyncPulseChoix               :    in std_logic_vector(7 downto 0);		--	Horiztonal sync pulse width in pixels
	 HBPChoix      		  	       :    in std_logic_vector(8 downto 0);		--	Horiztonal back porch width in pixels
	 HPolSyncCHoix 		           :    in   std_logic;												--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	 VLengthChoix 			       :    in  std_logic_vector(11 downto 0);		--	Total number of pixel clocks in column
	 VResChoix    		  	       :    in  std_logic_vector(11 downto 0); 		--	Vertical display width in pixels
	 VFPChoix 				       :    in std_logic_vector(3 downto 0);				--	Vertical front porch width in pixels
	 VSyncPulseChoix 		       :    in std_logic_vector(3 downto 0);		--	Vertical sync pulse width in pixels
	 VBPCHoix           	 	   :   in std_logic_vector(5 downto 0);	       --	Vertical back porch width in pixels
	 VPolSyncChoix   		       :   in std_logic;			--	Vertical sync pulse polarity (1 = positive, 0 = negative)
	 relojSistemaChoix 	           :   in std_logic_vector (3 downto 0);           ----- pixel_clock
	 dataDispo            		   : 	in std_logic;				-----------------pulse lecture
	 mireID                       : 	in std_logic_vector (3 downto 0));--------------------mire choix
	 
end TestVideoTop;

architecture rtl of TestVideoTop is

component Pll125to100x50
    port (CLK: in std_logic; CLKOP, CLKOK, LOCK: out std_logic);
end component;

component Pll125to159
    port (CLK: in std_logic; CLKOP, CLKOK, LOCK: out std_logic);
end component;

component PllClkto25
    port (CLK: in std_logic; CLKOP, CLKOK, LOCK: out std_logic);
end component;


component PllClkto80
    port (CLK: in std_logic; CLKOP, CLKOK, LOCK: out std_logic);
end component;


component PllClkto120
    port (CLK: in std_logic; CLKOP, CLKOK, LOCK: out std_logic);
end component;


component PllClkto140
    port (CLK: in std_logic; CLKOP, CLKOK, LOCK: out std_logic);
end component;

component PllClkto34
    port (CLK: in std_logic; CLKOP, CLKOK, LOCK: out std_logic);
end component;


component Pll125toclock
    port (CLK: in std_logic; CLKOP, CLKOK, LOCK: out std_logic);
end component;

------------------------------------------------------COMPONENT DCS-------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
COMPONENT DCS  
GENERIC  ( DCSMODE : string := "POS"  );  
PORT  ( CLK0   :IN  std_logic;    CLK1   :IN  std_logic;    SEL    :IN  std_logic;    DCSOUT :OUT std_logic  ); 
END COMPONENT;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


component SeqBlk 
generic(FREQMHZ : integer := 100; BAUDRATE : integer := 115200);
port ( Clk, ARst_N : in std_logic;
       SysCnt32 : out std_logic_vector(31 downto 0);
       InitDone, Ce16, Ce7, Ce1ms, Ce1us, SRst : out std_logic;
       StartupPCS : out std_logic_vector(1 downto 0); 
       StartupSDR, StartupDDR2, StartupDDR3 : out std_logic); 
end component;

 component simulacion 
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
 END component;


component I2cMasterCommands 
generic(FPGA_FAMILY : string := "ECP3";
        FREQ_MHZ : integer := 100; 
        RATE_KHZ : integer := 400);
port( 
	Clk, SRst: in std_logic ;

-- Command controls
    Trg, RdWr_N : in std_logic;
    Done, Busy : out std_logic;
    DeviceId, Address : in std_logic_vector(7 downto 0);

-- Write commands 
    We : in std_logic;
    DataW : in std_logic_vector(7 downto 0);
    FifoFull : out std_logic;

-- Read commands
    DataR : out std_logic_vector(7 downto 0);
    RdLen : in std_logic_vector(7 downto 0);
    DataVal : out std_logic;

-- I2C external interface
	Sda: inout std_logic ;
	Scl: out std_logic  
);
end component;

component pmi_fifo is
     generic (
       pmi_data_width : integer := 16; pmi_data_depth : integer := 1024; 
       pmi_full_flag : integer := 1024; pmi_empty_flag : integer := 0; 
       pmi_almost_full_flag : integer := 252; pmi_almost_empty_flag : integer := 4; 
       pmi_regmode : string := "reg"; pmi_family : string := "EC" ; 
       module_type : string := "pmi_fifo"; pmi_implementation : string := "LUT");
    port (
     Data : in std_logic_vector(pmi_data_width-1 downto 0);
     Clock: in std_logic; WrEn: in std_logic; RdEn: in std_logic;
     Reset: in std_logic; Q : out std_logic_vector(pmi_data_width-1 downto 0);
     Empty: out std_logic; Full: out std_logic;
     AlmostEmpty: out std_logic; AlmostFull: out std_logic);
end component ;


 --component testvideo IS
 --GENERIC (
 --Ha: INTEGER := 96; --Hpulse
 --Hb: INTEGER := 144; --Hpulse+HBP
 --Hc: INTEGER := 784; --Hpulse+HBP+Hactive
 --Hd: INTEGER := 800; --Hpulse+HBP+Hactive+HFP
 --Va: INTEGER := 2; --Vpulse
 --Vb: INTEGER := 35; --Vpulse+VBP
 --Vc: INTEGER := 515; --Vpulse+VBP+Vactive
 --Vd: INTEGER := 525); --Vpulse+VBP+Vactive+VFP
  
 --PORT (
 --pixel_clk: IN STD_LOGIC; 
 ----red_switch, green_switch, blue_switch: IN STD_LOGIC;
 --S_Hsync, S_Vsync, S_dena  : out STD_LOGIC;
 --ColoresRGB: OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
 --);
--end component ;


component Forth  
generic(FPGA_FAMILY : string := "ECP3";
        HEXFILE : string := "ep32q.hex"); 
port(
    Clk, SRst, Ce16, PortRx, TrgIntRe : in std_logic;
    PortTx, PpWe : out std_logic;
    PpAdd : out std_logic_vector(7 downto 0);
    PokeDat : out std_logic_vector(31 downto 0);
    PeekDat : in std_logic_vector(31 downto 0);
    Monitor: out std_logic_vector(7 downto 0)
  );
end component;


component Dvi410 
generic(FPGA_FAMILY : string := "ECP3"); 
port(         
-----------------------------------------------CHANGEMENT AU 02/08/2021------------------------------
	     	HLength	 	     :     in std_logic_vector(11 downto 0);	
			HRes		         :    in std_logic_vector(11 downto 0);
			VRes		         :    in  std_logic_vector(11 downto 0);
			---------------------------------------------------------------------------------------------------
			HFP					: 	   in std_logic_vector(7 downto 0);		--	Horiztonal front porch width in pixels
			HSyncPulse		: 	   in std_logic_vector(7 downto 0);		--	Horiztonal sync pulse width in pixels
			HBP					: 	   in std_logic_vector(8 downto 0);		--	Horiztonal back porch width in pixels
			HPolSync			: 		in std_logic;						--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
			VLength	 		: 		in std_logic_vector(11 downto 0);	--	Total number of pixel clocks in column
			VFP			: 			in std_logic_vector(3 downto 0);		--	Vertical front porch width in pixels
			VSyncPulse	: 		in std_logic_vector(3 downto 0);		--	Vertical sync pulse width in pixels
			VBP			: 			in std_logic_vector(5 downto 0);	--	Vertical back porch width in pixels
			VPolSync	: 			in std_logic;						--	Vertical sync pulse polarity (1 = positive, 0 = negative)
	--------------------------------------------------------------------------------------------------

-- Configuration in the SysClk domain
        SysClk : in std_logic; 
        SRst : in std_logic; 
        ConfWe : in std_logic;
        ConfAdd : in std_logic_vector(15 downto 0);
        ConfDat : in std_logic_vector(15 downto 0);
        DviResH : out std_logic_vector(11 downto 0);
-- DVI domain
        ClkDvi : in std_logic;
        NewFrame, ReqNewRow, FifoRd : out std_logic;
        DataIn : in std_logic_vector(23 downto 0);
-- TFP410 outputs
        PinTfpVs : out std_logic;
        PinTfpHs : out std_logic;
        PinTfpDe : out std_logic;
        PinTfpClk : out std_logic;
        PinTfpDat : out std_logic_vector(23 downto 0);
		
---Taille de l'ecran
		axeH : out std_logic_vector ( 11 downto 0 );
		axeV  : out std_logic_vector ( 11 downto 0 )
);
end component;

component mires
 PORT (
 Clk100:              IN STD_LOGIC;
 tH,tV:                IN std_logic_vector ( 11 downto 0 );
 NewDviFrame   :   IN STD_LOGIC; 
 ReqNewRow      : IN STD_LOGIC; 
 DviFifoRd          :   IN STD_LOGIC; 
 SRst                  : IN STD_LOGIC;
 --change 			  : inout STD_LOGIC;
 --resolutionChoix : IN STD_LOGIC_vector (3 DOWNTO 0);
 choixMire 		 : in std_logic_vector(3 downto 0);
 HContador        : out std_logic_vector(11 downto 0);
 HVertical           : out std_logic_vector(11 downto 0);
 DatRGB                 :            OUT std_logic_vector(23 downto 0)
 );
 END component;




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------CREATION DE SIGNALS PARA GAUTIER PARA HACERLAS CAMBIAR------------------------------------------------------------------------
	--signal  HLengthChoix  		: std_logic_vector(11 downto 0):=X"320";		--	Total number of pixel clocks in a row
	--signal 	HResChoix       	: std_logic_vector(11 downto 0):=X"280"; 		--	Horiztonal display width in pixels
	--signal 	HFPChoix 	   		: std_logic_vector(7 downto 0):=X"10";			--	Horiztonal front porch width in pixels
	--signal  HSyncPulseChoix     		: std_logic_vector(7 downto 0):=X"60";		--	Horiztonal sync pulse width in pixels
	--signal 	HBPChoix      		: std_logic_vector(8 downto 0):= '0'&X"30";		--	Horiztonal back porch width in pixels
	--signal 	HPolSyncCHoix 	: std_logic:='1';												--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	--signal  VLengthChoix 	: std_logic_vector(11 downto 0):=X"20D";		--	Total number of pixel clocks in column
	--signal  VResChoix      	: std_logic_vector(11 downto 0):=X"1E0"; 		--	Vertical display width in pixels
	--signal 	VFPChoix 			 : std_logic_vector(3 downto 0):=X"A";				--	Vertical front porch width in pixels
	--signal 	VSyncPulseChoix : std_logic_vector(3 downto 0):=X"2";		--	Vertical sync pulse width in pixels
	--signal 	VBPCHoix            : std_logic_vector(5 downto 0):="10"&X"1";	       --	Vertical back porch width in pixels
	--signal 	VPolSyncChoix   	: std_logic:='1';			--	Vertical sync pulse polarity (1 = positive, 0 = negative)
	--signal   relojSistema : std_logic;
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------SENALES PARA GAUTIER en 1280x1024_85hz--------@159 clk------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--signal  HLength1	 			: std_logic_vector(11 downto 0):=X"6D0";		--	Total number of pixel clocks in a row
	--signal 	HRes1					: std_logic_vector(11 downto 0):=X"500"; 			--	Horiztonal display width in pixels
	--signal 	HFP1						: std_logic_vector(7 downto 0):=X"60";				--	Horiztonal front porch width in pixels
	--signal  HSyncPulse1			: std_logic_vector(7 downto 0):=X"88";			--	Horiztonal sync pulse width in pixels
	--signal 	HBP1						: std_logic_vector(8 downto 0):= '0'&X"E8";		--	Horiztonal back porch width in pixels
	--signal 	HPolSync1				: std_logic:='1';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	--signal  VLength1	 			: std_logic_vector(11 downto 0):=X"433";		--	Total number of pixel clocks in column
	--signal  VRes1					: std_logic_vector(11 downto 0):=X"400"; 			--	Vertical display width in pixels
	--signal 	VFP1						: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	--signal 	VSyncPulse1			: std_logic_vector(3 downto 0):=X"3";			--	Vertical sync pulse width in pixels
	--signal 	VBP1						: std_logic_vector(5 downto 0):="10"&X"F";		--	Vertical back porch width in pixels
	--signal 	VPolSync1				: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------SENALES PARA GAUTIER en 640x480_60hz----------------------@25 clk----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--signal  HLength2	 	: std_logic_vector(11 downto 0):=X"320";		--	Total number of pixel clocks in a row
	--signal 	HRes2		: std_logic_vector(11 downto 0):=X"280"; 			--	Horiztonal display width in pixels
	--signal 	HFP2			: std_logic_vector(7 downto 0):=X"10";				--	Horiztonal front porch width in pixels
	--signal  HSyncPulse2	: std_logic_vector(7 downto 0):=X"60";			--	Horiztonal sync pulse width in pixels
	--signal 	HBP2			: std_logic_vector(8 downto 0):= '0'&X"30";		--	Horiztonal back porch width in pixels
	--signal 	HPolSync2	: std_logic:='0';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	--signal  VLength2	 	: std_logic_vector(11 downto 0):=X"20D";		--	Total number of pixel clocks in column
	--signal  VRes2		: std_logic_vector(11 downto 0):=X"1E0"; 			--	Vertical display width in pixels
	--signal 	VFP2			: std_logic_vector(3 downto 0):=X"A";				--	Vertical front porch width in pixels
	--signal 	VSyncPulse2	: std_logic_vector(3 downto 0):=X"2";			--	Vertical sync pulse width in pixels
	--signal 	VBP2			: std_logic_vector(5 downto 0):="10"&X"1";		--	Vertical back porch width in pixels
	--signal 	VPolSync2	: std_logic:='0';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------SENALES PARA GAUTIER en 800x600_60hz------------------------@40clk---------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--signal  HLength	 	: std_logic_vector(11 downto 0):=X"420";		--	Total number of pixel clocks in a row
	--signal 	HRes		: std_logic_vector(11 downto 0):=X"320"; 			--	Horiztonal display width in pixels
	--signal 	HFP			: std_logic_vector(7 downto 0):=X"28";				--	Horiztonal front porch width in pixels
	--signal  HSyncPulse	: std_logic_vector(7 downto 0):=X"80";			--	Horiztonal sync pulse width in pixels
	--signal 	HBP			: std_logic_vector(8 downto 0):= '0'&X"58";		--	Horiztonal back porch width in pixels
	--signal 	HPolSync	: std_logic:='1';													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	--signal  VLength	 	: std_logic_vector(11 downto 0):=X"274";		--	Total number of pixel clocks in column
	--signal  VRes		: std_logic_vector(11 downto 0):=X"258"; 			--	Vertical display width in pixels
	--signal 	VFP			: std_logic_vector(3 downto 0):=X"1";				--	Vertical front porch width in pixels
	--signal 	VSyncPulse	: std_logic_vector(3 downto 0):=X"4";			--	Vertical sync pulse width in pixels
	--signal 	VBP			: std_logic_vector(5 downto 0):="01"&X"7";		--	Vertical back porch width in pixels
	--signal 	VPolSync	: std_logic:='1';													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------SENALES PARA SIMULACION -------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MODIF CYP	
	
--	signal  HLengthChoix  		: std_logic_vector(11 downto 0);		--	Total number of pixel clocks in a row
--	signal 	HResChoix       	: std_logic_vector(11 downto 0); 		--	Horiztonal display width in pixels
--	signal 	HFPChoix 	   		: std_logic_vector(7 downto 0);			--	Horiztonal front porch width in pixels
--	signal  HSyncPulseChoix     		: std_logic_vector(7 downto 0);		--	Horiztonal sync pulse width in pixels
--	signal 	HBPChoix      		: std_logic_vector(8 downto 0);		--	Horiztonal back porch width in pixels
--	signal 	HPolSyncCHoix 	: std_logic;												--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
--	signal  VLengthChoix 	: std_logic_vector(11 downto 0);		--	Total number of pixel clocks in column
--	signal  VResChoix      	: std_logic_vector(11 downto 0); 		--	Vertical display width in pixels
--	signal 	VFPChoix 			 : std_logic_vector(3 downto 0);				--	Vertical front porch width in pixels
--	signal 	VSyncPulseChoix : std_logic_vector(3 downto 0);		--	Vertical sync pulse width in pixels
--	signal 	VBPCHoix            : std_logic_vector(5 downto 0);	       --	Vertical back porch width in pixels
--	signal 	VPolSyncChoix   	: std_logic;			--	Vertical sync pulse polarity (1 = positive, 0 = negative)
	signal   relojSistema : std_logic;
--	signal relojSistemaChoix : std_logic_vector  (3 downto 0);   ----- pixel_clock
--	signal dataDispo : std_logic;			-----------------pulse lecture
--	signal mireID 			: std_logic_vector (3 downto 0 );--------------------mire choix
	signal choixMire 		:std_logic_vector (3 downto 0);
   signal  HLength	 	: std_logic_vector(11 downto 0);		--	Total number of pixel clocks in a row
	signal 	HRes		: std_logic_vector(11 downto 0); 			--	Horiztonal display width in pixels
	signal 	HFP			: std_logic_vector(7 downto 0);				--	Horiztonal front porch width in pixels
	signal  HSyncPulse	: std_logic_vector(7 downto 0);			--	Horiztonal sync pulse width in pixels
	signal 	HBP			: std_logic_vector(8 downto 0);		--	Horiztonal back porch width in pixels
	signal 	HPolSync	: std_logic;													--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	signal  VLength	 	: std_logic_vector(11 downto 0);		--	Total number of pixel clocks in column
	signal  VRes		: std_logic_vector(11 downto 0); 			--	Vertical display width in pixels
	signal 	VFP			: std_logic_vector(3 downto 0);				--	Vertical front porch width in pixels
	signal 	VSyncPulse	: std_logic_vector(3 downto 0);			--	Vertical sync pulse width in pixels
	signal 	VBP			: std_logic_vector(5 downto 0);		--	Vertical back porch width in pixels
	signal 	VPolSync	: std_logic;													--	Vertical sync pulse polarity (1 = positive, 0 = negative)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



signal salida0, salida1, salida2, salida3, salida4, salida5 : std_logic; --, salida6, salida7, salida8      : std_logic;
--signal  change : std_logic;
--signal resolutionChoix : std_logic_vector( 3 downto 0):=X"0"; 
signal HContador, HVertical : std_logic_vector(11 downto 0);
--signal Selection : std_logic_vector (5 downto 0);
signal Selection : std_logic;
---taille de l'ecran
signal tH, tV : std_logic_vector ( 11 downto 0 );

-- Clocks, Rst,...
signal Clk100, Clk159, Clk50, Clk25, Clk20,Clk13, Clk12,Ce16, SRst, ARst_N, PllLock, PllLock1, PllLock2, InitDone : std_logic;
signal Clk120, Clk60, PllLock3 : std_logic;
signal  Clk140, Clk70, PllLock4 : std_logic;
signal  Clk80, Clk40, PllLock5 : std_logic;
signal  Clk34, Clk17, PllLock6 : std_logic;
signal  Clk110, Clk55, PllLock7 : std_logic;
signal SysCnt32 : std_logic_vector(31 downto 0);
signal Reloj1hz: std_logic;
signal  s_PinClk125 : std_logic;

-- Processor interface
signal PpWe : std_logic;
signal PpAdd : std_logic_vector(7 downto 0);
signal PokeDat, PeekDat, MiscReg1, MiscReg2, Timer : std_logic_vector(31 downto 0);

-- Mire
signal DatR, DatG, DatB : std_logic_vector(7 downto 0);
signal FCnt, HCnt, VCnt : std_logic_vector(11 downto 0);

-- DVI
signal DviConfWe, NewDviFrame, DviFifoRd, ReqNewRow : std_logic;
signal Resolution : std_logic_vector(11 downto 0);
signal DviDat : std_logic_vector(23 downto 0);

-- I2c interface
signal I2cTrg, I2cRdWr_N, I2cWe, DataVal, FifoRd, I2cBusy : std_logic;
signal RdLen, DataR, I2cDataR : std_logic_vector(7 downto 0);

begin

uPll : Pll125to100x50 port map (CLK=>PinClk125, CLKOP=>Clk100, CLKOK=>Clk50, LOCK=>PllLock);

-----------------------------------------------------------------------------------------------------------------------------------------------

uPllclock: Pll125toclock port map (CLK=>PinClk125, CLKOP=>Clk110, CLKOK=>Clk55, LOCK=>PllLock7);
--------------------------------------------------------------------------------------------------------------------------------

uclock : Pll125to159 port map (CLK=>Clk100, CLKOP=>Clk159 , CLKOK=>Clk13, LOCK=>PllLock1);

uclock640x480 : PllClkto25 port map (CLK=>Clk100, CLKOP=>Clk25 , CLKOK=>Clk12, LOCK=>PllLock2);

uclock1400x1050: PllClkto120 port map (CLK=>Clk100, CLKOP=>Clk120 , CLKOK=>Clk60, LOCK=>PllLock3);

uclock1680x: PllClkto140 port map (CLK=>Clk100, CLKOP=>Clk140 , CLKOK=>Clk70, LOCK=>PllLock4);

uclock800x600 : PllClkto80 port map (CLK=>Clk100, CLKOP=>Clk80 , CLKOK=>Clk40, LOCK=>PllLock5);

uclock34: PllClkto80 port map (CLK=>Clk100, CLKOP=>Clk34 , CLKOK=>Clk17, LOCK=>PllLock6); 

ARst_N <= PllLock;

uSeq : SeqBlk generic map (FREQMHZ=>50)
              port map (Clk=>Clk50, ARst_N=>ARst_N, SysCnt32=>SysCnt32, SRst=>SRst, InitDone=>InitDone, Ce16=>Ce16); 

PinLedXv <= SysCnt32(23);
--
-- Forth
--

uForth : Forth port map(Clk=>Clk50, SRst=>SRst, Ce16=>Ce16, TrgIntRe=>'0', 
                        PortRx=>PinPortRx, PortTx=>PinPortTx, Monitor=>open,
                        PpWe=>PpWe, PpAdd=>PpAdd, PokeDat=>PokeDat, PeekDat=>PeekDat);

--
-- Registers
--

pSetReg: process (Clk50)
begin
  if Clk50'event and Clk50='1' then
    if SRst = '1' then
      MiscReg1 <= (others => '0');
    elsif ((PpWe = '1') and (PpAdd = X"26")) then 
      MiscReg1 <= PokeDat;
    end if;
    if SRst = '1' then
      MiscReg2 <= (others => '0');
    elsif ((PpWe = '1') and (PpAdd = X"27")) then 
      MiscReg2 <= PokeDat;
    end if;
    if SRst = '1' then
      Timer <= (others => '0');
    elsif ((PpWe = '1') and (PpAdd = X"08")) then 
      Timer <= PokeDat;
    elsif Timer /= X"00000000" then 
      Timer <= Timer + X"FFFFFFFF";
    end if;
    if SRst = '1' then
      RdLen <= X"04";
    elsif ((PpWe = '1') and (PpAdd = X"33")) then 
      RdLen <= PokeDat(7 downto 0);
    end if;
  end if;
end process pSetReg;

PeekDat <= X"0000000" & "000" & InitDone  when PpAdd = X"05" else 
           Timer                          when PpAdd = X"08" else 
           MiscReg1                       when PpAdd = X"26" else 
           MiscReg2                       when PpAdd = X"27" else 
           X"0000000" & "000" & I2cBusy   when PpAdd = X"35" else 
           X"000000" & I2cDataR           when PpAdd = X"34" else
         X"00000" & Resolution          when PpAdd = X"20" else 
	    -- X"00000" & X"000"          when PpAdd = X"20" else 
           X"CAFECAFE";


--utestvideo : testvideo
 --GENERIC MAP(
 --Ha => 96, --Hpulse
 --Hb=>144, --Hpulse+HBP
 --Hc =>784, --Hpulse+HBP+Hactive
 --Hd =>800, --Hpulse+HBP+Hactive+HFP
 --Va => 2, --Vpulse
 --Vb  => 35, --Vpulse+VBP
 --Vc  => 515, --Vpulse+VBP+Vactive
 --Vd  => 525) --Vpulse+VBP+Vactive+VFP
 
 --PORT MAP(
 --pixel_clk => Clk25, S_Hsync => PinHSync, S_Vsync=> PinVSync , S_dena =>  PinDe, ColoresRGB=>PinDat);


-- 
-- TFP410 interface: Config TFP
--

uMaster : I2cMasterCommands  
generic map(FPGA_FAMILY=>"ECP3", FREQ_MHZ=>50, RATE_KHZ=>100)
port map( 
	Clk=>Clk50, SRst=>SRst,
    Trg=>I2cTrg, RdWr_N=>I2cRdWr_N,
    Done=>open, Busy=>I2cBusy,
    DeviceId=>X"70", Address=>PokeDat(7 downto 0),
    We=>I2cWe, DataW=>PokeDat(7 downto 0), FifoFull=>open,
    DataR=>DataR, RdLen=>RdLen, DataVal=>DataVal,
    Sda=>PinSda, Scl=>PinScl);

I2cTrg <= '1' when ((PpWe = '1') and (PpAdd = X"31")) else 
          '1' when ((PpWe = '1') and (PpAdd = X"32")) else 
          '0';

I2cRdWr_N <= '0' when ((PpWe = '1') and (PpAdd = X"31")) else '1';

I2cWe <= '1' when ((PpWe = '1') and (PpAdd = X"30")) else '0';
FifoRd <= '1' when ((PpWe = '1') and (PpAdd = X"34")) else '0';

uFifoRxRaw : pmi_fifo 
generic map(pmi_data_width=>8, pmi_data_depth=>16, pmi_full_flag=>16,
            pmi_regmode=>"noreg", pmi_family=>"ECP3", pmi_implementation=>"LUT")
port map(Clock=>Clk50, Data=>DataR, WrEn=>DataVal, Q=>I2cDataR, RdEn=>FifoRd, Reset=>SRst);


--
-- TFP410 interface: Data & config IP
--

--DviConfWe <= '1' when ((PpWe = '1') and (PpAdd = X"21")) else '0';
DviConfWe <= '1' ;--when ((PpWe = '1') and (PpAdd = X"21")) else '0';


uDvi : Dvi410 generic map(FPGA_FAMILY=>"ECP3") 
              port map(
				  HLength=>HLength, HRes=>HRes, VRes=>VRes, HFP=>HFP, HSyncPulse=>HSyncPulse, HBP=> HBP, HPolSync=>'1',VLength=>VLength, VFP=> VFP, VSyncPulse=>VSyncPulse, VBP=> VBP, VPolSync=>'1',  --descomentar esta parte 
				-- HLength=>HLengthChoix, HRes=>HResChoix, VRes=>VResCHoix, HFP=>HFPChoix, HSyncPulse=>HSyncPulseChoix, HBP=> HBPChoix, HPolSync=>HPolSyncChoix,VLength=>VLengthChoix, VFP=> VFPChoix, VSyncPulse=>VSyncPulseChoix, VBP=> VBPChoix, VPolSync=>VPolSyncChoix,
                   SysClk=>Clk50, SRst=>SRst, 
                   ConfWe=>DviConfWe, DviResH=>Resolution,
				   ConfAdd=>X"011A" , ConfDat=>PokeDat(15 downto 0),
                   --ConfAdd=>PokeDat(31 downto 16), ConfDat=>PokeDat(15 downto 0),
				   ClkDvi=>relojSistema,  
                 --ClkDvi=>Clk100,  
                   NewFrame=>NewDviFrame, ReqNewRow=>ReqNewRow,
                   FifoRd=>DviFifoRd, DataIn=>DviDat,
				   
				   PinTfpVs=>PinVSync, PinTfpHs=>PinHSync, PinTfpDe=>PinDe,
                   PinTfpClk=>PinClk, PinTfpDat=>PinDat, axeH => tH, axeV => tV);
				   
-- MODIF CYP				   
--uSimulacion : simulacion 
 --PORT MAP(
-----------------------------------------------CHANGEMENT AU 02/08/2021------------------------------	
--		clk                           => Clk50,
--        HLengthChoix  	=> HLengthChoix, --	Total number of pixel clocks in a row
--	  	HResChoix       	=>  HResChoix,		--	Horiztonal display width in pixels
--	  	HFPChoix 	   		 => HFPChoix,		--	Horiztonal front porch width in pixels
--	     HSyncPulseChoix    => 	HSyncPulseChoix,    --	Horiztonal sync pulse width in pixels
--	  	HBPChoix      		  	=>  HBPChoix,	--	Horiztonal back porch width in pixels
--	  	HPolSyncCHoix 		=> 	HPolSyncCHoix,										--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
--	    VLengthChoix 			=> 	VLengthChoix, --	Total number of pixel clocks in column
--	    VResChoix    		  	=>   VResChoix,		--	Vertical display width in pixels
--	  	VFPChoix 				=> 	VFPChoix,		--	Vertical front porch width in pixels
--	  	VSyncPulseChoix 	    =>	  VSyncPulseChoix,     --	Vertical sync pulse width in pixels
--	  	VBPCHoix           	    =>	  VBPCHoix,      --	Vertical back porch width in pixels
--	  	VPolSyncChoix   	    =>        VPolSyncChoix,		--	Vertical sync pulse polarity (1 = positive, 0 = negative)
--	    relojSistemaChoix 	=>      relojSistemaChoix,   ----- pixel_clock
--	    dataDispo            		=>   dataDispo,			-----------------pulse lecture
--		mireID                      =>     mireID--------------------mire choix
 --);
			 
			 
			 -------------------------------------------------------DCS8				  
--uDCS8 : DCS  
--GENERIC MAP( DCSMODE =>"POS"  )
--PORT MAP( CLK0 => Clk34,   CLK1  => CLk25,    SEL  => Selection(8),    DCSOUT => salida8 ); 				  
				  
-------------------------------------------------------DCS7				  
--uDCS7 : DCS  
--GENERIC MAP( DCSMODE =>"POS"  )
--PORT MAP( CLK0 => salida5,   CLK1  => salida6,    SEL  => Selection(7),    DCSOUT => relojSistema ); 				  
				  
-------------------------------------------------------DCS6					  
--uDCS5 : DCS  
--GENERIC MAP( DCSMODE =>"POS"  )
--PORT MAP( CLK0 => salida3,   CLK1  => salida4,    SEL  => Selection(5),    DCSOUT => relojSistema ); 

-------------------------------------------------------DCS5				  
--uDCS4: DCS  
--GENERIC MAP( DCSMODE =>"POS"  )
--PORT MAP( CLK0 => salida2,   CLK1  => Clk25,    SEL  => Selection(4),    DCSOUT => salida4 ); 

-------------------------------------------------------DCS4				  
--uDCS3: DCS  
--GENERIC MAP( DCSMODE =>"POS"  )
--PORT MAP( CLK0 => salida0,   CLK1  => salida1,    SEL  => Selection(3),    DCSOUT => salida3); 

-------------------------------------------------------DCS3			  
--uDCS2: DCS  
--GENERIC MAP( DCSMODE =>"POS"  )
--PORT MAP( CLK0 => Clk40,   CLK1  => Clk34,    SEL  => Selection(2),    DCSOUT => salida2 ); 

-----------------------------------------------------DCS2			  
uDCS1: DCS  
GENERIC MAP( DCSMODE =>"POS"  )
PORT MAP( CLK0 => Clk80,   CLK1  => salida0,    SEL  => Selection,    DCSOUT => salida1 ); 

-----------------------------------------------------DCS1			  
uDCS0: DCS  
GENERIC MAP( DCSMODE =>"POS"  )
PORT MAP( CLK0 => Clk140,   CLK1  => Clk100,    SEL  => Selection,    DCSOUT => salida0 ); 


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MIRES COMPONENT 
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
umires : mires port map (
 --Clk100 => Clk100,
 Clk100 => relojSistema,
 tH => tH,
 tV=> tV,                
 NewDviFrame => NewDviFrame,
 ReqNewRow => ReqNewRow,
 DviFifoRd => DviFifoRd,
 SRst => SRst,
 --change =>change,
 --resolutionChoix  => resolutionChoix,
 choixMire => choixMire,
 HContador => HContador, 
 HVertical=>HVertical,
 DatRGB => DviDat);
 
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
-----------------------HORLOGE DE 1HZ-----------------------------------------
  --PROCESS (Clk50)
 --variable sumatoria : integer range 0 to 50000000;
 --BEGIN
 --IF (Clk50'EVENT AND Clk50='1') THEN
 	
		--if(sumatoria < 50000000) then
		--sumatoria := sumatoria + 1;
		--else 
		--sumatoria := 0;
		--Reloj1hz <= NOT Reloj1hz;
		--end if;	
 --END IF;
 --END PROCESS;



--pSIMULACIONpulso: process (dataDispo)
--pSIMULACIONpulso: process (relojSistemaChoix)

--begin
 -- if dataDispo'event and dataDispo='1' then
   -- if rising_edge(dataDispo) then
  
       HLength				<=   HLengthChoix;   --	Total number of pixel clocks in a row
	 	HRes					<=  HResChoix;--	Horiztonal display width in pixels
	 	HFP						<=  HFPChoix;	--	Horiztonal front porch width in pixels
	  HSyncPulse	 		<= HSyncPulseChoix;--	Horiztonal sync pulse width in pixels
	 	HBP			         	<= HBPChoix;	--	Horiztonal back porch width in pixels
	 	HPolSync				<= HPolSyncCHoix;--	Horizontal sync pulse polarity (1 = positive, 0 = negative)		
	  VLength	 		     	<=  VLengthChoix;--	Total number of pixel clocks in column
	  VRes				        <= VResChoix; --	Vertical display width in pixels
	 	VFP		               	<= VFPCHoix;				--	Vertical front porch width in pixels
	 	VSyncPulse	   	   	<=	VSyncPulseChoix;--	Vertical sync pulse width in pixels
	 	VBP			            <= 	VBPChoix;  --	Vertical back porch width in pixels
	 	VPolSync	            <= VPolSyncChoix; --	Vertical sync pulse polarity (1 = positive, 0 = negative)
		choixMire  			<=  mireID;
		
		
		--pSIMULACIONpulso: process (relojSistemaChoix)
--begin
				--if  (relojSistemaChoix = X"2" ) 	then 
				--Selection  <=   '0';	
				--elsif  (relojSistemaChoix = X"9" ) 	then 
				--Selection <= '1';
				--end if;			
 --end process pSIMULACIONpulso;
				
								
			
			relojSistema <= Clk25 when relojSistemaChoix = X"0" else
									  Clk34  when relojSistemaChoix = X"1" else
									  Clk40   when relojSistemaChoix = X"2" else
			                            Clk60   when relojSistemaChoix = X"3" else
									  Clk70    when relojSistemaChoix = X"4" else
									  Clk80    when relojSistemaChoix = X"5" else
									  Clk100   when relojSistemaChoix = X"6" else
									  Clk120   when relojSistemaChoix = X"7" else
									  Clk140   when relojSistemaChoix = X"8" else
									  Clk159    when relojSistemaChoix = X"9";
									  
		--if  (relojSistemaChoix = X"0" ) 	then
		 --Selection <= "110000";
		----Selection <= "111000000";  ----------reloj  0
		
		--elsif (relojSistemaChoix = X"1" ) then
			--Selection <="101000";
		----Selection <= "011000000";
		
		--elsif (relojSistemaChoix = X"2" ) then
		   --Selection <= "100000";
		----Selection <= "010010000";
		
		--elsif (relojSistemaChoix = X"3" ) then
		----  Selection <= "
		----Selection <= "010000000";
		
		--elsif (relojSistemaChoix = X"4" ) then
		----Selection <= "000101000";
		
		--elsif (relojSistemaChoix = X"5" ) then
		----Selection <= "000100000";
		
			--elsif (relojSistemaChoix = X"6" ) then
		----Selection <= "000000110";
		
			--elsif (relojSistemaChoix = X"7" ) then
		----Selection <= "000000100";
		
			--elsif (relojSistemaChoix = X"8" ) then
		----Selection <= "000000001";
		
			--elsif (relojSistemaChoix = X"9" ) then
		----Selection <= "000000000";	
		--end if; 
		

			
			 --if (relojSistemaChoix = X"0" ) then 	
				--relojSistema    		<=    Clk25;			
			--elsif  (relojSistemaChoix = X"1" ) 	then 
				--relojSistema    		<=    Clk34;	 
		    --elsif  (relojSistemaChoix = X"2" ) 	then 
				--relojSistema    		<=    Clk40;				
			--elsif  (relojSistemaChoix = X"3" ) 	then 
				--relojSistema    		<=    Clk60;	
			--elsif  (relojSistemaChoix = X"4" ) 	then 
				--relojSistema    		<=    Clk70;	
			--elsif  (relojSistemaChoix = X"5" ) 	then 
				--relojSistema    		<=    Clk80;			
			--elsif  (relojSistemaChoix = X"6" ) 	then 
				--relojSistema    		<=    Clk100;
			--elsif  (relojSistemaChoix = X"7" ) 	then 
				--relojSistema    		<=    Clk120;
			--elsif  (relojSistemaChoix = X"8" ) 	then 
				--relojSistema    		<=    Clk140;			
			--elsif  (relojSistemaChoix = X"9" ) 	then 
				--relojSistema    		<=    Clk159;								
			--end if;
 --end process pSIMULACIONpulso;



-- relojSistema    <=    Clk25;          
---------------------------------------------------------------------------------------------------------------
-----------------------ELECCION DE LA MI
----------------------------------------------------------------------------------------------------------------
--process (Reloj1hz)
 --variable temporizador : integer range 0 to 30;
  --BEGIN
 --if(rising_edge(Reloj1Hz)) then

		--if(temporizador < 30 ) then
		 	--temporizador := temporizador + 1;		 	
				--if (temporizador < 15) then
			 --resolutionChoix <= X"0"; --	choixMire<= X"1";
				--else 
			 --resolutionChoix<= X"1"; --choixMire<= X"0";
				--end if;
		--else 
		--temporizador :=0;
		--end if;
--end if;
--end process;
 ----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------		
--resolutionChoix <= X"1";
---------------------------------------------------------------------------------------------------------------
-----------------------ELECCION DE LA RESOLUCION--------------------------------------------
------------------------------------------------------------------------------------------------------------------
--process (Reloj1hz)
 --variable temporizador : integer range 0 to 60;
  --BEGIN
 --if(rising_edge(Reloj1Hz)) then

		--if(temporizador < 60 ) then
		 	--temporizador := temporizador + 1;		 	
			--if (temporizador < 30) then
			
			
			
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
-----------------------ELECCION DE LA RESOLUCION------------------------------------------------
-----------------------------------------------------------------------------------------------------------------				
			--PROCESS(resolutionChoix)
			--BEGIN 
			
			--if (resolutionChoix = X"0" ) then 	
			
			
		----	change <= '1';
			--HLengthChoix  	<=  HLength2;
		    --HResChoix  			<=      HRes2;
		    --HFPChoix 			<=  HFP2;
	        --HSyncPulseChoix  <=  HSyncPulse2;
	     	--HBPChoix      		<=     HBP2;
	        --HPolSyncCHoix   	<= HPolSync2;	
	       --VLengthChoix 		<=   VLength2;
	        --VResChoix         	<=   VRes2;
	     	--VFPChoix 			<=   VFP2;
	 	   --VSyncPulseChoix 	<= VSyncPulse2;
	 	   --VBPCHoix            	<=   VBP2;
	    	--VPolSyncChoix   	<=   VPolSync2;
			----Selection <= '1';
	       --relojSistema    		<=    Clk25;			
		   
				--elsif  (resolutionChoix = X"1" ) 	then 
				
		----change <= '1';	
			--HLengthChoix  	<=  HLength1;
		    --HResChoix  			<=      HRes1;
		    --HFPChoix 			<=  HFP1;
	        --HSyncPulseChoix     	<=  HSyncPulse1;
	     	--HBPChoix      		<=     HBP1;
	        --HPolSyncCHoix   	<= HPolSync1;	
	       --VLengthChoix 		<=   VLength1;
	        --VResChoix         	<=   VRes1;
	     	--VFPChoix 			<=   VFP1;
	 	   --VSyncPulseChoix 	<= VSyncPulse1;
	 	   --VBPCHoix            	<=   VBP1;
	    	--VPolSyncChoix   	<=   VPolSync1;
			----Selection <= '0';
	       --relojSistema    		<=    Clk100;	   
				--end if;
				--END PROCESS;
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------		
--PinTfpClkP <= Clk100;
--PinTfpClkN <= not (Clk100); --volver a esto si no funciona


PinTfpClkP <= relojSistema;

PinTfpClkN <= not (relojSistema);


--uVGA : vga GENERIC MAP(
 --Ha => 96, --Hpulse
 --Hb => 144, --Hpulse+HBP
 --Hc => 784, --Hpulse+HBP+Hactive
 --Hd => 800, --Hpulse+HBP+Hactive+HFP
 --Va => 2, --Vpulse
 --Vb => 35, --Vpulse+VBP
 --Vc => 15, --Vpulse+VBP+Vactive
  --Vd =>525) --Vpulse+VBP+Vactive+VFP
 --PORT MAP (clk => Clk50, pixel_clk=>PinClk,Hsync=>PinHSync, Vsync=>PinVSync, DataRGB=> PinDat, dena2=>PinDe);



 ---Generate DVI data


--pGenMire: process (relojSistema)

--variable Horizontal : integer;
--variable Vertical : integer;
--variable intHCnt :integer;
--variable intVCnt : integer;

--variable halfHorizontal : integer;

--begin

  --if relojSistema'event and relojSistema='1' then
  
    --if SRst = '1' then
      --FCnt <= (others => '0');
    --elsif NewDviFrame = '1' then    --NewDviFrame == dvi_nf0
      --FCnt <= FCnt + '1';
    --end if;
	
    --if NewDviFrame = '1' then
      --VCnt <= (others => '0'); -- devuelve a cero
    --elsif ReqNewRow = '1' then 
      --VCnt <= VCnt + '1';
    --end if;
	
	
    --if ReqNewRow = '1' then
      --HCnt <= (others => '0');
    --elsif DviFifoRd = '1' then                --senial importante que viene de DVI410TIming
      --HCnt <= HCnt + '1';
    --end if;
	
	------------creacion de integers
	--intHCnt := to_integer(unsigned(HCnt));
	--intVCnt := to_integer(unsigned(VCnt));
	-----------------------------------------------------------
	--Horizontal := to_integer(unsigned(tH));
	--halfHorizontal :=  Horizontal / 2; 
	---------------------------------------------------
	--if intHCnt <= halfHorizontal then
	--DatR <= X"00";
	--DatG <= X"22";
	--DatB <= X"90";
	--else 
	--DatR <= X"E6";
	--DatG <= X"28";
	--DatB <= X"37";
	--end if;
	
    --DviDat <= DatR & DatG & DatB;
  --end if;
  
  
--end process pGenMire;



end rtl;

