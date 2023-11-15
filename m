Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF457ECBEC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjKOTZU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjKOTZT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00B219D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C2EC433C8;
        Wed, 15 Nov 2023 19:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076315;
        bh=Obyl9zUnrL5WsasC3SmZjzA8vP/qAng/cwQB9NVk5Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWvD6gVICmBnxGwZ46l7gYW9Xsc1eUkYvPbIrb8CwQeHo51ClZv20XOZVUGSIgUXA
         dCmp5UxQRDBimvNYmNtzHOt1tJxX9ONxBH/o3fW8Raa3K3J5SN7T7SviRMNaICeZAm
         D8mCUtlRFWg09rbfzq2WNp5/r080xE9uX4H+pDQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 213/550] drm/bridge: lt8912b: Manually disable HPD only if it was enabled
Date:   Wed, 15 Nov 2023 14:13:17 -0500
Message-ID: <20231115191615.561975695@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 6985c5efc4057bc79137807295d84ada3123d051 ]

lt8912b only calls drm_bridge_hpd_enable() if it creates a connector and
the next bridge has DRM_BRIDGE_OP_HPD set. However, when calling
drm_bridge_hpd_disable() it misses checking if a connector was created,
calling drm_bridge_hpd_disable() even if HPD was never enabled. I don't
see any issues caused by this wrong call, though.

Add the check to avoid wrongly calling drm_bridge_hpd_disable().

Fixes: 3b0a01a6a522 ("drm/bridge: lt8912b: Add hot plug detection")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230804-lt8912b-v1-3-c542692c6a2f@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 2d752e083433f..9ee639e75a1c2 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -587,7 +587,7 @@ static void lt8912_bridge_detach(struct drm_bridge *bridge)
 
 	lt8912_hard_power_off(lt);
 
-	if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD)
+	if (lt->connector.dev && lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD)
 		drm_bridge_hpd_disable(lt->hdmi_port);
 }
 
-- 
2.42.0



