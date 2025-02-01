Return-Path: <stable+bounces-111903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2697AA24B31
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 18:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A403A348A
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B62E1CAA84;
	Sat,  1 Feb 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQXRUu7V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD11CAA7C;
	Sat,  1 Feb 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738431946; cv=none; b=mAhfvB0jhzpvL4sfeDgnu94aO0B7RHWhxSyNjtVSd8iqnLu9eWFUp3FBChfCMpvSQ4wvwRTv6h+/RAO+rM0rmZOuysxtyxAzwTNhS2fgi2pk9x3+b1dKUaj/ld/L38QLUTkmHREE4atZwvjEVLjFRWCtlTd8ioGJ9aaoTmvUFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738431946; c=relaxed/simple;
	bh=zj20XjxHAYZYaXclCXde3/Nz5bvs29fz6kD11Hanosk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kcju7AFWfljTvUUCDJOQQCGqb8jb3BD8jXNd6SiN6O3MnsNjUmfi+uvwEwIfafuRpYC7JIttJ0LhwYD/E0oozv7GAB0/L0hdNT9Lb3x0T3/9T815kb6q2MDr0ni1qtW17cmKVaj3d5ySbtRshdFLmo28nujQxI1kpdK5phRb+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQXRUu7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4281EC4CED3;
	Sat,  1 Feb 2025 17:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738431946;
	bh=zj20XjxHAYZYaXclCXde3/Nz5bvs29fz6kD11Hanosk=;
	h=From:To:Cc:Subject:Date:From;
	b=HQXRUu7V29sMfkOFP+mD2ZtlSvBEKG2VnIgBWqvMQ+IeHucb6sdnFdYPBXaIsJ/Lr
	 wFUZ1wpfkkIEI16oiPHvEb3mrco90W1lZfPoMigP0GvMMgoMVzF56bGUapTDMh6Gwc
	 zZ6tZkn47L0KiZjsd1EbLXEK74YwyDRrD5X/tThE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.234
