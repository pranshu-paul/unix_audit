#!/bin/bash -e

echo "Ensure cramfs kernel module is not available (Automated)"

{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="cramfs" # set module name
 l_mtype="fs" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}


echo "Ensure freevxfs kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="freevxfs" # set module name
 l_mtype="fs" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure hfs kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="hfs" # set module name
 l_mtype="fs" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure hfsplus kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="hfsplus" # set module name
 l_mtype="fs" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure jffs2 kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="jffs2" # set module name
 l_mtype="fs" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure squashfs kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="squashfs" # set module name
 l_mtype="fs" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure udf kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="udf" # set module name
 l_mtype="fs" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure usb-storage kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="usb-storage" # set module name
 l_mtype="drivers" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure /tmp is a separate partition (Automated)"
if ! findmnt -nk /tmp || ! systemctl is-enabled tmp.mount | grep generated; then
  echo -e "\n- Audit Result:"
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"
fi

echo "Ensure nodev option set on /tmp partition (Automated)"
if ! findmnt -kn /tmp | grep -v nodev; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure nosuid option set on /tmp partition (Automated)"
if ! findmnt -kn /tmp | grep -v nosuid; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure noexec option set on /tmp partition (Automated)"
if findmnt -kn /tmp | grep -v noexec; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi  

echo "Ensure /dev/shm is a separate partition (Automated)"
if ! findmnt -kn /dev/shm; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi  

echo "Ensure nodev option set on /dev/shm partition (Automated)"
if ! findmnt -kn /dev/shm | grep -qw 'nodev'; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi  

echo "Ensure nosuid option set on /dev/shm partition (Automated)"
if ! findmnt -kn /dev/shm | grep -qw 'nosuid'; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure noexec option set on /dev/shm partition (Automated)"
if ! findmnt -kn /dev/shm | grep -qw 'noexec'; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi  

echo "Ensure separate partition exists for /home (Automated)"
if ! findmnt -nk /home; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure nodev option set on /home partition (Automated)"
if ! findmnt -nk /home | grep -qw nodev; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi  

echo "Ensure nosuid option set on /home partition (Automated)"
if ! findmnt -nk /home | grep -qw nosuid; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi  

echo "Ensure separate partition exists for /var (Automated)"
if ! findmnt -nk /var; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure nodev option set on /var partition (Automated)"
if ! findmnt -nk /var | grep -qw nodev; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure nosuid option set on /var partition (Automated)"
if ! findmnt -nk /var | grep -qw nosuid; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure separate partition exists for /var/tmp (Automated)"
if ! findmnt -nk /var/tmp; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure nodev option set on /var/tmp partition (Automated)"
if ! findmnt -nk /var/tmp | grep -qw nodev; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure nosuid option set on /var/tmp partition (Automated)"
if ! findmnt -nk /var/tmp | grep -qw nosuid; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure noexec option set on /var/tmp partition (Automated)"
if ! findmnt -nk /var/tmp | grep -qw noexec; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure separate partition exists for /var/log (Automated)"
if ! findmnt -nk /var/log; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure nodev option set on /var/log partition (Automated"
if ! findmnt -nk /var/log | grep -qw nodev; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure nosuid option set on /var/log partition (Automated)"
if ! findmnt -nk /var/log | grep -qw nosuid; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure noexec option set on /var/log partition (Automated)"
if ! findmnt -nk /var/log | grep -qw noexec; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure separate partition exists for /var/log/audit (Automated)"
if ! findmnt -nk /var/log/audit; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure nodev option set on /var/log/audit partition (Automated)"
if ! findmnt -nk /var/log/audit | grep -qw nodev; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi
 
echo "Ensure nosuid option set on /var/log/audit partition (Automated)"
if ! findmnt -nk /var/log/audit | grep -qw nosuid; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure noexec option set on /var/log/audit partition (Automated)"
if ! findmnt -nk /var/log/audit | grep -qw noexec; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure GPG keys are configured (Manual)"
gpg_count=$(grep -r gpgkey /etc/yum.repos.d/* /etc/dnf/dnf.conf | wc -l)
repos_count=$(grep -r baseurl /etc/yum.repos.d/* /etc/dnf/dnf.conf | wc -l)

if [ "$gpg_count" != "$repos_count" ]; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi	


echo "Ensure gpgcheck is globally activated (Automated)"
global_gpg_check=$(grep ^gpgcheck /etc/dnf/dnf.conf | grep -q =1; echo $?)
repos_gpg_check=$(grep -r gpgcheck /etc/yum.repos.d | grep -q gpgcheck=0; echo $?)
if [ "$global_gpg_check" == 0 ] && [ "$repos_gpg_check" != 0 ]; then
  echo -e "\n ** PASS ** \n"  
else
  echo -e "\n ** FAIL ** \n"
fi

echo "Ensure repo_gpgcheck is globally activated (Manual)"
if ! grep ^repo_gpgcheck /etc/dnf/dnf.conf; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi	

for repo in $(grep -l "repo_gpgcheck=0" /etc/yum.repos.d/* ); do
 if ! grep "${REPO_URL}" "${repo}" &>/dev/null; then
 echo Per repositary: "${repo}"
 fi
done

echo "Ensure package manager repositories are configured (Manual)"

dnf repolist
cat /etc/yum.repos.d/*.repo

echo "Ensure updates, patches, and additional security software are installed (Manual)"
#dnf check-update
#dnf needs-restarting -r
#dnf check-update

echo "Ensure bootloader password is set (Automated)"
{
 l_grub_password_file="$(find /boot -type f -name 'user.cfg' ! -empty)"
 if [ -f "$l_grub_password_file" ]; then
 awk -F. '/^\s*GRUB2_PASSWORD=\S+/ {print $1"."$2"."$3}' 
"$l_grub_password_file"
 fi
}

echo "Ensure permissions on bootloader config are configured (Automated)"
{
 l_output="" l_output2="" 
 file_mug_chk()
 {
 l_out="" l_out2=""
 [[ "$(dirname "$l_file")" =~ ^\/boot\/efi\/EFI ]] && l_pmask="0077" || 
l_pmask="0177"
 l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"
 if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
 l_out2="$l_out2\n - Is mode \"$l_mode\" and should be mode: 
\"$l_maxperm\" or more restrictive"
 else
 l_out="$l_out\n - Is correctly mode: \"$l_mode\" which is mode: 
\"$l_maxperm\" or more restrictive"
 fi
 if [ "$l_user" = "root" ]; then
 l_out="$l_out\n - Is correctly owned by user: \"$l_user\""
 else
 l_out2="$l_out2\n - Is owned by user: \"$l_user\" and should be 
owned by user: \"root\""
 fi
 if [ "$l_group" = "root" ]; then
 l_out="$l_out\n - Is correctly group-owned by group: \"$l_user\""
 else
 l_out2="$l_out2\n - Is group-owned by group: \"$l_user\" and 
should be group-owned by group: \"root\""
 fi
 [ -n "$l_out" ] && l_output="$l_output\n - File: \"$l_file\"$l_out\n"
 [ -n "$l_out2" ] && l_output2="$l_output2\n - File: 
\"$l_file\"$l_out2\n"
 }
 while IFS= read -r -d $'\0' l_gfile; do
 while read -r l_file l_mode l_user l_group; do
 file_mug_chk
 done <<< "$(stat -Lc '%n %#a %U %G' "$l_gfile")"
 done < <(find /boot -type f \( -name 'grub*' -o -name 'user.cfg' \) -print0)
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * 
:\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit 
failure * :\n$l_output2\n"
 [ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n"
 fi
}

echo "Ensure address space layout randomization (ASLR) is enabled (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("kernel.randomize_va_space=2")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in \"$(printf 
'%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<<"$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure ptrace_scope is restricted (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("kernel.yama.ptrace_scope=1")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in \"$(printf 
'%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<<"$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure core dump backtraces are disabled (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("ProcessSizeMax=0")
 l_systemd_config_file="/etc/systemd/coredump.conf" # Main systemd configuration file
 config_file_parameter_chk()
 {
 unset A_out; declare -A A_out # Check config file(s) setting
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_systemd_parameter="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "${l_systemd_parameter^^}" = "${l_systemd_parameter_name^^}" ] && 
A_out+=(["$l_systemd_parameter"]="$l_file")
 fi
 fi
 done < <(/usr/bin/systemd-analyze cat-config "$l_systemd_config_file" | grep -Pio 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_systemd_file_parameter_name l_systemd_file_parameter_value; do
 l_systemd_file_parameter_name="${l_systemd_file_parameter_name// /}"
 l_systemd_file_parameter_value="${l_systemd_file_parameter_value// /}"
 if [ "${l_systemd_file_parameter_value^^}" = "${l_systemd_parameter_value^^}" ]; then
 l_output="$l_output\n - \"$l_systemd_parameter_name\" is correctly set to 
\"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is incorrectly set to 
\"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value 
of: \"$l_systemd_parameter_value\"\n"
 fi
 done < <(grep -Pio -- "^\h*$l_systemd_parameter_name\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is not set in an included file\n 
** Note: \"$l_systemd_parameter_name\" May be set in a file that's ignored by load procedure 
**\n"
 fi
 }
 while IFS="=" read -r l_systemd_parameter_name l_systemd_parameter_value; do # Assess and 
check parameters
 l_systemd_parameter_name="${l_systemd_parameter_name// /}"
 l_systemd_parameter_value="${l_systemd_parameter_value// /}"
 config_file_parameter_chk
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure core dump storage is disabled (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("Storage=none")
 l_systemd_config_file="/etc/systemd/coredump.conf" # Main systemd configuration file
 config_file_parameter_chk()
 {
 unset A_out; declare -A A_out # Check config file(s) setting
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_systemd_parameter="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "${l_systemd_parameter^^}" = "${l_systemd_parameter_name^^}" ] && 
A_out+=(["$l_systemd_parameter"]="$l_file")
 fi
 fi
 done < <(/usr/bin/systemd-analyze cat-config "$l_systemd_config_file" | grep -Pio 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_systemd_file_parameter_name l_systemd_file_parameter_value; do
 l_systemd_file_parameter_name="${l_systemd_file_parameter_name// /}"
 l_systemd_file_parameter_value="${l_systemd_file_parameter_value// /}"
 if [ "${l_systemd_file_parameter_value^^}" = "${l_systemd_parameter_value^^}" ]; then
 l_output="$l_output\n - \"$l_systemd_parameter_name\" is correctly set to 
\"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is incorrectly set to 
\"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value 
of: \"$l_systemd_parameter_value\"\n"
 fi
 done < <(grep -Pio -- "^\h*$l_systemd_parameter_name\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is not set in an included file\n 
** Note: \"$l_systemd_parameter_name\" May be set in a file that's ignored by load procedure 
**\n"
 fi
 }
 while IFS="=" read -r l_systemd_parameter_name l_systemd_parameter_value; do # Assess and 
check parameters
 l_systemd_parameter_name="${l_systemd_parameter_name// /}"
 l_systemd_parameter_value="${l_systemd_parameter_value// /}"
 config_file_parameter_chk
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}


echo "Ensure SELinux is installed (Automated)"
if ! rpm -q libselinux; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure SELinux is not disabled in bootloader configuration (Automated)"
grubby --info=ALL | grep -Po '(selinux|enforcing)=0\b'

echo "Ensure SELinux policy is configured (Automated)"
grep -E '^\s*SELINUXTYPE=(targeted|mls)\b' /etc/selinux/config
 
echo "Ensure the SELinux mode is not disabled (Automated)"
getenforce
grep -Ei '^\s*SELINUX=(enforcing|permissive)' /etc/selinux/config
 
echo "Ensure the SELinux mode is enforcing (Automated)"
grep -i SELINUX=enforcing /etc/selinux/config
 
echo "Ensure no unconfined services exist (Automated)"
ps -eZ | grep unconfined_service_t
 
echo "Ensure the MCS Translation Service (mcstrans) is not installed (Automated)"
rpm -q mcstrans

echo "Ensure SETroubleshoot is not installed (Automated)"
if rpm -q setroubleshoot; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure system wide crypto policy is not set to legacy (Automated)"
grep -Pi '^\h*LEGACY\b' /etc/crypto-policies/config

echo "Ensure system wide crypto policy disables sha1 hash and signature support (Automated)"
grep -Pi -- '^\h*(hash|sign)\h*=\h*([^\n\r#]+)?-sha1\b' /etc/crypto-policies/state/CURRENT.pol
grep -Pi -- '^\h*sha1_in_certs\h*=\h*' /etc/crypto-policies/state/CURRENT.pol


echo "Ensure system wide crypto policy disables cbc for ssh (Automated)"
{
 l_output="" l_output2=""
 if grep -Piq -- '^\h*cipher\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then
 if grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*' /etc/crypto-policies/state/CURRENT.pol; then
 if ! grep -Piq -- '^\h*cipher@(lib|open)ssh(-server|-client)?\h*=\h*([^#\n\r]+)?-CBC\b' /etc/crypto-policies/state/CURRENT.pol; then
 l_output="$l_output\n - Cipher Block Chaining (CBC) is disabled
for SSH"
 else
 l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled
for SSH"
 fi
 else
 l_output2="$l_output2\n - Cipher Block Chaining (CBC) is enabled for
SSH"
 fi
 else
 l_output=" - Cipher Block Chaining (CBC) is disabled"
 fi
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit
failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure system wide crypto policy disables macs less than 128 bits (Automated)"
grep -Pi -- '^\h*mac\h*=\h*([^#\n\r]+)?-64\b' /etc/crypto-policies/state/CURRENT.pol
 
echo "Ensure local login warning banner is configured properly (Automated)"
cat /etc/motd
cat /etc/issue
grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/motd
grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -
f2 | sed -e 's/"//g'))" /etc/issue

echo "Ensure remote login warning banner is configured properly (Automated)"
cat /etc/issue.net

echo grep -E -i "(\\\v|\\\r|\\\m|\\\s|$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g'))" /etc/issue.net

echo "Ensure access to /etc/motd is configured (Automated)"
[ -e /etc/motd ] && stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/motd

echo "Ensure access to /etc/issue is configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: { %g/ %G)' /etc/issue

echo "Ensure access to /etc/issue.net is configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: { %g/ %G)' /etc/issue.net

echo "Ensure GNOME Display Manager is removed (Automated)"
if ! rpm -q gdm; then
  echo -e "\n ** FAIL ** \n"
else
	echo -e "\n ** PASS ** \n"  
fi

echo "Ensure GDM login banner is configured (Automated)"
{
 l_pkgoutput=""
 if command -v dpkg-query > /dev/null 2>&1; then
 l_pq="dpkg-query -W"
 elif command -v rpm > /dev/null 2>&1; then
 l_pq="rpm -q"
 fi
 l_pcl="gdm gdm3" # Space seporated list of packages to check
 for l_pn in $l_pcl; do
 $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists 
on the system\n - checking configuration"
 done
 if [ -n "$l_pkgoutput" ]; then
 l_output="" l_output2=""
 echo -e "$l_pkgoutput"
 # Look for existing settings and set variables if they exist
 l_gdmfile="$(grep -Prils '^\h*banner-message-enable\b' /etc/dconf/db/*.d)"
 if [ -n "$l_gdmfile" ]; then
 # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
 l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")"
 # Check if banner message is enabled
 if grep -Pisq '^\h*banner-message-enable=true\b' "$l_gdmfile"; then
 l_output="$l_output\n - The \"banner-message-enable\" option is enabled in 
\"$l_gdmfile\""
 else
 l_output2="$l_output2\n - The \"banner-message-enable\" option is not enabled"
 fi
 l_lsbt="$(grep -Pios '^\h*banner-message-text=.*$' "$l_gdmfile")"
 if [ -n "$l_lsbt" ]; then
 l_output="$l_output\n - The \"banner-message-text\" option is set in \"$l_gdmfile\"\n 
- banner-message-text is set to:\n - \"$l_lsbt\""
 else
 l_output2="$l_output2\n - The \"banner-message-text\" option is not set"
 fi
 if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then
 l_output="$l_output\n - The \"$l_gdmprofile\" profile exists"
 else
 l_output2="$l_output2\n - The \"$l_gdmprofile\" profile doesn't exist"
 fi
 if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then
 l_output="$l_output\n - The \"$l_gdmprofile\" profile exists in the dconf database"
 else
 l_output2="$l_output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf 
database"
 fi
 else
 l_output2="$l_output2\n - The \"banner-message-enable\" option isn't configured"
 fi
 else
 echo -e "\n\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not 
Applicable\n- Audit result:\n *** PASS ***\n"
 fi
 # Report results. If no failures output in l_output2, we pass
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure GDM disable-user-list option is enabled (Automated)"
{
 l_pkgoutput=""
 if command -v dpkg-query > /dev/null 2>&1; then
 l_pq="dpkg-query -W"
 elif command -v rpm > /dev/null 2>&1; then
 l_pq="rpm -q"
 fi
 l_pcl="gdm gdm3" # Space seporated list of packages to check
 for l_pn in $l_pcl; do
 $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists 
on the system\n - checking configuration"
 done
 if [ -n "$l_pkgoutput" ]; then
 output="" output2=""
 l_gdmfile="$(grep -Pril '^\h*disable-user-list\h*=\h*true\b' /etc/dconf/db)"
 if [ -n "$l_gdmfile" ]; then
 output="$output\n - The \"disable-user-list\" option is enabled in \"$l_gdmfile\""
 l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")"
 if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then
 output="$output\n - The \"$l_gdmprofile\" exists"
 else
 output2="$output2\n - The \"$l_gdmprofile\" doesn't exist"
 fi
 if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then
 output="$output\n - The \"$l_gdmprofile\" profile exists in the dconf database"
 else
 output2="$output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf 
database"
 fi
 else
 output2="$output2\n - The \"disable-user-list\" option is not enabled"
 fi
 if [ -z "$output2" ]; then
 echo -e "$l_pkgoutput\n- Audit result:\n *** PASS: ***\n$output\n"
 else
 echo -e "$l_pkgoutput\n- Audit Result:\n *** FAIL: ***\n$output2\n"
 [ -n "$output" ] && echo -e "$output\n"
 fi
 else
 echo -e "\n\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not 
Applicable\n- Audit result:\n *** PASS ***\n"
 fi
}

echo "Ensure GDM screen locks when the user is idle (Automated)"
{
 # Check if GNMOE Desktop Manager is installed. If package isn't 
installed, recommendation is Not Applicable\n
 # determine system's package manager
 l_pkgoutput=""
 if command -v dpkg-query > /dev/null 2>&1; then
 l_pq="dpkg-query -W"
 elif command -v rpm > /dev/null 2>&1; then
 l_pq="rpm -q"
 fi
 # Check if GDM is installed
 l_pcl="gdm gdm3" # Space seporated list of packages to check
 for l_pn in $l_pcl; do
 $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n -
Package: \"$l_pn\" exists on the system\n - checking configuration"
 done
 # Check configuration (If applicable)
 if [ -n "$l_pkgoutput" ]; then
 l_output="" l_output2=""
 l_idmv="900" # Set for max value for idle-delay in seconds
 l_ldmv="5" # Set for max value for lock-delay in seconds
 # Look for idle-delay to determine profile in use, needed for remaining 
tests
 l_kfile="$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' 
/etc/dconf/db/*/)" # Determine file containing idle-delay key
 if [ -n "$l_kfile" ]; then
 # set profile name (This is the name of a dconf database)
 l_profile="$(awk -F'/' '{split($(NF-1),a,".");print a[1]}' <<< 
"$l_kfile")" #Set the key profile name
 l_pdbdir="/etc/dconf/db/$l_profile.d" # Set the key file dconf db 
