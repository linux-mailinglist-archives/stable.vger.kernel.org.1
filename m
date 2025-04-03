Return-Path: <stable+bounces-127944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E1A7AD7C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1735317ECA3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1728AB9E;
	Thu,  3 Apr 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkTMffvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892E28AB99;
	Thu,  3 Apr 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707450; cv=none; b=N6phBuaAhk0ImYwmjcDsN9gx0V7jVYntfg7SmvotTd5XBIwXdJU7CG44inRlu3kCW0KbYFMPpsba7fQ61zq5my9j3fQE/rST1JvV+0CaCSK+LdJJZ8QiSlyd8/DYHUzfZ1R8jQ8eScsqlGt2q8tWQzsDUWZQ2JrQfASUDHJKwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707450; c=relaxed/simple;
	bh=pcu42rCdO7hqQtBPDgODN9Knl4sgLTyz5kA+vBvSjPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/SH09wJCOPvYiA4yh1gDhgTvIRnmrcDwmlhke48ltBuFL1FtKm9PCcR78enJHYJMaXw40QEvIQKldJGD1R/XQGzu32xwabUUBTJA4bEj/2EViVUWU6wuVSwLNcdjoBEvfibOwrtrx0vjFL5x1jqVLZvFZlBR64eF5yCDOw1m5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkTMffvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CABC4CEE8;
	Thu,  3 Apr 2025 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707449;
	bh=pcu42rCdO7hqQtBPDgODN9Knl4sgLTyz5kA+vBvSjPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkTMffvpV4Yh9Mu14U737QVKKF2Woy7WGMdEl2u3qeXLO6HletoMuHXEprKzQx2Eu
	 Td1P1actV819bm8UmHEpqBYuKIxZkZVoMFk8Xs18voEnGfHEqVwrUfIQEf7mUa4AqL
	 Hp108ebG8HWm8lYOllnw10o18kaQB4haUx+yFiMdgJrMlFVWzzbs+LsuwWlIIwWKgv
	 4hhKCMKiRwZVkahNVkKVxXIcNSqz0n+I9m8AFHQUypfcVHnj+ShV9BVzBPwstRyad+
	 TLxTEVL1Pxlw2Vd8CnnmIStxUGV0zqxJxyCVUSScAjCmoXOSlXyqFwFXBiKLIlKs6i
	 qViidpQfB9y+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	aha310510@gmail.com,
	quic_zhonhan@quicinc.com,
	dmantipov@yandex.ru,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 04/14] jfs: Prevent copying of nlink with value 0 from disk inode
Date: Thu,  3 Apr 2025 15:10:26 -0400
Message-Id: <20250403191036.2678799-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191036.2678799-1-sashal@kernel.org>
References: <20250403191036.2678799-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit b61e69bb1c049cf507e3c654fa3dc1568231bd07 ]

syzbot report a deadlock in diFree. [1]

When calling "ioctl$LOOP_SET_STATUS64", the offset value passed in is 4,
which does not match the mounted loop device, causing the mapping of the
mounted loop device to be invalidated.

When creating the directory and creating the inode of iag in diReadSpecial(),
read the page of fixed disk inode (AIT) in raw mode in read_metapage(), the
metapage data it returns is corrupted, which causes the nlink value of 0 to be
assigned to the iag inode when executing copy_from_dinode(), which ultimately
causes a deadlock when entering diFree().

To avoid this, first check the nlink value of dinode before setting iag inode.

[1]
WARNING: possible recursive locking detected
6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0 Not tainted
--------------------------------------------
syz-executor301/5309 is trying to acquire lock:
ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889

but task is already holding lock:
ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(imap->im_aglock[index]));
  lock(&(imap->im_aglock[index]));

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor301/5309:
 #0: ffff8880422a4420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:4026
 #2: ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630
 #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2460 [inline]
 #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocAG+0x4b7/0x1e50 fs/jfs/jfs_imap.c:1669
 #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2477 [inline]
 #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocAG+0x869/0x1e50 fs/jfs/jfs_imap.c:1669

stack backtrace:
CPU: 0 UID: 0 PID: 5309 Comm: syz-executor301 Not tainted 6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x4e8/0x9b0 fs/inode.c:725
 diFreeSpecial fs/jfs/jfs_imap.c:552 [inline]
 duplicateIXtree+0x3c6/0x550 fs/jfs/jfs_imap.c:3022
 diNewIAG fs/jfs/jfs_imap.c:2597 [inline]
 diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 diAllocAG+0x17dc/0x1e50 fs/jfs/jfs_imap.c:1669
 diAlloc+0x1d2/0x1630 fs/jfs/jfs_imap.c:1590
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1c5/0xba0 fs/jfs/namei.c:225
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=355da3b3a74881008e8f
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_imap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index da3a1c27d3498..84e2c67c9070f 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -458,7 +458,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
 	dp += inum % 8;		/* 8 inodes per 4K page */
 
 	/* copy on-disk inode to in-memory inode */
-	if ((copy_from_dinode(dp, ip)) != 0) {
+	if ((copy_from_dinode(dp, ip) != 0) || (ip->i_nlink == 0)) {
 		/* handle bad return by returning NULL for ip */
 		set_nlink(ip, 1);	/* Don't want iput() deleting it */
 		iput(ip);
-- 
2.39.5


