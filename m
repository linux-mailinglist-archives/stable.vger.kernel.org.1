Return-Path: <stable+bounces-238573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEc/IHdG42mgEAEAu9opvQ
	(envelope-from <stable+bounces-238573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:53:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C594207A4
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C235301CEC0
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACF137D138;
	Sat, 18 Apr 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a62z5vnE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6737E2F7;
	Sat, 18 Apr 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776502320; cv=none; b=ZFz4xIAo1odOq9vFL4cjI2pm9kagYuZxGpC2kGJP0Wz2SjGWm//4pyuLBHZSNZZl1Fp4H5ysz+l9jbUkT/yKydQ2osdlw+7ZTF0NfDg/cO5PcT4qpc7UeeF4X8KET9i+vvCdnU1AnWCiuko9/nGGmUrGnVddBa6RxhcKc856oaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776502320; c=relaxed/simple;
	bh=LC2rE53Bt1p8hIyaKOhz9Mr1Le3woQ/gPjFEwvNwIPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W3aCGk0hoU74d5Jg5igBZbb6duGRylXQaEh5aHKmHsMmBLwnES0HC6u4RRXZTlPdY50yQWKV+xMhaBWKOHOtbSaiusi8DVgxl44i5iXNFUPIf5qTNHQ2Z5+3GFIaLf3riCauVJtj+Cz/IOMu9tBMvIfN4S4KBYpWa/Lfx0eEKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a62z5vnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C170AC4AF0B;
	Sat, 18 Apr 2026 08:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776502320;
	bh=LC2rE53Bt1p8hIyaKOhz9Mr1Le3woQ/gPjFEwvNwIPk=;
	h=From:To:Cc:Subject:Date:From;
	b=a62z5vnE3mlVfdwh51SGjsF/FUXfkgRR7jOVPziYm0Ru03hsGlVXhvNQtx4wMevq2
	 2RsfFAyx0y66iUrD2jy540n9JLFDEo+UG1bYKrZofzcWQ3U8zR5D1OpDdKyNbBNRle
	 RDll1kAHpcVFw65fxe3mGM0K3oAIhd6mr6NLYbWk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.82
Date: Sat, 18 Apr 2026 10:51:20 +0200
Message-ID: <2026041821-brigade-feline-da8d@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238573-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 77C594207A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.12.82 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                            |    2 
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts                 |    2 
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi                   |   24 
 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts                |    2 
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi                      |    1 
 arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi              |    8 
 arch/loongarch/include/asm/setup.h                                  |    3 
 arch/loongarch/kernel/unwind_orc.c                                  |   28 
 arch/mips/include/asm/cpu-features.h                                |    1 
 arch/mips/include/asm/cpu-info.h                                    |    2 
 arch/mips/include/asm/mipsregs.h                                    |    2 
 arch/mips/kernel/cpu-probe.c                                        |   13 
 arch/mips/kernel/cpu-r3k-probe.c                                    |    2 
 arch/mips/mm/tlb-r4k.c                                              |  285 ++++++++--
 arch/x86/include/asm/msr-index.h                                    |    3 
 arch/x86/kernel/cpu/amd.c                                           |    3 
 crypto/asymmetric_keys/x509_cert_parser.c                           |    8 
 drivers/edac/edac_mc.c                                              |    6 
 drivers/gpu/drm/i915/display/intel_psr.c                            |   30 -
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c                    |   26 
 drivers/input/misc/uinput.c                                         |   35 -
 drivers/misc/fastrpc.c                                              |    4 
 drivers/mmc/host/vub300.c                                           |    2 
 drivers/net/ethernet/altera/altera_tse_main.c                       |    1 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                     |    6 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                      |    1 
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c               |   28 
 drivers/net/ethernet/qualcomm/qca_uart.c                            |    2 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c                    |   11 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c              |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c                      |    2 
 drivers/nfc/pn533/uart.c                                            |   11 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c |    8 
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c                              |    8 
 drivers/usb/typec/ucsi/ucsi.c                                       |    3 
 fs/btrfs/disk-io.c                                                  |   13 
 fs/btrfs/extent-tree.c                                              |   30 -
 fs/btrfs/extent_io.c                                                |   33 -
 fs/btrfs/extent_io.h                                                |   18 
 include/net/netfilter/nf_conntrack_timeout.h                        |    1 
 include/trace/events/rxrpc.h                                        |    2 
 kernel/sched/ext.c                                                  |   48 +
 kernel/trace/blktrace.c                                             |    4 
 kernel/workqueue.c                                                  |   14 
 lib/crypto/chacha.c                                                 |    4 
 mm/filemap.c                                                        |   11 
 net/batman-adv/bridge_loop_avoidance.c                              |   27 
 net/batman-adv/translation-table.c                                  |    9 
 net/core/skbuff.c                                                   |    5 
 net/core/skmsg.c                                                    |   14 
 net/ipv4/tcp.c                                                      |    4 
 net/ipv4/tcp_bpf.c                                                  |    2 
 net/ipv4/tcp_input.c                                                |   14 
 net/ipv4/tcp_minisocks.c                                            |    2 
 net/ipv4/udp.c                                                      |    3 
 net/ipv4/udp_bpf.c                                                  |    2 
 net/ipv6/seg6_iptunnel.c                                            |   34 -
 net/mptcp/pm_netlink.c                                              |   24 
 net/mptcp/protocol.c                                                |    2 
 net/mptcp/protocol.h                                                |    1 
 net/mptcp/subflow.c                                                 |   15 
 net/netfilter/nft_ct.c                                              |    2 
 net/nfc/nci/core.c                                                  |    9 
 net/rfkill/core.c                                                   |   35 -
 net/rxrpc/af_rxrpc.c                                                |    6 
 net/rxrpc/call_object.c                                             |   25 
 net/rxrpc/io_thread.c                                               |    3 
 net/rxrpc/key.c                                                     |    2 
 net/rxrpc/rxkad.c                                                   |   63 +-
 net/rxrpc/sendmsg.c                                                 |    2 
 net/rxrpc/server_key.c                                              |    3 
 net/tipc/group.c                                                    |    6 
 net/tls/tls_sw.c                                                    |   10 
 net/unix/af_unix.c                                                  |    8 
 net/xfrm/xfrm_user.c                                                |    3 
 sound/pci/hda/patch_hdmi.c                                          |    1 
 sound/soc/generic/simple-card-utils.c                               |    7 
 77 files changed, 739 insertions(+), 357 deletions(-)

Aaron Erhardt (1):
      ALSA: hda/hdmi: Add quirk for TUXEDO IBS14G6

Anderson Nascimento (1):
      rxrpc: Fix key reference count leak from call->key

Andrea Mayer (1):
      seg6: separate dst_cache for input and output paths in seg6 lwtunnel

Andrea Righi (1):
      sched_ext: Fix stale direct dispatch state in ddsp_dsq_id

Baolin Wang (1):
      mm: filemap: fix nr_pages calculation overflow in filemap_map_pages()

Borislav Petkov (AMD) (2):
      EDAC/mc: Fix error path ordering in edac_mc_alloc()
      x86/CPU: Fix FPDSS on Zen1

Chaitanya Kulkarni (1):
      blktrace: fix __this_cpu_read/write in preemptible context

Daniel Vacek (2):
      btrfs: remove unused flag EXTENT_BUFFER_READAHEAD
      btrfs: remove unused flag EXTENT_BUFFER_CORRUPT

David Carlier (4):
      net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()
      net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
      net: lan966x: fix page pool leak in error paths
      net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()

David Howells (4):
      rxrpc: Fix anonymous key handling
      rxrpc: Fix call removal to use RCU safe deletion
      rxrpc: Fix key/keyring checks in setsockopt(RXRPC_SECURITY_KEY/KEYRING)
      rxrpc: Fix missing error checks for rxkad encryption/decryption failure

David Sterba (3):
      btrfs: make wait_on_extent_buffer_writeback() static inline
      btrfs: remove unused define WAIT_PAGE_LOCK for extent io
      btrfs: split waiting from read_extent_buffer_pages(), drop parameter wait

Dmitry Torokhov (1):
      Input: uinput - take event lock when submitting FF request "event"

Douya Le (1):
      rxrpc: Only put the call ref if one was acquired

Emil Tantilov (2):
      idpf: improve locking around idpf_vc_xn_push_free()
      idpf: set the payload size before calling the async handler

Eric Biggers (1):
      lib/crypto: chacha: Zeroize permuted_state before it leaves scope

Eric Dumazet (1):
      net: annotate data-races around sk->sk_{data_ready,write_space}

Filipe Manana (1):
      btrfs: remove pointless out labels from extent-tree.c

Geert Uytterhoeven (1):
      arm64: dts: renesas: white-hawk-cpu-common: Add pin control for DSI-eDP IRQ

Greg Kroah-Hartman (3):
      xfrm_user: fix info leak in build_report()
      net: rfkill: prevent unlimited numbers of rfkill events from being created
      Linux 6.12.82

Haoze Xie (1):
      batman-adv: hold claim backbone gateways by reference

Jacky Bai (1):
      pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled

Jakub Kicinski (1):
      nfc: nci: complete pending data exchange on device close

Jiayuan Chen (2):
      mptcp: fix slab-use-after-free in __inet_lookup_established
      net: skb: fix cross-cache free of KFENCE-allocated skb head

Johan Hovold (2):
      wifi: rt2x00usb: fix devres lifetime
      mmc: vub300: fix NULL-deref on disconnect

Jouni Högander (1):
      drm/i915/psr: Do not use pipe_src as borders for SU area

Kuninori Morimoto (1):
      ASoC: simple-card-utils: Don't use __free(device_node) at graph_util_parse_dai()

Lukas Wunner (1):
      X.509: Fix out-of-bounds access when parsing extensions

Luxiao Xu (1):
      rxrpc: fix reference count leak in rxrpc_server_keyring()

Maciej W. Rozycki (3):
      MIPS: Always record SEGBITS in cpu_data.vmbits
      MIPS: mm: Suppress TLB uniquification on EHINV hardware
      MIPS: mm: Rewrite TLB uniquification for the hidden bit feature

Matthew Brost (1):
      workqueue: Add pool_workqueue to pending_pwqs list when unplugging multiple inactive works

Matthieu Baerts (NGI0) (1):
      Revert "mptcp: add needs_id for netlink appending addr"

Michael Guralnik (1):
      net/mlx5: Update the list of the PCI supported devices

Mikhail Gavrilov (1):
      Input: uinput - fix circular locking dependency with ff-core

Muhammad Alifa Ramdhan (1):
      net/tls: fix use-after-free in -EBUSY error path of tls_do_encryption

Nathan Rebello (1):
      usb: typec: ucsi: skip connector validation before init

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

Srinivas Pandruvada (1):
      platform/x86/intel-uncore-freq: Handle autonomous UFS status bit

Thomas Fourier (1):
      wifi: brcmsmac: Fix dma_free_coherent() size

Tiezhu Yang (2):
      LoongArch: Remove unnecessary checks for ORC unwinder
      LoongArch: Handle percpu handler address for ORC unwinder

Tuan Do (1):
      netfilter: nft_ct: fix use-after-free in timeout object destroy

Tyllis Xu (1):
      net: stmmac: fix integer underflow in chain mode

Xingjing Deng (1):
      misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe

Yasuaki Torimaru (1):
      xfrm: clear trailing padding in build_polexpire()

Yuqi Xu (1):
      rxrpc: reject undecryptable rxkad response tickets

robbieko (1):
      btrfs: fix incorrect return value after changing leaf in lookup_extent_data_ref()


