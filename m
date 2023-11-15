Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C27ECE47
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbjKOTmE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjKOTmD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5459A12C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC154C433C8;
        Wed, 15 Nov 2023 19:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077320;
        bh=L6vELtLA7OZsiREdpWgl0PhVtoH1FvHSHA5dHq+E9rU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idoUUqus7kElcFIF6p3If46JCpQhIH0O4/qSgsJbFK6lbAi+jGGHclvXqMGjw0pww
         7zZRb41lYrww3YKh8FAWp4exQMx+c4DRGGpITPmTYMm2Ig2hHYUe8chmAtekmbucMN
         P+q3M9Z0oI/JlxnMiguhJmjLxlcDGyS5wohTan6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 228/603] drm/bridge: lt8912b: Add missing drm_bridge_attach call
Date:   Wed, 15 Nov 2023 14:12:53 -0500
Message-ID: <20231115191628.971946285@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit f45acf7acf75921c0409d452f0165f51a19a74fd ]

The driver does not call drm_bridge_attach(), which causes the next
bridge to not be added to the bridge chain. This causes the pipeline
init to fail when DRM_BRIDGE_ATTACH_NO_CONNECTOR is used.

Add the call to drm_bridge_attach().

Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230804-lt8912b-v1-4-c542692c6a2f@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 9ee639e75a1c2..03532efb893bb 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -558,6 +558,13 @@ static int lt8912_bridge_attach(struct drm_bridge *bridge,
 	struct lt8912 *lt = bridge_to_lt8912(bridge);
 	int ret;
 
+	ret = drm_bridge_attach(bridge->encoder, lt->hdmi_port, bridge,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret < 0) {
+		dev_err(lt->dev, "Failed to attach next bridge (%d)\n", ret);
+		return ret;
+	}
+
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
 		ret = lt8912_bridge_connector_init(bridge);
 		if (ret) {
-- 
2.42.0



