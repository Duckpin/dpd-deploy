#!/bin/bash
# If any commands fail (exit code other than 0) entire script exits
set -e

# See if our project has a gulpfile either in the root directory if it's a theme
# or in the assets/ folder if it is a plugin

composer_path="./composer.json"
package_path="./package.json"
build_file_path="./gulpfile.js"
bower_file_path="./bower.json"

webpack_path="./Build/base.config.js"
webpack_path_legacy="./build/config/base.config.js"

# Begin from the ~/clone directory
# this directory is the default your git project is checked out into by Codeship.
cd clone

if [ -f "$build_file_path" ]
then
	echo "Gulpfile found. Starting build process"
	build_type=gulp
fi

if [ -f "$webpack_path" ]
then
	build_type=webpack
fi

if [ -f "$webpack_path_legacy" ]
then
	build_type=webpack
fi

# check to see our build type and if so build using either gulp or grunt
if [ "$build_type" != "none" ]
then
		if [ "$build_type" == "webpack" ]
		then
			echo "Webpack File Found. Starting Yarn Install"
			yarn install
			echo "Deploy Webpack"
			yarn deploy
		else
	    echo "Initiating NPM Install"
	    npm install

	    # Only install and fire bower if we have a bower.json
	    if [ -f "$bower_file_path" ]
	    then
				echo "Initiating Bower Install"

				npm install -g bower
				bower install
	    fi

	    if [ "$build_type" = "gulp" ]
	    then
		    			if grep -q build:production "$build_file_path";
									then
									echo "Building project using gulp"
									gulp build:production
		    			fi
	    else
	    	    # Make sure we have a build command within our grunt file
		    		if grep -q build "$build_file_path";
							then
							echo "Building project using grunt"
							grunt build
		    		fi
	    fi
	fi
fi

cd ..
