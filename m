Return-Path: <stable+bounces-108888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5CBA120CC
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B6E3A61D7
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010C3207DE0;
	Wed, 15 Jan 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uRBWadWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770E1E98FF;
	Wed, 15 Jan 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938142; cv=none; b=hoy6/UVq2j/GmsZl0M5KGMXzqOpmTghwYJdVrqKNeW4FmkXJCExIu4ocZ0M5r7MkCqIwnty1GKKz5hYqDALPwpIIxhOcTJH70c1uKHUNijCFzU13GjUK2z2shh2xh7plTgSwLMQf4OfSRkoTabKlKnsumtEv8O2uilL+wO0eQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938142; c=relaxed/simple;
	bh=t8rjKZe7PdqCUf2UsJcXwoRvbH2A85SE8RSlwYXaZCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTKIqn6kdO2bQZlsrxp1+muLOJZb4QAMftHvGXSNQ76XD9i/QAsojg+ObxI0wGWO5yJbV/PaL1K2VkyUNcVCHMRjqmBmJSMVI/sEJHUMeS+Nc25SndIfslDMKAmsuewSxDVVIUnY5dcRHBmLpSOG3maHn4QIhwcM9wK14ynutmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uRBWadWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A426EC4CEDF;
	Wed, 15 Jan 2025 10:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938142;
	bh=t8rjKZe7PdqCUf2UsJcXwoRvbH2A85SE8RSlwYXaZCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRBWadWZz8RJXcbxuxvmIEZPfy1NH+UJ+1ueLi+CopzRKSEaTnDzoIxjE409t67rz
	 YgS2K7yjkev3uST2kHxzGfjbxHEMPZuEWzhcVzmxU/oo8htPXWeq5v90ybl+t90XbY
	 CJOwXwajn8zRPbEuQA4Pt/XV+x3eaShcJMWZDxrA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liankun Yang <liankun.yang@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 065/189] drm/mediatek: Fix mode valid issue for dp
Date: Wed, 15 Jan 2025 11:36:01 +0100
Message-ID: <20250115103608.946207709@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liankun Yang <liankun.yang@mediatek.com>

[ Upstream commit 0d68b55887cedc7487036ed34cb4c2097c4228f1 ]

Fix dp mode valid issue to avoid abnormal display of limit state.

After DP passes link training, it can express the lane count of the
current link status is good. Calculate the maximum bandwidth supported
by DP using the current lane count.

The color format will select the best one based on the bandwidth
requirements of the current timing mode. If the current timing mode
uses RGB and meets the DP link bandwidth requirements, RGB will be used.

If the timing mode uses RGB but does not meet the DP link bandwidthi
requirements, it will continue to check whether YUV422 meets
the DP link bandwidth.

FEC overhead is approximately 2.4% from DP 1.4a spec 2.2.1.4.2.
The down-spread amplitude shall either be disabled (0.0%) or up
to 0.5% from 1.4a 3.5.2.6. Add up to approximately 3% total overhead.

Because rate is already divided by 10,
mode->clock does not need to be multiplied by 10.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20241025083036.8829-3-liankun.yang@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index bcc4d3fc77d8..461764ec19e7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2411,12 +2411,19 @@ mtk_dp_bridge_mode_valid(struct drm_bridge *bridge,
 {
 	struct mtk_dp *mtk_dp = mtk_dp_from_bridge(bridge);
 	u32 bpp = info->color_formats & DRM_COLOR_FORMAT_YCBCR422 ? 16 : 24;
-	u32 rate = min_t(u32, drm_dp_max_link_rate(mtk_dp->rx_cap) *
-			      drm_dp_max_lane_count(mtk_dp->rx_cap),
-			 drm_dp_bw_code_to_link_rate(mtk_dp->max_linkrate) *
-			 mtk_dp->max_lanes);
+	u32 lane_count_min = mtk_dp->train_info.lane_count;
+	u32 rate = drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate) *
+		   lane_count_min;
 
-	if (rate < mode->clock * bpp / 8)
+	/*
+	 *FEC overhead is approximately 2.4% from DP 1.4a spec 2.2.1.4.2.
+	 *The down-spread amplitude shall either be disabled (0.0%) or up
+	 *to 0.5% from 1.4a 3.5.2.6. Add up to approximately 3% total overhead.
+	 *
+	 *Because rate is already divided by 10,
+	 *mode->clock does not need to be multiplied by 10
+	 */
+	if ((rate * 97 / 100) < (mode->clock * bpp / 8))
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
@@ -2457,10 +2464,9 @@ static u32 *mtk_dp_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct drm_display_info *display_info =
 		&conn_state->connector->display_info;
-	u32 rate = min_t(u32, drm_dp_max_link_rate(mtk_dp->rx_cap) *
-			      drm_dp_max_lane_count(mtk_dp->rx_cap),
-			 drm_dp_bw_code_to_link_rate(mtk_dp->max_linkrate) *
-			 mtk_dp->max_lanes);
+	u32 lane_count_min = mtk_dp->train_info.lane_count;
+	u32 rate = drm_dp_bw_code_to_link_rate(mtk_dp->train_info.link_rate) *
+		   lane_count_min;
 
 	*num_input_fmts = 0;
 
@@ -2469,8 +2475,8 @@ static u32 *mtk_dp_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	 * datarate of YUV422 and sink device supports YUV422, we output YUV422
 	 * format. Use this condition, we can support more resolution.
 	 */
-	if ((rate < (mode->clock * 24 / 8)) &&
-	    (rate > (mode->clock * 16 / 8)) &&
+	if (((rate * 97 / 100) < (mode->clock * 24 / 8)) &&
+	    ((rate * 97 / 100) > (mode->clock * 16 / 8)) &&
 	    (display_info->color_formats & DRM_COLOR_FORMAT_YCBCR422)) {
 		input_fmts = kcalloc(1, sizeof(*input_fmts), GFP_KERNEL);
 		if (!input_fmts)
-- 
2.39.5




