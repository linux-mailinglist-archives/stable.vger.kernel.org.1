Return-Path: <stable+bounces-161592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF7DB00593
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C485A0D9B
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C529274670;
	Thu, 10 Jul 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+nf+l9F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46059274667;
	Thu, 10 Jul 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158843; cv=none; b=Lb9VPx6/cwfBjt0YRe+8Gldjt37az0aYqjXKZhsPrsfWlJV0eFmXcjtq2StUKS4FimdCOuLh13pXhCYCMdBShnVetAFUdLK0CyVgyNaXFiq9dJ5ZA7Ms17fjveiiwFU/b6GpOKyKLU83qsek6NHcoJgF0+zOwPg5Xauqay/WMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158843; c=relaxed/simple;
	bh=M3zfgmi2paPbyommEhKTl8QOYvB4fxr/6zVR4Zp5+J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lo66CXssqW03Mli2GHBIW2rP/mdsqSlzyGshBz4Ow4vc9OFM6p2VqTQZAlbxKTbuBBFvDxuu2IX0TgA8rtN3Uv3EM6OV1y1F6r06es0cnP2b9luPP0gaM1px799mLKrXmkue44+lZNLbWEM9GdhLYcps486SSx3tajCskcJ7TDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S+nf+l9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60800C4CEF4;
	Thu, 10 Jul 2025 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752158842;
	bh=M3zfgmi2paPbyommEhKTl8QOYvB4fxr/6zVR4Zp5+J0=;
	h=From:To:Cc:Subject:Date:From;
	b=S+nf+l9FYKAd8wKHo985q9L4VyC1POafG1ICHBkwyQCYh7DXGRd13uzCUB9FtTfbA
	 3w1mJhyVZQDHtd+PxfUKib9zQauq/2oNP0Z9DLXCtQvTnbLWNboF1Ir8Gr/tmPtVDt
	 DwKArYDmm/mbvROKtAz0zxHXTlAkKgNh/7Ny6flE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.144
