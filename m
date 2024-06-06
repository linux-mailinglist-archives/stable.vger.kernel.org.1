Return-Path: <stable+bounces-49634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC198FEE36
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6011F21AA2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F71A01AF;
	Thu,  6 Jun 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j61Oxy8T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87EE1A01A6;
	Thu,  6 Jun 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683632; cv=none; b=egSpyI9zAHf5zj9NiZAi39HrF+IKIZXeXhyZk6CcsX9LQyDIm0wl3YtvsmBCVoodkymUbEYhQwwx8PvQu18jB4wD1y7ypEjv4W1C9oO1kScK6FxpYFxf5fCuYATTIegXZmUG78dYOdDhahHIjH1Kw7NZ2k6gs/RmoFhOSX+tFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683632; c=relaxed/simple;
	bh=y+BQYyJnBUhxwL0NaOPAVvFR6kGjSSwWrWZ9lXrCtlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMzKfzokIpHLe4cfUBAo2WuqAGsqYXg27m9iW9MzPbi/DjyIBsv+xHkoiUOOsaQVNM22M5fCb8tyTK/UeGa7A9fZaipDXrZpLDfVdVq14WSGInyRYBo3qIMvJk4Eg2LOMCbNSLIdcc4rPRb0fCwAHkAaCyPtKWiviNYrw8e+qiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j61Oxy8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E34C4AF0B;
	Thu,  6 Jun 2024 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683631;
	bh=y+BQYyJnBUhxwL0NaOPAVvFR6kGjSSwWrWZ9lXrCtlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j61Oxy8TlPBfk33NZbmRB59a7oqE326/SnXuTdifTybcrzydNLA0fYtvnzX9JEapF
	 8NnRnEUO97Sh7m80U8NvmEUhgdP/HsDjFzYg5RVC9VCN2tGRE0yHiZcy4fSlDN9UOb
	 bP7zjf2CdLppxzJnCI7pD4tWoqqC5vp1mjgogkIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daeho Jeong <daehojeong@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 504/744] f2fs: kill heap-based allocation
Date: Thu,  6 Jun 2024 16:02:56 +0200
Message-ID: <20240606131748.610672783@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 4e0197f9932f70cc7be8744aa0ed4dd9b5d97d85 ]

No one uses this feature. Let's kill it.

