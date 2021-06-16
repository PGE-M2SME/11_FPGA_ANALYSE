library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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

type etat is (init, envoie, reception1, reception2, reception3, reception4, reception5, reception6, reception7, reception8, reception9, reception10, reception11, reception12,
  reception13, reception14, reception15, reception16, reception17, reception18, reception19, reception20, reception21, reception22,
 attente1, attente2, attente3, attente4, attente5, attente6, attente7, attente8, attente9, attente10, attente11, attente12, attente13, attente14, attente15, attente16, attente17,
  attente18, attente19, attente20, attente21, attente22 );

signal etat_present, etat_suivant : etat := init;

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

signal duree : std_logic_vector(3 downto 0);
signal erreur : std_logic;
signal fin_recep : std_logic;
signal fin_envoie : std_logic;

begin

process(clk)
begin
if clk'event and clk='1' then
	etat_present <= etat_suivant;
	if data_valid_out = '0' then
	duree <= duree+1;
	else
	duree <= "0000";
	end if;
end if;
end process;

process(etat_present, erreur, data_valid_out, fin_recep, fin_envoie)
begin
case etat_present is 

	when init =>	if data_valid_out='1' then
					etat_suivant <= reception1;
					else
					etat_suivant <= init;
					end if;
					
	when reception1 =>	if data_valid_out='0' then
						etat_suivant <= attente1;						
						else
						etat_suivant <= reception1;
						end if;
						
	when reception2 =>	if data_valid_out='0' then
						etat_suivant <= attente2;
						else
						etat_suivant <= reception2;
						end if;
						
	when reception3 =>	if data_valid_out='0' then
						etat_suivant <= attente3;
						else
						etat_suivant <= reception3;
						end if;
						
	when reception4 =>	if data_valid_out='0' then
						etat_suivant <= attente4;
						else
						etat_suivant <= reception4;
						end if;
						
	when reception5 =>	if data_valid_out='0' then
						etat_suivant <= attente5;
						else
						etat_suivant <= reception5;
						end if;
						
	when reception6 =>	if data_valid_out='0' then
						etat_suivant <= attente6;
						else
						etat_suivant <= reception6;
						end if;
						
	when reception7 =>	if data_valid_out='0' then
						etat_suivant <= attente7;
						else
						etat_suivant <= reception7;
						end if;
						
	when reception8 =>	if data_valid_out='0' then
						etat_suivant <= attente8;
						else
						etat_suivant <= reception8;
						end if;
						
	when reception9 =>	if data_valid_out='0' then
						etat_suivant <= attente9;
						else
						etat_suivant <= reception9;
						end if;
						
	when reception10 =>	if data_valid_out='0' then
						etat_suivant <= attente10;
						else
						etat_suivant <= reception10;
						end if;
						
	when reception11 =>	if data_valid_out='0' then
						etat_suivant <= attente11;
						else
						etat_suivant <= reception11;
						end if;
						
	when reception12 =>	if data_valid_out='0' then
						etat_suivant <= attente12;
						else
						etat_suivant <= reception12;
						end if;
						
	when reception13 =>	if data_valid_out='0' then
						etat_suivant <= attente13;
						else
						etat_suivant <= reception13;
						end if;
						
	when reception14 =>	if data_valid_out='0' then
						etat_suivant <= attente14;
						else
						etat_suivant <= reception14;
						end if;
						
	when reception15 =>	if data_valid_out='0' then
						etat_suivant <= attente15;
						else
						etat_suivant <= reception15;
						end if;
						
	when reception16 =>	if data_valid_out='0' then
						etat_suivant <= attente16;
						else
						etat_suivant <= reception16;
						end if;
						
	when reception17 =>	if data_valid_out='0' then
						etat_suivant <= attente17;
						else
						etat_suivant <= reception17;
						end if;
						
	when reception18 =>	if data_valid_out='0' then
						etat_suivant <= attente18;
						else
						etat_suivant <= reception18;
						end if;
						
	when reception19 =>	if data_valid_out='0' then
						etat_suivant <= attente19;
						else
						etat_suivant <= reception19;
						end if;
						
	when reception20 =>	if data_valid_out='0' then
						etat_suivant <= attente20;
						else
						etat_suivant <= reception20;
						end if;
						
	when reception21 =>	if data_valid_out='0' then
						etat_suivant <= attente21;
						else
						etat_suivant <= reception21;
						end if;
						
	when reception22 =>	if data_valid_out='0' then
						etat_suivant <= attente22;
						else
						etat_suivant <= reception22;
						end if;
						
	when attente1 =>	if data_valid_out='1' then
						etat_suivant <= reception2;
						elsif erreur='1' then
						etat_suivant <= init;
						else
						etat_suivant <= attente1;
						end if;
						
	when attente2 =>	if data_valid_out='0' then
						etat_suivant <= reception3;
						elsif erreur='1' then
						etat_suivant <= init;
						else
						etat_suivant <= attente2;
						end if;
						
	when attente3 =>	if data_valid_out='1' then
						etat_suivant <= reception4;
						elsif erreur='1' then
						etat_suivant <= init;
						else
						etat_suivant <= attente3;
						end if;
						
	when attente4 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception5;
						else
						etat_suivant <= attente4;
						end if;
						
	when attente5 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception6;
						else
						etat_suivant <= attente5;
						end if;
						
	when attente6 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception7;
						else
						etat_suivant <= attente6;
						end if;
						
	when attente7 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='0' then
						etat_suivant <= reception8;
						else
						etat_suivant <= attente7;
						end if;
						
	when attente8 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception9;
						else
						etat_suivant <= attente8;
						end if;
						
	when attente9 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception10;
						else
						etat_suivant <= attente9;
						end if;
						
	when attente10 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception11;
						else
						etat_suivant <= attente10;
						end if;
						
	when attente11 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception12;
						else
						etat_suivant <= attente11;
						end if;
						
	when attente12 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception13;
						else
						etat_suivant <= attente12;
						end if;
						
	when attente13 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception14;
						else
						etat_suivant <= attente13;
						end if;
						
	when attente14 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception15;
						else
						etat_suivant <= attente14;
						end if;
						
	when attente15 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception16;
						else
						etat_suivant <= attente15;
						end if;
						
	when attente16 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception17;
						else
						etat_suivant <= attente16;
						end if;
						
	when attente17 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception18;
						else
						etat_suivant <= attente17;
						end if;
						
	when attente18 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception19;
						else
						etat_suivant <= attente18;
						end if;
						
	when attente19 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception20;
						else
						etat_suivant <= attente19;
						end if;
						
	when attente20 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception21;
						else
						etat_suivant <= attente20;
						end if;
						
	when attente21 =>	if erreur='1' then
						etat_suivant <= init;
						elsif data_valid_out='1' then
						etat_suivant <= reception22;
						else
						etat_suivant <= attente21;
						end if;
						
	when attente22 =>	if fin_recep='1' then
						etat_suivant <= envoie;
						elsif erreur='1' then
						etat_suivant <= init;
						else
						etat_suivant <= attente22;
						end if;
						
	when envoie =>		if fin_envoie = '1' then
						etat_suivant <= init;
						else 
						etat_suivant <= envoie;
						end if;
					
