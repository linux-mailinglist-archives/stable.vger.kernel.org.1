Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49877ECEC2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjKOTon (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjKOToi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80495189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA9C433CA;
        Wed, 15 Nov 2023 19:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077475;
        bh=nuXPUKF1RZ/qIUhC4NWXIp8Lac7TPkPNMrB9JfP0qxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8K/oIBv9tVeKHhu4Rx7PU+x6pvdx3RFTLWT3lrv0kkZ50HN6DzTParzXFMBwCvGz
         OsoG4Jzu7/wi2Um7MroBCg/yLxzksqwaXAzfGK6yAcg5xiMJA+5Vof+7so05wbfE2x
         12clozoiOdP5je+rfYeBLkyu49YkTbRrYdCzOfM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 290/603] arm64: dts: qcom: sdx75-idp: align RPMh regulator nodes with bindings
Date:   Wed, 15 Nov 2023 14:13:55 -0500
Message-ID: <20231115191633.455621754@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 815ea491460766dbd4b39a3c9904b44b5880c41c ]

Device node names should be generic and bindings expect certain pattern
for RPMh regulator nodes:

  sdx75-idp.dtb: rsc@17a00000: 'pmx75-rpmh-regulators' does not match any of the regexes: '^regulators(-[0-9])?$', 'pinctrl-[0-9]+'

Fixes: 8a2dc39d1043 ("arm64: dts: qcom: sdx75-idp: Add regulator nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230905163103.257412-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdx75-idp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
index 10d15871f2c48..a14e0650c4a8a 100644
--- a/arch/arm64/boot/dts/qcom/sdx75-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
@@ -44,7 +44,7 @@ vreg_bob_3p3: pmx75-bob {
 };
 
 &apps_rsc {
-	pmx75-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pmx75-rpmh-regulators";
 		qcom,pmic-id = "b";
 
-- 
2.42.0



