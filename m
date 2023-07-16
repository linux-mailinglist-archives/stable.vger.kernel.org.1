Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08C75559D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjGPUms (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjGPUmq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B5E45
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:42:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C39660EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC52BC433C8;
        Sun, 16 Jul 2023 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540164;
        bh=syKRtNHTB2XuwYHCRU8UPzuB7Urt1OO6bVONtc5My3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SUdSIwTF4Ye1b04ibHz0t+GfY69SgM8KvXm/RbQ3Of/qQHPBRqyi65W6AziBd5T0A
         h/WLB9Tqukg70+96YjC/FtRRddx5fXZqsOkLZdhgFL0riP802JrxIuzXcipzUAnKA6
         IAc4TSWU7BOEN7nsQzKMbQ0UqMZVBeIWzfJkyMlI=
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
Subject: [PATCH 6.1 266/591] arm64: dts: mediatek: Add cpufreq nodes for MT8192
Date:   Sun, 16 Jul 2023 21:46:45 +0200
Message-ID: <20230716194930.780358395@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index ef1294d960145..ff2310fe3f1d2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -64,6 +64,7 @@ cpu0: cpu@0 {
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <530>;
 		};
 
@@ -75,6 +76,7 @@ cpu1: cpu@100 {
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <530>;
 		};
 
@@ -86,6 +88,7 @@ cpu2: cpu@200 {
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <530>;
 		};
 
@@ -97,6 +100,7 @@ cpu3: cpu@300 {
 			clock-frequency = <1701000000>;
 			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
+			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <530>;
 		};
 
@@ -108,6 +112,7 @@ cpu4: cpu@400 {
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -119,6 +124,7 @@ cpu5: cpu@500 {
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -130,6 +136,7 @@ cpu6: cpu@600 {
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -141,6 +148,7 @@ cpu7: cpu@700 {
 			clock-frequency = <2171000000>;
 			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
+			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
 		};
 
@@ -257,6 +265,12 @@ soc {
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



