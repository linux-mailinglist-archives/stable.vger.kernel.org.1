Return-Path: <stable+bounces-240661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMEWCBZw62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:28:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA75F45F03F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45AD0300E73E
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8453D6CA7;
	Fri, 24 Apr 2026 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufys7BLP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B43D6697
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037314; cv=none; b=ns75SI8o7PA5zQBRSCNhiSFfZ29fsVg8IrX2WZzv9wxSiIYVuVOiWtvRbN52d9T7fFmyCWBix95YiIewBHDH/nTJKp1CfKz2cHFMATcBZPAmgtGNXRhAPyr8mfA0uQN0iOI/9/rGOaK5doUwgEiOPijE5v9814g5g5ve+GBcio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037314; c=relaxed/simple;
	bh=oA4HfN/+8seod3AJHIMjL5SbyCpI49/zvsMl2uum1z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxIMAiYvoNVvvr+18FuxgqKsbB9UTDgnb7KzBEduaX1jIzxZARcxceEd6Z/DLc7+i84OBftt1LjvVVLkm8GwrQuNv2mpL22uZuvaAPvvIxee4lOE8bc0S6rMEK2WaQdUNeutI7L5I98/69cscmSBZnq0iIHZQzRW1KywuOlOZR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufys7BLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F101DC19425;
	Fri, 24 Apr 2026 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777037313;
	bh=oA4HfN/+8seod3AJHIMjL5SbyCpI49/zvsMl2uum1z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ufys7BLP6GYIaNvbzg8ebAlo9x76W4ELWsCvkmX/WGkkjG+0aR97eSjTs708unOZh
	 NmthSF0IHuKd4pcm9iXz+qUW0IUj9NN7In9DqH7zDVqS+PRbdhhTE7mUtwECayAAMh
	 EoAZrNaknV4Fj0qAvu7+gG7hrXUkSVlD2oCjyBKWTL2VyOJZYx78LbVrblLjfgUK5C
	 g+rZGShcAIIUT+ooV+kAi8zrjnJUYe/5e6kB9qJQZp4jN5GoOkZ/Xw5uXod+vObBMQ
	 3+Wrt/BhVktjQm5HZJEoD4PCTk51wsDwUNmgqsXW/c2YnygQ7jUzANtyLO7nga3qK/
	 ZqHiYAdJQJvNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	syzbot+62538b67389ee582837a@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix to do sanity check on dcc->discard_cmd_cnt conditionally
Date: Fri, 24 Apr 2026 09:28:31 -0400
Message-ID: <20260424132831.1946653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042414-venue-sepia-a14e@gregkh>
References: <2026042414-venue-sepia-a14e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA75F45F03F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240661-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RBL_SEM_FAIL(0.00)[172.234.253.10:query timed out];
	TAGGED_RCPT(0.00)[stable,62538b67389ee582837a];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]

From: Chao Yu <chao@kernel.org>

[ Upstream commit 6af249c996f7d73a3435f9e577956fa259347d18 ]

Syzbot reported a f2fs bug as below:

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:1900!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6527 Comm: syz.5.110 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:f2fs_issue_discard_timeout+0x59b/0x5a0 fs/f2fs/segment.c:1900
Code: d9 80 e1 07 80 c1 03 38 c1 0f 8c d6 fe ff ff 48 89 df e8 a8 5e fa fd e9 c9 fe ff ff e8 4e 46 94 fd 90 0f 0b e8 46 46 94 fd 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc9000494f940 EFLAGS: 00010283
RAX: ffffffff843009ca RBX: 0000000000000001 RCX: 0000000000080000
RDX: ffffc9001ca78000 RSI: 00000000000029f3 RDI: 00000000000029f4
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100893a431 R12: 1ffff1100893a430
R13: 1ffff1100c2b702c R14: dffffc0000000000 R15: ffff8880449d2160
FS:  00007ffa35fed6c0(0000) GS:ffff88812643d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2b68634000 CR3: 0000000039f62000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __f2fs_remount fs/f2fs/super.c:2960 [inline]
 f2fs_reconfigure+0x108a/0x1710 fs/f2fs/super.c:5443
 reconfigure_super+0x227/0x8a0 fs/super.c:1080
 do_remount fs/namespace.c:3391 [inline]
 path_mount+0xdc5/0x10e0 fs/namespace.c:4151
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4338
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffa37dbda0a

The root cause is there will be race condition in between f2fs_ioc_fitrim()
and f2fs_remount():

- f2fs_remount			- f2fs_ioc_fitrim
 - f2fs_issue_discard_timeout
  - __issue_discard_cmd
  - __drop_discard_cmd
  - __wait_all_discard_cmd
				 - f2fs_trim_fs
				  - f2fs_write_checkpoint
				   - f2fs_clear_prefree_segments
				    - f2fs_issue_discard
				     - __issue_discard_async
				      - __queue_discard_cmd
				       - __update_discard_tree_range
				        - __insert_discard_cmd
				         - __create_discard_cmd
				         : atomic_inc(&dcc->discard_cmd_cnt);
  - sanity check on dcc->discard_cmd_cnt (expect discard_cmd_cnt to be zero)

This will only happen when fitrim races w/ remount rw, if we remount to
readonly filesystem, remount will wait until mnt_pcp.mnt_writers to zero,
that means fitrim is not in process at that time.

Cc: stable@kernel.org
Fixes: 2482c4325dfe ("f2fs: detect bug_on in f2fs_wait_discard_bios")
Reported-by: syzbot+62538b67389ee582837a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/69b07d7c.050a0220.8df7.09a1.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Different function signatures ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/segment.c | 6 +++---
 fs/f2fs/super.c   | 9 +++++++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 31968257ad8e2..76841a30d16e1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3467,7 +3467,7 @@ bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
-bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
 void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0b284a28afeda..52d5915cee967 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1741,7 +1741,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 }
 
 /* This comes from f2fs_put_super */
-bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_policy dpolicy;
@@ -1755,7 +1755,7 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 	/* just to make sure there is no pending discard commands */
 	__wait_all_discard_cmd(sbi, NULL);
 
-	f2fs_bug_on(sbi, atomic_read(&dcc->discard_cmd_cnt));
+	f2fs_bug_on(sbi, need_check && atomic_read(&dcc->discard_cmd_cnt));
 	return dropped;
 }
 
@@ -2197,7 +2197,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 	 * fill_super(), it needs to give a chance to handle them.
 	 */
 	if (unlikely(atomic_read(&dcc->discard_cmd_cnt)))
-		f2fs_issue_discard_timeout(sbi);
+		f2fs_issue_discard_timeout(sbi, true);
 
 	kfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6f6368400ee46..76f5602735d7f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1600,7 +1600,7 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 
 	/* be sure to wait for any on-going discard commands */
-	dropped = f2fs_issue_discard_timeout(sbi);
+	dropped = f2fs_issue_discard_timeout(sbi, true);
 
 	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
 					!sbi->discard_blks && !dropped) {
@@ -2409,8 +2409,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		} else {
 			dcc = SM_I(sbi)->dcc_info;
 			f2fs_stop_discard_thread(sbi);
+			/*
+			 * f2fs_ioc_fitrim() won't race w/ "remount ro"
+			 * so it's safe to check discard_cmd_cnt in
+			 * f2fs_issue_discard_timeout().
+			 */
 			if (atomic_read(&dcc->discard_cmd_cnt))
-				f2fs_issue_discard_timeout(sbi);
+				f2fs_issue_discard_timeout(sbi, *flags & SB_RDONLY);
 			need_restart_discard = true;
 		}
 	}
-- 
2.53.0


