class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def custom_resize(w, h)
    manipulate! do |img|
      if img[:width] <= img[:height]
        # Image is tall ...
        img.resize w
        pixels_to_remove = ((img[:height] - h)/2).round # calculate amount to remove
        img.shave "0x#{pixels_to_remove}" # shave off the top and bottom
      else
        # Image is wide
        img.resize 'x' + h.to_s # resize to 140px high
        pixels_to_remove = ((img[:width] - w)/2).round # calculate amount to remove
        img.shave "#{pixels_to_remove}x0" # shave off the sides
      end

      img # Returned image should be 180x140, cropped from the centre
    end
  end

  #
  # def custom_resize(w, h)
  #   current_path = self.file.file
  #   rmagick_image = ::MiniMagick::Image.read(current_path).first
  #   if (rmagick_image.columns <= w && rmagick_image.rows <= h)
  #     white_fill = MiniMagick::GradientFill.new(0, 0, 0, 0, "#FFF", "#FFF")
  #     dst = MiniMagick::Image.new(w, h, white_fill)
  #     result = dst.composite(rmagick_image, MiniMagick::CenterGravity, MiniMagick::OverCompositeOp)
  #     result.write(current_path)
  #   else
  #     self.resize_and_pad(w, h)
  #   end
  # end

  version :hrect_lg do
    process :custom_resize => [800, 533]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
