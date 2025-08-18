Return-Path: <stable+bounces-169978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0B5B29F72
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9140416B017
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F051258EFD;
	Mon, 18 Aug 2025 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QempKYYS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFD258ED3
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514068; cv=none; b=ctoMFjRcRRRi0VtANlWZtpCDU8HGBsv7Yu4mkN6JNtobELTDKAZdQv9ZXTfzluF5K0vo7f4gFqshLRhLzHAXCMncUhGRFaEqKkExZZkjyjXSsSht0bYIFYSXfYCVJ493y36vw+qRBsOUizuLpiebmf1ZlZ4nDZXe+VnRBc8nHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514068; c=relaxed/simple;
	bh=mr8cukb4SkPhmewWvYaneTQuXmexokIfT8iRbep18ks=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MJF4w13F00JyiwBMJwASrPPeE0cQ1aQRWHH3I1rQsUwCr/JX73anZnhPYBDCrykB31wRCp5Gli/rcgsh3L06S9QBM/oraAU4LZ+xlqgKxCqu5JsQPOy7Z2XoMAm56npjNDsoVFwWMomF5DEAFGiaR3Z13d+yQsztaEZoazIx6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QempKYYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34792C4CEEB;
	Mon, 18 Aug 2025 10:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514067;
	bh=mr8cukb4SkPhmewWvYaneTQuXmexokIfT8iRbep18ks=;
	h=Subject:To:Cc:From:Date:From;
	b=QempKYYScYENowT5iVHVeB/iVm8RLiVd8Qg8WibR8qlaTTPqAsqtnFA4USq87Oy7v
	 6QYP0tn1gWQbWNDHAGGB/DK4qtZQVZgDokC5fMU/r3NuBw9eN6bbDJZ2plxyKbRZsT
	 rEVT3duV7GrtnIgMBgRcylDsDK2+fsqS2n5bW4kU=
Subject: FAILED: patch "[PATCH] btrfs: qgroup: fix race between quota disable and quota" failed to apply to 6.6-stable tree
To: fdmanana@suse.com,boris@bur.io,dsterba@suse.com,wqu@suse.com,zzzccc427@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:47:31 +0200
Message-ID: <2025081831-cancel-lunchtime-0e51@gregkh>
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
git cherry-pick -x e1249667750399a48cafcf5945761d39fa584edf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081831-cancel-lunchtime-0e51@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1249667750399a48cafcf5945761d39fa584edf Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Mon, 30 Jun 2025 13:19:20 +0100
Subject: [PATCH] btrfs: qgroup: fix race between quota disable and quota
 rescan ioctl

There's a race between a task disabling quotas and another running the
rescan ioctl that can result in a use-after-free of qgroup records from
the fs_info->qgroup_tree rbtree.

This happens as follows:

1) Task A enters btrfs_ioctl_quota_rescan() -> btrfs_qgroup_rescan();

2) Task B enters btrfs_quota_disable() and calls
   btrfs_qgroup_wait_for_completion(), which does nothing because at that
   point fs_info->qgroup_rescan_running is false (it wasn't set yet by
   task A);

3) Task B calls btrfs_free_qgroup_config() which starts freeing qgroups
   from fs_info->qgroup_tree without taking the lock fs_info->qgroup_lock;

4) Task A enters qgroup_rescan_zero_tracking() which starts iterating
   the fs_info->qgroup_tree tree while holding fs_info->qgroup_lock,
   but task B is freeing qgroup records from that tree without holding
   the lock, resulting in a use-after-free.

Fix this by taking fs_info->qgroup_lock at btrfs_free_qgroup_config().
Also at btrfs_qgroup_rescan() don't start the rescan worker if quotas
were already disabled.

Reported-by: cen zhang <zzzccc427@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com/
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b83d9534adae..310ca2dd9f24 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -636,22 +636,30 @@ bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info)
 
 /*
  * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
- * first two are in single-threaded paths.And for the third one, we have set
- * quota_root to be null with qgroup_lock held before, so it is safe to clean
- * up the in-memory structures without qgroup_lock held.
+ * first two are in single-threaded paths.
  */
 void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *n;
 	struct btrfs_qgroup *qgroup;
 
+	/*
+	 * btrfs_quota_disable() can be called concurrently with
+	 * btrfs_qgroup_rescan() -> qgroup_rescan_zero_tracking(), so take the
+	 * lock.
+	 */
+	spin_lock(&fs_info->qgroup_lock);
 	while ((n = rb_first(&fs_info->qgroup_tree))) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
 		rb_erase(n, &fs_info->qgroup_tree);
 		__del_qgroup_rb(qgroup);
+		spin_unlock(&fs_info->qgroup_lock);
 		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
 		kfree(qgroup);
+		spin_lock(&fs_info->qgroup_lock);
 	}
+	spin_unlock(&fs_info->qgroup_lock);
+
 	/*
 	 * We call btrfs_free_qgroup_config() when unmounting
 	 * filesystem and disabling quota, so we set qgroup_ulist
@@ -4036,12 +4044,21 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 	qgroup_rescan_zero_tracking(fs_info);
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	fs_info->qgroup_rescan_running = true;
-	btrfs_queue_work(fs_info->qgroup_rescan_workers,
-			 &fs_info->qgroup_rescan_work);
+	/*
+	 * The rescan worker is only for full accounting qgroups, check if it's
+	 * enabled as it is pointless to queue it otherwise. A concurrent quota
+	 * disable may also have just cleared BTRFS_FS_QUOTA_ENABLED.
+	 */
+	if (btrfs_qgroup_full_accounting(fs_info)) {
+		fs_info->qgroup_rescan_running = true;
+		btrfs_queue_work(fs_info->qgroup_rescan_workers,
+				 &fs_info->qgroup_rescan_work);
+	} else {
+		ret = -ENOTCONN;
+	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
-	return 0;
+	return ret;
 }
 
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,


