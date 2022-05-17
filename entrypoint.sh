#!/usr/bin/env sh
# Container entrypoint script to start an SSH mock
#
# Pass the name of the user as env variable 'USERNAME'
# Pass the full path of the directory where to store uploaded files as env variable 'STORAGE_DIR'

set -eu

echo "--> Changing root password"
echo "root:changeme" | chpasswd

echo "--> Configuring key authentication"
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

echo "--> Creating user: ${USERNAME}"
adduser -D -s /bin/ash ${USERNAME} && \
  passwd -u ${USERNAME} && \
  chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

echo "--> Configurating permissions for user: ${USERNAME}"
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh
chmod g-w /home/${USERNAME} && \
    chmod 700 /home/${USERNAME}/.ssh && \
    chmod 600 /home/${USERNAME}/.ssh/authorized_keys

mkdir -p ${STORAGE_DIR} && chown -R ${USERNAME}:${USERNAME} ${STORAGE_DIR}

echo "--> Accepting the following keys for user: ${USERNAME}"
cat /home/${USERNAME}/.ssh/authorized_keys

# generate host keys if not present
echo "--> Generating host keys"
ssh-keygen -A

# do not detach (-D), log to stderr (-e), passthrough other arguments
echo "--> Starting sshd"
exec /usr/sbin/sshd -D -e "$@"
