class ConverterWhisperer
  attr_accessor :source_file, :output_folder, :type, :quality
  
  def initialize
    @source_file = nil
    @output_folder = nil
    @type = nil
    @quality = nil
  end
  
  def convert
    system(build_command)
  end
  
  def build_command
    file_name = extract_file_name
    add_righthand_slash_to_output_folder
    specs = get_conversion_specs
    command = "ffmpeg -i #{@source_file}"
    command += " -ab #{specs.audio_bit_rate}kb"
    command += " -ar #{specs.audio_sampling_rate}"
    command += " -b #{specs.video_bit_rate}kb"
    command += " -r #{specs.frame_rate}"
    command += " #{@output_folder}#{file_name}#{@type}"
  end
  
  def extract_file_name
    full_file_name = @source_file.split("/")[-1..-1].first
    full_file_name.split(".").first
  end
  
  def add_righthand_slash_to_output_folder
    @output_folder = @output_folder + "/" if @output_folder[-1..-1] != "/"
  end
  
  def get_conversion_specs
    ConversionSpecs.new(@quality)
  end
  
  class ConversionSpecs
    attr_accessor :audio_bit_rate, :audio_sampling_rate, :video_bit_rate, :frame_rate
    
    def initialize (quality)
      send(quality.to_sym)
    end
    
    def Low
      @audio_bit_rate = "32"
      @audio_sampling_rate = "11025"
      @video_bit_rate = "50"
      @frame_rate = "15"
    end
    
    def Medium
      @audio_bit_rate = "64"
      @audio_sampling_rate = "22050"
      @video_bit_rate = "150"
      @frame_rate = "20"
    end
    
    def Good
      @audio_bit_rate = "128"
      @audio_sampling_rate = "22050"
      @video_bit_rate = "250"
      @frame_rate = "30"
    end
    
    def Excellent
      @audio_bit_rate = "256"
      @audio_sampling_rate = "44100"
      @video_bit_rate = "500"
      @frame_rate = "50"
    end
  end
end
