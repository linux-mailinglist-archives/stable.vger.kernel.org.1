Return-Path: <stable+bounces-109364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A6A15043
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51701635A9
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764DD2040B2;
	Fri, 17 Jan 2025 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kpEK/pXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31578200138;
	Fri, 17 Jan 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119281; cv=none; b=HCEf193EkOL6wOnI5Gw2pEovWyYcRplucSPZW6bQxMOc1tQ5xR6PDSVP1tvrgF5f2qg87ROKnnZYbcLPbrivAH6dhdt2UFpldhd0EliyLPVN9E8er4zCGSBNiP4AbzLn7ES78MO0t5sTgGkYgNTfN/GHHfa1EvC4+iu3OIkzuxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119281; c=relaxed/simple;
	bh=RH1hV6X6af7YMSfbC0SLHUXWTJs0XlTrNsvaNI0S8Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mtVWjroBm/A2OtU3kKh6d47AZdmOS8yngAtnEkIUksxw+IESjaG1pmfxU0HaZyD9jwhyqvW4OwPD+JPVRBLadLsUUv1/85HK1PMiad4R/OCqD0tc1/Z+zSmBwFCg7EA8HxWv2wNxYChfz0VN1BPEBR879K18ou+8Opmv7NYJUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kpEK/pXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DBCC4CEE3;
	Fri, 17 Jan 2025 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737119280;
	bh=RH1hV6X6af7YMSfbC0SLHUXWTJs0XlTrNsvaNI0S8Ms=;
	h=From:To:Cc:Subject:Date:From;
	b=kpEK/pXqEaW1NdzPfdZpiPifMGFCViuOK+O80ajUizj6S3s3xBcSV7i5INWJcd+Zp
	 5y5T/k+FWKBWMD8k0GMnQWg1CoRjGPz6PHF7gipp4i8Grqb7CXZro7O9XbVFM22/wo
	 E18NzMPlS5oH2VCatNuZ4fO6/QZIRjW5zITAOcqs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.10
