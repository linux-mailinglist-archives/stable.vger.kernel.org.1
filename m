Return-Path: <stable+bounces-45803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CE8CD3F9
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A561F26B0A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5506E14B955;
	Thu, 23 May 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwQHNy9d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245814A633;
	Thu, 23 May 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470406; cv=none; b=fue8MzJw5OqgSESL21uoSKNV4XuzPUCxDDRNG/EsG1Ezo9Ab3NQz35q9Zge9pdj+JBm+iAiMfDk+fhHhh4IXiEo607CBIk5qe1aU+RASyoDQSigDsfzEYP3v+/sGEooS1seEroN88teY5gjvMW1FjVIUQOZqqC27nsE1XVRCDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470406; c=relaxed/simple;
	bh=MWTdxTxzs4elC6e01bPED4Y58D+puIg0RO5Z9GOpQqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIIrnjbpdrCl/c99DdV2J1KA6Uf2oYRkquti4OxUNAMf2VSufsMSpsVlDDXJOlzJmQ2lOXC+YuNcU5GtAGFV8kvMSIHlw8pBd0vyWFq4RJZj4Rl+JHusW9qc+ATuE4DtviCLWKVfyDPDQsM+a0Y5N/Wxfktl6DrrssSLhaLtA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwQHNy9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEA6C2BD10;
	Thu, 23 May 2024 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470405;
	bh=MWTdxTxzs4elC6e01bPED4Y58D+puIg0RO5Z9GOpQqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TwQHNy9dKFrSyLmnhl4OxHj+P2My0HvmZYbh8/INAMyRgJNzjpAAA2gBqY6u1gIsl
	 Co0IQvUL3X8mr5stgkIYxH1O3FOs0Ng2TL0uoODLajuiSrj/kJDFdJWSKtrENRycQT
	 a6JFEYHzh43cl/amMWkrtkegDHwdgUYm9B++KOiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guo Xuenan <guoxuenan@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 25/45] xfs: wait iclog complete before tearing down AIL
Date: Thu, 23 May 2024 15:13:16 +0200
Message-ID: <20240523130333.446550693@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
References: <20240523130332.496202557@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guo Xuenan <guoxuenan@huawei.com>

[ Upstream commit 1eb52a6a71981b80f9acbd915acd6a05a5037196 ]

