Return-Path: <stable+bounces-227246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ErfFMPFu2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:45:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D8D2C8EFA
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8F0231FB44F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3977437D105;
	Thu, 19 Mar 2026 09:36:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7957E3AD522
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912975; cv=none; b=B7cSzIobFL3RBv1rss34hxmoi2kg9vjgtBAJjzsb/TN6/aw+sUv28aQFcJ5HFjMmPzUxOZRQZiDzuWMjcumnBjPQPCa4uAgqYjbP374tcdh4DwoVKTGkKepA3TMli4Nc4yDZrMFIeDUyotJJL5gGDb8BiZCXjNJtUQ0okLYldQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912975; c=relaxed/simple;
	bh=GwhJbEuTCOVggApqYyGjgB7lLVpCt5AR3VjWJLAj/YY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZKwxDvTeDDphjeaQ5cfWCtWA/A++4vyemTjw/m1NDlFm4ySHbyEa2BbF5IEe8wjLocB9Q/PjmvlD9VMK7ieBF5USxlY1ZTQSJkZxm/0Gm3nqD6tqr1Ynem4qObp7FCeADFP5qFNOr1weM1jAkfRt/AlrKRTCWh1e9nkrq1S1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003OE-PK; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013Dd-10;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0Z37;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:36:01 +0100
Subject: [PATCH 04/11] net/9p/usbg: always reset completion when
 disconnecting
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-4-c977a7433185@pengutronix.de>
References: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
In-Reply-To: <20260319-9pfixes-v1-0-c977a7433185@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hyungjung Joo <jhj140711@gmail.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=GwhJbEuTCOVggApqYyGjgB7lLVpCt5AR3VjWJLAj/YY=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OGl/49m44ghnblqGzoFWcTEqPrxmxyrQviR
 px2cLQqlGmJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhgAKCRC/aVhE+XH0
 qz5rEACmGjobhT+yZoyxqet+vbimlEULFN+sxQGY9nGhLThV5agCmNYBGW+5FzmgcDNKWvLTw5S
 p6f8cRftUwHDJlA2FqZsDNAr0IdJhLcYHKYLzHt4ms57LKbPJD2E+Fcg8r+hhk35mWnQfBH1vIT
 izS+tLkj+U4hkljTbqUBmvt4xASNRXQb3pkNZeSM0h+92De4KqQwBd/TSz9TUg/H53HuAiOF6E5
 7BUmvZxba50Da4VNUY08l8bjcRRt7OwIPskIaWPjst95kI2zvBe+T5txaJsuyN++Yqs4N5eyEP7
 3XqXpu3VK6NYkALrbyHSQqRrez59jHpp1E1xqe4oRN/atBRZFwAg6lXEFlYxQte8BY/EZZcJaXm
 YJCiqMyKjTGjjHRV6WfT3a9sJXnSGfEw2IutvYavTNNqhqFTRFQE+BXdb+UUXhhrC0O+X5/ng6q
 6U9JoPZUdDcE1orilA9dal3uxlrWPjoOT4J2Gr5OtzpDZgfQZn4H1hSEH2ySMl6FXuwwji2e6S4
 RYIbtULZP7w25qc4cOUS7+rq26xkmR3NuQvQicXBOxjSQY3gYP3f2uYC2m9Wy5rVXpOPfprefcM
 uElY23WXKr5iYbTqNi3b19c9jInJvKLFoQajbvsRnraswmeboYQYtS2LAQ6zqYkuOIebHp6t7S0
 JWDwAehY4/y9Y3g==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_TO(0.00)[kernel.org,ionkov.net,codewreck.org,crudebyte.com,linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227246-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.grzeschik@pengutronix.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5D8D2C8EFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When some tx or rx transfers were pending while closing the connection,
the completion handler could catch one pending completion call. To
ensure a normal start when mounting again, we have to reset the
completion and flush any pending completions.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/9p/trans_usbg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 6ddf6886dbadd7cdfdebb96dc767874169ccb16e..d6391db6d5d96a1609a3405646f66d82c93d35f1 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -497,6 +497,7 @@ static void p9_usbg_close(struct p9_client *client)
 	mutex_unlock(&usb9pfs_lock);
 
 	disable_usb9pfs(usb9pfs);
+	reinit_completion(&usb9pfs->send);
 }
 
 static int p9_usbg_request(struct p9_client *client, struct p9_req_t *p9_req)
@@ -786,6 +787,7 @@ static void usb9pfs_disable(struct usb_function *f)
 		usb9pfs->client->status = Disconnected;
 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 	usb9pfs_clear_tx(usb9pfs);
+	reinit_completion(&usb9pfs->send);
 }
 
 static struct usb_function *usb9pfs_alloc(struct usb_function_instance *fi)

-- 
2.47.3


