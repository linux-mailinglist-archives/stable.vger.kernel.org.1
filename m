Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E579B025
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjIKWrI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbjIKOzU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:55:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4C3118
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:55:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35C4C433C7;
        Mon, 11 Sep 2023 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444115;
        bh=Lw0qQ3p5nE8V8F9W+MwXy52bD5DXdT3VSdefUVaktcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/X/lfpF/uNAsEjWeBUHNbZIQtwTKihAoG2wYmQik9H0cKAghl4j/lgKaCMSYhS1D
         8kVz3CjIMGAoyb+siK8bOaY817yuZegMXLyTJNjy8xisrao/W7G9VS1JtWG4kSHhlP
         g90rdg6Y/GAH5sVeRleltX7DKiD/LWaOh0iifhfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 579/737] f2fs: fix to account gc stats correctly
Date:   Mon, 11 Sep 2023 15:47:18 +0200
Message-ID: <20230911134706.704315712@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit 9bf1dcbdfdc8892d9cfeaeab02519c0ecf17fe51 ]

As reported, status debugfs entry shows inconsistent GC stats as below:

GC calls: 6008 (BG: 6161)
  - data segments : 3053 (BG: 3053)
  - node segments : 2955 (BG: 2955)

Total GC calls is larger than BGGC calls, the reason is:
- f2fs_stat_info.call_count accounts total migrated section count
by f2fs_gc()
- f2fs_stat_info.bg_gc accounts total call times of f2fs_gc() from
background gc_thread

Another issue is gc_foreground_calls sysfs entry shows total GC call
count rather than FGGC call count.

This patch changes as below for fix:
- account GC calls and migrated segment count separately
- support to account migrated section count if it enables large section
mode
- fix to show correct value in gc_foreground_calls sysfs entry

Fixes: fc7100ea2a52 ("f2fs: Add f2fs stats to sysfs")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/debug.c   | 24 ++++++++++++++++++------
 fs/f2fs/f2fs.h    | 42 +++++++++++++++++++++---------------------
 fs/f2fs/file.c    |  4 ++++
 fs/f2fs/gc.c      | 13 +++++++------
 fs/f2fs/segment.c |  1 +
 fs/f2fs/super.c   |  1 +
 fs/f2fs/sysfs.c   |  4 ++--
 7 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 61c35b59126ec..c7cf453dce838 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -511,12 +511,24 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Total : %4d\n", si->nr_total_ckpt);
 		seq_printf(s, "  - Cur time : %4d(ms)\n", si->cur_ckpt_time);
 		seq_printf(s, "  - Peak time : %4d(ms)\n", si->peak_ckpt_time);
-		seq_printf(s, "GC calls: %d (BG: %d)\n",
-			   si->call_count, si->bg_gc);
-		seq_printf(s, "  - data segments : %d (%d)\n",
-				si->data_segs, si->bg_data_segs);
-		seq_printf(s, "  - node segments : %d (%d)\n",
-				si->node_segs, si->bg_node_segs);
+		seq_printf(s, "GC calls: %d (gc_thread: %d)\n",
+			   si->gc_call_count[BACKGROUND] +
+			   si->gc_call_count[FOREGROUND],
+			   si->gc_call_count[BACKGROUND]);
+		if (__is_large_section(sbi)) {
+			seq_printf(s, "  - data sections : %d (BG: %d)\n",
+					si->gc_secs[DATA][BG_GC] + si->gc_secs[DATA][FG_GC],
+					si->gc_secs[DATA][BG_GC]);
+			seq_printf(s, "  - node sections : %d (BG: %d)\n",
+					si->gc_secs[NODE][BG_GC] + si->gc_secs[NODE][FG_GC],
+					si->gc_secs[NODE][BG_GC]);
+		}
+		seq_printf(s, "  - data segments : %d (BG: %d)\n",
+				si->gc_segs[DATA][BG_GC] + si->gc_segs[DATA][FG_GC],
+				si->gc_segs[DATA][BG_GC]);
+		seq_printf(s, "  - node segments : %d (BG: %d)\n",
+				si->gc_segs[NODE][BG_GC] + si->gc_segs[NODE][FG_GC],
+				si->gc_segs[NODE][BG_GC]);
 		seq_puts(s, "  - Reclaimed segs :\n");
 		seq_printf(s, "    - Normal : %d\n", sbi->gc_reclaimed_segs[GC_NORMAL]);
 		seq_printf(s, "    - Idle CB : %d\n", sbi->gc_reclaimed_segs[GC_IDLE_CB]);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 395d23ab149da..278a401e32cf3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3848,6 +3848,12 @@ void f2fs_destroy_recovery_cache(void);
 /*
  * debug.c
  */
