library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity;

architecture tb of testbench is
    signal x,y,z,w,en1 : std_logic;
    signal o : std_logic_vector(15 downto 0);
    signal o0,o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11,o12,o13,o14,o15 : std_logic;

    component decoder4x16 is
        port(a, b, c, d, enable: in std_logic;
        dec: out std_logic_vector(15 downto 0));
    end component;

begin
    dut_instance : decoder4x16
    port map(a => x , b => y , c => z , d => w , enable => en1 , dec => o);

    o0 <= o(0);
    o1 <= o(1);
    o2 <= o(2);
    o3 <= o(3);
    o4 <= o(4);
    o5 <= o(5);
    o6 <= o(6);
    o7 <= o(7);
    o8 <= o(8);
    o9 <= o(9);
    o10 <= o(10);
    o11 <= o(11);
    o12 <= o(12);
    o13 <= o(13);
    o14 <= o(14);
    o15 <= o(15);
    
    process
    begin
        en1 <= '1';
        x <= '0';
        y <= '0';
        z <= '0';
        w <= '0';

        wait for 1 ns;

        en1 <= '1';
        x <= '0';
        y <= '0';
        z <= '0';
        w <= '1';

        wait for 1 ns;

        en1 <= '1';
        x <= '0';
        y <= '0';
        z <= '1';
        w <= '0';

        wait for 1 ns;

        en1 <= '1';
        x <= '0';
        y <= '0';
        z <= '1';
        w <= '1';

        wait for 1 ns;

        en1 <= '1';
        x <= '0';
        y <= '1';
        z <= '0';
        w <= '0';

        wait for 1 ns;

        en1 <= '1';
        x <= '0';
        y <= '1';
        z <= '0';
        w <= '1';

        wait for 1 ns;

        en1 <= '1';
        x <= '0';
        y <= '1';
        z <= '1';
        w <= '0';

        wait for 1 ns;

        en1 <= '1';
        x <= '0';
        y <= '1';
        z <= '1';
        w <= '1';

        wait for 1 ns;

        en1 <= '1';
        x <= '1';
        y <= '0';
        z <= '0';
        w <= '0';

        wait for 1 ns;

        en1 <= '1';
        x <= '1';
        y <= '0';
        z <= '0';
        w <= '1';

        wait for 1 ns;

        en1 <= '1';
        x <= '1';
        y <= '0';
        z <= '1';
        w <= '0';

        wait for 1 ns;

        en1 <= '1';
        x <= '1';
        y <= '0';
        z <= '1';
        w <= '1';

        wait for 1 ns;

        en1 <= '1';
        x <= '1';
        y <= '1';
        z <= '0';
        w <= '0';

        wait for 1 ns;

        en1 <= '1';
        x <= '1';
        y <= '1';
        z <= '0';
        w <= '1';

        wait for 1 ns;

        en1 <= '1';
        x <= '1';
        y <= '1';
        z <= '1';
        w <= '0';

        wait for 1 ns;

        en1 <= '1';
        x <= '1';
        y <= '1';
        z <= '1';
        w <= '1';

        wait for 1 ns;

    end process;
end architecture;

