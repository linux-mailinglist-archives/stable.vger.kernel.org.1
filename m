Return-Path: <stable+bounces-73093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B7896C30F
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 17:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA29C1C251F0
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 15:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635F11E5003;
	Wed,  4 Sep 2024 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNEMVSXQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B71E4939;
	Wed,  4 Sep 2024 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465098; cv=none; b=iRjomd6Mhq9OWO4LnZEwJWngg/Bs70sdHGi4N4N0+Bmkc68I0mWZuZ7HO/Nj3wY//tD3d/et6c6B4lE+yCNCQVB5kcKnW5x85ec6bPaLa0CvSwg+JJn7Kw7YbxbwCl1Ck5VEF2Qa8jis/57IH+R8kkVqe2jGzl3xCcse3CSisic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465098; c=relaxed/simple;
	bh=I7IXuGxMRYR7eY6NBf+1xNpvg8CKYVVrl2sOjIQby4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBLPrJ7VChH8dZiB8b5FlJTZJaxMnob5kT8dNCKtPrUM3nqwDRVjLTGEckHBQ7Xi1zbRRsvEBJ/5IQqOeroAgKB6bc0SI79ZI9pOE9P5csMcJ8KzfRItbWHJMcs3ic93F46jCI4RjyKDG9JB2eXqN1zovqZfbBOTNyJkGUNM9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNEMVSXQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725465096; x=1757001096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I7IXuGxMRYR7eY6NBf+1xNpvg8CKYVVrl2sOjIQby4A=;
  b=fNEMVSXQXAf+aN3866KHEhcl6K5iYf4mhcJO10pgkJccnzcaSuGP9yX1
   5VC72c4bY0fFnA64lztONVaOybJA3+HqFZxzRAuB3BUNYB5emG//fihaG
   DFLegz5pUSFd5Sq1DnjJbYQJ3hj5RkF5aaFqTw8jLpKn340mQk6zAzowD
   m/S59jtCKyupTgLtCJiqOLtkE6/h7Nn5drcZwj/6T+A18gXwBtlxJTW7X
   WvrwBsaATgmIVfNKOgEEV4Kub/jLwRR7deCGjw3FQ1uBp41SOtnhDAau3
   SlBL5XAQU2f1mG2c8ga8b9cOKyFj/5ypSj+fG6Wpb/1mSX0gnpDKBRCx2
   Q==;
X-CSE-ConnectionGUID: ZOhofqecSdWZbYoKttKH7g==
X-CSE-MsgGUID: sKBSm+FpSom+B1wxH8ssSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34737163"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="34737163"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:51:36 -0700
X-CSE-ConnectionGUID: JMT4w5N0Rpqri3o6nBks+Q==
X-CSE-MsgGUID: t8HBK54VSYCpBYPAGzw2lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="66041898"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 04 Sep 2024 08:51:33 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH iwl-next v2 5/6] idpf: fix netdev Tx queue stop/wake
Date: Wed,  4 Sep 2024 17:47:47 +0200
Message-ID: <20240904154748.2114199-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904154748.2114199-1-aleksander.lobakin@intel.com>
References: <20240904154748.2114199-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

netif_txq_maybe_stop() returns -1, 0, or 1, while
idpf_tx_maybe_stop_common() says it returns 0 or -EBUSY. As a result,
there sometimes are Tx queue timeout warnings despite that the queue
is empty or there is at least enough space to restart it.
Make idpf_tx_maybe_stop_common() inline and returning true or false,
handling the return of netif_txq_maybe_stop() properly. Use a correct
goto in idpf_tx_maybe_stop_splitq() to avoid stopping the queue or
incrementing the stops counter twice.

Fixes: 6818c4d5b3c2 ("idpf: add splitq start_xmit")
Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  9 ++++-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  4 +++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 35 +++++--------------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 3a2a92e79e60..33305de06975 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1018,7 +1018,6 @@ void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
 			   struct idpf_tx_buf *first, u16 ring_idx);
 unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 					 struct sk_buff *skb);
-int idpf_tx_maybe_stop_common(struct idpf_tx_queue *tx_q, unsigned int size);
 void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue);
 netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q);
@@ -1027,4 +1026,12 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
 				      u16 cleaned_count);
 int idpf_tso(struct sk_buff *skb, struct idpf_tx_offload_params *off);
 
+static inline bool idpf_tx_maybe_stop_common(struct idpf_tx_queue *tx_q,
+					     u32 needed)
+{
+	return !netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+					  IDPF_DESC_UNUSED(tx_q),
+					  needed, needed);
+}
+
 #endif /* !_IDPF_TXRX_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 947d3ff9677c..5ba360abbe66 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -375,6 +375,10 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				      IDPF_TX_DESCS_FOR_CTX)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
+		u64_stats_update_begin(&tx_q->stats_sync);
+		u64_stats_inc(&tx_q->q_stats.q_busy);
+		u64_stats_update_end(&tx_q->stats_sync);
+
 		return NETDEV_TX_BUSY;
 	}
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index a7f7efc61caf..05555303e097 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2131,29 +2131,6 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
 
-/**
- * idpf_tx_maybe_stop_common - 1st level check for common Tx stop conditions
- * @tx_q: the queue to be checked
- * @size: number of descriptors we want to assure is available
- *
- * Returns 0 if stop is not needed
- */
-int idpf_tx_maybe_stop_common(struct idpf_tx_queue *tx_q, unsigned int size)
-{
-	struct netdev_queue *nq;
-
-	if (likely(IDPF_DESC_UNUSED(tx_q) >= size))
-		return 0;
-
-	u64_stats_update_begin(&tx_q->stats_sync);
-	u64_stats_inc(&tx_q->q_stats.q_busy);
-	u64_stats_update_end(&tx_q->stats_sync);
-
-	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
-
-	return netif_txq_maybe_stop(nq, IDPF_DESC_UNUSED(tx_q), size, size);
-}
-
 /**
  * idpf_tx_maybe_stop_splitq - 1st level check for Tx splitq stop conditions
  * @tx_q: the queue to be checked
@@ -2165,7 +2142,7 @@ static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
 				     unsigned int descs_needed)
 {
 	if (idpf_tx_maybe_stop_common(tx_q, descs_needed))
-		goto splitq_stop;
+		goto out;
 
 	/* If there are too many outstanding completions expected on the
 	 * completion queue, stop the TX queue to give the device some time to
@@ -2184,10 +2161,12 @@ static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
 	return 0;
 
 splitq_stop:
+	netif_stop_subqueue(tx_q->netdev, tx_q->idx);
+
+out:
 	u64_stats_update_begin(&tx_q->stats_sync);
 	u64_stats_inc(&tx_q->q_stats.q_busy);
 	u64_stats_update_end(&tx_q->stats_sync);
-	netif_stop_subqueue(tx_q->netdev, tx_q->idx);
 
 	return -EBUSY;
 }
@@ -2210,7 +2189,11 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 	nq = netdev_get_tx_queue(tx_q->netdev, tx_q->idx);
 	tx_q->next_to_use = val;
 
-	idpf_tx_maybe_stop_common(tx_q, IDPF_TX_DESC_NEEDED);
+	if (idpf_tx_maybe_stop_common(tx_q, IDPF_TX_DESC_NEEDED)) {
+		u64_stats_update_begin(&tx_q->stats_sync);
+		u64_stats_inc(&tx_q->q_stats.q_busy);
+		u64_stats_update_end(&tx_q->stats_sync);
+	}
 
 	/* Force memory writes to complete before letting h/w
 	 * know there are new descriptors to fetch.  (Only
-- 
2.46.0


