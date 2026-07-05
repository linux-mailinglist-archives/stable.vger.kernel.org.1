Return-Path: <stable+bounces-272070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rJ6/AmZnSmoSCgEAu9opvQ
	(envelope-from <stable+bounces-272070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:17:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF7770A462
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:17:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=callumwong.com header.s=tm32yydslvviquw2x2q4ycbntmmm3paz header.b=ghake0G3;
	dkim=pass header.d=amazonses.com header.s=ulrbq2zjesb42hdt6rpnifgor3epinsy header.b=LJDnW+ZE;
	dmarc=pass (policy=none) header.from=callumwong.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272070-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272070-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09863300158D
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71994381EA7;
	Sun,  5 Jul 2026 14:17:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from b232-12.smtp-out.ap-southeast-2.amazonses.com (b232-12.smtp-out.ap-southeast-2.amazonses.com [69.169.232.12])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F037A48D
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:17:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783261024; cv=none; b=f8knwflhijv1dm6OnUPVyk5oMbWsLRwDVqBHBNKsySCyJBaSBrBxqgb66Jy0kByZ6qReovNaHxnvc36hDOmO7k3IVSK2D1WJVqNsmIDayHRdNsBy3nAXcYJw4rkXZ8liKSVmpJSbfLrvwzAdrW8weEpe1ur8zCawDOmHBnBpBQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783261024; c=relaxed/simple;
	bh=DD7/7mBFojVAb1s4AG49ZXVXz2Ddgt86NIiBgUi2IJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdnKa0YAHwuw/+Xf92Wm3d3VB4kRlsyn/bntMDWLBDPPRniAhqTqqeCLZfaosUo+kbYCHq7yZMsKR+VjFXNal+HiJBT3OnjXxWdVJnHUI+/2a/AMBMBtv9PyOMrRGyUDUjq5+QULPT+Y8cZTkq9/rMVBa7gPiteIG2PKLMm5yN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=callumwong.com; spf=pass smtp.mailfrom=bounce.callumwong.com; dkim=pass (2048-bit key) header.d=callumwong.com header.i=@callumwong.com header.b=ghake0G3; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=LJDnW+ZE; arc=none smtp.client-ip=69.169.232.12
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=tm32yydslvviquw2x2q4ycbntmmm3paz; d=callumwong.com; t=1783261021;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DD7/7mBFojVAb1s4AG49ZXVXz2Ddgt86NIiBgUi2IJE=;
	b=ghake0G3Ivo5nPV9pISjRWFy8FUnbaiAE1icAucuAbThpyjn0/FVVLVgG+wDRuWU
	3i/qX5OaY/e0kgrm7S59y60bWn/RO3XERWDNp1pK9Moxluih1Ld07s/qEy5zkKMGnci
	0lj6jZ0kl963Zvfm5S5RCY1Iq01oP36UoaGXHcrJlyQytwn+4Z87ITzVm3LhBj9hR+T
	FYbMIprwmkoQbg7R0BbhWvIYLgnfH1Sks5qqBdSZP7+794U41JJjs03R8Q8vn8tL6Me
	7wSB0SzNRkVOp8rFKW78RbKcVL3qpixYWs05FTcvW199XT2fjXzQ684YzC7xDu01osZ
	/rQP3A99ew==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ulrbq2zjesb42hdt6rpnifgor3epinsy; d=amazonses.com; t=1783261021;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=DD7/7mBFojVAb1s4AG49ZXVXz2Ddgt86NIiBgUi2IJE=;
	b=LJDnW+ZEf7fUy3e7vaCBXCnU1Bgp0fFpSduZPRxdvDQoBIeoZNQ1hC0XNVt4UnfG
	8XAvOd34aYf5C5MrMNYqKaAH0wpP74V9CMAC6DQD9avvL5tHChcEDEcDQVhBlpvGWMw
	hVIW3yzS6i7kC4aSQ9Ar3ZDGe02dujX41V0d6XOU=
From: Callum Wong <mail@callumwong.com>
To: mail@callumwong.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook 7 Laptop 14-fr0xxx
Date: Sun, 5 Jul 2026 14:17:01 +0000
Message-ID: <0108019f32a3c3a7-f13735f0-d96e-4194-8ed0-11c3d57faab7-000000@ap-southeast-2.amazonses.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705141657.180320-1-mail@callumwong.com>
References: <20260705141657.180320-1-mail@callumwong.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.ap-southeast-2.Bo07if0thBjjxfhnG0PllidpkDb4AFgWjQ4XZlpgJDk=:AmazonSES
X-SES-Outgoing: 2026.07.05-69.169.232.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[callumwong.com,none];
	R_DKIM_ALLOW(-0.20)[callumwong.com:s=tm32yydslvviquw2x2q4ycbntmmm3paz,amazonses.com:s=ulrbq2zjesb42hdt6rpnifgor3epinsy];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272070-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@callumwong.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mail@callumwong.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[callumwong.com:+,amazonses.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@callumwong.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amazonses.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ap-southeast-2.amazonses.com:mid,callumwong.com:from_mime,callumwong.com:email,callumwong.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDF7770A462

The HP OmniBook 7 Laptop 14-fr0xxx (SSID 103c:8e3b) is already handled by
ALC287_FIXUP_CS35L41_I2C_2, which binds its two CS35L41 amplifiers but
does not enable the keyboard mute LEDs. On this machine the F6
speaker-mute LED is driven via the ALC245 COEF register and the F9
mic-mute LED via a codec GPIO, the same as
ALC245_FIXUP_HP_X360_MUTE_LEDS.

Add a fixup that binds the amplifiers and chains that mute-LED path, and
point the 8e3b quirk at it, so both LEDs work in addition to the
speakers.

Fixes: 7150d57c370f ("ALSA: hda/realtek: Add support for HP Agusta using CS35L41 HDA")
Cc: stable@vger.kernel.org
Signed-off-by: Callum Wong <mail@callumwong.com>
---
 sound/hda/codecs/realtek/alc269.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 9ce143598b66..ec82e665a3a5 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4170,6 +4170,7 @@ enum {
 	ALC245_FIXUP_BASS_HP_DAC,
 	ALC245_FIXUP_ACER_MICMUTE_LED,
 	ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED,
+	ALC245_FIXUP_HP_OMNIBOOK_7_14_FR0XXX,
 	ALC236_FIXUP_HP_DMIC,
 	ALC256_FIXUP_HONOR_MRB_XXX_M1020_AUDIO,
 	ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX,
@@ -6745,6 +6746,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC287_FIXUP_CS35L41_I2C_2,
 	},
+	[ALC245_FIXUP_HP_OMNIBOOK_7_14_FR0XXX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_X360_MUTE_LEDS,
+	},
 	[ALC236_FIXUP_HP_DMIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7318,7 +7325,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e36, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e37, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e3a, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8e3b, "HP Agusta", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e3b, "HP OmniBook 7 Laptop 14-fr0xxx", ALC245_FIXUP_HP_OMNIBOOK_7_14_FR0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8e60, "HP OmniBook 7 Laptop 16-bh0xxx", ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e61, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e62, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.54.0


