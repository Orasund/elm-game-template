

/**
 * Register all provided sounds 
 * @param {string[]} paths to the audio files
 */
export function registerAllSounds(paths) {
    paths.forEach(path => {
        PIXI.sound.add(path,
            {
                url: "assets/sounds/" + path,
                preload: true,
                loaded: (err) => {
                    if (err === null)
                        console.log("Loading " + path + " successfully")
                    else
                        console.log("Loading " + path + ":" + err)
                }
            })
    }
    )
}

/**
 * Play an aduio file
 * @param {string} path 
 * @param {bool} playEndlessly 
 * @param {() => void} onended
 */
export function playSound(path, playEndlessly, onended) {
    let s = PIXI.sound.play(path)
    if (isIMediaInstance(s)) {
        s.loop = playEndlessly;
        s.on("end", onended);
    }
    else console.log(path + " is not yet loaded")
}

function isIMediaInstance(object) {
    return 'id' in object;
}

export function stopSound(path) {
    PIXI.sound.stop(path)
}
