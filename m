Return-Path: <stable+bounces-81872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF99949DE
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BFC2830F0
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B3D1DE3A3;
	Tue,  8 Oct 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iAHWqbsq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB7190663;
	Tue,  8 Oct 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390419; cv=none; b=SBGuPNbdSJKGxkd6HPFuadV6DVPD8lrj1CPHrEe2oI9DPN6vtM7aRG42PX6yPeBmG0ASihHEOn3K5mxCaGepvr3E/cHFHRM/8HHtQzxXy1F9xBdplJKbJb1h9nkP76tkAzdAZ8rpLR+4LSrH7dKavaJAeTVYMYbqZvZkZaGBL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390419; c=relaxed/simple;
	bh=O1Zn2XE4zQa6LD9NtTpvIOMdGGS0G95dRwqx+BFEoWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChhDY1WB/GafVior5sVvwudiKZNwEutl8a4cS5nl3iMjiNLUYLCLTN+IDp97q8DCkSTdIIdNYkeIFxxr7CZogjJhA64svIfc1JalAJQQqi+NEy12zA8vy+ogR2fster6QM+EVRa46A1PTnQM8ZdWxuYsdLKMd+slxJ9jFevW+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iAHWqbsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289FCC4CECD;
	Tue,  8 Oct 2024 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390419;
	bh=O1Zn2XE4zQa6LD9NtTpvIOMdGGS0G95dRwqx+BFEoWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iAHWqbsqMLNqxjzN2pq4i5R8P6Ju3ScpPGyQc9iCD5YLeGAD45xqowuRqQejVi/vy
	 R0QFCTCOgk+nOOMZ9VLNSEcvYkJT8uMjjb+xJtraeRGtlmCtgfjDHm+vRRE/14zOce
	 km9/AsU4eruN+oQlH/ZlxQFge8EcMQdanp9LmhLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 283/482] f2fs: make BG GC more aggressive for zoned devices
Date: Tue,  8 Oct 2024 14:05:46 +0200
Message-ID: <20241008115659.416796755@linuxfoundation.org>
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

[ Upstream commit 5062b5bed4323275f2f89bc185c6a28d62cfcfd5 ]

Since we don't have any GC on device side for zoned devices, need more
aggressive BG GC. So, tune the parameters for that.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 5cc69a27abfa ("f2fs: forcibly migrate to secure space for zoned device file pinning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  | 20 ++++++++++++++++++--
 fs/f2fs/gc.c    | 25 +++++++++++++++++++++----
 fs/f2fs/gc.h    | 21 +++++++++++++++++++++
 fs/f2fs/super.c |  5 +++++
 4 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 140f82886837a..6fd5fc486a703 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2870,13 +2870,26 @@ static inline bool is_inflight_io(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
+static inline bool is_inflight_read_io(struct f2fs_sb_info *sbi)
+{
+	return get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_DIO_READ);
+}
+
 static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
+	bool zoned_gc = (type == GC_TIME &&
+			F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_BLKZONED));
+
 	if (sbi->gc_mode == GC_URGENT_HIGH)
 		return true;
 
-	if (is_inflight_io(sbi, type))
-		return false;
+	if (zoned_gc) {
+		if (is_inflight_read_io(sbi))
+			return false;
+	} else {
+		if (is_inflight_io(sbi, type))
+			return false;
+	}
 
 	if (sbi->gc_mode == GC_URGENT_MID)
 		return true;
@@ -2885,6 +2898,9 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 			(type == DISCARD_TIME || type == GC_TIME))
 		return true;
 
+	if (zoned_gc)
+		return true;
+
 	return f2fs_time_over(sbi, type);
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 448c75e80b89e..7f61d6915e767 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -116,7 +116,17 @@ static int gc_thread_func(void *data)
 			goto next;
 		}
 
-		if (has_enough_invalid_blocks(sbi))
+		if (f2fs_sb_has_blkzoned(sbi)) {
+			if (has_enough_free_blocks(sbi, LIMIT_NO_ZONED_GC)) {
+				wait_ms = gc_th->no_gc_sleep_time;
+				f2fs_up_write(&sbi->gc_lock);
+				goto next;
+			}
+			if (wait_ms == gc_th->no_gc_sleep_time)
+				wait_ms = gc_th->max_sleep_time;
+		}
+
+		if (need_to_boost_gc(sbi))
 			decrease_sleep_time(gc_th, &wait_ms);
 		else
 			increase_sleep_time(gc_th, &wait_ms);
@@ -179,9 +189,16 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
-	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
-	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
-	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+
+	if (f2fs_sb_has_blkzoned(sbi)) {
+		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
+		gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME_ZONED;
+		gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME_ZONED;
+	} else {
+		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
+		gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
+		gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+	}
 
 	gc_th->gc_wake = false;
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index a8ea3301b815a..55c4ba73362ef 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -15,6 +15,11 @@
 #define DEF_GC_THREAD_MAX_SLEEP_TIME	60000
 #define DEF_GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
 
+/* GC sleep parameters for zoned deivces */
+#define DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED	10
+#define DEF_GC_THREAD_MAX_SLEEP_TIME_ZONED	20
+#define DEF_GC_THREAD_NOGC_SLEEP_TIME_ZONED	60000
+
 /* choose candidates from sections which has age of more than 7 days */
 #define DEF_GC_THREAD_AGE_THRESHOLD		(60 * 60 * 24 * 7)
 #define DEF_GC_THREAD_CANDIDATE_RATIO		20	/* select 20% oldest sections as candidates */
@@ -25,6 +30,9 @@
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
+#define LIMIT_NO_ZONED_GC	60 /* percentage over total user space of no gc for zoned devices */
+#define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
+
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
 
@@ -152,6 +160,12 @@ static inline void decrease_sleep_time(struct f2fs_gc_kthread *gc_th,
 		*wait -= min_time;
 }
 
+static inline bool has_enough_free_blocks(struct f2fs_sb_info *sbi,
+						unsigned int limit_perc)
+{
+	return free_sections(sbi) > ((sbi->total_sections * limit_perc) / 100);
+}
+
 static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 {
 	block_t user_block_count = sbi->user_block_count;
@@ -167,3 +181,10 @@ static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 		free_user_blocks(sbi) <
 			limit_free_user_blocks(invalid_user_blocks));
 }
+
+static inline bool need_to_boost_gc(struct f2fs_sb_info *sbi)
+{
+	if (f2fs_sb_has_blkzoned(sbi))
+		return !has_enough_free_blocks(sbi, LIMIT_BOOST_ZONED_GC);
+	return has_enough_invalid_blocks(sbi);
+}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f7eeea30278ea..1a1b87c4c803f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -711,6 +711,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (!strcmp(name, "on")) {
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 			} else if (!strcmp(name, "off")) {
+				if (f2fs_sb_has_blkzoned(sbi)) {
+					f2fs_warn(sbi, "zoned devices need bggc");
+					kfree(name);
+					return -EINVAL;
+				}
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_OFF;
 			} else if (!strcmp(name, "sync")) {
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_SYNC;
-- 
2.43.0




