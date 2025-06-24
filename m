Return-Path: <stable+bounces-158184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD038AE5753
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECA67B436D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75B22422F;
	Mon, 23 Jun 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xYIhC9rG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0BB676;
	Mon, 23 Jun 2025 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717691; cv=none; b=pTtsy6OS9fAj1t2ChIgr7K1iZrUs14yvEMcMwOfkdk6Dz5EOmwzX7b5+GK6mXAGK8hBkhVvPM0ztf6kJ4zpptOutT0t2CLSNZK8qAVasGQhYnCtsUD1MrFr14jeKSLoTvqPa7GDUW22fJHiWEbV/RQbqmSZmx5+O0t7lg72OgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717691; c=relaxed/simple;
	bh=4+I3ShXQK9YscLK7V8NIBMhelfYziqO6n5QC6KfwlqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjLxJNxtPi/qWLvlkc4gSC1J8+VZEtDTIBUvDz6j1UHuhkPRy/NsJbwY6ok3SZT4eX9UtzQG3+Ct8mgZ6O01XjH0oVvByESEB5CGsfgAC7ZqGQiPsueF9t9XX1WnilN8Nlp1KZoeWx7+LI0k5ADNLj/4ukAn5pqGs6EbP0Pq7MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xYIhC9rG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7736AC4CEEA;
	Mon, 23 Jun 2025 22:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717690;
	bh=4+I3ShXQK9YscLK7V8NIBMhelfYziqO6n5QC6KfwlqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xYIhC9rGfLNPGVPnpKknYGrzw0Wovj5+3cnzEv47JBSq/uq+zQ3ITtNyge6h6Q0Uv
	 6apJNllCYdHNkaoUwoWdQRAxYOP+O4TYfX2Nk+2zDkkd2q5C/w6DhxVfn+d3jo8Csj
	 rNrD213RamJQLIDjLfa2XGVLId78oZIoXIhSNObQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krishna Kumar <krikku@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH 6.1 478/508] net: ice: Perform accurate aRFS flow match
Date: Mon, 23 Jun 2025 15:08:43 +0200
Message-ID: <20250623130656.836790414@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krishna Kumar <krikku@gmail.com>

[ Upstream commit 5d3bc9e5e725aa36cca9b794e340057feb6880b4 ]

This patch fixes an issue seen in a large-scale deployment under heavy
incoming pkts where the aRFS flow wrongly matches a flow and reprograms the
NIC with wrong settings. That mis-steering causes RX-path latency spikes
and noisy neighbor effects when many connections collide on the same
hash (some of our production servers have 20-30K connections).

set_rps_cpu() calls ndo_rx_flow_steer() with flow_id that is calculated by
hashing the skb sized by the per rx-queue table size. This results in
multiple connections (even across different rx-queues) getting the same
hash value. The driver steer function modifies the wrong flow to use this
rx-queue, e.g.: Flow#1 is first added:
    Flow#1:  <ip1, port1, ip2, port2>, Hash 'h', q#10

Later when a new flow needs to be added:
	    Flow#2:  <ip3, port3, ip4, port4>, Hash 'h', q#20

The driver finds the hash 'h' from Flow#1 and updates it to use q#20. This
results in both flows getting un-optimized - packets for Flow#1 goes to
q#20, and then reprogrammed back to q#10 later and so on; and Flow #2
programming is never done as Flow#1 is matched first for all misses. Many
flows may wrongly share the same hash and reprogram rules of the original
flow each with their own q#.

Tested on two 144-core servers with 16K netperf sessions for 180s. Netperf
clients are pinned to cores 0-71 sequentially (so that wrong packets on q#s
72-143 can be measured). IRQs are set 1:1 for queues -> CPUs, enable XPS,
enable aRFS (global value is 144 * rps_flow_cnt).

Test notes about results from ice_rx_flow_steer():
---------------------------------------------------
1. "Skip:" counter increments here:
    if (fltr_info->q_index == rxq_idx ||
	arfs_entry->fltr_state != ICE_ARFS_ACTIVE)
	    goto out;
2. "Add:" counter increments here:
    ret = arfs_entry->fltr_info.fltr_id;
    INIT_HLIST_NODE(&arfs_entry->list_entry);
3. "Update:" counter increments here:
    /* update the queue to forward to on an already existing flow */

Runtime comparison: original code vs with the patch for different
rps_flow_cnt values.

