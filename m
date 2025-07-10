Return-Path: <stable+bounces-161595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A00B0059D
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9CF1C47828
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6219274B25;
	Thu, 10 Jul 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1BkfNgx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB82741D4;
	Thu, 10 Jul 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158867; cv=none; b=VdjEk538gygjU05C7wJ0vLT+dZUcoA1rt7sY0hW7WkVengk3GlfGrJs/WYgqEfbRyrJnhIwzXhFk4Pkto6N7ZUylHOiswxX76RM9eKGgpqcWoJoLykQEiErJOH3x+GWUuef5Oi9PzVl2ySoj/EoelKZB5T3gJGH4IHVytHZERyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158867; c=relaxed/simple;
	bh=vZqCHX1OXrD2KLHekbcKncMPfRgic+fdEmzdEOdDhqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j3NQBlE43m7qeHmHlPClmBEeUnq2urepwse3O5BldAPuUG8hffNKWVDJ5XpQm8cwESzPY0td716WWcOdZUUw5rsc3ewObT3cFz887dToO9VCR+CrWJDZ/XHihDWeYnT5COmUNJbxLplPC+QVxwdPDw5Tk7IAYsh396d17tkZP00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1BkfNgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A95C4CEF4;
	Thu, 10 Jul 2025 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752158866;
	bh=vZqCHX1OXrD2KLHekbcKncMPfRgic+fdEmzdEOdDhqo=;
	h=From:To:Cc:Subject:Date:From;
	b=c1BkfNgx5MQNrPyVI9wmNfsnCID/9uSr7xr6eSS6V794W+pvsUeMKhexuYD5zmWs5
	 ocfXXfLNYBGacvWMsnvtRonCONbW33bQIaYSxPy25rI9vuOtQVhENs0+xx51D0GPxs
	 7l/vESSbcZGOmnowu6DggnznD6H9XxMPwyfE6MzQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.97
