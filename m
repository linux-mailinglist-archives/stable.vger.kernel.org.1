Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B187B8986
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbjJDS1A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244196AbjJDS1A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:27:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6318E98
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:26:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B630C433C8;
        Wed,  4 Oct 2023 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444016;
        bh=y40RgDm2GMoUWyzASxqFPvqF12UNhsB761VR1V+U/1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XC7p6EUtZ0tzQaKK79oTlmHPb27jZvRBzCG1JidCRsXQTZ52qWiuWc7vYC2+qma8h
         TREZO1/i420/Ks5B63pWQZPFxqlbhPXy6fJVkR1ukhcsttfN9lGBM9DPtCd89TvuUE
         fTzULD9QyDRG2KfKxAI7pxwcmv1ovvCy0sjAU2u0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 101/321] octeontx2-pf: Do xdp_do_flush() after redirects.
Date:   Wed,  4 Oct 2023 19:54:06 +0200
Message-ID: <20231004175233.913267086@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 70b2b6892645e58ed6f051dad7f8d1083f0ad553 ]

xdp_do_flush() should be invoked before leaving the NAPI poll function
if XDP-redirect has been performed.

Invoke xdp_do_flush() before leaving NAPI.

Cc: Geetha sowjanya <gakula@marvell.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: hariprasad <hkelam@marvell.com>
Fixes: 06059a1a9a4a5 ("octeontx2-pf: Add XDP support to netdev PF")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Geethasowjanya Akula <gakula@marvell.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeontx2/nic/otx2_txrx.c         | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index e77d438489557..53b2a4ef52985 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -29,7 +29,8 @@
 static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct bpf_prog *prog,
 				     struct nix_cqe_rx_s *cqe,
-				     struct otx2_cq_queue *cq);
+				     struct otx2_cq_queue *cq,
+				     bool *need_xdp_flush);
 
 static int otx2_nix_cq_op_status(struct otx2_nic *pfvf,
 				 struct otx2_cq_queue *cq)
@@ -337,7 +338,7 @@ static bool otx2_check_rcv_errors(struct otx2_nic *pfvf,
 static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 				 struct napi_struct *napi,
 				 struct otx2_cq_queue *cq,
-				 struct nix_cqe_rx_s *cqe)
+				 struct nix_cqe_rx_s *cqe, bool *need_xdp_flush)
 {
 	struct nix_rx_parse_s *parse = &cqe->parse;
 	struct nix_rx_sg_s *sg = &cqe->sg;
@@ -353,7 +354,7 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	}
 
 	if (pfvf->xdp_prog)
-		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq))
+		if (otx2_xdp_rcv_pkt_handler(pfvf, pfvf->xdp_prog, cqe, cq, need_xdp_flush))
 			return;
 
 	skb = napi_get_frags(napi);
@@ -388,6 +389,7 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
 				struct napi_struct *napi,
 				struct otx2_cq_queue *cq, int budget)
 {
+	bool need_xdp_flush = false;
 	struct nix_cqe_rx_s *cqe;
 	int processed_cqe = 0;
 
@@ -409,13 +411,15 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
 		cq->cq_head++;
 		cq->cq_head &= (cq->cqe_cnt - 1);
 
-		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe);
+		otx2_rcv_pkt_handler(pfvf, napi, cq, cqe, &need_xdp_flush);
 
 		cqe->hdr.cqe_type = NIX_XQE_TYPE_INVALID;
 		cqe->sg.seg_addr = 0x00;
 		processed_cqe++;
 		cq->pend_cqe--;
 	}
+	if (need_xdp_flush)
+		xdp_do_flush();
 
 	/* Free CQEs to HW */
 	otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
@@ -1354,7 +1358,8 @@ bool otx2_xdp_sq_append_pkt(struct otx2_nic *pfvf, u64 iova, int len, u16 qidx)
 static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct bpf_prog *prog,
 				     struct nix_cqe_rx_s *cqe,
-				     struct otx2_cq_queue *cq)
+				     struct otx2_cq_queue *cq,
+				     bool *need_xdp_flush)
 {
 	unsigned char *hard_start, *data;
 	int qidx = cq->cq_idx;
@@ -1391,8 +1396,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 
 		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
 				    DMA_FROM_DEVICE);
-		if (!err)
+		if (!err) {
+			*need_xdp_flush = true;
 			return true;
+		}
 		put_page(page);
 		break;
 	default:
-- 
2.40.1



