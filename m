Return-Path: <stable+bounces-78508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1450A98BEBC
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB3C1C23CD1
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422641C57BC;
	Tue,  1 Oct 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZVe6AUK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31871C57B9
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791116; cv=none; b=npL9DWW3vbW7Go+HRsA2n6SocjtPGiZhF5QqYuRkuNIwR6B3Vhvq8Vt9MMpsZoxHwPX3dI74r094vTkRVmdOZcleZP5A9Fk92UgeHUJTM3AtQMH9/OV4xXaJ/RJt0KhpfMmZTu11xjlyPrBiIlmDc72ug//nLyTynmdsr4tGVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791116; c=relaxed/simple;
	bh=AZhAJySevGcX2z3HlWUyHpHa+gS0Y/qqPcZrggG3xUI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FNLOWxcwaploNnx8doJ7zWGjvq7cvAfzahtc4TIwtKJMroGfEMas8Ox3SNnWUPs9Pno4jxMvsIIjxvH7xZKy+9LTrc/dbt8OHDO9HJxMBk+FI2r5Ij8eL8P7/eMk93rd4ZP9MsiInmrtTq+3E9c+pfJ5CdqeWv1nPkfWCIW3Llg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZVe6AUK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4B5C4CEC6;
	Tue,  1 Oct 2024 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791115;
	bh=AZhAJySevGcX2z3HlWUyHpHa+gS0Y/qqPcZrggG3xUI=;
	h=Subject:To:Cc:From:Date:From;
	b=ZVe6AUK0zwle5eghTLnrgG8cQa/z5TSKp91iAMx+oFbqxF8SNvc9aRvUZqE6VKyFf
	 eQTaE0aMBbWFGJTqOXYrTgh4Dhg3LOy5AJmoDuSz1oPUvCjaUSDtI0zSxLzThXx7ia
	 ivkVe00Ry4bjMbB4m6AzkotMwyMEDpehdrUQJgc4=
Subject: FAILED: patch "[PATCH] f2fs: Require FMODE_WRITE for atomic write ioctls" failed to apply to 6.1-stable tree
To: jannh@google.com,chao@kernel.org,ebiggers@google.com,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 15:58:32 +0200
Message-ID: <2024100132-panorama-legacy-223d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4f5a100f87f32cb65d4bb1ad282a08c92f6f591e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100132-panorama-legacy-223d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


