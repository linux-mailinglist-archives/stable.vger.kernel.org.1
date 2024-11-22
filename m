Return-Path: <stable+bounces-94648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A09D6521
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E41613FB
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE21DF995;
	Fri, 22 Nov 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+eSalrc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355F1DF73A
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309668; cv=none; b=s5a1AYTc6jcxwZRvjyAgQ1A2JeKSMW7opCYbR/Bi933/j5wRSsrzVATuMLQJZXq8//8M1HVDxRnDgcnf7UTAUqeqUVQRE4CM4MQo2fzLFHnSti8WUYEhiDpx5vdgB0fa58B7oawUpy3JI8e87w0uVXEFsd8YtWYZbYuFYUAti/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309668; c=relaxed/simple;
	bh=2LVukebnrBZMYcz/nzazlJjXqgK6LPOZRaEBYb8o0bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBI3FXXea0GhjjdzG6w9USv2P2YoZGP6HYvD9+/nTJ8VhCJNXabdF/rwEH4g8G/ZuyOsfzuCDTGAkKFVlu3nFemp7OOrF5cAedMtbccTvBBhSI67MyEy7iLVvv/S+PN3Zbj3VQTyPfvANjJvMfPfWlNZbUF9VemDIVmROsQ6BiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+eSalrc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309666; x=1763845666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2LVukebnrBZMYcz/nzazlJjXqgK6LPOZRaEBYb8o0bA=;
  b=S+eSalrc4eN7Elz12pnrTUwWaaeKroVVDM3Rl0GnAQd6cuM3BvtQKg68
   PYBlePi/L4mrjfY7HA2yn+yRCnTMqT4MnW/W/e1APyiNLXNsL1mdKB4k6
   AuOvGXrneJ2mW0nWK2kZ/XrHnCKiE2yh57zmRd3fbzDGvifzpKD1LmUwg
   tePWyz/7L4U9f6kbLQ78QhD5dceUMRZGDpNMCSjmqqRRDLEwYjO/EKjaw
   jCvADTSYiaJvpgNLj1LAM8Bnx/oPV6gDJRw9yMPMblRhgmDi9pshEgLQU
   bimn9GYY0Bk5N+HFIuSfYitOXY0z35VXZhkpWnMdpnqAaCwFF/mzmHyWw
   w==;
X-CSE-ConnectionGUID: pSGAm8GjTQi2JD98LckoYA==
X-CSE-MsgGUID: axF+3lsURmWyQqQ3f/fT4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878265"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878265"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
X-CSE-ConnectionGUID: TMAA3DQuTy+PsiYb/xgeFg==
X-CSE-MsgGUID: iyNJRNX6TpWqmZwo0USwOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457214"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Alan Previn <alan.previn.teres.alexis@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH 6.11 10/31] drm/xe/uc: Use managed bo for HuC and GSC objects
Date: Fri, 22 Nov 2024 13:06:58 -0800
Message-ID: <20241122210719.213373-11-lucas.demarchi@intel.com>
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

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

commit 2e5d47fe7839298fa096970e184aac9bf82c3bd3 upstream.

Drmm actions are not the right ones to clean up BOs and we should use
devm instead. However, we can also instead just allocate the objects
using the managed_bo function, which will internally register the
correct cleanup call and therefore allows us to simplify the code.

While at it, switch to drmm_kzalloc for the GSC proxy allocation to
further simplify the cleanup.

Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240815230541.3828206-1-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gsc.c       | 12 +++--------
 drivers/gpu/drm/xe/xe_gsc_proxy.c | 36 ++++++-------------------------
 drivers/gpu/drm/xe/xe_huc.c       | 19 +++++-----------
 3 files changed, 14 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
index 29f96f4093918..9614d9e6617eb 100644
--- a/drivers/gpu/drm/xe/xe_gsc.c
+++ b/drivers/gpu/drm/xe/xe_gsc.c
@@ -450,11 +450,6 @@ static void free_resources(void *arg)
 		xe_exec_queue_put(gsc->q);
 		gsc->q = NULL;
 	}
-
-	if (gsc->private) {
-		xe_bo_unpin_map_no_vm(gsc->private);
-		gsc->private = NULL;
-	}
 }
 
 int xe_gsc_init_post_hwconfig(struct xe_gsc *gsc)
@@ -474,10 +469,9 @@ int xe_gsc_init_post_hwconfig(struct xe_gsc *gsc)
 	if (!hwe)
 		return -ENODEV;
 