Reviewed-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: aa4074e8fec4 ("f2fs: fix block migration when section is not aligned to pow2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/f2fs.rst |  4 +--
 fs/f2fs/gc.c                       |  5 ++-
 fs/f2fs/segment.c                  | 54 ++++--------------------------
 fs/f2fs/segment.h                  | 10 ------
 fs/f2fs/super.c                    |  9 +----
 5 files changed, 11 insertions(+), 71 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index d32c6209685d6..798ca4132928c 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -126,9 +126,7 @@ norecovery		 Disable the roll-forward recovery routine, mounted read-
 discard/nodiscard	 Enable/disable real-time discard in f2fs, if discard is
 			 enabled, f2fs will issue discard/TRIM commands when a
 			 segment is cleaned.
-no_heap			 Disable heap-style segment allocation which finds free
-			 segments for data from the beginning of main area, while
-			 for node from the end of main area.
+heap/no_heap		 Deprecated.
 nouser_xattr		 Disable Extended User Attributes. Note: xattr is enabled
 			 by default if CONFIG_F2FS_FS_XATTR is selected.
 noacl			 Disable POSIX Access Control List. Note: acl is enabled
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4cf37f51339c3..2a3d64f4253ee 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -280,12 +280,11 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 			p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
 
-	/* let's select beginning hot/small space first in no_heap mode*/
+	/* let's select beginning hot/small space first. */
 	if (f2fs_need_rand_seg(sbi))
 		p->offset = get_random_u32_below(MAIN_SECS(sbi) *
 						SEGS_PER_SEC(sbi));
-	else if (test_opt(sbi, NOHEAP) &&
-		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
+	else if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
 		p->offset = 0;
 	else
 		p->offset = SIT_I(sbi)->last_victim[p->gc_mode];
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 01e9366705b25..523c3a91bdf21 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2638,16 +2638,14 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
  * This function should be returned with success, otherwise BUG
  */
 static void get_new_segment(struct f2fs_sb_info *sbi,
-			unsigned int *newseg, bool new_sec, int dir)
+			unsigned int *newseg, bool new_sec)
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int segno, secno, zoneno;
 	unsigned int total_zones = MAIN_SECS(sbi) / sbi->secs_per_zone;
 	unsigned int hint = GET_SEC_FROM_SEG(sbi, *newseg);
 	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
-	unsigned int left_start = hint;
 	bool init = true;
-	int go_left = 0;
 	int i;
 
 	spin_lock(&free_i->segmap_lock);
@@ -2661,30 +2659,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 find_other_zone:
 	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 	if (secno >= MAIN_SECS(sbi)) {
-		if (dir == ALLOC_RIGHT) {
-			secno = find_first_zero_bit(free_i->free_secmap,
+		secno = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
-			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
-		} else {
-			go_left = 1;
-			left_start = hint - 1;
-		}
-	}
-	if (go_left == 0)
-		goto skip_left;
-
-	while (test_bit(left_start, free_i->free_secmap)) {
-		if (left_start > 0) {
-			left_start--;
-			continue;
-		}
-		left_start = find_first_zero_bit(free_i->free_secmap,
-							MAIN_SECS(sbi));
-		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
-		break;
+		f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
 	}
-	secno = left_start;
-skip_left:
 	segno = GET_SEG_FROM_SEC(sbi, secno);
 	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
 
@@ -2695,21 +2673,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		goto got_it;
 	if (zoneno == old_zoneno)
 		goto got_it;
-	if (dir == ALLOC_LEFT) {
-		if (!go_left && zoneno + 1 >= total_zones)
-			goto got_it;
-		if (go_left && zoneno == 0)
-			goto got_it;
-	}
 	for (i = 0; i < NR_CURSEG_TYPE; i++)
 		if (CURSEG_I(sbi, i)->zone == zoneno)
 			break;
 
 	if (i < NR_CURSEG_TYPE) {
 		/* zone is in user, try another */
-		if (go_left)
-			hint = zoneno * sbi->secs_per_zone - 1;
-		else if (zoneno + 1 >= total_zones)
+		if (zoneno + 1 >= total_zones)
 			hint = 0;
 		else
 			hint = (zoneno + 1) * sbi->secs_per_zone;
@@ -2767,8 +2737,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return 0;
 
-	if (test_opt(sbi, NOHEAP) &&
-		(seg_type == CURSEG_HOT_DATA || IS_NODESEG(seg_type)))
+	if (seg_type == CURSEG_HOT_DATA || IS_NODESEG(seg_type))
 		return 0;
 
 	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
@@ -2788,21 +2757,12 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
 static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	unsigned short seg_type = curseg->seg_type;
 	unsigned int segno = curseg->segno;
-	int dir = ALLOC_LEFT;
 
 	if (curseg->inited)
-		write_sum_page(sbi, curseg->sum_blk,
-				GET_SUM_BLOCK(sbi, segno));
-	if (seg_type == CURSEG_WARM_DATA || seg_type == CURSEG_COLD_DATA)
-		dir = ALLOC_RIGHT;
-
-	if (test_opt(sbi, NOHEAP))
-		dir = ALLOC_RIGHT;
-
+		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));
 	segno = __get_next_segno(sbi, type);
-	get_new_segment(sbi, &segno, new_sec, dir);
+	get_new_segment(sbi, &segno, new_sec);
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 1);
 	curseg->alloc_type = LFS;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 61fa12f12ffdc..93ffb62e45f4d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -136,16 +136,6 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 #define SECTOR_TO_BLOCK(sectors)					\
 	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
 
-/*
- * indicate a block allocation direction: RIGHT and LEFT.
- * RIGHT means allocating new sections towards the end of volume.
- * LEFT means the opposite direction.
- */
-enum {
-	ALLOC_RIGHT = 0,
-	ALLOC_LEFT
-};
-
 /*
  * In the victim_sel_policy->alloc_mode, there are three block allocation modes.
  * LFS writes data sequentially with cleaning operations.
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a0e6f804a1d0e..a20014fb5fc51 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -759,10 +759,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			clear_opt(sbi, DISCARD);
 			break;
 		case Opt_noheap:
-			set_opt(sbi, NOHEAP);
-			break;
 		case Opt_heap:
-			clear_opt(sbi, NOHEAP);
+			f2fs_warn(sbi, "heap/no_heap options were deprecated");
 			break;
 #ifdef CONFIG_F2FS_FS_XATTR
 		case Opt_user_xattr:
@@ -2013,10 +2011,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	} else {
 		seq_puts(seq, ",nodiscard");
 	}
-	if (test_opt(sbi, NOHEAP))
-		seq_puts(seq, ",no_heap");
-	else
-		seq_puts(seq, ",heap");
 #ifdef CONFIG_F2FS_FS_XATTR
 	if (test_opt(sbi, XATTR_USER))
 		seq_puts(seq, ",user_xattr");
@@ -2196,7 +2190,6 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-	set_opt(sbi, NOHEAP);
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-- 
2.43.0




