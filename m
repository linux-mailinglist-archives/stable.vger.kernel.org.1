Return-Path: <stable+bounces-68905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3695348E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A93E282F64
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD921A7074;
	Thu, 15 Aug 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bDxv2xGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1DC19FA99;
	Thu, 15 Aug 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732038; cv=none; b=pMWZYJjKanExyZGvBmSpR6/jdUKHA9uN6V7L1PP4DcIhXRzssWp1yXLhJ7p6CazXqqlWZIBj8mzu3JVoNfRylvkODKRBs9fOLiW4qBAxrq5cpRZZIgF9EPPI0zoCveMxk/+zNZRizkpguYs0Vr+RFsS5UwbGs+8Q7Opk+FzKl+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732038; c=relaxed/simple;
	bh=rCvz1pkf3Jo88hGR8vZ8P1zaxXikPRux1y4WiQLkIYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkGgXwYzKbo97pufbjMX76PEOdQTeaAqduTC1wNvoFddh5mnZ5rI+ztRShE99lpviOElhKiMbvILL3OFZUPwX83AMyVmLUpDAvKDNFfKLafyWLm8qj74HjFz/rfTI22NMicPbiQFQD2w+2AdTOXQLAKlXCItBD3jksbKAagD1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bDxv2xGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C8AC32786;
	Thu, 15 Aug 2024 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732038;
	bh=rCvz1pkf3Jo88hGR8vZ8P1zaxXikPRux1y4WiQLkIYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDxv2xGevV8VU6Cxq5WWCapUpJEA3GB4LRqek6xSTsdSHQtE/mBETMzqj1lZpImRO
	 TQ1rRyMqEI3O7DeP0VErM6adhXaBRFW+K0Dk6S6dGx2DMICuU9fUUxJyLwKma/lZZ3
	 mtKHZVefrGvpNZNCeiUKkyLm+6mj8CGAP1VWJH0w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Ariel Elior <aelior@marvell.com>,
	Shai Malin <smalin@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 056/352] qed: Improve the stack space of filter_config()
Date: Thu, 15 Aug 2024 15:22:02 +0200
Message-ID: <20240815131921.405043470@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shai Malin <smalin@marvell.com>

[ Upstream commit f55e36d5ab76c3097ff36ecea60b91c6b0d80fc8 ]

As it was reported and discussed in: https://lore.kernel.org/lkml/CAHk-=whF9F89vsfH8E9TGc0tZA-yhzi2Di8wOtquNB5vRkFX5w@mail.gmail.com/
This patch improves the stack space of qede_config_rx_mode() by
splitting filter_config() to 3 functions and removing the
union qed_filter_type_params.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: b5d14b0c6716 ("wifi: virt_wifi: avoid reporting connection success with wrong SSID")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c      | 23 ++-------
 .../net/ethernet/qlogic/qede/qede_filter.c    | 47 ++++++++-----------
 include/linux/qed/qed_eth_if.h                | 21 ++++-----
 3 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 0157bcd2efffa..198022bc1f941 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -2762,25 +2762,6 @@ static int qed_configure_filter_mcast(struct qed_dev *cdev,
 	return qed_filter_mcast_cmd(cdev, &mcast, QED_SPQ_MODE_CB, NULL);
 }
 
