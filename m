Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8773EA63
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjFZSqp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbjFZSqo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C8B9
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99E1160F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A249FC433C8;
        Mon, 26 Jun 2023 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805203;
        bh=tJx8afwHV6Ld0IeRrbLffo1EPhLFV0Glp6NzQDUm3Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aigiFNxVtGyv2QkbeQ1DEqozY70vucgAuKKOom8D10g4VMRbpuDCeMkJwVogrpvo5
         e1UImI0xmSqyEBmvTKLMQDgEF+uZaVLHS+IT5cXlL2Zfk/GtJHVYCpQDDumfz2HF1G
         /GE8flhOeIrEgo/+ayrYMkPgJULVyrQs3K80esHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 66/81] Input: soc_button_array - add invalid acpi_index DMI quirk handling
Date:   Mon, 26 Jun 2023 20:12:48 +0200
Message-ID: <20230626180747.140506445@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
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

[ Upstream commit 20a99a291d564a559cc2fd013b4824a3bb3f1db7 ]

Some devices have a wrong entry in their button array which points to
a GPIO which is required in another driver, so soc_button_array must
not claim it.

A specific example of this is the Lenovo Yoga Book X90F / X90L,
where the PNP0C40 home button entry points to a GPIO which is not
a home button and which is required by the lenovo-yogabook driver.

Add a DMI quirk table which can specify an ACPI GPIO resource index which
should be skipped; and add an entry for the Lenovo Yoga Book X90F / X90L
to this new DMI quirk table.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230414072116.4497-1-hdegoede@redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/soc_button_array.c | 30 +++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 31c02c2019c1c..67a134c8448d2 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -108,6 +108,27 @@ static const struct dmi_system_id dmi_use_low_level_irq[] = {
 	{} /* Terminating entry */
 };
 
+/*
+ * Some devices have a wrong entry which points to a GPIO which is
+ * required in another driver, so this driver must not claim it.
+ */
+static const struct dmi_system_id dmi_invalid_acpi_index[] = {
+	{
+		/*
+		 * Lenovo Yoga Book X90F / X90L, the PNP0C40 home button entry
+		 * points to a GPIO which is not a home button and which is
+		 * required by the lenovo-yogabook driver.
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+		},
+		.driver_data = (void *)1l,
+	},
+	{} /* Terminating entry */
+};
+
 /*
  * Get the Nth GPIO number from the ACPI object.
  */
@@ -137,6 +158,8 @@ soc_button_device_create(struct platform_device *pdev,
 	struct platform_device *pd;
 	struct gpio_keys_button *gpio_keys;
 	struct gpio_keys_platform_data *gpio_keys_pdata;
+	const struct dmi_system_id *dmi_id;
+	int invalid_acpi_index = -1;
 	int error, gpio, irq;
 	int n_buttons = 0;
 
@@ -154,10 +177,17 @@ soc_button_device_create(struct platform_device *pdev,
 	gpio_keys = (void *)(gpio_keys_pdata + 1);
 	n_buttons = 0;
 
+	dmi_id = dmi_first_match(dmi_invalid_acpi_index);
+	if (dmi_id)
+		invalid_acpi_index = (long)dmi_id->driver_data;
+
 	for (info = button_info; info->name; info++) {
 		if (info->autorepeat != autorepeat)
 			continue;
 
+		if (info->acpi_index == invalid_acpi_index)
+			continue;
+
 		error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index, &gpio, &irq);
 		if (error || irq < 0) {
 			/*
-- 
2.39.2



