Return-Path: <stable+bounces-204272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B1CEA798
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0BB13003FF4
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2022741B5;
	Tue, 30 Dec 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgD5kUPA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0711DD525
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767119542; cv=none; b=pBXKVr2vRUQ1L/XZLsaPGXrJuBnjg3+gWK1wXp/J3CLIK5Sncnw4etCmfG8Q0otguu6ZclMbqUODEHt1RDs1ZkKhGKfaArru7YxeurYPQgZcOAKlveTfmvve6a7ORRGB1CoUbMwkHhrR7K4hY1MSc6+67HK0mWUbiYw0pYq3u2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767119542; c=relaxed/simple;
	bh=l2BFBp56q5BUdh9FAxvh8/CRHN+/KtxEeEWJuqh1YqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYIi7wxEfaJM+QR0ovK2IVz8emc/v+2kMeCIyYlTl9dttsTSYJZnQzN38zynDS185TLvvsezVFITdJAh6Owu5ucPqtGqOj3DCbvowrf+ENeDmOpwdCk0oDuZCbUckIqCBLaR98UPF5CMLx2QIXJ9MdJGiqeGCpISGhGBSV6C/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgD5kUPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C33BC4CEFB;
	Tue, 30 Dec 2025 18:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767119542;
	bh=l2BFBp56q5BUdh9FAxvh8/CRHN+/KtxEeEWJuqh1YqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgD5kUPACs1IVI10KhyoTfGXlhVOypz5Htxi8+S5Pg32IMPiCdrM1rvWU6kRKPA/N
	 Inl3niKly7m0k1LpANuU0qPqv3CywDF9ls4LzUW8whPJsLgGKjum87b1AF6RCSMt6x
	 eTBqZL6UbcBo9EjTZJJaoJ1RQfLrfj3vjc9TkybjIEeK9ijljEHfmXuDNJHQR4LR9W
	 bjDnVspqrrmvI56fsKjpEuWnVlY1e0WHUkYPDwKk6AOeb/G5vW+U9wdnkP1cfVYbdA
	 9SqxuIF8JspM+c5DOpBOyrdNXwl8lhkIgqO0iFyHCkFMT/RcuLWmR914KVB9aRtJtD
	 K+MC8PBaPr6Fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
Date: Tue, 30 Dec 2025 13:32:19 -0500
Message-ID: <20251230183219.2392969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122945-sasquatch-unexposed-d830@gregkh>
References: <2025122945-sasquatch-unexposed-d830@gregkh>
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
 fs/f2fs/recovery.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e4d81b8705d1..bc105da3e746 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -398,7 +398,7 @@ static int sanity_check_node_chain(struct f2fs_sb_info *sbi, block_t blkaddr,
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-				bool check_only)
+				bool check_only, bool *new_inode)
 {
 	struct curseg_info *curseg;
 	struct page *page = NULL;
@@ -445,16 +445,19 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 				quota_inode = true;
 			}
 
-			/*
-			 * CP | dnode(F) | inode(DF)
-			 * For this case, we should not give up now.
-			 */
 			entry = add_fsync_inode(sbi, head, ino_of_node(page),
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
 				f2fs_put_page(page, 1);
 				break;
 			}
@@ -852,6 +855,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	int ret = 0;
 	unsigned long s_flags = sbi->sb->s_flags;
 	bool need_writecp = false;
+	bool new_inode = false;
 
 	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
 		f2fs_info(sbi, "recover fsync data on readonly fs");
@@ -864,8 +868,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
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


