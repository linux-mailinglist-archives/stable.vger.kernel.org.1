Return-Path: <stable+bounces-58856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D7D92C0CD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2432628A1C7
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D3D182A49;
	Tue,  9 Jul 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTzHYYcY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8CB180043;
	Tue,  9 Jul 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542283; cv=none; b=Usy2n7EKGLAqdjgd+tOttDrD2HDJNl5ECurxInjG3xmSM9eqSSLx/8MstZImbK+L8hTb2d4SRAsbwMyN+aNQMmNUPpxi6ICv7CWkBK/HlD4AT7cXO9yeR3znyP3o5JiNradG/2Sk0OgHU9RxPlFTlGn6IHkuiQ/gUTufEYn7BlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542283; c=relaxed/simple;
	bh=7lRbEQCqQpMupPQ3Pa0KTmdnCD+aCGyVQE+QHBlxQ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CK0p1e4zBa+jchGhmFZVUPhRjESIs0If6ygL+4NGgEn8F2sEwF6JPPnOinaPdmHxFfLcjBCVD2a8KYH2lnQSkBMiqZHnUmt2hE6i429fz6IcRnzigSeGDwO4RZ6K7hUo0Uh4F0v49EtjTN2POYtLUQ0r96vFhFACFqckTb3NdEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTzHYYcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC171C3277B;
	Tue,  9 Jul 2024 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542283;
	bh=7lRbEQCqQpMupPQ3Pa0KTmdnCD+aCGyVQE+QHBlxQ7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTzHYYcYW4IvhVVA06cYBtDd845D/RjRnAHwKWIHi5LbZuQo1L6GAVyl50Z95gPKb
	 na8uGCjEhw70+xDpcVJbim/QZ9y6vvffHzmSVuH/RdY14d6ApiqsndjBkji8x5es8k
	 QO2CN3l//NOYWM3DIKUk+q3yIKez3dDDhHSyEwMN8ebVB9arKwvj6+vIQzkS/CBfJZ
	 b4zkPq9bztSptL2apFKBz28wcraRY8qNu01mQMP8d8rntR0ccZn4QnSt23eWu8Cf3b
	 gi0k10LLtJGmqPuYHVj17riULLF3yGmo2MCLoYpkc9uQlpa2s6NPgNCPSjPcjTc3bD
	 /hF/OI7B+6Lgw==
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
Subject: [PATCH AUTOSEL 6.1 21/27] ibmvnic: Add tx check to prevent skb leak
Date: Tue,  9 Jul 2024 12:23:35 -0400
Message-ID: <20240709162401.31946-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162401.31946-1-sashal@kernel.org>
References: <20240709162401.31946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.97
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
index 157be4e9be4b7..977116a1b3158 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2288,6 +2288,18 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
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


