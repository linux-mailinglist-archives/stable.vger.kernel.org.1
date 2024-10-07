Return-Path: <stable+bounces-81465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84099354E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BF02842D5
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE81DDA06;
	Mon,  7 Oct 2024 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EWcmWxsn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE93B1DD868
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323217; cv=none; b=Y9Oo3bW4pUv+YfvbZv3x0gpXC+pzHomgVT6sFI+Wqef9GqcnHLF9ibg5Z+VBn4NWywQ6zCZNGkWNvwYh7UM/j6bkhVq1t0aANblo0r2/5zPNcpd5YgFwYRPeoXh5gsGblyr7sJxtcc5Pz1bWLHv13TWhwPVqHjhDOL9b/FKjo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323217; c=relaxed/simple;
	bh=pnIMP7O8WS25bSHjBvPFRlLlAHGeCmR8glpHG4XUvGc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kMKkCs8CrNAWmXbu1PBdFT/x6vxgKyuYLUBIj7P2G8bjCpRp6FZ6LJMsYSlQuE7YkxWBYvqCe4UVfy4D14BTWOYXtl8pxu3ILmCQlXlAWgnK6AFTHb4sXOy+QQ+prvlPD+BTLo+csBJGzZ8U48tYDyfvNDbE3PgQUzHszm9ciE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EWcmWxsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D084C4CEC6;
	Mon,  7 Oct 2024 17:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728323217;
	bh=pnIMP7O8WS25bSHjBvPFRlLlAHGeCmR8glpHG4XUvGc=;
	h=Subject:To:Cc:From:Date:From;
	b=EWcmWxsn9X/IRTKJd8zkt8qMnqGITC+/4wq9LMpgJhS7RiXA460WxQzV7pMqvJriW
	 lIbay2FzI/xVVBFkVr5yLgofEU/dJEhTP+g6K6otqlwiemTNY47eN+IBUxT4rpFlAS
	 rv+NkrxJNZz3zb6UbXh7MvGZYfYU3InYtFlV+Ggc=
Subject: FAILED: patch "[PATCH] drm/sched: Always wake up correct scheduler in" failed to apply to 5.10-stable tree
To: tvrtko.ursulin@igalia.com,airlied@gmail.com,alexander.deucher@amd.com,christian.koenig@amd.com,daniel@ffwll.ch,ltuikov89@gmail.com,matthew.brost@intel.com,pstanner@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:46:41 +0200
Message-ID: <2024100741-crying-undrilled-a32f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cbc8764e29c2318229261a679b2aafd0f9072885
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100741-crying-undrilled-a32f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

cbc8764e29c2 ("drm/sched: Always wake up correct scheduler in drm_sched_entity_push_job")
440d52b370b0 ("drm/sched: Fix dynamic job-flow control race")
f92a39ae4707 ("drm/sched: Partial revert of "Qualify drm_sched_wakeup() by drm_sched_entity_is_ready()"")
a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
f3123c259000 ("drm/sched: Qualify drm_sched_wakeup() by drm_sched_entity_is_ready()")
bc8d6a9df990 ("drm/sched: Don't disturb the entity when in RR-mode scheduling")
f12af4c461fb ("drm/sched: Drop suffix from drm_sched_wakeup_if_can_queue")
35a4279d42db ("drm/sched: Rename drm_sched_run_job_queue_if_ready and clarify kerneldoc")
67dd1d8c9f65 ("drm/sched: Rename drm_sched_free_job_queue to be more descriptive")
e608d9f7ac1a ("drm/sched: Move free worker re-queuing out of the if block")
7abbbe2694b3 ("drm/sched: Rename drm_sched_get_cleanup_job to be more descriptive")
f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
a6149f039369 ("drm/sched: Convert drm scheduler to use a work queue rather than kthread")
35963cf2cd25 ("drm/sched: Add drm_sched_wqueue_* helpers")
0da611a87021 ("dma-buf: add dma_fence_timestamp helper")
56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
7b05a7c0c9ca ("drm/nouveau: get vmm via nouveau_cli_vmm()")
e02238990b1a ("drm/nouveau: new VM_BIND uAPI interfaces")
7a5d5f9c0587 ("drm/nouveau: fixup the uapi header file.")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cbc8764e29c2318229261a679b2aafd0f9072885 Mon Sep 17 00:00:00 2001
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date: Tue, 24 Sep 2024 11:19:08 +0100
Subject: [PATCH] drm/sched: Always wake up correct scheduler in
 drm_sched_entity_push_job
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since drm_sched_entity_modify_sched() can modify the entities run queue,
lets make sure to only dereference the pointer once so both adding and
waking up are guaranteed to be consistent.

Alternative of moving the spin_unlock to after the wake up would for now
be more problematic since the same lock is taken inside
drm_sched_rq_update_fifo().

v2:
 * Improve commit message. (Philipp)
 * Cache the scheduler pointer directly. (Christian)

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: b37aced31eb0 ("drm/scheduler: implement a function to modify sched list")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Stanner <pstanner@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.7+
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240924101914.2713-3-tursulin@igalia.com
Signed-off-by: Christian König <christian.koenig@amd.com>

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 0e002c17fcb6..a75eede8bf8d 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -599,6 +599,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 	/* first job wakes up scheduler */
 	if (first) {
+		struct drm_gpu_scheduler *sched;
+		struct drm_sched_rq *rq;
+
 		/* Add the entity to the run queue */
 		spin_lock(&entity->rq_lock);
 		if (entity->stopped) {
@@ -608,13 +611,16 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 			return;
 		}
 
-		drm_sched_rq_add_entity(entity->rq, entity);
+		rq = entity->rq;
+		sched = rq->sched;
+
+		drm_sched_rq_add_entity(rq, entity);
 		spin_unlock(&entity->rq_lock);
 
 		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
 			drm_sched_rq_update_fifo(entity, submit_ts);
 
-		drm_sched_wakeup(entity->rq->sched);
+		drm_sched_wakeup(sched);
 	}
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);


