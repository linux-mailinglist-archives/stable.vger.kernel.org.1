Return-Path: <stable+bounces-6204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E9B80D95F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41C51F21A64
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00F951C53;
	Mon, 11 Dec 2023 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Znll7w8b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F651C37;
	Mon, 11 Dec 2023 18:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35399C433C8;
	Mon, 11 Dec 2023 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320792;
	bh=y7U6hfN1oUFFzgMhaoQDflETNZ/H91VX3zkYIdt1YBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Znll7w8bYYE3vzDI24uQ+iN3TpU8/+ai+LtScqQCVZxGLLXljZT0Dd3yadVQxyFDa
	 xGNYCxUtflQQsllIZpygdyC8JPw32sWSWZE/+tIe3zr2oNfvnah+MoCFfkQT5iOCB7
	 Ozx7AxF8kvb8LX+A/ovU+78TM50KVYeDbsZ8VlLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 192/194] drm/i915/lvds: Use REG_BIT() & co.
Date: Mon, 11 Dec 2023 19:23:02 +0100
Message-ID: <20231211182045.277199661@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 9dd56e979cb69f5cd904574c852b620777a2f69f ]

Use REG_BIT() & co. for the LVDS port register.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230130180540.8972-4-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Stable-dep-of: 20c2dbff342a ("drm/i915: Skip some timing checks on BXT/GLK DSI transcoders")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_lvds.c |  4 +-
 drivers/gpu/drm/i915/i915_reg.h           | 46 +++++++++++------------
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lvds.c b/drivers/gpu/drm/i915/display/intel_lvds.c
index a749a5a66d624..e4606d9a25edb 100644
--- a/drivers/gpu/drm/i915/display/intel_lvds.c
+++ b/drivers/gpu/drm/i915/display/intel_lvds.c
@@ -92,9 +92,9 @@ bool intel_lvds_port_enabled(struct drm_i915_private *dev_priv,
 
 	/* asserts want to know the pipe even if the port is disabled */
 	if (HAS_PCH_CPT(dev_priv))
-		*pipe = (val & LVDS_PIPE_SEL_MASK_CPT) >> LVDS_PIPE_SEL_SHIFT_CPT;
+		*pipe = REG_FIELD_GET(LVDS_PIPE_SEL_MASK_CPT, val);
 	else
-		*pipe = (val & LVDS_PIPE_SEL_MASK) >> LVDS_PIPE_SEL_SHIFT;
+		*pipe = REG_FIELD_GET(LVDS_PIPE_SEL_MASK, val);
 
 	return val & LVDS_PORT_EN;
 }
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 25015996f627a..c6766704340eb 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -2681,52 +2681,50 @@
  * Enables the LVDS port.  This bit must be set before DPLLs are enabled, as
  * the DPLL semantics change when the LVDS is assigned to that pipe.
  */
-#define   LVDS_PORT_EN			(1 << 31)
+#define   LVDS_PORT_EN			REG_BIT(31)
 /* Selects pipe B for LVDS data.  Must be set on pre-965. */
-#define   LVDS_PIPE_SEL_SHIFT		30
-#define   LVDS_PIPE_SEL_MASK		(1 << 30)
-#define   LVDS_PIPE_SEL(pipe)		((pipe) << 30)
-#define   LVDS_PIPE_SEL_SHIFT_CPT	29
-#define   LVDS_PIPE_SEL_MASK_CPT	(3 << 29)
-#define   LVDS_PIPE_SEL_CPT(pipe)	((pipe) << 29)
+#define   LVDS_PIPE_SEL_MASK		REG_BIT(30)
+#define   LVDS_PIPE_SEL(pipe)		REG_FIELD_PREP(LVDS_PIPE_SEL_MASK, (pipe))
+#define   LVDS_PIPE_SEL_MASK_CPT	REG_GENMASK(30, 29)
+#define   LVDS_PIPE_SEL_CPT(pipe)	REG_FIELD_PREP(LVDS_PIPE_SEL_MASK_CPT, (pipe))
 /* LVDS dithering flag on 965/g4x platform */
-#define   LVDS_ENABLE_DITHER		(1 << 25)
+#define   LVDS_ENABLE_DITHER		REG_BIT(25)
 /* LVDS sync polarity flags. Set to invert (i.e. negative) */
