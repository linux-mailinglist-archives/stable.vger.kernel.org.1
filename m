Return-Path: <stable+bounces-160284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72FAFA3E7
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB361188AAA0
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36681FBCB2;
	Sun,  6 Jul 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KbykGvoR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54C1F4C99;
	Sun,  6 Jul 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793225; cv=none; b=CVebAYnacsjL4RiD3oeh5OY66xpJ6NcuygpWvmDEgkkh3BLuBn+7/JzeJ5Z0gJM2Pjkh9J1ygYvI4cKzhwLm+51NUJPycDCRFH/8GvFHcn4TUvKt9NCvLyyBOKU+2ByAb0wrFb3B2IXfvIzAIa+cDxKZdD/rFB7bTF4PMXbvesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793225; c=relaxed/simple;
	bh=eq4IosQ0u6GNu+Ey4cQIP3KEi/Rkyzmd6/JqZA/tpw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8jx8yGC5+CPcJqTnc+PjMTsMziVZdN96URGB/QaMqmm2FbRRDSkE2alUFU8+1ovqRsMq3xWNlceEksAb97Tc9s/qGswZh+xJWaIxIMx6ZUhCURq6s4JdeXgQ4W6qlUSWZi6znkf/tcYq9nkrbDvbO/IlsWUKGgvFiXbM1q3Zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KbykGvoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E15C4CEED;
	Sun,  6 Jul 2025 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751793225;
	bh=eq4IosQ0u6GNu+Ey4cQIP3KEi/Rkyzmd6/JqZA/tpw8=;
	h=From:To:Cc:Subject:Date:From;
	b=KbykGvoRsuS2PAhkwu3dkubE2+QWpBzbEf7gqcVAKyWds3QyMwOUV3odLZbd/HQKH
	 JkukCebU1nZC6PjW0OTz7SRoA/1n1FUBe+ag1Yia9gk1BYDRHYtHtjrPHBIvYFd6ic
	 Z7obYPMrFFRgaVh7NsvjEmfTQpjpjE8asWWZ46gM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.36
