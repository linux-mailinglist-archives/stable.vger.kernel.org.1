Return-Path: <stable+bounces-204287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBD9CEA95F
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 21:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A4B73027D9E
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 20:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C662FD7A7;
	Tue, 30 Dec 2025 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKryCmDN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C12FD1DC
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767125323; cv=none; b=gF1HFs7Sgk/IUtc72++2pV1lVkOAkcKrs/lgwrozFcEz7nXn4TR0T4gsERZgGfefkAN5k7R7BZrNJgXmVVnerhURstBpCMBzOLPX9kCASrg6wR3M0KGJk9hV2Yv3L3FNkq5zr5E0AeJh44PlWiQfdzbbMypXMKkvkyNDxJ0MBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767125323; c=relaxed/simple;
	bh=SYjY10ncylGr/7pw/RY3s9/74rVc/owflH40wKXhL8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVqtAZzd3/YjSXfxZ36qq9Kqi9H1knuX7dDVY9dQbBPHRWROr5Lh9LFyR1A93kyTyRf7+BqAPndLwaLJlSvVfdNjmIaVabBxLyIy4cICSWCiXODjt0B5PspsYcpA1fa/HWNcbVywm3cqQvHovb4qPxg32OZm4Y9XI+krsRW/8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKryCmDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE99C113D0;
	Tue, 30 Dec 2025 20:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767125323;
	bh=SYjY10ncylGr/7pw/RY3s9/74rVc/owflH40wKXhL8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKryCmDNTLnAGfbw7sK8D1xgTOoN+ZD5uGBHBKlvoYOM2tieH5CNWxXIiApvJEC9x
	 01xFrqfTcW1bg/F/DK+SV7mrdN1DBjddA9D1bKnZGl8cy+mOk156A54NOqmLjIwU5Y
	 t+gOJ14fRWmpVtgbss/W7kK72TZyDHbxsB4v48QdH69zgW/Jvlt0bT4e5M0QlDX8xF
	 361nIWviyox7Bz8rlHFyY5gwrL9R1o03NYKxgRmtnqUQftxW8eVDEAMVDE96YOrvzK
	 R9CN5u0t5x1NiQECMfqnGxNiMfzjFZMxWtehTpTTRf5rNecDsWT3QHZS5UvI3u0yVL
	 SnXZSEsrHN49A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
Date: Tue, 30 Dec 2025 15:08:41 -0500
Message-ID: <20251230200841.2453139-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122953-length-breeding-7553@gregkh>
References: <2025122953-length-breeding-7553@gregkh>
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
index f07ae58d266d..339239bb7f63 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -343,7 +343,7 @@ static int recover_inode(struct inode *inode, struct page *page)
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-				bool check_only)
+				bool check_only, bool *new_inode)
 {
 	struct curseg_info *curseg;
 	struct page *page = NULL;
@@ -400,6 +400,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			if (IS_ERR(entry)) {
 				err = PTR_ERR(entry);
 				if (err == -ENOENT) {
+					if (check_only)
+						*new_inode = true;
 					err = 0;
 					goto next;
 				}
@@ -805,6 +807,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	unsigned long s_flags = sbi->sb->s_flags;
 	bool need_writecp = false;
 	bool fix_curseg_write_pointer = false;
+	bool new_inode = false;
 #ifdef CONFIG_QUOTA
 	int quota_enabled;
 #endif
@@ -829,8 +832,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	down_write(&sbi->cp_global_sem);
 
 	/* step #1: find fsynced inode numbers */
-	err = find_fsync_dnodes(sbi, &inode_list, check_only);
-	if (err || list_empty(&inode_list))
+	err = find_fsync_dnodes(sbi, &inode_list, check_only, &new_inode);
+	if (err < 0 || (list_empty(&inode_list) && (!check_only || !new_inode)))
 		goto skip;
 
 	if (check_only) {
-- 
2.51.0


