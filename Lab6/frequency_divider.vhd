----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:55:35 04/12/2017 
-- Design Name: 
-- Module Name:    frequency_divider - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ee240_bcdcounter is
    Port ( board_clk : in  STD_LOGIC;
          upcount : IN std_logic;
			  downcount : IN std_logic;
			  pload : IN std_logic;
			  pdata : in std_logic_vector (7 downto 0);
			SSEG_CA : out  STD_LOGIC_VECTOR (7 downto 0);
           SSEG_AN : out  STD_LOGIC_VECTOR (3 downto 0));
			
end ee240_bcdcounter;

architecture arch_bcd_counter of ee240_bcdcounter is

COMPONENT dff
          PORT(   Q : out std_logic;
                  C : in std_logic;      
						D : in std_logic);
          END COMPONENT;
			 
COMPONENT AND4
			port (O : out STD_ULOGIC;
					I0 : in STD_ULOGIC;
					I1 : in STD_ULOGIC;
					I2 : in STD_ULOGIC;
					I3 : in STD_ULOGIC);
			end component;
 
 signal clk_out: STD_LOGIC;
 -- 100 HZ
 signal dum_up :  std_logic_vector(3 downto 0);
 signal dum_down :  std_logic_vector(3 downto 0);
 signal dum_pload :  std_logic_vector(3 downto 0);
 signal dum_x : std_logic_vector (3 downto 0);
 -- dummy signals between d flio flops
 signal debounced_pload : std_logic ;
 signal debounced_up : std_logic ;
 signal debounced_down : std_logic ;
 signal debounced_x : std_logic;
 --debounced signals

-- signals after counter before decoder
signal c_content_ones : std_logic_vector (3 downto 0);
signal c_content_tens : std_logic_vector  (3 downto 0);

signal x : std_logic ;


--signal ce : std_logic ;
	-- digit signals inside 7 segment driver
	Signal digit0 :  std_logic_vector (7 downto 0);	
	Signal digit1 :  std_logic_vector (7 downto 0);	
	Signal digit2 :  std_logic_vector (7 downto 0);	
	Signal digit3 :  std_logic_vector (7 downto 0);	
	-- signals in bcd to 7 segment decoder
	SIGNAL sones :  std_logic_vector (6 downto 0);
	SIGNAL stens :  std_logic_vector (6 downto 0);
	--signals inside 7 segment driver
	signal ch_sel	: integer range 0 to 3 := 0;
	signal counter	: integer range 0 to 124999 := 0;
	signal my_clk : std_logic;
	--reset and clear signals inside flip flop and counter
	-- frequncy divider signals
	 signal refrclk	: STD_LOGIC := '0';
	 signal temporal : STD_LOGIC := '0';
    signal counter2 : integer range 0 to 499999 := 0;
begin
-- frequency driver converting frequency to 100 hz
    freqdivider: process (board_CLK) begin
	if rising_edge(board_clk) then
		if (counter2 = 499999) then 
			temporal <= not temporal;
			counter2 <= 0;
		else
			counter2 <= counter2 + 1;
		end if;
	end if;
end process;
clk_out <= temporal;


-- frequency divider done
-- set clear to 0, we dont need this.

u0 :dff PORT MAP (Q => dum_up(0) , C => clk_out  , D => upcount  );
u1: dff PORT MAP (Q => dum_up(1) , C => clk_out , D => dum_up(0) );
u2: dff PORT MAP (Q => dum_up(2) , C => clk_out  , D => dum_up(1) );
u3: dff PORT MAP (Q => dum_up(3) , C => clk_out  , D => dum_up(2) );
 
u4: dff PORT MAP (Q => dum_down(0) , C => clk_out , D => downcount  );
u5: dff PORT MAP (Q => dum_down(1) , C => clk_out , D => dum_down(0) );
u6: dff PORT MAP (Q => dum_down(2) , C => clk_out , D => dum_down(1) );
u7: dff PORT MAP (Q => dum_down(3) , C => clk_out  , D => dum_down(2) );
 
u8: dff PORT MAP (Q => dum_pload(0) , C => clk_out  , D => pload  );
u9: dff PORT MAP (Q => dum_pload(1) , C => clk_out  , D => dum_pload(0) );
u10: dff PORT MAP (Q => dum_pload(2) , C => clk_out  , D => dum_pload(1) );
u11: dff PORT MAP (Q => dum_pload(3) , C => clk_out , D => dum_pload(2) );

u12: and4 port map (I0 => dum_pload(0), I1 => dum_pload(1), I2 => dum_pload(2), I3 => dum_pload(3), o => debounced_pload  );
u13: and4 port map (I0 => dum_up(0), I1 => dum_up(1), I2 => dum_up(2), I3 => dum_up(3), o => debounced_up);
u14: and4 port map (I0 => dum_down(0), I1 => dum_down(1), I2 => dum_down(2), I3 => dum_down(3), o => debounced_down);

 

--

x <= debounced_pload xor debounced_up xor debounced_down ;


process(x)
	variable temp11, temp12, temp21 , temp22: std_logic_vector (3 downto 0);

	begin 

if rising_edge (x) and x='1' then
	if (debounced_pload = '1' )then
		temp11(0) := pdata(0) ;
		temp11(1) := pdata(1) ;
		temp11(2) := pdata(2) ;
		temp11(3) := pdata(3) ;
		
		temp12(0) := pdata(4) ;
		temp12(1) := pdata(5) ;
		temp12(2) := pdata(6) ;
		temp12(3) := pdata(7) ;
		else 
		temp11 := temp11;
		temp12 := temp12;
		end if;

	if (debounced_up = '1' ) then
	if ((temp12 = "1001") and (temp11 = "1001")) then
   temp11 := "0000";
   temp12 := "0000";
	elsif temp11 = "1001" then 
	temp11:= "0000";
	temp12 := temp12 + "0001";
	else
	temp11 := temp11+ "0001";
	temp12 := temp12;
	end if;
	end if;
	
	if (debounced_down = '1' ) then
   if (temp12 = "0000") and (temp11 ="0000") then
   temp11 := "1001";
   temp12 := "1001";
	elsif temp11 = "0000" then 
	temp11:= "1001";
	temp12 := temp12 - "0001";
	else
	temp11 := temp11- "0001";
	temp12 := temp12;
	end if;
	end if;

end if;

if(x'event and x = '0') then

	c_content_ones <= temp11;
   c_content_tens <= temp12;


end if;

end process;



with c_content_ones select
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
 
 with c_content_tens select
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

Digit0 <= "11111111";
Digit1 <= "11111111";

-- bcd to 7 segment decoder part done

-- rest is given driver
my_clk <= board_clk;
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

end  arch_bcd_counter;

