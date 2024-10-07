Return-Path: <stable+bounces-81467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DF0993551
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE09B24333
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C2B1DD868;
	Mon,  7 Oct 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0rFHmLoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36144156E4
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323228; cv=none; b=PbCsdj+p+dN60t/gIQpWbG44+E9qzSCwTXEnV2DzxZFMpSH7MlsON+craQFHC4FXHMaqmMD8bPC0IUx28g1dKYZFyt/y5BppyvrylBhXQd2/XPl5nWjbyGFMHUMsh441QFTEo+mK/QDWhoEnOMX4k03p7vBbgZ4KWycpeq8rvnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323228; c=relaxed/simple;
	bh=bJUUO/GWzRThBoiaC2z+5R3diP2dyK3vjpH9CpvOxFo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jCZLSXZPYyjGqe87Mqkm6AYc8+0inyrQrOoDHUiLk9OKU4wlkO6wtBERSvJNlw362vuBcOnafnnnM3uQLm1atk77w1Nej3yLYf8NUVXztDh8EyVsu4S1k7BLnT3lulQ4+t+HALpaMbZhbVQmdyxOPV37U2CT09a91FCYFuA3FTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0rFHmLoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E432C4CEC7;
	Mon,  7 Oct 2024 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728323228;
	bh=bJUUO/GWzRThBoiaC2z+5R3diP2dyK3vjpH9CpvOxFo=;
	h=Subject:To:Cc:From:Date:From;
	b=0rFHmLoYzXflBn7ZM8emK/AKyk4yNdVnibgY1Fo0uTxsSGF5k1KWLUEFAANiRCn39
	 jYOXRWA28p23u8towF4vRkNlk1mFx7dMAWA1im9cNjCaCBjT0LisXdm0YS/SdG3TVz
	 KYSiuwH+nlOQpfRdsBGK0i8uFKZTAdHaNPtRdmtk=
Subject: FAILED: patch "[PATCH] drm/sched: Always increment correct scheduler score" failed to apply to 6.1-stable tree
To: tvrtko.ursulin@igalia.com,airlied@gmail.com,christian.koenig@amd.com,daniel@ffwll.ch,ltuikov89@gmail.com,matthew.brost@intel.com,nirmoy.das@amd.com,nirmoy.das@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:46:54 +0200
Message-ID: <2024100754-headlock-unbridle-a6ed@gregkh>
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
git cherry-pick -x 087913e0ba2b3b9d7ccbafb2acf5dab9e35ae1d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100754-headlock-unbridle-a6ed@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


