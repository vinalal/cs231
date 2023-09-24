library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity;

architecture tb of testbench is
    signal a,b : std_logic;

    component NOT_Gate is
        port(x: in std_logic;
        y: out std_logic);
    end component;

begin
    dut_instance : NOT_Gate
    port map(x => a , y => b);

    process
    begin
        
        a <= '0';
        wait for 1 ns;

        a <= '1';
        wait for 1 ns;
    
    end process;
end architecture;