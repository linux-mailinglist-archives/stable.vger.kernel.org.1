Return-Path: <stable+bounces-75638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974C973838
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D0F0B21DEF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9D5192B8B;
	Tue, 10 Sep 2024 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="QvrTx0XQ"
X-Original-To: stable@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABF18FDA5
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973426; cv=none; b=KJ0G99UYGH0DrkBRT8e20/PIkj22Vu0BB2QvBCaB0hk435xOrvs8hw3Gez4mXSkLBwqPl2PGsalOto/ft4ArKEpkDYwD7gEsC0AaI4/EsmiMsAQogs/Ph8ym7rvt5q1HRQMeoGgIixDNImOYqwKliqvxgtWCSxRStz4VCgFVOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973426; c=relaxed/simple;
	bh=kGPEQ84Lja2oVS98vNSvVX6dCBoadgslgw3UfZ2innU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3h7/2pB9/1PTgOqnrL3UbYak3rh4IpBbIcY2/b39Zfwj7jFiOX4oK9ls5nZ51Muc51IiQyiat6TOTlc5HMFquA5R/tNbgWd9xB4Fku3cmZcJykm4ltJz1lZNLxeztuonY0ihEHep8Q2LO3RY7TlJRN4cvbbO7fASi/Bs8dvBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=QvrTx0XQ; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024091013033469c27cb94b7a57da2f
        for <stable@vger.kernel.org>;
        Tue, 10 Sep 2024 15:03:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kw4l5HZVrUk3+Q72g4V6pB8Svv1P+K7Ki3rt+kSviSQ=;
 b=QvrTx0XQwkl2Mo5aqKH7kW/waZoZ/v5mAqoOMimUHpzPcMaoSNicWSSIFgBx9fsTGnCOkK
 FyUIB0KFhNo7X0LgRxSOA7anjNI9/0DFLOLz0SYgLES1ygz6Xo2+NbrFjvmdm9FvROhAX7v4
 HPkYJGdWlsUlzraQiJpONk9Gio86ALFfgEXHVMdKlktzYVJpGv1yDYf4UrXiodD5RfDRhe6v
 rW8ApBPSrAi3LWFpNpXmk+qUMJtRHxHrxxoUmEJts1qIf0M71G8jer47RuG3tzM9WhWya92G
 NNS1EUk0L3c2QBwcIEqtSUQ0XFz2oAtC9tY+bmR4TnvGrIpTjfQuqNzA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 =?ISO-8859-1?Q?Ar1n=E7_=DCNAL?= <arinc.unal@arinc9.com>, Daniel Golle
 <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, Sean Wang
 <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Roopa Prabhu <roopa@nvidia.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, linux-mediatek@lists.infradead.org,
 bridge@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH 1/2] net: dsa: RCU-protect dsa_ptr in struct net_device
Date: Tue, 10 Sep 2024 15:03:15 +0200
Message-ID: <20240910130321.337154-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
References: <20240910130321.337154-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

There are multiple races of zeroing dsa_ptr in struct net_device (on
shutdown/remove) against asynchronous dereferences all over the net
code. Widespread pattern is as follows:

CPU0					CPU1
if (netdev_uses_dsa())
					dev->dsa_ptr = NULL;
        dev->dsa_ptr->...

One of the possible crashes:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
CPU: 0 PID: 12 Comm: ksoftirqd/0 Tainted: G O 6.1.99+ #1
pc : lan9303_rcv
lr : lan9303_rcv
Call trace:
 lan9303_rcv
 dsa_switch_rcv
 __netif_receive_skb_list_core
 netif_receive_skb_list_internal
 napi_gro_receive
 fec_enet_rx_napi
 __napi_poll
 net_rx_action
...

RCU-protect dsa_ptr and use rcu_dereference() or rtnl_dereference()
depending on the calling context.

Rename netdev_uses_dsa() into __netdev_uses_dsa_currently()
(assumes ether RCU or RTNL lock held) and netdev_uses_dsa_currently()
variants which better reflect the uselessness of the function's
return value, which becomes outdated right after the call.

Fixes: ee534378f005 ("net: dsa: fix panic when DSA master device unbinds on shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/dsa/mt7530.c                    |   3 +-
 drivers/net/dsa/ocelot/felix.c              |   3 +-
 drivers/net/dsa/qca/qca8k-8xxx.c            |   3 +-
 drivers/net/ethernet/broadcom/bcmsysport.c  |   8 +-
 drivers/net/ethernet/mediatek/airoha_eth.c  |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |  22 +++--
 drivers/net/ethernet/mediatek/mtk_ppe.c     |  15 ++-
 include/linux/netdevice.h                   |   2 +-
 include/net/dsa.h                           |  36 +++++--
 include/net/dsa_stubs.h                     |   6 +-
 net/bridge/br_input.c                       |   2 +-
 net/core/dev.c                              |   3 +-
 net/core/flow_dissector.c                   |  19 ++--
 net/dsa/conduit.c                           |  66 ++++++++-----
 net/dsa/dsa.c                               |  19 ++--
 net/dsa/port.c                              |   3 +-
 net/dsa/tag.c                               |   3 +-
 net/dsa/tag.h                               |  19 ++--
 net/dsa/tag_8021q.c                         |  10 +-
 net/dsa/tag_brcm.c                          |   2 +-
 net/dsa/tag_dsa.c                           |   8 +-
 net/dsa/tag_qca.c                           |  10 +-
 net/dsa/tag_sja1105.c                       |  22 +++--
 net/dsa/user.c                              | 104 +++++++++++---------
 net/ethernet/eth.c                          |   2 +-
 25 files changed, 240 insertions(+), 152 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ec18e68bf3a8..82d3f1786156 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -20,6 +20,7 @@
 #include <linux/reset.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
+#include <linux/rtnetlink.h>
 #include <net/dsa.h>
 
 #include "mt7530.h"
@@ -3092,7 +3093,7 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 			    const struct net_device *conduit,
 			    bool operational)
 {
-	struct dsa_port *cpu_dp = conduit->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(conduit->dsa_ptr);
 	struct mt7530_priv *priv = ds->priv;
 	int val = 0;
 	u8 mask;
diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 4a705f7333f4..f6bc0ff0c116 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -21,6 +21,7 @@
 #include <linux/of_net.h>
 #include <linux/pci.h>
 #include <linux/of.h>
+#include <linux/rtnetlink.h>
 #include <net/pkt_sched.h>
 #include <net/dsa.h>
 #include "felix.h"
@@ -57,7 +58,7 @@ static int felix_cpu_port_for_conduit(struct dsa_switch *ds,
 		return lag;
 	}
 
-	cpu_dp = conduit->dsa_ptr;
+	cpu_dp = rtnl_dereference(conduit->dsa_ptr);
 	return cpu_dp->index;
 }
 
diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index f8d8c70642c4..10b4d7e9be2f 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -20,6 +20,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/etherdevice.h>
 #include <linux/dsa/tag_qca.h>
