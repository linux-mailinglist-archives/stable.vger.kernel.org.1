Return-Path: <stable+bounces-241231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFY0CRoI72lv4QAAu9opvQ
	(envelope-from <stable+bounces-241231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:54:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DF846DE15
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51B763005A91
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDBF39022C;
	Mon, 27 Apr 2026 06:54:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.189.cn (189sx01-ptr.21cn.com [125.88.204.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55438F651
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.88.204.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272849; cv=none; b=EM3Ib5Wa5HUHa0fi3IBRB3ZJSMEO5DoUcMZW5BrhHN0SYNsp7sPGjXsxJC+q+tumIzg7ypkel/3FYspUmCqQtBhXLP5ynHXEMvDitRjozkWmcA6Dm5lBKTq7DzhgLTJ1wLrWG3tz3x4PWlhIgEyQyX8kBMeAacqKqAJLLWW7KAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272849; c=relaxed/simple;
	bh=K5oD8sUjZCMToEJF7sc7tGTIt1QZSOV12Rz+cBgGI2U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dfFd0ROwbwA4/rx5oxDy3GHzOFhKQB8jkck//ZzAHqbb2enRO92PqdZtMLuOMhqEAKZe6XBqJlHvQKkp4mu/hEuBx7XHP0zCmkeWo1hdj6YmUXAwauR/JIpT22DQINsodVYeqHE9ZtjgWLfEsR7ZC11fjfeVzDMuQsYxDtf5Py8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=125.88.204.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.1628428836
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-39.144.79.222 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 0FC4B40029A;
	Mon, 27 Apr 2026 14:54:01 +0800 (CST)
Received: from  ([39.144.79.222])
	by gateway-153622-dep-76cc7bc9cd-r45x9 with ESMTP id 461099178c6f4286a4cee7e8764d417a for wei.fang@nxp.com;
	Mon, 27 Apr 2026 14:54:03 CST
X-Transaction-ID: 461099178c6f4286a4cee7e8764d417a
X-Real-From: charles_xu@189.cn
X-Receive-IP: 39.144.79.222
X-MEDUSA-Status: 0
Sender: charles_xu@189.cn
From: charles_xu@189.cn
To: wei.fang@nxp.com,
	kuba@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] net: enetc: fix the deadlock of enetc_mdio_lock
Date: Mon, 27 Apr 2026 14:53:58 +0800
Message-Id: <20260427065358.7488-1-charles_xu@189.cn>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00DF846DE15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241231-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[charles_xu@189.cn,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[189.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.813];
	TO_DN_NONE(0.00)[];
	FROM_NO_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	FREEMAIL_FROM(0.00)[189.cn];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[189.cn:mid,189.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,windriver.com:email]

From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>

[ Upstream commit 50bd33f6b3922a6b760aa30d409cae891cec8fb5 ]

After applying the workaround for err050089, the LS1028A platform
experiences RCU stalls on RT kernel. This issue is caused by the
recursive acquisition of the read lock enetc_mdio_lock. Here list some
of the call stacks identified under the enetc_poll path that may lead to
a deadlock:

enetc_poll
  -> enetc_lock_mdio
  -> enetc_clean_rx_ring OR napi_complete_done
     -> napi_gro_receive
        -> enetc_start_xmit
           -> enetc_lock_mdio
           -> enetc_map_tx_buffs
           -> enetc_unlock_mdio
  -> enetc_unlock_mdio

After enetc_poll acquires the read lock, a higher-priority writer attempts
to acquire the lock, causing preemption. The writer detects that a
read lock is already held and is scheduled out. However, readers under
enetc_poll cannot acquire the read lock again because a writer is already
waiting, leading to a thread hang.

Currently, the deadlock is avoided by adjusting enetc_lock_mdio to prevent
recursive lock acquisition.

Fixes: 6d36ecdbc441 ("net: enetc: take the MDIO lock only once per NAPI poll cycle")
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Acked-by: Wei Fang <wei.fang@nxp.com>
Link: https://patch.msgid.link/20251015021427.180757-1-jianpeng.chang.cn@windriver.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ adjusted context ]
Signed-off-by: Charles Xu <charles_xu@189.cn>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 25 ++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index bf49c07c8b51..a0177130dc37 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1225,6 +1225,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd;
 		struct sk_buff *skb;
@@ -1260,7 +1262,9 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		rx_byte_cnt += skb->len + ETH_HLEN;
 		rx_frm_cnt++;
 
+		enetc_unlock_mdio();
 		napi_gro_receive(napi, skb);
+		enetc_lock_mdio();
 	}
 
 	rx_ring->next_to_clean = i;
@@ -1268,6 +1272,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -1562,6 +1568,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd, *orig_rxbd;
 		int orig_i, orig_cleaned_cnt;
@@ -1621,7 +1629,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			if (unlikely(!skb))
 				goto out;
 
+			enetc_unlock_mdio();
 			napi_gro_receive(napi, skb);
+			enetc_lock_mdio();
 			break;
 		case XDP_TX:
 			tx_ring = priv->xdp_tx_ring[rx_ring->index];
@@ -1664,7 +1674,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				break;
 			}
 
+			enetc_unlock_mdio();
 			err = xdp_do_redirect(rx_ring->ndev, &xdp_buff, prog);
+			enetc_lock_mdio();
 			if (unlikely(err)) {
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				rx_ring->stats.xdp_redirect_failures++;
@@ -1684,8 +1696,11 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
-	if (xdp_redirect_frm_cnt)
+	if (xdp_redirect_frm_cnt) {
+		enetc_unlock_mdio();
 		xdp_do_flush_map();
+		enetc_lock_mdio();
+	}
 
 	if (xdp_tx_frm_cnt)
 		enetc_update_tx_ring_tail(tx_ring);
@@ -1694,6 +1709,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
 				     rx_ring->xdp.xdp_tx_in_flight);
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -1712,6 +1729,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < v->count_tx_rings; i++)
 		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
 			complete = false;
+	enetc_unlock_mdio();
 
 	prog = rx_ring->xdp.prog;
 	if (prog)
@@ -1723,10 +1741,8 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	if (work_done)
 		v->rx_napi_work = true;
 
-	if (!complete) {
-		enetc_unlock_mdio();
+	if (!complete)
 		return budget;
-	}
 
 	napi_complete_done(napi, work_done);
 
@@ -1735,6 +1751,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 
 	v->rx_napi_work = false;
 
+	enetc_lock_mdio();
 	/* enable interrupts */
 	enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
 
-- 
2.35.3


