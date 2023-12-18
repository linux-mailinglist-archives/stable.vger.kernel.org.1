Return-Path: <stable+bounces-7427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73868817280
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7711F24364
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B621D141;
	Mon, 18 Dec 2023 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fc+2O8oj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4A129EC7;
	Mon, 18 Dec 2023 14:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2046EC433C8;
	Mon, 18 Dec 2023 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908437;
	bh=obD+QrZjilhrMIwHeDTmIP9QZuu3oA4O4aL10Aovaws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fc+2O8oj6pCo+xrpHvdgwvwNQhAt1hu+0yZWB3TQvZ9noSMvcv8W+FCpoB5z+s6dp
	 S9mdLMeqAchBjmS7GREdkimi4+BII1m0XxIXbFq1mPgmhywKfJ/0wgmDVL6g7qKVR6
	 3ZRcptxJK53W0cVcnpbBYMWEc5279HmyNfiK4NYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <simon.horman@corigine.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 10/62] net: vlan: introduce skb_vlan_eth_hdr()
Date: Mon, 18 Dec 2023 14:51:34 +0100
Message-ID: <20231218135046.673898624@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135046.178317233@linuxfoundation.org>
References: <20231218135046.178317233@linuxfoundation.org>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 1f5020acb33f926030f62563c86dffca35c7b701 ]

