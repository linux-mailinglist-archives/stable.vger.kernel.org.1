Return-Path: <stable+bounces-51879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBD390720B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DEF1F24ADD
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F1143724;
	Thu, 13 Jun 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EGOVkorC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E31428EF;
	Thu, 13 Jun 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282584; cv=none; b=INLGkvkxHA+ByHq6S26717tobV0tbiKFTbpY2MBBRn13wGJyBlFJiHl69b1Cat048SGcwkBO1OIoq35atP9ysTQ10cs4yfHoTQyCuJed1zXzzfqvQ0yUb2puTHoL8iOyTFGupK5WhOvfxEVcT4IPUrUmvXPwKS2h9FgV842xuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282584; c=relaxed/simple;
	bh=lnwnmS5jg1N5O7uGAIgAkwf/mqfMToatRA/QjJ6U/aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M06NPI1aqdtBxXqPyk8tbbYq0d+GcnKkSEFmm1mEbELN1bTwgj+iFUiaXK4kcoFv4AQ50ZfGV9PdPzQYeEsMlB23/tlW3SiR20VkISqBSRomaUUBy1EiH15yLNSqv9MaJm9DQ2F3Vbn+e9zePV2k0raa1XcJqLxtV7MmriJf1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EGOVkorC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A5EC2BBFC;
	Thu, 13 Jun 2024 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282583;
	bh=lnwnmS5jg1N5O7uGAIgAkwf/mqfMToatRA/QjJ6U/aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGOVkorCOF8SJMlClbpmYTxgrDP37O83aN1+0qgMNCsWu1sBQvOSRZdyUCsKruA5o
	 gzPgUrgBkyzE3kAsqdMzZdwZG2kz4iGtiAKe8d4fsSLZATqQwAHzTkfz1sJpKS7XYE
	 QEVoV2q/NWTUPGK3Z1vOucMBSBWPR/W0JYr3yzMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nati Koler <nkoler@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 327/402] net: ena: Extract recurring driver reset code into a function
Date: Thu, 13 Jun 2024 13:34:44 +0200
Message-ID: <20240613113314.894528552@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit 9fe890cc5bb84d6859d9a2422830b7fd6fd20521 ]

Create an inline function for resetting the driver
to reduce code duplication.

Signed-off-by: Nati Koler <nkoler@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2dc8b1e7177d ("net: ena: Fix redundant device NUMA node override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 45 ++++++--------------
 drivers/net/ethernet/amazon/ena/ena_netdev.h |  9 ++++
 2 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 3ea449be7bdc3..cf8148a159ee0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -103,7 +103,7 @@ static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	if (test_and_set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags))
 		return;
 
-	adapter->reset_reason = ENA_REGS_RESET_OS_NETDEV_WD;
+	ena_reset_device(adapter, ENA_REGS_RESET_OS_NETDEV_WD);
 	ena_increase_stat(&adapter->dev_stats.tx_timeout, 1, &adapter->syncp);
 
 	netif_err(adapter, tx_err, dev, "Transmit time out\n");
@@ -166,11 +166,9 @@ static int ena_xmit_common(struct net_device *dev,
 			  "Failed to prepare tx bufs\n");
 		ena_increase_stat(&ring->tx_stats.prepare_ctx_err, 1,
 				  &ring->syncp);
-		if (rc != -ENOMEM) {
-			adapter->reset_reason =
-				ENA_REGS_RESET_DRIVER_INVALID_STATE;
-			set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
-		}
+		if (rc != -ENOMEM)
+			ena_reset_device(adapter,
+					 ENA_REGS_RESET_DRIVER_INVALID_STATE);
 		return rc;
 	}
 
@@ -1297,10 +1295,8 @@ static int handle_invalid_req_id(struct ena_ring *ring, u16 req_id,
 			  req_id);
 
 	ena_increase_stat(&ring->tx_stats.bad_req_id, 1, &ring->syncp);
+	ena_reset_device(ring->adapter, ENA_REGS_RESET_INV_TX_REQ_ID);
 
-	/* Trigger device reset */
-	ring->adapter->reset_reason = ENA_REGS_RESET_INV_TX_REQ_ID;
-	set_bit(ENA_FLAG_TRIGGER_RESET, &ring->adapter->flags);
 	return -EFAULT;
 }
 
