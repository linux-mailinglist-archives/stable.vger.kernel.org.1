Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFD7ED08F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343559AbjKOT4Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343540AbjKOT4O (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA3BD55
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6EEC433C7;
        Wed, 15 Nov 2023 19:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078164;
        bh=k/xkIRHe0UG4UJEDTB7LuFQV1ySkfqBssCXD5BbShDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EkRYvKPNATSo6uh6+GeAx/5MhH+maEcnXQbFR2wagWldLOYA2kpB1ZWnHs4kdd4gj
         NKu7ksKx+YxhV/KuvCOt5I1CW4I/ckJmYu+6rIEhd6FtUb59F545IULNkuZOqMK/Oe
         nAGh/JSVh7uTfTpODf58Bs64WkUQmH0NWK68fxNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 151/379] drm/msm/dsi: free TX buffer in unbind
Date:   Wed, 15 Nov 2023 14:23:46 -0500
Message-ID: <20231115192654.047828758@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 5e05be78264594634860087953649487f486ffcc ]

If the drm/msm init code gets an error during output modeset
initialisation, the kernel will report an error regarding DRM memory
manager not being clean during shutdown. This is because
msm_dsi_modeset_init() allocates a piece of GEM memory for the TX
buffer, but destruction of the buffer happens only at
msm_dsi_host_destroy(), which is called during DSI driver's remove()
time, much later than the DRM MM shutdown.

To solve this issue, move the TX buffer destruction to dsi_unbind(), so
that the buffer is destructed at the correct time. Note, we also have to
store a reference to the address space, because priv->kms->aspace is
cleared before components are unbound.

Reported-by: Bjorn Andersson <andersson@kernel.org>
Fixes: 8f59ee9a570c ("drm/msm/dsi: Adjust probe order")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/562238/
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi.c      |  1 +
 drivers/gpu/drm/msm/dsi/dsi.h      |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c | 15 +++++++++------
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 8a95c744972a1..e9036e4036bc6 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -127,6 +127,7 @@ static void dsi_unbind(struct device *dev, struct device *master,
 	struct msm_drm_private *priv = dev_get_drvdata(master);
 	struct msm_dsi *msm_dsi = dev_get_drvdata(dev);
 
+	msm_dsi_tx_buf_free(msm_dsi->host);
 	priv->dsi[msm_dsi->id] = NULL;
 }
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 2a96b4fe7839f..6b239f77fca94 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -123,6 +123,7 @@ int dsi_tx_buf_alloc_v2(struct msm_dsi_host *msm_host, int size);
 void *dsi_tx_buf_get_6g(struct msm_dsi_host *msm_host);
 void *dsi_tx_buf_get_v2(struct msm_dsi_host *msm_host);
 void dsi_tx_buf_put_6g(struct msm_dsi_host *msm_host);
+void msm_dsi_tx_buf_free(struct mipi_dsi_host *mipi_host);
 int dsi_dma_base_get_6g(struct msm_dsi_host *msm_host, uint64_t *iova);
 int dsi_dma_base_get_v2(struct msm_dsi_host *msm_host, uint64_t *iova);
 int dsi_clk_init_v2(struct msm_dsi_host *msm_host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 4162595f15f1e..a7c6e8a1754de 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -149,6 +149,7 @@ struct msm_dsi_host {
 
 	/* DSI 6G TX buffer*/
 	struct drm_gem_object *tx_gem_obj;
+	struct msm_gem_address_space *aspace;
 
 	/* DSI v2 TX buffer */
 	void *tx_buf;
@@ -1127,8 +1128,10 @@ int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size)
 	uint64_t iova;
 	u8 *data;
 
+	msm_host->aspace = msm_gem_address_space_get(priv->kms->aspace);
+
 	data = msm_gem_kernel_new(dev, size, MSM_BO_WC,
-					priv->kms->aspace,
+					msm_host->aspace,
 					&msm_host->tx_gem_obj, &iova);
 
 	if (IS_ERR(data)) {
@@ -1157,10 +1160,10 @@ int dsi_tx_buf_alloc_v2(struct msm_dsi_host *msm_host, int size)
 	return 0;
 }
 
-static void dsi_tx_buf_free(struct msm_dsi_host *msm_host)
+void msm_dsi_tx_buf_free(struct mipi_dsi_host *host)
 {
+	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	struct drm_device *dev = msm_host->dev;
-	struct msm_drm_private *priv;
 
 	/*
 	 * This is possible if we're tearing down before we've had a chance to
@@ -1171,10 +1174,11 @@ static void dsi_tx_buf_free(struct msm_dsi_host *msm_host)
 	if (!dev)
 		return;
 
-	priv = dev->dev_private;
 	if (msm_host->tx_gem_obj) {
-		msm_gem_kernel_put(msm_host->tx_gem_obj, priv->kms->aspace);
+		msm_gem_kernel_put(msm_host->tx_gem_obj, msm_host->aspace);
+		msm_gem_address_space_put(msm_host->aspace);
 		msm_host->tx_gem_obj = NULL;
+		msm_host->aspace = NULL;
 	}
 
 	if (msm_host->tx_buf)
@@ -2013,7 +2017,6 @@ void msm_dsi_host_destroy(struct mipi_dsi_host *host)
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 
 	DBG("");
-	dsi_tx_buf_free(msm_host);
 	if (msm_host->workqueue) {
 		destroy_workqueue(msm_host->workqueue);
 		msm_host->workqueue = NULL;
-- 
2.42.0