directory
 # Confirm that idle-delay exists, includes unit32, and value is 
between 1 and max value for idle-delay
 l_idv="$(awk -F 'uint32' '/idle-delay/{print $2}' "$l_kfile" | 
xargs)"
 if [ -n "$l_idv" ]; then
 [ "$l_idv" -gt "0" -a "$l_idv" -le "$l_idmv" ] && 
l_output="$l_output\n - The \"idle-delay\" option is set to \"$l_idv\" 
seconds in \"$l_kfile\""
 [ "$l_idv" = "0" ] && l_output2="$l_output2\n - The \"idle delay\" option is set to \"$l_idv\" (disabled) in \"$l_kfile\""
 [ "$l_idv" -gt "$l_idmv" ] && l_output2="$l_output2\n - The 
\"idle-delay\" option is set to \"$l_idv\" seconds (greater than $l_idmv) in 
\"$l_kfile\""
 else
 l_output2="$l_output2\n - The \"idle-delay\" option is not set in 
\"$l_kfile\""
 fi
 # Confirm that lock-delay exists, includes unit32, and value is 
between 0 and max value for lock-delay
 l_ldv="$(awk -F 'uint32' '/lock-delay/{print $2}' "$l_kfile" | 
xargs)"
 if [ -n "$l_ldv" ]; then
 [ "$l_ldv" -ge "0" -a "$l_ldv" -le "$l_ldmv" ] && 
l_output="$l_output\n - The \"lock-delay\" option is set to \"$l_ldv\" 
Page 223
seconds in \"$l_kfile\""
 [ "$l_ldv" -gt "$l_ldmv" ] && l_output2="$l_output2\n - The 
\"lock-delay\" option is set to \"$l_ldv\" seconds (greater than $l_ldmv) in 
\"$l_kfile\""
 else
 l_output2="$l_output2\n - The \"lock-delay\" option is not set in 
\"$l_kfile\""
 fi
 # Confirm that dconf profile exists
 if grep -Psq "^\h*system-db:$l_profile" /etc/dconf/profile/*; then
 l_output="$l_output\n - The \"$l_profile\" profile exists"
 else
 l_output2="$l_output2\n - The \"$l_profile\" doesn't exist"
 fi
 # Confirm that dconf profile database file exists
 if [ -f "/etc/dconf/db/$l_profile" ]; then
 l_output="$l_output\n - The \"$l_profile\" profile exists in the 
dconf database"
 else
 l_output2="$l_output2\n - The \"$l_profile\" profile doesn't 
exist in the dconf database"
 fi
 else
 l_output2="$l_output2\n - The \"idle-delay\" option doesn't exist, 
remaining tests skipped"
 fi
 else
 l_output="$l_output\n - GNOME Desktop Manager package is not installed 
on the system\n - Recommendation is not applicable"
 fi
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit 
failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure GDM screen locks cannot be overridden (Automated)"
{
 # Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is 
Not Applicable\n
 # determine system's package manager
 l_pkgoutput=""
 if command -v dpkg-query > /dev/null 2>&1; then
 l_pq="dpkg-query -W"
 elif command -v rpm > /dev/null 2>&1; then
 l_pq="rpm -q"
 fi
 # Check if GDM is installed
 l_pcl="gdm gdm3" # Space seporated list of packages to check
 for l_pn in $l_pcl; do
 $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists 
on the system\n - checking configuration"
 done
 # Check configuration (If applicable)
 if [ -n "$l_pkgoutput" ]; then
 l_output="" l_output2=""
 # Look for idle-delay to determine profile in use, needed for remaining tests
 l_kfd="/etc/dconf/db/$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | 
awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
 l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*lock-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ 
| awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
 if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked
 if grep -Prilq '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd"; then
 l_output="$l_output\n - \"idle-delay\" is locked in \"$(grep -Pril 
'\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd")\""
 else
 l_output2="$l_output2\n - \"idle-delay\" is not locked"
 fi
 else
 l_output2="$l_output2\n - \"idle-delay\" is not set so it can not be locked"
 fi
 if [ -d "$l_kfd2" ]; then # If key file directory doesn't exist, options can't be locked
 if grep -Prilq '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2"; then
 l_output="$l_output\n - \"lock-delay\" is locked in \"$(grep -Pril 
'\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2")\""
 else
 l_output2="$l_output2\n - \"lock-delay\" is not locked"
 fi
 else
 l_output2="$l_output2\n - \"lock-delay\" is not set so it can not be locked"
 fi
 else
 l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n -
Recommendation is not applicable"
 fi
 # Report results. If no failures output in l_output2, we pass
[ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure GDM automatic mounting of removable media is disabled (Automated)"
{
 l_pkgoutput="" l_output="" l_output2=""
 # Check if GNOME Desktop Manager is installed. If package isn't 
installed, recommendation is Not Applicable\n
 # determine system's package manager
 if command -v dpkg-query > /dev/null 2>&1; then
 l_pq="dpkg-query -W"
 elif command -v rpm > /dev/null 2>&1; then
 l_pq="rpm -q"
 fi
 # Check if GDM is installed
 l_pcl="gdm gdm3" # Space seporated list of packages to check
 for l_pn in $l_pcl; do
 $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n -
Package: \"$l_pn\" exists on the system\n - checking configuration"
 done
 # Check configuration (If applicable)
 if [ -n "$l_pkgoutput" ]; then
 echo -e "$l_pkgoutput"
 # Look for existing settings and set variables if they exist
 l_kfile="$(grep -Prils -- '^\h*automount\b' /etc/dconf/db/*.d)"
 l_kfile2="$(grep -Prils -- '^\h*automount-open\b' /etc/dconf/db/*.d)"
 # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
 if [ -f "$l_kfile" ]; then
 l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< 
"$l_kfile")"
 elif [ -f "$l_kfile2" ]; then
 l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< 
"$l_kfile2")"
 fi
 # If the profile name exist, continue checks
 if [ -n "$l_gpname" ]; then
 l_gpdir="/etc/dconf/db/$l_gpname.d"
 # Check if profile file exists
 if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; 
then
 l_output="$l_output\n - dconf database profile file \"$(grep -Pl 
-- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists"
 else
 l_output2="$l_output2\n - dconf database profile isn't set"
 fi
 # Check if the dconf database file exists
 if [ -f "/etc/dconf/db/$l_gpname" ]; then
 l_output="$l_output\n - The dconf database \"$l_gpname\" exists"
 else
 l_output2="$l_output2\n - The dconf database \"$l_gpname\" 
doesn't exist"
 fi
 # check if the dconf database directory exists
 if [ -d "$l_gpdir" ]; then
 l_output="$l_output\n - The dconf directory \"$l_gpdir\" exitst"
 else
 l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" 
doesn't exist"
 fi
 # check automount setting
 if grep -Pqrs -- '^\h*automount\h*=\h*false\b' "$l_kfile"; then
 l_output="$l_output\n - \"automount\" is set to false in: 
\"$l_kfile\""
 else
 l_output2="$l_output2\n - \"automount\" is not set correctly"
 fi
 # check automount-open setting
 if grep -Pqs -- '^\h*automount-open\h*=\h*false\b' "$l_kfile2"; then
 l_output="$l_output\n - \"automount-open\" is set to false in: 
\"$l_kfile2\""
 else
 l_output2="$l_output2\n - \"automount-open\" is not set 
correctly"
 fi
 else
 # Setings don't exist. Nothing further to check
 l_output2="$l_output2\n - neither \"automount\" or \"automountopen\" is set"
 fi
 else
 l_output="$l_output\n - GNOME Desktop Manager package is not installed 
on the system\n - Recommendation is not applicable"
 fi
 # Report results. If no failures output in l_output2, we pass
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit 
failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure GDM disabling automatic mounting of removable media is not overridden (Automated)"
{
 # Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is 
Not Applicable\n
 # determine system's package manager
 l_pkgoutput=""
 if command -v dpkg-query > /dev/null 2>&1; then
 l_pq="dpkg-query -W"
 elif command -v rpm > /dev/null 2>&1; then
 l_pq="rpm -q"
 fi
 # Check if GDM is installed
 l_pcl="gdm gdm3" # Space seporated list of packages to check
 for l_pn in $l_pcl; do
 $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists 
on the system\n - checking configuration"
 done
 # Check configuration (If applicable)
 if [ -n "$l_pkgoutput" ]; then
 l_output="" l_output2=""
 echo -e "$l_pkgoutput\n"
 # Look for idle-delay to determine profile in use, needed for remaining tests
 l_kfd="/etc/dconf/db/$(grep -Psril '^\h*automount\b' /etc/dconf/db/*/ | awk -F'/' 
'{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
 l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*automount-open\b' /etc/dconf/db/*/ | awk -F'/' 