Similar to skb_eth_hdr() introduced in commit 96cc4b69581d ("macvlan: do
not assume mac_header is set in macvlan_broadcast()"), let's introduce a
skb_vlan_eth_hdr() helper which can be used in TX-only code paths to get
to the VLAN header based on skb->data rather than based on the
skb_mac_header(skb).

We also consolidate the drivers that dereference skb->data to go through
this helper.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9fc95fe95c3e ("net: fec: correct queue selection")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c      |  3 +--
 drivers/net/ethernet/emulex/benet/be_main.c          |  2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c      |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c          |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c        |  2 +-
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c |  2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c       |  4 ++--
 drivers/net/ethernet/sfc/tx_tso.c                    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  7 ++-----
 drivers/staging/gdm724x/gdm_lte.c                    |  4 ++--
 include/linux/if_vlan.h                              | 12 ++++++++++--
 net/batman-adv/soft-interface.c                      |  2 +-
 12 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 4f669e7c75587..4509a29ff73f9 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -1924,8 +1924,7 @@ u16 bnx2x_select_queue(struct net_device *dev, struct sk_buff *skb,
 
 		/* Skip VLAN tag if present */
 		if (ether_type == ETH_P_8021Q) {
-			struct vlan_ethhdr *vhdr =
-				(struct vlan_ethhdr *)skb->data;
+			struct vlan_ethhdr *vhdr = skb_vlan_eth_hdr(skb);
 
 			ether_type = ntohs(vhdr->h_vlan_encapsulated_proto);
 		}
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 52b399aa3213d..edd4dd73b3e32 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1125,7 +1125,7 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 						  struct be_wrb_params
 						  *wrb_params)
 {
-	struct vlan_ethhdr *veh = (struct vlan_ethhdr *)skb->data;
+	struct vlan_ethhdr *veh = skb_vlan_eth_hdr(skb);
 	unsigned int eth_hdr_len;
 	struct iphdr *ip;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4df5e91e86ce7..a4ab3e7efa5e4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1002,7 +1002,7 @@ static int hns3_handle_vtags(struct hns3_enet_ring *tx_ring,
 	if (unlikely(rc < 0))
 		return rc;
 
-	vhdr = (struct vlan_ethhdr *)skb->data;
+	vhdr = skb_vlan_eth_hdr(skb);
 	vhdr->h_vlan_TCI |= cpu_to_be16((skb->priority << VLAN_PRIO_SHIFT)
 					 & VLAN_PRIO_MASK);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 88d8f17cefd8e..57667ccc28f54 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2879,7 +2879,7 @@ static inline int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
 			rc = skb_cow_head(skb, 0);
 			if (rc < 0)
 				return rc;
-			vhdr = (struct vlan_ethhdr *)skb->data;
+			vhdr = skb_vlan_eth_hdr(skb);
 			vhdr->h_vlan_TCI = htons(tx_flags >>
 						 I40E_TX_FLAGS_VLAN_SHIFT);
 		} else {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2b100b7b325a5..5829d81f2cb11 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8707,7 +8707,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 
 			if (skb_cow_head(skb, 0))
 				goto out_drop;
-			vhdr = (struct vlan_ethhdr *)skb->data;
+			vhdr = skb_vlan_eth_hdr(skb);
 			vhdr->h_vlan_TCI = htons(tx_flags >>
 						 IXGBE_TX_FLAGS_VLAN_SHIFT);
 		} else {
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index e2046b6d65a30..2c54600835643 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -1861,7 +1861,7 @@ netxen_tso_check(struct net_device *netdev,
 
 	if (protocol == cpu_to_be16(ETH_P_8021Q)) {
 
-		vh = (struct vlan_ethhdr *)skb->data;
+		vh = skb_vlan_eth_hdr(skb);
 		protocol = vh->h_vlan_encapsulated_proto;
 		flags = FLAGS_VLAN_TAGGED;
 
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index bdf15d2a64313..7260e57d79f2e 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -317,7 +317,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 
 	if (adapter->flags & QLCNIC_VLAN_FILTERING) {
 		if (protocol == ETH_P_8021Q) {
-			vh = (struct vlan_ethhdr *)skb->data;
+			vh = skb_vlan_eth_hdr(skb);
 			vlan_id = ntohs(vh->h_vlan_TCI);
 		} else if (skb_vlan_tag_present(skb)) {
 			vlan_id = skb_vlan_tag_get(skb);
@@ -467,7 +467,7 @@ static int qlcnic_tx_pkt(struct qlcnic_adapter *adapter,
 	u32 producer = tx_ring->producer;
 
 	if (protocol == ETH_P_8021Q) {
-		vh = (struct vlan_ethhdr *)skb->data;
+		vh = skb_vlan_eth_hdr(skb);
 		flags = QLCNIC_FLAGS_VLAN_TAGGED;
 		vlan_tci = ntohs(vh->h_vlan_TCI);
 		protocol = ntohs(vh->h_vlan_encapsulated_proto);
diff --git a/drivers/net/ethernet/sfc/tx_tso.c b/drivers/net/ethernet/sfc/tx_tso.c
index 898e5c61d9086..d381d8164f07c 100644
--- a/drivers/net/ethernet/sfc/tx_tso.c
+++ b/drivers/net/ethernet/sfc/tx_tso.c
@@ -147,7 +147,7 @@ static __be16 efx_tso_check_protocol(struct sk_buff *skb)
 	EFX_WARN_ON_ONCE_PARANOID(((struct ethhdr *)skb->data)->h_proto !=
 				  protocol);
 	if (protocol == htons(ETH_P_8021Q)) {
-		struct vlan_ethhdr *veh = (struct vlan_ethhdr *)skb->data;
+		struct vlan_ethhdr *veh = skb_vlan_eth_hdr(skb);
 
 		protocol = veh->h_vlan_encapsulated_proto;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 59a07a01e80ca..709bd81fde2a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3660,13 +3660,10 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
 {
-	struct vlan_ethhdr *veth;
-	__be16 vlan_proto;
+	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
+	__be16 vlan_proto = veth->h_vlan_proto;
 	u16 vlanid;
 
-	veth = (struct vlan_ethhdr *)skb->data;
-	vlan_proto = veth->h_vlan_proto;
-
 	if ((vlan_proto == htons(ETH_P_8021Q) &&
 	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
 	    (vlan_proto == htons(ETH_P_8021AD) &&
diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index de30262c3fae0..e0787647093d1 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -350,7 +350,7 @@ static s32 gdm_lte_tx_nic_type(struct net_device *dev, struct sk_buff *skb)
 	/* Get ethernet protocol */
 	eth = (struct ethhdr *)skb->data;
 	if (ntohs(eth->h_proto) == ETH_P_8021Q) {
-		vlan_eth = (struct vlan_ethhdr *)skb->data;
+		vlan_eth = skb_vlan_eth_hdr(skb);
 		mac_proto = ntohs(vlan_eth->h_vlan_encapsulated_proto);
 		network_data = skb->data + VLAN_ETH_HLEN;
 		nic_type |= NIC_TYPE_F_VLAN;
@@ -436,7 +436,7 @@ static netdev_tx_t gdm_lte_tx(struct sk_buff *skb, struct net_device *dev)
 	 * driver based on the NIC mac
 	 */
 	if (nic_type & NIC_TYPE_F_VLAN) {
-		struct vlan_ethhdr *vlan_eth = (struct vlan_ethhdr *)skb->data;
+		struct vlan_ethhdr *vlan_eth = skb_vlan_eth_hdr(skb);
 
 		nic->vlan_id = ntohs(vlan_eth->h_vlan_TCI) & VLAN_VID_MASK;
 		data_buf = skb->data + (VLAN_ETH_HLEN - ETH_HLEN);
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 4e7e72f3da5bd..ce6714bec65fd 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -60,6 +60,14 @@ static inline struct vlan_ethhdr *vlan_eth_hdr(const struct sk_buff *skb)
 	return (struct vlan_ethhdr *)skb_mac_header(skb);
 }
 
+/* Prefer this version in TX path, instead of
+ * skb_reset_mac_header() + vlan_eth_hdr()
+ */
+static inline struct vlan_ethhdr *skb_vlan_eth_hdr(const struct sk_buff *skb)
+{
+	return (struct vlan_ethhdr *)skb->data;
+}
+
 #define VLAN_PRIO_MASK		0xe000 /* Priority Code Point */
 #define VLAN_PRIO_SHIFT		13
 #define VLAN_CFI_MASK		0x1000 /* Canonical Format Indicator / Drop Eligible Indicator */
@@ -526,7 +534,7 @@ static inline void __vlan_hwaccel_put_tag(struct sk_buff *skb,
  */
 static inline int __vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
 {
-	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb->data;
+	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
 
 	if (!eth_type_vlan(veth->h_vlan_proto))
 		return -EINVAL;
@@ -727,7 +735,7 @@ static inline bool skb_vlan_tagged_multi(struct sk_buff *skb)
 		if (unlikely(!pskb_may_pull(skb, VLAN_ETH_HLEN)))
 			return false;
 
-		veh = (struct vlan_ethhdr *)skb->data;
+		veh = skb_vlan_eth_hdr(skb);
 		protocol = veh->h_vlan_encapsulated_proto;
 	}
 
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7ac16d7b94a2f..0e6d0a5e68413 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -454,7 +454,7 @@ void batadv_interface_rx(struct net_device *soft_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
-		vhdr = (struct vlan_ethhdr *)skb->data;
+		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */
 		if (vhdr->h_vlan_encapsulated_proto != htons(ETH_P_BATMAN))
-- 
2.43.0




