Return-Path: <stable+bounces-107430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E0A02BD0
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B2B1886A91
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B816A930;
	Mon,  6 Jan 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R4Imf/bh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7361917E9;
	Mon,  6 Jan 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178439; cv=none; b=V8Mz5pnp5leljWdYoHz9Aw2Sens93AnFi725Eyu7pZzXgDX+50qPEzhO2PbVsjRTvznOypSmbFSSScU/0B0TyrCPYr924a2jLHjBCKGgkA5tx1NO3fky3pb3aGRsr6g55QcYx9MFm99kYBPzQlrj3eRByqtF8Ao3Ugqxzyw2F0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178439; c=relaxed/simple;
	bh=7zuglu9cTGbFjrMGyQV2GfZRMFFLXAXS9cdA5cmnI9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl9WZJ8jOWfFSZ4cjeS8r9/mk0L3ZhBSNbkhixbLTApRY2Ju6VLsoujYCZ0bb+HrTD3lRJIjlMgVIpcM9yp0vZCl0ASoaHghnpNbID8cUMSVZQ1Ke7w6dgCrtHHzw0uf86h2FGpAvmQRHoLJXLHEqRAoxeC+kGz71/KfT4XQ8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R4Imf/bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9233AC4CED2;
	Mon,  6 Jan 2025 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178439;
	bh=7zuglu9cTGbFjrMGyQV2GfZRMFFLXAXS9cdA5cmnI9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4Imf/bhUn6eWmmZTRN7HPOiL9LtQzwBjfXoSCwH1QqU0olRoShl8Hbd6D2PUjg3g
	 yxxi3URDp0knojpeLnWPszdLqZ//annBYlECiSjMwaHCmKb2Vs2g3c3aQmqSVYhwmG
	 XRehyDYZfjbIK9VGXPQoUcUSB2vrVNKSln45yXMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 117/138] btrfs: locking: remove all the blocking helpers
Date: Mon,  6 Jan 2025 16:17:21 +0100
Message-ID: <20250106151137.659642453@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151133.209718681@linuxfoundation.org>
References: <20250106151133.209718681@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit ac5887c8e013d6754d36e6d51dc03448ee0b0065 ]

Now that we're using a rw_semaphore we no longer need to indicate if a
lock is blocking or not, nor do we need to flip the entire path from
blocking to spinning.  Remove these helpers and all the places they are
called.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 44f52bbe96df ("btrfs: fix use-after-free when COWing tree bock and tracing is enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/backref.c       | 10 ++---
 fs/btrfs/ctree.c         | 91 ++++++----------------------------------
 fs/btrfs/delayed-inode.c |  7 ----
 fs/btrfs/disk-io.c       |  8 +---
 fs/btrfs/extent-tree.c   | 19 +++------
 fs/btrfs/file.c          |  3 +-
 fs/btrfs/inode.c         |  1 -
 fs/btrfs/locking.c       | 74 --------------------------------
 fs/btrfs/locking.h       | 11 +----
 fs/btrfs/qgroup.c        |  9 ++--
 fs/btrfs/ref-verify.c    |  6 +--
 fs/btrfs/relocation.c    |  4 --
 fs/btrfs/transaction.c   |  2 -
 fs/btrfs/tree-defrag.c   |  1 -
 fs/btrfs/tree-log.c      |  3 --
 15 files changed, 30 insertions(+), 219 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f1731eeb86a7..e68970674344 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1382,14 +1382,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 					goto out;
 				}
 
-				if (!path->skip_locking) {
+				if (!path->skip_locking)
 					btrfs_tree_read_lock(eb);
-					btrfs_set_lock_blocking_read(eb);
-				}
 				ret = find_extent_in_eb(eb, bytenr,
 							*extent_item_pos, &eie, ignore_offset);
 				if (!path->skip_locking)
-					btrfs_tree_read_unlock_blocking(eb);
+					btrfs_tree_read_unlock(eb);
 				free_extent_buffer(eb);
 				if (ret < 0)
 					goto out;
