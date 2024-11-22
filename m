Return-Path: <stable+bounces-94652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 519779D6527
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E67BFB23025
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DB18784C;
	Fri, 22 Nov 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/QzkRjv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF401DF98A
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309670; cv=none; b=RH8eobIdh/Dtira79dO0myh29FcRGtqi1rk5PShm/d5vWVgy5VKybcBMJIeOHlyiaJv16ieK2yeQq4wo3OiVrquxsm5ojK+Osqtf00yjnnyHIMewpJpsgRffAHReZDutsDylSp8JzURB45Seb2bF7kZmryC/RsUJnnhc4be2oCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309670; c=relaxed/simple;
	bh=8rdMuLlHV3jR78Xg3NESVfp9QQ+SOQjTGVv9YjTDm7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShQJfK6mmZJbdAIc20zjK4Cy6LrGzsa0WrvkR86bQT4yclwc/bGRaRv3BIXy6Rnl5f+8eMbDfSIqd6bihfGn5dW/9N6SGViLXnsTnk6+ARb2rPA11Sm+yfbUfXN2NdvoHW4w8oc2RqxWHYA5wOpLyFxwcl//rtVORDDrkUkQooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/QzkRjv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309668; x=1763845668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rdMuLlHV3jR78Xg3NESVfp9QQ+SOQjTGVv9YjTDm7A=;
  b=S/QzkRjvbu1dPpgCVayI9hiRPVumSS2U+94icyCenp4eSzn8lfLKMUvr
   cLrV4sv2ANtXBMPgrv0u2i0gvkZz+1nDS7Oj6PXZbzwPa1hDaR+r/hP+1
   e8G7zEgrb+oIAMYs29nN67z4vSaE/fUetOFKfHDYvPUr+1ppvEQNK10CK
   9bdezjCvUIxgbaCfDCARPwpuIdBslnvsTAMH0sQ7QvOIUjwhzJVy2DDg9
   wFgs0ZPny6LTOR/K+8Sx3kk8XXXwzEGgJ2ma/93Qv7Hk0Na77yoAmcDJ6
   dnPHd5qRNcAnqqo5uuh8YUU6b4sKSZQYHSFQ+fUESw2JR+2x0dpCYj35O
   g==;
X-CSE-ConnectionGUID: wZSp3wWGTbubroo8lcA1WA==
X-CSE-MsgGUID: 1riGT16/RWKGEdqFcqIA7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878270"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878270"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
X-CSE-ConnectionGUID: 0+N0T0HoRL+LEs0NW2+F+Q==
X-CSE-MsgGUID: bW1q87gzTmubPE8QUHqrKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457230"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 14/31] drm/i915/dp: Assume panel power is off if runtime suspended
Date: Fri, 22 Nov 2024 13:07:02 -0800
Message-ID: <20241122210719.213373-15-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

commit fef0bcf72b9506019ecd5440061d7df7f50b02b0 upstream.

If the device is runtime suspended the eDP panel power is also off.
Ignore a short HPD on eDP if the device is suspended accordingly,
instead of checking the panel power state via the PPS registers for the
same purpose. The latter involves runtime resuming the device
unnecessarily, in a frequent scenario where the panel generates a
spurious short HPD after disabling the panel power and the device is
runtime suspended.

Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241009194358.1321200-2-imre.deak@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c                   | 5 ++++-
 drivers/gpu/drm/i915/intel_runtime_pm.h                   | 8 +++++++-
 drivers/gpu/drm/xe/compat-i915-headers/intel_runtime_pm.h | 8 ++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 4ec724e8b2207..31cec30079509 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -82,6 +82,7 @@
 #include "intel_pch_display.h"
 #include "intel_pps.h"
 #include "intel_psr.h"
+#include "intel_runtime_pm.h"
 #include "intel_quirks.h"
 #include "intel_tc.h"
 #include "intel_vdsc.h"
@@ -6408,7 +6409,9 @@ intel_dp_hpd_pulse(struct intel_digital_port *dig_port, bool long_hpd)
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
 
 	if (dig_port->base.type == INTEL_OUTPUT_EDP &&
-	    (long_hpd || !intel_pps_have_panel_power_or_vdd(intel_dp))) {
+	    (long_hpd ||
+	     intel_runtime_pm_suspended(&i915->runtime_pm) ||
+	     !intel_pps_have_panel_power_or_vdd(intel_dp))) {
 		/*
 		 * vdd off can generate a long/short pulse on eDP which
 		 * would require vdd on to handle it, and thus we
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.h b/drivers/gpu/drm/i915/intel_runtime_pm.h
index de3579d399e18..335d536c441b4 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.h
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.h
@@ -97,10 +97,16 @@ intel_rpm_wakelock_count(int wakeref_count)
 	return wakeref_count >> INTEL_RPM_WAKELOCK_SHIFT;
 }
 
+static inline bool
+intel_runtime_pm_suspended(struct intel_runtime_pm *rpm)
+{
+	return pm_runtime_suspended(rpm->kdev);
+}
+
 static inline void
 assert_rpm_device_not_suspended(struct intel_runtime_pm *rpm)
 {
-	WARN_ONCE(pm_runtime_suspended(rpm->kdev),
+	WARN_ONCE(intel_runtime_pm_suspended(rpm),
 		  "Device suspended during HW access\n");
 }
 
diff --git a/drivers/gpu/drm/xe/compat-i915-headers/intel_runtime_pm.h b/drivers/gpu/drm/xe/compat-i915-headers/intel_runtime_pm.h
index 8c7b315aa8acd..ab4455e869dc2 100644
--- a/drivers/gpu/drm/xe/compat-i915-headers/intel_runtime_pm.h
+++ b/drivers/gpu/drm/xe/compat-i915-headers/intel_runtime_pm.h
@@ -20,6 +20,14 @@ static inline void enable_rpm_wakeref_asserts(void *rpm)
 {
 }
 
+static inline bool
+intel_runtime_pm_suspended(struct xe_runtime_pm *pm)
+{
+	struct xe_device *xe = container_of(pm, struct xe_device, runtime_pm);
+
+	return pm_runtime_suspended(xe->drm.dev);
+}
+
 static inline intel_wakeref_t intel_runtime_pm_get(struct xe_runtime_pm *pm)
 {
 	struct xe_device *xe = container_of(pm, struct xe_device, runtime_pm);
-- 
2.47.0


