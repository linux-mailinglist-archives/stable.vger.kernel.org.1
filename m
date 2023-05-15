Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23911703AAB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244128AbjEORx4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244688AbjEORxe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937AC1CA71
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8989462F4F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82676C433EF;
        Mon, 15 May 2023 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173009;
        bh=eIYs8AfAg/HsEMcGbPVAm9N5AKO8kVoOWq1wa+zfFM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlUHq+JzzDwZkxGbG0O8U+yab1yp2RXySC/wOLU+jWity22az9gkPmP6uDpHc07lg
         Bjr+lzslibQrBf2mjnn8ghyiz3ArUR4inX8MOxGS1sZN6psg2bK1zf7KqUPhB5SPAG
         BohnjijccheKSKrryGJp0kbVXxGJs2n5mX+xUL8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5.10 338/381] platform/x86: touchscreen_dmi: Add upside-down quirk for GDIX1002 ts on the Juno Tablet
Date:   Mon, 15 May 2023 18:29:49 +0200
Message-Id: <20230515161752.113540346@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 6abfa99ce52f61a31bcfc2aaaae09006f5665495 upstream.

The Juno Computers Juno Tablet has an upside-down mounted Goodix
touchscreen. Add a quirk to invert both axis to correct for this.

Link: https://junocomputers.com/us/product/juno-tablet/
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230505210323.43177-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/touchscreen_dmi.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -381,6 +381,11 @@ static const struct ts_dmi_data glavey_t
 	.properties	= glavey_tm800a550l_props,
 };
 
+static const struct ts_dmi_data gdix1002_00_upside_down_data = {
+	.acpi_name	= "GDIX1002:00",
+	.properties	= gdix1001_upside_down_props,
+};
+
 static const struct property_entry gp_electronic_t701_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 960),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 640),
@@ -1228,6 +1233,18 @@ const struct dmi_system_id touchscreen_d
 		},
 	},
 	{
+		/* Juno Tablet */
+		.driver_data = (void *)&gdix1002_00_upside_down_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
+			/* Both product- and board-name being "Default string" is somewhat rare */
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			/* Above matches are too generic, add partial bios-version match */
+			DMI_MATCH(DMI_BIOS_VERSION, "JP2V1."),
+		},
+	},
+	{
 		/* Mediacom WinPad 7.0 W700 (same hw as Wintron surftab 7") */
 		.driver_data = (void *)&trekstor_surftab_wintron70_data,
 		.matches = {