@@ -1732,7 +1730,7 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 					   name_off, name_len);
 		if (eb != eb_in) {
 			if (!path->skip_locking)
-				btrfs_tree_read_unlock_blocking(eb);
+				btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 		}
 		ret = btrfs_find_item(fs_root, path, parent, 0,
@@ -1752,8 +1750,6 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
 		eb = path->nodes[0];
 		/* make sure we can use eb after releasing the path */
 		if (eb != eb_in) {
-			if (!path->skip_locking)
-				btrfs_set_lock_blocking_read(eb);
 			path->nodes[0] = NULL;
 			path->locks[0] = 0;
 		}
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 814f2f07e74c..c71b02beb358 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1281,14 +1281,11 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	if (!tm)
 		return eb;
 
-	btrfs_set_path_blocking(path);
-	btrfs_set_lock_blocking_read(eb);
-
 	if (tm->op == MOD_LOG_KEY_REMOVE_WHILE_FREEING) {
 		BUG_ON(tm->slot != 0);
 		eb_rewin = alloc_dummy_extent_buffer(fs_info, eb->start);
 		if (!eb_rewin) {
-			btrfs_tree_read_unlock_blocking(eb);
+			btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 			return NULL;
 		}
@@ -1300,13 +1297,13 @@ tree_mod_log_rewind(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	} else {
 		eb_rewin = btrfs_clone_extent_buffer(eb);
 		if (!eb_rewin) {
-			btrfs_tree_read_unlock_blocking(eb);
+			btrfs_tree_read_unlock(eb);
 			free_extent_buffer(eb);
 			return NULL;
 		}
 	}
 
-	btrfs_tree_read_unlock_blocking(eb);
+	btrfs_tree_read_unlock(eb);
 	free_extent_buffer(eb);
 
 	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb_rewin),
@@ -1398,9 +1395,8 @@ get_old_root(struct btrfs_root *root, u64 time_seq)
 		free_extent_buffer(eb_root);
 		eb = alloc_dummy_extent_buffer(fs_info, logical);
 	} else {
-		btrfs_set_lock_blocking_read(eb_root);
 		eb = btrfs_clone_extent_buffer(eb_root);
-		btrfs_tree_read_unlock_blocking(eb_root);
+		btrfs_tree_read_unlock(eb_root);
 		free_extent_buffer(eb_root);
 	}
 
@@ -1508,10 +1504,6 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 
 	search_start = buf->start & ~((u64)SZ_1G - 1);
 
