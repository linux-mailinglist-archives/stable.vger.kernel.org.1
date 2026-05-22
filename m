Return-Path: <stable+bounces-253804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO1nHMFzEGoZXgYAu9opvQ
	(envelope-from <stable+bounces-253804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:18:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 779945B6C39
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 914C63044EEE
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2346AF12;
	Fri, 22 May 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiwQp81u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2093E44D03E;
	Fri, 22 May 2026 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459677; cv=none; b=HU+TziIYd4o0t+9ageioNDLUMJp5a8SSirKBWH/gMaoh1mmvFCaGdNyl+Ugb6OtRn8/GjcVvOVH6NZmSE7OBkem79C1ZZJIfeWFYUK+gO8FF8RWHCByAfEitLfeLHf8Zq5AHsvPKE45QiimztzrEZ0bZUGxLm+OErVCArmVrJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459677; c=relaxed/simple;
	bh=K0elrzimdXCyzURa1cLZ/r5goMxgKe51CSERdDdk5iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSGKRPhi0RkkgdqJLfNyXIonPK/Cs+uWNhCoiP6mab4JZDbV0ZgYrQlAMrohky3fwPy3iYGKknbl1e2smuA4LahT/zA8z9WSR+Mqn8gsIaLzZ6Q0CrCy6OvYS5gmWxrZ4AxHDlxcLzoqzHO3almS4VQnyRx7EkBJezGSX5hr8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiwQp81u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5A61F00A3D;
	Fri, 22 May 2026 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459667;
	bh=9+yIlTuD8sKkgWKpIyHWbkZfbsCingQbyRKVyoCqv1k=;
	h=From:To:Cc:Subject:Date;
	b=kiwQp81uU7lNsO5mrt86VGVQmN/9zraDoNt43aOQjUja9q0HOgR4CvQ0SxSBAP5UU
	 n0WZX8rrYN/JqzgL9houKI5DBvKmuEq3YE5RC34ZGRcqEsLaxIqHVtBmTVsr0rcTUW
	 4HHyIyuq7WkBcKfs8GRNQOkTTzBuTXuwuQAQ5dbGJsQqWnsiDZ5X0LUt/OQNM9dNJl
	 cR52nmUJzqcjpkyFOT45qqqUOU3xQ3BiZE5VqXrDY7Ik5jg/ZuocnHn8sYdH+6ZjCw
	 kHS9xZ4zWEGui8RcQoEehPEiPAxTZHuUj4e6PNDMqgNno1DUCOLl0p4rgNtrNUwhHJ
	 3wX3DfPvyXlAA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wQQkL-00000003yVS-06ZC;
	Fri, 22 May 2026 16:21:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: omninet: fix memory corruption with small endpoint
Date: Fri, 22 May 2026 16:20:58 +0200
Message-ID: <20260522142058.947562-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253804-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 779945B6C39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure that the bulk-out buffers are at least as large as the
hardcoded transfer size to avoid user-controlled slab corruption should
a malicious device report a smaller endpoint max packet size than
expected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/omninet.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index aa1e9745f967..b59982ed8b25 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -30,6 +30,10 @@
 /* This one seems to be a re-branded ZyXEL device */
 #define BT_IGNITIONPRO_ID	0x2000
 
+#define OMNINET_HEADERLEN	4
+#define OMNINET_BULKOUTSIZE	64
+#define OMNINET_PAYLOADSIZE	(OMNINET_BULKOUTSIZE - OMNINET_HEADERLEN)
+
 /* function prototypes */
 static void omninet_process_read_urb(struct urb *urb);
 static int omninet_prepare_write_buffer(struct usb_serial_port *port,
@@ -54,6 +58,7 @@ static struct usb_serial_driver zyxel_omninet_device = {
 	.description =		"ZyXEL - omni.net usb",
 	.id_table =		id_table,
 	.num_bulk_out =		2,
+	.bulk_out_size =	OMNINET_BULKOUTSIZE,
 	.calc_num_ports =	omninet_calc_num_ports,
 	.port_probe =		omninet_port_probe,
 	.port_remove =		omninet_port_remove,
@@ -130,10 +135,6 @@ static void omninet_port_remove(struct usb_serial_port *port)
 	kfree(od);
 }
 
-#define OMNINET_HEADERLEN	4
-#define OMNINET_BULKOUTSIZE	64
-#define OMNINET_PAYLOADSIZE	(OMNINET_BULKOUTSIZE - OMNINET_HEADERLEN)
-
 static void omninet_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
-- 
2.53.0


