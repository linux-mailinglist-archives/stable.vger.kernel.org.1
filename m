Return-Path: <stable+bounces-109360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2F8A1502E
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AC13A3A0B
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94C201266;
	Fri, 17 Jan 2025 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJDrV1Sx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B77201031;
	Fri, 17 Jan 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119254; cv=none; b=G8t2Bmh9VgyH6GzolHOjj/mlogyls+4j1N8LlpdKewmzihq7SyF1D2cXlKvlAkK/e6uYxQBAXwE6WgQXkqCin7O3EYz77cFf66m3oKxK7+DilqweEOgWPA88xDv5THsSvbQbXKXQW5VQf0hZvBHdIvFPWtP94wYZsGdVpyAKuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119254; c=relaxed/simple;
	bh=9iOK1/CVlssSGxWX2Cx3NCa1amLVztIo/7GN1neNDUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mYOcoedAMnBu/UIBSRh2wip3sVAYtiimozqw4aU2PExFUVUokqWlkeYEvlZ1vhLHCuYdrT/g51K2DJGTvVP0AScwkC5/jEoxkBojMYNCqG2xSfKoLV+YZwTKx3yzbLGcZBvPAVa5knKR3JgNRGVdV5DxZipN9ga2WQjM0bwY88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJDrV1Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E142C4CEDF;
	Fri, 17 Jan 2025 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737119253;
	bh=9iOK1/CVlssSGxWX2Cx3NCa1amLVztIo/7GN1neNDUw=;
	h=From:To:Cc:Subject:Date:From;
	b=JJDrV1SxPOg/mg8REZR68Xd7JDtcBEiYfJs5LEDF9w1rPN+Z+RvnJaE2hPeayLdpc
	 nmn6vvAe97eixGu5NCkH8gqRBVasfIQ5fZMRgdDoPpkLqzzt36Md5aCW/+1MA8vdNG
	 KlrMEKkXPoCqwtsYF/CVsU92vnp73W4BJ13S8TjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.125
