Return-Path: <stable+bounces-81124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A48990FD4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5C61F2251A
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08B21DD9D5;
	Fri,  4 Oct 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7UwFIlk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3673466
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070598; cv=none; b=DSa3QdzVMvB+lxYvfGPvap94RJ7yPlvAbbhjyI3zQC3WD9batuvNp7SEBgLTc5wlp8f30dUgTAJmqgc3eNHhzvqgS1R5nklJz2/lyJ4wdHwvPV/0ww9LscK52JCtukUvPjVHgRwydg7iWChh6Tp6ld8gEq3IYOFFIvvD9e10Djk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070598; c=relaxed/simple;
	bh=+RDQO2EzUUB70xcWc2RNgkxemDdhy9Q1pW55RniZ6Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOzCOCCB9Kh5dQR8BpAb+bN2tJ8tnCYvvUsi4PVCFr1YBbW4AQqHXeYcHjjEWT613g7gYZbQvYTEaWiglrQjbmZt8MFl4hQiiiAuk14GIiestXrSp41C0w/Z3ONMLFlfqJ6Q9LGYmv5UW6DfwcIjvX8IqhKqL76XSUm3KH6Snww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7UwFIlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B36C4CEC6;
	Fri,  4 Oct 2024 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070598;
	bh=+RDQO2EzUUB70xcWc2RNgkxemDdhy9Q1pW55RniZ6Eo=;
	h=From:To:Cc:Subject:Date:From;
	b=G7UwFIlkBI3ryVCMm4BuNc12vQZ3Qv7mO3VACHqI2/jG/v8A2FP1YN/Qq9QnBtr8/
	 f6VzDs0yymJB5u6DP7XOacGM6IclDjnlh7Mp0ulbcPBMw/1H8sA0fU4YOtJHnr36Aw
	 jQGUEyCniJsNyZF4AwJuEsCXI4m/Oh0+9YaYpF1xh7Kilw0J7vENAsu4RdrbL/qtKS
	 1L4c1wFXSx1i7Av5eezx31lMquXNKLyII/8nb0GjfLkTSLbaNGLIk1IVjXqdJZLTgz
	 pTSGIMmo64iWIqMz8mWKYA+UFO5IRYmkx7bSmbzYlrJ9CMK0gI58Trsm4Rs3knrhYb
	 alkWzGVsjW24Q==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	Jann Horn <jannh@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5.15] f2fs: Require FMODE_WRITE for atomic write ioctls
Date: Fri,  4 Oct 2024 19:35:57 +0000
Message-ID: <20241004193557.189976-1-ebiggers@kernel.org>
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
index be9536815e50d..fd369db1e47b5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2005,10 +2005,13 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
@@ -2075,10 +2078,13 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 static int f2fs_ioc_commit_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
@@ -2117,10 +2123,13 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 static int f2fs_ioc_start_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
@@ -2152,10 +2161,13 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 static int f2fs_ioc_release_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
@@ -2181,10 +2193,13 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 static int f2fs_ioc_abort_volatile_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)

base-commit: 3a5928702e7120f83f703fd566082bfb59f1a57e
-- 
2.47.0.rc0.187.ge670bccf7e-goog


