Return-Path: <stable+bounces-225368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL02FWhHtGk4kAAAu9opvQ
	(envelope-from <stable+bounces-225368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:20:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C735288032
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6F053048929
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689213CB2DE;
	Fri, 13 Mar 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtGiQyZA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AF386424
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773422242; cv=none; b=qEQvQVtfBmsI/d8pygrUzxdvlR0yU5RTMd6SmPfK7GXAb67h6RCsCCe796d0h/GzjAKVKmqv02oeBRfkALfctqFl3BtFpQQ0987ozU07mNuDwShZMvUvh/m72BNp7s41qTTa5OIXaZCocJBOSQPeSC4/+ndxMVf6+V0/eJLsV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773422242; c=relaxed/simple;
	bh=z9C/vbvIS5TY0XOjnQzdtr2PoKMmOdHy1mekRGEFKvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQQKgmxXGx8/u92xMXFegjiEVNSmDzyM/WFR8/Ir2l5c3O96muGIzeMt4JEpaNgEEiHVWXMBYfwNoD0/d6lzRuaZxqCUl86qd9d6qlsu2bRl5/Wrmbvto1EvJbBcFku7rwSOfcY4atUIySgHdpwdnBJ+bMjLW/Y91Ui97nyIKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtGiQyZA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so2275345b3a.3
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773422240; x=1774027040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWzkTz+o6MJ580k/Lw2tM48DPyYfCvZ1bzdyNrOoVFg=;
        b=NtGiQyZA8LCqzfI5qhVK/GxaYoZyXGBWIPro3Y3tRvat7f6FS8VJY8Qd0/wHeg1ANX
         2XpX4F5dHh3aaUUNsigfl+JAZ/ksBprkudlAM8B6/LJQYGTVFlF8gIGTh7xxY7Mg7W9q
         FV0zUWw1hvqqlr6SVN4C6MaZxvSXtP0zQKvkN8HdGDKHB91uK7CQWY9afWunewOe744d
         pwFPuXFUXJKFSeDWIsr/f8uipdCVhzESVPNnArk7Nxg/LLOLQzNkXs0cSmMrReS64Y4d
         YSP5eqEhzFXQ3sf51lXmG+rSQi/P8SS6p75B+kQWwie+2czMlZUscOx6VZxB0Hr6CWKO
         hHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773422240; x=1774027040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWzkTz+o6MJ580k/Lw2tM48DPyYfCvZ1bzdyNrOoVFg=;
        b=oVFV7ZoHqX5FnmzdPaKSl1E+ZvJqw72800JT0klJ5ZSPvdbHSRedq7m6M53Otx0578
         4LnIf1kowmCob4RVkZF2zhLXw7t1jYF793RuRMQi3eLTu198i3+PRQqLn40Xw7Inq4Ph
         X77NAYzCFoCnJfMoPfGR57A1Pj9zsxuqYJ4a9yvpNAWo5hZbiHugFxSMMerqLdJDE0BP
         yBo2dwkDP30ldNzfDfMUkfiiGHOUpAgCOiNRBQPKwRp8PNFgqOW1e68kfm8hHcbKrbKX
         kg7Vaog+cFW1mJm6yO16746cC+3TcpL477jqXzsnPTn34FEpY5eXxORQVoqwyCdYdnAo
         fW+A==
X-Forwarded-Encrypted: i=1; AJvYcCVGIGsskHYFq4t6reMGZFZzssRaaubPj1cgpNB7JxyNXRlgTy2TOz2msaKiTZ44R8bVcF4Ki+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfL/uL+pCsgbYWOLcInIqynp3nGw8Si/3R+5BM2a8fwQxdGw/
	4Tqo9nqA6UE9t+88tArd5WMJuUb5j4p/qFQlP87xbt52sf7vdS5zWZ2a
X-Gm-Gg: ATEYQzwTZdHIi0bZQHj071FnNXvM0SiK6vwA+1IZw2hdMG31wNg+0XlsBJpKPiZJR/X
	ep2FaHJQqVFxhPVtCHFCz3lnDnghuqxE3eKlIQsMGwsTKbnYovuxDUBtxZTTZ4mu0RIDH2u/IWq
	j5r1z5mGGi0a5ogMEisah5wlBgwsXA4MOVq4Rzp42CE5PMRv7W8fi8HqWuswwaHjwwVFJ4yo72H
	KwG15ttfH0uGyyFIDNRAA1mQxklMOrMQQlyf/8gnPd3oe3/2yau+sZap6i1WbQP+Ak2hn5wvEM8
	bmp3PwVKfwWFHCvSWJ6Voj/UvJ05sushQbyb6tIkC3pRDCE/1gv4mefe7dXIOxhA8tXCEVCF/PO
	b7tvbFBMwPg9iM4GKDNAQnJHbYeC3A5pBxEI7TPfjhykOTqjBcJDdmhVU9yEHoK4fMLeNutovbx
	vDsE7CHWY61D2hkGzECr4ygiJ2xF02bsk=
X-Received: by 2002:a05:6a00:9081:b0:827:3f01:d1ca with SMTP id d2e1a72fcca58-82a196d2facmr3485382b3a.4.1773422240081;
        Fri, 13 Mar 2026 10:17:20 -0700 (PDT)
Received: from JooHJ-PC.localdomain ([121.65.54.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0727f2fcsm6330485b3a.28.2026.03.13.10.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:17:19 -0700 (PDT)
From: Hyungjung Joo <jhj140711@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	m.grzeschik@pengutronix.de,
	gregkh@linuxfoundation.org,
	v9fs@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyungjung Joo <jhj140711@gmail.com>
Subject: [PATCH] net: 9p: usbg: clear stale client pointer on close
Date: Sat, 14 Mar 2026 02:16:59 +0900
Message-Id: <20260313171659.1225180-1-jhj140711@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[crudebyte.com,pengutronix.de,linuxfoundation.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-225368-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhj140711@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C735288032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 net/9p/trans_usbg.c | 63 +++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 1ce70338999c..3c2aa1943f93 100644
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
@@ -165,18 +166,27 @@ static void usb9pfs_tx_complete(struct usb_ep *ep, struct usb_request *req)
 		ep->name, req->status, req->actual, req->length);
 
 	spin_lock_irqsave(&usb9pfs->lock, flags);
-	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
+	client = usb9pfs->client;
+	p9_tx_req = req->context;
+	req->context = NULL;
 
-	p9_req_put(usb9pfs->client, p9_tx_req);
+	if (!client || !p9_tx_req) {
+		spin_unlock_irqrestore(&usb9pfs->lock, flags);
+		complete(&usb9pfs->send);
+		return;
+	}
 
-	req->context = NULL;
+	WRITE_ONCE(p9_tx_req->status, REQ_STATUS_SENT);
+
+	p9_req_put(client, p9_tx_req);
 
 	spin_unlock_irqrestore(&usb9pfs->lock, flags);
 
 	complete(&usb9pfs->send);
 }
 
-static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
+static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs,
+					  struct p9_client *client, void *buf)
 {
 	struct p9_req_t *p9_rx_req;
 	struct p9_fcall	rc;
@@ -202,7 +212,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		 "mux %p pkt: size: %d bytes tag: %d\n",
 		 usb9pfs, rc.size, rc.tag);
 
-	p9_rx_req = p9_tag_lookup(usb9pfs->client, rc.tag);
+	p9_rx_req = p9_tag_lookup(client, rc.tag);
 	if (!p9_rx_req || p9_rx_req->status != REQ_STATUS_SENT) {
 		p9_debug(P9_DEBUG_ERROR, "Unexpected packet tag %d\n", rc.tag);
 		return NULL;
@@ -212,7 +222,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		p9_debug(P9_DEBUG_ERROR,
 			 "requested packet size too big: %d for tag %d with capacity %zd\n",
 			 rc.size, rc.tag, p9_rx_req->rc.capacity);
-		p9_req_put(usb9pfs->client, p9_rx_req);
+		p9_req_put(client, p9_rx_req);
 		return NULL;
 	}
 
@@ -220,7 +230,7 @@ static struct p9_req_t *usb9pfs_rx_header(struct f_usb9pfs *usb9pfs, void *buf)
 		p9_debug(P9_DEBUG_ERROR,
 			 "No recv fcall for tag %d (req %p), disconnecting!\n",
 			 rc.tag, p9_rx_req);
-		p9_req_put(usb9pfs->client, p9_rx_req);
+		p9_req_put(client, p9_rx_req);
 		return NULL;
 	}
 
@@ -231,8 +241,10 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_usb9pfs *usb9pfs = ep->driver_data;
 	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
+	struct p9_client *client;
 	struct p9_req_t *p9_rx_req;
 	unsigned int req_size = req->actual;
+	unsigned long flags;
 	int status = REQ_STATUS_RCVD;
 
 	if (req->status) {
@@ -241,9 +253,16 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
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
@@ -257,8 +276,11 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 
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
@@ -416,7 +438,9 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 		client->status = Disconnected;
 	else
 		client->status = Connected;
+	spin_lock_irq(&usb9pfs->lock);
 	usb9pfs->client = client;
+	spin_unlock_irq(&usb9pfs->lock);
 
 	client->trans_mod->maxsize = usb9pfs->buflen;
 
@@ -427,18 +451,25 @@ static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 
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
2.34.1