Date: Fri, 17 Jan 2025 14:07:54 +0100
Message-ID: <2025011753-tug-thousand-5293@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.12.10 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/cgroup-v2.rst                   |    2 
 Makefile                                                  |    2 
 arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi                  |    2 
 arch/arm64/boot/dts/freescale/imx95.dtsi                  |    2 
 arch/arm64/boot/dts/qcom/sa8775p.dtsi                     |    5 
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                    |    2 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                  |    1 
 arch/riscv/include/asm/page.h                             |    1 
 arch/riscv/include/asm/pgtable.h                          |    2 
 arch/riscv/include/asm/sbi.h                              |    1 
 arch/riscv/kernel/entry.S                                 |   21 +-
 arch/riscv/kernel/module.c                                |   18 -
 arch/riscv/kernel/probes/kprobes.c                        |    2 
 arch/riscv/kernel/stacktrace.c                            |    4 
 arch/riscv/kernel/traps.c                                 |    6 
 arch/riscv/mm/init.c                                      |   17 +
 arch/x86/kernel/fpu/regset.c                              |    3 
 block/bfq-iosched.c                                       |   12 +
 drivers/acpi/resource.c                                   |   18 +
 drivers/base/topology.c                                   |   24 ++
 drivers/bluetooth/btmtk.c                                 |    7 
 drivers/bluetooth/btnxpuart.c                             |    1 
 drivers/cpuidle/cpuidle-riscv-sbi.c                       |    4 
 drivers/gpio/gpio-loongson-64bit.c                        |    6 
 drivers/gpio/gpio-virtuser.c                              |   44 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c              |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c                    |   17 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                  |    3 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         |   35 ---
 drivers/gpu/drm/amd/display/dc/core/dc.c                  |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_state.c            |    8 
 drivers/gpu/drm/amd/display/dc/dc.h                       |    4 
 drivers/gpu/drm/amd/display/dc/dc_stream.h                |    2 
 drivers/gpu/drm/amd/display/dc/dc_types.h                 |    1 
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h      |    8 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c   |    2 
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h              |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c            |   12 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c      |    1 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c      |    1 
 drivers/gpu/drm/mediatek/Kconfig                          |    5 
 drivers/gpu/drm/mediatek/mtk_crtc.c                       |   25 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c                   |   69 +++---
 drivers/gpu/drm/mediatek/mtk_dp.c                         |   46 ++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                    |    2 
 drivers/gpu/drm/mediatek/mtk_dsi.c                        |   49 +++-
 drivers/gpu/drm/xe/xe_gt.c                                |    8 
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c               |    4 
 drivers/gpu/drm/xe/xe_gt_tlb_invalidation.h               |    3 
 drivers/hwmon/drivetemp.c                                 |    8 
 drivers/iio/adc/ad7124.c                                  |    3 
 drivers/iio/adc/ad7173.c                                  |   10 -
 drivers/iio/adc/at91_adc.c                                |    2 
 drivers/iio/adc/rockchip_saradc.c                         |    2 
 drivers/iio/adc/ti-ads1119.c                              |    4 
 drivers/iio/adc/ti-ads124s08.c                            |    4 
 drivers/iio/adc/ti-ads1298.c                              |    2 
 drivers/iio/adc/ti-ads8688.c                              |    2 
 drivers/iio/dummy/iio_simple_dummy_buffer.c               |    2 
 drivers/iio/gyro/fxas21002c_core.c                        |    9 
 drivers/iio/imu/inv_icm42600/inv_icm42600.h               |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c          |   22 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c           |    3 
 drivers/iio/imu/kmx61.c                                   |    2 
 drivers/iio/inkern.c                                      |    2 
 drivers/iio/light/bh1745.c                                |    2 
 drivers/iio/light/vcnl4035.c                              |    2 
 drivers/iio/pressure/zpa2326.c                            |    2 
 drivers/md/dm-ebs-target.c                                |    2 
 drivers/md/dm-thin.c                                      |    5 
 drivers/md/dm-verity-fec.c                                |   40 ++--
 drivers/md/persistent-data/dm-array.c                     |   19 +
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c           |    4 
 drivers/net/ethernet/amd/pds_core/devlink.c               |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                 |   38 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c             |    3 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c           |    5 
 drivers/net/ethernet/google/gve/gve_main.c                |   14 -
 drivers/net/ethernet/hisilicon/hns3/hnae3.h               |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c        |   96 +++------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c           |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |   45 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c    |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c   |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c |   41 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c |    9 
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h           |    2 
 drivers/net/ethernet/intel/ice/ice_dpll.c                 |   35 ++-
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h           |    4 
 drivers/net/ethernet/intel/igc/igc_base.c                 |    6 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c             |    1 
 drivers/net/ethernet/realtek/rtase/rtase_main.c           |    2 
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c         |   14 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c                |   24 +-
 drivers/net/ieee802154/ca8210.c                           |    6 
 drivers/net/mctp/mctp-i3c.c                               |    4 
 drivers/perf/riscv_pmu_sbi.c                              |   17 -
 drivers/platform/x86/amd/pmc/pmc.c                        |    8 
 drivers/platform/x86/intel/pmc/core_ssram.c               |    4 
 drivers/staging/iio/frequency/ad9832.c                    |    2 
 drivers/staging/iio/frequency/ad9834.c                    |    2 
 drivers/thermal/thermal_of.c                              |    1 
 drivers/tty/serial/8250/8250_core.c                       |    3 
 drivers/tty/serial/stm32-usart.c                          |    4 
 drivers/ufs/core/ufshcd-priv.h                            |    6 
 drivers/ufs/core/ufshcd.c                                 |    1 
 drivers/ufs/host/ufs-qcom.c                               |   13 -
 drivers/usb/chipidea/ci_hdrc_imx.c                        |   25 +-
 drivers/usb/class/usblp.c                                 |    7 
 drivers/usb/core/hub.c                                    |    6 
 drivers/usb/core/port.c                                   |    7 
 drivers/usb/dwc3/core.h                                   |    1 
 drivers/usb/dwc3/dwc3-am62.c                              |    1 
 drivers/usb/dwc3/gadget.c                                 |    4 
 drivers/usb/gadget/Kconfig                                |    4 
 drivers/usb/gadget/configfs.c                             |    6 
 drivers/usb/gadget/function/f_fs.c                        |    2 
 drivers/usb/gadget/function/f_uac2.c                      |    1 
 drivers/usb/gadget/function/u_serial.c                    |    8 
 drivers/usb/host/xhci-plat.c                              |    3 
 drivers/usb/serial/cp210x.c                               |    1 
 drivers/usb/serial/option.c                               |    4 
 drivers/usb/storage/unusual_devs.h                        |    7 
 drivers/usb/typec/tcpm/maxim_contaminant.c                |    4 
 drivers/usb/typec/tcpm/tcpci.c                            |   25 +-
 drivers/usb/typec/ucsi/ucsi_ccg.c                         |    4 
 drivers/vfio/pci/vfio_pci_core.c                          |   17 -
 fs/afs/afs.h                                              |    2 
 fs/afs/afs_vl.h                                           |    1 
 fs/afs/vl_alias.c                                         |    8 
 fs/afs/vlclient.c                                         |    2 
 fs/btrfs/extent_io.c                                      |    7 
 fs/btrfs/inode.c                                          |    2 
 fs/btrfs/scrub.c                                          |    4 
 fs/btrfs/zlib.c                                           |    4 
 fs/buffer.c                                               |    4 
 fs/exfat/dir.c                                            |    3 
 fs/exfat/fatent.c                                         |   10 +
 fs/exfat/file.c                                           |    6 
 fs/ext4/page-io.c                                         |    2 
 fs/f2fs/data.c                                            |    9 
 fs/fs-writeback.c                                         |    8 
 fs/fuse/dir.c                                             |    2 
 fs/iomap/buffered-io.c                                    |   68 +++++-
 fs/jbd2/commit.c                                          |    4 
 fs/jbd2/revoke.c                                          |    2 
 fs/mount.h                                                |   15 -
 fs/mpage.c                                                |    2 
 fs/namespace.c                                            |   24 +-
 fs/netfs/buffered_read.c                                  |   28 +-
 fs/netfs/direct_write.c                                   |    7 
 fs/netfs/read_collect.c                                   |    9 
 fs/netfs/read_pgpriv2.c                                   |    4 
 fs/netfs/read_retry.c                                     |    5 
 fs/netfs/write_collect.c                                  |    9 
 fs/nfs/fscache.c                                          |    9 
 fs/notify/fdinfo.c                                        |    4 
 fs/overlayfs/copy_up.c                                    |   16 -
 fs/overlayfs/export.c                                     |   49 ++--
 fs/overlayfs/namei.c                                      |    4 
 fs/overlayfs/overlayfs.h                                  |    2 
 fs/smb/client/namespace.c                                 |   19 +
 fs/smb/server/smb2pdu.c                                   |   43 ++++
 fs/smb/server/smb2pdu.h                                   |   10 +
 fs/smb/server/vfs.c                                       |    3 
 include/linux/bus/stm32_firewall_device.h                 |    2 
 include/linux/iomap.h                                     |    2 
 include/linux/mount.h                                     |    3 
 include/linux/netfs.h                                     |    1 
 include/linux/writeback.h                                 |    4 
 include/net/inet_connection_sock.h                        |    2 
 include/ufs/ufshcd.h                                      |    2 
 io_uring/eventfd.c                                        |    2 
 io_uring/io_uring.c                                       |    5 
 io_uring/sqpoll.c                                         |    6 
 io_uring/timeout.c                                        |    4 
 kernel/cgroup/cpuset.c                                    |   35 ---
 kernel/sched/ext.c                                        |   76 ++++++-
 kernel/sched/ext.h                                        |    8 
 kernel/sched/idle.c                                       |    5 
 net/802/psnap.c                                           |    4 
 net/bluetooth/hci_sync.c                                  |   11 -
 net/bluetooth/mgmt.c                                      |   38 +++
 net/bluetooth/rfcomm/tty.c                                |    4 
 net/core/dev.c                                            |   43 +++-
 net/core/dev.h                                            |    3 
 net/core/link_watch.c                                     |   10 -
 net/core/netdev-genl.c                                    |    9 
 net/ipv4/tcp_ipv4.c                                       |    2 
 net/mptcp/ctrl.c                                          |   17 -
 net/netfilter/nf_conntrack_core.c                         |    5 
 net/netfilter/nf_tables_api.c                             |   15 +
 net/rds/tcp.c                                             |   39 +++
 net/sched/cls_flow.c                                      |    3 
 net/sched/sch_cake.c                                      |  140 +++++++-------
 net/sctp/sysctl.c                                         |   14 -
 net/tls/tls_sw.c                                          |    2 
 sound/soc/codecs/rt722-sdca.c                             |    7 
 sound/soc/mediatek/common/mtk-afe-platform-driver.c       |    4 
 tools/testing/selftests/alsa/Makefile                     |    2 
 tools/testing/selftests/cgroup/test_cpuset_prs.sh         |   33 +--
 201 files changed, 1419 insertions(+), 790 deletions(-)

