Return-Path: <stable+bounces-162207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE5CB05C8C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A4E4A0CDF
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20222E6106;
	Tue, 15 Jul 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Si6+UrCC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE492D8790;
	Tue, 15 Jul 2025 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585954; cv=none; b=FFJ5A4inOayozl1U+r7XDnd2mosmihKLkGZ9yr5dB83DHWL3V7U55zHdAeKaxSPy2wTjetNO3PRYP6EqRTTXADykwsl0NGxGVNEj4oL3JEcAJwUHM74TIwBLzg5fiDIbLFBYHqaodSC+yLB2ptbS/zRhb5lwQLQT8PREzoPFJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585954; c=relaxed/simple;
	bh=3Aob5wlgTUh/BEpo7+aQyMVu/A+XU1XU9ruUACADKPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+kucZtNy7FSC6Fkfq+cbJi/DbIg3qbRSJf8a7Uw4WPmtqSp9Hrd1wU8M4PQW1gz8haCJ/r2xSr9G8stcQCCB1SIlSwqMJacK8ZQWDottNFHhbzk5LRk+BXuyMFWREICyolNGXHRGxN7sHhSh5hB8kGIyb0IKnast18I5gwvuT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Si6+UrCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D38C4CEE3;
	Tue, 15 Jul 2025 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585954;
	bh=3Aob5wlgTUh/BEpo7+aQyMVu/A+XU1XU9ruUACADKPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Si6+UrCC7p2lw3dyidQQrA/ermXU5i3u2M2eVm7LjpOo1acLH2XfpfxftOa7IJiKl
	 69I/qt2/RU2wcA2KEQF0E1KU4jUhn+YNCwsYldVfX8paDl29F1zcTKPr/5X4SbiBoe
	 ja7BIYni25FxHXjIa0Y+UYvefCBDvCClIP9lqEiU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 069/109] btrfs: return a btrfs_inode from btrfs_iget_logging()
Date: Tue, 15 Jul 2025 15:13:25 +0200
Message-ID: <20250715130801.644739580@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130758.864940641@linuxfoundation.org>
References: <20250715130758.864940641@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a488d8ac2c4d96ecc7da59bb35a573277204ac6b ]

All callers of btrfs_iget_logging() are interested in the btrfs_inode
structure rather than the VFS inode, so make btrfs_iget_logging() return
the btrfs_inode instead, avoiding lots of BTRFS_I() calls.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 5f61b961599a ("btrfs: fix inode lookup error handling during log replay")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-log.c | 94 ++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a17942f4c155b..f846dcbd70756 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -140,7 +140,7 @@ static void wait_log_commit(struct btrfs_root *root, int transid);
  * and once to do all the other items.
  */
 
