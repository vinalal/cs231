library IEEE;
use IEEE.std_logic_1164.all;

entity decoder2x4 is
    port(x,y,en : in std_logic;
    outp : out std_logic_vector(3 downto 0));
end entity;

architecture behaviour of decoder2x4 is
    signal notx,noty,temp0,temp1,temp2,temp3 : std_logic;

    component AND_Gate is
        port(x1: in std_logic;
        x2: in std_logic;
        y: out std_logic);
    end component;

    component NOT_Gate is
        port(x: in std_logic;
        y: out std_logic);
    end component;

begin
    a1 : NOT_Gate
    port map(x => x, y => notx);

    a2 : NOT_Gate
    port map(x => y, y => noty);

    a3 : AND_Gate
    port map(x1 => notx , x2 => noty , y => temp0);

    a4 : AND_Gate
    port map(x1 => notx , x2 => y , y => temp1);

    a5 : AND_Gate
    port map(x1 => x , x2 => noty , y => temp2);

    a6 : AND_Gate
    port map(x1 => x , x2 => y , y => temp3);

    a7 : AND_Gate
    port map(x1 => temp0 , x2 => en , y => outp(0));

    a8 : AND_Gate
    port map(x1 => temp1 , x2 => en , y => outp(1));

    a9 : AND_Gate
    port map(x1 => temp2 , x2 => en , y => outp(2));

    a10 : AND_Gate
    port map(x1 => temp3 , x2 => en , y => outp(3));

end architecture;






    