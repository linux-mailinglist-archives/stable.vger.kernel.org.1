Return-Path: <stable+bounces-263301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d8q3NB8ZMGoNNgUAu9opvQ
	(envelope-from <stable+bounces-263301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:24:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C33687A29
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:24:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=gQSJwHjn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263301-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263301-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71B183093C33
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9E4028DF;
	Mon, 15 Jun 2026 15:20:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030294028EA
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:20:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536844; cv=none; b=XGZe3eCN2iD/PzYQrD31OR/P95KDV383oratujPVSuLVS0unN4RQme6djzeQKtgZbnNZPpCTcRwJ0RIEE9wojW9g/vM6D+kwfDm66fB76LVpqVQT2Wl5vmG/wb06hYCpLggjISLRa0/f/zpBasr/3iQs/Va6U2DGfUETPiZ7sb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536844; c=relaxed/simple;
	bh=JdD7Frlbyb3jjkTDiQgzWKKV4dpPajLzrXm9bYF95bg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s85Lcy34u5T6dwEjx5P4gkAKT31LTLgxkB6gkwycDVzoTPdRq/2HeIqmzFos6u7U4hJZ+e/2bEBuJf+ORyASqiGtKPpgKhs8j+NrzreMujCMIU8rADZytqsyYslC5roDaPIuOBlNu8MbGnwRIilYLqs78TV8E7y0h6DSqnT4Gmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQSJwHjn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39731F000E9;
	Mon, 15 Jun 2026 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781536842;
	bh=Y/IWxwQsfnVu0FS9vBpfUdJW/sCgA8v11Go2jL3cZx0=;
	h=Subject:To:Cc:From:Date;
	b=gQSJwHjnY6+OdbxUbln+lnaZLeJObpbH60KHz9zAeEbnjrNTA9wOBnCiMRZWHHmVz
	 ycAXAraRR5tiKipqwJC4cX5AflTceP8hkTN7ZqXc5BOSvxu1lKumwJR5iEX/OE4c8D
	 +kmXn8To2i5ThaXqksK85LvOZwNn1yA+txm8DtsU=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback" failed to apply to 5.15-stable tree
To: mukesh.ojha@oss.qualcomm.com,andersson@kernel.org,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:48:32 +0200
Message-ID: <2026061532-proponent-wife-a132@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263301-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mukesh.ojha@oss.qualcomm.com,m:andersson@kernel.org,m:gregkh@linuxfoundation.org,m:srini@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82C33687A29


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5401fb4fe10fac6134c308495df18ed74aebb9c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061532-proponent-wife-a132@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5401fb4fe10fac6134c308495df18ed74aebb9c4 Mon Sep 17 00:00:00 2001
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:45:27 +0100
Subject: [PATCH] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback

A NULL pointer dereference was observed on Hawi at boot when the DSP
sends a glink message before fastrpc_rpmsg_probe() has completed
initialization:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
  pc : _raw_spin_lock_irqsave+0x34/0x8c
  lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
  ...
  Call trace:
   _raw_spin_lock_irqsave+0x34/0x8c (P)
   fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
   qcom_glink_native_rx+0x538/0x6a4
   qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]

The faulting address 0x178 corresponds to the lock variable inside
struct fastrpc_channel_ctx, confirming that cctx is NULL when
fastrpc_rpmsg_callback() attempts to take the spinlock.

There are two issues here. First, dev_set_drvdata() is called before
spin_lock_init() and idr_init(), leaving a window where the callback
can retrieve a valid cctx pointer but operate on an uninitialized
spinlock. Second, the rpmsg channel becomes live as soon as the driver
is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
is called at all, resulting in dev_get_drvdata() returning NULL.

Fix both issues by moving all cctx initialization ahead of
dev_set_drvdata() so the structure is fully initialized before it
becomes visible to the callback, and add a NULL check in
fastrpc_rpmsg_callback() as a guard against any remaining window.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204528.116920-4-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index cca7489605c5..47cf3d21b51d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2460,7 +2460,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	kref_init(&data->refcount);
 
-	dev_set_drvdata(&rpdev->dev, data);
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
@@ -2469,6 +2468,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
 
 	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 	if (err)
@@ -2542,6 +2542,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (!cctx)
+		return -ENODEV;
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);


