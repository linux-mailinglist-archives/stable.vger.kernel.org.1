Return-Path: <stable+bounces-10296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FD2827440
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC1F2877AF
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BE454BCB;
	Mon,  8 Jan 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PECSgyX2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B5524C2;
	Mon,  8 Jan 2024 15:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B44C43391;
	Mon,  8 Jan 2024 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728600;
	bh=jcfxSyl6D2KAMsf2Y3qaGYmT9zWCsIFCOe2rWGP5zrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PECSgyX2ic3PGr6CjBqcVq4Zm3NowLy0r/CcicT0jEtOOnHQZshCgMuWA9kDIJVte
	 rSPwdJz7jTCHcHXv82SKqKRbt7X4bugjkgJNnU4zx1Sv552xCzYgPxTBnVUM/QwlLJ
	 LLdh4rNesk/MI+jN5HJMsraSvTmNoPJpa6/MXKHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 129/150] btrfs: fix qgroup_free_reserved_data int overflow
Date: Mon,  8 Jan 2024 16:36:20 +0100
Message-ID: <20240108153517.127336093@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

From: Boris Burkov <boris@bur.io>

[ Upstream commit 9e65bfca24cf1d77e4a5c7a170db5867377b3fe7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delalloc-space.c |  2 +-
 fs/btrfs/file.c           |  2 +-
 fs/btrfs/inode.c          | 16 ++++++++--------
 fs/btrfs/ordered-data.c   |  7 ++++---
 fs/btrfs/qgroup.c         | 25 +++++++++++++++----------
 fs/btrfs/qgroup.h         |  4 ++--
 6 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 0b62ce77053f5..f2bc5563c0f92 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -197,7 +197,7 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 	start = round_down(start, fs_info->sectorsize);
 
 	btrfs_free_reserved_data_space_noquota(fs_info, len);
-	btrfs_qgroup_free_data(inode, reserved, start, len);
+	btrfs_qgroup_free_data(inode, reserved, start, len, NULL);
 }
 
 /**
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0a46fff3dd067..1783a0fbf1665 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3191,7 +3191,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 			qgroup_reserved -= range->len;
 		} else if (qgroup_reserved > 0) {
 			btrfs_qgroup_free_data(BTRFS_I(inode), data_reserved,
-					       range->start, range->len);
+					       range->start, range->len, NULL);
 			qgroup_reserved -= range->len;
 		}
 		list_del(&range->list);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 81eac121c6b23..9a7d77c410e22 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -466,7 +466,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	 * And at reserve time, it's always aligned to page size, so
 	 * just free one page here.
 	 */
-	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE);
+	btrfs_qgroup_free_data(inode, NULL, 0, PAGE_SIZE, NULL);
 	btrfs_free_path(path);
 	btrfs_end_transaction(trans);
 	return ret;
@@ -5372,7 +5372,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 		 */
 		if (state_flags & EXTENT_DELALLOC)
 			btrfs_qgroup_free_data(BTRFS_I(inode), NULL, start,
-					       end - start + 1);
+					       end - start + 1, NULL);
 
 		clear_extent_bit(io_tree, start, end,
 				 EXTENT_CLEAR_ALL_BITS | EXTENT_DO_ACCOUNTING,
@@ -8440,7 +8440,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 		 *    reserved data space.
 		 *    Since the IO will never happen for this page.
 		 */
-		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur);
+		btrfs_qgroup_free_data(inode, NULL, cur, range_end + 1 - cur, NULL);
 		if (!inode_evicting) {
 			clear_extent_bit(tree, cur, range_end, EXTENT_LOCKED |
 				 EXTENT_DELALLOC | EXTENT_UPTODATE |
@@ -9902,7 +9902,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	struct btrfs_path *path;
 	u64 start = ins->objectid;
 	u64 len = ins->offset;
-	int qgroup_released;
+	u64 qgroup_released = 0;
 	int ret;
 
 	memset(&stack_fi, 0, sizeof(stack_fi));
@@ -9915,9 +9915,9 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
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
@@ -10903,7 +10903,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	btrfs_delalloc_release_metadata(inode, disk_num_bytes, ret < 0);
 out_qgroup_free_data:
 	if (ret < 0)
-		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes);
+		btrfs_qgroup_free_data(inode, data_reserved, start, num_bytes, NULL);
 out_free_data_space:
 	/*
 	 * If btrfs_reserve_extent() succeeded, then we already decremented
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 0321753c16b9f..1b2af4785c0e2 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -172,11 +172,12 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry;
 	int ret;
+	u64 qgroup_rsv = 0;
 
 	if (flags &
 	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
 		/* For nocow write, we can release the qgroup rsv right now */
-		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
+		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
 			return ret;
 		ret = 0;
@@ -185,7 +186,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 		 * The ordered extent has reserved qgroup space, release now
 		 * and pass the reserved number for qgroup_record to free.
 		 */
-		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes);
+		ret = btrfs_qgroup_release_data(inode, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
 			return ret;
 	}
@@ -203,7 +204,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
 	entry->inode = igrab(&inode->vfs_inode);
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
-	entry->qgroup_rsv = ret;
+	entry->qgroup_rsv = qgroup_rsv;
 	entry->physical = (u64)-1;
 
 	ASSERT((flags & ~BTRFS_ORDERED_TYPE_FLAGS) == 0);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 26cabffd59710..96ec9ccc2ef61 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3833,13 +3833,14 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 
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
@@ -3880,7 +3881,9 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
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
@@ -3888,7 +3891,7 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 
 static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len,
-			int free)
+			u64 *released, int free)
 {
 	struct extent_changeset changeset;
 	int trace_op = QGROUP_RELEASE;
@@ -3900,7 +3903,7 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 	/* In release case, we shouldn't have @reserved */
 	WARN_ON(!free && reserved);
 	if (free && reserved)
-		return qgroup_free_reserved_data(inode, reserved, start, len);
+		return qgroup_free_reserved_data(inode, reserved, start, len, released);
 	extent_changeset_init(&changeset);
 	ret = clear_record_extent_bits(&inode->io_tree, start, start + len -1,
 				       EXTENT_QGROUP_RESERVED, &changeset);
@@ -3915,7 +3918,8 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 		btrfs_qgroup_free_refroot(inode->root->fs_info,
 				inode->root->root_key.objectid,
 				changeset.bytes_changed, BTRFS_QGROUP_RSV_DATA);
-	ret = changeset.bytes_changed;
+	if (released)
+		*released = changeset.bytes_changed;
 out:
 	extent_changeset_release(&changeset);
 	return ret;
@@ -3934,9 +3938,10 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
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
@@ -3954,9 +3959,9 @@ int btrfs_qgroup_free_data(struct btrfs_inode *inode,
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
index 578c77e94200f..c382923f7628e 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -360,10 +360,10 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
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
-- 
2.43.0




