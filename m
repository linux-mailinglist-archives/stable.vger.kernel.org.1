Return-Path: <stable+bounces-59129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F392E9F3
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E31A1C211A3
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A24F1607AB;
	Thu, 11 Jul 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f5bBuSqf"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2EC15F40A
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706032; cv=none; b=vE47Ih5kEsOyB2rZRV55NyHeK2rL2JZFvUd7OXCKhfTNqLr9rYit5b/qCD4iC4WWse8TDVKJOMFRvufRBIQEMvqfuniw7Eu6h55Nxk0m+vmucsEXwlWAyt6vXUK9C7H7mmX8K3FrxDpYfxikedevOsU0x0dGS2CfqT+X3UlAYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706032; c=relaxed/simple;
	bh=aMgqdmt5a6IcpEsHEFTwhDu3Voll4O+kONDx0RrtLPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDSHnL/nXjeCELKcOMDgIm/+B3gQJdl9erdovkqDmpTp/xmWAmpt0scIhhSBu0b2obhQBricS51MyTw4RMS3tGuif4Y560/6qz+DWzguQGofxxqWx1Uhzqj0G8V7K2JcHb2sQ3QCw5flQJSmbmkipgTqSo/GQA2HAmYOfwBUspw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f5bBuSqf; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kuBi+K7wdxXlQtoFE4gQUicvwYbP8yhjGbUI9A5X6FY=; b=f5bBuSqfVOAwJ4gwq4e4a989Kf
	bbZQTd1sa047Tv9syg1vc8B71KJTBCvxymYf+haYdmyyBIV2rMCy12Hq/cHJGt6ecKoJs8nROVGnj
	kcLrMaRFwbix7TRtpc67Ve3YMEZ7XHPZXYgyOe8ctWgESFlNBp9yuBhlrkffwi6Qv4VulSnEE/D1r
	mzRJ1GzGf5T3zBEIPZT0cM2uAojGvFqHYro7oe46Yp6wxJw+PADLLiQ8YHdYAbuYrpp6qz0T3a8ii
	HSHuc+DTmqMUpIw/pOoUgP1Ss4Ke8kiHrSxUYqqsYdGGt4pwl5Gt4wyucAoSH8J00ATTTkx8UsfQD
	mCpmfEcQ==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRuEy-00Diez-Cb; Thu, 11 Jul 2024 15:53:44 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 03/11] drm/v3d: Fix potential memory leak in the performance extension
Date: Thu, 11 Jul 2024 14:53:32 +0100
Message-ID: <20240711135340.84617-4-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711135340.84617-1-tursulin@igalia.com>
References: <20240711135340.84617-1-tursulin@igalia.com>
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
Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job")
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  2 ++
 drivers/gpu/drm/v3d/v3d_sched.c  | 22 ++++++++++----
 drivers/gpu/drm/v3d/v3d_submit.c | 52 ++++++++++++++++++++------------
 3 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index e208ffdfba32..dd3ead4cb8bd 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -565,6 +565,8 @@ void v3d_mmu_remove_ptes(struct v3d_bo *bo);
 /* v3d_sched.c */
 void v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
 				   unsigned int count);
+void v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
+				     unsigned int count);
 void v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue);
 int v3d_sched_init(struct v3d_dev *v3d);
 void v3d_sched_fini(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 59dc0287dab9..5fbbee47c6b7 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -87,20 +87,30 @@ v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_info,
 	}
 }
 
+void
+v3d_performance_query_info_free(struct v3d_performance_query_info *query_info,
+				unsigned int count)
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
-	struct v3d_performance_query_info *performance_query = &job->performance_query;
 
 	v3d_timestamp_query_info_free(&job->timestamp_query,
 				      job->timestamp_query.count);
 
-	if (performance_query->queries) {
-		for (int i = 0; i < performance_query->count; i++)
-			drm_syncobj_put(performance_query->queries[i].syncobj);
-		kvfree(performance_query->queries);
-	}
+	v3d_performance_query_info_free(&job->performance_query,
+					job->performance_query.count);
 
 	v3d_job_cleanup(&job->base);
 }
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 121bf1314b80..50be4e8a7512 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -640,6 +640,8 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	u32 __user *syncs;
 	u64 __user *kperfmon_ids;
 	struct drm_v3d_reset_performance_query reset;
+	unsigned int i, j;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -668,39 +670,43 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	syncs = u64_to_user_ptr(reset.syncs);
 	kperfmon_ids = u64_to_user_ptr(reset.kperfmon_ids);
 
-	for (int i = 0; i < reset.count; i++) {
+	for (i = 0; i < reset.count; i++) {
 		u32 sync;
 		u64 ids;
 		u32 __user *ids_pointer;
 		u32 id;
 
 		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
-			kvfree(job->performance_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
-		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
-
 		if (copy_from_user(&ids, kperfmon_ids++, sizeof(ids))) {
-			kvfree(job->performance_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		ids_pointer = u64_to_user_ptr(ids);
 
-		for (int j = 0; j < reset.nperfmons; j++) {
+		for (j = 0; j < reset.nperfmons; j++) {
 			if (copy_from_user(&id, ids_pointer++, sizeof(id))) {
-				kvfree(job->performance_query.queries);
-				return -EFAULT;
+				err = -EFAULT;
+				goto error;
 			}
 
 			job->performance_query.queries[i].kperfmon_ids[j] = id;
 		}
+
+		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
 	}
 	job->performance_query.count = reset.count;
 	job->performance_query.nperfmons = reset.nperfmons;
 
 	return 0;
+
+error:
+	v3d_performance_query_info_free(&job->performance_query, i);
+	return err;
 }
 
 static int
@@ -711,6 +717,8 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	u32 __user *syncs;
 	u64 __user *kperfmon_ids;
 	struct drm_v3d_copy_performance_query copy;
+	unsigned int i, j;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -742,34 +750,34 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	syncs = u64_to_user_ptr(copy.syncs);
 	kperfmon_ids = u64_to_user_ptr(copy.kperfmon_ids);
 
-	for (int i = 0; i < copy.count; i++) {
+	for (i = 0; i < copy.count; i++) {
 		u32 sync;
 		u64 ids;
 		u32 __user *ids_pointer;
 		u32 id;
 
 		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
-			kvfree(job->performance_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
-		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
-
 		if (copy_from_user(&ids, kperfmon_ids++, sizeof(ids))) {
-			kvfree(job->performance_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		ids_pointer = u64_to_user_ptr(ids);
 
-		for (int j = 0; j < copy.nperfmons; j++) {
+		for (j = 0; j < copy.nperfmons; j++) {
 			if (copy_from_user(&id, ids_pointer++, sizeof(id))) {
-				kvfree(job->performance_query.queries);
-				return -EFAULT;
+				err = -EFAULT;
+				goto error;
 			}
 
 			job->performance_query.queries[i].kperfmon_ids[j] = id;
 		}
+
+		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
 	}
 	job->performance_query.count = copy.count;
 	job->performance_query.nperfmons = copy.nperfmons;
@@ -782,6 +790,10 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	job->copy.stride = copy.stride;
 
 	return 0;
+
+error:
+	v3d_performance_query_info_free(&job->performance_query, i);
+	return err;
 }
 
 /* Whenever userspace sets ioctl extensions, v3d_get_extensions parses data
-- 
2.44.0


