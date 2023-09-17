Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8477A3919
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjIQTpE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbjIQTod (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:44:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D310FE7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:44:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF866C433C8;
        Sun, 17 Sep 2023 19:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979867;
        bh=UK4FhFAAiuGaE9cwKOK3Z3OP3b7PFEjrkbfY57R7dXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqzq92AQU3a2zEKnvM05Kv45L/jGbm0sPkMMpjQkeE5kCa3ndCk7c/1p2fSD7rq9B
         SynOgUHA2DqUxuF9YnDPs3sd/9hxbrjv1ieiyjlJt36rvabk7xBfUvi2qOdHioh9em
         TPkjF5nJ4k6L+qI+gQ6pcA9Tkk/wGepvtpXkqQLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 029/285] arm64: dts: qcom: msm8953-vince: drop duplicated touschreen parent interrupt
Date:   Sun, 17 Sep 2023 21:10:29 +0200
Message-ID: <20230917191052.679242898@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit b019cf7e5fbaa7d25f716cb936a9237b47156f2d upstream.

Interrupts extended already define a parent interrupt controller:

  msm8953-xiaomi-vince.dtb: touchscreen@20: Unevaluated properties are not allowed ('interrupts-parent' was unexpected)

Fixes: aa17e707e04a ("arm64: dts: qcom: msm8953: Add device tree for Xiaomi Redmi 5 Plus")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230720115335.137354-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
index 0956c866d6cb..1a1d3f92a511 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
@@ -132,7 +132,6 @@ &i2c_3 {
 	touchscreen@20 {
 		reg = <0x20>;
 		compatible = "syna,rmi4-i2c";
-		interrupts-parent = <&tlmm>;
 		interrupts-extended = <&tlmm 65 IRQ_TYPE_EDGE_FALLING>;
 
 		#address-cells = <1>;
-- 
2.42.0



