Return-Path: <stable+bounces-152281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFF6AD3521
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B193B174F16
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1288D28B511;
	Tue, 10 Jun 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nV+NAala"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFEA28C00D;
	Tue, 10 Jun 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555501; cv=none; b=gtRJzy1P5rK09MfvLZqld+utsQtXhCu3jdMiO8vs5ccKAu+04CVK3u4NpA1eEwHoE7WSRAcowpTJAG6jDv9h+LbEMsuMsBBdfTaz43sCrx9hhTiFk1s8zn5a14aCXyrnBJhHXEXiCZ7QuEiP6zyPjDdxzS1ahgGaGQtpWFVliZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555501; c=relaxed/simple;
	bh=CS/PHPlPEfq6DmjwSe2MSCbzhupFa9l3b0fflUfP0Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLIg/w2YzOcjoI2hE/RmBVI77Onlh5KnmovJ3uMOOQP57IrgXETBPrRENvakP2w+V0GciNbI8YNQsB3jCt0gOr+EV9gUpkzwsMHmd5RkAQ/Jo2NFROGKwZ7u83yCeR7JtNsbrzs6vLuUNza3/GSv4waOOjtCdMw4H25gETPrX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nV+NAala; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A90EC4CEED;
	Tue, 10 Jun 2025 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749555501;
	bh=CS/PHPlPEfq6DmjwSe2MSCbzhupFa9l3b0fflUfP0Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nV+NAalaovfbhziMiFq0+1Fiy2mVyC+P3QA9aShzND5vBjiP9eRk2bC09Mcv9tLHR
	 rPZ9fBdUVAHtgiJ3O/cT8PrrHe6TAdJyDyB6v3WCH30mQ+Xayd94E8BjR6BcjfWFby
	 c82zfItTkg971LRIVNINuL0XDBlkgx9pi3V7Ld6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.33
Date: Tue, 10 Jun 2025 07:38:09 -0400
Message-ID: <2025061009-pleading-defile-d728@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025061009-unfasten-laurel-6109@gregkh>
References: <2025061009-unfasten-laurel-6109@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
index dc3a3f709fea..bac4d0b51d8a 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
@@ -58,8 +58,7 @@ properties:
   fsl,phy-tx-vboost-level-microvolt:
     description:
       Adjust the boosted transmit launch pk-pk differential amplitude
-    minimum: 880
-    maximum: 1120
+    enum: [844, 1008, 1156]
 
   fsl,phy-comp-dis-tune-percent:
     description:
diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
index e44e88d993d0..e802e9ac975b 100644
--- a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
+++ b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
@@ -14,9 +14,22 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - usb4b4,6504
-      - usb4b4,6506
+    oneOf:
+      - enum:
+          - usb4b4,6504
+          - usb4b4,6506
+      - items:
+          - enum:
+              - usb4b4,6500
+              - usb4b4,6508
+          - const: usb4b4,6504
+      - items:
+          - enum:
+              - usb4b4,6502
+              - usb4b4,6503
+              - usb4b4,6507
+              - usb4b4,650a
+          - const: usb4b4,6506
 
   reg: true
 
diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
index 8d8b53e96bcf..ccb4b153e6f2 100644
--- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
+++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
@@ -12,11 +12,14 @@ ACPI in general allows referring to device objects in the tree only.
 Hierarchical data extension nodes may not be referred to directly, hence this
 document defines a scheme to implement such references.
 
