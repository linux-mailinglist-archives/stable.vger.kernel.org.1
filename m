Return-Path: <stable+bounces-17868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DF884806F
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3972A28BEFB
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25311FBF2;
	Sat,  3 Feb 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfqW62Uv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF4FC11;
	Sat,  3 Feb 2024 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933374; cv=none; b=E/Jy4QBZgcCqjTY42HaBrciioaGzL/DrIMmtbMitzWDNsN6pMzD1DUFrftbjCexnYCLuy1VvD7rZA49trvTCz1LLSg83L1akVb9ZLCeOETX1BZH2FS4diwbKb6UEgaICDk0/BqI7JYt7I4Mcd/turtklPTaMfHtBK9bUUo/Ldww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933374; c=relaxed/simple;
	bh=BED8jlywTzIcuSlGPtwTH67rVNQlI+9IKqyU0A/16KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwbydzwPWhQaBPmG3uwCrDUo9UDSVe+/7F4AO+epY5BBYJelCCndPHsqfNwYEDDDotG34NU7Xewl/YnIiVE0hVtQwbwZI0CGBoVNhaPa/TSt7jK3TSJqCEJKTHZjONC5pjp5dkRqGvws1dGg8N7LKYXuQj78YqrvPOmWDdIaDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfqW62Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DD2C43390;
	Sat,  3 Feb 2024 04:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933374;
	bh=BED8jlywTzIcuSlGPtwTH67rVNQlI+9IKqyU0A/16KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfqW62UvodAWnSWFEEo5XV9JxjhzSJMKkka5rKKBnkBV1R7O6OVPxP329WEQYEIhE
	 MO8h5UCKlf7RdS2TOJC1NrbBc50Z1LKTH74HZ2tpcRUs9F0T3WcvP+NIXHmIXI7P9Y
	 CX8fy2ECqMSqvD0HsWQiQdc9Ekr+qEaNZbo3394M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Igor Russkikh <irusskikh@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 084/219] net: atlantic: eliminate double free in error handling logic
Date: Fri,  2 Feb 2024 20:04:17 -0800
Message-ID: <20240203035328.993364041@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

From: Igor Russkikh <irusskikh@marvell.com>

[ Upstream commit b3cb7a830a24527877b0bc900b9bd74a96aea928 ]

Driver has a logic leak in ring data allocation/free,
where aq_ring_free could be called multiple times on same ring,
if system is under stress and got memory allocation error.

Ring pointer was used as an indicator of failure, but this is
not correct since only ring data is allocated/deallocated.
Ring itself is an array member.

Changing ring allocation functions to return error code directly.
This simplifies error handling and eliminates aq_ring_free
on higher layer.

Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Link: https://lore.kernel.org/r/20231213095044.23146-1-irusskikh@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   | 28 +++------
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 61 +++++--------------
 .../net/ethernet/aquantia/atlantic/aq_ring.h  | 22 +++----
 .../net/ethernet/aquantia/atlantic/aq_vec.c   | 23 +++----
 4 files changed, 47 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 28c9b6f1a54f..abd4832e4ed2 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -953,8 +953,6 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 {
 	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
 	unsigned int tx_ring_idx, rx_ring_idx;
-	struct aq_ring_s *hwts;
-	struct aq_ring_s *ring;
 	int err;
 
 	if (!aq_ptp)
@@ -962,29 +960,23 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 
 	tx_ring_idx = aq_ptp_ring_idx(aq_nic->aq_nic_cfg.tc_mode);
 
-	ring = aq_ring_tx_alloc(&aq_ptp->ptp_tx, aq_nic,
-				tx_ring_idx, &aq_nic->aq_nic_cfg);
-	if (!ring) {
-		err = -ENOMEM;
+	err = aq_ring_tx_alloc(&aq_ptp->ptp_tx, aq_nic,
+			       tx_ring_idx, &aq_nic->aq_nic_cfg);
+	if (err)
 		goto err_exit;
-	}
 
 	rx_ring_idx = aq_ptp_ring_idx(aq_nic->aq_nic_cfg.tc_mode);
 
-	ring = aq_ring_rx_alloc(&aq_ptp->ptp_rx, aq_nic,
-				rx_ring_idx, &aq_nic->aq_nic_cfg);
-	if (!ring) {
-		err = -ENOMEM;
+	err = aq_ring_rx_alloc(&aq_ptp->ptp_rx, aq_nic,
+			       rx_ring_idx, &aq_nic->aq_nic_cfg);
+	if (err)
 		goto err_exit_ptp_tx;
-	}
 
-	hwts = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
-				     aq_nic->aq_nic_cfg.rxds,
-				     aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
-	if (!hwts) {
-		err = -ENOMEM;
+	err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
+				    aq_nic->aq_nic_cfg.rxds,
+				    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
+	if (err)
 		goto err_exit_ptp_rx;
-	}
 
 	err = aq_ptp_skb_ring_init(&aq_ptp->skb_ring, aq_nic->aq_nic_cfg.rxds);
 	if (err != 0) {
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 4d9d7d1edb9b..9c314fe14ab6 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -132,8 +132,8 @@ static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s *rxbuf)
 	return 0;
 }
 
