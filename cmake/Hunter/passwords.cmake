hunter_upload_password(
        # REPO_OWNER + REPO = https://github.com/undefinedev/hunter-cache
        REPO_OWNER "undefinedev"
        REPO "hunter-cache"

        # USERNAME = https://github.com/defineddev
        USERNAME "defineddev"

        # PASSWORD = GitHub token saved as a secure environment variable
        PASSWORD "$ENV{GITHUB_USER_PASSWORD}"
)