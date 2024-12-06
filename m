Return-Path: <stable+bounces-99689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C068F9E72E5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4338216D871
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DA2066EE;
	Fri,  6 Dec 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NW5uv1Ck"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EE1527AC;
	Fri,  6 Dec 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498019; cv=none; b=bTr/MvWYPpHsc+f1g55pKTiYfkYGN3+rKdcZoeJFTv5oOBygah9d1p9mxbE1tpaW+FhjqI0hvD7EXMXRKjnnzu2FnFEkE90NmEew8DZZ/X3wqWOMbkTy9hGZO5msYLn1Cv9PMOhCqYm/O2E+qSNvjtEi/FRZfxJ7HYyfqG/NEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498019; c=relaxed/simple;
	bh=OIPDaF1RQn9KRXJtnuIa4te7Zn9AHYCRpdCaweb2BSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT4NAjlYoMkyEpVsFbAi9L1Pbu8+dmW15VXo0tnAE0a+9eT+TR9czipyqkCEGrhC0u7jllqz9kmLZ8wydUVsJDJJOzez+PCdvDAvfcKKkAjaKIaWe0yYcvC4gDTwbBNL+g50Wqgqt81JYGb8JGxMFDsiEjGLEX+dYDuajiwtU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NW5uv1Ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24423C4CED1;
	Fri,  6 Dec 2024 15:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733498019;
	bh=OIPDaF1RQn9KRXJtnuIa4te7Zn9AHYCRpdCaweb2BSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NW5uv1Ckh8CKt+9DvRIhawPraHIWs8Tghk6ySyk5ejM0qOh2jVd0UPiU2Yt2MEjeU
	 B0uasUQayAKuCNnPBtZMZxXVetNhml+Ksoo0GH7+u+yb7x/aiuL4kwpHqBiM0VE39a
	 SuKYoIzWdOiA+w4IG9wjXViphTFFv3A4SlNGeH6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+a306f914b4d01b3958fe@syzkaller.appspotmail.com,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Bin Lan <bin.lan.cn@windriver.com>
Subject: [PATCH 6.6 463/676] btrfs: do not BUG_ON() when freeing tree block after error
Date: Fri,  6 Dec 2024 15:34:42 +0100
Message-ID: <20241206143711.452654312@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit bb3868033a4cccff7be57e9145f2117cbdc91c11 upstream.

When freeing a tree block, at btrfs_free_tree_block(), if we fail to
create a delayed reference we don't deal with the error and just do a
BUG_ON(). The error most likely to happen is -ENOMEM, and we have a
comment mentioning that only -ENOMEM can happen, but that is not true,
because in case qgroups are enabled any error returned from
btrfs_qgroup_trace_extent_post() (can be -EUCLEAN or anything returned
from btrfs_search_slot() for example) can be propagated back to
btrfs_free_tree_block().

So stop doing a BUG_ON() and return the error to the callers and make
them abort the transaction to prevent leaking space. Syzbot was
triggering this, likely due to memory allocation failure injection.

Reported-by: syzbot+a306f914b4d01b3958fe@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000fcba1e05e998263c@google.com/
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Resolve minor conflicts ]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.c           |   51 ++++++++++++++++++++++++++++++++++++---------
 fs/btrfs/extent-tree.c     |   22 +++++++++++--------
 fs/btrfs/extent-tree.h     |    8 +++----
 fs/btrfs/free-space-tree.c |   10 ++++++--
 fs/btrfs/ioctl.c           |    6 ++++-
 fs/btrfs/qgroup.c          |    6 +++--
 6 files changed, 74 insertions(+), 29 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -617,10 +617,16 @@ static noinline int __btrfs_cow_block(st
 		atomic_inc(&cow->refs);
 		rcu_assign_pointer(root->node, cow);
 
-		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
-				      parent_start, last_ref);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+					    parent_start, last_ref);
 		free_extent_buffer(buf);
 		add_root_to_dirty_list(root);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	} else {
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
 		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
@@ -645,8 +651,14 @@ static noinline int __btrfs_cow_block(st
 				return ret;
 			}
 		}
-		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
-				      parent_start, last_ref);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
+					    parent_start, last_ref);
+		if (ret < 0) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 	}
 	if (unlock_orig)
 		btrfs_tree_unlock(buf);
