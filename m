Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD0C79B52B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379516AbjIKWoi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjIKOyc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:54:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4758E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:54:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145B7C433C7;
        Mon, 11 Sep 2023 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444067;
        bh=c6drw9AJELAvUin57FVLlJLv4fe7OT8l8XdqtUUpduo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Z6Rz7yrW0s0BzEEFC3Kxa7fV7z7Ofhe63SWO5ip0koVhRyG0WKchjSDGJHk+Nv9G
         tJqDpkRe8tfN5VbLFHDI170kOebnUm5M+4Ynmq+jGvcv+wVwEHxsYJD/CMCeuPuuPT
         iqxol9M7LgTpCl2qulWok6Pwe+pMEDOgWGdLX4Ow=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 581/737] f2fs: fix to account cp stats correctly
Date:   Mon, 11 Sep 2023 15:47:20 +0200
Message-ID: <20230911134706.758894783@linuxfoundation.org>
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

[ Upstream commit eb61c2cca2eb2110cc7b61a7bc15b3850977a778 ]

cp_foreground_calls sysfs entry shows total CP call count rather than
foreground CP call count, fix it.

Fixes: fc7100ea2a52 ("f2fs: Add f2fs stats to sysfs")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/debug.c      |  9 ++++++++-
 fs/f2fs/f2fs.h       | 25 ++++++++++++++-----------
 fs/f2fs/gc.c         |  5 +++++
 fs/f2fs/recovery.c   |  1 +
 fs/f2fs/segment.c    |  3 ++-
 fs/f2fs/super.c      |  8 +++++++-
 fs/f2fs/sysfs.c      | 14 ++++++++++++--
 8 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8fd3b7f9fb88e..b0597a539fc54 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1701,9 +1701,9 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	}
 
 	f2fs_restore_inmem_curseg(sbi);
+	stat_inc_cp_count(sbi);
 stop:
 	unblock_operations(sbi);
-	stat_inc_cp_count(sbi->stat_info);
 
 	if (cpc->reason & CP_RECOVERY)
 		f2fs_notice(sbi, "checkpoint: version = %llx", ckpt_ver);
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index c7cf453dce838..fdbf994f12718 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -215,6 +215,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 		si->valid_blks[type] += blks;
 	}
 
+	for (i = 0; i < MAX_CALL_TYPE; i++)
+		si->cp_call_count[i] = atomic_read(&sbi->cp_call_count[i]);
+
 	for (i = 0; i < 2; i++) {
 		si->segment_count[i] = sbi->segment_count[i];
 		si->block_count[i] = sbi->block_count[i];
@@ -497,7 +500,9 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Prefree: %d\n  - Free: %d (%d)\n\n",
 			   si->prefree_count, si->free_segs, si->free_secs);
 		seq_printf(s, "CP calls: %d (BG: %d)\n",
-				si->cp_count, si->bg_cp_count);
+			   si->cp_call_count[TOTAL_CALL],
+			   si->cp_call_count[BACKGROUND]);
+		seq_printf(s, "CP count: %d\n", si->cp_count);
 		seq_printf(s, "  - cp blocks : %u\n", si->meta_count[META_CP]);
 		seq_printf(s, "  - sit blocks : %u\n",
 				si->meta_count[META_SIT]);
@@ -699,6 +704,8 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->inplace_count, 0);
 	for (i = META_CP; i < META_MAX; i++)
 		atomic_set(&sbi->meta_count[i], 0);
+	for (i = 0; i < MAX_CALL_TYPE; i++)
+		atomic_set(&sbi->cp_call_count[i], 0);
 
 	atomic_set(&sbi->max_aw_cnt, 0);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 278a401e32cf3..cfb8e274c0699 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1377,6 +1377,13 @@ enum errors_option {
 	MOUNT_ERRORS_PANIC,	/* panic on errors */
 };
 
