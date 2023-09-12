Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC2579B471
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359681AbjIKWSX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbjIKOoV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:44:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB1512A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:44:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEA3C433C8;
        Mon, 11 Sep 2023 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443455;
        bh=wb2tXysTlnamY2oXWRtntFlasykJgW690VFAxiNDUQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJKvqr28xenFcG44UFwPfuciXg0y+kNiXmxtKfGz8/k6GmOeZFf+rNJQl21Pdwchu
         jQtTvUd50RjPpT/42sQuHWlxgE/KfGhfba8FX2P/LfAJjgSPOAhcBbTxXaBgl6V3zN
         32zNMxWkWYhNSWt3ChHFkPq00x39TCX/eAosLq5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 383/737] arm64: dts: qcom: msm8916: Fix regulator constraints
Date:   Mon, 11 Sep 2023 15:44:02 +0200
Message-ID: <20230911134701.277223323@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 355750828c5519c88de6ac0d09202d2a7e5892c5 ]

The regulator constraints for most MSM8916 devices (except DB410c) were
originally taken from Qualcomm's msm-3.10 vendor device tree (for lack
of better documentation). Unfortunately it turns out that Qualcomm's
voltages are slightly off as well and do not match the voltage
constraints applied by the RPM firmware.

This means that we sometimes request a specific voltage but the RPM
firmware actually applies a much lower or higher voltage. This is
particularly critical for pm8916_l11 which is used as SD card VMMC
regulator: The SD card can choose a voltage from the current range of
1.8 - 2.95V. If it chooses to run at 1.8V we pretend that this is fine
but the RPM firmware will still silently end up configuring 2.95V.
This can be easily reproduced with a multimeter or by checking the
SPMI hardware registers of the regulator.

Fix this by making the voltages match the actual "specified range" in
the PM8916 Device Specification which is enforced by the RPM firmware.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230510-msm8916-regulators-v1-3-54d4960a05fc@gerhold.net
Stable-dep-of: 4facccb44a82 ("arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to powerdown-gpios")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts   | 14 +++++++-------
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     | 12 ++++++------
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 14 +++++++-------
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      | 14 +++++++-------
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     | 14 +++++++-------
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 14 +++++++-------
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 14 +++++++-------
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          | 14 +++++++-------
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     | 12 ++++++------
 13 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index 13cd9ad167df7..0d517804e44ed 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -159,13 +159,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -199,7 +199,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -209,12 +209,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index fecb69944cfa3..ddd64cc469983 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -201,13 +201,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -241,7 +241,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -251,12 +251,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index 91284a1d0966f..982457503a3cc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -169,13 +169,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -209,7 +209,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -219,12 +219,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index 525ec76efeeb7..9584d271c5260 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -159,13 +159,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -199,7 +199,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -209,12 +209,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 5b1bac8f51220..baa7bb86cdd5b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -322,13 +322,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -372,12 +372,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 1bcff702e7e57..66e7ba00633f7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -273,13 +273,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -313,7 +313,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -323,12 +323,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 6046e2c1f1586..1e0c08770371a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -155,13 +155,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -195,7 +195,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -205,12 +205,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 16d67749960e0..b362a76eebc94 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -285,13 +285,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -325,7 +325,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -335,12 +335,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 74ffd04db8d84..4464beeeaab12 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -168,13 +168,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -208,7 +208,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -218,12 +218,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index adeee0830e768..6e231e92e6756 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -134,13 +134,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -174,7 +174,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -184,12 +184,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 1a41a4db874da..fa5b330aaeaee 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -326,13 +326,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -366,7 +366,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -376,12 +376,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index 50bae6f214f1f..b27896e83a0e2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -132,13 +132,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -172,7 +172,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -182,12 +182,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index ac56c7595f78a..78020a0db4e48 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -194,13 +194,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -234,7 +234,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -244,7 +244,7 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
-- 
2.40.1



