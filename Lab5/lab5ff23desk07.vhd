----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:14:37 04/07/2017 
-- Design Name: 
-- Module Name:    lab5ff23desk07 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

USE ieee.std_logic_unsigned.all ;

USE ieee.std_logic_arith.all ;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab5ff23desk07 is
    Port ( FP : in  STD_LOGIC_VECTOR (5 downto 0);
           My_clk : in  STD_LOGIC;
           SSEG_CA : out  STD_LOGIC_VECTOR (7 downto 0);
           SSEG_AN : out  STD_LOGIC_VECTOR (3 downto 0));
end lab5ff23desk07;

architecture arch_FP_decoder of lab5ff23desk07 is




		SIGNAL sw :  std_logic_vector(5 downto 0);
		SIGNAL r :  std_logic_vector(6 downto 0);
		SIGNAL d_signal :  std_logic_vector(3 downto 0);
		SIGNAL dec_signal :  std_logic_vector(1 downto 0);
		SIGNAL significand :  std_logic_vector(2 downto 0);

		

		

		SIGNAL K :  std_logic_vector(3 downto 0);

	   SIGNAL L :  std_logic_vector(3 downto 0);

		SIGNAL M :  std_logic_vector(3 downto 0);

		SIGNAL r2 :  std_logic_vector(3 downto 0);

		SIGNAL s :  std_logic_vector (6 downto 0);

		SIGNAL d :  std_logic_vector (7 downto 0);

		

		

		SIGNAL dig :  std_logic_vector (7 downto 0);

		SIGNAL sones :  std_logic_vector (6 downto 0);

		SIGNAL stens :  std_logic_vector (6 downto 0);

		SIGNAL stres :  std_logic_vector (6 downto 0);

		SIGNAL tens_signal :  std_logic_vector(3 downto 0);

		SIGNAL units_signal :  std_logic_vector(3 downto 0);

		

	SIGNAL digit0 :  std_logic_vector (7 downto 0);	

				SIGNAL digit1 :  std_logic_vector (7 downto 0);	

				SIGNAL digit2 :  std_logic_vector (7 downto 0);	

				SIGNAL digit3 :  std_logic_vector (7 downto 0);	

				

				

				signal refrclk	: STD_LOGIC := '0';

	signal ch_sel	: integer range 0 to 3 := 0;

	signal counter	: integer range 0 to 124999 := 0;

begin




Sw(0) <= FP(0);

Sw(1) <= FP(1);

Sw(2) <= FP(2);

Sw(3) <= FP(3);

Sw(4) <= FP(4);

Sw(5) <= FP(5);




dec_signal(0) <= NOT SW(0);

dec_signal(1) <= NOT SW(1);

d_signal(0) <= dec_signal(0) and dec_signal(1);

d_signal(1) <= sw(0) and dec_signal(1);

d_signal(2) <= dec_signal(0) and sw(1);

d_signal(3) <= sw(0) and sw(1);

-- using a decoder achieve 2^n.

-- then multiply it with 3 bit significand

significand(0) <= sw(2); 

significand(1) <= sw(3);

significand(2) <= sw(4);




R <= significand * d_signal;

--R(6) is useless.




-- part 1 done




S(0) <= r(0);

S(1) <= r(1);

S(2) <= r(2);

S(3) <= r(3);

S(4) <= r(4);

S(5) <= r(5);




r2(3) <= '0';

r2(2) <= s(5);

r2(1) <= s(4);

r2(0) <= s(3);




K(3) <=  r2(3) Or ((r2(2) and r2(0))) or (r2(2) and r2(1));

K(2) <= (r2(3) and r2(0)) or (r2(2) and (not r2(1)) and (not r2(0)));

K(1) <= (r2(3) and (not r2(0))) or ((not r2(2)) and r2(1)) or (r2(1) and r2(0));

K(0) <=  (r2(3) and (not r2(0))) or (not r2(3) and  (not r2(2)) and  r2(0)) or (r2(2) and r2(1) and (not r2(0)));




L(3) <=  k(2) Or ((k(1) and s(2))) or (k(1) and k(0));

L(2) <= (k(2) and s(2)) or (k(1) and (not k(0)) and (not k(0)));

L(1) <= (k(2) and (not s(2))) or ((not k(1)) and k(0)) or (k(0) and s(2));