Date: Sun,  6 Jul 2025 11:13:37 +0200
Message-ID: <2025070638-embark-sanitary-05ae@gregkh>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.36 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/8250.yaml                             |    2 
 Documentation/netlink/specs/tc.yaml                                            |    4 
 Makefile                                                                       |    2 
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi                             |   12 
 arch/riscv/include/asm/cmpxchg.h                                               |    2 
 arch/riscv/include/asm/pgtable.h                                               |    1 
 arch/riscv/kernel/traps_misaligned.c                                           |    4 
 arch/riscv/mm/cacheflush.c                                                     |   15 
 arch/um/drivers/ubd_user.c                                                     |    2 
 arch/um/include/asm/asm-prototypes.h                                           |    5 
 arch/um/kernel/trap.c                                                          |  129 +
 arch/x86/include/uapi/asm/debugreg.h                                           |   21 
 arch/x86/kernel/cpu/common.c                                                   |   24 
 arch/x86/kernel/fpu/signal.c                                                   |   11 
 arch/x86/kernel/fpu/xstate.h                                                   |   22 
 arch/x86/kernel/traps.c                                                        |   34 
 arch/x86/um/asm/checksum.h                                                     |    3 
 drivers/accel/ivpu/ivpu_debugfs.c                                              |   84 +
 drivers/accel/ivpu/ivpu_drv.c                                                  |    6 
 drivers/accel/ivpu/ivpu_drv.h                                                  |   10 
 drivers/accel/ivpu/ivpu_hw.c                                                   |   21 
 drivers/accel/ivpu/ivpu_hw.h                                                   |    5 
 drivers/accel/ivpu/ivpu_job.c                                                  |  201 +-
 drivers/accel/ivpu/ivpu_job.h                                                  |    2 
 drivers/accel/ivpu/ivpu_jsm_msg.c                                              |   46 
 drivers/ata/ahci.c                                                             |    2 
 drivers/cxl/core/region.c                                                      |    7 
 drivers/dma/idxd/cdev.c                                                        |    4 
 drivers/dma/xilinx/xilinx_dma.c                                                |    2 
 drivers/edac/amd64_edac.c                                                      |   57 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                                  |   64 
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c                                      |   30 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                                        |   12 
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h                                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h                                       |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c                                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c                                      |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h                                      |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                                   |    2 
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c                                       |    6 
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h                                 |  677 +++++-----
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm                         |   82 -
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                                        |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                                        |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c                             |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c           |    1 
 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c |    5 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c                  |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c                      |    9 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c                            |    3 
 drivers/gpu/drm/ast/ast_mode.c                                                 |    6 
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c                                 |   32 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                                          |  109 +
 drivers/gpu/drm/drm_fbdev_dma.c                                                |  219 ++-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c                                        |    5 
 drivers/gpu/drm/i915/display/vlv_dsi.c                                         |    4 
 drivers/gpu/drm/i915/i915_pmu.c                                                |    2 
 drivers/gpu/drm/msm/dp/dp_display.c                                            |   11 
 drivers/gpu/drm/msm/dp/dp_drm.c                                                |    5 
 drivers/gpu/drm/msm/msm_gpu_devfreq.c                                          |    1 
 drivers/gpu/drm/scheduler/sched_entity.c                                       |    1 
 drivers/gpu/drm/tegra/dc.c                                                     |   17 
 drivers/gpu/drm/tegra/hub.c                                                    |    4 
 drivers/gpu/drm/tegra/hub.h                                                    |    3 
 drivers/gpu/drm/tiny/cirrus.c                                                  |    1 
 drivers/gpu/drm/udl/udl_drv.c                                                  |    2 
 drivers/gpu/drm/xe/display/xe_display.c                                        |    2 
 drivers/gpu/drm/xe/xe_ggtt.c                                                   |   11 
 drivers/gpu/drm/xe/xe_gpu_scheduler.h                                          |   10 
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c                                    |    8 
 drivers/gpu/drm/xe/xe_guc_ct.c                                                 |    7 
 drivers/gpu/drm/xe/xe_guc_ct.h                                                 |    5 
 drivers/gpu/drm/xe/xe_guc_pc.c                                                 |    2 
 drivers/gpu/drm/xe/xe_guc_submit.c                                             |   23 
 drivers/gpu/drm/xe/xe_guc_types.h                                              |    5 
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c                                         |   54 
 drivers/gpu/drm/xe/xe_vm.c                                                     |    8 
 drivers/hid/hid-lenovo.c                                                       |   11 
 drivers/hid/wacom_sys.c                                                        |    7 
 drivers/hwmon/pmbus/max34440.c                                                 |   48 
 drivers/hwtracing/coresight/coresight-core.c                                   |    3 
 drivers/hwtracing/coresight/coresight-priv.h                                   |    1 
 drivers/i2c/busses/i2c-robotfuzz-osif.c                                        |    6 
 drivers/i2c/busses/i2c-tiny-usb.c                                              |    6 
 drivers/iio/adc/ad_sigma_delta.c                                               |    4 
 drivers/iio/dac/Makefile                                                       |    2 
 drivers/iio/dac/ad3552r-common.c                                               |  248 +++
 drivers/iio/dac/ad3552r.c                                                      |  557 +-------
 drivers/iio/dac/ad3552r.h                                                      |  223 +++
 drivers/iio/pressure/zpa2326.c                                                 |    2 
 drivers/leds/led-class-multicolor.c                                            |    3 
 drivers/mailbox/mailbox.c                                                      |    2 
 drivers/md/bcache/super.c                                                      |    7 
 drivers/md/dm-raid.c                                                           |    2 
 drivers/md/dm-vdo/indexer/volume.c                                             |   24 
 drivers/md/md-bitmap.c                                                         |    2 
 drivers/media/usb/uvc/uvc_ctrl.c                                               |   34 
 drivers/mfd/max14577.c                                                         |    1 
 drivers/misc/tps6594-pfsm.c                                                    |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                                      |    5 
 drivers/net/ethernet/freescale/enetc/enetc_hw.h                                |    2 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                               |   12 
 drivers/net/ethernet/realtek/r8169.h                                           |    1 
 drivers/net/ethernet/realtek/r8169_main.c                                      |   23 
 drivers/net/ethernet/realtek/r8169_phy_config.c                                |   10 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                              |   11 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                                    |    6 
 drivers/net/phy/realtek.c                                                      |   54 
 drivers/nvme/host/tcp.c                                                        |   22 
 drivers/pci/controller/dwc/pci-imx6.c                                          |   15 
 drivers/pci/controller/dwc/pcie-designware.c                                   |    5 
 drivers/pci/controller/pcie-apple.c                                            |    7 
 drivers/s390/crypto/pkey_api.c                                                 |    2 
 drivers/scsi/megaraid/megaraid_sas_base.c                                      |    6 
 drivers/spi/spi-cadence-quadspi.c                                              |   12 
 drivers/spi/spi-fsl-qspi.c                                                     |   36 
 drivers/staging/rtl8723bs/core/rtw_security.c                                  |   44 
 drivers/tty/serial/8250/8250_pci1xxxx.c                                        |   10 
 drivers/tty/serial/imx.c                                                       |   17 
 drivers/tty/serial/serial_base_bus.c                                           |    1 
 drivers/tty/serial/uartlite.c                                                  |   25 
 drivers/ufs/core/ufshcd.c                                                      |    6 
 drivers/usb/class/cdc-wdm.c                                                    |   23 
 drivers/usb/common/usb-conn-gpio.c                                             |   25 
 drivers/usb/core/usb.c                                                         |   14 
 drivers/usb/dwc2/gadget.c                                                      |    6 
 drivers/usb/gadget/function/f_hid.c                                            |   19 
 drivers/usb/gadget/function/f_tcm.c                                            |    4 
 drivers/usb/typec/altmodes/displayport.c                                       |    4 
 drivers/usb/typec/mux.c                                                        |    4 
 drivers/usb/typec/tcpm/tcpm.c                                                  |    3 
 fs/btrfs/backref.h                                                             |    4 
 fs/btrfs/direct-io.c                                                           |    4 
 fs/btrfs/disk-io.c                                                             |    5 
 fs/btrfs/extent_io.h                                                           |    2 
 fs/btrfs/extent_map.c                                                          |  132 +
 fs/btrfs/extent_map.h                                                          |    3 
 fs/btrfs/fs.h                                                                  |    2 
 fs/btrfs/inode.c                                                               |  297 ++--
 fs/btrfs/ordered-data.c                                                        |   14 
 fs/btrfs/raid56.c                                                              |    5 
 fs/btrfs/super.c                                                               |   13 
 fs/btrfs/tests/extent-io-tests.c                                               |    6 
 fs/btrfs/volumes.c                                                             |    6 
 fs/btrfs/zstd.c                                                                |    2 
 fs/ceph/file.c                                                                 |    2 
 fs/f2fs/file.c                                                                 |   38 
 fs/f2fs/super.c                                                                |   30 
 fs/fuse/dir.c                                                                  |   11 
 fs/jfs/jfs_dmap.c                                                              |   41 
 fs/namespace.c                                                                 |    8 
 fs/nfs/inode.c                                                                 |   51 
 fs/nfs/nfs4proc.c                                                              |   25 
 fs/overlayfs/util.c                                                            |    4 
 fs/proc/task_mmu.c                                                             |    2 
 fs/smb/client/cifs_debug.c                                                     |   23 
 fs/smb/client/cifsglob.h                                                       |    2 
 fs/smb/client/cifspdu.h                                                        |    6 
 fs/smb/client/cifssmb.c                                                        |    1 
 fs/smb/client/connect.c                                                        |   58 
 fs/smb/client/misc.c                                                           |    8 
 fs/smb/client/sess.c                                                           |   21 
 fs/smb/client/smb2ops.c                                                        |   14 
 fs/smb/client/smbdirect.c                                                      |  513 +++----
 fs/smb/client/smbdirect.h                                                      |   64 
 fs/smb/client/trace.h                                                          |   24 
 fs/smb/common/smbdirect/smbdirect.h                                            |   37 
 fs/smb/common/smbdirect/smbdirect_pdu.h                                        |   55 
 fs/smb/common/smbdirect/smbdirect_socket.h                                     |   43 
 fs/smb/server/connection.h                                                     |    1 
 fs/smb/server/smb2pdu.c                                                        |   72 -
 fs/smb/server/smb2pdu.h                                                        |    3 
 include/net/bluetooth/hci_core.h                                               |    2 
 include/uapi/drm/ivpu_accel.h                                                  |    6 
 include/uapi/linux/vm_sockets.h                                                |    4 
 io_uring/kbuf.c                                                                |    1 
 io_uring/kbuf.h                                                                |    1 
 io_uring/net.c                                                                 |   46 
 io_uring/rsrc.c                                                                |   23 
 io_uring/rsrc.h                                                                |    1 
 lib/group_cpus.c                                                               |    9 
 lib/maple_tree.c                                                               |    4 
 mm/damon/sysfs-schemes.c                                                       |    1 
 mm/gup.c                                                                       |   14 
 mm/vma.c                                                                       |   27 
 net/atm/clip.c                                                                 |   11 
 net/atm/resources.c                                                            |    3 
 net/bluetooth/hci_core.c                                                       |   34 
 net/bluetooth/l2cap_core.c                                                     |    9 
 net/core/selftests.c                                                           |    5 
 net/mac80211/chan.c                                                            |    3 
 net/mac80211/ieee80211_i.h                                                     |   12 
 net/mac80211/iface.c                                                           |   12 
 net/mac80211/link.c                                                            |   94 +
 net/mac80211/util.c                                                            |    2 
 net/sunrpc/clnt.c                                                              |    9 
 net/unix/af_unix.c                                                             |   31 
 rust/Makefile                                                                  |    2 
 rust/macros/module.rs                                                          |    1 
 sound/pci/hda/hda_bind.c                                                       |    2 
 sound/pci/hda/hda_intel.c                                                      |    3 
 sound/pci/hda/patch_realtek.c                                                  |    2 
 sound/soc/amd/yc/acp6x-mach.c                                                  |    7 
 sound/soc/codecs/rt1320-sdw.c                                                  |   17 
 sound/soc/codecs/wcd9335.c                                                     |   40 
 sound/usb/quirks.c                                                             |    2 
 sound/usb/stream.c                                                             |    2 
 tools/lib/bpf/btf_dump.c                                                       |    3 
 tools/lib/bpf/libbpf.c                                                         |   10 
 tools/testing/selftests/bpf/progs/test_global_map_resize.c                     |   16 
 212 files changed, 3777 insertions(+), 2218 deletions(-)

