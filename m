Return-Path: <stable+bounces-108103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413C1A0764B
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4663E3A8101
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A35C218AB5;
	Thu,  9 Jan 2025 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i08qwda0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8772218AA5;
	Thu,  9 Jan 2025 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427430; cv=none; b=SnMbgFitI0TYMT17qe9NpZx2dU/fW7veEOh9YfnCvBltGWVp3jHYUMezfbDwd/GrEDxyXVIpcaK2ev4qrAkwsONEPOt3iczZf4Vwu9oVIvnE2aXw1ZPsya4OMv4JG9Lw5+3/BmDBBiT+4+DpieL72J7tA9TmSQwXp8d9VsXMb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427430; c=relaxed/simple;
	bh=r0+46O9QsHYH1AwgLLP3k87g7+XhxR6lMzv+Kf5quJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NsvmeJwnSMQy1Y8NABkdzzmjyaa7oOItS2+H6SDbuel5GqAw2pYQxf2t6htRQHDDh+TgBDVqWxw/sLNpH+SmXposW7LyDD8U13hk4OslFRdU6fdkMYcSbyUBjVrupFQzfLswjlZWaTITaCOZaMHvUFIgzH36Nsf9srpCOKmHeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i08qwda0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BC8C4CEE4;
	Thu,  9 Jan 2025 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736427430;
	bh=r0+46O9QsHYH1AwgLLP3k87g7+XhxR6lMzv+Kf5quJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=i08qwda0trKe3c6HdTTgYi3Z2YTEb0rNw6myiZbC0vrgADcQ/XTMRUD+zAQYQ5Crb
	 z8xoohL2kklcohn0pBGaceAd7et7ISASERbZ4LVg1Lgkby63Bk/ijUuXCg/c5FN89D
	 4imUtMScQHd2s5XlMqgM+b6EuGqwvVMvr7Ibq3A4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.124
Date: Thu,  9 Jan 2025 13:56:49 +0100
Message-ID: <2025010950-hazily-gradient-123a@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.124 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml |    2 
 Makefile                                                          |    2 
 arch/arc/Makefile                                                 |    2 
 arch/x86/kernel/cpu/mshyperv.c                                    |   58 +++
 drivers/block/zram/zram_drv.c                                     |    3 
 drivers/clocksource/hyperv_timer.c                                |   14 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                          |    4 
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c                    |   14 
 drivers/gpu/drm/bridge/adv7511/adv7533.c                          |    2 
 drivers/gpu/drm/i915/gt/intel_rc6.c                               |    2 
 drivers/infiniband/core/uverbs_cmd.c                              |   16 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                          |   28 -
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                          |    2 
 drivers/infiniband/hw/bnxt_re/qplib_sp.c                          |    2 
 drivers/infiniband/hw/hns/hns_roce_alloc.c                        |    3 
 drivers/infiniband/hw/hns/hns_roce_cq.c                           |   11 
 drivers/infiniband/hw/hns/hns_roce_device.h                       |   12 
 drivers/infiniband/hw/hns/hns_roce_hem.c                          |   54 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |  130 ++++----
 drivers/infiniband/hw/hns/hns_roce_mr.c                           |   95 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c                           |    4 
 drivers/infiniband/hw/hns/hns_roce_srq.c                          |    4 
 drivers/infiniband/hw/mlx5/main.c                                 |    6 
 drivers/infiniband/ulp/rtrs/rtrs-srv.c                            |    2 
 drivers/irqchip/irq-gic.c                                         |    2 
 drivers/net/dsa/microchip/ksz9477.c                               |   47 ++-
 drivers/net/dsa/microchip/ksz9477_reg.h                           |    4 
 drivers/net/dsa/microchip/ksz_common.h                            |    5 
 drivers/net/dsa/microchip/lan937x_main.c                          |   62 +++-
 drivers/net/dsa/microchip/lan937x_reg.h                           |    9 
 drivers/net/ethernet/broadcom/bcmsysport.c                        |   21 +
 drivers/net/ethernet/marvell/mv643xx_eth.c                        |   14 
 drivers/net/ethernet/marvell/sky2.c                               |    1 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c               |    3 
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c             |  151 +++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h             |    2 
 drivers/net/usb/qmi_wwan.c                                        |    3 
 drivers/net/wwan/iosm/iosm_ipc_mmio.c                             |    2 
 drivers/net/wwan/t7xx/t7xx_state_monitor.c                        |   26 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.h                        |    5 
 drivers/pinctrl/pinctrl-mcp23s08.c                                |    6 
 drivers/thunderbolt/nhi.c                                         |   12 
 drivers/thunderbolt/nhi.h                                         |    6 
 drivers/thunderbolt/retimer.c                                     |   17 -
 drivers/usb/host/xhci-ring.c                                      |   42 ++
 drivers/usb/host/xhci.c                                           |   21 +
 drivers/usb/host/xhci.h                                           |    2 
 fs/btrfs/ctree.c                                                  |   37 +-
 fs/btrfs/ctree.h                                                  |    7 
 fs/btrfs/disk-io.c                                                |    9 
 fs/btrfs/inode.c                                                  |    2 
 fs/smb/server/smb2pdu.c                                           |   12 
 fs/smb/server/vfs.h                                               |    1 
 include/clocksource/hyperv_timer.h                                |    2 
 include/linux/if_vlan.h                                           |   16 -
 include/linux/mlx5/driver.h                                       |    6 
 include/net/bluetooth/hci_core.h                                  |  108 ++++---
 include/net/ip_tunnels.h                                          |   28 -
 include/net/netfilter/nf_tables.h                                 |    7 
 kernel/bpf/core.c                                                 |    6 
 kernel/kcov.c                                                     |    2 
 kernel/trace/trace_events.c                                       |   12 
 mm/readahead.c                                                    |    6 
 mm/vmscan.c                                                       |    9 
 net/bluetooth/hci_core.c                                          |   10 
 net/bluetooth/iso.c                                               |    6 
 net/bluetooth/l2cap_core.c                                        |   12 
 net/bluetooth/rfcomm/core.c                                       |    6 
 net/bluetooth/sco.c                                               |   12 
 net/core/dev.c                                                    |    4 
 net/core/sock.c                                                   |    5 
 net/ipv4/ip_tunnel.c                                              |   60 ++-
 net/ipv4/ipip.c                                                   |    1 
 net/ipv4/tcp_input.c                                              |    1 
 net/ipv6/ila/ila_xlat.c                                           |   16 -
 net/ipv6/sit.c                                                    |    2 
 net/llc/llc_input.c                                               |    2 
 net/mac80211/util.c                                               |    3 
 net/mctp/route.c                                                  |   36 +-
 net/mptcp/options.c                                               |    7 
 net/mptcp/protocol.c                                              |   22 -
 net/netrom/nr_route.c                                             |    6 
 net/packet/af_packet.c                                            |   28 -
 net/sctp/associola.c                                              |    3 
 scripts/mod/file2alias.c                                          |    4 
 security/selinux/ss/services.c                                    |    8 
 sound/core/seq/oss/seq_oss_synth.c                                |    2 
 sound/pci/hda/patch_realtek.c                                     |    2 
 sound/usb/format.c                                                |    7 
 sound/usb/mixer_us16x08.c                                         |    2 
 sound/usb/quirks.c                                                |    2 
 91 files changed, 1031 insertions(+), 443 deletions(-)

