Return-Path: <stable+bounces-78511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C06B98BEBF
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FB51F22293
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C113C1C6882;
	Tue,  1 Oct 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ar0Q1fKm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822ED17C9E
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791124; cv=none; b=VVV1DnAjcETwQGaFP0IGZ6nZH8Hf2machPEoVesTy709POSSqr9fvQX/gobukwzjTWwidkJ7xmbpZb9n4e6vB6sYqB0Mj2TUQ5d0FGN9HrJ4zgaqLN7BxXrasITJvnjQ7F+hgzGxZCpY5D/6QxlIRkwRIR2BxVG6U7KF+li1qdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791124; c=relaxed/simple;
	bh=iJsk4+gJuZuXCnn9GiFBhBd2FnS7oWT7N7gQ6JcTbqM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=drAuNv6Cj9MaQoykpuduq8rnFBWSpVk+uJIKsC/EzXMb+ULj71V2lgAI73puHxczj3IUiY+DqeUeaZ+7bYyIW2g99r5PwNOa3ZHHC0BEcBeoeHEgLdujYAbupJtqGEmDVC4s+AD8l0CZvu4qHxHwajG/cDzG26sLjeZmqF7Ue90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ar0Q1fKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA781C4CEC6;
	Tue,  1 Oct 2024 13:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791124;
	bh=iJsk4+gJuZuXCnn9GiFBhBd2FnS7oWT7N7gQ6JcTbqM=;
	h=Subject:To:Cc:From:Date:From;
	b=Ar0Q1fKm3zeIceo8fWxVvlQkvdNRQlWQWlKAFTnXOqe0qFoRYjJ7wcxR6GFcjYTSL
	 bPZaz3gzaB5OCByfmLp6xcWAXyAHLmf3MB+0IiAGF2Qyw+3opGK20SBp/UpIH0XjdU
	 q+feRZHOVXDhj3X/oKWTI5g95jB1fpSxaPXUTyfU=
Subject: FAILED: patch "[PATCH] f2fs: Require FMODE_WRITE for atomic write ioctls" failed to apply to 5.4-stable tree
To: jannh@google.com,chao@kernel.org,ebiggers@google.com,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 15:58:35 +0200
Message-ID: <2024100135-magenta-resigned-365f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 4f5a100f87f32cb65d4bb1ad282a08c92f6f591e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100135-magenta-resigned-365f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

4f5a100f87f3 ("f2fs: Require FMODE_WRITE for atomic write ioctls")
01beba7957a2 ("fs: port inode_owner_or_capable() to mnt_idmap")
f2d40141d5d9 ("fs: port inode_init_owner() to mnt_idmap")
4609e1f18e19 ("fs: port ->permission() to pass mnt_idmap")
8782a9aea3ab ("fs: port ->fileattr_set() to pass mnt_idmap")
13e83a4923be ("fs: port ->set_acl() to pass mnt_idmap")
77435322777d ("fs: port ->get_acl() to pass mnt_idmap")
011e2b717b1b ("fs: port ->tmpfile() to pass mnt_idmap")
5ebb29bee8d5 ("fs: port ->mknod() to pass mnt_idmap")
c54bd91e9eab ("fs: port ->mkdir() to pass mnt_idmap")
7a77db95511c ("fs: port ->symlink() to pass mnt_idmap")
6c960e68aaed ("fs: port ->create() to pass mnt_idmap")
b74d24f7a74f ("fs: port ->getattr() to pass mnt_idmap")
c1632a0f1120 ("fs: port ->setattr() to pass mnt_idmap")
abf08576afe3 ("fs: port vfs_*() helpers to struct mnt_idmap")
6022ec6ee2c3 ("Merge tag 'ntfs3_for_6.2' of https://github.com/Paragon-Software-Group/linux-ntfs3")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f5a100f87f32cb65d4bb1ad282a08c92f6f591e Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Tue, 6 Aug 2024 16:07:16 +0200
Subject: [PATCH] f2fs: Require FMODE_WRITE for atomic write ioctls

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

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bddcb2cd945a..2c591fbc75a9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2131,6 +2131,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	loff_t isize;
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
@@ -2239,6 +2242,9 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
@@ -2271,6 +2277,9 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 


