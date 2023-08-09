Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31753775769
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjHIKpp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHIKpo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:45:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A3C10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA61F6283F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4F7C433C7;
        Wed,  9 Aug 2023 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577940;
        bh=FzIT9y/lJB3Iu5NnXj8MmGQtskAFfYLNhs+ADUfGXRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8Nwg769qRDlQNzQDdrERxdtOX2VlPqttlo9IoIa/aAjOoGBuM3NucduEqWNUweEv
         JqLpTmEMtdbs0Ho9XHTVJnwr1wyEd2QAC/B1VKTIiUxEWL7w2AVT24KURIA5o6LwKt
         Z7LBTdnaRich+YzW7oImYcOfl09BSyU2MDiK3JM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Simon Horman <simon.horman@corigine.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 049/165] net: move gso declarations and functions to their own files
Date:   Wed,  9 Aug 2023 12:39:40 +0200
Message-ID: <20230809103644.422860669@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d457a0e329b0bfd3a1450e0b1a18cd2b47a25a08 ]

Move declarations into include/net/gso.h and code into net/core/gso.c

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230608191738.3947077-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 7938cd154368 ("net: gro: fix misuse of CB in udp socket lookup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c           |   1 +
 .../net/ethernet/myricom/myri10ge/myri10ge.c  |   1 +
 drivers/net/ethernet/sfc/siena/tx_common.c    |   1 +
 drivers/net/ethernet/sfc/tx_common.c          |   1 +
 drivers/net/tap.c                             |   1 +
 drivers/net/usb/r8152.c                       |   1 +
 drivers/net/wireguard/device.c                |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   1 +
 include/linux/netdevice.h                     |  26 +-
 include/linux/skbuff.h                        |  71 -----
 include/net/gro.h                             |   1 +
 include/net/gso.h                             | 109 +++++++
 include/net/udp.h                             |   1 +
 net/core/Makefile                             |   2 +-
 net/core/dev.c                                |  70 +----
 net/core/gro.c                                |  59 +---
 net/core/gso.c                                | 273 ++++++++++++++++++
 net/core/skbuff.c                             | 142 +--------
 net/ipv4/af_inet.c                            |   1 +
 net/ipv4/esp4_offload.c                       |   1 +
 net/ipv4/gre_offload.c                        |   1 +
 net/ipv4/ip_output.c                          |   1 +
 net/ipv4/tcp_offload.c                        |   1 +
 net/ipv4/udp.c                                |   1 +
 net/ipv4/udp_offload.c                        |   1 +
 net/ipv6/esp6_offload.c                       |   1 +
 net/ipv6/ip6_offload.c                        |   1 +
 net/ipv6/ip6_output.c                         |   1 +
 net/ipv6/udp_offload.c                        |   1 +
 net/mac80211/tx.c                             |   1 +
 net/mpls/af_mpls.c                            |   1 +
 net/mpls/mpls_gso.c                           |   1 +
 net/netfilter/nf_flow_table_ip.c              |   1 +
 net/netfilter/nfnetlink_queue.c               |   1 +
 net/nsh/nsh.c                                 |   1 +
 net/openvswitch/actions.c                     |   1 +
 net/openvswitch/datapath.c                    |   1 +
 net/sched/act_police.c                        |   1 +
 net/sched/sch_cake.c                          |   1 +
 net/sched/sch_netem.c                         |   1 +
 net/sched/sch_taprio.c                        |   1 +
 net/sched/sch_tbf.c                           |   1 +
 net/sctp/offload.c                            |   1 +
 net/xfrm/xfrm_device.c                        |   1 +
 net/xfrm/xfrm_interface_core.c                |   1 +
 net/xfrm/xfrm_output.c                        |   1 +
 46 files changed, 425 insertions(+), 365 deletions(-)
 create mode 100644 include/net/gso.h
 create mode 100644 net/core/gso.c

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index a52cf9aae4988..5ef073a79ce94 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -57,6 +57,7 @@
 #include <linux/crc32poly.h>
 
 #include <net/checksum.h>
+#include <net/gso.h>
 #include <net/ip.h>
 
 #include <linux/io.h>
diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index c5687d94ea885..7b7e1c5b00f47 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -66,6 +66,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include <net/checksum.h>
+#include <net/gso.h>
 #include <net/ip.h>
 #include <net/tcp.h>
 #include <asm/byteorder.h>
diff --git a/drivers/net/ethernet/sfc/siena/tx_common.c b/drivers/net/ethernet/sfc/siena/tx_common.c
index 93a32d61944f0..a7a9ab304e136 100644
--- a/drivers/net/ethernet/sfc/siena/tx_common.c
+++ b/drivers/net/ethernet/sfc/siena/tx_common.c
@@ -12,6 +12,7 @@
 #include "efx.h"
 #include "nic_common.h"
 #include "tx_common.h"
+#include <net/gso.h>
 
 static unsigned int efx_tx_cb_page_count(struct efx_tx_queue *tx_queue)
 {
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index 755aa92bf8236..9f2393d343715 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -12,6 +12,7 @@
 #include "efx.h"
 #include "nic_common.h"
 #include "tx_common.h"
+#include <net/gso.h>
 
 static unsigned int efx_tx_cb_page_count(struct efx_tx_queue *tx_queue)
 {
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d30d730ed5a71..9137fb8c1c420 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/uio.h>
 
+#include <net/gso.h>
 #include <net/net_namespace.h>
 #include <net/rtnetlink.h>
 #include <net/sock.h>
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0999a58ca9d26..0738baa5b82e4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -27,6 +27,7 @@
 #include <linux/firmware.h>
 #include <crypto/hash.h>
 #include <linux/usb/r8152.h>
+#include <net/gso.h>
 
 /* Information for net-next */
 #define NETNEXT_VERSION		"12"
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index d58e9f818d3b7..258dcc1039216 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -20,6 +20,7 @@
 #include <linux/icmp.h>
 #include <linux/suspend.h>
 #include <net/dst_metadata.h>
+#include <net/gso.h>
 #include <net/icmp.h>
 #include <net/rtnetlink.h>
 #include <net/ip_tunnels.h>
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 00719e1304386..682733193d3de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -7,6 +7,7 @@
 #include <linux/ieee80211.h>
 #include <linux/etherdevice.h>
 #include <linux/tcp.h>
+#include <net/gso.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 68adc8af29efb..9291c04a2e09d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4827,13 +4827,6 @@ int skb_crc32c_csum_help(struct sk_buff *skb);
 int skb_csum_hwoffload_help(struct sk_buff *skb,
 			    const netdev_features_t features);
 
-struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
-				  netdev_features_t features, bool tx_path);
-struct sk_buff *skb_eth_gso_segment(struct sk_buff *skb,
-				    netdev_features_t features, __be16 type);
-struct sk_buff *skb_mac_gso_segment(struct sk_buff *skb,
-				    netdev_features_t features);
-
 struct netdev_bonding_info {
 	ifslave	slave;
 	ifbond	master;
@@ -4856,11 +4849,6 @@ static inline void ethtool_notify(struct net_device *dev, unsigned int cmd,
 }
 #endif
 
-static inline
-struct sk_buff *skb_gso_segment(struct sk_buff *skb, netdev_features_t features)
-{
-	return __skb_gso_segment(skb, features, true);
-}
 __be16 skb_network_protocol(struct sk_buff *skb, int *depth);
 
 static inline bool can_checksum_protocol(netdev_features_t features,
@@ -4987,6 +4975,7 @@ netdev_features_t passthru_features_check(struct sk_buff *skb,
 					  struct net_device *dev,
 					  netdev_features_t features);
 netdev_features_t netif_skb_features(struct sk_buff *skb);
+void skb_warn_bad_offload(const struct sk_buff *skb);
 
 static inline bool net_gso_ok(netdev_features_t features, int gso_type)
 {
@@ -5035,19 +5024,6 @@ void netif_set_tso_max_segs(struct net_device *dev, unsigned int segs);
 void netif_inherit_tso_max(struct net_device *to,
 			   const struct net_device *from);
 
-static inline void skb_gso_error_unwind(struct sk_buff *skb, __be16 protocol,
-					int pulled_hlen, u16 mac_offset,
-					int mac_len)
-{
-	skb->protocol = protocol;
-	skb->encapsulation = 1;
-	skb_push(skb, pulled_hlen);
-	skb_reset_transport_header(skb);
-	skb->mac_header = mac_offset;
-	skb->network_header = skb->mac_header + mac_len;
-	skb->mac_len = mac_len;
-}
-
 static inline bool netif_is_macsec(const struct net_device *dev)
 {
 	return dev->priv_flags & IFF_MACSEC;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0b40417457cd1..fdd9db2612968 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3992,8 +3992,6 @@ int skb_zerocopy(struct sk_buff *to, struct sk_buff *from,
 void skb_split(struct sk_buff *skb, struct sk_buff *skb1, const u32 len);
 int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen);
 void skb_scrub_packet(struct sk_buff *skb, bool xnet);
-bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu);
-bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len);
 struct sk_buff *skb_segment(struct sk_buff *skb, netdev_features_t features);
 struct sk_buff *skb_segment_list(struct sk_buff *skb, netdev_features_t features,
 				 unsigned int offset);
@@ -4859,75 +4857,6 @@ static inline struct sec_path *skb_sec_path(const struct sk_buff *skb)
 #endif
 }
 
-/* Keeps track of mac header offset relative to skb->head.
- * It is useful for TSO of Tunneling protocol. e.g. GRE.
- * For non-tunnel skb it points to skb_mac_header() and for
- * tunnel skb it points to outer mac header.
- * Keeps track of level of encapsulation of network headers.
- */
-struct skb_gso_cb {
-	union {
-		int	mac_offset;
-		int	data_offset;
-	};
-	int	encap_level;
-	__wsum	csum;
-	__u16	csum_start;
-};
-#define SKB_GSO_CB_OFFSET	32
-#define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
-
-static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
-{
-	return (skb_mac_header(inner_skb) - inner_skb->head) -
-		SKB_GSO_CB(inner_skb)->mac_offset;
-}
-
-static inline int gso_pskb_expand_head(struct sk_buff *skb, int extra)
-{
-	int new_headroom, headroom;
-	int ret;
-
-	headroom = skb_headroom(skb);
-	ret = pskb_expand_head(skb, extra, 0, GFP_ATOMIC);
-	if (ret)
-		return ret;
-
-	new_headroom = skb_headroom(skb);
-	SKB_GSO_CB(skb)->mac_offset += (new_headroom - headroom);
-	return 0;
-}
-
-static inline void gso_reset_checksum(struct sk_buff *skb, __wsum res)
-{
-	/* Do not update partial checksums if remote checksum is enabled. */
-	if (skb->remcsum_offload)
-		return;
-
-	SKB_GSO_CB(skb)->csum = res;
-	SKB_GSO_CB(skb)->csum_start = skb_checksum_start(skb) - skb->head;
-}
-
-/* Compute the checksum for a gso segment. First compute the checksum value
- * from the start of transport header to SKB_GSO_CB(skb)->csum_start, and
- * then add in skb->csum (checksum from csum_start to end of packet).
- * skb->csum and csum_start are then updated to reflect the checksum of the
- * resultant packet starting from the transport header-- the resultant checksum
- * is in the res argument (i.e. normally zero or ~ of checksum of a pseudo
- * header.
- */
-static inline __sum16 gso_make_checksum(struct sk_buff *skb, __wsum res)
-{
-	unsigned char *csum_start = skb_transport_header(skb);
-	int plen = (skb->head + SKB_GSO_CB(skb)->csum_start) - csum_start;
-	__wsum partial = SKB_GSO_CB(skb)->csum;
-
-	SKB_GSO_CB(skb)->csum = res;
-	SKB_GSO_CB(skb)->csum_start = csum_start - skb->head;
-
-	return csum_fold(csum_partial(csum_start, plen, partial));
-}
-
 static inline bool skb_is_gso(const struct sk_buff *skb)
 {
 	return skb_shinfo(skb)->gso_size;
diff --git a/include/net/gro.h b/include/net/gro.h
index a4fab706240d2..972ff42d3a829 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -446,5 +446,6 @@ static inline void gro_normal_one(struct napi_struct *napi, struct sk_buff *skb,
 		gro_normal_list(napi);
 }
 
+extern struct list_head offload_base;
 
 #endif /* _NET_IPV6_GRO_H */
diff --git a/include/net/gso.h b/include/net/gso.h
new file mode 100644
index 0000000000000..29975440cad51
--- /dev/null
+++ b/include/net/gso.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _NET_GSO_H
+#define _NET_GSO_H
+
+#include <linux/skbuff.h>
+
+/* Keeps track of mac header offset relative to skb->head.
+ * It is useful for TSO of Tunneling protocol. e.g. GRE.
+ * For non-tunnel skb it points to skb_mac_header() and for
+ * tunnel skb it points to outer mac header.
+ * Keeps track of level of encapsulation of network headers.
+ */
+struct skb_gso_cb {
+	union {
+		int	mac_offset;
+		int	data_offset;
+	};
+	int	encap_level;
+	__wsum	csum;
+	__u16	csum_start;
+};
+#define SKB_GSO_CB_OFFSET	32
+#define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
+
+static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
+{
+	return (skb_mac_header(inner_skb) - inner_skb->head) -
+		SKB_GSO_CB(inner_skb)->mac_offset;
+}
+
+static inline int gso_pskb_expand_head(struct sk_buff *skb, int extra)
+{
+	int new_headroom, headroom;
+	int ret;
+
+	headroom = skb_headroom(skb);
+	ret = pskb_expand_head(skb, extra, 0, GFP_ATOMIC);
+	if (ret)
+		return ret;
+
+	new_headroom = skb_headroom(skb);
+	SKB_GSO_CB(skb)->mac_offset += (new_headroom - headroom);
+	return 0;
+}
+
+static inline void gso_reset_checksum(struct sk_buff *skb, __wsum res)
+{
+	/* Do not update partial checksums if remote checksum is enabled. */
+	if (skb->remcsum_offload)
+		return;
+
+	SKB_GSO_CB(skb)->csum = res;
+	SKB_GSO_CB(skb)->csum_start = skb_checksum_start(skb) - skb->head;
+}
+
+/* Compute the checksum for a gso segment. First compute the checksum value
+ * from the start of transport header to SKB_GSO_CB(skb)->csum_start, and
+ * then add in skb->csum (checksum from csum_start to end of packet).
+ * skb->csum and csum_start are then updated to reflect the checksum of the
+ * resultant packet starting from the transport header-- the resultant checksum
+ * is in the res argument (i.e. normally zero or ~ of checksum of a pseudo
+ * header.
+ */
+static inline __sum16 gso_make_checksum(struct sk_buff *skb, __wsum res)
+{
+	unsigned char *csum_start = skb_transport_header(skb);
+	int plen = (skb->head + SKB_GSO_CB(skb)->csum_start) - csum_start;
+	__wsum partial = SKB_GSO_CB(skb)->csum;
+
+	SKB_GSO_CB(skb)->csum = res;
+	SKB_GSO_CB(skb)->csum_start = csum_start - skb->head;
+
+	return csum_fold(csum_partial(csum_start, plen, partial));
+}
+
+struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
+				  netdev_features_t features, bool tx_path);
+
+static inline struct sk_buff *skb_gso_segment(struct sk_buff *skb,
+					      netdev_features_t features)
+{
+	return __skb_gso_segment(skb, features, true);
+}
+
+struct sk_buff *skb_eth_gso_segment(struct sk_buff *skb,
+				    netdev_features_t features, __be16 type);
+
+struct sk_buff *skb_mac_gso_segment(struct sk_buff *skb,
+				    netdev_features_t features);
+
+bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu);
+
+bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len);
+
+static inline void skb_gso_error_unwind(struct sk_buff *skb, __be16 protocol,
+					int pulled_hlen, u16 mac_offset,
+					int mac_len)
+{
+	skb->protocol = protocol;
+	skb->encapsulation = 1;
+	skb_push(skb, pulled_hlen);
+	skb_reset_transport_header(skb);
+	skb->mac_header = mac_offset;
+	skb->network_header = skb->mac_header + mac_len;
+	skb->mac_len = mac_len;
+}
+
+#endif /* _NET_GSO_H */
diff --git a/include/net/udp.h b/include/net/udp.h
index de4b528522bb9..94f3486c43e33 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -21,6 +21,7 @@
 #include <linux/list.h>
 #include <linux/bug.h>
 #include <net/inet_sock.h>
+#include <net/gso.h>
 #include <net/sock.h>
 #include <net/snmp.h>
 #include <net/ip.h>
diff --git a/net/core/Makefile b/net/core/Makefile
index 8f367813bc681..731db2eaa6107 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -13,7 +13,7 @@ obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o flow_offload.o gro.o \
-			netdev-genl.o netdev-genl-gen.o
+			netdev-genl.o netdev-genl-gen.o gso.o
 
 obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 
diff --git a/net/core/dev.c b/net/core/dev.c
index c29f3e1db3ca7..44a4eb76a659e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3209,7 +3209,7 @@ static u16 skb_tx_hash(const struct net_device *dev,
 	return (u16) reciprocal_scale(skb_get_hash(skb), qcount) + qoffset;
 }
 
-static void skb_warn_bad_offload(const struct sk_buff *skb)
+void skb_warn_bad_offload(const struct sk_buff *skb)
 {
 	static const netdev_features_t null_features;
 	struct net_device *dev = skb->dev;
@@ -3338,74 +3338,6 @@ __be16 skb_network_protocol(struct sk_buff *skb, int *depth)
 	return vlan_get_protocol_and_depth(skb, type, depth);
 }
 
-/* openvswitch calls this on rx path, so we need a different check.
- */
-static inline bool skb_needs_check(struct sk_buff *skb, bool tx_path)
-{
-	if (tx_path)
-		return skb->ip_summed != CHECKSUM_PARTIAL &&
-		       skb->ip_summed != CHECKSUM_UNNECESSARY;
-
-	return skb->ip_summed == CHECKSUM_NONE;
-}
-
-/**
- *	__skb_gso_segment - Perform segmentation on skb.
- *	@skb: buffer to segment
- *	@features: features for the output path (see dev->features)
- *	@tx_path: whether it is called in TX path
- *
- *	This function segments the given skb and returns a list of segments.
- *
- *	It may return NULL if the skb requires no segmentation.  This is
- *	only possible when GSO is used for verifying header integrity.
- *
- *	Segmentation preserves SKB_GSO_CB_OFFSET bytes of previous skb cb.
- */
-struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
-				  netdev_features_t features, bool tx_path)
-{
-	struct sk_buff *segs;
-
-	if (unlikely(skb_needs_check(skb, tx_path))) {
-		int err;
-
-		/* We're going to init ->check field in TCP or UDP header */
-		err = skb_cow_head(skb, 0);
-		if (err < 0)
-			return ERR_PTR(err);
-	}
-
-	/* Only report GSO partial support if it will enable us to
-	 * support segmentation on this frame without needing additional
-	 * work.
-	 */
-	if (features & NETIF_F_GSO_PARTIAL) {
-		netdev_features_t partial_features = NETIF_F_GSO_ROBUST;
-		struct net_device *dev = skb->dev;
-
-		partial_features |= dev->features & dev->gso_partial_features;
-		if (!skb_gso_ok(skb, features | partial_features))
-			features &= ~NETIF_F_GSO_PARTIAL;
-	}
-
-	BUILD_BUG_ON(SKB_GSO_CB_OFFSET +
-		     sizeof(*SKB_GSO_CB(skb)) > sizeof(skb->cb));
-
-	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
-	SKB_GSO_CB(skb)->encap_level = 0;
-
-	skb_reset_mac_header(skb);
-	skb_reset_mac_len(skb);
-
-	segs = skb_mac_gso_segment(skb, features);
-
-	if (segs != skb && unlikely(skb_needs_check(skb, tx_path) && !IS_ERR(segs)))
-		skb_warn_bad_offload(skb);
-
-	return segs;
-}
-EXPORT_SYMBOL(__skb_gso_segment);
 
 /* Take action when hardware reception checksum errors are detected. */
 #ifdef CONFIG_BUG
