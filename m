Return-Path: <stable+bounces-235777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHaYIT3v2mnn7AgAu9opvQ
	(envelope-from <stable+bounces-235777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:02:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16D3E244C
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 03:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A89B3019194
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 01:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47B13D8B1;
	Sun, 12 Apr 2026 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhx2gobO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4C18EB0
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775955769; cv=none; b=GBkPBysXhcp9zzU4duedEcZ1b+GCQp/ynMQzZwHmKKrxpLxVcy0LT+fqiQEO9XExRXBysSGzkz0xH0R4WxaCpTYLbvy1RyDuW+6vreuDr+Gdtl4CVQOqSwdHyVNzriDVHgH2WUfVsJuU82ztdGv3KD8nXSDqGY6BqRrzDWfrMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775955769; c=relaxed/simple;
	bh=pkcUWocwIJqf14KxTO7Y+qKRdfvqA2oEpVOUHXV1Fd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1Rx2emAOyb/Gu+vugP2fo6E4BaabFWJhgd7LvIm9V1uXlEI7PbSx/yUs7NBsT1hKfp+LcVWAsT+yZl3mgdQMKJoGsyWkhremak91lhhkG1LtlohWjDkUPgEHGQs5sDRh0aecwtc/yRA3y7XahlFSfMkv91Z3vLb59So7Zwqylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhx2gobO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A39FC116C6;
	Sun, 12 Apr 2026 01:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775955769;
	bh=pkcUWocwIJqf14KxTO7Y+qKRdfvqA2oEpVOUHXV1Fd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhx2gobOqJY2aInrXBwXPabGaNd/bFhW0J2hI3SA6C8Yrq+DtOef1biHFYNtKDjyB
	 jxsO7ozPbtCw2cgnsjPl8IgqJU924iTMMj2d0yungZVpauZpRVCR592vlEVDFLwCbt
	 xrw1EK5zVgJC/H+RGF1qVRSk2+MS9mof5oYOKs9Bq40xw2GgfR1e96rZYt57IUbYx9
	 BeU1Pd9k8R0kCVpC1S3rkEc7Dlj6xGA6YqVyzWbhJW8SDUZIzdekgeMrs609pfNkQL
	 jL1/RPYVJpcXweiKGhRDLJf9TocpP329pNufJy8FNVhc1uzASa+wFXNX81MS1JQ/yx
	 vQLWHCK04Rr3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: gadget: f_hid: move list and spinlock inits from bind to alloc
Date: Sat, 11 Apr 2026 21:02:47 -0400
Message-ID: <20260412010247.1905349-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040826-pagan-amuser-3732@gregkh>
References: <2026040826-pagan-amuser-3732@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235777-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: DF16D3E244C
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
index d8dafebeabea4..2137513b23a08 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1000,13 +1000,8 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
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
@@ -1275,6 +1270,12 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 	mutex_lock(&opts->lock);
 
+	spin_lock_init(&hidg->write_spinlock);
+	spin_lock_init(&hidg->read_spinlock);
+	init_waitqueue_head(&hidg->write_queue);
+	init_waitqueue_head(&hidg->read_queue);
+	INIT_LIST_HEAD(&hidg->completed_out_req);
+
 	device_initialize(&hidg->dev);
 	hidg->dev.release = hidg_release;
 	hidg->dev.class = &hidg_class;
-- 
2.53.0


