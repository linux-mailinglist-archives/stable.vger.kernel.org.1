Return-Path: <stable+bounces-20278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DE6856530
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF14293F0B
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E237C13173C;
	Thu, 15 Feb 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O04ld3G3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3E12FF7C
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005627; cv=none; b=tuzPOuJPLBxQy3CgRdqXLZALAnhM129zMsC+EH1/JcP+dSUdQyrrxkzWjeo7w5OEMWG3YRHMtN5q7XqeF8ehMseC3TuZvV113h911R+e4Vch2pF8GWE1zpkGGGE4lrW1PQbVWczLOHz/IHi+Q+2jrQ50EQlwFnIdcB8haaiReo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005627; c=relaxed/simple;
	bh=Y0ur2QBKo0Pu/bQiz5HWAGjf0FMUNwl5zyZ3amcitNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBtManPIN44CETXK3234PdwY6pHA9HrDzttZzLyO5V8YLylfe2dNtdi9++PQKl2CZU8K1IuIRaJYOS2gJRiyG5KhP/7rYJWx+jkImSpjjWaA0qymBaiumX/rPGbyrolbSLluMojfjOC1SxJdt+x9SN5oz48ET4W3RaOWVXB6s7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O04ld3G3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708005626; x=1739541626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y0ur2QBKo0Pu/bQiz5HWAGjf0FMUNwl5zyZ3amcitNw=;
  b=O04ld3G3xgcjMKPPqg2fFtXaudQvrt3dpRSiFLkAx5bE67c/Qe/vW525
   OEQ8QFzpjaZUCQeL3o9L/BOJgphflHt+XXUiSFORnh6biCqT+JYNR3WAw
   cjwJr9PBFhhVlgu21u0QJg7QtWOdSQXoS48qwQOzU5veOyeFc5wcQ1CWS
   W8utq5+7wMuqFSBbdnQShrU7pC06sS7xoLkMFPXCJ6m6uq8EhzEefKEXd
   Vc39x5zMnZBljc2ki/ta1kmLneVFZj4GTPho4nasgKSDY+5pBFq5Ri1DJ
   6D1wkWUsOPkXzY8FPCWRFkveYFxBbKThgoURW54w7tFBk4zPB+hBpgX5A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5920233"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5920233"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:00:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912169849"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912169849"
Received: from yspisare-mobl2.ger.corp.intel.com (HELO intel.com) ([10.246.50.215])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:00:22 -0800
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 2/2] drm/i915/gt: Set default CCS mode '1'
Date: Thu, 15 Feb 2024 14:59:24 +0100
Message-ID: <20240215135924.51705-3-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215135924.51705-1-andi.shyti@linux.intel.com>
References: <20240215135924.51705-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since CCS automatic load balancing is disabled, we will impose a
fixed balancing policy that involves setting all the CCS engines
to work together on the same load.

Simultaneously, the user will see only 1 CCS rather than the
actual number. As of now, this change affects only DG2.

Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/i915/gt/intel_gt.c      | 11 +++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h |  2 ++
 drivers/gpu/drm/i915/i915_drv.h         | 17 +++++++++++++++++
 drivers/gpu/drm/i915/i915_query.c       |  5 +++--
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index a425db5ed3a2..e19df4ef47f6 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -168,6 +168,14 @@ static void init_unused_rings(struct intel_gt *gt)
 	}
 }
 
+static void intel_gt_apply_ccs_mode(struct intel_gt *gt)
+{
+	if (!IS_DG2(gt->i915))
+		return;
+
+	intel_uncore_write(gt->uncore, XEHP_CCS_MODE, 0);
+}
+
 int intel_gt_init_hw(struct intel_gt *gt)
 {
 	struct drm_i915_private *i915 = gt->i915;
@@ -195,6 +203,9 @@ int intel_gt_init_hw(struct intel_gt *gt)
 
 	intel_gt_init_swizzling(gt);
 
+	/* Configure CCS mode */
+	intel_gt_apply_ccs_mode(gt);
+
 	/*
 	 * At least 830 can leave some of the unused rings
 	 * "active" (ie. head != tail) after resume which
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index cf709f6c05ae..c148113770ea 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1605,6 +1605,8 @@
 #define   GEN12_VOLTAGE_MASK			REG_GENMASK(10, 0)
 #define   GEN12_CAGF_MASK			REG_GENMASK(19, 11)
 
+#define XEHP_CCS_MODE                          _MMIO(0x14804)
+
 #define GEN11_GT_INTR_DW(x)			_MMIO(0x190018 + ((x) * 4))
 #define   GEN11_CSME				(31)
 #define   GEN12_HECI_2				(30)
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index e81b3b2858ac..0853ffd3cb8d 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -396,6 +396,23 @@ static inline struct intel_gt *to_gt(const struct drm_i915_private *i915)
 	     (engine__); \
 	     (engine__) = rb_to_uabi_engine(rb_next(&(engine__)->uabi_node)))
 
+/*
+ * Exclude unavailable engines.
+ *
+ * Only the first CCS engine is utilized due to the disabling of CCS auto load
+ * balancing. As a result, all CCS engines operate collectively, functioning
+ * essentially as a single CCS engine, hence the count of active CCS engines is
+ * considered '1'.
+ * Currently, this applies to platforms with more than one CCS engine,
+ * specifically DG2.
+ */
+#define for_each_available_uabi_engine(engine__, i915__) \
+	for_each_uabi_engine(engine__, i915__) \
+		if ((IS_DG2(i915__)) && \
+		    ((engine__)->uabi_class == I915_ENGINE_CLASS_COMPUTE) && \
+		    ((engine__)->uabi_instance)) { } \
+		else
+
 #define INTEL_INFO(i915)	((i915)->__info)
 #define RUNTIME_INFO(i915)	(&(i915)->__runtime)
 #define DRIVER_CAPS(i915)	(&(i915)->caps)
diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
index fa3e937ed3f5..2d41bda626a6 100644
--- a/drivers/gpu/drm/i915/i915_query.c
+++ b/drivers/gpu/drm/i915/i915_query.c
@@ -124,6 +124,7 @@ static int query_geometry_subslices(struct drm_i915_private *i915,
 	return fill_topology_info(sseu, query_item, sseu->geometry_subslice_mask);
 }
 
+
 static int
 query_engine_info(struct drm_i915_private *i915,
 		  struct drm_i915_query_item *query_item)
@@ -140,7 +141,7 @@ query_engine_info(struct drm_i915_private *i915,
 	if (query_item->flags)
 		return -EINVAL;
 
-	for_each_uabi_engine(engine, i915)
+	for_each_available_uabi_engine(engine, i915)
 		num_uabi_engines++;
 
 	len = struct_size(query_ptr, engines, num_uabi_engines);
@@ -155,7 +156,7 @@ query_engine_info(struct drm_i915_private *i915,
 
 	info_ptr = &query_ptr->engines[0];
 
-	for_each_uabi_engine(engine, i915) {
+	for_each_available_uabi_engine(engine, i915) {
 		info.engine.engine_class = engine->uabi_class;
 		info.engine.engine_instance = engine->uabi_instance;
 		info.flags = I915_ENGINE_INFO_HAS_LOGICAL_INSTANCE;
-- 
2.43.0


