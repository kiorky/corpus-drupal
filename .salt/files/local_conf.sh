#!/usr/bin/env bash
# MANAGED VIA SALT !
# {% set cfg = salt['mc_project.get_configuration'](cfg) %}
# {% set data = cfg.data %}
# {% set force = data.get('force', {}) %}
# . "$(dirname ${0})/get-base.sh"

# Copy this file in the same directory
# and rename it to profile_conf.sh
# Enter property to used during drupal install

ROOTPATH="{{cfg.project_root}}"
BINPATH="{{cfg.project_root}}/sbin"
WWW_DIR="{{cfg.project_root}}/www"
DATA_DIR="{{cfg.data_root}}/var/sites"
PROJECT_CONFIG_PATH="${ROOTPATH}/sbin/templates"

# values are 8 or anything else for previous versions
DRUPAL_VERSION="{{cfg.data.drupal_version}}"
DRUSH_SPEC="{{cfg.data.drush_spec}}"
# Only for D8: first site or synchronised from an already first installed D8? -- for the UUID problems --
# values are: "new_website"|"sync"
D8_INSTALL_MODE="{{cfg.data.d8_install_mode}}"

# System User
USER="{{cfg.user}}"
GROUP="{{cfg.group}}"

#user right bash script path
#It should be absolute
# 1st arg is the file editor user,
# 2nd argument is the web server/php-fpm group (which may need some write rights on specific places)
# 3rd argument CAN be DEV or empty
USER_RIGHTS="{{cfg.project_dir}}/global-reset-perms.sh"

# Whether we are in dev mode or not...
# {% set devmode = cfg.default_env in ['dev'] and '1' or '' %}
DEV_MODE="${DEV_MODE:-{{devmode}}}"

# profile and INSTALL related ----------------
# Locale to set
LOCALE="{{data.drupal_locale}}"
# Used for admin account mail and site mail
MAIL="{{data.local_settings.account_email}}"
NAME="{{data.local_settings.account_name}}"
PASS="{{data.local_settings.site_password}}"
# Database info
# warning 'localhost' means socket, unavailable in chroot
DB_HOST="{{data.db_host}}"
DB_NAME="{{data.db_name}}"
DB_PORT="{{data.db_port}}"
DB_USER="{{data.db_user}}"
DB_PASS="{{data.db_password}}"
DB_TYPE="mysql"
SITE_DEFAULT_COUNTRY="{{data.country}}"
DATE_DEFAULT_TIMEZONE="{{data.tz}}"
UPDATE_STATUS_MODULE="{{data.update_status_module}}"
SITE_NAME="{{data.local_settings.site_name}}"
SITE_MAIL="{{data.local_settings.site_email}}"

#
# drush make related
#
# Profile to use
PROJECT_NAME="{{data.drupal_profile}}"
DRUPAL_URI="{{data.drupal_uri}}"
DRUSH_EXTRA_ARGS="--uri="${DRUPAL_URI}""
FORCE_MAKE_MARKER="{{cfg.data_root}}/force_make"
# {% if force.get('make') %}
FORCE_MAKE="y"
# {% else %}
FORCE_MAKE=""
# {% endif%}
MODULES_CHECK="{{data.modules_check}}"

#
# drush install related
#
FORCE_INSTALL_MARKER="{{cfg.data_root}}/force_install"
# {% if force.get('install') %}
FORCE_INSTALL="y"
# {% else %}
FORCE_INSTALL=""
# {% endif%}
INSTALL_MARKER="{{cfg.data_root}}/installed"

unset -v TARGETS
declare -A TARGETS
TARGETS["root@localhost"]="{{cfg.data_root}}/testsync"
# vim:set et sts=4 ts=4 tw=80:
