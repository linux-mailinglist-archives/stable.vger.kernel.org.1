Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF179BC5E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350852AbjIKVlu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbjIKOBX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:01:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB7CCD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:01:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F0BC433C8;
        Mon, 11 Sep 2023 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440878;
        bh=dA73C6qVbUmmPJoF5BvlcJGza3f3ADuhckv7fcmCiFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JB8asoanLGPr0bYm8skPp2+VPlt8GuPxqFvVLnCq0d2POvHThvdf9BVcQaHpU2jQ4
         xL4Y6iEIkfF+9eGhfMEY031CwvS/EktEWgeelaqkmFYzZuKUxiokxVGt7LgNbtXthN
         Kr9dgPd5kn886WPTYVvtlFgV0kV36M77Ox6Xk7ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 217/739] arm64: dts: qcom: sm8450: correct crypto unit address
Date:   Mon, 11 Sep 2023 15:40:16 +0200
Message-ID: <20230911134657.249374224@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit b02966f8689795406ac210189924a8cb02a71bbe ]

Crypto node unit address should match reg.

Fixes: b92b0d2f7582 ("arm64: dts: qcom: sm8450: add crypto nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230616174955.1783652-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 5cd7296c76605..1c71c0a2cd811 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4212,7 +4212,7 @@ cryptobam: dma-controller@1dc4000 {
 				 <&apps_smmu 0x59f 0x0>;
 		};
 
-		crypto: crypto@1de0000 {
+		crypto: crypto@1dfa000 {
 			compatible = "qcom,sm8450-qce", "qcom,sm8150-qce", "qcom,qce";
 			reg = <0 0x01dfa000 0 0x6000>;
 			dmas = <&cryptobam 4>, <&cryptobam 5>;
-- 
2.40.1



