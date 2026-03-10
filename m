Return-Path: <stable+bounces-224195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CoTGwwAsGmmdwIAu9opvQ
	(envelope-from <stable+bounces-224195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E666424AB69
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D79C130C5536
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AACF389DEF;
	Tue, 10 Mar 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFuuE5MU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5143806B8;
	Tue, 10 Mar 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141650; cv=none; b=g6z184ApJFg2YAvXn67vKF+Cu/N/3p467S6RLbmd3vpXlg4+ppMP416YkJmiq2FoCjKalHhNJ+n9pUYsAKqBRl5qEC2gPdjE4hIvrK9lFRJxE+6N7s0WlKqtlg0huZket6MrUwreVdXNf/WN1LaV7Y3RCe5aTXeDON1kIXEmEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141650; c=relaxed/simple;
	bh=6BvZz4rvdoYkSfDufJBlQ4SYaJIQB5EtcbgTrH96NEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNKzFSR73MQ9WJ/ugKkRiAXtR1ELeu4jZXfhanAPmWHrN7Tzl//I9MNcjVQaJ7qnz3qbHzUaN7JorXs1yfed3cXRmVty8BMjY23WFH+kvCtALosF8++rvt5p/MxQ6fkpj8Sezhf7nislMOJiJcE9LrWjClv45SsS2PDHIYsNMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFuuE5MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830DBC2BC86;
	Tue, 10 Mar 2026 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141650;
	bh=6BvZz4rvdoYkSfDufJBlQ4SYaJIQB5EtcbgTrH96NEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFuuE5MUP17H5Dn8kf0lErj8C9uu92D5SkD+5o3I51DPHFilAIxBbI3jNqFxikdzb
	 eSwgjMQoZwWR170UKY/dJ8Fr//bNoANv/amaysZ449w3By6yUfkwZWYVdfhTNotqVn
	 WSpS1dTWcS/QGQb4jjRDPQvxuaSSYdzq1FlUpJhHu0eaXgNJu2Z8uo3rnlv64arcnu
	 5y1Q58V5KuxXz+7MfeowIFfGZHjgUJeTltL1migzvzv9qbAdp4oW+lkQf37fddDNT+
	 T+4Zxo1qmZbqsSqdqossimNPyhrdtrYXpmaNsdF+MVEntLX0x+X2r7b92PCSbzjqPb
	 5DinKsdRMjxqQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 016/314] ALSA: usb-audio: Add QUIRK_FLAG_SKIP_IFACE_SETUP
Date: Tue, 10 Mar 2026 07:14:35 -0400
Message-ID: <86b64692c75cb939b01d4c9deeecfb76a5a71767.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E666424AB69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224195-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: "Geoffrey D. Bennett" <g@b4.vu>

[ Upstream commit 38c322068a26a01d7ff64da92179e68cdde9860b ]

Add a quirk flag to skip the usb_set_interface(),
snd_usb_init_pitch(), and snd_usb_init_sample_rate() calls in
__snd_usb_parse_audio_interface(). These are redundant with
snd_usb_endpoint_prepare() at stream-open time.

Enable the quirk for Focusrite devices, as init_sample_rate(rate_max)
sets 192kHz during probing, which disables the internal mixer and Air
and Safe modes.

Fixes: 16f1f838442d ("Revert "ALSA: usb-audio: Drop superfluous interface setup at parsing"")
Signed-off-by: Geoffrey D. Bennett <g@b4.vu>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/65a7909b15f9feb76c2a6f4f8814c240ddc50737.1771594828.git.g@b4.vu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks.c   | 3 ++-
 sound/usb/stream.c   | 3 +++
 sound/usb/usbaudio.h | 6 ++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ea5de072c36a1..c411005cd4d87 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2421,7 +2421,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	VENDOR_FLG(0x07fd, /* MOTU */
 		   QUIRK_FLAG_VALIDATE_RATES),
 	VENDOR_FLG(0x1235, /* Focusrite Novation */
-		   0),
+		   QUIRK_FLAG_SKIP_IFACE_SETUP),
 	VENDOR_FLG(0x1511, /* AURALiC */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x152a, /* Thesycon devices */
@@ -2503,6 +2503,7 @@ static const char *const snd_usb_audio_quirk_flag_names[] = {
 	QUIRK_STRING_ENTRY(MIC_RES_384),
 	QUIRK_STRING_ENTRY(MIXER_PLAYBACK_MIN_MUTE),
 	QUIRK_STRING_ENTRY(MIXER_CAPTURE_MIN_MUTE),
+	QUIRK_STRING_ENTRY(SKIP_IFACE_SETUP),
 	NULL
 };
 
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 5c235a5ba7e1b..3b2526964e4b4 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1261,6 +1261,9 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 			set_iface_first = true;
 
 		/* try to set the interface... */
+		if (chip->quirk_flags & QUIRK_FLAG_SKIP_IFACE_SETUP)
+			continue;
+
 		usb_set_interface(chip->dev, iface_no, 0);
 		if (set_iface_first)
 			usb_set_interface(chip->dev, iface_no, altno);
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 79978cae9799c..085530cf62d92 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -224,6 +224,10 @@ extern bool snd_usb_skip_validation;
  *  playback value represents muted state instead of minimum audible volume
  * QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE
  *  Similar to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE, but for capture streams
+ * QUIRK_FLAG_SKIP_IFACE_SETUP
+ *  Skip the probe-time interface setup (usb_set_interface,
+ *  init_pitch, init_sample_rate); redundant with
+ *  snd_usb_endpoint_prepare() at stream-open time
  */
 
 enum {
@@ -253,6 +257,7 @@ enum {
 	QUIRK_TYPE_MIC_RES_384			= 23,
 	QUIRK_TYPE_MIXER_PLAYBACK_MIN_MUTE	= 24,
 	QUIRK_TYPE_MIXER_CAPTURE_MIN_MUTE	= 25,
+	QUIRK_TYPE_SKIP_IFACE_SETUP		= 26,
 /* Please also edit snd_usb_audio_quirk_flag_names */
 };
 
@@ -284,5 +289,6 @@ enum {
 #define QUIRK_FLAG_MIC_RES_384			QUIRK_FLAG(MIC_RES_384)
 #define QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE	QUIRK_FLAG(MIXER_PLAYBACK_MIN_MUTE)
 #define QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE	QUIRK_FLAG(MIXER_CAPTURE_MIN_MUTE)
+#define QUIRK_FLAG_SKIP_IFACE_SETUP		QUIRK_FLAG(SKIP_IFACE_SETUP)
 
 #endif /* __USBAUDIO_H */
-- 
2.51.0


