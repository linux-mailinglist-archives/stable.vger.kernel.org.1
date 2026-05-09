Return-Path: <stable+bounces-244977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Mg7Lstf/2l65wAAu9opvQ
	(envelope-from <stable+bounces-244977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:24:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4B500741
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1DB300FC58
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 16:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27C92F5474;
	Sat,  9 May 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5sE5gJe"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FAD1F7575
	for <stable@vger.kernel.org>; Sat,  9 May 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778343870; cv=none; b=KQ2gBuE53MwM0B5/ep3rxdDrQrxgZ1e4F6xgThnAU7xMFUQdEHr+YyHBLDWHb+VjZwiwzN9+cJsEQYEXoAF/dLHGAlmqtAJ59bEo5a9C+lcoXoMJx3Su1AAAWXFyHLBLaLQOmhVFJkqjiptsXflDtEYgqJ5WSFBlOY1k9oo7WlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778343870; c=relaxed/simple;
	bh=RcG+GU1hBa37vZk5NMPJVtB9MApQFN5AZclLyN6LFx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxSBRd3qVMEz6s1s2Ie4gyi798GwqlnMWIfMLVTJYA7NBZc9s1h+n/Sq7cmGDBl3mc+c2+iIGuGT3VoVbtmE5NfbiHHrsa20nUn9Cv8sXyqPyh1btZVGgf7ESoGtE8qTMXdeurV0g7IpSf/8X9lGPD+D0FEvaLnjKID68rFRDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5sE5gJe; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479ed73e602so127943b6e.2
        for <stable@vger.kernel.org>; Sat, 09 May 2026 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778343867; x=1778948667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYSUkeQk08X5s5eiMKardz3dR/jsqi1HIQzkNjMFZNU=;
        b=J5sE5gJeW/RGToflPqKPaLUD88jXvJol+bxe0jbRT9jCEKgZ1m/kRD49IB2VLdEWWS
         oI9XwLunUcx+emwKGnghxYRd01yIZIxruPjuiBc+f0RX28CEu7iTxZvdqsVpB+yKoO1+
         /XlC9NVMP8lVDClxKnAQHdF9cRcO3wajF1mG63AptT34p+s7TRlp0xKdJriBnQUHgs/A
         MA49Aa9LY0VrNaWdOU0onKhNFdvB5N0z5Y8f+gRbuXBAPVtS2ySRtnfek2MnESUESM1U
         MENS22j8QT4gvgA1P8xiKsiZZJCSX9olBbQoD9CKhrrrDZQWjBCLEB8S1OJ+6hChqMEP
         zx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778343867; x=1778948667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYSUkeQk08X5s5eiMKardz3dR/jsqi1HIQzkNjMFZNU=;
        b=r0z7LCYbt7IbSUjWYOCIMf0jkvLj1Vyr1rkVj1GoiMk3WRf9oTAahnGYZhog/5kdLa
         zRA6DxD3jzk8BBwO4dVLjD84J6tG8g2hS/N/ctOs+huYz7urvZytYUuFx+9/50VKQX+i
         ujWW4jfsb+P0wmYT1PkO4L34VGZMpZqGIj/30Y/yRSScFKDhFPJcSPDE4uEyIz9nVWZr
         86n6Ha8oF9VMek4WwTLfVXeeXeU1GknvcziSjMl4Mn/kc0lPO/foP7Wu3CMwPQycW/f8
         31Te/urz1/LPZHfqot1jtOGCcGqqtbji6CDqwgKp1LDWe+26JS5suxtG2GSd7UntmD9t
         F95g==
X-Forwarded-Encrypted: i=1; AFNElJ+AiUAVaVRZY0ziO5LlNqsIqtClT8JNLOhGrumoosUNsrnTLrvQkcMPDaP3Cg50SdUXYodQuRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYiPfAZJ1wPrZsK5K4a/zN5My/t/mcaXRLn9lH6jAwJj6RG3qD
	sD0eVQcG9WgPQqhsbcRoHm6N5hQ0iuikeOwIJddgRLkb/nr7IkgUgKT8
X-Gm-Gg: Acq92OGjTKKZKZgX8b5sIRKq3HQHuSVuPRx5iovub8tbQlajWI44cHiOjoo+WEtJ+HQ
	OgJMJnBqXzZCjnc4N5lIVanrYKH3YZ1r/BVeNxxHT4SVoFYXFDR3EyFfZSTgRpGam7bwQBWgCD6
	JMCDC7rnHLXRXvWOSmYIccvZnldfKMMY4pnneVbHnSVdb1P2FkojExm4e5M93RrhAuZSF3kkr+L
	ReBBsJOkiMIq9LjP9eNGWVgxirHEyLkhXceeLJChiP2AJeCA4YA1SvhU1/fvCu6upBCdIsnGTFn
	7IaR3Kw43yLlp274xGgjK6kgQGUBQq7Ce3ZQSIFUW8syzSVjjUsFHByomOXPYi3IbYsK7/JlIju
	SjOzC1C2A+1f4nB8BkocRrkD1QUgpDGHf01ezPgd+h7SlQsG8KluveBhNkEByMTzZdEkKIX+/V4
	jnPnMFXQsW2BIRLgrB0Rh0W/MGumcDsrl3xlkfq39jPXnUzsDjDuBAJG/NdGAWo5uB6R5kr3BwY
	xXHSGeFPcUJr2hi48Qt8pi1rMqY4TSOyaw=
X-Received: by 2002:a05:6808:19a3:b0:467:53b0:b414 with SMTP id 5614622812f47-480451ce0c8mr5800487b6e.6.1778343867067;
        Sat, 09 May 2026 09:24:27 -0700 (PDT)
Received: from localhost ([136.49.184.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b2c87sm17071559b6e.4.2026.05.09.09.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 09:24:26 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	mika.kahola@intel.com,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH 3/3] drm/i915/cx0: return errors from CX0 PLL enable on failure
Date: Sat,  9 May 2026 11:24:07 -0500
Message-ID: <20260509162407.510539-4-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509162407.510539-1-aaron1esau@gmail.com>
References: <20260509162407.510539-1-aaron1esau@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36F4B500741
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,intel.com,ursulin.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244977-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

intel_cx0pll_enable() silently continues when the PHY fails to come
out of SOC reset or the PLL fails to lock. When the CX0 PHY MSGBUS
is unresponsive, this causes all subsequent PLL register writes to be
silently dropped and the PLL lock request to time out, leaving the
display hardware in a broken state.

Return -ETIMEDOUT from intel_cx0_phy_lane_reset() when the PHY fails
to come out of SOC reset. Return -ETIMEDOUT from intel_cx0pll_enable()
when the PLL fails to lock. Propagate these errors through
intel_mtl_pll_enable() and mtl_pll_enable() to the shared DPLL
framework, which (as of the previous patch) will abort the CRTC
enable sequence rather than driving a pipe with a non-functional PLL.

Fixes: 51390cc0e00a ("drm/i915/mtl: Add Support for C10 PHY message bus and pll programming")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c  | 47 ++++++++++++-------
 drivers/gpu/drm/i915/display/intel_cx0_phy.h  |  6 +--
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c |  4 +-
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index 4cacea802..f5c8444ef 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -3103,8 +3103,8 @@ static u32 intel_cx0_get_pclk_refclk_ack(u8 lane_mask)
 	return val;
 }
 
-static void intel_cx0_phy_lane_reset(struct intel_encoder *encoder,
-				     bool lane_reversal)
+static int intel_cx0_phy_lane_reset(struct intel_encoder *encoder,
+				    bool lane_reversal)
 {
 	struct intel_display *display = to_intel_display(encoder);
 	enum port port = encoder->port;
@@ -3121,10 +3121,12 @@ static void intel_cx0_phy_lane_reset(struct intel_encoder *encoder,
 
 	if (intel_de_wait_for_set_us(display, XELPDP_PORT_BUF_CTL1(display, port),
 				     XELPDP_PORT_BUF_SOC_PHY_READY,
-				     XELPDP_PORT_BUF_SOC_READY_TIMEOUT_US))
-		drm_warn(display->drm,
-			 "PHY %c failed to bring out of SOC reset\n",
-			 phy_name(phy));
+				     XELPDP_PORT_BUF_SOC_READY_TIMEOUT_US)) {
+		drm_err(display->drm,
+			"PHY %c failed to bring out of SOC reset\n",
+			phy_name(phy));
+		return -ETIMEDOUT;
+	}
 
 	intel_de_rmw(display, XELPDP_PORT_BUF_CTL2(display, port), lane_pipe_reset,
 		     lane_pipe_reset);
@@ -3160,6 +3162,8 @@ static void intel_cx0_phy_lane_reset(struct intel_encoder *encoder,
 		drm_warn(display->drm,
 			 "PHY %c failed to bring out of lane reset\n",
 			 phy_name(phy));
+
+	return 0;
 }
 
 static void intel_cx0_program_phy_lane(struct intel_encoder *encoder, int lane_count,
@@ -3220,17 +3224,18 @@ static u32 intel_cx0_get_pclk_pll_ack(u8 lane_mask)
 	return val;
 }
 
-static void intel_cx0pll_enable(struct intel_encoder *encoder,
-				const struct intel_cx0pll_state *pll_state)
+static int intel_cx0pll_enable(struct intel_encoder *encoder,
+			       const struct intel_cx0pll_state *pll_state)
 {
 	int port_clock = pll_state->use_c10 ? pll_state->c10.clock : pll_state->c20.clock;
 	struct intel_display *display = to_intel_display(encoder);
 	enum phy phy = intel_encoder_to_phy(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
+	struct ref_tracker *wakeref = intel_cx0_phy_transaction_begin(encoder);
 	bool lane_reversal = dig_port->lane_reversal;
 	u8 maxpclk_lane = lane_reversal ? INTEL_CX0_LANE1 :
 					  INTEL_CX0_LANE0;
-	struct ref_tracker *wakeref = intel_cx0_phy_transaction_begin(encoder);
+	int ret;
 
 	/*
 	 * Lane reversal is never used in DP-alt mode, in that case the
@@ -3246,7 +3251,9 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
 	intel_program_port_clock_ctl(encoder, pll_state, port_clock, lane_reversal);
 
 	/* 2. Bring PHY out of reset. */
-	intel_cx0_phy_lane_reset(encoder, lane_reversal);
+	ret = intel_cx0_phy_lane_reset(encoder, lane_reversal);
+	if (ret)
+		goto out;
 
 	/*
 	 * 3. Change Phy power state to Ready.
@@ -3296,9 +3303,12 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
 	if (intel_de_wait_us(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port),
 			     intel_cx0_get_pclk_pll_ack(INTEL_CX0_BOTH_LANES),
 			     intel_cx0_get_pclk_pll_ack(maxpclk_lane),
-			     XELPDP_PCLK_PLL_ENABLE_TIMEOUT_US, NULL))
-		drm_warn(display->drm, "Port %c PLL not locked\n",
-			 phy_name(phy));
+			     XELPDP_PCLK_PLL_ENABLE_TIMEOUT_US, NULL)) {
+		drm_err(display->drm, "Port %c PLL not locked\n",
+			phy_name(phy));
+		ret = -ETIMEDOUT;
+		goto out;
+	}
 
 	/*
 	 * 11. Follow the Display Voltage Frequency Switching Sequence After
@@ -3320,7 +3330,10 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
 						    XELPDP_P2_STATE_READY);
 	}
 
+out:
 	intel_cx0_phy_transaction_end(encoder, wakeref);
+
+	return ret;
 }
 
 void intel_mtl_tbt_pll_calc_state(struct intel_dpll_hw_state *hw_state)
@@ -3458,11 +3471,11 @@ void intel_mtl_tbt_pll_enable_clock(struct intel_encoder *encoder, int port_cloc
 		       port_clock);
 }
 
-void intel_mtl_pll_enable(struct intel_encoder *encoder,
-			  struct intel_dpll *pll,
-			  const struct intel_dpll_hw_state *dpll_hw_state)
+int intel_mtl_pll_enable(struct intel_encoder *encoder,
+			 struct intel_dpll *pll,
+			 const struct intel_dpll_hw_state *dpll_hw_state)
 {
-	intel_cx0pll_enable(encoder, &dpll_hw_state->cx0pll);
+	return intel_cx0pll_enable(encoder, &dpll_hw_state->cx0pll);
 }
 
 void intel_mtl_pll_enable_clock(struct intel_encoder *encoder,
diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.h b/drivers/gpu/drm/i915/display/intel_cx0_phy.h
index ae98ac23e..1d6cc32d7 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.h
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.h
@@ -28,9 +28,9 @@ struct intel_hdmi;
 void intel_clear_response_ready_flag(struct intel_encoder *encoder,
 				     int lane);
 bool intel_encoder_is_c10phy(struct intel_encoder *encoder);
-void intel_mtl_pll_enable(struct intel_encoder *encoder,
-			  struct intel_dpll *pll,
-			  const struct intel_dpll_hw_state *dpll_hw_state);
+int intel_mtl_pll_enable(struct intel_encoder *encoder,
+			 struct intel_dpll *pll,
+			 const struct intel_dpll_hw_state *dpll_hw_state);
 void intel_mtl_pll_disable(struct intel_encoder *encoder);
 enum icl_port_dpll_id
 intel_mtl_port_pll_type(struct intel_encoder *encoder,
diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index 78fd2e5f9..ce31deadc 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -4441,9 +4441,7 @@ static int mtl_pll_enable(struct intel_display *display,
 	if (drm_WARN_ON(display->drm, !encoder))
 		return -ENODEV;
 
-	intel_mtl_pll_enable(encoder, pll, dpll_hw_state);
-
-	return 0;
+	return intel_mtl_pll_enable(encoder, pll, dpll_hw_state);
 }
 
 static void mtl_pll_disable(struct intel_display *display,
-- 
2.54.0