-A reference consist of the device object name followed by one or more
-hierarchical data extension [dsd-guide] keys. Specifically, the hierarchical
-data extension node which is referred to by the key shall lie directly under
-the parent object i.e. either the device object or another hierarchical data
-extension node.
+A reference to a _DSD hierarchical data node is a string consisting of a
+device object reference followed by a dot (".") and a relative path to a data
+node object. Do not use non-string references as this will produce a copy of
+the hierarchical data node, not a reference!
+
+The hierarchical data extension node which is referred to shall be located
+directly under its parent object i.e. either the device object or another
+hierarchical data extension node [dsd-guide].
 
 The keys in the hierarchical data nodes shall consist of the name of the node,
 "@" character and the number of the node in hexadecimal notation (without pre-
@@ -33,11 +36,9 @@ extension key.
 Example
 =======
 
-In the ASL snippet below, the "reference" _DSD property contains a
-device object reference to DEV0 and under that device object, a
-hierarchical data extension key "node@1" referring to the NOD1 object
-and lastly, a hierarchical data extension key "anothernode" referring to
-the ANOD object which is also the final target node of the reference.
+In the ASL snippet below, the "reference" _DSD property contains a string
+reference to a hierarchical data extension node ANOD under DEV0 under the parent
+of DEV1. ANOD is also the final target node of the reference.
 ::
 
 	Device (DEV0)
@@ -76,10 +77,7 @@ the ANOD object which is also the final target node of the reference.
 	    Name (_DSD, Package () {
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
-		    Package () {
-			"reference", Package () {
-			    ^DEV0, "node@1", "anothernode"
-			}
+		    Package () { "reference", "^DEV0.ANOD" }
 		    },
 		}
 	    })
diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
index b9dbfc73ed25..d6ae5ffa748c 100644
--- a/Documentation/firmware-guide/acpi/dsd/graph.rst
+++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
@@ -66,12 +66,9 @@ of that port shall be zero. Similarly, if a port may only have a single
 endpoint, the number of that endpoint shall be zero.
 
 The endpoint reference uses property extension with "remote-endpoint" property
-name followed by a reference in the same package. Such references consist of
-the remote device reference, the first package entry of the port data extension
-reference under the device and finally the first package entry of the endpoint
-data extension reference under the port. Individual references thus appear as::
+name followed by a string reference in the same package. [data-node-ref]::
 
-    Package() { device, "port@X", "endpoint@Y" }
+    "device.datanode"
 
 In the above example, "X" is the number of the port and "Y" is the number of
 the endpoint.
@@ -109,7 +106,7 @@ A simple example of this is show below::
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
 		    Package () { "reg", 0 },
-		    Package () { "remote-endpoint", Package() { \_SB.PCI0.ISP, "port@4", "endpoint@0" } },
+		    Package () { "remote-endpoint", "\\_SB.PCI0.ISP.EP40" },
 		}
 	    })
 	}
@@ -141,7 +138,7 @@ A simple example of this is show below::
 		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 		Package () {
 		    Package () { "reg", 0 },
-		    Package () { "remote-endpoint", Package () { \_SB.PCI0.I2C2.CAM0, "port@0", "endpoint@0" } },
+		    Package () { "remote-endpoint", "\\_SB.PCI0.I2C2.CAM0.EP00" },
 		}
 	    })
 	}
diff --git a/Documentation/firmware-guide/acpi/dsd/leds.rst b/Documentation/firmware-guide/acpi/dsd/leds.rst
index 93db592c93c7..a97cd07d49be 100644
--- a/Documentation/firmware-guide/acpi/dsd/leds.rst
+++ b/Documentation/firmware-guide/acpi/dsd/leds.rst
@@ -15,11 +15,6 @@ Referring to LEDs in Device tree is documented in [video-interfaces], in
 "flash-leds" property documentation. In short, LEDs are directly referred to by
 using phandles.
 
-While Device tree allows referring to any node in the tree [devicetree], in
-ACPI references are limited to device nodes only [acpi]. For this reason using
-the same mechanism on ACPI is not possible. A mechanism to refer to non-device
-ACPI nodes is documented in [data-node-ref].
-
 ACPI allows (as does DT) using integer arguments after the reference. A
 combination of the LED driver device reference and an integer argument,
 referring to the "reg" property of the relevant LED, is used to identify
@@ -74,7 +69,7 @@ omitted. ::
 			Package () {
 				Package () {
 					"flash-leds",
-					Package () { ^LED, "led@0", ^LED, "led@1" },
+					Package () { "^LED.LED0", "^LED.LED1" },
 				}
 			}
 		})
