Return-Path: <stable+bounces-74087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582DB9723FE
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 22:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B85C1C21C57
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB9C18C029;
	Mon,  9 Sep 2024 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZERXfqN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD4418B498;
	Mon,  9 Sep 2024 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915218; cv=none; b=ceTtjZxMuF07n81XHLxHZrJsFBo2s/w8lyUosLBGaQ5pY3tR6NboJonG9uernJ/qVSbYyM6cBjW9OLU7t77YhFn2aATInCIcFnNkopPAA8xuDV4DDaXozl8+rkV5XdWYuWxDt2Q0VLcgz7623paJwqXqdwgCTYTUGTwrCbq/qS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915218; c=relaxed/simple;
	bh=3E/HP412xnXyT+6T/tXNpnLsI+ni3kx8fU/86uCfJcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPmHbpiSfINPzcfqkStZhWYd2qbpfcjaLu0He+BjsIDAaXQ299M7EQZliliAb3upJbyvhw1GKlsvQnltoQxuTKlNmIq0T1KPmZrsVd6xoVO01XTpYBug47k+dyk5V+08tpCLRqtF/8FX6BdUBrlVUE2cMXD1ceTSa3p/rN+QnhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZERXfqN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725915217; x=1757451217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3E/HP412xnXyT+6T/tXNpnLsI+ni3kx8fU/86uCfJcY=;
  b=mZERXfqN3An631lSQG/tptfpq3W193SDLaRD5tJRNk6q+YedFzNjlu5M
   2j6Ssqcv0c8BzZqQBBEiAwpXwfan3ut/H2qwy05xBTwVly2paGL58zlom
   MtiZh/m4z/eYN7cHben4HeZZTS7T5LBOSmu1C2SyurTtaliHvGdm7nWz5
   boqMExw9RSwEOM/ERYKcB0fD2ZMaMysTIwzZOlsRsW5yWjE8u57ASX6pi
   TLm2nozBgSd6eJydoPRri7diy8Y1xLZQbZFpTODYngvikd+TWI2xuUcXk
   CN7VmFWYB0ku5rDfvsVXZmosQX3ABypRn80g6bGOnQM1WbI/PgwGGHih8
   Q==;
X-CSE-ConnectionGUID: DlgcwBbsRGewnVfzvR6Skw==
X-CSE-MsgGUID: 3DhEoM7aRMy+TZ5Qb79hjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="42151262"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="42151262"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:53:34 -0700
X-CSE-ConnectionGUID: CPBKTypsSMCZMz983fLaZg==
X-CSE-MsgGUID: HjuxUFOuTvCCRCj+vbMPzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71194507"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 09 Sep 2024 13:53:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	joshua.a.hay@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	willemb@google.com,
	stable@vger.kernel.org
Subject: [PATCH net-next v3 5/6] idpf: fix netdev Tx queue stop/wake
Date: Mon,  9 Sep 2024 13:53:20 -0700
Message-ID: <20240909205323.3110312-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
References: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  4 +++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 35 +++++--------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  9 ++++-
 3 files changed, 21 insertions(+), 27 deletions(-)

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
index 9844d01eaedb..5d74f324bcd4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2132,29 +2132,6 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
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
@@ -2166,7 +2143,7 @@ static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
 				     unsigned int descs_needed)
 {
 	if (idpf_tx_maybe_stop_common(tx_q, descs_needed))
-		goto splitq_stop;
+		goto out;
 
 	/* If there are too many outstanding completions expected on the
 	 * completion queue, stop the TX queue to give the device some time to
@@ -2185,10 +2162,12 @@ static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
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
@@ -2211,7 +2190,11 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
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
-- 
2.42.0


