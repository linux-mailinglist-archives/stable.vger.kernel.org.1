Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D962F7A3D18
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbjIQUi7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbjIQUic (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:38:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB88101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:38:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A1C433C7;
        Sun, 17 Sep 2023 20:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983106;
        bh=KLbXH025VcgDvA/WVICERBy+GTDxxNTba8DDR2wQUuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDBDBReX72Jns0TKM1Z9dExLxS/LQ65vHBnyfPrRDvEtc+TzBTsURUacWSTbhJSom
         Na+ESSqcxGQ81L+0RNCrw4x3Vj78Iy3l3EIObAvkOmJnenEL303JaKkwUOyRqNNQtN
         tCpB3UpDOGRy94Pq4ZIjNgCxGWE3DUnYCKX4pr5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 445/511] octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler
Date:   Sun, 17 Sep 2023 21:14:32 +0200
Message-ID: <20230917191124.497820910@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit 29fe7a1b62717d58f033009874554d99d71f7d37 ]

The smq value used in the CN10K NIX AQ instruction enqueue mailbox
handler was truncated to 9-bit value from 10-bit value because of
typecasting the CN10K mbox request structure to the CN9K structure.
Though this hasn't caused any problems when programming the NIX SQ
context to the HW because the context structure is the same size.
However, this causes a problem when accessing the structure parameters.
This patch reads the right smq value for each platform.

Fixes: 30077d210c83 ("octeontx2-af: cn10k: Update NIX/NPA context structure")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index f5922d63e33e4..1593efc4502b5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -841,6 +841,21 @@ static int nix_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
 	return 0;
 }
 
+static void nix_get_aq_req_smq(struct rvu *rvu, struct nix_aq_enq_req *req,
+			       u16 *smq, u16 *smq_mask)
+{
+	struct nix_cn10k_aq_enq_req *aq_req;
+
+	if (!is_rvu_otx2(rvu)) {
+		aq_req = (struct nix_cn10k_aq_enq_req *)req;
+		*smq = aq_req->sq.smq;
+		*smq_mask = aq_req->sq_mask.smq;
+	} else {
+		*smq = req->sq.smq;
+		*smq_mask = req->sq_mask.smq;
+	}
+}
+
 static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 				   struct nix_aq_enq_req *req,
 				   struct nix_aq_enq_rsp *rsp)
@@ -852,6 +867,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	struct rvu_block *block;
 	struct admin_queue *aq;
 	struct rvu_pfvf *pfvf;
+	u16 smq, smq_mask;
 	void *ctx, *mask;
 	bool ena;
 	u64 cfg;
@@ -923,13 +939,14 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	if (rc)
 		return rc;
 
+	nix_get_aq_req_smq(rvu, req, &smq, &smq_mask);
 	/* Check if SQ pointed SMQ belongs to this PF/VF or not */
 	if (req->ctype == NIX_AQ_CTYPE_SQ &&
 	    ((req->op == NIX_AQ_INSTOP_INIT && req->sq.ena) ||
 	     (req->op == NIX_AQ_INSTOP_WRITE &&
-	      req->sq_mask.ena && req->sq_mask.smq && req->sq.ena))) {
+	      req->sq_mask.ena && req->sq.ena && smq_mask))) {
 		if (!is_valid_txschq(rvu, blkaddr, NIX_TXSCH_LVL_SMQ,
-				     pcifunc, req->sq.smq))
+				     pcifunc, smq))
 			return NIX_AF_ERR_AQ_ENQUEUE;
 	}
 
-- 
2.40.1



