Return-Path: <stable+bounces-161599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E68B005B3
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6641C87D7D
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97CF2777F9;
	Thu, 10 Jul 2025 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p16URoD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD04277032;
	Thu, 10 Jul 2025 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158889; cv=none; b=psz2Jbqff6iSQpG94KXgFVe5FuQzNZd8sBwrXCIWTEpcfKb4WOTVq66C3IMEbMb6QBe2atVGhRmldYw5YIPi1YJ2Obx7BXJMPzn2CE2krI/KKMUNGS96EEiRCK6m4F3ls8c51qN7NKv008fzm7a0stxwcr46/mRbdHgSSbhCrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158889; c=relaxed/simple;
	bh=SL/3KuLFDf39AlfZURAblcogEzKw/0eTpwQafk4JeoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cQ0OMQR5/FGCEzGm6/KYS3GWJE0ywk2AmY7s+WatI4Tco+IU4uX/uJupSd+xVZ6yfhsTUjtA2IoW2COXbG2VXZsqYcO9guH8gCN49vIm8+AnLEi444l5yVJ4c1z1HecdCD9/9YniM/rOv3WlG/bgaHeFyCJthTsBmDWqZjsHkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p16URoD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ADCC4CEE3;
	Thu, 10 Jul 2025 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752158888;
	bh=SL/3KuLFDf39AlfZURAblcogEzKw/0eTpwQafk4JeoM=;
	h=From:To:Cc:Subject:Date:From;
	b=p16URoD1SZpK+P05f4Oklv6wpg/2UkiDVxyFfVFbOYfE6NLWv+mekgL9+DNfSAxs0
	 GkueHVibrKL5raxKKBXWGzmthGzlMzmOFnVmhGEvoNdnvZukEQAI8rXne2/e0m2bin
	 JhpgBZywUFk/81omw+j1lGVbEjSGaewx4UnH20hI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.15.6
Date: Thu, 10 Jul 2025 16:47:54 +0200
Message-ID: <2025071054-elaborate-folic-b97a@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.15.6 kernel.

All users of the 6.15 kernel series must upgrade.

