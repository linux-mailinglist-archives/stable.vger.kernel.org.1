Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DEB7612F8
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjGYLG7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjGYLGq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:06:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278E8211B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:05:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B300961656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E25C433C7;
        Tue, 25 Jul 2023 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283108;
        bh=cMVd8dXQ5rMtlSutVKSDlDlElv7T0WX7Yotdrtz4s6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZZVtaPYr/02qkN7mXyKBCMlLZYlIu2yNk/vSzzhr9imAhemem40Iilon36EL9R2w
         fIl/OrOo4FtamVorqnslbyhIwGlBDV5HVZozbLB69x307iCSEBr4pQw8TG8SlPPa5j
         T2xeVuguXS+sR3nU1PheIOSsHQC2HiWMpe3xBU7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 142/183] ALSA: hda/realtek: Fix generic fixup definition for cs35l41 amp
Date:   Tue, 25 Jul 2023 12:46:10 +0200
Message-ID: <20230725104513.015454117@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>

[ Upstream commit f7b069cf08816252f494d193b9ecdff172bf9aa1 ]

Generic fixup for CS35L41 amplifies should not have vendor specific
chained fixup. For ThinkPad laptops with led issue, we can just add
specific fixup.

Fixes: a6ac60b36dade (ALSA: hda/realtek: Fix mute led issue on thinkpad with cs35l41 s-codec)
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230720082022.13033-1-vitalyr@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1a8ca119ffe45..cb34a62075b13 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7220,6 +7220,7 @@ enum {
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
+	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9090,8 +9091,6 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC287_FIXUP_CS35L41_I2C_2] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_i2c_two,
-		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
 	[ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9228,6 +9227,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 	},
+	[ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9750,14 +9755,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x22be, "Thinkpad X1 Carbon 8th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c1, "Thinkpad P1 Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c2, "Thinkpad X1 Extreme Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
-	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
-- 
2.39.2



