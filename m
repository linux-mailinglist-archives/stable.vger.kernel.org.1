Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D07A39B0
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbjIQTxI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbjIQTwv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:52:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D718013E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:52:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B049C433C8;
        Sun, 17 Sep 2023 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980357;
        bh=FvVFEPxVxowNq4euWBmGYAZuJ3bwrFBoC2aNwkBeP5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tC9wuPMvAhdDirjovBHV85qXdWlcF6mIb5Og0ksjmcBcH65VJX5jBWjZ/pp6BUwE7
         beCDRgZDHQZE6ZTmDHqrqY/gw5yPZ6R7lsk6PnnC2Jj1XO8JcdM5iFIubacA2tlc0/
         hqQ6q5RmwGLv4PaQ9vUH8bLt9f8UaeZxZH2BRcN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 140/285] octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler
Date:   Sun, 17 Sep 2023 21:12:20 +0200
Message-ID: <20230917191056.522203106@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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
index c2f68678e947e..23c2f2ed2fb83 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -846,6 +846,21 @@ static int nix_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
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
@@ -857,6 +872,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	struct rvu_block *block;
 	struct admin_queue *aq;
 	struct rvu_pfvf *pfvf;
+	u16 smq, smq_mask;
 	void *ctx, *mask;
 	bool ena;
 	u64 cfg;
@@ -928,13 +944,14 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
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