Date: Fri, 17 Jan 2025 14:07:28 +0100
Message-ID: <2025011725-urging-clubhouse-273f@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.125 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/arm/boot/dts/imxrt1050.dtsi                     |    2 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi             |    1 
 arch/riscv/kernel/traps.c                            |    6 
 block/bfq-iosched.c                                  |   12 +
 drivers/acpi/resource.c                              |   18 ++
 drivers/base/topology.c                              |   24 ++-
 drivers/cpuidle/cpuidle-riscv-sbi.c                  |    4 
 drivers/gpu/drm/amd/display/dc/dc.h                  |    2 
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h |    8 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c         |    8 -
 drivers/gpu/drm/bridge/adv7511/adv7533.c             |   22 +-
 drivers/gpu/drm/mediatek/Kconfig                     |    5 
 drivers/gpu/drm/mediatek/mtk_dp.c                    |   46 +++---
 drivers/iio/adc/ad7124.c                             |    3 
 drivers/iio/adc/at91_adc.c                           |    2 
 drivers/iio/adc/ti-ads124s08.c                       |    4 
 drivers/iio/adc/ti-ads8688.c                         |    2 
 drivers/iio/dummy/iio_simple_dummy_buffer.c          |    2 
 drivers/iio/gyro/fxas21002c_core.c                   |    9 +
 drivers/iio/imu/kmx61.c                              |    2 
 drivers/iio/inkern.c                                 |    2 
 drivers/iio/light/vcnl4035.c                         |    2 
 drivers/iio/pressure/zpa2326.c                       |    2 
 drivers/md/dm-ebs-target.c                           |    2 
 drivers/md/dm-thin.c                                 |    5 
 drivers/md/dm-verity-fec.c                           |   39 +++--
 drivers/md/persistent-data/dm-array.c                |   19 +-
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c      |    4 
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c        |    3 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c      |    5 
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c        |    1 
 drivers/net/ieee802154/ca8210.c                      |    6 
 drivers/of/address.c                                 |   76 +++++++---
 drivers/of/unittest-data/tests-address.dtsi          |    9 +
 drivers/of/unittest.c                                |  109 ++++++++++++++
 drivers/staging/iio/frequency/ad9832.c               |    2 
 drivers/staging/iio/frequency/ad9834.c               |    2 
 drivers/thermal/thermal_of.c                         |    1 
 drivers/usb/class/usblp.c                            |    7 
 drivers/usb/core/hub.c                               |    6 
 drivers/usb/core/port.c                              |    7 
 drivers/usb/dwc3/core.h                              |    1 
 drivers/usb/dwc3/dwc3-am62.c                         |    1 
 drivers/usb/dwc3/gadget.c                            |    4 
 drivers/usb/gadget/function/f_fs.c                   |    2 
 drivers/usb/gadget/function/f_uac2.c                 |    1 
 drivers/usb/gadget/function/u_serial.c               |    8 -
 drivers/usb/host/xhci-pci.c                          |    8 -
 drivers/usb/serial/cp210x.c                          |    1 
 drivers/usb/serial/option.c                          |    4 
 drivers/usb/storage/unusual_devs.h                   |    7 
 fs/afs/afs.h                                         |    2 
 fs/afs/afs_vl.h                                      |    1 
 fs/afs/vl_alias.c                                    |    8 -
 fs/afs/vlclient.c                                    |    2 
 fs/ceph/mds_client.c                                 |    9 -
 fs/exfat/dir.c                                       |    3 
 fs/exfat/fatent.c                                    |   10 +
 fs/jbd2/commit.c                                     |    4 
 fs/jbd2/revoke.c                                     |    2 
 fs/ocfs2/quota_global.c                              |    2 
 fs/ocfs2/quota_local.c                               |   10 -
 fs/smb/server/smb2pdu.c                              |    3 
 fs/smb/server/vfs.c                                  |    3 
 include/linux/bpf.h                                  |   14 +
 include/linux/sched/task_stack.h                     |    2 
 include/linux/usb.h                                  |    3 
 include/linux/usb/hcd.h                              |    2 
 include/net/inet_connection_sock.h                   |    2 
 io_uring/io_uring.c                                  |   13 +
 kernel/bpf/helpers.c                                 |   10 -
 kernel/bpf/ringbuf.c                                 |    2 
 kernel/bpf/syscall.c                                 |    2 
 kernel/bpf/verifier.c                                |   76 ++++------
 kernel/trace/bpf_trace.c                             |    4 
 net/802/psnap.c                                      |    4 
 net/bluetooth/hci_sync.c                             |   11 -
 net/core/filter.c                                    |    4 
 net/core/sock_map.c                                  |    6 
 net/ipv4/tcp_ipv4.c                                  |    2 
 net/netfilter/nf_conntrack_core.c                    |    5 
 net/netfilter/nf_tables_api.c                        |   15 +-
 net/sched/cls_flow.c                                 |    3 
 net/sched/sch_cake.c                                 |  140 ++++++++++---------
 net/sctp/sysctl.c                                    |   14 +
 net/tls/tls_sw.c                                     |    2 
 scripts/sorttable.h                                  |    6 
 sound/soc/mediatek/common/mtk-afe-platform-driver.c  |    4 
 90 files changed, 624 insertions(+), 315 deletions(-)

Ahmad Fatoum (1):
      drm: bridge: adv7511: use dev_err_probe in probe function

Akash M (1):
      usb: gadget: f_fs: Remove WARN_ON in functionfs_bind

Andrea della Porta (1):
      of: address: Preserve the flags portion on 1:1 dma-ranges mapping

André Draszik (1):
      usb: dwc3: gadget: fix writing NYET threshold

Antonio Pastor (1):
      net: 802: LLC+SNAP OID:PID lookup on start of skb data

Anumula Murali Mohan Reddy (1):
      cxgb4: Avoid removal of uninserted tid

Arnd Bergmann (2):
      drm/mediatek: stop selecting foreign drivers
      xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals

Benjamin Coddington (1):
      tls: Fix tls_sw_sendmsg error handling

Biju Das (1):
      drm: adv7511: Fix use-after-free in adv7533_attach_dsi()

Carlos Song (1):
      iio: gyro: fxas21002c: Fix missing data update in trigger handler

Chen-Yu Tsai (1):
      ASoC: mediatek: disable buffer pre-allocation

Chenguang Zhao (1):
      net/mlx5: Fix variable not being completed when function returns

Chukun Pan (1):
      USB: serial: option: add MeiG Smart SRM815

Daniel Borkmann (3):
      tcp: Annotate data-race around sk->sk_mark in tcp_v4_send_reset
      bpf: Add MEM_WRITE attribute
      bpf: Fix overloading of MEM_UNINIT's meaning

David Howells (1):
      afs: Fix the maximum cell name length

Dennis Lam (1):
      ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv

Eric Dumazet (1):
      net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute

Fabio Estevam (1):
      iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()

