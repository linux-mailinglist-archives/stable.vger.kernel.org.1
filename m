Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F477ECC1C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjKOT1A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjKOT0q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2FCD63
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9269FC433CA;
        Wed, 15 Nov 2023 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076402;
        bh=/qzDyTHAyVjCRqyNNH3F8mKKI34rG7DxvdGyyGHtsGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4UrbVvPzNnDIhWKdeKrXfTw7ueVqdaMA3c0EPD5t2TfsmqTx7RsJROKgyK3CSig5
         hmp9hgaYV9EmsUluSGwJ/3EBhsUf+baL+oXBtGDK11RAerpAIzvgYOT9zIkLfoXLVv
         ITm2zPyg0Aq8y4YsqhBFm2oiF9gOOcKR53G4q5sM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 269/550] arm64: dts: qcom: sc7280: drop incorrect EUD port on SoC side
Date:   Wed, 15 Nov 2023 14:14:13 -0500
Message-ID: <20231115191619.369712342@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 39c8af78cbefb8c71a5ad1fa088e761ef418f0a0 ]

Qualcomm Embedded USB Debugger (EUD) second port should point to Type-C
USB connector.  Such connector was defined directly in root node of
sc7280.dtsi which is clearly wrong.  SC7280 is a chip, so physically it
does not have USB Type-C port.  The connector is usually accessible
through some USB switch or controller.

Doug Anderson said that he wasn't ever able to use EUD on Herobrine
boards, probably because of invalid or missing DTS description - DTS is
saying EUD is on usb_2 node, which is connected to a USB Hub, not to the
Type-C port.

Correct the EUD/USB connector topology by removing the top-level fake
USB connector and EUD port pointing to it, and disabling the incomplete
EUD device node.

This fixes also dtbs_check warnings:

  sc7280-herobrine-crd.dtb: connector: ports:port@0: 'reg' is a required property

Link: https://lore.kernel.org/all/CAD=FV=Xt26=rBf99mzkAuwwtb2f-jnKtnHaEhXnthz0a5zke4Q@mail.gmail.com/
Fixes: 9ee402ccfeb1 ("arm64: dts: qcom: sc7280: Fix EUD dt node syntax")
Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20230820075626.22600-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 20231d80c504b..91bb58c6b1a61 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -649,18 +649,6 @@ cpu7_opp_3014mhz: opp-3014400000 {
 		};
 	};
 
-	eud_typec: connector {
-		compatible = "usb-c-connector";
-
-		ports {
-			port@0 {
-				con_eud: endpoint {
-					remote-endpoint = <&eud_con>;
-				};
-			};
-		};
-	};
-
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -3625,6 +3613,8 @@ eud: eud@88e0000 {
 			      <0 0x88e2000 0 0x1000>;
 			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
 
+			status = "disabled";
+
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -3635,13 +3625,6 @@ eud_ep: endpoint {
 						remote-endpoint = <&usb2_role_switch>;
 					};
 				};
-
-				port@1 {
-					reg = <1>;
-					eud_con: endpoint {
-						remote-endpoint = <&con_eud>;
-					};
-				};
 			};
 		};
 
-- 
2.42.0



