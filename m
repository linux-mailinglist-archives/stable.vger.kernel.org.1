Return-Path: <stable+bounces-252804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN4DC9P+DWpV5QUAu9opvQ
	(envelope-from <stable+bounces-252804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F69596AC0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 845DE3064AAC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11C33FB05C;
	Wed, 20 May 2026 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CgccpnNl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649D3F7ABC;
	Wed, 20 May 2026 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301632; cv=none; b=pqfEwbZMT7uyWSs/XnO/PmY6umJrCloPKUdqaKqZ1KtwgqqBvn7CEmgkYTuPNNJeD/WCbxy9IBC2zLANnILQ+w40KLnt0j23QW+Px4UfSFd5f0h0hii+NWzMY13uEg0jAY2WI6x8hiW/gJnUcQJeWagW3BBUC7b8kE6vWeJtclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301632; c=relaxed/simple;
	bh=I8QdBjtAoepKWs9hjaKPH2xkojK1/7Wi6vQqfHvEd2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JY1uOiXScKxnp04BqA2RWcvOhYv3GCt8R3ILSnEIfMVndPJU0AHQSCLIRQtjt4BzsAVsencMwuGM70vwiLSZKot+H962F+v8Rd3eiELjHrJjpO82FAVbg95WUk60fBaNAaox22c+u+JGRDiIU70//fjcdm3Bea8JJMNVgPuXQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CgccpnNl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B781F000E9;
	Wed, 20 May 2026 18:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301631;
	bh=gH/pTljXszOptj+XNdpAZe7VYU3SIdDO0A+Ldk9GgeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CgccpnNlgiBRpAJqcfveyYoS6zKqhSugC+De+PkmubWbuGGg9mDrl0kaina7+pkVR
	 RQORysjeWNli2K5EUdrHj26jHgKHpszCV27WCP3MzTkBVGdSKvk5qB0YEo4eKlCo55
	 /T6ZwNlKhs9WhZKQDdVXUpjTsNsn5C64+CwbM2Ik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 628/666] ALSA: usb-audio: Bound MIDI 2.0 endpoint descriptor scans
Date: Wed, 20 May 2026 18:23:59 +0200
Message-ID: <20260520162124.888420255@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252804-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: 06F69596AC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit 918be519c7876329e1b6e2ea1c59f0b75e792dca upstream.

The USB MIDI 2.0 endpoint parser has the same descriptor walking
pattern as the legacy MIDI parser. It validates bLength against
bNumGrpTrmBlock before reading baAssoGrpTrmBlkID[], but not against the
remaining bytes in the endpoint-extra scan.

A malformed device can therefore make later baAssoGrpTrmBlkID[] reads
consume bytes past the walked descriptor.

Reject zero-length and overlong descriptors while walking endpoint
extras.

Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260507-usb-midi-endpoint-scan-bounds-v1-2-329d7348160e@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/midi2.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -504,15 +504,17 @@ static void *find_usb_ms_endpoint_descri
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
 		    ms_ep->bDescriptorSubtype == subtype)
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