diff --git a/net/core/gro.c b/net/core/gro.c
index 2d84165cb4f1d..2f1b6524bddc5 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -10,7 +10,7 @@
 #define GRO_MAX_HEAD (MAX_HEADER + 128)
 
 static DEFINE_SPINLOCK(offload_lock);
-static struct list_head offload_base __read_mostly = LIST_HEAD_INIT(offload_base);
+struct list_head offload_base __read_mostly = LIST_HEAD_INIT(offload_base);
 /* Maximum number of GRO_NORMAL skbs to batch up for list-RX */
 int gro_normal_batch __read_mostly = 8;
 
@@ -92,63 +92,6 @@ void dev_remove_offload(struct packet_offload *po)
 }
 EXPORT_SYMBOL(dev_remove_offload);
 
-/**
- *	skb_eth_gso_segment - segmentation handler for ethernet protocols.
- *	@skb: buffer to segment
- *	@features: features for the output path (see dev->features)
- *	@type: Ethernet Protocol ID
- */
-struct sk_buff *skb_eth_gso_segment(struct sk_buff *skb,
-				    netdev_features_t features, __be16 type)
-{
-	struct sk_buff *segs = ERR_PTR(-EPROTONOSUPPORT);
-	struct packet_offload *ptype;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ptype, &offload_base, list) {
-		if (ptype->type == type && ptype->callbacks.gso_segment) {
-			segs = ptype->callbacks.gso_segment(skb, features);
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return segs;
-}
-EXPORT_SYMBOL(skb_eth_gso_segment);
-
-/**
- *	skb_mac_gso_segment - mac layer segmentation handler.
- *	@skb: buffer to segment
- *	@features: features for the output path (see dev->features)
- */
-struct sk_buff *skb_mac_gso_segment(struct sk_buff *skb,
-				    netdev_features_t features)
-{
-	struct sk_buff *segs = ERR_PTR(-EPROTONOSUPPORT);
-	struct packet_offload *ptype;
-	int vlan_depth = skb->mac_len;
-	__be16 type = skb_network_protocol(skb, &vlan_depth);
-
-	if (unlikely(!type))
-		return ERR_PTR(-EINVAL);
-
-	__skb_pull(skb, vlan_depth);
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ptype, &offload_base, list) {
-		if (ptype->type == type && ptype->callbacks.gso_segment) {
-			segs = ptype->callbacks.gso_segment(skb, features);
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	__skb_push(skb, skb->data - skb_mac_header(skb));
-
-	return segs;
-}
-EXPORT_SYMBOL(skb_mac_gso_segment);
 
 int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 {
diff --git a/net/core/gso.c b/net/core/gso.c
new file mode 100644
index 0000000000000..9e1803bfc9c6c
--- /dev/null
+++ b/net/core/gso.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/skbuff.h>
+#include <linux/sctp.h>
+#include <net/gso.h>
+#include <net/gro.h>
+
+/**
+ *	skb_eth_gso_segment - segmentation handler for ethernet protocols.
+ *	@skb: buffer to segment
+ *	@features: features for the output path (see dev->features)
+ *	@type: Ethernet Protocol ID
+ */
+struct sk_buff *skb_eth_gso_segment(struct sk_buff *skb,
+				    netdev_features_t features, __be16 type)
+{
+	struct sk_buff *segs = ERR_PTR(-EPROTONOSUPPORT);
+	struct packet_offload *ptype;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ptype, &offload_base, list) {
+		if (ptype->type == type && ptype->callbacks.gso_segment) {
+			segs = ptype->callbacks.gso_segment(skb, features);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return segs;
+}
+EXPORT_SYMBOL(skb_eth_gso_segment);
+
+/**
+ *	skb_mac_gso_segment - mac layer segmentation handler.
+ *	@skb: buffer to segment
+ *	@features: features for the output path (see dev->features)
+ */
+struct sk_buff *skb_mac_gso_segment(struct sk_buff *skb,
+				    netdev_features_t features)
+{
+	struct sk_buff *segs = ERR_PTR(-EPROTONOSUPPORT);
+	struct packet_offload *ptype;
+	int vlan_depth = skb->mac_len;
+	__be16 type = skb_network_protocol(skb, &vlan_depth);
+
+	if (unlikely(!type))
+		return ERR_PTR(-EINVAL);
+
+	__skb_pull(skb, vlan_depth);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ptype, &offload_base, list) {
+		if (ptype->type == type && ptype->callbacks.gso_segment) {
+			segs = ptype->callbacks.gso_segment(skb, features);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	__skb_push(skb, skb->data - skb_mac_header(skb));
+
+	return segs;
+}
+EXPORT_SYMBOL(skb_mac_gso_segment);
+/* openvswitch calls this on rx path, so we need a different check.
+ */
+static bool skb_needs_check(const struct sk_buff *skb, bool tx_path)
+{
+	if (tx_path)
+		return skb->ip_summed != CHECKSUM_PARTIAL &&
+		       skb->ip_summed != CHECKSUM_UNNECESSARY;
+
+	return skb->ip_summed == CHECKSUM_NONE;
+}
+
+/**
+ *	__skb_gso_segment - Perform segmentation on skb.
+ *	@skb: buffer to segment
+ *	@features: features for the output path (see dev->features)
+ *	@tx_path: whether it is called in TX path
+ *
+ *	This function segments the given skb and returns a list of segments.
+ *
+ *	It may return NULL if the skb requires no segmentation.  This is
+ *	only possible when GSO is used for verifying header integrity.
+ *
+ *	Segmentation preserves SKB_GSO_CB_OFFSET bytes of previous skb cb.
+ */
+struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
+				  netdev_features_t features, bool tx_path)
+{
+	struct sk_buff *segs;
+
+	if (unlikely(skb_needs_check(skb, tx_path))) {
+		int err;
+
+		/* We're going to init ->check field in TCP or UDP header */
+		err = skb_cow_head(skb, 0);
+		if (err < 0)
+			return ERR_PTR(err);
+	}
+
+	/* Only report GSO partial support if it will enable us to
+	 * support segmentation on this frame without needing additional
+	 * work.
+	 */
+	if (features & NETIF_F_GSO_PARTIAL) {
+		netdev_features_t partial_features = NETIF_F_GSO_ROBUST;
+		struct net_device *dev = skb->dev;
+
+		partial_features |= dev->features & dev->gso_partial_features;
+		if (!skb_gso_ok(skb, features | partial_features))
+			features &= ~NETIF_F_GSO_PARTIAL;
+	}
+
+	BUILD_BUG_ON(SKB_GSO_CB_OFFSET +
+		     sizeof(*SKB_GSO_CB(skb)) > sizeof(skb->cb));
+
+	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
+	SKB_GSO_CB(skb)->encap_level = 0;
+
+	skb_reset_mac_header(skb);
+	skb_reset_mac_len(skb);
+
+	segs = skb_mac_gso_segment(skb, features);
+
+	if (segs != skb && unlikely(skb_needs_check(skb, tx_path) && !IS_ERR(segs)))
+		skb_warn_bad_offload(skb);
+
+	return segs;
+}
+EXPORT_SYMBOL(__skb_gso_segment);
+
+/**
+ * skb_gso_transport_seglen - Return length of individual segments of a gso packet
+ *
+ * @skb: GSO skb
+ *
+ * skb_gso_transport_seglen is used to determine the real size of the
+ * individual segments, including Layer4 headers (TCP/UDP).
+ *
+ * The MAC/L2 or network (IP, IPv6) headers are not accounted for.
+ */
+static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	unsigned int thlen = 0;
+
+	if (skb->encapsulation) {
+		thlen = skb_inner_transport_header(skb) -
+			skb_transport_header(skb);
+
+		if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
+			thlen += inner_tcp_hdrlen(skb);
+	} else if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
+		thlen = tcp_hdrlen(skb);
+	} else if (unlikely(skb_is_gso_sctp(skb))) {
+		thlen = sizeof(struct sctphdr);
+	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
+		thlen = sizeof(struct udphdr);
+	}
+	/* UFO sets gso_size to the size of the fragmentation
+	 * payload, i.e. the size of the L4 (UDP) header is already
+	 * accounted for.
+	 */
+	return thlen + shinfo->gso_size;
+}
+
+/**
+ * skb_gso_network_seglen - Return length of individual segments of a gso packet
+ *
+ * @skb: GSO skb
+ *
+ * skb_gso_network_seglen is used to determine the real size of the
+ * individual segments, including Layer3 (IP, IPv6) and L4 headers (TCP/UDP).
+ *
+ * The MAC/L2 header is not accounted for.
+ */
+static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
+{
+	unsigned int hdr_len = skb_transport_header(skb) -
+			       skb_network_header(skb);
+
+	return hdr_len + skb_gso_transport_seglen(skb);
+}
+
+/**
+ * skb_gso_mac_seglen - Return length of individual segments of a gso packet
+ *
+ * @skb: GSO skb
+ *
+ * skb_gso_mac_seglen is used to determine the real size of the
+ * individual segments, including MAC/L2, Layer3 (IP, IPv6) and L4
+ * headers (TCP/UDP).
+ */
+static unsigned int skb_gso_mac_seglen(const struct sk_buff *skb)
+{
+	unsigned int hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
+
+	return hdr_len + skb_gso_transport_seglen(skb);
+}
+
+/**
+ * skb_gso_size_check - check the skb size, considering GSO_BY_FRAGS
+ *
+ * There are a couple of instances where we have a GSO skb, and we
+ * want to determine what size it would be after it is segmented.
+ *
+ * We might want to check:
+ * -    L3+L4+payload size (e.g. IP forwarding)
+ * - L2+L3+L4+payload size (e.g. sanity check before passing to driver)
+ *
+ * This is a helper to do that correctly considering GSO_BY_FRAGS.
+ *
+ * @skb: GSO skb
+ *
+ * @seg_len: The segmented length (from skb_gso_*_seglen). In the
+ *           GSO_BY_FRAGS case this will be [header sizes + GSO_BY_FRAGS].
+ *
+ * @max_len: The maximum permissible length.
+ *
+ * Returns true if the segmented length <= max length.
+ */
+static inline bool skb_gso_size_check(const struct sk_buff *skb,
+				      unsigned int seg_len,
+				      unsigned int max_len) {
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+	const struct sk_buff *iter;
+
+	if (shinfo->gso_size != GSO_BY_FRAGS)
+		return seg_len <= max_len;
+
+	/* Undo this so we can re-use header sizes */
+	seg_len -= GSO_BY_FRAGS;
+
+	skb_walk_frags(skb, iter) {
+		if (seg_len + skb_headlen(iter) > max_len)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * skb_gso_validate_network_len - Will a split GSO skb fit into a given MTU?
+ *
+ * @skb: GSO skb
+ * @mtu: MTU to validate against
+ *
+ * skb_gso_validate_network_len validates if a given skb will fit a
+ * wanted MTU once split. It considers L3 headers, L4 headers, and the
+ * payload.
+ */
+bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
+{
+	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
+}
+EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
+
+/**
+ * skb_gso_validate_mac_len - Will a split GSO skb fit in a given length?
+ *
+ * @skb: GSO skb
+ * @len: length to validate against
+ *
+ * skb_gso_validate_mac_len validates if a given skb will fit a wanted
+ * length once split, including L2, L3 and L4 headers and the payload.
+ */
+bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
+{
+	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
+}
+EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
+
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1b6a1d99869dc..593ec18e3f007 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -67,6 +67,7 @@
 #include <net/dst.h>
 #include <net/sock.h>
 #include <net/checksum.h>
+#include <net/gso.h>
 #include <net/ip6_checksum.h>
 #include <net/xfrm.h>
 #include <net/mpls.h>
@@ -5789,147 +5790,6 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet)
 }
 EXPORT_SYMBOL_GPL(skb_scrub_packet);
 
-/**
- * skb_gso_transport_seglen - Return length of individual segments of a gso packet
- *
- * @skb: GSO skb
- *
- * skb_gso_transport_seglen is used to determine the real size of the
- * individual segments, including Layer4 headers (TCP/UDP).
- *
- * The MAC/L2 or network (IP, IPv6) headers are not accounted for.
- */
-static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
-{
-	const struct skb_shared_info *shinfo = skb_shinfo(skb);
-	unsigned int thlen = 0;
-
-	if (skb->encapsulation) {
-		thlen = skb_inner_transport_header(skb) -
-			skb_transport_header(skb);
-
-		if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
-			thlen += inner_tcp_hdrlen(skb);
-	} else if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
-		thlen = tcp_hdrlen(skb);
-	} else if (unlikely(skb_is_gso_sctp(skb))) {
-		thlen = sizeof(struct sctphdr);
-	} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
-		thlen = sizeof(struct udphdr);
-	}
-	/* UFO sets gso_size to the size of the fragmentation
-	 * payload, i.e. the size of the L4 (UDP) header is already
-	 * accounted for.
-	 */
-	return thlen + shinfo->gso_size;
-}
-
-/**
- * skb_gso_network_seglen - Return length of individual segments of a gso packet
- *
- * @skb: GSO skb
- *
- * skb_gso_network_seglen is used to determine the real size of the
- * individual segments, including Layer3 (IP, IPv6) and L4 headers (TCP/UDP).
- *
- * The MAC/L2 header is not accounted for.
- */
-static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
-{
-	unsigned int hdr_len = skb_transport_header(skb) -
-			       skb_network_header(skb);
-
-	return hdr_len + skb_gso_transport_seglen(skb);
-}
-
-/**
- * skb_gso_mac_seglen - Return length of individual segments of a gso packet
- *
- * @skb: GSO skb
- *
- * skb_gso_mac_seglen is used to determine the real size of the
- * individual segments, including MAC/L2, Layer3 (IP, IPv6) and L4
- * headers (TCP/UDP).
- */
-static unsigned int skb_gso_mac_seglen(const struct sk_buff *skb)
-{
-	unsigned int hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
-
-	return hdr_len + skb_gso_transport_seglen(skb);
-}
-
-/**
- * skb_gso_size_check - check the skb size, considering GSO_BY_FRAGS
- *
- * There are a couple of instances where we have a GSO skb, and we
- * want to determine what size it would be after it is segmented.
- *
- * We might want to check:
- * -    L3+L4+payload size (e.g. IP forwarding)
- * - L2+L3+L4+payload size (e.g. sanity check before passing to driver)
- *
- * This is a helper to do that correctly considering GSO_BY_FRAGS.
- *
- * @skb: GSO skb
- *
- * @seg_len: The segmented length (from skb_gso_*_seglen). In the
- *           GSO_BY_FRAGS case this will be [header sizes + GSO_BY_FRAGS].
- *
- * @max_len: The maximum permissible length.
- *
- * Returns true if the segmented length <= max length.
- */
-static inline bool skb_gso_size_check(const struct sk_buff *skb,
-				      unsigned int seg_len,
-				      unsigned int max_len) {
-	const struct skb_shared_info *shinfo = skb_shinfo(skb);
-	const struct sk_buff *iter;
-
-	if (shinfo->gso_size != GSO_BY_FRAGS)
-		return seg_len <= max_len;
-
-	/* Undo this so we can re-use header sizes */
-	seg_len -= GSO_BY_FRAGS;
-
-	skb_walk_frags(skb, iter) {
-		if (seg_len + skb_headlen(iter) > max_len)
-			return false;
-	}
-
-	return true;
-}
-
-/**
- * skb_gso_validate_network_len - Will a split GSO skb fit into a given MTU?
- *
- * @skb: GSO skb
- * @mtu: MTU to validate against
- *
- * skb_gso_validate_network_len validates if a given skb will fit a
- * wanted MTU once split. It considers L3 headers, L4 headers, and the
- * payload.
- */
-bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
-{
-	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
-}
-EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
-
-/**
- * skb_gso_validate_mac_len - Will a split GSO skb fit in a given length?
- *
- * @skb: GSO skb
- * @len: length to validate against
- *
- * skb_gso_validate_mac_len validates if a given skb will fit a wanted
- * length once split, including L2, L3 and L4 headers and the payload.
- */
-bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
-{
-	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
-}
-EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
-
 static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 {
 	int mac_len, meta_len;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 4a76ebf793b85..10ebe39dcc873 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -100,6 +100,7 @@
 #include <net/ip_fib.h>
 #include <net/inet_connection_sock.h>
 #include <net/gro.h>
+#include <net/gso.h>
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <net/udplite.h>
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index ee848be59e65a..10e96ed6c9e39 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <net/gro.h>
+#include <net/gso.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
 #include <net/esp.h>
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index 2b9cb5398335b..311e70bfce407 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -11,6 +11,7 @@
 #include <net/protocol.h>
 #include <net/gre.h>
 #include <net/gro.h>
+#include <net/gso.h>
 
 static struct sk_buff *gre_gso_segment(struct sk_buff *skb,
 				       netdev_features_t features)
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a1bead441026e..d95e40a47098a 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -73,6 +73,7 @@
 #include <net/arp.h>
 #include <net/icmp.h>
 #include <net/checksum.h>
+#include <net/gso.h>
 #include <net/inetpeer.h>
 #include <net/inet_ecn.h>
 #include <net/lwtunnel.h>
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 4851211aa60d6..9c51ee9ccd4c0 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -9,6 +9,7 @@
 #include <linux/indirect_call_wrapper.h>
 #include <linux/skbuff.h>
 #include <net/gro.h>
+#include <net/gso.h>
 #include <net/tcp.h>
 #include <net/protocol.h>
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9482def1f3103..c6b790001aa77 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -103,6 +103,7 @@
 #include <net/ip_tunnels.h>
 #include <net/route.h>
 #include <net/checksum.h>
+#include <net/gso.h>
 #include <net/xfrm.h>
 #include <trace/events/udp.h>
 #include <linux/static_key.h>
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 4a61832e7f69b..f402946da344b 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -8,6 +8,7 @@
 
 #include <linux/skbuff.h>
 #include <net/gro.h>
+#include <net/gso.h>
 #include <net/udp.h>
 #include <net/protocol.h>
 #include <net/inet_common.h>
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 7723402689973..a189e08370a5e 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <net/gro.h>
+#include <net/gso.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
 #include <net/esp.h>
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 00dc2e3b01845..d6314287338da 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -16,6 +16,7 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <net/gro.h>
+#include <net/gso.h>
 
 #include "ip6_offload.h"
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 9554cf46ed888..4a27fab1d09a3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -42,6 +42,7 @@
 #include <net/sock.h>
 #include <net/snmp.h>
 
+#include <net/gso.h>
 #include <net/ipv6.h>
 #include <net/ndisc.h>
 #include <net/protocol.h>
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index e0e10f6bcdc18..09fa7a42cb937 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -14,6 +14,7 @@
 #include <net/ip6_checksum.h>
 #include "ip6_offload.h"
 #include <net/gro.h>
+#include <net/gso.h>
 
 static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 					 netdev_features_t features)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 13b522dab0a3d..39ca4a8fe7b32 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -26,6 +26,7 @@
 #include <net/codel_impl.h>
 #include <asm/unaligned.h>
 #include <net/fq_impl.h>
