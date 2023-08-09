Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D93775D13
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjHILdd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjHILdc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:33:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB3D1FEB
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7592A63448
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2538C433C8;
        Wed,  9 Aug 2023 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580810;
        bh=5E6uUPnJ5YSymgsnsMChAo7BKcDzHraTX4CqHsrYSFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zd3VGAMj+W7fBWVRakS/Con7MYI1uw8+2hvXMzOQpRdzGuJ3ZOGsRegewtnG+lYqy
         Hv2w+vFS2b+noUS1mejiUWzI8Y85RUaieyfu70Dpo5K/nfitnbRLQ15YzHCxPDGAqb
         6kHzOx7NRuCnKNftbbEZ2J+5Gpm/4GFgD0K/fpLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 148/154] ARM: dts: imx: add usb alias
Date:   Wed,  9 Aug 2023 12:42:59 +0200
Message-ID: <20230809103641.748781036@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 5c8b3b8a182cbc1ccdfcdeea9b25dd2c12a8148f ]

Add usb alias for bootloader searching the controller in correct order.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: ee70b908f77a ("ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++++
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 arch/arm/boot/dts/imx6sll.dtsi | 2 ++
 arch/arm/boot/dts/imx6sx.dtsi  | 3 +++
 arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
 arch/arm/boot/dts/imx7d.dtsi   | 6 ++++++
 arch/arm/boot/dts/imx7s.dtsi   | 2 ++
 7 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 9105e614fe5c6..bb02923bc2e5b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -45,6 +45,10 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg;
+		usb1 = &usbh1;
+		usb2 = &usbh2;
+		usb3 = &usbh3;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 452a77552e3d0..3cf1da06e7f04 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -39,6 +39,9 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+		usb2 = &usbh;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index 27c253d0fdde2..4c29fb9e35dce 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -36,6 +36,8 @@ aliases {
 		spi1 = &ecspi2;
 		spi3 = &ecspi3;
 		spi4 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 072d5fc9c6db9..790cc88c8b1ae 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -49,6 +49,9 @@ aliases {
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
 		spi4 = &ecspi5;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+		usb2 = &usbh;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index ae0722b93b9d7..05390cc2a3b3b 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -47,6 +47,8 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
 		usbphy0 = &usbphy1;
 		usbphy1 = &usbphy2;
 	};
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 9c8dd32cc035f..8b65ca8b5f30f 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -7,6 +7,12 @@
 #include <dt-bindings/reset/imx7-reset.h>
 
 / {
+	aliases {
+		usb0 = &usbotg1;
+		usb1 = &usbotg2;
+		usb2 = &usbh;
+	};
+
 	cpus {
 		cpu0: cpu@0 {
 			clock-frequency = <996000000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1ef076b64de26..e5151a7849d6b 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -47,6 +47,8 @@ aliases {
 		spi1 = &ecspi2;
 		spi2 = &ecspi3;
 		spi3 = &ecspi4;
+		usb0 = &usbotg1;
+		usb1 = &usbh;
 	};
 
 	cpus {
-- 
2.40.1



