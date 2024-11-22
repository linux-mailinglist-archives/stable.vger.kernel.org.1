Return-Path: <stable+bounces-94650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1869D6525
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09CBEB22E96
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8E61DF99C;
	Fri, 22 Nov 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJ9ufR+4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192518784C
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309669; cv=none; b=CUt65DCZ1vYJY8X6oOPTux72pnc00jqh177cbQTlCF8Lq/g10WtkAc/Iw14cKnP9wyhVo0w9VK9ic/cxkODGOxIecKjeJ4PC8lxiVhXDrzTlmiMSgpekI1YQH+4/9fCAn0QXDhPs/EByybEE/y3ewP9gzBrZPNGcssBPtvI48fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309669; c=relaxed/simple;
	bh=wIJibSI0w5GzJYB/hzyDfdoiACmbA080jBo3j9clY1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3g4utW7BW59Ok++YNu/FP5AIlA8fT6d3U02JFnJa18yEBSHUzqfzyqhqmcYYnHhk/t3zkyFYt+s0gM8gOMohm6k5W6GKfFUaPkX6TACpZlA1nQOhGLo2tDld86pjfYDnJkvVZIx9HzeovsTWsJdMJNsroOgpAbQcFjrKA8/fuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJ9ufR+4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309668; x=1763845668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wIJibSI0w5GzJYB/hzyDfdoiACmbA080jBo3j9clY1s=;
  b=bJ9ufR+4glnklYx9PJqy7gu5RgYbkn1CNfHugEri9X1ihWacVlpGgnF+
   ar6d8Su2sgTU+TDWmdtxt4Yyh8NJ5FGh2zTsuvalUM+rVEIPfDvAn+qdk
   WWv7vDDQSdPTcn0BMjrQAr17v0M8KjUBjAPLoyeBTzv8J/CFrl9biYtDM
   EznepmucVxuZDOQb9VDlWWYevAP91v4H/3rZFBNk2yWa6KpGN5bA2QA1Z
   SPOtvMvgPckCjdvjeCBvziRNnJUGxXfzbimoUEvxV20knYRwPpR+GQGM3
   kAuV4YfMuV+uWwR6MQ0Vo1XLp+qcYB4GkatZGvueU1MOkpwk2Jr2tz9gd
   g==;
X-CSE-ConnectionGUID: p6nE43YRTkq3zyM1yvCs3w==
X-CSE-MsgGUID: Dv6Ml2C0QgO67atK+fqhJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878269"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878269"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
X-CSE-ConnectionGUID: qnfr0UrcQDmOdcn3aeooPg==
X-CSE-MsgGUID: CQL4OvFETmmWkc2S5/Ou/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457225"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vinod Govindapillai <vinod.govindapillai@intel.com>,
	Arun R Murthy <arun.r.murthy@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 13/31] drm/xe/display: handle HPD polling in display runtime suspend/resume
Date: Fri, 22 Nov 2024 13:07:01 -0800
Message-ID: <20241122210719.213373-14-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinod Govindapillai <vinod.govindapillai@intel.com>

commit 66a0f6b9f5fc205272035b6ffa4830be51e3f787 upstream.

In XE, display runtime suspend / resume routines are called only
if d3cold is allowed. This makes the driver unable to detect any
HPDs once the device goes into runtime suspend state in platforms
like LNL. Update the display runtime suspend / resume routines
to include HPD polling regardless of d3cold status.

While xe_display_pm_suspend/resume() performs steps during runtime
suspend/resume that shouldn't happen, like suspending MST and they
are missing other steps like enabling DC9, this patchset is meant
to keep the current behavior wrt. these, leaving the corresponding
updates for a follow-up

v2: have a separate function for display runtime s/r (Rodrigo)

v3: better streamlining of system s/r and runtime s/r calls (Imre)

v4: rebased

Reviewed-by: Arun R Murthy <arun.r.murthy@intel.com>
Signed-off-by: Vinod Govindapillai <vinod.govindapillai@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240823112148.327015-4-vinod.govindapillai@intel.com
[ Fix silent conflict due to s/enable_display/probe_display/ ]
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/xe/display/xe_display.h |  4 ++++
 drivers/gpu/drm/xe/xe_pm.c              |  8 +++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 34b7050fc7c33..574909e098c17 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -304,6 +304,18 @@ static void xe_display_flush_cleanup_work(struct xe_device *xe)
 	}
 }
 
+/* TODO: System and runtime suspend/resume sequences will be sanitized as a follow-up. */
+void xe_display_pm_runtime_suspend(struct xe_device *xe)
+{
+	if (!xe->info.enable_display)
+		return;
+
+	if (xe->d3cold.allowed)
+		xe_display_pm_suspend(xe, true);
+
+	intel_hpd_poll_enable(xe);
+}
+
 void xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 {
 	bool s2idle = suspend_to_idle();
@@ -349,6 +361,17 @@ void xe_display_pm_suspend_late(struct xe_device *xe)
 	intel_display_power_suspend_late(xe);
 }
 
+void xe_display_pm_runtime_resume(struct xe_device *xe)
+{
+	if (!xe->info.enable_display)
+		return;
+
+	intel_hpd_poll_disable(xe);
+
+	if (xe->d3cold.allowed)
+		xe_display_pm_resume(xe, true);
+}
+
 void xe_display_pm_resume_early(struct xe_device *xe)
 {
 	if (!xe->info.enable_display)
diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
index 000fb5799df54..53d727fd792b4 100644
--- a/drivers/gpu/drm/xe/display/xe_display.h
+++ b/drivers/gpu/drm/xe/display/xe_display.h
@@ -38,6 +38,8 @@ void xe_display_pm_suspend(struct xe_device *xe, bool runtime);
 void xe_display_pm_suspend_late(struct xe_device *xe);
 void xe_display_pm_resume_early(struct xe_device *xe);
 void xe_display_pm_resume(struct xe_device *xe, bool runtime);
+void xe_display_pm_runtime_suspend(struct xe_device *xe);
+void xe_display_pm_runtime_resume(struct xe_device *xe);
 
 #else
 
@@ -67,6 +69,8 @@ static inline void xe_display_pm_suspend(struct xe_device *xe, bool runtime) {}
 static inline void xe_display_pm_suspend_late(struct xe_device *xe) {}
 static inline void xe_display_pm_resume_early(struct xe_device *xe) {}
 static inline void xe_display_pm_resume(struct xe_device *xe, bool runtime) {}
+static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
+static inline void xe_display_pm_runtime_resume(struct xe_device *xe) {}
 
 #endif /* CONFIG_DRM_XE_DISPLAY */
 #endif /* _XE_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 9a3f618d22dcb..0f6f0526efbc0 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -362,9 +362,9 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 		xe_bo_runtime_pm_release_mmap_offset(bo);
 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
 
-	if (xe->d3cold.allowed) {
-		xe_display_pm_suspend(xe, true);
+	xe_display_pm_runtime_suspend(xe);
 
+	if (xe->d3cold.allowed) {
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out;
@@ -426,12 +426,14 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	for_each_gt(gt, xe, id)
 		xe_gt_resume(gt);
 
+	xe_display_pm_runtime_resume(xe);
+
 	if (xe->d3cold.allowed) {
-		xe_display_pm_resume(xe, true);
 		err = xe_bo_restore_user(xe);
 		if (err)
 			goto out;
 	}
+
 out:
 	lock_map_release(&xe_pm_runtime_lockdep_map);
 	xe_pm_write_callback_task(xe, NULL);
-- 
2.47.0


