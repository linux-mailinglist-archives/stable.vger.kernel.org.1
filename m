Return-Path: <stable+bounces-241355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPuCN/V+72lKBwEAu9opvQ
	(envelope-from <stable+bounces-241355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:21:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDEF475113
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABDD930C8AEF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB1D37F002;
	Mon, 27 Apr 2026 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M1/RtnhZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE237CD22;
	Mon, 27 Apr 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302772; cv=none; b=YhFEc/kwwmklSaC1HNdKlgz5wa1pW81zKodykXL1odnX3Z/Bclz/aRopqpnyo+zdFr6V2vuSYqpGm6DIKAawe/erfL/tGIxiccK8YdupiPcab535+roYW+jjLw6VCUe85NihveLyQN1xJcX/A/hz/8nt6GpgTYxgg8Y9W+ntQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302772; c=relaxed/simple;
	bh=NrT+lkgxAaUQGBqclgxhvbLZ/BP/FT4o+nzUY5ge2M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNy9noceuopyqfAercQVG1qJVbnnfmWEXXMB5TzXfUC2nO5WaZR5IP9xYXoO8hgb/SfK+T9t/oetaT38jVSkhejosATnMm5sEuNfWgDasT+Nb7zNqNSYI3Uc7d5woNRl+cyzwb9qW8JarW1cV5qSYLfL1vaPv21rZ79Td7xNu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M1/RtnhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E64C2BCB4;
	Mon, 27 Apr 2026 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777302772;
	bh=NrT+lkgxAaUQGBqclgxhvbLZ/BP/FT4o+nzUY5ge2M8=;
	h=From:To:Cc:Subject:Date:From;
	b=M1/RtnhZO+mGJZYL7oF+Px8fbBxGy13n2xhP76M58BbSN+XXRO6JCWvO5AY5jiYJ3
	 qahZvjOmQ9yOsjDhKfYzX84x8/PEq2rlvKaZMJRNiHuTjZ8Nz5//qgj4Noa5BvhJHE
	 gFx/FYBGIm5lH0YkL5Q5Md5RyX4nhACa20DpyxMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.0.2
Date: Mon, 27 Apr 2026 09:12:15 -0600
Message-ID: <2026042716-hamster-implement-77c1@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3EDEF475113
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241355-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

I'm announcing the release of the 7.0.2 kernel.

All users of the 7.0 kernel series must upgrade.

The updated 7.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                |    2 
 crypto/authencesn.c                     |    6 +
 crypto/krb5enc.c                        |   51 +++++++-----
 drivers/crypto/ccp/sev-dev.c            |   19 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |   39 ++++-----
 drivers/hv/mshv_vtl_main.c              |   12 ++-
 drivers/pwm/pwm_th1520.rs               |    5 -
 fs/f2fs/compress.c                      |   14 ++-
 fs/f2fs/data.c                          |    7 +
 fs/f2fs/f2fs.h                          |    2 
 fs/f2fs/namei.c                         |    1 
 fs/f2fs/segment.c                       |    6 -
 fs/f2fs/super.c                         |   11 ++
 fs/fs-writeback.c                       |   36 ++++-----
 fs/fuse/control.c                       |    4 -
 fs/fuse/dev.c                           |   30 ++++---
 fs/fuse/fuse_i.h                        |    1 
 fs/fuse/inode.c                         |    1 
 fs/fuse/readdir.c                       |    4 +
 fs/ntfs3/fslog.c                        |   12 ++-
 fs/smb/client/cifsacl.c                 |  117 +++++++++++++++++++++--------
 fs/smb/client/connect.c                 |   10 +-
 fs/smb/client/smb1ops.c                 |   19 ++--
 fs/smb/client/smb2ops.c                 |    6 +
 fs/smb/server/connection.c              |    5 -
 fs/smb/server/mgmt/user_config.c        |    6 -
 fs/smb/server/mgmt/user_session.c       |    8 --
 fs/smb/server/oplock.c                  |    7 +
 fs/smb/server/oplock.h                  |    1 
 fs/smb/server/smb2pdu.c                 |    5 +
 fs/smb/server/smbacl.c                  |   61 ++++++++++++---
 fs/smb/server/transport_ipc.c           |   16 +++-
 fs/smb/server/transport_tcp.c           |    4 -
 fs/smb/server/vfs_cache.c               |  128 +++++++++++++++++++++++++++-----
 fs/smb/server/vfs_cache.h               |   12 ++-
 include/uapi/linux/mshv.h               |    2 
 net/packet/af_packet.c                  |   21 +++--
 net/rxrpc/key.c                         |    4 +
 scripts/dtc/dtc-lexer.l                 |    3 
 scripts/generate_rust_analyzer.py       |   14 +++
 sound/hda/codecs/realtek/alc269.c       |    1 
 sound/usb/caiaq/device.c                |    4 -
 sound/usb/mixer.c                       |    7 +
 43 files changed, 512 insertions(+), 212 deletions(-)

Anderson Nascimento (1):
      rxrpc: Fix missing validation of ticket length in non-XDR key preparsing

Berk Cem Goksel (1):
      ALSA: caiaq: take a reference on the USB device in create_card()

Bernd Schubert (1):
      fuse: Check for large folio with SPLICE_F_MOVE

Bingquan Chen (1):
      net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()

Chao Yu (3):
      f2fs: fix to do sanity check on dcc->discard_cmd_cnt conditionally
      f2fs: fix to avoid memory leak in f2fs_rename()
      f2fs: fix to avoid uninit-value access in f2fs_sanity_check_node_footer

Cryolitia PukNgae (1):
      ALSA: usb-audio: apply quirk for MOONDROP JU Jiu

DaeMyung Kang (2):
      smb: server: fix max_connections off-by-one in tcp accept path
      ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()

Darrick J. Wong (1):
      fuse: quiet down complaints in fuse_conn_limit_write

Dudu Lu (1):
      crypto: krb5enc - fix async decrypt skipping hash verification

Eric Naim (1):
      ALSA: hda/realtek: Add quirk for Legion S7 15IMH

George Saad (1):
      f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()

Greg Kroah-Hartman (2):
      fs/ntfs3: validate rec->used in journal-replay file record check
      Linux 7.0.2

Herbert Xu (1):
      crypto: authencesn - Fix src offset when decrypting in-place

Jan Kara (1):
      writeback: Fix use after free in inode_switch_wbs_work_fn()

Michael Bommarito (7):
      ksmbd: require minimum ACE size in smb_check_perm_dacl()
      smb: server: fix active_num_conn leak on transport allocation failure
      smb: client: require a full NFS mode SID before reading mode bits
      smb: client: validate the whole DACL before rewriting it in cifsacl
      smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path
      ksmbd: validate response sizes in ipc_validate_msg()
      ksmbd: validate num_aces and harden ACE walk in smb_inherit_dacl()

Miguel Ojeda (1):
      pwm: th1520: fix `CLIPPY=1` warning

Mikhail Gavrilov (1):
      drm/amdgpu: replace PASID IDR with XArray

Miklos Szeredi (2):
      fuse: abort on fatal signal during sync init
      fuse: fuse_dev_ioctl_clone() should wait for device file to be initialized

Naman Jain (1):
      mshv_vtl: Fix vmemmap_shift exceeding MAX_FOLIO_ORDER

Namjae Jeon (2):
      ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger
      ksmbd: validate owner of durable handle on reconnect

Nathan Chancellor (1):
      scripts/dtc: Remove unused dts_version in dtc-lexer.l

Paulo Alcantara (1):
      smb: client: fix dir separator in SMB1 UNIX mounts

Samuel Page (1):
      fuse: reject oversized dirents in page cache

Sean Christopherson (3):
      crypto: ccp: Don't attempt to copy CSR to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy PDH cert to userspace if PSP command failed
      crypto: ccp: Don't attempt to copy ID to userspace if PSP command failed

Tamir Duberstein (1):
      scripts: generate_rust_analyzer.py: define scripts

Tristan Madani (2):
      ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment
      ksmbd: use check_add_overflow() to prevent u16 DACL size overflow

Wesley Atwell (1):
      crypto: krb5enc - fix sleepable flag handling in encrypt dispatch

Yongpeng Yang (1):
      f2fs: fix UAF caused by decrementing sbi->nr_pages[] in f2fs_write_end_io()