The updated 6.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.15.y
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
 Documentation/core-api/symbol-namespaces.rst                    |   22 
 Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml  |    3 
 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml  |    3 
 Makefile                                                        |    2 
 arch/arm64/boot/dts/apple/spi1-nvram.dtsi                       |    2 
 arch/arm64/boot/dts/apple/t8103-j293.dts                        |    2 
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi                       |    2 
 arch/arm64/boot/dts/apple/t8103.dtsi                            |    2 
 arch/arm64/boot/dts/apple/t8112-j493.dts                        |    2 
 arch/arm64/boot/dts/apple/t8112.dtsi                            |    2 
 arch/powerpc/include/uapi/asm/ioctls.h                          |    8 
 arch/riscv/kernel/cpu_ops_sbi.c                                 |    6 
 arch/s390/pci/pci_event.c                                       |   15 
 arch/x86/Kconfig                                                |    9 
 arch/x86/entry/entry.S                                          |    8 
 arch/x86/include/asm/cpufeatures.h                              |    5 
 arch/x86/include/asm/irqflags.h                                 |    4 
 arch/x86/include/asm/kvm_host.h                                 |    1 
 arch/x86/include/asm/mwait.h                                    |   28 -
 arch/x86/include/asm/nospec-branch.h                            |   37 -
 arch/x86/kernel/cpu/amd.c                                       |   44 +
 arch/x86/kernel/cpu/bugs.c                                      |  133 +++++
 arch/x86/kernel/cpu/common.c                                    |   14 
 arch/x86/kernel/cpu/microcode/amd_shas.c                        |  112 ++++
 arch/x86/kernel/cpu/scattered.c                                 |    2 
 arch/x86/kernel/process.c                                       |   16 
 arch/x86/kvm/cpuid.c                                            |   15 
 arch/x86/kvm/reverse_cpuid.h                                    |    7 
 arch/x86/kvm/svm/vmenter.S                                      |    6 
 arch/x86/kvm/vmx/vmx.c                                          |    2 
 drivers/acpi/acpica/dsmethod.c                                  |    7 
 drivers/ata/libata-acpi.c                                       |   24 
 drivers/ata/pata_cs5536.c                                       |    2 
 drivers/ata/pata_via.c                                          |    6 
 drivers/base/cpu.c                                              |    3 
 drivers/block/aoe/aoe.h                                         |    1 
 drivers/block/aoe/aoecmd.c                                      |    8 
 drivers/block/aoe/aoedev.c                                      |    5 
 drivers/dma-buf/dma-resv.c                                      |   12 
 drivers/firmware/arm_ffa/driver.c                               |   71 +-
 drivers/firmware/samsung/exynos-acpm.c                          |   25 -
 drivers/gpu/drm/bridge/aux-hpd-bridge.c                         |    3 
 drivers/gpu/drm/bridge/panel.c                                  |    5 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                        |   12 
 drivers/gpu/drm/i915/gt/intel_gsc.c                             |    2 
 drivers/gpu/drm/i915/gt/intel_ring_submission.c                 |    3 
 drivers/gpu/drm/i915/selftests/i915_request.c                   |   20 
 drivers/gpu/drm/i915/selftests/mock_request.c                   |    2 
 drivers/gpu/drm/msm/msm_gem_submit.c                            |   17 
 drivers/gpu/drm/v3d/v3d_drv.h                                   |    8 
 drivers/gpu/drm/v3d/v3d_gem.c                                   |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                                   |   37 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                             |    2 
 drivers/gpu/drm/xe/Kconfig                                      |    3 
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h                           |    1 
 drivers/gpu/drm/xe/xe_device.c                                  |   72 +-
 drivers/gpu/drm/xe/xe_guc_ads.c                                 |    5 
 drivers/gpu/drm/xe/xe_guc_pc.c                                  |  249 +++++++---
 drivers/gpu/drm/xe/xe_guc_pc.h                                  |    2 
 drivers/gpu/drm/xe/xe_guc_pc_types.h                            |    2 
 drivers/gpu/drm/xe/xe_migrate.c                                 |   18 
 drivers/gpu/drm/xe/xe_wa_oob.rules                              |    6 
 drivers/hid/hid-appletb-kbd.c                                   |   14 
 drivers/i2c/busses/i2c-designware-master.c                      |    1 
 drivers/infiniband/hw/mlx5/counters.c                           |    4 
 drivers/infiniband/hw/mlx5/devx.c                               |   10 
 drivers/infiniband/hw/mlx5/main.c                               |   33 +
 drivers/infiniband/hw/mlx5/mr.c                                 |   61 +-
 drivers/infiniband/hw/mlx5/odp.c                                |    8 
 drivers/input/joystick/xpad.c                                   |    2 
 drivers/input/misc/cs40l50-vibra.c                              |    2 
 drivers/input/misc/iqs7222.c                                    |    7 
 drivers/iommu/intel/cache.c                                     |    5 
 drivers/iommu/intel/iommu.c                                     |   11 
 drivers/iommu/intel/iommu.h                                     |    2 
 drivers/iommu/rockchip-iommu.c                                  |    3 
 drivers/mmc/core/quirks.h                                       |   12 
 drivers/mmc/core/sd_uhs2.c                                      |    4 
 drivers/mmc/host/mtk-sd.c                                       |   21 
 drivers/mmc/host/sdhci-uhs2.c                                   |   20 
 drivers/mmc/host/sdhci.c                                        |    9 
 drivers/mmc/host/sdhci.h                                        |   16 
 drivers/mtd/nand/spi/core.c                                     |    1 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                     |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                       |   13 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c                     |   24 
 drivers/net/ethernet/amd/xgbe/xgbe.h                            |    4 
 drivers/net/ethernet/atheros/atlx/atl1.c                        |   79 ++-
 drivers/net/ethernet/cisco/enic/enic_main.c                     |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                |   26 -
 drivers/net/ethernet/intel/idpf/idpf_controlq.c                 |   23 
 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h             |    2 
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c                  |    4 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                      |   12 
 drivers/net/ethernet/intel/igc/igc_main.c                       |   10 
 drivers/net/ethernet/sun/niu.c                                  |   31 +
 drivers/net/ethernet/sun/niu.h                                  |    4 
 drivers/net/ethernet/wangxun/libwx/wx_lib.c                     |    1 
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c                  |    2 
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c                 |   22 
 drivers/net/usb/lan78xx.c                                       |    2 
 drivers/net/virtio_net.c                                        |   60 ++
 drivers/net/wireless/ath/ath6kl/bmi.c                           |    4 
 drivers/nvme/host/core.c                                        |    2 
 drivers/nvme/host/multipath.c                                   |    3 
 drivers/nvme/host/pci.c                                         |    6 
 drivers/nvme/target/nvmet.h                                     |    2 
 drivers/platform/mellanox/mlxbf-pmc.c                           |    2 
 drivers/platform/mellanox/mlxbf-tmfifo.c                        |    3 
 drivers/platform/mellanox/mlxreg-lc.c                           |    2 
 drivers/platform/mellanox/nvsw-sn2201.c                         |    2 
 drivers/platform/x86/amd/hsmp/hsmp.c                            |    6 
 drivers/platform/x86/amd/pmc/pmc-quirks.c                       |    9 
 drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c     |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c      |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c  |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c   |    5 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c              |   12 
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                    |    4 
 drivers/platform/x86/think-lmi.c                                |   94 +--
 drivers/platform/x86/wmi.c                                      |   16 
 drivers/powercap/intel_rapl_common.c                            |   18 
 drivers/regulator/fan53555.c                                    |   14 
 drivers/regulator/gpio-regulator.c                              |    8 
 drivers/rtc/rtc-cmos.c                                          |   10 
 drivers/rtc/rtc-pcf2127.c                                       |    7 
 drivers/scsi/hosts.c                                            |   18 
 drivers/scsi/qla2xxx/qla_mbx.c                                  |    2 
 drivers/scsi/qla4xxx/ql4_os.c                                   |    2 
 drivers/scsi/sd.c                                               |    2 
 drivers/spi/spi-fsl-dspi.c                                      |   11 
 drivers/spi/spi-qpic-snand.c                                    |   16 
 drivers/target/target_core_pr.c                                 |    4 
 drivers/tee/optee/ffa_abi.c                                     |   41 +
 drivers/tee/optee/optee_private.h                               |    2 
 drivers/ufs/core/ufs-sysfs.c                                    |    4 
 drivers/usb/cdns3/cdnsp-debug.h                                 |    5 
 drivers/usb/cdns3/cdnsp-ep0.c                                   |   18 
 drivers/usb/cdns3/cdnsp-gadget.h                                |    6 
 drivers/usb/cdns3/cdnsp-ring.c                                  |    7 
 drivers/usb/chipidea/udc.c                                      |    7 
 drivers/usb/core/hub.c                                          |    3 
 drivers/usb/core/quirks.c                                       |    3 
 drivers/usb/core/usb-acpi.c                                     |    4 
 drivers/usb/dwc3/core.c                                         |    9 
 drivers/usb/dwc3/gadget.c                                       |   24 
 drivers/usb/host/xhci-dbgcap.c                                  |    4 
 drivers/usb/host/xhci-dbgtty.c                                  |    1 
 drivers/usb/host/xhci-mem.c                                     |    4 
 drivers/usb/host/xhci-pci.c                                     |   25 +
 drivers/usb/host/xhci-plat.c                                    |    3 
 drivers/usb/host/xhci-ring.c                                    |    5 
 drivers/usb/host/xhci.c                                         |   31 -
 drivers/usb/host/xhci.h                                         |    3 
 drivers/usb/typec/altmodes/displayport.c                        |    5 
 fs/anon_inodes.c                                                |   23 
 fs/btrfs/block-group.h                                          |    2 
 fs/btrfs/free-space-tree.c                                      |   40 +
 fs/btrfs/inode.c                                                |   36 -
 fs/btrfs/ioctl.c                                                |    4 
 fs/btrfs/tree-log.c                                             |  137 ++---
 fs/exec.c                                                       |    9 
 fs/libfs.c                                                      |    8 
 fs/namei.c                                                      |    2 
 fs/netfs/buffered_write.c                                       |    2 
 fs/netfs/direct_write.c                                         |    8 
 fs/netfs/misc.c                                                 |   26 -
 fs/netfs/write_retry.c                                          |    2 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |  120 +++-
 fs/nfs/inode.c                                                  |   17 
 fs/nfs/pnfs.c                                                   |    4 
 fs/smb/client/cifsglob.h                                        |    2 
 fs/smb/client/cifsproto.h                                       |    1 
 fs/smb/client/cifssmb.c                                         |    2 
 fs/smb/client/connect.c                                         |   15 
 fs/smb/client/fs_context.c                                      |   17 
 fs/smb/client/misc.c                                            |    6 
 fs/smb/client/readdir.c                                         |    2 
 fs/smb/client/reparse.c                                         |   22 
 fs/smb/client/smb2pdu.c                                         |   11 
 fs/xfs/xfs_rtalloc.c                                            |    2 
 include/linux/arm_ffa.h                                         |    1 
 include/linux/cpu.h                                             |    1 
 include/linux/export.h                                          |   12 
 include/linux/fs.h                                              |    2 
 include/linux/libata.h                                          |    7 
 include/linux/usb.h                                             |    2 
 include/linux/usb/typec_dp.h                                    |    1 
 include/trace/events/netfs.h                                    |    1 
 kernel/irq/irq_sim.c                                            |    2 
 kernel/rcu/tree.c                                               |    4 
 lib/test_objagg.c                                               |    4 
 mm/secretmem.c                                                  |    9 
 mm/vmalloc.c                                                    |   63 +-
 net/bluetooth/hci_event.c                                       |   36 -
 net/bluetooth/hci_sync.c                                        |  227 +++++----
 net/bluetooth/mgmt.c                                            |   25 -
 net/ipv4/ip_input.c                                             |    7 
 net/mac80211/rx.c                                               |    4 
 net/rose/rose_route.c                                           |   15 
 net/sched/sch_api.c                                             |   19 
 net/vmw_vsock/vmci_transport.c                                  |    4 
 sound/isa/sb/sb16_main.c                                        |    7 
 sound/soc/amd/yc/acp6x-mach.c                                   |   14 
 tools/testing/selftests/iommu/iommufd.c                         |   32 -
 tools/testing/selftests/iommu/iommufd_utils.h                   |    9 
 212 files changed, 2310 insertions(+), 984 deletions(-)

