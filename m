Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763C575D415
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjGUTRk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjGUTRi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:17:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440535AB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01FAC61D7B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9E6C433C8;
        Fri, 21 Jul 2023 19:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967055;
        bh=DW+p4sDZ9al6hk/RgXf6uC+edNJdi8mops/Q12KA5D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqfamoTJqZ/RhMM2f2JU+Hs98IeVFk+wwWj30D+mlBYSymUl5dIsw8A7eZrm9liSs
         8O6UpqEk+NRen6iXBVoFQtIpMHF/vhygTNyi2NGDm3RLmLAn8gOoQlvQwOCtvM1hOK
         QoRkZkXtgvAd+qXqd6rrAXREpI6rZ+KhP+lWVfoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ratheesh Kannoth <rkannoth@marvell.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 029/223] octeontx2-af: Promisc enable/disable through mbox
Date:   Fri, 21 Jul 2023 18:04:42 +0200
Message-ID: <20230721160522.112036837@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ratheesh Kannoth <rkannoth@marvell.com>

[ Upstream commit af42088bdaf292060b8d8a00d8644ca7b2b3f2d1 ]

In legacy silicon, promiscuous mode is only modified
through CGX mbox messages. In CN10KB silicon, it is modified
from CGX mbox and NIX. This breaks legacy application
behaviour. Fix this by removing call from NIX.

Fixes: d6c9784baf59 ("octeontx2-af: Invoke exact match functions if supported")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 11 ++-------
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 23 +++++++++++++++++--
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 8cb2a0181fb9b..705325431dec3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3804,21 +3804,14 @@ int rvu_mbox_handler_nix_set_rx_mode(struct rvu *rvu, struct nix_rx_mode *req,
 	}
 
 	/* install/uninstall promisc entry */
-	if (promisc) {
+	if (promisc)
 		rvu_npc_install_promisc_entry(rvu, pcifunc, nixlf,
 					      pfvf->rx_chan_base,
 					      pfvf->rx_chan_cnt);
-
-		if (rvu_npc_exact_has_match_table(rvu))
-			rvu_npc_exact_promisc_enable(rvu, pcifunc);
-	} else {
+	else
 		if (!nix_rx_multicast)
 			rvu_npc_enable_promisc_entry(rvu, pcifunc, nixlf, false);
 
-		if (rvu_npc_exact_has_match_table(rvu))
-			rvu_npc_exact_promisc_disable(rvu, pcifunc);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 3b48b635977f6..3b0a66c0977a7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -1168,8 +1168,10 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 {
 	struct npc_exact_table *table;
 	u16 *cnt, old_cnt;
+	bool promisc;
 
 	table = rvu->hw->table;
+	promisc = table->promisc_mode[drop_mcam_idx];
 
 	cnt = &table->cnt_cmd_rules[drop_mcam_idx];
 	old_cnt = *cnt;
@@ -1181,13 +1183,18 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 
 	*enable_or_disable_cam = false;
 
-	/* If all rules are deleted, disable cam */
+	if (promisc)
+		goto done;
+
+	/* If all rules are deleted and not already in promisc mode;
+	 * disable cam
+	 */
 	if (!*cnt && val < 0) {
 		*enable_or_disable_cam = true;
 		goto done;
 	}
 
-	/* If rule got added, enable cam */
+	/* If rule got added and not already in promisc mode; enable cam */
 	if (!old_cnt && val > 0) {
 		*enable_or_disable_cam = true;
 		goto done;
@@ -1466,6 +1473,12 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
 	*promisc = false;
 	mutex_unlock(&table->lock);
 
+	/* Enable drop rule */
+	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX,
+					   true);
+
+	dev_dbg(rvu->dev, "%s: disabled  promisc mode (cgx=%d lmac=%d)\n",
+		__func__, cgx_id, lmac_id);
 	return 0;
 }
 
@@ -1507,6 +1520,12 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
 	*promisc = true;
 	mutex_unlock(&table->lock);
 
+	/*  disable drop rule */
+	rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX,
+					   false);
+
+	dev_dbg(rvu->dev, "%s: Enabled promisc mode (cgx=%d lmac=%d)\n",
+		__func__, cgx_id, lmac_id);
 	return 0;
 }
 
-- 
2.39.2



