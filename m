Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC5A7DD3E7
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjJaRGM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbjJaRF6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:05:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B982137
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:03:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE664C433C8;
        Tue, 31 Oct 2023 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771803;
        bh=Vx4necyDxDLokXvCtSreCYtk8N/U6j00mx96U6vn1uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAIw2R0jlpe/j/b9J/bD2tpmdq7ZN+O49L2PaZdRioThH0cDRhpYKGpJtn7xNPOSk
         xznI1L3IF5tzVe11KUvlm/QBEWMWaFIZ1mX3EcO7CQrKuYYbBWl3sNBGaUICWHmAH0
         9iLAzryn7GQklBLJKgF9UCgClYvsE/s6VoB1R8JU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Takashi Iwai <tiwai@suse.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 05/86] ASoC: codecs: wcd938x: Convert to platform remove callback returning void
Date:   Tue, 31 Oct 2023 18:00:30 +0100
Message-ID: <20231031165918.777236098@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 7cd686a59b36860511965882dad1f76df2c25766 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20230315150745.67084-57-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 69a026a2357e ("ASoC: codecs: wcd938x: fix regulator leaks on probe errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index c3964aa00b288..73d7c92e87242 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3616,11 +3616,9 @@ static int wcd938x_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int wcd938x_remove(struct platform_device *pdev)
+static void wcd938x_remove(struct platform_device *pdev)
 {
 	component_master_del(&pdev->dev, &wcd938x_comp_ops);
-
-	return 0;
 }
 
 #if defined(CONFIG_OF)
@@ -3634,7 +3632,7 @@ MODULE_DEVICE_TABLE(of, wcd938x_dt_match);
 
 static struct platform_driver wcd938x_codec_driver = {
 	.probe = wcd938x_probe,
-	.remove = wcd938x_remove,
+	.remove_new = wcd938x_remove,
 	.driver = {
 		.name = "wcd938x_codec",
 		.of_match_table = of_match_ptr(wcd938x_dt_match),
-- 
2.42.0



