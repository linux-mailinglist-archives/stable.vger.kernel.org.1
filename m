Return-Path: <stable+bounces-243973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NuFAnN9+WmZ9AIAu9opvQ
	(envelope-from <stable+bounces-243973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:17:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A36BF4C6C7B
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76E0E3040C7C
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7093C3459;
	Tue,  5 May 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBhnryxr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F223C13EC;
	Tue,  5 May 2026 05:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958143; cv=none; b=O2MawvNSRYuZ/oKPISJHSHLuYJzL4JRXQBcoe16nub/QY14Bc36Al0I6CpSkUfx6jvnzdRjg1xgnUbzEzmoO4NGYvawalBJu39zEMZ296E/jpm97DPzLY7HyzUWAo3UGsZrP2uQYC9ZaNZ0HJCc7/kVdeFefqgfWr5YlxyznvkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958143; c=relaxed/simple;
	bh=D904DKy6XSwJcFQCt1ke022KDhrtNTaZ/6ntdEoUdtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7Ie2dWjF5+2xp3dpS/LHrzEd8I0B+198q+XnoJARPMy3T73NL28Di5k0AugDir+eDb+evQrrD6lHHaDD54OICU7ZFyBpjxWdmHrYV2+FHPuXDp4yz036ImQPFW5xQyFRziOFEiBn932NfSp5Ft+1KkjK1ee1EVlosKm7KNNOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBhnryxr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958142; x=1809494142;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D904DKy6XSwJcFQCt1ke022KDhrtNTaZ/6ntdEoUdtk=;
  b=IBhnryxr4SoUqCcdKZoA8rcHxp2KICrDzHAwJO8K/S1GVx800Dcg/1o/
   REzmu8JlcJ2SfDBCUazLcFoctTGCScQ9HoseBBo+X5wvS1nsBhalha+Nd
   cDMe1q+8sATqE06BVUkTpg0v5zC7c+Sk/VKfxir8z9FXLGoD95n1PsHwh
   glvZCV9Vu4jYyMsToEOE+d5Z9UAuGghZdBqYcKy1w6x9ZN9TrezqZ0fpg
   zJ9Wmv4WVSt2+S9oTFTRJZUHbIkSQdODeNKfzrRvFPbAQNasiRFrlM6ty
   miZc0HOr4DTJN4nfcnGGdnbxztNCbJWiMVjzEIfL1VY/gOPsZysRp89Dx
   A==;
X-CSE-ConnectionGUID: AX+MHexfRjCTo+ih+GxlYg==
X-CSE-MsgGUID: rzewA2J5SO2tdzR8R9OWBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126457"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126457"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
X-CSE-ConnectionGUID: MWIItd61ROGscEcw7hJh7Q==
X-CSE-MsgGUID: LtRt0KFzQIWZDvgNWrFKKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683502"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:19 -0700
Subject: [PATCH net 06/13] idpf: fix skb datapath queue based scheduling
 crashes and timeouts
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-6-a222a88bd962@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=8812;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=EZm85tHecHy61dRE7iltojwQcsHXRGWEyDVMbE7YmUk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNd8UFwuask+eyiYRNXV2xMMabe/rVzanqjutdbu0g
 EGZbUtVRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABPJKmX4n2qg/deA+W/hzbNB
 jCJHNm5Z82zLp5JOrRtzl3xitSk+Icjwz3Bh87vDkfv6reVXLPzBfmmLmLPWxbd3bYKmV71YXhR
 zjBkA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: A36BF4C6C7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243973-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Joshua Hay <joshua.a.hay@intel.com>

The splitq Tx resource checks were assuming that the queues were using
flow based scheduling and checking the refillqs for free buffers.
However, the Tx refillqs are not allocated when using queue based
scheduling resulting in a NULL ptr dereference. Adjust the Tx resource
checks to only check available descriptor resources when using queue
based scheduling. Because queue based scheduling does not have any
notion of descriptor only completions, there cannot be any packets in
flight, meaning there is no need to check for pending completions.

The driver also only supported 8 byte completion descriptors in the skb
datapath previously. However, currently the FW only supports 4 byte
completion descriptors when using queue based scheduling. This meant we
were skipping over completions, resulting in Tx timeouts.  Add support
to process both 4 and 8 byte completion descriptors, depending on the
scheduling mode. Cache the next_to_clean completion descriptor in the
completion queue struct, and fetch this descriptor before the start of
each cleaning loop. Access the next descriptor in the loop by
calculating the index based on raw byte count.

Fixes: 0c3f135e840d ("idpf: stop Tx if there are insufficient buffer resources")
Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 +++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 49 ++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..b6836e38f449 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -807,11 +807,13 @@ libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 24, 32);
  * @txq_grp: See struct idpf_txq_group
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Number of descriptors
+ * @desc_sz: Descriptor size in bytes
  * @clean_budget: queue cleaning budget
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use. Relevant in both split & single txq
  *		 and bufq.
  * @next_to_clean: Next descriptor to clean
+ * @ntc_desc: Pointer to next_to_clean descriptor for next NAPI poll
  * @num_completions: Only relevant for TX completion queue. It tracks the
  *		     number of completions received to compare against the
  *		     number of completions pending, as accumulated by the
