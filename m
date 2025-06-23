Return-Path: <stable+bounces-156754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD66CAE50F9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECCF440FD6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F9B1EFFA6;
	Mon, 23 Jun 2025 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eC5Vl19a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EFC1E5B71;
	Mon, 23 Jun 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714184; cv=none; b=P4O1e4+EctB+ZSAjRDtUwq0g9335ZXBNLW5CWt/xd45Scy9lc8R8V16wiHsXrcyyR0dF7pT0rJKKMKlqK99Ef2KmGqvLUTgL1pWWUe+hzX26XpAGE88FeBL+TmbGAwDsSg4GrDr1YwEVgn9AifOweYEx0UUD4vjE8iPkfQZHEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714184; c=relaxed/simple;
	bh=+KsC+fodKXrhETN2bVy6xlHrSgtXza0XY2sDubTjKPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeTSIqQhdu52lIM/nlIJsPTgR76LsK7RKUtXZ4X0JM463+lt+qCheZeyqqVhC+7vPDFid/zU59x1aOUFfpS59wVkv+H9zRh8WuYiOEftX++lRnvxsuYrCVHeNprBCYRcjLY9wLm9s+CNqhsJstmute/4GriwwURRlJzGFOHBw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eC5Vl19a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8C5C4CEEA;
	Mon, 23 Jun 2025 21:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714184;
	bh=+KsC+fodKXrhETN2bVy6xlHrSgtXza0XY2sDubTjKPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eC5Vl19a/uOC0pIpikw3it9mQy5o5o/rE1dAdeI44eWH6wybNKqXss1pKZ/nOITkd
	 pwvnkgUCXRlIeHDHuoSA0SVl39ODavP3Vrhqay+a4pNQorTsgXV3vbF5O0Woei3ZRV
	 wybOcWPGwOSzkhiqcBgst6jbHppZ6zIAeiYN7B90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Saritha Sanigani <sarithax.sanigani@intel.com>
Subject: [PATCH 6.1 177/508] ice: fix rebuilding the Tx scheduler tree for large queue counts
Date: Mon, 23 Jun 2025 15:03:42 +0200
Message-ID: <20250623130649.628898280@linuxfoundation.org>
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

From: Michal Kubiak <michal.kubiak@intel.com>

[ Upstream commit 73145e6d81070d34a21431c9e0d7aaf2f29ca048 ]

The current implementation of the Tx scheduler allows the tree to be
rebuilt as the user adds more Tx queues to the VSI. In such a case,
additional child nodes are added to the tree to support the new number
of queues.
Unfortunately, this algorithm does not take into account that the limit
of the VSI support node may be exceeded, so an additional node in the
VSI layer may be required to handle all the requested queues.

Such a scenario occurs when adding XDP Tx queues on machines with many
CPUs. Although the driver still respects the queue limit returned by
the FW, the Tx scheduler was unable to add those queues to its tree
and returned one of the errors below.

Such a scenario occurs when adding XDP Tx queues on machines with many
CPUs (e.g. at least 321 CPUs, if there is already 128 Tx/Rx queue pairs).
Although the driver still respects the queue limit returned by the FW,
the Tx scheduler was unable to add those queues to its tree and returned
the following errors:

     Failed VSI LAN queue config for XDP, error: -5
or:
     Failed to set LAN Tx queue context, error: -22

Fix this problem by extending the tree rebuild algorithm to check if the
current VSI node can support the requested number of queues. If it
cannot, create as many additional VSI support nodes as necessary to
handle all the required Tx queues. Symmetrically, adjust the VSI node
removal algorithm to remove all nodes associated with the given VSI.
Also, make the search for the next free VSI node more restrictive. That is,
add queue group nodes only to the VSI support nodes that have a matching
VSI handle.
Finally, fix the comment describing the tree update algorithm to better
reflect the current scenario.

Fixes: b0153fdd7e8a ("ice: update VSI config dynamically")
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Tested-by: Saritha Sanigani <sarithax.sanigani@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 170 +++++++++++++++++----
 1 file changed, 142 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 3baa9d161a0bf..f8f2f657bf9b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -84,6 +84,27 @@ ice_sched_find_node_by_teid(struct ice_sched_node *start_node, u32 teid)
 	return NULL;
 }
 
