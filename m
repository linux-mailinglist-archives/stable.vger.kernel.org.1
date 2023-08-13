Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2397877ABA7
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjHMVYP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjHMVYP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616D310DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:24:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F289E628C3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:24:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BFFC433C7;
        Sun, 13 Aug 2023 21:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961856;
        bh=19GWCA3D//vHDkY3LGiI/VAccSA6a9Z7Gdbm0a0Qe1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=skmiItH/DyK1n0EDqYjRndCmCU34jEjGqd2JDaCV0DTfixNJA9UURyz4831CnrDFQ
         SvbR+df5tp3CPrS8u9Av0gUDMwFJ+QoGyuLu9CDW6ukWJryWvJBYn8dqcM2GjocppS
         dDA3+ke4LLrwcLw8XZBL+R2sjoZx0X9NOLaZpKS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.4 023/206] ACPI: resource: revert "Remove "Zen" specific match and quirks"
Date:   Sun, 13 Aug 2023 23:16:33 +0200
Message-ID: <20230813211725.649477976@linuxfoundation.org>
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

commit 2d331a6ac4815e2e2fe5f2d80d908566e57797cc upstream.

Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
quirks") is causing keyboard problems for quite a log of AMD based
laptop users, leading to many bug reports.

Revert this change for now, until we can come up with
a better fix for the PS/2 IRQ trigger-type/polarity problems
on some x86 laptops.

Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2228891
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229165
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229317
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217718
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217726
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217731
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/resource.c | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 1dd8d5aebf67..0800a9d77558 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -470,6 +470,52 @@ static const struct dmi_system_id asus_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id lenovo_laptop[] = {
+	{
+		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
+		},
+	},
+	{
+		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
+		},
+	},
+	{ }
+};
+
+static const struct dmi_system_id tongfang_gm_rg[] = {
+	{
+		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
+		},
+	},
+	{ }
+};
+
+static const struct dmi_system_id maingear_laptop[] = {
+	{
+		.ident = "MAINGEAR Vector Pro 2 15",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
+		}
+	},
+	{
+		.ident = "MAINGEAR Vector Pro 2 17",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
+		},
+	},
+	{ }
+};
+
 static const struct dmi_system_id lg_laptop[] = {
 	{
 		.ident = "LG Electronics 17U70P",
@@ -493,6 +539,10 @@ struct irq_override_cmp {
 static const struct irq_override_cmp override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
+	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
+	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
+	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };
 
@@ -512,6 +562,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 			return entry->override;
 	}
 
+#ifdef CONFIG_X86
+	/*
+	 * IRQ override isn't needed on modern AMD Zen systems and
+	 * this override breaks active low IRQs on AMD Ryzen 6000 and
+	 * newer systems. Skip it.
+	 */
+	if (boot_cpu_has(X86_FEATURE_ZEN))
+		return false;
+#endif
+
 	return true;
 }
 
-- 
2.41.0



