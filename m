Return-Path: <stable+bounces-58914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5297592C19E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756AA1C226E2
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7761B29B1;
	Tue,  9 Jul 2024 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QJObrmnV"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA101B29B0
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542886; cv=none; b=aKmxSvh9kcZbmfvnZqSjUCqSCWeonvn3zMyknop0VzlprNFxLvDjrY5CvSQ0gvDJKPX68nQbGO4wQDZlKLKyxrax3JYhAO35ODZ6fhc3I9T9XSFGpwBDD3nNKQPK6Z/0yAtLL02v9WSICeB/ppKoZ79bZMXEnoxap54oSPiqyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542886; c=relaxed/simple;
	bh=NJCXG1IS7mQLNIBwoae4CWbTyzvAexck8i5I17bXsZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyujdtrT4y57SDMArfrbLVvY8mDnbQZJ4v48I20qvQXd8Kj1hmiYjqAFPwm3nOxTCTjd6CDhJji5ijiZOJnvzv315H++8GZz6ywihRp8Ck+1LW7kEaFMYFzxfOLVDpxz0DzlvmmnWWhUmRPaxzQVnJ8VEdmAiAxQ6goUSWwsaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QJObrmnV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=83M8A3iugGdLdsh/4jkJjGQJeaIdByksfx/Wh7FQ2xE=; b=QJObrmnV+9HJoDJLWBsRMyMdYz
	Z/pUmYP1aqwxE15H389vODx3GId93+bbWmY9q+9bjtdETOUiSpL5fRC6gdN8srFcJkcXy36/b8K96
	1xbwP8bkghZwlDGTzAXg0yUgEvlgTgu4N6I8llxbpHWmnD9Cfr6R9MhLMslT86gb9fEh0WjBpzdEh
	8XO69bI3IurhYNgU2TJYb988TSrRxFWtzNpCFa0goXF2bLiwk3HYlQSF/+iDhSaREQIQl5gwbVKX8
	eTk7PrB8sGlx32CVx7Bdi4HJ7KECMfh6wWgEV2AlsW1VF+iNZpt6dts8qp7mWiYgCMcoEeFgoxiEw
	LlMhJezg==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRDnW-00CsoJ-L1; Tue, 09 Jul 2024 18:34:34 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 05/12] drm/v3d: Fix potential memory leak in the timestamp extension
Date: Tue,  9 Jul 2024 17:34:18 +0100
Message-ID: <20240709163425.58276-6-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240709163425.58276-1-tursulin@igalia.com>
References: <20240709163425.58276-1-tursulin@igalia.com>
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
 drivers/gpu/drm/v3d/v3d_sched.c  | 22 ++++++++++++++------
 drivers/gpu/drm/v3d/v3d_submit.c | 35 +++++++++++++++++++++++---------
 3 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 099b962bdfde..95651c3c926f 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -563,6 +563,8 @@ void v3d_mmu_insert_ptes(struct v3d_bo *bo);
 void v3d_mmu_remove_ptes(struct v3d_bo *bo);
 
 /* v3d_sched.c */
+void __v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *qinfo,
+				     unsigned int count);
 void v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue);
 int v3d_sched_init(struct v3d_dev *v3d);
 void v3d_sched_fini(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 03df37a3acf5..e45d3ddc6f82 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -73,18 +73,28 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
 	v3d_job_cleanup(job);
 }
 
+void
+__v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *qinfo,
+				unsigned int count)
+{
+	if (qinfo->queries) {
+		unsigned int i;
+
+		for (i = 0; i < count; i++)
+			drm_syncobj_put(qinfo->queries[i].syncobj);
+
+		kvfree(qinfo->queries);
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
+	__v3d_timestamp_query_info_free(&job->timestamp_query,
+					job->timestamp_query.count);
 
 	if (performance_query->queries) {
 		for (int i = 0; i < performance_query->count; i++)
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index c960bc6ca32d..0f1c900c7d35 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -454,6 +454,7 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 	struct drm_v3d_timestamp_query timestamp;
 	struct v3d_timestamp_query_info *qinfo = &job->timestamp_query;
 	unsigned int i;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -486,15 +487,15 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 		u32 offset, sync;
 
 		if (get_user(offset, offsets++)) {
-			kvfree(qinfo->queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		qinfo->queries[i].offset = offset;
 
 		if (get_user(sync, syncs++)) {
-			kvfree(qinfo->queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
@@ -502,6 +503,10 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 	qinfo->count = timestamp.count;
 
 	return 0;
+
+error:
+	__v3d_timestamp_query_info_free(qinfo, i);
+	return err;
 }
 
 static int
@@ -513,6 +518,7 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 	struct drm_v3d_reset_timestamp_query reset;
 	struct v3d_timestamp_query_info *qinfo = &job->timestamp_query;
 	unsigned int i;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -543,8 +549,8 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 		qinfo->queries[i].offset = reset.offset + 8 * i;
 
 		if (get_user(sync, syncs++)) {
-			kvfree(qinfo->queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
@@ -552,6 +558,10 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 	qinfo->count = reset.count;
 
 	return 0;
+
+error:
+	__v3d_timestamp_query_info_free(qinfo, i);
+	return err;
 }
 
 /* Get data for the copy timestamp query results job submission. */
@@ -564,6 +574,7 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 	struct drm_v3d_copy_timestamp_query copy;
 	struct v3d_timestamp_query_info *qinfo = &job->timestamp_query;
 	unsigned int i;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -596,15 +607,15 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 		u32 offset, sync;
 
 		if (get_user(offset, offsets++)) {
-			kvfree(qinfo->queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		qinfo->queries[i].offset = offset;
 
 		if (get_user(sync, syncs++)) {
-			kvfree(qinfo->queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
@@ -618,6 +629,10 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 	job->copy.stride = copy.stride;
 
 	return 0;
+
+error:
+	__v3d_timestamp_query_info_free(qinfo, i);
+	return err;
 }
 
 static int
-- 
2.44.0


