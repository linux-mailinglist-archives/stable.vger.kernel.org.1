Return-Path: <stable+bounces-163279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0CB09293
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D187AFC51
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E62FD593;
	Thu, 17 Jul 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CRHlaFoA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDBA93D;
	Thu, 17 Jul 2025 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771827; cv=none; b=eQC32sm/a/z/6Z6GwstrFB8afNA25gQ0Jm7QGCiZWsnwx9R2jxa+8bYT8+ACh3ZBOLLOxfJpAeNEn8SLRH0yCv0xmkjLknDaGKNC0ZiLdJjVIMLRKeRShjbXMArtkX8k//9lu3NefJ//ucAmW89AqURD6rJkSGfsKAgjLdTugKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771827; c=relaxed/simple;
	bh=gmaEFKmCyKWMz5OoE82vHYaK+8ek4LRpgOap3L5tbm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WkFl0UicvBTDBhBOF168M1XX3/5MndmLDB4Kqlj2bQxaYdGqHHjVW0Mg26lsJq4DPl85yQCb2wWTOqGOXK4UMhR4OLOR1/UV/41qtFylv6Nx6tF5SDucoKhz89vHX88fdPKujb/uHUelzOv5XUJjgcQ2s6y3zNxjn1lSGsgjjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CRHlaFoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F43C4CEED;
	Thu, 17 Jul 2025 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752771826;
	bh=gmaEFKmCyKWMz5OoE82vHYaK+8ek4LRpgOap3L5tbm0=;
	h=From:To:Cc:Subject:Date:From;
	b=CRHlaFoAeZjOz4C0pvFlM4SY40aWK++iNRcHUQfpeLewJk0I1J9vx9BxCoY2NTWuG
	 2tPJLyb8iAY82/thsE332tM3T2hzZtKfmLYd8Spfp7/2gaXnog3j6hywaKpDrbYHny
	 afZEPYJtgrjc7YlaC7t9Evo3uaCVqsLQm88uR7ao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.240
