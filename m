Return-Path: <stable+bounces-183058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5923ABB40DF
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2962A868D
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111DB3148C5;
	Thu,  2 Oct 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yxTmrsx5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906A3148C1;
	Thu,  2 Oct 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411863; cv=none; b=AXMdW5T06F8cfeNXmOBqdvCi7Gth5QsPrj3WtEHVN0mnbxyxBbzXGAp+tAKp80KcY4ONnHz+fKF8ASUgcrNeDCAPZroXa9a3mDeHamsX+z2vGD+4eLYDEO8KZ2eyrG0oB1tduSUwswhOS6wRk29kt2h8iLDY+rVbxqPk/2VkvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411863; c=relaxed/simple;
	bh=eDrRhB7VjKmPN5WG4fzvvim654wm8dVcc7xE/3k3amk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a00n2Rkn1rRrp8dvWR3GUN3t18yDWDq4dSJLAZ/j4lAyEutyUE3w7sSjZxr4O+WCIi0x8w4L23lw6tVVCNnDQYfKnZ02ML9wOsUtTG14lAJ9ZPkjYKIwENs3ZxcoQSjVvurFiTON95LzUdCo5Ps0KtUEyftmHkBWFXIAs5/41lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yxTmrsx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4D1C4CEF4;
	Thu,  2 Oct 2025 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411863;
	bh=eDrRhB7VjKmPN5WG4fzvvim654wm8dVcc7xE/3k3amk=;
	h=From:To:Cc:Subject:Date:From;
	b=yxTmrsx5jhuONiBcdc3MqDm6y4DUmpauGsSdNqf/17RVUiCUq/cHz4g1acvS+sui3
	 MEjpH8Xs3NKGL8o/gNQVjpN+hKJ54dOmXxA65mFlob4lLr508yoTJDGiSGDK/7YMiA
	 Zv279me1rtFgBpRrnnLwLcHWggZ0EAo4KpvAOlQM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.16.10
Date: Thu,  2 Oct 2025 15:30:44 +0200
Message-ID: <2025100245-skintight-elastic-1e30@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.16.10 kernel.

All users of the 6.16 kernel series must upgrade.