-	bo = xe_bo_create_pin_map(xe, tile, NULL, SZ_4M,
-				  ttm_bo_type_kernel,
-				  XE_BO_FLAG_STOLEN |
-				  XE_BO_FLAG_GGTT);
+	bo = xe_managed_bo_create_pin_map(xe, tile, SZ_4M,
+					  XE_BO_FLAG_STOLEN |
+					  XE_BO_FLAG_GGTT);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
diff --git a/drivers/gpu/drm/xe/xe_gsc_proxy.c b/drivers/gpu/drm/xe/xe_gsc_proxy.c
index aa812a2bc3edb..8f880c44211d0 100644
--- a/drivers/gpu/drm/xe/xe_gsc_proxy.c
+++ b/drivers/gpu/drm/xe/xe_gsc_proxy.c
@@ -376,27 +376,6 @@ static const struct component_ops xe_gsc_proxy_component_ops = {
 	.unbind = xe_gsc_proxy_component_unbind,
 };
 
-static void proxy_channel_free(struct drm_device *drm, void *arg)
-{
-	struct xe_gsc *gsc = arg;
-
-	if (!gsc->proxy.bo)
-		return;
-
-	if (gsc->proxy.to_csme) {
-		kfree(gsc->proxy.to_csme);
-		gsc->proxy.to_csme = NULL;
-		gsc->proxy.from_csme = NULL;
-	}
-
-	if (gsc->proxy.bo) {
-		iosys_map_clear(&gsc->proxy.to_gsc);
-		iosys_map_clear(&gsc->proxy.from_gsc);
-		xe_bo_unpin_map_no_vm(gsc->proxy.bo);
-		gsc->proxy.bo = NULL;
-	}
-}
-
 static int proxy_channel_alloc(struct xe_gsc *gsc)
 {
 	struct xe_gt *gt = gsc_to_gt(gsc);
@@ -405,18 +384,15 @@ static int proxy_channel_alloc(struct xe_gsc *gsc)
 	struct xe_bo *bo;
 	void *csme;
 
-	csme = kzalloc(GSC_PROXY_CHANNEL_SIZE, GFP_KERNEL);
+	csme = drmm_kzalloc(&xe->drm, GSC_PROXY_CHANNEL_SIZE, GFP_KERNEL);
 	if (!csme)
 		return -ENOMEM;
 
-	bo = xe_bo_create_pin_map(xe, tile, NULL, GSC_PROXY_CHANNEL_SIZE,
-				  ttm_bo_type_kernel,
-				  XE_BO_FLAG_SYSTEM |
-				  XE_BO_FLAG_GGTT);
-	if (IS_ERR(bo)) {
-		kfree(csme);
+	bo = xe_managed_bo_create_pin_map(xe, tile, GSC_PROXY_CHANNEL_SIZE,
+					  XE_BO_FLAG_SYSTEM |
+					  XE_BO_FLAG_GGTT);
+	if (IS_ERR(bo))
 		return PTR_ERR(bo);
-	}
 
 	gsc->proxy.bo = bo;
 	gsc->proxy.to_gsc = IOSYS_MAP_INIT_OFFSET(&bo->vmap, 0);
@@ -424,7 +400,7 @@ static int proxy_channel_alloc(struct xe_gsc *gsc)
 	gsc->proxy.to_csme = csme;
 	gsc->proxy.from_csme = csme + GSC_PROXY_BUFFER_SIZE;
 
-	return drmm_add_action_or_reset(&xe->drm, proxy_channel_free, gsc);
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_huc.c b/drivers/gpu/drm/xe/xe_huc.c
index bec4366e55138..f5459f97af23f 100644
--- a/drivers/gpu/drm/xe/xe_huc.c
+++ b/drivers/gpu/drm/xe/xe_huc.c
@@ -43,14 +43,6 @@ huc_to_guc(struct xe_huc *huc)
 	return &container_of(huc, struct xe_uc, huc)->guc;
 }
 
-static void free_gsc_pkt(struct drm_device *drm, void *arg)
-{
-	struct xe_huc *huc = arg;
-
-	xe_bo_unpin_map_no_vm(huc->gsc_pkt);
-	huc->gsc_pkt = NULL;
-}
-
 #define PXP43_HUC_AUTH_INOUT_SIZE SZ_4K
 static int huc_alloc_gsc_pkt(struct xe_huc *huc)
 {
@@ -59,17 +51,16 @@ static int huc_alloc_gsc_pkt(struct xe_huc *huc)
 	struct xe_bo *bo;
 
 	/* we use a single object for both input and output */
-	bo = xe_bo_create_pin_map(xe, gt_to_tile(gt), NULL,
-				  PXP43_HUC_AUTH_INOUT_SIZE * 2,
-				  ttm_bo_type_kernel,
-				  XE_BO_FLAG_SYSTEM |
-				  XE_BO_FLAG_GGTT);
+	bo = xe_managed_bo_create_pin_map(xe, gt_to_tile(gt),
+					  PXP43_HUC_AUTH_INOUT_SIZE * 2,
+					  XE_BO_FLAG_SYSTEM |
+					  XE_BO_FLAG_GGTT);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
 	huc->gsc_pkt = bo;
 
-	return drmm_add_action_or_reset(&xe->drm, free_gsc_pkt, huc);
+	return 0;
 }
 
 int xe_huc_init(struct xe_huc *huc)
-- 
2.47.0


