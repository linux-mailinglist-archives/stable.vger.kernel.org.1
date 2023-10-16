Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC97CABD8
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjJPOqN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjJPOqM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:46:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C3E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:46:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C72C433CA;
        Mon, 16 Oct 2023 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467570;
        bh=x3lLDyrXWVOR89RdEFHs06IPEvDSmxE8N/S1eMOaX6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Brs7tpEEqDbBPFJ3+kCenTPIjnQYffriU+oTtjBjtz9wUg65UjSHnhUS0Xs+dmQhr
         ga4W/B5rWntEmYXYi2rRNCHfl/IIi7eZ9ncVyNbwXTZZKYipq6wQmzefxua/PmLSyD
         tHNVsRBSFi3CM8ysf59if5KK0Mlmo4TMuFGrxKi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 045/191] drm/msm/dsi: skip the wait for video mode done if not applicable
Date:   Mon, 16 Oct 2023 10:40:30 +0200
Message-ID: <20231016084016.461051004@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

[ Upstream commit ab483e3adcc178254eb1ce0fbdfbea65f86f1006 ]

dsi_wait4video_done() API waits for the DSI video mode engine to
become idle so that we can transmit the DCS commands in the
beginning of BLLP. However, with the current sequence, the MDP
timing engine is turned on after the panel's pre_enable() callback
which can send out the DCS commands needed to power up the panel.

During those cases, this API will always timeout and print out the
error spam leading to long bootup times and log flooding.

Fix this by checking if the DSI video engine was actually busy before
waiting for it to become idle otherwise this is a redundant wait.

changes in v2:
	- move the reg read below the video mode check
	- minor fixes in commit text

Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/34
Fixes: a689554ba6ed ("drm/msm: Initial add DSI connector support")
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/557853/
Link: https://lore.kernel.org/r/20230915204426.19011-1-quic_abhinavk@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 3f6dfb4f9d5a6..ee91bad0d5880 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1075,9 +1075,21 @@ static void dsi_wait4video_done(struct msm_dsi_host *msm_host)
 
 static void dsi_wait4video_eng_busy(struct msm_dsi_host *msm_host)
 {
+	u32 data;
+
 	if (!(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO))
 		return;
 
+	data = dsi_read(msm_host, REG_DSI_STATUS0);
+
+	/* if video mode engine is not busy, its because
+	 * either timing engine was not turned on or the
+	 * DSI controller has finished transmitting the video
+	 * data already, so no need to wait in those cases
+	 */
+	if (!(data & DSI_STATUS0_VIDEO_MODE_ENGINE_BUSY))
+		return;
+
 	if (msm_host->power_on && msm_host->enabled) {
 		dsi_wait4video_done(msm_host);
 		/* delay 4 ms to skip BLLP */
-- 
2.40.1



