Return-Path: <stable+bounces-230592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCEkAd0nxmnQGwUAu9opvQ
	(envelope-from <stable+bounces-230592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 07:46:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA633FFF4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 07:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A626A3004D3A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 06:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1E93C1970;
	Fri, 27 Mar 2026 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPjP9uAk"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F913BE173
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593914; cv=none; b=IwcQCHsmJKOXeL8OWY6bk6n13T1x709BA0C0aljBcI3na0P5PyALu+dKCx5q1cxt302wkT4NnP9az7yO1jIahiYzTP8TEOXBQ/WpZFdvP2tXWHMR5kdOvZc0l9cQshsIo4ffGxJFidvdfPByD00NrK5Xv6dO97nHp+wJN8Gvpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593914; c=relaxed/simple;
	bh=i9wiMfsMy9Mf4aeuKAwnYO3RKNzbzS39shLmUR25TVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cw0aecpsZFf0su+6lJO+RKePwv6UYB9v92ArhW4IrpsGFnxN7GhzXwICbC80AsDQIzfGgWcp18AcjbXpAA1duCxljB6Oceq8KApV6EIrGbTL4b6TPQhF8O4dHsL3/PSrD/TYNR4gHt22T1p5q8w/8hE9dnNdle7rabp2hJcTaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPjP9uAk; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ffc879c1aeso1189811137.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774593904; x=1775198704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5steKgFbVCdTXCRbQ/WRIMoGkwD2ComHRnreYDYbjI=;
        b=WPjP9uAkhaSho3azgC4X2mkgmded/cf6VGAIHcDZbI5dXpT41JfbIIvrQaGAmVfqf1
         jsLqcXIAk2jsTe/HviWQAEgk9H5fz7NzuKBmA/Tx4Y5HCw9VsKn2WGOAEgENI9BS/cNV
         LgzVfjjrYFntZYyLyjTOKZEb4Rqc+UBY8iywS6LShP1WFXHSZI+u3MLywBmIxpTxDDIV
         PsFisrtHzK0tJirfR1TUgWChlANStUxHp3R/hXUS0kYILnFnRSqz67gYQKfiOUuDfsiI
         8quc4C3HRHOGo43dOoaB7+SIJLTcpKru4fJShYD43r9Mt8+TWh42E94N3UXJ4BxDjF+/
         s2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593904; x=1775198704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5steKgFbVCdTXCRbQ/WRIMoGkwD2ComHRnreYDYbjI=;
        b=caoH4h17i0iEdtVkR/cS2orn3H10UZU2WnOfINXZZEGCX/x5lbYlwOLsXeNwVHXvSa
         ogKJAe8kSOW4akOFPMRXcrDHqSKo8clgAsxg1Y6R4vZ4H9nwoBqdlbWKSbjApdPaVebe
         2InpWComh87I5l1tN+sX31B5yCUzBXk6nZ7Ct/cV4r8p2vqf7HfzbEp5k1K9rgofvQrr
         g7sZoMPtkho1iknVzdpsihQqsl3g5ryGOKFTfUkNOpwu2PlqiIES0JK+dYdDfZhJT5tg
         UeHn7ktNCn4TuE8WKx/hsHLJuSGr+vEboVfDec8VsIsF5haCwNQoZ2tPVKIkdIdFs8Fa
         ELrA==
X-Forwarded-Encrypted: i=1; AJvYcCX4sp8kUPMuDae7eRa/g9QwFD2pJHKIRTMqQlpsF9tjvxvXn3v9rkUA97fmm1A3BFJCkDlZ0vU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuxdh5fUhbJO0Q7qxhYkeFZHOG7qBKZvvIxH6GuNrV8aulioou
	KelGcqHFheEC26WHw+WbdZHmXhRawnnDj30l1xKssoe46wp+XpgUn6da
X-Gm-Gg: ATEYQzzMEvYenfasGKq+dGwPrOsRZ/TJB6sIIXqW27V1t4AdBUq/lonfJHekLC8BVIq
	SG5twrX1weBw7yFX3Wroms0vCAsLwRtA43HfBP3UKOooyCRSCJq0AdnUNa+zrMNi1TT/aIZmcbc
	uHf5ix/tWPFCB7XydJw3VwgfoqqfG83r61momZektg9YC4sWPgRxEzNONyfR19d86xDdCqtXPlc
	jJTu3LLCkADzxRvprioJY6kWNYqes9+BBtu/GJvANOD9agMi6ixZRkFz8vRZAYWErnyYnh6vYnu
	ri7UR4HNyGmCA3zRgl0bSN5g1ri7nM7avLDj9UhPcNEarQdW13g1qT+H9sjhI0mF+Sc2gsQP0ed
	zA7+7dOJPdgn+mA7xDV82pROzOnXESHvnLuhIF55BfFkLPAUDUzR3ddFHN2kEkrKrxePkA7N3JN
	ouHp5am9O9c1BQHzJYZwUZsmYiLrL4cn2OAPc4+EzSBh6jEg/Wmpxmj9O3y0mKlRhxODVDVxNWI
	o5VMrXRKxWteCRRPkcB3II8ogPwbeiSRZ6ZmnWVtdOWz51K2eMzZKZ+nLaqQ0Djmr4PIRgcAYmR
	tWs=
X-Received: by 2002:a05:6102:c4d:b0:5ff:c6b2:efde with SMTP id ada2fe7eead31-604f909816fmr552934137.6.1774593903894;
        Thu, 26 Mar 2026 23:45:03 -0700 (PDT)
Received: from localhost.localdomain (2603-900b-5c40-0017-3433-631f-7c6a-3c94.inf6.spectrum.com. [2603:900b:5c40:17:3433:631f:7c6a:3c94])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-604d5313adbsm5641316137.8.2026.03.26.23.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:45:03 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	addcontent08@gmail.com,
	skhan@linuxfoundation.org,
	kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH] usbip: vhci: reject RET_SUBMIT with inflated number_of_packets
