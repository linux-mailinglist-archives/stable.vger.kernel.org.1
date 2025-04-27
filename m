Return-Path: <stable+bounces-136793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B50B4A9E493
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 22:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333AB3BC4CB
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E591FAC59;
	Sun, 27 Apr 2025 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eGTZlhO/"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A71DED57
	for <stable@vger.kernel.org>; Sun, 27 Apr 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745785815; cv=none; b=LWbJtPdyzGkrAeqOzhOeW36Ie/LVx3a7aIEcWBZkTh/VY3ULxYmOHMNg56ck2RofXcL9K3If3+0mhfAJoYPGKi3aVUFFd2HBWLb/8lnGl1xfNQEpPsFNLzdf6dsb4K8a1UG7aEHvhyGwNYXYr5cKjAlmI7UHOHOVF7NmmC6tvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745785815; c=relaxed/simple;
	bh=jTBoJko4C0TQN5hlt0ohgeyi5h6wXckib688sIbMY0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dui040yAoIauvFCz4I5H3h5JaNb7OZIKgZTulI5XJjClcHNtvV7hAwuMJVobbDZD3p7xk1xlVXECZBYvu5rAdclb4IvMfc2tRfDLUzTgd3I4hX8ekM9e8EOPUb/S/ny8qHDFp/u+3F+/Vc4K0C6qoDgmD2buI6B++khtnZVKhnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eGTZlhO/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DJq9pqAKSm5welJfFxtAn+ZPpP43EeqseTT8+PJN9nk=; b=eGTZlhO/ad9Tty6IIHvP+kvsZN
	AEgjc1gswNpcNVvwhB3/wkUQSJ5fQnl6Ri4/hKTzKksbl047pdXqGaTAllxvtYVzpBTUP+xigxCay
	zlFoagE25o1CpOsmkD1zsfaLSsT0QEnwk+7jp8YH2XtSlZyESTY9ZGDhNGWSx2GRXtVN2MSr5wCAw
	q0ng9P4RQvsYzJj9vzhle/eqvslYY0W50r0F8tn3hguCV9yuUUJWy7OF6olRDcaOkwHxl/MIvflm1
	QRnQsMCeh+I+3RQaa+DZtjV0mgQhw/hhEjEFZhd+yc57v045EU/PbemUrmnKz6O75RsrUHHMHNKso
	x1VsF7pQ==;
Received: from [189.7.87.174] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256) (Exim)
	id 1u98dX-009Une-3f; Sun, 27 Apr 2025 22:30:03 +0200
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
Subject: [PATCH] drm/v3d: Add job to pending list if the reset was skipped
Date: Sun, 27 Apr 2025 17:28:21 -0300
Message-ID: <20250427202907.94415-2-mcanal@igalia.com>
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

This situation leads to a memory leak, as exposed in [1].

Similarly to commit 704d3d60fec4 ("drm/etnaviv: don't block scheduler when
GPU is still active"), this patch ensures the job is put back on the
pending list when extending the timeout.

Cc: stable@vger.kernel.org # 6.0
Link: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12227 [1]
Reported-by: Daivik Bhatia <dtgs1208@gmail.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index b3be08b0ca91..a98dcf9d75b1 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -734,11 +734,6 @@ v3d_gpu_reset_for_timeout(struct v3d_dev *v3d, struct drm_sched_job *sched_job)
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 
-/* If the current address or return address have changed, then the GPU
- * has probably made progress and we should delay the reset.  This
- * could fail if the GPU got in an infinite loop in the CL, but that
- * is pretty unlikely outside of an i-g-t testcase.
- */
 static enum drm_gpu_sched_stat
 v3d_cl_job_timedout(struct drm_sched_job *sched_job, enum v3d_queue q,
 		    u32 *timedout_ctca, u32 *timedout_ctra)
@@ -748,9 +743,16 @@ v3d_cl_job_timedout(struct drm_sched_job *sched_job, enum v3d_queue q,
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
+		list_add(&sched_job->list, &sched_job->sched->pending_list);
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 	}
 
@@ -790,11 +792,13 @@ v3d_csd_job_timedout(struct drm_sched_job *sched_job)
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
+		list_add(&sched_job->list, &sched_job->sched->pending_list);
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 	}
 
-- 
2.49.0