Date: Sat,  1 Feb 2025 18:45:32 +0100
Message-ID: <2025020133-ultimatum-legwork-0940@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.234 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/arm64/boot/dts/rockchip/px30.dtsi               |    8 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi             |    4 
 arch/arm64/boot/dts/rockchip/rk3399.dtsi             |   20 ++++
 arch/m68k/fpsp040/skeleton.S                         |    3 
 arch/m68k/kernel/entry.S                             |    2 
 arch/m68k/kernel/traps.c                             |    2 
 arch/riscv/kernel/traps.c                            |    6 -
 arch/x86/include/asm/special_insns.h                 |    2 
 arch/x86/xen/xen-asm.S                               |    2 
 block/genhd.c                                        |   13 +-
 drivers/acpi/resource.c                              |   18 +++
 drivers/block/loop.c                                 |    8 -
 drivers/block/virtio_blk.c                           |    2 
 drivers/block/xen-blkfront.c                         |    2 
 drivers/gpio/gpiolib-cdev.c                          |    2 
 drivers/gpu/drm/amd/display/dc/dc.h                  |    2 
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h |    8 +
 drivers/gpu/drm/bridge/adv7511/adv7511.h             |    1 
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c         |   17 +--
 drivers/gpu/drm/bridge/adv7511/adv7533.c             |   38 ++-----
 drivers/gpu/drm/drm_mipi_dsi.c                       |   81 ++++++++++++++++
 drivers/gpu/drm/radeon/radeon_gem.c                  |    2 
 drivers/gpu/drm/v3d/v3d_irq.c                        |   12 ++
 drivers/i2c/busses/i2c-rcar.c                        |   20 +++-
 drivers/i2c/muxes/i2c-demux-pinctrl.c                |    4 
 drivers/iio/adc/at91_adc.c                           |    2 
 drivers/iio/adc/rockchip_saradc.c                    |    2 
 drivers/iio/adc/ti-ads124s08.c                       |    4 
 drivers/iio/adc/ti-ads8688.c                         |    2 
 drivers/iio/dummy/iio_simple_dummy_buffer.c          |    2 
 drivers/iio/gyro/fxas21002c_core.c                   |    9 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h          |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c     |   18 +++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c      |    3 
 drivers/iio/imu/kmx61.c                              |    2 
 drivers/iio/inkern.c                                 |    2 
 drivers/iio/light/vcnl4035.c                         |    2 
 drivers/iio/pressure/zpa2326.c                       |    2 
 drivers/infiniband/hw/hns/hns_roce_main.c            |    1 
 drivers/infiniband/hw/hns/hns_roce_srq.c             |    6 -
 drivers/input/joystick/xpad.c                        |    2 
 drivers/input/keyboard/atkbd.c                       |    2 
 drivers/irqchip/irq-gic-v3.c                         |    2 
 drivers/irqchip/irq-sunxi-nmi.c                      |    3 
 drivers/md/dm-ebs-target.c                           |    2 
 drivers/md/dm-thin.c                                 |    5 -
 drivers/md/persistent-data/dm-array.c                |   19 ++-
 drivers/md/raid5.c                                   |   14 +-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c          |   19 ---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c      |    5 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c    |   95 +++++++++++++++----
 drivers/net/ethernet/netronome/nfp/bpf/offload.c     |    3 
 drivers/net/ethernet/ti/cpsw_ale.c                   |   14 +-
 drivers/net/gtp.c                                    |   42 +++++---
 drivers/net/ieee802154/ca8210.c                      |    6 +
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c          |    7 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c          |    9 +
 drivers/nvme/host/core.c                             |    5 -
 drivers/nvme/target/io-cmd-bdev.c                    |    2 
 drivers/pci/controller/pci-host-common.c             |    4 
 drivers/pci/probe.c                                  |   20 ++--
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c    |   53 ++++++++--
 drivers/phy/broadcom/phy-brcm-usb-init.h             |    1 
 drivers/phy/broadcom/phy-brcm-usb.c                  |    8 +
 drivers/scsi/scsi_transport_iscsi.c                  |    4 
 drivers/scsi/sd.c                                    |    9 -
 drivers/scsi/sg.c                                    |    2 
 drivers/staging/iio/frequency/ad9832.c               |    2 
 drivers/staging/iio/frequency/ad9834.c               |    2 
 drivers/usb/class/usblp.c                            |    7 -
 drivers/usb/core/hub.c                               |    6 -
 drivers/usb/core/port.c                              |    7 -
 drivers/usb/dwc3/core.h                              |    1 
 drivers/usb/dwc3/gadget.c                            |    4 
 drivers/usb/gadget/function/f_fs.c                   |    2 
 drivers/usb/host/xhci-pci.c                          |    4 
 drivers/usb/serial/cp210x.c                          |    1 
 drivers/usb/serial/option.c                          |    4 
 drivers/usb/serial/quatech2.c                        |    2 
 drivers/usb/storage/unusual_devs.h                   |    7 +
 drivers/vfio/platform/vfio_platform_common.c         |   10 ++
 fs/afs/afs.h                                         |    2 
 fs/afs/afs_vl.h                                      |    1 
 fs/afs/vl_alias.c                                    |    8 +
 fs/afs/vlclient.c                                    |    2 
 fs/ceph/mds_client.c                                 |    9 -
 fs/exfat/dir.c                                       |    3 
 fs/file.c                                            |    1 
 fs/gfs2/file.c                                       |    1 
 fs/hfs/super.c                                       |    4 
 fs/jbd2/commit.c                                     |    4 
 fs/nfsd/filecache.c                                  |   18 ++-
 fs/nfsd/filecache.h                                  |    1 
 fs/ocfs2/quota_global.c                              |    2 
 fs/ocfs2/quota_local.c                               |   10 --
 fs/proc/vmcore.c                                     |    2 
 include/drm/drm_mipi_dsi.h                           |    4 
 include/linux/blk-cgroup.h                           |    6 +
 include/linux/genhd.h                                |    3 
 include/linux/hrtimer.h                              |    1 
 include/linux/mlx5/device.h                          |    2 
 include/linux/mlx5/fs.h                              |    2 
 include/linux/poll.h                                 |   10 +-
 include/linux/seccomp.h                              |    2 
 include/linux/usb.h                                  |    3 
 include/linux/usb/hcd.h                              |    2 
 include/net/inet_connection_sock.h                   |    2 
 include/net/net_namespace.h                          |    3 
 include/net/netfilter/nf_tables.h                    |    2 
 kernel/cpu.c                                         |    2 
 kernel/gen_kheaders.sh                               |    1 
 kernel/time/hrtimer.c                                |   11 ++
 mm/vmalloc.c                                         |    3 
 net/802/psnap.c                                      |    4 
 net/bluetooth/rfcomm/sock.c                          |   14 +-
 net/core/filter.c                                    |   30 +++---
 net/core/net_namespace.c                             |   83 ++++++++++------
 net/dccp/ipv6.c                                      |    2 
 net/ipv4/fou.c                                       |    2 
 net/ipv4/ip_tunnel.c                                 |    2 
 net/ipv6/route.c                                     |    2 
 net/ipv6/tcp_ipv6.c                                  |    4 
 net/mac802154/iface.c                                |    4 
 net/netfilter/nf_conntrack_core.c                    |    5 -
 net/netfilter/nf_tables_api.c                        |   38 ++++++-
 net/netfilter/nft_dynset.c                           |    7 +
 net/sched/cls_flow.c                                 |    3 
 net/sched/sch_ets.c                                  |    2 
 net/sctp/sysctl.c                                    |    9 +
 net/tls/tls_sw.c                                     |    2 
 net/vmw_vsock/af_vsock.c                             |   15 +++
 net/vmw_vsock/virtio_transport_common.c              |   36 +++++--
 scripts/sorttable.h                                  |   10 +-
 sound/soc/codecs/Kconfig                             |    1 
 sound/soc/mediatek/common/mtk-afe-platform-driver.c  |    4 
 sound/soc/samsung/Kconfig                            |    6 -
 137 files changed, 813 insertions(+), 354 deletions(-)

