Return-Path: <stable+bounces-46997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A442B8D0C26
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206851F24989
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64D15FD07;
	Mon, 27 May 2024 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AgJUAKt/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D601863F;
	Mon, 27 May 2024 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837395; cv=none; b=bQlmVXPeFqhGu0AuOeJ0axu3dBkwjAiF9th61CRKtuhDzndfzCxsiVAb9woihVy9KrX5k+iTNg3kS7DYID4DrZCjOrizI03xBZaJOrot2vfXTRfyj3CP8zJ/7UodhtxfA5bUJMDXInhH3Z5K2eJgSSuS5dZ8dT2yIMQFBXaxyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837395; c=relaxed/simple;
	bh=naTuz6NG7gcKuKWWQdsZKgSUJjL9YLvuFTPVXvooRQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX1r7Od+cb50gLPb0Xkeu3MQhw8fH7vo2Izkz1Yqpm7KT0PYak27NjbGY7XRUW6TCVXEI0yydIqd75hHi9u+RkHZkh68OS6Uiba7RubZesvSY3RCzlUIGgp92pOYavGMegBKazj8NdIwJO8ItFZS9y8983IcYaB3UiqRxkJR1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AgJUAKt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E82CC2BBFC;
	Mon, 27 May 2024 19:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837395;
	bh=naTuz6NG7gcKuKWWQdsZKgSUJjL9YLvuFTPVXvooRQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgJUAKt/LXlGmSULALtHJWgs8+TNO7xU1NtK7fTPGiNKfMr1HBEPhVsIZ5C5tCDXu
	 LSQ1cES5dlC3ySP0gBjGk0/y6a62mWs6tzTLVkdKgR3LwyzlY14y9KFwwNHRGvElew
	 5WcVBNX9GUXZKa+0AP+1NASCbr9TARcG+O+gVDRM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 424/427] net: txgbe: fix to control VLAN strip
Date: Mon, 27 May 2024 20:57:51 +0200
Message-ID: <20240527185635.826840101@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiawen Wu <jiawenwu@trustnetic.com>

[ Upstream commit 1d3c6414950badaa38002af3b5857e01a21f01e9 ]

When VLAN tag strip is changed to enable or disable, the hardware requires
the Rx ring to be in a disabled state, otherwise the feature cannot be
changed.

Fixes: f3b03c655f67 ("net: wangxun: Implement vlan add and kill functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  2 ++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  6 ++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 22 ++++++++++++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 18 +++++++----
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 18 +++++++----
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 30 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
 7 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 945c13d1a9829..c09a6f7445754 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1958,6 +1958,8 @@ int wx_sw_init(struct wx *wx)
 		return -ENOMEM;
 	}
 
+	bitmap_zero(wx->state, WX_STATE_NBITS);
+
 	return 0;
 }
 EXPORT_SYMBOL(wx_sw_init);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index d0cb09a4bd3d4..07ba3a270a14f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2692,9 +2692,9 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 	netdev->features = features;
 
-	if (changed &
-	    (NETIF_F_HW_VLAN_CTAG_RX |
-	     NETIF_F_HW_VLAN_STAG_RX))
+	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
+		wx->do_reset(netdev);
+	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 1fdeb464d5f4a..5aaf7b1fa2db9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -982,8 +982,13 @@ struct wx_hw_stats {
 	u64 qmprc;
 };
 
+enum wx_state {
+	WX_STATE_RESETTING,
+	WX_STATE_NBITS,		/* must be last */
+};
 struct wx {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+	DECLARE_BITMAP(state, WX_STATE_NBITS);
 
 	void *priv;
 	u8 __iomem *hw_addr;
@@ -1071,6 +1076,8 @@ struct wx {
 	u64 hw_csum_rx_good;
 	u64 hw_csum_rx_error;
 	u64 alloc_rx_buff_failed;
+
+	void (*do_reset)(struct net_device *netdev);
 };
 
 #define WX_INTR_ALL (~0ULL)
@@ -1131,4 +1138,19 @@ static inline struct wx *phylink_to_wx(struct phylink_config *config)
 	return container_of(config, struct wx, phylink_config);
 }
 
