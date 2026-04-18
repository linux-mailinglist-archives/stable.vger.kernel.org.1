Return-Path: <stable+bounces-238570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BojCzRG42mgEAEAu9opvQ
	(envelope-from <stable+bounces-238570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:52:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8B4420769
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BBED300D4F0
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815AA37D138;
	Sat, 18 Apr 2026 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sO15/YPr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD837CD52;
	Sat, 18 Apr 2026 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776502310; cv=none; b=frdWkCY4DJHFYZ6Pl5y2E5kN4ppYBSRdiOc8GefHBU0nBY8yd7n/7MhqDQXTGD4L09lmgC7pDkuNCjR4wGitJWwiJe32WrmMFtXXr8w+jN4Lan/Ur83iFdhN4NH2LhObdXD0W4e6Fatr3I5qjCkd7zn17aF3TX1u4263wHeB8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776502310; c=relaxed/simple;
	bh=WDrmY1A1mcpe3f9LcONDJjX94yZ0HRWgW7AiK7qw+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOIW668OfNn6J3f7vW41R543+J+RoudT+/cxPraXIJBvAzj5jey2P6/RH2VhkJ6q5b8SvY6Km/EZsOhVSFb3mLpNPKdCSwsUkQOzxzzy7HJu9KqzpmeGa5AmZ1Uo4vLln+UiuQxJuJ2CIs/iOwuJA5u16S6eruvzRck8g+RTl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sO15/YPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE41AC19424;
	Sat, 18 Apr 2026 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776502310;
	bh=WDrmY1A1mcpe3f9LcONDJjX94yZ0HRWgW7AiK7qw+/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=sO15/YPropsxkr6MlqZeaiT3r9rzITyYrN01zdDqHvQoNJYInVXANirrGkHeUbpjT
	 aRrXQvPEwx11GRqVaeK+CjUfh5a8mZzwUvpAM2rmPIE3oJ4WVLOk7HttDA7KiQ+N08
	 QXWq/DRtoq5etEF4HcBKUHOe8dUkxRXLESLZe7Qk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.169
Date: Sat, 18 Apr 2026 10:51:06 +0200
Message-ID: <2026041807-unseen-molasses-cf82@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238570-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC8B4420769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.1.169 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                               |    2 
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
 drivers/acpi/acpica/acevents.h                         |    6 
 drivers/acpi/acpica/evregion.c                         |   12 
 drivers/acpi/acpica/evxfregn.c                         |   64 ---
 drivers/acpi/ec.c                                      |   14 
 drivers/acpi/internal.h                                |    1 
 drivers/acpi/scan.c                                    |    2 
 drivers/edac/edac_mc.c                                 |    6 
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c       |   26 +
 drivers/gpu/drm/scheduler/sched_entity.c               |    1 
 drivers/input/misc/uinput.c                            |   35 +-
 drivers/media/usb/uvc/uvc_driver.c                     |   88 +++--
 drivers/media/usb/uvc/uvcvideo.h                       |    2 
 drivers/mmc/host/vub300.c                              |    2 
 drivers/net/ethernet/altera/altera_tse_main.c          |    1 
 drivers/net/ethernet/mellanox/mlx5/core/main.c         |    1 
 drivers/net/ethernet/qualcomm/qca_uart.c               |    2 
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c       |   11 
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00usb.c         |    2 
 drivers/nfc/pn533/uart.c                               |   11 
 drivers/pci/pci-driver.c                               |    8 
 drivers/pci/pci.c                                      |   10 
 drivers/pci/pci.h                                      |    1 
 drivers/usb/gadget/function/f_hid.c                    |   11 
 drivers/usb/gadget/function/u_ether.c                  |    8 
 include/acpi/acpixf.h                                  |    5 
 include/net/netfilter/nf_conntrack_timeout.h           |    1 
 lib/crypto/chacha.c                                    |    4 
 net/batman-adv/bridge_loop_avoidance.c                 |   27 +
 net/batman-adv/translation-table.c                     |    9 
 net/ipv6/seg6_iptunnel.c                               |   41 +-
 net/mptcp/pm_netlink.c                                 |   24 -
 net/mptcp/protocol.c                                   |    2 
 net/mptcp/protocol.h                                   |    1 
 net/mptcp/subflow.c                                    |   15 
 net/netfilter/nft_ct.c                                 |    2 
 net/netfilter/nft_set_pipapo.c                         |   20 -
 net/rfkill/core.c                                      |   84 +++--
 net/rxrpc/af_rxrpc.c                                   |    6 
 net/rxrpc/key.c                                        |    2 
 net/rxrpc/server_key.c                                 |    3 
 net/tipc/group.c                                       |    6 
 net/tls/tls_sw.c                                       |   10 
 net/xfrm/xfrm_user.c                                   |    3 
 security/apparmor/apparmorfs.c                         |  228 ++++++++-----
 security/apparmor/include/label.h                      |   16 
 security/apparmor/include/lib.h                        |   12 
 security/apparmor/include/match.h                      |    1 
 security/apparmor/include/policy.h                     |   13 
 security/apparmor/include/policy_ns.h                  |    2 
 security/apparmor/include/policy_unpack.h              |   75 ++--
 security/apparmor/label.c                              |   12 
 security/apparmor/match.c                              |   58 ++-
 security/apparmor/policy.c                             |   82 ++++
 security/apparmor/policy_ns.c                          |    2 
 security/apparmor/policy_unpack.c                      |   58 ++-
 67 files changed, 982 insertions(+), 485 deletions(-)

Andrea Mayer (1):
      seg6: separate dst_cache for input and output paths in seg6 lwtunnel

Bo Liu (1):
      rfkill: Use sysfs_emit() to instead of sprintf()

Borislav Petkov (AMD) (2):
      EDAC/mc: Fix error path ordering in edac_mc_alloc()
      x86/CPU: Fix FPDSS on Zen1

David Carlier (1):
      net: altera-tse: fix skb leak on DMA mapping error in tse_start_xmit()

David Howells (1):
      rxrpc: Fix key/keyring checks in setsockopt(RXRPC_SECURITY_KEY/KEYRING)

Dmitry Torokhov (1):
      Input: uinput - take event lock when submitting FF request "event"

Eric Biggers (1):
      lib/crypto: chacha: Zeroize permuted_state before it leaves scope

Florian Westphal (1):
      netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR

Greg Kroah-Hartman (3):
      xfrm_user: fix info leak in build_report()
      net: rfkill: prevent unlimited numbers of rfkill events from being created
      Linux 6.1.169

Haoze Xie (1):
      batman-adv: hold claim backbone gateways by reference

Jiayuan Chen (1):
      mptcp: fix slab-use-after-free in __inet_lookup_established

Johan Hovold (2):
      wifi: rt2x00usb: fix devres lifetime
      mmc: vub300: fix NULL-deref on disconnect

Johannes Berg (2):
      rfkill: sync before userspace visibility/changes
      net: rfkill: reduce data->mtx scope in rfkill_fop_open

John Johansen (6):
      apparmor: fix: limit the number of levels of policy namespaces
      apparmor: Fix double free of ns_name in aa_replace_profiles()
      apparmor: fix unprivileged local user can do privileged policy management
      apparmor: fix differential encoding verification
      apparmor: fix race on rawdata dereference
      apparmor: fix race between freeing data and fs accessing it

Kuen-Han Tsai (1):
      usb: gadget: u_ether: Fix race between gether_disconnect and eth_stop

Lin.Cao (1):
      drm/scheduler: signal scheduled fence when kill job

Luxiao Xu (1):
      rxrpc: fix reference count leak in rxrpc_server_keyring()

Maciej W. Rozycki (3):
      MIPS: Always record SEGBITS in cpu_data.vmbits
      MIPS: mm: Suppress TLB uniquification on EHINV hardware
      MIPS: mm: Rewrite TLB uniquification for the hidden bit feature

Manivannan Sadhasivam (1):
      Revert "PCI: Enable ACS after configuring IOMMU for OF platforms"

Massimiliano Pellizzer (5):
      apparmor: validate DFA start states are in bounds in unpack_pdb
      apparmor: fix memory leak in verify_header
      apparmor: replace recursive profile removal with iterative approach
      apparmor: fix side-effect bug in match_char() macro usage
      apparmor: fix missing bounds check on DEFAULT table in verify_dfa()

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

Rafael J. Wysocki (3):
      Revert "ACPI: EC: Evaluate orphan _REG under EC device"
      ACPICA: Add a depth argument to acpi_execute_reg_methods()
      ACPI: EC: Evaluate _REG outside the EC scope more carefully

Ricardo Ribalda (1):
      media: uvcvideo: Use heuristic to find stream entity

Ruide Cao (1):
      batman-adv: reject oversized global TT response buffers

Sebastian Brzezinka (1):
      drm/i915/gt: fix refcount underflow in intel_engine_park_heartbeat

Shawn Guo (2):
      arm64: dts: hisilicon: poplar: Correct PCIe reset GPIO polarity
      arm64: dts: hisilicon: hi3798cv200: Add missing dma-ranges

Thadeu Lima de Souza Cascardo (1):
      media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID

Thomas Fourier (1):
      wifi: brcmsmac: Fix dma_free_coherent() size

Tuan Do (1):
      netfilter: nft_ct: fix use-after-free in timeout object destroy

Tyllis Xu (1):
      net: stmmac: fix integer underflow in chain mode

Yasuaki Torimaru (1):
      xfrm: clear trailing padding in build_polexpire()


