Return-Path: <stable+bounces-111901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E12A24B2E
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A0D3A2851
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660431C3BEE;
	Sat,  1 Feb 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uQ/jVgTu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9F1BC9FB;
	Sat,  1 Feb 2025 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431932; cv=none; b=qEcsSsLfiOGIpO+b31DhnnGGf7++gw9nuoisNPZl+Tv2aN3CNDNj5mQBxV6EtfejI+W6tLZulOAs7e8/ZHV2fD0xNGyPu9EfHYgO3ACN9yZg1fFtPNjR2e0k2dDDkafd3+zKkHIVq0v2XJnLuIxvS+/j5UPmTU2lAfc1l/7rt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431932; c=relaxed/simple;
	bh=TaMUPs6jCYL9/yAQOtVovV2lfqj1rGYaRd3kOUq5nVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PtytOV5l0d//g7OU2PPiIlCd8wq/OSfD8XaNyaslpIrGG8wMBfXrHIKV+ml22tiA4PPt7817ymWpJXjvwGNLOLXTDcdnvEfABeIXM/XNWMv5Lr0oAq0GxCdzYszplOv4+SX6EFvdEiDoWezMtG5isfr5Kgo9pCqj7P2XorJTSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uQ/jVgTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E075DC4CED3;
	Sat,  1 Feb 2025 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738431931;
	bh=TaMUPs6jCYL9/yAQOtVovV2lfqj1rGYaRd3kOUq5nVo=;
	h=From:To:Cc:Subject:Date:From;
	b=uQ/jVgTu56zAZ8IHYTPQ/Qvjwl2Vf+2pF9Ph7Hm4whbh9D3hyXR0SOHIiBDXl5WW7
	 Dptgk7lsT7X6kJGhN/SwvH2XDw0Fcn8ZFK/zpXep/IlcgAGV+qhRgYtV89z4poj2DO
	 Q7/MrvtLeBGI3Kpc33HQJO/rCPsUUj8NjV3q4X/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.290
Date: Sat,  1 Feb 2025 18:45:25 +0100
Message-ID: <2025020126-bottling-drew-1dae@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.290 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/arm64/boot/dts/rockchip/px30.dtsi               |    8 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi             |    4 
 arch/arm64/boot/dts/rockchip/rk3399.dtsi             |   40 ++++++---
 arch/m68k/fpsp040/skeleton.S                         |    3 
 arch/m68k/kernel/entry.S                             |    2 
 arch/m68k/kernel/sys_m68k.c                          |    2 
 arch/m68k/kernel/traps.c                             |    2 
 drivers/acpi/resource.c                              |   18 ++++
 drivers/gpu/drm/amd/display/dc/dc.h                  |    2 
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h |    8 +
 drivers/gpu/drm/v3d/v3d_irq.c                        |   12 ++
 drivers/i2c/muxes/i2c-demux-pinctrl.c                |    4 
 drivers/iio/adc/at91_adc.c                           |    2 
 drivers/iio/adc/ti-ads124s08.c                       |    4 
 drivers/iio/adc/ti-ads8688.c                         |    2 
 drivers/iio/dummy/iio_simple_dummy_buffer.c          |    2 
 drivers/iio/gyro/fxas21002c_core.c                   |    9 +-
 drivers/iio/imu/kmx61.c                              |    2 
 drivers/iio/inkern.c                                 |    2 
 drivers/iio/light/vcnl4035.c                         |    2 
 drivers/iio/pressure/zpa2326.c                       |    2 
 drivers/input/joystick/xpad.c                        |    2 
 drivers/input/keyboard/atkbd.c                       |    2 
 drivers/irqchip/irq-gic-v3.c                         |    2 
 drivers/irqchip/irq-sunxi-nmi.c                      |    3 
 drivers/md/dm-thin.c                                 |    5 -
 drivers/md/persistent-data/dm-array.c                |   19 ++--
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c          |   19 ----
 drivers/net/ethernet/netronome/nfp/bpf/offload.c     |    3 
 drivers/net/ethernet/ti/cpsw_ale.c                   |   14 +--
 drivers/net/gtp.c                                    |   42 +++++----
 drivers/net/ieee802154/ca8210.c                      |    6 +
 drivers/net/xen-netback/hash.c                       |    7 -
 drivers/nvme/target/io-cmd-bdev.c                    |    2 
 drivers/phy/phy-core.c                               |    7 -
 drivers/scsi/scsi_transport_iscsi.c                  |    4 
 drivers/scsi/sg.c                                    |    2 
 drivers/staging/iio/frequency/ad9832.c               |    2 
 drivers/staging/iio/frequency/ad9834.c               |    2 
 drivers/usb/class/usblp.c                            |    7 -
 drivers/usb/core/hub.c                               |    6 -
 drivers/usb/core/port.c                              |    7 -
 drivers/usb/gadget/function/f_fs.c                   |    2 
 drivers/usb/serial/cp210x.c                          |    1 
 drivers/usb/serial/option.c                          |    4 
 drivers/usb/serial/quatech2.c                        |    2 
 drivers/usb/storage/unusual_devs.h                   |    7 +
 drivers/vfio/platform/vfio_platform_common.c         |   10 ++
 fs/ext4/ext4.h                                       |    1 
 fs/ext4/extents.c                                    |   64 ++++++++++++--
 fs/gfs2/file.c                                       |    1 
 fs/hfs/super.c                                       |    4 
 fs/jbd2/commit.c                                     |    4 
 fs/ocfs2/quota_global.c                              |    2 
 fs/ocfs2/quota_local.c                               |   10 --
 fs/proc/vmcore.c                                     |    2 
 include/linux/hrtimer.h                              |    1 
 include/linux/poll.h                                 |   10 ++
 include/linux/usb.h                                  |    3 
 include/linux/usb/hcd.h                              |    2 
 include/net/inet_connection_sock.h                   |    2 
 include/net/net_namespace.h                          |    3 
 kernel/cpu.c                                         |    2 
 kernel/gen_kheaders.sh                               |    1 
 kernel/time/hrtimer.c                                |   11 ++
 net/802/psnap.c                                      |    4 
 net/core/net_namespace.c                             |   83 ++++++++++++-------
 net/dccp/ipv6.c                                      |    2 
 net/ipv6/route.c                                     |    2 
 net/ipv6/tcp_ipv6.c                                  |    4 
 net/mac802154/iface.c                                |    4 
 net/sched/cls_flow.c                                 |    3 
 net/sctp/sysctl.c                                    |    9 +-
 net/tls/tls_sw.c                                     |    2 
 sound/soc/codecs/Kconfig                             |    1 
 76 files changed, 387 insertions(+), 173 deletions(-)

