Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68A679B912
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377563AbjIKW1L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238635AbjIKOBS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:01:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6959CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:01:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7464C433C7;
        Mon, 11 Sep 2023 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440873;
        bh=ghQw8FrcA4Bv1qQuro2XOdUDcEHCmXcLE00yvIkb3VI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOPocNBAE1bJvcc7EM6TduDYuwYoY3Gsb+t/2fyshq7aUt4jfPtB1F/0TLCdK19LI
         E4rSLzO/huZULtQ1AddBI9q2P9hIhazZXHocly+KFCXQ+Dg0ojwqNswjGqo+u8Wfhl
         n16U89I/O4hhiX8kgoa57O0sOrQLCFysERQjWIFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 215/739] Revert "arm64: dts: qcom: msm8996: rename labels for HDMI nodes"
Date:   Mon, 11 Sep 2023 15:40:14 +0200
Message-ID: <20230911134657.195244757@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 2b812caf5f64df959555e48dfc7bf8f061d9fe8f ]

The commit f43b6dc7d56e ("arm64: dts: qcom: msm8996: rename labels for
HDMI nodes") is broken, it changes all the HDMI node names,
compatible strings instead of changing just node aliases. Revert the
commit in order to land a proper clean version.

Reported-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Fixes: f43b6dc7d56e ("arm64: dts: qcom: msm8996: rename labels for HDMI nodes")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230615083422.350297-2-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts  | 50 ++++++++++----------
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts |  6 +--
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts     |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 16 +++----
 4 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 537547b97459b..b599909c44639 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -208,6 +208,25 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&hdmi_hpd_active &hdmi_ddc_active>;
+	pinctrl-1 = <&hdmi_hpd_suspend &hdmi_ddc_suspend>;
+
+	core-vdda-supply = <&vreg_l12a_1p8>;
+	core-vcc-supply = <&vreg_s4a_1p8>;
+};
+
+&hdmi_phy {
+	status = "okay";
+
+	vddio-supply = <&vreg_l12a_1p8>;
+	vcca-supply = <&vreg_l28a_0p925>;
+	#phy-cells = <0>;
+};
+
 &hsusb_phy1 {
 	status = "okay";
 
@@ -232,25 +251,6 @@ &mdss {
 	status = "okay";
 };
 
-&mdss_hdmi {
-	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&mdss_hdmi_hpd_active &mdss_hdmi_ddc_active>;
-	pinctrl-1 = <&mdss_hdmi_hpd_suspend &mdss_hdmi_ddc_suspend>;
-
-	core-vdda-supply = <&vreg_l12a_1p8>;
-	core-vcc-supply = <&vreg_s4a_1p8>;
-};
-
-&mdss_hdmi_phy {
-	status = "okay";
-
-	vddio-supply = <&vreg_l12a_1p8>;
-	vcca-supply = <&vreg_l28a_0p925>;
-	#phy-cells = <0>;
-};
-
 &mmcc {
 	vdd-gfx-supply = <&vdd_gfx>;
 };
@@ -433,28 +433,28 @@ sdc2_cd_off: sdc2-cd-off-state {
 		drive-strength = <2>;
 	};
 
-	mdss_hdmi_hpd_active: mdss_hdmi-hpd-active-state {
+	hdmi_hpd_active: hdmi-hpd-active-state {
 		pins = "gpio34";
 		function = "hdmi_hot";
 		bias-pull-down;
 		drive-strength = <16>;
 	};
 
-	mdss_hdmi_hpd_suspend: mdss_hdmi-hpd-suspend-state {
+	hdmi_hpd_suspend: hdmi-hpd-suspend-state {
 		pins = "gpio34";
 		function = "hdmi_hot";
 		bias-pull-down;
 		drive-strength = <2>;
 	};
 
-	mdss_hdmi_ddc_active: mdss_hdmi-ddc-active-state {
+	hdmi_ddc_active: hdmi-ddc-active-state {
 		pins = "gpio32", "gpio33";
 		function = "hdmi_ddc";
 		drive-strength = <2>;
 		bias-pull-up;
 	};
 
-	mdss_hdmi_ddc_suspend: mdss_hdmi-ddc-suspend-state {
+	hdmi_ddc_suspend: hdmi-ddc-suspend-state {
 		pins = "gpio32", "gpio33";
 		function = "hdmi_ddc";
 		drive-strength = <2>;
@@ -1043,7 +1043,7 @@ cpu {
 		};
 	};
 
-	mdss_hdmi-dai-link {
+	hdmi-dai-link {
 		link-name = "HDMI";
 		cpu {
 			sound-dai = <&q6afedai HDMI_RX>;
@@ -1054,7 +1054,7 @@ platform {
 		};
 
 		codec {
-			sound-dai = <&mdss_hdmi 0>;
+			sound-dai = <&hdmi 0>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
index ac6471d1db1f7..ed2e2f6c6775a 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
@@ -92,15 +92,15 @@ &gpu {
 	status = "okay";
 };
 
-&mdss {
+&hdmi {
 	status = "okay";
 };
 
-&mdss_hdmi {
+&hdmi_phy {
 	status = "okay";
 };
 
-&mdss_hdmi_phy {
+&mdss {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
index 495d45a16e63a..596ad4c896f55 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-mtp.dts
@@ -24,10 +24,10 @@ &blsp2_uart2 {
 	status = "okay";
 };
 
-&mdss_hdmi {
+&hdmi {
 	status = "okay";
 };
 
-&mdss_hdmi_phy {
+&hdmi_phy {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0cb2d4f08c3a1..3855366ca89fd 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -895,7 +895,7 @@ mmcc: clock-controller@8c0000 {
 				 <&mdss_dsi0_phy 0>,
 				 <&mdss_dsi1_phy 1>,
 				 <&mdss_dsi1_phy 0>,
-				 <&mdss_hdmi_phy>;
+				 <&hdmi_phy>;
 			clock-names = "xo",
 				      "gpll0",
 				      "gcc_mmss_noc_cfg_ahb_clk",
@@ -980,7 +980,7 @@ ports {
 					port@0 {
 						reg = <0>;
 						mdp5_intf3_out: endpoint {
-							remote-endpoint = <&mdss_hdmi_in>;
+							remote-endpoint = <&hdmi_in>;
 						};
 					};
 
@@ -1136,8 +1136,8 @@ mdss_dsi1_phy: phy@996400 {
 				status = "disabled";
 			};
 
-			mdss_hdmi: mdss_hdmi-tx@9a0000 {
-				compatible = "qcom,mdss_hdmi-tx-8996";
+			hdmi: hdmi-tx@9a0000 {
+				compatible = "qcom,hdmi-tx-8996";
 				reg =	<0x009a0000 0x50c>,
 					<0x00070000 0x6158>,
 					<0x009e0000 0xfff>;
@@ -1160,7 +1160,7 @@ mdss_hdmi: mdss_hdmi-tx@9a0000 {
 					"alt_iface",
 					"extp";
 
-				phys = <&mdss_hdmi_phy>;
+				phys = <&hdmi_phy>;
 				#sound-dai-cells = <1>;
 
 				status = "disabled";
@@ -1171,16 +1171,16 @@ ports {
 
 					port@0 {
 						reg = <0>;
-						mdss_hdmi_in: endpoint {
+						hdmi_in: endpoint {
 							remote-endpoint = <&mdp5_intf3_out>;
 						};
 					};
 				};
 			};
 
-			mdss_hdmi_phy: phy@9a0600 {
+			hdmi_phy: phy@9a0600 {
 				#phy-cells = <0>;
-				compatible = "qcom,mdss_hdmi-phy-8996";
+				compatible = "qcom,hdmi-phy-8996";
 				reg = <0x009a0600 0x1c4>,
 				      <0x009a0a00 0x124>,
 				      <0x009a0c00 0x124>,
-- 
2.40.1



