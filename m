Return-Path: <stable+bounces-109362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA9A1503A
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F51E7A17C5
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A4202F90;
	Fri, 17 Jan 2025 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SuPvluD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18927202F95;
	Fri, 17 Jan 2025 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119267; cv=none; b=iCbTmDRJFTJBfOzCI+ttAdF4qOO8SL0BvZvSwn6pPaqQQWa7p9rsuq2EryuneuBIfnLBVUqALvecgzbM5ZPSKpLRcASajlh2WO25uog0aP1cXLmkI0tRqAv+OxZHfnbsFXjY0/jEk0YKlK4z95bbC1cShNe2fDKqNFpHrqpfH58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119267; c=relaxed/simple;
	bh=BPLgk7h2yFM2BGJULxzwnRFsPGF7hnc7mC3z49AOHHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZVSFz1K3Q34sUHRFDHoT1/nD/4Qtsp7lr5ye1+7UDYG+NcZ060V55xNzm+V2iPEbWz9H6zHGMGFKp2MvG9cwRYuETtU5meMYqoqJWGlcYQfi/kh8dL0Z6yxbnmbOmTap4CzNWUZ79mE2J6Vx0jGFdKLE8rOiR5iC+t5mhH7K+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SuPvluD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA25C4CEDD;
	Fri, 17 Jan 2025 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737119266;
	bh=BPLgk7h2yFM2BGJULxzwnRFsPGF7hnc7mC3z49AOHHI=;
	h=From:To:Cc:Subject:Date:From;
	b=SuPvluD4GsR+c1FHUBNFqHzwOcANgHq3rmtwmybHqjv3RQYaN7dK7Lr4cJJUi6iJn
	 tQ/MO6nsCH2ekQdABr8OA3ManultCNzP5pYNPwjUAoyZXkrLjFKadYWYUviza29LVi
	 d/9GFVn1Ofhzmf0poozOi4l/uGn2+sY6l6fpx8HE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.72
