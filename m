Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B907ED30F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjKOUp7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjKOUp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:45:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E51BE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:45:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A30EC433C7;
        Wed, 15 Nov 2023 20:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081154;
        bh=GFufORipAGPuid5m4wGJd3YX8mOsi8CwcIOhy31RorI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nK7uNY9LvRCQY42WmkndCyeCRy5/urE9ngi9ANsNPUJDvk5j2+P3aWPLqrlsmnyGj
         jYfjgGHZj/lnh9vqgyp/P3CXtRtzOuUog3tZ2Sx4Z1s+Vx6BCZWBe4WjWzSMZ8r0l1
         vurN+mMnHimbnNYPkWY/VfamEc+AG0k4iTjIhs5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 70/88] pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume
Date:   Wed, 15 Nov 2023 15:36:22 -0500
Message-ID: <20231115191430.312357267@linuxfoundation.org>
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
index 8063cffa1c960..5d7842a62d594 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -307,7 +307,7 @@ static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_disable(p->clk);
+	clk_disable_unprepare(p->clk);
 
 	return 0;
 }
@@ -316,7 +316,7 @@ static int brcmstb_pwm_resume(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_enable(p->clk);
+	clk_prepare_enable(p->clk);
 
 	return 0;
 }
-- 
2.42.0



