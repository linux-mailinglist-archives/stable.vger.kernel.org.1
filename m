Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142937A3A74
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbjIQUDp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240504AbjIQUDM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:03:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEEC185
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:03:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCEFC433C9;
        Sun, 17 Sep 2023 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980984;
        bh=CZdlYMkaBkc4Dha1iXay2XjvT7Dj3S88/iHjkQgn/b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6wJUVwnRkqpAzCHXbfr0JV2at8x+4vCYqKzQoPsgvGCcRDG2vLlHIlXuc/GZZtPF
         6ov6J/Vi9TALE/UCYv7q3QM0zN0h+EsFk0pNHgPnZDWiFcKjCGzOGfuVGgPqhzKgSa
         vSSbH9xGFe0OAy0dyflOTZ5vfL5CW9D25EvVKiHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 066/219] pwm: atmel-tcb: Convert to platform remove callback returning void
Date:   Sun, 17 Sep 2023 21:13:13 +0200
Message-ID: <20230917191043.380915891@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 9609284a76978daf53a54e05cff36873a75e4d13 ]

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
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: c11622324c02 ("pwm: atmel-tcb: Fix resource freeing in error path and remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-atmel-tcb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 2837b4ce8053c..4a116dc44f6e7 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -500,7 +500,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int atmel_tcb_pwm_remove(struct platform_device *pdev)
+static void atmel_tcb_pwm_remove(struct platform_device *pdev)
 {
 	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
 
@@ -509,8 +509,6 @@ static int atmel_tcb_pwm_remove(struct platform_device *pdev)
 	clk_disable_unprepare(tcbpwm->slow_clk);
 	clk_put(tcbpwm->slow_clk);
 	clk_put(tcbpwm->clk);
-
-	return 0;
 }
 
 static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
@@ -564,7 +562,7 @@ static struct platform_driver atmel_tcb_pwm_driver = {
 		.pm = &atmel_tcb_pwm_pm_ops,
 	},
 	.probe = atmel_tcb_pwm_probe,
-	.remove = atmel_tcb_pwm_remove,
+	.remove_new = atmel_tcb_pwm_remove,
 };
 module_platform_driver(atmel_tcb_pwm_driver);
 
-- 
2.40.1



