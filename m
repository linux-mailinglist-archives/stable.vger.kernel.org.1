Return-Path: <stable+bounces-76710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A797BFBF
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E681C21765
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4056C1C9874;
	Wed, 18 Sep 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnHlqEYI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BB1ACE0F
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680965; cv=none; b=HdgDZBfN8l5kU6rnRJjj/WFL7ALTu9DoIbcux/KDpLSlitKvPeHkpwkzzxhr0a+s+sumdeKpz5es5M6YXjFP4ySs96YcbjYWuCOQECoJlBfXNRoYcV5PjbllSeCup/m1U3iXUig6CysxkXi941d83KTDcuAOtbelucOEiSbVXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680965; c=relaxed/simple;
	bh=3OIdegb10eXY2CD8wMgFajYfkbkdgnvx0PT2jNwnyng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZlqwkODMOwdlRuDspEmofodbVaCs73A4tq1bdAqpmGYa1ojnxy8kOH2v0TmAdi9Wv6PzbHlHZt1wT1Aw8KGo31GaxgX2CzSYXUyU5F/02U8XqsGqNDtO8fPO520yHHirALXdsQasJ1GM4lFEN4mJ60x2YcOHmdMi6OV7HUtHALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnHlqEYI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726680963; x=1758216963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OIdegb10eXY2CD8wMgFajYfkbkdgnvx0PT2jNwnyng=;
  b=EnHlqEYIw/zzFSzfJFcsn8q2MqR2ctLezZP935f4i5X09ht0WkNU883L
   P5FbRwfRAS6aUL1/AhfmWBrvjaTwpArQLuWlMKkX/KrZnklXk1WW8ZWB3
   5R4URLv9SpDFYoTXd4Z7hpKVOtc8gQEthU5J2SajQb5taAOTBSnDjCVV8
   J26gjZsz6vsoVK8152wpDcdJQo1ld01it+aGb5kTUyOBJ2KSU7itDWG7u
   wIWstQLumGqSui4q/w76JYudjhXgUR9etIVbYmHZmhUBDofCyzVjwFloR
   pyKs8xlPISaiZe7dgYvzbBJiM0WlhhIxFoamkcfTbNNwiBmQuZi+KKpcS
   g==;
X-CSE-ConnectionGUID: 9fafpviCSjuODg3b7N1L5g==
X-CSE-MsgGUID: f9K35SpTSRK6CV/5MNbk9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25704106"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="25704106"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 10:36:02 -0700
X-CSE-ConnectionGUID: 8xx4gfWvSpuAZipIHy/3MA==
X-CSE-MsgGUID: xaj2SEwPTVG2UU+vx+ZRxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="107102538"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 10:35:59 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/6] drm/i915/gem: fix bitwise and logical AND mixup
Date: Wed, 18 Sep 2024 20:35:43 +0300
Message-Id: <643cc0a4d12f47fd8403d42581e83b1e9c4543c7.1726680898.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1726680898.git.jani.nikula@intel.com>
References: <cover.1726680898.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND is an int, defaulting to 250. When
the wakeref is non-zero, it's either -1 or a dynamically allocated
pointer, depending on CONFIG_DRM_I915_DEBUG_RUNTIME_PM. It's likely that
the code works by coincidence with the bitwise AND, but with
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y, there's the off chance that the
condition evaluates to false, and intel_wakeref_auto() doesn't get
called. Switch to the intended logical AND.

v2: Use != to avoid clang -Wconstant-logical-operand (Nathan)

Fixes: ad74457a6b5a ("drm/i915/dgfx: Release mmap on rpm suspend")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: <stable@vger.kernel.org> # v6.1+
Reviewed-by: Matthew Auld <matthew.auld@intel.com> # v1
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> # v1
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 5c72462d1f57..b22e2019768f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -1131,7 +1131,7 @@ static vm_fault_t vm_fault_ttm(struct vm_fault *vmf)
 		GEM_WARN_ON(!i915_ttm_cpu_maps_iomem(bo->resource));
 	}
 
-	if (wakeref & CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
+	if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND != 0)
 		intel_wakeref_auto(&to_i915(obj->base.dev)->runtime_pm.userfault_wakeref,
 				   msecs_to_jiffies_timeout(CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND));
 
-- 
2.39.2