Date: Thu, 10 Jul 2025 16:47:29 +0200
Message-ID: <2025071029-circus-smuggling-141f@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.97 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu              |    1 
 Documentation/ABI/testing/sysfs-driver-ufs                      |    2 
 Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst |    4 
 Documentation/admin-guide/kernel-parameters.txt                 |   13 
 Documentation/arch/x86/mds.rst                                  |    8 
 Documentation/core-api/symbol-namespaces.rst                    |   22 +
 Makefile                                                        |    2 
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi                       |    2 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                            |   30 +
 arch/powerpc/include/uapi/asm/ioctls.h                          |    8 
 arch/powerpc/kernel/Makefile                                    |    2 
 arch/s390/pci/pci_event.c                                       |    4 
 arch/x86/Kconfig                                                |    9 
 arch/x86/entry/entry.S                                          |    8 
 arch/x86/include/asm/cpu.h                                      |   12 
 arch/x86/include/asm/cpufeatures.h                              |    6 
 arch/x86/include/asm/irqflags.h                                 |    4 
 arch/x86/include/asm/mwait.h                                    |   28 +
 arch/x86/include/asm/nospec-branch.h                            |   37 +-
 arch/x86/include/uapi/asm/debugreg.h                            |   21 +
 arch/x86/kernel/cpu/amd.c                                       |   60 +++
 arch/x86/kernel/cpu/bugs.c                                      |  133 +++++++-
 arch/x86/kernel/cpu/common.c                                    |   38 +-
 arch/x86/kernel/cpu/microcode/amd.c                             |   12 
 arch/x86/kernel/cpu/microcode/amd_shas.c                        |  112 +++++++
 arch/x86/kernel/cpu/scattered.c                                 |    2 
 arch/x86/kernel/process.c                                       |   16 -
 arch/x86/kernel/traps.c                                         |   32 +-
 arch/x86/kvm/cpuid.c                                            |    8 
 arch/x86/kvm/reverse_cpuid.h                                    |    8 
 arch/x86/kvm/svm/vmenter.S                                      |    6 
 arch/x86/kvm/vmx/vmx.c                                          |    2 
 drivers/acpi/acpica/dsmethod.c                                  |    7 
 drivers/ata/libata-acpi.c                                       |   24 +
 drivers/ata/pata_cs5536.c                                       |    2 
 drivers/ata/pata_via.c                                          |    6 
 drivers/base/cpu.c                                              |    3 
 drivers/block/aoe/aoe.h                                         |    1 
 drivers/block/aoe/aoecmd.c                                      |    8 
 drivers/block/aoe/aoedev.c                                      |    5 
 drivers/dma-buf/dma-resv.c                                      |   12 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                        |   12 
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c                  |    2 
 drivers/gpu/drm/i915/gt/intel_gsc.c                             |    2 
 drivers/gpu/drm/i915/gt/intel_ring_submission.c                 |    3 
 drivers/gpu/drm/i915/selftests/i915_request.c                   |   20 -
 drivers/gpu/drm/i915/selftests/mock_request.c                   |    2 
 drivers/gpu/drm/msm/msm_gem_submit.c                            |   17 -
 drivers/gpu/drm/tiny/simpledrm.c                                |    4 
 drivers/gpu/drm/v3d/v3d_drv.h                                   |    8 
 drivers/gpu/drm/v3d/v3d_gem.c                                   |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                                   |   37 +-
 drivers/i2c/busses/i2c-designware-master.c                      |    1 
 drivers/infiniband/hw/mlx5/counters.c                           |    4 
 drivers/infiniband/hw/mlx5/devx.c                               |    2 
 drivers/infiniband/hw/mlx5/main.c                               |   33 ++
 drivers/input/joystick/xpad.c                                   |    2 
 drivers/input/misc/iqs7222.c                                    |    7 
 drivers/iommu/rockchip-iommu.c                                  |    3 
 drivers/mmc/core/quirks.h                                       |   12 
 drivers/mmc/host/mtk-sd.c                                       |   21 +
 drivers/mmc/host/sdhci.c                                        |    9 
 drivers/mmc/host/sdhci.h                                        |   16 +
 drivers/mtd/nand/spi/core.c                                     |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                     |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                       |   13 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                     |   24 -
 drivers/net/ethernet/amd/xgbe/xgbe.h                            |    4 
 drivers/net/ethernet/atheros/atlx/atl1.c                        |   79 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                       |    7 
 drivers/net/ethernet/cisco/enic/enic_main.c                     |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                |   26 +
 drivers/net/ethernet/intel/igc/igc_main.c                       |   10 
 drivers/net/ethernet/sun/niu.c                                  |   31 +
 drivers/net/ethernet/sun/niu.h                                  |    4 
 drivers/net/usb/lan78xx.c                                       |    2 
 drivers/net/virtio_net.c                                        |   38 ++
 drivers/net/wireless/ath/ath6kl/bmi.c                           |    4 
 drivers/platform/mellanox/mlxbf-tmfifo.c                        |    3 
 drivers/platform/mellanox/mlxreg-lc.c                           |    2 
 drivers/platform/mellanox/nvsw-sn2201.c                         |    2 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                       |    9 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c      |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c  |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c   |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c              |   25 -
 drivers/platform/x86/firmware_attributes_class.c                |   43 --
 drivers/platform/x86/firmware_attributes_class.h                |    5 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                    |   14 
 drivers/platform/x86/think-lmi.c                                |  103 ++----
 drivers/powercap/intel_rapl_common.c                            |   18 +
 drivers/regulator/fan53555.c                                    |   14 
 drivers/regulator/gpio-regulator.c                              |    8 
 drivers/rtc/rtc-cmos.c                                          |   10 
 drivers/rtc/rtc-pcf2127.c                                       |    7 
 drivers/scsi/qla2xxx/qla_mbx.c                                  |    2 
 drivers/scsi/qla4xxx/ql4_os.c                                   |    2 
 drivers/spi/spi-fsl-dspi.c                                      |   11 
 drivers/target/target_core_pr.c                                 |    4 
 drivers/ufs/core/ufs-sysfs.c                                    |    4 
 drivers/ufs/core/ufshcd.c                                       |  160 +++++++---
 drivers/usb/cdns3/cdnsp-ring.c                                  |    4 
 drivers/usb/chipidea/udc.c                                      |    7 
 drivers/usb/core/quirks.c                                       |    3 
 drivers/usb/host/xhci-dbgcap.c                                  |    4 
 drivers/usb/host/xhci-dbgtty.c                                  |    1 
 drivers/usb/host/xhci-mem.c                                     |    4 
 drivers/usb/host/xhci-pci.c                                     |   25 +
 drivers/usb/host/xhci-plat.c                                    |    3 
 drivers/usb/host/xhci.h                                         |    1 
 drivers/usb/typec/altmodes/displayport.c                        |    5 
 fs/anon_inodes.c                                                |   23 +
 fs/btrfs/inode.c                                                |   56 +--
 fs/btrfs/ordered-data.c                                         |   12 
 fs/btrfs/tree-log.c                                             |    8 
 fs/f2fs/file.c                                                  |  119 +++++--
 fs/nfs/flexfilelayout/flexfilelayout.c                          |  121 +++++--
 fs/nfs/inode.c                                                  |   17 -
 fs/nfs/pnfs.c                                                   |    4 
 fs/smb/client/cifsglob.h                                        |    2 
 fs/smb/client/connect.c                                         |    7 
 fs/smb/client/readdir.c                                         |    2 
 fs/smb/client/smb2pdu.c                                         |   10 
 fs/smb/client/trace.h                                           |   18 -
 include/linux/cpu.h                                             |    1 
 include/linux/export.h                                          |   12 
 include/linux/fs.h                                              |    2 
 include/linux/libata.h                                          |    7 
 include/linux/usb/typec_dp.h                                    |    1 
 include/net/bluetooth/hci_core.h                                |    2 
 include/trace/events/f2fs.h                                     |   39 +-
 include/ufs/ufshcd.h                                            |    4 
 kernel/rcu/tree.c                                               |    4 
 lib/test_objagg.c                                               |    4 
 mm/secretmem.c                                                  |   11 
 net/bluetooth/hci_core.c                                        |   34 +-
 net/bluetooth/hci_sync.c                                        |   20 -
 net/bluetooth/mgmt.c                                            |   25 +
 net/mac80211/chan.c                                             |    6 
 net/mac80211/ieee80211_i.h                                      |    9 
 net/mac80211/link.c                                             |   15 
 net/mac80211/rx.c                                               |    4 
 net/rose/rose_route.c                                           |   15 
 net/sched/sch_api.c                                             |   19 -
 net/vmw_vsock/vmci_transport.c                                  |    4 
 sound/isa/sb/sb16_main.c                                        |    7 
 sound/soc/amd/yc/acp6x-mach.c                                   |   14 
 149 files changed, 1745 insertions(+), 629 deletions(-)

