Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A16FABE4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjEHLSe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjEHLSd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4B034118
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC0A061D7C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF595C433EF;
        Mon,  8 May 2023 11:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544711;
        bh=svmuf55Cw/3szkoDp3svpLJem/NMlhco/7UIyO3EWuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlX887rcyskwHqHm5gMmggYddrG9Cykr0Nw1ylacmMySRqQuFx47sfAI+/ojwMW5N
         vHSsJHRCrxWuWoHSdmpqQVaRNxTTVU6xqJrBAUQ9y39LaFN2LlbDSeAKkYBn/nsOrA
         u4xH5NK7CgXHDDqNJLwiNmAEBFx399HbmbSseszs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 499/694] interconnect: qcom: drop obsolete OSM_L3/EPSS defines
Date:   Mon,  8 May 2023 11:45:34 +0200
Message-Id: <20230508094450.224605445@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 4c4161b4c81b632fc29002c324e996cbb79894e7 ]

Since Qualcomm platforms have switched to the separate OSM_L3/EPSS
driver, old related defines became unused. Drop them now.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Fixes: 4529992c9474 ("interconnect: qcom: osm-l3: Use platform-independent node ids")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230103045717.1079067-1-dmitry.baryshkov@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/sc7180.h  | 2 --
 drivers/interconnect/qcom/sc7280.h  | 2 --
 drivers/interconnect/qcom/sc8180x.h | 2 --
 drivers/interconnect/qcom/sdm845.h  | 2 --
 drivers/interconnect/qcom/sm8150.h  | 2 --
 drivers/interconnect/qcom/sm8250.h  | 2 --
 6 files changed, 12 deletions(-)

diff --git a/drivers/interconnect/qcom/sc7180.h b/drivers/interconnect/qcom/sc7180.h
index 7a2b3eb00923c..2b718922c1090 100644
--- a/drivers/interconnect/qcom/sc7180.h
+++ b/drivers/interconnect/qcom/sc7180.h
@@ -145,7 +145,5 @@
 #define SC7180_SLAVE_SERVICE_SNOC			134
 #define SC7180_SLAVE_QDSS_STM				135
 #define SC7180_SLAVE_TCU				136
-#define SC7180_MASTER_OSM_L3_APPS			137
-#define SC7180_SLAVE_OSM_L3				138
 
 #endif
diff --git a/drivers/interconnect/qcom/sc7280.h b/drivers/interconnect/qcom/sc7280.h
index 1fb9839b2c14b..175e400305c51 100644
--- a/drivers/interconnect/qcom/sc7280.h
+++ b/drivers/interconnect/qcom/sc7280.h
@@ -150,7 +150,5 @@
 #define SC7280_SLAVE_PCIE_1			139
 #define SC7280_SLAVE_QDSS_STM			140
 #define SC7280_SLAVE_TCU			141
-#define SC7280_MASTER_EPSS_L3_APPS		142
-#define SC7280_SLAVE_EPSS_L3			143
 
 #endif
diff --git a/drivers/interconnect/qcom/sc8180x.h b/drivers/interconnect/qcom/sc8180x.h
index c138dcd350f1d..f8d90598335a1 100644
--- a/drivers/interconnect/qcom/sc8180x.h
+++ b/drivers/interconnect/qcom/sc8180x.h
@@ -168,8 +168,6 @@
 #define SC8180X_SLAVE_EBI_CH0_DISPLAY		158
 #define SC8180X_SLAVE_MNOC_SF_MEM_NOC_DISPLAY	159
 #define SC8180X_SLAVE_MNOC_HF_MEM_NOC_DISPLAY	160
-#define SC8180X_MASTER_OSM_L3_APPS		161
-#define SC8180X_SLAVE_OSM_L3			162
 
 #define SC8180X_MASTER_QUP_CORE_0		163
 #define SC8180X_MASTER_QUP_CORE_1		164
diff --git a/drivers/interconnect/qcom/sdm845.h b/drivers/interconnect/qcom/sdm845.h
index 776e9c2acb278..bc7e425ce9852 100644
--- a/drivers/interconnect/qcom/sdm845.h
+++ b/drivers/interconnect/qcom/sdm845.h
@@ -136,7 +136,5 @@
 #define SDM845_SLAVE_SERVICE_SNOC			128
 #define SDM845_SLAVE_QDSS_STM				129
 #define SDM845_SLAVE_TCU				130
-#define SDM845_MASTER_OSM_L3_APPS			131
-#define SDM845_SLAVE_OSM_L3				132
 
 #endif /* __DRIVERS_INTERCONNECT_QCOM_SDM845_H__ */
diff --git a/drivers/interconnect/qcom/sm8150.h b/drivers/interconnect/qcom/sm8150.h
index 023161681fb87..1d587c94eb06e 100644
--- a/drivers/interconnect/qcom/sm8150.h
+++ b/drivers/interconnect/qcom/sm8150.h
@@ -148,7 +148,5 @@
 #define SM8150_SLAVE_VSENSE_CTRL_CFG		137
 #define SM8150_SNOC_CNOC_MAS			138
 #define SM8150_SNOC_CNOC_SLV			139
-#define SM8150_MASTER_OSM_L3_APPS		140
-#define SM8150_SLAVE_OSM_L3			141
 
 #endif
diff --git a/drivers/interconnect/qcom/sm8250.h b/drivers/interconnect/qcom/sm8250.h
index e3fc56bc7ca0e..209ab195f21fb 100644
--- a/drivers/interconnect/qcom/sm8250.h
+++ b/drivers/interconnect/qcom/sm8250.h
@@ -158,7 +158,5 @@
 #define SM8250_SLAVE_VSENSE_CTRL_CFG		147
 #define SM8250_SNOC_CNOC_MAS			148
 #define SM8250_SNOC_CNOC_SLV			149
-#define SM8250_MASTER_EPSS_L3_APPS		150
-#define SM8250_SLAVE_EPSS_L3			151
 
 #endif
-- 
2.39.2