+enum {
+	BACKGROUND,
+	FOREGROUND,
+	MAX_CALL_TYPE
+};
+
 #ifdef CONFIG_F2FS_STAT_FS
 struct f2fs_stat_info {
 	struct list_head stat_list;
@@ -3873,7 +3879,7 @@ struct f2fs_stat_info {
 	int nats, dirty_nats, sits, dirty_sits;
 	int free_nids, avail_nids, alloc_nids;
 	int total_count, utilization;
-	int bg_gc, nr_wb_cp_data, nr_wb_data;
+	int nr_wb_cp_data, nr_wb_data;
 	int nr_rd_data, nr_rd_node, nr_rd_meta;
 	int nr_dio_read, nr_dio_write;
 	unsigned int io_skip_bggc, other_skip_bggc;
@@ -3893,9 +3899,11 @@ struct f2fs_stat_info {
 	int rsvd_segs, overp_segs;
 	int dirty_count, node_pages, meta_pages, compress_pages;
 	int compress_page_hit;
-	int prefree_count, call_count, cp_count, bg_cp_count;
-	int tot_segs, node_segs, data_segs, free_segs, free_secs;
-	int bg_node_segs, bg_data_segs;
+	int prefree_count, free_segs, free_secs;
+	int cp_count, bg_cp_count;
+	int gc_call_count[MAX_CALL_TYPE];
+	int gc_segs[2][2];
+	int gc_secs[2][2];
 	int tot_blks, data_blks, node_blks;
 	int bg_data_blks, bg_node_blks;
 	int curseg[NR_CURSEG_TYPE];
@@ -3919,8 +3927,6 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 
 #define stat_inc_cp_count(si)		((si)->cp_count++)
 #define stat_inc_bg_cp_count(si)	((si)->bg_cp_count++)
-#define stat_inc_call_count(si)		((si)->call_count++)
-#define stat_inc_bggc_count(si)		((si)->bg_gc++)
 #define stat_io_skip_bggc_count(sbi)	((sbi)->io_skip_bggc++)
 #define stat_other_skip_bggc_count(sbi)	((sbi)->other_skip_bggc++)
 #define stat_inc_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]++)
@@ -4005,18 +4011,12 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		if (cur > max)						\
 			atomic_set(&F2FS_I_SB(inode)->max_aw_cnt, cur);	\
 	} while (0)
-#define stat_inc_seg_count(sbi, type, gc_type)				\
-	do {								\
-		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
-		si->tot_segs++;						\
-		if ((type) == SUM_TYPE_DATA) {				\
-			si->data_segs++;				\
-			si->bg_data_segs += (gc_type == BG_GC) ? 1 : 0;	\
-		} else {						\
-			si->node_segs++;				\
-			si->bg_node_segs += (gc_type == BG_GC) ? 1 : 0;	\
-		}							\
-	} while (0)
+#define stat_inc_gc_call_count(sbi, foreground)				\
+		(F2FS_STAT(sbi)->gc_call_count[(foreground)]++)
+#define stat_inc_gc_sec_count(sbi, type, gc_type)			\
+		(F2FS_STAT(sbi)->gc_secs[(type)][(gc_type)]++)
+#define stat_inc_gc_seg_count(sbi, type, gc_type)			\
+		(F2FS_STAT(sbi)->gc_segs[(type)][(gc_type)]++)
 
 #define stat_inc_tot_blk_count(si, blks)				\
 	((si)->tot_blks += (blks))
@@ -4045,8 +4045,6 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #else
 #define stat_inc_cp_count(si)				do { } while (0)
 #define stat_inc_bg_cp_count(si)			do { } while (0)
-#define stat_inc_call_count(si)				do { } while (0)
-#define stat_inc_bggc_count(si)				do { } while (0)
 #define stat_io_skip_bggc_count(sbi)			do { } while (0)
 #define stat_other_skip_bggc_count(sbi)			do { } while (0)
 #define stat_inc_dirty_inode(sbi, type)			do { } while (0)
@@ -4074,7 +4072,9 @@ void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #define stat_inc_seg_type(sbi, curseg)			do { } while (0)
 #define stat_inc_block_count(sbi, curseg)		do { } while (0)
 #define stat_inc_inplace_blocks(sbi)			do { } while (0)
-#define stat_inc_seg_count(sbi, type, gc_type)		do { } while (0)
+#define stat_inc_gc_call_count(sbi, foreground)		do { } while (0)
+#define stat_inc_gc_sec_count(sbi, type, gc_type)	do { } while (0)
+#define stat_inc_gc_seg_count(sbi, type, gc_type)	do { } while (0)
 #define stat_inc_tot_blk_count(si, blks)		do { } while (0)
 #define stat_inc_data_blk_count(sbi, blks, gc_type)	do { } while (0)
 #define stat_inc_node_blk_count(sbi, blks, gc_type)	do { } while (0)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f1be41014180a..094b047d246c9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1729,6 +1729,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 		if (has_not_enough_free_secs(sbi, 0,
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
 			f2fs_down_write(&sbi->gc_lock);
+			stat_inc_gc_call_count(sbi, FOREGROUND);
 			err = f2fs_gc(sbi, &gc_control);
 			if (err && err != -ENODATA)
 				goto out_err;
@@ -2477,6 +2478,7 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
 
 	gc_control.init_gc_type = sync ? FG_GC : BG_GC;
 	gc_control.err_gc_skipped = sync;
+	stat_inc_gc_call_count(sbi, FOREGROUND);
 	ret = f2fs_gc(sbi, &gc_control);
 out:
 	mnt_drop_write_file(filp);
@@ -2520,6 +2522,7 @@ static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
 	}
 
 	gc_control.victim_segno = GET_SEGNO(sbi, range->start);
+	stat_inc_gc_call_count(sbi, FOREGROUND);
 	ret = f2fs_gc(sbi, &gc_control);
 	if (ret) {
 		if (ret == -EBUSY)
@@ -2991,6 +2994,7 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 		sm->last_victim[ALLOC_NEXT] = end_segno + 1;
 
 		gc_control.victim_segno = start_segno;
+		stat_inc_gc_call_count(sbi, FOREGROUND);
 		ret = f2fs_gc(sbi, &gc_control);
 		if (ret == -EAGAIN)
 			ret = 0;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 719b1ba32a78b..2addd7c95c7eb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -121,8 +121,8 @@ static int gc_thread_func(void *data)
 		else
 			increase_sleep_time(gc_th, &wait_ms);
 do_gc:
-		if (!foreground)
-			stat_inc_bggc_count(sbi->stat_info);
+		stat_inc_gc_call_count(sbi, foreground ?
+					FOREGROUND : BACKGROUND);
 
 		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
 
@@ -1685,6 +1685,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	int seg_freed = 0, migrated = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
+	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
 	int submitted = 0;
 
 	if (__is_large_section(sbi))
@@ -1766,7 +1767,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 							segno, gc_type,
 							force_migrate);
 
-		stat_inc_seg_count(sbi, type, gc_type);
+		stat_inc_gc_seg_count(sbi, data_type, gc_type);
 		sbi->gc_reclaimed_segs[sbi->gc_mode]++;
 		migrated++;
 
@@ -1783,12 +1784,12 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	}
 
 	if (submitted)
