Return-Path: <stable+bounces-81125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F1C9910BB
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1492B21E3D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561C1DED6D;
	Fri,  4 Oct 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlXraFbu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94051CACFB
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070628; cv=none; b=YdesuxWTokkKbIm3/R8BLTXVHs6AcGBu1IEX5JiciALVmv0ImK5m8QbDGnFooUuYerQYf12KCK7v4KmJVRuu1s0si+CtXkoDauNyHeo9+SnjN5DveMBQBh6UcWLkEFvWShE0NC00Q7WPZWK8NFw7hS4Q5ZXSWndEnEQnPjh2IfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070628; c=relaxed/simple;
	bh=dkL3L2bqK29d84C7yW4lPON2QKH/kQS0VZta8hKzgfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBmn/J0gXwnEKUcqK9GNq0vCjmIgrmVn0V0Cc0bOM6XZLnBmV/Snjr9jAkYwaIONRebG7gg+XW6bBP3wWH4GHn27EV7ToVLqBLCohSjIdsOS8B4Vw0Z5vcW1EpPM/hoI2Pyqtglq4E/D4Nvv9GqrkpHs4gll7W/5MNYD6kn5d+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlXraFbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4FBC4CEC6;
	Fri,  4 Oct 2024 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070627;
	bh=dkL3L2bqK29d84C7yW4lPON2QKH/kQS0VZta8hKzgfM=;
	h=From:To:Cc:Subject:Date:From;
	b=tlXraFbuBzhZEyjFeYK5D2J95Tasue1LDgR6yUKUWcg6iMWV4I3TgZ42EqZtA/Wh2
	 rsDbL2wBAdZXFkpc4QapIfLeXyeL308yJsZTye5yO/lA6wRZv9LdhYukMGprngkStU
	 lLac+Or6foFhb5BBzchT1eaXs/XZDK2OAPt9OmjejAoj6osoI0Sm/ANaIE6rMHpqcJ
	 qNdrF93mW6/pFQEJYK441BNHH/bz/nv9aId/jApDplepoC9HHR/wXv3oK7YGxR8gHi
	 Mpe3Z5ztfXaejg0Fgxe5io7IiGYLsJe5/qVJIT5H+txDwy/1Ea13pR+YNRovR94IFl
	 H0dIL4LVtzSzA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	Jann Horn <jannh@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5.10] f2fs: Require FMODE_WRITE for atomic write ioctls
Date: Fri,  4 Oct 2024 19:36:43 +0000
Message-ID: <20241004193643.190072-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

commit 4f5a100f87f32cb65d4bb1ad282a08c92f6f591e upstream.

The F2FS ioctls for starting and committing atomic writes check for
inode_owner_or_capable(), but this does not give LSMs like SELinux or
Landlock an opportunity to deny the write access - if the caller's FSUID
matches the inode's UID, inode_owner_or_capable() immediately returns true.

There are scenarios where LSMs want to deny a process the ability to write
particular files, even files that the FSUID of the process owns; but this
can currently partially be bypassed using atomic write ioctls in two ways:

 - F2FS_IOC_START_ATOMIC_REPLACE + F2FS_IOC_COMMIT_ATOMIC_WRITE can
   truncate an inode to size 0
 - F2FS_IOC_START_ATOMIC_WRITE + F2FS_IOC_ABORT_ATOMIC_WRITE can revert
   changes another process concurrently made to a file

Fix it by requiring FMODE_WRITE for these operations, just like for
F2FS_IOC_MOVE_RANGE. Since any legitimate caller should only be using these
ioctls when intending to write into the file, that seems unlikely to break
anything.

Fixes: 88b88a667971 ("f2fs: support atomic writes")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 50514962771a1..e25788e643bbd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2047,10 +2047,13 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
@@ -2117,10 +2120,13 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 static int f2fs_ioc_commit_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
@@ -2159,10 +2165,13 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 static int f2fs_ioc_start_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
@@ -2194,10 +2203,13 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 static int f2fs_ioc_release_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
@@ -2223,10 +2235,13 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 static int f2fs_ioc_abort_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)

base-commit: ceb091e2c4ccf93b1ee0e0e8a202476a433784ff
-- 
2.47.0.rc0.187.ge670bccf7e-goog


