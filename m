Return-Path: <stable+bounces-116426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 446BFA36022
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 15:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E6216F711
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4A5265CAD;
	Fri, 14 Feb 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StByD+SL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B43245002
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542748; cv=none; b=Fby0L8WwwUm8K8JhbEMatVEOGXuxZ9xTiBNNPjJ+3Oc6lV5gSna9cXIToH8zOYTreyuiMwH2tgYnbiYtidwuhkK97n0A8/JHPVnjSs2Hrv4Hy/Yw7MD89Ux/LPLMPMVU4XQ17iBXHsvJDuCRpjOQteh+FvpyX1NQdtHAQkxtvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542748; c=relaxed/simple;
	bh=8aOrwWx4Z/wQIBdiIqNxIrebV6N3+rO90d7LtuuH6pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqp76gAsaWEqGAq7xEZaYtQH6jAAiDchh+6aHXA/9zSjdfGCGTUeE8YUq4ODvmxYSrpNkym0TAQxZrUYhl1HQo/BNwYJ6H6DF2fzTbrff24dDnMelH2x14sGVEfK9uiZ9qtkpsxhDWZ2t9KvVIq5dJnw1beSReaxt7HsC0tqemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StByD+SL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739542747; x=1771078747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8aOrwWx4Z/wQIBdiIqNxIrebV6N3+rO90d7LtuuH6pA=;
  b=StByD+SL9KHeuZ+E22mnnsRPFr5Xhpj9wC982pxOEqpCtnXY76DSBlme
   yUXcDkquOtkcalVycslp97Y3mPU2rxtjttMfS/W7vznXfPs6zyg/UjL4U
   0StZlhO6VJjyzxHGvFF7+1K7rpjwpjlK5chWTRiW9iPFrbMC3bQRtUX3A
   G42SW9kirPH31jBazavTXVVh8sD/Au15u7rNmLaSW7x8EjAAx0ijjUZJ+
   m9HSWYARE7s8LFrdIQ7FG/9e7fiSzigrfe0+shvwzCOeP5xDbjmEbsNll
   8PBsEjFd0MMYy+FgG7RY5qDgkZFs74tCJn75NooEYjQfM8yft1KPphycb
   A==;
X-CSE-ConnectionGUID: C4XMeih7TNeFF1KZa9E1sw==
X-CSE-MsgGUID: H0uEkcH2TuWDFUlF1YGUqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40217706"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40217706"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:19:05 -0800
X-CSE-ConnectionGUID: TsH9+hTDR4eOVeHKPLcKIA==
X-CSE-MsgGUID: S4zkhH13S4OZppsHDtb+KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136694241"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 06:19:04 -0800
From: Imre Deak <imre.deak@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 02/11] drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
Date: Fri, 14 Feb 2025 16:19:52 +0200
Message-ID: <20250214142001.552916-3-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20250214142001.552916-1-imre.deak@intel.com>
References: <20250214142001.552916-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the port width programming in the DDI_BUF_CTL register on MTLP+,
where this had an off-by-one error.

Cc: <stable@vger.kernel.org> # v6.5+
Fixes: b66a8abaa48a ("drm/i915/display/mtl: Fill port width in DDI_BUF_/TRANS_DDI_FUNC_/PORT_BUF_CTL for HDMI")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 2 +-
 drivers/gpu/drm/i915/i915_reg.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 5433279227e18..5ef7857a893f8 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3511,7 +3511,7 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 		intel_de_rmw(dev_priv, XELPDP_PORT_BUF_CTL1(dev_priv, port),
 			     XELPDP_PORT_WIDTH_MASK | XELPDP_PORT_REVERSAL, port_buf);
 
-		buf_ctl |= DDI_PORT_WIDTH(lane_count);
+		buf_ctl |= DDI_PORT_WIDTH(crtc_state->lane_count);
 
 		if (DISPLAY_VER(dev_priv) >= 20)
 			buf_ctl |= XE2LPD_DDI_BUF_D2D_LINK_ENABLE;
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 670cd2371f947..3eea191f20175 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -3639,7 +3639,7 @@ enum skl_power_gate {
 #define  DDI_BUF_IS_IDLE			(1 << 7)
 #define  DDI_BUF_CTL_TC_PHY_OWNERSHIP		REG_BIT(6)
 #define  DDI_A_4_LANES				(1 << 4)
-#define  DDI_PORT_WIDTH(width)			(((width) - 1) << 1)
+#define  DDI_PORT_WIDTH(width)			(((width) == 3 ? 4 : ((width) - 1)) << 1)
 #define  DDI_PORT_WIDTH_MASK			(7 << 1)
 #define  DDI_PORT_WIDTH_SHIFT			1
 #define  DDI_INIT_DISPLAY_DETECTED		(1 << 0)
-- 
2.44.2