Date: Thu, 17 Jul 2025 19:03:37 +0200
Message-ID: <2025071738-thinner-handprint-4e6e@gregkh>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.240 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu              |    2 
 Documentation/ABI/testing/sysfs-driver-ufs                      |    2 
 Documentation/admin-guide/hw-vuln/index.rst                     |    1 
 Documentation/admin-guide/hw-vuln/indirect-target-selection.rst |  156 +++++
 Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst |    4 
 Documentation/admin-guide/kernel-parameters.txt                 |   28 
 Documentation/devicetree/bindings/serial/8250.yaml              |    2 
 Makefile                                                        |    2 
 arch/arm64/mm/mmu.c                                             |    3 
 arch/powerpc/include/uapi/asm/ioctls.h                          |    8 
 arch/s390/Makefile                                              |    2 
 arch/s390/purgatory/Makefile                                    |    2 
 arch/um/drivers/ubd_user.c                                      |    2 
 arch/um/drivers/vector_kern.c                                   |   42 -
 arch/um/include/asm/asm-prototypes.h                            |    5 
 arch/x86/Kconfig                                                |   22 
 arch/x86/entry/entry.S                                          |    8 
 arch/x86/include/asm/alternative.h                              |   26 
 arch/x86/include/asm/cpu.h                                      |   13 
 arch/x86/include/asm/cpufeature.h                               |    5 
 arch/x86/include/asm/cpufeatures.h                              |   14 
 arch/x86/include/asm/disabled-features.h                        |    2 
 arch/x86/include/asm/irqflags.h                                 |    4 
 arch/x86/include/asm/msr-index.h                                |   13 
 arch/x86/include/asm/mwait.h                                    |   19 
 arch/x86/include/asm/nospec-branch.h                            |   50 +
 arch/x86/include/asm/required-features.h                        |    2 
 arch/x86/include/asm/text-patching.h                            |   31 +
 arch/x86/kernel/alternative.c                                   |  308 +++++++++-
 arch/x86/kernel/cpu/amd.c                                       |   58 +
 arch/x86/kernel/cpu/bugs.c                                      |  272 ++++++++
 arch/x86/kernel/cpu/common.c                                    |   77 ++
 arch/x86/kernel/cpu/mce/amd.c                                   |   15 
 arch/x86/kernel/cpu/mce/core.c                                  |    8 
 arch/x86/kernel/cpu/mce/intel.c                                 |    1 
 arch/x86/kernel/cpu/scattered.c                                 |    1 
 arch/x86/kernel/ftrace.c                                        |    4 
 arch/x86/kernel/kprobes/core.c                                  |   39 -
 arch/x86/kernel/module.c                                        |   14 
 arch/x86/kernel/process.c                                       |   15 
 arch/x86/kernel/static_call.c                                   |    2 
 arch/x86/kernel/vmlinux.lds.S                                   |    8 
 arch/x86/kvm/cpuid.c                                            |   31 -
 arch/x86/kvm/cpuid.h                                            |    1 
 arch/x86/kvm/svm/vmenter.S                                      |    3 
 arch/x86/kvm/vmx/vmx.c                                          |    2 
 arch/x86/kvm/x86.c                                              |    4 
 arch/x86/lib/retpoline.S                                        |   39 +
 arch/x86/net/bpf_jit_comp.c                                     |    8 
 arch/x86/um/asm/checksum.h                                      |    3 
 drivers/acpi/acpi_pad.c                                         |    7 
 drivers/acpi/acpica/dsmethod.c                                  |    7 
 drivers/acpi/battery.c                                          |   19 
 drivers/ata/pata_cs5536.c                                       |    2 
 drivers/atm/idt77252.c                                          |    5 
 drivers/base/cpu.c                                              |   15 
 drivers/dma-buf/dma-resv.c                                      |    2 
 drivers/dma/xilinx/xilinx_dma.c                                 |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c              |    2 
 drivers/gpu/drm/bridge/cdns-dsi.c                               |   27 
 drivers/gpu/drm/exynos/exynos7_drm_decon.c                      |    4 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                        |   12 
 drivers/gpu/drm/i915/gt/intel_ring_submission.c                 |    3 
 drivers/gpu/drm/i915/selftests/i915_request.c                   |   20 
 drivers/gpu/drm/i915/selftests/mock_request.c                   |    2 
 drivers/gpu/drm/tegra/dc.c                                      |   17 
 drivers/gpu/drm/tegra/hub.c                                     |    4 
 drivers/gpu/drm/tegra/hub.h                                     |    3 
 drivers/gpu/drm/udl/udl_drv.c                                   |    2 
 drivers/gpu/drm/v3d/v3d_drv.h                                   |    7 
 drivers/gpu/drm/v3d/v3d_gem.c                                   |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                                   |   38 -
 drivers/hid/hid-ids.h                                           |    5 
 drivers/hid/hid-quirks.c                                        |    3 
 drivers/hid/wacom_sys.c                                         |    6 
 drivers/hv/channel_mgmt.c                                       |  117 ++-
 drivers/hv/hyperv_vmbus.h                                       |   19 
 drivers/hv/vmbus_drv.c                                          |    2 
 drivers/hwmon/pmbus/max34440.c                                  |   48 +
 drivers/i2c/busses/i2c-robotfuzz-osif.c                         |    6 
 drivers/i2c/busses/i2c-tiny-usb.c                               |    6 
 drivers/iio/pressure/zpa2326.c                                  |    2 
 drivers/infiniband/core/iwcm.c                                  |   38 -
 drivers/infiniband/core/iwcm.h                                  |    2 
 drivers/infiniband/hw/mlx5/counters.c                           |    2 
 drivers/infiniband/hw/mlx5/devx.c                               |    2 
 drivers/infiniband/hw/mlx5/main.c                               |   33 +
 drivers/input/joystick/xpad.c                                   |    5 
 drivers/input/keyboard/atkbd.c                                  |    3 
 drivers/leds/led-class-multicolor.c                             |    3 
 drivers/mailbox/mailbox.c                                       |    2 
 drivers/md/bcache/super.c                                       |    7 
 drivers/md/dm-raid.c                                            |    2 
 drivers/md/md-bitmap.c                                          |    2 
 drivers/md/raid1.c                                              |    1 
 drivers/media/platform/omap3isp/ispccdc.c                       |    8 
 drivers/media/platform/omap3isp/ispstat.c                       |    6 
 drivers/media/usb/uvc/uvc_ctrl.c                                |   61 +
 drivers/mfd/max14577.c                                          |    1 
 drivers/misc/vmw_vmci/vmci_host.c                               |    9 
 drivers/mmc/host/mtk-sd.c                                       |   39 -
 drivers/mmc/host/sdhci.c                                        |    9 
 drivers/mmc/host/sdhci.h                                        |   16 
 drivers/net/can/m_can/m_can.c                                   |    2 
 drivers/net/can/m_can/tcan4x5x.c                                |    9 
 drivers/net/ethernet/amd/xgbe/xgbe-common.h                     |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c                       |    9 
 drivers/net/ethernet/amd/xgbe/xgbe.h                            |    4 
 drivers/net/ethernet/atheros/atlx/atl1.c                        |   78 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c                   |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c                   |    2 
 drivers/net/ethernet/cisco/enic/enic_main.c                     |    4 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c                |  141 +++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h                |   20 
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c            |   18 
 drivers/net/ethernet/freescale/dpaa2/dpni-cmd.h                 |    6 
 drivers/net/ethernet/freescale/dpaa2/dpni.c                     |    2 
 drivers/net/ethernet/freescale/dpaa2/dpni.h                     |    6 
 drivers/net/ethernet/freescale/enetc/enetc_hw.h                 |    2 
 drivers/net/ethernet/sun/niu.c                                  |   31 -
 drivers/net/ethernet/sun/niu.h                                  |    4 
 drivers/net/ethernet/xilinx/ll_temac_main.c                     |    2 
 drivers/net/phy/microchip.c                                     |    2 
 drivers/net/phy/smsc.c                                          |   28 
 drivers/net/usb/qmi_wwan.c                                      |    1 
 drivers/net/wireless/ath/ath6kl/bmi.c                           |    4 
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c                    |    6 
 drivers/pci/controller/cadence/pcie-cadence-ep.c                |    5 
 drivers/pci/controller/pci-hyperv.c                             |   17 
 drivers/pinctrl/qcom/pinctrl-msm.c                              |   20 
 drivers/platform/mellanox/mlxbf-tmfifo.c                        |    3 
 drivers/pwm/pwm-mediatek.c                                      |   15 
 drivers/regulator/gpio-regulator.c                              |    4 
 drivers/rtc/lib_test.c                                          |    2 
 drivers/rtc/rtc-cmos.c                                          |   10 
 drivers/scsi/qla2xxx/qla_mbx.c                                  |    2 
 drivers/scsi/qla4xxx/ql4_os.c                                   |    2 
 drivers/scsi/ufs/ufs-sysfs.c                                    |    4 
 drivers/spi/spi-fsl-dspi.c                                      |   11 
 drivers/staging/rtl8723bs/core/rtw_security.c                   |   46 -
 drivers/target/target_core_pr.c                                 |    4 
 drivers/tty/vt/vt.c                                             |    1 
 drivers/uio/uio_hv_generic.c                                    |   18 
 drivers/usb/class/cdc-wdm.c                                     |   23 
 drivers/usb/common/usb-conn-gpio.c                              |   25 
 drivers/usb/core/quirks.c                                       |    3 
 drivers/usb/core/usb.c                                          |   14 
 drivers/usb/gadget/function/f_tcm.c                             |    4 
 drivers/usb/gadget/function/u_serial.c                          |    6 
 drivers/usb/host/xhci-dbgcap.c                                  |    4 
 drivers/usb/host/xhci-dbgtty.c                                  |    1 
 drivers/usb/typec/altmodes/displayport.c                        |    5 
 drivers/usb/typec/tcpm/tcpci_maxim.c                            |   20 
 drivers/vhost/scsi.c                                            |    7 
 fs/btrfs/inode.c                                                |   36 -
 fs/btrfs/tree-log.c                                             |    4 
 fs/btrfs/volumes.c                                              |    6 
 fs/ceph/file.c                                                  |    2 
 fs/cifs/misc.c                                                  |    8 
 fs/f2fs/super.c                                                 |   30 
 fs/jfs/jfs_dmap.c                                               |   41 -
 fs/namespace.c                                                  |    8 
 fs/nfs/flexfilelayout/flexfilelayout.c                          |  121 ++-
 fs/nfs/inode.c                                                  |   17 
 fs/nfs/nfs4proc.c                                               |   12 
 fs/nfs/pnfs.c                                                   |    4 
 fs/overlayfs/util.c                                             |    4 
 fs/proc/array.c                                                 |    6 
 fs/proc/inode.c                                                 |    2 
 fs/proc/proc_sysctl.c                                           |   18 
 include/drm/spsc_queue.h                                        |    4 
 include/linux/cpu.h                                             |    3 
 include/linux/hyperv.h                                          |    2 
 include/linux/ipv6.h                                            |    1 
 include/linux/module.h                                          |    5 
 include/linux/usb/typec_dp.h                                    |    1 
 include/uapi/linux/vm_sockets.h                                 |   30 
 kernel/events/core.c                                            |    2 
 kernel/rcu/tree.c                                               |    4 
 kernel/rseq.c                                                   |   60 +
 lib/test_objagg.c                                               |    4 
 net/appletalk/ddp.c                                             |    1 
 net/atm/clip.c                                                  |   75 +-
 net/atm/resources.c                                             |    3 
 net/bluetooth/l2cap_core.c                                      |    9 
 net/ipv6/ip6_output.c                                           |    9 
 net/mac80211/rx.c                                               |    4 
 net/mac80211/util.c                                             |    2 
 net/netlink/af_netlink.c                                        |   82 +-
 net/rose/rose_route.c                                           |   15 
 net/rxrpc/call_accept.c                                         |    3 
 net/sched/sch_api.c                                             |   42 -
 net/sched/sch_sfq.c                                             |   10 
 net/tipc/topsrv.c                                               |    2 
 net/vmw_vsock/af_vsock.c                                        |   78 ++
 net/vmw_vsock/vmci_transport.c                                  |    4 
 sound/isa/sb/sb16_main.c                                        |    4 
 sound/pci/hda/hda_bind.c                                        |    2 
 sound/pci/hda/hda_intel.c                                       |    3 
 sound/soc/fsl/fsl_asrc.c                                        |    3 
 sound/usb/stream.c                                              |    2 
 tools/lib/bpf/btf_dump.c                                        |    3 
 202 files changed, 2709 insertions(+), 793 deletions(-)

