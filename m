Return-Path: <stable+bounces-119747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B94A46BDA
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 21:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D48161F0B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 20:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A50257429;
	Wed, 26 Feb 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Kt1eAYtW"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5F257420
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600000; cv=none; b=DHTAw/A5ZcejsYIqntNjI79GIk/86sFpFc9mBsBz/H87tld4VG2orHWTpNcmEGNsOACCpairkd+yVGA51hT1KhuToXZ75rgP3GqymJXBiufUiUxfJEu5mZ0wA7cfwpR4AdFMMeiJMv4FcDuCQAI/ACkk6ddcOpdR6T6+LZMFFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600000; c=relaxed/simple;
	bh=bUryKYLtnN/BEwb4kNwZZ92cWDNa8JE7Wj0Szh70uSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLRlQNXOvr7+Wrq5plg17UpIk05OdUaX7EgQuW2BgmPQvnFHryPOQztHhwtbwQ1ub8ACgjnjUrzVJR14wGUZxmpSO17zMH7ZrGntRbNSSKV0OIcuzkC5vNBy7abDTGff7AmdQ0DBVRqILNokAJhuMf6qWArRJp+QfZERg4IN+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Kt1eAYtW; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e9Cn6ByLPah154+p0cfCiGDTEchGM+HAhFQn+4UWbM0=; b=Kt1eAYtWfvnnI23KtV0iD+g6oy
	8onJGhgbsCEHMnR5ZQ8tPW/B4gV0aKJZ3T5xvqEA6/ts6VDNWQfX9rhGd7aVhUCfLugDMaDXc50+j
	j9toaLaAdugnRUE0u4GN/FZtE20sDhSGFicFYHR5RWIFUuizXFYpRDsgK2vw/EiKKQfnxI1kLQmA4
	tRWkxQ1jNQ99sK4VZVFHqrGAS+iW8YT6VlQE6bgzBeqm0GdJcmG7esQTZXPRfmZ39fkWN6bXKowXd
	Y1BgrKIJUHMzXubzywy6w31WK4iHhdtVSF0mQXdvrOZ+RwOXeJFjCDKZOrKBv8lmjmBNmZ1f61qvR
	7QaQpZ5g==;
Received: from [187.36.213.55] (helo=1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnNZ3-0019lA-HS; Wed, 26 Feb 2025 20:59:35 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 26 Feb 2025 16:58:59 -0300
Subject: [PATCH 1/6] drm/v3d: Don't run jobs that have errors flagged in
 its fence
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-v3d-gpu-reset-fixes-v1-1-83a969fdd9c1@igalia.com>
References: <20250226-v3d-gpu-reset-fixes-v1-0-83a969fdd9c1@igalia.com>
In-Reply-To: <20250226-v3d-gpu-reset-fixes-v1-0-83a969fdd9c1@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=bUryKYLtnN/BEwb4kNwZZ92cWDNa8JE7Wj0Szh70uSc=;
 b=owEBbQGS/pANAwAIAT/zDop2iPqqAcsmYgBnv3KfDfDWWj8qczEVtu3v+dkTMoqFXTQVzUUFH
 UtCIkSXjbSJATMEAAEIAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCZ79ynwAKCRA/8w6Kdoj6
 qpuJCACN80fHtqEHQF75lH1xT/V+7c1yD4OjYWK2HmI+sC+18Ym7S8TL1iacNyZBKCR8RvRFGXs
 Yx+iwD85dJL/CfhxkIiD0dz7oNXAe1bTW1ufJvITwtlWnZQib02D/GAKAQxddrT2cf1yCzIBg5z
 EG/dvC8wQzqD/mr0yV7TM2rhsYueKv7LRgWx1L0aBlkM2SfYVzEYi0e1WCi2XLpNYbgc43j+3Uv
 9xi48TEdQoj8ggOwCjbtg2xeceOsBCCoVMl/J/Q7DXuKDd0NVakusK6vi3raZqUcPQuJrC1n3u3
 vTpU+tH5MEeSMM416QXJGJr3TS5FQ2I3GqXvg+T4TyjSVCwR
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

The V3D driver still relies on `drm_sched_increase_karma()` and
`drm_sched_resubmit_jobs()` for resubmissions when a timeout occurs.
The function `drm_sched_increase_karma()` marks the job as guilty, while
`drm_sched_resubmit_jobs()` sets an error (-ECANCELED) in the DMA fence of
that guilty job.

Because of this, we must check whether the job’s DMA fence has been
flagged with an error before executing the job. Otherwise, the same guilty
job may be resubmitted indefinitely, causing repeated GPU resets.

This patch adds a check for an error on the job's fence to prevent running
a guilty job that was previously flagged when the GPU timed out.

Note that the CPU and CACHE_CLEAN queues do not require this check, as
their jobs are executed synchronously once the DRM scheduler starts them.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Fixes: 1584f16ca96e ("drm/v3d: Add support for submitting jobs to the TFU.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 80466ce8c7df669280e556c0793490b79e75d2c7..c2010ecdb08f4ba3b54f7783ed33901552d0eba1 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -327,11 +327,15 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
+	v3d->tfu_job = job;
+
 	fence = v3d_fence_create(v3d, V3D_TFU);
 	if (IS_ERR(fence))
 		return NULL;
 
-	v3d->tfu_job = job;
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
 	job->base.irq_fence = dma_fence_get(fence);
@@ -369,6 +373,9 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence;
 	int i, csd_cfg0_reg;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
 	v3d->csd_job = job;
 
 	v3d_invalidate_caches(v3d);

-- 
Git-154)