Date: Thu, 10 Jul 2025 16:47:17 +0200
Message-ID: <2025071018-scorn-outshoot-944a@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.144 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu              |    1 
 Documentation/ABI/testing/sysfs-driver-ufs                      |    2 
 Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst |    4 
 Documentation/admin-guide/kernel-parameters.txt                 |   13 
 Makefile                                                        |    2 
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi                       |    2 
 arch/powerpc/include/uapi/asm/ioctls.h                          |    8 
 arch/s390/pci/pci_event.c                                       |    4 
 arch/x86/Kconfig                                                |    9 
 arch/x86/entry/entry.S                                          |    8 
 arch/x86/include/asm/cpu.h                                      |   12 
 arch/x86/include/asm/cpufeatures.h                              |    6 
 arch/x86/include/asm/irqflags.h                                 |    4 
 arch/x86/include/asm/mwait.h                                    |   19 -
 arch/x86/include/asm/nospec-branch.h                            |   39 +-
 arch/x86/kernel/cpu/amd.c                                       |   58 ++++
 arch/x86/kernel/cpu/bugs.c                                      |  133 +++++++++-
 arch/x86/kernel/cpu/common.c                                    |   14 -
 arch/x86/kernel/cpu/scattered.c                                 |    2 
 arch/x86/kernel/process.c                                       |   15 -
 arch/x86/kvm/cpuid.c                                            |    9 
 arch/x86/kvm/reverse_cpuid.h                                    |    8 
 arch/x86/kvm/svm/vmenter.S                                      |    6 
 arch/x86/kvm/vmx/vmx.c                                          |    2 
 drivers/acpi/acpica/dsmethod.c                                  |    7 
 drivers/ata/libata-acpi.c                                       |   24 +
 drivers/ata/pata_cs5536.c                                       |    2 
 drivers/ata/pata_via.c                                          |    6 
 drivers/base/cpu.c                                              |    7 
 drivers/block/aoe/aoe.h                                         |    1 
 drivers/block/aoe/aoecmd.c                                      |    8 
 drivers/block/aoe/aoedev.c                                      |    5 
 drivers/dma-buf/dma-resv.c                                      |   12 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                        |   12 
 drivers/gpu/drm/i915/gt/intel_gsc.c                             |    2 
 drivers/gpu/drm/i915/gt/intel_ring_submission.c                 |    3 
 drivers/gpu/drm/i915/selftests/i915_request.c                   |   20 -
 drivers/gpu/drm/i915/selftests/mock_request.c                   |    2 
 drivers/gpu/drm/msm/msm_gem_submit.c                            |   17 +
 drivers/gpu/drm/v3d/v3d_drv.h                                   |    8 
 drivers/gpu/drm/v3d/v3d_gem.c                                   |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                                   |   37 ++
 drivers/i2c/busses/i2c-designware-master.c                      |    1 
 drivers/infiniband/hw/mlx5/counters.c                           |    2 
 drivers/infiniband/hw/mlx5/devx.c                               |    2 
 drivers/mmc/core/quirks.h                                       |   12 
 drivers/mmc/host/mtk-sd.c                                       |   21 +
 drivers/mmc/host/sdhci.c                                        |    9 
 drivers/mmc/host/sdhci.h                                        |   16 +
 drivers/mtd/nand/spi/core.c                                     |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                     |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                       |    9 
 drivers/net/ethernet/amd/xgbe/xgbe.h                            |    4 
 drivers/net/ethernet/atheros/atlx/atl1.c                        |   79 ++++-
 drivers/net/ethernet/cisco/enic/enic_main.c                     |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                |   26 +
 drivers/net/ethernet/intel/igc/igc_main.c                       |   10 
 drivers/net/ethernet/sun/niu.c                                  |   31 ++
 drivers/net/ethernet/sun/niu.h                                  |    4 
 drivers/net/usb/lan78xx.c                                       |    2 
 drivers/net/virtio_net.c                                        |   38 ++
 drivers/net/wireless/ath/ath6kl/bmi.c                           |    4 
 drivers/platform/mellanox/mlxbf-tmfifo.c                        |    3 
 drivers/platform/mellanox/mlxreg-lc.c                           |    2 
 drivers/platform/mellanox/nvsw-sn2201.c                         |    2 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c      |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c  |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c   |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c              |   12 
 drivers/platform/x86/think-lmi.c                                |   53 ++-
 drivers/regulator/gpio-regulator.c                              |    8 
 drivers/rtc/rtc-cmos.c                                          |   10 
 drivers/scsi/qla2xxx/qla_mbx.c                                  |    2 
 drivers/scsi/qla4xxx/ql4_os.c                                   |    2 
 drivers/spi/spi-fsl-dspi.c                                      |   11 
 drivers/target/target_core_pr.c                                 |    4 
 drivers/ufs/core/ufs-sysfs.c                                    |    4 
 drivers/usb/cdns3/cdnsp-ring.c                                  |    4 
 drivers/usb/core/quirks.c                                       |    3 
 drivers/usb/host/xhci-dbgcap.c                                  |    4 
 drivers/usb/host/xhci-dbgtty.c                                  |    1 
 drivers/usb/host/xhci-plat.c                                    |    3 
 drivers/usb/typec/altmodes/displayport.c                        |    5 
 fs/btrfs/inode.c                                                |    7 
 fs/btrfs/tree-log.c                                             |    8 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |  121 ++++++---
 fs/nfs/inode.c                                                  |   17 +
 fs/nfs/pnfs.c                                                   |    4 
 fs/smb/client/cifsglob.h                                        |    1 
 fs/smb/client/connect.c                                         |    7 
 include/linux/cpu.h                                             |    1 
 include/linux/libata.h                                          |    7 
 include/linux/usb/typec_dp.h                                    |    1 
 kernel/rcu/tree.c                                               |    4 
 lib/test_objagg.c                                               |    4 
 net/bluetooth/hci_sync.c                                        |   20 -
 net/bluetooth/mgmt.c                                            |   25 +
 net/mac80211/rx.c                                               |    4 
 net/rose/rose_route.c                                           |   15 -
 net/sched/sch_api.c                                             |   19 -
 net/vmw_vsock/vmci_transport.c                                  |    4 
 sound/isa/sb/sb16_main.c                                        |    7 
 sound/soc/amd/yc/acp6x-mach.c                                   |    7 
 105 files changed, 970 insertions(+), 303 deletions(-)

