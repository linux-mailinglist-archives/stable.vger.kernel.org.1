Return-Path: <stable+bounces-81126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FB9990FD7
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236F51C232B8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256931DED69;
	Fri,  4 Oct 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djJJaugJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87031D8E17
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070666; cv=none; b=TnoGNjq08B4jyTbb1Jo0qtvyLZ3IduYn6mfIn74+aa/Xre1TYaIDLWm7e74Cl/XtO96kpXay4YpL6SUBi8VCupYKe1k3lPv/v5IkBiYDf/lZORpBZtEOfq4dInmfvKhuFiRL9Y9VRkHsYAPJdCH4NJVuY+TzVf4zoDYuN01Mjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070666; c=relaxed/simple;
	bh=wAdDN0YKVirpYCZ6hzHIl54G9I+v/JPkaqEyYbaags8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUJITh3/CHR8BGQUQT6cJAK+tLLwB4KTAHTNlIQt7njzZxzuIqjlsxFUQsoBRLWFpEYzYONekF9L61pBhBYomwDQ9tv1x3g+LPucJDJc2qjSHh6XU0RpssDvdzBhLWtjOjVHCBEpPcb6EKSs9I5miIJF0I1vT42OYEjK9I4FEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djJJaugJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8C4C4CEC6;
	Fri,  4 Oct 2024 19:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070665;
	bh=wAdDN0YKVirpYCZ6hzHIl54G9I+v/JPkaqEyYbaags8=;
	h=From:To:Cc:Subject:Date:From;
	b=djJJaugJVp2aVcD+OdP5rsn72UYYgVLqspxXZfBvUl/49PbnvqIoqS8+pBT5bH/aG
	 Ky/f+WBOCI0ps/7MPK+mLNWD8F5ndM+izGU6TsMcdFbzVBJsIl9D01bi2n54uDh3V6
	 hkgQEsI5OR/PceMGAvwD8PS5NSNBjDUxWInaEuvFuUcREvIGuA8hKJVCPcU+pihJu6
	 NefzXNCbNb3MYuuFQU01lHPX543yGDWy4hF5jXlLfQARrFRn43A6FguWY/NTxfkb+W
	 JD3vNWxxsTsDiL0T0MhQojrrvfKJB1R5dmDIbbdSb43i9GAgKZ3x8GjlSJK6eiLsTS
	 Y9izDWEQG9QAw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	Jann Horn <jannh@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5.4] f2fs: Require FMODE_WRITE for atomic write ioctls
Date: Fri,  4 Oct 2024 19:37:10 +0000
Message-ID: <20241004193710.190186-1-ebiggers@kernel.org>
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
index 2330600dbe02e..738d65abde510 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1855,10 +1855,13 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
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
@@ -1921,10 +1924,13 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
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
@@ -1963,10 +1969,13 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
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
@@ -1998,10 +2007,13 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
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
@@ -2027,10 +2039,13 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
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

base-commit: 661f109c057497c8baf507a2562ceb9f9fb3cbc2
-- 
2.47.0.rc0.187.ge670bccf7e-goog


