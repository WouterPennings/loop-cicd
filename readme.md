# Loop Pipeline

This is a simple Powershell script that runs the same tests as the [Loop](https://github.com/looplanguage/loop) pipeline. It is way faster to run locally than on the GitLab servers (about 40 times), therefore a big time saver.

## How to use
 - Download the file in the root of the Loop repository: `wget -O .\loop-pipeline.ps1 https://raw.githubusercontent.com/wouterpennings/loop-pipeline/main/loop-pipeline.ps1`
 - To run the script just type this: `.\loop-pipeline.ps1`. 
    - If you want to save the output when there are errors, execute: `.\loop-pipeline.ps1 -to_file 1` 
