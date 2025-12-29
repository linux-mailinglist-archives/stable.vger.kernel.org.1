Return-Path: <stable+bounces-203597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA1CE6F64
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0884301118F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59A72165EA;
	Mon, 29 Dec 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kY2iTw/P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4F1F4C8E
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016856; cv=none; b=Yv6nLQvUhhYmr8/GWsKt83SKa2OLG6u6W1a4pbMieoO4wMe74VSt6CPUT5yrBC2xO2K7FM5gg8IrJua12ZVBeDo+gVJsJJVUKNuzRTJlxKHIRWj7uT2THAAUgxJT9s6rNmlW6H415BWpUCz5fk4N9ir7ejcFsGByN44hfZr7+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016856; c=relaxed/simple;
	bh=RhivbTe2Mon9tbPDb29xosLlI3FCzVQwk9w5hCZ8+yo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rxSkj/AZdNKJNvT+c1RNUCOEQ6do3ILqF7cjhaln1w2z5/SPk79FAqml3beXPl0IRV6eTeUFYJbY47x/nchmgjD6uFPAqrRUT3Tc7UjtRYvdbLC4VRMcl90Lh5H+6hqGmQS8+nT394+GVxsLyoltRn8vPiPbMHfp3oHqjWkhT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kY2iTw/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF2DC4CEF7;
	Mon, 29 Dec 2025 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016856;
	bh=RhivbTe2Mon9tbPDb29xosLlI3FCzVQwk9w5hCZ8+yo=;
	h=Subject:To:Cc:From:Date:From;
	b=kY2iTw/Pqplo7HgUc3a7U/noQvJlLMv9YVqnXuRAXBhWwyNcjns9WkWBL2bhNFYDa
	 atxkQFXxHr8rtY/ZhqSLOmB/2vFWhDtGKXyfsoof46vplmUX5gwr/mB6NXonQuEUfL
	 ZuSWbEYS0LULBoSHzPizsI1QX9/5lOxeg52FdWvE=
Subject: FAILED: patch "[PATCH] f2fs: fix to detect recoverable inode during dryrun of" failed to apply to 6.6-stable tree
To: chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:00:51 +0100
Message-ID: <2025122951-marvelous-paramount-6494@gregkh>
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
git cherry-pick -x 68d05693f8c031257a0822464366e1c2a239a512
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122951-marvelous-paramount-6494@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68d05693f8c031257a0822464366e1c2a239a512 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Wed, 5 Nov 2025 14:50:23 +0800
Subject: [PATCH] f2fs: fix to detect recoverable inode during dryrun of
 find_fsync_dnodes()

mkfs.f2fs -f /dev/vdd
mount /dev/vdd /mnt/f2fs
touch /mnt/f2fs/foo
sync		# avoid CP_UMOUNT_FLAG in last f2fs_checkpoint.ckpt_flags
touch /mnt/f2fs/bar
f2fs_io fsync /mnt/f2fs/bar
f2fs_io shutdown 2 /mnt/f2fs
umount /mnt/f2fs
blockdev --setro /dev/vdd
mount /dev/vdd /mnt/f2fs
mount: /mnt/f2fs: WARNING: source write-protected, mounted read-only.

For the case if we create and fsync a new inode before sudden power-cut,
without norecovery or disable_roll_forward mount option, the following
mount will succeed w/o recovering last fsynced inode.

The problem here is that we only check inode_list list after
find_fsync_dnodes() in f2fs_recover_fsync_data() to find out whether
there is recoverable data in the iamge, but there is a missed case, if
last fsynced inode is not existing in last checkpoint, then, we will
fail to get its inode due to nat of inode node is not existing in last
checkpoint, so the inode won't be linked in inode_list.

Let's detect such case in dyrun mode to fix this issue.

After this change, mount will fail as expected below:
mount: /mnt/f2fs: cannot mount /dev/vdd read-only.
       dmesg(1) may have more information after failed mount system call.
demsg:
F2FS-fs (vdd): Need to recover fsync data, but write access unavailable, please try mount w/ disable_roll_forward or norecovery

Cc: stable@kernel.org
Fixes: 6781eabba1bd ("f2fs: give -EINVAL for norecovery and rw mount")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 215e442db72c..d7faebaa3c6b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -399,7 +399,7 @@ static int sanity_check_node_chain(struct f2fs_sb_info *sbi, block_t blkaddr,
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-				bool check_only)
+				bool check_only, bool *new_inode)
 {
 	struct curseg_info *curseg;
 	block_t blkaddr, blkaddr_fast;
@@ -447,16 +447,19 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 				quota_inode = true;
 			}
 
-			/*
-			 * CP | dnode(F) | inode(DF)
-			 * For this case, we should not give up now.
-			 */
 			entry = add_fsync_inode(sbi, head, ino_of_node(folio),
 								quota_inode);
 			if (IS_ERR(entry)) {
 				err = PTR_ERR(entry);
-				if (err == -ENOENT)
+				/*
+				 * CP | dnode(F) | inode(DF)
+				 * For this case, we should not give up now.
+				 */
+				if (err == -ENOENT) {
+					if (check_only)
+						*new_inode = true;
 					goto next;
+				}
 				f2fs_folio_put(folio, true);
 				break;
 			}
@@ -875,6 +878,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	int ret = 0;
 	unsigned long s_flags = sbi->sb->s_flags;
 	bool need_writecp = false;
+	bool new_inode = false;
 
 	f2fs_notice(sbi, "f2fs_recover_fsync_data: recovery fsync data, "
 					"check_only: %d", check_only);
@@ -890,8 +894,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	f2fs_down_write(&sbi->cp_global_sem);
 
 	/* step #1: find fsynced inode numbers */
-	err = find_fsync_dnodes(sbi, &inode_list, check_only);
-	if (err || list_empty(&inode_list))
+	err = find_fsync_dnodes(sbi, &inode_list, check_only, &new_inode);
+	if (err < 0 || (list_empty(&inode_list) && (!check_only || !new_inode)))
 		goto skip;
 
 	if (check_only) {


