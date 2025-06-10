Return-Path: <stable+bounces-152283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F8AD352D
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E40188DF3E
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5659928E569;
	Tue, 10 Jun 2025 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WOrsyhdp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F137928D82D;
	Tue, 10 Jun 2025 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555690; cv=none; b=GYM4rltSTvvFnYw0WxNBiTv8Ud6NVVyWup+A6vDt6HaNqrUSCgi9NRqt56nl12dJcuD1RAECiTwvpj7buNwToPB4kTmE9E7CIOOoX5xkP/9pxx/yUJ1/4EpHoSX480MIaQzlTcWCORC5RvpgesjZbCL0ARABPIObeVSL7X4diZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555690; c=relaxed/simple;
	bh=oRCN3S4FKVjIosj91x0Dsh98YzzB3G7I0rRD1Eer2GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnt70C96jLg6fzmO/9GQQCxv2gsjBYYZGC8nEFFOZGdvSY/uuIdQkx9zisRyNA52lRbPvEgMBivJn8H+wnAzwZBm2RAhfkvHViwFzcZPDr6YRhgE1VgLsoks4i6geCvbsw7oQD1KM9Q7IOzbnjCy0TDaJjO69hW+CtqKrUOxi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WOrsyhdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40289C4CEED;
	Tue, 10 Jun 2025 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749555689;
	bh=oRCN3S4FKVjIosj91x0Dsh98YzzB3G7I0rRD1Eer2GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOrsyhdpsTx8LFsdXKFsoRzFTVEUd5hkwD2knJ3Sc+t+8zVv5KWl+QpYSia/FEMle
	 ck/Kyv44JvFChQpTmhz68C50u2VMb83VSly1DDNXj6XO4G5BRZItIimZRmQfbg2nhn
	 BjUKwJT67jcIV+ZzMyi9GlY/jxBZMKFu58X82p0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.15.2
Date: Tue, 10 Jun 2025 07:41:19 -0400
Message-ID: <2025061019-shaky-doorknob-fd18@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025061018-coauthor-casualty-2986@gregkh>
References: <2025061018-coauthor-casualty-2986@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
index daee0c0fc915..c468207eb951 100644
--- a/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
@@ -63,8 +63,7 @@ properties:
   fsl,phy-tx-vboost-level-microvolt:
     description:
       Adjust the boosted transmit launch pk-pk differential amplitude
-    minimum: 880
-    maximum: 1120
+    enum: [844, 1008, 1156]
 
   fsl,phy-comp-dis-tune-percent:
     description:
diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index 45e112d0efb4..5575c58357d6 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -30,11 +30,19 @@ properties:
     const: 3
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: axi
+      - const: ext
 
 required:
   - reg
   - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -43,6 +51,7 @@ examples:
     pwm@44b00000 {
         compatible = "adi,axi-pwmgen-2.00.a";
         reg = <0x44b00000 0x1000>;
-        clocks = <&spi_clk>;
+        clocks = <&fpga_clk>, <&spi_clk>;
+        clock-names = "axi", "ext";
         #pwm-cells = <3>;
     };
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
index 56ff6386534d..5dcc2a32c080 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
@@ -16,6 +16,9 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,sc8180x-adsp-pas
+      - qcom,sc8180x-cdsp-pas
+      - qcom,sc8180x-slpi-pas
       - qcom,sm8150-adsp-pas
       - qcom,sm8150-cdsp-pas
       - qcom,sm8150-mpss-pas
