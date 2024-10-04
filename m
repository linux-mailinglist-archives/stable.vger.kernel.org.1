Return-Path: <stable+bounces-81127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B839F990FD9
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0A61C232E1
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DCD1DF24B;
	Fri,  4 Oct 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2kPVUQ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A7A1DD877
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070699; cv=none; b=sYbC0Ta/kgwR5h2vXed06eV2vOKmkzuMonukDqIdB0I9DVhXIPH7BKHOsh5pMpThgVDAXD5uIIBfpSBqtsxQpQ5uKIChraN3QrfJP/5aALBTdjka7P2WnQz/iiiKdh+FlutqO6AbIJ75cpjIGRZ9jmHDjic6VU1sNwUWXPZwIJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070699; c=relaxed/simple;
	bh=61RQvFcZxzV9OxImIeIelFCFhkqbd3Cj4t5qAiz9/sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NPYavR/p5kOx4Z9p0o6wtqQNs/dmpFPRb6j9MQ0NoXZ9T8LZw2V+mjeX0nPdi5d/lqrAR6jaHEf3Kmfh6YtK7Vrj6nn+F2ihtUmL6HBnim6yxNB/s6N7hRMhm2CJRSlUHbPh4Pvr2SEZZQfUQyWnJKgT91LelwvaP8ugZfePjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2kPVUQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B17C4CEC6;
	Fri,  4 Oct 2024 19:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070699;
	bh=61RQvFcZxzV9OxImIeIelFCFhkqbd3Cj4t5qAiz9/sI=;
	h=From:To:Cc:Subject:Date:From;
	b=r2kPVUQ4XwGGJKM+skMfeVurKpxby7+wO9mD331QKrzj1NAt8Vyb+o7NN8/Um5Bxw
	 u379T9rbZWrl1jfnBkiMJZbpk7RWsPWOqOLbELtwEzmL5oOo9WQH8nSq7fl1eE3J0v
	 v4DBcJRvJvtKIkU5nGp8ySDAx4fcMGbUI6FqIKEHFSh+oGF7FI5Xk/SGUSWOaDFsMz
	 KKEoprwqDHe0YhCpW8QJrR7t2s3T3PLUTSF3Yd3aZ6tjybKW478qOajUzsgaHmHx+8
	 Mo8HZvo1CnBQhIDxJ1alVltpPytX77hGbce91aKYhht+oiP7Z+67PwxuD/9RbLEWXm
	 PudRvR5EMN8Qg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	Jann Horn <jannh@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.19] f2fs: Require FMODE_WRITE for atomic write ioctls
Date: Fri,  4 Oct 2024 19:37:49 +0000
Message-ID: <20241004193749.190266-1-ebiggers@kernel.org>
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
index 043ce96ac1270..0cc2f41e81243 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1709,10 +1709,13 @@ static int f2fs_ioc_getversion(struct file *filp, unsigned long arg)
 static int f2fs_ioc_start_atomic_write(struct file *filp)
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
@@ -1766,10 +1769,13 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
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
@@ -1811,10 +1817,13 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
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
@@ -1846,10 +1855,13 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
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
@@ -1875,10 +1887,13 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
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

base-commit: de2cffe297563c815c840cfa14b77a0868b61e53
-- 
2.47.0.rc0.187.ge670bccf7e-goog


