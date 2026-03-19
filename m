Return-Path: <stable+bounces-227247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DXJHsfFu2n1ngIAu9opvQ
	(envelope-from <stable+bounces-227247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:45:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3E2C8F02
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 10:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01ADD3205505
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C063B5843;
	Thu, 19 Mar 2026 09:36:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBF3AE706
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912976; cv=none; b=F35pIsTvay+XRQzGdZ/IhdCfNHP5kKhoaUAMTczC2zY64wwpS4gVYxN3vbaRvJ/Oy+EynGan8INHAo5TMurygivlgeFivFdf9FQVk/XSBa2EYkE7Pa6OuAKGK8jAtA2BBVmQyVH8irpYNgqUEFIDicCkc/ya7tPvAzwJYDvyzwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912976; c=relaxed/simple;
	bh=osCbwNt4rlCqoKf9oNMoCVN+Bo1ssz2TIEALjOeK1Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kh89rQTGoibaZaq48B8IXeBNyECIVu+pfyw5Ge5kP9pzEMEJ5AP8B9DwmrqL4j5nZjOlgUhyq+ppTNj8qBjRVOper9tsFNI5QkpRWXcyood+7spr1Nf2rBGEzdVcHt4CHQaw7XlIPL1p/5VBU4hK6KUUBT8BbHJ3miPKmH/8Mjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0003OC-Pz; Thu, 19 Mar 2026 10:36:09 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-0013Db-10;
	Thu, 19 Mar 2026 10:36:09 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1w39nV-00000008yzO-0X4L;
	Thu, 19 Mar 2026 10:36:09 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 19 Mar 2026 10:35:58 +0100
Subject: [PATCH 01/11] net/9p/usbg: clear stale client pointer on close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-9pfixes-v1-1-c977a7433185@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6126;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=uTuribG64L7Kn1/cY5QOdK4+KwyXN53R3m83vAGWWBc=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpu8OFNxnYnhjDaAJZ3RftTxo1A9NdfnqO5MmAH
 W8ee74IBJ6JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCabvDhQAKCRC/aVhE+XH0
 q41KD/9ThZ80Dxo+iWqqKDkp0sMsVrIo0HLsIK1NfjKuPaUCeEXbvn+nsEwvZ6wosYWM7M6vp5f
 O8oHnGsiE6YZMjKbviUwRsTQ4wVFpfdRVQxIAmapuwbiKSP5PqdGX+7kNxxXueCWbKZx47Y1wdL
 PExwZFsycBrUhnrRTqDG7CrMVJF+uVciy/DJbWIMIsHGgTzEE1sd96LC6N7Il/An9hKgvi6dei1
 jY/fYgXRuyg5vF/h4PXd6FYBZJjDqXyN5Ur7Ale55iVsSgnXe6sYm+7mVXcepvSHN1Kbhbj8vDA
 7JIsWx+PHPUUqx3cyhxREpgojnri7sORPGfu5jenkF5B3OAG1z/f9J8ikQkpCJeGXZNLjfrUdwb
 7faxVxtaFygnxsUbWHseJLYA7S++mZEpZFQkPDCt0NHbphrxOO9IUN1ArEQZ3+8xFhKuImjuCyR
 xGrfUIKtDuwj5O7agEHl+VJBjljwAMFFbclahIoyMO9qI/vOIncfHqxdvLUuvfdOEQDB5A9SZac
 gjBihlnGPEyTn3ZHe/2z4muVSjVw7AkqUEt67kKSU3Lr2JGh8qUuPgkL+TUgKjixX5DitCFG2Au
 /sptCTUxgipqDkyEQ+pyr2y1Z78plOKnxUbdsVr0NTx3KeMOZBBhaMIxTikC4ztuI4ENzblhzmM
 w1W4JNxm2z3Ck+g==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_TO(0.00)[kernel.org,ionkov.net,codewreck.org,crudebyte.com,linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227247-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.945];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Queue-Id: 07F3E2C8F02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hyungjung Joo <jhj140711@gmail.com>

p9_usbg_close() tears down the client transport, but usb9pfs keeps
using usb9pfs->client from asynchronous TX and RX completion handlers.
A late completion can therefore dereference a client that has already
been freed during mount teardown.

Clear usb9pfs->client under usb9pfs->lock when closing the transport,
detach any pending TX request from in_req->context, and make the TX/RX
completion handlers bail out once the transport has been detached. This
keeps late completions from touching a freed or rebound p9_client.

Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/9p/trans_usbg.c | 61 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 1ce70338999c8c712ba298efa88c69e6372ac40f..f7a94572013e7d1015d75fb5dbdde5eb81f7d7d0 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -149,7 +149,8 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_usb9pfs *usb9pfs = ep->driver_data;
 	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
-	struct p9_req_t *p9_tx_req = req->context;
+	struct p9_client *client;
+	struct p9_req_t *p9_tx_req;
 	unsigned long flags;
 
 	/* reset zero packages */
@@ -165,18 +166,25 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
 		ep->name, req->status, req->actual, req->length);
 
 	spin_lock_irqsave(&usb9pfs->lock, flags);
