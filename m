Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE5C79B736
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbjIKVHU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbjIKOiQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:38:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D710F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:38:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EC0C433C8;
        Mon, 11 Sep 2023 14:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443091;
        bh=UfqbVOebIqh+zVZhSoPJo67IozpGguTMEiar23MVdlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SV4W5wP1+tdLR5feNA3LSd0RvE/CuyYyvGl5G0JqItrcpPC2o3GQGkUMRPUsRGd4C
         T9/aUvjWMeKn1KYUoCuykVlDfaj9avi9HzfHqXTdt1ikmlR38q3YMXp07YhdK6SPsN
         xZa2vuzt9GOtjC5aeGkCyX2rWdlAnnTbe/2Q11fQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hariprasad Kelam <hkelam@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 255/737] octeontx2-pf: Refactor schedular queue alloc/free calls
Date:   Mon, 11 Sep 2023 15:41:54 +0200
Message-ID: <20230911134657.714285016@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit 6b4b2ded9c4282deea421eef144ab0ced954721c ]

1. Upon txschq free request, the transmit schedular config in hardware
is not getting reset. This patch adds necessary changes to do the same.

2. Current implementation calls txschq alloc during interface
initialization and in response handler updates the default txschq array.
This creates a problem for htb offload where txsch alloc will be called
for every tc class. This patch addresses the issue by reading txschq
response in mbox caller function instead in the response handler.

3. Current otx2_txschq_stop routine tries to free all txschq nodes
allocated to the interface. This creates a problem for htb offload.
This patch introduces the otx2_txschq_free_one to free txschq in a
given level.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a9ac2e187795 ("octeontx2-pf: Fix PFC TX scheduler free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 45 +++++++++++++
 .../marvell/octeontx2/nic/otx2_common.c       | 67 ++++++++++++-------
 .../marvell/octeontx2/nic/otx2_common.h       |  3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 13 +---
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  4 --
 5 files changed, 94 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 49c1dbe5ec788..43f6d1b50d2ad 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1691,6 +1691,42 @@ handle_txschq_shaper_update(struct rvu *rvu, int blkaddr, int nixlf,
 	return true;
 }
 
+static void nix_reset_tx_schedule(struct rvu *rvu, int blkaddr,
+				  int lvl, int schq)
+{
+	u64 tlx_parent = 0, tlx_schedule = 0;
+
+	switch (lvl) {
+	case NIX_TXSCH_LVL_TL2:
+		tlx_parent   = NIX_AF_TL2X_PARENT(schq);
+		tlx_schedule = NIX_AF_TL2X_SCHEDULE(schq);
+		break;
+	case NIX_TXSCH_LVL_TL3:
+		tlx_parent   = NIX_AF_TL3X_PARENT(schq);
+		tlx_schedule = NIX_AF_TL3X_SCHEDULE(schq);
+		break;
+	case NIX_TXSCH_LVL_TL4:
+		tlx_parent   = NIX_AF_TL4X_PARENT(schq);
+		tlx_schedule = NIX_AF_TL4X_SCHEDULE(schq);
+		break;
+	case NIX_TXSCH_LVL_MDQ:
+		/* no need to reset SMQ_CFG as HW clears this CSR
+		 * on SMQ flush
+		 */
+		tlx_parent   = NIX_AF_MDQX_PARENT(schq);
+		tlx_schedule = NIX_AF_MDQX_SCHEDULE(schq);
+		break;
+	default:
+		return;
+	}
+
+	if (tlx_parent)
+		rvu_write64(rvu, blkaddr, tlx_parent, 0x0);
+
+	if (tlx_schedule)
+		rvu_write64(rvu, blkaddr, tlx_schedule, 0x0);
+}
+
 /* Disable shaping of pkts by a scheduler queue
  * at a given scheduler level.
  */
@@ -2040,6 +2076,7 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 				pfvf_map[schq] = TXSCH_MAP(pcifunc, 0);
 			nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
 			nix_reset_tx_shaping(rvu, blkaddr, nixlf, lvl, schq);
+			nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
 		}
 
 		for (idx = 0; idx < req->schq[lvl]; idx++) {
@@ -2049,6 +2086,7 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 				pfvf_map[schq] = TXSCH_MAP(pcifunc, 0);
 			nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
 			nix_reset_tx_shaping(rvu, blkaddr, nixlf, lvl, schq);
+			nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
 		}
 	}
 
