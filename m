Return-Path: <stable+bounces-87990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C59ADA8B
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD40282D4C
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF1B16D9BF;
	Thu, 24 Oct 2024 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrzmTTgj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB41166F3A
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741140; cv=none; b=EB9GZ2ermdAEYb72yAGT8fGPp1HdhxdF9qBAIqqTfdZ0ubIaCcOuK385iAcWRKkI24B91ZIFZ0yOtNelNpmVaA5bBymhc8JRVmUxSr24aRy4EvSuF53WWRsbAT4dRBiuo3HOKOyHyYBbUyRUxanSs82dBO4eP8BruRKyxLHegC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741140; c=relaxed/simple;
	bh=aX8QQ93uVxQRM3mQrcl16YuQOIN4BhZ9Zru2FShEU2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2V78z9opEXB2vibbjz+w2GvEOIWPgoGm5kqC6Y22jg/R3cdT1h4VXb3ZUgfeT70BhoWNNWGAKROoQ5F97bsp4E403BUWDaL4FUfHj5T5p85HCggHjYsMygXWSSPLHlIZ7cCIOCUo2mDTL6+hVDKmV4d+1hHRg0rn3nV8ST/AvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrzmTTgj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741138; x=1761277138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aX8QQ93uVxQRM3mQrcl16YuQOIN4BhZ9Zru2FShEU2c=;
  b=SrzmTTgj++wBZBGSW2JBe1VtGjGMH65jN+OgrIwu5oRq63o3y4hv0tKB
   HrnIw8+3fRgtrGCvCwzvoxoMUgIwfCpd1KcnVWZkkhbWhBUUGU2R0NlgD
   ucqIpIVC21+ZJyfbWF8z7ofDnrI+OYMgH8kMrhwrhnApk3S1M/0zZbqKu
   rYAbH+gGEfM7OeIZoYpiYC8dGgYX8gfarAGk7kchBLFJcFQRWwO3V2pA1
   kQV8RDVEGjH0009EEULyF9ib1pJnV7tKFcxw6vuDVvZ1FrzNNw0yd3294
   NsYtNts3yTe0i8/NNrUDlhuGut24jrz9WXcAt0qeWsfvvT4rhQn2u6IGJ
   w==;
X-CSE-ConnectionGUID: 8d0MSWRkQbuVqI9S7fqgzg==
X-CSE-MsgGUID: ZfL77aYYRM+nHGbwz5We7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264996"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264996"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:52 -0700
X-CSE-ConnectionGUID: RxU4Em8JQqmnBq4QyjyA/g==
X-CSE-MsgGUID: Xxs0itFpT8u5XLU7GVqJKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384968"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH xe-i915-for-6.11 11/22] drm/xe/display: drop unused rawclk_freq and RUNTIME_INFO()
Date: Wed, 23 Oct 2024 20:38:03 -0700
Message-ID: <20241024033815.3538736-11-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

commit f15e5587448989a55cf8b4feaad0df72ca3aa6a0 upstream.

With rawclk_freq moved to display runtime info, xe has no users left for
them.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/9f09274bddc14f555c0102f37af6df23b4433102.1724144570.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h | 1 -
 drivers/gpu/drm/xe/xe_device_types.h              | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h b/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
index 1f1ad4d3ef517..a7d2061339223 100644
--- a/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
+++ b/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
@@ -116,7 +116,6 @@ struct i915_sched_attr {
 #define i915_gem_fence_wait_priority(fence, attr) do { (void) attr; } while (0)
 
 #define pdev_to_i915 pdev_to_xe_device
-#define RUNTIME_INFO(xe)		(&(xe)->info.i915_runtime)
 
 #define FORCEWAKE_ALL XE_FORCEWAKE_ALL
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index a7c7812d57915..ebdb6f2d1ca7c 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -297,12 +297,6 @@ struct xe_device {
 		u8 has_atomic_enable_pte_bit:1;
 		/** @info.has_device_atomics_on_smem: Supports device atomics on SMEM */
 		u8 has_device_atomics_on_smem:1;
-
-#if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
-		struct {
-			u32 rawclk_freq;
-		} i915_runtime;
-#endif
 	} info;
 
 	/** @irq: device interrupt state */
-- 
2.47.0


