Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2837ED459
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbjKOU5v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbjKOU5a (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843910EC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC4C3277D;
        Wed, 15 Nov 2023 20:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081331;
        bh=/ehhWsY2bO6BpWO4x1KBnKKznbIVeDeJ7NXKiIisz0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLTG6UDI1h61zajeqob4ztT79R70w7aFJ8mzoMYTLcFPPSbGy3Oj54EjjCS85LCQH
         iwUw1qeXN1oIjWrJ7CxjHtbaBn4VstRds+i2UD4Ua1jmiqk8lwqvkIV+43zkRHZ1qO
         E5MKjv9JluXWamSJSdl6oDeoyXFJP9NJVPue1NZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 088/244] drm/bridge: lt8912b: Switch to devm MIPI-DSI helpers
Date:   Wed, 15 Nov 2023 15:34:40 -0500
Message-ID: <20231115203553.638111418@linuxfoundation.org>
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

From: Maxime Ripard <maxime@cerno.tech>

[ Upstream commit 1fdbf66e3d40257902b4c5cdf872730dae24004f ]

Let's switch to the new devm MIPI-DSI function to register and attach
our secondary device.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20211025151536.1048186-6-maxime@cerno.tech
Stable-dep-of: 941882a0e96d ("drm/bridge: lt8912b: Fix bridge_detach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index d3fd76a0a34ae..24ca22b0b9f56 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -481,11 +481,11 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 		return -EPROBE_DEFER;
 	}
 
-	dsi = mipi_dsi_device_register_full(host, &info);
+	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
 		ret = PTR_ERR(dsi);
 		dev_err(dev, "failed to create dsi device (%d)\n", ret);
-		goto err_dsi_device;
+		return ret;
 	}
 
 	lt->dsi = dsi;
@@ -497,24 +497,13 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 			  MIPI_DSI_MODE_LPM |
 			  MIPI_DSI_MODE_NO_EOT_PACKET;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "failed to attach dsi to host\n");
-		goto err_dsi_attach;
+		return ret;
 	}
 
 	return 0;
-
-err_dsi_attach:
-	mipi_dsi_device_unregister(dsi);
-err_dsi_device:
-	return ret;
-}
-
-static void lt8912_detach_dsi(struct lt8912 *lt)
-{
-	mipi_dsi_detach(lt->dsi);
-	mipi_dsi_device_unregister(lt->dsi);
 }
 
 static int lt8912_bridge_connector_init(struct drm_bridge *bridge)
@@ -581,7 +570,6 @@ static void lt8912_bridge_detach(struct drm_bridge *bridge)
 	struct lt8912 *lt = bridge_to_lt8912(bridge);
 
 	if (lt->is_attached) {
-		lt8912_detach_dsi(lt);
 		lt8912_hard_power_off(lt);
 		drm_connector_unregister(&lt->connector);
 		drm_connector_cleanup(&lt->connector);
-- 
2.42.0



