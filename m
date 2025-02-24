Return-Path: <stable+bounces-119013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DF0A42445
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199F5442180
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FF915FA7B;
	Mon, 24 Feb 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y2zDUWfG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B24A33;
	Mon, 24 Feb 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408023; cv=none; b=m17RZf1XL60W+PSTSRzb3dVwV5vsBCQ5d6wsSdoTu9j7gVR/RZ+hB3PM4EIcW7PYpPSeAc+n7upqvCBk3vYOOgnCVuX7Y6s9835FEMpiougwY5G0XMzVofj24OmDxwOgyBuPQOwHjOWsqVeGuecQDPhtNZ2dlOet6y2Zp+7Pr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408023; c=relaxed/simple;
	bh=5vjmiRQmr6n2OxUUHw4DTT597qdS0PDMSeQLl1OZCQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9NOmAmzRVreIBXouK10lyIRtY3qrVTQ9cdzMWfW2IvGoq428eRvYJmwDxOVfWrUrthPj3dFb3JIP3GamEFlN9KEUBrDSF4/YwQmBZOvLnDf6JIBwzCUAH5GDIBzl/g9i/IQlNRZGl0rhsqvKyQjFw89oxCFNpjhcBRSypLXjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y2zDUWfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75FDC4CED6;
	Mon, 24 Feb 2025 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408023;
	bh=5vjmiRQmr6n2OxUUHw4DTT597qdS0PDMSeQLl1OZCQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y2zDUWfGxc+VF3mcXjjDfEcaETuFC92NtnuUoQbJ897kz+x0vXstQs7Jlg7MOE6yI
	 Vd5zzAyN5nOn8fDz60Ss/k6xRsvI0Rxkv81s4lDezCm20VAdOaSXkVfJep3nwd8kF+
	 7z2YY3H7ibc6ciqYtfo0Hkia5MFR62CgFewDpKn8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nick Child <nnac123@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 078/140] ibmvnic: Dont reference skb after sending to VIOS
Date: Mon, 24 Feb 2025 15:34:37 +0100
Message-ID: <20250224142606.076592361@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Child <nnac123@linux.ibm.com>

[ Upstream commit bdf5d13aa05ec314d4385b31ac974d6c7e0997c9 ]

Previously, after successfully flushing the xmit buffer to VIOS,
the tx_bytes stat was incremented by the length of the skb.

It is invalid to access the skb memory after sending the buffer to
the VIOS because, at any point after sending, the VIOS can trigger
an interrupt to free this memory. A race between reading skb->len
and freeing the skb is possible (especially during LPM) and will
result in use-after-free:
 ==================================================================
 BUG: KASAN: slab-use-after-free in ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
 Read of size 4 at addr c00000024eb48a70 by task hxecom/14495
 <...>
 Call Trace:
 [c000000118f66cf0] [c0000000018cba6c] dump_stack_lvl+0x84/0xe8 (unreliable)
 [c000000118f66d20] [c0000000006f0080] print_report+0x1a8/0x7f0
 [c000000118f66df0] [c0000000006f08f0] kasan_report+0x128/0x1f8
 [c000000118f66f00] [c0000000006f2868] __asan_load4+0xac/0xe0
 [c000000118f66f20] [c0080000046eac84] ibmvnic_xmit+0x75c/0x1808 [ibmvnic]
 [c000000118f67340] [c0000000014be168] dev_hard_start_xmit+0x150/0x358
 <...>
 Freed by task 0:
 kasan_save_stack+0x34/0x68
 kasan_save_track+0x2c/0x50
 kasan_save_free_info+0x64/0x108
 __kasan_mempool_poison_object+0x148/0x2d4
 napi_skb_cache_put+0x5c/0x194
 net_tx_action+0x154/0x5b8
 handle_softirqs+0x20c/0x60c
 do_softirq_own_stack+0x6c/0x88
 <...>
 The buggy address belongs to the object at c00000024eb48a00 which
  belongs to the cache skbuff_head_cache of size 224
==================================================================

Fixes: 032c5e82847a ("Driver for IBM System i/p VNIC protocol")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250214155233.235559-1-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index cd5224f6c42a3..4f18addc191b8 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2424,6 +2424,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	dma_addr_t data_dma_addr;
 	struct netdev_queue *txq;
 	unsigned long lpar_rc;
+	unsigned int skblen;
 	union sub_crq tx_crq;
 	unsigned int offset;
 	int num_entries = 1;
@@ -2526,6 +2527,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tx_buff->skb = skb;
 	tx_buff->index = bufidx;
 	tx_buff->pool_index = queue_num;
+	skblen = skb->len;
 
 	memset(&tx_crq, 0, sizeof(tx_crq));
 	tx_crq.v1.first = IBMVNIC_CRQ_CMD;
@@ -2616,7 +2618,7 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 		netif_stop_subqueue(netdev, queue_num);
 	}
 
-	tx_bytes += skb->len;
+	tx_bytes += skblen;
 	txq_trans_cond_update(txq);
 	ret = NETDEV_TX_OK;
 	goto out;
-- 
2.39.5




