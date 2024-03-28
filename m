Return-Path: <stable+bounces-33056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70EB88F8DB
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 08:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D60296561
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2FE50279;
	Thu, 28 Mar 2024 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxSAsMsS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B523DABF3
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611300; cv=none; b=AWOM0HJDoMNww+b6D96fj+KkcJJS5M0rziqf4rxSNt8KaYzh0gEH8MGV6l4LmiT8o8YB3mG1unX3bCTqaqzppUPnDHMiZFqdD0HUJIA2yBLRBkh9Ew/FGhjXnpveVKJtP+kRKrkXXjd+D7qdTdIxefmvIpfLB9YLbNKujmz5byE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611300; c=relaxed/simple;
	bh=XTFPaTmXSta6mgFUckkxJnipFhHYQtbRcrwp6ptz84Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OB6mbYoWqCN4YBFsvpfxiWtELa3FB0oneu7bmCFO84XusqWMfTUY646KGl8W08tC5URrWPdCgNGvuEMpGoekQP7k3HrYklNxgkqDyg+GsEBZRZf/jUoq9jRpxBN3tWNTO7B8n0uvL4d6Rezn+yZcqJAeBO3vCGMfi9yroG2YytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxSAsMsS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711611298; x=1743147298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XTFPaTmXSta6mgFUckkxJnipFhHYQtbRcrwp6ptz84Y=;
  b=DxSAsMsSO6DPL1dzSBE+/Oh9MYP972DCu/lQ2p8N3A9o5yXIQYemEdeK
   jZr5E2Li5pg7mOYiwPIAkm8FOmijLhoHcE86T37+UN8AbWpIrDq/VnATS
   CPcNKJ1unfdcCoRn2nvulI0gpz1idPY/pYrJP8wQDj7du9pnaTfCDW5zi
   2AWK/k87s4Bgd8/CNXarMfdrBPnpBCpJDLdqzIKtRd1stALsX1TtwhH/z
   /n2bpD0ijibVbglg59A7NaeD48BeixLmTHxs4ugsE8Q2tIKkuTSHlqAAV
   NsEpW1iIk12UIvmPMk2Unn7uT8YRAbZ9mSDAXyzZTPLmU359p6kWFGSq3
   A==;
X-CSE-ConnectionGUID: uPU8djg9QR+afA4dHHexgg==
X-CSE-MsgGUID: 9ig6eFPLQo6jspU1GUr72Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10555537"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="10555537"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="16568519"
Received: from unknown (HELO intel.com) ([10.247.118.221])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:34:50 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH v8 2/3] drm/i915/gt: Do not generate the command streamer for all the CCS
Date: Thu, 28 Mar 2024 08:34:04 +0100
Message-ID: <20240328073409.674098-3-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328073409.674098-1-andi.shyti@linux.intel.com>
References: <20240328073409.674098-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want a fixed load CCS balancing consisting in all slices
sharing one single user engine. For this reason do not create the
intel_engine_cs structure with its dedicated command streamer for
CCS slices beyond the first.

Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: <stable@vger.kernel.org> # v6.2+
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index 476651bd0a21..8c44af1c3451 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -874,6 +874,23 @@ static intel_engine_mask_t init_engine_mask(struct intel_gt *gt)
 		info->engine_mask &= ~BIT(GSC0);
 	}
 
+	/*
+	 * Do not create the command streamer for CCS slices beyond the first.
+	 * All the workload submitted to the first engine will be shared among
+	 * all the slices.
+	 *
+	 * Once the user will be allowed to customize the CCS mode, then this
+	 * check needs to be removed.
+	 */
+	if (IS_DG2(gt->i915)) {
+		u8 first_ccs = __ffs(CCS_MASK(gt));
+
+		/* Mask off all the CCS engine */
+		info->engine_mask &= ~GENMASK(CCS3, CCS0);
+		/* Put back in the first CCS engine */
+		info->engine_mask |= BIT(_CCS(first_ccs));
+	}
+
 	return info->engine_mask;
 }
 
-- 
2.43.0


