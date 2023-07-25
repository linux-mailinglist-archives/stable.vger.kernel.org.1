Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B507611D2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjGYK4j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjGYK4P (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:56:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9724C03
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:53:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E0A461682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98166C433C7;
        Tue, 25 Jul 2023 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282435;
        bh=0xWRiWQWQT9nCTgwrrHRG9BM6tm1Sh5W6GmoVHq5964=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gD3hhqG0GFMDYmsEPaloBfMk/nY008QKM5GxZFVVbitbzHXrFP3Fo919obtERII7Y
         20mSDoSd39uAa8Q1ncrTp74esN89hmqcEqiZOsfgKOMpzUqrgag2Q2SfBSkrAqnMZU
         34k18UMqyfw5HTkFHOj+sx9hbTM0uRqjCs4uNu3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 099/227] ACPI: x86: Add ACPI_QUIRK_UART1_SKIP for Lenovo Yoga Book yb1-x90f/l
Date:   Tue, 25 Jul 2023 12:44:26 +0200
Message-ID: <20230725104518.835213115@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f91280f35895d6dcb53f504968fafd1da0b00397 ]

The Lenovo Yoga Book yb1-x90f/l 2-in-1 which ships with Android as
Factory OS has (another) bug in its DSDT where the UART resource for
the BTH0 ACPI device contains "\\_SB.PCIO.URT1" as path to the UART.

Note that is with a letter 'O' instead of the number '0' which is wrong.

This causes Linux to instantiate a standard /dev/ttyS? device for
the UART instead of a /sys/bus/serial device, which in turn causes
bluetooth to not work.

Similar DSDT bugs have been encountered before and to work around those
the acpi_quirk_skip_serdev_enumeration() helper exists.

Previous devices had the broken resource pointing to the first UART, while
the BT HCI was on the second UART, which ACPI_QUIRK_UART1_TTY_UART2_SKIP
deals with. Add a new ACPI_QUIRK_UART1_SKIP quirk for skipping enumeration
of UART1 instead for the Yoga Book case and add this quirk to the
existing DMI quirk table entry for the yb1-x90f/l .

This leaves the UART1 controller unbound allowing the x86-android-tablets
module to manually instantiate a serdev for it fixing bluetooth.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4cfee2da06756..c2b925f8cd4e4 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -259,10 +259,11 @@ bool force_storage_d3(void)
  * drivers/platform/x86/x86-android-tablets.c kernel module.
  */
 #define ACPI_QUIRK_SKIP_I2C_CLIENTS				BIT(0)
-#define ACPI_QUIRK_UART1_TTY_UART2_SKIP				BIT(1)
-#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(2)
-#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(3)
-#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS			BIT(4)
+#define ACPI_QUIRK_UART1_SKIP					BIT(1)
+#define ACPI_QUIRK_UART1_TTY_UART2_SKIP				BIT(2)
+#define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY			BIT(3)
+#define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY			BIT(4)
+#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS			BIT(5)
 
 static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 	/*
@@ -319,6 +320,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
 		},
 		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_UART1_SKIP |
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
@@ -449,6 +451,9 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	if (dmi_id)
 		quirks = (unsigned long)dmi_id->driver_data;
 
+	if ((quirks & ACPI_QUIRK_UART1_SKIP) && uid == 1)
+		*skip = true;
+
 	if (quirks & ACPI_QUIRK_UART1_TTY_UART2_SKIP) {
 		if (uid == 1)
 			return -ENODEV; /* Create tty cdev instead of serdev */
-- 
2.39.2



