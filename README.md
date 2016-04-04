# Helper Scripts

When developing locally on an active project using a version control system, it's likely that the main uploads folder is not bundled within your repository, meaning that content managed uploads will not load locally. These scripts allow you to quickly generate a local `.htaccess` file in your configured uploads directory and will redirect all requests to the remote server instead.

This repository is intended to host a collection of other scripts to carry out common and repetitive development tasks in the future. It is a work in progress.

*Disclaimer: These scripts and commands were originally created for use internally within our development team to speed up common, repetitive tasks. However, they may be of some use to others. Feel free to use in your own projects, your mileage may vary.*

## Requirements

* Composer
* PHP >= 5.3.0
* A local development environment, such as Vagrant.

## Notes

* These scripts require a .env config file in the project root. If you're using WordPress, you can use [scottjs/wp-dotenv](https://github.com/scottjs/wp-dotenv) to allow WordPress to share the same .env file and avoid maintaining two config files.
* This script was designed with WordPress in mind, however it should work with other projects, such as Laravel 5.

## Installation

Add `"scottjs/helper-scripts": "0.*"` to your `composer.json` file:

```
"require-dev": {
	"scottjs/helper-scripts": "0.*"
},
```

Then add the following scripts to your `composer.json` file:

```
"scripts": {
	"remote-uploads-enable" : [
		"vendor/scottjs/helper-scripts/remote-uploads.sh enable"
	],
	"remote-uploads-disable" : [
		"vendor/scottjs/helper-scripts/remote-uploads.sh disable"
	]
}
```

Run the `composer update` command from the root of your project. 

Create a `.env` file in the root of your project and add/update the following configuration options:

```
DOMAIN_REMOTE=www.example.com
APP_DOCROOT=/public
APP_UPLOADS=/wp-content/uploads
```

## Usage

From the root of your project, you will be able to run the following composer commands:

* ***composer remote-uploads-enable*** - This command will generate a local .htaccess file in your configured uploads directory and will redirect all requests to the remote server instead. This requires `DOMAIN_REMOTE`, `APP_DOCROOT` and `APP_UPLOADS` to be set in the .env file. It's recommended to ignore this .htaccess file from your project repository if your uploads directory is not already ignored.

* ***composer remote-uploads-disable*** - A convenient helper command to remove the .htaccess file created by the command above just in case you find it causes issues or is no longer needed.

## Configuration Options

See below for an explanation of each configuration option used within the .env file.

* ***DOMAIN_REMOTE*** - It should point to your remote or production environment (if available) and not include http:// or trailing slashes. Example: `www.example.com` or `subdomain.example.com`.

* ***APP_DOCROOT*** - It should be relative to your project root folder and point to where the document root is configured. It should start with a slash and not include a trailing slash. Leave blank if not applicable. Example: `/public`.

* ***APP_UPLOADS*** - It should point to the URL where remote uploads are located relative to `DOMAIN_REMOTE`. It should start with a slash and not include a trailing slash. Example: `/wo-content/uploads`.
