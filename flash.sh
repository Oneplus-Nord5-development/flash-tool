#!/bin/bash

# Check all images exist
function check_images() {
    required_images=(
        "boot.img" "dtbo.img" "init_boot.img" "modem.img" "recovery.img" 
        "vbmeta.img" "vbmeta_system.img" "vbmeta_vendor.img" "vendor_boot.img" 
        "abl.img" "aop.img" "aop_config.img" "bluetooth.img" "cpucp.img" 
        "cpucp_dtb.img" "devcfg.img" "dsp.img" "engineering_cdt.img" 
        "featenabler.img" "hyp.img" "imagefv.img" "keymaster.img" 
        "oplus_sec.img" "oplusstanvbk.img" "qupfw.img" "shrm.img" 
        "splash.img" "tz.img" "uefi.img" "uefisecapp.img" 
        "xbl.img" "xbl_config.img" "xbl_ramdump.img" 
        "my_bigball.img" "my_carrier.img" "my_engineering.img" 
        "my_heytap.img" "my_manifest.img" "my_product.img" 
        "my_region.img" "my_stock.img" "odm.img" "product.img" 
        "system.img" "system_dlkm.img" "system_ext.img" 
        "vendor.img" "vendor_dlkm.img" "my_company.img" "my_preload.img"
    )

    missing_files=()
    for img in "${required_images[@]}"; do
        if [ ! -f "../$img" ]; then
            missing_files+=("$img")
        fi
    done
    
    if [ ${#missing_files[@]} -ne 0 ]; then
        msg="Error: The following images are missing in the parent directory (../):\n\n"
        count=0
        for f in "${missing_files[@]}"; do
            msg="${msg}- $f\n"
            ((count++))
            if [ $count -gt 15 ]; then
                msg="${msg}... and more."
                break
            fi
        done
        msg="${msg}\n\nPlease 'Process Local ZIP' or 'Download ROM' to get these files first."
        whiptail --msgbox "$msg" 25 78
        return 1
    fi
    return 0
}

# Function to perform the actual flashing
function do_flash() {
    echo "Starting flash process..."
    fastboot --set-active=a
    fastboot flash boot ../boot.img
    fastboot flash dtbo ../dtbo.img
    fastboot flash init_boot ../init_boot.img
    fastboot flash modem ../modem.img
    fastboot flash recovery ../recovery.img
    fastboot flash vbmeta ../vbmeta.img
    fastboot flash vbmeta_system ../vbmeta_system.img
    fastboot flash vbmeta_vendor ../vbmeta_vendor.img
    fastboot flash vendor_boot ../vendor_boot.img
    fastboot flash --slot=all abl ../abl.img
    fastboot flash --slot=all aop ../aop.img
    fastboot flash --slot=all aop_config ../aop_config.img
    fastboot flash --slot=all bluetooth ../bluetooth.img
    fastboot flash --slot=all cpucp ../cpucp.img
    fastboot flash --slot=all cpucp_dtb ../cpucp_dtb.img
    fastboot flash --slot=all devcfg ../devcfg.img
    fastboot flash --slot=all dsp ../dsp.img
    fastboot flash --slot=all engineering_cdt ../engineering_cdt.img
    fastboot flash --slot=all featenabler ../featenabler.img
    fastboot flash --slot=all hyp ../hyp.img
    fastboot flash --slot=all imagefv ../imagefv.img
    fastboot flash --slot=all keymaster ../keymaster.img
    fastboot flash --slot=all oplus_sec ../oplus_sec.img
    fastboot flash --slot=all oplusstanvbk ../oplusstanvbk.img
    fastboot flash --slot=all qupfw ../qupfw.img
    fastboot flash --slot=all shrm ../shrm.img
    fastboot flash --slot=all splash ../splash.img
    fastboot flash --slot=all tz ../tz.img
    fastboot flash --slot=all uefi ../uefi.img
    fastboot flash --slot=all uefisecapp ../uefisecapp.img
    fastboot flash --slot=all xbl ../xbl.img
    fastboot flash --slot=all xbl_config ../xbl_config.img
    fastboot flash --slot=all xbl_ramdump ../xbl_ramdump.img
    fastboot delete-logical-partition my_bigball_a
    fastboot delete-logical-partition my_bigball_b
    fastboot delete-logical-partition my_bigball_a-cow
    fastboot delete-logical-partition my_bigball_b-cow
    fastboot create-logical-partition my_bigball_a 1
    fastboot create-logical-partition my_bigball_b 1
    fastboot flash my_bigball ../my_bigball.img
    fastboot delete-logical-partition my_carrier_a
    fastboot delete-logical-partition my_carrier_b
    fastboot delete-logical-partition my_carrier_a-cow
    fastboot delete-logical-partition my_carrier_b-cow
    fastboot create-logical-partition my_carrier_a 1
    fastboot create-logical-partition my_carrier_b 1
    fastboot flash my_carrier ../my_carrier.img
    fastboot delete-logical-partition my_engineering_a
    fastboot delete-logical-partition my_engineering_b
    fastboot delete-logical-partition my_engineering_a-cow
    fastboot delete-logical-partition my_engineering_b-cow
    fastboot create-logical-partition my_engineering_a 1
    fastboot create-logical-partition my_engineering_b 1
    fastboot flash my_engineering ../my_engineering.img
    fastboot delete-logical-partition my_heytap_a
    fastboot delete-logical-partition my_heytap_b
    fastboot delete-logical-partition my_heytap_a-cow
    fastboot delete-logical-partition my_heytap_b-cow
    fastboot create-logical-partition my_heytap_a 1
    fastboot create-logical-partition my_heytap_b 1
    fastboot flash my_heytap ../my_heytap.img
    fastboot delete-logical-partition my_manifest_a
    fastboot delete-logical-partition my_manifest_b
    fastboot delete-logical-partition my_manifest_a-cow
    fastboot delete-logical-partition my_manifest_b-cow
    fastboot create-logical-partition my_manifest_a 1
    fastboot create-logical-partition my_manifest_b 1
    fastboot flash my_manifest ../my_manifest.img
    fastboot delete-logical-partition my_product_a
    fastboot delete-logical-partition my_product_b
    fastboot delete-logical-partition my_product_a-cow
    fastboot delete-logical-partition my_product_b-cow
    fastboot create-logical-partition my_product_a 1
    fastboot create-logical-partition my_product_b 1
    fastboot flash my_product ../my_product.img
    fastboot delete-logical-partition my_region_a
    fastboot delete-logical-partition my_region_b
    fastboot delete-logical-partition my_region_a-cow
    fastboot delete-logical-partition my_region_b-cow
    fastboot create-logical-partition my_region_a 1
    fastboot create-logical-partition my_region_b 1
    fastboot flash my_region ../my_region.img
    fastboot delete-logical-partition my_stock_a
    fastboot delete-logical-partition my_stock_b
    fastboot delete-logical-partition my_stock_a-cow
    fastboot delete-logical-partition my_stock_b-cow
    fastboot create-logical-partition my_stock_a 1
    fastboot create-logical-partition my_stock_b 1
    fastboot flash my_stock ../my_stock.img
    fastboot delete-logical-partition odm_a
    fastboot delete-logical-partition odm_b
    fastboot delete-logical-partition odm_a-cow
    fastboot delete-logical-partition odm_b-cow
    fastboot create-logical-partition odm_a 1
    fastboot create-logical-partition odm_b 1
    fastboot flash odm ../odm.img
    fastboot delete-logical-partition product_a
    fastboot delete-logical-partition product_b
    fastboot delete-logical-partition product_a-cow
    fastboot delete-logical-partition product_b-cow
    fastboot create-logical-partition product_a 1
    fastboot create-logical-partition product_b 1
    fastboot flash product ../product.img
    fastboot delete-logical-partition system_a
    fastboot delete-logical-partition system_b
    fastboot delete-logical-partition system_a-cow
    fastboot delete-logical-partition system_b-cow
    fastboot create-logical-partition system_a 1
    fastboot create-logical-partition system_b 1
    fastboot flash system ../system.img
    fastboot delete-logical-partition system_dlkm_a
    fastboot delete-logical-partition system_dlkm_b
    fastboot delete-logical-partition system_dlkm_a-cow
    fastboot delete-logical-partition system_dlkm_b-cow
    fastboot create-logical-partition system_dlkm_a 1
    fastboot create-logical-partition system_dlkm_b 1
    fastboot flash system_dlkm ../system_dlkm.img
    fastboot delete-logical-partition system_ext_a
    fastboot delete-logical-partition system_ext_b
    fastboot delete-logical-partition system_ext_a-cow
    fastboot delete-logical-partition system_ext_b-cow
    fastboot create-logical-partition system_ext_a 1
    fastboot create-logical-partition system_ext_b 1
    fastboot flash system_ext ../system_ext.img
    fastboot delete-logical-partition vendor_a
    fastboot delete-logical-partition vendor_b
    fastboot delete-logical-partition vendor_a-cow
    fastboot delete-logical-partition vendor_b-cow
    fastboot create-logical-partition vendor_a 1
    fastboot create-logical-partition vendor_b 1
    fastboot flash vendor ../vendor.img
    fastboot delete-logical-partition vendor_dlkm_a
    fastboot delete-logical-partition vendor_dlkm_b
    fastboot delete-logical-partition vendor_dlkm_a-cow
    fastboot delete-logical-partition vendor_dlkm_b-cow
    fastboot create-logical-partition vendor_dlkm_a 1
    fastboot create-logical-partition vendor_dlkm_b 1
    fastboot flash vendor_dlkm ../vendor_dlkm.img
    fastboot delete-logical-partition my_company_a
    fastboot delete-logical-partition my_company_b
    fastboot delete-logical-partition my_company_a-cow
    fastboot delete-logical-partition my_company_b-cow
    fastboot create-logical-partition my_company_a 1
    fastboot create-logical-partition my_company_b 1
    fastboot flash my_company ../my_company.img
    fastboot delete-logical-partition my_preload_a
    fastboot delete-logical-partition my_preload_b
    fastboot delete-logical-partition my_preload_a-cow
    fastboot delete-logical-partition my_preload_b-cow
    fastboot create-logical-partition my_preload_a 1
    fastboot create-logical-partition my_preload_b 1
    fastboot flash my_preload ../my_preload.img
    echo "Flashing complete."
}

# Function to flash images with logs and post-flash menu
function flash_images() {
    if ! check_images; then
        return
    fi
    
    # Run flashing and log output
    {
        do_flash
    } 2>&1 | tee flashing_log.txt
    
    whiptail --msgbox "Flashing complete!\n\nLog saved to: flashing_log.txt\n\nPlease check the log above (or in the file) for any errors before proceeding." 12 78
    
    # Post-flash menu
    pf_choice=$(whiptail --title "Post-Flash Actions" --menu "Choose what to do next:" 15 78 3 \
    "1" "Lock Bootloader (Relock)" \
    "2" "Keep Bootloader Unlocked (Wipe Data)" \
    "3" "Do Nothing (Exit Tool)" 3>&1 1>&2 2>&3)
    
    case $pf_choice in
        1)
            if whiptail --yesno "WARNING: Relocking the bootloader will wipe your data again. Are you sure?" 8 78; then
                fastboot reboot bootloader
                fastboot flashing relock
                echo "Please confirm locking on your device."
                exit 0
            fi
            ;;
        2)
            echo "Rebooting to bootloader and wiping data..."
            fastboot reboot bootloader
            fastboot -w
            echo "Data wiped. You can now reboot to system manually."
            exit 0
            ;;
        3)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Cancelled."
            ;;
    esac
}

