Return-Path: <stable+bounces-58829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFFC92C080
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1950E28ABC8
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F65D1CE0AE;
	Tue,  9 Jul 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXoMcsEu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB51CE0A3;
	Tue,  9 Jul 2024 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542202; cv=none; b=eTLVmwXGYQn/SsVYUqUnV475TXsG8IJ9QXA6NVd0CfB0HdQB240U0BWBOnkvTVQ74PLRwnFjftmUnxP/W7sJkiNIj07/LGinJ3oimeQqYXYIAes6d2anjs4Fs+4b3tqzEMkaOz1FUMlMPCDbBqSukX/OwvikXIC9zFvDa01KkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542202; c=relaxed/simple;
	bh=NsTaBH4LXz2kgAxnFxnMLIQDl1UdmzXG53VYfI8BPEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twpxn+yXfUeS7S/9uYKXAp9y3GHzFeGgfWDiKNWxw3kTzRYbrL4xL6HuxjDYKW9Bc/50eWoX334n5Cc5rbPbyQylHnjNgSpT6DyO9O0jcw0Wd52gr6whGv5Ia5vwtJymZ8cjmXWxhpFQnPhVdQYhLalutA8Kuzz6TU8JgPOpC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXoMcsEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C6AC3277B;
	Tue,  9 Jul 2024 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542202;
	bh=NsTaBH4LXz2kgAxnFxnMLIQDl1UdmzXG53VYfI8BPEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXoMcsEuXhhDLzsPoeyI3Q6CG72U+f0RUJOBb1Da8smdsltxYQ00snqJtP/nVk+Uu
	 9hMejV3T0KWO8K/j4JW6MFkYy4uM04BPP4TwAmuv4Aiv/E/u7lChOOW1k6yXLyLd5s
	 /y9aPleKSl7ZWCaGMVKDPgwfcqdHBNiBid4iKf7BZu6WuhNq/PfITESsxUhiUHxHJJ
	 dydsbrvNMEA6r9nQZuL0j+UxKK2iovdqogBzexI5Qda8SneuoD3vlnrZOxWMHVwK4o
	 xPmuREpNop4fjucFifOqbUIs8VerBBvEm03jbduqjDqKagGFKraW+/TipskdmnX/ty
	 fo7WEZ/viMomQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nick Child <nnac123@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 27/33] ibmvnic: Add tx check to prevent skb leak
Date: Tue,  9 Jul 2024 12:21:53 -0400
Message-ID: <20240709162224.31148-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
Content-Transfer-Encoding: 8bit

From: Nick Child <nnac123@linux.ibm.com>

[ Upstream commit 0983d288caf984de0202c66641577b739caad561 ]

Below is a summary of how the driver stores a reference to an skb during
transmit:
    tx_buff[free_map[consumer_index]]->skb = new_skb;
    free_map[consumer_index] = IBMVNIC_INVALID_MAP;
    consumer_index ++;
Where variable data looks like this:
    free_map == [4, IBMVNIC_INVALID_MAP, IBMVNIC_INVALID_MAP, 0, 3]
                                               	consumer_index^
    tx_buff == [skb=null, skb=<ptr>, skb=<ptr>, skb=null, skb=null]

The driver has checks to ensure that free_map[consumer_index] pointed to
a valid index but there was no check to ensure that this index pointed
to an unused/null skb address. So, if, by some chance, our free_map and
tx_buff lists become out of sync then we were previously risking an
skb memory leak. This could then cause tcp congestion control to stop
sending packets, eventually leading to ETIMEDOUT.

Therefore, add a conditional to ensure that the skb address is null. If
not then warn the user (because this is still a bug that should be
patched) and free the old pointer to prevent memleak/tcp problems.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index cdf5251e56795..e6e03cb014cb7 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2478,6 +2478,18 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	    (tx_pool->consumer_index + 1) % tx_pool->num_buffers;
 
 	tx_buff = &tx_pool->tx_buff[bufidx];
+
+	/* Sanity checks on our free map to make sure it points to an index
+	 * that is not being occupied by another skb. If skb memory is
+	 * not freed then we see congestion control kick in and halt tx.
+	 */
+	if (unlikely(tx_buff->skb)) {
+		dev_warn_ratelimited(dev, "TX free map points to untracked skb (%s %d idx=%d)\n",
+				     skb_is_gso(skb) ? "tso_pool" : "tx_pool",
+				     queue_num, bufidx);
+		dev_kfree_skb_any(tx_buff->skb);
+	}
+
 	tx_buff->skb = skb;
 	tx_buff->index = bufidx;
 	tx_buff->pool_index = queue_num;
-- 
2.43.0