Ahmed Zaki (1):
      idpf: convert control queue mutex to a spinlock

Alok Tiwari (5):
      platform/mellanox: mlxbf-pmc: Fix duplicate event ID for CACHE_DATA1
      platform/mellanox: nvsw-sn2201: Fix bus number in adapter error message
      nvme: Fix incorrect cdw15 value in passthru error logging
      platform/mellanox: mlxreg-lc: Fix logic error in power state check
      enic: fix incorrect MTU comparison in enic_change_mtu()

Andrei Kuchynski (1):
      usb: typec: displayport: Fix potential deadlock

Antoine Tenart (1):
      net: ipv4: fix stat increase when udp early demux drops the packet

Armin Wolf (1):
      platform/x86: wmi: Fix WMI event enablement

Arnd Bergmann (1):
      RDMA/mlx5: reduce stack usage in mlx5_ib_ufile_hw_cleanup

Avri Altman (1):
      mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier

Bart Van Assche (1):
      scsi: ufs: core: Fix spelling of a sysfs attribute name

Benjamin Coddington (1):
      NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN

Borislav Petkov (1):
      KVM: x86: Sort CPUID_8000_0021_EAX leaf bits properly

Borislav Petkov (AMD) (5):
      x86/bugs: Rename MDS machinery to something more generic
      x86/bugs: Add a Transient Scheduler Attacks mitigation
      KVM: SVM: Advertise TSA CPUID bits to guests
      x86/microcode/AMD: Add TSA microcode SHAs
      x86/process: Move the buffer clearing before MONITOR

