Return-Path: <stable+bounces-139663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CBAA9136
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679553ACE62
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9E01FBEA2;
	Mon,  5 May 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7ACmtrU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C41922FA
	for <stable@vger.kernel.org>; Mon,  5 May 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746441221; cv=none; b=k2PANbHucwQa4T2USh/M77qnH+4KgZPPzulRkUBGKHESAJBC4Y+FLtEoEt+iW8B9v3MeSaojOcKMNbi6w+dLNCNQ+mD9BXmG3Hy1J8IR7+6mVhxK/3zEfZ61bVD0bOXgfkxNINy827gBsFsDnYcU1whzDCWD8XFgZdsR7Jk92vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746441221; c=relaxed/simple;
	bh=DGNlqy7oG9y+49moBo9AIcVFIJtrnDRJjqubVPuxVTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLBFAPAn7wls0pLHF6gp1VA0wpBHT17k75Zq5n0qr4ASAPL2qXCrwbFDWvpbk+b99APhV8hzrmmKpubcKmnKlxWAof+l9uP2vBYpuaSjNwDnF/o6SHflFgelfZi5/doxINAN4YZUD1fkHpi5q5iHqTJOCA2jaE0PNIFPdqSL208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7ACmtrU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746441220; x=1777977220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGNlqy7oG9y+49moBo9AIcVFIJtrnDRJjqubVPuxVTw=;
  b=H7ACmtrU8BmnI4ugMVxM94gRjqVRLvKzUn0UeW0ZPfCR48KdlbhbUne6
   vXTHZ89csK2MkQQZeWyukRj7c7R2kvOWZrqkcDiVl/A4qsw1jS3fXwOn1
   Xykxm194rFzqlDwPaNhqEfL0GgxpFQ39JxaUicpAoik1WbbBJ8MqQpbo2
   gltyn/ibV0ywvfc5swVCJ2hOtXIy14ETC4h+x8TDtnlijMHSOIrg0uYFG
   PlihxLeh2tCmVo8dUim5uc+xOJ34eyJvSb0ipOJ5QbtSyY6HV6p/2tBiZ
   B/iN+LuzCcnF9Nx7s6r9YlVPVW0TRTZpdsUcRThokrrcoXJjYQNaSlg8i
   w==;
X-CSE-ConnectionGUID: 8yoWE8RaR7ahUt8e92AY0Q==
X-CSE-MsgGUID: VCNIQwtXTNaGBzO5bAJExA==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="47301804"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="47301804"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:40 -0700
X-CSE-ConnectionGUID: fY7KBWtYRJGqI9RfMzsmJg==
X-CSE-MsgGUID: yvyWDGpaQDSi5mwmzymkeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135186842"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 03:33:38 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v2 1/7] accel/ivpu: Make DB_ID and JOB_ID allocations incremental
Date: Mon,  5 May 2025 12:33:28 +0200
Message-ID: <20250505103334.79027-2-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250505103334.79027-1-jacek.lawrynowicz@linux.intel.com>
References: <20250505103334.79027-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>

commit c3b0ec0fe0c7ebc4eb42ba60f7340ecdb7aae1a2 upstream.

Save last used ID and use it to limit the possible values
for the ID. This should decrease the rate at which the IDs
are reused, which will make debugging easier.

Cc: stable@vger.kernel.org # v6.12
Signed-off-by: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>
Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240930195322.461209-19-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c |  9 +++++++++
 drivers/accel/ivpu/ivpu_drv.h |  7 +++++++
 drivers/accel/ivpu/ivpu_job.c | 37 +++++++++++++++++++++++++----------
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 88df2cdc46b62..009b1226ee2ec 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -260,6 +260,11 @@ static int ivpu_open(struct drm_device *dev, struct drm_file *file)
 	if (ret)
 		goto err_xa_erase;
 
+	file_priv->default_job_limit.min = FIELD_PREP(IVPU_JOB_ID_CONTEXT_MASK,
+						      (file_priv->ctx.id - 1));
+	file_priv->default_job_limit.max = file_priv->default_job_limit.min | IVPU_JOB_ID_JOB_MASK;
+	file_priv->job_limit = file_priv->default_job_limit;
+
 	mutex_unlock(&vdev->context_list_lock);
 	drm_dev_exit(idx);
 
@@ -607,6 +612,10 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 	lockdep_set_class(&vdev->submitted_jobs_xa.xa_lock, &submitted_jobs_xa_lock_class_key);
 	INIT_LIST_HEAD(&vdev->bo_list);
 
+	vdev->default_db_limit.min = IVPU_MIN_DB;
+	vdev->default_db_limit.max = IVPU_MAX_DB;
+	vdev->db_limit = vdev->default_db_limit;
+
 	ret = drmm_mutex_init(&vdev->drm, &vdev->context_list_lock);
 	if (ret)
 		goto err_xa_destroy;
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 9430a24994c32..92f5df7fdc83d 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -46,6 +46,9 @@
 #define IVPU_MIN_DB 1
 #define IVPU_MAX_DB 255
 
