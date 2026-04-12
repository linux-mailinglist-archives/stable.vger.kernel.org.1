Return-Path: <stable+bounces-235808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id af6xF3qJ22l4DAkAu9opvQ
	(envelope-from <stable+bounces-235808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:00:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBE3E3B1F
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09B9B300B859
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 12:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62933258CD0;
	Sun, 12 Apr 2026 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQx7+D/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DA237B409
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995204; cv=none; b=seG2ly44Nwo5RWV3Nevp5H0/r6TYZMkS8zNKK7GnhKDZmyocEyiaJN/VogHq8GJDTxVpQzj4i9maPElx/nocCPtulhDp8SV7+cx0kX2wT9RCorQ2k1exSQ5yxP9txr4NaHD6Uv5+UHyIDxuCXFSYrzd/ASGmuXxQy2F7l1M6Sbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995204; c=relaxed/simple;
	bh=N49dKV3PD2oEa//TiAOA4ONTh/tS5mfmxWTFO5KOO9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMOUXABK3A5IUXe89B7rbniaQF6ie+nxS07vaqQcmeH0PJ3r7h7b2N8qsGFw4Q/nm7izrBVI9woUckCLIX9Fx+qDvY49jHhrnai0k1gi/ILtKzoaw2Tkv7u9qMHWnOiuttd83C6aEjBdJEWhFM/EqB2utuIP/zyNEP83LGE72AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQx7+D/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A27C19424;
	Sun, 12 Apr 2026 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775995203;
	bh=N49dKV3PD2oEa//TiAOA4ONTh/tS5mfmxWTFO5KOO9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQx7+D/9EhIWhndpYwjiIrdSJKO20Wef9M4dvViuOuYy9NZqQ2hTVw0H6U0RQ3m/w
	 SAEsX4RgNKDsHdPQR7rT4d7iik4nBRX6EjR7N+F3Xy8SqdcFzHRcXAAbG/AZx6gI69
	 YajPvz2BquR16QaKdIGgYAs5R0cN9Ntd2Bf7yEgAzosSkMdFXIBY2BVXIj4eVA3qix
	 5hqQSTnXZgmeINmr6ZcaSYbQaCp31h946Gnazel8rTM/L5ffYJ0dSlxJDj9XeFCsWv
	 p8Ax10D/MU76OuqrJ3u58GNAgFexRsg1fx2trHcAk1glMC5BRyx2nOEvXIQDKXG2PP
	 p+SSRkYr5VHSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: gadget: f_hid: move list and spinlock inits from bind to alloc
Date: Sun, 12 Apr 2026 08:00:00 -0400
Message-ID: <20260412120000.2096246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040827-jitters-comic-f139@gregkh>
References: <2026040827-jitters-comic-f139@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235808-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,msgid.link:url]
X-Rspamd-Queue-Id: C1DBE3E3B1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Zimmermann <sigmaepsilon92@gmail.com>

[ Upstream commit 4e0a88254ad59f6c53a34bf5fa241884ec09e8b2 ]

There was an issue when you did the following:
- setup and bind an hid gadget
- open /dev/hidg0
- use the resulting fd in EPOLL_CTL_ADD
- unbind the UDC
- bind the UDC
- use the fd in EPOLL_CTL_DEL

When CONFIG_DEBUG_LIST was enabled, a list_del corruption was reported
within remove_wait_queue (via ep_remove_wait_queue). After some
debugging I found out that the queues, which f_hid registers via
poll_wait were the problem. These were initialized using
init_waitqueue_head inside hidg_bind. So effectively, the bind function
re-initialized the queues while there were still items in them.

The solution is to move the initialization from hidg_bind to hidg_alloc
to extend their lifetimes to the lifetime of the function instance.

Additionally, I found many other possibly problematic init calls in the
bind function, which I moved as well.

Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260331184844.2388761-1-sigmaepsilon92@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 1293bc9157087..f8cc26af702c9 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -996,13 +996,8 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	if (status)
 		goto fail;
 
-	spin_lock_init(&hidg->write_spinlock);
 	hidg->write_pending = 1;
 	hidg->req = NULL;
-	spin_lock_init(&hidg->read_spinlock);
-	init_waitqueue_head(&hidg->write_queue);
-	init_waitqueue_head(&hidg->read_queue);
-	INIT_LIST_HEAD(&hidg->completed_out_req);
 
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
@@ -1272,6 +1267,12 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	mutex_lock(&opts->lock);
 	++opts->refcnt;
 
+	spin_lock_init(&hidg->write_spinlock);
+	spin_lock_init(&hidg->read_spinlock);
+	init_waitqueue_head(&hidg->write_queue);
+	init_waitqueue_head(&hidg->read_queue);
+	INIT_LIST_HEAD(&hidg->completed_out_req);
+
 	device_initialize(&hidg->dev);
 	hidg->dev.release = hidg_release;
 	hidg->dev.class = hidg_class;
-- 
2.53.0


