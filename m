Return-Path: <stable+bounces-220314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCu+E+Ywo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B481C5982
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D621D34220E7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A32390F70;
	Sat, 28 Feb 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQgHsnqm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385F390F67;
	Sat, 28 Feb 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300216; cv=none; b=l2TPH0rIcLw3QvVJ8mi0gxG3ZAry5Qay3+punE88l9lSiKUbdNTs78ILUPq3reJHYN6DgRwJ0vhuperDvh/HeNimBhMUIPkrZLc56Xva8jG4wSiHLnHF55hNm9nPI1MA+r4TQAL3hkWxxZwhxbY/1t8/aYfNEwl/POJgUZsgOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300216; c=relaxed/simple;
	bh=t3tLolziVK0PAhfyxAfCkWSKHKRla6C4pF3dA1JR8Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdJQxJlv5LhnsKQ0DRhxOyCZTOS9Sm6WR2MmUUgwp5ZDfvk+6bwevSRty45yBXaPRsu5duc36Jbv50nrNuSxJAugILp1hATusfoCFM5iw66A9sXjm2XTIitdapWKvq8u8+R3/RnSd9mV4r3bQ3QCOpw1BTRbTzbcqoyV0bqavYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQgHsnqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF80C19423;
	Sat, 28 Feb 2026 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300216;
	bh=t3tLolziVK0PAhfyxAfCkWSKHKRla6C4pF3dA1JR8Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQgHsnqmRFcnYpTv1bqdk8EIbLmyBZ0N34OQkZEnrbBu9D22nXbML67BjMocsXWks
	 QKf9RqzeN2REqX9j5yD/kSqBbNV8ZaykRkqu4uq6S4Ko5hC2+PkYQt7g8BWlEfaLUY
	 8gzfxAysHU5BKx/ekv5ovflkmmjzTW1N3TlM0D+8dd7chh/4WKxNR/LNJluN8pjXB3
	 TQxRvpainRKBNKdVWsygAwym5Git/XxghitF8Y93OQcL5ASh5azeufcFg58MyOcr+e
	 uRTfqNiu5snR4rD83VEVF2BQxWJ0cHgSWRvSzW5F3mUoeYz8FtFPHZt43K4s53JVrm
	 GxDHSieabAODw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 236/844] ALSA: hda/realtek: Add quirk for Minisforum V3 SE
Date: Sat, 28 Feb 2026 12:22:29 -0500
Message-ID: <20260228173244.1509663-237-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220314-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 60B481C5982
X-Rspamd-Action: no action

From: Samuel Dionne-Riel <samuel@dionne-riel.com>

[ Upstream commit e3474301824926ecce1d45f2ede7ecdda9a35840 ]

First, adding a generic quirk for Bass speaker DAC avoidance.

This pattern (re-routing the bass speakers off of a DAC without volume
control) seems common enough that having a "model" to match against and
quickly use to verify may be worthwhile.

The alc285_fixup_thinkpad_x1_gen7 routing was selected, amongst the
different options, as it should allow tuning the ratio between both
speaker set.

The routing was verified using `hda-verb`, and picking either 0x00 or
0x01. Either routing made the volume of the bass speakers controllable.

    hda-verb /dev/snd/hwC1D0 0x17 SET_CONNECT_SEL 0x01

This likely will apply for the Minisforum V3, though there isn't a lot
of information to confirm whether or not the identifiers are the same.

This was verified on the Minisforum V3 SE, and the root cause (the bass
speakers routing) was found out by using pink noise, and playing with
the mixers.

Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
Link: https://patch.msgid.link/20260203010132.1981419-2-samuel@dionne-riel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index b6fae275919c6..82219f03b212c 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4046,6 +4046,7 @@ enum {
 	ALC288_FIXUP_SURFACE_SWAP_DACS,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO,
 	ALC233_FIXUP_LENOVO_GPIO2_MIC_HOTKEY,
+	ALC245_FIXUP_BASS_HP_DAC,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6548,6 +6549,11 @@ static const struct hda_fixup alc269_fixups[] = {
                 .type = HDA_FIXUP_FUNC,
                 .v.func = alc233_fixup_lenovo_gpio2_mic_hotkey,
         },
+	[ALC245_FIXUP_BASS_HP_DAC] = {
+		.type = HDA_FIXUP_FUNC,
+		/* Borrow the DAC routing selected for those Thinkpads */
+		.v.func = alc285_fixup_thinkpad_x1_gen7,
+	},
 };
 
 static const struct hda_quirk alc269_fixup_tbl[] = {
@@ -7609,6 +7615,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1e39, 0xca14, "MEDION NM14LNL", ALC233_FIXUP_MEDION_MTL_SPK),
 	SND_PCI_QUIRK(0x1ee7, 0x2078, "HONOR BRB-X M1010", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1f4c, 0xe001, "Minisforum V3 (SE)", ALC245_FIXUP_BASS_HP_DAC),
 	SND_PCI_QUIRK(0x1f66, 0x0105, "Ayaneo Portable Game Player", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x2014, 0x800a, "Positivo ARN50", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2039, 0x0001, "Inspur S14-G1", ALC295_FIXUP_CHROME_BOOK),
@@ -7824,6 +7831,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
 	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
+	{.id = ALC245_FIXUP_BASS_HP_DAC, .name = "alc245-fixup-bass-hp-dac"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.51.0


