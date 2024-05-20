Return-Path: <stable+bounces-45456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B421F8CA120
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 19:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 194C2B21519
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C01137747;
	Mon, 20 May 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cR7eHO6S"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA453E13
	for <stable@vger.kernel.org>; Mon, 20 May 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716225363; cv=none; b=uqNIP91WhVdWMYydwaukURGhAjmKISgupcQt3GcbULsi57tNVznlvcCwcKBSKDGmJUB/TH9ZuiPoYNzx0Ttcrh5eIN2gb6D6T9DtM+DGuQH6OthDdomQUMrNDU6KHVUMoVA7nQpUQfaBK99iHhG/OXdEhUTHJPN+6MjBTz4iyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716225363; c=relaxed/simple;
	bh=9xMXqirmrS/KjGPrHamiK+u0YLlE+Rr9VOFJSXKx134=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ai5aD3WCGxUgr34IRYcnLYTEuABScptkmTBJje4NBjvZHEA9dujksE9okScfVdaNZTV7XuuBU7bZUXYYaxvX6Va8LyudymMB6WVAZqwesOSV6lB8wecB9+pcTopVvklR/3Bb3YCEdMOxLaPMO9pQnluOOMxAToO+3P1Yr3/wOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cR7eHO6S; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716225362; x=1747761362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9xMXqirmrS/KjGPrHamiK+u0YLlE+Rr9VOFJSXKx134=;
  b=cR7eHO6SV0sF0+iB8Ewl/+Dnp+7b/RRnEQQ8j+5cnd+M0E6DCW854Ecc
   lGD18P8GEuPX1tbbvNaVpWU22u+7WxrJyBgKT1+2XebwNoVkam09lojv2
   b5lHq+VjVz0+L6K/foIDLhKU9Jq5uO1z8/oqGzZOL6TfDcqaaDX0DQZiL
   oi1GM1bQj3FdoPOBPKTJPscyQ9eeyloNtxQlQMJ1RaO6qmuvt/up056VB
   P7l98VGk/OQJAeoZystGU17X0orAjqHAfkeJICNK5u14LvtGrbTny0Tpr
   JmBNENNCcaHxDhSUbGj0P4qx3tKlhX8xBNla8bjNz+AVQe22IExx2Kf0q
   w==;
X-CSE-ConnectionGUID: CzX4t+F+T9W55Pvd1hRaDA==
X-CSE-MsgGUID: 0HU+/xYkTWK7eYUqcNURDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="22946360"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="22946360"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 10:16:01 -0700
X-CSE-ConnectionGUID: kk1BKTZtRuqV/RPERNf4jA==
X-CSE-MsgGUID: Dvmd7404QpGy7dGMIUrXjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="63840432"
Received: from vsrini4-xps-8920.iind.intel.com ([10.99.123.50])
  by fmviesa001.fm.intel.com with ESMTP; 20 May 2024 10:16:00 -0700
From: Vidya Srinivas <vidya.srinivas@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: ville.syrjala@intel.com,
	shawn.c.lee@intel.com,
	Vidya Srinivas <vidya.srinivas@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Date: Mon, 20 May 2024 22:26:34 +0530
Message-Id: <20240520165634.1162470-1-vidya.srinivas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520152410.1098393-1-vidya.srinivas@intel.com>
References: <20240520152410.1098393-1-vidya.srinivas@intel.com>
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

Credits-to: Ville Syrjala <ville.syrjala@linux.intel.com>
	    Shawn Lee <shawn.c.lee@intel.com>

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


