Return-Path: <stable+bounces-220321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OzgBmc3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:43:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707A1C6332
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1DC33154D29
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AA936C9FB;
	Sat, 28 Feb 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3KLeTgt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C436C9F3;
	Sat, 28 Feb 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300222; cv=none; b=n0eJzumJCgv9qod613hiE/Qqf0LNuNUlgVbBkTfDPrZBIf2AT6sQqnUnBJOehWCcByp3ePd38jwENnSgCwywbOyXTYlmJuH6lKEHXtsz5UOTuw6jg/PxJXxL6nk+A+8ZWqMZaFbHyS9lMh7j3kAkcn0yxE1PJm8DMwVhBEs+i0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300222; c=relaxed/simple;
	bh=wW3ULmAtSumJmGoZuT2w468/2kPh9PHltumcfbMtRxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThnyH/Fll05C/Qo0l4xPZsyrRH1CKw75EapBGG0PEaMrzScpBS4qSAprlBGfOFP9xecISsIFmjhksgCqpq5I2tBh1leI+8oIhzgAD8RSOZMTdF0k/ZQfGFqlUsZjCNpL6WFU/O1VxzjmoseRrqCJe55RDrRstCLD5EgywBuqnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3KLeTgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3804DC19425;
	Sat, 28 Feb 2026 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300222;
	bh=wW3ULmAtSumJmGoZuT2w468/2kPh9PHltumcfbMtRxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3KLeTgtOSnJKEpnTgLot7HfXYWn3h3F8QgpmBx8lZ3osrmTobQV3tJSaU9tZi5h4
	 gP8Lg04sLbZ7p22+LAEBKW0EYH7Lf4UNvhkPjDVN6ptKYJqAIrdjAvsLCHZuu5CdwE
	 9ZUMpQX4gSXls2LFYELFjhQYr7yBT1n7Mju5KU3lgN/1Y4vQNn+xY+hm1c2XQArYnu
	 y3ISx2zV2Rknqbz3aoMcZGx4GGw7Gf0/N0RsJGPdEqVAsqy1cNfD4w5+0Ds52KCuRx
	 SrrC7+2O0SHUkWBPsKihEA9nlRu/t6XVoLiXz/dyKzuYDzuSkgAPT+H9/YS0+3pLI2
	 tHbovy2AF/imQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Illia Barbashyn <04baril@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 243/844] ALSA: hda/realtek - Enable mute LEDs on HP ENVY x360 15-es0xxx
Date: Sat, 28 Feb 2026 12:22:36 -0500
Message-ID: <20260228173244.1509663-244-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220321-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3707A1C6332
X-Rspamd-Action: no action

From: Illia Barbashyn <04baril@gmail.com>

[ Upstream commit ac1ff574bbc09a6c90f4fe8f9e6b8d66c983064c ]

The mute and mic-mute LEDs on HP ENVY x360 Convertible 15-es0xxx
(PCI SSID 103c:88b3) do not work with the current driver.

This model requires a combination of COEFBIT and GPIO fixups to
correctly control the LEDs. Introduce a new fixup function
alc245_fixup_hp_envy_x360_mute_led and add a quirk to apply it.

Signed-off-by: Illia Barbashyn <04baril@gmail.com>
Link: https://patch.msgid.link/20260207221955.24132-1-04baril@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 82219f03b212c..c11312aa5ca76 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -1660,6 +1660,13 @@ static void alc285_fixup_hp_spectre_x360_mute_led(struct hda_codec *codec,
 	alc285_fixup_hp_gpio_micmute_led(codec, fix, action);
 }
 
+static void alc245_fixup_hp_envy_x360_mute_led(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	alc245_fixup_hp_mute_led_v1_coefbit(codec, fix, action);
+	alc245_fixup_hp_gpio_led(codec, fix, action);
+}
+
 static void alc236_fixup_hp_mute_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -3919,6 +3926,7 @@ enum {
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED,
+	ALC245_FIXUP_HP_ENVY_X360_MUTE_LED,
 	ALC285_FIXUP_HP_BEEP_MICMUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
 	ALC236_FIXUP_HP_GPIO_LED,
@@ -5575,6 +5583,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360_mute_led,
 	},
+	[ALC245_FIXUP_HP_ENVY_X360_MUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_envy_x360_mute_led,
+	},
 	[ALC285_FIXUP_HP_BEEP_MICMUTE_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_beep,
@@ -6848,6 +6860,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x103c, 0x88b3, "HP ENVY x360 Convertible 15-es0xxx", ALC245_FIXUP_HP_ENVY_X360_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x88dd, "HP Pavilion 15z-ec200", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x88eb, "HP Victus 16-e0xxx", ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT),
-- 
2.51.0


