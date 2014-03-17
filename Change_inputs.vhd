----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Spence
-- 
-- Create Date:    	10:33:47 07/07/2012 
-- Design Name:		Lab3
-- Module Name:    	Change_inputs - Behavioral 
-- Description: 		Lab3
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Change_inputs is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           input : in STD_LOGIC_VECTOR (3 downto 0);
           floor : out  STD_LOGIC_VECTOR (3 downto 0));
end Change_inputs;

architecture Behavioral of Change_inputs is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
type floor_state_type is (floor0, floor1, floor2, floor3, floor4, floor5, floor6, floor7);

--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal floor_state : floor_state_type;

begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------

floor_state_machine: process(clk)
begin
if rising_edge(clk) then
		if reset='1' then
			floor_state <= floor0;
		else
			case floor_state is
				when floor0 =>
					
					if (input = "0000") then floor_state <= floor0;
					elsif (input = "0001") then floor_state <= floor1;
					elsif (input = "0010") then floor_state <= floor1;
					elsif (input = "0011") then floor_state <= floor1;
					elsif (input = "0100") then floor_state <= floor1;
					elsif (input = "0101") then floor_state <= floor1;
					elsif (input = "0110") then floor_state <= floor1;
					elsif (input = "0111") then floor_state <= floor1;
					else floor_state <= floor0;
					end if;
				when floor1 =>	
					if (input = "0000") then floor_state <= floor0;
					elsif (input = "0001") then floor_state <= floor1;
					elsif (input = "0010") then floor_state <= floor2;
					elsif (input = "0011") then floor_state <= floor2;
					elsif (input = "0100") then floor_state <= floor2;
					elsif (input = "0101") then floor_state <= floor2;
					elsif (input = "0110") then floor_state <= floor2;
					elsif (input = "0111") then floor_state <= floor2;
					else floor_state <= floor1;
					end if;
					
				

				when floor2 =>
					if (input = "0000") then floor_state <= floor1;
					elsif (input = "0001") then floor_state <= floor1;
					elsif (input = "0010") then floor_state <= floor2;
					elsif (input = "0011") then floor_state <= floor3;
					elsif (input = "0100") then floor_state <= floor3;
					elsif (input = "0101") then floor_state <= floor3;
					elsif (input = "0110") then floor_state <= floor3;
					elsif (input = "0111") then floor_state <= floor3;
					else floor_state <= floor2;
					end if;
				when floor3 =>
					if (input = "0000") then floor_state <= floor2;
					elsif (input = "0001") then floor_state <= floor2;
					elsif (input = "0010") then floor_state <= floor2;
					elsif (input = "0011") then floor_state <= floor3;
					elsif (input = "0100") then floor_state <= floor4;
					elsif (input = "0101") then floor_state <= floor4;
					elsif (input = "0110") then floor_state <= floor4;
					elsif (input = "0111") then floor_state <= floor4;
					else floor_state <= floor3;
					end if;
				when floor4 =>
					if (input = "0000") then floor_state <= floor3;
					elsif (input = "0001") then floor_state <= floor3;
					elsif (input = "0010") then floor_state <= floor3;
					elsif (input = "0011") then floor_state <= floor3;
					elsif (input = "0100") then floor_state <= floor4;
					elsif (input = "0101") then floor_state <= floor5;
					elsif (input = "0110") then floor_state <= floor5;
					elsif (input = "0111") then floor_state <= floor5;
					else floor_state <= floor4;
					end if;
				
				when floor5 =>
					if (input = "0000") then floor_state <= floor4;
					elsif (input = "0001") then floor_state <= floor4;
					elsif (input = "0010") then floor_state <= floor4;
					elsif (input = "0011") then floor_state <= floor4;
					elsif (input = "0100") then floor_state <= floor4;
					elsif (input = "0101") then floor_state <= floor5;
					elsif (input = "0110") then floor_state <= floor6;
					elsif (input = "0111") then floor_state <= floor6;
					else floor_state <= floor5;
					end if;
					
				when floor6 =>
					if (input = "0000") then floor_state <= floor5;
					elsif (input = "0001") then floor_state <= floor5;
					elsif (input = "0010") then floor_state <= floor5;
					elsif (input = "0011") then floor_state <= floor5;
					elsif (input = "0100") then floor_state <= floor5;
					elsif (input = "0101") then floor_state <= floor5;
					elsif (input = "0110") then floor_state <= floor6;
					elsif (input = "0111") then floor_state <= floor7;
					else floor_state <= floor6;
					end if;
				
				when floor7 =>
					if (input = "0000") then floor_state <= floor6;
					elsif (input = "0001") then floor_state <= floor6;
					elsif (input = "0010") then floor_state <= floor6;
					elsif (input = "0011") then floor_state <= floor6;
					elsif (input = "0100") then floor_state <= floor6;
					elsif (input = "0101") then floor_state <= floor6;
					elsif (input = "0110") then floor_state <= floor6;
					elsif (input = "0111") then floor_state <= floor7;
					else floor_state <= floor7;
					end if;
				--This line accounts for phantom states
				when others =>
					floor_state <= floor0;
			end case;
		end if;
	end if;
end process;
floor <= "0000" when (floor_state = floor0 ) else
			"0001" when (floor_state = floor1 ) else
			"0010" when (floor_state = floor2 ) else
			"0011" when (floor_state = floor3 ) else
			"0100" when (floor_state = floor4 ) else
			"0101" when (floor_state = floor5 ) else
			"0110" when (floor_state = floor6 ) else
			"0111" when (floor_state = floor7 ) else
			"0000";

end Behavioral;

