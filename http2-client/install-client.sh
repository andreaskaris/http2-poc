#!/bin/bash

cp /cert /etc/pki/ca-trust/source/anchors/
update-ca-trust extract
