Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EBA74C372
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjGILcn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjGILcP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB36695
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E46D60BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A36CC433C8;
        Sun,  9 Jul 2023 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902333;
        bh=Yal0FQE63yNb1fKw8N510CHUB4HPzQEJIbOHmq2mwR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xLT55xyQ+nbX8kUbS1z2QfeUL8sNpsC9kXSTBR8FAfA1mVMyIGR9A72K5G/9aj2Hd
         yiC6wE21x7qht6i6IH36ZNXWnhrLVSzwaewm/LFGJ6+UrkFswVWONXjjuirxa9GKJ9
         QKcXrhWLPMs5BD68RMtsUObUbU3AGVOH+/AykKL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 311/431] drm/msm/dp: Drop aux devices together with DP controller
Date:   Sun,  9 Jul 2023 13:14:19 +0200
Message-ID: <20230709111458.455342104@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit a7bfb2ad2184a1fba78be35209b6019aa8cc8d4d ]

Using devres to depopulate the aux bus made sure that upon a probe
deferral the EDP panel device would be destroyed and recreated upon next
attempt.

But the struct device which the devres is tied to is the DPUs
(drm_dev->dev), which may be happen after the DP controller is torn
down.

Indications of this can be seen in the commonly seen EDID-hexdump full
of zeros in the log, or the occasional/rare KASAN fault where the
panel's attempt to read the EDID information causes a use after free on
DP resources.

It's tempting to move the devres to the DP controller's struct device,
but the resources used by the device(s) on the aux bus are explicitly
torn down in the error path. The KASAN-reported use-after-free also
remains, as the DP aux "module" explicitly frees its devres-allocated
memory in this code path.

As such, explicitly depopulate the aux bus in the error path, and in the
component unbind path, to avoid these issues.

Fixes: 2b57f726611e ("drm/msm/dp: fix aux-bus EP lifetime")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/542163/
Link: https://lore.kernel.org/r/20230612220106.1884039-1-quic_bjorande@quicinc.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3f9a18410c0bb..97776f5e12524 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -325,6 +325,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
 
 	kthread_stop(dp->ev_tsk);
 
+	of_dp_aux_depopulate_bus(dp->aux);
+
 	dp_power_client_deinit(dp->power);
 	dp_unregister_audio_driver(dev, dp->audio);
 	dp_aux_unregister(dp->aux);
@@ -1538,11 +1540,6 @@ void msm_dp_debugfs_init(struct msm_dp *dp_display, struct drm_minor *minor)
 	}
 }
 
-static void of_dp_aux_depopulate_bus_void(void *data)
-{
-	of_dp_aux_depopulate_bus(data);
-}
-
 static int dp_display_get_next_bridge(struct msm_dp *dp)
 {
 	int rc;
@@ -1571,12 +1568,6 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
 		of_node_put(aux_bus);
 		if (rc)
 			goto error;
-
-		rc = devm_add_action_or_reset(dp->drm_dev->dev,
-						of_dp_aux_depopulate_bus_void,
-						dp_priv->aux);
-		if (rc)
-			goto error;
 	} else if (dp->is_edp) {
 		DRM_ERROR("eDP aux_bus not found\n");
 		return -ENODEV;
@@ -1601,6 +1592,7 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
 error:
 	if (dp->is_edp) {
 		disable_irq(dp_priv->irq);
+		of_dp_aux_depopulate_bus(dp_priv->aux);
 		dp_display_host_phy_exit(dp_priv);
 		dp_display_host_deinit(dp_priv);
 	}
-- 
2.39.2



