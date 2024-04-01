Return-Path: <stable+bounces-34677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7A894056
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7808FB20A51
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BF46B9F;
	Mon,  1 Apr 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whM5IP+I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14B2C129;
	Mon,  1 Apr 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988924; cv=none; b=sOXer44PsuflhEj+vjz+uub7Q52gDC81yYMEB1572FV47K7n4Y04Jh9xjoWCHl0zl4iTtzaTGEhZoLC56Z7wGB4PJb0gBD1E3kuyQ5GniwwEfcEjCrxdtG6MJ+mZteZWBFJ2d+fl25+X4RrikQ8WqxA9Ox1ed+sugWW2eks8pDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988924; c=relaxed/simple;
	bh=kCQcE8GiBb/ObJvqkKCUZO99me5kky6mlsZwKF8Xs8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSVXrWGTjk6eCh4McELqU7gRTXRlyH/hzZUa6CO1YnXrByKy2O4wcT0THa0WTgw9AmcGl8U3vFIQwApA7zf4DHDM4uCbgiomLI9xcOrJqKIiCDzBXNHfGcKay9NKCyoCpHtY7uYIcReKIw16AgkH9yYBndlJl7Zet9zhAl8qUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whM5IP+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DFBC433C7;
	Mon,  1 Apr 2024 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988924;
	bh=kCQcE8GiBb/ObJvqkKCUZO99me5kky6mlsZwKF8Xs8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=whM5IP+InVg7vEAs388rAgZoSMdNzgxo3q+/K4lapvZwajs7xNRVgWGBBhNSpzQAM
	 ixQlwFFuNpDTzTei/TL85TuGssbSynAUkGj1l0iQ5/wXJ+OD5oQakAyoLcv9WkLlBx
	 bVcJtZ9J3l996ekp17tpvNihEx+OTkl9PUHRngis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.7 330/432] drm/i915: Suppress old PLL pipe_mask checks for MG/TC/TBT PLLs
Date: Mon,  1 Apr 2024 17:45:17 +0200
Message-ID: <20240401152603.055983739@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 33c7760226c79ee8de6c0646640963a8a7ee794a upstream.

TC ports have both the MG/TC and TBT PLLs selected simultanously (so
that we can switch from MG/TC to TBT as a fallback). This doesn't play
well with the state checker that assumes that the old PLL shouldn't
have the pipe in its pipe_mask anymore. Suppress that check for these
PLLs to avoid spurious WARNs when you disconnect a TC port and a
non-disabling modeset happens before actually disabling the port.

v2: Only suppress when one of the PLLs is the TBT PLL and the
    other one is not

Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9816
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240123093137.9133-2-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c |   23 +++++++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h |    4 ++++
 2 files changed, 23 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -4026,7 +4026,8 @@ static const struct intel_shared_dpll_fu
 static const struct dpll_info icl_plls[] = {
 	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL0, },
 	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL1, },
-	{ .name = "TBT PLL", .funcs = &tbt_pll_funcs, .id = DPLL_ID_ICL_TBTPLL, },
+	{ .name = "TBT PLL", .funcs = &tbt_pll_funcs, .id = DPLL_ID_ICL_TBTPLL,
+	  .flags = INTEL_DPLL_IS_ALT_PORT_DPLL, },
 	{ .name = "MG PLL 1", .funcs = &mg_pll_funcs, .id = DPLL_ID_ICL_MGPLL1, },
 	{ .name = "MG PLL 2", .funcs = &mg_pll_funcs, .id = DPLL_ID_ICL_MGPLL2, },
 	{ .name = "MG PLL 3", .funcs = &mg_pll_funcs, .id = DPLL_ID_ICL_MGPLL3, },
@@ -4070,7 +4071,8 @@ static const struct intel_shared_dpll_fu
 static const struct dpll_info tgl_plls[] = {
 	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL0, },
 	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL1, },
-	{ .name = "TBT PLL", .funcs = &tbt_pll_funcs, .id = DPLL_ID_ICL_TBTPLL, },
+	{ .name = "TBT PLL", .funcs = &tbt_pll_funcs, .id = DPLL_ID_ICL_TBTPLL,
+	  .flags = INTEL_DPLL_IS_ALT_PORT_DPLL, },
 	{ .name = "TC PLL 1", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL1, },
 	{ .name = "TC PLL 2", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL2, },
 	{ .name = "TC PLL 3", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL3, },
@@ -4143,7 +4145,8 @@ static const struct intel_dpll_mgr adls_
 static const struct dpll_info adlp_plls[] = {
 	{ .name = "DPLL 0", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL0, },
 	{ .name = "DPLL 1", .funcs = &combo_pll_funcs, .id = DPLL_ID_ICL_DPLL1, },
-	{ .name = "TBT PLL", .funcs = &tbt_pll_funcs, .id = DPLL_ID_ICL_TBTPLL, },
+	{ .name = "TBT PLL", .funcs = &tbt_pll_funcs, .id = DPLL_ID_ICL_TBTPLL,
+	  .flags = INTEL_DPLL_IS_ALT_PORT_DPLL, },
 	{ .name = "TC PLL 1", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL1, },
 	{ .name = "TC PLL 2", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL2, },
 	{ .name = "TC PLL 3", .funcs = &dkl_pll_funcs, .id = DPLL_ID_ICL_MGPLL3, },
@@ -4521,6 +4524,14 @@ verify_single_dpll_state(struct drm_i915
 			pll->info->name);
 }
 
+static bool has_alt_port_dpll(const struct intel_shared_dpll *old_pll,
+			      const struct intel_shared_dpll *new_pll)
+{
+	return old_pll && new_pll && old_pll != new_pll &&
+		(old_pll->info->flags & INTEL_DPLL_IS_ALT_PORT_DPLL ||
+		 new_pll->info->flags & INTEL_DPLL_IS_ALT_PORT_DPLL);
+}
+
 void intel_shared_dpll_state_verify(struct intel_atomic_state *state,
 				    struct intel_crtc *crtc)
 {
@@ -4542,7 +4553,11 @@ void intel_shared_dpll_state_verify(stru
 		I915_STATE_WARN(i915, pll->active_mask & pipe_mask,
 				"%s: pll active mismatch (didn't expect pipe %c in active mask (0x%x))\n",
 				pll->info->name, pipe_name(crtc->pipe), pll->active_mask);
-		I915_STATE_WARN(i915, pll->state.pipe_mask & pipe_mask,
+
+		/* TC ports have both MG/TC and TBT PLL referenced simultaneously */
+		I915_STATE_WARN(i915, !has_alt_port_dpll(old_crtc_state->shared_dpll,
+							 new_crtc_state->shared_dpll) &&
+				pll->state.pipe_mask & pipe_mask,
 				"%s: pll enabled crtcs mismatch (found pipe %c in enabled mask (0x%x))\n",
 				pll->info->name, pipe_name(crtc->pipe), pll->state.pipe_mask);
 	}
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
@@ -271,12 +271,16 @@ struct dpll_info {
 	enum intel_dpll_id id;
 
 #define INTEL_DPLL_ALWAYS_ON	(1 << 0)
+#define INTEL_DPLL_IS_ALT_PORT_DPLL	(1 << 1)
 	/**
 	 * @flags:
 	 *
 	 * INTEL_DPLL_ALWAYS_ON
 	 *     Inform the state checker that the DPLL is kept enabled even if
 	 *     not in use by any CRTC.
+	 * INTEL_DPLL_IS_ALT_PORT_DPLL
+	 *     Inform the state checker that the DPLL can be used as a fallback
+	 *     (for TC->TBT fallback).
 	 */
 	u32 flags;
 };



