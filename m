Return-Path: <stable+bounces-139221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC53AA5675
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F7E3B2DEA
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC398298CB2;
	Wed, 30 Apr 2025 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HSa56L30"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994B1CAA62
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047231; cv=none; b=An8rNyYtqjBOvNI8ozfmWlFjmp7HnoJMdW2QHoa+Q2k+mvA1pb26KL1VpuFQu0yEiOxu5I2wVaWEcS/J4Ur/Sz9wp054EMzCqqsXTV9PKUUR4iapvbm3yFi0NW7mZloS6+64WQBUE/ORRV5XDf3HKz+XjraK3BmZh7P/42XzmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047231; c=relaxed/simple;
	bh=ghqZigJ1lI3QgBkbGlCoFd74q/r0WAVnOD6GAAhby+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hiM0dO45bSnAHqrPrnk1VLf2wIHcrYnxzLHAjIHgfR8QatLpnz4GqIIOpyR86mazYkraijmhS1qzLXUPriZevaEODwA9cqA3xIQCnRWl1FoQHmBPtrwo0MmlExOWYBCSwtMjvSITKOKT5vVZ8712FX3E7b0JX+ONRwaQVlSkt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HSa56L30; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TVgKImvOgQ5iXDXZfftce7xrDvSiDUF+zpUQsNobFrs=; b=HSa56L305mTrLVk+NvbMdZDA7R
	Wn9S5z2dVS/FPy8OyystdtzbCukxf8+wynrKyvE9Cw116i9otLsjKmC59kVNiWofYl6veVBnMlhDo
	L+j14T+45PWsqOhUB3k0cYNeYY2LYQtF8lqK1WJJCPId/svnpM/fa8n0bj/Le5cAnOnOECuptXHdU
	Sv1OL8euZ/lrOJUOpEMv+awEpL+iLwaifcKBqT79We2FNZfo1piHHE3JVgx02WGQntukKrRBY2lrR
	s76Oay7VIwBv6UY/LEev39LwH5s9L4qdJSypeH9UA0F5nPJxrP8RLKN0dKrVMCZjsSCqcDFTZV/QZ
	1aF3PP1Q==;
Received: from [189.7.87.174] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256) (Exim)
	id 1uAEcw-0016h9-4o; Wed, 30 Apr 2025 23:07:01 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>,
	Iago Toral <itoral@igalia.com>,
	Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	stable@vger.kernel.org,
	Daivik Bhatia <dtgs1208@gmail.com>
Subject: [PATCH v2] drm/v3d: Add job to pending list if the reset was skipped
Date: Wed, 30 Apr 2025 17:51:52 -0300
Message-ID: <20250430210643.57924-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a CL/CSD job times out, we check if the GPU has made any progress
since the last timeout. If so, instead of resetting the hardware, we skip
the reset and let the timer get rearmed. This gives long-running jobs a
chance to complete.

However, when `timedout_job()` is called, the job in question is removed
from the pending list, which means it won't be automatically freed through
`free_job()`. Consequently, when we skip the reset and keep the job
running, the job won't be freed when it finally completes.

This situation leads to a memory leak, as exposed in [1] and [2].

Similarly to commit 704d3d60fec4 ("drm/etnaviv: don't block scheduler when
GPU is still active"), this patch ensures the job is put back on the
pending list when extending the timeout.

Cc: stable@vger.kernel.org # 6.0
Reported-by: Daivik Bhatia <dtgs1208@gmail.com>
Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12227 [1]
Closes: https://github.com/raspberrypi/linux/issues/6817 [2]
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
---

Hi,

While we typically strive to avoid exposing the scheduler's internals
within the drivers, I'm proposing this fix as an interim solution. I'm aware
that a comprehensive fix will need some adjustments on the DRM sched side,
and I plan to address that soon.

However, it would be hard to justify the backport of such patches to the
stable branches and this issue is affecting users in the moment.
Therefore, I'd like to push this patch to drm-misc-fixes in order to
address this leak as soon as possible, while working in a more generic
solution.

Best Regards,
- Maíra

v1 -> v2: https://lore.kernel.org/dri-devel/20250427202907.94415-2-mcanal@igalia.com/

- Protect the pending list by using its spinlock.
- Add the URL of another downstream issue related to this patch. 

 drivers/gpu/drm/v3d/v3d_sched.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index b3be08b0ca91..c612363181df 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -734,11 +734,16 @@ v3d_gpu_reset_for_timeout(struct v3d_dev *v3d, struct drm_sched_job *sched_job)
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 
-/* If the current address or return address have changed, then the GPU
- * has probably made progress and we should delay the reset.  This
- * could fail if the GPU got in an infinite loop in the CL, but that
- * is pretty unlikely outside of an i-g-t testcase.
- */
+static void
+v3d_sched_skip_reset(struct drm_sched_job *sched_job)
+{
+	struct drm_gpu_scheduler *sched = sched_job->sched;
+
+	spin_lock(&sched->job_list_lock);
+	list_add(&sched_job->list, &sched->pending_list);
+	spin_unlock(&sched->job_list_lock);
+}
+
 static enum drm_gpu_sched_stat
 v3d_cl_job_timedout(struct drm_sched_job *sched_job, enum v3d_queue q,
 		    u32 *timedout_ctca, u32 *timedout_ctra)
@@ -748,9 +753,16 @@ v3d_cl_job_timedout(struct drm_sched_job *sched_job, enum v3d_queue q,
 	u32 ctca = V3D_CORE_READ(0, V3D_CLE_CTNCA(q));
 	u32 ctra = V3D_CORE_READ(0, V3D_CLE_CTNRA(q));
 
+	/* If the current address or return address have changed, then the GPU
+	 * has probably made progress and we should delay the reset. This
+	 * could fail if the GPU got in an infinite loop in the CL, but that
+	 * is pretty unlikely outside of an i-g-t testcase.
+	 */
 	if (*timedout_ctca != ctca || *timedout_ctra != ctra) {
 		*timedout_ctca = ctca;
 		*timedout_ctra = ctra;
+
+		v3d_sched_skip_reset(sched_job);
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 	}
 
@@ -790,11 +802,13 @@ v3d_csd_job_timedout(struct drm_sched_job *sched_job)
 	struct v3d_dev *v3d = job->base.v3d;
 	u32 batches = V3D_CORE_READ(0, V3D_CSD_CURRENT_CFG4(v3d->ver));
 
-	/* If we've made progress, skip reset and let the timer get
-	 * rearmed.
+	/* If we've made progress, skip reset, add the job to the pending
+	 * list, and let the timer get rearmed.
 	 */
 	if (job->timedout_batches != batches) {
 		job->timedout_batches = batches;
+
+		v3d_sched_skip_reset(sched_job);
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 	}
 
-- 
2.49.0


