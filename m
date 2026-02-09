Return-Path: <stable+bounces-215097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAbyDHbwiWn4EQAAu9opvQ
	(envelope-from <stable+bounces-215097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:34:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8A9110747
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 785D33004632
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902E7285060;
	Mon,  9 Feb 2026 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m/JY2bBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542AD1AF0AF;
	Mon,  9 Feb 2026 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647665; cv=none; b=PhLFUHGRLvwkQn8YcKmfW+InqrgLs/FPuizuWb/Y4udFCNIrCZRYo2gbZcg89gSKawOcsMd1+mDNYDs55/ZltlxwqXmwNomJRM8aOP/f053icU8rEJpO9pUTUytYKNIRtmZIjbtkOiPsTCQdEIOukBkJBuL3ho0sOElnJ5WO4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647665; c=relaxed/simple;
	bh=cF3Y8aGhCUKnvEXLr+5EgPquFON1X3n0VeFsfhtEcNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdHIMRbEbFEdTDGf3uo2zb9fgCZK20wuEg4BdSFXyepmcmnZtSfltaQY/6+OE/VX7qM3AtpvNuXqEA8Vpu/YIkroFMp/GdUHtV74WV6OUKea+SbvTmSgiD8zeRELSwlppJCo41K3qW0VhOyoCLMDXsY06ahfp+tcDhEQJb+Pfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m/JY2bBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E44C116C6;
	Mon,  9 Feb 2026 14:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647665;
	bh=cF3Y8aGhCUKnvEXLr+5EgPquFON1X3n0VeFsfhtEcNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/JY2bBqVowUdmYmHI6O+3ZuoiM485JJmH33HmrswCZXUewciVHDt0tjiP3ovR5Mo
	 b/A5LlfMtx91PMWCSKEOQjkVGzJmg1HbknJzAdLL56qnFzlDDk1PhWg5ug43y3VnOO
	 dRqyuBqrKiVSQdazJP1przKwCWlVBY1YBvVJ67Zo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Shtylyov <s.shtylyov@auroraos.dev>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 160/175] ALSA: usb-audio: fix broken logic in snd_audigy2nx_led_update()
Date: Mon,  9 Feb 2026 15:23:53 +0100
Message-ID: <20260209142326.247749379@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215097-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3E8A9110747
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Shtylyov <s.shtylyov@auroraos.dev>

[ Upstream commit 124bdc6eccc8c5cba68fee00e01c084c116c4360 ]

When the support for the Sound Blaster X-Fi Surround 5.1 Pro was added,
the existing logic for the X-Fi Surround 5.1 in snd_audigy2nx_led_put()
was broken due to missing *else* before the added *if*: snd_usb_ctl_msg()
became incorrectly called twice and an error from first snd_usb_ctl_msg()
call ignored.  As the added snd_usb_ctl_msg() call was totally identical
to the existing one for the "plain" X-Fi Surround 5.1, just merge those
two *if* statements while fixing the broken logic...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: 7cdd8d73139e ("ALSA: usb-audio - Add support for USB X-Fi S51 Pro")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Link: https://patch.msgid.link/20260203161558.18680-1-s.shtylyov@auroraos.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_quirks.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 828af3095b86e..4873b5e748016 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -311,13 +311,8 @@ static int snd_audigy2nx_led_update(struct usb_mixer_interface *mixer,
 	if (pm.err < 0)
 		return pm.err;
 
-	if (chip->usb_id == USB_ID(0x041e, 0x3042))
-		err = snd_usb_ctl_msg(chip->dev,
-				      usb_sndctrlpipe(chip->dev, 0), 0x24,
-				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-				      !value, 0, NULL, 0);
-	/* USB X-Fi S51 Pro */
-	if (chip->usb_id == USB_ID(0x041e, 0x30df))
+	if (chip->usb_id == USB_ID(0x041e, 0x3042) ||	/* USB X-Fi S51 */
+	    chip->usb_id == USB_ID(0x041e, 0x30df))	/* USB X-Fi S51 Pro */
 		err = snd_usb_ctl_msg(chip->dev,
 				      usb_sndctrlpipe(chip->dev, 0), 0x24,
 				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-- 
2.51.0