Akash M (1):
      usb: gadget: f_fs: Remove WARN_ON in functionfs_bind

Al Viro (1):
      m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Andreas Gruenbacher (1):
      gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag

Antonio Pastor (1):
      net: 802: LLC+SNAP OID:PID lookup on start of skb data

Arnd Bergmann (1):
      xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals

Baokun Li (1):
      ext4: fix slab-use-after-free in ext4_split_extent_at()

Benjamin Coddington (1):
      tls: Fix tls_sw_sendmsg error handling

Carlos Song (1):
      iio: gyro: fxas21002c: Fix missing data update in trigger handler

Charles Keepax (1):
      ASoC: wm8994: Add depends on MFD core

Chukun Pan (1):
      USB: serial: option: add MeiG Smart SRM815

Dan Carpenter (1):
      nfp: bpf: prevent integer overflow in nfp_bpf_event_output()

David Howells (1):
      kheaders: Ignore silly-rename files

Dennis Lam (1):
      ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv

Eric Dumazet (4):
      net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute
      net: add exit_batch_rtnl() method
      gtp: use exit_batch_rtnl() method
      ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()

Eric W. Biederman (1):
      signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die

Fabio Estevam (1):
      iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()

Greg Kroah-Hartman (2):
      Revert "usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null"
      Linux 5.4.290

Hans de Goede (2):
      ACPI: resource: Add TongFang GM5HG0A to irq1_edge_low_force_override[]
      ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]

Heiner Kallweit (1):
      net: ethernet: xgbe: re-add aneg to supported features in PHY quirks

Jack Greiner (1):
      Input: xpad - add support for wooting two he (arm)

Jason Xing (1):
      tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog

Javier Carrasco (5):
      iio: pressure: zpa2326: fix information leak in triggered buffer
      iio: dummy: iio_simply_dummy_buffer: fix information leak in triggered buffer
      iio: light: vcnl4035: fix information leak in triggered buffer
      iio: imu: kmx61: fix information leak in triggered buffer
      iio: adc: ti-ads8688: fix information leak in triggered buffer

