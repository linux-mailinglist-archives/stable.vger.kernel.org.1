Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB97D31CC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjJWLNV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjJWLNU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:13:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5558C4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:13:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C91AC433C7;
        Mon, 23 Oct 2023 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059598;
        bh=Np/NaxBVxOfOtEiHWmM48Oeyn/J4VeJPYMgcJ0xNETs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mtqd8bVzDBIl+G5uCnazH40X9LNQfwlcConoMf54Yfi8uGowZsFL1TxFv46Tz1s1Q
         1kaFMScdq/+vYxb6/G9tWHuAryOZro8v6QKMa1/gJ+ThzotnyiT0Hnb7Btk1xFE5I3
         xi35W9o9nJwom54pjPiFjoe6xULXFsg44fut53Wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 230/241] phy: qcom-qmp-usb: split PCS_USB init table for sc8280xp and sa8775p
Date:   Mon, 23 Oct 2023 12:56:56 +0200
Message-ID: <20231023104839.481561984@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrien Thierry <athierry@redhat.com>

[ Upstream commit c599dc5cca4dd6a5c664e4a8837246e68a96cb4c ]

For sc8280xp and sa8775p, PCS and PCS_USB initialization data is
described in the same table, thus the pcs_usb offset is not being
applied during initialization of PCS_USB registers. Fix this by adding
the appropriate pcs_usb_tbl tables.

Fixes: 8bd2d6e11c99 ("phy: qcom-qmp: Add SA8775P USB3 UNI phy")
Fixes: c0c7769cdae2 ("phy: qcom-qmp: Add SC8280XP USB3 UNI phy")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Adrien Thierry <athierry@redhat.com>
Link: https://lore.kernel.org/r/20230828152353.16529-3-athierry@redhat.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index f9cb60f12575b..575329004b901 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1480,8 +1480,6 @@ static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0xaa),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCS_TX_RX_CONFIG, 0x0c),
-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_CDR_RESET_TIME, 0x0a),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG1, 0x88),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG2, 0x13),
@@ -1490,6 +1488,11 @@ static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x21),
 };
 
+static const struct qmp_phy_init_tbl sc8280xp_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+};
+
 static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG1, 0xc4),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_LOCK_DETECT_CONFIG2, 0x89),
@@ -1499,9 +1502,6 @@ static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_RX_SIGDET_LVL, 0xaa),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCS_TX_RX_CONFIG, 0x0c),
-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
-	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_POWER_STATE_CONFIG1, 0x6f),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_CDR_RESET_TIME, 0x0a),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG1, 0x88),
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_ALIGN_DETECT_CONFIG2, 0x13),
@@ -1510,6 +1510,12 @@ static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V5_PCS_REFGEN_REQ_CONFIG1, 0x21),
 };
 
+static const struct qmp_phy_init_tbl sa8775p_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_USB3_POWER_STATE_CONFIG1, 0x6f),
+};
+
 struct qmp_usb_offsets {
 	u16 serdes;
 	u16 pcs;
@@ -1788,6 +1794,8 @@ static const struct qmp_phy_cfg sa8775p_usb3_uniphy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
 	.pcs_tbl		= sa8775p_usb3_uniphy_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sa8775p_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sa8775p_usb3_uniphy_pcs_usb_tbl),
 	.clk_list		= qmp_v4_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
 	.reset_list		= qcm2290_usb3phy_reset_l,
@@ -1833,6 +1841,8 @@ static const struct qmp_phy_cfg sc8280xp_usb3_uniphy_cfg = {
 	.rx_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_rx_tbl),
 	.pcs_tbl		= sc8280xp_usb3_uniphy_pcs_tbl,
 	.pcs_tbl_num		= ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= sc8280xp_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sc8280xp_usb3_uniphy_pcs_usb_tbl),
 	.clk_list		= qmp_v4_phy_clk_l,
 	.num_clks		= ARRAY_SIZE(qmp_v4_phy_clk_l),
 	.reset_list		= qcm2290_usb3phy_reset_l,
-- 
2.42.0



