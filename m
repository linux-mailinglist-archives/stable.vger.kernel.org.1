Return-Path: <stable+bounces-74071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A332497204B
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7121F22C41
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F0516DC12;
	Mon,  9 Sep 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="o/3pMLiO"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9C16D4EF
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902397; cv=none; b=RwDvVWxECZzagcLITOvOcwVSxRAlgGtH5z3NqtYWxPcBKk8mc34SrX8PnoG3e3gSCL6PU4nnhNa5JXvhDMtB75sX/XaqFC4z6JaVlZzKE2YHTLNO5UrOrvfy50dAPRQOYZpCGUmN6e4QSrJbyn00vth4YphNPmW0CqvUbBXazvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902397; c=relaxed/simple;
	bh=KFHSCjP0LmgvoqXUCeWfajW53VZCMw//mMqKUk8ARjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3Bn4gw4jJpVycIPhQs2llJEp1594OeV5mxYUycQGwmI8ZfKFQZRade6Qxcv7eMkXCIlADuDQ1z1ikD2vCgrR2m5AuDrSrDWiF7d88Py0/zMMTaDNROTCaGzgEWtwCUZBKRFIqWZv6gVNAmPnT8AInB6V9iDbiwYbNGMs0nXv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=o/3pMLiO; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3SmfDcNV0KWZMPar8/lJem855Q1DXTNAMl9Haq7K4nA=; b=o/3pMLiOlGc0ExiF+o+LhvIyxS
	ljV6jtx5XfXxqc/NTTajuws1D7xOCNeDTZCAO73t+JBwib5vRmFBN51Jbztalap4CjLoGgd+RbhAX
	ciJPBjcX15OPU62ez6Es8yiVbMWbC+GQM5x2mn+9LjCa2yI5n5RAwT4yFTiWyy+TFo10ikbyABT2U
	9kt3n54vvTIDh4+/hygY1+7iB8dMuWXHizqPh8Lxit0kBV7HIQQQUuOT7OSMYESYl+3o+/vwHQbEg
	bPmwXyfRfvH7IXDg5YCZlFY6L5ZDTKfAOb3yr3OWZXt9SnaTYehRzdSLVp/0Ofk7BOb3stQhuI74k
	Inqh22vw==;
Received: from [90.241.98.187] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sni3C-00Bg4q-Fh; Mon, 09 Sep 2024 19:19:42 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Philipp Stanner <pstanner@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/8] drm/sched: Always wake up correct scheduler in drm_sched_entity_push_job
Date: Mon,  9 Sep 2024 18:19:31 +0100
Message-ID: <20240909171937.51550-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909171937.51550-1-tursulin@igalia.com>
References: <20240909171937.51550-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

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
---
 drivers/gpu/drm/scheduler/sched_entity.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index ae8be30472cd..76e422548d40 100644
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
 
-		drm_sched_wakeup(entity->rq->sched, entity);
+		drm_sched_wakeup(sched, entity);
 	}
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
-- 
2.46.0


