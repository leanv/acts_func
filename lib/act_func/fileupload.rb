module ActFunc
  class Fileupload
    #file upload
    #params: file->file stream,filepath->file save path,rule->can upload file format("jpg|xls")，minsize and maxsize->minsize<file's size<maxsize
    #return: {state: true, result: "new filename"} or {state: false, result: "error message"}
    def Fileupload.upload(file, filepath="", rule="jpg|xls", minsize=1, maxsize=4000)
      result = Fileupload.rule_validata(file, rule, minsize, maxsize)
      if result[:state]
        sname = Fileupload.getname(file, filepath)
        begin
          unless Dir::exist?(filepath)
            unless system("mkdir -p #{filepath}")
              return {state: false, result: "目录创建失败，请于管理员联系"}
            end
          end
          File.open(filepath+sname, "wb") do |f|
            f.write(file.read)
          end
          return {state: true, result: sname}
        rescue
          return {state: false, result: "写入文件失败：#{$!}"}
        end
      else
        return {state: false, result: result[:message]}
      end
    end

    #validate file
    #params:file->file stream，rule->can upload file format，minsize<file's size<maxsize
    #return:{state: true} or return {state: false, message: "error message"}
    def Fileupload.rule_validata(file, rule, minsize, maxsize)
      rule_for = Fileupload.filename_validata(file, rule)
      unless rule_for
        return {state: false, message: "错误：文件格式不对，只允许上传#{rule}格式！\\n"}
      end
      if file.size<minsize*1024 || file.size>maxsize*1024
        return {state: false, message: "错误：文件大小错误，只允许#{minsize}kb~#{maxsize}kb！\\n"}
      end
      return {state: true}
    end

    #validate file format
    #params: file-> file stream; rule-> validate rule ("jpg|xls")
    #return: validate result -> true | false
    def Fileupload.filename_validata(file, rule)
      !eval("/\.(#{rule})+$/").match(file.original_filename).blank?
    end

    #get new file's name
    #params:filestream->file stream file name,filepath->file save path
    #return:new file's name
    def Fileupload.getname(filestream, filepath)
      file_for = Fileupload.file_format(filestream.original_filename)
      filename = Time.now.strftime("%Y%m%d%h%m%s")<<rand(99999).to_s<<file_for
      file = filepath+filename
      while File.exist?(file) do
        filename = Time.now.strftime("%Y%m%d%h%m%s")<<rand(99999).to_s<<file_for
        file = filepath+filename
      end
      filename
    end

    #get file format
    #params: filename->file's name
    #return: file format '.jpg','.exe'
    def Fileupload.file_format(filename)
      /\.[^\.]+$/.match(filename)[0]
    end

    #image upload
    #params: file->file stream; filepath->file save path; rule->can upload file format("jpg|xls"); minsize and maxsize->minsize<file's size<maxsize;  w->new image width, h->new image height
    #return: {state: true, result: "new filename"} or {state: false, result: "error message"}
    def Fileupload.imageupload(imgfile, filepath="", rule="jpg|jpeg", minsize=0, maxsize=2000, w=0, h=0)
      result = Fileupload.rule_validata(imgfile, rule, minsize, maxsize)
      if result[:state]
        sname = Fileupload.getname(imgfile, filepath)
        begin
          unless Dir::exist?(filepath)
            unless system("mkdir -p #{filepath}")
              return {state: false, result: "目录创建失败，请于管理员联系"}
            end
          end
          File.open(filepath+sname, "wb") do |f|
            f.write(imgfile.read)
          end
          Fileupload.resize(filepath + sname, w, h)
          return {state: true, result: sname}
        rescue
          return {state: false, result: "写入图片失败：#{$!}"}
        end
      else
        return {state: false, result: result[:message]}
      end
    end

    #delete dir
    #params: dir-> dir path
    #return true or false
    def Fileupload.rmdir(dir)
      system("rm -rf #{dir}")
    end

    #image resize
    #params: imagepath-> image file path; w-> new image width; h-> new image height
    def Fileupload.resize(imagepath, w, h)
      img = Magick::Image.read(imagepath)[0]
      if w==0 || h==0
        w=img.columns
        h=img.rows
      end
      newimg = img.resize_to_fill(w, h)
      newimg.write(imagepath)
    end
  end
end
