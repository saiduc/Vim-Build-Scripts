# Vim Build Scripts

Some scripts to put into your .vimrc if you want to easily compile and run programs with ctrl+b.

## Setup

Just copy the script from the necessary files to your .vimrc file. It shouldn't matter where you paste it. The python script has both python2 and python3 variants in the same file, set to build with different shortcuts. Copy only the one you want, or both if you need to be able to run both versions.

## Features

Script will detect the filetype, so the same shortcut can be used to execute different language scripts.

Programs that require compilation (currently only .cpp supported) will be compiled quietly in background and executed. Binary file is deleted after execution.

The output is shown in a buffer below the code buffer. New buffer is created only if one does not already exist from a previous execution. The buffer does not display line numbers or status bars to keep it neat.

Focus will return to code pane after execution, so you can continue coding without disturbance.

## Acknowledgments

* https://stackoverflow.com/questions/18948491/running-python-code-in-vim was very useful to get up and running with the Python scripts, I just had to make some modifications to buffer behavior and make a C++ script.
