Return-Path: <stable+bounces-252287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCcLM1D5DWq75AUAu9opvQ
	(envelope-from <stable+bounces-252287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:11:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED7595802
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9AC330D35E9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B953FC5C3;
	Wed, 20 May 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJQDSjQ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D633FC5AE;
	Wed, 20 May 2026 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300281; cv=none; b=iZWkXYrZrF+UrFYgMhykQzGU/h87QlE3WpmK6TGX6QqtqMg7VjJOrMUE4AfqNnABc18mq246gVVAALaMmAQBp0w3H+o8s3rspw3f0aScYJphJTnZd1UhAs4NN27yuLMcN9yUSfcp/X84cAMMq3CQIe1tMbLMyplVJs5jt4RxiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300281; c=relaxed/simple;
	bh=ApqAVu/U00jbFj5VcPhovy28b8O/EukODF2sxs3zKPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toaOXZI1lU7uNPVTwLb0KOeCdFZKqHU9n8/Om8OgEVGMWHSWYbOETjiJuAtBnPqoR30mFNRyOcJnUmL3naNMKWrEm3mlISpCK7cRnutu22Zd4rHxiASwSrOl5SySHKLeqVqzign0BM6EiB7v0/T4B2upBKBPLyUojCRkkalyF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mJQDSjQ2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7022C1F000E9;
	Wed, 20 May 2026 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300279;
	bh=VqHOL5Rdxffd1886kZ8/JDQ3GPKQq3KanZRxhgRd2tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mJQDSjQ2TabjdLK3NxFSwmLuk4UNGB8F3FMSFvFmcYokskzQEpqAk94SRBQB6bjLf
	 4AVOz+89pBo5voIwfkgsDzB6at3VVzpGjyYsafg+wZXiGeQPki0USsdo7jm6bc84qV
	 2r/3mVzzD/OPD6WUIcDeqj3NphOURUacqtkwVayI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 078/666] net: bcmgenet: fix racing timeout handler
Date: Wed, 20 May 2026 18:14:49 +0200
Message-ID: <20260520162112.921980618@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252287-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tipi-net.de:email]
X-Rspamd-Queue-Id: 4FED7595802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justin.chen@broadcom.com>

[ Upstream commit 5393b2b5bee2ac51a0043dc7f4ac3475f053d08d ]

The bcmgenet_timeout handler tries to take down all tx queues when
a single queue times out. This is over zealous and causes many race
conditions with queues that are still chugging along. Instead lets
only restart the timed out queue.

Fixes: 13ea657806cf ("net: bcmgenet: improve TX timeout")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>
Link: https://patch.msgid.link/20260406175756.134567-4-justin.chen@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 22 ++++++++-----------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 0fe11e98f738d..f012025a517dd 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3465,27 +3465,23 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
 static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	u32 int1_enable = 0;
-	unsigned int q;
+	struct bcmgenet_tx_ring *ring = &priv->tx_rings[txqueue];
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
 
 	netif_dbg(priv, tx_err, dev, "bcmgenet_timeout\n");
 
-	for (q = 0; q <= priv->hw_params->tx_queues; q++)
-		bcmgenet_dump_tx_queue(&priv->tx_rings[q]);
-
-	bcmgenet_tx_reclaim_all(dev);
+	bcmgenet_dump_tx_queue(ring);
 
-	for (q = 0; q <= priv->hw_params->tx_queues; q++)
-		int1_enable |= (1 << q);
+	bcmgenet_tx_reclaim(dev, ring, true);
 
-	/* Re-enable TX interrupts if disabled */
-	bcmgenet_intrl2_1_writel(priv, int1_enable, INTRL2_CPU_MASK_CLEAR);
+	/* Re-enable the TX interrupt for this ring */
+	bcmgenet_intrl2_1_writel(priv, 1 << txqueue, INTRL2_CPU_MASK_CLEAR);
 
-	netif_trans_update(dev);
+	txq_trans_cond_update(txq);
 
-	BCMGENET_STATS64_INC((&priv->tx_rings[txqueue].stats64), errors);
+	BCMGENET_STATS64_INC((&ring->stats64), errors);
 
-	netif_tx_wake_all_queues(dev);
+	netif_tx_wake_queue(txq);
 }
 
 #define MAX_MDF_FILTER	17
-- 
2.53.0