-#define   LVDS_VSYNC_POLARITY		(1 << 21)
-#define   LVDS_HSYNC_POLARITY		(1 << 20)
+#define   LVDS_VSYNC_POLARITY		REG_BIT(21)
+#define   LVDS_HSYNC_POLARITY		REG_BIT(20)
 
 /* Enable border for unscaled (or aspect-scaled) display */
-#define   LVDS_BORDER_ENABLE		(1 << 15)
+#define   LVDS_BORDER_ENABLE		REG_BIT(15)
 /*
  * Enables the A0-A2 data pairs and CLKA, containing 18 bits of color data per
  * pixel.
  */
-#define   LVDS_A0A2_CLKA_POWER_MASK	(3 << 8)
-#define   LVDS_A0A2_CLKA_POWER_DOWN	(0 << 8)
-#define   LVDS_A0A2_CLKA_POWER_UP	(3 << 8)
+#define   LVDS_A0A2_CLKA_POWER_MASK	REG_GENMASK(9, 8)
+#define   LVDS_A0A2_CLKA_POWER_DOWN	REG_FIELD_PREP(LVDS_A0A2_CLKA_POWER_MASK, 0)
+#define   LVDS_A0A2_CLKA_POWER_UP	REG_FIELD_PREP(LVDS_A0A2_CLKA_POWER_MASK, 3)
 /*
  * Controls the A3 data pair, which contains the additional LSBs for 24 bit
  * mode.  Only enabled if LVDS_A0A2_CLKA_POWER_UP also indicates it should be
  * on.
  */
-#define   LVDS_A3_POWER_MASK		(3 << 6)
-#define   LVDS_A3_POWER_DOWN		(0 << 6)
-#define   LVDS_A3_POWER_UP		(3 << 6)
+#define   LVDS_A3_POWER_MASK		REG_GENMASK(7, 6)
+#define   LVDS_A3_POWER_DOWN		REG_FIELD_PREP(LVDS_A3_POWER_MASK, 0)
+#define   LVDS_A3_POWER_UP		REG_FIELD_PREP(LVDS_A3_POWER_MASK, 3)
 /*
  * Controls the CLKB pair.  This should only be set when LVDS_B0B3_POWER_UP
  * is set.
  */
-#define   LVDS_CLKB_POWER_MASK		(3 << 4)
-#define   LVDS_CLKB_POWER_DOWN		(0 << 4)
-#define   LVDS_CLKB_POWER_UP		(3 << 4)
+#define   LVDS_CLKB_POWER_MASK		REG_GENMASK(5, 4)
+#define   LVDS_CLKB_POWER_DOWN		REG_FIELD_PREP(LVDS_CLKB_POWER_MASK, 0)
+#define   LVDS_CLKB_POWER_UP		REG_FIELD_PREP(LVDS_CLKB_POWER_MASK, 3)
 /*
  * Controls the B0-B3 data pairs.  This must be set to match the DPLL p2
  * setting for whether we are in dual-channel mode.  The B3 pair will
  * additionally only be powered up when LVDS_A3_POWER_UP is set.
  */
-#define   LVDS_B0B3_POWER_MASK		(3 << 2)
-#define   LVDS_B0B3_POWER_DOWN		(0 << 2)
-#define   LVDS_B0B3_POWER_UP		(3 << 2)
+#define   LVDS_B0B3_POWER_MASK		REG_GENMASK(3, 2)
+#define   LVDS_B0B3_POWER_DOWN		REG_FIELD_PREP(LVDS_B0B3_POWER_MASK, 0)
+#define   LVDS_B0B3_POWER_UP		REG_FIELD_PREP(LVDS_B0B3_POWER_MASK, 3)
 
 /* Video Data Island Packet control */
 #define VIDEO_DIP_DATA		_MMIO(0x61178)
@@ -6461,7 +6459,7 @@
 #define FDI_PLL_CTL_2           _MMIO(0xfe004)
 
 #define PCH_LVDS	_MMIO(0xe1180)
-#define  LVDS_DETECTED	(1 << 1)
+#define   LVDS_DETECTED	REG_BIT(1)
 
 #define _PCH_DP_B		0xe4100
 #define PCH_DP_B		_MMIO(_PCH_DP_B)
-- 
2.42.0




