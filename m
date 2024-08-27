Return-Path: <stable+bounces-71213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F089961255
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADEE282134
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8C1CE6FA;
	Tue, 27 Aug 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ByW+0bGH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296411C8FCF;
	Tue, 27 Aug 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772469; cv=none; b=XDfIEkgMnM7S8OY1gCKziSMB5Ud/Y3I9K/7+uYk44TKXbpwNfG5nRhnTWSIzy8NyhXQTTvmUCi5yeDKMDiy9wpuM6wEd/TSK7qI59Tz04heYakhYhMCQJgu4fqUREzy99GB6IpEBzsoPs6PJ8+uqJfIBaDpP4irjs3uZ6UQ/2/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772469; c=relaxed/simple;
	bh=emFkVz/LBvnWjCmDmiqpdIBXOn6CfnjChbm/hfagIco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljS4mW4e42vR9ezJkvDkTTgY7ksx54nBf8CqGB/d+jC/SAM4VpPJQGzC02BZqJxCS486I/tdXMZOczCDRzfz/X/Y//VhZVXQcNWgBpn3Ahj8ibsa/tfeEuGjqLWyD9mpqdx6ks758yWaORcHyM+ojYuAkEwsA0xU+wOhs9L0Q3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ByW+0bGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F369C61040;
	Tue, 27 Aug 2024 15:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772469;
	bh=emFkVz/LBvnWjCmDmiqpdIBXOn6CfnjChbm/hfagIco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ByW+0bGHi6mtlmA/Og94kbVXuiEhX1LtHT5OfNYMWcor/7ljHDJf6WTZ2Di1TLQig
	 uv+4DmdIna1UeKosaeJt8hqY9gTWApOgoX8QsrruoD5tjsjAEfLlYZslY5VfbiHYz9
	 cd7sJ6//EEyy1erOPwPuBmAlIJMVQsAAHOvO4Nzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 224/321] net: mscc: ocelot: use ocelot_xmit_get_vlan_info() also for FDMA and register injection
Date: Tue, 27 Aug 2024 16:38:52 +0200
Message-ID: <20240827143846.758647120@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 67c3ca2c5cfe6a50772514e3349b5e7b3b0fac03 ]

Problem description
-------------------

On an NXP LS1028A (felix DSA driver) with the following configuration:

- ocelot-8021q tagging protocol
- VLAN-aware bridge (with STP) spanning at least swp0 and swp1
- 8021q VLAN upper interfaces on swp0 and swp1: swp0.700, swp1.700
- ptp4l on swp0.700 and swp1.700

we see that the ptp4l instances do not see each other's traffic,
and they all go to the grand master state due to the
ANNOUNCE_RECEIPT_TIMEOUT_EXPIRES condition.

Jumping to the conclusion for the impatient
-------------------------------------------

There is a zero-day bug in the ocelot switchdev driver in the way it
handles VLAN-tagged packet injection. The correct logic already exists in
the source code, in function ocelot_xmit_get_vlan_info() added by commit
5ca721c54d86 ("net: dsa: tag_ocelot: set the classified VLAN during xmit").
But it is used only for normal NPI-based injection with the DSA "ocelot"
tagging protocol. The other injection code paths (register-based and
FDMA-based) roll their own wrong logic. This affects and was noticed on
the DSA "ocelot-8021q" protocol because it uses register-based injection.

By moving ocelot_xmit_get_vlan_info() to a place that's common for both
the DSA tagger and the ocelot switch library, it can also be called from
ocelot_port_inject_frame() in ocelot.c.

We need to touch the lines with ocelot_ifh_port_set()'s prototype
anyway, so let's rename it to something clearer regarding what it does,
and add a kernel-doc. ocelot_ifh_set_basic() should do.

Investigation notes
-------------------

Debugging reveals that PTP event (aka those carrying timestamps, like
Sync) frames injected into swp0.700 (but also swp1.700) hit the wire
with two VLAN tags:

00000000: 01 1b 19 00 00 00 00 01 02 03 04 05 81 00 02 bc
                                              ~~~~~~~~~~~
00000010: 81 00 02 bc 88 f7 00 12 00 2c 00 00 02 00 00 00
          ~~~~~~~~~~~
00000020: 00 00 00 00 00 00 00 00 00 00 00 01 02 ff fe 03
00000030: 04 05 00 01 00 04 00 00 00 00 00 00 00 00 00 00
00000040: 00 00

