#!/c/Ruby193/bin/ruby

$input_list1
$input_list2

class RedundantCheck

  # �R���X�g���N�^
  def initialize
     $input_list1 = Array.new 
     $input_list2 = Array.new 
  end

  # 1)�t�@�C����1�s���Ǎ���
  # 2)�Ǎ��񂾃f�[�^�����X�g�ɂ߂�
  def fileRead(input_file, input_list)

    if input_list == nil then
      puts "input_list is nil"
      exit 
    end

    target = open(input_file)
    target.each{|line|
      input_list.push(line)
    }
    target.close
  end

  # �f�[�^��r
  def listCompare(input_list1, input_list2)

    input_list1.each {|data1|
      input_list2.each {|data2|

        if data1 == data2 then
          # �d���f�[�^��W���o��
          puts data1
        end
      }
    }
  end
end

# �����`�F�b�N
if ARGV[0] == nil or ARGV[1] == nil then
  p "Usage: DataCheck inputFile1 inputFile2"
  exit
end

filename1 = ARGV[0]
filename2 = ARGV[1]

# �C���X�^���X�����`�t�@�C���Ǎ���
rc = RedundantCheck.new
rc.fileRead(filename1, $input_list1)
rc.fileRead(filename2, $input_list2)

# �d���f�[�^�`�F�b�N
rc.listCompare($input_list1, $input_list2)

