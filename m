Return-Path: <stable+bounces-161590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C105B0058A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2F61707C2
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0AC1E7660;
	Thu, 10 Jul 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHb+t+61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB714A60F;
	Thu, 10 Jul 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158832; cv=none; b=ayUu0++J1YJcvYDwaPm++lDBLBeQkNl91SWJg2xMPdxw7Op6qPVcdEc5NEvHgzYUL8VFSEva2dnJPWSN9uUyMpgZTc7W1xkr8uy7kegakJcEoB0Ngka84kYsVA6yzrQroQlLu2txxxLqIBRJupdrtLuN1r5iVAgVEK+h8zGdVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158832; c=relaxed/simple;
	bh=Mm1pHtB/LACiLaQEpESzlCGXrYL5dGcT3z2uz33ERKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQb8q07M5RgXP8XvPWh5fqJE5Az42ax0UyLBtsDWm4XySkvOAd4Hs8XP2dohSoCGTmX5R50Xyq6AVXfO4+nAZGDPeqW3O8JG3q1vuFoWtuP6gYTd5rWhUOEPtJu46/uUuFndvyOksCaFmM5v1OfzfC87kQOTiRXtLOF/hzPiuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHb+t+61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388A1C4CEE3;
	Thu, 10 Jul 2025 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752158831;
	bh=Mm1pHtB/LACiLaQEpESzlCGXrYL5dGcT3z2uz33ERKk=;
	h=From:To:Cc:Subject:Date:From;
	b=zHb+t+61WbJxSyFj9K4PCXmgYB5BqonHx+x5hawHZLExt8a/ndskE+5DMgoftc77a
	 e2CC6fodNPGv6sIW/I4KmK7ovZjQu9KMZDqOgv3s+BP7zOYRj817h53SBM43Df6Vy+
	 978JvV0wceRir4oxK+H7BKvDCHLUWXtYVzPAaNpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.187
