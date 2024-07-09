Return-Path: <stable+bounces-58795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A365192C014
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EF6285281
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E871B3731;
	Tue,  9 Jul 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSaSOXVk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5651B150B;
	Tue,  9 Jul 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542079; cv=none; b=SfHhxeZnotvhTVyqNGqUY5JNzlOb/R3hPX+2ibwtYSHLzWKXstIt6Ug46ufaUXFp3x9Zax5rBV0de2HgifGZdDfFDeKvz+77hN0Ye9yWBAbhEvAR430ydRTXviasE3HPPV2o1mvF8jXihPKMeXIkTR+2A+74IZ6OKuTBZtt5R0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542079; c=relaxed/simple;
	bh=IoeP0EghkleDF63rHUC/yUuCmqEfS1c9TzRyk2h1YCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RylPTsEe+ninf2N2YqO6O+u6wz7Mwt6N13VIr+vbvMfMQk7/SZkzQa754XNCQBu2r8PvwOWT3hybV2vVGK5qgdrLYbQdZ1vK5LD/l6mckz7BSFEnSMRGpGLj+ijOaMmLQbPsR1Fm2RHAMMzQLpytc+cvI3z+xhTEtGFHEA7AO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSaSOXVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D940C32782;
	Tue,  9 Jul 2024 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542079;
	bh=IoeP0EghkleDF63rHUC/yUuCmqEfS1c9TzRyk2h1YCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSaSOXVkek61vtH1t8xDpIfG7HbSmTg6mNlsjDyIlNPIotkwKoIfTwGG61D7dMpR9
	 L8CuQjEEYymSyPVOwgs/oV89fPgQBHMvxhxrLE3xFiGSQca5rzCLGhq2ckwRyQpYlk
	 OGn2E9v8IVVGOFSFYdJFucUagZR4oWDiWUqG7QxU8qhBKYSJmS7ZDEYnT39AgAlozb
	 Zr3gurLy2VpbVs/pED3wYER/i6emsFEdHTq5gNlMM4aJY2XQCGdO8t5CkxxmNG30s3
	 LRQvpFCCndzaIZ+GZUrHRnRCgkh0ZH3N6tuoU4QX7NUGtSMW0joEfpg3pMsZKpNz8o
	 LTyt5M4z3qmPg==
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
Subject: [PATCH AUTOSEL 6.9 33/40] ibmvnic: Add tx check to prevent skb leak
Date: Tue,  9 Jul 2024 12:19:13 -0400
Message-ID: <20240709162007.30160-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
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
index 30c47b8470ade..381f326b2722b 100644
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


