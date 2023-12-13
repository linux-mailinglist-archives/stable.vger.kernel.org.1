Return-Path: <stable+bounces-6057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10580D886
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D17B1C214AF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6155103A;
	Mon, 11 Dec 2023 18:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2dQhDDoQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E79C8C8;
	Mon, 11 Dec 2023 18:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A451EC433C7;
	Mon, 11 Dec 2023 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320395;
	bh=BPJtaatXL0G74nhlVrMryQ654Ieb//kg0tkCQantr6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2dQhDDoQPEoBJpKIF8zQ1ZAcBBZTlflABZ/Tvrc7WRYBtBqR8sVeIwv2YKvJ6Bsz3
	 vtok3QcEbaTZWvBEnHo6n9Wa0fhA9xbptlL/PLqa5geKRkxIEVNbpM2qMjguGVLbhA
	 JPQYVM/uDELGvfVyBx7j6ay8dQZxEYHYl/AXWic0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniil Maximov <daniil31415it@gmail.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 044/194] net: atlantic: Fix NULL dereference of skb pointer in
Date: Mon, 11 Dec 2023 19:20:34 +0100
Message-ID: <20231211182038.531271828@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

From: Daniil Maximov <daniil31415it@gmail.com>

[ Upstream commit cbe860be36095e68e4e5561ab43610982fb429fd ]

If is_ptp_ring == true in the loop of __aq_ring_xdp_clean function,
then a timestamp is stored from a packet in a field of skb object,
which is not allocated at the moment of the call (skb == NULL).

Generalize aq_ptp_extract_ts and other affected functions so they don't
work with struct sk_buff*, but with struct skb_shared_hwtstamps*.

Found by Linux Verification Center (linuxtesting.org) with SVACE

Fixes: 26efaef759a1 ("net: atlantic: Implement xdp data plane")
Signed-off-by: Daniil Maximov <daniil31415it@gmail.com>
Reviewed-by: Igor Russkikh <irusskikh@marvell.com>
Link: https://lore.kernel.org/r/20231204085810.1681386-1-daniil31415it@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/aquantia/atlantic/aq_ptp.c    | 10 +++++-----
 .../net/ethernet/aquantia/atlantic/aq_ptp.h    |  4 ++--
 .../net/ethernet/aquantia/atlantic/aq_ring.c   | 18 ++++++++++++------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 80b44043e6c53..28c9b6f1a54f1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -553,17 +553,17 @@ void aq_ptp_tx_hwtstamp(struct aq_nic_s *aq_nic, u64 timestamp)
 
 /* aq_ptp_rx_hwtstamp - utility function which checks for RX time stamp
  * @adapter: pointer to adapter struct
- * @skb: particular skb to send timestamp with
+ * @shhwtstamps: particular skb_shared_hwtstamps to save timestamp
  *
  * if the timestamp is valid, we convert it into the timecounter ns
  * value, then store that result into the hwtstamps structure which
  * is passed up the network stack
  */
-static void aq_ptp_rx_hwtstamp(struct aq_ptp_s *aq_ptp, struct sk_buff *skb,
+static void aq_ptp_rx_hwtstamp(struct aq_ptp_s *aq_ptp, struct skb_shared_hwtstamps *shhwtstamps,
 			       u64 timestamp)
 {
 	timestamp -= atomic_read(&aq_ptp->offset_ingress);
-	aq_ptp_convert_to_hwtstamp(aq_ptp, skb_hwtstamps(skb), timestamp);
+	aq_ptp_convert_to_hwtstamp(aq_ptp, shhwtstamps, timestamp);
 }
 
 void aq_ptp_hwtstamp_config_get(struct aq_ptp_s *aq_ptp,
@@ -639,7 +639,7 @@ bool aq_ptp_ring(struct aq_nic_s *aq_nic, struct aq_ring_s *ring)
 	       &aq_ptp->ptp_rx == ring || &aq_ptp->hwts_rx == ring;
 }
 
-u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct sk_buff *skb, u8 *p,
+u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct skb_shared_hwtstamps *shhwtstamps, u8 *p,
 		      unsigned int len)
 {
 	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
@@ -648,7 +648,7 @@ u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct sk_buff *skb, u8 *p,
 						   p, len, &timestamp);
 
 	if (ret > 0)
