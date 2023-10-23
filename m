Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0A7D34E9
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjJWLnp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjJWLn3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:43:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF310FE
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:43:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C441BC433C7;
        Mon, 23 Oct 2023 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061406;
        bh=yIXFesigVfZvzlUMw6/IiHdVxXN2L7x7FUNNWTIwT1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPXw2O5tJseyDTymV3/HsgpXjL/ssv+p/uUkELOnDSRD2hTGfOQixhjH39hEC0Kj1
         mOfQatwimg2kYNT3gTe4cPVr4/dJEKTEmY9StLSxUVV9HPuD2qiw0gB7CyvdqP60WG
         ztkWVstm5zIUJsO+WH65WOVAHK65TO7yvCYXtXwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 010/202] drm/msm/dp: do not reinitialize phy unless retry during link training
Date:   Mon, 23 Oct 2023 12:55:17 +0200
Message-ID: <20231023104826.894116571@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuogee Hsieh <quic_khsieh@quicinc.com>

[ Upstream commit 0c1a2e69bcb506f48ebf94bd199bab0b93f66da2 ]

DP PHY re-initialization done using dp_ctrl_reinitialize_mainlink() will
cause PLL unlocked initially and then PLL gets locked at the end of
initialization. PLL_UNLOCKED interrupt will fire during this time if the
interrupt mask is enabled.

However currently DP driver link training implementation incorrectly
re-initializes PHY unconditionally during link training as the PHY was
already configured in dp_ctrl_enable_mainlink_clocks().

Fix this by re-initializing the PHY only if the previous link training
failed.

[drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/30
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Tested-by: Abhinav Kumar <quic_abhinavk@quicinc.com> # sc7280
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/551847/
Link: https://lore.kernel.org/r/1691533190-19335-1-git-send-email-quic_khsieh@quicinc.com
[quic_abhinavk@quicinc.com: added line break in commit text]
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 9fac55c24214a..07becbf3c64fc 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1665,13 +1665,6 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 		return rc;
 
 	while (--link_train_max_retries) {
-		rc = dp_ctrl_reinitialize_mainlink(ctrl);
-		if (rc) {
-			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n",
-					rc);
-			break;
-		}
-
 		training_step = DP_TRAINING_NONE;
 		rc = dp_ctrl_setup_main_link(ctrl, &cr, &training_step);
 		if (rc == 0) {
@@ -1712,6 +1705,12 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 				break; /* lane == 1 already */
 			}
 		}
+
+		rc = dp_ctrl_reinitialize_mainlink(ctrl);
+		if (rc) {
+			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n", rc);
+			break;
+		}
 	}
 
 	if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN)
-- 
2.40.1



