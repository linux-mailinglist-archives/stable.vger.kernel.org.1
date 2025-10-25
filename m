Return-Path: <stable+bounces-189580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7407C09BD3
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 18:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB70F546581
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C431326F;
	Sat, 25 Oct 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlftwVTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626C309EF7;
	Sat, 25 Oct 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409388; cv=none; b=dXmDDQH93WStHJ2DFS3KerF96LdDrl/Ano5RJ+vLZ0ZH3cs9ve4EDkkXMgt0iw8cfGJb4G+i7J47FlrmZHLpEhHz933W7Ga2Rl5sYawL9nR0HC3E/KiNbM9BGOiXErxWqwNWQHCxMns/TvWQ+pk2UomQ73CKh/l8I8rR40XmmUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409388; c=relaxed/simple;
	bh=2BytTBVf22JRRNwNudRZs96gVnu3n/E07bOA1sh3iZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqR3XReSPMFK/k1+dmqFXHaII3PF3tNb2W+if0/QoSDJOSZXfvaoZkTIJjcg5MTw1FDXO9ikSWATsb6Ij8W1q09NDnGaGT0dA2WF/bKQvycNJadz8JNIdDTlquE99c4fWPWsl8McX/orPt8Lr4D1tROdif9+A+N3WcSsfZri7ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlftwVTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B40C4CEFF;
	Sat, 25 Oct 2025 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409388;
	bh=2BytTBVf22JRRNwNudRZs96gVnu3n/E07bOA1sh3iZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlftwVTv5MeNhOFxP5uP7z8XOfuqpuaslCq70pcNmbPOMhaQIPCTltDm8e64UMZkm
	 iNETClkMA+JiS2SC6HTzwQcw67gs0lyV+DXDI1whhL4d4vuaO8fFBUVhNhXJnq4cgy
	 WUEua/2r7M+I4PfpK3PCMNTkkYvDzCnH++TvqsHvG5lo8fy/4XFrWJvAbPk0gdvoBi
	 IKUrO7eY/b4jHO8IxSXkI9P99x1SzNe7QGpbQ4GZjYIG7u8rB6TjMkrt2ZQ2J7LG21
	 KZiWitRqkZA65GZmhRWMKD4nwXxxle2kJrTQvRQQszmnJikU9c62bpDV6409hydBgJ
	 FBuH4yZZa1t1Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Fan Gong <gongfan1@huawei.com>,
	Zhu Yikai <zhuyikai1@h-partners.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] hinic3: Queue pair endianness improvements
Date: Sat, 25 Oct 2025 11:58:52 -0400
Message-ID: <20251025160905.3857885-301-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fan Gong <gongfan1@huawei.com>

[ Upstream commit 6b822b658aafe840ffd6d7f1af5bf4f77df15a11 ]

Explicitly use little-endian & big-endian structs to support big
endian hosts.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/9b995a10f1e209a878bf98e4e1cdfb926f386695.1757653621.git.zhuyikai1@h-partners.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – this keeps the hinic3 data path functional on big-endian systems
with very low regression risk.

- `drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h:77-93` now stores
  doorbell metadata as `__le32` and uses `cpu_to_le32()`, fixing the
  MMIO write ordering bug that prevents queue pairs from working on big-
  endian hosts.
- RX descriptors and completions are switched to little-endian storage
  (`hinic3_rx.h:29-44`, `hinic3_rx.c:114-117`), and incoming CQE fields
  are decoded with `le32_to_cpu()` (`hinic3_rx.c:363-533`), so
  checksum/LRO handling no longer reads garbage on big-endian.
- The TX path stores DMA addresses, lengths, and offload metadata in
  little-endian (`hinic3_tx.h:79-91`, `hinic3_tx.c:55-107`,
  `hinic3_tx.c:277-372`, `hinic3_tx.c:466-502`), and the helper macros
  now convert back to CPU order when inspected, preventing incorrect
  TSO/PLDOFF decisions.
- These changes are confined to the hinic3 driver, introduce no new
  features, and simply make the existing hardware interface endian-safe;
  they are essentially no-ops on little-endian machines via
  `cpu_to_le32()` / `le32_to_cpu()`.

Natural follow-up: 1) Run basic Tx/Rx regression on a big-endian
platform to confirm the fix; 2) Ensure the change applies cleanly to the
desired stable branches.

 .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 15 ++--
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 10 +--
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    | 24 +++---
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 81 ++++++++++---------
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 18 ++---
 5 files changed, 79 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
