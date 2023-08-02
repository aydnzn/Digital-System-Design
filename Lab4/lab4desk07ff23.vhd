----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:14:55 04/07/2017 
-- Design Name: 
-- Module Name:    lab4desk07ff23 - structural 
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

entity lab4desk07ff23 is
    Port ( wclock : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (3 downto 0);
           co : out  STD_LOGIC;
           en : in  STD_LOGIC);
end lab4desk07ff23;

architecture structural of lab4desk07ff23 is
 COMPONENT FDCE

          PORT(   Q : out std_logic;

                  C : in std_logic;      

                  CE :std_logic;

						CLR : in std_logic;

						D : in std_logic);

          END COMPONENT;

			 

			 COMPONENT and2 

			 Port( I0 : in std_logic;

					I1 : in std_logic;

					o : out std_logic );

			    END COMPONENT;

			 

			  COMPONENT xor2 

			 Port( I0 : in std_logic;

					I1 : in std_logic;

					o : out std_logic);

   END COMPONENT;

          SIGNAL dummysignal :  std_logic_vector(3 downto 0);

			 SIGNAL dummysignal2 :  std_logic_vector(3 downto 0);

			  SIGNAL dummysignal3 :  std_logic_vector(3 downto 0);




begin




u0: and2 PORT MAP (I0 => EN, I1 => dummysignal3(0), o => dummysignal2(0));

u1: and2 PORT MAP (I0 => dummysignal2(0), I1 => dummysignal3(1), o => dummysignal2(1));

u2: and2 PORT MAP (I0 => dummysignal2(1), I1=> dummysignal3(2), o => dummysignal2(2));

u3: and2 PORT MAP (I0 => dummysignal2(2), I1 => dummysignal3(3), o => CO);

u4: xor2 PORT MAP (I0 => dummysignal3(0), I1 => EN, o => dummysignal(0));

u5: xor2 PORT MAP (I0 => dummysignal3(1), I1 => dummysignal2(0), o => dummysignal(1));

u6: xor2 PORT MAP (I0 => dummysignal3(2), I1 => dummysignal2(1), o => dummysignal(2));

u7: xor2 PORT MAP (I0 => dummysignal3(3), I1 => dummysignal2(2), o => dummysignal(3));

u8: fdce PORT MAP (Q => dummysignal3(0) , C => wclock , CE => '1'  ,CLR => CLR , D => dummysignal(0)   );

u9: fdce PORT MAP (Q => dummysignal3(1) , C => wclock , CE => '1'  ,CLR => CLR  , D => dummysignal(1)  );

u10: fdce PORT MAP (Q => dummysignal3(2) , C => wclock, CE => '1' ,CLR => CLR , D => dummysignal(2)  );

u11: fdce PORT MAP (Q => dummysignal3(3) , C => wclock , CE => '1' ,CLR => CLR , D => dummysignal(3)  );

Q(0) <= dummysignal3(0);

Q(1) <= dummysignal3(1);

Q(2) <= dummysignal3(2);

Q(3) <= dummysignal3(3); 


end structural;

