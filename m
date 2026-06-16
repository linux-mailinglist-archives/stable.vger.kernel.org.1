Return-Path: <stable+bounces-264754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JkvuFWl7MWrpkQUAu9opvQ
	(envelope-from <stable+bounces-264754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:35:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E56923DA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:35:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fIOUENLR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264754-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264754-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CEB830302CD
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2744A477995;
	Tue, 16 Jun 2026 16:35:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DA4779A8;
	Tue, 16 Jun 2026 16:35:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627718; cv=none; b=ORnfQPzA7uk+ESHp8WVCtSmZD9SyGTMxM6oiuBhShxPFT+scSNaiZIXBlbv+zcVv64m/Oa30xK98V/LaiTxhbbOwXnROhfMpy0Gtw1xs7jsxg1Y20V4Ifog4qE6MQQMwjTUXiaMAfX5VjOVvP8ZR2+luOXTvZfPe4Clm/vX3p1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627718; c=relaxed/simple;
	bh=qQ2x6Yhp05/Aw5hxOTDxTuvi1OFcIfxvyuahOc/yI88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azQJSi1kWTyP/hXB1N+P6VYySzB+xbtEqf4kpzfDBm7oy1DLDGEnl9HdxMeiJTo7rQwbnXf/K98JKs2UNn7hSf/3snd958wcQRCFj1hCaO7/Q9LeeBWva9KOLbN2VU8EhoAbkCfIxW5+/8pvzYiOtIkPv3Dn3q8ABWQxyCkIrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fIOUENLR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3BC1F000E9;
	Tue, 16 Jun 2026 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627717;
	bh=88CRewZCd6daaZvgxEc5dms2turIC7ImojHTSZCE/dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fIOUENLR1IKLB9EWSFuy7JpCvi8NLWkdoJBOKAvw/uRVXX5Rqq96xxqI+myiQ7L5g
	 hMbGPO2emAG9wBHmXSKNxVYwjSzS2WdyAxnksF2lfoWdKJ7M2RWbFafWNDQA58hkHp
	 xo60qaH+QWhBu338+1n3PVS6M25PWNen+Ej25iAw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 6.12 181/261] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback
Date: Tue, 16 Jun 2026 20:30:19 +0530
Message-ID: <20260616145053.462998288@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264754-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mukesh.ojha@oss.qualcomm.com,m:andersson@kernel.org,m:srini@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF5E56923DA

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

commit 5401fb4fe10fac6134c308495df18ed74aebb9c4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2411,7 +2411,6 @@ static int fastrpc_rpmsg_probe(struct rp
 
 	kref_init(&data->refcount);
 
-	dev_set_drvdata(&rpdev->dev, data);
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
@@ -2420,6 +2419,7 @@ static int fastrpc_rpmsg_probe(struct rp
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
 
 	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 	if (err)
@@ -2493,6 +2493,9 @@ static int fastrpc_rpmsg_callback(struct
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (!cctx)
+		return -ENODEV;
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);



