Return-Path: <stable+bounces-23532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07BF861DA3
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 21:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DA728A102
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 20:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70512883B;
	Fri, 23 Feb 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bjes7mT1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B95EAD2
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720342; cv=none; b=g8cg4stBToHKnBAsYwTPe1JvwmacpxEI0qhHtF28uSpJVuZmrn2I8cfU4wv7HcIrcbOVZa3F9ldwSMRK5CaTdzCThYK7pwNazKg6EwR/NG9vdRxMEgEfK1MabW1gMyaEBD0Jpc6HlJhiQ0jA7i8MlHynKjubQ1HXc58Q55ROr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720342; c=relaxed/simple;
	bh=Ij2xtGVIRqKAuVJQgoiWaJzArSxqnsTgWTAuVAHOpuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UfXFqe5KOIZ4wh8n3xnFqKt3YGWQ144P/YApbqnVkoGJRAgdbgMpLSlJrCHnxTjOX0BzWYEnDO6TcKmKaY1YiUkk0ZP/tjaQRX0eXxtTPCrz5dAVfFuMwjdooJETylI9nWeyY2gEJDX8p/sDFA5fsl64HeWDLSOq/vf+p5ui1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bjes7mT1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708720340; x=1740256340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ij2xtGVIRqKAuVJQgoiWaJzArSxqnsTgWTAuVAHOpuw=;
  b=Bjes7mT1F62auTIFhZ2CzemIbUymuVVXMEG9desqYzhQWfT2v7MJHo7p
   I38PmtEl+4SeCcfFjf0I2Zn9++BeFCYP55F59o5yHHiq4ULIvQSlI+yBv
   LK18wk9UDJ2I/LOPNRa7KhM+c6+qCnPkUcovsf6vY6N78sQSWxN+TFXtV
   hWbUTLrThN7yMZSF+QylQja5aCEqTClwVtyRYBdKG9NNiU+/dFdgcY3Q5
   uMEPuXleSjXvTta3NH+1rjLeeQGOU2ScnQKwU6SM3rnhfgCGbWOE5q7Pt
   cjG3dcRGEO/bmjSJTa3TL5t84ZqKqjAGW5FmbDvAw45cFP37qK9EZkeAt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20503637"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20503637"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:32:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="827767880"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="827767880"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 23 Feb 2024 12:32:17 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 23 Feb 2024 22:32:16 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915: Don't explode when the dig port we don't have an AUX CH
Date: Fri, 23 Feb 2024 22:32:15 +0200
Message-ID: <20240223203216.15210-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The icl+ power well code currently assumes that every AUX power
well maps to an encoder which is using said power well. That is
by no menas guaranteed as we:
- only register encoders for ports declared in the VBT
- combo PHY HDMI-only encoder no longer get an AUX CH since
  commit 9856308c94ca ("drm/i915: Only populate aux_ch if really needed")

However we have places such as intel_power_domains_sanitize_state()
that blindly traverse all the possible power wells. So these bits
of code may very well encounbter an aux power well with no associated
encoder.

In this particular case the BIOS seems to have left one AUX power
well enabled even though we're dealing with a HDMI only encoder
on a combo PHY. We then proceed to turn off said power well and
explode when we can't find a matching encoder. As a short term fix
we should be able to just skip the PHY related parts of the power
well programming since we know this situation can only happen with
combo PHYs.

Another option might be to go back to always picking an AUX CH for
all encoders. However I'm a bit wary about that since we might in
theory end up conflicting with the VBT AUX CH assignment. Also
that wouldn't help with encoders not declared in the VBT, should
we ever need to poke the corresponding power wells.

Longer term we need to figure out what the actual relationship
is between the PHY vs. AUX CH vs. AUX power well. Currently this
is entirely unclear.

Cc: stable@vger.kernel.org
Fixes: 9856308c94ca ("drm/i915: Only populate aux_ch if really needed")
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10184
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../drm/i915/display/intel_display_power_well.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_power_well.c b/drivers/gpu/drm/i915/display/intel_display_power_well.c
index 47cd6bb04366..06900ff307b2 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power_well.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power_well.c
@@ -246,7 +246,14 @@ static enum phy icl_aux_pw_to_phy(struct drm_i915_private *i915,
 	enum aux_ch aux_ch = icl_aux_pw_to_ch(power_well);
 	struct intel_digital_port *dig_port = aux_ch_to_digital_port(i915, aux_ch);
 
-	return intel_port_to_phy(i915, dig_port->base.port);
+	/*
+	 * FIXME should we care about the (VBT defined) dig_port->aux_ch
+	 * relationship or should this be purely defined by the hardware layout?
+	 * Currently if the port doesn't appear in the VBT, or if it's declared
+	 * as HDMI-only and routed to a combo PHY, the encoder either won't be
+	 * present at all or it will not have an aux_ch assigned.
+	 */
+	return dig_port ? intel_port_to_phy(i915, dig_port->base.port) : PHY_NONE;
 }
 
 static void hsw_wait_for_power_well_enable(struct drm_i915_private *dev_priv,
@@ -414,7 +421,8 @@ icl_combo_phy_aux_power_well_enable(struct drm_i915_private *dev_priv,
 
 	intel_de_rmw(dev_priv, regs->driver, 0, HSW_PWR_WELL_CTL_REQ(pw_idx));
 
-	if (DISPLAY_VER(dev_priv) < 12)
+	/* FIXME this is a mess */
+	if (phy != PHY_NONE)
 		intel_de_rmw(dev_priv, ICL_PORT_CL_DW12(phy),
 			     0, ICL_LANE_ENABLE_AUX);
 
@@ -437,7 +445,10 @@ icl_combo_phy_aux_power_well_disable(struct drm_i915_private *dev_priv,
 
 	drm_WARN_ON(&dev_priv->drm, !IS_ICELAKE(dev_priv));
 
-	intel_de_rmw(dev_priv, ICL_PORT_CL_DW12(phy), ICL_LANE_ENABLE_AUX, 0);
+	/* FIXME this is a mess */
+	if (phy != PHY_NONE)
+		intel_de_rmw(dev_priv, ICL_PORT_CL_DW12(phy),
+			     ICL_LANE_ENABLE_AUX, 0);
 
 	intel_de_rmw(dev_priv, regs->driver, HSW_PWR_WELL_CTL_REQ(pw_idx), 0);
 
-- 
2.43.0


