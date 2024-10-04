Return-Path: <stable+bounces-81123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36099109D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4464B2586E
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782841AA7A1;
	Fri,  4 Oct 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmdjtxXK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902081E
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070544; cv=none; b=Po08/Zoe/3T474ky998fWCFYa651MLDAWt4Ay/B855RN1o/g6lwzJId3sFiwu14Si7u+N+XhADmc/+qMEEbmO4ZNots3aRjM356HAthw7wvwwu2PvMY04WsS5Nm2qdtZlYgGrE0XNsL5Hu0Qh/l4FlmBJSRhK6rzwYM9PeA7Dio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070544; c=relaxed/simple;
	bh=FbIVHiY/rbg7WqDXDZGXK07+PNJJ+HGQxWp38nW2jbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXxnJSX/6uBhSMQ/niZ2LJ/ole/LKAKKZGIZ0bNkXgEkUy6/yaK7u1LPqhKied7rqndHE3PUcoUaH4DCM7XMrsghSD7kApk+066cVrZWrJkb8eI3tWE4SfUz1kFTB+99F71KVlp6mMb5bvxRRDB3hjPqQjkgGRm/IB07M0uXbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmdjtxXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FD9C4CEC6;
	Fri,  4 Oct 2024 19:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070543;
	bh=FbIVHiY/rbg7WqDXDZGXK07+PNJJ+HGQxWp38nW2jbY=;
	h=From:To:Cc:Subject:Date:From;
	b=qmdjtxXKzU3KqRiKfmWuYdRtSEELcgbzOSwoMg0FXkUFegim+lyNOMDzuyPhoeBLT
	 5QoVD4Akkozb9UUUwueCd7QbQ9qTkcSrGsMXoZqspwEDd2EgdTfS2R/y6v5aZWDp8C
	 5oqlDQ6UUj6HWXwGY9nwpS2MVsr0IBb1FdVzgKZ2Q8fqhpClWMAdu9WJeQLq5F0k98
	 rYbVURbRmHK71i/lzH/Yn6SpLqRtFM//J5NkYxFSDyvzjH2+TubvphPgU8jRUgNQ7S
	 f33g87h81S0Fm2aWDDesI7oAAWDF7neK5vrLDnJ/sf7gHfjWHt+iPxzxxnCxTxoKBX
	 QWw5q4eoVl39g==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	Jann Horn <jannh@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.1] f2fs: Require FMODE_WRITE for atomic write ioctls
Date: Fri,  4 Oct 2024 19:34:41 +0000
Message-ID: <20241004193442.189774-1-ebiggers@kernel.org>
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
 fs/f2fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 62f2521cd955e..2982cc5b37d78 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2103,10 +2103,13 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inode *pinode;
 	loff_t isize;
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
@@ -2200,10 +2203,13 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
@@ -2232,10 +2238,13 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	struct user_namespace *mnt_userns = file_mnt_user_ns(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)

base-commit: aa4cd140bba57b7064b4c7a7141bebd336d32087
-- 
2.47.0.rc0.187.ge670bccf7e-goog


