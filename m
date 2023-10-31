Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720717DD4EE
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346979AbjJaRph (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376261AbjJaRpg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:45:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55680F7
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:45:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B1FC433C8;
        Tue, 31 Oct 2023 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774334;
        bh=qm53SfkhdPQpvkabOs79Bou9umkzKEMN1/uSAPQw7MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8gKOaILDIoLRFmBUyp5/3sSEAYnMj/KYhDDHcIwRNVsye9qPPaCDGwqVXyplgSxK
         x9vyfyouGS3QLeWiKu6YfSbxGvsdKx4Y4mg8+bnHbPuSXDPvE128Y+6FvC0mzrjzYt
         93kFKlrI1tDgN/02kjNFQ8MqZ3JGsiqruGrSyx5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 015/112] arm64: dts: qcom: apq8096-db820c: fix missing clock populate
Date:   Tue, 31 Oct 2023 18:00:16 +0100
Message-ID: <20231031165901.790007990@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 2ca3e844e3f978c0dbc95072dbf379abfc4a27db upstream.

Commit 704e26678c8d ("arm64: dts: qcom: apq8096-db820c: drop simple-bus
from clocks") removed "simple-bus" compatible from "clocks" node, but
one of the clocks - divclk1 - is a gpio-gate-clock, which does not have
CLK_OF_DECLARE.  This means it will not be instantiated if placed in
some subnode.  Move the clocks to the root node, so regular devices will
be populated.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Closes: https://lore.kernel.org/all/CAA8EJprF==p87oN+RiwAiNeURF1JcHGfL2Ez5zxqYPRRbN-hhg@mail.gmail.com/
Cc: stable@vger.kernel.org
Fixes: 704e26678c8d ("arm64: dts: qcom: apq8096-db820c: drop simple-bus from clocks")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230901081812.19121-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 32 ++++++++++-----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 385b178314db..3067a4091a7a 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -62,25 +62,23 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	clocks {
-		divclk4: divclk4 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "divclk4";
+	div1_mclk: divclk1 {
+		compatible = "gpio-gate-clock";
+		pinctrl-0 = <&audio_mclk>;
+		pinctrl-names = "default";
+		clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
+		#clock-cells = <0>;
+		enable-gpios = <&pm8994_gpios 15 0>;
+	};
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk4_pin_a>;
-		};
+	divclk4: divclk4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "divclk4";
 
-		div1_mclk: divclk1 {
-			compatible = "gpio-gate-clock";
-			pinctrl-0 = <&audio_mclk>;
-			pinctrl-names = "default";
-			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
-			#clock-cells = <0>;
-			enable-gpios = <&pm8994_gpios 15 0>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk4_pin_a>;
 	};
 
 	gpio-keys {
-- 
2.42.0