-	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
+	client = usb9pfs->client;
+	p9_tx_req = req->context;
+	req->context = NULL;
 
-	p9_req_put(usb9pfs->client, p9_tx_req);
+	if (!client || !p9_tx_req)
+		goto unlock_complete;
 
-	req->context = NULL;
+	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
 
+	p9_req_put(client, p9_tx_req);
+
+unlock_complete:
 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
 	complete(&usb9pfs->send);
 }
 
-static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
+static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs,
+					  struct p9_client *client, void *buf)
 {
 	struct p9_req_t *p9_rx_req;
 	struct p9_fcall	rc;
@@ -202,7 +210,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		 "mux %p pkt: size: %d bytes tag: %d\n",
 		 usb9pfs, rc.size, rc.tag);
 
-	p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
+	p9_rx_req = p9_tag_lookup(client, rc.tag);
 	if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
 		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
 		return NULL;
@@ -212,7 +220,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		p9_debug(P9_DEBUG_ERROR,
 			 "requested packet size too big: %d for tag %d with capacity %zd\n",
 			 rc.size, rc.tag, p9_rx_req->rc.capacity);
-		p9_req_put(usb9pfs->client, p9_rx_req);
+		p9_req_put(client, p9_rx_req);
 		return NULL;
 	}
 
@@ -220,7 +228,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		p9_debug(P9_DEBUG_ERROR,
 			 "No recv fcall for tag %d (req %p), disconnecting!\n",
 			 rc.tag, p9_rx_req);
-		p9_req_put(usb9pfs->client, p9_rx_req);
+		p9_req_put(client, p9_rx_req);
 		return NULL;
 	}
 
@@ -231,8 +239,10 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_usb9pfs *usb9pfs = ep->driver_data;
 	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	struct p9_client *client;
 	struct p9_req_t *p9_rx_req;
 	unsigned int req_size = req->actual;
+	unsigned long flags;
 	int status = REQ_STATUS_RCVD;
 
 	if (req->status) {
@@ -241,9 +251,16 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
-	p9_rx_req = usb9pfs_rx_header(usb9pfs, req->buf);
-	if (!p9_rx_req)
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+	client = usb9pfs->client;
+	if (!client) {
+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
 		return;
+	}
+
+	p9_rx_req = usb9pfs_rx_header(usb9pfs, client, req->buf);
+	if (!p9_rx_req)
+		goto out_unlock;
 
 	if (req_size > p9_rx_req->rc.capacity) {
 		dev_err(&cdev->gadget->dev,
@@ -257,8 +274,11 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 
 	p9_rx_req->rc.size = req_size;
 
-	p9_client_cb(usb9pfs->client, p9_rx_req, status);
-	p9_req_put(usb9pfs->client, p9_rx_req);
+	p9_client_cb(client, p9_rx_req, status);
+	p9_req_put(client, p9_rx_req);
+
+out_unlock:
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
 	complete(&usb9pfs->received);
 }
@@ -416,7 +436,9 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 		client->status = Disconnected;
 	else
 		client->status = Connected;
+	spin_lock_irq(&usb9pfs->lock);
 	usb9pfs->client = client;
+	spin_unlock_irq(&usb9pfs->lock);
 
 	client->trans_mod->maxsize = usb9pfs->buflen;
 
@@ -427,18 +449,25 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 
 static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
 {
+	struct p9_client *client;
 	struct p9_req_t *req;
+	unsigned long flags;
 
-	guard(spinlock_irqsave)(&usb9pfs->lock);
+	spin_lock_irqsave(&usb9pfs->lock, flags);
+	client = usb9pfs->client;
+	usb9pfs->client = NULL;
+	req = usb9pfs->in_req ? usb9pfs->in_req->context : NULL;
+	if (usb9pfs->in_req)
+		usb9pfs->in_req->context = NULL;
+	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
-	req = usb9pfs->in_req->context;
-	if (!req)
+	if (!req || !client)
 		return;
 
 	if (!req->t_err)
 		req->t_err = -ECONNRESET;
 
-	p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
+	p9_client_cb(client, req, REQ_STATUS_ERROR);
 }
 
 static void p9_usbg_close(struct p9_client *client)

-- 
2.47.3


