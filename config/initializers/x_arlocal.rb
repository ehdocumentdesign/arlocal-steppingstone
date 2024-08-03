# There should be no need to modify this file.
# Please use rails credentials:edit to store rsync and mail server information.

Rails.application.configure do

  config.x.arlocal = {}

  config.x.arlocal.merge! ({
    app_copyright_year: 2023,
    app_logo_file_path: 'arlocal/arlocal-logo.png',
    app_logo_icon_file_path: 'arlocal/arlocal-logo-icon.png',
    app_nilpicture_file_path: 'arlocal/arlocal-nilpicture.png',
    source_imported_filesystem_dirname: File.join(Rails.root, '/public/portfolio'),
    source_imported_url_path_prefix: '/portfolio'
  })

  config.action_controller.forgery_protection_origin_check = true
  config.action_controller.per_form_csrf_tokens = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  config.active_storage.service = :local

  if Rails.application.credentials.mailer_smtp
    config.action_mailer.smtp_settings = {
      address:              Rails.application.credentials.mailer_smtp[:address],
      authentication:       Rails.application.credentials.mailer_smtp[:authentication],
      domain:               Rails.application.credentials.mailer_smtp[:domain],
      enable_starttls_auto: Rails.application.credentials.mailer_smtp[:enable_starttls_auto],
      password:             Rails.application.credentials.mailer_smtp[:password],
      port:                 Rails.application.credentials.mailer_smtp[:port],
      ssl:                  Rails.application.credentials.mailer_smtp[:ssl],
      user_name:            Rails.application.credentials.mailer_smtp[:user_name]
    }
  end

end
