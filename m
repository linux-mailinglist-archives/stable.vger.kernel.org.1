Return-Path: <stable+bounces-73843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD1970666
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25AE1C20F91
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 10:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92F14B978;
	Sun,  8 Sep 2024 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FH1fkahX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28D4DA14
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790396; cv=none; b=FiR8cKjsTfjsdJ6zuAh/eBWMorEG2O5uw/FhO4gzLX9xPP4Sv6r87caA4wwNiS1heT4FaAZXNT0aINC2PtCobYjOSQus7RTCNmwDGNEYUWhdMPyjojvkGhJGVcdM1DVZ78WvGnhH5RRxUKYT6wOwSFmTALdNozAceIgn3Aq5AyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790396; c=relaxed/simple;
	bh=HlsfQrdBuhtAuG0U+lSA/VApVVZ+wPra76XAQgmzFXA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qSGg69upuWCOhHnJso13lXVUvwxI2IsUizgB80d2PQEpIVSM6rHeW44pwwjMGpKlLmxlMiq5YHPfzotQEEYT3WsRomSa/ULzIRCWe7D0MVwDR6k5c47arLqf3l/ZoPVyoDLIiTV8Ae2N1BFRuZtSYB3mIZBDDkYrc+sjtoFYYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FH1fkahX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A524BC4CEC3;
	Sun,  8 Sep 2024 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725790396;
	bh=HlsfQrdBuhtAuG0U+lSA/VApVVZ+wPra76XAQgmzFXA=;
	h=Subject:To:Cc:From:Date:From;
	b=FH1fkahXlLNIgrL2OPi/2V/KTM3RkHXIcLHtK1Ysniv+Cj1fu+qm5o8jJFXB6DuT0
	 oLmhRGStgVRyrU+1l4bEc+6O0I+kRlhSE251XFCbdMJi/HEPVfamdwhjOAYWvgSUn4
	 P4IE3DUbFvCSz4n9zxgo49byxaUH3E+elcQDolBA=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: extend quirks for Clevo V5[46]0" failed to apply to 6.10-stable tree
To: marmarek@invisiblethingslab.com,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 12:13:13 +0200
Message-ID: <2024090812-ample-stowaway-5c06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 562755501d44cfbbe82703a62cb41502bd067bd1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090812-ample-stowaway-5c06@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

562755501d44 ("ALSA: hda/realtek: extend quirks for Clevo V5[46]0")
03c5c350e38d ("ALSA: hda/realtek: Add support for new HP G12 laptops")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 562755501d44cfbbe82703a62cb41502bd067bd1 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Date: Tue, 3 Sep 2024 14:49:31 +0200
Subject: [PATCH] ALSA: hda/realtek: extend quirks for Clevo V5[46]0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mic in those laptops suffers too high gain resulting in mostly (fan
or else) noise being recorded. In addition to the existing fixup about
mic detection, apply also limiting its boost. While at it, extend the
quirk to also V5[46]0TNE models, which have the same issue.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240903124939.6213-1-marmarek@invisiblethingslab.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ff62702a8226..fd7711d69823 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7638,6 +7638,7 @@ enum {
 	ALC287_FIXUP_LENOVO_14ARP8_LEGION_IAH7,
 	ALC287_FIXUP_LENOVO_SSID_17AA3820,
 	ALCXXX_FIXUP_CS35LXX,
+	ALC245_FIXUP_CLEVO_NOISY_MIC,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -9977,6 +9978,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35lxx_autodet_fixup,
 	},
+	[ALC245_FIXUP_CLEVO_NOISY_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -10626,7 +10633,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1558, 0xa763, "Clevo V54x_6x_TU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa741, "Clevo V54x_6x_TNE", ALC245_FIXUP_CLEVO_NOISY_MIC),
+	SND_PCI_QUIRK(0x1558, 0xa763, "Clevo V54x_6x_TU", ALC245_FIXUP_CLEVO_NOISY_MIC),
 	SND_PCI_QUIRK(0x1558, 0xb018, "Clevo NP50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb019, "Clevo NH77D[BE]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb022, "Clevo NH77D[DC][QW]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),


