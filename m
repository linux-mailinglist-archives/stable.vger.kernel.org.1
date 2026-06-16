Return-Path: <stable+bounces-264883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zuPbKPd9MWoDkwUAu9opvQ
	(envelope-from <stable+bounces-264883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:46:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ACE692715
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:46:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=MFWVKCnA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264883-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264883-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5946301BB94
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796735AC3E;
	Tue, 16 Jun 2026 16:46:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026732C302;
	Tue, 16 Jun 2026 16:46:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628392; cv=none; b=GCwjyHb7HDp35yIXFYtE+VmvD1poOwyd3WK5ODnkpi/ZWRUBVmbCbRKT9Gq3InuQ6UKqRDT/Wp66fxkYB1Auv0DYS50HFFCfZP0cIb4VJeIax2dSFJJ/8nurXcv/1Rd52GNPbyUXXhghMn1yclzJUjJYBe65DoMR8n3kUXFJRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628392; c=relaxed/simple;
	bh=OqApRGEQcRTYy9vkYvldrvokMwGtBt3x8qpuhv8Dh/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYLRCd4uvGGkgEVgN1D4M7cSbydg1OLpHAZ2MMO659IK7CCRrWUsmP+hJhA7GHL3ZxOgJvZE0jE35lzvbCYJ3EHvIo19tKy3aw5713ji0xHmDWZovkIQ+t9cgDAW/sS8dnUWzYjwz8jmBEd0go8rqYhRhDYl/y3hf5KyAmihviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MFWVKCnA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CEA1F000E9;
	Tue, 16 Jun 2026 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628391;
	bh=09/y65FGHyqtscc6E3KrnLGmJijU9UpcPCHrzBwi8EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MFWVKCnAfVPFRDdDEJFSX/rx8HbGfCJF3OA4wWaDB/EPfT15JvybNb8+SRjqv6Cwo
	 9Ckwaq1JMLJo6n/ljQKOXq8PK7HQlxwfdRuFn+wCAAe2POrIwKh+UspbrP77b2YDPY
	 WJ0MDqILN7wZAZ//Ba1e3Pm/MibHpeiYvNwWYYwc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.6 087/452] usb: typec: tcpm/tcpci_maxim: validate header NDO against RX_BYTE_CNT
Date: Tue, 16 Jun 2026 20:25:14 +0530
Message-ID: <20260616145122.421406406@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264883-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:heikki.krogerus@linux.intel.com,m:andre.draszik@linaro.org,m:badhri@google.com,m:amitsd@google.com,m:stable@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,intel.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39ACE692715

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit aa2f716327be1818e1cb156da8a2844804aaec2f upstream.

A broken/malicious port can transmit a CRC-valid frame whose header
advertises up to seven data objects but whose body carries fewer than
that.  Check for this, and rightfully reject the message, instead of
reading from uninitialized stack memory.

Assisted-by: gkh_clanker_t1000
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Badhri Jagan Sridharan <badhri@google.com>
Cc: Amit Sunil Dhamne <amitsd@google.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/2026051350-sitter-canopener-9045@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -165,6 +165,15 @@ static void process_rx(struct max_tcpci_
 	rx_buf_ptr = rx_buf + TCPC_RECEIVE_BUFFER_RX_BYTE_BUF_OFFSET;
 	msg.header = cpu_to_le16(*(u16 *)rx_buf_ptr);
 	rx_buf_ptr = rx_buf_ptr + sizeof(msg.header);
+
+	if (count < TCPC_RECEIVE_BUFFER_RX_BYTE_BUF_OFFSET + sizeof(msg.header) +
+		    pd_header_cnt_le(msg.header) * sizeof(msg.payload[0])) {
+		max_tcpci_write16(chip, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
+		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d for header cnt %d\n",
+			count, pd_header_cnt_le(msg.header));
+		return;
+	}
+
 	for (payload_index = 0; payload_index < pd_header_cnt_le(msg.header); payload_index++,
 	     rx_buf_ptr += sizeof(msg.payload[0]))
 		msg.payload[payload_index] = cpu_to_le32(*(u32 *)rx_buf_ptr);



