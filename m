Return-Path: <stable+bounces-88239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5AA9B2187
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794651C20A69
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00BF1878;
	Mon, 28 Oct 2024 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iWARbChK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722F6EEA8
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075049; cv=none; b=cVs4ba+HHa78jVqTxq94/MnhhlNtcJSzrn4bLazyrlyXL06Upo8YV6EHL56BucJ4Liu0HXHJ3x5Gf686FtywKibENRy2MuClUC2cMAT55G6ALPdfXytwdJVrq9gWj4nHNyYSn+BFFHi0LS3aucCEiiw1EsrG+JXtxARQOauVuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075049; c=relaxed/simple;
	bh=80BvHy3PqyTIPGx/HI9V9wl791e3ywfGlnbQLB2hsBY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YjQEvj/iwS5Mw8sHA9vj44pbyydhArWbRc1kzOd+0n0DFlyq0lbM0A37t72aOoTR01NPiqn1LOBH7cvNHWVivwMjY3lYudzY9QFNFZgPa46vMbHVbItQPMsFerEAw+YV/TEcimf1inY2TDpIdllBf5kx57GvSEV9iEnmbsig1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iWARbChK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA0FC4CEC3;
	Mon, 28 Oct 2024 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730075049;
	bh=80BvHy3PqyTIPGx/HI9V9wl791e3ywfGlnbQLB2hsBY=;
	h=Subject:To:Cc:From:Date:From;
	b=iWARbChKCydCI1zyNd8xihDG5v1C1y+XW902EDT/7uamS/Wy7F/hI4zF+Sd/Zinmi
	 Ng7hgIa/lNGV8UQ7noPcy4oZ7jqOVt4ZnFu6p548Vkdw+9qDnpmYwfUHH3oWS+44Mp
	 g4iod2J2ywxJAGrVbzmIdPJvFOA2TxuVq+MDesgM=
Subject: FAILED: patch "[PATCH] btrfs: qgroup: set a more sane default value for subtree drop" failed to apply to 6.6-stable tree
To: wqu@suse.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Oct 2024 01:23:56 +0100
Message-ID: <2024102856-chance-seventh-bedd@gregkh>
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
git cherry-pick -x 5f9062a48db260fd6b53d86ecfb4d5dc59266316
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102856-chance-seventh-bedd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


