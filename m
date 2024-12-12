Return-Path: <stable+bounces-101203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F859EEADC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A782827BA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6985C1487CD;
	Thu, 12 Dec 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="obt7UoUG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDD2AF0E;
	Thu, 12 Dec 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016716; cv=none; b=WWW2v2YCe8eZU4ipb+RfJIETfytzpT23Xw+Orhe7sytmXELV1CQK7daTvJSdqBEoVY3ItaDXVJk9QHnn75R0WHiavLrac0Ta/7u2lXVacgDRA1Bhm4xGndKP1X8CeHko+iAit6eh4UcSCTDeLpsIl5W8YNLDT4kVmWBP39sRvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016716; c=relaxed/simple;
	bh=9LMaZ7uPrs0ZfdwrvvsX2lsybySPbUselO81QJLFgKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQTPdZBiLJBSQw8OnwIWPaKAw/0VELQrMLXX+nT+42rsWNbavfofSzUks7m/O5kCcQvZGd8fX9NLjbfd+2SQi+92x/aUNifACfZpGyoHxV1WtFGez2FldPJsCCZTJ37go2PhBQrITI04Vd+mCdLhe2DxHvCWUlNG8kx2CP5IjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=obt7UoUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88827C4CECE;
	Thu, 12 Dec 2024 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016716;
	bh=9LMaZ7uPrs0ZfdwrvvsX2lsybySPbUselO81QJLFgKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obt7UoUGDAeuxrLkqvXsno2kGTp6J46QpupElZM4Cr397uXmn47Pet0OMZYTniXOd
	 zzpmQ4NXwxM2pKlRoPse2GRITwGVvoNtNdNxjRQwXOh4cHzPc3kYcnQMulshSm3jMk
	 s+AMWLHQBNz4/iE9v2ioIEMdi5GP26qVwHR8mdm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 278/466] ALSA: hda/realtek: Use codec SSID matching for Lenovo devices
Date: Thu, 12 Dec 2024 15:57:27 +0100
Message-ID: <20241212144317.769231606@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 504f052aa3435ab2f15af8b20bc4f4de8ff259c7 ]

Now we can perform the codec ID matching primarily, and reduce the
conditional application of the quirk for conflicting PCI SSIDs in
various Lenovo devices.

