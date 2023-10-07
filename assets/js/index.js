/// <reference path="../../elm.d.ts" />

import { registerAllSounds, playSound } from "./sound.js";

var app = Elm.Main.init({ node: document.querySelector('main') })
// you can use ports and stuff here

app.ports.interopFromElm.subscribe(fromElm => {
    switch (fromElm.tag) {
        case "registerSounds":
            return registerAllSounds(fromElm.data);
        case "playSound":
            console.log("button clicked");
            return playSound(fromElm.data.sound, fromElm.data.looping);
    };

})