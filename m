Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AAA755290
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjGPUJX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGPUJX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:09:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1649A9D
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C15360EBB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A7FC433C8;
        Sun, 16 Jul 2023 20:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538160;
        bh=Xpx9YY6YGd+aohkVd8fMuCNdNsMg5l+Hiqtde0WDD+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkLee35k7qaC8uuiT1BGMvZE5OaMVCgvM4VyoxcB8AvkqS2mWZKrrqSoh8BlPVRP6
         TJgPGq8JZfBlSkH1z6fQPVqofcunVqbhQqUmFvzLWpsxFveBzl1m7rrrksznik0rGQ
         ELwztP9br4FekXJdUbEzEOh2/2Xj3VRfvA086wGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 318/800] arm64: dts: qcom: apq8016-sbc: Fix regulator constraints
Date:   Sun, 16 Jul 2023 21:42:51 +0200
Message-ID: <20230716194956.458741473@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit e27654df20d77ad7549a3cf6739ebaa3aa59a088 ]

For some reason DB410c has completely bogus regulator constraints that
actually just correspond to the programmable voltages which are already
provided by the regulator driver. Some of them are not just outside the
recommended operating conditions of the APQ8016E SoC but even exceed
the absolute maximum ratings, potentially risking permanent device
damage.

In practice it's not quite as dangerous thanks to the RPM firmware:
It turns out that it has its own voltage constraints and silently
clamps all regulator requests. For example, requesting 3.3V for L5
(allowed by the current regulator constraints!) still results in 1.8V
being programmed in the actual regulator hardware.

Experimentation with various voltages shows that the internal RPM
voltage constraints roughly correspond to the safe "specified range"
in the PM8916 Device Specification (rather than the "programmable
range" used inside apq8016-sbc.dtsi right now).

Combine those together with some fixed voltages used in the old
msm-3.10 device tree from Qualcomm to give DB410c some actually valid
voltage constraints.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: 4c7d53d16d77 ("arm64: dts: apq8016-sbc: add regulators support")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230510-msm8916-regulators-v1-1-54d4960a05fc@gerhold.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 64 ++++++++++++------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 59860a2223b83..14cb217a13c1e 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -447,21 +447,21 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <375000>;
-		regulator-max-microvolt = <1562000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 
 		regulator-always-on;
 		regulator-boot-on;
 	};
 
 	l1 {
-		regulator-min-microvolt = <375000>;
-		regulator-max-microvolt = <1525000>;
+		regulator-min-microvolt = <1225000>;
+		regulator-max-microvolt = <1225000>;
 	};
 
 	l2 {
@@ -470,13 +470,13 @@ l2 {
 	};
 
 	l4 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2050000>;
+		regulator-max-microvolt = <2050000>;
 	};
 
 	l5 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
 	};
 
 	l6 {
@@ -485,45 +485,45 @@ l6 {
 	};
 
 	l7 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
 	};
 
 	l8 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
 	};
 
 	l9 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 	};
 
 	l10 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
 	};
 
 	l12 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
 	};
 
 	l13 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <3075000>;
+		regulator-max-microvolt = <3075000>;
 	};
 
 	l14 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
 	};
 
 	/**
@@ -531,14 +531,14 @@ l14 {
 	 * for mezzanine boards
 	 */
 	l15 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
 	};
 
 	l16 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
 	};
 
 	l17 {
@@ -547,8 +547,8 @@ l17 {
 	};
 
 	l18 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
 	};
 };
 
-- 
2.39.2



