Return-Path: <stable+bounces-20277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E71085652C
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 15:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F5D1C23EF1
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829C7130ADA;
	Thu, 15 Feb 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIiaM9XT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A512FF7C
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005621; cv=none; b=jWC9gS50xLbtu5lND+A7nv04JEvKxBMYBxFM365u5P5Xrfuel+I5gecGnhGLGrUIV1sVO6pLrfbgskFezh/Pr2frE3T63sFtEh5pGEF85+7X+szee4YS1e2GjLu1t+y82QuaRxv9fFn8EM8TaOBJV7IGGcldkgJjzux849mOh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005621; c=relaxed/simple;
	bh=HPtiP7PZxZwC5GGDZKuHaMs0/IGLQ0pcFgPpdFKI2tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R29cL800UF9f2xZQ+vOUWIG4MAftPGps4H/SQrSaEiJhGeUZ8t+DLUuRa8uFLtt0ipH35HfzD1hBI1ExHfQb9tcckYn45q0RBSAbWbFqV3TlOTijNv2VjnPR7xhoNZZsug8+pWZgZa7vhn0XmPpqWTdt5Qy9WjPiY02Rhqviiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIiaM9XT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708005620; x=1739541620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPtiP7PZxZwC5GGDZKuHaMs0/IGLQ0pcFgPpdFKI2tg=;
  b=VIiaM9XTh6c081J7EH1Uld6BcERzZJiq7LYba1MCGrdmPxv/lCOna7iy
   0HtI3eEJGVPk1TVhwH9Z4RTenK2woBTOkRW/tIOI+EMA/S8zGzJJ7SqUE
   Iaw+kfx3+NbS2lMzLx4Mm6Mrep/HlI9WB7BqFwF9N0yEAYVMQyWDucT9t
   cxsDt2hJDjYdWE0D+6Saam/IQLjrDnfcM5gjiG+jMcQVyAYL1SLT4pXLN
   Bt8MtaEMvddoBXozXscTEEpB0gXjnutfOWpBKpU7bs2uHgn+z28457y6M
   UwFhcYaHNFd4GAvOTjK27FvxyZ+iwF7ReCF7scbs2IhPWG+mzEstXbww1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5061177"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5061177"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:00:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8188588"
Received: from yspisare-mobl2.ger.corp.intel.com (HELO intel.com) ([10.246.50.215])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:00:17 -0800
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 1/2] drm/i915/gt: Disable HW load balancing for CCS
Date: Thu, 15 Feb 2024 14:59:23 +0100
Message-ID: <20240215135924.51705-2-andi.shyti@linux.intel.com>
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

The hardware should not dynamically balance the load between CCS
engines. Wa_16016805146 recommends disabling it across all
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
index d67d44611c28..7f42c8015f71 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -2988,6 +2988,12 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 		wa_mcr_masked_en(wal, GEN8_HALF_SLICE_CHICKEN1,
 				 GEN7_PSD_SINGLE_PORT_DISPATCH_ENABLE);
 	}
+
+	/*
+	 * Wa_16016805146: disable the CCS load balancing
+	 * indiscriminately for all the platforms
+	 */
+	wa_masked_en(wal, GEN12_RCU_MODE, XEHP_RCU_MODE_FIXED_SLICE_CCS_MODE);
 }
 
 static void
-- 
2.43.0


