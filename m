Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEF78AC4C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjH1Kiz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjH1Kig (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:38:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7D3A7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61E5663F42
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F0AC433C7;
        Mon, 28 Aug 2023 10:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219112;
        bh=XHnMaUVgelrFt4T9CFBlweFFi+iq++35zg9FsGsn1/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7muPq3/NGy/uftimUk4yKn2u9l1jJ7QvZ2ufh7yWPU6E0w101/OJ7S0IQLVc4rbC
         dkKblSo/xGEuhWWYXuKJYZkF7q/uNwypVweUDDb/GyIIrLpj/u4lIqLsN7BN5vo9KL
         TggknUSCvrLci7HdHxrFsGgJWZoC35pLsenTXw5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Wahren <stefan.wahren@i2se.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 078/158] ARM: dts: imx: Adjust dma-apbh node name
Date:   Mon, 28 Aug 2023 12:12:55 +0200
Message-ID: <20230828101159.906737799@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit e9f5cd85f1f931bb7b64031492f7051187ccaac7 ]

Currently the dtbs_check generates warnings like this:

$nodename:0: 'dma-apbh@110000' does not match '^dma-controller(@.*)?$'

So fix all affected dma-apbh node names.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: be18293e47cb ("ARM: dts: imx: Set default tuning step for imx7d usdhc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx23.dtsi   | 2 +-
 arch/arm/boot/dts/imx28.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
 arch/arm/boot/dts/imx7s.dtsi   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 8257630f7a491..42700d7f8bf74 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -59,7 +59,7 @@
 				reg = <0x80000000 0x2000>;
 			};
 
-			dma_apbh: dma-apbh@80004000 {
+			dma_apbh: dma-controller@80004000 {
 				compatible = "fsl,imx23-dma-apbh";
 				reg = <0x80004000 0x2000>;
 				interrupts = <0 14 20 0
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e14d8ef0158b8..235c69bd181fe 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -78,7 +78,7 @@
 				status = "disabled";
 			};
 
-			dma_apbh: dma-apbh@80004000 {
+			dma_apbh: dma-controller@80004000 {
 				compatible = "fsl,imx28-dma-apbh";
 				reg = <0x80004000 0x2000>;
 				interrupts = <82 83 84 85
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index bb02923bc2e5b..861392ff70861 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -160,7 +160,7 @@
 		interrupt-parent = <&gpc>;
 		ranges;
 
-		dma_apbh: dma-apbh@110000 {
+		dma_apbh: dma-controller@110000 {
 			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x00110000 0x2000>;
 			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 790cc88c8b1ae..f50fd581e1276 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -211,7 +211,7 @@
 			power-domains = <&pd_pu>;
 		};
 
-		dma_apbh: dma-apbh@1804000 {
+		dma_apbh: dma-controller@1804000 {
 			compatible = "fsl,imx6sx-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x01804000 0x2000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 05390cc2a3b3b..5b677b66162ac 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -174,7 +174,7 @@
 			      <0x00a06000 0x2000>;
 		};
 
-		dma_apbh: dma-apbh@1804000 {
+		dma_apbh: dma-controller@1804000 {
 			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x01804000 0x2000>;
 			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 7a8521499eb40..a06efc1270fb6 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1192,7 +1192,7 @@
 			};
 		};
 
-		dma_apbh: dma-apbh@33000000 {
+		dma_apbh: dma-controller@33000000 {
 			compatible = "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x33000000 0x2000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.40.1



