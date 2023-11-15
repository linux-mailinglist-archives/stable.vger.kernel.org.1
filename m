Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3667ED30D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjKOUp4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjKOUpz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:45:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63F71AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:45:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D13C433C7;
        Wed, 15 Nov 2023 20:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081151;
        bh=fjjiaJRGZWJLDisafsJmQLAWXfc3eDxVb9f/msj1rnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHLokBM7dgoeVrm1sp1PwoFjmgeScscT5SizJBoQMLdU94y8HTF/YZKZURdUXIKzb
         v7np8Y273nUfX/pZhbl7wJdKpIUm32jZ6ApM3WobVUb4NcmqgK9R5xEBW0hGmLS9Ja
         lCneR904Unk9c3HHxIxnzCA/jEAdOzAtuz4KOsJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 68/88] pwm: sti: Avoid conditional gotos
Date:   Wed, 15 Nov 2023 15:36:20 -0500
Message-ID: <20231115191430.197982388@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <thierry.reding@gmail.com>

[ Upstream commit fd3ae02bb66f091e55f363d32eca7b4039977bf5 ]

Using gotos for conditional code complicates this code significantly.
Convert the code to simple conditional blocks to increase readability.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: 2d6812b41e0d ("pwm: sti: Reduce number of allocations and drop usage of chip_data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-sti.c | 48 ++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 2b7c31c9d1ab2..f413b41dc69d8 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -599,38 +599,34 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (!cdata->pwm_num_devs)
-		goto skip_pwm;
-
-	pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
-	if (IS_ERR(pc->pwm_clk)) {
-		dev_err(dev, "failed to get PWM clock\n");
-		return PTR_ERR(pc->pwm_clk);
-	}
+	if (cdata->pwm_num_devs) {
+		pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
+		if (IS_ERR(pc->pwm_clk)) {
+			dev_err(dev, "failed to get PWM clock\n");
+			return PTR_ERR(pc->pwm_clk);
+		}
 
-	ret = clk_prepare(pc->pwm_clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		return ret;
+		ret = clk_prepare(pc->pwm_clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare clock\n");
+			return ret;
+		}
 	}
 
-skip_pwm:
-	if (!cdata->cpt_num_devs)
-		goto skip_cpt;
-
-	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
-	if (IS_ERR(pc->cpt_clk)) {
-		dev_err(dev, "failed to get PWM capture clock\n");
-		return PTR_ERR(pc->cpt_clk);
-	}
+	if (cdata->cpt_num_devs) {
+		pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
+		if (IS_ERR(pc->cpt_clk)) {
+			dev_err(dev, "failed to get PWM capture clock\n");
+			return PTR_ERR(pc->cpt_clk);
+		}
 
-	ret = clk_prepare(pc->cpt_clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		return ret;
+		ret = clk_prepare(pc->cpt_clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare clock\n");
+			return ret;
+		}
 	}
 
-skip_cpt:
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
-- 
2.42.0



