param(
    [string] $Name = 'amf',
    [string] $Version = '1.4.34',
    [string] $Uri = 'https://github.com/GPUOpen-LibrariesAndSDKs/AMF.git',
    [string] $Hash = '6d7bec0469961e2891c6e1aaa5122b76ed82e1db',
    [array] $Targets = @('x64')
)

function Setup {
    Log-Information "Setup (${Target})"

    New-Item -Path $Path -ItemType Directory -Force *> $null

    Invoke-GitCheckout $Uri $Hash -Sparse -SparseArgs set,amf/public/include
}

function Install {
    Log-Information "Install (${Target})"
    Set-Location $Path

    New-Item -Path "$($ConfigData.OutputPath)/include/AMF" -ItemType Directory -Force *> $null

    $Items = @(
        @{
            Path = "amf/public/include/*"
            Destination = "$($ConfigData.OutputPath)/include/AMF/"
            ErrorAction = "SilentlyContinue"
            Recurse = $true
        }
    )

    $Items | ForEach-Object {
        $Item = $_
        Log-Output ('{0} => {1}' -f ($Item.Path -join ", "), $Item.Destination)
        Copy-Item @Item
    }
}
