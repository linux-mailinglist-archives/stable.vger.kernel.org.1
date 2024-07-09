Return-Path: <stable+bounces-58916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D4892C1FC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F79B2F002
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87391B29C6;
	Tue,  9 Jul 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jTnfPpR+"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9BD1A00C2
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542887; cv=none; b=X5PTxYPfN7/+QKVzvgFpgG4oS61HPHZBQNG9/zOpV8eW4tKsC14274wqFzkIpLoOCIykLamAQ54vUv9EtVl8I31dWsL+YyHXNTrbkEBnZJg64CxBS1N348yqWNBDoitBqoESWuBajtETnfkbxClXACw56izImzckeC+L741wU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542887; c=relaxed/simple;
	bh=Di6VdBrB2YKbGY3dt9XzJS5jwPunbGIFXUKg+uFyHag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGyhAOvBk9fvw/yryHVEXs8regTzoA69A4/e6YJ0JxcinZAS/pwYpXbOPRhBnu92+Rx+Weth2fnAsyYbJah+e7Ui2yXc47HpOdpeq8RC9kdeo8Guk+kBVQokLP04EvJQF9IadSB/oS11eNkxvQ3wpAjLxSawFx41iotjkRjiKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jTnfPpR+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=L1YGG/6nLKQNVCT4mNcLHZccHgt/bEXBUIOKvL2HJvM=; b=jTnfPpR+mDtkl3Slq17DIdAyd8
	eCy+JfZpbOUxI4Cozs/4Fhp6Uesb68wA+r5E+NfBpD9gSzpUtl2bP74/ZgpeM7rRKcj+BFr+fRuuO
	Npy+SuscXz0woNC841NnXP8m0p9qa14wblydrerqwJ0mxfYAeAdBcJHjJjfe/FgM1tSVxkpKgajIm
	ojSe1Lsu38NxaYoj/UuH2Xyp4QkVb525o4kQEqx142g+Z/Qksr8lTUIH9nY5L063BxmiN3odc/V41
	F8I+8Pbc/f00cc55rWzIhkZBBtKmGM16i6Xg5yWS59fyWISXZq6rKzYRtR2flAdEoCRM3WqPMc3Nl
	13z+6SHA==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRDnX-00CsoQ-A2; Tue, 09 Jul 2024 18:34:35 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 06/12] drm/v3d: Fix potential memory leak in the performance extension
Date: Tue,  9 Jul 2024 17:34:19 +0100
Message-ID: <20240709163425.58276-7-tursulin@igalia.com>
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
Fixes: bae7cb5d6800 ("drm/v3d: Create a CPU job extension for the reset performance query job"
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  2 ++
 drivers/gpu/drm/v3d/v3d_sched.c  | 22 ++++++++++++-----
 drivers/gpu/drm/v3d/v3d_submit.c | 42 ++++++++++++++++++++------------
 3 files changed, 44 insertions(+), 22 deletions(-)

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
index 0f1c900c7d35..81afcfccc6bb 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -645,6 +645,7 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	struct drm_v3d_reset_performance_query reset;
 	struct v3d_performance_query_info *qinfo = &job->performance_query;
 	unsigned int i, j;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -680,32 +681,36 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 		u32 id;
 
 		if (get_user(sync, syncs++)) {
-			kvfree(qinfo->queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
-		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
-
 		if (get_user(ids, kperfmon_ids++)) {
-			kvfree(qinfo->queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		ids_pointer = u64_to_user_ptr(ids);
 
 		for (j = 0; j < reset.nperfmons; j++) {
 			if (get_user(id, ids_pointer++)) {
-				kvfree(qinfo->queries);
-				return -EFAULT;
+				err = -EFAULT;
+				goto error;
 			}
 
 			qinfo->queries[i].kperfmon_ids[j] = id;
 		}
+
+		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
 	}
 	qinfo->count = reset.count;
 	qinfo->nperfmons = reset.nperfmons;
 
 	return 0;
+
+error:
+	__v3d_performance_query_info_free(qinfo, i);
+	return err;
 }
 
 static int
@@ -718,6 +723,7 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	struct drm_v3d_copy_performance_query copy;
 	struct v3d_performance_query_info *qinfo = &job->performance_query;
 	unsigned int i, j;
+	int err;
 
 	if (!job) {
 		DRM_DEBUG("CPU job extension was attached to a GPU job.\n");
@@ -756,27 +762,27 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 		u32 id;
 
 		if (get_user(sync, syncs++)) {
-			kvfree(qinfo->queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
-		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
-
 		if (get_user(ids, kperfmon_ids++)) {
-			kvfree(qinfo->queries);
-			return -EFAULT;
+			err = -EFAULT;
+			goto error;
 		}
 
 		ids_pointer = u64_to_user_ptr(ids);
 
 		for (j = 0; j < copy.nperfmons; j++) {
 			if (get_user(id, ids_pointer++)) {
-				kvfree(qinfo->queries);
-				return -EFAULT;
+				err = -EFAULT;
+				goto error;
 			}
 
 			qinfo->queries[i].kperfmon_ids[j] = id;
 		}
+
+		qinfo->queries[i].syncobj = drm_syncobj_find(file_priv, sync);
 	}
 	qinfo->count = copy.count;
 	qinfo->nperfmons = copy.nperfmons;
@@ -789,6 +795,10 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
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


