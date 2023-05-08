Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF386FA753
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjEHK3c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjEHK3U (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF22551F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 388A462678
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3311BC433D2;
        Mon,  8 May 2023 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541757;
        bh=1gBYmoLoFVbN2uVz0sASRQB8yzD8hpkM8OGxQfWXyKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZL3XtyaN7QrklRZCg065B9WwrwfRq/dkyL6jhCs+PG8XhL4X85YR/tu5vO+2PzMc
         pxmjILpRDAwpc35uOTCsyQQf7noNF7GKonqodFvG9DY5OPu8lhHpWeuW2uHMMW7VP/
         DJRRVpqKiWeRmnOXryIMN7riZ9y6+P+PruBKM9jQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 218/663] arm64: dts: qcom: msm8998-oneplus-cheeseburger: revert "fix backlight pin function"
Date:   Mon,  8 May 2023 11:40:44 +0200
Message-Id: <20230508094435.415837694@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 97b4fdc6b82d6d5cfb92a9b164540278720fb700 ]

This reverts commit 46546f28825cf3a5ef6873b9cf947cd85c8a7258 because it
mistakenly took PMIC pinctrl/GPIO as TLMM.  The TLMM pinctrl uses "gpio"
function, but PMIC uses "normal", so original code was correct:

  msm8998-oneplus-cheeseburger.dtb: pmic@2: gpio@c000:button-backlight-state: 'oneOf' conditional failed, one must be fixed:
    'gpio' is not one of ['normal', 'paired', 'func1', 'func2', 'dtest1', 'dtest2', 'dtest3', 'dtest4', 'func3', 'func4']

Fixes: 46546f28825c ("arm64: dts: qcom: msm8998-oneplus-cheeseburger: fix backlight pin function")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230312183622.460488-5-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
index 9fb1fb9b85298..794e9f2ab77ab 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
@@ -34,7 +34,7 @@
 &pmi8998_gpio {
 	button_backlight_default: button-backlight-state {
 		pins = "gpio5";
-		function = "gpio";
+		function = "normal";
 		bias-pull-down;
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
-- 
2.39.2



