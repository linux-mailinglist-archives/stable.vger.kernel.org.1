Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49C17ECDC9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjKOTi1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjKOTiZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B0A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518DFC433C7;
        Wed, 15 Nov 2023 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077102;
        bh=xy743gM9Qu5a2Jl9kwwb3wC41ykcGkOjyyEGbkh19UI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6LbcKFpFUU/kDR5Y31j+PNINY58gkBJ712+JQSjqbiYNOD5owrnp9460YAeNYymR
         d4Dln7mFZd2FZy/IlrfllLRH2rRnVLL1kDXqhxaed/kazWxpxFMIn6p8CvvJs+QgUY
         unxAV9iJUjlD9Q34weqP1qtHhooR8+8jv7giJRes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ratheesh Kannoth <rkannoth@marvell.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 505/550] octeontx2-pf: Fix holes in error code
Date:   Wed, 15 Nov 2023 14:18:09 -0500
Message-ID: <20231115191635.925595982@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ratheesh Kannoth <rkannoth@marvell.com>

[ Upstream commit 7aeeb2cb7a2570bb69a87ad14018b03e06ce5be5 ]

Error code strings are not getting printed properly
due to holes. Print error code as well.

Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Link: https://lore.kernel.org/r/20231027021953.1819959-2-rkannoth@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 80 +++++++++++--------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 9ded98bb1c890..ca6602fe27050 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1192,31 +1192,32 @@ static char *nix_mnqerr_e_str[NIX_MNQERR_MAX] = {
 };
 
 static char *nix_snd_status_e_str[NIX_SND_STATUS_MAX] =  {
-	"NIX_SND_STATUS_GOOD",
-	"NIX_SND_STATUS_SQ_CTX_FAULT",
-	"NIX_SND_STATUS_SQ_CTX_POISON",
-	"NIX_SND_STATUS_SQB_FAULT",
-	"NIX_SND_STATUS_SQB_POISON",
-	"NIX_SND_STATUS_HDR_ERR",
-	"NIX_SND_STATUS_EXT_ERR",
-	"NIX_SND_STATUS_JUMP_FAULT",
-	"NIX_SND_STATUS_JUMP_POISON",
-	"NIX_SND_STATUS_CRC_ERR",
-	"NIX_SND_STATUS_IMM_ERR",
-	"NIX_SND_STATUS_SG_ERR",
-	"NIX_SND_STATUS_MEM_ERR",
-	"NIX_SND_STATUS_INVALID_SUBDC",
-	"NIX_SND_STATUS_SUBDC_ORDER_ERR",
-	"NIX_SND_STATUS_DATA_FAULT",
-	"NIX_SND_STATUS_DATA_POISON",
-	"NIX_SND_STATUS_NPC_DROP_ACTION",
-	"NIX_SND_STATUS_LOCK_VIOL",
-	"NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
-	"NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
-	"NIX_SND_STATUS_NPC_MCAST_ABORT",
-	"NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
-	"NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
-	"NIX_SND_STATUS_SEND_STATS_ERR",
+	[NIX_SND_STATUS_GOOD] = "NIX_SND_STATUS_GOOD",
+	[NIX_SND_STATUS_SQ_CTX_FAULT] = "NIX_SND_STATUS_SQ_CTX_FAULT",
+	[NIX_SND_STATUS_SQ_CTX_POISON] = "NIX_SND_STATUS_SQ_CTX_POISON",
+	[NIX_SND_STATUS_SQB_FAULT] = "NIX_SND_STATUS_SQB_FAULT",
+	[NIX_SND_STATUS_SQB_POISON] = "NIX_SND_STATUS_SQB_POISON",
+	[NIX_SND_STATUS_HDR_ERR] = "NIX_SND_STATUS_HDR_ERR",
+	[NIX_SND_STATUS_EXT_ERR] = "NIX_SND_STATUS_EXT_ERR",
+	[NIX_SND_STATUS_JUMP_FAULT] = "NIX_SND_STATUS_JUMP_FAULT",
+	[NIX_SND_STATUS_JUMP_POISON] = "NIX_SND_STATUS_JUMP_POISON",
+	[NIX_SND_STATUS_CRC_ERR] = "NIX_SND_STATUS_CRC_ERR",
+	[NIX_SND_STATUS_IMM_ERR] = "NIX_SND_STATUS_IMM_ERR",
+	[NIX_SND_STATUS_SG_ERR] = "NIX_SND_STATUS_SG_ERR",
+	[NIX_SND_STATUS_MEM_ERR] = "NIX_SND_STATUS_MEM_ERR",
+	[NIX_SND_STATUS_INVALID_SUBDC] = "NIX_SND_STATUS_INVALID_SUBDC",
+	[NIX_SND_STATUS_SUBDC_ORDER_ERR] = "NIX_SND_STATUS_SUBDC_ORDER_ERR",
+	[NIX_SND_STATUS_DATA_FAULT] = "NIX_SND_STATUS_DATA_FAULT",
+	[NIX_SND_STATUS_DATA_POISON] = "NIX_SND_STATUS_DATA_POISON",
+	[NIX_SND_STATUS_NPC_DROP_ACTION] = "NIX_SND_STATUS_NPC_DROP_ACTION",
+	[NIX_SND_STATUS_LOCK_VIOL] = "NIX_SND_STATUS_LOCK_VIOL",
+	[NIX_SND_STATUS_NPC_UCAST_CHAN_ERR] = "NIX_SND_STAT_NPC_UCAST_CHAN_ERR",
+	[NIX_SND_STATUS_NPC_MCAST_CHAN_ERR] = "NIX_SND_STAT_NPC_MCAST_CHAN_ERR",
+	[NIX_SND_STATUS_NPC_MCAST_ABORT] = "NIX_SND_STATUS_NPC_MCAST_ABORT",
+	[NIX_SND_STATUS_NPC_VTAG_PTR_ERR] = "NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
+	[NIX_SND_STATUS_NPC_VTAG_SIZE_ERR] = "NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
+	[NIX_SND_STATUS_SEND_MEM_FAULT] = "NIX_SND_STATUS_SEND_MEM_FAULT",
+	[NIX_SND_STATUS_SEND_STATS_ERR] = "NIX_SND_STATUS_SEND_STATS_ERR",
 };
 
 static irqreturn_t otx2_q_intr_handler(int irq, void *data)