Bui Quang Minh (2):
      virtio-net: xsk: rx: fix the frame's length check
      virtio-net: ensure the received length does not exceed allocated size

Christian Brauner (1):
      anon_inode: rework assertions

Christian Eggers (4):
      Bluetooth: HCI: Set extended advertising data synchronously
      Bluetooth: hci_sync: revert some mesh modifications
      Bluetooth: MGMT: set_mesh: update LE scan interval and window
      Bluetooth: MGMT: mesh_send: check instances prior disabling advertising

Christian König (1):
      dma-buf: fix timeout handling in dma_resv_wait_timeout v2

Christoph Hellwig (1):
      scsi: core: Enforce unlimited max_segment_size when virt_boundary_mask is set

Dan Carpenter (2):
      drm/i915/selftests: Change mock_request() to return error pointers
      lib: test_objagg: Set error message in check_expect_hints_stats()

Darrick J. Wong (1):
      xfs: actually use the xfs_growfs_check_rtgeom tracepoint

David Howells (5):
      netfs: Fix hang due to missing case in final DIO read result collection
      netfs: Fix looping in wait functions
      netfs: Fix ref leak on inserted extra subreq in write retry
      netfs: Fix i_size updating
      netfs: Fix double put of request

David Thompson (1):
      platform/mellanox: mlxbf-tmfifo: fix vring_desc.len assignment

