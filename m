Return-Path: <stable+bounces-99025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315D29E6DC4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3034918832A5
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFC200129;
	Fri,  6 Dec 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D/lp0qXC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69A1DACB4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486788; cv=none; b=ii6ebQ8rVpgfCli4K2sZWGkt9jM2yJvbW9nWdqS8RmGL5jIK7njDdDShLUDMTdivSNnJdNEFtVz5whwDYF0K+BNm1CYfINSeZKVj54IWZJF1dRbb6VRnK0Zjpq9l/G1PCK0m1uRkt1FCgXdaavyQq+ahkTo/GN5xAW1dnRFWCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486788; c=relaxed/simple;
	bh=D2kHFneGBDOXSkEmi4HlbcbDOUT6KmZClFaimV4X1fc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uA1c1U1E89rg0+tCH7mpUhGKX+BIffJz0/EOSfIkiEpu/0TfsLP29kGRnHFaBwFYSA5RJrx0H/XjGNbU46ozYnimag+3lRWmcEwuK8ISnPY7eOjMQt7bllGjPCfHMrfkMq0AuWYKOiT4ian4DkLVmNmzsLtjqcvYvOLGg1K9zno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D/lp0qXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D46C4CED1;
	Fri,  6 Dec 2024 12:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733486786;
	bh=D2kHFneGBDOXSkEmi4HlbcbDOUT6KmZClFaimV4X1fc=;
	h=Subject:To:Cc:From:Date:From;
	b=D/lp0qXC3tLf0KoR6OcAqGRWQUshPrqnsO1YiKl0vKFq3k+S8CpNbhM0iX+zVN/rp
	 8rBeAPuYnIVYqL9Ni8b9SUn7lrZ68sET2e1hqn1ZVQpF0+Ya8C4LzolLj8yvIkJvN9
	 8naaM0XEPQBqxAKj4KNnIRCfT01ux3YotMJOVsIM=
Subject: FAILED: patch "[PATCH] f2fs: fix to drop all discards after creating snapshot on lvm" failed to apply to 5.10-stable tree
To: chao@kernel.org,jaegeuk@kernel.org,piergiorgio.sartor@nexgo.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:06:15 +0100
Message-ID: <2024120615-majorette-labored-f822@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x bc8aeb04fd80cb8cfae3058445c84410fd0beb5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120615-majorette-labored-f822@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc8aeb04fd80cb8cfae3058445c84410fd0beb5e Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Thu, 21 Nov 2024 22:17:16 +0800
Subject: [PATCH] f2fs: fix to drop all discards after creating snapshot on lvm
 device

Piergiorgio reported a bug in bugzilla as below:

------------[ cut here ]------------
WARNING: CPU: 2 PID: 969 at fs/f2fs/segment.c:1330
RIP: 0010:__submit_discard_cmd+0x27d/0x400 [f2fs]
Call Trace:
 __issue_discard_cmd+0x1ca/0x350 [f2fs]
 issue_discard_thread+0x191/0x480 [f2fs]
 kthread+0xcf/0x100
 ret_from_fork+0x31/0x50
 ret_from_fork_asm+0x1a/0x30

w/ below testcase, it can reproduce this bug quickly:
- pvcreate /dev/vdb
- vgcreate myvg1 /dev/vdb
- lvcreate -L 1024m -n mylv1 myvg1
- mount /dev/myvg1/mylv1 /mnt/f2fs
- dd if=/dev/zero of=/mnt/f2fs/file bs=1M count=20
- sync
- rm /mnt/f2fs/file
- sync
- lvcreate -L 1024m -s -n mylv1-snapshot /dev/myvg1/mylv1
- umount /mnt/f2fs

The root cause is: it will update discard_max_bytes of mounted lvm
device to zero after creating snapshot on this lvm device, then,
__submit_discard_cmd() will pass parameter @nr_sects w/ zero value
to __blkdev_issue_discard(), it returns a NULL bio pointer, result
in panic.

This patch changes as below for fixing:
1. Let's drop all remained discards in f2fs_unfreeze() if snapshot
of lvm device is created.
2. Checking discard_max_bytes before submitting discard during
__submit_discard_cmd().

Cc: stable@vger.kernel.org
Fixes: 35ec7d574884 ("f2fs: split discard command in prior to block layer")
Reported-by: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219484
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4236040e3994..eade36c5ef13 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1290,16 +1290,18 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 						wait_list, issued);
 			return 0;
 		}
-
-		/*
-		 * Issue discard for conventional zones only if the device
-		 * supports discard.
-		 */
-		if (!bdev_max_discard_sectors(bdev))
-			return -EOPNOTSUPP;
 	}
 #endif
 
+	/*
+	 * stop issuing discard for any of below cases:
+	 * 1. device is conventional zone, but it doesn't support discard.
+	 * 2. device is regulare device, after snapshot it doesn't support
+	 * discard.
+	 */
+	if (!bdev_max_discard_sectors(bdev))
+		return -EOPNOTSUPP;
+
 	trace_f2fs_issue_discard(bdev, dc->di.start, dc->di.len);
 
 	lstart = dc->di.lstart;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c0670cd61956..fc7d463dee15 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1760,6 +1760,18 @@ static int f2fs_freeze(struct super_block *sb)
 
 static int f2fs_unfreeze(struct super_block *sb)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+
+	/*
+	 * It will update discard_max_bytes of mounted lvm device to zero
+	 * after creating snapshot on this lvm device, let's drop all
+	 * remained discards.
+	 * We don't need to disable real-time discard because discard_max_bytes
+	 * will recover after removal of snapshot.
+	 */
+	if (test_opt(sbi, DISCARD) && !f2fs_hw_support_discard(sbi))
+		f2fs_issue_discard_timeout(sbi);
+
 	clear_sbi_flag(F2FS_SB(sb), SBI_IS_FREEZING);
 	return 0;
 }


