#!/bin/bash

temp=$(sensors 2>/dev/null | awk '/Package id 0:|Cpu:|temp1:/ {print $2; exit}')



echo $temp