diff --git a/Makefile b/Makefile
index 1e6a6c66403f..c53dd3520193 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 32
+SUBLEVEL = 33
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/block/bio.c b/block/bio.c
index 20c74696bf23..094a5adf79d2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1156,9 +1156,10 @@ EXPORT_SYMBOL(bio_add_page);
 void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
 			  size_t off)
 {
+	unsigned long nr = off / PAGE_SIZE;
+
 	WARN_ON_ONCE(len > UINT_MAX);
-	WARN_ON_ONCE(off > UINT_MAX);
-	__bio_add_page(bio, &folio->page, len, off);
+	__bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE);
 }
 EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
 
@@ -1179,9 +1180,11 @@ EXPORT_SYMBOL_GPL(bio_add_folio_nofail);
 bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 		   size_t off)
 {
-	if (len > UINT_MAX || off > UINT_MAX)
+	unsigned long nr = off / PAGE_SIZE;
+
+	if (len > UINT_MAX)
 		return false;
-	return bio_add_page(bio, &folio->page, len, off) > 0;
+	return bio_add_page(bio, folio_page(folio, nr), len, off % PAGE_SIZE) > 0;
 }
 EXPORT_SYMBOL(bio_add_folio);
 
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 168d03d5aa1d..67d56a944d54 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -709,6 +709,7 @@ static struct pci_device_id ivpu_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_MTL) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_ARL) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_LNL) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PTL_P) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, ivpu_pci_ids);
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index a5707a85e725..1fe6a3bd4e36 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -23,9 +23,10 @@
 #define DRIVER_DESC "Driver for Intel NPU (Neural Processing Unit)"
 #define DRIVER_DATE "20230117"
 
-#define PCI_DEVICE_ID_MTL   0x7d1d
-#define PCI_DEVICE_ID_ARL   0xad1d
-#define PCI_DEVICE_ID_LNL   0x643e
+#define PCI_DEVICE_ID_MTL	0x7d1d
+#define PCI_DEVICE_ID_ARL	0xad1d
+#define PCI_DEVICE_ID_LNL	0x643e
+#define PCI_DEVICE_ID_PTL_P	0xb03e
 
 #define IVPU_HW_IP_37XX 37
 #define IVPU_HW_IP_40XX 40
@@ -227,6 +228,8 @@ static inline int ivpu_hw_ip_gen(struct ivpu_device *vdev)
 		return IVPU_HW_IP_37XX;
 	case PCI_DEVICE_ID_LNL:
 		return IVPU_HW_IP_40XX;
+	case PCI_DEVICE_ID_PTL_P:
+		return IVPU_HW_IP_50XX;
 	default:
 		dump_stack();
 		ivpu_err(vdev, "Unknown NPU IP generation\n");
@@ -241,6 +244,7 @@ static inline int ivpu_hw_btrs_gen(struct ivpu_device *vdev)
 	case PCI_DEVICE_ID_ARL:
 		return IVPU_HW_BTRS_MTL;
 	case PCI_DEVICE_ID_LNL:
