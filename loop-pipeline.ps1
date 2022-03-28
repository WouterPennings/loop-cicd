# Parameter writes output to file when an error occurs
param([Int32]$to_file=0)

function print_succes {
    param($text)
    Write-Host "[SUCCES]", $text -ForegroundColor DarkGreen,DarkGreen
}

function print_error {
    param($text)
    Write-Host "[ERROR]", $text -ForegroundColor Red,Red
}

function print_info {
    param($text)
    Write-Host "[INFO]", $text -ForegroundColor Blue,Blue
}

[bool] $has_failed = $false

$clippy = cargo clippy -- -D warnings
if($?) { print_succes -text "Cargo clippy succeeded" }
else 
{ 
    Write-Output $clippy
    print_error -text "Cargo clippy failed"
    $has_failed = $true
}

$fmt = cargo fmt --all -- --check
if($?) { print_succes -text "Cargo fmt succeeded" }
else 
{ 
    Write-Output $fmt
    print_error -text "Cargo fmt failed"
    $has_failed = $true
}

$check = cargo check 
if($?) { print_succes -text "Cargo check succeeded" }
else 
{ 
    Write-Output $check
    print_error -text "Cargo check failed"
    $has_failed = $true
}

$test = cargo test
if($?) { print_succes -text "Cargo test succeeded" }
else 
{ 
    Write-Output $test
    print_error -text "Cargo test failed"
    $has_failed = $true
}

$test = cargo build --release
$test = py tests/integration_test.py 
if($?) { print_succes -text "Integration tests succeeded" }
else 
{ 
    Write-Output $test
    print_error -text "Integration tests succeeded"
    $has_failed = $true
}

if($has_failed){
    print_error -text "CI/CD Pipeline has failed"
    if($to_file) {
        New-item -Name cicd_error_output.txt -Value "$($clippy) $($fmt) $($check) $($test)" -Force | out-null
        print_info -text "Output written to file named '.\cicd_error_output.txt'"
    }
}
else
{
    Write-Host ""
    print_succes -text "CI/CD Pipeline has succeeded"
}