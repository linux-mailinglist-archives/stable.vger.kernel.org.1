Return-Path: <stable+bounces-252081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FVxJ8b+DWpV5QUAu9opvQ
	(envelope-from <stable+bounces-252081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22921596A61
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94608324B4D7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5263F1AD9;
	Wed, 20 May 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CLuoEfH1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B67225A38;
	Wed, 20 May 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299696; cv=none; b=puIXVDGwCYInLkTzHFqr1i2qLy//sf5Q6XCjTNoVFs6OeLHqgkLz7Rs9HfBSAd9i4ano8l/OOEbkwRZ0fL7uaE+CTMMYoTsd5MHJDVS6RR+yczeo9Cv92Xr4Th0w8pqTg/2FORR0k5SB/tc27eJ44MuV656I0KBLX3310b6xV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299696; c=relaxed/simple;
	bh=V9bo2rk10RjskXJUoVC4nBWMESb5397CUYd28ckbo7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmZIBhB38NReZt4VOIfPJz2lvpGCx2Xdm/FLxpenM6rKc+Zt3JliLc7Do+eVyFs4hu4ZkMOoR1IM+LzJRmeaiM00kjgC6B5odiCJNQbZ36PNi3gjNSKGMpHyQ3l5oeILd7p84vh2iZx/5AAMjmqYL+FtzH7bFw/qVAMOGsgXUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CLuoEfH1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DCA1F000E9;
	Wed, 20 May 2026 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299695;
	bh=YA3+Sb7oCC5I0iU7nujUEknix5jVwsDdXmkEAbZIcuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CLuoEfH1GXk2CbIOYQRoj8NEeOuI6wF9WVGXnrmO36PUY4aoeaIxzHOpNBy78EQgF
	 MYnpcWGTDB7eMysn5mBEAMuEMpNLdeXNuZ580LZ98tCdryrKahMQkhcwBZedbV89Cx
	 2PfhPr6jG4nzNpCWId94YyK3goeyyOSRxxWglbTk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 869/957] net: airoha: Move entries to queue head in case of DMA mapping failure in airoha_dev_xmit()
Date: Wed, 20 May 2026 18:22:32 +0200
Message-ID: <20260520162153.412432934@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252081-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 22921596A61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 75df490c9e8457990c8b227650f6491218ce018b ]

In order to respect the original descriptor order and avoid any
potential IOMMU fault or memory corruption, move pending queue entries
to the head of hw queue tx_list if the DMA mapping of current inflight
packet fails in airoha_dev_xmit routine.

Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order DMA tx descriptors")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260429-airoha-xmit-unmap-error-path-v2-1-32e43b7c6d25@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 4364f4320428a..b4dfab2702cb9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2136,14 +2136,12 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 
 error_unmap:
-	while (!list_empty(&tx_list)) {
-		e = list_first_entry(&tx_list, struct airoha_queue_entry,
-				     list);
+	list_for_each_entry(e, &tx_list, list) {
 		dma_unmap_single(dev->dev.parent, e->dma_addr, e->dma_len,
 				 DMA_TO_DEVICE);
 		e->dma_addr = 0;
-		list_move_tail(&e->list, &q->tx_list);
 	}
+	list_splice(&tx_list, &q->tx_list);
 
 	spin_unlock_bh(&q->lock);
 error:
-- 
2.53.0




