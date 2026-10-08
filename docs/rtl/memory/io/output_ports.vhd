-------------------------------------------
-- Description: Each output port in the
-- computer system is assigned a unique
-- address. Each output port also contains
-- storage capability. This allows the CPU
-- to update an output port by writing to
-- its specific address.
--
-- Once the CPU stores a value to an output
-- port address, the output holds that value
-- until the CPU writes to that port again.
-------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.memory_types_pkg.all;

entity PORTS is 
  generic (
    WIDTH : integer := 8
  );
  port (
    address  : in  std_logic_vector(WIDTH - 1 downto 0);
    clock    : in  std_logic;
    reset    : in  std_logic;
    write    : in  std_logic;
    data_in  : in  std_logic_vector(WIDTH - 1 downto 0);
    port_out : out port_array
  );
end PORTS;


architecture PORTS_arch of PORTS is

begin

  -- PORT 0: Address 0xE0
  U0 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(0) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E0" and write = '1' then
        port_out(0) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 1: Address 0xE1
  U1 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(1) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E1" and write = '1' then
        port_out(1) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 2: Address 0xE2
  U2 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(2) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E2" and write = '1' then
        port_out(2) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 3: Address 0xE3
  U3 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(3) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E3" and write = '1' then
        port_out(3) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 4: Address 0xE4
  U4 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(4) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E4" and write = '1' then
        port_out(4) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 5: Address 0xE5
  U5 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(5) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E5" and write = '1' then
        port_out(5) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 6: Address 0xE6
  U6 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(6) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E6" and write = '1' then
        port_out(6) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 7: Address 0xE7
  U7 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(7) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E7" and write = '1' then
        port_out(7) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 8: Address 0xE8
  U8 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(8) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E8" and write = '1' then
        port_out(8) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 9: Address 0xE9
  U9 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(9) <= x"00";

    elsif rising_edge(clock) then
      if address = x"E9" and write = '1' then
        port_out(9) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 10: Address 0xEA
  U10 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(10) <= x"00";

    elsif rising_edge(clock) then
      if address = x"EA" and write = '1' then
        port_out(10) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 11: Address 0xEB
  U11 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(11) <= x"00";

    elsif rising_edge(clock) then
      if address = x"EB" and write = '1' then
        port_out(11) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 12: Address 0xEC
  U12 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(12) <= x"00";

    elsif rising_edge(clock) then
      if address = x"EC" and write = '1' then
        port_out(12) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 13: Address 0xED
  U13 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(13) <= x"00";

    elsif rising_edge(clock) then
      if address = x"ED" and write = '1' then
        port_out(13) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 14: Address 0xEE
  U14 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(14) <= x"00";

    elsif rising_edge(clock) then
      if address = x"EE" and write = '1' then
        port_out(14) <= data_in;
      end if;
    end if;
  end process;


  -- PORT 15: Address 0xEF
  U15 : process(clock, reset)
  begin
    if reset = '0' then
      port_out(15) <= x"00";

    elsif rising_edge(clock) then
      if address = x"EF" and write = '1' then
        port_out(15) <= data_in;
      end if;
    end if;
  end process;

end PORTS_arch;