Adrian Ratiu (2):
      sound: usb: enable DSD output for ddHiFi TC44C
      sound: usb: format: don't warn that raw DSD is unsupported

Andrew Halaney (1):
      net: stmmac: don't create a MDIO bus if unnecessary

Anton Protopopov (1):
      bpf: fix potential error return

Antonio Pastor (1):
      net: llc: reset skb->transport_header

Arnd Bergmann (1):
      kcov: mark in_softirq_really() as __always_inline

Bartosz Golaszewski (1):
      net: stmmac: platform: provide devm_stmmac_probe_config_dt()

Biju Das (2):
      drm: adv7511: Drop dsi single lane support
      dt-bindings: display: adi,adv7533: Drop single lane support

Chengchang Tang (4):
      RDMA/hns: Refactor mtr find
      RDMA/hns: Remove unused parameters and variables
      RDMA/hns: Fix warning storm caused by invalid input in IO path
      RDMA/hns: Fix missing flush CQE for DWQE

Christian Ehrig (1):
      ipip,ip_tunnel,sit: Add FOU support for externally controlled ipip devices

Dan Carpenter (1):
      RDMA/uverbs: Prevent integer overflow issue

Daniel Schaefer (1):
      ALSA hda/realtek: Add quirk for Framework F111:000C

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FE910C04 compositions

Dominique Martinet (1):
      zram: check comp is non-NULL before calling comp_destroy

Emmanuel Grumbach (1):
      wifi: mac80211: wake the queues in case of failure in resume

Eric Dumazet (5):
      ip_tunnel: annotate data-races around t->parms.link
      net: restrict SO_REUSEPORT to inet sockets
      af_packet: fix vlan_get_tci() vs MSG_PEEK
      af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
      ila: serialize calls to nf_register_net_hooks()

Evgenii Shatokhin (1):
      pinctrl: mcp23s08: Fix sleeping in atomic context due to regmap locking

Filipe Manana (3):
      btrfs: rename and export __btrfs_cow_block()
      btrfs: fix use-after-free when COWing tree bock and tracing is enabled
      btrfs: flush delalloc workers queue before stopping cleaner kthread during unmount

