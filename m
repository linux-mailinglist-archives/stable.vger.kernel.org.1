Return-Path: <stable+bounces-110303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747ABA1A896
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E3E3B01FF
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628C145B26;
	Thu, 23 Jan 2025 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ofWWfRDw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA9130499;
	Thu, 23 Jan 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652181; cv=none; b=dBelojGjaxZG/UJzJW159aKYxHI0S3iu3ear9umpsAyh8FdXmDNWY85eyiNVom8fH0Em03o+zabayw7x0B/rqNc047hYe0a3J1a2gjwXNpAGwA6CGwxwnIaqGnzyVWjYxIOkoN+GY7hK0cblIAu+nO0qox+tPTCeLmUvCA9hli0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652181; c=relaxed/simple;
	bh=wYtLZ3HKhwoe/K5qRKVev6jyumbrOM25/9zd91b8xsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y7K7KNIzdsHoBP60BAr4LCQQsEGSX11f36GhB2PudtLI1jCoSAr6gxTj+Ui68jmw7av6jn+O5C/CqQdA/uCaY7UuDWKT7iLm1YBOMVkeY3Fr1nxTU0BJ9swtJ1Uh+qUL4BJ+cPN0T+DyJ5q9yqiLYVyM874jYdlEQ9Cgx1c2XZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ofWWfRDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C320C4CED3;
	Thu, 23 Jan 2025 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737652180;
	bh=wYtLZ3HKhwoe/K5qRKVev6jyumbrOM25/9zd91b8xsY=;
	h=From:To:Cc:Subject:Date:From;
	b=ofWWfRDw4/2Px/5B5VeZsnbjSQTWQZ4pAy94067+27/G32efYV9GESHJlEo47j2GU
	 wyw6Nl2vBm9zy1xTvpuAZzDLU+vghNKM6WM+QMdxkud6nIemL9avAR4+bsSpWC7ufZ
	 jAF3f9WTZpUHuyLihOifvK/zRXU1ivW7xykuCt6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.177