@@ -2144,6 +2182,7 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
 				continue;
 			nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
 			nix_clear_tx_xoff(rvu, blkaddr, lvl, schq);
+			nix_reset_tx_shaping(rvu, blkaddr, nixlf, lvl, schq);
 		}
 	}
 	nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1,
@@ -2182,6 +2221,7 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
 		for (schq = 0; schq < txsch->schq.max; schq++) {
 			if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
 				continue;
+			nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
 			rvu_free_rsrc(&txsch->schq, schq);
 			txsch->pfvf_map[schq] = TXSCH_MAP(0, NIX_TXSCHQ_FREE);
 		}
@@ -2241,6 +2281,9 @@ static int nix_txschq_free_one(struct rvu *rvu,
 	 */
 	nix_clear_tx_xoff(rvu, blkaddr, lvl, schq);
 
+	nix_reset_tx_linkcfg(rvu, blkaddr, lvl, schq);
+	nix_reset_tx_shaping(rvu, blkaddr, nixlf, lvl, schq);
+
 	/* Flush if it is a SMQ. Onus of disabling
 	 * TL2/3 queue links before SMQ flush is on user
 	 */
@@ -2250,6 +2293,8 @@ static int nix_txschq_free_one(struct rvu *rvu,
 		goto err;
 	}
 
+	nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
+
 	/* Free the resource */
 	rvu_free_rsrc(&txsch->schq, schq);
 	txsch->pfvf_map[schq] = TXSCH_MAP(0, NIX_TXSCHQ_FREE);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 8a41ad8ca04f1..dd97731f81698 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -716,7 +716,8 @@ EXPORT_SYMBOL(otx2_smq_flush);
 int otx2_txsch_alloc(struct otx2_nic *pfvf)
 {
 	struct nix_txsch_alloc_req *req;
-	int lvl;
+	struct nix_txsch_alloc_rsp *rsp;
+	int lvl, schq, rc;
 
 	/* Get memory to put this msg */
 	req = otx2_mbox_alloc_msg_nix_txsch_alloc(&pfvf->mbox);
@@ -726,33 +727,68 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 	/* Request one schq per level */
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
 		req->schq[lvl] = 1;
+	rc = otx2_sync_mbox_msg(&pfvf->mbox);
+	if (rc)
+		return rc;
 
-	return otx2_sync_mbox_msg(&pfvf->mbox);
+	rsp = (struct nix_txsch_alloc_rsp *)
+	      otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp))
+		return PTR_ERR(rsp);
+
+	/* Setup transmit scheduler list */
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
+		for (schq = 0; schq < rsp->schq[lvl]; schq++)
+			pfvf->hw.txschq_list[lvl][schq] =
+				rsp->schq_list[lvl][schq];
+
+	pfvf->hw.txschq_link_cfg_lvl = rsp->link_cfg_lvl;
+
+	return 0;
 }
 
-int otx2_txschq_stop(struct otx2_nic *pfvf)
+void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq)
 {
 	struct nix_txsch_free_req *free_req;
-	int lvl, schq, err;
+	int err;
 
 	mutex_lock(&pfvf->mbox.lock);
-	/* Free the transmit schedulers */
+
 	free_req = otx2_mbox_alloc_msg_nix_txsch_free(&pfvf->mbox);
 	if (!free_req) {
 		mutex_unlock(&pfvf->mbox.lock);
-		return -ENOMEM;
+		netdev_err(pfvf->netdev,
+			   "Failed alloc txschq free req\n");
+		return;
 	}
 
-	free_req->flags = TXSCHQ_FREE_ALL;
+	free_req->schq_lvl = lvl;
+	free_req->schq = schq;
+
 	err = otx2_sync_mbox_msg(&pfvf->mbox);
+	if (err) {
+		netdev_err(pfvf->netdev,
+			   "Failed stop txschq %d at level %d\n", schq, lvl);
+	}
+
 	mutex_unlock(&pfvf->mbox.lock);
+}
+
+void otx2_txschq_stop(struct otx2_nic *pfvf)
+{
+	int lvl, schq;
+
+	/* free non QOS TLx nodes */
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
+		otx2_txschq_free_one(pfvf, lvl,
+				     pfvf->hw.txschq_list[lvl][0]);
 
 	/* Clear the txschq list */
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
 		for (schq = 0; schq < MAX_TXSCHQ_PER_FUNC; schq++)
 			pfvf->hw.txschq_list[lvl][schq] = 0;
 	}