Al Viro (2):
      attach_recursive_mnt(): do not lock the covering tree when sliding something under it
      fix proc_sys_compare() handling of in-lookup dentries

Alexandre Belloni (1):
      rtc: lib_test: add MODULE_LICENSE

Alexandru Ardelean (1):
      uio: uio_hv_generic: use devm_kzalloc() for private data alloc

Alexis Czezar Torreno (1):
      hwmon: (pmbus/max34440) Fix support for max34451

Alok Tiwari (2):
      enic: fix incorrect MTU comparison in enic_change_mtu()
      net: ll_temac: Fix missing tx_pending check in ethtools_set_ringparam()

Amit Sunil Dhamne (1):
      usb: typec: tcpm/tcpci_maxim: Fix bounds check in process_rx()

Andra Paraschiv (4):
      vm_sockets: Add flags field in the vsock address data structure
      vm_sockets: Add VMADDR_FLAG_TO_HOST vsock flag
      af_vsock: Set VMADDR_FLAG_TO_HOST flag on the receive path
      af_vsock: Assign the vsock transport considering the vsock address flags

Andrei Kuchynski (1):
      usb: typec: displayport: Fix potential deadlock

Andy Shevchenko (1):
      usb: Add checks for snprintf() calls in usb_alloc_dev()

