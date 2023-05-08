Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAB6FAAAF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjEHLFg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbjEHLFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC2231ECD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3365562A73
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C85C433D2;
        Mon,  8 May 2023 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543824;
        bh=uPxDP1oq4bTVRb5SQUdmO8EJYC+vQ0U4QGZIbUNMNYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJbx3dwy7uuc1v0EzSGybbHTxr8SgJQXOGcjCK1mgVth6zPzQz1zetKwnIWTbzVdX
         TmIb+qfh14CiTo/01HL1QNfsWdWfZRg/6ToGLMVgdtB06XK+t0UABwdClhMl/Lyiek
         uhw/UVLjk4015XYX+56rKJWeVu1aJY4qq1DSwbjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 182/694] arm64: dts: qcom: sc7280: fix EUD port properties
Date:   Mon,  8 May 2023 11:40:17 +0200
Message-Id: <20230508094438.341207736@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

[ Upstream commit a369c74243ca4ad60b9de0ac5c2207fb4c4117b8 ]

Nodes with unit addresses must have also 'reg' property:

  sc7280-herobrine-crd.dtb: eud@88e0000: ports:port@0: 'reg' is a required property

Fixes: 0b059979090d ("arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230308125906.236885-10-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8f4ab6bd28864..c04bb158f4311 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3595,12 +3595,17 @@
 			      <0 0x088e2000 0 0x1000>;
 			interrupts-extended = <&pdc 11 IRQ_TYPE_LEVEL_HIGH>;
 			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
 				port@0 {
+					reg = <0>;
 					eud_ep: endpoint {
 						remote-endpoint = <&usb2_role_switch>;
 					};
 				};
 				port@1 {
+					reg = <1>;
 					eud_con: endpoint {
 						remote-endpoint = <&con_eud>;
 					};
@@ -3611,7 +3616,11 @@
 		eud_typec: connector {
 			compatible = "usb-c-connector";
 			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
 				port@0 {
+					reg = <0>;
 					con_eud: endpoint {
 						remote-endpoint = <&eud_con>;
 					};
-- 
2.39.2