Date: Fri, 17 Jan 2025 14:07:41 +0100
Message-ID: <2025011740-granular-rust-dc2d@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.72 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi             |    2 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi             |    1 
 arch/riscv/include/asm/cacheflush.h                  |    6 
 arch/riscv/include/asm/page.h                        |    1 
 arch/riscv/include/asm/patch.h                       |    1 
 arch/riscv/include/asm/pgtable.h                     |    2 
 arch/riscv/kernel/ftrace.c                           |   47 +++++-
 arch/riscv/kernel/patch.c                            |   16 +-
 arch/riscv/kernel/probes/kprobes.c                   |    2 
 arch/riscv/kernel/traps.c                            |    6 
 arch/riscv/mm/init.c                                 |   17 ++
 arch/x86/kernel/fpu/regset.c                         |    3 
 arch/x86/mm/numa.c                                   |    6 
 block/bfq-iosched.c                                  |   12 +
 drivers/acpi/resource.c                              |   18 ++
 drivers/base/topology.c                              |   24 ++-
 drivers/bluetooth/btnxpuart.c                        |    1 
 drivers/cpuidle/cpuidle-riscv-sbi.c                  |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c               |   17 ++
 drivers/gpu/drm/amd/display/dc/dc.h                  |    2 
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h |    8 +
 drivers/gpu/drm/mediatek/Kconfig                     |    5 
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c              |   57 +++----
 drivers/gpu/drm/mediatek/mtk_dp.c                    |   46 +++---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c               |    2 
 drivers/hwmon/drivetemp.c                            |    8 -
 drivers/iio/adc/ad7124.c                             |    3 
 drivers/iio/adc/at91_adc.c                           |    2 
 drivers/iio/adc/rockchip_saradc.c                    |    2 
 drivers/iio/adc/ti-ads124s08.c                       |    4 
 drivers/iio/adc/ti-ads8688.c                         |    2 
 drivers/iio/dummy/iio_simple_dummy_buffer.c          |    2 
 drivers/iio/gyro/fxas21002c_core.c                   |    9 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c     |    8 -
 drivers/iio/imu/kmx61.c                              |    2 
 drivers/iio/inkern.c                                 |    2 
 drivers/iio/light/vcnl4035.c                         |    2 
 drivers/iio/pressure/zpa2326.c                       |    2 
 drivers/md/dm-ebs-target.c                           |    2 
 drivers/md/dm-thin.c                                 |    5 
 drivers/md/dm-verity-fec.c                           |   39 +++--
 drivers/md/persistent-data/dm-array.c                |   19 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c      |    4 
 drivers/net/ethernet/amd/pds_core/devlink.c          |    2 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c        |    3 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c      |    5 
 drivers/net/ethernet/google/gve/gve_main.c           |   14 +
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h      |    4 
 drivers/net/ethernet/intel/igc/igc_base.c            |   12 +
 drivers/net/ethernet/intel/igc/igc_i225.c            |    5 
 drivers/net/ethernet/intel/igc/igc_main.c            |    6 
 drivers/net/ethernet/intel/igc/igc_phy.c             |    4 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c        |    1 
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c    |   14 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c           |   24 +--
 drivers/net/ieee802154/ca8210.c                      |    6 
 drivers/platform/x86/amd/pmc/pmc.c                   |    8 -
 drivers/pmdomain/imx/gpcv2.c                         |   10 -
 drivers/staging/iio/frequency/ad9832.c               |    2 
 drivers/staging/iio/frequency/ad9834.c               |    2 
 drivers/thermal/thermal_of.c                         |    1 
 drivers/tty/serial/8250/8250_core.c                  |    3 
 drivers/ufs/core/ufshcd-priv.h                       |    6 
 drivers/ufs/core/ufshcd.c                            |    1 
 drivers/ufs/host/ufs-qcom.c                          |   13 -
 drivers/usb/chipidea/ci_hdrc_imx.c                   |   25 ++-
 drivers/usb/class/usblp.c                            |    7 
 drivers/usb/core/hub.c                               |    6 
 drivers/usb/core/port.c                              |    7 
 drivers/usb/dwc3/core.h                              |    1 
 drivers/usb/dwc3/dwc3-am62.c                         |    1 
 drivers/usb/dwc3/gadget.c                            |    4 
 drivers/usb/gadget/Kconfig                           |    4 
 drivers/usb/gadget/configfs.c                        |    6 
 drivers/usb/gadget/function/f_fs.c                   |    2 
 drivers/usb/gadget/function/f_uac2.c                 |    1 
 drivers/usb/gadget/function/u_serial.c               |    8 -
 drivers/usb/serial/cp210x.c                          |    1 
 drivers/usb/serial/option.c                          |    4 
 drivers/usb/storage/unusual_devs.h                   |    7 
 drivers/usb/typec/tcpm/maxim_contaminant.c           |    4 
 fs/Kconfig                                           |   24 ++-
 fs/afs/afs.h                                         |    2 
 fs/afs/afs_vl.h                                      |    1 
 fs/afs/vl_alias.c                                    |    8 -
 fs/afs/vlclient.c                                    |    2 
 fs/btrfs/scrub.c                                     |    4 
 fs/erofs/zdata.c                                     |   66 ++++----
 fs/exfat/dir.c                                       |    3 
 fs/exfat/fatent.c                                    |   10 +
 fs/f2fs/super.c                                      |   12 -
 fs/jbd2/commit.c                                     |    4 
 fs/jbd2/revoke.c                                     |    2 
 fs/overlayfs/copy_up.c                               |   62 +++++---
 fs/overlayfs/export.c                                |   49 +++---
 fs/overlayfs/namei.c                                 |   41 ++++-
 fs/overlayfs/overlayfs.h                             |   28 ++-
 fs/overlayfs/super.c                                 |   20 +-
 fs/overlayfs/util.c                                  |   10 +
 fs/smb/client/namespace.c                            |   19 ++
 fs/smb/server/smb2pdu.c                              |   43 +++++
 fs/smb/server/smb2pdu.h                              |   10 +
 fs/smb/server/vfs.c                                  |    3 
 include/linux/hugetlb.h                              |    5 
 include/linux/mm.h                                   |    1 
 include/linux/mm_types.h                             |   34 ++++
 include/linux/numa.h                                 |    5 
 include/net/inet_connection_sock.h                   |    2 
 include/ufs/ufshcd.h                                 |    2 
 io_uring/io_uring.c                                  |   13 +
 io_uring/timeout.c                                   |    4 
 kernel/workqueue.c                                   |   68 ++++++---
 mm/hugetlb.c                                         |   24 +--
 mm/memblock.c                                        |   24 ---
 net/802/psnap.c                                      |    4 
 net/bluetooth/hci_sync.c                             |   11 -
 net/bluetooth/mgmt.c                                 |   38 ++++-
 net/core/link_watch.c                                |   10 -
 net/ipv4/tcp_ipv4.c                                  |    2 
 net/mptcp/ctrl.c                                     |   11 -
 net/netfilter/nf_conntrack_core.c                    |    5 
 net/netfilter/nf_tables_api.c                        |   15 +-
 net/sched/cls_flow.c                                 |    3 
 net/sched/sch_cake.c                                 |  140 ++++++++++---------
 net/sctp/sysctl.c                                    |   14 +
 net/tls/tls_sw.c                                     |    2 
 sound/soc/codecs/rt722-sdca.c                        |    7 
 sound/soc/mediatek/common/mtk-afe-platform-driver.c  |    4 
 tools/include/linux/numa.h                           |    5 
 tools/testing/selftests/alsa/Makefile                |    2 
 131 files changed, 1030 insertions(+), 507 deletions(-)