Dmitry Baryshkov (2):
      drm/bridge: panel: move prepare_prev_first handling to drm_panel_bridge_add_typed
      drm/bridge: aux-hpd-bridge: fix assignment of the of_node

Dmitry Bogdanov (1):
      nvmet: fix memory leak of bio integrity

Elena Popa (1):
      rtc: pcf2127: fix SPI command byte for PCF2131

Eugen Hristev (1):
      nvme-pci: refresh visible attrs after being checked

Filipe Manana (7):
      btrfs: fix failure to rebuild free space tree using multiple transactions
      btrfs: fix missing error handling when searching for inode refs during log replay
      btrfs: fix iteration of extrefs during log replay
      btrfs: fix inode lookup error handling during log replay
      btrfs: record new subvolume in parent dir earlier to avoid dir logging races
      btrfs: propagate last_unlink_trans earlier when doing a rmdir
      btrfs: use btrfs_record_snapshot_destroy() during rmdir

Fushuai Wang (1):
      dpaa2-eth: fix xdp_rxq_info leak

Gabor Juhos (1):
      spi: spi-qpic-snand: reallocate BAM transactions

Gabriel Santese (1):
      ASoC: amd: yc: Add quirk for MSI Bravo 17 D7VF internal mic

Geliang Tang (1):
      nvme-multipath: fix suspicious RCU usage warning

Greg Kroah-Hartman (1):
      Linux 6.15.6

Gyeyoung Baek (1):
      genirq/irq_sim: Initialize work context pointers properly

Harry Austen (1):
      drm/xe: Allow dropping kunit dependency as built-in

HarshaVardhana S A (1):
      vsock/vmci: Clear the vmci transport packet properly when initializing it

Heikki Krogerus (1):
      usb: acpi: fix device link removal

Heiko Stuebner (1):
      regulator: fan53555: add enable_time support and soft-start times

Hongyu Xie (1):
      xhci: Disable stream for xHC controller with XHCI_BROKEN_STREAMS

Hugo Villeneuve (1):
      rtc: pcf2127: add missing semicolon after statement

Jake Hillion (1):
      x86/platform/amd: move final timeout check to after final sleep

James Clark (1):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer

Janne Grunau (1):
      arm64: dts: apple: t8103: Fix PCIe BCM4377 nodename

Janusz Krzysztofik (1):
      drm/i915/gt: Fix timeline left held on VMA alloc error

Jeff LaBundy (1):
      Input: iqs7222 - explicitly define number of external channels

