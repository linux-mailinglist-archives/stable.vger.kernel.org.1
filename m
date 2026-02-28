Return-Path: <stable+bounces-220267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBFdFlovo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F611C57AA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477B2322391C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BAD37F054;
	Sat, 28 Feb 2026 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt8D1Tu4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6137F04A;
	Sat, 28 Feb 2026 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300170; cv=none; b=gy1hubwtD+DSvDw144djuy5wv0ikhv5qiCJbnLwCxba0NQA3aOrcObczbUOACxryrO2je5uqW9IU4wcx6ltNtXff+QIMFGMnDI/df8WaE8OD6wNAclvFwhKZivt6buOZcJWeMlN1THc3QrjiNNA5lD05JCeyaLRtKjrPgT9KfmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300170; c=relaxed/simple;
	bh=kH2Q4tjC6AD30/OuYaSFbeXe/W8j/TLTaXSK7hAfnPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ3cOmmmfPrN1QmZDiF+3Krv5WiXfnOUiGoQSesFqeYXIUCjx7ApxO/J33EA9tzeFYDJpurtPSlsZ54/wMtZNxRu7AESzUqNDBy0BctjquDPG9cDcQUOEc+GoqSPXp3xHYYD4Aq0E5IEPURVs6oqXmZGcZtqFp4LOpzZ4HHtEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt8D1Tu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E13C19424;
	Sat, 28 Feb 2026 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300170;
	bh=kH2Q4tjC6AD30/OuYaSFbeXe/W8j/TLTaXSK7hAfnPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tt8D1Tu4yUI7eg4GKeLGszUwz6mS2s8mnmG1zOZni4zG14ZlbFULGnyooUjNXMmQj
	 v9ZvYU1qDlv52sIRtmtVlSntCLtvTBtEdNfpGufmGXRe+GIJbxNTAgzf91jbkDTwnk
	 +2bLgIBHIzmAw5yoLNWJU/G7E6+ortlPG0Jk94HBu4OkpP3ORx1jwmycNIX9yyM6TB
	 VhlF7QtBmA02rcy0LCk7cMT8oOdekvbpxehHW36ELpRPv78+JguQNzmUuyzQaUPO8K
	 zsLgCve34Ps4M/kMMGcChrH1uvOlG96+I0VMTEzn6nUoNxTQQVzw6du1r8tJan+jZ0
	 kBr2UeQSNEuxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bharat Dev Burman <bharat.singh7924@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 189/844] ALSA: hda/realtek: add HP Victus 16-e0xxx mute LED quirk
Date: Sat, 28 Feb 2026 12:21:42 -0500
Message-ID: <20260228173244.1509663-190-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220267-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0F611C57AA
X-Rspamd-Action: no action

From: Bharat Dev Burman <bharat.singh7924@gmail.com>

[ Upstream commit 72919c57a055f6d7b79d66731dc398e9b433f47c ]

HP Victus 16-e0xxx with ALC245 codec does not handle the toggling of
the mute LED.
This patch adds a quirk entry for subsystem ID 0x88eb using a new
ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT fixup, enabling correct mute LED
behavior.

Signed-off-by: Bharat Dev Burman <bharat.singh7924@gmail.com>
Link: https://patch.msgid.link/20260112184253.33376-1-bharat.singh7924@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 1964494321006..c9f59e62ee022 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -1551,6 +1551,22 @@ static void alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
 	}
 }
 
+static void alc245_fixup_hp_mute_led_v2_coefbit(struct hda_codec *codec,
+					  const struct hda_fixup *fix,
+					  int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_coef.idx = 0x0b;
+		spec->mute_led_coef.mask = 1 << 3;
+		spec->mute_led_coef.on = 1 << 3;
+		spec->mute_led_coef.off = 0;
+		snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
+	}
+}
+
 /* turn on/off mic-mute LED per capture hook by coef bit */
 static int coef_micmute_led_set(struct led_classdev *led_cdev,
 				enum led_brightness brightness)
@@ -3828,6 +3844,7 @@ enum {
 	ALC287_FIXUP_YOGA7_14ARB7_I2C,
 	ALC245_FIXUP_HP_MUTE_LED_COEFBIT,
 	ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT,
+	ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT,
 	ALC245_FIXUP_HP_X360_MUTE_LEDS,
 	ALC287_FIXUP_THINKPAD_I2S_SPK,
 	ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD,
@@ -6165,6 +6182,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_mute_led_v1_coefbit,
 	},
+	[ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc245_fixup_hp_mute_led_v2_coefbit,
+	},
 	[ALC245_FIXUP_HP_X360_MUTE_LEDS] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc245_fixup_hp_mute_led_coefbit,
@@ -6654,6 +6675,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x88dd, "HP Pavilion 15z-ec200", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x88eb, "HP Victus 16-e0xxx", ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
-- 
2.51.0