Akash M (1):
      usb: gadget: f_fs: Remove WARN_ON in functionfs_bind

Alexander Gordeev (1):
      pgtable: fix s390 ptdesc field comments

Alexandre Ghiti (2):
      riscv: Fix early ftrace nop patching
      riscv: Fix text patching when IPI are used

Amir Goldstein (3):
      ovl: do not encode lower fh with upper sb_writers held
      ovl: pass realinode to ovl_encode_real_fh() instead of realdentry
      ovl: support encoding fid from inode with no alias

André Draszik (1):
      usb: dwc3: gadget: fix writing NYET threshold

Antonio Pastor (1):
      net: 802: LLC+SNAP OID:PID lookup on start of skb data

Anumula Murali Mohan Reddy (1):
      cxgb4: Avoid removal of uninserted tid

Arnd Bergmann (1):
      drm/mediatek: stop selecting foreign drivers

Benjamin Coddington (1):
      tls: Fix tls_sw_sendmsg error handling

Carlos Song (1):
      iio: gyro: fxas21002c: Fix missing data update in trigger handler

Chen-Yu Tsai (1):
      ASoC: mediatek: disable buffer pre-allocation

Chenguang Zhao (1):
      net/mlx5: Fix variable not being completed when function returns

Chukun Pan (1):
      USB: serial: option: add MeiG Smart SRM815

Dan Carpenter (1):
      usb: typec: tcpm/tcpci_maxim: fix error code in max_contaminant_read_resistance_kohm()

Daniel Borkmann (1):
      tcp: Annotate data-race around sk->sk_mark in tcp_v4_send_reset

Daniel Golle (1):
      drm/mediatek: Only touch DISP_REG_OVL_PITCH_MSB if AFBC is supported

Daniil Stas (1):
      hwmon: (drivetemp) Fix driver producing garbage data when SCSI errors occur

David Hildenbrand (1):
      mm/hugetlb: enforce that PMD PT sharing has split PMD PT locks

David Howells (1):
      afs: Fix the maximum cell name length

En-Wei Wu (1):
      igc: return early when failing to read EECD register

Eric Dumazet (1):
      net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute

Fabio Estevam (1):
      iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()

Gao Xiang (2):
      erofs: handle overlapped pclusters out of crafted images properly
      erofs: fix PSI memstall accounting

Greg Kroah-Hartman (1):
      Linux 6.6.72

Guoqing Jiang (1):
      drm/mediatek: Set private->all_drm_private[i]->drm to NULL if mtk_drm_bind returns err

Hans de Goede (2):
      ACPI: resource: Add TongFang GM5HG0A to irq1_edge_low_force_override[]
      ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]

He Wang (1):
      ksmbd: fix unexpectedly changed path in ksmbd_vfs_kern_path_locked

Ilpo Järvinen (1):
      tty: serial: 8250: Fix another runtime PM usage counter underflow

Ingo Rohloff (1):
      usb: gadget: configfs: Ignore trailing LF for user strings to cdev

Jakub Kicinski (1):
      eth: gve: use appropriate helper to set xdp_features

Jan Beulich (2):
      memblock: make memblock_set_node() also warn about use of MAX_NUMNODES
      x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()

Jason Xing (1):
      tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog

Javier Carrasco (7):
      cpuidle: riscv-sbi: fix device node release in early exit of for_each_possible_cpu
      iio: pressure: zpa2326: fix information leak in triggered buffer
      iio: dummy: iio_simply_dummy_buffer: fix information leak in triggered buffer
      iio: light: vcnl4035: fix information leak in triggered buffer
      iio: imu: kmx61: fix information leak in triggered buffer
      iio: adc: rockchip_saradc: fix information leak in triggered buffer
      iio: adc: ti-ads8688: fix information leak in triggered buffer

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on

Jens Axboe (1):
      io_uring/eventfd: ensure io_eventfd_signal() defers another RCU period