+/**
+ * ice_sched_find_next_vsi_node - find the next node for a given VSI
+ * @vsi_node: VSI support node to start search with
+ *
+ * Return: Next VSI support node, or NULL.
+ *
+ * The function returns a pointer to the next node from the VSI layer
+ * assigned to the given VSI, or NULL if there is no such a node.
+ */
+static struct ice_sched_node *
+ice_sched_find_next_vsi_node(struct ice_sched_node *vsi_node)
+{
+	unsigned int vsi_handle = vsi_node->vsi_handle;
+
+	while ((vsi_node = vsi_node->sibling) != NULL)
+		if (vsi_node->vsi_handle == vsi_handle)
+			break;
+
+	return vsi_node;
+}
+
 /**
  * ice_aqc_send_sched_elem_cmd - send scheduling elements cmd
  * @hw: pointer to the HW struct
@@ -1073,8 +1094,10 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 		if (parent->num_children < max_child_nodes) {
 			new_num_nodes = max_child_nodes - parent->num_children;
 		} else {
-			/* This parent is full, try the next sibling */
-			parent = parent->sibling;
+			/* This parent is full,
+			 * try the next available sibling.
+			 */
+			parent = ice_sched_find_next_vsi_node(parent);
 			/* Don't modify the first node TEID memory if the
 			 * first node was added already in the above call.
 			 * Instead send some temp memory for all other
@@ -1515,12 +1538,23 @@ ice_sched_get_free_qparent(struct ice_port_info *pi, u16 vsi_handle, u8 tc,
 	/* get the first queue group node from VSI sub-tree */
 	qgrp_node = ice_sched_get_first_node(pi, vsi_node, qgrp_layer);
 	while (qgrp_node) {
+		struct ice_sched_node *next_vsi_node;
+
 		/* make sure the qgroup node is part of the VSI subtree */
 		if (ice_sched_find_node_in_subtree(pi->hw, vsi_node, qgrp_node))
 			if (qgrp_node->num_children < max_children &&
 			    qgrp_node->owner == owner)
 				break;
 		qgrp_node = qgrp_node->sibling;
+		if (qgrp_node)
+			continue;
+
+		next_vsi_node = ice_sched_find_next_vsi_node(vsi_node);
+		if (!next_vsi_node)
+			break;
+
+		vsi_node = next_vsi_node;
+		qgrp_node = ice_sched_get_first_node(pi, vsi_node, qgrp_layer);
 	}
 
 	/* Select the best queue group */
@@ -1764,7 +1798,11 @@ ice_sched_add_vsi_support_nodes(struct ice_port_info *pi, u16 vsi_handle,
 		if (!parent)
 			return -EIO;
 
-		if (i == vsil)
+		/* Do not modify the VSI handle for already existing VSI nodes,
+		 * (if no new VSI node was added to the tree).
+		 * Assign the VSI handle only to newly added VSI nodes.
+		 */
+		if (i == vsil && num_added)
 			parent->vsi_handle = vsi_handle;
 	}
 
@@ -1797,6 +1835,41 @@ ice_sched_add_vsi_to_topo(struct ice_port_info *pi, u16 vsi_handle, u8 tc)
 					       num_nodes);
 }
 
+/**
+ * ice_sched_recalc_vsi_support_nodes - recalculate VSI support nodes count
+ * @hw: pointer to the HW struct
+ * @vsi_node: pointer to the leftmost VSI node that needs to be extended
+ * @new_numqs: new number of queues that has to be handled by the VSI
+ * @new_num_nodes: pointer to nodes count table to modify the VSI layer entry
+ *
+ * This function recalculates the number of supported nodes that need to
+ * be added after adding more Tx queues for a given VSI.
+ * The number of new VSI support nodes that shall be added will be saved
+ * to the @new_num_nodes table for the VSI layer.
+ */
+static void
+ice_sched_recalc_vsi_support_nodes(struct ice_hw *hw,
+				   struct ice_sched_node *vsi_node,
+				   unsigned int new_numqs, u16 *new_num_nodes)
+{
+	u32 vsi_nodes_cnt = 1;
+	u32 max_queue_cnt = 1;
+	u32 qgl, vsil;
+
+	qgl = ice_sched_get_qgrp_layer(hw);
+	vsil = ice_sched_get_vsi_layer(hw);
+
+	for (u32 i = vsil; i <= qgl; i++)
+		max_queue_cnt *= hw->max_children[i];
+
+	while ((vsi_node = ice_sched_find_next_vsi_node(vsi_node)) != NULL)
+		vsi_nodes_cnt++;
+
+	if (new_numqs > (max_queue_cnt * vsi_nodes_cnt))
+		new_num_nodes[vsil] = DIV_ROUND_UP(new_numqs, max_queue_cnt) -
+				      vsi_nodes_cnt;
+}
+
 /**
  * ice_sched_update_vsi_child_nodes - update VSI child nodes
  * @pi: port information structure
@@ -1848,16 +1921,25 @@ ice_sched_update_vsi_child_nodes(struct ice_port_info *pi, u16 vsi_handle,
 			return status;
 	}
 
+	ice_sched_recalc_vsi_support_nodes(hw, vsi_node,
+					   new_numqs, new_num_nodes);
 	ice_sched_calc_vsi_child_nodes(hw, new_numqs - prev_numqs,
 				       new_num_nodes);
 
-	/* Keep the max number of queue configuration all the time. Update the
-	 * tree only if number of queues > previous number of queues. This may
+	/* Never decrease the number of queues in the tree. Update the tree
+	 * only if number of queues > previous number of queues. This may
 	 * leave some extra nodes in the tree if number of queues < previous
 	 * number but that wouldn't harm anything. Removing those extra nodes
 	 * may complicate the code if those nodes are part of SRL or
 	 * individually rate limited.
+	 * Also, add the required VSI support nodes if the existing ones cannot
+	 * handle the requested new number of queues.
 	 */
