# Contained Scripts

## CreateZip.js

Compresses the folder assets and the files elm.js and index.html into a zip.

```
node script/createZip.js <OutputPath>
```

* OutputPath - The path to the resulting zip.
    Default: Game.zip

Example:

```
# Zip the content and save it as Output.zip
node scripts/createZip.js Output.zip
```