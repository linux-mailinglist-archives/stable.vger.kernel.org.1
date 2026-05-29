Return-Path: <stable+bounces-256825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBA9KuckGmow1wgAu9opvQ
	(envelope-from <stable+bounces-256825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:44:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05798609EEA
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F023066405
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4629D3AD526;
	Fri, 29 May 2026 23:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKI0RLNO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E433F8AA
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097916; cv=none; b=lSY8z3x3IaJL2WeDGPYuGx/33WYeWu1LK+D+MDuq7mOE2/Jo6+yh0SKtqfbsaaVAvPkKkCY2ohFOXR9n7qnOAONq8MscpIqLKn3FTefpAHmGI/r9Ee2Yeo8d23v0tlKtgAcxl1FvFH3cXyQghCsQcDEzw366DNQrSKOZWXvvbJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097916; c=relaxed/simple;
	bh=wIe6tbkNST/2wCjczC/ZMHY8o1RVS04e4M9Tc6KnHHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmm5utry9A5Uyhkj4uRdjSezEPnJpx4HZdJMM0Fo5iOMHDBmWjLlzTCoUN7M3yN3tjeHvyXT1CGFUe7czGtoRkWeuIXhThYlNhK0Rqe68e2/p8iNNsbO0UM6ujpicEhrjHrhxl1FA0snQComWvQFCTcAOQQgrhB868dUB1mYwZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKI0RLNO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804ED1F00893;
	Fri, 29 May 2026 23:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097915;
	bh=6Qxo/0ahzWwGAPeAJ0MnobwhLxDTBxEsbGYQzbFpJ1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UKI0RLNOm3Z8q9VeTTW9U6U+mtv+9/oJ3YbhPep3zY1g7ix6yJeY49Hu0JQRmKDTu
	 WWXV5mwraD4myZKDxKTowWwuwEalaIqeIUsPTlRpZhIMf4Bbq0nB5AZy9uwrdw4l8q
	 6+yjcQgjk6MfGQFSuEtHJp59fSrvrmBlGs1mMAOT0u770MFgVoU99P0Z5LGQ+IpTmr
	 IRjERSp7Ib/ypDm2w8qNcA11XMcUkxMhXMJJlxlhSf6QhuyTL8KSuvJNycfLl8eao+
	 pBBJeXRy17chcT62ovvolHDlJOxpoHOCrf+yHxUhQ+Sqz41Je1YmYE9EUhJ83vYYxy
	 aV/BspNiNjzQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fernando Antunez Antonio <fer.antunez24antonio@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 1/2] ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP Envy X360 15-fh0xxx
Date: Fri, 29 May 2026 19:38:32 -0400
Message-ID: <20260529233833.1909329-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052801-harmonize-cosmos-d0b2@gregkh>
References: <2026052801-harmonize-cosmos-d0b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256825-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05798609EEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Fernando Antunez Antonio <fer.antunez24antonio@gmail.com>

[ Upstream commit dc1e0172be54e742bccb28d5f14c0c395e28c098 ]

This enables the mute and mic-mute LEDs on the HP Envy X360 15-fh0xxx
2-in-1 laptops.
The quirk 'ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX' has been created and
is now enabled for this device.

This is my first patch, and I'm still getting to grips with the code,
so there's probably a better way to implement this fix.
I apologize for any inconvenience caused by the constant release of
new versions of this patch.

Signed-off-by: Fernando Antunez Antonio <fer.antunez24antonio@gmail.com>
Link: https://patch.msgid.link/20260504-hpenvy-muteled-fix-v3-1-5567fd9b3d25@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 9e5fb6098d21 ("ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP 16 Piston OmniBook X")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 8f7d8337b4bc6..9f69a888ffbed 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4132,6 +4132,7 @@ enum {
 	ALC245_FIXUP_ACER_MICMUTE_LED,
 	ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED,
 	ALC236_FIXUP_HP_DMIC,
+	ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6678,6 +6679,12 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x12, 0x90a60160 }, /* use as internal mic */
 			{ }
 		},
+	},
+	[ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_X360_MUTE_LEDS
 	}
 };
 
@@ -7096,7 +7103,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8be6, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8be7, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8be8, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8be9, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8be9, "HP Envy x360 2-in-1 Laptop 15-fh0xxx", ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8bf0, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c15, "HP Spectre x360 2-in-1 Laptop 14-eu0xxx", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8c16, "HP Spectre x360 2-in-1 Laptop 16-aa0xxx", ALC245_FIXUP_HP_SPECTRE_X360_16_AA0XXX),
-- 
2.53.0