Alok Tiwari (3):
      platform/mellanox: nvsw-sn2201: Fix bus number in adapter error message
      platform/mellanox: mlxreg-lc: Fix logic error in power state check
      enic: fix incorrect MTU comparison in enic_change_mtu()

Andrei Kuchynski (1):
      usb: typec: displayport: Fix potential deadlock

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

Bui Quang Minh (1):
      virtio-net: ensure the received length does not exceed allocated size

Christian Eggers (3):
      Bluetooth: hci_sync: revert some mesh modifications
      Bluetooth: MGMT: set_mesh: update LE scan interval and window
      Bluetooth: MGMT: mesh_send: check instances prior disabling advertising

Christian König (1):
      dma-buf: fix timeout handling in dma_resv_wait_timeout v2

Dan Carpenter (2):
      drm/i915/selftests: Change mock_request() to return error pointers
      lib: test_objagg: Set error message in check_expect_hints_stats()

David Thompson (1):
      platform/mellanox: mlxbf-tmfifo: fix vring_desc.len assignment

Filipe Manana (3):
      btrfs: fix missing error handling when searching for inode refs during log replay
      btrfs: fix iteration of extrefs during log replay
      btrfs: use btrfs_record_snapshot_destroy() during rmdir

Fushuai Wang (1):
      dpaa2-eth: fix xdp_rxq_info leak

Greg Kroah-Hartman (1):
      Linux 6.1.144

HarshaVardhana S A (1):
      vsock/vmci: Clear the vmci transport packet properly when initializing it

Hongyu Xie (1):
      xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS

James Clark (1):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer

Janne Grunau (1):
      arm64: dts: apple: t8103: Fix PCIe BCM4377 nodename

Janusz Krzysztofik (1):
      drm/i915/gt: Fix timeline left held on VMA alloc error

Johannes Berg (3):
      ata: pata_cs5536: fix build on 32-bit UML
      wifi: mac80211: drop invalid source address OCB frames
      wifi: ath6kl: remove WARN on bad firmware input

Junxiao Chang (1):
      drm/i915/gsc: mei interrupt top half should be in irq disabled context

Justin Sanders (1):
      aoe: defer rexmit timer downdev work to workqueue

Kohei Enju (1):
      rose: fix dangling neighbour pointers in rose_rt_device_down()

Kuniyuki Iwashima (1):
      nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.

Kurt Borja (5):
      platform/x86: dell-wmi-sysman: Fix WMI data block retrieval in sysfs callbacks
      platform/x86: think-lmi: Fix class device unregistration
      platform/x86: dell-wmi-sysman: Fix class device unregistration
      platform/x86: think-lmi: Create ksets consecutively
      platform/x86: think-lmi: Fix kobject cleanup

Lion Ackermann (1):
      net/sched: Always pass notifications when child class becomes empty

Madhavan Srinivasan (1):
      powerpc: Fix struct termio related ioctl macros

Manivannan Sadhasivam (1):
      regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods

Marek Szyprowski (1):
      drm/exynos: fimd: Guard display clock control with runtime PM calls

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

Niklas Schnelle (1):
      s390/pci: Do not try re-enabling load/store if device is disabled

Oleksij Rempel (1):
      net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect

Oliver Neukum (1):
      Logitech C-270 even more broken

Pablo Martin-Gomez (1):
      mtd: spinand: fix memory leak of ECC engine conf

Patrisious Haddad (1):
      RDMA/mlx5: Fix CC counters query for MPV

Peter Chen (1):
      usb: cdnsp: do not disable slot for disabled slot

RD Babiera (1):
      usb: typec: altmodes/displayport: do not index invalid pin_assignments

Rafael J. Wysocki (1):
      ACPICA: Refuse to evaluate a method if arguments are missing

Raju Rangoju (1):
      amd-xgbe: align CL37 AN sequence as per databook

Raven Black (1):
      ASoC: amd: yc: update quirk data for HP Victus

Rob Clark (2):
      drm/msm: Fix a fence leak in submit error path
      drm/msm: Fix another leak in the submit error path

Sergey Senozhatsky (1):
      mtk-sd: reset host->mrq on prepare_data() error

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

Yang Li (1):
      Bluetooth: Prevent unintended pause by checking if advertising is active

Łukasz Bartosik (1):
      xhci: dbctty: disable ECHO flag by default