-		f2fs_submit_merged_write(sbi,
-				(type == SUM_TYPE_NODE) ? NODE : DATA);
+		f2fs_submit_merged_write(sbi, data_type);
 
 	blk_finish_plug(&plug);
 
-	stat_inc_call_count(sbi->stat_info);
+	if (migrated)
+		stat_inc_gc_sec_count(sbi, data_type, gc_type);
 
 	return seg_freed;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6db410f1bb8ce..aa126597b8be5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -433,6 +433,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 			.err_gc_skipped = false,
 			.nr_free_secs = 1 };
 		f2fs_down_write(&sbi->gc_lock);
+		stat_inc_gc_call_count(sbi, FOREGROUND);
 		f2fs_gc(sbi, &gc_control);
 	}
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 72b7ea71f55df..751ac088bc19e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2189,6 +2189,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 			.nr_free_secs = 1 };
 
 		f2fs_down_write(&sbi->gc_lock);
+		stat_inc_gc_call_count(sbi, FOREGROUND);
 		err = f2fs_gc(sbi, &gc_control);
 		if (err == -ENODATA) {
 			err = 0;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 99b028db80a1d..52a0b7878e718 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -974,8 +974,8 @@ F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
 #ifdef CONFIG_F2FS_STAT_FS
 STAT_INFO_RO_ATTR(cp_foreground_calls, cp_count);
 STAT_INFO_RO_ATTR(cp_background_calls, bg_cp_count);
-STAT_INFO_RO_ATTR(gc_foreground_calls, call_count);
-STAT_INFO_RO_ATTR(gc_background_calls, bg_gc);
+STAT_INFO_RO_ATTR(gc_foreground_calls, gc_call_count[FOREGROUND]);
+STAT_INFO_RO_ATTR(gc_background_calls, gc_call_count[BACKGROUND]);
 #endif
 
 /* FAULT_INFO ATTR */
-- 
2.40.1