The updated 6.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.16.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/laptops/lg-laptop.rst                         |    4 
 Makefile                                                                |    2 
 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts              |    6 
 arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts                    |    2 
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                               |    4 
 arch/arm64/boot/dts/marvell/cn9130-cf.dtsi                              |    7 
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts                      |    6 
 arch/arm64/boot/dts/marvell/cn9132-clearfog.dts                         |   22 
 arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi                         |    8 
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi                    |    3 
 arch/riscv/include/asm/pgtable.h                                        |   17 
 arch/x86/Kconfig                                                        |    2 
 arch/x86/include/asm/topology.h                                         |   10 
 arch/x86/kernel/cpu/topology.c                                          |   13 
 drivers/cpufreq/cpufreq.c                                               |   20 
 drivers/firewire/core-cdev.c                                            |    2 
 drivers/gpio/gpio-regmap.c                                              |    2 
 drivers/gpio/gpiolib-acpi-quirks.c                                      |   14 
 drivers/gpio/gpiolib.c                                                  |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                        |   44 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                               |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                       |   12 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h                       |    7 
 drivers/gpu/drm/amd/display/dc/dc.h                                     |    1 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c                 |    6 
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c               |    6 
 drivers/gpu/drm/ast/ast_dp.c                                            |    2 
 drivers/gpu/drm/gma500/oaktrail_hdmi.c                                  |    2 
 drivers/gpu/drm/i915/display/intel_ddi.c                                |    5 
 drivers/gpu/drm/panfrost/panfrost_drv.c                                 |   61 -
 drivers/gpu/drm/panthor/panthor_sched.c                                 |    8 
 drivers/gpu/drm/xe/abi/guc_actions_abi.h                                |    5 
 drivers/gpu/drm/xe/abi/guc_klvs_abi.h                                   |   40 
 drivers/gpu/drm/xe/xe_bo_evict.c                                        |    4 
 drivers/gpu/drm/xe/xe_configfs.c                                        |    2 
 drivers/gpu/drm/xe/xe_device_sysfs.c                                    |    2 
 drivers/gpu/drm/xe/xe_gt.c                                              |    3 
 drivers/gpu/drm/xe/xe_guc.c                                             |   62 -
 drivers/gpu/drm/xe/xe_guc.h                                             |    1 
 drivers/gpu/drm/xe/xe_guc_submit.c                                      |   87 -
 drivers/gpu/drm/xe/xe_guc_submit.h                                      |    2 
 drivers/gpu/drm/xe/xe_uc.c                                              |    4 
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                                |   12 
 drivers/hid/amd-sfh-hid/amd_sfh_common.h                                |    3 
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                                  |    4 
 drivers/hid/hid-asus.c                                                  |    3 
 drivers/hid/hid-cp2112.c                                                |   10 
 drivers/hid/hid-multitouch.c                                            |   45 
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c                 |    2 
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h                 |    2 
 drivers/i2c/busses/i2c-designware-platdrv.c                             |    7 
 drivers/infiniband/hw/mlx5/devx.c                                       |    1 
 drivers/iommu/iommufd/eventq.c                                          |    9 
 drivers/iommu/iommufd/main.c                                            |   35 
 drivers/mmc/host/sdhci-cadence.c                                        |   11 
 drivers/net/can/rcar/rcar_can.c                                         |    8 
 drivers/net/can/spi/hi311x.c                                            |    1 
 drivers/net/can/sun4i_can.c                                             |    1 
 drivers/net/can/usb/etas_es58x/es58x_core.c                             |    3 
 drivers/net/can/usb/mcba_usb.c                                          |    1 
 drivers/net/can/usb/peak_usb/pcan_usb_core.c                            |    2 
 drivers/net/dsa/lantiq_gswip.c                                          |   21 
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c                            |    2 
 drivers/net/ethernet/freescale/fec_main.c                               |    4 
 drivers/net/ethernet/intel/i40e/i40e.h                                  |    3 
 drivers/net/ethernet/intel/i40e/i40e_main.c                             |   26 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                      |  110 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h                      |    3 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                         |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c                      |    1 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h                       |    1 
 drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c                   |   25 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c           |    7 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c           |   18 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c     |    8 
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h          |    7 
 drivers/net/phy/bcm-phy-ptp.c                                           |    6 
 drivers/net/phy/sfp.c                                                   |   24 
 drivers/net/tun.c                                                       |    3 
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c                            |    3 
 drivers/net/wireless/virtual/virt_wifi.c                                |    4 
 drivers/pinctrl/mediatek/pinctrl-airoha.c                               |   31 
 drivers/platform/x86/lg-laptop.c                                        |   34 
 drivers/platform/x86/oxpec.c                                            |    7 
 drivers/spi/spi-cadence-quadspi.c                                       |   90 +
 drivers/ufs/core/ufs-mcq.c                                              |    4 
 drivers/usb/core/quirks.c                                               |    2 
 drivers/vhost/net.c                                                     |   33 
 drivers/video/fbdev/core/fbcon.c                                        |   13 
 fs/afs/server.c                                                         |    3 
 fs/btrfs/volumes.c                                                      |    5 
 fs/hugetlbfs/inode.c                                                    |   10 
 fs/netfs/buffered_read.c                                                |   10 
 fs/netfs/direct_read.c                                                  |    7 
 fs/netfs/direct_write.c                                                 |    6 
 fs/netfs/internal.h                                                     |    1 
 fs/netfs/objects.c                                                      |   30 
 fs/netfs/read_pgpriv2.c                                                 |    2 
 fs/netfs/read_single.c                                                  |    2 
 fs/netfs/write_issue.c                                                  |    3 
 fs/nfs/file.c                                                           |   33 
 fs/nfs/inode.c                                                          |    9 
 fs/nfs/internal.h                                                       |    2 
 fs/nfs/nfs42proc.c                                                      |   33 
 fs/nfs/nfstrace.h                                                       |    1 
 fs/proc/task_mmu.c                                                      |    3 
 fs/smb/client/smb2inode.c                                               |    2 
 fs/smb/server/transport_rdma.c                                          |   22 
 include/crypto/if_alg.h                                                 |    2 
 include/linux/firmware/imx/sm.h                                         |   47 
 include/linux/mlx5/fs.h                                                 |    2 
 include/net/bluetooth/hci_core.h                                        |   21 
 kernel/bpf/core.c                                                       |    5 
 kernel/bpf/verifier.c                                                   |    6 
 kernel/fork.c                                                           |    2 
 kernel/futex/requeue.c                                                  |    6 
 kernel/sched/ext_idle.c                                                 |   52 
 kernel/sched/ext_idle.h                                                 |    7 
 kernel/trace/fgraph.c                                                   |   12 
 kernel/trace/fprobe.c                                                   |    7 
 kernel/trace/trace_dynevent.c                                           |    4 
 kernel/trace/trace_osnoise.c                                            |    3 
 kernel/vhost_task.c                                                     |    3 
 mm/damon/sysfs.c                                                        |    4 
 mm/kmsan/core.c                                                         |   10 
 mm/kmsan/kmsan_test.c                                                   |   16 
 net/bluetooth/hci_event.c                                               |   30 
 net/bluetooth/hci_sync.c                                                |    7 
 net/bluetooth/mgmt.c                                                    |  259 +++-
 net/bluetooth/mgmt_util.c                                               |   46 
 net/bluetooth/mgmt_util.h                                               |    3 
 net/core/skbuff.c                                                       |    2 
 net/ipv4/nexthop.c                                                      |    7 
 net/smc/smc_loopback.c                                                  |   14 
 net/xfrm/xfrm_device.c                                                  |    2 
 net/xfrm/xfrm_state.c                                                   |    3 
 sound/pci/hda/patch_realtek.c                                           |   11 
 sound/soc/intel/boards/sof_es8336.c                                     |   10 
 sound/soc/intel/boards/sof_rt5682.c                                     |    7 
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c                       |   32 
 sound/usb/mixer_quirks.c                                                |  571 +++++++---
 sound/usb/quirks.c                                                      |   24 
 sound/usb/usbaudio.h                                                    |    4 
 tools/testing/selftests/bpf/prog_tests/free_timer.c                     |    4 
 tools/testing/selftests/bpf/prog_tests/timer.c                          |    4 
 tools/testing/selftests/bpf/prog_tests/timer_crash.c                    |    4 
 tools/testing/selftests/bpf/prog_tests/timer_lockup.c                   |    4 
 tools/testing/selftests/bpf/prog_tests/timer_mim.c                      |    4 
 tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c    |   17 
 tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c |   18 
 tools/testing/selftests/net/fib_nexthops.sh                             |   12 
 153 files changed, 1832 insertions(+), 851 deletions(-)

