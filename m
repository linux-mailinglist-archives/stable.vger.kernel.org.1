Return-Path: <stable+bounces-108096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF15A07637
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAC83A85B9
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7EC2185A0;
	Thu,  9 Jan 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="knI6XFsT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E63218599;
	Thu,  9 Jan 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427389; cv=none; b=Irm5WT5DrIcIPpboeh/Bp8xY2WKk7B8QMQFobc83z0PgnCoez1KFn9ItCiE/9EUyQx5QAFq7SAiHyWN4/DJ+EbbXs97vXz3BN2En1HYKdyP4ZbBlX8JsaSUFCyfEye3e4CpJO9/DtKASnGxHDw0sedQE1agMbAj8cUPE4VpZusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427389; c=relaxed/simple;
	bh=NWKvi/jkZtRNsgjmbSufIOEgsjfbAHsColzVA6aarCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CepK84XciYJ0EVhs2PU4KYMnE58W9tiT1BcGZH32sozf6RhfeqYJtHi3MKlWdYUmD9DpiMuJGJ0E++Ma70tzSupVjbkHOfggRvlRcIhzbE3t7yZJCNAvUZpESiSgE7tmOFaT/U6VPTB3+12tLpXickI+w78VbbqKKHAGma1fAKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=knI6XFsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A77C4CED2;
	Thu,  9 Jan 2025 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736427387;
	bh=NWKvi/jkZtRNsgjmbSufIOEgsjfbAHsColzVA6aarCA=;
	h=From:To:Cc:Subject:Date:From;
	b=knI6XFsTA4k3N8npDAgktTk1Ka/8QRbzIVbHtYLBz5fXa1K5gClSf8FL1TR/V4+Zv
	 aieh2hfgfeamrx5eQNGZpPrb4FP1CQgY//sBUmvrjx7j1OMCM55KpeApnCY1W/i+WT
	 NuEdg4ghO9sr7t0j0lRXOCJlm0sfr2zFoe8NR6SI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.289
