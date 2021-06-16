--
-- Synopsys
-- Vhdl wrapper for top level design, written on Thu Apr 15 15:25:16 2021
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity wrapper_for_Top is
   port (
      PinClk125 : in std_logic;
      PinPortRx : in std_logic;
      PinLedXv : out std_logic;
      PinPortTx : out std_logic;
      PinClk : out std_logic;
      PinVSync : out std_logic;
      PinHSync : out std_logic;
      PinDe : out std_logic;
      PinTfpClkP : out std_logic;
      PinTfpClkN : out std_logic;
      PinDat : out std_logic_vector(23 downto 0);
      PinSda : in std_logic;
      PinScl : out std_logic;
      SCLK : in std_logic;
      MOSI : in std_logic;
      SS : in std_logic;
      MISO : out std_logic;
      SS_out : out std_logic
   );
end wrapper_for_Top;

architecture rtl of wrapper_for_Top is

component Top
 port (
   PinClk125 : in std_logic;
   PinPortRx : in std_logic;
   PinLedXv : out std_logic;
   PinPortTx : out std_logic;
   PinClk : out std_logic;
   PinVSync : out std_logic;
   PinHSync : out std_logic;
   PinDe : out std_logic;
   PinTfpClkP : out std_logic;
   PinTfpClkN : out std_logic;
   PinDat : out std_logic_vector (23 downto 0);
   PinSda : inout std_logic;
   PinScl : out std_logic;
   SCLK : in std_logic;
   MOSI : in std_logic;
   SS : in std_logic;
   MISO : out std_logic;
   SS_out : out std_logic
 );
end component;

signal tmp_PinClk125 : std_logic;
signal tmp_PinPortRx : std_logic;
signal tmp_PinLedXv : std_logic;
signal tmp_PinPortTx : std_logic;
signal tmp_PinClk : std_logic;
signal tmp_PinVSync : std_logic;
signal tmp_PinHSync : std_logic;
signal tmp_PinDe : std_logic;
signal tmp_PinTfpClkP : std_logic;
signal tmp_PinTfpClkN : std_logic;
signal tmp_PinDat : std_logic_vector (23 downto 0);
signal tmp_PinSda : std_logic;
signal tmp_PinScl : std_logic;
signal tmp_SCLK : std_logic;
signal tmp_MOSI : std_logic;
signal tmp_SS : std_logic;
signal tmp_MISO : std_logic;
signal tmp_SS_out : std_logic;

begin

tmp_PinClk125 <= PinClk125;

tmp_PinPortRx <= PinPortRx;

PinLedXv <= tmp_PinLedXv;

PinPortTx <= tmp_PinPortTx;

PinClk <= tmp_PinClk;

PinVSync <= tmp_PinVSync;

PinHSync <= tmp_PinHSync;

PinDe <= tmp_PinDe;

PinTfpClkP <= tmp_PinTfpClkP;

PinTfpClkN <= tmp_PinTfpClkN;

PinDat <= tmp_PinDat;

tmp_PinSda <= PinSda;

PinScl <= tmp_PinScl;

tmp_SCLK <= SCLK;

tmp_MOSI <= MOSI;

tmp_SS <= SS;

MISO <= tmp_MISO;

SS_out <= tmp_SS_out;



u1:   Top port map (
		PinClk125 => tmp_PinClk125,
		PinPortRx => tmp_PinPortRx,
		PinLedXv => tmp_PinLedXv,
		PinPortTx => tmp_PinPortTx,
		PinClk => tmp_PinClk,
		PinVSync => tmp_PinVSync,
		PinHSync => tmp_PinHSync,
		PinDe => tmp_PinDe,
		PinTfpClkP => tmp_PinTfpClkP,
		PinTfpClkN => tmp_PinTfpClkN,
		PinDat => tmp_PinDat,
		PinSda => tmp_PinSda,
		PinScl => tmp_PinScl,
		SCLK => tmp_SCLK,
		MOSI => tmp_MOSI,
		SS => tmp_SS,
		MISO => tmp_MISO,
		SS_out => tmp_SS_out
       );
end rtl;
