Return-Path: <stable+bounces-6947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE9816739
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D311C222AE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A5F79D2;
	Mon, 18 Dec 2023 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uqkWykDM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73243F9C1
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0132EC433C9;
	Mon, 18 Dec 2023 07:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702883826;
	bh=SjxGdQvVFoNOiAgQ6J34jNNr4rtdtB9KWmit0h1cTYw=;
	h=Subject:To:Cc:From:Date:From;
	b=uqkWykDMN/nLM1CFL9Y2ywPllOSwUijidSskmmPawHEGCkR5u/7VOZrkqMO8c9xj1
	 jrCOK2t6MlQlxQ6eS+Whu+TK+d3+eYdEVSlF7PS3gZ1q23cXYnTqPsR4AuL6dLJbv9
	 FVSZBOyedLhNlw6CVmctPfPvfe68Tr04GIDTPfck=
Subject: FAILED: patch "[PATCH] btrfs: fix qgroup_free_reserved_data int overflow" failed to apply to 6.1-stable tree
To: boris@bur.io,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:17:03 +0100
Message-ID: <2023121803-scalding-snowfall-4460@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9e65bfca24cf1d77e4a5c7a170db5867377b3fe7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121803-scalding-snowfall-4460@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

9e65bfca24cf ("btrfs: fix qgroup_free_reserved_data int overflow")
53d9981ca20e ("btrfs: split btrfs_alloc_ordered_extent to allocation and insertion helpers")
cbfce4c7fbde ("btrfs: optimize the logical to physical mapping for zoned writes")
5cfe76f846d5 ("btrfs: rename the bytenr field in struct btrfs_ordered_sum to logical")
6e4b2479ab38 ("btrfs: mark the len field in struct btrfs_ordered_sum as unsigned")
adbe7e388e42 ("btrfs: use SECTOR_SHIFT to convert LBA to physical offset")
cf6d1aa482fb ("btrfs: add function to create and return an ordered extent")
ae42a154ca89 ("btrfs: pass a btrfs_bio to btrfs_submit_bio")
34f888ce3a35 ("btrfs: cleanup main loop in btrfs_encoded_read_regular_fill_pages")
10e924bc320a ("btrfs: factor out a btrfs_add_compressed_bio_pages helper")
e7aff33e3161 ("btrfs: use the bbio file offset in btrfs_submit_compressed_read")
798c9fc74d03 ("btrfs: remove redundant free_extent_map in btrfs_submit_compressed_read")
544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio")
04f0847c4552 ("btrfs: don't rely on unchanging ->bi_bdev for zone append remaps")
d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
35a8d7da3ca8 ("btrfs: remove now spurious bio submission helpers")
285599b6fe15 ("btrfs: remove the fs_info argument to btrfs_submit_bio")
48253076c3a9 ("btrfs: open code submit_encoded_read_bio")
a34e4c3f884c ("btrfs: remove stripe boundary calculation for encoded I/O")
30493ff49f81 ("btrfs: remove stripe boundary calculation for compressed I/O")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e65bfca24cf1d77e4a5c7a170db5867377b3fe7 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Fri, 1 Dec 2023 13:00:10 -0800
Subject: [PATCH] btrfs: fix qgroup_free_reserved_data int overflow

The reserved data counter and input parameter is a u64, but we
inadvertently accumulate it in an int. Overflowing that int results in
freeing the wrong amount of data and breaking reserve accounting.

Unfortunately, this overflow rot spreads from there, as the qgroup
release/free functions rely on returning an int to take advantage of
negative values for error codes.

Therefore, the full fix is to return the "released" or "freed" amount by
a u64 argument and to return 0 or negative error code via the return
value.

Most of the call sites simply ignore the return value, though some
of them handle the error and count the returned bytes. Change all of
them accordingly.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 51453d4928fa..2833e8ef4c09 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -199,7 +199,7 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 	start = round_down(start, fs_info->sectorsize);
 
 	btrfs_free_reserved_data_space_noquota(fs_info, len);
