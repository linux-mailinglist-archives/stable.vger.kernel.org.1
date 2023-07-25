Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D3C7611CC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjGYK40 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjGYK4F (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A791F3585
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7191F61693
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A35C433C7;
        Tue, 25 Jul 2023 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282423;
        bh=RPVf79G9Z6bC8QuV2X6vCZINAtB/lji81jjylWCwAWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnI8RCXOmooRpiRPXgbVvnLcyX3YWBN1uU9Olsm6rDq52Qg5j5NNS8BYQ3TlrKYfi
         bTS7ZmEHnCbCK8x6cCARTEd3xADqIIMWYJ6G3NW7M9jkXlLdrMNJ0FdwkDG7SZeTDn
         zj6TQiwpW5FRfS55KTLmrKs/l1EDviefj31UqB60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 097/227] ACPI: x86: Add skip i2c clients quirk for Nextbook Ares 8A
Date:   Tue, 25 Jul 2023 12:44:24 +0200
Message-ID: <20230725104518.755096661@linuxfoundation.org>
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

[ Upstream commit 69d6b37695c1f2320cfa330e1e1636d50dd5040a ]

The Nextbook Ares 8A is a x86 ACPI tablet which ships with Android x86
as factory OS. Its DSDT contains a bunch of I2C devices which are not
actually there (the Android x86 kernel fork ignores I2C devices described
in the DSDT).

On this specific model this just not cause resource conflicts, one of
the probe() calls for the non existing i2c_clients actually ends up
toggling a GPIO or executing a _PS3 after a failed probe which turns
the tablet off.

Add a ACPI_QUIRK_SKIP_I2C_CLIENTS for the Nextbook Ares 8 to the
acpi_quirk_skip_dmi_ids table to avoid the bogus i2c_clients and
to fix the tablet turning off during boot because of this.

Also add the "10EC5651" HID for the RealTek ALC5651 codec used
in this tablet to the list of HIDs for which not to skipi2c_client
instantiation, since the Intel SST sound driver relies on
the codec being instantiated through ACPI.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/x86/utils.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 9c2d6f35f88a0..4cfee2da06756 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -365,7 +365,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
 	},
 	{
-		/* Nextbook Ares 8 */
+		/* Nextbook Ares 8 (BYT version)*/
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "M890BAP"),
@@ -374,6 +374,16 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY |
 					ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS),
 	},
+	{
+		/* Nextbook Ares 8A (CHT version)*/
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
+			DMI_MATCH(DMI_BIOS_VERSION, "M882"),
+		},
+		.driver_data = (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
+					ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY),
+	},
 	{
 		/* Whitelabel (sold as various brands) TM800A550L */
 		.matches = {
@@ -392,6 +402,7 @@ static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] = {
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
 static const struct acpi_device_id i2c_acpi_known_good_ids[] = {
 	{ "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
+	{ "10EC5651", 0 }, /* RealTek ALC5651 audio codec */
 	{ "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
 	{ "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
 	{ "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
-- 
2.39.2



