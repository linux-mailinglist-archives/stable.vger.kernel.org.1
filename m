Return-Path: <stable+bounces-94525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA9E9D4E86
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 15:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A9EB26066
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E21D88D1;
	Thu, 21 Nov 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFBO2pNb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773E1D63FD;
	Thu, 21 Nov 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198649; cv=none; b=XZ0zUF08onWRZXrzpScA1pl7w4Qit2gc/jlCSTYyEtQsYnrAAw9A8cezNq8OVe4ntQI0vBla+h2TGdD/cViAshDhlgxyykO8cLGkIM6ati0hAIk/EpePPQyYD2heSli+F2DY1lCghxRHuC3+1Di4/Y+bGBJnwHI9jJosJApaxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198649; c=relaxed/simple;
	bh=Nwing6hxd7cbL8mrx1UFhwO+4wTLgqqgFjW37N/tBsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GgDlLtbMg9vTh7d0yOMIJrPwdhg9jC0f1vHUM96311FSTFVJD/v+2Qb89vIRstjpZBbmWgcnBq6sfFZKUt1Jhn5rUI1Ro8GZFfi2gstkklLGIWCYXf4dA5W13D56r1eA0Kvjc+Mwa1sav1JCwmS4VlFIMPscOvvrs6CjMHj7+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFBO2pNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2882C4CECC;
	Thu, 21 Nov 2024 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732198649;
	bh=Nwing6hxd7cbL8mrx1UFhwO+4wTLgqqgFjW37N/tBsY=;
	h=From:To:Cc:Subject:Date:From;
	b=WFBO2pNbkJJdN3p7N5UR1GeTs2j6WYsbgzGfuu+5SGkRUCMTRmfBooHBQHQM/Fsg2
	 k9Zr14TBDhpekulan4sDjdyDiGe054/+vJ9NYTAP77515vh6ZgBuesca6wwOesiboQ
	 aCrH2TzvD44QIcYNG59RfppvjzC/dgUc5oy80PlHtUiqdXk2J+MIX76aJzpYZSHyaj
	 z5tHo5O2mUbCN25lZL+wiXfHhnWzuZ7Ed1CXzMLME7qT81YdoPwMEkLEmAIFubXkbK
	 doltu3cGGVfqHr01kx4nvU6VFrC8b1a2UhsQv35/4W5nEZvBtHoSpYHB/dYH+Q+Ts6
	 qZvui8KMW5T6g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org,
	Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>
Subject: [PATCH] f2fs: fix to drop all discards after creating snapshot on lvm device
Date: Thu, 21 Nov 2024 22:17:16 +0800
Message-Id: <20241121141716.3018855-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/f2fs/segment.c | 16 +++++++++-------
 fs/f2fs/super.c   | 12 ++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7bdfe08ce9ea..af3fb3f6d9b5 100644
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
-- 
2.40.1


