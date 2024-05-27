Return-Path: <stable+bounces-46354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696EF8D033F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A92129F6FC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4710E16FF3E;
	Mon, 27 May 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnpCaEUF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009315FD04;
	Mon, 27 May 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819217; cv=none; b=MJUIt/90QUZ82Qb97X/C2rHHnzx+vexUaA0KzUVCFZd4v0M0j1HxvixAhlbSqP9TNDm4BJU5TnBhKRcYD68E6T1UFyGGvA/iyw3uLQXtesuPLfvVcS79x1i1AhmtdcagJZ0x/HiEinXi17ofDs8Zu3JXZBIDM5YwcFKRpB+aqFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819217; c=relaxed/simple;
	bh=+V0FDSzG+6YYenFIDE+4ZYoVCvKbhYefr+hUGjhfkAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDesMTXxpviGMhLZzqgN8ze5E+2wl30vrTpbTopAYdNzS+zFOPLm4oLPH2M0T8x1RRfSkCFCOTrUTPtzzqxbomNW/2Sh02DZwFBe1dWho53m/+qbahgp5Atqe5C9mUIY84SYj6K5+d2xuiwEQpjXouzk+vnMXmCikZKVq2ma+Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnpCaEUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5076BC2BBFC;
	Mon, 27 May 2024 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819216;
	bh=+V0FDSzG+6YYenFIDE+4ZYoVCvKbhYefr+hUGjhfkAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnpCaEUFduQ0GSAKbIL3JAF/bxp9CIJ6EqVHCRBiHnO0Nu4gHnQUyLT30gZ4g5LwD
	 dJ8wAtAqDRjToh+dHSQmgoE5X+FGeE+VKDjvWSO9D/Ay+cWyK1ncS/QEkcHbU94NLm
	 KCbFsJudzazN1Z9lCBefMkefZsovfoQXCztb4gFXI7hhteJw1xNpy/V0x8f/pVhWK7
	 j9tDeF0zubhjYKoNho2r4WaDPWsqiM9AYmiidIrxzVRFJNaNvQs2OUB4QxYKfac50W
	 sfnclI0EoBeLjfMJQe3XVzV1vcqBiZe2Lk8WtnehU0Xl94Xzyaqzblf1COb1rJDN0T
	 lp4O05bix2Yqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Arinzon <darinzon@amazon.com>,
	Shahar Itzko <itzko@amazon.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shayagr@amazon.com,
	akiyano@amazon.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kheib@redhat.com,
	bigeasy@linutronix.de,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 34/35] net: ena: Add validation for completion descriptors consistency
Date: Mon, 27 May 2024 10:11:39 -0400
Message-ID: <20240527141214.3844331-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527141214.3844331-1-sashal@kernel.org>
References: <20240527141214.3844331-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit b37b98a3a0c1198bafe8c2d9ce0bc845b4e7a9a7 ]

Validate that `first` flag is set only for the first
descriptor in multi-buffer packets.
In case of an invalid descriptor, a reset will occur.
A new reset reason for RX data corruption has been added.

Signed-off-by: Shahar Itzko <itzko@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240512134637.25299-4-darinzon@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_eth_com.c | 37 ++++++++++++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  2 +
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |  1 +
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index 933e619b3a313..4c6e07aa4bbb5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -229,30 +229,43 @@ static struct ena_eth_io_rx_cdesc_base *
 		idx * io_cq->cdesc_entry_size_in_bytes);
 }
 