Greg Kroah-Hartman (1):
      Linux 6.1.125

Hans de Goede (2):
      ACPI: resource: Add TongFang GM5HG0A to irq1_edge_low_force_override[]
      ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]

He Wang (1):
      ksmbd: fix unexpectedly changed path in ksmbd_vfs_kern_path_locked

Herve Codina (2):
      of: address: Fix address translation when address-size is greater than 2
      of: address: Remove duplicated functions

Jason Xing (1):
      tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog

Javier Carrasco (6):
      cpuidle: riscv-sbi: fix device node release in early exit of for_each_possible_cpu
      iio: pressure: zpa2326: fix information leak in triggered buffer
      iio: dummy: iio_simply_dummy_buffer: fix information leak in triggered buffer
      iio: light: vcnl4035: fix information leak in triggered buffer
      iio: imu: kmx61: fix information leak in triggered buffer
      iio: adc: ti-ads8688: fix information leak in triggered buffer

Jens Axboe (1):
      io_uring/eventfd: ensure io_eventfd_signal() defers another RCU period

Jesse Taube (1):
      ARM: dts: imxrt1050: Fix clocks for mmc

Joe Hattori (3):
      thermal: of: fix OF node leak in of_thermal_zone_find()
      iio: adc: at91: call input_free_device() on allocated iio_dev
      iio: inkern: call iio_device_put() only on mapped devices

Johan Hovold (1):
      USB: serial: cp210x: add Phoenix Contact UPS Device

Joseph Qi (1):
      ocfs2: correct return value of ocfs2_local_free_info()

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

Kuan-Wei Chiu (1):
      scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity

Li Huafei (1):
      topology: Keep the cpumask unchanged when printing cpumap

Liankun Yang (3):
      drm/mediatek: Fix YCbCr422 color format issue for DP
      drm/mediatek: Fix mode valid issue for dp
      drm/mediatek: Add return value check when reading DPCD

Lianqin Hu (1):
      usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null

Lubomir Rintel (1):
      usb-storage: Add max sectors quirk for Nokia 208

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not setting Random Address when required

Ma Ke (1):
      usb: fix reference leak in usb_new_device()

Matthieu Baerts (NGI0) (5):
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: rto_min/max: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy
      sctp: sysctl: udp_port: avoid using current->nsproxy
      sctp: sysctl: plpmtud_probe_interval: avoid using current->nsproxy

Max Kellermann (1):
      ceph: give up on paths longer than PATH_MAX

Melissa Wen (1):
      drm/amd/display: increase MAX_SURFACES to the value supported by hw

Michal Hrusecky (1):
      USB: serial: option: add Neoway N723-EA support

Michal Luczaj (1):
      bpf, sockmap: Fix race between element replace and close()

Mikulas Patocka (1):
      dm-ebs: don't set the flag DM_TARGET_PASSES_INTEGRITY

Milan Broz (1):
      dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)

Ming-Hung Tsai (3):
      dm array: fix releasing a faulty array block twice in dm_array_cursor_end
      dm array: fix unreleased btree blocks on closing a faulty array cursor
      dm array: fix cursor index when skipping across block boundaries

Nam Cao (1):
      riscv: Fix sleeping in invalid context in die()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: imbalance in flowtable binding
      netfilter: conntrack: clamp maximum hashtable size to INT_MAX

Peter Geis (1):
      arm64: dts: rockchip: add hevc power domain clock to rk3328

Prashanth K (2):
      usb: dwc3-am62: Disable autosuspend during remove
      usb: gadget: f_uac2: Fix incorrect setting of bNumEndpoints

Przemyslaw Korba (1):
      ice: fix incorrect PHY settings for 100 GB/s

Qun-Wei Lin (1):
      sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers

Rengarajan S (2):
      misc: microchip: pci1xxxx: Resolve kernel panic during GPIO IRQ handling
      misc: microchip: pci1xxxx: Resolve return code mismatch during GPIO set config

Rob Herring (3):
      of: unittest: Add bus address range parsing tests
      of/address: Add support for 3 address cell bus
      of: address: Store number of bus flag cells rather than bool

Roman Li (1):
      drm/amd/display: Add check for granularity in dml ceil/floor helpers

Toke Høiland-Jørgensen (1):
      sched: sch_cake: add bounds checks to host bulk flow fairness counts

Uwe Kleine-König (1):
      iio: adc: ad7124: Disable all channels at probe time

Wentao Liang (1):
      ksmbd: fix a missing return value check bug

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


