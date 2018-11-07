#!/bin/bash

export SPLUNK_HOME=/opt/splunk
export SPLUNK_LOGIN="admin:admin123"

function reload_endpoint() {
    echo -n "GET /services/$1/_reload -> "
    $SPLUNK_HOME/bin/splunk _internal call /services/$1/_reload -auth $SPLUNK_LOGIN | grep HTTP

}

function reload_ss() {
    echo "Reloading Splunk static"
    $SPLUNK_HOME/bin/splunk restartss
}
function reload_macros() {
    reload_endpoint admin/macros
}

function reload_alerts() {
    reload_endpoint admin/modalerts
    reload_endpoint admin/alert_actions
}


function reload_views() {
    reload_endpoint data/ui/views
    reload_panels
    reload_nav
}

function reload_panels() {
    reload_endpoint data/ui/panels
}

function reload_nav() {
    reload_endpoint data/ui/nav
}

function reload_apps() {
    reload_endpoint admin/localapps
}

function reload_saved() {
    reload_endpoint admin/savedsearch
}

function reload_splunkweb() {
    echo "Restarting splunkweb"
    $SPLUNK_HOME/bin/splunk restart splunkweb -auth $SPLUNK_LOGIN
}

function reload_rest() {
    echo "Killing persistent appserver process..."
    ps -ef | grep appserver.py | grep -v grep | awk '{print $2}' | xargs kill
}

function reload_all() {
    reload_endpoint admin/modalerts				#OK
    reload_endpoint admin/conf-times            # OK
    reload_endpoint data/ui/manager             # OK
    reload_endpoint data/ui/nav                 # OK
    reload_endpoint data/ui/views               # OK
    reload_endpoint admin/alert_actions         # OK
    reload_endpoint admin/clusterconfig         # OK
    reload_endpoint admin/collections-conf      #    BadRequest
    reload_endpoint admin/commandsconf          # OK
    reload_endpoint admin/conf-deploymentclient # OK
    reload_endpoint admin/conf-inputs           # OK
    reload_endpoint admin/conf-times            # OK
    reload_endpoint admin/conf-wmi              # OK
    reload_endpoint admin/cooked                # OK
    reload_endpoint admin/datamodel-files       # OK
    reload_endpoint admin/datamodelacceleration # OK
    reload_endpoint admin/datamodeledit         # OK
    reload_endpoint admin/deploymentserver      # OK
    reload_endpoint admin/eventtypes            # OK
    reload_endpoint admin/fields                # OK
    reload_endpoint admin/fifo                  # OK
    reload_endpoint admin/fvtags                # OK
    reload_endpoint admin/indexes               # OK
    reload_endpoint admin/localapps             # OK
    reload_endpoint admin/lookup-table-files    # OK
    reload_endpoint admin/macros                # OK
    reload_endpoint admin/manager               # OK
    reload_endpoint admin/monitor               # OK
    reload_endpoint admin/nav                   # OK
    reload_endpoint admin/oidemo_modinput       # OK
}