-static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
+static struct btrfs_inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 {
 	unsigned int nofs_flag;
 	struct inode *inode;
@@ -156,7 +156,10 @@ static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 	inode = btrfs_iget(root->fs_info->sb, objectid, root);
 	memalloc_nofs_restore(nofs_flag);
 
-	return inode;
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	return BTRFS_I(inode);
 }
 
 /*
@@ -620,12 +623,12 @@ static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
 static noinline struct inode *read_one_inode(struct btrfs_root *root,
 					     u64 objectid)
 {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	inode = btrfs_iget_logging(objectid, root);
 	if (IS_ERR(inode))
-		inode = NULL;
-	return inode;
+		return NULL;
+	return &inode->vfs_inode;
 }
 
 /* replays a single extent in 'eb' at 'slot' with 'key' into the
@@ -5419,7 +5422,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	ihold(&curr_inode->vfs_inode);
 
 	while (true) {
-		struct inode *vfs_inode;
 		struct btrfs_key key;
 		struct btrfs_key found_key;
 		u64 next_index;
@@ -5435,7 +5437,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			struct extent_buffer *leaf = path->nodes[0];
 			struct btrfs_dir_item *di;
 			struct btrfs_key di_key;
-			struct inode *di_inode;
+			struct btrfs_inode *di_inode;
 			int log_mode = LOG_INODE_EXISTS;
 			int type;
 
@@ -5462,17 +5464,16 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 
-			if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-				btrfs_add_delayed_iput(BTRFS_I(di_inode));
+			if (!need_log_inode(trans, di_inode)) {
+				btrfs_add_delayed_iput(di_inode);
 				break;
 			}
 
 			ctx->log_new_dentries = false;
 			if (type == BTRFS_FT_DIR)
 				log_mode = LOG_INODE_ALL;
-			ret = btrfs_log_inode(trans, BTRFS_I(di_inode),
-					      log_mode, ctx);
-			btrfs_add_delayed_iput(BTRFS_I(di_inode));
+			ret = btrfs_log_inode(trans, di_inode, log_mode, ctx);
+			btrfs_add_delayed_iput(di_inode);
 			if (ret)
 				goto out;
 			if (ctx->log_new_dentries) {
@@ -5514,14 +5515,13 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 		kfree(dir_elem);
 
 		btrfs_add_delayed_iput(curr_inode);
-		curr_inode = NULL;
 
-		vfs_inode = btrfs_iget_logging(ino, root);
-		if (IS_ERR(vfs_inode)) {
-			ret = PTR_ERR(vfs_inode);
+		curr_inode = btrfs_iget_logging(ino, root);
+		if (IS_ERR(curr_inode)) {
+			ret = PTR_ERR(curr_inode);
+			curr_inode = NULL;
 			break;
 		}
-		curr_inode = BTRFS_I(vfs_inode);
 	}
 out:
 	btrfs_free_path(path);
@@ -5599,7 +5599,7 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 				 struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_ino_list *ino_elem;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	/*
 	 * It's rare to have a lot of conflicting inodes, in practice it is not
@@ -5690,12 +5690,12 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 	 * inode in LOG_INODE_EXISTS mode and rename operations update the log,
 	 * so that the log ends up with the new name and without the old name.
 	 */