Akash M (1):
      usb: gadget: f_fs: Remove WARN_ON in functionfs_bind

Alex Hung (1):
      drm/amd/display: Remove unnecessary amdgpu_irq_get/put

Alex Williamson (1):
      vfio/pci: Fallback huge faults for unaligned pfn

Amir Goldstein (4):
      fuse: respect FOPEN_KEEP_CACHE on opendir
      ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
      ovl: support encoding fid from inode with no alias
      fs: relax assertions on failure to encode file handles

Andrea Righi (1):
      sched_ext: idle: Refresh idle masks during idle-to-idle transitions

André Draszik (1):
      usb: dwc3: gadget: fix writing NYET threshold

AngeloGioacchino Del Regno (1):
      drm/mediatek: mtk_dsi: Add registers to pdata to fix MT8186/MT8188

Antonio Pastor (1):
      net: 802: LLC+SNAP OID:PID lookup on start of skb data

Anumula Murali Mohan Reddy (1):
      cxgb4: Avoid removal of uninserted tid

Arkadiusz Kubalewski (1):
      ice: fix max values for dpll pin phase adjust

Arnd Bergmann (1):
      drm/mediatek: stop selecting foreign drivers

Arunpravin Paneer Selvam (1):
      drm/amdgpu: Add a lock when accessing the buddy trim function