+#include <linux/rtnetlink.h>
 
 #include "qca8k.h"
 #include "qca8k_leds.h"
@@ -1754,7 +1755,7 @@ static void
 qca8k_conduit_change(struct dsa_switch *ds, const struct net_device *conduit,
 		     bool operational)
 {
-	struct dsa_port *dp = conduit->dsa_ptr;
+	struct dsa_port *dp = rtnl_dereference(conduit->dsa_ptr);
 	struct qca8k_priv *priv = ds->priv;
 
 	/* Ethernet MIB/MDIO is only supported for CPU port 0 */
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index c9faa8540859..bd9bc081346d 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -145,7 +145,7 @@ static void bcm_sysport_set_rx_csum(struct net_device *dev,
 	 * sure we tell the RXCHK hardware to expect a 4-bytes Broadcom
 	 * tag after the Ethernet MAC Source Address.
 	 */
-	if (netdev_uses_dsa(dev))
+	if (__netdev_uses_dsa_currently(dev))
 		reg |= RXCHK_BRCM_TAG_EN;
 	else
 		reg &= ~RXCHK_BRCM_TAG_EN;
@@ -173,7 +173,7 @@ static void bcm_sysport_set_tx_csum(struct net_device *dev,
 	 * checksum to be computed correctly when using VLAN HW acceleration,
 	 * else it has no effect, so it can always be turned on.
 	 */
-	if (netdev_uses_dsa(dev))
+	if (__netdev_uses_dsa_currently(dev))
 		reg |= tdma_control_bit(priv, SW_BRCM_TAG);
 	else
 		reg &= ~tdma_control_bit(priv, SW_BRCM_TAG);
@@ -1950,7 +1950,7 @@ static inline void gib_set_pad_extension(struct bcm_sysport_priv *priv)
 
 	reg = gib_readl(priv, GIB_CONTROL);
 	/* Include Broadcom tag in pad extension and fix up IPG_LENGTH */
-	if (netdev_uses_dsa(priv->netdev)) {
+	if (__netdev_uses_dsa_currently(priv->netdev)) {
 		reg &= ~(GIB_PAD_EXTENSION_MASK << GIB_PAD_EXTENSION_SHIFT);
 		reg |= ENET_BRCM_TAG_LEN << GIB_PAD_EXTENSION_SHIFT;
 	}
@@ -2299,7 +2299,7 @@ static u16 bcm_sysport_select_queue(struct net_device *dev, struct sk_buff *skb,
 	struct bcm_sysport_tx_ring *tx_ring;
 	unsigned int q, port;
 
-	if (!netdev_uses_dsa(dev))
+	if (!__netdev_uses_dsa_currently(dev))
 		return netdev_pick_tx(dev, skb, NULL);
 
 	/* DSA tagging layer will have configured the correct queue */
diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 1c5b85a86df1..f7425d393b22 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2255,7 +2255,7 @@ static int airoha_dev_open(struct net_device *dev)
 	if (err)
 		return err;
 
-	if (netdev_uses_dsa(dev))
+	if (__netdev_uses_dsa_currently(dev))
 		airoha_fe_set(eth, REG_GDM_INGRESS_CFG(port->id),
 			      GDM_STAG_EN_MASK);
 	else
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 16ca427cf4c3..82a828349323 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -24,6 +24,7 @@
 #include <linux/pcs/pcs-mtk-lynxi.h>
 #include <linux/jhash.h>
 #include <linux/bitfield.h>
+#include <linux/rcupdate.h>
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
@@ -1375,7 +1376,8 @@ static void mtk_tx_set_dma_desc_v2(struct net_device *dev, void *txd,
 		/* tx checksum offload */
 		if (info->csum)
 			data |= TX_DMA_CHKSUM_V2;
-		if (mtk_is_netsys_v3_or_greater(eth) && netdev_uses_dsa(dev))
+		if (mtk_is_netsys_v3_or_greater(eth) &&
+		    __netdev_uses_dsa_currently(dev))
 			data |= TX_DMA_SPTAG_V3;
 	}
 	WRITE_ONCE(desc->txd5, data);
@@ -2183,7 +2185,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		 * hardware treats the MTK special tag as a VLAN and untags it.
 		 */
 		if (mtk_is_netsys_v1(eth) && (trxd.rxd2 & RX_DMA_VTAG) &&
-		    netdev_uses_dsa(netdev)) {
+		    __netdev_uses_dsa_currently(netdev)) {
 			unsigned int port = RX_DMA_VPID(trxd.rxd3) & GENMASK(2, 0);
 
 			if (port < ARRAY_SIZE(eth->dsa_meta) &&
@@ -3304,7 +3306,7 @@ static void mtk_gdm_config(struct mtk_eth *eth, u32 id, u32 config)
 
 	val |= config;
 
-	if (eth->netdev[id] && netdev_uses_dsa(eth->netdev[id]))
+	if (eth->netdev[id] && __netdev_uses_dsa_currently(eth->netdev[id]))
 		val |= MTK_GDMA_SPECIAL_TAG;
 
 	mtk_w32(eth, val, MTK_GDMA_FWD_CFG(id));
@@ -3313,12 +3315,16 @@ static void mtk_gdm_config(struct mtk_eth *eth, u32 id, u32 config)
 
 static bool mtk_uses_dsa(struct net_device *dev)
 {
+	bool ret = false;
 #if IS_ENABLED(CONFIG_NET_DSA)
-	return netdev_uses_dsa(dev) &&
-	       dev->dsa_ptr->tag_ops->proto == DSA_TAG_PROTO_MTK;
-#else
-	return false;
+	struct dsa_port *dp;
+
+	rcu_read_lock();
+	dp = rcu_dereference(dev->dsa_ptr);
+	ret = dp && dp->tag_ops->proto == DSA_TAG_PROTO_MTK;
+	rcu_read_unlock();
 #endif
+	return ret;
 }
 
 static int mtk_device_event(struct notifier_block *n, unsigned long event, void *ptr)
@@ -4482,7 +4488,7 @@ static u16 mtk_select_queue(struct net_device *dev, struct sk_buff *skb,
 	struct mtk_mac *mac = netdev_priv(dev);
 	unsigned int queue = 0;
 
-	if (netdev_uses_dsa(dev))
+	if (__netdev_uses_dsa_currently(dev))
 		queue = skb_get_queue_mapping(skb) + 3;
 	else
 		queue = mac->id;
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 0acee405a749..0c78ec90d855 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/rcupdate.h>
 #include <net/dst_metadata.h>
 #include <net/dsa.h>
 #include "mtk_eth_soc.h"
@@ -785,9 +786,17 @@ void __mtk_ppe_check_skb(struct mtk_ppe *ppe, struct sk_buff *skb, u16 hash)
 	switch (skb->protocol) {
 #if IS_ENABLED(CONFIG_NET_DSA)
 	case htons(ETH_P_XDSA):
-		if (!netdev_uses_dsa(skb->dev) ||
-		    skb->dev->dsa_ptr->tag_ops->proto != DSA_TAG_PROTO_MTK)
-			goto out;
+		{
+			struct dsa_port *dp;
+			bool proto_mtk;
+
+			rcu_read_lock();
+			dp = rcu_dereference(skb->dev->dsa_ptr);
+			proto_mtk = dp && dp->tag_ops->proto == DSA_TAG_PROTO_MTK;
+			rcu_read_unlock();
+			if (!proto_mtk)
+				goto out;
+		}
 
 		if (!skb_metadata_dst(skb))
 			tag += 4;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 607009150b5f..e645c7eabd42 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2229,7 +2229,7 @@ struct net_device {
 	struct vlan_info __rcu	*vlan_info;
 #endif
 #if IS_ENABLED(CONFIG_NET_DSA)
-	struct dsa_port		*dsa_ptr;
+	struct dsa_port	 __rcu	*dsa_ptr;
 #endif
 #if IS_ENABLED(CONFIG_TIPC)
 	struct tipc_bearer __rcu *tipc_ptr;
diff --git a/include/net/dsa.h b/include/net/dsa.h
index d7a6c2930277..ab2777611e71 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -19,6 +19,7 @@
 #include <linux/phy.h>
 #include <linux/platform_data/dsa.h>
 #include <linux/phylink.h>
+#include <linux/rcupdate.h>
 #include <net/devlink.h>
 #include <net/switchdev.h>
 
@@ -92,8 +93,9 @@ struct dsa_switch;
 struct dsa_device_ops {
 	struct sk_buff *(*xmit)(struct sk_buff *skb, struct net_device *dev);
 	struct sk_buff *(*rcv)(struct sk_buff *skb, struct net_device *dev);
-	void (*flow_dissect)(const struct sk_buff *skb, __be16 *proto,
-			     int *offset);
+	void (*flow_dissect)(const struct sk_buff *skb,
+			     const struct dsa_port *dp,
+			     __be16 *proto, int *offset);
 	int (*connect)(struct dsa_switch *ds);
 	void (*disconnect)(struct dsa_switch *ds);
 	unsigned int needed_headroom;
@@ -1334,14 +1336,29 @@ bool dsa_mdb_present_in_other_db(struct dsa_switch *ds, int port,
 				 struct dsa_db db);
 
 /* Keep inline for faster access in hot path */
-static inline bool netdev_uses_dsa(const struct net_device *dev)
+
+/* Must be called under RCU or RTNL lock */
+static inline bool __netdev_uses_dsa_currently(const struct net_device *dev)
 {
 #if IS_ENABLED(CONFIG_NET_DSA)
-	return dev->dsa_ptr && dev->dsa_ptr->rcv;
+	struct dsa_port *dp = rcu_dereference_rtnl(dev->dsa_ptr);
+
+	return dp && dp->rcv;
 #endif
 	return false;
 }
 
+static inline bool netdev_uses_dsa_currently(const struct net_device *dev)
+{
+	bool ret = false;
+#if IS_ENABLED(CONFIG_NET_DSA)
+	rcu_read_lock();
+	ret = __netdev_uses_dsa_currently(dev);
+	rcu_read_unlock();
+#endif
+	return ret;
+}
+
 /* All DSA tags that push the EtherType to the right (basically all except tail
  * tags, which don't break dissection) can be treated the same from the
  * perspective of the flow dissector.
@@ -1355,17 +1372,20 @@ static inline bool netdev_uses_dsa(const struct net_device *dev)
  *    that, in __be16 shorts).
  *
  *  - proto: the value of the real EtherType.
+ *
+ * Must be called under RCU read lock (because of dp).
  */
 static inline void dsa_tag_generic_flow_dissect(const struct sk_buff *skb,
+						const struct dsa_port *dp,
 						__be16 *proto, int *offset)
 {
-#if IS_ENABLED(CONFIG_NET_DSA)
-	const struct dsa_device_ops *ops = skb->dev->dsa_ptr->tag_ops;
-	int tag_len = ops->needed_headroom;
+	int tag_len;
 
+	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(), "no rcu lock held");
+
+	tag_len = dp->tag_ops->needed_headroom;
 	*offset = tag_len;
 	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
-#endif
 }
 
 void dsa_unregister_switch(struct dsa_switch *ds);
diff --git a/include/net/dsa_stubs.h b/include/net/dsa_stubs.h
index 6f384897f287..ca899305ba36 100644
--- a/include/net/dsa_stubs.h
+++ b/include/net/dsa_stubs.h
@@ -22,9 +22,6 @@ static inline int dsa_conduit_hwtstamp_validate(struct net_device *dev,
 						const struct kernel_hwtstamp_config *config,
 						struct netlink_ext_ack *extack)
 {
-	if (!netdev_uses_dsa(dev))
-		return 0;
-
 	/* rtnl_lock() is a sufficient guarantee, because as long as
 	 * netdev_uses_dsa() returns true, the dsa_core module is still
 	 * registered, and so, dsa_unregister_stubs() couldn't have run.
@@ -33,6 +30,9 @@ static inline int dsa_conduit_hwtstamp_validate(struct net_device *dev,
 	 */
 	ASSERT_RTNL();
 
+	if (!__netdev_uses_dsa_currently(dev))
+		return 0;
+
 	return dsa_stubs->conduit_hwtstamp_validate(dev, config, extack);
 }
 
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947..542cfc5678df 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -443,7 +443,7 @@ static rx_handler_result_t br_handle_frame_dummy(struct sk_buff **pskb)
 
 rx_handler_func_t *br_get_rx_handler(const struct net_device *dev)
 {
-	if (netdev_uses_dsa(dev))
+	if (__netdev_uses_dsa_currently(dev))
 		return br_handle_frame_dummy;
 
 	return br_handle_frame;
diff --git a/net/core/dev.c b/net/core/dev.c
index f66e61407883..9ae1c097cbad 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5568,7 +5568,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		}
 	}
 
-	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
+	if (unlikely(skb_vlan_tag_present(skb)) &&
+	    !__netdev_uses_dsa_currently(skb->dev)) {
 check_vlan_id:
 		if (skb_vlan_tag_get_id(skb)) {
 			/* Vlan id is non 0 and vlan_do_receive() above couldn't
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 0e638a37aa09..e1523c609bb7 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1071,25 +1071,30 @@ bool __skb_flow_dissect(const struct net *net,
 		nhoff = skb_network_offset(skb);
 		hlen = skb_headlen(skb);
 #if IS_ENABLED(CONFIG_NET_DSA)
-		if (unlikely(skb->dev && netdev_uses_dsa(skb->dev) &&
-			     proto == htons(ETH_P_XDSA))) {
+		if (unlikely(skb->dev && proto == htons(ETH_P_XDSA))) {
 			struct metadata_dst *md_dst = skb_metadata_dst(skb);
-			const struct dsa_device_ops *ops;
+			struct dsa_port *dp;
 			int offset = 0;
 
-			ops = skb->dev->dsa_ptr->tag_ops;
+			rcu_read_lock();
+
+			dp = rcu_dereference(skb->dev->dsa_ptr);
 			/* Only DSA header taggers break flow dissection */
-			if (ops->needed_headroom &&
+			if (dp && dp->tag_ops->needed_headroom &&
 			    (!md_dst || md_dst->type != METADATA_HW_PORT_MUX)) {
-				if (ops->flow_dissect)
-					ops->flow_dissect(skb, &proto, &offset);
+				if (dp->tag_ops->flow_dissect)
+					dp->tag_ops->flow_dissect(skb, dp,
+								  &proto, &offset);
 				else
 					dsa_tag_generic_flow_dissect(skb,
+								     dp,
 								     &proto,
 								     &offset);
 				hlen -= offset;
 				nhoff += offset;
 			}
+
+			rcu_read_unlock();
 		}
 #endif
 	}
diff --git a/net/dsa/conduit.c b/net/dsa/conduit.c
index 3dfdb3cb47dc..967770cdf88f 100644
--- a/net/dsa/conduit.c
+++ b/net/dsa/conduit.c
@@ -9,6 +9,7 @@
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
+#include <linux/rcupdate.h>
 #include <net/dsa.h>
 
 #include "conduit.h"
@@ -18,7 +19,7 @@
 
 static int dsa_conduit_get_regs_len(struct net_device *dev)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
 	struct dsa_switch *ds = cpu_dp->ds;
 	int port = cpu_dp->index;
@@ -48,7 +49,7 @@ static int dsa_conduit_get_regs_len(struct net_device *dev)
 static void dsa_conduit_get_regs(struct net_device *dev,
 				 struct ethtool_regs *regs, void *data)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
 	struct dsa_switch *ds = cpu_dp->ds;
 	struct ethtool_drvinfo *cpu_info;
@@ -84,7 +85,7 @@ static void dsa_conduit_get_ethtool_stats(struct net_device *dev,
 					  struct ethtool_stats *stats,
 					  uint64_t *data)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
 	struct dsa_switch *ds = cpu_dp->ds;
 	int port = cpu_dp->index;
@@ -103,7 +104,7 @@ static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
 					      struct ethtool_stats *stats,
 					      uint64_t *data)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
 	struct dsa_switch *ds = cpu_dp->ds;
 	int port = cpu_dp->index;
@@ -127,7 +128,7 @@ static void dsa_conduit_get_ethtool_phy_stats(struct net_device *dev,
 
 static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
 	struct dsa_switch *ds = cpu_dp->ds;
 	int count = 0;
@@ -150,7 +151,7 @@ static int dsa_conduit_get_sset_count(struct net_device *dev, int sset)
 static void dsa_conduit_get_strings(struct net_device *dev, uint32_t stringset,
 				    uint8_t *data)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
 	const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
 	struct dsa_switch *ds = cpu_dp->ds;
 	int port = cpu_dp->index;
@@ -202,7 +203,7 @@ int __dsa_conduit_hwtstamp_validate(struct net_device *dev,
 				    const struct kernel_hwtstamp_config *config,
 				    struct netlink_ext_ack *extack)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
 	struct dsa_switch *ds = cpu_dp->ds;
 	struct dsa_switch_tree *dst;
 	struct dsa_port *dp;
@@ -222,7 +223,7 @@ int __dsa_conduit_hwtstamp_validate(struct net_device *dev,
 
 static int dsa_conduit_ethtool_setup(struct net_device *dev)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
 	struct dsa_switch *ds = cpu_dp->ds;
 	struct ethtool_ops *ops;
 
@@ -251,7 +252,7 @@ static int dsa_conduit_ethtool_setup(struct net_device *dev)
 
 static void dsa_conduit_ethtool_teardown(struct net_device *dev)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
 
 	if (netif_is_lag_master(dev))
 		return;
@@ -267,13 +268,14 @@ static void dsa_conduit_ethtool_teardown(struct net_device *dev)
  */
 static void dsa_conduit_set_promiscuity(struct net_device *dev, int inc)
 {
-	const struct dsa_device_ops *ops = dev->dsa_ptr->tag_ops;
+	const struct dsa_device_ops *ops;
+
+	ASSERT_RTNL();
+	ops = rtnl_dereference(dev->dsa_ptr)->tag_ops;
 
 	if ((dev->priv_flags & IFF_UNICAST_FLT) && !ops->promisc_on_conduit)
 		return;
 
-	ASSERT_RTNL();
-
 	dev_set_promiscuity(dev, inc);
 }
 
@@ -281,10 +283,17 @@ static ssize_t tagging_show(struct device *d, struct device_attribute *attr,
 			    char *buf)
 {
 	struct net_device *dev = to_net_dev(d);
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp;
+	int ret = 0;
+
+	rcu_read_lock();
+	cpu_dp = rcu_dereference(dev->dsa_ptr);
+	if (cpu_dp)
+		ret = sysfs_emit(buf, "%s\n",
+				 dsa_tag_protocol_to_str(cpu_dp->tag_ops));
+	rcu_read_unlock();
 
-	return sysfs_emit(buf, "%s\n",
-		       dsa_tag_protocol_to_str(cpu_dp->tag_ops));
+	return ret;
 }
 
 static ssize_t tagging_store(struct device *d, struct device_attribute *attr,
@@ -293,7 +302,7 @@ static ssize_t tagging_store(struct device *d, struct device_attribute *attr,
 	const struct dsa_device_ops *new_tag_ops, *old_tag_ops;
 	const char *end = strchrnul(buf, '\n'), *name;
 	struct net_device *dev = to_net_dev(d);
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp;
 	size_t len = end - buf;
 	int err;
 
@@ -305,13 +314,17 @@ static ssize_t tagging_store(struct device *d, struct device_attribute *attr,
 	if (!name)
 		return -ENOMEM;
 
-	old_tag_ops = cpu_dp->tag_ops;
 	new_tag_ops = dsa_tag_driver_get_by_name(name);
 	kfree(name);
 	/* Bad tagger name? */
 	if (IS_ERR(new_tag_ops))
 		return PTR_ERR(new_tag_ops);
 
+	if (!rtnl_trylock())
+		return restart_syscall();
+
+	cpu_dp = rtnl_dereference(dev->dsa_ptr);
+	old_tag_ops = cpu_dp->tag_ops;
 	if (new_tag_ops == old_tag_ops)
 		/* Drop the temporarily held duplicate reference, since
 		 * the DSA switch tree uses this tagger.
@@ -321,6 +334,7 @@ static ssize_t tagging_store(struct device *d, struct device_attribute *attr,
 	err = dsa_tree_change_tag_proto(cpu_dp->ds->dst, new_tag_ops,
 					old_tag_ops);
 	if (err) {
+		rtnl_unlock();
 		/* On failure the old tagger is restored, so we don't need the
 		 * driver for the new one.
 		 */
@@ -331,6 +345,7 @@ static ssize_t tagging_store(struct device *d, struct device_attribute *attr,
 	/* On success we no longer need the module for the old tagging protocol
 	 */
 out:
+	rtnl_unlock();
 	dsa_tag_driver_put(old_tag_ops);
 	return count;
 }
@@ -384,13 +399,11 @@ int dsa_conduit_setup(struct net_device *dev, struct dsa_port *cpu_dp)
 		netdev_warn(dev, "error %d setting MTU to %d to include DSA overhead\n",
 			    ret, mtu);
 
-	/* If we use a tagging format that doesn't have an ethertype
-	 * field, make sure that all packets from this point on get
-	 * sent to the tag format's receive function.
+	rcu_assign_pointer(dev->dsa_ptr, cpu_dp);
+	/*
+	 * No need to synchronize_rcu() here because dsa_ptr in not going away
+	 * before it will be zeroed
 	 */
-	wmb();
-
-	dev->dsa_ptr = cpu_dp;
 
 	dsa_conduit_set_promiscuity(dev, 1);
 
@@ -418,13 +431,12 @@ void dsa_conduit_teardown(struct net_device *dev)
 	dsa_conduit_reset_mtu(dev);
 	dsa_conduit_set_promiscuity(dev, -1);
 
-	dev->dsa_ptr = NULL;
-
 	/* If we used a tagging format that doesn't have an ethertype
 	 * field, make sure that all packets from this point get sent
 	 * without the tag and go through the regular receive path.
 	 */
-	wmb();
+	rcu_assign_pointer(dev->dsa_ptr, NULL);
+	synchronize_rcu();
 }
 
 int dsa_conduit_lag_setup(struct net_device *lag_dev, struct dsa_port *cpu_dp,
@@ -434,7 +446,7 @@ int dsa_conduit_lag_setup(struct net_device *lag_dev, struct dsa_port *cpu_dp,
 	bool conduit_setup = false;
 	int err;
 
-	if (!netdev_uses_dsa(lag_dev)) {
+	if (!__netdev_uses_dsa_currently(lag_dev)) {
 		err = dsa_conduit_setup(lag_dev, cpu_dp);
 		if (err)
 			return err;
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 668c729946ea..36b9ebddc8b8 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -976,6 +976,8 @@ static int dsa_tree_bind_tag_proto(struct dsa_switch_tree *dst,
 /* Since the dsa/tagging sysfs device attribute is per conduit, the assumption
  * is that all DSA switches within a tree share the same tagger, otherwise
  * they would have formed disjoint trees (different "dsa,member" values).
+ *
+ * Must be called with RTNL lock held.
  */
 int dsa_tree_change_tag_proto(struct dsa_switch_tree *dst,
 			      const struct dsa_device_ops *tag_ops,
@@ -985,8 +987,7 @@ int dsa_tree_change_tag_proto(struct dsa_switch_tree *dst,
 	struct dsa_port *dp;
 	int err = -EBUSY;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	ASSERT_RTNL();
 
 	/* At the moment we don't allow changing the tag protocol under
 	 * traffic. The rtnl_mutex also happens to serialize concurrent
@@ -1011,15 +1012,12 @@ int dsa_tree_change_tag_proto(struct dsa_switch_tree *dst,
 	if (err)
 		goto out_unwind_tagger;
 
-	rtnl_unlock();
-
 	return 0;
 
 out_unwind_tagger:
 	info.tag_ops = old_tag_ops;
 	dsa_tree_notify(dst, DSA_NOTIFIER_TAG_PROTO, &info);
 out_unlock:
-	rtnl_unlock();
 	return err;
 }
 
@@ -1027,7 +1025,7 @@ static void dsa_tree_conduit_state_change(struct dsa_switch_tree *dst,
 					  struct net_device *conduit)
 {
 	struct dsa_notifier_conduit_state_info info;
-	struct dsa_port *cpu_dp = conduit->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(conduit->dsa_ptr);
 
 	info.conduit = conduit;
 	info.operational = dsa_port_conduit_is_operational(cpu_dp);
@@ -1039,7 +1037,7 @@ void dsa_tree_conduit_admin_state_change(struct dsa_switch_tree *dst,
 					 struct net_device *conduit,
 					 bool up)
 {
-	struct dsa_port *cpu_dp = conduit->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(conduit->dsa_ptr);
 	bool notify = false;
 
 	/* Don't keep track of admin state on LAG DSA conduits,
@@ -1062,7 +1060,7 @@ void dsa_tree_conduit_oper_state_change(struct dsa_switch_tree *dst,
 					struct net_device *conduit,
 					bool up)
 {
-	struct dsa_port *cpu_dp = conduit->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(conduit->dsa_ptr);
 	bool notify = false;
 
 	/* Don't keep track of oper state on LAG DSA conduits,
@@ -1594,10 +1592,11 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 	}
 
 	/* Disconnect from further netdevice notifiers on the conduit,
-	 * since netdev_uses_dsa() will now return false.
+	 * from now on, netdev_uses_dsa_currently() will return false.
 	 */
 	dsa_switch_for_each_cpu_port(dp, ds)
-		dp->conduit->dsa_ptr = NULL;
+		rcu_assign_pointer(dp->conduit->dsa_ptr, NULL);
+	synchronize_rcu();
 
 	rtnl_unlock();
 out:
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 25258b33e59e..6220c520d776 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -11,6 +11,7 @@
 #include <linux/notifier.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/rtnetlink.h>
 
 #include "dsa.h"
 #include "port.h"
@@ -1414,7 +1415,7 @@ static int dsa_port_assign_conduit(struct dsa_port *dp,
 	if (err && fail_on_err)
 		return err;
 
-	dp->cpu_dp = conduit->dsa_ptr;
+	dp->cpu_dp = rtnl_dereference(conduit->dsa_ptr);
 	dp->cpu_port_in_lag = netif_is_lag_master(conduit);
 
 	return 0;
diff --git a/net/dsa/tag.c b/net/dsa/tag.c
index 79ad105902d9..ba662adecc14 100644
--- a/net/dsa/tag.c
+++ b/net/dsa/tag.c
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <linux/ptp_classify.h>
 #include <linux/skbuff.h>
+#include <linux/rcupdate.h>
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
 
@@ -55,7 +56,7 @@ static int dsa_switch_rcv(struct sk_buff *skb, struct net_device *dev,
 			  struct packet_type *pt, struct net_device *unused)
 {
 	struct metadata_dst *md_dst = skb_metadata_dst(skb);
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
+	struct dsa_port *cpu_dp = rcu_dereference(dev->dsa_ptr);
 	struct sk_buff *nskb = NULL;
 	struct dsa_user_priv *p;
 
diff --git a/net/dsa/tag.h b/net/dsa/tag.h
index d5707870906b..dbb2217d4344 100644
--- a/net/dsa/tag.h
+++ b/net/dsa/tag.h
@@ -5,6 +5,7 @@
 
 #include <linux/if_vlan.h>
 #include <linux/list.h>
+#include <linux/rcupdate.h>
 #include <linux/types.h>
 #include <net/dsa.h>
 
@@ -32,11 +33,14 @@ static inline int dsa_tag_protocol_overhead(const struct dsa_device_ops *ops)
 static inline struct net_device *dsa_conduit_find_user(struct net_device *dev,
 						       int device, int port)
 {
-	struct dsa_port *cpu_dp = dev->dsa_ptr;
-	struct dsa_switch_tree *dst = cpu_dp->dst;
+	struct dsa_port *cpu_dp;
 	struct dsa_port *dp;
 
-	list_for_each_entry(dp, &dst->ports, list)
+	cpu_dp = rcu_dereference(dev->dsa_ptr);
+	if (!cpu_dp)
+		return NULL;
+
+	list_for_each_entry(dp, &cpu_dp->dst->ports, list)
 		if (dp->ds->index == device && dp->index == port &&
 		    dp->type == DSA_PORT_TYPE_USER)
 			return dp->user;
@@ -184,14 +188,17 @@ static inline struct sk_buff *dsa_software_vlan_untag(struct sk_buff *skb)
 static inline struct net_device *
 dsa_find_designated_bridge_port_by_vid(struct net_device *conduit, u16 vid)
 {
-	struct dsa_port *cpu_dp = conduit->dsa_ptr;
-	struct dsa_switch_tree *dst = cpu_dp->dst;
+	struct dsa_port *cpu_dp;
 	struct bridge_vlan_info vinfo;
 	struct net_device *user;
 	struct dsa_port *dp;
 	int err;
 
-	list_for_each_entry(dp, &dst->ports, list) {
+	cpu_dp = rcu_dereference(conduit->dsa_ptr);
+	if (!cpu_dp)
+		return NULL;
+
+	list_for_each_entry(dp, &cpu_dp->dst->ports, list) {
 		if (dp->type != DSA_PORT_TYPE_USER)
 			continue;
 
diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 3ee53e28ec2e..c9fb4fd2a4cf 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -5,6 +5,7 @@
  * primitives for taggers that rely on 802.1Q VLAN tags to use.
  */
 #include <linux/if_vlan.h>
+#include <linux/rcupdate.h>
 #include <linux/dsa/8021q.h>
 
 #include "port.h"
@@ -474,14 +475,17 @@ EXPORT_SYMBOL_GPL(dsa_8021q_xmit);
 static struct net_device *
 dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit, int vbid)
 {
-	struct dsa_port *cpu_dp = conduit->dsa_ptr;
-	struct dsa_switch_tree *dst = cpu_dp->dst;
+	struct dsa_port *cpu_dp;
 	struct dsa_port *dp;
 
 	if (WARN_ON(!vbid))
 		return NULL;
 
-	dsa_tree_for_each_user_port(dp, dst) {
+	cpu_dp = rcu_dereference(conduit->dsa_ptr);
+	if (!cpu_dp)
+		return NULL;
+
+	dsa_tree_for_each_user_port(dp, cpu_dp->dst) {
 		if (!dp->bridge)
 			continue;
 
diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 8c3c068728e5..c87f16cd959f 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -269,7 +269,7 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 		return NULL;
 
 	/* VLAN tag is added by BCM63xx internal switch */
-	if (netdev_uses_dsa(skb->dev))
+	if (__netdev_uses_dsa_currently(skb->dev))
 		len += VLAN_HLEN;
 
 	/* Remove Broadcom tag and update checksum */
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c
index 2a2c4fb61a65..7f5dc8d384c9 100644
--- a/net/dsa/tag_dsa.c
+++ b/net/dsa/tag_dsa.c
@@ -48,6 +48,7 @@
 #include <linux/dsa/mv88e6xxx.h>
 #include <linux/etherdevice.h>
 #include <linux/list.h>
+#include <linux/rcupdate.h>
 #include <linux/slab.h>
 
 #include "tag.h"
@@ -257,14 +258,15 @@ static struct sk_buff *dsa_rcv_ll(struct sk_buff *skb, struct net_device *dev,
 	source_port = (dsa_header[1] >> 3) & 0x1f;
 
 	if (trunk) {
-		struct dsa_port *cpu_dp = dev->dsa_ptr;
-		struct dsa_lag *lag;
+		struct dsa_port *cpu_dp = rcu_dereference(dev->dsa_ptr);
+		struct dsa_lag *lag = NULL;
 
 		/* The exact source port is not available in the tag,
 		 * so we inject the frame directly on the upper
 		 * team/bond.
 		 */
-		lag = dsa_lag_by_id(cpu_dp->dst, source_port + 1);
+		if (cpu_dp)
+			lag = dsa_lag_by_id(cpu_dp->dst, source_port + 1);
 		skb->dev = lag ? lag->dev : NULL;
 	} else {
 		skb->dev = dsa_conduit_find_user(dev, source_device,
diff --git a/net/dsa/tag_qca.c b/net/dsa/tag_qca.c
index 0cf61286b426..dbc1f659ed07 100644
--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -5,6 +5,7 @@
 
 #include <linux/etherdevice.h>
 #include <linux/bitfield.h>
+#include <linux/rcupdate.h>
 #include <net/dsa.h>
 #include <linux/dsa/tag_qca.h>
 
@@ -36,8 +37,8 @@ static struct sk_buff *qca_tag_xmit(struct sk_buff *skb, struct net_device *dev)
 static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 {
 	struct qca_tagger_data *tagger_data;
-	struct dsa_port *dp = dev->dsa_ptr;
-	struct dsa_switch *ds = dp->ds;
+	struct dsa_port *dp;
+	struct dsa_switch *ds;
 	u8 ver, pk_type;
 	__be16 *phdr;
 	int port;
@@ -45,6 +46,11 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 
 	BUILD_BUG_ON(sizeof(struct qca_mgmt_ethhdr) != QCA_HDR_MGMT_HEADER_LEN + QCA_HDR_LEN);
 
+	dp = rcu_dereference(dev->dsa_ptr);
+	if (!dp)
+		return NULL;
+	ds = dp->ds;
+
 	tagger_data = ds->tagger_data;
 
 	if (unlikely(!pskb_may_pull(skb, QCA_HDR_LEN)))
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 3e902af7eea6..0746a7d34178 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -5,6 +5,7 @@
 #include <linux/dsa/sja1105.h>
 #include <linux/dsa/8021q.h>
 #include <linux/packing.h>
+#include <linux/rcupdate.h>
 
 #include "tag.h"
 #include "tag_8021q.h"
@@ -530,12 +531,13 @@ static struct sk_buff *sja1110_rcv_meta(struct sk_buff *skb, u16 rx_header)
 	int n_ts = SJA1110_RX_HEADER_N_TS(rx_header);
 	struct sja1105_tagger_data *tagger_data;
 	struct net_device *conduit = skb->dev;
+	struct dsa_switch *ds = NULL;
 	struct dsa_port *cpu_dp;
-	struct dsa_switch *ds;
 	int i;
 
-	cpu_dp = conduit->dsa_ptr;
-	ds = dsa_switch_find(cpu_dp->dst->index, switch_id);
+	cpu_dp = rcu_dereference(conduit->dsa_ptr);
+	if (cpu_dp)
+		ds = dsa_switch_find(cpu_dp->dst->index, switch_id);
 	if (!ds) {
 		net_err_ratelimited("%s: cannot find switch id %d\n",
 				    conduit->name, switch_id);
@@ -662,24 +664,26 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	return skb;
 }
 
-static void sja1105_flow_dissect(const struct sk_buff *skb, __be16 *proto,
-				 int *offset)
+static void sja1105_flow_dissect(const struct sk_buff *skb,
+				 const struct dsa_port *dp,
+				 __be16 *proto, int *offset)
 {
 	/* No tag added for management frames, all ok */
 	if (unlikely(sja1105_is_link_local(skb)))
 		return;
 
-	dsa_tag_generic_flow_dissect(skb, proto, offset);
+	dsa_tag_generic_flow_dissect(skb, dp, proto, offset);
 }
 
-static void sja1110_flow_dissect(const struct sk_buff *skb, __be16 *proto,
-				 int *offset)
+static void sja1110_flow_dissect(const struct sk_buff *skb,
+				 const struct dsa_port *dp,
+				 __be16 *proto, int *offset)
 {
 	/* Management frames have 2 DSA tags on RX, so the needed_headroom we
 	 * declared is fine for the generic dissector adjustment procedure.
 	 */
 	if (unlikely(sja1105_is_link_local(skb)))
-		return dsa_tag_generic_flow_dissect(skb, proto, offset);
+		return dsa_tag_generic_flow_dissect(skb, dp, proto, offset);
 
 	/* For the rest, there is a single DSA tag, the tag_8021q one */
 	*offset = VLAN_HLEN;
diff --git a/net/dsa/user.c b/net/dsa/user.c
index f5adfa1d978a..2afd21e34772 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -21,6 +21,7 @@
 #include <linux/if_hsr.h>
 #include <net/dcbnl.h>
 #include <linux/netpoll.h>
+#include <linux/rcupdate.h>
 #include <linux/string.h>
 
 #include "conduit.h"
@@ -2839,7 +2840,7 @@ int dsa_user_change_conduit(struct net_device *dev, struct net_device *conduit,
 		return -EOPNOTSUPP;
 	}
 
-	if (!netdev_uses_dsa(conduit)) {
+	if (!__netdev_uses_dsa_currently(conduit)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Interface not eligible as DSA conduit");
 		return -EOPNOTSUPP;
@@ -3141,8 +3142,8 @@ static int dsa_lag_conduit_validate(struct net_device *lag_dev,
 
 	netdev_for_each_lower_dev(lag_dev, lower1, iter1) {
 		netdev_for_each_lower_dev(lag_dev, lower2, iter2) {
-			if (!netdev_uses_dsa(lower1) ||
-			    !netdev_uses_dsa(lower2)) {
+			if (!__netdev_uses_dsa_currently(lower1) ||
+			    !__netdev_uses_dsa_currently(lower2)) {
 				NL_SET_ERR_MSG_MOD(extack,
 						   "All LAG ports must be eligible as DSA conduits");
 				return notifier_from_errno(-EINVAL);
@@ -3151,8 +3152,8 @@ static int dsa_lag_conduit_validate(struct net_device *lag_dev,
 			if (lower1 == lower2)
 				continue;
 
-			if (!dsa_port_tree_same(lower1->dsa_ptr,
-						lower2->dsa_ptr)) {
+			if (!dsa_port_tree_same(rtnl_dereference(lower1->dsa_ptr),
+						rtnl_dereference(lower2->dsa_ptr))) {
 				NL_SET_ERR_MSG_MOD(extack,
 						   "LAG contains DSA conduits of disjoint switch trees");
 				return notifier_from_errno(-EINVAL);
@@ -3169,7 +3170,7 @@ dsa_conduit_prechangeupper_sanity_check(struct net_device *conduit,
 {
 	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(&info->info);
 
-	if (!netdev_uses_dsa(conduit))
+	if (!__netdev_uses_dsa_currently(conduit))
 		return NOTIFY_DONE;
 
 	if (!info->linking)
@@ -3205,20 +3206,22 @@ dsa_lag_conduit_prechangelower_sanity_check(struct net_device *dev,
 	struct net_device *lower;
 	struct list_head *iter;
 
-	if (!netdev_uses_dsa(lag_dev) || !netif_is_lag_master(lag_dev))
+	if (!__netdev_uses_dsa_currently(lag_dev) ||
+	    !netif_is_lag_master(lag_dev))
 		return NOTIFY_DONE;
 
 	if (!info->linking)
 		return NOTIFY_DONE;
 
-	if (!netdev_uses_dsa(dev)) {
+	if (!__netdev_uses_dsa_currently(dev)) {
 		NL_SET_ERR_MSG(extack,
 			       "Only DSA conduits can join a LAG DSA conduit");
 		return notifier_from_errno(-EINVAL);
 	}
 
 	netdev_for_each_lower_dev(lag_dev, lower, iter) {
-		if (!dsa_port_tree_same(dev->dsa_ptr, lower->dsa_ptr)) {
+		if (!dsa_port_tree_same(rtnl_dereference(dev->dsa_ptr),
+					rtnl_dereference(lower->dsa_ptr))) {
 			NL_SET_ERR_MSG(extack,
 				       "Interface is DSA conduit for a different switch tree than this LAG");
 			return notifier_from_errno(-EINVAL);
@@ -3257,7 +3260,8 @@ dsa_bridge_prechangelower_sanity_check(struct net_device *new_lower,
 	extack = netdev_notifier_info_to_extack(&info->info);
 
 	netdev_for_each_lower_dev(br, lower, iter) {
-		if (!netdev_uses_dsa(new_lower) && !netdev_uses_dsa(lower))
+		if (!__netdev_uses_dsa_currently(new_lower) &&
+		    !__netdev_uses_dsa_currently(lower))
 			continue;
 
 		if (!netdev_port_same_parent_id(lower, new_lower)) {
@@ -3295,7 +3299,7 @@ static int dsa_conduit_lag_join(struct net_device *conduit,
 				struct netdev_lag_upper_info *uinfo,
 				struct netlink_ext_ack *extack)
 {
-	struct dsa_port *cpu_dp = conduit->dsa_ptr;
+	struct dsa_port *cpu_dp = rtnl_dereference(conduit->dsa_ptr);
 	struct dsa_switch_tree *dst = cpu_dp->dst;
 	struct dsa_port *dp;
 	int err;
@@ -3328,7 +3332,7 @@ static int dsa_conduit_lag_join(struct net_device *conduit,
 		}
 	}
 
-	dsa_conduit_lag_teardown(lag_dev, conduit->dsa_ptr);
+	dsa_conduit_lag_teardown(lag_dev, rtnl_dereference(conduit->dsa_ptr));
 
 	return err;
 }
@@ -3336,17 +3340,16 @@ static int dsa_conduit_lag_join(struct net_device *conduit,
 static void dsa_conduit_lag_leave(struct net_device *conduit,
 				  struct net_device *lag_dev)
 {
-	struct dsa_port *dp, *cpu_dp = lag_dev->dsa_ptr;
+	struct dsa_port *dp, *cpu_dp = rtnl_dereference(lag_dev->dsa_ptr);
 	struct dsa_switch_tree *dst = cpu_dp->dst;
 	struct dsa_port *new_cpu_dp = NULL;
 	struct net_device *lower;
 	struct list_head *iter;
 
 	netdev_for_each_lower_dev(lag_dev, lower, iter) {
-		if (netdev_uses_dsa(lower)) {
-			new_cpu_dp = lower->dsa_ptr;
+		new_cpu_dp = rtnl_dereference(lower->dsa_ptr);
+		if (new_cpu_dp)
 			break;
-		}
 	}
 
 	if (new_cpu_dp) {
@@ -3360,8 +3363,11 @@ static void dsa_conduit_lag_leave(struct net_device *conduit,
 		/* Update the index of the virtual CPU port to match the lowest
 		 * physical CPU port
 		 */
-		lag_dev->dsa_ptr = new_cpu_dp;
-		wmb();
+		rcu_assign_pointer(lag_dev->dsa_ptr, new_cpu_dp);
+		/*
+		 * No need to synchronize_rcu() here because dsa_ptr in not
+		 * going away before it will be zeroed
+		 */
 	} else {
 		/* If the LAG DSA conduit has no ports left, migrate back all
 		 * user ports to the first physical CPU port
@@ -3372,7 +3378,7 @@ static void dsa_conduit_lag_leave(struct net_device *conduit,
 	/* This DSA conduit has left its LAG in any case, so let
 	 * the CPU port leave the hardware LAG as well
 	 */
-	dsa_conduit_lag_teardown(lag_dev, conduit->dsa_ptr);
+	dsa_conduit_lag_teardown(lag_dev, rtnl_dereference(conduit->dsa_ptr));
 }
 
 static int dsa_conduit_changeupper(struct net_device *dev,
@@ -3381,7 +3387,7 @@ static int dsa_conduit_changeupper(struct net_device *dev,
 	struct netlink_ext_ack *extack;
 	int err = NOTIFY_DONE;
 
-	if (!netdev_uses_dsa(dev))
+	if (!__netdev_uses_dsa_currently(dev))
 		return err;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
@@ -3464,14 +3470,14 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 			err = dsa_port_lag_change(dp, info->lower_state_info);
 		}
 
+		dp = rtnl_dereference(dev->dsa_ptr);
+		if (!dp)
+			return NOTIFY_OK;
+
 		/* Mirror LAG port events on DSA conduits that are in
 		 * a LAG towards their respective switch CPU ports
 		 */
-		if (netdev_uses_dsa(dev)) {
-			dp = dev->dsa_ptr;
-
-			err = dsa_port_lag_change(dp, info->lower_state_info);
-		}
+		err = dsa_port_lag_change(dp, info->lower_state_info);
 
 		return notifier_from_errno(err);
 	}
@@ -3481,39 +3487,41 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 		 * DSA driver may require the conduit port (and indirectly
 		 * the tagger) to be available for some special operation.
 		 */
-		if (netdev_uses_dsa(dev)) {
-			struct dsa_port *cpu_dp = dev->dsa_ptr;
-			struct dsa_switch_tree *dst = cpu_dp->ds->dst;
-
-			/* Track when the conduit port is UP */
-			dsa_tree_conduit_oper_state_change(dst, dev,
-							   netif_oper_up(dev));
-
-			/* Track when the conduit port is ready and can accept
-			 * packet.
-			 * NETDEV_UP event is not enough to flag a port as ready.
-			 * We also have to wait for linkwatch_do_dev to dev_activate
-			 * and emit a NETDEV_CHANGE event.
-			 * We check if a conduit port is ready by checking if the dev
-			 * have a qdisc assigned and is not noop.
-			 */
-			dsa_tree_conduit_admin_state_change(dst, dev,
-							    !qdisc_tx_is_noop(dev));
+		struct dsa_port *cpu_dp = rtnl_dereference(dev->dsa_ptr);
+		struct dsa_switch_tree *dst;
 
-			return NOTIFY_OK;
-		}
+		if (!cpu_dp)
+			return NOTIFY_DONE;
+
+		dst = cpu_dp->ds->dst;
+
+		/* Track when the conduit port is UP */
+		dsa_tree_conduit_oper_state_change(dst, dev,
+						   netif_oper_up(dev));
+
+		/* Track when the conduit port is ready and can accept
+		 * packet.
+		 * NETDEV_UP event is not enough to flag a port as ready.
+		 * We also have to wait for linkwatch_do_dev to dev_activate
+		 * and emit a NETDEV_CHANGE event.
+		 * We check if a conduit port is ready by checking if the dev
+		 * have a qdisc assigned and is not noop.
+		 */
+		dsa_tree_conduit_admin_state_change(dst, dev,
+						    !qdisc_tx_is_noop(dev));
+
+		return NOTIFY_OK;
 
-		return NOTIFY_DONE;
 	}
 	case NETDEV_GOING_DOWN: {
 		struct dsa_port *dp, *cpu_dp;
 		struct dsa_switch_tree *dst;
 		LIST_HEAD(close_list);
 
-		if (!netdev_uses_dsa(dev))
+		cpu_dp = rtnl_dereference(dev->dsa_ptr);
+		if (!cpu_dp)
 			return NOTIFY_DONE;
 
-		cpu_dp = dev->dsa_ptr;
 		dst = cpu_dp->ds->dst;
 
 		dsa_tree_conduit_admin_state_change(dst, dev, false);
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 4e3651101b86..a05ff82551c3 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -170,7 +170,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	 * variants has been configured on the receiving interface,
 	 * and if so, set skb->protocol without looking at the packet.
 	 */
-	if (unlikely(netdev_uses_dsa(dev)))
+	if (unlikely(netdev_uses_dsa_currently(dev)))
 		return htons(ETH_P_XDSA);
 
 	if (likely(eth_proto_is_802_3(eth->h_proto)))
-- 
2.46.0


