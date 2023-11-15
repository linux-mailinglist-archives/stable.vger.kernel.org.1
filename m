Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF32E7ED57C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjKOVH2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjKOVHY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:07:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563BA1A1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:07:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE58DC3277F;
        Wed, 15 Nov 2023 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081334;
        bh=JlYfsFndsBqwJdsHdXyfo0GpgAxblqdzNVFT7HBMYWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1q6RYjYQwrNZBLH8El857X2TRoB+KU34XlpnbMHBcLnjMS4XVUIHzeKh5zP7d0d5
         jDJWK7QO9UU8DVfY2XIMcf/9Saxe7HG86Nd1bpmsktiXewFapci8++bSqE0cVA0tA2
         RkFWrwbZKwX4pwEY7Y0EHLWnj4wQ1cifE8EcmqgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Adrien Grassein <adrien.grassein@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 090/244] drm/bridge: lt8912b: Add hot plug detection
Date:   Wed, 15 Nov 2023 15:34:42 -0500
Message-ID: <20231115203553.761315185@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

[ Upstream commit 3b0a01a6a5224ed9b3f69f44edaa889b2e2b9779 ]

Enable hot plug detection when it is available on the HDMI port.
Without this connecting to a different monitor with incompatible timing
before the 10 seconds poll period will lead to a broken display output.

Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20221128112320.25708-1-francesco@dolcini.it
Stable-dep-of: 941882a0e96d ("drm/bridge: lt8912b: Fix bridge_detach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 6ad3b2d1819f1..a89e505aa3811 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -506,14 +506,27 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 	return 0;
 }
 
+static void lt8912_bridge_hpd_cb(void *data, enum drm_connector_status status)
+{
+	struct lt8912 *lt = data;
+
+	if (lt->bridge.dev)
+		drm_helper_hpd_irq_event(lt->bridge.dev);
+}
+
 static int lt8912_bridge_connector_init(struct drm_bridge *bridge)
 {
 	int ret;
 	struct lt8912 *lt = bridge_to_lt8912(bridge);
 	struct drm_connector *connector = &lt->connector;
 
-	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
-			    DRM_CONNECTOR_POLL_DISCONNECT;
+	if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD) {
+		drm_bridge_hpd_enable(lt->hdmi_port, lt8912_bridge_hpd_cb, lt);
+		connector->polled = DRM_CONNECTOR_POLL_HPD;
+	} else {
+		connector->polled = DRM_CONNECTOR_POLL_CONNECT |
+				    DRM_CONNECTOR_POLL_DISCONNECT;
+	}
 
 	ret = drm_connector_init(bridge->dev, connector,
 				 &lt8912_connector_funcs,
@@ -567,6 +580,10 @@ static void lt8912_bridge_detach(struct drm_bridge *bridge)
 
 	if (lt->is_attached) {
 		lt8912_hard_power_off(lt);
+
+		if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD)
+			drm_bridge_hpd_disable(lt->hdmi_port);
+
 		drm_connector_unregister(&lt->connector);
 		drm_connector_cleanup(&lt->connector);
 	}
-- 
2.42.0



