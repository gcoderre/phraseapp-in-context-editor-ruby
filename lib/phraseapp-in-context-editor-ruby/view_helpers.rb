module PhraseApp
  module InContextEditor
    module ViewHelpers
      def phraseapp_in_context_editor_js
        return "" unless PhraseApp::InContextEditor.enabled?

        js_config = ["projectId: '#{PhraseApp::InContextEditor.project_id}'"]
        if PhraseApp::InContextEditor.api_host.present? && PhraseApp::InContextEditor.api_host != "https://api.phraseapp.com"
          js_config << "apiBaseUrl: '#{PhraseApp::InContextEditor.api_host}/api/v2'"
        end

        js = <<-eos
                <script>
                  window.PHRASEAPP_CONFIG = {
                        #{js_config.join(', ')}
                      };
                  (function() {
                    var phraseapp = document.createElement('script'); phraseapp.type = 'text/javascript'; phraseapp.async = true;
                    phraseapp.src = ['#{PhraseApp::InContextEditor.js_use_ssl ? 'https' : 'http'}://', '#{PhraseApp::InContextEditor.js_host}/assets/in-context-editor/2.0/app.js?', new Date().getTime()].join('');
                    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(phraseapp, s);
                  })();
                </script>
             eos
        js.respond_to?(:html_safe) ? js.html_safe : js
      end
    end
  end
end
