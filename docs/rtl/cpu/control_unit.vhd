library ieee;
use ieee.std_logic_1164.all;

entity data_path is 
  port (
    Clock : in std_logic;
    Reset:  out std_logic    
  );
end data_path;

architecture data_path_arch of data_path is 
  --declarations 
  signal BUS1: std_logic_vector(7 downto 0);
  signal BUS2: std_logic_vector(7 downto 0);

  begin 

    INSTRUCTION_REGISTER: process(Clock, Reset):
      begin
        if (Reset = '0') then 
          IR <= x"00";
        elsif (rising_edge(clock)) then 
          --CONTROL UNIT SIGNAL FROM SEPARATE FILE (control_unit.vhd)
          if (IR_Load = "1") then 
            --GIVE IR THE DATA ON BUS2
            IR <= Bus2;
           end if;
        end if;
    end process; 

