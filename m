Return-Path: <stable+bounces-238577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGpaGhBH42mgEAEAu9opvQ
	(envelope-from <stable+bounces-238577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:55:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE0C4207FD
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 296FD30A71D9
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB0637FF41;
	Sat, 18 Apr 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MjE+0H4k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128437DEA5;
	Sat, 18 Apr 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776502334; cv=none; b=nawrz4YB8LM7kxVh2nFfHfu9fOditFRwa1JF3MxyznFPAMQeet6uHEfjyemE4O1VmMYRXslPZgHx+VxbbcMeydOtzsqem2orxGgpgIo8w9u79WpR5bwCr12L+DFNAX0B/TLcp8Byo9HXQ2ah9Z9DA6VOdbqzYSRMnW8ue12UC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776502334; c=relaxed/simple;
	bh=b0Db4CfCz9Klou+dNs7r+Gb1qYJ/RnQEidIlChiZmGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1EPCXQnPtcedGaKAr78lPmdOxVEQF+Dsi4y/DiO114eddGJKJrDmRYabeoK2xhM1wSJLnBBUNOEARPXgbm7lL8Z6gf+5NbRPleg0uhEe6p2nwCKC1NbMTY7zC7QiRaOgcQzdR9SngoBk8m6P1pIGv33zREJ0TEm/Gq8HJ45ed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MjE+0H4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93204C19424;
	Sat, 18 Apr 2026 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776502334;
	bh=b0Db4CfCz9Klou+dNs7r+Gb1qYJ/RnQEidIlChiZmGM=;
	h=From:To:Cc:Subject:Date:From;
	b=MjE+0H4krjqg5dFehwRmCgMrVGHcYVKqTsjonP1m3nhT6l2zWTzJtyuDVoIQuqFyC
	 N0rtqJhRqzostP2m0sdC+ttHLLbow4OnZTFO4DXFz/DChd4FlkAjZXLvWiLEbYMZpi
	 MJtne//OI8QE6phIhOmRXAa6ipKteKs3JLCnD6hI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.19.13
Date: Sat, 18 Apr 2026 10:51:32 +0200
Message-ID: <2026041833-snowbird-deviant-beb9@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238577-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BBE0C4207FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.19.13 kernel.

All users of the 6.19 kernel series must upgrade.

The updated 6.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.19.y
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
 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts               |   11 
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts                |   18 
 arch/mips/include/asm/cpu-features.h                                |    1 
 arch/mips/include/asm/cpu-info.h                                    |    2 
 arch/mips/include/asm/mipsregs.h                                    |    2 
 arch/mips/kernel/cpu-probe.c                                        |   13 
 arch/mips/kernel/cpu-r3k-probe.c                                    |    2 
 arch/mips/mm/tlb-r4k.c                                              |  285 ++++++++--
 arch/x86/include/asm/msr-index.h                                    |    3 
 arch/x86/kernel/cpu/amd.c                                           |    3 
 arch/x86/kernel/cpu/mce/amd.c                                       |    8 
 crypto/asymmetric_keys/x509_cert_parser.c                           |    8 
 drivers/edac/edac_mc.c                                              |    6 
 drivers/firmware/thead,th1520-aon.c                                 |    7 
 drivers/gpu/drm/i915/display/intel_psr.c                            |   30 -
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c                    |   26 
 drivers/i2c/busses/i2c-imx.c                                        |    2 
 drivers/input/misc/uinput.c                                         |   35 -
 drivers/mmc/host/vub300.c                                           |   19 
 drivers/net/ethernet/altera/altera_tse_main.c                       |    1 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c                     |   20 
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h                     |    5 
 drivers/net/ethernet/intel/igb/igb_main.c                           |    3 
 drivers/net/ethernet/mellanox/mlx5/core/main.c                      |    1 
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c               |   28 
 drivers/net/ethernet/qualcomm/qca_uart.c                            |    2 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c                    |   11 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c              |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c                      |    2 
 drivers/nfc/pn533/uart.c                                            |   11 
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c         |    2 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c |    8 
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c                              |    8 
 drivers/usb/typec/ucsi/ucsi.c                                       |    3 
 fs/btrfs/extent-tree.c                                              |   24 
 include/linux/firmware/thead/thead,th1520-aon.h                     |   74 --
 include/net/netfilter/nf_conntrack_timeout.h                        |    1 
 include/trace/events/rxrpc.h                                        |    4 
 kernel/liveupdate/luo_session.c                                     |    9 
 kernel/workqueue.c                                                  |   14 
 mm/damon/stat.c                                                     |    7 
 mm/damon/sysfs.c                                                    |    3 
 mm/filemap.c                                                        |   11 
 mm/memory_hotplug.c                                                 |   20 
 mm/vma.c                                                            |    7 
 net/batman-adv/bridge_loop_avoidance.c                              |   27 
 net/batman-adv/translation-table.c                                  |    9 
 net/core/skbuff.c                                                   |    5 
 net/ipv4/xfrm4_input.c                                              |    5 
 net/ipv6/seg6_iptunnel.c                                            |   34 -
 net/ipv6/xfrm6_input.c                                              |    5 
 net/mptcp/pm_kernel.c                                               |   24 
 net/mptcp/protocol.c                                                |    2 
 net/mptcp/protocol.h                                                |    1 
 net/mptcp/subflow.c                                                 |   15 
 net/netfilter/nft_ct.c                                              |    2 
 net/rfkill/core.c                                                   |   35 -
 net/rxrpc/af_rxrpc.c                                                |    6 
 net/rxrpc/ar-internal.h                                             |    2 
 net/rxrpc/call_object.c                                             |   25 
 net/rxrpc/conn_event.c                                              |   19 
 net/rxrpc/input_rack.c                                              |    2 
 net/rxrpc/io_thread.c                                               |    3 
 net/rxrpc/key.c                                                     |   40 -
 net/rxrpc/output.c                                                  |    2 
 net/rxrpc/proc.c                                                    |   37 -
 net/rxrpc/rxgk.c                                                    |   19 
 net/rxrpc/rxkad.c                                                   |   63 +-
 net/rxrpc/sendmsg.c                                                 |    2 
 net/rxrpc/server_key.c                                              |    3 
 net/tipc/group.c                                                    |    6 
 net/tls/tls_sw.c                                                    |   10 
 net/xfrm/xfrm_input.c                                               |   18 
 net/xfrm/xfrm_user.c                                                |    3 
 scripts/Makefile.package                                            |    3 
 scripts/mod/modpost.c                                               |    2 
 sound/hda/codecs/realtek/alc662.c                                   |    9 
 sound/hda/controllers/intel.c                                       |    7 
 sound/soc/sof/intel/hda-pcm.c                                       |   14 
 84 files changed, 800 insertions(+), 452 deletions(-)

Alex Dvoretsky (1):
      igb: remove napi_synchronize() in igb_down()

Alok Tiwari (2):
      rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial
      rxrpc: Fix rack timer warning to report unexpected mode

Anderson Nascimento (1):
      rxrpc: Fix key reference count leak from call->key

Andrea Mayer (1):
      seg6: separate dst_cache for input and output paths in seg6 lwtunnel

Anthony Pighin (1):
      i2c: imx: zero-initialize dma_slave_config for eDMA

Baolin Wang (1):
      mm: filemap: fix nr_pages calculation overflow in filemap_map_pages()

Borislav Petkov (AMD) (2):
      EDAC/mc: Fix error path ordering in edac_mc_alloc()
      x86/CPU: Fix FPDSS on Zen1

David Carlier (4):
      net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()
      net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
      net: lan966x: fix page pool leak in error paths
      net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()

David Howells (9):
      rxrpc: Fix key quota calculation for multitoken keys
      rxrpc: Fix key parsing memleak
      rxrpc: Fix anonymous key handling
      rxrpc: Fix call removal to use RCU safe deletion
      rxrpc: Fix key/keyring checks in setsockopt(RXRPC_SECURITY_KEY/KEYRING)
      rxrpc: Fix missing error checks for rxkad encryption/decryption failure
      rxrpc: Fix integer overflow in rxgk_verify_response()
      rxrpc: Fix leak of rxgk context in rxgk_verify_response()
      rxrpc: Fix buffer overread in rxgk_do_verify_authenticator()

Dmitry Torokhov (1):
      Input: uinput - take event lock when submitting FF request "event"

Douya Le (1):
      rxrpc: Only put the call ref if one was acquired

Emil Tantilov (3):
      idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling
      idpf: improve locking around idpf_vc_xn_push_free()
      idpf: set the payload size before calling the async handler

Filipe Manana (1):
      btrfs: remove pointless out labels from extent-tree.c

Greg Kroah-Hartman (3):
      xfrm_user: fix info leak in build_report()
      net: rfkill: prevent unlimited numbers of rfkill events from being created
      Linux 6.19.13

Hao Li (1):
      mm/memory_hotplug: maintain N_NORMAL_MEMORY during hotplug

Haoze Xie (1):
      batman-adv: hold claim backbone gateways by reference

Heiko Stuebner (1):
      Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinebook Pro"

Jacky Bai (1):
      pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled

Janne Grunau (1):
      kbuild: modules-cpio-pkg: Respect INSTALL_MOD_PATH

Jiayuan Chen (2):
      mptcp: fix slab-use-after-free in __inet_lookup_established
      net: skb: fix cross-cache free of KFENCE-allocated skb head

Johan Hovold (3):
      wifi: rt2x00usb: fix devres lifetime
      mmc: vub300: fix NULL-deref on disconnect
      mmc: vub300: fix use-after-free on disconnect

Jouni Högander (1):
      drm/i915/psr: Do not use pipe_src as borders for SU area

Kai Vehmanen (2):
      ALSA: hda/intel: enforce stricter period-size alignment for Intel NVL
      ASoC: SOF: Intel: hda: modify period size constraints for ACE4

Keenan Dong (2):
      rxrpc: fix RESPONSE authenticator parser OOB read
      rxrpc: fix oversized RESPONSE authenticator length check

Leo Timmins (1):
      liveupdate: propagate file deserialization failures

Lukas Wunner (1):
      X.509: Fix out-of-bounds access when parsing extensions

Luxiao Xu (1):
      rxrpc: fix reference count leak in rxrpc_server_keyring()

Maciej W. Rozycki (3):
      MIPS: Always record SEGBITS in cpu_data.vmbits
      MIPS: mm: Suppress TLB uniquification on EHINV hardware
      MIPS: mm: Rewrite TLB uniquification for the hidden bit feature

Marc Dionne (1):
      rxrpc: Fix to request an ack if window is limited

Marek Vasut (1):
      arm64: dts: renesas: sparrow-hawk: Reserve first 128 MiB of DRAM

Matthew Brost (1):
      workqueue: Add pool_workqueue to pending_pwqs list when unplugging multiple inactive works

Matthieu Baerts (NGI0) (1):
      Revert "mptcp: add needs_id for netlink appending addr"

Michael Guralnik (1):
      net/mlx5: Update the list of the PCI supported devices

Michal Wilczynski (1):
      firmware: thead: Fix buffer overflow and use standard endian macros

Mikhail Gavrilov (1):
      Input: uinput - fix circular locking dependency with ff-core

Muhammad Alifa Ramdhan (1):
      net/tls: fix use-after-free in -EBUSY error path of tls_do_encryption

Nathan Chancellor (1):
      modpost: Declare extra_warn with unused attribute

Nathan Rebello (1):
      usb: typec: ucsi: skip connector validation before init

Oleh Konko (2):
      tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
      rxrpc: Fix RxGK token loading to check bounds

Pengpeng Hou (3):
      nfc: pn533: allocate rx skb before consuming bytes
      net: qualcomm: qca_uart: report the consumed byte on RX skb allocation failure
      rxrpc: proc: size address buffers for %pISpc output

Qi Tang (1):
      xfrm: hold dev ref until after transport_finish NF_HOOK

Ruide Cao (1):
      batman-adv: reject oversized global TT response buffers

Sebastian Brzezinka (1):
      drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat

Sebastian Krzyszkowiak (2):
      Revert "arm64: dts: imx8mq-librem5: Set the DVS voltages lower"
      arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V

Sechang Lim (1):
      mm/vma: fix memory leak in __mmap_region()

SeongJae Park (2):
      mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
      mm/damon/stat: deallocate damon_call() failure leaking damon_ctx

Shawn Guo (2):
      arm64: dts: hisilicon: poplar: Correct PCIe reset GPIO polarity
      arm64: dts: hisilicon: hi3798cv200: Add missing dma-ranges

Srinivas Pandruvada (2):
      platform/x86: ISST: Reset core count to 0
      platform/x86/intel-uncore-freq: Handle autonomous UFS status bit

Takashi Iwai (1):
      Revert "ALSA: hda/realtek: Add quirk for Gigabyte Technology to fix headphone"

Thomas Fourier (1):
      wifi: brcmsmac: Fix dma_free_coherent() size

Tuan Do (1):
      netfilter: nft_ct: fix use-after-free in timeout object destroy

Tyllis Xu (1):
      net: stmmac: fix integer underflow in chain mode

Wang Jie (1):
      rxrpc: only handle RESPONSE during service challenge

Yasuaki Torimaru (1):
      xfrm: clear trailing padding in build_polexpire()

Yazen Ghannam (1):
      x86/mce/amd: Filter bogus hardware errors on Zen3 clients

Yuqi Xu (1):
      rxrpc: reject undecryptable rxkad response tickets

robbieko (1):
      btrfs: fix incorrect return value after changing leaf in lookup_extent_data_ref()


