############################################################
# Author: Joey Milton                                      #
# Date: 6/9/2025                                           #
# Purpose: These scripts are to automate installing Wazuh  #
#          with salt scripts.                              #
############################################################

When using these scripts make sure we are the currently on the right version of
Wazuh due to them updating offen. Also for the Linux and Windows salt states 
change the manager IP so they can connect to the manager when the state runs.
Make sure you use the manager salt state first so the agents can connect without
problems.
