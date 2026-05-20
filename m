Return-Path: <stable+bounces-253296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OjIGJMvDmoK7wUAu9opvQ
	(envelope-from <stable+bounces-253296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:02:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C357159BA60
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1549B2A00E1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E093FBEB3;
	Wed, 20 May 2026 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUt7diFb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243940242E;
	Wed, 20 May 2026 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302908; cv=none; b=pNwq7hgBg9TCitkVUDTVhLPwfVmkK1FaZTqfVkAkPaEOLHvOHRoUjHeT2eXydnUDFbxrfvInd7+rkhgiBIhchlf2HlmjbBPeMko2eY3iZHhaJ0uhQPDkfrB7lqn6N9wzcivTrF4QYi9W9xWEUv/6518mPLu5CZ5RiM/GNO08xu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302908; c=relaxed/simple;
	bh=AFh+sKIlYb4n4OPYS5xjNwOnD9v9GlALIAgG1nLPnJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLgoU47eT+GyF+TAR/0MkmNFv7g8HWzKCrmh10CK/jFRFWzt12fcOelrKejacmuXCQTVMxJ1Per0eRO3tCqn3wvHYpllp0tD+PP7mjJKDXT8o1fa0Xap9DGnt1hB1lzSbYLp6/SE5zpYXkp7g5aAswuOY5mYyyV3IiRcwO0iuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUt7diFb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87561F000E9;
	Wed, 20 May 2026 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302906;
	bh=kikeiQsGhG39IJf+2QHitzPeSezdq8cvkNZhZC+j0cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PUt7diFb4twN+lpRHtjDozBSoNyRXRyOHApFLyRwoUDWwF+vWmBqAIQo6ctEUkC4e
	 X9xd8AaoUWfGkd7LhMr65mySvXjKwiW7AiZuhGQa1YpUSUG7bY3KGLBjhNENqysaGa
	 rGYR8Ttuj7n+vjK2g+6CyceBHTA4UFwiXUe0Zoqg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 446/508] net: bcmgenet: fix leaking free_bds
Date: Wed, 20 May 2026 18:24:29 +0200
Message-ID: <20260520162108.262101640@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253296-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,broadcom.com:email,tipi-net.de:email]
X-Rspamd-Queue-Id: C357159BA60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justin.chen@broadcom.com>

[ Upstream commit 3f3168300efb839028328d720ab3962f91d6a0d0 ]

While reclaiming the tx queue we fast forward the write pointer to
drop any data in flight. These dropped frames are not added back
to the pool of free bds. We also need to tell the netdev that we
are dropping said data.

Fixes: f1bacae8b655 ("net: bcmgenet: support reclaiming unsent Tx packets")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Nicolai Buchwitz <nb@tipi-net.de>
Link: https://patch.msgid.link/20260406175756.134567-3-justin.chen@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index d9bd011e0d7c8..d1f5ae56fa417 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1942,6 +1942,7 @@ static unsigned int bcmgenet_tx_reclaim(struct net_device *dev,
 		drop = (ring->prod_index - ring->c_index) & DMA_C_INDEX_MASK;
 		released += drop;
 		ring->prod_index = ring->c_index & DMA_C_INDEX_MASK;
+		ring->free_bds += drop;
 		while (drop--) {
 			cb_ptr = bcmgenet_put_txcb(priv, ring);
 			skb = cb_ptr->skb;
@@ -1953,6 +1954,7 @@ static unsigned int bcmgenet_tx_reclaim(struct net_device *dev,
 		}
 		if (skb)
 			dev_consume_skb_any(skb);
+		netdev_tx_reset_queue(netdev_get_tx_queue(dev, ring->index));
 		bcmgenet_tdma_ring_writel(priv, ring->index,
 					  ring->prod_index, TDMA_PROD_INDEX);
 		wr_ptr = ring->write_ptr * WORDS_PER_BD(priv);
-- 
2.53.0




