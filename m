Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4E5755573
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGPUlL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjGPUlG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA22E50
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAAC860EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72C0C433C8;
        Sun, 16 Jul 2023 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540054;
        bh=andwomOxNVYznthqKl6+TKJI7xc4ylJNYc5tXGc+P00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yipVIvW0WvwZkkEIo3ipxtbH/plkLuLDkBdRuM0gKNym3Ozna8bs78PVD3hufzlpm
         wchLNx3T5vOC/zNrJW/b1+IyAaDFliqML1PSjFGvtCW69A6HQjFUouaCGZ9MaIg/z/
         ZX8ShHi6WBsSUexuRbsZ4VPAZDtsGHWqoi23o56g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 199/591] arm64: dts: qcom: sdm845: correct camss unit address
Date:   Sun, 16 Jul 2023 21:45:38 +0200
Message-ID: <20230716194929.021987793@linuxfoundation.org>
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

[ Upstream commit a05b913a27e46926ba60ba2bcacc7ec7a8403e4c ]

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/camss@a00000: simple-bus unit address format error, expected "acb3000"

Fixes: d48a6698a6b7 ("arm64: dts: qcom: sdm845: Add CAMSS ISP node")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230419211856.79332-11-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index a99eda4971010..6f4cc3329400c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4207,7 +4207,7 @@ videocc: clock-controller@ab00000 {
 			#reset-cells = <1>;
 		};
 
-		camss: camss@a00000 {
+		camss: camss@acb3000 {
 			compatible = "qcom,sdm845-camss";
 
 			reg = <0 0xacb3000 0 0x1000>,
-- 
2.39.2



