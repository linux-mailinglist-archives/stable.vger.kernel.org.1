Return-Path: <stable+bounces-76254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9820197A0CB
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F371281D05
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74181547F5;
	Mon, 16 Sep 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+gj6Ugo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6185A95E;
	Mon, 16 Sep 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488068; cv=none; b=PQLRXr21Ad2ifvZh6UIVwgJ9WjCFzoBtWn7+atjnHRFQ2Ry7HWdzn7s8lfC1QvTc3eaE/Y9P/8Lm+5wYKZoejiGOYTY9mbh6PpFp25qjn4Un/DLSeA4a4VTQxI3vlksmlqgG11wS8ix4z7gPlwdUzZPyHHbX1z49klXobVV/47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488068; c=relaxed/simple;
	bh=k8AvPyirFUnLgoTafFz2YtnkI9aiMlwXnm7aWjqEsV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP2Mv7AIe00baG66RgdWoKb8XfgMwmK5vNZDBk4wsD/Kr2FMYCQjdwcFyXjPCt097psrDKdlZ+xY8+AbGN8ah5AAhVxlgQXFRsYpiksGE7bimnkGmh3Sw0ReBs+zi5IYb0WUexEWPWrB52kDHULL6x4dlBG48Gx8eZlwouSkkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S+gj6Ugo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E80EC4CEC7;
	Mon, 16 Sep 2024 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488068;
	bh=k8AvPyirFUnLgoTafFz2YtnkI9aiMlwXnm7aWjqEsV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+gj6UgosJISujsMmbui/EwL+ma1JN+j/2Ldk4JXqO0inwc3ZrJeJqFVjuPrO8YMt
	 NJIoJyDd8fIxqUXJjrughWC6zyk135+E2zediFdXYnvzQjH72kSOEOgPxv0O57ZFfL
	 T3FbldWcYZ7sYPr69whtjLUTZcncn5opODZG5juc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 48/63] octeontx2-af: Set XOFF on other child transmit schedulers during SMQ flush
Date: Mon, 16 Sep 2024 13:44:27 +0200
Message-ID: <20240916114222.764730280@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114221.021192667@linuxfoundation.org>
References: <20240916114221.021192667@linuxfoundation.org>
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

From: Naveen Mamindlapalli <naveenm@marvell.com>

[ Upstream commit e18aab0470d8f6259be82282ffb3fdcfeaeff6c3 ]

When multiple transmit scheduler queues feed a TL1 transmit link, the
SMQ flush initiated on a low priority queue might get stuck when a high
priority queue fully subscribes the transmit link. This inturn effects
interface teardown. To avoid this, temporarily XOFF all TL1's other
immediate child transmit scheduler queues and also clear any rate limit
configuration on all the scheduler queues in SMQ(flush) hierarchy.

Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  16 +++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 130 +++++++++++++++++-
 2 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a3ae21398ca7..ee64cb077103 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -286,6 +286,22 @@ struct nix_mark_format {
 	u32 *cfg;
 };
 
+/* smq(flush) to tl1 cir/pir info */
+struct nix_smq_tree_ctx {
+	u64 cir_off;
+	u64 cir_val;
+	u64 pir_off;
+	u64 pir_val;
+};
+
+/* smq flush context */
+struct nix_smq_flush_ctx {
+	int smq;
+	u16 tl1_schq;
+	u16 tl2_schq;
+	struct nix_smq_tree_ctx smq_tree_ctx[NIX_TXSCH_LVL_CNT];
+};
+
 struct npc_pkind {
 	struct rsrc_bmap rsrc;
 	u32	*pfchan_map;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index ef526408b0bd..7d7e84dedb54 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2121,9 +2121,121 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 	return rc;
 }
 
