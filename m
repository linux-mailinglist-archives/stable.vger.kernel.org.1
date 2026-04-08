Return-Path: <stable+bounces-233866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBqMD7dE1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:06:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B81223BBBD0
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AD883071DAE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0723BBA01;
	Wed,  8 Apr 2026 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ah4UrlVU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24093BB9FA
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649640; cv=none; b=JyaYGYu6OxHyE8AzpMrMERaG3yMhjZyaX/j2r375Oy+BRKGWDtAk07cSiZXLM2l/ZiwS5zaxTTE3ZUuDwcKK/R6rgsyOkCfBO+OmO9EzBd4x60bJjnOZOlzivhiT9TyD2usLYObt7m2ZWAPXNEQkbPs7GHHyPsDte7ZRo/cSZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649640; c=relaxed/simple;
	bh=EgzHQrv9cX9I+Z6vytBqpQNvGjHDdM1Jzu7YXl0kAfc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cQq3bRHU3YowoNUjUERGFSvl4unuhWk4qohfC6ZHSD6ZofUBlyo627Qs38bHAjMWIQIawD8alomALyYTukLLUcKxfh6OUg43PPcy2qCht/wvP/fDaTDOA/invczTmU6HhNQKBHBNEApf2K44EkE2Lsno1SLGrVzxJPk60ZdoauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ah4UrlVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82502C19421;
	Wed,  8 Apr 2026 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775649639;
	bh=EgzHQrv9cX9I+Z6vytBqpQNvGjHDdM1Jzu7YXl0kAfc=;
	h=Subject:To:Cc:From:Date:From;
	b=ah4UrlVUzORQ/51CY7HU0sYRZqGonEatGIXF02CsNUoaiVlLCtnUl0r9yr0LLkck2
	 lIxIY+Fj2gWdOAUMrhbbkPxebZBXSXVEUYUJzCVu3zBV6NVdCT9G79b+jcJ8tKt3wx
	 +HKeFiPgXsHSR0SwLntf29IzMboXnG3euZYsbiQY=
Subject: FAILED: patch "[PATCH] usb: gadget: f_hid: move list and spinlock inits from bind to" failed to apply to 5.15-stable tree
To: sigmaepsilon92@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 14:00:27 +0200
Message-ID: <2026040827-jitters-comic-f139@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[msgid.link:server fail,gregkh:server fail,linuxfoundation.org:server fail,tor.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233866-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,msgid.link:url,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B81223BBBD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4e0a88254ad59f6c53a34bf5fa241884ec09e8b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040827-jitters-comic-f139@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e0a88254ad59f6c53a34bf5fa241884ec09e8b2 Mon Sep 17 00:00:00 2001
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
Date: Tue, 31 Mar 2026 20:48:44 +0200
Subject: [PATCH] usb: gadget: f_hid: move list and spinlock inits from bind to
 alloc

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

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 8812ebf33d14..e5ccaec7750c 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1262,17 +1262,8 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
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
@@ -1608,6 +1599,16 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
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


