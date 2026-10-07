library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is 
  port (
    address  : in std_logic_vector(7 downto 0);
    data_in  : in std_logic_vector(7 downto 0);
    write    : in std_logic; 
    data_out : out std_logic_vector(7 downto 0);
    clock    : in std_logic;
    reset    : in std_logic; 
    -----Represent Port as a vector and then slice them when modeling behavior and instantiating entities-------
    port_in  : in port_array;
    port_out : out port_array
  );
end memory;

architecture memory_arch of memory is 
  --declarations
  --create a array of 16 ports, each with 8 bits of std_logic
  type port_array is array(0 to 15) of std_logic_vector(7 downto 0);
  
  --we can then create a signal for both port in and port out
    signal port_array_in  := port_array;
    signal port_array_out := port_array;

    signal ram_data_out := data_out;
    signal rom_data_out := data_out;

    ram_data_out <= data_out;
    rom_data_out <= data_out;

    port_in  <= port_array_in;
    port_out <= port_array_out;

  begin 

    ROM_Inst : entity work.rom_128x8_sync
      port map (
        clock     => clock;
        address   => address;
        data_out  => data_out
      );
      
    RAM_Inst : entity work.ram_128x8_syn
      port map (
          clock    => clock;
          address  => address;
          data_in  => data_in;
          WE       => write;
          data_out => ram_data
      );

      MUX: process(address, ram_data_out, rom_data_out, port_in)
        begin 
          case(address) is
            when (to_integer(unsigned(address)) >= 0) and
                 (to_integer(unsigned(address)) <= 127) =>
                  data_out = rom_data_out;

            when (to_integer(unsigned(address)) >= 128) and
                 (to_integer(unsigned(address)) <= 223) =>
                  data_out = ram_data_out;

            when (address = x"F0") => port_in(0);
                  (address = x"FF") => port_in(15);
          end case;
       end process;
        

            
            

    


    
    
  
