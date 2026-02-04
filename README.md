# Disclaimer
I am not responsible for any damage that may occur to your device. Flashing firmware involves risks and you proceed at your own responsibility. Use this tool with caution.

# Fastboot Flasher

A powerful, interactive script to flash stock firmware images and extract payloads for the OnePlus Nord 5.

## Features
- **Interactive TUI**: Easy-to-use menu system.
- **Flash Images**: Automated flashing of all partitions with checks to ensure all files exist.
- **Process Local ZIP**: Extract images directly from a local firmware ZIP file.
- **Download & Extract**: Download firmware from a direct link and automatically extract images from `payload.bin`.
    - Supports `aria2c` for high-speed downloads.
    - Auto-detects system architecture (x86_64, arm64, armv7) to download the correct `payload-dumper-go` binary.

## Prerequisites
- Linux Environment (Bash)
- `fastboot`.
- `whiptail`.
- `unzip`, `wget`, `curl`.
- (Optional) `aria2c` for faster downloads.

## Usage

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Oneplus-Nord5-development/flash-tool flash
   cd flash
   ```

2. **Make the script executable**:
   ```bash
   chmod +x flash.sh
   ```

3. **Run the tool**:
   ```bash
   ./flash.sh
   ```

4. **Follow the on-screen menu**:
   - **Option 1: Flash Images**: Flashes images from the parent directory (`../`). **Note**: You must be in `fastbootd` mode.
   - **Option 2: Process Local ZIP**: Select a firmware ZIP on your disk to extract.
   - **Option 3: Download ROM**: Paste a direct link to a firmware ZIP to download and extract it.

## Flashing Instructions
1. Ensure your device is in **FastbootD** mode.
2. If you don't have images yet, use **Option 2** or **Option 3** to get them.
3. Select **Option 1** to flash.
4. If checking for success, manually verify output.
5. Once done: Verify and select the post flash options.
6. Enjoy

---
## Credits 
- For flash script : [Chandu](https://github.com/chandu078)