Date: Thu, 10 Jul 2025 16:47:05 +0200
Message-ID: <2025071006-motivator-fiftieth-34fd@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.187 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu              |    1 
 Documentation/ABI/testing/sysfs-driver-ufs                      |    2 
 Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst |    4 
 Documentation/admin-guide/kernel-parameters.txt                 |   13 
 Documentation/devicetree/bindings/serial/8250.yaml              |    2 
 Makefile                                                        |    2 
 arch/arm/include/asm/ptrace.h                                   |    5 
 arch/arm64/mm/mmu.c                                             |    3 
 arch/powerpc/include/uapi/asm/ioctls.h                          |    8 
 arch/s390/Makefile                                              |    2 
 arch/s390/kernel/entry.S                                        |    2 
 arch/s390/purgatory/Makefile                                    |    2 
 arch/um/drivers/ubd_user.c                                      |    2 
 arch/um/include/asm/asm-prototypes.h                            |    5 
 arch/x86/Kconfig                                                |    9 
 arch/x86/entry/entry.S                                          |    8 
 arch/x86/include/asm/cpu.h                                      |   13 
 arch/x86/include/asm/cpufeatures.h                              |    6 
 arch/x86/include/asm/irqflags.h                                 |    4 
 arch/x86/include/asm/mwait.h                                    |   19 -
 arch/x86/include/asm/nospec-branch.h                            |   39 +-
 arch/x86/kernel/cpu/amd.c                                       |   58 ++++
 arch/x86/kernel/cpu/bugs.c                                      |  133 +++++++++-
 arch/x86/kernel/cpu/common.c                                    |   14 -
 arch/x86/kernel/cpu/scattered.c                                 |    2 
 arch/x86/kernel/process.c                                       |   15 -
 arch/x86/kvm/cpuid.c                                            |   25 +
 arch/x86/kvm/reverse_cpuid.h                                    |    8 
 arch/x86/kvm/svm/vmenter.S                                      |    6 
 arch/x86/kvm/vmx/vmx.c                                          |    2 
 arch/x86/um/asm/checksum.h                                      |    3 
 drivers/acpi/acpica/dsmethod.c                                  |    7 
 drivers/ata/pata_cs5536.c                                       |    2 
 drivers/base/cpu.c                                              |    7 
 drivers/clk/ti/clk-43xx.c                                       |    1 
 drivers/dma/xilinx/xilinx_dma.c                                 |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c              |    2 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c             |    3 
 drivers/gpu/drm/bridge/cdns-dsi.c                               |   27 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                        |   12 
 drivers/gpu/drm/i915/gt/intel_ring_submission.c                 |    3 
 drivers/gpu/drm/i915/selftests/i915_request.c                   |   20 -
 drivers/gpu/drm/i915/selftests/mock_request.c                   |    2 
 drivers/gpu/drm/msm/msm_gem_submit.c                            |    9 
 drivers/gpu/drm/tegra/dc.c                                      |   17 -
 drivers/gpu/drm/tegra/hub.c                                     |    4 
 drivers/gpu/drm/tegra/hub.h                                     |    3 
 drivers/gpu/drm/udl/udl_drv.c                                   |    2 
 drivers/gpu/drm/v3d/v3d_drv.h                                   |    8 
 drivers/gpu/drm/v3d/v3d_gem.c                                   |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                                   |   39 ++
 drivers/hid/wacom_sys.c                                         |    6 
 drivers/hv/channel_mgmt.c                                       |   33 +-
 drivers/hv/hyperv_vmbus.h                                       |   19 -
 drivers/hv/vmbus_drv.c                                          |    2 
 drivers/hwmon/pmbus/max34440.c                                  |   48 +++
 drivers/hwtracing/coresight/coresight-core.c                    |    3 
 drivers/hwtracing/coresight/coresight-priv.h                    |    1 
 drivers/i2c/busses/i2c-designware-master.c                      |    1 
 drivers/i2c/busses/i2c-robotfuzz-osif.c                         |    6 
 drivers/i2c/busses/i2c-tiny-usb.c                               |    6 
 drivers/iio/pressure/zpa2326.c                                  |    2 
 drivers/infiniband/hw/mlx5/counters.c                           |    2 
 drivers/infiniband/hw/mlx5/devx.c                               |    2 
 drivers/leds/led-class-multicolor.c                             |    3 
 drivers/mailbox/mailbox.c                                       |    2 
 drivers/md/bcache/super.c                                       |    7 
 drivers/md/dm-raid.c                                            |    2 
 drivers/md/md-bitmap.c                                          |    2 
 drivers/media/platform/davinci/vpif.c                           |    4 
 drivers/media/platform/imx-jpeg/mxc-jpeg.c                      |   12 
 drivers/media/platform/omap3isp/ispccdc.c                       |    8 
 drivers/media/platform/omap3isp/ispstat.c                       |    6 
 drivers/media/usb/uvc/uvc_ctrl.c                                |   40 +--
 drivers/mfd/max14577.c                                          |    1 
 drivers/mmc/core/quirks.h                                       |   16 -
 drivers/mmc/host/mtk-sd.c                                       |   21 +
 drivers/mmc/host/sdhci.c                                        |    9 
 drivers/mmc/host/sdhci.h                                        |   16 +
 drivers/mtd/nand/spi/core.c                                     |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                     |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                       |    9 
 drivers/net/ethernet/amd/xgbe/xgbe.h                            |    4 
 drivers/net/ethernet/atheros/atlx/atl1.c                        |   78 ++++-
 drivers/net/ethernet/cisco/enic/enic_main.c                     |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                |  115 +++++++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h                |   14 -
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c            |   18 -
 drivers/net/ethernet/freescale/dpaa2/dpni-cmd.h                 |    6 
 drivers/net/ethernet/freescale/dpaa2/dpni.c                     |    2 
 drivers/net/ethernet/freescale/dpaa2/dpni.h                     |    6 
 drivers/net/ethernet/freescale/enetc/enetc_hw.h                 |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                       |   10 
 drivers/net/ethernet/sun/niu.c                                  |   31 ++
 drivers/net/ethernet/sun/niu.h                                  |    4 
 drivers/net/wireless/ath/ath6kl/bmi.c                           |    4 
 drivers/pci/controller/pci-hyperv.c                             |   17 -
 drivers/platform/mellanox/mlxbf-tmfifo.c                        |    3 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c      |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c  |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c   |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c              |   12 
 drivers/platform/x86/ideapad-laptop.c                           |   19 +
 drivers/platform/x86/think-lmi.c                                |   18 -
 drivers/regulator/gpio-regulator.c                              |   19 +
 drivers/rtc/rtc-cmos.c                                          |   10 
 drivers/s390/crypto/pkey_api.c                                  |    2 
 drivers/scsi/qla2xxx/qla_mbx.c                                  |    2 
 drivers/scsi/qla4xxx/ql4_os.c                                   |    2 
 drivers/scsi/ufs/ufs-sysfs.c                                    |    4 
 drivers/spi/spi-fsl-dspi.c                                      |   11 
 drivers/staging/rtl8723bs/core/rtw_security.c                   |   44 +--
 drivers/target/target_core_pr.c                                 |    4 
 drivers/tty/serial/uartlite.c                                   |   25 -
 drivers/tty/vt/consolemap.c                                     |   47 ++-
 drivers/tty/vt/vt.c                                             |   12 
 drivers/uio/uio_hv_generic.c                                    |   10 
 drivers/usb/cdns3/cdnsp-ring.c                                  |    4 
 drivers/usb/class/cdc-wdm.c                                     |   23 -
 drivers/usb/common/usb-conn-gpio.c                              |   25 +
 drivers/usb/core/quirks.c                                       |    3 
 drivers/usb/core/usb.c                                          |   14 -
 drivers/usb/dwc2/gadget.c                                       |    6 
 drivers/usb/gadget/function/f_tcm.c                             |    4 
 drivers/usb/host/xhci-dbgcap.c                                  |    4 
 drivers/usb/host/xhci-dbgtty.c                                  |    1 
 drivers/usb/typec/altmodes/displayport.c                        |    5 
 drivers/video/console/dummycon.c                                |   24 +
 drivers/video/console/mdacon.c                                  |   21 -
 drivers/video/console/newport_con.c                             |   12 
 drivers/video/console/sticon.c                                  |   14 -
 drivers/video/console/vgacon.c                                  |   38 +-
 drivers/video/fbdev/core/fbcon.c                                |   57 +---
 fs/btrfs/inode.c                                                |   19 +
 fs/btrfs/tree-log.c                                             |    4 
 fs/btrfs/volumes.c                                              |    6 
 fs/ceph/file.c                                                  |    2 
 fs/cifs/misc.c                                                  |    8 
 fs/f2fs/super.c                                                 |   30 +-
 fs/jfs/jfs_dmap.c                                               |   41 ---
 fs/ksmbd/smb2pdu.c                                              |   53 ++-
 fs/namespace.c                                                  |    8 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |  121 ++++++---
 fs/nfs/inode.c                                                  |   19 +
 fs/nfs/nfs4proc.c                                               |   12 
 fs/nfs/pnfs.c                                                   |    4 
 fs/overlayfs/util.c                                             |    4 
 include/dt-bindings/clock/am4.h                                 |    1 
 include/linux/console.h                                         |   13 
 include/linux/console_struct.h                                  |    6 
 include/linux/cpu.h                                             |    1 
 include/linux/hyperv.h                                          |    2 
 include/linux/ipv6.h                                            |    1 
 include/linux/regulator/gpio-regulator.h                        |    2 
 include/linux/usb/typec_dp.h                                    |    1 
 include/uapi/linux/vm_sockets.h                                 |    4 
 kernel/rcu/tree.c                                               |    4 
 lib/test_objagg.c                                               |    4 
 net/atm/clip.c                                                  |   11 
 net/atm/resources.c                                             |    3 
 net/bluetooth/l2cap_core.c                                      |    9 
 net/core/selftests.c                                            |    5 
 net/ipv6/ip6_output.c                                           |    9 
 net/mac80211/rx.c                                               |    4 
 net/mac80211/util.c                                             |    2 
 net/rose/rose_route.c                                           |   15 -
 net/sched/sch_api.c                                             |   19 -
 net/unix/af_unix.c                                              |   18 -
 net/vmw_vsock/vmci_transport.c                                  |    4 
 sound/isa/sb/sb16_main.c                                        |    7 
 sound/pci/hda/hda_bind.c                                        |    2 
 sound/pci/hda/hda_intel.c                                       |    3 
 sound/usb/quirks.c                                              |    2 
 sound/usb/stream.c                                              |    2 
 tools/lib/bpf/btf_dump.c                                        |    3 
 177 files changed, 1582 insertions(+), 626 deletions(-)