Aradhya Bhatia (4):
      drm/bridge: cdns-dsi: Fix the clock variable for mode_valid()
      drm/bridge: cdns-dsi: Fix connecting to next bridge
      drm/bridge: cdns-dsi: Check return value when getting default PHY config
      drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready

Badhri Jagan Sridharan (1):
      usb: typec: tcpci_maxim: Fix uninitialized return variable

Bart Van Assche (1):
      scsi: ufs: core: Fix spelling of a sysfs attribute name

Bartosz Golaszewski (1):
      pinctrl: qcom: msm: mark certain pins as invalid for interrupts

Benjamin Coddington (1):
      NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN

Borislav Petkov (5):
      x86/bugs: Rename MDS machinery to something more generic
      x86/bugs: Add a Transient Scheduler Attacks mitigation
      KVM: x86: add support for CPUID leaf 0x80000021
      KVM: SVM: Advertise TSA CPUID bits to guests
      x86/process: Move the buffer clearing before MONITOR

Borislav Petkov (AMD) (1):
      x86/alternative: Optimize returns patching

Brett A C Sheffield (Librecast) (1):
      Revert "ipv6: save dontfrag in cork"

Brett Werling (1):
      can: tcan4x5x: fix power regulator retrieval during probe

Cezary Rojewski (1):
      ALSA: hda: Ignore unsol events for cards being shut down