Adin Scannell (1):
      libbpf: Fix possible use-after-free for externs

Aidan Stewart (1):
      serial: core: restore of_node information in sysfs

Al Viro (1):
      attach_recursive_mnt(): do not lock the covering tree when sliding something under it

Alex Deucher (2):
      drm/amdgpu/discovery: optionally use fw based ip discovery
      drm/amdgpu: switch job hw_fence to amdgpu_fence

Alex Hung (2):
      drm/amd/display: Check dce_hwseq before dereferencing it
      drm/amd/display: Fix mpv playback corruption on weston

Alexis Czezar Torreno (1):
      hwmon: (pmbus/max34440) Fix support for max34451

Andres Traumann (1):
      ALSA: hda/realtek: Bass speaker fixup for ASUS UM5606KA

Andrzej Kacprowski (1):
      accel/ivpu: Remove copy engine support

Andy Chiu (1):
      riscv: add a data fence for CMODX in the kernel mode

Andy Shevchenko (1):
      usb: Add checks for snprintf() calls in usb_alloc_dev()

Angelo Dureghello (3):
      iio: dac: ad3552r: changes to use FIELD_PREP
      iio: dac: ad3552r: extract common code (no changes in behavior intended)
      iio: dac: ad3552r-common: fix ad3541/2r ranges

