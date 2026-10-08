library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.memory_types_pkg.all;

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

  signal ram_data_out : std_logic_vector(7 downto 0);
  signal rom_data_out : std_logic_vector(7 downto 0);

  begin 

    ROM_Inst : entity work.rom_128x8_sync
      port map (
        clock     => clock;
        address   => address;
        data_out  => rom_data_out
      );
      
    RAM_Inst : entity work.ram_128x8_syn
      port map (
          clock    => clock;
          address  => address;
          data_in  => data_in;
          WE       => write;
          data_out => ram_data_out
      );

    PORT_Inst : entity work. 

    MUX : process(address, ram_data_out, rom_data_out, port_in)
      begin
        -- ROM: 0x00 - 0x7F
        if (to_integer(unsigned(address)) >= 0) and
           (to_integer(unsigned(address)) <= 127) then

            data_out <= rom_data_out;


        -- RAM: 0x80 - 0xDF
        elsif (to_integer(unsigned(address)) >= 128) and
              (to_integer(unsigned(address)) <= 223) then

            data_out <= ram_data_out;


        -- INPUT PORTS: 0xF0 - 0xFF
        elsif address = x"F0" then
            data_out <= port_in(0);

        elsif address = x"F1" then
            data_out <= port_in(1);

        elsif address = x"F2" then
            data_out <= port_in(2);

        elsif address = x"F3" then
            data_out <= port_in(3);

        elsif address = x"F4" then
            data_out <= port_in(4);

        elsif address = x"F5" then
            data_out <= port_in(5);

        elsif address = x"F6" then
            data_out <= port_in(6);

        elsif address = x"F7" then
            data_out <= port_in(7);

        elsif address = x"F8" then
            data_out <= port_in(8);

        elsif address = x"F9" then
            data_out <= port_in(9);

        elsif address = x"FA" then
            data_out <= port_in(10);

        elsif address = x"FB" then
            data_out <= port_in(11);

        elsif address = x"FC" then
            data_out <= port_in(12);

        elsif address = x"FD" then
            data_out <= port_in(13);

        elsif address = x"FE" then
            data_out <= port_in(14);

        elsif address = x"FF" then
            data_out <= port_in(15);

        -- UNMAPPED ADDRESS
        else
            data_out <= (others => '0');
      
        end if;
    end process;

end memory_arch;
            
            

    


    
    
  
