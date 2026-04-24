Return-Path: <stable+bounces-240590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK//MBc662nRJwAAu9opvQ
	(envelope-from <stable+bounces-240590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:38:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4356345C4F6
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAD673011798
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5583890F3;
	Fri, 24 Apr 2026 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d5A4QozK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A532D0F5
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023508; cv=none; b=ZUEIU8/staDhejn3FpeXnF7/JI+p/SyYjLzUXaeWU7mXlLoIK856nICzspxvP+f83Gui74i6FbHwS+iFkANaG1Eq0ZFmv+sa/vazqOcVuMv1dnvM0Y6bIZEe/HjIHxEnJw5kwfm9xL1WrPkxsXMpEIETKdMXjW2OS4CZWvUG3Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023508; c=relaxed/simple;
	bh=04wAp3GLPfXinTXeLRUCB30v7DguyakzBmJp7sMQ9jw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pi/9shOpju8A+7zNThdrTM9mjqTJBsUguZbpscDmyR4IH+uo02m50DgTBmggOD1Yv6897McG0JnKM9Tv8BVz2MUFI9Hz/aOs3dLpva50Dk95n1U29kFpke+OmXHeoPP0yPBEeWeHoVqwkrbTH53KZXuCFfQSjuTdNBnvHQrk6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d5A4QozK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E8BC19425;
	Fri, 24 Apr 2026 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023507;
	bh=04wAp3GLPfXinTXeLRUCB30v7DguyakzBmJp7sMQ9jw=;
	h=Subject:To:Cc:From:Date:From;
	b=d5A4QozKYx9CIJ8MLGJPHjxUXaVwsZfQg6DhFamViIzHlU8NGQJEuVrbPgi45fiYW
	 bOYNcmWIdMLD0O8WpQszx4en0+lroM76ikl/1t7Nd7tEFIgOIu91bYWltwIG9eqmS3
	 NOQpuZAwnklWiHSF/A/dKt/K/0uggWA6CB/bb1n0=
Subject: FAILED: patch "[PATCH] f2fs: fix to do sanity check on dcc->discard_cmd_cnt" failed to apply to 5.10-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:38:15 +0200
Message-ID: <2026042415-slept-sierra-89ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4356345C4F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240590-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6af249c996f7d73a3435f9e577956fa259347d18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042415-slept-sierra-89ce@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6af249c996f7d73a3435f9e577956fa259347d18 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Wed, 11 Mar 2026 21:35:42 +0800
Subject: [PATCH] f2fs: fix to do sanity check on dcc->discard_cmd_cnt
 conditionally

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

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 04891aaf476f..df4cdf804376 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3988,7 +3988,7 @@ bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
-bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
 void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
 void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 23faf6725632..0bf25786667f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1880,7 +1880,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
  *
  * Return true if issued all discard cmd or no discard cmd need issue, otherwise return false.
  */
-bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
+bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_policy dpolicy;
@@ -1897,7 +1897,7 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 	/* just to make sure there is no pending discard commands */
 	__wait_all_discard_cmd(sbi, NULL);
 
-	f2fs_bug_on(sbi, atomic_read(&dcc->discard_cmd_cnt));
+	f2fs_bug_on(sbi, need_check && atomic_read(&dcc->discard_cmd_cnt));
 	return !dropped;
 }
 
@@ -2367,7 +2367,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 	 * Recovery can cache discard commands, so in error path of
 	 * fill_super(), it needs to give a chance to handle them.
 	 */
-	f2fs_issue_discard_timeout(sbi);
+	f2fs_issue_discard_timeout(sbi, true);
 
 	kfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a9adb6198184..f626e5ca089d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2009,7 +2009,7 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 
 	/* be sure to wait for any on-going discard commands */
-	done = f2fs_issue_discard_timeout(sbi);
+	done = f2fs_issue_discard_timeout(sbi, true);
 	if (f2fs_realtime_discard_enable(sbi) && !sbi->discard_blks && done) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
@@ -2152,7 +2152,7 @@ static int f2fs_unfreeze(struct super_block *sb)
 	 * will recover after removal of snapshot.
 	 */
 	if (test_opt(sbi, DISCARD) && !f2fs_hw_support_discard(sbi))
-		f2fs_issue_discard_timeout(sbi);
+		f2fs_issue_discard_timeout(sbi, true);
 
 	clear_sbi_flag(F2FS_SB(sb), SBI_IS_FREEZING);
 	return 0;
@@ -2957,7 +2957,12 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 			need_stop_discard = true;
 		} else {
 			f2fs_stop_discard_thread(sbi);
-			f2fs_issue_discard_timeout(sbi);
+			/*
+			 * f2fs_ioc_fitrim() won't race w/ "remount ro"
+			 * so it's safe to check discard_cmd_cnt in
+			 * f2fs_issue_discard_timeout().
+			 */
+			f2fs_issue_discard_timeout(sbi, flags & SB_RDONLY);
 			need_restart_discard = true;
 		}
 	}


