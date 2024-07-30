Return-Path: <stable+bounces-62755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866ED940F6D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC695B28240
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D041A2570;
	Tue, 30 Jul 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FuaaAs/t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7762E19FA82
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335277; cv=none; b=YN/mDup1N4X/l4obwvDVTSGUGcP2nmWX6rMxHjyp6IhsRq4p4Gcc1offc3esL2YS8pR2J7gasDdT+8/3tt+s/coJeAzB5e/37a8BYGlTbku2YP0zfOBuxaPVL/kKinq/aaHZa9Mio/tBWJ2J8RHKS6/s9ie4JKRGHChQjStZP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335277; c=relaxed/simple;
	bh=0/weN4hzDGHrShieXYR13uJo1YdYTfVo0zqb40G/Twk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zk9Cy8b5ybHX2nD1/fARJRNJU2yRF0HAqqmUmcHsQa7TMc8NZwzIfLdPKL/gimQe0+Vg8G49G1CkLPeXzzpffa0kCyy2PTH2tVHPZrvU5lsTYALRIUva76udkGznHLJ1DxC308YofR3DPfFL0TKkEIVznm6BXf8d6OH/bQOQoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FuaaAs/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA17BC4AF09;
	Tue, 30 Jul 2024 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335277;
	bh=0/weN4hzDGHrShieXYR13uJo1YdYTfVo0zqb40G/Twk=;
	h=Subject:To:Cc:From:Date:From;
	b=FuaaAs/t1AYXrtDYAv6uJEN2nohn2DikQXcQLIA+o3cXZ1TNDM5nyFnyAIAaqcsj5
	 z6GtYQnZsEMNVWSnyK0HyOC19000DEyjIoIqdpegBi7IIs70hSyLvoQ0IAVvrZYOT+
	 5hNRcYq4cJSwCAO7TDrZKs7Lx0XWEy44ymYElH2Q=
Subject: FAILED: patch "[PATCH] MIPS: dts: loongson: Fix liointc IRQ polarity" failed to apply to 6.10-stable tree
To: jiaxun.yang@flygoat.com,tsbogend@alpha.franken.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:27:54 +0200
Message-ID: <2024073054-estate-stylishly-6520@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x dbb69b9d6234aad23b3ecd33e5bc8a8ae1485b7d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073054-estate-stylishly-6520@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

dbb69b9d6234 ("MIPS: dts: loongson: Fix liointc IRQ polarity")
d89a415ff8d5 ("MIPS: Loongson64: DTS: Fix PCIe port nodes for ls7a")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dbb69b9d6234aad23b3ecd33e5bc8a8ae1485b7d Mon Sep 17 00:00:00 2001
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 14 Jun 2024 16:40:10 +0100
Subject: [PATCH] MIPS: dts: loongson: Fix liointc IRQ polarity

All internal liointc interrupts are high level triggered.

Fixes: b1a792601f26 ("MIPS: Loongson64: DeviceTree for Loongson-2K1000")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index f5a74338bf05..3f5255584c30 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -93,7 +93,7 @@ rtc0: rtc@1fe07800 {
 			compatible = "loongson,ls2k1000-rtc";
 			reg = <0 0x1fe07800 0 0x78>;
 			interrupt-parent = <&liointc0>;
-			interrupts = <60 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		uart0: serial@1fe00000 {
@@ -101,7 +101,7 @@ uart0: serial@1fe00000 {
 			reg = <0 0x1fe00000 0 0x8>;
 			clock-frequency = <125000000>;
 			interrupt-parent = <&liointc0>;
-			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 			no-loopback-test;
 		};
 
@@ -124,8 +124,8 @@ gmac@3,0 {
 						   "pciclass0c03";
 
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
-				interrupts = <12 IRQ_TYPE_LEVEL_LOW>,
-					     <13 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
+					     <13 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
 				interrupt-parent = <&liointc0>;
 				phy-mode = "rgmii";
@@ -147,8 +147,8 @@ gmac@3,1 {
 						   "loongson, pci-gmac";
 
 				reg = <0x1900 0x0 0x0 0x0 0x0>;
-				interrupts = <14 IRQ_TYPE_LEVEL_LOW>,
-					     <15 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+					     <15 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
 				interrupt-parent = <&liointc0>;
 				phy-mode = "rgmii";
@@ -169,7 +169,7 @@ ehci@4,1 {
 						   "pciclass0c03";
 
 				reg = <0x2100 0x0 0x0 0x0 0x0>;
-				interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 			};
 
@@ -180,7 +180,7 @@ ohci@4,2 {
 						   "pciclass0c03";
 
 				reg = <0x2200 0x0 0x0 0x0 0x0>;
-				interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 			};
 
@@ -191,7 +191,7 @@ sata@8,0 {
 						   "pciclass0106";
 
 				reg = <0x4000 0x0 0x0 0x0 0x0>;
-				interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc0>;
 			};
 
@@ -206,10 +206,10 @@ pcie@9,0 {
 				#size-cells = <2>;
 				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 0 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 0 IRQ_TYPE_LEVEL_HIGH>;
 				ranges;
 				external-facing;
 			};
@@ -225,10 +225,10 @@ pcie@a,0 {
 				#size-cells = <2>;
 				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 1 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 1 IRQ_TYPE_LEVEL_HIGH>;
 				ranges;
 				external-facing;
 			};
@@ -244,10 +244,10 @@ pcie@b,0 {
 				#size-cells = <2>;
 				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 2 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 2 IRQ_TYPE_LEVEL_HIGH>;
 				ranges;
 				external-facing;
 			};
@@ -263,10 +263,10 @@ pcie@c,0 {
 				#size-cells = <2>;
 				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 3 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 3 IRQ_TYPE_LEVEL_HIGH>;
 				ranges;
 				external-facing;
 			};
@@ -282,10 +282,10 @@ pcie@d,0 {
 				#size-cells = <2>;
 				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 4 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 4 IRQ_TYPE_LEVEL_HIGH>;
 				ranges;
 				external-facing;
 			};
@@ -301,10 +301,10 @@ pcie@e,0 {
 				#size-cells = <2>;
 				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 5 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 5 IRQ_TYPE_LEVEL_HIGH>;
 				ranges;
 				external-facing;
 			};


