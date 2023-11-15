Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582BE7ED446
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjKOU5f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjKOU5Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061219F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5408DC3277E;
        Wed, 15 Nov 2023 20:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081332;
        bh=VYmoS7hIaiL6xUH+NNLe8QVhSW8D439j3tvxm5be3EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBmiprtoHA9LFHCXZ1ZDTrygD8BuJyqJ0eF6lFc4FlzyCwftWSQDe6BKG6tbJ17Se
         pdt0v/QBboMcD3RqV3Ancqh66gnrBWBQsLeo76DVCtQV9+kJ33+BfFzvk1RGjCPYFQ
         ftf7+uGjRu9B0qd7GhgEbu6aI8W7y+dtHYjkhjLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 089/244] drm/bridge: lt8912b: Register and attach our DSI device at probe
Date:   Wed, 15 Nov 2023 15:34:41 -0500
Message-ID: <20231115203553.699521100@linuxfoundation.org>
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

[ Upstream commit d89078c37b10f05fa4f4791b71db2572db361b68 ]

In order to avoid any probe ordering issue, the best practice is to move
the secondary MIPI-DSI device registration and attachment to the
MIPI-DSI host at probe time. Let's do this.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20211025151536.1048186-7-maxime@cerno.tech
Stable-dep-of: 941882a0e96d ("drm/bridge: lt8912b: Fix bridge_detach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 24ca22b0b9f56..6ad3b2d1819f1 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -552,10 +552,6 @@ static int lt8912_bridge_attach(struct drm_bridge *bridge,
 	if (ret)
 		goto error;
 
-	ret = lt8912_attach_dsi(lt);
-	if (ret)
-		goto error;
-
 	lt->is_attached = true;
 
 	return 0;
@@ -714,8 +710,15 @@ static int lt8912_probe(struct i2c_client *client,
 
 	drm_bridge_add(&lt->bridge);
 
+	ret = lt8912_attach_dsi(lt);
+	if (ret)
+		goto err_attach;
+
 	return 0;
 
+err_attach:
+	drm_bridge_remove(&lt->bridge);
+	lt8912_free_i2c(lt);
 err_i2c:
 	lt8912_put_dt(lt);
 err_dt_parse:
-- 
2.42.0



