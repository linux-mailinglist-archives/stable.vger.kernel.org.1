Return-Path: <stable+bounces-261666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PZz+IS5PJWoFGwIAu9opvQ
	(envelope-from <stable+bounces-261666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:59:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4401650345
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:59:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dxzDFj5Z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261666-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261666-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39DF730959F5
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA22E30C153;
	Sun,  7 Jun 2026 10:50:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4B2D8378;
	Sun,  7 Jun 2026 10:50:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829404; cv=none; b=JK2RK/LaQAKm0nlmzQiYAcKgd7VFUs9x3fQiSjzHqP/u5BH0NGXtaEv9TjSCS4/IPAANeT/jTHS+HxSx2qL239P/xH5TcnXwPKNUX+8Y3VlTbUYmTUvC/wO98lsxftF8Ku/rl11HBTHEsFxB9U5M/95/apingLpPYpqyXT1lN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829404; c=relaxed/simple;
	bh=PzWQ/qh8PtmNxocsCEZTGpIC6ZC0Hp7n78HAKIiUfJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QV1sMMA6jJ803mwk6KKqmWDYzqoI46nABv9UvY1mfGgD0gLvo0D7RnFMefty/lTtLwG84QwZqq9zPXrhW8fNN/FnH9pAm6sUUMjN5GO6LD2s1yo2Y4PxPcbv6E8V/7jvDrSdSa02owCTDQfEaIl5J6ynn6rDY+fDOLMlWgfiri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dxzDFj5Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120A71F00893;
	Sun,  7 Jun 2026 10:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829403;
	bh=oYJwRtJO4sfiTff5UajtZGBbxHxS1NukCaHI8flAXhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dxzDFj5ZjcPdbSI/UYMlaI+gj1tKLRMcW/XCYqKfMaJaIqjBej5FRpq+mj1usXZ1g
	 VHTxZIREeZtLDl+veQgeSAmY03hk0xT2V2WLjp8r5eTg4zMIFE80Q5BeYqZdYjgCNe
	 kSUDF3ZHxAaQzC1GxbZwhevuGHyKd3XieRcuElQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	Heitor Alves de Siqueira <halves@igalia.com>
Subject: [PATCH 6.12 221/307] usb: usbtmc: reject interrupt endpoints with small wMaxPacketSize
Date: Sun,  7 Jun 2026 12:00:18 +0200
Message-ID: <20260607095735.829207870@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261666-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:michal.pecio@gmail.com,m:halves@igalia.com,m:michalpecio@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,igalia.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4401650345

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heitor Alves de Siqueira <halves@igalia.com>

commit 121d2f682ba912b1427cddca7cf84840f41cc620 upstream.

The USB488 subclass specification requires interrupt wMaxPacketSize to
be 0x02, unless the device sends vendor-specific notifications.
Endpoints that advertise less than 2 bytes for wMaxPacketSize are
unlikely to work with the current driver, as URBs will not have enough
space for interrupt headers. Considering that any notification URBs will
be ignored by the driver, reject these endpoints early during probe.

Fixes: 041370cce889 ("USB: usbtmc: refactor endpoint retrieval")
Cc: stable <stable@kernel.org>
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
Link: https://patch.msgid.link/20260505-usbtmc-iin-size-v3-2-a36113f62db7@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/usbtmc.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -2444,6 +2444,12 @@ static int usbtmc_probe(struct usb_inter
 		data->iin_ep = int_in->bEndpointAddress;
 		data->iin_wMaxPacketSize = usb_endpoint_maxp(int_in);
 		data->iin_interval = int_in->bInterval;
+		/* wMaxPacketSize should be 0x02 or more as per USB488 Table 22 */
+		if (iface_desc->desc.bInterfaceProtocol == 1 &&
+		    data->iin_wMaxPacketSize < 2) {
+			retcode = -EINVAL;
+			goto err_put;
+		}
 		dev_dbg(&intf->dev, "Found Int in endpoint at %u\n",
 				data->iin_ep);
 	}



