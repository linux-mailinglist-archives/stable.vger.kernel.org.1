Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B467ECE84
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjKOTnj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbjKOTni (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:43:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44244AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F7C433C7;
        Wed, 15 Nov 2023 19:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077414;
        bh=70QVZJR0NDo0u0C5tKfI0RSdAMfxkSV3EP7QqWkC10I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqmSR7XqhNsZdrglPnmGsufbgMVxULWVACXyKCNvaAuKH47SH95uTTQI4lRPMJEPX
         XGkr/FgtlXjtYqrNi6UwWFL5Us70g5+auZT1RAetJNyXEBEOjlrm/h4p/SJR9+KTpT
         YunSiIaVIzGqAI5PZRshtwNjeBBNALVBuLyBQ2fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 288/603] arm64: dts: qcom: sm8350: fix pinctrl for UART18
Date:   Wed, 15 Nov 2023 14:13:53 -0500
Message-ID: <20231115191633.310006215@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit c1efa960114f743924b884da098298512a7e9983 ]

On sm8350 QUP18 uses GPIO 68/69, not 58/59. Fix correponding UART18
pinconf configuraion.

Fixes: 98374e6925b8 ("arm64: dts: qcom: sm8350: Set up WRAP2 QUPs")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230825214550.1650938-1-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 00604bf7724f4..a94e069da83d5 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2964,7 +2964,7 @@ qup_uart6_default: qup-uart6-default-state {
 			};
 
 			qup_uart18_default: qup-uart18-default-state {
-				pins = "gpio58", "gpio59";
+				pins = "gpio68", "gpio69";
 				function = "qup18";
 				drive-strength = <2>;
 				bias-disable;
-- 
2.42.0



