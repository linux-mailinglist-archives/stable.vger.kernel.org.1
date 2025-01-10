Return-Path: <stable+bounces-108185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C6FA08EF5
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 12:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D78164779
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD4520ADF6;
	Fri, 10 Jan 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E3w6zSr2"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C191F205515
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507713; cv=none; b=o98UP3o/2QAGCnFCgbtmQFtftWkIFN4icunm4nLguhCbzGnZWavn4dSqssI7DCyarsALvu/8ocZPtUSWUHT+3cfxiNQdvAu5V0UkHG9ZokIr+kZBP36sTP1hp/Izl4nkSsPnDjvmx5AhK6rLq2dStJl3Hrb0jJC7e4OuO5iBSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507713; c=relaxed/simple;
	bh=/bgaQ2xRtV6OHId07wjaTxbU2Il9FwZ3ApffuRen39I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=otC0U8HnraehPerh7+RzGEYhKrXjQ0naL3nrw9MVywKgb1d+atZUAsnPUV6l9rGyBIljgJ1zRm8TuEjJvO1BR9zwO//8bAc+ZJN0gT/53H5Sc4XTD78ec7uXmUXBK5EJf5+uRNIusZOSPm8xoG9Swzgy3VDaDF9RDWTtdcRuits=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E3w6zSr2; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JR3qg8roNPa1r4OHOvGTJw/zOE29GW/7Nvx132GrPZ0=; b=E3w6zSr25msb6mlKNti/l8+i5I
	qfbwYqVLtifV2h0LC7m1bSqLhSlpUcBCu70nmon6s40OE0dscX78tPCNfQQYqF8AujahLe9swoscY
	ZYjoKIrlBVOpJ5EjMtSSkwGeIADqXSpjCF6jJBMQ2frUKe46jUnGCJrfeWHRRf0tthSr4Ax8abDYB
	DJ+v3w6nZ0iaE0iD1As8sfR46MEYko4WvcUKFiVEYVYOTYruIlA62OKX9bf+c7iRu0xsbq7XpME9B
	tPesFMExo85VbjeLQZE7jcIzHPsxwGB06AKCJ3Z7Um8/LblyHdB5yx2EEvRovutnji3CsDIrItaGt
	2vb9MELw==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tWCyc-00Dvn1-SM; Fri, 10 Jan 2025 12:14:54 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/sched: Remove job submit/free race when using unordered workqueues
Date: Fri, 10 Jan 2025 11:14:52 +0000
Message-ID: <20250110111452.76976-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After commit f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
and with drivers who use the unordered workqueue sched_jobs can be freed
in parallel as soon as the complete_all(&entity->entity_idle) is called.
This makes all dereferencing in the lower part of the worker unsafe so
lets fix it by moving the complete_all() call to after the worker is done
touching the job.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <pstanner@redhat.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/scheduler/sched_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 57da84908752..f0d02c061c23 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1188,7 +1188,6 @@ static void drm_sched_run_job_work(struct work_struct *w)
 		container_of(w, struct drm_gpu_scheduler, work_run_job);
 	struct drm_sched_entity *entity;
 	struct dma_fence *fence;
-	struct drm_sched_fence *s_fence;
 	struct drm_sched_job *sched_job;
 	int r;
 
@@ -1207,15 +1206,12 @@ static void drm_sched_run_job_work(struct work_struct *w)
 		return;
 	}
 
-	s_fence = sched_job->s_fence;
-
 	atomic_add(sched_job->credits, &sched->credit_count);
 	drm_sched_job_begin(sched_job);
 
 	trace_drm_run_job(sched_job, entity);
 	fence = sched->ops->run_job(sched_job);
-	complete_all(&entity->entity_idle);
-	drm_sched_fence_scheduled(s_fence, fence);
+	drm_sched_fence_scheduled(sched_job->s_fence, fence);
 
 	if (!IS_ERR_OR_NULL(fence)) {
 		/* Drop for original kref_init of the fence */
@@ -1232,6 +1228,7 @@ static void drm_sched_run_job_work(struct work_struct *w)
 				   PTR_ERR(fence) : 0);
 	}
 
+	complete_all(&entity->entity_idle);
 	wake_up(&sched->job_scheduled);
 	drm_sched_run_job_queue(sched);
 }
-- 
2.47.1