index 865ba6878c483..1808d37e7cf71 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -75,8 +75,8 @@ static inline u16 hinic3_get_sq_hw_ci(const struct hinic3_io_queue *sq)
 #define DB_CFLAG_DP_RQ   1
 
 struct hinic3_nic_db {
-	u32 db_info;
-	u32 pi_hi;
+	__le32 db_info;
+	__le32 pi_hi;
 };
 
 static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
@@ -84,11 +84,12 @@ static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
 {
 	struct hinic3_nic_db db;
 
-	db.db_info = DB_INFO_SET(DB_SRC_TYPE, TYPE) |
-		     DB_INFO_SET(cflag, CFLAG) |
-		     DB_INFO_SET(cos, COS) |
-		     DB_INFO_SET(queue->q_id, QID);
-	db.pi_hi = DB_PI_HIGH(pi);
+	db.db_info =
+		cpu_to_le32(DB_INFO_SET(DB_SRC_TYPE, TYPE) |
+			    DB_INFO_SET(cflag, CFLAG) |
+			    DB_INFO_SET(cos, COS) |
+			    DB_INFO_SET(queue->q_id, QID));
+	db.pi_hi = cpu_to_le32(DB_PI_HIGH(pi));
 
 	writeq(*((u64 *)&db), DB_ADDR(queue, pi));
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 860163e9d66cf..ac04e3a192ada 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -66,8 +66,8 @@ static void rq_wqe_buf_set(struct hinic3_io_queue *rq, uint32_t wqe_idx,
 	struct hinic3_rq_wqe *rq_wqe;
 
 	rq_wqe = get_q_element(&rq->wq.qpages, wqe_idx, NULL);
-	rq_wqe->buf_hi_addr = upper_32_bits(dma_addr);
-	rq_wqe->buf_lo_addr = lower_32_bits(dma_addr);
+	rq_wqe->buf_hi_addr = cpu_to_le32(upper_32_bits(dma_addr));
+	rq_wqe->buf_lo_addr = cpu_to_le32(lower_32_bits(dma_addr));
 }
 
 static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
@@ -279,7 +279,7 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 	if (skb_is_nonlinear(skb))
 		hinic3_pull_tail(skb);
 
-	offload_type = rx_cqe->offload_type;
+	offload_type = le32_to_cpu(rx_cqe->offload_type);
 	hinic3_rx_csum(rxq, offload_type, status, skb);
 
 	num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
@@ -311,14 +311,14 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 	while (likely(nr_pkts < budget)) {
 		sw_ci = rxq->cons_idx & rxq->q_mask;
 		rx_cqe = rxq->cqe_arr + sw_ci;
-		status = rx_cqe->status;
+		status = le32_to_cpu(rx_cqe->status);
 		if (!RQ_CQE_STATUS_GET(status, RXDONE))
 			break;
 
 		/* make sure we read rx_done before packet length */
 		rmb();
 
-		vlan_len = rx_cqe->vlan_len;
+		vlan_len = le32_to_cpu(rx_cqe->vlan_len);
 		pkt_len = RQ_CQE_SGE_GET(vlan_len, LEN);
 		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))
 			break;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 1cca21858d40e..e7b496d13a697 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -27,21 +27,21 @@
 
 /* RX Completion information that is provided by HW for a specific RX WQE */
 struct hinic3_rq_cqe {
-	u32 status;
-	u32 vlan_len;
-	u32 offload_type;
-	u32 rsvd3;
-	u32 rsvd4;
-	u32 rsvd5;
-	u32 rsvd6;
-	u32 pkt_info;
+	__le32 status;
+	__le32 vlan_len;
+	__le32 offload_type;
+	__le32 rsvd3;
+	__le32 rsvd4;
+	__le32 rsvd5;
+	__le32 rsvd6;
+	__le32 pkt_info;
 };
 
 struct hinic3_rq_wqe {
-	u32 buf_hi_addr;
-	u32 buf_lo_addr;
-	u32 cqe_hi_addr;
-	u32 cqe_lo_addr;
+	__le32 buf_hi_addr;
+	__le32 buf_lo_addr;
+	__le32 cqe_hi_addr;
+	__le32 cqe_lo_addr;
 };
 
 struct hinic3_rx_info {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 3f7f73430be41..dd8f362ded185 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -81,10 +81,10 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 
 	dma_info[0].len = skb_headlen(skb);
 
-	wqe_desc->hi_addr = upper_32_bits(dma_info[0].dma);
-	wqe_desc->lo_addr = lower_32_bits(dma_info[0].dma);
+	wqe_desc->hi_addr = cpu_to_le32(upper_32_bits(dma_info[0].dma));
+	wqe_desc->lo_addr = cpu_to_le32(lower_32_bits(dma_info[0].dma));
 
-	wqe_desc->ctrl_len = dma_info[0].len;
+	wqe_desc->ctrl_len = cpu_to_le32(dma_info[0].len);
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		frag = &(skb_shinfo(skb)->frags[i]);
@@ -197,7 +197,8 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		union hinic3_ip ip;
 		u8 l4_proto;
 
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, TUNNEL_FLAG);
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1,
+								 TUNNEL_FLAG));
 
 		ip.hdr = skb_network_header(skb);
 		if (ip.v4->version == 4) {
@@ -226,7 +227,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		}
 	}
 
