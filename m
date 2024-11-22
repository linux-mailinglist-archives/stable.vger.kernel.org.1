Return-Path: <stable+bounces-94653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89DB9D6526
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8440516147E
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA4B1DF98A;
	Fri, 22 Nov 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RN5gHb4I"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C0189F43
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309670; cv=none; b=tEF61wCLRYqpauDkXPWCxoK8lp7Kkgr6VsqH5PzYFdgwYZ0a3wz7hPLrVOJTCJoDg/16GzdJf+79b4C1IGUf0ihw+roj0Y/x2hie9aGyzeaTAnj38GdmKAEEk2B5UbXmJrgXNXw4KqxAE+Nr9Ka+I1R8+G6d6iF/cKrxfUrUqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309670; c=relaxed/simple;
	bh=uODrVxStW7I/3O+etcOC+Ah7E6kcuuQeC4xC70lT30c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUoIkvIXEb9fdSpf8rfPCzoSEoXCfi0fKXSwCzQjm71DAxcPSBU+SZTXAs00gqKiK1OSlWGZmOvQ5HqKaCpDiYO9V4bNApdl0tD9qNF9Jp3gnTLsCl4ITRv6RmRbp+4vBFCALzj4M22vNK5dwqCL5QxVQGPRH+xPmDJepU/+N9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RN5gHb4I; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309669; x=1763845669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uODrVxStW7I/3O+etcOC+Ah7E6kcuuQeC4xC70lT30c=;
  b=RN5gHb4Ivn/qLmkAiHhhEy53lsJEYiD9Av+ubqeTFmz0ZJQpLVkUcaRY
   W8REixGgup5D7nkTWKHUvmDRmUNBhCxwZeUwlS7ev+FNLw70ztBO3cz8d
   Uz202x/PJ4aLccBC+PYFRTHWGJb0BZLmAui6QaQDPWSJrvJcwCg3GehZn
   hY+DVMpV6ZD9DfyjFYOGPVa9FiWcm9IKJoTmcFvb+i8u5y2C8kXIQlQUq
   rMza2syA2MpuIcLnAQNrbSQ5Ckq8UBLzfXFz0e6oba6V1Wak3Xj75vPiq
   p0IfWrTEDipaap+wx9+MxP8ll5mvVZukLzbR+NHwxcsE8QbLLz5IlzfkG
   Q==;
X-CSE-ConnectionGUID: hdR5X5jVS7eZbB9MlvtfAQ==
X-CSE-MsgGUID: bLFgzp3dT2O8vl50htvt+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878272"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878272"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
X-CSE-ConnectionGUID: XtQoZ8JFTdq4stAtdlIYxw==
X-CSE-MsgGUID: seYiwdGFQmOfA7U/bHGW7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457242"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:42 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Vinod Govindapillai <vinod.govindapillai@intel.com>
Subject: [PATCH 6.11 16/31] drm/xe: Remove runtime argument from display s/r functions
Date: Fri, 22 Nov 2024 13:07:04 -0800
Message-ID: <20241122210719.213373-17-lucas.demarchi@intel.com>
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

From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

commit f90491d4b64e302e940133103d3d9908e70e454f upstream.

The previous change ensures that pm_suspend is only called when
suspending or resuming. This ensures no further bugs like those
in the previous commit.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Vinod Govindapillai <vinod.govindapillai@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240905150052.174895-3-maarten.lankhorst@linux.intel.com
[ s/probe_display/enable_display/ to fix conflicts ]
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 53 +++++++++++++++----------
 drivers/gpu/drm/xe/display/xe_display.h |  8 ++--
 drivers/gpu/drm/xe/xe_pm.c              |  6 +--
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 574909e098c17..04e99d1beb21a 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -305,18 +305,7 @@ static void xe_display_flush_cleanup_work(struct xe_device *xe)
 }
 
 /* TODO: System and runtime suspend/resume sequences will be sanitized as a follow-up. */
-void xe_display_pm_runtime_suspend(struct xe_device *xe)
-{
-	if (!xe->info.enable_display)
-		return;
-
-	if (xe->d3cold.allowed)
-		xe_display_pm_suspend(xe, true);
-
-	intel_hpd_poll_enable(xe);
-}
-
-void xe_display_pm_suspend(struct xe_device *xe, bool runtime)
+static void __xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 {
 	bool s2idle = suspend_to_idle();
 	if (!xe->info.enable_display)
@@ -350,26 +339,31 @@ void xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 	intel_dmc_suspend(xe);
 }
 
-void xe_display_pm_suspend_late(struct xe_device *xe)
+void xe_display_pm_suspend(struct xe_device *xe)
+{
+	__xe_display_pm_suspend(xe, false);
+}
+
+void xe_display_pm_runtime_suspend(struct xe_device *xe)
 {
-	bool s2idle = suspend_to_idle();
 	if (!xe->info.enable_display)
 		return;
 
-	intel_power_domains_suspend(xe, s2idle);
+	if (xe->d3cold.allowed)
+		__xe_display_pm_suspend(xe, true);
 
-	intel_display_power_suspend_late(xe);
+	intel_hpd_poll_enable(xe);
 }
 
