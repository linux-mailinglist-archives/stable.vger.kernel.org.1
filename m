Return-Path: <stable+bounces-139679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3778AA92C3
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C7D18976CB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224522655E;
	Mon,  5 May 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfnW1fCN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8AB2288CB
	for <stable@vger.kernel.org>; Mon,  5 May 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447170; cv=none; b=Dl+YJ2MWexSHvic8ggv31uInGcyKpn5IcY2tz+raLZX1SBnXGjxvcDtJeBRvdaU4doeJQWSArhI38WPl36HO6tRu+T2xDcERkNv0F34rVIyvxI8YNcboP8ihzG2hVgke6isM91Vw2rh+UC+Oc9j1uDpav6Gwd7M0RsEHFbT9IhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447170; c=relaxed/simple;
	bh=5S7BoVmlHK3VD3SVZlQyh35knlwy0A6NqnEeYxjd/EQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mAbdPVMO5hTcBAcbyT7Sujxckj+QDn3ahWQKsDL+J1nybhcHtCCYQUIzpkulWBrPgyiWulpy6VqyQHHVDarG8mGwuK5Omu7Qm3tVXz1HaFaYa0EOfI6CELDLjn90YeobljP9NekaplN7KqbgdQPmWfUNxO3CbDWZ9QZA0s/tueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfnW1fCN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso4345976b3a.2
        for <stable@vger.kernel.org>; Mon, 05 May 2025 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746447167; x=1747051967; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCWGqi4QkALxnCqGmj2Cki09wk61axEdwdjnn5rv6Og=;
        b=QfnW1fCNry2vTA8ODdIewvQA6p/OlZx50jXW7Z/CHxtSdHlklFNnopcA9bri6fPOfX
         3qcgpNGQdY7b60ZfAwMjNWM92a90Tdy4kLnlxDt9AXGU5kedbopB5J7KdCbARBRBDXbx
         a5TS0Uf5M5s7P6e2BJVyyZZVYGTLQfANqjpicE9DN/Pz6Kbx/DmmTJqjzShk1b74rEUs
         ySYT77U4OfxHG6WwwfxXWimFONdH9/QWcA03fZ9QBiXOGuxdkdYkiqivuvisnx6qlsj1
         JTtuTUOT2r11/liTSNAvr6AxAAj/UiIGFPMHfn/1fNHD04s99MdD3lfiNiiJRrW3rDrv
         6I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746447167; x=1747051967;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCWGqi4QkALxnCqGmj2Cki09wk61axEdwdjnn5rv6Og=;
        b=Yaq+c7jDmUt8DARitb7VvnqEme/V2/rcwiMQLJDZ02wv01ZQQKak60pS4D7NyeyCKy
         J1iXWYgXRyaMc3hUHTZKDYBmQhvs5/NFi5uwtHoYDwT3GjCOJsVBicGKdHdZc1uLQSG5
         BvF5M7UWbAOtSFOwo+UnX7jkgYCBrYY+HEUeFQier2cCk/IudN6ukeQA0DUA9IwPut8k
         zX7ddsGTcZzSk0q5v1cPyKc78OJdP9XMGO7nJacdVqxqmV0/I5ywzIbcAb0Vfz2LnH7r
         nVXVJPMrLQIUXCGmaZxGo9bpUqY2Yxg3HW7KO1HhCBXLF7tesHZjfBkjwyRZar2MZLv5
         8OvA==
X-Forwarded-Encrypted: i=1; AJvYcCXszUsVS6uK9lI2YeRKxx+BLg3g8FvQ3bSAxh6jBYqwM6Um/xgT008pC4hxzHYIFdQ7f/LB6Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4UXPx/eLclqcLX/yuwmPH52OGOTSYP79mFBFPaSYc9bRHi9X
	kSczOIoMZc0aSO4CnGYWH7CbHfwT+BMIJhNiC4NDjqiV06KrwwBg
