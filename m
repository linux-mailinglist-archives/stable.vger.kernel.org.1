Return-Path: <stable+bounces-166831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FFFB1E6F8
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 13:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0684D580DCC
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 11:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC61FF5E3;
	Fri,  8 Aug 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLCrTY/r"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66F145329
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651385; cv=none; b=hnsg9CbnDD5pwY5onZgEwQtCceatwFfl5CdqSP4yPuA2EYMi9zPHuTbRh8Wq+ltJZ6fc9+a7qbOyiCCWQxTN69NoIA0sFLVO6NTXM60XzQqinr2JYg3g5Gi7gz6VV7i5COn77UAS2wpwCy8oy49thrbwPS3nN77OnL9zSTCrWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651385; c=relaxed/simple;
	bh=oDN8mNmri0NIELuh1yHunw0u7lcm6gCsrRT07Xgm6zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TV75Vqub/FUuBD9468iIUnevaw8cn3p5kSw+i9iqChszHbGi26I/D3p0uoDZXFkLvr7b57/RXzmm01PiJU57twQpLB2IpA+sb84brmNeABjuFAgFFrtWv5OD3vafp4HNQFC4/dQ91/wsTSOC52lAdF9M6/+S+5Soj2QuZSZwRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLCrTY/r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754651384; x=1786187384;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oDN8mNmri0NIELuh1yHunw0u7lcm6gCsrRT07Xgm6zo=;
  b=ZLCrTY/ryaSrD04HJYFvVEByRNVp6VXofvTtlMcKq3vfzALqWNolKFTm
   hXQmsQj/0Fi+NdSacIxvHm/gKjSsebqavWSk43lV8PzUswlFYwXLnKID7
   j2HcOw4k2Vd5kVz9FaYHwL1W2SPtVAFpAStvbC2cW9fqBCuEBKKi9ADX5
   zIj7Aomh0HfNrSbxRlLXoRGLjX58WkJz/6pbVuejSPVTCDx0UI5M2FfMt
   LiSTl6Fr51mTAvYHXJGuX0rnZ3mRwfDSqeGVvnU/n8R2IeUupjsKgJsg/
   hPQ20up3B7yRKbZskWO+mYvEZpRGfjh+Pucg8jMrWveLiMhmrWEiLF84z
   Q==;
X-CSE-ConnectionGUID: lwstSHAwS7i6oQvTbEIMHw==
X-CSE-MsgGUID: wrgfGoOrTHeSmBpLI20szw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67267511"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="67267511"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 04:09:44 -0700
X-CSE-ConnectionGUID: il22XxceT4CJq2Zg1Q8WSQ==
X-CSE-MsgGUID: 1UAFZIYLSQSN8UE0534YPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="170682507"
Received: from unknown (HELO jlawryno.igk.intel.com) ([10.91.220.59])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 04:09:42 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	Karol Wachowski <karol.wachowski@intel.com>,
	stable@vger.kernel.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH] accel/ivpu: Prevent recovery work from being queued during device removal
Date: Fri,  8 Aug 2025 13:09:39 +0200
Message-ID: <20250808110939.328366-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Wachowski <karol.wachowski@intel.com>

Use disable_work_sync() instead of cancel_work_sync() in ivpu_dev_fini()
to ensure that no new recovery work items can be queued after device
removal has started. Previously, recovery work could be scheduled even
after canceling existing work, potentially leading to use-after-free
bugs if recovery accessed freed resources.

Rename ivpu_pm_cancel_recovery() to ivpu_pm_disable_recovery() to better
reflect its new behavior.

Fixes: 58cde80f45a2 ("accel/ivpu: Use dedicated work for job timeout detection")
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 2 +-
 drivers/accel/ivpu/ivpu_pm.c  | 4 ++--
 drivers/accel/ivpu/ivpu_pm.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 3d6d52492536a..3289751b47573 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -677,7 +677,7 @@ static void ivpu_bo_unbind_all_user_contexts(struct ivpu_device *vdev)
 static void ivpu_dev_fini(struct ivpu_device *vdev)
 {
 	ivpu_jobs_abort_all(vdev);
-	ivpu_pm_cancel_recovery(vdev);
+	ivpu_pm_disable_recovery(vdev);
 	ivpu_pm_disable(vdev);
 	ivpu_prepare_for_reset(vdev);
 	ivpu_shutdown(vdev);
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index eacda1dbe8405..475ddc94f1cfe 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -417,10 +417,10 @@ void ivpu_pm_init(struct ivpu_device *vdev)
 	ivpu_dbg(vdev, PM, "Autosuspend delay = %d\n", delay);
 }
 
-void ivpu_pm_cancel_recovery(struct ivpu_device *vdev)
+void ivpu_pm_disable_recovery(struct ivpu_device *vdev)
 {
 	drm_WARN_ON(&vdev->drm, delayed_work_pending(&vdev->pm->job_timeout_work));
-	cancel_work_sync(&vdev->pm->recovery_work);
+	disable_work_sync(&vdev->pm->recovery_work);
 }
 
 void ivpu_pm_enable(struct ivpu_device *vdev)
diff --git a/drivers/accel/ivpu/ivpu_pm.h b/drivers/accel/ivpu/ivpu_pm.h
index 89b264cc0e3e7..a2aa7a27f32ef 100644
--- a/drivers/accel/ivpu/ivpu_pm.h
+++ b/drivers/accel/ivpu/ivpu_pm.h
@@ -25,7 +25,7 @@ struct ivpu_pm_info {
 void ivpu_pm_init(struct ivpu_device *vdev);
 void ivpu_pm_enable(struct ivpu_device *vdev);
 void ivpu_pm_disable(struct ivpu_device *vdev);
-void ivpu_pm_cancel_recovery(struct ivpu_device *vdev);
+void ivpu_pm_disable_recovery(struct ivpu_device *vdev);
 
 int ivpu_pm_suspend_cb(struct device *dev);
 int ivpu_pm_resume_cb(struct device *dev);
-- 
2.45.1


