Return-Path: <stable+bounces-139155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE1AA4BDD
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 14:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A43A50036A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF9258CE6;
	Wed, 30 Apr 2025 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiO/6buS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FE25B1FE
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017307; cv=none; b=KVGSAJJoemFqgGqmqHFRDX3EJvrwh+e5DIoLrV3svGP7S94/thpg5U9ediAswGpMNSwsK3VERD6C/PGGTweL7SGBrwHhf/1YLGIUYwcP+FI722/czYmM1kBh5TSuz/reTIOHiJYwqriodAb4jIfobNkM9jrqcJg3uve//3jedYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017307; c=relaxed/simple;
	bh=QW/PqHT/Xb3HUFQFkdnIQteiZQ58ukOvTQo3+gn9b0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVKp57pyxe3/NZr8l6VNlOHVUa9X/odX51XB1aYGzfNxeopVPRqfr2leSwc7n71TKYNCtTKX7kHmiHOR6kLtYgvmaUgiUmyepbRFvskytd4QgYhRPcSZ5+0tMq6GWFscC91t/qioNT01uM/BbMBYTphFtLr36iq4TSMNH9o3H7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiO/6buS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017306; x=1777553306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QW/PqHT/Xb3HUFQFkdnIQteiZQ58ukOvTQo3+gn9b0g=;
  b=WiO/6buSJ78KiELuRizsTp359YtMOsL+mk/okvFJVy7Zf1OxgwuFHjFz
   Kn1uE4bCLggTKkva6AlzuI0QAnYxisfvU5503u2LNdcM0osy45P6t6t1G
   GY/zne1kqX+Tc9lKOUHY5v6XQBsFLywa/l0nxsJfCoxY2Etlcvm8l8mpj
   mDNogkhmZ6PxHbpdwi4WQH/9cgx/8/jEwIrKJDxuOIg6r1OHL/XMu13xj
   HVgEghzHtKfF31Cw7JqZu1FXerFrrqP6NoG+XvjyhBXzmhiHIw/61D51D
   syBMfYFwah/Wx+BKFnEjKCyIm45RvQRrxBhKTjV2I1WoQhihyU5Smzovw
   w==;
X-CSE-ConnectionGUID: YVHJImtgTqyOl3FY2agPug==
X-CSE-MsgGUID: ryxiqYixRtOkeq1ffwTOKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51488495"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51488495"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:25 -0700
X-CSE-ConnectionGUID: BlCN+pq7RxegdhxIS3JP5w==
X-CSE-MsgGUID: 88rjlo9zTque/TDCIkyFtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138925404"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:48:23 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: stable@vger.kernel.org
Cc: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 1/7] accel/ivpu: Make DB_ID and JOB_ID allocations incremental
Date: Wed, 30 Apr 2025 14:48:13 +0200
Message-ID: <20250430124819.3761263-2-jacek.lawrynowicz@linux.intel.com>
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

From: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>

commit c3b0ec0fe0c7ebc4eb42ba60f7340ecdb7aae1a2 upstream.

Save last used ID and use it to limit the possible values
for the ID. This should decrease the rate at which the IDs
are reused, which will make debugging easier.

Cc: <stable@vger.kernel.org> # v6.12
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
index c929be956280e..b43621e069a11 100644
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


