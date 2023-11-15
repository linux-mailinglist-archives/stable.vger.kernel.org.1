Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877867ED127
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbjKOT7r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbjKOT7p (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:59:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38491AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:59:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B4C433C8;
        Wed, 15 Nov 2023 19:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078379;
        bh=vgIfm5XXl4r5NtzSDrqnSMAdOTztE8pRPBaKS8Jl6vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVoBwaV9DQTbgNdc7JTEtOfh9apI7qe2yhIIgvZ3lKqrMTELURYsBxVLzFUpusr9e
         leqBRXQvZxGAgBFbKh2iFsy+0CwTjvCdEOTZiS6IPkV8T1cREovnx4UA42HFTJxUFl
         YnaAO5IfkQve8i8Za+ZrkIShlrLeiroyj90jLEns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 288/379] interconnect: qcom: sm8150: Retire DEFINE_QBCM
Date:   Wed, 15 Nov 2023 14:26:03 -0500
Message-ID: <20231115192702.181086049@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 670699a4225b8cba6962f965b227e0175d09ecda ]

The struct definition macros are hard to read and compare, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Link: https://lore.kernel.org/r/20230811-topic-icc_retire_macrosd-v1-17-c03aaeffc769@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Stable-dep-of: 7ed42176406e ("interconnect: qcom: sm8150: Set ACV enable_mask")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sm8150.c | 283 ++++++++++++++++++++++++++---
 1 file changed, 255 insertions(+), 28 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index c5ab29322164a..640fd4c4a6886 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -154,34 +154,261 @@ DEFINE_QNODE(xs_pcie_1, SM8150_SLAVE_PCIE_1, 1, 8);
 DEFINE_QNODE(xs_qdss_stm, SM8150_SLAVE_QDSS_STM, 1, 4);
 DEFINE_QNODE(xs_sys_tcu_cfg, SM8150_SLAVE_TCU, 1, 8);
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_mm1, "MM1", false, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_hf1_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf0, &qxm_camnoc_hf1, &qxm_mdp0, &qxm_mdp1);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &qns_gem_noc_snoc);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qxm_camnoc_sf, &qns2_mem_noc);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &acm_gpu_tcu, &acm_sys_tcu);
-DEFINE_QBCM(bcm_mm3, "MM3", false, &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &qnm_cmpnoc);
-DEFINE_QBCM(bcm_sh5, "SH5", false, &acm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
-DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_mem_noc);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_co1, "CO1", false, &qnm_npu);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &qhm_spdm, &qnm_snoc, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy_south, &qhs_aop, &qhs_aoss, &qhs_camera_cfg, &qhs_clk_ctl, &qhs_compute_dsp, &qhs_cpr_cx, &qhs_cpr_mmcx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_emac_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_npu_cfg, &qhs_pcie0_cfg, &qhs_pcie1_cfg, &qhs_phy_refgen_north, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qspi, &qhs_qupv3_east, &qhs_qupv3_north, &qhs_qupv3_south, &qhs_sdc2, &qhs_sdc4, &qhs_snoc_cfg, &qhs_spdm, &qhs_spss_cfg, &qhs_ssc_cfg, &qhs_tcsr, &qhs_tlmm_east, &qhs_tlmm_north, &qhs_tlmm_south, &qhs_tlmm_west, &qhs_tsif, &qhs_ufs_card_cfg, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_usb3_1, &qhs_venus_cfg, &qhs_vsense_ctrl_cfg, &qns_cnoc_a2noc, &srvc_cnoc);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qhm_qup0, &qhm_qup1, &qhm_qup2);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &srvc_aggre1_noc, &srvc_aggre2_noc, &qns_cnoc);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &qxs_pimem);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &xs_pcie_0, &xs_pcie_1);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn11, "SN11", false, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn12, "SN12", false, &qxm_pimem, &xm_gic);
-DEFINE_QBCM(bcm_sn14, "SN14", false, &qns_pcie_mem_noc);
-DEFINE_QBCM(bcm_sn15, "SN15", false, &qnm_gemnoc);
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.keepalive = false,
+	.num_nodes = 7,
+	.nodes = { &qxm_camnoc_hf0_uncomp,
+		   &qxm_camnoc_hf1_uncomp,
+		   &qxm_camnoc_sf_uncomp,
+		   &qxm_camnoc_hf0,
+		   &qxm_camnoc_hf1,
+		   &qxm_mdp0,
+		   &qxm_mdp1
+	},
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_gem_noc_snoc },
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qxm_camnoc_sf, &qns2_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &acm_gpu_tcu, &acm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.num_nodes = 4,
+	.nodes = { &qxm_rot, &qxm_venus0, &qxm_venus1, &qxm_venus_arm9 },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_sh5 = {
+	.name = "SH5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &acm_apps },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_cdsp_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_co1 = {
+	.name = "CO1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 53,
+	.nodes = { &qhm_spdm,
+		   &qnm_snoc,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy_south,
+		   &qhs_aop,
+		   &qhs_aoss,
+		   &qhs_camera_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_compute_dsp,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mmcx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_emac_cfg,
+		   &qhs_glm,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mnoc_cfg,
+		   &qhs_npu_cfg,
+		   &qhs_pcie0_cfg,
+		   &qhs_pcie1_cfg,
+		   &qhs_phy_refgen_north,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qspi,
+		   &qhs_qupv3_east,
+		   &qhs_qupv3_north,
+		   &qhs_qupv3_south,
+		   &qhs_sdc2,
+		   &qhs_sdc4,
+		   &qhs_snoc_cfg,
+		   &qhs_spdm,
+		   &qhs_spss_cfg,
+		   &qhs_ssc_cfg,
+		   &qhs_tcsr,
+		   &qhs_tlmm_east,
+		   &qhs_tlmm_north,
+		   &qhs_tlmm_south,
+		   &qhs_tlmm_west,
+		   &qhs_tsif,
+		   &qhs_ufs_card_cfg,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0,
+		   &qhs_usb3_1,
+		   &qhs_venus_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &qns_cnoc_a2noc,
+		   &srvc_cnoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = false,
+	.num_nodes = 3,
+	.nodes = { &qhm_qup0, &qhm_qup1, &qhm_qup2 },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_gc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.num_nodes = 3,
+	.nodes = { &srvc_aggre1_noc, &srvc_aggre2_noc, &qns_cnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &xs_pcie_0, &xs_pcie_1 },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn11 = {
+	.name = "SN11",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn12 = {
+	.name = "SN12",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qxm_pimem, &xm_gic },
+};
+
+static struct qcom_icc_bcm bcm_sn14 = {
+	.name = "SN14",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn15 = {
+	.name = "SN15",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_qup0,
-- 
2.42.0



