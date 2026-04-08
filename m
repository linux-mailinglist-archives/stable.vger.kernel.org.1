Return-Path: <stable+bounces-234950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB41CAup1mlKHAgAu9opvQ
	(envelope-from <stable+bounces-234950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:14:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B11393C29F1
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F035315F53A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295F23D75C3;
	Wed,  8 Apr 2026 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EOdL1utR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC4E337B81;
	Wed,  8 Apr 2026 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674182; cv=none; b=E/2uKGxsJZQqtbHcjfT3bBlnQWsl4Rhn3FIpj79CmbTdAjhqRJyRxrymp1lMDXL17wvthR0kI4YeIVsNCG2pR9ys2RfdigtTRYyswYG0tqZbKF6sFlOmVTfEdlUILVIW1v9cxzvHgIK+Byw1YUoP4cZpm2xtGCtyOIOC/OgnEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674182; c=relaxed/simple;
	bh=P496sRTi6lsdggDKtqSRDm3a5YqFh7IgeJC7tpBYVKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNkloPhdQEZur4SEKsgDYIwekGB8jNYWJEvXfFib/uiVaWMPrOP1otqJGSNVqjVhXta54nNrqt+dGxWdVXoV8t5Sy5pEMNS7slgfqY3OCzWlQfjBjZ4c5jNLkRyCXtdl8Mle1K7k9OaUhiKbtikT4PGbe3Wp3Uh7ZUsn51n66eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EOdL1utR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75667C19421;
	Wed,  8 Apr 2026 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674182;
	bh=P496sRTi6lsdggDKtqSRDm3a5YqFh7IgeJC7tpBYVKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOdL1utRtYeVFljWgcnOyEfK0oMGS5O8JRRGL8BQC5OfhrdMZnG+9WGDwpdQSVQf9
	 xegjpj2EB0amdSOUE6P/7v1mLITH7lGTMKRYR7Fka1kc7Va+4BVZr7lPVKYWYUpvHL
	 2yKReddR9wlIXxMkLXx1B1GZJQ4NztUXfmwpL0yY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Zimmermann <sigmaepsilon92@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.12 210/242] usb: gadget: f_hid: move list and spinlock inits from bind to alloc
Date: Wed,  8 Apr 2026 20:04:10 +0200
Message-ID: <20260408175934.941889180@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234950-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B11393C29F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Zimmermann <sigmaepsilon92@gmail.com>

commit 4e0a88254ad59f6c53a34bf5fa241884ec09e8b2 upstream.

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
---
 drivers/usb/gadget/function/f_hid.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1255,17 +1255,8 @@ static int hidg_bind(struct usb_configur
 	if (status)
 		goto fail;
 
-	spin_lock_init(&hidg->write_spinlock);
 	hidg->write_pending = 1;
 	hidg->req = NULL;
-	spin_lock_init(&hidg->read_spinlock);
-	spin_lock_init(&hidg->get_report_spinlock);
-	init_waitqueue_head(&hidg->write_queue);
-	init_waitqueue_head(&hidg->read_queue);
-	init_waitqueue_head(&hidg->get_queue);
-	init_waitqueue_head(&hidg->get_id_queue);
-	INIT_LIST_HEAD(&hidg->completed_out_req);
-	INIT_LIST_HEAD(&hidg->report_list);
 
 	INIT_WORK(&hidg->work, get_report_workqueue_handler);
 	hidg->workqueue = alloc_workqueue("report_work",
@@ -1550,6 +1541,16 @@ static struct usb_function *hidg_alloc(s
 
 	mutex_lock(&opts->lock);
 
+	spin_lock_init(&hidg->write_spinlock);
+	spin_lock_init(&hidg->read_spinlock);
+	spin_lock_init(&hidg->get_report_spinlock);
+	init_waitqueue_head(&hidg->write_queue);
+	init_waitqueue_head(&hidg->read_queue);
+	init_waitqueue_head(&hidg->get_queue);
+	init_waitqueue_head(&hidg->get_id_queue);
+	INIT_LIST_HEAD(&hidg->completed_out_req);
+	INIT_LIST_HEAD(&hidg->report_list);
+
 	device_initialize(&hidg->dev);
 	hidg->dev.release = hidg_release;
 	hidg->dev.class = &hidg_class;



