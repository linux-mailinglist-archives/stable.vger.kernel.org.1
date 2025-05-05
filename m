Return-Path: <stable+bounces-140290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2848EAAA71C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F69179FE3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB7F29ACD2;
	Mon,  5 May 2025 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G85lwjPX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBD29ACC7;
	Mon,  5 May 2025 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484568; cv=none; b=CONNVDuUOT9DoSE/xwrdW9ziUOfg6Ls/Jn1OcZ9oStTe6ZEEI56wVpMbkKlGudDCynuxv3gb8qZN2fQLC1L+TP/uaN/ZjfJGdqxyvmCV34qKKSAVyjM0vXsNhjaeMr+t2eZmoxmLmY8QiXXctKmDvHFEdRiko6Uy0zFJp6n0cLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484568; c=relaxed/simple;
	bh=4WfFbFjcaanBR0u3Vi8013gCJwg8jWqxRkdGc3InMBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PRxHuAhJjpSMjQIlw8rFbl9EpeZ2SrJwotT2M6lBOe0oPhLiBWjdcoMdhbcTPdoaq5Jl8UFDeVnEEtd0W3Wd1XOEnQm8udiouvrK8hklBvvv8YYRPFfd7O9saIqEvfm81pGmk2cqR0EPPZhBuyY08x6fhx4WFRrcmLlvVM8G+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G85lwjPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D0FC4CEF2;
	Mon,  5 May 2025 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484568;
	bh=4WfFbFjcaanBR0u3Vi8013gCJwg8jWqxRkdGc3InMBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G85lwjPXfVnOpgt3/ioobduSENsASCyGRlYGe1vs615n7fQ8N+mW49i2NksKAImaB
	 0EIPOA4j2ydGrcYjGsAnShWx2P6yk2AtCBEUnc8HbEKqx9nJi5HUTOYiRZexKMDN7A
	 MMzQvRPO50px87Fcgc+HVx42lisRRn6W8zVdXVshmhN99862dsJR6JxVgn+unA+vzx
	 QuhSnC/xQ6Z3H89rcMspTVRqGF1dke+eqKB/i6iY/qDyVtamfBVSIc7vDhvrTUMJOk
	 Tgkt8HAgcHMQtUAh0QTSpKkreSJPSR4s0WNMs6mAgYzjUCRSVgWEvsbT70+U6QZG+O
	 L49U/kIrFGflQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 542/642] drm/rockchip: vop2: Improve display modes handling on RK3588 HDMI0
Date: Mon,  5 May 2025 18:12:38 -0400
Message-Id: <20250505221419.2672473-542-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 2c1268e7aad0819f38e56134bbc2095fd95fde1b ]

The RK3588 specific implementation is currently quite limited in terms
of handling the full range of display modes supported by the connected
screens, e.g. 2560x1440@75Hz, 2048x1152@60Hz, 1024x768@60Hz are just a
few of them.

Additionally, it doesn't cope well with non-integer refresh rates like
59.94, 29.97, 23.98, etc.

Make use of HDMI0 PHY PLL as a more accurate DCLK source to handle
all display modes up to 4K@60Hz.

Tested-by: FUKAUMI Naoki <naoki@radxa.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20250204-vop2-hdmi0-disp-modes-v3-3-d71c6a196e58@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 64029237358d8..bcbd498823928 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -159,6 +159,7 @@ struct vop2_video_port {
 	struct drm_crtc crtc;
 	struct vop2 *vop2;
 	struct clk *dclk;
+	struct clk *dclk_src;
 	unsigned int id;
 	const struct vop2_video_port_data *data;
 
@@ -214,6 +215,7 @@ struct vop2 {
 	struct clk *hclk;
 	struct clk *aclk;
 	struct clk *pclk;
+	struct clk *pll_hdmiphy0;
 
 	/* optional internal rgb encoder */
 	struct rockchip_rgb *rgb;
@@ -222,6 +224,8 @@ struct vop2 {
 	struct vop2_win win[];
 };
 
+#define VOP2_MAX_DCLK_RATE		600000000
+
 #define vop2_output_if_is_hdmi(x)	((x) == ROCKCHIP_VOP2_EP_HDMI0 || \
 					 (x) == ROCKCHIP_VOP2_EP_HDMI1)
 
@@ -1155,6 +1159,9 @@ static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	vop2_crtc_disable_irq(vp, VP_INT_DSP_HOLD_VALID);
 
+	if (vp->dclk_src)
+		clk_set_parent(vp->dclk, vp->dclk_src);
+
 	clk_disable_unprepare(vp->dclk);
 
 	vop2->enable_count--;
@@ -2257,6 +2264,27 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	vop2_vp_write(vp, RK3568_VP_MIPI_CTRL, 0);
 
+	/*
+	 * Switch to HDMI PHY PLL as DCLK source for display modes up
+	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
+	 */
+	if (vop2->pll_hdmiphy0 && clock <= VOP2_MAX_DCLK_RATE) {
+		drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_mask) {
+			struct rockchip_encoder *rkencoder = to_rockchip_encoder(encoder);
+
+			if (rkencoder->crtc_endpoint_id == ROCKCHIP_VOP2_EP_HDMI0) {
+				if (!vp->dclk_src)
+					vp->dclk_src = clk_get_parent(vp->dclk);
+
+				ret = clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
+				if (ret < 0)
+					drm_warn(vop2->drm,
+						 "Could not switch to HDMI0 PHY PLL: %d\n", ret);
+				break;
+			}
+		}
+	}
+
 	clk_set_rate(vp->dclk, clock);
 
 	vop2_post_config(crtc);
@@ -3697,6 +3725,12 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(vop2->pclk);
 	}
 
+	vop2->pll_hdmiphy0 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy0");
+	if (IS_ERR(vop2->pll_hdmiphy0)) {
+		drm_err(vop2->drm, "failed to get pll_hdmiphy0\n");
+		return PTR_ERR(vop2->pll_hdmiphy0);
+	}
+
 	vop2->irq = platform_get_irq(pdev, 0);
 	if (vop2->irq < 0) {
 		drm_err(vop2->drm, "cannot find irq for vop2\n");
-- 
2.39.5


