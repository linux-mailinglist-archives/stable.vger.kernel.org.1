Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EF179B3DA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378629AbjIKWgH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbjIKOBc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:01:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B88CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:01:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12844C433C9;
        Mon, 11 Sep 2023 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440887;
        bh=p3prK6mY6fnfhk30HVMrXa0O+ohPnEgjEIf/4Nx6vS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zWG++6fb+ywEKiPt3eotg+0/MulTipHDBgzdpKc3VvYZb2dN0wgaNzNppARokeSQX
         XPLP7aWefUVQSkQQSOggsbT59Y6gll29heFWk/SkMoqw7sBz0gfjAchlkWYYMi4Vvv
         P/c+U1+BRM5xfGPhJ6yl21IDrxDiv9M0Eq2o/GsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 220/739] arm64: dts: qcom: sm8250-edo: Add GPIO line names for PMIC GPIOs
Date:   Mon, 11 Sep 2023 15:40:19 +0200
Message-ID: <20230911134657.331137428@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 6b8a63350752c6a5e4b54f2de6174084652cd3cd ]

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the PDX203&206 DTSIs to better document the hardware.

Diff between 203 and 206:
pm8009_gpios
<                         "CAM_PWR_LD_EN",
>                         "NC",

pm8150_gpios
<                         "NC",
>                         "G_ASSIST_N",
<                         "WLC_EN_N", /* GPIO_10 */
>                         "NC", /* GPIO_10 */
Which is due to 5 II having an additional Google Assistant hardware
button and 1 II having a wireless charger & different camera wiring
to accommodate the additional 3D iToF sensor.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230614-topic-edo_pinsgpiopmic-v2-2-6f90bba54c53@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: a422c6a91a66 ("arm64: dts: qcom: sm8250-edo: Rectify gpio-keys")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../qcom/sm8250-sony-xperia-edo-pdx203.dts    | 50 +++++++++++++++++++
 .../qcom/sm8250-sony-xperia-edo-pdx206.dts    | 50 +++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
index 84104d2b20101..62590c6bd3067 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
@@ -15,6 +15,56 @@ / {
 
 /delete-node/ &vreg_l7f_1p8;
 
+&pm8009_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "CAM_PWR_LD_EN",
+			  "WIDEC_PWR_EN",
+			  "NC";
+};
+
+&pm8150_gpios {
+	gpio-line-names = "VOL_DOWN_N", /* GPIO_1 */
+			  "OPTION_2",
+			  "NC",
+			  "PM_SLP_CLK_IN",
+			  "OPTION_1",
+			  "NC",
+			  "NC",
+			  "SP_ARI_PWR_ALARM",
+			  "NC",
+			  "NC"; /* GPIO_10 */
+};
+
+&pm8150b_gpios {
+	gpio-line-names = "SNAPSHOT_N", /* GPIO_1 */
+			  "FOCUS_N",
+			  "NC",
+			  "NC",
+			  "RF_LCD_ID_EN",
+			  "NC",
+			  "NC",
+			  "LCD_ID",
+			  "NC",
+			  "WLC_EN_N", /* GPIO_10 */
+			  "NC",
+			  "RF_ID";
+};
+
+&pm8150l_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "PM3003A_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "AUX2_THERM",
+			  "BB_HP_EN",
+			  "FP_LDO_EN",
+			  "PMX_RESET_N",
+			  "AUX3_THERM", /* GPIO_10 */
+			  "DTV_PWR_EN",
+			  "PM3003A_MODE";
+};
+
 &tlmm {
 	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
 			  "MDM2AP_ERR_FATAL",
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
index fae6568cb79e4..ea4571bf4fbf0 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
@@ -30,6 +30,56 @@ g-assist-key {
 	};
 };
 
+&pm8009_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "WIDEC_PWR_EN",
+			  "NC";
+};
+
+&pm8150_gpios {
+	gpio-line-names = "VOL_DOWN_N", /* GPIO_1 */
+			  "OPTION_2",
+			  "NC",
+			  "PM_SLP_CLK_IN",
+			  "OPTION_1",
+			  "G_ASSIST_N",
+			  "NC",
+			  "SP_ARI_PWR_ALARM",
+			  "NC",
+			  "NC"; /* GPIO_10 */
+};
+
+&pm8150b_gpios {
+	gpio-line-names = "SNAPSHOT_N", /* GPIO_1 */
+			  "FOCUS_N",
+			  "NC",
+			  "NC",
+			  "RF_LCD_ID_EN",
+			  "NC",
+			  "NC",
+			  "LCD_ID",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "RF_ID";
+};
+
+&pm8150l_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "PM3003A_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "AUX2_THERM",
+			  "BB_HP_EN",
+			  "FP_LDO_EN",
+			  "PMX_RESET_N",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "PM3003A_MODE";
+};
+
 &tlmm {
 	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
 			  "MDM2AP_ERR_FATAL",
-- 
2.40.1



