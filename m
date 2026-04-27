Return-Path: <stable+bounces-241351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMjQHf5972lKBwEAu9opvQ
	(envelope-from <stable+bounces-241351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:17:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A41475032
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16EB3302A0AC
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A63358A6;
	Mon, 27 Apr 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nNLHJlWi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB9334C27;
	Mon, 27 Apr 2026 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302762; cv=none; b=YDTTFUOWNRRm9NkSa8CjFDn2nZDrvEIXOZqCDJeqZVHjGXoC33D3eY4MSzQwz7YX/mfnezdYjUQfAoJ/5Gs2eT8eEZbytLGsTN+1V0df3ix8eCahSeDK2XBMAN7t5rA3S2cHsCanZrFEoihsM70279W/H07gfqqh8yXtoEriVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302762; c=relaxed/simple;
	bh=RmJ6fgSuf3KAtgclZ0TVmxpR+kkbT20BL37eWsHJJE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Es/0dYQLrvlVrkIk7jwXHjpWVEQQe3O4rxQKJVhpV8zhw5+R9F6lY84l9ZWNY7/FjCWDiLNzdugO4Z4dynsficwoR3uHc9+8yzv9zyQN8VY1FViDU3MIwHYyqd5PsbPe8/956wgJPS4SsNMg/kz0TNf0NTyxmNVzINYmEWEOjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nNLHJlWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8E9C2BCB7;
	Mon, 27 Apr 2026 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777302762;
	bh=RmJ6fgSuf3KAtgclZ0TVmxpR+kkbT20BL37eWsHJJE4=;
	h=From:To:Cc:Subject:Date:From;
	b=nNLHJlWiaTRUZyyaaDCtBTqrW15YUyNOaE2v6juhdIC9n+bWpNFDv52oRu7qkaVXS
	 vWOvcHpSPhqsmfSH4ySCaKN8XqFe3FA2PzKErcWmjG+HBDVq80OrDKFwb4udH3Xgvh
	 Em70SRm/CSQWxUKEQ715NdsBifCQvUWZI09ZVnSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.84
Date: Mon, 27 Apr 2026 09:12:03 -0600
Message-ID: <2026042704-task-rendition-2d6a@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93A41475032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241351-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

I'm announcing the release of the 6.12.84 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                            |    2 
 drivers/crypto/ccp/sev-dev.c                        |   19 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c             |   39 ++++++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.c         |   22 ++++++-
 drivers/net/ethernet/mediatek/mtk_ppe.c             |   30 +++++++++
 drivers/net/ethernet/mediatek/mtk_ppe.h             |    1 
 drivers/net/wireless/ath/ath9k/channel.c            |    6 -
 drivers/net/wireless/virtual/mac80211_hwsim.c       |    1 
 drivers/pci/endpoint/functions/pci-epf-vntb.c       |   18 -----
 fs/f2fs/compress.c                                  |   14 +++-
 fs/f2fs/namei.c                                     |    1 
 fs/fuse/control.c                                   |    4 -
 fs/fuse/dev.c                                       |    3 
 fs/fuse/readdir.c                                   |    4 +
 fs/ntfs3/fslog.c                                    |   12 +++
 fs/smb/client/cifsacl.c                             |    1 
 fs/smb/client/smb2ops.c                             |    6 +
 fs/smb/server/mgmt/user_config.c                    |    6 -
 fs/smb/server/smb2pdu.c                             |    2 
 fs/smb/server/smbacl.c                              |   61 +++++++++++++++-----
 fs/smb/server/transport_ipc.c                       |   16 ++++-
 fs/smb/server/transport_tcp.c                       |    4 -
 fs/smb/server/vfs_cache.c                           |   41 +++++++++----
 include/linux/hugetlb.h                             |   17 +++++
 include/net/mac80211.h                              |    4 -
 mm/pagewalk.c                                       |   24 +++++++
 mm/userfaultfd.c                                    |    2 
 net/mac80211/tx.c                                   |    4 -
 net/packet/af_packet.c                              |   21 ++++--
 net/rxrpc/conn_event.c                              |   14 +++-
 net/rxrpc/key.c                                     |    4 +
 scripts/dtc/dtc-lexer.l                             |    3 
 scripts/generate_rust_analyzer.py                   |   14 ++++
 scripts/rust_is_available.sh                        |   15 ++++
 scripts/rust_is_available_bindgen_libclang_concat.h |    3 
 scripts/rust_is_available_test.py                   |   34 ++++++++++-
 security/integrity/ima/ima_kexec.c                  |   13 ++++
 sound/usb/caiaq/device.c                            |    4 -
 sound/usb/mixer.c                                   |    7 ++
 39 files changed, 388 insertions(+), 108 deletions(-)

Anderson Nascimento (1):
      rxrpc: Fix missing validation of ticket length in non-XDR key preparsing

Berk Cem Goksel (1):
      ALSA: caiaq: take a reference on the USB device in create_card()

Bernd Schubert (1):
      fuse: Check for large folio with SPLICE_F_MOVE

Bingquan Chen (1):
      net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()

Chao Yu (1):
      f2fs: fix to avoid memory leak in f2fs_rename()

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP JU Jiu

DaeMyung Kang (1):
      smb: server: fix max_connections off-by-one in tcp accept path

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: initialize PPE per-tag-layer MTU registers

Darrick J. Wong (1):
      fuse: quiet down complaints in fuse_conn_limit_write

Felix Fietkau (1):
      wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure

George Saad (1):
      f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()

Greg Kroah-Hartman (2):
      fs/ntfs3: validate rec->used in journal-replay file record check
      Linux 6.12.84

Jianhui Zhou (1):
      mm/userfaultfd: fix hugetlb fault mutex hash calculation

Koichiro Den (1):
      PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown

Max Boone (1):
      mm/pagewalk: fix race between concurrent split and refault

Michael Bommarito (6):
      ksmbd: require minimum ACE size in smb_check_perm_dacl()
      smb: server: fix active_num_conn leak on transport allocation failure
      smb: client: require a full NFS mode SID before reading mode bits
      smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
      ksmbd: validate response sizes in ipc_validate_msg()
      ksmbd: validate num_aces and harden ACE walk in smb_inherit_dacl()

Miguel Ojeda (1):
      rust: warn on bindgen < 0.69.5 and libclang >= 19.1

Mikhail Gavrilov (1):
      drm/amdgpu: replace PASID IDR with XArray

Namjae Jeon (1):
      ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger

Nathan Chancellor (1):
      scripts/dtc: Remove unused dts_version in dtc-lexer.l

Samuel Page (1):
      fuse: reject oversized dirents in page cache

Sean Christopherson (3):
      crypto: ccp: Don't attempt to copy CSR to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy PDH cert to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy ID to userspace if PSP command failed

Steven Chen (2):
      ima: verify if the segment size has changed
      ima: do not copy measurement list to kdump kernel

Tamir Duberstein (1):
      scripts: generate_rust_analyzer.py: define scripts

Tristan Madani (2):
      ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment
      ksmbd: use check_add_overflow() to prevent u16 DACL size overflow

Wang Jie (1):
      rxrpc: only handle RESPONSE during service challenge


