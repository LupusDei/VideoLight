module ConvertButton
  def mouse_clicked(e)
    puts "Converting.............."
    converter = ConverterWhisperer.new()
    converter.source_file = scene.find("input_file").text
    converter.output_folder = scene.find("output_folder").text
    converter.type = scene.find("convert_options").value
    converter.quality = scene.find("quality_options").value
    converter.convert
  end
  
end