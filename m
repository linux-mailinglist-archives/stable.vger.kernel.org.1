Return-Path: <stable+bounces-223245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OiSE66nqWlSBwEAu9opvQ
	(envelope-from <stable+bounces-223245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:56:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E02214F21
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B62A8308066A
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C443D34BE;
	Thu,  5 Mar 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiQWkKX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6D3D6CC1;
	Thu,  5 Mar 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725051; cv=none; b=GlXKqriL/WOdinX+WlnsRefscn00DtvCQSeKGzW2A6c8RNcVhykoqCYhWBgEKBdxeIIAU5LYMPA8D5StfPwAIg4W2cG1ETEicBKsjW2eAa6izav8A+NnaRbP5MP+GFHz1vJG79OQla6dy9qW70YzbBYsSSovxa+yAgtocA/C/Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725051; c=relaxed/simple;
	bh=x2Bg0hYBPBF3e2SfXkcHi5npjg01hY2YeE54gT/+cp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnR9Jcilv4sTeNC+wZE+o8f4ex+KiWz+qzT0dSRLNckh9TcVLVeZahGg5tkHNi+0GcBh/dbErMUWJY4voZVpcvlc+J6Bz5siAX96vGgp+VQWb8KLB+2IWElK53tFXcUqN+5jODCmFHGi7woBIPVYYquL9jgodB+Rku1y3y1lhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiQWkKX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7605C116C6;
	Thu,  5 Mar 2026 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772725051;
	bh=x2Bg0hYBPBF3e2SfXkcHi5npjg01hY2YeE54gT/+cp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiQWkKX4ZZ/0dZ4m8j4ZAlIKoGSxLm2lmBGQgMgVyYvcw0oERb36aRI8XZzpW+bVV
	 6W2q13OKZSUzOfqZtbw+3wDXexCqKqLHCil9XDixvErA7LnB03MWcT3tUdBYhuFSmA
	 3g7VQeuBMloGeQPGCwb1yaezrclhjq8XFBD5J4VZAOtAdB8NiVWn9kO/+OP9HxKZ1Z
	 gDfs36buC9xilA+wHbKi+icm+t2rdaAPVW41snTNl7bfjzdAiuGspxFeV2XCvSsYdM
	 mIi8KQ5o/NCoJohxGMkXUoOWc+6xt09hdpnG2tqsEvXjBPw9adbm2hIKBx3yKYk/mU
	 AfZho62sTmHNg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] ALSA: hda/realtek: Fix speaker pop on Star Labs StarFighter
Date: Thu,  5 Mar 2026 10:37:01 -0500
Message-ID: <20260305153704.106918-18-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305153704.106918-1-sashal@kernel.org>
References: <20260305153704.106918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52E02214F21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223245-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,suse.de:email,starlabs.systems:email,suse.com:email]
X-Rspamd-Action: no action

From: Sean Rhodes <sean@starlabs.systems>

[ Upstream commit 1cb3c20688fc8380c9b365d03aea7e84faf6a9fd ]

On Star Labs StarFighter (Realtek ALC233/235), the internal speakers can
emit an audible pop when entering or leaving runtime suspend.

Mute the speaker output paths via snd_hda_gen_shutup_speakers() in the
Realtek shutup callback before the codec is powered down.

This is enough to avoid the pop without special EAPD handling.

Test results:
- runtime PM pop fixed
- still reaches D3 (PCI 0000:00:1f.3 power_state=D3hot)
- does not address pops on cold boot (G3 exit) or around display manager
  start/shutdown

journalctl -k (boot):
- snd_hda_codec_alc269 hdaudioC0D0: ALC233: picked fixup for PCI SSID
  7017:2014
- snd_hda_codec_alc269 hdaudioC0D0: autoconfig for ALC233: line_outs=1
  (0x1b/0x0/0x0/0x0/0x0) type:speaker

Suggested-by: Takashi Iwai <tiwai@suse.com>
Tested-by: Sean Rhodes <sean@starlabs.systems>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
Link: https://patch.msgid.link/4d5fb71b132bb283fd41c622b8413770b2065242.1771532060.git.sean@starlabs.systems
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### What the commit does
This adds an audio codec quirk (SND_PCI_QUIRK) for the Star Labs
StarFighter laptop (PCI SSID 0x7017:0x2014, Realtek ALC233/235). It
fixes an audible speaker pop when entering or leaving runtime suspend by
muting speaker output paths via `snd_hda_gen_shutup_speakers()` before
the codec powers down.

### Change breakdown
1. New shutup callback `starlabs_starfighter_shutup()` - calls existing
   `snd_hda_gen_shutup_speakers()` + 30ms delay
2. New fixup function `alc233_fixup_starlabs_starfighter()` - hooks the
   shutup callback during probe
3. New enum `ALC233_FIXUP_STARLABS_STARFIGHTER`
4. Fixup table entry and PCI SSID quirk entry (`0x7017, 0x2014`)
5. Model fixup string entry

