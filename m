Return-Path: <stable+bounces-220507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCPZI1RMo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:13:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A05D91C807A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B6823244CA8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233EF3CA76B;
	Sat, 28 Feb 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjKEaMkm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAC3CA763;
	Sat, 28 Feb 2026 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300391; cv=none; b=iIZXVYaWhIs7+debpk+PVJUkYIx+95IJn2acr7REtJma8JpTBXbqlbrlEO6B+ByzP5Zql/2/S9DCXJ7nMRZK0FNvGJ28/baXZEAVogSYCl9/NNfcEM+MkXiS4j5W9cFK12QFpyKMpiYy+Vy9HbtjXrMonqO8HspwM/ErZHIn8E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300391; c=relaxed/simple;
	bh=A0DZ+VURr0w625Y0aRbinDsfvZTdhyTk4iXPX+wyYu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKt0bYOTQf7mM8mfmfZZUZHmSmhKkb1oMW+F1Xqr+fLoQBGshqmEFP6KAzlNUy7LGd3QB2xX0qShXOxNEjmAEMXGHN9b+7Nrt7zTAEfQ0Bg7nXmjCVigS9BUfpsa5gHHcaZYyMiIwGBr7LOQIUm49bIiemV104+Low9cPzo50Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjKEaMkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E41C116D0;
	Sat, 28 Feb 2026 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300391;
	bh=A0DZ+VURr0w625Y0aRbinDsfvZTdhyTk4iXPX+wyYu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjKEaMkmrMdPe1VWrWgf9KDZBCKm47rmI3vIG3e6DufrGrOHFxjOsUh3FdLAMhAJE
	 bnuW3fCGz0rQ3zOm3Nr/vfnHMqcI7g5TefGgabBc/m3+pQZuVoe7Re+3ycikyLWadG
	 XjElkNfN5MDC2a7waz5a4FAd0EVTFNh0bb/r5A4bZD0OgoJiZc39vUZIsz4FQu8NnJ
	 7TxMoTm2q8aBvrOJa5xA8xC7bfR1QY6S/nV6mbEhqf1/XQIldfsTSo+QinttbDQwSz
	 5sRfEFrEYpVWOLUO5VJnigfRcR+kdqwoaOwLNJ/EnYD6gA1vdTZOVDpPCOf0UZxIa3
	 ymEZavTuiOUlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erik Sanjaya <sirreidlos@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 428/844] ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14 UX3405MA
Date: Sat, 28 Feb 2026 12:25:41 -0500
Message-ID: <20260228173244.1509663-429-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220507-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,suse.de:email]
X-Rspamd-Queue-Id: A05D91C807A
X-Rspamd-Action: no action

From: Erik Sanjaya <sirreidlos@gmail.com>

[ Upstream commit 91062e119b4eafde553c894ca072cd615a6dae2e ]

The ASUS Zenbook 14 UX3405MA uses an ALC294 codec with CS35L41
amplifiers over SPI. The existing quirk for this model only configured
the amplifiers, leaving the headset microphone on the combo jack
non-functional.

Introduce a new fixup that configures pin 0x19 as headset mic input
and chains to ALC245_FIXUP_CS35L41_SPI_2 to preserve speaker
functionality.

Similar to the fix done for the UM3406HA in commit 018f659753fd
("ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14").

Signed-off-by: Erik Sanjaya <sirreidlos@gmail.com>
Link: https://patch.msgid.link/20260217102112.20651-1-sirreidlos@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index c11312aa5ca76..36053042ca772 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3886,6 +3886,7 @@ enum {
 	ALC294_FIXUP_ASUS_MIC,
 	ALC294_FIXUP_ASUS_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_I2C_HEADSET_MIC,
+	ALC294_FIXUP_ASUS_SPI_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_SPK,
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
@@ -5236,6 +5237,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC287_FIXUP_CS35L41_I2C_2
 	},
+	[ALC294_FIXUP_ASUS_SPI_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x04a11020 }, /* use as headset mic */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC245_FIXUP_CS35L41_SPI_2
+	},
 	[ALC294_FIXUP_ASUS_SPK] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -7189,7 +7199,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1a63, "ASUS UX3405MA", ALC294_FIXUP_ASUS_SPI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a83, "ASUS UM5302LA", ALC294_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1a8e, "ASUS G712LWS", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x1043, 0x1a8f, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
-- 
2.51.0


