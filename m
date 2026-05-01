Return-Path: <stable+bounces-242455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCPFC83K9GnEEgIAu9opvQ
	(envelope-from <stable+bounces-242455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 17:46:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A184ADB2B
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 17:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C94C302A6E0
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E913D0914;
	Fri,  1 May 2026 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLmCo7J8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54D2D97B8
	for <stable@vger.kernel.org>; Fri,  1 May 2026 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777650127; cv=none; b=kgQxPRnWLEq1+g7Do6wObE0g6rvs2LLQdP5Y4w5tdri1X/VXY+Itm7mfeLL0nDn5IbIxK2X/SpjR7OnLAHlsimsQsbqQXJg+upswfAFEXoSvHvx7qtmnwPXbDvgNzRfQEEvPtXWojM85uqWCp/ZcbHGpORthqjGVELqQP3ogsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777650127; c=relaxed/simple;
	bh=on344V+BshqhUdPgOK6GHu1hKkJ71ybb367w5kn63B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0w9tGMw3hShwKSuYDcsfr4d9Dym+7WSvtXErcYf/d8fj5SVQ7dZxypSsOTpdlFPCMnV8CoZu+AeOdkTHZxGgDd80eSSWjm/C2xEAy0OXYXjUhxKsGKB3uJRoWDBLUNdft2vSqY8gpPkkkDwwyUFhWbttQXGOOJgzgqSakYJ7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLmCo7J8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4222C2BCB4;
	Fri,  1 May 2026 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777650127;
	bh=on344V+BshqhUdPgOK6GHu1hKkJ71ybb367w5kn63B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLmCo7J88qg1lV0ewm+PxQeJgG6Cv2GaNBO/6Cyp0n/8DlGxeoSUHJsfmjr6dTBam
	 ptnkth9V5E7UW2QNyvawH3tEIh40oRQfO4/Z8AKuhVqalx36MUXrN1+tTz857CLLGh
	 AsjIaECVulCZSFdakqdcdLWKIH6TvQc45Opa3f3GUIRckDU/LOFWxlY71QAxzdDfXC
	 nqaiMlbSL2CBZIwuPrYn+GVVSOemjnFq+6oZaRlFEdmCrkjAQE/sEwNWuYW8t7QNAC
	 IbeqA6YPQH6dmDqzYORhRhRGIZ04frzgwCOcwfO+g+9JQCO3gcC1FUDzTMWXoVuHgS
	 sSau3AowRcPUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: rc: ttusbir: respect DMA coherency rules
Date: Fri,  1 May 2026 11:42:03 -0400
Message-ID: <20260501154203.3594498-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050121-reverb-commodore-11f0@gregkh>
References: <2026050121-reverb-commodore-11f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 79A184ADB2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242455-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mess.org:email]

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 50acaad3d202c064779db8dc3d010007347f59c7 ]

Buffers must not share a cache line with other data structures.
Allocate separately.

Fixes: 0938069fa0897 ("[media] rc: Add support for the TechnoTrend USB IR Receiver")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ kept kzalloc(sizeof(*tt), GFP_KERNEL) instead of kzalloc_obj() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/ttusbir.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
index 560a26f3965cf..dde446a95eaa9 100644
--- a/drivers/media/rc/ttusbir.c
+++ b/drivers/media/rc/ttusbir.c
@@ -32,7 +32,7 @@ struct ttusbir {
 
 	struct led_classdev led;
 	struct urb *bulk_urb;
-	uint8_t bulk_buffer[5];
+	u8 *bulk_buffer;
 	int bulk_out_endp, iso_in_endp;
 	bool led_on, is_led_on;
 	atomic_t led_complete;
@@ -186,13 +186,16 @@ static int ttusbir_probe(struct usb_interface *intf,
 	struct rc_dev *rc;
 	int i, j, ret;
 	int altsetting = -1;
+	u8 *buffer;
 
 	tt = kzalloc(sizeof(*tt), GFP_KERNEL);
+	buffer = kzalloc(5, GFP_KERNEL);
 	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
-	if (!tt || !rc) {
+	if (!tt || !rc || buffer) {
 		ret = -ENOMEM;
 		goto out;
 	}
+	tt->bulk_buffer = buffer;
 
 	/* find the correct alt setting */
 	for (i = 0; i < intf->num_altsetting && altsetting == -1; i++) {
@@ -281,8 +284,8 @@ static int ttusbir_probe(struct usb_interface *intf,
 	tt->bulk_buffer[3] = 0x01;
 
 	usb_fill_bulk_urb(tt->bulk_urb, tt->udev, usb_sndbulkpipe(tt->udev,
-		tt->bulk_out_endp), tt->bulk_buffer, sizeof(tt->bulk_buffer),
-						ttusbir_bulk_complete, tt);
+			  tt->bulk_out_endp), tt->bulk_buffer, 5,
+			  ttusbir_bulk_complete, tt);
 
 	tt->led.name = "ttusbir:green:power";
 	tt->led.default_trigger = "rc-feedback";
@@ -351,6 +354,7 @@ static int ttusbir_probe(struct usb_interface *intf,
 		kfree(tt);
 	}
 	rc_free_device(rc);
+	kfree(buffer);
 
 	return ret;
 }
@@ -373,6 +377,7 @@ static void ttusbir_disconnect(struct usb_interface *intf)
 	}
 	usb_kill_urb(tt->bulk_urb);
 	usb_free_urb(tt->bulk_urb);
+	kfree(tt->bulk_buffer);
 	usb_set_intfdata(intf, NULL);
 	kfree(tt);
 }
-- 
2.53.0