Fix uaf in xfs_trans_ail_delete during xlog force shutdown.
In commit cd6f79d1fb32 ("xfs: run callbacks before waking waiters in
xlog_state_shutdown_callbacks") changed the order of running callbacks
and wait for iclog completion to avoid unmount path untimely destroy AIL.
But which seems not enough to ensue this, adding mdelay in
`xfs_buf_item_unpin` can prove that.

The reproduction is as follows. To ensure destroy AIL safely,
we should wait all xlog ioend workers done and sync the AIL.

==================================================================
BUG: KASAN: use-after-free in xfs_trans_ail_delete+0x240/0x2a0
Read of size 8 at addr ffff888023169400 by task kworker/1:1H/43

CPU: 1 PID: 43 Comm: kworker/1:1H Tainted: G        W
6.1.0-rc1-00002-gc28266863c4a #137
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: xfs-log/sda xlog_ioend_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x4d/0x66
 print_report+0x171/0x4a6
 kasan_report+0xb3/0x130
 xfs_trans_ail_delete+0x240/0x2a0
 xfs_buf_item_done+0x7b/0xa0
 xfs_buf_ioend+0x1e9/0x11f0
 xfs_buf_item_unpin+0x4c8/0x860
 xfs_trans_committed_bulk+0x4c2/0x7c0
 xlog_cil_committed+0xab6/0xfb0
 xlog_cil_process_committed+0x117/0x1e0
 xlog_state_shutdown_callbacks+0x208/0x440
 xlog_force_shutdown+0x1b3/0x3a0
 xlog_ioend_work+0xef/0x1d0
 process_one_work+0x6f9/0xf70
 worker_thread+0x578/0xf30
 kthread+0x28c/0x330
 ret_from_fork+0x1f/0x30
 </TASK>

Allocated by task 9606:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 __kasan_kmalloc+0x7a/0x90
 __kmalloc+0x59/0x140
 kmem_alloc+0xb2/0x2f0
 xfs_trans_ail_init+0x20/0x320
 xfs_log_mount+0x37e/0x690
 xfs_mountfs+0xe36/0x1b40
 xfs_fs_fill_super+0xc5c/0x1a70
 get_tree_bdev+0x3c5/0x6c0
 vfs_get_tree+0x85/0x250
 path_mount+0xec3/0x1830
 do_mount+0xef/0x110
 __x64_sys_mount+0x150/0x1f0
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 9662:
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x21/0x30
 kasan_save_free_info+0x2a/0x40
 __kasan_slab_free+0x105/0x1a0
 __kmem_cache_free+0x99/0x2d0
 kvfree+0x3a/0x40
 xfs_log_unmount+0x60/0xf0
 xfs_unmountfs+0xf3/0x1d0
 xfs_fs_put_super+0x78/0x300
 generic_shutdown_super+0x151/0x400
 kill_block_super+0x9a/0xe0
 deactivate_locked_super+0x82/0xe0
 deactivate_super+0x91/0xb0
 cleanup_mnt+0x32a/0x4a0
 task_work_run+0x15f/0x240
 exit_to_user_mode_prepare+0x188/0x190
 syscall_exit_to_user_mode+0x12/0x30
 do_syscall_64+0x42/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888023169400
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes inside of
 128-byte region [ffff888023169400, ffff888023169480)

The buggy address belongs to the physical page:
page:ffffea00008c5a00 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff888023168f80 pfn:0x23168
head:ffffea00008c5a00 order:1 compound_mapcount:0 compound_pincount:0
flags: 0x1fffff80010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
raw: 001fffff80010200 ffffea00006b3988 ffffea0000577a88 ffff88800f842ac0
raw: ffff888023168f80 0000000000150007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888023169300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888023169380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888023169400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888023169480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888023169500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Disabling lock debugging due to kernel taint

Fixes: cd6f79d1fb32 ("xfs: run callbacks before waking waiters in xlog_state_shutdown_callbacks")
Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_log.c |   36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -887,6 +887,23 @@ xlog_force_iclog(
 }
 
 /*
+ * Cycle all the iclogbuf locks to make sure all log IO completion
+ * is done before we tear down these buffers.
+ */
+static void
+xlog_wait_iclog_completion(struct xlog *log)
+{
+	int		i;
+	struct xlog_in_core	*iclog = log->l_iclog;
+
+	for (i = 0; i < log->l_iclog_bufs; i++) {
+		down(&iclog->ic_sema);
+		up(&iclog->ic_sema);
+		iclog = iclog->ic_next;
+	}
+}
+
+/*
  * Wait for the iclog and all prior iclogs to be written disk as required by the
  * log force state machine. Waiting on ic_force_wait ensures iclog completions
  * have been ordered and callbacks run before we are woken here, hence
@@ -1111,6 +1128,14 @@ xfs_log_unmount(
 {
 	xfs_log_clean(mp);
 
+	/*
+	 * If shutdown has come from iclog IO context, the log
+	 * cleaning will have been skipped and so we need to wait
+	 * for the iclog to complete shutdown processing before we
+	 * tear anything down.
+	 */
+	xlog_wait_iclog_completion(mp->m_log);
+
 	xfs_buftarg_drain(mp->m_ddev_targp);
 
 	xfs_trans_ail_destroy(mp);
@@ -2114,17 +2139,6 @@ xlog_dealloc_log(
 	int		i;
 
 	/*
-	 * Cycle all the iclogbuf locks to make sure all log IO completion
-	 * is done before we tear down these buffers.
-	 */
-	iclog = log->l_iclog;
-	for (i = 0; i < log->l_iclog_bufs; i++) {
-		down(&iclog->ic_sema);
-		up(&iclog->ic_sema);
-		iclog = iclog->ic_next;
-	}
-
-	/*
 	 * Destroy the CIL after waiting for iclog IO completion because an
 	 * iclog EIO error will try to shut down the log, which accesses the
 	 * CIL to wake up the waiters.