Aradhya Bhatia (5):
      drm/bridge: cdns-dsi: Fix the clock variable for mode_valid()
      drm/bridge: cdns-dsi: Fix phy de-init and flag it so
      drm/bridge: cdns-dsi: Fix connecting to next bridge
      drm/bridge: cdns-dsi: Check return value when getting default PHY config
      drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready

Arnd Bergmann (1):
      drm/i915: fix build error some more

Avadhut Naik (1):
      EDAC/amd64: Fix size calculation for Non-Power-of-Two DIMMs

Benjamin Berg (1):
      um: use proper care when taking mmap lock during segfault

Cezary Rojewski (1):
      ALSA: hda: Ignore unsol events for cards being shut down

Chance Yang (1):
      usb: common: usb-conn-gpio: use a unique name for usb connector device

Chang S. Bae (2):
      x86/fpu: Refactor xfeature bitmask update code for sigframe XSAVE
      x86/pkeys: Simplify PKRU update in signal frame

Chao Yu (2):
      f2fs: don't over-report free space or inodes in statvfs
      f2fs: fix to zero post-eof page

Chen Yu (1):
      scsi: megaraid_sas: Fix invalid node index

Chen Yufeng (1):
      usb: potential integer overflow in usbg_make_tpg()

Chenyuan Yang (1):
      misc: tps6594-pfsm: Add NULL pointer check in tps6594_pfsm_probe()

