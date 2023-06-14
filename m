Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF3B719DD7
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjFAN0w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjFAN0p (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6401A8
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE957644AF
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66B8C433EF;
        Thu,  1 Jun 2023 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625980;
        bh=ButedDyARNPCEM+8Bd7CjZ17mo9aFfQE4Rrb9oHZ3cA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkmIxTXLd372WYd9ms0CEN5Qv2HuE65y+HDxGNMiey8TQr40w41cMBRvxowckmK96
         spF7j6e3evrY1rxMlqXoAchS80ZNGWA1sUakSqGQhTQD8DZu2jKdZ9qdb0E+WH+Ss0
         Mcfj3ZR8Cre5q4UT8T3rz178FbwPRqTIWj6w6MUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xing Tong Wu <xingtong.wu@siemens.com>,
        Henning Schild <henning.schild@siemens.com>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 28/45] gpio-f7188x: fix chip name and pin count on Nuvoton chip
Date:   Thu,  1 Jun 2023 14:21:24 +0100
Message-Id: <20230601131939.966217322@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Henning Schild <henning.schild@siemens.com>

[ Upstream commit 3002b8642f016d7fe3ff56240dacea1075f6b877 ]

In fact the device with chip id 0xD283 is called NCT6126D, and that is
the chip id the Nuvoton code was written for. Correct that name to avoid
confusion, because a NCT6116D in fact exists as well but has another
chip id, and is currently not supported.

The look at the spec also revealed that GPIO group7 in fact has 8 pins,
so correct the pin count in that group as well.

Fixes: d0918a84aff0 ("gpio-f7188x: Add GPIO support for Nuvoton NCT6116")
Reported-by: Xing Tong Wu <xingtong.wu@siemens.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
Acked-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/Kconfig       |  2 +-
 drivers/gpio/gpio-f7188x.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index badbe05823180..14b655411aa0a 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -879,7 +879,7 @@ config GPIO_F7188X
 	help
 	  This option enables support for GPIOs found on Fintek Super-I/O
 	  chips F71869, F71869A, F71882FG, F71889F and F81866.
-	  As well as Nuvoton Super-I/O chip NCT6116D.
+	  As well as Nuvoton Super-I/O chip NCT6126D.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called f7188x-gpio.
diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 9effa7769bef5..f54ca5a1775ea 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -48,7 +48,7 @@
 /*
  * Nuvoton devices.
  */
-#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
+#define SIO_NCT6126D_ID		0xD283  /* NCT6126D chipset ID */
 
 #define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
 
@@ -62,7 +62,7 @@ enum chips {
 	f81866,
 	f81804,
 	f81865,
-	nct6116d,
+	nct6126d,
 };
 
 static const char * const f7188x_names[] = {
@@ -74,7 +74,7 @@ static const char * const f7188x_names[] = {
 	"f81866",
 	"f81804",
 	"f81865",
-	"nct6116d",
+	"nct6126d",
 };
 
 struct f7188x_sio {
@@ -187,8 +187,8 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 /* Output mode register (0:open drain 1:push-pull). */
 #define f7188x_gpio_out_mode(base) ((base) + 3)
 
-#define f7188x_gpio_dir_invert(type)	((type) == nct6116d)
-#define f7188x_gpio_data_single(type)	((type) == nct6116d)
+#define f7188x_gpio_dir_invert(type)	((type) == nct6126d)
+#define f7188x_gpio_data_single(type)	((type) == nct6126d)
 
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
@@ -274,7 +274,7 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] = {
 	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
 };
 
-static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
+static struct f7188x_gpio_bank nct6126d_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
 	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
 	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
@@ -282,7 +282,7 @@ static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
 	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
 	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
 	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
-	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
+	F7188X_GPIO_BANK(70, 8, 0xFC, DRVNAME "-7"),
 };
 
 static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
@@ -490,9 +490,9 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
 		data->nr_bank = ARRAY_SIZE(f81865_gpio_bank);
 		data->bank = f81865_gpio_bank;
 		break;
-	case nct6116d:
-		data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
-		data->bank = nct6116d_gpio_bank;
+	case nct6126d:
+		data->nr_bank = ARRAY_SIZE(nct6126d_gpio_bank);
+		data->bank = nct6126d_gpio_bank;
 		break;
 	default:
 		return -ENODEV;
@@ -559,9 +559,9 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	case SIO_F81865_ID:
 		sio->type = f81865;
 		break;
-	case SIO_NCT6116D_ID:
+	case SIO_NCT6126D_ID:
 		sio->device = SIO_LD_GPIO_NUVOTON;
-		sio->type = nct6116d;
+		sio->type = nct6126d;
 		break;
 	default:
 		pr_info("Unsupported Fintek device 0x%04x\n", devid);
@@ -569,7 +569,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	}
 
 	/* double check manufacturer where possible */
-	if (sio->type != nct6116d) {
+	if (sio->type != nct6126d) {
 		manid = superio_inw(addr, SIO_FINTEK_MANID);
 		if (manid != SIO_FINTEK_ID) {
 			pr_debug("Not a Fintek device at 0x%08x\n", addr);
@@ -581,7 +581,7 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	err = 0;
 
 	pr_info("Found %s at %#x\n", f7188x_names[sio->type], (unsigned int)addr);
-	if (sio->type != nct6116d)
+	if (sio->type != nct6126d)
 		pr_info("   revision %d\n", superio_inb(addr, SIO_FINTEK_DEVREV));
 
 err:
-- 
2.39.2