+	case PCI_DEVICE_ID_PTL_P:
 		return IVPU_HW_BTRS_LNL;
 	default:
 		dump_stack();
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index d12188730ac7..83e4995540a6 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -57,11 +57,14 @@ static struct {
 	{ IVPU_HW_IP_37XX, "intel/vpu/vpu_37xx_v0.0.bin" },
 	{ IVPU_HW_IP_40XX, "vpu_40xx.bin" },
 	{ IVPU_HW_IP_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
+	{ IVPU_HW_IP_50XX, "vpu_50xx.bin" },
+	{ IVPU_HW_IP_50XX, "intel/vpu/vpu_50xx_v0.0.bin" },
 };
 
 /* Production fw_names from the table above */
 MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
 MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_50xx_v0.0.bin");
 
 static int ivpu_fw_request(struct ivpu_device *vdev)
 {
diff --git a/drivers/accel/ivpu/ivpu_hw_40xx_reg.h b/drivers/accel/ivpu/ivpu_hw_40xx_reg.h
index d0b795b344c7..fc0ee8d637f9 100644
--- a/drivers/accel/ivpu/ivpu_hw_40xx_reg.h
+++ b/drivers/accel/ivpu/ivpu_hw_40xx_reg.h
@@ -115,6 +115,8 @@
 
 #define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY			0x00030068u
 #define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY_POST_DLY_MASK	GENMASK(7, 0)
+#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY_POST1_DLY_MASK	GENMASK(15, 8)
+#define VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY_POST2_DLY_MASK	GENMASK(23, 16)
 
 #define VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY			0x0003006cu
 #define VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY_STATUS_DLY_MASK	GENMASK(7, 0)
diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
index 60b33fc59d96..bd2582a8c80f 100644
--- a/drivers/accel/ivpu/ivpu_hw_ip.c
+++ b/drivers/accel/ivpu/ivpu_hw_ip.c
@@ -8,15 +8,12 @@
 #include "ivpu_hw.h"
 #include "ivpu_hw_37xx_reg.h"
 #include "ivpu_hw_40xx_reg.h"
+#include "ivpu_hw_btrs.h"
 #include "ivpu_hw_ip.h"
 #include "ivpu_hw_reg_io.h"
 #include "ivpu_mmu.h"
 #include "ivpu_pm.h"
 
-#define PWR_ISLAND_EN_POST_DLY_FREQ_DEFAULT 0
-#define PWR_ISLAND_EN_POST_DLY_FREQ_HIGH    18
-#define PWR_ISLAND_STATUS_DLY_FREQ_DEFAULT  3
-#define PWR_ISLAND_STATUS_DLY_FREQ_HIGH	    46
 #define PWR_ISLAND_STATUS_TIMEOUT_US        (5 * USEC_PER_MSEC)
 
 #define TIM_SAFE_ENABLE		            0xf1d0dead
@@ -268,20 +265,15 @@ void ivpu_hw_ip_idle_gen_disable(struct ivpu_device *vdev)
 		idle_gen_drive_40xx(vdev, false);
 }
 
-static void pwr_island_delay_set_50xx(struct ivpu_device *vdev)
+static void
+pwr_island_delay_set_50xx(struct ivpu_device *vdev, u32 post, u32 post1, u32 post2, u32 status)
 {
-	u32 val, post, status;
-
-	if (vdev->hw->pll.profiling_freq == PLL_PROFILING_FREQ_DEFAULT) {
-		post = PWR_ISLAND_EN_POST_DLY_FREQ_DEFAULT;
-		status = PWR_ISLAND_STATUS_DLY_FREQ_DEFAULT;
-	} else {
-		post = PWR_ISLAND_EN_POST_DLY_FREQ_HIGH;
-		status = PWR_ISLAND_STATUS_DLY_FREQ_HIGH;
-	}
+	u32 val;
 
 	val = REGV_RD32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY);
 	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST_DLY, post, val);
+	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST1_DLY, post1, val);
+	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST2_DLY, post2, val);
 	REGV_WR32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, val);
 
 	val = REGV_RD32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY);
@@ -686,13 +678,36 @@ static void dpu_active_drive_37xx(struct ivpu_device *vdev, bool enable)
 	REGV_WR32(VPU_37XX_HOST_SS_AON_DPU_ACTIVE, val);
 }
 
+static void pwr_island_delay_set(struct ivpu_device *vdev)
+{
+	bool high = vdev->hw->pll.profiling_freq == PLL_PROFILING_FREQ_HIGH;
+	u32 post, post1, post2, status;
+
+	if (ivpu_hw_ip_gen(vdev) < IVPU_HW_IP_50XX)
+		return;
+
+	switch (ivpu_device_id(vdev)) {
+	case PCI_DEVICE_ID_PTL_P:
+		post = high ? 18 : 0;
+		post1 = 0;
+		post2 = 0;
+		status = high ? 46 : 3;
+		break;
+
+	default:
+		dump_stack();
+		ivpu_err(vdev, "Unknown device ID\n");
+		return;
+	}
+
+	pwr_island_delay_set_50xx(vdev, post, post1, post2, status);
+}
+
 int ivpu_hw_ip_pwr_domain_enable(struct ivpu_device *vdev)
 {
 	int ret;
 
-	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_50XX)
-		pwr_island_delay_set_50xx(vdev);
-
+	pwr_island_delay_set(vdev);
 	pwr_island_enable(vdev);
 
 	ret = wait_for_pwr_island_status(vdev, 0x1);
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1837622ea625..025b9a07c087 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2385,14 +2385,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
-		if (IS_ERR(qcadev->bt_en) &&
-		    (data->soc_type == QCA_WCN6750 ||
-		     data->soc_type == QCA_WCN6855)) {
-			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
-			return PTR_ERR(qcadev->bt_en);
-		}
+		if (IS_ERR(qcadev->bt_en))
+			return dev_err_probe(&serdev->dev,
+					     PTR_ERR(qcadev->bt_en),
+					     "failed to acquire BT_EN gpio\n");
 
