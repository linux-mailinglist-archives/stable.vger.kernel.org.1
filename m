Return-Path: <stable+bounces-220228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJVDFucto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C75371C55F6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049DA311673C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC54F7993;
	Sat, 28 Feb 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFsynSqH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8004F798E;
	Sat, 28 Feb 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300133; cv=none; b=LYrHPnTdnLebJHSm3MtnKeaGOpZ0tHPbRppXPuHZvkYkXAeoKBGRS6ygZGpM4FaqEFnG4pPII/EOWI5FRcO0+MeUzt4CQCW5iYoltQ1GW5fsPevVnfUxJwMatw1T+ioT3HN7ml8/nBMeFVZZcR7JR35RokUxX3P9KvbpB1r98U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300133; c=relaxed/simple;
	bh=70Z/ufDjf1kcofKyMtayteHWgkEdvEWGI2H+qggGxyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoXRuy4f8o6tV3qO6m1XqxPKmXnBz5SJLi5klyT+sFzVclVNd0NnKZpHyj+Kgz9hABygccujJWFP45wNPxNklP+sy/73FN960SIdqLQ5jXXQAqVy2Dd1qSfFxp12gMWMR3NDnbgKM3JplTGcnWf77vFirm7rtpDTQrSb1JiwJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFsynSqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E1FC116D0;
	Sat, 28 Feb 2026 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300133;
	bh=70Z/ufDjf1kcofKyMtayteHWgkEdvEWGI2H+qggGxyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFsynSqH8myl8G//ZTeNUk20vLVsofpdNOQoDETfECZ5KaZuXOODtvGCXMH8hzGyb
	 jwcOFTipPOn8LZCmtJ/k1FTx+MRdwaDAyJh72tN2Z8XGB6NS8s37pK5NOnI04dKsXj
	 9cClYF3SF/OL0X7qGrSt43djQZkXR3yBrYlulDgdEEMkYCjxR1n6LSovrv7lr0aB+F
	 819KLqIG8IJTQgd2NN6EDb4fZgIoZJyVLNQrt0q7QjmYrn4AQ6fcXDIqwWRPCr7qb2
	 5Kzk31X3nyvZxGXVP1RX1gYBGRUUak4qoNdy+pDLs0YlkuEgreKJm7+TPsTgr9uRcx
	 6q/2kGixZ1JFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 150/844] ALSA: hda/realtek - Enable Mute LED for Lenovo platform
Date: Sat, 28 Feb 2026 12:21:03 -0500
Message-ID: <20260228173244.1509663-151-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220228-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C75371C55F6
X-Rspamd-Action: no action

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 5de5db35350d9c4def1de2ae273e224a4eee5ed1 ]

Enable SPK Mute Led and Mic Mute Led for Lenovo platform.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://patch.msgid.link/8a99edffee044e13b6e348d1b69c2b57@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 15203c5855eb5..1964494321006 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -1616,6 +1616,20 @@ static void alc295_fixup_hp_mute_led_coefbit11(struct hda_codec *codec,
 	}
 }
 
+static void alc233_fixup_lenovo_coef_micmute_led(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mic_led_coef.idx = 0x10;
+		spec->mic_led_coef.mask = 1 << 13;
+		spec->mic_led_coef.on = 0;
+		spec->mic_led_coef.off = 1 << 13;
+		snd_hda_gen_add_micmute_led_cdev(codec, coef_micmute_led_set);
+	}
+}
+
 static void alc285_fixup_hp_mute_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -1918,6 +1932,39 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 	}
 }
 
+/* GPIO2 = mic mute hotkey
+ * GPIO3 = mic mute LED
+ */
+static void alc233_fixup_lenovo_gpio2_mic_hotkey(struct hda_codec *codec,
+					     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	alc233_fixup_lenovo_coef_micmute_led(codec, fix, action);
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		alc_update_coef_idx(codec, 0x10, 1<<2, 1<<2);
+		if (alc_register_micmute_input_device(codec) != 0)
+			return;
+
+		spec->gpio_mask |= 0x04;
+		spec->gpio_dir |= 0x0;
+		snd_hda_codec_write_cache(codec, codec->core.afg, 0,
+					  AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x04);
+		snd_hda_jack_detect_enable_callback(codec, codec->core.afg,
+						    gpio2_mic_hotkey_event);
+		return;
+	}
+
+	if (!spec->kb_dev)
+		return;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_FREE:
+		input_unregister_device(spec->kb_dev);
+		spec->kb_dev = NULL;
+	}
+}
+
 /* Line2 = mic mute hotkey
  * GPIO2 = mic mute LED
  */
@@ -3816,6 +3863,7 @@ enum {
 	ALC245_FIXUP_HP_TAS2781_I2C_MUTE_LED,
 	ALC288_FIXUP_SURFACE_SWAP_DACS,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO,
+	ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6306,6 +6354,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc288_fixup_surface_swap_dacs,
 	},
+        [ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY] = {
+                .type = HDA_FIXUP_FUNC,
+                .v.func = alc233_fixup_lenovo_gpio2_mic_hotkey,
+        },
 };
 
 static const struct hda_quirk alc269_fixup_tbl[] = {
@@ -7213,7 +7265,12 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3176, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
+	SND_PCI_QUIRK(0x17aa, 0x3341, "Lenovo ThinkCentre M90 Gen4", ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY),
+	SND_PCI_QUIRK(0x17aa, 0x3342, "Lenovo ThinkCentre M90 Gen4", ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY),
+	SND_PCI_QUIRK(0x17aa, 0x3343, "Lenovo ThinkCentre M70 Gen4", ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY),
+	SND_PCI_QUIRK(0x17aa, 0x3344, "Lenovo ThinkCentre M70 Gen4", ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x334f, "Lenovo ThinkCentre M90a Gen5", ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x3384, "ThinkCentre M90a PRO", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
 	SND_PCI_QUIRK(0x17aa, 0x3386, "ThinkCentre M90a Gen6", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
 	SND_PCI_QUIRK(0x17aa, 0x3387, "ThinkCentre M70a Gen6", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
-- 
2.51.0


