Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C27479C09C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbjIKVOX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbjIKOAJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:00:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF014CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:00:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01863C433C8;
        Mon, 11 Sep 2023 14:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440805;
        bh=gWx42G0jTT482W5Jo84KJ18vLCtltMuqOVS3Zi/OEi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+wmtrPLkH2JmOycBXKsw5Smprk7N0mcKTRaNNukiMtBag0ZFzORPmqwYzbWyZhxT
         VXI/WCOYthi1fwPGRO3YbL7RltMUj7fSqo/ezAfvco8L+U1qu0e7wJpXcmNCv8EAmo
         xqMKU7ckxbF9IMSw1qNj9LINo8h9RrujMlaIQuTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suman Ghosh <sumang@marvell.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 191/739] cteonxt2-pf: Fix backpressure config for multiple PFC priorities to work simultaneously
Date:   Mon, 11 Sep 2023 15:39:50 +0200
Message-ID: <20230911134656.528727841@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suman Ghosh <sumang@marvell.com>

[ Upstream commit 597d0ec0e4ca6a912affea4cc94df08959e9ec74 ]

MAC (CGX or RPM) asserts backpressure at TL3 or TL2 node of the egress
hierarchical scheduler tree depending on link level config done. If
there are multiple PFC priorities enabled at a time and for all such
flows to backoff, each priority will have to assert backpressure at
different TL3/TL2 scheduler nodes and these flows will need to submit
egress pkts to these nodes.

Current PFC configuration has an issue where in only one backpressure
scheduler node is being allocated which is resulting in only one PFC
priority to work. This patch fixes this issue.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230824081032.436432-4-sumang@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index 6492749dd7c89..bfddbff7bcdfb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -70,7 +70,7 @@ static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 	 * link config level. These rest of the scheduler can be
 	 * same as hw.txschq_list.
 	 */
-	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
+	for (lvl = 0; lvl <= pfvf->hw.txschq_link_cfg_lvl; lvl++)
 		req->schq[lvl] = 1;
 
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
@@ -83,7 +83,7 @@ static int otx2_pfc_txschq_alloc_one(struct otx2_nic *pfvf, u8 prio)
 		return PTR_ERR(rsp);
 
 	/* Setup transmit scheduler list */
-	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++) {
+	for (lvl = 0; lvl <= pfvf->hw.txschq_link_cfg_lvl; lvl++) {
 		if (!rsp->schq[lvl])
 			return -ENOSPC;
 
@@ -128,7 +128,7 @@ static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 	int lvl;
 
 	/* free PFC TLx nodes */
-	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
+	for (lvl = 0; lvl <= pfvf->hw.txschq_link_cfg_lvl; lvl++)
 		otx2_txschq_free_one(pfvf, lvl,
 				     pfvf->pfc_schq_list[lvl][prio]);
 
-- 
2.40.1