Atish Patra (2):
      drivers/perf: riscv: Fix Platform firmware event data
      drivers/perf: riscv: Return error for default case

Ben Wolsieffer (1):
      serial: stm32: use port lock wrappers for break control

Benjamin Coddington (1):
      tls: Fix tls_sw_sendmsg error handling

Binbin Zhou (1):
      gpio: loongson: Fix Loongson-2K2000 ACPI GPIO register offset

Carlos Song (1):
      iio: gyro: fxas21002c: Fix missing data update in trigger handler

Changwoo Min (1):
      sched_ext: Replace rq_lock() to raw_spin_rq_lock() in scx_ops_bypass()

Charles Han (1):
      iio: adc: ti-ads1298: Add NULL check in ads1298_init

Chen Ridong (1):
      cgroup/cpuset: remove kernfs active break

Chen-Yu Tsai (1):
      ASoC: mediatek: disable buffer pre-allocation

Chenguang Zhao (1):
      net/mlx5: Fix variable not being completed when function returns

Chris Lu (1):
      Bluetooth: btmtk: Fix failed to send func ctrl for MediaTek devices.

Christian Brauner (1):
      fs: kill MNT_ONRB

Chukun Pan (1):
      USB: serial: option: add MeiG Smart SRM815

Chun-Kuang Hu (1):
      Revert "drm/mediatek: dsi: Correct calculation formula of PHY Timing"

Clément Léger (3):
      riscv: module: remove relocation_head rel_entry member allocation
      riscv: stacktrace: fix backtracing through exceptions
      riscv: use local label names instead of global ones in assembly