Jens Wiklander (1):
      optee: ffa: fix sleep in atomic context

Jeongjun Park (1):
      mm/vmalloc: fix data race in show_numa_info()

Jia Yao (1):
      drm/xe: Fix out-of-bounds field write in MI_STORE_DATA_IMM

Jiawen Wu (2):
      net: txgbe: request MISC IRQ in ndo_open
      net: libwx: fix the incorrect display of the queue number

Johannes Berg (3):
      ata: pata_cs5536: fix build on 32-bit UML
      wifi: mac80211: drop invalid source address OCB frames
      wifi: ath6kl: remove WARN on bad firmware input

John Harrison (1):
      drm/xe/guc: Enable w/a 16026508708

Junxiao Chang (1):
      drm/i915/gsc: mei interrupt top half should be in irq disabled context

Justin Sanders (1):
      aoe: defer rexmit timer downdev work to workqueue

Kohei Enju (1):
      rose: fix dangling neighbour pointers in rose_rt_device_down()

Krzysztof Kozlowski (2):
      dt-bindings: net: sophgo,sg2044-dwmac: Drop status from the example
      dt-bindings: i2c: realtek,rtl9301: Fix missing 'reg' constraint

Kuen-Han Tsai (1):
      usb: dwc3: Abort suspend on soft disconnect failure

Kuniyuki Iwashima (1):
      nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.

Kurt Borja (7):
      platform/x86: dell-wmi-sysman: Fix WMI data block retrieval in sysfs callbacks
      platform/x86: hp-bioscfg: Fix class device unregistration
      platform/x86: think-lmi: Fix class device unregistration
      platform/x86: dell-wmi-sysman: Fix class device unregistration
      platform/x86: think-lmi: Create ksets consecutively
      platform/x86: think-lmi: Fix kobject cleanup
      platform/x86: think-lmi: Fix sysfs group cleanup

Lion Ackermann (1):
      net/sched: Always pass notifications when child class becomes empty

Lu Baolu (1):
      iommu/vt-d: Assign devtlb cache tag on ATS enablement

Lucas De Marchi (2):
      drm/xe/guc_pc: Add _locked variant for min/max freq
      drm/xe: Split xe_device_td_flush()

Madhavan Srinivasan (1):
      powerpc: Fix struct termio related ioctl macros

Manivannan Sadhasivam (1):
      regulator: gpio: Fix the out-of-bounds access to drvdata::gpiods

Marek Szyprowski (1):
      drm/exynos: fimd: Guard display clock control with runtime PM calls

Mario Limonciello (1):
      platform/x86/amd/pmc: Add PCSpecialist Lafite Pro V 14M to 8042 quirks list

Mark Zhang (1):
      RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert

Marko Kiiskila (1):
      drm/vmwgfx: Fix guests running with TDX/SEV

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

Michal Swiatkowski (1):
      idpf: return 0 size for RSS key if not supported

Nicolin Chen (3):
      iommufd/selftest: Add missing close(mfd) in memfd_mmap()
      iommufd/selftest: Add asserts testing global mfd
      iommufd/selftest: Fix iommufd_dirty_tracking with large hugepage sizes

Niklas Schnelle (2):
      s390/pci: Fix stale function handles in error handling
      s390/pci: Do not try re-enabling load/store if device is disabled

Nilton Perim Neto (1):
      Input: xpad - support Acer NGR 200 Controller

Oleksij Rempel (1):
      net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect

Oliver Neukum (1):
      Logitech C-270 even more broken

Or Har-Toov (2):
      RDMA/mlx5: Fix unsafe xarray access in implicit ODP handling
      IB/mlx5: Fix potential deadlock in MR deregistration

Pablo Martin-Gomez (1):
      mtd: spinand: fix memory leak of ECC engine conf

Patrisious Haddad (3):
      RDMA/mlx5: Fix HW counters query for non-representor devices
      RDMA/mlx5: Fix CC counters query for MPV
      RDMA/mlx5: Fix vport loopback for MPV device

