Return-Path: <stable+bounces-261198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wL1pHRpGJWq5FgIAu9opvQ
	(envelope-from <stable+bounces-261198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:21:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B30B64F8F5
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:21:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=XQnXMSL1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261198-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261198-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF5263006D41
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D3F2FB97B;
	Sun,  7 Jun 2026 10:20:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398F2DB7A3;
	Sun,  7 Jun 2026 10:20:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827626; cv=none; b=fc8SM0UqD2uqHNR/mNdpNZTyvESRfHu3iuKnVPG3myIYjD8gMjvDDfQ+IZgwr0Vlii18g/g0+1qaJZUlqSrGDC2fhSiPvD14LGAd0YCpu98d9yQL6IlQJD+a2utGPpa3ifv54WOIOwN2HDuIUJ0MrZGUZNJmlhCDYkiUhkM9Woo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827626; c=relaxed/simple;
	bh=zGAMjeIJ+MDOTyXZqOUzrQEVtyh198KlyRaybkRZZtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQO98x0Hzr9uebUDl085vfqFZIT71UNFzrYODikf5I9KxtGiknMNkBjUTOE4/ZP+dYtPjujgcNaMDX539z6/tMNn4k3XvY5JNuA1GmQnsMwX5Qn6yqyDc0a1Z6Lcyuz+olLToyTAXIb4869xZQi57qzzwmiiI5B4uqALk3s22d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQnXMSL1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090D01F00893;
	Sun,  7 Jun 2026 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827624;
	bh=0oqRpPFOe4622ln5HWYzalJ5fubuz5OmEC9oGzarCQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQnXMSL1HU8QR5lxYXz6wDIZw+m2MQpfj1T8cdUuLP+BcVhu/qMhu3MM/V3b5liQC
	 0pk/J1OSssM/hNqSiC6h2JW+WhXhGYqlx4KV7oNR+9/Qcf3kPiP9TYkuIj+5yEE3yS
	 Vx6BGTVnJsCM05rRr4YoDDFF609s+UIgq3P4tbFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 088/315] net: mana: Add NULL guards in teardown path to prevent panic on attach failure
Date: Sun,  7 Jun 2026 11:57:55 +0200
Message-ID: <20260607095730.856002198@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261198-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:haiyangz@microsoft.com,m:dipayanroy@linux.microsoft.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B30B64F8F5

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dipayaan Roy <dipayanroy@linux.microsoft.com>

[ Upstream commit 17bfe0a8c014ee1d542ad352cd6a0a505361664a ]

When queue allocation fails partway through, the error cleanup frees
and NULLs apc->tx_qp and apc->rxqs. Multiple teardown paths such as
mana_remove(), mana_change_mtu() recovery, and internal error handling
in mana_alloc_queues() can subsequently call into functions that
dereference these pointers without NULL checks:

- mana_chn_setxdp() dereferences apc->rxqs[0], causing a NULL pointer
  dereference panic (CR2: 0000000000000000 at mana_chn_setxdp+0x26).
- mana_destroy_vport() iterates apc->rxqs without a NULL check.
- mana_fence_rqs() iterates apc->rxqs without a NULL check.
- mana_dealloc_queues() iterates apc->tx_qp without a NULL check.

Add NULL guards for apc->rxqs in mana_fence_rqs(),
mana_destroy_vport(), and before the mana_chn_setxdp() call. Add a
NULL guard for apc->tx_qp in mana_dealloc_queues() to skip TX queue
draining when TX queues were never allocated or already freed.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Link: https://patch.msgid.link/20260525081129.1230035-2-dipayanroy@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 70 +++++++++++--------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index d1eb77d540427d..6ef2a3ee44c6b0 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1720,6 +1720,9 @@ static void mana_fence_rqs(struct mana_port_context *apc)
 	struct mana_rxq *rxq;
 	int err;
 
+	if (!apc->rxqs)
+		return;
+
 	for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
 		rxq = apc->rxqs[rxq_idx];
 		err = mana_fence_rq(apc, rxq);
@@ -2830,13 +2833,16 @@ static void mana_destroy_vport(struct mana_port_context *apc)
 	struct mana_rxq *rxq;
 	u32 rxq_idx;
 
-	for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
-		rxq = apc->rxqs[rxq_idx];
-		if (!rxq)
-			continue;
+	if (apc->rxqs) {
 
-		mana_destroy_rxq(apc, rxq, true);
-		apc->rxqs[rxq_idx] = NULL;
+		for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
+			rxq = apc->rxqs[rxq_idx];
+			if (!rxq)
+				continue;
+
+			mana_destroy_rxq(apc, rxq, true);
+			apc->rxqs[rxq_idx] = NULL;
+		}
 	}
 
 	mana_destroy_txq(apc);
@@ -3241,7 +3247,8 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	if (apc->port_is_up)
 		return -EINVAL;
 
-	mana_chn_setxdp(apc, NULL);
+	if (apc->rxqs)
+		mana_chn_setxdp(apc, NULL);
 
 	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
 		mana_pf_deregister_filter(apc);
@@ -3259,33 +3266,38 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 * number of queues.
 	 */
 
-	for (i = 0; i < apc->num_queues; i++) {
-		txq = &apc->tx_qp[i].txq;
-		tsleep = 1000;
-		while (atomic_read(&txq->pending_sends) > 0 &&
-		       time_before(jiffies, timeout)) {
-			usleep_range(tsleep, tsleep + 1000);
-			tsleep <<= 1;
-		}
-		if (atomic_read(&txq->pending_sends)) {
-			err = pcie_flr(to_pci_dev(gd->gdma_context->dev));
-			if (err) {
-				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
-					   err, atomic_read(&txq->pending_sends),
-					   txq->gdma_txq_id);
+	if (apc->tx_qp) {
+		for (i = 0; i < apc->num_queues; i++) {
+			txq = &apc->tx_qp[i].txq;
+			tsleep = 1000;
+			while (atomic_read(&txq->pending_sends) > 0 &&
+			       time_before(jiffies, timeout)) {
+				usleep_range(tsleep, tsleep + 1000);
+				tsleep <<= 1;
+			}
+			if (atomic_read(&txq->pending_sends)) {
+				err =
+				    pcie_flr(to_pci_dev(gd->gdma_context->dev));
+				if (err) {
+					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
+						   err,
+					    atomic_read(&txq->pending_sends),
+					    txq->gdma_txq_id);
+				}
+				break;
 			}
-			break;
 		}
-	}
 
-	for (i = 0; i < apc->num_queues; i++) {
-		txq = &apc->tx_qp[i].txq;
-		while ((skb = skb_dequeue(&txq->pending_skbs))) {
-			mana_unmap_skb(skb, apc);
-			dev_kfree_skb_any(skb);
+		for (i = 0; i < apc->num_queues; i++) {
+			txq = &apc->tx_qp[i].txq;
+			while ((skb = skb_dequeue(&txq->pending_skbs))) {
+				mana_unmap_skb(skb, apc);
+				dev_kfree_skb_any(skb);
+			}
+			atomic_set(&txq->pending_sends, 0);
 		}
-		atomic_set(&txq->pending_sends, 0);
 	}
+
 	/* We're 100% sure the queues can no longer be woken up, because
 	 * we're sure now mana_poll_tx_cq() can't be running.
 	 */
-- 
2.53.0