Chance Yang (1):
      usb: common: usb-conn-gpio: use a unique name for usb connector device

Chao Yu (1):
      f2fs: don't over-report free space or inodes in statvfs

Chen Yufeng (1):
      usb: potential integer overflow in usbg_make_tpg()

Chia-Lin Kao (AceLan) (1):
      HID: quirks: Add quirk for 2 Chicony Electronics HP 5MP Cameras

Christian König (1):
      dma-buf: fix timeout handling in dma_resv_wait_timeout v2

Dan Carpenter (2):
      drm/i915/selftests: Change mock_request() to return error pointers
      lib: test_objagg: Set error message in check_expect_hints_stats()

Daniel Sneddon (1):
      x86/bhi: Define SPEC_CTRL_BHI_DIS_S

Daniil Dulov (1):
      wifi: zd1211rw: Fix potential NULL pointer dereference in zd_mac_tx_to_dev()

Dave Kleikamp (1):
      fs/jfs: consolidate sanity checking in dbMount

David Howells (1):
      rxrpc: Fix oops due to non-existence of prealloc backlog struct

David Thompson (1):
      platform/mellanox: mlxbf-tmfifo: fix vring_desc.len assignment

Dev Jain (1):
      arm64: Restrict pagetable teardown to avoid false warning

Dexuan Cui (1):
      PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM boot time

Dmitry Kandybka (1):
      ceph: fix possible integer overflow in ceph_zero_objects()

Dongli Zhang (1):
      vhost-scsi: protect vq->log_used with vq->mutex

Eric Biggers (1):
      x86/its: Fix build errors when CONFIG_MODULES=n

Eric Dumazet (2):
      net_sched: sch_sfq: reject invalid perturb period
      atm: clip: prevent NULL deref in clip_push()

