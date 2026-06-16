Return-Path: <stable+bounces-266058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l+qXAaKVMWrCnQUAu9opvQ
	(envelope-from <stable+bounces-266058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:27:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 119E969423F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:27:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=QlwIWAxu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266058-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-266058-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0AE83017CD8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D33477986;
	Tue, 16 Jun 2026 18:27:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B943D75A4;
	Tue, 16 Jun 2026 18:27:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634441; cv=none; b=o97EyVaTrWCYRmJCOuc+Df+5CKm944I4pARw488EZsdL6MBUHqN/xpxRS9TuQPn8Z0dMwwq6vhV6OwfFutTtwWSZ5TDAGFRY5f07P1NnAKmseNnGUwE/WBFEwVznHCxFQUNrXih0O9ZGWOvVL6QXbtcE7h7YRIc7OJJATnTVrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634441; c=relaxed/simple;
	bh=qr+BawgZD0dzwDKmF9NNSw7HheRAswcSzP2tFhxz2Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rpb1OiZBuQoqnljUVVFqc5SbRXtMqB4UOpY4Fuxg6Zc7bMMR03sULq1ozmFSp48kQPCFkCmwxzG1Gsa/Ezfu5AICLKq39JalmNE9938yXhURMCHfLG3LJQ7niKV/77CF+03+72crDo8EFa26ZfTxuM3uv8NhsX/6SUCftey7MOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QlwIWAxu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E221F000E9;
	Tue, 16 Jun 2026 18:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634440;
	bh=QY5Aj3w2m3Y9xvomY7llchmjh7ScoypKW2N60NKuGaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QlwIWAxuiPdJkee+d7OVHvZUDKDIQHXwlaGnU2T4jh937+FicAea9aXVnKtlCD7Xs
	 FH7rriZGWb1DlUI7fS8vaQS5qdGGijq65ijygXxgAETP64b8CqrudO+rdhSSGlOoZp
	 0CmiaSQ7jlVXHnircWF6OV5x5IqgbbHMvmP7Et+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 266/411] media: rc: ttusbir: respect DMA coherency rules
Date: Tue, 16 Jun 2026 20:28:24 +0530
Message-ID: <20260616145115.210727047@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266058-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:oneukum@suse.com,m:sean@mess.org,m:hverkuil+cisco@kernel.org,m:sashal@kernel.org,m:hverkuil@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 119E969423F

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/ttusbir.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

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
@@ -188,13 +188,16 @@ static int ttusbir_probe(struct usb_inte
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
@@ -283,8 +286,8 @@ static int ttusbir_probe(struct usb_inte
 	tt->bulk_buffer[3] = 0x01;
 
 	usb_fill_bulk_urb(tt->bulk_urb, tt->udev, usb_sndbulkpipe(tt->udev,
-		tt->bulk_out_endp), tt->bulk_buffer, sizeof(tt->bulk_buffer),
-						ttusbir_bulk_complete, tt);
+			  tt->bulk_out_endp), tt->bulk_buffer, 5,
+			  ttusbir_bulk_complete, tt);
 
 	tt->led.name = "ttusbir:green:power";
 	tt->led.default_trigger = "rc-feedback";
@@ -353,6 +356,7 @@ out:
 		kfree(tt);
 	}
 	rc_free_device(rc);
+	kfree(buffer);
 
 	return ret;
 }
@@ -375,6 +379,7 @@ static void ttusbir_disconnect(struct us
 	}
 	usb_kill_urb(tt->bulk_urb);
 	usb_free_urb(tt->bulk_urb);
+	kfree(tt->bulk_buffer);
 	usb_set_intfdata(intf, NULL);
 	kfree(tt);
 }



