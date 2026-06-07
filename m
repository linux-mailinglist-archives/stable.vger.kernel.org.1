Return-Path: <stable+bounces-260935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r6jUHeRBJWqtFAIAu9opvQ
	(envelope-from <stable+bounces-260935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:03:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1936964F4E4
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:03:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ByYTmskd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260935-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260935-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41FC93003836
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0A2F5A13;
	Sun,  7 Jun 2026 10:03:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0D2EEE7D;
	Sun,  7 Jun 2026 10:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826593; cv=none; b=pLSblbzjjjqb0CQQ5MhUliQFigXGX7UfwFoxR5gsAvMlNOzgsjSkzd4PNB2sQG1B/jqSoZ6Oz6V6rTuIG8hWLRj3IFItxPurAlIDr6X4W5BRWZyuUriqUu5DIk1EK3HPuPmtpH+o+/eERQzPqSlwUsbajBgnDxYToVY8QHn1QLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826593; c=relaxed/simple;
	bh=IdUF73tc6E0RERVUj33AmYNqKY61kor8ywIZjyUvAXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nr/I1MfNkC6+XGAMQ5nEdP1G3WnJRqU+koQcQ3/MUQMBdEDqvqn7rY3HWZ2Akwn7C14ZGuUTur5h44RAlmyqo2IdKJpd9bUeWRJNO3slmMGccEvqMOEKOTsaA1Hu3l1dCHf/ns5T9rLJDL7KXTvzMz03f9Wvy6KjdXcTFmh5JBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ByYTmskd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94FF1F00893;
	Sun,  7 Jun 2026 10:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826592;
	bh=tZfv0ng5ZX/qfnBe5DLlu08eHZzdLALQdJfVBh8FIx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ByYTmskdN/O6Eytfqj++lqn9On3mSiEhNCPHuDTC0jECmtGZa+Gb66w1aDfD/MRu6
	 zzxc9aOTElsODeR42D0BkfGVSTb4vB9YgF88tPTkOZWBVJVcA5oChn6X0jJrvuvsDb
	 B2T9/OtvKyk0xbh9+xugwSpZ9GKzcnXor6hU7I5Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.18 001/315] Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
Date: Sun,  7 Jun 2026 11:56:28 +0200
Message-ID: <20260607095727.580617827@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260935-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dmitry.torokhov@gmail.com,m:stable@kernel.org,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1936964F4E4

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 2905281cbda52ec9df540113b35b835feb5fafd3 upstream.

nexio_read_data() pulls data_len and x_len from a packed __be16 header
in the device's interrupt packet and then walks packet->data[0..x_len)
and packet->data[x_len..data_len) comparing each byte against a
threshold.

Both fields are 16-bit on the wire (max 65535).  The existing
adjustments shave at most 0x100 / 0x80 off, so the loop bound can still
reach roughly 0xfeff.  The URB transfer buffer for NEXIO is rept_size
(1024) bytes from usb_alloc_coherent(), with the first 7 occupied by the
packed header — so packet->data[] has 1017 valid bytes.  read_data()
callbacks are not given urb->actual_length, and nothing else bounds the
walk.

A device that lies about its length can get a ~64 KiB out-of-bounds read
past the coherent DMA allocation.  The first index whose byte exceeds
NEXIO_THRESHOLD lands in begin_x / begin_y and from there into the
reported touch coordinates, so adjacent kernel memory contents leak to
userspace as ABS_X / ABS_Y events.  Far enough out, the read can also
hit an unmapped page and fault.

Fix this all by clamping data_len to the buffer's data[] capacity and
x_len to data_len.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 5197424cdccc ("Input: usbtouchscreen - add NEXIO (or iNexio) support")
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026042026-chlorine-epidermis-fd6d@gregkh
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/usbtouchscreen.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1070,6 +1070,11 @@ static int nexio_read_data(struct usbtou
 	if (x_len > 0xff)
 		x_len -= 0x80;
 
+	if (data_len > usbtouch->data_size - sizeof(*packet))
+		data_len = usbtouch->data_size - sizeof(*packet);
+	if (x_len > data_len)
+		x_len = data_len;
+
 	/* send ACK */
 	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
 	if (ret)



