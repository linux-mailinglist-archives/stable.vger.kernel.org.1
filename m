Return-Path: <stable+bounces-159749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44CDAF7A35
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432E53A7F24
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A72EA149;
	Thu,  3 Jul 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Etg7/Ggk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F315442C;
	Thu,  3 Jul 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555219; cv=none; b=dc8J10r7IPpMBTNAd5RJLLczjRtIWC7/d6ovlUNWuq9tygZwvWpF7aB5+9W8nHF68aLAZizpsqxilsv1YWWFoMjlfusruG0DGemj6X5E2FLph1ugtBPEyN2/sKtsUcVfW88QlJH2XVc+/wtPXkeIcyQH7Wh136rtNnftrXJSfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555219; c=relaxed/simple;
	bh=VLRdgpLacrprFmVlrM0/VeEI94SBPYVGLgS5lv0WPf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4Xm0mOemQMaIIKy42UbW4WFNP0sdWgrSDw0r7X3kulq2YVEqcx7NWU7hzzgfMQp30M5Wftql0EFBWPp0HOHDHIpRbeE756JK2NOJUrXi7Nr0Y4JVJ69KHJ8PtWNbzExXhP+LTmriBg3+a55yJND+5ywNb/RtqN+Yy+xd0+KRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Etg7/Ggk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126BAC4CEE3;
	Thu,  3 Jul 2025 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555219;
	bh=VLRdgpLacrprFmVlrM0/VeEI94SBPYVGLgS5lv0WPf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Etg7/GgkMBYgJm7N6qBiXKSLZvznGOiDRDHSO752tzk4Cm0qzQOb5YPAkpuNJ0mL0
	 lz6NDDBHDZyVEx+btHo5Ah2ktFlq31+V58y0N0EP3ZlclJKscJjGnGUrrW4a1Flzhu
	 BPq6wF/nyP6W4nRasSlnl5k+S0Kvsp8O3vvlhfno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mika Kahola <mika.kahola@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.15 212/263] drm/i915/ptl: Use everywhere the correct DDI port clock select mask
Date: Thu,  3 Jul 2025 16:42:12 +0200
Message-ID: <20250703144012.891141557@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit a38b3232d618653155032a51208e974511c151e4 upstream.

The PTL XELPDP_PORT_CLOCK_CTL register XELPDP_DDI_CLOCK_SELECT field's
size is 5 bits vs. the earlier platforms where its size is 4 bits. Make
sure the field is read-out/programmed everywhere correctly, according to
the above.

Cc: Mika Kahola <mika.kahola@intel.com>
Cc: stable@vger.kernel.org # v6.13+
Tested-by: Mika Kahola <mika.kahola@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250512142600.824347-1-imre.deak@intel.com
(cherry picked from commit d0bf684bd42db22e7d131a038f8f78927fa6a72a)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c      |   27 ++++++++--------------
 drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h |   15 ++++++++----
 2 files changed, 21 insertions(+), 21 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -2761,9 +2761,9 @@ static void intel_program_port_clock_ctl
 	val |= XELPDP_FORWARD_CLOCK_UNGATE;
 
 	if (!is_dp && is_hdmi_frl(port_clock))
-		val |= XELPDP_DDI_CLOCK_SELECT(XELPDP_DDI_CLOCK_SELECT_DIV18CLK);
+		val |= XELPDP_DDI_CLOCK_SELECT_PREP(display, XELPDP_DDI_CLOCK_SELECT_DIV18CLK);
 	else
-		val |= XELPDP_DDI_CLOCK_SELECT(XELPDP_DDI_CLOCK_SELECT_MAXPCLK);
+		val |= XELPDP_DDI_CLOCK_SELECT_PREP(display, XELPDP_DDI_CLOCK_SELECT_MAXPCLK);
 
 	/* TODO: HDMI FRL */
 	/* DP2.0 10G and 20G rates enable MPLLA*/
@@ -2774,7 +2774,7 @@ static void intel_program_port_clock_ctl
 
 	intel_de_rmw(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port),
 		     XELPDP_LANE1_PHY_CLOCK_SELECT | XELPDP_FORWARD_CLOCK_UNGATE |
-		     XELPDP_DDI_CLOCK_SELECT_MASK | XELPDP_SSC_ENABLE_PLLA |
+		     XELPDP_DDI_CLOCK_SELECT_MASK(display) | XELPDP_SSC_ENABLE_PLLA |
 		     XELPDP_SSC_ENABLE_PLLB, val);
 }
 
@@ -3097,10 +3097,7 @@ int intel_mtl_tbt_calc_port_clock(struct
 
 	val = intel_de_read(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port));
 
-	if (DISPLAY_VER(display) >= 30)
-		clock = REG_FIELD_GET(XE3_DDI_CLOCK_SELECT_MASK, val);
-	else
-		clock = REG_FIELD_GET(XELPDP_DDI_CLOCK_SELECT_MASK, val);
+	clock = XELPDP_DDI_CLOCK_SELECT_GET(display, val);
 
 	drm_WARN_ON(display->drm, !(val & XELPDP_FORWARD_CLOCK_UNGATE));
 	drm_WARN_ON(display->drm, !(val & XELPDP_TBT_CLOCK_REQUEST));
