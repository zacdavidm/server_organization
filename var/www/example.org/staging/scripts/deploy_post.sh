#!/bin/bash
# Post Automatic Deploy of Master

# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# place files
source place_files.sh

cd $DIR
# place settings
source place_settings.sh

# run bash updates
