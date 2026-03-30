Return-Path: <stable+bounces-231165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP+WJmZcymn27gUAu9opvQ
	(envelope-from <stable+bounces-231165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:20:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5CE35A1B8
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 528503065363
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9333BE15C;
	Mon, 30 Mar 2026 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a0sMKGym"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082F38642B
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868595; cv=none; b=J71Xql6s8bpUkGkgdgotMk7mVj05ImIRb1nhRTyF1OjSreDN6P4UT3ojCOSpgKvj0EiHjbnFBNPxewXLmucVE3iHwauU3GL8JtSYAkEHXa0yV45GbPVkU+7FZSkf1E/L6nOlhBPZqaM+J9c8hjyIpd6emW3PTNXAqI+5LhjuqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868595; c=relaxed/simple;
	bh=KFvQoDtWx40GjgbDF/SwyaHKNCU8gNvVPhSj93SA8vc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ewXNv2zcM0isFo9rRvlkxro++LKO2657J0pHQBcKWdzePQssZfsQXIiedeAMBOFxisa2OapMf9f3bUgCb0+hxs9pKseuI2QJMGEEqQzDygMwxw+sfvXPsepFdegZvRBL5LvQMEY553f7QnANko83cGBohC/2/CRJ6lAb4tLMBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a0sMKGym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78CBC4CEF7;
	Mon, 30 Mar 2026 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774868594;
	bh=KFvQoDtWx40GjgbDF/SwyaHKNCU8gNvVPhSj93SA8vc=;
	h=Subject:To:Cc:From:Date:From;
	b=a0sMKGymIZqTLM1fJYMfIwLf//x84HjIvn/7M1LEVbwyWqhNwiK9/fM/r3DHP90wd
	 HtjIdF2o/TJ9YRtjnYsWzZrTTBCH0QJvNsTNYQeobtTFiyUq1DrYo178Pg5YoQ9cSE
	 hC1fAeJTFSqggjCtvR+U3lYcqglcGZfmVAKR+jks=
Subject: FAILED: patch "[PATCH] ext4: publish jinode after initialization" failed to apply to 5.15-stable tree
To: me@linux.beauty,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 13:03:04 +0200
Message-ID: <2026033004-latitude-reverend-7a4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231165-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:email,linuxfoundation.org:dkim,gregkh:email,linux.beauty:email]
X-Rspamd-Queue-Id: 8F5CE35A1B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1aec30021edd410b986c156f195f3d23959a9d11
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033004-latitude-reverend-7a4e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1aec30021edd410b986c156f195f3d23959a9d11 Mon Sep 17 00:00:00 2001
From: Li Chen <me@linux.beauty>
Date: Wed, 25 Feb 2026 16:26:16 +0800
Subject: [PATCH] ext4: publish jinode after initialization

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

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index f575751f1cae..6e949c21842d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -975,13 +975,13 @@ static int ext4_fc_flush_data(journal_t *journal)
 	int ret = 0;
 
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ret = jbd2_submit_inode_data(journal, ei->jinode);
+		ret = jbd2_submit_inode_data(journal, READ_ONCE(ei->jinode));
 		if (ret)
 			return ret;
 	}
 
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ret = jbd2_wait_inode_data(journal, ei->jinode);
+		ret = jbd2_wait_inode_data(journal, READ_ONCE(ei->jinode));
 		if (ret)
 			return ret;
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 252191632f56..ac5f3446c731 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -128,6 +128,8 @@ void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
 static inline int ext4_begin_ordered_truncate(struct inode *inode,
 					      loff_t new_size)
 {
+	struct jbd2_inode *jinode = READ_ONCE(EXT4_I(inode)->jinode);
+
 	trace_ext4_begin_ordered_truncate(inode, new_size);
 	/*
 	 * If jinode is zero, then we never opened the file for
@@ -135,10 +137,10 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
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
 
@@ -4451,8 +4453,13 @@ int ext4_inode_attach_jinode(struct inode *inode)
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


