library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_128x8_sync.vhd
  generic(
    WIDTH : integer := 8;
    DEPTH : integer := 7;
  )

  port (
    clock     : in std_logic;
    address   : in std_logic;
    data_out  : out std_logic(WIDTH -1 to 0);
  )