Al Viro (1):
      attach_recursive_mnt(): do not lock the covering tree when sliding something under it

Alexis Czezar Torreno (1):
      hwmon: (pmbus/max34440) Fix support for max34451

Alok Tiwari (1):
      enic: fix incorrect MTU comparison in enic_change_mtu()

Andrei Kuchynski (1):
      usb: typec: displayport: Fix potential deadlock

Andy Shevchenko (1):
      usb: Add checks for snprintf() calls in usb_alloc_dev()

Aradhya Bhatia (4):
      drm/bridge: cdns-dsi: Fix the clock variable for mode_valid()
      drm/bridge: cdns-dsi: Fix connecting to next bridge
      drm/bridge: cdns-dsi: Check return value when getting default PHY config
      drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready

Avri Altman (1):
      mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier

Bart Van Assche (1):
      scsi: ufs: core: Fix spelling of a sysfs attribute name

Benjamin Coddington (1):
      NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN

Borislav Petkov (AMD) (4):
      x86/bugs: Rename MDS machinery to something more generic
      x86/bugs: Add a Transient Scheduler Attacks mitigation
      KVM: SVM: Advertise TSA CPUID bits to guests
      x86/process: Move the buffer clearing before MONITOR

Brett A C Sheffield (Librecast) (1):
      Revert "ipv6: save dontfrag in cork"

