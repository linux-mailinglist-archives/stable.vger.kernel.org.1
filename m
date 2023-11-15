Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CAE7ECE80
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjKOTnd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjKOTnc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:43:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB864AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58883C433C9;
        Wed, 15 Nov 2023 19:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077408;
        bh=vm8utHu1JWhMrz7RcpVNjUUmGJgO9P6c+s+b+xpTFBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQrYCALCWqgwRAGjlSU3re7uITbggFnnWlGup4inJaUFGaorGkP6X0aZr2INxi9sI
         0N2FhxLuP4cX0fzz02pEON/qrAxsFXKIRsEFqR+Ht3WvMuOcq3hlyllLWuxSMyWuok
         KDKUmhTwY3v1nr2NRVlUGRg5Xir6xv+MvgQCs0Tc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 284/603] arm64: dts: qcom: qrb2210-rb1: Fix regulators
Date:   Wed, 15 Nov 2023 14:13:49 -0500
Message-ID: <20231115191633.034115529@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 31bee70793b67f4b428825434542afc72ddb2b3b ]

Commit b4fe47d12f1f ("arm64: dts: qcom: qrb2210-rb1: Add regulators")
introduced regulator settings that were never put in place, as all of the
properties ended 'microvolts' instead of 'microvolt' (which dt schema did
not check for back then).

Fix the microvolts-microvolt typo and adjust voltage ranges where it's
necessary to fit within the volt = base + n*step formula.

