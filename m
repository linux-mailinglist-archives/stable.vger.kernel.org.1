Return-Path: <stable+bounces-156467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DA4AE4FB4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3A31B61547
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E94522172C;
	Mon, 23 Jun 2025 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hsf8JtOz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA5222576;
	Mon, 23 Jun 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713482; cv=none; b=TkJ7cKm9ifn8Dgy61hP7WdZbwJLrU1OwV/UbH0Es/ahrbeDiBJl35iLYAfLQFRW3IQUNddb2B44prhANkkxmBY43C4/FQFPsAlRy/r70NENYNieRVFW/ijSHFatN5pLgrIk1qXM5VLaTUX30AF7WASi+f9b7o4AeCslVioH0EWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713482; c=relaxed/simple;
	bh=2jGpetEDY/wrmsvZlrrN+vwOsdY9qRH47DEC0rUwHAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLGhA4x9VIlRXXO0LEFpEwA3VcnJBSD36Bs/nKt6gFd8XZnPBhN44cYE6PiaRoomtQVgMVngRCwuS4x5FtdibsfP8npmgqDKGpPYRg/OyT+BQnr6UKL4iKautu5VERKfJXmyNlDXdyRx5VQf8HstkWnSS5m8sqYPl2a98E73Kdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hsf8JtOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B9CC4CEEA;
	Mon, 23 Jun 2025 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713482;
	bh=2jGpetEDY/wrmsvZlrrN+vwOsdY9qRH47DEC0rUwHAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hsf8JtOzeCVLS1+DJfWk1P/JCYNl+sR2oNHc2vWw39EJQVJqLt3cZiWyNbJ3c0H+f
	 bs/PLygFAEHmSime+KpQBzdQlcDU3YYyIPCmwRTdxQIPK6dgCrwoeHB6lPuUmD3azi
	 civkqa9dZno6UZw0gck0uUDXGVV6LvzcHwlpxwWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Hewitt <christianshewitt@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 149/411] drm/meson: fix more rounding issues with 59.94Hz modes
Date: Mon, 23 Jun 2025 15:04:53 +0200
Message-ID: <20250623130637.374198570@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 0cee6c4d3518b2e757aedae78771f17149f57653 ]

Commit 1017560164b6 ("drm/meson: use unsigned long long / Hz for
frequency types") attempts to resolve video playback using 59.94Hz.
 using YUV420 by changing the clock calculation to use
Hz instead of kHz (thus yielding more precision).

The basic calculation itself is correct, however the comparisions in
meson_vclk_vic_supported_freq() and meson_vclk_setup() don't work
anymore for 59.94Hz modes (using the freq * 1000 / 1001 logic). For
example, drm/edid specifies a 593407kHz clock for 3840x2160@59.94Hz.
With the mentioend commit we convert this to Hz. Then meson_vclk
tries to find a matchig "params" entry (as the clock setup code
currently only supports specific frequencies) by taking the venc_freq
from the params and calculating the "alt frequency" (used for the
59.94Hz modes) from it, which is:
  (594000000Hz * 1000) / 1001 = 593406593Hz

Similar calculation is applied to the phy_freq (TMDS clock), which is 10
times the pixel clock.

Implement a new meson_vclk_freqs_are_matching_param() function whose
purpose is to compare if the requested and calculated frequencies. They
may not match exactly (for the reasons mentioned above). Allow the
clocks to deviate slightly to make the 59.94Hz modes again.

Fixes: 1017560164b6 ("drm/meson: use unsigned long long / Hz for frequency types")
Reported-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250609202751.962208-1-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_vclk.c | 55 ++++++++++++++++++------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index c4123bb958e4c..dfe0c28a0f054 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -110,10 +110,7 @@
 #define HDMI_PLL_LOCK		BIT(31)
 #define HDMI_PLL_LOCK_G12A	(3 << 30)
 
-#define PIXEL_FREQ_1000_1001(_freq)	\
-	DIV_ROUND_CLOSEST_ULL((_freq) * 1000ULL, 1001ULL)
-#define PHY_FREQ_1000_1001(_freq)	\
-	(PIXEL_FREQ_1000_1001(DIV_ROUND_DOWN_ULL(_freq, 10ULL)) * 10)
+#define FREQ_1000_1001(_freq)	DIV_ROUND_CLOSEST_ULL((_freq) * 1000ULL, 1001ULL)
 
 /* VID PLL Dividers */
 enum {
@@ -772,6 +769,36 @@ static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
 		  pll_freq);
 }
 
