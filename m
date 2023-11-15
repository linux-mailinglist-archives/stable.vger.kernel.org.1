Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1E7ED4BD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbjKOU7A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344738AbjKOU5s (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D510A1BC9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F50C32792;
        Wed, 15 Nov 2023 20:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081356;
        bh=VJkqkpNm0iYxxz56rVMSWhb5pZRzCzKM1N5ql6gQubg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBWaiGrIY4WDfNqyLTP6iseP9yMCH2z+AzgpW8eQtO4y8psLALZa8i+bf/di88ZCs
         o0qoHPlw42X8Y6wTRaIPfIrfRpe8cfQ5pv/YYj1Hqhfu8VHs2vRUma4IzHLZl0KtoU
         tq9T/Fqa498Nzfd6KdNjAlwB3qqHc5AM15ZdlnPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 103/244] drm/bridge: lt9611uxc: Register and attach our DSI device at probe
Date:   Wed, 15 Nov 2023 15:34:55 -0500
Message-ID: <20231115203554.537187546@linuxfoundation.org>
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

[ Upstream commit 4a46ace5ac621c0f84b3910bc3c93acf6c93963b ]

In order to avoid any probe ordering issue, the best practice is to move
the secondary MIPI-DSI device registration and attachment to the
MIPI-DSI host at probe time. Let's do this.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20211025151536.1048186-11-maxime@cerno.tech
Stable-dep-of: 15fe53be46ea ("drm/bridge: lt9611uxc: fix the race in the error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 31 +++++++++++++---------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index b58842f69fff1..1e33b3150bdc5 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -367,18 +367,6 @@ static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
 			return ret;
 	}
 
-	/* Attach primary DSI */
-	lt9611uxc->dsi0 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi0_node);
-	if (IS_ERR(lt9611uxc->dsi0))
-		return PTR_ERR(lt9611uxc->dsi0);
-
-	/* Attach secondary DSI, if specified */
-	if (lt9611uxc->dsi1_node) {
-		lt9611uxc->dsi1 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi1_node);
-		if (IS_ERR(lt9611uxc->dsi1))
-			return PTR_ERR(lt9611uxc->dsi1);
-	}
-
 	return 0;
 }
 
@@ -958,8 +946,27 @@ static int lt9611uxc_probe(struct i2c_client *client,
 
 	drm_bridge_add(&lt9611uxc->bridge);
 
+	/* Attach primary DSI */
+	lt9611uxc->dsi0 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi0_node);
+	if (IS_ERR(lt9611uxc->dsi0)) {
+		ret = PTR_ERR(lt9611uxc->dsi0);
+		goto err_remove_bridge;
+	}
+
+	/* Attach secondary DSI, if specified */
+	if (lt9611uxc->dsi1_node) {
+		lt9611uxc->dsi1 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi1_node);
+		if (IS_ERR(lt9611uxc->dsi1)) {
+			ret = PTR_ERR(lt9611uxc->dsi1);
+			goto err_remove_bridge;
+		}
+	}
+
 	return lt9611uxc_audio_init(dev, lt9611uxc);
 
+err_remove_bridge:
+	drm_bridge_remove(&lt9611uxc->bridge);
+
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(lt9611uxc->supplies), lt9611uxc->supplies);
 
-- 
2.42.0