+static void nix_smq_flush_fill_ctx(struct rvu *rvu, int blkaddr, int smq,
+				   struct nix_smq_flush_ctx *smq_flush_ctx)
+{
+	struct nix_smq_tree_ctx *smq_tree_ctx;
+	u64 parent_off, regval;
+	u16 schq;
+	int lvl;
+
+	smq_flush_ctx->smq = smq;
+
+	schq = smq;
+	for (lvl = NIX_TXSCH_LVL_SMQ; lvl <= NIX_TXSCH_LVL_TL1; lvl++) {
+		smq_tree_ctx = &smq_flush_ctx->smq_tree_ctx[lvl];
+		if (lvl == NIX_TXSCH_LVL_TL1) {
+			smq_flush_ctx->tl1_schq = schq;
+			smq_tree_ctx->cir_off = NIX_AF_TL1X_CIR(schq);
+			smq_tree_ctx->pir_off = 0;
+			smq_tree_ctx->pir_val = 0;
+			parent_off = 0;
+		} else if (lvl == NIX_TXSCH_LVL_TL2) {
+			smq_flush_ctx->tl2_schq = schq;
+			smq_tree_ctx->cir_off = NIX_AF_TL2X_CIR(schq);
+			smq_tree_ctx->pir_off = NIX_AF_TL2X_PIR(schq);
+			parent_off = NIX_AF_TL2X_PARENT(schq);
+		} else if (lvl == NIX_TXSCH_LVL_TL3) {
+			smq_tree_ctx->cir_off = NIX_AF_TL3X_CIR(schq);
+			smq_tree_ctx->pir_off = NIX_AF_TL3X_PIR(schq);
+			parent_off = NIX_AF_TL3X_PARENT(schq);
+		} else if (lvl == NIX_TXSCH_LVL_TL4) {
+			smq_tree_ctx->cir_off = NIX_AF_TL4X_CIR(schq);
+			smq_tree_ctx->pir_off = NIX_AF_TL4X_PIR(schq);
+			parent_off = NIX_AF_TL4X_PARENT(schq);
+		} else if (lvl == NIX_TXSCH_LVL_MDQ) {
+			smq_tree_ctx->cir_off = NIX_AF_MDQX_CIR(schq);
+			smq_tree_ctx->pir_off = NIX_AF_MDQX_PIR(schq);
+			parent_off = NIX_AF_MDQX_PARENT(schq);
+		}
+		/* save cir/pir register values */
+		smq_tree_ctx->cir_val = rvu_read64(rvu, blkaddr, smq_tree_ctx->cir_off);
+		if (smq_tree_ctx->pir_off)
+			smq_tree_ctx->pir_val = rvu_read64(rvu, blkaddr, smq_tree_ctx->pir_off);
+
+		/* get parent txsch node */
+		if (parent_off) {
+			regval = rvu_read64(rvu, blkaddr, parent_off);
+			schq = (regval >> 16) & 0x1FF;
+		}
+	}
+}
+
+static void nix_smq_flush_enadis_xoff(struct rvu *rvu, int blkaddr,
+				      struct nix_smq_flush_ctx *smq_flush_ctx, bool enable)
+{
+	struct nix_txsch *txsch;
+	struct nix_hw *nix_hw;
+	u64 regoff;
+	int tl2;
+
+	nix_hw = get_nix_hw(rvu->hw, blkaddr);
+	if (!nix_hw)
+		return;
+
+	/* loop through all TL2s with matching PF_FUNC */
+	txsch = &nix_hw->txsch[NIX_TXSCH_LVL_TL2];
+	for (tl2 = 0; tl2 < txsch->schq.max; tl2++) {
+		/* skip the smq(flush) TL2 */
+		if (tl2 == smq_flush_ctx->tl2_schq)
+			continue;
+		/* skip unused TL2s */
+		if (TXSCH_MAP_FLAGS(txsch->pfvf_map[tl2]) & NIX_TXSCHQ_FREE)
+			continue;
+		/* skip if PF_FUNC doesn't match */
+		if ((TXSCH_MAP_FUNC(txsch->pfvf_map[tl2]) & ~RVU_PFVF_FUNC_MASK) !=
+		    (TXSCH_MAP_FUNC(txsch->pfvf_map[smq_flush_ctx->tl2_schq] &
+				    ~RVU_PFVF_FUNC_MASK)))
+			continue;
+		/* enable/disable XOFF */
+		regoff = NIX_AF_TL2X_SW_XOFF(tl2);
+		if (enable)
+			rvu_write64(rvu, blkaddr, regoff, 0x1);
+		else
+			rvu_write64(rvu, blkaddr, regoff, 0x0);
+	}
+}
+
+static void nix_smq_flush_enadis_rate(struct rvu *rvu, int blkaddr,
+				      struct nix_smq_flush_ctx *smq_flush_ctx, bool enable)
+{
+	u64 cir_off, pir_off, cir_val, pir_val;
+	struct nix_smq_tree_ctx *smq_tree_ctx;
+	int lvl;
+
+	for (lvl = NIX_TXSCH_LVL_SMQ; lvl <= NIX_TXSCH_LVL_TL1; lvl++) {
+		smq_tree_ctx = &smq_flush_ctx->smq_tree_ctx[lvl];
+		cir_off = smq_tree_ctx->cir_off;
+		cir_val = smq_tree_ctx->cir_val;
+		pir_off = smq_tree_ctx->pir_off;
+		pir_val = smq_tree_ctx->pir_val;
+
+		if (enable) {
+			rvu_write64(rvu, blkaddr, cir_off, cir_val);
+			if (lvl != NIX_TXSCH_LVL_TL1)
+				rvu_write64(rvu, blkaddr, pir_off, pir_val);
+		} else {
+			rvu_write64(rvu, blkaddr, cir_off, 0x0);
+			if (lvl != NIX_TXSCH_LVL_TL1)
+				rvu_write64(rvu, blkaddr, pir_off, 0x0);
+		}
+	}
+}
+
 static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 			 int smq, u16 pcifunc, int nixlf)
 {
+	struct nix_smq_flush_ctx *smq_flush_ctx;
 	int pf = rvu_get_pf(pcifunc);
 	u8 cgx_id = 0, lmac_id = 0;
 	int err, restore_tx_en = 0;
@@ -2136,6 +2248,14 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 						   lmac_id, true);
 	}
 
