Return-Path: <stable+bounces-70166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F8E95EFEA
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8BB1F21D13
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B599D1547D8;
	Mon, 26 Aug 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UxFPBpwe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D531482E3
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672346; cv=none; b=pZnmTztlfB5UQrgnqNn43KZN5cqoiiSrhL9lH25sI/0nJPJcm+gBZr+B7LZ/ii64F1h+dVapN9xLKLxDycUCYUXcPxKx0uuDdW1d0fslrMVTOgRW+YxnQYTZlZGC7ku7k7B7fJqTrGdhkwhszyZaNaKzG7VLjdqvzwgS1MNYjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672346; c=relaxed/simple;
	bh=K9pYGFXspMD2IbxVqDoOKtTVm4RCH4cJwOdUCBVnncQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HO1eQ867MGtbkJCM6PJod3X8R0m04eEa+mgRumg64wzNsXBUA7DHTzFqnEifH0KesftSUMG/8b60CxJXvO+rwn3nNiuqL3t0P3DHphFt+5jo5MdMvT87SgnRepjxJjkgxZcvSQlIJIM2X1ORQL7Cizn9hjlzs770IPFURtFOwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UxFPBpwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC4EC5140E;
	Mon, 26 Aug 2024 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724672346;
	bh=K9pYGFXspMD2IbxVqDoOKtTVm4RCH4cJwOdUCBVnncQ=;
	h=Subject:To:Cc:From:Date:From;
	b=UxFPBpwe5Yv9YM4fQeyv+82i0xYOsQ2EGwCTuR3dcb8xgnRMCCPvx/C1LVxV4HuBZ
	 arthwq8wnLSjy1abSY4fLtywK/78QJATkIa1Ikl22ilHyA4vZRyxKhyusbE3pSabPC
	 DYpaVXX3T41khWpelrc6wYyERtyiWXAE2TNSBCiE=
Subject: FAILED: patch "[PATCH] drm/xe: prevent UAF around preempt fence" failed to apply to 6.10-stable tree
To: matthew.auld@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 13:39:03 +0200
Message-ID: <2024082602-sneezing-kettle-88ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 730b72480e29f63fd644f5fa57c9d46109428953
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082602-sneezing-kettle-88ca@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

730b72480e29 ("drm/xe: prevent UAF around preempt fence")
731e46c03228 ("drm/xe/exec_queue: Rename xe_exec_queue::compute to xe_exec_queue::lr")
b3181f433206 ("drm/xe/vm: Simplify if condition")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 730b72480e29f63fd644f5fa57c9d46109428953 Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Wed, 14 Aug 2024 12:01:30 +0100
Subject: [PATCH] drm/xe: prevent UAF around preempt fence

The fence lock is part of the queue, therefore in the current design
anything locking the fence should then also hold a ref to the queue to
prevent the queue from being freed.

However, currently it looks like we signal the fence and then drop the
queue ref, but if something is waiting on the fence, the waiter is
kicked to wake up at some later point, where upon waking up it first
grabs the lock before checking the fence state. But if we have already
dropped the queue ref, then the lock might already be freed as part of
the queue, leading to uaf.

To prevent this, move the fence lock into the fence itself so we don't
run into lifetime issues. Alternative might be to have device level
lock, or only release the queue in the fence release callback, however
that might require pushing to another worker to avoid locking issues.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2454
References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2342
References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2020
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240814110129.825847-2-matthew.auld@intel.com
(cherry picked from commit 7116c35aacedc38be6d15bd21b2fc936eed0008b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 16f24f4a7062..9731dcd0b1bd 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -643,7 +643,6 @@ int xe_exec_queue_create_ioctl(struct drm_device *dev, void *data,
 
 		if (xe_vm_in_preempt_fence_mode(vm)) {
 			q->lr.context = dma_fence_context_alloc(1);
-			spin_lock_init(&q->lr.lock);
 
 			err = xe_vm_add_compute_exec_queue(vm, q);
 			if (XE_IOCTL_DBG(xe, err))
diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index a35ce24c9798..f6ee0ae80fd6 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -126,8 +126,6 @@ struct xe_exec_queue {
 		u32 seqno;
 		/** @lr.link: link into VM's list of exec queues */
 		struct list_head link;
-		/** @lr.lock: preemption fences lock */
-		spinlock_t lock;
 	} lr;
 
 	/** @ops: submission backend exec queue operations */
diff --git a/drivers/gpu/drm/xe/xe_preempt_fence.c b/drivers/gpu/drm/xe/xe_preempt_fence.c
index e8b8ae5c6485..c453f45328b1 100644
--- a/drivers/gpu/drm/xe/xe_preempt_fence.c
+++ b/drivers/gpu/drm/xe/xe_preempt_fence.c
@@ -128,8 +128,9 @@ xe_preempt_fence_arm(struct xe_preempt_fence *pfence, struct xe_exec_queue *q,
 {
 	list_del_init(&pfence->link);
 	pfence->q = xe_exec_queue_get(q);
+	spin_lock_init(&pfence->lock);
 	dma_fence_init(&pfence->base, &preempt_fence_ops,
-		      &q->lr.lock, context, seqno);
+		      &pfence->lock, context, seqno);
 
 	return &pfence->base;
 }
diff --git a/drivers/gpu/drm/xe/xe_preempt_fence_types.h b/drivers/gpu/drm/xe/xe_preempt_fence_types.h
index b54b5c29b533..312c3372a49f 100644
--- a/drivers/gpu/drm/xe/xe_preempt_fence_types.h
+++ b/drivers/gpu/drm/xe/xe_preempt_fence_types.h
@@ -25,6 +25,8 @@ struct xe_preempt_fence {
 	struct xe_exec_queue *q;
 	/** @preempt_work: work struct which issues preemption */
 	struct work_struct preempt_work;
+	/** @lock: dma-fence fence lock */
+	spinlock_t lock;
 	/** @error: preempt fence is in error state */
 	int error;
 };


