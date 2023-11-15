Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B857ED07B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbjKOTzy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjKOTz2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:55:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0CD1702
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:55:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE261C433CC;
        Wed, 15 Nov 2023 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078120;
        bh=vpizGsADhLgNZ1HwW69alU7C8URUQPNIFSacLBzJLy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pD3t6/B/yC047uVzRxi6jOcfbR1u4OuvHdjl0o/2v8UNzkaiwPhJ0d0fjZV7M4Vyc
         dH8aQd+b1xNwBk+5P5T8bgz0HuT8msgg4J8BrhUW0mxgivJd1LoPRa+k6NLolV+ij1
         3y0Tht0q78iO0k6TOAWq1n9vhkxogrI2VC58XJ1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 122/379] drm/bridge: lt8912b: Fix bridge_detach
Date:   Wed, 15 Nov 2023 14:23:17 -0500
Message-ID: <20231115192652.340244550@linuxfoundation.org>
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

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 941882a0e96d245f38116e940912b404b6a93c6f ]

The driver calls lt8912_bridge_detach() from its lt8912_remove()
function. As the DRM core detaches bridges automatically, this leads to
calling lt8912_bridge_detach() twice. The code probably has tried to
manage the double-call with the 'is_attached' variable, but the driver
never sets the variable to false, so its of no help.

Fix the issue by dropping the call to lt8912_bridge_detach() from
lt8912_remove(), as the DRM core will handle the detach call for us,
and also drop the useless is_attached field.

Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230804-lt8912b-v1-1-c542692c6a2f@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 8d2785a305b39..dc16b0d01bcb9 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -45,7 +45,6 @@ struct lt8912 {
 
 	u8 data_lanes;
 	bool is_power_on;
-	bool is_attached;
 };
 
 static int lt8912_write_init_config(struct lt8912 *lt)
@@ -575,8 +574,6 @@ static int lt8912_bridge_attach(struct drm_bridge *bridge,
 	if (ret)
 		goto error;
 
-	lt->is_attached = true;
-
 	return 0;
 
 error:
@@ -588,15 +585,13 @@ static void lt8912_bridge_detach(struct drm_bridge *bridge)
 {
 	struct lt8912 *lt = bridge_to_lt8912(bridge);
 
-	if (lt->is_attached) {
-		lt8912_hard_power_off(lt);
+	lt8912_hard_power_off(lt);
 
-		if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD)
-			drm_bridge_hpd_disable(lt->hdmi_port);
+	if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD)
+		drm_bridge_hpd_disable(lt->hdmi_port);
 
-		drm_connector_unregister(&lt->connector);
-		drm_connector_cleanup(&lt->connector);
-	}
+	drm_connector_unregister(&lt->connector);
+	drm_connector_cleanup(&lt->connector);
 }
 
 static enum drm_connector_status
@@ -751,7 +746,6 @@ static void lt8912_remove(struct i2c_client *client)
 {
 	struct lt8912 *lt = i2c_get_clientdata(client);
 
-	lt8912_bridge_detach(&lt->bridge);
 	drm_bridge_remove(&lt->bridge);
 	lt8912_free_i2c(lt);
 	lt8912_put_dt(lt);
-- 
2.42.0