The second (unexpected) VLAN tag makes felix_check_xtr_pkt() ->
ptp_classify_raw() fail to see these as PTP packets at the link
partner's receiving end, and return PTP_CLASS_NONE (because the BPF
classifier is not written to expect 2 VLAN tags).

The reason why packets have 2 VLAN tags is because the transmission
code treats VLAN incorrectly.

Neither ocelot switchdev, nor felix DSA, declare the NETIF_F_HW_VLAN_CTAG_TX
feature. Therefore, at xmit time, all VLANs should be in the skb head,
and none should be in the hwaccel area. This is done by:

static struct sk_buff *validate_xmit_vlan(struct sk_buff *skb,
					  netdev_features_t features)
{
	if (skb_vlan_tag_present(skb) &&
	    !vlan_hw_offload_capable(features, skb->vlan_proto))
		skb = __vlan_hwaccel_push_inside(skb);
	return skb;
}

But ocelot_port_inject_frame() handles things incorrectly:

	ocelot_ifh_port_set(ifh, port, rew_op, skb_vlan_tag_get(skb));

void ocelot_ifh_port_set(struct sk_buff *skb, void *ifh, int port, u32 rew_op)
{
	(...)
	if (vlan_tag)
		ocelot_ifh_set_vlan_tci(ifh, vlan_tag);
	(...)
}

The way __vlan_hwaccel_push_inside() pushes the tag inside the skb head
is by calling:

static inline void __vlan_hwaccel_clear_tag(struct sk_buff *skb)
{
	skb->vlan_present = 0;
}

which does _not_ zero out skb->vlan_tci as seen by skb_vlan_tag_get().
This means that ocelot, when it calls skb_vlan_tag_get(), sees
(and uses) a residual skb->vlan_tci, while the same VLAN tag is
_already_ in the skb head.

The trivial fix for double VLAN headers is to replace the content of
ocelot_ifh_port_set() with:

	if (skb_vlan_tag_present(skb))
		ocelot_ifh_set_vlan_tci(ifh, skb_vlan_tag_get(skb));

but this would not be correct either, because, as mentioned,
vlan_hw_offload_capable() is false for us, so we'd be inserting dead
code and we'd always transmit packets with VID=0 in the injection frame
header.

I can't actually test the ocelot switchdev driver and rely exclusively
on code inspection, but I don't think traffic from 8021q uppers has ever
been injected properly, and not double-tagged. Thus I'm blaming the
introduction of VLAN fields in the injection header - early driver code.

As hinted at in the early conclusion, what we _want_ to happen for
VLAN transmission was already described once in commit 5ca721c54d86
("net: dsa: tag_ocelot: set the classified VLAN during xmit").

ocelot_xmit_get_vlan_info() intends to ensure that if the port through
which we're transmitting is under a VLAN-aware bridge, the outer VLAN
tag from the skb head is stripped from there and inserted into the
injection frame header (so that the packet is processed in hardware
through that actual VLAN). And in all other cases, the packet is sent
with VID=0 in the injection frame header, since the port is VLAN-unaware
and has logic to strip this VID on egress (making it invisible to the
wire).

Fixes: 08d02364b12f ("net: mscc: fix the injection header")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot.c      | 29 +++++++++++----
 drivers/net/ethernet/mscc/ocelot_fdma.c |  2 +-
 include/linux/dsa/ocelot.h              | 47 +++++++++++++++++++++++++
 include/soc/mscc/ocelot.h               |  3 +-
 net/dsa/tag_ocelot.c                    | 37 ++-----------------
 5 files changed, 75 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 01b6e13f4692f..b594f3054afb6 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1088,17 +1088,34 @@ bool ocelot_can_inject(struct ocelot *ocelot, int grp)
 }
 EXPORT_SYMBOL(ocelot_can_inject);
 
