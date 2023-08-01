Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3A476AE12
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjHAJfz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjHAJfc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C41BF6
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B1A614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEB1C433C8;
        Tue,  1 Aug 2023 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882419;
        bh=pSVIaabH/x8RFpUQ+q6+6jTXdw9VGLpvYluFLL89k7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIC5Ok6oaiqnjNzAvTuOHIvNCKp8Je74nWtGzdvrlGKuXgpZMXqce6iKwyKYVo5oW
         e6LnbG9joLVabxrJohUhES1+BRPWLXmy99llsVuCF5eLa4hzvj4gV5yK06U0CiPYSY
         hES5ozUTITyly7/WfTM6nHHklZzwJ6ZOY6Klp8jE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sunil Goutham <sgoutham@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 099/228] octeontx2-af: Removed unnecessary debug messages.
Date:   Tue,  1 Aug 2023 11:19:17 +0200
Message-ID: <20230801091926.400961556@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

From: Sunil Goutham <sgoutham@marvell.com>

[ Upstream commit 609aa68d60965f70485655def733d533f99b341b ]

NPC exact match feature is supported only on one silicon
variant, removed debug messages which print that this
feature is not available on all other silicon variants.

Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/20230201040301.1034843-1-rkannoth@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 4e62c99d71e5 ("octeontx2-af: Fix hash extraction enable configuration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../marvell/octeontx2/af/rvu_npc_hash.c        | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 3b0a66c0977a7..efc2e64689f7d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -203,10 +203,8 @@ void npc_config_secret_key(struct rvu *rvu, int blkaddr)
 	struct rvu_hwinfo *hw = rvu->hw;
 	u8 intf;
 
-	if (!hwcap->npc_hash_extract) {
-		dev_info(rvu->dev, "HW does not support secret key configuration\n");
+	if (!hwcap->npc_hash_extract)
 		return;
-	}
 
 	for (intf = 0; intf < hw->npc_intfs; intf++) {
 		rvu_write64(rvu, blkaddr, NPC_AF_INTFX_SECRET_KEY0(intf),
@@ -224,10 +222,8 @@ void npc_program_mkex_hash(struct rvu *rvu, int blkaddr)
 	struct rvu_hwinfo *hw = rvu->hw;
 	u8 intf;
 
-	if (!hwcap->npc_hash_extract) {
-		dev_dbg(rvu->dev, "Field hash extract feature is not supported\n");
+	if (!hwcap->npc_hash_extract)
 		return;
-	}
 
 	for (intf = 0; intf < hw->npc_intfs; intf++) {
 		npc_program_mkex_hash_rx(rvu, blkaddr, intf);
@@ -1864,19 +1860,13 @@ int rvu_npc_exact_init(struct rvu *rvu)
 
 	/* Check exact match feature is supported */
 	npc_const3 = rvu_read64(rvu, blkaddr, NPC_AF_CONST3);
-	if (!(npc_const3 & BIT_ULL(62))) {
-		dev_info(rvu->dev, "%s: No support for exact match support\n",
-			 __func__);
+	if (!(npc_const3 & BIT_ULL(62)))
 		return 0;
-	}
 
 	/* Check if kex profile has enabled EXACT match nibble */
 	cfg = rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(NIX_INTF_RX));
-	if (!(cfg & NPC_EXACT_NIBBLE_HIT)) {
-		dev_info(rvu->dev, "%s: NPC exact match nibble not enabled in KEX profile\n",
-			 __func__);
+	if (!(cfg & NPC_EXACT_NIBBLE_HIT))
 		return 0;
-	}
 
 	/* Set capability to true */
 	rvu->hw->cap.npc_exact_match_enabled = true;
-- 
2.39.2



