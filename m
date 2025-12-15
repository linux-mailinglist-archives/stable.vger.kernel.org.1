Return-Path: <stable+bounces-201107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D21CC0092
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 22:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A726230DF486
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 21:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D0132C94D;
	Mon, 15 Dec 2025 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUUuc97i"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DC32C948
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834998; cv=none; b=Tjq94PUT2YIstKyc/8jCTRe+KCr9kNdqCvOtykqzLmTYkPW94fJhd4SUpzOWkQNTwsvbAWU93beILab17Z/Cm1m8zPVGMgNtWn/0XAcD4FdiAv9atJUh/pjzmViYgHMBVSpIoSEKzkdX1lFfaeHub8QFw1pkUp49zJbZzSLfMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834998; c=relaxed/simple;
	bh=eE7IfXfk0cO9aGAEK9sBpMndWgxZog0w05WWZEaYmtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAA6ImaXM59PvP335MdlaUeeTNV8ZYtnodEvL2Mhjd57Mf2+L07+JdFiwm5o8XPfxBofZI1NCu/4wPMvotIZvGBWin5S1ojk/yTMGImoJoXlNYvRMmzTtNwpBQqBwQgDzTjqdSohLoOlQg1lzN/V/2gwjT6ihbs9oK8Nf92GOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUUuc97i; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765834996; x=1797370996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eE7IfXfk0cO9aGAEK9sBpMndWgxZog0w05WWZEaYmtQ=;
  b=GUUuc97iHF3OPm2ttsZb9/uXB4Kh/FsXaQe2q78ekGzb1ouK6l6O9+Mf
   W3dvSWRxoq63vOaxqm5XoWRCfP8VSoAGcM//yO/fw4wMVqbyH77ciegV/
   aOZHMohimhTuBgVch+cWz6sj4K6D0NfnC+P57nPhpnhTUjQqA/aUagPp7
   xiGfoa34I5Rqquw5nwkxp4pmZHgKqwfmzNaAEXwjkpPhcOdmpJitjPfDc
   TIKEwZkbgWS5BIxyMMsJC39EyrfpLh7dMLzYDoDnsRvm8LyTbEl3W66KU
   NqbDBY+bfygJZhcHTTz0QNNpm8GIp6GVZKC9EksStt644S0Yt3qlwbN8f
   Q==;
X-CSE-ConnectionGUID: pZrjHvPpTvuWWgRTZiGP6g==
X-CSE-MsgGUID: kUT5L+7DRoi6D1ejCNOeyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67711908"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="67711908"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 13:43:11 -0800
X-CSE-ConnectionGUID: oKy8BMRXTQCorLZ05BRlYg==
X-CSE-MsgGUID: TTXtBo1+TtCCu2q0BJAwog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="197110685"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 13:43:11 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: stable@vger.kernel.org
Cc: Joshua Hay <joshua.a.hay@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	decot@google.com,
	lrizzo@google.com,
	brianvv@google.com,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH stable 6.12.y 3/8] idpf: add support for Tx refillqs in flow scheduling mode
Date: Mon, 15 Dec 2025 13:42:42 -0800
Message-ID: <20251215214303.2608822-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251215214303.2608822-1-anthony.l.nguyen@intel.com>
References: <20251215214303.2608822-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Hay <joshua.a.hay@intel.com>

[ Upstream commit cb83b559bea39f207ee214ee2972657e8576ed18 ]

Changes from original commit:
- Adjusted idpf_tx_queue assert size to align with 6.12 struct definition

In certain production environments, it is possible for completion tags
to collide, meaning N packets with the same completion tag are in flight
at the same time. In this environment, any given Tx queue is effectively
used to send both slower traffic and higher throughput traffic
simultaneously. This is the result of a customer's specific
configuration in the device pipeline, the details of which Intel cannot
provide. This configuration results in a small number of out-of-order
completions, i.e., a small number of packets in flight. The existing
guardrails in the driver only protect against a large number of packets
in flight. The slower flow completions are delayed which causes the
out-of-order completions. The fast flow will continue sending traffic
and generating tags. Because tags are generated on the fly, the fast
flow eventually uses the same tag for a packet that is still in flight
from the slower flow. The driver has no idea which packet it should
clean when it processes the completion with that tag, but it will look
for the packet on the buffer ring before the hash table.  If the slower
flow packet completion is processed first, it will end up cleaning the
fast flow packet on the ring prematurely. This leaves the descriptor
ring in a bad state resulting in a crash or Tx timeout.

In summary, generating a tag when a packet is sent can lead to the same
tag being associated with multiple packets. This can lead to resource
leaks, crashes, and/or Tx timeouts.

