module Language
    extend ActiveSupport::Concern

    included do 
        around_action :switch_locale
        private
        
        
        def switch_locale(&action)
            I18n.with_locale(locale_from_header, &action)
          end

        def locale_from_header
            accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
            if accept_language
              accept_language.scan(/^[a-z]{2}/).first
            else
              # Define un valor predeterminado o manejo para el caso en que no haya encabezado HTTP_ACCEPT_LANGUAGE.
              # Por ejemplo, podrías usar el idioma por defecto de la aplicación.
              I18n.default_locale
            end
        end

    end
end