Date: Fri, 27 Mar 2026 02:44:49 -0400
Message-ID: <20260327064449.735-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,dartmouth.edu,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230592-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05AA633FFF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a USB/IP client receives a RET_SUBMIT response,
usbip_pack_ret_submit() unconditionally overwrites
urb->number_of_packets from the network PDU. This value is
subsequently used as the loop bound in usbip_recv_iso() and
usbip_pad_iso() to iterate over urb->iso_frame_desc[], a flexible
array whose size was fixed at URB allocation time based on the
*original* number_of_packets from the CMD_SUBMIT.

A malicious USB/IP server can set number_of_packets in the response
to a value larger than what was originally submitted, causing a heap
out-of-bounds write when usbip_recv_iso() writes to
urb->iso_frame_desc[i] beyond the allocated region.

KASAN confirmed this with kernel 7.0.0-rc5:

  BUG: KASAN: slab-out-of-bounds in usbip_recv_iso+0x46a/0x640
  Write of size 4 at addr ffff888106351d40 by task vhci_rx/69

  The buggy address is located 0 bytes to the right of
   allocated 320-byte region [ffff888106351c00, ffff888106351d40)

The server side (stub_rx.c) and gadget side (vudc_rx.c) already
validate number_of_packets in the CMD_SUBMIT path since commits
c6688ef9f297 ("usbip: fix stub_rx: harden CMD_SUBMIT path to handle
malicious input") and b78d830f0049 ("usbip: fix vudc_rx: harden
CMD_SUBMIT path to handle malicious input"). The server side validates
against USBIP_MAX_ISO_PACKETS because no URB exists yet at that point.
On the client side we have the original URB, so we can use the tighter
bound: the response must not exceed the original number_of_packets.

This mirrors the existing validation of actual_length against
transfer_buffer_length in usbip_recv_xbuff(), which checks the
response value against the original allocation size.

Kelvin Mbogo's series ("usb: usbip: fix integer overflow in
usbip_recv_iso()", v2) hardens the receive-side functions themselves;
this patch complements that work by catching the bad value at its
source -- in usbip_pack_ret_submit() before the overwrite -- and
using the tighter per-URB allocation bound rather than the global
USBIP_MAX_ISO_PACKETS limit.

Fix this by checking rpdu->number_of_packets against
urb->number_of_packets in usbip_pack_ret_submit() before the
overwrite. On violation, clamp to zero so that usbip_recv_iso() and
usbip_pad_iso() safely return early.

Fixes: 0775a9cbc798 ("staging: usbip: vhci extension: modifications to the client side")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
 drivers/usb/usbip/usbip_common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -470,7 +470,18 @@ static void usbip_pack_ret_submit(struct usbip_header *pdu, struct urb *urb,
 		urb->status		= rpdu->status;
 		urb->actual_length	= rpdu->actual_length;
 		urb->start_frame	= rpdu->start_frame;
-		urb->number_of_packets = rpdu->number_of_packets;
+		/*
+		 * The number_of_packets field determines the length of
+		 * iso_frame_desc[], which is a flexible array allocated
+		 * at URB creation time. A response must never claim more
+		 * packets than originally submitted; doing so would cause
+		 * an out-of-bounds write in usbip_recv_iso() and
+		 * usbip_pad_iso(). Clamp to zero on violation so both
+		 * functions safely return early.
+		 */
+		if (rpdu->number_of_packets < 0 ||
+		    rpdu->number_of_packets > urb->number_of_packets)
+			rpdu->number_of_packets = 0;
+		urb->number_of_packets = rpdu->number_of_packets;
 		urb->error_count	= rpdu->error_count;
 	}
 }