X-Gm-Gg: ASbGncvrkTC5vOCJ5Jgvq5OUMl1VLSeSm0NmyTrgJ0WQoCf4ChZhtsj4me9K+Ss05Za
	Lh2FUwPWPK9wD+DviwtEw6h0GxOg8+NoKx6+ZE3CrmJXAT5CllVFlcs+OrW6zsnKVpp/yZTfyJb
	9eJPS2dFBEwUu40XrE93pQYIsPj0ffKBBccrE6h7+kWrrAsEBI1qwYyN5z197n2GYC2nx5whxBo
	lau0KIEEjNCDusgDQwyS7PRYccG3ckMdUaZ/KeA1OsMe+xcNKO67+rCGaV+uX9v0y3pPklA5PW7
	H7Z5Cf0dY4zFjQfcVbpRZrlwnndCWB+qxEBV/1Q+NlydSmGu3tMGQAazMj5u+Q==
X-Google-Smtp-Source: AGHT+IErnROgEV8KPIcJ/P1vVmUGbBxU6fIF06DYcxUTaBjYc1cgdLRfhOtQ7jCqL/+lYQBwxxF+/Q==
X-Received: by 2002:a05:6a21:1698:b0:203:bac4:c6d4 with SMTP id adf61e73a8af0-20e97abe423mr10925186637.29.1746447167531;
        Mon, 05 May 2025 05:12:47 -0700 (PDT)
Received: from ubuntu.localdomain ([39.86.156.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b5113csm5338123a12.18.2025.05.05.05.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:12:46 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: caocaodeyouxiang@gmail.com
Cc: Penglei Jiang <superman.xpt@gmail.com>,
	stable@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.14.y] btrfs: fix the inode leak in btrfs_iget()
Date: Mon,  5 May 2025 05:12:40 -0700
Message-Id: <20250505121240.96063-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

[BUG]
There is a bug report that a syzbot reproducer can lead to the following
busy inode at unmount time:

  BTRFS info (device loop1): last unmount of filesystem 1680000e-3c1e-4c46-84b6-56bd3909af50
  VFS: Busy inodes after unmount of loop1 (btrfs)
  ------------[ cut here ]------------
  kernel BUG at fs/super.c:650!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 0 UID: 0 PID: 48168 Comm: syz-executor Not tainted 6.15.0-rc2-00471-g119009db2674 #2 PREEMPT(full)
  Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  RIP: 0010:generic_shutdown_super+0x2e9/0x390 fs/super.c:650
  Call Trace:
   <TASK>
   kill_anon_super+0x3a/0x60 fs/super.c:1237
   btrfs_kill_super+0x3b/0x50 fs/btrfs/super.c:2099
   deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
   deactivate_super fs/super.c:506 [inline]
   deactivate_super+0xe2/0x100 fs/super.c:502
   cleanup_mnt+0x21f/0x440 fs/namespace.c:1435
   task_work_run+0x14d/0x240 kernel/task_work.c:227
   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
   syscall_exit_to_user_mode+0x269/0x290 kernel/entry/common.c:218
   do_syscall_64+0xd4/0x250 arch/x86/entry/syscall_64.c:100
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

[CAUSE]
When btrfs_alloc_path() failed, btrfs_iget() directly returned without
releasing the inode already allocated by btrfs_iget_locked().

This results the above busy inode and trigger the kernel BUG.

[FIX]
Fix it by calling iget_failed() if btrfs_alloc_path() failed.

If we hit error inside btrfs_read_locked_inode(), it will properly call
iget_failed(), so nothing to worry about.

Although the iget_failed() cleanup inside btrfs_read_locked_inode() is a
break of the normal error handling scheme, let's fix the obvious bug
and backport first, then rework the error handling later.

Reported-by: Penglei Jiang <superman.xpt@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/20250421102425.44431-1-superman.xpt@gmail.com/
Fixes: 7c855e16ab72 ("btrfs: remove conditional path allocation in btrfs_read_locked_inode()")
CC: stable@vger.kernel.org # 6.13+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
Signed-off-by: David Sterba <dsterba@suse.com>
(cherry picked from commit 48c1d1bb525b1c44b8bdc8e7ec5629cb6c2b9fc4)
---
 fs/btrfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 38756f8cef46..ad7009d336fa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5659,8 +5659,10 @@ struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 		return inode;
 
 	path = btrfs_alloc_path();
-	if (!path)
+	if (!path) {
+		iget_failed(&inode->vfs_inode);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	ret = btrfs_read_locked_inode(inode, path);
 	btrfs_free_path(path);
-- 
2.17.1


