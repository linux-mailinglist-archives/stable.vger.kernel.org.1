Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9241C75D26D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGUS70 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGUS70 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:59:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1930D4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B55B361D80
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6477C433C8;
        Fri, 21 Jul 2023 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965964;
        bh=lBUxmHwEbRk4pXWSik+LYXm0C4G84yalt0hAQwvHWWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIWcS4KwkBIeNCasWGNFy/LjBwj69OGY+hDxjM9hXAVFxduuWAK7ELo/OI2y/Yo6Q
         kz1mwE7PDkifkw4eArv7fftQVaW4Kr5inAKVbKRk9I7SlEQvU95leE/u4ISa69/Aan
         hZCvrq4NrNmcnesxAPaMONYaiV/NmpVo/Wh+ucFk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yongqin Liu <yongqin.liu@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 177/532] drm/msm/dpu: do not enable color-management if DSPPs are not available
Date:   Fri, 21 Jul 2023 18:01:21 +0200
Message-ID: <20230721160623.986677292@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 3bcfc7b90465efd337d39b91b43972162f0d1908 ]

We can not support color management without DSPP blocks being provided
in the HW catalog. Do not enable color management for CRTCs if num_dspps
is 0.

Fixes: 4259ff7ae509 ("drm/msm/dpu: add support for pcc color block in dpu driver")
Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Sumit Semwal <sumit.semwal@linaro.org>
Tested-by: Yongqin Liu <yongqin.liu@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/542141/
Link: https://lore.kernel.org/r/20230612182534.3345805-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 4194689b6b35d..8be941c9b6a94 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1380,6 +1380,8 @@ static const struct drm_crtc_helper_funcs dpu_crtc_helper_funcs = {
 struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 				struct drm_plane *cursor)
 {
+	struct msm_drm_private *priv = dev->dev_private;
+	struct dpu_kms *dpu_kms = to_dpu_kms(priv->kms);
 	struct drm_crtc *crtc = NULL;
 	struct dpu_crtc *dpu_crtc = NULL;
 	int i;
@@ -1411,7 +1413,8 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 
 	drm_crtc_helper_add(crtc, &dpu_crtc_helper_funcs);
 
-	drm_crtc_enable_color_mgmt(crtc, 0, true, 0);
+	if (dpu_kms->catalog->dspp_count)
+		drm_crtc_enable_color_mgmt(crtc, 0, true, 0);
 
 	/* save user friendly CRTC name for later */
 	snprintf(dpu_crtc->name, DPU_CRTC_NAME_SIZE, "crtc%u", crtc->base.id);
-- 
2.39.2



