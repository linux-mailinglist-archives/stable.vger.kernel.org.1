Return-Path: <stable+bounces-121605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F2A58707
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 19:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91414169ABB
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA501F8747;
	Sun,  9 Mar 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tNWNKN/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEE13EFE3
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544189; cv=none; b=NOuXk6C8YF7Xir/JH0HcSv9Ds8IhPWfBod7Syv5FDj2TiEWxlKZS2uxAUos5gG8HpnNHj/PyhG5qtqJhMTYtj+1h1tDobBhd/yOoWKWSgQEmsZN8no1Y1bgPTQusSanbkQ7RJeZRWOEdUAhBfn6RNDzDOWhRa2Pn175zj7DhdXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544189; c=relaxed/simple;
	bh=g8+vVk4J8Xq/A6U955VBcH6r0ygO+ql08dq9iLJKABM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fgY/IUDuCdJholHEQjoZ0jhqBO5sCr+qXnb7ABX8zJy9T0AeiNRVdl+Ho5MKcPAIdKfvHY2QI/sc8luWlni623Qe/GxjnntXLjxBt3+cmpVybtQT7vM3QDmGqqh/rk1HSQgE2Kw2acmLlxkttBFPNY2lalMjW4BctSHCg9K0Yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tNWNKN/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63CAC4CEE3;
	Sun,  9 Mar 2025 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741544189;
	bh=g8+vVk4J8Xq/A6U955VBcH6r0ygO+ql08dq9iLJKABM=;
	h=Subject:To:Cc:From:Date:From;
	b=tNWNKN/STQqPeL3oqwTNFRt8cHlQ5cCXLz5scmvl4qxv7uLP5PFkh78LNG1rL6Lru
	 oCdO5OHtOjzMOQWyRPZVfYGFER+/h8Z6iG5+DIoBsXvhqIK9HyUABK0DwPuCUvGsgX
	 o+b2iic6EgEPuOVaYK35QVYF+fTYpiDesaPiNSdo=
Subject: FAILED: patch "[PATCH] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq" failed to apply to 6.13-stable tree
To: urezki@gmail.com,joelagnelf@nvidia.com,kbusch@kernel.org,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 19:16:13 +0100
Message-ID: <2025030913-contact-unit-647c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x dfd3df31c9db752234d7d2e09bef2aeabb643ce4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030913-contact-unit-647c@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dfd3df31c9db752234d7d2e09bef2aeabb643ce4 Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Fri, 28 Feb 2025 13:13:56 +0100
Subject: [PATCH] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq

Currently kvfree_rcu() APIs use a system workqueue which is
"system_unbound_wq" to driver RCU machinery to reclaim a memory.

Recently, it has been noted that the following kernel warning can
be observed:

<snip>
workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
  WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
  Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) ...
  CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
  Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
  Workqueue: nvme-wq nvme_scan_work
  RIP: 0010:check_flush_dependency+0x112/0x120
  Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 ...
  RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
  RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
  RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
  RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
  R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
  R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
  CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __warn+0xa4/0x140
   ? check_flush_dependency+0x112/0x120
   ? report_bug+0xe1/0x140
   ? check_flush_dependency+0x112/0x120
   ? handle_bug+0x5e/0x90
   ? exc_invalid_op+0x16/0x40
   ? asm_exc_invalid_op+0x16/0x20
   ? timer_recalc_next_expiry+0x190/0x190
   ? check_flush_dependency+0x112/0x120
   ? check_flush_dependency+0x112/0x120
   __flush_work.llvm.1643880146586177030+0x174/0x2c0
   flush_rcu_work+0x28/0x30
   kvfree_rcu_barrier+0x12f/0x160
   kmem_cache_destroy+0x18/0x120
   bioset_exit+0x10c/0x150
   disk_release.llvm.6740012984264378178+0x61/0xd0
   device_release+0x4f/0x90
   kobject_put+0x95/0x180
   nvme_put_ns+0x23/0xc0
   nvme_remove_invalid_namespaces+0xb3/0xd0
   nvme_scan_work+0x342/0x490
   process_scheduled_works+0x1a2/0x370
   worker_thread+0x2ff/0x390
   ? pwq_release_workfn+0x1e0/0x1e0
   kthread+0xb1/0xe0
   ? __kthread_parkme+0x70/0x70
   ret_from_fork+0x30/0x40
   ? __kthread_parkme+0x70/0x70
   ret_from_fork_asm+0x11/0x20
   </TASK>
  ---[ end trace 0000000000000000 ]---
<snip>

To address this switch to use of independent WQ_MEM_RECLAIM
workqueue, so the rules are not violated from workqueue framework
point of view.

Apart of that, since kvfree_rcu() does reclaim memory it is worth
to go with WQ_MEM_RECLAIM type of wq because it is designed for
this purpose.

Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
Reported-by: Keith Busch <kbusch@kernel.org>
Closes: https://lore.kernel.org/all/Z7iqJtCjHKfo8Kho@kbusch-mbp/
Cc: stable@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4030907b6b7d..4c9f0a87f733 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
 static int rcu_delay_page_cache_fill_msec = 5000;
 module_param(rcu_delay_page_cache_fill_msec, int, 0444);
 
+static struct workqueue_struct *rcu_reclaim_wq;
+
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (5 * HZ)
 #define KFREE_N_BATCHES 2
@@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 	if (delayed_work_pending(&krcp->monitor_work)) {
 		delay_left = krcp->monitor_work.timer.expires - jiffies;
 		if (delay < delay_left)
-			mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
+			mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
 		return;
 	}
-	queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
+	queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
 }
 
 static void
@@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
 			// "free channels", the batch can handle. Break
 			// the loop since it is done with this CPU thus
 			// queuing an RCU work is _always_ success here.
-			queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
+			queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
 			WARN_ON_ONCE(!queued);
 			break;
 		}
@@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
 		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-			queue_delayed_work(system_unbound_wq,
+			queue_delayed_work(rcu_reclaim_wq,
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
 		} else {
@@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
 	int i, j;
 	struct shrinker *kfree_rcu_shrinker;
 
+	rcu_reclaim_wq = alloc_workqueue("kvfree_rcu_reclaim",
+			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	WARN_ON(!rcu_reclaim_wq);
+
 	/* Clamp it to [0:100] seconds interval. */
 	if (rcu_delay_page_cache_fill_msec < 0 ||
 		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {


