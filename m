Return-Path: <stable+bounces-110582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856AA1CA33
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6874416A39F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF2C1FECD4;
	Sun, 26 Jan 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMr9Zl6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DD1FECD0;
	Sun, 26 Jan 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903407; cv=none; b=HkaugC0ZJTS4dlkVwpo8przbH4U3y+RFrrVr3wKEKqz7NWfHMDPhnhk7cntgkHfi9atAUMPcA0ZaznoJmaP6rRlqiZdG/fxzPAmN04U3pg5Ks+kE6yXiMpjeQtNvXP8tFZ8nChHx40wSh8q0nrw2EAtUcVicPkl+OSgG7p6Vtf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903407; c=relaxed/simple;
	bh=Cw+eoe/UHDLELop/e214PmazjCWoAy1PcgxjlS84Eyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OeEGi2Qtjr+HWVQmM/PdRTV2G2a1wQgamvlg/pEahHNKNyTGOnqfT3IWg0OZFJZW+Fcpvld+PTiSkT5KIto0qM/YJSFiI4KzYY7+ADkY7F/x3qlVlRgHBUeiITjhz9FxD4EB1lJzvk1us4YH9xut2RIFDCgxqxDYHvnjN9ejeRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMr9Zl6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D889AC4CEE2;
	Sun, 26 Jan 2025 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903407;
	bh=Cw+eoe/UHDLELop/e214PmazjCWoAy1PcgxjlS84Eyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMr9Zl6pN0jGCVM9DA1e76jeHNowFhtaPmDt0XFXSG1maU27j5a/NLvOFYsZo+Ka4
	 FBxP2N71H4JpJ4peb8/S1S6FGtCredZJpaq+lMQnvQXiMuO99AH8gLN5C9t+FuSgA6
	 umURIHL9ZQSnF6pRCbesquPkd+0vkHL1hluHpQmh48tjG4DRDBJ3xgD+Oj5n64lfCd
	 6FVeZQtKPYxPESEQR8vvvQrMfKZsMr0mxeTfV6uis83zw80HulpBjJLReR0GZiG37i
	 MFLhcER/lg8kLgLAKQo8L+gXrzo8WhP3RS4sSgIPxTvdDXIV+9QRGNqptYPPL32S+3
	 keETigcvxA3Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hermes Wu <hermes.wu@ite.com.tw>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 15/17] drm/bridge: it6505: fix HDCP CTS compare V matching
Date: Sun, 26 Jan 2025 09:56:10 -0500
Message-Id: <20250126145612.937679-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145612.937679-1-sashal@kernel.org>
References: <20250126145612.937679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Hermes Wu <hermes.wu@ite.com.tw>

[ Upstream commit 0989c02c7a5c887c70afeae80c64d0291624e1a7 ]

When HDCP negotiation with a repeater device.
Checking SHA V' matching must retry 3 times before restarting HDCP.

Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241230-v7-upstream-v7-8-e0fdd4844703@ite.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 32 +++++++++++++++++------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index a1ad9a1a59a62..b23e6f663b18f 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2020,7 +2020,7 @@ static bool it6505_hdcp_part2_ksvlist_check(struct it6505 *it6505)
 {
 	struct device *dev = it6505->dev;
 	u8 av[5][4], bv[5][4];
-	int i, err;
+	int i, err, retry;
 
 	i = it6505_setup_sha1_input(it6505, it6505->sha1_input);
 	if (i <= 0) {
@@ -2029,22 +2029,28 @@ static bool it6505_hdcp_part2_ksvlist_check(struct it6505 *it6505)
 	}
 
 	it6505_sha1_digest(it6505, it6505->sha1_input, i, (u8 *)av);
+	/*1B-05 V' must retry 3 times */
+	for (retry = 0; retry < 3; retry++) {
+		err = it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (u8 *)bv,
+				      sizeof(bv));
 
-	err = it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (u8 *)bv,
-			      sizeof(bv));
+		if (err < 0) {
+			dev_err(dev, "Read V' value Fail %d", retry);
+			continue;
+		}
 
-	if (err < 0) {
-		dev_err(dev, "Read V' value Fail");
-		return false;
-	}
+		for (i = 0; i < 5; i++) {
+			if (bv[i][3] != av[i][0] || bv[i][2] != av[i][1] ||
+			    av[i][1] != av[i][2] || bv[i][0] != av[i][3])
+				break;
 
-	for (i = 0; i < 5; i++)
-		if (bv[i][3] != av[i][0] || bv[i][2] != av[i][1] ||
-		    bv[i][1] != av[i][2] || bv[i][0] != av[i][3])
-			return false;
+			DRM_DEV_DEBUG_DRIVER(dev, "V' all match!! %d, %d", retry, i);
+			return true;
+		}
+	}
 
-	DRM_DEV_DEBUG_DRIVER(dev, "V' all match!!");
-	return true;
+	DRM_DEV_DEBUG_DRIVER(dev, "V' NOT match!! %d", retry);
+	return false;
 }
 
 static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
-- 
2.39.5


