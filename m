Return-Path: <stable+bounces-25703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD686D7D8
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 00:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C161C21ABD
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 23:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474F13C9C4;
	Thu, 29 Feb 2024 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQVBtTfK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B22200BA
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249359; cv=none; b=TnCCLQqR9Klsz7TKJ0fwbQJpaptUtcGjALXEM7Us7867zxqlpgBTiqgZmLZrMGFGD97jBq+H/3Z4UMkDeO/4S9zuDShRz1pD3wdDBYWF6yYnwCSmXwJZ1T/8kXHXcjB3aHOzBRky9tm31Ip5KSsWDfOIaN3nGP5jLcPyme5DsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249359; c=relaxed/simple;
	bh=FsJg7da216jGR+DSt67oF8jsZ7fqGOUmPlzjNCsMDdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLw20jU7l37l23zqFXELZTYKV1CAPI/TaOjdSW5Dp1yEOm+uiBCLT3om+j4BfDUjHUuE/f6zxS44Qg8D4SdPdwnPVr7GeYnQmAuEeWVg3MkMiLiKsK7WBWgL9as2R38EG9qN6M3IZQlVcgiKalotrhePFzWIJ1zt4dJw9hKZrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQVBtTfK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709249359; x=1740785359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FsJg7da216jGR+DSt67oF8jsZ7fqGOUmPlzjNCsMDdU=;
  b=RQVBtTfKQVldKsuh2vCnb+eB4UxADSzYzz07QLOWeByq8BVm7awCuZiE
   CdcYsnyZkiMDvHvBJRN/bB/CKqTiQrdb4WhoiLcY8ZFXHiq5NFlNQJvTy
   Gg2jbcFWICyQJHjyXAn7ehGhMaJD+JyQaVUG5pZkgDy6FThTGwehaUJj1
   imC1ZlaH0RfYMUoOQkWPm6vt2gLF6eeYZtFTmzOxUp6zavT9/qO7KkhOO
   +jiyalvFTnIwLMjK2kPeZpwik1AXZ4BSRvr98TQt6bBwmWp0qOkljAK1Q
   +feMxFlI27Upbg0l92Vv2EHpGjqiUomn6URO4AyzkerLNyPPBnQvFGSSW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="15201217"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="15201217"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 15:29:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="45544060"
Received: from syhu-mobl2.ccr.corp.intel.com (HELO intel.com) ([10.94.248.193])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 15:29:14 -0800
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
Subject: [PATCH v3 2/4] drm/i915/gt: Do not exposed fused off engines.
Date: Fri,  1 Mar 2024 00:28:57 +0100
Message-ID: <20240229232859.70058-3-andi.shyti@linux.intel.com>
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

Some of the CCS engines are disabled. They should not be listed
in the uabi_engine list, that is the list of engines that the
user can see.

Fixes: d2eae8e98d59 ("drm/i915/dg2: Drop force_probe requirement")
Requires: 4e4f77d74878 ("drm/i915/gt: Refactor uabi engine class/instance list creation")
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_engine_user.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/drm/i915/gt/intel_engine_user.c
index cf8f24ad88f6..ec5bcd1c1ec4 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
@@ -244,6 +244,18 @@ void intel_engines_driver_register(struct drm_i915_private *i915)
 		if (uabi_class > I915_LAST_UABI_ENGINE_CLASS)
 			continue;
 
+		/*
+		 * If the CCS engine is fused off, the corresponding bit
+		 * in the engine mask is disabled. Do not expose it
+		 * to the user.
+		 *
+		 * By default at least one engine is enabled (check
+		 * the engine_mask_apply_compute_fuses() function.
+		 */
+		if (!(engine->gt->info.engine_mask &
+		      BIT(_CCS(engine->uabi_instance))))
+			continue;
+
 		GEM_BUG_ON(uabi_class >=
 			   ARRAY_SIZE(i915->engine_uabi_class_count));
 		i915->engine_uabi_class_count[uabi_class]++;
-- 
2.43.0


