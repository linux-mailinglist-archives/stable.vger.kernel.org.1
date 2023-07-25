Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A07613DF
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjGYLOt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjGYLO3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:14:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D463C1E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:13:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 807A1615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFEFC433C8;
        Tue, 25 Jul 2023 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283609;
        bh=cwVomBMHQqKFP9C/ArD09XLryqNUQT/tVt3FirnaOB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vr6EKRpWo8zajRENse4myqMCZXYo/iI5i+qXKVd+tzKTl/tErrJ+4NTqUqATpiRY/
         UWnNu9z+wzpAMui/YClZna72nvDwISnIxjeoKCfiMGugytIK8CmSBVq8Et8qa/z1//
         Or34YHqXZnqjFjr6MSB92isVVC85dRBDoQ+srs+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/509] thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()
Date:   Tue, 25 Jul 2023 12:39:29 +0200
Message-ID: <20230725104555.028006936@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 89382022b370dfd34eaae9c863baa123fcd4d132 ]

Should an error occur after calling sun8i_ths_resource_init() in the probe
function, some resources need to be released, as already done in the
.remove() function.

Switch to the devm_clk_get_enabled() helper and add a new devm_action to
turn sun8i_ths_resource_init() into a fully managed function.

Move the place where reset_control_deassert() is called so that the
recommended order of reset release/clock enable steps is kept.
A64 manual states that:

	3.3.6.4. Gating and reset

	Make sure that the reset signal has been released before the release of
	module clock gating;

This fixes the issue and removes some LoC at the same time.

Fixes: dccc5c3b6f30 ("thermal/drivers/sun8i: Add thermal driver for H6/H5/H3/A64/A83T/R40")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/a8ae84bd2dc4b55fe428f8e20f31438bf8bb6762.1684089931.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/sun8i_thermal.c | 55 +++++++++++----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index f8b13071a6f42..e053b06280172 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -318,6 +318,11 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	return ret;
 }
 
+static void sun8i_ths_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int sun8i_ths_resource_init(struct ths_device *tmdev)
 {
 	struct device *dev = tmdev->dev;
@@ -338,47 +343,35 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		if (IS_ERR(tmdev->reset))
 			return PTR_ERR(tmdev->reset);
 
-		tmdev->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		ret = reset_control_deassert(tmdev->reset);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
+					       tmdev->reset);
+		if (ret)
+			return ret;
+
+		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
 		if (IS_ERR(tmdev->bus_clk))
 			return PTR_ERR(tmdev->bus_clk);
 	}
 
 	if (tmdev->chip->has_mod_clk) {
-		tmdev->mod_clk = devm_clk_get(&pdev->dev, "mod");
+		tmdev->mod_clk = devm_clk_get_enabled(&pdev->dev, "mod");
 		if (IS_ERR(tmdev->mod_clk))
 			return PTR_ERR(tmdev->mod_clk);
 	}
 
-	ret = reset_control_deassert(tmdev->reset);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(tmdev->bus_clk);
-	if (ret)
-		goto assert_reset;
-
 	ret = clk_set_rate(tmdev->mod_clk, 24000000);
 	if (ret)
-		goto bus_disable;
-
-	ret = clk_prepare_enable(tmdev->mod_clk);
-	if (ret)
-		goto bus_disable;
+		return ret;
 
 	ret = sun8i_ths_calibrate(tmdev);
 	if (ret)
-		goto mod_disable;
+		return ret;
 
 	return 0;
-
-mod_disable:
-	clk_disable_unprepare(tmdev->mod_clk);
-bus_disable:
-	clk_disable_unprepare(tmdev->bus_clk);
-assert_reset:
-	reset_control_assert(tmdev->reset);
-
-	return ret;
 }
 
 static int sun8i_h3_thermal_init(struct ths_device *tmdev)
@@ -529,17 +522,6 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sun8i_ths_remove(struct platform_device *pdev)
-{
-	struct ths_device *tmdev = platform_get_drvdata(pdev);
-
-	clk_disable_unprepare(tmdev->mod_clk);
-	clk_disable_unprepare(tmdev->bus_clk);
-	reset_control_assert(tmdev->reset);
-
-	return 0;
-}
-
 static const struct ths_thermal_chip sun8i_a83t_ths = {
 	.sensor_num = 3,
 	.scale = 705,
@@ -641,7 +623,6 @@ MODULE_DEVICE_TABLE(of, of_ths_match);
 
 static struct platform_driver ths_driver = {
 	.probe = sun8i_ths_probe,
-	.remove = sun8i_ths_remove,
 	.driver = {
 		.name = "sun8i-thermal",
 		.of_match_table = of_ths_match,
-- 
2.39.2



