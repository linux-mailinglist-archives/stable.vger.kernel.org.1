Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437817CABDC
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjJPOq1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjJPOq0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:46:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5B2AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:46:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B425EC433C7;
        Mon, 16 Oct 2023 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467583;
        bh=39gYdX/ocyZhQSSdcA51u6T5T9x0hCeCmmwPWa9Z9m0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVSCiDBZ5nRI3AfXFHVovc0UK8kbIjvW9QVKBRE3eGtwwbuNAVTzH3MhG7U2edsM0
         4NOAKHC7qZUeMBR8M883u/SoCOoRl1w0ldiPYE9+y52eeTKnRZRvL+ne84QsvkUjod
         9l3XP4bxS0dIT4NFxMG+9oc2/hy4UexouEzLx3bY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 049/191] drm/msm/dpu: fail dpu_plane_atomic_check() based on mdp clk limits
Date:   Mon, 16 Oct 2023 10:40:34 +0200
Message-ID: <20231016084016.553529759@linuxfoundation.org>
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

[ Upstream commit 10f20628c9b8e924b8046e63b36b2cea4d2c85e4 ]

Currently, dpu_plane_atomic_check() does not check whether the
plane can process the image without exceeding the per chipset
limits for MDP clock. This leads to underflow issues because the
SSPP is not able to complete the processing for the data rate of
the display.

Fail the dpu_plane_atomic_check() if the SSPP cannot process the
image without exceeding the MDP clock limits.

changes in v2:
	- use crtc_state's adjusted_mode instead of mode

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/556819/
Link: https://lore.kernel.org/r/20230911221627.9569-1-quic_abhinavk@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 98c1b22e9bca0..0be195f9149c5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -733,9 +733,11 @@ static int dpu_plane_check_inline_rotation(struct dpu_plane *pdpu,
 static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
 		struct dpu_sw_pipe *pipe,
 		struct dpu_sw_pipe_cfg *pipe_cfg,
-		const struct dpu_format *fmt)
+		const struct dpu_format *fmt,
+		const struct drm_display_mode *mode)
 {
 	uint32_t min_src_size;
+	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
 
 	min_src_size = DPU_FORMAT_IS_YUV(fmt) ? 2 : 1;
 
@@ -774,6 +776,12 @@ static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
 		return -EINVAL;
 	}
 
+	/* max clk check */
+	if (_dpu_plane_calc_clk(mode, pipe_cfg) > kms->perf.max_core_clk_rate) {
+		DPU_DEBUG_PLANE(pdpu, "plane exceeds max mdp core clk limits\n");
+		return -E2BIG;
+	}
+
 	return 0;
 }
 
@@ -899,12 +907,13 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 		r_pipe_cfg->dst_rect.x1 = pipe_cfg->dst_rect.x2;
 	}
 
-	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt);
+	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg, fmt, &crtc_state->adjusted_mode);
 	if (ret)
 		return ret;
 
 	if (r_pipe->sspp) {
-		ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg, fmt);
+		ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg, fmt,
+						  &crtc_state->adjusted_mode);
 		if (ret)
 			return ret;
 	}
-- 
2.40.1



