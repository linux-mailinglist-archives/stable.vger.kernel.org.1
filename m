Return-Path: <stable+bounces-201108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C98BCC0095
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 22:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50BD230E04D4
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9B832E154;
	Mon, 15 Dec 2025 21:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eqp9e719"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B132AAA5
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834999; cv=none; b=dahlZRYz/7vOO4Dev4PxWVdSwuS9ra/eD3p2B7CCzePcbiWqLm0bw8Th/SL9CNzleiAQ9qCbAz8cGsShIq+6IeFdmqMHidoxB5e6RoEMIVvDHS1CPZnXH8x963TqzYIChXd6M+uG2Ddb2Dn76Hz6iFM/b0aNWx91HploPAfDNSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834999; c=relaxed/simple;
	bh=4FIilz0WAhpM70lzBiBmVe2/4DENN3TMWBFu46q+v2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGQw1SFBkdt2Uxkymi207muYn8dZH5pNWkjlKy/Vx7ZyO41TINAdTQEMOi1YcAo04n5zKCnuY563BXKzyqUVW1Lb2LaXexiuuD/M1paBe8bCLshcEuK59AAbFDFF3dqqXeg3JxPKaTUOp6c6DkrkObcal+Dtqn/9PFeDOtUayMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eqp9e719; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765834997; x=1797370997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4FIilz0WAhpM70lzBiBmVe2/4DENN3TMWBFu46q+v2A=;
  b=Eqp9e719Qr6PgzAHD95Hxe+H1ijHlTkwpHtcJWZXVSINmuSx3MkBRpLu
   rLpIOTEw9ZbWct0a1DHjgLYDGVFX5V9z/9/+OlRpanwfbp9lBRFrsXY0D
   +d3YGWfncF754MnZpLXumz27AWot521qCBDZmKeias8JTYwr7bsxyoCbk
   mFKYqEBCobyG8rFxu4unEvAaS+B43VcDJ7z56wjE9KcNcboH/GMD3iTOl
   gBq6FQKIdFs2roBsDEfUdestQrXj6hxGTL/W0AB83fR2zOJ6h+cJjc27V
   2VyOAVerI4ztStdF43M6uow1RVR+Gv521YZG3mLe2aT+/+z+JTQFfAi3E
   w==;
X-CSE-ConnectionGUID: 4eyE2PcrRKSKYBubHmpcMg==
X-CSE-MsgGUID: F1Hf7ZjvR4i78PNkr4z/xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67711911"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="67711911"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 13:43:11 -0800
X-CSE-ConnectionGUID: XSsYSntVSf6bQdawHf9PFg==
X-CSE-MsgGUID: Jq293FWUTbWIagyeJXG5Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; 
   d="scan'208";a="197110689"
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
Subject: [PATCH stable 6.12.y 4/8] idpf: improve when to set RE bit logic
Date: Mon, 15 Dec 2025 13:42:43 -0800
Message-ID: <20251215214303.2608822-5-anthony.l.nguyen@intel.com>
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

[ Upstream commit f2d18e16479cac7a708d77cbfb4220a9114a71fc ]

Track the gap between next_to_use and the last RE index. Set RE again
if the gap is large enough to ensure RE bit is set frequently. This is
critical before removing the stashing mechanisms because the
opportunistic descriptor ring cleaning from the out-of-order completions
will go away. Previously the descriptors would be "cleaned" by both the
descriptor (RE) completion and the out-of-order completions. Without the
latter, we must ensure the RE bit is set more frequently. Otherwise,
it's theoretically possible for the descriptor ring next_to_clean to
never advance.  The previous implementation was dependent on the start
of a packet falling on a 64th index in the descriptor ring, which is not
guaranteed with large packets.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 20 +++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index bbcedb31dfee..183569669746 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -313,6 +313,8 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 	 */
 	idpf_queue_change(GEN_CHK, refillq);
 
+	tx_q->last_re = tx_q->desc_count - IDPF_TX_SPLITQ_RE_MIN_GAP;
+
 	return 0;
 
 err_alloc:
@@ -2708,6 +2710,21 @@ netdev_tx_t idpf_tx_drop_skb(struct idpf_tx_queue *tx_q, struct sk_buff *skb)
 	return NETDEV_TX_OK;
 }
 
+/**
+ * idpf_tx_splitq_need_re - check whether RE bit needs to be set
+ * @tx_q: pointer to Tx queue
+ *
+ * Return: true if RE bit needs to be set, false otherwise
+ */
+static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
+{
+	int gap = tx_q->next_to_use - tx_q->last_re;
+
+	gap += (gap < 0) ? tx_q->desc_count : 0;
+
+	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
+}
+
 /**
  * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
  * @skb: send buffer
@@ -2788,9 +2805,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 		 * MIN_RING size to ensure it will be set at least once each
 		 * time around the ring.
 		 */
-		if (!(tx_q->next_to_use % IDPF_TX_SPLITQ_RE_MIN_GAP)) {
+		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
 			tx_q->txq_grp->num_completions_pending++;
+			tx_q->last_re = tx_q->next_to_use;
 		}
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 510c6e95af3a..d731e9e28407 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -623,6 +623,8 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
+ * @last_re: last descriptor index that RE bit was set
+ * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @cleaned_bytes: Splitq only, TXQ only: When a TX completion is received on
  *		   the TX completion queue, it can be for any TXQ associated
  *		   with that completion queue. This means we can clean up to
@@ -633,7 +635,6 @@ libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
  *		   only once at the end of the cleaning routine.
  * @clean_budget: singleq only, queue cleaning budget
  * @cleaned_pkts: Number of packets cleaned for the above said case
- * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @stash: Tx buffer stash for Flow-based scheduling mode
  * @refillq: Pointer to refill queue
  * @compl_tag_bufid_m: Completion tag buffer id mask
@@ -674,6 +675,8 @@ struct idpf_tx_queue {
 	__cacheline_group_begin_aligned(read_write);
 	u16 next_to_use;
 	u16 next_to_clean;
+	u16 last_re;
+	u16 tx_max_bufs;
 
 	union {
 		u32 cleaned_bytes;
@@ -681,7 +684,6 @@ struct idpf_tx_queue {
 	};
 	u16 cleaned_pkts;
 
-	u16 tx_max_bufs;
 	struct idpf_txq_stash *stash;
 	struct idpf_sw_queue *refillq;
 
-- 
2.47.1


