Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06F5791D24
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbjIDSff (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbjIDSff (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:35:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D31B2
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2FE9CE0F9A
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A486C433C7;
        Mon,  4 Sep 2023 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852528;
        bh=y3KRT12AGLpGQm5JEZ5Q6Z0H6Plb6e3GEnetyLDSsTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/b2bzEK7qxVhJFkRJmVWkOvg7eDD+KvtCcV2WxVgRxEjbOdnkPNiZ5SSydjAR5Jp
         67En2cMXQRkxKDXT8UW5ass+WVaFBX5393QyFq3vWuHAm80JwYEkpqY2xJGPX+I02V
         shGcopte1XlC18ohiANGQyqohTxylUAo/SrUbwMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.1 07/31] mmc: au1xmmc: force non-modular build and remove symbol_get usage
Date:   Mon,  4 Sep 2023 19:30:15 +0100
Message-ID: <20230904182947.350585097@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
References: <20230904182946.999390199@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit d4a5c59a955bba96b273ec1a5885bada24c56979 upstream.

au1xmmc is split somewhat awkwardly into the main mmc subsystem driver,
and callbacks in platform_data that sit under arch/mips/ and are
always built in.  The latter than call mmc_detect_change through
symbol_get.  Remove the use of symbol_get by requiring the driver
to be built in.  In the future the interrupt handlers for card
insert/eject detection should probably be moved into the main driver,
and which point it can be built modular again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
[mcgrof: squashed in depends on MMC=y suggested by Arnd]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/alchemy/devboards/db1000.c |    8 +-------
 arch/mips/alchemy/devboards/db1200.c |   19 ++-----------------
 arch/mips/alchemy/devboards/db1300.c |   10 +---------
 drivers/mmc/host/Kconfig             |    5 +++--
 4 files changed, 7 insertions(+), 35 deletions(-)

--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
@@ -167,12 +166,7 @@ static struct platform_device db1x00_aud
 
 static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	mmc_cd(ptr, msecs_to_jiffies(500));
-	symbol_put(mmc_detect_change);
-
+	mmc_detect_change(ptr, msecs_to_jiffies(500));
 	return IRQ_HANDLED;
 }
 
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -10,7 +10,6 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/leds.h>
@@ -340,14 +339,7 @@ static irqreturn_t db1200_mmc_cd(int irq
 
 static irqreturn_t db1200_mmc_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(200));
-		symbol_put(mmc_detect_change);
-	}
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == DB1200_SD0_INSERT_INT)
@@ -431,14 +423,7 @@ static irqreturn_t pb1200_mmc1_cd(int ir
 
 static irqreturn_t pb1200_mmc1_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(200));
-		symbol_put(mmc_detect_change);
-	}
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == PB1200_SD1_INSERT_INT)
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/ata_platform.h>
 #include <linux/mmc/host.h>
-#include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/platnand.h>
 #include <linux/platform_device.h>
@@ -459,14 +458,7 @@ static irqreturn_t db1300_mmc_cd(int irq
 
 static irqreturn_t db1300_mmc_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m.  We can only be called once MMC core has
-	 * initialized the controller, so symbol_get() should always succeed.
-	 */
-	mmc_cd = symbol_get(mmc_detect_change);
-	mmc_cd(ptr, msecs_to_jiffies(200));
-	symbol_put(mmc_detect_change);
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == DB1300_SD1_INSERT_INT)
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -528,11 +528,12 @@ config MMC_ALCOR
 	  of Alcor Micro PCI-E card reader
 
 config MMC_AU1X
-	tristate "Alchemy AU1XX0 MMC Card Interface support"
+	bool "Alchemy AU1XX0 MMC Card Interface support"
 	depends on MIPS_ALCHEMY
+	depends on MMC=y
 	help
 	  This selects the AMD Alchemy(R) Multimedia card interface.
-	  If you have a Alchemy platform with a MMC slot, say Y or M here.
+	  If you have a Alchemy platform with a MMC slot, say Y here.
 
 	  If unsure, say N.
 


