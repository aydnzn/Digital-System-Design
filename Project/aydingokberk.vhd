----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Aydýn Uzun - Gökberk Erdoðan
-- 
-- Create Date:    12:39:31 05/30/2017 
-- Design Name: 
-- Module Name:    denem1 - Behavioral 
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
use ieee.std_logic_signed.all;
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

entity denem1 is
port(
Q : out std_logic_vector (7 downto 0);
my_clk : in std_logic ;
button1 : in std_logic;
reset : in std_logic;
nreset : in  STD_LOGIC;
SSEG_CA : out  STD_LOGIC_VECTOR (7 downto 0);
SSEG_AN : out  STD_LOGIC_VECTOR (3 downto 0);
vsync : out  STD_LOGIC;
hsync : out  STD_LOGIC;		
red : out  STD_LOGIC_VECTOR (2 downto 0);
green : out  STD_LOGIC_VECTOR (2 downto 0); 
blue : out  STD_LOGIC_VECTOR (1 downto 0) ); 
end denem1;

architecture Behavioral of denem1 is
	
    signal temporal: STD_LOGIC;
  signal counter : integer range 0 to 24999999 := 0;
	 signal input:  std_logic_vector( 7 downto 0);
	 signal refrclk : std_logic  := '0';
	 signal clk_out : std_logic;
	 signal qout : std_logic_vector (7 downto 0);
	 
	 -- integers
	   signal temp: integer range 0 to 120 := 0;
		signal n : integer range 0 to 1111111111 := 1;
		signal can : integer range 0 to 3 := 3;
		signal hs : integer range 0 to 100 := 0;
		signal hhhs : integer range 0 to 100 := 0;
	
	-- signals for vga part
	 signal clk_outvga: STD_LOGIC; 
	 constant hd : integer :=639; --horizontal display
	 constant hfp : integer :=16; --front porch
	 constant hsp : integer :=96; --sync pulse
	 constant hbp : integer :=48; --back porch
	 constant vd : integer :=479; --horizontal display
	 constant vfp : integer :=10; --front porch
	 constant vsp : integer :=2; --sync pulse
	 constant vbp : integer :=29; --back porch
	 signal hpos : integer :=0;
	 signal vpos : integer :=0;
	 signal video : std_logic :='0';
	 signal rgb : std_logic_vector(7 downto 0);
	 
	 -- signals for sseg driver
	 signal newtemp : std_logic_vector(7 downto 0);
	 signal units_signal : std_logic_vector(3 downto 0);
	 signal tens_signal : std_logic_vector (3 downto 0);
	 SIGNAL sones :  std_logic_vector (6 downto 0);
	SIGNAL stens :  std_logic_vector (6 downto 0);
	SIGNAL digit0 :  std_logic_vector (7 downto 0);	
	SIGNAL digit1 :  std_logic_vector (7 downto 0);	
	SIGNAL digit2 :  std_logic_vector (7 downto 0);	
	SIGNAL digit3 :  std_logic_vector (7 downto 0);
	signal refrclk3	: STD_LOGIC := '0';
	signal ch_sel	: integer range 0 to 3 := 0;
	signal counter3	: integer range 0 to 124999 := 0;
	 signal newtemphs : std_logic_vector(7 downto 0);
	 signal units_signalhs : std_logic_vector(3 downto 0);
	 signal tens_signalhs : std_logic_vector (3 downto 0);
	 SIGNAL soneshs :  std_logic_vector (6 downto 0);
	SIGNAL stenshs :  std_logic_vector (6 downto 0);
	 
-- frequency divider signals
	 signal refrclkvga	: STD_LOGIC := '0'; 
	 signal temporalvga : STD_LOGIC := '0';  
    signal countervga : integer range 0 to 1 := 0; 
begin
-- VGA
--VGA
--VGA
 freqdivider: process (my_CLK,nreset) begin
	  if (nreset = '1') then
            temporalvga <= '0';
            countervga <= 0;
	elsif rising_edge(my_clk) then
		if (countervga = 1) then 
			temporalvga <= not temporalvga;
			countervga <= 0;
		else
			countervga <= countervga + 1;
		end if;
	end if;
