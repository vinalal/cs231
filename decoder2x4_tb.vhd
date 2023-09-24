library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity;

architecture tb of testbench is
    signal a,b,en2 : std_logic;
    signal o1: std_logic_vector(3 downto 0);

    component decoder2x4 is
        port(x,y,en : in std_logic;
        outp : out std_logic_vector(3 downto 0));
    end component;

begin
    dut_instance : decoder2x4
    port map(x => a , y => b , en => en2 , outp => o1);

    process
    begin
        en2 <= '1';
        a <= '0';
        b <= '0';
        wait for 1 ns;

        en2 <= '1';
        a <= '1';
        b <= '0';
        wait for 1 ns;

        en2 <= '1';
        a <= '0';
        b <= '1';
        wait for 1 ns;

        en2 <= '1';
        a <= '1';
        b <= '1';
        wait for 1 ns;
    end process;
end architecture;


