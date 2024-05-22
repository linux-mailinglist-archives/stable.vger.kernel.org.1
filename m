Return-Path: <stable+bounces-45585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8B08CC47B
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AB61F22A96
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485F26293;
	Wed, 22 May 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESddYS4k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6881411F4
	for <stable@vger.kernel.org>; Wed, 22 May 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392916; cv=none; b=ldZzDcfCB1WrK8mVogOzjERgbcOJjzUtoo6G8j3P0oOTqERsrGC5mD7aNoNpwTRHi2bbPB6FRwSa+FHMCsPZ/YSOT0kx6TaqwD7eh86OJCIqRcuy5X1jLd7LkrhoIoL2F7ikVIZtxDp55BC+FmJ58dlcSaO8nwMd7kznFSGOa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392916; c=relaxed/simple;
	bh=c3lwhsx8v5J7zTkRHTVoheJXRrnP8JRgkqZfDTZitpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i070NPHTGbnnazZjLwwUfATco2DLqcyOG4XutUwDYTEkz2dTwBM8tyTWpiuFDtyKppjspk0TFiO5szPvLVPfHZLYbK4WJQV1TrqTIUC3vxC/TuwC9oF36CGitv1vhfya/0svpxyERCQOgjjJ5YRVLv2ZwgQUJxc14EcezJ9Boyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESddYS4k; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716392914; x=1747928914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c3lwhsx8v5J7zTkRHTVoheJXRrnP8JRgkqZfDTZitpA=;
  b=ESddYS4ka+nGesGJ6x13CeGGZK+PdwuCQIEs4rV9Oo46glIjeqSUT2+f
   AGIfj31OlYDbFJoSlVNwDIHStIQpPRGMrcUPHAvHdnByUTEgIdY1DLcbL
   DZkwBRPJorNl4NxWrZHLoFWUmwQVtsm0vxtVdRaZwbMYmYGrz53OBVKTX
   uQufqq04HRITLDL0oBpQdlHByi2P6ihcFdl1FJJKB8zQ4ZX0H0JOh+oYF
   jONf5WTBsqaKgicQ7avM0K2fg6B73+/v5u8jwV6wIpn+YsGa9AGQl3b+b
   XetFH0FPvapPhihd9qrXii9Je8C+hLAghEAyx2zM1UVx8UUhMJL+55vu3
   Q==;
X-CSE-ConnectionGUID: 5DrOe9obTwmMPVylal1ALQ==
X-CSE-MsgGUID: DK3ZTBZnSmi1smc65OS16A==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12834942"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12834942"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:48:34 -0700
X-CSE-ConnectionGUID: BUAv5LjVSTS2SOGy7XZDAQ==
X-CSE-MsgGUID: FXsbVGXPQUqUqIXrx/ZqyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37913283"
Received: from vsrini4-xps-8920.iind.intel.com ([10.99.123.50])
  by fmviesa004.fm.intel.com with ESMTP; 22 May 2024 08:48:32 -0700
From: Vidya Srinivas <vidya.srinivas@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: shawn.c.lee@intel.com,
	Vidya Srinivas <vidya.srinivas@intel.com>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Date: Wed, 22 May 2024 20:59:16 +0530
Message-Id: <20240522152916.1702614-1-vidya.srinivas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520165634.1162470-1-vidya.srinivas@intel.com>
References: <20240520165634.1162470-1-vidya.srinivas@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some scenarios, the DPT object gets shrunk but
the actual framebuffer did not and thus its still
there on the DPT's vm->bound_list. Then it tries to
rewrite the PTEs via a stale CPU mapping. This causes panic.

Suggested-by: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: stable@vger.kernel.org
Fixes: 0dc987b699ce ("drm/i915/display: Add smem fallback allocation for dpt")
Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index 3560a062d287..e6b485fc54d4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -284,7 +284,8 @@ bool i915_gem_object_has_iomem(const struct drm_i915_gem_object *obj);
 static inline bool
 i915_gem_object_is_shrinkable(const struct drm_i915_gem_object *obj)
 {
-	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE);
+	return i915_gem_object_type_has(obj, I915_GEM_OBJECT_IS_SHRINKABLE) &&
+		!obj->is_dpt;
 }
 
 static inline bool
-- 
2.34.1


