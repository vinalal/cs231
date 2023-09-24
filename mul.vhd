library IEEE;
use IEEE.std_logic_1164.all;

entity mux4x1 is
    port(D: in std_logic_vector (3 downto 0);
    S: in std_logic_vector(1 downto 0);
    Y: out std_logic);
end entity; 

architecture behaviour of OR_Gate is
    signal nots0,nots1 : std_logic;
    signal temp1,temp2,temp3,temp4,out1,out2,out3,out4,fout1,fout2: std_logic;
    
    component OR_Gate is
        port(x1: in std_logic;
        x2: in std_logic;
        y: out std_logic);
    end component;

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
    a1:NOT_Gate
    port map(x =>S(0) , y=>nots0);

    a2:NOT_Gate
    port map(x =>S(1) , y=>nots1);

    a3:AND_Gate
    port map(x1 => nots0 , x2 => nots1, y => temp1);

    a4:AND_Gate
    port map(x1 => D(0) , x2 => temp1, y => out1);

    a5:AND_Gate
    port map(x1 => S(0) , x2 => nots1, y => temp2);

    a6:AND_Gate
    port map(x1 => temp2 , x2 => D(1), y => out2);

    a7:AND_Gate
    port map(x1 => nots0 , x2 => S(1), y => temp3);

    a8:AND_Gate
    port map(x1 => temp3 , x2 => D(2), y => out3);

    a9:AND_Gate
    port map(x1 => S(0) , x2 => S(1), y => temp4);

    a10:AND_Gate
    port map(x1 => temp4 , x2 => D(3), y => out4);
    
    a11:OR_Gate
    port map(x1 => out1 , x2 => out2, y => fout1);

    a12:OR_Gate
    port map(x1 => out3 , x2 => out4, y => fout2);

    a13:OR_Gate
    port map(x1 => fout1 , x2 => fout2, y => Y);

end architecture;





    