'{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
 if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked
 if grep -Priq '^\h*\/org/gnome\/desktop\/media-handling\/automount\b' "$l_kfd"; then
 l_output="$l_output\n - \"automount\" is locked in \"$(grep -Pril 
'^\h*\/org/gnome\/desktop\/media-handling\/automount\b' "$l_kfd")\""
 else
 l_output2="$l_output2\n - \"automount\" is not locked"
 fi
 else
 l_output2="$l_output2\n - \"automount\" is not set so it can not be locked"
 fi
 if [ -d "$l_kfd2" ]; then # If key file directory doesn't exist, options can't be locked
 if grep -Priq '^\h*\/org/gnome\/desktop\/media-handling\/automount-open\b' "$l_kfd2"; 
then
 l_output="$l_output\n - \"lautomount-open\" is locked in \"$(grep -Pril 
'^\h*\/org/gnome\/desktop\/media-handling\/automount-open\b' "$l_kfd2")\""
 else
 l_output2="$l_output2\n - \"automount-open\" is not locked"
 fi
 else
 l_output2="$l_output2\n - \"automount-open\" is not set so it can not be locked"
 fi
 else
 l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n -
Recommendation is not applicable"
 fi
 # Report results. If no failures output in l_output2, we pass
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure GDM autorun-never is enabled (Automated)"
{
 l_pkgoutput="" l_output="" l_output2=""
 # Check if GNOME Desktop Manager is installed. If package isn't 
installed, recommendation is Not Applicable\n
 # determine system's package manager
 if command -v dpkg-query > /dev/null 2>&1; then
 l_pq="dpkg-query -W"
 elif command -v rpm > /dev/null 2>&1; then
 l_pq="rpm -q"
 fi
 # Check if GDM is installed
 l_pcl="gdm gdm3" # Space separated list of packages to check
 for l_pn in $l_pcl; do
 $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n -
Package: \"$l_pn\" exists on the system\n - checking configuration"
 echo -e "$l_pkgoutput"
 done
 # Check configuration (If applicable)
 if [ -n "$l_pkgoutput" ]; then
 echo -e "$l_pkgoutput"
 # Look for existing settings and set variables if they exist
 l_kfile="$(grep -Prils -- '^\h*autorun-never\b' /etc/dconf/db/*.d)"
 # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
 if [ -f "$l_kfile" ]; then
 l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< 
"$l_kfile")"
 fi
 # If the profile name exist, continue checks
 if [ -n "$l_gpname" ]; then
 l_gpdir="/etc/dconf/db/$l_gpname.d"
 # Check if profile file exists
 if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; 
then
 l_output="$l_output\n - dconf database profile file \"$(grep -Pl 
-- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists"
 else
 l_output2="$l_output2\n - dconf database profile isn't set"
 fi
 # Check if the dconf database file exists
 if [ -f "/etc/dconf/db/$l_gpname" ]; then
 l_output="$l_output\n - The dconf database \"$l_gpname\" exists"
 else
 l_output2="$l_output2\n - The dconf database \"$l_gpname\"
doesn't exist"
 fi
 # check if the dconf database directory exists
 if [ -d "$l_gpdir" ]; then
 l_output="$l_output\n - The dconf directory \"$l_gpdir\" exitst"
 else
 l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" 
doesn't exist"
 fi
 # check autorun-never setting
 if grep -Pqrs -- '^\h*autorun-never\h*=\h*true\b' "$l_kfile"; then
 l_output="$l_output\n - \"autorun-never\" is set to true in:
 \"$l_kfile\""
 else
 l_output2="$l_output2\n - \"autorun-never\" is not set correctly"
 fi
 else
 # Settings don't exist. Nothing further to check
 l_output2="$l_output2\n - \"autorun-never\" is not set"
 fi
 else
 l_output="$l_output\n - GNOME Desktop Manager package is not installed 
on the system\n - Recommendation is not applicable"
 fi
 # Report results. If no failures output in l_output2, we pass
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit 
failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure GDM autorun-never is not overridden (Automated)"
{
 # Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is 
Not Applicable\n
 # determine system's package manager
 l_pkgoutput=""
 if command -v dpkg-query > /dev/null 2>&1; then
 l_pq="dpkg-query -W"
 elif command -v rpm > /dev/null 2>&1; then
 l_pq="rpm -q"
 fi
 # Check if GDM is installed
 l_pcl="gdm gdm3" # Space separated list of packages to check
 for l_pn in $l_pcl; do
 $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists 
on the system\n - checking configuration"
 done
 # Check configuration (If applicable)
 if [ -n "$l_pkgoutput" ]; then
 l_output="" l_output2=""
 echo -e "$l_pkgoutput\n"
 # Look for idle-delay to determine profile in use, needed for remaining tests
 l_kfd="/etc/dconf/db/$(grep -Psril '^\h*autorun-never\b' /etc/dconf/db/*/ | awk -F'/' 
'{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
 if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked
 if grep -Priq '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd"; then
 l_output="$l_output\n - \"autorun-never\" is locked in \"$(grep -Pril 
'^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd")\""
 else
 l_output2="$l_output2\n - \"autorun-never\" is not locked"
 fi
 else
 l_output2="$l_output2\n - \"autorun-never\" is not set so it can not be locked"
 fi
 else
 l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n -
Recommendation is not applicable"
 fi
 # Report results. If no failures output in l_output2, we pass
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure XDMCP is not enabled (Automated)"
grep -Eis '^\s*Enable\s*=\s*true' /etc/gdm/custom.conf

echo "Ensure time synchronization is in use (Automated)"
rpm -q chrony
 
echo "Ensure chrony is configured (Automated)"
grep -Prs -- '^\h*(server|pool)\h+[^#\n\r]+' /etc/chrony.conf /etc/chrony.d/

echo "Ensure chrony is not run as the root user (Automated)"
grep -Psi -- '^\h*OPTIONS=\"?\h+-u\h+root\b' /etc/sysconfig/chronyd
 
echo "Ensure autofs services are not in use (Automated)"
rpm -q autofs
systemctl is-enabled autofs.service 2>/dev/null | grep 'enabled'
systemctl is-active autofs.service 2>/dev/null | grep '^active'

echo "Ensure avahi daemon services are not in use (Automated)"
rpm -q avahi

systemctl is-enabled avahi-daemon.socket avahi-daemon.service 2>/dev/null | 
grep 'enabled'
systemctl is-active avahi-daemon.socket avahi-daemon.service 2>/dev/null | 
grep '^active'

echo "Ensure dhcp server services are not in use (Automated)"
rpm -q dhcp-server
systemctl is-enabled dhcpd.service dhcpd6.service 2>/dev/null | grep 'enabled'
systemctl is-active dhcpd.service dhcpd6.service 2>/dev/null | grep '^active'

echo "Ensure dns server services are not in use (Automated)"
rpm -q bind
systemctl is-enabled named.service 2>/dev/null | grep 'enabled'
systemctl is-active named.service 2>/dev/null | grep '^active'

echo "Ensure dnsmasq services are not in use (Automated)"
rpm -q dnsmasq
systemctl is-enabled dnsmasq.service 2>/dev/null | grep 'enabled'
systemctl is-active dnsmasq.service 2>/dev/null | grep '^active'

echo "Ensure samba file server services are not in use (Automated)"
rpm -q samba
systemctl is-enabled smb.service 2>/dev/null | grep 'enabled'
systemctl is-active smb.service 2>/dev/null | grep '^active'

echo "Ensure ftp server services are not in use (Automated)"
rpm -q vsftpd
systemctl is-enabled vsftpd.service 2>/dev/null | grep 'enabled'
systemctl is-active vsftpd.service 2>/dev/null | grep '^active'
 
echo "Ensure message access server services are not in use (Automated)"
rpm -q dovecot cyrus-imapd
systemctl is-enabled dovecot.socket dovecot.service cyrus-imapd.service 2>/dev/null | grep 'enabled'
systemctl is-active dovecot.socket dovecot.service cyrus-imapd.service 2>/dev/null | grep '^active'

echo "Ensure network file system services are not in use (Automated)"
rpm -q nfs-utils
systemctl is-enabled nfs-server.service 2>/dev/null | grep 'enabled'
systemctl is-active nfs-server.service 2>/dev/null | grep '^active'

echo "Ensure nis server services are not in use (Automated)"
rpm -q ypserv
systemctl is-enabled ypserv.service 2>/dev/null | grep 'enabled'
systemctl is-active ypserv.service 2>/dev/null | grep '^active'

echo "Ensure print server services are not in use (Automated)"
rpm -q cups
systemctl is-enabled cups.socket cups.service 2>/dev/null | grep 'enabled'
systemctl is-active cups.socket cups.service 2>/dev/null | grep '^active'
  
echo "Ensure rpcbind services are not in use (Automated)"
rpm -q rpcbind
systemctl is-enabled rpcbind.socket rpcbind.service 2>/dev/null | grep 'enabled'
systemctl is-active rpcbind.socket rpcbind.service 2>/dev/null | grep '^active'

echo "Ensure rsync services are not in use (Automated)"
rpm -q rsync-daemon
systemctl is-enabled rsyncd.socket rsyncd.service 2>/dev/null | grep 'enabled'
systemctl is-active rsyncd.socket rsyncd.service 2>/dev/null | grep '^active'
 
echo "Ensure snmp services are not in use (Automated)"
rpm -q net-snmp
systemctl is-enabled snmpd.service 2>/dev/null | grep 'enabled'
systemctl is-active snmpd.service 2>/dev/null | grep '^active'

echo "Ensure telnet server services are not in use (Automated)"
systemctl is-enabled telnet.socket 2>/dev/null | grep 'enabled'
systemctl is-active telnet.socket 2>/dev/null | grep '^active'

echo "Ensure tftp server services are not in use (Automated)"
rpm -q tftp-server
systemctl is-enabled tftp.socket tftp.service 2>/dev/null | grep 'enabled'
systemctl is-active tftp.socket tftp.service 2>/dev/null | grep '^active'

echo "Ensure web proxy server services are not in use (Automated)"
rpm -q squid
systemctl is-enabled squid.service 2>/dev/null | grep 'enabled'
systemctl is-active squid.service 2>/dev/null | grep '^active'

echo "Ensure web server services are not in use (Automated)"
rpm -q httpd nginx
systemctl is-enabled httpd.socket httpd.service nginx.service 2>/dev/null | grep 'enabled'
systemctl is-active httpd.socket httpd.service nginx.service 2>/dev/null | grep '^active'

echo "Ensure xinetd services are not in use (Automated)"
rpm -q xinetd
systemctl is-enabled xinetd.service 2>/dev/null | grep 'enabled'
systemctl is-active xinetd.service 2>/dev/null | grep '^active'

echo "Ensure X window server services are not in use (Automated)"
rpm -q xorg-x11-server-common

echo "Ensure mail transfer agents are configured for local-only mode (Automated)"
ss -plntu | grep -P -- ':25\b' | grep -Pv -- '\h+(127\.0\.0\.1|\[?::1\]?):25\b'
ss -plntu | grep -P -- ':465\b' | grep -Pv -- '\h+(127\.0\.0\.1|\[?::1\]?):465\b'
ss -plntu | grep -P -- ':587\b' | grep -Pv -- '\h+(127\.0\.0\.1|\[?::1\]?):587\b'

echo "Ensure only approved services are listening on a network interface (Manual)"
ss -plntu

echo "Ensure ftp client is not installed (Automated)"
rpm -q ftp
 
echo "Ensure ldap client is not installed (Automated)"
rpm -q openldap-clients

echo "Ensure nis client is not installed (Automated)"
rpm -q ypbind

echo "Ensure telnet client is not installed (Automated)"
rpm -q telnet

echo "Ensure tftp client is not installed (Automated)"
rpm -q tftp
 
echo "Ensure IPv6 status is identified (Manual)"
grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && echo -e "\n - IPv6 is enabled\n" || echo -e "\n - IPv6 is not enabled\n"

echo "Ensure wireless interfaces are disabled (Automated)"
{
 l_output="" l_output2=""
 module_chk()
 {
 # Check how module will be loaded
 l_loadable="$(modprobe -n -v "$l_mname")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 # Check is the module currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 # Check if the module is deny listed
 if modprobe --showconfig | grep -Pq -- "^\h*blacklist\h+$l_mname\b"; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pl --
"^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then
 l_dname=$(for driverdir in $(find /sys/class/net/*/ -type d -name wireless | xargs -0 
dirname); do basename "$(readlink -f "$driverdir"/device/driver/module)";done | sort -u)
 for l_mname in $l_dname; do
 module_chk
 done
 fi
 # Report results. If no failures output in l_output2, we pass
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **"
 if [ -z "$l_output" ]; then
 echo -e "\n - System has no wireless NICs installed"
 else
 echo -e "\n$l_output\n"
 fi
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure bluetooth services are not in use (Automated)"
rpm -q bluez
systemctl is-enabled bluetooth.service 2>/dev/null | grep 'enabled'
systemctl is-active bluetooth.service 2>/dev/null | grep '^active'

echo "Ensure dccp kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="dccp" # set module name
 l_mtype="net" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure tipc kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="tipc" # set module name
 l_mtype="net" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure rds kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="rds" # set module name
 l_mtype="net" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure sctp kernel module is not available (Automated)"
{
 l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
 l_mname="sctp" # set module name
 l_mtype="net" # set module type
 l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf 
/etc/modprobe.d/*.conf"
 l_mpath="/lib/modules/**/kernel/$l_mtype"
 l_mpname="$(tr '-' '_' <<< "$l_mname")"
 l_mndir="$(tr '-' '/' <<< "$l_mname")"
 module_loadable_chk()
 {
 # Check if the module is currently loadable
 l_loadable="$(modprobe -n -v "$l_mname")"
 [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
 if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
 l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
 fi
 }
 module_loaded_chk()
 {
 # Check if the module is currently loaded
 if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
 l_output="$l_output\n - module: \"$l_mname\" is not loaded"
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
 fi
 }
 module_deny_chk()
 {
 # Check if the module is deny listed
 l_dl="y"
 if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
 l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
 else
 l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
 fi
 }
 # Check if the module exists on the system
 for l_mdir in $l_mpath; do
 if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
 l_output3="$l_output3\n - \"$l_mdir\""
 [ "$l_dl" != "y" ] && module_deny_chk
 if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
 module_loadable_chk
 module_loaded_chk
 fi
 else
 l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
 fi
 done
 # Report results. If no failures output in l_output2, we pass
 [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure ip forwarding is disabled (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.ip_forward=0" "net.ipv6.conf.all.forwarding=0")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<<"$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure packet redirect sending is disabled (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.conf.all.send_redirects=0" "net.ipv4.conf.default.send_redirects=0")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure bogus icmp responses are ignored (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.icmp_ignore_bogus_error_responses=1")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure broadcast icmp requests are ignored (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.icmp_echo_ignore_broadcasts=1")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure icmp redirects are not accepted (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.conf.all.accept_redirects=0" "net.ipv4.conf.default.accept_redirects=0" 
"net.ipv6.conf.all.accept_redirects=0" "net.ipv6.conf.default.accept_redirects=0")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure secure icmp redirects are not accepted (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.conf.all.secure_redirects=0" "net.ipv4.conf.default.secure_redirects=0")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure reverse path filtering is enabled (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.conf.all.rp_filter=1" "net.ipv4.conf.default.rp_filter=1")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure source routed packets are not accepted (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.conf.all.accept_source_route=0" 
"net.ipv4.conf.default.accept_source_route=0" "net.ipv6.conf.all.accept_source_route=0" 
"net.ipv6.conf.default.accept_source_route=0")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure suspicious packets are logged (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.conf.all.log_martians=1" "net.ipv4.conf.default.log_martians=1")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure tcp syn cookies is enabled (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv4.tcp_syncookies=1")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure ipv6 router advertisements are not accepted (Automated)"
{
 l_output="" l_output2=""
 a_parlist=("net.ipv6.conf.all.accept_ra=0" "net.ipv6.conf.default.accept_ra=0")
 l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' 
/etc/default/ufw)"
 kernel_parameter_chk()
 { 
 l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
 if [ "$l_krp" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running 
configuration"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running 
configuration and should have a value of: \"$l_kpvalue\""
 fi
 unset A_out; declare -A A_out # Check durable setting (files)
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
 fi
 fi
 done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
 l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
 l_kpar="${l_kpar//\//.}"
 [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
 fi
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_fkpname l_fkpvalue; do
 l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
 if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
 l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in 
\"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
 fi
 done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n ** Note: 
\"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
 fi
 }
 while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
 l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
 if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
 l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
 else
 kernel_parameter_chk
 fi
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

echo "Ensure nftables is installed (Automated)"
rpm -q nftables

echo "Ensure a single firewall configuration utility is in use (Automated)"
{
 l_output="" l_output2="" l_fwd_status="" l_nft_status="" 
l_fwutil_status=""
 # Determine FirewallD utility Status
 rpm -q firewalld > /dev/null 2>&1 && l_fwd_status="$(systemctl is-enabled 
firewalld.service):$(systemctl is-active firewalld.service)"
 # Determine NFTables utility Status
 rpm -q nftables > /dev/null 2>&1 && l_nft_status="$(systemctl is-enabled 
nftables.service):$(systemctl is-active nftables.service)"
 l_fwutil_status="$l_fwd_status:$l_nft_status"
 case $l_fwutil_status in
 enabled:active:masked:inactive|enabled:active:disabled:inactive) 
 l_output="\n - FirewallD utility is in use, enabled and active\n -
NFTables utility is correctly disabled or masked and inactive" ;;
 masked:inactive:enabled:active|disabled:inactive:enabled:active) 
 l_output="\n - NFTables utility is in use, enabled and active\n -
FirewallD utility is correctly disabled or masked and inactive" ;;
 enabled:active:enabled:active)
 l_output2="\n - Both FirewallD and NFTables utilities are enabled 
and active" ;;
 enabled:*:enabled:*)
 l_output2="\n - Both FirewallD and NFTables utilities are enabled" 
;;
 *:active:*:active) 
 l_output2="\n - Both FirewallD and NFTables utilities are enabled" 
;;
 :enabled:active) 
 l_output="\n - NFTables utility is in use, enabled, and active\n -
FirewallD package is not installed" ;;
 :) 
 l_output2="\n - Neither FirewallD or NFTables is installed." ;;
 *:*:) 
 l_output2="\n - NFTables package is not installed on the system" ;;
 *) 
 l_output2="\n - Unable to determine firewall state" ;;
 esac
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Results:\n ** Pass **\n$l_output\n"
 else
 echo -e "\n- Audit Results:\n ** Fail **\n$l_output2\n"
 fi
}

