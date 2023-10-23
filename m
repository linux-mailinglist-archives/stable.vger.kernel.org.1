Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2241D7D3334
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjJWL1t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjJWL1t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:27:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFE7E4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:27:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BFAC433C8;
        Mon, 23 Oct 2023 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060467;
        bh=x3se2kq6xWS8YxuUwnpu7/eLDRtC29MT4FvGypsarPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Su/qpA/z9X7t/lRW5TykXbg+NKKt0UucPvE8O4imbP6VO5QDJmkhw6vrZd6aBx5Qt
         iZl5BNt6OlAJcH9abwRvfffNK/evGYsKP1gseqLA37nhhLPPxAKozRtRbVMx+o3NnT
         0wDGir7CM5aKXpHF8peN/KMPJ4vwSwJCEisBGSoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6.1 182/196] serial: 8250: omap: convert to modern PM ops
Date:   Mon, 23 Oct 2023 12:57:27 +0200
Message-ID: <20231023104833.537515280@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ae62c49c0ceff20dc7c1fad4a5b8f91d64b4f628 upstream.

The new uart_write() function is only called from suspend/resume code, causing
a build warning when those are left out:

drivers/tty/serial/8250/8250_omap.c:169:13: error: 'uart_write' defined but not used [-Werror=unused-function]

Remove the #ifdefs and use the modern pm_ops/pm_sleep_ops and their wrappers
to let the compiler see where it's used but still drop the dead code.

Fixes: 398cecc24846 ("serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20230517202012.634386-1-arnd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_omap.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1487,7 +1487,6 @@ static int omap8250_remove(struct platfo
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int omap8250_prepare(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
@@ -1547,12 +1546,7 @@ static int omap8250_resume(struct device
 
 	return 0;
 }
-#else
-#define omap8250_prepare NULL
-#define omap8250_complete NULL
-#endif
 
-#ifdef CONFIG_PM
 static int omap8250_lost_context(struct uart_8250_port *up)
 {
 	u32 val;
@@ -1664,7 +1658,6 @@ static int omap8250_runtime_resume(struc
 	schedule_work(&priv->qos_work);
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP
 static int __init omap8250_console_fixup(void)
@@ -1707,17 +1700,17 @@ console_initcall(omap8250_console_fixup)
 #endif
 
 static const struct dev_pm_ops omap8250_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(omap8250_suspend, omap8250_resume)
-	SET_RUNTIME_PM_OPS(omap8250_runtime_suspend,
+	SYSTEM_SLEEP_PM_OPS(omap8250_suspend, omap8250_resume)
+	RUNTIME_PM_OPS(omap8250_runtime_suspend,
 			   omap8250_runtime_resume, NULL)
-	.prepare        = omap8250_prepare,
-	.complete       = omap8250_complete,
+	.prepare        = pm_sleep_ptr(omap8250_prepare),
+	.complete       = pm_sleep_ptr(omap8250_complete),
 };
 
 static struct platform_driver omap8250_platform_driver = {
 	.driver = {
 		.name		= "omap8250",
-		.pm		= &omap8250_dev_pm_ops,
+		.pm		= pm_ptr(&omap8250_dev_pm_ops),
 		.of_match_table = omap8250_dt_ids,
 	},
 	.probe			= omap8250_probe,


