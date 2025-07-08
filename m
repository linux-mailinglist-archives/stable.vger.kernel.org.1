Return-Path: <stable+bounces-160789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465FFAFD1E0
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BD4487CAD
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACDF2E3B03;
	Tue,  8 Jul 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d3x3TK9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4241CD1E4;
	Tue,  8 Jul 2025 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992695; cv=none; b=iQyr38qYZJzLJHmdsYYJ8Gdn5egAEtKvP30BWYUQ5pYNd5cG1c3sstEgiBsbr+CAbnVkb9muedjad7jFwBHJGVxdY9tTuPN37mr2BbXGx3Iz0as18OmgVe4LAVVBlALPxfQRGo94LOjZqpNamkfuVsG87dcuoeQ2vYdComz45GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992695; c=relaxed/simple;
	bh=e9CUZDJJvIRsliUQeGh5enbu6DcNbmfJNyMSi6pbeoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6HX3bMsb//FY8Pd/yl03I7/60Ac+jDEf8udZDS5t4pigMskWGecpLYmt35I5QI+8MvigUfyzKQuBYlKzIXxP38Tp2lCWVk81HOEijucdwrwAl/Sx409TRWa5bWzGV9/ILHx4P0dKVi9EuzoKukHBW/3Db53Lk6z5z6SAkue5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d3x3TK9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26776C4CEED;
	Tue,  8 Jul 2025 16:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992695;
	bh=e9CUZDJJvIRsliUQeGh5enbu6DcNbmfJNyMSi6pbeoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d3x3TK9HJIDx3FWM8xxS74+0WZsLiUVQ5haualPqMtpBiqOij8ZUsPVTLKMaywIEq
	 IHYvEqJLx8SImvGft1WPQGqwsTfRCgUWq0WvvPPkKMJ6uTBQKQncuOn7x+S5ZWwaEB
	 suDYaYeWeQ+P4Eb4pl3IaWArihyd0L66n1YFIiTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 049/232] btrfs: return a btrfs_inode from btrfs_iget_logging()
Date: Tue,  8 Jul 2025 18:20:45 +0200
Message-ID: <20250708162242.748583851@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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
index 3ecab032907e7..262523cd80476 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -138,7 +138,7 @@ static void wait_log_commit(struct btrfs_root *root, int transid);
  * and once to do all the other items.
  */
 
-static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
+static struct btrfs_inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 {
 	unsigned int nofs_flag;
 	struct inode *inode;
@@ -154,7 +154,10 @@ static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 	inode = btrfs_iget(objectid, root);
 	memalloc_nofs_restore(nofs_flag);
 
-	return inode;
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	return BTRFS_I(inode);
 }
 
 /*
@@ -617,12 +620,12 @@ static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
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
@@ -5487,7 +5490,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	ihold(&curr_inode->vfs_inode);
 
 	while (true) {
-		struct inode *vfs_inode;
 		struct btrfs_key key;
 		struct btrfs_key found_key;
 		u64 next_index;
@@ -5503,7 +5505,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			struct extent_buffer *leaf = path->nodes[0];
 			struct btrfs_dir_item *di;
 			struct btrfs_key di_key;
-			struct inode *di_inode;
+			struct btrfs_inode *di_inode;
 			int log_mode = LOG_INODE_EXISTS;
 			int type;
 
@@ -5530,17 +5532,16 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
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
@@ -5582,14 +5583,13 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
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
@@ -5667,7 +5667,7 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 				 struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_ino_list *ino_elem;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	/*
 	 * It's rare to have a lot of conflicting inodes, in practice it is not
@@ -5758,12 +5758,12 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
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
@@ -5799,7 +5799,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 	 */
 	while (!list_empty(&ctx->conflict_inodes)) {
 		struct btrfs_ino_list *curr;
-		struct inode *inode;
+		struct btrfs_inode *inode;
 		u64 ino;
 		u64 parent;
 
@@ -5835,9 +5835,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
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
@@ -5853,8 +5852,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * it again because if some other task logged the inode after
 		 * that, we can avoid doing it again.
 		 */
-		if (!need_log_inode(trans, BTRFS_I(inode))) {
-			btrfs_add_delayed_iput(BTRFS_I(inode));
+		if (!need_log_inode(trans, inode)) {
+			btrfs_add_delayed_iput(inode);
 			continue;
 		}
 
@@ -5865,8 +5864,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
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
@@ -6358,7 +6357,7 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 
 	list_for_each_entry(item, delayed_ins_list, log_list) {
 		struct btrfs_dir_item *dir_item;
-		struct inode *di_inode;
+		struct btrfs_inode *di_inode;
 		struct btrfs_key key;
 		int log_mode = LOG_INODE_EXISTS;
 
@@ -6374,8 +6373,8 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-			btrfs_add_delayed_iput(BTRFS_I(di_inode));
+		if (!need_log_inode(trans, di_inode)) {
+			btrfs_add_delayed_iput(di_inode);
 			continue;
 		}
 
@@ -6383,12 +6382,12 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
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
@@ -6796,7 +6795,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 		ptr = btrfs_item_ptr_offset(leaf, slot);
 		while (cur_offset < item_size) {
 			struct btrfs_key inode_key;
-			struct inode *dir_inode;
+			struct btrfs_inode *dir_inode;
 
 			inode_key.type = BTRFS_INODE_ITEM_KEY;
 			inode_key.offset = 0;
@@ -6845,18 +6844,16 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
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
@@ -6881,7 +6878,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		struct extent_buffer *leaf;
 		int slot;
 		struct btrfs_key search_key;
-		struct inode *inode;
+		struct btrfs_inode *inode;
 		u64 ino;
 		int ret = 0;
 
@@ -6896,11 +6893,10 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
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