+enum {
+	BACKGROUND,
+	FOREGROUND,
+	MAX_CALL_TYPE,
+	TOTAL_CALL = FOREGROUND,
+};
+
 static inline int f2fs_test_bit(unsigned int nr, char *addr);
 static inline void f2fs_set_bit(unsigned int nr, char *addr);
 static inline void f2fs_clear_bit(unsigned int nr, char *addr);
@@ -1687,6 +1694,7 @@ struct f2fs_sb_info {
 	unsigned int io_skip_bggc;		/* skip background gc for in-flight IO */
 	unsigned int other_skip_bggc;		/* skip background gc for other reasons */
 	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
+	atomic_t cp_call_count[MAX_CALL_TYPE];	/* # of cp call */
 #endif
 	spinlock_t stat_lock;			/* lock for stat operations */
 
@@ -3848,12 +3856,6 @@ void f2fs_destroy_recovery_cache(void);
 /*
  * debug.c
  */
-enum {
-	BACKGROUND,
-	FOREGROUND,
-	MAX_CALL_TYPE
-};
-
 #ifdef CONFIG_F2FS_STAT_FS
 struct f2fs_stat_info {
 	struct list_head stat_list;
@@ -3900,7 +3902,7 @@ struct f2fs_stat_info {
 	int dirty_count, node_pages, meta_pages, compress_pages;
 	int compress_page_hit;
 	int prefree_count, free_segs, free_secs;
-	int cp_count, bg_cp_count;
+	int cp_call_count[MAX_CALL_TYPE], cp_count;
 	int gc_call_count[MAX_CALL_TYPE];
 	int gc_segs[2][2];
 	int gc_secs[2][2];
@@ -3925,8 +3927,9 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 	return (struct f2fs_stat_info *)sbi->stat_info;
 }
 
-#define stat_inc_cp_count(si)		((si)->cp_count++)
-#define stat_inc_bg_cp_count(si)	((si)->bg_cp_count++)
+#define stat_inc_cp_call_count(sbi, foreground)				\
+		atomic_inc(&sbi->cp_call_count[(foreground)])
+#define stat_inc_cp_count(si)		(F2FS_STAT(sbi)->cp_count++)
 #define stat_io_skip_bggc_count(sbi)	((sbi)->io_skip_bggc++)
 #define stat_other_skip_bggc_count(sbi)	((sbi)->other_skip_bggc++)
 #define stat_inc_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]++)
@@ -4043,8 +4046,8 @@ void __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
 #else
-#define stat_inc_cp_count(si)				do { } while (0)
-#define stat_inc_bg_cp_count(si)			do { } while (0)
+#define stat_inc_cp_call_count(sbi, foreground)		do { } while (0)
+#define stat_inc_cp_count(sbi)				do { } while (0)
 #define stat_io_skip_bggc_count(sbi)			do { } while (0)
 #define stat_other_skip_bggc_count(sbi)			do { } while (0)
 #define stat_inc_dirty_inode(sbi, type)			do { } while (0)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2addd7c95c7eb..7d2736b66c702 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1840,6 +1840,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		 * secure free segments which doesn't need fggc any more.
 		 */
 		if (prefree_segments(sbi)) {
+			stat_inc_cp_call_count(sbi, TOTAL_CALL);
 			ret = f2fs_write_checkpoint(sbi, &cpc);
 			if (ret)
 				goto stop;
@@ -1884,6 +1885,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		round++;
 		if (skipped_round > MAX_SKIP_GC_COUNT &&
 				skipped_round * 2 >= round) {
+			stat_inc_cp_call_count(sbi, TOTAL_CALL);
 			ret = f2fs_write_checkpoint(sbi, &cpc);
 			goto stop;
 		}
@@ -1899,6 +1901,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	 */
 	if (free_sections(sbi) <= upper_secs + NR_GC_CHECKPOINT_SECS &&
 				prefree_segments(sbi)) {
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
 		ret = f2fs_write_checkpoint(sbi, &cpc);
 		if (ret)
 			goto stop;
@@ -2024,6 +2027,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	if (gc_only)
 		goto out;
 
+	stat_inc_cp_call_count(sbi, TOTAL_CALL);
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err)
 		goto out;
@@ -2216,6 +2220,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
 	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
+	stat_inc_cp_call_count(sbi, TOTAL_CALL);
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err) {
 		update_fs_metadata(sbi, secs);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 58c1a0096f7de..5b632d2641d49 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -895,6 +895,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 			struct cp_control cpc = {
 				.reason = CP_RECOVERY,
 			};
+			stat_inc_cp_call_count(sbi, TOTAL_CALL);
 			err = f2fs_write_checkpoint(sbi, &cpc);
 		}
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index aa126597b8be5..37196d7a9685c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -511,8 +511,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 
 		mutex_unlock(&sbi->flush_lock);
 	}
+	stat_inc_cp_call_count(sbi, BACKGROUND);
 	f2fs_sync_fs(sbi->sb, 1);
-	stat_inc_bg_cp_count(sbi->stat_info);
 }
 
 static int __submit_flush_wait(struct f2fs_sb_info *sbi,
@@ -3151,6 +3151,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 		goto out;
 
 	f2fs_down_write(&sbi->gc_lock);
+	stat_inc_cp_call_count(sbi, TOTAL_CALL);
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	f2fs_up_write(&sbi->gc_lock);
 	if (err)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 20f1bda0e1a17..a6f283d34cd49 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1598,6 +1598,7 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
 		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
@@ -1607,6 +1608,7 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
 		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
@@ -1703,8 +1705,10 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		return -EAGAIN;
 
-	if (sync)
+	if (sync) {
+		stat_inc_cp_call_count(sbi, TOTAL_CALL);
 		err = f2fs_issue_checkpoint(sbi);
+	}
 
 	return err;
 }