-static int qed_configure_filter(struct qed_dev *cdev,
-				struct qed_filter_params *params)
-{
-	enum qed_filter_rx_mode_type accept_flags;
-
-	switch (params->type) {
-	case QED_FILTER_TYPE_UCAST:
-		return qed_configure_filter_ucast(cdev, &params->filter.ucast);
-	case QED_FILTER_TYPE_MCAST:
-		return qed_configure_filter_mcast(cdev, &params->filter.mcast);
-	case QED_FILTER_TYPE_RX_MODE:
-		accept_flags = params->filter.accept_flags;
-		return qed_configure_filter_rx_mode(cdev, accept_flags);
-	default:
-		DP_NOTICE(cdev, "Unknown filter type %d\n", (int)params->type);
-		return -EINVAL;
-	}
-}
-
 static int qed_configure_arfs_searcher(struct qed_dev *cdev,
 				       enum qed_filter_config_mode mode)
 {
@@ -2903,7 +2884,9 @@ static const struct qed_eth_ops qed_eth_ops_pass = {
 	.q_rx_stop = &qed_stop_rxq,
 	.q_tx_start = &qed_start_txq,
 	.q_tx_stop = &qed_stop_txq,
-	.filter_config = &qed_configure_filter,
+	.filter_config_rx_mode = &qed_configure_filter_rx_mode,
+	.filter_config_ucast = &qed_configure_filter_ucast,
+	.filter_config_mcast = &qed_configure_filter_mcast,
 	.fastpath_stop = &qed_fastpath_stop,
 	.eth_cqe_completion = &qed_fp_cqe_completion,
 	.get_vport_stats = &qed_get_vport_stats,
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 5f4962d90022e..f4385466418ce 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -619,30 +619,28 @@ static int qede_set_ucast_rx_mac(struct qede_dev *edev,
 				 enum qed_filter_xcast_params_type opcode,
 				 unsigned char mac[ETH_ALEN])
 {
-	struct qed_filter_params filter_cmd;
+	struct qed_filter_ucast_params ucast;
 
-	memset(&filter_cmd, 0, sizeof(filter_cmd));
-	filter_cmd.type = QED_FILTER_TYPE_UCAST;
-	filter_cmd.filter.ucast.type = opcode;
-	filter_cmd.filter.ucast.mac_valid = 1;
-	ether_addr_copy(filter_cmd.filter.ucast.mac, mac);
+	memset(&ucast, 0, sizeof(ucast));
+	ucast.type = opcode;
+	ucast.mac_valid = 1;
+	ether_addr_copy(ucast.mac, mac);
 
-	return edev->ops->filter_config(edev->cdev, &filter_cmd);
+	return edev->ops->filter_config_ucast(edev->cdev, &ucast);
 }
 
 static int qede_set_ucast_rx_vlan(struct qede_dev *edev,
 				  enum qed_filter_xcast_params_type opcode,
 				  u16 vid)
 {
-	struct qed_filter_params filter_cmd;
+	struct qed_filter_ucast_params ucast;
 
-	memset(&filter_cmd, 0, sizeof(filter_cmd));
-	filter_cmd.type = QED_FILTER_TYPE_UCAST;
-	filter_cmd.filter.ucast.type = opcode;
-	filter_cmd.filter.ucast.vlan_valid = 1;
-	filter_cmd.filter.ucast.vlan = vid;
+	memset(&ucast, 0, sizeof(ucast));
+	ucast.type = opcode;
+	ucast.vlan_valid = 1;
+	ucast.vlan = vid;
 
-	return edev->ops->filter_config(edev->cdev, &filter_cmd);
+	return edev->ops->filter_config_ucast(edev->cdev, &ucast);
 }
 
 static int qede_config_accept_any_vlan(struct qede_dev *edev, bool action)
@@ -1057,18 +1055,17 @@ static int qede_set_mcast_rx_mac(struct qede_dev *edev,
 				 enum qed_filter_xcast_params_type opcode,
 				 unsigned char *mac, int num_macs)
 {
-	struct qed_filter_params filter_cmd;
+	struct qed_filter_mcast_params mcast;
 	int i;
 
-	memset(&filter_cmd, 0, sizeof(filter_cmd));
-	filter_cmd.type = QED_FILTER_TYPE_MCAST;
-	filter_cmd.filter.mcast.type = opcode;
-	filter_cmd.filter.mcast.num = num_macs;
+	memset(&mcast, 0, sizeof(mcast));
+	mcast.type = opcode;
+	mcast.num = num_macs;
 
 	for (i = 0; i < num_macs; i++, mac += ETH_ALEN)
-		ether_addr_copy(filter_cmd.filter.mcast.mac[i], mac);
+		ether_addr_copy(mcast.mac[i], mac);
 
-	return edev->ops->filter_config(edev->cdev, &filter_cmd);
+	return edev->ops->filter_config_mcast(edev->cdev, &mcast);
 }
 
 int qede_set_mac_addr(struct net_device *ndev, void *p)
@@ -1194,7 +1191,6 @@ void qede_config_rx_mode(struct net_device *ndev)
 {
 	enum qed_filter_rx_mode_type accept_flags;
 	struct qede_dev *edev = netdev_priv(ndev);
-	struct qed_filter_params rx_mode;
 	unsigned char *uc_macs, *temp;
 	struct netdev_hw_addr *ha;
 	int rc, uc_count;
@@ -1220,10 +1216,6 @@ void qede_config_rx_mode(struct net_device *ndev)
 
 	netif_addr_unlock_bh(ndev);
 
-	/* Configure the struct for the Rx mode */
-	memset(&rx_mode, 0, sizeof(struct qed_filter_params));
-	rx_mode.type = QED_FILTER_TYPE_RX_MODE;
-
 	/* Remove all previous unicast secondary macs and multicast macs
 	 * (configure / leave the primary mac)
 	 */
@@ -1271,8 +1263,7 @@ void qede_config_rx_mode(struct net_device *ndev)
 		qede_config_accept_any_vlan(edev, false);
 	}
 
-	rx_mode.filter.accept_flags = accept_flags;
-	edev->ops->filter_config(edev->cdev, &rx_mode);
+	edev->ops->filter_config_rx_mode(edev->cdev, accept_flags);
 out:
 	kfree(uc_macs);
 }
diff --git a/include/linux/qed/qed_eth_if.h b/include/linux/qed/qed_eth_if.h
index 812a4d7511633..4df0bf0a0864e 100644
--- a/include/linux/qed/qed_eth_if.h
+++ b/include/linux/qed/qed_eth_if.h
@@ -145,12 +145,6 @@ struct qed_filter_mcast_params {
 	unsigned char mac[64][ETH_ALEN];
 };
 
-union qed_filter_type_params {
-	enum qed_filter_rx_mode_type accept_flags;
-	struct qed_filter_ucast_params ucast;
-	struct qed_filter_mcast_params mcast;
-};
-
 enum qed_filter_type {
 	QED_FILTER_TYPE_UCAST,
 	QED_FILTER_TYPE_MCAST,
@@ -158,11 +152,6 @@ enum qed_filter_type {
 	QED_MAX_FILTER_TYPES,
 };
 
-struct qed_filter_params {
-	enum qed_filter_type type;
-	union qed_filter_type_params filter;
-};
-
 struct qed_tunn_params {
 	u16 vxlan_port;
 	u8 update_vxlan_port;
@@ -314,8 +303,14 @@ struct qed_eth_ops {
 
 	int (*q_tx_stop)(struct qed_dev *cdev, u8 rss_id, void *handle);
 
-	int (*filter_config)(struct qed_dev *cdev,
-			     struct qed_filter_params *params);
+	int (*filter_config_rx_mode)(struct qed_dev *cdev,
+				     enum qed_filter_rx_mode_type type);
+
+	int (*filter_config_ucast)(struct qed_dev *cdev,
+				   struct qed_filter_ucast_params *params);
+
+	int (*filter_config_mcast)(struct qed_dev *cdev,
+				   struct qed_filter_mcast_params *params);
 
 	int (*fastpath_stop)(struct qed_dev *cdev);
 
-- 
2.43.0




