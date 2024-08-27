Return-Path: <stable+bounces-70886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431D2961085
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E775C282363
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507511C5783;
	Tue, 27 Aug 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/LB3g04"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F24712E4D;
	Tue, 27 Aug 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771389; cv=none; b=dT4rx53rGrMNl0Mw6VJfFM87aEH+T1KqRKd+s5NZPS5oATtfEqUANDQU2MIp0dBJr8CO+rR+uSx2fumILKHkV/IJQPtx4+kwUN4KKq8U7jFeylccHnBdbBkAIXCh4arRCohXOH/Juhv70W3tl8E+qnf532dhBth8e3zuOhSQj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771389; c=relaxed/simple;
	bh=KkAtqAV5RQXgphYcLawo/7vTuYraKovbX/20EppJvDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob/GXn6kIETW5pvcs2sxZSrVPG8q+FjKKHfeGV10/BrL/qKyVy4wTxp9r9L53M5uP6fLCUaXyyNPT9qrW1PJ/bId7g2CHq+Ft8dEKiJLscHyvQmlBRX1bD8r6A5KPdHhNfnT9DLp1WSr8s+hGCgZrRJEzrB7T+97uNhLAP45ikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/LB3g04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEF0C4AF1A;
	Tue, 27 Aug 2024 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771388;
	bh=KkAtqAV5RQXgphYcLawo/7vTuYraKovbX/20EppJvDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/LB3g04UV0DwwxR7dtHsqTNlHtTiqRek8mrt4sNsJwrdUwchsIBcnDUa0OZYlZvf
	 kY3ze6RS5AMv3mPeencVkdmFOUNsRKx2hBAY0PbwFVLPn1roh2PfbntXfa2Phh/pwB
	 WN3+KlXBP/Ks24ELNGavy8unhKuizbRB9ggLFOCI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Luiz Capitulino <luizcap@redhat.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH 6.10 174/273] ice: fix truesize operations for PAGE_SIZE >= 8192
Date: Tue, 27 Aug 2024 16:38:18 +0200
Message-ID: <20240827143840.031601325@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit d53d4dcce69be5773e2d0878c9899ebfbf58c393 ]

When working on multi-buffer packet on arch that has PAGE_SIZE >= 8192,
truesize is calculated and stored in xdp_buff::frame_sz per each
processed Rx buffer. This means that frame_sz will contain the truesize
based on last received buffer, but commit 1dc1a7e7f410 ("ice:
Centrallize Rx buffer recycling") assumed this value will be constant
for each buffer, which breaks the page recycling scheme and mess up the
way we update the page::page_offset.

To fix this, let us work on constant truesize when PAGE_SIZE >= 8192
instead of basing this on size of a packet read from Rx descriptor. This
way we can simplify the code and avoid calculating truesize per each
received frame and on top of that when using
xdp_update_skb_shared_info(), current formula for truesize update will
be valid.

This means ice_rx_frame_truesize() can be removed altogether.
Furthermore, first call to it within ice_clean_rx_irq() for 4k PAGE_SIZE
was redundant as xdp_buff::frame_sz is initialized via xdp_init_buff()
in ice_vsi_cfg_rxq(). This should have been removed at the point where
xdp_buff struct started to be a member of ice_rx_ring and it was no
longer a stack based variable.

There are two fixes tags as my understanding is that the first one
exposed us to broken truesize and page_offset handling and then second
introduced broken skb_shared_info update in ice_{construct,build}_skb().

Reported-and-tested-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/netdev/8f9e2a5c-fd30-4206-9311-946a06d031bb@redhat.com/
Fixes: 1dc1a7e7f410 ("ice: Centrallize Rx buffer recycling")
Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 21 ++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c | 33 -----------------------
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1facf179a96fd..f448d3a845642 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -512,6 +512,25 @@ static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
 	xsk_pool_fill_cb(ring->xsk_pool, &desc);
 }
 
+/**
+ * ice_get_frame_sz - calculate xdp_buff::frame_sz
+ * @rx_ring: the ring being configured
+ *
+ * Return frame size based on underlying PAGE_SIZE
+ */
+static unsigned int ice_get_frame_sz(struct ice_rx_ring *rx_ring)
+{
+	unsigned int frame_sz;
+
+#if (PAGE_SIZE >= 8192)
+	frame_sz = rx_ring->rx_buf_len;
+#else
+	frame_sz = ice_rx_pg_size(rx_ring) / 2;
+#endif
+
+	return frame_sz;
+}
+
 /**
  * ice_vsi_cfg_rxq - Configure an Rx queue
  * @ring: the ring being configured
@@ -576,7 +595,7 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		}
 	}
 
-	xdp_init_buff(&ring->xdp, ice_rx_pg_size(ring) / 2, &ring->xdp_rxq);
+	xdp_init_buff(&ring->xdp, ice_get_frame_sz(ring), &ring->xdp_rxq);
 	ring->xdp.data = NULL;
 	ring->xdp_ext.pkt_ctx = &ring->pkt_ctx;
 	err = ice_setup_rx_ctx(ring);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4b690952bb403..c9bc3f1add5d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -521,30 +521,6 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
 	return -ENOMEM;
 }
 
-/**
- * ice_rx_frame_truesize
- * @rx_ring: ptr to Rx ring
- * @size: size
- *
- * calculate the truesize with taking into the account PAGE_SIZE of
- * underlying arch
- */
-static unsigned int
-ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
-{
-	unsigned int truesize;
-
-#if (PAGE_SIZE < 8192)
-	truesize = ice_rx_pg_size(rx_ring) / 2; /* Must be power-of-2 */
-#else
-	truesize = rx_ring->rx_offset ?
-		SKB_DATA_ALIGN(rx_ring->rx_offset + size) +
-		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
-		SKB_DATA_ALIGN(size);
-#endif
-	return truesize;
-}
-
 /**
  * ice_run_xdp - Executes an XDP program on initialized xdp_buff
  * @rx_ring: Rx ring
@@ -1154,11 +1130,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	bool failure;
 	u32 first;
 
-	/* Frame size depend on rx_ring setup when PAGE_SIZE=4K */
-#if (PAGE_SIZE < 8192)
-	xdp->frame_sz = ice_rx_frame_truesize(rx_ring, 0);
-#endif
-
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	if (xdp_prog) {
 		xdp_ring = rx_ring->xdp_ring;
@@ -1217,10 +1188,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
 				     offset;
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
-#if (PAGE_SIZE > 4096)
-			/* At larger PAGE_SIZE, frame_sz depend on len size */
-			xdp->frame_sz = ice_rx_frame_truesize(rx_ring, size);
-#endif
 			xdp_buff_clear_frags_flag(xdp);
 		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
 			break;
-- 
2.43.0




