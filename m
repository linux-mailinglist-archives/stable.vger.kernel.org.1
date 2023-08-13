Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610CF77ABF6
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjHMV1m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjHMV1m (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CEE10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED2AF629FF
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F455C433C7;
        Sun, 13 Aug 2023 21:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962063;
        bh=35N4bKQTvZJrhA0Sejk+G8tyokwZGg18+pTAd/wrCHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgzmmT7viD23QJysTJifudyE6t/8+WxdEcz19lTZhy+DFO4/ZLHIzYWF5Trd/+dez
         m7i06uE9VylWJSGwzbuNLnAzjX4u1cg6XUWDKGOsZlHeeW1VmGuHURCKIHbyD/qEeM
         q2DTIjAdn3W9vuszryZi8lDBkRKoJ4JEUQuzcGtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Subject: [PATCH 6.4 100/206] interconnect: qcom: sm8550: add enable_mask for bcm nodes
Date:   Sun, 13 Aug 2023 23:17:50 +0200
Message-ID: <20230813211727.923067382@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

commit 0dc82bd9e4627065dbc6ac8468296aa18f13c840 upstream.

Set the proper enable_mask to nodes requiring such value
to be used instead of a bandwidth when voting.

The masks were copied from the downstream implementation at [1].

[1] https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r1-rel/drivers/interconnect/qcom/kalama.c

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20230619-topic-sm8550-upstream-interconnect-mask-vote-v2-3-709474b151cc@linaro.org
Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/interconnect/qcom/sm8550.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index d823ba988ef6..0864ed285375 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -1473,6 +1473,7 @@ static struct qcom_icc_node qns_mem_noc_sf_cam_ife_2 = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = 0x8,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
@@ -1485,6 +1486,7 @@ static struct qcom_icc_bcm bcm_ce0 = {
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
+	.enable_mask = 0x1,
 	.keepalive = true,
 	.num_nodes = 54,
 	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
@@ -1524,6 +1526,7 @@ static struct qcom_icc_bcm bcm_cn1 = {
 
 static struct qcom_icc_bcm bcm_co0 = {
 	.name = "CO0",
+	.enable_mask = 0x1,
 	.num_nodes = 2,
 	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
 };
@@ -1549,6 +1552,7 @@ static struct qcom_icc_bcm bcm_mm0 = {
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 8,
 	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
 		   &qnm_camnoc_sf, &qnm_vapss_hcp,
@@ -1589,6 +1593,7 @@ static struct qcom_icc_bcm bcm_sh0 = {
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 13,
 	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
 		   &chm_apps, &qnm_gpu,
@@ -1608,6 +1613,7 @@ static struct qcom_icc_bcm bcm_sn0 = {
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
+	.enable_mask = 0x1,
 	.num_nodes = 3,
 	.nodes = { &qhm_gic, &xm_gic,
 		   &qns_gemnoc_gc },
@@ -1633,6 +1639,7 @@ static struct qcom_icc_bcm bcm_sn7 = {
 
 static struct qcom_icc_bcm bcm_acv_disp = {
 	.name = "ACV",
+	.enable_mask = 0x1,
 	.num_nodes = 1,
 	.nodes = { &ebi_disp },
 };
@@ -1657,12 +1664,14 @@ static struct qcom_icc_bcm bcm_sh0_disp = {
 
 static struct qcom_icc_bcm bcm_sh1_disp = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 2,
 	.nodes = { &qnm_mnoc_hf_disp, &qnm_pcie_disp },
 };
 
 static struct qcom_icc_bcm bcm_acv_cam_ife_0 = {
 	.name = "ACV",
+	.enable_mask = 0x0,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_0 },
 };
@@ -1681,6 +1690,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_0 = {
 
 static struct qcom_icc_bcm bcm_mm1_cam_ife_0 = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf_cam_ife_0, &qnm_camnoc_icp_cam_ife_0,
 		   &qnm_camnoc_sf_cam_ife_0, &qns_mem_noc_sf_cam_ife_0 },
@@ -1694,6 +1704,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_0 = {
 
 static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 3,
 	.nodes = { &qnm_mnoc_hf_cam_ife_0, &qnm_mnoc_sf_cam_ife_0,
 		   &qnm_pcie_cam_ife_0 },
@@ -1701,6 +1712,7 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
 
 static struct qcom_icc_bcm bcm_acv_cam_ife_1 = {
 	.name = "ACV",
+	.enable_mask = 0x0,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_1 },
 };
@@ -1719,6 +1731,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_1 = {
 
 static struct qcom_icc_bcm bcm_mm1_cam_ife_1 = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf_cam_ife_1, &qnm_camnoc_icp_cam_ife_1,
 		   &qnm_camnoc_sf_cam_ife_1, &qns_mem_noc_sf_cam_ife_1 },
@@ -1732,6 +1745,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_1 = {
 
 static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 3,
 	.nodes = { &qnm_mnoc_hf_cam_ife_1, &qnm_mnoc_sf_cam_ife_1,
 		   &qnm_pcie_cam_ife_1 },
@@ -1739,6 +1753,7 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
 
 static struct qcom_icc_bcm bcm_acv_cam_ife_2 = {
 	.name = "ACV",
+	.enable_mask = 0x0,
 	.num_nodes = 1,
 	.nodes = { &ebi_cam_ife_2 },
 };
@@ -1757,6 +1772,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_2 = {
 
 static struct qcom_icc_bcm bcm_mm1_cam_ife_2 = {
 	.name = "MM1",
+	.enable_mask = 0x1,
 	.num_nodes = 4,
 	.nodes = { &qnm_camnoc_hf_cam_ife_2, &qnm_camnoc_icp_cam_ife_2,
 		   &qnm_camnoc_sf_cam_ife_2, &qns_mem_noc_sf_cam_ife_2 },
@@ -1770,6 +1786,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_2 = {
 
 static struct qcom_icc_bcm bcm_sh1_cam_ife_2 = {
 	.name = "SH1",
+	.enable_mask = 0x1,
 	.num_nodes = 3,
 	.nodes = { &qnm_mnoc_hf_cam_ife_2, &qnm_mnoc_sf_cam_ife_2,
 		   &qnm_pcie_cam_ife_2 },
-- 
2.41.0



