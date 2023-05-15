Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399AC70366D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbjEORKL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243724AbjEORJW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:09:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9170AAD07
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D75C662AD1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB4AC433D2;
        Mon, 15 May 2023 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170416;
        bh=ZGQwDrblZujQZQODfbu5LD+tJ6qDeTPQhNlyaCkmguQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBQssClJC/0NcXRPjAualPgzI0VMSVNTx8M4aqN9HnOXxsjzZruSU3imprzHvp9K1
         CqwTZPfGT0TkG5WOyLu54lObx4E5lkYBLt5S22uQ3Qik3ylcoRNiVkJmxFNaYjSYPf
         igKf129yZGXUfYq+W9wP029b3w5YxX6/p3XDaQFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.1 124/239] platform/x86: touchscreen_dmi: Add upside-down quirk for GDIX1002 ts on the Juno Tablet
Date:   Mon, 15 May 2023 18:26:27 +0200
Message-Id: <20230515161725.422584438@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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
@@ -378,6 +378,11 @@ static const struct ts_dmi_data gdix1001
 	.properties	= gdix1001_upside_down_props,
 };
 
+static const struct ts_dmi_data gdix1002_00_upside_down_data = {
+	.acpi_name	= "GDIX1002:00",
+	.properties	= gdix1001_upside_down_props,
+};
+
 static const struct property_entry gp_electronic_t701_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 960),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 640),
@@ -1296,6 +1301,18 @@ const struct dmi_system_id touchscreen_d
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


