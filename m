Return-Path: <stable+bounces-159519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1EBAF790C
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D747546C73
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD92ECE92;
	Thu,  3 Jul 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4dE4I88"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1722578A;
	Thu,  3 Jul 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554485; cv=none; b=gB785fBbi3Fv0LqmbVODT0YZEp62ckhn8prP9q7ZN+3g9WjtlA8mguaYIm2XIF1UQ6senz6m5SSflzn9ta3pRtk4L8fgNsYo9kSYa6vHpiAG8YCUDQ21SLxQ3YfI8qmQEkBuFZZ9pNiYGKrtD1lnJQCvalWiTYDWPOLn7ll/73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554485; c=relaxed/simple;
	bh=ZUe12KWkqja4q9zScKFvOAZrjo8R6ztpJFRju3b7pQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOPktrEyg6H+CaI7FWD3GduhAjZTLkWfdbbZPcQ7TmiK2NnpXF/jKNIe9DgjvXy5d1swut50jRNcE/C4Ug7CiPOl5sdOY2TqkYCDrn0g+6KOY+H9Ak+JngZgDmLd06jJMeNqnpGZLEzq2Lc9gLSj6wIHySNt4YCb9ADQPt8odaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4dE4I88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E50EC4CEE3;
	Thu,  3 Jul 2025 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554485;
	bh=ZUe12KWkqja4q9zScKFvOAZrjo8R6ztpJFRju3b7pQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4dE4I88/fzrnoG73ljgjscLHhdr0o0g3A5qNHb6v7WlBwlp9FdrvEUaONe9kFCht
	 UkLznJNrFpnfHf1pCoTU45L/chIs8Z60nG/Je7my9VZTseLFNrG8GVcd6hu6HKINp/
	 toiaRYa1QD0LlboqAw96uNUE/KIdSeDel/pMz93Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 203/218] btrfs: make the extent map shrinker run asynchronously as a work queue job
Date: Thu,  3 Jul 2025 16:42:31 +0200
Message-ID: <20250703144004.340406402@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 1020443840569535f6025a855958f07ea3eebf71 ]

Currently the extent map shrinker is run synchronously for kswapd tasks
that end up calling the fs shrinker (fs/super.c:super_cache_scan()).
This has some disadvantages and for some heavy workloads with memory
pressure it can cause some delays and stalls that make a machine
unresponsive for some periods. This happens because:

1) We can have several kswapd tasks on machines with multiple NUMA zones,
   and running the extent map shrinker concurrently can cause high
   contention on some spin locks, namely the spin locks that protect
   the radix tree that tracks roots, the per root xarray that tracks
   open inodes and the list of delayed iputs. This not only delays the
   shrinker but also causes high CPU consumption and makes the task
   running the shrinker monopolize a core, resulting in the symptoms
   of an unresponsive system. This was noted in previous commits such as
   commit ae1e766f623f ("btrfs: only run the extent map shrinker from
   kswapd tasks");

2) The extent map shrinker's iteration over inodes can often be slow, even
   after changing the data structure that tracks open inodes for a root
   from a red black tree (up to kernel 6.10) to an xarray (kernel 6.10+).
   The transition to the xarray while it made things a bit faster, it's
   still somewhat slow - for example in a test scenario with 10000 inodes
   that have no extent maps loaded, the extent map shrinker took between
   5ms to 8ms, using a release, non-debug kernel. Iterating over the
   extent maps of an inode can also be slow if have an inode with many
   thousands of extent maps, since we use a red black tree to track and
   search extent maps. So having the extent map shrinker run synchronously
   adds extra delay for other things a kswapd task does.

So make the extent map shrinker run asynchronously as a job for the
system unbounded workqueue, just like what we do for data and metadata
space reclaim jobs.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c    |  2 ++
 fs/btrfs/extent_map.c | 51 ++++++++++++++++++++++++++++++++++++-------
 fs/btrfs/extent_map.h |  3 ++-
 fs/btrfs/fs.h         |  2 ++
 fs/btrfs/super.c      | 13 +++--------
 5 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 96282bf28b19c..e655fa3bfd9be 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2785,6 +2785,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_init_scrub(fs_info);
 	btrfs_init_balance(fs_info);
 	btrfs_init_async_reclaim_work(fs_info);
+	btrfs_init_extent_map_shrinker_work(fs_info);
 
 	rwlock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT_CACHED;
@@ -4334,6 +4335,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
 	cancel_work_sync(&fs_info->preempt_reclaim_work);