Adrián Larumbe (1):
      drm/panthor: Defer scheduler entitiy destruction to queue release

Akinobu Mita (1):
      mm/damon/sysfs: do not ignore callback's return value in damon_sysfs_damon_call()

Aleksander Jan Bajkowski (1):
      net: sfp: add quirk for FLYPRO copper SFP+ module

Alexander Popov (1):
      x86/Kconfig: Reenable PTDUMP on i386

Alexandre Ghiti (1):
      riscv: Use an atomic xchg in pudp_huge_get_and_clear()

Alok Tiwari (2):
      scsi: ufs: mcq: Fix memory allocation checks for SQE and CQE
      bnxt_en: correct offset handling for IPv6 destination address

Amit Chaudhari (1):
      HID: asus: add support for missing PX series fn keys

Andrea Righi (2):
      sched_ext: idle: Make local functions static in ext_idle.c
      sched_ext: idle: Handle migration-disabled tasks in BPF code

Antheas Kapenekakis (1):
      platform/x86: oxpec: Add support for OneXPlayer X1 Mini Pro (Strix Point)

Balamurugan C (3):
      ASoC: Intel: soc-acpi: Add entry for sof_es8336 in PTL match table.
      ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in PTL match table
      ASoC: Intel: sof_rt5682: Add HDMI-In capture with rt5682 support for PTL.

Basavaraj Natikar (1):
      HID: amd_sfh: Add sync across amd sfh work functions

Benoît Monin (1):
      mmc: sdhci-cadence: add Mobileye eyeQ support

Carolina Jubran (1):
      net/mlx5e: Fix missing FEC RS stats for RS_544_514_INTERLEAVED_QUAD

Chen Ni (1):
      ALSA: usb-audio: Convert comma to semicolon

Chris Morgan (1):
      net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick

Christian Loehle (1):
      cpufreq: Initialize cpufreq-based invariance before subsys

Christian Marangi (2):
      pinctrl: airoha: fix wrong PHY LED mux value for LED1 GPIO46
      pinctrl: airoha: fix wrong MDIO function bitmaks

Cristian Ciocaltea (8):
      ALSA: usb-audio: Fix code alignment in mixer_quirks
      ALSA: usb-audio: Fix whitespace & blank line issues in mixer_quirks
      ALSA: usb-audio: Fix block comments in mixer_quirks
      ALSA: usb-audio: Drop unnecessary parentheses in mixer_quirks
      ALSA: usb-audio: Avoid multiple assignments in mixer_quirks
      ALSA: usb-audio: Simplify NULL comparison in mixer_quirks
      ALSA: usb-audio: Remove unneeded wmb() in mixer_quirks
      ALSA: usb-audio: Add mixer quirk for Sony DualSense PS5