Aharon Landau (1):
      net/mlx5: Add priorities for counters in RDMA namespaces

Ahmad Fatoum (1):
      drm: bridge: adv7511: use dev_err_probe in probe function

Akash M (1):
      usb: gadget: f_fs: Remove WARN_ON in functionfs_bind

Al Cooper (1):
      phy: usb: Add "wake on" functionality for newer Synopsis XHCI controllers

Al Viro (1):
      m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal

Alex Williamson (1):
      vfio/platform: check the bounds of read/write syscalls

Alvin Šipraga (1):
      drm: bridge: adv7511: unregister cec i2c device after cec adapter

Andreas Gruenbacher (1):
      gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag

André Draszik (1):
      usb: dwc3: gadget: fix writing NYET threshold

Anjaneyulu (1):
      wifi: iwlwifi: add a few rate index validity checks

Antonio Pastor (1):
      net: 802: LLC+SNAP OID:PID lookup on start of skb data

Anumula Murali Mohan Reddy (1):
      cxgb4: Avoid removal of uninserted tid

Arnd Bergmann (1):
      xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals

Benjamin Coddington (1):
      tls: Fix tls_sw_sendmsg error handling

Biju Das (1):
      drm: adv7511: Fix use-after-free in adv7533_attach_dsi()

Carlos Song (1):
      iio: gyro: fxas21002c: Fix missing data update in trigger handler

Charles Keepax (3):
      ASoC: wm8994: Add depends on MFD core
      ASoC: samsung: Add missing selects for MFD_WM8994
      ASoC: samsung: Add missing depends on I2C

Chen-Yu Tsai (1):
      ASoC: mediatek: disable buffer pre-allocation

Chengchang Tang (1):
      RDMA/hns: Fix deadlock on SRQ async events.

Christoph Hellwig (4):
      loop: let set_capacity_revalidate_and_notify update the bdev size
      nvme: let set_capacity_revalidate_and_notify update the bdev size
      sd: update the bdev size in sd_revalidate_disk
      block: remove the update_bdev parameter to set_capacity_revalidate_and_notify