-void xe_display_pm_runtime_resume(struct xe_device *xe)
+void xe_display_pm_suspend_late(struct xe_device *xe)
 {
+	bool s2idle = suspend_to_idle();
 	if (!xe->info.enable_display)
 		return;
 
-	intel_hpd_poll_disable(xe);
+	intel_power_domains_suspend(xe, s2idle);
 
-	if (xe->d3cold.allowed)
-		xe_display_pm_resume(xe, true);
+	intel_display_power_suspend_late(xe);
 }
 
 void xe_display_pm_resume_early(struct xe_device *xe)
@@ -382,7 +376,7 @@ void xe_display_pm_resume_early(struct xe_device *xe)
 	intel_power_domains_resume(xe);
 }
 
-void xe_display_pm_resume(struct xe_device *xe, bool runtime)
+static void __xe_display_pm_resume(struct xe_device *xe, bool runtime)
 {
 	if (!xe->info.enable_display)
 		return;
@@ -414,6 +408,23 @@ void xe_display_pm_resume(struct xe_device *xe, bool runtime)
 	intel_power_domains_enable(xe);
 }
 
+void xe_display_pm_resume(struct xe_device *xe)
+{
+	__xe_display_pm_resume(xe, false);
+}
+
+void xe_display_pm_runtime_resume(struct xe_device *xe)
+{
+	if (!xe->info.enable_display)
+		return;
+
+	intel_hpd_poll_disable(xe);
+
+	if (xe->d3cold.allowed)
+		__xe_display_pm_resume(xe, true);
+}
+
+
 static void display_device_remove(struct drm_device *dev, void *arg)
 {
 	struct xe_device *xe = arg;
diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
index 53d727fd792b4..bed55fd26f304 100644
--- a/drivers/gpu/drm/xe/display/xe_display.h
+++ b/drivers/gpu/drm/xe/display/xe_display.h
@@ -34,10 +34,10 @@ void xe_display_irq_enable(struct xe_device *xe, u32 gu_misc_iir);
 void xe_display_irq_reset(struct xe_device *xe);
 void xe_display_irq_postinstall(struct xe_device *xe, struct xe_gt *gt);
 
-void xe_display_pm_suspend(struct xe_device *xe, bool runtime);
+void xe_display_pm_suspend(struct xe_device *xe);
 void xe_display_pm_suspend_late(struct xe_device *xe);
 void xe_display_pm_resume_early(struct xe_device *xe);
-void xe_display_pm_resume(struct xe_device *xe, bool runtime);
+void xe_display_pm_resume(struct xe_device *xe);
 void xe_display_pm_runtime_suspend(struct xe_device *xe);
 void xe_display_pm_runtime_resume(struct xe_device *xe);
 
@@ -65,10 +65,10 @@ static inline void xe_display_irq_enable(struct xe_device *xe, u32 gu_misc_iir)
 static inline void xe_display_irq_reset(struct xe_device *xe) {}
 static inline void xe_display_irq_postinstall(struct xe_device *xe, struct xe_gt *gt) {}
 
-static inline void xe_display_pm_suspend(struct xe_device *xe, bool runtime) {}
+static inline void xe_display_pm_suspend(struct xe_device *xe) {}
 static inline void xe_display_pm_suspend_late(struct xe_device *xe) {}
 static inline void xe_display_pm_resume_early(struct xe_device *xe) {}
-static inline void xe_display_pm_resume(struct xe_device *xe, bool runtime) {}
+static inline void xe_display_pm_resume(struct xe_device *xe) {}
 static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
 static inline void xe_display_pm_runtime_resume(struct xe_device *xe) {}
 
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 0f6f0526efbc0..1402156e4b7e6 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -91,7 +91,7 @@ int xe_pm_suspend(struct xe_device *xe)
 	for_each_gt(gt, xe, id)
 		xe_gt_suspend_prepare(gt);
 
-	xe_display_pm_suspend(xe, false);
+	xe_display_pm_suspend(xe);
 
 	/* FIXME: Super racey... */
 	err = xe_bo_evict_all(xe);
@@ -101,7 +101,7 @@ int xe_pm_suspend(struct xe_device *xe)
 	for_each_gt(gt, xe, id) {
 		err = xe_gt_suspend(gt);
 		if (err) {
-			xe_display_pm_resume(xe, false);
+			xe_display_pm_resume(xe);
 			goto err;
 		}
 	}
@@ -154,7 +154,7 @@ int xe_pm_resume(struct xe_device *xe)
 	for_each_gt(gt, xe, id)
 		xe_gt_resume(gt);
 
-	xe_display_pm_resume(xe, false);
+	xe_display_pm_resume(xe);
 
 	err = xe_bo_restore_user(xe);
 	if (err)
-- 
2.47.0