Filipe Manana (3):
      btrfs: fix missing error handling when searching for inode refs during log replay
      btrfs: propagate last_unlink_trans earlier when doing a rmdir
      btrfs: use btrfs_record_snapshot_destroy() during rmdir

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix L2CAP MTU negotiation

Fushuai Wang (1):
      dpaa2-eth: fix xdp_rxq_info leak

George Kennedy (1):
      VMCI: check context->notify_page after call to get_user_pages_fast() to avoid GPF

Greg Kroah-Hartman (1):
      Linux 5.10.240

Gustavo A. R. Silva (1):
      net: rose: Fix fall-through warnings for Clang

Haiyang Zhang (1):
      Drivers: hv: vmbus: Fix duplicate CPU assignments within a device

Hans de Goede (1):
      Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID

HarshaVardhana S A (1):
      vsock/vmci: Clear the vmci transport packet properly when initializing it

Heinz Mauelshagen (1):
      dm-raid: fix variable in journal device check

Ioana Ciornei (2):
      dpaa2-eth: rename dpaa2_eth_xdp_release_buf into dpaa2_eth_recycle_buf
      net: dpaa2-eth: rearrange variable in dpaa2_eth_get_ethtool_stats

JP Kobryn (1):
      x86/mce: Make sure CMCI banks are cleared during shutdown on Intel

Jakub Kicinski (1):
      netlink: make sure we allow at least one dump skb

James Clark (1):
      spi: spi-fsl-dspi: Clear completion counter before initiating transfer

Jann Horn (1):
      x86/mm: Disable hugetlb page table sharing on 32-bit

Janusz Krzysztofik (1):
      drm/i915/gt: Fix timeline left held on VMA alloc error

Jay Cornwall (1):
      drm/amdkfd: Fix race in GWS queue scheduling

Johannes Berg (3):
      ata: pata_cs5536: fix build on 32-bit UML
      wifi: mac80211: drop invalid source address OCB frames
      wifi: ath6kl: remove WARN on bad firmware input

Jonathan Cameron (1):
      iio: pressure: zpa2326: Use aligned_s64 for the timestamp

Jos Wang (1):
      usb: typec: displayport: Receive DP Status Update NAK request exit dp altmode

Josh Poimboeuf (1):
      x86/alternatives: Remove faulty optimization

Junlin Yang (2):
      usb: typec: tcpci_maxim: remove redundant assignment
      usb: typec: tcpci_maxim: add terminating newlines to logging

Kaustabh Chakraborty (1):
      drm/exynos: exynos7_drm_decon: add vblank check in IRQ handling

Kees Cook (1):
      ovl: Check for NULL d_inode() in ovl_dentry_upper()

Kito Xu (1):
      net: appletalk: Fix device refcount leak in atrtr_create()

Kohei Enju (1):
      rose: fix dangling neighbour pointers in rose_rt_device_down()

Krzysztof Kozlowski (1):
      mfd: max14577: Fix wakeup source leaks on device unbind

Kuen-Han Tsai (1):
      usb: gadget: u_serial: Fix race condition in TTY wakeup

Kuniyuki Iwashima (8):
      atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().
      nfs: Clean up /proc/net/rpc/nfs when nfs_fs_proc_net_init() fails.
      netlink: Fix wraparounds of sk->sk_rmem_alloc.
      tipc: Fix use-after-free in tipc_conn_close().
      atm: clip: Fix potential null-ptr-deref in to_atmarpd().
      atm: clip: Fix memory leak of struct clip_vcc.
      atm: clip: Fix infinite recursive call of clip_push().
      netlink: Fix rmem check in netlink_broadcast_deliver().

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

Matt Reynolds (1):
      Input: xpad - add support for Amazon Game Controller

Matthew Brost (1):
      drm/sched: Increment job count before swapping tail spsc queue

Maurizio Lombardi (1):
      scsi: target: Fix NULL pointer dereference in core_scsi3_decode_spec_i_port()

Maíra Canal (1):
      drm/v3d: Disable interrupts before resetting the GPU

