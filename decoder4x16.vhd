library IEEE;
use IEEE.std_logic_1164.all;

entity decoder4x16 is
    port(a, b, c, d, enable: in std_logic;
    dec: out std_logic_vector(15 downto 0));
end entity;

architecture behaviour of decoder4x16 is
    signal temp,temp1,temp2,temp3,temp4 : std_logic_vector(3 downto 0);

    component decoder2x4 is
        port(x,y,en : in std_logic;
        outp : out std_logic_vector(3 downto 0));
    end component;

begin
    a1 : decoder2x4
    port map(x => a , y => b , en => enable , outp => temp);

    a2 : decoder2x4
    port map(x => c, y => d, en => temp(0), outp => temp1);

    a3 : decoder2x4
    port map(x => c, y => d, en => temp(1), outp => temp2);

    a4 : decoder2x4
    port map(x => c, y => d, en => temp(2), outp => temp3);

    a5 : decoder2x4
    port map(x => c, y => d, en => temp(3), outp => temp4);

    dec(0) <= temp1(0);
    dec(1) <= temp1(1);
    dec(2) <= temp1(2);
    dec(3) <= temp1(3);

    dec(4) <= temp2(0);
    dec(5) <= temp2(1);
    dec(6) <= temp2(2);
    dec(7) <= temp2(3);

    dec(8) <= temp3(0);
    dec(9) <= temp3(1);
    dec(10) <= temp3(2);
    dec(11) <= temp3(3);

    dec(12) <= temp4(0);
    dec(13) <= temp4(1);
    dec(14) <= temp4(2);
    dec(15) <= temp4(3);

end architecture;


