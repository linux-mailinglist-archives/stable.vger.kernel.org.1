Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C286FACBA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbjEHL1i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjEHL1Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681AF3C9B9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4837F62D14
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3C7C433D2;
        Mon,  8 May 2023 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545227;
        bh=kjsn8EC8znD3UmGWKTTvGFe8CixJgsskO6DqxniylZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mf8L1HKMrfOAf0pyyerkbbxvR5GKkqJO7VDPTRCTXYR247s8poRVgOAxWTbic35/+
         maCyY40ocypxp0kuycaY74jwt/mNTkqWz68NAM4lQwv0GChHtXpiGCjG+Ln9PCs5Eh
         BU5dA1otwn5XKjwzcC0MoOM7kSk78eaof3MRb3BU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?G=C3=A9=20Koerkamp?= <ge.koerkamp@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 666/694] ACPI: PM: Do not turn of unused power resources on the Toshiba Click Mini
Date:   Mon,  8 May 2023 11:48:21 +0200
Message-Id: <20230508094457.690318901@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 9b04d99788cf475cbd277f30ec66230ccb7e99f4 ]

The CPR3 power resource on the Toshiba Click Mini toggles a GPIO
which is called SISP (for SIS touchscreen power?) on/off.

This CPR3 power resource is not listed in any _PR? lists, let alone
in a _PR0 list for the SIS0817 touchscreen ACPI device which needs it.

Before commit a1224f34d72a ("ACPI: PM: Check states of power resources
during initialization") this was not an issue because since nothing
referenced the CPR3 power resource its state was always
ACPI_POWER_RESOURCE_STATE_UNKNOWN and power resources with this state
get ignored by acpi_turn_off_unused_power_resources().

This clearly is a bug in the DSDT of this device. Add a DMI quirk
to make acpi_turn_off_unused_power_resources() a no-op on this
model to fix the touchscreen no longer working since kernel 5.16 .

This quirk also causes 2 other power resources to not get turned
off, but the _OFF method on these already was a no-op, so this makes
no difference for the other 2 power resources.

Fixes: a1224f34d72a ("ACPI: PM: Check states of power resources during initialization")
Reported-by: Gé Koerkamp <ge.koerkamp@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216946
Link: https://lore.kernel.org/regressions/32a14a8a-9795-4c8c-7e00-da9012f548f8@leemhuis.info/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/power.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 23507d29f0006..c2c70139c4f1d 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -23,6 +23,7 @@
 
 #define pr_fmt(fmt) "ACPI: PM: " fmt
 
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -1022,6 +1023,21 @@ void acpi_resume_power_resources(void)
 }
 #endif
 
+static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
+	{
+		/*
+		 * The Toshiba Click Mini has a CPR3 power-resource which must
+		 * be on for the touchscreen to work, but which is not in any
+		 * _PR? lists. The other 2 affected power-resources are no-ops.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE Click Mini L9W-B"),
+		},
+	},
+	{}
+};
+
 /**
  * acpi_turn_off_unused_power_resources - Turn off power resources not in use.
  */
@@ -1029,6 +1045,9 @@ void acpi_turn_off_unused_power_resources(void)
 {
 	struct acpi_power_resource *resource;
 
+	if (dmi_check_system(dmi_leave_unused_power_resources_on))
+		return;
+
 	mutex_lock(&power_resource_list_lock);
 
 	list_for_each_entry_reverse(resource, &acpi_power_resource_list, list_node) {
-- 
2.39.2