Date: Thu, 23 Jan 2025 18:09:35 +0100
Message-ID: <2025012336-ounce-litmus-bb62@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.177 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi             |    1 
 arch/riscv/kernel/traps.c                            |    6 -
 arch/x86/include/asm/special_insns.h                 |    2 
 arch/x86/xen/xen-asm.S                               |    2 
 block/bfq-iosched.c                                  |   12 +-
 drivers/acpi/resource.c                              |   24 +++-
 drivers/base/regmap/regmap.c                         |   12 --
 drivers/base/topology.c                              |   24 +++-
 drivers/gpio/gpiolib-cdev.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |   45 -------
 drivers/gpu/drm/amd/display/dc/dc.h                  |    2 
 drivers/gpu/drm/amd/display/dc/dml/dml_inline_defs.h |    8 +
 drivers/gpu/drm/i915/display/intel_fb.c              |    2 
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c              |   12 +-
 drivers/gpu/drm/v3d/v3d_irq.c                        |    4 
 drivers/hwmon/tmp513.c                               |    7 -
 drivers/i2c/busses/i2c-rcar.c                        |   20 ++-
 drivers/i2c/muxes/i2c-demux-pinctrl.c                |    4 
 drivers/iio/adc/ad7124.c                             |    3 
 drivers/iio/adc/at91_adc.c                           |    2 
 drivers/iio/adc/rockchip_saradc.c                    |    2 
 drivers/iio/adc/ti-ads124s08.c                       |    4 
 drivers/iio/adc/ti-ads8688.c                         |    2 
 drivers/iio/dummy/iio_simple_dummy_buffer.c          |    2 
 drivers/iio/gyro/fxas21002c_core.c                   |    9 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h          |    1 
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c     |   18 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c      |    3 
 drivers/iio/imu/kmx61.c                              |    2 
 drivers/iio/inkern.c                                 |    2 
 drivers/iio/light/vcnl4035.c                         |    2 
 drivers/iio/pressure/zpa2326.c                       |    2 
 drivers/irqchip/irq-gic-v3.c                         |    2 
 drivers/md/dm-ebs-target.c                           |    2 
 drivers/md/dm-thin.c                                 |    5 
 drivers/md/persistent-data/dm-array.c                |   19 ++-
 drivers/md/raid5.c                                   |   14 +-
 drivers/mtd/spi-nor/core.c                           |    2 
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c          |   19 ---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c        |    3 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c      |    5 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c    |   95 +++++++++++++---
 drivers/net/ethernet/netronome/nfp/bpf/offload.c     |    3 
 drivers/net/ethernet/ti/cpsw_ale.c                   |   14 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c    |    6 +
 drivers/net/gtp.c                                    |   42 ++++---
 drivers/net/ieee802154/ca8210.c                      |    6 -
 drivers/nvme/target/io-cmd-bdev.c                    |    2 
 drivers/of/address.c                                 |   76 +++++++++----
 drivers/of/unittest-data/tests-address.dtsi          |    9 +
 drivers/of/unittest.c                                |  109 +++++++++++++++++++
 drivers/pci/controller/pci-host-common.c             |    4 
 drivers/pci/probe.c                                  |   20 +--
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c    |   53 +++++++--
 drivers/phy/broadcom/phy-brcm-usb-init.h             |    1 
 drivers/phy/broadcom/phy-brcm-usb.c                  |    8 -
 drivers/scsi/sg.c                                    |    2 
 drivers/staging/iio/frequency/ad9832.c               |    2 
 drivers/staging/iio/frequency/ad9834.c               |    2 
 drivers/usb/class/usblp.c                            |    7 -
 drivers/usb/core/hub.c                               |    6 -
 drivers/usb/core/port.c                              |    7 -
 drivers/usb/dwc3/core.h                              |    1 
 drivers/usb/dwc3/gadget.c                            |    4 
 drivers/usb/gadget/function/f_fs.c                   |    2 
 drivers/usb/gadget/function/f_uac2.c                 |    1 
 drivers/usb/gadget/function/u_serial.c               |    8 -
 drivers/usb/host/xhci-pci.c                          |    4 
 drivers/usb/serial/cp210x.c                          |    1 
 drivers/usb/serial/option.c                          |    4 
 drivers/usb/storage/unusual_devs.h                   |    7 +
 fs/afs/afs.h                                         |    2 
 fs/afs/afs_vl.h                                      |    1 
 fs/afs/vl_alias.c                                    |    8 +
 fs/afs/vlclient.c                                    |    2 
 fs/ceph/mds_client.c                                 |    9 -
 fs/exfat/dir.c                                       |    3 
 fs/exfat/fatent.c                                    |   10 +
 fs/file.c                                            |    1 
 fs/hfs/super.c                                       |    4 
 fs/jbd2/commit.c                                     |    4 
 fs/ksmbd/smb2pdu.c                                   |    3 
 fs/nfsd/filecache.c                                  |   18 +--
 fs/nfsd/filecache.h                                  |    1 
 fs/ocfs2/quota_global.c                              |    2 
 fs/ocfs2/quota_local.c                               |   10 -
 fs/proc/vmcore.c                                     |    2 
 include/linux/blk-cgroup.h                           |    6 -
 include/linux/hrtimer.h                              |    1 
 include/linux/mlx5/device.h                          |    2 
 include/linux/mlx5/fs.h                              |    2 
 include/linux/poll.h                                 |   10 +
 include/linux/usb.h                                  |    3 
 include/linux/usb/hcd.h                              |    2 
 include/net/inet_connection_sock.h                   |    2 
 include/net/net_namespace.h                          |    3 
 kernel/cpu.c                                         |    2 
 kernel/gen_kheaders.sh                               |    1 
 kernel/time/hrtimer.c                                |   11 +
 mm/filemap.c                                         |    2 
 net/802/psnap.c                                      |    4 
 net/core/filter.c                                    |   30 +++--
 net/core/net_namespace.c                             |   31 +++++
 net/core/pktgen.c                                    |    6 -
 net/dccp/ipv6.c                                      |    2 
 net/ipv6/route.c                                     |    2 
 net/ipv6/tcp_ipv6.c                                  |    4 
 net/mac802154/iface.c                                |    4 
 net/mptcp/options.c                                  |   12 +-
 net/mptcp/pm.c                                       |    7 -
 net/mptcp/protocol.h                                 |    2 
 net/netfilter/nf_conntrack_core.c                    |    5 
 net/netfilter/nf_tables_api.c                        |   15 +-
 net/sched/cls_flow.c                                 |    3 
 net/sctp/sysctl.c                                    |   14 +-
 net/tls/tls_sw.c                                     |    2 
 net/vmw_vsock/af_vsock.c                             |   18 +++
 net/vmw_vsock/virtio_transport_common.c              |   36 ++++--
 scripts/sorttable.h                                  |    6 -
 sound/soc/mediatek/common/mtk-afe-platform-driver.c  |    4 
 121 files changed, 819 insertions(+), 337 deletions(-)

Aharon Landau (1):
      net/mlx5: Add priorities for counters in RDMA namespaces

Akash M (1):
      usb: gadget: f_fs: Remove WARN_ON in functionfs_bind

Al Cooper (1):
      phy: usb: Add "wake on" functionality for newer Synopsis XHCI controllers

Andrea della Porta (1):
      of: address: Preserve the flags portion on 1:1 dma-ranges mapping

André Draszik (1):
      usb: dwc3: gadget: fix writing NYET threshold

Antonio Pastor (1):
      net: 802: LLC+SNAP OID:PID lookup on start of skb data

Anumula Murali Mohan Reddy (1):
      cxgb4: Avoid removal of uninserted tid

Arnd Bergmann (1):
      xhci: use pm_ptr() instead of #ifdef for CONFIG_PM conditionals

Artem Chernyshev (1):
      pktgen: Avoid out-of-bounds access in get_imix_entries

Benjamin Coddington (1):
      tls: Fix tls_sw_sendmsg error handling

Carlos Song (1):
      iio: gyro: fxas21002c: Fix missing data update in trigger handler

Chen-Yu Tsai (1):
      ASoC: mediatek: disable buffer pre-allocation