-		if (!qcadev->bt_en)
+		if (!qcadev->bt_en &&
+		    (data->soc_type == QCA_WCN6750 ||
+		     data->soc_type == QCA_WCN6855))
 			power_ctrl_enabled = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 47e910c22a80..0f1679817682 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -663,7 +663,7 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (nominal_freq)
-		*nominal_freq = perf_caps.nominal_freq;
+		*nominal_freq = perf_caps.nominal_freq * 1000;
 
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 4e5b6f9a56d1..7b8fcfa55038 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -73,18 +73,11 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
-	u32 cpu;
 
 	policy->freq_table = data->clusters[cluster].table;
 	policy->cpuinfo.transition_latency = 300 * 1000;
 	policy->driver_data = NULL;
 
-	/* set same policy for all cpus in a cluster */
-	for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
-		if (data->cpus[cpu].bpmp_cluster_id == cluster)
-			cpumask_set_cpu(cpu, policy->cpus);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5f9452b22596..084d9ed325af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -668,21 +668,15 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
 	if (acrtc->dm_irq_params.stream &&
-		acrtc->dm_irq_params.vrr_params.supported) {
-		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
-		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
-		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
-
+	    acrtc->dm_irq_params.vrr_params.supported &&
+	    acrtc->dm_irq_params.freesync_config.state ==
+		    VRR_STATE_ACTIVE_VARIABLE) {
 		mod_freesync_handle_v_update(adev->dm.freesync_module,
 					     acrtc->dm_irq_params.stream,
 					     &acrtc->dm_irq_params.vrr_params);
 
-		/* update vmin_vmax only if freesync is enabled, or only if PSR and REPLAY are disabled */
-		if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
-			dc_stream_adjust_vmin_vmax(adev->dm.dc,
-					acrtc->dm_irq_params.stream,
-					&acrtc->dm_irq_params.vrr_params.adjust);
-		}
+		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_params.stream,
+					   &acrtc->dm_irq_params.vrr_params.adjust);
 	}
 
 	/*
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 62650a2f00cc..a392e060ca2f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -805,6 +805,15 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &parent_lnkctl);
 	pcie_capability_read_word(child, PCI_EXP_LNKCTL, &child_lnkctl);
 
+	/* Disable L0s/L1 before updating L1SS config */
+	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
+	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
+		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
+					   child_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL,
+					   parent_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+	}
+
 	/*
 	 * Setup L0s state
 	 *
@@ -829,6 +838,13 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	aspm_l1ss_init(link);
 
+	/* Restore L0s/L1 if they were enabled */
+	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
+	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
+		pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);
+	}
+
 	/* Save default state */
 	link->aspm_default = link->aspm_enabled;
 
@@ -845,25 +861,28 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 }
 
-/* Configure the ASPM L1 substates */
+/* Configure the ASPM L1 substates. Caller must disable L1 first. */
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
-	u32 val, enable_req;
+	u32 val;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 
-	enable_req = (link->aspm_enabled ^ state) & state;
+	val = 0;
+	if (state & PCIE_LINK_STATE_L1_1)
+		val |= PCI_L1SS_CTL1_ASPM_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2)
+		val |= PCI_L1SS_CTL1_ASPM_L1_2;
+	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
+		val |= PCI_L1SS_CTL1_PCIPM_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
+		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
 
 	/*
-	 * Here are the rules specified in the PCIe spec for enabling L1SS:
-	 * - When enabling L1.x, enable bit at parent first, then at child
-	 * - When disabling L1.x, disable bit at child first, then at parent
-	 * - When enabling ASPM L1.x, need to disable L1
-	 *   (at child followed by parent).
-	 * - The ASPM/PCIPM L1.2 must be disabled while programming timing
+	 * PCIe r6.2, sec 5.5.4, rules for enabling L1 PM Substates:
+	 * - Clear L1.x enable bits at child first, then at parent
+	 * - Set L1.x enable bits at parent first, then at child
+	 * - ASPM/PCIPM L1.2 must be disabled while programming timing
 	 *   parameters
-	 *
-	 * To keep it simple, disable all L1SS bits first, and later enable
-	 * what is needed.
 	 */
 
 	/* Disable all L1 substates */