diff --git a/Documentation/devicetree/bindings/usb/cypress,hx3.yaml b/Documentation/devicetree/bindings/usb/cypress,hx3.yaml
index 1033b7a4b8f9..d6eac1213228 100644
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
index 61d69a3fc827..7138d1fabfa4 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 15
-SUBLEVEL = 1
+SUBLEVEL = 2
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d6cf1e23c2a3..96355ab9aed9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1238,10 +1238,6 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
-/*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
 void __noreturn mwait_play_dead(unsigned int eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
@@ -1287,6 +1283,50 @@ void __noreturn mwait_play_dead(unsigned int eax_hint)
 	}
 }
 
+/*
+ * We need to flush the caches before going to sleep, lest we have
+ * dirty data in our caches when we come back up.
+ */
+static inline void mwait_play_dead_cpuid_hint(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+	unsigned int highest_cstate = 0;
+	unsigned int highest_subcstate = 0;
+	int i;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		return;
+	if (!this_cpu_has(X86_FEATURE_MWAIT))
+		return;
+	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
+		return;
+
+	eax = CPUID_LEAF_MWAIT;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	/*
+	 * eax will be 0 if EDX enumeration is not valid.
+	 * Initialized below to cstate, sub_cstate value when EDX is valid.
+	 */
+	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
+		eax = 0;
+	} else {
+		edx >>= MWAIT_SUBSTATE_SIZE;
+		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
+			if (edx & MWAIT_SUBSTATE_MASK) {
+				highest_cstate = i;
+				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
+			}
+		}
+		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
+			(highest_subcstate - 1);
+	}
+
+	mwait_play_dead(eax);
+}
+
 /*
  * Kick all "offline" CPUs out of mwait on kexec(). See comment in
  * mwait_play_dead().
@@ -1337,9 +1377,9 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	/* Below returns only on error. */
-	cpuidle_play_dead();
-	hlt_play_dead();
+	mwait_play_dead_cpuid_hint();
+	if (cpuidle_play_dead())
+		hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 911875c5a5f1..58842130ca47 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -37,7 +37,7 @@ struct acpi_db_argument_info {
 struct acpi_db_execute_walk {
 	u32 count;
 	u32 max_count;
-	char name_seg[ACPI_NAMESEG_SIZE + 1];
+	char name_seg[ACPI_NAMESEG_SIZE + 1] ACPI_NONSTRING;
 };
 
 #define PARAM_LIST(pl)                  pl
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 6481c48c22bb..b40e9a520618 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -293,7 +293,7 @@ acpi_status (*acpi_internal_method) (struct acpi_walk_state * walk_state);
  * expected_return_btypes - Allowed type(s) for the return value
  */
 struct acpi_name_info {
-	char name[ACPI_NAMESEG_SIZE] __nonstring;
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	u16 argument_list;
 	u8 expected_btypes;
 };
@@ -370,7 +370,7 @@ typedef acpi_status (*acpi_object_converter) (struct acpi_namespace_node *
 					      converted_object);
 
 struct acpi_simple_repair_info {
-	char name[ACPI_NAMESEG_SIZE] __nonstring;
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	u32 unexpected_btypes;
 	u32 package_index;
 	acpi_object_converter object_converter;
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index d91153f65700..22aeeeb56cff 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -194,7 +194,7 @@ acpi_ns_build_normalized_path(struct acpi_namespace_node *node,
 			      char *full_path, u32 path_size, u8 no_trailing)
 {
 	u32 length = 0, i;
-	char name[ACPI_NAMESEG_SIZE];
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	u8 do_no_trailing;
 	char c, *left, *right;
 	struct acpi_namespace_node *next_node;
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 330b5e4711da..0075fc80d498 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -25,7 +25,7 @@ acpi_status (*acpi_repair_function) (struct acpi_evaluate_info * info,
 				     return_object_ptr);
 
 typedef struct acpi_repair_info {
-	char name[ACPI_NAMESEG_SIZE] __nonstring;
+	char name[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 	acpi_repair_function repair_function;
 
 } acpi_repair_info;
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 5fc2c8ee61b1..6be0f7ac7213 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -79,6 +79,8 @@ static HLIST_HEAD(binder_deferred_list);
 static DEFINE_MUTEX(binder_deferred_lock);
 
 static HLIST_HEAD(binder_devices);
+static DEFINE_SPINLOCK(binder_devices_lock);
+
 static HLIST_HEAD(binder_procs);
 static DEFINE_MUTEX(binder_procs_lock);
 
@@ -5244,6 +5246,7 @@ static void binder_free_proc(struct binder_proc *proc)
 			__func__, proc->outstanding_txns);
 	device = container_of(proc->context, struct binder_device, context);
 	if (refcount_dec_and_test(&device->ref)) {
+		binder_remove_device(device);
 		kfree(proc->context->name);
 		kfree(device);
 	}
@@ -6929,7 +6932,16 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
 
 void binder_add_device(struct binder_device *device)
 {
+	spin_lock(&binder_devices_lock);
 	hlist_add_head(&device->hlist, &binder_devices);
+	spin_unlock(&binder_devices_lock);
+}
+
+void binder_remove_device(struct binder_device *device)
+{
+	spin_lock(&binder_devices_lock);
+	hlist_del_init(&device->hlist);
+	spin_unlock(&binder_devices_lock);
 }
 
 static int __init init_binder_device(const char *name)
@@ -6956,7 +6968,7 @@ static int __init init_binder_device(const char *name)
 		return ret;
 	}
 
-	hlist_add_head(&binder_device->hlist, &binder_devices);
+	binder_add_device(binder_device);
 
 	return ret;
 }
@@ -7018,7 +7030,7 @@ static int __init binder_init(void)
 err_init_binder_device_failed:
 	hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
 		misc_deregister(&device->miscdev);
-		hlist_del(&device->hlist);
+		binder_remove_device(device);
 		kfree(device);
 	}
 
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 6a66c9769c6c..1ba5caf1d88d 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -583,9 +583,13 @@ struct binder_object {
 /**
  * Add a binder device to binder_devices
  * @device: the new binder device to add to the global list
- *
- * Not reentrant as the list is not protected by any locks
  */
 void binder_add_device(struct binder_device *device);
 
+/**
+ * Remove a binder device to binder_devices
+ * @device: the binder device to remove from the global list
+ */
+void binder_remove_device(struct binder_device *device);
+
 #endif /* _LINUX_BINDER_INTERNAL_H */
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 94c6446604fc..44d430c4ebef 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -274,7 +274,7 @@ static void binderfs_evict_inode(struct inode *inode)
 	mutex_unlock(&binderfs_minors_mutex);
 
 	if (refcount_dec_and_test(&device->ref)) {
-		hlist_del_init(&device->hlist);
+		binder_remove_device(device);
 		kfree(device->context.name);
 		kfree(device);
 	}
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e00590ba24fd..a2dc39c005f4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2415,14 +2415,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
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
diff --git a/drivers/clk/samsung/clk-exynosautov920.c b/drivers/clk/samsung/clk-exynosautov920.c
index dc8d4240f6de..b0561faecfeb 100644
--- a/drivers/clk/samsung/clk-exynosautov920.c
+++ b/drivers/clk/samsung/clk-exynosautov920.c
@@ -1393,7 +1393,7 @@ static const unsigned long hsi1_clk_regs[] __initconst = {
 /* List of parent clocks for Muxes in CMU_HSI1 */
 PNAME(mout_hsi1_mmc_card_user_p) = {"oscclk", "dout_clkcmu_hsi1_mmc_card"};
 PNAME(mout_hsi1_noc_user_p) = { "oscclk", "dout_clkcmu_hsi1_noc" };
-PNAME(mout_hsi1_usbdrd_user_p) = { "oscclk", "mout_clkcmu_hsi1_usbdrd" };
+PNAME(mout_hsi1_usbdrd_user_p) = { "oscclk", "dout_clkcmu_hsi1_usbdrd" };
 PNAME(mout_hsi1_usbdrd_p) = { "dout_tcxo_div2", "mout_hsi1_usbdrd_user" };
 
 static const struct samsung_mux_clock hsi1_mux_clks[] __initconst = {
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d26b610e4f24..76768fe213a9 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -660,7 +660,7 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	nominal_perf = perf_caps.nominal_perf;
 
 	if (nominal_freq)
-		*nominal_freq = perf_caps.nominal_freq;
+		*nominal_freq = perf_caps.nominal_freq * 1000;
 
 	if (!highest_perf || !nominal_perf) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a187cdb43e7e..0fe8bd19ecd1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -675,21 +675,15 @@ static void dm_crtc_high_irq(void *interrupt_params)
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
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8671b7c974b9..eceb3cdb421f 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -260,6 +260,7 @@ config NVMEM_RCAR_EFUSE
 config NVMEM_RMEM
 	tristate "Reserved Memory Based Driver Support"
 	depends on HAS_IOMEM
+	select CRC32
 	help
 	  This driver maps reserved memory into an nvmem device. It might be
 	  useful to expose information left by firmware in memory.
diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index b4eb2beab691..c516c34aaaf6 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -22,7 +22,6 @@
 #include <linux/platform_device.h>
 
 #include "mtk-eint.h"
-#include "pinctrl-mtk-common-v2.h"
 
 #define MTK_EINT_EDGE_SENSITIVE           0
 #define MTK_EINT_LEVEL_SENSITIVE          1
@@ -505,10 +504,9 @@ int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
 }
 EXPORT_SYMBOL_GPL(mtk_eint_find_irq);
 
-int mtk_eint_do_init(struct mtk_eint *eint)
+int mtk_eint_do_init(struct mtk_eint *eint, struct mtk_eint_pin *eint_pin)
 {
 	unsigned int size, i, port, inst = 0;
-	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)eint->pctl;
 
 	/* If clients don't assign a specific regs, let's use generic one */
 	if (!eint->regs)
@@ -519,7 +517,15 @@ int mtk_eint_do_init(struct mtk_eint *eint)
 	if (!eint->base_pin_num)
 		return -ENOMEM;
 
-	if (eint->nbase == 1) {
+	if (eint_pin) {
+		eint->pins = eint_pin;
+		for (i = 0; i < eint->hw->ap_num; i++) {
+			inst = eint->pins[i].instance;
+			if (inst >= eint->nbase)
+				continue;
+			eint->base_pin_num[inst]++;
+		}
+	} else {
 		size = eint->hw->ap_num * sizeof(struct mtk_eint_pin);
 		eint->pins = devm_kmalloc(eint->dev, size, GFP_KERNEL);
 		if (!eint->pins)
@@ -533,16 +539,6 @@ int mtk_eint_do_init(struct mtk_eint *eint)
 		}
 	}
 
-	if (hw && hw->soc && hw->soc->eint_pin) {
-		eint->pins = hw->soc->eint_pin;
-		for (i = 0; i < eint->hw->ap_num; i++) {
-			inst = eint->pins[i].instance;
-			if (inst >= eint->nbase)
-				continue;
-			eint->base_pin_num[inst]++;
-		}
-	}
-
 	eint->pin_list = devm_kmalloc(eint->dev, eint->nbase * sizeof(u16 *), GFP_KERNEL);
 	if (!eint->pin_list)
 		goto err_pin_list;
@@ -610,7 +606,7 @@ int mtk_eint_do_init(struct mtk_eint *eint)
 err_wake_mask:
 	devm_kfree(eint->dev, eint->pin_list);
 err_pin_list:
-	if (eint->nbase == 1)
+	if (!eint_pin)
 		devm_kfree(eint->dev, eint->pins);
 err_pins:
 	devm_kfree(eint->dev, eint->base_pin_num);
diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
index f7f58cca0d5e..23801d4b636f 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.h
+++ b/drivers/pinctrl/mediatek/mtk-eint.h
@@ -88,7 +88,7 @@ struct mtk_eint {
 };
 
 #if IS_ENABLED(CONFIG_EINT_MTK)
-int mtk_eint_do_init(struct mtk_eint *eint);
+int mtk_eint_do_init(struct mtk_eint *eint, struct mtk_eint_pin *eint_pin);
 int mtk_eint_do_suspend(struct mtk_eint *eint);
 int mtk_eint_do_resume(struct mtk_eint *eint);
 int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
@@ -96,7 +96,8 @@ int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
 int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n);
 
 #else
-static inline int mtk_eint_do_init(struct mtk_eint *eint)
+static inline int mtk_eint_do_init(struct mtk_eint *eint,
+				   struct mtk_eint_pin *eint_pin)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index d1556b75d9ef..ba13558bfcd7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -416,7 +416,7 @@ int mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
 	hw->eint->pctl = hw;
 	hw->eint->gpio_xlate = &mtk_eint_xt;
 
-	ret = mtk_eint_do_init(hw->eint);
+	ret = mtk_eint_do_init(hw->eint, hw->soc->eint_pin);
 	if (ret)
 		goto err_free_eint;
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 8596f3541265..7289648eaa02 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1039,7 +1039,7 @@ static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
 	pctl->eint->pctl = pctl;
 	pctl->eint->gpio_xlate = &mtk_eint_xt;
 
-	return mtk_eint_do_init(pctl->eint);
+	return mtk_eint_do_init(pctl->eint, NULL);
 }
 
 /* This is used as a common probe function */
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 335744ac8310..79f9c08e5039 100644
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
index b88cd4fb295b..b1a2be1f9e3b 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -326,7 +326,7 @@ static void rtc_device_get_offset(struct rtc_device *rtc)
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
index cd15e84c47f4..1db2e951b53f 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -151,6 +151,11 @@ static void tb_cfg_request_dequeue(struct tb_cfg_request *req)
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
index 36d3df7d040c..53d68d20fb62 100644
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
index 010688dd9e49..22579d0d8ab8 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -458,6 +458,8 @@ static int pl2303_detect_type(struct usb_serial *serial)
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
index 9c5278a0c5d4..70910232a05d 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -434,7 +434,7 @@ struct ucsi_debugfs_entry {
 		u64 low;
 		u64 high;
 	} response;
