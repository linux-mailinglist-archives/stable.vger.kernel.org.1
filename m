Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3B7ECE4D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjKOTmO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjKOTmN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A87EAB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133CBC433CB;
        Wed, 15 Nov 2023 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077329;
        bh=9zfeSWl/G9okiOKllTgz+g8SXVk7mJigBxjJYh8rzlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoOQfjxM14ZZnLDkll+3fgCoufn7gc3lQJ6supbtNinLnH5V3sdvaRvnWejO7whb1
         LSdjzffPmADQ6Mm8eX3iTVkqEvJrIWyDXxYHXruaZRXzTfJHYSjgmTrFkkcPr5OIMq
         fs5ijD6JdXtaIlZULSKpgtD2XVqjv2+x/P06gARg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 208/603] hwmon: (sch5627) Use bit macros when accessing the control register
Date:   Wed, 15 Nov 2023 14:12:33 -0500
Message-ID: <20231115191627.663129375@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 7f0b28e0653f36b51542d25dd54ed312c397ecfc ]

Use bit macros then accessing SCH5627_REG_CTRL, so that people
do not need to look at the datasheet to find out what each bit
does.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20230907052639.16491-2-W_Armin@gmx.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 7da8a6354360 ("hwmon: (sch5627) Disallow write access if virtual registers are locked")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sch5627.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 1bbda3b05532e..0eefb8c0aef25 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/init.h>
@@ -32,6 +33,9 @@
 #define SCH5627_REG_PRIMARY_ID		0x3f
 #define SCH5627_REG_CTRL		0x40
 
+#define SCH5627_CTRL_START		BIT(0)
+#define SCH5627_CTRL_VBAT		BIT(4)
+
 #define SCH5627_NO_TEMPS		8
 #define SCH5627_NO_FANS			4
 #define SCH5627_NO_IN			5
@@ -147,7 +151,8 @@ static int sch5627_update_in(struct sch5627_data *data)
 
 	/* Trigger a Vbat voltage measurement every 5 minutes */
 	if (time_after(jiffies, data->last_battery + 300 * HZ)) {
-		sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL, data->control | 0x10);
+		sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL,
+					  data->control | SCH5627_CTRL_VBAT);
 		data->last_battery = jiffies;
 	}
 
@@ -483,14 +488,13 @@ static int sch5627_probe(struct platform_device *pdev)
 		return val;
 
 	data->control = val;
-	if (!(data->control & 0x01)) {
+	if (!(data->control & SCH5627_CTRL_START)) {
 		pr_err("hardware monitoring not enabled\n");
 		return -ENODEV;
 	}
 	/* Trigger a Vbat voltage measurement, so that we get a valid reading
 	   the first time we read Vbat */
-	sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL,
-				  data->control | 0x10);
+	sch56xx_write_virtual_reg(data->addr, SCH5627_REG_CTRL, data->control | SCH5627_CTRL_VBAT);
 	data->last_battery = jiffies;
 
 	/*
-- 
2.42.0



