Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894BE7CA2E2
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjJPI4b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjJPI4b (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:56:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D56DE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:56:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BF9C433C9;
        Mon, 16 Oct 2023 08:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446587;
        bh=DS2p/sC1CiCfUBsqjuxNX8wbKIvyk/Ac0kb6NFbuvAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaPB7eJcfNkKkWg8MusavxLr8iJTNbv0WitqS0XCoTEy4OUKL4d7AbikEqucahBiU
         tXs0kUXvIQy6Ups2HejTn3MGp+TiwyrTHp22R7U3vdGWaJxNN18us30k8gJInwbplW
         4QOvsR8GA5CZopcXF7+iGa0cxlJl48MQF6FSrEVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Nia Espera <nespera@igalia.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 037/131] drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow
Date:   Mon, 16 Oct 2023 10:40:20 +0200
Message-ID: <20231016084000.989943447@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 3fbda2a1f77fc..62d48c0f905e4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -142,6 +142,7 @@ static void _dpu_plane_calc_bw(struct drm_plane *plane,
 	const struct dpu_format *fmt = NULL;
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
 	int src_width, src_height, dst_height, fps;
+	u64 plane_pixel_rate, plane_bit_rate;
 	u64 plane_prefill_bw;
 	u64 plane_bw;
 	u32 hw_latency_lines;
@@ -164,13 +165,12 @@ static void _dpu_plane_calc_bw(struct drm_plane *plane,
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