Dan Carpenter (2):
      rtase: Fix a check for error in rtase_alloc_msix()
      usb: typec: tcpm/tcpci_maxim: fix error code in max_contaminant_read_resistance_kohm()

Daniel Borkmann (1):
      tcp: Annotate data-race around sk->sk_mark in tcp_v4_send_reset

Daniel Golle (1):
      drm/mediatek: Only touch DISP_REG_OVL_PITCH_MSB if AFBC is supported

Daniil Stas (1):
      hwmon: (drivetemp) Fix driver producing garbage data when SCSI errors occur

David E. Box (1):
      platform/x86: intel/pmc: Fix ioremap() of bad address

David Howells (9):
      netfs: Fix enomem handling in buffered reads
      nfs: Fix oops in nfs_netfs_init_request() when copying to cache
      netfs: Fix missing barriers by using clear_and_wake_up_bit()
      netfs: Fix ceph copy to cache on write-begin
      netfs: Fix the (non-)cancellation of copy when cache is temporarily disabled
      netfs: Fix is-caching check in read-retry
      afs: Fix the maximum cell name length
      netfs: Fix kernel async DIO
      netfs: Fix read-retry for fs with no ->prepare_read()

David Lechner (1):
      iio: adc: ad7173: fix using shared static info struct

En-Wei Wu (1):
      igc: return early when failing to read EECD register

Eric Dumazet (1):
      net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute

Fabio Estevam (1):
      iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()

GONG Ruiqi (1):
      usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()

Greg Kroah-Hartman (1):
      Linux 6.12.10

Guoqing Jiang (1):
      drm/mediatek: Set private->all_drm_private[i]->drm to NULL if mtk_drm_bind returns err

Hans de Goede (2):
      ACPI: resource: Add TongFang GM5HG0A to irq1_edge_low_force_override[]
      ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]

Hao Lan (4):
      net: hns3: fixed reset failure issues caused by the incorrect reset type
      net: hns3: fix missing features due to dev->features configuration too early
      net: hns3: Resolved the issue that the debugfs query result is inconsistent.
      net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds issue

He Wang (1):
      ksmbd: fix unexpectedly changed path in ksmbd_vfs_kern_path_locked

Honglei Wang (1):
      sched_ext: switch class when preempted by higher priority scheduler

Ilpo Järvinen (1):
      tty: serial: 8250: Fix another runtime PM usage counter underflow

Ingo Rohloff (1):
      usb: gadget: configfs: Ignore trailing LF for user strings to cdev

Jakub Kicinski (3):
      net: don't dump Tx and uninitialized NAPIs
      eth: gve: use appropriate helper to set xdp_features
      netdev: prevent accessing NAPI instances from another namespace

Jason-JH.Lin (2):
      drm/mediatek: Move mtk_crtc_finish_page_flip() to ddp_cmdq_cb()
      drm/mediatek: Add support for 180-degree rotation in the display driver

Javier Carrasco (10):
      cpuidle: riscv-sbi: fix device node release in early exit of for_each_possible_cpu
      iio: pressure: zpa2326: fix information leak in triggered buffer
      iio: dummy: iio_simply_dummy_buffer: fix information leak in triggered buffer
      iio: light: vcnl4035: fix information leak in triggered buffer
      iio: light: bh1745: fix information leak in triggered buffer
      iio: imu: kmx61: fix information leak in triggered buffer
      iio: adc: rockchip_saradc: fix information leak in triggered buffer
      iio: adc: ti-ads8688: fix information leak in triggered buffer
      iio: adc: ti-ads1119: fix information leak in triggered buffer
      iio: adc: ti-ads1119: fix sample size in scan struct for triggered buffer

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
      iio: imu: inv_icm42600: fix spi burst write not supported

Jens Axboe (1):
      io_uring/eventfd: ensure io_eventfd_signal() defers another RCU period

Jesse Taube (1):
      ARM: dts: imxrt1050: Fix clocks for mmc

Jesse.zhang@amd.com (1):
      drm/amdkfd: fixed page fault when enable MES shader debugger

Jian Shen (2):
      net: hns3: don't auto enable misc vector
      net: hns3: initialize reset_timer before hclgevf_misc_irq_init()