+static bool meson_vclk_freqs_are_matching_param(unsigned int idx,
+						unsigned long long phy_freq,
+						unsigned long long vclk_freq)
+{
+	DRM_DEBUG_DRIVER("i = %d vclk_freq = %lluHz alt = %lluHz\n",
+			 idx, params[idx].vclk_freq,
+			 FREQ_1000_1001(params[idx].vclk_freq));
+	DRM_DEBUG_DRIVER("i = %d phy_freq = %lluHz alt = %lluHz\n",
+			 idx, params[idx].phy_freq,
+			 FREQ_1000_1001(params[idx].phy_freq));
+
+	/* Match strict frequency */
+	if (phy_freq == params[idx].phy_freq &&
+	    vclk_freq == params[idx].vclk_freq)
+		return true;
+
+	/* Match 1000/1001 variant: vclk deviation has to be less than 1kHz
+	 * (drm EDID is defined in 1kHz steps, so everything smaller must be
+	 * rounding error) and the PHY freq deviation has to be less than
+	 * 10kHz (as the TMDS clock is 10 times the pixel clock, so anything
+	 * smaller must be rounding error as well).
+	 */
+	if (abs(vclk_freq - FREQ_1000_1001(params[idx].vclk_freq)) < 1000 &&
+	    abs(phy_freq - FREQ_1000_1001(params[idx].phy_freq)) < 10000)
+		return true;
+
+	/* no match */
+	return false;
+}
+
 enum drm_mode_status
 meson_vclk_vic_supported_freq(struct meson_drm *priv,
 			      unsigned long long phy_freq,
@@ -790,19 +817,7 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv,
 	}
 
 	for (i = 0 ; params[i].pixel_freq ; ++i) {
-		DRM_DEBUG_DRIVER("i = %d vclk_freq = %lluHz alt = %lluHz\n",
-				 i, params[i].vclk_freq,
-				 PIXEL_FREQ_1000_1001(params[i].vclk_freq));
-		DRM_DEBUG_DRIVER("i = %d phy_freq = %lluHz alt = %lluHz\n",
-				 i, params[i].phy_freq,
-				 PHY_FREQ_1000_1001(params[i].phy_freq));
-		/* Match strict frequency */
-		if (phy_freq == params[i].phy_freq &&
-		    vclk_freq == params[i].vclk_freq)
-			return MODE_OK;
-		/* Match 1000/1001 variant */
-		if (phy_freq == PHY_FREQ_1000_1001(params[i].phy_freq) &&
-		    vclk_freq == PIXEL_FREQ_1000_1001(params[i].vclk_freq))
+		if (meson_vclk_freqs_are_matching_param(i, phy_freq, vclk_freq))
 			return MODE_OK;
 	}
 
@@ -1075,10 +1090,8 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 	}
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
-		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == PHY_FREQ_1000_1001(params[freq].phy_freq)) &&
-		    (vclk_freq == params[freq].vclk_freq ||
-		     vclk_freq == PIXEL_FREQ_1000_1001(params[freq].vclk_freq))) {
+		if (meson_vclk_freqs_are_matching_param(freq, phy_freq,
+							vclk_freq)) {
 			if (vclk_freq != params[freq].vclk_freq)
 				vic_alternate_clock = true;
 			else
-- 
2.39.5




