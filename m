Return-Path: <stable+bounces-216860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNj1K/KTlGl3FgIAu9opvQ
	(envelope-from <stable+bounces-216860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:14:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C814DF37
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C663303983C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2B036E471;
	Tue, 17 Feb 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpbqPCFZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0336E46E
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344876; cv=none; b=rtkQwqweGGvOJIBBaJQOwyJvI/jzVegGfX7pU0TqNddEuVUzuQmx4J0oymaps+MX/kva1vsjsa21Bu9fdQ01WCrx5VI58GyUNI/mi2YmncyWoy/AzTyzISpmYsjUIh77YjQIsKYpEDmxSv6inrWbWIe1OWSHWEw2yP59vuFcpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344876; c=relaxed/simple;
	bh=nHTjpKCNBlRcnmv5e189lJT741CYFZcVM90PpBCK5ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JD28Chwj5TghmGChRskulLer2Bg5VtMIUIiEg9CSfAoedZ8tQVoFzLoE33q8ccQvEZ6nPw3ee9Fyn/7aoUII6P9kEUDtkWavnDeOhUKx3GilsO/vmvRlfoaj+G2rIFwR5B4GPZRFfNd8MLffbdF+so2iT7NkVWxhb2gi6czTH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpbqPCFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37925C19424;
	Tue, 17 Feb 2026 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771344876;
	bh=nHTjpKCNBlRcnmv5e189lJT741CYFZcVM90PpBCK5ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpbqPCFZ+9NxYHs2rXzf8yu537HfrBCh38fvVO8zjFTuweXUZyz6gLrSFKnPvXUqe
	 t5VZx+c2HOhkI6aJ7aH2FMNa241i7BTznEnP3kRTLSs4h7JEZC/nP5Vtmc204O1NfC
	 Id1g8GclLWmylNY6ACuCbNAfqixofLhCUUAEK9M89F3c5TACTk3AETOSxj2OK6c0hu
	 JpdSpCWO24yeO3JlRzGGp/sIqXdyHFcRNx+Qrtod3jOP8BJba7ykmzSpGQnb2UC2Bz
	 nhK4pTbve41779PCFKUHkxzWuBdXlbyPfFEICS/njir+GIfRYMszP7H/K1OQbbtjGJ
	 pydgrnZp2isqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] Revert "f2fs: block cache/dio write during f2fs_enable_checkpoint()"
Date: Tue, 17 Feb 2026 11:14:32 -0500
Message-ID: <20260217161432.3763097-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021721-glare-regular-e385@gregkh>
References: <2026021721-glare-regular-e385@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216860-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 537C814DF37
X-Rspamd-Action: no action

From: Chao Yu <chao@kernel.org>

[ Upstream commit 3996b70209f145bfcf2afc7d05dd92c27b233b48 ]

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
[ drop tracing bits ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c  |  2 --
 fs/f2fs/f2fs.h  |  3 +--
 fs/f2fs/super.c | 38 ++++++++------------------------------
 3 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c30e69392a623..d21a3ce71dfb6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1418,7 +1418,6 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 
 static void f2fs_map_lock(struct f2fs_sb_info *sbi, int flag)
 {
-	f2fs_down_read(&sbi->cp_enable_rwsem);
 	if (flag == F2FS_GET_BLOCK_PRE_AIO)
 		f2fs_down_read(&sbi->node_change);
 	else
@@ -1431,7 +1430,6 @@ static void f2fs_map_unlock(struct f2fs_sb_info *sbi, int flag)
 		f2fs_up_read(&sbi->node_change);
 	else
 		f2fs_unlock_op(sbi);
-	f2fs_up_read(&sbi->cp_enable_rwsem);
 }
 
 int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 20edbb99b814a..8ea576eac73fb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -287,7 +287,7 @@ enum {
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
-#define DEF_ENABLE_INTERVAL		5	/* 5 secs */
+#define DEF_ENABLE_INTERVAL		16	/* 16 secs */
 #define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
 #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
 
@@ -1716,7 +1716,6 @@ struct f2fs_sb_info {
 	long interval_time[MAX_TIME];		/* to store thresholds */
 	struct ckpt_req_control cprc_info;	/* for checkpoint request control */
 	struct cp_stats cp_stats;		/* for time stat of checkpoint */
-	struct f2fs_rwsem cp_enable_rwsem;	/* block cache/dio write */
 
 	struct inode_management im[MAX_INO_ENTRY];	/* manage inode cache */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c4c225e09dc47..3fa78021a013c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2636,11 +2636,10 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 {
 	unsigned int nr_pages = get_pages(sbi, F2FS_DIRTY_DATA) / 16;
-	long long start, writeback, lock, sync_inode, end;
+	long long start, writeback, end;
 	int ret;
 
-	f2fs_info(sbi, "%s start, meta: %lld, node: %lld, data: %lld",
-					__func__,
+	f2fs_info(sbi, "f2fs_enable_checkpoint() starts, meta: %lld, node: %lld, data: %lld",
 					get_pages(sbi, F2FS_DIRTY_META),
 					get_pages(sbi, F2FS_DIRTY_NODES),
 					get_pages(sbi, F2FS_DIRTY_DATA));
@@ -2659,18 +2658,11 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
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
 
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_dirty_to_prefree(sbi);
@@ -2679,13 +2671,6 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	f2fs_up_write(&sbi->gc_lock);
 
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
@@ -2693,17 +2678,11 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
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
 
@@ -4906,7 +4885,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	init_f2fs_rwsem(&sbi->node_change);
 	spin_lock_init(&sbi->stat_lock);
 	init_f2fs_rwsem(&sbi->cp_rwsem);
-	init_f2fs_rwsem(&sbi->cp_enable_rwsem);
 	init_f2fs_rwsem(&sbi->quota_sem);
 	init_waitqueue_head(&sbi->cp_wait);
 	spin_lock_init(&sbi->error_lock);
-- 
2.51.0