Daniele Ceraolo Spurio (1):
      drm/xe: Fix early wedge on GuC load failure

Dave Kleikamp (1):
      fs/jfs: consolidate sanity checking in dbMount

David Hildenbrand (2):
      fs/proc/task_mmu: fix PAGE_IS_PFNZERO detection for the huge zero folio
      mm/gup: revert "mm: gup: fix infinite loop within __get_longterm_locked"

David Howells (2):
      cifs: Fix the smbd_response slab to allow usercopy
      cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code

David Sterba (1):
      btrfs: use unsigned types for constants defined as bit shifts

Dmitry Kandybka (1):
      ceph: fix possible integer overflow in ceph_zero_objects()

Dragan Simic (1):
      arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board dtsi

Eric Dumazet (1):
      atm: clip: prevent NULL deref in clip_push()

FUJITA Tomonori (1):
      rust: module: place cleanup_module() in .exit.text section

Fabio Estevam (1):
      serial: imx: Restore original RXTL for console to fix data loss

Fedor Pchelkin (1):
      s390/pkey: Prevent overflow in size calculation for memdup_user()

Filipe Manana (5):
      btrfs: fix qgroup reservation leak on failure to allocate ordered extent
      btrfs: fix a race between renames and directory logging
      btrfs: skip inodes without loaded extent maps when shrinking extent maps
      btrfs: make the extent map shrinker run asynchronously as a work queue job
      btrfs: do regular iput instead of delayed iput during extent map shrinking

Frank Min (1):
      drm/amdgpu: Add kicker device detection

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix L2CAP MTU negotiation

Greg Kroah-Hartman (1):
      Linux 6.12.36

Guang Yuan Wu (1):
      fuse: fix race between concurrent setattrs from multiple nodes

Han Xu (1):
      spi: fsl-qspi: use devm function instead of driver remove

Han Young (1):
      NFSv4: Always set NLINK even if the server doesn't support it

Hannes Reinecke (2):
      nvme-tcp: fix I/O stalls on congested sockets
      nvme-tcp: sanitize request list handling

Haoxiang Li (1):
      drm/xe/display: Add check for alloc_ordered_workqueue()

Hector Martin (1):
      PCI: apple: Fix missing OF node reference in apple_pcie_setup_port

Heiner Kallweit (3):
      r8169: add support for RTL8125D
      net: phy: realtek: merge the drivers for internal NBase-T PHY's
      net: phy: realtek: add RTL8125D-internal PHY

Heinz Mauelshagen (1):
      dm-raid: fix variable in journal device check

Iusico Maxim (1):
      HID: lenovo: Restrict F7/9/11 mode to compact keyboards only