# Function to setup payload-dumper-go
function setup_payload_dumper() {
    if command -v payload-dumper-go &> /dev/null; then
        return 0
    fi
    
    if [ -f "./payload-dumper-go" ]; then
         return 0
    fi

    whiptail --infobox "payload-dumper-go not found. Downloading..." 8 78
    
    # Architecture detection
    ARCH=$(uname -m)
    case $ARCH in
        x86_64)
            URL="https://github.com/ssut/payload-dumper-go/releases/download/1.3.0/payload-dumper-go_1.3.0_linux_amd64.tar.gz"
            ;;
        aarch64|arm64)
            URL="https://github.com/ssut/payload-dumper-go/releases/download/1.3.0/payload-dumper-go_1.3.0_linux_arm64.tar.gz"
            ;;
        armv7l|armv7)
            URL="https://github.com/ssut/payload-dumper-go/releases/download/1.3.0/payload-dumper-go_1.3.0_linux_armv7.tar.gz"
            ;;
        *)
            # Fallback to amd64 if unknown
            URL="https://github.com/ssut/payload-dumper-go/releases/download/1.3.0/payload-dumper-go_1.3.0_linux_amd64.tar.gz"
            ;;
    esac

    wget -O payload-dumper.tar.gz "$URL"
    tar -xzf payload-dumper.tar.gz
    chmod +x payload-dumper-go
    rm payload-dumper.tar.gz
}