@@ -3168,13 +3165,9 @@ static void intel_mtl_tbt_pll_enable(str
 	 * clock muxes, gating and SSC
 	 */
 
-	if (DISPLAY_VER(display) >= 30) {
-		mask = XE3_DDI_CLOCK_SELECT_MASK;
-		val |= XE3_DDI_CLOCK_SELECT(intel_mtl_tbt_clock_select(display, crtc_state->port_clock));
-	} else {
-		mask = XELPDP_DDI_CLOCK_SELECT_MASK;
-		val |= XELPDP_DDI_CLOCK_SELECT(intel_mtl_tbt_clock_select(display, crtc_state->port_clock));
-	}
+	mask = XELPDP_DDI_CLOCK_SELECT_MASK(display);
+	val |= XELPDP_DDI_CLOCK_SELECT_PREP(display,
+					    intel_mtl_tbt_clock_select(display, crtc_state->port_clock));
 
 	mask |= XELPDP_FORWARD_CLOCK_UNGATE;
 	val |= XELPDP_FORWARD_CLOCK_UNGATE;
@@ -3287,7 +3280,7 @@ static void intel_cx0pll_disable(struct
 
 	/* 7. Program PORT_CLOCK_CTL register to disable and gate clocks. */
 	intel_de_rmw(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port),
-		     XELPDP_DDI_CLOCK_SELECT_MASK, 0);
+		     XELPDP_DDI_CLOCK_SELECT_MASK(display), 0);
 	intel_de_rmw(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port),
 		     XELPDP_FORWARD_CLOCK_UNGATE, 0);
 
@@ -3336,7 +3329,7 @@ static void intel_mtl_tbt_pll_disable(st
 	 * 5. Program PORT CLOCK CTRL register to disable and gate clocks
 	 */
 	intel_de_rmw(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port),
-		     XELPDP_DDI_CLOCK_SELECT_MASK |
+		     XELPDP_DDI_CLOCK_SELECT_MASK(display) |
 		     XELPDP_FORWARD_CLOCK_UNGATE, 0);
 
 	/* 6. Program DDI_CLK_VALFREQ to 0. */
@@ -3365,7 +3358,7 @@ intel_mtl_port_pll_type(struct intel_enc
 	 * handling is done via the standard shared DPLL framework.
 	 */
 	val = intel_de_read(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port));
-	clock = REG_FIELD_GET(XELPDP_DDI_CLOCK_SELECT_MASK, val);
+	clock = XELPDP_DDI_CLOCK_SELECT_GET(display, val);
 
 	if (clock == XELPDP_DDI_CLOCK_SELECT_MAXPCLK ||
 	    clock == XELPDP_DDI_CLOCK_SELECT_DIV18CLK)
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy_regs.h
@@ -192,10 +192,17 @@
 
 #define   XELPDP_TBT_CLOCK_REQUEST			REG_BIT(19)
 #define   XELPDP_TBT_CLOCK_ACK				REG_BIT(18)
-#define   XELPDP_DDI_CLOCK_SELECT_MASK			REG_GENMASK(15, 12)
-#define   XE3_DDI_CLOCK_SELECT_MASK			REG_GENMASK(16, 12)
-#define   XELPDP_DDI_CLOCK_SELECT(val)			REG_FIELD_PREP(XELPDP_DDI_CLOCK_SELECT_MASK, val)
-#define   XE3_DDI_CLOCK_SELECT(val)			REG_FIELD_PREP(XE3_DDI_CLOCK_SELECT_MASK, val)
+#define   _XELPDP_DDI_CLOCK_SELECT_MASK			REG_GENMASK(15, 12)
+#define   _XE3_DDI_CLOCK_SELECT_MASK			REG_GENMASK(16, 12)
+#define   XELPDP_DDI_CLOCK_SELECT_MASK(display)		(DISPLAY_VER(display) >= 30 ? \
+							 _XE3_DDI_CLOCK_SELECT_MASK : _XELPDP_DDI_CLOCK_SELECT_MASK)
+#define   XELPDP_DDI_CLOCK_SELECT_PREP(display, val)	(DISPLAY_VER(display) >= 30 ? \
+							 REG_FIELD_PREP(_XE3_DDI_CLOCK_SELECT_MASK, (val)) : \
+							 REG_FIELD_PREP(_XELPDP_DDI_CLOCK_SELECT_MASK, (val)))
+#define   XELPDP_DDI_CLOCK_SELECT_GET(display, val)	(DISPLAY_VER(display) >= 30 ? \
+							 REG_FIELD_GET(_XE3_DDI_CLOCK_SELECT_MASK, (val)) : \
+							 REG_FIELD_GET(_XELPDP_DDI_CLOCK_SELECT_MASK, (val)))
+
 #define   XELPDP_DDI_CLOCK_SELECT_NONE			0x0
 #define   XELPDP_DDI_CLOCK_SELECT_MAXPCLK		0x8
 #define   XELPDP_DDI_CLOCK_SELECT_DIV18CLK		0x9



