Return-Path: <stable+bounces-191715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52A8C1F9BF
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 11:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB053AEBD4
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1451D3546FB;
	Thu, 30 Oct 2025 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOLo2YOH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300E335BAF;
	Thu, 30 Oct 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820969; cv=none; b=Xnch0qMVAiCFoFaP5PwB4Qx2JsUk1DXJxNhlRO7SKy/ZBWAo8qg1W5eWOphF6x+iN864KAuJWFX/uLI86Y0oZRgmFNzY+BFK5xJ5BOt0G3Ir/Fu/oywBIlUTB5sc4jDtKf9fcc6BJIqUqerquBZHoab/9aZpI/hcXj/wGXPLKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820969; c=relaxed/simple;
	bh=21Imxsayj+IViqhAG6JgOVkWhAy1BH84E8W2Bso8PDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViNMhKtHn8f0vohJmBM3K30XonH63JMwHoYKIp7scBBFhjAm4V2K7yf+RvqDrTx0pTVS1ITCgWv2EYMgLlI1An57VbkQoIcBhc4B7Vakl3wLngpqTqr2Dij4fwDVSb1bOcai79KNqxmtaQyo9yxXYYa5E1AmXSrrcDpKGvzbYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOLo2YOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFFDC4CEF1;
	Thu, 30 Oct 2025 10:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761820969;
	bh=21Imxsayj+IViqhAG6JgOVkWhAy1BH84E8W2Bso8PDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOLo2YOH4OkOEoCN2DKzPliod5u8DzwhLaUYSh74iVtICZoUDt59pB8EOqnc+yKi7
	 fOyvR4BAB6BsL6YKrPtxL5d+SYvMj49JujD8R++V2+geHBZxgpea9o38Br3rYXxctg
	 8n1+lUyYXHRoL1PivR5S+WVqAkbven2QAvK4x8grgpNh07qH7UsV/rFfYoZTGVu0b7
	 IVTNZuawGp+6BYSVTBSiVb1yjODMg8n/IUygF0t0s2bhqjftt69aKPEcclC2kaeii8
	 M1pt38bVOMD78mMJpA1Df7osigAlWmJfaHyPfORpT0tJEVWVgIsVThGRg1Y4iX4aBc
	 EJWfDQn0geYNA==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Melissa Wen <mwen@igalia.com>,
	Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/sched: Use proper locks in drm_sched_job_arm()
Date: Thu, 30 Oct 2025 11:42:19 +0100
Message-ID: <20251030104219.181704-3-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251030104219.181704-2-phasta@kernel.org>
References: <20251030104219.181704-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_arm() is just racing when dereferencing entity and
runqueue.

Add the proper spinlocks.

Cc: stable@vger.kernel.org # v5.16+
Fixes: dbe48d030b28 ("drm/sched: Split drm_sched_job_init")
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c39f0245e3a9..7f938f491b6f 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -859,10 +859,16 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 
 	BUG_ON(!entity);
 	drm_sched_entity_select_rq(entity);
+
+	spin_lock(&entity->lock);
+	spin_lock(&entity->rq->lock);
 	sched = entity->rq->sched;
+	spin_unlock(&entity->rq->lock);
+
+	job->s_priority = entity->priority;
+	spin_unlock(&entity->lock);
 
 	job->sched = sched;
-	job->s_priority = entity->priority;
 
 	drm_sched_fence_init(job->s_fence, job->entity);
 }
-- 
2.49.0