-void ocelot_ifh_port_set(void *ifh, int port, u32 rew_op, u32 vlan_tag)
+/**
+ * ocelot_ifh_set_basic - Set basic information in Injection Frame Header
+ * @ifh: Pointer to Injection Frame Header memory
+ * @ocelot: Switch private data structure
+ * @port: Egress port number
+ * @rew_op: Egress rewriter operation for PTP
+ * @skb: Pointer to socket buffer (packet)
+ *
+ * Populate the Injection Frame Header with basic information for this skb: the
+ * analyzer bypass bit, destination port, VLAN info, egress rewriter info.
+ */
+void ocelot_ifh_set_basic(void *ifh, struct ocelot *ocelot, int port,
+			  u32 rew_op, struct sk_buff *skb)
 {
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	u64 vlan_tci, tag_type;
+
+	ocelot_xmit_get_vlan_info(skb, ocelot_port->bridge, &vlan_tci,
+				  &tag_type);
+
 	ocelot_ifh_set_bypass(ifh, 1);
 	ocelot_ifh_set_dest(ifh, BIT_ULL(port));
-	ocelot_ifh_set_tag_type(ifh, IFH_TAG_TYPE_C);
-	if (vlan_tag)
-		ocelot_ifh_set_vlan_tci(ifh, vlan_tag);
+	ocelot_ifh_set_tag_type(ifh, tag_type);
+	ocelot_ifh_set_vlan_tci(ifh, vlan_tci);
 	if (rew_op)
 		ocelot_ifh_set_rew_op(ifh, rew_op);
 }
-EXPORT_SYMBOL(ocelot_ifh_port_set);
+EXPORT_SYMBOL(ocelot_ifh_set_basic);
 
 void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 			      u32 rew_op, struct sk_buff *skb)
@@ -1109,7 +1126,7 @@ void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 	ocelot_write_rix(ocelot, QS_INJ_CTRL_GAP_SIZE(1) |
 			 QS_INJ_CTRL_SOF, QS_INJ_CTRL, grp);
 
-	ocelot_ifh_port_set(ifh, port, rew_op, skb_vlan_tag_get(skb));
+	ocelot_ifh_set_basic(ifh, ocelot, port, rew_op, skb);
 
 	for (i = 0; i < OCELOT_TAG_LEN / 4; i++)
 		ocelot_write_rix(ocelot, ifh[i], QS_INJ_WR, grp);
diff --git a/drivers/net/ethernet/mscc/ocelot_fdma.c b/drivers/net/ethernet/mscc/ocelot_fdma.c
index 8e3894cf5f7cd..e9d2e96adb229 100644
--- a/drivers/net/ethernet/mscc/ocelot_fdma.c
+++ b/drivers/net/ethernet/mscc/ocelot_fdma.c
@@ -666,7 +666,7 @@ static int ocelot_fdma_prepare_skb(struct ocelot *ocelot, int port, u32 rew_op,
 	ifh = skb_push(skb, OCELOT_TAG_LEN);
 	skb_put(skb, ETH_FCS_LEN);
 	memset(ifh, 0, OCELOT_TAG_LEN);
-	ocelot_ifh_port_set(ifh, port, rew_op, skb_vlan_tag_get(skb));
+	ocelot_ifh_set_basic(ifh, ocelot, port, rew_op, skb);
 
 	return 0;
 }
diff --git a/include/linux/dsa/ocelot.h b/include/linux/dsa/ocelot.h
index dca2969015d80..6fbfbde68a37c 100644
--- a/include/linux/dsa/ocelot.h
+++ b/include/linux/dsa/ocelot.h
@@ -5,6 +5,8 @@
 #ifndef _NET_DSA_TAG_OCELOT_H
 #define _NET_DSA_TAG_OCELOT_H
 
+#include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/kthread.h>
 #include <linux/packing.h>
 #include <linux/skbuff.h>
@@ -273,4 +275,49 @@ static inline u32 ocelot_ptp_rew_op(struct sk_buff *skb)
 	return rew_op;
 }
 
