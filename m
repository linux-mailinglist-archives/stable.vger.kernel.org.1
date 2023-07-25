Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F176144A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbjGYLRo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjGYLRm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9ECE7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6787261683
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782CEC433C9;
        Tue, 25 Jul 2023 11:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283860;
        bh=V+/5q8Dck38EU8gZteKH3IgFoOMfy70Kbdu4MfCgY/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDOPobBvQJ9zFNJdag7faww2UaQ/VTgXvnDKq8715THIO7Z6flevaWxoVMRsAl742
         B9d3jT262dPFndNo6/O4IezyUSWD8JLK/i2NkrW1NdVZbyCFCqAMw3Cc0D6mYtJ75k
         sCFEb9dDF6OTUSgiTKjEmuy7UifJhNZTC4YLogPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 121/509] arm64: dts: qcom: msm8994: correct SPMI unit address
Date:   Tue, 25 Jul 2023 12:41:00 +0200
Message-ID: <20230725104559.217691765@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 24f0f6a8059c7108d4ee3476c95db1e7ff4feb79 ]

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc/spmi@fc4c0000: simple-bus unit address format error, expected "fc4cf000"

Fixes: b0ad598f8ec0 ("arm64: dts: qcom: msm8994: Add SPMI PMIC arbiter device")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230419211856.79332-8-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index aeb5762566e91..caaf7102f5798 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -489,7 +489,7 @@ restart@fc4ab000 {
 			reg = <0xfc4ab000 0x4>;
 		};
 
-		spmi_bus: spmi@fc4c0000 {
+		spmi_bus: spmi@fc4cf000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xfc4cf000 0x1000>,
 			      <0xfc4cb000 0x1000>,
-- 
2.39.2