end process;
clk_outvga <= temporalvga;
-- vga clock

horizontal_position_counter:process(clk_outvga, nreset)
	begin
		if (nreset = '1') then
			hpos <= 0;
		elsif(clk_outvga'event and clk_outvga = '1') then
			if(hpos = (hd + hsp + hfp + hbp))then
				hpos <= 0;
			else
				hpos <= hpos +1;
			end if;
		end if;
end process;
-- vga horizontal position

vertical_position_counter:process(clk_outvga, nreset)
	begin
		if (nreset = '1') then
			vpos <= 0;
		elsif(clk_outvga'event and clk_outvga = '1') then
			if(hpos = (hd + hsp + hfp + hbp))then
				if(vpos = (vd + vsp + vfp + vbp))then
					vpos <= 0;
				else
					vpos <= vpos +1;
				end if;
			end if;
		end if;
end process;
-- vga vertical position

horizontal_synchro:process(clk_outvga, nreset)
	begin
		if (nreset = '1') then
			hsync <= '0';
		elsif(clk_outvga'event and clk_outvga = '1') then
			if((hpos <= (hd + hfp)) or (hpos > hd + hfp + hsp ))then
				hsync <= '1';
			else
				hsync <= '0';
			end if;
		end if;
end process;
-- vga horizontal synchronization


vertical_synchro:process(clk_outvga, nreset, vpos)
	begin
		if (nreset = '1') then
			vsync <= '0';
		elsif(clk_outvga'event and clk_outvga = '1') then
			if((vpos <= (vd + vfp)) or (vpos > vd + vfp + vsp ))then
				vsync <= '1';
			else
				vsync <= '0';
			end if;
		end if;
end process;		
-- vga vertical synchronization

			
video_on:process(clk_outvga,nreset, hpos, vpos)
begin
		if (nreset = '1') then
			video <= '0';
		elsif(clk_outvga'event and clk_outvga = '1') then
			if(hpos <= hd and vpos <= vd)then
				video <= '1';
			else
				video <= '0';
			end if;
		end if;
end process;
-- vga video on




FREQ_DIV: process (MY_CLK) begin
	if rising_edge(MY_CLK) then
	if (counter = 24999999 / n) then
			refrclk <= not refrclk;
			counter <= 0;
	elsif(counter > 24999999) then
		counter <= 0;
		else
			counter <= counter + 1;
		end if;
	end if;
end process;
clk_out <= refrclk;
--clock for led timer game



-- led synchronizer
process (clk_out)
begin
if clk_out'event and clk_out = '1' then
if reset = '1' then
Qout <= "00000000";
else 
if (qout = "00000000") and (button1 = '0') then
qout <= "00000001";
end if;

if (qout = "00000001") and (button1 = '0') then
qout <= "00000010";
end if;

if (qout = "00000010") and (button1 = '0') then
qout <= "00000100";
end if;

if (qout = "00000100") and (button1 = '0') then
qout <= "00001000";
end if;

if (qout = "00001000") and (button1 = '0') then
qout <= "00010000";
end if;

if (qout = "00010000") and (button1 = '0') then
qout <= "00100000";
end if;

if (qout = "00100000") and (button1 = '0') then
qout <= "01000000";
end if;

if (qout = "01000000") and (button1 = '0') then
qout <= "10000000";
end if;

if (qout = "10000000") and (button1 = '0') then
qout <= "00000000";
end if;


end if;
end if;
end process;
q<=qout;



-- stop the led with button 1
process(button1)
begin
if button1'event and (button1 = '1') then
if(reset = '1') then
can <= 3;
temp <= 0;
elsif (qout = "00100000") and (can > 0) then 
temp <= temp +1 ; 
elsif (can > 0) then
if(temp > hs) then
hs <= temp;
end if;
temp <= 0;
can <= can-1;
elsif (can = 0) then
if(hhhs < hs) then 
--win case
hhhs <= hs;
hs <= 0;
can<=3;
else
can <=3;
hs <= 0;
--lose case
end if;
end if;
end if;
end process;

n <=temp + 1 ;

-- VGA part
draw:process(clk_outvga, nreset)
variable temp2 : std_logic_vector (7 downto 0) := "00000000";
variable i : integer := 1;
variable j : integer := 1;
begin
        if (nreset = '1') then
            temp2 := "00000000";
        elsif(clk_outvga'event and clk_outvga = '1') then
        if(video = '1') then
		  -- draw life bar
         if((hpos >=10 and hpos<=(can*180)+10) and (vpos>=10 and vpos<=60)) then			
					if(can = 3) then
		    if((hpos >=10 and hpos<=170) and (vpos>=10 and vpos<=60)) then
                temp2 := "11100000";
					   elsif((hpos >=190 and hpos<=350) and (vpos>=10 and vpos<=60)) then
                temp2 := "11100000";
					 	   elsif((hpos >=370 and hpos<=530) and (vpos>=10 and vpos<=60)) then
                temp2 := "11100000";
					 else
					 temp2 := "00000000";
					 end if;
		  elsif(can = 2) then
		    if((hpos >=10 and hpos<=170) and (vpos>=10 and vpos<=60)) then
                temp2 := "11100000";
					   elsif((hpos >=190 and hpos<=350) and (vpos>=10 and vpos<=60)) then
                temp2 := "11100000";
					  else
					 temp2 := "00000000";
					 end if;	 
		  elsif(can=1) then
		   if((hpos >=10 and hpos<=170) and (vpos>=10 and vpos<=60)) then
                temp2 := "11100000";
					  else
					 temp2 := "00000000";
					 end if;
					 else
					 temp2 := "00000000";
					 end if;
				--draw c
				elsif((hpos >=10 and hpos<=85) and (vpos>=80 and vpos<=105)) then
                temp2 := "11111111";
					 elsif((hpos >=10 and hpos<=85) and (vpos>=80 and vpos<=105)) then
                temp2 := "00000000";
            elsif((hpos >=10 and hpos<=35) and (vpos>=105 and vpos<=180)) then
                temp2 := "11111111";
            elsif((hpos >=10 and hpos<=85) and (vpos>=180 and vpos<=205)) then
                temp2 := "11111111";
            --draw s
				 elsif((hpos >=110 and hpos<=185) and (vpos>=80 and vpos<=105)) then
                temp2 := "11111111";
            elsif((hpos >=110 and hpos<=135) and (vpos>=105 and vpos<=155)) then
                temp2 := "11111111";
            elsif((hpos >=135 and hpos<=185) and (vpos>=130 and vpos<=155)) then
                temp2 := "11111111";
            elsif((hpos >=160 and hpos<=185) and (vpos>=155 and vpos<=180)) then
                temp2 := "11111111";
            elsif((hpos >=110 and hpos<=185) and (vpos>=180 and vpos<=205)) then
                temp2 := "11111111";
				--draw :
            elsif((hpos >=210 and hpos<=235) and (vpos>=105 and vpos<=130)) then
                temp2 := "11111111";
            elsif((hpos >=210 and hpos<=235) and (vpos>=155 and vpos<=180)) then
                temp2 := "11111111";
            	 
				--draw h
            elsif((hpos >=10 and hpos<=35) and (vpos>=230 and vpos<=355)) then
                temp2 := "11111111";
            elsif((hpos >=35 and hpos<=60) and (vpos>=280 and vpos<=305)) then
                temp2 := "11111111";
            elsif((hpos >=60 and hpos<=85) and (vpos>=230 and vpos<=355)) then
                temp2 := "11111111";
            --draw s
             elsif((hpos >=110 and hpos<=185) and (vpos>=230 and vpos<=255)) then
                temp2 := "11111111";
            elsif((hpos >=110 and hpos<=135) and (vpos>=255 and vpos<=305)) then
                temp2 := "11111111";
            elsif((hpos >=135 and hpos<=185) and (vpos>=280 and vpos<=305)) then
                temp2 := "11111111";
            elsif((hpos >=160 and hpos<=185) and (vpos>=305 and vpos<=330)) then
                temp2 := "11111111";
            elsif((hpos >=110 and hpos<=185) and (vpos>=330 and vpos<=355)) then
                temp2 := "11111111";
            --draw :
				elsif((hpos >=210 and hpos<=235) and (vpos>=255 and vpos<=280)) then
                temp2 := "11111111";
            elsif((hpos >=210 and hpos<=235) and (vpos>=305 and vpos<=330)) then
                temp2 := "11111111";
					 

            --current score bar
            elsif((hpos >=260 and hpos<=260+(15*temp)) and (vpos>=105 and vpos<=180)) then
					if(temp>0) then
					 i := 1;
					while i<=temp loop
					if((hpos >=(245+15*i) and hpos<=(255+15*i) ) and (vpos>=105 and vpos<=180)) then
					temp2 := "11111000";
				else
				temp2 := "00000000";
				end if;
			 i := i + 1;
					end loop;
					else
					end if;
					-- highest score bar
			              elsif((hpos >=260 and hpos<=260+(15*hhhs)) and (vpos>=255 and vpos<=330)) then
					if(hhhs>0) then
					j := 1;
					while j<=hhhs loop
					if((hpos >=(245+15*j) and hpos<=(255+15*j) ) and (vpos>=255 and vpos<=330)) then
					temp2 := "11111000";
					else
					temp2 := "00000000";
					end if;
					j := j+1;
					end loop;
					else
					end if;
			  
            else
                temp2 := "00000000";
            end if;
				else
				temp2 := "00000000";
    end if;
	 end if;
	 rgb <= temp2;
end process;


red(2) <= rgb(7);
red(1) <= rgb(6);
red(0) <= rgb(5);
green(2) <= rgb(4);
green(1) <= rgb(3);
green(0) <= rgb(2);
blue(1) <= rgb(1);
blue(0) <= rgb(0);


-- SSEG driver
newtemp <= conv_std_logic_vector(temp, 8);
newtemphs <= conv_std_logic_vector(hhhs, 8);
units_signal(0)<= newtemp(0);
units_signal(1)<= newtemp(1);
units_signal(2)<= newtemp(2);
units_signal(3)<= newtemp(3);
tens_signal(0)<= newtemp(4);
tens_signal(1)<= newtemp(5);
tens_signal(2)<= newtemp(6);
tens_signal(3)<= newtemp(7);
units_signalhs(0)<= newtemphs(0);
units_signalhs(1)<= newtemphs(1);
units_signalhs(2)<= newtemphs(2);
units_signalhs(3)<= newtemphs(3);
tens_signalhs(0)<= newtemphs(4);
tens_signalhs(1)<= newtemphs(5);
tens_signalhs(2)<= newtemphs(6);
tens_signalhs(3)<= newtemphs(7);
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
 with units_signalhs select
 soneshs <= "1000000" when "0000",
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
 with tens_signalhs select
 stenshs <= "1000000" when "0000",
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
Digit1(0) <=soneshs(0);
Digit1(1) <=soneshs(1);
Digit1(2) <=soneshs(2);
Digit1(3) <=soneshs(3);
Digit1(4) <=soneshs(4);
Digit1(5) <=soneshs(5);
Digit1(6) <=soneshs(6);
Digit1(7) <= '1';
Digit0(0) <=stenshs(0);
Digit0(1) <=stenshs(1);
Digit0(2) <=stenshs(2);
Digit0(3) <=stenshs(3);
Digit0(4) <=stenshs(4);
Digit0(5) <=stenshs(5);
Digit0(6) <=stenshs(6);
Digit0(7) <= '1';
FREQ_DIV3: process (MY_CLK) begin
	if rising_edge(MY_CLK) then
		if (counter3 = 124999) then -- 400Hz Clock, each SSEG will be refreshed with a freq 100Hz 
			refrclk3 <= not refrclk3;
			counter3 <= 0;
		else
			counter3 <= counter3 + 1;
		end if;
	end if;
end process;
process(refrclk3) begin
	if rising_edge(refrclk3) then
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
end Behavioral;

