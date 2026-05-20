Return-Path: <stable+bounces-251982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FD0B879DWo95QUAu9opvQ
	(envelope-from <stable+bounces-251982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:30:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1765596648
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E767335A9488
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB93F65E1;
	Wed, 20 May 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OgaKWYwY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1E53F23C5;
	Wed, 20 May 2026 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299435; cv=none; b=hvg9YJ6kzyqG+CZ1tK6oOynJ9451TaM7rQejbvuahRENDyFFkg12rxKgw3WynMES/mh6lyrc43oSs2yWY+d9OxXVSYzy4n9BXwVzUqB4+39GabDfp+1rCcfE3ZDZD8gS6wHine9aDvKoeuI5yrd4DJBed8/pkUxI7wfeFUbMkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299435; c=relaxed/simple;
	bh=YB7LGaquYBhXlq7lcI38Hn2K4c88d1TI7fsXdISDDf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+Dehk+mQbbbvz52Qz0PR3Ddr7Ftm0Vf2YgRAJQWxAlGO5yYswsxAJg9GVyn7FajvxBiMErFQgj1Ddm6QPQ+EEDFfI/4zXw5s4tjKp+7UIMdC7IDbIYlDDh5NSUFDGrklgLG6o7KPkUyRdR3dDVyLXFOc5ZyVxV84I05BBytvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OgaKWYwY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3822C1F000E9;
	Wed, 20 May 2026 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299434;
	bh=E6RbrduHM2xFgkto4D3NsaDU2U4gXsTy280uiQLbRRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OgaKWYwYak/qGj9EF/+k/geLVR7jwU/W709W/hhqh7A8iW4cr8XHVHqhUD01oc5DK
	 rzR8upoDFrvdJc3t2RXB4kBT0L2lYMJIuAk8+4dCL2vGTAG8sG4pGcjxmPZZf+mguH
	 Cp9TnrY5owoOnlur6phmSitjErrFWFAyT5Hx1apA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 771/957] net: airoha: stop net_device TX queue before updating CPU index
Date: Wed, 20 May 2026 18:20:54 +0200
Message-ID: <20260520162151.283799302@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251982-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A1765596648
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 3854de7b38be742cf7558476956d12414cb274f2 ]

Currently, airoha_eth driver updates the CPU index register prior of
verifying whether the number of free descriptors has fallen below the
threshold.
Move net_device TX queue length check before updating the TX CPU index
in order to update TX CPU index even if there are more packets to be
transmitted but the net_device TX queue is going to be stopped
accounting the inflight packets.

Fixes: 1d304174106c ("net: airoha: Implement BQL support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260421-airoha-xmit-stop-condition-v1-1-e670d6a48467@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 865b854bd4afc..fd612cc339e13 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2111,17 +2111,16 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 
 	skb_tx_timestamp(skb);
 	netdev_tx_sent_queue(txq, skb->len);
+	if (q->ndesc - q->queued < q->free_thr) {
+		netif_tx_stop_queue(txq);
+		q->txq_stopped = true;
+	}
 
 	if (netif_xmit_stopped(txq) || !netdev_xmit_more())
 		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
 				TX_RING_CPU_IDX_MASK,
 				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
-	if (q->ndesc - q->queued < q->free_thr) {
-		netif_tx_stop_queue(txq);
-		q->txq_stopped = true;
-	}
-
 	spin_unlock_bh(&q->lock);
 
 	return NETDEV_TX_OK;
-- 
2.53.0




