Return-Path: <stable+bounces-59076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225AC92E33B
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9638F1F238F2
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 09:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6DB155312;
	Thu, 11 Jul 2024 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iStinXrB"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E808179AB
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689351; cv=none; b=qdC3jBOOuCf1HaIJT200pPrRyEcSy2cshFllRHppbTvcLD1p2tuVqnFxCx8JCm65c2GVmLLfi2sP7gqgjUE6aNU8cmrScCLwgbVDZhdG3wPCVMvoawYKR9zcfXmBsHyn2OxgqAsHNGdzTiit1++WK/4plXdUz5amy5SXJw6bwt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689351; c=relaxed/simple;
	bh=7V3jUTdZmQWPRfMh9okWQi/bishxsV/PBy+F/fjJA5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrBlS9AiOPe55/EzXXURPOM1VRR739wA3TeHHxnEwJFSRSqVuqyc70OnEFxpdUnzwp/Z5zheWigxTJ0ww9dKk5aoPB62vt4sYCOshnJ1Z/Ju4tCgeEPsJr9bbxENb921c3F9YnKofBUpMdHc42qSVwPSM33K67U0So76ybo5bJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iStinXrB; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kCXRX3dcArGziVViF/qMwyRr6jaVdtXMzNEXI93cS70=; b=iStinXrBtyAm7yiviQkuvnuLuB
	AjXHuQEHXF5jfBPeR6xX9ItHXrn93EAOEZhHHoUyUpqY6WA9+ejq3yz9UF9HWfT9sziwjabskYtr1
	JIR6/Xzjs44sde2AYNmZTjbvfAqhPlJYHb/N+YLSwwAslaVy0t6imlVoRVEhlpKa/yNpbKsh9UusF
	SUt6szzGoSskiGAuDtZ7e/hBiiJg7+u48Pblfx1lCxBnUSOVFoZqTvbytimUx0XL9nFJzjZ10UdeZ
	EvzzXxXsiEC4Rqoy8ctVhgSTSW0UcdepULYkavhrCN3Gsq+bko2Nq9HmeFPMshotWBy9jBtT2E5I+
	AYJNpPNg==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRptx-00DcKO-21; Thu, 11 Jul 2024 11:15:45 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/11] drm/v3d: Fix potential memory leak in the timestamp extension
Date: Thu, 11 Jul 2024 10:15:33 +0100
Message-ID: <20240711091542.82083-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711091542.82083-1-tursulin@igalia.com>
References: <20240711091542.82083-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

If fetching of userspace memory fails during the main loop, all drm sync
objs looked up until that point will be leaked because of the missing
drm_syncobj_put.

Fix it by exporting and using a common cleanup helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  2 ++
 drivers/gpu/drm/v3d/v3d_sched.c  | 22 +++++++++++-----
 drivers/gpu/drm/v3d/v3d_submit.c | 43 ++++++++++++++++++++++----------
 3 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 099b962bdfde..e208ffdfba32 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -563,6 +563,8 @@ void v3d_mmu_insert_ptes(struct v3d_bo *bo);
 void v3d_mmu_remove_ptes(struct v3d_bo *bo);
 
 /* v3d_sched.c */
+void v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
+				   unsigned int count);
 void v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue);
 int v3d_sched_init(struct v3d_dev *v3d);
 void v3d_sched_fini(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 03df37a3acf5..59dc0287dab9 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -73,18 +73,28 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
 	v3d_job_cleanup(job);
 }
 
+void
+v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
+			      unsigned int count)
+{
+	if (query_info->queries) {
+		unsigned int i;
+
+		for (i = 0; i < count; i++)
+			drm_syncobj_put(query_info->queries[i].syncobj);
+
+		kvfree(query_info->queries);
+	}
+}
+
 static void
 v3d_cpu_job_free(struct drm_sched_job *sched_job)
 {
 	struct v3d_cpu_job *job = to_cpu_job(sched_job);
-	struct v3d_timestamp_query_info *timestamp_query = &job->timestamp_query;
 	struct v3d_performance_query_info *performance_query = &job->performance_query;
 
-	if (timestamp_query->queries) {
-		for (int i = 0; i < timestamp_query->count; i++)
-			drm_syncobj_put(timestamp_query->queries[i].syncobj);
-		kvfree(timestamp_query->queries);
-	}
+	v3d_timestamp_query_info_free(&job->timestamp_query,
+				      job->timestamp_query.count);
 
 	if (performance_query->queries) {
 		for (int i = 0; i < performance_query->count; i++)
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 263fefc1d04f..121bf1314b80 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -452,6 +452,8 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 {
 	u32 __user *offsets, *syncs;
 	struct drm_v3d_timestamp_query timestamp;
+	unsigned int i;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -480,19 +482,19 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 	offsets = u64_to_user_ptr(timestamp.offsets);
 	syncs = u64_to_user_ptr(timestamp.syncs);
 
-	for (int i = 0; i < timestamp.count; i++) {
+	for (i = 0; i < timestamp.count; i++) {
 		u32 offset, sync;
 
 		if (copy_from_user(&offset, offsets++, sizeof(offset))) {
-			kvfree(job->timestamp_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		job->timestamp_query.queries[i].offset = offset;
 
 		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
-			kvfree(job->timestamp_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
@@ -500,6 +502,10 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 	job->timestamp_query.count = timestamp.count;
 
 	return 0;
+
+error:
+	v3d_timestamp_query_info_free(&job->timestamp_query, i);
+	return err;
 }
 
 static int
@@ -509,6 +515,8 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 {
 	u32 __user *syncs;
 	struct drm_v3d_reset_timestamp_query reset;
+	unsigned int i;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -533,14 +541,14 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 
 	syncs = u64_to_user_ptr(reset.syncs);
 
-	for (int i = 0; i < reset.count; i++) {
+	for (i = 0; i < reset.count; i++) {
 		u32 sync;
 
 		job->timestamp_query.queries[i].offset = reset.offset + 8 * i;
 
 		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
-			kvfree(job->timestamp_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
@@ -548,6 +556,10 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 	job->timestamp_query.count = reset.count;
 
 	return 0;
+
+error:
+	v3d_timestamp_query_info_free(&job->timestamp_query, i);
+	return err;
 }
 
 /* Get data for the copy timestamp query results job submission. */
@@ -558,7 +570,8 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 {
 	u32 __user *offsets, *syncs;
 	struct drm_v3d_copy_timestamp_query copy;
-	int i;
+	unsigned int i;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -591,15 +604,15 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 		u32 offset, sync;
 
 		if (copy_from_user(&offset, offsets++, sizeof(offset))) {
-			kvfree(job->timestamp_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		job->timestamp_query.queries[i].offset = offset;
 
 		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
-			kvfree(job->timestamp_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
@@ -613,6 +626,10 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 	job->copy.stride = copy.stride;
 
 	return 0;
+
+error:
+	v3d_timestamp_query_info_free(&job->timestamp_query, i);
+	return err;
 }
 
 static int
-- 
2.44.0


