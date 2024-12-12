Return-Path: <stable+bounces-101345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E716B9EEBED
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3E9188A825
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A76748A;
	Thu, 12 Dec 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sdpAWW3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21918209693;
	Thu, 12 Dec 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017235; cv=none; b=TFAdXZLbM4AamyTITjvQF5+3YXoPboyxmCZNUUjCvXxAJWEfKvI+PIk3DoJ1CZySS8d2hjFrrlO1FkokfBqtHbydtyUVpr4GJrIIMiDNLPOGj2yMqRRty4NyvbHIggzxzPvKoF6ZggTJWJetefXdIbNZhZcI72VoY7rF+gMnF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017235; c=relaxed/simple;
	bh=iuuCJWrXd8cJoHEbaHjwk/7mh9LPjSD5PWAuBnJ7OMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdUDZhEKQuWdH49ChIgw/SAY+FftqmUwrxPi4nG26NEmXpgZQs/dVraIzza95L8vTyXb7yTaPdkOaW+M2XgWsSiL6sqBdYZD5KBWeJ41/EYEzqU4O0lMkfKXxdnW8JOy85o0duVHhZcAGiet9DqcSGOWYcXbfnp73LOtd3GE00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sdpAWW3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E988C4CED0;
	Thu, 12 Dec 2024 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017235;
	bh=iuuCJWrXd8cJoHEbaHjwk/7mh9LPjSD5PWAuBnJ7OMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdpAWW3L/DhbbcoixNB8ewUDZENDB9Fz4dw7n63z4gFbbCTta8/9r77lLEBfz8rRy
	 KmJPt1tPmpsz/+6pksikFWT3by0HnShg5WhzUVEG3yp8soYgZnI/cBd1XBZkwPMvs8
	 BZHQNiC1FFhAsLycRetLY1MDUfh3FqOtGdCmK0W4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xi Ruoyao <xry111@xry111.site>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 419/466] MIPS: Loongson64: DTS: Really fix PCIe port nodes for ls7a
Date: Thu, 12 Dec 2024 15:59:48 +0100
Message-ID: <20241212144323.309915119@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xi Ruoyao <xry111@xry111.site>

[ Upstream commit 4fbd66d8254cedfd1218393f39d83b6c07a01917 ]

Fix the dtc warnings:

    arch/mips/boot/dts/loongson/ls7a-pch.dtsi:68.16-416.5: Warning (interrupt_provider): /bus@10000000/pci@1a000000: '#interrupt-cells' found, but node is not an interrupt provider
    arch/mips/boot/dts/loongson/ls7a-pch.dtsi:68.16-416.5: Warning (interrupt_provider): /bus@10000000/pci@1a000000: '#interrupt-cells' found, but node is not an interrupt provider
    arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'

And a runtime warning introduced in commit 045b14ca5c36 ("of: WARN on
deprecated #address-cells/#size-cells handling"):

    WARNING: CPU: 0 PID: 1 at drivers/of/base.c:106 of_bus_n_addr_cells+0x9c/0xe0
    Missing '#address-cells' in /bus@10000000/pci@1a000000/pci_bridge@9,0

The fix is similar to commit d89a415ff8d5 ("MIPS: Loongson64: DTS: Fix PCIe
port nodes for ls7a"), which has fixed the issue for ls2k (despite its
subject mentions ls7a).

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi | 73 +++++++++++++++++++----
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
index cce9428afc41f..ee71045883e7e 100644
--- a/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
+++ b/arch/mips/boot/dts/loongson/ls7a-pch.dtsi
@@ -70,7 +70,6 @@
 			device_type = "pci";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			#interrupt-cells = <2>;
 			msi-parent = <&msi>;
 
 			reg = <0 0x1a000000 0 0x02000000>,
@@ -234,7 +233,7 @@
 				};
 			};
 
-			pci_bridge@9,0 {
+			pcie@9,0 {
 				compatible = "pci0014,7a19.1",
 						   "pci0014,7a19",
 						   "pciclass060400",
@@ -244,12 +243,16 @@
 				interrupts = <32 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 32 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@a,0 {
+			pcie@a,0 {
 				compatible = "pci0014,7a09.1",
 						   "pci0014,7a09",
 						   "pciclass060400",
@@ -259,12 +262,16 @@
 				interrupts = <33 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 33 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@b,0 {
+			pcie@b,0 {
 				compatible = "pci0014,7a09.1",
 						   "pci0014,7a09",
 						   "pciclass060400",
@@ -274,12 +281,16 @@
 				interrupts = <34 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 34 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@c,0 {
+			pcie@c,0 {
 				compatible = "pci0014,7a09.1",
 						   "pci0014,7a09",
 						   "pciclass060400",
@@ -289,12 +300,16 @@
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 35 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@d,0 {
+			pcie@d,0 {
 				compatible = "pci0014,7a19.1",
 						   "pci0014,7a19",
 						   "pciclass060400",
@@ -304,12 +319,16 @@
 				interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 36 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@e,0 {
+			pcie@e,0 {
 				compatible = "pci0014,7a09.1",
 						   "pci0014,7a09",
 						   "pciclass060400",
@@ -319,12 +338,16 @@
 				interrupts = <37 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 37 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@f,0 {
+			pcie@f,0 {
 				compatible = "pci0014,7a29.1",
 						   "pci0014,7a29",
 						   "pciclass060400",
@@ -334,12 +357,16 @@
 				interrupts = <40 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 40 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@10,0 {
+			pcie@10,0 {
 				compatible = "pci0014,7a19.1",
 						   "pci0014,7a19",
 						   "pciclass060400",
@@ -349,12 +376,16 @@
 				interrupts = <41 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 41 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@11,0 {
+			pcie@11,0 {
 				compatible = "pci0014,7a29.1",
 						   "pci0014,7a29",
 						   "pciclass060400",
@@ -364,12 +395,16 @@
 				interrupts = <42 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 42 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@12,0 {
+			pcie@12,0 {
 				compatible = "pci0014,7a19.1",
 						   "pci0014,7a19",
 						   "pciclass060400",
@@ -379,12 +414,16 @@
 				interrupts = <43 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 43 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@13,0 {
+			pcie@13,0 {
 				compatible = "pci0014,7a29.1",
 						   "pci0014,7a29",
 						   "pciclass060400",
@@ -394,12 +433,16 @@
 				interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 38 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 
-			pci_bridge@14,0 {
+			pcie@14,0 {
 				compatible = "pci0014,7a19.1",
 						   "pci0014,7a19",
 						   "pciclass060400",
@@ -409,9 +452,13 @@
 				interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&pic>;
 
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
 				interrupt-map-mask = <0 0 0 0>;
 				interrupt-map = <0 0 0 0 &pic 39 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 			};
 		};
 
-- 
2.43.0




