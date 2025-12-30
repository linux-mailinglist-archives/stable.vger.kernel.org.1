Return-Path: <stable+bounces-204288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F366CEA9B7
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 21:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA883016DFB
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47495165F1A;
	Tue, 30 Dec 2025 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK0vbsKz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7E1F95C
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126696; cv=none; b=X4ckKIOxmA1hVzjHUK/ivGEWPbwE3mKv9D0hNp16GpGunRi1yOdrNs4Tdo3tdixhzaHJ1N4iLzXmSF4A9klA3Sg7VKNrAsl/9my1fjLZaoVynCp7MhDDzlFgwlt+QNZvf6piiSMbSP+fDwAfL+M2Oc4kv45X7uoHGaQ5rMdOMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126696; c=relaxed/simple;
	bh=pdpsxcLXeM3oG/8WKZRlg79yJjaVwCG/ymvYAhF6r5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJZ7jHDtBXYSR1nRWgff/584tLym2P3bXt6AWUgSRoloLNzKvFEnApfvWUKeqdDx2Li0/siefXy+p7eus97ngbC5u8SVeufzApraRB/gkGxwEprOQ7/2NUnxfWmQy4ebASmJVgBc7cFKZn1ebzjVCD7itvs6Rr260P+akGfiuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK0vbsKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D518BC4CEFB;
	Tue, 30 Dec 2025 20:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767126695;
	bh=pdpsxcLXeM3oG/8WKZRlg79yJjaVwCG/ymvYAhF6r5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sK0vbsKznHus4dlZioXiMsuNsn2P81kgDWeq/BHqwsLbVTgzLszWGVnwCYre14GAZ
	 iZRMUONH5NFV9fubH42FkNqgHuWtMJ7LqRRSaRg6gFK0mtCYrdevQR24M+ue5Hl5P7
	 G9gw26eNVH7yVoGeVW6hAi7TDtwjHa+BrV5IAUbpY/uUMZEARVCRAWEMpf1IfeXP0O
	 eKr3aBLZpF0ZD/Yv3p7TPtjsLY0HTECHOEJiDK+F4ddLfgagvvFoaKHb7reZzRz0Rg
	 vbdIAwnqWyXs2BUICRWzGCtBV33W7JsT7VuZL5HDs7/ZjSR4X8I4yJFKGklZIlDBvs
	 x1u59ky6C/FPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
Date: Tue, 30 Dec 2025 15:31:33 -0500
Message-ID: <20251230203133.2457797-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122953-federal-handclasp-1d09@gregkh>
References: <2025122953-federal-handclasp-1d09@gregkh>
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
index cd56af93df42..320553b45ee9 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -328,7 +328,7 @@ static int recover_inode(struct inode *inode, struct page *page)
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-				bool check_only)
+				bool check_only, bool *new_inode)
 {
 	struct curseg_info *curseg;
 	struct page *page = NULL;
@@ -385,6 +385,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			if (IS_ERR(entry)) {
 				err = PTR_ERR(entry);
 				if (err == -ENOENT) {
+					if (check_only)
+						*new_inode = true;
 					err = 0;
 					goto next;
 				}
@@ -789,6 +791,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	unsigned long s_flags = sbi->sb->s_flags;
 	bool need_writecp = false;
 	bool fix_curseg_write_pointer = false;
+	bool new_inode = false;
 #ifdef CONFIG_QUOTA
 	int quota_enabled;
 #endif
@@ -813,8 +816,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	mutex_lock(&sbi->cp_mutex);
 
 	/* step #1: find fsynced inode numbers */
-	err = find_fsync_dnodes(sbi, &inode_list, check_only);
-	if (err || list_empty(&inode_list))
+	err = find_fsync_dnodes(sbi, &inode_list, check_only, &new_inode);
+	if (err < 0 || (list_empty(&inode_list) && (!check_only || !new_inode)))
 		goto skip;
 
 	if (check_only) {
-- 
2.51.0