### Classification: Hardware quirk (STRONG YES category)

This is a textbook audio codec quirk — one of the most commonly
backported types of changes to stable. It:
- Only activates for one specific PCI SSID (zero risk to other hardware)
- Uses existing, well-tested infrastructure
  (`snd_hda_gen_shutup_speakers()`, standard fixup mechanism)
- Fixes a real user-facing issue (audible speaker pop during runtime PM)
- Was suggested by the HDA subsystem maintainer (Takashi Iwai) and
  tested by the hardware vendor (Sean Rhodes @ Star Labs)

### Risk assessment: Very low
- Scope is strictly limited to one laptop model via PCI SSID matching
- No changes to shared code paths
- All new code uses established patterns seen in hundreds of similar
  fixups in this file
- The fixup mechanism (`HDA_FIXUP_FUNC` + `spec->shutup`) is a standard,
  well-tested pattern

### Stable criteria
- **Obviously correct**: Yes — standard quirk pattern, suggested by
  maintainer
- **Fixes real bug**: Yes — audible pop during runtime suspend
- **Small and contained**: Yes — ~25 new lines, all device-specific
- **No new features**: Correct — just a hardware workaround
- **Tested**: Yes — tested by hardware vendor, confirmed runtime PM
  still works (D3hot)

### Verification
- The commit uses `snd_hda_gen_shutup_speakers()` which is an existing
  function in the HDA generic layer — verified by the fact it's called
  without any new includes or declarations
- The fixup pattern (`HDA_FIXUP_FUNC` with `spec->shutup` assignment) is
  identical to patterns used by many other fixups in this same file
  (standard approach)
- Takashi Iwai (HDA subsystem maintainer) both suggested the approach
  and merged the patch — strong trust indicator
- The PCI SSID `0x7017:0x2014` is device-specific, limiting blast radius
  to exactly one laptop model
- The patch is self-contained with no dependencies on other commits —
  all additions are new enum values, table entries, and small functions
- "Tested-by: Sean Rhodes" from Star Labs confirms hardware validation

**YES**

 sound/hda/codecs/realtek/alc269.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 36053042ca772..9f64bb97c3f9a 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -1017,6 +1017,24 @@ static int alc269_resume(struct hda_codec *codec)
 	return 0;
 }
 
+#define STARLABS_STARFIGHTER_SHUTUP_DELAY_MS	30
+
+static void starlabs_starfighter_shutup(struct hda_codec *codec)
+{
+	if (snd_hda_gen_shutup_speakers(codec))
+		msleep(STARLABS_STARFIGHTER_SHUTUP_DELAY_MS);
+}
+
+static void alc233_fixup_starlabs_starfighter(struct hda_codec *codec,
+					      const struct hda_fixup *fix,
+					      int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->shutup = starlabs_starfighter_shutup;
+}
+
 static void alc269_fixup_pincfg_no_hp_to_lineout(struct hda_codec *codec,
 						 const struct hda_fixup *fix, int action)
 {
@@ -4040,6 +4058,7 @@ enum {
 	ALC245_FIXUP_CLEVO_NOISY_MIC,
 	ALC269_FIXUP_VAIO_VJFH52_MIC_NO_PRESENCE,
 	ALC233_FIXUP_MEDION_MTL_SPK,
+	ALC233_FIXUP_STARLABS_STARFIGHTER,
 	ALC294_FIXUP_BASS_SPEAKER_15,
 	ALC283_FIXUP_DELL_HP_RESUME,
 	ALC294_FIXUP_ASUS_CS35L41_SPI_2,
@@ -6499,6 +6518,10 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		},
 	},
+	[ALC233_FIXUP_STARLABS_STARFIGHTER] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc233_fixup_starlabs_starfighter,
+	},
 	[ALC294_FIXUP_BASS_SPEAKER_15] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc294_fixup_bass_speaker_15,
@@ -7651,6 +7674,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x2782, 0x4900, "MEDION E15443", ALC233_FIXUP_MEDION_MTL_SPK),
+	SND_PCI_QUIRK(0x7017, 0x2014, "Star Labs StarFighter", ALC233_FIXUP_STARLABS_STARFIGHTER),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
@@ -7747,6 +7771,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC298_FIXUP_TPT470_DOCK_FIX, .name = "tpt470-dock-fix"},
 	{.id = ALC298_FIXUP_TPT470_DOCK, .name = "tpt470-dock"},
 	{.id = ALC233_FIXUP_LENOVO_MULTI_CODECS, .name = "dual-codecs"},
+	{.id = ALC233_FIXUP_STARLABS_STARFIGHTER, .name = "starlabs-starfighter"},
 	{.id = ALC700_FIXUP_INTEL_REFERENCE, .name = "alc700-ref"},
 	{.id = ALC269_FIXUP_SONY_VAIO, .name = "vaio"},
 	{.id = ALC269_FIXUP_DELL_M101Z, .name = "dell-m101z"},
-- 
2.51.0