Chukun Pan (1):
      USB: serial: option: add MeiG Smart SRM815

Dan Carpenter (1):
      nfp: bpf: prevent integer overflow in nfp_bpf_event_output()

David Howells (2):
      afs: Fix the maximum cell name length
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
      Linux 5.10.234

Gui-Dong Han (1):
      md/raid5: fix atomicity violation in raid5_cache_count

Hans de Goede (2):
      ACPI: resource: Add TongFang GM5HG0A to irq1_edge_low_force_override[]
      ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]

Heiner Kallweit (1):
      net: ethernet: xgbe: re-add aneg to supported features in PHY quirks

Ido Schimmel (1):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()

Jack Greiner (1):
      Input: xpad - add support for wooting two he (arm)

Jamal Hadi Salim (1):
      net: sched: fix ets qdisc OOB Indexing

Jason Xing (1):
      tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog

Javier Carrasco (6):
      iio: pressure: zpa2326: fix information leak in triggered buffer
      iio: dummy: iio_simply_dummy_buffer: fix information leak in triggered buffer
      iio: light: vcnl4035: fix information leak in triggered buffer
      iio: imu: kmx61: fix information leak in triggered buffer
      iio: adc: ti-ads8688: fix information leak in triggered buffer
      iio: adc: rockchip_saradc: fix information leak in triggered buffer

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: fix spi burst write not supported
      iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on

Joe Hattori (2):
      iio: adc: at91: call input_free_device() on allocated iio_dev
      iio: inkern: call iio_device_put() only on mapped devices

Johan Hovold (1):
      USB: serial: cp210x: add Phoenix Contact UPS Device

Johan Jonker (1):
      arm64: dts: rockchip: add #power-domain-cells to power domain nodes

Joseph Qi (1):
      ocfs2: correct return value of ocfs2_local_free_info()

Juergen Gross (2):
      x86/asm: Make serialize() always_inline
      x86/xen: fix SLS mitigation in xen_hypercall_iret()

Jun Yan (1):
      USB: usblp: return error when setting unsupported protocol

Justin Chen (3):
      phy: usb: Toggle the PHY power during init
      phy: usb: Use slow clock for wake enabled suspend
      phy: usb: Fix clock imbalance for suspend/resume

Kai-Heng Feng (1):
      USB: core: Disable LPM only for non-suspended ports

Keisuke Nishimura (1):
      ieee802154: ca8210: Add missing check for kfifo_alloc() in ca8210_probe()

Koichiro Den (1):
      hrtimers: Handle CPU state correctly on hotplug

Krister Johansen (1):
      dm thin: make get_first_thin use rcu-safe list first function

Kuan-Wei Chiu (1):
      scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity

Kuniyuki Iwashima (2):
      gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
      gtp: Destroy device along with udp socket's netns dismantle.

Leo Stone (1):
      hfs: Sanity check the root record

Lianqin Hu (1):
      usb: gadget: u_serial: Disable ep before setting port to null to fix the crash caused by port being null

Linus Walleij (1):
      seccomp: Stub for !CONFIG_SECCOMP

Lizhi Xu (1):
      mac802154: check local interfaces before deleting sdata list

Lubomir Rintel (1):
      usb-storage: Add max sectors quirk for Nokia 208

Luis Chamberlain (1):
      nvmet: propagate npwg topology

Luiz Augusto von Dentz (1):
      Bluetooth: RFCOMM: Fix not validating setsockopt user input

Ma Ke (1):
      usb: fix reference leak in usb_new_device()

Maor Gottlieb (1):
      net/mlx5: Refactor mlx5_get_flow_namespace

Mark Pearson (1):
      Input: atkbd - map F23 key to support default copilot shortcut

Matthew Wilcox (Oracle) (1):
      vmalloc: fix accounting with i915

Matthieu Baerts (NGI0) (3):
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy
      sctp: sysctl: rto_min/max: avoid using current->nsproxy

Max Kellermann (1):
      ceph: give up on paths longer than PATH_MAX

