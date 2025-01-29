Return-Path: <stable+bounces-111127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0CA21D42
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 13:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312631886F89
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE277A23;
	Wed, 29 Jan 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8kY/Kh3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A9E28EB
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154421; cv=none; b=Y0DUkstHW8vEgnhGHAc7qIbyypd4OpG0xFpzmNEQLzuDytAL0mvgv10RBjhVL2+cLUZdjOJihY4euCgo+t2U/BxCZxtkJAlunZ0Lng5a8eR2bUitW+5R6cdFwJIyLHEmiZJ3YqmFKEEn/jAbmJQhe2HXoIhODOz1nuvdt84W4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154421; c=relaxed/simple;
	bh=ycYTW3uXyeWMfli1Zkkt9W6LanpaxIjUMBTLTTzIwRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhjHv7UOxRxLvo2ATXdkyhq/sL40xy+uSD8yO1wX8PZsTEYiGuZfqvX2buZNKplRd21A6K1u0KCgWv3QfoX5Er60vYfz7C1Ru7oBFa5trNb37HTIw7ziN3YgJCOoWFcDog80AAvgvro9fpGQJynnGbrzoSBCm0TBQ6So0vBpVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8kY/Kh3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738154420; x=1769690420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ycYTW3uXyeWMfli1Zkkt9W6LanpaxIjUMBTLTTzIwRI=;
  b=j8kY/Kh33jKPeFP4NFaVrp/yoCYAHbf0+NzrJlQ5wCJmRpWG7qdAmnR+
   AcnI04A/hSm3HsIkrvj0c0h0YAmX2XmelsOP2SQE32c+no6xdMpHnY3WG
   uDhV+mlB8uFYxqCQVw33ACNg1mDj++NsbgzRCY/1vzyMjWU7UWxIya9PY
   1aTPOQAocwbg3ely9BEcAXx190ciL4bdVjZvMsuwSghGQwy4ca7Z5wvok
   289WK0i0dwiTL/qmkyFqU5ui0CWx+AJLrnJSJrSMkskkrT6YFCra802mp
   +fGH7yqjb55uSLH6PDlYCk5FJBFQ1pnAimFm0F+7we5M/9L875npDVYP0
   g==;
X-CSE-ConnectionGUID: SkE0/hEjRvicolv9fbP9gA==
X-CSE-MsgGUID: bc0grW/mTomuepbXyJvURA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49647275"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="49647275"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 04:40:20 -0800
X-CSE-ConnectionGUID: ejX3+XEfRh6qIee+vuHBWw==
X-CSE-MsgGUID: 5Mar7FTlSgCWertrPeAhzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113030878"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 04:40:17 -0800
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	maciej.falkowski@linux.intel.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] accel/ivpu: Fix error handling in recovery/reset
Date: Wed, 29 Jan 2025 13:40:09 +0100
Message-ID: <20250129124009.1039982-4-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250129124009.1039982-1-jacek.lawrynowicz@linux.intel.com>
References: <20250129124009.1039982-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Disable runtime PM for the duration of reset/recovery so it is possible
to set the correct runtime PM state depending on the outcome of the
`ivpu_resume()`. Don’t suspend or reset the HW if the NPU is suspended
when the reset/recovery is requested. Also, move common reset/recovery
code to separate functions for better code readability.

Fixes: 27d19268cf39 ("accel/ivpu: Improve recovery and reset support")
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_pm.c | 79 ++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index c3774d2221326..8b2b050cc41a9 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -115,41 +115,57 @@ static int ivpu_resume(struct ivpu_device *vdev)
 	return ret;
 }
 
