#!/bin/bash
sudo dnf remove $(dnf repoquery --installonly --latest-limit=-1 -q)