@@ -871,26 +890,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 				       PCI_L1SS_CTL1_L1SS_MASK, 0);
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_L1SS_MASK, 0);
-	/*
-	 * If needed, disable L1, and it gets enabled later
-	 * in pcie_config_aspm_link().
-	 */
-	if (enable_req & (PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)) {
-		pcie_capability_clear_word(child, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPM_L1);
-		pcie_capability_clear_word(parent, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPM_L1);
-	}
-
-	val = 0;
-	if (state & PCIE_LINK_STATE_L1_1)
-		val |= PCI_L1SS_CTL1_ASPM_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2)
-		val |= PCI_L1SS_CTL1_ASPM_L1_2;
-	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
-		val |= PCI_L1SS_CTL1_PCIPM_L1_1;
-	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
-		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
 
 	/* Enable what we need to enable */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
@@ -937,21 +936,30 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		dwstream |= PCI_EXP_LNKCTL_ASPM_L1;
 	}
 
+	/*
+	 * Per PCIe r6.2, sec 5.5.4, setting either or both of the enable
+	 * bits for ASPM L1 PM Substates must be done while ASPM L1 is
+	 * disabled. Disable L1 here and apply new configuration after L1SS
+	 * configuration has been completed.
+	 *
+	 * Per sec 7.5.3.7, when disabling ASPM L1, software must disable
+	 * it in the Downstream component prior to disabling it in the
+	 * Upstream component, and ASPM L1 must be enabled in the Upstream
+	 * component prior to enabling it in the Downstream component.
+	 *
+	 * Sec 7.5.3.7 also recommends programming the same ASPM Control
+	 * value for all functions of a multi-function device.
+	 */
+	list_for_each_entry(child, &linkbus->devices, bus_list)
+		pcie_config_aspm_dev(child, 0);
+	pcie_config_aspm_dev(parent, 0);
+
 	if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
 		pcie_config_aspm_l1ss(link, state);
 
-	/*
-	 * Spec 2.0 suggests all functions should be configured the
-	 * same setting for ASPM. Enabling ASPM L1 should be done in
-	 * upstream component first and then downstream, and vice
-	 * versa for disabling ASPM L1. Spec doesn't mention L0S.
-	 */
-	if (state & PCIE_LINK_STATE_L1)
-		pcie_config_aspm_dev(parent, upstream);
+	pcie_config_aspm_dev(parent, upstream);
 	list_for_each_entry(child, &linkbus->devices, bus_list)
 		pcie_config_aspm_dev(child, dwstream);
-	if (!(state & PCIE_LINK_STATE_L1))
-		pcie_config_aspm_dev(parent, upstream);
 
 	link->aspm_enabled = state;
 
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 4c4ada06423d..4ce11c74fec1 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -417,20 +417,22 @@ static int armada_37xx_gpio_direction_output(struct gpio_chip *chip,
 					     unsigned int offset, int value)
 {
 	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
-	unsigned int reg = OUTPUT_EN;
+	unsigned int en_offset = offset;
+	unsigned int reg = OUTPUT_VAL;
 	unsigned int mask, val, ret;
 
 	armada_37xx_update_reg(&reg, &offset);
 	mask = BIT(offset);
+	val = value ? mask : 0;
 
-	ret = regmap_update_bits(info->regmap, reg, mask, mask);
-
+	ret = regmap_update_bits(info->regmap, reg, mask, val);
 	if (ret)
 		return ret;
 
-	reg = OUTPUT_VAL;
-	val = value ? mask : 0;
-	regmap_update_bits(info->regmap, reg, mask, val);
+	reg = OUTPUT_EN;
+	armada_37xx_update_reg(&reg, &en_offset);
+
+	regmap_update_bits(info->regmap, reg, mask, mask);
 
 	return 0;
 }
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index e31fa0ad127e..a0afdeaac270 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -327,7 +327,7 @@ static void rtc_device_get_offset(struct rtc_device *rtc)
 	 *
 	 * Otherwise the offset seconds should be 0.
 	 */
