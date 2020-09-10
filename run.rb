require "pry" # 1. hexdump
# 2. read file as bytes
rom = File.open("morse_demo.ch8").each_byte.to_a # hexyl morse_demo.ch8, view bytes in the file as hex (step 1)
$pc = 0

# 0x means hexidecimal - whenever writing a hex number, prepend with 0x.
# ROM = read only memory
# a byte is always represented as 2 characters in hex
# hex can count up to 16 in 1 digit
# 9abcdef
# highest number you can store in a byte is when they're both at f - so 0xff, 255
# 8 bits is 1 byte

# - might have  to join bytes together (not add). little endian and big endian 'endianness'
# - bytes have to be joined in the right way
# - then set up loop to constantly read next byte off ROM and these will represent arguments to the instructions
# 00000000 00000000

# 1 and 2 are decode and executing
# fetch decode execute loop
# fetch next bytes
# decode the byes into instructiosn
# execute instructions
# puts rom
# grab next 2 bytes off rom array

def decode_parts(raw_instruction)
  nnn = raw_instruction & 0x0fff
  kk = raw_instruction & 0x00ff
  x = (raw_instruction >> 8) & 0xf
  y = (raw_instruction >> 4) & 0xf
  n = raw_instruction & 0x000f
  {
    nnn: nnn,
    kk: kk,
    x: x,
    y: y,
    n: n
  }
end

def fetch(rom)
  rom[$pc] << 8 | rom[$pc+1] #returning raw_instruction in some sort of endianness/joinedness

end

def decode(raw_instruction)
  parts = decode_parts(raw_instruction)
  x = (raw_instruction >> 12) & 0xf
  puts x.to_s(16)
  case x
  when 0x0
    case raw_instruction
    when 0x00e0
      puts "We have instructions DisplayClear"
    when 0x00ee
      puts "Opcode::RET"
    else
      puts "Opcode::SYS(nnn)"
    end
  when 0xa
    puts "LDI nnn: #{parts[:nnn].to_s(16)}"
  when 0x6
    puts "LD x: #{parts[:x].to_s(16)}, kk: #{parts[:kk].to_s(16)}"
    binding.pry
  when 0xd
    puts "DRW x: #{parts[:x].to_s(16)}, y: #{parts[:y].to_s(16)}, n: #{parts[:n].to_s(16)}"
  when 0x7
    puts "ADD"
  else
    # raise parts.inspect
    binding.pry
  end
  # take the two byes from fetch
  # return instruction
end

def execute(instruction)
  # takes instruction from decode and executes it
  $pc+=2 #move on execution
end

loop do
  bytes = fetch(rom)
  instruction = decode(bytes)
  execute(instruction)
end

# need a program counter 'pc' to find where i'm at in the ROM


# Instruction parsing:
# -  Each CHIP-8 instruction is two bytes in length and is represented using four hexadecimal digits.x
# - have to do bitshifting too (doing things with the individual bits)


# brew install hexyl
# same as hexdump but pretty colours

# base10, our counting system
# [3] pry(main)> rom[1].to_s(10)
# => "224"

# base16, also known as hex
# [4] pry(main)> rom[1].to_s(16)
# => "e0"

# binary!
# [5] pry(main)> rom[1].to_s(2)
# => "11100000"

  #[test]
#   fn decode_parts(instruction: u16) -> (Nnn, Kk, DataRegister, DataRegister, N) {
#     (
#       Nnn(instruction & 0x0fff),
#       Kk((instruction & 0x00ff) as u8),
#       DataRegister::from(((instruction >> 8) & 0xf) as u8),
#       DataRegister::from(((instruction >> 4) & 0xf) as u8),
#       N((instruction & 0x000f) as u8),
#     )
#   }

#   fn test_decode_parts() {
#     let (nnn, kk, x, y, n) = decode_parts(0b1111_1110_1100_1000);

#     assert_eq!(nnn.0, 0b1110_1100_1000);
#     assert_eq!(kk.0, 0b1100_1000);
#     assert_eq!(x, DataRegister::VE); // 14 (0b1110)
#     assert_eq!(y, DataRegister::VC); // 12 (0b1100)
#     assert_eq!(n.0, 0b1000);
# }