+-------------------------------+--------------+--------------+
| rps_flow_cnt                  |      512     |    2048      |
+-------------------------------+--------------+--------------+
| Ratio of Pkts on Good:Bad q's | 214 vs 822K  | 1.1M vs 980K |
| Avoid wrong aRFS programming  | 0 vs 310K    | 0 vs 30K     |
| CPU User                      | 216 vs 183   | 216 vs 206   |
| CPU System                    | 1441 vs 1171 | 1447 vs 1320 |
| CPU Softirq                   | 1245 vs 920  | 1238 vs 961  |
| CPU Total                     | 29 vs 22.7   | 29 vs 24.9   |
| aRFS Update                   | 533K vs 59   | 521K vs 32   |
| aRFS Skip                     | 82M vs 77M   | 7.2M vs 4.5M |
+-------------------------------+--------------+--------------+

A separate TCP_STREAM and TCP_RR with 1,4,8,16,64,128,256,512 connections
showed no performance degradation.

Some points on the patch/aRFS behavior:
1. Enabling full tuple matching ensures flows are always correctly matched,
   even with smaller hash sizes.
2. 5-6% drop in CPU utilization as the packets arrive at the correct CPUs
   and fewer calls to driver for programming on misses.
3. Larger hash tables reduces mis-steering due to more unique flow hashes,
   but still has clashes. However, with larger per-device rps_flow_cnt, old
   flows take more time to expire and new aRFS flows cannot be added if h/w
   limits are reached (rps_may_expire_flow() succeeds when 10*rps_flow_cnt
   pkts have been processed by this cpu that are not part of the flow).

Fixes: 28bf26724fdb0 ("ice: Implement aRFS")
Signed-off-by: Krishna Kumar <krikku@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_arfs.c | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 79074f041e39b..e3114c12e1293 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -376,6 +376,50 @@ ice_arfs_is_perfect_flow_set(struct ice_hw *hw, __be16 l3_proto, u8 l4_proto)
 	return false;
 }
 
+/**
+ * ice_arfs_cmp - Check if aRFS filter matches this flow.
+ * @fltr_info: filter info of the saved ARFS entry.
+ * @fk: flow dissector keys.
+ * @n_proto:  One of htons(ETH_P_IP) or htons(ETH_P_IPV6).
+ * @ip_proto: One of IPPROTO_TCP or IPPROTO_UDP.
+ *
+ * Since this function assumes limited values for n_proto and ip_proto, it
+ * is meant to be called only from ice_rx_flow_steer().
+ *
+ * Return:
+ * * true	- fltr_info refers to the same flow as fk.
+ * * false	- fltr_info and fk refer to different flows.
+ */
+static bool
+ice_arfs_cmp(const struct ice_fdir_fltr *fltr_info, const struct flow_keys *fk,
+	     __be16 n_proto, u8 ip_proto)
+{
+	/* Determine if the filter is for IPv4 or IPv6 based on flow_type,
+	 * which is one of ICE_FLTR_PTYPE_NONF_IPV{4,6}_{TCP,UDP}.
+	 */
+	bool is_v4 = fltr_info->flow_type == ICE_FLTR_PTYPE_NONF_IPV4_TCP ||
+		     fltr_info->flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP;
+
+	/* Following checks are arranged in the quickest and most discriminative
+	 * fields first for early failure.
+	 */
+	if (is_v4)
+		return n_proto == htons(ETH_P_IP) &&
+			fltr_info->ip.v4.src_port == fk->ports.src &&
+			fltr_info->ip.v4.dst_port == fk->ports.dst &&
+			fltr_info->ip.v4.src_ip == fk->addrs.v4addrs.src &&
+			fltr_info->ip.v4.dst_ip == fk->addrs.v4addrs.dst &&
+			fltr_info->ip.v4.proto == ip_proto;
+
+	return fltr_info->ip.v6.src_port == fk->ports.src &&
+		fltr_info->ip.v6.dst_port == fk->ports.dst &&
+		fltr_info->ip.v6.proto == ip_proto &&
+		!memcmp(&fltr_info->ip.v6.src_ip, &fk->addrs.v6addrs.src,
+			sizeof(struct in6_addr)) &&
+		!memcmp(&fltr_info->ip.v6.dst_ip, &fk->addrs.v6addrs.dst,
+			sizeof(struct in6_addr));
+}
+
 /**
  * ice_rx_flow_steer - steer the Rx flow to where application is being run
  * @netdev: ptr to the netdev being adjusted
@@ -447,6 +491,10 @@ ice_rx_flow_steer(struct net_device *netdev, const struct sk_buff *skb,
 			continue;
 
 		fltr_info = &arfs_entry->fltr_info;
+
+		if (!ice_arfs_cmp(fltr_info, &fk, n_proto, ip_proto))
+			continue;
+
 		ret = fltr_info->fltr_id;
 
 		if (fltr_info->q_index == rxq_idx ||
-- 
2.39.5




