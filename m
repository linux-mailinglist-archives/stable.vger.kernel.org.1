Return-Path: <stable+bounces-20927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4878485C65C
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99417B23B1B
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB66F151CD0;
	Tue, 20 Feb 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gjb14n0F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8B151CC9;
	Tue, 20 Feb 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462810; cv=none; b=bMGwzik/2W/rJAil/OIgLfC+Q73Ma3wbUvSk4skB0isDzGWfLfVK3wKS+jIi1+YtBuuUor3WaJkdStmxHIjNWkJbptNKKSzZUHwLs3ReJxI+PnszxllGMiISq1lJnumTeYNeIlC433E0KUinwALdFQCtl8kYe1a3hxFQZK/3QNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462810; c=relaxed/simple;
	bh=FpE7RYsz6s3hoMZkl/Ef93Xd5hk/QOKGvn4SMfptqP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv4NsFU5dVy8ovjRehWORzy1vH5sWo1euoH9U1NVgbBf+LMnFbT9rZWom8dK4EEBY/fuvF2/eSHTmzQO7biUnFkJXFCIq0PkHNDwpkitPxW3u3b0+H4WSlD/VeHNE510P8uUXs2TgfdWpC78PWKr8mzbV6ansHNBKkj1wlTfe44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gjb14n0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E3CC433C7;
	Tue, 20 Feb 2024 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708462810;
	bh=FpE7RYsz6s3hoMZkl/Ef93Xd5hk/QOKGvn4SMfptqP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjb14n0FfV+jnuzvvZHLJkYzA8AXGzCOfjUfvqMUrza0f+7zaMEv0TH/g7dYiFWkH
	 JLRfH+i9thrz0Iy+HbxDOtNf6uqwyV/L1qo8vkn7JTfIStfwO/B+bUN1DVqNH40X4A
	 feE+4XR5X3F8pOF2gzBzQaJxDtb5jZQKO1MY0Pfk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 004/197] btrfs: do not delete unused block group if it may be used soon
Date: Tue, 20 Feb 2024 21:49:23 +0100
Message-ID: <20240220204841.208765847@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit f4a9f219411f318ae60d6ff7f129082a75686c6c upstream.

Before deleting a block group that is in the list of unused block groups
(fs_info->unused_bgs), we check if the block group became used before
deleting it, as extents from it may have been allocated after it was added
to the list.

However even if the block group was not yet used, there may be tasks that
have only reserved space and have not yet allocated extents, and they
might be relying on the availability of the unused block group in order
to allocate extents. The reservation works first by increasing the
"bytes_may_use" field of the corresponding space_info object (which may
first require flushing delayed items, allocating a new block group, etc),
and only later a task does the actual allocation of extents.

For metadata we usually don't end up using all reserved space, as we are
pessimistic and typically account for the worst cases (need to COW every
single node in a path of a tree at maximum possible height, etc). For
data we usually reserve the exact amount of space we're going to allocate
later, except when using compression where we always reserve space based
on the uncompressed size, as compression is only triggered when writeback
starts so we don't know in advance how much space we'll actually need, or
if the data is compressible.

So don't delete an unused block group if the total size of its space_info
object minus the block group's size is less then the sum of used space and
space that may be used (space_info->bytes_may_use), as that means we have
tasks that reserved space and may need to allocate extents from the block
group. In this case, besides skipping the deletion, re-add the block group
to the list of unused block groups so that it may be reconsidered later,
in case the tasks that reserved space end up not needing to allocate
extents from it.

Allowing the deletion of the block group while we have reserved space, can
result in tasks failing to allocate metadata extents (-ENOSPC) while under
a transaction handle, resulting in a transaction abort, or failure during
writeback for the case of data extents.

CC: stable@vger.kernel.org # 6.0+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/block-group.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1318,6 +1318,7 @@ out:
  */
 void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 {
+	LIST_HEAD(retry_list);
 	struct btrfs_block_group *block_group;
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
@@ -1339,6 +1340,7 @@ void btrfs_delete_unused_bgs(struct btrf
 
 	spin_lock(&fs_info->unused_bgs_lock);
 	while (!list_empty(&fs_info->unused_bgs)) {
+		u64 used;
 		int trimming;
 
 		block_group = list_first_entry(&fs_info->unused_bgs,
@@ -1374,6 +1376,7 @@ void btrfs_delete_unused_bgs(struct btrf
 			goto next;
 		}
 
+		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
 		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
@@ -1385,10 +1388,49 @@ void btrfs_delete_unused_bgs(struct btrf
 			 */
 			trace_btrfs_skip_unused_block_group(block_group);
 			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
+
+		/*
+		 * The block group may be unused but there may be space reserved
+		 * accounting with the existence of that block group, that is,
+		 * space_info->bytes_may_use was incremented by a task but no
+		 * space was yet allocated from the block group by the task.
+		 * That space may or may not be allocated, as we are generally
+		 * pessimistic about space reservation for metadata as well as
+		 * for data when using compression (as we reserve space based on
+		 * the worst case, when data can't be compressed, and before
+		 * actually attempting compression, before starting writeback).
+		 *
+		 * So check if the total space of the space_info minus the size
+		 * of this block group is less than the used space of the
+		 * space_info - if that's the case, then it means we have tasks
+		 * that might be relying on the block group in order to allocate
+		 * extents, and add back the block group to the unused list when
+		 * we finish, so that we retry later in case no tasks ended up
+		 * needing to allocate extents from the block group.
+		 */
+		used = btrfs_space_info_used(space_info, true);
+		if (space_info->total_bytes - block_group->length < used) {
+			/*
+			 * Add a reference for the list, compensate for the ref
+			 * drop under the "next" label for the
+			 * fs_info->unused_bgs list.
+			 */
+			btrfs_get_block_group(block_group);
+			list_add_tail(&block_group->bg_list, &retry_list);
+
+			trace_btrfs_skip_unused_block_group(block_group);
+			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
+			up_write(&space_info->groups_sem);
+			goto next;
+		}
+
 		spin_unlock(&block_group->lock);
+		spin_unlock(&space_info->lock);
 
 		/* We don't want to force the issue, only flip if it's ok. */
 		ret = inc_block_group_ro(block_group, 0);
@@ -1512,12 +1554,16 @@ next:
 		btrfs_put_block_group(block_group);
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
+	list_splice_tail(&retry_list, &fs_info->unused_bgs);
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	return;
 
 flip_async:
 	btrfs_end_transaction(trans);
+	spin_lock(&fs_info->unused_bgs_lock);
+	list_splice_tail(&retry_list, &fs_info->unused_bgs);
+	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_put_block_group(block_group);
 	btrfs_discard_punt_unused_bgs_list(fs_info);