Date: Thu,  9 Jan 2025 13:56:22 +0100
Message-ID: <2025010923-federal-grunt-0386@gregkh>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.289 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 arch/arc/Makefile                                   |    2 
 arch/mips/Makefile                                  |    2 
 drivers/base/regmap/regmap.c                        |    4 
 drivers/block/virtio_blk.c                          |    7 +
 drivers/block/zram/zram_drv.c                       |    6 +
 drivers/crypto/chelsio/chtls/chtls_main.c           |    5 -
 drivers/dma-buf/udmabuf.c                           |    2 
 drivers/dma/at_xdmac.c                              |    2 
 drivers/dma/mv_xor.c                                |    2 
 drivers/gpu/drm/bridge/adv7511/adv7511_audio.c      |   28 ++++++
 drivers/gpu/drm/bridge/adv7511/adv7533.c            |    2 
 drivers/gpu/drm/i915/i915_scheduler.c               |    2 
 drivers/hv/hv_kvp.c                                 |    6 +
 drivers/hv/hv_snapshot.c                            |    6 +
 drivers/hv/hv_util.c                                |    9 ++
 drivers/hv/hyperv_vmbus.h                           |    2 
 drivers/i2c/busses/i2c-pnx.c                        |    4 
 drivers/i2c/busses/i2c-riic.c                       |    2 
 drivers/infiniband/core/uverbs_cmd.c                |   16 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c            |   28 +++---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c            |    2 
 drivers/infiniband/hw/mlx5/main.c                   |    8 +
 drivers/irqchip/irq-gic.c                           |    2 
 drivers/media/dvb-frontends/dib3000mb.c             |    2 
 drivers/mmc/host/sdhci-tegra.c                      |    1 
 drivers/mtd/nand/raw/atmel/pmecc.c                  |    4 
 drivers/mtd/nand/raw/diskonchip.c                   |    2 
 drivers/net/ethernet/broadcom/bgmac-platform.c      |    5 -
 drivers/net/ethernet/huawei/hinic/hinic_main.c      |    2 
 drivers/net/ethernet/marvell/sky2.c                 |    1 
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c |    4 
 drivers/net/usb/qmi_wwan.c                          |    3 
 drivers/of/address.c                                |    2 
 drivers/of/base.c                                   |   15 ++-
 drivers/of/irq.c                                    |    1 
 drivers/pci/pcie/aer.c                              |   18 ++++
 drivers/pci/quirks.c                                |    4 
 drivers/phy/phy-core.c                              |   15 ++-
 drivers/pinctrl/pinctrl-mcp23s08.c                  |    6 +
 drivers/platform/x86/asus-nb-wmi.c                  |    1 
 drivers/scsi/megaraid/megaraid_sas_base.c           |    5 -
 drivers/scsi/mpt3sas/mpt3sas_base.c                 |    7 +
 drivers/scsi/qla1280.h                              |   12 +-
 drivers/sh/clk/core.c                               |    2 
 drivers/usb/dwc2/gadget.c                           |    4 
 drivers/usb/serial/option.c                         |   27 ++++++
 fs/btrfs/inode.c                                    |    2 
 fs/btrfs/tree-checker.c                             |   27 ++++++
 fs/efivarfs/inode.c                                 |    2 
 fs/efivarfs/internal.h                              |    1 
 fs/efivarfs/super.c                                 |    3 
 fs/erofs/inode.c                                    |   20 +---
 fs/eventpoll.c                                      |    5 -
 fs/nfs/pnfs.c                                       |    2 
 fs/nfsd/nfs4callback.c                              |    4 
 fs/nilfs2/inode.c                                   |    8 +
 fs/nilfs2/namei.c                                   |    5 +
 include/linux/hyperv.h                              |    1 
 include/linux/if_vlan.h                             |   16 +++
 include/linux/mlx5/driver.h                         |   13 ++-
 include/linux/netfilter/ipset/ip_set.h              |    2 
 include/linux/netfilter/x_tables.h                  |    8 -
 include/linux/netfilter_arp/arp_tables.h            |    2 
 include/linux/netfilter_bridge/ebtables.h           |    2 
 include/linux/netfilter_ipv4/ip_tables.h            |    2 
 include/linux/netfilter_ipv6/ip6_tables.h           |    2 
 include/linux/skbuff.h                              |    1 
 include/linux/trace_events.h                        |    2 
 include/linux/wait.h                                |    1 
 include/net/netfilter/nf_conntrack_extend.h         |    2 
 include/net/netfilter/nf_conntrack_timeout.h        |    2 
 include/net/netfilter/nf_tables.h                   |   13 +--
 include/uapi/linux/netfilter_bridge/ebt_among.h     |    2 
 kernel/bpf/core.c                                   |    6 +
 kernel/trace/ftrace.c                               |    4 
 kernel/trace/trace_kprobe.c                         |    2 
 mm/vmscan.c                                         |    9 +-
 net/bridge/netfilter/ebtables.c                     |    2 
 net/core/filter.c                                   |   23 +++--
 net/core/skbuff.c                                   |   52 ++++++++++++
 net/core/skmsg.c                                    |    4 
 net/ipv4/netfilter/arp_tables.c                     |    4 
 net/ipv4/netfilter/ip_tables.c                      |    4 
 net/ipv6/ila/ila_xlat.c                             |   16 ++-
 net/ipv6/ip6_output.c                               |   86 ++++++++------------
 net/ipv6/netfilter/ip6_tables.c                     |    4 
 net/llc/llc_input.c                                 |    2 
 net/mac80211/util.c                                 |    3 
 net/netfilter/ipset/ip_set_bitmap_ip.c              |    2 
 net/netfilter/ipset/ip_set_bitmap_ipmac.c           |    2 
 net/netfilter/ipset/ip_set_bitmap_port.c            |    2 
 net/netfilter/ipset/ip_set_hash_gen.h               |    4 
 net/netfilter/ipset/ip_set_list_set.c               |    3 
 net/netfilter/nfnetlink_acct.c                      |    2 
 net/netfilter/xt_hashlimit.c                        |    2 
 net/netfilter/xt_recent.c                           |    4 
 net/netrom/nr_route.c                               |    6 +
 net/packet/af_packet.c                              |   28 +-----
 net/sched/sch_cake.c                                |    2 
 net/sched/sch_choke.c                               |    2 
 net/sctp/associola.c                                |    3 
 net/smc/af_smc.c                                    |    7 +
 scripts/mod/file2alias.c                            |    4 
 security/selinux/ss/services.c                      |    8 +
 sound/usb/format.c                                  |    7 +
 sound/usb/mixer.c                                   |    7 +
 sound/usb/mixer_us16x08.c                           |    2 
 108 files changed, 524 insertions(+), 238 deletions(-)

