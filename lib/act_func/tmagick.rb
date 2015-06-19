module ActFunc
  class Ttmagick
    #画图类
    #img->底图 "#{Rails.root}/public/images/1.jpg"
    #newimg->处理完保存的地址 save img handle path example->"#{Rails.root}/public/images/new.jpg"
    #example-> Tmagick.new("1.jpg","public/n.jpg").images(images),texts(texts).images(imgs).write
    def initialize(img, newimg=nil)
      @pushimg = Magick::Image.read(img).first
      @poppath = newimg.blank? ? img : newimg
    end

    #图片叠加和水印
    #images->多图片叠加，数组，在一个图片上画多个图片; image=>{img: "1.jpg", x: 0, y: 0}，img要画的图片地址，xy画的左顶点位置
    #return->成功返回当前对象，失败返回nil
    def images(images)
      return nil if images.blank?
      images.each do |img|
        image = Magick::Image.read(img[:img]).first.resize_to_fit(img[:w], img[:h])
        @pushimg.composite!(image, img[:x], img[:y], Magick::OverCompositeOp)
      end
      return self
    end

    #图片上写字
    #fontobjs 文字数组; fontobj=>{text: "aaaaaaaaa",color: "#000000",font: "simsun.ttc'",size: 20,weight: 100, x: 0, y: 0}
    #   text文字内容，color颜色，font字体，size大小，weight粗细，xy画的左顶点位置
    #return-》成功返回当前对象，失败返回nil
    def texts(texts)
      return nil if texts.blank?
      texts.each do |text|
        copyright = Magick::Draw.new
        copyright.font = text[:font]
        copyright.pointsize = text[:size]
        copyright.font_weight = text[:weight]
        copyright.fill = text[:color]
        copyright.annotate(@pushimg, 0, 0, text[:x], text[:y]+12, text[:text])
      end
      return self
    end

    #重定义图片大小
    def resize(new_width, new_height)
      @pushimg = Magick::Image.read(@pushimg).first.resize_to_fit(new_width, new_height)
      @pushimg.blank? ? nil : self
    end

    #写出操作
    def write
      @pushimg.write(@poppath)
    end
  end
end