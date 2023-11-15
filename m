Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DCF7ECE0F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjKOTkR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjKOTkO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:40:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5347A1AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:40:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00F5C43395;
        Wed, 15 Nov 2023 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077203;
        bh=nZi/9JNCks2fHKyQ7quDKhGBEd7vb93QbMSARbjr8C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEvfH7TMtfBaobcJt988523TodGHbIkw27+ZSmANTKuFnXawaiVwJaDyvCp8KcyMr
         rVZ2mXWKF7pYIMBFUApT04yHCws9nYg1GKHbInJJ3ceo5bvswPnEAcoJO+zzn+9MMf
         mUHxBjiF3ocfF5jEXfB9StbpuDBwjL71UmLVGqsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 540/550] ALSA: hda/realtek: Add support dual speaker for Dell
Date:   Wed, 15 Nov 2023 14:18:44 -0500
Message-ID: <20231115191638.363056394@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit f0d9da19d7de9e845e7a93a901c4b9658df6b492 ]

Dell new platform support dual speaker. But BIOS verb table only show one speaker.
It will fill verb table for second speaker. Then bind with CS AMP model.

Fixes: de90f5165b1c ("ALSA: hda/realtek: Add support for DELL Oasis 13/14/16 laptops")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/4dd390a77bf742b8a518ac2deee00b0f@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 40 +++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c2fbf484b1104..7f1d79f450a2a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7193,8 +7193,10 @@ enum {
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC299_FIXUP_PREDATOR_SPK,
 	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
+	ALC289_FIXUP_DELL_SPK1,
 	ALC289_FIXUP_DELL_SPK2,
 	ALC289_FIXUP_DUAL_SPK,
+	ALC289_FIXUP_RTK_AMP_DUAL_SPK,
 	ALC294_FIXUP_SPK2_TO_DAC1,
 	ALC294_FIXUP_ASUS_DUAL_SPK,
 	ALC285_FIXUP_THINKPAD_X1_GEN7,
@@ -7293,6 +7295,7 @@ enum {
 	ALC287_FIXUP_THINKPAD_I2S_SPK,
 	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD,
 	ALC2XX_FIXUP_HEADSET_MIC,
+	ALC289_FIXUP_DELL_CS35L41_SPI_2,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -8519,6 +8522,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
+	[ALC289_FIXUP_DELL_SPK1] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90170140 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE
+	},
 	[ALC289_FIXUP_DELL_SPK2] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -8534,6 +8546,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC289_FIXUP_DELL_SPK2
 	},
+	[ALC289_FIXUP_RTK_AMP_DUAL_SPK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+		.chained = true,
+		.chain_id = ALC289_FIXUP_DELL_SPK1
+	},
 	[ALC294_FIXUP_SPK2_TO_DAC1] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_speaker2_to_dac1,
@@ -9395,6 +9413,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_headset_mic,
 	},
+	[ALC289_FIXUP_DELL_CS35L41_SPI_2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_spi_two,
+		.chained = true,
+		.chain_id = ALC289_FIXUP_DUAL_SPK
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -9505,13 +9529,15 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0c1c, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1d, "Dell Precision 3440", ALC236_FIXUP_DELL_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1028, 0x0c1e, "Dell Precision 3540", ALC236_FIXUP_DELL_DUAL_CODECS),
-	SND_PCI_QUIRK(0x1028, 0x0cbd, "Dell Oasis 13 CS MTL-U", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1028, 0x0cbe, "Dell Oasis 13 2-IN-1 MTL-U", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1028, 0x0cbf, "Dell Oasis 13 Low Weight MTU-L", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1028, 0x0cc1, "Dell Oasis 14 MTL-H/U", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1028, 0x0cc2, "Dell Oasis 14 2-in-1 MTL-H/U", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1028, 0x0cc3, "Dell Oasis 14 Low Weight MTL-U", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1028, 0x0cc4, "Dell Oasis 16 MTL-H/U", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cbd, "Dell Oasis 13 CS MTL-U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cbe, "Dell Oasis 13 2-IN-1 MTL-U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cbf, "Dell Oasis 13 Low Weight MTU-L", ALC289_FIXUP_DELL_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc0, "Dell Oasis 13", ALC289_FIXUP_RTK_AMP_DUAL_SPK),
+	SND_PCI_QUIRK(0x1028, 0x0cc1, "Dell Oasis 14 MTL-H/U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc2, "Dell Oasis 14 2-in-1 MTL-H/U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc3, "Dell Oasis 14 Low Weight MTL-U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc4, "Dell Oasis 16 MTL-H/U", ALC289_FIXUP_DELL_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1028, 0x0cc5, "Dell Oasis 14", ALC289_FIXUP_RTK_AMP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.42.0