Adrian Ratiu (1):
      sound: usb: format: don't warn that raw DSD is unsupported

Ajit Khaparde (1):
      PCI: Add ACS quirk for Broadcom BCM5760X NIC

Anton Protopopov (1):
      bpf: fix potential error return

Antonio Pastor (1):
      net: llc: reset skb->transport_header

Armin Wolf (1):
      platform/x86: asus-nb-wmi: Ignore unknown event 0xCF

Biju Das (1):
      drm: adv7511: Drop dsi single lane support

Bogdan Togorean (1):
      drm: bridge: adv7511: Enable SPDIF DAI

Chen Ridong (1):
      dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac_prep_dma_memset

Christian Göttsche (1):
      tracing: Constify string literal data member in struct trace_event_call

Cong Wang (1):
      bpf: Check negative offsets in __bpf_skb_min_len()

Dan Carpenter (4):
      net: hinic: Fix cleanup in create_rxqs/txqs()
      chelsio/chtls: prevent potential integer overflow on 32bit
      mtd: rawnand: fix double free in atmel_pmecc_create_user()
      RDMA/uverbs: Prevent integer overflow issue

Daniel Swanemar (1):
      USB: serial: option: add TCL IK512 MBIM & ECM

Daniele Palmas (2):
      USB: serial: option: add Telit FE910C04 rmnet compositions
      net: usb: qmi_wwan: add Telit FE910C04 compositions

Edward Adam Davis (1):
      nilfs2: prevent use of deleted inode

Emmanuel Grumbach (1):
      wifi: mac80211: wake the queues in case of failure in resume

Eric Dumazet (5):
      ipv6: fix possible UAF in ip6_finish_output2()
      ipv6: prevent possible UAF in ip6_xmit()
      af_packet: fix vlan_get_tci() vs MSG_PEEK
      af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
      ila: serialize calls to nf_register_net_hooks()

Evgenii Shatokhin (1):
      pinctrl: mcp23s08: Fix sleeping in atomic context due to regmap locking

Filipe Manana (1):
      btrfs: avoid monopolizing a core when activating a swap file

Gao Xiang (2):
      erofs: fix order >= MAX_ORDER warning due to crafted negative i_size
      erofs: fix incorrect symlink detection in fast symlink

Geert Uytterhoeven (2):
      i2c: riic: Always round-up when calculating bus period
      sh: clk: Fix clk_enable() to return 0 on NULL clk

Greg Kroah-Hartman (1):
      Linux 5.4.289

Guangguan Wang (1):
      net/smc: check sndbuf_space again after NOSPACE flag is set in smc_poll

Gustavo A. R. Silva (1):
      netfilter: Replace zero-length array with flexible-array member

Herve Codina (1):
      of: Fix error path in of_parse_phandle_with_args_map()

Ilya Shchipletsov (1):
      netrom: check buffer length before accessing it

Jack Wu (1):
      USB: serial: option: add MediaTek T7XX compositions

James Bottomley (1):
      efivarfs: Fix error on non-existent file

Jann Horn (1):
      udmabuf: also check for F_SEAL_FUTURE_WRITE

Javier Carrasco (1):
      dmaengine: mv_xor: fix child node refcount handling in early exit

Jiasheng Jiang (1):
      drm/i915: Fix memory leak by correcting cache object name in error handler

Jiaxun Yang (1):
      MIPS: Probe toolchain support of -msym32

Jiayuan Chen (1):
      bpf: fix recursive lock when verdict program return SK_PASS

Joe Hattori (1):
      net: ethernet: bgmac-platform: fix an OF node reference leak

Kai-Heng Feng (1):
      PCI/AER: Disable AER service on suspend

Kairui Song (1):
      zram: refuse to use zero sized block device as backing device

Kalesh AP (1):
      RDMA/bnxt_re: Fix reporting hw_ver in query_device

Koichiro Den (1):
      ftrace: use preempt_enable/disable notrace macros to avoid double fault

