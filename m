Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C179C0F3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349006AbjIKVcO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241801AbjIKPOw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:14:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C9FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:14:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3B6C433C8;
        Mon, 11 Sep 2023 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445288;
        bh=bjNL/FppvAcc/H+XGzELytcvevrDSr9/OSqvzJFMzPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxHUDA9hZ9quKYQe70SrhVnUCYlw/njTsE2ku2KiNJiquQ0gr8UMcXVSy2LZEnxUV
         rC+tpgSzsx+id8kPji9xE637Etm6k0NnLUXG5+MXyGhl+4AzUUM5Xf2I+7KHufKZx/
         RIKnH90sgb5GLiU+IxS3EZSTo8nJVG5GA0Q2jLUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 255/600] arm64: dts: qcom: sm8250-sony-xperia: correct GPIO keys wakeup again
Date:   Mon, 11 Sep 2023 15:44:48 +0200
Message-ID: <20230911134641.133280136@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit b8fbeea0253211d97c579eae787274633d3eaf0d ]

gpio-keys,wakeup is a deprecated property:

  m8250-sony-xperia-edo-pdx206.dtb: gpio-keys: key-camera-focus: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)

Fixes: a422c6a91a66 ("arm64: dts: qcom: sm8250-edo: Rectify gpio-keys")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230711063011.16222-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index 259798a959749..3b710c6a326a5 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -60,7 +60,7 @@ key-camera-focus {
 			gpios = <&pm8150b_gpios 2 GPIO_ACTIVE_LOW>;
 			debounce-interval = <15>;
 			linux,can-disable;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key-camera-snapshot {
@@ -69,7 +69,7 @@ key-camera-snapshot {
 			gpios = <&pm8150b_gpios 1 GPIO_ACTIVE_LOW>;
 			debounce-interval = <15>;
 			linux,can-disable;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		key-vol-down {
-- 
2.40.1



