Return-Path: <stable+bounces-47912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870C78FACF2
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CBA2839F2
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC49142E6E;
	Tue,  4 Jun 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3KvaiVU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9EA1420A5;
	Tue,  4 Jun 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487811; cv=none; b=bx6Z5lg7Htc3grwodVrmszFYN5tgMBjJuQgsWjWWbLzRxREU5hhn95+BKxT2p1VnuXkm+ArHmEoW+3Y91AR22pdk68iq3jrWDoUgwdCrCxHOCGk8/VQ5U5aCyzTS3oNHnMJsWtbiN8f0FpurRLi8MDNoVbkvxi6YDXCFQDfaaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487811; c=relaxed/simple;
	bh=Th/bB0ynCfO7mBhDp66CrCHTDuadKccCIQuJMOSIRY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rEor0wPv7HxMrJbYn/S4zGjeKZMMJgaIRLbf5FzEC4f3zsUuS/Gq/xZhxBNReruKDRTzFk0wMTVPlwzd/giItAqyA+g70obUlVfekeHtgWRR2TnhrrXDJuT7sRtKB/Igw34t+GoePKGtcAS9G0yaTY7H/GfvwLD/cA3XwlcjFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3KvaiVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC81C2BBFC;
	Tue,  4 Jun 2024 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487811;
	bh=Th/bB0ynCfO7mBhDp66CrCHTDuadKccCIQuJMOSIRY4=;
	h=From:To:Cc:Subject:Date:From;
	b=g3KvaiVU/xqeqaTzDV8nY3eNyEjqjPfyvo3F7DXRzSODsuzx86qp5/8vnI+vebXqQ
	 sozoykN1o+zTbkD3/SesWFwXLoDP0bqMpq5JfYdktaOqDJ4e2MWR8mpPDJp8ebG+BZ
	 ngh4SeIBlf74V3zietQIhQowVewvVur/WjpF8CdsmYkvYwV43o9KIhTzaY3kRIk/8F
	 cP9Dt1RfX/0J3q0Y42XBkacg1udQUf3SqIpfOhdP4RPH1Q/ITOcowWNFzGpeKENaO+
	 exDEEk575mK74TugEOeC7gy8hfR+NY9w1Cc0yGTxlRxHRWinTOWLOTyiW5ML+zryVh
	 v1pl5X8bRZQCA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org,
	syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to don't dirty inode for readonly filesystem
Date: Tue,  4 Jun 2024 15:56:36 +0800
Message-Id: <20240604075636.3126389-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports f2fs bug as below:

kernel BUG at fs/f2fs/inode.c:933!
RIP: 0010:f2fs_evict_inode+0x1576/0x1590 fs/f2fs/inode.c:933
Call Trace:
 evict+0x2a4/0x620 fs/inode.c:664
 dispose_list fs/inode.c:697 [inline]
 evict_inodes+0x5f8/0x690 fs/inode.c:747
 generic_shutdown_super+0x9d/0x2c0 fs/super.c:675
 kill_block_super+0x44/0x90 fs/super.c:1667
 kill_f2fs_super+0x303/0x3b0 fs/f2fs/super.c:4894
 deactivate_locked_super+0xc1/0x130 fs/super.c:484
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2399
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
 do_syscall_64+0x50/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The root cause is:
- do_sys_open
 - f2fs_lookup
  - __f2fs_find_entry
   - f2fs_i_depth_write
    - f2fs_mark_inode_dirty_sync
     - f2fs_dirty_inode
      - set_inode_flag(inode, FI_DIRTY_INODE)

- umount
 - kill_f2fs_super
  - kill_block_super
   - generic_shutdown_super
    - sync_filesystem
    : sb is readonly, skip sync_filesystem()
    - evict_inodes
     - iput
      - f2fs_evict_inode
       - f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE))
       : trigger kernel panic

When we try to repair i_current_depth in readonly filesystem, let's
skip dirty inode to avoid panic in later f2fs_evict_inode().

Cc: stable@vger.kernel.org
Reported-by: syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000e890bc0609a55cff@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8f2b9f62ef73..64cda1d77fe5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -29,6 +29,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (is_inode_flag_set(inode, FI_NEW_INODE))
 		return;
 
+	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+		return;
+
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
-- 
2.40.1


