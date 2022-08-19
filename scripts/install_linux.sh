#!/bin/bash
# Script to install program files on linux systems

SYSUNITDIR=${DESTDIR}/etc/systemd/system
RSYSLOGDIR=${DESTDIR}/etc/rsyslog.d
LOGROTATEDIR=${DESTDIR}/etc/logrotate.d

# Create service file
mkdir -p ${SYSUNITDIR}
cat ${TEMPLATE_DIR}/sysunit.service \
    | sed "s~{{ PROGRAM_NAME }}~${PROGRAM_NAME}~" \
    | sed "s~{{ DESCRIPTION }}~${DESCRIPTION}~" \
    | sed "s~{{ PROGRAM }}~${BINDIR}/${PROGRAM_NAME}~" \
    > ${SYSUNITDIR}/${PROGRAM_NAME}.service

# Create systemd config file
mkdir -p ${DESTDIR}${ETCDIR}
cat ${TEMPLATE_DIR}/config \
    | sed "s~{{ PROGRAM_NAME }}~${PROGRAM_NAME}~" \
    > ${DESTDIR}${ETCDIR}/env

# Create rsyslog file
mkdir -p ${RSYSLOGDIR}
cat ${TEMPLATE_DIR}/rsyslog.conf \
    | sed "s~{{ PROGRAM }}~${PROGRAM_NAME}~" \
    | sed "s~{{ LOG_FILE }}~${LOGFILE}~" \
    > ${RSYSLOGDIR}/49-${PROGRAM_NAME}.conf

# Create logrotate file
mkdir -p ${LOGROTATEDIR}
cat ${TEMPLATE_DIR}/logrotate.conf \
    | sed "s~{{ LOG_FILE }}~${LOGFILE}~" \
    > ${LOGROTATEDIR}/${PROGRAM_NAME}.conf
chmod 644 ${LOGROTATEDIR}/${PROGRAM_NAME}.conf

# Copy program
mkdir -p ${DESTDIR}/${BINDIR}
cp ${BUILD_DIR}/${PROGRAM_NAME} ${DESTDIR}${BINDIR}/${PROGRAM_NAME}

# Copy files.
mkdir -p ${DESTDIR}${SHAREDIR}
cp ${BASE_DIR}/../README.md ${DESTDIR}${SHAREDIR}
