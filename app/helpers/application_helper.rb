module ApplicationHelper

  def page_url
    request.original_url
  end

  def encoded_page_url
    URI.encode page_url
  end

  def component(component_name, *args, &block)
    locals = args.extract_options!
    render("/components/#{component_name}/#{component_name.split('/').last}.html.erb", locals, &block)
  end
  alias c component

end
