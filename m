Return-Path: <stable+bounces-266588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0WKnIS/RMWrfqgUAu9opvQ
	(envelope-from <stable+bounces-266588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 00:41:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FDE695A20
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 00:41:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oain2oZu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266588-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266588-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56618318B478
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 22:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79DD3E2AD2;
	Tue, 16 Jun 2026 22:40:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C53DF00C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 22:40:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649608; cv=none; b=eS/lFUuNsqiOh4fLkfyduzZn95BWiEfAwTRAlnKO5mTpTEVkeUJ1/8pnqdHamM6uzikjbRs3EUA9pGtGwcr4iyHcho8QthGn1mCNRSksPXW8l7AKtE4JjduG0EZ53msWTtIDYmoumKlVeYuOe5K+i+1BNjYhfwOQxXDonvlcKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649608; c=relaxed/simple;
	bh=jxoKKTFvKrAEAU9lyPMxgu3P59Dm3EDbadQIZ3jyxQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjL7JBnsSRK+R27tb+8dOp36+PB8S00spLz2dz6UoPK3MfFT2tcme79M/j3hcytxtQ0itNHbZKNXJfvnC4131eCgs5hgdYtWKnCIrJspT7nsTF4c0WaL+uV709xbKtPWj4e/X3LQE9Ncw9qdbRtBkfw0zdSNU7VOUNNW5QXlTAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oain2oZu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99371F000E9;
	Tue, 16 Jun 2026 22:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781649607;
	bh=q3tUUZXmU/BRUzhoKHIQUW/gatt07Apiy2JTUEuy/HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oain2oZuGwTn9MieW10nnMw1DsOamK7NpBfjEW49nvVj6vgzDDISQUDIsYeFFwmnM
	 9ZPJHZTHxigb0d1gnwsaL7AKPkMA8znFwTtLvcR3K/MgRem1GiFMO970ArJyKaYpfM
	 VgcLA2of4wPYcQlfc+EVMA5H9KLpvxxodxekO7UhShTJzrW4cBbJI1/h2EhXwLLG1G
	 auZDYu+wFdYWYPtGgO2G3A6q1hlQlB0SHYrqR2vHKeF6G1i0Sg8BxLhqz7P0st6B8i
	 gh2QkAPhmoDdT/FNYZdLTTpp/4cZIIAzzdchYbQXgA84xc1fwaJ/Oo8C2gkT55J6kV
	 /DkWftvtegN0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
Date: Tue, 16 Jun 2026 18:40:03 -0400
Message-ID: <20260616224004.3558667-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061534-unlikable-frolic-167a@gregkh>
References: <2026061534-unlikable-frolic-167a@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266588-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:abel.vesa@linaro.org,m:srinivas.kandagatla@linaro.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linaro.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06FDE695A20

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 9bde43a0e2f469961e18d0a3496a9a74379c22bf ]

dma_set_mask_and_coherent only updates the mask to which the device
dma_mask pointer points to. Add a dma_mask to the channel ctx and set
the device dma_mask to point to that, otherwise the dma_set_mask will
return an error and the dma_set_coherent_mask will be skipped too.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20221125071405.148786-11-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 5401fb4fe10f ("misc: fastrpc: Fix NULL pointer dereference in rpmsg callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index af8412dd590ef6..2f6df86881b606 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -214,6 +214,7 @@ struct fastrpc_channel_ctx {
 	struct list_head users;
 	struct miscdevice miscdev;
 	struct kref refcount;
+	u64 dma_mask;
 };
 
 struct fastrpc_user {
@@ -1660,6 +1661,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
+	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
 	spin_lock_init(&data->lock);
-- 
2.53.0


