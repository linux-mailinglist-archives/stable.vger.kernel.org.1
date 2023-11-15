Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272B37ED173
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344154AbjKOUBn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344167AbjKOUBm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:01:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5EA198
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:01:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3DAC433C7;
        Wed, 15 Nov 2023 20:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078498;
        bh=mwi+8XeHRj1Utk8gGATEf7tFno3Gp3d7br+fIGur2bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HzXxwuWy4D/WSgLHAl4fjFCStIeEJPRk/PnyKp25tsDpbwJEnMfzk0G+w88B6I7QZ
         gSxm0v78nQL5tzfJeuFQTq2FmND7s+p115kPysABGsWQAOSbIycItkz7ErPOMUVgfS
         VdHOb+UdfeRuDplZqfiPc0Pf3QSmq4du+P391I0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 334/379] watchdog: ixp4xx: Make sure restart always works
Date:   Wed, 15 Nov 2023 14:26:49 -0500
Message-ID: <20231115192704.914360611@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit b4075ecfe348a44209534c75ad72392c63a489a6 ]

The IXP4xx watchdog in early "A0" silicon is unreliable and
cannot be registered, however for some systems such as the
USRobotics USR8200 the watchdog is the only restart option,
so implement a "dummy" watchdog that can only support restart
in this case.

Fixes: 1aea522809e6 ("watchdog: ixp4xx: Implement restart")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230926-ixp4xx-wdt-restart-v2-1-15cf4639b423@linaro.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/ixp4xx_wdt.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index 281a48d9889fc..0fc91e9c4a773 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -105,6 +105,25 @@ static const struct watchdog_ops ixp4xx_wdt_ops = {
 	.owner = THIS_MODULE,
 };
 
+/*
+ * The A0 version of the IXP422 had a bug in the watchdog making
+ * is useless, but we still need to use it to restart the system
+ * as it is the only way, so in this special case we register a
+ * "dummy" watchdog that doesn't really work, but will support
+ * the restart operation.
+ */
+static int ixp4xx_wdt_dummy(struct watchdog_device *wdd)
+{
+	return 0;
+}
+
+static const struct watchdog_ops ixp4xx_wdt_restart_only_ops = {
+	.start = ixp4xx_wdt_dummy,
+	.stop = ixp4xx_wdt_dummy,
+	.restart = ixp4xx_wdt_restart,
+	.owner = THIS_MODULE,
+};
+
 static const struct watchdog_info ixp4xx_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING
 		| WDIOF_MAGICCLOSE
@@ -120,14 +139,17 @@ static void ixp4xx_clock_action(void *d)
 
 static int ixp4xx_wdt_probe(struct platform_device *pdev)
 {
+	static const struct watchdog_ops *iwdt_ops;
 	struct device *dev = &pdev->dev;
 	struct ixp4xx_wdt *iwdt;
 	struct clk *clk;
 	int ret;
 
 	if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
-		dev_err(dev, "Rev. A0 IXP42x CPU detected - watchdog disabled\n");
-		return -ENODEV;
+		dev_info(dev, "Rev. A0 IXP42x CPU detected - only restart supported\n");
+		iwdt_ops = &ixp4xx_wdt_restart_only_ops;
+	} else {
+		iwdt_ops = &ixp4xx_wdt_ops;
 	}
 
 	iwdt = devm_kzalloc(dev, sizeof(*iwdt), GFP_KERNEL);
@@ -153,7 +175,7 @@ static int ixp4xx_wdt_probe(struct platform_device *pdev)
 		iwdt->rate = IXP4XX_TIMER_FREQ;
 
 	iwdt->wdd.info = &ixp4xx_wdt_info;
-	iwdt->wdd.ops = &ixp4xx_wdt_ops;
+	iwdt->wdd.ops = iwdt_ops;
 	iwdt->wdd.min_timeout = 1;
 	iwdt->wdd.max_timeout = U32_MAX / iwdt->rate;
 	iwdt->wdd.parent = dev;
-- 
2.42.0



