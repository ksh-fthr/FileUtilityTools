require 'logger'
$log = Logger.new("./#{$0}.log")

class FileGsubString
    attr_accessor :input_file
    attr_accessor :src_str    
    attr_accessor :dest_str
    attr_accessor :file_list

    #
    # 初期化.
    #
    def initialize(input_file, src_str, dest_str)
        $log.info('method: initialize')

        @input_file = input_file
        @src_str = src_str
        @dest_str = dest_str
        @file_list = Array.new
    end

    #
    # スクリプト引数で渡されたファイルを読み込み, 処理対象のファイル名をリストにセットする.
    #
    def set_target_list
        $log.info('method: set_target_list')

        target = open(@input_file, 'r:utf-8')
        target.each {|line|
            if(line.start_with?("#") == false) then
                @file_list.push(line)
            end
        }
        target.close
    end

    #
    # ファイルリストから処理対象のファイルを読み込み, スクリプト引数で渡された文字列にヒットした文字列を
    # 同じくスクリプト引数で渡された文字列に置換する.
    # そのうえで、元のファイルを上書き保存する.
    #
    def gsub_str
        $log.info('method: gsub_str')

        begin
            @file_list.each {|file|
                # 改行を削除
                target_file = file.strip
                $log.debug('file: ' + target_file)

                # 読み込み
                f = open(target_file, 'r:utf-8')
                buf = f.read()
                # 置換
                buf.gsub!(/#{@src_str}/, @dest_str)
                # 書き込み
                f = open(target_file, 'w:utf-8')
                f.write(buf)
=begin
open のブロックを使用して「置換」→「置換後のバッファを上書き保存」したかったが駄目だった
--> 0バイトのファイルが作成された

                open(file, 'w+:utf-8') {|f|
                #open(file) {|f|
                    # 置換処理
                    body = f.read
                    body.gsub!(/PowerGeneration/, 'Sales')
                    $log.debug('body: ' + body)
                    f.write body
                }
=end
            }
        rescue => e
            $log.error('exception: ' + e.to_s)
        end
    end
end

# 引数チェック
if ARGV[0] == nil or ARGV[1] == nil  or ARGV[2] == nil then
  p "Usage: #{$0} target_file_list src dest"
  exit
end

$log.info('')
$log.info('START')
$log.debug('param: ' + ARGV[0])
$log.debug('param: ' + ARGV[1])
$log.debug('param: ' + ARGV[2])

gs = FileGsubString.new(ARGV[0], ARGV[1], ARGV[2])
gs.set_target_list
gs.gsub_str

$log.info('END')
