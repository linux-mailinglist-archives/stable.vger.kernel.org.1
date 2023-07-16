Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CBC7553C8
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjGPUW6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGPUWx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265F1B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2275560EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA3CC433C7;
        Sun, 16 Jul 2023 20:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538971;
        bh=dQvGgRmeWDebYmrjcUuW9pJlQaoBZO15RZPdm+KoYXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAUoR5FxeLgy4ubYEIUZn2pLuUTAqoRQoo8Zb99L3bChnkrTOd+K85OgX+ce+YKfL
         8KehWl+0LILwj/d7Sy+hVztjVlGGH2l2/JodxahH1GW9iROU2xBlAtRHDVJ5jyj+ME
         BW6Ir47oPr0F5WPj5W0Wpy0VauglOMx/qqRZtqss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 642/800] phy: qcom: qmp-combo: fix Display Port PHY configuration for SM8550
Date:   Sun, 16 Jul 2023 21:48:15 +0200
Message-ID: <20230716195004.025321157@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit 6cd52a2a06774c6c454ffef084c3d9b17618ca23 ]

The SM8550 PHY also uses a different offset for the CMN_STATUS reg,
use the right one for the v6 Display Port configuration.

Fixes: 49742e9edab3 ("phy: qcom-qmp-combo: Add support for SM8550")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230601-topic-sm8550-upstream-dp-phy-init-fix-v1-1-4e9da9f97991@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 87b17e5877ab8..1fdcc81661ed8 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2142,6 +2142,7 @@ static void qmp_v4_configure_dp_tx(struct qmp_combo *qmp)
 static int qmp_v456_configure_dp_phy(struct qmp_combo *qmp,
 				     unsigned int com_resetm_ctrl_reg,
 				     unsigned int com_c_ready_status_reg,
+				     unsigned int com_cmn_status_reg,
 				     unsigned int dp_phy_status_reg)
 {
 	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
@@ -2198,14 +2199,14 @@ static int qmp_v456_configure_dp_phy(struct qmp_combo *qmp,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
+	if (readl_poll_timeout(qmp->dp_serdes + com_cmn_status_reg,
 			status,
 			((status & BIT(0)) > 0),
 			500,
 			10000))
 		return -ETIMEDOUT;
 
-	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_V4_COM_CMN_STATUS,
+	if (readl_poll_timeout(qmp->dp_serdes + com_cmn_status_reg,
 			status,
 			((status & BIT(1)) > 0),
 			500,
@@ -2241,6 +2242,7 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
 
 	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
 					QSERDES_V4_COM_C_READY_STATUS,
+					QSERDES_V4_COM_CMN_STATUS,
 					QSERDES_V4_DP_PHY_STATUS);
 	if (ret < 0)
 		return ret;
@@ -2305,6 +2307,7 @@ static int qmp_v5_configure_dp_phy(struct qmp_combo *qmp)
 
 	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V4_COM_RESETSM_CNTRL,
 					QSERDES_V4_COM_C_READY_STATUS,
+					QSERDES_V4_COM_CMN_STATUS,
 					QSERDES_V4_DP_PHY_STATUS);
 	if (ret < 0)
 		return ret;
@@ -2364,6 +2367,7 @@ static int qmp_v6_configure_dp_phy(struct qmp_combo *qmp)
 
 	ret = qmp_v456_configure_dp_phy(qmp, QSERDES_V6_COM_RESETSM_CNTRL,
 					QSERDES_V6_COM_C_READY_STATUS,
+					QSERDES_V6_COM_CMN_STATUS,
 					QSERDES_V6_DP_PHY_STATUS);
 	if (ret < 0)
 		return ret;
-- 
2.39.2



