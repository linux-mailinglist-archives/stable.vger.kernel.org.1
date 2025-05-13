Return-Path: <stable+bounces-144275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033DCAB5FDE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 01:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735B417CBA4
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 23:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1139620C014;
	Tue, 13 May 2025 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luvDFKDn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518345948
	for <stable@vger.kernel.org>; Tue, 13 May 2025 23:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747178840; cv=none; b=DMHS+2/nJo34SkKH2I4Hc8H4FVyqvIvxNt8cLn2RdewRTvPENAi5MXEjI6y5lHjjXz6z4XfkTr2aWvLUhjhqjAlSB5QAQNNZzR8q53EyhL2XITRLACeD6aiKPQjP/eYx45z7pXimTYoN2rv3lxNibvRTKsmhxhzCXCD75ViKwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747178840; c=relaxed/simple;
	bh=9HVEFYze78dXG3lwXm9qjTQNO+S+jSR4qPmvucDase8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+pEWPHC7D5Wv3XVnT6Fm4NNzEFyYCIiA8OS0tI0VJJuIJOD3sFUW0XvCVIJT30eoqVXoCaxYlzX0LHeg0b45/yhUf+1KbNgY/5s7vMKbjWohkI/zWebEW4fD7mwor7N4hP08jSl/ZHInd2HUM/u9cLoaaahXAZPDc2wxFRXxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luvDFKDn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747178839; x=1778714839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9HVEFYze78dXG3lwXm9qjTQNO+S+jSR4qPmvucDase8=;
  b=luvDFKDnHorInYWbxqNE+Dw7R2T42ARQr2jPlnpRGBpvShTODiwm/Gi9
   EvXl5NXhM2uJUHTtMIpzfgLjkzSFViiLYBC8cNOGLtp4qsCGsJBs+oadS
   HRkielTpGO/GW1YCIgiVz4Geuy6vnVowbDm5v+ScdQW+K699pjBjJEZ+S
   oCyvhHYV7XGvBxsyXkv/2CW/JDd1QKUZkZoN8MmvLHAHbe+pEAm1ZccUi
   D8fulJQPKAaSnEXuUOfhN5BC6ND6IemzMCB2Ya4oQTtKRDugPcXsS/KHV
   t9H5RzoPiJRvNM0Ge+0IrZpbBeSYcW3CnjYXO9688loaIyDCNSipaLjLU
   w==;
X-CSE-ConnectionGUID: 3PLHfqyTSFqkkBi9c1APOg==
X-CSE-MsgGUID: g4Vb/UCfQ7+voBwsWn6QSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="59713064"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="59713064"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 16:27:17 -0700
X-CSE-ConnectionGUID: oNrTTERIRkCzlhQUVpMOTw==
X-CSE-MsgGUID: ybBd//TqSsKqPXpI5QhOBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="137724198"
Received: from valcore-skull-1.fm.intel.com ([10.1.39.17])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 16:27:17 -0700
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
To: stable@vger.kernel.org
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Alan Previn <alan.previn.teres.alexis@intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.12.y] drm/xe/gsc: do not flush the GSC worker from the reset path
Date: Tue, 13 May 2025 16:27:06 -0700
Message-ID: <20250513232706.2986265-1-daniele.ceraolospurio@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025051239-ceremony-rehab-8e6c@gregkh>
References: <2025051239-ceremony-rehab-8e6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The workqueue used for the reset worker is marked as WQ_MEM_RECLAIM,
while the GSC one isn't (and can't be as we need to do memory
allocations in the gsc worker). Therefore, we can't flush the latter
from the former.

The reason why we had such a flush was to avoid interrupting either
the GSC FW load or in progress GSC proxy operations. GSC proxy
operations fall into 2 categories:

1) GSC proxy init: this only happens once immediately after GSC FW load
   and does not support being interrupted. The only way to recover from
   an interruption of the proxy init is to do an FLR and re-load the GSC.

2) GSC proxy request: this can happen in response to a request that
   the driver sends to the GSC. If this is interrupted, the GSC FW will
   timeout and the driver request will be failed, but overall the GSC
   will keep working fine.

