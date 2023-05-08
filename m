Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8E6FAD94
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjEHLfi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbjEHLfR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897B73D206
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6927163235
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C82DC4339C;
        Mon,  8 May 2023 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545701;
        bh=XGxwgyjxWgEVbkeQNY7XMMOlNLJD0IT+dAbUSS7HL64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfrUK3oD9Eo0Vc1zi4TrQSppCK2K52hUfz+ZKkLJB0ymiw7HqnW8dFrO6FgffyQt0
         RCuR4MgOXHE+XzTNZ5ci1x8vyIOAQ52oIyKrtclKrSb5+TSuNWbjTipN0KMCwUpe+a
         o+nzUKGAJO39QwXxdzIeSUJ7oWj+c9BAX6aTfrs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 124/371] arm64: dts: qcom: msm8994-kitakami: drop unit address from PMI8994 regulator
Date:   Mon,  8 May 2023 11:45:25 +0200
Message-Id: <20230508094816.946727645@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

[ Upstream commit 3555dd528ba9c08d6ccd56239c695dbeac3b63e3 ]

The PMIC regulators are not supposed to have unit addresses.

Fixes: e9783584c9b7 ("arm64: dts: qcom: msm8994-kitakami: Add VDD_GFX regulator")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230312183622.460488-6-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
index 48de66bf19c4c..55198190bbeaa 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-sony-xperia-kitakami.dtsi
@@ -183,8 +183,7 @@
 	 * power domain.. which still isn't enough and forces us to bind
 	 * OXILI_CX and OXILI_GX together!
 	 */
-	vdd_gfx: s2@1700 {
-		reg = <0x1700 0x100>;
+	vdd_gfx: s2 {
 		regulator-name = "VDD_GFX";
 		regulator-min-microvolt = <980000>;
 		regulator-max-microvolt = <980000>;
-- 
2.39.2