+static inline int wx_set_state_reset(struct wx *wx)
+{
+	u8 timeout = 50;
+
+	while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
+		timeout--;
+		if (!timeout)
+			return -EBUSY;
+
+		usleep_range(1000, 2000);
+	}
+
+	return 0;
+}
+
 #endif /* _WX_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 786a652ae64f3..46a5a3e952021 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -52,7 +52,7 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	struct wx *wx = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
 	struct wx_ring *temp_ring;
-	int i;
+	int i, err = 0;
 
 	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
 	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
@@ -64,6 +64,10 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	    new_rx_count == wx->rx_ring_count)
 		return 0;
 
+	err = wx_set_state_reset(wx);
+	if (err)
+		return err;
+
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
 			wx->tx_ring[i]->count = new_tx_count;
@@ -72,14 +76,16 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
-		return 0;
+		goto clear_reset;
 	}
 
 	/* allocate temporary buffer to store rings in */
 	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
 	temp_ring = kvmalloc_array(i, sizeof(struct wx_ring), GFP_KERNEL);
-	if (!temp_ring)
-		return -ENOMEM;
+	if (!temp_ring) {
+		err = -ENOMEM;
+		goto clear_reset;
+	}
 
 	ngbe_down(wx);
 
@@ -89,7 +95,9 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_configure(wx);
 	ngbe_up(wx);
 
-	return 0;
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	return err;
 }
 
 static int ngbe_set_channels(struct net_device *dev,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index db675512ce4dc..31fde3fa7c6b5 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -19,7 +19,7 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	struct wx *wx = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
 	struct wx_ring *temp_ring;
-	int i;
+	int i, err = 0;
 
 	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
 	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
@@ -31,6 +31,10 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	    new_rx_count == wx->rx_ring_count)
 		return 0;
 
+	err = wx_set_state_reset(wx);
+	if (err)
+		return err;
+
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
 			wx->tx_ring[i]->count = new_tx_count;
@@ -39,14 +43,16 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
-		return 0;
+		goto clear_reset;
 	}
 
 	/* allocate temporary buffer to store rings in */
 	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
 	temp_ring = kvmalloc_array(i, sizeof(struct wx_ring), GFP_KERNEL);
-	if (!temp_ring)
-		return -ENOMEM;
+	if (!temp_ring) {
+		err = -ENOMEM;
+		goto clear_reset;
+	}
 
 	txgbe_down(wx);
 
@@ -55,7 +61,9 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 
 	txgbe_up(wx);
 
-	return 0;
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	return err;
 }
 
 static int txgbe_set_channels(struct net_device *dev,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index b3c0058b045da..8c7a74981b907 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -269,6 +269,8 @@ static int txgbe_sw_init(struct wx *wx)
 	wx->tx_work_limit = TXGBE_DEFAULT_TX_WORK;
 	wx->rx_work_limit = TXGBE_DEFAULT_RX_WORK;
 
+	wx->do_reset = txgbe_do_reset;
+
 	return 0;
 }
 
@@ -421,6 +423,34 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void txgbe_reinit_locked(struct wx *wx)
+{
+	int err = 0;
+
+	netif_trans_update(wx->netdev);
+
+	err = wx_set_state_reset(wx);
+	if (err) {
+		wx_err(wx, "wait device reset timeout\n");
+		return;
+	}
+
+	txgbe_down(wx);
+	txgbe_up(wx);
+
+	clear_bit(WX_STATE_RESETTING, wx->state);
+}
+
+void txgbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		txgbe_reinit_locked(wx);
+	else
+		txgbe_reset(wx);
+}
+
 static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_open               = txgbe_open,
 	.ndo_stop               = txgbe_close,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 1b4ff50d58571..f434a7865cb7b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -134,6 +134,7 @@ extern char txgbe_driver_name[];
 void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
+void txgbe_do_reset(struct net_device *netdev);
 
 #define NODE_PROP(_NAME, _PROP)			\
 	(const struct software_node) {		\
-- 
2.43.0