Maxime Ripard (3):
      drm/mipi-dsi: Create devm device registration
      drm/mipi-dsi: Create devm device attachment
      drm/bridge: adv7533: Switch to devm MIPI-DSI helpers

Maíra Canal (2):
      drm/v3d: Ensure job pointer is set to NULL after job completion
      drm/v3d: Assign job pointer to NULL before signaling the fence

Melissa Wen (1):
      drm/amd/display: increase MAX_SURFACES to the value supported by hw

Michal Hrusecky (1):
      USB: serial: option: add Neoway N723-EA support

Michal Luczaj (1):
      bpf: Fix bpf_sk_select_reuseport() memory leak

Mikulas Patocka (1):
      dm-ebs: don't set the flag DM_TARGET_PASSES_INTEGRITY

Ming-Hung Tsai (3):
      dm array: fix releasing a faulty array block twice in dm_array_cursor_end
      dm array: fix unreleased btree blocks on closing a faulty array cursor
      dm array: fix cursor index when skipping across block boundaries

Nam Cao (1):
      riscv: Fix sleeping in invalid context in die()

Nilton Perim Neto (1):
      Input: xpad - add unofficial Xbox 360 wireless receiver clone

Oleg Nesterov (1):
      poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()

Pablo Neira Ayuso (3):
      netfilter: nft_dynset: honor stateful expressions in set definition
      netfilter: nf_tables: imbalance in flowtable binding
      netfilter: conntrack: clamp maximum hashtable size to INT_MAX

Patrisious Haddad (1):
      net/mlx5: Fix RDMA TX steering prio

Peter Geis (1):
      arm64: dts: rockchip: add hevc power domain clock to rk3328

Philippe Simons (1):
      irqchip/sunxi-nmi: Add missing SKIP_WAKE flag

Pierre-Eric Pelloux-Prayer (1):
      drm/radeon: check bo_va->bo is non-NULL before using it

Qasim Ijaz (1):
      USB: serial: quatech2: fix null-ptr-deref in qt2_process_read_urb()

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore (part 2)

Roman Li (1):
      drm/amd/display: Add check for granularity in dml ceil/floor helpers

Ron Economos (1):
      Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals

Stefano Garzarella (4):
      vsock/virtio: cancel close work in the destructor
      vsock: reset socket state when de-assigning the transport
      vsock/virtio: discard packets if the transport changes
      vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]

Sudheer Kumar Doredla (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()

Suraj Sonawane (1):
      scsi: sg: Fix slab-use-after-free read in sg_release()

Tejun Heo (1):
      blk-cgroup: Fix UAF in blkcg_unpin_online()

Terry Tritton (1):
      Revert "PCI: Use preserve_config in place of pci_flags"

Wang Liang (1):
      net: fix data-races around sk->sk_forward_alloc

Willem de Bruijn (1):
      fou: remove warn in gue_gro_receive on unsupported protocol

Wolfram Sang (2):
      i2c: mux: demux-pinctrl: check initial mux selection, too
      i2c: rcar: fix NACK handling when being a target

Xiang Zhang (1):
      scsi: iscsi: Fix redundant response for ISCSI_UEVENT_GET_HOST_STATS request

Xu Wang (1):
      drm: bridge: adv7511: Remove redundant null check before clk_disable_unprepare

Yajun Deng (1):
      net: net_namespace: Optimize the code

Yogesh Lal (1):
      irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly

Youzhong Yang (1):
      nfsd: add list_head nf_gc to struct nfsd_file

Yuezhang Mo (1):
      exfat: fix the infinite loop in exfat_readdir()

Zhang Kunbo (1):
      fs: fix missing declaration of init_files

Zhang Yi (1):
      jbd2: flush filesystem device before updating tail sequence

Zhongqiu Duan (1):
      tcp/dccp: allow a connection when sk_max_ack_backlog is zero

Zhongqiu Han (1):
      gpiolib: cdev: Fix use after free in lineinfo_changed_notify

Zicheng Qu (2):
      staging: iio: ad9834: Correct phase range check
      staging: iio: ad9832: Correct phase range check