Alok Tiwari (3):
      platform/mellanox: nvsw-sn2201: Fix bus number in adapter error message
      platform/mellanox: mlxreg-lc: Fix logic error in power state check
      enic: fix incorrect MTU comparison in enic_change_mtu()

Anand Jain (1):
      btrfs: rename err to ret in btrfs_rmdir()

Andrei Kuchynski (1):
      usb: typec: displayport: Fix potential deadlock

Avri Altman (1):
      mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier

Bart Van Assche (1):
      scsi: ufs: core: Fix spelling of a sysfs attribute name

Benjamin Coddington (1):
      NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN

Borislav Petkov (AMD) (5):
      x86/bugs: Rename MDS machinery to something more generic
      x86/bugs: Add a Transient Scheduler Attacks mitigation
      KVM: SVM: Advertise TSA CPUID bits to guests
      x86/microcode/AMD: Add TSA microcode SHAs
      x86/process: Move the buffer clearing before MONITOR

Bui Quang Minh (1):
      virtio-net: ensure the received length does not exceed allocated size

Chao Yu (4):
      f2fs: add tracepoint for f2fs_vm_page_mkwrite()
      f2fs: convert f2fs_vm_page_mkwrite() to use folio
      f2fs: fix to zero post-eof page
      f2fs: fix to avoid use-after-free issue in f2fs_filemap_fault

Christian Eggers (3):
      Bluetooth: hci_sync: revert some mesh modifications
      Bluetooth: MGMT: set_mesh: update LE scan interval and window
      Bluetooth: MGMT: mesh_send: check instances prior disabling advertising

Christian König (1):
      dma-buf: fix timeout handling in dma_resv_wait_timeout v2

