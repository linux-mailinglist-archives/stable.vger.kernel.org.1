Return-Path: <stable+bounces-7393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A993817256
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A624F1F23F07
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A193786C;
	Mon, 18 Dec 2023 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t42bLf6o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2942387;
	Mon, 18 Dec 2023 14:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18239C433C7;
	Mon, 18 Dec 2023 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908350;
	bh=nAhMKVVEqpBXdZoFilqWJtq529iYpex9HXGBoCyjO2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t42bLf6oEDRUtra9iUWzgbdIBIzlBCR96NTRK02aNROyRGVbON2ec0CU4oLsORnV5
	 vEw5XgigahWIW5+GVTZLUC5djExIU7yUNJ1tBec5uYeSYg7gyw3jeMWBE8Q9tQRBPU
	 TSLaqlEo8YWywAzgFxw0OGPc94ITKsBBqsnQVDlI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 144/166] btrfs: fix qgroup_free_reserved_data int overflow
Date: Mon, 18 Dec 2023 14:51:50 +0100
Message-ID: <20231218135111.564907318@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

From: Boris Burkov <boris@bur.io>

commit 9e65bfca24cf1d77e4a5c7a170db5867377b3fe7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/delalloc-space.c |    2 +-
 fs/btrfs/file.c           |    2 +-
 fs/btrfs/inode.c          |   16 ++++++++--------
 fs/btrfs/ordered-data.c   |    7 ++++---
 fs/btrfs/qgroup.c         |   25 +++++++++++++++----------
 fs/btrfs/qgroup.h         |    4 ++--
 6 files changed, 31 insertions(+), 25 deletions(-)

--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -199,7 +199,7 @@ void btrfs_free_reserved_data_space(stru
 	start = round_down(start, fs_info->sectorsize);
 
 	btrfs_free_reserved_data_space_noquota(fs_info, len);
-	btrfs_qgroup_free_data(inode, reserved, start, len);
+	btrfs_qgroup_free_data(inode, reserved, start, len, NULL);
 }
 
 /*
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3187,7 +3187,7 @@ static long btrfs_fallocate(struct file
 			qgroup_reserved -= range->len;
 		} else if (qgroup_reserved > 0) {
 			btrfs_qgroup_free_data(BTRFS_I(inode), data_reserved,
-					       range->start, range->len);
+					       range->start, range->len, NULL);
 			qgroup_reserved -= range->len;
 		}
 		list_del(&range->list);
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -687,7 +687,7 @@ out:
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE);
+	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
@@ -5129,7 +5129,7 @@ static void evict_inode_truncate_pages(s
 		 */
 		if (state_flags & EXTENT_DELALLOC)
 			btrfs_qgroup_free_data(BTRFS_I(inode), NULL, start,
-					       end - start + 1);
+					       end - start + 1, NULL);
 
 		clear_extent_bit(io_tree, start, end,
 				 EXTENT_CLEAR_ALL_BITS | EXTENT_DO_ACCOUNTING,
@@ -8051,7 +8051,7 @@ next:
 		 *    reserved data space.
 		 *    Since the IO will never happen for this page.
 		 */
-		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur);
+		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur, NULL);
 		if (!inode_evicting) {
 			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_UPTODATE |
@@ -9481,7 +9481,7 @@ static struct btrfs_trans_handle *insert
 	struct btrfs_path *path;
 	u64 start = ins->objectid;
 	u64 len = ins->offset;
-	int qgroup_released;
+	u64 qgroup_released = 0;
 	int ret;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
@@ -9494,9 +9494,9 @@ static struct btrfs_trans_handle *insert
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
@@ -10391,7 +10391,7 @@ out_delalloc_release:
 	btrfs_delalloc_release_metadata(inode, disk_num_bytes, ret < 0);
 out_qgroup_free_data:
 	if (ret < 0)
-		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes);
+		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes, NULL);
 out_free_data_space:
 	/*
 	 * If btrfs_reserve_extent() succeeded, then we already decremented
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -153,11 +153,12 @@ static struct btrfs_ordered_extent *allo
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
@@ -165,7 +166,7 @@ static struct btrfs_ordered_extent *allo
 		 * The ordered extent has reserved qgroup space, release now
 		 * and pass the reserved number for qgroup_record to free.
 		 */
-		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
+		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
 			return ERR_PTR(ret);
 	}
@@ -183,7 +184,7 @@ static struct btrfs_ordered_extent *allo
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
-	entry->qgroup_rsv = ret;
+	entry->qgroup_rsv = qgroup_rsv;
 	entry->flags = flags;
 	refcount_set(&entry->refs, 1);
 	init_waitqueue_head(&entry->wait);
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3855,13 +3855,14 @@ int btrfs_qgroup_reserve_data(struct btr
 
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
@@ -3902,7 +3903,9 @@ static int qgroup_free_reserved_data(str
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
@@ -3910,7 +3913,7 @@ out:
 
 static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len,
-			int free)
+			u64 *released, int free)
 {
 	struct extent_changeset changeset;
 	int trace_op = QGROUP_RELEASE;
@@ -3922,7 +3925,7 @@ static int __btrfs_qgroup_release_data(s
 	/* In release case, we shouldn't have @reserved */
 	WARN_ON(!free && reserved);
 	if (free && reserved)
-		return qgroup_free_reserved_data(inode, reserved, start, len);
+		return qgroup_free_reserved_data(inode, reserved, start, len, released);
 	extent_changeset_init(&changeset);
 	ret = clear_record_extent_bits(&inode->io_tree, start, start + len -1,
 				       EXTENT_QGROUP_RESERVED, &changeset);
@@ -3937,7 +3940,8 @@ static int __btrfs_qgroup_release_data(s
 		btrfs_qgroup_free_refroot(inode->root->fs_info,
 				inode->root->root_key.objectid,
 				changeset.bytes_changed, BTRFS_QGROUP_RSV_DATA);
-	ret = changeset.bytes_changed;
+	if (released)
+		*released = changeset.bytes_changed;
 out:
 	extent_changeset_release(&changeset);
 	return ret;
@@ -3956,9 +3960,10 @@ out:
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
@@ -3976,9 +3981,9 @@ int btrfs_qgroup_free_data(struct btrfs_
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
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -363,10 +363,10 @@ int btrfs_verify_qgroup_counts(struct bt
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



