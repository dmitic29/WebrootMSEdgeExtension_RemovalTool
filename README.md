# WebrootMSEdgeExtension_RemovalTool
Removes persistent Webroot Edge extension

When you administratively deploy Webroot from a cloud controller, it also installs the Webroot extension in your MS Edge. You can't remove this extension through the MS Edge Extensions management interface and if you just delete the Webroot folder from "C:\Users\%username%\AppData\Local\Microsoft\Edge\User Data\Default\Extensions" it will simply reinstall itself the next time you restart Edge.
As a side note, if you just need a script to remove the Webroot application (not the Edge extension) from your computer, @redlettertech has one and you can find it here:
https://gist.github.com/redlettertech/bd970ac04d38be4864af8d8cdf39f1d8