Jeongjun Park (1):
      net/xen-netback: prevent UAF in xenvif_flush_hash()

Joe Hattori (2):
      iio: adc: at91: call input_free_device() on allocated iio_dev
      iio: inkern: call iio_device_put() only on mapped devices

Johan Hovold (1):
      USB: serial: cp210x: add Phoenix Contact UPS Device

Johan Jonker (3):
      arm64: dts: rockchip: fix defines in pd_vio node for rk3399
      arm64: dts: rockchip: fix pd_tcpc0 and pd_tcpc1 node position on rk3399
      arm64: dts: rockchip: add #power-domain-cells to power domain nodes

Joseph Qi (1):
      ocfs2: correct return value of ocfs2_local_free_info()

Jun Yan (1):
      USB: usblp: return error when setting unsupported protocol

Kai-Heng Feng (1):
      USB: core: Disable LPM only for non-suspended ports

Keisuke Nishimura (1):
      ieee802154: ca8210: Add missing check for kfifo_alloc() in ca8210_probe()

Koichiro Den (1):
      hrtimers: Handle CPU state correctly on hotplug

Krister Johansen (1):
      dm thin: make get_first_thin use rcu-safe list first function

Kuniyuki Iwashima (2):
      gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
      gtp: Destroy device along with udp socket's netns dismantle.

Leo Stone (1):
      hfs: Sanity check the root record

Liam Howlett (1):
      m68k: Add missing mmap_read_lock() to sys_cacheflush()

Lianqin Hu (1):
      usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null

Lizhi Xu (1):
      mac802154: check local interfaces before deleting sdata list

Lubomir Rintel (1):
      usb-storage: Add max sectors quirk for Nokia 208

Luis Chamberlain (1):
      nvmet: propagate npwg topology

Ma Ke (1):
      usb: fix reference leak in usb_new_device()

Madhuparna Bhowmik (1):
      net: xen-netback: hash.c: Use built-in RCU list checking

Mark Pearson (1):
      Input: atkbd - map F23 key to support default copilot shortcut

Matthieu Baerts (NGI0) (3):
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy
      sctp: sysctl: rto_min/max: avoid using current->nsproxy

Maíra Canal (2):
      drm/v3d: Ensure job pointer is set to NULL after job completion
      drm/v3d: Assign job pointer to NULL before signaling the fence

Melissa Wen (1):
      drm/amd/display: increase MAX_SURFACES to the value supported by hw

Michal Hrusecky (1):
      USB: serial: option: add Neoway N723-EA support

Ming-Hung Tsai (3):
      dm array: fix releasing a faulty array block twice in dm_array_cursor_end
      dm array: fix unreleased btree blocks on closing a faulty array cursor
      dm array: fix cursor index when skipping across block boundaries

Nilton Perim Neto (1):
      Input: xpad - add unofficial Xbox 360 wireless receiver clone

Oleg Nesterov (1):
      poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()

Peter Geis (1):
      arm64: dts: rockchip: add hevc power domain clock to rk3328

Philippe Simons (1):
      irqchip/sunxi-nmi: Add missing SKIP_WAKE flag

Qasim Ijaz (1):
      USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore (part 2)

Roman Li (1):
      drm/amd/display: Add check for granularity in dml ceil/floor helpers

Ron Economos (1):
      Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals

Sudheer Kumar Doredla (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()

Suraj Sonawane (1):
      scsi: sg: Fix slab-use-after-free read in sg_release()

Theodore Ts'o (1):
      ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path

Vinod Koul (1):
      phy: core: fix code style in devm_of_phy_provider_unregister

Wang Liang (1):
      net: fix data-races around sk->sk_forward_alloc

Wolfram Sang (1):
      i2c: mux: demux-pinctrl: check initial mux selection, too

Xiang Zhang (1):
      scsi: iscsi: Fix redundant response for ISCSI_UEVENT_GET_HOST_STATS request

Yajun Deng (1):
      net: net_namespace: Optimize the code

Yogesh Lal (1):
      irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly

Zhang Yi (1):
      jbd2: flush filesystem device before updating tail sequence

Zhongqiu Duan (1):
      tcp/dccp: allow a connection when sk_max_ack_backlog is zero

Zicheng Qu (2):
      staging: iio: ad9834: Correct phase range check
      staging: iio: ad9832: Correct phase range check

Zijun Hu (1):
      phy: core: Fix that API devm_of_phy_provider_unregister() fails to unregister the phy provider


