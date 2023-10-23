Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA467D31BF
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjJWLMp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjJWLMl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:12:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB310CF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A218FC433C7;
        Mon, 23 Oct 2023 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059558;
        bh=YCAJHvv+322iXrFacMiU9ZyJXyBnXfIBrlZb7+KgYDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJ8RyH0tJeXanlqMJE+0gSQuXQNg3HzaEs7qMNPXOZJJsNczORs3bPLRNk8tBI8jy
         gpzbJuGcpDqJ7uI547neW8hivShTudYwt2Yo+eGupPuggRgOowJ2dwTXGz32sONpHe
         eoWqtAf1wbQzlQK2oriz/A9q0psZJiRrysJ1/Ar8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Stephen Boyd <swboyd@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 218/241] drm/bridge: ti-sn65dsi86: Associate DSI device lifetime with auxiliary device
Date:   Mon, 23 Oct 2023 12:56:44 +0200
Message-ID: <20231023104839.166867358@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 7b821db95140e2c118567aee22a78bf85f3617e0 ]

The kernel produces a warning splat and the DSI device fails to register
in this driver if the i2c driver probes, populates child auxiliary
devices, and then somewhere in ti_sn_bridge_probe() a function call
returns -EPROBE_DEFER. When the auxiliary driver probe defers, the dsi
device created by devm_mipi_dsi_device_register_full() is left
registered because the devm managed device used to manage the lifetime
of the DSI device is the parent i2c device, not the auxiliary device
that is being probed.

Associate the DSI device created and managed by this driver to the
lifetime of the auxiliary device, not the i2c device, so that the DSI
device is removed when the auxiliary driver unbinds. Similarly change
the device pointer used for dev_err_probe() so the deferred probe errors
are associated with the auxiliary device instead of the parent i2c
device so we can narrow down future problems faster.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231002235407.769399-1-swboyd@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index f448b903e1907..84148a79414b7 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -692,7 +692,7 @@ static struct ti_sn65dsi86 *bridge_to_ti_sn65dsi86(struct drm_bridge *bridge)
 	return container_of(bridge, struct ti_sn65dsi86, bridge);
 }
 
-static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
+static int ti_sn_attach_host(struct auxiliary_device *adev, struct ti_sn65dsi86 *pdata)
 {
 	int val;
 	struct mipi_dsi_host *host;
@@ -707,7 +707,7 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
 	if (!host)
 		return -EPROBE_DEFER;
 
-	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+	dsi = devm_mipi_dsi_device_register_full(&adev->dev, host, &info);
 	if (IS_ERR(dsi))
 		return PTR_ERR(dsi);
 
@@ -725,7 +725,7 @@ static int ti_sn_attach_host(struct ti_sn65dsi86 *pdata)
 
 	pdata->dsi = dsi;
 
-	return devm_mipi_dsi_attach(dev, dsi);
+	return devm_mipi_dsi_attach(&adev->dev, dsi);
 }
 
 static int ti_sn_bridge_attach(struct drm_bridge *bridge,
@@ -1298,9 +1298,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 	struct device_node *np = pdata->dev->of_node;
 	int ret;
 
-	pdata->next_bridge = devm_drm_of_get_bridge(pdata->dev, np, 1, 0);
+	pdata->next_bridge = devm_drm_of_get_bridge(&adev->dev, np, 1, 0);
 	if (IS_ERR(pdata->next_bridge))
-		return dev_err_probe(pdata->dev, PTR_ERR(pdata->next_bridge),
+		return dev_err_probe(&adev->dev, PTR_ERR(pdata->next_bridge),
 				     "failed to create panel bridge\n");
 
 	ti_sn_bridge_parse_lanes(pdata, np);
@@ -1319,9 +1319,9 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 
 	drm_bridge_add(&pdata->bridge);
 
-	ret = ti_sn_attach_host(pdata);
+	ret = ti_sn_attach_host(adev, pdata);
 	if (ret) {
-		dev_err_probe(pdata->dev, ret, "failed to attach dsi host\n");
+		dev_err_probe(&adev->dev, ret, "failed to attach dsi host\n");
 		goto err_remove_bridge;
 	}
 
-- 
2.42.0



