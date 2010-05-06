require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Default Scene" do

  uses_limelight :scene => "default_scene", :hidden => true

  it "should have a source file input" do
    prop = scene.find("input_file")
    prop.should_not be_nil
  end
  
  it "should have a output folder input" do
    prop = scene.find("output_folder")
    prop.should_not be_nil
  end
  
  it "should have a convertion type option" do
    prop = scene.find("convert_options")
    prop.should_not be_nil
    prop.choices.should == ['.flv', '.mp4', '.mpeg']
  end
  
  it "should have a quality option" do
    prop = scene.find("quality_options")
    prop.should_not be_nil
    prop.choices.should == ['Excellent', 'Good', 'Medium', 'Low']
  end
  
  it "should have a convert button" do
    prop = scene.find("convert")
    prop.should_not be_nil
    prop.text.should == "Convert"
    prop.players.should == "button"
  end
end