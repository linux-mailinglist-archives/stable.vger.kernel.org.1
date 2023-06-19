Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC37353B8
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjFSKsY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjFSKsF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E4F10D9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B4B960B86
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB0DC433C0;
        Mon, 19 Jun 2023 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171649;
        bh=seBwDG90EK9ztkHzh+9UXfvB6qcy753ppZ7FAtdVqNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/P4KMzChoR9HdV0CUYqDcCHxKkunAFg6T6EskrJ3j0x4S2m6hPHY31tbZfw+8f8P
         oBbrFtHKjl70s+ya9BK7SnInkVKNnh8yUQI/iPtRtbjSUxhFw0EKZD9k8zFwKHfoR2
         ZGxYE035eF2Rm466s3lo/1uttTCYDpuW2opRFPLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ratheesh Kannoth <rkannoth@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 106/166] octeontx2-af: Fix promiscuous mode
Date:   Mon, 19 Jun 2023 12:29:43 +0200
Message-ID: <20230619102159.936583181@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Ratheesh Kannoth <rkannoth@marvell.com>

[ Upstream commit c0e489372a294044feea650b38f38c888eff57a4 ]

CN10KB silicon introduced a new exact match feature,
which is used for DMAC filtering. The state of installed
DMAC filters in this exact match table is getting corrupted
when promiscuous mode is toggled. Fix this by not touching
Exact match related config when promiscuous mode is toggled.

Fixes: 2dba9459d2c9 ("octeontx2-af: Wrapper functions for MAC addr add/del/update/reset")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 29 ++-----------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 3182adb7b9a80..3b48b635977f6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -1168,10 +1168,8 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 {
 	struct npc_exact_table *table;
 	u16 *cnt, old_cnt;
-	bool promisc;
 
 	table = rvu->hw->table;
-	promisc = table->promisc_mode[drop_mcam_idx];
 
 	cnt = &table->cnt_cmd_rules[drop_mcam_idx];
 	old_cnt = *cnt;
@@ -1183,16 +1181,13 @@ static u16 __rvu_npc_exact_cmd_rules_cnt_update(struct rvu *rvu, int drop_mcam_i
 
 	*enable_or_disable_cam = false;
 
-	if (promisc)
-		goto done;
-
-	/* If all rules are deleted and not already in promisc mode; disable cam */
+	/* If all rules are deleted, disable cam */
 	if (!*cnt && val < 0) {
 		*enable_or_disable_cam = true;
 		goto done;
 	}
 
-	/* If rule got added and not already in promisc mode; enable cam */
+	/* If rule got added, enable cam */
 	if (!old_cnt && val > 0) {
 		*enable_or_disable_cam = true;
 		goto done;
@@ -1447,7 +1442,6 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
 	u32 drop_mcam_idx;
 	bool *promisc;
 	bool rc;
-	u32 cnt;
 
 	table = rvu->hw->table;
 
@@ -1470,17 +1464,8 @@ int rvu_npc_exact_promisc_disable(struct rvu *rvu, u16 pcifunc)
 		return LMAC_AF_ERR_INVALID_PARAM;
 	}
 	*promisc = false;
-	cnt = __rvu_npc_exact_cmd_rules_cnt_update(rvu, drop_mcam_idx, 0, NULL);
 	mutex_unlock(&table->lock);
 
-	/* If no dmac filter entries configured, disable drop rule */
-	if (!cnt)
-		rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, false);
-	else
-		rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, !*promisc);
-
-	dev_dbg(rvu->dev, "%s: disabled  promisc mode (cgx=%d lmac=%d, cnt=%d)\n",
-		__func__, cgx_id, lmac_id, cnt);
 	return 0;
 }
 
@@ -1498,7 +1483,6 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
 	u32 drop_mcam_idx;
 	bool *promisc;
 	bool rc;
-	u32 cnt;
 
 	table = rvu->hw->table;
 
@@ -1521,17 +1505,8 @@ int rvu_npc_exact_promisc_enable(struct rvu *rvu, u16 pcifunc)
 		return LMAC_AF_ERR_INVALID_PARAM;
 	}
 	*promisc = true;
-	cnt = __rvu_npc_exact_cmd_rules_cnt_update(rvu, drop_mcam_idx, 0, NULL);
 	mutex_unlock(&table->lock);
 
-	/* If no dmac filter entries configured, disable drop rule */
-	if (!cnt)
-		rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, false);
-	else
-		rvu_npc_enable_mcam_by_entry_index(rvu, drop_mcam_idx, NIX_INTF_RX, !*promisc);
-
-	dev_dbg(rvu->dev, "%s: Enabled promisc mode (cgx=%d lmac=%d cnt=%d)\n",
-		__func__, cgx_id, lmac_id, cnt);
 	return 0;
 }
 
-- 
2.39.2



