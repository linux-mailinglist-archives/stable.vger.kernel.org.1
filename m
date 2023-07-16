Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFE0755550
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjGPUjn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjGPUjn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E4BA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3A9C60EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A0DC433C7;
        Sun, 16 Jul 2023 20:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539981;
        bh=54IZKhYg/BNLjfv7gezrpKL3c3jLu55J1I3svTMo1D4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzxzKsR+7SsSSNsgd9ISUkOuGW2FSfvd/W6O4t3S5GYtNpT2GGpmR05tPjVGfz/Kl
         f7vBRc+C+yu3dXEgqi2xxpfmMwRyytDgnQBfFaEHgFGRdQNKd/CTpsaNtbP1NbAlnl
         r4E7qLlUKQr033ty0Vhmo84Ldy4RKLVOaR3vYMoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 201/591] arm64: dts: qcom: sm8350: correct DMA controller unit address
Date:   Sun, 16 Jul 2023 21:45:40 +0200
Message-ID: <20230716194929.070642904@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 41d6bca799b3f40d4d3c22dd4545aeac7c210e33 ]

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/dma-controller@900000: simple-bus unit address format error, expected "9800000"

Fixes: bc08fbf49bc8 ("arm64: dts: qcom: sm8350: Define GPI DMA engines")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230419211856.79332-13-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 9430166ee45b5..7fd1c3f71c0f8 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -903,7 +903,7 @@ spi19: spi@894000 {
 			};
 		};
 
-		gpi_dma0: dma-controller@900000 {
+		gpi_dma0: dma-controller@9800000 {
 			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x09800000 0 0x60000>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.39.2