Greg Kroah-Hartman (1):
      Linux 6.1.124

Hobin Woo (1):
      ksmbd: retry iterate_dir in smb2_query_dir

Ido Schimmel (3):
      ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_bind_dev()
      ipv4: ip_tunnel: Unmask upper DSCP bits in ip_md_tunnel_xmit()
      ipv4: ip_tunnel: Unmask upper DSCP bits in ip_tunnel_xmit()

Ilya Shchipletsov (1):
      netrom: check buffer length before accessing it

Jeremy Kerr (1):
      net: mctp: handle skb cleanup on sock_queue failures

Jinjian Song (1):
      net: wwan: t7xx: Fix FSM command timeout issue

Joe Hattori (2):
      net: stmmac: restructure the error path of stmmac_probe_config_dt()
      net: mv643xx_eth: fix an OF node reference leak

Johannes Thumshirn (1):
      btrfs: fix use-after-free in btrfs_encoded_read_endio()

Kalesh AP (1):
      RDMA/bnxt_re: Fix reporting hw_ver in query_device

Leon Romanovsky (1):
      ARC: build: Try to guess GCC variant of cross compiler

Li Zhijian (1):
      RDMA/rtrs: Ensure 'ib_sge list' is accessible

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix sleeping function called from invalid context

Maciej S. Szmigiero (1):
      net: wwan: iosm: Properly check for valid exec stage in ipc_mmio_init()

Mario Limonciello (1):
      thunderbolt: Don't display nvm_version unless upgrade supported

Masahiro Yamada (2):
      modpost: fix input MODULE_DEVICE_TABLE() built for 64-bit on 32-bit host
      modpost: fix the missed iteration for the max bit in do_input()

Mathias Nyman (1):
      xhci: Turn NEC specific quirk for handling Stop Endpoint errors generic

Michal Pecio (3):
      xhci: retry Stop Endpoint on buggy NEC controllers
      usb: xhci: Limit Stop Endpoint retries
      usb: xhci: Avoid queuing redundant Stop Endpoint commands

Mika Westerberg (2):
      thunderbolt: Add support for Intel Lunar Lake
      thunderbolt: Add support for Intel Panther Lake-M/P

Naman Jain (1):
      x86/hyperv: Fix hv tsc page based sched_clock for hibernation

Nikolay Kuratov (1):
      net/sctp: Prevent autoclose integer overflow in sctp_association_init()

Oleksij Rempel (1):
      net: dsa: microchip: add ksz_rmw8() function

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: unaligned atomic read on struct nft_set_ext

Paolo Abeni (3):
      mptcp: fix TCP options overflow.
      mptcp: fix recvbuffer adjust on sleeping rcvmsg
      mptcp: don't always assume copied data in mptcp_cleanup_rbuf()

Pascal Hambourg (1):
      sky2: Add device ID 11ab:4373 for Marvell 88E8075

Patrisious Haddad (1):
      RDMA/mlx5: Enforce same type port association for multiport RoCE

Prike Liang (1):
      drm/amdkfd: Correct the migration DMA map direction

Rodrigo Vivi (1):
      drm/i915/dg1: Fix power gate sequence.

Saravanan Vajravel (1):
      RDMA/bnxt_re: Add check for path mtu in modify_qp

Seiji Nishikawa (1):
      mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()

Selvin Xavier (2):
      RDMA/bnxt_re: Fix max_qp_wrs reported
      RDMA/bnxt_re: Fix the locking while accessing the QP table

Stefan Ekenberg (1):
      drm/bridge: adv7511_audio: Update Audio InfoFrame properly

Steven Rostedt (1):
      tracing: Have process_string() also allow arrays

Takashi Iwai (1):
      ALSA: seq: oss: Fix races at processing SysEx messages

Tanya Agarwal (1):
      ALSA: usb-audio: US16x08: Initialize array before use

Thiébaud Weksteen (1):
      selinux: ignore unknown extended permissions

Tristram Ha (2):
      net: dsa: microchip: Fix KSZ9477 set_ageing_time function
      net: dsa: microchip: Fix LAN937X set_ageing_time function

Uros Bizjak (1):
      irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base

Vasiliy Kovalev (1):
      ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model

Vitalii Mordan (1):
      eth: bcmsysport: fix call balance of priv->clk handling routines

Wang Liang (1):
      net: fix memory leak in tcp_conn_request()

Willem de Bruijn (1):
      net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets

Xiao Liang (1):
      net: Fix netns for ip_tunnel_init_flow()

Yafang Shao (1):
      mm/readahead: fix large folio support in async readahead

wenglianfa (1):
      RDMA/hns: Fix mapping error of zero-hop WQE buffer