Jakub Kicinski (2):
      netlink: specs: tc: replace underscores with dashes in names
      net: selftests: fix TCP packet checksum

Jakub Lewalski (1):
      tty: serial: uartlite: register uart driver in init

James Clark (1):
      coresight: Only check bottom two claim bits

Janne Grunau (1):
      PCI: apple: Set only available ports up

Jay Cornwall (2):
      drm/amdkfd: Fix race in GWS queue scheduling
      drm/amdkfd: Fix instruction hazard in gfx12 trap handler

Jayesh Choudhary (1):
      drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort connector type

Jens Axboe (6):
      io_uring/net: improve recv bundles
      io_uring/net: only retry recv bundle for a full transfer
      io_uring/net: only consider msg_inq if larger than 1
      io_uring/net: always use current transfer count for buffer put
      io_uring/net: mark iov as dynamically allocated even for single segments
      io_uring/kbuf: flag partial buffer mappings

Jesse Zhang (1):
      drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop sequences

Jiawen Wu (2):
      net: libwx: fix the creation of page_pool
      net: libwx: fix Tx L4 checksum

Johannes Berg (1):
      wifi: mac80211: finish link init before RCU publish

John Olender (1):
      drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to total vram

Jonathan Cameron (1):
      iio: pressure: zpa2326: Use aligned_s64 for the timestamp

Jonathan Kim (1):
      drm/amdkfd: remove gfx 12 trap handler page size cap

Joonas Lahtinen (1):
      Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1"

Jos Wang (1):
      usb: typec: displayport: Receive DP Status Update NAK request exit dp altmode

Karol Wachowski (5):
      accel/ivpu: Do not fail on cmdq if failed to allocate preemption buffers
      accel/ivpu: Make command queue ID allocated on XArray
      accel/ivpu: Separate DB ID and CMDQ ID allocations from CMDQ allocation
      accel/ivpu: Add debugfs interface for setting HWS priority bands
      accel/ivpu: Trigger device recovery on engine reset/resume failure

Kees Cook (1):
      ovl: Check for NULL d_inode() in ovl_dentry_upper()

Kevin Hao (1):
      spi: fsl-qspi: Fix double cleanup in probe error path

Khairul Anuar Romli (1):
      spi: spi-cadence-quadspi: Fix pm runtime unbalance

Krzysztof Kozlowski (2):
      mfd: max14577: Fix wakeup source leaks on device unbind
      ASoC: codecs: wcd9335: Fix missing free of regulator supplies

Kuniyuki Iwashima (4):
      af_unix: Don't leave consecutive consumed OOB skbs.
      Bluetooth: hci_core: Fix use-after-free in vhci_flush()
      af_unix: Don't set -ECONNRESET for consumed OOB skb.
      atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().

Lachlan Hodges (1):
      wifi: mac80211: fix beacon interval calculation overflow

Liam R. Howlett (1):
      maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()

Lin.Cao (1):
      drm/scheduler: signal scheduled fence when kill job

Linggang Zeng (1):
      bcache: fix NULL pointer in cache_set_flush()

Lorenzo Stoakes (1):
      mm/vma: reset VMA iterator on commit_merge() OOM failure

Lucas De Marchi (2):
      drm/xe: Fix memset on iomem
      drm/xe: Fix taking invalid lock on wedge

Mario Limonciello (2):
      ALSA: usb-audio: Add a quirk for Lenovo Thinkpad Thunderbolt 3 dock
      drm/amd: Adjust output for discovery error handling

Mark Harmstone (1):
      btrfs: update superblock's device bytes_used when dropping chunk

Matthew Auld (3):
      drm/xe/vm: move rebind_work init earlier
      drm/xe/sched: stop re-submitting signalled jobs
      drm/xe/guc_submit: add back fix

Matthew Sakai (1):
      dm vdo indexer: don't read request structure after enqueuing

Maíra Canal (1):
      drm/etnaviv: Protect the scheduler's pending list with its lock

Michael Grzeschik (2):
      usb: dwc2: also exit clock_gating when stopping udc while suspended
      usb: typec: mux: do not return on EOPNOTSUPP in {mux, switch}_set