-	if (rtc->start_secs > rtc->range_max ||
+	if ((rtc->start_secs >= 0 && rtc->start_secs > rtc->range_max) ||
 	    rtc->start_secs + range_secs - 1 < rtc->range_min)
 		rtc->offset_secs = rtc->start_secs - rtc->range_min;
 	else if (rtc->start_secs > rtc->range_min)
diff --git a/drivers/rtc/lib.c b/drivers/rtc/lib.c
index fe361652727a..13b5b1f20465 100644
--- a/drivers/rtc/lib.c
+++ b/drivers/rtc/lib.c
@@ -46,24 +46,38 @@ EXPORT_SYMBOL(rtc_year_days);
  * rtc_time64_to_tm - converts time64_t to rtc_time.
  *
  * @time:	The number of seconds since 01-01-1970 00:00:00.
- *		(Must be positive.)
+ *		Works for values since at least 1900
  * @tm:		Pointer to the struct rtc_time.
  */
 void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 {
-	unsigned int secs;
-	int days;
+	int days, secs;
 
 	u64 u64tmp;
 	u32 u32tmp, udays, century, day_of_century, year_of_century, year,
 		day_of_year, month, day;
 	bool is_Jan_or_Feb, is_leap_year;
 
-	/* time must be positive */
+	/*
+	 * Get days and seconds while preserving the sign to
+	 * handle negative time values (dates before 1970-01-01)
+	 */
 	days = div_s64_rem(time, 86400, &secs);
 
+	/*
+	 * We need 0 <= secs < 86400 which isn't given for negative
+	 * values of time. Fixup accordingly.
+	 */
+	if (secs < 0) {
+		days -= 1;
+		secs += 86400;
+	}
+
 	/* day of the week, 1970-01-01 was a Thursday */
 	tm->tm_wday = (days + 4) % 7;
+	/* Ensure tm_wday is always positive */
+	if (tm->tm_wday < 0)
+		tm->tm_wday += 7;
 
 	/*
 	 * The following algorithm is, basically, Proposition 6.3 of Neri
@@ -93,7 +107,7 @@ void rtc_time64_to_tm(time64_t time, struct rtc_time *tm)
 	 * thus, is slightly different from [1].
 	 */
 
-	udays		= ((u32) days) + 719468;
+	udays		= days + 719468;
 
 	u32tmp		= 4 * udays + 3;
 	century		= u32tmp / 146097;
diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 4bdb2d45e0bf..58ab3d86bc25 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -148,6 +148,11 @@ static void tb_cfg_request_dequeue(struct tb_cfg_request *req)
 	struct tb_ctl *ctl = req->ctl;
 
 	mutex_lock(&ctl->request_queue_lock);
+	if (!test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags)) {
+		mutex_unlock(&ctl->request_queue_lock);
+		return;
+	}
+
 	list_del(&req->list);
 	clear_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
 	if (test_bit(TB_CFG_REQUEST_CANCELED, &req->flags))
diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index ce0fef7e2c66..be2f130696b3 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -451,6 +451,7 @@ int jsm_uart_port_init(struct jsm_board *brd)
 		if (!brd->channels[i])
 			continue;
 
+		brd->channels[i]->uart_port.dev = &brd->pci_dev->dev;
 		brd->channels[i]->uart_port.irq = brd->irq;
 		brd->channels[i]->uart_port.uartclk = 14745600;
 		brd->channels[i]->uart_port.type = PORT_JSM;
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 740d2d2b19fb..66f3d9324ba2 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -483,6 +483,7 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 	u8 tag;
 	int rv;
 	long wait_rv;
+	unsigned long expire;
 
 	dev_dbg(dev, "Enter ioctl_read_stb iin_ep_present: %d\n",
 		data->iin_ep_present);
@@ -512,10 +513,11 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 	}
 
 	if (data->iin_ep_present) {
+		expire = msecs_to_jiffies(file_data->timeout);
 		wait_rv = wait_event_interruptible_timeout(
 			data->waitq,
 			atomic_read(&data->iin_data_valid) != 0,
-			file_data->timeout);
+			expire);
 		if (wait_rv < 0) {
 			dev_dbg(dev, "wait interrupted %ld\n", wait_rv);
 			rv = wait_rv;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 4903c733d37a..c979ecd0169a 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -372,6 +372,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* SanDisk Corp. SanDisk 3.2Gen1 */
 	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* SanDisk Extreme 55AE */
+	{ USB_DEVICE(0x0781, 0x55ae), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Realforce 87U Keyboard */
 	{ USB_DEVICE(0x0853, 0x011b), .driver_info = USB_QUIRK_NO_LPM },
 
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index ad41363e3cea..9708c3d40f07 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -457,6 +457,8 @@ static int pl2303_detect_type(struct usb_serial *serial)
 		case 0x605:
 		case 0x700:	/* GR */
 		case 0x705:
+		case 0x905:	/* GT-2AB */
+		case 0x1005:	/* GC-Q20 */
 			return TYPE_HXN;
 		}
 		break;
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index d460d71b4257..1477e31d7763 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -52,6 +52,13 @@ UNUSUAL_DEV(0x059f, 0x1061, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES | US_FL_NO_SAME),
 
+/* Reported-by: Zhihong Zhou <zhouzhihong@greatwall.com.cn> */
+UNUSUAL_DEV(0x0781, 0x55e8, 0x0000, 0x9999,
+		"SanDisk",
+		"",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS),
+
 /* Reported-by: Hongling Zeng <zenghongling@kylinos.cn> */
 UNUSUAL_DEV(0x090c, 0x2000, 0x0000, 0x9999,
 		"Hiksemi",
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 5863a20b6c5d..0568e643e844 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -367,7 +367,7 @@ struct ucsi_debugfs_entry {
 		u64 low;
 		u64 high;
 	} response;
-	u32 status;
+	int status;
 	struct dentry *dentry;
 };
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index a60db5e795a4..1061991434b1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -777,6 +777,13 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		!is_inode_flag_set(inode, FI_DIRTY_INODE))
 		return 0;
 
