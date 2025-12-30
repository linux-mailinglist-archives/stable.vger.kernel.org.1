Return-Path: <stable+bounces-204277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F15CEA819
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 19:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C74533004612
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9263A28489E;
	Tue, 30 Dec 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG1z/Gkb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DDF263C8A
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767120807; cv=none; b=EIEuwqgvPaHvKX7xEmg//AU9rm/DcNGzEZB9gnG87sVFt0gzejHfRyYGczGneqg3B2NexxAr6O9Z9OAfwqcoZtSXA0kogl7qEPG82GvBNN+60xhOe8CSk3sh930rrRDNfFPGduchP2+BlbAOVBxPtx5DYBD9ml2JG+uChYLh4I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767120807; c=relaxed/simple;
	bh=Dm1K5cv9e5Ic8TLpvjcRfYdf2HaPZzoOeWEwCJByhaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGQtzJKW9eCB5Ayzim4zKUTdP+/RYDV4L87Nq9rlYp+VxTIKMkwOMl9JRipo80LQHNaMRaKFKmpNmCQUkA8SzJ1o8RPGLUYIwpnInrhLhQOy3ZT2Mx8zvv/qn2ZyRSri+HhP7PFQ2eEkDyXB7cbNXAMj2u6fXsxWtKgcG4TYWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG1z/Gkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601F9C4CEFB;
	Tue, 30 Dec 2025 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767120807;
	bh=Dm1K5cv9e5Ic8TLpvjcRfYdf2HaPZzoOeWEwCJByhaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BG1z/GkbDD6VPPQJIyF4oh9Zic4hCEQ8dNOCoIAjY0Yf8s2RLkIX8wTHCL/ZtG5M/
	 YbyLnFiIGI9F9BEmpmBkZ+su5df5G+38y5xQHh0YdnxUvHTwEf6YkNZ7WSCZm0D6rk
	 IFooVLFGIFaE8D0qdMlmAucolh/jNUhoPtbw3xLevZ/spgGaFpDjmweaKS7dtVH9CM
	 qC0IwWI2miFQgw3tdSa2LTATHY1GoYP33i20aJ7wecDD7DKvtQm0MNU74qnzPYZHiR
	 VT6xICsoDWJB3zS7mlupIDZYxwidAKSYt/4cH+CqDOwOamlOBKCgApyAVuGV3Fkk0m
	 pXiZj1x7gjGxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
Date: Tue, 30 Dec 2025 13:53:24 -0500
Message-ID: <20251230185324.2411791-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122951-marvelous-paramount-6494@gregkh>
References: <2025122951-marvelous-paramount-6494@gregkh>
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
index f8852aa52640..3a5e02443943 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -405,7 +405,7 @@ static int sanity_check_node_chain(struct f2fs_sb_info *sbi, block_t blkaddr,
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-				bool check_only)
+				bool check_only, bool *new_inode)
 {
 	struct curseg_info *curseg;
 	struct page *page = NULL;
@@ -452,16 +452,19 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
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
@@ -864,6 +867,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	unsigned long s_flags = sbi->sb->s_flags;
 	bool need_writecp = false;
 	bool fix_curseg_write_pointer = false;
+	bool new_inode = false;
 
 	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
 		f2fs_info(sbi, "recover fsync data on readonly fs");
@@ -876,8 +880,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
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