-	if (parent)
-		btrfs_set_lock_blocking_write(parent);
-	btrfs_set_lock_blocking_write(buf);
-
 	/*
 	 * Before CoWing this block for later modification, check if it's
 	 * the subtree root and do the delayed subtree trace if needed.
@@ -1629,8 +1621,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	if (parent_nritems <= 1)
 		return 0;
 
-	btrfs_set_lock_blocking_write(parent);
-
 	for (i = start_slot; i <= end_slot; i++) {
 		struct btrfs_key first_key;
 		int close = 1;
@@ -1688,7 +1678,6 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 			search_start = last_block;
 
 		btrfs_tree_lock(cur);
-		btrfs_set_lock_blocking_write(cur);
 		err = __btrfs_cow_block(trans, root, cur, parent, i,
 					&cur, search_start,
 					min(16 * blocksize,
@@ -1860,8 +1849,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 	mid = path->nodes[level];
 
-	WARN_ON(path->locks[level] != BTRFS_WRITE_LOCK &&
-		path->locks[level] != BTRFS_WRITE_LOCK_BLOCKING);
+	WARN_ON(path->locks[level] != BTRFS_WRITE_LOCK);
 	WARN_ON(btrfs_header_generation(mid) != trans->transid);
 
 	orig_ptr = btrfs_node_blockptr(mid, orig_slot);
@@ -1890,7 +1878,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		}
 
 		btrfs_tree_lock(child);
-		btrfs_set_lock_blocking_write(child);
 		ret = btrfs_cow_block(trans, root, child, mid, 0, &child,
 				      BTRFS_NESTING_COW);
 		if (ret) {
@@ -1929,7 +1916,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 	if (left) {
 		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
-		btrfs_set_lock_blocking_write(left);
 		wret = btrfs_cow_block(trans, root, left,
 				       parent, pslot - 1, &left,
 				       BTRFS_NESTING_LEFT_COW);
@@ -1945,7 +1931,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 	if (right) {
 		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
-		btrfs_set_lock_blocking_write(right);
 		wret = btrfs_cow_block(trans, root, right,
 				       parent, pslot + 1, &right,
 				       BTRFS_NESTING_RIGHT_COW);
@@ -2109,7 +2094,6 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		u32 left_nr;
 
 		__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
-		btrfs_set_lock_blocking_write(left);
 
 		left_nr = btrfs_header_nritems(left);
 		if (left_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
@@ -2164,7 +2148,6 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		u32 right_nr;
 
 		__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
-		btrfs_set_lock_blocking_write(right);
 
 		right_nr = btrfs_header_nritems(right);
 		if (right_nr >= BTRFS_NODEPTRS_PER_BLOCK(fs_info) - 1) {
@@ -2424,14 +2407,6 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			return 0;
 		}
 
-		/* the pages were up to date, but we failed
-		 * the generation number check.  Do a full
-		 * read for the generation number that is correct.
-		 * We must do this without dropping locks so
-		 * we can trust our generation number
-		 */
-		btrfs_set_path_blocking(p);
-
 		/* now we're allowed to do a blocking uptodate check */
 		ret = btrfs_read_buffer(tmp, gen, parent_level - 1, &first_key);
 		if (!ret) {
@@ -2451,7 +2426,6 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	 * out which blocks to read.
 	 */
 	btrfs_unlock_up_safe(p, level + 1);
-	btrfs_set_path_blocking(p);
 
 	if (p->reada != READA_NONE)
 		reada_for_search(fs_info, p, level, slot, key->objectid);
@@ -2505,7 +2479,6 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 			goto again;
 		}
 
-		btrfs_set_path_blocking(p);
 		reada_for_balance(fs_info, p, level);
 		sret = split_node(trans, root, p, level);
 
@@ -2525,7 +2498,6 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 			goto again;
 		}
 
-		btrfs_set_path_blocking(p);
 		reada_for_balance(fs_info, p, level);
 		sret = balance_level(trans, root, p, level);
 
@@ -2788,7 +2760,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				goto again;
 			}
 
-			btrfs_set_path_blocking(p);
 			if (last_level)
 				err = btrfs_cow_block(trans, root, b, NULL, 0,
 						      &b,
@@ -2858,7 +2829,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 					goto again;
 				}
 
-				btrfs_set_path_blocking(p);
 				err = split_leaf(trans, root, key,
 						 p, ins_len, ret == 0);
 
@@ -2920,17 +2890,11 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (!p->skip_locking) {
 			level = btrfs_header_level(b);
 			if (level <= write_lock_level) {
-				if (!btrfs_try_tree_write_lock(b)) {
-					btrfs_set_path_blocking(p);
-					btrfs_tree_lock(b);
-				}
+				btrfs_tree_lock(b);
 				p->locks[level] = BTRFS_WRITE_LOCK;
 			} else {
-				if (!btrfs_tree_read_lock_atomic(b)) {
-					btrfs_set_path_blocking(p);
-					__btrfs_tree_read_lock(b, BTRFS_NESTING_NORMAL,
-							       p->recurse);
-				}
+				__btrfs_tree_read_lock(b, BTRFS_NESTING_NORMAL,
+						       p->recurse);
 				p->locks[level] = BTRFS_READ_LOCK;
 			}
 			p->nodes[level] = b;
@@ -2938,12 +2902,6 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	}
 	ret = 1;
 done:
-	/*
-	 * we don't really know what they plan on doing with the path
-	 * from here on, so for now just mark it as blocking
-	 */
-	if (!p->leave_spinning)
-		btrfs_set_path_blocking(p);
 	if (ret < 0 && !p->skip_release_on_error)
 		btrfs_release_path(p);
 	return ret;
@@ -3035,10 +2993,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 		}
 
 		level = btrfs_header_level(b);
