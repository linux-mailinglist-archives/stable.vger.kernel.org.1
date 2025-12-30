Return-Path: <stable+bounces-204284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49CCEA904
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 20:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 816D53015840
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A023191D6;
	Tue, 30 Dec 2025 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qULAKCo8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3A318143
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124473; cv=none; b=pN8UAJ/UVgc/4SbOngS1t2e6mV/pfKxFdhxtPz3jGL29lAWon+ZA1V+PQ+aZIfw/T+S+L12hELbeOmScJG6Jrko2ihvhTTOKcWBZgZ1aX67Se77NCcJgUr0XOEb/wI4pl5kFCsAcL1K6qiIe6xxnDOD1RaQAOfQzz5c22pjnboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124473; c=relaxed/simple;
	bh=368b8mKxQ52ZOhC3oq1R4dilkTIwP7Tsa6tVTx+vpK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI3CHC8yjGzarxraV0Z0gn3s44Nl8U0mv6TyukhutJTOpDGvRV0TVtfGQFH8QJ/H7ziMyx1yBs4KehR7MxzJOavfi3REbSLSUTagDZ8HGVpPpou1hiO0jp4mRjxQbHmCqcqpgP26xVL4nl1wtOU+IVPeKGKFX6RKhwst5uQmbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qULAKCo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAD4C4CEFB;
	Tue, 30 Dec 2025 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767124473;
	bh=368b8mKxQ52ZOhC3oq1R4dilkTIwP7Tsa6tVTx+vpK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qULAKCo8SFQjxEOVUy64VWsQK2RfQQmWLmTNbvxYQyDKvdpUyvlxyKo4/qoWq8Vno
	 6Skt6n45LS04+/suxh7fhjHBYbLECn2wP3cemUhZqexeFitHJDZY0cGxe6JAZuov5b
	 a1MlrWYuXnoYd8HBnXAt4SbXaoiuZSDOBQ8FRlH73G8wJLlDc/HPPNp4amwUULqLpM
	 0B+u4CvOk9q5mUPwCsUlvFV4Nv8OHBF5qeH9ozI6pMUBcaVanktT1hOWYzpt8JQmES
	 3fSwdZkNYmFXAs5AwlSCK088dxW1vys8I0Lhi8/reQd84ujSoPGSrH+oFvkZTWGOOf
	 MEb2yWoVLiQ9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
Date: Tue, 30 Dec 2025 14:54:31 -0500
Message-ID: <20251230195431.2446807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122952-earlobe-rework-7c0d@gregkh>
References: <2025122952-earlobe-rework-7c0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 68d05693f8c031257a0822464366e1c2a239a512 ]

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
[ folio => page ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index f5efc37a2b51..0bf1d2854ffe 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -361,7 +361,7 @@ static unsigned int adjust_por_ra_blocks(struct f2fs_sb_info *sbi,
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-				bool check_only)
+				bool check_only, bool *new_inode)
 {
 	struct curseg_info *curseg;
 	struct page *page = NULL;
@@ -419,6 +419,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			if (IS_ERR(entry)) {
 				err = PTR_ERR(entry);
 				if (err == -ENOENT) {
+					if (check_only)
+						*new_inode = true;
 					err = 0;
 					goto next;
 				}
@@ -835,6 +837,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	unsigned long s_flags = sbi->sb->s_flags;
 	bool need_writecp = false;
 	bool fix_curseg_write_pointer = false;
+	bool new_inode = false;
 #ifdef CONFIG_QUOTA
 	int quota_enabled;
 #endif
@@ -857,8 +860,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	f2fs_down_write(&sbi->cp_global_sem);
 
 	/* step #1: find fsynced inode numbers */
-	err = find_fsync_dnodes(sbi, &inode_list, check_only);
-	if (err || list_empty(&inode_list))
+	err = find_fsync_dnodes(sbi, &inode_list, check_only, &new_inode);
+	if (err < 0 || (list_empty(&inode_list) && (!check_only || !new_inode)))
 		goto skip;
 
 	if (check_only) {
-- 
2.51.0


