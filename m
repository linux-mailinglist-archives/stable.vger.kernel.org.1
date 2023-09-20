Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252267A7DE3
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjITMNK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjITMNI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:13:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CDCAD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:13:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44305C433C8;
        Wed, 20 Sep 2023 12:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211982;
        bh=vQb+gqusYJ/tP4H4P/FEYzWTeIXkuvMgvtLUbyI/Y3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4xJOeu/ULan1OyAzX5V5kSz4jIrMmyOwgBWslWU1YmMPBY7dNCBfWXlof0z9X/Y0
         kETKUbfG5YnV65zLeQsyQEmQGdXYjwRL1H+HVEKKTUsFsjt/tyg64j4YpEuqE4zNgF
         kHcHH5E3Nh/ZD3kzvM/D1u0P0zztMyvncxvGRXIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 090/273] ARM: dts: s5pv210: add RTC 32 KHz clock in SMDKV210
Date:   Wed, 20 Sep 2023 13:28:50 +0200
Message-ID: <20230920112849.227696395@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 7260b363457a22b8723d5cbc43fee67397896d07 ]

The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
However the PMIC is not described in DTS at all so at least add
a workaround to model its clock with a fixed-clock.

This fixes dtbs_check warnings:

  rtc@e2800000: clocks: [[2, 145]] is too short
  rtc@e2800000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20200907161141.31034-15-krzk@kernel.org
Stable-dep-of: 982655cb0e7f ("ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/s5pv210-smdkv210.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index 84b38f1851991..1f20622da7194 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -31,6 +31,13 @@ memory@20000000 {
 		reg = <0x20000000 0x40000000>;
 	};
 
+	pmic_ap_clk: clock-0 {
+		/* Workaround for missing PMIC and its clock */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
 	ethernet@18000000 {
 		compatible = "davicom,dm9000";
 		reg = <0xA8000000 0x2 0xA8000002 0x2>;
@@ -147,6 +154,8 @@ &uart3 {
 
 &rtc {
 	status = "okay";
+	clocks = <&clocks CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
 };
 
 &sdhci0 {
-- 
2.40.1



