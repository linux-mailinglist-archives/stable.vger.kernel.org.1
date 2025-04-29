Return-Path: <stable+bounces-137390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68BEAA1325
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE4C1707CE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70672522A0;
	Tue, 29 Apr 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LCdl4Uk+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EC242934;
	Tue, 29 Apr 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945925; cv=none; b=jd8aSfezLEGbArhHWwkQhXIwwNkmWcMniiGy3xJfuiAEw+2Ivu3FaXZ0kB6BKivTGxp0pUb0zc/aslM3aWOvLfGR8Q6nsTAZyvVL8tuEf+Rm2OxCMBfUYmFYsxD+Uz8n+nM9F38ehZIS6mVy5R9EgrqbN0urLl0ZZl8jU8z4dv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945925; c=relaxed/simple;
	bh=qz5usBVfXtCwXWUrttsYRzZ4yesFcUUEUkyVgbzqWBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMOdDbhzF3V866tyHPndMyQfgD+gNwNC4enec8/jHSzgCq2KnDiRsnFsWgv4TnBNcSdPsjefwGrWpREQ5dzitp7tHDE/yqUKpJuPXo9YQKx0oaR3dhEPUg9Rx+ZFF8piRjh1ihQZWVrqF07k4CvymnA6G0GalBaYO/dVO3peg3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LCdl4Uk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99112C4CEE9;
	Tue, 29 Apr 2025 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945925;
	bh=qz5usBVfXtCwXWUrttsYRzZ4yesFcUUEUkyVgbzqWBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCdl4Uk+jLicyCbBgIQmE4OzZH3GFTKOYQh0KiJTRxtql4DAVShiPWYVZxa41rJrL
	 5jB4IJGhZzI8MGThiMdGYAABtHTSu4W0thcVzuQUIqOfpDrrH0bck+fnfEK3d6ET3V
	 PQDkafBlvH1lfTIwYtCxzjTe+PbdDRQPjalBvr1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Hewitt <christianshewitt@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 096/311] Revert "drm/meson: vclk: fix calculation of 59.94 fractional rates"
Date: Tue, 29 Apr 2025 18:38:53 +0200
Message-ID: <20250429161124.974692174@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit f37bb5486ea536c1d61df89feeaeff3f84f0b560 ]

This reverts commit bfbc68e.

The patch does permit the offending YUV420 @ 59.94 phy_freq and
vclk_freq mode to match in calculations. It also results in all
fractional rates being unavailable for use. This was unintended
and requires the patch to be reverted.

Fixes: bfbc68e4d869 ("drm/meson: vclk: fix calculation of 59.94 fractional rates")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250421201300.778955-2-martin.blumenstingl@googlemail.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250421201300.778955-2-martin.blumenstingl@googlemail.com
Stable-dep-of: 1017560164b6 ("drm/meson: use unsigned long long / Hz for frequency types")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_vclk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a942dc6a6dc2..2a82119eb58ed 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
+				 FREQ_1000_1001(params[i].phy_freq/10)*10);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
-- 
2.39.5