-		if (!btrfs_tree_read_lock_atomic(b)) {
-			btrfs_set_path_blocking(p);
-			btrfs_tree_read_lock(b);
-		}
+		btrfs_tree_read_lock(b);
 		b = tree_mod_log_rewind(fs_info, p, b, time_seq);
 		if (!b) {
 			ret = -ENOMEM;
@@ -3049,8 +3004,6 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 	}
 	ret = 1;
 done:
-	if (!p->leave_spinning)
-		btrfs_set_path_blocking(p);
 	if (ret < 0)
 		btrfs_release_path(p);
 
@@ -3477,7 +3430,7 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 	add_root_to_dirty_list(root);
 	atomic_inc(&c->refs);
 	path->nodes[level] = c;
-	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 	path->slots[level] = 0;
 	return 0;
 }
@@ -3852,7 +3805,6 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 1;
 
 	__btrfs_tree_lock(right, BTRFS_NESTING_RIGHT);
-	btrfs_set_lock_blocking_write(right);
 
 	free_space = btrfs_leaf_free_space(right);
 	if (free_space < data_size)
@@ -4092,7 +4044,6 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 		return 1;
 
 	__btrfs_tree_lock(left, BTRFS_NESTING_LEFT);
-	btrfs_set_lock_blocking_write(left);
 
 	free_space = btrfs_leaf_free_space(left);
 	if (free_space < data_size) {
@@ -4488,7 +4439,6 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 			goto err;
 	}
 
-	btrfs_set_path_blocking(path);
 	ret = split_leaf(trans, root, &key, path, ins_len, 1);
 	if (ret)
 		goto err;
