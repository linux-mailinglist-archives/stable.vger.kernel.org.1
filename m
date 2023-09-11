Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC6779B278
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378892AbjIKWhx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbjIKOEM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:04:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFEACF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:04:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4E6C433C8;
        Mon, 11 Sep 2023 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441046;
        bh=a8HgahCiuXaolO3kqxmDi2sSryxDeY+kS01pjlPDdao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=do6dAPzDPkwSFCwzf2yUBN8r6VZu/gI15AT1a+p+E2PKNF4WbcYRjjPietVcPxlRj
         1VQ6w39EWTgCSwtSt3MABktL/7A9o/htgz6Qn+BaJhfekT8NZao4VOM+7EJ7IVXUs9
         arl6bq81/wu2qYuevhzxq6UXti6QQiXMs2ixLqjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 276/739] arm64: dts: qcom: sc8180x-pmics: align SPMI PMIC Power-on node name with dtschema
Date:   Mon, 11 Sep 2023 15:41:15 +0200
Message-ID: <20230911134658.834549035@linuxfoundation.org>
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

[ Upstream commit bf520227bd32381c587fa36271475e035daab3d7 ]

Bindings expect the Power-on node name to be "pon":

  sc8180x-lenovo-flex-5g.dtb: pmic@0: 'power-on@800' does not match any of the regexes:

Fixes: d3302290f59e ("arm64: dts: qcom: sc8180x: Add pmics")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230720083500.73554-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
index b96ae45cd2df4..ffd374b9b3158 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
@@ -74,7 +74,7 @@ pmc8180_0: pmic@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pon: power-on@800 {
+		pon: pon@800 {
 			compatible = "qcom,pm8916-pon";
 			reg = <0x0800>;
 			pwrkey {
@@ -247,7 +247,7 @@ pmic@4 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		power-on@800 {
+		pon@800 {
 			compatible = "qcom,pm8916-pon";
 			reg = <0x0800>;
 
-- 
2.40.1



