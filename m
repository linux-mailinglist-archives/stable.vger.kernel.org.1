Return-Path: <stable+bounces-16102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC6F83F050
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A2AB21F93
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 21:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684921B279;
	Sat, 27 Jan 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DKe0mKvr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667833D5
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392540; cv=none; b=Vf8iCH9rnFEEurbuIl5boe8Gzgkkjv33FW66EqL2J3IeN5UowUstoKP/QLfWtPAcnHA3QBPhQMfi4Rxnu4PkSSUiAL+mTuf+eCkeYDTNc+FZccSXkTX6tm4bkcSnltWpxupoOt7HCgZac0DzAJS17oPDSF7mS29VakYe9UNPXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392540; c=relaxed/simple;
	bh=IcjJq27NJcjHD6qOdRns628VOHtMc4YRG53iQv1zn3c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TgBgdTHr7ktDGb2M/XNtY0uUYieEjg6Dqmx5NNicqmZn8gO9yGi0d7DrOf+bwKmAYIb7yo3OnoWhdMuF9quX6fphnTe9G3ZQEihg4gnyPfGZakj1wYVu5Y2MLOLvL2pJeDW/g7+u1KDhkw1Haej74y0/So7rW2v1tE9W5HNdUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DKe0mKvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5751C433F1;
	Sat, 27 Jan 2024 21:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706392539;
	bh=IcjJq27NJcjHD6qOdRns628VOHtMc4YRG53iQv1zn3c=;
	h=Subject:To:Cc:From:Date:From;
	b=DKe0mKvrVsEs9XpM7W6tnKoM5l4XOy2T8eCogXegSimPD/iv4in9KJg4ur8tjj6kS
	 jCo34v9CufmSQS7d5LJ2JgKdUNn8UHyLhmH5e6tULAQG1ufezFHfFQTFlbkXzLpibg
	 d5HlfOnEyRt1CZmvnNf0avd8z5K/cF+CL4tZI/Ek=
Subject: FAILED: patch "[PATCH] btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot" failed to apply to 4.19-stable tree
To: osandov@fb.com,anand.jain@oracle.com,dsterba@suse.com,sweettea-kernel@dorminy.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 13:55:38 -0800
Message-ID: <2024012738-abdomen-crimson-3018@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 3324d0547861b16cf436d54abba7052e0c8aa9de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012738-abdomen-crimson-3018@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

3324d0547861 ("btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted")
60021bd754c6 ("btrfs: prevent subvol with swapfile from being deleted")
dd0734f2a866 ("btrfs: fix race between swap file activation and snapshot creation")
ee0d904fd9c5 ("btrfs: remove err variable from btrfs_delete_subvolume")
c3e1f96c37d0 ("btrfs: enumerate the type of exclusive operation in progress")
e85fde5162bf ("btrfs: qgroup: fix qgroup meta rsv leak for subvolume operations")
adca4d945c8d ("btrfs: qgroup: remove ASYNC_COMMIT mechanism in favor of reserve retry-after-EDQUOT")
c11fbb6ed0dd ("btrfs: reduce lock contention when creating snapshot")
63f018be577f ("btrfs: Remove __ prefix from btrfs_block_rsv_release")
dcc3eb9638c3 ("btrfs: convert snapshot/nocow exlcusion to drew lock")
0024652895e3 ("btrfs: rename btrfs_put_fs_root and btrfs_grab_fs_root")
bd647ce385ec ("btrfs: add a leak check for roots")
8260edba67a2 ("btrfs: make the init of static elements in fs_info separate")
ae18c37ad5a1 ("btrfs: move fs_info init work into it's own helper function")
141386e1a5d6 ("btrfs: free more things in btrfs_free_fs_info")
bc44d7c4b2b1 ("btrfs: push btrfs_grab_fs_root into btrfs_get_fs_root")
81f096edf047 ("btrfs: use btrfs_put_fs_root to free roots always")
0d4b0463011d ("btrfs: export and rename free_fs_info")
fbb0ce40d606 ("btrfs: hold a ref on the root in btrfs_check_uuid_tree_entry")
ca2037fba6af ("btrfs: hold a ref on the root in btrfs_recover_log_trees")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3324d0547861b16cf436d54abba7052e0c8aa9de Mon Sep 17 00:00:00 2001
From: Omar Sandoval <osandov@fb.com>
Date: Thu, 4 Jan 2024 11:48:47 -0800
Subject: [PATCH] btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot
 of subvolume being deleted