echo "Ensure nftables base chains exist (Automated)"
nft list ruleset | grep 'hook input'
nft list ruleset | grep 'hook forward'
 
echo "Ensure host based firewall loopback traffic is configured (Automated)"
{
 l_output="" l_output2=""
 if nft list ruleset | awk '/hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -Pq --
'\H+\h+"lo"\h+accept'; then
 l_output="$l_output\n - Network traffic to the loopback address is 
correctly set to accept"
 else
 l_output2="$l_output2\n - Network traffic to the loopback address is 
not set to accept"
 fi
 l_ipsaddr="$(nft list ruleset | awk 
'/filter_IN_public_deny|hook\s+input\s+/,/\}\s*(#.*)?$/' | grep -P --
'ip\h+saddr')"
 if grep -Pq --
'ip\h+saddr\h+127\.0\.0\.0\/8\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?dr
op' <<< "$l_ipsaddr" || grep -Pq --
'ip\h+daddr\h+\!\=\h+127\.0\.0\.1\h+ip\h+saddr\h+127\.0\.0\.1\h+drop' <<< "$l_ipsaddr"; then
 l_output="$l_output\n - IPv4 network traffic from loopback address 
correctly set to drop"
 else
 l_output2="$l_output2\n - IPv4 network traffic from loopback address 
not set to drop"
 fi
 if grep -Pq -- '^\h*0\h*$' /sys/module/ipv6/parameters/disable; then
 l_ip6saddr="$(nft list ruleset | awk '/filter_IN_public_deny|hook 
input/,/}/' | grep 'ip6 saddr')"
 if grep -Pq 
'ip6\h+saddr\h+::1\h+(counter\h+packets\h+\d+\h+bytes\h+\d+\h+)?drop' <<< "$l_ip6saddr" || grep -Pq --
'ip6\h+daddr\h+\!=\h+::1\h+ip6\h+saddr\h+::1\h+drop' <<< "$l_ip6saddr"; then
 l_output="$l_output\n - IPv6 network traffic from loopback address 
correctly set to drop"
 else
 l_output2="$l_output2\n - IPv6 network traffic from loopback address 
not set to drop"
 fi
 fi
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n *** PASS ***\n$l_output"
 else
 echo -e "\n- Audit Result:\n *** FAIL ***\n$l_output2\n\n - Correctly 
set:\n$l_output"
 fi
}

echo "Ensure firewalld drops unnecessary services and ports (Manual)"
systemctl is-enabled firewalld.service | grep -q 'enabled' && firewall-cmd --list-all --zone="$(firewall-cmd --list-all | awk '/\(active\)/ { print $1 }')" | grep -P -- '^\h*(services:|ports:)'

echo "Ensure nftables established connections are configured (Manual)"
systemctl is-enabled nftables.service | grep -q 'enabled' && nft list ruleset | awk '/hook input/,/}/' | grep 'ct state'

echo "Ensure nftables default deny firewall policy (Automated)"
systemctl --quiet is-enabled nftables.service && nft list ruleset | grep 'hook input' | grep -v 'policy drop'
systemctl --quiet is-enabled nftables.service && nft list ruleset | grep 'hook forward' | grep -v 'policy drop'

echo "Ensure cron daemon is enabled and active (Automated)"
systemctl is-enabled crond
systemctl is-active crond
 
echo "Ensure permissions on /etc/crontab are configured (Automated)"
stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/crontab

echo "Ensure permissions on /etc/cron.hourly are configured (Automated)"
stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/cron.hourly/
 
echo "Ensure permissions on /etc/cron.daily are configured (Automated)"
echo stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/cron.daily/

echo "Ensure permissions on /etc/cron.weekly are configured (Automated)"
stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/cron.weekly/

echo "Ensure permissions on /etc/cron.monthly are configured (Automated)"
stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/cron.monthly/
 
echo "Ensure permissions on /etc/cron.d are configured (Automated)"
stat -Lc 'Access: (%a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/cron.d/

echo "Ensure crontab is restricted to authorized users (Automated)"
stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.allow
[ -e "/etc/cron.deny" ] && stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/cron.deny 
 
echo "Ensure at is restricted to authorized users (Automated)"
stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.allow
[ -e "/etc/at.deny" ] && stat -Lc 'Access: (%a/%A) Owner: (%U) Group: (%G)' /etc/at.deny

