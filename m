Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D8B7ED2B5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjKOUnD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbjKOTzh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:55:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B18171F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:55:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5242BC433B6;
        Wed, 15 Nov 2023 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078129;
        bh=FNcsL9SVaq6kUIBHzkOA9bohHoQvfMggUM8RIBoDPt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRQgWFVKYuLuDZwCXY1oyFV/d1QQwvxzV1psIWBcmGKFlPaw0+e1bqhpxIm1UsuU8
         B6SavwG/XBfgqi1eP8krWHTQCygp5nl3X5F5FMKOmhl8bTcHnx9mEKK9EI16oJiaOv
         tsZjKZe3jYeyI5NGGnvdHvdhHCiWinclkedKRFIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Nartowicz <deadbeef@nartowicz.co.uk>,
        Armin Wolf <W_Armin@gmx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 110/379] Revert "hwmon: (sch56xx-common) Add DMI override table"
Date:   Wed, 15 Nov 2023 14:23:05 -0500
Message-ID: <20231115192651.635885021@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 28da9dee3594423534f3ea1e1f61e6bb2d2fa651 ]

This reverts commit fd2d53c367ae9983c2100ac733a834e0c79d7537.

As reported by Ian Nartowicz, this and the preceding patch
result in a failure to load the driver on Celsius W280.
While the alternative would be to add the board to the DMI
override table, it is quite likely that other systems are
also affected. Revert the offending patches to avoid future
problems.

Fixes: fd2d53c367ae ("hwmon: (sch56xx-common) Add DMI override table")
Reported-by: Ian Nartowicz <deadbeef@nartowicz.co.uk>
Closes: https://lore.kernel.org/linux-hwmon/20231025192239.3c5389ae@debian.org/T/#t
Cc: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/sch56xx-common.c | 44 ++++++++--------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index de3a0886c2f72..3ece53adabd62 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -523,28 +523,6 @@ static int __init sch56xx_device_add(int address, const char *name)
 	return PTR_ERR_OR_ZERO(sch56xx_pdev);
 }
 
-static const struct dmi_system_id sch56xx_dmi_override_table[] __initconst = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS W380"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO P710"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO E9900"),
-		},
-	},
-	{ }
-};
-
 /* For autoloading only */
 static const struct dmi_system_id sch56xx_dmi_table[] __initconst = {
 	{
@@ -565,18 +543,16 @@ static int __init sch56xx_init(void)
 		if (!dmi_check_system(sch56xx_dmi_table))
 			return -ENODEV;
 
-		if (!dmi_check_system(sch56xx_dmi_override_table)) {
-			/*
-			 * Some machines like the Esprimo P720 and Esprimo C700 have
-			 * onboard devices named " Antiope"/" Theseus" instead of
-			 * "Antiope"/"Theseus", so we need to check for both.
-			 */
-			if (!dmi_find_device(DMI_DEV_TYPE_OTHER, "Antiope", NULL) &&
-			    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Antiope", NULL) &&
-			    !dmi_find_device(DMI_DEV_TYPE_OTHER, "Theseus", NULL) &&
-			    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Theseus", NULL))
-				return -ENODEV;
-		}
+		/*
+		 * Some machines like the Esprimo P720 and Esprimo C700 have
+		 * onboard devices named " Antiope"/" Theseus" instead of
+		 * "Antiope"/"Theseus", so we need to check for both.
+		 */
+		if (!dmi_find_device(DMI_DEV_TYPE_OTHER, "Antiope", NULL) &&
+		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Antiope", NULL) &&
+		    !dmi_find_device(DMI_DEV_TYPE_OTHER, "Theseus", NULL) &&
+		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Theseus", NULL))
+			return -ENODEV;
 	}
 
 	/*
-- 
2.42.0