+	/* XOFF all TL2s whose parent TL1 matches SMQ tree TL1 */
+	smq_flush_ctx = kzalloc(sizeof(*smq_flush_ctx), GFP_KERNEL);
+	if (!smq_flush_ctx)
+		return -ENOMEM;
+	nix_smq_flush_fill_ctx(rvu, blkaddr, smq, smq_flush_ctx);
+	nix_smq_flush_enadis_xoff(rvu, blkaddr, smq_flush_ctx, true);
+	nix_smq_flush_enadis_rate(rvu, blkaddr, smq_flush_ctx, false);
+
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq));
 	/* Do SMQ flush and set enqueue xoff */
 	cfg |= BIT_ULL(50) | BIT_ULL(49);
@@ -2150,8 +2270,14 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 	err = rvu_poll_reg(rvu, blkaddr,
 			   NIX_AF_SMQX_CFG(smq), BIT_ULL(49), true);
 	if (err)
-		dev_err(rvu->dev,
-			"NIXLF%d: SMQ%d flush failed\n", nixlf, smq);
+		dev_info(rvu->dev,
+			 "NIXLF%d: SMQ%d flush failed, txlink might be busy\n",
+			 nixlf, smq);
+
+	/* clear XOFF on TL2s */
+	nix_smq_flush_enadis_rate(rvu, blkaddr, smq_flush_ctx, true);
+	nix_smq_flush_enadis_xoff(rvu, blkaddr, smq_flush_ctx, false);
+	kfree(smq_flush_ctx);
 
 	rvu_cgx_enadis_rx_bp(rvu, pf, true);
 	/* restore cgx tx state */
-- 
2.43.0