-	task->pkt_info0 |= SQ_TASK_INFO0_SET(1, INNER_L4_EN);
+	task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1, INNER_L4_EN));
 
 	return 1;
 }
@@ -255,26 +256,28 @@ static void get_inner_l3_l4_type(struct sk_buff *skb, union hinic3_ip *ip,
 	}
 }
 
-static void hinic3_set_tso_info(struct hinic3_sq_task *task, u32 *queue_info,
+static void hinic3_set_tso_info(struct hinic3_sq_task *task, __le32 *queue_info,
 				enum hinic3_l4_offload_type l4_offload,
 				u32 offset, u32 mss)
 {
 	if (l4_offload == HINIC3_L4_OFFLOAD_TCP) {
-		*queue_info |= SQ_CTRL_QUEUE_INFO_SET(1, TSO);
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, INNER_L4_EN);
+		*queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(1, TSO));
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1,
+								 INNER_L4_EN));
 	} else if (l4_offload == HINIC3_L4_OFFLOAD_UDP) {
-		*queue_info |= SQ_CTRL_QUEUE_INFO_SET(1, UFO);
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, INNER_L4_EN);
+		*queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(1, UFO));
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1,
+								 INNER_L4_EN));
 	}
 
 	/* enable L3 calculation */
-	task->pkt_info0 |= SQ_TASK_INFO0_SET(1, INNER_L3_EN);
+	task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1, INNER_L3_EN));
 
-	*queue_info |= SQ_CTRL_QUEUE_INFO_SET(offset >> 1, PLDOFF);
+	*queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(offset >> 1, PLDOFF));
 
 	/* set MSS value */
-	*queue_info &= ~SQ_CTRL_QUEUE_INFO_MSS_MASK;
-	*queue_info |= SQ_CTRL_QUEUE_INFO_SET(mss, MSS);
+	*queue_info &= cpu_to_le32(~SQ_CTRL_QUEUE_INFO_MSS_MASK);
+	*queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(mss, MSS));
 }
 
 static __sum16 csum_magic(union hinic3_ip *ip, unsigned short proto)
@@ -284,7 +287,7 @@ static __sum16 csum_magic(union hinic3_ip *ip, unsigned short proto)
 		csum_ipv6_magic(&ip->v6->saddr, &ip->v6->daddr, 0, proto, 0);
 }
 
-static int hinic3_tso(struct hinic3_sq_task *task, u32 *queue_info,
+static int hinic3_tso(struct hinic3_sq_task *task, __le32 *queue_info,
 		      struct sk_buff *skb)
 {
 	enum hinic3_l4_offload_type l4_offload;
@@ -305,15 +308,17 @@ static int hinic3_tso(struct hinic3_sq_task *task, u32 *queue_info,
 	if (skb->encapsulation) {
 		u32 gso_type = skb_shinfo(skb)->gso_type;
 		/* L3 checksum is always enabled */
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, OUT_L3_EN);
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, TUNNEL_FLAG);
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1, OUT_L3_EN));
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1,
+								 TUNNEL_FLAG));
 
 		l4.hdr = skb_transport_header(skb);
 		ip.hdr = skb_network_header(skb);
 
 		if (gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
 			l4.udp->check = ~csum_magic(&ip, IPPROTO_UDP);
-			task->pkt_info0 |= SQ_TASK_INFO0_SET(1, OUT_L4_EN);
+			task->pkt_info0 |=
+				cpu_to_le32(SQ_TASK_INFO0_SET(1, OUT_L4_EN));
 		}
 
 		ip.hdr = skb_inner_network_header(skb);
@@ -343,13 +348,14 @@ static void hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task,
 	 * 2=select TPID2 in IPSU, 3=select TPID3 in IPSU,
 	 * 4=select TPID4 in IPSU
 	 */
