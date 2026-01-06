Return-Path: <stable+bounces-205652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE6CFACDD
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ADE23141798
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 19:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0A341ACB;
	Tue,  6 Jan 2026 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xiat7TDR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4B6330315;
	Tue,  6 Jan 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721404; cv=none; b=HDEaSSw0SCRmRwHEA1k3mTJCUdU2MLsPtbkOyMJ6cwuLqcZlRSddjQ6PgO9h4PatMJKxanP3WkzQhuchl92LHN08ykXCnb1BWrBBtXygRv0LmkOel3JGEBR/3R264zIKRJiCVRy54QhlbqQaQXEYAkgb9x+WAgCe2pt2kgA/zhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721404; c=relaxed/simple;
	bh=LI10qlaAiub/EWmCeF33lpb+pwX8PQTia02FwwvqUtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2VA2GmKSzIEGUllfpqHzPtRTBUREXRvh70FduUT2mPqBUuxjPdR0LvpoZtIQ1TnI/gxFs9fhyn9oeTZwiCA40ZRbQdu51EIoQep6CnIg8GW7W8j52x5b0YD+ZEv6HZncO+sUMcFN3JHifUyJ6Miix8BoIW1W+8P1C/Kqbyf0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xiat7TDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0819C19424;
	Tue,  6 Jan 2026 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721404;
	bh=LI10qlaAiub/EWmCeF33lpb+pwX8PQTia02FwwvqUtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xiat7TDReileSA5dHtQ4FKs9uuzNgOj6itiVOsSRhBAEbGcsTP2SVszI+0op9VF5o
	 /8A8qgx8KoiTA7C9M87zSTXnxx+y5bCY8zQUTkn7qeJdZFoB0gTPTahl2GJ7wJ+0Z1
	 0zi42jcdFQTy0IHl03+IVnCSA6P10Mhxhara8RtI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 494/567] f2fs: fix to detect recoverable inode during dryrun of find_fsync_dnodes()
Date: Tue,  6 Jan 2026 18:04:36 +0100
Message-ID: <20260106170509.636454053@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/recovery.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -398,7 +398,7 @@ static int sanity_check_node_chain(struc
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
-				bool check_only)
+				bool check_only, bool *new_inode)
 {
 	struct curseg_info *curseg;
 	struct page *page = NULL;
@@ -445,16 +445,19 @@ static int find_fsync_dnodes(struct f2fs
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
@@ -852,6 +855,7 @@ int f2fs_recover_fsync_data(struct f2fs_
 	int ret = 0;
 	unsigned long s_flags = sbi->sb->s_flags;
 	bool need_writecp = false;
+	bool new_inode = false;
 
 	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
 		f2fs_info(sbi, "recover fsync data on readonly fs");
@@ -864,8 +868,8 @@ int f2fs_recover_fsync_data(struct f2fs_
 	f2fs_down_write(&sbi->cp_global_sem);
 
 	/* step #1: find fsynced inode numbers */
-	err = find_fsync_dnodes(sbi, &inode_list, check_only);
-	if (err || list_empty(&inode_list))
+	err = find_fsync_dnodes(sbi, &inode_list, check_only, &new_inode);
+	if (err < 0 || (list_empty(&inode_list) && (!check_only || !new_inode)))
 		goto skip;
 
 	if (check_only) {



