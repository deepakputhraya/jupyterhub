import os

c = get_config()

# Allow CORS
c.NotebookApp.allow_origin = '*'

# Allows multiple single-server per user
c.JupyterHub.allow_named_servers = True

# Use Google OAuthenticator for local users
c.JupyterHub.authenticator_class = 'oauthenticator.LocalGoogleOAuthenticator'
c.LocalGoogleOAuthenticator.oauth_callback_url = os.environ['GOOGLE_CALLBACK_URL']
c.LocalGoogleOAuthenticator.client_id = os.environ['GOOGLE_CLIENT_ID']
c.LocalGoogleOAuthenticator.client_secret = os.environ['GOOGLE_CLIENT_SECRET']

c.LocalGoogleOAuthenticator.hosted_domain = [os.environ['GOOGLE_HOSTED_DOMAIN']]
c.LocalGoogleOAuthenticator.login_service = os.environ['SERVICE_NAME']
c.Authenticator.add_user_cmd = ['adduser', '-q', '--gecos', '""', '--disabled-password', '--force-badname']

# create system users that don't exist yet
c.LocalAuthenticator.create_system_users = True

# Shutdown idle notebooks after 1.5h of inactivity
c.MappingKernelManager.cull_idle_timeout = 5400
c.NotebookApp.shutdown_no_activity_timeout = 5400

# Use jupyterlab by default
c.Spawner.default_url = '/lab'

# Use Postgresql database
c.JupyterHub.db_url = 'postgresql://{}:{}@{}:5432/{}'.format(
    os.environ['POSTGRES_USERNAME'], os.environ['POSTGRES_PASSWORD'], os.environ['POSTGRES_HOST'], os.environ['POSTGRES_DATABASE']
)

