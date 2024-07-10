Return-Path: <stable+bounces-59015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C39892D309
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6D51C20E0D
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7B192B91;
	Wed, 10 Jul 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GHgQ6UnC"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B921DDC5
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618902; cv=none; b=cbnsGEsCgA+ZWydRJj1ndEWb4ScrAWAiqNaVotfgkW9seShxKe7CyZPLcf3A4CPS4/o+s4hDIWi3Ojfn8kUIDs5NC0Sfx3uD5rSkaOEq/lP3Pn1bh5j6PD7h1GzbWNqG2CBHnjg6n7c9L0b+bd/eTG8gZM4HPkBSHdiWLKZoNNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618902; c=relaxed/simple;
	bh=hPNoqNDZTRPCzrT7yCDedC47/UnY11NEeR5jUG1YvPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJbKXByKY/b1lKno3qyVKqqx2cOcYS+VgO8qzafWA6yJBCAlj4ZZae7cA651J4HIl+igXXax/ufzsmMPQ+xrc9RHNRyejtOn5l5q6TF3WnKdtDsKRxTjGyVhfzxPBfskENhvRaLhBZkQD5VJ+j8I1OPnnr6ph71aIkPrEtrpNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GHgQ6UnC; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ds31SSc3/ZtcRU2X/bF1Le6Pz+GPfNZq8S0mqSayfo0=; b=GHgQ6UnC2IsikJ5FAjkYf6PgNH
	76ZzHFOGWodDzzbpMCJlpTC7zoMlvDEl9A56oLitNVsHcwclZyoewUUTzTewswDjVyHfcTM2FyO7n
	0UigF1KbSB24hTyyX3dml70JKHAVbm3UCtc2zzkvmPUAAdBy3Iz55d23OnbIU/n7luWv7qIteihs7
	D5fTHgAIdvn+TBYeI3l69VP+CFaR5q70kDpLHHfZCXR9OtkvOcaGDYVcFiS1EyAYnZQW2J/Tv7ezm
	YpRwChd5uXiQYeOR7I9Pdf5VleVOgwMAGs76YiZeJOkL3wCtjOdnnkuMPEsjZeVW/OgS3oTrz6hk+
	vWYysTiA==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRXZe-00DH0u-VI; Wed, 10 Jul 2024 15:41:35 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/12] drm/v3d: Fix potential memory leak in the timestamp extension
Date: Wed, 10 Jul 2024 14:41:20 +0100
Message-ID: <20240710134130.17292-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240710134130.17292-1-tursulin@igalia.com>
References: <20240710134130.17292-1-tursulin@igalia.com>
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
 drivers/gpu/drm/v3d/v3d_sched.c  | 22 +++++++++++++------
 drivers/gpu/drm/v3d/v3d_submit.c | 36 ++++++++++++++++++++++----------
 3 files changed, 43 insertions(+), 17 deletions(-)

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
index 263fefc1d04f..2818afdd4807 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -452,6 +452,7 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 {
 	u32 __user *offsets, *syncs;
 	struct drm_v3d_timestamp_query timestamp;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -484,15 +485,15 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
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
@@ -500,6 +501,10 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 	job->timestamp_query.count = timestamp.count;
 
 	return 0;
+
+error:
+	__v3d_timestamp_query_info_free(qinfo, i);
+	return err;
 }
 
 static int
@@ -509,6 +514,7 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 {
 	u32 __user *syncs;
 	struct drm_v3d_reset_timestamp_query reset;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -539,8 +545,8 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 		job->timestamp_query.queries[i].offset = reset.offset + 8 * i;
 
 		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
-			kvfree(job->timestamp_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
@@ -548,6 +554,10 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 	job->timestamp_query.count = reset.count;
 
 	return 0;
+
+error:
+	__v3d_timestamp_query_info_free(qinfo, i);
+	return err;
 }
 
 /* Get data for the copy timestamp query results job submission. */
@@ -558,7 +568,7 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 {
 	u32 __user *offsets, *syncs;
 	struct drm_v3d_copy_timestamp_query copy;
-	int i;
+	int i, err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -591,15 +601,15 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
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
@@ -613,6 +623,10 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
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


