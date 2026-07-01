Return-Path: <stable+bounces-270130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1FjkBbvpRGoN3AoAu9opvQ
	(envelope-from <stable+bounces-270130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:19:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E486EC0A5
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 12:19:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Re+bCBG9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270130-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270130-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24056304B271
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBFA411673;
	Wed,  1 Jul 2026 10:18:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAE40BCC9
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 10:18:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782901124; cv=none; b=K11VMqqKZ+Lai54q9sAgEh8uuX5GFIubFGA9U21/u9yn2LAiRLeTkukKWN5rixxHe/W+N4YjvZbH8vjrqlcvab46BezdiJjKvBiFqqZpSkqGtYC2XDMSdUwkgbil6tZZQhkBZJdN/iSVuDmgNS409np/qqlshpc0JRhEXcyg4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782901124; c=relaxed/simple;
	bh=/VmhbYzCS6eDKZXe2njWV1zyejy53Cf7/VfGl6cwv7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3O7eQzKEy5gUX9dqYPCowHJAe4SqGWazk85G5eCIpXDc66mq3vhOWTzVOeIJAUXlxmemvvGgSKL0AcJPUUQ+bke/xgLqmTrOlkxhMAEg4FJIsWCmKG8c9By4JU4v7i8uNYCWM1bb/vNMt9CnrVdiFHEE5jP5031fXonRnAcwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Re+bCBG9; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782901120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVo9xWqcp3+zcVgFIG4G4vrNjsMp5E1zzhatU2EMl58=;
	b=Re+bCBG9DWF8nqF/XoxDb4w739Jncd0Kh61qeHE/55TN85UsivMpEdY3MnxpReU5DwO+Pd
	O/T7e21+El/Bejkaau7yHODrcwInRqJFLj9UO9wC2TNjFacoXTejhucVGCjHzflwjrXpny
	8P2SAKG5YDukCWGX5VYOSF3SU2YZUcQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-LY5cMxLqNVmUdiUTAncdXw-1; Wed,
 01 Jul 2026 06:18:35 -0400
X-MC-Unique: LY5cMxLqNVmUdiUTAncdXw-1
X-Mimecast-MFC-AGG-ID: LY5cMxLqNVmUdiUTAncdXw_1782901114
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF56D1879598;
	Wed,  1 Jul 2026 10:18:33 +0000 (UTC)
Received: from nixos.redhat.com (unknown [10.44.49.208])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51AF136936;
	Wed,  1 Jul 2026 10:18:31 +0000 (UTC)
From: Sascha Grunert <sgrunert@redhat.com>
To: linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sascha Grunert <sgrunert@redhat.com>
Subject: [PATCH 1/2] usbip: drain remaining PDU payload on rejected endpoint
Date: Wed,  1 Jul 2026 12:18:25 +0200
Message-ID: <20260701101826.894848-2-sgrunert@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zenithal.me,linuxfoundation.org,vger.kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270130-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2E486EC0A5

When get_pipe() returns -1, stub_recv_cmd_submit() bails out without
reading the transfer buffer and ISO descriptors that follow the PDU
header on the TCP stream. The next recv() parses leftover payload as a
PDU header, desyncs the stream, and kills the connection.

Consume those trailing bytes before the early return so the stream
stays in sync.

Fixes: 635f545a7e8b ("usbip: fix stub_rx: get_pipe() to validate endpoint number")
Cc: stable@vger.kernel.org
Signed-off-by: Sascha Grunert <sgrunert@redhat.com>
---
 drivers/usb/usbip/stub_rx.c | 60 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
index 1e9ae57..d0e3d3f 100644
--- a/drivers/usb/usbip/stub_rx.c
+++ b/drivers/usb/usbip/stub_rx.c
@@ -461,6 +461,62 @@ static int stub_recv_xbuff(struct usbip_device *ud, struct stub_priv *priv)
 	return ret;
 }
 
+/*
+ * When get_pipe() rejects an endpoint (e.g. an isochronous endpoint that
+ * does not exist in the current alt setting), the transfer buffer and ISO
+ * packet descriptors that follow the PDU header on the TCP stream must
+ * still be consumed.  Without this the next recv() interprets leftover
+ * payload bytes as a PDU header, desynchronises the stream, and tears
+ * down the connection.
+ */
+static void stub_recv_cmd_submit_drain(struct usbip_device *ud,
+				       struct usbip_header *pdu)
+{
+	int bufsz, ret, np;
+	void *buf;
+
+	if (pdu->base.direction == USBIP_DIR_OUT) {
+		bufsz = pdu->u.cmd_submit.transfer_buffer_length;
+		if (bufsz > 0) {
+			buf = kzalloc(min_t(int, bufsz, PAGE_SIZE),
+				      GFP_KERNEL);
+			if (!buf) {
+				usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
+				return;
+			}
+			while (bufsz > 0) {
+				int chunk = min_t(int, bufsz, PAGE_SIZE);
+
+				ret = usbip_recv(ud->tcp_socket, buf, chunk);
+				if (ret != chunk) {
+					kfree(buf);
+					usbip_event_add(ud,
+							SDEV_EVENT_ERROR_TCP);
+					return;
+				}
+				bufsz -= chunk;
+			}
+			kfree(buf);
+		}
+	}
+
+	np = pdu->u.cmd_submit.number_of_packets;
+	if (np > 0 && np <= USBIP_MAX_ISO_PACKETS) {
+		bufsz = np * sizeof(struct usbip_iso_packet_descriptor);
+		buf = kzalloc(bufsz, GFP_KERNEL);
+		if (!buf) {
+			usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
+			return;
+		}
+		ret = usbip_recv(ud->tcp_socket, buf, bufsz);
+		kfree(buf);
+		if (ret != bufsz) {
+			usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
+			return;
+		}
+	}
+}
+
 static void stub_recv_cmd_submit(struct stub_device *sdev,
 				 struct usbip_header *pdu)
 {
@@ -479,8 +535,10 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
 	int ret, i;
 	int is_tweaked;
 
-	if (pipe == -1)
+	if (pipe == -1) {
+		stub_recv_cmd_submit_drain(ud, pdu);
 		return;
+	}
 
 	/*
 	 * Smatch reported the error case where use_sg is true and buf_len is 0.
-- 
2.52.0


