Return-Path: <stable+bounces-164909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E92B139EA
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A223B618B
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A518421CA0C;
	Mon, 28 Jul 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uLvrz5CR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658CD2AF11
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702438; cv=none; b=r9RJfXnp+hpl5jt7atz/FjK4x889Ynvi9lBxGODGP10Ybw8Mj4MGN7JAloTFEhqw66SAXc30ELpi/yJ9walQHgdANTQ4vFNJx3McGFc+dd1K2NiFt2qCk+ep5Q3sJaDRhySqnMyF8vcHmEUHLiWyL8fbra0gBkp/TABEP5yaqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702438; c=relaxed/simple;
	bh=k9ytvACR26OLGfKkrCiCAvchMsT0l7Lgkdh+Hio/wgk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KTB0HI9uu1/InBDJIyEL7sQrRK1TT6X/T2tz/XfaNRtHpOazDA24sSXA/WVEs5nDlZWlTbIuumAbuhQn0NKtoHKze5D4+50a1HKKLOHRbU9w583GGyret0PXdwGE4uC0iR2h4hxIMSUchh8IGPsW7Q0vUPZPBXbcxu0+B5Hlgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uLvrz5CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0D3C4CEE7;
	Mon, 28 Jul 2025 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753702435;
	bh=k9ytvACR26OLGfKkrCiCAvchMsT0l7Lgkdh+Hio/wgk=;
	h=Subject:To:Cc:From:Date:From;
	b=uLvrz5CREZX0sLufD34lzo8ItOY32LKaqjximaDrl0CHk8TJmrxjzyQAx4aitOvyg
	 NKauF90y9irZikLJhZTnQc20wUOQ5ijW/wg+zlGQPnYV/vP2VNPBBDBtBLGgfjAZ5Q
	 5t8+0SwuX/5QwMfnQ2RRThJj98ZHxevRS+qpjHwo=
Subject: FAILED: patch "[PATCH] drm/sched: Remove optimization that causes hang when killing" failed to apply to 6.6-stable tree
To: lincao12@amd.com,christian.koenig@amd.com,phasta@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 13:33:52 +0200
Message-ID: <2025072852-shrivel-theorize-77f8@gregkh>
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
git cherry-pick -x 15f77764e90a713ee3916ca424757688e4f565b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072852-shrivel-theorize-77f8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


