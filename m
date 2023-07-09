Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4FC74C2FE
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjGIL1C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjGIL1B (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:27:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935FE18F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1460C60BD8
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC4CC433C7;
        Sun,  9 Jul 2023 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902018;
        bh=AxFezsQpZRmEQ097RT+PqgQx4rWZvhcqNdlwLTvNwyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8i8Z9Bawz26UbXpehpUDZyjCBIbqX6hDjlHGNs02XigaFVOnKv8wbzjDr1tUKvwq
         TcMhzf3XRKU6f3i2HmAJgCSg3rxTAicKVYdRnrHU+E6J/bDJftU5xClYQJYb+2jjvc
         i/Jp5knBU6cjpBYIvwjArfbUmGp2cap+SQ+2FnEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 227/431] arm64: dts: qcom: msm8916: Move WCN compatible to boards
Date:   Sun,  9 Jul 2023 13:12:55 +0200
Message-ID: <20230709111456.482686789@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

[ Upstream commit 3244442406ff49e8f75a1f2def211c497710570f ]

On MSM8916 the wireless connectivity functionality (WiFi/Bluetooth) is
split into the digital part inside the SoC and the analog RF part inside
a supplementary WCN36xx chip. For MSM8916, three different options
exist:

  - WCN3620  (WLAN 802.11 b/g/n 2.4 GHz + Bluetooth)
  - WCN3660B (WLAN 802.11 a/b/g/n 2.4/5 GHz + Bluetooth)
  - WCN3680B (WLAN 802.11ac 2.4/5 GHz + Bluetooth)

Choosing one of these is up to the board vendor. This means that the
compatible belongs into the board-specific DT part so people porting
new boards pay attention to set the correct compatible.

Right now msm8916.dtsi sets "qcom,wcn3620" as default compatible,
which does not work at all for boards that have WCN3660B or WCN3680B.

Remove the default compatible from msm8196.dtsi and move it to the board
DT as follows:

  - Boards with only &pronto { status = "okay"; } used the default
    "qcom,wcn3620" so far. They now set this explicitly for &wcnss_iris.
  - Boards with &pronto { ... iris { compatible = "qcom,wcn3660b"; }};
    already had an override that just moves to &wcnss_iris now.
  - For msm8916-samsung-a2015-common.dtsi the WCN compatible differs for
    boards making use of it (a3u: wcn3620, a5u: wcn3660b, e2015: wcn3620)
    so the definitions move to the board-specific DT part.

Since this requires touching all the board DTs, use this as a chance to
name the WCNSS-related labels consistently, so everything is grouped
properly when sorted alphabetically.

