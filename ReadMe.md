# Matt PowerShell Prompt

This repository contains a custom PowerShell prompt script designed to ✨enhance✨ your terminal experience, especially when working in Visual Studio Code (VSCode or VSCode Insiders).

## Features

- **Dynamic Prompt**: Displays the current working directory, virtual environment (if active), and Git branch information.
- **Git Status**: Shows a checkmark (✓) for a clean Git status or a cross (✗) for uncommitted changes.
- **VSCode Detection**: Automatically adjusts the prompt for VSCode environments.

### **Prompt with Virtual Environment**:

<img src="images/venv.webp" width=75% height=75%>

### **Prompt in a Git Repository (when .venv does not exist)**:

<img src="images/venv-git.webp" width=75% height=75%>
<img src="images/no-venv.webp" width=60% height=60%>

### **Default Prompt (Inside VSCode)**:
   
<img src="images/raw.webp" width=75% height=75%>

### **Default Prompt 🦗 (Outside of VSCode Projects)**:
   
<img src="images/ps.webp" width=60% height=60%>

## Installation

1. Clone this repository or copy the `Microsoft.PowerShell_profile.ps1` script.
2. Place the script in your PowerShell profile directory. The default path is:
   ```plaintext
   $USER/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
   ```
3. If the `$PROFILE` file does not exist, you can create it by running:
   ```powershell
   New-Item -ItemType File -Path $PROFILE -Force
   ```
4. Copy the contents of the script into the newly created `$PROFILE` file.
5. Restart your PowerShell terminal to apply the changes.

## Usage

- Open your PowerShell terminal.
- Navigate to a directory to see the enhanced prompt in action.
- If you're in a Git repository, the prompt will display the current branch and status.
- Activate a virtual environment to see its name reflected in the prompt.

## Learn More
I don't take all of the credit for this script. I was inspired by the [Oh-My-Zsh Project](https://github.com/ohmyzsh/ohmyzsh) particularly the [robbyrussel theme](https://github.com/ohmyzsh/wiki/blob/main/Themes.md). I learned a lot of converting most of the style to `💻PS >_` by visiting the [PowerShell documentation](https://learn.microsoft.com/en-us/windows/terminal/tutorials/custom-prompt-setup). 🙂

And no, I didn't want to use `Oh-My-Posh` as it was a fairly easy script. I already use `Oh-My-Zsh` for my WSL and I don't themes for my Ubuntu machine.

## Contributing

Feel free to open issues or submit pull requests to improve this script. Contributions are welcome!

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.