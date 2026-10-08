//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
  {" Wl:", "nmcli networking connectivity check",10 , 3},
	{"Mem: ",  "free -m | awk '/Mem:/ {printf \"%.2f / %.2f GiB\", $3/1024, $2/1024}'", 10,   4},
	{"Df: ",    "df -h / 2>/dev/null | awk 'NR==2 {gsub(/[^0-9.]/, \"\", $3); printf \"%s GiB\", $3}'",                          3600, 5},
	{"Temp:", "status-systemstats.sh",                                                 30,   0},
	{"",       "date +\"%I:%M %p | %F\"",                                                60,   0},
	{"Bat:",  "cat /sys/class/power_supply/BAT0/capacity | awk '{print $0\"%\"}'",     5,    0}
};

// sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
//Github:lennin331