No functional change, just clean-up for more clarity & easier porting.
Aside from ordering the generated DTBs are identical.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230309091452.1011776-1-stephan.gerhold@kernkonzept.com
Stable-dep-of: 1f9a41bb0bba ("arm64: dts: qcom: msm8916: correct WCNSS unit address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 15 ++++++++-----
 .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 12 ++++++----
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 12 ++++++----
 .../arm64/boot/dts/qcom/msm8916-asus-z00l.dts | 12 ++++++----
 .../boot/dts/qcom/msm8916-gplus-fl8005a.dts   | 12 ++++++----
 .../arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 12 ++++++----
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts | 12 ++++++----
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts | 12 ++++++----
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi  | 22 +++++++++----------
 .../qcom/msm8916-samsung-a2015-common.dtsi    |  4 ----
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts |  8 +++++++
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts | 14 +++++++-----
 .../qcom/msm8916-samsung-e2015-common.dtsi    |  8 +++++++
 .../dts/qcom/msm8916-samsung-gt5-common.dtsi  | 16 +++++++-------
 .../dts/qcom/msm8916-samsung-j5-common.dtsi   | 12 ++++++----
 .../dts/qcom/msm8916-samsung-serranove.dts    | 16 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 12 ++++++----
 .../dts/qcom/msm8916-wingtech-wt88047.dts     | 12 ++++++----
 arch/arm64/boot/dts/qcom/msm8916.dtsi         | 13 +++++------
 19 files changed, 146 insertions(+), 90 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index c52d79a55d80c..27ceaa94c8bda 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -325,12 +325,6 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
-&pronto {
-	status = "okay";
-
-	firmware-name = "qcom/apq8016/wcnss.mbn";
-};
-
 &sdhc_1 {
 	status = "okay";
 
@@ -411,10 +405,19 @@ &wcd_codec {
 	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
 };
 
+&wcnss {
+	status = "okay";
+	firmware-name = "qcom/apq8016/wcnss.mbn";
+};
+
 &wcnss_ctrl {
 	firmware-name = "qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin";
 };
 
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 /* Enable CoreSight */
 &cti0 { status = "okay"; };
 &cti1 { status = "okay"; };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index ed3fa7b3575b7..13cd9ad167df7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -118,10 +118,6 @@ &pm8916_vib {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
@@ -149,6 +145,14 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 701a5585d77e4..fecb69944cfa3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -160,10 +160,6 @@ &pm8916_vib {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	status = "okay";
 
@@ -191,6 +187,14 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index 3618704a53309..91284a1d0966f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -128,10 +128,6 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	status = "okay";
 
@@ -159,6 +155,14 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index a0e520edde029..525ec76efeeb7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -118,10 +118,6 @@ &pm8916_vib {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
@@ -149,6 +145,14 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 8c07eca900d3f..5b1bac8f51220 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -227,10 +227,6 @@ &pm8916_vib {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	status = "okay";
 
@@ -312,6 +308,14 @@ &wcd_codec {
 	qcom,hphl-jack-type-normally-open;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index d1e8cf2f50c0d..f1dd625e18227 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -231,10 +231,6 @@ &pm8916_vib {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	status = "okay";
 
@@ -263,6 +259,14 @@ &usb_hs_phy {
 	extcon = <&pm8916_usbin>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 3899e11b9843b..b79e80913af9f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -99,10 +99,6 @@ &pm8916_vib {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	status = "okay";
 
@@ -130,6 +126,14 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index 8cac23b5240c6..6eb5e0a395100 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -20,17 +20,6 @@ &mpss {
 	pll-supply = <&pm8916_l7>;
 };
 
-&pronto {
-	vddpx-supply = <&pm8916_l7>;
-
-	iris {
-		vddxo-supply = <&pm8916_l7>;
-		vddrfa-supply = <&pm8916_s3>;
-		vddpa-supply = <&pm8916_l9>;
-		vdddig-supply = <&pm8916_l5>;
-	};
-};
-
 &sdhc_1 {
 	vmmc-supply = <&pm8916_l8>;
 	vqmmc-supply = <&pm8916_l5>;
@@ -46,6 +35,17 @@ &usb_hs_phy {
 	v3p3-supply = <&pm8916_l13>;
 };
 
+&wcnss {
+	vddpx-supply = <&pm8916_l7>;
+};
+
+&wcnss_iris {
+	vddxo-supply = <&pm8916_l7>;
+	vddrfa-supply = <&pm8916_s3>;
+	vddpa-supply = <&pm8916_l9>;
+	vdddig-supply = <&pm8916_l5>;
+};
+
 &rpm_requests {
 	smd_rpm_regulators: regulators {
 		compatible = "qcom,rpm-pm8916-regulators";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index a2ed7bdbf528f..16d67749960e0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -252,10 +252,6 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index c691cca2eb459..a1ca4d8834201 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -112,6 +112,14 @@ &vibrator {
 	status = "okay";
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &msmgpio {
 	panel_vdd3_default: panel-vdd3-default-state {
 		pins = "gpio9";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
index 3dd819458785d..4e10b8a5e9f9c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
@@ -54,12 +54,6 @@ &clk_pwm {
 	status = "okay";
 };
 
-&pronto {
-	iris {
-		compatible = "qcom,wcn3660b";
-	};
-};
-
 &touchkey {
 	vcc-supply = <&reg_touch_key>;
 	vdd-supply = <&reg_touch_key>;
@@ -69,6 +63,14 @@ &vibrator {
 	status = "okay";
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3660b";
+};
+
 &msmgpio {
 	tkey_en_default: tkey-en-default-state {
 		pins = "gpio97";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index c95f0b4bc61f3..f6c4a011fdfd2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -58,6 +58,14 @@ &touchkey {
 	vdd-supply = <&reg_touch_key>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &msmgpio {
 	tkey_en_default: tkey-en-default-state {
 		pins = "gpio97";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index d920b7247d823..74ffd04db8d84 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -125,14 +125,6 @@ &pm8916_usbin {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-
-	iris {
-		compatible = "qcom,wcn3660b";
-	};
-};
-
 &sdhc_1 {
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
@@ -162,6 +154,14 @@ &usb_hs_phy {
 	extcon = <&pm8916_usbin>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3660b";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index f3b81b6f0a2f1..adeee0830e768 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -93,10 +93,6 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	status = "okay";
 
@@ -124,6 +120,14 @@ &usb_hs_phy {
 	extcon = <&muic>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index d4984b3af8023..1a41a4db874da 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -272,14 +272,6 @@ &pm8916_vib {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-
-	iris {
-		compatible = "qcom,wcn3660b";
-	};
-};
-
 &sdhc_1 {
 	status = "okay";
 
@@ -320,6 +312,14 @@ &usb_hs_phy {
 	extcon = <&muic>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3660b";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index cdf34b74fa8fa..50bae6f214f1f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -99,10 +99,6 @@ &pm8916_usbin {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
@@ -122,6 +118,14 @@ &usb_hs_phy {
 	extcon = <&pm8916_usbin>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index a87be1d95b14b..ac56c7595f78a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -153,10 +153,6 @@ &pm8916_vib {
 	status = "okay";
 };
 
-&pronto {
-	status = "okay";
-};
-
 &sdhc_1 {
 	status = "okay";
 
@@ -184,6 +180,14 @@ &usb_hs_phy {
 	extcon = <&usb_id>;
 };
 
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
 &smd_rpm_regulators {
 	vdd_l1_l2_l3-supply = <&pm8916_s3>;
 	vdd_l4_l5_l6-supply = <&pm8916_s4>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9bbe97902f0fe..80f210e55657c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1870,7 +1870,7 @@ usb_hs_phy: phy {
 			};
 		};
 
-		pronto: remoteproc@a21b000 {
+		wcnss: remoteproc@a21b000 {
 			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
 			reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
 			reg-names = "ccu", "dxe", "pmu";
@@ -1896,9 +1896,8 @@ pronto: remoteproc@a21b000 {
 
 			status = "disabled";
 
-			iris {
-				compatible = "qcom,wcn3620";
-
+			wcnss_iris: iris {
+				/* Separate chip, compatible is board-specific */
 				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
 				clock-names = "xo";
 			};
@@ -1916,13 +1915,13 @@ wcnss_ctrl: wcnss {
 					compatible = "qcom,wcnss";
 					qcom,smd-channels = "WCNSS_CTRL";
 
-					qcom,mmio = <&pronto>;
+					qcom,mmio = <&wcnss>;
 
-					bluetooth {
+					wcnss_bt: bluetooth {
 						compatible = "qcom,wcnss-bt";
 					};
 
-					wifi {
+					wcnss_wifi: wifi {
 						compatible = "qcom,wcnss-wlan";
 
 						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.39.2



