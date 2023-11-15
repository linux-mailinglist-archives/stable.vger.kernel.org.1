Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7186D7ECD94
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjKOThQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbjKOThP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355BB12C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED9AC433C8;
        Wed, 15 Nov 2023 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077031;
        bh=DSm2z21+9fu4uaZoOUas3yPLR2js3cgv/NWeuqLgW/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJ1lQKWOUIHtt69sm+3M09oylqYo8T/Op9f5mrH5u4i9dnOSAxC5E9l+2ct6uwini
         LSn1dLgdB68mEVNTVivP7Q5/fD3Jw5Ol1shyoFa0w7FB2LTEMzgVu0Kg/VvP2ubyNR
         fHIJiYTlOeM86jVcjuy01A6hSHZV0nzPI+h+xbpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Zary <linux@zary.sk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: =?UTF-8?q?=5BPATCH=206=2E6=20103/603=5D=20=3D=3FUTF-8=3Fq=3FACPI=3A=3D20video=3A=3D20Add=3D20acpi=3D5Fbacklight=3D3Dvendor=3D20quir=3F=3D=20=3D=3FUTF-8=3Fq=3Fk=3D20for=3D20Toshiba=3D20Port=3DC3=3DA9g=3DC3=3DA9=3D20R100=3F=3D?=
Date:   Wed, 15 Nov 2023 14:10:48 -0500
Message-ID: <20231115191620.329925022@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Zary <linux@zary.sk>

[ Upstream commit 35a341c9b25da6a479bd8013bcb11a680a7233e3 ]

Toshiba Portégé R100 has both acpi_video and toshiba_acpi vendor
backlight driver working. But none of them gets activated as it has
a VGA with no kernel driver (Trident CyberBlade XP4m32).

The DMI strings are very generic ("Portable PC") so add a custom
callback function to check for Trident CyberBlade XP4m32 PCI device
before enabling the vendor backlight driver (better than acpi_video
as it has more brightness steps).

Fixes: 5aa9d943e9b6 ("ACPI: video: Don't enable fallback path for creating ACPI backlight by default")
Signed-off-by: Ondrej Zary <linux@zary.sk>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 442396f6ed1f9..31205fee59d4a 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -130,6 +130,16 @@ static int video_detect_force_native(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int video_detect_portege_r100(const struct dmi_system_id *d)
+{
+	struct pci_dev *dev;
+	/* Search for Trident CyberBlade XP4m32 to confirm Portégé R100 */
+	dev = pci_get_device(PCI_VENDOR_ID_TRIDENT, 0x2100, NULL);
+	if (dev)
+		acpi_backlight_dmi = acpi_backlight_vendor;
+	return 0;
+}
+
 static const struct dmi_system_id video_detect_dmi_table[] = {
 	/*
 	 * Models which should use the vendor backlight interface,
@@ -270,6 +280,22 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 
+	/*
+	 * Toshiba Portégé R100 has working both acpi_video and toshiba_acpi
+	 * vendor driver. But none of them gets activated as it has a VGA with
+	 * no kernel driver (Trident CyberBlade XP4m32).
+	 * The DMI strings are generic so check for the VGA chip in callback.
+	 */
+	{
+	 .callback = video_detect_portege_r100,
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Portable PC"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "Version 1.0"),
+		DMI_MATCH(DMI_BOARD_NAME, "Portable PC")
+		},
+	},
+
 	/*
 	 * Models which need acpi_video backlight control where the GPU drivers
 	 * do not call acpi_video_register_backlight() because no internal panel
-- 
2.42.0



