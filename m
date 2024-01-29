Return-Path: <stable+bounces-16642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F21840DD0
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5057E285D69
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4EC15AACA;
	Mon, 29 Jan 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wVuOd9Je"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCDF158D76;
	Mon, 29 Jan 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548171; cv=none; b=b/S7v2U+TO/ov2pcL3rSty5p1LbHOXwgA4auZOeGsc9zKbPoqyzQvqFDHuv//7IU731LIe0MMs0p4iA2I62IPRujbstC6l6sHqm5dkZ9wKLTZ0cmK+GitNMJJcVaELXK2llfNMPYHDFnVK5jtQYaCHliQvG65v7YJrDjD4XkOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548171; c=relaxed/simple;
	bh=djZeChmOCINAlI0+Frk7G/5FHMbyWXjNFlCTe3ThTFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDsvA0bku2eZaVIuARnUuYEw7vEJ+oL6PGJy8C6IsqyMVysJN6ILmZepfbuRCtQ/7UnvMm+/OHPvnwZ3pOkOsplfdwpP4PzcjKnMuOvukjmEjCJAQVBx+5fLi9J1zNwIxTXMn2kpd0qvsGan0fuZZ5PKj+vg1/jdY0kXP1vdtb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wVuOd9Je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52EEC43394;
	Mon, 29 Jan 2024 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548170;
	bh=djZeChmOCINAlI0+Frk7G/5FHMbyWXjNFlCTe3ThTFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wVuOd9JeHxpAE0ZU/UXrPusSnBqdCBmLal03DRo+tZuwv5eysRX32xfUZ0VisQIDK
	 owj4rk8PQSOmK+NlxZEeb5+ocNOV5GLjqlrEjNfBYjarJ3aRr5eG3DS+CZwMVtE6jV
	 ReEZAuZCTHvTjMugmKy7dzcus9mQ+NGfXNIHARoc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 215/346] i40e: set xdp_rxq_info::frag_size
Date: Mon, 29 Jan 2024 09:04:06 -0800
Message-ID: <20240129170022.704744579@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit a045d2f2d03d23e7db6772dd83e0ba2705dfad93 ]

i40e support XDP multi-buffer so it is supposed to use
__xdp_rxq_info_reg() instead of xdp_rxq_info_reg() and set the
frag_size. It can not be simply converted at existing callsite because
rx_buf_len could be un-initialized, so let us register xdp_rxq_info
within i40e_configure_rx_ring(), which happen to be called with already
initialized rx_buf_len value.

Commit 5180ff1364bc ("i40e: use int for i40e_status") converted 'err' to
int, so two variables to deal with return codes are not needed within
i40e_configure_rx_ring(). Remove 'ret' and use 'err' to handle status
from xdp_rxq_info registration.

Fixes: e213ced19bef ("i40e: add support for XDP multi-buffer Rx")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Link: https://lore.kernel.org/r/20240124191602.566724-11-maciej.fijalkowski@intel.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 40 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  9 -----
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d5519af34657..f97a63812141 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3588,40 +3588,48 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	struct i40e_hmc_obj_rxq rx_ctx;
 	int err = 0;
 	bool ok;
-	int ret;
 
 	bitmap_zero(ring->state, __I40E_RING_STATE_NBITS);
 
 	/* clear the context structure first */
 	memset(&rx_ctx, 0, sizeof(rx_ctx));
 
-	if (ring->vsi->type == I40E_VSI_MAIN)
-		xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
+	ring->rx_buf_len = vsi->rx_buf_len;
+
+	/* XDP RX-queue info only needed for RX rings exposed to XDP */
+	if (ring->vsi->type != I40E_VSI_MAIN)
+		goto skip;
+
+	if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
+		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+					 ring->queue_index,
+					 ring->q_vector->napi.napi_id,
+					 ring->rx_buf_len);
+		if (err)
+			return err;
+	}
 
 	ring->xsk_pool = i40e_xsk_pool(ring);
 	if (ring->xsk_pool) {
-		ring->rx_buf_len =
-		  xsk_pool_get_rx_frame_size(ring->xsk_pool);
-		ret = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+		ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
+		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 						 MEM_TYPE_XSK_BUFF_POOL,
 						 NULL);
-		if (ret)
-			return ret;
+		if (err)
+			return err;
 		dev_info(&vsi->back->pdev->dev,
 			 "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 			 ring->queue_index);
 
 	} else {
-		ring->rx_buf_len = vsi->rx_buf_len;
-		if (ring->vsi->type == I40E_VSI_MAIN) {
-			ret = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-							 MEM_TYPE_PAGE_SHARED,
-							 NULL);
-			if (ret)
-				return ret;
-		}
+		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						 MEM_TYPE_PAGE_SHARED,
+						 NULL);
+		if (err)
+			return err;
 	}
 
+skip:
 	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 35e1bb6fe5e1..071ef309a3a4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1555,7 +1555,6 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring)
 int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 {
 	struct device *dev = rx_ring->dev;
-	int err;
 
 	u64_stats_init(&rx_ring->syncp);
 
@@ -1576,14 +1575,6 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 	rx_ring->next_to_process = 0;
 	rx_ring->next_to_use = 0;
 
-	/* XDP RX-queue info only needed for RX rings exposed to XDP */
-	if (rx_ring->vsi->type == I40E_VSI_MAIN) {
-		err = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
-				       rx_ring->queue_index, rx_ring->q_vector->napi.napi_id);
-		if (err < 0)
-			return err;
-	}
-
 	rx_ring->xdp_prog = rx_ring->vsi->xdp_prog;
 
 	rx_ring->rx_bi =
-- 
2.43.0




