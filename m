Return-Path: <stable+bounces-10769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7682CB8A
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 11:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C21282F9B
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58E1869;
	Sat, 13 Jan 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v8q/PyMV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0870D1EF1C;
	Sat, 13 Jan 2024 10:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0782EC433F1;
	Sat, 13 Jan 2024 10:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705140049;
	bh=xYS+SN3+N5TgR45efSXVxpQDHKmISBY17gZY/E/NvLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v8q/PyMVvRnSBU2Jl6hEgS5IsJaDtVwYcMjqX8pRnnEty4Id8aNJQmMSgiUHz8mzH
	 wgPfB4E2ApXIZ1i+Iv9XsIKH4OBgBaWM/n7MnQ4OErFhnuBnsHhB+QjdzqC66Z7HQf
	 nfIjcPmbqPPMOxwxvVhGARNnssV0DvPImMjjED+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 37/59] octeontx2-af: Always configure NIX TX link credits based on max frame size
Date: Sat, 13 Jan 2024 10:50:08 +0100
Message-ID: <20240113094210.449259246@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
References: <20240113094209.301672391@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naveen Mamindlapalli <naveenm@marvell.com>

[ Upstream commit a0d9528f6daf7fe8de217fa80a94d2989d2a57a7 ]

Currently the NIX TX link credits are initialized based on the max frame
size that can be transmitted on a link but when the MTU is changed, the
NIX TX link credits are reprogrammed by the SW based on the new MTU value.
Since SMQ max packet length is programmed to max frame size by default,
there is a chance that NIX TX may stall while sending a max frame sized
packet on the link with insufficient credits to send the packet all at
once. This patch avoids stall issue by not changing the link credits
dynamically when the MTU is changed.

Fixes: 1c74b89171c3 ("octeontx2-af: Wait for TX link idle for credits change")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 110 +-----------------
 1 file changed, 3 insertions(+), 107 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 874248499ef9a..cb082f5e6cda9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3877,90 +3877,18 @@ static void nix_find_link_frs(struct rvu *rvu,
 		req->minlen = minlen;
 }
 
-static int
-nix_config_link_credits(struct rvu *rvu, int blkaddr, int link,
-			u16 pcifunc, u64 tx_credits)
-{
-	struct rvu_hwinfo *hw = rvu->hw;
-	int pf = rvu_get_pf(pcifunc);
-	u8 cgx_id = 0, lmac_id = 0;
-	unsigned long poll_tmo;
-	bool restore_tx_en = 0;
-	struct nix_hw *nix_hw;
-	u64 cfg, sw_xoff = 0;
-	u32 schq = 0;
-	u32 credits;
-	int rc;
-
-	nix_hw = get_nix_hw(rvu->hw, blkaddr);
-	if (!nix_hw)
-		return NIX_AF_ERR_INVALID_NIXBLK;
-
-	if (tx_credits == nix_hw->tx_credits[link])
-		return 0;
-
-	/* Enable cgx tx if disabled for credits to be back */
-	if (is_pf_cgxmapped(rvu, pf)) {
-		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
-		restore_tx_en = !rvu_cgx_config_tx(rvu_cgx_pdata(cgx_id, rvu),
-						    lmac_id, true);
-	}
-
-	mutex_lock(&rvu->rsrc_lock);
-	/* Disable new traffic to link */
-	if (hw->cap.nix_shaping) {
-		schq = nix_get_tx_link(rvu, pcifunc);
-		sw_xoff = rvu_read64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(schq));
-		rvu_write64(rvu, blkaddr,
-			    NIX_AF_TL1X_SW_XOFF(schq), BIT_ULL(0));
-	}
-
-	rc = NIX_AF_ERR_LINK_CREDITS;
-	poll_tmo = jiffies + usecs_to_jiffies(200000);
-	/* Wait for credits to return */
-	do {
-		if (time_after(jiffies, poll_tmo))
-			goto exit;
-		usleep_range(100, 200);
-
-		cfg = rvu_read64(rvu, blkaddr,
-				 NIX_AF_TX_LINKX_NORM_CREDIT(link));
-		credits = (cfg >> 12) & 0xFFFFFULL;
-	} while (credits != nix_hw->tx_credits[link]);
-
-	cfg &= ~(0xFFFFFULL << 12);
-	cfg |= (tx_credits << 12);
-	rvu_write64(rvu, blkaddr, NIX_AF_TX_LINKX_NORM_CREDIT(link), cfg);
-	rc = 0;
-
-	nix_hw->tx_credits[link] = tx_credits;
-
-exit:
-	/* Enable traffic back */
-	if (hw->cap.nix_shaping && !sw_xoff)
-		rvu_write64(rvu, blkaddr, NIX_AF_TL1X_SW_XOFF(schq), 0);
-
-	/* Restore state of cgx tx */
-	if (restore_tx_en)
-		rvu_cgx_config_tx(rvu_cgx_pdata(cgx_id, rvu), lmac_id, false);
-
-	mutex_unlock(&rvu->rsrc_lock);
-	return rc;
-}
-
 int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 				    struct msg_rsp *rsp)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = req->hdr.pcifunc;
 	int pf = rvu_get_pf(pcifunc);