@@ -833,6 +835,7 @@ struct idpf_compl_queue {
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
 	u32 desc_count;
+	u32 desc_sz;
 
 	u32 clean_budget;
 	struct net_device *netdev;
@@ -841,6 +844,7 @@ struct idpf_compl_queue {
 	__cacheline_group_begin_aligned(read_write);
 	u32 next_to_use;
 	u32 next_to_clean;
+	struct idpf_splitq_tx_compl_desc *ntc_desc;
 
 	aligned_u64 num_completions;
 	__cacheline_group_end_aligned(read_write);
@@ -853,7 +857,7 @@ struct idpf_compl_queue {
 	struct idpf_q_vector *q_vector;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_compl_queue, 40, 16, 24);
+libeth_cacheline_set_assert(struct idpf_compl_queue, 48, 24, 24);
 
 /**
  * struct idpf_sw_queue
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f6b3b15364ff..4fc0bb14c5b1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -270,11 +270,9 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
 				 struct idpf_compl_queue *complq)
 {
-	u32 desc_size;
-
-	desc_size = idpf_queue_has(FLOW_SCH_EN, complq) ?
-		    sizeof(*complq->comp) : sizeof(*complq->comp_4b);
-	complq->size = array_size(complq->desc_count, desc_size);
+	complq->desc_sz = idpf_queue_has(FLOW_SCH_EN, complq) ?
+			  sizeof(*complq->comp) : sizeof(*complq->comp_4b);
+	complq->size = array_size(complq->desc_count, complq->desc_sz);
 
 	complq->desc_ring = dma_alloc_coherent(complq->netdev->dev.parent,
 					       complq->size, &complq->dma,
@@ -284,6 +282,7 @@ static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
 
 	complq->next_to_use = 0;
 	complq->next_to_clean = 0;
+	complq->ntc_desc = complq->comp;
 	idpf_queue_set(GEN_CHK, complq);
 
 	idpf_xsk_setup_queue(vport, complq,
@@ -2193,7 +2192,7 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 				 int *cleaned)
 {
-	struct idpf_splitq_tx_compl_desc *tx_desc;
+	struct idpf_splitq_tx_compl_desc *tx_desc = complq->ntc_desc;
 	s16 ntc = complq->next_to_clean;
 	struct idpf_netdev_priv *np;
 	unsigned int complq_budget;
@@ -2201,7 +2200,6 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 	int i;
 
 	complq_budget = complq->clean_budget;
-	tx_desc = &complq->comp[ntc];
 	ntc -= complq->desc_count;
 
 	do {
@@ -2257,11 +2255,12 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		u64_stats_update_end(&tx_q->stats_sync);
 
 fetch_next_desc:
-		tx_desc++;
+		tx_desc = (struct idpf_splitq_tx_compl_desc *)
+				((u8 *)tx_desc + complq->desc_sz);
 		ntc++;
 		if (unlikely(!ntc)) {
 			ntc -= complq->desc_count;
-			tx_desc = &complq->comp[0];
+			tx_desc = complq->comp;
 			idpf_queue_change(GEN_CHK, complq);
 		}
 
@@ -2271,6 +2270,8 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		complq_budget--;
 	} while (likely(complq_budget));
 
+	complq->ntc_desc = tx_desc;
+
 	/* Store the state of the complq to be used later in deciding if a
 	 * TXQ can be started again
 	 */
@@ -2437,21 +2438,32 @@ static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 descs_needed,
  * @tx_q: the queue to be checked
  * @descs_needed: number of descriptors required for this packet
  * @bufs_needed: number of buffers needed for this packet
+ * @flow: true if queue uses flow based scheduling, false if queue based scheduling
  *
  * Return: 0 if stop is not needed
  */
 static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
-				     u32 descs_needed,
-				     u32 bufs_needed)
+				     u32 descs_needed, u32 bufs_needed,
+				     bool flow)
 {
-	/* Since we have multiple resources to check for splitq, our
+	/* Since we have multiple resources to check for flow based splitq, our
 	 * start,stop_thrs becomes a boolean check instead of a count
 	 * threshold.
 	 */
-	if (netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
-				      idpf_txq_has_room(tx_q, descs_needed,
-							bufs_needed),
-				      1, 1))
+	if (flow && netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+					      idpf_txq_has_room(tx_q,
+								descs_needed,
+								bufs_needed),
+					      1, 1))
+		return 0;
+
+	/* For queue based splitq, there is no need to check the number of
+	 * pending completions since we cannot reuse descriptors until we get
+	 * completions, so we only need to check for descriptor resources.
+	 */
+	if (!flow && netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+					       IDPF_DESC_UNUSED(tx_q),
+					       descs_needed, descs_needed))
 		return 0;
 
 	u64_stats_update_begin(&tx_q->stats_sync);
@@ -3021,6 +3033,7 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 					struct idpf_tx_queue *tx_q)
 {
+	bool flow = idpf_queue_has(FLOW_SCH_EN, tx_q);
 	struct idpf_tx_splitq_params tx_params = {
 		.prev_ntu = tx_q->next_to_use,
 	};
@@ -3040,7 +3053,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 	/* Check for splitq specific TX resources */
 	count += (IDPF_TX_DESCS_PER_CACHE_LINE + tso);
-	if (idpf_tx_maybe_stop_splitq(tx_q, count, buf_count)) {
+	if (idpf_tx_maybe_stop_splitq(tx_q, count, buf_count, flow)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
 		return NETDEV_TX_BUSY;
@@ -3072,7 +3085,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 		idpf_tx_set_tstamp_desc(ctx_desc, idx);
 	}
 
-	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
+	if (flow) {
 		struct idpf_sw_queue *refillq = tx_q->refillq;
 
 		/* Save refillq state in case of a packet rollback.  Otherwise,

-- 
2.54.0.rc2.531.gaf818d63126a