@@ -4518,8 +4468,6 @@ static noinline int split_item(struct btrfs_path *path,
 	leaf = path->nodes[0];
 	BUG_ON(btrfs_leaf_free_space(leaf) < sizeof(struct btrfs_item));
 
-	btrfs_set_path_blocking(path);
-
 	item = btrfs_item_nr(path->slots[0]);
 	orig_offset = btrfs_item_offset(leaf, item);
 	item_size = btrfs_item_size(leaf, item);
@@ -5095,7 +5043,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (leaf == root->node) {
 			btrfs_set_header_level(leaf, 0);
 		} else {
-			btrfs_set_path_blocking(path);
 			btrfs_clean_tree_block(leaf);
 			btrfs_del_leaf(trans, root, path, leaf);
 		}
@@ -5117,7 +5064,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			slot = path->slots[1];
 			atomic_inc(&leaf->refs);
 
-			btrfs_set_path_blocking(path);
 			wret = push_leaf_left(trans, root, path, 1, 1,
 					      1, (u32)-1);
 			if (wret < 0 && wret != -ENOSPC)
@@ -5318,7 +5264,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 		 */
 		if (slot >= nritems) {
 			path->slots[level] = slot;
-			btrfs_set_path_blocking(path);
 			sret = btrfs_find_next_key(root, path, min_key, level,
 						  min_trans);
 			if (sret == 0) {
@@ -5335,7 +5280,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			ret = 0;
 			goto out;
 		}
-		btrfs_set_path_blocking(path);
 		cur = btrfs_read_node_slot(cur, slot);
 		if (IS_ERR(cur)) {
 			ret = PTR_ERR(cur);
@@ -5352,7 +5296,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	path->keep_locks = keep_locks;
 	if (ret == 0) {
 		btrfs_unlock_up_safe(path, path->lowest_level + 1);
-		btrfs_set_path_blocking(path);
 		memcpy(min_key, &found_key, sizeof(found_key));
 	}
 	return ret;
@@ -5562,7 +5505,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 				goto again;
 			}
 			if (!ret) {
-				btrfs_set_path_blocking(path);
 				__btrfs_tree_read_lock(next,
 						       BTRFS_NESTING_RIGHT,
 						       path->recurse);
@@ -5597,13 +5539,8 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		if (!path->skip_locking) {
-			ret = btrfs_try_tree_read_lock(next);
-			if (!ret) {
-				btrfs_set_path_blocking(path);
-				__btrfs_tree_read_lock(next,
-						       BTRFS_NESTING_RIGHT,
-						       path->recurse);
-			}
+			__btrfs_tree_read_lock(next, BTRFS_NESTING_RIGHT,
+					       path->recurse);
 			next_rw_lock = BTRFS_READ_LOCK;
 		}
 	}
@@ -5611,8 +5548,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 done:
 	unlock_up(path, 0, 1, 0, NULL);
 	path->leave_spinning = old_spinning;
-	if (!old_spinning)
-		btrfs_set_path_blocking(path);
 
 	return ret;
 }
@@ -5634,7 +5569,6 @@ int btrfs_previous_item(struct btrfs_root *root,
 
 	while (1) {
 		if (path->slots[0] == 0) {
-			btrfs_set_path_blocking(path);
 			ret = btrfs_prev_leaf(root, path);
 			if (ret != 0)
 				return ret;
@@ -5676,7 +5610,6 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 
 	while (1) {
 		if (path->slots[0] == 0) {
-			btrfs_set_path_blocking(path);
 			ret = btrfs_prev_leaf(root, path);
 			if (ret != 0)
 				return ret;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e2afaa70ae5e..cbc05bd8452e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -741,13 +741,6 @@ static int btrfs_batch_insert_items(struct btrfs_root *root,
 		goto out;
 	}
 
-	/*
-	 * we need allocate some memory space, but it might cause the task
-	 * to sleep, so we set all locked nodes in the path to blocking locks
-	 * first.
-	 */
-	btrfs_set_path_blocking(path);
-
 	keys = kmalloc_array(nitems, sizeof(struct btrfs_key), GFP_NOFS);
 	if (!keys) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 104c86784796..023999767edc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -248,10 +248,8 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	if (atomic)
 		return -EAGAIN;
 
-	if (need_lock) {
+	if (need_lock)
 		btrfs_tree_read_lock(eb);
-		btrfs_set_lock_blocking_read(eb);
-	}
 
 	lock_extent_bits(io_tree, eb->start, eb->start + eb->len - 1,
 			 &cached_state);
@@ -280,7 +278,7 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	unlock_extent_cached(io_tree, eb->start, eb->start + eb->len - 1,
 			     &cached_state);
 	if (need_lock)
-		btrfs_tree_read_unlock_blocking(eb);
+		btrfs_tree_read_unlock(eb);
 	return ret;
 }
 
@@ -1012,8 +1010,6 @@ void btrfs_clean_tree_block(struct extent_buffer *buf)
 			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 						 -buf->len,
 						 fs_info->dirty_metadata_batch);
-			/* ugh, clear_extent_buffer_dirty needs to lock the page */
-			btrfs_set_lock_blocking_write(buf);
 			clear_extent_buffer_dirty(buf);
 		}
 	}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d8a1bec69fb8..a8089bf2be98 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4608,7 +4608,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_clean_tree_block(buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
 
-	btrfs_set_lock_blocking_write(buf);
 	set_extent_buffer_uptodate(buf);
 
 	memzero_extent_buffer(buf, 0, sizeof(struct btrfs_header));
@@ -5008,7 +5007,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		reada = 1;
 	}
 	btrfs_tree_lock(next);
-	btrfs_set_lock_blocking_write(next);
 
 	ret = btrfs_lookup_extent_info(trans, fs_info, bytenr, level - 1, 1,
 				       &wc->refs[level - 1],
@@ -5069,7 +5067,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			return -EIO;
 		}
 		btrfs_tree_lock(next);
-		btrfs_set_lock_blocking_write(next);
 	}
 
 	level--;
@@ -5081,7 +5078,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	}
 	path->nodes[level] = next;
 	path->slots[level] = 0;
-	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 	wc->level = level;
 	if (wc->level == 1)
 		wc->reada_slot = 0;
