Return-Path: <stable+bounces-5007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C86B80A208
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 12:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2A528188A
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6751A728;
	Fri,  8 Dec 2023 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ahkiwjnd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788061723
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 03:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702034421; x=1733570421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=heLHhGdJb5ogsEZx38ya6Iu2SDWm1MIvcjqACQwmS0s=;
  b=Ahkiwjnd08Um7Q17uXO6K7tc1YfjpLGx9zEF8KQzo/GSOpoxQ6fbbo0Z
   jRPIZEJz7J7fL3eWWSIhNtOf8AlOSdvGRCA/7N3n7UQOjRhVTAr8YE76P
   7JNMW45p6rOIuYD5YGotj5pPYhEHkluCTmPQ7sUZroijaVosmpkQqGo8t
   tVPSSgrG+LTpeQ8uVHyJn8zvxfBDbpM9leNA4erJM9BFNgcdHSpRC9Zre
   FPrcpzXn3caHQpMk3avN/EkscTEcm2qBDrl9VfYam1P/0/INBvtymdWxU
   ki5jQVVip2fDl5Yi4qVZGGl2IWnKrS7Ml+Jo7auO/sBtns1Yy7UcksX/f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1472951"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1472951"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:20:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721841396"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="721841396"
Received: from mvafin-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.63.236])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 03:20:17 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915: fix display ver 12-13 fault error handling
Date: Fri,  8 Dec 2023 13:20:08 +0200
Message-Id: <20231208112008.2904497-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Unless I'm completely misreading the bspec, there are no defined bits
for plane gtt fault errors in DE PIPE IIR for a display versions
12-14. This would explain why DG2 in the linked bug is getting thousands
of fault errors.

Bspec: 50335
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9769
Fixes: 99e2d8bcb887 ("drm/i915/rkl: Limit number of universal planes to 5")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v5.9+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_irq.c | 4 +++-
 drivers/gpu/drm/i915/i915_reg.h                  | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/gpu/drm/i915/display/intel_display_irq.c
index f8ed53f30b2e..7bede5b56286 100644
--- a/drivers/gpu/drm/i915/display/intel_display_irq.c
+++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
@@ -834,7 +834,9 @@ static u32 gen8_de_port_aux_mask(struct drm_i915_private *dev_priv)
 
 static u32 gen8_de_pipe_fault_mask(struct drm_i915_private *dev_priv)
 {
-	if (DISPLAY_VER(dev_priv) >= 13 || HAS_D12_PLANE_MINIMIZATION(dev_priv))
+	if (DISPLAY_VER(dev_priv) >= 14)
+		return MTL_DE_PIPE_IRQ_FAULT_ERRORS;
+	else if (DISPLAY_VER(dev_priv) >= 12)
 		return RKL_DE_PIPE_IRQ_FAULT_ERRORS;
 	else if (DISPLAY_VER(dev_priv) >= 11)
 		return GEN11_DE_PIPE_IRQ_FAULT_ERRORS;
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 27dc903f0553..fcf980694cb4 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -4354,7 +4354,8 @@
 	 GEN11_PIPE_PLANE7_FAULT | \
 	 GEN11_PIPE_PLANE6_FAULT | \
 	 GEN11_PIPE_PLANE5_FAULT)
-#define RKL_DE_PIPE_IRQ_FAULT_ERRORS \
+#define RKL_DE_PIPE_IRQ_FAULT_ERRORS	0
+#define MTL_DE_PIPE_IRQ_FAULT_ERRORS \
 	(GEN9_DE_PIPE_IRQ_FAULT_ERRORS | \
 	 GEN11_PIPE_PLANE5_FAULT)
 
-- 
2.39.2


