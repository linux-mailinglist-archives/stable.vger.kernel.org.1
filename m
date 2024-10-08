Return-Path: <stable+bounces-81876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA59949E4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87901F21A5B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB811DF73B;
	Tue,  8 Oct 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mcnKgnTP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124381DF27B;
	Tue,  8 Oct 2024 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390433; cv=none; b=ugV8gqW+9Qh5wFe+nMo7I+XA8yb0Cy9eWK9O+h7Odw4e4Eig+gn11CgBTOaj7wLNfTrebMYMa9WRuVL5AY/l74es5bIbhKiKjqOXxV4Xa5b4L5KrKU/fn6EVitWx5WfhNjOfz71LMMm84b4pskoh1H2kZv5EEO+/v+DHm04RaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390433; c=relaxed/simple;
	bh=QRBm0XRvrYVyM9akzotM+FNpeewsC1p9Z66BXI2pngo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luJ8IKTlZmGb5RqB8eAC+iEENNs9YEVkdC8WTkcXy0URPgm1CX/r7iOOHJnaa/rKPuuoHU3iwkGVVtQkValM7g2LSwdmMTmS8X8Ot1Vr5lfbPh1Nh7nrMlX8S6JGAFMROWrlscBxeiKCetjqNO2TODypo0sDjnDWnKy+Sah7rD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mcnKgnTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5A2C4CECC;
	Tue,  8 Oct 2024 12:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390433;
	bh=QRBm0XRvrYVyM9akzotM+FNpeewsC1p9Z66BXI2pngo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcnKgnTP/9n6xBPXw6uWvE9ieVetaJFZ9m3MQTYWkZJGKox77EES/zR3iMJiMLmhw
	 mvRcLNX342YX4J2R+Rz/1JLr2AGjwCAzuDu26rRZ0XMkKD47itX3N9H2Ie87cyDDo0
	 o908/Ppqc7ui4Kbu2Hqja9Xr2pdWOGScfGCMohiU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 286/482] f2fs: do FG_GC when GC boosting is required for zoned devices
Date: Tue,  8 Oct 2024 14:05:49 +0200
Message-ID: <20241008115659.533926468@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 9748c2ddea4a3f46a498bff4cf2bf9a5629e3f8b ]

Under low free section count, we need to use FG_GC instead of BG_GC to
recover free sections.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 5cc69a27abfa ("f2fs: forcibly migrate to secure space for zoned device file pinning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/gc.c   | 24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9796ad64727a6..549361ee48503 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1301,6 +1301,7 @@ struct f2fs_gc_control {
 	bool no_bg_gc;			/* check the space and stop bg_gc */
 	bool should_migrate_blocks;	/* should migrate blocks */
 	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
+	bool one_time;			/* require one time GC in one migration unit */
 	unsigned int nr_free_secs;	/* # of free sections to do GC */
 };
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e59a87dc5130b..2fbac9965dc3f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -81,6 +81,8 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
+		gc_control.one_time = false;
+
 		/*
 		 * [GC triggering condition]
 		 * 0. GC is not conducted currently.
@@ -126,15 +128,19 @@ static int gc_thread_func(void *data)
 				wait_ms = gc_th->max_sleep_time;
 		}
 
-		if (need_to_boost_gc(sbi))
+		if (need_to_boost_gc(sbi)) {
 			decrease_sleep_time(gc_th, &wait_ms);
-		else
+			if (f2fs_sb_has_blkzoned(sbi))
+				gc_control.one_time = true;
+		} else {
 			increase_sleep_time(gc_th, &wait_ms);
+		}
 do_gc:
 		stat_inc_gc_call_count(sbi, foreground ?
 					FOREGROUND : BACKGROUND);
 
-		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
+		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
+				gc_control.one_time;
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground)
@@ -1701,7 +1707,7 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				unsigned int start_segno,
 				struct gc_inode_list *gc_list, int gc_type,
-				bool force_migrate)
+				bool force_migrate, bool one_time)
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
@@ -1728,7 +1734,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			sec_end_segno -= SEGS_PER_SEC(sbi) -
 					f2fs_usable_segs_in_sec(sbi, segno);
 
-		if (gc_type == BG_GC) {
+		if (gc_type == BG_GC || one_time) {
 			unsigned int window_granularity =
 				sbi->migration_window_granularity;
 
@@ -1912,7 +1918,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	}
 
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type,
-				gc_control->should_migrate_blocks);
+				gc_control->should_migrate_blocks,
+				gc_control->one_time);
 	if (seg_freed < 0)
 		goto stop;
 
@@ -1923,6 +1930,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		total_sec_freed++;
 	}
 
+	if (gc_control->one_time)
+		goto stop;
+
 	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
 
@@ -2048,7 +2058,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		};
 
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
-						dry_run_sections == 0);
+						dry_run_sections == 0, false);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
-- 
2.43.0