Leon Romanovsky (1):
      ARC: build: Try to guess GCC variant of cross compiler

Lion Ackermann (1):
      net: sched: fix ordering of qlen adjustment

Magnus Lindholm (1):
      scsi: qla1280: Fix hw revision numbering for ISP1020/1040

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 modules for WWAN Ready

Mark Brown (1):
      regmap: Use correct format specifier for logging range errors

Masahiro Yamada (2):
      modpost: fix input MODULE_DEVICE_TABLE() built for 64-bit on 32-bit host
      modpost: fix the missed iteration for the max bit in do_input()

Masami Hiramatsu (Google) (1):
      tracing/kprobe: Make trace_kprobe's module callback called after jump_label update

Michael Kelley (1):
      Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet

Michal Hrusecky (1):
      USB: serial: option: add MeiG Smart SLM770A

Ming Lei (1):
      virtio-blk: don't keep queue frozen during system suspend

NeilBrown (1):
      nfsd: restore callback functionality for NFSv4.0

Nikita Zhandarovich (1):
      media: dvb-frontends: dib3000mb: fix uninit-value in dib3000_write_reg

Nikolay Kuratov (1):
      net/sctp: Prevent autoclose integer overflow in sctp_association_init()

Pablo Neira Ayuso (1):
      netfilter: nft_set_hash: unaligned atomic read on struct nft_set_ext

Parav Pandit (2):
      IB/mlx5: Introduce and use mlx5_core_is_vf()
      net/mlx5: Make API mlx5_core_is_ecpf accept const pointer

Pascal Hambourg (1):
      sky2: Add device ID 11ab:4373 for Marvell 88E8075

Patrisious Haddad (1):
      RDMA/mlx5: Enforce same type port association for multiport RoCE

Peng Hongchi (1):
      usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled

Phil Sutter (1):
      netfilter: ipset: Fix for recursive locking warning

Prathamesh Shete (1):
      mmc: sdhci-tegra: Remove SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC quirk

Qu Wenruo (1):
      btrfs: tree-checker: reject inline extent items with 0 ref count

Ranjan Kumar (1):
      scsi: mpt3sas: Diag-Reset when Doorbell-In-Use bit is set during driver load time

Saravanan Vajravel (1):
      RDMA/bnxt_re: Add check for path mtu in modify_qp

Seiji Nishikawa (1):
      mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()

Selvin Xavier (1):
      RDMA/bnxt_re: Fix max_qp_wrs reported

Shannon Nelson (1):
      ionic: use ee->offset when returning sprom data

Stefan Ekenberg (1):
      drm/bridge: adv7511_audio: Update Audio InfoFrame properly

Takashi Iwai (1):
      ALSA: usb: Fix UBSAN warning in parse_audio_unit()

Tanya Agarwal (1):
      ALSA: usb-audio: US16x08: Initialize array before use

Thiébaud Weksteen (1):
      selinux: ignore unknown extended permissions

Tomas Henzl (1):
      scsi: megaraid_sas: Fix for a potential deadlock

Trond Myklebust (1):
      NFS/pnfs: Fix a live lock between recalled layouts and layoutget

Uros Bizjak (1):
      irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base

Vasily Averin (4):
      skbuff: introduce skb_expand_head()
      ipv6: use skb_expand_head in ip6_finish_output2
      ipv6: use skb_expand_head in ip6_xmit
      skb_expand_head() adjust skb->truesize incorrectly

Vladimir Riabchun (1):
      i2c: pnx: Fix timeout in wait functions

Xuewen Yan (1):
      epoll: Add synchronous wakeup support for ep_poll_callback

Zichen Xie (1):
      mtd: diskonchip: Cast an operand to prevent potential overflow

Zijun Hu (6):
      of/irq: Fix using uninitialized variable @addr_len in API of_irq_parse_one()
      of: Fix refcount leakage for OF node returned by __of_get_dma_parent()
      phy: core: Fix an OF node refcount leakage in _of_phy_get()
      phy: core: Fix an OF node refcount leakage in of_phy_provider_lookup()
      phy: core: Fix that API devm_phy_put() fails to release the phy
      phy: core: Fix that API devm_phy_destroy() fails to destroy the phy


