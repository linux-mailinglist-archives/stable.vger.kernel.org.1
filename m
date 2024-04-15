Return-Path: <stable+bounces-39421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9843D8A4F1A
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235091F21C7E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E933EA7B;
	Mon, 15 Apr 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j2rHn88D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C11FA1
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184504; cv=none; b=aHBgtMybnv3rYdPdGUymq7Q8oXo819esaDaMQeHkZf89dRdbSas9B7o8SxRaqv1RCVW4Ci8wpj43IYMQan0/SpMgcjN4HeFvfyZoQSFIekX/ds0kBhAZUO5qpVG5FfZg4vYIUkCO36+1oEtK6JcYwUyGIQReANC35Jf/qVhVguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184504; c=relaxed/simple;
	bh=YJC/wlKHnzzQ6lbEcbTGszrAIFEUUVgsvNKNEb0Mzmc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UZc6IF2vlBu8DCqmeMXZwW0WbSnNBQtA3EvXhaQ7wjJpqHNbbFriRFyEUXZXlVN5rUfiT+r4F8ulEqiXFh33QhS4sHPM4harUTI27G+znCioq9HlFIc5FhuIz5TdBl/1rFIPMhlovoPYVgy1K8rubJmehf3Q7MzeFm++lTgjW/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j2rHn88D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68665C113CC;
	Mon, 15 Apr 2024 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713184503;
	bh=YJC/wlKHnzzQ6lbEcbTGszrAIFEUUVgsvNKNEb0Mzmc=;
	h=Subject:To:Cc:From:Date:From;
	b=j2rHn88DkgDoNbAkFVhvA6B7PiF+dLXLWQ4XUQJuY1va44FsC/5LmnasJPmWUp4/o
	 tIklCNaPt3sAKKCOjQ0bNVEQFCNi/Hx1RmfrlyAjUI+5tVJeBitkpvucZvIOnJ3iAJ
	 /L7bXvVRZgWCqiMY5aRpPyWR4x3uKyfy06b9imIY=
Subject: FAILED: patch "[PATCH] btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume" failed to apply to 6.1-stable tree
To: boris@bur.io,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 14:35:00 +0200
Message-ID: <2024041500-iodize-marina-a41e@gregkh>
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
git cherry-pick -x 74e97958121aa1f5854da6effba70143f051b0cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041500-iodize-marina-a41e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

74e97958121a ("btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations")
3324d0547861 ("btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted")
1b53e51a4a8f ("btrfs: don't commit transaction for every subvol create")
45c40c8f9541 ("btrfs: move root tree prototypes to their own header")
2839c2c142dd ("btrfs: move delalloc space related prototypes to delalloc-space.h")
a0231804affe ("btrfs: move extent-tree helpers into their own header file")
e2f13b343c14 ("btrfs: move btrfs_account_ro_block_groups_free_space into space-info.c")
8483d40242c5 ("btrfs: remove extra space info prototypes in ctree.h")
6db75318823a ("btrfs: use struct fscrypt_str instead of struct qstr")
ab3c5c18e8fa ("btrfs: setup qstr from dentrys using fscrypt helper")
e43eec81c516 ("btrfs: use struct qstr instead of name and namelen pairs")
07e81dc94474 ("btrfs: move accessor helpers into accessors.h")
ad1ac5012c2b ("btrfs: move btrfs_map_token to accessors")
55e5cfd36da5 ("btrfs: remove fs_info::pending_changes and related code")
7966a6b5959b ("btrfs: move fs_info::flags enum to fs.h")
fc97a410bd78 ("btrfs: move mount option definitions to fs.h")
0d3a9cf8c306 ("btrfs: convert incompat and compat flag test helpers to macros")
ec8eb376e271 ("btrfs: move BTRFS_FS_STATE* definitions and helpers to fs.h")
9b569ea0be6f ("btrfs: move the printk helpers out of ctree.h")
e118578a8df7 ("btrfs: move assert helpers out of ctree.h")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74e97958121aa1f5854da6effba70143f051b0cd Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Thu, 21 Mar 2024 10:02:04 -0700
Subject: [PATCH] btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume
 operations

Create subvolume, create snapshot and delete subvolume all use
btrfs_subvolume_reserve_metadata() to reserve metadata for the changes
done to the parent subvolume's fs tree, which cannot be mediated in the
normal way via start_transaction. When quota groups (squota or qgroups)
are enabled, this reserves qgroup metadata of type PREALLOC. Once the
operation is associated to a transaction, we convert PREALLOC to
PERTRANS, which gets cleared in bulk at the end of the transaction.

However, the error paths of these three operations were not implementing
this lifecycle correctly. They unconditionally converted the PREALLOC to
PERTRANS in a generic cleanup step regardless of errors or whether the
operation was fully associated to a transaction or not. This resulted in
error paths occasionally converting this rsv to PERTRANS without calling
record_root_in_trans successfully, which meant that unless that root got
recorded in the transaction by some other thread, the end of the
transaction would not free that root's PERTRANS, leaking it. Ultimately,
this resulted in hitting a WARN in CONFIG_BTRFS_DEBUG builds at unmount
for the leaked reservation.

The fix is to ensure that every qgroup PREALLOC reservation observes the
following properties:

1. any failure before record_root_in_trans is called successfully
   results in freeing the PREALLOC reservation.
2. after record_root_in_trans, we convert to PERTRANS, and now the
   transaction owns freeing the reservation.

This patch enforces those properties on the three operations. Without
it, generic/269 with squotas enabled at mkfs time would fail in ~5-10
runs on my system. With this patch, it ran successfully 1000 times in a
row.

