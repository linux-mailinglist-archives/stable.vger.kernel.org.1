Return-Path: <stable+bounces-25704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74BC86D7DD
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 00:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F2D9B2131A
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 23:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C574C03;
	Thu, 29 Feb 2024 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QemE0gVz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79D74BFE
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249364; cv=none; b=VLMYlorsuuYDlz5KbjTbdHGgtJEWRq4M3CnW0FDFW18FEJOBmGL7AnNro1ww0eJtwNsxIhLK6ON0QP/IoNbbGBuSeMSSStqLaZe/me4wFhqAYCsbNrdTY9x1jbJWhKTUYTiQrKR0uOgWatDiKH+arum222gqxxEudS/IJpLZChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249364; c=relaxed/simple;
	bh=1/JxcshBh9SfSED7bBj6dJuMtZzfhEzcLUHv5yAdcGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mo4bs4B5tvWKFigbZmB11zP4CKm6N0UF/5IPLNPdSOvTCbAPeD2qL1OGWdlw+zQumIgAGCvuGEfyjaF7kyv3g0Kb0Z12mMq5GosOg4QXK0+ksUXFCuuYNJht5CdNCFC7Asv/i9Y2frILOlNmVa0SdcXZkJ3fIqLxf7jG3KR/W0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QemE0gVz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709249363; x=1740785363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1/JxcshBh9SfSED7bBj6dJuMtZzfhEzcLUHv5yAdcGE=;
  b=QemE0gVzfvjancQ09LK7uU4EnljCp0ginYoXiIzb+1IvRRjgWdujePl4
   WKB0WRBVVOfnL8hOAgGHzV2fdAI2Thgk2buYvYcX+2/M9N3r8NBqphInc
   zHZgxjl++XGpLihDt5xhZjUH7KitHmKTP1DGmKQVO83Ow1Jcgbo+fVdt0
   uGyZq1sQ1PQw0K6jWO3p/Om2Uhdkkz99G2ewXMFyuCx8aCXqaYcemhTAk
   sjpVK/uq/CpG3yG/NYYfxzwzTTYEfY3qo0lfBiBSVZ9JAcykyA1+a5SnH
   yXs3AdVabTrNN1A0zMhh+EVlx8ulCWo+f2xjDs3ZYnJJc7pe6zaEPyCUs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="29193489"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="29193489"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 15:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38836097"
Received: from syhu-mobl2.ccr.corp.intel.com (HELO intel.com) ([10.94.248.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 15:29:19 -0800
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v3 3/4] drm/i915/gt: Disable HW load balancing for CCS
Date: Fri,  1 Mar 2024 00:28:58 +0100
Message-ID: <20240229232859.70058-4-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229232859.70058-1-andi.shyti@linux.intel.com>
References: <20240229232859.70058-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware should not dynamically balance the load between CCS
engines. Wa_14019159160 recommends disabling it across all
platforms.

Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     | 1 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 50962cfd1353..cf709f6c05ae 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1478,6 +1478,7 @@
 
 #define GEN12_RCU_MODE				_MMIO(0x14800)
 #define   GEN12_RCU_MODE_CCS_ENABLE		REG_BIT(0)
+#define   XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE	REG_BIT(1)
 
 #define CHV_FUSE_GT				_MMIO(VLV_GUNIT_BASE + 0x2168)
 #define   CHV_FGT_DISABLE_SS0			(1 << 10)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index d67d44611c28..57c1f3d2589e 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -2945,6 +2945,12 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 
 		/* Wa_18028616096 */
 		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0_UDW, UGM_FRAGMENT_THRESHOLD_TO_3);
+
+		/*
+		 * Wa_14019159160: disable the CCS load balancing
+		 * indiscriminately for all the platforms
+		 */
+		wa_masked_en(wal, GEN12_RCU_MODE, XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE);
 	}
 
 	if (IS_DG2_G11(i915)) {
-- 
2.43.0


