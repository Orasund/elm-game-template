export class Sound {
    pool = new Map();
    ctx = new AudioContext();
    amountLoaded = 0;

    constructor() {
        Object.values(SoundSource).map((source) => this.register(source))
    }

    /**
     * Register all provided sounds 
     * @param {string[]} paths to the audio files
     */
    registerAll(paths) {
        paths.map(this.register)

        return this;
    }

    /**
     * Register a single audio file
     * @param {string} path to the audio file
     * @returns {Sound} itself
     */
    register(path) {
        const audio = new Audio();
        this.ctx.createMediaElementSource(audio)
            .connect(this.ctx.destination);
        audio.src = "assets/sounds/" + path + ".mp3";
        audio.oncanplay = () => this.amountLoaded++
        this.pool.set(path, audio);

        return this;
    }

    /**
     * Play an aduio file
     * @param {string} path 
     * @param {bool} playEndlessly 
     */
    play(path, playEndlessly) {
        const audio = this.pool.get(path)
        if (audio === undefined)
            console.log(path + " not found. Please register it before playing.")

        audio.onended = playEndlessly
            ? () => {
                audio.load;
                audio.play();

            }
            : () => { }

        if (this.ctx.state === "suspended")
            this.ctx.resume();
        else {
            audio.load();
            audio.play();
        }

    }
}