Fixes: e85fde5162bf ("btrfs: qgroup: fix qgroup meta rsv leak for subvolume operations")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 37701531eeb1..1f9e74c4161d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4503,6 +4503,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_block_rsv block_rsv;
 	u64 root_flags;
+	u64 qgroup_reserved = 0;
 	int ret;
 
 	down_write(&fs_info->subvol_sem);
@@ -4547,12 +4548,20 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
 	if (ret)
 		goto out_undead;
+	qgroup_reserved = block_rsv.qgroup_rsv_reserved;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_release;
 	}
+	ret = btrfs_record_root_in_trans(trans, root);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto out_end_trans;
+	}
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+	qgroup_reserved = 0;
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
 
@@ -4611,7 +4620,9 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	ret = btrfs_end_transaction(trans);
 	inode->i_flags |= S_DEAD;
 out_release:
-	btrfs_subvolume_release_metadata(root, &block_rsv);
+	btrfs_block_rsv_release(fs_info, &block_rsv, (u64)-1, NULL);
+	if (qgroup_reserved)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 out_undead:
 	if (ret) {
 		spin_lock(&dest->root_item_lock);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 38459a89b27c..5a507237c4fa 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -613,6 +613,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 	int ret;
 	dev_t anon_dev;
 	u64 objectid;
+	u64 qgroup_reserved = 0;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
 	if (!root_item)
@@ -650,13 +651,18 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 					       trans_num_items, false);
 	if (ret)
 		goto out_new_inode_args;
+	qgroup_reserved = block_rsv.qgroup_rsv_reserved;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
-		btrfs_subvolume_release_metadata(root, &block_rsv);
-		goto out_new_inode_args;
+		goto out_release_rsv;
 	}
+	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
+	if (ret)
+		goto out;
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+	qgroup_reserved = 0;
 	trans->block_rsv = &block_rsv;
 	trans->bytes_reserved = block_rsv.size;
 	/* Tree log can't currently deal with an inode which is a new root. */
@@ -767,9 +773,11 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 out:
 	trans->block_rsv = NULL;
 	trans->bytes_reserved = 0;
-	btrfs_subvolume_release_metadata(root, &block_rsv);
-
 	btrfs_end_transaction(trans);
+out_release_rsv:
+	btrfs_block_rsv_release(fs_info, &block_rsv, (u64)-1, NULL);
+	if (qgroup_reserved)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 out_new_inode_args:
 	btrfs_new_inode_args_destroy(&new_inode_args);
 out_inode:
@@ -791,6 +799,8 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	struct btrfs_pending_snapshot *pending_snapshot;
 	unsigned int trans_num_items;
 	struct btrfs_trans_handle *trans;
+	struct btrfs_block_rsv *block_rsv;
+	u64 qgroup_reserved = 0;
 	int ret;
 
 	/* We do not support snapshotting right now. */
@@ -827,19 +837,19 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		goto free_pending;
 	}
 
-	btrfs_init_block_rsv(&pending_snapshot->block_rsv,
-			     BTRFS_BLOCK_RSV_TEMP);
+	block_rsv = &pending_snapshot->block_rsv;
+	btrfs_init_block_rsv(block_rsv, BTRFS_BLOCK_RSV_TEMP);
 	/*
 	 * 1 to add dir item
 	 * 1 to add dir index
 	 * 1 to update parent inode item
 	 */
 	trans_num_items = create_subvol_num_items(inherit) + 3;
-	ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root,
-					       &pending_snapshot->block_rsv,
+	ret = btrfs_subvolume_reserve_metadata(BTRFS_I(dir)->root, block_rsv,
 					       trans_num_items, false);
 	if (ret)
 		goto free_pending;
+	qgroup_reserved = block_rsv->qgroup_rsv_reserved;
 
 	pending_snapshot->dentry = dentry;
 	pending_snapshot->root = root;
@@ -852,6 +862,13 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 		ret = PTR_ERR(trans);
 		goto fail;
 	}
+	ret = btrfs_record_root_in_trans(trans, BTRFS_I(dir)->root);
+	if (ret) {
+		btrfs_end_transaction(trans);
+		goto fail;
+	}
+	btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
+	qgroup_reserved = 0;
 
 	trans->pending_snapshot = pending_snapshot;
 
@@ -881,7 +898,9 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (ret && pending_snapshot->snap)
 		pending_snapshot->snap->anon_dev = 0;
 	btrfs_put_root(pending_snapshot->snap);
-	btrfs_subvolume_release_metadata(root, &pending_snapshot->block_rsv);
+	btrfs_block_rsv_release(fs_info, block_rsv, (u64)-1, NULL);
+	if (qgroup_reserved)
+		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserved);
 free_pending:
 	if (pending_snapshot->anon_dev)
 		free_anon_bdev(pending_snapshot->anon_dev);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 4bb538a372ce..7007f9e0c972 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -548,13 +548,3 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 	}
 	return ret;
 }
-
-void btrfs_subvolume_release_metadata(struct btrfs_root *root,
-				      struct btrfs_block_rsv *rsv)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	u64 qgroup_to_release;
-
-	btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
-	btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);
-}
diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
index 6f929cf3bd49..8f5739e732b9 100644
--- a/fs/btrfs/root-tree.h
+++ b/fs/btrfs/root-tree.h
@@ -18,8 +18,6 @@ struct btrfs_trans_handle;
 int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 				     struct btrfs_block_rsv *rsv,
 				     int nitems, bool use_global_rsv);
-void btrfs_subvolume_release_metadata(struct btrfs_root *root,
-				      struct btrfs_block_rsv *rsv);
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		       u64 ref_id, u64 dirid, u64 sequence,
 		       const struct fscrypt_str *name);


