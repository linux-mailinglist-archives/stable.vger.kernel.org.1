Return-Path: <stable+bounces-106249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE229FE3AE
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4323A1F2B
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A819F49F;
	Mon, 30 Dec 2024 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhPabfCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A325948E
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547234; cv=none; b=SgBaOrW9GDNJPPT3Gg578LKhakpS7Ea/wIlD3t62mNrklfubGBI7i9ewBiHINqzMnyNcaVl7GJE8RAhphrJu9/PqRXtLLoJUwWB0rvvyBex8/78yi9+ygT2DUu9aVcVbX8oL7PmvVixAQnjSMcNLRh3WObP8N2xqSkWaZTTopC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547234; c=relaxed/simple;
	bh=QOadnlFxKVk2tvRMfqyRLZbOK5aocAs43PU13a1oJro=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jtLjEnonCWsK8aznvFbzW0njp3E16x35Ts4BGeZuaa5P1rpTr+8q/dx3pK0HG671RpDdyJtfntxuz7uy2UzmlEHT9lZYoSQcX0iGyajluTo6u4WA28z+glHa8SpYM9hVBVJdz64RGey+TP4M0czusqXpiTpqPSDu3Dg9F3l/IpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhPabfCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0768C4CED0;
	Mon, 30 Dec 2024 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547233;
	bh=QOadnlFxKVk2tvRMfqyRLZbOK5aocAs43PU13a1oJro=;
	h=Subject:To:Cc:From:Date:From;
	b=qhPabfCETSwLbE48/f+0j96m2fxpFAshpnLxd9BUJyt40/tvXsvl5EfzSwdP0Q2Rv
	 eM55+fRw2bFFayWSQboVEFXHxUnN7UjEDDc6kea9EuYAQPp3Gi68WBo4XMeD9QbzUf
	 y333tmeXfYvS/48iqsbBWu9nWq9RPSP4udAcDlWc=
Subject: FAILED: patch "[PATCH] btrfs: fix race with memory mapped writes when activating" failed to apply to 6.6-stable tree
To: fdmanana@suse.com,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:27:09 +0100
Message-ID: <2024123009-carbon-thrower-2611@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0525064bb82e50d59543b62b9d41a606198a4a44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123009-carbon-thrower-2611@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0525064bb82e50d59543b62b9d41a606198a4a44 Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Fri, 29 Nov 2024 12:25:30 +0000
Subject: [PATCH] btrfs: fix race with memory mapped writes when activating
 swap file

When activating the swap file we flush all delalloc and wait for ordered
extent completion, so that we don't miss any delalloc and extents before
we check that the file's extent layout is usable for a swap file and
activate the swap file. We are called with the inode's VFS lock acquired,
so we won't race with buffered and direct IO writes, however we can still
race with memory mapped writes since they don't acquire the inode's VFS
lock. The race window is between flushing all delalloc and locking the
whole file's extent range, since memory mapped writes lock an extent range
with the length of a page.

Fix this by acquiring the inode's mmap lock before we flush delalloc.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6baa0269a85b..b2abc0aa5300 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9809,6 +9809,15 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	u64 isize;
 	u64 start;
 
+	/*
+	 * Acquire the inode's mmap lock to prevent races with memory mapped
+	 * writes, as they could happen after we flush delalloc below and before
+	 * we lock the extent range further below. The inode was already locked
+	 * up in the call chain.
+	 */
+	btrfs_assert_inode_locked(BTRFS_I(inode));
+	down_write(&BTRFS_I(inode)->i_mmap_lock);
+
 	/*
 	 * If the swap file was just created, make sure delalloc is done. If the
 	 * file changes again after this, the user is doing something stupid and
@@ -9816,22 +9825,25 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	 */
 	ret = btrfs_wait_ordered_range(BTRFS_I(inode), 0, (u64)-1);
 	if (ret)
-		return ret;
+		goto out_unlock_mmap;
 
 	/*
 	 * The inode is locked, so these flags won't change after we check them.
 	 */
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_COMPRESS) {
 		btrfs_warn(fs_info, "swapfile must not be compressed");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock_mmap;
 	}
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW)) {
 		btrfs_warn(fs_info, "swapfile must not be copy-on-write");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock_mmap;
 	}
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
 		btrfs_warn(fs_info, "swapfile must not be checksummed");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock_mmap;
 	}
 
 	/*
@@ -9846,7 +9858,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_SWAP_ACTIVATE)) {
 		btrfs_warn(fs_info,
 	   "cannot activate swapfile while exclusive operation is running");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_unlock_mmap;
 	}
 
 	/*
@@ -9860,7 +9873,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		btrfs_exclop_finish(fs_info);
 		btrfs_warn(fs_info,
 	   "cannot activate swapfile because snapshot creation is in progress");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_unlock_mmap;
 	}
 	/*
 	 * Snapshots can create extents which require COW even if NODATACOW is
@@ -9881,7 +9895,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		btrfs_warn(fs_info,
 		"cannot activate swapfile because subvolume %llu is being deleted",
 			btrfs_root_id(root));
-		return -EPERM;
+		ret = -EPERM;
+		goto out_unlock_mmap;
 	}
 	atomic_inc(&root->nr_swapfiles);
 	spin_unlock(&root->root_item_lock);
@@ -10036,6 +10051,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 
 	btrfs_exclop_finish(fs_info);
 
+out_unlock_mmap:
+	up_write(&BTRFS_I(inode)->i_mmap_lock);
 	if (ret)
 		return ret;
 


