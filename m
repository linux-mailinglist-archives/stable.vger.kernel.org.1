Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2877ABA8
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjHMVYS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjHMVYS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:24:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E33310EA
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1812628E0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4597C433C8;
        Sun, 13 Aug 2023 21:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961859;
        bh=rU//zqm5J3jQA9CL9pRtmwo1UCacZdAvbgb9r4aTKZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z6LHz2QD1KID/zD0m2kT+G6S5iVx6zgOfuEUFVPn5BeslgCjLoUXRJ0NjORqQp/3Z
         +90ciU/8Zzn58oIBA8hBU35fbr01N7I2WE+AUSHyABiMUr6/OVl4vvjgD7CIe7rgxI
         y/Pbhii5+pRj8vPSCc7SgRlQnr+3XcGmdu9Ww9E8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.4 024/206] ACPI: resource: Always use MADT override IRQ settings for all legacy non i8042 IRQs
Date:   Sun, 13 Aug 2023 23:16:34 +0200
Message-ID: <20230813211725.681244266@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 9728ac221160c5ea111879125a7694bb81364720 upstream.

All the cases, were the DSDT IRQ settings should be used instead of
the MADT override, are for IRQ 1 or 12, the PS/2 kbd resp. mouse IRQs.

Simplify things by always honering the override for other legacy IRQs
(for non DMI quirked cases).

This allows removing the DMI quirks to honor the override for
some non i8042 IRQs on some AMD ZEN based Lenovo models.

Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c |   28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -470,24 +470,6 @@ static const struct dmi_system_id asus_l
 	{ }
 };
 
-static const struct dmi_system_id lenovo_laptop[] = {
-	{
-		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
-		},
-	},
-	{
-		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
-		},
-	},
-	{ }
-};
-
 static const struct dmi_system_id tongfang_gm_rg[] = {
 	{
 		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
@@ -539,8 +521,6 @@ struct irq_override_cmp {
 static const struct irq_override_cmp override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
-	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
-	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
@@ -564,6 +544,14 @@ static bool acpi_dev_irq_override(u32 gs
 
 #ifdef CONFIG_X86
 	/*
+	 * Always use the MADT override info, except for the i8042 PS/2 ctrl
+	 * IRQs (1 and 12). For these the DSDT IRQ settings should sometimes
+	 * be used otherwise PS/2 keyboards / mice will not work.
+	 */
+	if (gsi != 1 && gsi != 12)
+		return true;
+
+	/*
 	 * IRQ override isn't needed on modern AMD Zen systems and
 	 * this override breaks active low IRQs on AMD Ryzen 6000 and
 	 * newer systems. Skip it.