-	u32 status;
+	int status;
 	struct dentry *dentry;
 };
 
diff --git a/fs/bcachefs/dirent.c b/fs/bcachefs/dirent.c
index a51195088227..901230ca4a75 100644
--- a/fs/bcachefs/dirent.c
+++ b/fs/bcachefs/dirent.c
@@ -395,8 +395,8 @@ int bch2_dirent_read_target(struct btree_trans *trans, subvol_inum dir,
 }
 
 int bch2_dirent_rename(struct btree_trans *trans,
-		subvol_inum src_dir, struct bch_hash_info *src_hash, u64 *src_dir_i_size,
-		subvol_inum dst_dir, struct bch_hash_info *dst_hash, u64 *dst_dir_i_size,
+		subvol_inum src_dir, struct bch_hash_info *src_hash,
+		subvol_inum dst_dir, struct bch_hash_info *dst_hash,
 		const struct qstr *src_name, subvol_inum *src_inum, u64 *src_offset,
 		const struct qstr *dst_name, subvol_inum *dst_inum, u64 *dst_offset,
 		enum bch_rename_mode mode)
@@ -535,14 +535,6 @@ int bch2_dirent_rename(struct btree_trans *trans,
 	    new_src->v.d_type == DT_SUBVOL)
 		new_src->v.d_parent_subvol = cpu_to_le32(src_dir.subvol);
 
