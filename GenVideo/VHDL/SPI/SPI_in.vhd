library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
       
  entity SPI_in is     			            		-- This component take MOSI in input and the byte receive in output
  port(
       clk, input : in std_logic;					-- clk = clock coming from master, input bit receive from the master (MOSI)
       data_out : out std_logic_vector(7 downto 0); -- octet receive
       data_valid : out std_logic; 					-- the byte has been receive
       SS : in std_logic					 		-- active(low) when the master send a byte
       );
end SPI_in;

architecture ar of SPI_in is
  
  signal dataq : std_logic_vector(7 downto 0);
  
begin
  process(clk) 
	variable cpt : integer := 8;
  begin
     if clk'event and clk='0' then
		if (SS = '0') then						  
			
			dataq <= dataq(6 downto 0) & input;
			cpt := cpt - 1;
			if cpt = 0 then
				cpt := 8;
				
			end if;
		end if;
		if (SS = '1') then
			cpt := 8;
			
		end if;
	 end if;
  end process; 
  data_valid <= ss;
  data_out <= dataq;
end ar;