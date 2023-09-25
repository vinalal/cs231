library ieee, std;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all ;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity CHORDEncoder is
    port(clk, rst: in std_logic;
    a: in std_logic_vector(7 downto 0);
    data_valid: out std_logic := '1'; 
    z: out std_logic_vector(7 downto 0));
end entity;

architecture behaviour of CHORDEncoder is
    
    function binarytoindex(input_seq : std_logic_vector(7 downto 0)) return integer is
    begin
        if input_seq = "01000011" then
            return 0; --C
        elsif input_seq = "01100100" then
            return 1; --d or C#
        elsif input_seq = "01000100" then
            return 2; --D
        elsif input_seq = "01100101" then
            return 3; --e
        elsif input_seq = "01000101" or input_seq = "01100110" then
            return 4; -- E or f
        elsif input_seq = "01000110" then
            return 5; --F
        elsif input_seq = "01100111" then
            return 6; --g
        elsif input_seq = "01000111" then
            return 7; --G
        elsif input_seq = "01100001" then
            return 8; --a
        elsif input_seq = "01000001" then
            return 9; --A
        elsif input_seq = "01100010" then
            return 10; --b
        elsif input_seq = "01000010" or input_seq = "01100011" then
            return 11; --B or c
        end if;
    end function;

    function indextoBinary(index : integer) return std_logic_vector is
        begin
            if index = 0 then
                return "01000011"; -- C
            elsif index = 1 then
                return "01100100"; -- d or C#
            elsif index = 2 then
                return "01000100"; -- D
            elsif index = 3 then
                return "01100101"; -- e
            elsif index = 4 then
                return "01000101"; -- E
            elsif index = 5 then
                return "01000110"; -- F
            elsif index = 6 then
                return "01100111"; -- g
            elsif index = 7 then
                return "01000111"; -- G
            elsif index = 8 then
                return "01100001"; -- a
            elsif index = 9 then
                return "01000001"; -- A
            elsif index = 10 then
                return "01100010"; -- b
            elsif index = 11 then
                return "01000010"; --B
            end if;
        end function;
    
    
    
begin
    process(clk)
    variable i:integer :=0;
    variable j:integer :=0;
    variable found : integer := 0;
    type IntegerArray is array (natural range <>) of integer;
    variable in_array : IntegerArray(0 to 31);

    begin
        if a /= "00000000" and a/= "UUUUUUUU" then
            if rising_edge(clk) then
                if a = "00011111" then
                    in_array(i-1) := (in_array(i-1) + 1) mod 12;
                else
            
                    
                    in_array(i) := binarytoindex(input_seq => a);
                    i := i + 1;
                end if;
            end if;
        
        elsif a = "00000000" then
            if rising_edge(clk) then
                if j >= i then
                    data_valid <= '0';
                end if;
                
                if found = 4 then
                    z <= "00110111"; --7
                    found := 0;
                elsif found = 3 then
                    z <= "01001101"; --M
                    found := 0;
                elsif found = 2 then
                    z <= "01101101"; --m
                    found := 0;
                elsif found = 1 then
                    z <= "01110011"; --s
                    found := 0;
                elsif found = 0 then
                    if j+2<i then
                        if ((in_array(j+1) - in_array(j) + 12) mod 12 = 4) and ((in_array(j+2) - in_array(j+1) + 12) mod 12 = 3) then
                            if (in_array(j+3) - in_array(j+2) + 12) mod 12 = 3 then
                                z <= indextoBinary(index => in_array(j));
                                found := 4;
                                j := j+4;
                            else
                                z <= indextoBinary(index => in_array(j));
                                found := 3;
                                j := j + 3;
                            end if;
                        elsif ((in_array(j+1) - in_array(j) + 12) mod 12 = 3) and ((in_array(j+2) - in_array(j+1) + 12) mod 12 = 4) then
                            z <= indextoBinary(index => in_array(j));
                            found := 2;
                            j := j + 3;
                        elsif ((in_array(j+1) - in_array(j) + 12) mod 12 = 5) and ((in_array(j+2) - in_array(j+1) + 12) mod 12 = 2) then
                            z <= indextoBinary(index => in_array(j));
                            found := 1;
                            j := j + 3;
                        else
                            z <= indextoBinary(index => in_array(j));
                            j := j + 1;
                        end if;
                    else
                        report "j is " & integer'image(j);
                        report "i is " & integer'image(i);
                        if(j = i) then
                            data_valid <= '0';
                            z <= "UUUUUUUU";
                        else
                            z <= indextoBinary(index => in_array(j));
                            j := j + 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;
end architecture;

                    
                        
                        
            
            
            
            
        
        