Michal Wajdeczko (1):
      drm/xe: Process deferred GGTT node removals on device unwind

Muna Sinada (2):
      wifi: mac80211: Add link iteration macro for link data
      wifi: mac80211: Create separate links for VLAN interfaces

Nam Cao (2):
      Revert "riscv: Define TASK_SIZE_MAX for __access_ok()"
      Revert "riscv: misaligned: fix sleeping function called during misaligned access handling"

Namjae Jeon (2):
      ksmbd: allow a filename to contain special characters on SMB3.1.1 posix extension
      ksmbd: provide zero as a unique ID to the Mac client

Naohiro Aota (1):
      btrfs: zoned: fix extent range end unlock in cow_file_range()

Nathan Chancellor (1):
      staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()

Nikhil Jha (1):
      sunrpc: don't immediately retransmit on seqno miss

Niklas Cassel (1):
      ata: ahci: Use correct DMI identifier for ASUSPRO-D840SA LPM quirk

Olga Kornievskaia (1):
      NFSv4.2: fix listxattr to return selinux security label

Oliver Schramm (1):
      ASoC: amd: yc: Add DMI quirk for Lenovo IdeaPad Slim 5 15

Pali Rohár (3):
      cifs: Correctly set SMB1 SessionKey field in Session Setup Request
      cifs: Fix cifs_query_path_info() for Windows NT servers
      cifs: Fix encoding of SMB1 Session Setup NTLMSSP Request in non-UNICODE mode

Paulo Alcantara (1):
      smb: client: fix potential deadlock when reconnecting channels

Pavel Begunkov (2):
      io_uring/rsrc: fix folio unpinning
      io_uring/rsrc: don't rely on user vaddr alignment

Peng Fan (2):
      mailbox: Not protect module_put with spin_lock_irqsave
      ASoC: codec: wcd9335: Convert to GPIO descriptors

Penglei Jiang (1):
      io_uring: fix potential page leak in io_sqe_buffer_register()

Peter Korsgaard (1):
      usb: gadget: f_hid: wake up readers on disable/unbind

Philip Yang (1):
      drm/amdgpu: seq64 memory unmap uses uninterruptible lock

Purva Yeshi (1):
      iio: adc: ad_sigma_delta: Fix use of uninitialized status_pos

Qasim Ijaz (3):
      HID: wacom: fix memory leak on kobject creation failure
      HID: wacom: fix memory leak on sysfs attribute creation failure
      HID: wacom: fix kobject reference count leak

Qingfang Deng (1):
      net: stmmac: Fix accessing freed irq affinity_hint

Qiu-ji Chen (1):
      drm/tegra: Fix a possible null pointer dereference

Qu Wenruo (3):
      btrfs: handle csum tree error with rescue=ibadroots correctly
      btrfs: factor out nocow ordered extent and extent map generation into a helper
      btrfs: do proper folio cleanup when cow_file_range() failed

Rengarajan S (1):
      8250: microchip: pci1xxxx: Add PCIe Hot reset disable support for Rev C0 and later devices

Ricardo Ribalda (1):
      media: uvcvideo: Rollback non processed entities on error

Richard Zhu (1):
      PCI: imx6: Add workaround for errata ERR051624

Robert Hodaszi (1):
      usb: cdc-wdm: avoid setting WDM_READ for ZLP-s

Robert Richter (1):
      cxl/region: Add a dev_err() on missing target list entries

Rudraksha Gupta (1):
      rust: arm: fix unknown (to Clang) argument '-mno-fdpic'

Sagi Grimberg (1):
      NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET when timestamps are delegated

Salvatore Bonaccorso (1):
      ALSA: hda/realtek: Fix built-in mic on ASUS VivoBook X507UAR

Sami Tolvanen (1):
      um: Add cmpxchg8b_emu and checksum functions to asm-prototypes.h

Sasha Levin (5):
      drm/xe: Carve out wopcm portion from the stolen memory
      usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap enters ERROR_RECOVERY
      drm/msm/dp: account for widebus and yuv420 during mode validation
      riscv/atomic: Do proper sign extension also for unsigned in arch_cmpxchg
      btrfs: fix use-after-free on inode when scanning root during em shrinking

