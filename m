Return-Path: <stable+bounces-106807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E82A02331
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA45D163814
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133881D63D7;
	Mon,  6 Jan 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QtACV73V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4913B676
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159878; cv=none; b=bexzpYRzhzYlnaNtf3z8w8bDBNo6APHtNOsiUFLIivngQU72a6dVrXkkofTNgafEvmNfvwWozvXaG6eZ55aVznif5kLrWYXxyMdBB50OGigP1oylmZFDO7q8TwsI6hlMliyk3yXRTQXsC0eoovygYnSYWaziexvqfkunVp+nt24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159878; c=relaxed/simple;
	bh=78hXmAPeHoNqaT4MSHdLamU0yCSfBq2agbwJGFmINxo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IW0i9MEsWp9spXBCWvZlLPQVBrRis/UeqBUJ+MKHxLHhlzmWRacgjIPomqSPNrrgv/MP1mv8+eQ6EwU4EAxOxNlHv2A2vlylUt0Md1JwBgiCKmT6sNHObZXJw8ZjAQeRyJHTUb23bMigHjYnE/T5BR5/x8nAOBQJyPYBthepK7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QtACV73V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6C2C4CED2;
	Mon,  6 Jan 2025 10:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736159878;
	bh=78hXmAPeHoNqaT4MSHdLamU0yCSfBq2agbwJGFmINxo=;
	h=Subject:To:Cc:From:Date:From;
	b=QtACV73Vwme5U8bapGQqIg6ydjo9kxZ5iHKZ0yBzUvWuOp1AFMCro5nM27TW9JlDw
	 2abYGBiiGAa2+GHK3bImxbh9UVMYyqMCAxs/T/nH/D8a+ND0EUGCDowp5/0t1sS3oD
	 4eVN5O8oigpVuXKFem47cVjaYGm9wXsYe2Nan8w8=
Subject: FAILED: patch "[PATCH] workqueue: Do not warn when cancelling WQ_MEM_RECLAIM work" failed to apply to 6.1-stable tree
To: tvrtko.ursulin@igalia.com,alexander.deucher@amd.com,christian.koenig@amd.com,jiangshanlai@gmail.com,matthew.brost@intel.com,peterz@infradead.org,stable@vger.kernel.org,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 06 Jan 2025 11:37:53 +0100
Message-ID: <2025010653-enroll-disagree-652b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x de35994ecd2dd6148ab5a6c5050a1670a04dec77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010653-enroll-disagree-652b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From de35994ecd2dd6148ab5a6c5050a1670a04dec77 Mon Sep 17 00:00:00 2001
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date: Thu, 19 Dec 2024 09:30:30 +0000
Subject: [PATCH] workqueue: Do not warn when cancelling WQ_MEM_RECLAIM work
 from !WQ_MEM_RECLAIM worker
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After commit
746ae46c1113 ("drm/sched: Mark scheduler work queues with WQ_MEM_RECLAIM")
amdgpu started seeing the following warning:

 [ ] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work [gpu_sched] is flushing !WQ_MEM_RECLAIM events:amdgpu_device_delay_enable_gfx_off [amdgpu]
...
 [ ] Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
...
 [ ] Call Trace:
 [ ]  <TASK>
...
 [ ]  ? check_flush_dependency+0xf5/0x110
...
 [ ]  cancel_delayed_work_sync+0x6e/0x80
 [ ]  amdgpu_gfx_off_ctrl+0xab/0x140 [amdgpu]
 [ ]  amdgpu_ring_alloc+0x40/0x50 [amdgpu]
 [ ]  amdgpu_ib_schedule+0xf4/0x810 [amdgpu]
 [ ]  ? drm_sched_run_job_work+0x22c/0x430 [gpu_sched]
 [ ]  amdgpu_job_run+0xaa/0x1f0 [amdgpu]
 [ ]  drm_sched_run_job_work+0x257/0x430 [gpu_sched]
 [ ]  process_one_work+0x217/0x720
...
 [ ]  </TASK>

The intent of the verifcation done in check_flush_depedency is to ensure
forward progress during memory reclaim, by flagging cases when either a
memory reclaim process, or a memory reclaim work item is flushed from a
context not marked as memory reclaim safe.

This is correct when flushing, but when called from the
cancel(_delayed)_work_sync() paths it is a false positive because work is
either already running, or will not be running at all. Therefore
cancelling it is safe and we can relax the warning criteria by letting the
helper know of the calling context.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: fca839c00a12 ("workqueue: warn if memory reclaim tries to flush !WQ_MEM_RECLAIM workqueue")
References: 746ae46c1113 ("drm/sched: Mark scheduler work queues with WQ_MEM_RECLAIM")
Cc: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v4.5+
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8b07576814a5..8336218ec4b8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3680,23 +3680,27 @@ void workqueue_softirq_dead(unsigned int cpu)
  * check_flush_dependency - check for flush dependency sanity
  * @target_wq: workqueue being flushed
  * @target_work: work item being flushed (NULL for workqueue flushes)
+ * @from_cancel: are we called from the work cancel path
  *
  * %current is trying to flush the whole @target_wq or @target_work on it.
- * If @target_wq doesn't have %WQ_MEM_RECLAIM, verify that %current is not
- * reclaiming memory or running on a workqueue which doesn't have
- * %WQ_MEM_RECLAIM as that can break forward-progress guarantee leading to
- * a deadlock.
+ * If this is not the cancel path (which implies work being flushed is either
+ * already running, or will not be at all), check if @target_wq doesn't have
+ * %WQ_MEM_RECLAIM and verify that %current is not reclaiming memory or running
+ * on a workqueue which doesn't have %WQ_MEM_RECLAIM as that can break forward-
+ * progress guarantee leading to a deadlock.
  */
 static void check_flush_dependency(struct workqueue_struct *target_wq,
-				   struct work_struct *target_work)
+				   struct work_struct *target_work,
+				   bool from_cancel)
 {
-	work_func_t target_func = target_work ? target_work->func : NULL;
+	work_func_t target_func;
 	struct worker *worker;
 
-	if (target_wq->flags & WQ_MEM_RECLAIM)
+	if (from_cancel || target_wq->flags & WQ_MEM_RECLAIM)
 		return;
 
 	worker = current_wq_worker();
+	target_func = target_work ? target_work->func : NULL;
 
 	WARN_ONCE(current->flags & PF_MEMALLOC,
 		  "workqueue: PF_MEMALLOC task %d(%s) is flushing !WQ_MEM_RECLAIM %s:%ps",
@@ -3980,7 +3984,7 @@ void __flush_workqueue(struct workqueue_struct *wq)
 		list_add_tail(&this_flusher.list, &wq->flusher_overflow);
 	}
 
-	check_flush_dependency(wq, NULL);
+	check_flush_dependency(wq, NULL, false);
 
 	mutex_unlock(&wq->mutex);
 
@@ -4155,7 +4159,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	}
 
 	wq = pwq->wq;
-	check_flush_dependency(wq, work);
+	check_flush_dependency(wq, work, from_cancel);
 
 	insert_wq_barrier(pwq, barr, work, worker);
 	raw_spin_unlock_irq(&pool->lock);