-	if (old_dst.k)
-		*dst_dir_i_size -= bkey_bytes(old_dst.k);
-	*src_dir_i_size -= bkey_bytes(old_src.k);
-
-	if (mode == BCH_RENAME_EXCHANGE)
-		*src_dir_i_size += bkey_bytes(&new_src->k);
-	*dst_dir_i_size += bkey_bytes(&new_dst->k);
-
 	ret = bch2_trans_update(trans, &dst_iter, &new_dst->k_i, 0);
 	if (ret)
 		goto out;
diff --git a/fs/bcachefs/dirent.h b/fs/bcachefs/dirent.h
index d3e7ae669575..999b895fa28a 100644
--- a/fs/bcachefs/dirent.h
+++ b/fs/bcachefs/dirent.h
@@ -80,8 +80,8 @@ enum bch_rename_mode {
 };
 
 int bch2_dirent_rename(struct btree_trans *,
-		       subvol_inum, struct bch_hash_info *, u64 *,
-		       subvol_inum, struct bch_hash_info *, u64 *,
+		       subvol_inum, struct bch_hash_info *,
+		       subvol_inum, struct bch_hash_info *,
 		       const struct qstr *, subvol_inum *, u64 *,
 		       const struct qstr *, subvol_inum *, u64 *,
 		       enum bch_rename_mode);
