Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A7F7552C5
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjGPULq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjGPULq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:11:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F8EC0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACA4460DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED2AC433C8;
        Sun, 16 Jul 2023 20:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538302;
        bh=LDtFgJqvC8X84uaOKc9i87iZlvpzvZduVms7uM4w8UE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ga0Bp9UpBr38P8+EJZjkQJlXlAzqo2hJlFLpJtmtkPOGrcSeBLV7oxymFRMoN07F1
         AjAfWg6dT5jycR2ov8rY1DKeLEVM5TUKsfQdwHWMottxAuMIvyoylPQowkdrWR2v9m
         NcaV8OaNAYxDjOcsS9c3N2AdYhYKm32BU1eY+tD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "=?UTF-8?q?N=C3=ADcolas=20F . =20R . =20A . =20Prado?=" 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 403/800] arm64: dts: mediatek: Add cpufreq nodes for MT8192
Date:   Sun, 16 Jul 2023 21:44:16 +0200
Message-ID: <20230716194958.433002551@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

[ Upstream commit 9d498cce9298a71e3896e2d1aee24a1a4c531d81 ]

Add the cpufreq nodes for MT8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230317061944.15434-1-allen-kh.cheng@mediatek.com
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Stable-dep-of: a4366b5695c9 ("arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 5c30caf740265..6593cd0ef2972 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -70,6 +70,7 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <530>;
 		};
 
@@ -87,6 +88,7 @@ cpu1: cpu@100 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <530>;
 		};
 
@@ -104,6 +106,7 @@ cpu2: cpu@200 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <530>;
 		};
 
@@ -121,6 +124,7 @@ cpu3: cpu@300 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <530>;
 		};
 
@@ -138,6 +142,7 @@ cpu4: cpu@400 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -155,6 +160,7 @@ cpu5: cpu@500 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -172,6 +178,7 @@ cpu6: cpu@600 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -189,6 +196,7 @@ cpu7: cpu@700 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -403,6 +411,12 @@ soc {
 		compatible = "simple-bus";
 		ranges;
 
+		performance: performance-controller@11bc10 {
+			compatible = "mediatek,cpufreq-hw";
+			reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
+			#performance-domain-cells = <1>;
+		};
+
 		gic: interrupt-controller@c000000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <4>;
-- 
2.39.2



