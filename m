Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936A07A7FC2
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbjITMaQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjITMaL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:30:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68FA92
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:30:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4201DC433C9;
        Wed, 20 Sep 2023 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213005;
        bh=xCoZ510v+maRK4Bh4zpsqyDAymm7FfEwN47ZFz5H1sU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUzoNVKR3kWvEWs4P9ZUxF51KCSEuwyD82QgipyojmPaWBX+wOqRfdRxfOduEBVVJ
         6YAJf3sQVTbxGxFa9AT42N9eQv0InnRvxS4OHFazUFQ/CfJpPiTEI3oKvEYrgtcIY2
         XV6kUFXvce8l10n5ZLf3tNMB6E/ARG+j+Aai49qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 098/367] ARM: dts: s3c6410: move fixed clocks under root node in Mini6410
Date:   Wed, 20 Sep 2023 13:27:55 +0200
Message-ID: <20230920112901.094318078@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 8b81a8decea77bf2ca3c718732184d4aaf949096 ]

The fixed clocks are kept under dedicated 'clocks' node but this causes
multiple dtschema warnings:

  clocks: $nodename:0: 'clocks' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
  clocks: #size-cells:0:0: 0 is not one of [1, 2]
  clocks: oscillator@0:reg:0: [0] is too short
  clocks: oscillator@1:reg:0: [1] is too short
  clocks: 'ranges' is a required property
  oscillator@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20200907183313.29234-3-krzk@kernel.org
Stable-dep-of: cf0cb2af6a18 ("ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/s3c6410-mini6410.dts | 30 ++++++++++----------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 1aeac33b0d341..75067dbcf7e83 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -28,26 +28,18 @@ chosen {
 		bootargs = "console=ttySAC0,115200n8 earlyprintk rootwait root=/dev/mmcblk0p1";
 	};
 
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		fin_pll: oscillator@0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			clock-frequency = <12000000>;
-			clock-output-names = "fin_pll";
-			#clock-cells = <0>;
-		};
+	fin_pll: oscillator-0 {
+		compatible = "fixed-clock";
+		clock-frequency = <12000000>;
+		clock-output-names = "fin_pll";
+		#clock-cells = <0>;
+	};
 
-		xusbxti: oscillator@1 {
-			compatible = "fixed-clock";
-			reg = <1>;
-			clock-output-names = "xusbxti";
-			clock-frequency = <48000000>;
-			#clock-cells = <0>;
-		};
+	xusbxti: oscillator-1 {
+		compatible = "fixed-clock";
+		clock-output-names = "xusbxti";
+		clock-frequency = <48000000>;
+		#clock-cells = <0>;
 	};
 
 	srom-cs1@18000000 {
-- 
2.40.1



