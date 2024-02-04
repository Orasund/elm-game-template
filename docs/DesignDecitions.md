# Design Decitions

## JS/TS Building Tool

### (DO) Elm-live

Elm-Live was a really good initial start. It supports JS and hot reloading. However it does not support TS and Bundling.

After trying Parcel I went back to Elm-live and copied the needed files into the js folder. It works perfectly. Much less overhead and a way faster build time during hot-reloading.

However this does with two major downsides:

1. Packages have to be updated by hand. This means coping the files old-school style into the folder. As this should not happend that often, i assume this is ok. (Alternatively one also could write a small script that copies the files directly from the modules folder)
2. Still no TS support. You can add types by adding a *.d.ts file to root (like the elm.d.ts file). While this seems like a downside, I actually found the JSDocs supports from VSCode much nicer. JSDocs will increase the file size of your js files, but that might be just the perfect tradeoff or this project.


### (DON'T) Parcel

Using parcel was initically quite promising, as it comes with TS out of the box and supports Elm.

However it actually introduced a bit of overhead (copying the assets folder into dist, slower build time during hot-reloading).

The finishing blow was that the resulting game could not run on itch.io (the path to the index.js file was `/index.js` while it should have been `index.js`). I could have spent more time finding a solution. However I decided against it, as I was already thinking of finding a better building tool.