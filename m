Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AD07ED124
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbjKOT7j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbjKOT7h (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:59:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A1B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:59:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4872BC433C7;
        Wed, 15 Nov 2023 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078373;
        bh=cqVRqYGFDoW2NU9o80iDz5zjBU/TY9575kY3k6Agzew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBTSDhT/PcoSgr7/sY3Jjao9iZOVnbaHB14/PlfkA5+Om668tVJghr0YwgXD+VGZU
         CzKTzwpSpXwfghdTJ/AIrZfh+BsACs33O3bPWgyTXSQua5jwJJZF/wKVT9yJcomafM
         v6Qar7+7Rh7RphoVezZ0GSzfmzkoXDW8vKNh4jpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 284/379] interconnect: qcom: sm6350: Retire DEFINE_QBCM
Date:   Wed, 15 Nov 2023 14:25:59 -0500
Message-ID: <20231115192701.923823434@linuxfoundation.org>
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

[ Upstream commit ab2c1cb5740a7d2240b40b7b494700078db4eb13 ]

The struct definition macros are hard to read and compare, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Link: https://lore.kernel.org/r/20230811-topic-icc_retire_macrosd-v1-16-c03aaeffc769@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Stable-dep-of: fe7a3abf4111 ("interconnect: qcom: sm6350: Set ACV enable_mask")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sm6350.c | 251 ++++++++++++++++++++++++++---
 1 file changed, 226 insertions(+), 25 deletions(-)

diff --git a/drivers/interconnect/qcom/sm6350.c b/drivers/interconnect/qcom/sm6350.c
index a3d46e59444e0..8a33a39f13260 100644
--- a/drivers/interconnect/qcom/sm6350.c
+++ b/drivers/interconnect/qcom/sm6350.c
@@ -142,31 +142,232 @@ DEFINE_QNODE(srvc_snoc, SM6350_SLAVE_SERVICE_SNOC, 1, 4);
 DEFINE_QNODE(xs_qdss_stm, SM6350_SLAVE_QDSS_STM, 1, 4);
 DEFINE_QNODE(xs_sys_tcu_cfg, SM6350_SLAVE_TCU, 1, 8);
 
