Return-Path: <stable+bounces-109509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C0A16C83
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BA71889B6A
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3761B87D7;
	Mon, 20 Jan 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="oai8Q/QK"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63271FC8;
	Mon, 20 Jan 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737377176; cv=none; b=JSMjZi5rQHYzUwhhBHD2CATgmAmCalUeXe0cIjLHADKE83kOWcxM/L7yHagQaqYh6PsGuGFSC1ZzGAMJF6NHge6KCbgq/lATrg+w+HvrGQrZ18Im9lHOcOL4QO+bC/WURVyGFQ823n42rSQ5lHjmQldU7f6DHL3tmLvZkAdEYn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737377176; c=relaxed/simple;
	bh=ckmUieoQ6c7b2h5qvdikaklIDj7v6vTDGluUVK1/L88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUhtJvOaqVjPUicDiGfkrSrysJgd2hdGUP1o2R2O+wE8VtDNnvSXSZ80fGxp+D1e8qQyJLpOEdJMS5r2q8P85f4T8j/7L5T8mb1I7ftfjPyfQXJQ+514QbVBlIKQilgYaca/gjXgpXJZ4sMwxoDivoU4ZB85Z6zqEyHq5DO0juk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=oai8Q/QK; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737377171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mXZ3I+8rEu5hC7Bbr/07M4uZY5uMU2tu8N9VtF7I1iA=;
	b=oai8Q/QKw5LqOWxxqAprZkqYpgoN8NZC/ObNCToUubGbEn/gh/nB7CRoHqDAkGqcegZSie
	W94FUdMXxAEa6f+YMfQ1Cxato7KLUzk2lCNMiEWVD63EuGJfOkqxUPSddTfEoLjGmSlKQL
	o9v/OvTZbUY9iASnWG4hyWlVn87tQy0=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nick Child <nnac123@linux.ibm.com>,
	Dany Madden <drt@linux.ibm.com>,
	Lijun Pan <ljp@linux.ibm.com>,
	Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10] ibmvnic: Add tx check to prevent skb leak
Date: Mon, 20 Jan 2025 15:46:10 +0300
Message-ID: <20250120124611.51436-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nick Child <nnac123@linux.ibm.com>

From: Nick Child <nnac123@linux.ibm.com>

commit 0983d288caf984de0202c66641577b739caad561 upstream.

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
[Denis: minor fix to resolve merge conflict.]
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
Backport fix for CVE-2024-41066
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-41066
---
 drivers/net/ethernet/ibm/ibmvnic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 84da6ccaf339..439796975cbf 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1625,6 +1625,18 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	    (tx_pool->consumer_index + 1) % tx_pool->num_buffers;
 
 	tx_buff = &tx_pool->tx_buff[index];
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
 	tx_buff->data_dma[0] = data_dma_addr;
 	tx_buff->data_len[0] = skb->len;
-- 
2.43.0


