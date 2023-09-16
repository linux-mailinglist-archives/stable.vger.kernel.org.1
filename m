Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305B07A2FF7
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbjIPMXs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbjIPMXQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:23:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA99194
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:23:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22F2C433C8;
        Sat, 16 Sep 2023 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694866991;
        bh=VH15Z7mKVfmNjBnTDwfeoFC/CE2In+iawJAP2jBiR7c=;
        h=Subject:To:Cc:From:Date:From;
        b=Su7+B4EPf2/0wMw8xPVK4iM26CvsSWULKvAUjMcOdiUfD5d56pKSSw6vXbiE3SmdN
         I3tbjPaG2YGmoOt45VnxFpB8nN2cYX2FX7RsOmWJw2M0Lr6Cf4lpl9Vl9SIBf/206l
         KjtSYgks1IDGIUOhZU7VOT9TgYj+dz+BtMFhCehY=
Subject: FAILED: patch "[PATCH] btrfs: zoned: activate metadata block group on write time" failed to apply to 6.5-stable tree
To:     naohiro.aota@wdc.com, dsterba@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:21:39 +0200
Message-ID: <2023091639-mundane-justice-4caa@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 13bb483d32abb6f8ebd40141d87eb68f11cc2dd2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091639-mundane-justice-4caa@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
0356ad41e0dd ("btrfs: zoned: defer advancing meta write pointer")
2ad8c0510a96 ("btrfs: zoned: return int from btrfs_check_meta_write_pointer")
7db94301a980 ("btrfs: zoned: introduce block group context to btrfs_eb_write_context")
861093eff4f0 ("btrfs: introduce struct to consolidate extent buffer write context")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 13bb483d32abb6f8ebd40141d87eb68f11cc2dd2 Mon Sep 17 00:00:00 2001
From: Naohiro Aota <naohiro.aota@wdc.com>
Date: Tue, 8 Aug 2023 01:12:37 +0900
Subject: [PATCH] btrfs: zoned: activate metadata block group on write time

In the current implementation, block groups are activated at reservation
time to ensure that all reserved bytes can be written to an active metadata
block group. However, this approach has proven to be less efficient, as it
activates block groups more frequently than necessary, putting pressure on
the active zone resource and leading to potential issues such as early
ENOSPC or hung_task.

Another drawback of the current method is that it hampers metadata
over-commit, and necessitates additional flush operations and block group
allocations, resulting in decreased overall performance.

To address these issues, this commit introduces a write-time activation of
metadata and system block group. This involves reserving at least one
active block group specifically for a metadata and system block group.

Since metadata write-out is always allocated sequentially, when we need to
write to a non-active block group, we can wait for the ongoing IOs to
complete, activate a new block group, and then proceed with writing to the
new block group.

Fixes: b09315139136 ("btrfs: zoned: activate metadata block group on flush_space")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a127865f49f9..b0e432c30e1d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4287,6 +4287,17 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	struct btrfs_caching_control *caching_ctl;
 	struct rb_node *n;
 
+	if (btrfs_is_zoned(info)) {
+		if (info->active_meta_bg) {
+			btrfs_put_block_group(info->active_meta_bg);
+			info->active_meta_bg = NULL;
+		}
+		if (info->active_system_bg) {
+			btrfs_put_block_group(info->active_system_bg);
+			info->active_system_bg = NULL;
+		}
+	}
+
 	write_lock(&info->block_group_cache_lock);
 	while (!list_empty(&info->caching_block_groups)) {
 		caching_ctl = list_entry(info->caching_block_groups.next,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index ef07c6c252d8..a523d64d5491 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -770,6 +770,9 @@ struct btrfs_fs_info {
 	u64 data_reloc_bg;
 	struct mutex zoned_data_reloc_io_lock;
 
+	struct btrfs_block_group *active_meta_bg;
+	struct btrfs_block_group *active_system_bg;
+
 	u64 nr_global_roots;
 
 	spinlock_t zone_active_bgs_lock;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fc69041bb6b4..099cb6a6d3b3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -65,6 +65,9 @@
 
 #define SUPER_INFO_SECTORS	((u64)BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT)
 
+static void wait_eb_writebacks(struct btrfs_block_group *block_group);
+static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written);
+
 static inline bool sb_zone_is_full(const struct blk_zone *zone)
 {
 	return (zone->cond == BLK_ZONE_COND_FULL) ||
@@ -1747,6 +1750,62 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 	}
 }
 
+static bool check_bg_is_active(struct btrfs_eb_write_context *ctx,
+			       struct btrfs_block_group **active_bg)
+{
+	const struct writeback_control *wbc = ctx->wbc;
+	struct btrfs_block_group *block_group = ctx->zoned_bg;
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
+		return true;
+
+	if (fs_info->treelog_bg == block_group->start) {
+		if (!btrfs_zone_activate(block_group)) {
+			int ret_fin = btrfs_zone_finish_one_bg(fs_info);
+
+			if (ret_fin != 1 || !btrfs_zone_activate(block_group))
+				return false;
+		}
+	} else if (*active_bg != block_group) {
+		struct btrfs_block_group *tgt = *active_bg;
+
+		/* zoned_meta_io_lock protects fs_info->active_{meta,system}_bg. */
+		lockdep_assert_held(&fs_info->zoned_meta_io_lock);
+
+		if (tgt) {
+			/*
+			 * If there is an unsent IO left in the allocated area,
+			 * we cannot wait for them as it may cause a deadlock.
+			 */
+			if (tgt->meta_write_pointer < tgt->start + tgt->alloc_offset) {
+				if (wbc->sync_mode == WB_SYNC_NONE ||
+				    (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync))
+					return false;
+			}
+
+			/* Pivot active metadata/system block group. */
+			btrfs_zoned_meta_io_unlock(fs_info);
+			wait_eb_writebacks(tgt);
+			do_zone_finish(tgt, true);
+			btrfs_zoned_meta_io_lock(fs_info);
+			if (*active_bg == tgt) {
+				btrfs_put_block_group(tgt);
+				*active_bg = NULL;
+			}
+		}
+		if (!btrfs_zone_activate(block_group))
+			return false;
+		if (*active_bg != block_group) {
+			ASSERT(*active_bg == NULL);
+			*active_bg = block_group;
+			btrfs_get_block_group(block_group);
+		}
+	}
+
+	return true;
+}
+
 /*
  * Check if @ctx->eb is aligned to the write pointer.
  *
@@ -1781,8 +1840,26 @@ int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 		ctx->zoned_bg = block_group;
 	}
 
-	if (block_group->meta_write_pointer == eb->start)
-		return 0;
+	if (block_group->meta_write_pointer == eb->start) {
+		struct btrfs_block_group **tgt;
+
+		if (!test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags))
+			return 0;
+
+		if (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM)
+			tgt = &fs_info->active_system_bg;
+		else
+			tgt = &fs_info->active_meta_bg;
+		if (check_bg_is_active(ctx, tgt))
+			return 0;
+	}
+
+	/*
+	 * Since we may release fs_info->zoned_meta_io_lock, someone can already
+	 * start writing this eb. In that case, we can just bail out.
+	 */
+	if (block_group->meta_write_pointer > eb->start)
+		return -EBUSY;
 
 	/* If for_sync, this hole will be filled with trasnsaction commit. */
 	if (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync)

