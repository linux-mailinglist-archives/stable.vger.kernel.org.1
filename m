Return-Path: <stable+bounces-28095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0187B2C5
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 21:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8613D1F261A5
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130324CB41;
	Wed, 13 Mar 2024 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgcyRh0i"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3121EB31
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361239; cv=none; b=kDzOcKqG2Rb4qYnhDWOG2KaG4OML/HvQNa9Ft3ZAEohQhwyHOdre8IuVpO9J4htMpMB3HFxH+HgNUwkGPUwjeBB9/UXXRWV8f8yqZqybbPmMslbHHKKvouNGCh7NxkM/Q1j36zDQt4mcOvge6T2RTRCkowhgv4/X/ewTU8o1ixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361239; c=relaxed/simple;
	bh=r5NgUsrUCXSYJV76trjm0jpWeaLmzYtmdFCDjovonxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYfmGSOivpJRloGo49Fgu4ivQfMXIqxZXGZYHKhPwOSW/zfOMps/8XLuMEsfWMPQHdfBTW2/c4z6wGh7w38zKEsIs+SswBNUNwUR660WnzhFL1thV74kzWFva501Ep0lJfc/0zXEYHpIt9UUAsms3YH7LQCXmhF92SbDRTOikto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgcyRh0i; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710361238; x=1741897238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r5NgUsrUCXSYJV76trjm0jpWeaLmzYtmdFCDjovonxA=;
  b=PgcyRh0iEgiksz0eAqxcyUBSct78hs/3hl67QRM6hTPw/ObVRiUwObBf
   Ffb/xPpPcoOTJ9xL1gVC8IKvunGOHJRsp2Ag44XXA/2pTTx9obxx+fr+M
   rb5WZV4SSdwOJkCIB7W8d0S0v8JW6bcYYiGYCO1sm11d2KomnrOAYRGO9
   ZrFHswynzuR2/Zz0jJW2SZaCdUFB6OeSsu9Cc2e8D11T3H81BJjsb2m2R
   H5JonsT9pjy7l6jVZ4MP69maPPnnaL4RpOLf8y28hIu9Dw7yfzN9HSRCY
   83/LY+2cE6PxrdoAC+V5oF2zevtPbDzOlTWtzivQiM8viQx4/s/3RXWQT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5016261"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="5016261"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 13:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="49484943"
Received: from unknown (HELO intel.com) ([10.247.118.152])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 13:20:31 -0700
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
Subject: [PATCH v6 2/3] drm/i915/gt: Do not generate the command streamer for all the CCS
Date: Wed, 13 Mar 2024 21:19:50 +0100
Message-ID: <20240313201955.95716-3-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313201955.95716-1-andi.shyti@linux.intel.com>
References: <20240313201955.95716-1-andi.shyti@linux.intel.com>
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
---
 drivers/gpu/drm/i915/gt/intel_engine_cs.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index f553cf4e6449..c4fb31bb6e72 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -966,6 +966,7 @@ int intel_engines_init_mmio(struct intel_gt *gt)
 	const unsigned int engine_mask = init_engine_mask(gt);
 	unsigned int mask = 0;
 	unsigned int i, class;
+	u8 ccs_instance = 0;
 	u8 logical_ids[MAX_ENGINE_INSTANCE + 1];
 	int err;
 
@@ -986,6 +987,19 @@ int intel_engines_init_mmio(struct intel_gt *gt)
 			    !HAS_ENGINE(gt, i))
 				continue;
 
+			/*
+			 * Do not create the command streamer for CCS slices
+			 * beyond the first. All the workload submitted to the
+			 * first engine will be shared among all the slices.
+			 *
+			 * Once the user will be allowed to customize the CCS
+			 * mode, then this check needs to be removed.
+			 */
+			if (IS_DG2(i915) &&
+			    class == COMPUTE_CLASS &&
+			    ccs_instance++)
+				continue;
+
 			err = intel_engine_setup(gt, i,
 						 logical_ids[instance]);
 			if (err)
@@ -996,11 +1010,9 @@ int intel_engines_init_mmio(struct intel_gt *gt)
 	}
 
 	/*
-	 * Catch failures to update intel_engines table when the new engines
-	 * are added to the driver by a warning and disabling the forgotten
-	 * engines.
+	 * Update the intel_engines table.
 	 */
-	if (drm_WARN_ON(&i915->drm, mask != engine_mask))
+	if (mask != engine_mask)
 		gt->info.engine_mask = mask;
 
 	gt->info.num_engines = hweight32(mask);
-- 
2.43.0


