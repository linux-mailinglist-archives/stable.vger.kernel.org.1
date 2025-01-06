Return-Path: <stable+bounces-106806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB1A02330
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 11:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D358C1634D8
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4219E7EB;
	Mon,  6 Jan 2025 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oFWRf/an"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686A1D5171
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159875; cv=none; b=ITp5c3p9yjhWAZmVQSS0yJmWaWyr2xLaR8L+aCgibFsy/wfwKyw31TpDLTCKt2n8xi+lRHXTeFp0yJ5rPq47GiDpS6DriVofvoHPng/tBz7umaS1IsQbJd3gpjNjmS9+yApos47JeQfFZNL2zPbWkeJXir1whg5axxuD15AV7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159875; c=relaxed/simple;
	bh=WVep5VycK/53II3QlCOu0Jpxr8GmU34Jo1np/LshoQU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HB9WYNqro8uCDz0Hf40A55ZZzq4PnG7sApAmzvdZgow+4VWSM83o+Wdhtc64l9psNmfgZIXl6A36UikGMKb+3kwWTHR7hgXpwRK8G7QrXfNvaFAIq4KBxu/+1zjPDtF1qM2h7LDfjlHRdfxYHmzaPzJ8TDOY1Kw4OZMVzpzBeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oFWRf/an; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A037CC4CED2;
	Mon,  6 Jan 2025 10:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736159875;
	bh=WVep5VycK/53II3QlCOu0Jpxr8GmU34Jo1np/LshoQU=;
	h=Subject:To:Cc:From:Date:From;
	b=oFWRf/anyRpsn2x5ZIF+PaaeQkV5iNuG9kKX0qvr57Q18FOWKxKMW1ITkuNHOuofO
	 +99Vm3ANyeiDJDrHN8eGLNAmYE4Hybjwo/h4Gg3hp2dAww82+KEDk4YWY6NU0aGcF3
	 Ra53DPPP/S2yQGe/Wssl1bkaNMDtoG8b61hDB3G4=
Subject: FAILED: patch "[PATCH] workqueue: Do not warn when cancelling WQ_MEM_RECLAIM work" failed to apply to 6.6-stable tree
To: tvrtko.ursulin@igalia.com,alexander.deucher@amd.com,christian.koenig@amd.com,jiangshanlai@gmail.com,matthew.brost@intel.com,peterz@infradead.org,stable@vger.kernel.org,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 06 Jan 2025 11:37:52 +0100
Message-ID: <2025010652-clad-doorframe-5d77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x de35994ecd2dd6148ab5a6c5050a1670a04dec77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025010652-clad-doorframe-5d77@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


