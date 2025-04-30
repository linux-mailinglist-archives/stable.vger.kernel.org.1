Return-Path: <stable+bounces-139156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8680AAA4BDE
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0D54E4F42
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5085225B1FA;
	Wed, 30 Apr 2025 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laBvfUkE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4123815D
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017308; cv=none; b=AvIxMeZWi3Uufen9lWXxLm7sdfGjyx2zccHMvXIh/buTau7wbbp0pRczDMEXjiImBk2ALiTZCGFPMEN0MG/ux/DXE6j/rgdI1RCgkATHPofBbIcxzLOK31amPpyfaIdMhWOlmnm9C3JmeRPOjlbN0dO5cehY+JsZsc5PX+X7Ue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017308; c=relaxed/simple;
	bh=92KQS/HcxQLLUPCsdf5xCJqRFdfjW80pXuO5pOE8F1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9AwHt3YiJb7wn05DTwOpNQBxkQNCjd6Y0WzcQG768Wz0SBftqPnqPqSROLrxk5j8pVqI279ZLhT3OvAyxV4u8ld14HAyDiFf1Skr3kjm93QRI+DQHA2vf67cx8XRB7ExLCN7Xp3Mrnizu0CvRP24fLi33MseDPqDkRauxuSEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laBvfUkE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017307; x=1777553307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=92KQS/HcxQLLUPCsdf5xCJqRFdfjW80pXuO5pOE8F1c=;
  b=laBvfUkENfR4cq57dy83Nv+JAJkyii3IyK02wr3QEyLvo2DWKj0o3H2H
   1w/Gv9FJulzqYJE3PUqo6p+6Z+4F5oZ+Zkew02k7zHDZVTMae42gd6Iqx
   kIW+ZH+jiECdnVKZUyYWgIUIgMVQU/8cXcSUiD5ZZ8GjeuB0GH2U9+a29
   RtCxlR74DOOHU563pFT5FhflVantKCuIn3i5ZDqXJi/gM084orVS3K98Z
   9RElaY6FEkNIqVsn9KgTJ8xy75AGJHAOEslyRmgO9T4a210Gr4sG1dOPc
   2BTVokEA9OHsz4+WMyaVZMhi0fNfiL3UZXyWtLNLuFLXPrQq7vGfHYohA
   g==;
X-CSE-ConnectionGUID: qewUvNVgRhaKwy47fLCeoA==
X-CSE-MsgGUID: 0OAvx2vTSYaZ0Aq3Er1MQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51488503"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51488503"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:26 -0700
X-CSE-ConnectionGUID: ZmJp/fH+QvuJy1tBX0dmUg==
X-CSE-MsgGUID: oKNoEhG2Q2mFasw70TBuwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138925408"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:25 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 2/7] accel/ivpu: Use xa_alloc_cyclic() instead of custom function
Date: Wed, 30 Apr 2025 14:48:14 +0200
Message-ID: <20250430124819.3761263-3-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
References: <20250430124819.3761263-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Wachowski <karol.wachowski@intel.com>

commit ae7af7d8dc2a13a427aa90d003fe4fb2c168342a upstream.

Remove custom ivpu_id_alloc() wrapper used for ID allocations
and replace it with standard xa_alloc_cyclic() API.

The idea behind ivpu_id_alloc() was to have monotonic IDs, so the driver
is easier to debug because same IDs are not reused all over. The same
can be achieved just by using appropriate Linux API.

Cc: <stable@vger.kernel.org> # v6.12
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241017145817.121590-7-jacek.lawrynowicz@linux.intel.com
---
 drivers/accel/ivpu/ivpu_drv.c | 11 ++++-------
 drivers/accel/ivpu/ivpu_drv.h |  4 ++--
 drivers/accel/ivpu/ivpu_job.c | 34 ++++++----------------------------
 3 files changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index b43621e069a11..17b3d38abd68d 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -260,10 +260,8 @@ static int ivpu_open(struct drm_device *dev, struct drm_file *file)
 	if (ret)
 		goto err_xa_erase;
 
-	file_priv->default_job_limit.min = FIELD_PREP(IVPU_JOB_ID_CONTEXT_MASK,
-						      (file_priv->ctx.id - 1));
-	file_priv->default_job_limit.max = file_priv->default_job_limit.min | IVPU_JOB_ID_JOB_MASK;
-	file_priv->job_limit = file_priv->default_job_limit;
+	file_priv->job_limit.min = FIELD_PREP(IVPU_JOB_ID_CONTEXT_MASK, (file_priv->ctx.id - 1));
+	file_priv->job_limit.max = file_priv->job_limit.min | IVPU_JOB_ID_JOB_MASK;
 
 	mutex_unlock(&vdev->context_list_lock);
 	drm_dev_exit(idx);