-		aq_ptp_rx_hwtstamp(aq_ptp, skb, timestamp);
+		aq_ptp_rx_hwtstamp(aq_ptp, shhwtstamps, timestamp);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
index 28ccb7ca2df9e..210b723f22072 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.h
@@ -67,7 +67,7 @@ int aq_ptp_hwtstamp_config_set(struct aq_ptp_s *aq_ptp,
 /* Return either ring is belong to PTP or not*/
 bool aq_ptp_ring(struct aq_nic_s *aq_nic, struct aq_ring_s *ring);
 
-u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct sk_buff *skb, u8 *p,
+u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic, struct skb_shared_hwtstamps *shhwtstamps, u8 *p,
 		      unsigned int len);
 
 struct ptp_clock *aq_ptp_get_ptp_clock(struct aq_ptp_s *aq_ptp);
@@ -143,7 +143,7 @@ static inline bool aq_ptp_ring(struct aq_nic_s *aq_nic, struct aq_ring_s *ring)
 }
 
 static inline u16 aq_ptp_extract_ts(struct aq_nic_s *aq_nic,
-				    struct sk_buff *skb, u8 *p,
+				    struct skb_shared_hwtstamps *shhwtstamps, u8 *p,
 				    unsigned int len)
 {
 	return 0;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 2dc8d215a5918..b5a49166fa972 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -647,7 +647,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 		}
 		if (is_ptp_ring)
 			buff->len -=
-				aq_ptp_extract_ts(self->aq_nic, skb,
+				aq_ptp_extract_ts(self->aq_nic, skb_hwtstamps(skb),
 						  aq_buf_vaddr(&buff->rxdata),
 						  buff->len);
 
@@ -742,6 +742,8 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 		struct aq_ring_buff_s *buff = &rx_ring->buff_ring[rx_ring->sw_head];
 		bool is_ptp_ring = aq_ptp_ring(rx_ring->aq_nic, rx_ring);
 		struct aq_ring_buff_s *buff_ = NULL;
+		u16 ptp_hwtstamp_len = 0;
+		struct skb_shared_hwtstamps shhwtstamps;
 		struct sk_buff *skb = NULL;
 		unsigned int next_ = 0U;
 		struct xdp_buff xdp;
@@ -810,11 +812,12 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 		hard_start = page_address(buff->rxdata.page) +
 			     buff->rxdata.pg_off - rx_ring->page_offset;
 
-		if (is_ptp_ring)
-			buff->len -=
-				aq_ptp_extract_ts(rx_ring->aq_nic, skb,
-						  aq_buf_vaddr(&buff->rxdata),
-						  buff->len);
+		if (is_ptp_ring) {
+			ptp_hwtstamp_len = aq_ptp_extract_ts(rx_ring->aq_nic, &shhwtstamps,
+							     aq_buf_vaddr(&buff->rxdata),
+							     buff->len);
+			buff->len -= ptp_hwtstamp_len;
+		}
 
 		xdp_init_buff(&xdp, frame_sz, &rx_ring->xdp_rxq);
 		xdp_prepare_buff(&xdp, hard_start, rx_ring->page_offset,
@@ -834,6 +837,9 @@ static int __aq_ring_xdp_clean(struct aq_ring_s *rx_ring,
 		if (IS_ERR(skb) || !skb)
 			continue;
 
+		if (ptp_hwtstamp_len > 0)
+			*skb_hwtstamps(skb) = shhwtstamps;
+
 		if (buff->is_vlan)
 			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
 					       buff->vlan_rx_tag);
-- 
2.42.0




