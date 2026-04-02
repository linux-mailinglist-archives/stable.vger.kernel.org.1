Return-Path: <stable+bounces-233085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEZNMlarzml+pQYAu9opvQ
	(envelope-from <stable+bounces-233085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:45:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D138CB45
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B47430106A8
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6EF35958;
	Thu,  2 Apr 2026 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbrN3mx9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A62287503
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151686; cv=none; b=pnURkFgHr5DB9QzjU0fba1cuYPjSwE/MlG9WTMVWfeWjIm6Y8zHKqS9cBkHYfXhxWTt5NdRzI6e5m+ktqqc2MLIzsGKMGfm458lqpALDwgiTfB3c/iJWfzyAuZg50CSt6ix61ET2Mj7P8Whq3gSME/uJntzexqcXFaRmJCSJc00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151686; c=relaxed/simple;
	bh=ZZhdHv0MmEzSdzWg0Q/lJVDmqXY1mFdj3IZxyTfF/y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5fvyDGImU34pA5e+XunAC8keYHnxsHwH1YHOBBa7ORdTbKFYfkbTgw4OseijHohxnvzw60Z0E2m+KDEnbSeBuZvV1za6wFQW7QvLqnwSHAAIoa50CkGWoXhXnkzfQRskAt9AClot1BMrLebv3wTBsWXPY/ccfMHFpnkcZBGNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbrN3mx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156ABC116C6;
	Thu,  2 Apr 2026 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151685;
	bh=ZZhdHv0MmEzSdzWg0Q/lJVDmqXY1mFdj3IZxyTfF/y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbrN3mx9QNuCelDh0sl0ie4JHU6qq0SU0VXYSZ/0ieE7UlNMnIDG4tP/QrGVNldD9
	 iMbR4F2x0Cx9NT3dwak1VRJE6G4IdUdirsnjq7A9qncLb4plX+dirC7JqUHoxT2aAI
	 k1IrCshxpLtX5FhH6GJ9dfn9EV8m/7efIm1EodvT2TJ+z6xPyWYVf+zTxpYvYkp9NS
	 d1nkzvgIBhSXyLwE/14yXOtLs/hvMp1oCzCm5YFogRpaIL+mR4DMAXxCUwxwBz79Ng
	 UGDjPhqfnOmAsnhRGMl6CdMw5+XqQm6XVXaGqTE+bEP5d1PDh6xJ86hiMEzhgE5irz
	 VQp8Z22Bv+oIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ext4: publish jinode after initialization
Date: Thu,  2 Apr 2026 13:41:23 -0400
Message-ID: <20260402174123.1572392-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033003-overstep-steep-7800@gregkh>
References: <2026033003-overstep-steep-7800@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233085-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:email,suse.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: C44D138CB45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li Chen <me@linux.beauty>

[ Upstream commit 1aec30021edd410b986c156f195f3d23959a9d11 ]

ext4_inode_attach_jinode() publishes ei->jinode to concurrent users.
It used to set ei->jinode before jbd2_journal_init_jbd_inode(),
allowing a reader to observe a non-NULL jinode with i_vfs_inode
still unset.

The fast commit flush path can then pass this jinode to
jbd2_wait_inode_data(), which dereferences i_vfs_inode->i_mapping and
may crash.

Below is the crash I observe:
```
BUG: unable to handle page fault for address: 000000010beb47f4
PGD 110e51067 P4D 110e51067 PUD 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 1 UID: 0 PID: 4850 Comm: fc_fsync_bench_ Not tainted 6.18.0-00764-g795a690c06a5 #1 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
RIP: 0010:xas_find_marked+0x3d/0x2e0
Code: e0 03 48 83 f8 02 0f 84 f0 01 00 00 48 8b 47 08 48 89 c3 48 39 c6 0f 82 fd 01 00 00 48 85 c9 74 3d 48 83 f9 03 77 63 4c 8b 0f <49> 8b 71 08 48 c7 47 18 00 00 00 00 48 89 f1 83 e1 03 48 83 f9 02
RSP: 0018:ffffbbee806e7bf0 EFLAGS: 00010246
RAX: 000000000010beb4 RBX: 000000000010beb4 RCX: 0000000000000003
RDX: 0000000000000001 RSI: 0000002000300000 RDI: ffffbbee806e7c10
RBP: 0000000000000001 R08: 0000002000300000 R09: 000000010beb47ec
R10: ffff9ea494590090 R11: 0000000000000000 R12: 0000002000300000
R13: ffffbbee806e7c90 R14: ffff9ea494513788 R15: ffffbbee806e7c88
FS: 00007fc2f9e3e6c0(0000) GS:ffff9ea6b1444000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010beb47f4 CR3: 0000000119ac5000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
<TASK>
filemap_get_folios_tag+0x87/0x2a0
__filemap_fdatawait_range+0x5f/0xd0
? srso_alias_return_thunk+0x5/0xfbef5
? __schedule+0x3e7/0x10c0
? srso_alias_return_thunk+0x5/0xfbef5
? srso_alias_return_thunk+0x5/0xfbef5
? srso_alias_return_thunk+0x5/0xfbef5
? preempt_count_sub+0x5f/0x80
? srso_alias_return_thunk+0x5/0xfbef5
? cap_safe_nice+0x37/0x70
? srso_alias_return_thunk+0x5/0xfbef5
? preempt_count_sub+0x5f/0x80
? srso_alias_return_thunk+0x5/0xfbef5
filemap_fdatawait_range_keep_errors+0x12/0x40
ext4_fc_commit+0x697/0x8b0
? ext4_file_write_iter+0x64b/0x950
? srso_alias_return_thunk+0x5/0xfbef5
? preempt_count_sub+0x5f/0x80
? srso_alias_return_thunk+0x5/0xfbef5
? vfs_write+0x356/0x480
? srso_alias_return_thunk+0x5/0xfbef5
? preempt_count_sub+0x5f/0x80
ext4_sync_file+0xf7/0x370
do_fsync+0x3b/0x80
? syscall_trace_enter+0x108/0x1d0
__x64_sys_fdatasync+0x16/0x20
do_syscall_64+0x62/0x2c0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
...
```

Fix this by initializing the jbd2_inode first.
Use smp_wmb() and WRITE_ONCE() to publish ei->jinode after
initialization. Readers use READ_ONCE() to fetch the pointer.

Fixes: a361293f5fede ("jbd2: Fix oops in jbd2_journal_file_inode()")
Cc: stable@vger.kernel.org
Signed-off-by: Li Chen <me@linux.beauty>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260225082617.147957-1-me@linux.beauty
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[ adapted READ_ONCE(jinode) wrapping to split ext4_fc_submit_inode_data_all() and ext4_fc_wait_inode_data_all() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/fast_commit.c |  4 ++--
 fs/ext4/inode.c       | 15 +++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 83a0a78a124a1..5038a74c74a52 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1019,7 +1019,7 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 			finish_wait(&ei->i_fc_wait, &wait);
 		}
 		spin_unlock(&sbi->s_fc_lock);
-		ret = jbd2_submit_inode_data(ei->jinode);
+		ret = jbd2_submit_inode_data(READ_ONCE(ei->jinode));
 		if (ret)
 			return ret;
 		spin_lock(&sbi->s_fc_lock);
@@ -1044,7 +1044,7 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
 			continue;
 		spin_unlock(&sbi->s_fc_lock);
 
-		ret = jbd2_wait_inode_data(journal, pos->jinode);
+		ret = jbd2_wait_inode_data(journal, READ_ONCE(pos->jinode));
 		if (ret)
 			return ret;
 		spin_lock(&sbi->s_fc_lock);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 79619f3db984f..f843f1b267fa8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -122,6 +122,8 @@ void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
 static inline int ext4_begin_ordered_truncate(struct inode *inode,
 					      loff_t new_size)
 {
+	struct jbd2_inode *jinode = READ_ONCE(EXT4_I(inode)->jinode);
+
 	trace_ext4_begin_ordered_truncate(inode, new_size);
 	/*
 	 * If jinode is zero, then we never opened the file for
@@ -129,10 +131,10 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 	 * jbd2_journal_begin_ordered_truncate() since there's no
 	 * outstanding writes we need to flush.
 	 */
-	if (!EXT4_I(inode)->jinode)
+	if (!jinode)
 		return 0;
 	return jbd2_journal_begin_ordered_truncate(EXT4_JOURNAL(inode),
-						   EXT4_I(inode)->jinode,
+						   jinode,
 						   new_size);
 }
 
@@ -4180,8 +4182,13 @@ int ext4_inode_attach_jinode(struct inode *inode)
 			spin_unlock(&inode->i_lock);
 			return -ENOMEM;
 		}
-		ei->jinode = jinode;
-		jbd2_journal_init_jbd_inode(ei->jinode, inode);
+		jbd2_journal_init_jbd_inode(jinode, inode);
+		/*
+		 * Publish ->jinode only after it is fully initialized so that
+		 * readers never observe a partially initialized jbd2_inode.
+		 */
+		smp_wmb();
+		WRITE_ONCE(ei->jinode, jinode);
 		jinode = NULL;
 	}
 	spin_unlock(&inode->i_lock);
-- 
2.53.0


