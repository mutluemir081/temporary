# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/SuperiorOS/manifest.git -b thirteen -g default,-mips,-darwin,-notdefault
git clone https://github.com/mutluemir081/local_manifests --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch superior_ginkgo-userdebug
export TZ=Asia/Dhaka #put before last build command
m bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
