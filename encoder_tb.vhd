library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity;

architecture tb of testbench is
    signal i : std_logic_vector(3 downto 0);
    signal y : std_logic_vector(1 downto 0);

    component encoder4x2 is
        port(I: in std_logic_vector (3 downto 0);
        Y: out std_logic_vector(1 downto 0));
    end component;

begin
    dut_instance: encoder4x2
    port map(I => i, Y=> y);

    process
    begin
        i <= "0001";
        wait for 1 ns;

        i <= "0010";
        wait for 1 ns;

        i <= "0100";
        wait for 1 ns;

        i <= "1000";
        wait for 1 ns;
    end process
end architecture;
