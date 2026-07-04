Return-Path: <stable+bounces-271971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y3jiCiIESWqLxgAAu9opvQ
	(envelope-from <stable+bounces-271971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 15:01:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C3707AE0
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 15:01:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TzD+MM26;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271971-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271971-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CD4330055F6
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 13:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ACB3A7F5F;
	Sat,  4 Jul 2026 13:01:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530F3AA1A9
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 13:01:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783170077; cv=none; b=ZHwMeVgme7fJc2YcGB//97Q0WlE0QTZzICVKwz6Lq95vXKJwE3aB6pEa2ytl2FmqTXFdA8Ec0a6wnC7lmu55z1imVtzyhMYGHWSURT7NtalnAL0zwInx4FFq36sZd7wFxejG6TGMRfCTH9EVNZeC+UBYfvrIAMpnRb+Q7Yqljvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783170077; c=relaxed/simple;
	bh=watRZl/hkO4QQvBiV4e/bLbVovvNqMKu6lcW/a3bQqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEBKm1eM7vewpuZ+oR9vv7iDuKTYCDPXWBoHdvvGp6+GptgwqxHYyIqptOCelgDgTM29Uh1geEnF+VkHBKa1rFG0Cv00aHY2RR+14lctyyHNmlsyDF2tz7uVYGmrsZxWuAy0uFk6IjpqJcwAuV0P1yzVFvybo4soWrhrnAXlBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzD+MM26; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149C41F00A3F;
	Sat,  4 Jul 2026 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783170071;
	bh=fO34cxJTQ9iQih5/8poOVxu/1SEfyUKEUWs+RCthiNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TzD+MM26m5LK9CwG/5V+96I3TWQuDZe0lQqyCmMZXqM8mTIq1L0037XMvQZIxEX9B
	 FB3+joXDTBfv/a5J+AKjZyahKElCkMyYyrZhlfe4r2S08exKJBKnqRhzRg++9nEIJa
	 x2CX5Z4oOJqnSGTxYa7wb0tbfZq9V/ZlCrsLAcY5UKJlGtOPGzH4kG/ts80CaPBRxV
	 FWGjfxj7DwLlsVUHCUucG15kC2D7N/EMdJI1VKiFcMcOawJJy6NQCgxZorlnyzSbMn
	 ORAoMc1mAoGFhdYBXc+Y+PZgnKC44Zi0T29rDC/yHGrBERiP+KioH3xQ6KXniXFYNM
	 Xms0vjEllLrSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	syzbot+2488d8d751b27f7ce268@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] f2fs: fix to do sanity check on f2fs_get_node_folio_ra()
Date: Sat,  4 Jul 2026 09:01:06 -0400
Message-ID: <20260704130106.828918-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260704130106.828918-1-sashal@kernel.org>
References: <2026070234-outdated-refutable-f834@gregkh>
 <20260704130106.828918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271971-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:chao@kernel.org,m:stable@kernel.org,m:syzbot+2488d8d751b27f7ce268@syzkaller.appspotmail.com,m:jaegeuk@kernel.org,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,2488d8d751b27f7ce268];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 256C3707AE0

From: Chao Yu <chao@kernel.org>

[ Upstream commit 8712353ed80f87271d732297567dcdbe4b84e8c7 ]

kernel BUG at fs/f2fs/file.c:845!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:f2fs_do_truncate_blocks+0x1115/0x1140 fs/f2fs/file.c:845
Code: fc fc 90 0f 0b e8 8b 9d 9a fd 90 0f 0b e8 83 9d 9a fd 48 89 df 48 c7 c6 60 d1 1a 8c e8 54 f1 fc fc 90 0f 0b e8 6c 9d 9a fd 90 <0f> 0b e8 64 9d 9a fd 90 0f 0b 90 e9 93 fd ff ff e8 56 9d 9a fd 90
RSP: 0018:ffffc9000e4474c0 EFLAGS: 00010283
RAX: ffffffff842b1d34 RBX: 0000000000000003 RCX: 0000000000100000
RDX: ffffc9000f03a000 RSI: 0000000000035503 RDI: 0000000000035504
RBP: ffffc9000e447608 R08: ffff8880123b0000 R09: 0000000000000002
R10: 00000000fffffffe R11: 0000000000000002 R12: 0000000000000001
R13: 0000000000000000 R14: 1ffff92001c88ea0 R15: 00000000ffff039c
FS:  00007f7e02ee36c0(0000) GS:ffff88808c887000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff0305c4000 CR3: 0000000012d4c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 f2fs_truncate_blocks+0x10a/0x300 fs/f2fs/file.c:882
 f2fs_truncate+0x471/0x7c0 fs/f2fs/file.c:940
 f2fs_evict_inode+0xa3f/0x1ac0 fs/f2fs/inode.c:907
 evict+0x61e/0xb10 fs/inode.c:841
 f2fs_fill_super+0x5f43/0x78f0 fs/f2fs/super.c:5224
 get_tree_bdev_flags+0x431/0x4f0 fs/super.c:1694
 vfs_get_tree+0x92/0x2a0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3758 [inline]
 do_new_mount+0x341/0xd30 fs/namespace.c:3834
 do_mount fs/namespace.c:4167 [inline]
 __do_sys_mount fs/namespace.c:4383 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4360
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

	count = ADDRS_PER_PAGE(dn.node_folio, inode);

	count -= dn.ofs_in_node;
	f2fs_bug_on(sbi, count < 0);

The fuzz test will trigger above bug_on in f2fs.

The root cause should be: in the corrupted inode, there is a direct node
which has the same ino and nid in its footer, so in f2fs_do_truncate_blocks(),
after f2fs_get_dnode_of_data() finds such dnode:
1) ADDRS_PER_PAGE(dn.node_folio, inode) will return 923
2) once dn.ofs_in_node points to addr[923, 1017]
Then it will trigger the system panic.

Let's introduce NODE_TYPE_NON_IXNODE to indicate current node should
not be an inode or xattr node, and then use it in below path to detect
inconsistent node chain in inode mapping table:

- f2fs_do_truncate_blocks
 - f2fs_get_dnode_of_data
  - f2fs_get_node_folio_ra
   -  __get_node_folio
    - f2fs_sanity_check_node_footer
     - case NODE_TYPE_NON_IXNODE -> check whether it is inode|xnode

Cc: stable@kernel.org
Reported-by: syzbot+2488d8d751b27f7ce268@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69fa3697.170a0220.59368.0018.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/node.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 31252fb1b06bd1..4cdef8c27ce059 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1533,6 +1533,7 @@ enum node_type {
 	NODE_TYPE_INODE,
 	NODE_TYPE_XATTR,
 	NODE_TYPE_NON_INODE,
+	NODE_TYPE_NON_IXNODE,	/* non inode and xnode */
 };
 
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index bf06c9582ae49b..16388c2941bab5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1529,6 +1529,10 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 		if (is_inode)
 			goto out_err;
 		break;
+	case NODE_TYPE_NON_IXNODE:
+		if (is_inode || is_xnode)
+			goto out_err;
+		break;
 	default:
 		break;
 	}
@@ -1622,7 +1626,7 @@ static struct folio *f2fs_get_node_folio_ra(struct folio *parent, int start)
 	struct f2fs_sb_info *sbi = F2FS_F_SB(parent);
 	nid_t nid = get_nid(parent, start, false);
 
-	return __get_node_folio(sbi, nid, parent, start, NODE_TYPE_REGULAR);
+	return __get_node_folio(sbi, nid, parent, start, NODE_TYPE_NON_IXNODE);
 }
 
 static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
-- 
2.53.0