-	btrfs_qgroup_free_data(inode, reserved, start, len);
+	btrfs_qgroup_free_data(inode, reserved, start, len, NULL);
 }
 
 /*
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 92419cb8508a..33587c7ac859 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3190,7 +3190,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 			qgroup_reserved -= range->len;
 		} else if (qgroup_reserved > 0) {
 			btrfs_qgroup_free_data(BTRFS_I(inode), data_reserved,
-					       range->start, range->len);
+					       range->start, range->len, NULL);
 			qgroup_reserved -= range->len;
 		}
 		list_del(&range->list);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 137c4824ff91..b9a31df58744 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -688,7 +688,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE);
+	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
@@ -5132,7 +5132,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		 */
 		if (state_flags & EXTENT_DELALLOC)
 			btrfs_qgroup_free_data(BTRFS_I(inode), NULL, start,
-					       end - start + 1);
+					       end - start + 1, NULL);
 
 		clear_extent_bit(io_tree, start, end,
 				 EXTENT_CLEAR_ALL_BITS | EXTENT_DO_ACCOUNTING,
@@ -8055,7 +8055,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		 *    reserved data space.
 		 *    Since the IO will never happen for this page.
 		 */
-		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur);
+		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur, NULL);
 		if (!inode_evicting) {
 			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_UPTODATE |
@@ -9487,7 +9487,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	struct btrfs_path *path;
 	u64 start = ins->objectid;
 	u64 len = ins->offset;
-	int qgroup_released;
+	u64 qgroup_released = 0;
 	int ret;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
@@ -9500,9 +9500,9 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	btrfs_set_stack_file_extent_compression(&stack_fi, BTRFS_COMPRESS_NONE);
 	/* Encryption and other encoding is reserved and all 0 */
 
-	qgroup_released = btrfs_qgroup_release_data(inode, file_offset, len);
-	if (qgroup_released < 0)
-		return ERR_PTR(qgroup_released);
+	ret = btrfs_qgroup_release_data(inode, file_offset, len, &qgroup_released);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
 	if (trans) {
 		ret = insert_reserved_file_extent(trans, inode,
@@ -10397,7 +10397,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	btrfs_delalloc_release_metadata(inode, disk_num_bytes, ret < 0);
 out_qgroup_free_data:
 	if (ret < 0)
-		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes);
+		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes, NULL);
 out_free_data_space:
 	/*
 	 * If btrfs_reserve_extent() succeeded, then we already decremented
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 8620ff402de4..a82e1417c4d2 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -152,11 +152,12 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 {
 	struct btrfs_ordered_extent *entry;
 	int ret;
+	u64 qgroup_rsv = 0;
 
 	if (flags &
 	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
 		/* For nocow write, we can release the qgroup rsv right now */
-		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
+		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
 			return ERR_PTR(ret);
 	} else {
@@ -164,7 +165,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 		 * The ordered extent has reserved qgroup space, release now
 		 * and pass the reserved number for qgroup_record to free.
 		 */
-		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
+		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
 			return ERR_PTR(ret);
 	}
@@ -182,7 +183,7 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
-	entry->qgroup_rsv = ret;
+	entry->qgroup_rsv = qgroup_rsv;
 	entry->flags = flags;
 	refcount_set(&entry->refs, 1);
 	init_waitqueue_head(&entry->wait);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ce446d9d7f23..a953c16c7eb8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4057,13 +4057,14 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 
 /* Free ranges specified by @reserved, normally in error path */
 static int qgroup_free_reserved_data(struct btrfs_inode *inode,
-			struct extent_changeset *reserved, u64 start, u64 len)
+				     struct extent_changeset *reserved,
+				     u64 start, u64 len, u64 *freed_ret)
 {
 	struct btrfs_root *root = inode->root;
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
 	struct extent_changeset changeset;
-	int freed = 0;
+	u64 freed = 0;
 	int ret;
 
 	extent_changeset_init(&changeset);
@@ -4104,7 +4105,9 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 	}
 	btrfs_qgroup_free_refroot(root->fs_info, root->root_key.objectid, freed,
 				  BTRFS_QGROUP_RSV_DATA);
-	ret = freed;
+	if (freed_ret)
+		*freed_ret = freed;
+	ret = 0;
 out:
 	extent_changeset_release(&changeset);
 	return ret;
@@ -4112,7 +4115,7 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 
 static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len,
-			int free)
+			u64 *released, int free)
 {
 	struct extent_changeset changeset;
 	int trace_op = QGROUP_RELEASE;
@@ -4128,7 +4131,7 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 	/* In release case, we shouldn't have @reserved */
 	WARN_ON(!free && reserved);
 	if (free && reserved)
-		return qgroup_free_reserved_data(inode, reserved, start, len);
+		return qgroup_free_reserved_data(inode, reserved, start, len, released);
 	extent_changeset_init(&changeset);
 	ret = clear_record_extent_bits(&inode->io_tree, start, start + len -1,
 				       EXTENT_QGROUP_RESERVED, &changeset);
@@ -4143,7 +4146,8 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 		btrfs_qgroup_free_refroot(inode->root->fs_info,
 				inode->root->root_key.objectid,
 				changeset.bytes_changed, BTRFS_QGROUP_RSV_DATA);
-	ret = changeset.bytes_changed;
+	if (released)
+		*released = changeset.bytes_changed;
 out:
 	extent_changeset_release(&changeset);
 	return ret;
@@ -4162,9 +4166,10 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
  * NOTE: This function may sleep for memory allocation.
  */
 int btrfs_qgroup_free_data(struct btrfs_inode *inode,
-			struct extent_changeset *reserved, u64 start, u64 len)
+			   struct extent_changeset *reserved,
+			   u64 start, u64 len, u64 *freed)
 {
-	return __btrfs_qgroup_release_data(inode, reserved, start, len, 1);
+	return __btrfs_qgroup_release_data(inode, reserved, start, len, freed, 1);
 }
 
 /*
@@ -4182,9 +4187,9 @@ int btrfs_qgroup_free_data(struct btrfs_inode *inode,
  *
  * NOTE: This function may sleep for memory allocation.
  */
-int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len)
+int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len, u64 *released)
 {
-	return __btrfs_qgroup_release_data(inode, NULL, start, len, 0);
+	return __btrfs_qgroup_release_data(inode, NULL, start, len, released, 0);
 }
 
 static void add_root_meta_rsv(struct btrfs_root *root, int num_bytes,
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 855a4f978761..15b485506104 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -358,10 +358,10 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 /* New io_tree based accurate qgroup reserve API */
 int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
-int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len);
+int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len, u64 *released);
 int btrfs_qgroup_free_data(struct btrfs_inode *inode,
 			   struct extent_changeset *reserved, u64 start,
-			   u64 len);
+			   u64 len, u64 *freed);
 int btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 			      enum btrfs_qgroup_rsv_type type, bool enforce);
 int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,


