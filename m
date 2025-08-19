Return-Path: <stable+bounces-171714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4CEB2B688
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABA9625378
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2CD287255;
	Tue, 19 Aug 2025 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1PfUK+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959928724A
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568733; cv=none; b=FdgSfZK3N6H8sVwfXdKzC9ZevLmMUfmsA6mcAVqhzUpvH8iyN9QmRQkPVHw/27yqLioitz0EXYfbj/wWe9xsElrQJM4XWASdSHYnoFn9ROT3Wc1uNCLpZfyI1GLgdALu3siiA0iEF/7Lp3wJNr9trD3oDwVsa/cSC5xUg/kjVhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568733; c=relaxed/simple;
	bh=etIZJPhAOxTrvBVx62tI8ZYgsEhVH+Mj9U+nMRMmhSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dp7KetnfD8vY81nZ4zow7qnxU2ai8apFzJVEW7bB/cENte8EuiQpkcgkFT97gG6ilgy0EbDSfmUXN0ItUYiMidJG1JS+DY0jEav2FQmW0ak40uUGeb2x2uG4RXPvJnBH20mEXMGli/HyPIREfKy1ISSxQLsDk2zVxegC/r1Hcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1PfUK+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04614C116C6;
	Tue, 19 Aug 2025 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755568733;
	bh=etIZJPhAOxTrvBVx62tI8ZYgsEhVH+Mj9U+nMRMmhSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1PfUK+Jn9EFDJnEfSu+SCtsLNI/LHHM6K76iJRQqH4eAUnRgLQvBtjZu60XRm5AV
	 B8XA3XjKxK5t5U6kt2byaXfUR8PPScppoGTEEUVEpxip2AaGqaXECC4Gw6FFLr/HDq
	 diyBbr62YW1CNhLxlA5cyRWHJFA8HKpxd6z0kdwtw5mcfR2GEoFnkHcBuV+hxE6kRh
	 5tQFaUshfJIY+LgxMmlxQOleM287eD+OaGNaZCdc3Sf3SeKZjAfivGOk8uB5P7//Bn
	 P0GXzcWR84p5Ft8KEoFmd+rPDWpUIWJWVxjnq1pinblwDQLXrt0BlIUNeGHaCLTvpp
	 jHK3TDsClNz6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] btrfs: codify pattern for adding block_group to bg_list
Date: Mon, 18 Aug 2025 21:58:48 -0400
Message-ID: <20250819015850.263708-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819015850.263708-1-sashal@kernel.org>
References: <2025081853-parrot-skeleton-78e1@gregkh>
 <20250819015850.263708-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 0497dfba98c00edbc7af12d53c0b1138eb318bf7 ]

Similar to mark_bg_unused() and mark_bg_to_reclaim(), we have a few
places that use bg_list with refcounting, mostly for retrying failures
to reclaim/delete unused.

These have custom logic for handling locking and refcounting the bg_list
properly, but they actually all want to do the same thing, so pull that
logic out into a helper. Unfortunately, mark_bg_unused() does still need
the NEW flag to avoid prematurely marking stuff unused (even if refcount
is fine, we don't want to mess with bg creation), so it cannot use the
new helper.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 62be7afcc13b ("btrfs: zoned: requeue to unused block group list if zone finish failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 55 ++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7a18d862821b..841954bd788f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1459,6 +1459,32 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	return ret == 0;
 }
 
+/*
+ * Link the block_group to a list via bg_list.
+ *
+ * @bg:       The block_group to link to the list.
+ * @list:     The list to link it to.
+ *
+ * Use this rather than list_add_tail() directly to ensure proper respect
+ * to locking and refcounting.
+ *
+ * Returns: true if the bg was linked with a refcount bump and false otherwise.
+ */
+static bool btrfs_link_bg_list(struct btrfs_block_group *bg, struct list_head *list)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	bool added = false;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	if (list_empty(&bg->bg_list)) {
+		btrfs_get_block_group(bg);
+		list_add_tail(&bg->bg_list, list);
+		added = true;
+	}
+	spin_unlock(&fs_info->unused_bgs_lock);
+	return added;
+}
+
 /*
  * Process the unused_bgs list and remove any that don't have any allocated
  * space inside of them.
@@ -1574,8 +1600,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			 * drop under the "next" label for the
 			 * fs_info->unused_bgs list.
 			 */
-			btrfs_get_block_group(block_group);
-			list_add_tail(&block_group->bg_list, &retry_list);
+			btrfs_link_bg_list(block_group, &retry_list);
 
 			trace_btrfs_skip_unused_block_group(block_group);
 			spin_unlock(&block_group->lock);
@@ -1948,20 +1973,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		spin_unlock(&space_info->lock);
 
 next:
-		if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
-			/* Refcount held by the reclaim_bgs list after splice. */
-			spin_lock(&fs_info->unused_bgs_lock);
-			/*
-			 * This block group might be added to the unused list
-			 * during the above process. Move it back to the
-			 * reclaim list otherwise.
-			 */
-			if (list_empty(&bg->bg_list)) {
-				btrfs_get_block_group(bg);
-				list_add_tail(&bg->bg_list, &retry_list);
-			}
-			spin_unlock(&fs_info->unused_bgs_lock);
-		}
+		if (ret && !READ_ONCE(space_info->periodic_reclaim))
+			btrfs_link_bg_list(bg, &retry_list);
 		btrfs_put_block_group(bg);
 
 		mutex_unlock(&fs_info->reclaim_bgs_lock);
@@ -2001,13 +2014,8 @@ void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
-	spin_lock(&fs_info->unused_bgs_lock);
-	if (list_empty(&bg->bg_list)) {
-		btrfs_get_block_group(bg);
+	if (btrfs_link_bg_list(bg, &fs_info->reclaim_bgs))
 		trace_btrfs_add_reclaim_block_group(bg);
-		list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
-	}
-	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
 static int read_bg_from_eb(struct btrfs_fs_info *fs_info, const struct btrfs_key *key,
@@ -2923,8 +2931,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	}
 #endif
 
-	btrfs_get_block_group(cache);
-	list_add_tail(&cache->bg_list, &trans->new_bgs);
+	btrfs_link_bg_list(cache, &trans->new_bgs);
 	btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
 
 	set_avail_alloc_bits(fs_info, type);
-- 
2.50.1


