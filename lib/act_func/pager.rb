class Pager
  def initialize(dqyclass='page-navigator-current PNNW-S',aclass='page-navigator-number PNNW-S',
      spageclass='page-navigator-prev',xpageclass='page-navigator-next',spagedis='page-navigator-prev-disable',
      xpagedis='page-navigator-next-disable',dianclass='page-navigator-dots')
    @dqyclass = dqyclass
    @aclass = aclass
    @spageclass = spageclass
    @xpageclass = xpageclass
    @spagedis = spagedis
    @xpagedis = xpagedis
    @dianclass = dianclass
  end
  def getpage(currentpage, pagecount, route)
    shenglvhao = "<span class='#{@dianclass}'>...</span>"
    syiye = currentpage>1 ? "<a class='#{@spageclass}' href='#{route}#{currentpage-1}'>&lt;上一页</a>" : "<span class='#{@spagedis}'>&lt;上一页</span>"
    xyiye = currentpage<pagecount ? "<a class='#{@xpageclass}' href='#{route}#{currentpage+1}'>下一页&gt;</a>" : "<span class='#{@xpagedis}'>&lt;下一页</span>"
    pages=""
    if currentpage<7 && pagecount>10
      for i in 1..9
        if currentpage==i
          pages += "<span class='#{@dqyclass}'>#{currentpage}</span>"
        else
          pages += "<a class='#{@aclass}' href='#{route}#{i}'>#{i}</a>"
        end
      end
      pages += shenglvhao
      pages += "<a class='#{@aclass}' href='#{route}#{pagecount}'>#{pagecount}</a>"
    elsif currentpage>=7 && currentpage<=pagecount-7
      pages = "<a class='#{@aclass}' href='1'>1</a>"
      pages += shenglvhao
      pages += "<a class='#{@aclass}S' href='#{route}#{currentpage-4}'>#{currentpage-4}</a>"
      pages += "<a class='#{@aclass}' href='#{route}#{currentpage-3}'>#{currentpage-3}</a>"
      pages += "<a class='#{@aclass}' href='#{route}#{currentpage-2}'>#{currentpage-2}</a>"
      pages += "<a class='#{@aclass}' href='#{route}#{currentpage-1}'>#{currentpage-1}</a>"
      pages += "<span class='#{@dqyclass}'>#{currentpage}</span>"
      pages += "<a class='#{@aclass}' href='#{route}#{currentpage+1}'>#{currentpage+1}</a>"
      pages += "<a class='#{@aclass}' href='#{route}#{currentpage+2}'>#{currentpage+2}</a>"
      pages += "<a class='#{@aclass}' href='#{route}#{currentpage+3}'>#{currentpage+3}</a>"
      pages += "<a class='#{@aclass}' href='#{route}#{currentpage+4}'>#{currentpage+4}</a>"
      pages += shenglvhao
      pages += "<a class='#{@aclass}' href='#{route}#{pagecount}'>#{pagecount}</a>"
    elsif currentpage>=7 && currentpage>pagecount-7
      pages = "<a class='#{@aclass}' href='1'>1</a>"
      pages += shenglvhao
      for i in 1..9
        fpage = pagecount-9+i
        if currentpage == fpage
          pages += "<span class='#{@dqyclass}'>#{currentpage}</span>"
        else
          pages += "<a class='#{@aclass}' href='#{route}#{fpage}'>#{fpage}</a>"
        end
      end
    elsif currentpage>0 && pagecount<=10
      for i in 1..10
        if currentpage==i
          pages += "<span class='#{@dqyclass}'>#{currentpage}</span>"
        else
          pages += "<a class='#{@aclass}' href='#{route}#{i}'>#{i}</a>"
        end
      end
    end
    syiye + pages +xyiye
  end
end