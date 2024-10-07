Return-Path: <stable+bounces-81468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A818993550
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75A128416A
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9FA139CFA;
	Mon,  7 Oct 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kdAThZSJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4B1D54F0
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323231; cv=none; b=c1wAUe30/w/5kmti4GjHysgu30WSnqQMc2RC+6xWrAABBR+5wsMq+EUkO8ryGBXaKimObFHWCfDPkXGY+NibAJ9KViUa5Oz2ch/TJA/6p9fWUvR1naPLXjmaaVaT48xLqQOJWaRcS1/iVA79L7GXNdMEhmRWb0I5qZUp8xDAoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323231; c=relaxed/simple;
	bh=NhfDq+ltROgh8kK6UW4mXqvH+qQ97zWXAcoCaQ6rtLs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SqQgDYzdcSEKRIwoPN1AhqHRRg7ggTn4ObQhEiSsfzAKEpWfg5uH7Bqw35n7b6yb5Cx3LX2XR4hO3deUMefIooQ+a5yegUv7AndC/HF4l6YznFBM11T71r9w2QUBnwi1YQ2kalP4dVcTpQYYum1RIEyjPNf97T0wLy3H5tYEh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kdAThZSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C59C4CEC6;
	Mon,  7 Oct 2024 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728323231;
	bh=NhfDq+ltROgh8kK6UW4mXqvH+qQ97zWXAcoCaQ6rtLs=;
	h=Subject:To:Cc:From:Date:From;
	b=kdAThZSJkoG7ET2KYLWLux/fcrQqQuX1/Q8Ck1bEhUSwvbhtT+2ClWS0oEQ4AFksf
	 47E4wcgc/u+BhPPEBf6wUo4zSoQQfe9sdSNZB4u2uMW1dRNgSFANVs2H1YM4GSXiHu
	 Sw+mVC3ZzN/7FurOc75fDor2C3KY2gwZgow9uJwE=
Subject: FAILED: patch "[PATCH] drm/sched: Always increment correct scheduler score" failed to apply to 5.15-stable tree
To: tvrtko.ursulin@igalia.com,airlied@gmail.com,christian.koenig@amd.com,daniel@ffwll.ch,ltuikov89@gmail.com,matthew.brost@intel.com,nirmoy.das@amd.com,nirmoy.das@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:46:55 +0200
Message-ID: <2024100755-preacher-reformist-f489@gregkh>
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
git cherry-pick -x 087913e0ba2b3b9d7ccbafb2acf5dab9e35ae1d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100755-preacher-reformist-f489@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

087913e0ba2b ("drm/sched: Always increment correct scheduler score")
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

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 087913e0ba2b3b9d7ccbafb2acf5dab9e35ae1d5 Mon Sep 17 00:00:00 2001
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Date: Tue, 24 Sep 2024 11:19:09 +0100
Subject: [PATCH] drm/sched: Always increment correct scheduler score
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Entities run queue can change during drm_sched_entity_push_job() so make
sure to update the score consistently.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: d41a39dda140 ("drm/scheduler: improve job distribution with multiple queues")
Cc: Nirmoy Das <nirmoy.das@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Luben Tuikov <ltuikov89@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.9+
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240924101914.2713-4-tursulin@igalia.com
Signed-off-by: Christian König <christian.koenig@amd.com>

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index a75eede8bf8d..b2cf3e0c1838 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -586,7 +586,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	ktime_t submit_ts;
 
 	trace_drm_sched_job(sched_job, entity);
-	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
 
 	/*
@@ -614,6 +613,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		rq = entity->rq;
 		sched = rq->sched;
 
+		atomic_inc(sched->score);
 		drm_sched_rq_add_entity(rq, entity);
 		spin_unlock(&entity->rq_lock);
 


