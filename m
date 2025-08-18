Return-Path: <stable+bounces-170008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB09B29FDE
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489FD1897AF3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647FC261B8D;
	Mon, 18 Aug 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zLTh5TyJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24441261B8A
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514794; cv=none; b=aAGc+dQVBiJN8c2Qf/MZEPhC/hsh1/ruNEWZCuxzBQZUGArrB0lFMtCDCcY0qVwrffbGPEwH57eAtiwU8av46IHM3coCp0NY4H3uKN8L61HNPOY9NCnh1DoOvmul+nbIW6OvvyDQ7J7c1utlBWcFxqdtikY7uN6rgNs7bqgG4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514794; c=relaxed/simple;
	bh=MnWoLKs0KkT1v8ahxwpivMYUPRrVEYGC/Qp0jX37i6c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DqArcsbHc3dX4Iq+WIAsoTz1LjlgLYL53zXR14JcLPF3k5Pyk0I6ayYT/rgWkg2clZY8GDpJxPz8/ealJkScX64jBk+0fDIWkTzUjqGmqie4MO3oW051gWZK9wcmQ2tyIp0DyW2r8zLdSa9xP0AkuMoB/VJ3xkWsjFttayKRbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zLTh5TyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52658C4CEEB;
	Mon, 18 Aug 2025 10:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514794;
	bh=MnWoLKs0KkT1v8ahxwpivMYUPRrVEYGC/Qp0jX37i6c=;
	h=Subject:To:Cc:From:Date:From;
	b=zLTh5TyJo7VrdzIDPUjnqPa0U//w7NYlYDdJalsxGDrOmg0UMR0YIXg/gysX3+wRf
	 5uBnQLB9bkcr4JuLf8AEUbJ/ROjepyPh0AIAqG4F9HJRQm8aloRfE2R7sLuY8vnkzl
	 xiT4/tBAdLnPciVSlLzd4L5Rjh2cL908XN0F0rwE=
Subject: FAILED: patch "[PATCH] btrfs: fix ssd_spread overallocation" failed to apply to 6.6-stable tree
To: boris@bur.io,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:59:32 +0200
Message-ID: <2025081832-unearned-monopoly-13b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 807d9023e75fc20bfd6dd2ac0408ce4af53f1648
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081832-unearned-monopoly-13b1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 807d9023e75fc20bfd6dd2ac0408ce4af53f1648 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Mon, 14 Jul 2025 16:44:28 -0700
Subject: [PATCH] btrfs: fix ssd_spread overallocation

If the ssd_spread mount option is enabled, then we run the so called
clustered allocator for data block groups. In practice, this results in
creating a btrfs_free_cluster which caches a block_group and borrows its
free extents for allocation.

Since the introduction of allocation size classes in 6.1, there has been
a bug in the interaction between that feature and ssd_spread.
find_free_extent() has a number of nested loops. The loop going over the
allocation stages, stored in ffe_ctl->loop and managed by
find_free_extent_update_loop(), the loop over the raid levels, and the
loop over all the block_groups in a space_info. The size class feature
relies on the block_group loop to ensure it gets a chance to see a
block_group of a given size class.  However, the clustered allocator
uses the cached cluster block_group and breaks that loop. Each call to
do_allocation() will really just go back to the same cached block_group.
Normally, this is OK, as the allocation either succeeds and we don't
want to loop any more or it fails, and we clear the cluster and return
its space to the block_group.

But with size classes, the allocation can succeed, then later fail,
outside of do_allocation() due to size class mismatch. That latter
failure is not properly handled due to the highly complex multi loop
logic. The result is a painful loop where we continue to allocate the
same num_bytes from the cluster in a tight loop until it fails and
releases the cluster and lets us try a new block_group. But by then, we
have skipped great swaths of the available block_groups and are likely
to fail to allocate, looping the outer loop. In pathological cases like
the reproducer below, the cached block_group is often the very last one,
in which case we don't perform this tight bg loop but instead rip
through the ffe stages to LOOP_CHUNK_ALLOC and allocate a chunk, which
is now the last one, and we enter the tight inner loop until an
allocation failure. Then allocation succeeds on the final block_group
and if the next allocation is a size mismatch, the exact same thing
happens again.

Triggering this is as easy as mounting with -o ssd_spread and then
running:

  mount -o ssd_spread $dev $mnt
  dd if=/dev/zero of=$mnt/big bs=16M count=1 &>/dev/null
  dd if=/dev/zero of=$mnt/med bs=4M count=1 &>/dev/null
  sync

if you do the two writes + sync in a loop, you can force btrfs to spin
an excessive amount on semi-successful clustered allocations, before
ultimately failing and advancing to the stage where we force a chunk
allocation. This results in 2G of data allocated per iteration, despite
only using ~20M of data. By using a small size classed extent, the inner
loop takes longer and we can spin for longer.

The simplest, shortest term fix to unbreak this is to make the clustered
allocator size_class aware in the dumbest way, where it fails on size
class mismatch. This may hinder the operation of the clustered
allocator, but better hindered than completely broken and terribly
overallocating.

Further re-design improvements are also in the works.

Fixes: 52bb7a2166af ("btrfs: introduce size class to block group allocator")
CC: stable@vger.kernel.org # 6.1+
Reported-by: David Sterba <dsterba@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 85833bf216de..97d517cdf2df 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3651,6 +3651,21 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
 	btrfs_put_block_group(cache);
 }
 
+static bool find_free_extent_check_size_class(const struct find_free_extent_ctl *ffe_ctl,
+					      const struct btrfs_block_group *bg)
+{
+	if (ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED)
+		return true;
+	if (!btrfs_block_group_should_use_size_class(bg))
+		return true;
+	if (ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS)
+		return true;
+	if (ffe_ctl->loop >= LOOP_UNSET_SIZE_CLASS &&
+	    bg->size_class == BTRFS_BG_SZ_NONE)
+		return true;
+	return ffe_ctl->size_class == bg->size_class;
+}
+
 /*
  * Helper function for find_free_extent().
  *
@@ -3672,7 +3687,8 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 	if (!cluster_bg)
 		goto refill_cluster;
 	if (cluster_bg != bg && (cluster_bg->ro ||
-	    !block_group_bits(cluster_bg, ffe_ctl->flags)))
+	    !block_group_bits(cluster_bg, ffe_ctl->flags) ||
+	    !find_free_extent_check_size_class(ffe_ctl, cluster_bg)))
 		goto release_cluster;
 
 	offset = btrfs_alloc_from_cluster(cluster_bg, last_ptr,
@@ -4229,21 +4245,6 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	return -ENOSPC;
 }
 
-static bool find_free_extent_check_size_class(struct find_free_extent_ctl *ffe_ctl,
-					      struct btrfs_block_group *bg)
-{
-	if (ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED)
-		return true;
-	if (!btrfs_block_group_should_use_size_class(bg))
-		return true;
-	if (ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS)
-		return true;
-	if (ffe_ctl->loop >= LOOP_UNSET_SIZE_CLASS &&
-	    bg->size_class == BTRFS_BG_SZ_NONE)
-		return true;
-	return ffe_ctl->size_class == bg->size_class;
-}
-
 static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
 					struct find_free_extent_ctl *ffe_ctl,
 					struct btrfs_space_info *space_info,


