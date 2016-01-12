require 'fileutils'
require 'logger'

$log = Logger.new("./#{$0}.log")

class FileRename
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
            if line.start_with?("#") == false then
                @file_list.push(line)
            end
        }
        target.close
    end

    #
    # ファイルリストから処理対象のファイルを読み込み, ファイル名をリネームする.
    #
    def rename_file
        $log.info('method: rename_file')

        begin
            @file_list.each {|file|
                # 改行を削除
                src_file = file.strip

                # リネーム
                dest_file = src_file.gsub(/#{@src_str}/, @dest_str).strip

                $log.debug('リネーム対象ファイル: ' + src_file)
                $log.debug('リネーム後ファイル:   ' + dest_file)

                if(src_file != dest_file) then
                    FileUtils.mv(src_file, dest_file)
                end
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

rn = FileRename.new(ARGV[0], ARGV[1], ARGV[2])
rn.set_target_list
rn.rename_file

$log.info('END')

