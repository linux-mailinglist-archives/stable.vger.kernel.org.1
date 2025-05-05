Return-Path: <stable+bounces-139600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293F6AA8D35
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712D93AB4DB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AAC1D5CD1;
	Mon,  5 May 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CXUZc5ZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB7176AC8
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430921; cv=none; b=GmZr9qmt9M/ImfgPAZ05srTwcfM6GdLNl1/wK+6yIYb7H72NhsUlIWsuYtKeDiKTqh4j/J8Lech5U93YSswNn0pf7pDcHFQafmYQ548rpVIpeqvOgvwE9KBJk3S3jVXbycdbhRdBl6TU4SUHq1XQEmPkHmaTuA2pzzDJifJEY0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430921; c=relaxed/simple;
	bh=CfYBLYe+txazrOo2Yhl31Pt887fE93nxzFgnnTVDqYg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NBI2bPJWOZbgE6Gc6NhcWFqMjY4NfvN90fm+Ph5gmSt8R/F6PZLfFnaiH0kk5+SWhKUiljvFuvB1XWnyGjCZeiKYXViRPcH0t9z+IfrZqeHzyOL058WYFR0iDa01vs0qrrMollU4m5BGMuGPgaKjPBsroIfFeCDUhurhuiNiVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CXUZc5ZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E954CC4CEE9;
	Mon,  5 May 2025 07:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746430921;
	bh=CfYBLYe+txazrOo2Yhl31Pt887fE93nxzFgnnTVDqYg=;
	h=Subject:To:Cc:From:Date:From;
	b=CXUZc5ZDotcJAFPzNvqe25m6xMhTViaFlj7Oaf6QiBgvdAvfjBJOg3sSroOliXloO
	 qAj1H04+Rep1j1CRMV8ZCXwasH47sy46JhNFys98O+1VJNaB9SGiZhbr29FxPcp9+Z
	 ubLMC2D+o5slRVk3Pg9B5lpM7YCXlvhvS1Get/n4=
Subject: FAILED: patch "[PATCH] btrfs: fix the inode leak in btrfs_iget()" failed to apply to 6.14-stable tree
To: superman.xpt@gmail.com,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:41:58 +0200
Message-ID: <2025050558-charger-crumpled-6ca4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 48c1d1bb525b1c44b8bdc8e7ec5629cb6c2b9fc4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050558-charger-crumpled-6ca4@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48c1d1bb525b1c44b8bdc8e7ec5629cb6c2b9fc4 Mon Sep 17 00:00:00 2001
From: Penglei Jiang <superman.xpt@gmail.com>
Date: Mon, 21 Apr 2025 08:40:29 -0700
Subject: [PATCH] btrfs: fix the inode leak in btrfs_iget()

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

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 312fa996a987..d295a37fa049 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5682,8 +5682,10 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 		return inode;
 
 	path = btrfs_alloc_path();
-	if (!path)
+	if (!path) {
+		iget_failed(&inode->vfs_inode);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	ret = btrfs_read_locked_inode(inode, path);
 	btrfs_free_path(path);


