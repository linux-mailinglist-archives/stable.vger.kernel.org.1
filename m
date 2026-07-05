Return-Path: <stable+bounces-272076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f7hpFiZqSmqwCgEAu9opvQ
	(envelope-from <stable+bounces-272076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:28:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF370A4C4
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:28:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=callumwong.com header.s=tm32yydslvviquw2x2q4ycbntmmm3paz header.b=AskJC0mg;
	dkim=pass header.d=amazonses.com header.s=ulrbq2zjesb42hdt6rpnifgor3epinsy header.b=UMXVTPxb;
	dmarc=pass (policy=none) header.from=callumwong.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272076-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272076-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9E383023FBB
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525E238551D;
	Sun,  5 Jul 2026 14:27:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from b232-9.smtp-out.ap-southeast-2.amazonses.com (b232-9.smtp-out.ap-southeast-2.amazonses.com [69.169.232.9])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58783384CF7;
	Sun,  5 Jul 2026 14:27:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783261676; cv=none; b=sbuPUKZTEf9i9ObBxLwGyb0USTnO76ok8ppZMIoHuRfLcxkOIQryUlb8yWKGIN0RhrqkzyAvDAjASMCw7SG/WIV9+F8NSQjkgetWV4NA/guLODPCVFzVcUvKFbIZJSbdGZrMZyaIjeyPB/oKQieVeehCqrFOmhTouimwezlJWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783261676; c=relaxed/simple;
	bh=DD7/7mBFojVAb1s4AG49ZXVXz2Ddgt86NIiBgUi2IJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kS/84XsSOrbkuneu6Phcau5YapRgNuIYdQR/fYMD6lcRiGexk3O1c2m2hhOLvTJn8YSPI292lUUpzBU7IV0uGpCnm2DWntoxNAJNHHG208pqsiI8Mtlju/lo/1ndSfWVmUFMcJQOswA0ri7lJT2icTiOGJK34N4cnmV6/dYst9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=callumwong.com; spf=pass smtp.mailfrom=bounce.callumwong.com; dkim=pass (2048-bit key) header.d=callumwong.com header.i=@callumwong.com header.b=AskJC0mg; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=UMXVTPxb; arc=none smtp.client-ip=69.169.232.9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=tm32yydslvviquw2x2q4ycbntmmm3paz; d=callumwong.com; t=1783261672;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DD7/7mBFojVAb1s4AG49ZXVXz2Ddgt86NIiBgUi2IJE=;
	b=AskJC0mgEl5/QXE8XFGhbm8uxnu6pjGcIIErNl5nM/7Np+WBlObgifImQ5elIHAZ
	f/pDFpVxYNdj/38vN9vpeX/gkA9eIdRiRBdV65vBMGhAfgF/ZasaCVkvirWAKkOyswF
	x0gUA1y673pkuHouD4hXSBGlPAbSvbvn8lCgbhaVPuTjxft3oo5WzEb/+Evz2cO1LVl
	eWEUS0qcLYmtfpxAUJDr7XPa1oKb9T0ScR1oN6UJxAbk36ALcpDuCnClwIvpBp44v6d
	SvOmLxSAn8ajVKjQ+G8DkxDyZ+/hPmWAljxjvwwpnqxt+zdJu4DG/JnW+kU1RzwSvL5
	Nyj6BAcdwg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ulrbq2zjesb42hdt6rpnifgor3epinsy; d=amazonses.com; t=1783261672;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=DD7/7mBFojVAb1s4AG49ZXVXz2Ddgt86NIiBgUi2IJE=;
	b=UMXVTPxbW88f2KYrNAt41i5Fuyw59k54iO2MSP4C3JL33qQIQi8mnZUe1+3i/pJS
	eaWpJiTQCzJjxEQFCr81GNrr7ZRpiSEzsyTmSwleP4uLItkdIGb5nm+3gQtb/CexVvV
	zBEVOzjS8T5pNioUWb0lbI2CMPxXTT/FHd3TRzOY=
From: Callum Wong <mail@callumwong.com>
To: tiwai@suse.com, perex@perex.cz
Cc: linux-sound@vger.kernel.org, sbinding@opensource.cirrus.com, 
	patches@opensource.cirrus.com, rf@opensource.cirrus.com, 
	david.rhodes@cirrus.com, linux-kernel@vger.kernel.org, 
	Callum Wong <mail@callumwong.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook 7 Laptop 14-fr0xxx
Date: Sun, 5 Jul 2026 14:27:52 +0000
Message-ID: <0108019f32adb483-2c606373-6a9f-483c-ba13-c413bc432170-000000@ap-southeast-2.amazonses.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705142535.186028-1-mail@callumwong.com>
References: <20260705142535.186028-1-mail@callumwong.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.ap-southeast-2.Bo07if0thBjjxfhnG0PllidpkDb4AFgWjQ4XZlpgJDk=:AmazonSES
X-SES-Outgoing: 2026.07.05-69.169.232.9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[callumwong.com,none];
	R_DKIM_ALLOW(-0.20)[callumwong.com:s=tm32yydslvviquw2x2q4ycbntmmm3paz,amazonses.com:s=ulrbq2zjesb42hdt6rpnifgor3epinsy];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272076-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tiwai@suse.com,m:perex@perex.cz,m:linux-sound@vger.kernel.org,m:sbinding@opensource.cirrus.com,m:patches@opensource.cirrus.com,m:rf@opensource.cirrus.com,m:david.rhodes@cirrus.com,m:linux-kernel@vger.kernel.org,m:mail@callumwong.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[mail@callumwong.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[callumwong.com:+,amazonses.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@callumwong.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ap-southeast-2.amazonses.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazonses.com:dkim,callumwong.com:from_mime,callumwong.com:email,callumwong.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0FF370A4C4

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