@@ -1237,14 +1238,16 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			continue;
 
 		if (val & BIT_ULL(42)) {
-			netdev_err(pf->netdev, "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
+			netdev_err(pf->netdev,
+				   "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
 				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
 		} else {
 			if (val & BIT_ULL(NIX_CQERRINT_DOOR_ERR))
 				netdev_err(pf->netdev, "CQ%lld: Doorbell error",
 					   qidx);
 			if (val & BIT_ULL(NIX_CQERRINT_CQE_FAULT))
-				netdev_err(pf->netdev, "CQ%lld: Memory fault on CQE write to LLC/DRAM",
+				netdev_err(pf->netdev,
+					   "CQ%lld: Memory fault on CQE write to LLC/DRAM",
 					   qidx);
 		}
 
@@ -1271,7 +1274,8 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			     (val & NIX_SQINT_BITS));
 
 		if (val & BIT_ULL(42)) {
-			netdev_err(pf->netdev, "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
+			netdev_err(pf->netdev,
+				   "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
 				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
 			goto done;
 		}
@@ -1281,8 +1285,11 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			goto chk_mnq_err_dbg;
 
 		sq_op_err_code = FIELD_GET(GENMASK(7, 0), sq_op_err_dbg);
-		netdev_err(pf->netdev, "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(%llx)  err=%s\n",
-			   qidx, sq_op_err_dbg, nix_sqoperr_e_str[sq_op_err_code]);
+		netdev_err(pf->netdev,
+			   "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(0x%llx)  err=%s(%#x)\n",
+			   qidx, sq_op_err_dbg,
+			   nix_sqoperr_e_str[sq_op_err_code],
+			   sq_op_err_code);
 
 		otx2_write64(pf, NIX_LF_SQ_OP_ERR_DBG, BIT_ULL(44));
 
@@ -1299,16 +1306,21 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			goto chk_snd_err_dbg;
 
 		mnq_err_code = FIELD_GET(GENMASK(7, 0), mnq_err_dbg);
-		netdev_err(pf->netdev, "SQ%lld: NIX_LF_MNQ_ERR_DBG(%llx)  err=%s\n",
-			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code]);
+		netdev_err(pf->netdev,
+			   "SQ%lld: NIX_LF_MNQ_ERR_DBG(0x%llx)  err=%s(%#x)\n",
+			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code],
+			   mnq_err_code);
 		otx2_write64(pf, NIX_LF_MNQ_ERR_DBG, BIT_ULL(44));
 
 chk_snd_err_dbg:
 		snd_err_dbg = otx2_read64(pf, NIX_LF_SEND_ERR_DBG);
 		if (snd_err_dbg & BIT(44)) {
 			snd_err_code = FIELD_GET(GENMASK(7, 0), snd_err_dbg);
-			netdev_err(pf->netdev, "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s\n",
-				   qidx, snd_err_dbg, nix_snd_status_e_str[snd_err_code]);
+			netdev_err(pf->netdev,
+				   "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s(%#x)\n",
+				   qidx, snd_err_dbg,
+				   nix_snd_status_e_str[snd_err_code],
+				   snd_err_code);
 			otx2_write64(pf, NIX_LF_SEND_ERR_DBG, BIT_ULL(44));
 		}
 
-- 
2.42.0



