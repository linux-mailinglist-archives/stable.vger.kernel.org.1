Return-Path: <stable+bounces-16100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367583F04E
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560E01C216CC
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026541B5BB;
	Sat, 27 Jan 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z9H3yzFp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46311B297
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392536; cv=none; b=P733UxCMSIU1F2rcSk02TqK2gPUT+9YhknMwtFdbhZh9J0nzsyv/ZFuJnTdIMl43AE9xiFmcT+0R6IL6dMIxrI8b8oakp33TJLLthal44PbIdY7WayxPpqbhHJlYeqydiVM9c3kOc3zVhzgXzS+rHQgeGgpXmqhIfBueX/Hisos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392536; c=relaxed/simple;
	bh=SeBfzVgo84//liQZAcTBmbfz9AkSKtUYwNZKNnAKRZ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=as7zsOnKFGsBhsCbRWLEOdXlcdRzxQLF9vKDaU6rznST+6XsKsd66EbHwYYwbGnlZpR7Nclb90TP3PHAzvyGXbwGuV2bM0A+jCFHGmhjQpY9FPqa2PWAYINqyo7u2KgBuCWxJQpVJ1ZjyQeP2GtmR0gDpoPV75408oXoTaFBJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z9H3yzFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA58C43390;
	Sat, 27 Jan 2024 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706392536;
	bh=SeBfzVgo84//liQZAcTBmbfz9AkSKtUYwNZKNnAKRZ0=;
	h=Subject:To:Cc:From:Date:From;
	b=Z9H3yzFpkxJTj6GqpQ0+nbrPUIuJGT1/rWe6f4gphYQWj8+P1Ni/sHCxc0maxhgax
	 KYZtMo+X06tLlGDPkJ0L4RcSX5oHgV1j9ckGJfsZWtu7whRSUTEZuaRno0csqobb0j
	 v0HLgaLeGqbQwZ01NHD5cuZruQ494FeTCMaHxUM8=
Subject: FAILED: patch "[PATCH] btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot" failed to apply to 5.10-stable tree
To: osandov@fb.com,anand.jain@oracle.com,dsterba@suse.com,sweettea-kernel@dorminy.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 13:55:35 -0800
Message-ID: <2024012735-gentile-overture-2afa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3324d0547861b16cf436d54abba7052e0c8aa9de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012735-gentile-overture-2afa@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

3324d0547861 ("btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted")
60021bd754c6 ("btrfs: prevent subvol with swapfile from being deleted")
dd0734f2a866 ("btrfs: fix race between swap file activation and snapshot creation")
ee0d904fd9c5 ("btrfs: remove err variable from btrfs_delete_subvolume")

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