+#define IVPU_JOB_ID_JOB_MASK		GENMASK(7, 0)
+#define IVPU_JOB_ID_CONTEXT_MASK	GENMASK(31, 8)
+
 #define IVPU_NUM_ENGINES       2
 #define IVPU_NUM_PRIORITIES    4
 #define IVPU_NUM_CMDQS_PER_CTX (IVPU_NUM_ENGINES * IVPU_NUM_PRIORITIES)
@@ -136,6 +139,8 @@ struct ivpu_device {
 	struct xa_limit context_xa_limit;
 
 	struct xarray db_xa;
+	struct xa_limit db_limit;
+	struct xa_limit default_db_limit;
 
 	struct mutex bo_list_lock; /* Protects bo_list */
 	struct list_head bo_list;
@@ -171,6 +176,8 @@ struct ivpu_file_priv {
 	struct mutex ms_lock; /* Protects ms_instance_list, ms_info_bo */
 	struct list_head ms_instance_list;
 	struct ivpu_bo *ms_info_bo;
+	struct xa_limit job_limit;
+	struct xa_limit default_job_limit;
 	bool has_mmu_faults;
 	bool bound;
 	bool aborted;
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 91f7f6f3ca675..c0e52126779bc 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -21,8 +21,6 @@
 #include "vpu_boot_api.h"
 
 #define CMD_BUF_IDX	     0
-#define JOB_ID_JOB_MASK	     GENMASK(7, 0)
-#define JOB_ID_CONTEXT_MASK  GENMASK(31, 8)
 #define JOB_MAX_BUFFER_COUNT 65535
 
 static void ivpu_cmdq_ring_db(struct ivpu_device *vdev, struct ivpu_cmdq *cmdq)
@@ -77,9 +75,28 @@ static void ivpu_preemption_buffers_free(struct ivpu_device *vdev,
 	ivpu_bo_free(cmdq->secondary_preempt_buf);
 }
 
+static int ivpu_id_alloc(struct xarray *xa, u32 *id, void *entry, struct xa_limit *limit,
+			 const struct xa_limit default_limit)
+{
+	int ret;
+
+	ret = __xa_alloc(xa, id, entry, *limit, GFP_KERNEL);
+	if (ret) {
+		limit->min = default_limit.min;
+		ret = __xa_alloc(xa, id, entry, *limit, GFP_KERNEL);
+		if (ret)
+			return ret;
+	}
+
+	limit->min = *id + 1;
+	if (limit->min > limit->max)
+		limit->min = default_limit.min;
+
+	return ret;
+}
+
 static struct ivpu_cmdq *ivpu_cmdq_alloc(struct ivpu_file_priv *file_priv)
 {
-	struct xa_limit db_xa_limit = {.max = IVPU_MAX_DB, .min = IVPU_MIN_DB};
 	struct ivpu_device *vdev = file_priv->vdev;
 	struct ivpu_cmdq *cmdq;
 	int ret;
@@ -88,7 +105,10 @@ static struct ivpu_cmdq *ivpu_cmdq_alloc(struct ivpu_file_priv *file_priv)
 	if (!cmdq)
 		return NULL;
 
-	ret = xa_alloc(&vdev->db_xa, &cmdq->db_id, NULL, db_xa_limit, GFP_KERNEL);
+	xa_lock(&vdev->db_xa); /* lock here to protect db_limit */
+	ret = ivpu_id_alloc(&vdev->db_xa, &cmdq->db_id, NULL, &vdev->db_limit,
+			    vdev->default_db_limit);
+	xa_unlock(&vdev->db_xa);
 	if (ret) {
 		ivpu_err(vdev, "Failed to allocate doorbell id: %d\n", ret);
 		goto err_free_cmdq;
@@ -519,7 +539,6 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 {
 	struct ivpu_file_priv *file_priv = job->file_priv;
 	struct ivpu_device *vdev = job->vdev;
-	struct xa_limit job_id_range;
 	struct ivpu_cmdq *cmdq;
 	bool is_first_job;
 	int ret;
@@ -530,7 +549,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 
 	mutex_lock(&file_priv->lock);
 
-	cmdq = ivpu_cmdq_acquire(job->file_priv, job->engine_idx, priority);
+	cmdq = ivpu_cmdq_acquire(file_priv, job->engine_idx, priority);
 	if (!cmdq) {
 		ivpu_warn_ratelimited(vdev, "Failed to get job queue, ctx %d engine %d prio %d\n",
 				      file_priv->ctx.id, job->engine_idx, priority);
@@ -538,12 +557,10 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 		goto err_unlock_file_priv;
 	}
 
-	job_id_range.min = FIELD_PREP(JOB_ID_CONTEXT_MASK, (file_priv->ctx.id - 1));
-	job_id_range.max = job_id_range.min | JOB_ID_JOB_MASK;
-
 	xa_lock(&vdev->submitted_jobs_xa);
 	is_first_job = xa_empty(&vdev->submitted_jobs_xa);
-	ret = __xa_alloc(&vdev->submitted_jobs_xa, &job->job_id, job, job_id_range, GFP_KERNEL);
+	ret = ivpu_id_alloc(&vdev->submitted_jobs_xa, &job->job_id, job, &file_priv->job_limit,
+			    file_priv->default_job_limit);
 	if (ret) {
 		ivpu_dbg(vdev, JOB, "Too many active jobs in ctx %d\n",
 			 file_priv->ctx.id);
-- 
2.45.1


