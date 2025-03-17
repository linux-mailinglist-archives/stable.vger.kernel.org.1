Return-Path: <stable+bounces-124713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836A1A65910
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8884883EC9
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAE220A5DA;
	Mon, 17 Mar 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEvF/a6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB0B20A5D1;
	Mon, 17 Mar 2025 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229615; cv=none; b=BF2siPCFcz6VWvkx8xW2kvGNaX3dAH6+pdg+/U64Ri+EXodk+SP9wsPdw8ZWSd70LVnos0o9zhbrb2g5jKOVVNdZxF1UHpYsEcPh0DyXDWMXAKW546qPBrXPUQtaWSb6AxelB0pmS9/aYuO6gQfT3IWrJcH5yMpO7RX5mavyK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229615; c=relaxed/simple;
	bh=UKFgi1ct+m4YwkxpymQeYyxpXLQw5s5TfYgDObZm0GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aY8rqgqozWOxLHksGvwVdWhZE6bpshQKW9S8vrFTZw2GPKo/8/rzstyyLgvFr26oqjVwYKvgdAA5zl2MiO9ZFZtxNs/322ZHRBHN0GpU9N5WPRS7UF41bABSlSMrEH3U/twurXhASNt3DhVYH/jDLV/bEaiK4HRrdes5mjZBCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEvF/a6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FB9C4CEEC;
	Mon, 17 Mar 2025 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229615;
	bh=UKFgi1ct+m4YwkxpymQeYyxpXLQw5s5TfYgDObZm0GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aEvF/a6PPLsuYyx5tL+3s6r6ZXqGYCS2zUPI6mtsKOFubx6DlSokpdQkC+lEvydoO
	 nN8hC0JgYMjljaLZaEUpFQEu9fmocjBcrbyE4EICagE7+nhHzUaCeNhtMJesA0BThS
	 ePb/laEP6l7z5Vq3h7MxxZvjCrmHZ0Ka6oVZhOJNRGpnvyZbR4uaT0OpQfNQ0QGY86
	 xK6l7MdA+KfaRx07iKeXrR38pS5UEIhVUnc/EdX3P69piBR5fzpZdmtMpqjvgXRL4K
	 r4XNLF1x+sfzX3mad6KdGiMJGsPJws4ZMqx94mKc0JlcqT8ggVe6WWPRrxFPJH3wgm
	 bCvoqFDqpi+5A==
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
Subject: [PATCH AUTOSEL 5.10 2/2] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion x360 14-dy1xxx
Date: Mon, 17 Mar 2025 12:40:08 -0400
Message-Id: <20250317164008.1893869-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317164008.1893869-1-sashal@kernel.org>
References: <20250317164008.1893869-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
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
index ea12b7f815e10..aedf87d120bfd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4700,6 +4700,21 @@ static void alc236_fixup_hp_coef_micmute_led(struct hda_codec *codec,
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
@@ -6940,6 +6955,7 @@ enum {
 	ALC290_FIXUP_MONO_SPEAKERS_HSJACK,
 	ALC290_FIXUP_SUBWOOFER,
 	ALC290_FIXUP_SUBWOOFER_HSJACK,
+	ALC295_FIXUP_HP_MUTE_LED_COEFBIT11,
 	ALC269_FIXUP_THINKPAD_ACPI,
 	ALC269_FIXUP_DMIC_THINKPAD_ACPI,
 	ALC269VB_FIXUP_INFINIX_ZERO_BOOK_13,
@@ -8485,6 +8501,10 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -9193,6 +9213,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x861f, "HP Elite Dragonfly G1", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-- 
2.39.5


