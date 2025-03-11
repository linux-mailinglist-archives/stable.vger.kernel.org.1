Return-Path: <stable+bounces-124073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900D4A5CD95
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AC63BAE68
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A1C2638BF;
	Tue, 11 Mar 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e58DWT+C"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D92638B0;
	Tue, 11 Mar 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716871; cv=none; b=jlvfWNjlosNtLFWftXD7WzNUgEJq1wvxFFGoGScEDGuaqzSnGjrgTOjiFoh8/gvqLPrZ8So2pWSnFq0EhMUB6Kd6LuNJYcmliaEui5pi0Gquw/rIJq0z3Nj26BwZeAKZQT8Ruj80xybYRG9lUuUTjFUWrvaOWeASMqNNwKkGkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716871; c=relaxed/simple;
	bh=pUXjA+I7tCLIoH3bNrkO4IB28zYBbl1H9vaCVIpHHNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kp11H8DKeETqwaVTIeBa62eiMTyICJJtKkhoYnEc2DnrehlqnE26zYiLwpZzMzRVqa4JQfu3/bkT3v8srPkmDitjAyvCQ6JK8Ac+VBEq9l7IisfUQbJwfNtbhxBLenyPeZKkcG+jwo2CVcWcWCPoI2yquKK39o0WPdsnsjioHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e58DWT+C; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FcMGhykXB4u4YxIGnBy/HoDy7WeSl1BAMrtIHGKlZ4g=; b=e58DWT+C7c1Bp2eLmbP4LOczVo
	1i71i9O+vt+vM7WVuujnwe6IWfG1C1cgSlQnleqnbfrokZOgsO/tppcsX5x+HqKcmyO/nnTlI3Dih
	1LeX4TFKzc6V6BYtTUp3gQbQyA6Wu+DPG165K9DwytF9+dS1i/LhGngWa5ASHT6w5j2MPaE6YTMj0
	chh7RdSUd4sFXtLSfb2r+Q4YhbnOGQz86adXO8hdp4fyVWw+ADljlzeMIZ3lIPC/rLjM/dpIHS1eL
	XR9xwdsVyd4bi5748/GceuLbgVPsrsVxUiatR2Wqvb9j2JM7RyIxej0c2RomPmXlddVjp9WJDX6sH
	JTMFMUeg==;
Received: from [189.7.87.170] (helo=janis.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ts47M-007Dal-LL; Tue, 11 Mar 2025 19:14:22 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 11 Mar 2025 15:13:43 -0300
Subject: [PATCH v3 1/7] drm/v3d: Don't run jobs that have errors flagged in
 its fence
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250311-v3d-gpu-reset-fixes-v3-1-64f7a4247ec0@igalia.com>
References: <20250311-v3d-gpu-reset-fixes-v3-0-64f7a4247ec0@igalia.com>
In-Reply-To: <20250311-v3d-gpu-reset-fixes-v3-0-64f7a4247ec0@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Phil Elwell <phil@raspberrypi.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, kernel-dev@igalia.com, stable@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=pUXjA+I7tCLIoH3bNrkO4IB28zYBbl1H9vaCVIpHHNI=;
 b=owEBbQGS/pANAwAIAT/zDop2iPqqAcsmYgBn0H10ZadohT0Zdp1KOMiUSWGwcglcntHOvWs1F
 0hTzW1dejuJATMEAAEIAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCZ9B9dAAKCRA/8w6Kdoj6
 qoUiB/0anrK+NSftVWYLjQL2p7DgJPp4+B6tgcXgHNUpj6xgqw9/vvqJy1xN6tMCD7ENckWNaZY
 FAInnvfczIu4iGvcUYbMnc1cMrdr648aovc1xBFuPEiffMUrhPaAERCdaTELHt/FslW3Nfcs5hX
 yjs7WznET7F3mVh3+t0s1QRvNlJokggnKTVIVmZXvS61fdhLyb5rhz1AKPdSuDDUFaJ0EJMdsKK
 azQNPY6kA1C3AFNyZm30cnVu+5XcqAqkkAMuL/rBM+uzoJ/ENSlAlxF0KjTaVRKzERRyQ9+lO1d
 2jtcXGdjD/t1IeXdAXU4yqmNJa/2AmO4k9+6UJj/YeSdJwjk
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
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
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


