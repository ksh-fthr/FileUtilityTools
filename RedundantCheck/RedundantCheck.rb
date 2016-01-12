#!/c/Ruby193/bin/ruby

$input_list1
$input_list2

class RedundantCheck

  # コンストラクタ
  def initialize
     $input_list1 = Array.new 
     $input_list2 = Array.new 
  end

  # 1)ファイルを1行ずつ読込む
  # 2)読込んだデータをリストにつめる
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

  # データ比較
  def listCompare(input_list1, input_list2)

    input_list1.each {|data1|
      input_list2.each {|data2|

        if data1 == data2 then
          # 重複データを標準出力
          puts data1
        end
      }
    }
  end
end

# 引数チェック
if ARGV[0] == nil or ARGV[1] == nil then
  p "Usage: DataCheck inputFile1 inputFile2"
  exit
end

filename1 = ARGV[0]
filename2 = ARGV[1]

# インスタンス生成～ファイル読込み
rc = RedundantCheck.new
rc.fileRead(filename1, $input_list1)
rc.fileRead(filename2, $input_list2)

# 重複データチェック
rc.listCompare($input_list1, $input_list2)

