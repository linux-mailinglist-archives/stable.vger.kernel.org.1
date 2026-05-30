Return-Path: <stable+bounces-259221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO2zHSoyG2qkAAkAu9opvQ
	(envelope-from <stable+bounces-259221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094A612BF9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D01E330E3850
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508271D63E4;
	Sat, 30 May 2026 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ssqiMWVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B22E7398;
	Sat, 30 May 2026 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167015; cv=none; b=eWjxFRP/NRD/Ji8rMZqq3AMT+Y9cq4GRTwOblUaQtHVSJtt3VPHPKZuA+3qoF1OMf9bZOAfW/MUUEcB/SIc19fwfnDexjeBhxnXu7Up/jSJUJ6r+2WmY0GBUCzBcRJXbMSZrbZHQO6lK4d+adbxfbZn7QnoUFuQZsqP0Lkb4R30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167015; c=relaxed/simple;
	bh=WdGqgQX3dClS3bivieZgsT1VGX8nGB6xWOX+1dUS3HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnAhU/l4PKatxa6U8x3MjZEH4Tfx+45rEFX4+um3BNzHLS6l5SnxDfT6Akv53uue/K1lI5NuRz7VBb6W1vYXdB/TVL/PnAmOvby3UnQxeTQBw9/l7XDeFIJ4d84LC28Un3O1d3tR6vCTA4kR3iLdUJNF+cyHu8oDD6UnKseHACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ssqiMWVg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761A61F00893;
	Sat, 30 May 2026 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780167014;
	bh=kGMBCKbCLBv6g5CXYSbRQa0SHsfLPljZ7TxUwJ+2nWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ssqiMWVg76L2h6Qbb8XnUoaTPWxtA3/sDR9MzQvLSxwlT3nPIIT4lFonubw3e03xY
	 qq7oXa1DgtfAofhybq/Oi3dZSeUfak2+uFn4j87QS9hIuG9dSYWjo1dBafPRjmYjB9
	 sRCVsvigbqrIterr1HzQpnKwnMAyCr+x1yqNor/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 509/589] ALSA: usb-audio: Bound MIDI endpoint descriptor scans
Date: Sat, 30 May 2026 18:06:30 +0200
Message-ID: <20260530160237.976046703@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259221-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email]
X-Rspamd-Queue-Id: 1094A612BF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit d6854daa67be623860f4e1873fd3d3c275aba4ed upstream.

snd_usbmidi_get_ms_info() validates the internal MIDIStreaming endpoint
descriptor size before using baAssocJackID[], but the descriptor walker can
still return a class-specific endpoint descriptor whose bLength exceeds the
remaining bytes in the endpoint-extra scan.

That leaves later flexible-array reads bounded by bLength, but not by the
remaining bytes in the endpoint-extra scan.

Stop walking when bLength is zero or
extends past the remaining endpoint-extra scan.

Fixes: 5c6cd7021a05 ("ALSA: usb-audio: Fix case when USB MIDI interface has more than one extra endpoint descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260507-usb-midi-endpoint-scan-bounds-v1-1-329d7348160e@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/midi.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1906,15 +1906,17 @@ static struct usb_ms_endpoint_descriptor
 	while (extralen > 3) {
 		struct usb_ms_endpoint_descriptor *ms_ep =
 				(struct usb_ms_endpoint_descriptor *)extra;
+		int length = ms_ep->bLength;
 
-		if (ms_ep->bLength > 3 &&
+		if (!length || length > extralen)
+			break;
+
+		if (length > 3 &&
 		    ms_ep->bDescriptorType == USB_DT_CS_ENDPOINT &&
 		    ms_ep->bDescriptorSubtype == UAC_MS_GENERAL)
 			return ms_ep;
-		if (!extra[0])
-			break;
-		extralen -= extra[0];
-		extra += extra[0];
+		extralen -= length;
+		extra += length;
 	}
 	return NULL;
 }