Jesse Brandeburg (1):
      igc: field get conversion

Jesse Taube (1):
      ARM: dts: imxrt1050: Fix clocks for mmc

Jesse.zhang@amd.com (1):
      drm/amdkfd: fixed page fault when enable MES shader debugger

Jiawen Wu (1):
      net: libwx: fix firmware mailbox abnormal return

Joe Hattori (5):
      thermal: of: fix OF node leak in of_thermal_zone_find()
      usb: chipidea: ci_hdrc_imx: decrement device's refcount in .remove() and in the error path of .probe()
      iio: adc: at91: call input_free_device() on allocated iio_dev
      iio: inkern: call iio_device_put() only on mapped devices
      pmdomain: imx: gpcv2: fix an OF node reference leak in imx_gpcv2_probe()

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

Krister Johansen (1):
      dm thin: make get_first_thin use rcu-safe list first function

Krzysztof Kozlowski (1):
      pmdomain: imx: gpcv2: Simplify with scoped for each OF child loop

Kuniyuki Iwashima (1):
      ipvlan: Fix use-after-free in ipvlan_get_iflink().

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

Liu Shixin (1):
      mm: hugetlb: independent PMD page table shared count

Lubomir Rintel (1):
      usb-storage: Add max sectors quirk for Nokia 208

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not setting Random Address when required
      Bluetooth: MGMT: Fix Add Device to responding before completing

Ma Ke (1):
      usb: fix reference leak in usb_new_device()

Maciej S. Szmigiero (1):
      platform/x86/amd/pmc: Only disable IRQ1 wakeup where i8042 actually enabled it

Manivannan Sadhasivam (1):
      scsi: ufs: qcom: Power off the PHY if it was already powered on in ufs_qcom_power_up_sequence()

Matthieu Baerts (NGI0) (6):
      mptcp: sysctl: sched: avoid using current->nsproxy
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: rto_min/max: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy
      sctp: sysctl: udp_port: avoid using current->nsproxy
      sctp: sysctl: plpmtud_probe_interval: avoid using current->nsproxy

Meetakshi Setiya (1):
      smb: client: sync the root session and superblock context passwords before automounting

Melissa Wen (1):
      drm/amd/display: increase MAX_SURFACES to the value supported by hw

Michal Hrusecky (1):
      USB: serial: option: add Neoway N723-EA support

Mike Rapoport (IBM) (1):
      memblock: use numa_valid_node() helper to check for invalid node ID

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

Parker Newman (1):
      net: stmmac: dwmac-tegra: Read iommu stream id from device tree

Pavel Begunkov (1):
      io_uring/timeout: fix multishot updates

Peter Geis (1):
      arm64: dts: rockchip: add hevc power domain clock to rk3328

Peter Xu (1):
      fs/Kconfig: make hugetlbfs a menuconfig

Prashanth K (2):
      usb: dwc3-am62: Disable autosuspend during remove
      usb: gadget: f_uac2: Fix incorrect setting of bNumEndpoints

Przemyslaw Korba (1):
      ice: fix incorrect PHY settings for 100 GB/s

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

Tejun Heo (1):
      workqueue: Update lock debugging code

Toke Høiland-Jørgensen (1):
      sched: sch_cake: add bounds checks to host bulk flow fairness counts

Tvrtko Ursulin (1):
      workqueue: Do not warn when cancelling WQ_MEM_RECLAIM work from !WQ_MEM_RECLAIM worker

Uwe Kleine-König (1):
      iio: adc: ad7124: Disable all channels at probe time

Wei Yang (1):
      memblock tests: fix implicit declaration of function 'numa_valid_node'

Wentao Liang (1):
      ksmbd: fix a missing return value check bug

Xu Lu (1):
      riscv: mm: Fix the out of bound issue of vmemmap address

Xuewen Yan (1):
      workqueue: Add rcu lock check at the end of work item execution

Ye Bin (1):
      f2fs: fix null-ptr-deref in f2fs_submit_page_bio()

Yu Kuai (1):
      block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()

Yuezhang Mo (2):
      exfat: fix the infinite loop in exfat_readdir()
      exfat: fix the infinite loop in __exfat_free_cluster()

Zhang Yi (2):
      jbd2: increase IO priority for writing revoke records
      jbd2: flush filesystem device before updating tail sequence

Zhongqiu Duan (1):
      tcp/dccp: allow a connection when sk_max_ack_backlog is zero

Zicheng Qu (2):
      staging: iio: ad9834: Correct phase range check
      staging: iio: ad9832: Correct phase range check


