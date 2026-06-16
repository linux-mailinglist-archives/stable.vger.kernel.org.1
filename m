Return-Path: <stable+bounces-265548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0YBICXuMMWpYmQUAu9opvQ
	(envelope-from <stable+bounces-265548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:48:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 785E56937FE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:48:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Li8rMHd8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265548-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265548-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A26AC3079AD4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B1344044;
	Tue, 16 Jun 2026 17:42:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A803A5E91;
	Tue, 16 Jun 2026 17:42:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631759; cv=none; b=M/m1LrGkC6g6msL5d3XL4AqO/AAkuDbyAl49ieh/haUq+7Vm/SnF56ML4Dv62xRj1/yIvD+dXm+YIJUsKhhYFqyU/AHj9uSUn3qM24FvZJBesEocBpE/t+YvqV7Shg+qJ0Ac3bgWjfGIzRSMX26cnrmp9bA3JmedZSOHvvRSE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631759; c=relaxed/simple;
	bh=+PN8f3NK+Zs8Wh+psyDla8qoBl4COEJwMzue7T80+OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzxM981ohokdK2hDkCRHXs2/0lPGhZBNp/aL/ckvByrUbkh6KGtB0ou6mZp51S2ll4eIOVZ82SR6Ln5dXorVKzSd1bqlDXRhbuZLu2ILT1SCJ9HjCol9NGMdoxpPN5UCLVJm91LLqPI2Oq1uHUetRqfB232tCy96VlEOGTtVC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Li8rMHd8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0771F000E9;
	Tue, 16 Jun 2026 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631757;
	bh=Ug8SFWMTa1Qe5V+Oyiq7bkt075lDxYR8ZEZckdsD2vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Li8rMHd8xXuReZxcfj8nlLOK/Yg9pG9MdEGCUy0K3wi7uZRJynDEKfPstL8smjujE
	 ab5/exDCOWA8IJBP30Dhsu9Ol9LpWY30fdampv3h75VV8e8CmrkOF9zr4gdE1yk5dN
	 glYPpnGF1RybxiyxZpI/OCxJ0/xNuaLzC7HlAlmA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 250/522] r8152: handle the return value of usb_reset_device()
Date: Tue, 16 Jun 2026 20:26:37 +0530
Message-ID: <20260616145137.668348265@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265548-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:hsu.chih.kai@realtek.com,m:hayeswang@realtek.com,m:andrew@lunn.ch,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,realtek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 785E56937FE

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chih Kai Hsu <hsu.chih.kai@realtek.com>

[ Upstream commit 19440600e729d4f74a42591a872099cf25c7d28a ]

If usb_reset_device() returns a negative error code, stop the
process of probing.

Fixes: 10c3271712f5 ("r8152: disable the ECM mode")
Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Reviewed-by: Hayes Wang <hayeswang@realtek.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20260604092247.27158-450-nic_swsd@realtek.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index e8a69d3d418379..c0f7a15e406fee 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9754,7 +9754,12 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	struct net_device *netdev;
 	int ret;
 
-	usb_reset_device(udev);
+	ret = usb_reset_device(udev);
+	if (ret < 0) {
+		dev_err(&intf->dev, "USB reset failed, errno=%d\n", ret);
+		return ret;
+	}
+
 	netdev = alloc_etherdev(sizeof(struct r8152));
 	if (!netdev) {
 		dev_err(&intf->dev, "Out of memory\n");
-- 
2.53.0




