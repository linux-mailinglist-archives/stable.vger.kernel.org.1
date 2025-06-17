Return-Path: <stable+bounces-154498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15207ADDA6A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39714067A0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C962FA62E;
	Tue, 17 Jun 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D8eL+SD7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002032FA624;
	Tue, 17 Jun 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179404; cv=none; b=XRGo8b9h35r4Tsf5f+W8QU4C12q4Yu/z08J2mHVehyVy62HXiWMI/jk1OMApY97IWfI5txiOvPHIiHzEsmVqi/VWjfvvElmgdb2JtjGQSEYhUXeD+S2QPxf/KfDmXOf4jFxEJnCsqhXZryt7Ar5G+jCWG2297pBj62i5PnaYtco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179404; c=relaxed/simple;
	bh=pa18rvMnOCpfE2XHKbPZHYOfMIL4Uz/2kx1i+RFdglc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGOdrfWbpveezg4B5LAFS0Pd7dMT1Q19lKTFHQv1fGSfsRYPVZbByzUWFKpyiew0356U8Ai4IpriWuXNXNlvZAfNEJmA+DRZYD7hZgis6V4gJFu3AjM5pKtRpvgoqATdK49HBSTu0pdTlM+E1k2p4P0butimR9dmNy98YzNHDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D8eL+SD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0128FC4CEE3;
	Tue, 17 Jun 2025 16:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179401;
	bh=pa18rvMnOCpfE2XHKbPZHYOfMIL4Uz/2kx1i+RFdglc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8eL+SD79U/CzL1TOnPIEPkbqIe2DVhCri7Fzi1FBxGYxNbb9CprWPTcaG8NOLHCW
	 TR3BCxkSC76yScO7MFkIus1D2SxtrCvSOjPN3guxOvRTm8yvDoEHgD7Qsx6C6ibCLv
	 AgMDVd/amyme1x9qaN0JzIR+W132RjHCVqOjEtuU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+531502bbbe51d2f769f4@syzkaller.appspotmail.com,
	Penglei Jiang <superman.xpt@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 733/780] io_uring: fix use-after-free of sq->thread in __io_uring_show_fdinfo()
Date: Tue, 17 Jun 2025 17:27:21 +0200
Message-ID: <20250617152521.349954289@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Penglei Jiang <superman.xpt@gmail.com>

[ Upstream commit ac0b8b327a5677dc6fecdf353d808161525b1ff0 ]

syzbot reports:

BUG: KASAN: slab-use-after-free in getrusage+0x1109/0x1a60
Read of size 8 at addr ffff88810de2d2c8 by task a.out/304

CPU: 0 UID: 0 PID: 304 Comm: a.out Not tainted 6.16.0-rc1 #1 PREEMPT(voluntary)
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 print_report+0xd0/0x670
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? getrusage+0x1109/0x1a60
 kasan_report+0xce/0x100
 ? getrusage+0x1109/0x1a60
 getrusage+0x1109/0x1a60
 ? __pfx_getrusage+0x10/0x10
 __io_uring_show_fdinfo+0x9fe/0x1790
 ? ksys_read+0xf7/0x1c0
 ? do_syscall_64+0xa4/0x260
 ? vsnprintf+0x591/0x1100
 ? __pfx___io_uring_show_fdinfo+0x10/0x10
 ? __pfx_vsnprintf+0x10/0x10
 ? mutex_trylock+0xcf/0x130
 ? __pfx_mutex_trylock+0x10/0x10
 ? __pfx_show_fd_locks+0x10/0x10
 ? io_uring_show_fdinfo+0x57/0x80
 io_uring_show_fdinfo+0x57/0x80
 seq_show+0x38c/0x690
 seq_read_iter+0x3f7/0x1180
 ? inode_set_ctime_current+0x160/0x4b0
 seq_read+0x271/0x3e0
 ? __pfx_seq_read+0x10/0x10
 ? __pfx__raw_spin_lock+0x10/0x10
 ? __mark_inode_dirty+0x402/0x810
 ? selinux_file_permission+0x368/0x500
 ? file_update_time+0x10f/0x160
 vfs_read+0x177/0xa40
 ? __pfx___handle_mm_fault+0x10/0x10
 ? __pfx_vfs_read+0x10/0x10
 ? mutex_lock+0x81/0xe0
 ? __pfx_mutex_lock+0x10/0x10
 ? fdget_pos+0x24d/0x4b0
 ksys_read+0xf7/0x1c0
 ? __pfx_ksys_read+0x10/0x10
 ? do_user_addr_fault+0x43b/0x9c0
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0f74170fc9
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 8
RSP: 002b:00007fffece049e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0f74170fc9
RDX: 0000000000001000 RSI: 00007fffece049f0 RDI: 0000000000000004
RBP: 00007fffece05ad0 R08: 0000000000000000 R09: 00007fffece04d90
R10: 0000000000000000 R11: 0000000000000206 R12: 00005651720a1100
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 298:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_slab_alloc+0x6e/0x70
 kmem_cache_alloc_node_noprof+0xe8/0x330
 copy_process+0x376/0x5e00
 create_io_thread+0xab/0xf0
 io_sq_offload_create+0x9ed/0xf20
 io_uring_setup+0x12b0/0x1cc0
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 22:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x37/0x50
 kmem_cache_free+0xc4/0x360
 rcu_core+0x5ff/0x19f0
 handle_softirqs+0x18c/0x530
 run_ksoftirqd+0x20/0x30
 smpboot_thread_fn+0x287/0x6c0
 kthread+0x30d/0x630
 ret_from_fork+0xef/0x1a0
 ret_from_fork_asm+0x1a/0x30

