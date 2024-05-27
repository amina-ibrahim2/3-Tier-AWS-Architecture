
resource "aws_key_pair" "three_tier_key_pair" {
    key_name = "Three_Tier_Key_Pair"
    public_key = tls_private_key.three_tier_key_info.public_key_openssh 
}

resource "tls_private_key" "three_tier_key_info" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "key_pair_file" {
    content = tls_private_key.three_tier_key_info.private_key_pem
    filename = "Three_Tier_Key-Pair"
}

