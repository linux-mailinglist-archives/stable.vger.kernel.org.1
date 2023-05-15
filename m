Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDA5703931
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243915AbjEORkJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244530AbjEORjv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87CB93CE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A62CB62DEE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EBEC433EF;
        Mon, 15 May 2023 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172198;
        bh=TFkufBmbjWOEFjG+8mkET8EfzYJk6FIXJkjZvYnvRr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNtCUSx7BffNJjo3x0K/TpBuSj5pzK0hUrxSYgiVXie/Cz53OuucqP+dipIWI0S3z
         TMaG03luc5Uc2bmezCs3PYfLHdVTEqygfgUszauPC4hWlTDMPrH/dz7RXZtLstFWkR
         maeQi4RjkuXC1cDcGORLrNvFd1DghI/V6bIpUzBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 076/381] soc: ti: pm33xx: Enable basic PM runtime support for genpd
Date:   Mon, 15 May 2023 18:25:27 +0200
Message-Id: <20230515161740.248469854@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 74033131d2467fda6b76ba10bc80a75fb47e03d1 ]

To prepare for moving to use genpd, let's enable basic PM
runtime support.

Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Suman Anna <s-anna@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Stable-dep-of: 8f3c307b580a ("soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/pm33xx.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index dc21aa855a458..332588de22f3f 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -19,6 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_data/pm33xx.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/rtc.h>
 #include <linux/rtc/rtc-omap.h>
 #include <linux/sizes.h>
@@ -555,16 +556,26 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
 #endif /* CONFIG_SUSPEND */
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		goto err_pm_runtime_disable;
+	}
+
 	ret = pm_ops->init(am33xx_do_sram_idle);
 	if (ret) {
 		dev_err(dev, "Unable to call core pm init!\n");
 		ret = -ENODEV;
-		goto err_put_wkup_m3_ipc;
+		goto err_pm_runtime_put;
 	}
 
 	return 0;
 
-err_put_wkup_m3_ipc:
+err_pm_runtime_put:
+	pm_runtime_put_sync(dev);
+err_pm_runtime_disable:
+	pm_runtime_disable(dev);
 	wkup_m3_ipc_put(m3_ipc);
 err_unsetup_rtc:
 	iounmap(rtc_base_virt);
@@ -577,6 +588,8 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 
 static int am33xx_pm_remove(struct platform_device *pdev)
 {
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	if (pm_ops->deinit)
 		pm_ops->deinit();
 	suspend_set_ops(NULL);
-- 
2.39.2