-	if (!need_log_inode(trans, BTRFS_I(inode))) {
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+	if (!need_log_inode(trans, inode)) {
+		btrfs_add_delayed_iput(inode);
 		return 0;
 	}
 
-	btrfs_add_delayed_iput(BTRFS_I(inode));
+	btrfs_add_delayed_iput(inode);
 
 	ino_elem = kmalloc(sizeof(*ino_elem), GFP_NOFS);
 	if (!ino_elem)
@@ -5731,7 +5731,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 	 */
 	while (!list_empty(&ctx->conflict_inodes)) {
 		struct btrfs_ino_list *curr;
-		struct inode *inode;
+		struct btrfs_inode *inode;
 		u64 ino;
 		u64 parent;
 
@@ -5767,9 +5767,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			 * dir index key range logged for the directory. So we
 			 * must make sure the deletion is recorded.
 			 */
-			ret = btrfs_log_inode(trans, BTRFS_I(inode),
-					      LOG_INODE_ALL, ctx);
-			btrfs_add_delayed_iput(BTRFS_I(inode));
+			ret = btrfs_log_inode(trans, inode, LOG_INODE_ALL, ctx);
+			btrfs_add_delayed_iput(inode);
 			if (ret)
 				break;
 			continue;
@@ -5785,8 +5784,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * it again because if some other task logged the inode after
 		 * that, we can avoid doing it again.
 		 */
-		if (!need_log_inode(trans, BTRFS_I(inode))) {
-			btrfs_add_delayed_iput(BTRFS_I(inode));
+		if (!need_log_inode(trans, inode)) {
+			btrfs_add_delayed_iput(inode);
 			continue;
 		}
 
@@ -5797,8 +5796,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * well because during a rename we pin the log and update the
 		 * log with the new name before we unpin it.
 		 */
-		ret = btrfs_log_inode(trans, BTRFS_I(inode), LOG_INODE_EXISTS, ctx);
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+		ret = btrfs_log_inode(trans, inode, LOG_INODE_EXISTS, ctx);
+		btrfs_add_delayed_iput(inode);
 		if (ret)
 			break;
 	}
@@ -6290,7 +6289,7 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 
 	list_for_each_entry(item, delayed_ins_list, log_list) {
 		struct btrfs_dir_item *dir_item;
-		struct inode *di_inode;
+		struct btrfs_inode *di_inode;
 		struct btrfs_key key;
 		int log_mode = LOG_INODE_EXISTS;
 
@@ -6306,8 +6305,8 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-			btrfs_add_delayed_iput(BTRFS_I(di_inode));
+		if (!need_log_inode(trans, di_inode)) {
+			btrfs_add_delayed_iput(di_inode);
 			continue;
 		}
 
@@ -6315,12 +6314,12 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 			log_mode = LOG_INODE_ALL;
 
 		ctx->log_new_dentries = false;
-		ret = btrfs_log_inode(trans, BTRFS_I(di_inode), log_mode, ctx);
+		ret = btrfs_log_inode(trans, di_inode, log_mode, ctx);
 
 		if (!ret && ctx->log_new_dentries)
-			ret = log_new_dir_dentries(trans, BTRFS_I(di_inode), ctx);
+			ret = log_new_dir_dentries(trans, di_inode, ctx);
 
-		btrfs_add_delayed_iput(BTRFS_I(di_inode));
+		btrfs_add_delayed_iput(di_inode);
 
 		if (ret)
 			break;
@@ -6728,7 +6727,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 		ptr = btrfs_item_ptr_offset(leaf, slot);
 		while (cur_offset < item_size) {
 			struct btrfs_key inode_key;
-			struct inode *dir_inode;
+			struct btrfs_inode *dir_inode;
 
 			inode_key.type = BTRFS_INODE_ITEM_KEY;
 			inode_key.offset = 0;
@@ -6777,18 +6776,16 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 
-			if (!need_log_inode(trans, BTRFS_I(dir_inode))) {
-				btrfs_add_delayed_iput(BTRFS_I(dir_inode));
+			if (!need_log_inode(trans, dir_inode)) {
+				btrfs_add_delayed_iput(dir_inode);
 				continue;
 			}
 
 			ctx->log_new_dentries = false;
-			ret = btrfs_log_inode(trans, BTRFS_I(dir_inode),
-					      LOG_INODE_ALL, ctx);
+			ret = btrfs_log_inode(trans, dir_inode, LOG_INODE_ALL, ctx);
 			if (!ret && ctx->log_new_dentries)
-				ret = log_new_dir_dentries(trans,
-						   BTRFS_I(dir_inode), ctx);
-			btrfs_add_delayed_iput(BTRFS_I(dir_inode));
+				ret = log_new_dir_dentries(trans, dir_inode, ctx);
+			btrfs_add_delayed_iput(dir_inode);
 			if (ret)
 				goto out;
 		}
@@ -6813,7 +6810,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		struct extent_buffer *leaf;
 		int slot;
 		struct btrfs_key search_key;
-		struct inode *inode;
+		struct btrfs_inode *inode;
 		u64 ino;
 		int ret = 0;
 
@@ -6828,11 +6825,10 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
-		if (BTRFS_I(inode)->generation >= trans->transid &&
-		    need_log_inode(trans, BTRFS_I(inode)))
-			ret = btrfs_log_inode(trans, BTRFS_I(inode),
-					      LOG_INODE_EXISTS, ctx);
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+		if (inode->generation >= trans->transid &&
+		    need_log_inode(trans, inode))
+			ret = btrfs_log_inode(trans, inode, LOG_INODE_EXISTS, ctx);
+		btrfs_add_delayed_iput(inode);
 		if (ret)
 			return ret;
 
-- 
2.39.5