@@ -1463,10 +1459,7 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		netif_err(adapter, rx_err, rx_ring->netdev,
 			  "Page is NULL. qid %u req_id %u\n", rx_ring->qid, req_id);
 		ena_increase_stat(&rx_ring->rx_stats.bad_req_id, 1, &rx_ring->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_INV_RX_REQ_ID;
-		/* Make sure reset reason is set before triggering the reset */
-		smp_mb__before_atomic();
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+		ena_reset_device(adapter, ENA_REGS_RESET_INV_RX_REQ_ID);
 		return NULL;
 	}
 
@@ -1806,15 +1799,12 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	if (rc == -ENOSPC) {
 		ena_increase_stat(&rx_ring->rx_stats.bad_desc_num, 1,
 				  &rx_ring->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_TOO_MANY_RX_DESCS;
+		ena_reset_device(adapter, ENA_REGS_RESET_TOO_MANY_RX_DESCS);
 	} else {
 		ena_increase_stat(&rx_ring->rx_stats.bad_req_id, 1,
 				  &rx_ring->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_INV_RX_REQ_ID;
+		ena_reset_device(adapter, ENA_REGS_RESET_INV_RX_REQ_ID);
 	}
-
-	set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
-
 	return 0;
 }
 
@@ -3740,9 +3730,8 @@ static int check_for_rx_interrupt_queue(struct ena_adapter *adapter,
 		netif_err(adapter, rx_err, adapter->netdev,
 			  "Potential MSIX issue on Rx side Queue = %d. Reset the device\n",
 			  rx_ring->qid);
-		adapter->reset_reason = ENA_REGS_RESET_MISS_INTERRUPT;
-		smp_mb__before_atomic();
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+
+		ena_reset_device(adapter, ENA_REGS_RESET_MISS_INTERRUPT);
 		return -EIO;
 	}
 
@@ -3779,9 +3768,7 @@ static int check_missing_comp_in_tx_queue(struct ena_adapter *adapter,
 			netif_err(adapter, tx_err, adapter->netdev,
 				  "Potential MSIX issue on Tx side Queue = %d. Reset the device\n",
 				  tx_ring->qid);
-			adapter->reset_reason = ENA_REGS_RESET_MISS_INTERRUPT;
-			smp_mb__before_atomic();
-			set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+			ena_reset_device(adapter, ENA_REGS_RESET_MISS_INTERRUPT);
 			return -EIO;
 		}
 
@@ -3807,9 +3794,7 @@ static int check_missing_comp_in_tx_queue(struct ena_adapter *adapter,
 			  "The number of lost tx completions is above the threshold (%d > %d). Reset the device\n",
 			  missed_tx,
 			  adapter->missing_tx_completion_threshold);
-		adapter->reset_reason =
-			ENA_REGS_RESET_MISS_TX_CMPL;
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+		ena_reset_device(adapter, ENA_REGS_RESET_MISS_TX_CMPL);
 		rc = -EIO;
 	}
 
@@ -3933,8 +3918,7 @@ static void check_for_missing_keep_alive(struct ena_adapter *adapter)
 			  "Keep alive watchdog timeout.\n");
 		ena_increase_stat(&adapter->dev_stats.wd_expired, 1,
 				  &adapter->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_KEEP_ALIVE_TO;
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+		ena_reset_device(adapter, ENA_REGS_RESET_KEEP_ALIVE_TO);
 	}
 }
 
@@ -3945,8 +3929,7 @@ static void check_for_admin_com_state(struct ena_adapter *adapter)
 			  "ENA admin queue is not in running state!\n");
 		ena_increase_stat(&adapter->dev_stats.admin_q_pause, 1,
 				  &adapter->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_ADMIN_TO;
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+		ena_reset_device(adapter, ENA_REGS_RESET_ADMIN_TO);
 	}
 }
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index bf2a39c91c00d..4ad5a086b47ea 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -410,6 +410,15 @@ int ena_set_rx_copybreak(struct ena_adapter *adapter, u32 rx_copybreak);
 
 int ena_get_sset_count(struct net_device *netdev, int sset);
 
+static inline void ena_reset_device(struct ena_adapter *adapter,
+				    enum ena_regs_reset_reason_types reset_reason)
+{
+	adapter->reset_reason = reset_reason;
+	/* Make sure reset reason is set before triggering the reset */
+	smp_mb__before_atomic();
+	set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+}
+
 enum ena_xdp_errors_t {
 	ENA_XDP_ALLOWED = 0,
 	ENA_XDP_CURRENT_MTU_TOO_LARGE,
-- 
2.43.0