Sweet Tea spotted a race between subvolume deletion and snapshotting
that can result in the root item for the snapshot having the
BTRFS_ROOT_SUBVOL_DEAD flag set. The race is:

Thread 1                                      | Thread 2
----------------------------------------------|----------
btrfs_delete_subvolume                        |
  btrfs_set_root_flags(BTRFS_ROOT_SUBVOL_DEAD)|
                                              |btrfs_mksubvol
                                              |  down_read(subvol_sem)
                                              |  create_snapshot
                                              |    ...
                                              |    create_pending_snapshot
                                              |      copy root item from source
  down_write(subvol_sem)                      |

This flag is only checked in send and swap activate, which this would
cause to fail mysteriously.

create_snapshot() now checks the root refs to reject a deleted
subvolume, so we can fix this by locking subvol_sem earlier so that the
BTRFS_ROOT_SUBVOL_DEAD flag and the root refs are updated atomically.

CC: stable@vger.kernel.org # 4.14+
Reported-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b3e39610cc95..7bcc1c03437a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4458,6 +4458,8 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	u64 root_flags;
 	int ret;
 
+	down_write(&fs_info->subvol_sem);
+
 	/*
 	 * Don't allow to delete a subvolume with send in progress. This is
 	 * inside the inode lock so the error handling that has to drop the bit
@@ -4469,25 +4471,25 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu during send",
 			   dest->root_key.objectid);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_up_write;
 	}
 	if (atomic_read(&dest->nr_swapfiles)) {
 		spin_unlock(&dest->root_item_lock);
 		btrfs_warn(fs_info,
 			   "attempt to delete subvolume %llu with active swapfile",
 			   root->root_key.objectid);
-		return -EPERM;
+		ret = -EPERM;
+		goto out_up_write;
 	}
 	root_flags = btrfs_root_flags(&dest->root_item);
 	btrfs_set_root_flags(&dest->root_item,
 			     root_flags | BTRFS_ROOT_SUBVOL_DEAD);
 	spin_unlock(&dest->root_item_lock);
 
-	down_write(&fs_info->subvol_sem);
-
 	ret = may_destroy_subvol(dest);
 	if (ret)
-		goto out_up_write;
+		goto out_undead;
 
 	btrfs_init_block_rsv(&block_rsv, BTRFS_BLOCK_RSV_TEMP);
 	/*
@@ -4497,7 +4499,7 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	 */
 	ret = btrfs_subvolume_reserve_metadata(root, &block_rsv, 5, true);
 	if (ret)
-		goto out_up_write;
+		goto out_undead;
 
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
@@ -4563,15 +4565,17 @@ int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
 	inode->i_flags |= S_DEAD;
 out_release:
 	btrfs_subvolume_release_metadata(root, &block_rsv);
-out_up_write:
-	up_write(&fs_info->subvol_sem);
+out_undead:
 	if (ret) {
 		spin_lock(&dest->root_item_lock);
 		root_flags = btrfs_root_flags(&dest->root_item);
 		btrfs_set_root_flags(&dest->root_item,
 				root_flags & ~BTRFS_ROOT_SUBVOL_DEAD);
 		spin_unlock(&dest->root_item_lock);
-	} else {
+	}
+out_up_write:
+	up_write(&fs_info->subvol_sem);
+	if (!ret) {
 		d_invalidate(dentry);
 		btrfs_prune_dentries(dest);
 		ASSERT(dest->send_in_progress == 0);