Last potentially related work creation:
 kasan_save_stack+0x33/0x60
 kasan_record_aux_stack+0x8c/0xa0
 __call_rcu_common.constprop.0+0x68/0x940
 __schedule+0xff2/0x2930
 __cond_resched+0x4c/0x80
 mutex_lock+0x5c/0xe0
 io_uring_del_tctx_node+0xe1/0x2b0
 io_uring_clean_tctx+0xb7/0x160
 io_uring_cancel_generic+0x34e/0x760
 do_exit+0x240/0x2350
 do_group_exit+0xab/0x220
 __x64_sys_exit_group+0x39/0x40
 x64_sys_call+0x1243/0x1840
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88810de2cb00
 which belongs to the cache task_struct of size 3712
The buggy address is located 1992 bytes inside of
 freed 3712-byte region [ffff88810de2cb00, ffff88810de2d980)

which is caused by the task_struct pointed to by sq->thread being
released while it is being used in the function
__io_uring_show_fdinfo(). Holding ctx->uring_lock does not prevent ehre
relase or exit of sq->thread.

Fix this by assigning and looking up ->thread under RCU, and grabbing a
reference to the task_struct. This ensures that it cannot get released
while fdinfo is using it.

Reported-by: syzbot+531502bbbe51d2f769f4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/682b06a5.a70a0220.3849cf.00b3.GAE@google.com
Fixes: 3fcb9d17206e ("io_uring/sqpoll: statistics of the true utilization of sq threads")
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
Link: https://lore.kernel.org/r/20250610171801.70960-1-superman.xpt@gmail.com
[axboe: massage commit message]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/fdinfo.c | 12 ++++++++++--
 io_uring/sqpoll.c |  9 ++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index e0d6a59a89fa1..f948917f7f707 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -172,18 +172,26 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
 		struct io_sq_data *sq = ctx->sq_data;
+		struct task_struct *tsk;
 
+		rcu_read_lock();
+		tsk = rcu_dereference(sq->thread);
 		/*
 		 * sq->thread might be NULL if we raced with the sqpoll
 		 * thread termination.
 		 */
-		if (sq->thread) {
+		if (tsk) {
+			get_task_struct(tsk);
+			rcu_read_unlock();
+			getrusage(tsk, RUSAGE_SELF, &sq_usage);
+			put_task_struct(tsk);
 			sq_pid = sq->task_pid;
 			sq_cpu = sq->sq_cpu;
-			getrusage(sq->thread, RUSAGE_SELF, &sq_usage);
 			sq_total_time = (sq_usage.ru_stime.tv_sec * 1000000
 					 + sq_usage.ru_stime.tv_usec);
 			sq_work_time = sq->work_time;
+		} else {
+			rcu_read_unlock();
 		}
 	}
 
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 03c699493b5ab..0625a421626f4 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -270,7 +270,8 @@ static int io_sq_thread(void *data)
 	/* offload context creation failed, just exit */
 	if (!current->io_uring) {
 		mutex_lock(&sqd->lock);
-		sqd->thread = NULL;
+		rcu_assign_pointer(sqd->thread, NULL);
+		put_task_struct(current);
 		mutex_unlock(&sqd->lock);
 		goto err_out;
 	}
@@ -379,7 +380,8 @@ static int io_sq_thread(void *data)
 		io_sq_tw(&retry_list, UINT_MAX);
 
 	io_uring_cancel_generic(true, sqd);
-	sqd->thread = NULL;
+	rcu_assign_pointer(sqd->thread, NULL);
+	put_task_struct(current);
 	list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
 		atomic_or(IORING_SQ_NEED_WAKEUP, &ctx->rings->sq_flags);
 	io_run_task_work();
@@ -495,9 +497,6 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		ret = -EINVAL;
 		goto err;
 	}
-
-	if (task_to_put)
-		put_task_struct(task_to_put);
 	return 0;
 err_sqpoll:
 	complete(&ctx->sq_data->exited);
-- 
2.39.5




