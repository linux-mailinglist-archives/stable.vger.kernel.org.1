Return-Path: <stable+bounces-250889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJQYKqrpDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:04:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F24592E3C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E42930205CF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D053E3F88BE;
	Wed, 20 May 2026 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eATZI6EP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0733F7ABC;
	Wed, 20 May 2026 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296572; cv=none; b=Mgjnw4ou37HkUxhfDoUflVlgujUEk2UO4I5hPOO5dPWg0kZp7yUiMUKKc9zKVG/V7WsV6S2RedK0NB3Q5ZVy77lhCMR3MU4Ln5JQb9RC8UZx/hlY7GxOx6H50ilYO8bSUZXTu14LL6+NZOtHcF8jpC4vADiVkOg2nJi3N0ML7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296572; c=relaxed/simple;
	bh=1Lsl2xHiDI71DO2HzbKzysWLqkD3wesox0/N3PDWMIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqwL5Rt821/cnVTHDVMiaaC3qGW0kAXfEiQ0zejmVSrZ9FiXIWeW4qGOXU3yOZtIkJ510DbpO8aBoUBQOlo28KfMq2y8dkga1jImK6+NrTT6okXHW4eBalv4B/cj9tCcVuB8GpWFp1hSXbR1rjrtJrx0gEptVMJW2Obl+pHyFMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eATZI6EP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9AD1F00894;
	Wed, 20 May 2026 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296569;
	bh=6FFLZkj9ONDasibjh+bHeyopNLy8NuP58LlLq0uLIbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eATZI6EPzTlZyzKz2sF4Trzs33RjGCJUhoOukRrG5DdbyTEXlsbP7uORKtwc4M7YB
	 93YGfDgJoFRvD0EJLLkrk1Ojx8a0wjHCSdEv0tk7rXBERLHbbs2fttVuSFWQH5PA2Z
	 GmnQIkSvySl8k2y8DjLfjrQIV+YxPAf5DiHDQ+jA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0849/1146] net: airoha: Add size check for TX NAPIs in airoha_qdma_cleanup()
Date: Wed, 20 May 2026 18:18:19 +0200
Message-ID: <20260520162207.450977732@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250889-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35F24592E3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 4b91cb65789b794bfc8d50554b8994f8e0f16309 ]

If airoha_qdma_init routine fails before airoha_qdma_tx_irq_init() runs
successfully for all TX NAPIs, airoha_qdma_cleanup() will
unconditionally runs netif_napi_del() on TX NAPIs, triggering a NULL
pointer dereference. Fix the issue relying on q_tx_irq size value to
check if the TX NAPIs is properly initialized in airoha_qdma_cleanup().
Moreover, run netif_napi_add_tx() just if irq_q queue is properly
allocated.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260420-airoha_qdma_init_rx_queue-fix-v2-2-d99347e5c18d@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index adff897e9bfde..1bdf90b311060 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1020,8 +1020,6 @@ static int airoha_qdma_tx_irq_init(struct airoha_tx_irq_queue *irq_q,
 	struct airoha_eth *eth = qdma->eth;
 	dma_addr_t dma_addr;
 
-	netif_napi_add_tx(eth->napi_dev, &irq_q->napi,
-			  airoha_qdma_tx_napi_poll);
 	irq_q->q = dmam_alloc_coherent(eth->dev, size * sizeof(u32),
 				       &dma_addr, GFP_KERNEL);
 	if (!irq_q->q)
@@ -1031,6 +1029,9 @@ static int airoha_qdma_tx_irq_init(struct airoha_tx_irq_queue *irq_q,
 	irq_q->size = size;
 	irq_q->qdma = qdma;
 
+	netif_napi_add_tx(eth->napi_dev, &irq_q->napi,
+			  airoha_qdma_tx_napi_poll);
+
 	airoha_qdma_wr(qdma, REG_TX_IRQ_BASE(id), dma_addr);
 	airoha_qdma_rmw(qdma, REG_TX_IRQ_CFG(id), TX_IRQ_DEPTH_MASK,
 			FIELD_PREP(TX_IRQ_DEPTH_MASK, size));
@@ -1450,8 +1451,12 @@ static void airoha_qdma_cleanup(struct airoha_qdma *qdma)
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
+		if (!qdma->q_tx_irq[i].size)
+			continue;
+
 		netif_napi_del(&qdma->q_tx_irq[i].napi);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
 		if (!qdma->q_tx[i].ndesc)
-- 
2.53.0