Cezary Rojewski (1):
      ALSA: hda: Ignore unsol events for cards being shut down

Chance Yang (1):
      usb: common: usb-conn-gpio: use a unique name for usb connector device

Chao Yu (1):
      f2fs: don't over-report free space or inodes in statvfs

Chen Yufeng (1):
      usb: potential integer overflow in usbg_make_tpg()

Dan Carpenter (2):
      drm/i915/selftests: Change mock_request() to return error pointers
      lib: test_objagg: Set error message in check_expect_hints_stats()

Daniel Vetter (1):
      fbcon: delete a few unneeded forward decl

Dave Kleikamp (1):
      fs/jfs: consolidate sanity checking in dbMount

David Thompson (1):
      platform/mellanox: mlxbf-tmfifo: fix vring_desc.len assignment

Dev Jain (1):
      arm64: Restrict pagetable teardown to avoid false warning

Dexuan Cui (1):
      PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot time

Dmitry Kandybka (1):
      ceph: fix possible integer overflow in ceph_zero_objects()

Dmitry Nikiforov (1):
      media: davinci: vpif: Fix memory leak in probe error path

Eric Dumazet (1):
      atm: clip: prevent NULL deref in clip_push()

Fedor Pchelkin (1):
      s390/pkey: Prevent overflow in size calculation for memdup_user()

Filipe Manana (1):
      btrfs: fix missing error handling when searching for inode refs during log replay

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix L2CAP MTU negotiation

Fushuai Wang (1):
      dpaa2-eth: fix xdp_rxq_info leak

Geert Uytterhoeven (1):
      ARM: 9354/1: ptrace: Use bitfield helpers

Greg Kroah-Hartman (1):
      Linux 5.15.187

Han Young (1):
      NFSv4: Always set NLINK even if the server doesn't support it

HarshaVardhana S A (1):
      vsock/vmci: Clear the vmci transport packet properly when initializing it

Heiko Carstens (1):
      s390/entry: Fix last breaking event handling in case of stack corruption

Heinz Mauelshagen (1):
      dm-raid: fix variable in journal device check

Ioana Ciornei (1):
      net: dpaa2-eth: rearrange variable in dpaa2_eth_get_ethtool_stats

Jakub Kicinski (1):
      net: selftests: fix TCP packet checksum

Jakub Lewalski (1):
      tty: serial: uartlite: register uart driver in init

James Clark (2):
      coresight: Only check bottom two claim bits
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer

Janusz Krzysztofik (1):
      drm/i915/gt: Fix timeline left held on VMA alloc error

Jay Cornwall (1):
      drm/amdkfd: Fix race in GWS queue scheduling

Jerome Neanne (1):
      regulator: gpio: Add input_supply support in gpio_regulator_config

Jiri Slaby (1):
      tty/vt: consolemap: rename and document struct uni_pagedir

