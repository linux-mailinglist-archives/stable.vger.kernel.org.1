Return-Path: <stable+bounces-119384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D85A4269A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B7E3A57AE
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8417825D55F;
	Mon, 24 Feb 2025 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3804qaK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79FE25D536
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411019; cv=none; b=IgDiSlsKRNDrhFghFPZ8yGArn+VzomfeLpZTgrP12H7VBAGVxNNSsJWTdwkBZi2+3qc/0xpRfeyc3x4fkg3YwzRoE9vPyBJcDnsy7aXM5mHW7FINtz+WNrNlVye8LTI/Mm8uv17FblLXF71NH0kAqP7vFcFPA6akwAA4X5iz/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411019; c=relaxed/simple;
	bh=7aMexjIRiIRDgftGbrbJ19epzKhZUjNcqhG49F+Gbw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4KSjau9pzfnGfUc+1/r55h21o7o7iinjEbe+Z4vbrcWoMAIrwb+C10jE6o3JItsZg7QeA8QR1fKpKVDrHtGnSsqS7ErWdFPlRLs6HwNzrWgj75CPEHPz/H4kTsX6a2D+JEkBTAk+/WQb119DHeTvDjL6U0cfG9m9o0+kTP23Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3804qaK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740411018; x=1771947018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7aMexjIRiIRDgftGbrbJ19epzKhZUjNcqhG49F+Gbw4=;
  b=I3804qaKjGQnudYtIULuig1ouhmUWN0tLt7XOXPg5J4dFNGhk+jCsAbO
   9yaasfzcCWvLW90XGNtCBPaFvt+1mh0z7XWPEr6lCFWdofmwochMh4hsP
   p8gkxzBwdiKyzn77MLMlMJovg2+4X8lYctrWljDs4EMszS4ssAZviWUL0
   aaq5PDNDJnCCtISdNoY2bHi0kuWhBQM+6weIAPDaxiR4+4Bbb7SR+8oSK
   XdaHMtOcNAZgatdh69x7TwFVTezyTNVfwBFsG/eXgc7SuMH3LyZTF1eBM
   GrCbGGwpoOcoJRjUa+0l5Or7DG/nXaySLkdqhuif1ch/beT/euMN+pJ0d
   Q==;
X-CSE-ConnectionGUID: pzrWjZzyQFqf4jEYyyj63Q==
X-CSE-MsgGUID: oaL4JaWdTFaJW70DBrYTog==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40358255"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40358255"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:30:13 -0800
X-CSE-ConnectionGUID: vKgegw9TRte2o7hRsvjA1g==
X-CSE-MsgGUID: CKMt0yPtRKGM9hBBXzQ5jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116594675"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:30:11 -0800
From: Imre Deak <imre.deak@intel.com>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.6.y] drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
Date: Mon, 24 Feb 2025 17:31:12 +0200
Message-ID: <20250224153112.1959486-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <2025022418-frostlike-congrats-bf0d@gregkh>
References: <2025022418-frostlike-congrats-bf0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b2ecdabe46d23db275f94cd7c46ca414a144818b upstream.

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


