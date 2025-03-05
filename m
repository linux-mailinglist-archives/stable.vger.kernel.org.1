Return-Path: <stable+bounces-120448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F540A503BC
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 16:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B226E3A53D5
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6383C24BC17;
	Wed,  5 Mar 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqrxZkAG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E02E3362
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189432; cv=none; b=co5HviG4mnZPByDg1697oRKaRMY505ANK3nLZAYnkv5knrpCk1z6Ti7OknfcHiYmvfZpbJLBbxpWWY1eBmQFqsFFmIA++48Y2T40N604A9q13YEFaa1Sz4TsZulPD+Kya4uSfEjonejmdnT0zXWMrE4j3pAJgq07hBashwiCC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189432; c=relaxed/simple;
	bh=KHx0YicyyRJZR9PHSGqOgp9KWO9Il4YjzhTkkKWYS0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7s3q1NA7Kh+n28SQ/+Cd0f+88Y1HE81Xm+xTKZu4gsaldrHKJiPNRq5eeXz8BBXjsrtJJaSLszaCWS7NuI0h4X1Y+G1Bib+c/YLqJOzf/UwD0+UpYgZhsA/3dTQag3nl8g+NLpQr0vqsSP6k9123N2D0t5qoyzw/fbketNGOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqrxZkAG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741189431; x=1772725431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KHx0YicyyRJZR9PHSGqOgp9KWO9Il4YjzhTkkKWYS0M=;
  b=PqrxZkAG0DfZcQ+Uzm8SBRc4x+JvVY8+o4Wsqv1b4C/9DcQgBj6xCt7M
   Jc1PQ9yubOOPjMOBS0dOLjJucw/0LplJdZabsLXPWMPSVT2ndPcboMC0d
   ED+U/hZ2/IsBoP46xOyT4xXWqnhV18cvtY4mIqLE00qUtay4arhWCRtz8
   MDb6TARVPT2/iqPPFHQHdvdl+RH5Znz6j+VSZGmOveGTcrP2pb4oCPZ3I
   k3dxY3lqQEvuour79UlBm/7mZSZ3aeKxbP2f705oKSmrCmk91x/w0qXSv
   rpkX4BhWc++eP6RrSoBagPRTps8AdAsx0a/KGv51dm3NcCPIHHN4aSaGU
   A==;
X-CSE-ConnectionGUID: 9iDviib9Rh6xjB1Zvpoutg==
X-CSE-MsgGUID: KR/IJ6tnTum0A3p+HRtIsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41407815"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="41407815"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:43:50 -0800
X-CSE-ConnectionGUID: TIx1Y3L2R323nlP+qP/b1g==
X-CSE-MsgGUID: nMyduyocQ/SIrYgVjQm8Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123753845"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:43:48 -0800
From: Imre Deak <imre.deak@intel.com>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 2/2] drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
Date: Wed,  5 Mar 2025 17:43:46 +0200
Message-ID: <20250305154346.3565096-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <2025022456-vintage-hunter-6136@gregkh>
References: <2025022456-vintage-hunter-6136@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 166ce267ae3f96e439d8ccc838e8ec4d8b4dab73 upstream.

Fix the port width programming in the DDI_BUF_CTL register on MTLP+,
where this had an off-by-one error.

Cc: <stable@vger.kernel.org> # v6.5+
Fixes: b66a8abaa48a ("drm/i915/display/mtl: Fill port width in DDI_BUF_/TRANS_DDI_FUNC_/PORT_BUF_CTL for HDMI")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250214142001.552916-3-imre.deak@intel.com
(cherry picked from commit b2ecdabe46d23db275f94cd7c46ca414a144818b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 166ce267ae3f96e439d8ccc838e8ec4d8b4dab73)
[Imre: Rebased on v6.6.y, due to upstream API changes for
 XELPDP_PORT_BUF_CTL1() and addition of the XE2LPD_DDI_BUF_D2D_LINK_ENABLE flag]
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 2 +-
 drivers/gpu/drm/i915/i915_reg.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index b347f90623494..93ad7df1fade9 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3224,7 +3224,7 @@ static void intel_enable_ddi_hdmi(struct intel_atomic_state *state,
 		intel_de_rmw(dev_priv, XELPDP_PORT_BUF_CTL1(port),
 			     XELPDP_PORT_WIDTH_MASK | XELPDP_PORT_REVERSAL, port_buf);
 
-		buf_ctl |= DDI_PORT_WIDTH(lane_count);
+		buf_ctl |= DDI_PORT_WIDTH(crtc_state->lane_count);
 	} else if (IS_ALDERLAKE_P(dev_priv) && intel_phy_is_tc(dev_priv, phy)) {
 		drm_WARN_ON(&dev_priv->drm, !intel_tc_port_in_legacy_mode(dig_port));
 		buf_ctl |= DDI_BUF_CTL_TC_PHY_OWNERSHIP;
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index aefad14ab27a4..4a50802541a39 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -5735,7 +5735,7 @@ enum skl_power_gate {
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