end case;
end process;

process(clk, etat_present, data_out, data_valid_out, duree, erreur, fin_recep, fin_envoie,
iHLength, iHRes, iHFP, iHSyncPulse, iHBP, iHPolSync, iVLength, iVRes, iVFP, iVSyncPulse, iVBP, iVPolSync, iPClock, iMire_ID)
begin
case etat_present is

	when init => 	data_dispo <= '0';
					HLength <= "000000000000";
					HRes <= "000000000000";
					HFP <= "00000000";
					HSyncPulse <= "00000000";
					HBP <= "000000000";
					HPolSync <= '0';
					VLength <= "000000000000";
					VRes <= "000000000000";
					VFP <= "0000";
					VSyncPulse <= "0000";
 					VBP <= "000000";
					VPolSync <= '0';
					PClock <= "0000";
					Mire_ID <= "0000";
	
	when reception1 => 	nb_octets <= data_out;
	when reception2 => 	id_sys <= data_out;
	when reception3 => 	id_cmd <= data_out;
	when reception4 => 	iHLength(11 downto 4) <= data_out;
	when reception5 => 	iHLength(3 downto 0) <= data_out(7 downto 4);
	when reception6 => 	iHRes(11 downto 4) <= data_out;
	when reception7 => 	iHRes(3 downto 0) <= data_out(7 downto 4);
	when reception8 => 	iHFP <= data_out;
	when reception9 => 	iHSyncPulse <= data_out;
	when reception10 => iHBP(8 downto 1) <= data_out;
	when reception11 => iHBP(0) <= data_out(7);
	when reception12 => iHPolSync <= data_out(0);
	when reception13 => iVLength(11 downto 4) <= data_out;
	when reception14 => iVLength(3 downto 0) <= data_out(7 downto 4);
	when reception15 => iVRes(11 downto 4) <= data_out;
	when reception16 => iVRes(3 downto 0) <= data_out(7 downto 4);
	when reception17 => iVFP <= data_out(3 downto 0);
	when reception18 => iVSyncPulse <= data_out(3 downto 0);
	when reception19 => iVBP <= data_out(5 downto 0);
	when reception20 => iVPolSync <= data_out(0);
	when reception21 => iPClock <= data_out(3 downto 0);
	when reception22 => iMire_ID <= data_out(3 downto 0); fin_recep<='1';
	
	when attente1 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente2 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente3 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente4 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente5 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente6 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente7 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente8 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente9 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente10 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente11 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente12 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente13 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente14 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente15 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente16 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente17 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente18 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente19 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente20 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente21 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	when attente22 =>		if duree = "1111" then erreur <= '1'; else erreur <='0'; end if;
	
	
	

	
	when envoie =>	HLength <= iHLength;
					HRes <= iHres;
					HFP <= iHFP;
					HSyncPulse <= iHSyncPulse;
					HBP <= iHBP;
					HPolSync <= iHPolSync;
					VLength <= iVLength;
					VRes <= iVres;
					VFP <= iVFP;
					VSyncPulse <= iVSyncPulse;
					VBP <= iVBP;
					VPolSync <= iVPolSync;
					PClock <= iPClock;
					Mire_ID <= iMire_ID;
	
					data_dispo <= '1';
					fin_envoie <= '1';

end case;
end process;


end arch;