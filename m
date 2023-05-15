Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0965F70360D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243442AbjEORFw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243448AbjEORFS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:05:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E03DA5EB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C053B62ABD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD35EC433EF;
        Mon, 15 May 2023 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170228;
        bh=NNISOHxR4cXLqX4rqj9MEP6f0iTjiVmzkmqCrA1E5MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEzmQFnTwddG4JkH2u1m0zXshhasABtngpq8pd4ec5Ej5S4zpYspnX5t7k8fd/H1+
         bbtqhB6vps8IE3HK/5pip9q9LO8Pv3p7Vc6aMi1c4S2LxjgtmWMKnDk1Ez24Dzrt33
         I6njc3iLXhy3HOVyLL0fSu9EXaS66d0w0wShDlxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Sai Krishna <saikrishnag@marvell.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 065/239] octeontx2-af: Secure APR table update with the lock
Date:   Mon, 15 May 2023 18:25:28 +0200
Message-Id: <20230515161723.647620370@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit 048486f81d01db4d100af021ee2ea211d19732a0 ]

APR table contains the lmtst base address of PF/VFs. These entries
are updated by the PF/VF during the device probe. The lmtst address
is fetched from HW using "TXN_REQ" and "ADDR_RSP_STS" registers.
The lock tries to protect these registers from getting overwritten
when multiple PFs invokes rvu_get_lmtaddr() simultaneously.

For example, if PF1 submit the request and got permitted before it
reads the response and PF2 got scheduled submit the request then the
response of PF1 is overwritten by the PF2 response.

Fixes: 893ae97214c3 ("octeontx2-af: cn10k: Support configurable LMTST regions")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c   | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 7dbbc115cde42..f9faa5b23bb9d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -60,13 +60,14 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 			   u64 iova, u64 *lmt_addr)
 {
 	u64 pa, val, pf;
-	int err;
+	int err = 0;
 
 	if (!iova) {
 		dev_err(rvu->dev, "%s Requested Null address for transulation\n", __func__);
 		return -EINVAL;
 	}
 
+	mutex_lock(&rvu->rsrc_lock);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_REQ, iova);
 	pf = rvu_get_pf(pcifunc) & 0x1F;
 	val = BIT_ULL(63) | BIT_ULL(14) | BIT_ULL(13) | pf << 8 |
@@ -76,12 +77,13 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 	err = rvu_poll_reg(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_RSP_STS, BIT_ULL(0), false);
 	if (err) {
 		dev_err(rvu->dev, "%s LMTLINE iova transulation failed\n", __func__);
-		return err;
+		goto exit;
 	}
 	val = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_RSP_STS);
 	if (val & ~0x1ULL) {
 		dev_err(rvu->dev, "%s LMTLINE iova transulation failed err:%llx\n", __func__, val);
-		return -EIO;
+		err = -EIO;
+		goto exit;
 	}
 	/* PA[51:12] = RVU_AF_SMMU_TLN_FLIT0[57:18]
 	 * PA[11:0] = IOVA[11:0]
@@ -89,8 +91,9 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 	pa = rvu_read64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_TLN_FLIT0) >> 18;
 	pa &= GENMASK_ULL(39, 0);
 	*lmt_addr = (pa << 12) | (iova  & 0xFFF);
-
-	return 0;
+exit:
+	mutex_unlock(&rvu->rsrc_lock);
+	return err;
 }
 
 static int rvu_update_lmtaddr(struct rvu *rvu, u16 pcifunc, u64 lmt_addr)
-- 
2.39.2