Michael Jeanson (1):
      rseq: Fix segfault on registration when rseq_cs is non-zero

Michal Luczaj (3):
      vsock: Fix transport_{g2h,h2g} TOCTOU
      vsock: Fix transport_* TOCTOU
      vsock: Fix IOCTL_VM_SOCKETS_GET_LOCAL_CID to check also `transport_local`

Nathan Chancellor (2):
      s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
      staging: rtl8723bs: Avoid memset() in aes_cipher() and aes_decipher()

Nicolas Pitre (1):
      vt: add missing notification when switching back to text mode

Niklas Cassel (1):
      PCI: cadence-ep: Correct PBA offset in .set_msix() callback

Nilton Perim Neto (1):
      Input: xpad - support Acer NGR 200 Controller

Oleg Nesterov (1):
      fs/proc: do_task_stat: use __for_each_thread()

Oleksij Rempel (3):
      net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
      net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
      net: phy: microchip: limit 100M workaround to link-down events on LAN88xx

Olga Kornievskaia (1):
      NFSv4.2: fix listxattr to return selinux security label

Oliver Neukum (1):
      Logitech C-270 even more broken

Pali Rohár (1):
      cifs: Fix cifs_query_path_info() for Windows NT servers

Patrisious Haddad (2):
      RDMA/mlx5: Fix CC counters query for MPV
      RDMA/mlx5: Fix vport loopback for MPV device

Pawan Gupta (7):
      Documentation: x86/bugs/its: Add ITS documentation
      x86/its: Enumerate Indirect Target Selection (ITS) bug
      x86/its: Add support for ITS-safe indirect thunk
      x86/its: Add support for ITS-safe return thunk
      x86/its: Fix undefined reference to cpu_wants_rethunk_at()
      x86/its: Enable Indirect Target Selection mitigation
      x86/its: Add "vmexit" option to skip mitigation on some CPUs

Peng Fan (1):
      mailbox: Not protect module_put with spin_lock_irqsave

Peter Zijlstra (5):
      perf: Revert to requiring CAP_SYS_ADMIN for uprobes
      x86/alternatives: Introduce int3_emulate_jcc()
      x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
      x86/its: Use dynamic thunks for indirect branches
      x86/its: FineIBT-paranoid vs ITS

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

Rafael J. Wysocki (2):
      ACPICA: Refuse to evaluate a method if arguments are missing
      Revert "ACPI: battery: negate current when discharging"

Raju Rangoju (1):
      amd-xgbe: align CL37 AN sequence as per databook

Ricardo Ribalda (3):
      media: uvcvideo: Return the number of processed controls
      media: uvcvideo: Send control events for partial succeeds
      media: uvcvideo: Rollback non processed entities on error

Robert Hodaszi (1):
      usb: cdc-wdm: avoid setting WDM_READ for ZLP-s

Sami Tolvanen (1):
      um: Add cmpxchg8b_emu and checksum functions to asm-prototypes.h

Saurabh Sengar (2):
      Drivers: hv: vmbus: Add utility function for querying ring size
      uio_hv_generic: Query the ringbuffer size for device

Sean Nyekjaer (1):
      can: m_can: m_can_handle_lost_msg(): downgrade msg lost in rx message to debug level

Seiji Nishikawa (1):
      ACPI: PAD: fix crash in exit_round_robin()

Sergey Senozhatsky (1):
      mtk-sd: reset host->mrq on prepare_data() error

Shengjiu Wang (1):
      ASoC: fsl_asrc: use internal measured ratio for non-ideal ratio mode

Shin'ichiro Kawasaki (1):
      RDMA/iwcm: Fix use-after-free of work objects after cm_id destruction

Shravya KN (1):
      bnxt_en: Fix DCB ETS validation

Simon Horman (1):
      net: enetc: Correct endianness handling in _enetc_rd_reg64

Somnath Kotur (1):
      bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

