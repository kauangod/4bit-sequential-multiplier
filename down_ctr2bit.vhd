library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;

entity down_ctr2bit is
    port (
		  cout   :out std_logic_vector (2 downto 0) := "100";  -- Output of the counter                      
		  enable :in std_logic; 							 -- Enable counting
        clk    :in  std_logic;                      -- Input clock
        reset  :in  std_logic                       -- Input reset
    );
end entity;

architecture rtl of down_ctr2bit is
    signal count :std_logic_vector (2 downto 0) := "100";
begin
    process (clk, reset) begin
        if (reset = '1') then
            count <= (others=>'0');
		  if (enable = '0') then
				count <= "100";
		  end if;
		  elsif (rising_edge(clk)) then
				if (enable = '1') then
					if (count /= "00") then
						count <= count - 1;
					end if;
				end if;
		  end if;
    end process;
    cout <= count;
end architecture;