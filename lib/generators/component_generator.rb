class ComponentGenerator < Rails::Generators::Base
  argument :component_name, required: true, desc: 'Component name, e.g: button or session/login_form'

  def create_view_file
    create_file "#{component_path}/_#{component_filename}.html.erb"
  end

  def create_css_file
    create_file "#{component_path}/index.css"
  end

  def create_js_file
    create_file "#{component_path}/index.js"
  end

  protected

    def component_path
      "frontend/components/#{component_name}"
    end

    def component_filename
      component_name.split('/').pop
    end
end
