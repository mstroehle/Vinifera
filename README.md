
# Vinifera

Vinifera is an open source re-implementation of Command & Conquer Tiberian Sun: Firestorm. Firestorm is the expansion pack of Command & Conquer Tiberian Sun, released in 2000.

This project is a bottom-up rewrite of Tiberian Sun: Firestorm, using the original binary to provide functions that have not been implemented yet. The intention is to allow the fixing of bugs, implementation of new features and porting to platforms unsupported by the original.

## Chat

You can chat and discuss the development of Vinifera in The Assembly Armarda's [Discord server](https://discord.gg/UnWK2Tw) in the #vinifera channel.

## Running Vinifera
Currently Vinfera can only be run on Windows.

To run Vinifera, you first need to have Command & Conquer Tiberian Sun: Firestorm installed. If you don't have the original game disc(s), Tiberian Sun: Firestorm can currently be bought most easily as a downloadable version that is part of the Command & Conquer The Ultimate Collection from [Origin](https://www.origin.com/en-us/store/command-and-conquer/command-and-conquer-the-ultimate-collection/ultimate-collection) or a third-party like [Amazon](https://www.amazon.com/Command-Conquer-Ultimate-Collection-PC/dp/B0095C0I4W).

If you wish to use our custom launcher without messing with patches or anything, only an install original Windows disc based English language version of Tiberian Sun: Firestorm (patched to version 2.03) is supported. That 2.03 patch can be downloaded [here](https://cnc-comm.com/tiberian-sun/downloads/patches/2.03) if your installation hasn't been updated yet.

## Anti-virus Warning
Anti-virus software like Windows Defender could mark Vinifera as a virus. This is a false-positive. We can assure you that Vinifera is fully safe to use. If you are still unsure about this, you can just [build Vinifera](#building-vinifera).

## Building Vinifera
In order to generate a working binary, currently you must build the project using a version of the Microsoft Visual Studio compiler (2017 and above). Building with Clang against a Windows SDK is in theory possible but is untested for a cross compile solution.

It is also possible to build a standalone binary if you want to test compiling on other platforms.

## Linux and macOS
Native support for Linux and macOS is planned for the future, but because of how the project is developed, a fully playable native binary will not be possible for some time. In the mean time, using Wine on Linux and macOS, should be possible but is currently untested.

If you are interested in developing the cross platform aspect of the project it is now possible to build the project standalone by passing ```-DVINIFERA_STANDALONE=TRUE``` to CMake when configuring the project
but the resulting binary currently has very limited functionality.

## Contributing
If you are interested in contributing to Vinifera, you will need some knowledge of C++ as a minimum requirement. Join the developer chat listed above for more information on what else you will need, such as the idc file for the current map of the binary.

## Licence
The source code provided in this repository for Vinifera is licenced under the [GNU General Public License version 2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html) or later with an exception allowing the resulting code to be linked against a closed source binary which will be in place until Vinifera no longer relies on the original binary.

## Other Open-Game Projects
Below is a list of similar projects and their respective original games:

 * [Chronoshift](https://github.com/TheAssemblyArmada/Chronoshift) - C&C Red Alert
 * [Thyme](https://github.com/TheAssemblyArmada/Thyme) - C&C Generals: Zero Hour
 * [OpenRCT2](https://github.com/OpenRCT2/OpenRCT2) - RollerCoaster Tycoon 2
 * [OpenTTD](https://www.openttd.org/) - Transport Tycoon Deluxe
 * [OpenMC2](https://github.com/LRFLEW/OpenMC2) - Midnight Club 2
 * [OpenDUNE](https://github.com/OpenDUNE/OpenDUNE) - Dune 2
 * [OpenFodder](https://github.com/OpenFodder/openfodder) - Cannon Fodder
 * [Devilution](https://github.com/diasurgical/devilution) - Diablo

There is also the [Wikipedia page for open source games](https://en.wikipedia.org/wiki/List_of_open-source_video_games).
