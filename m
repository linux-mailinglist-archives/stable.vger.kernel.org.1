Return-Path: <stable+bounces-238572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPzbOF5G42mgEAEAu9opvQ
	(envelope-from <stable+bounces-238572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:52:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E9110420795
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78FFE3017A28
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5A37DEA7;
	Sat, 18 Apr 2026 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uR/+8ftz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4337D120;
	Sat, 18 Apr 2026 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776502317; cv=none; b=q1rls3MMiBLVUmYDNtfmvmtmYw4kJ+ewJtDPmo+YoskIBt1R/+BAPg96FCXztytHz62eUuBeOA6XsJyAo4DNWteWRpAyVKa8phW9jmnBb2il/Z/0EONw0KvRaF5LmZXzlwjglNqQ9zT5ARMi7n4VLCgB+0x1pjsDod/xVzmlTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776502317; c=relaxed/simple;
	bh=bJCKUfe+a+COLJzqvL9DZRHpKOQhHDU+0kqHoxKIjqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fgIIL2QesRqgqHiHy6vmfbW+vzA1RQyUWrKeq6Sg/xoR0ES+1hV7QzVKIeDc5gEG0w87GoaHYfYLx3Kz1c2pUcSyqjdpZ+OGuvu/rGOR3/6FMh6OHduZ0Zdbvh4ezaUOXp7jEqPjJ/E9NSDHJUNrL+FTuPr4ue309NL1pxqw7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uR/+8ftz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D025CC19424;
	Sat, 18 Apr 2026 08:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776502317;
	bh=bJCKUfe+a+COLJzqvL9DZRHpKOQhHDU+0kqHoxKIjqA=;
	h=From:To:Cc:Subject:Date:From;
	b=uR/+8ftzjVm5fMO9RvjPBqDjpiXaHIEMhd3kblncoZwpLb21gCh5R8Jdb/PtahDBb
	 kxOYoCIdNowLNNzj2mCgDIo93bc4r6DHX9NlL7e/Lj05Qgn6zBW3uqoD768a3Cyyqr
	 53GcVxvi8sfFkiTw9l5eihkxQadkqZwklpitQOoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.135
Date: Sat, 18 Apr 2026 10:51:15 +0200
Message-ID: <2026041816-spectator-germproof-35d1@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238572-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E9110420795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.6.135 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                               |    2 
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts    |    2 
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi      |   24 -
 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts   |    2 
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi         |    1 
 arch/mips/include/asm/cpu-features.h                   |    1 
 arch/mips/include/asm/cpu-info.h                       |    2 
 arch/mips/include/asm/mipsregs.h                       |    2 
 arch/mips/kernel/cpu-probe.c                           |   13 
 arch/mips/kernel/cpu-r3k-probe.c                       |    2 
 arch/mips/mm/tlb-r4k.c                                 |  285 +++++++++++++----
 arch/x86/include/asm/msr-index.h                       |    3 
 arch/x86/kernel/cpu/amd.c                              |    3 
 crypto/asymmetric_keys/x509_cert_parser.c              |    8 
 drivers/edac/edac_mc.c                                 |    6 
 drivers/gpu/drm/drm_file.c                             |    5 
 drivers/gpu/drm/drm_mode_config.c                      |    9 
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c       |   26 +
 drivers/input/misc/uinput.c                            |   35 +-
 drivers/mmc/host/vub300.c                              |    2 
 drivers/net/ethernet/altera/altera_tse_main.c          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/main.c         |    1 
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c  |    2 
 drivers/net/ethernet/qualcomm/qca_uart.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c       |   11 
 drivers/net/virtio_net.c                               |   16 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c         |    2 
 drivers/nfc/pn533/uart.c                               |   11 
 drivers/pci/pci-driver.c                               |    8 
 drivers/pci/pci.c                                      |   10 
 drivers/pci/pci.h                                      |    1 
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c                 |    8 
 drivers/ufs/core/ufshcd.c                              |   31 +
 drivers/ufs/host/ufshcd-pci.c                          |    2 
 drivers/ufs/host/ufshcd-pltfrm.c                       |   25 -
 drivers/usb/gadget/function/f_hid.c                    |   11 
 include/net/netfilter/nf_conntrack_timeout.h           |    1 
 include/trace/events/rxrpc.h                           |    2 
 include/ufs/ufshcd.h                                   |    1 
 lib/crypto/chacha.c                                    |    4 
 mm/filemap.c                                           |   11 
 net/batman-adv/bridge_loop_avoidance.c                 |   27 +
 net/batman-adv/translation-table.c                     |    9 
 net/ipv6/seg6_iptunnel.c                               |   41 +-
 net/mptcp/pm_netlink.c                                 |   24 -
 net/mptcp/protocol.c                                   |    2 
 net/mptcp/protocol.h                                   |    1 
 net/mptcp/subflow.c                                    |   15 
 net/netfilter/nft_ct.c                                 |    2 
 net/netfilter/nft_set_pipapo.c                         |   20 -
 net/rfkill/core.c                                      |   35 +-
 net/rxrpc/af_rxrpc.c                                   |    6 
 net/rxrpc/call_object.c                                |   25 -
 net/rxrpc/io_thread.c                                  |    3 
 net/rxrpc/key.c                                        |    2 
 net/rxrpc/rxkad.c                                      |   63 ++-
 net/rxrpc/server_key.c                                 |    3 
 net/tipc/group.c                                       |    6 
 net/tls/tls_sw.c                                       |   10 
 net/xfrm/xfrm_user.c                                   |    3 
 sound/soc/generic/simple-card-utils.c                  |    7 
 62 files changed, 596 insertions(+), 304 deletions(-)

Anderson Nascimento (1):
      rxrpc: Fix key reference count leak from call->key

Andrea Mayer (1):
      seg6: separate dst_cache for input and output paths in seg6 lwtunnel

André Draszik (1):
      scsi: ufs: core: Fix use-after free in init error and remove paths

Baolin Wang (1):
      mm: filemap: fix nr_pages calculation overflow in filemap_map_pages()

Borislav Petkov (AMD) (2):
      x86/CPU: Fix FPDSS on Zen1
      EDAC/mc: Fix error path ordering in edac_mc_alloc()

David Carlier (2):
      net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()
      net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()

David Howells (3):
      rxrpc: Fix call removal to use RCU safe deletion
      rxrpc: Fix key/keyring checks in setsockopt(RXRPC_SECURITY_KEY/KEYRING)
      rxrpc: Fix missing error checks for rxkad encryption/decryption failure

Dmitry Torokhov (1):
      Input: uinput - take event lock when submitting FF request "event"

Douya Le (1):
      rxrpc: Only put the call ref if one was acquired

Eric Biggers (1):
      lib/crypto: chacha: Zeroize permuted_state before it leaves scope

Florian Westphal (1):
      netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR

Greg Kroah-Hartman (3):
      xfrm_user: fix info leak in build_report()
      net: rfkill: prevent unlimited numbers of rfkill events from being created
      Linux 6.6.135

Haoze Xie (1):
      batman-adv: hold claim backbone gateways by reference

Jacky Bai (1):
      pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled

Jiayuan Chen (1):
      mptcp: fix slab-use-after-free in __inet_lookup_established

Johan Hovold (2):
      wifi: rt2x00usb: fix devres lifetime
      mmc: vub300: fix NULL-deref on disconnect

Kuninori Morimoto (1):
      ASoC: simple-card-utils: Don't use __free(device_node) at graph_util_parse_dai()

Lukas Wunner (1):
      X.509: Fix out-of-bounds access when parsing extensions

Luxiao Xu (1):
      rxrpc: fix reference count leak in rxrpc_server_keyring()

Maarten Lankhorst (1):
      Revert "drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug"

Maciej W. Rozycki (3):
      MIPS: Always record SEGBITS in cpu_data.vmbits
      MIPS: mm: Suppress TLB uniquification on EHINV hardware
      MIPS: mm: Rewrite TLB uniquification for the hidden bit feature

Manivannan Sadhasivam (1):
      Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"

Matthieu Baerts (NGI0) (1):
      Revert "mptcp: add needs_id for netlink appending addr"

Michael Guralnik (1):
      net/mlx5: Update the list of the PCI supported devices

Michael Zimmermann (1):
      usb: gadget: f_hid: move list and spinlock inits from bind to alloc

Mikhail Gavrilov (1):
      Input: uinput - fix circular locking dependency with ff-core

Muhammad Alifa Ramdhan (1):
      net/tls: fix use-after-free in -EBUSY error path of tls_do_encryption

Oleh Konko (1):
      tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG

Pengpeng Hou (2):
      nfc: pn533: allocate rx skb before consuming bytes
      net: qualcomm: qca_uart: report the consumed byte on RX skb allocation failure

Ruide Cao (1):
      batman-adv: reject oversized global TT response buffers

Sebastian Brzezinka (1):
      drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat

Sebastian Krzyszkowiak (2):
      Revert "arm64: dts: imx8mq-librem5: Set the DVS voltages lower"
      arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V

Shawn Guo (2):
      arm64: dts: hisilicon: poplar: Correct PCIe reset GPIO polarity
      arm64: dts: hisilicon: hi3798cv200: Add missing dma-ranges

Srujana Challa (1):
      virtio_net: clamp rss_max_key_size to NETDEV_RSS_KEY_LEN

Thomas Fourier (1):
      wifi: brcmsmac: Fix dma_free_coherent() size

Tuan Do (1):
      netfilter: nft_ct: fix use-after-free in timeout object destroy

Tyllis Xu (1):
      net: stmmac: fix integer underflow in chain mode

Yasuaki Torimaru (1):
      xfrm: clear trailing padding in build_polexpire()

Yuqi Xu (1):
      rxrpc: reject undecryptable rxkad response tickets


