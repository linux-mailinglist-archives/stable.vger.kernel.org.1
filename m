Return-Path: <stable+bounces-228872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KhzE5JXwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:09:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB732F5DCB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 860A53081E1B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20A626ED46;
	Mon, 23 Mar 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lZb/wmUH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20023AC0D2;
	Mon, 23 Mar 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277363; cv=none; b=IUZLtx6eZR5+zt3lPqC30we9wH4aF87OwyyCHJd7oJssxXVW9Pr82eJTSb17XRXSEkkyoBP3gpPDw6Y0xyT0oPeJCw8ArbFY3MbYeYer6qIpC68J73LklvndNMJ5QYQgJwUQpXGX1lzWHSqkUK+bxTru46z842mzcxoQxYBjf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277363; c=relaxed/simple;
	bh=rUhLGxEESJizd8A+wiCDRSZC2BkHHoNa60MVN8GfrVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OakcWOcDTNJvLBgvTwJUvuK0iijmau/D36nARW/FcC8KAuZWh/+t5pImneeTPOZWt7/2kwRySbsaSn9I2couTheYT+mvyVuERKYZJstv4E9QQX29SgoP+s8pYwk8VMw+bAAtiqh9dwol5E825/Uc+BIZ7W9uk4OToqrn3rh0Es4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lZb/wmUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CCCC2BC9E;
	Mon, 23 Mar 2026 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277362;
	bh=rUhLGxEESJizd8A+wiCDRSZC2BkHHoNa60MVN8GfrVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZb/wmUHFIksrjeCgoGaC4frKOlGeJfeb65j3795MG556A5bgl/awh+zqNO+RzKWa
	 lyZulvV54kMRsdIwTtOt9WjPQzR0Vwjm/bMPzaiHtIe5Kz5tyq12kAPfbZSrfGv+YP
	 mk911MO/QGidBYURVZPu4TIkeV22XRyIH/FsGPjE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 410/460] net: airoha: Read completion queue data in airoha_qdma_tx_napi_poll()
Date: Mon, 23 Mar 2026 14:46:46 +0100
Message-ID: <20260323134536.627997325@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228872-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8AB732F5DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 3affa310de523d63e52ea8e2efb3c476df29e414 ]

In order to avoid any possible race, read completion queue head and
pending entry in airoha_qdma_tx_napi_poll routine instead of doing it in
airoha_irq_handler. Remove unused airoha_tx_irq_queue unused fields.
This is a preliminary patch to add Qdisc offload for airoha_eth driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20241029-airoha-en7581-tx-napi-work-v1-1-96ad1686b946@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: d4a533ad249e ("net: airoha: Remove airoha_dev_stop() in airoha_remove()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 31 +++++++++-------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index cd2e888a8c52e..1dc051749603e 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -752,11 +752,9 @@ struct airoha_tx_irq_queue {
 	struct airoha_qdma *qdma;
 
 	struct napi_struct napi;
-	u32 *q;
 
 	int size;
-	int queued;
-	u16 head;
+	u32 *q;
 };
 
 struct airoha_hw_stats {
@@ -1655,25 +1653,31 @@ static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
 static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_tx_irq_queue *irq_q;
+	int id, done = 0, irq_queued;
 	struct airoha_qdma *qdma;
 	struct airoha_eth *eth;
-	int id, done = 0;
+	u32 status, head;
 
 	irq_q = container_of(napi, struct airoha_tx_irq_queue, napi);
 	qdma = irq_q->qdma;
 	id = irq_q - &qdma->q_tx_irq[0];
 	eth = qdma->eth;
 
-	while (irq_q->queued > 0 && done < budget) {
-		u32 qid, last, val = irq_q->q[irq_q->head];
+	status = airoha_qdma_rr(qdma, REG_IRQ_STATUS(id));
+	head = FIELD_GET(IRQ_HEAD_IDX_MASK, status);
+	head = head % irq_q->size;
+	irq_queued = FIELD_GET(IRQ_ENTRY_LEN_MASK, status);
+
+	while (irq_queued > 0 && done < budget) {
+		u32 qid, last, val = irq_q->q[head];
 		struct airoha_queue *q;
 
 		if (val == 0xff)
 			break;
 
-		irq_q->q[irq_q->head] = 0xff; /* mark as done */
-		irq_q->head = (irq_q->head + 1) % irq_q->size;
-		irq_q->queued--;
+		irq_q->q[head] = 0xff; /* mark as done */
+		head = (head + 1) % irq_q->size;
+		irq_queued--;
 		done++;
 
 		last = FIELD_GET(IRQ_DESC_IDX_MASK, val);
@@ -2023,20 +2027,11 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 
 	if (intr[0] & INT_TX_MASK) {
 		for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
-			struct airoha_tx_irq_queue *irq_q = &qdma->q_tx_irq[i];
-			u32 status, head;
-
 			if (!(intr[0] & TX_DONE_INT_MASK(i)))
 				continue;
 
 			airoha_qdma_irq_disable(qdma, QDMA_INT_REG_IDX0,
 						TX_DONE_INT_MASK(i));
-
-			status = airoha_qdma_rr(qdma, REG_IRQ_STATUS(i));
-			head = FIELD_GET(IRQ_HEAD_IDX_MASK, status);
-			irq_q->head = head % irq_q->size;
-			irq_q->queued = FIELD_GET(IRQ_ENTRY_LEN_MASK, status);
-
 			napi_schedule(&qdma->q_tx_irq[i].napi);
 		}
 	}
-- 
2.51.0




