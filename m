Return-Path: <stable+bounces-251190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLrvL/EVDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:13:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF35994CD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 867B5324A5B1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF093D75C7;
	Wed, 20 May 2026 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rDuiuiri"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E94356748;
	Wed, 20 May 2026 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297334; cv=none; b=tLFnPL+6JXMg1NkNZvY9WVyvUsKBBxkZcMnAp+Q8134sYMCsA1MQ/eTEAqvL5XmGlKdefcr69A6+Y7AXoge9JFOspNZ296r7imw+ahSXgEXpdLJY0uk/VJOEJ70UmhA48zrTb0TXzihrJJE4RnQnlW1iMcuBwy+Pu0+v4UPsuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297334; c=relaxed/simple;
	bh=kJW4sIe7+VU7AzbTv4zSSUJbnBHP6xruPswCAFLGu3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtoPIjgMv4KSteN8XzP6yDnh1jb9gELZNBjC8zkqGasCNzF5YwJJykyZ9n42IQuXh2dD/BIJ344alb9sqBnSf/mJXlgZJPQC/rdke24iuefpk4y9nOf10WV+dtC0BbhlKoEK33zd4tXX7iT9S+ddlurgayHz5VBIqY9Yzg+WucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rDuiuiri; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C721F000E9;
	Wed, 20 May 2026 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297333;
	bh=OiVE337kF7WYb7LweRadhXasAMLeQRBL+RZ9Vw4GhiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rDuiuirikUVdwEL9C0imdpm/FcSEcdn4b/k+NKMXz/sUES9/0G1h5yoEqzyCvzV/j
	 Qp9KkAW4WRb52HJrmNRqToO985u8XEPUBZUT4PHxAWcN8/e+VXPwGPTGVeWe3w0TjQ
	 A0qqkkym7p7mMIrTnQpAAuRXmS6PLUPUmouKQEWM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrien Burnett <an.arctic.pigeon@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7.0 1088/1146] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion Laptop 16-ag0xxx
Date: Wed, 20 May 2026 18:22:18 +0200
Message-ID: <20260520162212.859052906@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-251190-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 37CF35994CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrien Burnett <an.arctic.pigeon@gmail.com>

commit 7d1051ad68df3d584b5f24bfa1fb19f3a24db278 upstream.

Add a SND_PCI_QUIRK entry for the HP Pavilion Laptop 16-ag0xxx
(subsystem 0x103c:0x8cbc, Realtek ALC245). The
ALC245_FIXUP_HP_X360_MUTE_LEDS fixup is already used by the
neighbouring HP Pavilion Aero Laptop 13-bg0xxx (0x103c:0x8cbd);
it chains the master-mute COEF handler with the GPIO mic-mute
LED handler, which is what this machine needs.

Tested on the affected hardware: both the mute and mic-mute key
LEDs respond correctly to the keyboard hotkeys after this change.

Cc: <stable@vger.kernel.org>
Signed-off-by: Adrien Burnett <an.arctic.pigeon@gmail.com>
Link: https://patch.msgid.link/20260514165905.21175-1-an.arctic.pigeon@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/codecs/realtek/alc269.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7146,6 +7146,7 @@ static const struct hda_quirk alc269_fix
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8caf, "HP Elite mt645 G8 Mobile Thin Client", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8cbc, "HP Pavilion Laptop 16-ag0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8cbd, "HP Pavilion Aero Laptop 13-bg0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8cdd, "HP Spectre", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8cde, "HP OmniBook Ultra Flip Laptop 14t", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),