+	status = ice_sched_add_vsi_support_nodes(pi, vsi_handle, tc_node,
+						 new_num_nodes);
+	if (status)
+		return status;
+
 	status = ice_sched_add_vsi_child_nodes(pi, vsi_handle, tc_node,
 					       new_num_nodes, owner);
 	if (status)
@@ -1998,6 +2080,58 @@ static bool ice_sched_is_leaf_node_present(struct ice_sched_node *node)
 	return (node->info.data.elem_type == ICE_AQC_ELEM_TYPE_LEAF);
 }
 
+/**
+ * ice_sched_rm_vsi_subtree - remove all nodes assigned to a given VSI
+ * @pi: port information structure
+ * @vsi_node: pointer to the leftmost node of the VSI to be removed
+ * @owner: LAN or RDMA
+ * @tc: TC number
+ *
+ * Return: Zero in case of success, or -EBUSY if the VSI has leaf nodes in TC.
+ *
+ * This function removes all the VSI support nodes associated with a given VSI
+ * and its LAN or RDMA children nodes from the scheduler tree.
+ */
+static int
+ice_sched_rm_vsi_subtree(struct ice_port_info *pi,
+			 struct ice_sched_node *vsi_node, u8 owner, u8 tc)
+{
+	u16 vsi_handle = vsi_node->vsi_handle;
+	bool all_vsi_nodes_removed = true;
+	int j = 0;
+
+	while (vsi_node) {
+		struct ice_sched_node *next_vsi_node;
+
+		if (ice_sched_is_leaf_node_present(vsi_node)) {
+			ice_debug(pi->hw, ICE_DBG_SCHED, "VSI has leaf nodes in TC %d\n", tc);
+			return -EBUSY;
+		}
+		while (j < vsi_node->num_children) {
+			if (vsi_node->children[j]->owner == owner)
+				ice_free_sched_node(pi, vsi_node->children[j]);
+			else
+				j++;
+		}
+
+		next_vsi_node = ice_sched_find_next_vsi_node(vsi_node);
+
+		/* remove the VSI if it has no children */
+		if (!vsi_node->num_children)
+			ice_free_sched_node(pi, vsi_node);
+		else
+			all_vsi_nodes_removed = false;
+
+		vsi_node = next_vsi_node;
+	}
+
+	/* clean up aggregator related VSI info if any */
+	if (all_vsi_nodes_removed)
+		ice_sched_rm_agg_vsi_info(pi, vsi_handle);
+
+	return 0;
+}
+
 /**
  * ice_sched_rm_vsi_cfg - remove the VSI and its children nodes
  * @pi: port information structure
@@ -2024,7 +2158,6 @@ ice_sched_rm_vsi_cfg(struct ice_port_info *pi, u16 vsi_handle, u8 owner)
 
 	ice_for_each_traffic_class(i) {
 		struct ice_sched_node *vsi_node, *tc_node;
-		u8 j = 0;
 
 		tc_node = ice_sched_get_tc_node(pi, i);
 		if (!tc_node)
@@ -2034,31 +2167,12 @@ ice_sched_rm_vsi_cfg(struct ice_port_info *pi, u16 vsi_handle, u8 owner)
 		if (!vsi_node)
 			continue;
 
-		if (ice_sched_is_leaf_node_present(vsi_node)) {
-			ice_debug(pi->hw, ICE_DBG_SCHED, "VSI has leaf nodes in TC %d\n", i);
-			status = -EBUSY;
+		status = ice_sched_rm_vsi_subtree(pi, vsi_node, owner, i);
+		if (status)
 			goto exit_sched_rm_vsi_cfg;
-		}
-		while (j < vsi_node->num_children) {
-			if (vsi_node->children[j]->owner == owner) {
-				ice_free_sched_node(pi, vsi_node->children[j]);
 
-				/* reset the counter again since the num
-				 * children will be updated after node removal
-				 */
-				j = 0;
-			} else {
-				j++;
-			}
-		}
-		/* remove the VSI if it has no children */
-		if (!vsi_node->num_children) {
-			ice_free_sched_node(pi, vsi_node);
-			vsi_ctx->sched.vsi_node[i] = NULL;
+		vsi_ctx->sched.vsi_node[i] = NULL;
 
-			/* clean up aggregator related VSI info if any */
-			ice_sched_rm_agg_vsi_info(pi, vsi_handle);
-		}
 		if (owner == ICE_SCHED_NODE_OWNER_LAN)
 			vsi_ctx->sched.max_lanq[i] = 0;
 		else
-- 
2.39.5