Flushing the work allowed us to avoid interruption in both cases (unless
the hang came from the GSC engine itself, in which case we're toast
anyway). However, a failure on a proxy request is tolerable if we're in
a scenario where we're triggering a GT reset (i.e., something is already
gone pretty wrong), so what we really need to avoid is interrupting
the init flow, which we can do by polling on the register that reports
when the proxy init is complete (as that ensure us that all the load and
init operations have been completed).

Note that during suspend we still want to do a flush of the worker to
make sure it completes any operations involving the HW before the power
is cut.

v2: fix spelling in commit msg, rename waiter function (Julia)

Fixes: dd0e89e5edc2 ("drm/xe/gsc: GSC FW load")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4830
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Julia Filipchuk <julia.filipchuk@intel.com>
Link: https://lore.kernel.org/r/20250502155104.2201469-1-daniele.ceraolospurio@intel.com
(cherry picked from commit 12370bfcc4f0bdf70279ec5b570eb298963422b5)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 03552d8ac0afcc080c339faa0b726e2c0e9361cb)
---
 drivers/gpu/drm/xe/xe_gsc.c       | 22 ++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_gsc.h       |  1 +
 drivers/gpu/drm/xe/xe_gsc_proxy.c | 11 +++++++++++
 drivers/gpu/drm/xe/xe_gsc_proxy.h |  1 +
 drivers/gpu/drm/xe/xe_gt.c        |  2 +-
 drivers/gpu/drm/xe/xe_uc.c        |  8 +++++++-
 drivers/gpu/drm/xe/xe_uc.h        |  1 +
 7 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index 6fbea70d3d36..feb680d127e6 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -564,6 +564,28 @@ void xe_gsc_remove(struct xe_gsc *gsc)
 	xe_gsc_proxy_remove(gsc);
 }
 
