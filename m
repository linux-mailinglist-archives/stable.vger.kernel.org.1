Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B9C79B9E0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359748AbjIKWSd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbjIKOAE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:00:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42313CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:00:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88661C433C7;
        Mon, 11 Sep 2023 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440799;
        bh=LveeN9LXkluQmj4aPEi8tGS3tFEPXkSkG3cz62j/Khk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKVj+8vTn0dJSwPXIeDMmy5lqL5M9MvKvL1BZIH3UjRx1/h0EKGAtXjno+Gs4IjoO
         jsDPiGwGueORfVCE/sEuNI2Pa+9NwCkkaWKH0c8Yu1JSrnKEYg2M1VnLU13icbollT
         Tr6P5Tw8gD09fCMbK/5WTxMEjVAhcFM6zg/WJxGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suman Ghosh <sumang@marvell.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 189/739] octeontx2-pf: Fix PFC TX scheduler free
Date:   Mon, 11 Sep 2023 15:39:48 +0200
Message-ID: <20230911134656.472872649@linuxfoundation.org>
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

[ Upstream commit a9ac2e18779597f280d68a5b5f5bdd51a34080fa ]

During PFC TX schedulers free, flag TXSCHQ_FREE_ALL was being set
which caused free up all schedulers other than the PFC schedulers.
This patch fixes that to free only the PFC Tx schedulers.

Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
Signed-off-by: Suman Ghosh <sumang@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230824081032.436432-2-sumang@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c  |  1 +
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c   | 15 ++++-----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 3e1c70c746227..b9712040a0bc2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -804,6 +804,7 @@ void otx2_txschq_free_one(struct otx2_nic *pfvf, u16 lvl, u16 schq)
 
 	mutex_unlock(&pfvf->mbox.lock);
 }
+EXPORT_SYMBOL(otx2_txschq_free_one);
 
 void otx2_txschq_stop(struct otx2_nic *pfvf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index ccaf97bb1ce03..6492749dd7c89 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -125,19 +125,12 @@ int otx2_pfc_txschq_alloc(struct otx2_nic *pfvf)
 
 static int otx2_pfc_txschq_stop_one(struct otx2_nic *pfvf, u8 prio)
 {
-	struct nix_txsch_free_req *free_req;
+	int lvl;
 
-	mutex_lock(&pfvf->mbox.lock);
 	/* free PFC TLx nodes */
-	free_req = otx2_mbox_alloc_msg_nix_txsch_free(&pfvf->mbox);
-	if (!free_req) {
-		mutex_unlock(&pfvf->mbox.lock);
-		return -ENOMEM;
-	}
-
-	free_req->flags = TXSCHQ_FREE_ALL;
-	otx2_sync_mbox_msg(&pfvf->mbox);
-	mutex_unlock(&pfvf->mbox.lock);
+	for (lvl = 0; lvl < pfvf->hw.txschq_link_cfg_lvl; lvl++)
+		otx2_txschq_free_one(pfvf, lvl,
+				     pfvf->pfc_schq_list[lvl][prio]);
 
 	pfvf->pfc_alloc_status[prio] = false;
 	return 0;
-- 
2.40.1



