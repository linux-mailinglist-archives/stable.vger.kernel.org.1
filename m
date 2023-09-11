Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2079BE91
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjIKWse (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbjIKPNr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:13:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE549FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:13:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B03C433C8;
        Mon, 11 Sep 2023 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445223;
        bh=N0k5jieWtYA+nD1520UGJ+5xprSzNsB1mNk/Ufjqq5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7NwtHthKpkkQehK7U+KP29C4h6wns1WowBaRNTrywFlfyAkBxdPyCU2wFlUnvajY
         SLt0YQ+4+ldM8JIQFcu+zvxI139WA/6GPPW5UVvrQVn2IabZiozF3ec1ZHEwNvMbyR
         DykpO2zJk4E/7oZEq9XeoX5aXJEGwbOmMYby3Htg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 271/600] arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
Date:   Mon, 11 Sep 2023 15:45:04 +0200
Message-ID: <20230911134641.608668721@linuxfoundation.org>
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 4b6ea15c0a1122422b44bf6c47a3c22fc8d46777 ]

GCC and it's GDSCs are under the RPMh CX power domain. So let's add the
missing RPMh power domain to the GCC node.

Fixes: 6d4cf750d03a ("arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20230720054100.9940-4-manivannan.sadhasivam@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b7ba70857d0ad..375c86633b5b9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1099,6 +1099,7 @@ gcc: clock-controller@100000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			power-domains = <&rpmhpd SDM845_CX>;
 		};
 
 		qfprom@784000 {
-- 
2.40.1



