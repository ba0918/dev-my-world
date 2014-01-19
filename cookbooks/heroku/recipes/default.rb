bash "install heroku toolbelt" do
    code <<-EOC
        wget --no-check-certificate https://toolbelt.heroku.com/install.sh | sh
    EOC
    not_if "which heroku"
end