@@ -2229,6 +2233,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	f2fs_down_write(&sbi->gc_lock);
 	cpc.reason = CP_PAUSE;
 	set_sbi_flag(sbi, SBI_CP_DISABLED);
+	stat_inc_cp_call_count(sbi, TOTAL_CALL);
 	err = f2fs_write_checkpoint(sbi, &cpc);
 	if (err)
 		goto out_unlock;
@@ -4848,6 +4853,7 @@ static void kill_f2fs_super(struct super_block *sb)
 			struct cp_control cpc = {
 				.reason = CP_UMOUNT,
 			};
+			stat_inc_cp_call_count(sbi, TOTAL_CALL);
 			f2fs_write_checkpoint(sbi, &cpc);
 		}
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 52a0b7878e718..8e18c2d742ca9 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -356,6 +356,16 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 	if (!strcmp(a->attr.name, "revoked_atomic_block"))
 		return sysfs_emit(buf, "%llu\n", sbi->revoked_atomic_block);
 
+#ifdef CONFIG_F2FS_STAT_FS
+	if (!strcmp(a->attr.name, "cp_foreground_calls"))
+		return sysfs_emit(buf, "%d\n",
+				atomic_read(&sbi->cp_call_count[TOTAL_CALL]) -
+				atomic_read(&sbi->cp_call_count[BACKGROUND]));
+	if (!strcmp(a->attr.name, "cp_background_calls"))
+		return sysfs_emit(buf, "%d\n",
+				atomic_read(&sbi->cp_call_count[BACKGROUND]));
+#endif
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sysfs_emit(buf, "%u\n", *ui);
@@ -972,8 +982,8 @@ F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
 
 /* STAT_INFO ATTR */
 #ifdef CONFIG_F2FS_STAT_FS
-STAT_INFO_RO_ATTR(cp_foreground_calls, cp_count);
-STAT_INFO_RO_ATTR(cp_background_calls, bg_cp_count);
+STAT_INFO_RO_ATTR(cp_foreground_calls, cp_call_count[FOREGROUND]);
+STAT_INFO_RO_ATTR(cp_background_calls, cp_call_count[BACKGROUND]);
 STAT_INFO_RO_ATTR(gc_foreground_calls, gc_call_count[FOREGROUND]);
 STAT_INFO_RO_ATTR(gc_background_calls, gc_call_count[BACKGROUND]);
 #endif
-- 
2.40.1