-DEFINE_QBCM(bcm_acv, "ACV", false, &ebi);
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_cn0, "CN0", true, &qnm_snoc, &xm_qdss_dap, &qhs_a1_noc_cfg, &qhs_a2_noc_cfg, &qhs_ahb2phy0, &qhs_aoss, &qhs_boot_rom, &qhs_camera_cfg, &qhs_camera_nrt_thrott_cfg, &qhs_camera_rt_throttle_cfg, &qhs_clk_ctl, &qhs_cpr_cx, &qhs_cpr_mx, &qhs_crypto0_cfg, &qhs_dcc_cfg, &qhs_ddrss_cfg, &qhs_display_cfg, &qhs_display_throttle_cfg, &qhs_glm, &qhs_gpuss_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mnoc_cfg, &qhs_mss_cfg, &qhs_npu_cfg, &qhs_pimem_cfg, &qhs_prng, &qhs_qdss_cfg, &qhs_qm_cfg, &qhs_qm_mpu_cfg, &qhs_qup0, &qhs_qup1, &qhs_security, &qhs_snoc_cfg, &qhs_tcsr, &qhs_ufs_mem_cfg, &qhs_usb3_0, &qhs_venus_cfg, &qhs_venus_throttle_cfg, &qhs_vsense_ctrl_cfg, &srvc_cnoc);
-DEFINE_QBCM(bcm_cn1, "CN1", false, &xm_emmc, &xm_sdc2, &qhs_ahb2phy2, &qhs_emmc_cfg, &qhs_pdm, &qhs_sdc2);
-DEFINE_QBCM(bcm_co0, "CO0", false, &qns_cdsp_gemnoc);
-DEFINE_QBCM(bcm_co2, "CO2", false, &qnm_npu);
-DEFINE_QBCM(bcm_co3, "CO3", false, &qxm_npu_dsp);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_mm0, "MM0", true, &qns_mem_noc_hf);
-DEFINE_QBCM(bcm_mm1, "MM1", true, &qxm_camnoc_hf0_uncomp, &qxm_camnoc_icp_uncomp, &qxm_camnoc_sf_uncomp, &qxm_camnoc_hf, &qxm_mdp0);
-DEFINE_QBCM(bcm_mm2, "MM2", false, &qns_mem_noc_sf);
-DEFINE_QBCM(bcm_mm3, "MM3", false, &qhm_mnoc_cfg, &qnm_video0, &qnm_video_cvp, &qxm_camnoc_sf);
-DEFINE_QBCM(bcm_qup0, "QUP0", false, &qup0_core_master, &qup1_core_master, &qup0_core_slave, &qup1_core_slave);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_sh2, "SH2", false, &acm_sys_tcu);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &qnm_cmpnoc);
-DEFINE_QBCM(bcm_sh4, "SH4", false, &acm_apps);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_gemnoc_sf);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &qns_gemnoc_gc);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &qxs_pimem);
-DEFINE_QBCM(bcm_sn4, "SN4", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &qnm_aggre1_noc);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &qnm_aggre2_noc);
-DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_gemnoc);
+static struct qcom_icc_bcm bcm_acv = {
+	.name = "ACV",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.keepalive = true,
+	.num_nodes = 41,
+	.nodes = { &qnm_snoc,
+		   &xm_qdss_dap,
+		   &qhs_a1_noc_cfg,
+		   &qhs_a2_noc_cfg,
+		   &qhs_ahb2phy0,
+		   &qhs_aoss,
+		   &qhs_boot_rom,
+		   &qhs_camera_cfg,
+		   &qhs_camera_nrt_thrott_cfg,
+		   &qhs_camera_rt_throttle_cfg,
+		   &qhs_clk_ctl,
+		   &qhs_cpr_cx,
+		   &qhs_cpr_mx,
+		   &qhs_crypto0_cfg,
+		   &qhs_dcc_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_display_cfg,
+		   &qhs_display_throttle_cfg,
+		   &qhs_glm,
+		   &qhs_gpuss_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mnoc_cfg,
+		   &qhs_mss_cfg,
+		   &qhs_npu_cfg,
+		   &qhs_pimem_cfg,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qm_cfg,
+		   &qhs_qm_mpu_cfg,
+		   &qhs_qup0,
+		   &qhs_qup1,
+		   &qhs_security,
+		   &qhs_snoc_cfg,
+		   &qhs_tcsr,
+		   &qhs_ufs_mem_cfg,
+		   &qhs_usb3_0,
+		   &qhs_venus_cfg,
+		   &qhs_venus_throttle_cfg,
+		   &qhs_vsense_ctrl_cfg,
+		   &srvc_cnoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.keepalive = false,
+	.num_nodes = 6,
+	.nodes = { &xm_emmc,
+		   &xm_sdc2,
+		   &qhs_ahb2phy2,
+		   &qhs_emmc_cfg,
+		   &qhs_pdm,
+		   &qhs_sdc2
+	},
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_cdsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_co2 = {
+	.name = "CO2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_npu },
+};
+
+static struct qcom_icc_bcm bcm_co3 = {
+	.name = "CO3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_npu_dsp },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
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
+	.keepalive = true,
+	.num_nodes = 5,
+	.nodes = { &qxm_camnoc_hf0_uncomp,
+		   &qxm_camnoc_icp_uncomp,
+		   &qxm_camnoc_sf_uncomp,
+		   &qxm_camnoc_hf,
+		   &qxm_mdp0
+	},
+};
+
+static struct qcom_icc_bcm bcm_mm2 = {
+	.name = "MM2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_mm3 = {
+	.name = "MM3",
+	.keepalive = false,
+	.num_nodes = 4,
+	.nodes = { &qhm_mnoc_cfg, &qnm_video0, &qnm_video_cvp, &qxm_camnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup0 = {
+	.name = "QUP0",
+	.keepalive = false,
+	.num_nodes = 4,
+	.nodes = { &qup0_core_master, &qup1_core_master, &qup0_core_slave, &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh2 = {
+	.name = "SH2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &acm_sys_tcu },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_cmpnoc },
+};
+
+static struct qcom_icc_bcm bcm_sh4 = {
+	.name = "SH4",
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
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
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
+	.num_nodes = 1,
+	.nodes = { &qxs_pimem },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn10 = {
+	.name = "SN10",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_gemnoc },
+};
 
 static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 	&bcm_cn1,
-- 
2.42.0