+	cancel_work_sync(&fs_info->extent_map_shrinker_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d67abf5f97a77..61477cb69a6fd 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1128,7 +1128,8 @@ struct btrfs_em_shrink_ctx {
 
 static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_ctx *ctx)
 {
-	const u64 cur_fs_gen = btrfs_get_fs_generation(inode->root->fs_info);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u64 cur_fs_gen = btrfs_get_fs_generation(fs_info);
 	struct extent_map_tree *tree = &inode->extent_tree;
 	long nr_dropped = 0;
 	struct rb_node *node;
@@ -1187,7 +1188,8 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 		 * lock. This is to avoid slowing other tasks trying to take the
 		 * lock.
 		 */
-		if (need_resched() || rwlock_needbreak(&tree->lock))
+		if (need_resched() || rwlock_needbreak(&tree->lock) ||
+		    btrfs_fs_closing(fs_info))
 			break;
 		node = next;
 	}
@@ -1261,7 +1263,8 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 		ctx->last_ino = btrfs_ino(inode);
 		btrfs_add_delayed_iput(inode);
 
-		if (ctx->scanned >= ctx->nr_to_scan)
+		if (ctx->scanned >= ctx->nr_to_scan ||
+		    btrfs_fs_closing(inode->root->fs_info))
 			break;
 
 		cond_resched();
@@ -1290,16 +1293,19 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 	return nr_dropped;
 }
 
-long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
+static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 {
+	struct btrfs_fs_info *fs_info;
 	struct btrfs_em_shrink_ctx ctx;
 	u64 start_root_id;
 	u64 next_root_id;
 	bool cycled = false;
 	long nr_dropped = 0;
 
+	fs_info = container_of(work, struct btrfs_fs_info, extent_map_shrinker_work);
+
 	ctx.scanned = 0;
-	ctx.nr_to_scan = nr_to_scan;
+	ctx.nr_to_scan = atomic64_read(&fs_info->extent_map_shrinker_nr_to_scan);
 
 	/*
 	 * In case we have multiple tasks running this shrinker, make the next
@@ -1317,12 +1323,12 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_to_scan,
+		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, ctx.nr_to_scan,
 							   nr, ctx.last_root,
 							   ctx.last_ino);
 	}
 
-	while (ctx.scanned < ctx.nr_to_scan) {
+	while (ctx.scanned < ctx.nr_to_scan && !btrfs_fs_closing(fs_info)) {
 		struct btrfs_root *root;
 		unsigned long count;
 
@@ -1380,5 +1386,34 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 							  ctx.last_ino);
 	}
 
-	return nr_dropped;
+	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
+}
+
+void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
+{
+	/*
+	 * Do nothing if the shrinker is already running. In case of high memory
+	 * pressure we can have a lot of tasks calling us and all passing the
+	 * same nr_to_scan value, but in reality we may need only to free
+	 * nr_to_scan extent maps (or less). In case we need to free more than
+	 * that, we will be called again by the fs shrinker, so no worries about
+	 * not doing enough work to reclaim memory from extent maps.
+	 * We can also be repeatedly called with the same nr_to_scan value
+	 * simply because the shrinker runs asynchronously and multiple calls
+	 * to this function are made before the shrinker does enough progress.
+	 *
+	 * That's why we set the atomic counter to nr_to_scan only if its
+	 * current value is zero, instead of incrementing the counter by
+	 * nr_to_scan.
+	 */
+	if (atomic64_cmpxchg(&fs_info->extent_map_shrinker_nr_to_scan, 0, nr_to_scan) != 0)
+		return;
+
+	queue_work(system_unbound_wq, &fs_info->extent_map_shrinker_work);
+}
+
+void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info)
+{
+	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
+	INIT_WORK(&fs_info->extent_map_shrinker_work, btrfs_extent_map_shrinker_worker);
 }
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 5154a8f1d26c9..cd123b266b641 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -189,6 +189,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
 int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 				   struct extent_map *new_em,
 				   bool modified);
-long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan);
+void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan);
+void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info);
 
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index bb822e425d7fa..374843aca60d8 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -639,6 +639,8 @@ struct btrfs_fs_info {
 	spinlock_t extent_map_shrinker_lock;
 	u64 extent_map_shrinker_last_root;
 	u64 extent_map_shrinker_last_ino;
+	atomic64_t extent_map_shrinker_nr_to_scan;
+	struct work_struct extent_map_shrinker_work;
 
 	/* Protected by 'trans_lock'. */
 	struct list_head dirty_cowonly_roots;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index bcb8def4ade20..6119a06b05693 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -28,7 +28,6 @@
 #include <linux/btrfs.h>
 #include <linux/security.h>
 #include <linux/fs_parser.h>
-#include <linux/swap.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
@@ -2399,16 +2398,10 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	const long nr_to_scan = min_t(unsigned long, LONG_MAX, sc->nr_to_scan);
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 
-	/*
-	 * We may be called from any task trying to allocate memory and we don't
-	 * want to slow it down with scanning and dropping extent maps. It would
-	 * also cause heavy lock contention if many tasks concurrently enter
-	 * here. Therefore only allow kswapd tasks to scan and drop extent maps.
-	 */
-	if (!current_is_kswapd())
-		return 0;
+	btrfs_free_extent_maps(fs_info, nr_to_scan);
 
-	return btrfs_free_extent_maps(fs_info, nr_to_scan);
+	/* The extent map shrinker runs asynchronously, so always return 0. */
+	return 0;
 }
 
 static const struct super_operations btrfs_super_ops = {
-- 
2.39.5