Scott Mayhew (1):
      NFSv4: xattr handlers should check for absent nfs filehandles

SeongJae Park (1):
      mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path on write

Shuming Fan (1):
      ASoC: rt1320: fix speaker noise when volume bar is 100%

Simon Horman (1):
      net: enetc: Correct endianness handling in _enetc_rd_reg64

Stefan Metzmacher (8):
      smb: client: remove \t from TP_printk statements
      smb: smbdirect: add smbdirect_pdu.h with protocol definitions
      smb: client: make use of common smbdirect_pdu.h
      smb: smbdirect: add smbdirect.h with public structures
      smb: smbdirect: add smbdirect_socket.h
      smb: client: make use of common smbdirect_socket
      smb: smbdirect: introduce smbdirect_socket_parameters
      smb: client: make use of common smbdirect_socket_parameters

Stefano Garzarella (1):
      vsock/uapi: fix linux/vm_sockets.h userspace compilation errors

Stephan Gerhold (1):
      drm/msm/gpu: Fix crash when throttling GPU immediately during boot

Sven Schwermer (1):
      leds: multicolor: Fix intensity setting while SW blinking

Thierry Reding (1):
      drm/tegra: Assign plane type before registration

Thomas Fourier (1):
      ethernet: ionic: Fix DMA mapping tests

Thomas Gessler (1):
      dmaengine: xilinx_dma: Set dma_device directions

Thomas Zeitlhofer (1):
      HID: wacom: fix crash in wacom_aes_battery_handler()

Thomas Zimmermann (4):
      drm/ast: Fix comment on modeset lock
      drm/cirrus-qemu: Fix pitch programming
      drm/udl: Unregister device before cleaning up on disconnect
      drm/fbdev-dma: Add shadow buffering for deferred I/O

Tiwei Bie (1):
      um: ubd: Add missing error check in start_io_thread()

Vasiliy Kovalev (1):
      jfs: validate AG parameters in dbMount() to prevent crashes

Vijendar Mukunda (1):
      ALSA: hda: Add new pci id for AMD GPU display HD audio controller

Ville Syrjälä (2):
      drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1
      drm/i915/dsi: Fix off by one in BXT_MIPI_TRANS_VTOTAL

Wenbin Yao (1):
      PCI: dwc: Make link training more robust by setting PORT_LOGIC_LINK_WIDTH to one lane

Wentao Liang (1):
      drm/amd/display: Add null pointer check for get_first_active_display()

Wolfram Sang (3):
      i2c: tiny-usb: disable zero-length read messages
      i2c: robotfuzz-osif: disable zero-length read messages
      drm/bridge: ti-sn65dsi86: make use of debugfs_init callback

Xin Li (Intel) (1):
      x86/traps: Initialize DR6 by writing its architectural reset value

Yan Zhai (1):
      bnxt: properly flush XDP redirect lists

Yao Zi (1):
      dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive

Yi Sun (1):
      dmaengine: idxd: Check availability of workqueue allocated by idxd wq driver before using

Yifan Zhang (1):
      amd/amdkfd: fix a kfd_process ref leak

Yihan Zhu (1):
      drm/amd/display: Fix RMCM programming seq errors

Youngjun Lee (1):
      ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()

Yu Kuai (2):
      md/md-bitmap: fix dm-raid max_write_behind setting
      lib/group_cpus: fix NULL pointer dereference from group_cpus_evenly()

Yuan Chen (1):
      libbpf: Fix null pointer dereference in btf_dump__free on allocation failure

Zhang Zekun (1):
      PCI: apple: Use helper function for_each_child_of_node_scoped()

Zhongwei Zhang (1):
      drm/amd/display: Correct non-OLED pre_T11_delay.

Ziqi Chen (1):
      scsi: ufs: core: Don't perform UFS clkscaling during host async scan

anvithdosapati (1):
      scsi: ufs: core: Fix clk scaling to be conditional in reset and restore