diff --git a/fs/bcachefs/errcode.h b/fs/bcachefs/errcode.h
index d9ebffa5b3a2..346766299cb3 100644
--- a/fs/bcachefs/errcode.h
+++ b/fs/bcachefs/errcode.h
@@ -209,6 +209,8 @@
 	x(EINVAL,			remove_would_lose_data)			\
 	x(EINVAL,			no_resize_with_buckets_nouse)		\
 	x(EINVAL,			inode_unpack_error)			\
+	x(EINVAL,			inode_not_unlinked)			\
+	x(EINVAL,			inode_has_child_snapshot)		\
 	x(EINVAL,			varint_decode_error)			\
 	x(EINVAL,			erasure_coding_found_btree_node)	\
 	x(EOPNOTSUPP,			may_not_use_incompat_feature)		\
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 47f1a64c5c8d..8a47ce3467e8 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -2181,7 +2181,13 @@ static void bch2_evict_inode(struct inode *vinode)
 				KEY_TYPE_QUOTA_WARN);
 		bch2_quota_acct(c, inode->ei_qid, Q_INO, -1,
 				KEY_TYPE_QUOTA_WARN);
-		bch2_inode_rm(c, inode_inum(inode));
+		int ret = bch2_inode_rm(c, inode_inum(inode));
+		if (ret && !bch2_err_matches(ret, EROFS)) {
+			bch_err_msg(c, ret, "VFS incorrectly tried to delete inode %llu:%llu",
+				    inode->ei_inum.subvol,
+				    inode->ei_inum.inum);
+			bch2_sb_error_count(c, BCH_FSCK_ERR_vfs_bad_inode_rm);
+		}
 
 		/*
 		 * If we are deleting, we need it present in the vfs hash table
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index aaf187085276..bf117f2225d8 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -1183,6 +1183,14 @@ static int check_inode(struct btree_trans *trans,
 		ret = 0;
 	}
 
+	if (fsck_err_on(S_ISDIR(u.bi_mode) && u.bi_size,
+			trans, inode_dir_has_nonzero_i_size,
+			"directory %llu:%u with nonzero i_size %lli",
+			u.bi_inum, u.bi_snapshot, u.bi_size)) {
+		u.bi_size = 0;
+		do_update = true;
+	}
+
 	ret = bch2_inode_has_child_snapshots(trans, k.k->p);
 	if (ret < 0)
 		goto err;
diff --git a/fs/bcachefs/inode.c b/fs/bcachefs/inode.c
index 490b85841de9..845efd429d13 100644
--- a/fs/bcachefs/inode.c
+++ b/fs/bcachefs/inode.c
@@ -38,6 +38,7 @@ static const char * const bch2_inode_flag_strs[] = {
 #undef  x
 
 static int delete_ancestor_snapshot_inodes(struct btree_trans *, struct bpos);
+static int may_delete_deleted_inum(struct btree_trans *, subvol_inum);
 
 static const u8 byte_table[8] = { 1, 2, 3, 4, 6, 8, 10, 13 };
 
@@ -1048,19 +1049,23 @@ int bch2_inode_rm(struct bch_fs *c, subvol_inum inum)
 	u32 snapshot;
 	int ret;
 
+	ret = lockrestart_do(trans, may_delete_deleted_inum(trans, inum));
+	if (ret)
+		goto err2;
+
 	/*
 	 * If this was a directory, there shouldn't be any real dirents left -
 	 * but there could be whiteouts (from hash collisions) that we should
 	 * delete:
 	 *
-	 * XXX: the dirent could ideally would delete whiteouts when they're no
+	 * XXX: the dirent code ideally would delete whiteouts when they're no
 	 * longer needed
 	 */
 	ret   = bch2_inode_delete_keys(trans, inum, BTREE_ID_extents) ?:
 		bch2_inode_delete_keys(trans, inum, BTREE_ID_xattrs) ?:
 		bch2_inode_delete_keys(trans, inum, BTREE_ID_dirents);
 	if (ret)
-		goto err;
+		goto err2;
 retry:
 	bch2_trans_begin(trans);
 
