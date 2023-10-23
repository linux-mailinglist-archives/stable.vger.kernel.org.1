Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6A7D33BE
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjJWLdk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjJWLdj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:33:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A85E4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:33:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EAFC433C7;
        Mon, 23 Oct 2023 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060816;
        bh=RbPpLYoUWj0rW3rNPPSBAFnicPdwVjin6obKEJoZWgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=siq+wQ7xFleAvmQdRUUjA3GKwhyMJ7j/ue+fN2xoS3A1fIaxFVWw3k1bmEjUduuEn
         s4k/VHe8a3NYzsVxqKxYycvD4W0fd+Ggb96gKzDCaucowom4HOdTAJuN7PTmJWu5ZI
         UmWOJP98I+d9cMaf/FobuFK2YBwgqdUV1f0OqiZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Manuel Krause <manuelkrause@netscape.net>,
        Hui Wang <hui.wang@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 075/123] ACPI: resources: Add DMI-based legacy IRQ override quirk
Date:   Mon, 23 Oct 2023 12:57:13 +0200
Message-ID: <20231023104820.199719608@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit 892a012699fc0b91a2ed6309078936191447f480 ]

After the commit 0ec4e55e9f57 ("ACPI: resources: Add checks for ACPI
IRQ override") is reverted, the keyboard on Medion laptops can't
work again.

To fix the keyboard issue, add a DMI-based override check that will
not affect other machines along the lines of prt_quirks[] in
drivers/acpi/pci_irq.c.

If similar issues are seen on other platforms, the quirk table could
be expanded in the future.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
BugLink: http://bugs.launchpad.net/bugs/1909814
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reported-by: Manuel Krause <manuelkrause@netscape.net>
Tested-by: Manuel Krause <manuelkrause@netscape.net>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: c1ed72171ed5 ("ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/resource.c | 49 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 0ce3656e4633b..6489dd3ff0741 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -16,6 +16,7 @@
 #include <linux/ioport.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86
 #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
@@ -380,9 +381,51 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
+static const struct dmi_system_id medion_laptop[] = {
+	{
+		.ident = "MEDION P15651",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_BOARD_NAME, "M15T"),
+		},
+	},
+	{ }
+};
+
+struct irq_override_cmp {
+	const struct dmi_system_id *system;
+	unsigned char irq;
+	unsigned char triggering;
+	unsigned char polarity;
+	unsigned char shareable;
+};
+
+static const struct irq_override_cmp skip_override_table[] = {
+	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
+};
+
+static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
+				  u8 shareable)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
+		const struct irq_override_cmp *entry = &skip_override_table[i];
+
+		if (dmi_check_system(entry->system) &&
+		    entry->irq == gsi &&
+		    entry->triggering == triggering &&
+		    entry->polarity == polarity &&
+		    entry->shareable == shareable)
+			return false;
+	}
+
+	return true;
+}
+
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
-				     bool legacy)
+				     bool check_override)
 {
 	int irq, p, t;
 
@@ -401,7 +444,9 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	 * using extended IRQ descriptors we take the IRQ configuration
 	 * from _CRS directly.
 	 */
-	if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
+	if (check_override &&
+	    acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
+	    !acpi_get_override_irq(gsi, &t, &p)) {
 		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
 		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
 
-- 
2.40.1



