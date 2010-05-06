header :text => "The Limelight Video Converter"
converter_form do
  input_label :text => "Source File:"
  input_file :players => "text_box", :id => "input_file"
  output_label :text => "Destination Folder:"
  output_folder :players => "text_box", :id => "output_folder"
  convert_label :text => "Convert to:"
  convert_options :players => "combo_box", :choices => ['.flv', '.mp4', '.mpeg'], :id => "convert_options"
  quality_label :text => "Quality:"
  quality_options :players => "combo_box", :choices => ['Excellent', 'Good', 'Medium', 'Low'], :id => "quality_options"
  convert_button :players => "button", :text => "Convert", :id => "convert"
end