-static u16 ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
-					   u16 *first_cdesc_idx)
+static int ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
+				    u16 *first_cdesc_idx,
+				    u16 *num_descs)
 {
+	u16 count = io_cq->cur_rx_pkt_cdesc_count, head_masked;
 	struct ena_eth_io_rx_cdesc_base *cdesc;
-	u16 count = 0, head_masked;
 	u32 last = 0;
 
 	do {
+		u32 status;
+
 		cdesc = ena_com_get_next_rx_cdesc(io_cq);
 		if (!cdesc)
 			break;
+		status = READ_ONCE(cdesc->status);
 
 		ena_com_cq_inc_head(io_cq);
+		if (unlikely((status & ENA_ETH_IO_RX_CDESC_BASE_FIRST_MASK) >>
+		    ENA_ETH_IO_RX_CDESC_BASE_FIRST_SHIFT && count != 0)) {
+			struct ena_com_dev *dev = ena_com_io_cq_to_ena_dev(io_cq);
+
+			netdev_err(dev->net_device,
+				   "First bit is on in descriptor #%d on q_id: %d, req_id: %u\n",
+				   count, io_cq->qid, cdesc->req_id);
+			return -EFAULT;
+		}
 		count++;
-		last = (READ_ONCE(cdesc->status) & ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
-		       ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT;
+		last = (status & ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
+			ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT;
 	} while (!last);
 
 	if (last) {
 		*first_cdesc_idx = io_cq->cur_rx_pkt_cdesc_start_idx;
-		count += io_cq->cur_rx_pkt_cdesc_count;
 
 		head_masked = io_cq->head & (io_cq->q_depth - 1);
 
+		*num_descs = count;
 		io_cq->cur_rx_pkt_cdesc_count = 0;
 		io_cq->cur_rx_pkt_cdesc_start_idx = head_masked;
 
@@ -260,11 +273,11 @@ static u16 ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 			   "ENA q_id: %d packets were completed. first desc idx %u descs# %d\n",
 			   io_cq->qid, *first_cdesc_idx, count);
 	} else {
-		io_cq->cur_rx_pkt_cdesc_count += count;
-		count = 0;
+		io_cq->cur_rx_pkt_cdesc_count = count;
+		*num_descs = 0;
 	}
 
-	return count;
+	return 0;
 }
 
 static int ena_com_create_meta(struct ena_com_io_sq *io_sq,
@@ -539,10 +552,14 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 	u16 cdesc_idx = 0;
 	u16 nb_hw_desc;
 	u16 i = 0;
+	int rc;
 
 	WARN(io_cq->direction != ENA_COM_IO_QUEUE_DIRECTION_RX, "wrong Q type");
 
-	nb_hw_desc = ena_com_cdesc_rx_pkt_get(io_cq, &cdesc_idx);
+	rc = ena_com_cdesc_rx_pkt_get(io_cq, &cdesc_idx, &nb_hw_desc);
+	if (unlikely(rc != 0))
+		return -EFAULT;
+
 	if (nb_hw_desc == 0) {
 		ena_rx_ctx->descs = nb_hw_desc;
 		return 0;
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index be5acfa41ee0c..8db05f7544f90 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1347,6 +1347,8 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	if (rc == -ENOSPC) {
 		ena_increase_stat(&rx_ring->rx_stats.bad_desc_num, 1, &rx_ring->syncp);
 		ena_reset_device(adapter, ENA_REGS_RESET_TOO_MANY_RX_DESCS);
+	} else if (rc == -EFAULT) {
+		ena_reset_device(adapter, ENA_REGS_RESET_RX_DESCRIPTOR_MALFORMED);
 	} else {
 		ena_increase_stat(&rx_ring->rx_stats.bad_req_id, 1,
 				  &rx_ring->syncp);
diff --git a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
index 2c3d6a77ea79f..a2efebafd686a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
@@ -22,6 +22,7 @@ enum ena_regs_reset_reason_types {
 	ENA_REGS_RESET_GENERIC                      = 13,
 	ENA_REGS_RESET_MISS_INTERRUPT               = 14,
 	ENA_REGS_RESET_SUSPECTED_POLL_STARVATION    = 15,
+	ENA_REGS_RESET_RX_DESCRIPTOR_MALFORMED	    = 16,
 };
 
 /* ena_registers offsets */
-- 
2.43.0


