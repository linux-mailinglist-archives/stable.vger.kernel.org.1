Return-Path: <stable+bounces-249964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP1PLWXIDWor3QUAu9opvQ
	(envelope-from <stable+bounces-249964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:42:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A18158FE07
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B76B3021BCA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F13D891E;
	Wed, 20 May 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pNeUZBTl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EAB3DCD9D
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288007; cv=none; b=S0jAPow9n84lFbAtuuqOjfKUspmO2PZrCWH+y6F8dqhprmdE+iHoMJ8o+g6vO9QiDRRHLj3zoqz/IfzXcwY7yNNjs3TngoiMQrRZu87XQRa1fgEHMTYvslHsG75m5hBXzYDCjK6mGhrffMSa2wl3xFs1d9zsQSxCgcpwEtqOKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288007; c=relaxed/simple;
	bh=GKuCEq5SHYWHRp+u/41koagFV5MCpAAK0m4U7IGODSM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FPnF8/6x/4Gz+DjkFKLz892/YPu8j4FUxVnV36HbAalt7a+jVkDrnwHSUfyhj5lwW8Vw7NefplAIrZwmkVRwOOh91jTMAv9Nvc2G3dlpAfVzIHNG6hQ/K3WlQLhqpLMllqJUhcsRo/NsM4Dyxh3Zbmo5zpgYuhN+u69qUYxWJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNeUZBTl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05BE1F000E9;
	Wed, 20 May 2026 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288005;
	bh=Zm/2yY3HYTQwHCSEriH5gTjiOBuVdxi7NjxTazsvfJs=;
	h=Subject:To:Cc:From:Date;
	b=pNeUZBTllHYf77T8npIOfTnTzBrctKOG6I2RJq5bIypYaE66q1jl4JPy6Gkjxatr3
	 K5Kt3a1tWMb8jQLG4jRy+Moq86/U0F5X7x8itJlUTIki+FzhKbrBZKJTu7qUpQtPQg
	 1zHECVJu4JoyGNy3ErXH1/DGbs4DlSKgEuVgVnX8=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix Legion 7 16ITHG6 speaker amp binding" failed to apply to 6.18-stable tree
To: hadobedo@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:40:00 +0200
Message-ID: <2026052000-clinking-footsie-50af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249964-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,suse.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: 5A18158FE07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x dd074f04e04648d89d9d10ae9846cd057c97b385
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052000-clinking-footsie-50af@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd074f04e04648d89d9d10ae9846cd057c97b385 Mon Sep 17 00:00:00 2001
From: Nicholas Bonello <hadobedo@gmail.com>
Date: Fri, 8 May 2026 18:55:07 -0400
Subject: [PATCH] ALSA: hda/realtek: Fix Legion 7 16ITHG6 speaker amp binding

The Lenovo Legion 7 16ITHG6 uses codec SSID 17aa:3855, but its PCI
SSID is 17aa:3811.  The latter is now also used by the Legion S7 15IMH05
quirk, which is matched before codec SSID fallback and incorrectly
routes Legion 7 16ITHG6 machines to ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS.

That fixup does not bind the CLSA0101 CS35L41 companion amplifiers,
making the built-in speakers silent even though playback appears to be
active.

Add a codec SSID quirk for 17aa:3855 before the conflicting PCI SSID
quirk so that the Legion 7 16ITHG6 uses ALC287_FIXUP_LEGION_16ITHG6.
This restores CS35L41 firmware loading and binds both speaker
amplifiers.

Fixes: 67f4c61a73e9 ("ALSA: hda/realtek: Add quirk for Legion S7 15IMH")
Cc: stable@vger.kernel.org
Tested-by: Nicholas Bonello <hadobedo@gmail.com>
Assisted-by: Codex:GPT-5
Signed-off-by: Nicholas Bonello <hadobedo@gmail.com>
Link: https://patch.msgid.link/20260508225507.47667-1-hadobedo@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 55bb98e2e55a..4e2c8401c404 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7675,11 +7675,12 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
-	/* Yoga Pro 9 16IMH9 shares PCI SSID 17aa:3811 with Legion S7 15IMH05;
-	 * use codec SSID to distinguish them
+	/* Yoga Pro 9 16IMH9 and Legion 7 16ITHG6 share PCI SSID 17aa:3811
+	 * with Legion S7 15IMH05; use codec SSID to distinguish them
 	 */
 	HDA_CODEC_QUIRK(0x17aa, 0x38d5, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
 	HDA_CODEC_QUIRK(0x17aa, 0x38d6, "Lenovo Yoga Pro 9 16IMH9", ALC287_FIXUP_TAS2781_I2C),
+	HDA_CODEC_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3811, "Legion S7 15IMH05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),