# Helper to handle payload extraction
function extract_payload_if_found() {
    local target_dir="$1"
    
    if [ -f "$target_dir/payload.bin" ]; then
        if whiptail --yesno "Found payload.bin in $target_dir. Extract images?" 8 78; then
            setup_payload_dumper
            
            DUMPER_CMD=""
            if command -v payload-dumper-go &> /dev/null; then
                DUMPER_CMD="payload-dumper-go"
            elif [ -f "./payload-dumper-go" ]; then
                DUMPER_CMD="./payload-dumper-go"
            fi
            
            if [ -n "$DUMPER_CMD" ]; then
                echo "Extracting payload.bin..."
                # Extract to the target directory (usually ../ to be ready for flash)
                $DUMPER_CMD -o "$target_dir" "$target_dir/payload.bin"
                echo "Extraction complete."
                read -p "Press Enter to continue..."
            else
                echo "Error: payload-dumper-go setup failed. Skipping."
                read -p "Press Enter to continue..."
            fi
        fi
    fi
}

# Function to download images
function download_images() {
    url=$(whiptail --inputbox "Enter the direct URL to the firmware zip:" 8 78 --title "Download Firmware" 3>&1 1>&2 2>&3)
    if [ -z "$url" ]; then return; fi
    
    dest_dir=$(whiptail --inputbox "Enter destination directory (default: ..):" 8 78 ".." --title "Destination" 3>&1 1>&2 2>&3)
    dest_dir=${dest_dir:-..}
    mkdir -p "$dest_dir"

    clear
    
    ARIA_CMD=""
    if command -v aria2c &> /dev/null; then ARIA_CMD="aria2c"; fi
    
    if [ -n "$ARIA_CMD" ]; then
        echo "Downloading firmware using aria2c..."
        $ARIA_CMD -x 16 -s 16 -d "$dest_dir" -o "firmware.zip" "$url"
        DL_STATUS=$?
    else
        echo "aria2c not found. Using wget..."
        wget -O "$dest_dir/firmware.zip" "$url"
        DL_STATUS=$?
    fi
    
    if [ $DL_STATUS -eq 0 ]; then
        echo "Download successful. Unzipping..."
        unzip -o "$dest_dir/firmware.zip" -d "$dest_dir"
        extract_payload_if_found "$dest_dir"
    else
        echo "Download failed."
        read -p "Press Enter to continue..."
    fi
}

