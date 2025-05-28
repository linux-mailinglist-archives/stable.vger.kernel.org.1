Return-Path: <stable+bounces-147975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E95AC6D15
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8327DA225B7
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D80728C2CE;
	Wed, 28 May 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhbzipSp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64167218EB1
	for <stable@vger.kernel.org>; Wed, 28 May 2025 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446980; cv=none; b=G7U6VY8cQYGGtEjRjA6aQeoH+eGc18VUGUhF6tEOeOY+Yqrwyd38tn9ehQvTgtq57PEmjsqOdSAPHsROTgj+JijZOOU8CoKkTqhZbTRAYjhgI8MMzGasKRvR6rCmkKGjnNyJNQ3kyIT7nLTxQPc9LHK/HfqAGfMCoKCP0/JetBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446980; c=relaxed/simple;
	bh=z29oqwbfIkfZOK/DRZr/JGiSy5UYuX6rEDLDM6hk5OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klKXVaftH9DKpCQElx0CgyFc6L6HvxZpheSxbj0wOI++Zwtm6SUzjB16C81Z/sHjOeU01f2m/G2KJE5Mn7OE5Y2yprgdpZxGldm9WyM4NUOeUy4sQotu6RjQI9YzZ/0dsjAwReHXwT6sOuaCn/i8QxPK2Xe4AxeyZ+BqX9adUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhbzipSp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748446979; x=1779982979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z29oqwbfIkfZOK/DRZr/JGiSy5UYuX6rEDLDM6hk5OM=;
  b=KhbzipSpfdpm2B9ipvACnPLSbQoEJEZ+FJ2u9mBX3sX5L3JuQ4DdEAyu
   Pikjb98tMIqUibylJF+72dB5Um+B00MC5nqJ5NGCsqJkQDr7KvA46Eqeo
   05Z8pnOBH3UUUyT2VVRdyoDCzh4EOjq9nUh2a7meX8Yl1fQ/gVicRECeJ
   YhP8urPRcIN1MxZQviQIXcTGNFt9uWYhMK4dEU848RXtMx3lhjejfeLSV
   YlBM7cwq9rsXjRxBUOvyPe/flQsmHqLlqRo3q7PMo4iAHoEC7a50iat6t
   W5P4jjo4caRqnmsWR9TJYaHotam2AHjzfVzEGXne/3CKkdieZEWLIDhlu
   Q==;
X-CSE-ConnectionGUID: cgQ3UbW/TG2y3kUARZD2eQ==
X-CSE-MsgGUID: xwDJlPVPT5WW0SAM06RRJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50406856"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="50406856"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:42:58 -0700
X-CSE-ConnectionGUID: uh/OJARtRgG8VbUHPuMO1w==
X-CSE-MsgGUID: ud+M1hp4T9KX7dOSwyfh+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143276197"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:42:55 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	Karol Wachowski <karol.wachowski@intel.com>,
	stable@vger.kernel.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH] accel/ivpu: Trigger device recovery on engine reset/resume failure
Date: Wed, 28 May 2025 17:42:53 +0200
Message-ID: <20250528154253.500556-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Wachowski <karol.wachowski@intel.com>

Trigger full device recovery when the driver fails to restore device state
via engine reset and resume operations. This is necessary because, even if
submissions from a faulty context are blocked, the NPU may still process
previously submitted faulty jobs if the engine reset fails to abort them.
Such jobs can continue to generate faults and occupy device resources.
When engine reset is ineffective, the only way to recover is to perform
a full device recovery.

Fixes: dad945c27a42 ("accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW")
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_job.c     | 6 ++++--
 drivers/accel/ivpu/ivpu_jsm_msg.c | 9 +++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 1c8e283ad9854..fae8351aa3309 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -986,7 +986,8 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
 		return;
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
-		ivpu_jsm_reset_engine(vdev, 0);
+		if (ivpu_jsm_reset_engine(vdev, 0))
+			return;
 
 	mutex_lock(&vdev->context_list_lock);
 	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
@@ -1009,7 +1010,8 @@ void ivpu_context_abort_work_fn(struct work_struct *work)
 	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
 		goto runtime_put;
 
-	ivpu_jsm_hws_resume_engine(vdev, 0);
+	if (ivpu_jsm_hws_resume_engine(vdev, 0))
+		return;
 	/*
 	 * In hardware scheduling mode NPU already has stopped processing jobs
 	 * and won't send us any further notifications, thus we have to free job related resources
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index 219ab8afefabd..0256b2dfefc10 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -7,6 +7,7 @@
 #include "ivpu_hw.h"
 #include "ivpu_ipc.h"
 #include "ivpu_jsm_msg.h"
+#include "ivpu_pm.h"
 #include "vpu_jsm_api.h"
 
 const char *ivpu_jsm_msg_type_to_str(enum vpu_ipc_msg_type type)
@@ -163,8 +164,10 @@ int ivpu_jsm_reset_engine(struct ivpu_device *vdev, u32 engine)
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_ENGINE_RESET_DONE, &resp,
 				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
-	if (ret)
+	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to reset engine %d: %d\n", engine, ret);
+		ivpu_pm_trigger_recovery(vdev, "Engine reset failed");
+	}
 
 	return ret;
 }
@@ -354,8 +357,10 @@ int ivpu_jsm_hws_resume_engine(struct ivpu_device *vdev, u32 engine)
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_HWS_RESUME_ENGINE_DONE, &resp,
 				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
-	if (ret)
+	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to resume engine %d: %d\n", engine, ret);
+		ivpu_pm_trigger_recovery(vdev, "Engine resume failed");
+	}
 
 	return ret;
 }
-- 
2.45.1


