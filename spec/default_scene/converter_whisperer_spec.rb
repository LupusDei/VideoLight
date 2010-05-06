require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe ConverterWhisperer do
  before do
    @whisperer = ConverterWhisperer.new
  end
  context "Receiving input" do
    it "can accept a source file" do
      source = "file/source.file"
      @whisperer.source_file = source
      @whisperer.source_file.should == source
    end
    
    it "can accept an output folder" do
      folder = "file/source.file"
      @whisperer.output_folder = folder
      @whisperer.output_folder.should == folder
    end
    
    it "can accept a conversion type" do
      type = ".flv"
      @whisperer.type = type
      @whisperer.type.should == type
    end
    
    it "can use different levels of quality" do
      quality = "Excellent"
      @whisperer.quality = quality
      @whisperer.quality.should == quality
    end
  end
  
  context "Converting quality into meaning" do
    it "will use minimal settings for low quality" do
      @whisperer.quality = "Low"
      specs = @whisperer.get_conversion_specs
      specs.audio_bit_rate.should == "32"
    end
  end
  
  context "Building the command" do
    before do
      @whisperer.source_file = "file/file/source.file"
      @whisperer.output_folder = "place/file"
      @whisperer.type = ".flv"
    end
    
    it "extracts the file name" do
      name = @whisperer.extract_file_name
      name.should == "source"
    end
    
    it "will add a forward slash onto the output folder if it isn't there" do
      @whisperer.add_righthand_slash_to_output_folder
      @whisperer.output_folder.should == "place/file/"
    end
    
    it "will create a ffmpeg command for low quality" do
      @whisperer.quality = "Low"
      command = @whisperer.build_command
      command.should == "ffmpeg -i file/file/source.file -ab 32kb -ar 11025 -b 50kb -r 15 place/file/source.flv"
    end
    
    it "will create a ffmpeg command for medium quality" do
      @whisperer.quality = "Medium"
      command = @whisperer.build_command
      command.should == "ffmpeg -i file/file/source.file -ab 64kb -ar 22050 -b 150kb -r 20 place/file/source.flv"
    end
    
    it "will create a ffmpeg command for good quality" do
      @whisperer.quality = "Good"
      command = @whisperer.build_command
      command.should == "ffmpeg -i file/file/source.file -ab 128kb -ar 22050 -b 250kb -r 30 place/file/source.flv"
    end
    
    it "will create a ffmpeg command for excellent quality" do
      @whisperer.quality = "Excellent"
      command = @whisperer.build_command
      command.should == "ffmpeg -i file/file/source.file -ab 256kb -ar 44100 -b 500kb -r 50 place/file/source.flv"
    end
  end
end

describe ConverterWhisperer::ConversionSpecs do
  @@atrs = ['audio_bit_rate', 'audio_sampling_rate', 'video_bit_rate', 'frame_rate']
  def make_expected_values_from (values)
    @expect = {}
    @@atrs.each_with_index {|atr,val| @expect[atr] = values[val]}
  end
  
  context "Low Quality" do
    before do
      @specs = ConverterWhisperer::ConversionSpecs.new("Low")
      values = ["32","11025","50","15"]
      make_expected_values_from values
    end
    
    @@atrs.each do |attribute|
      it "has a #{attribute}" do
        @specs.send(attribute.to_sym).should == @expect[attribute]
      end
    end
  end
  
  context "Medium Quality" do
    before do
      @specs = ConverterWhisperer::ConversionSpecs.new("Medium")
      values = ["64","22050","150","20"]
      make_expected_values_from values
    end
    
    @@atrs.each do |attribute|
      it "has a #{attribute}" do
        @specs.send(attribute.to_sym).should == @expect[attribute]
      end
    end
  end
  
  context "Good Quality" do
    before do
      @specs = ConverterWhisperer::ConversionSpecs.new("Good")
      values = ["128","22050","250","30"]
      make_expected_values_from values
    end
    
    @@atrs.each do |attribute|
      it "has a #{attribute}" do
        @specs.send(attribute.to_sym).should == @expect[attribute]
      end
    end
  end
  
  context "Excellent Quality" do
    before do
      @specs = ConverterWhisperer::ConversionSpecs.new("Excellent")
      values = ["256","44100","500","50"]
      make_expected_values_from values
    end
    
    @@atrs.each do |attribute|
      it "has a #{attribute}" do
        @specs.send(attribute.to_sym).should == @expect[attribute]
      end
    end
  end
end