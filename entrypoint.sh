#!/bin/bash
# If any commands fail (exit code other than 0) entire script exits
set -e

# See if our project has a gulpfile either in the root directory if it's a theme
# or in the assets/ folder if it is a plugin

package_path="./package.json"
bower_file_path="./bower.json"

webpack_path="./Build/config.base.js"
webpack_path_lower="./build/config.base.js"

# Begin from the ~/clone directory
# this directory is the default your git project is checked out into by Codeship.
cd ${working_directory:-./}

# if [ -f "$webpack_path" ]
# then
# 	build_type=webpack
# fi

# if [ -f "$webpack_path_legacy" ]
# then	
# 	build_type=webpack
# fi

# if [ -f "$webpack_path_other_legacy" ]
# then
# 	build_type=webpack
# fi

# if [ -f "$webpack_path_lower" ]
# then
# 	build_type=webpack
# fi

build_type=webpack

# check to see our build type and if so build using either gulp or grunt
if [ "$build_type" != "none" ]
then
		if [ "$build_type" == "webpack" ]
		then
			echo "Webpack File Found. Starting Yarn Install"
			yarn install
			echo "Compiling"
			yarn deploy
		else
	    echo "Initiating Yarn Install"
	    yarn install
	fi
fi

composer install

cd ..
