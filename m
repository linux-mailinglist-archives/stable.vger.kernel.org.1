Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8AC7ECFB8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbjKOTuV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjKOTuU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:50:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58A5AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9FCC433C8;
        Wed, 15 Nov 2023 19:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077817;
        bh=Av/xsorMicMY0+Un8JPjsNxVDpjj9lLRM4flDhn/EdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C368jQiY535YK5iQ9D4Mtit9dq4ncs2RmjaoOKPWuelaJl2gSG4R+OW52LNBBsFpD
         dcEawU3Xlsr7Qt2KZL1z4S/4JvcXAZRZW4wQKPM4CwXO/Oj5B5Y1IbnzY4GTzUiRQY
         mc/Kyotn++AkthPMztW8lFh71BA4i1Zz1gXh5wDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 537/603] pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume
Date:   Wed, 15 Nov 2023 14:18:02 -0500
Message-ID: <20231115191649.006401069@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian.fainelli@broadcom.com>

[ Upstream commit e9bc4411548aaa738905d37851a0146c16b3bb21 ]

The suspend/resume functions currently utilize
clk_disable()/clk_enable() respectively which may be no-ops with certain
clock providers such as SCMI. Fix this to use clk_disable_unprepare()
and clk_prepare_enable() respectively as we should.

Fixes: 3a9f5957020f ("pwm: Add Broadcom BCM7038 PWM controller support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index a3faa9a3de7cc..a7d529bf76adc 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -288,7 +288,7 @@ static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_disable(p->clk);
+	clk_disable_unprepare(p->clk);
 
 	return 0;
 }
@@ -297,7 +297,7 @@ static int brcmstb_pwm_resume(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_enable(p->clk);
+	clk_prepare_enable(p->clk);
 
 	return 0;
 }
-- 
2.42.0



