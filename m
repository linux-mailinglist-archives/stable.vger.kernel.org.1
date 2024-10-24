Return-Path: <stable+bounces-87982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3689ADA80
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DF4282F3B
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84A16130C;
	Thu, 24 Oct 2024 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKtuQF7Y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602C14F9EE
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741134; cv=none; b=XGtmiGGU9vYge8yPEZGaXDds/RyTyzaDq1o+WHwYCNs8WNJ5XhvP0ewRU2k2rOs2/xfwYJHWcB8vaf1Kr7WQgpxfsZ2RahdHHwdSXdrT+CPgtVMQV58kIaqSDq0C1t5PUbbEunxdVKbaQ4ydD5mie+qpz0EtdaAz0nx9rqHeysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741134; c=relaxed/simple;
	bh=oWZxAf5gvfl5LBo+aWdhCoe4X5FRYWpxsXdCS7BGAJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cao+OhEOqEMBczXbGY+pf5UwNT1XKg2UmiqukGWje2gy48K0NYs5jNWDeHXRsYVx7Ecunky1Udc3WEnOg2XdPgPKYCZ5gUen+EQy8AKuCanbCfnrNr9HWVCXdMJx7r3AHwssEUq+kYuxKxxkWmHIVzv/0yUvJqpK4pFvdBnYyhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKtuQF7Y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741132; x=1761277132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oWZxAf5gvfl5LBo+aWdhCoe4X5FRYWpxsXdCS7BGAJU=;
  b=YKtuQF7Y7uUbwOyyuDdIKgMgw5e9VYVT83TRyRbxU1tBS9oDChTHJOkU
   u9IDf/sd+RwlqJz4oqqdUz6qjLDulqNcr25ZzYCMByHosxzy4ObWUFrUz
   cu/xoV2kRGJPMjHv5nPXRY+cEXwRWSaTQ4Z8Y1dW8Zp+5q8/GXlePnA9S
   BZYp4MBNpv5hBhHse6yBj/D5Tm3M+dJuwTuaTGFulp0NhH1RjObkQSS7S
   MXzSF15sTlka+h+57dcV+uK7R1zCHw7ow99lwPW3LjMrPSuGKqr6tvAwk
   Ifh7AI+MK5SNW5477pFSPwWQSAU3Zyl4TIF/D2EbeOn+8+oaqb5YDmOCi
   g==;
X-CSE-ConnectionGUID: XOjRu15WTYWM/arughE/aw==
X-CSE-MsgGUID: MiJDR28KSpKa/YynS5+eLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33264982"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33264982"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
X-CSE-ConnectionGUID: ENnZARAWQZe4kVk/53Vmww==
X-CSE-MsgGUID: 7qHVMIczSkS2e5XeLjhc7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384939"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:50 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Vinod Govindapillai <vinod.govindapillai@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH xe-i915-for-6.11 02/22] drm/i915: disable fbc due to Wa_16023588340
Date: Wed, 23 Oct 2024 20:37:54 -0700
Message-ID: <20241024033815.3538736-2-lucas.demarchi@intel.com>
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

From: Matthew Auld <matthew.auld@intel.com>

commit c55f79f317ab428ae6d005965bc07e37496f209f upstream.

On BMG-G21 we need to disable fbc due to complications around the WA.

v2:
 - Try to handle with i915_drv.h and compat layer. (Rodrigo)
v3:
 - For simplicity retreat back to the original design for now.
 - Drop the extra \ from the Makefile (Jani)

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Vinod Govindapillai <vinod.govindapillai@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240703124338.208220-4-matthew.auld@intel.com
[ commit dc0f1644c47e ("drm/xe: Generate oob before compiling anything")
  makes part of the change to the Makefile not needed.
  Drop that to resolve conflict. ]
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_wa.h |  8 ++++++++
 drivers/gpu/drm/i915/display/intel_fbc.c        |  6 ++++++
 drivers/gpu/drm/xe/Makefile                     |  1 +
 drivers/gpu/drm/xe/display/xe_display_wa.c      | 16 ++++++++++++++++
 4 files changed, 31 insertions(+)
 create mode 100644 drivers/gpu/drm/xe/display/xe_display_wa.c

diff --git a/drivers/gpu/drm/i915/display/intel_display_wa.h b/drivers/gpu/drm/i915/display/intel_display_wa.h
index 63201d09852c5..be644ab6ae006 100644
--- a/drivers/gpu/drm/i915/display/intel_display_wa.h
+++ b/drivers/gpu/drm/i915/display/intel_display_wa.h
@@ -6,8 +6,16 @@
 #ifndef __INTEL_DISPLAY_WA_H__
 #define __INTEL_DISPLAY_WA_H__
 
+#include <linux/types.h>
+
 struct drm_i915_private;
 
 void intel_display_wa_apply(struct drm_i915_private *i915);
 
+#ifdef I915
+static inline bool intel_display_needs_wa_16023588340(struct drm_i915_private *i915) { return false; }
+#else
+bool intel_display_needs_wa_16023588340(struct drm_i915_private *i915);
+#endif
+
 #endif
diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index 67116c9f14643..8488f82143a40 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -56,6 +56,7 @@
 #include "intel_display_device.h"
 #include "intel_display_trace.h"
 #include "intel_display_types.h"
+#include "intel_display_wa.h"
 #include "intel_fbc.h"
 #include "intel_fbc_regs.h"
 #include "intel_frontbuffer.h"
@@ -1237,6 +1238,11 @@ static int intel_fbc_check_plane(struct intel_atomic_state *state,
 		return 0;
 	}
 
+	if (intel_display_needs_wa_16023588340(i915)) {
+		plane_state->no_fbc_reason = "Wa_16023588340";
+		return 0;
+	}
+
 	/* WaFbcTurnOffFbcWhenHyperVisorIsUsed:skl,bxt */
 	if (i915_vtd_active(i915) && (IS_SKYLAKE(i915) || IS_BROXTON(i915))) {
 		plane_state->no_fbc_reason = "VT-d enabled";
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 1979614a90bdd..1ff9602a52f67 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -175,6 +175,7 @@ xe-$(CONFIG_DRM_XE_DISPLAY) += \
 	display/xe_display.o \
 	display/xe_display_misc.o \
 	display/xe_display_rps.o \
+	display/xe_display_wa.o \
 	display/xe_dsb_buffer.o \
 	display/xe_fb_pin.o \
 	display/xe_hdcp_gsc.o \
diff --git a/drivers/gpu/drm/xe/display/xe_display_wa.c b/drivers/gpu/drm/xe/display/xe_display_wa.c
new file mode 100644
index 0000000000000..68e3d1959ad6a
--- /dev/null
+++ b/drivers/gpu/drm/xe/display/xe_display_wa.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2024 Intel Corporation
+ */
+
+#include "intel_display_wa.h"
+
+#include "xe_device.h"
+#include "xe_wa.h"
+
+#include <generated/xe_wa_oob.h>
+
+bool intel_display_needs_wa_16023588340(struct drm_i915_private *i915)
+{
+	return XE_WA(xe_root_mmio_gt(i915), 16023588340);
+}
-- 
2.47.0