Daeho Jeong (1):
      f2fs: prevent writing without fallocate() for pinned files

Dan Carpenter (2):
      drm/i915/selftests: Change mock_request() to return error pointers
      lib: test_objagg: Set error message in check_expect_hints_stats()

David Thompson (1):
      platform/mellanox: mlxbf-tmfifo: fix vring_desc.len assignment

Elena Popa (1):
      rtc: pcf2127: fix SPI command byte for PCF2131

Filipe Manana (5):
      btrfs: fix missing error handling when searching for inode refs during log replay
      btrfs: fix iteration of extrefs during log replay
      btrfs: propagate last_unlink_trans earlier when doing a rmdir
      btrfs: use btrfs_record_snapshot_destroy() during rmdir
      btrfs: fix qgroup reservation leak on failure to allocate ordered extent

Fushuai Wang (1):
      dpaa2-eth: fix xdp_rxq_info leak

Gabriel Santese (1):
      ASoC: amd: yc: Add quirk for MSI Bravo 17 D7VF internal mic

Greg Kroah-Hartman (1):
      Linux 6.6.97

HarshaVardhana S A (1):
      vsock/vmci: Clear the vmci transport packet properly when initializing it

Heiko Stuebner (1):
      regulator: fan53555: add enable_time support and soft-start times

Hongyu Xie (1):
      xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS

Hugo Villeneuve (1):
      rtc: pcf2127: add missing semicolon after statement

James Clark (1):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer

Janne Grunau (1):
      arm64: dts: apple: t8103: Fix PCIe BCM4377 nodename

Janusz Krzysztofik (1):
      drm/i915/gt: Fix timeline left held on VMA alloc error

Jeff LaBundy (1):
      Input: iqs7222 - explicitly define number of external channels

Johannes Berg (5):
      wifi: mac80211: chan: chandef is non-NULL for reserved
      wifi: mac80211: finish link init before RCU publish
      ata: pata_cs5536: fix build on 32-bit UML
      wifi: mac80211: drop invalid source address OCB frames
      wifi: ath6kl: remove WARN on bad firmware input

Joonas Lahtinen (1):
      Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1"

Junxiao Chang (1):
      drm/i915/gsc: mei interrupt top half should be in irq disabled context

Justin Sanders (1):
      aoe: defer rexmit timer downdev work to workqueue

Kohei Enju (1):
      rose: fix dangling neighbour pointers in rose_rt_device_down()

Kuniyuki Iwashima (2):
      nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.
      Bluetooth: hci_core: Fix use-after-free in vhci_flush()

Kurt Borja (7):
      platform/x86: dell-wmi-sysman: Fix WMI data block retrieval in sysfs callbacks
      platform/x86: think-lmi: Fix class device unregistration
      platform/x86: dell-wmi-sysman: Fix class device unregistration
      platform/x86: hp-bioscfg: Fix class device unregistration
      platform/x86: think-lmi: Create ksets consecutively
      platform/x86: think-lmi: Fix kobject cleanup
      platform/x86: think-lmi: Fix sysfs group cleanup

Lion Ackermann (1):
      net/sched: Always pass notifications when child class becomes empty

Madhavan Srinivasan (2):
      powerpc: Fix struct termio related ioctl macros
      powerpc/kernel: Fix ppc_save_regs inclusion in build

Manivannan Sadhasivam (2):
      regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods
      scsi: ufs: core: Add OPP support for scaling clocks and regulators

Marek Szyprowski (1):
      drm/exynos: fimd: Guard display clock control with runtime PM calls

Mario Limonciello (1):
      platform/x86/amd/pmc: Add PCSpecialist Lafite Pro V 14M to 8042 quirks list

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

Michael J. Ruhl (1):
      i2c/designware: Fix an initialization issue

Muna Sinada (1):
      wifi: mac80211: Add link iteration macro for link data

Neil Armstrong (1):
      arm64: dts: qcom: sm8550: add UART14 nodes

Niklas Schnelle (1):
      s390/pci: Do not try re-enabling load/store if device is disabled

Nilton Perim Neto (1):
      Input: xpad - support Acer NGR 200 Controller

Oleksij Rempel (1):
      net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect

