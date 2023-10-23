Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1CC7D32EC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjJWLZF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjJWLZD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:25:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBFD7E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:24:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91715C433BA;
        Mon, 23 Oct 2023 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060297;
        bh=MPTOG4HFYO9WrlG/S2+S8rsgUqrC609AfJ87cOSZAcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGnCGYObU+qNAgnhTojw7cvt9F2vlw8azZp7gp4YrUPqLDucvTDz1lYhb4vOV2+JU
         rG7q8QfsEBs+HNFS91JWTQWv6Q0B9xhT7l/zrwW5wvLSN4CXvHNirHHmsgArJihC1U
         95PrEyF7m3oTu/014o+TYxF6tQlQGxSBviCu6cBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Renan Guilherme Lebre Ramos <japareaggae@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 125/196] platform/x86: touchscreen_dmi: Add info for the Positivo C4128B
Date:   Mon, 23 Oct 2023 12:56:30 +0200
Message-ID: <20231023104832.038882835@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Renan Guilherme Lebre Ramos <japareaggae@gmail.com>

[ Upstream commit aa7dcba3bae6869122828b144a3cfd231718089d ]

Add information for the Positivo C4128B, a notebook/tablet convertible.

Link: https://github.com/onitake/gsl-firmware/pull/217
Signed-off-by: Renan Guilherme Lebre Ramos <japareaggae@gmail.com>
Link: https://lore.kernel.org/r/20231004235900.426240-1-japareaggae@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/touchscreen_dmi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 68e66b60445c3..9a92d515abb9b 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -740,6 +740,21 @@ static const struct ts_dmi_data pipo_w11_data = {
 	.properties	= pipo_w11_props,
 };
 
+static const struct property_entry positivo_c4128b_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 13),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1915),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1269),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-positivo-c4128b.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct ts_dmi_data positivo_c4128b_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= positivo_c4128b_props,
+};
+
 static const struct property_entry pov_mobii_wintab_p800w_v20_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 32),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
@@ -1457,6 +1472,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "MOMO.G.WI71C.MABMRBA02"),
 		},
 	},
+	{
+		/* Positivo C4128B */
+		.driver_data = (void *)&positivo_c4128b_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C4128B-1"),
+		},
+	},
 	{
 		/* Point of View mobii wintab p800w (v2.0) */
 		.driver_data = (void *)&pov_mobii_wintab_p800w_v20_data,
-- 
2.40.1



