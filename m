Return-Path: <stable+bounces-225829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN1AHIU9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:39:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E66642A90CA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1A5A30DB80D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AAC3B8BD0;
	Tue, 17 Mar 2026 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWZ6SAyx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A6D3B8938;
	Tue, 17 Mar 2026 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747191; cv=none; b=c9cVF75widBOfTp+R1oPbrVRHyb1sW9huTl58zfOo/YeZ7oKu8dD0+qN4R16Tts6IMxOdJ0sMytPpkor5z8dhV+fzS3tNJE1HPGZU3qCxtxIqRnTn1ySWvCYTFW5+hvToqD2i+0UmhrxHb06/G+X68bGey2Hbw923zikMypvMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747191; c=relaxed/simple;
	bh=JEJzMC7JKr5FmW+9VFixyXgn97ExOON2VornUdb+rH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=St3pvdQD2Kf0cbQIEHCbFgvkkvlTgkvmxQ4z3oTM+VrRPz7B1fuLDHzYCSfs/vPSrO+PxK7IlCwgQ5+2/vK46lsl8ebl8MwX3WDjfOtlnugjo0rnmceAuv04MdzQ4w1906slQe/6ADhEtFNx0hWjquh59txxZBErDgYiVuoDHZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWZ6SAyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77846C2BCAF;
	Tue, 17 Mar 2026 11:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773747191;
	bh=JEJzMC7JKr5FmW+9VFixyXgn97ExOON2VornUdb+rH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cWZ6SAyxtlzmMVWmSawBqX4D8cCGzZiBDLcuzII2okY1H0aa9czXZrsO3nWQ748df
	 1pZcu3f0k9f6v3bm0QGR0gLwA+/yE+3+lDGC41Z4gM59QpHrrvnyepb5UKjv3no65O
	 80cVdDr58EjoRnPtuoSfrIgbx8GTZwUcJA/MU0L17eyN4eX2rGCHY0dEZkHIJH0TEl
	 4xCANIVAq/PcvxNjcg2HDR3LhRHhM9eT16sqg2la+vmxOlmu/soDBhjqIBDhq2tFuw
	 g/MwFGIEuH2taP46RWJg8l+cbWaHhr9KIWLgNmPrjx2ymymUH4t6444oPM2/IULN9O
	 5amUl7DnRtZ/Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Uzair Mughal <contact@uzair.is-a.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] ALSA: hda/realtek: Add headset jack quirk for Thinkpad X390
Date: Tue, 17 Mar 2026 07:32:47 -0400
Message-ID: <20260317113249.117771-16-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317113249.117771-1-sashal@kernel.org>
References: <20260317113249.117771-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225829-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,msgid.link:url,uzair.is-a.dev:email]
X-Rspamd-Queue-Id: E66642A90CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Uzair Mughal <contact@uzair.is-a.dev>

[ Upstream commit 542127f6528ca7cc3cf61e1651d6ccb58495f953 ]

The Lenovo ThinkPad X390 (ALC257 codec, subsystem ID 0x17aa2288)
does not report headset button press events. Headphone insertion is
detected (SW_HEADPHONE_INSERT), but pressing the inline microphone
button on a headset produces no input events.

Add a SND_PCI_QUIRK entry that maps this subsystem ID to
ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK, which enables
headset jack button detection through alc_fixup_headset_jack()
and ThinkPad ACPI integration. This is the same fixup used by
similar ThinkPad models (P1 Gen 3, X1 Extreme Gen 3).

Signed-off-by: Uzair Mughal <contact@uzair.is-a.dev>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260307012906.20093-1-contact@uzair.is-a.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### What the commit does

This is a single-line addition of a `SND_PCI_QUIRK` entry for the Lenovo
ThinkPad X390 (subsystem ID `0x17aa:0x2288`) using the ALC257 codec. It
maps this device to the existing fixup
`ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK`, which enables headset
jack button detection.

### Bug being fixed

Headset button press events are not reported on this laptop. While
headphone insertion is detected, pressing the inline microphone button
on a headset produces no input events — a functional defect for users.

### Stable kernel criteria

- **Obviously correct**: Yes — it's a one-line quirk table entry using
  the same fixup already applied to similar ThinkPads (P1 Gen 3 at
  `0x22c1`, X1 Extreme Gen 3 at `0x22c2`).
- **Fixes a real bug**: Yes — headset buttons don't work without this
  quirk.
- **Small and contained**: Yes — one line added to a quirk table. Zero
  risk of regression on other hardware.
- **No new features**: Correct — it uses an existing fixup on existing
  driver infrastructure.
- **Hardware quirk exception**: This falls squarely into the "audio
  codec quirks" category explicitly listed as appropriate for stable
  backporting.

### Risk assessment

**Minimal risk.** The change only affects the specific subsystem ID
`0x17aa:0x2288`. It cannot affect any other hardware. The fixup chain it
invokes (`ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK`) is already
proven on multiple ThinkPad models in the same quirk table.

### Verification

- The diff shows exactly one line added in sorted order within the
  existing `alc269_fixup_tbl[]` quirk table in
  `sound/hda/codecs/realtek/alc269.c`.
- The same fixup `ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK` is
  used by entries at `0x22c1` (P1 Gen 3) and `0x22c2` (X1 Extreme Gen
  3), both visible in the diff context — confirmed directly from the
  patch.
- The commit is signed off by Takashi Iwai (ALSA/HDA subsystem
  maintainer), confirming maintainer review and acceptance.
- The vendor ID `0x17aa` is Lenovo, consistent with ThinkPad X390.

This is a textbook stable-worthy hardware quirk addition: one line, zero
regression risk, fixes a real hardware defect for ThinkPad X390 users.

**YES**

 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 13d14c86569f9..f213f8792b01f 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7471,6 +7471,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x17aa, 0x2288, "Thinkpad X390", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22be, "Thinkpad X1 Carbon 8th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x22c1, "Thinkpad P1 Gen 3", ALC285_FIXUP_THINKPAD_NO_BASS_SPK_HEADSET_JACK),
-- 
2.51.0


