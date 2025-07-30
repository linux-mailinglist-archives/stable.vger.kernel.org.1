Return-Path: <stable+bounces-165317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43388B15CAC
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CDE7B1F1F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B23C442C;
	Wed, 30 Jul 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGQphoXG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02120E6;
	Wed, 30 Jul 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868650; cv=none; b=YvHke787VPooN21FP9aAiQ1EztMuY0TJTK57pcw3PIUMXI+WU4X4G0UdGdwg8Tx2JMJjpV4DVBBGCqRDG46xxJhRqM7LN75C0/TuY7z0DJw79i4k39SsHnKs8TbP7e3NLbX+N1t/a6Zopw3JahEE595Q1rSlHkGnWbhUEQ8qv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868650; c=relaxed/simple;
	bh=SA6L6EF3n31FUc3KHoRbXAoXJpY0Zr/nKuVuZNSTg4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjxHKiNL7Sf08vaXBycPzrF4T0g6SoiRm1Lz8eE9TxhxhSwFh/v197PI8Qilwi3p5NyACzeDBvkv0GGosnemBH6Tj7TWfOKtMJFZBbvT06WVb9pywpEij8Tug84bsn2A9IWShEy7bGkAB/AYL3hr+lS1JQcaOI5dRAvTmpGgAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGQphoXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154FAC4CEE7;
	Wed, 30 Jul 2025 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753868649;
	bh=SA6L6EF3n31FUc3KHoRbXAoXJpY0Zr/nKuVuZNSTg4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGQphoXGht5IQsnnEuyluhQtUDcf9kM3M/snpADrurefzswtvEJn+45wyhX5YahgX
	 Czz9I1fay3KOw5WFotjgA2lVU+azdeo0M/xnKG1jiTkluvD1iTaT3OXMS9F+FKpNGF
	 5s9oQhS69uBqCBZczUY+QEt/VZqJga4kESS4Zpsg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Lin.Cao" <lincao12@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 6.12 042/117] drm/sched: Remove optimization that causes hang when killing dependent jobs
Date: Wed, 30 Jul 2025 11:35:11 +0200
Message-ID: <20250730093235.198540394@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
References: <20250730093233.592541778@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin.Cao <lincao12@amd.com>

commit 15f77764e90a713ee3916ca424757688e4f565b9 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c |   21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -368,17 +368,6 @@ void drm_sched_entity_destroy(struct drm
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
  * drm_sched_entity_clear_dep - callback to clear the entities dependency and
  * wake up scheduler
@@ -389,7 +378,8 @@ static void drm_sched_entity_wakeup(stru
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -442,13 +432,6 @@ static bool drm_sched_entity_add_depende
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