-	int blkaddr, schq, link = -1;
-	struct nix_txsch *txsch;
-	u64 cfg, lmac_fifo_len;
+	int blkaddr, link = -1;
 	struct nix_hw *nix_hw;
 	struct rvu_pfvf *pfvf;
 	u8 cgx = 0, lmac = 0;
 	u16 max_mtu;
+	u64 cfg;
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 	if (blkaddr < 0)
@@ -3981,25 +3909,6 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (req->update_minlen && req->minlen < NIC_HW_MIN_FRS)
 		return NIX_AF_ERR_FRS_INVALID;
 
-	/* Check if requester wants to update SMQ's */
-	if (!req->update_smq)
-		goto rx_frscfg;
-
-	/* Update min/maxlen in each of the SMQ attached to this PF/VF */
-	txsch = &nix_hw->txsch[NIX_TXSCH_LVL_SMQ];
-	mutex_lock(&rvu->rsrc_lock);
-	for (schq = 0; schq < txsch->schq.max; schq++) {
-		if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
-			continue;
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(schq));
-		cfg = (cfg & ~(0xFFFFULL << 8)) | ((u64)req->maxlen << 8);
-		if (req->update_minlen)
-			cfg = (cfg & ~0x7FULL) | ((u64)req->minlen & 0x7F);
-		rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(schq), cfg);
-	}
-	mutex_unlock(&rvu->rsrc_lock);
-
-rx_frscfg:
 	/* Check if config is for SDP link */
 	if (req->sdp_link) {
 		if (!hw->sdp_links)
@@ -4022,7 +3931,6 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 	if (link < 0)
 		return NIX_AF_ERR_RX_LINK_INVALID;
 
-
 linkcfg:
 	nix_find_link_frs(rvu, req, pcifunc);
 
@@ -4032,19 +3940,7 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
 		cfg = (cfg & ~0xFFFFULL) | req->minlen;
 	rvu_write64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link), cfg);
 
-	if (req->sdp_link || pf == 0)
-		return 0;
-
-	/* Update transmit credits for CGX links */
-	lmac_fifo_len = rvu_cgx_get_lmac_fifolen(rvu, cgx, lmac);
-	if (!lmac_fifo_len) {
-		dev_err(rvu->dev,
-			"%s: Failed to get CGX/RPM%d:LMAC%d FIFO size\n",
-			__func__, cgx, lmac);
-		return 0;
-	}
-	return nix_config_link_credits(rvu, blkaddr, link, pcifunc,
-				       (lmac_fifo_len - req->maxlen) / 16);
+	return 0;
 }
 
 int rvu_mbox_handler_nix_set_rx_cfg(struct rvu *rvu, struct nix_rx_cfg *req,
-- 
2.43.0