@@ -1121,9 +1133,13 @@ static noinline int balance_level(struct
 		free_extent_buffer(mid);
 
 		root_sub_used(root, mid->len);
-		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		/* once for the root ptr */
 		free_extent_buffer_stale(mid);
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 		return 0;
 	}
 	if (btrfs_header_nritems(mid) >
@@ -1191,10 +1207,14 @@ static noinline int balance_level(struct
 				goto out;
 			}
 			root_sub_used(root, right->len);
-			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
+			ret = btrfs_free_tree_block(trans, btrfs_root_id(root), right,
 					      0, 1);
 			free_extent_buffer_stale(right);
 			right = NULL;
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				goto out;
+			}
 		} else {
 			struct btrfs_disk_key right_key;
 			btrfs_node_key(right, &right_key, 0);
@@ -1249,9 +1269,13 @@ static noinline int balance_level(struct
 			goto out;
 		}
 		root_sub_used(root, mid->len);
-		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
+		ret = btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		free_extent_buffer_stale(mid);
 		mid = NULL;
+		if (ret < 0) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 	} else {
 		/* update the parent key to reflect our changes */
 		struct btrfs_disk_key mid_key;
@@ -3022,7 +3046,11 @@ static noinline int insert_new_root(stru
 	old = root->node;
 	ret = btrfs_tree_mod_log_insert_root(root->node, c, false);
 	if (ret < 0) {
-		btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
+		int ret2;
+
+		ret2 = btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
+		if (ret2 < 0)
+			btrfs_abort_transaction(trans, ret2);
 		btrfs_tree_unlock(c);
 		free_extent_buffer(c);
 		return ret;
@@ -4587,9 +4615,12 @@ static noinline int btrfs_del_leaf(struc
 	root_sub_used(root, leaf->len);
 
 	atomic_inc(&leaf->refs);
-	btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), leaf, 0, 1);
 	free_extent_buffer_stale(leaf);
-	return 0;
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
+
+	return ret;
 }
 /*
  * delete the item at the leaf level in path.  If that empties
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3290,10 +3290,10 @@ out_delayed_unlock:
 	return 0;
 }
 
-void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			   u64 root_id,
-			   struct extent_buffer *buf,
-			   u64 parent, int last_ref)
+int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
+			  u64 root_id,
+			  struct extent_buffer *buf,
+			  u64 parent, int last_ref)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_ref generic_ref = { 0 };
@@ -3307,7 +3307,8 @@ void btrfs_free_tree_block(struct btrfs_
 	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
 		btrfs_ref_tree_mod(fs_info, &generic_ref);
 		ret = btrfs_add_delayed_tree_ref(trans, &generic_ref, NULL);
-		BUG_ON(ret); /* -ENOMEM */
+		if (ret < 0)
+			return ret;
 	}
 
 	if (last_ref && btrfs_header_generation(buf) == trans->transid) {
@@ -3371,6 +3372,7 @@ out:
 		 */
 		clear_bit(EXTENT_BUFFER_CORRUPT, &buf->bflags);
 	}
+	return 0;
 }
 
 /* Can return -ENOMEM */
@@ -5474,7 +5476,7 @@ static noinline int walk_up_proc(struct
 				 struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	int ret;
+	int ret = 0;
 	int level = wc->level;
 	struct extent_buffer *eb = path->nodes[level];
 	u64 parent = 0;
@@ -5565,12 +5567,14 @@ static noinline int walk_up_proc(struct
 			goto owner_mismatch;
 	}
 
-	btrfs_free_tree_block(trans, btrfs_root_id(root), eb, parent,
-			      wc->refs[level] == 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), eb, parent,
+				    wc->refs[level] == 1);
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
 out:
 	wc->refs[level] = 0;
 	wc->flags[level] = 0;
-	return 0;
+	return ret;
 
 owner_mismatch:
 	btrfs_err_rl(fs_info, "unexpected tree owner, have %llu expect %llu",
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -114,10 +114,10 @@ struct extent_buffer *btrfs_alloc_tree_b
 					     int level, u64 hint,
 					     u64 empty_size,
 					     enum btrfs_lock_nesting nest);
-void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
-			   u64 root_id,
-			   struct extent_buffer *buf,
-			   u64 parent, int last_ref);
+int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
+			  u64 root_id,
+			  struct extent_buffer *buf,
+			  u64 parent, int last_ref);
 int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				     struct btrfs_root *root, u64 owner,
 				     u64 offset, u64 ram_bytes,
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1289,10 +1289,14 @@ int btrfs_delete_free_space_tree(struct
 	btrfs_tree_lock(free_space_root->node);
 	btrfs_clear_buffer_dirty(trans, free_space_root->node);
 	btrfs_tree_unlock(free_space_root->node);
-	btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
-			      free_space_root->node, 0, 1);
-
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(free_space_root),
+				    free_space_root->node, 0, 1);
 	btrfs_put_root(free_space_root);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
 
 	return btrfs_commit_transaction(trans);
 
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -707,6 +707,8 @@ static noinline int create_subvol(struct
 	ret = btrfs_insert_root(trans, fs_info->tree_root, &key,
 				root_item);
 	if (ret) {
+		int ret2;
+
 		/*
 		 * Since we don't abort the transaction in this case, free the
 		 * tree block so that we don't leak space and leave the
@@ -717,7 +719,9 @@ static noinline int create_subvol(struct
 		btrfs_tree_lock(leaf);
 		btrfs_clear_buffer_dirty(trans, leaf);
 		btrfs_tree_unlock(leaf);
-		btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
+		ret2 = btrfs_free_tree_block(trans, objectid, leaf, 0, 1);
+		if (ret2 < 0)
+			btrfs_abort_transaction(trans, ret2);
 		free_extent_buffer(leaf);
 		goto out;
 	}
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1320,9 +1320,11 @@ int btrfs_quota_disable(struct btrfs_fs_
 	btrfs_tree_lock(quota_root->node);
 	btrfs_clear_buffer_dirty(trans, quota_root->node);
 	btrfs_tree_unlock(quota_root->node);
-	btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
-			      quota_root->node, 0, 1);
+	ret = btrfs_free_tree_block(trans, btrfs_root_id(quota_root),
+				    quota_root->node, 0, 1);
 
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
 
 out:
 	btrfs_put_root(quota_root);



