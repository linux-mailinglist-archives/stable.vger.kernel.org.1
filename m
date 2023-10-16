Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6757CABDA
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjJPOqT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjJPOqS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:46:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCE7E1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:46:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BB0C433C8;
        Mon, 16 Oct 2023 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467576;
        bh=Cvc3GvLpHy/bSSGpQ77CvKS8kDaTmfRl4IgVwQ/k+I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzeLn5ShVBDaeeneLrvL6kt0HZON4hxDWhqTvIKGT2e1TCR/tpRR9CinAqGnya0ZF
         eG74T5DyUMQ2hzS/+Yrm/8oktpS1zKCrycIPl2KUf+HzcI4ms3022mv32DoscWVGT6
         12hBCqwyzHyXBdy6TNySTwwuAu+oqsS/urfCW5Oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Nia Espera <nespera@igalia.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 047/191] drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow
Date:   Mon, 16 Oct 2023 10:40:32 +0200
Message-ID: <20231016084016.507352868@linuxfoundation.org>
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

[ Upstream commit 95e681ca3b65e4ce3d2537b47672d787b7d30375 ]

_dpu_plane_calc_bw() uses integer variables to calculate the bandwidth
used during plane bandwidth calculations. However for high resolution
displays this overflows easily and leads to below errors

[dpu error]crtc83 failed performance check -7

Promote the intermediate variables to u64 to avoid overflow.

changes in v2:
	- change to u64 where actually needed in the math

Fixes: c33b7c0389e1 ("drm/msm/dpu: add support for clk and bw scaling for display")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reported-by: Nia Espera <nespera@igalia.com>
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/32
Tested-by: Nia Espera <nespera@igalia.com>
Patchwork: https://patchwork.freedesktop.org/patch/556288/
Link: https://lore.kernel.org/r/20230908012616.20654-1-quic_abhinavk@quicinc.com
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index c2aaaded07ed6..98c1b22e9bca0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -119,6 +119,7 @@ static u64 _dpu_plane_calc_bw(const struct dpu_mdss_cfg *catalog,
 	struct dpu_sw_pipe_cfg *pipe_cfg)
 {
 	int src_width, src_height, dst_height, fps;
+	u64 plane_pixel_rate, plane_bit_rate;
 	u64 plane_prefill_bw;
 	u64 plane_bw;
 	u32 hw_latency_lines;
@@ -136,13 +137,12 @@ static u64 _dpu_plane_calc_bw(const struct dpu_mdss_cfg *catalog,
 	scale_factor = src_height > dst_height ?
 		mult_frac(src_height, 1, dst_height) : 1;
 
-	plane_bw =
-		src_width * mode->vtotal * fps * fmt->bpp *
-		scale_factor;
+	plane_pixel_rate = src_width * mode->vtotal * fps;
+	plane_bit_rate = plane_pixel_rate * fmt->bpp;
 
-	plane_prefill_bw =
-		src_width * hw_latency_lines * fps * fmt->bpp *
-		scale_factor * mode->vtotal;
+	plane_bw = plane_bit_rate * scale_factor;
+
+	plane_prefill_bw = plane_bw * hw_latency_lines;
 
 	if ((vbp+vpw) > hw_latency_lines)
 		do_div(plane_prefill_bw, (vbp+vpw));
-- 
2.40.1



