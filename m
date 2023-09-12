Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0703379BF0C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378575AbjIKWfk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbjIKOoX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:44:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294312A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:44:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F819C433C7;
        Mon, 11 Sep 2023 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443458;
        bh=/V0Q39E5xRjPmOkT3E2DG+0QraO2bbRwJHKbgi5woC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LK3/Wy1YDX/Wa8rMbr/pk53zdC6XnRfOsQ4SlNDnZpfc5dTTsaY4JETGTdg+3HAe+
         PFxkoK2D0eMiaKEoepaiphqiBjEQL7p6IbpEfE8JXG9+xBJfbF13aImqHZWA/A37N6
         8k2lpXh7JCDRDSfh+CVZWJR604KXmjFsbFJqpoV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 384/737] arm64: dts: qcom: msm8916: Disable audio codecs by default
Date:   Mon, 11 Sep 2023 15:44:03 +0200
Message-ID: <20230911134701.310359800@linuxfoundation.org>
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

[ Upstream commit a5cf21b14666c42912327c7bece38711f6e0d708 ]

Not every device has something connected to the digital audio codec
in MSM8916 and/or the analog audio codec in PM8916. Disable those by
default so the hardware is only powered up when necessary.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230510-msm8916-regulators-v1-4-54d4960a05fc@gerhold.net
Stable-dep-of: 4facccb44a82 ("arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to powerdown-gpios")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts       | 5 +++++
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 5 +++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi          | 1 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi           | 1 +
 4 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 7261cfc99f9fa..73c51fa101c8b 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -310,6 +310,10 @@ &lpass {
 	status = "okay";
 };
 
+&lpass_codec {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
@@ -399,6 +403,7 @@ &usb_hs_phy {
 };
 
 &wcd_codec {
+	status = "okay";
 	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
 	clock-names = "mclk";
 	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index baa7bb86cdd5b..8197710372ad1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -218,6 +218,10 @@ &lpass {
 	status = "okay";
 };
 
+&lpass_codec {
+	status = "okay";
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -302,6 +306,7 @@ &usb_hs_phy {
 };
 
 &wcd_codec {
+	status = "okay";
 	qcom,micbias-lvl = <2800>;
 	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
 	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index bf88c10ff55b0..9ab55e723aa6c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1552,6 +1552,7 @@ lpass_codec: audio-codec@771c000 {
 				 <&gcc GCC_CODEC_DIGCODEC_CLK>;
 			clock-names = "ahbix-clk", "mclk";
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
 		sdhc_1: mmc@7824900 {
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index f4fb1a92ab55a..33ca1002fb754 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -178,6 +178,7 @@ wcd_codec: audio-codec@f000 {
 			vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
 			vdd-micbias-supply = <&pm8916_l13>;
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 	};
 };
-- 
2.40.1