+#include <net/gso.h>
 
 #include "ieee80211_i.h"
 #include "driver-ops.h"
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index dc5165d3eec4e..bf6e81d562631 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -12,6 +12,7 @@
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/percpu.h>
+#include <net/gso.h>
 #include <net/ip.h>
 #include <net/dst.h>
 #include <net/sock.h>
diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
index 1482259de9b5d..533d082f0701e 100644
--- a/net/mpls/mpls_gso.c
+++ b/net/mpls/mpls_gso.c
@@ -14,6 +14,7 @@
 #include <linux/netdev_features.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gso.h>
 #include <net/mpls.h>
 
 static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 3bbaf9c7ea46a..7eba00f6c6b6a 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -8,6 +8,7 @@
 #include <linux/ipv6.h>
 #include <linux/netdevice.h>
 #include <linux/if_ether.h>
+#include <net/gso.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/ip6_route.h>
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index e311462f6d98d..556bc902af00f 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -30,6 +30,7 @@
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <linux/list.h>
 #include <linux/cgroup-defs.h>
+#include <net/gso.h>
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <net/netfilter/nf_queue.h>
diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index 0f23e5e8e03eb..f4a38bd6a7e04 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
+#include <net/gso.h>
 #include <net/nsh.h>
 #include <net/tun_proto.h>
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index a8cf9a88758ef..8074ea00d577e 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -17,6 +17,7 @@
 #include <linux/if_vlan.h>
 
 #include <net/dst.h>