-static struct aq_ring_s *aq_ring_alloc(struct aq_ring_s *self,
-				       struct aq_nic_s *aq_nic)
+static int aq_ring_alloc(struct aq_ring_s *self,
+			 struct aq_nic_s *aq_nic)
 {
 	int err = 0;
 
@@ -156,46 +156,29 @@ static struct aq_ring_s *aq_ring_alloc(struct aq_ring_s *self,
 err_exit:
 	if (err < 0) {
 		aq_ring_free(self);
-		self = NULL;
 	}
 
-	return self;
+	return err;
 }
 
-struct aq_ring_s *aq_ring_tx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg)
+int aq_ring_tx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg)
 {
-	int err = 0;
-
 	self->aq_nic = aq_nic;
 	self->idx = idx;
 	self->size = aq_nic_cfg->txds;
 	self->dx_size = aq_nic_cfg->aq_hw_caps->txd_size;
 
-	self = aq_ring_alloc(self, aq_nic);
-	if (!self) {
-		err = -ENOMEM;
-		goto err_exit;
-	}
-
-err_exit:
-	if (err < 0) {
-		aq_ring_free(self);
-		self = NULL;
-	}
-
-	return self;
+	return aq_ring_alloc(self, aq_nic);
 }
 
-struct aq_ring_s *aq_ring_rx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg)
+int aq_ring_rx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg)
 {
-	int err = 0;
-
 	self->aq_nic = aq_nic;
 	self->idx = idx;
 	self->size = aq_nic_cfg->rxds;
@@ -217,22 +200,10 @@ struct aq_ring_s *aq_ring_rx_alloc(struct aq_ring_s *self,
 		self->tail_size = 0;
 	}
 
-	self = aq_ring_alloc(self, aq_nic);
-	if (!self) {
-		err = -ENOMEM;
-		goto err_exit;
-	}
-
-err_exit:
-	if (err < 0) {
-		aq_ring_free(self);
-		self = NULL;
-	}
-
-	return self;
+	return aq_ring_alloc(self, aq_nic);
 }
 
-struct aq_ring_s *
+int
 aq_ring_hwts_rx_alloc(struct aq_ring_s *self, struct aq_nic_s *aq_nic,
 		      unsigned int idx, unsigned int size, unsigned int dx_size)
 {
@@ -250,10 +221,10 @@ aq_ring_hwts_rx_alloc(struct aq_ring_s *self, struct aq_nic_s *aq_nic,
 					   GFP_KERNEL);
 	if (!self->dx_ring) {
 		aq_ring_free(self);
-		return NULL;
+		return -ENOMEM;
 	}
 
-	return self;
+	return 0;
 }
 
 int aq_ring_init(struct aq_ring_s *self, const enum atl_ring_type ring_type)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 0a6c34438c1d..52847310740a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -183,14 +183,14 @@ static inline unsigned int aq_ring_avail_dx(struct aq_ring_s *self)
 		self->sw_head - self->sw_tail - 1);
 }
 
