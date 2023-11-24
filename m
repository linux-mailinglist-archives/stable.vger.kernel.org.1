Return-Path: <stable+bounces-2210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F997F833B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965B31C25075
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE31E2E858;
	Fri, 24 Nov 2023 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCknKiNw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01892E853;
	Fri, 24 Nov 2023 19:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1F9C433C8;
	Fri, 24 Nov 2023 19:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853323;
	bh=ESC52ktzUnw+FK+KWOnrqjozZs3fq23+4JNSbeDmxMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCknKiNwp0/PCWrDykh9MysYlMa4/YHxXa30v7nCMRINDcTeaRF81ovwX7l7K7eCw
	 Zuw960pTwDdtQ24mvPpxnsVQefvvCxLQLYGaOTJo8WG0xdq875SfYp+kEnQellL7s2
	 eRpJgHmI56RwEYemO7gSKu9TiBu0Fgb6FU+xnhoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Leah Rumancik <leah.rumancik@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 143/297] xfs: prevent a UAF when log IO errors race with unmount
Date: Fri, 24 Nov 2023 17:53:05 +0000
Message-ID: <20231124172005.269739726@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darrick J. Wong <djwong@kernel.org>

[ Upstream commit 7561cea5dbb97fecb952548a0fb74fb105bf4664 ]

KASAN reported the following use after free bug when running
generic/475:

 XFS (dm-0): Mounting V5 Filesystem
 XFS (dm-0): Starting recovery (logdev: internal)
 XFS (dm-0): Ending recovery (logdev: internal)
 Buffer I/O error on dev dm-0, logical block 20639616, async page read
 Buffer I/O error on dev dm-0, logical block 20639617, async page read
 XFS (dm-0): log I/O error -5
 XFS (dm-0): Filesystem has been shut down due to log error (0x2).
 XFS (dm-0): Unmounting Filesystem
 XFS (dm-0): Please unmount the filesystem and rectify the problem(s).
 ==================================================================
 BUG: KASAN: use-after-free in do_raw_spin_lock+0x246/0x270
 Read of size 4 at addr ffff888109dd84c4 by task 3:1H/136

 CPU: 3 PID: 136 Comm: 3:1H Not tainted 5.19.0-rc4-xfsx #rc4 8e53ab5ad0fddeb31cee5e7063ff9c361915a9c4
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
 Workqueue: xfs-log/dm-0 xlog_ioend_work [xfs]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x34/0x44
  print_report.cold+0x2b8/0x661
  ? do_raw_spin_lock+0x246/0x270
  kasan_report+0xab/0x120
  ? do_raw_spin_lock+0x246/0x270
  do_raw_spin_lock+0x246/0x270
  ? rwlock_bug.part.0+0x90/0x90
  xlog_force_shutdown+0xf6/0x370 [xfs 4ad76ae0d6add7e8183a553e624c31e9ed567318]
  xlog_ioend_work+0x100/0x190 [xfs 4ad76ae0d6add7e8183a553e624c31e9ed567318]
  process_one_work+0x672/0x1040
  worker_thread+0x59b/0xec0
  ? __kthread_parkme+0xc6/0x1f0
  ? process_one_work+0x1040/0x1040
  ? process_one_work+0x1040/0x1040
  kthread+0x29e/0x340
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

 Allocated by task 154099:
  kasan_save_stack+0x1e/0x40
  __kasan_kmalloc+0x81/0xa0
  kmem_alloc+0x8d/0x2e0 [xfs]
  xlog_cil_init+0x1f/0x540 [xfs]
  xlog_alloc_log+0xd1e/0x1260 [xfs]
  xfs_log_mount+0xba/0x640 [xfs]
  xfs_mountfs+0xf2b/0x1d00 [xfs]
  xfs_fs_fill_super+0x10af/0x1910 [xfs]
  get_tree_bdev+0x383/0x670
  vfs_get_tree+0x7d/0x240
  path_mount+0xdb7/0x1890
  __x64_sys_mount+0x1fa/0x270
  do_syscall_64+0x2b/0x80
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

 Freed by task 154151:
  kasan_save_stack+0x1e/0x40
  kasan_set_track+0x21/0x30
  kasan_set_free_info+0x20/0x30
  ____kasan_slab_free+0x110/0x190
  slab_free_freelist_hook+0xab/0x180
  kfree+0xbc/0x310
  xlog_dealloc_log+0x1b/0x2b0 [xfs]
  xfs_unmountfs+0x119/0x200 [xfs]
  xfs_fs_put_super+0x6e/0x2e0 [xfs]
  generic_shutdown_super+0x12b/0x3a0
  kill_block_super+0x95/0xd0
  deactivate_locked_super+0x80/0x130
  cleanup_mnt+0x329/0x4d0
  task_work_run+0xc5/0x160
  exit_to_user_mode_prepare+0xd4/0xe0
  syscall_exit_to_user_mode+0x1d/0x40
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

This appears to be a race between the unmount process, which frees the
CIL and waits for in-flight iclog IO; and the iclog IO completion.  When
generic/475 runs, it starts fsstress in the background, waits a few
seconds, and substitutes a dm-error device to simulate a disk falling
out of a machine.  If the fsstress encounters EIO on a pure data write,
it will exit but the filesystem will still be online.

The next thing the test does is unmount the filesystem, which tries to
clean the log, free the CIL, and wait for iclog IO completion.  If an
iclog was being written when the dm-error switch occurred, it can race
with log unmounting as follows:

Thread 1				Thread 2

					xfs_log_unmount
					xfs_log_clean
					xfs_log_quiesce
xlog_ioend_work
<observe error>
xlog_force_shutdown
test_and_set_bit(XLOG_IOERROR)
					xfs_log_force
					<log is shut down, nop>
					xfs_log_umount_write
					<log is shut down, nop>
					xlog_dealloc_log
					xlog_cil_destroy
					<wait for iclogs>
spin_lock(&log->l_cilp->xc_push_lock)
<KABOOM>

Therefore, free the CIL after waiting for the iclogs to complete.  I
/think/ this race has existed for quite a few years now, though I don't
remember the ~2014 era logging code well enough to know if it was a real
threat then or if the actual race was exposed only more recently.

Fixes: ac983517ec59 ("xfs: don't sleep in xlog_cil_force_lsn on shutdown")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_log.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 0fb7d05ca308d..eba295f666acc 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -2061,8 +2061,6 @@ xlog_dealloc_log(
 	xlog_in_core_t	*iclog, *next_iclog;
 	int		i;
 
-	xlog_cil_destroy(log);
-
 	/*
 	 * Cycle all the iclogbuf locks to make sure all log IO completion
 	 * is done before we tear down these buffers.
@@ -2074,6 +2072,13 @@ xlog_dealloc_log(
 		iclog = iclog->ic_next;
 	}
 
+	/*
+	 * Destroy the CIL after waiting for iclog IO completion because an
+	 * iclog EIO error will try to shut down the log, which accesses the
+	 * CIL to wake up the waiters.
+	 */
+	xlog_cil_destroy(log);
+
 	iclog = log->l_iclog;
 	for (i = 0; i < log->l_iclog_bufs; i++) {
 		next_iclog = iclog->ic_next;
-- 
2.42.0




