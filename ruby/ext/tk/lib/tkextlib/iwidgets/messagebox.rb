#
#  tkextlib/iwidgets/messagebox.rb
#                               by Hidetoshi NAGAI (nagai@ai.kyutech.ac.jp)
#

require 'tk'
require 'tkextlib/iwidgets.rb'

module Tk
  module Iwidgets
    class Messagebox < Tk::Iwidgets::Scrolledwidget
    end
  end
end

class Tk::Iwidgets::Messagebox
  TkCommandNames = ['::iwidgets::messagebox'.freeze].freeze
  WidgetClassName = 'Messagebox'.freeze
  WidgetClassNames[WidgetClassName] = self

  ####################################

  include TkItemConfigMethod

  def __item_cget_cmd(id)
    [self.path, 'type', 'cget', id]
  end
  private :__item_cget_cmd

  def __item_config_cmd(id)
    [self.path, 'type', 'configure', id]
  end
  private :__item_config_cmd

  def tagid(tagOrId)
    if tagOrId.kind_of?(Tk::Itk::Component)
      tagOrId.name
    else
      #_get_eval_string(tagOrId)
      tagOrId
    end
  end

  alias typecget itemcget
  alias typeconfigure itemconfigure
  alias typeconfiginfo itemconfiginfo
  alias current_typeconfiginfo current_itemconfiginfo

  private :itemcget, :itemconfigure
  private :itemconfiginfo, :current_itemconfiginfo

  ####################################

  def type_add(tag=nil, keys={})
    if tag.kind_of?(Hash)
      keys = tag
      tag = nil
    end
    unless tag
      tag = Tk::Itk::Component.new(self)
    end
    tk_call(@path, 'type', 'add', tagid(tag), *hash_kv(keys))
    tag
  end

  def clear
    tk_call(@path, 'clear')
    self
  end

  def export(file)
    tk_call(@path, 'export', file)
    self
  end

  def issue(string, type=None, *args)
    tk_call(@path, 'issue', string, tagid(type), *args)
    self
  end

end