@@ -1342,10 +1347,8 @@ int bch2_inode_rm_snapshot(struct btree_trans *trans, u64 inum, u32 snapshot)
 		delete_ancestor_snapshot_inodes(trans, SPOS(0, inum, snapshot));
 }
 
-static int may_delete_deleted_inode(struct btree_trans *trans,
-				    struct btree_iter *iter,
-				    struct bpos pos,
-				    bool *need_another_pass)
+static int may_delete_deleted_inode(struct btree_trans *trans, struct bpos pos,
+				    bool from_deleted_inodes)
 {
 	struct bch_fs *c = trans->c;
 	struct btree_iter inode_iter;
@@ -1360,11 +1363,13 @@ static int may_delete_deleted_inode(struct btree_trans *trans,
 		return ret;
 
 	ret = bkey_is_inode(k.k) ? 0 : -BCH_ERR_ENOENT_inode;
-	if (fsck_err_on(!bkey_is_inode(k.k),
+	if (fsck_err_on(from_deleted_inodes && ret,
 			trans, deleted_inode_missing,
 			"nonexistent inode %llu:%u in deleted_inodes btree",
 			pos.offset, pos.snapshot))
 		goto delete;
+	if (ret)
+		goto out;
 
 	ret = bch2_inode_unpack(k, &inode);
 	if (ret)
@@ -1372,7 +1377,8 @@ static int may_delete_deleted_inode(struct btree_trans *trans,
 
 	if (S_ISDIR(inode.bi_mode)) {
 		ret = bch2_empty_dir_snapshot(trans, pos.offset, 0, pos.snapshot);
-		if (fsck_err_on(bch2_err_matches(ret, ENOTEMPTY),
+		if (fsck_err_on(from_deleted_inodes &&
+				bch2_err_matches(ret, ENOTEMPTY),
 				trans, deleted_inode_is_dir,
 				"non empty directory %llu:%u in deleted_inodes btree",
 				pos.offset, pos.snapshot))
@@ -1381,17 +1387,25 @@ static int may_delete_deleted_inode(struct btree_trans *trans,
 			goto out;
 	}
 
-	if (fsck_err_on(!(inode.bi_flags & BCH_INODE_unlinked),
+	ret = inode.bi_flags & BCH_INODE_unlinked ? 0 : -BCH_ERR_inode_not_unlinked;
+	if (fsck_err_on(from_deleted_inodes && ret,
 			trans, deleted_inode_not_unlinked,
 			"non-deleted inode %llu:%u in deleted_inodes btree",
 			pos.offset, pos.snapshot))
 		goto delete;
+	if (ret)
+		goto out;
+
+	ret = !(inode.bi_flags & BCH_INODE_has_child_snapshot)
+		? 0 : -BCH_ERR_inode_has_child_snapshot;
 
-	if (fsck_err_on(inode.bi_flags & BCH_INODE_has_child_snapshot,
+	if (fsck_err_on(from_deleted_inodes && ret,
 			trans, deleted_inode_has_child_snapshots,
 			"inode with child snapshots %llu:%u in deleted_inodes btree",
 			pos.offset, pos.snapshot))
 		goto delete;
+	if (ret)
+		goto out;
 
 	ret = bch2_inode_has_child_snapshots(trans, k.k->p);
 	if (ret < 0)
@@ -1408,19 +1422,28 @@ static int may_delete_deleted_inode(struct btree_trans *trans,
 			if (ret)
 				goto out;
 		}
+
+		if (!from_deleted_inodes) {
+			ret =   bch2_trans_commit(trans, NULL, NULL, BCH_TRANS_COMMIT_no_enospc) ?:
+				-BCH_ERR_inode_has_child_snapshot;
+			goto out;
+		}
+
 		goto delete;
 
 	}
 
-	if (test_bit(BCH_FS_clean_recovery, &c->flags) &&
-	    !fsck_err(trans, deleted_inode_but_clean,
-		      "filesystem marked as clean but have deleted inode %llu:%u",
-		      pos.offset, pos.snapshot)) {
-		ret = 0;
-		goto out;
-	}
+	if (from_deleted_inodes) {
+		if (test_bit(BCH_FS_clean_recovery, &c->flags) &&
+		    !fsck_err(trans, deleted_inode_but_clean,
+			      "filesystem marked as clean but have deleted inode %llu:%u",
+			      pos.offset, pos.snapshot)) {
+			ret = 0;
+			goto out;
+		}
 
-	ret = 1;
+		ret = 1;
+	}
 out:
 fsck_err:
 	bch2_trans_iter_exit(trans, &inode_iter);
@@ -1431,12 +1454,19 @@ static int may_delete_deleted_inode(struct btree_trans *trans,
 	goto out;
 }
 
+static int may_delete_deleted_inum(struct btree_trans *trans, subvol_inum inum)
+{
+	u32 snapshot;
+
+	return bch2_subvolume_get_snapshot(trans, inum.subvol, &snapshot) ?:
+		may_delete_deleted_inode(trans, SPOS(0, inum.inum, snapshot), false);
+}
+
 int bch2_delete_dead_inodes(struct bch_fs *c)
 {
 	struct btree_trans *trans = bch2_trans_get(c);
-	bool need_another_pass;
 	int ret;
-again:
+
 	/*
 	 * if we ran check_inodes() unlinked inodes will have already been
 	 * cleaned up but the write buffer will be out of sync; therefore we
@@ -1446,8 +1476,6 @@ int bch2_delete_dead_inodes(struct bch_fs *c)
 	if (ret)
 		goto err;
 
-	need_another_pass = false;
-
 	/*
 	 * Weird transaction restart handling here because on successful delete,
 	 * bch2_inode_rm_snapshot() will return a nested transaction restart,
@@ -1457,7 +1485,7 @@ int bch2_delete_dead_inodes(struct bch_fs *c)
 	ret = for_each_btree_key_commit(trans, iter, BTREE_ID_deleted_inodes, POS_MIN,
 					BTREE_ITER_prefetch|BTREE_ITER_all_snapshots, k,
 					NULL, NULL, BCH_TRANS_COMMIT_no_enospc, ({
-		ret = may_delete_deleted_inode(trans, &iter, k.k->p, &need_another_pass);
+		ret = may_delete_deleted_inode(trans, k.k->p, true);
 		if (ret > 0) {
 			bch_verbose_ratelimited(c, "deleting unlinked inode %llu:%u",
 						k.k->p.offset, k.k->p.snapshot);
@@ -1478,9 +1506,6 @@ int bch2_delete_dead_inodes(struct bch_fs *c)
 
 		ret;
 	}));
-
-	if (!ret && need_another_pass)
-		goto again;
 err:
 	bch2_trans_put(trans);
 	return ret;
diff --git a/fs/bcachefs/namei.c b/fs/bcachefs/namei.c
index 9136a9097789..413fb60cff43 100644
--- a/fs/bcachefs/namei.c
+++ b/fs/bcachefs/namei.c
@@ -418,8 +418,8 @@ int bch2_rename_trans(struct btree_trans *trans,
 	}
 
 	ret = bch2_dirent_rename(trans,
-				 src_dir, &src_hash, &src_dir_u->bi_size,
-				 dst_dir, &dst_hash, &dst_dir_u->bi_size,
+				 src_dir, &src_hash,
+				 dst_dir, &dst_hash,
 				 src_name, &src_inum, &src_offset,
 				 dst_name, &dst_inum, &dst_offset,
 				 mode);
diff --git a/fs/bcachefs/sb-errors_format.h b/fs/bcachefs/sb-errors_format.h
index 4036a20c6adc..9387f6092fe9 100644
--- a/fs/bcachefs/sb-errors_format.h
+++ b/fs/bcachefs/sb-errors_format.h
@@ -232,6 +232,7 @@ enum bch_fsck_flags {
 	x(inode_dir_multiple_links,				206,	FSCK_AUTOFIX)	\
 	x(inode_dir_missing_backpointer,			284,	FSCK_AUTOFIX)	\
 	x(inode_dir_unlinked_but_not_empty,			286,	FSCK_AUTOFIX)	\
+	x(inode_dir_has_nonzero_i_size,				319,	FSCK_AUTOFIX)	\
 	x(inode_multiple_links_but_nlink_0,			207,	FSCK_AUTOFIX)	\
 	x(inode_wrong_backpointer,				208,	FSCK_AUTOFIX)	\
 	x(inode_wrong_nlink,					209,	FSCK_AUTOFIX)	\
@@ -243,6 +244,7 @@ enum bch_fsck_flags {
 	x(inode_parent_has_case_insensitive_not_set,		317,	FSCK_AUTOFIX)	\
 	x(vfs_inode_i_blocks_underflow,				311,	FSCK_AUTOFIX)	\
 	x(vfs_inode_i_blocks_not_zero_at_truncate,		313,	FSCK_AUTOFIX)	\
+	x(vfs_bad_inode_rm,					320,	0)		\
 	x(deleted_inode_but_clean,				211,	FSCK_AUTOFIX)	\
 	x(deleted_inode_missing,				212,	FSCK_AUTOFIX)	\
 	x(deleted_inode_is_dir,					213,	FSCK_AUTOFIX)	\
@@ -328,7 +330,7 @@ enum bch_fsck_flags {
 	x(dirent_stray_data_after_cf_name,			305,	0)		\
 	x(rebalance_work_incorrectly_set,			309,	FSCK_AUTOFIX)	\
 	x(rebalance_work_incorrectly_unset,			310,	FSCK_AUTOFIX)	\
-	x(MAX,							319,	0)
+	x(MAX,							321,	0)
 
 enum bch_sb_error_id {
 #define x(t, n, ...) BCH_FSCK_ERR_##t = n,
diff --git a/fs/bcachefs/subvolume.c b/fs/bcachefs/subvolume.c
index d0209f7658bb..bc6009a71284 100644
--- a/fs/bcachefs/subvolume.c
+++ b/fs/bcachefs/subvolume.c
@@ -6,6 +6,7 @@
 #include "errcode.h"
 #include "error.h"
 #include "fs.h"
+#include "inode.h"
 #include "recovery_passes.h"
 #include "snapshot.h"
 #include "subvolume.h"
@@ -113,10 +114,20 @@ static int check_subvol(struct btree_trans *trans,
 			     "subvolume %llu points to missing subvolume root %llu:%u",
 			     k.k->p.offset, le64_to_cpu(subvol.v->inode),
 			     le32_to_cpu(subvol.v->snapshot))) {
-			ret = bch2_subvolume_delete(trans, iter->pos.offset);
-			bch_err_msg(c, ret, "deleting subvolume %llu", iter->pos.offset);
-			ret = ret ?: -BCH_ERR_transaction_restart_nested;
-			goto err;
+			/*
+			 * Recreate - any contents that are still disconnected
+			 * will then get reattached under lost+found
+			 */
+			bch2_inode_init_early(c, &inode);
+			bch2_inode_init_late(&inode, bch2_current_time(c),
+					     0, 0, S_IFDIR|0700, 0, NULL);
+			inode.bi_inum			= le64_to_cpu(subvol.v->inode);
+			inode.bi_snapshot		= le32_to_cpu(subvol.v->snapshot);
+			inode.bi_subvol			= k.k->p.offset;
+			inode.bi_parent_subvol		= le32_to_cpu(subvol.v->fs_path_parent);
+			ret = __bch2_fsck_write_inode(trans, &inode);
+			if (ret)
+				goto err;
 		}
 	} else {
 		goto err;
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 2fc89704be17..74cc61e3ab09 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -66,12 +66,12 @@
  ******************************************************************************/
 
 struct acpi_table_header {
-	char signature[ACPI_NAMESEG_SIZE] __nonstring;	/* ASCII table signature */
+	char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;	/* ASCII table signature */
 	u32 length;		/* Length of table in bytes, including this header */
 	u8 revision;		/* ACPI Specification minor version number */
 	u8 checksum;		/* To make sum of entire table == 0 */
-	char oem_id[ACPI_OEM_ID_SIZE];	/* ASCII OEM identification */
-	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];	/* ASCII OEM table identification */
+	char oem_id[ACPI_OEM_ID_SIZE] ACPI_NONSTRING;	/* ASCII OEM identification */
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE] ACPI_NONSTRING;	/* ASCII OEM table identification */
 	u32 oem_revision;	/* OEM revision number */
 	char asl_compiler_id[ACPI_NAMESEG_SIZE];	/* ASCII ASL compiler vendor ID */
 	u32 asl_compiler_revision;	/* ASL compiler version */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 80767e8bf3ad..f7b3c4a4b7e7 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1327,4 +1327,8 @@ typedef enum {
 #define ACPI_FLEX_ARRAY(TYPE, NAME)     TYPE NAME[0]
 #endif
 
+#ifndef ACPI_NONSTRING
+#define ACPI_NONSTRING		/* No terminating NUL character */
+#endif
+
 #endif				/* __ACTYPES_H__ */
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 04b4bf620517..68e9379623e6 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -72,4 +72,12 @@
                 TYPE NAME[];                    \
         }
 
+/*
+ * Explicitly mark strings that lack a terminating NUL character so
+ * that ACPICA can be built with -Wunterminated-string-initialization.
+ */
+#if __has_attribute(__nonstring__)
+#define ACPI_NONSTRING __attribute__((__nonstring__))
+#endif
+
 #endif				/* __ACGCC_H__ */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5b8db27fb6ef..766cb3cd254e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6824,7 +6824,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
 					  min((size_t)trace_seq_used(&iter->seq),
-						  PAGE_SIZE));
+						  (size_t)PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 9d70d8c945af..987a5d32f3b6 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -19,7 +19,7 @@ ACPI_MODULE_NAME("oslinuxtbl")
 typedef struct osl_table_info {
 	struct osl_table_info *next;
 	u32 instance;
-	char signature[ACPI_NAMESEG_SIZE];
+	char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;
 
 } osl_table_info;
 
diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
index 13817f9112c0..9fc927fcc22a 100644
--- a/tools/power/acpi/tools/acpidump/apfiles.c
+++ b/tools/power/acpi/tools/acpidump/apfiles.c
@@ -103,7 +103,7 @@ int ap_open_output_file(char *pathname)
 
 int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
 {
-	char filename[ACPI_NAMESEG_SIZE + 16];
+	char filename[ACPI_NAMESEG_SIZE + 16] ACPI_NONSTRING;
 	char instance_str[16];
 	ACPI_FILE file;
 	acpi_size actual;

