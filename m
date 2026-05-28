Return-Path: <stable+bounces-254775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOhpD4IAGGrUYwgAu9opvQ
	(envelope-from <stable+bounces-254775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:44:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C65EEDD5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4697F305927A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7FD37DE9E;
	Thu, 28 May 2026 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VOBUVRBc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862938229D
	for <stable@vger.kernel.org>; Thu, 28 May 2026 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957537; cv=none; b=jc2qa7/y7Ev4GxRJlJaXmiagWdX4NjiL1QRDVwBwC9ad9yc2GdVz9hTGCoC8g1PFDKd1TpZcB7oRqxRJAXkSmNBpXAvCw34pv/LCQevzW78FvDqjeqiwfEG7DNl20jDcErmxJZi/e7nMqXqbGE84j1tIKFIVI2DQO2Tk5A2B9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957537; c=relaxed/simple;
	bh=osPM64v6xBl/HiBIe5vZcklJrGAqnWM6MUo8qiwyKjA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YetLI8FARVeQLd0WWgoNytKdm8qisim0Zoo4m6EYtH0NfzY+3D3lI/jhph5AJQi4PZMB1S5Um++z2bJU8Ga5VCiu/JntkSuMDdC5XqgzbWnohq2aeJZNlmfpJryrWnT+kjKqRaZwDY+7M/AdVBkVkdB28ceN8ZZ3c692111OFfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VOBUVRBc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7F01F000E9;
	Thu, 28 May 2026 08:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779957535;
	bh=flW27IAaMN+k7wDMXHWUG+RqCWYzcxkF7JA1rD66oUQ=;
	h=Subject:To:Cc:From:Date;
	b=VOBUVRBcOIUF0IUUAVNEM3lokQzB9XLMe58DQ5VVM0fqjV9OhxM36SQVXtUI8hK8x
	 3Dz/6vUzeC1Rx3POSJEr7n+yqdIdjjATL476BELmCP6IZG68YcQP4Am7VLOOFdxlDz
	 1zZzkxcBppLEeLidTjkcEHRIWloNQpNG34382F0c=
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP 16" failed to apply to 7.0-stable tree
To: zhangheng@kylinos.cn,stable@vger.kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 10:38:01 +0200
Message-ID: <2026052801-harmonize-cosmos-d0b2@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254775-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 459C65EEDD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 9e5fb6098d21e1f9be9982b46c3e5b8329d4e7d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052801-harmonize-cosmos-d0b2@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e5fb6098d21e1f9be9982b46c3e5b8329d4e7d2 Mon Sep 17 00:00:00 2001
From: Zhang Heng <zhangheng@kylinos.cn>
Date: Tue, 19 May 2026 09:55:35 +0800
Subject: [PATCH] ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP 16
 Piston OmniBook X

The ALC245 sound card on this machine requires the quirk
`ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX` to fix the mic and mute LED.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221509
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20260519015535.891156-1-zhangheng@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index d86d4f5f9ca6..be1bbde8be5a 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7231,7 +7231,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8da0, "HP 16 Clipper OmniBook 7(X360)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da1, "HP 16 Clipper OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8dc9, "HP Laptop 15-fc0xxx", ALC236_FIXUP_HP_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8dd4, "HP EliteStudio 8 AIO", ALC274_FIXUP_HP_AIO_BIND_DACS),
 	SND_PCI_QUIRK(0x103c, 0x8dd7, "HP Laptop 15-fd0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),


