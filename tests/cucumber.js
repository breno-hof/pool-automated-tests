// cucumber.js
const common = [
	"features/**/*.feature",             	// Load feature files
	"--require-module ts-node/register",  	// Enable TypeScript support
	"--require step-definitions/**/*.ts", 	// Load step definitions
	"--format progress" // Use cucumber-pretty for output
].join(" ");

module.exports = {
	default: common
};