@@ -5209,8 +5206,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 		if (!path->locks[level]) {
 			BUG_ON(level == 0);
 			btrfs_tree_lock(eb);
-			btrfs_set_lock_blocking_write(eb);
-			path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_WRITE_LOCK;
 
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						       eb->start, level, 1,
@@ -5258,8 +5254,7 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 		if (!path->locks[level] &&
 		    btrfs_header_generation(eb) == trans->transid) {
 			btrfs_tree_lock(eb);
-			btrfs_set_lock_blocking_write(eb);
-			path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_WRITE_LOCK;
 		}
 		btrfs_clean_tree_block(eb);
 	}
@@ -5427,9 +5422,8 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		level = btrfs_header_level(root->node);
 		path->nodes[level] = btrfs_lock_root_node(root);
-		btrfs_set_lock_blocking_write(path->nodes[level]);
 		path->slots[level] = 0;
-		path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+		path->locks[level] = BTRFS_WRITE_LOCK;
 		memset(&wc->update_progress, 0,
 		       sizeof(wc->update_progress));
 	} else {
@@ -5457,8 +5451,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		level = btrfs_header_level(root->node);
 		while (1) {
 			btrfs_tree_lock(path->nodes[level]);
-			btrfs_set_lock_blocking_write(path->nodes[level]);
-			path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_WRITE_LOCK;
 
 			ret = btrfs_lookup_extent_info(trans, fs_info,
 						path->nodes[level]->start,
@@ -5653,7 +5646,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	level = btrfs_header_level(node);
 	path->nodes[level] = node;
 	path->slots[level] = 0;
-	path->locks[level] = BTRFS_WRITE_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_WRITE_LOCK;
 
 	wc->refs[parent_level] = 1;
 	wc->flags[parent_level] = BTRFS_BLOCK_FLAG_FULL_BACKREF;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 416a1b753ff6..53a3c32a0f8c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -984,8 +984,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	 * write lock.
 	 */
 	if (!ret && replace_extent && leafs_visited == 1 &&
-	    (path->locks[0] == BTRFS_WRITE_LOCK_BLOCKING ||
-	     path->locks[0] == BTRFS_WRITE_LOCK) &&
+	    path->locks[0] == BTRFS_WRITE_LOCK &&
 	    btrfs_leaf_free_space(leaf) >=
 	    sizeof(struct btrfs_item) + extent_item_size) {
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b9dfa1d2de25..560c4f2a1833 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6752,7 +6752,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		em->orig_start = em->start;
 		ptr = btrfs_file_extent_inline_start(item) + extent_offset;
 
-		btrfs_set_path_blocking(path);
 		if (!PageUptodate(page)) {
 			if (btrfs_file_extent_compression(leaf, item) !=
 			    BTRFS_COMPRESS_NONE) {
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 60e0f00b9b8f..5260660b655a 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -50,31 +50,6 @@
  *
  */
 
-/*
- * Mark already held read lock as blocking. Can be nested in write lock by the
- * same thread.
- *
- * Use when there are potentially long operations ahead so other thread waiting
- * on the lock will not actively spin but sleep instead.
- *
- * The rwlock is released and blocking reader counter is increased.
- */
-void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
-{
-}
-
-/*
- * Mark already held write lock as blocking.
- *
- * Use when there are potentially long operations ahead so other threads
- * waiting on the lock will not actively spin but sleep instead.
- *
- * The rwlock is released and blocking writers is set.
- */
-void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
-{
-}
-
 /*
  * __btrfs_tree_read_lock - lock extent buffer for read
  * @eb:		the eb to be locked
@@ -130,17 +105,6 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 	__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL, false);
 }
 
-/*
- * Lock extent buffer for read, optimistically expecting that there are no
- * contending blocking writers. If there are, don't wait.
- *
- * Return 1 if the rwlock has been taken, 0 otherwise
- */
-int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
-{
-	return btrfs_try_tree_read_lock(eb);
-}
-
 /*
  * Try-lock for read.
  *
@@ -192,18 +156,6 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
 	up_read(&eb->lock);
 }
 
-/*
- * Release read lock, previously set to blocking by a pairing call to
- * btrfs_set_lock_blocking_read(). Can be nested in write lock by the same
- * thread.
- *
- * State of rwlock is unchanged, last reader wakes waiting threads.
- */
-void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
-{
-	btrfs_tree_read_unlock(eb);
-}
-
 /*
  * __btrfs_tree_lock - lock eb for write
  * @eb:		the eb to lock
@@ -239,32 +191,6 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
 	up_write(&eb->lock);
 }
 
-/*
- * Set all locked nodes in the path to blocking locks.  This should be done
- * before scheduling
- */
-void btrfs_set_path_blocking(struct btrfs_path *p)
-{
-	int i;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
-		if (!p->nodes[i] || !p->locks[i])
-			continue;
-		/*
-		 * If we currently have a spinning reader or writer lock this
-		 * will bump the count of blocking holders and drop the
-		 * spinlock.
-		 */
-		if (p->locks[i] == BTRFS_READ_LOCK) {
-			btrfs_set_lock_blocking_read(p->nodes[i]);
-			p->locks[i] = BTRFS_READ_LOCK_BLOCKING;
-		} else if (p->locks[i] == BTRFS_WRITE_LOCK) {
-			btrfs_set_lock_blocking_write(p->nodes[i]);
-			p->locks[i] = BTRFS_WRITE_LOCK_BLOCKING;
-		}
-	}
-}
-
 /*
  * This releases any locks held in the path starting at level and going all the
  * way up to the root.
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 7c27f142f7d2..f8f2fd835582 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -13,8 +13,6 @@
 
 #define BTRFS_WRITE_LOCK 1
 #define BTRFS_READ_LOCK 2
-#define BTRFS_WRITE_LOCK_BLOCKING 3
-#define BTRFS_READ_LOCK_BLOCKING 4
 
 /*
  * We are limited in number of subclasses by MAX_LOCKDEP_SUBCLASSES, which at
@@ -93,12 +91,8 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 			    bool recurse);
 void btrfs_tree_read_lock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
-void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb);
-void btrfs_set_lock_blocking_read(struct extent_buffer *eb);
-void btrfs_set_lock_blocking_write(struct extent_buffer *eb);
 int btrfs_try_tree_read_lock(struct extent_buffer *eb);
 int btrfs_try_tree_write_lock(struct extent_buffer *eb);
-int btrfs_tree_read_lock_atomic(struct extent_buffer *eb);
 struct extent_buffer *btrfs_lock_root_node(struct btrfs_root *root);
 struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *root,
 						  bool recurse);
@@ -116,15 +110,12 @@ static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
 static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) { }
 #endif
 
-void btrfs_set_path_blocking(struct btrfs_path *p);
 void btrfs_unlock_up_safe(struct btrfs_path *path, int level);
 
 static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
 {
-	if (rw == BTRFS_WRITE_LOCK || rw == BTRFS_WRITE_LOCK_BLOCKING)
+	if (rw == BTRFS_WRITE_LOCK)
 		btrfs_tree_unlock(eb);
-	else if (rw == BTRFS_READ_LOCK_BLOCKING)
-		btrfs_tree_read_unlock_blocking(eb);
 	else if (rw == BTRFS_READ_LOCK)
 		btrfs_tree_read_unlock(eb);
 	else
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 7518ab3b409c..95a39d535a82 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2061,8 +2061,7 @@ static int qgroup_trace_extent_swap(struct btrfs_trans_handle* trans,
 			src_path->nodes[cur_level] = eb;
 
 			btrfs_tree_read_lock(eb);
-			btrfs_set_lock_blocking_read(eb);
-			src_path->locks[cur_level] = BTRFS_READ_LOCK_BLOCKING;
+			src_path->locks[cur_level] = BTRFS_READ_LOCK;
 		}
 
 		src_path->slots[cur_level] = dst_path->slots[cur_level];
@@ -2202,8 +2201,7 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 		dst_path->slots[cur_level] = 0;
 
 		btrfs_tree_read_lock(eb);
-		btrfs_set_lock_blocking_read(eb);
-		dst_path->locks[cur_level] = BTRFS_READ_LOCK_BLOCKING;
+		dst_path->locks[cur_level] = BTRFS_READ_LOCK;
 		need_cleanup = true;
 	}
 
@@ -2377,8 +2375,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 			path->slots[level] = 0;
 
 			btrfs_tree_read_lock(eb);
-			btrfs_set_lock_blocking_read(eb);
-			path->locks[level] = BTRFS_READ_LOCK_BLOCKING;
+			path->locks[level] = BTRFS_READ_LOCK;
 
 			ret = btrfs_qgroup_trace_extent(trans, child_bytenr,
 							fs_info->nodesize,
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 38e1ed4dc2a9..4755bccee9aa 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -575,10 +575,9 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 				return -EIO;
 			}
 			btrfs_tree_read_lock(eb);
-			btrfs_set_lock_blocking_read(eb);
 			path->nodes[level-1] = eb;
 			path->slots[level-1] = 0;
-			path->locks[level-1] = BTRFS_READ_LOCK_BLOCKING;
+			path->locks[level-1] = BTRFS_READ_LOCK;
 		} else {
 			ret = process_leaf(root, path, bytenr, num_bytes);
 			if (ret)
@@ -1006,11 +1005,10 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		return -ENOMEM;
 
 	eb = btrfs_read_lock_root_node(fs_info->extent_root);
-	btrfs_set_lock_blocking_read(eb);
 	level = btrfs_header_level(eb);
 	path->nodes[level] = eb;
 	path->slots[level] = 0;
-	path->locks[level] = BTRFS_READ_LOCK_BLOCKING;
+	path->locks[level] = BTRFS_READ_LOCK;
 
 	while (1) {
 		/*
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index cdd16583b2ff..98e3b3749ec1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1214,7 +1214,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	btrfs_node_key_to_cpu(path->nodes[lowest_level], &key, slot);
 
 	eb = btrfs_lock_root_node(dest);
-	btrfs_set_lock_blocking_write(eb);
 	level = btrfs_header_level(eb);
 
 	if (level < lowest_level) {
@@ -1228,7 +1227,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				      BTRFS_NESTING_COW);
 		BUG_ON(ret);
 	}
-	btrfs_set_lock_blocking_write(eb);
 
 	if (next_key) {
 		next_key->objectid = (u64)-1;
@@ -1297,7 +1295,6 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 						      BTRFS_NESTING_COW);
 				BUG_ON(ret);
 			}
-			btrfs_set_lock_blocking_write(eb);
 
 			btrfs_tree_unlock(parent);
 			free_extent_buffer(parent);
@@ -2327,7 +2324,6 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 			goto next;
 		}
 		btrfs_tree_lock(eb);
-		btrfs_set_lock_blocking_write(eb);
 
 		if (!node->eb) {
 			ret = btrfs_cow_block(trans, root, eb, upper->eb,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8878aa7cbdc5..d1f010022f68 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1648,8 +1648,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 		goto fail;
 	}
 
-	btrfs_set_lock_blocking_write(old);
-
 	ret = btrfs_copy_root(trans, root, old, &tmp, objectid);
 	/* clean up in any case */
 	btrfs_tree_unlock(old);
diff --git a/fs/btrfs/tree-defrag.c b/fs/btrfs/tree-defrag.c
index d3f28b8f4ff9..7c45d960b53c 100644
--- a/fs/btrfs/tree-defrag.c
+++ b/fs/btrfs/tree-defrag.c
@@ -52,7 +52,6 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 		u32 nritems;
 
 		root_node = btrfs_lock_root_node(root);
-		btrfs_set_lock_blocking_write(root_node);
 		nritems = btrfs_header_nritems(root_node);
 		root->defrag_max.objectid = 0;
 		/* from above we know this is not a leaf */
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 34e9eb5010cd..4ee681429327 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2774,7 +2774,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 				if (trans) {
 					btrfs_tree_lock(next);
-					btrfs_set_lock_blocking_write(next);
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
@@ -2843,7 +2842,6 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 
 				if (trans) {
 					btrfs_tree_lock(next);
-					btrfs_set_lock_blocking_write(next);
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
@@ -2925,7 +2923,6 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			if (trans) {
 				btrfs_tree_lock(next);
-				btrfs_set_lock_blocking_write(next);
 				btrfs_clean_tree_block(next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
-- 
2.39.5




