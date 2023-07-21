Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4085875D25A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGUS6o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjGUS6n (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6A230D7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3FDE61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F245EC433C8;
        Fri, 21 Jul 2023 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965921;
        bh=86dVskVF+/bSNt6LlVE6M1up3Ni+JO+m3+MbUsGPmd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jllY6YOLikxQ9cQ9obtdqRwqBvD3Vk4e6crJBO/h3lWUSpI6GQ13TJkrnRi0q+Zv4
         miN0p8ez0dfXWYRGRFvgbzEXQsNAqRhvllgATMPxG8Dw7zyS+z3MjztdflFG+z9EN/
         Yl2iYQzcxcucdo1LFGGNysDgkLRm70yegB2B/Vdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 133/532] arm64: dts: qcom: apq8016-sbc: Update modem and WiFi firmware path
Date:   Fri, 21 Jul 2023 18:00:37 +0200
Message-ID: <20230721160621.680378860@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 0f6b380d580cd081d5e385d349f55dfc52e3d68c ]

The firmware for the modem and WiFi subsystems platform specific and is
signed with a OEM specific key (or a test key). In order to support more
than a single device it is therefor not possible to rely on the default
path and stash these files directly in the firmware directory.

This has already been addressed for other platforms, but the APQ8016 SBC
(aka db410c) was never finished upstream.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Tested-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20210531224453.783218-1-bjorn.andersson@linaro.org
Stable-dep-of: e27654df20d7 ("arm64: dts: qcom: apq8016-sbc: Fix regulator constraints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi     |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index f8d8f3e3664ec..351c68d29afb7 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -305,6 +305,12 @@ &mdss {
 	status = "okay";
 };
 
+&mpss {
+	status = "okay";
+
+	firmware-name = "qcom/msm8916/mba.mbn", "qcom/msm8916/modem.mbn";
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -312,6 +318,8 @@ &pm8916_resin {
 
 &pronto {
 	status = "okay";
+
+	firmware-name = "qcom/msm8916/wcnss.mbn";
 };
 
 &sdhc_1 {
@@ -394,6 +402,10 @@ &wcd_codec {
 	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
 };
 
+&wcnss_ctrl {
+	firmware-name = "qcom/msm8916/WCNSS_qcom_wlan_nv.bin";
+};
+
 /* Enable CoreSight */
 &cti0 { status = "okay"; };
 &cti1 { status = "okay"; };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index aa79e08075ea7..fcc9f757c9e14 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1771,7 +1771,7 @@ smd-edge {
 
 				label = "pronto";
 
-				wcnss {
+				wcnss_ctrl: wcnss {
 					compatible = "qcom,wcnss";
 					qcom,smd-channels = "WCNSS_CTRL";
 
-- 
2.39.2



