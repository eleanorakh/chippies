# 1. hexdump
# 2. read file as bytes
File.open("morse_demo.ch8").each_byte.to_a # hexdump morse_demo.ch8, view bytes in the file as hex (step 1)


# 0x means hexidecimal - whenever writing a hex number, prepend with 0x.
# ROM = read only memory
# a byte is always represented as 2 characters in hex
# hex can count up to 16 in 1 digit
# 9abcdef
# highest number you can store in a byte is when they're both at f - so 0xff, 255
# 8 bits is 1 byte
# 

# - might have  to join bytes together (not add). little endian and big endian
# - bytes have to be joined in the right way
# - then set up loop to constantly read next byte off ROM and these will represent arguments to the instructions
# - have to do bitshifting too (doing things with the individual bits)
# - 


# -  Each CHIP-8 instruction is two bytes in length and is represented using four hexadecimal digits.x