Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB71675CD88
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGUQMk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjGUQMU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0183C3A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4274C61D3E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558ECC433C8;
        Fri, 21 Jul 2023 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955917;
        bh=cqFzTWInx0Co4DALnRL8B6XTaDKz4WSTZU7QpHMgNFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4k6hUP6XhNO1pJEXkSVn0YcWUAelcm/X3Y006E+cXOttFgyYn/ZPNGt2WU4y0YiF
         6UYeesbGzu2ekP/gCp56VxgsdP6dj2YdM7n0HzqLodDyk6PLodWTcxmInwXjqYHV2q
         reiIfPC9VJI6tD4sc813l9JGO24ulVSZwTR/kFtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ratheesh Kannoth <rkannoth@marvell.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 048/292] octeontx2-af: Promisc enable/disable through mbox
Date:   Fri, 21 Jul 2023 18:02:37 +0200
Message-ID: <20230721160530.868206483@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
index f01d057ad025a..8cdf91a5bf44f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -3815,21 +3815,14 @@ int rvu_mbox_handler_nix_set_rx_mode(struct rvu *rvu, struct nix_rx_mode *req,
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
index 9f11c1e407373..6fe67f3a7f6f1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -1164,8 +1164,10 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 {
 	struct npc_exact_table *table;
 	u16 *cnt, old_cnt;
+	bool promisc;
 
 	table = rvu->hw->table;
+	promisc = table->promisc_mode[drop_mcam_idx];
 
 	cnt = &table->cnt_cmd_rules[drop_mcam_idx];
 	old_cnt = *cnt;
@@ -1177,13 +1179,18 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 
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
@@ -1462,6 +1469,12 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
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
 
@@ -1503,6 +1516,12 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
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