Jiawen Wu (1):
      net: libwx: fix firmware mailbox abnormal return

Jie Gan (1):
      arm64: dts: qcom: sa8775p: fix the secure device bootup issue

Jie Wang (1):
      net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

Joe Hattori (4):
      thermal: of: fix OF node leak in of_thermal_zone_find()
      usb: chipidea: ci_hdrc_imx: decrement device's refcount in .remove() and in the error path of .probe()
      iio: adc: at91: call input_free_device() on allocated iio_dev
      iio: inkern: call iio_device_put() only on mapped devices

Johan Hovold (1):
      USB: serial: cp210x: add Phoenix Contact UPS Device

Jun Yan (1):
      USB: usblp: return error when setting unsupported protocol

Kai-Heng Feng (1):
      USB: core: Disable LPM only for non-suspended ports

Kalesh AP (1):
      bnxt_en: Fix possible memory leak when hwrm_req_replace fails

Keisuke Nishimura (1):
      ieee802154: ca8210: Add missing check for kfifo_alloc() in ca8210_probe()

Koichiro Den (2):
      gpio: virtuser: fix missing lookup table cleanups
      gpio: virtuser: fix handling of multiple conn_ids in lookup table

Krister Johansen (1):
      dm thin: make get_first_thin use rcu-safe list first function

Kun Liu (1):
      drm/amd/pm: fix BUG: scheduling while atomic

Kuniyuki Iwashima (1):
      ipvlan: Fix use-after-free in ipvlan_get_iflink().

Leo Yang (1):
      mctp i3c: fix MCTP I3C driver multi-thread issue

Li Huafei (1):
      topology: Keep the cpumask unchanged when printing cpumap

Li Zhijian (1):
      selftests/alsa: Fix circular dependency involving global-timer

Liankun Yang (3):
      drm/mediatek: Fix YCbCr422 color format issue for DP
      drm/mediatek: Fix mode valid issue for dp
      drm/mediatek: Add return value check when reading DPCD

Lianqin Hu (1):
      usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null

Long Li (2):
      iomap: pass byte granular end position to iomap_add_to_ioend
      iomap: fix zero padding data issue in concurrent append writes

Lubomir Rintel (1):
      usb-storage: Add max sectors quirk for Nokia 208

Lucas De Marchi (1):
      drm/xe: Fix tlb invalidation when wedging

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not setting Random Address when required
      Bluetooth: MGMT: Fix Add Device to responding before completing

Ma Ke (1):
      usb: fix reference leak in usb_new_device()

Maciej S. Szmigiero (1):
      platform/x86/amd/pmc: Only disable IRQ1 wakeup where i8042 actually enabled it

Manivannan Sadhasivam (2):
      scsi: ufs: qcom: Power off the PHY if it was already powered on in ufs_qcom_power_up_sequence()
      arm64: dts: qcom: sa8775p: Fix the size of 'addr_space' regions

Matthieu Baerts (NGI0) (9):
      mptcp: sysctl: avail sched: remove write access
      mptcp: sysctl: sched: avoid using current->nsproxy
      mptcp: sysctl: blackhole timeout: avoid using current->nsproxy
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: rto_min/max: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy
      sctp: sysctl: udp_port: avoid using current->nsproxy
      sctp: sysctl: plpmtud_probe_interval: avoid using current->nsproxy
      rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy

Meetakshi Setiya (1):
      smb: client: sync the root session and superblock context passwords before automounting

Melissa Wen (3):
      drm/amd/display: fix divide error in DM plane scale calcs
      drm/amd/display: fix page fault due to max surface definition mismatch
      drm/amd/display: increase MAX_SURFACES to the value supported by hw

Michael Chan (1):
      bnxt_en: Fix DIM shutdown

Michal Hrusecky (1):
      USB: serial: option: add Neoway N723-EA support

Mikhail Zaslonko (1):
      btrfs: zlib: fix avail_in bytes for s390 zlib HW compression path

Miklos Szeredi (1):
      fs: fix is_mnt_ns_file()

