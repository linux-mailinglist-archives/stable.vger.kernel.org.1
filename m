Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562C97ED582
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjKOVHb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbjKOVHZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 16:07:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DCD1AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 13:07:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBEFC32780;
        Wed, 15 Nov 2023 20:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081335;
        bh=SMNyhAvDiOk4eTmY8X12WK9H0jBl9YoaGdzdLklCKag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQCaLTD9MUorh8cYl7gdAS5Ql6wWdC6lxOehNaimLvZ8+zDqCmbRszTAK94+5sqHf
         DcLXQbD5t+YVnPy7phJ/PDG08+isXA3IZJUWahFHRroBA5hven2PyvBByjurCWnYjO
         tVHeSCYlze8inoLY+VuwWdqlR03HtgdvfV+SwyjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 091/244] drm/bridge: lt8912b: Fix bridge_detach
Date:   Wed, 15 Nov 2023 15:34:43 -0500
Message-ID: <20231115203553.819887542@linuxfoundation.org>
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
index a89e505aa3811..d435cb3ed3808 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -43,7 +43,6 @@ struct lt8912 {
 
 	u8 data_lanes;
 	bool is_power_on;
-	bool is_attached;
 };
 
 static int lt8912_write_init_config(struct lt8912 *lt)
@@ -565,8 +564,6 @@ static int lt8912_bridge_attach(struct drm_bridge *bridge,
 	if (ret)
 		goto error;
 
-	lt->is_attached = true;
-
 	return 0;
 
 error:
@@ -578,15 +575,13 @@ static void lt8912_bridge_detach(struct drm_bridge *bridge)
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
@@ -746,7 +741,6 @@ static int lt8912_remove(struct i2c_client *client)
 {
 	struct lt8912 *lt = i2c_get_clientdata(client);
 
-	lt8912_bridge_detach(&lt->bridge);
 	drm_bridge_remove(&lt->bridge);
 	lt8912_free_i2c(lt);
 	lt8912_put_dt(lt);
-- 
2.42.0