Stefano Garzarella (1):
      vsock/uapi: fix linux/vm_sockets.h userspace compilation errors

Sven Schwermer (1):
      leds: multicolor: Fix intensity setting while SW blinking

Takashi Iwai (1):
      ALSA: sb: Force to disable DMAs once when DMA mode is changed

Thierry Reding (1):
      drm/tegra: Assign plane type before registration

Thomas Fourier (5):
      scsi: qla2xxx: Fix DMA mapping test in qla24xx_get_port_database()
      scsi: qla4xxx: Fix missing DMA mapping error in qla4xxx_alloc_pdu()
      nui: Fix dma_mapping_error() check
      ethernet: atl1: Add missing DMA mapping error checks and count errors
      atm: idt77252: Add missing `dma_map_error()`

Thomas Gessler (1):
      dmaengine: xilinx_dma: Set dma_device directions

Thomas Gleixner (1):
      x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()

Thomas Zimmermann (1):
      drm/udl: Unregister device before cleaning up on disconnect

Tigran Mkrtchyan (1):
      flexfiles/pNFS: update stats on NFS4ERR_DELAY for v4.1 DSes

Tiwei Bie (2):
      um: ubd: Add missing error check in start_io_thread()
      um: vector: Reduce stack usage in vector_eth_configure()

Trond Myklebust (1):
      NFSv4/flexfiles: Fix handling of NFS level errors in I/O

Uladzislau Rezki (Sony) (1):
      rcu: Return early if callback is not specified

Ulf Hansson (1):
      Revert "mmc: sdhci: Disable SD card clock before changing parameters"

Uwe Kleine-König (1):
      pwm: mediatek: Ensure to disable clocks in error path

Vasiliy Kovalev (1):
      jfs: validate AG parameters in dbMount() to prevent crashes

Vicki Pfau (1):
      Input: xpad - add VID for Turtle Beach controllers

Victor Nogueira (1):
      net/sched: Abort __tc_modify_qdisc if parent class does not exist

Victor Shih (1):
      mmc: sdhci: Add a helper function for dump register in dynamic debug mode

Vijendar Mukunda (1):
      ALSA: hda: Add new pci id for AMD GPU display HD audio controller

Vitaly Kuznetsov (1):
      Drivers: hv: Rename 'alloced' to 'allocated'

Wang Jinchao (1):
      md/raid1: Fix stack memory use after return in raid1_reshape

Weihang Li (1):
      RDMA/core: Use refcount_t instead of atomic_t on refcount of iwcm_id_private

Wolfram Sang (2):
      i2c: tiny-usb: disable zero-length read messages
      i2c: robotfuzz-osif: disable zero-length read messages

Wupeng Ma (1):
      VMCI: fix race between vmci_host_setup_notify and vmci_ctx_unset_notify

Xiaowei Li (1):
      net: usb: qmi_wwan: add SIMCom 8230C composition

Yao Zi (1):
      dt-bindings: serial: 8250: Make clocks and clock-frequency exclusive

Yazen Ghannam (2):
      x86/mce/amd: Fix threshold limit reset
      x86/mce: Don't remove sysfs if thresholding sysfs init fails

Youngjun Lee (1):
      ALSA: usb-audio: Fix out-of-bounds read in snd_usb_get_audioformat_uac3()

Yu Kuai (1):
      md/md-bitmap: fix dm-raid max_write_behind setting

Yuan Chen (1):
      libbpf: Fix null pointer dereference in btf_dump__free on allocation failure

Yue Haibing (1):
      atm: clip: Fix NULL pointer dereference in vcc_sendmsg()

Yue Hu (1):
      mmc: mediatek: use data instead of mrq parameter from msdc_{un}prepare_data()

Zhang Heng (1):
      HID: Add IGNORE quirk for SMARTLINKTECHNOLOGY

Łukasz Bartosik (1):
      xhci: dbctty: disable ECHO flag by default