Cryolitia PukNgae (1):
      ALSA: usb-audio: move mixer_quirks' min_mute into common quirk

Dan Carpenter (1):
      octeontx2-pf: Fix potential use after free in otx2_tc_add_flow()

Daniel Lee (1):
      platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()

Eric Biggers (2):
      crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
      kmsan: fix out-of-bounds access to shadow memory

Eric Huang (1):
      drm/amdkfd: fix p2p links bug in topology

Geert Uytterhoeven (1):
      can: rcar_can: rcar_can_resume(): fix s2ram with PSCI

Greg Kroah-Hartman (1):
      Linux 6.16.10

Hans de Goede (1):
      gpiolib: Extend software-node support to support secondary software-nodes

Heikki Krogerus (1):
      i2c: designware: Add quirk for Intel Xe

Ido Schimmel (2):
      nexthop: Forbid FDB status change while nexthop is in a group
      selftests: fib_nexthops: Fix creation of non-FDB nexthops

Ioana Ciornei (1):
      gpio: regmap: fix memory leak of gpio_regmap structure

Jacob Keller (2):
      broadcom: fix support for PTP_PEROUT_DUTY_CYCLE
      broadcom: fix support for PTP_EXTTS_REQUEST2 ioctl

Jakub Acs (1):
      fs/proc/task_mmu: check p->vec_buf for NULL

James Guan (1):
      wifi: virt_wifi: Fix page fault on connect

Jason Baron (1):
      net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS

Jason Gunthorpe (1):
      iommufd: Fix race during abort for file descriptors

Jason Wang (1):
      vhost-net: flush batched before enabling notifications

Jiayi Li (1):
      usb: core: Add 0x prefix to quirks debug output

Jihed Chaibi (1):
      ARM: dts: kirkwood: Fix sound DAI cells for OpenRD clients

Jimmy Hon (1):
      arm64: dts: rockchip: Fix the headphone detection on the orangepi 5

Jinjiang Tu (1):
      mm/hugetlb: fix folio is still mapped when deleted

Jiri Olsa (1):
      bpf: Check the helper function is valid in get_helper_proto

Johannes Berg (2):
      wifi: iwlwifi: fix byte count table for old devices
      wifi: iwlwifi: pcie: fix byte count table for some devices

Josua Mayer (3):
      arm64: dts: marvell: cn913x-solidrun: fix sata ports status
      arm64: dts: marvell: cn9132-clearfog: disable eMMC high-speed modes
      arm64: dts: marvell: cn9132-clearfog: fix multi-lane pci x2 and x4 ports

Kerem Karabay (4):
      HID: multitouch: Get the contact ID from HID_DG_TRANSDUCER_INDEX fields in case of Apple Touch Bar
      HID: multitouch: support getting the tip state from HID_DG_TOUCH fields in Apple Touch Bar
      HID: multitouch: take cls->maxcontacts into account for Apple Touch Bar even without a HID_DG_CONTACTMAX field
      HID: multitouch: specify that Apple Touch Bar is direct

Khairul Anuar Romli (2):
      spi: cadence-quadspi: Implement refcount to handle unbind during busy
      spi: cadence-qspi: defer runtime support on socfpga if reset bit is enabled

Leon Hwang (2):
      bpf: Reject bpf_timer for PREEMPT_RT
      selftests/bpf: Skip timer cases when bpf_timer is not supported

Louis-Alexis Eyraud (3):
      drm/panfrost: Drop duplicated Mediatek supplies arrays
      drm/panfrost: Commonize Mediatek power domain array definitions
      drm/panfrost: Add support for Mali on the MT8370 SoC

Lucas De Marchi (1):
      drm/xe: Fix build with CONFIG_MODULES=n

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
      Bluetooth: MGMT: Fix possible UAFs

Lukasz Czapnik (8):
      i40e: add validation for ring_len param
      i40e: fix idx validation in i40e_validate_queue_map
      i40e: fix idx validation in config queues msg
      i40e: fix input validation logic for action_meta
      i40e: fix validation of VF state in get resources
      i40e: add max boundary check for VF filters
      i40e: add mask to apply valid bits for itr_idx
      i40e: improve VF MAC filters accounting

Marc Kleine-Budde (1):
      net: fec: rename struct fec_devinfo fec_imx6x_info -> fec_imx6sx_info

Mario Limonciello (AMD) (1):
      gpiolib: acpi: Add quirk for ASUS ProArt PX13

Mark Harmstone (1):
      btrfs: don't allow adding block device of less than 1 MB

