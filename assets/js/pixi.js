

export const pixiApp = new PIXI.Application();

/**
 * Initiate the PixiApplication
 * @param {string} parent 
 */
export function init(parent) {
    const parentNode = document.getElementById(parent)
    parentNode.appendChild(pixiApp.view);
    pixiApp.resizeTo(parentNode);
}

/**
 * Resize the Pixi Application to the size of the parant node
 */
export function resize() {
    pixiApp.resize()
}

/**
 * Starts the Pixi Application again (if it's stopped)
 */
export function start() {
    pixiApp.start()
}

/**
 * Stop the Pixi Application
 */
export function stop() {
    pixiApp.stop()
}

/**
 * Render the current stage
 */
export function render() {
    pixiApp.render()
}