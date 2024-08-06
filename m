Return-Path: <stable+bounces-65490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BE19492A2
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 16:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CC31C2118D
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF0818D631;
	Tue,  6 Aug 2024 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bd/5vX9C"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A918D627
	for <stable@vger.kernel.org>; Tue,  6 Aug 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953251; cv=none; b=pJ7rX1w/5VywjGkr784hsaFvDQ+qOFS9B4ks/IC66lYQ2QKwJgBBT4oRi6kjM21BVWnpmwf/jF0k7l+4w48YgKFWpNBwKh4k1NToqpFr+pcIv6Mcn5D4qLiakGdi+t+OM5m4ZpzAqmBoM20UE+E6uHhkMG6ttOAUaSeQzy67ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953251; c=relaxed/simple;
	bh=ZXE8YRwRjRlnWnbKZwcnN363Dx2ojCKLeGL5iZ9KS0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E6mdQyCxiTIk3NAv3HbUIlPlAZ8HkuCOs0VB97zxDjfk33o1r4rOkuu1hQjjQ6HadnZVwFg2/lPoGdgEIzi/KI2ub13wHQwBHjLxiI4UOJZ1XnCYtcXpCbEm3Hhtg8PbNbxElGeR1F2onJbOomsSMOqttmLz1vlg9IYhf5I3dmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bd/5vX9C; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428063f4d71so58825e9.1
        for <stable@vger.kernel.org>; Tue, 06 Aug 2024 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722953248; x=1723558048; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mNJXmqdg/wrODcSMNLZaLEyt49+/cc65vl/68WJpwIU=;
        b=bd/5vX9CmlCx+Tm5P9KiMIRZ9kfvIN/qbYIzp4OHCYFpWYOr4/VpXAndmZ4G+EsmUd
         4cwE+5CsqmLANmYT6oSfJ1IuZrTYoRs2V6HddNpmopaqUJET/J4bWUxOlQUdNtXW1LUg
         MsAGDwTrHQB3X044c8mSQIZGtknOMZNBZfC8qZoM5MgT532ocGeTbsdlTLueoO3b747X
         KV7PSMyG5XBnwoWE7RJR1HGf5+l/K7G1iSUdtiZHODlc9RstD/SQl0uPQ2tCxkm64Ard
         Xf691TJPFBnA6QIgsbQTJItl1EdLSbSuEM33YltQdmrxzDs+gQCm1d4O/LRTScT9GlTk
         8FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722953248; x=1723558048;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNJXmqdg/wrODcSMNLZaLEyt49+/cc65vl/68WJpwIU=;
        b=JdVVWtfRW9RT9xBOEEnId0wpl173JEgI/IhkA2+SF4FyZwLN9BU9/ZoJOkzKd6Kv6C
         0LSzsAhO/Yb0u1wrPBTA8gLsnrkfymi9fNimWXlhHHUJgJ1dn6Jv2GDk3Md7WlOuiAA1
         ISdcOtSldr6WMh3x6J+7/KS3Xz8pnUL5f2GpIALZVvSZO/V0ASUnDqCinkUHv/n5aB9C
         ho34RfanI+i5ILjHLP1We0Dt4RAcg6cOPlgC5tiMHWOGXPQdWeDNOuDEIjYJ4Y0rCsuI
         Ppo+/RLvLTy2kl7xatryeFMpaQlP9sJW5rqi1/weYOOFcnyEbvJfmFv/o4jG3EO54i0a
         IkCA==
X-Forwarded-Encrypted: i=1; AJvYcCX1OYDw96c4QO9MNENgrAe5CH2ff8HGKrNv8LH0rPIdGlAgcJCNjCMgGs1nOT7nJajqIVnVASfxn0baTyT3v4B1L+xEjYGt
X-Gm-Message-State: AOJu0Ywu5FPC2Ty9yTCuEpLcTkgBa3dhvzviQ9LkSNCjkfJYN5zV1pSN
	4rI3PbAZgSaw2ZAa32Z3ic4ivXh1UM6avi6LerOpT8TRemWkbEh1MpxhUmIclQ==
X-Google-Smtp-Source: AGHT+IEjnmj/9A++4g9dfV6Pp5GNvDhemkB90CQw2gg7OgKrBntYsLFfW3sjJJPh92DYzEUk/xDxtQ==
X-Received: by 2002:a05:600c:34cc:b0:424:898b:522b with SMTP id 5b1f17b1804b1-429008aeed2mr671265e9.1.1722953247161;
        Tue, 06 Aug 2024 07:07:27 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:5649:bc4b:84ff:8e24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a862sm245809365e9.4.2024.08.06.07.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:07:25 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 06 Aug 2024 16:07:16 +0200
Subject: [PATCH] f2fs: Require FMODE_WRITE for atomic write ioctls
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-f2fs-atomic-write-v1-1-8a586e194fd7@google.com>
X-B4-Tracking: v=1; b=H4sIABMusmYC/x3MTQqAIBBA4avErBtQk/6uEi3ExppFGRoViHdPW
 n6L9xJECkwRxipBoJsj+6NA1hXYzRwrIS/FoITSohctOuUimsvvbPEJfBGSkIPRXa+ahaB0ZyD
 H7/+c5pw/6hSYXWMAAAA=
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722953241; l=2816;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=ZXE8YRwRjRlnWnbKZwcnN363Dx2ojCKLeGL5iZ9KS0A=;
 b=SxfzSCKBN2CpOmUQWWZjQ5m95ZMD/8Nc/Bg14dR57k3AQ9SY3Tax9bjw9lERq5jyGZ+VNKsFd
 ifymP+MITBHAOG7F4Nz5fmKNmyoz1AZJSdbipNYf16uAOKdf1JpdDtw
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

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
---
 fs/f2fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 168f08507004..a662392c5d8b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2117,12 +2117,15 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct inode *pinode;
 	loff_t isize;
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
@@ -2225,12 +2228,15 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 static int f2fs_ioc_commit_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -2257,12 +2263,15 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 static int f2fs_ioc_abort_atomic_write(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	int ret;
 
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;

---
base-commit: b446a2dae984fa5bd56dd7c3a02a426f87e05813
change-id: 20240806-f2fs-atomic-write-e019a47823de
-- 
Jann Horn <jannh@google.com>


