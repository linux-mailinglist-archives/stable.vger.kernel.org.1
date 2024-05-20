Return-Path: <stable+bounces-45455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05308CA10D
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 19:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701CD1F219C4
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B3137C2A;
	Mon, 20 May 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaUU/4oo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E33DDDA
	for <stable@vger.kernel.org>; Mon, 20 May 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224959; cv=none; b=R2Pq4y6A/4m0emZB9xjBgc4xraLzU4mM2fhG/ZUIlPl9AXqv6ZvTZtBSjtKtX+bMy2wjlxMN2lYniyXRacmxUwcrakmfJsXx9X45XOOEYnb0VnXq1Nz5SlksaojGg2cPOroPmnMQON25O1pVutYhg7xBsREejN7KLOT1blfIZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224959; c=relaxed/simple;
	bh=9xMXqirmrS/KjGPrHamiK+u0YLlE+Rr9VOFJSXKx134=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UvJ/t6RY20lkRxBqotMQkFJXJrS/KBLpKwnCvSoUA12iIzKumpIqRSlrH9pVCrTLrZNlZFMJqWd4e6nbn34M56/9RV49OfbTs42flcJ7j9bEuV2mZKJCys0lVYHfF6b/dsB2iBf5tO1rGm65NKRUrDbb6JlpxEh0J+aEkN0gI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaUU/4oo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716224957; x=1747760957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9xMXqirmrS/KjGPrHamiK+u0YLlE+Rr9VOFJSXKx134=;
  b=TaUU/4ooPeZ9FWNAR3y3lf+R67Jpr4yTfbMo6Lye2PM5ydMn2vccZkNC
   fkVzaCaXagCIlIS5qVpxHTpoASHuJpZ5ITx4WbNbKiJJeqf3/sXiNBS5x
   VP1d0nlhkB04DWzR8G6l5kSYX2kh19OdGoPLVhcYw9Im/U3IvAQzhxpL9
   QbCQsPH4JNqYDS8mIGd7UczQ0onbrw+NnIHpCJv6kK01mVEIlJexkdMUc
   3thJrnbsoDrAi0ANqp8Y6ZCFx/jl1ILSu6975/ZDFcBCA4DaWyJLT8/C9
   e/1KheJZDiHVnG4wSEqsLNuwliF0X1JayeFLO+hkVtsL0WlxidTIgpUIB
   w==;
X-CSE-ConnectionGUID: qxMH8l1YTL6acoiYNmuwBw==
X-CSE-MsgGUID: 52pnwj6UR2an8FcTCp0XWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23509386"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="23509386"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 10:09:16 -0700
X-CSE-ConnectionGUID: 91jUV6L8R6Smptn2LzEwcA==
X-CSE-MsgGUID: e1xLUIvcSvmmgTcM/Ols/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="32512805"
Received: from vsrini4-xps-8920.iind.intel.com ([10.99.123.50])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2024 10:09:15 -0700
From: Vidya Srinivas <vidya.srinivas@intel.com>
To: vidya.srinivas@intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915/dpt: Make DPT object unshrinkable
Date: Mon, 20 May 2024 22:20:05 +0530
Message-Id: <20240520165005.1162448-1-vidya.srinivas@intel.com>
X-Mailer: git-send-email 2.34.1
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