Jiri Slaby (SUSE) (5):
      vgacon: switch vgacon_scrolldelta() and vgacon_restore_screen()
      vgacon: remove unneeded forward declarations
      tty: vt: make init parameter of consw::con_init() a bool
      tty: vt: sanitize arguments of consw::con_clear()
      tty: vt: make consw::con_switch() return a bool

Johannes Berg (3):
      ata: pata_cs5536: fix build on 32-bit UML
      wifi: mac80211: drop invalid source address OCB frames
      wifi: ath6kl: remove WARN on bad firmware input

Jonathan Cameron (1):
      iio: pressure: zpa2326: Use aligned_s64 for the timestamp

Jos Wang (1):
      usb: typec: displayport: Receive DP Status Update NAK request exit dp altmode

Josef Bacik (1):
      btrfs: don't drop extent_map for free space inode on write error

Kees Cook (1):
      ovl: Check for NULL d_inode() in ovl_dentry_upper()

Kohei Enju (1):
      rose: fix dangling neighbour pointers in rose_rt_device_down()

Krzysztof Kozlowski (1):
      mfd: max14577: Fix wakeup source leaks on device unbind

Kuniyuki Iwashima (3):
      af_unix: Don't set -ECONNRESET for consumed OOB skb.
      atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().
      nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.

Kurt Borja (4):
      platform/x86: dell-wmi-sysman: Fix WMI data block retrieval in sysfs callbacks
      platform/x86: think-lmi: Fix class device unregistration
      platform/x86: dell-wmi-sysman: Fix class device unregistration
      platform/x86: think-lmi: Create ksets consecutively

Lachlan Hodges (1):
      wifi: mac80211: fix beacon interval calculation overflow

Linggang Zeng (1):
      bcache: fix NULL pointer in cache_set_flush()

Lion Ackermann (1):
      net/sched: Always pass notifications when child class becomes empty

Long Li (1):
      uio_hv_generic: Align ring size to system page

Madhavan Srinivasan (1):
      powerpc: Fix struct termio related ioctl macros

Manivannan Sadhasivam (1):
      regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods

Marek Szyprowski (2):
      media: omap3isp: use sgtable-based scatterlist wrappers
      drm/exynos: fimd: Guard display clock control with runtime PM calls

Mario Limonciello (1):
      ALSA: usb-audio: Add a quirk for Lenovo Thinkpad Thunderbolt 3 dock

Mark Harmstone (1):
      btrfs: update superblock's device bytes_used when dropping chunk

Mark Zhang (1):
      RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert

Masami Hiramatsu (Google) (2):
      mtk-sd: Fix a pagefault in dma_unmap_sg() for not prepared data
      mtk-sd: Prevent memory corruption from DMA map failure

Mateusz Jończyk (1):
      rtc: cmos: use spin_lock_irqsave in cmos_interrupt

Mathias Nyman (1):
      xhci: dbc: Flush queued requests before stopping dbc

Maurizio Lombardi (1):
      scsi: target: Fix NULL pointer dereference in core_scsi3_decode_spec_i_port()

Maíra Canal (1):
      drm/v3d: Disable interrupts before resetting the GPU

Michael Grzeschik (1):
      usb: dwc2: also exit clock_gating when stopping udc while suspended

Michael J. Ruhl (1):
      i2c/designware: Fix an initialization issue

Ming Qian (1):
      media: imx-jpeg: Drop the first error frames

Miquel Raynal (1):
      clk: ti: am43xx: Add clkctrl data for am43xx ADC1

Namjae Jeon (1):
      ksmbd: allow a filename to contain special characters on SMB3.1.1 posix extension

Nathan Chancellor (2):
      staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()
      s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS

Olga Kornievskaia (1):
      NFSv4.2: fix listxattr to return selinux security label

Oliver Neukum (1):
      Logitech C-270 even more broken

Pablo Martin-Gomez (1):
      mtd: spinand: fix memory leak of ECC engine conf

Pali Rohár (1):
      cifs: Fix cifs_query_path_info() for Windows NT servers

Paolo Bonzini (1):
      KVM: x86: add support for CPUID leaf 0x80000021

Patrisious Haddad (1):
      RDMA/mlx5: Fix CC counters query for MPV

Peng Fan (1):
      mailbox: Not protect module_put with spin_lock_irqsave

