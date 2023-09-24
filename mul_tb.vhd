library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity;

architecture tb of testbench is
    signal d:std_logic_vector(3 downto 0);
    signal s:std_logic_vector(1 downto 0);
    signal y:std_logic;

    component mux4x1 is
        port(D: in std_logic_vector (3 downto 0);
        S: in std_logic_vector(1 downto 0);
        Y: out std_logic);
    end component;

begin
    dut_instance:mux4x1
    port map(D => d, S =>s , Y=>y);

    process
    begin
        d <= "0000";
        s <= "00";
        wait for 1 ns;

        d <= "0000";
        s <= "01";
        wait for 1 ns;

        d <= "0000";
        s <= "10";
        wait for 1 ns;

        d <= "0000";
        s <= "11";
        wait for 1 ns;

        d <= "0001";
        s <= "00";
        wait for 1 ns;

        d <= "0001";
        s <= "01";
        wait for 1 ns;

        d <= "0001";
        s <= "10";
        wait for 1 ns;

        d <= "0001";
        s <= "11";
        wait for 1 ns;

        d <= "0010";
        s <= "00";
        wait for 1 ns;

        d <= "0010";
        s <= "01";
        wait for 1 ns;

        d <= "0010";
        s <= "10";
        wait for 1 ns;

        d <= "0010";
        s <= "11";
        wait for 1 ns;

        d <= "0011";
        s <= "00";
        wait for 1 ns;

        d <= "0011";
        s <= "01";
        wait for 1 ns;

        d <= "0011";
        s <= "10";
        wait for 1 ns;

        d <= "0011";
        s <= "11";
        wait for 1 ns;

        d <= "0100";
        s <= "00";
        wait for 1 ns;

        d <= "0100";
        s <= "01";
        wait for 1 ns;

        d <= "0100";
        s <= "10";
        wait for 1 ns;

        d <= "0100";
        s <= "11";
        wait for 1 ns;

        d <= "0101";
        s <= "00";
        wait for 1 ns;

        d <= "0101";
        s <= "01";
        wait for 1 ns;

        d <= "0101";
        s <= "10";
        wait for 1 ns;

        d <= "0101";
        s <= "11";
        wait for 1 ns;

        d <= "0110";
        s <= "00";
        wait for 1 ns;

        d <= "0110";
        s <= "01";
        wait for 1 ns;

        d <= "0110";
        s <= "10";
        wait for 1 ns;

        d <= "0110";
        s <= "11";
        wait for 1 ns;

        d <= "0111";
        s <= "00";
        wait for 1 ns;

        d <= "0111";
        s <= "01";
        wait for 1 ns;

        d <= "0111";
        s <= "10";
        wait for 1 ns;

        d <= "0111";
        s <= "11";
        wait for 1 ns;

        d <= "1000";
        s <= "00";
        wait for 1 ns;

        d <= "1000";
        s <= "01";
        wait for 1 ns;

        d <= "1000";
        s <= "10";
        wait for 1 ns;

        d <= "1000";
        s <= "11";
        wait for 1 ns;

        d <= "1001";
        s <= "00";
        wait for 1 ns;

        d <= "1001";
        s <= "01";
        wait for 1 ns;

        d <= "1001";
        s <= "10";
        wait for 1 ns;

        d <= "1001";
        s <= "11";
        wait for 1 ns;

        d <= "1010";
        s <= "00";
        wait for 1 ns;

        d <= "1010";
        s <= "01";
        wait for 1 ns;

        d <= "1010";
        s <= "10";
        wait for 1 ns;

        d <= "1010";
        s <= "11";
        wait for 1 ns;

        d <= "1011";
        s <= "00";
        wait for 1 ns;

        d <= "1011";
        s <= "01";
        wait for 1 ns;

        d <= "1011";
        s <= "10";
        wait for 1 ns;

        d <= "1011";
        s <= "11";
        wait for 1 ns;

        d <= "1100";
        s <= "00";
        wait for 1 ns;

        d <= "1100";
        s <= "01";
        wait for 1 ns;

        d <= "1100";
        s <= "10";
        wait for 1 ns;

        d <= "1100";
        s <= "11";
        wait for 1 ns;

        d <= "1101";
        s <= "00";
        wait for 1 ns;

        d <= "1101";
        s <= "01";
        wait for 1 ns;

        d <= "1101";
        s <= "10";
        wait for 1 ns;

        d <= "1101";
        s <= "11";
        wait for 1 ns;

        d <= "1110";
        s <= "00";
        wait for 1 ns;

        d <= "1110";
        s <= "01";
        wait for 1 ns;

        d <= "1110";
        s <= "10";
        wait for 1 ns;

        d <= "1110";
        s <= "11";
        wait for 1 ns;

        d <= "1111";
        s <= "00";
        wait for 1 ns;

        d <= "1111";
        s <= "01";
        wait for 1 ns;

        d <= "1111";
        s <= "10";
        wait for 1 ns;

        d <= "1111";
        s <= "11";
        wait for 1 ns;
    end process;
end architecture;




        