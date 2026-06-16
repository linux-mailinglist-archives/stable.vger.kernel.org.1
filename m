Return-Path: <stable+bounces-266566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XbNmDr2pMWqPowUAu9opvQ
	(envelope-from <stable+bounces-266566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:53:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 897CB695054
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:53:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JYA8OF+P;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266566-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266566-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2183B31A542D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BB537B032;
	Tue, 16 Jun 2026 19:53:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB4374192
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:53:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639586; cv=none; b=ci/mIp+0yKhZNnNnF4f+LB4WLBVOkBJ8qLZU0PaaAtDXuTo0AYZsaIwOLAfW4Ibwj3O2tpCBH5SKtLio0j+1Mq62lEpPvNvZVMT/ND0X713uUj2nv7vR/PrxCYAV8+DENw+UHFmVOAmhLMwB151tZt2TsyAVdl2j7XkZnAm7BLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639586; c=relaxed/simple;
	bh=+BNVCenZgnbrbJxFgrUitBa8odZkQtwlzSrSaNwcLM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwSUpVZY0w3PeGjIMy5G1G24N0Z4jp4wyJ+aGj/Gg5fcNK42VFiz7KhI9Fb8YS6EaRBBuDboQaxRwe0keqaC8t/ZE5fWx3C/GjrkgdaddBoLNhzFBiqq8+VdlLsS8zRVC+ryNeMW4ddVIMylizQQu1aKVmh4YcGBiKLCSe9YVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYA8OF+P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF63B1F00A3A;
	Tue, 16 Jun 2026 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639585;
	bh=xiQij2G4Q1n+868+CTT2W9qy29SsNKvNhzbQkyMw6pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYA8OF+P8OKWvmzQOE/IQOUOLK3F3pY/3DwS6nmOxZ4kpVbvGfgRL/DUnlN191IFC
	 6n0bjn+yc9rLN6TFRvMkD5X9/vgcyqmszDH0v5xFmsIMcvGkRUXd7D5RajDF295Wda
	 K+Vu6nRZYsQSRifvW8pwaRa3BZDDy3GrWMZtDYQzlqGKlZzbZuiXEZZeKkxe+y14SH
	 BgwKf4D47N9fZCwtmYZkWk95W3o/hsH+NlrHTmmaI2gCjKhw5Oo7ajBTmvdDhO0iD1
	 M19B14SyheGz7O1zzCP4JBGGDuCrDDT5OHC39yVCRruDKilCnw4bzB7LDjfKvdlUhL
	 mR5vcH7qSxkKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback
Date: Tue, 16 Jun 2026 15:53:02 -0400
Message-ID: <20260616195302.3526937-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616195302.3526937-1-sashal@kernel.org>
References: <2026061532-proponent-wife-a132@gregkh>
 <20260616195302.3526937-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266566-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mukesh.ojha@oss.qualcomm.com,m:andersson@kernel.org,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 897CB695054

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

[ Upstream commit 5401fb4fe10fac6134c308495df18ed74aebb9c4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index fad9654a8ee1c4..2b33bfd3f256ef 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1662,7 +1662,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	kref_init(&data->refcount);
 
-	dev_set_drvdata(&rpdev->dev, data);
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
@@ -1670,6 +1669,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
 
 	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 }
@@ -1717,6 +1717,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (!cctx)
+		return -ENODEV;
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-- 
2.53.0