Peter Chen (1):
      usb: cdnsp: do not disable slot for disabled slot

Qasim Ijaz (3):
      HID: wacom: fix memory leak on kobject creation failure
      HID: wacom: fix memory leak on sysfs attribute creation failure
      HID: wacom: fix kobject reference count leak

Qiu-ji Chen (1):
      drm/tegra: Fix a possible null pointer dereference

RD Babiera (1):
      usb: typec: altmodes/displayport: do not index invalid pin_assignments

Radu Bulie (2):
      dpaa2-eth: Update dpni_get_single_step_cfg command
      dpaa2-eth: Update SINGLE_STEP register access

Rafael J. Wysocki (1):
      ACPICA: Refuse to evaluate a method if arguments are missing

Raju Rangoju (1):
      amd-xgbe: align CL37 AN sequence as per databook

Ricardo Ribalda (1):
      media: uvcvideo: Rollback non processed entities on error

Rob Clark (1):
      drm/msm: Fix a fence leak in submit error path

Robert Hodaszi (1):
      usb: cdc-wdm: avoid setting WDM_READ for ZLP-s

Rong Zhang (1):
      platform/x86: ideapad-laptop: use usleep_range() for EC polling

Sami Tolvanen (1):
      um: Add cmpxchg8b_emu and checksum functions to asm-prototypes.h

Saurabh Sengar (2):
      Drivers: hv: vmbus: Add utility function for querying ring size
      uio_hv_generic: Query the ringbuffer size for device

Sergey Senozhatsky (1):
      mtk-sd: reset host->mrq on prepare_data() error

Simon Horman (1):
      net: enetc: Correct endianness handling in _enetc_rd_reg64

Stefano Garzarella (1):
      vsock/uapi: fix linux/vm_sockets.h userspace compilation errors

Sven Schwermer (1):
      leds: multicolor: Fix intensity setting while SW blinking

Takashi Iwai (2):
      ALSA: sb: Don't allow changing the DMA mode during operations
      ALSA: sb: Force to disable DMAs once when DMA mode is changed

Thierry Reding (1):
      drm/tegra: Assign plane type before registration

Thomas Fourier (4):
      scsi: qla2xxx: Fix DMA mapping test in qla24xx_get_port_database()
      scsi: qla4xxx: Fix missing DMA mapping error in qla4xxx_alloc_pdu()
      nui: Fix dma_mapping_error() check
      ethernet: atl1: Add missing DMA mapping error checks and count errors

Thomas Gessler (1):
      dmaengine: xilinx_dma: Set dma_device directions

Thomas Zimmermann (2):
      dummycon: Trigger redraw when switching consoles with deferred takeover
      drm/udl: Unregister device before cleaning up on disconnect

Tiwei Bie (1):
      um: ubd: Add missing error check in start_io_thread()

Trond Myklebust (1):
      NFSv4/flexfiles: Fix handling of NFS level errors in I/O

Uladzislau Rezki (Sony) (1):
      rcu: Return early if callback is not specified

Ulf Hansson (1):
      Revert "mmc: sdhci: Disable SD card clock before changing parameters"

Vasiliy Kovalev (1):
      jfs: validate AG parameters in dbMount() to prevent crashes

Victor Shih (1):
      mmc: sdhci: Add a helper function for dump register in dynamic debug mode

Vijendar Mukunda (1):
      ALSA: hda: Add new pci id for AMD GPU display HD audio controller

Vitaly Kuznetsov (1):
      Drivers: hv: Rename 'alloced' to 'allocated'

Vitaly Lifshits (1):
      igc: disable L1.2 PCI-E link substate to avoid performance issue

Wentao Liang (1):
      drm/amd/display: Add null pointer check for get_first_active_display()

Wolfram Sang (2):
      i2c: tiny-usb: disable zero-length read messages
      i2c: robotfuzz-osif: disable zero-length read messages

Yao Zi (1):
      dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive

Youngjun Lee (1):
      ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()

Yu Kuai (1):
      md/md-bitmap: fix dm-raid max_write_behind setting

Yuan Chen (1):
      libbpf: Fix null pointer dereference in btf_dump__free on allocation failure

Łukasz Bartosik (1):
      xhci: dbctty: disable ECHO flag by default


