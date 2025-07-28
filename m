Return-Path: <stable+bounces-164912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B1EB139EF
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396EB173ABB
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332525CC5E;
	Mon, 28 Jul 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJjIYEJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1D2AF11
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702452; cv=none; b=sIRlC/mpmXDjYbVSeVI7ug1bTyg9YO/gbbt2x7XD12PBVI0SiTqjcXbiWF73M8uGAfFPoW4k1O3RAUF/MOO8+NwRMCA8OW7z/t8V5LAyEMChsI4uJVdkPQiMEVTafWl4DcQggUt9DRShvbWOpAoVEOLQ36nmAfnqxT/RlazWLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702452; c=relaxed/simple;
	bh=dlofWTc5RW6rpSwOjKYvONjhKmMFDLwaSib7WW7aB0M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VTraPUAcL/4AJrtzlJMAX7bIXWnpR06Qo2BE+METJjGPQ7R84LScBtS39QJM9qPDwVaK6IipNUXn8Sbpd6yMIQGFj5V31mtIihHm2XodlzN33aLRKGphSzPkXpX7/E9+AN6bTzxmOTOWZ2EleL+kWolDSRtTe+2gpX6KqlYg4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJjIYEJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536E9C4CEE7;
	Mon, 28 Jul 2025 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753702450;
	bh=dlofWTc5RW6rpSwOjKYvONjhKmMFDLwaSib7WW7aB0M=;
	h=Subject:To:Cc:From:Date:From;
	b=DJjIYEJzgAfVhXSKoOBHiCsbX6OgXN1tj6dJQ+mUL6/MwK/oxcel2eEOfV15xKMEY
	 cGrNXguiTjNUoz2hUXxYqBSLNmtEAtk/RYbs8EhNT7lNvNaQEQTeqD8/tJ7Bo/Kuwv
	 sfn8HFUPyEx+OidXcH96KHkC9PgWkb24A5o8XZV8=
Subject: FAILED: patch "[PATCH] drm/sched: Remove optimization that causes hang when killing" failed to apply to 5.15-stable tree
To: lincao12@amd.com,christian.koenig@amd.com,phasta@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 13:33:54 +0200
Message-ID: <2025072854-backlog-freeness-4f50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 15f77764e90a713ee3916ca424757688e4f565b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072854-backlog-freeness-4f50@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15f77764e90a713ee3916ca424757688e4f565b9 Mon Sep 17 00:00:00 2001
From: "Lin.Cao" <lincao12@amd.com>
Date: Thu, 17 Jul 2025 16:44:53 +0800
Subject: [PATCH] drm/sched: Remove optimization that causes hang when killing
 dependent jobs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When application A submits jobs and application B submits a job with a
dependency on A's fence, the normal flow wakes up the scheduler after
processing each job. However, the optimization in
drm_sched_entity_add_dependency_cb() uses a callback that only clears
dependencies without waking up the scheduler.

When application A is killed before its jobs can run, the callback gets
triggered but only clears the dependency without waking up the scheduler,
causing the scheduler to enter sleep state and application B to hang.

Remove the optimization by deleting drm_sched_entity_clear_dep() and its
usage, ensuring the scheduler is always woken up when dependencies are
cleared.

Fixes: 777dbd458c89 ("drm/amdgpu: drop a dummy wakeup scheduler")
Cc: stable@vger.kernel.org # v4.6+
Signed-off-by: Lin.Cao <lincao12@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Link: https://lore.kernel.org/r/20250717084453.921097-1-lincao12@amd.com

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index e671aa241720..ac678de7fe5e 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -355,17 +355,6 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
 }
 EXPORT_SYMBOL(drm_sched_entity_destroy);
 
-/* drm_sched_entity_clear_dep - callback to clear the entities dependency */
-static void drm_sched_entity_clear_dep(struct dma_fence *f,
-				       struct dma_fence_cb *cb)
-{
-	struct drm_sched_entity *entity =
-		container_of(cb, struct drm_sched_entity, cb);
-
-	entity->dependency = NULL;
-	dma_fence_put(f);
-}
-
 /*
  * drm_sched_entity_wakeup - callback to clear the entity's dependency and
  * wake up the scheduler
@@ -376,7 +365,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -429,13 +419,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
 		fence = dma_fence_get(&s_fence->scheduled);
 		dma_fence_put(entity->dependency);
 		entity->dependency = fence;
-		if (!dma_fence_add_callback(fence, &entity->cb,
-					    drm_sched_entity_clear_dep))
-			return true;
-
-		/* Ignore it when it is already scheduled */
-		dma_fence_put(fence);
-		return false;
 	}
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,