-	return err;
+
 }
 
 void otx2_sqb_flush(struct otx2_nic *pfvf)
@@ -1629,21 +1665,6 @@ void mbox_handler_cgx_fec_stats(struct otx2_nic *pfvf,
 	pfvf->hw.cgx_fec_uncorr_blks += rsp->fec_uncorr_blks;
 }
 
-void mbox_handler_nix_txsch_alloc(struct otx2_nic *pf,
-				  struct nix_txsch_alloc_rsp *rsp)
-{
-	int lvl, schq;
-
-	/* Setup transmit scheduler list */
-	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
-		for (schq = 0; schq < rsp->schq[lvl]; schq++)
-			pf->hw.txschq_list[lvl][schq] =
-				rsp->schq_list[lvl][schq];
-
-	pf->hw.txschq_link_cfg_lvl = rsp->link_cfg_lvl;
-}
-EXPORT_SYMBOL(mbox_handler_nix_txsch_alloc);
-
 void mbox_handler_npa_lf_alloc(struct otx2_nic *pfvf,
 			       struct npa_lf_alloc_rsp *rsp)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 0c8fc66ade82d..53cf964fc3e14 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -920,7 +920,8 @@ int otx2_config_nix(struct otx2_nic *pfvf);
 int otx2_config_nix_queues(struct otx2_nic *pfvf);
 int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool pfc_en);
 int otx2_txsch_alloc(struct otx2_nic *pfvf);
-int otx2_txschq_stop(struct otx2_nic *pfvf);
+void otx2_txschq_stop(struct otx2_nic *pfvf);
+void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq);
 void otx2_sqb_flush(struct otx2_nic *pfvf);
 int __otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 		      dma_addr_t *dma);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 384d26bee9b23..fb951e953df34 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -791,10 +791,6 @@ static void otx2_process_pfaf_mbox_msg(struct otx2_nic *pf,
 	case MBOX_MSG_NIX_LF_ALLOC:
 		mbox_handler_nix_lf_alloc(pf, (struct nix_lf_alloc_rsp *)msg);
 		break;
-	case MBOX_MSG_NIX_TXSCH_ALLOC:
-		mbox_handler_nix_txsch_alloc(pf,
-					     (struct nix_txsch_alloc_rsp *)msg);
-		break;
 	case MBOX_MSG_NIX_BP_ENABLE:
 		mbox_handler_nix_bp_enable(pf, (struct nix_bp_cfg_rsp *)msg);
 		break;
@@ -1517,8 +1513,7 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	otx2_free_cq_res(pf);
 	otx2_ctx_disable(mbox, NIX_AQ_CTYPE_RQ, false);
 err_free_txsch:
-	if (otx2_txschq_stop(pf))
-		dev_err(pf->dev, "%s failed to stop TX schedulers\n", __func__);
+	otx2_txschq_stop(pf);
 err_free_sq_ptrs:
 	otx2_sq_free_sqbs(pf);
 err_free_rq_ptrs:
@@ -1553,15 +1548,13 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 	struct mbox *mbox = &pf->mbox;
 	struct otx2_cq_queue *cq;
 	struct msg_req *req;
-	int qidx, err;
+	int qidx;
 
 	/* Ensure all SQE are processed */
 	otx2_sqb_flush(pf);
 
 	/* Stop transmission */
-	err = otx2_txschq_stop(pf);
-	if (err)
-		dev_err(pf->dev, "RVUPF: Failed to stop/free TX schedulers\n");
+	otx2_txschq_stop(pf);
 
 #ifdef CONFIG_DCB
 	if (pf->pfc_en)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 53366dbfbf27c..f8f0c01f62a14 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -70,10 +70,6 @@ static void otx2vf_process_vfaf_mbox_msg(struct otx2_nic *vf,
 	case MBOX_MSG_NIX_LF_ALLOC:
 		mbox_handler_nix_lf_alloc(vf, (struct nix_lf_alloc_rsp *)msg);
 		break;
-	case MBOX_MSG_NIX_TXSCH_ALLOC:
-		mbox_handler_nix_txsch_alloc(vf,
-					     (struct nix_txsch_alloc_rsp *)msg);
-		break;
 	case MBOX_MSG_NIX_BP_ENABLE:
 		mbox_handler_nix_bp_enable(vf, (struct nix_bp_cfg_rsp *)msg);
 		break;
-- 
2.40.1



