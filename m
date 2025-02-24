Return-Path: <stable+bounces-118730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F6A41AB6
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C031889854
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A752245007;
	Mon, 24 Feb 2025 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YNRCaNy7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0523F439
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392479; cv=none; b=pz6qQmI8hefVFpEIOBlNmM3mAPVoCkNrPFjuBdShjYc9CNmISJW/fKu2Ahrixg1bBf75JHWfj2DCORMaKWCU7/t8ZnU2oH75sIEux96i1yoK36ou/XdtpFUTYNS2rQFkfLyU2kz5PPW73P+BSuoDTJXtnjKYDYUJz8VfxbuZrbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392479; c=relaxed/simple;
	bh=GcEQiP5NJlWoi98mMosAdW162uAgkxUxkdLpUFM6rlM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s3TMXYgPzStj5cV2lTdNnMap0eN/yLOcvTsWQeVkvDSwLDqUeM3gQlpesKDG2roFRszuWfVlbAJoboLxhbxVct52k7Rqd8BGhXjy25M5upX1Gu1KtwjuzrD8EifOOY+8Pff6pdySVBBmP5nerM+O3FU8y5dfhlSAIS5MaFhQU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YNRCaNy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77DCC4CED6;
	Mon, 24 Feb 2025 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740392478;
	bh=GcEQiP5NJlWoi98mMosAdW162uAgkxUxkdLpUFM6rlM=;
	h=Subject:To:Cc:From:Date:From;
	b=YNRCaNy7k+XBKjax9SZXLWx2X3We/LU6KqHAJkOd11wi67I3pLgcYkFmHEw4PVusT
	 wr0bOfbndFC4Kk3C6mMLXJqy/z4gzmgznf4ZdhL49KiKxQQM65oikWKpTQRQjs6X3Y
	 NPsVtpLufuaSCesSixRIj7boEc2IGvhBQ4WzeEKY=
Subject: FAILED: patch "[PATCH] drm/msm/dp: account for widebus and yuv420 during mode" failed to apply to 6.12-stable tree
To: quic_abhinavk@quicinc.com,daleyo@gmail.com,dmitry.baryshkov@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:20:57 +0100
Message-ID: <2025022457-capitol-primate-f197@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x df9cf852ca3099feb8fed781bdd5d3863af001c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022457-capitol-primate-f197@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df9cf852ca3099feb8fed781bdd5d3863af001c8 Mon Sep 17 00:00:00 2001
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
Date: Thu, 6 Feb 2025 11:46:36 -0800
Subject: [PATCH] drm/msm/dp: account for widebus and yuv420 during mode
 validation

Widebus allows the DP controller to operate in 2 pixel per clock mode.
The mode validation logic validates the mode->clock against the max
DP pixel clock. However the max DP pixel clock limit assumes widebus
is already enabled. Adjust the mode validation logic to only compare
the adjusted pixel clock which accounts for widebus against the max DP
pixel clock. Also fix the mode validation logic for YUV420 modes as in
that case as well, only half the pixel clock is needed.

Cc: stable@vger.kernel.org
Fixes: 757a2f36ab09 ("drm/msm/dp: enable widebus feature for display port")
Fixes: 6db6e5606576 ("drm/msm/dp: change clock related programming for YUV420 over DP")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dale Whinham <daleyo@gmail.com>
Patchwork: https://patchwork.freedesktop.org/patch/635789/
Link: https://lore.kernel.org/r/20250206-dp-widebus-fix-v2-1-cb89a0313286@quicinc.com
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d852e7a85334..a129e26c3ddb 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -930,16 +930,17 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (mode->clock > DP_MAX_PIXEL_CLK_KHZ)
-		return MODE_CLOCK_HIGH;
-
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 	link_info = &msm_dp_display->panel->link_info;
 
-	if (drm_mode_is_420_only(&dp->connector->display_info, mode) &&
-	    msm_dp_display->panel->vsc_sdp_supported)
+	if ((drm_mode_is_420_only(&dp->connector->display_info, mode) &&
+	     msm_dp_display->panel->vsc_sdp_supported) ||
+	     msm_dp_wide_bus_available(dp))
 		mode_pclk_khz /= 2;
 
+	if (mode_pclk_khz > DP_MAX_PIXEL_CLK_KHZ)
+		return MODE_CLOCK_HIGH;
+
 	mode_bpp = dp->connector->display_info.bpc * num_components;
 	if (!mode_bpp)
 		mode_bpp = default_bpp;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index d3e241ea6941..16b7913d1eef 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -257,7 +257,10 @@ static enum drm_mode_status msm_edp_bridge_mode_valid(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (mode->clock > DP_MAX_PIXEL_CLK_KHZ)
+	if (msm_dp_wide_bus_available(dp))
+		mode_pclk_khz /= 2;
+
+	if (mode_pclk_khz > DP_MAX_PIXEL_CLK_KHZ)
 		return MODE_CLOCK_HIGH;
 
 	/*