Chukun Pan (1):
      USB: serial: option: add MeiG Smart SRM815

Dan Carpenter (1):
      nfp: bpf: prevent integer overflow in nfp_bpf_event_output()

David Howells (2):
      afs: Fix the maximum cell name length
      kheaders: Ignore silly-rename files

David Lechner (1):
      hwmon: (tmp513) Fix division of negative numbers

Dennis Lam (1):
      ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv

Eric Dumazet (4):
      net_sched: cls_flow: validate TCA_FLOW_RSHIFT attribute
      net: add exit_batch_rtnl() method
      gtp: use exit_batch_rtnl() method
      ipv6: avoid possible NULL deref in rt6_uncached_list_flush_dev()

Fabio Estevam (1):
      iio: adc: ti-ads124s08: Use gpiod_set_value_cansleep()

Geliang Tang (1):
      mptcp: drop port parameter of mptcp_pm_add_addr_signal

Greg Kroah-Hartman (3):
      Revert "drm/amdgpu: rework resume handling for display (v2)"
      Revert "regmap: detach regmap from dev on regmap_exit"
      Linux 5.15.177

Gui-Dong Han (1):
      md/raid5: fix atomicity violation in raid5_cache_count

Hans de Goede (3):
      ACPI: resource: Add TongFang GM5HG0A to irq1_edge_low_force_override[]
      ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]
      ACPI: resource: acpi_dev_irq_override(): Check DMI match last

Heiner Kallweit (1):
      net: ethernet: xgbe: re-add aneg to supported features in PHY quirks

Herve Codina (2):
      of: address: Fix address translation when address-size is greater than 2
      of: address: Remove duplicated functions

Jason Xing (1):
      tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog

Jason-JH.Lin (1):
      drm/mediatek: Add support for 180-degree rotation in the display driver

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

Kalesh AP (1):
      bnxt_en: Fix possible memory leak when hwrm_req_replace fails

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

Li Huafei (1):
      topology: Keep the cpumask unchanged when printing cpumap

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

Maor Gottlieb (1):
      net/mlx5: Refactor mlx5_get_flow_namespace

Marco Nelissen (1):
      filemap: avoid truncating 64-bit offset to 32 bits

Matthieu Baerts (NGI0) (5):
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: rto_min/max: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy
      sctp: sysctl: udp_port: avoid using current->nsproxy
      sctp: sysctl: plpmtud_probe_interval: avoid using current->nsproxy

Max Kellermann (1):
      ceph: give up on paths longer than PATH_MAX

Maíra Canal (1):
      drm/v3d: Ensure job pointer is set to NULL after job completion

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

Oleg Nesterov (1):
      poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()

Pablo Neira Ayuso (2):
      netfilter: nf_tables: imbalance in flowtable binding
      netfilter: conntrack: clamp maximum hashtable size to INT_MAX

Paolo Abeni (1):
      mptcp: fix TCP options overflow.

Patrisious Haddad (1):
      net/mlx5: Fix RDMA TX steering prio

Peter Geis (1):
      arm64: dts: rockchip: add hevc power domain clock to rk3328

Prashanth K (1):
      usb: gadget: f_uac2: Fix incorrect setting of bNumEndpoints

Pratyush Yadav (1):
      Revert "mtd: spi-nor: core: replace dummy buswidth from addr to data"

Rik van Riel (1):
      fs/proc: fix softlockup in __read_vmcore (part 2)

Rob Herring (3):
      of: unittest: Add bus address range parsing tests
      of/address: Add support for 3 address cell bus
      of: address: Store number of bus flag cells rather than bool

Roman Li (1):
      drm/amd/display: Add check for granularity in dml ceil/floor helpers

Ron Economos (1):
      Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals

Sean Anderson (1):
      net: xilinx: axienet: Fix IRQ coalescing packet count overflow

Stefano Garzarella (4):
      vsock/virtio: cancel close work in the destructor
      vsock: reset socket state when de-assigning the transport
      vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]
      vsock/virtio: discard packets if the transport changes

Sudheer Kumar Doredla (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()

Suraj Sonawane (1):
      scsi: sg: Fix slab-use-after-free read in sg_release()

Tejun Heo (1):
      blk-cgroup: Fix UAF in blkcg_unpin_online()

Terry Tritton (1):
      Revert "PCI: Use preserve_config in place of pci_flags"

Uwe Kleine-König (1):
      iio: adc: ad7124: Disable all channels at probe time

Ville Syrjälä (1):
      drm/i915/fb: Relax clear color alignment to 64 bytes

Wang Liang (1):
      net: fix data-races around sk->sk_forward_alloc

Wentao Liang (1):
      ksmbd: fix a missing return value check bug

Wolfram Sang (2):
      i2c: mux: demux-pinctrl: check initial mux selection, too
      i2c: rcar: fix NACK handling when being a target

Yogesh Lal (1):
      irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly

Youzhong Yang (1):
      nfsd: add list_head nf_gc to struct nfsd_file

Yu Kuai (1):
      block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()

Yuezhang Mo (2):
      exfat: fix the infinite loop in exfat_readdir()
      exfat: fix the infinite loop in __exfat_free_cluster()

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