-	task->vlan_offload = SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |
-			     SQ_TASK_INFO3_SET(vlan_tpid, VLAN_TPID) |
-			     SQ_TASK_INFO3_SET(1, VLAN_TAG_VALID);
+	task->vlan_offload =
+		cpu_to_le32(SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |
+			    SQ_TASK_INFO3_SET(vlan_tpid, VLAN_TPID) |
+			    SQ_TASK_INFO3_SET(1, VLAN_TAG_VALID));
 }
 
 static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
-			     u32 *queue_info, struct hinic3_txq *txq)
+			     __le32 *queue_info, struct hinic3_txq *txq)
 {
 	u32 offload = 0;
 	int tso_cs_en;
@@ -440,39 +446,41 @@ static u16 hinic3_set_wqe_combo(struct hinic3_txq *txq,
 }
 
 static void hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
-				   u32 queue_info, int nr_descs, u16 owner)
+				   __le32 queue_info, int nr_descs, u16 owner)
 {
 	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->ctrl_bd0;
 
 	if (wqe_combo->wqe_type == SQ_WQE_COMPACT_TYPE) {
 		wqe_desc->ctrl_len |=
-		    SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
-		    SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
-		    SQ_CTRL_SET(owner, OWNER);
+			cpu_to_le32(SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+				    SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+				    SQ_CTRL_SET(owner, OWNER));
 
 		/* compact wqe queue_info will transfer to chip */
 		wqe_desc->queue_info = 0;
 		return;
 	}
 
-	wqe_desc->ctrl_len |= SQ_CTRL_SET(nr_descs, BUFDESC_NUM) |
-			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
-			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
-			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
-			      SQ_CTRL_SET(owner, OWNER);
+	wqe_desc->ctrl_len |=
+		cpu_to_le32(SQ_CTRL_SET(nr_descs, BUFDESC_NUM) |
+			    SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
+			    SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+			    SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+			    SQ_CTRL_SET(owner, OWNER));
 
 	wqe_desc->queue_info = queue_info;
-	wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(1, UC);
+	wqe_desc->queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(1, UC));
 
 	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {
 		wqe_desc->queue_info |=
-		    SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_DEFAULT, MSS);
+		    cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_DEFAULT, MSS));
 	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <
 		   HINIC3_TX_MSS_MIN) {
 		/* mss should not be less than 80 */
-		wqe_desc->queue_info &= ~SQ_CTRL_QUEUE_INFO_MSS_MASK;
+		wqe_desc->queue_info &=
+		    cpu_to_le32(~SQ_CTRL_QUEUE_INFO_MSS_MASK);
 		wqe_desc->queue_info |=
-		    SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_MIN, MSS);
+		    cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_MIN, MSS));
 	}
 }
 
@@ -482,12 +490,13 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 {
 	struct hinic3_sq_wqe_combo wqe_combo = {};
 	struct hinic3_tx_info *tx_info;
-	u32 offload, queue_info = 0;
 	struct hinic3_sq_task task;
 	u16 wqebb_cnt, num_sge;
+	__le32 queue_info = 0;
 	u16 saved_wq_prod_idx;
 	u16 owner, pi = 0;
 	u8 saved_sq_owner;
+	u32 offload;
 	int err;
 
 	if (unlikely(skb->len < MIN_SKB_LEN)) {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
index 9e505cc19dd55..21dfe879a29a2 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -58,7 +58,7 @@ enum hinic3_tx_offload_type {
 #define SQ_CTRL_QUEUE_INFO_SET(val, member) \
 	FIELD_PREP(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)
 #define SQ_CTRL_QUEUE_INFO_GET(val, member) \
-	FIELD_GET(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)
+	FIELD_GET(SQ_CTRL_QUEUE_INFO_##member##_MASK, le32_to_cpu(val))
 
 #define SQ_CTRL_MAX_PLDOFF  221
 
@@ -77,17 +77,17 @@ enum hinic3_tx_offload_type {
 	FIELD_PREP(SQ_TASK_INFO3_##member##_MASK, val)
 
 struct hinic3_sq_wqe_desc {
-	u32 ctrl_len;
-	u32 queue_info;
-	u32 hi_addr;
-	u32 lo_addr;
+	__le32 ctrl_len;
+	__le32 queue_info;
+	__le32 hi_addr;
+	__le32 lo_addr;
 };
 
 struct hinic3_sq_task {
-	u32 pkt_info0;
-	u32 ip_identify;
-	u32 rsvd;
-	u32 vlan_offload;
+	__le32 pkt_info0;
+	__le32 ip_identify;
+	__le32 rsvd;
+	__le32 vlan_offload;
 };
 
 struct hinic3_sq_wqe_combo {
-- 
2.51.0


