library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity rom_128x8_sync is 
  generic(
    WIDTH : integer := 8;
    DEPTH : integer := 128 --CONSTANT TO SCALE ADDRESSES 2^N OR 2^DEPTH 
  );

  port (
    clock     : in std_logic;
    address   : in std_logic_vector(integer(ceil(log2(real(DEPTH)))) -1 downto 0);
    data_out  : out std_logic(WIDTH-1 to 0)
  );
end entity;


architecture rom_128x8_sync_arch of rom_128x8_sync is 
  
    type ROM_ARRAY is array (0 to DEPTH -1) of std_logic_vector(WIDTH-1 downto 0)

    -- THIS IS PROGRAM MEMORY, YOU CAN PUT WHATEVER INSTRUCTIONS YOU WANT TO RUN SPECIFIC OPERATION. MAKE SURE TO BRANCH TO TOP 
    const ROM : ROM_ARRAY :=  ( 0       =>   
                                1       =>
                                2       =>
                                3       =>
                                4       => BRA,
                                5       => x"00",
                                others  => x"00");
    
    --ADDRESS AND CLOCK BOTH ENTER MEMORY. NEED SEPARATE PROCESSES

    signal EN : std_logic;
                             
    begin      

    ADDRESS : process(address)
      begin
        if (to_integer(unsigned(address)) >= 0) and (to_integer(unsigned(address)) <= 127) then 
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
  
  



