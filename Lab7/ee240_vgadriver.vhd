----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:55:30 05/03/2017 
-- Design Name: 
-- Module Name:    ee240_vgadriver - Behavioral 
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

entity ee240_vgadriver is
    Port ( nreset : in  STD_LOGIC;
           board_clk : in  STD_LOGIC;
           vsync : out  STD_LOGIC;
           hsync : out  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0); 
           blue : out  STD_LOGIC_VECTOR (1 downto 0));
end ee240_vgadriver;

architecture Behavioral of ee240_vgadriver is

	 signal clk_out: STD_LOGIC;
	 
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
	 
-- frequency divider signals
	 signal refrclk	: STD_LOGIC := '0';
	 signal temporal : STD_LOGIC := '0';
    signal counter : integer range 0 to 1 := 0;
	 
begin

    freqdivider: process (board_CLK,nreset) begin
	  if (nreset = '1') then
            temporal <= '0';
            counter <= 0;
	elsif rising_edge(board_clk) then
		if (counter = 1) then 
			temporal <= not temporal;
			counter <= 0;
		else
			counter <= counter + 1;
		end if;
	end if;
end process;
clk_out <= temporal;


horizontal_position_counter:process(clk_out, nreset)
	begin
		if (nreset = '1') then
			hpos <= 0;
		elsif(clk_out'event and clk_out = '1') then
			if(hpos = (hd + hsp + hfp + hbp))then
				hpos <= 0;
			else
				hpos <= hpos +1;
			end if;
		end if;
end process;



vertical_position_counter:process(clk_out, nreset)
	begin
		if (nreset = '1') then
			vpos <= 0;
		elsif(clk_out'event and clk_out = '1') then
			if(hpos = (hd + hsp + hfp + hbp))then
				if(vpos = (vd + vsp + vfp + vbp))then
					vpos <= 0;
				else
					vpos <= vpos +1;
				end if;
			end if;
		end if;
end process;


horizontal_synchro:process(clk_out, nreset)
	begin
		if (nreset = '1') then
			hsync <= '0';
		elsif(clk_out'event and clk_out = '1') then
			if((hpos <= (hd + hfp)) or (hpos > hd + hfp + hsp ))then
				hsync <= '1';
			else
				hsync <= '0';
			end if;
		end if;
end process;



vertical_synchro:process(clk_out, nreset, vpos)
	begin
		if (nreset = '1') then
			vsync <= '0';
		elsif(clk_out'event and clk_out = '1') then
			if((vpos <= (vd + vfp)) or (vpos > vd + vfp + vsp ))then
				vsync <= '1';
			else
				vsync <= '0';
			end if;
		end if;
end process;		
			

			
video_on:process(clk_out,nreset, hpos, vpos)
begin
		if (nreset = '1') then
			video <= '0';
		elsif(clk_out'event and clk_out = '1') then
			if(hpos <= hd and vpos <= vd)then
				video <= '1';
			else
				video <= '0';
			end if;
		end if;
end process;





color_generator:process(clk_out, nreset)
variable temp : std_logic_vector (7 downto 0) := "00000000";
begin
		if (nreset = '1') then
			temp := "00000000";
			
		elsif(clk_out'event and clk_out = '1') then
			if(video = '1')then
				if(temp = "11111111")then
					temp := "00000000";
				else
					temp := temp + "00000001";
				end if;
			else
			temp := "00000000";
		end if;
	end if;
	
	rgb <= temp;
	
end process;	


red(2) <= rgb(7);
red(1) <= rgb(6);
red(0) <= rgb(5);
green(2) <= rgb(4);
green(1) <= rgb(3);
green(0) <= rgb(2);
blue(1) <= rgb(1);
blue(0) <= rgb(0);
	
end Behavioral;


