# Project Utility for Clarion Build Automation

## Overview
This utility is specially designed for integration into the build process of a Clarion project. It showcases how to create a tool that can be used in pre/post-build batch files, providing output directly to the build console.

## Features
- **Clarion Build Integration**: Tailored to fit into Clarion build processes, enhancing automation with a utility that functions seamlessly in such environments.
- **Console Application**: Executes as a console application, ideal for batch operations during builds.

## Dependency
This project depends on a class developed by Brahn Partridge. You can find the original class at:
- [Brahn Partridge's ClarionClasses](https://github.com/fushnisoft/ClarionClasses)

## Modifications
Modifications have been made to Brahn's original class to suppress input features from the `init` method, adapting it for use where build outputs do not support interactive inputs.

## Setup
To configure this utility as a console application in a Clarion build environment, you must create an PROJECT.EXP file as follows:
```plaintext
NAME 'FIXSQLVERSION' CUI