echo "Ensure permissions on /etc/ssh/sshd_config are configured (Automated)"
{
 l_output="" l_output2=""
 unset a_sshdfiles && a_sshdfiles=()
 [ -e "/etc/ssh/sshd_config" ] && a_sshdfiles+=("$(stat -Lc '%n^%#a^%U^%G' 
"/etc/ssh/sshd_config")")
 while IFS= read -r -d $'\0' l_file; do
 [ -e "$l_file" ] && a_sshdfiles+=("$(stat -Lc '%n^%#a^%U^%G' 
"$l_file")")
 done < <(find /etc/ssh/sshd_config.d -type f \( -perm /077 -o ! -user 
root -o ! -group root \) -print0)
 if (( ${#a_sshdfiles[@]} != 0 )); then
 perm_mask='0177'
 maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
 while IFS="^" read -r l_file l_mode l_user l_group; do
 l_out2=""
 [ $(( $l_mode & $perm_mask )) -gt 0 ] && l_out2="$l_out2\n - Is 
mode: \"$l_mode\" should be: \"$maxperm\" or more restrictive"
 [ "$l_user" != "root" ] && l_out2="$l_out2\n - Is owned by 
\"$l_user\" should be owned by \"root\""
 [ "$l_group" != "root" ] && l_out2="$l_out2\n - Is group owned by 
\"$l_user\" should be group owned by \"root\""
 if [ -n "$l_out2" ]; then
 l_output2="$l_output2\n - File: \"$l_file\":$l_out2"
 else
 l_output="$l_output\n - File: \"$l_file\":\n - Correct: mode 
($l_mode), owner ($l_user), and group owner ($l_group) configured"
 fi
 done <<< "$(printf '%s\n' "${a_sshdfiles[@]}")"
 fi
 unset a_sshdfiles
 # If l_output2 is empty, we pass
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * 
:\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit 
failure * :\n$l_output2\n"
 [ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n"
 fi
}

echo "Ensure permissions on SSH private host key files are configured (Automated)"
{
 l_output="" l_output2=""
 l_skgn="$(grep -Po -- '^(ssh_keys|_?ssh)\b' /etc/group)" # Group 
designated to own openSSH keys
 l_skgid="$(awk -F: '($1 == "'"$l_skgn"'"){print $3}' /etc/group)" # Get 
gid of group
 [ -n "$l_skgid" ] && l_agroup="(root|$l_skgn)" || l_agroup="root"
 unset a_skarr && a_skarr=() # Clear and initialize array
 if [ -d /etc/ssh ]; then
 while IFS= read -r -d $'\0' l_file; do # Loop to populate array
 if grep -Pq ':\h+OpenSSH\h+private\h+key\b' <<< "$(file "$l_file")"; 
then
 a_skarr+=("$(stat -Lc '%n^%#a^%U^%G^%g' "$l_file")")
 fi
 done < <(find -L /etc/ssh -xdev -type f -print0)
 while IFS="^" read -r l_file l_mode l_owner l_group l_gid; do
 l_out2=""
 [ "$l_gid" = "$l_skgid" ] && l_pmask="0137" || l_pmask="0177"
 l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"
 if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
 l_out2="$l_out2\n - Mode: \"$l_mode\" should be mode: 
\"$l_maxperm\" or more restrictive"
 fi
 if [ "$l_owner" != "root" ]; then
 l_out2="$l_out2\n - Owned by: \"$l_owner\" should be owned by 
\"root\""
 fi
 if [[ ! "$l_group" =~ $l_agroup ]]; then
 l_out2="$l_out2\n - Owned by group \"$l_group\" should be group 
owned by: \"${l_agroup//|/ or }\""
 fi
 if [ -n "$l_out2" ]; then
 l_output2="$l_output2\n - File: \"$l_file\"$l_out2"
 else
 l_output="$l_output\n - File: \"$l_file\"\n - Correct: mode 
($l_mode), owner ($l_owner), and group owner ($l_group) configured"
 fi
 done <<< "$(printf '%s\n' "${a_skarr[@]}")"
 else
 l_output=" - openSSH keys not found on the system"
 fi
 unset a_skarr
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * 
:\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit 
failure * :\n$l_output2\n"
 [ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n"
 fi
}

echo "Ensure permissions on SSH public host key files are configured (Automated)"
{
 l_output="" l_output2=""
 l_skgn="$(grep -Po -- '^(ssh_keys|_?ssh)\b' /etc/group)" # Group designated to own openSSH 
public keys
 l_skgid="$(awk -F: '($1 == "'"$l_skgn"'"){print $3}' /etc/group)" # Get gid of group
 [ -n "$l_skgid" ] && l_agroup="(root|$l_skgn)" || l_agroup="root"
 unset a_skarr && a_skarr=() # Clear and initialize array
 if [ -d /etc/ssh ]; then
 while IFS= read -r -d $'\0' l_file; do # Loop to populate array
 if grep -Pq ':\h+OpenSSH\h+(\H+\h+)public\h+key\b' <<< "$(file "$l_file")"; then
 a_skarr+=("$(stat -Lc '%n^%#a^%U^%G^%g' "$l_file")")
 fi
 done < <(find -L /etc/ssh -xdev -type f -print0)
 while IFS="^" read -r l_file l_mode l_owner l_group l_gid; do
 echo "File: \"$l_file\" Mode: \"$l_mode\" Owner: \"$l_owner\" Group: \"$l_group\" GID: 
\"$l_gid\""
 l_out2=""
 l_pmask="0133"
 l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"
 if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
 l_out2="$l_out2\n - Mode: \"$l_mode\" should be mode: \"$l_maxperm\" or more 
restrictive"
 fi
 if [ "$l_owner" != "root" ]; then
 l_out2="$l_out2\n - Owned by: \"$l_owner\" should be owned by \"root\""
 fi
 if [[ ! "$l_group" =~ $l_agroup ]]; then
 l_out2="$l_out2\n - Owned by group \"$l_group\" should be group owned by: 
\"${l_agroup//|/ or }\""
 fi
 if [ -n "$l_out2" ]; then
 l_output2="$l_output2\n - File: \"$l_file\"$l_out2"
 else
 l_output="$l_output\n - File: \"$l_file\"\n - Correct: mode ($l_mode), owner 
($l_owner), and group owner ($l_group) configured"
 fi
 done <<< "$(printf '%s\n' "${a_skarr[@]}")"
 else
 l_output=" - openSSH keys not found on the system"
 fi
 unset a_skarr
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n *** PASS ***\n- * Correctly set * :\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2\n"
 [ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n"
 fi
}

echo "Ensure sshd access is configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -Pi '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$'
grep -Pis '^\h*(allow|deny)(users|groups)\h+\H+(\h+.*)?$' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd Banner is configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep banner

echo "Ensure sshd Ciphers are configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep ciphers

echo "Ensure sshd ClientAliveInterval and ClientAliveCountMax are configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep clientaliveinterval
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep clientalivecountmax
grep -Pis '^\h*ClientAliveCountMax\h+"?0\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd DisableForwarding is enabled (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i disableforwarding
grep -Pis '^\h*DisableForwarding\h+\"?no\"?\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd HostbasedAuthentication is disabled (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep hostbasedauthentication
grep -Pis '^\h*HostbasedAuthentication\h+"?yes"?\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd IgnoreRhosts is enabled (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep ignorerhosts
grep -Pis '^\h*ignorerhosts\h+"?no"?\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd KexAlgorithms is configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep kexalgorithms

echo "Ensure sshd LoginGraceTime is configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep logingracetime
grep -Pis '^\h*LoginGraceTime\h+"?(0|6[1-9]|[7-9][0-9]|[1-9][0-9][0-9]+|[^1]m)\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd LogLevel is configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep loglevel
grep -Pis '^\h*loglevel\h+' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf | grep -Pvi '(VERBOSE|INFO)'

echo "Ensure sshd MACs are configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i "MACs"

echo "Ensure sshd MaxAuthTries is configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep maxauthtries
grep -Pis '^\h*maxauthtries\h+"?([5-9]|[1-9][0-9]+)\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd MaxSessions is configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxsessions
grep -Pis '^\h*MaxSessions\h+"?(1[1-9]|[2-9][0-9]|[1-9][0-9][0-9]+)\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd MaxStartups is configured (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxstartups
grep -Pis '^\h*maxstartups\h+"?(((1[1-9]|[1-9][0-9][0-9]+):([0-9]+):([0-9]+))|(([0-9]+):(3[1-9]|[4-9][0-9]|[1-9][0-9][0-9]+):([0-9]+))|(([0-9]+):([0-9]+):(6[1-9]|[7-9][0-9]|[1-9][0-9][0-9]+)))\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd PermitEmptyPasswords is disabled (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitemptypasswords
grep -Pis '^\h*PermitEmptyPasswords\h+"?yes\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd PermitRootLogin is disabled (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitrootlogin
grep -Pis '^\h*PermitRootLogin\h+"?(yes|prohibit-password|forced-commands-only)"?\b' /etc/ssh/sshd_config /etc/ssh/ssh_config.d/*.conf

echo "Ensure sshd PermitUserEnvironment is disabled (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permituserenvironment
grep -Pis '^\h*PermitUserEnvironment\h+"?yes"?\b' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf

echo "Ensure sshd UsePAM is enabled (Automated)"
sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i usepam
grep -Pis '^\h*UsePAM\h+"?no"?\b' /etc/ssh/sshd_config /etc/ssh/ssh_config.d/*.conf

echo "Ensure sshd crypto_policy is not set (Automated)"
grep -Pi '^\h*CRYPTO_POLICY\h*=' /etc/sysconfig/sshd

echo "Ensure sudo is installed (Automated)"
dnf list sudo

echo "Ensure sudo commands use pty (Automated)"
grep -rPi '^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$' /etc/sudoers*

echo "Ensure sudo log file exists (Automated)"
grep -rPsi "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers*

echo "Ensure users must provide password for escalation (Automated)"
grep -r "^[^#].*NOPASSWD" /etc/sudoers*
 
echo "Ensure re-authentication for privilege escalation is not disabled globally (Automated)"
grep -r "^[^#].*\!authenticate" /etc/sudoers*

echo "Ensure sudo authentication timeout is configured correctly (Automated)"
grep -roP "timestamp_timeout=\K[0-9]*" /etc/sudoers*
sudo -V | grep "Authentication timestamp timeout:"

echo "Ensure access to the su command is restricted (Automated)"
grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su

echo "Ensure latest version of pam is installed (Automated)"
rpm -q pam

echo "Ensure latest version of authselect is installed (Automated)"
rpm -q authselect

echo "Ensure active authselect profile includes pam modules (Automated)"
grep -P -- '\b(pam_pwquality\.so|pam_pwhistory\.so|pam_faillock\.so|pam_unix\.so)\b' /etc/authselect/"$(head -1 /etc/authselect/authselect.conf)"/{system,password}-auth

echo "Ensure pam_faillock module is enabled (Automated)"
grep -P -- '\bpam_faillock.so\b' /etc/pam.d/{password,system}-auth

echo "Ensure pam_pwquality module is enabled (Automated)"
grep -P -- '\bpam_pwquality\.so\b' /etc/pam.d/{password,system}-auth

echo "Ensure pam_pwhistory module is enabled (Automated)"
grep -P -- '\bpam_pwhistory\.so\b' /etc/pam.d/{password,system}-auth

echo "Ensure pam_unix module is enabled (Automated)"
grep -P -- '\bpam_unix\.so\b' /etc/pam.d/{password,system}-auth
 
echo  "Ensure password failed attempts lockout is configured (Automated)"
grep -Pi -- '^\h*deny\h*=\h*[1-5]\b' /etc/security/faillock.conf
grep -Pi -- '^\h*auth\h+(requisite|required|sufficient)\h+pam_faillock\.so\h+([^#\n\r]+\h+)?deny\h*=\h*(0|[6-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth

echo "Ensure password unlock time is configured (Automated)"
grep -Pi -- '^\h*unlock_time\h*=\h*(0|9[0-9][0-9]|[1-9][0-9]{3,})\b' /etc/security/faillock.conf

echo "Ensure password failed attempts lockout includes root account (Automated)"
grep -Pi -- '^\h*(even_deny_root|root_unlock_time\h*=\h*\d+)\b' /etc/security/faillock.conf
grep -Pi -- '^\h*root_unlock_time\h*=\h*([1-9]|[1-5][0-9])\b' /etc/security/faillock.conf
grep -Pi -- '^\h*auth\h+([^#\n\r]+\h+)pam_faillock\.so\h+([^#\n\r]+\h+)?root_unlock_time\h*=\h*([1-9]|[1-5][0-9])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth

echo "Ensure password number of changed characters is configured (Automated)"
grep -Psi -- '^\h*difok\h*=\h*([2-9]|[1-9][0-9]+)\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf
grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?difok\h*=\h*([0-1])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth

echo "Ensure password length is configured (Automated)"
grep -Psi -- '^\h*minlen\h*=\h*(1[4-9]|[2-9][0-9]|[1-9][0-9]{2,})\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf
grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?minlen\h*=\h*([0-9]|1[0-3])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth

echo "Ensure password complexity is configured (Manual)"
grep -Psi -- '^\h*(minclass|[dulo]credit)\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf
grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?(minclass=[0-3]|[dulo]credit=[^-]\d*)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth

echo "Ensure password same consecutive characters is configured (Automated)"
grep -Psi -- '^\h*maxrepeat\h*=\h*[1-3]\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf
grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?maxrepeat\h*=\h*(0|[4-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth

echo "Ensure password maximum sequential characters is configured (Automated)"
grep -Psi -- '^\h*maxsequence\h*=\h*[1-3]\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf
grep -Psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?maxsequence\h*=\h*(0|[4-9]|[1-9][0-9]+)\b' /etc/pam.d/system-auth /etc/pam.d/password-auth

echo "Ensure password dictionary check is enabled (Automated)"
grep -Psi -- '^\h*dictcheck\h*=\h*0\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf
grep -psi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwquality\.so\h+([^#\n\r]+\h+)?dictcheck\h*=\h*0\b' /etc/pam.d/system-auth /etc/pam.d/password-auth

echo "Ensure password quality is enforced for the root user (Automated)"
grep -Psi -- '^\h*enforce_for_root\b' /etc/security/pwquality.conf /etc/security/pwquality.conf.d/*.conf

echo "Ensure password history remember is configured (Automated)"
grep -Pi -- '^\h*remember\h*=\h*(2[4-9]|[3-9][0-9]|[1-9][0-9]{2,})\b' /etc/security/pwhistory.conf
grep -Pi -- '^\h*password\h+(requisite|required|sufficient)\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?remember=(2[0-3]|1[0-9]|[0-9])\b' /etc/pam.d/system-auth /etc/pam.d/password-auth

echo "Ensure password history is enforced for the root user (Automated)"
grep -Pi -- '^\h*enforce_for_root\b' /etc/security/pwhistory.conf

echo "Ensure pam_pwhistory includes use_authtok (Automated)"
grep -P -- '^\h*password\h+([^#\n\r]+)\h+pam_pwhistory\.so\h+([^#\n\r]+\h+)?use_authtok\b' /etc/pam.d/{password,system}-auth

echo "Ensure pam_unix does not include nullok (Automated)"
grep -P -- '^\h*(auth|account|password|session)\h+(requisite|required|sufficient)\h+pam_unix\.so\b' /etc/pam.d/{password,system}-auth | grep -Pv -- '\bnullok\b'

echo "Ensure pam_unix does not include remember (Automated)"
grep -Pi '^\h*password\h+([^#\n\r]+\h+)?pam_unix\.so\b' /etc/pam.d/{password,system}-auth | grep -Pv '\bremember=\d\b'

echo "Ensure pam_unix includes a strong password hashing algorithm (Automated)"
grep -P -- '^\h*password\h+([^#\n\r]+)\h+pam_unix\.so\h+([^#\n\r]+\h+)?(sha512|yescrypt)\b' /etc/pam.d/{password,system}-auth

echo "Ensure pam_unix includes use_authtok (Automated)"
grep -P -- '^\h*password\h+([^#\n\r]+)\h+pam_unix\.so\h+([^#\n\r]+\h+)?use_authtok\b' /etc/pam.d/{password,system}-auth

echo "Ensure strong password hashing algorithm is configured (Automated)"
grep -Pi -- '^\h*crypt_style\h*=\h*(sha512|yescrypt)\b' /etc/libuser.conf
grep -Pi -- '^\h*ENCRYPT_METHOD\h+(SHA512|yescrypt)\b' /etc/login.defs

echo "Ensure password expiration is 365 days or less (Automated)"
grep PASS_MAX_DAYS /etc/login.defs
grep -E '^[^:]+:[^!*]' /etc/shadow | cut -d: -f1,5
 
echo "Ensure password expiration warning days is 7 or more (Automated)"
grep PASS_WARN_AGE /etc/login.defs

echo "Ensure inactive password lock is 30 days or less (Automated)"
useradd -D | grep INACTIVE
awk -F: '/^[^#:]+:[^!\*:]*:[^:]*:[^:]*:[^:]*:[^:]*:(\s*|-1|3[1-9]|[4-9][0-9]|[1-9][0-9][0-9]+):[^:]*:[^:]*\s*$/ {print $1":"$7}' /etc/shadow

echo "Ensure all users last password change date is in the past (Automated)"
{
 while IFS= read -r l_user; do
 l_change=$(date -d "$(chage --list $l_user | grep '^Last password 
change' | cut -d: -f2 | grep -v 'never$')" +%s)
 if [[ "$l_change" -gt "$(date +%s)" ]]; then
 echo "User: \"$l_user\" last password change was \"$(chage --list 
$l_user | grep '^Last password change' | cut -d: -f2)\""
 fi
 done < <(awk -F: '/^[^:\n\r]+:[^!*xX\n\r]/{print $1}' /etc/shadow)
}

echo "Ensure default group for the root account is GID 0 (Automated)"
awk -F: '$1=="root"{print $1":"$4}' /etc/passwd

echo "Ensure root user umask is configured (Automated)"
grep -Psi -- '^\h*umask\h+(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[wrx]{1,3},)?o=[wrx]{1,3}\b)))' /root/.bash_profile /root/.bashrc

echo "Ensure system accounts are secured (Automated)"
awk -F: '($1!~/^(root|halt|sync|shutdown|nfsnobody)$/ && ($3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' || $3 == 65534) && $7!~/^(\/usr)?\/sbin\/nologin$/) { print $1 }' /etc/passwd
awk -F: '/nologin/ {print $1}' /etc/passwd | xargs -I '{}' passwd -S '{}' | awk '($2!="L" && $2!="LK") {print $1}'

echo "Ensure root password is set (Automated)"
passwd -S root
 
echo "Ensure nologin is not listed in /etc/shells (Automated)"
grep '/nologin\b' /etc/shells
 
echo "Ensure default user shell timeout is configured (Automated)"
{
 output1="" output2=""
 [ -f /etc/bashrc ] && BRC="/etc/bashrc"
 for f in "$BRC" /etc/profile /etc/profile.d/*.sh ; do
 grep -Pq '^\s*([^#]+\s+)?TMOUT=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9])\b' "$f" && grep -Pq '^\s*([^#]+;\s*)?readonly\s+TMOUT(\s+|\s*;|\s*$|=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9]))\b' "$f" && grep -Pq '^\s*([^#]+;\s*)?export\s+TMOUT(\s+|\s*;|\s*$|=(900|[1-8][0-9][0-9]|[1-9][0-9]|[1-9]))\b' "$f" &&  output1="$f"
 done
 grep -Pq '^\s*([^#]+\s+)?TMOUT=(9[0-9][1-9]|9[1-9][0-9]|0+|[1-9]\d{3,})\b' /etc/profile 
/etc/profile.d/*.sh "$BRC" && output2=$(grep -Ps '^\s*([^#]+\s+)?TMOUT=(9[0-9][1-9]|9[1-9][0-
9]|0+|[1-9]\d{3,})\b' /etc/profile /etc/profile.d/*.sh $BRC)
 if [ -n "$output1" ] && [ -z "$output2" ]; then
 echo -e "\nPASSED\n\nTMOUT is configured in: \"$output1\"\n"
 else
 [ -z "$output1" ] && echo -e "\nFAILED\n\nTMOUT is not configured\n"
 [ -n "$output2" ] && echo -e "\nFAILED\n\nTMOUT is incorrectly configured in: 
\"$output2\"\n"
 fi
}

echo "Ensure default user umask is configured (Automated)"
{
 l_output="" l_output2=""
 file_umask_chk()
 {
 if grep -Psiq -- '^\h*umask\h+(0?[0-7][2-7]7|u(=[rwx]{0,3}),g=([rx]{0,2}),o=)(\h*#.*)?$' "$l_file"; then
 l_output="$l_output\n - umask is set correctly in \"$l_file\""
 elif grep -Psiq -- '^\h*umask\h+(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b|[0-7][0-7][0-6]\b)|(u=[rwx]{1,3},)?(((g=[rx]?[rx]?w[rx]?[rx]?\b)(,o=[rwx]{1,3})?)|((g=[wrx]{1,3},)?o=[wrx]{1,3}\b)))' "$l_file"; then
 l_output2="$l_output2\n - umask is incorrectly set in \"$l_file\""
 fi
 }
 while IFS= read -r -d $'\0' l_file; do
 file_umask_chk
 done < <(find /etc/profile.d/ -type f -name '*.sh' -print0)
 l_file="/etc/profile" && file_umask_chk
 l_file="/etc/bashrc" && file_umask_chk
 l_file="/etc/bash.bashrc" && file_umask_chk
 l_file="/etc/pam.d/postlogin"
 if grep -Psiq -- '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(0?[0-7][2-7]7)\b' "$l_file"; then
 l_output1="$l_output1\n - umask is set correctly in \"$l_file\""
 elif grep -Psiq '^\h*session\h+[^#\n\r]+\h+pam_umask\.so\h+([^#\n\r]+\h+)?umask=(([0-7][0-7][01][0-7]\b|[0-7][0-7][0-7][0-6]\b)|([0-7][01][0-7]\b))' "$l_file"; then
 l_output2="$l_output2\n - umask is incorrectly set in \"$l_file\""
 fi
 l_file="/etc/login.defs" && file_umask_chk
 l_file="/etc/default/login" && file_umask_chk
 [[ -z "$l_output" && -z "$l_output2" ]] && l_output2="$l_output2\n - umask is not set"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2"
 [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n"
 fi
}

echo "Ensure rsyslog is installed (Automated)"
rpm -q rsyslog

echo "Ensure rsyslog service is enabled (Manual)"
systemctl is-enabled rsyslog
 
echo "Ensure journald is configured to send logs to rsyslog (Manual)"
{
 l_output="" l_output2=""
 a_parlist=("ForwardToSyslog=yes")
 l_systemd_config_file="/etc/systemd/journald.conf" # Main systemd configuration file
 config_file_parameter_chk()
 {
 unset A_out; declare -A A_out # Check config file(s) setting
 while read -r l_out; do
 if [ -n "$l_out" ]; then
 if [[ $l_out =~ ^\s*# ]]; then
 l_file="${l_out//# /}"
 else
 l_systemd_parameter="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
 [ "${l_systemd_parameter^^}" = "${l_systemd_parameter_name^^}" ] && 
A_out+=(["$l_systemd_parameter"]="$l_file")
 fi
 fi
 done < <(/usr/bin/systemd-analyze cat-config "$l_systemd_config_file" | grep -Pio 
'^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
 if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
 while IFS="=" read -r l_systemd_file_parameter_name l_systemd_file_parameter_value; do
 l_systemd_file_parameter_name="${l_systemd_file_parameter_name// /}"
 l_systemd_file_parameter_value="${l_systemd_file_parameter_value// /}"
 if [ "${l_systemd_file_parameter_value^^}" = "${l_systemd_parameter_value^^}" ]; then
 l_output="$l_output\n - \"$l_systemd_parameter_name\" is correctly set to 
\"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\"\n"
 else
 l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is incorrectly set to 
\"$l_systemd_file_parameter_value\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value 
of: \"$l_systemd_parameter_value\"\n"
 fi
 done < <(grep -Pio -- "^\h*$l_systemd_parameter_name\h*=\h*\H+" "${A_out[@]}")
 else
 l_output2="$l_output2\n - \"$l_systemd_parameter_name\" is not set in an included file\n 
** Note: \"$l_systemd_parameter_name\" May be set in a file that's ignored by load procedure 
**\n"
 fi
 }
 while IFS="=" read -r l_systemd_parameter_name l_systemd_parameter_value; do # Assess and 
check parameters
 l_systemd_parameter_name="${l_systemd_parameter_name// /}"
 l_systemd_parameter_value="${l_systemd_parameter_value// /}"
 config_file_parameter_chk
 done < <(printf '%s\n' "${a_parlist[@]}")
 if [ -z "$l_output2" ]; then # Provide output from checks
 echo -e "\n- Audit Result:\n ** PASS **\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
 fi
}

systemctl list-units --type service | grep -P -- '(journald|rsyslog)'
 
echo "Ensure rsyslog default file permissions are configured (Automated)"
grep -Ps '^\h*\$FileCreateMode\h+0[0,2,4,6][0,2,4]0\b' /etc/rsyslog.conf /etc/rsyslog.d/*.conf

echo "Ensure logging is configured (Manual)"
ls -l /var/log/
 
echo "Ensure rsyslog is configured to send logs to a remote log host (Manual)"
grep "^*.*[^I][^I]*@" /etc/rsyslog.conf /etc/rsyslog.d/*.conf

echo "Ensure rsyslog is not configured to receive logs from a remote client (Automated)"
grep -Ps -- '^\h*module\(load="imtcp"\)' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
grep -Ps -- '^\h*input\(type="imtcp" port="514"\)' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
grep -s '$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
grep -s '$InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
 
echo "Ensure systemd-journal-remote is installed (Manual)"
rpm -q systemd-journal-remote

echo "Ensure systemd-journal-remote is configured (Manual)"
grep -P "^ *URL=|^ *ServerKeyFile=|^ *ServerCertificateFile=|^ *TrustedCertificateFile=" /etc/systemd/journal-upload.conf

echo "Ensure systemd-journal-remote is enabled (Manual)"
systemctl is-enabled systemd-journal-upload.service

echo "Ensure journald is not configured to receive logs from a remote client (Automated)"
systemctl is-enabled systemd-journal-remote.socket

echo "Ensure journald service is enabled (Automated)"
systemctl is-enabled systemd-journald.service

echo "Ensure journald is configured to compress large log files (Automated)"
grep ^\s*Compress /etc/systemd/journald.conf
 
echo "Ensure journald is configured to write logfiles to persistent disk (Automated)"
grep ^\s*Storage /etc/systemd/journald.conf
 
echo "Ensure journald is not configured to send logs to rsyslog (Manual)"
grep ^\s*ForwardToSyslog /etc/systemd/journald.conf

echo "Ensure journald log rotation is configured per site policy (Manual)"
grep -E 'SystemMaxUse=|SystemKeepFree=|RuntimeMaxUse=|RuntimeKeepFree=|MaxFileSec=' /etc/systemd/journald.conf 

echo "Ensure logrotate is configured (Manual)"
cat /etc/logrotate.conf

echo "Ensure all logfiles have appropriate access configured (Automated)"
{
 l_op2="" l_output2=""
 l_uidmin="$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"
 file_test_chk()
 {
 l_op2=""
 if [ $(( $l_mode & $perm_mask )) -gt 0 ]; then
 l_op2="$l_op2\n - Mode: \"$l_mode\" should be \"$maxperm\" or more restrictive"
 fi
 if [[ ! "$l_user" =~ $l_auser ]]; then
 l_op2="$l_op2\n - Owned by: \"$l_user\" and should be owned by \"${l_auser//|/ or }\""
 fi
 if [[ ! "$l_group" =~ $l_agroup ]]; then
 l_op2="$l_op2\n - Group owned by: \"$l_group\" and should be group owned by 
\"${l_agroup//|/ or }\""
 fi
 [ -n "$l_op2" ] && l_output2="$l_output2\n - File: \"$l_fname\" is:$l_op2\n"
 }
 unset a_file && a_file=() # clear and initialize array
 # Loop to create array with stat of files that could possibly fail one of the audits
 while IFS= read -r -d $'\0' l_file; do
 [ -e "$l_file" ] && a_file+=("$(stat -Lc '%n^%#a^%U^%u^%G^%g' "$l_file")")
 done < <(find -L /var/log -type f \( -perm /0137 -o ! -user root -o ! -group root \) -print0)
 while IFS="^" read -r l_fname l_mode l_user l_uid l_group l_gid; do
 l_bname="$(basename "$l_fname")"
 case "$l_bname" in
 lastlog | lastlog.* | wtmp | wtmp.* | wtmp-* | btmp | btmp.* | btmp-* | README)
 perm_mask='0113'
 maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
 l_auser="root"
 l_agroup="(root|utmp)"
 file_test_chk
 ;;
 secure | auth.log | syslog | messages)
 perm_mask='0137'
 maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
 l_auser="(root|syslog)"
 l_agroup="(root|adm)"
 file_test_chk
 ;;
 SSSD | sssd)
 perm_mask='0117'
 maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
 l_auser="(root|SSSD)"
 l_agroup="(root|SSSD)"
 file_test_chk 
 ;;
 gdm | gdm3)
 perm_mask='0117'
 maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
 l_auser="root"
 l_agroup="(root|gdm|gdm3)"
 file_test_chk 
 ;;
 *.journal | *.journal~)
 perm_mask='0137'
 maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
 l_auser="root"
 l_agroup="(root|systemd-journal)"
 file_test_chk
 ;;
 *)
 perm_mask='0137'
 maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
 l_auser="(root|syslog)"
 l_agroup="(root|adm)"
 if [ "$l_uid" -lt "$l_uidmin" ] && [ -z "$(awk -v grp="$l_group" -F: '$1==grp {print 
$4}' /etc/group)" ]; then
 if [[ ! "$l_user" =~ $l_auser ]]; then
 l_auser="(root|syslog|$l_user)"
 fi
 if [[ ! "$l_group" =~ $l_agroup ]]; then
 l_tst=""
while l_out3="" read -r l_duid; do
 [ "$l_duid" -ge "$l_uidmin" ] && l_tst=failed
 done <<< "$(awk -F: '$4=='"$l_gid"' {print $3}' /etc/passwd)"
[ "$l_tst" != "failed" ] && l_agroup="(root|adm|$l_group)"
 fi
 fi
 file_test_chk
 ;;
 esac
 done <<< "$(printf '%s\n' "${a_file[@]}")"
 unset a_file # Clear array
 # If all files passed, then we pass
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Results:\n ** Pass **\n- All files in \"/var/log/\" have appropriate 
permissions and ownership\n"
 else
 # print the reason why we are failing
 echo -e "\n- Audit Results:\n ** Fail **\n$l_output2"
 fi
}

echo "Ensure audit is installed (Automated)"
rpm -q audit

echo "Ensure auditing for processes that start prior to auditd is enabled (Automated)"
grubby --info=ALL | grep -Po '\baudit=1\b'
 
 
echo "Ensure audit_backlog_limit is sufficient (Automated)"
grubby --info=ALL | grep -Po "\baudit_backlog_limit=\d+\b"
  
echo "Ensure auditd service is enabled (Automated)"
systemctl is-enabled auditd
  
echo "Ensure audit log storage size is configured (Automated)"
grep -w "^\s*max_log_file\s*=" /etc/audit/auditd.conf

echo "Ensure audit logs are not automatically deleted (Automated)"
grep max_log_file_action /etc/audit/auditd.conf

echo "Ensure system is disabled when audit logs are full (Automated)"
grep -P -- '^\h*disk_full_action\h*=\h*(halt|single)\b' /etc/audit/auditd.conf
grep -P -- '^\h*disk_error_action\h*=\h*(syslog|single|halt)\b' /etc/audit/auditd.conf

echo "Ensure system warns when audit logs are low on space (Automated)"
grep -P -- '^\h*space_left_action\h*=\h*(email|exec|single|halt)\b' /etc/audit/auditd.conf
grep -P -- '^\h*admin_space_left_action\h*=\h*(single|halt)\b' /etc/audit/auditd.conf

echo "Ensure changes to system administration scope (sudoers) is collected (Automated)"
awk '/^ *-w/ \
&&/\/etc\/sudoers/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules

echo "Ensure actions as another user are always logged (Automated)"
awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&(/ -C *euid!=uid/||/ -C *uid!=euid/) \
&&/ -S *execve/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules

auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&(/ -C *euid!=uid/||/ -C *uid!=euid/) \
&&/ -S *execve/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'

echo "Ensure events that modify the sudo log file are collected (Automated)"
{
SUDO_LOG_FILE_ESCAPED=$(grep -r logfile /etc/sudoers* | sed -e 
's/.*logfile=//;s/,? .*//' -e 's/"//g' -e 's|/|\\/|g')
[ -n "${SUDO_LOG_FILE_ESCAPED}" ] && awk "/^ *-w/ \
&&/"${SUDO_LOG_FILE_ESCAPED}"/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'SUDO_LOG_FILE_ESCAPED' is unset.\n"
}

echo "Ensure events that modify date and time information are collected (Automated)"
{
awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/adjtimex/ \
 ||/settimeofday/ \
 ||/clock_settime/ ) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
awk '/^ *-w/ \
&&/\/etc\/localtime/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
}

echo  "Ensure events that modify the system's network environment are collected (Automated)"
{
awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
 ||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
awk '/^ *-w/ \
&&(/\/etc\/issue/ \
 ||/\/etc\/issue.net/ \
 ||/\/etc\/hosts/ \
 ||/\/etc\/sysconfig\/network/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
}

{
auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
 ||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/issue/ \
 ||/\/etc\/issue.net/ \
 ||/\/etc\/hosts/ \
 ||/\/etc\/sysconfig\/network/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
}

echo "Ensure use of privileged commands are collected (Automated)"
for PARTITION in $(findmnt -n -l -k -it $(awk '/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv "noexec|nosuid" | awk '{print $1}'); do
 for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f); do
 grep -qr "${PRIVILEGED}" /etc/audit/rules.d && printf "OK: 
'${PRIVILEGED}' found in auditing rules.\n" || printf "Warning: 
'${PRIVILEGED}' not found in on disk configuration.\n"
 done
done

{
 RUNNING=$(auditctl -l)
 [ -n "${RUNNING}" ] && for PARTITION in $(findmnt -n -l -k -it $(awk 
'/nodev/ { print $2 }' /proc/filesystems | paste -sd,) | grep -Pv 
"noexec|nosuid" | awk '{print $1}'); do
 for PRIVILEGED in $(find "${PARTITION}" -xdev -perm /6000 -type f); do
 printf -- "${RUNNING}" | grep -q "${PRIVILEGED}" && printf "OK: 
'${PRIVILEGED}' found in auditing rules.\n" || printf "Warning: 
'${PRIVILEGED}' not found in running configuration.\n"
 done
 done \
 || printf "ERROR: Variable 'RUNNING' is unset.\n"
}

echo "Ensure unsuccessful file access attempts are collected (Automated)"
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) \
&&/ -S/ \
&&/creat/ \
&&/open/ \
&&/truncate/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) \
&&/ -S/ \
&&/creat/ \
&&/open/ \
&&/truncate/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo "Ensure events that modify user/group information are collected (Automated)"
awk '/^ *-w/ \
&&(/\/etc\/group/ \
 ||/\/etc\/passwd/ \
 ||/\/etc\/gshadow/ \
 ||/\/etc\/shadow/ \
 ||/\/etc\/security\/opasswd/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules

auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/group/ \
 ||/\/etc\/passwd/ \
 ||/\/etc\/gshadow/ \
 ||/\/etc\/shadow/ \
 ||/\/etc\/security\/opasswd/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'

echo "Ensure discretionary access control permission modification events are collected (Automated)"
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -S/ \
&&/ -F *auid>=${UID_MIN}/ \
&&(/chmod/||/fchmod/||/fchmodat/ \
 ||/chown/||/fchown/||/fchownat/||/lchown/ \
 ||/setxattr/||/lsetxattr/||/fsetxattr/ \
 ||/removexattr/||/lremovexattr/||/fremovexattr/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -S/ \
&&/ -F *auid>=${UID_MIN}/ \
&&(/chmod/||/fchmod/||/fchmodat/ \
 ||/chown/||/fchown/||/fchownat/||/lchown/ \
 ||/setxattr/||/lsetxattr/||/fsetxattr/ \
 ||/removexattr/||/lremovexattr/||/fremovexattr/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo "Ensure successful file system mounts are collected (Automated)"
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -S/ \
&&/mount/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo "Ensure session initiation information is collected (Automated)"
awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
 ||/\/var\/log\/wtmp/ \
 ||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules

auditctl -l | awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
 ||/\/var\/log\/wtmp/ \
 ||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'

echo "Ensure login and logout events are collected (Automated)"
awk '/^ *-w/ \
&&(/\/var\/log\/lastlog/ \
 ||/\/var\/run\/faillock/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules

auditctl -l | awk '/^ *-w/ \
&&(/\/var\/log\/lastlog/ \
 ||/\/var\/run\/faillock/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'

echo "Ensure file deletion events by users are collected (Automated)"
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -S/ \
&&(/unlink/||/rename/||/unlinkat/||/renameat/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -S/ \
&&(/unlink/||/rename/||/unlinkat/||/renameat/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo "Ensure events that modify the system's Mandatory Access Controls are collected (Automated)"
awk '/^ *-w/ \
&&(/\/etc\/selinux/ \
 ||/\/usr\/share\/selinux/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules

 auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/selinux/ \
 ||/\/usr\/share\/selinux/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'

echo "Ensure successful and unsuccessful attempts to use the chcon command are recorded (Automated)"
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/chcon/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/chcon/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo "Ensure successful and unsuccessful attempts to use the setfacl command are recorded (Automated)"
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/setfacl/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/setfacl/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo "Ensure successful and unsuccessful attempts to use the chacl command are recorded (Automated)"
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/chacl/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/chacl/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo "Ensure successful and unsuccessful attempts to use the usermod command are recorded (Automated)"
{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/sbin\/usermod/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

{
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/sbin\/usermod/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo "Ensure kernel module loading unloading and modification is collected (Automated)"
{
awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) \
&&/ -S/ \
&&(/init_module/ \
 ||/finit_module/ \
 ||/delete_module/ \
 ||/create_module/ \
 ||/query_module/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/kmod/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" /etc/audit/rules.d/*.rules \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

{
auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F auid!=unset/||/ -F auid!=-1/||/ -F auid!=4294967295/) \
&&/ -S/ \
&&(/init_module/ \
 ||/finit_module/ \
 ||/delete_module/ \
 ||/create_module/ \
 ||/query_module/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
UID_MIN=$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)
[ -n "${UID_MIN}" ] && auditctl -l | awk "/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/bin\/kmod/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)" \
|| printf "ERROR: Variable 'UID_MIN' is unset.\n"
}

echo "Ensure the audit configuration is immutable (Automated)"
grep -Ph -- '^\h*-e\h+2\b' /etc/audit/rules.d/*.rules | tail -1

echo "Ensure the running and on disk configuration is the same (Manual)"
augenrules --check
 
echo "Ensure the audit log directory is 0750 or more restrictive (Automated)"
stat -Lc "%n %a" "$(dirname $( awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf))" | grep -Pv -- '^\h*\H+\h+([0,5,7][0,5]0)'

echo "Ensure audit log files are mode 0640 or less permissive (Automated)"
[ -f /etc/audit/auditd.conf ] && find "$(dirname $(awk -F "=" '/^\s*log_file/ {print $2}' /etc/audit/auditd.conf | xargs))" -type f \( ! -perm 600 -a ! -perm 0400 -a ! -perm 0200 -a ! -perm 0000 -a ! -perm 0640 -a ! -perm 0440 -a ! -perm 0040 \) -exec stat -Lc "%n %#a" {} +

echo "Ensure only authorized users own audit log files (Automated)"
[ -f /etc/audit/auditd.conf ] && find "$(dirname $(awk -F "=" '/^\s*log_file/ {print $2}' /etc/audit/auditd.conf | xargs))" -type f ! -user root -exec stat -Lc "%n %U" {} +

echo "Ensure only authorized groups are assigned ownership of audit log files (Automated)"
grep -Piw -- '^\h*log_group\h*=\h*(adm|root)\b' /etc/audit/auditd.conf
stat -c "%n %G" "$(dirname $(awk -F"=" '/^\s*log_file\s*=\s*/ {print $2}' /etc/audit/auditd.conf | xargs))"/* | grep -Pv '^\h*\H+\h+(adm|root)\b'

echo "Ensure audit configuration files are 640 or more restrictive (Automated)"
find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) -exec stat -Lc "%n %a" {} + | grep -Pv -- '^\h*\H+\h*([0,2,4,6][0,4]0)\h*$'

echo "Ensure audit configuration files are owned by root (Automated)"
find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -user root

echo "Ensure audit configuration files belong to group root (Automated)"
find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group root

echo "Ensure audit tools are 755 or more restrictive (Automated)"
stat -c "%n %a" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+([0-7][0,1,4,5][0,1,4,5])\h*$'

echo "Ensure audit tools are owned by root (Automated)"
stat -c "%n %U" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+root\h*$'

echo "Ensure audit tools belong to group root (Automated)"
stat -c "%n %a %U %G" /sbin/auditctl /sbin/aureport /sbin/ausearch /sbin/autrace /sbin/auditd /sbin/augenrules | grep -Pv -- '^\h*\H+\h+([0-7][0,1,4,5][0,1,4,5])\h+root\h+root\h*$'

echo "Ensure AIDE is installed (Automated)"
rpm -q aide

echo "Ensure filesystem integrity is regularly checked (Automated)"
grep -Ers '^([^#]+\s+)?(\/usr\/s?bin\/|^\s*)aide(\.wrapper)?\s(--?\S+\s)*(--(check|update)|\$AIDEARGS)\b' /etc/cron.* /etc/crontab /var/spool/cron/
systemctl is-enabled aidecheck.services
systemctl is-enabled aidecheck.timer
systemctl status aidecheck.timer

echo "Ensure cryptographic mechanisms are used to protect the integrity of audit tools (Automated)"
grep -Ps -- '(\/sbin\/(audit|au)\H*\b)' /etc/aide.conf.d/*.conf /etc/aide.conf

echo "Ensure permissions on /etc/passwd are configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/passwd
 
echo "Ensure permissions on /etc/passwd- are configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: { %g/ %G)' /etc/passwd-
 
echo "Ensure permissions on /etc/opasswd are configured (Automated)"
[ -e "/etc/security/opasswd" ] && stat -Lc '%n Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/security/opasswd
[ -e "/etc/security/opasswd.old" ] && stat -Lc '%n Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/security/opasswd.old

echo "Ensure permissions on /etc/group are configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/group

echo "Ensure permissions on /etc/group- are configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/group-

echo "Ensure permissions on /etc/shadow are configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/shadow

echo "Ensure permissions on /etc/shadow- are configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/shadow-

echo "Ensure permissions on /etc/gshadow are configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/gshadow

echo "Ensure permissions on /etc/gshadow- are configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/gshadow-

echo "Ensure permissions on /etc/shells are configured (Automated)"
stat -Lc 'Access: (%#a/%A) Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/shells
 
echo "Ensure world writable files and directories are secured (Automated)"
{
 l_output="" l_output2=""
 l_smask='01000'
 a_path=(); a_arr=(); a_file=(); a_dir=() # Initialize arrays
 a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path 
"*/kubelet/pods/*" -a ! -path "/sys/kernel/security/apparmor/*" -a ! -path "/snap/*" -a ! -path 
"/sys/fs/cgroup/memory/*" -a ! -path "/sys/fs/selinux/*")
 while read -r l_bfs; do
 a_path+=( -a ! -path ""$l_bfs"/*")
 done < <(findmnt -Dkerno fstype,target | awk '$1 ~ /^\s*(nfs|proc|smb)/ {print $2}')
 # Populate array with files that will possibly fail one of the audits
 while IFS= read -r -d $'\0' l_file; do
 [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%#a' "$l_file")")
 done < <(find / \( "${a_path[@]}" \) \( -type f -o -type d \) -perm -0002 -print0 2>/dev/null)
 while IFS="^" read -r l_fname l_mode; do # Test files in the array
 [ -f "$l_fname" ] && a_file+=("$l_fname") # Add WR files
 if [ -d "$l_fname" ]; then # Add directories w/o sticky bit
 [ ! $(( $l_mode & $l_smask )) -gt 0 ] && a_dir+=("$l_fname")
 fi
 done < <(printf '%s\n' "${a_arr[@]}")
 if ! (( ${#a_file[@]} > 0 )); then
 l_output="$l_output\n - No world writable files exist on the local filesystem."
 else
 l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_file[@]}")\" World writable files 
on the system.\n - The following is a list of World writable files:\n$(printf '%s\n' 
"${a_file[@]}")\n - end of list\n"
 fi
 if ! (( ${#a_dir[@]} > 0 )); then
 l_output="$l_output\n - Sticky bit is set on world writable directories on the local 
filesystem."
 else
 l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_dir[@]}")\" World writable 
directories without the sticky bit on the system.\n - The following is a list of World writable 
directories without the sticky bit:\n$(printf '%s\n' "${a_dir[@]}")\n - end of list\n"
 fi
 unset a_path; unset a_arr; unset a_file; unset a_dir # Remove arrays
 # If l_output2 is empty, we pass
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2"
 [ -n "$l_output" ] && echo -e "- * Correctly configured * :\n$l_output\n"
 fi
}

echo "Ensure no unowned or ungrouped files or directories exist (Automated)"
{
 l_output="" l_output2=""
 a_path=(); a_arr=(); a_nouser=(); a_nogroup=() # Initialize arrays
 a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path 
"*/kubelet/pods/*" -a ! -path "/sys/fs/cgroup/memory/*")
 while read -r l_bfs; do
 a_path+=( -a ! -path ""$l_bfs"/*")
 done < <(findmnt -Dkerno fstype,target | awk '$1 ~ /^\s*(nfs|proc|smb)/ {print $2}')
 while IFS= read -r -d $'\0' l_file; do
 [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%U^%G' "$l_file")") && echo "Adding: $l_file"
 done < <(find / \( "${a_path[@]}" \) \( -type f -o -type d \) \( -nouser -o -nogroup \) -
print0 2> /dev/null)
 while IFS="^" read -r l_fname l_user l_group; do # Test files in the array
 [ "$l_user" = "UNKNOWN" ] && a_nouser+=("$l_fname")
 [ "$l_group" = "UNKNOWN" ] && a_nogroup+=("$l_fname")
 done <<< "$(printf '%s\n' "${a_arr[@]}")"
 if ! (( ${#a_nouser[@]} > 0 )); then
 l_output="$l_output\n - No unowned files or directories exist on the local filesystem."
 else
 l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nouser[@]}")\" unowned files or 
directories on the system.\n - The following is a list of unowned files and/or 
directories:\n$(printf '%s\n' "${a_nouser[@]}")\n - end of list"
 fi
 if ! (( ${#a_nogroup[@]} > 0 )); then
 l_output="$l_output\n - No ungrouped files or directories exist on the local filesystem."
 else
 l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_nogroup[@]}")\" ungrouped files 
or directories on the system.\n - The following is a list of ungrouped files and/or 
directories:\n$(printf '%s\n' "${a_nogroup[@]}")\n - end of list"
 fi 
 unset a_path; unset a_arr ; unset a_nouser; unset a_nogroup # Remove arrays
 if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
 echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2"
 [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n"
 fi
}

echo "Ensure SUID and SGID files are reviewed (Manual)"
{
 l_output="" l_output2=""
 a_arr=(); a_suid=(); a_sgid=() # initialize arrays
 # Populate array with files that will possibly fail one of the audits
 while read -r l_mpname; do
 while IFS= read -r -d $'\0' l_file; do
 [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%#a' "$l_file")")
 done < <(find "$l_mpname" -xdev -not -path "/run/user/*" -type f \( -perm -2000 -o -perm -4000 \) -print0)
 done <<< "$(findmnt -Derno target)"
 # Test files in the array
 while IFS="^" read -r l_fname l_mode; do
 if [ -f "$l_fname" ]; then
 l_suid_mask="04000"; l_sgid_mask="02000"
 [ $(( $l_mode & $l_suid_mask )) -gt 0 ] && a_suid+=("$l_fname")
 [ $(( $l_mode & $l_sgid_mask )) -gt 0 ] && a_sgid+=("$l_fname")
 fi
 done <<< "$(printf '%s\n' "${a_arr[@]}")" 
 if ! (( ${#a_suid[@]} > 0 )); then
 l_output="$l_output\n - There are no SUID files exist on the system"
 else
 l_output2="$l_output2\n - List of \"$(printf '%s' "${#a_suid[@]}")\" 
SUID executable files:\n$(printf '%s\n' "${a_suid[@]}")\n - end of list -\n"
 fi
 if ! (( ${#a_sgid[@]} > 0 )); then
 l_output="$l_output\n - There are no SGID files exist on the system"
 else
 l_output2="$l_output2\n - List of \"$(printf '%s' "${#a_sgid[@]}")\" 
SGID executable files:\n$(printf '%s\n' "${a_sgid[@]}")\n - end of list -\n"
 fi
 [ -n "$l_output2" ] && l_output2="$l_output2\n- Review the preceding 
list(s) of SUID and/or SGID files to\n- ensure that no rogue programs have 
been introduced onto the system.\n" 
 unset a_arr; unset a_suid; unset a_sgid # Remove arrays
 # If l_output2 is empty, Nothing to report
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n$l_output\n"
 else
 echo -e "\n- Audit Result:\n$l_output2\n"
 [ -n "$l_output" ] && echo -e "$l_output\n"
 fi
}

echo "Audit system file permissions (Manual)"
rpm -qf /bin/bash
rpm -V bash
rpm -V `rpm -qf /etc/passwd`
rpm -Va --nomtime --nosize --nomd5 --nolinkto --noconfig --noghost > /etc/passwd
rpm -Va --nomtime --nosize --nomd5 --nolinkto --noconfig --noghost > /etc/passwd-
rpm -Va --nomtime --nosize --nomd5 --nolinkto --noconfig --noghost > /etc/shadow
rpm -Va --nomtime --nosize --nomd5 --nolinkto --noconfig --noghost > /etc/shadow-
rpm -Va --nomtime --nosize --nomd5 --nolinkto --noconfig --noghost > /etc/sudoers
rpm -Va --nomtime --nosize --nomd5 --nolinkto --noconfig --noghost > /bin/bash

echo "Ensure accounts in /etc/passwd use shadowed passwords (Automated)"
awk -F: '($2 != "x" ) { print $1 " is not set to shadowed passwords "}' /etc/passwd

echo "Ensure /etc/shadow password fields are not empty (Automated)"
awk -F: '($2 == "" ) { print $1 " does not have a password "}' /etc/shadow

echo "Ensure all groups in /etc/passwd exist in /etc/group"
for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
 grep -q -P "^.*?:[^:]*:$i:" /etc/group
 if [ $? -ne 0 ]; then
 echo "Group $i is referenced by /etc/passwd but does not exist in 
/etc/group"
 fi
done

echo "Ensure no duplicate UIDs exist (Automated)"
{
 while read -r l_count l_uid; do
 if [ "$l_count" -gt 1 ]; then
 echo -e "Duplicate UID: \"$l_uid\" Users: \"$(awk -F: '($3 == n) { 
print $1 }' n=$l_uid /etc/passwd | xargs)\""
 fi
 done < <(cut -f3 -d":" /etc/passwd | sort -n | uniq -c)
}

echo "Ensure no duplicate GIDs exist (Automated)"
{
 while read -r l_count l_gid; do
 if [ "$l_count" -gt 1 ]; then
 echo -e "Duplicate GID: \"$l_gid\" Groups: \"$(awk -F: '($3 == n) { 
print $1 }' n=$l_gid /etc/group | xargs)\""
 fi
 done < <(cut -f3 -d":" /etc/group | sort -n | uniq -c)
}

echo "Ensure no duplicate user names exist (Automated)"
{
 while read -r l_count l_user; do
 if [ "$l_count" -gt 1 ]; then
 echo -e "Duplicate User: \"$l_user\" Users: \"$(awk -F: '($1 == n) { 
print $1 }' n=$l_user /etc/passwd | xargs)\""
 fi
 done < <(cut -f1 -d":" /etc/passwd | sort -n | uniq -c)
}

echo "Ensure no duplicate group names exist (Automated)"
{
 while read -r l_count l_group; do
 if [ "$l_count" -gt 1 ]; then
 echo -e "Duplicate Group: \"$l_group\" Groups: \"$(awk -F: '($1 == 
n) { print $1 }' n=$l_group /etc/group | xargs)\""
 fi
 done < <(cut -f1 -d":" /etc/group | sort -n | uniq -c)
}

echo "Ensure root path integrity (Automated)"
{
 l_output2=""
 l_pmask="0022"
 l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"
 l_root_path="$(sudo -Hiu root env | grep '^PATH' | cut -d= -f2)"
 unset a_path_loc && IFS=":" read -ra a_path_loc <<< "$l_root_path"
 grep -q "::" <<< "$l_root_path" && l_output2="$l_output2\n - root's path 
contains a empty directory (::)"
 grep -Pq ":\h*$" <<< "$l_root_path" && l_output2="$l_output2\n - root's 
path contains a trailing (:)"
 grep -Pq '(\h+|:)\.(:|\h*$)' <<< "$l_root_path" && l_output2="$l_output2\n 
- root's path contains current working directory (.)"
 while read -r l_path; do
 if [ -d "$l_path" ]; then
 while read -r l_fmode l_fown; do
 [ "$l_fown" != "root" ] && l_output2="$l_output2\n - Directory: 
\"$l_path\" is owned by: \"$l_fown\" should be owned by \"root\""
 [ $(( $l_fmode & $l_pmask )) -gt 0 ] && l_output2="$l_output2\n -
Directory: \"$l_path\" is mode: \"$l_fmode\" and should be mode: 
\"$l_maxperm\" or more restrictive"
 done <<< "$(stat -Lc '%#a %U' "$l_path")"
 else
 l_output2="$l_output2\n - \"$l_path\" is not a directory"
 fi
 done <<< "$(printf "%s\n" "${a_path_loc[@]}")"
 if [ -z "$l_output2" ]; then
 echo -e "\n- Audit Result:\n *** PASS ***\n - Root's path is correctly 
configured\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit 
failure * :\n$l_output2\n"
 fi
}

echo "Ensure root is the only UID 0 account (Automated)"
awk -F: '($3 == 0) { print $1 }' /etc/passwd

echo "Ensure local interactive user home directories are configured (Automated)"
{
 l_output="" l_output2="" l_heout2="" l_hoout2="" l_haout2=""
 l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn 
'/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$"
 unset a_uarr && a_uarr=() # Clear and initialize array
 while read -r l_epu l_eph; do # Populate array with users and user home location
 a_uarr+=("$l_epu $l_eph")
 done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' 
/etc/passwd)"
 l_asize="${#a_uarr[@]}" # Here if we want to look at number of users before proceeding 
 [ "$l_asize " -gt "10000" ] && echo -e "\n ** INFO **\n - \"$l_asize\" Local interactive 
users found on the system\n - This may be a long running check\n"
 while read -r l_user l_home; do
 if [ -d "$l_home" ]; then
 l_mask='0027'
 l_max="$( printf '%o' $(( 0777 & ~$l_mask)) )"
 while read -r l_own l_mode; do
 [ "$l_user" != "$l_own" ] && l_hoout2="$l_hoout2\n - User: \"$l_user\" Home 
\"$l_home\" is owned by: \"$l_own\""
 if [ $(( $l_mode & $l_mask )) -gt 0 ]; then
 l_haout2="$l_haout2\n - User: \"$l_user\" Home \"$l_home\" is mode: \"$l_mode\" 
should be mode: \"$l_max\" or more restrictive"
 fi
 done <<< "$(stat -Lc '%U %#a' "$l_home")"
 else
 l_heout2="$l_heout2\n - User: \"$l_user\" Home \"$l_home\" Doesn't exist"
 fi
 done <<< "$(printf '%s\n' "${a_uarr[@]}")"
 [ -z "$l_heout2" ] && l_output="$l_output\n - home directories exist" || 
l_output2="$l_output2$l_heout2"
 [ -z "$l_hoout2" ] && l_output="$l_output\n - own their home directory" || 
l_output2="$l_output2$l_hoout2"
 [ -z "$l_haout2" ] && l_output="$l_output\n - home directories are mode: \"$l_max\" or more 
restrictive" || l_output2="$l_output2$l_haout2"
 [ -n "$l_output" ] && l_output=" - All local interactive users:$l_output"
 if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
 echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * :\n$l_output"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit failure * :\n$l_output2"
 [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output"
 fi
}

echo "Ensure local interactive user dot files access is configured (Automated)"
{
 l_output="" l_output2="" l_output3=""
 l_bf="" l_df="" l_nf="" l_hf=""
 l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed 
-rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$"
 unset a_uarr && a_uarr=() # Clear and initialize array
 while read -r l_epu l_eph; do # Populate array with users and user home 
location
 [[ -n "$l_epu" && -n "$l_eph" ]] && a_uarr+=("$l_epu $l_eph")
 done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " 
$(NF-1) }' /etc/passwd)"
 l_asize="${#a_uarr[@]}" # Here if we want to look at number of users 
before proceeding 
 l_maxsize="1000" # Maximun number of local interactive users before warning (Default 1,000)
 [ "$l_asize " -gt "$l_maxsize" ] && echo -e "\n ** INFO **\n -
\"$l_asize\" Local interactive users found on the system\n - This may be a 
long running check\n"
 file_access_chk()
 {
 l_facout2=""
 l_max="$( printf '%o' $(( 0777 & ~$l_mask)) )"
 if [ $(( $l_mode & $l_mask )) -gt 0 ]; then
 l_facout2="$l_facout2\n - File: \"$l_hdfile\" is mode: \"$l_mode\" 
and should be mode: \"$l_max\" or more restrictive"
 fi
 if [[ ! "$l_owner" =~ ($l_user) ]]; then
 l_facout2="$l_facout2\n - File: \"$l_hdfile\" owned by: 
\"$l_owner\" and should be owned by \"${l_user//|/ or }\""
 fi
 if [[ ! "$l_gowner" =~ ($l_group) ]]; then
 l_facout2="$l_facout2\n - File: \"$l_hdfile\" group owned by: 
\"$l_gowner\" and should be group owned by \"${l_group//|/ or }\""
 fi
 }
 while read -r l_user l_home; do
 l_fe="" l_nout2="" l_nout3="" l_dfout2="" l_hdout2="" l_bhout2=""
 if [ -d "$l_home" ]; then
 l_group="$(id -gn "$l_user" | xargs)"
 l_group="${l_group// /|}"
 while IFS= read -r -d $'\0' l_hdfile; do
 while read -r l_mode l_owner l_gowner; do
 case "$(basename "$l_hdfile")" in
 .forward | .rhost )
 l_fe="Y" && l_bf="Y"
l_dfout2="$l_dfout2\n - File: \"$l_hdfile\" exists" ;;
 .netrc )
 l_mask='0177'
file_access_chk
if [ -n "$l_facout2" ]; then
 l_fe="Y" && l_nf="Y"
l_nout2="$l_facout2"
 else
 l_nout3=" - File: \"$l_hdfile\" exists"
 fi ;;
 .bash_history )
 l_mask='0177'
file_access_chk
if [ -n "$l_facout2" ]; then
 l_fe="Y" && l_hf="Y"
l_bhout2="$l_facout2"
 fi ;;
 * )
 l_mask='0133'
file_access_chk
if [ -n "$l_facout2" ]; then
 l_fe="Y" && l_df="Y"
l_hdout2="$l_facout2"
 fi ;;
 esac
 done <<< "$(stat -Lc '%#a %U %G' "$l_hdfile")"
 done < <(find "$l_home" -xdev -type f -name '.*' -print0)
 fi
 if [ "$l_fe" = "Y" ]; then
 l_output2="$l_output2\n - User: \"$l_user\" Home Directory: 
\"$l_home\""
 [ -n "$l_dfout2" ] && l_output2="$l_output2$l_dfout2"
 [ -n "$l_nout2" ] && l_output2="$l_output2$l_nout2"
 [ -n "$l_bhout2" ] && l_output2="$l_output2$l_bhout2"
 [ -n "$l_hdout2" ] && l_output2="$l_output2$l_hdout2"
 fi
 [ -n "$l_nout3" ] && l_output3="$l_output3\n - User: \"$l_user\" Home 
Directory: \"$l_home\"\n$l_nout3"
 done <<< "$(printf '%s\n' "${a_uarr[@]}")"
 unset a_uarr # Remove array
 [ -n "$l_output3" ] && l_output3=" - ** Warning **\n - \".netrc\" files 
should be removed unless deemed necessary\n and in accordance with local 
site policy:$l_output3"
 [ -z "$l_bf" ] && l_output="$l_output\n - \".forward\" or \".rhost\" 
files"
 [ -z "$l_nf" ] && l_output="$l_output\n - \".netrc\" files with 
incorrect access configured"
 [ -z "$l_hf" ] && l_output="$l_output\n - \".bash_history\" files with 
incorrect access configured"
 [ -z "$l_df" ] && l_output="$l_output\n - \"dot\" files with incorrect 
access configured"
 [ -n "$l_output" ] && l_output=" - No local interactive users home 
directories contain:$l_output"
 if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
 echo -e "\n- Audit Result:\n ** PASS **\n - * Correctly configured * 
:\n$l_output\n"
 echo -e "$l_output3\n"
 else
 echo -e "\n- Audit Result:\n ** FAIL **\n - * Reasons for audit 
failure * :\n$l_output2\n"
 echo -e "$l_output3\n"
 [ -n "$l_output" ] && echo -e "- * Correctly configured * 
:\n$l_output\n"
 fi
}