-struct aq_ring_s *aq_ring_tx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg);
-struct aq_ring_s *aq_ring_rx_alloc(struct aq_ring_s *self,
-				   struct aq_nic_s *aq_nic,
-				   unsigned int idx,
-				   struct aq_nic_cfg_s *aq_nic_cfg);
+int aq_ring_tx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg);
+int aq_ring_rx_alloc(struct aq_ring_s *self,
+		     struct aq_nic_s *aq_nic,
+		     unsigned int idx,
+		     struct aq_nic_cfg_s *aq_nic_cfg);
 
 int aq_ring_init(struct aq_ring_s *self, const enum atl_ring_type ring_type);
 void aq_ring_rx_deinit(struct aq_ring_s *self);
@@ -207,9 +207,9 @@ int aq_ring_rx_clean(struct aq_ring_s *self,
 		     int budget);
 int aq_ring_rx_fill(struct aq_ring_s *self);
 
-struct aq_ring_s *aq_ring_hwts_rx_alloc(struct aq_ring_s *self,
-		struct aq_nic_s *aq_nic, unsigned int idx,
-		unsigned int size, unsigned int dx_size);
+int aq_ring_hwts_rx_alloc(struct aq_ring_s *self,
+			  struct aq_nic_s *aq_nic, unsigned int idx,
+			  unsigned int size, unsigned int dx_size);
 void aq_ring_hwts_rx_clean(struct aq_ring_s *self, struct aq_nic_s *aq_nic);
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index f5db1c44e9b9..9769ab4f9bef 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -136,35 +136,32 @@ int aq_vec_ring_alloc(struct aq_vec_s *self, struct aq_nic_s *aq_nic,
 		const unsigned int idx_ring = AQ_NIC_CFG_TCVEC2RING(aq_nic_cfg,
 								    i, idx);
 
-		ring = aq_ring_tx_alloc(&self->ring[i][AQ_VEC_TX_ID], aq_nic,
-					idx_ring, aq_nic_cfg);
-		if (!ring) {
-			err = -ENOMEM;
+		ring = &self->ring[i][AQ_VEC_TX_ID];
+		err = aq_ring_tx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
+		if (err)
 			goto err_exit;
-		}
 
 		++self->tx_rings;
 
 		aq_nic_set_tx_ring(aq_nic, idx_ring, ring);
 
-		if (xdp_rxq_info_reg(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq,
+		ring = &self->ring[i][AQ_VEC_RX_ID];
+		if (xdp_rxq_info_reg(&ring->xdp_rxq,
 				     aq_nic->ndev, idx,
 				     self->napi.napi_id) < 0) {
 			err = -ENOMEM;
 			goto err_exit;
 		}
-		if (xdp_rxq_info_reg_mem_model(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq,
+		if (xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 					       MEM_TYPE_PAGE_SHARED, NULL) < 0) {
-			xdp_rxq_info_unreg(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq);
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 			err = -ENOMEM;
 			goto err_exit;
 		}
 
-		ring = aq_ring_rx_alloc(&self->ring[i][AQ_VEC_RX_ID], aq_nic,
-					idx_ring, aq_nic_cfg);
-		if (!ring) {
-			xdp_rxq_info_unreg(&self->ring[i][AQ_VEC_RX_ID].xdp_rxq);
-			err = -ENOMEM;
+		err = aq_ring_rx_alloc(ring, aq_nic, idx_ring, aq_nic_cfg);
+		if (err) {
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 			goto err_exit;
 		}
 
-- 
2.43.0