+#include <net/gso.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/ip6_fib.h>
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 58f530f60172a..a6d2a0b1aa21e 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -35,6 +35,7 @@
 #include <linux/rculist.h>
 #include <linux/dmi.h>
 #include <net/genetlink.h>
+#include <net/gso.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <net/pkt_cls.h>
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index 2e9dce03d1ecc..f3121c5a85e9f 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <net/act_api.h>
+#include <net/gso.h>
 #include <net/netlink.h>
 #include <net/pkt_cls.h>
 #include <net/tc_act/tc_police.h>
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 891e007d5c0bf..9cff99558694d 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -65,6 +65,7 @@
 #include <linux/reciprocal_div.h>
 #include <net/netlink.h>
 #include <linux/if_vlan.h>
+#include <net/gso.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
 #include <net/tcp.h>
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index b93ec2a3454eb..38d9aa0cd30e7 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -21,6 +21,7 @@
 #include <linux/reciprocal_div.h>
 #include <linux/rbtree.h>
 
+#include <net/gso.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <net/inet_ecn.h>
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 4caf80ddc6721..f681af138179c 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/time.h>
+#include <net/gso.h>
 #include <net/netlink.h>
 #include <net/pkt_sched.h>
 #include <net/pkt_cls.h>
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index 277ad11f4d613..17d2d00ddb182 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
+#include <net/gso.h>
 #include <net/netlink.h>
 #include <net/sch_generic.h>
 #include <net/pkt_cls.h>
diff --git a/net/sctp/offload.c b/net/sctp/offload.c
index eb874e3c399a5..502095173d885 100644
--- a/net/sctp/offload.c
+++ b/net/sctp/offload.c
@@ -22,6 +22,7 @@
 #include <net/sctp/sctp.h>
 #include <net/sctp/checksum.h>
 #include <net/protocol.h>
+#include <net/gso.h>
 
 static __le32 sctp_gso_make_checksum(struct sk_buff *skb)
 {
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 408f5e55744ed..533697e2488f2 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <net/dst.h>
+#include <net/gso.h>
 #include <net/xfrm.h>
 #include <linux/notifier.h>
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 35279c220bd78..a3319965470a7 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -33,6 +33,7 @@
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
 
+#include <net/gso.h>
 #include <net/icmp.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 369e5de8558ff..662c83beb345e 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <net/dst.h>
+#include <net/gso.h>
 #include <net/icmp.h>
 #include <net/inet_ecn.h>
 #include <net/xfrm.h>
-- 
2.40.1