Here, HDA_CODEC_QUIRK() is applied at first so that the device with
the codec SSID matching is picked up, followed by SND_PCI_QUIRK() for
PCI SSID matching with the same ID number.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20241008120233.7154-4-tiwai@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 98 +++--------------------------------
 1 file changed, 8 insertions(+), 90 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1138883c68625..2aa8198d3ea1b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7726,8 +7726,6 @@ enum {
 	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
 	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
 	ALC298_FIXUP_LENOVO_C940_DUET7,
-	ALC287_FIXUP_LENOVO_14IRP8_DUETITL,
-	ALC287_FIXUP_LENOVO_LEGION_7,
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
 	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
@@ -7772,8 +7770,6 @@ enum {
 	ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1,
 	ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318,
 	ALC256_FIXUP_CHROME_BOOK,
-	ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7,
-	ALC287_FIXUP_LENOVO_SSID_17AA3820,
 	ALC245_FIXUP_CLEVO_NOISY_MIC,
 	ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE,
 	ALC233_FIXUP_MEDION_MTL_SPK,
@@ -7796,72 +7792,6 @@ static void alc298_fixup_lenovo_c940_duet7(struct hda_codec *codec,
 	__snd_hda_apply_fixup(codec, id, action, 0);
 }
 
-/* A special fixup for Lenovo Slim/Yoga Pro 9 14IRP8 and Yoga DuetITL 2021;
- * 14IRP8 PCI SSID will mistakenly be matched with the DuetITL codec SSID,
- * so we need to apply a different fixup in this case. The only DuetITL codec
- * SSID reported so far is the 17aa:3802 while the 14IRP8 has the 17aa:38be
- * and 17aa:38bf. If it weren't for the PCI SSID, the 14IRP8 models would
- * have matched correctly by their codecs.
- */
-static void alc287_fixup_lenovo_14irp8_duetitl(struct hda_codec *codec,
-					      const struct hda_fixup *fix,
-					      int action)
-{
-	int id;
-
-	if (codec->core.subsystem_id == 0x17aa3802)
-		id = ALC287_FIXUP_YOGA7_14ITL_SPEAKERS; /* DuetITL */
-	else
-		id = ALC287_FIXUP_TAS2781_I2C; /* 14IRP8 */
-	__snd_hda_apply_fixup(codec, id, action, 0);
-}
-
-/* Similar to above the Lenovo Yoga Pro 7 14ARP8 PCI SSID matches the codec SSID of the
-   Legion Y9000X 2022 IAH7.*/
-static void alc287_fixup_lenovo_14arp8_legion_iah7(struct hda_codec *codec,
-					   const struct hda_fixup *fix,
-					   int action)
-{
-	int id;
-
-	if (codec->core.subsystem_id == 0x17aa386e)
-		id = ALC287_FIXUP_CS35L41_I2C_2; /* Legion Y9000X 2022 IAH7 */
-	else
-		id = ALC285_FIXUP_SPEAKER2_TO_DAC1; /* Yoga Pro 7 14ARP8 */
-	__snd_hda_apply_fixup(codec, id, action, 0);
-}
-
-/* Another hilarious PCI SSID conflict with Lenovo Legion Pro 7 16ARX8H (with
- * TAS2781 codec) and Legion 7i 16IAX7 (with CS35L41 codec);
- * we apply a corresponding fixup depending on the codec SSID instead
- */
-static void alc287_fixup_lenovo_legion_7(struct hda_codec *codec,
-					 const struct hda_fixup *fix,
-					 int action)
-{
-	int id;
-
-	if (codec->core.subsystem_id == 0x17aa38a8)
-		id = ALC287_FIXUP_TAS2781_I2C; /* Legion Pro 7 16ARX8H */
-	else
-		id = ALC287_FIXUP_CS35L41_I2C_2; /* Legion 7i 16IAX7 */
-	__snd_hda_apply_fixup(codec, id, action, 0);
-}
-
-/* Yet more conflicting PCI SSID (17aa:3820) on two Lenovo models */
-static void alc287_fixup_lenovo_ssid_17aa3820(struct hda_codec *codec,
-					      const struct hda_fixup *fix,
-					      int action)
-{
-	int id;
-
-	if (codec->core.subsystem_id == 0x17aa3820)
-		id = ALC269_FIXUP_ASPIRE_HEADSET_MIC; /* IdeaPad 330-17IKB 81DM */
-	else /* 0x17aa3802 */
-		id =  ALC287_FIXUP_YOGA7_14ITL_SPEAKERS; /* "Yoga Duet 7 13ITL6 */
-	__snd_hda_apply_fixup(codec, id, action, 0);
-}
-
 static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_GPIO2] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9810,14 +9740,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_lenovo_c940_duet7,
 	},
-	[ALC287_FIXUP_LENOVO_14IRP8_DUETITL] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = alc287_fixup_lenovo_14irp8_duetitl,
-	},
-	[ALC287_FIXUP_LENOVO_LEGION_7] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = alc287_fixup_lenovo_legion_7,
-	},
 	[ALC287_FIXUP_13S_GEN2_SPEAKERS] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -10002,10 +9924,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK,
 	},
-	[ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = alc287_fixup_lenovo_14arp8_legion_iah7,
-	},
 	[ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc287_fixup_yoga9_14iap7_bass_spk_pin,
@@ -10140,10 +10058,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC225_FIXUP_HEADSET_JACK
 	},
-	[ALC287_FIXUP_LENOVO_SSID_17AA3820] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = alc287_fixup_lenovo_ssid_17aa3820,
-	},
 	[ALC245_FIXUP_CLEVO_NOISY_MIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_limit_int_mic_boost,
@@ -10911,11 +10825,13 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
-	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8 / DuetITL 2021", ALC287_FIXUP_LENOVO_14IRP8_DUETITL),
+	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
-	SND_PCI_QUIRK(0x17aa, 0x3820, "IdeaPad 330 / Yoga Duet 7", ALC287_FIXUP_LENOVO_SSID_17AA3820),
+	HDA_CODEC_QUIRK(0x17aa, 0x3820, "IdeaPad 330-17IKB 81DM", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x3820, "Yoga Duet 7 13ITL6", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3824, "Legion Y9000X 2020", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
@@ -10929,8 +10845,10 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3865, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3866, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
-	SND_PCI_QUIRK(0x17aa, 0x386e, "Legion Y9000X 2022 IAH7 / Yoga Pro 7 14ARP8",  ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7),
-	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion Pro 7/7i", ALC287_FIXUP_LENOVO_LEGION_7),
+	HDA_CODEC_QUIRK(0x17aa, 0x386e, "Legion Y9000X 2022 IAH7", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x386e, "Yoga Pro 7 14ARP8", ALC285_FIXUP_SPEAKER2_TO_DAC1),
+	HDA_CODEC_QUIRK(0x17aa, 0x386f, "Legion Pro 7 16ARX8H", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion Pro 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3877, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3878, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.43.0




