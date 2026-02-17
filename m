Return-Path: <stable+bounces-216810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKy5JMdklGkFDgIAu9opvQ
	(envelope-from <stable+bounces-216810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:53:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F95F14C257
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F292130233C2
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC1355057;
	Tue, 17 Feb 2026 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4fzQmCx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D6355056
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332804; cv=none; b=TMygXMVfn1I8cWZ71Vqh9HFKdjsd2LJXA605LODm8TcMWG7IocnMo594FfCb95iu5wi3HX6SPLi+6U/MErLIytt9ohls8boQop49JJ1NY4IfzFibwWYFqU1jkNFZbgAeDZZg3sPuj7DkJoe/ZT//6U3lxE2FWddIPulqxQyjTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332804; c=relaxed/simple;
	bh=T3tbd0RVjUF8+oCpX9D1VIufmfoSJCqG6r3/yKNHOSg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sKyqRks+PxKlz6/POrrFgEcDc3gkjO7sWoxDG6Ga1lLM5HyDsriiy6HCEGazVslA+aP1ELmta634VJ4HqHIJ/FujTJbXoqae2nnYYpEXP7riAZNeq1cB220t8x6MeYaZxzsT9NG/T3d2rx49ULypz+ueNghENVcPGhXKNxJf+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4fzQmCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31F8C4CEF7;
	Tue, 17 Feb 2026 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771332804;
	bh=T3tbd0RVjUF8+oCpX9D1VIufmfoSJCqG6r3/yKNHOSg=;
	h=Subject:To:Cc:From:Date:From;
	b=M4fzQmCxONByu13TOBafWVF9jOHho0rp0D+TJq6ROYPsQEcomlSnK4OWhbaXqzpTL
	 LEw46G8LmJNFDHvtjtU25hVAQmrLCvxl9tfqkfxqIHM5/mBjILTsbjgNlMTJswCHqe
	 z5GYuhic5jT+D5rMirWJo9am/I3wXnArTmBGXTxk=
Subject: FAILED: patch "[PATCH] Revert "f2fs: block cache/dio write during" failed to apply to 6.19-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:53:21 +0100
Message-ID: <2026021721-glare-regular-e385@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-216810-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F95F14C257
X-Rspamd-Action: no action


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x 3996b70209f145bfcf2afc7d05dd92c27b233b48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026021721-glare-regular-e385@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3996b70209f145bfcf2afc7d05dd92c27b233b48 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Fri, 16 Jan 2026 11:38:16 +0800
Subject: [PATCH] Revert "f2fs: block cache/dio write during
 f2fs_enable_checkpoint()"

This reverts commit 196c81fdd438f7ac429d5639090a9816abb9760a.

Original patch may cause below deadlock, revert it.

write				remount
- write_begin
 - lock_page  --- lock A
 - prepare_write_begin
  - f2fs_map_lock
				- f2fs_enable_checkpoint
				 - down_write(cp_enable_rwsem)  --- lock B
				 - sync_inode_sb
				  - writepages
				   - lock_page			--- lock A
   - down_read(cp_enable_rwsem)  --- lock A

Cc: stable@kernel.org
Fixes: 196c81fdd438 ("f2fs: block cache/dio write during f2fs_enable_checkpoint()")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f32eb51ccee4..2e133a723b99 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1474,7 +1474,6 @@ static void f2fs_map_lock(struct f2fs_sb_info *sbi,
 				struct f2fs_lock_context *lc,
 				int flag)
 {
-	f2fs_down_read(&sbi->cp_enable_rwsem);
 	if (flag == F2FS_GET_BLOCK_PRE_AIO)
 		f2fs_down_read_trace(&sbi->node_change, lc);
 	else
@@ -1489,7 +1488,6 @@ static void f2fs_map_unlock(struct f2fs_sb_info *sbi,
 		f2fs_up_read_trace(&sbi->node_change, lc);
 	else
 		f2fs_unlock_op(sbi, lc);
-	f2fs_up_read(&sbi->cp_enable_rwsem);
 }
 
 int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ded41b416ed7..90aa1d53722a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -311,7 +311,7 @@ enum {
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
-#define DEF_ENABLE_INTERVAL		5	/* 5 secs */
+#define DEF_ENABLE_INTERVAL		16	/* 16 secs */
 #define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
 #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
 
@@ -1762,7 +1762,6 @@ struct f2fs_sb_info {
 	long interval_time[MAX_TIME];		/* to store thresholds */
 	struct ckpt_req_control cprc_info;	/* for checkpoint request control */
 	struct cp_stats cp_stats;		/* for time stat of checkpoint */
-	struct f2fs_rwsem cp_enable_rwsem;	/* block cache/dio write */
 
 	struct inode_management im[MAX_INO_ENTRY];	/* manage inode cache */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4573bac94793..25f796232ad9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2687,12 +2687,11 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
-	long long start, writeback, lock, sync_inode, end;
+	long long start, writeback, end;
 	int ret;
 	struct f2fs_lock_context lc;
 
-	f2fs_info(sbi, "%s start, meta: %lld, node: %lld, data: %lld",
-					__func__,
+	f2fs_info(sbi, "f2fs_enable_checkpoint() starts, meta: %lld, node: %lld, data: %lld",
 					get_pages(sbi, F2FS_DIRTY_META),
 					get_pages(sbi, F2FS_DIRTY_NODES),
 					get_pages(sbi, F2FS_DIRTY_DATA));
@@ -2711,18 +2710,11 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	}
 	writeback = ktime_get();
 
-	f2fs_down_write(&sbi->cp_enable_rwsem);
-
-	lock = ktime_get();
-
-	if (get_pages(sbi, F2FS_DIRTY_DATA))
-		sync_inodes_sb(sbi->sb);
+	sync_inodes_sb(sbi->sb);
 
 	if (unlikely(get_pages(sbi, F2FS_DIRTY_DATA)))
-		f2fs_warn(sbi, "%s: has some unwritten data: %lld",
-			__func__, get_pages(sbi, F2FS_DIRTY_DATA));
-
-	sync_inode = ktime_get();
+		f2fs_warn(sbi, "checkpoint=enable has some unwritten data: %lld",
+					get_pages(sbi, F2FS_DIRTY_DATA));
 
 	f2fs_down_write_trace(&sbi->gc_lock, &lc);
 	f2fs_dirty_to_prefree(sbi);
@@ -2731,13 +2723,6 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	f2fs_up_write_trace(&sbi->gc_lock, &lc);
 
-	f2fs_info(sbi, "%s sync_fs, meta: %lld, imeta: %lld, node: %lld, dents: %lld, qdata: %lld",
-					__func__,
-					get_pages(sbi, F2FS_DIRTY_META),
-					get_pages(sbi, F2FS_DIRTY_IMETA),
-					get_pages(sbi, F2FS_DIRTY_NODES),
-					get_pages(sbi, F2FS_DIRTY_DENTS),
-					get_pages(sbi, F2FS_DIRTY_QDATA));
 	ret = f2fs_sync_fs(sbi->sb, 1);
 	if (ret)
 		f2fs_err(sbi, "%s sync_fs failed, ret: %d", __func__, ret);
@@ -2745,17 +2730,11 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	/* Let's ensure there's no pending checkpoint anymore */
 	f2fs_flush_ckpt_thread(sbi);
 
-	f2fs_up_write(&sbi->cp_enable_rwsem);
-
 	end = ktime_get();
 
-	f2fs_info(sbi, "%s end, writeback:%llu, "
-				"lock:%llu, sync_inode:%llu, sync_fs:%llu",
-				__func__,
-				ktime_ms_delta(writeback, start),
-				ktime_ms_delta(lock, writeback),
-				ktime_ms_delta(sync_inode, lock),
-				ktime_ms_delta(end, sync_inode));
+	f2fs_info(sbi, "f2fs_enable_checkpoint() finishes, writeback:%llu, sync:%llu",
+					ktime_ms_delta(writeback, start),
+					ktime_ms_delta(end, writeback));
 	return ret;
 }
 
@@ -4952,7 +4931,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	init_f2fs_rwsem_trace(&sbi->node_change, sbi, LOCK_NAME_NODE_CHANGE);
 	spin_lock_init(&sbi->stat_lock);
 	init_f2fs_rwsem_trace(&sbi->cp_rwsem, sbi, LOCK_NAME_CP_RWSEM);
-	init_f2fs_rwsem(&sbi->cp_enable_rwsem);
 	init_f2fs_rwsem(&sbi->quota_sem);
 	init_waitqueue_head(&sbi->cp_wait);
 	spin_lock_init(&sbi->error_lock);


