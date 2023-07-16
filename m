Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9844275525F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjGPUHO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGPUHN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A570CE6C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3867660EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FA6C433C8;
        Sun, 16 Jul 2023 20:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538019;
        bh=A/hG8Y9ZYQgSzq7zk7mnoPGANzo8p71vMYB9pOKFke8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKNHvV/tH8uXgE8iPWYUQJQxUcjK6qL4P0y9loVk5lYBHQ6icEPgXxC1QsrG9PbRo
         8w5ESnHRG9CmIE3msE79J56DKxJpQGQ2yRsHXTbxsJsnpAHUVkgaflFPIH8ePmMXGw
         ZtDgFdt1IaGCNdyDWBTfiHwCydhWciWYdD72tkws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 302/800] arm64: dts: qcom: msm8916: correct MMC unit address
Date:   Sun, 16 Jul 2023 21:42:35 +0200
Message-ID: <20230716194956.092874440@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

[ Upstream commit 72644bc76d5145c098c268829554a0b98fab1de1 ]

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/mmc@7824000: simple-bus unit address format error, expected "7824900"
  Warning (simple_bus_reg): /soc@0/mmc@7864000: simple-bus unit address format error, expected "7864900"

Fixes: c4da5a561627 ("arm64: dts: qcom: Add msm8916 sdhci configuration nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230419211856.79332-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 894a994311580..f6ccce0dad4e2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1554,7 +1554,7 @@ lpass_codec: audio-codec@771c000 {
 			#sound-dai-cells = <1>;
 		};
 
-		sdhc_1: mmc@7824000 {
+		sdhc_1: mmc@7824900 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
 			reg-names = "hc", "core";
@@ -1572,7 +1572,7 @@ sdhc_1: mmc@7824000 {
 			status = "disabled";
 		};
 
-		sdhc_2: mmc@7864000 {
+		sdhc_2: mmc@7864900 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
 			reg-names = "hc", "core";
-- 
2.39.2



