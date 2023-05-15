Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65143703BEB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbjEOSIb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245124AbjEOSH6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:07:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C4189BB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3AFD630A4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F55C433EF;
        Mon, 15 May 2023 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173900;
        bh=E2LngIcH5FPyqbbjVe7W+U69rqjM/pwlC9qSjWZBaE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSXxfEoOOyIry+LfuUTko2B+9/iB8s30/tPYJlssCTCzfGXErdZkLOOuvcSf16Xpy
         U082NN2SBcLJFm+jWfrDU+o8ES4Bv73BG684THxobyGpS/jLB+ZiOWjb11hqLs8nnY
         lJj5QSQOyOnwpfjcIX3pNb+5vV1ehv0wmm5ni3TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrey Avdeev <jamesstoun@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5.4 243/282] platform/x86: touchscreen_dmi: Add info for the Dexp Ursus KX210i
Date:   Mon, 15 May 2023 18:30:21 +0200
Message-Id: <20230515161729.541311641@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Andrey Avdeev <jamesstoun@gmail.com>

commit 4b65f95c87c35699bc6ad540d6b9dd7f950d0924 upstream.

Add touchscreen info for the Dexp Ursus KX210i

Signed-off-by: Andrey Avdeev <jamesstoun@gmail.com>
Link: https://lore.kernel.org/r/ZE4gRgzRQCjXFYD0@avdeevavpc
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/touchscreen_dmi.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -232,6 +232,22 @@ static const struct ts_dmi_data dexp_urs
 	.properties	= dexp_ursus_7w_props,
 };
 
+static const struct property_entry dexp_ursus_kx210i_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 5),
+	PROPERTY_ENTRY_U32("touchscreen-min-y",  2),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1137),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-dexp-ursus-kx210i.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data dexp_ursus_kx210i_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= dexp_ursus_kx210i_props,
+};
+
 static const struct property_entry digma_citi_e200_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
@@ -774,6 +790,14 @@ static const struct dmi_system_id touchs
 		},
 	},
 	{
+		/* DEXP Ursus KX210i */
+		.driver_data = (void *)&dexp_ursus_kx210i_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "INSYDE Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S107I"),
+		},
+	},
+	{
 		/* Digma Citi E200 */
 		.driver_data = (void *)&digma_citi_e200_data,
 		.matches = {


