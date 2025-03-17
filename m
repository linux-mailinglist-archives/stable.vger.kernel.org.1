Return-Path: <stable+bounces-124707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34493A658F6
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D9619A2B27
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4F0209689;
	Mon, 17 Mar 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dky2ElzV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93571A76BB;
	Mon, 17 Mar 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229608; cv=none; b=LOw+/s4AXVZHb+U3darhyoCWFzxnhQNgBVrvOtnKeRl+9OgzU2L6rWWraIbutabYRlMi1OrhBRf7RVTEZIKd4YVu9Rp8NMF5VrFyGMoaZ5AvQjH76dHg0ud0P1s58AvODYhWyUmXYrMcGWjxUcQnbMCGL+L4TWlkS2Q0haQ03Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229608; c=relaxed/simple;
	bh=IuhfuT8S9hJIHHhBNQwtEhBy0GkXzY0UjEZtJlxCkak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9uV9RpZMuTc/A47Gr8PgOYVmRTXsRWIqRMuAWV6hc+RKp+PL1PQ7epai9SQCTSpgM4vUnWMm8afQuxIGuivmYm7b8LGKTwL3gJMaDm6FlMlhmJ1/O42G70k/S2pKa7P9rPeesOPMUbMwepDikS2ypHr3R8UR6pqYRZwRpg1XxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dky2ElzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F11EC4CEED;
	Mon, 17 Mar 2025 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229607;
	bh=IuhfuT8S9hJIHHhBNQwtEhBy0GkXzY0UjEZtJlxCkak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dky2ElzVrE/MDT/QDJWP8o3nSxK+DESURc0B5qMO4M/tbtINU040xVIhfeeuED8+e
	 eWEEQXEe11i95fjCxJ0Fd92vYSuAyM0HznQruJ52SvyKrWWyMq8CBK8y6b7d2EejUT
	 v6ZrOKjQeD5id8S0xr0rdD2M4qrVGTKwKcLoXY1km7/SSs+F5dwISoeEDlUVjbCwlN
	 k6PcBDU+iK+q2u9CLllVLW3INrKo5sT3MVEVHO+OKMuRoq0GtXBMwyONE4bhWI2pZe
	 K6C0EG51yyQe9+lYiXLE4uxKzVflh+CRBICH2YmKuZFIOh2DCthQjTNrLXA1KFrco2
	 8bsxzsgyYM8Qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Navon John Lukose <navonjohnlukose@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/4] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion x360 14-dy1xxx
Date: Mon, 17 Mar 2025 12:39:49 -0400
Message-Id: <20250317163949.1893632-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163949.1893632-1-sashal@kernel.org>
References: <20250317163949.1893632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Navon John Lukose <navonjohnlukose@gmail.com>

[ Upstream commit b11a74ac4f545626d0dc95a8ca8c41df90532bf3 ]

Add a fixup to enable the mute LED on HP Pavilion x360 Convertible
14-dy1xxx with ALC295 codec. The appropriate coefficient index and bits
were identified through a brute-force method, as detailed in
https://bbs.archlinux.org/viewtopic.php?pid=2079504#p2079504.

Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
Link: https://patch.msgid.link/20250307213319.35507-1-navonjohnlukose@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6440a79f4d480..f60e10a0c657f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4757,6 +4757,21 @@ static void alc236_fixup_hp_coef_micmute_led(struct hda_codec *codec,
 	}
 }
 
+static void alc295_fixup_hp_mute_led_coefbit11(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0xb;
+		spec->mute_led_coef.mask = 3 << 3;
+		spec->mute_led_coef.on = 1 << 3;
+		spec->mute_led_coef.off = 1 << 4;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 static void alc285_fixup_hp_mute_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -6996,6 +7011,7 @@ enum {
 	ALC290_FIXUP_MONO_SPEAKERS_HSJACK,
 	ALC290_FIXUP_SUBWOOFER,
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
+	ALC295_FIXUP_HP_MUTE_LED_COEFBIT11,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
 	ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13,
@@ -8542,6 +8558,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC283_FIXUP_INT_MIC,
 	},
+	[ALC295_FIXUP_HP_MUTE_LED_COEFBIT11] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc295_fixup_hp_mute_led_coefbit11,
+	},
 	[ALC298_FIXUP_SAMSUNG_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_samsung_amp,
@@ -9256,6 +9276,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.39.5


