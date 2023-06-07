Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED108726E3D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjFGUtG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjFGUsm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7194810EA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:48:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19401646B2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28849C433D2;
        Wed,  7 Jun 2023 20:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170903;
        bh=0GUAsxossW2/ifeIIFxjnS7AQuYoW38Ib0Q2Gzs16z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1fGgC3M5zPUc/A0iseT13klGryQ2/EaPNQ3X36Bn3DSnmEw6Rkp8C/UgbGAyXsEH
         Zf8SGCJiBzaN4uEYoYquqv9OjeU4N7J+JQxmUffC4go9myZ2rYMh9MBdxyFpyD5fyI
         013Li30LyKKS00yKb4xABMTs+k+IedUwHz1Bmfpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Hongguang Gao <hongguang.gao@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 009/120] RDMA/bnxt_re: Fix return value of bnxt_re_process_raw_qp_pkt_rx
Date:   Wed,  7 Jun 2023 22:15:25 +0200
Message-ID: <20230607200901.211950046@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 0fa0d520e2a878cb4c94c4dc84395905d3f14f54 ]

bnxt_re_process_raw_qp_pkt_rx() always return 0 and ignores the return
value of bnxt_re_post_send_shadow_qp().

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Link: https://lore.kernel.org/r/1684397461-23082-3-git-send-email-selvin.xavier@broadcom.com
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 85fecb432aa00..2a973a1390a4a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3247,9 +3247,7 @@ static int bnxt_re_process_raw_qp_pkt_rx(struct bnxt_re_qp *gsi_qp,
 	udwr.remote_qkey = gsi_sqp->qplib_qp.qkey;
 
 	/* post data received  in the send queue */
-	rc = bnxt_re_post_send_shadow_qp(rdev, gsi_sqp, swr);
-
-	return 0;
+	return bnxt_re_post_send_shadow_qp(rdev, gsi_sqp, swr);
 }
 
 static void bnxt_re_process_res_rawqp1_wc(struct ib_wc *wc,
-- 
2.39.2



