Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A749775D224
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGUS4X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjGUS4W (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469CF30DB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6ECF61D7F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9929C433C7;
        Fri, 21 Jul 2023 18:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965780;
        bh=UfWFcywoK3RUd4lvOsWBPWLfXabWC/2ZkoTNMQ4X0dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cT7JOb+qsTpyG6FYmd569XXslwzOxuzciTh1HlneUe5WIWGsm1wT3zjrACFJyiAIG
         K7x556JlSBd8Ui/nzHgby4Eslnf1i4MqXZmJZ/tbyGlbJrES6TGV1IBpOdOk5MlVqr
         Eqab6JU/nG7qAOB0Pw8ezk7DXNFGZXt2mcOtCbmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, XuDong Liu <m202071377@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 112/532] drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`
Date:   Fri, 21 Jul 2023 18:00:16 +0200
Message-ID: <20230721160620.642115814@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: XuDong Liu <m202071377@hust.edu.cn>

[ Upstream commit 123ee07ba5b7123e0ce0e0f9d64938026c16a2ce ]

Smatch reports:
drivers/gpu/drm/sun4i/sun4i_tcon.c:805 sun4i_tcon_init_clocks() warn:
'tcon->clk' from clk_prepare_enable() not released on lines: 792,801.

In the function sun4i_tcon_init_clocks(), tcon->clk and tcon->sclk0 are
not disabled in the error handling, which affects the release of
these variable. Although sun4i_tcon_bind(), which calls
sun4i_tcon_init_clocks(), use sun4i_tcon_free_clocks to disable the
variables mentioned, but the error handling branch of
sun4i_tcon_init_clocks() ignores the required disable process.

To fix this issue, use the devm_clk_get_enabled to automatically
balance enable and disabled calls. As original implementation use
sun4i_tcon_free_clocks() to disable clk explicitly, we delete the
related calls and error handling that are no longer needed.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Fixes: b14e945bda8a ("drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init")
Fixes: 8e9240472522 ("drm/sun4i: support TCONs without channel 1")
Fixes: 34d698f6e349 ("drm/sun4i: Add has_channel_0 TCON quirk")
Signed-off-by: XuDong Liu <m202071377@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20230430112347.4689-1-m202071377@hust.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 9f06dec0fc61d..bb43196d5d83e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -777,21 +777,19 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 static int sun4i_tcon_init_clocks(struct device *dev,
 				  struct sun4i_tcon *tcon)
 {
-	tcon->clk = devm_clk_get(dev, "ahb");
+	tcon->clk = devm_clk_get_enabled(dev, "ahb");
 	if (IS_ERR(tcon->clk)) {
 		dev_err(dev, "Couldn't get the TCON bus clock\n");
 		return PTR_ERR(tcon->clk);
 	}
-	clk_prepare_enable(tcon->clk);
 
 	if (tcon->quirks->has_channel_0) {
-		tcon->sclk0 = devm_clk_get(dev, "tcon-ch0");
+		tcon->sclk0 = devm_clk_get_enabled(dev, "tcon-ch0");
 		if (IS_ERR(tcon->sclk0)) {
 			dev_err(dev, "Couldn't get the TCON channel 0 clock\n");
 			return PTR_ERR(tcon->sclk0);
 		}
 	}
-	clk_prepare_enable(tcon->sclk0);
 
 	if (tcon->quirks->has_channel_1) {
 		tcon->sclk1 = devm_clk_get(dev, "tcon-ch1");
@@ -804,12 +802,6 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 	return 0;
 }
 
-static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
-{
-	clk_disable_unprepare(tcon->sclk0);
-	clk_disable_unprepare(tcon->clk);
-}
-
 static int sun4i_tcon_init_irq(struct device *dev,
 			       struct sun4i_tcon *tcon)
 {
@@ -1224,14 +1216,14 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	ret = sun4i_tcon_init_regmap(dev, tcon);
 	if (ret) {
 		dev_err(dev, "Couldn't init our TCON regmap\n");
-		goto err_free_clocks;
+		goto err_assert_reset;
 	}
 
 	if (tcon->quirks->has_channel_0) {
 		ret = sun4i_dclk_create(dev, tcon);
 		if (ret) {
 			dev_err(dev, "Couldn't create our TCON dot clock\n");
-			goto err_free_clocks;
+			goto err_assert_reset;
 		}
 	}
 
@@ -1294,8 +1286,6 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 err_free_dotclock:
 	if (tcon->quirks->has_channel_0)
 		sun4i_dclk_free(tcon);
-err_free_clocks:
-	sun4i_tcon_free_clocks(tcon);
 err_assert_reset:
 	reset_control_assert(tcon->lcd_rst);
 	return ret;
@@ -1309,7 +1299,6 @@ static void sun4i_tcon_unbind(struct device *dev, struct device *master,
 	list_del(&tcon->list);
 	if (tcon->quirks->has_channel_0)
 		sun4i_dclk_free(tcon);
-	sun4i_tcon_free_clocks(tcon);
 }
 
 static const struct component_ops sun4i_tcon_ops = {
-- 
2.39.2