@@ -612,9 +610,8 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 	lockdep_set_class(&vdev->submitted_jobs_xa.xa_lock, &submitted_jobs_xa_lock_class_key);
 	INIT_LIST_HEAD(&vdev->bo_list);
 
-	vdev->default_db_limit.min = IVPU_MIN_DB;
-	vdev->default_db_limit.max = IVPU_MAX_DB;
-	vdev->db_limit = vdev->default_db_limit;
+	vdev->db_limit.min = IVPU_MIN_DB;
+	vdev->db_limit.max = IVPU_MAX_DB;
 
 	ret = drmm_mutex_init(&vdev->drm, &vdev->context_list_lock);
 	if (ret)
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 92f5df7fdc83d..56509c5a3875b 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -140,7 +140,7 @@ struct ivpu_device {
 
 	struct xarray db_xa;
 	struct xa_limit db_limit;
-	struct xa_limit default_db_limit;
+	u32 db_next;
 
 	struct mutex bo_list_lock; /* Protects bo_list */
 	struct list_head bo_list;
@@ -177,7 +177,7 @@ struct ivpu_file_priv {
 	struct list_head ms_instance_list;
 	struct ivpu_bo *ms_info_bo;
 	struct xa_limit job_limit;
-	struct xa_limit default_job_limit;
+	u32 job_id_next;
 	bool has_mmu_faults;
 	bool bound;
 	bool aborted;
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index c0e52126779bc..9767cde4ccd4b 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -75,26 +75,6 @@ static void ivpu_preemption_buffers_free(struct ivpu_device *vdev,
 	ivpu_bo_free(cmdq->secondary_preempt_buf);
 }
 
-static int ivpu_id_alloc(struct xarray *xa, u32 *id, void *entry, struct xa_limit *limit,
-			 const struct xa_limit default_limit)
-{
-	int ret;
-
-	ret = __xa_alloc(xa, id, entry, *limit, GFP_KERNEL);
-	if (ret) {
-		limit->min = default_limit.min;
-		ret = __xa_alloc(xa, id, entry, *limit, GFP_KERNEL);
-		if (ret)
-			return ret;
-	}
-
-	limit->min = *id + 1;
-	if (limit->min > limit->max)
-		limit->min = default_limit.min;
-
-	return ret;
-}
-
 static struct ivpu_cmdq *ivpu_cmdq_alloc(struct ivpu_file_priv *file_priv)
 {
 	struct ivpu_device *vdev = file_priv->vdev;
@@ -105,11 +85,9 @@ static struct ivpu_cmdq *ivpu_cmdq_alloc(struct ivpu_file_priv *file_priv)
 	if (!cmdq)
 		return NULL;
 
-	xa_lock(&vdev->db_xa); /* lock here to protect db_limit */
-	ret = ivpu_id_alloc(&vdev->db_xa, &cmdq->db_id, NULL, &vdev->db_limit,
-			    vdev->default_db_limit);
-	xa_unlock(&vdev->db_xa);
-	if (ret) {
+	ret = xa_alloc_cyclic(&vdev->db_xa, &cmdq->db_id, NULL, vdev->db_limit, &vdev->db_next,
+			      GFP_KERNEL);
+	if (ret < 0) {
 		ivpu_err(vdev, "Failed to allocate doorbell id: %d\n", ret);
 		goto err_free_cmdq;
 	}
@@ -559,9 +537,9 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 
 	xa_lock(&vdev->submitted_jobs_xa);
 	is_first_job = xa_empty(&vdev->submitted_jobs_xa);
-	ret = ivpu_id_alloc(&vdev->submitted_jobs_xa, &job->job_id, job, &file_priv->job_limit,
-			    file_priv->default_job_limit);
-	if (ret) {
+	ret = __xa_alloc_cyclic(&vdev->submitted_jobs_xa, &job->job_id, job, file_priv->job_limit,
+				&file_priv->job_id_next, GFP_KERNEL);
+	if (ret < 0) {
 		ivpu_dbg(vdev, JOB, "Too many active jobs in ctx %d\n",
 			 file_priv->ctx.id);
 		ret = -EBUSY;
-- 
2.45.1


