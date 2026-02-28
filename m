Return-Path: <stable+bounces-220514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGCHLkg5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:51:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E88D1C6559
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B936323AE0C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523773CB82B;
	Sat, 28 Feb 2026 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMEpFz39"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140CA3CB81A;
	Sat, 28 Feb 2026 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300398; cv=none; b=Uc/WaXHgW1SgSnLQ5JD7j5jJ6gy57Rf914aPZrC9zpR7boKAevwV+edZG0c5qSADxHxcaAh4ezMGyE3EsexmuoYqFg5IkwUMzUOswTy0li/V8pCMvN1IyR5A3yYko7Mlcr1rJdcF4K8DaUBlLjq/zaLZ4qMP4MZV2yFOzpb0Fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300398; c=relaxed/simple;
	bh=z4ONJflA2gCPaXMC/sKG6Z8ES0UuOJ9WngsB/kBloT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1iHGVQmU2oXWaVgS/LcWfDAtvoJIGZq0lhWo2s8yEkPBN2LS5qaWLEMqmEc8QHvfD0qH0tRx07VlS45rgi+S8G5nw3SymOdKnTVLd45od0ZW15EGnsIbwwX8CpZSeac0TX+Qc3mv86P8aB7xnpO4HFWWildu8slv9nNIcSjqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMEpFz39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73562C2BC87;
	Sat, 28 Feb 2026 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300398;
	bh=z4ONJflA2gCPaXMC/sKG6Z8ES0UuOJ9WngsB/kBloT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMEpFz397jfDrn2iYsfvJgWRzRXG+syAXZtdCoHuKPlDK3qEf6VtXQEOnlX0be17f
	 /X2MvBNlgPSk1ILpET5rBOu1EGkOIbyLwK5Ehn9cDzR8bJzNEfpTFmQafdZgth3aEM
	 3Mfha/BoVJm8hWYJslhREGRD0eQ8d81hrrKnSLfYoC8DLXZqXcW2psR6IeZyvSnnkt
	 XAKad1xwewZt9cDC+xb8iyXgPu04KEb7Nb2sXRU0YgYmLoj+aovxx3e5gVSiMXWRJf
	 6I2bjtbRys6Ym/5bBt8y207HoTW1ZeHPKCkPf/p6/ya3sxKx8la4bohV4la7S0cRN0
	 M+H6oj4FxGD4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 435/844] ALSA: usb-audio: Add sanity check for OOB writes at silencing
Date: Sat, 28 Feb 2026 12:25:48 -0500
Message-ID: <20260228173244.1509663-436-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-220514-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3E88D1C6559
X-Rspamd-Action: no action

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit fba2105a157fffcf19825e4eea498346738c9948 ]

At silencing the playback URB packets in the implicit fb mode before
the actual playback, we blindly assume that the received packets fit
with the buffer size.  But when the setup in the capture stream
differs from the playback stream (e.g. due to the USB core limitation
of max packet size), such an inconsistency may lead to OOB writes to
the buffer, resulting in a crash.

For addressing it, add a sanity check of the transfer buffer size at
prepare_silent_urb(), and stop the data copy if the received data
overflows.  Also, report back the transfer error properly from there,
too.

Note that this doesn't fix the root cause of the playback error
itself, but this merely covers the kernel Oops.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221076
Link: https://patch.msgid.link/20260216141209.1849200-4-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 27ade2aa16f5a..1eaf52d1ae9c7 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -275,8 +275,8 @@ static inline bool has_tx_length_quirk(struct snd_usb_audio *chip)
 	return chip->quirk_flags & QUIRK_FLAG_TX_LENGTH;
 }
 
-static void prepare_silent_urb(struct snd_usb_endpoint *ep,
-			       struct snd_urb_ctx *ctx)
+static int prepare_silent_urb(struct snd_usb_endpoint *ep,
+			      struct snd_urb_ctx *ctx)
 {
 	struct urb *urb = ctx->urb;
 	unsigned int offs = 0;
@@ -289,28 +289,34 @@ static void prepare_silent_urb(struct snd_usb_endpoint *ep,
 		extra = sizeof(packet_length);
 
 	for (i = 0; i < ctx->packets; ++i) {
-		unsigned int offset;
-		unsigned int length;
-		int counts;
-
-		counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, 0);
-		length = counts * ep->stride; /* number of silent bytes */
-		offset = offs * ep->stride + extra * i;
-		urb->iso_frame_desc[i].offset = offset;
+		int length;
+
+		length = snd_usb_endpoint_next_packet_size(ep, ctx, i, 0);
+		if (length < 0)
+			return length;
+		length *= ep->stride; /* number of silent bytes */
+		if (offs + length + extra > ctx->buffer_size)
+			break;
+		urb->iso_frame_desc[i].offset = offs;
 		urb->iso_frame_desc[i].length = length + extra;
 		if (extra) {
 			packet_length = cpu_to_le32(length);
-			memcpy(urb->transfer_buffer + offset,
+			memcpy(urb->transfer_buffer + offs,
 			       &packet_length, sizeof(packet_length));
+			offs += extra;
 		}
-		memset(urb->transfer_buffer + offset + extra,
+		memset(urb->transfer_buffer + offs,
 		       ep->silence_value, length);
-		offs += counts;
+		offs += length;
 	}
 
-	urb->number_of_packets = ctx->packets;
-	urb->transfer_buffer_length = offs * ep->stride + ctx->packets * extra;
+	if (!offs)
+		return -EPIPE;
+
+	urb->number_of_packets = i;
+	urb->transfer_buffer_length = offs;
 	ctx->queued = 0;
+	return 0;
 }
 
 /*
@@ -332,8 +338,7 @@ static int prepare_outbound_urb(struct snd_usb_endpoint *ep,
 		if (data_subs && ep->prepare_data_urb)
 			return ep->prepare_data_urb(data_subs, urb, in_stream_lock);
 		/* no data provider, so send silence */
-		prepare_silent_urb(ep, ctx);
-		break;
+		return prepare_silent_urb(ep, ctx);
 
 	case SND_USB_ENDPOINT_TYPE_SYNC:
 		if (snd_usb_get_speed(ep->chip->dev) >= USB_SPEED_HIGH) {
-- 
2.51.0