+	/*
+	 * no need to update inode page, ultimately f2fs_evict_inode() will
+	 * clear dirty status of inode.
+	 */
+	if (f2fs_cp_error(sbi))
+		return -EIO;
+
 	if (!f2fs_is_checkpoint_ready(sbi)) {
 		f2fs_mark_inode_dirty_sync(inode, true);
 		return -ENOSPC;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 51b2b8c5c749..0c004dd5595b 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -562,13 +562,16 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 			unsigned int node_blocks, unsigned int data_blocks,
 			unsigned int dent_blocks)
 {
-
 	unsigned int segno, left_blocks, blocks;
 	int i;
 
 	/* check current data/node sections in the worst case. */
 	for (i = CURSEG_HOT_DATA; i < NR_PERSISTENT_LOG; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
+
+		if (unlikely(segno == NULL_SEGNO))
+			return false;
+
 		left_blocks = CAP_BLKS_PER_SEC(sbi) -
 				get_ckpt_valid_blocks(sbi, segno, true);
 
@@ -579,6 +582,10 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 
 	/* check current data section for dentry blocks. */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
+
+	if (unlikely(segno == NULL_SEGNO))
+		return false;
+
 	left_blocks = CAP_BLKS_PER_SEC(sbi) -
 			get_ckpt_valid_blocks(sbi, segno, true);
 	if (dent_blocks > left_blocks)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e773b0adcfc0..2dc5cfecb016 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6699,7 +6699,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
 					  min((size_t)trace_seq_used(&iter->seq),
-						  PAGE_SIZE));
+						  (size_t)PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;

