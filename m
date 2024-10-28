Return-Path: <stable+bounces-88240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6D9B2188
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BBE1F212B1
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5F1C14;
	Mon, 28 Oct 2024 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FNeh+3nT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F915C3
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075059; cv=none; b=o+3OZeUFL+PRfm+skBx5SqCLN3/rhzVTblwdlD4sKuReldXQNdln3FAXKuago4MOT1iXMB2ZX14C2RnAGeGljXDm5nzPEByAk0Qepr6TOSi4nBAQQGtE738Op0LU66xkimMPX6mkv+BfVPOnSYJMd7F9jslbTfvwEGm17layABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075059; c=relaxed/simple;
	bh=IYLffw5HVeUqANZzo7xZgJ8AG65aex+BlebLSAe6n/A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mgROoVqUHLxqNN0KRu4Ks+nN2ph3g3E3JWeesPePizXvnN/QhiKJ4venIk9VDQjnnAmBgji1Vtmnqib6vBf9mAVTrIYeOJV7/l8JDhRuuXqdygw4xNGCnYasNyWsit4L9gEQ5XmOJfJDqDyt7CFUlej3cuVrXaactGg68kyH23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FNeh+3nT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546DCC4CEC3;
	Mon, 28 Oct 2024 00:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730075058;
	bh=IYLffw5HVeUqANZzo7xZgJ8AG65aex+BlebLSAe6n/A=;
	h=Subject:To:Cc:From:Date:From;
	b=FNeh+3nTkR3pvKaGP7uQ6l9j3OuEI3CbsGOkdEYVX8nLupRRMYUuMy7CMiq/zPP9B
	 knnr4c5OXZEUva8PelN7swkEi9aVvuODFp83QOe604t1lMEKITQSFnb7hY5UUyONt9
	 Dx24CDj2O8Tml6nzijGpdCGkhZPnih9RZjiScVOM=
Subject: FAILED: patch "[PATCH] btrfs: qgroup: set a more sane default value for subtree drop" failed to apply to 6.1-stable tree
To: wqu@suse.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Oct 2024 01:23:58 +0100
Message-ID: <2024102858-yield-gestate-e6bc@gregkh>
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
git cherry-pick -x 5f9062a48db260fd6b53d86ecfb4d5dc59266316
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102858-yield-gestate-e6bc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5f9062a48db260fd6b53d86ecfb4d5dc59266316 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Tue, 10 Sep 2024 15:21:04 +0930
Subject: [PATCH] btrfs: qgroup: set a more sane default value for subtree drop
 threshold

Since commit 011b46c30476 ("btrfs: skip subtree scan if it's too high to
avoid low stall in btrfs_commit_transaction()"), btrfs qgroup can
automatically skip large subtree scan at the cost of marking qgroup
inconsistent.

It's designed to address the final performance problem of snapshot drop
with qgroup enabled, but to be safe the default value is
BTRFS_MAX_LEVEL, requiring a user space daemon to set a different value
to make it work.

I'd say it's not a good idea to rely on user space tool to set this
default value, especially when some operations (snapshot dropping) can
be triggered immediately after mount, leaving a very small window to
that that sysfs interface.

So instead of disabling this new feature by default, enable it with a
low threshold (3), so that large subvolume tree drop at mount time won't
cause huge qgroup workload.

CC: stable@vger.kernel.org # 6.1
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1238a38c59b2..5afb68c0304b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1959,7 +1959,7 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 	fs_info->qgroup_seq = 1;
 	fs_info->qgroup_ulist = NULL;
 	fs_info->qgroup_rescan_running = false;
-	fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
+	fs_info->qgroup_drop_subtree_thres = BTRFS_QGROUP_DROP_SUBTREE_THRES_DEFAULT;
 	mutex_init(&fs_info->qgroup_rescan_lock);
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1332ec59c539..a0e8deca87a7 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1407,7 +1407,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	fs_info->quota_root = NULL;
 	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
 	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
-	fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
+	fs_info->qgroup_drop_subtree_thres = BTRFS_QGROUP_DROP_SUBTREE_THRES_DEFAULT;
 	spin_unlock(&fs_info->qgroup_lock);
 
 	btrfs_free_qgroup_config(fs_info);
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 98adf4ec7b01..c229256d6fd5 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -121,6 +121,8 @@ struct btrfs_inode;
 #define BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN		(1ULL << 63)
 #define BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING		(1ULL << 62)
 
+#define BTRFS_QGROUP_DROP_SUBTREE_THRES_DEFAULT		(3)
+
 /*
  * Record a dirty extent, and info qgroup to update quota on it
  */


