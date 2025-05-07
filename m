Return-Path: <stable+bounces-142456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5EEAAEAAE
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477459C7AC4
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B33924E4CE;
	Wed,  7 May 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhxstKD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461FF1482F5;
	Wed,  7 May 2025 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644310; cv=none; b=TEyu3DtLPKnkil0iX7McqGcWrCscG2lng5O3U+AfNlENkYQXfGHzUXI6alxn5tmbDY2b4n6VSM60Nis75eRXQvjcnptcqyR3cleKtS3alzB7bE3LTHg0FwkM3aaNRFupA8E7G/vgq9cKFzfmFRfjoqShxtyxej2hkuf/vyaeMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644310; c=relaxed/simple;
	bh=mdrt9JwPo0DZLeQ+p7jKnPdiLpe3pMZ3tmY9HyXkt0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHP3ttxtT20gUqQNnMHUIq/z9JD7HZ/buVw9jpI4fwipQdFxY+QR3b0M9Fvme31jQMJFwm4wFb1/P+iT8h8hFDlFTMPza1Er5gakLsv3nrpUSxq2lxsjKJMarVCc2rp8DLUdMNRlZgsPKM/uMUCFRMbLthnzBmRTuu56npngpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhxstKD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A38C4CEE2;
	Wed,  7 May 2025 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644309;
	bh=mdrt9JwPo0DZLeQ+p7jKnPdiLpe3pMZ3tmY9HyXkt0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhxstKD1z83gH91i3gkxV9z/+Se4JOw/EA4uEe2mY3a3rgTvHBvUrXGQw0zG+0yuQ
	 FHyIOlKalHvJY4ZwCFEdp12RdLDwh4SRbyY06yZfFYjGbkhYfrskZzZk04DnxZUJ4Q
	 S5yJDJI+vL7du5hN00sF4yEsK5F3EfBGQItqX0BI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 178/183] btrfs: pass struct btrfs_inode to btrfs_read_locked_inode()
Date: Wed,  7 May 2025 20:40:23 +0200
Message-ID: <20250507183832.067087514@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Sterba <dsterba@suse.com>

[ Upstream commit d36f84a849c7685099594815a1e5a48db62c243d ]

Pass a struct btrfs_inode to btrfs_read_locked_inode() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 48c1d1bb525b ("btrfs: fix the inode leak in btrfs_iget()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 119 +++++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 90782fd9f37b8..6d9d1c255285d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3846,12 +3846,13 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
  *
  * On failure clean up the inode.
  */
-static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
+static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path *path)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
 	struct btrfs_inode_item *inode_item;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct inode *vfs_inode = &inode->vfs_inode;
 	struct btrfs_key location;
 	unsigned long ptr;
 	int maybe_acls;
@@ -3860,17 +3861,17 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	bool filled = false;
 	int first_xattr_slot;
 
-	ret = btrfs_init_file_extent_tree(BTRFS_I(inode));
+	ret = btrfs_init_file_extent_tree(inode);
 	if (ret)
 		goto out;
 
-	ret = btrfs_fill_inode(inode, &rdev);
+	ret = btrfs_fill_inode(vfs_inode, &rdev);
 	if (!ret)
 		filled = true;
 
 	ASSERT(path);
 
-	btrfs_get_inode_key(BTRFS_I(inode), &location);
+	btrfs_get_inode_key(inode, &location);
 
 	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
 	if (ret) {
@@ -3890,42 +3891,41 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 
 	inode_item = btrfs_item_ptr(leaf, path->slots[0],
 				    struct btrfs_inode_item);
-	inode->i_mode = btrfs_inode_mode(leaf, inode_item);
-	set_nlink(inode, btrfs_inode_nlink(leaf, inode_item));
-	i_uid_write(inode, btrfs_inode_uid(leaf, inode_item));
-	i_gid_write(inode, btrfs_inode_gid(leaf, inode_item));
-	btrfs_i_size_write(BTRFS_I(inode), btrfs_inode_size(leaf, inode_item));
-	btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
-			round_up(i_size_read(inode), fs_info->sectorsize));
-
-	inode_set_atime(inode, btrfs_timespec_sec(leaf, &inode_item->atime),
+	vfs_inode->i_mode = btrfs_inode_mode(leaf, inode_item);
+	set_nlink(vfs_inode, btrfs_inode_nlink(leaf, inode_item));
+	i_uid_write(vfs_inode, btrfs_inode_uid(leaf, inode_item));
+	i_gid_write(vfs_inode, btrfs_inode_gid(leaf, inode_item));
+	btrfs_i_size_write(inode, btrfs_inode_size(leaf, inode_item));
+	btrfs_inode_set_file_extent_range(inode, 0,
+			round_up(i_size_read(vfs_inode), fs_info->sectorsize));
+
+	inode_set_atime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->atime),
 			btrfs_timespec_nsec(leaf, &inode_item->atime));
 