# Function to process local ZIP
function process_local_zip() {
    zip_path=$(whiptail --inputbox "Enter the full path to the local ZIP file:" 8 78 --title "Process Local ZIP" 3>&1 1>&2 2>&3)
    if [ -z "$zip_path" ]; then return; fi
    
    if [ ! -f "$zip_path" ]; then
        whiptail --msgbox "Error: File not found at $zip_path" 8 78
        return
    fi
    
    dest_dir=$(whiptail --inputbox "Enter destination directory to dump contents (default: ..):" 8 78 ".." --title "Destination" 3>&1 1>&2 2>&3)
    dest_dir=${dest_dir:-..}
    mkdir -p "$dest_dir"
    
    clear
    echo "Unzipping $zip_path to $dest_dir ..."
    unzip -o "$zip_path" -d "$dest_dir"
    
    if [ $? -eq 0 ]; then
        echo "Unzip complete."
        extract_payload_if_found "$dest_dir"
    else
        echo "Unzip failed."
        read -p "Press Enter to continue..."
    fi
}

# Main Menu
function main_menu() {
    while true; do
        choice=$(whiptail --title "Fastboot Flash Tool" --menu "Choose an option" 15 70 4 \
        "1" "Flash Images" \
        "2" "Process Local ZIP / Payload Dump" \
        "3" "Download ROM & Extract Images" \
        "4" "Exit" 3>&1 1>&2 2>&3)
        
        exit_status=$?
        if [ $exit_status -ne 0 ]; then
            exit 0
        fi

        case $choice in
            1) 
                if whiptail --yesno "Are you sure you want to flash images? This involves writing to partitions." 8 78; then
                    clear
                    flash_images
                    read -p "Press Enter to return to menu..."
                fi
                ;;
            2) 
                process_local_zip 
                ;;
            3) 
                download_images 
                ;;
            4) 
                exit 0 
                ;;
        esac
    done
}

# Check if whiptail is available
if ! command -v whiptail &> /dev/null; then
    echo "Error: whiptail is not installed. Please install it."
    exit 1
fi

# Run the menu
main_menu