+void xe_gsc_stop_prepare(struct xe_gsc *gsc)
+{
+	struct xe_gt *gt = gsc_to_gt(gsc);
+	int ret;
+
+	if (!xe_uc_fw_is_loadable(&gsc->fw) || xe_uc_fw_is_in_error_state(&gsc->fw))
+		return;
+
+	xe_force_wake_assert_held(gt_to_fw(gt), XE_FW_GSC);
+
+	/*
+	 * If the GSC FW load or the proxy init are interrupted, the only way
+	 * to recover it is to do an FLR and reload the GSC from scratch.
+	 * Therefore, let's wait for the init to complete before stopping
+	 * operations. The proxy init is the last step, so we can just wait on
+	 * that
+	 */
+	ret = xe_gsc_wait_for_proxy_init_done(gsc);
+	if (ret)
+		xe_gt_err(gt, "failed to wait for GSC init completion before uc stop\n");
+}
+
 /*
  * wa_14015076503: if the GSC FW is loaded, we need to alert it before doing a
  * GSC engine reset by writing a notification bit in the GS1 register and then
diff --git a/drivers/gpu/drm/xe/xe_gsc.h b/drivers/gpu/drm/xe/xe_gsc.h
index e282b9ef6ec4..c31fe24c4b66 100644
--- a/drivers/gpu/drm/xe/xe_gsc.h
+++ b/drivers/gpu/drm/xe/xe_gsc.h
@@ -16,6 +16,7 @@ struct xe_hw_engine;
 int xe_gsc_init(struct xe_gsc *gsc);
 int xe_gsc_init_post_hwconfig(struct xe_gsc *gsc);
 void xe_gsc_wait_for_worker_completion(struct xe_gsc *gsc);
+void xe_gsc_stop_prepare(struct xe_gsc *gsc);
 void xe_gsc_load_start(struct xe_gsc *gsc);
 void xe_gsc_remove(struct xe_gsc *gsc);
 void xe_gsc_hwe_irq_handler(struct xe_hw_engine *hwe, u16 intr_vec);
diff --git a/drivers/gpu/drm/xe/xe_gsc_proxy.c b/drivers/gpu/drm/xe/xe_gsc_proxy.c
index 2d6ea8c01445..85801de4fab1 100644
--- a/drivers/gpu/drm/xe/xe_gsc_proxy.c
+++ b/drivers/gpu/drm/xe/xe_gsc_proxy.c
@@ -71,6 +71,17 @@ bool xe_gsc_proxy_init_done(struct xe_gsc *gsc)
 	       HECI1_FWSTS1_PROXY_STATE_NORMAL;
 }
 
+int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc)
+{
+	struct xe_gt *gt = gsc_to_gt(gsc);
+
+	/* Proxy init can take up to 500ms, so wait double that for safety */
+	return xe_mmio_wait32(gt, HECI_FWSTS1(MTL_GSC_HECI1_BASE),
+			      HECI1_FWSTS1_CURRENT_STATE,
+			      HECI1_FWSTS1_PROXY_STATE_NORMAL,
+			      USEC_PER_SEC, NULL, false);
+}
+
 static void __gsc_proxy_irq_rmw(struct xe_gsc *gsc, u32 clr, u32 set)
 {
 	struct xe_gt *gt = gsc_to_gt(gsc);
diff --git a/drivers/gpu/drm/xe/xe_gsc_proxy.h b/drivers/gpu/drm/xe/xe_gsc_proxy.h
index c511ade6b863..e2498aa6de18 100644
--- a/drivers/gpu/drm/xe/xe_gsc_proxy.h
+++ b/drivers/gpu/drm/xe/xe_gsc_proxy.h
@@ -13,6 +13,7 @@ struct xe_gsc;
 int xe_gsc_proxy_init(struct xe_gsc *gsc);
 bool xe_gsc_proxy_init_done(struct xe_gsc *gsc);
 void xe_gsc_proxy_remove(struct xe_gsc *gsc);
+int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc);
 int xe_gsc_proxy_start(struct xe_gsc *gsc);
 
 int xe_gsc_proxy_request_handler(struct xe_gsc *gsc);
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 17ba15132a98..3a7628fb5ad3 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -828,7 +828,7 @@ void xe_gt_suspend_prepare(struct xe_gt *gt)
 {
 	XE_WARN_ON(xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 
-	xe_uc_stop_prepare(&gt->uc);
+	xe_uc_suspend_prepare(&gt->uc);
 
 	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
 }
diff --git a/drivers/gpu/drm/xe/xe_uc.c b/drivers/gpu/drm/xe/xe_uc.c
index 0d073a9987c2..bb03c524613f 100644
--- a/drivers/gpu/drm/xe/xe_uc.c
+++ b/drivers/gpu/drm/xe/xe_uc.c
@@ -241,7 +241,7 @@ void xe_uc_gucrc_disable(struct xe_uc *uc)
 
 void xe_uc_stop_prepare(struct xe_uc *uc)
 {
-	xe_gsc_wait_for_worker_completion(&uc->gsc);
+	xe_gsc_stop_prepare(&uc->gsc);
 	xe_guc_stop_prepare(&uc->guc);
 }
 
@@ -275,6 +275,12 @@ static void uc_reset_wait(struct xe_uc *uc)
 		goto again;
 }
 
+void xe_uc_suspend_prepare(struct xe_uc *uc)
+{
+	xe_gsc_wait_for_worker_completion(&uc->gsc);
+	xe_guc_stop_prepare(&uc->guc);
+}
+
 int xe_uc_suspend(struct xe_uc *uc)
 {
 	/* GuC submission not enabled, nothing to do */
diff --git a/drivers/gpu/drm/xe/xe_uc.h b/drivers/gpu/drm/xe/xe_uc.h
index 506517c11333..ba2937ab94cf 100644
--- a/drivers/gpu/drm/xe/xe_uc.h
+++ b/drivers/gpu/drm/xe/xe_uc.h
@@ -18,6 +18,7 @@ int xe_uc_reset_prepare(struct xe_uc *uc);
 void xe_uc_stop_prepare(struct xe_uc *uc);
 void xe_uc_stop(struct xe_uc *uc);
 int xe_uc_start(struct xe_uc *uc);
+void xe_uc_suspend_prepare(struct xe_uc *uc);
 int xe_uc_suspend(struct xe_uc *uc);
 int xe_uc_sanitize_reset(struct xe_uc *uc);
 void xe_uc_remove(struct xe_uc *uc);
-- 
2.43.0


