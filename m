Return-Path: <stable+bounces-59017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0092D312
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429461C208FA
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6F192B88;
	Wed, 10 Jul 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LEveVS/N"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F73190673
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618903; cv=none; b=Qj1yK5/xxaTsUkqnhg2u9FY3OXZmJDtaHtvKuT6Oip28oVxnbL83GwPemSCZ10bZbefoHzW6gGEDPsIAcLxFv7xiYSA2YQsn2cOEKf8c8Fov9giHduEZv0YPBBpIoFQHVVoWOTGgVRhM4JQPN2ERGW3dqU/Z/DBXlZzoY+04Bzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618903; c=relaxed/simple;
	bh=CvOCE/Ppm8M3Nlfnmt6E2jb1x5T0G/RE9E2NAqWMqBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnLS4u9mptB++dDqaNQRcU2Pe9pc9Pw1sm/cl/0z8xpepSbf0Y3LvlETCgONJQ0pvyqS3cG1g8CtfYkLoZxx1tIW+6KVxk+uO4hkxboTfIMo6xNtplXya/M6idkDMMMr5+AZFMrcpgdOTWycQVObbKszG1o0J8PT8mtXIYrZwro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LEveVS/N; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UfhSHEE18XgM/bt5JIjBxX8yVEeqmq5+iCZJ5IdJMw8=; b=LEveVS/N7KCBguYt+kNW5I7acW
	zlkeczTdBLHisuo2cNRJKcjoxiRH93bVd8+T03cSXq/piTHmGT5uYpGrFTsB6Ld07V6yBa/nYb5l3
	mZDgeOSLzNmCsw2UMN11d5Yq2Z3GqFPJDtBqz77Z4FZjVObsyFiCsQXGmWpGWLcpdSIPkYbEMwodE
	zdR0ZNWBOPtXdsq7zHeRy4TI42yWGGEqlYIUILNxKOpktSZBXGqjsOSfaiCCU+sFeEYVdBSb4p2Dd
	4t8YiChMfp87duEb/rWNE4/9G7WEPm4fesJ0qzibip2/3umDFYiUQflsYz7koOkJUkdzyRUDTbxzP
	GfleeoFQ==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRXZf-00DH0y-KW; Wed, 10 Jul 2024 15:41:35 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 03/12] drm/v3d: Fix potential memory leak in the performance extension
Date: Wed, 10 Jul 2024 14:41:21 +0100
Message-ID: <20240710134130.17292-4-tursulin@igalia.com>
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
Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job"
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  2 ++
 drivers/gpu/drm/v3d/v3d_sched.c  | 22 +++++++++++++-----
 drivers/gpu/drm/v3d/v3d_submit.c | 40 +++++++++++++++++++++-----------
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 95651c3c926f..38c80168da51 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -565,6 +565,8 @@ void v3d_mmu_remove_ptes(struct v3d_bo *bo);
 /* v3d_sched.c */
 void __v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *qinfo,
 				     unsigned int count);
+void __v3d_performance_query_info_free(struct v3d_performance_query_info *qinfo,
+				       unsigned int count);
 void v3d_job_update_stats(struct v3d_job *job, enum v3d_queue queue);
 int v3d_sched_init(struct v3d_dev *v3d);
 void v3d_sched_fini(struct v3d_dev *v3d);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index e45d3ddc6f82..173801aa54ee 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -87,20 +87,30 @@ __v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *qinfo,
 	}
 }
 
+void
+__v3d_performance_query_info_free(struct v3d_performance_query_info *qinfo,
+				  unsigned int count)
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
-	struct v3d_performance_query_info *performance_query = &job->performance_query;
 
 	__v3d_timestamp_query_info_free(&job->timestamp_query,
 					job->timestamp_query.count);
 
-	if (performance_query->queries) {
-		for (int i = 0; i < performance_query->count; i++)
-			drm_syncobj_put(performance_query->queries[i].syncobj);
-		kvfree(performance_query->queries);
-	}
+	__v3d_performance_query_info_free(&job->performance_query,
+					  job->performance_query.count);
 
 	v3d_job_cleanup(&job->base);
 }
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 2818afdd4807..ca1b1ad0a75c 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -637,6 +637,7 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	u32 __user *syncs;
 	u64 __user *kperfmon_ids;
 	struct drm_v3d_reset_performance_query reset;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -672,32 +673,36 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
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
 
 		for (int j = 0; j < reset.nperfmons; j++) {
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
+	__v3d_performance_query_info_free(qinfo, i);
+	return err;
 }
 
 static int
@@ -708,6 +713,7 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	u32 __user *syncs;
 	u64 __user *kperfmon_ids;
 	struct drm_v3d_copy_performance_query copy;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -746,27 +752,29 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 		u32 id;
 
 		if (copy_from_user(&sync, syncs++, sizeof(sync))) {
-			kvfree(job->performance_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		job->performance_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
 
 		if (copy_from_user(&ids, kperfmon_ids++, sizeof(ids))) {
-			kvfree(job->performance_query.queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		ids_pointer = u64_to_user_ptr(ids);
 
 		for (int j = 0; j < copy.nperfmons; j++) {
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
@@ -779,6 +787,10 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	job->copy.stride = copy.stride;
 
 	return 0;
+
+error:
+	__v3d_performance_query_info_free(qinfo, i);
+	return err;
 }
 
 /* Whenever userspace sets ioctl extensions, v3d_get_extensions parses data
-- 
2.44.0


