library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity decodage_generation is
port (	PClock : out std_logic_vector(3 downto 0);
		Mire_ID : out std_logic_vector(3 downto 0);
		data_dispo : out std_logic;
		HLength : out std_logic_vector(11 downto 0);
		HRes : out std_logic_vector(11 downto 0);
		HFP : out std_logic_vector(7 downto 0);
		HSyncPulse : out std_logic_vector(7 downto 0);
		HBP : out std_logic_vector(8 downto 0);
		HPolSync : out std_logic;
		VLength : out std_logic_vector(11 downto 0);
		VRes : out std_logic_vector(11 downto 0);
		VFP : out std_logic_vector(3 downto 0);
		VSyncPulse : out std_logic_vector(3 downto 0);
		VBP : out std_logic_vector(5 downto 0);
		VPolSync : out std_logic;
		data_out : in std_logic_vector (7 downto 0);
		data_valid_out : in std_logic;
		clk : in std_logic
		);
end decodage_generation;

architecture arch of decodage_generation is


signal nb_octets : std_logic_vector(7 downto 0);
signal id_sys : std_logic_vector(7 downto 0);
signal id_cmd : std_logic_vector(7 downto 0);
signal iPClock : std_logic_vector(3 downto 0);
signal iMire_ID : std_logic_vector(3 downto 0);
signal idata_dispo : std_logic:='0';
signal iHLength : std_logic_vector(11 downto 0);
signal iHRes : std_logic_vector(11 downto 0);
signal iHFP : std_logic_vector(7 downto 0);
signal iHSyncPulse : std_logic_vector(7 downto 0);
signal iHBP : std_logic_vector(8 downto 0);
signal iHPolSync : std_logic:='0';
signal iVLength : std_logic_vector(11 downto 0);
signal iVRes : std_logic_vector(11 downto 0);
signal iVFP : std_logic_vector(3 downto 0);
signal iVSyncPulse : std_logic_vector(3 downto 0);
signal iVBP : std_logic_vector(5 downto 0);
signal iVPolSync : std_logic:='0';


-- Front montant 
signal ddata_valid_out , FrontH : std_logic ;  


-- MEF EMISSION SIGNALS

signal  cpt  : std_logic_vector ( 7 downto 0);
signal cptRST : std_logic_vector (11 downto 0) := X"000";
signal Rst : std_logic;

Type etats is (etat1,etat2,etat3,etat4,etat5,etat6,etat7,etat8,etat9,etat10,etat11,etat12,etat13,etat14,etat15,etat16,etat17,etat18,etat19,etat20,etat21,etat22,  init );
signal EtatPresent : etats;
signal EtatSuivant : etats; 


begin



				 
				 
				 EtatSuivant  <=
				 
				 
				  etat1 when ( Cpt  = "00000001") else 
				  etat2  when  ( Cpt  = "00000010")  else 
				  etat3  when   ( Cpt  = "00000011")  else 
				  etat4  when   ( Cpt  = X"04")  else 
				  etat5  when  ( Cpt  = X"05")  else 
				  etat6  when  ( Cpt  = X"06")  else 
				  etat7  when  ( Cpt  = X"07")  else 
				  etat8  when  ( Cpt  = X"08")  else 
				  etat9  when   ( Cpt  = X"09")  else 
				  etat10  when   ( Cpt  = X"0A")  else 
				  etat11  when    ( Cpt  = X"0B")  else 
				  etat12  when   ( Cpt  = X"0C")  else 
				  etat13  when    ( Cpt  = X"0D")  else 
				  etat14  when   ( Cpt  = X"0E")  else 
				  etat15  when  ( Cpt  = X"0F")  else 
				  etat16  when  ( Cpt  = X"10")  else 
				  etat17  when   ( Cpt  = X"11")  else 
				  etat18  when   ( Cpt  = X"12")  else 
				  etat19  when   ( Cpt  = X"13")  else 
				  etat20  when   ( Cpt  = X"14")  else 
				  etat21  when   ( Cpt  = X"15")  else
				  etat22  when  ( Cpt  = X"16")  else	
				  
				 			  
				  
				 EtatPresent;
				 
				 
				 
 nb_octets <= data_out when ( Cpt  = "00000001");
 id_sys <= data_out  when ( Cpt  = "00000010");
 id_cmd <= data_out  when  ( Cpt  = "00000011");
 iPClock <= data_out( 3 downto 0) when ( Cpt  = X"04");
 iMire_ID <= data_out( 3 downto 0) when ( Cpt  = X"05") ;
 iHLength(7 downto 0) <= data_out when ( Cpt  = X"06");
 iHLength(11 downto 8) <= data_out(3 downto 0) when ( Cpt  = X"07");
 iHRes(7 downto 0) <= data_out when ( Cpt  = X"08");
 iHRes(11 downto 8) <= data_out(3 downto 0) when( Cpt  = X"09");
 iHFP <= data_out when( Cpt  = X"0A");
 iHSyncPulse <= data_out when( Cpt  = X"0B");
 iHBP(7 downto 0) <= data_out when ( Cpt  = X"0C");
 iHBP(8) <= data_out(0) when( Cpt  = X"0D");
 iHPolSync <= data_out(0) when ( Cpt  = X"0E");
 iVLength(7 downto 0) <= data_out when ( Cpt  = X"0F");
 iVLength(11 downto 8) <= data_out(3 downto 0) when ( Cpt  = X"10");
 iVRes(7 downto 0) <= data_out when ( Cpt  = X"11");
 iVRes(11 downto 8) <= data_out(3 downto 0) when ( Cpt  = X"12");
 iVFP <= data_out( 3 downto 0) when ( Cpt  = X"13");
 iVSyncPulse <= data_out( 3 downto 0) when ( Cpt  = X"14");
 iVBP <= data_out(5 downto 0)  when( Cpt  = X"15");
 iVPolSync <= data_out(0) when ( Cpt  = X"16");


 

 PClock <=iPClock;
 Mire_ID <=iMire_ID;
 HLength <= iHLength;
 HRes <= iHRes;
 HFP <= iHFP;
 HSyncPulse <= iHSyncPulse;
 HBP <=  iHBP;
 HPolSync <= iHPolSync;
 VLength <= iVLength;
 VRes <= iVRes;
 VFP <= iVFP;
 VSyncPulse <= iVSyncPulse ;
 VBP <= iVBP;
 VPolSync <= iVPolSync;




Process(Clk )
Begin 
	if Clk'event and Clk = '1' then 
		EtatPresent <= EtatSuivant;

	 if ( FrontH = '1')  then 
	 
		cpt <= cpt + 1 ;
	 
	end if;
	if ( cpt >= X"16" )or ( RST = '1' )  then 
	
	cpt <= (others => '0');

	end if; 

	end if;

end process;

Process(Clk )
Begin 
	if Clk'event and Clk = '1' then 
	 
		cptRST <= cptRST  + 1 ;
	 

	if ( cptRST >= X"300" )  then 
	
	cptRST <=  X"200";

	end if; 
	
	if ( cptRST= X"150" )  then 
	
	RST <= '1';
	else 
	RST <= '0';

	end if; 

	end if;

end process;

PDetectH : process(clk)
begin
if clk'event and clk='1' then
	
	ddata_valid_out  <= data_valid_out;
	
	if ddata_valid_out = '0' and data_valid_out = '1' then 
	
		FrontH <= '1';
	else
	
		FrontH <= '0';

end if;
end if;

end process;

end arch;