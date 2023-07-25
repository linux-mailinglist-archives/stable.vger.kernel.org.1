Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D477611DA
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjGYK4z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGYK42 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED64C15
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDE076165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC75C433C8;
        Tue, 25 Jul 2023 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282432;
        bh=MY2QVCepyYKb6djDRwYxhF8cokHoC5u9Fkge0FG6BME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=affYCILQpDC3zSX88d/XeAKcji6/cDmdg8+Ko4AeIbmAAcJ/3bM5MQdnoSJ4p8CCj
         RO+zfnyprlPWw66nN99OEspmMHS8QJWyNe3cyXr8C85z2I7MhryazEEktTX+J4fgVf
         1twrfLvAMDSvVLT4of+PSRcIH509fXyWlFeDNJGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 098/227] ACPI: button: Add lid disable DMI quirk for Nextbook Ares 8A
Date:   Tue, 25 Jul 2023 12:44:25 +0200
Message-ID: <20230725104518.796952645@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 4fd5556608bfa9c2bf276fc115ef04288331aded ]

The LID0 device on the Nextbook Ares 8A tablet always reports lid
closed causing userspace to suspend the device as soon as booting
is complete.

Add a DMI quirk to disable the broken lid functionality.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/button.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 475e1eddfa3b4..ef77c14c72a92 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -77,6 +77,15 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
 	},
+	{
+		/* Nextbook Ares 8A tablet, _LID device always reports lid closed */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CherryTrail"),
+			DMI_MATCH(DMI_BIOS_VERSION, "M882"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
+	},
 	{
 		/*
 		 * Lenovo Yoga 9 14ITL5, initial notification of the LID device
-- 
2.39.2



