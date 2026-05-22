Return-Path: <stable+bounces-253803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBxiK0dzEGoZXgYAu9opvQ
	(envelope-from <stable+bounces-253803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:16:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B28C05B6C14
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F26A030A2F03
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB70427A10;
	Fri, 22 May 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy8NefCb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299C3FFAB6;
	Fri, 22 May 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459606; cv=none; b=j4Fj3/SQhmf8or6hnUGcc9KG7Qz3m+3rt21gXqdHItCVdGC3lbNTyjDll/M86NWLW8lIhng1AfwZU2yIrsg4vSnA7PIma3IS6iWxaDRKSxneV3yhz047NvwhqVcaNCsta5H91EeZMYicovNv4Ea2Gq3IAa3Tq/4BNA3QZShbieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459606; c=relaxed/simple;
	bh=11gouIwUW0jRrXK7IAlQZnvsti6SZR840f5szgMu3Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UM8mRBvwkWYtq77Dj33idRGVfzsnw+QiTWoW1hU2X3VPqfrC9BHXgWZH/Ng6/J4uJ5OCG5m44KfnqWrs36lM7V6Wl4NxC4OAlr8s+OpOwdKxJC/uTqhe6gka2OPSwsL3Ez3pN80ydiBEQSq0LF9SyqgswZ66NjgF8mJAN2EqtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy8NefCb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686911F000E9;
	Fri, 22 May 2026 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779459600;
	bh=L5ixqrYNlm/ZTh7tH9x0MeVLArrx0bUSChftgqmU4yU=;
	h=From:To:Cc:Subject:Date;
	b=Yy8NefCbNa8+tU2WTrkWByL7eCNMK3d/6HFIq6vvsP/6lhO7SuluF2GOLiPlcT+OM
	 5rKgSoa88GJjtnEm97J4EdWQV2NMIvc8t6FKk2KLQn1zRKgSDJM22zJAOjDIfzAWjr
	 64NM7F0khnaOgui/t2spFheg75t+57RtYn8WFfiGGsRkySo0rIjzu7SITbapm52TiS
	 pIQ11BJpKqQ0VsNOkU4GXqlKTQYkG1rCBw7JR9aNaK81AJY73WWpXBCU2IoJEjvsRC
	 6f7gKzn7/R/296ocGcCvoE1rYmkgpXZhQ0vpAahhl+7x47HBxSiHyTQiXBtdEMASMc
	 6DG2p33cqhsUQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wQQjF-00000003yTx-3xLf;
	Fri, 22 May 2026 16:19:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] USB: serial: mxuport: fix memory corruption with small endpoint
Date: Fri, 22 May 2026 16:19:50 +0200
Message-ID: <20260522141950.947466-1-johan@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253803-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: B28C05B6C14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure that the bulk-out endpoint max packet size is at least eight
bytes to avoid user-controlled slab corruption should a malicious device
report a smaller size.

Fixes: ee467a1f2066 ("USB: serial: add Moxa UPORT 12XX/14XX/16XX driver")
Cc: stable@vger.kernel.org	# 3.14
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/mxuport.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index ad5fdf55a02e..c9b9928c473a 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -962,6 +962,14 @@ static int mxuport_calc_num_ports(struct usb_serial *serial,
 	 */
 	BUILD_BUG_ON(ARRAY_SIZE(epds->bulk_out) < 16);
 
+	/*
+	 * The bulk-out buffers must be large enough for the four-byte header
+	 * (and following data), but assume anything smaller than eight bytes
+	 * is broken.
+	 */
+	if (usb_endpoint_maxp(epds->bulk_out[0]) < 8)
+		return -EINVAL;
+
 	for (i = 1; i < num_ports; ++i)
 		epds->bulk_out[i] = epds->bulk_out[0];
 
-- 
2.53.0


