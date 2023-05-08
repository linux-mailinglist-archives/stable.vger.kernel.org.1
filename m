Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208AB6FA752
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjEHK33 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjEHK3R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E423A25251
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DB4062695
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFF8C4339B;
        Mon,  8 May 2023 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541754;
        bh=IbA2kI44DiybcmENrfW6ndxjyPxEF2oKV1ME6S9IHSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SK1bZhG4zUgDHt2xsCFNfF+6jB88szgP/oj2IWlpeRPQ6Vao4SGdRz+2TOZeXaWwJ
         WVvAlM4uHE79U66p8oZh3QoCfSlGPuwKFdyqKx4sF3j5zYISNZ0O5V9HHt9xB8yF32
         p8gFeZjoGLhNg+ompE1d2V7aapsJdKMRbwkioc/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 217/663] arm64: dts: qcom: sc7180-trogdor-pazquel: correct trackpad supply
Date:   Mon,  8 May 2023 11:40:43 +0200
Message-Id: <20230508094435.387089485@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 24f39eec6a70768e7c2eb2f3d8158f45050ff75a ]

The hid-over-i2c takes VDD, not VCC supply.  Fix copy-pasta from other
boards which use elan,ekth3000 with valid VCC:

  sc7180-trogdor-pazquel360-lte.dtb: trackpad@15: 'vcc-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: fb69f6adaf88 ("arm64: dts: qcom: sc7180: Add pazquel dts files")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230312183622.460488-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
index d06cc4ea33756..8823edbb4d6e2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
@@ -39,7 +39,7 @@
 		interrupt-parent = <&tlmm>;
 		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
 
-		vcc-supply = <&pp3300_fp_tp>;
+		vdd-supply = <&pp3300_fp_tp>;
 		post-power-on-delay-ms = <100>;
 		hid-descr-addr = <0x0001>;
 
-- 
2.39.2