Masami Hiramatsu (Google) (3):
      tracing: dynevent: Add a missing lockdown check on dynevent
      tracing: fgraph: Protect return handler from recursion loop
      tracing: fprobe: Fix to remove recorded module addresses from filter

Matthew Schwartz (1):
      drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume

Max Kellermann (1):
      netfs: fix reference leak

Melissa Wen (1):
      drm/amd/display: remove output_tf_change flag

Michael S. Tsirkin (1):
      Revert "vhost/net: Defer TX queue re-enable until after sendmsg"

Michal Wajdeczko (1):
      drm/xe/vf: Don't expose sysfs attributes not applicable for VFs

Moshe Shemesh (1):
      net/mlx5: fs, fix UAF in flow counter release

Nirmoy Das (1):
      drm/ast: Use msleep instead of mdelay for edid read

Nobuhiro Iwamatsu (1):
      ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address

Or Har-Toov (1):
      IB/mlx5: Fix obj_type mismatch for SRQ event subscriptions

Peng Fan (4):
      firmware: imx: Add stub functions for SCMI MISC API
      firmware: imx: Add stub functions for SCMI LMM API
      firmware: imx: Add stub functions for SCMI CPU API
      arm64: dts: imx8mp: Correct thermal sensor index

Petr Malat (1):
      ethernet: rvu-af: Remove slash from the driver name

Sabrina Dubroca (2):
      xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
      xfrm: fix offloading of cross-family tunnels

Samasth Norway Ananda (1):
      fbcon: fix integer overflow in fbcon_do_set_font

Sang-Heon Jeon (1):
      smb: client: fix wrong index reference in smb2_compound_op()

Sasha Levin (2):
      Revert "drm/xe/guc: Set RCS/CCS yield policy"
      Revert "drm/xe/guc: Enable extended CAT error reporting"

Sebastian Andrzej Siewior (3):
      vhost: Take a reference on the task in struct vhost_task.
      futex: Prevent use-after-free during requeue-PI
      futex: Use correct exit on failure from futex_hash_allocate_default()

Sidraya Jayagond (1):
      net/smc: fix warning in smc_rx_splice() when calling get_page()

Stefan Binding (1):
      ALSA: hda/realtek: Add support for ASUS NUC using CS35L41 HDA

Stefan Metzmacher (2):
      smb: server: don't use delayed_work for post_recv_credits_work
      smb: server: use disable_work_sync in transport_rdma.c

Stéphane Grosjean (1):
      can: peak_usb: fix shift-out-of-bounds issue

Suraj Kandpal (1):
      drm/i915/ddi: Guard reg_val against a INVALID_TRANSCODER

Sébastien Szymanski (1):
      HID: cp2112: fix setter callbacks return value

Takashi Iwai (1):
      ALSA: usb-audio: Fix build with CONFIG_INPUT=n

Takashi Sakamoto (1):
      firewire: core: fix overlooked update of subsystem ABI version

Thomas Gleixner (1):
      x86/topology: Implement topology_is_core_online() to address SMT regression

Thomas Hellström (1):
      drm/xe: Don't copy pinned kernel bos twice on suspend

Thomas Zimmermann (1):
      fbcon: Fix OOB access in font allocation

Trond Myklebust (2):
      NFS: Protect against 'eof page pollution'
      NFSv4.2: Protect copy offload and clone against 'eof page pollution'

Vincent Mailhol (4):
      can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
      can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
      can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow

Vlad Dogaru (1):
      net/mlx5: HWS, remove unused create_dest_array parameter

Vladimir Oltean (2):
      net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()
      net: dsa: lantiq_gswip: suppress -EINVAL errors for bridge FDB entries added to the CPU port

Wang Liang (2):
      net: tun: Update napi->skb after XDP process
      tracing/osnoise: Fix slab-out-of-bounds in _parse_integer_limit()

Xing Guo (1):
      selftests/fs/mount-notify: Fix compilation failure.

Xinpeng Sun (1):
      HID: intel-thc-hid: intel-quickspi: Add WCL Device IDs

Yevgeny Kliteynik (1):
      net/mlx5: HWS, ignore flow level for multi-dest table

Yifan Zhang (1):
      amd/amdkfd: correct mem limit calculation for small APUs

Zabelin Nikita (1):
      drm/gma500: Fix null dereference in hdmi teardown

Zhen Ni (1):
      afs: Fix potential null pointer dereference in afs_put_server

noble.yang (1):
      ALSA: usb-audio: Add DSD support for Comtrue USB Audio device

qaqland (1):
      ALSA: usb-audio: Add mute TLV for playback volumes on more devices