-static void ivpu_pm_recovery_work(struct work_struct *work)
+static void ivpu_pm_reset_begin(struct ivpu_device *vdev)
 {
-	struct ivpu_pm_info *pm = container_of(work, struct ivpu_pm_info, recovery_work);
-	struct ivpu_device *vdev = pm->vdev;
-	char *evt[2] = {"IVPU_PM_EVENT=IVPU_RECOVER", NULL};
-	int ret;
-
-	ivpu_err(vdev, "Recovering the NPU (reset #%d)\n", atomic_read(&vdev->pm->reset_counter));
-
-	ret = pm_runtime_resume_and_get(vdev->drm.dev);
-	if (ret)
-		ivpu_err(vdev, "Failed to resume NPU: %d\n", ret);
-
-	ivpu_jsm_state_dump(vdev);
-	ivpu_dev_coredump(vdev);
+	pm_runtime_disable(vdev->drm.dev);
 
 	atomic_inc(&vdev->pm->reset_counter);
 	atomic_set(&vdev->pm->reset_pending, 1);
 	down_write(&vdev->pm->reset_lock);
+}
+
+static void ivpu_pm_reset_complete(struct ivpu_device *vdev)
+{
+	int ret;
 
-	ivpu_suspend(vdev);
 	ivpu_pm_prepare_cold_boot(vdev);
 	ivpu_jobs_abort_all(vdev);
 	ivpu_ms_cleanup_all(vdev);
 
 	ret = ivpu_resume(vdev);
-	if (ret)
+	if (ret) {
 		ivpu_err(vdev, "Failed to resume NPU: %d\n", ret);
+		pm_runtime_set_suspended(vdev->drm.dev);
+	} else {
+		pm_runtime_set_active(vdev->drm.dev);
+	}
 
 	up_write(&vdev->pm->reset_lock);
 	atomic_set(&vdev->pm->reset_pending, 0);
 
-	kobject_uevent_env(&vdev->drm.dev->kobj, KOBJ_CHANGE, evt);
 	pm_runtime_mark_last_busy(vdev->drm.dev);
-	pm_runtime_put_autosuspend(vdev->drm.dev);
+	pm_runtime_enable(vdev->drm.dev);
+}
+
+static void ivpu_pm_recovery_work(struct work_struct *work)
+{
+	struct ivpu_pm_info *pm = container_of(work, struct ivpu_pm_info, recovery_work);
+	struct ivpu_device *vdev = pm->vdev;
+	char *evt[2] = {"IVPU_PM_EVENT=IVPU_RECOVER", NULL};
+
+	ivpu_err(vdev, "Recovering the NPU (reset #%d)\n", atomic_read(&vdev->pm->reset_counter));
+
+	ivpu_pm_reset_begin(vdev);
+
+	if (!pm_runtime_status_suspended(vdev->drm.dev)) {
+		ivpu_jsm_state_dump(vdev);
+		ivpu_dev_coredump(vdev);
+		ivpu_suspend(vdev);
+	}
+
+	ivpu_pm_reset_complete(vdev);
+
+	kobject_uevent_env(&vdev->drm.dev->kobj, KOBJ_CHANGE, evt);
 }
 
 void ivpu_pm_trigger_recovery(struct ivpu_device *vdev, const char *reason)
@@ -328,16 +344,13 @@ void ivpu_pm_reset_prepare_cb(struct pci_dev *pdev)
 	struct ivpu_device *vdev = pci_get_drvdata(pdev);
 
 	ivpu_dbg(vdev, PM, "Pre-reset..\n");
-	atomic_inc(&vdev->pm->reset_counter);
-	atomic_set(&vdev->pm->reset_pending, 1);
 
-	pm_runtime_get_sync(vdev->drm.dev);
-	down_write(&vdev->pm->reset_lock);
-	ivpu_prepare_for_reset(vdev);
-	ivpu_hw_reset(vdev);
-	ivpu_pm_prepare_cold_boot(vdev);
-	ivpu_jobs_abort_all(vdev);
-	ivpu_ms_cleanup_all(vdev);
+	ivpu_pm_reset_begin(vdev);
+
+	if (!pm_runtime_status_suspended(vdev->drm.dev)) {
+		ivpu_prepare_for_reset(vdev);
+		ivpu_hw_reset(vdev);
+	}
 
 	ivpu_dbg(vdev, PM, "Pre-reset done.\n");
 }
@@ -345,18 +358,12 @@ void ivpu_pm_reset_prepare_cb(struct pci_dev *pdev)
 void ivpu_pm_reset_done_cb(struct pci_dev *pdev)
 {
 	struct ivpu_device *vdev = pci_get_drvdata(pdev);
-	int ret;
 
 	ivpu_dbg(vdev, PM, "Post-reset..\n");
-	ret = ivpu_resume(vdev);
-	if (ret)
-		ivpu_err(vdev, "Failed to set RESUME state: %d\n", ret);
-	up_write(&vdev->pm->reset_lock);
-	atomic_set(&vdev->pm->reset_pending, 0);
-	ivpu_dbg(vdev, PM, "Post-reset done.\n");
 
-	pm_runtime_mark_last_busy(vdev->drm.dev);
-	pm_runtime_put_autosuspend(vdev->drm.dev);
+	ivpu_pm_reset_complete(vdev);
+
+	ivpu_dbg(vdev, PM, "Post-reset done.\n");
 }
 
 void ivpu_pm_init(struct ivpu_device *vdev)
-- 
2.45.1


