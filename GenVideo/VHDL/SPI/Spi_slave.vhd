library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
           
entity Spi_slave is
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
end Spi_slave;

architecture ar of Spi_slave  is 

component SPI_in is     			                -- This component take MOSI in input and the byte receive in output
  port(
       clk, input : in std_logic;					-- clk = clock coming from master, input bit receive from the master (MOSI)
       data_out : out std_logic_vector(7 downto 0); -- octet receive
       data_valid : out std_logic; 					-- the byte has been receive
       SS  : in std_logic					 		-- active(low) when the master send a byte
       );
end component;

component SPI_out is				                 -- This component take a byte in input and send it to the master bit to bit in output
  port(
       clk : in std_logic;							 -- clock 
       SS : out std_logic;							 -- active when we send a byte by MISO
       data_valid : in std_logic;				     -- the byte in input is complete we are ready to send
       data_in : in std_logic_vector (7 downto 0);   -- send octet when active (active high), must be active when sending
       output : out std_logic     					 -- send the byte bit to bit
       );
end component;

signal mosi_sig : std_logic;


begin

C1 : SPI_in port map(SCLK , MOSI, Data_out, Data_valid_out, SS); 

C2 : SPI_out port map(SCLK, SS_out, Data_valid_in, Data_in, MISO);  
											   										  
end ar;