Reported-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: b4fe47d12f1f ("arm64: dts: qcom: qrb2210-rb1: Add regulators")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230906-topic-rb1_features_sans_icc-v1-2-e92ce6fbde16@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 86 ++++++++++++------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 5cda5b761455b..0f7c591878962 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -150,15 +150,15 @@ regulators {
 
 		pm2250_s3: s3 {
 			/* 0.4V-1.6625V -> 1.3V (Power tree requirements) */
-			regulator-min-microvolts = <1350000>;
-			regulator-max-microvolts = <1350000>;
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
 			regulator-boot-on;
 		};
 
 		pm2250_s4: s4 {
 			/* 1.2V-2.35V -> 2.05V (Power tree requirements) */
-			regulator-min-microvolts = <2072000>;
-			regulator-max-microvolts = <2072000>;
+			regulator-min-microvolt = <2072000>;
+			regulator-max-microvolt = <2072000>;
 			regulator-boot-on;
 		};
 
@@ -166,47 +166,47 @@ pm2250_s4: s4 {
 
 		pm2250_l2: l2 {
 			/* LPDDR4X VDD2 */
-			regulator-min-microvolts = <1136000>;
-			regulator-max-microvolts = <1136000>;
+			regulator-min-microvolt = <1136000>;
+			regulator-max-microvolt = <1136000>;
 			regulator-always-on;
 			regulator-boot-on;
 		};
 
 		pm2250_l3: l3 {
 			/* LPDDR4X VDDQ */
-			regulator-min-microvolts = <616000>;
-			regulator-max-microvolts = <616000>;
+			regulator-min-microvolt = <616000>;
+			regulator-max-microvolt = <616000>;
 			regulator-always-on;
 			regulator-boot-on;
 		};
 
 		pm2250_l4: l4 {
-			/* max = 3.05V -> max = just below 3V (SDHCI2) */
-			regulator-min-microvolts = <1648000>;
-			regulator-max-microvolts = <2992000>;
+			/* max = 3.05V -> max = 2.7 to disable 3V signaling (SDHCI2) */
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2700000>;
 			regulator-allow-set-load;
 		};
 
 		pm2250_l5: l5 {
 			/* CSI/DSI */
-			regulator-min-microvolts = <1232000>;
-			regulator-max-microvolts = <1232000>;
+			regulator-min-microvolt = <1232000>;
+			regulator-max-microvolt = <1232000>;
 			regulator-allow-set-load;
 			regulator-boot-on;
 		};
 
 		pm2250_l6: l6 {
 			/* DRAM PLL */
-			regulator-min-microvolts = <928000>;
-			regulator-max-microvolts = <928000>;
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <928000>;
 			regulator-always-on;
 			regulator-boot-on;
 		};
 
 		pm2250_l7: l7 {
 			/* Wi-Fi CX/MX */
-			regulator-min-microvolts = <664000>;
-			regulator-max-microvolts = <664000>;
+			regulator-min-microvolt = <664000>;
+			regulator-max-microvolt = <664000>;
 		};
 
 		/*
@@ -216,37 +216,37 @@ pm2250_l7: l7 {
 
 		pm2250_l10: l10 {
 			/* Wi-Fi RFA */
-			regulator-min-microvolts = <1300000>;
-			regulator-max-microvolts = <1300000>;
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
 		};
 
 		pm2250_l11: l11 {
 			/* GPS RF1 */
-			regulator-min-microvolts = <1000000>;
-			regulator-max-microvolts = <1000000>;
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
 			regulator-boot-on;
 		};
 
 		pm2250_l12: l12 {
 			/* USB PHYs */
-			regulator-min-microvolts = <928000>;
-			regulator-max-microvolts = <928000>;
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <928000>;
 			regulator-allow-set-load;
 			regulator-boot-on;
 		};
 
 		pm2250_l13: l13 {
 			/* USB/QFPROM/PLLs */
-			regulator-min-microvolts = <1800000>;
-			regulator-max-microvolts = <1800000>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 			regulator-allow-set-load;
 			regulator-boot-on;
 		};
 
 		pm2250_l14: l14 {
 			/* SDHCI1 VQMMC */
-			regulator-min-microvolts = <1800000>;
-			regulator-max-microvolts = <1800000>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 			regulator-allow-set-load;
 			/* Broken hardware, never turn it off! */
 			regulator-always-on;
@@ -254,8 +254,8 @@ pm2250_l14: l14 {
 
 		pm2250_l15: l15 {
 			/* WCD/DSI/BT VDDIO */
-			regulator-min-microvolts = <1800000>;
-			regulator-max-microvolts = <1800000>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 			regulator-allow-set-load;
 			regulator-always-on;
 			regulator-boot-on;
@@ -263,47 +263,47 @@ pm2250_l15: l15 {
 
 		pm2250_l16: l16 {
 			/* GPS RF2 */
-			regulator-min-microvolts = <1800000>;
-			regulator-max-microvolts = <1800000>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 			regulator-boot-on;
 		};
 
 		pm2250_l17: l17 {
-			regulator-min-microvolts = <3000000>;
-			regulator-max-microvolts = <3000000>;
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
 		};
 
 		pm2250_l18: l18 {
 			/* VDD_PXn */
-			regulator-min-microvolts = <1800000>;
-			regulator-max-microvolts = <1800000>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 		};
 
 		pm2250_l19: l19 {
 			/* VDD_PXn */
-			regulator-min-microvolts = <1800000>;
-			regulator-max-microvolts = <1800000>;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
 		};
 
 		pm2250_l20: l20 {
 			/* SDHCI1 VMMC */
-			regulator-min-microvolts = <2856000>;
-			regulator-max-microvolts = <2856000>;
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3600000>;
 			regulator-allow-set-load;
 		};
 
 		pm2250_l21: l21 {
 			/* SDHCI2 VMMC */
-			regulator-min-microvolts = <2960000>;
-			regulator-max-microvolts = <3300000>;
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <3300000>;
 			regulator-allow-set-load;
 			regulator-boot-on;
 		};
 
 		pm2250_l22: l22 {
 			/* Wi-Fi */
-			regulator-min-microvolts = <3312000>;
-			regulator-max-microvolts = <3312000>;
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3312000>;
 		};
 	};
 };
-- 
2.42.0