-	inode_set_mtime(inode, btrfs_timespec_sec(leaf, &inode_item->mtime),
+	inode_set_mtime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->mtime),
 			btrfs_timespec_nsec(leaf, &inode_item->mtime));
 
-	inode_set_ctime(inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
+	inode_set_ctime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
 			btrfs_timespec_nsec(leaf, &inode_item->ctime));
 
-	BTRFS_I(inode)->i_otime_sec = btrfs_timespec_sec(leaf, &inode_item->otime);
-	BTRFS_I(inode)->i_otime_nsec = btrfs_timespec_nsec(leaf, &inode_item->otime);
+	inode->i_otime_sec = btrfs_timespec_sec(leaf, &inode_item->otime);
+	inode->i_otime_nsec = btrfs_timespec_nsec(leaf, &inode_item->otime);
 
-	inode_set_bytes(inode, btrfs_inode_nbytes(leaf, inode_item));
-	BTRFS_I(inode)->generation = btrfs_inode_generation(leaf, inode_item);
-	BTRFS_I(inode)->last_trans = btrfs_inode_transid(leaf, inode_item);
+	inode_set_bytes(vfs_inode, btrfs_inode_nbytes(leaf, inode_item));
+	inode->generation = btrfs_inode_generation(leaf, inode_item);
+	inode->last_trans = btrfs_inode_transid(leaf, inode_item);
 
-	inode_set_iversion_queried(inode,
-				   btrfs_inode_sequence(leaf, inode_item));
-	inode->i_generation = BTRFS_I(inode)->generation;
-	inode->i_rdev = 0;
+	inode_set_iversion_queried(vfs_inode, btrfs_inode_sequence(leaf, inode_item));
+	vfs_inode->i_generation = inode->generation;
+	vfs_inode->i_rdev = 0;
 	rdev = btrfs_inode_rdev(leaf, inode_item);
 
-	if (S_ISDIR(inode->i_mode))
-		BTRFS_I(inode)->index_cnt = (u64)-1;
+	if (S_ISDIR(vfs_inode->i_mode))
+		inode->index_cnt = (u64)-1;
 
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
-				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
-	btrfs_update_inode_mapping_flags(BTRFS_I(inode));
+				&inode->flags, &inode->ro_flags);
+	btrfs_update_inode_mapping_flags(inode);
 
 cache_index:
 	/*
@@ -3937,9 +3937,8 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * This is required for both inode re-read from disk and delayed inode
 	 * in the delayed_nodes xarray.
 	 */
-	if (BTRFS_I(inode)->last_trans == btrfs_get_fs_generation(fs_info))
-		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-			&BTRFS_I(inode)->runtime_flags);
+	if (inode->last_trans == btrfs_get_fs_generation(fs_info))
+		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
 
 	/*
 	 * We don't persist the id of the transaction where an unlink operation
@@ -3968,7 +3967,7 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * transaction commits on fsync if our inode is a directory, or if our
 	 * inode is not a directory, logging its parent unnecessarily.
 	 */
-	BTRFS_I(inode)->last_unlink_trans = BTRFS_I(inode)->last_trans;
+	inode->last_unlink_trans = inode->last_trans;
 
 	/*
 	 * Same logic as for last_unlink_trans. We don't persist the generation
@@ -3976,15 +3975,15 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * operation, so after eviction and reloading the inode we must be
 	 * pessimistic and assume the last transaction that modified the inode.
 	 */
-	BTRFS_I(inode)->last_reflink_trans = BTRFS_I(inode)->last_trans;
+	inode->last_reflink_trans = inode->last_trans;
 
 	path->slots[0]++;
