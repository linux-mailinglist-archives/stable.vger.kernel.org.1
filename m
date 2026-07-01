Return-Path: <stable+bounces-270129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c8PpAWzsRGo73QoAu9opvQ
	(envelope-from <stable+bounces-270129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:31:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E68FF6EC2A7
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:31:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=aKNOVojN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270129-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270129-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35CEF30696A7
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7F440FDA5;
	Wed,  1 Jul 2026 10:18:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1AA40E8E5
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:18:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901123; cv=none; b=CFIFtVXcly9BCeplU2SFTttgEPAzmwjQ93rmABgk6FKAhuABjpA7RHChTJQ2oIt30E5ZOOh0r1Yz/ywbtoa+r07b/PCBAZVQmTSx9tXzeffBdtUUGVtNuQS/G4acCfDvg5+jdD4b7JgJLlmxXqkASBl72a+Pk2U24V15q03EPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901123; c=relaxed/simple;
	bh=dTmqjJ1A0rx0L3Yz5VKymYbyJYy+f3YeiDTHTuNs6Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T37TSwGpNQCJDqJjCE3XzKZyRU1sJj0jGSWT/2fy5zn925T0sZ5bO4s2Dc4mFyzxv6nRZ4iS3SW0bh64Kb4t7bIB72VLGJ6ksgjbRYx2iWozQbq+drd/h7b01onZt+gDgoFgMcUJjOfWb6btdo4VDxOZnceE8cEolK1XdlXxTAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKNOVojN; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782901120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3K0jYSno9pP21YqICBjADCSbE+ZxELgscbZYlBI/F54=;
	b=aKNOVojNM442gZrE54TIISg5xgxbbPkMcDMn8xOguU7z7QY9l8LIPj/sLz4M+c79OYszrC
	ZP+iPnHC9kwSBKFrQm2Bbvl8J/NAe8c/B0JErFxG5YWK/CD0Axef04v7p2vqw6BCu5bGuc
	V0ot5GjxfzZQp8Ks/7KIFIA2c7zBfC4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-7aHYyTceN7mOHTTJYLjKJQ-1; Wed,
 01 Jul 2026 06:18:37 -0400
X-MC-Unique: 7aHYyTceN7mOHTTJYLjKJQ-1
X-Mimecast-MFC-AGG-ID: 7aHYyTceN7mOHTTJYLjKJQ_1782901116
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FF4A195C242;
	Wed,  1 Jul 2026 10:18:36 +0000 (UTC)
Received: from nixos.redhat.com (unknown [10.44.49.208])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D03D36936;
	Wed,  1 Jul 2026 10:18:33 +0000 (UTC)
From: Sascha Grunert <sgrunert@redhat.com>
To: linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sascha Grunert <sgrunert@redhat.com>
Subject: [PATCH 2/2] usbip: block SET_INTERFACE for isoc alt settings
Date: Wed,  1 Jul 2026 12:18:26 +0200
Message-ID: <20260701101826.894848-3-sgrunert@redhat.com>
In-Reply-To: <20260701101826.894848-1-sgrunert@redhat.com>
References: <20260701101826.894848-1-sgrunert@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zenithal.me,linuxfoundation.org,vger.kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270129-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[sgrunert@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-usb@vger.kernel.org,m:valentina.manea.m@gmail.com,m:shuah@kernel.org,m:i@zenithal.me,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:sgrunert@redhat.com,m:valentinamaneam@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgrunert@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E68FF6EC2A7

USB/IP cannot forward isochronous transfers. When the client activates
an alt setting with isoc endpoints, the transfers fail with -EPROTO and
the resulting usb_clear_halt cascade disconnects the device.

Intercept SET_INTERFACE in tweak_set_interface_cmd() and fake success
when the target alt setting contains isoc endpoints, keeping the device
at alt 0.

Tested with a Turtle Beach Velocity One Flight yoke (10f5:7001)
forwarded to a VM via USB/IP, which previously disconnect-looped every
few seconds and now stays connected.

Cc: stable@vger.kernel.org
Signed-off-by: Sascha Grunert <sgrunert@redhat.com>
---
 drivers/usb/usbip/stub_rx.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index d0e3d3f..f323b48 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -100,6 +100,28 @@ static int tweak_clear_halt_cmd(struct urb *urb)
 	return ret;
 }
 
+static bool altsetting_has_isoc(struct usb_device *udev, __u16 interface,
+				__u16 alternate)
+{
+	struct usb_interface *intf;
+	struct usb_host_interface *alt;
+	int i;
+
+	intf = usb_ifnum_to_if(udev, interface);
+	if (!intf)
+		return false;
+
+	alt = usb_altnum_to_altsetting(intf, alternate);
+	if (!alt)
+		return false;
+
+	for (i = 0; i < alt->desc.bNumEndpoints; i++) {
+		if (usb_endpoint_xfer_isoc(&alt->endpoint[i].desc))
+			return true;
+	}
+	return false;
+}
+
 static int tweak_set_interface_cmd(struct urb *urb)
 {
 	struct usb_ctrlrequest *req;
@@ -111,6 +133,20 @@ static int tweak_set_interface_cmd(struct urb *urb)
 	alternate = le16_to_cpu(req->wValue);
 	interface = le16_to_cpu(req->wIndex);
 
+	/*
+	 * USB/IP cannot forward isochronous transfers.  If the requested
+	 * alt setting activates isochronous endpoints, pretend the switch
+	 * succeeded without touching the device.  This prevents the
+	 * cascade of failed isoc URBs that leads to a device disconnect.
+	 */
+	if (alternate != 0 && altsetting_has_isoc(urb->dev, interface,
+						  alternate)) {
+		dev_info(&urb->dev->dev,
+			 "usb_set_interface blocked: inf %u alt %u (isoc)\n",
+			 interface, alternate);
+		return 0;
+	}
+
 	usbip_dbg_stub_rx("set_interface: inf %u alt %u\n",
 			  interface, alternate);
 
-- 
2.52.0


