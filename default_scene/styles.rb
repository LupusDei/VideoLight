# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

default_scene {
  background_color :black
  secondary_background_color :white
  gradient :on
  horizontal_alignment :left
  vertical_alignment :top
  width "100%"
  height "100%"
}

header {
  margin 10
  height 70
  width "100%"
  font_size 32
  font_style :bold
  background_color :blue
  secondary_background_color :green
  gradient :on
  transparency '80%'
  rounded_corner_radius 7
}

converter_form {
  left_margin 50
  height 250
  width 450
  transparency '90%'
  border_width 2
  background_color :red
  horizontal_alignment :left
  padding 5
  rounded_corner_radius 7
}

input_label {
  width 150
  height 50
  font_style :bold
  font_size 16
}

input_file {
  width 200
}

output_label {
  extends :input_label
}

output_folder {
  extends :input_file
}

convert_label {
  extends :input_label
}

quality_label {
  extends :input_label
}