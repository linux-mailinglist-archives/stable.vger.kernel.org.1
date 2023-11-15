Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFC77ECBDF
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjKOTZD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjKOTZB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041CE1A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:24:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E089C433C7;
        Wed, 15 Nov 2023 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076297;
        bh=Ou0GOJmrkwCty6z8gov9b75RgywQd+84u8xXv74Df6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwSpRzTeykM4bJZxEFh2RWM2gPUXOWRVOuTfiAhk8tSKP+WmIkZVzXT3owo9fpR9h
         3BbFdWfVFg7sR7jA4802E9atZD0xkROk/jWKw2ELjWnapVYrW4+IgR1g8ENjTvN4G9
         fhDUi5qaqSuOt0icPnyp2dzDH5j3PgIKkImGZkEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Nartowicz <deadbeef@nartowicz.co.uk>,
        Armin Wolf <W_Armin@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 194/550] Revert "hwmon: (sch56xx-common) Add automatic module loading on supported devices"
Date:   Wed, 15 Nov 2023 14:12:58 -0500
Message-ID: <20231115191614.218089092@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit d621a46d05107f4e510383d6a38f2160c62d28f7 ]

This reverts commit 393935baa45e5ccb9603cf7f9f020ed1bc0915f7.

As reported by Ian Nartowicz, this and the next patch
result in a failure to load the driver on Celsius W280.
While the alternative would be to add the board to the DMI
override table, it is quite likely that other systems are
also affected. Revert the offending patches to avoid future
problems.

Fixes: 393935baa45e ("hwmon: (sch56xx-common) Add automatic module loading on supported devices")
Reported-by: Ian Nartowicz <deadbeef@nartowicz.co.uk>
Closes: https://lore.kernel.org/linux-hwmon/20231025192239.3c5389ae@debian.org/T/#t
Cc: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sch56xx-common.c | 40 ++--------------------------------
 1 file changed, 2 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index 3ece53adabd62..ac1f725807155 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -7,10 +7,8 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
@@ -21,10 +19,7 @@
 #include <linux/slab.h>
 #include "sch56xx-common.h"
 
-static bool ignore_dmi;
-module_param(ignore_dmi, bool, 0);
-MODULE_PARM_DESC(ignore_dmi, "Omit DMI check for supported devices (default=0)");
-
+/* Insmod parameters */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
@@ -523,42 +518,11 @@ static int __init sch56xx_device_add(int address, const char *name)
 	return PTR_ERR_OR_ZERO(sch56xx_pdev);
 }
 
-/* For autoloading only */
-static const struct dmi_system_id sch56xx_dmi_table[] __initconst = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-		},
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(dmi, sch56xx_dmi_table);
-
 static int __init sch56xx_init(void)
 {
-	const char *name = NULL;
 	int address;
+	const char *name = NULL;
 
-	if (!ignore_dmi) {
-		if (!dmi_check_system(sch56xx_dmi_table))
-			return -ENODEV;
-
-		/*
-		 * Some machines like the Esprimo P720 and Esprimo C700 have
-		 * onboard devices named " Antiope"/" Theseus" instead of
-		 * "Antiope"/"Theseus", so we need to check for both.
-		 */
-		if (!dmi_find_device(DMI_DEV_TYPE_OTHER, "Antiope", NULL) &&
-		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Antiope", NULL) &&
-		    !dmi_find_device(DMI_DEV_TYPE_OTHER, "Theseus", NULL) &&
-		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Theseus", NULL))
-			return -ENODEV;
-	}
-
-	/*
-	 * Some devices like the Esprimo C700 have both onboard devices,
-	 * so we still have to check manually
-	 */
 	address = sch56xx_find(0x4e, &name);
 	if (address < 0)
 		address = sch56xx_find(0x2e, &name);
-- 
2.42.0