-	if (inode->i_nlink != 1 ||
+	if (vfs_inode->i_nlink != 1 ||
 	    path->slots[0] >= btrfs_header_nritems(leaf))
 		goto cache_acl;
 
 	btrfs_item_key_to_cpu(leaf, &location, path->slots[0]);
-	if (location.objectid != btrfs_ino(BTRFS_I(inode)))
+	if (location.objectid != btrfs_ino(inode))
 		goto cache_acl;
 
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
@@ -3992,13 +3991,12 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 		struct btrfs_inode_ref *ref;
 
 		ref = (struct btrfs_inode_ref *)ptr;
-		BTRFS_I(inode)->dir_index = btrfs_inode_ref_index(leaf, ref);
+		inode->dir_index = btrfs_inode_ref_index(leaf, ref);
 	} else if (location.type == BTRFS_INODE_EXTREF_KEY) {
 		struct btrfs_inode_extref *extref;
 
 		extref = (struct btrfs_inode_extref *)ptr;
-		BTRFS_I(inode)->dir_index = btrfs_inode_extref_index(leaf,
-								     extref);
+		inode->dir_index = btrfs_inode_extref_index(leaf, extref);
 	}
 cache_acl:
 	/*
@@ -4006,50 +4004,49 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * any xattrs or acls
 	 */
 	maybe_acls = acls_after_inode_item(leaf, path->slots[0],
-			btrfs_ino(BTRFS_I(inode)), &first_xattr_slot);
+					   btrfs_ino(inode), &first_xattr_slot);
 	if (first_xattr_slot != -1) {
 		path->slots[0] = first_xattr_slot;
-		ret = btrfs_load_inode_props(inode, path);
+		ret = btrfs_load_inode_props(vfs_inode, path);
 		if (ret)
 			btrfs_err(fs_info,
 				  "error loading props for ino %llu (root %llu): %d",
-				  btrfs_ino(BTRFS_I(inode)),
-				  btrfs_root_id(root), ret);
+				  btrfs_ino(inode), btrfs_root_id(root), ret);
 	}
 
 	if (!maybe_acls)
-		cache_no_acl(inode);
+		cache_no_acl(vfs_inode);
 
-	switch (inode->i_mode & S_IFMT) {
+	switch (vfs_inode->i_mode & S_IFMT) {
 	case S_IFREG:
-		inode->i_mapping->a_ops = &btrfs_aops;
-		inode->i_fop = &btrfs_file_operations;
-		inode->i_op = &btrfs_file_inode_operations;
+		vfs_inode->i_mapping->a_ops = &btrfs_aops;
+		vfs_inode->i_fop = &btrfs_file_operations;
+		vfs_inode->i_op = &btrfs_file_inode_operations;
 		break;
 	case S_IFDIR:
-		inode->i_fop = &btrfs_dir_file_operations;
-		inode->i_op = &btrfs_dir_inode_operations;
+		vfs_inode->i_fop = &btrfs_dir_file_operations;
+		vfs_inode->i_op = &btrfs_dir_inode_operations;
 		break;
 	case S_IFLNK:
-		inode->i_op = &btrfs_symlink_inode_operations;
-		inode_nohighmem(inode);
-		inode->i_mapping->a_ops = &btrfs_aops;
+		vfs_inode->i_op = &btrfs_symlink_inode_operations;
+		inode_nohighmem(vfs_inode);
+		vfs_inode->i_mapping->a_ops = &btrfs_aops;
 		break;
 	default:
-		inode->i_op = &btrfs_special_inode_operations;
-		init_special_inode(inode, inode->i_mode, rdev);
+		vfs_inode->i_op = &btrfs_special_inode_operations;
+		init_special_inode(vfs_inode, vfs_inode->i_mode, rdev);
 		break;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(vfs_inode);
 
-	ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
+	ret = btrfs_add_inode_to_root(inode, true);
 	if (ret)
 		goto out;
 
 	return 0;
 out:
-	iget_failed(inode);
+	iget_failed(vfs_inode);
 	return ret;
 }
 
@@ -5636,7 +5633,7 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	ret = btrfs_read_locked_inode(inode, path);
+	ret = btrfs_read_locked_inode(BTRFS_I(inode), path);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -5664,7 +5661,7 @@ struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
-	ret = btrfs_read_locked_inode(inode, path);
+	ret = btrfs_read_locked_inode(BTRFS_I(inode), path);
 	btrfs_free_path(path);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.39.5




