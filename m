Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46247C759F
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 20:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347319AbjJLSEM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 14:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjJLSEL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 14:04:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633B8CA
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 11:04:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0770C433CB;
        Thu, 12 Oct 2023 18:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697133848;
        bh=L3tnrlDYFUPLmUAN8WFjPAVlMimishuMe35uY24447M=;
        h=Subject:To:Cc:From:Date:From;
        b=YgwYyZQ3AZ7EO/Be+PkUObBlwpAB2TSsKFJkBuOIe069Iv/+gMV5spCAHSpeRVt5a
         3t7Qumg8R1LEE7Y6MogjKZqcv8AmZDeyiO8B4VcXdN5cHJ+LnZxIbIjo3rm7Oxh6hc
         bDZaNZzpCl9FEGO24jQdwnU6W4tn23Xq4rVMakHk=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek - ALC287 merge RTK codec with CS CS35L41" failed to apply to 6.1-stable tree
To:     kailang@realtek.com, tiwai@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 12 Oct 2023 20:03:57 +0200
Message-ID: <2023101257-educated-sloppy-c73d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d93eeca627db512a56145285dc94feac5b88a1d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101257-educated-sloppy-c73d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d93eeca627db ("ALSA: hda/realtek - ALC287 merge RTK codec with CS CS35L41 AMP")
e43252db7e20 ("ALSA: hda/realtek - ALC287 I2S speaker platform support")
c99c26b16c15 ("ALSA: hda/realtek: Add quirk for mute LEDs on HP ENVY x360 15-eu0xxx")
93dc18e11b1a ("ALSA: hda/realtek: Add quirk for HP Victus 16-d1xxx to enable mute LED")
3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
f7b069cf0881 ("ALSA: hda/realtek: Fix generic fixup definition for cs35l41 amp")
0659400f18c0 ("ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx")
067eb0845928 ("ALSA: hda/realtek: Add quirk for ThinkPad P1 Gen 6")
8eda19cd59ce ("ALSA: hda/realtek: Add quirks for Lenovo Z13/Z16 Gen2")
9a6804aa1c92 ("ALSA: hda/realtek: Enable mute/micmute LEDs on HP Elitebook, 645 G9")
ca88eeb308a2 ("ALSA: hda/realtek: Enable mute/micmute LEDs on HP Spectre x360 13-aw0xxx")
a4517c4f3423 ("ALSA: hda/realtek: Apply dual codec fixup for Dell Latitude laptops")
2912cdda734d ("ALSA: patch_realtek: Fix Dell Inspiron Plus 16")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d93eeca627db512a56145285dc94feac5b88a1d4 Mon Sep 17 00:00:00 2001
From: Kailang Yang <kailang@realtek.com>
Date: Thu, 21 Sep 2023 15:20:41 +0800
Subject: [PATCH] ALSA: hda/realtek - ALC287 merge RTK codec with CS CS35L41
 AMP

This is merge model ALC287_FIXUP_THINKPAD_I2S_SPK and
ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Fixes: f7b069cf0881 ("ALSA: hda/realtek: Fix generic fixup definition for cs35l41 amp")
Link: https://lore.kernel.org/r/82a45234327c4c50b4988a27e9f64c37@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 751783f3a15c..48bb57bd8d11 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7343,6 +7343,7 @@ enum {
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
 	ALC287_FIXUP_THINKPAD_I2S_SPK,
+	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9441,6 +9442,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_bind_dacs,
 	},
+	[ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_bind_dacs,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9988,14 +9995,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x22be, "Thinkpad X1 Carbon 8th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c1, "Thinkpad P1 Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c2, "Thinkpad X1 Extreme Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
-	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
-	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x2318, "Thinkpad Z13 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x2319, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x231a, "Thinkpad Z16 Gen2", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),

