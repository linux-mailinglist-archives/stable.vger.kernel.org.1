Return-Path: <stable+bounces-33004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF72088EA0A
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6844C298EA4
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3644F20C;
	Wed, 27 Mar 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9SAWM2v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D5E4503E
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555063; cv=none; b=f3dqC1LLUatNGrRHh3B70nC2klJQiOWK0GYlZTYJGUA+tiG6dB3aI+kfF7Kos/4ej2dT98FN+TqVsW2/tEitk4NsaLQymFUQAJlLCicG1lbh0Abif04fQHE8aDC4oQ1sG579gJYQ8yCYlqD6fpgSyi90BRlSe3MyZtKAoVZ1msE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555063; c=relaxed/simple;
	bh=WKS4G/JZZc32wBQOFU9VUnZxgHcH9+WC0RJw3zMDNd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNR8huVf42i1+v1eLgtP9TwelL8FgYRQDRa8t4d+UcVbgUswc1TKXul0U3ZslLIyZUDvgiZ+YHeUQG3fx77lXDPSmkbOD9bzRorSFNCTjAMdSb6KaieF23y4sN+Pw31KtoPWxLENpsfNGQYDreWxH/Gv9SuH1b3H6/ntWRseqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9SAWM2v; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711555059; x=1743091059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WKS4G/JZZc32wBQOFU9VUnZxgHcH9+WC0RJw3zMDNd8=;
  b=N9SAWM2vzAnrZkHvZjK2brgTedZgn7HmAvOEwla86ByJ5rdN2FAWecS9
   /7q6tmpWzgYb7u7VNfBDQyN6Uf0pWuSYBZsuVNN/HO7IJl/FEJfmyI8YW
   GscUrverW60KPh19n7/hsIs3zWVWnP4BKuF8oMCA/DRJ2S7B26Ro3EI3A
   AS/UADJL1F7Xxe4VSVGlhq8ZGsDL1vEFD8UKeods0cidzIsdqaoSG85Rn
   1OOKZfjij1IgLl0wHReIr8vvW9imaNUUWMBpwtPcCNtneOH29C8V+xbYm
   axE2/Ety8/Rkc8wP70ijlKRqwCR46tATAd8SC05iKBwiGKy8GRnzs9SXY
   w==;
X-CSE-ConnectionGUID: QRP6+hlsSe+ffuMaUWngtw==
X-CSE-MsgGUID: Zyb8nTrYSr+yjtGGtPr7Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="7271764"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="7271764"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16787647"
Received: from unknown (HELO intel.com) ([10.247.118.215])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:57:23 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Michal Mrozek <michal.mrozek@intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v7 2/3] drm/i915/gt: Do not generate the command streamer for all the CCS
Date: Wed, 27 Mar 2024 16:56:18 +0100
Message-ID: <20240327155622.538140-3-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327155622.538140-1-andi.shyti@linux.intel.com>
References: <20240327155622.538140-1-andi.shyti@linux.intel.com>
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
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index f553cf4e6449..47c4a69e854c 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -908,6 +908,21 @@ static intel_engine_mask_t init_engine_mask(struct intel_gt *gt)
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
+		intel_engine_mask_t first_ccs = BIT((CCS0 + __ffs(CCS_MASK(gt))));
+		intel_engine_mask_t all_ccs = CCS_MASK(gt) << CCS0;
+
+		info->engine_mask &= ~(all_ccs &= ~first_ccs);
+	}
+
 	return info->engine_mask;
 }
 
-- 
2.43.0


