Return-Path: <stable+bounces-250884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFmJDCTwDWqo4wUAu9opvQ
	(envelope-from <stable+bounces-250884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01760593E52
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB35031B8730
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4B3EFD34;
	Wed, 20 May 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iewilnFH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2603EBF35;
	Wed, 20 May 2026 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296558; cv=none; b=li1PoHYnE7zRwChlCOVcfCR4KMVOkVuC3028L4eWRDWjpQvSCWnajXOXH+1B8TJVC9qSqxUXOF3eC+TpDkmCRyHah7IUtqyPnE/5oovqvvj4Vcv+4PrGPapm9GWIHjDV1tnXrnTv29SvOUijfK8dHTH4PAtRM3Wul0JTxdA6D/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296558; c=relaxed/simple;
	bh=3y4xIzIbkpeAoUum+1R1rp2arWj1/Zb523qezvhr33A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJwA7WLls+H5EYFQ8vfYHNnr2ap7OFKADwZV6rGLgT3bVZEe3e8AuOA+9DNeyAj7CVryI15Pp9uEd1VzGGP5lUUOfel+Nn1x8sqWVPMD6/ogJ9eev5Wlu0S/NmWQAsAAbC3KngHvjs62FnNzdF3bwWXTrRp5nenOksNYJrgSUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iewilnFH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CA01F00893;
	Wed, 20 May 2026 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296556;
	bh=avHPGr5cK5pYkYLGVmceDcxt+OXxwu6Wqd44ZqjL2uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iewilnFHZV7V1RtZJkX0cRwbXyPvE9KZlULOSHDgnBdif0dLgRuslkT0yBip4pG/b
	 eoX0kJAWiOZWVI9dfDz0+tdlPKuDaIcCMvH9jEztPoK+XxEB7zzkAzbpcwxWY+gz/X
	 Mf/XNoL6eTgk2PfYCiN3MngvP3bG/vUCvJgflRxE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0844/1146] net: airoha: Move ndesc initialization at end of airoha_qdma_init_tx()
Date: Wed, 20 May 2026 18:18:14 +0200
Message-ID: <20260520162207.336121276@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250884-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 01760593E52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit f329924bb49458c65297f1361f545816a5b90998 ]

If queue entry list allocation fails in airoha_qdma_init_tx_queue routine,
airoha_qdma_cleanup_tx_queue() will trigger a NULL pointer dereference
accessing the queue entry array. The issue is due to the early ndesc
initialization in airoha_qdma_init_tx_queue(). Fix the issue moving ndesc
initialization at end of airoha_qdma_init_tx routine.

Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order DMA tx descriptors")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-1-e04bcc2c9642@kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 3deffc499bcb4..ab166c1d04d30 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -978,27 +978,27 @@ static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
 	dma_addr_t dma_addr;
 
 	spin_lock_init(&q->lock);
-	q->ndesc = size;
 	q->qdma = qdma;
 	q->free_thr = 1 + MAX_SKB_FRAGS;
 	INIT_LIST_HEAD(&q->tx_list);
 
-	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
+	q->entry = devm_kzalloc(eth->dev, size * sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
 		return -ENOMEM;
 
-	q->desc = dmam_alloc_coherent(eth->dev, q->ndesc * sizeof(*q->desc),
+	q->desc = dmam_alloc_coherent(eth->dev, size * sizeof(*q->desc),
 				      &dma_addr, GFP_KERNEL);
 	if (!q->desc)
 		return -ENOMEM;
 
-	for (i = 0; i < q->ndesc; i++) {
+	for (i = 0; i < size; i++) {
 		u32 val = FIELD_PREP(QDMA_DESC_DONE_MASK, 1);
 
 		list_add_tail(&q->entry[i].list, &q->tx_list);
 		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
 	}
+	q->ndesc = size;
 
 	/* xmit ring drop default setting */
 	airoha_qdma_set(qdma, REG_TX_RING_BLOCKING(qid),
-- 
2.53.0




