#!/bin/bash

############################
#  Exported variables.     #
############################

export BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Info
set -o allexport
source ${BASE_DIR}/info
set +o allexport

# Directories.
export PACKAGE_BINDIR=${PACKAGE_PREFIX}/bin
export PACKAGE_ETCDIR=etc/${PACKAGE_NAME}
export PACKAGE_SYSUNITDIR=etc/systemd/system
export PACKAGE_RSYSLOGDIR=etc/rsyslog.d
export PACKAGE_LOGROTATEDIR=etc/logrotate.d
export PACKAGE_LOGDIR=/var/log
export PACKAGE_LOGFILE=${PACKAGE_LOGDIR}/${PACKAGE_NAME}.log
export PACKAGE_SHAREDIR=${PACKAGE_PREFIX}/share/${PACKAGE_NAME}
export PACKAGE_TMPDIR="pack"

if [ $# -lt 1 ]; then
	echo "$0 <pkg_type>"
	exit 1
fi

PKG_TYPE=$1
PKG_SCRIPT="${BASE_DIR}/build_${PKG_TYPE}.sh"

# Check and call script
if [ ! -x $PKG_SCRIPT ]; then
	echo "$PKG_SCRIPT not found"
	exit 1
fi

$PKG_SCRIPT