L(0) <=  (k(2) and (not s(2))) or (not k(2) and  (not k(1)) and s(2)) or (k(1) and k(0) and (not s(2)));




M(3) <=  l(2) Or ((l(1) and s(1))) or (l(1) and l(0));

M(2) <= (l(2) and s(1)) or (l(1) and (not l(0)) and (not s(1)));

M(1) <= (l(2) and (not s(1))) or ((not l(1)) and l(0)) or (l(0) and s(1));

M(0) <=  (l(2) and (not s(1))) or (not l(2) and  (not l(1)) and  s(1)) or (l(1) and l(0) and (not s(1)));




D(7) <= '0';

D(6) <= K(3);

D(5) <= l(3);

D(4) <= m(3);

D(3) <= m(2);

D(2) <= m(1);

D(1) <= m(0);

D(0) <= s(0);




-- part 2 done




Dig(0) <= d(0);

Dig(1) <= d(1);

Dig(2) <= d(2);

Dig(3) <= d(3);

Dig(4) <= d(4);

Dig(5) <= d(5);

Dig(6) <= d(6);

Dig(7) <= d(7);




units_signal(0)<= dig(0);

units_signal(1)<= dig(1);

units_signal(2)<= dig(2);

units_signal(3)<= dig(3);

tens_signal(0)<= dig(4);

tens_signal(1)<= dig(5);

tens_signal(2)<= dig(6);

tens_signal(3)<= dig(7);




with units_signal select

 sones <= "1000000" when "0000",

 "1111001" when "0001",

 "0100100" when "0010",

 "0110000" when "0011",

 "0011001" when "0100",

 "0010010" when "0101",

 "0000010" when "0110",

 "1111000" when "0111",

 "0000000" when "1000",

 "0010000" when "1001",

 "1111111" when others;

 

 with tens_signal select

 stens <= "1000000" when "0000",

 "1111001" when "0001",

 "0100100" when "0010",

 "0110000" when "0011",

 "0011001" when "0100",

 "0010010" when "0101",

 "0000010" when "0110",

 "1111000" when "0111",

 "0000000" when "1000",

 "0010000" when "1001",

 "1111111" when others;




Digit3(0) <=sones(0);

Digit3(1) <=sones(1);

Digit3(2) <=sones(2);

Digit3(3) <=sones(3);

Digit3(4) <=sones(4);

Digit3(5) <=sones(5);

Digit3(6) <=sones(6);

Digit3(7) <= '1';




Digit2(0) <=stens(0);

Digit2(1) <=stens(1);

Digit2(2) <=stens(2);

Digit2(3) <=stens(3);

Digit2(4) <=stens(4);

Digit2(5) <=stens(5);

Digit2(6) <=stens(6);

Digit2(7) <= '1';




with sw(5) select

stres <= "0111111" when '1',

 "1111111" when others;

 

 

Digit1(0) <=stres(0);

Digit1(1) <=stres(1);

Digit1(2) <=stres(2);

Digit1(3) <=stres(3);

Digit1(4) <=stres(4);

Digit1(5) <=stres(5);

Digit1(6) <=stres(6);

Digit1(7) <= '1';



Digit0(0) <='1';

Digit0(1) <='1';

Digit0(2) <='1';

Digit0(3) <='1';

Digit0(4) <='1';

Digit0(5) <='1';

Digit0(6) <='1';

Digit0(7) <= '1';





FREQ_DIV: process (MY_CLK) begin

	if rising_edge(MY_CLK) then

		if (counter = 124999) then -- 400Hz Clock, each SSEG will be refreshed with a freq 100Hz 

			refrclk <= not refrclk;

			counter <= 0;

		else

			counter <= counter + 1;

		end if;

	end if;

end process;

    

process(refrclk) begin

	if rising_edge(refrclk) then

		if (ch_sel = 3) then

			ch_sel <= 0;

		else

			ch_sel <= ch_sel + 1;

		end if;

	end if;

end process;

	

with ch_sel select

	SSEG_AN <= 

		"0111" when 0,

		"1011" when 1,

		"1101" when 2,

		"1110" when 3;




with ch_sel select

	SSEG_CA <= 

		DIGIT0 when 0,

		DIGIT1 when 1,

		DIGIT2 when 2,

		DIGIT3 when 3;










end arch_FP_decoder;