Before we can replace the tag generation, we need a new mechanism for
the send path to know what tag to use next. The driver will allocate and
initialize a refillq for each TxQ with all of the possible free tag
values. During send, the driver grabs the next free tag from the refillq
from next_to_clean. While cleaning the packet, the clean routine posts
the tag back to the refillq's next_to_use to indicate that it is now
free to use.

This mechanism works exactly the same way as the existing Rx refill
queues, which post the cleaned buffer IDs back to the buffer queue to be
reposted to HW. Since we're using the refillqs for both Rx and Tx now,
genericize some of the existing refillq support.

Note: the refillqs will not be used yet. This is only demonstrating how
they will be used to pass free tags back to the send path.

Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 93 +++++++++++++++++++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  8 +-
 2 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index e03b6ac72894..bbcedb31dfee 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -158,6 +158,9 @@ static void idpf_tx_desc_rel(struct idpf_tx_queue *txq)
 	if (!txq->desc_ring)
 		return;
 
+	if (txq->refillq)
+		kfree(txq->refillq->ring);
+
 	dmam_free_coherent(txq->dev, txq->size, txq->desc_ring, txq->dma);
 	txq->desc_ring = NULL;
 	txq->next_to_use = 0;
@@ -263,6 +266,7 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 			      struct idpf_tx_queue *tx_q)
 {
 	struct device *dev = tx_q->dev;
+	struct idpf_sw_queue *refillq;
 	int err;
 
 	err = idpf_tx_buf_alloc_all(tx_q);
@@ -286,6 +290,29 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 	tx_q->next_to_clean = 0;
 	idpf_queue_set(GEN_CHK, tx_q);
 
+	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
+		return 0;
+
+	refillq = tx_q->refillq;
+	refillq->desc_count = tx_q->desc_count;
+	refillq->ring = kcalloc(refillq->desc_count, sizeof(u32),
+				GFP_KERNEL);
+	if (!refillq->ring) {
+		err = -ENOMEM;
+		goto err_alloc;
+	}
+
+	for (unsigned int i = 0; i < refillq->desc_count; i++)
+		refillq->ring[i] =
+			FIELD_PREP(IDPF_RFL_BI_BUFID_M, i) |
+			FIELD_PREP(IDPF_RFL_BI_GEN_M,
+				   idpf_queue_has(GEN_CHK, refillq));
+
+	/* Go ahead and flip the GEN bit since this counts as filling
+	 * up the ring, i.e. we already ring wrapped.
+	 */
+	idpf_queue_change(GEN_CHK, refillq);
+
 	return 0;
 
 err_alloc:
@@ -622,18 +649,18 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
 }
 
 /**
- * idpf_rx_post_buf_refill - Post buffer id to refill queue
+ * idpf_post_buf_refill - Post buffer id to refill queue
  * @refillq: refill queue to post to
  * @buf_id: buffer id to post
  */
-static void idpf_rx_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
+static void idpf_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
 {
 	u32 nta = refillq->next_to_use;
 
 	/* store the buffer ID and the SW maintained GEN bit to the refillq */
 	refillq->ring[nta] =
-		FIELD_PREP(IDPF_RX_BI_BUFID_M, buf_id) |
-		FIELD_PREP(IDPF_RX_BI_GEN_M,
+		FIELD_PREP(IDPF_RFL_BI_BUFID_M, buf_id) |
+		FIELD_PREP(IDPF_RFL_BI_GEN_M,
 			   idpf_queue_has(GEN_CHK, refillq));
 
 	if (unlikely(++nta == refillq->desc_count)) {
@@ -1014,6 +1041,11 @@ static void idpf_txq_group_rel(struct idpf_vport *vport)
 		struct idpf_txq_group *txq_grp = &vport->txq_grps[i];
 
 		for (j = 0; j < txq_grp->num_txq; j++) {
+			if (flow_sch_en) {
+				kfree(txq_grp->txqs[j]->refillq);
+				txq_grp->txqs[j]->refillq = NULL;
+			}
+
 			kfree(txq_grp->txqs[j]);
 			txq_grp->txqs[j] = NULL;
 		}
@@ -1425,6 +1457,13 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport, u16 num_txq)
 			}
 
 			idpf_queue_set(FLOW_SCH_EN, q);
+
+			q->refillq = kzalloc(sizeof(*q->refillq), GFP_KERNEL);
+			if (!q->refillq)
+				goto err_alloc;
+
+			idpf_queue_set(GEN_CHK, q->refillq);
+			idpf_queue_set(RFL_GEN_CHK, q->refillq);
 		}
 
 		if (!split)
@@ -1973,6 +2012,8 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 
 	compl_tag = le16_to_cpu(desc->q_head_compl_tag.compl_tag);
 
