Return-Path: <stable+bounces-151771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5EBAD0C86
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 12:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E499F188FF2F
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B9F21A444;
	Sat,  7 Jun 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="09xY60lF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F610219E8F;
	Sat,  7 Jun 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749290958; cv=none; b=eatJRe4XPzxwlbAytlcLWCNdCGh1nEOMSOjT1mrDXHhhqENKRovd8c7p/qH4oFvqG6KX/P3l//PQobwAbg5g6F7dYv1+Oh6JF8dafb1YGji8So8rECWjOjxsFinluanu2MwDVxDq1j5aORBLzH6PVccLm86501eUwl2JgCGdduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749290958; c=relaxed/simple;
	bh=fhxUVzWavN97dR9p4RJkkWbJhMhNqMrc4iZ+mb282wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+Jh6DW7yciGW4I6ErAGmSgSvMcbA8zRgzi/gg6I3e84OzQt6wtW3Eyn+fwLuAQA83nSQAv2636DnDagKw7FulbAsnknb7Q0KIr/wgzngPkdvQ7wovdT5CMdNYlZV87NKiJId9WzjE7A7usmJWlv+c1mX35Vs/AB4y2dS/dQdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=09xY60lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD46CC4CEED;
	Sat,  7 Jun 2025 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749290958;
	bh=fhxUVzWavN97dR9p4RJkkWbJhMhNqMrc4iZ+mb282wA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=09xY60lFgqr4P3PULo2JtQRY7bkF/6fwcPK7Ye0brU3XSSyuw51GyYk9CINOmi1+m
	 4nQDGQqF6VUp3f7/yY2H6PraaLFHGp1VO+CxoCbXUGNRUUFlIvn4hbhZvQ+h0Gyk9v
	 5PP3pIJQsMjx/GDysc8AHTzdaisEPNgxBl7IYrxM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12 02/24] f2fs: fix to avoid accessing uninitialized curseg
Date: Sat,  7 Jun 2025 12:07:33 +0200
Message-ID: <20250607100718.006192189@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
References: <20250607100717.910797456@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

commit 986c50f6bca109c6cf362b4e2babcb85aba958f6 upstream.

syzbot reports a f2fs bug as below:

F2FS-fs (loop3): Stopped filesystem due to reason: 7
kworker/u8:7: attempt to access beyond end of device
BUG: unable to handle page fault for address: ffffed1604ea3dfa
RIP: 0010:get_ckpt_valid_blocks fs/f2fs/segment.h:361 [inline]
RIP: 0010:has_curseg_enough_space fs/f2fs/segment.h:570 [inline]
RIP: 0010:__get_secs_required fs/f2fs/segment.h:620 [inline]
RIP: 0010:has_not_enough_free_secs fs/f2fs/segment.h:633 [inline]
RIP: 0010:has_enough_free_secs+0x575/0x1660 fs/f2fs/segment.h:649
 <TASK>
 f2fs_is_checkpoint_ready fs/f2fs/segment.h:671 [inline]
 f2fs_write_inode+0x425/0x540 fs/f2fs/inode.c:791
 write_inode fs/fs-writeback.c:1525 [inline]
 __writeback_single_inode+0x708/0x10d0 fs/fs-writeback.c:1745
 writeback_sb_inodes+0x820/0x1360 fs/fs-writeback.c:1976
 wb_writeback+0x413/0xb80 fs/fs-writeback.c:2156
 wb_do_writeback fs/fs-writeback.c:2303 [inline]
 wb_workfn+0x410/0x1080 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Commit 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT") allows to trigger
no free segment fault in allocator, then it will update curseg->segno to
NULL_SEGNO, though, CP_ERROR_FLAG has been set, f2fs_write_inode() missed
to check the flag, and access invalid curseg->segno directly in below call
path, then resulting in panic:

- f2fs_write_inode
 - f2fs_is_checkpoint_ready
  - has_enough_free_secs
   - has_not_enough_free_secs
    - __get_secs_required
     - has_curseg_enough_space
      - get_ckpt_valid_blocks
      : access invalid curseg->segno

To avoid this issue, let's:
- check CP_ERROR_FLAG flag in prior to f2fs_is_checkpoint_ready() in
f2fs_write_inode().
- in has_curseg_enough_space(), save curseg->segno into a temp variable,
and verify its validation before use.

Fixes: 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT")
Reported-by: syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67973c2b.050a0220.11b1bb.0089.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/inode.c   |    7 +++++++
 fs/f2fs/segment.h |    9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -777,6 +777,13 @@ int f2fs_write_inode(struct inode *inode
 		!is_inode_flag_set(inode, FI_DIRTY_INODE))
 		return 0;
 
+	/*
+	 * no need to update inode page, ultimately f2fs_evict_inode() will
+	 * clear dirty status of inode.
+	 */
+	if (f2fs_cp_error(sbi))
+		return -EIO;
+
 	if (!f2fs_is_checkpoint_ready(sbi)) {
 		f2fs_mark_inode_dirty_sync(inode, true);
 		return -ENOSPC;
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -562,13 +562,16 @@ static inline bool has_curseg_enough_spa
 			unsigned int node_blocks, unsigned int data_blocks,
 			unsigned int dent_blocks)
 {
-
 	unsigned int segno, left_blocks, blocks;
 	int i;
 
 	/* check current data/node sections in the worst case. */
 	for (i = CURSEG_HOT_DATA; i < NR_PERSISTENT_LOG; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
+
+		if (unlikely(segno == NULL_SEGNO))
+			return false;
+
 		left_blocks = CAP_BLKS_PER_SEC(sbi) -
 				get_ckpt_valid_blocks(sbi, segno, true);
 
@@ -579,6 +582,10 @@ static inline bool has_curseg_enough_spa
 
 	/* check current data section for dentry blocks. */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
+
+	if (unlikely(segno == NULL_SEGNO))
+		return false;
+
 	left_blocks = CAP_BLKS_PER_SEC(sbi) -
 			get_ckpt_valid_blocks(sbi, segno, true);
 	if (dent_blocks > left_blocks)