Paulo Alcantara (5):
      smb: client: fix warning when reconnecting channel
      smb: client: set missing retry flag in smb2_writev_callback()
      smb: client: set missing retry flag in cifs_readv_callback()
      smb: client: set missing retry flag in cifs_writev_callback()
      smb: client: fix native SMB symlink traversal

Pawel Laszczak (1):
      usb: cdnsp: Fix issue with CV Bad Descriptor test

Peter Chen (1):
      usb: cdnsp: do not disable slot for disabled slot

Peter Zijlstra (1):
      module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper

Philipp Kerling (1):
      smb: client: fix readdir returning wrong type with POSIX extensions

Qasim Ijaz (2):
      HID: appletb-kbd: fix memory corruption of input_handler_list
      HID: appletb-kbd: fix slab use-after-free bug in appletb_kbd_probe

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

Rob Clark (2):
      drm/msm: Fix a fence leak in submit error path
      drm/msm: Fix another leak in the submit error path

Roy Luo (2):
      usb: xhci: Skip xhci_reset in xhci_resume if xhci is being removed
      Revert "usb: xhci: Implement xhci_handshake_check_state() helper"

SCHNEIDER Johannes (1):
      usb: dwc3: gadget: Fix TRB reclaim logic for short transfers and ZLPs

Sergey Senozhatsky (1):
      mtk-sd: reset host->mrq on prepare_data() error

Shivank Garg (1):
      fs: export anon_inode_make_secure_inode() and fix secretmem LSM bypass

Shyam Prasad N (1):
      cifs: all initializations for tcon should happen in tcon_info_alloc

Simon Xue (1):
      iommu/rockchip: prevent iommus dead loop when two masters share one IOMMU

Sudeep Holla (3):
      firmware: arm_ffa: Fix memory leak by freeing notifier callback node
      firmware: arm_ffa: Move memory allocation outside the mutex locking
      firmware: arm_ffa: Replace mutex with rwlock to avoid sleep in atomic context

Sven Peter (2):
      arm64: dts: apple: Drop {address,size}-cells from SPI NOR
      arm64: dts: apple: Move touchbar mipi {address,size}-cells from dtsi to dts

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

Tigran Mkrtchyan (1):
      flexfiles/pNFS: update stats on NFS4ERR_DELAY for v4.1 DSes

Trond Myklebust (1):
      NFSv4/flexfiles: Fix handling of NFS level errors in I/O

Tudor Ambarus (1):
      firmware: exynos-acpm: fix timeouts on xfers handling

Uladzislau Rezki (Sony) (1):
      rcu: Return early if callback is not specified

Ulf Hansson (1):
      Revert "mmc: sdhci: Disable SD card clock before changing parameters"

Victor Shih (3):
      mmc: sdhci: Add a helper function for dump register in dynamic debug mode
      mmc: sdhci-uhs2: Adjust some error messages and register dump for SD UHS-II card
      mmc: core: Adjust some error messages for SD UHS-II cards

Vinay Belgaumkar (2):
      drm/xe/bmg: Update Wa_14022085890
      drm/xe/bmg: Update Wa_22019338487

Viresh Kumar (1):
      firmware: arm_ffa: Fix the missing entry in struct ffa_indirect_msg_hdr

Vitaly Lifshits (1):
      igc: disable L1.2 PCI-E link substate to avoid performance issue

Vivian Wang (1):
      riscv: cpu_ops_sbi: Use static array for boot_data

Wang Zhaolong (1):
      smb: client: fix race condition in negotiate timeout by using more precise timing

Xu Yang (1):
      usb: chipidea: udc: disconnect/reconnect from host when do suspend/resume

Yang Li (1):
      Bluetooth: Prevent unintended pause by checking if advertising is active

Yunshui Jiang (1):
      Input: cs40l50-vibra - fix potential NULL dereference in cs40l50_upload_owt()

Zhang Rui (1):
      powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed

jackysliu (1):
      scsi: sd: Fix VPD page 0xb7 length check

Łukasz Bartosik (1):
      xhci: dbctty: disable ECHO flag by default


