library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.MNEMONICS.all 

entity ram_128x8_sync is 
  generic(
    WIDTH : integer := 8;
    DEPTH : integer := 224 --CONSTANT TO SCALE ADDRESSES 2^N OR 2^DEPTH 
  );

  port (
    clock     : in std_logic;
    address   : in std_logic_vector(integer(ceil(log2(real(DEPTH)))) -1 downto 0);
    data_in   : in std_logic_vector(WIDTH-1 to 0);
    data_out  : out std_logic(WIDTH-1 to 0)
  );
end entity;


architecture ram_128x8_sync_arch of ram_128x8_sync is 
  
    type RAM_ARRAY is array (128 to DEPTH -1) of std_logic_vector(WIDTH-1 downto 0)

    --ADDRESS AND CLOCK BOTH ENTER MEMORY. NEED SEPARATE PROCESSES

    signal EN : std_logic;
    -- RW signal to handle data 
    signal RW : RAM_ARRAY; 
                             
    begin      

    ADDRESS : process(address)
      begin
        if (to_integer(unsigned(address)) >= 128) and (to_integer(unsigned(address)) <= 223) then 
          EN <= '1';
        else
          EN <= '0';
        end if; 
    end process; 

    MEMORY : process(clock)
        begin 
          if(rising_edge(clock)) then
            if (EN = '1') then 
              data_out <= ROM(to_integer(unsigned(address)));
            end if;
          end if; 
    end process;
            
end architecture; 
  
  