+	idpf_post_buf_refill(txq->refillq, compl_tag);
+
 	/* If we didn't clean anything on the ring, this packet must be
 	 * in the hash table. Go clean it there.
 	 */
@@ -2332,6 +2373,37 @@ static unsigned int idpf_tx_splitq_bump_ntu(struct idpf_tx_queue *txq, u16 ntu)
 	return ntu;
 }
 
+/**
+ * idpf_tx_get_free_buf_id - get a free buffer ID from the refill queue
+ * @refillq: refill queue to get buffer ID from
+ * @buf_id: return buffer ID
+ *
+ * Return: true if a buffer ID was found, false if not
+ */
+static bool idpf_tx_get_free_buf_id(struct idpf_sw_queue *refillq,
+				    u16 *buf_id)
+{
+	u32 ntc = refillq->next_to_clean;
+	u32 refill_desc;
+
+	refill_desc = refillq->ring[ntc];
+
+	if (unlikely(idpf_queue_has(RFL_GEN_CHK, refillq) !=
+		     !!(refill_desc & IDPF_RFL_BI_GEN_M)))
+		return false;
+
+	*buf_id = FIELD_GET(IDPF_RFL_BI_BUFID_M, refill_desc);
+
+	if (unlikely(++ntc == refillq->desc_count)) {
+		idpf_queue_change(RFL_GEN_CHK, refillq);
+		ntc = 0;
+	}
+
+	refillq->next_to_clean = ntc;
+
+	return true;
+}
+
 /**
  * idpf_tx_splitq_map - Build the Tx flex descriptor
  * @tx_q: queue to send buffer on
@@ -2702,6 +2774,13 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 	}
 
 	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
+		if (unlikely(!idpf_tx_get_free_buf_id(tx_q->refillq,
+						      &tx_params.compl_tag))) {
+			u64_stats_update_begin(&tx_q->stats_sync);
+			u64_stats_inc(&tx_q->q_stats.q_busy);
+			u64_stats_update_end(&tx_q->stats_sync);
+		}
+
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
 		/* Set the RE bit to catch any packets that may have not been
@@ -3220,7 +3299,7 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 skip_data:
 		rx_buf->page = NULL;
 
-		idpf_rx_post_buf_refill(refillq, buf_id);
+		idpf_post_buf_refill(refillq, buf_id);
 		IDPF_RX_BUMP_NTC(rxq, ntc);
 
 		/* skip if it is non EOP desc */
@@ -3328,10 +3407,10 @@ static void idpf_rx_clean_refillq(struct idpf_buf_queue *bufq,
 		bool failure;
 
 		if (idpf_queue_has(RFL_GEN_CHK, refillq) !=
-		    !!(refill_desc & IDPF_RX_BI_GEN_M))
+		    !!(refill_desc & IDPF_RFL_BI_GEN_M))
 			break;
 
-		buf_id = FIELD_GET(IDPF_RX_BI_BUFID_M, refill_desc);
+		buf_id = FIELD_GET(IDPF_RFL_BI_BUFID_M, refill_desc);
 		failure = idpf_rx_update_bufq_desc(bufq, buf_id, buf_desc);
 		if (failure)
 			break;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 77389653f666..510c6e95af3a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -107,8 +107,8 @@ do {								\
  */
 #define IDPF_TX_SPLITQ_RE_MIN_GAP	64
 
-#define IDPF_RX_BI_GEN_M		BIT(16)
-#define IDPF_RX_BI_BUFID_M		GENMASK(15, 0)
+#define IDPF_RFL_BI_GEN_M		BIT(16)
+#define IDPF_RFL_BI_BUFID_M		GENMASK(15, 0)
 
 #define IDPF_RXD_EOF_SPLITQ		VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_EOF_M
 #define IDPF_RXD_EOF_SINGLEQ		VIRTCHNL2_RX_BASE_DESC_STATUS_EOF_M
@@ -635,6 +635,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @cleaned_pkts: Number of packets cleaned for the above said case
  * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @stash: Tx buffer stash for Flow-based scheduling mode
+ * @refillq: Pointer to refill queue
  * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_cur_gen: Used to keep track of current completion tag generation
  * @compl_tag_gen_max: To determine when compl_tag_cur_gen should be reset
@@ -682,6 +683,7 @@ struct idpf_tx_queue {
 
 	u16 tx_max_bufs;
 	struct idpf_txq_stash *stash;
+	struct idpf_sw_queue *refillq;
 
 	u16 compl_tag_bufid_m;
 	u16 compl_tag_cur_gen;
@@ -700,7 +702,7 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
-			    88 + sizeof(struct u64_stats_sync),
+			    96 + sizeof(struct u64_stats_sync),
 			    24);
 
 /**
-- 
2.47.1