Oliver Neukum (1):
      Logitech C-270 even more broken

Pablo Martin-Gomez (1):
      mtd: spinand: fix memory leak of ECC engine conf

Patrisious Haddad (3):
      RDMA/mlx5: Fix HW counters query for non-representor devices
      RDMA/mlx5: Fix CC counters query for MPV
      RDMA/mlx5: Fix vport loopback for MPV device

Paulo Alcantara (1):
      smb: client: fix warning when reconnecting channel

Peter Chen (1):
      usb: cdnsp: do not disable slot for disabled slot

Peter Wang (1):
      scsi: ufs: core: Fix abnormal scale up after last cmd finish

Peter Zijlstra (1):
      module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper

Philipp Kerling (1):
      smb: client: fix readdir returning wrong type with POSIX extensions

RD Babiera (1):
      usb: typec: altmodes/displayport: do not index invalid pin_assignments

Rafael J. Wysocki (1):
      ACPICA: Refuse to evaluate a method if arguments are missing

Raju Rangoju (3):
      amd-xgbe: align CL37 AN sequence as per databook
      amd-xgbe: do not double read link status
      usb: xhci: quirk for data loss in ISOC transfers

Raven Black (1):
      ASoC: amd: yc: update quirk data for HP Victus

Ricardo B. Marliere (1):
      platform/x86: make fw_attr_class constant

Rob Clark (2):
      drm/msm: Fix a fence leak in submit error path
      drm/msm: Fix another leak in the submit error path

Sergey Senozhatsky (1):
      mtk-sd: reset host->mrq on prepare_data() error

Shivank Garg (1):
      fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass

Simon Xue (1):
      iommu/rockchip: prevent iommus dead loop when two masters share one IOMMU

Stefan Metzmacher (1):
      smb: client: remove \t from TP_printk statements

Takashi Iwai (2):
      ALSA: sb: Don't allow changing the DMA mode during operations
      ALSA: sb: Force to disable DMAs once when DMA mode is changed

Tasos Sahanidis (1):
      ata: libata-acpi: Do not assume 40 wire cable if no devices are enabled

Thomas Fourier (4):
      scsi: qla2xxx: Fix DMA mapping test in qla24xx_get_port_database()
      scsi: qla4xxx: Fix missing DMA mapping error in qla4xxx_alloc_pdu()
      ethernet: atl1: Add missing DMA mapping error checks and count errors
      nui: Fix dma_mapping_error() check

Thomas Weißschuh (5):
      platform/x86: firmware_attributes_class: Move include linux/device/class.h
      platform/x86: firmware_attributes_class: Simplify API
      platform/x86: think-lmi: Directly use firmware_attributes_class
      platform/x86: dell-sysman: Directly use firmware_attributes_class
      platform/x86: hp-bioscfg: Directly use firmware_attributes_class

Thomas Zimmermann (1):
      drm/simpledrm: Do not upcast in release helpers

Trond Myklebust (1):
      NFSv4/flexfiles: Fix handling of NFS level errors in I/O

Uladzislau Rezki (Sony) (1):
      rcu: Return early if callback is not specified

Ulf Hansson (1):
      Revert "mmc: sdhci: Disable SD card clock before changing parameters"

Victor Shih (1):
      mmc: sdhci: Add a helper function for dump register in dynamic debug mode

Vitaly Lifshits (1):
      igc: disable L1.2 PCI-E link substate to avoid performance issue

Wang Zhaolong (1):
      smb: client: fix race condition in negotiate timeout by using more precise timing

Xin Li (Intel) (2):
      x86/traps: Initialize DR6 by writing its architectural reset value
      drm/i915/dp_mst: Work around Thunderbolt sink disconnect after SINK_COUNT_ESI read

Xu Yang (1):
      usb: chipidea: udc: disconnect/reconnect from host when do suspend/resume

Yan Zhai (1):
      bnxt: properly flush XDP redirect lists

Yang Li (1):
      Bluetooth: Prevent unintended pause by checking if advertising is active

Zhang Rui (1):
      powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed

anvithdosapati (1):
      scsi: ufs: core: Fix clk scaling to be conditional in reset and restore

Łukasz Bartosik (1):
      xhci: dbctty: disable ECHO flag by default