+/**
+ * ocelot_xmit_get_vlan_info: Determine VLAN_TCI and TAG_TYPE for injected frame
+ * @skb: Pointer to socket buffer
+ * @br: Pointer to bridge device that the port is under, if any
+ * @vlan_tci:
+ * @tag_type:
+ *
+ * If the port is under a VLAN-aware bridge, remove the VLAN header from the
+ * payload and move it into the DSA tag, which will make the switch classify
+ * the packet to the bridge VLAN. Otherwise, leave the classified VLAN at zero,
+ * which is the pvid of standalone ports (OCELOT_STANDALONE_PVID), although not
+ * of VLAN-unaware bridge ports (that would be ocelot_vlan_unaware_pvid()).
+ * Anyway, VID 0 is fine because it is stripped on egress for these port modes,
+ * and source address learning is not performed for packets injected from the
+ * CPU anyway, so it doesn't matter that the VID is "wrong".
+ */
+static inline void ocelot_xmit_get_vlan_info(struct sk_buff *skb,
+					     struct net_device *br,
+					     u64 *vlan_tci, u64 *tag_type)
+{
+	struct vlan_ethhdr *hdr;
+	u16 proto, tci;
+
+	if (!br || !br_vlan_enabled(br)) {
+		*vlan_tci = 0;
+		*tag_type = IFH_TAG_TYPE_C;
+		return;
+	}
+
+	hdr = (struct vlan_ethhdr *)skb_mac_header(skb);
+	br_vlan_get_proto(br, &proto);
+
+	if (ntohs(hdr->h_vlan_proto) == proto) {
+		vlan_remove_tag(skb, &tci);
+		*vlan_tci = tci;
+	} else {
+		rcu_read_lock();
+		br_vlan_get_pvid_rcu(br, &tci);
+		rcu_read_unlock();
+		*vlan_tci = tci;
+	}
+
+	*tag_type = (proto != ETH_P_8021Q) ? IFH_TAG_TYPE_S : IFH_TAG_TYPE_C;
+}
+
 #endif
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 195ca8f0b6f9d..9b904ea2f0db9 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -1128,7 +1128,8 @@ void __ocelot_target_write_ix(struct ocelot *ocelot, enum ocelot_target target,
 bool ocelot_can_inject(struct ocelot *ocelot, int grp);
 void ocelot_port_inject_frame(struct ocelot *ocelot, int port, int grp,
 			      u32 rew_op, struct sk_buff *skb);
-void ocelot_ifh_port_set(void *ifh, int port, u32 rew_op, u32 vlan_tag);
+void ocelot_ifh_set_basic(void *ifh, struct ocelot *ocelot, int port,
+			  u32 rew_op, struct sk_buff *skb);
 int ocelot_xtr_poll_frame(struct ocelot *ocelot, int grp, struct sk_buff **skb);
 void ocelot_drain_cpu_queue(struct ocelot *ocelot, int grp);
 void ocelot_ptp_rx_timestamp(struct ocelot *ocelot, struct sk_buff *skb,
diff --git a/net/dsa/tag_ocelot.c b/net/dsa/tag_ocelot.c
index 18dda9423fae5..ce9d2b20d67a9 100644
--- a/net/dsa/tag_ocelot.c
+++ b/net/dsa/tag_ocelot.c
@@ -4,40 +4,6 @@
 #include <linux/dsa/ocelot.h>
 #include "dsa_priv.h"
 
-/* If the port is under a VLAN-aware bridge, remove the VLAN header from the
- * payload and move it into the DSA tag, which will make the switch classify
- * the packet to the bridge VLAN. Otherwise, leave the classified VLAN at zero,
- * which is the pvid of standalone and VLAN-unaware bridge ports.
- */
-static void ocelot_xmit_get_vlan_info(struct sk_buff *skb, struct dsa_port *dp,
-				      u64 *vlan_tci, u64 *tag_type)
-{
-	struct net_device *br = dsa_port_bridge_dev_get(dp);
-	struct vlan_ethhdr *hdr;
-	u16 proto, tci;
-
-	if (!br || !br_vlan_enabled(br)) {
-		*vlan_tci = 0;
-		*tag_type = IFH_TAG_TYPE_C;
-		return;
-	}
-
-	hdr = skb_vlan_eth_hdr(skb);
-	br_vlan_get_proto(br, &proto);
-
-	if (ntohs(hdr->h_vlan_proto) == proto) {
-		vlan_remove_tag(skb, &tci);
-		*vlan_tci = tci;
-	} else {
-		rcu_read_lock();
-		br_vlan_get_pvid_rcu(br, &tci);
-		rcu_read_unlock();
-		*vlan_tci = tci;
-	}
-
-	*tag_type = (proto != ETH_P_8021Q) ? IFH_TAG_TYPE_S : IFH_TAG_TYPE_C;
-}
-
 static void ocelot_xmit_common(struct sk_buff *skb, struct net_device *netdev,
 			       __be32 ifh_prefix, void **ifh)
 {
@@ -49,7 +15,8 @@ static void ocelot_xmit_common(struct sk_buff *skb, struct net_device *netdev,
 	u32 rew_op = 0;
 	u64 qos_class;
 
-	ocelot_xmit_get_vlan_info(skb, dp, &vlan_tci, &tag_type);
+	ocelot_xmit_get_vlan_info(skb, dsa_port_bridge_dev_get(dp), &vlan_tci,
+				  &tag_type);
 
 	qos_class = netdev_get_num_tc(netdev) ?
 		    netdev_get_prio_tc_map(netdev, skb->priority) : skb->priority;
-- 
2.43.0