Mikulas Patocka (1):
      dm-ebs: don't set the flag DM_TARGET_PASSES_INTEGRITY

Milan Broz (1):
      dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)

Ming-Hung Tsai (3):
      dm array: fix releasing a faulty array block twice in dm_array_cursor_end
      dm array: fix unreleased btree blocks on closing a faulty array cursor
      dm array: fix cursor index when skipping across block boundaries

Nam Cao (2):
      riscv: Fix sleeping in invalid context in die()
      riscv: kprobes: Fix incorrect address calculation

Namjae Jeon (1):
      ksmbd: Implement new SMB3 POSIX type

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix driver sending truncated data

Pablo Neira Ayuso (2):
      netfilter: nf_tables: imbalance in flowtable binding
      netfilter: conntrack: clamp maximum hashtable size to INT_MAX

Pankaj Raghav (1):
      fs/writeback: convert wbc_account_cgroup_owner to take a folio

Parker Newman (1):
      net: stmmac: dwmac-tegra: Read iommu stream id from device tree

Pavel Begunkov (3):
      io_uring/timeout: fix multishot updates
      io_uring/sqpoll: zero sqd->thread on tctx errors
      io_uring: don't touch sqd->thread off tw add

Peter Geis (1):
      arm64: dts: rockchip: add hevc power domain clock to rk3328

Prashanth K (2):
      usb: dwc3-am62: Disable autosuspend during remove
      usb: gadget: f_uac2: Fix incorrect setting of bNumEndpoints

Przemyslaw Korba (1):
      ice: fix incorrect PHY settings for 100 GB/s

Qiang Yu (1):
      arm64: dts: qcom: x1e80100: Fix up BAR space size for PCIe6a

Qu Wenruo (1):
      btrfs: avoid NULL pointer dereference if no valid extent tree

Rengarajan S (2):
      misc: microchip: pci1xxxx: Resolve kernel panic during GPIO IRQ handling
      misc: microchip: pci1xxxx: Resolve return code mismatch during GPIO set config

Rick Edgecombe (1):
      x86/fpu: Ensure shadow stack is active before "getting" registers

Roman Li (1):
      drm/amd/display: Add check for granularity in dml ceil/floor helpers

Shannon Nelson (1):
      pds_core: limit loop over fw name list

Shuming Fan (1):
      ASoC: rt722: add delay time to wait for the calibration procedure

Takashi Iwai (1):
      usb: gadget: midi2: Reverse-select at the right place

Toke Høiland-Jørgensen (1):
      sched: sch_cake: add bounds checks to host bulk flow fairness counts

Uwe Kleine-König (1):
      iio: adc: ad7124: Disable all channels at probe time

Waiman Long (1):
      cgroup/cpuset: Prevent leakage of isolated CPUs into sched domains

Wei Fang (1):
      arm64: dts: imx95: correct the address length of netcmix_blk_ctrl

Wentao Liang (1):
      ksmbd: fix a missing return value check bug

Xu Lu (1):
      riscv: mm: Fix the out of bound issue of vmemmap address

Xu Yang (2):
      usb: typec: tcpci: fix NULL pointer issue on shared irq case
      usb: host: xhci-plat: set skip_phy_initialization if software node has XHCI_SKIP_PHY_INIT property

Yu Kuai (1):
      block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()

Yuezhang Mo (3):
      exfat: fix the infinite loop in exfat_readdir()
      exfat: fix the new buffer was not zeroed before writing
      exfat: fix the infinite loop in __exfat_free_cluster()

Zhang Yi (2):
      jbd2: increase IO priority for writing revoke records
      jbd2: flush filesystem device before updating tail sequence

Zhongqiu Duan (1):
      tcp/dccp: allow a connection when sk_max_ack_backlog is zero

Zhu Lingshan (1):
      drm/amdkfd: wq_release signals dma_fence only when available

Zicheng Qu (2):
      staging: iio: ad9834: Correct phase range check
      staging: iio: ad9832: Correct phase range check

guanjing (1):
      firewall: remove misplaced semicolon from stm32_firewall_get_firewall


