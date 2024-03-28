Return-Path: <stable+bounces-26303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF8870DF8
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44901C20FE5
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EEA1F92C;
	Mon,  4 Mar 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xpzSa7qe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB48F58;
	Mon,  4 Mar 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588371; cv=none; b=tbZBjHISRnzNjZEd2FOxuZVaEXNztOcMWaqR28cpMtesGN40LmYL5VjvgXcIRZ3NB9u4j05WSswGWdIUnaTvHoMRcH/LXujpM/sSDc7bwbEpcPh/ZU7sF5NB4T2Gp5qd2Wa0op8YSnXWtXQgdz/VImtz0ete2zfS6V1gPWffW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588371; c=relaxed/simple;
	bh=ZxxEBA2guoOsePoVgyvueOnvQLe970bBOO3e2AYJjpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnyM4b9EsPbR7tApmc8S7LblBiRCEmfZIGYM0YGgYs/YiVPPJkQaXrNICkzV+fnPoaNrxzdxfYWEIQk3KIj8AtK6/9G+Kb0JgTiIlwYzRr8CGYru8R7fv4NcsslD+l0ru8xDiD3O5K1+YB+gAVtpJCChU1z8mTa6haQzL6wrhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpzSa7qe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1702FC433F1;
	Mon,  4 Mar 2024 21:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588371;
	bh=ZxxEBA2guoOsePoVgyvueOnvQLe970bBOO3e2AYJjpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xpzSa7qeQurIKs5I3oJrhz+ouf/kvVtVYH8kFOsEcQUaJeB9nW80ST+jMmSTZSWiU
	 oONimbsOxX9o/PgvZWe/3TkYGr4TqWb97VUeNc0wWBF1O2XitUF21pR2Mb3rXAiaWQ
	 2fJpg9BTYPifSRrlG4ZeOQ+ackA9/IV/hQ1j275M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willian Wang <git@willian.wang>,
	Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 074/143] ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8
Date: Mon,  4 Mar 2024 21:23:14 +0000
Message-ID: <20240304211552.287066905@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willian Wang <git@willian.wang>

commit 0ac32a396e4f41e88df76ce2282423188a2d2ed0 upstream.

Lenovo Slim/Yoga Pro 9 14IRP8 requires a special fixup because there is
a collision of its PCI SSID (17aa:3802) with Lenovo Yoga DuetITL 2021
codec SSID.

Fixes: 3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555
Link: https://lore.kernel.org/all/d5b42e483566a3815d229270abd668131a0d9f3a.camel@irl.hu
Cc: stable@vger.kernel.org
Signed-off-by: Willian Wang <git@willian.wang>
Reviewed-by: Gergo Koteles <soyer@irl.hu>
Link: https://lore.kernel.org/r/170879111795.8.6687687359006700715.273812184@willian.wang
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7352,6 +7352,7 @@ enum {
 	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
 	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
 	ALC298_FIXUP_LENOVO_C940_DUET7,
+	ALC287_FIXUP_LENOVO_14IRP8_DUETITL,
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
 	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
@@ -7401,6 +7402,26 @@ static void alc298_fixup_lenovo_c940_due
 	__snd_hda_apply_fixup(codec, id, action, 0);
 }
 
+/* A special fixup for Lenovo Slim/Yoga Pro 9 14IRP8 and Yoga DuetITL 2021;
+ * 14IRP8 PCI SSID will mistakenly be matched with the DuetITL codec SSID,
+ * so we need to apply a different fixup in this case. The only DuetITL codec
+ * SSID reported so far is the 17aa:3802 while the 14IRP8 has the 17aa:38be
+ * and 17aa:38bf. If it weren't for the PCI SSID, the 14IRP8 models would
+ * have matched correctly by their codecs.
+ */
+static void alc287_fixup_lenovo_14irp8_duetitl(struct hda_codec *codec,
+					      const struct hda_fixup *fix,
+					      int action)
+{
+	int id;
+
+	if (codec->core.subsystem_id == 0x17aa3802)
+		id = ALC287_FIXUP_YOGA7_14ITL_SPEAKERS; /* DuetITL */
+	else
+		id = ALC287_FIXUP_TAS2781_I2C; /* 14IRP8 */
+	__snd_hda_apply_fixup(codec, id, action, 0);
+}
+
 static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_GPIO2] = {
 		.type = HDA_FIXUP_FUNC,
@@ -9285,6 +9306,10 @@ static const struct hda_fixup alc269_fix
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_lenovo_c940_duet7,
 	},
+	[ALC287_FIXUP_LENOVO_14IRP8_DUETITL] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_lenovo_14irp8_duetitl,
+	},
 	[ALC287_FIXUP_13S_GEN2_SPEAKERS] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -10134,7 +10159,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
-	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8 / DuetITL 2021", ALC287_FIXUP_LENOVO_14IRP8_DUETITL),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),



