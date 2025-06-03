Return-Path: <stable+bounces-150649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAB6ACC071
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 08:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B223A3B69
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73F320FAB2;
	Tue,  3 Jun 2025 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="oMfd9XBh"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECB1D6DB6
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933292; cv=none; b=nU9vx19eJyV7p7AxgXQ+JmoVgRxnYctnAAM/2GkgSDoDp6+82vx+qiWyetFyxJTS/HnD0WnFGpixM3x5F0j4NbkLewZDVH4LOEb1wtqXd0TnRT8iBO0HqSHVZOIgD2y3CKQo0XFjUeoTdZMCiwGIYv0YQx/D7/R2RX2wxFLk/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933292; c=relaxed/simple;
	bh=LuVNKs/aM7HSgd1rS+aN8sOMu1mQcAQiuMmf8pv+XK4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=C1CaQDJcVVnAnv1kkgORJjoQDOPoBiQSW97NzQDamoN8lrvvCh8+0LeVTK8FRUUgkXaj/KcRrduL73swxX+yO+YVAp5OeyoC2F0MsswyXWMn4FDSvjH8TrKTy+KjVyEq4jGSjTQRa/bD+XT4efs1HDFt7Y3aD/BfCAZ1Frz7mYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=oMfd9XBh; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1748933277;
	bh=qgJLGOUQLzEh2amHgVWt7Oqdx1HZEaXCIxhLHeM14Ok=;
	h=From:To:Cc:Subject:Date;
	b=oMfd9XBhFwH8SAvR/me+JSLMckQutU33tG6I8V9ToFm+zHOmMTwtGsW9gWww1rbCf
	 lIIHv8+64PCQN7OFiND45ffdQ7uLFLftxFMNm1lfse+DU9LNttfIX9IjtlJneOs4Wa
	 AhhmDnBI+5htmZtIrzkjRxkKRNh40+EbNE0W9BEg=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.185])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id BF3172C4; Tue, 03 Jun 2025 14:47:51 +0800
X-QQ-mid: xmsmtpt1748933271tqdgnfegw
Message-ID: <tencent_381A1068DD6A903EBA2513AD817046602209@qq.com>
X-QQ-XMAILINFO: MJT6ZmiQPif/amOLtJU4ze7FtS1T460r46kWrDrn3N+zl8Icwu8CKeCzT2Q7xN
	 XzNWnSzFaDBBlT9YJzkT1QrVj1C2sHs6KbM+WIx7nFImaByL5ZBSmh2yGoz0F5H2PC6R2V+fWh5p
	 n0kxjL9bLwy9W9kabfwtoNDtkn063lBQg+S53v/dMZDbFh3X9hk4C8hoKakf3mhmbwGEfFSGcIYH
	 ockTuY5u842tTTre23F+fTTHkDEK2baTw+P63HhonEx9nR/hsKgfHIVh5rKo+/qcD7HfdhyR6Zfb
	 JNjBiwRTRSFE8IRpcuZLgmAFsCPdGxmwcHce2wZWkhmeamE3w39uQ8uEaPt3lhaQ3c6P6CxGbofh
	 zWIHtBFMe2JoQYb16/9wRiW44OT5MbW98bNF8JFORfZNyz7rX1d4xt7ibxRHdoFxbOZwkiprjb0o
	 H2+3Tj8KisL+iqKSTH+v3L7ERqD0blB2UXijFm2PbrHLHzJZb3xj/dB/wt1l3g/DhsWQcgmiWl8T
	 SaUzuN18/pmGjqZnf2xWzt+VOCHaeAF/W1e9+6m9k8s3nhWaeLRGSdhXFNTvLa1n0FFuQiRBNK5s
	 P+Km2CYoZLTRzVi1gnmLPonITB4aEBYepJEecfBAaJnjuiCpvnfZ0jaMjZJE10YkibxqumL3huvp
	 ISkbfOrMC3ObPj6wk0y2nUf43q00zzBVNbU1UzjmRJOJQd8Gl0qbD79RPoIChDIPgwqdp9eukz6G
	 6xPUcb/um5XFZIQ0FIPrKUTgaFybMKR01+WgINhbDhUeACXGPk7pdbNXn1IdpUHJQtZskcqL6+IN
	 oqXEm7eycahYneUh5UZst9wZvIDpF3gGpj7Dmnd56fJae3a7NY7/RkGHv4XFCE6/gpMZHxrAmu4a
	 Yr6Na1lGktxvBvLK7ORjMTtAwYd5ZJUNHDPc6DJUriFx+Aoi+IRFjzQpaXqivU9rBbaq2C8mfyJT
	 e6gB3ytnRJa2nZh3Ej5cuJll90to4740vsUF81BWAGPEg1T+dEx874CEh3XpoFWDfH1fsmwRU1et
	 Dkokt1JgD0H/qOVrc4ECLd/BR2qX0=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.12.y] f2fs: fix to avoid accessing uninitialized curseg
Date: Tue,  3 Jun 2025 14:47:36 +0800
X-OQ-MSGID: <20250603064736.9084-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 986c50f6bca109c6cf362b4e2babcb85aba958f6 ]

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
---
Build test passed.
The kernel booted up successfully with the patch applied.
---
 fs/f2fs/inode.c   | 7 +++++++
 fs/f2fs/segment.h | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index a60db5e795a4..1061991434b1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -777,6 +777,13 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
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
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 51b2b8c5c749..0c004dd5595b 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -562,13 +562,16 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
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
 
@@ -579,6 +582,10 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 
 	/* check current data section for dentry blocks. */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
+
+	if (unlikely(segno == NULL_SEGNO))
+		return false;
+
 	left_blocks = CAP_BLKS_PER_SEC(sbi) -
 			get_ckpt_valid_blocks(sbi, segno, true);
 	if (dent_blocks > left_blocks)
-- 
2.34.1


