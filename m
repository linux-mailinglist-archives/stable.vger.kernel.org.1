Return-Path: <stable+bounces-161596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F42B005AC
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E09760F66
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C927602D;
	Thu, 10 Jul 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IHv3Ciuh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987E6275AF2;
	Thu, 10 Jul 2025 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158875; cv=none; b=D+vKu32xoNt7sYzYgyW2sRkZ6P7CM+g4MZjBakOwmBwFN7AX4uNDyvzhx+ggn2o33HwfXlWK+P3/ZYnEvZZRBtmtQTQEOYF0AMT3YR31s+LrWfWhfSnYMBFMeQJiWC2VR2BtdEe2LY44m4L/hV+ptU7zXoYieBm8acDpo8ozwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158875; c=relaxed/simple;
	bh=6ZJvFC/Y5pQUcbgv4JESW0XZsmYdPeRVeOTGlvG6NpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tprN+R5SgiIC/1W594ZZAGdhzlL/kLWyiTmGiR9aW9mLMgYeQ9EHUGU/gPUbRkOYPyRjpKFxdF9I+KcQ/8fauwkQHpbc3E7NVtwuuO6QQE9T1Jv+m7qYHDpqVL7pF8wbAX4BoiDCo2pJ0INXcQOU8MWeNy/clxqjJQV+4qThgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IHv3Ciuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A062CC4CEF6;
	Thu, 10 Jul 2025 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752158874;
	bh=6ZJvFC/Y5pQUcbgv4JESW0XZsmYdPeRVeOTGlvG6NpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHv3CiuhZbFVv88AzLR0FoPmIP+ZCjOjllgWkYoAc0bM00Z7xFcDOaS4NL4Ww3E2l
	 gcZgJomDNEq1KySpX86kiN3T4kLMZHdRwjioTItvlHU+NuNAu5aT9VMHmebyYWsiGH
	 tJphC4cSYyhMRTrCUVeH+H8NsbVeF8Ikkba4Tldg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.37
Date: Thu, 10 Jul 2025 16:47:43 +0200
Message-ID: <2025071043-pointy-comfy-4b5a@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071043-grass-unknotted-2378@gregkh>
References: <2025071043-grass-unknotted-2378@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 6a1acabb29d8..53755b2021ed 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -523,6 +523,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
 		/sys/devices/system/cpu/vulnerabilities/spectre_v2
 		/sys/devices/system/cpu/vulnerabilities/srbds
+		/sys/devices/system/cpu/vulnerabilities/tsa
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 5fa6655aee84..16f17e91ee49 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -711,7 +711,7 @@ Description:	This file shows the thin provisioning type. This is one of
 
 		The file is read only.
 
-What:		/sys/class/scsi_device/*/device/unit_descriptor/physical_memory_resourse_count
+What:		/sys/class/scsi_device/*/device/unit_descriptor/physical_memory_resource_count
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the total physical memory resources. This is
diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
index 1302fd1b55e8..6dba18dbb9ab 100644
--- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
+++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
@@ -157,9 +157,7 @@ This is achieved by using the otherwise unused and obsolete VERW instruction in
 combination with a microcode update. The microcode clears the affected CPU
 buffers when the VERW instruction is executed.
 
-Kernel reuses the MDS function to invoke the buffer clearing:
-
-	mds_clear_cpu_buffers()
+Kernel does the buffer clearing with x86_clear_cpu_buffers().
 
 On MDS affected CPUs, the kernel already invokes CPU buffer clear on
 kernel/userspace, hypervisor/guest and C-state (idle) transitions. No
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5cb36148554..f402bbaccc8a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6993,6 +6993,19 @@
 			having this key zero'ed is acceptable. E.g. in testing
 			scenarios.
 
+	tsa=		[X86] Control mitigation for Transient Scheduler
+			Attacks on AMD CPUs. Search the following in your
+			favourite search engine for more details:
+
+			"Technical guidance for mitigating transient scheduler
+			attacks".
+
+			off		- disable the mitigation
+			on		- enable the mitigation (default)
+			user		- mitigate only user/kernel transitions
+			vm		- mitigate only guest/host transitions
+
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
diff --git a/Documentation/arch/x86/mds.rst b/Documentation/arch/x86/mds.rst
index 5a2e6c0ef04a..3518671e1a85 100644
--- a/Documentation/arch/x86/mds.rst
+++ b/Documentation/arch/x86/mds.rst
@@ -93,7 +93,7 @@ enters a C-state.
 
 The kernel provides a function to invoke the buffer clearing:
 
-    mds_clear_cpu_buffers()
+    x86_clear_cpu_buffers()
 
 Also macro CLEAR_CPU_BUFFERS can be used in ASM late in exit-to-user path.
 Other than CFLAGS.ZF, this macro doesn't clobber any registers.
@@ -185,9 +185,9 @@ Mitigation points
    idle clearing would be a window dressing exercise and is therefore not
    activated.
 
-   The invocation is controlled by the static key mds_idle_clear which is
-   switched depending on the chosen mitigation mode and the SMT state of
-   the system.
+   The invocation is controlled by the static key cpu_buf_idle_clear which is
+   switched depending on the chosen mitigation mode and the SMT state of the
+   system.
 
    The buffer clear is only invoked before entering the C-State to prevent
    that stale data from the idling CPU from spilling to the Hyper-Thread
diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index d1154eb43810..cca94469fa41 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -28,6 +28,9 @@ kernel. As of today, modules that make use of symbols exported into namespaces,
 are required to import the namespace. Otherwise the kernel will, depending on
 its configuration, reject loading the module or warn about a missing import.
 
+Additionally, it is possible to put symbols into a module namespace, strictly
+limiting which modules are allowed to use these symbols.
+
 2. How to define Symbol Namespaces
 ==================================
 
@@ -84,6 +87,22 @@ unit as preprocessor statement. The above example would then read::
 within the corresponding compilation unit before any EXPORT_SYMBOL macro is
 used.
 
+2.3 Using the EXPORT_SYMBOL_GPL_FOR_MODULES() macro
+===================================================
+
+Symbols exported using this macro are put into a module namespace. This
+namespace cannot be imported.
+
+The macro takes a comma separated list of module names, allowing only those
+modules to access this symbol. Simple tail-globs are supported.
+
+For example:
+
+  EXPORT_SYMBOL_GPL_FOR_MODULES(preempt_notifier_inc, "kvm,kvm-*")
+
+will limit usage of this symbol to modules whoes name matches the given
+patterns.
+
 3. How to use Symbols exported in Namespaces
 ============================================
 
@@ -155,3 +174,6 @@ in-tree modules::
 You can also run nsdeps for external module builds. A typical usage is::
 
 	$ make -C <path_to_kernel_src> M=$PWD nsdeps
+
+Note: it will happily generate an import statement for the module namespace;
+which will not work and generates build and runtime failures.
diff --git a/Makefile b/Makefile
index 7012820523ff..ca3225cbf130 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 36
+SUBLEVEL = 37
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
index 5988a4eb6efa..cb78ce7af0b3 100644
--- a/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
@@ -71,7 +71,7 @@ hpm1: usb-pd@3f {
  */
 &port00 {
 	bus-range = <1 1>;
-	wifi0: network@0,0 {
+	wifi0: wifi@0,0 {
 		compatible = "pci14e4,4425";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index edde21972f5a..bd91624bd3bf 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -68,18 +68,18 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a520";
 			reg = <0 0>;
 
 			clocks = <&cpufreq_hw 0>;
 
-			power-domains = <&CPU_PD0>;
+			power-domains = <&cpu_pd0>;
 			power-domain-names = "psci";
 
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 
@@ -87,13 +87,13 @@ CPU0: cpu@0 {
 
 			#cooling-cells = <2>;
 
-			L2_0: l2-cache {
+			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 
-				L3_0: l3-cache {
+				l3_0: l3-cache {
 					compatible = "cache";
 					cache-level = <3>;
 					cache-unified;
@@ -101,18 +101,18 @@ L3_0: l3-cache {
 			};
 		};
 
-		CPU1: cpu@100 {
+		cpu1: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a520";
 			reg = <0 0x100>;
 
 			clocks = <&cpufreq_hw 0>;
 
-			power-domains = <&CPU_PD1>;
+			power-domains = <&cpu_pd1>;
 			power-domain-names = "psci";
 
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 
@@ -121,18 +121,18 @@ CPU1: cpu@100 {
 			#cooling-cells = <2>;
 		};
 
-		CPU2: cpu@200 {
+		cpu2: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a720";
 			reg = <0 0x200>;
 
 			clocks = <&cpufreq_hw 3>;
 
-			power-domains = <&CPU_PD2>;
+			power-domains = <&cpu_pd2>;
 			power-domain-names = "psci";
 
 			enable-method = "psci";
-			next-level-cache = <&L2_200>;
+			next-level-cache = <&l2_200>;
 			capacity-dmips-mhz = <1792>;
 			dynamic-power-coefficient = <238>;
 
@@ -140,46 +140,53 @@ CPU2: cpu@200 {
 
 			#cooling-cells = <2>;
 
-			L2_200: l2-cache {
+			l2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU3: cpu@300 {
+		cpu3: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a720";
 			reg = <0 0x300>;
 
 			clocks = <&cpufreq_hw 3>;
 
-			power-domains = <&CPU_PD3>;
+			power-domains = <&cpu_pd3>;
 			power-domain-names = "psci";
 
 			enable-method = "psci";
-			next-level-cache = <&L2_200>;
+			next-level-cache = <&l2_300>;
 			capacity-dmips-mhz = <1792>;
 			dynamic-power-coefficient = <238>;
 
 			qcom,freq-domain = <&cpufreq_hw 3>;
 
 			#cooling-cells = <2>;
+
+			l2_300: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+				next-level-cache = <&l3_0>;
+			};
 		};
 
-		CPU4: cpu@400 {
+		cpu4: cpu@400 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a720";
 			reg = <0 0x400>;
 
 			clocks = <&cpufreq_hw 3>;
 
-			power-domains = <&CPU_PD4>;
+			power-domains = <&cpu_pd4>;
 			power-domain-names = "psci";
 
 			enable-method = "psci";
-			next-level-cache = <&L2_400>;
+			next-level-cache = <&l2_400>;
 			capacity-dmips-mhz = <1792>;
 			dynamic-power-coefficient = <238>;
 
@@ -187,26 +194,26 @@ CPU4: cpu@400 {
 
 			#cooling-cells = <2>;
 
-			L2_400: l2-cache {
+			l2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU5: cpu@500 {
+		cpu5: cpu@500 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a720";
 			reg = <0 0x500>;
 
 			clocks = <&cpufreq_hw 1>;
 
-			power-domains = <&CPU_PD5>;
+			power-domains = <&cpu_pd5>;
 			power-domain-names = "psci";
 
 			enable-method = "psci";
-			next-level-cache = <&L2_500>;
+			next-level-cache = <&l2_500>;
 			capacity-dmips-mhz = <1792>;
 			dynamic-power-coefficient = <238>;
 
@@ -214,26 +221,26 @@ CPU5: cpu@500 {
 
 			#cooling-cells = <2>;
 
-			L2_500: l2-cache {
+			l2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU6: cpu@600 {
+		cpu6: cpu@600 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a720";
 			reg = <0 0x600>;
 
 			clocks = <&cpufreq_hw 1>;
 
-			power-domains = <&CPU_PD6>;
+			power-domains = <&cpu_pd6>;
 			power-domain-names = "psci";
 
 			enable-method = "psci";
-			next-level-cache = <&L2_600>;
+			next-level-cache = <&l2_600>;
 			capacity-dmips-mhz = <1792>;
 			dynamic-power-coefficient = <238>;
 
@@ -241,26 +248,26 @@ CPU6: cpu@600 {
 
 			#cooling-cells = <2>;
 
-			L2_600: l2-cache {
+			l2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
-		CPU7: cpu@700 {
+		cpu7: cpu@700 {
 			device_type = "cpu";
 			compatible = "arm,cortex-x4";
 			reg = <0 0x700>;
 
 			clocks = <&cpufreq_hw 2>;
 
-			power-domains = <&CPU_PD7>;
+			power-domains = <&cpu_pd7>;
 			power-domain-names = "psci";
 
 			enable-method = "psci";
-			next-level-cache = <&L2_700>;
+			next-level-cache = <&l2_700>;
 			capacity-dmips-mhz = <1894>;
 			dynamic-power-coefficient = <588>;
 
@@ -268,46 +275,46 @@ CPU7: cpu@700 {
 
 			#cooling-cells = <2>;
 
-			L2_700: l2-cache {
+			l2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
-				next-level-cache = <&L3_0>;
+				next-level-cache = <&l3_0>;
 			};
 		};
 
 		cpu-map {
 			cluster0 {
 				core0 {
-					cpu = <&CPU0>;
+					cpu = <&cpu0>;
 				};
 
 				core1 {
-					cpu = <&CPU1>;
+					cpu = <&cpu1>;
 				};
 
 				core2 {
-					cpu = <&CPU2>;
+					cpu = <&cpu2>;
 				};
 
 				core3 {
-					cpu = <&CPU3>;
+					cpu = <&cpu3>;
 				};
 
 				core4 {
-					cpu = <&CPU4>;
+					cpu = <&cpu4>;
 				};
 
 				core5 {
-					cpu = <&CPU5>;
+					cpu = <&cpu5>;
 				};
 
 				core6 {
-					cpu = <&CPU6>;
+					cpu = <&cpu6>;
 				};
 
 				core7 {
-					cpu = <&CPU7>;
+					cpu = <&cpu7>;
 				};
 			};
 		};
@@ -315,7 +322,7 @@ core7 {
 		idle-states {
 			entry-method = "psci";
 
-			SILVER_CPU_SLEEP_0: cpu-sleep-0-0 {
+			silver_cpu_sleep_0: cpu-sleep-0-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "silver-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
@@ -325,7 +332,7 @@ SILVER_CPU_SLEEP_0: cpu-sleep-0-0 {
 				local-timer-stop;
 			};
 
-			GOLD_CPU_SLEEP_0: cpu-sleep-1-0 {
+			gold_cpu_sleep_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "gold-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
@@ -335,7 +342,7 @@ GOLD_CPU_SLEEP_0: cpu-sleep-1-0 {
 				local-timer-stop;
 			};
 
-			GOLD_PLUS_CPU_SLEEP_0: cpu-sleep-2-0 {
+			gold_plus_cpu_sleep_0: cpu-sleep-2-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "gold-plus-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
@@ -347,7 +354,7 @@ GOLD_PLUS_CPU_SLEEP_0: cpu-sleep-2-0 {
 		};
 
 		domain-idle-states {
-			CLUSTER_SLEEP_0: cluster-sleep-0 {
+			cluster_sleep_0: cluster-sleep-0 {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x41000044>;
 				entry-latency-us = <750>;
@@ -355,7 +362,7 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 				min-residency-us = <9144>;
 			};
 
-			CLUSTER_SLEEP_1: cluster-sleep-1 {
+			cluster_sleep_1: cluster-sleep-1 {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x4100c344>;
 				entry-latency-us = <2800>;
@@ -411,58 +418,58 @@ psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		CPU_PD0: power-domain-cpu0 {
+		cpu_pd0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&SILVER_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&silver_cpu_sleep_0>;
 		};
 
-		CPU_PD1: power-domain-cpu1 {
+		cpu_pd1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&SILVER_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&silver_cpu_sleep_0>;
 		};
 
-		CPU_PD2: power-domain-cpu2 {
+		cpu_pd2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&SILVER_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_cpu_sleep_0>;
 		};
 
-		CPU_PD3: power-domain-cpu3 {
+		cpu_pd3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&GOLD_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_cpu_sleep_0>;
 		};
 
-		CPU_PD4: power-domain-cpu4 {
+		cpu_pd4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&GOLD_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_cpu_sleep_0>;
 		};
 
-		CPU_PD5: power-domain-cpu5 {
+		cpu_pd5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&GOLD_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_cpu_sleep_0>;
 		};
 
-		CPU_PD6: power-domain-cpu6 {
+		cpu_pd6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&GOLD_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_cpu_sleep_0>;
 		};
 
-		CPU_PD7: power-domain-cpu7 {
+		cpu_pd7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&GOLD_PLUS_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&gold_plus_cpu_sleep_0>;
 		};
 
-		CLUSTER_PD: power-domain-cluster {
+		cluster_pd: power-domain-cluster {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_0>,
-					     <&CLUSTER_SLEEP_1>;
+			domain-idle-states = <&cluster_sleep_0>,
+					     <&cluster_sleep_1>;
 		};
 	};
 
@@ -5233,7 +5240,7 @@ apps_rsc: rsc@17a00000 {
 				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 
-			power-domains = <&CLUSTER_PD>;
+			power-domains = <&cluster_pd>;
 
 			qcom,tcs-offset = <0xd00>;
 			qcom,drv-id = <2>;
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 044a2f1432fe..2a504a449b0b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -419,6 +419,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -440,6 +441,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l16b_2p9: ldo16 {
diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
index 68b04e56ae56..5a15a956702a 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
@@ -62,8 +62,7 @@ phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/dts/renesas/cat875.dtsi
index 8c9da8b4bd60..191b051ecfd4 100644
--- a/arch/arm64/boot/dts/renesas/cat875.dtsi
+++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
@@ -25,8 +25,7 @@ phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id001c.c915",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/condor-common.dtsi b/arch/arm64/boot/dts/renesas/condor-common.dtsi
index 8b7c0c34eadc..b2d99dfaa0cd 100644
--- a/arch/arm64/boot/dts/renesas/condor-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/condor-common.dtsi
@@ -166,8 +166,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio4 23 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/draak.dtsi b/arch/arm64/boot/dts/renesas/draak.dtsi
index 6f133f54ded5..402112a37d75 100644
--- a/arch/arm64/boot/dts/renesas/draak.dtsi
+++ b/arch/arm64/boot/dts/renesas/draak.dtsi
@@ -247,8 +247,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio5 19 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio5 18 GPIO_ACTIVE_LOW>;
 		/*
 		 * TX clock internal delay mode is required for reliable
diff --git a/arch/arm64/boot/dts/renesas/ebisu.dtsi b/arch/arm64/boot/dts/renesas/ebisu.dtsi
index cba2fde9dd36..1aedd093fb41 100644
--- a/arch/arm64/boot/dts/renesas/ebisu.dtsi
+++ b/arch/arm64/boot/dts/renesas/ebisu.dtsi
@@ -314,8 +314,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 		/*
 		 * TX clock internal delay mode is required for reliable
diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
index ad898c6db4e6..4113710d5522 100644
--- a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
@@ -27,8 +27,7 @@ phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-id001c.c915",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
index 0608dce92e40..7dd9e13cf007 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -111,8 +111,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio1 17 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
index e36999e91af5..0a103f93b14d 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -117,8 +117,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio1 17 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
index 77d22df25fff..a8a20c748ffc 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -124,8 +124,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio4 23 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts b/arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts
index 63db822e5f46..6bd580737f25 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779a0-falcon.dts
@@ -31,8 +31,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio4 16 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi
index 33c1015e9ab3..5d38669ed1ec 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ethernet.dtsi
@@ -60,8 +60,7 @@ mdio {
 				u101: ethernet-phy@1 {
 					reg = <1>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 10 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
@@ -78,8 +77,7 @@ mdio {
 				u201: ethernet-phy@2 {
 					reg = <2>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 11 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
@@ -96,8 +94,7 @@ mdio {
 				u301: ethernet-phy@3 {
 					reg = <3>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 9 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts b/arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts
index fa910b85859e..5d71d52f9c65 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779f4-s4sk.dts
@@ -197,8 +197,7 @@ mdio {
 				ic99: ethernet-phy@1 {
 					reg = <1>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 10 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
@@ -216,8 +215,7 @@ mdio {
 				ic102: ethernet-phy@2 {
 					reg = <2>;
 					compatible = "ethernet-phy-ieee802.3-c45";
-					interrupt-parent = <&gpio3>;
-					interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+					interrupts-extended = <&gpio3 11 IRQ_TYPE_LEVEL_LOW>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dts b/arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dts
index 50a428572d9b..48befde38937 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g2-white-hawk-single.dts
@@ -7,71 +7,10 @@
 
 /dts-v1/;
 #include "r8a779g2.dtsi"
-#include "white-hawk-cpu-common.dtsi"
-#include "white-hawk-common.dtsi"
+#include "white-hawk-single.dtsi"
 
 / {
 	model = "Renesas White Hawk Single board based on r8a779g2";
 	compatible = "renesas,white-hawk-single", "renesas,r8a779g2",
 		     "renesas,r8a779g0";
 };
-
-&hscif0 {
-	uart-has-rtscts;
-};
-
-&hscif0_pins {
-	groups = "hscif0_data", "hscif0_ctrl";
-	function = "hscif0";
-};
-
-&pfc {
-	tsn0_pins: tsn0 {
-		mux {
-			groups = "tsn0_link", "tsn0_mdio", "tsn0_rgmii",
-				 "tsn0_txcrefclk";
-			function = "tsn0";
-		};
-
-		link {
-			groups = "tsn0_link";
-			bias-disable;
-		};
-
-		mdio {
-			groups = "tsn0_mdio";
-			drive-strength = <24>;
-			bias-disable;
-		};
-
-		rgmii {
-			groups = "tsn0_rgmii";
-			drive-strength = <24>;
-			bias-disable;
-		};
-	};
-};
-
-&tsn0 {
-	pinctrl-0 = <&tsn0_pins>;
-	pinctrl-names = "default";
-	phy-mode = "rgmii";
-	phy-handle = <&phy3>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		reset-gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
-		reset-post-delay-us = <4000>;
-
-		phy3: ethernet-phy@0 {
-			compatible = "ethernet-phy-id002b.0980",
-				     "ethernet-phy-ieee802.3-c22";
-			reg = <0>;
-			interrupt-parent = <&gpio4>;
-			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts b/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
index 9a1917b87f61..f4d721a7f505 100644
--- a/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dts
@@ -175,8 +175,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio7>;
-		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio7 5 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio7 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index 83f5642d0d35..502d9f17bf16 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -102,8 +102,7 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -130,8 +129,7 @@ phy1: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ3 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ3 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index b4ef5ea8a9e3..de39311a77dc 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -82,8 +82,7 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ0 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 79443fb3f581..1a6fd58bd368 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -78,8 +78,7 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -107,8 +106,7 @@ phy1: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
-		interrupt-parent = <&irqc>;
-		interrupts = <RZG2L_IRQ7 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&irqc RZG2L_IRQ7 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 612cdc7efabb..d2d367c09abd 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -98,8 +98,7 @@ &eth0 {
 
 	phy0: ethernet-phy@7 {
 		reg = <7>;
-		interrupt-parent = <&pinctrl>;
-		interrupts = <RZG2L_GPIO(12, 0) IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&pinctrl RZG2L_GPIO(12, 0) IRQ_TYPE_EDGE_FALLING>;
 		rxc-skew-psec = <0>;
 		txc-skew-psec = <0>;
 		rxdv-skew-psec = <0>;
@@ -124,8 +123,7 @@ &eth1 {
 
 	phy1: ethernet-phy@7 {
 		reg = <7>;
-		interrupt-parent = <&pinctrl>;
-		interrupts = <RZG2L_GPIO(12, 1) IRQ_TYPE_EDGE_FALLING>;
+		interrupts-extended = <&pinctrl RZG2L_GPIO(12, 1) IRQ_TYPE_EDGE_FALLING>;
 		rxc-skew-psec = <0>;
 		txc-skew-psec = <0>;
 		rxdv-skew-psec = <0>;
diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 1eb4883b3219..c5035232956a 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -353,8 +353,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index a2f66f916048..4cf141a701c0 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -150,8 +150,7 @@ phy0: ethernet-phy@0 {
 			     "ethernet-phy-ieee802.3-c22";
 		rxc-skew-ps = <1500>;
 		reg = <0>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		interrupts-extended = <&gpio2 11 IRQ_TYPE_LEVEL_LOW>;
 		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi b/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi
index 3845b413bd24..69e4fddebd4e 100644
--- a/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi
@@ -167,8 +167,7 @@ avb0_phy: ethernet-phy@0 {
 				     "ethernet-phy-ieee802.3-c22";
 			rxc-skew-ps = <1500>;
 			reg = <0>;
-			interrupt-parent = <&gpio7>;
-			interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+			interrupts-extended = <&gpio7 5 IRQ_TYPE_LEVEL_LOW>;
 			reset-gpios = <&gpio7 10 GPIO_ACTIVE_LOW>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi b/arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi
index 595ec4ff4cdd..ad94bf3f5e6c 100644
--- a/arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi
+++ b/arch/arm64/boot/dts/renesas/white-hawk-ethernet.dtsi
@@ -29,8 +29,7 @@ mdio {
 		avb1_phy: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c45";
 			reg = <0>;
-			interrupt-parent = <&gpio6>;
-			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+			interrupts-extended = <&gpio6 3 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
@@ -51,8 +50,7 @@ mdio {
 		avb2_phy: ethernet-phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c45";
 			reg = <0>;
-			interrupt-parent = <&gpio5>;
-			interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+			interrupts-extended = <&gpio5 4 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/renesas/white-hawk-single.dtsi b/arch/arm64/boot/dts/renesas/white-hawk-single.dtsi
new file mode 100644
index 000000000000..976a3ab44e5a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/white-hawk-single.dtsi
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the White Hawk Single board
+ *
+ * Copyright (C) 2023-2024 Glider bv
+ */
+
+#include "white-hawk-cpu-common.dtsi"
+#include "white-hawk-common.dtsi"
+
+/ {
+	model = "Renesas White Hawk Single board";
+	compatible = "renesas,white-hawk-single";
+
+	aliases {
+		ethernet3 = &tsn0;
+	};
+};
+
+&hscif0 {
+	uart-has-rtscts;
+};
+
+&hscif0_pins {
+	groups = "hscif0_data", "hscif0_ctrl";
+	function = "hscif0";
+};
+
+&pfc {
+	tsn0_pins: tsn0 {
+		mux {
+			groups = "tsn0_link", "tsn0_mdio", "tsn0_rgmii",
+				 "tsn0_txcrefclk";
+			function = "tsn0";
+		};
+
+		link {
+			groups = "tsn0_link";
+			bias-disable;
+		};
+
+		mdio {
+			groups = "tsn0_mdio";
+			drive-strength = <24>;
+			bias-disable;
+		};
+
+		rgmii {
+			groups = "tsn0_rgmii";
+			drive-strength = <24>;
+			bias-disable;
+		};
+	};
+};
+
+&tsn0 {
+	pinctrl-0 = <&tsn0_pins>;
+	pinctrl-names = "default";
+	phy-mode = "rgmii";
+	phy-handle = <&tsn0_phy>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reset-gpios = <&gpio1 23 GPIO_ACTIVE_LOW>;
+		reset-post-delay-us = <4000>;
+
+		tsn0_phy: ethernet-phy@0 {
+			compatible = "ethernet-phy-id002b.0980",
+				     "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			interrupts-extended = <&gpio4 3 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 257636d0d2cb..0a73218ea37b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -59,17 +59,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc5v0_host: vcc5v0-host-regulator {
-		compatible = "regulator-fixed";
-		gpio = <&gpio4 RK_PA3 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_host_en>;
-		regulator-name = "vcc5v0_host";
-		regulator-always-on;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: regulator-vcc5v0-sys {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -509,10 +499,10 @@ pmic_int_l: pmic-int-l {
 		};
 	};
 
-	usb2 {
-		vcc5v0_host_en: vcc5v0-host-en {
+	usb {
+		cy3304_reset: cy3304-reset {
 			rockchip,pins =
-			  <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+			  <4 RK_PA3 RK_FUNC_GPIO &pcfg_output_high>;
 		};
 	};
 
@@ -579,7 +569,6 @@ u2phy1_otg: otg-port {
 	};
 
 	u2phy1_host: host-port {
-		phy-supply = <&vcc5v0_host>;
 		status = "okay";
 	};
 };
@@ -591,6 +580,29 @@ &usbdrd3_1 {
 &usbdrd_dwc3_1 {
 	status = "okay";
 	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&cy3304_reset>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	hub_2_0: hub@1 {
+		compatible = "usb4b4,6502", "usb4b4,6506";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+		vdd-supply = <&vcc1v2_phy>;
+		vdd2-supply = <&vcc3v3_sys>;
+
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb4b4,6500", "usb4b4,6504";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio4 RK_PA3 GPIO_ACTIVE_HIGH>;
+		vdd-supply = <&vcc1v2_phy>;
+		vdd2-supply = <&vcc3v3_sys>;
+	};
 };
 
 &usb_host1_ehci {
diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/include/uapi/asm/ioctls.h
index 2c145da3b774..b5211e413829 100644
--- a/arch/powerpc/include/uapi/asm/ioctls.h
+++ b/arch/powerpc/include/uapi/asm/ioctls.h
@@ -23,10 +23,10 @@
 #define TCSETSW		_IOW('t', 21, struct termios)
 #define TCSETSF		_IOW('t', 22, struct termios)
 
-#define TCGETA		_IOR('t', 23, struct termio)
-#define TCSETA		_IOW('t', 24, struct termio)
-#define TCSETAW		_IOW('t', 25, struct termio)
-#define TCSETAF		_IOW('t', 28, struct termio)
+#define TCGETA		0x40147417 /* _IOR('t', 23, struct termio) */
+#define TCSETA		0x80147418 /* _IOW('t', 24, struct termio) */
+#define TCSETAW		0x80147419 /* _IOW('t', 25, struct termio) */
+#define TCSETAF		0x8014741c /* _IOW('t', 28, struct termio) */
 
 #define TCSBRK		_IO('t', 29)
 #define TCXONC		_IO('t', 30)
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b4006a4a1121..04d6a1e8ff9a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -162,9 +162,7 @@ endif
 
 obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
 
-ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC_CORE)$(CONFIG_PPC_BOOK3S),)
 obj-y				+= ppc_save_regs.o
-endif
 
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index e6fbaaf54956..87d655944803 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -18,10 +18,10 @@ const struct cpu_operations cpu_ops_sbi;
 
 /*
  * Ordered booting via HSM brings one cpu at a time. However, cpu hotplug can
- * be invoked from multiple threads in parallel. Define a per cpu data
+ * be invoked from multiple threads in parallel. Define an array of boot data
  * to handle that.
  */
-static DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
+static struct sbi_hart_boot_data boot_data[NR_CPUS];
 
 static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
 			      unsigned long priv)
@@ -67,7 +67,7 @@ static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 	unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
 	unsigned long hartid = cpuid_to_hartid_map(cpuid);
 	unsigned long hsm_data;
-	struct sbi_hart_boot_data *bdata = &per_cpu(boot_data, cpuid);
+	struct sbi_hart_boot_data *bdata = &boot_data[cpuid];
 
 	/* Make sure tidle is updated */
 	smp_mb();
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 6f48a1073c6e..ef44feb1a9da 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -105,6 +105,10 @@ static pci_ers_result_t zpci_event_do_error_state_clear(struct pci_dev *pdev,
 	struct zpci_dev *zdev = to_zpci(pdev);
 	int rc;
 
+	/* The underlying device may have been disabled by the event */
+	if (!zdev_enabled(zdev))
+		return PCI_ERS_RESULT_NEED_RESET;
+
 	pr_info("%s: Unblocking device access for examination\n", pci_name(pdev));
 	rc = zpci_reset_load_store_blocked(zdev);
 	if (rc) {
@@ -260,6 +264,8 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 	struct zpci_dev *zdev = get_zdev_by_fid(ccdf->fid);
 	struct pci_dev *pdev = NULL;
 	pci_ers_result_t ers_res;
+	u32 fh = 0;
+	int rc;
 
 	zpci_dbg(3, "err fid:%x, fh:%x, pec:%x\n",
 		 ccdf->fid, ccdf->fh, ccdf->pec);
@@ -268,6 +274,15 @@ static void __zpci_event_error(struct zpci_ccdf_err *ccdf)
 
 	if (zdev) {
 		mutex_lock(&zdev->state_lock);
+		rc = clp_refresh_fh(zdev->fid, &fh);
+		if (rc)
+			goto no_pdev;
+		if (!fh || ccdf->fh != fh) {
+			/* Ignore events with stale handles */
+			zpci_dbg(3, "err fid:%x, fh:%x (stale %x)\n",
+				 ccdf->fid, fh, ccdf->fh);
+			goto no_pdev;
+		}
 		zpci_update_fh(zdev, ccdf->fh);
 		if (zdev->zbus->bus)
 			pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 15425c9bdc2b..dfa334e3d1a0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2760,6 +2760,15 @@ config MITIGATION_ITS
 	  disabled, mitigation cannot be enabled via cmdline.
 	  See <file:Documentation/admin-guide/hw-vuln/indirect-target-selection.rst>
 
+config MITIGATION_TSA
+	bool "Mitigate Transient Scheduler Attacks"
+	depends on CPU_SUP_AMD
+	default y
+	help
+	  Enable mitigation for Transient Scheduler Attacks. TSA is a hardware
+	  security vulnerability on AMD CPUs which can lead to forwarding of
+	  invalid info to subsequent instructions and thus can affect their
+	  timing and thereby cause a leakage.
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 5b96249734ad..b0d5ab951231 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -33,20 +33,20 @@ EXPORT_SYMBOL_GPL(entry_ibpb);
 
 /*
  * Define the VERW operand that is disguised as entry code so that
- * it can be referenced with KPTI enabled. This ensure VERW can be
+ * it can be referenced with KPTI enabled. This ensures VERW can be
  * used late in exit-to-user path after page tables are switched.
  */
 .pushsection .entry.text, "ax"
 
 .align L1_CACHE_BYTES, 0xcc
-SYM_CODE_START_NOALIGN(mds_verw_sel)
+SYM_CODE_START_NOALIGN(x86_verw_sel)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
 	.word __KERNEL_DS
 .align L1_CACHE_BYTES, 0xcc
-SYM_CODE_END(mds_verw_sel);
+SYM_CODE_END(x86_verw_sel);
 /* For KVM */
-EXPORT_SYMBOL_GPL(mds_verw_sel);
+EXPORT_SYMBOL_GPL(x86_verw_sel);
 
 .popsection
 
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index aa30fd8cad7f..b6099456477c 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -69,4 +69,16 @@ int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
 
 extern struct cpumask cpus_stop_mask;
 
+union zen_patch_rev {
+	struct {
+		__u32 rev	 : 8,
+		      stepping	 : 4,
+		      model	 : 4,
+		      __reserved : 4,
+		      ext_model	 : 4,
+		      ext_fam	 : 8;
+	};
+	__u32 ucode_rev;
+};
+
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 308e7d97135c..ef5749a0d8c2 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -455,6 +455,7 @@
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
 #define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing / synchronizes RDTSC */
+#define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* The memory form of VERW mitigates TSA */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears Base */
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* Automatic IBRS */
 #define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* SMM_CTL MSR is not present */
@@ -477,6 +478,10 @@
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
 #define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32 + 6) /* Use thunk for indirect branches in lower half of cacheline */
 
+#define X86_FEATURE_TSA_SQ_NO          (21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
+#define X86_FEATURE_TSA_L1_NO          (21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
+#define X86_FEATURE_CLEAR_CPU_BUF_VM   (21*32+13) /* Clear CPU buffers using VERW before VMRUN */
+
 /*
  * BUG word(s)
  */
@@ -529,4 +534,5 @@
 #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
 #define X86_BUG_ITS			X86_BUG(1*32 + 5) /* "its" CPU is affected by Indirect Target Selection */
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG(1*32 + 6) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
+#define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 1c2db11a2c3c..2b75fe80fcb2 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -44,13 +44,13 @@ static __always_inline void native_irq_enable(void)
 
 static __always_inline void native_safe_halt(void)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
 	asm volatile("sti; hlt": : :"memory");
 }
 
 static __always_inline void native_halt(void)
 {
-	mds_idle_clear_cpu_buffers();
+	x86_idle_clear_cpu_buffers();
 	asm volatile("hlt": : :"memory");
 }
 
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 3e4e85f71a6a..7f9a97c572fe 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -44,8 +44,6 @@ static __always_inline void __monitorx(const void *eax, unsigned long ecx,
 
 static __always_inline void __mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
-
 	/* "mwait %eax, %ecx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
@@ -80,7 +78,7 @@ static __always_inline void __mwait(unsigned long eax, unsigned long ecx)
 static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
 				     unsigned long ecx)
 {
-	/* No MDS buffer clear as this is AMD/HYGON only */
+	/* No need for TSA buffer clearing on AMD */
 
 	/* "mwaitx %eax, %ebx, %ecx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xfb;"
@@ -98,7 +96,7 @@ static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
  */
 static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	mds_idle_clear_cpu_buffers();
+
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
 		     :: "a" (eax), "c" (ecx));
@@ -116,21 +114,29 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
  */
 static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
+	if (need_resched())
+		return;
+
+	x86_idle_clear_cpu_buffers();
+
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
 		const void *addr = &current_thread_info()->flags;
 
 		alternative_input("", "clflush (%[addr])", X86_BUG_CLFLUSH_MONITOR, [addr] "a" (addr));
 		__monitor(addr, 0, 0);
 
-		if (!need_resched()) {
-			if (ecx & 1) {
-				__mwait(eax, ecx);
-			} else {
-				__sti_mwait(eax, ecx);
-				raw_local_irq_disable();
-			}
+		if (need_resched())
+			goto out;
+
+		if (ecx & 1) {
+			__mwait(eax, ecx);
+		} else {
+			__sti_mwait(eax, ecx);
+			raw_local_irq_disable();
 		}
 	}
+
+out:
 	current_clr_polling();
 }
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f7bb0016d7d9..331f6a05535d 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -315,25 +315,31 @@
 .endm
 
 /*
- * Macro to execute VERW instruction that mitigate transient data sampling
- * attacks such as MDS. On affected systems a microcode update overloaded VERW
- * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
- *
+ * Macro to execute VERW insns that mitigate transient data sampling
+ * attacks such as MDS or TSA. On affected systems a microcode update
+ * overloaded VERW insns to also clear the CPU buffers. VERW clobbers
+ * CFLAGS.ZF.
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
-.macro CLEAR_CPU_BUFFERS
+.macro __CLEAR_CPU_BUFFERS feature
 #ifdef CONFIG_X86_64
-	ALTERNATIVE "", "verw mds_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", "verw x86_verw_sel(%rip)", \feature
 #else
 	/*
 	 * In 32bit mode, the memory operand must be a %cs reference. The data
 	 * segments may not be usable (vm86 mode), and the stack segment may not
 	 * be flat (ESPFIX32).
 	 */
-	ALTERNATIVE "", "verw %cs:mds_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", "verw %cs:x86_verw_sel", \feature
 #endif
 .endm
 
+#define CLEAR_CPU_BUFFERS \
+	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF
+
+#define VM_CLEAR_CPU_BUFFERS \
+	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF_VM
+
 #ifdef CONFIG_X86_64
 .macro CLEAR_BRANCH_HISTORY
 	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOOP
@@ -582,24 +588,24 @@ DECLARE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 DECLARE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-DECLARE_STATIC_KEY_FALSE(mds_idle_clear);
+DECLARE_STATIC_KEY_FALSE(cpu_buf_idle_clear);
 
 DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 
 DECLARE_STATIC_KEY_FALSE(mmio_stale_data_clear);
 
-extern u16 mds_verw_sel;
+extern u16 x86_verw_sel;
 
 #include <asm/segment.h>
 
 /**
- * mds_clear_cpu_buffers - Mitigation for MDS and TAA vulnerability
+ * x86_clear_cpu_buffers - Buffer clearing support for different x86 CPU vulns
  *
  * This uses the otherwise unused and obsolete VERW instruction in
  * combination with microcode which triggers a CPU buffer flush when the
  * instruction is executed.
  */
-static __always_inline void mds_clear_cpu_buffers(void)
+static __always_inline void x86_clear_cpu_buffers(void)
 {
 	static const u16 ds = __KERNEL_DS;
 
@@ -616,14 +622,15 @@ static __always_inline void mds_clear_cpu_buffers(void)
 }
 
 /**
- * mds_idle_clear_cpu_buffers - Mitigation for MDS vulnerability
+ * x86_idle_clear_cpu_buffers - Buffer clearing support in idle for the MDS
+ * and TSA vulnerabilities.
  *
  * Clear CPU buffers if the corresponding static key is enabled
  */
-static __always_inline void mds_idle_clear_cpu_buffers(void)
+static __always_inline void x86_idle_clear_cpu_buffers(void)
 {
-	if (static_branch_likely(&mds_idle_clear))
-		mds_clear_cpu_buffers();
+	if (static_branch_likely(&cpu_buf_idle_clear))
+		x86_clear_cpu_buffers();
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index e432910859cb..8a740e92e483 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -368,6 +368,63 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
 #endif
 }
 
+static bool amd_check_tsa_microcode(void)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	union zen_patch_rev p;
+	u32 min_rev = 0;
+
+	p.ext_fam	= c->x86 - 0xf;
+	p.model		= c->x86_model;
+	p.stepping	= c->x86_stepping;
+
+	if (cpu_has(c, X86_FEATURE_ZEN3) ||
+	    cpu_has(c, X86_FEATURE_ZEN4)) {
+		switch (p.ucode_rev >> 8) {
+		case 0xa0011:	min_rev = 0x0a0011d7; break;
+		case 0xa0012:	min_rev = 0x0a00123b; break;
+		case 0xa0082:	min_rev = 0x0a00820d; break;
+		case 0xa1011:	min_rev = 0x0a10114c; break;
+		case 0xa1012:	min_rev = 0x0a10124c; break;
+		case 0xa1081:	min_rev = 0x0a108109; break;
+		case 0xa2010:	min_rev = 0x0a20102e; break;
+		case 0xa2012:	min_rev = 0x0a201211; break;
+		case 0xa4041:	min_rev = 0x0a404108; break;
+		case 0xa5000:	min_rev = 0x0a500012; break;
+		case 0xa6012:	min_rev = 0x0a60120a; break;
+		case 0xa7041:	min_rev = 0x0a704108; break;
+		case 0xa7052:	min_rev = 0x0a705208; break;
+		case 0xa7080:	min_rev = 0x0a708008; break;
+		case 0xa70c0:	min_rev = 0x0a70c008; break;
+		case 0xaa002:	min_rev = 0x0aa00216; break;
+		default:
+			pr_debug("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
+				 __func__, p.ucode_rev, c->microcode);
+			return false;
+		}
+	}
+
+	if (!min_rev)
+		return false;
+
+	return c->microcode >= min_rev;
+}
+
+static void tsa_init(struct cpuinfo_x86 *c)
+{
+	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+		return;
+
+	if (cpu_has(c, X86_FEATURE_ZEN3) ||
+	    cpu_has(c, X86_FEATURE_ZEN4)) {
+		if (amd_check_tsa_microcode())
+			setup_force_cpu_cap(X86_FEATURE_VERW_CLEAR);
+	} else {
+		setup_force_cpu_cap(X86_FEATURE_TSA_SQ_NO);
+		setup_force_cpu_cap(X86_FEATURE_TSA_L1_NO);
+	}
+}
+
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
@@ -475,6 +532,9 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	bsp_determine_snp(c);
+
+	tsa_init(c);
+
 	return;
 
 warn:
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0e9ab0b9a494..c2c7b76d953f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -50,6 +50,7 @@ static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
 static void __init its_select_mitigation(void);
+static void __init tsa_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -122,9 +123,9 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
 /* Control unconditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_always_ibpb);
 
-/* Control MDS CPU buffer clear before idling (halt, mwait) */
-DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
-EXPORT_SYMBOL_GPL(mds_idle_clear);
+/* Control CPU buffer clear before idling (halt, mwait) */
+DEFINE_STATIC_KEY_FALSE(cpu_buf_idle_clear);
+EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
 
 /*
  * Controls whether l1d flush based mitigations are enabled,
@@ -185,6 +186,7 @@ void __init cpu_select_mitigations(void)
 	srso_select_mitigation();
 	gds_select_mitigation();
 	its_select_mitigation();
+	tsa_select_mitigation();
 }
 
 /*
@@ -448,7 +450,7 @@ static void __init mmio_select_mitigation(void)
 	 * is required irrespective of SMT state.
 	 */
 	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
-		static_branch_enable(&mds_idle_clear);
+		static_branch_enable(&cpu_buf_idle_clear);
 
 	/*
 	 * Check if the system has the right microcode.
@@ -2092,10 +2094,10 @@ static void update_mds_branch_idle(void)
 		return;
 
 	if (sched_smt_active()) {
-		static_branch_enable(&mds_idle_clear);
+		static_branch_enable(&cpu_buf_idle_clear);
 	} else if (mmio_mitigation == MMIO_MITIGATION_OFF ||
 		   (x86_arch_cap_msr & ARCH_CAP_FBSDP_NO)) {
-		static_branch_disable(&mds_idle_clear);
+		static_branch_disable(&cpu_buf_idle_clear);
 	}
 }
 
@@ -2103,6 +2105,94 @@ static void update_mds_branch_idle(void)
 #define TAA_MSG_SMT "TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.\n"
 #define MMIO_MSG_SMT "MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.\n"
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"Transient Scheduler Attacks: " fmt
+
+enum tsa_mitigations {
+	TSA_MITIGATION_NONE,
+	TSA_MITIGATION_UCODE_NEEDED,
+	TSA_MITIGATION_USER_KERNEL,
+	TSA_MITIGATION_VM,
+	TSA_MITIGATION_FULL,
+};
+
+static const char * const tsa_strings[] = {
+	[TSA_MITIGATION_NONE]		= "Vulnerable",
+	[TSA_MITIGATION_UCODE_NEEDED]	= "Vulnerable: Clear CPU buffers attempted, no microcode",
+	[TSA_MITIGATION_USER_KERNEL]	= "Mitigation: Clear CPU buffers: user/kernel boundary",
+	[TSA_MITIGATION_VM]		= "Mitigation: Clear CPU buffers: VM",
+	[TSA_MITIGATION_FULL]		= "Mitigation: Clear CPU buffers",
+};
+
+static enum tsa_mitigations tsa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TSA) ? TSA_MITIGATION_FULL : TSA_MITIGATION_NONE;
+
+static int __init tsa_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off"))
+		tsa_mitigation = TSA_MITIGATION_NONE;
+	else if (!strcmp(str, "on"))
+		tsa_mitigation = TSA_MITIGATION_FULL;
+	else if (!strcmp(str, "user"))
+		tsa_mitigation = TSA_MITIGATION_USER_KERNEL;
+	else if (!strcmp(str, "vm"))
+		tsa_mitigation = TSA_MITIGATION_VM;
+	else
+		pr_err("Ignoring unknown tsa=%s option.\n", str);
+
+	return 0;
+}
+early_param("tsa", tsa_parse_cmdline);
+
+static void __init tsa_select_mitigation(void)
+{
+	if (tsa_mitigation == TSA_MITIGATION_NONE)
+		return;
+
+	if (cpu_mitigations_off() || !boot_cpu_has_bug(X86_BUG_TSA)) {
+		tsa_mitigation = TSA_MITIGATION_NONE;
+		return;
+	}
+
+	if (!boot_cpu_has(X86_FEATURE_VERW_CLEAR))
+		tsa_mitigation = TSA_MITIGATION_UCODE_NEEDED;
+
+	switch (tsa_mitigation) {
+	case TSA_MITIGATION_USER_KERNEL:
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+		break;
+
+	case TSA_MITIGATION_VM:
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF_VM);
+		break;
+
+	case TSA_MITIGATION_UCODE_NEEDED:
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			goto out;
+
+		pr_notice("Forcing mitigation on in a VM\n");
+
+		/*
+		 * On the off-chance that microcode has been updated
+		 * on the host, enable the mitigation in the guest just
+		 * in case.
+		 */
+		fallthrough;
+	case TSA_MITIGATION_FULL:
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF_VM);
+		break;
+	default:
+		break;
+	}
+
+out:
+	pr_info("%s\n", tsa_strings[tsa_mitigation]);
+}
+
 void cpu_bugs_smt_update(void)
 {
 	mutex_lock(&spec_ctrl_mutex);
@@ -2156,6 +2246,24 @@ void cpu_bugs_smt_update(void)
 		break;
 	}
 
+	switch (tsa_mitigation) {
+	case TSA_MITIGATION_USER_KERNEL:
+	case TSA_MITIGATION_VM:
+	case TSA_MITIGATION_FULL:
+	case TSA_MITIGATION_UCODE_NEEDED:
+		/*
+		 * TSA-SQ can potentially lead to info leakage between
+		 * SMT threads.
+		 */
+		if (sched_smt_active())
+			static_branch_enable(&cpu_buf_idle_clear);
+		else
+			static_branch_disable(&cpu_buf_idle_clear);
+		break;
+	case TSA_MITIGATION_NONE:
+		break;
+	}
+
 	mutex_unlock(&spec_ctrl_mutex);
 }
 
@@ -3084,6 +3192,11 @@ static ssize_t gds_show_state(char *buf)
 	return sysfs_emit(buf, "%s\n", gds_strings[gds_mitigation]);
 }
 
+static ssize_t tsa_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", tsa_strings[tsa_mitigation]);
+}
+
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
@@ -3145,6 +3258,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_ITS:
 		return its_show_state(buf);
 
+	case X86_BUG_TSA:
+		return tsa_show_state(buf);
+
 	default:
 		break;
 	}
@@ -3229,6 +3345,11 @@ ssize_t cpu_show_indirect_target_selection(struct device *dev, struct device_att
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_ITS);
 }
+
+ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_TSA);
+}
 #endif
 
 void __warn_thunk(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a11c61fd7d52..ed072b126111 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1233,6 +1233,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define ITS		BIT(8)
 /* CPU is affected by Indirect Target Selection, but guest-host isolation is not affected */
 #define ITS_NATIVE_ONLY	BIT(9)
+/* CPU is affected by Transient Scheduler Attacks */
+#define TSA		BIT(10)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),
@@ -1280,7 +1282,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_AMD(0x16, RETBLEED),
 	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
 	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_AMD(0x19, SRSO),
+	VULNBL_AMD(0x19, SRSO | TSA),
 	{}
 };
 
@@ -1490,6 +1492,16 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 			setup_force_cpu_bug(X86_BUG_ITS_NATIVE_ONLY);
 	}
 
+	if (c->x86_vendor == X86_VENDOR_AMD) {
+		if (!cpu_has(c, X86_FEATURE_TSA_SQ_NO) ||
+		    !cpu_has(c, X86_FEATURE_TSA_L1_NO)) {
+			if (cpu_matches(cpu_vuln_blacklist, TSA) ||
+			    /* Enable bug on Zen guests to allow for live migration. */
+			    (cpu_has(c, X86_FEATURE_HYPERVISOR) && cpu_has(c, X86_FEATURE_ZEN)))
+				setup_force_cpu_bug(X86_BUG_TSA);
+		}
+	}
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 2f84164b20e0..765b4646648f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -94,18 +94,6 @@ static struct equiv_cpu_table {
 	struct equiv_cpu_entry *entry;
 } equiv_table;
 
-union zen_patch_rev {
-	struct {
-		__u32 rev	 : 8,
-		      stepping	 : 4,
-		      model	 : 4,
-		      __reserved : 4,
-		      ext_model	 : 4,
-		      ext_fam	 : 8;
-	};
-	__u32 ucode_rev;
-};
-
 union cpuid_1_eax {
 	struct {
 		__u32 stepping    : 4,
diff --git a/arch/x86/kernel/cpu/microcode/amd_shas.c b/arch/x86/kernel/cpu/microcode/amd_shas.c
index 2a1655b1fdd8..1fd349cfc802 100644
--- a/arch/x86/kernel/cpu/microcode/amd_shas.c
+++ b/arch/x86/kernel/cpu/microcode/amd_shas.c
@@ -231,6 +231,13 @@ static const struct patch_digest phashes[] = {
 		0x0d,0x5b,0x65,0x34,0x69,0xb2,0x62,0x21,
 	}
  },
+ { 0xa0011d7, {
+                0x35,0x07,0xcd,0x40,0x94,0xbc,0x81,0x6b,
+                0xfc,0x61,0x56,0x1a,0xe2,0xdb,0x96,0x12,
+                0x1c,0x1c,0x31,0xb1,0x02,0x6f,0xe5,0xd2,
+                0xfe,0x1b,0x04,0x03,0x2c,0x8f,0x4c,0x36,
+        }
+ },
  { 0xa001223, {
 		0xfb,0x32,0x5f,0xc6,0x83,0x4f,0x8c,0xb8,
 		0xa4,0x05,0xf9,0x71,0x53,0x01,0x16,0xc4,
@@ -294,6 +301,13 @@ static const struct patch_digest phashes[] = {
 		0xc0,0xcd,0x33,0xf2,0x8d,0xf9,0xef,0x59,
 	}
  },
+ { 0xa00123b, {
+		0xef,0xa1,0x1e,0x71,0xf1,0xc3,0x2c,0xe2,
+		0xc3,0xef,0x69,0x41,0x7a,0x54,0xca,0xc3,
+		0x8f,0x62,0x84,0xee,0xc2,0x39,0xd9,0x28,
+		0x95,0xa7,0x12,0x49,0x1e,0x30,0x71,0x72,
+	}
+ },
  { 0xa00820c, {
 		0xa8,0x0c,0x81,0xc0,0xa6,0x00,0xe7,0xf3,
 		0x5f,0x65,0xd3,0xb9,0x6f,0xea,0x93,0x63,
@@ -301,6 +315,13 @@ static const struct patch_digest phashes[] = {
 		0xe1,0x3b,0x8d,0xb2,0xf8,0x22,0x03,0xe2,
 	}
  },
+ { 0xa00820d, {
+		0xf9,0x2a,0xc0,0xf4,0x9e,0xa4,0x87,0xa4,
+		0x7d,0x87,0x00,0xfd,0xab,0xda,0x19,0xca,
+		0x26,0x51,0x32,0xc1,0x57,0x91,0xdf,0xc1,
+		0x05,0xeb,0x01,0x7c,0x5a,0x95,0x21,0xb7,
+	}
+ },
  { 0xa10113e, {
 		0x05,0x3c,0x66,0xd7,0xa9,0x5a,0x33,0x10,
 		0x1b,0xf8,0x9c,0x8f,0xed,0xfc,0xa7,0xa0,
@@ -322,6 +343,13 @@ static const struct patch_digest phashes[] = {
 		0xf1,0x5e,0xb0,0xde,0xb4,0x98,0xae,0xc4,
 	}
  },
+ { 0xa10114c, {
+		0x9e,0xb6,0xa2,0xd9,0x87,0x38,0xc5,0x64,
+		0xd8,0x88,0xfa,0x78,0x98,0xf9,0x6f,0x74,
+		0x39,0x90,0x1b,0xa5,0xcf,0x5e,0xb4,0x2a,
+		0x02,0xff,0xd4,0x8c,0x71,0x8b,0xe2,0xc0,
+	}
+ },
  { 0xa10123e, {
 		0x03,0xb9,0x2c,0x76,0x48,0x93,0xc9,0x18,
 		0xfb,0x56,0xfd,0xf7,0xe2,0x1d,0xca,0x4d,
@@ -343,6 +371,13 @@ static const struct patch_digest phashes[] = {
 		0x1b,0x7d,0x64,0x9d,0x4b,0x53,0x13,0x75,
 	}
  },
+ { 0xa10124c, {
+		0x29,0xea,0xf1,0x2c,0xb2,0xe4,0xef,0x90,
+		0xa4,0xcd,0x1d,0x86,0x97,0x17,0x61,0x46,
+		0xfc,0x22,0xcb,0x57,0x75,0x19,0xc8,0xcc,
+		0x0c,0xf5,0xbc,0xac,0x81,0x9d,0x9a,0xd2,
+	}
+ },
  { 0xa108108, {
 		0xed,0xc2,0xec,0xa1,0x15,0xc6,0x65,0xe9,
 		0xd0,0xef,0x39,0xaa,0x7f,0x55,0x06,0xc6,
@@ -350,6 +385,13 @@ static const struct patch_digest phashes[] = {
 		0x28,0x1e,0x9c,0x59,0x69,0x99,0x4d,0x16,
 	}
  },
+ { 0xa108109, {
+		0x85,0xb4,0xbd,0x7c,0x49,0xa7,0xbd,0xfa,
+		0x49,0x36,0x80,0x81,0xc5,0xb7,0x39,0x1b,
+		0x9a,0xaa,0x50,0xde,0x9b,0xe9,0x32,0x35,
+		0x42,0x7e,0x51,0x4f,0x52,0x2c,0x28,0x59,
+	}
+ },
  { 0xa20102d, {
 		0xf9,0x6e,0xf2,0x32,0xd3,0x0f,0x5f,0x11,
 		0x59,0xa1,0xfe,0xcc,0xcd,0x9b,0x42,0x89,
@@ -357,6 +399,13 @@ static const struct patch_digest phashes[] = {
 		0x8c,0xe9,0x19,0x3e,0xcc,0x3f,0x7b,0xb4,
 	}
  },
+ { 0xa20102e, {
+		0xbe,0x1f,0x32,0x04,0x0d,0x3c,0x9c,0xdd,
+		0xe1,0xa4,0xbf,0x76,0x3a,0xec,0xc2,0xf6,
+		0x11,0x00,0xa7,0xaf,0x0f,0xe5,0x02,0xc5,
+		0x54,0x3a,0x1f,0x8c,0x16,0xb5,0xff,0xbe,
+	}
+ },
  { 0xa201210, {
 		0xe8,0x6d,0x51,0x6a,0x8e,0x72,0xf3,0xfe,
 		0x6e,0x16,0xbc,0x62,0x59,0x40,0x17,0xe9,
@@ -364,6 +413,13 @@ static const struct patch_digest phashes[] = {
 		0xf7,0x55,0xf0,0x13,0xbb,0x22,0xf6,0x41,
 	}
  },
+ { 0xa201211, {
+		0x69,0xa1,0x17,0xec,0xd0,0xf6,0x6c,0x95,
+		0xe2,0x1e,0xc5,0x59,0x1a,0x52,0x0a,0x27,
+		0xc4,0xed,0xd5,0x59,0x1f,0xbf,0x00,0xff,
+		0x08,0x88,0xb5,0xe1,0x12,0xb6,0xcc,0x27,
+	}
+ },
  { 0xa404107, {
 		0xbb,0x04,0x4e,0x47,0xdd,0x5e,0x26,0x45,
 		0x1a,0xc9,0x56,0x24,0xa4,0x4c,0x82,0xb0,
@@ -371,6 +427,13 @@ static const struct patch_digest phashes[] = {
 		0x13,0xbc,0xc5,0x25,0xe4,0xc5,0xc3,0x99,
 	}
  },
+ { 0xa404108, {
+		0x69,0x67,0x43,0x06,0xf8,0x0c,0x62,0xdc,
+		0xa4,0x21,0x30,0x4f,0x0f,0x21,0x2c,0xcb,
+		0xcc,0x37,0xf1,0x1c,0xc3,0xf8,0x2f,0x19,
+		0xdf,0x53,0x53,0x46,0xb1,0x15,0xea,0x00,
+	}
+ },
  { 0xa500011, {
 		0x23,0x3d,0x70,0x7d,0x03,0xc3,0xc4,0xf4,
 		0x2b,0x82,0xc6,0x05,0xda,0x80,0x0a,0xf1,
@@ -378,6 +441,13 @@ static const struct patch_digest phashes[] = {
 		0x11,0x5e,0x96,0x7e,0x71,0xe9,0xfc,0x74,
 	}
  },
+ { 0xa500012, {
+		0xeb,0x74,0x0d,0x47,0xa1,0x8e,0x09,0xe4,
+		0x93,0x4c,0xad,0x03,0x32,0x4c,0x38,0x16,
+		0x10,0x39,0xdd,0x06,0xaa,0xce,0xd6,0x0f,
+		0x62,0x83,0x9d,0x8e,0x64,0x55,0xbe,0x63,
+	}
+ },
  { 0xa601209, {
 		0x66,0x48,0xd4,0x09,0x05,0xcb,0x29,0x32,
 		0x66,0xb7,0x9a,0x76,0xcd,0x11,0xf3,0x30,
@@ -385,6 +455,13 @@ static const struct patch_digest phashes[] = {
 		0xe8,0x73,0xe2,0xd6,0xdb,0xd2,0x77,0x1d,
 	}
  },
+ { 0xa60120a, {
+		0x0c,0x8b,0x3d,0xfd,0x52,0x52,0x85,0x7d,
+		0x20,0x3a,0xe1,0x7e,0xa4,0x21,0x3b,0x7b,
+		0x17,0x86,0xae,0xac,0x13,0xb8,0x63,0x9d,
+		0x06,0x01,0xd0,0xa0,0x51,0x9a,0x91,0x2c,
+	}
+ },
  { 0xa704107, {
 		0xf3,0xc6,0x58,0x26,0xee,0xac,0x3f,0xd6,
 		0xce,0xa1,0x72,0x47,0x3b,0xba,0x2b,0x93,
@@ -392,6 +469,13 @@ static const struct patch_digest phashes[] = {
 		0x64,0x39,0x71,0x8c,0xce,0xe7,0x41,0x39,
 	}
  },
+ { 0xa704108, {
+		0xd7,0x55,0x15,0x2b,0xfe,0xc4,0xbc,0x93,
+		0xec,0x91,0xa0,0xae,0x45,0xb7,0xc3,0x98,
+		0x4e,0xff,0x61,0x77,0x88,0xc2,0x70,0x49,
+		0xe0,0x3a,0x1d,0x84,0x38,0x52,0xbf,0x5a,
+	}
+ },
  { 0xa705206, {
 		0x8d,0xc0,0x76,0xbd,0x58,0x9f,0x8f,0xa4,
 		0x12,0x9d,0x21,0xfb,0x48,0x21,0xbc,0xe7,
@@ -399,6 +483,13 @@ static const struct patch_digest phashes[] = {
 		0x03,0x35,0xe9,0xbe,0xfb,0x06,0xdf,0xfc,
 	}
  },
+ { 0xa705208, {
+		0x30,0x1d,0x55,0x24,0xbc,0x6b,0x5a,0x19,
+		0x0c,0x7d,0x1d,0x74,0xaa,0xd1,0xeb,0xd2,
+		0x16,0x62,0xf7,0x5b,0xe1,0x1f,0x18,0x11,
+		0x5c,0xf0,0x94,0x90,0x26,0xec,0x69,0xff,
+	}
+ },
  { 0xa708007, {
 		0x6b,0x76,0xcc,0x78,0xc5,0x8a,0xa3,0xe3,
 		0x32,0x2d,0x79,0xe4,0xc3,0x80,0xdb,0xb2,
@@ -406,6 +497,13 @@ static const struct patch_digest phashes[] = {
 		0xdf,0x92,0x73,0x84,0x87,0x3c,0x73,0x93,
 	}
  },
+ { 0xa708008, {
+		0x08,0x6e,0xf0,0x22,0x4b,0x8e,0xc4,0x46,
+		0x58,0x34,0xe6,0x47,0xa2,0x28,0xfd,0xab,
+		0x22,0x3d,0xdd,0xd8,0x52,0x9e,0x1d,0x16,
+		0xfa,0x01,0x68,0x14,0x79,0x3e,0xe8,0x6b,
+	}
+ },
  { 0xa70c005, {
 		0x88,0x5d,0xfb,0x79,0x64,0xd8,0x46,0x3b,
 		0x4a,0x83,0x8e,0x77,0x7e,0xcf,0xb3,0x0f,
@@ -413,6 +511,13 @@ static const struct patch_digest phashes[] = {
 		0xee,0x49,0xac,0xe1,0x8b,0x13,0xc5,0x13,
 	}
  },
+ { 0xa70c008, {
+		0x0f,0xdb,0x37,0xa1,0x10,0xaf,0xd4,0x21,
+		0x94,0x0d,0xa4,0xa2,0xe9,0x86,0x6c,0x0e,
+		0x85,0x7c,0x36,0x30,0xa3,0x3a,0x78,0x66,
+		0x18,0x10,0x60,0x0d,0x78,0x3d,0x44,0xd0,
+	}
+ },
  { 0xaa00116, {
 		0xe8,0x4c,0x2c,0x88,0xa1,0xac,0x24,0x63,
 		0x65,0xe5,0xaa,0x2d,0x16,0xa9,0xc3,0xf5,
@@ -441,4 +546,11 @@ static const struct patch_digest phashes[] = {
 		0x68,0x2f,0x46,0xee,0xfe,0xc6,0x6d,0xef,
 	}
  },
+ { 0xaa00216, {
+		0x79,0xfb,0x5b,0x9f,0xb6,0xe6,0xa8,0xf5,
+		0x4e,0x7c,0x4f,0x8e,0x1d,0xad,0xd0,0x08,
+		0xc2,0x43,0x7c,0x8b,0xe6,0xdb,0xd0,0xd2,
+		0xe8,0x39,0x26,0xc1,0xe5,0x5a,0x48,0xf1,
+	}
+ },
 };
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index c84c30188fdf..bc4993aa41ed 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,8 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_TSA_SQ_NO,	CPUID_ECX,  1, 0x80000021, 0 },
+	{ X86_FEATURE_TSA_L1_NO,	CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1dbd7a34645c..4c9c98c5deab 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -911,16 +911,24 @@ static __init bool prefer_mwait_c1_over_halt(void)
  */
 static __cpuidle void mwait_idle(void)
 {
+	if (need_resched())
+		return;
+
+	x86_idle_clear_cpu_buffers();
+
 	if (!current_set_polling_and_test()) {
 		const void *addr = &current_thread_info()->flags;
 
 		alternative_input("", "clflush (%[addr])", X86_BUG_CLFLUSH_MONITOR, [addr] "a" (addr));
 		__monitor(addr, 0, 0);
-		if (!need_resched()) {
-			__sti_mwait(0, 0);
-			raw_local_irq_disable();
-		}
+		if (need_resched())
+			goto out;
+
+		__sti_mwait(0, 0);
+		raw_local_irq_disable();
 	}
+
+out:
 	__current_clr_polling();
 }
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index c92e43f2d0c4..02196db26a08 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -814,6 +814,7 @@ void kvm_set_cpu_caps(void)
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
 		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
+		F(VERW_CLEAR) |
 		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */ |
 		F(WRMSR_XX_BASE_NS)
 	);
@@ -826,6 +827,10 @@ void kvm_set_cpu_caps(void)
 		F(PERFMON_V2)
 	);
 
+	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0021_ECX,
+		F(TSA_SQ_NO) | F(TSA_L1_NO)
+	);
+
 	/*
 	 * Synthesize "LFENCE is serializing" into the AMD-defined entry in
 	 * KVM's supported CPUID if the feature is reported as supported by the
@@ -1376,8 +1381,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 		break;
 	case 0x80000021:
-		entry->ebx = entry->ecx = entry->edx = 0;
+		entry->ebx = entry->edx = 0;
 		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
+		cpuid_entry_override(entry, CPUID_8000_0021_ECX);
 		break;
 	/* AMD Extended Performance Monitoring and Debug */
 	case 0x80000022: {
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 0d17d6b70639..0ea847b82354 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -18,6 +18,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_8000_0022_EAX,
 	CPUID_7_2_EDX,
 	CPUID_24_0_EBX,
+	CPUID_8000_0021_ECX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
@@ -68,6 +69,10 @@ enum kvm_only_cpuid_leafs {
 /* CPUID level 0x80000022 (EAX) */
 #define KVM_X86_FEATURE_PERFMON_V2	KVM_X86_FEATURE(CPUID_8000_0022_EAX, 0)
 
+/* CPUID level 0x80000021 (ECX) */
+#define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
+#define KVM_X86_FEATURE_TSA_L1_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
+
 struct cpuid_reg {
 	u32 function;
 	u32 index;
@@ -98,6 +103,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_8000_0022_EAX] = {0x80000022, 0, CPUID_EAX},
 	[CPUID_7_2_EDX]       = {         7, 2, CPUID_EDX},
 	[CPUID_24_0_EBX]      = {      0x24, 0, CPUID_EBX},
+	[CPUID_8000_0021_ECX] = {0x80000021, 0, CPUID_ECX},
 };
 
 /*
@@ -137,6 +143,8 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
 	KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
 	KVM_X86_TRANSLATE_FEATURE(BHI_CTRL);
+	KVM_X86_TRANSLATE_FEATURE(TSA_SQ_NO);
+	KVM_X86_TRANSLATE_FEATURE(TSA_L1_NO);
 	default:
 		return x86_feature;
 	}
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 0c61153b275f..235c4af6b692 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -169,6 +169,9 @@ SYM_FUNC_START(__svm_vcpu_run)
 #endif
 	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
 
+	/* Clobbers EFLAGS.ZF */
+	VM_CLEAR_CPU_BUFFERS
+
 	/* Enter guest mode */
 3:	vmrun %_ASM_AX
 4:
@@ -335,6 +338,9 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	mov SVM_current_vmcb(%rdi), %rax
 	mov KVM_VMCB_pa(%rax), %rax
 
+	/* Clobbers EFLAGS.ZF */
+	VM_CLEAR_CPU_BUFFERS
+
 	/* Enter guest mode */
 1:	vmrun %rax
 2:
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index bcbedddacc48..029fbf3791f1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7313,7 +7313,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 		vmx_l1d_flush(vcpu);
 	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
 		 kvm_arch_has_assigned_device(vcpu->kvm))
-		mds_clear_cpu_buffers();
+		x86_clear_cpu_buffers();
 
 	vmx_disable_fb_clear(vmx);
 
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index e809c2aed78a..a232746d150a 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -483,6 +483,13 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
 		return_ACPI_STATUS(AE_NULL_OBJECT);
 	}
 
+	if (this_walk_state->num_operands < obj_desc->method.param_count) {
+		ACPI_ERROR((AE_INFO, "Missing argument for method [%4.4s]",
+			    acpi_ut_get_node_name(method_node)));
+
+		return_ACPI_STATUS(AE_AML_UNINITIALIZED_ARG);
+	}
+
 	/* Init for new method, possibly wait on method mutex */
 
 	status =
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 78db38c7076e..125d7df8f30a 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -803,7 +803,13 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_thermal_aml_dependency_fix(tz);
 
-	/* Get trip points [_CRT, _PSV, etc.] (required). */
+	/*
+	 * Set the cooling mode [_SCP] to active cooling. This needs to happen before
+	 * we retrieve the trip point values.
+	 */
+	acpi_execute_simple_method(tz->device->handle, "_SCP", ACPI_THERMAL_MODE_ACTIVE);
+
+	/* Get trip points [_ACi, _PSV, etc.] (required). */
 	acpi_thermal_get_trip_points(tz);
 
 	crit_temp = acpi_thermal_get_critical_trip(tz);
@@ -814,10 +820,6 @@ static int acpi_thermal_add(struct acpi_device *device)
 	if (result)
 		goto free_memory;
 
-	/* Set the cooling mode [_SCP] to active cooling. */
-	acpi_execute_simple_method(tz->device->handle, "_SCP",
-				   ACPI_THERMAL_MODE_ACTIVE);
-
 	/* Determine the default polling frequency [_TZP]. */
 	if (tzp)
 		tz->polling_frequency = tzp;
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index d36e71f475ab..39a350755a1b 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -514,15 +514,19 @@ unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
 EXPORT_SYMBOL_GPL(ata_acpi_gtm_xfermask);
 
 /**
- * ata_acpi_cbl_80wire		-	Check for 80 wire cable
+ * ata_acpi_cbl_pata_type - Return PATA cable type
  * @ap: Port to check
- * @gtm: GTM data to use
  *
- * Return 1 if the @gtm indicates the BIOS selected an 80wire mode.
+ * Return ATA_CBL_PATA* according to the transfer mode selected by BIOS
  */
-int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
+int ata_acpi_cbl_pata_type(struct ata_port *ap)
 {
 	struct ata_device *dev;
+	int ret = ATA_CBL_PATA_UNK;
+	const struct ata_acpi_gtm *gtm = ata_acpi_init_gtm(ap);
+
+	if (!gtm)
+		return ATA_CBL_PATA40;
 
 	ata_for_each_dev(dev, &ap->link, ENABLED) {
 		unsigned int xfer_mask, udma_mask;
@@ -530,13 +534,17 @@ int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
 		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
 		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
 
-		if (udma_mask & ~ATA_UDMA_MASK_40C)
-			return 1;
+		ret = ATA_CBL_PATA40;
+
+		if (udma_mask & ~ATA_UDMA_MASK_40C) {
+			ret = ATA_CBL_PATA80;
+			break;
+		}
 	}
 
-	return 0;
+	return ret;
 }
-EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
+EXPORT_SYMBOL_GPL(ata_acpi_cbl_pata_type);
 
 static void ata_acpi_gtf_to_tf(struct ata_device *dev,
 			       const struct ata_acpi_gtf *gtf,
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index b811efd2cc34..73e81e160c91 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -27,7 +27,7 @@
 #include <scsi/scsi_host.h>
 #include <linux/dmi.h>
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86) && defined(CONFIG_X86_32)
 #include <asm/msr.h>
 static int use_msr;
 module_param_named(msr, use_msr, int, 0644);
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index d82728a01832..bb80e7800dcb 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -201,11 +201,9 @@ static int via_cable_detect(struct ata_port *ap) {
 	   two drives */
 	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
 		return ATA_CBL_PATA80;
+
 	/* Check with ACPI so we can spot BIOS reported SATA bridges */
-	if (ata_acpi_init_gtm(ap) &&
-	    ata_acpi_cbl_80wire(ap, ata_acpi_init_gtm(ap)))
-		return ATA_CBL_PATA80;
-	return ATA_CBL_PATA40;
+	return ata_acpi_cbl_pata_type(ap);
 }
 
 static int via_pre_reset(struct ata_link *link, unsigned long deadline)
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index d88f721cf68c..02870e70ed59 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -600,6 +600,7 @@ CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
 CPU_SHOW_VULN_FALLBACK(gds);
 CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
 CPU_SHOW_VULN_FALLBACK(indirect_target_selection);
+CPU_SHOW_VULN_FALLBACK(tsa);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -616,6 +617,7 @@ static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NU
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 static DEVICE_ATTR(indirect_target_selection, 0444, cpu_show_indirect_target_selection, NULL);
+static DEVICE_ATTR(tsa, 0444, cpu_show_tsa, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -633,6 +635,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_reg_file_data_sampling.attr,
 	&dev_attr_indirect_target_selection.attr,
+	&dev_attr_tsa.attr,
 	NULL
 };
 
diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
index 749ae1246f4c..d35caa3c69e1 100644
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -80,6 +80,7 @@ enum {
 	DEVFL_NEWSIZE = (1<<6),	/* need to update dev size in block layer */
 	DEVFL_FREEING = (1<<7),	/* set when device is being cleaned up */
 	DEVFL_FREED = (1<<8),	/* device has been cleaned up */
+	DEVFL_DEAD = (1<<9),	/* device has timed out of aoe_deadsecs */
 };
 
 enum {
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 92b06d1de4cc..6c94cfd1c480 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -754,7 +754,7 @@ rexmit_timer(struct timer_list *timer)
 
 	utgts = count_targets(d, NULL);
 
-	if (d->flags & DEVFL_TKILL) {
+	if (d->flags & (DEVFL_TKILL | DEVFL_DEAD)) {
 		spin_unlock_irqrestore(&d->lock, flags);
 		return;
 	}
@@ -786,7 +786,8 @@ rexmit_timer(struct timer_list *timer)
 			 * to clean up.
 			 */
 			list_splice(&flist, &d->factive[0]);
-			aoedev_downdev(d);
+			d->flags |= DEVFL_DEAD;
+			queue_work(aoe_wq, &d->work);
 			goto out;
 		}
 
@@ -898,6 +899,9 @@ aoecmd_sleepwork(struct work_struct *work)
 {
 	struct aoedev *d = container_of(work, struct aoedev, work);
 
+	if (d->flags & DEVFL_DEAD)
+		aoedev_downdev(d);
+
 	if (d->flags & DEVFL_GDALLOC)
 		aoeblk_gdalloc(d);
 
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 280679bde3a5..4240e11adfb7 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -200,8 +200,11 @@ aoedev_downdev(struct aoedev *d)
 	struct list_head *head, *pos, *nx;
 	struct request *rq, *rqnext;
 	int i;
+	unsigned long flags;
 
-	d->flags &= ~DEVFL_UP;
+	spin_lock_irqsave(&d->lock, flags);
+	d->flags &= ~(DEVFL_UP | DEVFL_DEAD);
+	spin_unlock_irqrestore(&d->lock, flags);
 
 	/* clean out active and to-be-retransmitted buffers */
 	for (i = 0; i < NFACTIVE; i++) {
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index e1f60f0f507c..df2728cccf8b 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1126,8 +1126,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 			struct idxd_wq *wq,
 			dma_addr_t src_addr, unsigned int slen,
 			dma_addr_t dst_addr, unsigned int *dlen,
-			u32 *compression_crc,
-			bool disable_async)
+			u32 *compression_crc)
 {
 	struct iaa_device_compression_mode *active_compression_mode;
 	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
@@ -1170,7 +1169,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	desc->src2_size = sizeof(struct aecs_comp_table_record);
 	desc->completion_addr = idxd_desc->compl_dma;
 
-	if (ctx->use_irq && !disable_async) {
+	if (ctx->use_irq) {
 		desc->flags |= IDXD_OP_FLAG_RCI;
 
 		idxd_desc->crypto.req = req;
@@ -1183,8 +1182,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 			" src_addr %llx, dst_addr %llx\n", __func__,
 			active_compression_mode->name,
 			src_addr, dst_addr);
-	} else if (ctx->async_mode && !disable_async)
-		req->base.data = idxd_desc;
+	}
 
 	dev_dbg(dev, "%s: compression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
@@ -1204,7 +1202,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	update_total_comp_calls();
 	update_wq_comp_calls(wq);
 
-	if (ctx->async_mode && !disable_async) {
+	if (ctx->async_mode) {
 		ret = -EINPROGRESS;
 		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
 		goto out;
@@ -1224,7 +1222,7 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 
 	*compression_crc = idxd_desc->iax_completion->crc;
 
-	if (!ctx->async_mode || disable_async)
+	if (!ctx->async_mode)
 		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
@@ -1421,8 +1419,7 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 			" src_addr %llx, dst_addr %llx\n", __func__,
 			active_compression_mode->name,
 			src_addr, dst_addr);
-	} else if (ctx->async_mode && !disable_async)
-		req->base.data = idxd_desc;
+	}
 
 	dev_dbg(dev, "%s: decompression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
@@ -1490,13 +1487,11 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	struct iaa_compression_ctx *compression_ctx;
 	struct crypto_tfm *tfm = req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
-	bool disable_async = false;
 	int nr_sgs, cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	u32 compression_crc;
 	struct idxd_wq *wq;
 	struct device *dev;
-	int order = -1;
 
 	compression_ctx = crypto_tfm_ctx(tfm);
 
@@ -1526,21 +1521,6 @@ static int iaa_comp_acompress(struct acomp_req *req)
 
 	iaa_wq = idxd_wq_get_private(wq);
 
-	if (!req->dst) {
-		gfp_t flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
-
-		/* incompressible data will always be < 2 * slen */
-		req->dlen = 2 * req->slen;
-		order = order_base_2(round_up(req->dlen, PAGE_SIZE) / PAGE_SIZE);
-		req->dst = sgl_alloc_order(req->dlen, order, false, flags, NULL);
-		if (!req->dst) {
-			ret = -ENOMEM;
-			order = -1;
-			goto out;
-		}
-		disable_async = true;
-	}
-
 	dev = &wq->idxd->pdev->dev;
 
 	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
@@ -1570,7 +1550,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
 	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
-			   &req->dlen, &compression_crc, disable_async);
+			   &req->dlen, &compression_crc);
 	if (ret == -EINPROGRESS)
 		return ret;
 
@@ -1601,100 +1581,6 @@ static int iaa_comp_acompress(struct acomp_req *req)
 out:
 	iaa_wq_put(wq);
 
-	if (order >= 0)
-		sgl_free_order(req->dst, order);
-
-	return ret;
-}
-
-static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
-{
-	gfp_t flags = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
-		GFP_KERNEL : GFP_ATOMIC;
-	struct crypto_tfm *tfm = req->base.tfm;
-	dma_addr_t src_addr, dst_addr;
-	int nr_sgs, cpu, ret = 0;
-	struct iaa_wq *iaa_wq;
-	struct device *dev;
-	struct idxd_wq *wq;
-	int order = -1;
-
-	cpu = get_cpu();
-	wq = wq_table_next_wq(cpu);
-	put_cpu();
-	if (!wq) {
-		pr_debug("no wq configured for cpu=%d\n", cpu);
-		return -ENODEV;
-	}
-
-	ret = iaa_wq_get(wq);
-	if (ret) {
-		pr_debug("no wq available for cpu=%d\n", cpu);
-		return -ENODEV;
-	}
-
-	iaa_wq = idxd_wq_get_private(wq);
-
-	dev = &wq->idxd->pdev->dev;
-
-	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto out;
-	}
-	src_addr = sg_dma_address(req->src);
-	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
-		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
-		req->src, req->slen, sg_dma_len(req->src));
-
-	req->dlen = 4 * req->slen; /* start with ~avg comp rato */
-alloc_dest:
-	order = order_base_2(round_up(req->dlen, PAGE_SIZE) / PAGE_SIZE);
-	req->dst = sgl_alloc_order(req->dlen, order, false, flags, NULL);
-	if (!req->dst) {
-		ret = -ENOMEM;
-		order = -1;
-		goto out;
-	}
-
-	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto err_map_dst;
-	}
-
-	dst_addr = sg_dma_address(req->dst);
-	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
-		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
-		req->dst, req->dlen, sg_dma_len(req->dst));
-	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
-			     dst_addr, &req->dlen, true);
-	if (ret == -EOVERFLOW) {
-		dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-		req->dlen *= 2;
-		if (req->dlen > CRYPTO_ACOMP_DST_MAX)
-			goto err_map_dst;
-		goto alloc_dest;
-	}
-
-	if (ret != 0)
-		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
-
-	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-err_map_dst:
-	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-out:
-	iaa_wq_put(wq);
-
-	if (order >= 0)
-		sgl_free_order(req->dst, order);
-
 	return ret;
 }
 
@@ -1717,9 +1603,6 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 		return -EINVAL;
 	}
 
-	if (!req->dst)
-		return iaa_comp_adecompress_alloc_dest(req);
-
 	cpu = get_cpu();
 	wq = wq_table_next_wq(cpu);
 	put_cpu();
@@ -1800,19 +1683,10 @@ static int iaa_comp_init_fixed(struct crypto_acomp *acomp_tfm)
 	return 0;
 }
 
-static void dst_free(struct scatterlist *sgl)
-{
-	/*
-	 * Called for req->dst = NULL cases but we free elsewhere
-	 * using sgl_free_order().
-	 */
-}
-
 static struct acomp_alg iaa_acomp_fixed_deflate = {
 	.init			= iaa_comp_init_fixed,
 	.compress		= iaa_comp_acompress,
 	.decompress		= iaa_comp_adecompress,
-	.dst_free               = dst_free,
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "deflate-iaa",
diff --git a/drivers/crypto/xilinx/zynqmp-sha.c b/drivers/crypto/xilinx/zynqmp-sha.c
index 1bcec6f46c9c..9b5345068604 100644
--- a/drivers/crypto/xilinx/zynqmp-sha.c
+++ b/drivers/crypto/xilinx/zynqmp-sha.c
@@ -3,18 +3,19 @@
  * Xilinx ZynqMP SHA Driver.
  * Copyright (c) 2022 Xilinx Inc.
  */
-#include <linux/cacheflush.h>
 #include <crypto/hash.h>
 #include <crypto/internal/hash.h>
 #include <crypto/sha3.h>
-#include <linux/crypto.h>
+#include <linux/cacheflush.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/err.h>
 #include <linux/firmware/xlnx-zynqmp.h>
-#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 #include <linux/platform_device.h>
 
 #define ZYNQMP_DMA_BIT_MASK		32U
@@ -43,6 +44,8 @@ struct zynqmp_sha_desc_ctx {
 static dma_addr_t update_dma_addr, final_dma_addr;
 static char *ubuf, *fbuf;
 
+static DEFINE_SPINLOCK(zynqmp_sha_lock);
+
 static int zynqmp_sha_init_tfm(struct crypto_shash *hash)
 {
 	const char *fallback_driver_name = crypto_shash_alg_name(hash);
@@ -124,7 +127,8 @@ static int zynqmp_sha_export(struct shash_desc *desc, void *out)
 	return crypto_shash_export(&dctx->fbk_req, out);
 }
 
-static int zynqmp_sha_digest(struct shash_desc *desc, const u8 *data, unsigned int len, u8 *out)
+static int __zynqmp_sha_digest(struct shash_desc *desc, const u8 *data,
+			       unsigned int len, u8 *out)
 {
 	unsigned int remaining_len = len;
 	int update_size;
@@ -159,6 +163,12 @@ static int zynqmp_sha_digest(struct shash_desc *desc, const u8 *data, unsigned i
 	return ret;
 }
 
+static int zynqmp_sha_digest(struct shash_desc *desc, const u8 *data, unsigned int len, u8 *out)
+{
+	scoped_guard(spinlock_bh, &zynqmp_sha_lock)
+		return __zynqmp_sha_digest(desc, data, len, out);
+}
+
 static struct zynqmp_sha_drv_ctx sha3_drv_ctx = {
 	.sha3_384 = {
 		.init = zynqmp_sha_init,
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index b1ef4546346d..bea3e9858aca 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -685,11 +685,13 @@ long dma_resv_wait_timeout(struct dma_resv *obj, enum dma_resv_usage usage,
 	dma_resv_iter_begin(&cursor, obj, usage);
 	dma_resv_for_each_fence_unlocked(&cursor, fence) {
 
-		ret = dma_fence_wait_timeout(fence, intr, ret);
-		if (ret <= 0) {
-			dma_resv_iter_end(&cursor);
-			return ret;
-		}
+		ret = dma_fence_wait_timeout(fence, intr, timeout);
+		if (ret <= 0)
+			break;
+
+		/* Even for zero timeout the return value is 1 */
+		if (timeout)
+			timeout = ret;
 	}
 	dma_resv_iter_end(&cursor);
 
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 47751b2c057a..83dad9c2da06 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -110,7 +110,7 @@ struct ffa_drv_info {
 	struct work_struct sched_recv_irq_work;
 	struct xarray partition_info;
 	DECLARE_HASHTABLE(notifier_hash, ilog2(FFA_MAX_NOTIFICATIONS));
-	struct mutex notify_lock; /* lock to protect notifier hashtable  */
+	rwlock_t notify_lock; /* lock to protect notifier hashtable  */
 };
 
 static struct ffa_drv_info *drv_info;
@@ -1141,12 +1141,11 @@ notifier_hash_node_get(u16 notify_id, enum notify_type type)
 	return NULL;
 }
 
-static int
-update_notifier_cb(int notify_id, enum notify_type type, ffa_notifier_cb cb,
-		   void *cb_data, bool is_registration)
+static int update_notifier_cb(int notify_id, enum notify_type type,
+			      struct notifier_cb_info *cb)
 {
 	struct notifier_cb_info *cb_info = NULL;
-	bool cb_found;
+	bool cb_found, is_registration = !!cb;
 
 	cb_info = notifier_hash_node_get(notify_id, type);
 	cb_found = !!cb_info;
@@ -1155,17 +1154,10 @@ update_notifier_cb(int notify_id, enum notify_type type, ffa_notifier_cb cb,
 		return -EINVAL;
 
 	if (is_registration) {
-		cb_info = kzalloc(sizeof(*cb_info), GFP_KERNEL);
-		if (!cb_info)
-			return -ENOMEM;
-
-		cb_info->type = type;
-		cb_info->cb = cb;
-		cb_info->cb_data = cb_data;
-
-		hash_add(drv_info->notifier_hash, &cb_info->hnode, notify_id);
+		hash_add(drv_info->notifier_hash, &cb->hnode, notify_id);
 	} else {
 		hash_del(&cb_info->hnode);
+		kfree(cb_info);
 	}
 
 	return 0;
@@ -1190,18 +1182,18 @@ static int ffa_notify_relinquish(struct ffa_device *dev, int notify_id)
 	if (notify_id >= FFA_MAX_NOTIFICATIONS)
 		return -EINVAL;
 
-	mutex_lock(&drv_info->notify_lock);
+	write_lock(&drv_info->notify_lock);
 
-	rc = update_notifier_cb(notify_id, type, NULL, NULL, false);
+	rc = update_notifier_cb(notify_id, type, NULL);
 	if (rc) {
 		pr_err("Could not unregister notification callback\n");
-		mutex_unlock(&drv_info->notify_lock);
+		write_unlock(&drv_info->notify_lock);
 		return rc;
 	}
 
 	rc = ffa_notification_unbind(dev->vm_id, BIT(notify_id));
 
-	mutex_unlock(&drv_info->notify_lock);
+	write_unlock(&drv_info->notify_lock);
 
 	return rc;
 }
@@ -1211,6 +1203,7 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 {
 	int rc;
 	u32 flags = 0;
+	struct notifier_cb_info *cb_info = NULL;
 	enum notify_type type = ffa_notify_type_get(dev->vm_id);
 
 	if (ffa_notifications_disabled())
@@ -1219,24 +1212,34 @@ static int ffa_notify_request(struct ffa_device *dev, bool is_per_vcpu,
 	if (notify_id >= FFA_MAX_NOTIFICATIONS)
 		return -EINVAL;
 
-	mutex_lock(&drv_info->notify_lock);
+	cb_info = kzalloc(sizeof(*cb_info), GFP_KERNEL);
+	if (!cb_info)
+		return -ENOMEM;
+
+	cb_info->type = type;
+	cb_info->cb_data = cb_data;
+	cb_info->cb = cb;
+
+	write_lock(&drv_info->notify_lock);
 
 	if (is_per_vcpu)
 		flags = PER_VCPU_NOTIFICATION_FLAG;
 
 	rc = ffa_notification_bind(dev->vm_id, BIT(notify_id), flags);
-	if (rc) {
-		mutex_unlock(&drv_info->notify_lock);
-		return rc;
-	}
+	if (rc)
+		goto out_unlock_free;
 
-	rc = update_notifier_cb(notify_id, type, cb, cb_data, true);
+	rc = update_notifier_cb(notify_id, type, cb_info);
 	if (rc) {
 		pr_err("Failed to register callback for %d - %d\n",
 		       notify_id, rc);
 		ffa_notification_unbind(dev->vm_id, BIT(notify_id));
 	}
-	mutex_unlock(&drv_info->notify_lock);
+
+out_unlock_free:
+	write_unlock(&drv_info->notify_lock);
+	if (rc)
+		kfree(cb_info);
 
 	return rc;
 }
@@ -1266,9 +1269,9 @@ static void handle_notif_callbacks(u64 bitmap, enum notify_type type)
 		if (!(bitmap & 1))
 			continue;
 
-		mutex_lock(&drv_info->notify_lock);
+		read_lock(&drv_info->notify_lock);
 		cb_info = notifier_hash_node_get(notify_id, type);
-		mutex_unlock(&drv_info->notify_lock);
+		read_unlock(&drv_info->notify_lock);
 
 		if (cb_info && cb_info->cb)
 			cb_info->cb(notify_id, cb_info->cb_data);
@@ -1718,7 +1721,7 @@ static void ffa_notifications_setup(void)
 		goto cleanup;
 
 	hash_init(drv_info->notifier_hash);
-	mutex_init(&drv_info->notify_lock);
+	rwlock_init(&drv_info->notify_lock);
 
 	drv_info->notif_enabled = true;
 	return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 7d4b540340e0..41b88e0ea98b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -860,7 +860,9 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to map legacy queue\n");
 
@@ -883,7 +885,9 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	queue_input.trail_fence_addr = gpu_addr;
 	queue_input.trail_fence_data = seq;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to unmap legacy queue\n");
 
@@ -910,7 +914,9 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device *adev,
 	queue_input.vmid = vmid;
 	queue_input.use_mmio = use_mmio;
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->reset_legacy_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to reset legacy queue\n");
 
@@ -931,7 +937,9 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to read reg (0x%x)\n", reg);
 	else
@@ -957,7 +965,9 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to write reg (0x%x)\n", reg);
 
@@ -984,7 +994,9 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to reg_write_reg_wait\n");
 
@@ -1009,7 +1021,9 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 		goto error;
 	}
 
+	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
+	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to reg_write_reg_wait\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 48e30e5f8338..3d42f6c3308e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3430,7 +3430,10 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 	uint8_t *ucode_array_start_addr;
 	int err = 0;
 
-	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_sos.bin", chip_name);
+	if (amdgpu_is_kicker_fw(adev))
+		err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_sos_kicker.bin", chip_name);
+	else
+		err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_sos.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3672,7 +3675,10 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 	struct amdgpu_device *adev = psp->adev;
 	int err;
 
-	err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, "amdgpu/%s_ta.bin", chip_name);
+	if (amdgpu_is_kicker_fw(adev))
+		err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, "amdgpu/%s_ta_kicker.bin", chip_name);
+	else
+		err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, "amdgpu/%s_ta.bin", chip_name);
 	if (err)
 		return err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1f06b22dbe7c..96e5c520af31 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -84,6 +84,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_rlc_1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_pfp.bin");
@@ -734,6 +735,9 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 		    adev->pdev->revision == 0xCE)
 			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
 						   "amdgpu/gc_11_0_0_rlc_1.bin");
+		else if (amdgpu_is_kicker_fw(adev))
+			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+						   "amdgpu/%s_rlc_kicker.bin", ucode_prefix);
 		else
 			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
 						   "amdgpu/%s_rlc.bin", ucode_prefix);
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index d4f72e47ae9e..c4f5cbf1ecd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -32,6 +32,7 @@
 #include "gc/gc_11_0_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
@@ -50,7 +51,10 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 	DRM_DEBUG("\n");
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
+	if (amdgpu_is_kicker_fw(adev))
+		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu_kicker.bin", ucode_prefix);
+	else
+		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index bf00de763acb..124f74e862d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -42,7 +42,9 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta_kicker.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_sos.bin");
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
new file mode 100644
index 000000000000..cdefd7fcb0da
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -0,0 +1,1624 @@
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_vcn.h"
+#include "amdgpu_pm.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "soc15_hw_ip.h"
+#include "vcn_v2_0.h"
+#include "vcn_v4_0_3.h"
+#include "mmsch_v5_0.h"
+
+#include "vcn/vcn_5_0_0_offset.h"
+#include "vcn/vcn_5_0_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+#include "vcn_v5_0_0.h"
+#include "vcn_v5_0_1.h"
+
+#include <drm/drm_drv.h>
+
+static int vcn_v5_0_1_start_sriov(struct amdgpu_device *adev);
+static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
+static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state);
+static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
+static void vcn_v5_0_1_set_ras_funcs(struct amdgpu_device *adev);
+/**
+ * vcn_v5_0_1_early_init - set function pointers and load microcode
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Set ring and irq function pointers
+ * Load microcode from filesystem
+ */
+static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, r;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		/* re-use enc ring as unified ring */
+		adev->vcn.inst[i].num_enc_rings = 1;
+
+	vcn_v5_0_1_set_unified_ring_funcs(adev);
+	vcn_v5_0_1_set_irq_funcs(adev);
+	vcn_v5_0_1_set_ras_funcs(adev);
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].set_pg_state = vcn_v5_0_1_set_pg_state;
+
+		r = amdgpu_vcn_early_init(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static void vcn_v5_0_1_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
+{
+	struct amdgpu_vcn5_fw_shared *fw_shared;
+
+	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+
+	if (fw_shared->sq.is_enabled)
+		return;
+	fw_shared->present_flag_0 =
+		cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
+	fw_shared->sq.is_enabled = 1;
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
+}
+
+/**
+ * vcn_v5_0_1_sw_init - sw init for VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Load firmware and sw initialization
+ */
+static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring;
+	int i, r, vcn_inst;
+
+	/* VCN UNIFIED TRAP */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
+	if (r)
+		return r;
+
+	/* VCN POISON TRAP */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_5_0__SRCID_UVD_POISON, &adev->vcn.inst->ras_poison_irq);
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		vcn_inst = GET_INST(VCN, i);
+
+		r = amdgpu_vcn_sw_init(adev, i);
+		if (r)
+			return r;
+
+		amdgpu_vcn_setup_ucode(adev, i);
+
+		r = amdgpu_vcn_resume(adev, i);
+		if (r)
+			return r;
+
+		ring = &adev->vcn.inst[i].ring_enc[0];
+		ring->use_doorbell = true;
+		if (!amdgpu_sriov_vf(adev))
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				11 * vcn_inst;
+		else
+			ring->doorbell_index =
+				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+				32 * vcn_inst;
+
+		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
+		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
+
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
+					AMDGPU_RING_PRIO_DEFAULT, &adev->vcn.inst[i].sched_score);
+		if (r)
+			return r;
+
+		vcn_v5_0_1_fw_shared_init(adev, i);
+	}
+
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_alloc_mm_table(adev);
+		if (r)
+			return r;
+	}
+
+	vcn_v5_0_0_alloc_ip_dump(adev);
+
+	return amdgpu_vcn_sysfs_reset_mask_init(adev);
+}
+
+/**
+ * vcn_v5_0_1_sw_fini - sw fini for VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * VCN suspend and free up sw allocation
+ */
+static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, r, idx;
+
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+
+			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+			fw_shared->present_flag_0 = 0;
+			fw_shared->sq.is_enabled = 0;
+		}
+
+		drm_dev_exit(idx);
+	}
+
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_free_mm_table(adev);
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(adev, i);
+		if (r)
+			return r;
+	}
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_sw_fini(adev, i);
+		if (r)
+			return r;
+	}
+
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
+	kfree(adev->vcn.ip_dump);
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_1_hw_init - start and test VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Initialize the hardware, boot up the VCPU and do some testing
+ */
+static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring;
+	int i, r, vcn_inst;
+
+	if (amdgpu_sriov_vf(adev)) {
+		r = vcn_v5_0_1_start_sriov(adev);
+		if (r)
+			return r;
+
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			ring = &adev->vcn.inst[i].ring_enc[0];
+			ring->wptr = 0;
+			ring->wptr_old = 0;
+			vcn_v5_0_1_unified_ring_set_wptr(ring);
+			ring->sched.ready = true;
+		}
+	} else {
+		if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+			adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
+		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+			vcn_inst = GET_INST(VCN, i);
+			ring = &adev->vcn.inst[i].ring_enc[0];
+
+			if (ring->use_doorbell)
+				adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
+					11 * vcn_inst),
+					adev->vcn.inst[i].aid_id);
+
+			/* Re-init fw_shared, if required */
+			vcn_v5_0_1_fw_shared_init(adev, i);
+
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_1_hw_fini - stop the hardware block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Stop the VCN block, mark ring as not ready any more
+ */
+static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		if (vinst->cur_state != AMD_PG_STATE_GATE)
+			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
+	}
+
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		amdgpu_irq_put(adev, &adev->vcn.inst->ras_poison_irq, 0);
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_1_suspend - suspend VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * HW fini and suspend VCN block
+ */
+static int vcn_v5_0_1_suspend(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r, i;
+
+	r = vcn_v5_0_1_hw_fini(ip_block);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		r = amdgpu_vcn_suspend(ip_block->adev, i);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+/**
+ * vcn_v5_0_1_resume - resume VCN block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Resume firmware and hw init VCN block
+ */
+static int vcn_v5_0_1_resume(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		if (amdgpu_in_reset(adev))
+			vinst->cur_state = AMD_PG_STATE_GATE;
+
+		r = amdgpu_vcn_resume(ip_block->adev, i);
+		if (r)
+			return r;
+	}
+
+	r = vcn_v5_0_1_hw_init(ip_block);
+
+	return r;
+}
+
+/**
+ * vcn_v5_0_1_mc_resume - memory controller programming
+ *
+ * @vinst: VCN instance
+ *
+ * Let the VCN memory controller know it's offsets
+ */
+static void vcn_v5_0_1_mc_resume(struct amdgpu_vcn_inst *vinst)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int inst = vinst->inst;
+	uint32_t offset, size, vcn_inst;
+	const struct common_firmware_header *hdr;
+
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
+	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
+
+	vcn_inst = GET_INST(VCN, inst);
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst].tmr_mc_addr_lo));
+		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst].tmr_mc_addr_hi));
+		WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_OFFSET0, 0);
+		offset = 0;
+	} else {
+		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			lower_32_bits(adev->vcn.inst[inst].gpu_addr));
+		WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			upper_32_bits(adev->vcn.inst[inst].gpu_addr));
+		offset = size;
+		WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_OFFSET0,
+				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
+	}
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_SIZE0, size);
+
+	/* cache window 1: stack */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].gpu_addr + offset));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].gpu_addr + offset));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_OFFSET1, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
+
+	/* cache window 2: context */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_OFFSET2, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
+
+	/* non-cache window */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_OFFSET0, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_VCPU_NONCACHE_SIZE0,
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)));
+}
+
+/**
+ * vcn_v5_0_1_mc_resume_dpg_mode - memory controller programming for dpg mode
+ *
+ * @vinst: VCN instance
+ * @indirect: indirectly write sram
+ *
+ * Let the VCN memory controller know it's offsets with dpg mode
+ */
+static void vcn_v5_0_1_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
+	uint32_t offset, size;
+	const struct common_firmware_header *hdr;
+
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
+	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
+
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (!indirect) {
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN +
+				 inst_idx].tmr_mc_addr_lo), 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN +
+				 inst_idx].tmr_mc_addr_hi), 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		} else {
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
+			WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+				VCN, 0, regUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		}
+		offset = 0;
+	} else {
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		offset = size;
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
+			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
+	}
+
+	if (!indirect)
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+	else
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
+
+	/* cache window 1: stack */
+	if (!indirect) {
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+	} else {
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
+		WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+	}
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+			VCN, 0, regUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
+
+	/* cache window 2: context */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset +
+			AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset +
+			AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
+
+	/* non-cache window */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].fw_shared.gpu_addr), 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_NONCACHE_SIZE0),
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared)), 0, indirect);
+
+	/* VCN global tiling registers */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+}
+
+/**
+ * vcn_v5_0_1_disable_clock_gating - disable VCN clock gating
+ *
+ * @vinst: VCN instance
+ *
+ * Disable clock gating for VCN block
+ */
+static void vcn_v5_0_1_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
+{
+}
+
+/**
+ * vcn_v5_0_1_enable_clock_gating - enable VCN clock gating
+ *
+ * @vinst: VCN instance
+ *
+ * Enable clock gating for VCN block
+ */
+static void vcn_v5_0_1_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
+{
+}
+
+/**
+ * vcn_v5_0_1_pause_dpg_mode - VCN pause with dpg mode
+ *
+ * @vinst: VCN instance
+ * @new_state: pause state
+ *
+ * Pause dpg mode for VCN block
+ */
+static int vcn_v5_0_1_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	uint32_t reg_data = 0;
+	int vcn_inst;
+
+	vcn_inst = GET_INST(VCN, vinst->inst);
+
+	/* pause/unpause if state is changed */
+	if (vinst->pause_state.fw_based != new_state->fw_based) {
+		DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -> %d %s\n",
+			vinst->pause_state.fw_based, new_state->fw_based,
+			new_state->fw_based ? "VCN_DPG_STATE__PAUSE" : "VCN_DPG_STATE__UNPAUSE");
+		reg_data = RREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE) &
+			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
+			/* pause DPG */
+			reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
+
+			/* wait for ACK */
+			SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_DPG_PAUSE,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
+					UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+		} else {
+			/* unpause DPG, no need to wait */
+			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE, reg_data);
+		}
+		vinst->pause_state.fw_based = new_state->fw_based;
+	}
+
+	return 0;
+}
+
+
+/**
+ * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode
+ *
+ * @vinst: VCN instance
+ * @indirect: indirectly write sram
+ *
+ * Start VCN block with dpg mode
+ */
+static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared =
+		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
+	struct amdgpu_ring *ring;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__PAUSE};
+	int vcn_inst;
+	uint32_t tmp;
+
+	vcn_inst = GET_INST(VCN, inst_idx);
+
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 1,
+		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* enable dynamic power gating mode */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS);
+	tmp |= UVD_POWER_STATUS__UVD_PG_MODE_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_POWER_STATUS, tmp);
+
+	if (indirect) {
+		adev->vcn.inst[inst_idx].dpg_sram_curr_addr =
+			(uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
+		/* Use dummy register 0xDEADBEEF passing AID selection to PSP FW */
+		WREG32_SOC24_DPG_MODE(inst_idx, 0xDEADBEEF,
+				adev->vcn.inst[inst_idx].aid_id, 0, true);
+	}
+
+	/* enable VCPU clock */
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK | UVD_VCPU_CNTL__BLK_RST_MASK;
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* disable master interrupt */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_MASTINT_EN), 0, 0, indirect);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = (UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		UVD_LMI_CTRL__REQ_MODE_MASK |
+		UVD_LMI_CTRL__CRC_RESET_MASK |
+		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
+		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
+		0x00100000L);
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_CTRL), tmp, 0, indirect);
+
+	vcn_v5_0_1_mc_resume_dpg_mode(vinst, indirect);
+
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* enable LMI MC and UMC channels */
+	tmp = 0x1f << UVD_LMI_CTRL2__RE_OFLD_MIF_WR_REQ_NUM__SHIFT;
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_LMI_CTRL2), tmp, 0, indirect);
+
+	/* enable master interrupt */
+	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
+		VCN, 0, regUVD_MASTINT_EN),
+		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
+
+	if (indirect)
+		amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
+
+	/* resetting ring, fw should not check RB ring */
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+
+	/* Pause dpg */
+	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
+
+	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring->ring_size / sizeof(uint32_t));
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, tmp);
+	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	/* resetting done, fw can check RB ring */
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
+		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		VCN_RB1_DB_CTRL__EN_MASK);
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+
+	return 0;
+}
+
+static int vcn_v5_0_1_start_sriov(struct amdgpu_device *adev)
+{
+	int i, vcn_inst;
+	struct amdgpu_ring *ring_enc;
+	uint64_t cache_addr;
+	uint64_t rb_enc_addr;
+	uint64_t ctx_addr;
+	uint32_t param, resp, expected;
+	uint32_t offset, cache_size;
+	uint32_t tmp, timeout;
+
+	struct amdgpu_mm_table *table = &adev->virt.mm_table;
+	uint32_t *table_loc;
+	uint32_t table_size;
+	uint32_t size, size_dw;
+	uint32_t init_status;
+	uint32_t enabled_vcn;
+
+	struct mmsch_v5_0_cmd_direct_write
+		direct_wt = { {0} };
+	struct mmsch_v5_0_cmd_direct_read_modify_write
+		direct_rd_mod_wt = { {0} };
+	struct mmsch_v5_0_cmd_end end = { {0} };
+	struct mmsch_v5_0_init_header header;
+
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+	volatile struct amdgpu_fw_shared_rb_setup *rb_setup;
+
+	direct_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_WRITE;
+	direct_rd_mod_wt.cmd_header.command_type =
+		MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
+	end.cmd_header.command_type = MMSCH_COMMAND__END;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		vcn_inst = GET_INST(VCN, i);
+
+		vcn_v5_0_1_fw_shared_init(adev, vcn_inst);
+
+		memset(&header, 0, sizeof(struct mmsch_v5_0_init_header));
+		header.version = MMSCH_VERSION;
+		header.total_size = sizeof(struct mmsch_v5_0_init_header) >> 2;
+
+		table_loc = (uint32_t *)table->cpu_addr;
+		table_loc += header.total_size;
+
+		table_size = 0;
+
+		MMSCH_V5_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, 0, regUVD_STATUS),
+			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
+
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
+
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo);
+
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi);
+
+			offset = 0;
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_VCPU_CACHE_OFFSET0), 0);
+		} else {
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				lower_32_bits(adev->vcn.inst[i].gpu_addr));
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				upper_32_bits(adev->vcn.inst[i].gpu_addr));
+			offset = cache_size;
+			MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+				regUVD_VCPU_CACHE_OFFSET0),
+				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
+		}
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE0),
+			cache_size);
+
+		cache_addr = adev->vcn.inst[vcn_inst].gpu_addr + offset;
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), lower_32_bits(cache_addr));
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_OFFSET1), 0);
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE);
+
+		cache_addr = adev->vcn.inst[vcn_inst].gpu_addr + offset +
+			AMDGPU_VCN_STACK_SIZE;
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW), lower_32_bits(cache_addr));
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH), upper_32_bits(cache_addr));
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_OFFSET2), 0);
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE);
+
+		fw_shared = adev->vcn.inst[vcn_inst].fw_shared.cpu_addr;
+		rb_setup = &fw_shared->rb_setup;
+
+		ring_enc = &adev->vcn.inst[vcn_inst].ring_enc[0];
+		ring_enc->wptr = 0;
+		rb_enc_addr = ring_enc->gpu_addr;
+
+		rb_setup->is_rb_enabled_flags |= RB_ENABLED;
+		rb_setup->rb_addr_lo = lower_32_bits(rb_enc_addr);
+		rb_setup->rb_addr_hi = upper_32_bits(rb_enc_addr);
+		rb_setup->rb_size = ring_enc->ring_size / 4;
+		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
+
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[vcn_inst].fw_shared.gpu_addr));
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[vcn_inst].fw_shared.gpu_addr));
+		MMSCH_V5_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
+			regUVD_VCPU_NONCACHE_SIZE0),
+			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
+		MMSCH_V5_0_INSERT_END();
+
+		header.vcn0.init_status = 0;
+		header.vcn0.table_offset = header.total_size;
+		header.vcn0.table_size = table_size;
+		header.total_size += table_size;
+
+		/* Send init table to mmsch */
+		size = sizeof(struct mmsch_v5_0_init_header);
+		table_loc = (uint32_t *)table->cpu_addr;
+		memcpy((void *)table_loc, &header, size);
+
+		ctx_addr = table->gpu_addr;
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_ADDR_LO, lower_32_bits(ctx_addr));
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_ADDR_HI, upper_32_bits(ctx_addr));
+
+		tmp = RREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_VMID);
+		tmp &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
+		tmp |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_VMID, tmp);
+
+		size = header.total_size;
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_CTX_SIZE, size);
+
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_RESP, 0);
+
+		param = 0x00000001;
+		WREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_HOST, param);
+		tmp = 0;
+		timeout = 1000;
+		resp = 0;
+		expected = MMSCH_VF_MAILBOX_RESP__OK;
+		while (resp != expected) {
+			resp = RREG32_SOC15(VCN, vcn_inst, regMMSCH_VF_MAILBOX_RESP);
+			if (resp != 0)
+				break;
+
+			udelay(10);
+			tmp = tmp + 10;
+			if (tmp >= timeout) {
+				DRM_ERROR("failed to init MMSCH. TIME-OUT after %d usec"\
+					" waiting for regMMSCH_VF_MAILBOX_RESP "\
+					"(expected=0x%08x, readback=0x%08x)\n",
+					tmp, expected, resp);
+				return -EBUSY;
+			}
+		}
+
+		enabled_vcn = amdgpu_vcn_is_disabled_vcn(adev, VCN_DECODE_RING, 0) ? 1 : 0;
+		init_status = ((struct mmsch_v5_0_init_header *)(table_loc))->vcn0.init_status;
+		if (resp != expected && resp != MMSCH_VF_MAILBOX_RESP__INCOMPLETE
+					&& init_status != MMSCH_VF_ENGINE_STATUS__PASS) {
+			DRM_ERROR("MMSCH init status is incorrect! readback=0x%08x, header init "\
+				"status for VCN%x: 0x%x\n", resp, enabled_vcn, init_status);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_1_start - VCN start
+ *
+ * @vinst: VCN instance
+ *
+ * Start VCN block
+ */
+static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+	struct amdgpu_ring *ring;
+	uint32_t tmp;
+	int j, k, r, vcn_inst;
+
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v5_0_1_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
+
+	vcn_inst = GET_INST(VCN, i);
+
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL, tmp |
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	vcn_v5_0_1_mc_resume(vinst);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+			if (status & 2)
+				break;
+			mdelay(100);
+			if (amdgpu_emu_mode == 1)
+				msleep(20);
+		}
+
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status & 2) {
+				r = 0;
+				break;
+			}
+		} else {
+			r = 0;
+			if (status & 2)
+				break;
+
+			dev_err(adev->dev,
+				"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
+			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+				 UVD_VCPU_CNTL__BLK_RST_MASK,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+			mdelay(10);
+			r = -1;
+		}
+	}
+
+	if (r) {
+		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
+		return r;
+	}
+
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
+		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+
+	ring = &adev->vcn.inst[i].ring_enc[0];
+
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
+		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		     VCN_RB1_DB_CTRL__EN_MASK);
+
+	/* Read DB_CTRL to flush the write DB_CTRL command. */
+	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO, ring->gpu_addr);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE, ring->ring_size / 4);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, tmp);
+	ring->wptr = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
+	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_1_stop_dpg_mode - VCN stop with dpg mode
+ *
+ * @vinst: VCN instance
+ *
+ * Stop VCN block with dpg mode
+ */
+static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int inst_idx = vinst->inst;
+	uint32_t tmp;
+	int vcn_inst;
+	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
+
+	vcn_inst = GET_INST(VCN, inst_idx);
+
+	/* Unpause dpg */
+	vcn_v5_0_1_pause_dpg_mode(vinst, &state);
+
+	/* Wait for power status to be 1 */
+	SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+
+	/* wait for read ptr to be equal to write ptr */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
+	SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_RB_RPTR, tmp, 0xFFFFFFFF);
+
+	/* disable dynamic power gating mode */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
+		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+}
+
+/**
+ * vcn_v5_0_1_stop - VCN stop
+ *
+ * @vinst: VCN instance
+ *
+ * Stop VCN block
+ */
+static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int i = vinst->inst;
+	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
+	uint32_t tmp;
+	int r = 0, vcn_inst;
+
+	vcn_inst = GET_INST(VCN, i);
+
+	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v5_0_1_stop_dpg_mode(vinst);
+		return 0;
+	}
+
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
+
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
+
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
+
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
+
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
+
+	/* clear status */
+	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
+	return 0;
+}
+
+/**
+ * vcn_v5_0_1_unified_ring_get_rptr - get unified read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware unified read pointer
+ */
+static uint64_t vcn_v5_0_1_unified_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	return RREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_RPTR);
+}
+
+/**
+ * vcn_v5_0_1_unified_ring_get_wptr - get unified write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware unified write pointer
+ */
+static uint64_t vcn_v5_0_1_unified_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	if (ring->use_doorbell)
+		return *ring->wptr_cpu_addr;
+	else
+		return RREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_WPTR);
+}
+
+/**
+ * vcn_v5_0_1_unified_ring_set_wptr - set enc write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the enc write pointer to the hardware
+ */
+static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
+		DRM_ERROR("wrong ring id is identified in %s", __func__);
+
+	if (ring->use_doorbell) {
+		*ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15(VCN, GET_INST(VCN, ring->me), regUVD_RB_WPTR,
+				lower_32_bits(ring->wptr));
+	}
+}
+
+static const struct amdgpu_ring_funcs vcn_v5_0_1_unified_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_ENC,
+	.align_mask = 0x3f,
+	.nop = VCN_ENC_CMD_NO_OP,
+	.get_rptr = vcn_v5_0_1_unified_ring_get_rptr,
+	.get_wptr = vcn_v5_0_1_unified_ring_get_wptr,
+	.set_wptr = vcn_v5_0_1_unified_ring_set_wptr,
+	.emit_frame_size = SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+			   SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
+			   4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
+			   5 +
+			   5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
+			   1, /* vcn_v2_0_enc_ring_insert_end */
+	.emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
+	.emit_ib = vcn_v2_0_enc_ring_emit_ib,
+	.emit_fence = vcn_v2_0_enc_ring_emit_fence,
+	.emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
+	.emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
+	.test_ring = amdgpu_vcn_enc_ring_test_ring,
+	.test_ib = amdgpu_vcn_unified_ring_test_ib,
+	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_end = vcn_v2_0_enc_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_vcn_ring_begin_use,
+	.end_use = amdgpu_vcn_ring_end_use,
+	.emit_wreg = vcn_v4_0_3_enc_ring_emit_wreg,
+	.emit_reg_wait = vcn_v4_0_3_enc_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
+/**
+ * vcn_v5_0_1_set_unified_ring_funcs - set unified ring functions
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set unified ring functions
+ */
+static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev)
+{
+	int i, vcn_inst;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_1_unified_ring_vm_funcs;
+		adev->vcn.inst[i].ring_enc[0].me = i;
+		vcn_inst = GET_INST(VCN, i);
+		adev->vcn.inst[i].aid_id = vcn_inst / adev->vcn.num_inst_per_aid;
+	}
+}
+
+/**
+ * vcn_v5_0_1_is_idle - check VCN block is idle
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block structure
+ *
+ * Check whether VCN block is idle
+ */
+static bool vcn_v5_0_1_is_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, ret = 1;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret &= (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) == UVD_STATUS__IDLE);
+
+	return ret;
+}
+
+/**
+ * vcn_v5_0_1_wait_for_idle - wait for VCN block idle
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Wait for VCN block idle
+ */
+static int vcn_v5_0_1_wait_for_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, ret = 0;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		ret = SOC15_WAIT_ON_RREG(VCN, GET_INST(VCN, i), regUVD_STATUS, UVD_STATUS__IDLE,
+			UVD_STATUS__IDLE);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+/**
+ * vcn_v5_0_1_set_clockgating_state - set VCN block clockgating state
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ * @state: clock gating state
+ *
+ * Set VCN block clockgating state
+ */
+static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					    enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	bool enable = state == AMD_CG_STATE_GATE;
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
+
+		if (enable) {
+			if (RREG32_SOC15(VCN, GET_INST(VCN, i), regUVD_STATUS) != UVD_STATUS__IDLE)
+				return -EBUSY;
+			vcn_v5_0_1_enable_clock_gating(vinst);
+		} else {
+			vcn_v5_0_1_disable_clock_gating(vinst);
+		}
+	}
+
+	return 0;
+}
+
+static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
+				   enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = vinst->adev;
+	int ret = 0;
+
+	/* for SRIOV, guest should not control VCN Power-gating
+	 * MMSCH FW should control Power-gating and clock-gating
+	 * guest should avoid touching CGC and PG
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		vinst->cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
+	if (state == vinst->cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_1_stop(vinst);
+	else
+		ret = vcn_v5_0_1_start(vinst);
+
+	if (!ret)
+		vinst->cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v5_0_1_process_interrupt - process VCN block interrupt
+ *
+ * @adev: amdgpu_device pointer
+ * @source: interrupt sources
+ * @entry: interrupt entry from clients and sources
+ *
+ * Process VCN block interrupt
+ */
+static int vcn_v5_0_1_process_interrupt(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
+	struct amdgpu_iv_entry *entry)
+{
+	uint32_t i, inst;
+
+	i = node_id_to_phys_map[entry->node_id];
+
+	DRM_DEV_DEBUG(adev->dev, "IH: VCN TRAP\n");
+
+	for (inst = 0; inst < adev->vcn.num_vcn_inst; ++inst)
+		if (adev->vcn.inst[inst].aid_id == i)
+			break;
+	if (inst >= adev->vcn.num_vcn_inst) {
+		dev_WARN_ONCE(adev->dev, 1,
+				"Interrupt received for unknown VCN instance %d",
+				entry->node_id);
+		return 0;
+	}
+
+	switch (entry->src_id) {
+	case VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
+		amdgpu_fence_process(&adev->vcn.inst[inst].ring_enc[0]);
+		break;
+	default:
+		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
+			  entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
+
+static int vcn_v5_0_1_set_ras_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs vcn_v5_0_1_irq_funcs = {
+	.process = vcn_v5_0_1_process_interrupt,
+};
+
+static const struct amdgpu_irq_src_funcs vcn_v5_0_1_ras_irq_funcs = {
+	.set = vcn_v5_0_1_set_ras_interrupt_state,
+	.process = amdgpu_vcn_process_poison_irq,
+};
+
+
+/**
+ * vcn_v5_0_1_set_irq_funcs - set VCN block interrupt irq functions
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set VCN block interrupt irq functions
+ */
+static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		adev->vcn.inst->irq.num_types++;
+
+	adev->vcn.inst->irq.funcs = &vcn_v5_0_1_irq_funcs;
+
+	adev->vcn.inst->ras_poison_irq.num_types = 1;
+	adev->vcn.inst->ras_poison_irq.funcs = &vcn_v5_0_1_ras_irq_funcs;
+
+}
+
+static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
+	.name = "vcn_v5_0_1",
+	.early_init = vcn_v5_0_1_early_init,
+	.late_init = NULL,
+	.sw_init = vcn_v5_0_1_sw_init,
+	.sw_fini = vcn_v5_0_1_sw_fini,
+	.hw_init = vcn_v5_0_1_hw_init,
+	.hw_fini = vcn_v5_0_1_hw_fini,
+	.suspend = vcn_v5_0_1_suspend,
+	.resume = vcn_v5_0_1_resume,
+	.is_idle = vcn_v5_0_1_is_idle,
+	.wait_for_idle = vcn_v5_0_1_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = vcn_v5_0_1_set_clockgating_state,
+	.set_powergating_state = vcn_set_powergating_state,
+	.dump_ip_state = vcn_v5_0_0_dump_ip_state,
+	.print_ip_state = vcn_v5_0_0_print_ip_state,
+};
+
+const struct amdgpu_ip_block_version vcn_v5_0_1_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_VCN,
+	.major = 5,
+	.minor = 0,
+	.rev = 1,
+	.funcs = &vcn_v5_0_1_ip_funcs,
+};
+
+static uint32_t vcn_v5_0_1_query_poison_by_instance(struct amdgpu_device *adev,
+			uint32_t instance, uint32_t sub_block)
+{
+	uint32_t poison_stat = 0, reg_value = 0;
+
+	switch (sub_block) {
+	case AMDGPU_VCN_V5_0_1_VCPU_VCODEC:
+		reg_value = RREG32_SOC15(VCN, instance, regUVD_RAS_VCPU_VCODEC_STATUS);
+		poison_stat = REG_GET_FIELD(reg_value, UVD_RAS_VCPU_VCODEC_STATUS, POISONED_PF);
+		break;
+	default:
+		break;
+	}
+
+	if (poison_stat)
+		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
+			instance, sub_block);
+
+	return poison_stat;
+}
+
+static bool vcn_v5_0_1_query_poison_status(struct amdgpu_device *adev)
+{
+	uint32_t inst, sub;
+	uint32_t poison_stat = 0;
+
+	for (inst = 0; inst < adev->vcn.num_vcn_inst; inst++)
+		for (sub = 0; sub < AMDGPU_VCN_V5_0_1_MAX_SUB_BLOCK; sub++)
+			poison_stat +=
+			vcn_v5_0_1_query_poison_by_instance(adev, inst, sub);
+
+	return !!poison_stat;
+}
+
+static const struct amdgpu_ras_block_hw_ops vcn_v5_0_1_ras_hw_ops = {
+	.query_poison_status = vcn_v5_0_1_query_poison_status,
+};
+
+static int vcn_v5_0_1_aca_bank_parser(struct aca_handle *handle, struct aca_bank *bank,
+				      enum aca_smu_type type, void *data)
+{
+	struct aca_bank_info info;
+	u64 misc0;
+	int ret;
+
+	ret = aca_bank_info_decode(bank, &info);
+	if (ret)
+		return ret;
+
+	misc0 = bank->regs[ACA_REG_IDX_MISC0];
+	switch (type) {
+	case ACA_SMU_TYPE_UE:
+		bank->aca_err_type = ACA_ERROR_TYPE_UE;
+		ret = aca_error_cache_log_bank_error(handle, &info, ACA_ERROR_TYPE_UE,
+						     1ULL);
+		break;
+	case ACA_SMU_TYPE_CE:
+		bank->aca_err_type = ACA_ERROR_TYPE_CE;
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type,
+						     ACA_REG__MISC0__ERRCNT(misc0));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+/* reference to smu driver if header file */
+static int vcn_v5_0_1_err_codes[] = {
+	14, 15, /* VCN */
+};
+
+static bool vcn_v5_0_1_aca_bank_is_valid(struct aca_handle *handle, struct aca_bank *bank,
+					 enum aca_smu_type type, void *data)
+{
+	u32 instlo;
+
+	instlo = ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]);
+	instlo &= GENMASK(31, 1);
+
+	if (instlo != mmSMNAID_AID0_MCA_SMU)
+		return false;
+
+	if (aca_bank_check_error_codes(handle->adev, bank,
+				       vcn_v5_0_1_err_codes,
+				       ARRAY_SIZE(vcn_v5_0_1_err_codes)))
+		return false;
+
+	return true;
+}
+
+static const struct aca_bank_ops vcn_v5_0_1_aca_bank_ops = {
+	.aca_bank_parser = vcn_v5_0_1_aca_bank_parser,
+	.aca_bank_is_valid = vcn_v5_0_1_aca_bank_is_valid,
+};
+
+static const struct aca_info vcn_v5_0_1_aca_info = {
+	.hwip = ACA_HWIP_TYPE_SMU,
+	.mask = ACA_ERROR_UE_MASK,
+	.bank_ops = &vcn_v5_0_1_aca_bank_ops,
+};
+
+static int vcn_v5_0_1_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
+{
+	int r;
+
+	r = amdgpu_ras_block_late_init(adev, ras_block);
+	if (r)
+		return r;
+
+	r = amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__VCN,
+				&vcn_v5_0_1_aca_info, NULL);
+	if (r)
+		goto late_fini;
+
+	return 0;
+
+late_fini:
+	amdgpu_ras_block_late_fini(adev, ras_block);
+
+	return r;
+}
+
+static struct amdgpu_vcn_ras vcn_v5_0_1_ras = {
+	.ras_block = {
+		.hw_ops = &vcn_v5_0_1_ras_hw_ops,
+		.ras_late_init = vcn_v5_0_1_ras_late_init,
+	},
+};
+
+static void vcn_v5_0_1_set_ras_funcs(struct amdgpu_device *adev)
+{
+	adev->vcn.ras = &vcn_v5_0_1_ras;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index ca446e08f6a2..21aff7fa6375 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1019,8 +1019,22 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 		if (pipe_ctx->plane_res.dpp || pipe_ctx->stream_res.opp)
 			update_state->pg_pipe_res_update[PG_MPCC][pipe_ctx->plane_res.mpcc_inst] = false;
 
-		if (pipe_ctx->stream_res.dsc)
+		if (pipe_ctx->stream_res.dsc) {
 			update_state->pg_pipe_res_update[PG_DSC][pipe_ctx->stream_res.dsc->inst] = false;
+			if (dc->caps.sequential_ono) {
+				update_state->pg_pipe_res_update[PG_HUBP][pipe_ctx->stream_res.dsc->inst] = false;
+				update_state->pg_pipe_res_update[PG_DPP][pipe_ctx->stream_res.dsc->inst] = false;
+
+				/* All HUBP/DPP instances must be powered if the DSC inst != HUBP inst */
+				if (!pipe_ctx->top_pipe && pipe_ctx->plane_res.hubp &&
+				    pipe_ctx->plane_res.hubp->inst != pipe_ctx->stream_res.dsc->inst) {
+					for (j = 0; j < dc->res_pool->pipe_count; ++j) {
+						update_state->pg_pipe_res_update[PG_HUBP][j] = false;
+						update_state->pg_pipe_res_update[PG_DPP][j] = false;
+					}
+				}
+			}
+		}
 
 		if (pipe_ctx->stream_res.opp)
 			update_state->pg_pipe_res_update[PG_OPP][pipe_ctx->stream_res.opp->inst] = false;
@@ -1165,6 +1179,25 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		update_state->pg_pipe_res_update[PG_HDMISTREAM][0] = true;
 
 	if (dc->caps.sequential_ono) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (new_pipe->stream_res.dsc && !new_pipe->top_pipe &&
+			    update_state->pg_pipe_res_update[PG_DSC][new_pipe->stream_res.dsc->inst]) {
+				update_state->pg_pipe_res_update[PG_HUBP][new_pipe->stream_res.dsc->inst] = true;
+				update_state->pg_pipe_res_update[PG_DPP][new_pipe->stream_res.dsc->inst] = true;
+
+				/* All HUBP/DPP instances must be powered if the DSC inst != HUBP inst */
+				if (new_pipe->plane_res.hubp &&
+				    new_pipe->plane_res.hubp->inst != new_pipe->stream_res.dsc->inst) {
+					for (j = 0; j < dc->res_pool->pipe_count; ++j) {
+						update_state->pg_pipe_res_update[PG_HUBP][j] = true;
+						update_state->pg_pipe_res_update[PG_DPP][j] = true;
+					}
+				}
+			}
+		}
+
 		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
 			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 			    update_state->pg_pipe_res_update[PG_DPP][i]) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4f78c84da780..c5bca3019de0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -58,6 +58,7 @@
 
 MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_0.bin");
+MODULE_FIRMWARE("amdgpu/smu_13_0_0_kicker.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_7.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 
@@ -92,7 +93,7 @@ const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
 int smu_v13_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char ucode_prefix[15];
+	char ucode_prefix[30];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
 	const struct common_firmware_header *header;
@@ -103,7 +104,10 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 		return 0;
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
+	if (amdgpu_is_kicker_fw(adev))
+		err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s_kicker.bin", ucode_prefix);
+	else
+		err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index 6886db2d9e00..8e889a38fad0 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -64,10 +64,11 @@ struct auxiliary_device *devm_drm_dp_hpd_bridge_alloc(struct device *parent, str
 	adev->id = ret;
 	adev->name = "dp_hpd_bridge";
 	adev->dev.parent = parent;
-	adev->dev.of_node = of_node_get(parent->of_node);
 	adev->dev.release = drm_aux_hpd_bridge_release;
 	adev->dev.platform_data = of_node_get(np);
 
+	device_set_of_node_from_dev(&adev->dev, parent);
+
 	ret = auxiliary_device_init(adev);
 	if (ret) {
 		of_node_put(adev->dev.platform_data);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index f57df8c48139..05e4a5a63f5d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -187,6 +187,7 @@ struct fimd_context {
 	u32				i80ifcon;
 	bool				i80_if;
 	bool				suspended;
+	bool				dp_clk_enabled;
 	wait_queue_head_t		wait_vsync_queue;
 	atomic_t			wait_vsync_event;
 	atomic_t			win_updated;
@@ -1047,7 +1048,18 @@ static void fimd_dp_clock_enable(struct exynos_drm_clk *clk, bool enable)
 	struct fimd_context *ctx = container_of(clk, struct fimd_context,
 						dp_clk);
 	u32 val = enable ? DP_MIE_CLK_DP_ENABLE : DP_MIE_CLK_DISABLE;
+
+	if (enable == ctx->dp_clk_enabled)
+		return;
+
+	if (enable)
+		pm_runtime_resume_and_get(ctx->dev);
+
+	ctx->dp_clk_enabled = enable;
 	writel(val, ctx->regs + DP_MIE_CLKCON);
+
+	if (!enable)
+		pm_runtime_put(ctx->dev);
 }
 
 static const struct exynos_drm_crtc_ops fimd_crtc_ops = {
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 45cca965c11b..ca9e0c730013 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -4300,6 +4300,24 @@ intel_dp_mst_disconnect(struct intel_dp *intel_dp)
 static bool
 intel_dp_get_sink_irq_esi(struct intel_dp *intel_dp, u8 *esi)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
+	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
+
+	/*
+	 * Display WA for HSD #13013007775: mtl/arl/lnl
+	 * Read the sink count and link service IRQ registers in separate
+	 * transactions to prevent disconnecting the sink on a TBT link
+	 * inadvertently.
+	 */
+	if (IS_DISPLAY_VER(display, 14, 20) && !IS_BATTLEMAGE(i915)) {
+		if (drm_dp_dpcd_read(&intel_dp->aux, DP_SINK_COUNT_ESI, esi, 3) != 3)
+			return false;
+
+		/* DP_SINK_COUNT_ESI + 3 == DP_LINK_SERVICE_IRQ_VECTOR_ESI0 */
+		return drm_dp_dpcd_readb(&intel_dp->aux, DP_LINK_SERVICE_IRQ_VECTOR_ESI0,
+					 &esi[3]) == 1;
+	}
+
 	return drm_dp_dpcd_read(&intel_dp->aux, DP_SINK_COUNT_ESI, esi, 4) == 4;
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index 1e925c75fb08..c43febc862dc 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -284,7 +284,7 @@ static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
 	if (gt->gsc.intf[intf_id].irq < 0)
 		return;
 
-	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
+	ret = generic_handle_irq_safe(gt->gsc.intf[intf_id].irq);
 	if (ret)
 		gt_err_ratelimited(gt, "error handling GSC irq: %d\n", ret);
 }
diff --git a/drivers/gpu/drm/i915/gt/intel_ring_submission.c b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
index 72277bc8322e..f84fa09cdb33 100644
--- a/drivers/gpu/drm/i915/gt/intel_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
@@ -575,7 +575,6 @@ static int ring_context_alloc(struct intel_context *ce)
 	/* One ringbuffer to rule them all */
 	GEM_BUG_ON(!engine->legacy.ring);
 	ce->ring = engine->legacy.ring;
-	ce->timeline = intel_timeline_get(engine->legacy.timeline);
 
 	GEM_BUG_ON(ce->state);
 	if (engine->context_size) {
@@ -588,6 +587,8 @@ static int ring_context_alloc(struct intel_context *ce)
 		ce->state = vma;
 	}
 
+	ce->timeline = intel_timeline_get(engine->legacy.timeline);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index acae30a04a94..0122719ee921 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -73,8 +73,8 @@ static int igt_add_request(void *arg)
 	/* Basic preliminary test to create a request and let it loose! */
 
 	request = mock_request(rcs0(i915)->kernel_context, HZ / 10);
-	if (!request)
-		return -ENOMEM;
+	if (IS_ERR(request))
+		return PTR_ERR(request);
 
 	i915_request_add(request);
 
@@ -91,8 +91,8 @@ static int igt_wait_request(void *arg)
 	/* Submit a request, then wait upon it */
 
 	request = mock_request(rcs0(i915)->kernel_context, T);
-	if (!request)
-		return -ENOMEM;
+	if (IS_ERR(request))
+		return PTR_ERR(request);
 
 	i915_request_get(request);
 
@@ -160,8 +160,8 @@ static int igt_fence_wait(void *arg)
 	/* Submit a request, treat it as a fence and wait upon it */
 
 	request = mock_request(rcs0(i915)->kernel_context, T);
-	if (!request)
-		return -ENOMEM;
+	if (IS_ERR(request))
+		return PTR_ERR(request);
 
 	if (dma_fence_wait_timeout(&request->fence, false, T) != -ETIME) {
 		pr_err("fence wait success before submit (expected timeout)!\n");
@@ -219,8 +219,8 @@ static int igt_request_rewind(void *arg)
 	GEM_BUG_ON(IS_ERR(ce));
 	request = mock_request(ce, 2 * HZ);
 	intel_context_put(ce);
-	if (!request) {
-		err = -ENOMEM;
+	if (IS_ERR(request)) {
+		err = PTR_ERR(request);
 		goto err_context_0;
 	}
 
@@ -237,8 +237,8 @@ static int igt_request_rewind(void *arg)
 	GEM_BUG_ON(IS_ERR(ce));
 	vip = mock_request(ce, 0);
 	intel_context_put(ce);
-	if (!vip) {
-		err = -ENOMEM;
+	if (IS_ERR(vip)) {
+		err = PTR_ERR(vip);
 		goto err_context_1;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_request.c b/drivers/gpu/drm/i915/selftests/mock_request.c
index 09f747228dff..1b0cf073e964 100644
--- a/drivers/gpu/drm/i915/selftests/mock_request.c
+++ b/drivers/gpu/drm/i915/selftests/mock_request.c
@@ -35,7 +35,7 @@ mock_request(struct intel_context *ce, unsigned long delay)
 	/* NB the i915->requests slab cache is enlarged to fit mock_request */
 	request = intel_context_create_request(ce);
 	if (IS_ERR(request))
-		return NULL;
+		return request;
 
 	request->mock.delay = delay;
 	return request;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index f775638d239a..4b3a8ee8e278 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -85,6 +85,15 @@ void __msm_gem_submit_destroy(struct kref *kref)
 			container_of(kref, struct msm_gem_submit, ref);
 	unsigned i;
 
+	/*
+	 * In error paths, we could unref the submit without calling
+	 * drm_sched_entity_push_job(), so msm_job_free() will never
+	 * get called.  Since drm_sched_job_cleanup() will NULL out
+	 * s_fence, we can use that to detect this case.
+	 */
+	if (submit->base.s_fence)
+		drm_sched_job_cleanup(&submit->base);
+
 	if (submit->fence_id) {
 		spin_lock(&submit->queue->idr_lock);
 		idr_remove(&submit->queue->fence_idr, submit->fence_id);
@@ -658,6 +667,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	struct msm_ringbuffer *ring;
 	struct msm_submit_post_dep *post_deps = NULL;
 	struct drm_syncobj **syncobjs_to_reset = NULL;
+	struct sync_file *sync_file = NULL;
 	int out_fence_fd = -1;
 	unsigned i;
 	int ret;
@@ -868,7 +878,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	}
 
 	if (ret == 0 && args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
-		struct sync_file *sync_file = sync_file_create(submit->user_fence);
+		sync_file = sync_file_create(submit->user_fence);
 		if (!sync_file) {
 			ret = -ENOMEM;
 		} else {
@@ -902,8 +912,11 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 out_unlock:
 	mutex_unlock(&queue->lock);
 out_post_unlock:
-	if (ret && (out_fence_fd >= 0))
+	if (ret && (out_fence_fd >= 0)) {
 		put_unused_fd(out_fence_fd);
+		if (sync_file)
+			fput(sync_file->file);
+	}
 
 	if (!IS_ERR_OR_NULL(submit)) {
 		msm_gem_submit_put(submit);
diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index d19e10289428..07abaf27315f 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -284,7 +284,7 @@ static struct simpledrm_device *simpledrm_device_of_dev(struct drm_device *dev)
 
 static void simpledrm_device_release_clocks(void *res)
 {
-	struct simpledrm_device *sdev = simpledrm_device_of_dev(res);
+	struct simpledrm_device *sdev = res;
 	unsigned int i;
 
 	for (i = 0; i < sdev->clk_count; ++i) {
@@ -382,7 +382,7 @@ static int simpledrm_device_init_clocks(struct simpledrm_device *sdev)
 
 static void simpledrm_device_release_regulators(void *res)
 {
-	struct simpledrm_device *sdev = simpledrm_device_of_dev(res);
+	struct simpledrm_device *sdev = res;
 	unsigned int i;
 
 	for (i = 0; i < sdev->regulator_count; ++i) {
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 75b4725d49c7..d4b0549205c2 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -95,6 +95,12 @@ struct v3d_perfmon {
 	u64 values[] __counted_by(ncounters);
 };
 
+enum v3d_irq {
+	V3D_CORE_IRQ,
+	V3D_HUB_IRQ,
+	V3D_MAX_IRQS,
+};
+
 struct v3d_dev {
 	struct drm_device drm;
 
@@ -106,6 +112,8 @@ struct v3d_dev {
 
 	bool single_irq_line;
 
+	int irq[V3D_MAX_IRQS];
+
 	struct v3d_perfmon_info perfmon_info;
 
 	void __iomem *hub_regs;
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index da8faf3b9011..6b6ba7a68fcb 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -118,6 +118,8 @@ v3d_reset(struct v3d_dev *v3d)
 	if (false)
 		v3d_idle_axi(v3d, 0);
 
+	v3d_irq_disable(v3d);
+
 	v3d_idle_gca(v3d);
 	v3d_reset_v3d(v3d);
 
diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
index 72b6a119412f..b98e1a4b33c7 100644
--- a/drivers/gpu/drm/v3d/v3d_irq.c
+++ b/drivers/gpu/drm/v3d/v3d_irq.c
@@ -228,7 +228,7 @@ v3d_hub_irq(int irq, void *arg)
 int
 v3d_irq_init(struct v3d_dev *v3d)
 {
-	int irq1, ret, core;
+	int irq, ret, core;
 
 	INIT_WORK(&v3d->overflow_mem_work, v3d_overflow_mem_work);
 
@@ -239,17 +239,24 @@ v3d_irq_init(struct v3d_dev *v3d)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS(v3d->ver));
 	V3D_WRITE(V3D_HUB_INT_CLR, V3D_HUB_IRQS(v3d->ver));
 
-	irq1 = platform_get_irq_optional(v3d_to_pdev(v3d), 1);
-	if (irq1 == -EPROBE_DEFER)
-		return irq1;
-	if (irq1 > 0) {
-		ret = devm_request_irq(v3d->drm.dev, irq1,
+	irq = platform_get_irq_optional(v3d_to_pdev(v3d), 1);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+	if (irq > 0) {
+		v3d->irq[V3D_CORE_IRQ] = irq;
+
+		ret = devm_request_irq(v3d->drm.dev, v3d->irq[V3D_CORE_IRQ],
 				       v3d_irq, IRQF_SHARED,
 				       "v3d_core0", v3d);
 		if (ret)
 			goto fail;
-		ret = devm_request_irq(v3d->drm.dev,
-				       platform_get_irq(v3d_to_pdev(v3d), 0),
+
+		irq = platform_get_irq(v3d_to_pdev(v3d), 0);
+		if (irq < 0)
+			return irq;
+		v3d->irq[V3D_HUB_IRQ] = irq;
+
+		ret = devm_request_irq(v3d->drm.dev, v3d->irq[V3D_HUB_IRQ],
 				       v3d_hub_irq, IRQF_SHARED,
 				       "v3d_hub", v3d);
 		if (ret)
@@ -257,8 +264,12 @@ v3d_irq_init(struct v3d_dev *v3d)
 	} else {
 		v3d->single_irq_line = true;
 
-		ret = devm_request_irq(v3d->drm.dev,
-				       platform_get_irq(v3d_to_pdev(v3d), 0),
+		irq = platform_get_irq(v3d_to_pdev(v3d), 0);
+		if (irq < 0)
+			return irq;
+		v3d->irq[V3D_CORE_IRQ] = irq;
+
+		ret = devm_request_irq(v3d->drm.dev, v3d->irq[V3D_CORE_IRQ],
 				       v3d_irq, IRQF_SHARED,
 				       "v3d", v3d);
 		if (ret)
@@ -299,6 +310,12 @@ v3d_irq_disable(struct v3d_dev *v3d)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_MSK_SET, ~0);
 	V3D_WRITE(V3D_HUB_INT_MSK_SET, ~0);
 
+	/* Finish any interrupt handler still in flight. */
+	for (int i = 0; i < V3D_MAX_IRQS; i++) {
+		if (v3d->irq[i])
+			synchronize_irq(v3d->irq[i]);
+	}
+
 	/* Clear any pending interrupts we might have left. */
 	for (core = 0; core < v3d->cores; core++)
 		V3D_CORE_WRITE(core, V3D_CTL_INT_CLR, V3D_CORE_IRQS(v3d->ver));
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 7bbe46a98ff1..93e742c1f21e 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_XE
 	tristate "Intel Xe Graphics"
-	depends on DRM && PCI && MMU && (m || (y && KUNIT=y))
+	depends on DRM && PCI && MMU
+	depends on KUNIT || !KUNIT
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
 	# the shmem_readpage() which depends upon tmpfs
diff --git a/drivers/gpu/drm/xe/abi/guc_communication_ctb_abi.h b/drivers/gpu/drm/xe/abi/guc_communication_ctb_abi.h
index 8f86a16dc577..f58198cf2cf6 100644
--- a/drivers/gpu/drm/xe/abi/guc_communication_ctb_abi.h
+++ b/drivers/gpu/drm/xe/abi/guc_communication_ctb_abi.h
@@ -52,6 +52,7 @@ struct guc_ct_buffer_desc {
 #define GUC_CTB_STATUS_OVERFLOW				(1 << 0)
 #define GUC_CTB_STATUS_UNDERFLOW			(1 << 1)
 #define GUC_CTB_STATUS_MISMATCH				(1 << 2)
+#define GUC_CTB_STATUS_DISABLED				(1 << 3)
 	u32 reserved[13];
 } __packed;
 static_assert(sizeof(struct guc_ct_buffer_desc) == 64);
diff --git a/drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_stolen.h b/drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_stolen.h
index cb6c7598824b..9c4cf050059a 100644
--- a/drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_stolen.h
+++ b/drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_stolen.h
@@ -29,7 +29,7 @@ static inline int i915_gem_stolen_insert_node_in_range(struct xe_device *xe,
 
 	bo = xe_bo_create_locked_range(xe, xe_device_get_root_tile(xe),
 				       NULL, size, start, end,
-				       ttm_bo_type_kernel, flags);
+				       ttm_bo_type_kernel, flags, 0);
 	if (IS_ERR(bo)) {
 		err = PTR_ERR(bo);
 		bo = NULL;
diff --git a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
index f99d901a3214..9f941fc2e36b 100644
--- a/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
+++ b/drivers/gpu/drm/xe/display/xe_dsb_buffer.c
@@ -17,10 +17,7 @@ u32 intel_dsb_buffer_ggtt_offset(struct intel_dsb_buffer *dsb_buf)
 
 void intel_dsb_buffer_write(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val)
 {
-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
-
 	iosys_map_wr(&dsb_buf->vma->bo->vmap, idx * 4, u32, val);
-	xe_device_l2_flush(xe);
 }
 
 u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
@@ -30,12 +27,9 @@ u32 intel_dsb_buffer_read(struct intel_dsb_buffer *dsb_buf, u32 idx)
 
 void intel_dsb_buffer_memset(struct intel_dsb_buffer *dsb_buf, u32 idx, u32 val, size_t size)
 {
-	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
-
 	WARN_ON(idx > (dsb_buf->buf_size - size) / sizeof(*dsb_buf->cmd_buf));
 
 	iosys_map_memset(&dsb_buf->vma->bo->vmap, idx * 4, val, size);
-	xe_device_l2_flush(xe);
 }
 
 bool intel_dsb_buffer_create(struct intel_crtc *crtc, struct intel_dsb_buffer *dsb_buf, size_t size)
@@ -48,11 +42,12 @@ bool intel_dsb_buffer_create(struct intel_crtc *crtc, struct intel_dsb_buffer *d
 	if (!vma)
 		return false;
 
+	/* Set scanout flag for WC mapping */
 	obj = xe_bo_create_pin_map(xe, xe_device_get_root_tile(xe),
 				   NULL, PAGE_ALIGN(size),
 				   ttm_bo_type_kernel,
 				   XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
-				   XE_BO_FLAG_GGTT);
+				   XE_BO_FLAG_SCANOUT | XE_BO_FLAG_GGTT);
 	if (IS_ERR(obj)) {
 		kfree(vma);
 		return false;
@@ -73,5 +68,12 @@ void intel_dsb_buffer_cleanup(struct intel_dsb_buffer *dsb_buf)
 
 void intel_dsb_buffer_flush_map(struct intel_dsb_buffer *dsb_buf)
 {
-	/* TODO: add xe specific flush_map() for dsb buffer object. */
+	struct xe_device *xe = dsb_buf->vma->bo->tile->xe;
+
+	/*
+	 * The memory barrier here is to ensure coherency of DSB vs MMIO,
+	 * both for weak ordering archs and discrete cards.
+	 */
+	xe_device_wmb(xe);
+	xe_device_l2_flush(xe);
 }
diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index b58fc4ba2aac..0558b106f8b6 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -153,7 +153,10 @@ static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
 	}
 
 	vma->dpt = dpt;
-	vma->node = dpt->ggtt_node;
+	vma->node = dpt->ggtt_node[tile0->id];
+
+	/* Ensure DPT writes are flushed */
+	xe_device_l2_flush(xe);
 	return 0;
 }
 
@@ -203,8 +206,8 @@ static int __xe_pin_fb_vma_ggtt(const struct intel_framebuffer *fb,
 	if (xe_bo_is_vram(bo) && ggtt->flags & XE_GGTT_FLAGS_64K)
 		align = max_t(u32, align, SZ_64K);
 
-	if (bo->ggtt_node && view->type == I915_GTT_VIEW_NORMAL) {
-		vma->node = bo->ggtt_node;
+	if (bo->ggtt_node[ggtt->tile->id] && view->type == I915_GTT_VIEW_NORMAL) {
+		vma->node = bo->ggtt_node[ggtt->tile->id];
 	} else if (view->type == I915_GTT_VIEW_NORMAL) {
 		u32 x, size = bo->ttm.base.size;
 
@@ -318,8 +321,6 @@ static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
 	if (ret)
 		goto err_unpin;
 
-	/* Ensure DPT writes are flushed */
-	xe_device_l2_flush(xe);
 	return vma;
 
 err_unpin:
@@ -333,10 +334,12 @@ static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
 
 static void __xe_unpin_fb_vma(struct i915_vma *vma)
 {
+	u8 tile_id = vma->node->ggtt->tile->id;
+
 	if (vma->dpt)
 		xe_bo_unpin_map_no_vm(vma->dpt);
-	else if (!xe_ggtt_node_allocated(vma->bo->ggtt_node) ||
-		 vma->bo->ggtt_node->base.start != vma->node->base.start)
+	else if (!xe_ggtt_node_allocated(vma->bo->ggtt_node[tile_id]) ||
+		 vma->bo->ggtt_node[tile_id]->base.start != vma->node->base.start)
 		xe_ggtt_node_remove(vma->node, false);
 
 	ttm_bo_reserve(&vma->bo->ttm, false, false, NULL);
diff --git a/drivers/gpu/drm/xe/regs/xe_reg_defs.h b/drivers/gpu/drm/xe/regs/xe_reg_defs.h
index 23f7dc5bbe99..51fd40ffafcb 100644
--- a/drivers/gpu/drm/xe/regs/xe_reg_defs.h
+++ b/drivers/gpu/drm/xe/regs/xe_reg_defs.h
@@ -128,7 +128,7 @@ struct xe_reg_mcr {
  *       options.
  */
 #define XE_REG_MCR(r_, ...)	((const struct xe_reg_mcr){					\
-				 .__reg = XE_REG_INITIALIZER(r_,  ##__VA_ARGS__, .mcr = 1)	\
+				 .__reg = XE_REG_INITIALIZER(r_, ##__VA_ARGS__, .mcr = 1)	\
 				 })
 
 static inline bool xe_reg_is_valid(struct xe_reg r)
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 8acc4640f0a2..5f745d9ed6cc 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1130,6 +1130,8 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 {
 	struct xe_bo *bo = ttm_to_xe_bo(ttm_bo);
 	struct xe_device *xe = ttm_to_xe_device(ttm_bo->bdev);
+	struct xe_tile *tile;
+	u8 id;
 
 	if (bo->ttm.base.import_attach)
 		drm_prime_gem_destroy(&bo->ttm.base, NULL);
@@ -1137,8 +1139,9 @@ static void xe_ttm_bo_destroy(struct ttm_buffer_object *ttm_bo)
 
 	xe_assert(xe, list_empty(&ttm_bo->base.gpuva.list));
 
-	if (bo->ggtt_node && bo->ggtt_node->base.size)
-		xe_ggtt_remove_bo(bo->tile->mem.ggtt, bo);
+	for_each_tile(tile, xe, id)
+		if (bo->ggtt_node[id] && bo->ggtt_node[id]->base.size)
+			xe_ggtt_remove_bo(tile->mem.ggtt, bo);
 
 #ifdef CONFIG_PROC_FS
 	if (bo->client)
@@ -1308,6 +1311,10 @@ struct xe_bo *___xe_bo_create_locked(struct xe_device *xe, struct xe_bo *bo,
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* XE_BO_FLAG_GGTTx requires XE_BO_FLAG_GGTT also be set */
+	if ((flags & XE_BO_FLAG_GGTT_ALL) && !(flags & XE_BO_FLAG_GGTT))
+		return ERR_PTR(-EINVAL);
+
 	if (flags & (XE_BO_FLAG_VRAM_MASK | XE_BO_FLAG_STOLEN) &&
 	    !(flags & XE_BO_FLAG_IGNORE_MIN_PAGE_SIZE) &&
 	    ((xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K) ||
@@ -1454,7 +1461,8 @@ static struct xe_bo *
 __xe_bo_create_locked(struct xe_device *xe,
 		      struct xe_tile *tile, struct xe_vm *vm,
 		      size_t size, u64 start, u64 end,
-		      u16 cpu_caching, enum ttm_bo_type type, u32 flags)
+		      u16 cpu_caching, enum ttm_bo_type type, u32 flags,
+		      u64 alignment)
 {
 	struct xe_bo *bo = NULL;
 	int err;
@@ -1483,6 +1491,8 @@ __xe_bo_create_locked(struct xe_device *xe,
 	if (IS_ERR(bo))
 		return bo;
 
+	bo->min_align = alignment;
+
 	/*
 	 * Note that instead of taking a reference no the drm_gpuvm_resv_bo(),
 	 * to ensure the shared resv doesn't disappear under the bo, the bo
@@ -1495,19 +1505,29 @@ __xe_bo_create_locked(struct xe_device *xe,
 	bo->vm = vm;
 
 	if (bo->flags & XE_BO_FLAG_GGTT) {
-		if (!tile && flags & XE_BO_FLAG_STOLEN)
-			tile = xe_device_get_root_tile(xe);
+		struct xe_tile *t;
+		u8 id;
 
-		xe_assert(xe, tile);
+		if (!(bo->flags & XE_BO_FLAG_GGTT_ALL)) {
+			if (!tile && flags & XE_BO_FLAG_STOLEN)
+				tile = xe_device_get_root_tile(xe);
 
-		if (flags & XE_BO_FLAG_FIXED_PLACEMENT) {
-			err = xe_ggtt_insert_bo_at(tile->mem.ggtt, bo,
-						   start + bo->size, U64_MAX);
-		} else {
-			err = xe_ggtt_insert_bo(tile->mem.ggtt, bo);
+			xe_assert(xe, tile);
+		}
+
+		for_each_tile(t, xe, id) {
+			if (t != tile && !(bo->flags & XE_BO_FLAG_GGTTx(t)))
+				continue;
+
+			if (flags & XE_BO_FLAG_FIXED_PLACEMENT) {
+				err = xe_ggtt_insert_bo_at(t->mem.ggtt, bo,
+							   start + bo->size, U64_MAX);
+			} else {
+				err = xe_ggtt_insert_bo(t->mem.ggtt, bo);
+			}
+			if (err)
+				goto err_unlock_put_bo;
 		}
-		if (err)
-			goto err_unlock_put_bo;
 	}
 
 	return bo;
@@ -1523,16 +1543,18 @@ struct xe_bo *
 xe_bo_create_locked_range(struct xe_device *xe,
 			  struct xe_tile *tile, struct xe_vm *vm,
 			  size_t size, u64 start, u64 end,
-			  enum ttm_bo_type type, u32 flags)
+			  enum ttm_bo_type type, u32 flags, u64 alignment)
 {
-	return __xe_bo_create_locked(xe, tile, vm, size, start, end, 0, type, flags);
+	return __xe_bo_create_locked(xe, tile, vm, size, start, end, 0, type,
+				     flags, alignment);
 }
 
 struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
 				  struct xe_vm *vm, size_t size,
 				  enum ttm_bo_type type, u32 flags)
 {
-	return __xe_bo_create_locked(xe, tile, vm, size, 0, ~0ULL, 0, type, flags);
+	return __xe_bo_create_locked(xe, tile, vm, size, 0, ~0ULL, 0, type,
+				     flags, 0);
 }
 
 struct xe_bo *xe_bo_create_user(struct xe_device *xe, struct xe_tile *tile,
@@ -1542,7 +1564,7 @@ struct xe_bo *xe_bo_create_user(struct xe_device *xe, struct xe_tile *tile,
 {
 	struct xe_bo *bo = __xe_bo_create_locked(xe, tile, vm, size, 0, ~0ULL,
 						 cpu_caching, ttm_bo_type_device,
-						 flags | XE_BO_FLAG_USER);
+						 flags | XE_BO_FLAG_USER, 0);
 	if (!IS_ERR(bo))
 		xe_bo_unlock_vm_held(bo);
 
@@ -1565,6 +1587,17 @@ struct xe_bo *xe_bo_create_pin_map_at(struct xe_device *xe, struct xe_tile *tile
 				      struct xe_vm *vm,
 				      size_t size, u64 offset,
 				      enum ttm_bo_type type, u32 flags)
+{
+	return xe_bo_create_pin_map_at_aligned(xe, tile, vm, size, offset,
+					       type, flags, 0);
+}
+
+struct xe_bo *xe_bo_create_pin_map_at_aligned(struct xe_device *xe,
+					      struct xe_tile *tile,
+					      struct xe_vm *vm,
+					      size_t size, u64 offset,
+					      enum ttm_bo_type type, u32 flags,
+					      u64 alignment)
 {
 	struct xe_bo *bo;
 	int err;
@@ -1576,7 +1609,8 @@ struct xe_bo *xe_bo_create_pin_map_at(struct xe_device *xe, struct xe_tile *tile
 		flags |= XE_BO_FLAG_GGTT;
 
 	bo = xe_bo_create_locked_range(xe, tile, vm, size, start, end, type,
-				       flags | XE_BO_FLAG_NEEDS_CPU_ACCESS);
+				       flags | XE_BO_FLAG_NEEDS_CPU_ACCESS,
+				       alignment);
 	if (IS_ERR(bo))
 		return bo;
 
@@ -2355,14 +2389,18 @@ void xe_bo_put_commit(struct llist_head *deferred)
 
 void xe_bo_put(struct xe_bo *bo)
 {
+	struct xe_tile *tile;
+	u8 id;
+
 	might_sleep();
 	if (bo) {
 #ifdef CONFIG_PROC_FS
 		if (bo->client)
 			might_lock(&bo->client->bos_lock);
 #endif
-		if (bo->ggtt_node && bo->ggtt_node->ggtt)
-			might_lock(&bo->ggtt_node->ggtt->lock);
+		for_each_tile(tile, xe_bo_device(bo), id)
+			if (bo->ggtt_node[id] && bo->ggtt_node[id]->ggtt)
+				might_lock(&bo->ggtt_node[id]->ggtt->lock);
 		drm_gem_object_put(&bo->ttm.base);
 	}
 }
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index d22269a230aa..d04159c59846 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -39,10 +39,22 @@
 #define XE_BO_FLAG_NEEDS_64K		BIT(15)
 #define XE_BO_FLAG_NEEDS_2M		BIT(16)
 #define XE_BO_FLAG_GGTT_INVALIDATE	BIT(17)
+#define XE_BO_FLAG_GGTT0                BIT(18)
+#define XE_BO_FLAG_GGTT1                BIT(19)
+#define XE_BO_FLAG_GGTT2                BIT(20)
+#define XE_BO_FLAG_GGTT3                BIT(21)
+#define XE_BO_FLAG_GGTT_ALL             (XE_BO_FLAG_GGTT0 | \
+					 XE_BO_FLAG_GGTT1 | \
+					 XE_BO_FLAG_GGTT2 | \
+					 XE_BO_FLAG_GGTT3)
+
 /* this one is trigger internally only */
 #define XE_BO_FLAG_INTERNAL_TEST	BIT(30)
 #define XE_BO_FLAG_INTERNAL_64K		BIT(31)
 
+#define XE_BO_FLAG_GGTTx(tile) \
+	(XE_BO_FLAG_GGTT0 << (tile)->id)
+
 #define XE_PTE_SHIFT			12
 #define XE_PAGE_SIZE			(1 << XE_PTE_SHIFT)
 #define XE_PTE_MASK			(XE_PAGE_SIZE - 1)
@@ -77,7 +89,7 @@ struct xe_bo *
 xe_bo_create_locked_range(struct xe_device *xe,
 			  struct xe_tile *tile, struct xe_vm *vm,
 			  size_t size, u64 start, u64 end,
-			  enum ttm_bo_type type, u32 flags);
+			  enum ttm_bo_type type, u32 flags, u64 alignment);
 struct xe_bo *xe_bo_create_locked(struct xe_device *xe, struct xe_tile *tile,
 				  struct xe_vm *vm, size_t size,
 				  enum ttm_bo_type type, u32 flags);
@@ -94,6 +106,12 @@ struct xe_bo *xe_bo_create_pin_map(struct xe_device *xe, struct xe_tile *tile,
 struct xe_bo *xe_bo_create_pin_map_at(struct xe_device *xe, struct xe_tile *tile,
 				      struct xe_vm *vm, size_t size, u64 offset,
 				      enum ttm_bo_type type, u32 flags);
+struct xe_bo *xe_bo_create_pin_map_at_aligned(struct xe_device *xe,
+					      struct xe_tile *tile,
+					      struct xe_vm *vm,
+					      size_t size, u64 offset,
+					      enum ttm_bo_type type, u32 flags,
+					      u64 alignment);
 struct xe_bo *xe_bo_create_from_data(struct xe_device *xe, struct xe_tile *tile,
 				     const void *data, size_t size,
 				     enum ttm_bo_type type, u32 flags);
@@ -188,14 +206,24 @@ xe_bo_main_addr(struct xe_bo *bo, size_t page_size)
 }
 
 static inline u32
-xe_bo_ggtt_addr(struct xe_bo *bo)
+__xe_bo_ggtt_addr(struct xe_bo *bo, u8 tile_id)
 {
-	if (XE_WARN_ON(!bo->ggtt_node))
+	struct xe_ggtt_node *ggtt_node = bo->ggtt_node[tile_id];
+
+	if (XE_WARN_ON(!ggtt_node))
 		return 0;
 
-	XE_WARN_ON(bo->ggtt_node->base.size > bo->size);
-	XE_WARN_ON(bo->ggtt_node->base.start + bo->ggtt_node->base.size > (1ull << 32));
-	return bo->ggtt_node->base.start;
+	XE_WARN_ON(ggtt_node->base.size > bo->size);
+	XE_WARN_ON(ggtt_node->base.start + ggtt_node->base.size > (1ull << 32));
+	return ggtt_node->base.start;
+}
+
+static inline u32
+xe_bo_ggtt_addr(struct xe_bo *bo)
+{
+	xe_assert(xe_bo_device(bo), bo->tile);
+
+	return __xe_bo_ggtt_addr(bo, bo->tile->id);
 }
 
 int xe_bo_vmap(struct xe_bo *bo);
diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
index 8fb2be061003..6a40eedd9db1 100644
--- a/drivers/gpu/drm/xe/xe_bo_evict.c
+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
@@ -152,11 +152,17 @@ int xe_bo_restore_kernel(struct xe_device *xe)
 		}
 
 		if (bo->flags & XE_BO_FLAG_GGTT) {
-			struct xe_tile *tile = bo->tile;
+			struct xe_tile *tile;
+			u8 id;
 
-			mutex_lock(&tile->mem.ggtt->lock);
-			xe_ggtt_map_bo(tile->mem.ggtt, bo);
-			mutex_unlock(&tile->mem.ggtt->lock);
+			for_each_tile(tile, xe, id) {
+				if (tile != bo->tile && !(bo->flags & XE_BO_FLAG_GGTTx(tile)))
+					continue;
+
+				mutex_lock(&tile->mem.ggtt->lock);
+				xe_ggtt_map_bo(tile->mem.ggtt, bo);
+				mutex_unlock(&tile->mem.ggtt->lock);
+			}
 		}
 
 		/*
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 2ed558ac2264..aa298d33c250 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -13,6 +13,7 @@
 #include <drm/ttm/ttm_execbuf_util.h>
 #include <drm/ttm/ttm_placement.h>
 
+#include "xe_device_types.h"
 #include "xe_ggtt_types.h"
 
 struct xe_device;
@@ -39,8 +40,8 @@ struct xe_bo {
 	struct ttm_place placements[XE_BO_MAX_PLACEMENTS];
 	/** @placement: current placement for this BO */
 	struct ttm_placement placement;
-	/** @ggtt_node: GGTT node if this BO is mapped in the GGTT */
-	struct xe_ggtt_node *ggtt_node;
+	/** @ggtt_node: Array of GGTT nodes if this BO is mapped in the GGTTs */
+	struct xe_ggtt_node *ggtt_node[XE_MAX_TILES_PER_DEVICE];
 	/** @vmap: iosys map of this buffer */
 	struct iosys_map vmap;
 	/** @ttm_kmap: TTM bo kmap object for internal use only. Keep off. */
@@ -76,6 +77,11 @@ struct xe_bo {
 
 	/** @vram_userfault_link: Link into @mem_access.vram_userfault.list */
 		struct list_head vram_userfault_link;
+
+	/** @min_align: minimum alignment needed for this BO if different
+	 * from default
+	 */
+	u64 min_align;
 };
 
 #define intel_bo_to_drm_bo(bo) (&(bo)->ttm.base)
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 0c3db53b93d8..82da51a6616a 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -37,6 +37,7 @@
 #include "xe_gt_printk.h"
 #include "xe_gt_sriov_vf.h"
 #include "xe_guc.h"
+#include "xe_guc_pc.h"
 #include "xe_hw_engine_group.h"
 #include "xe_hwmon.h"
 #include "xe_irq.h"
@@ -871,31 +872,37 @@ void xe_device_td_flush(struct xe_device *xe)
 	if (!IS_DGFX(xe) || GRAPHICS_VER(xe) < 20)
 		return;
 
-	if (XE_WA(xe_root_mmio_gt(xe), 16023588340)) {
+	gt = xe_root_mmio_gt(xe);
+	if (XE_WA(gt, 16023588340)) {
+		/* A transient flush is not sufficient: flush the L2 */
 		xe_device_l2_flush(xe);
-		return;
-	}
-
-	for_each_gt(gt, xe, id) {
-		if (xe_gt_is_media_type(gt))
-			continue;
-
-		if (xe_force_wake_get(gt_to_fw(gt), XE_FW_GT))
-			return;
-
-		xe_mmio_write32(gt, XE2_TDF_CTRL, TRANSIENT_FLUSH_REQUEST);
-		/*
-		 * FIXME: We can likely do better here with our choice of
-		 * timeout. Currently we just assume the worst case, i.e. 150us,
-		 * which is believed to be sufficient to cover the worst case
-		 * scenario on current platforms if all cache entries are
-		 * transient and need to be flushed..
-		 */
-		if (xe_mmio_wait32(gt, XE2_TDF_CTRL, TRANSIENT_FLUSH_REQUEST, 0,
-				   150, NULL, false))
-			xe_gt_err_once(gt, "TD flush timeout\n");
-
-		xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+	} else {
+		xe_guc_pc_apply_flush_freq_limit(&gt->uc.guc.pc);
+		
+		/* Execute TDF flush on all graphics GTs */
+		for_each_gt(gt, xe, id) {
+			if (xe_gt_is_media_type(gt))
+				continue;
+
+			if (xe_force_wake_get(gt_to_fw(gt), XE_FW_GT))
+				return;
+
+			xe_mmio_write32(gt, XE2_TDF_CTRL, TRANSIENT_FLUSH_REQUEST);
+			/*
+			 * FIXME: We can likely do better here with our choice of
+			 * timeout. Currently we just assume the worst case, i.e. 150us,
+			 * which is believed to be sufficient to cover the worst case
+			 * scenario on current platforms if all cache entries are
+			 * transient and need to be flushed..
+			 */
+			if (xe_mmio_wait32(gt, XE2_TDF_CTRL, TRANSIENT_FLUSH_REQUEST, 0,
+					   150, NULL, false))
+				xe_gt_err_once(gt, "TD flush timeout\n");
+
+			xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+		}
+		
+		xe_guc_pc_remove_flush_freq_limit(&xe_root_mmio_gt(xe)->uc.guc.pc);
 	}
 }
 
diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index e9820126feb9..76e1092f51d9 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -605,10 +605,10 @@ void xe_ggtt_map_bo(struct xe_ggtt *ggtt, struct xe_bo *bo)
 	u64 start;
 	u64 offset, pte;
 
-	if (XE_WARN_ON(!bo->ggtt_node))
+	if (XE_WARN_ON(!bo->ggtt_node[ggtt->tile->id]))
 		return;
 
-	start = bo->ggtt_node->base.start;
+	start = bo->ggtt_node[ggtt->tile->id]->base.start;
 
 	for (offset = 0; offset < bo->size; offset += XE_PAGE_SIZE) {
 		pte = ggtt->pt_ops->pte_encode_bo(bo, offset, pat_index);
@@ -619,15 +619,16 @@ void xe_ggtt_map_bo(struct xe_ggtt *ggtt, struct xe_bo *bo)
 static int __xe_ggtt_insert_bo_at(struct xe_ggtt *ggtt, struct xe_bo *bo,
 				  u64 start, u64 end)
 {
+	u64 alignment = bo->min_align > 0 ? bo->min_align : XE_PAGE_SIZE;
+	u8 tile_id = ggtt->tile->id;
 	int err;
-	u64 alignment = XE_PAGE_SIZE;
 
 	if (xe_bo_is_vram(bo) && ggtt->flags & XE_GGTT_FLAGS_64K)
 		alignment = SZ_64K;
 
-	if (XE_WARN_ON(bo->ggtt_node)) {
+	if (XE_WARN_ON(bo->ggtt_node[tile_id])) {
 		/* Someone's already inserted this BO in the GGTT */
-		xe_tile_assert(ggtt->tile, bo->ggtt_node->base.size == bo->size);
+		xe_tile_assert(ggtt->tile, bo->ggtt_node[tile_id]->base.size == bo->size);
 		return 0;
 	}
 
@@ -637,19 +638,19 @@ static int __xe_ggtt_insert_bo_at(struct xe_ggtt *ggtt, struct xe_bo *bo,
 
 	xe_pm_runtime_get_noresume(tile_to_xe(ggtt->tile));
 
-	bo->ggtt_node = xe_ggtt_node_init(ggtt);
-	if (IS_ERR(bo->ggtt_node)) {
-		err = PTR_ERR(bo->ggtt_node);
-		bo->ggtt_node = NULL;
+	bo->ggtt_node[tile_id] = xe_ggtt_node_init(ggtt);
+	if (IS_ERR(bo->ggtt_node[tile_id])) {
+		err = PTR_ERR(bo->ggtt_node[tile_id]);
+		bo->ggtt_node[tile_id] = NULL;
 		goto out;
 	}
 
 	mutex_lock(&ggtt->lock);
-	err = drm_mm_insert_node_in_range(&ggtt->mm, &bo->ggtt_node->base, bo->size,
-					  alignment, 0, start, end, 0);
+	err = drm_mm_insert_node_in_range(&ggtt->mm, &bo->ggtt_node[tile_id]->base,
+					  bo->size, alignment, 0, start, end, 0);
 	if (err) {
-		xe_ggtt_node_fini(bo->ggtt_node);
-		bo->ggtt_node = NULL;
+		xe_ggtt_node_fini(bo->ggtt_node[tile_id]);
+		bo->ggtt_node[tile_id] = NULL;
 	} else {
 		xe_ggtt_map_bo(ggtt, bo);
 	}
@@ -698,13 +699,15 @@ int xe_ggtt_insert_bo(struct xe_ggtt *ggtt, struct xe_bo *bo)
  */
 void xe_ggtt_remove_bo(struct xe_ggtt *ggtt, struct xe_bo *bo)
 {
-	if (XE_WARN_ON(!bo->ggtt_node))
+	u8 tile_id = ggtt->tile->id;
+
+	if (XE_WARN_ON(!bo->ggtt_node[tile_id]))
 		return;
 
 	/* This BO is not currently in the GGTT */
-	xe_tile_assert(ggtt->tile, bo->ggtt_node->base.size == bo->size);
+	xe_tile_assert(ggtt->tile, bo->ggtt_node[tile_id]->base.size == bo->size);
 
-	xe_ggtt_node_remove(bo->ggtt_node,
+	xe_ggtt_node_remove(bo->ggtt_node[tile_id],
 			    bo->flags & XE_BO_FLAG_GGTT_INVALIDATE);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 52df28032a6f..96373cdb366b 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -985,7 +985,7 @@ int xe_guc_mmio_send_recv(struct xe_guc *guc, const u32 *request,
 		BUILD_BUG_ON(FIELD_MAX(GUC_HXG_MSG_0_TYPE) != GUC_HXG_TYPE_RESPONSE_SUCCESS);
 		BUILD_BUG_ON((GUC_HXG_TYPE_RESPONSE_SUCCESS ^ GUC_HXG_TYPE_RESPONSE_FAILURE) != 1);
 
-		ret = xe_mmio_wait32(gt, reply_reg,  resp_mask, resp_mask,
+		ret = xe_mmio_wait32(gt, reply_reg, resp_mask, resp_mask,
 				     1000000, &header, false);
 
 		if (unlikely(FIELD_GET(GUC_HXG_MSG_0_ORIGIN, header) !=
@@ -1175,7 +1175,7 @@ void xe_guc_print_info(struct xe_guc *guc, struct drm_printer *p)
 
 	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
 
-	xe_guc_ct_print(&guc->ct, p, false);
+	xe_guc_ct_print(&guc->ct, p);
 	xe_guc_submit_print(guc, p);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 1f74f6bd50f3..f1ce4e14dcb5 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -25,12 +25,53 @@
 #include "xe_gt_sriov_pf_monitor.h"
 #include "xe_gt_tlb_invalidation.h"
 #include "xe_guc.h"
+#include "xe_guc_log.h"
 #include "xe_guc_relay.h"
 #include "xe_guc_submit.h"
 #include "xe_map.h"
 #include "xe_pm.h"
 #include "xe_trace_guc.h"
 
+static void receive_g2h(struct xe_guc_ct *ct);
+static void g2h_worker_func(struct work_struct *w);
+static void safe_mode_worker_func(struct work_struct *w);
+static void ct_exit_safe_mode(struct xe_guc_ct *ct);
+
+#if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
+enum {
+	/* Internal states, not error conditions */
+	CT_DEAD_STATE_REARM,			/* 0x0001 */
+	CT_DEAD_STATE_CAPTURE,			/* 0x0002 */
+
+	/* Error conditions */
+	CT_DEAD_SETUP,				/* 0x0004 */
+	CT_DEAD_H2G_WRITE,			/* 0x0008 */
+	CT_DEAD_H2G_HAS_ROOM,			/* 0x0010 */
+	CT_DEAD_G2H_READ,			/* 0x0020 */
+	CT_DEAD_G2H_RECV,			/* 0x0040 */
+	CT_DEAD_G2H_RELEASE,			/* 0x0080 */
+	CT_DEAD_DEADLOCK,			/* 0x0100 */
+	CT_DEAD_PROCESS_FAILED,			/* 0x0200 */
+	CT_DEAD_FAST_G2H,			/* 0x0400 */
+	CT_DEAD_PARSE_G2H_RESPONSE,		/* 0x0800 */
+	CT_DEAD_PARSE_G2H_UNKNOWN,		/* 0x1000 */
+	CT_DEAD_PARSE_G2H_ORIGIN,		/* 0x2000 */
+	CT_DEAD_PARSE_G2H_TYPE,			/* 0x4000 */
+};
+
+static void ct_dead_worker_func(struct work_struct *w);
+static void ct_dead_capture(struct xe_guc_ct *ct, struct guc_ctb *ctb, u32 reason_code);
+
+#define CT_DEAD(ct, ctb, reason_code)		ct_dead_capture((ct), (ctb), CT_DEAD_##reason_code)
+#else
+#define CT_DEAD(ct, ctb, reason)			\
+	do {						\
+		struct guc_ctb *_ctb = (ctb);		\
+		if (_ctb)				\
+			_ctb->info.broken = true;	\
+	} while (0)
+#endif
+
 /* Used when a CT send wants to block and / or receive data */
 struct g2h_fence {
 	u32 *response_buffer;
@@ -147,14 +188,11 @@ static void guc_ct_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc_ct *ct = arg;
 
+	ct_exit_safe_mode(ct);
 	destroy_workqueue(ct->g2h_wq);
 	xa_destroy(&ct->fence_lookup);
 }
 
-static void receive_g2h(struct xe_guc_ct *ct);
-static void g2h_worker_func(struct work_struct *w);
-static void safe_mode_worker_func(struct work_struct *w);
-
 static void primelockdep(struct xe_guc_ct *ct)
 {
 	if (!IS_ENABLED(CONFIG_LOCKDEP))
@@ -182,7 +220,11 @@ int xe_guc_ct_init(struct xe_guc_ct *ct)
 	spin_lock_init(&ct->fast_lock);
 	xa_init(&ct->fence_lookup);
 	INIT_WORK(&ct->g2h_worker, g2h_worker_func);
-	INIT_DELAYED_WORK(&ct->safe_mode_worker,  safe_mode_worker_func);
+	INIT_DELAYED_WORK(&ct->safe_mode_worker, safe_mode_worker_func);
+#if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
+	spin_lock_init(&ct->dead.lock);
+	INIT_WORK(&ct->dead.worker, ct_dead_worker_func);
+#endif
 	init_waitqueue_head(&ct->wq);
 	init_waitqueue_head(&ct->g2h_fence_wq);
 
@@ -419,10 +461,22 @@ int xe_guc_ct_enable(struct xe_guc_ct *ct)
 	if (ct_needs_safe_mode(ct))
 		ct_enter_safe_mode(ct);
 
+#if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
+	/*
+	 * The CT has now been reset so the dumper can be re-armed
+	 * after any existing dead state has been dumped.
+	 */
+	spin_lock_irq(&ct->dead.lock);
+	if (ct->dead.reason)
+		ct->dead.reason |= (1 << CT_DEAD_STATE_REARM);
+	spin_unlock_irq(&ct->dead.lock);
+#endif
+
 	return 0;
 
 err_out:
 	xe_gt_err(gt, "Failed to enable GuC CT (%pe)\n", ERR_PTR(err));
+	CT_DEAD(ct, NULL, SETUP);
 
 	return err;
 }
@@ -469,6 +523,19 @@ static bool h2g_has_room(struct xe_guc_ct *ct, u32 cmd_len)
 
 	if (cmd_len > h2g->info.space) {
 		h2g->info.head = desc_read(ct_to_xe(ct), h2g, head);
+
+		if (h2g->info.head > h2g->info.size) {
+			struct xe_device *xe = ct_to_xe(ct);
+			u32 desc_status = desc_read(xe, h2g, status);
+
+			desc_write(xe, h2g, status, desc_status | GUC_CTB_STATUS_OVERFLOW);
+
+			xe_gt_err(ct_to_gt(ct), "CT: invalid head offset %u >= %u)\n",
+				  h2g->info.head, h2g->info.size);
+			CT_DEAD(ct, h2g, H2G_HAS_ROOM);
+			return false;
+		}
+
 		h2g->info.space = CIRC_SPACE(h2g->info.tail, h2g->info.head,
 					     h2g->info.size) -
 				  h2g->info.resv_space;
@@ -524,10 +591,24 @@ static void __g2h_reserve_space(struct xe_guc_ct *ct, u32 g2h_len, u32 num_g2h)
 
 static void __g2h_release_space(struct xe_guc_ct *ct, u32 g2h_len)
 {
+	bool bad = false;
+
 	lockdep_assert_held(&ct->fast_lock);
-	xe_gt_assert(ct_to_gt(ct), ct->ctbs.g2h.info.space + g2h_len <=
-		     ct->ctbs.g2h.info.size - ct->ctbs.g2h.info.resv_space);
-	xe_gt_assert(ct_to_gt(ct), ct->g2h_outstanding);
+
+	bad = ct->ctbs.g2h.info.space + g2h_len >
+		     ct->ctbs.g2h.info.size - ct->ctbs.g2h.info.resv_space;
+	bad |= !ct->g2h_outstanding;
+
+	if (bad) {
+		xe_gt_err(ct_to_gt(ct), "Invalid G2H release: %d + %d vs %d - %d -> %d vs %d, outstanding = %d!\n",
+			  ct->ctbs.g2h.info.space, g2h_len,
+			  ct->ctbs.g2h.info.size, ct->ctbs.g2h.info.resv_space,
+			  ct->ctbs.g2h.info.space + g2h_len,
+			  ct->ctbs.g2h.info.size - ct->ctbs.g2h.info.resv_space,
+			  ct->g2h_outstanding);
+		CT_DEAD(ct, &ct->ctbs.g2h, G2H_RELEASE);
+		return;
+	}
 
 	ct->ctbs.g2h.info.space += g2h_len;
 	if (!--ct->g2h_outstanding)
@@ -554,12 +635,43 @@ static int h2g_write(struct xe_guc_ct *ct, const u32 *action, u32 len,
 	u32 full_len;
 	struct iosys_map map = IOSYS_MAP_INIT_OFFSET(&h2g->cmds,
 							 tail * sizeof(u32));
+	u32 desc_status;
 
 	full_len = len + GUC_CTB_HDR_LEN;
 
 	lockdep_assert_held(&ct->lock);
 	xe_gt_assert(gt, full_len <= GUC_CTB_MSG_MAX_LEN);
-	xe_gt_assert(gt, tail <= h2g->info.size);
+
+	desc_status = desc_read(xe, h2g, status);
+	if (desc_status) {
+		xe_gt_err(gt, "CT write: non-zero status: %u\n", desc_status);
+		goto corrupted;
+	}
+
+	if (IS_ENABLED(CONFIG_DRM_XE_DEBUG)) {
+		u32 desc_tail = desc_read(xe, h2g, tail);
+		u32 desc_head = desc_read(xe, h2g, head);
+
+		if (tail != desc_tail) {
+			desc_write(xe, h2g, status, desc_status | GUC_CTB_STATUS_MISMATCH);
+			xe_gt_err(gt, "CT write: tail was modified %u != %u\n", desc_tail, tail);
+			goto corrupted;
+		}
+
+		if (tail > h2g->info.size) {
+			desc_write(xe, h2g, status, desc_status | GUC_CTB_STATUS_OVERFLOW);
+			xe_gt_err(gt, "CT write: tail out of range: %u vs %u\n",
+				  tail, h2g->info.size);
+			goto corrupted;
+		}
+
+		if (desc_head >= h2g->info.size) {
+			desc_write(xe, h2g, status, desc_status | GUC_CTB_STATUS_OVERFLOW);
+			xe_gt_err(gt, "CT write: invalid head offset %u >= %u)\n",
+				  desc_head, h2g->info.size);
+			goto corrupted;
+		}
+	}
 
 	/* Command will wrap, zero fill (NOPs), return and check credits again */
 	if (tail + full_len > h2g->info.size) {
@@ -612,6 +724,10 @@ static int h2g_write(struct xe_guc_ct *ct, const u32 *action, u32 len,
 			     desc_read(xe, h2g, head), h2g->info.tail);
 
 	return 0;
+
+corrupted:
+	CT_DEAD(ct, &ct->ctbs.h2g, H2G_WRITE);
+	return -EPIPE;
 }
 
 /*
@@ -719,7 +835,6 @@ static int guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action, u32 len,
 {
 	struct xe_device *xe = ct_to_xe(ct);
 	struct xe_gt *gt = ct_to_gt(ct);
-	struct drm_printer p = xe_gt_info_printer(gt);
 	unsigned int sleep_period_ms = 1;
 	int ret;
 
@@ -772,8 +887,13 @@ static int guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action, u32 len,
 			goto broken;
 #undef g2h_avail
 
-		if (dequeue_one_g2h(ct) < 0)
+		ret = dequeue_one_g2h(ct);
+		if (ret < 0) {
+			if (ret != -ECANCELED)
+				xe_gt_err(ct_to_gt(ct), "CTB receive failed (%pe)",
+					  ERR_PTR(ret));
 			goto broken;
+		}
 
 		goto try_again;
 	}
@@ -782,8 +902,7 @@ static int guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action, u32 len,
 
 broken:
 	xe_gt_err(gt, "No forward process on H2G, reset required\n");
-	xe_guc_ct_print(ct, &p, true);
-	ct->ctbs.h2g.info.broken = true;
+	CT_DEAD(ct, &ct->ctbs.h2g, DEADLOCK);
 
 	return -EDEADLK;
 }
@@ -851,7 +970,7 @@ static bool retry_failure(struct xe_guc_ct *ct, int ret)
 #define ct_alive(ct)	\
 	(xe_guc_ct_enabled(ct) && !ct->ctbs.h2g.info.broken && \
 	 !ct->ctbs.g2h.info.broken)
-	if (!wait_event_interruptible_timeout(ct->wq, ct_alive(ct),  HZ * 5))
+	if (!wait_event_interruptible_timeout(ct->wq, ct_alive(ct), HZ * 5))
 		return false;
 #undef ct_alive
 
@@ -1049,6 +1168,7 @@ static int parse_g2h_response(struct xe_guc_ct *ct, u32 *msg, u32 len)
 		else
 			xe_gt_err(gt, "unexpected response %u for FAST_REQ H2G fence 0x%x!\n",
 				  type, fence);
+		CT_DEAD(ct, NULL, PARSE_G2H_RESPONSE);
 
 		return -EPROTO;
 	}
@@ -1056,6 +1176,7 @@ static int parse_g2h_response(struct xe_guc_ct *ct, u32 *msg, u32 len)
 	g2h_fence = xa_erase(&ct->fence_lookup, fence);
 	if (unlikely(!g2h_fence)) {
 		/* Don't tear down channel, as send could've timed out */
+		/* CT_DEAD(ct, NULL, PARSE_G2H_UNKNOWN); */
 		xe_gt_warn(gt, "G2H fence (%u) not found!\n", fence);
 		g2h_release_space(ct, GUC_CTB_HXG_MSG_MAX_LEN);
 		return 0;
@@ -1100,7 +1221,7 @@ static int parse_g2h_msg(struct xe_guc_ct *ct, u32 *msg, u32 len)
 	if (unlikely(origin != GUC_HXG_ORIGIN_GUC)) {
 		xe_gt_err(gt, "G2H channel broken on read, origin=%u, reset required\n",
 			  origin);
-		ct->ctbs.g2h.info.broken = true;
+		CT_DEAD(ct, &ct->ctbs.g2h, PARSE_G2H_ORIGIN);
 
 		return -EPROTO;
 	}
@@ -1118,7 +1239,7 @@ static int parse_g2h_msg(struct xe_guc_ct *ct, u32 *msg, u32 len)
 	default:
 		xe_gt_err(gt, "G2H channel broken on read, type=%u, reset required\n",
 			  type);
-		ct->ctbs.g2h.info.broken = true;
+		CT_DEAD(ct, &ct->ctbs.g2h, PARSE_G2H_TYPE);
 
 		ret = -EOPNOTSUPP;
 	}
@@ -1195,9 +1316,11 @@ static int process_g2h_msg(struct xe_guc_ct *ct, u32 *msg, u32 len)
 		xe_gt_err(gt, "unexpected G2H action 0x%04x\n", action);
 	}
 
-	if (ret)
+	if (ret) {
 		xe_gt_err(gt, "G2H action 0x%04x failed (%pe)\n",
 			  action, ERR_PTR(ret));
+		CT_DEAD(ct, NULL, PROCESS_FAILED);
+	}
 
 	return 0;
 }
@@ -1207,7 +1330,7 @@ static int g2h_read(struct xe_guc_ct *ct, u32 *msg, bool fast_path)
 	struct xe_device *xe = ct_to_xe(ct);
 	struct xe_gt *gt = ct_to_gt(ct);
 	struct guc_ctb *g2h = &ct->ctbs.g2h;
-	u32 tail, head, len;
+	u32 tail, head, len, desc_status;
 	s32 avail;
 	u32 action;
 	u32 *hxg;
@@ -1226,6 +1349,63 @@ static int g2h_read(struct xe_guc_ct *ct, u32 *msg, bool fast_path)
 
 	xe_gt_assert(gt, xe_guc_ct_enabled(ct));
 
+	desc_status = desc_read(xe, g2h, status);
+	if (desc_status) {
+		if (desc_status & GUC_CTB_STATUS_DISABLED) {
+			/*
+			 * Potentially valid if a CLIENT_RESET request resulted in
+			 * contexts/engines being reset. But should never happen as
+			 * no contexts should be active when CLIENT_RESET is sent.
+			 */
+			xe_gt_err(gt, "CT read: unexpected G2H after GuC has stopped!\n");
+			desc_status &= ~GUC_CTB_STATUS_DISABLED;
+		}
+
+		if (desc_status) {
+			xe_gt_err(gt, "CT read: non-zero status: %u\n", desc_status);
+			goto corrupted;
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_DRM_XE_DEBUG)) {
+		u32 desc_tail = desc_read(xe, g2h, tail);
+		/*
+		u32 desc_head = desc_read(xe, g2h, head);
+
+		 * info.head and desc_head are updated back-to-back at the end of
+		 * this function and nowhere else. Hence, they cannot be different
+		 * unless two g2h_read calls are running concurrently. Which is not
+		 * possible because it is guarded by ct->fast_lock. And yet, some
+		 * discrete platforms are reguarly hitting this error :(.
+		 *
+		 * desc_head rolling backwards shouldn't cause any noticeable
+		 * problems - just a delay in GuC being allowed to proceed past that
+		 * point in the queue. So for now, just disable the error until it
+		 * can be root caused.
+		 *
+		if (g2h->info.head != desc_head) {
+			desc_write(xe, g2h, status, desc_status | GUC_CTB_STATUS_MISMATCH);
+			xe_gt_err(gt, "CT read: head was modified %u != %u\n",
+				  desc_head, g2h->info.head);
+			goto corrupted;
+		}
+		 */
+
+		if (g2h->info.head > g2h->info.size) {
+			desc_write(xe, g2h, status, desc_status | GUC_CTB_STATUS_OVERFLOW);
+			xe_gt_err(gt, "CT read: head out of range: %u vs %u\n",
+				  g2h->info.head, g2h->info.size);
+			goto corrupted;
+		}
+
+		if (desc_tail >= g2h->info.size) {
+			desc_write(xe, g2h, status, desc_status | GUC_CTB_STATUS_OVERFLOW);
+			xe_gt_err(gt, "CT read: invalid tail offset %u >= %u)\n",
+				  desc_tail, g2h->info.size);
+			goto corrupted;
+		}
+	}
+
 	/* Calculate DW available to read */
 	tail = desc_read(xe, g2h, tail);
 	avail = tail - g2h->info.head;
@@ -1242,9 +1422,7 @@ static int g2h_read(struct xe_guc_ct *ct, u32 *msg, bool fast_path)
 	if (len > avail) {
 		xe_gt_err(gt, "G2H channel broken on read, avail=%d, len=%d, reset required\n",
 			  avail, len);
-		g2h->info.broken = true;
-
-		return -EPROTO;
+		goto corrupted;
 	}
 
 	head = (g2h->info.head + 1) % g2h->info.size;
@@ -1290,6 +1468,10 @@ static int g2h_read(struct xe_guc_ct *ct, u32 *msg, bool fast_path)
 			     action, len, g2h->info.head, tail);
 
 	return len;
+
+corrupted:
+	CT_DEAD(ct, &ct->ctbs.g2h, G2H_READ);
+	return -EPROTO;
 }
 
 static void g2h_fast_path(struct xe_guc_ct *ct, u32 *msg, u32 len)
@@ -1316,9 +1498,11 @@ static void g2h_fast_path(struct xe_guc_ct *ct, u32 *msg, u32 len)
 		xe_gt_warn(gt, "NOT_POSSIBLE");
 	}
 
-	if (ret)
+	if (ret) {
 		xe_gt_err(gt, "G2H action 0x%04x failed (%pe)\n",
 			  action, ERR_PTR(ret));
+		CT_DEAD(ct, NULL, FAST_G2H);
+	}
 }
 
 /**
@@ -1378,7 +1562,6 @@ static int dequeue_one_g2h(struct xe_guc_ct *ct)
 
 static void receive_g2h(struct xe_guc_ct *ct)
 {
-	struct xe_gt *gt = ct_to_gt(ct);
 	bool ongoing;
 	int ret;
 
@@ -1415,9 +1598,8 @@ static void receive_g2h(struct xe_guc_ct *ct)
 		mutex_unlock(&ct->lock);
 
 		if (unlikely(ret == -EPROTO || ret == -EOPNOTSUPP)) {
-			struct drm_printer p = xe_gt_info_printer(gt);
-
-			xe_guc_ct_print(ct, &p, false);
+			xe_gt_err(ct_to_gt(ct), "CT dequeue failed: %d", ret);
+			CT_DEAD(ct, NULL, G2H_RECV);
 			kick_reset(ct);
 		}
 	} while (ret == 1);
@@ -1445,9 +1627,8 @@ static void guc_ctb_snapshot_capture(struct xe_device *xe, struct guc_ctb *ctb,
 
 	snapshot->cmds = kmalloc_array(ctb->info.size, sizeof(u32),
 				       atomic ? GFP_ATOMIC : GFP_KERNEL);
-
 	if (!snapshot->cmds) {
-		drm_err(&xe->drm, "Skipping CTB commands snapshot. Only CTB info will be available.\n");
+		drm_err(&xe->drm, "Skipping CTB commands snapshot. Only CT info will be available.\n");
 		return;
 	}
 
@@ -1528,7 +1709,7 @@ struct xe_guc_ct_snapshot *xe_guc_ct_snapshot_capture(struct xe_guc_ct *ct,
 			   atomic ? GFP_ATOMIC : GFP_KERNEL);
 
 	if (!snapshot) {
-		drm_err(&xe->drm, "Skipping CTB snapshot entirely.\n");
+		xe_gt_err(ct_to_gt(ct), "Skipping CTB snapshot entirely.\n");
 		return NULL;
 	}
 
@@ -1592,16 +1773,119 @@ void xe_guc_ct_snapshot_free(struct xe_guc_ct_snapshot *snapshot)
  * xe_guc_ct_print - GuC CT Print.
  * @ct: GuC CT.
  * @p: drm_printer where it will be printed out.
- * @atomic: Boolean to indicate if this is called from atomic context like
- * reset or CTB handler or from some regular path like debugfs.
  *
  * This function quickly capture a snapshot and immediately print it out.
  */
-void xe_guc_ct_print(struct xe_guc_ct *ct, struct drm_printer *p, bool atomic)
+void xe_guc_ct_print(struct xe_guc_ct *ct, struct drm_printer *p)
 {
 	struct xe_guc_ct_snapshot *snapshot;
 
-	snapshot = xe_guc_ct_snapshot_capture(ct, atomic);
+	snapshot = xe_guc_ct_snapshot_capture(ct, false);
 	xe_guc_ct_snapshot_print(snapshot, p);
 	xe_guc_ct_snapshot_free(snapshot);
 }
+
+#if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
+static void ct_dead_capture(struct xe_guc_ct *ct, struct guc_ctb *ctb, u32 reason_code)
+{
+	struct xe_guc_log_snapshot *snapshot_log;
+	struct xe_guc_ct_snapshot *snapshot_ct;
+	struct xe_guc *guc = ct_to_guc(ct);
+	unsigned long flags;
+	bool have_capture;
+
+	if (ctb)
+		ctb->info.broken = true;
+
+	/* Ignore further errors after the first dump until a reset */
+	if (ct->dead.reported)
+		return;
+
+	spin_lock_irqsave(&ct->dead.lock, flags);
+
+	/* And only capture one dump at a time */
+	have_capture = ct->dead.reason & (1 << CT_DEAD_STATE_CAPTURE);
+	ct->dead.reason |= (1 << reason_code) |
+			   (1 << CT_DEAD_STATE_CAPTURE);
+
+	spin_unlock_irqrestore(&ct->dead.lock, flags);
+
+	if (have_capture)
+		return;
+
+	snapshot_log = xe_guc_log_snapshot_capture(&guc->log, true);
+	snapshot_ct = xe_guc_ct_snapshot_capture((ct), true);
+
+	spin_lock_irqsave(&ct->dead.lock, flags);
+
+	if (ct->dead.snapshot_log || ct->dead.snapshot_ct) {
+		xe_gt_err(ct_to_gt(ct), "Got unexpected dead CT capture!\n");
+		xe_guc_log_snapshot_free(snapshot_log);
+		xe_guc_ct_snapshot_free(snapshot_ct);
+	} else {
+		ct->dead.snapshot_log = snapshot_log;
+		ct->dead.snapshot_ct = snapshot_ct;
+	}
+
+	spin_unlock_irqrestore(&ct->dead.lock, flags);
+
+	queue_work(system_unbound_wq, &(ct)->dead.worker);
+}
+
+static void ct_dead_print(struct xe_dead_ct *dead)
+{
+	struct xe_guc_ct *ct = container_of(dead, struct xe_guc_ct, dead);
+	struct xe_device *xe = ct_to_xe(ct);
+	struct xe_gt *gt = ct_to_gt(ct);
+	static int g_count;
+	struct drm_printer ip = xe_gt_info_printer(gt);
+	struct drm_printer lp = drm_line_printer(&ip, "Capture", ++g_count);
+
+	if (!dead->reason) {
+		xe_gt_err(gt, "CTB is dead for no reason!?\n");
+		return;
+	}
+
+	drm_printf(&lp, "CTB is dead - reason=0x%X\n", dead->reason);
+
+	/* Can't generate a genuine core dump at this point, so just do the good bits */
+	drm_puts(&lp, "**** Xe Device Coredump ****\n");
+	xe_device_snapshot_print(xe, &lp);
+
+	drm_printf(&lp, "**** GT #%d ****\n", gt->info.id);
+	drm_printf(&lp, "\tTile: %d\n", gt->tile->id);
+
+	drm_puts(&lp, "**** GuC Log ****\n");
+	xe_guc_log_snapshot_print(dead->snapshot_log, &lp);
+
+	drm_puts(&lp, "**** GuC CT ****\n");
+	xe_guc_ct_snapshot_print(dead->snapshot_ct, &lp);
+
+	drm_puts(&lp, "Done.\n");
+}
+
+static void ct_dead_worker_func(struct work_struct *w)
+{
+	struct xe_guc_ct *ct = container_of(w, struct xe_guc_ct, dead.worker);
+
+	if (!ct->dead.reported) {
+		ct->dead.reported = true;
+		ct_dead_print(&ct->dead);
+	}
+
+	spin_lock_irq(&ct->dead.lock);
+
+	xe_guc_log_snapshot_free(ct->dead.snapshot_log);
+	ct->dead.snapshot_log = NULL;
+	xe_guc_ct_snapshot_free(ct->dead.snapshot_ct);
+	ct->dead.snapshot_ct = NULL;
+
+	if (ct->dead.reason & (1 << CT_DEAD_STATE_REARM)) {
+		/* A reset has occurred so re-arm the error reporting */
+		ct->dead.reason = 0;
+		ct->dead.reported = false;
+	}
+
+	spin_unlock_irq(&ct->dead.lock);
+}
+#endif
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
index 13e316668e90..c7ac9407b861 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct.h
@@ -21,7 +21,7 @@ xe_guc_ct_snapshot_capture(struct xe_guc_ct *ct, bool atomic);
 void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot,
 			      struct drm_printer *p);
 void xe_guc_ct_snapshot_free(struct xe_guc_ct_snapshot *snapshot);
-void xe_guc_ct_print(struct xe_guc_ct *ct, struct drm_printer *p, bool atomic);
+void xe_guc_ct_print(struct xe_guc_ct *ct, struct drm_printer *p);
 
 static inline bool xe_guc_ct_initialized(struct xe_guc_ct *ct)
 {
diff --git a/drivers/gpu/drm/xe/xe_guc_ct_types.h b/drivers/gpu/drm/xe/xe_guc_ct_types.h
index 761cb9031298..85e127ec91d7 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct_types.h
@@ -86,6 +86,24 @@ enum xe_guc_ct_state {
 	XE_GUC_CT_STATE_ENABLED,
 };
 
+#if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
+/** struct xe_dead_ct - Information for debugging a dead CT */
+struct xe_dead_ct {
+	/** @lock: protects memory allocation/free operations, and @reason updates */
+	spinlock_t lock;
+	/** @reason: bit mask of CT_DEAD_* reason codes */
+	unsigned int reason;
+	/** @reported: for preventing multiple dumps per error sequence */
+	bool reported;
+	/** @worker: worker thread to get out of interrupt context before dumping */
+	struct work_struct worker;
+	/** snapshot_ct: copy of CT state and CTB content at point of error */
+	struct xe_guc_ct_snapshot *snapshot_ct;
+	/** snapshot_log: copy of GuC log at point of error */
+	struct xe_guc_log_snapshot *snapshot_log;
+};
+#endif
+
 /**
  * struct xe_guc_ct - GuC command transport (CT) layer
  *
@@ -128,6 +146,11 @@ struct xe_guc_ct {
 	u32 msg[GUC_CTB_MSG_MAX_LEN];
 	/** @fast_msg: Message buffer */
 	u32 fast_msg[GUC_CTB_MSG_MAX_LEN];
+
+#if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
+	/** @dead: information for debugging dead CTs */
+	struct xe_dead_ct dead;
+#endif
 };
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index f978da8be35c..af02803c145b 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -6,6 +6,9 @@
 #include "xe_guc_pc.h"
 
 #include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <linux/wait_bit.h>
 
 #include <drm/drm_managed.h>
 #include <generated/xe_wa_oob.h>
@@ -47,6 +50,12 @@
 
 #define LNL_MERT_FREQ_CAP	800
 #define BMG_MERT_FREQ_CAP	2133
+#define BMG_MIN_FREQ		1200
+#define BMG_MERT_FLUSH_FREQ_CAP	2600
+
+#define SLPC_RESET_TIMEOUT_MS 5 /* roughly 5ms, but no need for precision */
+#define SLPC_RESET_EXTENDED_TIMEOUT_MS 1000 /* To be used only at pc_start */
+#define SLPC_ACT_FREQ_TIMEOUT_MS 100
 
 /**
  * DOC: GuC Power Conservation (PC)
@@ -133,6 +142,36 @@ static int wait_for_pc_state(struct xe_guc_pc *pc,
 	return -ETIMEDOUT;
 }
 
+static int wait_for_flush_complete(struct xe_guc_pc *pc)
+{
+	const unsigned long timeout = msecs_to_jiffies(30);
+
+	if (!wait_var_event_timeout(&pc->flush_freq_limit,
+				    !atomic_read(&pc->flush_freq_limit),
+				    timeout))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int wait_for_act_freq_limit(struct xe_guc_pc *pc, u32 freq)
+{
+	int timeout_us = SLPC_ACT_FREQ_TIMEOUT_MS * USEC_PER_MSEC;
+	int slept, wait = 10;
+
+	for (slept = 0; slept < timeout_us;) {
+		if (xe_guc_pc_get_act_freq(pc) <= freq)
+			return 0;
+
+		usleep_range(wait, wait << 1);
+		slept += wait;
+		wait <<= 1;
+		if (slept + wait > timeout_us)
+			wait = timeout_us - slept;
+	}
+
+	return -ETIMEDOUT;
+}
 static int pc_action_reset(struct xe_guc_pc *pc)
 {
 	struct xe_guc_ct *ct = pc_to_ct(pc);
@@ -584,6 +623,11 @@ int xe_guc_pc_set_max_freq(struct xe_guc_pc *pc, u32 freq)
 {
 	int ret;
 
+	if (XE_WA(pc_to_gt(pc), 22019338487)) {
+		if (wait_for_flush_complete(pc) != 0)
+			return -EAGAIN;
+	}
+
 	mutex_lock(&pc->freq_lock);
 	if (!pc->freq_ready) {
 		/* Might be in the middle of a gt reset */
@@ -793,6 +837,106 @@ static int pc_adjust_requested_freq(struct xe_guc_pc *pc)
 	return ret;
 }
 
+static bool needs_flush_freq_limit(struct xe_guc_pc *pc)
+{
+	struct xe_gt *gt = pc_to_gt(pc);
+
+	return  XE_WA(gt, 22019338487) &&
+		pc->rp0_freq > BMG_MERT_FLUSH_FREQ_CAP;
+}
+
+/**
+ * xe_guc_pc_apply_flush_freq_limit() - Limit max GT freq during L2 flush
+ * @pc: the xe_guc_pc object
+ *
+ * As per the WA, reduce max GT frequency during L2 cache flush
+ */
+void xe_guc_pc_apply_flush_freq_limit(struct xe_guc_pc *pc)
+{
+	struct xe_gt *gt = pc_to_gt(pc);
+	u32 max_freq;
+	int ret;
+
+	if (!needs_flush_freq_limit(pc))
+		return;
+
+	mutex_lock(&pc->freq_lock);
+
+	if (!pc->freq_ready) {
+		mutex_unlock(&pc->freq_lock);
+		return;
+	}
+
+	ret = pc_action_query_task_state(pc);
+	if (ret) {
+		mutex_unlock(&pc->freq_lock);
+		return;
+	}
+
+	max_freq = pc_get_max_freq(pc);
+	if (max_freq > BMG_MERT_FLUSH_FREQ_CAP) {
+		ret = pc_set_max_freq(pc, BMG_MERT_FLUSH_FREQ_CAP);
+		if (ret) {
+			xe_gt_err_once(gt, "Failed to cap max freq on flush to %u, %pe\n",
+				       BMG_MERT_FLUSH_FREQ_CAP, ERR_PTR(ret));
+			mutex_unlock(&pc->freq_lock);
+			return;
+		}
+
+		atomic_set(&pc->flush_freq_limit, 1);
+
+		/*
+		 * If user has previously changed max freq, stash that value to
+		 * restore later, otherwise use the current max. New user
+		 * requests wait on flush.
+		 */
+		if (pc->user_requested_max != 0)
+			pc->stashed_max_freq = pc->user_requested_max;
+		else
+			pc->stashed_max_freq = max_freq;
+	}
+
+	mutex_unlock(&pc->freq_lock);
+
+	/*
+	 * Wait for actual freq to go below the flush cap: even if the previous
+	 * max was below cap, the current one might still be above it
+	 */
+	ret = wait_for_act_freq_limit(pc, BMG_MERT_FLUSH_FREQ_CAP);
+	if (ret)
+		xe_gt_err_once(gt, "Actual freq did not reduce to %u, %pe\n",
+			       BMG_MERT_FLUSH_FREQ_CAP, ERR_PTR(ret));
+}
+
+/**
+ * xe_guc_pc_remove_flush_freq_limit() - Remove max GT freq limit after L2 flush completes.
+ * @pc: the xe_guc_pc object
+ *
+ * Retrieve the previous GT max frequency value.
+ */
+void xe_guc_pc_remove_flush_freq_limit(struct xe_guc_pc *pc)
+{
+	struct xe_gt *gt = pc_to_gt(pc);
+	int ret = 0;
+
+	if (!needs_flush_freq_limit(pc))
+		return;
+
+	if (!atomic_read(&pc->flush_freq_limit))
+		return;
+
+	mutex_lock(&pc->freq_lock);
+
+	ret = pc_set_max_freq(&gt->uc.guc.pc, pc->stashed_max_freq);
+	if (ret)
+		xe_gt_err_once(gt, "Failed to restore max freq %u:%d",
+			       pc->stashed_max_freq, ret);
+
+	atomic_set(&pc->flush_freq_limit, 0);
+	mutex_unlock(&pc->freq_lock);
+	wake_up_var(&pc->flush_freq_limit);
+}
+
 static int pc_set_mert_freq_cap(struct xe_guc_pc *pc)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.h b/drivers/gpu/drm/xe/xe_guc_pc.h
index efda432fadfc..7154b3aab0d8 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.h
+++ b/drivers/gpu/drm/xe/xe_guc_pc.h
@@ -34,5 +34,7 @@ u64 xe_guc_pc_mc6_residency(struct xe_guc_pc *pc);
 void xe_guc_pc_init_early(struct xe_guc_pc *pc);
 int xe_guc_pc_restore_stashed_freq(struct xe_guc_pc *pc);
 void xe_guc_pc_raise_unslice(struct xe_guc_pc *pc);
+void xe_guc_pc_apply_flush_freq_limit(struct xe_guc_pc *pc);
+void xe_guc_pc_remove_flush_freq_limit(struct xe_guc_pc *pc);
 
 #endif /* _XE_GUC_PC_H_ */
diff --git a/drivers/gpu/drm/xe/xe_guc_pc_types.h b/drivers/gpu/drm/xe/xe_guc_pc_types.h
index 13810be015db..5b86d91296cb 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_pc_types.h
@@ -15,6 +15,8 @@
 struct xe_guc_pc {
 	/** @bo: GGTT buffer object that is shared with GuC PC */
 	struct xe_bo *bo;
+	/** @flush_freq_limit: 1 when max freq changes are limited by driver */
+	atomic_t flush_freq_limit;
 	/** @rp0_freq: HW RP0 frequency - The Maximum one */
 	u32 rp0_freq;
 	/** @rpe_freq: HW RPe frequency - The Efficient one */
diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
index 5f2c368c35ad..14c3a476597a 100644
--- a/drivers/gpu/drm/xe/xe_irq.c
+++ b/drivers/gpu/drm/xe/xe_irq.c
@@ -173,7 +173,7 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
 		if (ccs_mask & (BIT(0)|BIT(1)))
 			xe_mmio_write32(gt, CCS0_CCS1_INTR_MASK, ~dmask);
 		if (ccs_mask & (BIT(2)|BIT(3)))
-			xe_mmio_write32(gt,  CCS2_CCS3_INTR_MASK, ~dmask);
+			xe_mmio_write32(gt, CCS2_CCS3_INTR_MASK, ~dmask);
 	}
 
 	if (xe_gt_is_media_type(gt) || MEDIA_VER(xe) < 13) {
@@ -504,7 +504,7 @@ static void gt_irq_reset(struct xe_tile *tile)
 	if (ccs_mask & (BIT(0)|BIT(1)))
 		xe_mmio_write32(mmio, CCS0_CCS1_INTR_MASK, ~0);
 	if (ccs_mask & (BIT(2)|BIT(3)))
-		xe_mmio_write32(mmio,  CCS2_CCS3_INTR_MASK, ~0);
+		xe_mmio_write32(mmio, CCS2_CCS3_INTR_MASK, ~0);
 
 	if ((tile->media_gt &&
 	     xe_hw_engine_mask_per_class(tile->media_gt, XE_ENGINE_CLASS_OTHER)) ||
diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
index ba0f61e7d2d6..4ff023b5d040 100644
--- a/drivers/gpu/drm/xe/xe_trace_bo.h
+++ b/drivers/gpu/drm/xe/xe_trace_bo.h
@@ -189,7 +189,7 @@ DECLARE_EVENT_CLASS(xe_vm,
 			   ),
 
 		    TP_printk("dev=%s, vm=%p, asid=0x%05x", __get_str(dev),
-			      __entry->vm,  __entry->asid)
+			      __entry->vm, __entry->asid)
 );
 
 DEFINE_EVENT(xe_vm, xe_vm_kill,
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 28188c6d0555..52dc666c3ef4 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -346,6 +346,7 @@ static int amd_i2c_dw_xfer_quirk(struct i2c_adapter *adap, struct i2c_msg *msgs,
 
 	dev->msgs = msgs;
 	dev->msgs_num = num_msgs;
+	dev->msg_write_idx = 0;
 	i2c_dw_xfer_init(dev);
 
 	/* Initiate messages read/write transaction */
diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
index 81cfa74147a1..ad6c195d077b 100644
--- a/drivers/infiniband/hw/mlx5/counters.c
+++ b/drivers/infiniband/hw/mlx5/counters.c
@@ -391,7 +391,7 @@ static int do_get_hw_stats(struct ib_device *ibdev,
 		return ret;
 
 	/* We don't expose device counters over Vports */
-	if (is_mdev_switchdev_mode(dev->mdev) && port_num != 0)
+	if (is_mdev_switchdev_mode(dev->mdev) && dev->is_rep && port_num != 0)
 		goto done;
 
 	if (MLX5_CAP_PCAM_FEATURE(dev->mdev, rx_icrc_encapsulated_counter)) {
@@ -411,7 +411,7 @@ static int do_get_hw_stats(struct ib_device *ibdev,
 			 */
 			goto done;
 		}
-		ret = mlx5_lag_query_cong_counters(dev->mdev,
+		ret = mlx5_lag_query_cong_counters(mdev,
 						   stats->value +
 						   cnts->num_q_counters,
 						   cnts->num_cong_counters,
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 69999d8d24f3..f49f78b69ab9 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1914,6 +1914,7 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
 			/* Level1 is valid for future use, no need to free */
 			return -ENOMEM;
 
+		INIT_LIST_HEAD(&obj_event->obj_sub_list);
 		err = xa_insert(&event->object_ids,
 				key_level2,
 				obj_event,
@@ -1922,7 +1923,6 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
 			kfree(obj_event);
 			return err;
 		}
-		INIT_LIST_HEAD(&obj_event->obj_sub_list);
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 8c47cb4edd0a..435c456a4fd5 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1766,6 +1766,33 @@ static void deallocate_uars(struct mlx5_ib_dev *dev,
 					     context->devx_uid);
 }
 
+static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
+				struct mlx5_core_dev *slave)
+{
+	int err;
+
+	err = mlx5_nic_vport_update_local_lb(master, true);
+	if (err)
+		return err;
+
+	err = mlx5_nic_vport_update_local_lb(slave, true);
+	if (err)
+		goto out;
+
+	return 0;
+
+out:
+	mlx5_nic_vport_update_local_lb(master, false);
+	return err;
+}
+
+static void mlx5_ib_disable_lb_mp(struct mlx5_core_dev *master,
+				  struct mlx5_core_dev *slave)
+{
+	mlx5_nic_vport_update_local_lb(slave, false);
+	mlx5_nic_vport_update_local_lb(master, false);
+}
+
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
@@ -3448,6 +3475,8 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	lockdep_assert_held(&mlx5_ib_multiport_mutex);
 
+	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev);
+
 	mlx5_core_mp_event_replay(ibdev->mdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
 				  NULL);
@@ -3543,6 +3572,10 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_DONE,
 				  &key);
 
+	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev);
+	if (err)
+		goto unbind;
+
 	return true;
 
 unbind:
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 068eac3bdb50..726b81b6330c 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1968,7 +1968,6 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 
 	if (mr->mmkey.cache_ent) {
 		spin_lock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
-		mr->mmkey.cache_ent->in_use--;
 		goto end;
 	}
 
@@ -2029,32 +2028,62 @@ void mlx5_ib_revoke_data_direct_mrs(struct mlx5_ib_dev *dev)
 	}
 }
 
-static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
+static int mlx5_umr_revoke_mr_with_lock(struct mlx5_ib_mr *mr)
 {
-	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
-	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
-	bool is_odp = is_odp_mr(mr);
 	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
-			!to_ib_umem_dmabuf(mr->umem)->pinned;
-	int ret = 0;
+			      !to_ib_umem_dmabuf(mr->umem)->pinned;
+	bool is_odp = is_odp_mr(mr);
+	int ret;
 
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
 
 	if (is_odp_dma_buf)
-		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv, NULL);
+		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv,
+			      NULL);
+
+	ret = mlx5r_umr_revoke_mr(mr);
 
-	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
+	if (is_odp) {
+		if (!ret)
+			to_ib_umem_odp(mr->umem)->private = NULL;
+		mutex_unlock(&to_ib_umem_odp(mr->umem)->umem_mutex);
+	}
+
+	if (is_odp_dma_buf) {
+		if (!ret)
+			to_ib_umem_dmabuf(mr->umem)->private = NULL;
+		dma_resv_unlock(
+			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
+	}
+
+	return ret;
+}
+
+static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
+{
+	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
+			      !to_ib_umem_dmabuf(mr->umem)->pinned;
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
+	bool is_odp = is_odp_mr(mr);
+	bool from_cache = !!ent;
+	int ret;
+
+	if (mr->mmkey.cacheable && !mlx5_umr_revoke_mr_with_lock(mr) &&
+	    !cache_ent_find_and_store(dev, mr)) {
 		ent = mr->mmkey.cache_ent;
 		/* upon storing to a clean temp entry - schedule its cleanup */
 		spin_lock_irq(&ent->mkeys_queue.lock);
+		if (from_cache)
+			ent->in_use--;
 		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
 			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
 					 msecs_to_jiffies(30 * 1000));
 			ent->tmp_cleanup_scheduled = true;
 		}
 		spin_unlock_irq(&ent->mkeys_queue.lock);
-		goto out;
+		return 0;
 	}
 
 	if (ent) {
@@ -2063,8 +2092,14 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 		mr->mmkey.cache_ent = NULL;
 		spin_unlock_irq(&ent->mkeys_queue.lock);
 	}
+
+	if (is_odp)
+		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
+
+	if (is_odp_dma_buf)
+		dma_resv_lock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv,
+			      NULL);
 	ret = destroy_mkey(dev, mr);
-out:
 	if (is_odp) {
 		if (!ret)
 			to_ib_umem_odp(mr->umem)->private = NULL;
@@ -2074,9 +2109,9 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 	if (is_odp_dma_buf) {
 		if (!ret)
 			to_ib_umem_dmabuf(mr->umem)->private = NULL;
-		dma_resv_unlock(to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
+		dma_resv_unlock(
+			to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv);
 	}
-
 	return ret;
 }
 
@@ -2125,7 +2160,7 @@ static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr)
 	}
 
 	/* Stop DMA */
-	rc = mlx5_revoke_mr(mr);
+	rc = mlx5r_handle_mkey_cleanup(mr);
 	if (rc)
 		return rc;
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index e158d5b1ab17..98a76c9db7ab 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -247,8 +247,8 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 	}
 
 	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
-		__xa_erase(&mr_to_mdev(mr)->odp_mkeys,
-			   mlx5_base_mkey(mr->mmkey.key));
+		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
+			 mlx5_base_mkey(mr->mmkey.key));
 	xa_unlock(&imr->implicit_children);
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
@@ -521,8 +521,8 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	}
 
 	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
-		ret = __xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
-				 &mr->mmkey, GFP_KERNEL);
+		ret = xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+			       &mr->mmkey, GFP_KERNEL);
 		if (xa_is_err(ret)) {
 			ret = ERR_PTR(xa_err(ret));
 			__xa_erase(&imr->implicit_children, idx);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 91d329e90308..8b805b16136e 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -811,7 +811,12 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 	qp->qp_timeout_jiffies = 0;
 
-	if (qp_type(qp) == IB_QPT_RC) {
+	/* In the function timer_setup, .function is initialized. If .function
+	 * is NULL, it indicates the function timer_setup is not called, the
+	 * timer is not initialized. Or else, the timer is initialized.
+	 */
+	if (qp_type(qp) == IB_QPT_RC && qp->retrans_timer.function &&
+		qp->rnr_nak_timer.function) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index da5b14602a76..6d679e235af6 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -174,6 +174,7 @@ static const struct xpad_device {
 	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3030, "Chic Controller", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3031, "Chic Controller", 0, XTYPE_XBOX },
+	{ 0x0502, 0x1305, "Acer NGR200", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0020, "Logic3 Xbox GamePad", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0033, "Competition Pro Steering Wheel", 0, XTYPE_XBOX },
 	{ 0x06a3, 0x0200, "Saitek Racing Wheel", 0, XTYPE_XBOX },
@@ -515,6 +516,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft Xbox 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft Xbox One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech Xbox 360-style controllers */
+	XPAD_XBOX360_VENDOR(0x0502),		/* Acer Inc. Xbox 360 style controllers */
 	XPAD_XBOX360_VENDOR(0x056e),		/* Elecom JC-U3613M */
 	XPAD_XBOX360_VENDOR(0x06a3),		/* Saitek P3600 */
 	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz Xbox 360 controllers */
diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40l50-vibra.c
index dce3b0ec8cf3..330f09123631 100644
--- a/drivers/input/misc/cs40l50-vibra.c
+++ b/drivers/input/misc/cs40l50-vibra.c
@@ -238,6 +238,8 @@ static int cs40l50_upload_owt(struct cs40l50_work *work_data)
 	header.data_words = len / sizeof(u32);
 
 	new_owt_effect_data = kmalloc(sizeof(header) + len, GFP_KERNEL);
+	if (!new_owt_effect_data)
+		return -ENOMEM;
 
 	memcpy(new_owt_effect_data, &header, sizeof(header));
 	memcpy(new_owt_effect_data + sizeof(header), work_data->custom_data, len);
diff --git a/drivers/input/misc/iqs7222.c b/drivers/input/misc/iqs7222.c
index 01c4009fd53e..846aac9a5c9d 100644
--- a/drivers/input/misc/iqs7222.c
+++ b/drivers/input/misc/iqs7222.c
@@ -301,6 +301,7 @@ struct iqs7222_dev_desc {
 	int allow_offset;
 	int event_offset;
 	int comms_offset;
+	int ext_chan;
 	bool legacy_gesture;
 	struct iqs7222_reg_grp_desc reg_grps[IQS7222_NUM_REG_GRPS];
 };
@@ -315,6 +316,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 		.allow_offset = 9,
 		.event_offset = 10,
 		.comms_offset = 12,
+		.ext_chan = 10,
 		.reg_grps = {
 			[IQS7222_REG_GRP_STAT] = {
 				.base = IQS7222_SYS_STATUS,
@@ -373,6 +375,7 @@ static const struct iqs7222_dev_desc iqs7222_devs[] = {
 		.allow_offset = 9,
 		.event_offset = 10,
 		.comms_offset = 12,
+		.ext_chan = 10,
 		.legacy_gesture = true,
 		.reg_grps = {
 			[IQS7222_REG_GRP_STAT] = {
@@ -2244,7 +2247,7 @@ static int iqs7222_parse_chan(struct iqs7222_private *iqs7222,
 	const struct iqs7222_dev_desc *dev_desc = iqs7222->dev_desc;
 	struct i2c_client *client = iqs7222->client;
 	int num_chan = dev_desc->reg_grps[IQS7222_REG_GRP_CHAN].num_row;
-	int ext_chan = rounddown(num_chan, 10);
+	int ext_chan = dev_desc->ext_chan ? : num_chan;
 	int error, i;
 	u16 *chan_setup = iqs7222->chan_setup[chan_index];
 	u16 *sys_setup = iqs7222->sys_setup;
@@ -2448,7 +2451,7 @@ static int iqs7222_parse_sldr(struct iqs7222_private *iqs7222,
 	const struct iqs7222_dev_desc *dev_desc = iqs7222->dev_desc;
 	struct i2c_client *client = iqs7222->client;
 	int num_chan = dev_desc->reg_grps[IQS7222_REG_GRP_CHAN].num_row;
-	int ext_chan = rounddown(num_chan, 10);
+	int ext_chan = dev_desc->ext_chan ? : num_chan;
 	int count, error, reg_offset, i;
 	u16 *event_mask = &iqs7222->sys_setup[dev_desc->event_offset];
 	u16 *sldr_setup = iqs7222->sldr_setup[sldr_index];
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ff55b8c30712..ae69691471e9 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1087,7 +1087,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	 * - R-Car Gen3 IPMMU (leaf devices only - skip root IPMMU-MM device)
 	 */
 	if (!mmu->features->has_cache_leaf_nodes || !ipmmu_is_root(mmu)) {
-		ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL,
+		ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, "%s",
 					     dev_name(&pdev->dev));
 		if (ret)
 			return ret;
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4b369419b32c..4c7f470a4752 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1154,7 +1154,6 @@ static int rk_iommu_of_xlate(struct device *dev,
 	iommu_dev = of_find_device_by_node(args->np);
 
 	data->iommu = platform_get_drvdata(iommu_dev);
-	data->iommu->domain = &rk_identity_domain;
 	dev_iommu_priv_set(dev, data);
 
 	platform_device_put(iommu_dev);
@@ -1192,6 +1191,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (!iommu)
 		return -ENOMEM;
 
+	iommu->domain = &rk_identity_domain;
+
 	platform_set_drvdata(pdev, iommu);
 	iommu->dev = dev;
 	iommu->num_mmu = 0;
diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index e36805f07282..8b5fed476039 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -104,11 +104,22 @@ static const struct regmap_config exynos_lpass_reg_conf = {
 	.fast_io	= true,
 };
 
+static void exynos_lpass_disable_lpass(void *data)
+{
+	struct platform_device *pdev = data;
+	struct exynos_lpass *lpass = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		exynos_lpass_disable(lpass);
+}
+
 static int exynos_lpass_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct exynos_lpass *lpass;
 	void __iomem *base_top;
+	int ret;
 
 	lpass = devm_kzalloc(dev, sizeof(*lpass), GFP_KERNEL);
 	if (!lpass)
@@ -134,16 +145,11 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	exynos_lpass_enable(lpass);
 
-	return devm_of_platform_populate(dev);
-}
-
-static void exynos_lpass_remove(struct platform_device *pdev)
-{
-	struct exynos_lpass *lpass = platform_get_drvdata(pdev);
+	ret = devm_add_action_or_reset(dev, exynos_lpass_disable_lpass, pdev);
+	if (ret)
+		return ret;
 
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		exynos_lpass_disable(lpass);
+	return devm_of_platform_populate(dev);
 }
 
 static int __maybe_unused exynos_lpass_suspend(struct device *dev)
@@ -183,7 +189,6 @@ static struct platform_driver exynos_lpass_driver = {
 		.of_match_table	= exynos_lpass_of_match,
 	},
 	.probe	= exynos_lpass_probe,
-	.remove_new = exynos_lpass_remove,
 };
 module_platform_driver(exynos_lpass_driver);
 
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 7f893bafaa60..c417ed34c057 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -44,6 +44,12 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
 		   MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
 
+	/*
+	 * Some SD cards reports discard support while they don't
+	 */
+	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
+		  MMC_QUIRK_BROKEN_SD_DISCARD),
+
 	END_FIXUP
 };
 
@@ -147,12 +153,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
-	/*
-	 * Some SD cards reports discard support while they don't
-	 */
-	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
-		  MMC_QUIRK_BROKEN_SD_DISCARD),
-
 	END_FIXUP
 };
 
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d5d868cb4edc..be9954f5bc0a 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -776,12 +776,18 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
 {
 	if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
-		data->host_cookie |= MSDC_PREPARE_FLAG;
 		data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
 					    mmc_get_dma_dir(data));
+		if (data->sg_count)
+			data->host_cookie |= MSDC_PREPARE_FLAG;
 	}
 }
 
+static bool msdc_data_prepared(struct mmc_data *data)
+{
+	return data->host_cookie & MSDC_PREPARE_FLAG;
+}
+
 static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
 {
 	if (data->host_cookie & MSDC_ASYNC_FLAG)
@@ -1345,8 +1351,19 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(host->mrq);
 	host->mrq = mrq;
 
-	if (mrq->data)
+	if (mrq->data) {
 		msdc_prepare_data(host, mrq->data);
+		if (!msdc_data_prepared(mrq->data)) {
+			host->mrq = NULL;
+			/*
+			 * Failed to prepare DMA area, fail fast before
+			 * starting any commands.
+			 */
+			mrq->cmd->error = -ENOSPC;
+			mmc_request_done(mmc_from_priv(host), mrq);
+			return;
+		}
+	}
 
 	/* if SBC is required, we have HW option and SW option.
 	 * if HW option is enabled, and SBC does not have "special" flags,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8ae76300d157..4b91c9e96635 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2035,15 +2035,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (clk & SDHCI_CLOCK_CARD_EN)
-		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
-			SDHCI_CLOCK_CONTROL);
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0) {
-		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	if (clock == 0)
 		return;
-	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f531b617f28d..da1b0a46b1d9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -825,4 +825,20 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+#define SDHCI_DBG_ANYWAY 0
+#elif defined(DEBUG)
+#define SDHCI_DBG_ANYWAY 1
+#else
+#define SDHCI_DBG_ANYWAY 0
+#endif
+
+#define sdhci_dbg_dumpregs(host, fmt)					\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) ||	SDHCI_DBG_ANYWAY)	\
+		sdhci_dumpregs(host);					\
+} while (0)
+
 #endif /* __SDHCI_HW_H */
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4d76f9f71a0e..241f6a4df16c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1496,6 +1496,7 @@ static void spinand_cleanup(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 
+	nanddev_ecc_engine_cleanup(nand);
 	nanddev_cleanup(nand);
 	spinand_manufacturer_cleanup(spinand);
 	kfree(spinand->databuf);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2a513dbbd975..52ff0f9e04e0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -497,9 +497,9 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 		goto out;
 	}
 
-	xs->xso.real_dev = real_dev;
 	err = real_dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
 	if (!err) {
+		xs->xso.real_dev = real_dev;
 		ipsec->xs = xs;
 		INIT_LIST_HEAD(&ipsec->list);
 		mutex_lock(&bond->ipsec_lock);
@@ -541,11 +541,11 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 		if (ipsec->xs->xso.real_dev == real_dev)
 			continue;
 
-		ipsec->xs->xso.real_dev = real_dev;
 		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
-			ipsec->xs->xso.real_dev = NULL;
+			continue;
 		}
+		ipsec->xs->xso.real_dev = real_dev;
 	}
 out:
 	mutex_unlock(&bond->ipsec_lock);
@@ -627,6 +627,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				   "%s: no slave xdo_dev_state_delete\n",
 				   __func__);
 		} else {
+			ipsec->xs->xso.real_dev = NULL;
 			real_dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
 			if (real_dev->xfrmdev_ops->xdo_dev_state_free)
 				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
@@ -661,6 +662,7 @@ static void bond_ipsec_free_sa(struct xfrm_state *xs)
 
 	WARN_ON(xs->xso.real_dev != real_dev);
 
+	xs->xso.real_dev = NULL;
 	if (real_dev && real_dev->xfrmdev_ops &&
 	    real_dev->xfrmdev_ops->xdo_dev_state_free)
 		real_dev->xfrmdev_ops->xdo_dev_state_free(xs);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 3b70f6737633..aa25a8a0a106 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -1373,6 +1373,8 @@
 #define MDIO_VEND2_CTRL1_SS13		BIT(13)
 #endif
 
+#define XGBE_VEND2_MAC_AUTO_SW		BIT(9)
+
 /* MDIO mask values */
 #define XGBE_AN_CL73_INT_CMPLT		BIT(0)
 #define XGBE_AN_CL73_INC_LINK		BIT(1)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 07f4f3418d01..ed76a8df6ec6 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -375,6 +375,10 @@ static void xgbe_an37_set(struct xgbe_prv_data *pdata, bool enable,
 		reg |= MDIO_VEND2_CTRL1_AN_RESTART;
 
 	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
+
+	reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
+	reg |= XGBE_VEND2_MAC_AUTO_SW;
+	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
 }
 
 static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
@@ -1003,6 +1007,11 @@ static void xgbe_an37_init(struct xgbe_prv_data *pdata)
 
 	netif_dbg(pdata, link, pdata->netdev, "CL37 AN (%s) initialized\n",
 		  (pdata->an_mode == XGBE_AN_MODE_CL37) ? "BaseX" : "SGMII");
+
+	reg = XMDIO_READ(pdata, MDIO_MMD_AN, MDIO_CTRL1);
+	reg &= ~MDIO_AN_CTRL1_ENABLE;
+	XMDIO_WRITE(pdata, MDIO_MMD_AN, MDIO_CTRL1, reg);
+
 }
 
 static void xgbe_an73_init(struct xgbe_prv_data *pdata)
@@ -1404,6 +1413,10 @@ static void xgbe_phy_status(struct xgbe_prv_data *pdata)
 
 	pdata->phy.link = pdata->phy_if.phy_impl.link_status(pdata,
 							     &an_restart);
+	/* bail out if the link status register read fails */
+	if (pdata->phy.link < 0)
+		return;
+
 	if (an_restart) {
 		xgbe_phy_config_aneg(pdata);
 		goto adjust_link;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index 268399dfcf22..32e633d11348 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2855,8 +2855,7 @@ static bool xgbe_phy_valid_speed(struct xgbe_prv_data *pdata, int speed)
 static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 {
 	struct xgbe_phy_data *phy_data = pdata->phy_data;
-	unsigned int reg;
-	int ret;
+	int reg, ret;
 
 	*an_restart = 0;
 
@@ -2890,11 +2889,20 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 			return 0;
 	}
 
-	/* Link status is latched low, so read once to clear
-	 * and then read again to get current state
-	 */
-	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
 	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+	if (reg < 0)
+		return reg;
+
+	/* Link status is latched low so that momentary link drops
+	 * can be detected. If link was already down read again
+	 * to get the latest state.
+	 */
+
+	if (!pdata->phy.link && !(reg & MDIO_STAT1_LSTATUS)) {
+		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
+		if (reg < 0)
+			return reg;
+	}
 
 	if (pdata->en_rx_adap) {
 		/* if the link is available and adaptation is done,
@@ -2913,9 +2921,7 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
 			xgbe_phy_set_mode(pdata, phy_data->cur_mode);
 		}
 
-		/* check again for the link and adaptation status */
-		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
-		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
+		if (pdata->rx_adapt_done)
 			return 1;
 	} else if (reg & MDIO_STAT1_LSTATUS)
 		return 1;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index ed5d43c16d0e..7526a0906b39 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -292,12 +292,12 @@
 #define XGBE_LINK_TIMEOUT		5
 #define XGBE_KR_TRAINING_WAIT_ITER	50
 
-#define XGBE_SGMII_AN_LINK_STATUS	BIT(1)
+#define XGBE_SGMII_AN_LINK_DUPLEX	BIT(1)
 #define XGBE_SGMII_AN_LINK_SPEED	(BIT(2) | BIT(3))
 #define XGBE_SGMII_AN_LINK_SPEED_10	0x00
 #define XGBE_SGMII_AN_LINK_SPEED_100	0x04
 #define XGBE_SGMII_AN_LINK_SPEED_1000	0x08
-#define XGBE_SGMII_AN_LINK_DUPLEX	BIT(4)
+#define XGBE_SGMII_AN_LINK_STATUS	BIT(4)
 
 /* ECC correctable error notification window (seconds) */
 #define XGBE_ECC_LIMIT			60
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 3afd3627ce48..9c5d61990904 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -1861,14 +1861,21 @@ static u16 atl1_alloc_rx_buffers(struct atl1_adapter *adapter)
 			break;
 		}
 
-		buffer_info->alloced = 1;
-		buffer_info->skb = skb;
-		buffer_info->length = (u16) adapter->rx_buffer_len;
 		page = virt_to_page(skb->data);
 		offset = offset_in_page(skb->data);
 		buffer_info->dma = dma_map_page(&pdev->dev, page, offset,
 						adapter->rx_buffer_len,
 						DMA_FROM_DEVICE);
+		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			kfree_skb(skb);
+			adapter->soft_stats.rx_dropped++;
+			break;
+		}
+
+		buffer_info->alloced = 1;
+		buffer_info->skb = skb;
+		buffer_info->length = (u16)adapter->rx_buffer_len;
+
 		rfd_desc->buffer_addr = cpu_to_le64(buffer_info->dma);
 		rfd_desc->buf_len = cpu_to_le16(adapter->rx_buffer_len);
 		rfd_desc->coalese = 0;
@@ -2183,8 +2190,8 @@ static int atl1_tx_csum(struct atl1_adapter *adapter, struct sk_buff *skb,
 	return 0;
 }
 
-static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
-	struct tx_packet_desc *ptpd)
+static bool atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
+			struct tx_packet_desc *ptpd)
 {
 	struct atl1_tpd_ring *tpd_ring = &adapter->tpd_ring;
 	struct atl1_buffer *buffer_info;
@@ -2194,6 +2201,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	unsigned int nr_frags;
 	unsigned int f;
 	int retval;
+	u16 first_mapped;
 	u16 next_to_use;
 	u16 data_len;
 	u8 hdr_len;
@@ -2201,6 +2209,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	buf_len -= skb->data_len;
 	nr_frags = skb_shinfo(skb)->nr_frags;
 	next_to_use = atomic_read(&tpd_ring->next_to_use);
+	first_mapped = next_to_use;
 	buffer_info = &tpd_ring->buffer_info[next_to_use];
 	BUG_ON(buffer_info->skb);
 	/* put skb in last TPD */
@@ -2216,6 +2225,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, hdr_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
@@ -2242,6 +2253,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 								page, offset,
 								buffer_info->length,
 								DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      buffer_info->dma))
+					goto dma_err;
 				if (++next_to_use == tpd_ring->count)
 					next_to_use = 0;
 			}
@@ -2254,6 +2268,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, buf_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
 	}
@@ -2277,6 +2293,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 			buffer_info->dma = skb_frag_dma_map(&adapter->pdev->dev,
 				frag, i * ATL1_MAX_TX_BUF_LEN,
 				buffer_info->length, DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev,
+					      buffer_info->dma))
+				goto dma_err;
 
 			if (++next_to_use == tpd_ring->count)
 				next_to_use = 0;
@@ -2285,6 +2304,22 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 
 	/* last tpd's buffer-info */
 	buffer_info->skb = skb;
+
+	return true;
+
+ dma_err:
+	while (first_mapped != next_to_use) {
+		buffer_info = &tpd_ring->buffer_info[first_mapped];
+		dma_unmap_page(&adapter->pdev->dev,
+			       buffer_info->dma,
+			       buffer_info->length,
+			       DMA_TO_DEVICE);
+		buffer_info->dma = 0;
+
+		if (++first_mapped == tpd_ring->count)
+			first_mapped = 0;
+	}
+	return false;
 }
 
 static void atl1_tx_queue(struct atl1_adapter *adapter, u16 count,
@@ -2355,10 +2390,8 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 
 	len = skb_headlen(skb);
 
-	if (unlikely(skb->len <= 0)) {
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
+	if (unlikely(skb->len <= 0))
+		goto drop_packet;
 
 	nr_frags = skb_shinfo(skb)->nr_frags;
 	for (f = 0; f < nr_frags; f++) {
@@ -2371,10 +2404,9 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 	if (mss) {
 		if (skb->protocol == htons(ETH_P_IP)) {
 			proto_hdr_len = skb_tcp_all_headers(skb);
-			if (unlikely(proto_hdr_len > len)) {
-				dev_kfree_skb_any(skb);
-				return NETDEV_TX_OK;
-			}
+			if (unlikely(proto_hdr_len > len))
+				goto drop_packet;
+
 			/* need additional TPD ? */
 			if (proto_hdr_len != len)
 				count += (len - proto_hdr_len +
@@ -2406,23 +2438,26 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 	}
 
 	tso = atl1_tso(adapter, skb, ptpd);
-	if (tso < 0) {
-		dev_kfree_skb_any(skb);
-		return NETDEV_TX_OK;
-	}
+	if (tso < 0)
+		goto drop_packet;
 
 	if (!tso) {
 		ret_val = atl1_tx_csum(adapter, skb, ptpd);
-		if (ret_val < 0) {
-			dev_kfree_skb_any(skb);
-			return NETDEV_TX_OK;
-		}
+		if (ret_val < 0)
+			goto drop_packet;
 	}
 
-	atl1_tx_map(adapter, skb, ptpd);
+	if (!atl1_tx_map(adapter, skb, ptpd))
+		goto drop_packet;
+
 	atl1_tx_queue(adapter, count, ptpd);
 	atl1_update_mailbox(adapter);
 	return NETDEV_TX_OK;
+
+drop_packet:
+	adapter->soft_stats.tx_errors++;
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
 }
 
 static int atl1_rings_clean(struct napi_struct *napi, int budget)
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index ffed14b63d41..a432783756d8 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2127,10 +2127,10 @@ static int enic_change_mtu(struct net_device *netdev, int new_mtu)
 	if (enic_is_dynamic(enic) || enic_is_sriov_vf(enic))
 		return -EOPNOTSUPP;
 
-	if (netdev->mtu > enic->port_mtu)
+	if (new_mtu > enic->port_mtu)
 		netdev_warn(netdev,
 			    "interface MTU (%d) set higher than port MTU (%d)\n",
-			    netdev->mtu, enic->port_mtu);
+			    new_mtu, enic->port_mtu);
 
 	return _enic_change_mtu(netdev, new_mtu);
 }
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 29886a8ba73f..efd0048acd3b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -3928,6 +3928,7 @@ static int dpaa2_eth_setup_rx_flow(struct dpaa2_eth_priv *priv,
 					 MEM_TYPE_PAGE_ORDER0, NULL);
 	if (err) {
 		dev_err(dev, "xdp_rxq_info_reg_mem_model failed\n");
+		xdp_rxq_info_unreg(&fq->channel->xdp_rxq);
 		return err;
 	}
 
@@ -4421,17 +4422,25 @@ static int dpaa2_eth_bind_dpni(struct dpaa2_eth_priv *priv)
 			return -EINVAL;
 		}
 		if (err)
-			return err;
+			goto out;
 	}
 
 	err = dpni_get_qdid(priv->mc_io, 0, priv->mc_token,
 			    DPNI_QUEUE_TX, &priv->tx_qdid);
 	if (err) {
 		dev_err(dev, "dpni_get_qdid() failed\n");
-		return err;
+		goto out;
 	}
 
 	return 0;
+
+out:
+	while (i--) {
+		if (priv->fq[i].type == DPAA2_RX_FQ &&
+		    xdp_rxq_info_is_reg(&priv->fq[i].channel->xdp_rxq))
+			xdp_rxq_info_unreg(&priv->fq[i].channel->xdp_rxq);
+	}
+	return err;
 }
 
 /* Allocate rings for storing incoming frame descriptors */
@@ -4814,6 +4823,17 @@ static void dpaa2_eth_del_ch_napi(struct dpaa2_eth_priv *priv)
 	}
 }
 
+static void dpaa2_eth_free_rx_xdp_rxq(struct dpaa2_eth_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_fqs; i++) {
+		if (priv->fq[i].type == DPAA2_RX_FQ &&
+		    xdp_rxq_info_is_reg(&priv->fq[i].channel->xdp_rxq))
+			xdp_rxq_info_unreg(&priv->fq[i].channel->xdp_rxq);
+	}
+}
+
 static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 {
 	struct device *dev;
@@ -5017,6 +5037,7 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	free_percpu(priv->percpu_stats);
 err_alloc_percpu_stats:
 	dpaa2_eth_del_ch_napi(priv);
+	dpaa2_eth_free_rx_xdp_rxq(priv);
 err_bind:
 	dpaa2_eth_free_dpbps(priv);
 err_dpbp_setup:
@@ -5069,6 +5090,7 @@ static void dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	free_percpu(priv->percpu_extras);
 
 	dpaa2_eth_del_ch_napi(priv);
+	dpaa2_eth_free_rx_xdp_rxq(priv);
 	dpaa2_eth_free_dpbps(priv);
 	dpaa2_eth_free_dpio(priv);
 	dpaa2_eth_free_dpni(priv);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index b28991dd1870..48b8e184f3db 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -96,7 +96,7 @@ static void idpf_ctlq_init_rxq_bufs(struct idpf_ctlq_info *cq)
  */
 static void idpf_ctlq_shutdown(struct idpf_hw *hw, struct idpf_ctlq_info *cq)
 {
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	/* free ring buffers and the ring itself */
 	idpf_ctlq_dealloc_ring_res(hw, cq);
@@ -104,8 +104,7 @@ static void idpf_ctlq_shutdown(struct idpf_hw *hw, struct idpf_ctlq_info *cq)
 	/* Set ring_size to 0 to indicate uninitialized queue */
 	cq->ring_size = 0;
 
-	mutex_unlock(&cq->cq_lock);
-	mutex_destroy(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 }
 
 /**
@@ -173,7 +172,7 @@ int idpf_ctlq_add(struct idpf_hw *hw,
 
 	idpf_ctlq_init_regs(hw, cq, is_rxq);
 
-	mutex_init(&cq->cq_lock);
+	spin_lock_init(&cq->cq_lock);
 
 	list_add(&cq->cq_list, &hw->cq_list_head);
 
@@ -272,7 +271,7 @@ int idpf_ctlq_send(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 	int err = 0;
 	int i;
 
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	/* Ensure there are enough descriptors to send all messages */
 	num_desc_avail = IDPF_CTLQ_DESC_UNUSED(cq);
@@ -332,7 +331,7 @@ int idpf_ctlq_send(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 	wr32(hw, cq->reg.tail, cq->next_to_use);
 
 err_unlock:
-	mutex_unlock(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 
 	return err;
 }
@@ -364,7 +363,7 @@ int idpf_ctlq_clean_sq(struct idpf_ctlq_info *cq, u16 *clean_count,
 	if (*clean_count > cq->ring_size)
 		return -EBADR;
 
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	ntc = cq->next_to_clean;
 
@@ -397,7 +396,7 @@ int idpf_ctlq_clean_sq(struct idpf_ctlq_info *cq, u16 *clean_count,
 
 	cq->next_to_clean = ntc;
 
-	mutex_unlock(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 
 	/* Return number of descriptors actually cleaned */
 	*clean_count = i;
@@ -435,7 +434,7 @@ int idpf_ctlq_post_rx_buffs(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 	if (*buff_count > 0)
 		buffs_avail = true;
 
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	if (tbp >= cq->ring_size)
 		tbp = 0;
@@ -524,7 +523,7 @@ int idpf_ctlq_post_rx_buffs(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 		wr32(hw, cq->reg.tail, cq->next_to_post);
 	}
 
-	mutex_unlock(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 
 	/* return the number of buffers that were not posted */
 	*buff_count = *buff_count - i;
@@ -552,7 +551,7 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 	u16 i;
 
 	/* take the lock before we start messing with the ring */
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	ntc = cq->next_to_clean;
 
@@ -614,7 +613,7 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 
 	cq->next_to_clean = ntc;
 
-	mutex_unlock(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 
 	*num_q_msg = i;
 	if (*num_q_msg == 0)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h b/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
index e8e046ef2f0d..5890d8adca4a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
@@ -99,7 +99,7 @@ struct idpf_ctlq_info {
 
 	enum idpf_ctlq_type cq_type;
 	int q_id;
-	struct mutex cq_lock;		/* control queue lock */
+	spinlock_t cq_lock;		/* control queue lock */
 	/* used for interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 59b1a1a09996..f72420cf6821 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -46,7 +46,7 @@ static u32 idpf_get_rxfh_key_size(struct net_device *netdev)
 	struct idpf_vport_user_config_data *user_config;
 
 	if (!idpf_is_cap_ena_all(np->adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
-		return -EOPNOTSUPP;
+		return 0;
 
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
@@ -65,7 +65,7 @@ static u32 idpf_get_rxfh_indir_size(struct net_device *netdev)
 	struct idpf_vport_user_config_data *user_config;
 
 	if (!idpf_is_cap_ena_all(np->adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
-		return -EOPNOTSUPP;
+		return 0;
 
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index ba645ab22d39..746b65533727 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2315,8 +2315,12 @@ void *idpf_alloc_dma_mem(struct idpf_hw *hw, struct idpf_dma_mem *mem, u64 size)
 	struct idpf_adapter *adapter = hw->back;
 	size_t sz = ALIGN(size, 4096);
 
-	mem->va = dma_alloc_coherent(&adapter->pdev->dev, sz,
-				     &mem->pa, GFP_KERNEL);
+	/* The control queue resources are freed under a spinlock, contiguous
+	 * pages will avoid IOMMU remapping and the use vmap (and vunmap in
+	 * dma_free_*() path.
+	 */
+	mem->va = dma_alloc_attrs(&adapter->pdev->dev, sz, &mem->pa,
+				  GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
 	mem->size = sz;
 
 	return mem->va;
@@ -2331,8 +2335,8 @@ void idpf_free_dma_mem(struct idpf_hw *hw, struct idpf_dma_mem *mem)
 {
 	struct idpf_adapter *adapter = hw->back;
 
-	dma_free_coherent(&adapter->pdev->dev, mem->size,
-			  mem->va, mem->pa);
+	dma_free_attrs(&adapter->pdev->dev, mem->size,
+		       mem->va, mem->pa, DMA_ATTR_FORCE_CONTIGUOUS);
 	mem->size = 0;
 	mem->va = NULL;
 	mem->pa = 0;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 082b0baf5d37..2a0c5a343e47 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6987,6 +6987,10 @@ static int igc_probe(struct pci_dev *pdev,
 	adapter->port_num = hw->bus.func;
 	adapter->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
 
+	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
+	if (igc_is_device_id_i226(hw))
+		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
+
 	err = pci_save_state(pdev);
 	if (err)
 		goto err_ioremap;
@@ -7368,6 +7372,9 @@ static int igc_resume(struct device *dev)
 	pci_enable_wake(pdev, PCI_D3hot, 0);
 	pci_enable_wake(pdev, PCI_D3cold, 0);
 
+	if (igc_is_device_id_i226(hw))
+		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
+
 	if (igc_init_interrupt_scheme(adapter, true)) {
 		netdev_err(netdev, "Unable to allocate memory for queues\n");
 		return -ENOMEM;
@@ -7480,6 +7487,9 @@ static pci_ers_result_t igc_io_slot_reset(struct pci_dev *pdev)
 		pci_enable_wake(pdev, PCI_D3hot, 0);
 		pci_enable_wake(pdev, PCI_D3cold, 0);
 
+		if (igc_is_device_id_i226(hw))
+			pci_disable_link_state_locked(pdev, PCIE_LINK_STATE_L1_2);
+
 		/* In case of PCI error, adapter loses its HW address
 		 * so we should re-assign it here.
 		 */
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index f5449b73b9a7..1e4cf89bd79a 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3336,7 +3336,7 @@ static int niu_rbr_add_page(struct niu *np, struct rx_ring_info *rp,
 
 	addr = np->ops->map_page(np->device, page, 0,
 				 PAGE_SIZE, DMA_FROM_DEVICE);
-	if (!addr) {
+	if (np->ops->mapping_error(np->device, addr)) {
 		__free_page(page);
 		return -ENOMEM;
 	}
@@ -6672,6 +6672,8 @@ static netdev_tx_t niu_start_xmit(struct sk_buff *skb,
 	len = skb_headlen(skb);
 	mapping = np->ops->map_single(np->device, skb->data,
 				      len, DMA_TO_DEVICE);
+	if (np->ops->mapping_error(np->device, mapping))
+		goto out_drop;
 
 	prod = rp->prod;
 
@@ -6713,6 +6715,8 @@ static netdev_tx_t niu_start_xmit(struct sk_buff *skb,
 		mapping = np->ops->map_page(np->device, skb_frag_page(frag),
 					    skb_frag_off(frag), len,
 					    DMA_TO_DEVICE);
+		if (np->ops->mapping_error(np->device, mapping))
+			goto out_unmap;
 
 		rp->tx_buffs[prod].skb = NULL;
 		rp->tx_buffs[prod].mapping = mapping;
@@ -6737,6 +6741,19 @@ static netdev_tx_t niu_start_xmit(struct sk_buff *skb,
 out:
 	return NETDEV_TX_OK;
 
+out_unmap:
+	while (i--) {
+		const skb_frag_t *frag;
+
+		prod = PREVIOUS_TX(rp, prod);
+		frag = &skb_shinfo(skb)->frags[i];
+		np->ops->unmap_page(np->device, rp->tx_buffs[prod].mapping,
+				    skb_frag_size(frag), DMA_TO_DEVICE);
+	}
+
+	np->ops->unmap_single(np->device, rp->tx_buffs[rp->prod].mapping,
+			      skb_headlen(skb), DMA_TO_DEVICE);
+
 out_drop:
 	rp->tx_errors++;
 	kfree_skb(skb);
@@ -9638,6 +9655,11 @@ static void niu_pci_unmap_single(struct device *dev, u64 dma_address,
 	dma_unmap_single(dev, dma_address, size, direction);
 }
 
+static int niu_pci_mapping_error(struct device *dev, u64 addr)
+{
+	return dma_mapping_error(dev, addr);
+}
+
 static const struct niu_ops niu_pci_ops = {
 	.alloc_coherent	= niu_pci_alloc_coherent,
 	.free_coherent	= niu_pci_free_coherent,
@@ -9645,6 +9667,7 @@ static const struct niu_ops niu_pci_ops = {
 	.unmap_page	= niu_pci_unmap_page,
 	.map_single	= niu_pci_map_single,
 	.unmap_single	= niu_pci_unmap_single,
+	.mapping_error	= niu_pci_mapping_error,
 };
 
 static void niu_driver_version(void)
@@ -10011,6 +10034,11 @@ static void niu_phys_unmap_single(struct device *dev, u64 dma_address,
 	/* Nothing to do.  */
 }
 
+static int niu_phys_mapping_error(struct device *dev, u64 dma_address)
+{
+	return false;
+}
+
 static const struct niu_ops niu_phys_ops = {
 	.alloc_coherent	= niu_phys_alloc_coherent,
 	.free_coherent	= niu_phys_free_coherent,
@@ -10018,6 +10046,7 @@ static const struct niu_ops niu_phys_ops = {
 	.unmap_page	= niu_phys_unmap_page,
 	.map_single	= niu_phys_map_single,
 	.unmap_single	= niu_phys_unmap_single,
+	.mapping_error	= niu_phys_mapping_error,
 };
 
 static int niu_of_probe(struct platform_device *op)
diff --git a/drivers/net/ethernet/sun/niu.h b/drivers/net/ethernet/sun/niu.h
index 04c215f91fc0..0b169c08b0f2 100644
--- a/drivers/net/ethernet/sun/niu.h
+++ b/drivers/net/ethernet/sun/niu.h
@@ -2879,6 +2879,9 @@ struct tx_ring_info {
 #define NEXT_TX(tp, index) \
 	(((index) + 1) < (tp)->pending ? ((index) + 1) : 0)
 
+#define PREVIOUS_TX(tp, index) \
+	(((index) - 1) >= 0 ? ((index) - 1) : (((tp)->pending) - 1))
+
 static inline u32 niu_tx_avail(struct tx_ring_info *tp)
 {
 	return (tp->pending -
@@ -3140,6 +3143,7 @@ struct niu_ops {
 			  enum dma_data_direction direction);
 	void (*unmap_single)(struct device *dev, u64 dma_address,
 			     size_t size, enum dma_data_direction direction);
+	int (*mapping_error)(struct device *dev, u64 dma_address);
 };
 
 struct niu_link_config {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index d8a6fea961c0..ea2123ea6e38 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1585,6 +1585,7 @@ static void wx_set_rss_queues(struct wx *wx)
 
 	clear_bit(WX_FLAG_FDIR_HASH, wx->flags);
 
+	wx->ring_feature[RING_F_FDIR].indices = 1;
 	/* Use Flow Director in addition to RSS to ensure the best
 	 * distribution of flows across cores, even when an FDIR flow
 	 * isn't matched.
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 0ee73a265545..c698f4ec751a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -68,7 +68,6 @@ int txgbe_request_queue_irqs(struct wx *wx)
 		free_irq(wx->msix_q_entries[vector].vector,
 			 wx->q_vector[vector]);
 	}
-	wx_reset_interrupt_capability(wx);
 	return err;
 }
 
@@ -169,6 +168,7 @@ void txgbe_free_misc_irq(struct txgbe *txgbe)
 	free_irq(txgbe->link_irq, txgbe);
 	free_irq(txgbe->misc.irq, txgbe);
 	txgbe_del_irq_domain(txgbe);
+	txgbe->wx->misc_irq_domain = false;
 }
 
 int txgbe_setup_misc_irq(struct txgbe *txgbe)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 7e352837184f..9ede260b85dc 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -308,10 +308,14 @@ static int txgbe_open(struct net_device *netdev)
 
 	wx_configure(wx);
 
-	err = txgbe_request_queue_irqs(wx);
+	err = txgbe_setup_misc_irq(wx->priv);
 	if (err)
 		goto err_free_resources;
 
+	err = txgbe_request_queue_irqs(wx);
+	if (err)
+		goto err_free_misc_irq;
+
 	/* Notify the stack of the actual queue counts. */
 	err = netif_set_real_num_tx_queues(netdev, wx->num_tx_queues);
 	if (err)
@@ -327,6 +331,9 @@ static int txgbe_open(struct net_device *netdev)
 
 err_free_irq:
 	wx_free_irq(wx);
+err_free_misc_irq:
+	txgbe_free_misc_irq(wx->priv);
+	wx_reset_interrupt_capability(wx);
 err_free_resources:
 	wx_free_resources(wx);
 err_reset:
@@ -365,6 +372,7 @@ static int txgbe_close(struct net_device *netdev)
 
 	txgbe_down(wx);
 	wx_free_irq(wx);
+	txgbe_free_misc_irq(wx->priv);
 	wx_free_resources(wx);
 	txgbe_fdir_filter_exit(wx);
 	wx_control_hw(wx, false);
@@ -410,7 +418,6 @@ static void txgbe_shutdown(struct pci_dev *pdev)
 int txgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct wx *wx = netdev_priv(dev);
-	struct txgbe *txgbe = wx->priv;
 
 	/* Hardware has to reinitialize queues and interrupts to
 	 * match packet buffer alignment. Unfortunately, the
@@ -421,7 +428,6 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	else
 		txgbe_reset(wx);
 
-	txgbe_free_misc_irq(txgbe);
 	wx_clear_interrupt_scheme(wx);
 
 	if (tc)
@@ -430,7 +436,6 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 		netdev_reset_tc(dev);
 
 	wx_init_interrupt_scheme(wx);
-	txgbe_setup_misc_irq(txgbe);
 
 	if (netif_running(dev))
 		txgbe_open(dev);
@@ -677,13 +682,9 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 	txgbe_init_fdir(txgbe);
 
-	err = txgbe_setup_misc_irq(txgbe);
-	if (err)
-		goto err_release_hw;
-
 	err = txgbe_init_phy(txgbe);
 	if (err)
-		goto err_free_misc_irq;
+		goto err_release_hw;
 
 	err = register_netdev(netdev);
 	if (err)
@@ -711,8 +712,6 @@ static int txgbe_probe(struct pci_dev *pdev,
 
 err_remove_phy:
 	txgbe_remove_phy(txgbe);
-err_free_misc_irq:
-	txgbe_free_misc_irq(txgbe);
 err_release_hw:
 	wx_clear_interrupt_scheme(wx);
 	wx_control_hw(wx, false);
@@ -746,7 +745,6 @@ static void txgbe_remove(struct pci_dev *pdev)
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
-	txgbe_free_misc_irq(txgbe);
 	wx_free_isb_resources(wx);
 
 	pci_release_selected_regions(pdev,
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 531b1b6a37d1..2f8637224b69 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4229,8 +4229,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	if (!dev)
 		return;
 
-	netif_napi_del(&dev->napi);
-
 	udev = interface_to_usbdev(intf);
 	net = dev->net;
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6d36cb204f9b..54c5d9a14c67 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -765,6 +765,26 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
 	return (unsigned long)mrg_ctx & ((1 << MRG_CTX_HEADER_SHIFT) - 1);
 }
 
+static int check_mergeable_len(struct net_device *dev, void *mrg_ctx,
+			       unsigned int len)
+{
+	unsigned int headroom, tailroom, room, truesize;
+
+	truesize = mergeable_ctx_to_truesize(mrg_ctx);
+	headroom = mergeable_ctx_to_headroom(mrg_ctx);
+	tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
+	room = SKB_DATA_ALIGN(headroom + tailroom);
+
+	if (len > truesize - room) {
+		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
+			 dev->name, len, (unsigned long)(truesize - room));
+		DEV_STATS_INC(dev, rx_length_errors);
+		return -1;
+	}
+
+	return 0;
+}
+
 static struct sk_buff *virtnet_build_skb(void *buf, unsigned int buflen,
 					 unsigned int headroom,
 					 unsigned int len)
@@ -1098,15 +1118,29 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 	sg->length = len;
 }
 
+/* Note that @len is the length of received data without virtio header */
 static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
-				   struct receive_queue *rq, void *buf, u32 len)
+				   struct receive_queue *rq, void *buf,
+				   u32 len, bool first_buf)
 {
 	struct xdp_buff *xdp;
 	u32 bufsize;
 
 	xdp = (struct xdp_buff *)buf;
 
-	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool) + vi->hdr_len;
+	/* In virtnet_add_recvbuf_xsk, we use part of XDP_PACKET_HEADROOM for
+	 * virtio header and ask the vhost to fill data from
+	 *         hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
+	 * The first buffer has virtio header so the remaining region for frame
+	 * data is
+	 *         xsk_pool_get_rx_frame_size()
+	 * While other buffers than the first one do not have virtio header, so
+	 * the maximum frame data's length can be
+	 *         xsk_pool_get_rx_frame_size() + vi->hdr_len
+	 */
+	bufsize = xsk_pool_get_rx_frame_size(rq->xsk_pool);
+	if (!first_buf)
+		bufsize += vi->hdr_len;
 
 	if (unlikely(len > bufsize)) {
 		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
@@ -1231,7 +1265,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 
 		u64_stats_add(&stats->bytes, len);
 
-		xdp = buf_to_xdp(vi, rq, buf, len);
+		xdp = buf_to_xdp(vi, rq, buf, len, false);
 		if (!xdp)
 			goto err;
 
@@ -1329,7 +1363,7 @@ static void virtnet_receive_xsk_buf(struct virtnet_info *vi, struct receive_queu
 
 	u64_stats_add(&stats->bytes, len);
 
-	xdp = buf_to_xdp(vi, rq, buf, len);
+	xdp = buf_to_xdp(vi, rq, buf, len, true);
 	if (!xdp)
 		return;
 
@@ -1649,7 +1683,8 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
  * across multiple buffers (num_buf > 1), and we make sure buffers
  * have enough headroom.
  */
-static struct page *xdp_linearize_page(struct receive_queue *rq,
+static struct page *xdp_linearize_page(struct net_device *dev,
+				       struct receive_queue *rq,
 				       int *num_buf,
 				       struct page *p,
 				       int offset,
@@ -1669,18 +1704,27 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 	memcpy(page_address(page) + page_off, page_address(p) + offset, *len);
 	page_off += *len;
 
+	/* Only mergeable mode can go inside this while loop. In small mode,
+	 * *num_buf == 1, so it cannot go inside.
+	 */
 	while (--*num_buf) {
 		unsigned int buflen;
 		void *buf;
+		void *ctx;
 		int off;
 
-		buf = virtnet_rq_get_buf(rq, &buflen, NULL);
+		buf = virtnet_rq_get_buf(rq, &buflen, &ctx);
 		if (unlikely(!buf))
 			goto err_buf;
 
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
+		if (check_mergeable_len(dev, ctx, buflen)) {
+			put_page(p);
+			goto err_buf;
+		}
+
 		/* guard against a misconfigured or uncooperative backend that
 		 * is sending packet larger than the MTU.
 		 */
@@ -1769,7 +1813,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 		headroom = vi->hdr_len + header_offset;
 		buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-		xdp_page = xdp_linearize_page(rq, &num_buf, page,
+		xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
 					      offset, header_offset,
 					      &tlen);
 		if (!xdp_page)
@@ -2104,7 +2148,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 	 */
 	if (!xdp_prog->aux->xdp_has_frags) {
 		/* linearize data for XDP */
-		xdp_page = xdp_linearize_page(rq, num_buf,
+		xdp_page = xdp_linearize_page(vi->dev, rq, num_buf,
 					      *page, offset,
 					      XDP_PACKET_HEADROOM,
 					      len);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1623298ba2c4..eebdcc16e8fc 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1868,8 +1868,7 @@ static void ath12k_dp_rx_h_csum_offload(struct ath12k *ar, struct sk_buff *msdu)
 			  CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
 }
 
-static int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar,
-				       enum hal_encrypt_type enctype)
+int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype)
 {
 	switch (enctype) {
 	case HAL_ENCRYPT_TYPE_OPEN:
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index eb1f92559179..4232091d9e32 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -143,4 +143,7 @@ int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
 			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
 				       const void *ptr, void *data),
 			   void *data);
+
+int ath12k_dp_rx_crypto_mic_len(struct ath12k *ar, enum hal_encrypt_type enctype);
+
 #endif /* ATH12K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 734e3da4cbf1..21e07b5cee57 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -227,7 +227,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
 	struct hal_tcl_data_cmd *hal_tcl_desc;
 	struct hal_tx_msdu_ext_desc *msg;
-	struct sk_buff *skb_ext_desc;
+	struct sk_buff *skb_ext_desc = NULL;
 	struct hal_srng *tcl_ring;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct dp_tx_ring *tx_ring;
@@ -397,17 +397,15 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 			if (ret < 0) {
 				ath12k_dbg(ab, ATH12K_DBG_DP_TX,
 					   "Failed to add HTT meta data, dropping packet\n");
-				goto fail_unmap_dma;
+				goto fail_free_ext_skb;
 			}
 		}
 
 		ti.paddr = dma_map_single(ab->dev, skb_ext_desc->data,
 					  skb_ext_desc->len, DMA_TO_DEVICE);
 		ret = dma_mapping_error(ab->dev, ti.paddr);
-		if (ret) {
-			kfree_skb(skb_ext_desc);
-			goto fail_unmap_dma;
-		}
+		if (ret)
+			goto fail_free_ext_skb;
 
 		ti.data_len = skb_ext_desc->len;
 		ti.type = HAL_TCL_DESC_TYPE_EXT_DESC;
@@ -443,7 +441,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 			ring_selector++;
 		}
 
-		goto fail_unmap_dma;
+		goto fail_unmap_dma_ext;
 	}
 
 	ath12k_hal_tx_cmd_desc_setup(ab, hal_tcl_desc, &ti);
@@ -459,13 +457,16 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 
 	return 0;
 
-fail_unmap_dma:
-	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
-
+fail_unmap_dma_ext:
 	if (skb_cb->paddr_ext_desc)
 		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
 				 sizeof(struct hal_tx_msdu_ext_desc),
 				 DMA_TO_DEVICE);
+fail_free_ext_skb:
+	kfree_skb(skb_ext_desc);
+
+fail_unmap_dma:
+	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
 
 fail_remove_tx_buf:
 	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fbf5d5728357..4ca684278c36 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3864,8 +3864,8 @@ static int ath12k_install_key(struct ath12k_vif *arvif,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
 		arg.key_cipher = WMI_CIPHER_AES_CCM;
-		/* TODO: Re-check if flag is valid */
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV_MGMT;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -3873,12 +3873,10 @@ static int ath12k_install_key(struct ath12k_vif *arvif,
 		arg.key_txmic_len = 8;
 		arg.key_rxmic_len = 8;
 		break;
-	case WLAN_CIPHER_SUITE_CCMP_256:
-		arg.key_cipher = WMI_CIPHER_AES_CCM;
-		break;
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		arg.key_cipher = WMI_CIPHER_AES_GCM;
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV_MGMT;
 		break;
 	default:
 		ath12k_warn(ar->ab, "cipher %d is not supported\n", key->cipher);
@@ -5725,6 +5723,8 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_vif *arvif,
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info;
+	enum hal_encrypt_type enctype;
+	unsigned int mic_len;
 	dma_addr_t paddr;
 	int buf_id;
 	int ret;
@@ -5738,12 +5738,16 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_vif *arvif,
 		return -ENOSPC;
 
 	info = IEEE80211_SKB_CB(skb);
-	if (!(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
+	if ((ATH12K_SKB_CB(skb)->flags & ATH12K_SKB_CIPHER_SET) &&
+	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
 		if ((ieee80211_is_action(hdr->frame_control) ||
 		     ieee80211_is_deauth(hdr->frame_control) ||
 		     ieee80211_is_disassoc(hdr->frame_control)) &&
 		     ieee80211_has_protected(hdr->frame_control)) {
-			skb_put(skb, IEEE80211_CCMP_MIC_LEN);
+			enctype =
+			    ath12k_dp_tx_get_encrypt_type(ATH12K_SKB_CB(skb)->cipher);
+			mic_len = ath12k_dp_rx_crypto_mic_len(ar, enctype);
+			skb_put(skb, mic_len);
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath6kl/bmi.c b/drivers/net/wireless/ath/ath6kl/bmi.c
index af98e871199d..5a9e93fd1ef4 100644
--- a/drivers/net/wireless/ath/ath6kl/bmi.c
+++ b/drivers/net/wireless/ath/ath6kl/bmi.c
@@ -87,7 +87,9 @@ int ath6kl_bmi_get_target_info(struct ath6kl *ar,
 		 * We need to do some backwards compatibility to make this work.
 		 */
 		if (le32_to_cpu(targ_info->byte_count) != sizeof(*targ_info)) {
-			WARN_ON(1);
+			ath6kl_err("mismatched byte count %d vs. expected %zd\n",
+				   le32_to_cpu(targ_info->byte_count),
+				   sizeof(*targ_info));
 			return -EINVAL;
 		}
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eca764fede48..abd42598fc78 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -380,7 +380,7 @@ static void nvme_log_err_passthru(struct request *req)
 		nr->cmd->common.cdw12,
 		nr->cmd->common.cdw13,
 		nr->cmd->common.cdw14,
-		nr->cmd->common.cdw14);
+		nr->cmd->common.cdw15);
 }
 
 enum nvme_disposition {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 190f55e6d753..3062562c096a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -714,6 +714,8 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 {
 	if (bio != &req->b.inline_bio)
 		bio_put(bio);
+	else
+		bio_uninit(bio);
 }
 
 #ifdef CONFIG_NVME_TARGET_AUTH
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 9ff7b487dc48..fbb8128d19de 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -710,7 +710,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_llt_events[] = {
 	{101, "GDC_BANK0_HIT_DCL_PARTIAL"},
 	{102, "GDC_BANK0_EVICT_DCL"},
 	{103, "GDC_BANK0_G_RSE_PIPE_CACHE_DATA0"},
-	{103, "GDC_BANK0_G_RSE_PIPE_CACHE_DATA1"},
+	{104, "GDC_BANK0_G_RSE_PIPE_CACHE_DATA1"},
 	{105, "GDC_BANK0_ARB_STRB"},
 	{106, "GDC_BANK0_ARB_WAIT"},
 	{107, "GDC_BANK0_GGA_STRB"},
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 6c834e39352d..d2c27cc0733b 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -281,7 +281,8 @@ static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
 		vring->align = SMP_CACHE_BYTES;
 		vring->index = i;
 		vring->vdev_id = tm_vdev->vdev.id.device;
-		vring->drop_desc.len = VRING_DROP_DESC_MAX_LEN;
+		vring->drop_desc.len = cpu_to_virtio32(&tm_vdev->vdev,
+						       VRING_DROP_DESC_MAX_LEN);
 		dev = &tm_vdev->vdev.dev;
 
 		size = vring_size(vring->num, vring->align);
diff --git a/drivers/platform/mellanox/mlxreg-lc.c b/drivers/platform/mellanox/mlxreg-lc.c
index 43d119e3a473..99152676dbd2 100644
--- a/drivers/platform/mellanox/mlxreg-lc.c
+++ b/drivers/platform/mellanox/mlxreg-lc.c
@@ -688,7 +688,7 @@ static int mlxreg_lc_completion_notify(void *handle, struct i2c_adapter *parent,
 	if (regval & mlxreg_lc->data->mask) {
 		mlxreg_lc->state |= MLXREG_LC_SYNCED;
 		mlxreg_lc_state_update_locked(mlxreg_lc, MLXREG_LC_SYNCED, 1);
-		if (mlxreg_lc->state & ~MLXREG_LC_POWERED) {
+		if (!(mlxreg_lc->state & MLXREG_LC_POWERED)) {
 			err = mlxreg_lc_power_on_off(mlxreg_lc, 1);
 			if (err)
 				goto mlxreg_lc_regmap_power_on_off_fail;
diff --git a/drivers/platform/mellanox/nvsw-sn2201.c b/drivers/platform/mellanox/nvsw-sn2201.c
index abe7be602f84..e708521e5274 100644
--- a/drivers/platform/mellanox/nvsw-sn2201.c
+++ b/drivers/platform/mellanox/nvsw-sn2201.c
@@ -1088,7 +1088,7 @@ static int nvsw_sn2201_i2c_completion_notify(void *handle, int id)
 	if (!nvsw_sn2201->main_mux_devs->adapter) {
 		err = -ENODEV;
 		dev_err(nvsw_sn2201->dev, "Failed to get adapter for bus %d\n",
-			nvsw_sn2201->cpld_devs->nr);
+			nvsw_sn2201->main_mux_devs->nr);
 		goto i2c_get_adapter_main_fail;
 	}
 
diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 2e3f6fc67c56..7ed12c1d3b34 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -224,6 +224,15 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "WUJIE14-GX4HRXL"),
 		}
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=220116 */
+	{
+		.ident = "PCSpecialist Lafite Pro V 14M",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Lafite Pro V 14M"),
+		}
+	},
 	{}
 };
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
index 3ad33a094588..817ee7ba07ca 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
@@ -89,6 +89,11 @@ extern struct wmi_sysman_priv wmi_priv;
 
 enum { ENUM, INT, STR, PO };
 
+#define ENUM_MIN_ELEMENTS		8
+#define INT_MIN_ELEMENTS		9
+#define STR_MIN_ELEMENTS		8
+#define PO_MIN_ELEMENTS			4
+
 enum {
 	ATTR_NAME,
 	DISPL_NAME_LANG_CODE,
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
index 8cc212c85266..fc2f58b4cbc6 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
@@ -23,9 +23,10 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
 	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
 	if (!obj)
 		return -EIO;
-	if (obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_STRING) {
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count < ENUM_MIN_ELEMENTS ||
+	    obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_STRING) {
 		kfree(obj);
-		return -EINVAL;
+		return -EIO;
 	}
 	ret = snprintf(buf, PAGE_SIZE, "%s\n", obj->package.elements[CURRENT_VAL].string.pointer);
 	kfree(obj);
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
index 951e75b538fa..735248064239 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
@@ -25,9 +25,10 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
 	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
 	if (!obj)
 		return -EIO;
-	if (obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_INTEGER) {
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count < INT_MIN_ELEMENTS ||
+	    obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_INTEGER) {
 		kfree(obj);
-		return -EINVAL;
+		return -EIO;
 	}
 	ret = snprintf(buf, PAGE_SIZE, "%lld\n", obj->package.elements[CURRENT_VAL].integer.value);
 	kfree(obj);
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
index d8f1bf5e58a0..3167e06d416e 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
@@ -26,9 +26,10 @@ static ssize_t is_enabled_show(struct kobject *kobj, struct kobj_attribute *attr
 	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
 	if (!obj)
 		return -EIO;
-	if (obj->package.elements[IS_PASS_SET].type != ACPI_TYPE_INTEGER) {
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count < PO_MIN_ELEMENTS ||
+	    obj->package.elements[IS_PASS_SET].type != ACPI_TYPE_INTEGER) {
 		kfree(obj);
-		return -EINVAL;
+		return -EIO;
 	}
 	ret = snprintf(buf, PAGE_SIZE, "%lld\n", obj->package.elements[IS_PASS_SET].integer.value);
 	kfree(obj);
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
index c392f0ecf8b5..0d2c74f8d1aa 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
@@ -25,9 +25,10 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
 	obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
 	if (!obj)
 		return -EIO;
-	if (obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_STRING) {
+	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count < STR_MIN_ELEMENTS ||
+	    obj->package.elements[CURRENT_VAL].type != ACPI_TYPE_STRING) {
 		kfree(obj);
-		return -EINVAL;
+		return -EIO;
 	}
 	ret = snprintf(buf, PAGE_SIZE, "%s\n", obj->package.elements[CURRENT_VAL].string.pointer);
 	kfree(obj);
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 40ddc6eb7562..f5402b714657 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -25,7 +25,6 @@ struct wmi_sysman_priv wmi_priv = {
 /* reset bios to defaults */
 static const char * const reset_types[] = {"builtinsafe", "lastknowngood", "factory", "custom"};
 static int reset_option = -1;
-static const struct class *fw_attr_class;
 
 
 /**
@@ -408,10 +407,10 @@ static int init_bios_attributes(int attr_type, const char *guid)
 		return retval;
 
 	switch (attr_type) {
-	case ENUM:	min_elements = 8;	break;
-	case INT:	min_elements = 9;	break;
-	case STR:	min_elements = 8;	break;
-	case PO:	min_elements = 4;	break;
+	case ENUM:	min_elements = ENUM_MIN_ELEMENTS;	break;
+	case INT:	min_elements = INT_MIN_ELEMENTS;	break;
+	case STR:	min_elements = STR_MIN_ELEMENTS;	break;
+	case PO:	min_elements = PO_MIN_ELEMENTS;		break;
 	default:
 		pr_err("Error: Unknown attr_type: %d\n", attr_type);
 		return -EINVAL;
@@ -541,15 +540,11 @@ static int __init sysman_init(void)
 		goto err_exit_bios_attr_pass_interface;
 	}
 
-	ret = fw_attributes_class_get(&fw_attr_class);
-	if (ret)
-		goto err_exit_bios_attr_pass_interface;
-
-	wmi_priv.class_dev = device_create(fw_attr_class, NULL, MKDEV(0, 0),
+	wmi_priv.class_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
 				  NULL, "%s", DRIVER_NAME);
 	if (IS_ERR(wmi_priv.class_dev)) {
 		ret = PTR_ERR(wmi_priv.class_dev);
-		goto err_unregister_class;
+		goto err_exit_bios_attr_pass_interface;
 	}
 
 	wmi_priv.main_dir_kset = kset_create_and_add("attributes", NULL,
@@ -602,10 +597,7 @@ static int __init sysman_init(void)
 	release_attributes_data();
 
 err_destroy_classdev:
-	device_destroy(fw_attr_class, MKDEV(0, 0));
-
-err_unregister_class:
-	fw_attributes_class_put();
+	device_unregister(wmi_priv.class_dev);
 
 err_exit_bios_attr_pass_interface:
 	exit_bios_attr_pass_interface();
@@ -619,8 +611,7 @@ static int __init sysman_init(void)
 static void __exit sysman_exit(void)
 {
 	release_attributes_data();
-	device_destroy(fw_attr_class, MKDEV(0, 0));
-	fw_attributes_class_put();
+	device_unregister(wmi_priv.class_dev);
 	exit_bios_attr_set_interface();
 	exit_bios_attr_pass_interface();
 }
diff --git a/drivers/platform/x86/firmware_attributes_class.c b/drivers/platform/x86/firmware_attributes_class.c
index 182a07d8ae3d..87672c49e86a 100644
--- a/drivers/platform/x86/firmware_attributes_class.c
+++ b/drivers/platform/x86/firmware_attributes_class.c
@@ -2,48 +2,35 @@
 
 /* Firmware attributes class helper module */
 
-#include <linux/mutex.h>
-#include <linux/device/class.h>
 #include <linux/module.h>
 #include "firmware_attributes_class.h"
 
-static DEFINE_MUTEX(fw_attr_lock);
-static int fw_attr_inuse;
-
-static const struct class firmware_attributes_class = {
+const struct class firmware_attributes_class = {
 	.name = "firmware-attributes",
 };
+EXPORT_SYMBOL_GPL(firmware_attributes_class);
+
+static __init int fw_attributes_class_init(void)
+{
+	return class_register(&firmware_attributes_class);
+}
+module_init(fw_attributes_class_init);
+
+static __exit void fw_attributes_class_exit(void)
+{
+	class_unregister(&firmware_attributes_class);
+}
+module_exit(fw_attributes_class_exit);
 
 int fw_attributes_class_get(const struct class **fw_attr_class)
 {
-	int err;
-
-	mutex_lock(&fw_attr_lock);
-	if (!fw_attr_inuse) { /*first time class is being used*/
-		err = class_register(&firmware_attributes_class);
-		if (err) {
-			mutex_unlock(&fw_attr_lock);
-			return err;
-		}
-	}
-	fw_attr_inuse++;
 	*fw_attr_class = &firmware_attributes_class;
-	mutex_unlock(&fw_attr_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fw_attributes_class_get);
 
 int fw_attributes_class_put(void)
 {
-	mutex_lock(&fw_attr_lock);
-	if (!fw_attr_inuse) {
-		mutex_unlock(&fw_attr_lock);
-		return -EINVAL;
-	}
-	fw_attr_inuse--;
-	if (!fw_attr_inuse) /* No more consumers */
-		class_unregister(&firmware_attributes_class);
-	mutex_unlock(&fw_attr_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fw_attributes_class_put);
diff --git a/drivers/platform/x86/firmware_attributes_class.h b/drivers/platform/x86/firmware_attributes_class.h
index 363c75f1ac1b..ef6c3764a834 100644
--- a/drivers/platform/x86/firmware_attributes_class.h
+++ b/drivers/platform/x86/firmware_attributes_class.h
@@ -5,6 +5,9 @@
 #ifndef FW_ATTR_CLASS_H
 #define FW_ATTR_CLASS_H
 
+#include <linux/device/class.h>
+
+extern const struct class firmware_attributes_class;
 int fw_attributes_class_get(const struct class **fw_attr_class);
 int fw_attributes_class_put(void);
 
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 2dc50152158a..00b04adb4f19 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -24,8 +24,6 @@ struct bioscfg_priv bioscfg_drv = {
 	.mutex = __MUTEX_INITIALIZER(bioscfg_drv.mutex),
 };
 
-static const struct class *fw_attr_class;
-
 ssize_t display_name_language_code_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *buf)
@@ -972,11 +970,7 @@ static int __init hp_init(void)
 	if (ret)
 		return ret;
 
-	ret = fw_attributes_class_get(&fw_attr_class);
-	if (ret)
-		goto err_unregister_class;
-
-	bioscfg_drv.class_dev = device_create(fw_attr_class, NULL, MKDEV(0, 0),
+	bioscfg_drv.class_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
 					      NULL, "%s", DRIVER_NAME);
 	if (IS_ERR(bioscfg_drv.class_dev)) {
 		ret = PTR_ERR(bioscfg_drv.class_dev);
@@ -1043,10 +1037,9 @@ static int __init hp_init(void)
 	release_attributes_data();
 
 err_destroy_classdev:
-	device_destroy(fw_attr_class, MKDEV(0, 0));
+	device_unregister(bioscfg_drv.class_dev);
 
 err_unregister_class:
-	fw_attributes_class_put();
 	hp_exit_attr_set_interface();
 
 	return ret;
@@ -1055,9 +1048,8 @@ static int __init hp_init(void)
 static void __exit hp_exit(void)
 {
 	release_attributes_data();
-	device_destroy(fw_attr_class, MKDEV(0, 0));
+	device_unregister(bioscfg_drv.class_dev);
 
-	fw_attributes_class_put();
 	hp_exit_attr_set_interface();
 }
 
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 1abd8378f158..6ad2af46248b 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -192,7 +192,6 @@ static const char * const level_options[] = {
 	[TLMI_LEVEL_MASTER] = "master",
 };
 static struct think_lmi tlmi_priv;
-static const struct class *fw_attr_class;
 static DEFINE_MUTEX(tlmi_mutex);
 
 static inline struct tlmi_pwd_setting *to_tlmi_pwd_setting(struct kobject *kobj)
@@ -907,6 +906,7 @@ static const struct attribute_group auth_attr_group = {
 	.is_visible = auth_attr_is_visible,
 	.attrs = auth_attrs,
 };
+__ATTRIBUTE_GROUPS(auth_attr);
 
 /* ---- Attributes sysfs --------------------------------------------------------- */
 static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1122,6 +1122,7 @@ static const struct attribute_group tlmi_attr_group = {
 	.is_visible = attr_is_visible,
 	.attrs = tlmi_attrs,
 };
+__ATTRIBUTE_GROUPS(tlmi_attr);
 
 static void tlmi_attr_setting_release(struct kobject *kobj)
 {
@@ -1141,11 +1142,13 @@ static void tlmi_pwd_setting_release(struct kobject *kobj)
 static const struct kobj_type tlmi_attr_setting_ktype = {
 	.release        = &tlmi_attr_setting_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
+	.default_groups = tlmi_attr_groups,
 };
 
 static const struct kobj_type tlmi_pwd_setting_ktype = {
 	.release        = &tlmi_pwd_setting_release,
 	.sysfs_ops	= &kobj_sysfs_ops,
+	.default_groups = auth_attr_groups,
 };
 
 static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1314,21 +1317,18 @@ static struct kobj_attribute debug_cmd = __ATTR_WO(debug_cmd);
 /* ---- Initialisation --------------------------------------------------------- */
 static void tlmi_release_attr(void)
 {
-	int i;
+	struct kobject *pos, *n;
 
 	/* Attribute structures */
-	for (i = 0; i < TLMI_SETTINGS_COUNT; i++) {
-		if (tlmi_priv.setting[i]) {
-			sysfs_remove_group(&tlmi_priv.setting[i]->kobj, &tlmi_attr_group);
-			kobject_put(&tlmi_priv.setting[i]->kobj);
-		}
-	}
 	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &pending_reboot.attr);
 	sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &save_settings.attr);
 
 	if (tlmi_priv.can_debug_cmd && debug_support)
 		sysfs_remove_file(&tlmi_priv.attribute_kset->kobj, &debug_cmd.attr);
 
+	list_for_each_entry_safe(pos, n, &tlmi_priv.attribute_kset->list, entry)
+		kobject_put(pos);
+
 	kset_unregister(tlmi_priv.attribute_kset);
 
 	/* Free up any saved signatures */
@@ -1336,19 +1336,8 @@ static void tlmi_release_attr(void)
 	kfree(tlmi_priv.pwd_admin->save_signature);
 
 	/* Authentication structures */
-	sysfs_remove_group(&tlmi_priv.pwd_admin->kobj, &auth_attr_group);
-	kobject_put(&tlmi_priv.pwd_admin->kobj);
-	sysfs_remove_group(&tlmi_priv.pwd_power->kobj, &auth_attr_group);
-	kobject_put(&tlmi_priv.pwd_power->kobj);
-
-	if (tlmi_priv.opcode_support) {
-		sysfs_remove_group(&tlmi_priv.pwd_system->kobj, &auth_attr_group);
-		kobject_put(&tlmi_priv.pwd_system->kobj);
-		sysfs_remove_group(&tlmi_priv.pwd_hdd->kobj, &auth_attr_group);
-		kobject_put(&tlmi_priv.pwd_hdd->kobj);
-		sysfs_remove_group(&tlmi_priv.pwd_nvme->kobj, &auth_attr_group);
-		kobject_put(&tlmi_priv.pwd_nvme->kobj);
-	}
+	list_for_each_entry_safe(pos, n, &tlmi_priv.authentication_kset->list, entry)
+		kobject_put(pos);
 
 	kset_unregister(tlmi_priv.authentication_kset);
 }
@@ -1375,11 +1364,7 @@ static int tlmi_sysfs_init(void)
 {
 	int i, ret;
 
-	ret = fw_attributes_class_get(&fw_attr_class);
-	if (ret)
-		return ret;
-
-	tlmi_priv.class_dev = device_create(fw_attr_class, NULL, MKDEV(0, 0),
+	tlmi_priv.class_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
 			NULL, "%s", "thinklmi");
 	if (IS_ERR(tlmi_priv.class_dev)) {
 		ret = PTR_ERR(tlmi_priv.class_dev);
@@ -1393,6 +1378,14 @@ static int tlmi_sysfs_init(void)
 		goto fail_device_created;
 	}
 
+	tlmi_priv.authentication_kset = kset_create_and_add("authentication", NULL,
+							    &tlmi_priv.class_dev->kobj);
+	if (!tlmi_priv.authentication_kset) {
+		kset_unregister(tlmi_priv.attribute_kset);
+		ret = -ENOMEM;
+		goto fail_device_created;
+	}
+
 	for (i = 0; i < TLMI_SETTINGS_COUNT; i++) {
 		/* Check if index is a valid setting - skip if it isn't */
 		if (!tlmi_priv.setting[i])
@@ -1409,12 +1402,8 @@ static int tlmi_sysfs_init(void)
 
 		/* Build attribute */
 		tlmi_priv.setting[i]->kobj.kset = tlmi_priv.attribute_kset;
-		ret = kobject_add(&tlmi_priv.setting[i]->kobj, NULL,
-				  "%s", tlmi_priv.setting[i]->display_name);
-		if (ret)
-			goto fail_create_attr;
-
-		ret = sysfs_create_group(&tlmi_priv.setting[i]->kobj, &tlmi_attr_group);
+		ret = kobject_init_and_add(&tlmi_priv.setting[i]->kobj, &tlmi_attr_setting_ktype,
+					   NULL, "%s", tlmi_priv.setting[i]->display_name);
 		if (ret)
 			goto fail_create_attr;
 	}
@@ -1434,55 +1423,34 @@ static int tlmi_sysfs_init(void)
 	}
 
 	/* Create authentication entries */
-	tlmi_priv.authentication_kset = kset_create_and_add("authentication", NULL,
-								&tlmi_priv.class_dev->kobj);
-	if (!tlmi_priv.authentication_kset) {
-		ret = -ENOMEM;
-		goto fail_create_attr;
-	}
 	tlmi_priv.pwd_admin->kobj.kset = tlmi_priv.authentication_kset;
-	ret = kobject_add(&tlmi_priv.pwd_admin->kobj, NULL, "%s", "Admin");
-	if (ret)
-		goto fail_create_attr;
-
-	ret = sysfs_create_group(&tlmi_priv.pwd_admin->kobj, &auth_attr_group);
+	ret = kobject_init_and_add(&tlmi_priv.pwd_admin->kobj, &tlmi_pwd_setting_ktype,
+				   NULL, "%s", "Admin");
 	if (ret)
 		goto fail_create_attr;
 
 	tlmi_priv.pwd_power->kobj.kset = tlmi_priv.authentication_kset;
-	ret = kobject_add(&tlmi_priv.pwd_power->kobj, NULL, "%s", "Power-on");
-	if (ret)
-		goto fail_create_attr;
-
-	ret = sysfs_create_group(&tlmi_priv.pwd_power->kobj, &auth_attr_group);
+	ret = kobject_init_and_add(&tlmi_priv.pwd_power->kobj, &tlmi_pwd_setting_ktype,
+				   NULL, "%s", "Power-on");
 	if (ret)
 		goto fail_create_attr;
 
 	if (tlmi_priv.opcode_support) {
 		tlmi_priv.pwd_system->kobj.kset = tlmi_priv.authentication_kset;
-		ret = kobject_add(&tlmi_priv.pwd_system->kobj, NULL, "%s", "System");
-		if (ret)
-			goto fail_create_attr;
-
-		ret = sysfs_create_group(&tlmi_priv.pwd_system->kobj, &auth_attr_group);
+		ret = kobject_init_and_add(&tlmi_priv.pwd_system->kobj, &tlmi_pwd_setting_ktype,
+					   NULL, "%s", "System");
 		if (ret)
 			goto fail_create_attr;
 
 		tlmi_priv.pwd_hdd->kobj.kset = tlmi_priv.authentication_kset;
-		ret = kobject_add(&tlmi_priv.pwd_hdd->kobj, NULL, "%s", "HDD");
-		if (ret)
-			goto fail_create_attr;
-
-		ret = sysfs_create_group(&tlmi_priv.pwd_hdd->kobj, &auth_attr_group);
+		ret = kobject_init_and_add(&tlmi_priv.pwd_hdd->kobj, &tlmi_pwd_setting_ktype,
+					   NULL, "%s", "HDD");
 		if (ret)
 			goto fail_create_attr;
 
 		tlmi_priv.pwd_nvme->kobj.kset = tlmi_priv.authentication_kset;
-		ret = kobject_add(&tlmi_priv.pwd_nvme->kobj, NULL, "%s", "NVMe");
-		if (ret)
-			goto fail_create_attr;
-
-		ret = sysfs_create_group(&tlmi_priv.pwd_nvme->kobj, &auth_attr_group);
+		ret = kobject_init_and_add(&tlmi_priv.pwd_nvme->kobj, &tlmi_pwd_setting_ktype,
+					   NULL, "%s", "NVMe");
 		if (ret)
 			goto fail_create_attr;
 	}
@@ -1492,9 +1460,8 @@ static int tlmi_sysfs_init(void)
 fail_create_attr:
 	tlmi_release_attr();
 fail_device_created:
-	device_destroy(fw_attr_class, MKDEV(0, 0));
+	device_unregister(tlmi_priv.class_dev);
 fail_class_created:
-	fw_attributes_class_put();
 	return ret;
 }
 
@@ -1516,8 +1483,6 @@ static struct tlmi_pwd_setting *tlmi_create_auth(const char *pwd_type,
 	new_pwd->maxlen = tlmi_priv.pwdcfg.core.max_length;
 	new_pwd->index = 0;
 
-	kobject_init(&new_pwd->kobj, &tlmi_pwd_setting_ktype);
-
 	return new_pwd;
 }
 
@@ -1621,7 +1586,6 @@ static int tlmi_analyze(void)
 		if (setting->possible_values)
 			strreplace(setting->possible_values, ',', ';');
 
-		kobject_init(&setting->kobj, &tlmi_attr_setting_ktype);
 		tlmi_priv.setting[i] = setting;
 		kfree(item);
 	}
@@ -1717,8 +1681,7 @@ static int tlmi_analyze(void)
 static void tlmi_remove(struct wmi_device *wdev)
 {
 	tlmi_release_attr();
-	device_destroy(fw_attr_class, MKDEV(0, 0));
-	fw_attributes_class_put();
+	device_unregister(tlmi_priv.class_dev);
 }
 
 static int tlmi_probe(struct wmi_device *wdev, const void *context)
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 5e793b80fd6b..c3de52e78e01 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -340,12 +340,28 @@ static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
 	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	u64 val;
 	int ret;
 
 	cpus_read_lock();
 	ret = rapl_write_pl_data(rd, POWER_LIMIT1, PL_ENABLE, mode);
-	if (!ret && defaults->set_floor_freq)
+	if (ret)
+		goto end;
+
+	ret = rapl_read_pl_data(rd, POWER_LIMIT1, PL_ENABLE, false, &val);
+	if (ret)
+		goto end;
+
+	if (mode != val) {
+		pr_debug("%s cannot be %s\n", power_zone->name,
+			 str_enabled_disabled(mode));
+		goto end;
+	}
+
+	if (defaults->set_floor_freq)
 		defaults->set_floor_freq(rd, mode);
+
+end:
 	cpus_read_unlock();
 
 	return ret;
diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index bd9447dac596..c282236959b1 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -147,6 +147,7 @@ struct fan53555_device_info {
 	unsigned int slew_mask;
 	const unsigned int *ramp_delay_table;
 	unsigned int n_ramp_values;
+	unsigned int enable_time;
 	unsigned int slew_rate;
 };
 
@@ -282,6 +283,7 @@ static int fan53526_voltages_setup_fairchild(struct fan53555_device_info *di)
 	di->slew_mask = CTL_SLEW_MASK;
 	di->ramp_delay_table = slew_rates;
 	di->n_ramp_values = ARRAY_SIZE(slew_rates);
+	di->enable_time = 250;
 	di->vsel_count = FAN53526_NVOLTAGES;
 
 	return 0;
@@ -296,10 +298,12 @@ static int fan53555_voltages_setup_fairchild(struct fan53555_device_info *di)
 		case FAN53555_CHIP_REV_00:
 			di->vsel_min = 600000;
 			di->vsel_step = 10000;
+			di->enable_time = 400;
 			break;
 		case FAN53555_CHIP_REV_13:
 			di->vsel_min = 800000;
 			di->vsel_step = 10000;
+			di->enable_time = 400;
 			break;
 		default:
 			dev_err(di->dev,
@@ -311,13 +315,19 @@ static int fan53555_voltages_setup_fairchild(struct fan53555_device_info *di)
 	case FAN53555_CHIP_ID_01:
 	case FAN53555_CHIP_ID_03:
 	case FAN53555_CHIP_ID_05:
+		di->vsel_min = 600000;
+		di->vsel_step = 10000;
+		di->enable_time = 400;
+		break;
 	case FAN53555_CHIP_ID_08:
 		di->vsel_min = 600000;
 		di->vsel_step = 10000;
+		di->enable_time = 175;
 		break;
 	case FAN53555_CHIP_ID_04:
 		di->vsel_min = 603000;
 		di->vsel_step = 12826;
+		di->enable_time = 400;
 		break;
 	default:
 		dev_err(di->dev,
@@ -350,6 +360,7 @@ static int fan53555_voltages_setup_rockchip(struct fan53555_device_info *di)
 	di->slew_mask = CTL_SLEW_MASK;
 	di->ramp_delay_table = slew_rates;
 	di->n_ramp_values = ARRAY_SIZE(slew_rates);
+	di->enable_time = 360;
 	di->vsel_count = FAN53555_NVOLTAGES;
 
 	return 0;
@@ -372,6 +383,7 @@ static int rk8602_voltages_setup_rockchip(struct fan53555_device_info *di)
 	di->slew_mask = CTL_SLEW_MASK;
 	di->ramp_delay_table = slew_rates;
 	di->n_ramp_values = ARRAY_SIZE(slew_rates);
+	di->enable_time = 360;
 	di->vsel_count = RK8602_NVOLTAGES;
 
 	return 0;
@@ -395,6 +407,7 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 	di->slew_mask = CTL_SLEW_MASK;
 	di->ramp_delay_table = slew_rates;
 	di->n_ramp_values = ARRAY_SIZE(slew_rates);
+	di->enable_time = 400;
 	di->vsel_count = FAN53555_NVOLTAGES;
 
 	return 0;
@@ -594,6 +607,7 @@ static int fan53555_regulator_register(struct fan53555_device_info *di,
 	rdesc->ramp_mask = di->slew_mask;
 	rdesc->ramp_delay_table = di->ramp_delay_table;
 	rdesc->n_ramp_values = di->n_ramp_values;
+	rdesc->enable_time = di->enable_time;
 	rdesc->owner = THIS_MODULE;
 
 	rdev = devm_regulator_register(di->dev, &di->desc, config);
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 65927fa2ef16..1bdd494cf882 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -260,8 +260,10 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	drvdata->gpiods = devm_kzalloc(dev, sizeof(struct gpio_desc *),
-				       GFP_KERNEL);
+	drvdata->gpiods = devm_kcalloc(dev, config->ngpios,
+				       sizeof(struct gpio_desc *), GFP_KERNEL);
+	if (!drvdata->gpiods)
+		return -ENOMEM;
 
 	if (config->input_supply) {
 		drvdata->desc.supply_name = devm_kstrdup(&pdev->dev,
@@ -274,8 +276,6 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (!drvdata->gpiods)
-		return -ENOMEM;
 	for (i = 0; i < config->ngpios; i++) {
 		drvdata->gpiods[i] = devm_gpiod_get_index(dev,
 							  NULL,
diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index 2ae0655ddf1d..73be3d216791 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -568,11 +568,9 @@ static int k3_dsp_reserved_mem_init(struct k3_dsp_rproc *kproc)
 			return -EINVAL;
 
 		rmem = of_reserved_mem_lookup(rmem_np);
-		if (!rmem) {
-			of_node_put(rmem_np);
-			return -EINVAL;
-		}
 		of_node_put(rmem_np);
+		if (!rmem)
+			return -EINVAL;
 
 		kproc->rmem[i].bus_addr = rmem->base;
 		/* 64-bit address regions currently not supported */
diff --git a/drivers/remoteproc/ti_k3_m4_remoteproc.c b/drivers/remoteproc/ti_k3_m4_remoteproc.c
index fba6e393635e..6cd50b16a8e8 100644
--- a/drivers/remoteproc/ti_k3_m4_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_m4_remoteproc.c
@@ -433,11 +433,9 @@ static int k3_m4_reserved_mem_init(struct k3_m4_rproc *kproc)
 			return -EINVAL;
 
 		rmem = of_reserved_mem_lookup(rmem_np);
-		if (!rmem) {
-			of_node_put(rmem_np);
-			return -EINVAL;
-		}
 		of_node_put(rmem_np);
+		if (!rmem)
+			return -EINVAL;
 
 		kproc->rmem[i].bus_addr = rmem->base;
 		/* 64-bit address regions currently not supported */
diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 4894461aa65f..941bb130c85c 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -440,13 +440,36 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 {
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
-	struct k3_r5_core *core = kproc->core;
+	struct k3_r5_core *core = kproc->core, *core0, *core1;
 	struct device *dev = kproc->dev;
 	u32 ctrl = 0, cfg = 0, stat = 0;
 	u64 boot_vec = 0;
 	bool mem_init_dis;
 	int ret;
 
+	/*
+	 * R5 cores require to be powered on sequentially, core0 should be in
+	 * higher power state than core1 in a cluster. So, wait for core0 to
+	 * power up before proceeding to core1 and put timeout of 2sec. This
+	 * waiting mechanism is necessary because rproc_auto_boot_callback() for
+	 * core1 can be called before core0 due to thread execution order.
+	 *
+	 * By placing the wait mechanism here in .prepare() ops, this condition
+	 * is enforced for rproc boot requests from sysfs as well.
+	 */
+	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
+	core1 = list_last_entry(&cluster->cores, struct k3_r5_core, elem);
+	if (cluster->mode == CLUSTER_MODE_SPLIT && core == core1 &&
+	    !core0->released_from_reset) {
+		ret = wait_event_interruptible_timeout(cluster->core_transition,
+						       core0->released_from_reset,
+						       msecs_to_jiffies(2000));
+		if (ret <= 0) {
+			dev_err(dev, "can not power up core1 before core0");
+			return -EPERM;
+		}
+	}
+
 	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl, &stat);
 	if (ret < 0)
 		return ret;
@@ -462,6 +485,14 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 		return ret;
 	}
 
+	/*
+	 * Notify all threads in the wait queue when core0 state has changed so
+	 * that threads waiting for this condition can be executed.
+	 */
+	core->released_from_reset = true;
+	if (core == core0)
+		wake_up_interruptible(&cluster->core_transition);
+
 	/*
 	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
 	 * of TCMs, so there is no need to perform the s/w memzero. This bit is
@@ -507,10 +538,30 @@ static int k3_r5_rproc_unprepare(struct rproc *rproc)
 {
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
-	struct k3_r5_core *core = kproc->core;
+	struct k3_r5_core *core = kproc->core, *core0, *core1;
 	struct device *dev = kproc->dev;
 	int ret;
 
+	/*
+	 * Ensure power-down of cores is sequential in split mode. Core1 must
+	 * power down before Core0 to maintain the expected state. By placing
+	 * the wait mechanism here in .unprepare() ops, this condition is
+	 * enforced for rproc stop or shutdown requests from sysfs and device
+	 * removal as well.
+	 */
+	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
+	core1 = list_last_entry(&cluster->cores, struct k3_r5_core, elem);
+	if (cluster->mode == CLUSTER_MODE_SPLIT && core == core0 &&
+	    core1->released_from_reset) {
+		ret = wait_event_interruptible_timeout(cluster->core_transition,
+						       !core1->released_from_reset,
+						       msecs_to_jiffies(2000));
+		if (ret <= 0) {
+			dev_err(dev, "can not power down core0 before core1");
+			return -EPERM;
+		}
+	}
+
 	/* Re-use LockStep-mode reset logic for Single-CPU mode */
 	ret = (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
 	       cluster->mode == CLUSTER_MODE_SINGLECPU) ?
@@ -518,6 +569,14 @@ static int k3_r5_rproc_unprepare(struct rproc *rproc)
 	if (ret)
 		dev_err(dev, "unable to disable cores, ret = %d\n", ret);
 
+	/*
+	 * Notify all threads in the wait queue when core1 state has changed so
+	 * that threads waiting for this condition can be executed.
+	 */
+	core->released_from_reset = false;
+	if (core == core1)
+		wake_up_interruptible(&cluster->core_transition);
+
 	return ret;
 }
 
@@ -543,7 +602,7 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
 	struct device *dev = kproc->dev;
-	struct k3_r5_core *core0, *core;
+	struct k3_r5_core *core;
 	u32 boot_addr;
 	int ret;
 
@@ -565,21 +624,9 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 				goto unroll_core_run;
 		}
 	} else {
-		/* do not allow core 1 to start before core 0 */
-		core0 = list_first_entry(&cluster->cores, struct k3_r5_core,
-					 elem);
-		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
-			dev_err(dev, "%s: can not start core 1 before core 0\n",
-				__func__);
-			return -EPERM;
-		}
-
 		ret = k3_r5_core_run(core);
 		if (ret)
 			return ret;
-
-		core->released_from_reset = true;
-		wake_up_interruptible(&cluster->core_transition);
 	}
 
 	return 0;
@@ -620,8 +667,7 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 {
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
-	struct device *dev = kproc->dev;
-	struct k3_r5_core *core1, *core = kproc->core;
+	struct k3_r5_core *core = kproc->core;
 	int ret;
 
 	/* halt all applicable cores */
@@ -634,16 +680,6 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 			}
 		}
 	} else {
-		/* do not allow core 0 to stop before core 1 */
-		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
-					elem);
-		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
-			dev_err(dev, "%s: can not stop core 0 before core 1\n",
-				__func__);
-			ret = -EPERM;
-			goto out;
-		}
-
 		ret = k3_r5_core_halt(core);
 		if (ret)
 			goto out;
@@ -947,6 +983,13 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
 	return ret;
 }
 
+static void k3_r5_mem_release(void *data)
+{
+	struct device *dev = data;
+
+	of_reserved_mem_device_release(dev);
+}
+
 static int k3_r5_reserved_mem_init(struct k3_r5_rproc *kproc)
 {
 	struct device *dev = kproc->dev;
@@ -977,28 +1020,25 @@ static int k3_r5_reserved_mem_init(struct k3_r5_rproc *kproc)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, k3_r5_mem_release, dev);
+	if (ret)
+		return ret;
+
 	num_rmems--;
-	kproc->rmem = kcalloc(num_rmems, sizeof(*kproc->rmem), GFP_KERNEL);
-	if (!kproc->rmem) {
-		ret = -ENOMEM;
-		goto release_rmem;
-	}
+	kproc->rmem = devm_kcalloc(dev, num_rmems, sizeof(*kproc->rmem), GFP_KERNEL);
+	if (!kproc->rmem)
+		return -ENOMEM;
 
 	/* use remaining reserved memory regions for static carveouts */
 	for (i = 0; i < num_rmems; i++) {
 		rmem_np = of_parse_phandle(np, "memory-region", i + 1);
-		if (!rmem_np) {
-			ret = -EINVAL;
-			goto unmap_rmem;
-		}
+		if (!rmem_np)
+			return -EINVAL;
 
 		rmem = of_reserved_mem_lookup(rmem_np);
-		if (!rmem) {
-			of_node_put(rmem_np);
-			ret = -EINVAL;
-			goto unmap_rmem;
-		}
 		of_node_put(rmem_np);
+		if (!rmem)
+			return -EINVAL;
 
 		kproc->rmem[i].bus_addr = rmem->base;
 		/*
@@ -1013,12 +1053,11 @@ static int k3_r5_reserved_mem_init(struct k3_r5_rproc *kproc)
 		 */
 		kproc->rmem[i].dev_addr = (u32)rmem->base;
 		kproc->rmem[i].size = rmem->size;
-		kproc->rmem[i].cpu_addr = ioremap_wc(rmem->base, rmem->size);
+		kproc->rmem[i].cpu_addr = devm_ioremap_wc(dev, rmem->base, rmem->size);
 		if (!kproc->rmem[i].cpu_addr) {
 			dev_err(dev, "failed to map reserved memory#%d at %pa of size %pa\n",
 				i + 1, &rmem->base, &rmem->size);
-			ret = -ENOMEM;
-			goto unmap_rmem;
+			return -ENOMEM;
 		}
 
 		dev_dbg(dev, "reserved memory%d: bus addr %pa size 0x%zx va %pK da 0x%x\n",
@@ -1029,25 +1068,6 @@ static int k3_r5_reserved_mem_init(struct k3_r5_rproc *kproc)
 	kproc->num_rmems = num_rmems;
 
 	return 0;
-
-unmap_rmem:
-	for (i--; i >= 0; i--)
-		iounmap(kproc->rmem[i].cpu_addr);
-	kfree(kproc->rmem);
-release_rmem:
-	of_reserved_mem_device_release(dev);
-	return ret;
-}
-
-static void k3_r5_reserved_mem_exit(struct k3_r5_rproc *kproc)
-{
-	int i;
-
-	for (i = 0; i < kproc->num_rmems; i++)
-		iounmap(kproc->rmem[i].cpu_addr);
-	kfree(kproc->rmem);
-
-	of_reserved_mem_device_release(kproc->dev);
 }
 
 /*
@@ -1274,10 +1294,10 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 			goto out;
 		}
 
-		ret = rproc_add(rproc);
+		ret = devm_rproc_add(dev, rproc);
 		if (ret) {
-			dev_err(dev, "rproc_add failed, ret = %d\n", ret);
-			goto err_add;
+			dev_err_probe(dev, ret, "rproc_add failed\n");
+			goto out;
 		}
 
 		/* create only one rproc in lockstep, single-cpu or
@@ -1287,26 +1307,6 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
 		    cluster->mode == CLUSTER_MODE_SINGLECORE)
 			break;
-
-		/*
-		 * R5 cores require to be powered on sequentially, core0
-		 * should be in higher power state than core1 in a cluster
-		 * So, wait for current core to power up before proceeding
-		 * to next core and put timeout of 2sec for each core.
-		 *
-		 * This waiting mechanism is necessary because
-		 * rproc_auto_boot_callback() for core1 can be called before
-		 * core0 due to thread execution order.
-		 */
-		ret = wait_event_interruptible_timeout(cluster->core_transition,
-						       core->released_from_reset,
-						       msecs_to_jiffies(2000));
-		if (ret <= 0) {
-			dev_err(dev,
-				"Timed out waiting for %s core to power up!\n",
-				rproc->name);
-			goto err_powerup;
-		}
 	}
 
 	return 0;
@@ -1321,10 +1321,6 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 		}
 	}
 
-err_powerup:
-	rproc_del(rproc);
-err_add:
-	k3_r5_reserved_mem_exit(kproc);
 out:
 	/* undo core0 upon any failures on core1 in split-mode */
 	if (cluster->mode == CLUSTER_MODE_SPLIT && core == core1) {
@@ -1367,10 +1363,6 @@ static void k3_r5_cluster_rproc_exit(void *data)
 		}
 
 		mbox_free_channel(kproc->mbox);
-
-		rproc_del(rproc);
-
-		k3_r5_reserved_mem_exit(kproc);
 	}
 }
 
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 5849d2970bba..095de4e0e4f3 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -697,8 +697,12 @@ static irqreturn_t cmos_interrupt(int irq, void *p)
 {
 	u8		irqstat;
 	u8		rtc_control;
+	unsigned long	flags;
 
-	spin_lock(&rtc_lock);
+	/* We cannot use spin_lock() here, as cmos_interrupt() is also called
+	 * in a non-irq context.
+	 */
+	spin_lock_irqsave(&rtc_lock, flags);
 
 	/* When the HPET interrupt handler calls us, the interrupt
 	 * status is passed as arg1 instead of the irq number.  But
@@ -732,7 +736,7 @@ static irqreturn_t cmos_interrupt(int irq, void *p)
 			hpet_mask_rtc_irq_bit(RTC_AIE);
 		CMOS_READ(RTC_INTR_FLAGS);
 	}
-	spin_unlock(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
 
 	if (is_intr(irqstat)) {
 		rtc_update_irq(p, 1, irqstat);
@@ -1300,9 +1304,7 @@ static void cmos_check_wkalrm(struct device *dev)
 	 * ACK the rtc irq here
 	 */
 	if (t_now >= cmos->alarm_expires && cmos_use_acpi_alarm()) {
-		local_irq_disable();
 		cmos_interrupt(0, (void *)cmos->rtc);
-		local_irq_enable();
 		return;
 	}
 
diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 9c04c4e1a49c..fc079b9dcf71 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1383,6 +1383,11 @@ static int pcf2127_i2c_probe(struct i2c_client *client)
 		variant = &pcf21xx_cfg[type];
 	}
 
+	if (variant->type == PCF2131) {
+		config.read_flag_mask = 0x0;
+		config.write_flag_mask = 0x0;
+	}
+
 	config.max_register = variant->max_register,
 
 	regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,
@@ -1456,7 +1461,7 @@ static int pcf2127_spi_probe(struct spi_device *spi)
 		variant = &pcf21xx_cfg[type];
 	}
 
-	config.max_register = variant->max_register,
+	config.max_register = variant->max_register;
 
 	regmap = devm_regmap_init_spi(spi, &config);
 	if (IS_ERR(regmap)) {
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 85059b83ea6b..1c6b024160da 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -398,7 +398,11 @@ lpfc_bsg_send_mgmt_cmd(struct bsg_job *job)
 	/* in case no data is transferred */
 	bsg_reply->reply_payload_rcv_len = 0;
 
-	if (ndlp->nlp_flag & NLP_ELS_SND_MASK)
+	if (test_bit(NLP_PLOGI_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_PRLI_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_ADISC_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_LOGO_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_RNID_SND, &ndlp->nlp_flag))
 		return -ENODEV;
 
 	/* allocate our bsg tracking structure */
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index d4e46a08f94d..36470bd71617 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -571,7 +571,7 @@ int lpfc_issue_reg_vfi(struct lpfc_vport *);
 int lpfc_issue_unreg_vfi(struct lpfc_vport *);
 int lpfc_selective_reset(struct lpfc_hba *);
 int lpfc_sli4_read_config(struct lpfc_hba *);
-void lpfc_sli4_node_prep(struct lpfc_hba *);
+void lpfc_sli4_node_rpi_restore(struct lpfc_hba *phba);
 int lpfc_sli4_els_sgl_update(struct lpfc_hba *phba);
 int lpfc_sli4_nvmet_sgl_update(struct lpfc_hba *phba);
 int lpfc_io_buf_flush(struct lpfc_hba *phba, struct list_head *sglist);
diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index ce3a1f42713d..30891ad17e2a 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -735,7 +735,7 @@ lpfc_prep_node_fc4type(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
 
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "0238 Process x%06x NameServer Rsp "
-					 "Data: x%x x%x x%x x%lx x%x\n", Did,
+					 "Data: x%lx x%x x%x x%lx x%x\n", Did,
 					 ndlp->nlp_flag, ndlp->nlp_fc4_type,
 					 ndlp->nlp_state, vport->fc_flag,
 					 vport->fc_rscn_id_cnt);
@@ -744,7 +744,7 @@ lpfc_prep_node_fc4type(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
 			 * state of ndlp hit devloss, change state to
 			 * allow rediscovery.
 			 */
-			if (ndlp->nlp_flag & NLP_NPR_2B_DISC &&
+			if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag) &&
 			    ndlp->nlp_state == NLP_STE_UNUSED_NODE) {
 				lpfc_nlp_set_state(vport, ndlp,
 						   NLP_STE_NPR_NODE);
@@ -832,12 +832,10 @@ lpfc_ns_rsp_audit_did(struct lpfc_vport *vport, uint32_t Did, uint8_t fc4_type)
 			if (ndlp->nlp_type != NLP_NVME_INITIATOR ||
 			    ndlp->nlp_state != NLP_STE_UNMAPPED_NODE)
 				continue;
-			spin_lock_irq(&ndlp->lock);
 			if (ndlp->nlp_DID == Did)
-				ndlp->nlp_flag &= ~NLP_NVMET_RECOV;
+				clear_bit(NLP_NVMET_RECOV, &ndlp->nlp_flag);
 			else
-				ndlp->nlp_flag |= NLP_NVMET_RECOV;
-			spin_unlock_irq(&ndlp->lock);
+				set_bit(NLP_NVMET_RECOV, &ndlp->nlp_flag);
 		}
 	}
 }
@@ -894,13 +892,11 @@ lpfc_ns_rsp(struct lpfc_vport *vport, struct lpfc_dmabuf *mp, uint8_t fc4_type,
 	 */
 	if (vport->phba->nvmet_support) {
 		list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
-			if (!(ndlp->nlp_flag & NLP_NVMET_RECOV))
+			if (!test_bit(NLP_NVMET_RECOV, &ndlp->nlp_flag))
 				continue;
 			lpfc_disc_state_machine(vport, ndlp, NULL,
 						NLP_EVT_DEVICE_RECOVERY);
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_NVMET_RECOV;
-			spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_NVMET_RECOV, &ndlp->nlp_flag);
 		}
 	}
 
@@ -1440,7 +1436,7 @@ lpfc_cmpl_ct_cmd_gff_id(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	if (ndlp) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "0242 Process x%x GFF "
-				 "NameServer Rsp Data: x%x x%lx x%x\n",
+				 "NameServer Rsp Data: x%lx x%lx x%x\n",
 				 did, ndlp->nlp_flag, vport->fc_flag,
 				 vport->fc_rscn_id_cnt);
 	} else {
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index a2d2b02b3418..3fd1aa5cc78c 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -870,8 +870,8 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
 				wwn_to_u64(ndlp->nlp_nodename.u.wwn));
 		len += scnprintf(buf+len, size-len, "RPI:x%04x ",
 				 ndlp->nlp_rpi);
-		len +=  scnprintf(buf+len, size-len, "flag:x%08x ",
-			ndlp->nlp_flag);
+		len += scnprintf(buf+len, size-len, "flag:x%08lx ",
+				 ndlp->nlp_flag);
 		if (!ndlp->nlp_type)
 			len += scnprintf(buf+len, size-len, "UNKNOWN_TYPE ");
 		if (ndlp->nlp_type & NLP_FC_NODE)
diff --git a/drivers/scsi/lpfc/lpfc_disc.h b/drivers/scsi/lpfc/lpfc_disc.h
index f5ae8cc15820..af5d5bd75642 100644
--- a/drivers/scsi/lpfc/lpfc_disc.h
+++ b/drivers/scsi/lpfc/lpfc_disc.h
@@ -102,7 +102,7 @@ struct lpfc_nodelist {
 
 	spinlock_t	lock;			/* Node management lock */
 
-	uint32_t         nlp_flag;		/* entry flags */
+	unsigned long    nlp_flag;		/* entry flags */
 	uint32_t         nlp_DID;		/* FC D_ID of entry */
 	uint32_t         nlp_last_elscmd;	/* Last ELS cmd sent */
 	uint16_t         nlp_type;
@@ -182,37 +182,37 @@ struct lpfc_node_rrq {
 #define lpfc_ndlp_check_qdepth(phba, ndlp) \
 	(ndlp->cmd_qdepth < phba->sli4_hba.max_cfg_param.max_xri)
 
-/* Defines for nlp_flag (uint32) */
-#define NLP_IGNR_REG_CMPL  0x00000001 /* Rcvd rscn before we cmpl reg login */
-#define NLP_REG_LOGIN_SEND 0x00000002   /* sent reglogin to adapter */
-#define NLP_RELEASE_RPI    0x00000004   /* Release RPI to free pool */
-#define NLP_SUPPRESS_RSP   0x00000010	/* Remote NPort supports suppress rsp */
-#define NLP_PLOGI_SND      0x00000020	/* sent PLOGI request for this entry */
-#define NLP_PRLI_SND       0x00000040	/* sent PRLI request for this entry */
-#define NLP_ADISC_SND      0x00000080	/* sent ADISC request for this entry */
-#define NLP_LOGO_SND       0x00000100	/* sent LOGO request for this entry */
-#define NLP_RNID_SND       0x00000400	/* sent RNID request for this entry */
-#define NLP_ELS_SND_MASK   0x000007e0	/* sent ELS request for this entry */
-#define NLP_NVMET_RECOV    0x00001000   /* NVMET auditing node for recovery. */
-#define NLP_UNREG_INP      0x00008000	/* UNREG_RPI cmd is in progress */
-#define NLP_DROPPED        0x00010000	/* Init ref count has been dropped */
-#define NLP_DELAY_TMO      0x00020000	/* delay timeout is running for node */
-#define NLP_NPR_2B_DISC    0x00040000	/* node is included in num_disc_nodes */
-#define NLP_RCV_PLOGI      0x00080000	/* Rcv'ed PLOGI from remote system */
-#define NLP_LOGO_ACC       0x00100000	/* Process LOGO after ACC completes */
-#define NLP_TGT_NO_SCSIID  0x00200000	/* good PRLI but no binding for scsid */
-#define NLP_ISSUE_LOGO     0x00400000	/* waiting to issue a LOGO */
-#define NLP_IN_DEV_LOSS    0x00800000	/* devloss in progress */
-#define NLP_ACC_REGLOGIN   0x01000000	/* Issue Reg Login after successful
+/* nlp_flag mask bits */
+enum lpfc_nlp_flag {
+	NLP_IGNR_REG_CMPL  = 0,         /* Rcvd rscn before we cmpl reg login */
+	NLP_REG_LOGIN_SEND = 1,         /* sent reglogin to adapter */
+	NLP_SUPPRESS_RSP   = 4,         /* Remote NPort supports suppress rsp */
+	NLP_PLOGI_SND      = 5,         /* sent PLOGI request for this entry */
+	NLP_PRLI_SND       = 6,         /* sent PRLI request for this entry */
+	NLP_ADISC_SND      = 7,         /* sent ADISC request for this entry */
+	NLP_LOGO_SND       = 8,         /* sent LOGO request for this entry */
+	NLP_RNID_SND       = 10,        /* sent RNID request for this entry */
+	NLP_NVMET_RECOV    = 12,        /* NVMET auditing node for recovery. */
+	NLP_UNREG_INP      = 15,        /* UNREG_RPI cmd is in progress */
+	NLP_DROPPED        = 16,        /* Init ref count has been dropped */
+	NLP_DELAY_TMO      = 17,        /* delay timeout is running for node */
+	NLP_NPR_2B_DISC    = 18,        /* node is included in num_disc_nodes */
+	NLP_RCV_PLOGI      = 19,        /* Rcv'ed PLOGI from remote system */
+	NLP_LOGO_ACC       = 20,        /* Process LOGO after ACC completes */
+	NLP_TGT_NO_SCSIID  = 21,        /* good PRLI but no binding for scsid */
+	NLP_ISSUE_LOGO     = 22,        /* waiting to issue a LOGO */
+	NLP_IN_DEV_LOSS    = 23,        /* devloss in progress */
+	NLP_ACC_REGLOGIN   = 24,        /* Issue Reg Login after successful
 					   ACC */
-#define NLP_NPR_ADISC      0x02000000	/* Issue ADISC when dq'ed from
+	NLP_NPR_ADISC      = 25,        /* Issue ADISC when dq'ed from
 					   NPR list */
-#define NLP_RM_DFLT_RPI    0x04000000	/* need to remove leftover dflt RPI */
-#define NLP_NODEV_REMOVE   0x08000000	/* Defer removal till discovery ends */
-#define NLP_TARGET_REMOVE  0x10000000   /* Target remove in process */
-#define NLP_SC_REQ         0x20000000	/* Target requires authentication */
-#define NLP_FIRSTBURST     0x40000000	/* Target supports FirstBurst */
-#define NLP_RPI_REGISTERED 0x80000000	/* nlp_rpi is valid */
+	NLP_RM_DFLT_RPI    = 26,        /* need to remove leftover dflt RPI */
+	NLP_NODEV_REMOVE   = 27,        /* Defer removal till discovery ends */
+	NLP_TARGET_REMOVE  = 28,        /* Target remove in process */
+	NLP_SC_REQ         = 29,        /* Target requires authentication */
+	NLP_FIRSTBURST     = 30,        /* Target supports FirstBurst */
+	NLP_RPI_REGISTERED = 31         /* nlp_rpi is valid */
+};
 
 /* There are 4 different double linked lists nodelist entries can reside on.
  * The Port Login (PLOGI) list and Address Discovery (ADISC) list are used
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index d737b897ddd8..b5fa5054e952 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -725,11 +725,9 @@ lpfc_cmpl_els_flogi_fabric(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		list_for_each_entry_safe(np, next_np,
 					&vport->fc_nodes, nlp_listp) {
 			if ((np->nlp_state != NLP_STE_NPR_NODE) ||
-				   !(np->nlp_flag & NLP_NPR_ADISC))
+			    !test_bit(NLP_NPR_ADISC, &np->nlp_flag))
 				continue;
-			spin_lock_irq(&np->lock);
-			np->nlp_flag &= ~NLP_NPR_ADISC;
-			spin_unlock_irq(&np->lock);
+			clear_bit(NLP_NPR_ADISC, &np->nlp_flag);
 			lpfc_unreg_rpi(vport, np);
 		}
 		lpfc_cleanup_pending_mbox(vport);
@@ -864,9 +862,7 @@ lpfc_cmpl_els_flogi_nport(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		       sizeof(struct lpfc_name));
 		/* Set state will put ndlp onto node list if not already done */
 		lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 		mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 		if (!mbox)
@@ -1018,7 +1014,7 @@ lpfc_cmpl_els_flogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * registered with the SCSI transport, remove the initial
 		 * reference to trigger node release.
 		 */
-		if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS) &&
+		if (!test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag) &&
 		    !(ndlp->fc4_xpt_flags & SCSI_XPT_REGD))
 			lpfc_nlp_put(ndlp);
 
@@ -1548,7 +1544,7 @@ lpfc_initial_flogi(struct lpfc_vport *vport)
 		 * Otherwise, decrement node reference to trigger release.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
-		    !(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+		    !test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 			lpfc_nlp_put(ndlp);
 		return 0;
 	}
@@ -1597,7 +1593,7 @@ lpfc_initial_fdisc(struct lpfc_vport *vport)
 		 * Otherwise, decrement node reference to trigger release.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
-		    !(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+		    !test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 			lpfc_nlp_put(ndlp);
 		return 0;
 	}
@@ -1675,9 +1671,9 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
 	struct lpfc_nodelist *new_ndlp;
 	struct serv_parm *sp;
 	uint8_t  name[sizeof(struct lpfc_name)];
-	uint32_t keepDID = 0, keep_nlp_flag = 0;
+	uint32_t keepDID = 0;
 	int rc;
-	uint32_t keep_new_nlp_flag = 0;
+	unsigned long keep_nlp_flag = 0, keep_new_nlp_flag = 0;
 	uint16_t keep_nlp_state;
 	u32 keep_nlp_fc4_type = 0;
 	struct lpfc_nvme_rport *keep_nrport = NULL;
@@ -1704,8 +1700,8 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
 	}
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_NODE,
-			 "3178 PLOGI confirm: ndlp x%x x%x x%x: "
-			 "new_ndlp x%x x%x x%x\n",
+			 "3178 PLOGI confirm: ndlp x%x x%lx x%x: "
+			 "new_ndlp x%x x%lx x%x\n",
 			 ndlp->nlp_DID, ndlp->nlp_flag,  ndlp->nlp_fc4_type,
 			 (new_ndlp ? new_ndlp->nlp_DID : 0),
 			 (new_ndlp ? new_ndlp->nlp_flag : 0),
@@ -1769,48 +1765,48 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
 	new_ndlp->nlp_flag = ndlp->nlp_flag;
 
 	/* if new_ndlp had NLP_UNREG_INP set, keep it */
-	if (keep_new_nlp_flag & NLP_UNREG_INP)
-		new_ndlp->nlp_flag |= NLP_UNREG_INP;
+	if (test_bit(NLP_UNREG_INP, &keep_new_nlp_flag))
+		set_bit(NLP_UNREG_INP, &new_ndlp->nlp_flag);
 	else
-		new_ndlp->nlp_flag &= ~NLP_UNREG_INP;
+		clear_bit(NLP_UNREG_INP, &new_ndlp->nlp_flag);
 
 	/* if new_ndlp had NLP_RPI_REGISTERED set, keep it */
-	if (keep_new_nlp_flag & NLP_RPI_REGISTERED)
-		new_ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	if (test_bit(NLP_RPI_REGISTERED, &keep_new_nlp_flag))
+		set_bit(NLP_RPI_REGISTERED, &new_ndlp->nlp_flag);
 	else
-		new_ndlp->nlp_flag &= ~NLP_RPI_REGISTERED;
+		clear_bit(NLP_RPI_REGISTERED, &new_ndlp->nlp_flag);
 
 	/*
 	 * Retain the DROPPED flag. This will take care of the init
 	 * refcount when affecting the state change
 	 */
-	if (keep_new_nlp_flag & NLP_DROPPED)
-		new_ndlp->nlp_flag |= NLP_DROPPED;
+	if (test_bit(NLP_DROPPED, &keep_new_nlp_flag))
+		set_bit(NLP_DROPPED, &new_ndlp->nlp_flag);
 	else
-		new_ndlp->nlp_flag &= ~NLP_DROPPED;
+		clear_bit(NLP_DROPPED, &new_ndlp->nlp_flag);
 
 	ndlp->nlp_flag = keep_new_nlp_flag;
 
 	/* if ndlp had NLP_UNREG_INP set, keep it */
-	if (keep_nlp_flag & NLP_UNREG_INP)
-		ndlp->nlp_flag |= NLP_UNREG_INP;
+	if (test_bit(NLP_UNREG_INP, &keep_nlp_flag))
+		set_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 	else
-		ndlp->nlp_flag &= ~NLP_UNREG_INP;
+		clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 
 	/* if ndlp had NLP_RPI_REGISTERED set, keep it */
-	if (keep_nlp_flag & NLP_RPI_REGISTERED)
-		ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	if (test_bit(NLP_RPI_REGISTERED, &keep_nlp_flag))
+		set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 	else
-		ndlp->nlp_flag &= ~NLP_RPI_REGISTERED;
+		clear_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 
 	/*
 	 * Retain the DROPPED flag. This will take care of the init
 	 * refcount when affecting the state change
 	 */
-	if (keep_nlp_flag & NLP_DROPPED)
-		ndlp->nlp_flag |= NLP_DROPPED;
+	if (test_bit(NLP_DROPPED, &keep_nlp_flag))
+		set_bit(NLP_DROPPED, &ndlp->nlp_flag);
 	else
-		ndlp->nlp_flag &= ~NLP_DROPPED;
+		clear_bit(NLP_DROPPED, &ndlp->nlp_flag);
 
 	spin_unlock_irq(&new_ndlp->lock);
 	spin_unlock_irq(&ndlp->lock);
@@ -1888,7 +1884,7 @@ lpfc_plogi_confirm_nport(struct lpfc_hba *phba, uint32_t *prsp,
 			     phba->active_rrq_pool);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS | LOG_NODE,
-			 "3173 PLOGI confirm exit: new_ndlp x%x x%x x%x\n",
+			 "3173 PLOGI confirm exit: new_ndlp x%x x%lx x%x\n",
 			 new_ndlp->nlp_DID, new_ndlp->nlp_flag,
 			 new_ndlp->nlp_fc4_type);
 
@@ -2009,7 +2005,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	IOCB_t *irsp;
 	struct lpfc_nodelist *ndlp, *free_ndlp;
 	struct lpfc_dmabuf *prsp;
-	int disc;
+	bool disc;
 	struct serv_parm *sp = NULL;
 	u32 ulp_status, ulp_word4, did, iotag;
 	bool release_node = false;
@@ -2044,10 +2040,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* Since ndlp can be freed in the disc state machine, note if this node
 	 * is being used during discovery.
 	 */
-	spin_lock_irq(&ndlp->lock);
-	disc = (ndlp->nlp_flag & NLP_NPR_2B_DISC);
-	ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-	spin_unlock_irq(&ndlp->lock);
+	disc = test_and_clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 	/* PLOGI completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
@@ -2060,9 +2053,7 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* Check to see if link went down during discovery */
 	if (lpfc_els_chk_latt(vport)) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		goto out;
 	}
 
@@ -2070,11 +2061,8 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* Check for retry */
 		if (lpfc_els_retry(phba, cmdiocb, rspiocb)) {
 			/* ELS command is being retried */
-			if (disc) {
-				spin_lock_irq(&ndlp->lock);
-				ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-				spin_unlock_irq(&ndlp->lock);
-			}
+			if (disc)
+				set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 			goto out;
 		}
 		/* Warn PLOGI status Don't print the vport to vport rjts */
@@ -2097,7 +2085,8 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * with the reglogin process.
 		 */
 		spin_lock_irq(&ndlp->lock);
-		if ((ndlp->nlp_flag & (NLP_ACC_REGLOGIN | NLP_RCV_PLOGI)) &&
+		if ((test_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag) ||
+		     test_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag)) &&
 		    ndlp->nlp_state == NLP_STE_REG_LOGIN_ISSUE) {
 			spin_unlock_irq(&ndlp->lock);
 			goto out;
@@ -2108,8 +2097,8 @@ lpfc_cmpl_els_plogi(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 * start the device remove process.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+			if (!test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 				release_node = true;
 		}
 		spin_unlock_irq(&ndlp->lock);
@@ -2212,12 +2201,13 @@ lpfc_issue_els_plogi(struct lpfc_vport *vport, uint32_t did, uint8_t retry)
 	 * outstanding UNREG_RPI mbox command completes, unless we
 	 * are going offline. This logic does not apply for Fabric DIDs
 	 */
-	if ((ndlp->nlp_flag & (NLP_IGNR_REG_CMPL | NLP_UNREG_INP)) &&
+	if ((test_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag) ||
+	     test_bit(NLP_UNREG_INP, &ndlp->nlp_flag)) &&
 	    ((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
 	    !test_bit(FC_OFFLINE_MODE, &vport->fc_flag)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "4110 Issue PLOGI x%x deferred "
-				 "on NPort x%x rpi x%x flg x%x Data:"
+				 "on NPort x%x rpi x%x flg x%lx Data:"
 				 " x%px\n",
 				 ndlp->nlp_defer_did, ndlp->nlp_DID,
 				 ndlp->nlp_rpi, ndlp->nlp_flag, ndlp);
@@ -2335,10 +2325,10 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	ulp_status = get_job_ulpstatus(phba, rspiocb);
 	ulp_word4 = get_job_word4(phba, rspiocb);
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_PRLI_SND;
+	clear_bit(NLP_PRLI_SND, &ndlp->nlp_flag);
 
 	/* Driver supports multiple FC4 types.  Counters matter. */
+	spin_lock_irq(&ndlp->lock);
 	vport->fc_prli_sent--;
 	ndlp->fc4_prli_sent--;
 	spin_unlock_irq(&ndlp->lock);
@@ -2379,7 +2369,7 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* Warn PRLI status */
 		lpfc_printf_vlog(vport, mode, LOG_ELS,
 				 "2754 PRLI DID:%06X Status:x%x/x%x, "
-				 "data: x%x x%x x%x\n",
+				 "data: x%x x%x x%lx\n",
 				 ndlp->nlp_DID, ulp_status,
 				 ulp_word4, ndlp->nlp_state,
 				 ndlp->fc4_prli_sent, ndlp->nlp_flag);
@@ -2396,10 +2386,10 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if ((ndlp->nlp_state >= NLP_STE_PLOGI_ISSUE &&
 		     ndlp->nlp_state <= NLP_STE_REG_LOGIN_ISSUE) ||
 		    (ndlp->nlp_state == NLP_STE_NPR_NODE &&
-		     ndlp->nlp_flag & NLP_DELAY_TMO)) {
-			lpfc_printf_vlog(vport, KERN_WARNING, LOG_NODE,
+		     test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag))) {
+			lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
 					 "2784 PRLI cmpl: Allow Node recovery "
-					 "DID x%06x nstate x%x nflag x%x\n",
+					 "DID x%06x nstate x%x nflag x%lx\n",
 					 ndlp->nlp_DID, ndlp->nlp_state,
 					 ndlp->nlp_flag);
 			goto out;
@@ -2420,8 +2410,8 @@ lpfc_cmpl_els_prli(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		spin_lock_irq(&ndlp->lock);
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD)) &&
 		    !ndlp->fc4_prli_sent) {
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+			if (!test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 				release_node = true;
 		}
 		spin_unlock_irq(&ndlp->lock);
@@ -2496,7 +2486,8 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	ndlp->nlp_type &= ~(NLP_FCP_TARGET | NLP_FCP_INITIATOR);
 	ndlp->nlp_type &= ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
 	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-	ndlp->nlp_flag &= ~(NLP_FIRSTBURST | NLP_NPR_2B_DISC);
+	clear_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	ndlp->nvme_fb_size = 0;
 
  send_next_prli:
@@ -2627,8 +2618,8 @@ lpfc_issue_els_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * the ndlp is used to track outstanding PRLIs for different
 	 * FC4 types.
 	 */
+	set_bit(NLP_PRLI_SND, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_PRLI_SND;
 	vport->fc_prli_sent++;
 	ndlp->fc4_prli_sent++;
 	spin_unlock_irq(&ndlp->lock);
@@ -2789,7 +2780,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_vport *vport = cmdiocb->vport;
 	IOCB_t *irsp;
 	struct lpfc_nodelist *ndlp;
-	int  disc;
+	bool  disc;
 	u32 ulp_status, ulp_word4, tmo, iotag;
 	bool release_node = false;
 
@@ -2818,10 +2809,8 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* Since ndlp can be freed in the disc state machine, note if this node
 	 * is being used during discovery.
 	 */
-	spin_lock_irq(&ndlp->lock);
-	disc = (ndlp->nlp_flag & NLP_NPR_2B_DISC);
-	ndlp->nlp_flag &= ~(NLP_ADISC_SND | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	disc = test_and_clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+	clear_bit(NLP_ADISC_SND, &ndlp->nlp_flag);
 	/* ADISC completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0104 ADISC completes to NPort x%x "
@@ -2832,9 +2821,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 
 	/* Check to see if link went down during discovery */
 	if (lpfc_els_chk_latt(vport)) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		goto out;
 	}
 
@@ -2843,9 +2830,7 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		if (lpfc_els_retry(phba, cmdiocb, rspiocb)) {
 			/* ELS command is being retried */
 			if (disc) {
-				spin_lock_irq(&ndlp->lock);
-				ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-				spin_unlock_irq(&ndlp->lock);
+				set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 				lpfc_set_disctmo(vport);
 			}
 			goto out;
@@ -2864,8 +2849,8 @@ lpfc_cmpl_els_adisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		 */
 		spin_lock_irq(&ndlp->lock);
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			if (!(ndlp->nlp_flag & NLP_IN_DEV_LOSS))
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+			if (!test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag))
 				release_node = true;
 		}
 		spin_unlock_irq(&ndlp->lock);
@@ -2938,9 +2923,7 @@ lpfc_issue_els_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	phba->fc_stat.elsXmitADISC++;
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_adisc;
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_ADISC_SND;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_ADISC_SND, &ndlp->nlp_flag);
 	elsiocb->ndlp = lpfc_nlp_get(ndlp);
 	if (!elsiocb->ndlp) {
 		lpfc_els_free_iocb(phba, elsiocb);
@@ -2961,9 +2944,7 @@ lpfc_issue_els_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	return 0;
 
 err:
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_ADISC_SND;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_ADISC_SND, &ndlp->nlp_flag);
 	return 1;
 }
 
@@ -2985,7 +2966,6 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	struct lpfc_nodelist *ndlp = cmdiocb->ndlp;
 	struct lpfc_vport *vport = ndlp->vport;
 	IOCB_t *irsp;
-	unsigned long flags;
 	uint32_t skip_recovery = 0;
 	int wake_up_waiter = 0;
 	u32 ulp_status;
@@ -3007,8 +2987,8 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		iotag = irsp->ulpIoTag;
 	}
 
+	clear_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_LOGO_SND;
 	if (ndlp->save_flags & NLP_WAIT_FOR_LOGO) {
 		wake_up_waiter = 1;
 		ndlp->save_flags &= ~NLP_WAIT_FOR_LOGO;
@@ -3023,7 +3003,7 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* LOGO completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0105 LOGO completes to NPort x%x "
-			 "IoTag x%x refcnt %d nflags x%x xflags x%x "
+			 "IoTag x%x refcnt %d nflags x%lx xflags x%x "
 			 "Data: x%x x%x x%x x%x\n",
 			 ndlp->nlp_DID, iotag,
 			 kref_read(&ndlp->kref), ndlp->nlp_flag,
@@ -3061,12 +3041,8 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* The driver sets this flag for an NPIV instance that doesn't want to
 	 * log into the remote port.
 	 */
-	if (ndlp->nlp_flag & NLP_TARGET_REMOVE) {
-		spin_lock_irq(&ndlp->lock);
-		if (phba->sli_rev == LPFC_SLI_REV4)
-			ndlp->nlp_flag |= NLP_RELEASE_RPI;
-		ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_TARGET_REMOVE, &ndlp->nlp_flag)) {
+		clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 					NLP_EVT_DEVICE_RM);
 		goto out_rsrc_free;
@@ -3089,9 +3065,7 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	if (ndlp->nlp_type & (NLP_FCP_TARGET | NLP_NVME_TARGET) &&
 	    skip_recovery == 0) {
 		lpfc_cancel_retry_delay_tmo(vport, ndlp);
-		spin_lock_irqsave(&ndlp->lock, flags);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irqrestore(&ndlp->lock, flags);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "3187 LOGO completes to NPort x%x: Start "
@@ -3113,9 +3087,7 @@ lpfc_cmpl_els_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	 * register with the transport.
 	 */
 	if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		lpfc_disc_state_machine(vport, ndlp, cmdiocb,
 					NLP_EVT_DEVICE_RM);
 	}
@@ -3156,12 +3128,8 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	uint16_t cmdsize;
 	int rc;
 
-	spin_lock_irq(&ndlp->lock);
-	if (ndlp->nlp_flag & NLP_LOGO_SND) {
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_LOGO_SND, &ndlp->nlp_flag))
 		return 0;
-	}
-	spin_unlock_irq(&ndlp->lock);
 
 	cmdsize = (2 * sizeof(uint32_t)) + sizeof(struct lpfc_name);
 	elsiocb = lpfc_prep_els_iocb(vport, 1, cmdsize, retry, ndlp,
@@ -3180,10 +3148,8 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	phba->fc_stat.elsXmitLOGO++;
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_logo;
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_SND;
-	ndlp->nlp_flag &= ~NLP_ISSUE_LOGO;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
+	clear_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
 	elsiocb->ndlp = lpfc_nlp_get(ndlp);
 	if (!elsiocb->ndlp) {
 		lpfc_els_free_iocb(phba, elsiocb);
@@ -3208,9 +3174,7 @@ lpfc_issue_els_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	return 0;
 
 err:
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_LOGO_SND;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 	return 1;
 }
 
@@ -3286,13 +3250,13 @@ lpfc_cmpl_els_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 static int
 lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 {
-	int rc = 0;
+	int rc;
 	struct lpfc_hba *phba = vport->phba;
 	struct lpfc_nodelist *ns_ndlp;
 	LPFC_MBOXQ_t *mbox;
 
-	if (fc_ndlp->nlp_flag & NLP_RPI_REGISTERED)
-		return rc;
+	if (test_bit(NLP_RPI_REGISTERED, &fc_ndlp->nlp_flag))
+		return 0;
 
 	ns_ndlp = lpfc_findnode_did(vport, NameServer_DID);
 	if (!ns_ndlp)
@@ -3309,7 +3273,7 @@ lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 	if (!mbox) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
 				 "0936 %s: no memory for reg_login "
-				 "Data: x%x x%x x%x x%x\n", __func__,
+				 "Data: x%x x%x x%lx x%x\n", __func__,
 				 fc_ndlp->nlp_DID, fc_ndlp->nlp_state,
 				 fc_ndlp->nlp_flag, fc_ndlp->nlp_rpi);
 		return -ENOMEM;
@@ -3321,7 +3285,7 @@ lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 		goto out;
 	}
 
-	fc_ndlp->nlp_flag |= NLP_REG_LOGIN_SEND;
+	set_bit(NLP_REG_LOGIN_SEND, &fc_ndlp->nlp_flag);
 	mbox->mbox_cmpl = lpfc_mbx_cmpl_fc_reg_login;
 	mbox->ctx_ndlp = lpfc_nlp_get(fc_ndlp);
 	if (!mbox->ctx_ndlp) {
@@ -3345,7 +3309,7 @@ lpfc_reg_fab_ctrl_node(struct lpfc_vport *vport, struct lpfc_nodelist *fc_ndlp)
 	lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 	lpfc_printf_vlog(vport, KERN_ERR, LOG_NODE,
 			 "0938 %s: failed to format reg_login "
-			 "Data: x%x x%x x%x x%x\n", __func__,
+			 "Data: x%x x%x x%lx x%x\n", __func__,
 			 fc_ndlp->nlp_DID, fc_ndlp->nlp_state,
 			 fc_ndlp->nlp_flag, fc_ndlp->nlp_rpi);
 	return rc;
@@ -4384,11 +4348,8 @@ lpfc_cancel_retry_delay_tmo(struct lpfc_vport *vport, struct lpfc_nodelist *nlp)
 {
 	struct lpfc_work_evt *evtp;
 
-	if (!(nlp->nlp_flag & NLP_DELAY_TMO))
+	if (!test_and_clear_bit(NLP_DELAY_TMO, &nlp->nlp_flag))
 		return;
-	spin_lock_irq(&nlp->lock);
-	nlp->nlp_flag &= ~NLP_DELAY_TMO;
-	spin_unlock_irq(&nlp->lock);
 	del_timer_sync(&nlp->nlp_delayfunc);
 	nlp->nlp_last_elscmd = 0;
 	if (!list_empty(&nlp->els_retry_evt.evt_listp)) {
@@ -4397,10 +4358,7 @@ lpfc_cancel_retry_delay_tmo(struct lpfc_vport *vport, struct lpfc_nodelist *nlp)
 		evtp = &nlp->els_retry_evt;
 		lpfc_nlp_put((struct lpfc_nodelist *)evtp->evt_arg1);
 	}
-	if (nlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&nlp->lock);
-		nlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-		spin_unlock_irq(&nlp->lock);
+	if (test_and_clear_bit(NLP_NPR_2B_DISC, &nlp->nlp_flag)) {
 		if (vport->num_disc_nodes) {
 			if (vport->port_state < LPFC_VPORT_READY) {
 				/* Check if there are more ADISCs to be sent */
@@ -4480,14 +4438,11 @@ lpfc_els_retry_delay_handler(struct lpfc_nodelist *ndlp)
 	spin_lock_irq(&ndlp->lock);
 	cmd = ndlp->nlp_last_elscmd;
 	ndlp->nlp_last_elscmd = 0;
+	spin_unlock_irq(&ndlp->lock);
 
-	if (!(ndlp->nlp_flag & NLP_DELAY_TMO)) {
-		spin_unlock_irq(&ndlp->lock);
+	if (!test_and_clear_bit(NLP_DELAY_TMO, &ndlp->nlp_flag))
 		return;
-	}
 
-	ndlp->nlp_flag &= ~NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
 	/*
 	 * If a discovery event readded nlp_delayfunc after timer
 	 * firing and before processing the timer, cancel the
@@ -5010,9 +4965,7 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			/* delay is specified in milliseconds */
 			mod_timer(&ndlp->nlp_delayfunc,
 				jiffies + msecs_to_jiffies(delay));
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_DELAY_TMO;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 
 			ndlp->nlp_prev_state = ndlp->nlp_state;
 			if ((cmd == ELS_CMD_PRLI) ||
@@ -5072,7 +5025,7 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "0108 No retry ELS command x%x to remote "
 				 "NPORT x%x Retried:%d Error:x%x/%x "
-				 "IoTag x%x nflags x%x\n",
+				 "IoTag x%x nflags x%lx\n",
 				 cmd, did, cmdiocb->retry, ulp_status,
 				 ulp_word4, cmdiocb->iotag,
 				 (ndlp ? ndlp->nlp_flag : 0));
@@ -5239,7 +5192,7 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* ACC to LOGO completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0109 ACC to LOGO completes to NPort x%x refcnt %d "
-			 "last els x%x Data: x%x x%x x%x\n",
+			 "last els x%x Data: x%lx x%x x%x\n",
 			 ndlp->nlp_DID, kref_read(&ndlp->kref),
 			 ndlp->nlp_last_elscmd, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
@@ -5254,16 +5207,14 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		goto out;
 
 	if (ndlp->nlp_state == NLP_STE_NPR_NODE) {
-		if (ndlp->nlp_flag & NLP_RPI_REGISTERED)
+		if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag))
 			lpfc_unreg_rpi(vport, ndlp);
 
 		/* If came from PRLO, then PRLO_ACC is done.
 		 * Start rediscovery now.
 		 */
 		if (ndlp->nlp_last_elscmd == ELS_CMD_PRLO) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 			ndlp->nlp_prev_state = ndlp->nlp_state;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -5300,7 +5251,7 @@ lpfc_mbx_cmpl_dflt_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	if (ndlp) {
 		lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-				 "0006 rpi x%x DID:%x flg:%x %d x%px "
+				 "0006 rpi x%x DID:%x flg:%lx %d x%px "
 				 "mbx_cmd x%x mbx_flag x%x x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 				 kref_read(&ndlp->kref), ndlp, mbx_cmd,
@@ -5311,11 +5262,9 @@ lpfc_mbx_cmpl_dflt_rpi(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		 * first on an UNREG_LOGIN and then release the final
 		 * references.
 		 */
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+		clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 		if (mbx_cmd == MBX_UNREG_LOGIN)
-			ndlp->nlp_flag &= ~NLP_UNREG_INP;
-		spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 		lpfc_nlp_put(ndlp);
 		lpfc_drop_node(ndlp->vport, ndlp);
 	}
@@ -5381,23 +5330,23 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* ELS response tag <ulpIoTag> completes */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0110 ELS response tag x%x completes "
-			 "Data: x%x x%x x%x x%x x%x x%x x%x x%x %p %p\n",
+			 "Data: x%x x%x x%x x%x x%lx x%x x%x x%x %p %p\n",
 			 iotag, ulp_status, ulp_word4, tmo,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi, kref_read(&ndlp->kref), mbox, ndlp);
 	if (mbox) {
-		if (ulp_status == 0
-		    && (ndlp->nlp_flag & NLP_ACC_REGLOGIN)) {
+		if (ulp_status == 0 &&
+		    test_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag)) {
 			if (!lpfc_unreg_rpi(vport, ndlp) &&
 			    !test_bit(FC_PT2PT, &vport->fc_flag)) {
-				if (ndlp->nlp_state ==  NLP_STE_PLOGI_ISSUE ||
+				if (ndlp->nlp_state == NLP_STE_PLOGI_ISSUE ||
 				    ndlp->nlp_state ==
 				     NLP_STE_REG_LOGIN_ISSUE) {
 					lpfc_printf_vlog(vport, KERN_INFO,
 							 LOG_DISCOVERY,
 							 "0314 PLOGI recov "
 							 "DID x%x "
-							 "Data: x%x x%x x%x\n",
+							 "Data: x%x x%x x%lx\n",
 							 ndlp->nlp_DID,
 							 ndlp->nlp_state,
 							 ndlp->nlp_rpi,
@@ -5414,18 +5363,17 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 				goto out_free_mbox;
 
 			mbox->vport = vport;
-			if (ndlp->nlp_flag & NLP_RM_DFLT_RPI) {
+			if (test_bit(NLP_RM_DFLT_RPI, &ndlp->nlp_flag)) {
 				mbox->mbox_flag |= LPFC_MBX_IMED_UNREG;
 				mbox->mbox_cmpl = lpfc_mbx_cmpl_dflt_rpi;
-			}
-			else {
+			} else {
 				mbox->mbox_cmpl = lpfc_mbx_cmpl_reg_login;
 				ndlp->nlp_prev_state = ndlp->nlp_state;
 				lpfc_nlp_set_state(vport, ndlp,
 					   NLP_STE_REG_LOGIN_ISSUE);
 			}
 
-			ndlp->nlp_flag |= NLP_REG_LOGIN_SEND;
+			set_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 			if (lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT)
 			    != MBX_NOT_FINISHED)
 				goto out;
@@ -5434,12 +5382,12 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 			 * set for this failed mailbox command.
 			 */
 			lpfc_nlp_put(ndlp);
-			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+			clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 
 			/* ELS rsp: Cannot issue reg_login for <NPortid> */
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				"0138 ELS rsp: Cannot issue reg_login for x%x "
-				"Data: x%x x%x x%x\n",
+				"Data: x%lx x%x x%x\n",
 				ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 				ndlp->nlp_rpi);
 		}
@@ -5448,32 +5396,20 @@ lpfc_cmpl_els_rsp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	}
 out:
 	if (ndlp && shost) {
-		spin_lock_irq(&ndlp->lock);
 		if (mbox)
-			ndlp->nlp_flag &= ~NLP_ACC_REGLOGIN;
-		ndlp->nlp_flag &= ~NLP_RM_DFLT_RPI;
-		spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag);
+		clear_bit(NLP_RM_DFLT_RPI, &ndlp->nlp_flag);
 	}
 
 	/* An SLI4 NPIV instance wants to drop the node at this point under
-	 * these conditions and release the RPI.
+	 * these conditions because it doesn't need the login.
 	 */
 	if (phba->sli_rev == LPFC_SLI_REV4 &&
 	    vport && vport->port_type == LPFC_NPIV_PORT &&
 	    !(ndlp->fc4_xpt_flags & SCSI_XPT_REGD)) {
-		if (ndlp->nlp_flag & NLP_RELEASE_RPI) {
-			if (ndlp->nlp_state != NLP_STE_PLOGI_ISSUE &&
-			    ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE) {
-				lpfc_sli4_free_rpi(phba, ndlp->nlp_rpi);
-				spin_lock_irq(&ndlp->lock);
-				ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
-				ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
-				spin_unlock_irq(&ndlp->lock);
-			}
-			lpfc_drop_node(vport, ndlp);
-		} else if (ndlp->nlp_state != NLP_STE_PLOGI_ISSUE &&
-			   ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE &&
-			   ndlp->nlp_state != NLP_STE_PRLI_ISSUE) {
+		if (ndlp->nlp_state != NLP_STE_PLOGI_ISSUE &&
+		    ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE &&
+		    ndlp->nlp_state != NLP_STE_PRLI_ISSUE) {
 			/* Drop ndlp if there is no planned or outstanding
 			 * issued PRLI.
 			 *
@@ -5540,9 +5476,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 		elsiocb = lpfc_prep_els_iocb(vport, 0, cmdsize, oldiocb->retry,
 					     ndlp, ndlp->nlp_DID, ELS_CMD_ACC);
 		if (!elsiocb) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_LOGO_ACC;
-			spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 			return 1;
 		}
 
@@ -5570,7 +5504,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 		pcmd += sizeof(uint32_t);
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-			"Issue ACC:       did:x%x flg:x%x",
+			"Issue ACC:       did:x%x flg:x%lx",
 			ndlp->nlp_DID, ndlp->nlp_flag, 0);
 		break;
 	case ELS_CMD_FLOGI:
@@ -5649,7 +5583,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 		}
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-			"Issue ACC FLOGI/PLOGI: did:x%x flg:x%x",
+			"Issue ACC FLOGI/PLOGI: did:x%x flg:x%lx",
 			ndlp->nlp_DID, ndlp->nlp_flag, 0);
 		break;
 	case ELS_CMD_PRLO:
@@ -5687,7 +5621,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 		els_pkt_ptr->un.prlo.acceptRspCode = PRLO_REQ_EXECUTED;
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-			"Issue ACC PRLO:  did:x%x flg:x%x",
+			"Issue ACC PRLO:  did:x%x flg:x%lx",
 			ndlp->nlp_DID, ndlp->nlp_flag, 0);
 		break;
 	case ELS_CMD_RDF:
@@ -5732,12 +5666,10 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 	default:
 		return 1;
 	}
-	if (ndlp->nlp_flag & NLP_LOGO_ACC) {
-		spin_lock_irq(&ndlp->lock);
-		if (!(ndlp->nlp_flag & NLP_RPI_REGISTERED ||
-			ndlp->nlp_flag & NLP_REG_LOGIN_SEND))
-			ndlp->nlp_flag &= ~NLP_LOGO_ACC;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_LOGO_ACC, &ndlp->nlp_flag)) {
+		if (!test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag) &&
+		    !test_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag))
+			clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 		elsiocb->cmd_cmpl = lpfc_cmpl_els_logo_acc;
 	} else {
 		elsiocb->cmd_cmpl = lpfc_cmpl_els_rsp;
@@ -5760,7 +5692,7 @@ lpfc_els_rsp_acc(struct lpfc_vport *vport, uint32_t flag,
 	/* Xmit ELS ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0128 Xmit ELS ACC response Status: x%x, IoTag: x%x, "
-			 "XRI: x%x, DID: x%x, nlp_flag: x%x nlp_state: x%x "
+			 "XRI: x%x, DID: x%x, nlp_flag: x%lx nlp_state: x%x "
 			 "RPI: x%x, fc_flag x%lx refcnt %d\n",
 			 rc, elsiocb->iotag, elsiocb->sli4_xritag,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
@@ -5835,13 +5767,13 @@ lpfc_els_rsp_reject(struct lpfc_vport *vport, uint32_t rejectError,
 	/* Xmit ELS RJT <err> response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0129 Xmit ELS RJT x%x response tag x%x "
-			 "xri x%x, did x%x, nlp_flag x%x, nlp_state x%x, "
+			 "xri x%x, did x%x, nlp_flag x%lx, nlp_state x%x, "
 			 "rpi x%x\n",
 			 rejectError, elsiocb->iotag,
 			 get_job_ulpcontext(phba, elsiocb), ndlp->nlp_DID,
 			 ndlp->nlp_flag, ndlp->nlp_state, ndlp->nlp_rpi);
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		"Issue LS_RJT:    did:x%x flg:x%x err:x%x",
+		"Issue LS_RJT:    did:x%x flg:x%lx err:x%x",
 		ndlp->nlp_DID, ndlp->nlp_flag, rejectError);
 
 	phba->fc_stat.elsXmitLSRJT++;
@@ -5852,18 +5784,6 @@ lpfc_els_rsp_reject(struct lpfc_vport *vport, uint32_t rejectError,
 		return 1;
 	}
 
-	/* The NPIV instance is rejecting this unsolicited ELS. Make sure the
-	 * node's assigned RPI gets released provided this node is not already
-	 * registered with the transport.
-	 */
-	if (phba->sli_rev == LPFC_SLI_REV4 &&
-	    vport->port_type == LPFC_NPIV_PORT &&
-	    !(ndlp->fc4_xpt_flags & SCSI_XPT_REGD)) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_RELEASE_RPI;
-		spin_unlock_irq(&ndlp->lock);
-	}
-
 	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, elsiocb, 0);
 	if (rc == IOCB_ERROR) {
 		lpfc_els_free_iocb(phba, elsiocb);
@@ -5944,7 +5864,7 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		lpfc_format_edc_lft_desc(phba, tlv);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-			      "Issue EDC ACC:      did:x%x flg:x%x refcnt %d",
+			      "Issue EDC ACC:      did:x%x flg:x%lx refcnt %d",
 			      ndlp->nlp_DID, ndlp->nlp_flag,
 			      kref_read(&ndlp->kref));
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_rsp;
@@ -5966,7 +5886,7 @@ lpfc_issue_els_edc_rsp(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	/* Xmit ELS ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0152 Xmit EDC ACC response Status: x%x, IoTag: x%x, "
-			 "XRI: x%x, DID: x%x, nlp_flag: x%x nlp_state: x%x "
+			 "XRI: x%x, DID: x%x, nlp_flag: x%lx nlp_state: x%x "
 			 "RPI: x%x, fc_flag x%lx\n",
 			 rc, elsiocb->iotag, elsiocb->sli4_xritag,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
@@ -6035,7 +5955,7 @@ lpfc_els_rsp_adisc_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 	/* Xmit ADISC ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0130 Xmit ADISC ACC response iotag x%x xri: "
-			 "x%x, did x%x, nlp_flag x%x, nlp_state x%x rpi x%x\n",
+			 "x%x, did x%x, nlp_flag x%lx, nlp_state x%x rpi x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
@@ -6051,7 +5971,7 @@ lpfc_els_rsp_adisc_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 	ap->DID = be32_to_cpu(vport->fc_myDID);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		      "Issue ACC ADISC: did:x%x flg:x%x refcnt %d",
+		      "Issue ACC ADISC: did:x%x flg:x%lx refcnt %d",
 		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
@@ -6157,7 +6077,7 @@ lpfc_els_rsp_prli_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 	/* Xmit PRLI ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0131 Xmit PRLI ACC response tag x%x xri x%x, "
-			 "did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x\n",
+			 "did x%x, nlp_flag x%lx, nlp_state x%x, rpi x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
@@ -6228,7 +6148,7 @@ lpfc_els_rsp_prli_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
 				 "6015 NVME issue PRLI ACC word1 x%08x "
-				 "word4 x%08x word5 x%08x flag x%x, "
+				 "word4 x%08x word5 x%08x flag x%lx, "
 				 "fcp_info x%x nlp_type x%x\n",
 				 npr_nvme->word1, npr_nvme->word4,
 				 npr_nvme->word5, ndlp->nlp_flag,
@@ -6243,7 +6163,7 @@ lpfc_els_rsp_prli_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 				 ndlp->nlp_DID);
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		      "Issue ACC PRLI:  did:x%x flg:x%x",
+		      "Issue ACC PRLI:  did:x%x flg:x%lx",
 		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
@@ -6357,7 +6277,7 @@ lpfc_els_rsp_rnid_acc(struct lpfc_vport *vport, uint8_t format,
 	}
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		      "Issue ACC RNID:  did:x%x flg:x%x refcnt %d",
+		      "Issue ACC RNID:  did:x%x flg:x%lx refcnt %d",
 		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
@@ -6414,7 +6334,7 @@ lpfc_els_clear_rrq(struct lpfc_vport *vport,
 			get_job_ulpcontext(phba, iocb));
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		"Clear RRQ:  did:x%x flg:x%x exchg:x%.08x",
+		"Clear RRQ:  did:x%x flg:x%lx exchg:x%.08x",
 		ndlp->nlp_DID, ndlp->nlp_flag, rrq->rrq_exchg);
 	if (vport->fc_myDID == be32_to_cpu(bf_get(rrq_did, rrq)))
 		xri = bf_get(rrq_oxid, rrq);
@@ -6491,7 +6411,7 @@ lpfc_els_rsp_echo_acc(struct lpfc_vport *vport, uint8_t *data,
 	memcpy(pcmd, data, cmdsize - sizeof(uint32_t));
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_RSP,
-		      "Issue ACC ECHO:  did:x%x flg:x%x refcnt %d",
+		      "Issue ACC ECHO:  did:x%x flg:x%lx refcnt %d",
 		      ndlp->nlp_DID, ndlp->nlp_flag, kref_read(&ndlp->kref));
 
 	phba->fc_stat.elsXmitACC++;
@@ -6541,14 +6461,12 @@ lpfc_els_disc_adisc(struct lpfc_vport *vport)
 	list_for_each_entry_safe(ndlp, next_ndlp, &vport->fc_nodes, nlp_listp) {
 
 		if (ndlp->nlp_state != NLP_STE_NPR_NODE ||
-		    !(ndlp->nlp_flag & NLP_NPR_ADISC))
+		    !test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag))
 			continue;
 
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 
-		if (!(ndlp->nlp_flag & NLP_NPR_2B_DISC)) {
+		if (!test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
 			/* This node was marked for ADISC but was not picked
 			 * for discovery. This is possible if the node was
 			 * missing in gidft response.
@@ -6606,9 +6524,9 @@ lpfc_els_disc_plogi(struct lpfc_vport *vport)
 	/* go thru NPR nodes and issue any remaining ELS PLOGIs */
 	list_for_each_entry_safe(ndlp, next_ndlp, &vport->fc_nodes, nlp_listp) {
 		if (ndlp->nlp_state == NLP_STE_NPR_NODE &&
-				(ndlp->nlp_flag & NLP_NPR_2B_DISC) != 0 &&
-				(ndlp->nlp_flag & NLP_DELAY_TMO) == 0 &&
-				(ndlp->nlp_flag & NLP_NPR_ADISC) == 0) {
+		    test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag) &&
+		    !test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag) &&
+		    !test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 			ndlp->nlp_prev_state = ndlp->nlp_state;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -7104,7 +7022,7 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			"2171 Xmit RDP response tag x%x xri x%x, "
-			"did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x",
+			"did x%x, nlp_flag x%lx, nlp_state x%x, rpi x%x",
 			elsiocb->iotag, ulp_context,
 			ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			ndlp->nlp_rpi);
@@ -8078,7 +7996,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	 */
 	if (vport->port_state <= LPFC_NS_QRY) {
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RSCN ignore: did:x%x/ste:x%x flg:x%x",
+			"RCV RSCN ignore: did:x%x/ste:x%x flg:x%lx",
 			ndlp->nlp_DID, vport->port_state, ndlp->nlp_flag);
 
 		lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
@@ -8108,7 +8026,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 					 vport->fc_flag, payload_len,
 					 *lp, vport->fc_rscn_id_cnt);
 			lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-				"RCV RSCN vport:  did:x%x/ste:x%x flg:x%x",
+				"RCV RSCN vport:  did:x%x/ste:x%x flg:x%lx",
 				ndlp->nlp_DID, vport->port_state,
 				ndlp->nlp_flag);
 
@@ -8145,7 +8063,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	if (test_bit(FC_RSCN_MODE, &vport->fc_flag) ||
 	    test_bit(FC_NDISC_ACTIVE, &vport->fc_flag)) {
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RSCN defer:  did:x%x/ste:x%x flg:x%x",
+			"RCV RSCN defer:  did:x%x/ste:x%x flg:x%lx",
 			ndlp->nlp_DID, vport->port_state, ndlp->nlp_flag);
 
 		set_bit(FC_RSCN_DEFERRED, &vport->fc_flag);
@@ -8201,7 +8119,7 @@ lpfc_els_rcv_rscn(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		return 0;
 	}
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-		"RCV RSCN:        did:x%x/ste:x%x flg:x%x",
+		"RCV RSCN:        did:x%x/ste:x%x flg:x%lx",
 		ndlp->nlp_DID, vport->port_state, ndlp->nlp_flag);
 
 	set_bit(FC_RSCN_MODE, &vport->fc_flag);
@@ -8707,7 +8625,7 @@ lpfc_els_rsp_rls_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	/* Xmit ELS RLS ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_ELS,
 			 "2874 Xmit ELS RLS ACC response tag x%x xri x%x, "
-			 "did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x\n",
+			 "did x%x, nlp_flag x%lx, nlp_state x%x, rpi x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
@@ -8869,7 +8787,7 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	/* Xmit ELS RLS ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_ELS,
 			 "2875 Xmit ELS RTV ACC response tag x%x xri x%x, "
-			 "did x%x, nlp_flag x%x, nlp_state x%x, rpi x%x, "
+			 "did x%x, nlp_flag x%lx, nlp_state x%x, rpi x%x, "
 			 "Data: x%x x%x x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
@@ -9066,7 +8984,7 @@ lpfc_els_rsp_rpl_acc(struct lpfc_vport *vport, uint16_t cmdsize,
 	/* Xmit ELS RPL ACC response tag <ulpIoTag> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0120 Xmit ELS RPL ACC response tag x%x "
-			 "xri x%x, did x%x, nlp_flag x%x, nlp_state x%x, "
+			 "xri x%x, did x%x, nlp_flag x%lx, nlp_state x%x, "
 			 "rpi x%x\n",
 			 elsiocb->iotag, ulp_context,
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
@@ -10411,14 +10329,11 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	 * Do not process any unsolicited ELS commands
 	 * if the ndlp is in DEV_LOSS
 	 */
-	spin_lock_irq(&ndlp->lock);
-	if (ndlp->nlp_flag & NLP_IN_DEV_LOSS) {
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag)) {
 		if (newnode)
 			lpfc_nlp_put(ndlp);
 		goto dropit;
 	}
-	spin_unlock_irq(&ndlp->lock);
 
 	elsiocb->ndlp = lpfc_nlp_get(ndlp);
 	if (!elsiocb->ndlp)
@@ -10447,7 +10362,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	switch (cmd) {
 	case ELS_CMD_PLOGI:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV PLOGI:       did:x%x/ste:x%x flg:x%x",
+			"RCV PLOGI:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvPLOGI++;
@@ -10486,9 +10401,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			}
 		}
 
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_TARGET_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_TARGET_REMOVE, &ndlp->nlp_flag);
 
 		lpfc_disc_state_machine(vport, ndlp, elsiocb,
 					NLP_EVT_RCV_PLOGI);
@@ -10496,7 +10409,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FLOGI:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV FLOGI:       did:x%x/ste:x%x flg:x%x",
+			"RCV FLOGI:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvFLOGI++;
@@ -10523,7 +10436,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_LOGO:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV LOGO:        did:x%x/ste:x%x flg:x%x",
+			"RCV LOGO:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvLOGO++;
@@ -10540,7 +10453,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_PRLO:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV PRLO:        did:x%x/ste:x%x flg:x%x",
+			"RCV PRLO:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvPRLO++;
@@ -10569,7 +10482,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_ADISC:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV ADISC:       did:x%x/ste:x%x flg:x%x",
+			"RCV ADISC:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		lpfc_send_els_event(vport, ndlp, payload);
@@ -10584,7 +10497,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_PDISC:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV PDISC:       did:x%x/ste:x%x flg:x%x",
+			"RCV PDISC:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvPDISC++;
@@ -10598,7 +10511,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FARPR:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV FARPR:       did:x%x/ste:x%x flg:x%x",
+			"RCV FARPR:       did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvFARPR++;
@@ -10606,7 +10519,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FARP:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV FARP:        did:x%x/ste:x%x flg:x%x",
+			"RCV FARP:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvFARP++;
@@ -10614,7 +10527,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FAN:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV FAN:         did:x%x/ste:x%x flg:x%x",
+			"RCV FAN:         did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvFAN++;
@@ -10623,7 +10536,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	case ELS_CMD_PRLI:
 	case ELS_CMD_NVMEPRLI:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV PRLI:        did:x%x/ste:x%x flg:x%x",
+			"RCV PRLI:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvPRLI++;
@@ -10637,7 +10550,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_LIRR:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV LIRR:        did:x%x/ste:x%x flg:x%x",
+			"RCV LIRR:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvLIRR++;
@@ -10648,7 +10561,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RLS:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RLS:         did:x%x/ste:x%x flg:x%x",
+			"RCV RLS:         did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvRLS++;
@@ -10659,7 +10572,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RPL:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RPL:         did:x%x/ste:x%x flg:x%x",
+			"RCV RPL:         did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvRPL++;
@@ -10670,7 +10583,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RNID:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RNID:        did:x%x/ste:x%x flg:x%x",
+			"RCV RNID:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvRNID++;
@@ -10681,7 +10594,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RTV:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RTV:        did:x%x/ste:x%x flg:x%x",
+			"RCV RTV:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 		phba->fc_stat.elsRcvRTV++;
 		lpfc_els_rcv_rtv(vport, elsiocb, ndlp);
@@ -10691,7 +10604,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_RRQ:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV RRQ:         did:x%x/ste:x%x flg:x%x",
+			"RCV RRQ:         did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvRRQ++;
@@ -10702,7 +10615,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_ECHO:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-			"RCV ECHO:        did:x%x/ste:x%x flg:x%x",
+			"RCV ECHO:        did:x%x/ste:x%x flg:x%lx",
 			did, vport->port_state, ndlp->nlp_flag);
 
 		phba->fc_stat.elsRcvECHO++;
@@ -10718,7 +10631,8 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 		break;
 	case ELS_CMD_FPIN:
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_UNSOL,
-				      "RCV FPIN:       did:x%x/ste:x%x flg:x%x",
+				      "RCV FPIN:       did:x%x/ste:x%x "
+				      "flg:x%lx",
 				      did, vport->port_state, ndlp->nlp_flag);
 
 		lpfc_els_rcv_fpin(vport, (struct fc_els_fpin *)payload,
@@ -11226,9 +11140,7 @@ lpfc_retry_pport_discovery(struct lpfc_hba *phba)
 		return;
 
 	mod_timer(&ndlp->nlp_delayfunc, jiffies + msecs_to_jiffies(1000));
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 	ndlp->nlp_last_elscmd = ELS_CMD_FLOGI;
 	phba->pport->port_state = LPFC_FLOGI;
 	return;
@@ -11359,11 +11271,9 @@ lpfc_cmpl_els_fdisc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		list_for_each_entry_safe(np, next_np,
 			&vport->fc_nodes, nlp_listp) {
 			if ((np->nlp_state != NLP_STE_NPR_NODE) ||
-			    !(np->nlp_flag & NLP_NPR_ADISC))
+			    !test_bit(NLP_NPR_ADISC, &np->nlp_flag))
 				continue;
-			spin_lock_irq(&ndlp->lock);
-			np->nlp_flag &= ~NLP_NPR_ADISC;
-			spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_NPR_ADISC, &np->nlp_flag);
 			lpfc_unreg_rpi(vport, np);
 		}
 		lpfc_cleanup_pending_mbox(vport);
@@ -11566,7 +11476,7 @@ lpfc_cmpl_els_npiv_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* NPIV LOGO completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "2928 NPIV LOGO completes to NPort x%x "
-			 "Data: x%x x%x x%x x%x x%x x%x x%x\n",
+			 "Data: x%x x%x x%x x%x x%x x%lx x%x\n",
 			 ndlp->nlp_DID, ulp_status, ulp_word4,
 			 tmo, vport->num_disc_nodes,
 			 kref_read(&ndlp->kref), ndlp->nlp_flag,
@@ -11582,8 +11492,9 @@ lpfc_cmpl_els_npiv_logo(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		/* Wake up lpfc_vport_delete if waiting...*/
 		if (ndlp->logo_waitq)
 			wake_up(ndlp->logo_waitq);
+		clear_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
+		clear_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~(NLP_ISSUE_LOGO | NLP_LOGO_SND);
 		ndlp->save_flags &= ~NLP_WAIT_FOR_LOGO;
 		spin_unlock_irq(&ndlp->lock);
 	}
@@ -11633,13 +11544,11 @@ lpfc_issue_els_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	memcpy(pcmd, &vport->fc_portname, sizeof(struct lpfc_name));
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_ELS_CMD,
-		"Issue LOGO npiv  did:x%x flg:x%x",
+		"Issue LOGO npiv  did:x%x flg:x%lx",
 		ndlp->nlp_DID, ndlp->nlp_flag, 0);
 
 	elsiocb->cmd_cmpl = lpfc_cmpl_els_npiv_logo;
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_SND;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 	elsiocb->ndlp = lpfc_nlp_get(ndlp);
 	if (!elsiocb->ndlp) {
 		lpfc_els_free_iocb(phba, elsiocb);
@@ -11655,9 +11564,7 @@ lpfc_issue_els_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	return 0;
 
 err:
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_LOGO_SND;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_LOGO_SND, &ndlp->nlp_flag);
 	return 1;
 }
 
@@ -12138,7 +12045,7 @@ lpfc_sli_abts_recover_port(struct lpfc_vport *vport,
 	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
 			"3094 Start rport recovery on shost id 0x%x "
 			"fc_id 0x%06x vpi 0x%x rpi 0x%x state 0x%x "
-			"flags 0x%x\n",
+			"flag 0x%lx\n",
 			shost->host_no, ndlp->nlp_DID,
 			vport->vpi, ndlp->nlp_rpi, ndlp->nlp_state,
 			ndlp->nlp_flag);
@@ -12148,8 +12055,8 @@ lpfc_sli_abts_recover_port(struct lpfc_vport *vport,
 	 */
 	spin_lock_irqsave(&ndlp->lock, flags);
 	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-	ndlp->nlp_flag |= NLP_ISSUE_LOGO;
 	spin_unlock_irqrestore(&ndlp->lock, flags);
+	set_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
 	lpfc_unreg_rpi(vport, ndlp);
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 34f77b250387..b5dd17eecf82 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -137,7 +137,7 @@ lpfc_terminate_rport_io(struct fc_rport *rport)
 	ndlp = rdata->pnode;
 	vport = ndlp->vport;
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-			      "rport terminate: sid:x%x did:x%x flg:x%x",
+			      "rport terminate: sid:x%x did:x%x flg:x%lx",
 			      ndlp->nlp_sid, ndlp->nlp_DID, ndlp->nlp_flag);
 
 	if (ndlp->nlp_sid != NLP_NO_SID)
@@ -155,7 +155,7 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	struct lpfc_hba   *phba;
 	struct lpfc_work_evt *evtp;
 	unsigned long iflags;
-	bool nvme_reg = false;
+	bool drop_initial_node_ref = false;
 
 	ndlp = ((struct lpfc_rport_data *)rport->dd_data)->pnode;
 	if (!ndlp)
@@ -165,11 +165,11 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	phba  = vport->phba;
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-		"rport devlosscb: sid:x%x did:x%x flg:x%x",
+		"rport devlosscb: sid:x%x did:x%x flg:x%lx",
 		ndlp->nlp_sid, ndlp->nlp_DID, ndlp->nlp_flag);
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-			 "3181 dev_loss_callbk x%06x, rport x%px flg x%x "
+			 "3181 dev_loss_callbk x%06x, rport x%px flg x%lx "
 			 "load_flag x%lx refcnt %u state %d xpt x%x\n",
 			 ndlp->nlp_DID, ndlp->rport, ndlp->nlp_flag,
 			 vport->load_flag, kref_read(&ndlp->kref),
@@ -182,8 +182,13 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		spin_lock_irqsave(&ndlp->lock, iflags);
 		ndlp->rport = NULL;
 
-		if (ndlp->fc4_xpt_flags & NVME_XPT_REGD)
-			nvme_reg = true;
+		/* Only 1 thread can drop the initial node reference.
+		 * If not registered for NVME and NLP_DROPPED flag is
+		 * clear, remove the initial reference.
+		 */
+		if (!(ndlp->fc4_xpt_flags & NVME_XPT_REGD))
+			if (!test_and_set_bit(NLP_DROPPED, &ndlp->nlp_flag))
+				drop_initial_node_ref = true;
 
 		/* The scsi_transport is done with the rport so lpfc cannot
 		 * call to unregister.
@@ -194,13 +199,16 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 			/* If NLP_XPT_REGD was cleared in lpfc_nlp_unreg_node,
 			 * unregister calls were made to the scsi and nvme
 			 * transports and refcnt was already decremented. Clear
-			 * the NLP_XPT_REGD flag only if the NVME Rport is
+			 * the NLP_XPT_REGD flag only if the NVME nrport is
 			 * confirmed unregistered.
 			 */
-			if (!nvme_reg && ndlp->fc4_xpt_flags & NLP_XPT_REGD) {
-				ndlp->fc4_xpt_flags &= ~NLP_XPT_REGD;
+			if (ndlp->fc4_xpt_flags & NLP_XPT_REGD) {
+				if (!(ndlp->fc4_xpt_flags & NVME_XPT_REGD))
+					ndlp->fc4_xpt_flags &= ~NLP_XPT_REGD;
 				spin_unlock_irqrestore(&ndlp->lock, iflags);
-				lpfc_nlp_put(ndlp); /* may free ndlp */
+
+				/* Release scsi transport reference */
+				lpfc_nlp_put(ndlp);
 			} else {
 				spin_unlock_irqrestore(&ndlp->lock, iflags);
 			}
@@ -208,19 +216,8 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 			spin_unlock_irqrestore(&ndlp->lock, iflags);
 		}
 
-		spin_lock_irqsave(&ndlp->lock, iflags);
-
-		/* Only 1 thread can drop the initial node reference.  If
-		 * another thread has set NLP_DROPPED, this thread is done.
-		 */
-		if (nvme_reg || (ndlp->nlp_flag & NLP_DROPPED)) {
-			spin_unlock_irqrestore(&ndlp->lock, iflags);
-			return;
-		}
-
-		ndlp->nlp_flag |= NLP_DROPPED;
-		spin_unlock_irqrestore(&ndlp->lock, iflags);
-		lpfc_nlp_put(ndlp);
+		if (drop_initial_node_ref)
+			lpfc_nlp_put(ndlp);
 		return;
 	}
 
@@ -253,14 +250,14 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 		return;
 	}
 
-	spin_lock_irqsave(&ndlp->lock, iflags);
-	ndlp->nlp_flag |= NLP_IN_DEV_LOSS;
+	set_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 
+	spin_lock_irqsave(&ndlp->lock, iflags);
 	/* If there is a PLOGI in progress, and we are in a
 	 * NLP_NPR_2B_DISC state, don't turn off the flag.
 	 */
 	if (ndlp->nlp_state != NLP_STE_PLOGI_ISSUE)
-		ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
+		clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 	/*
 	 * The backend does not expect any more calls associated with this
@@ -289,15 +286,13 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	} else {
 		lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
 				 "3188 worker thread is stopped %s x%06x, "
-				 " rport x%px flg x%x load_flag x%lx refcnt "
+				 " rport x%px flg x%lx load_flag x%lx refcnt "
 				 "%d\n", __func__, ndlp->nlp_DID,
 				 ndlp->rport, ndlp->nlp_flag,
 				 vport->load_flag, kref_read(&ndlp->kref));
 		if (!(ndlp->fc4_xpt_flags & NVME_XPT_REGD)) {
-			spin_lock_irqsave(&ndlp->lock, iflags);
 			/* Node is in dev loss.  No further transaction. */
-			ndlp->nlp_flag &= ~NLP_IN_DEV_LOSS;
-			spin_unlock_irqrestore(&ndlp->lock, iflags);
+			clear_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 			lpfc_disc_state_machine(vport, ndlp, NULL,
 						NLP_EVT_DEVICE_RM);
 		}
@@ -430,7 +425,7 @@ lpfc_check_nlp_post_devloss(struct lpfc_vport *vport,
 		lpfc_nlp_get(ndlp);
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY | LOG_NODE,
 				 "8438 Devloss timeout reversed on DID x%x "
-				 "refcnt %d ndlp %p flag x%x "
+				 "refcnt %d ndlp %p flag x%lx "
 				 "port_state = x%x\n",
 				 ndlp->nlp_DID, kref_read(&ndlp->kref), ndlp,
 				 ndlp->nlp_flag, vport->port_state);
@@ -473,7 +468,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 			      ndlp->nlp_DID, ndlp->nlp_type, ndlp->nlp_sid);
 
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_NODE,
-			 "3182 %s x%06x, nflag x%x xflags x%x refcnt %d\n",
+			 "3182 %s x%06x, nflag x%lx xflags x%x refcnt %d\n",
 			 __func__, ndlp->nlp_DID, ndlp->nlp_flag,
 			 ndlp->fc4_xpt_flags, kref_read(&ndlp->kref));
 
@@ -487,9 +482,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 				 *(name+4), *(name+5), *(name+6), *(name+7),
 				 ndlp->nlp_DID);
 
-		spin_lock_irqsave(&ndlp->lock, iflags);
-		ndlp->nlp_flag &= ~NLP_IN_DEV_LOSS;
-		spin_unlock_irqrestore(&ndlp->lock, iflags);
+		clear_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 		return fcf_inuse;
 	}
 
@@ -517,7 +510,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 			}
 			break;
 		case Fabric_Cntl_DID:
-			if (ndlp->nlp_flag & NLP_REG_LOGIN_SEND)
+			if (test_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag))
 				recovering = true;
 			break;
 		case FDMI_DID:
@@ -545,15 +538,13 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 		 * the following lpfc_nlp_put is necessary after fabric node is
 		 * recovered.
 		 */
-		spin_lock_irqsave(&ndlp->lock, iflags);
-		ndlp->nlp_flag &= ~NLP_IN_DEV_LOSS;
-		spin_unlock_irqrestore(&ndlp->lock, iflags);
+		clear_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 		if (recovering) {
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_DISCOVERY | LOG_NODE,
 					 "8436 Devloss timeout marked on "
 					 "DID x%x refcnt %d ndlp %p "
-					 "flag x%x port_state = x%x\n",
+					 "flag x%lx port_state = x%x\n",
 					 ndlp->nlp_DID, kref_read(&ndlp->kref),
 					 ndlp, ndlp->nlp_flag,
 					 vport->port_state);
@@ -570,7 +561,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 					 LOG_DISCOVERY | LOG_NODE,
 					 "8437 Devloss timeout ignored on "
 					 "DID x%x refcnt %d ndlp %p "
-					 "flag x%x port_state = x%x\n",
+					 "flag x%lx port_state = x%x\n",
 					 ndlp->nlp_DID, kref_read(&ndlp->kref),
 					 ndlp, ndlp->nlp_flag,
 					 vport->port_state);
@@ -590,7 +581,7 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0203 Devloss timeout on "
 				 "WWPN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
-				 "NPort x%06x Data: x%x x%x x%x refcnt %d\n",
+				 "NPort x%06x Data: x%lx x%x x%x refcnt %d\n",
 				 *name, *(name+1), *(name+2), *(name+3),
 				 *(name+4), *(name+5), *(name+6), *(name+7),
 				 ndlp->nlp_DID, ndlp->nlp_flag,
@@ -600,15 +591,13 @@ lpfc_dev_loss_tmo_handler(struct lpfc_nodelist *ndlp)
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_TRACE_EVENT,
 				 "0204 Devloss timeout on "
 				 "WWPN %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
-				 "NPort x%06x Data: x%x x%x x%x\n",
+				 "NPort x%06x Data: x%lx x%x x%x\n",
 				 *name, *(name+1), *(name+2), *(name+3),
 				 *(name+4), *(name+5), *(name+6), *(name+7),
 				 ndlp->nlp_DID, ndlp->nlp_flag,
 				 ndlp->nlp_state, ndlp->nlp_rpi);
 	}
-	spin_lock_irqsave(&ndlp->lock, iflags);
-	ndlp->nlp_flag &= ~NLP_IN_DEV_LOSS;
-	spin_unlock_irqrestore(&ndlp->lock, iflags);
+	clear_bit(NLP_IN_DEV_LOSS, &ndlp->nlp_flag);
 
 	/* If we are devloss, but we are in the process of rediscovering the
 	 * ndlp, don't issue a NLP_EVT_DEVICE_RM event.
@@ -1373,7 +1362,7 @@ lpfc_linkup_cleanup_nodes(struct lpfc_vport *vport)
 			if (ndlp->nlp_DID != Fabric_DID)
 				lpfc_unreg_rpi(vport, ndlp);
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-		} else if (!(ndlp->nlp_flag & NLP_NPR_ADISC)) {
+		} else if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 			/* Fail outstanding IO now since device is
 			 * marked for PLOGI.
 			 */
@@ -3882,14 +3871,13 @@ lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	pmb->ctx_ndlp = NULL;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_SLI | LOG_NODE | LOG_DISCOVERY,
-			 "0002 rpi:%x DID:%x flg:%x %d x%px\n",
+			 "0002 rpi:%x DID:%x flg:%lx %d x%px\n",
 			 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 			 kref_read(&ndlp->kref),
 			 ndlp);
-	if (ndlp->nlp_flag & NLP_REG_LOGIN_SEND)
-		ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+	clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 
-	if (ndlp->nlp_flag & NLP_IGNR_REG_CMPL ||
+	if (test_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag) ||
 	    ndlp->nlp_state != NLP_STE_REG_LOGIN_ISSUE) {
 		/* We rcvd a rscn after issuing this
 		 * mbox reg login, we may have cycled
@@ -3899,16 +3887,14 @@ lpfc_mbx_cmpl_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		 * there is another reg login in
 		 * process.
 		 */
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag);
 
 		/*
 		 * We cannot leave the RPI registered because
 		 * if we go thru discovery again for this ndlp
 		 * a subsequent REG_RPI will fail.
 		 */
-		ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+		set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 		lpfc_unreg_rpi(vport, ndlp);
 	}
 
@@ -4221,7 +4207,7 @@ lpfc_mbx_cmpl_fabric_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	if (phba->sli_rev < LPFC_SLI_REV4)
 		ndlp->nlp_rpi = mb->un.varWords[0];
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 
@@ -4352,9 +4338,7 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		 * reference.
 		 */
 		if (!(ndlp->fc4_xpt_flags & (SCSI_XPT_REGD | NVME_XPT_REGD))) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 			lpfc_nlp_put(ndlp);
 		}
 
@@ -4375,11 +4359,11 @@ lpfc_mbx_cmpl_ns_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	if (phba->sli_rev < LPFC_SLI_REV4)
 		ndlp->nlp_rpi = mb->un.varWords[0];
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE | LOG_DISCOVERY,
-			 "0003 rpi:%x DID:%x flg:%x %d x%px\n",
+			 "0003 rpi:%x DID:%x flg:%lx %d x%px\n",
 			 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 			 kref_read(&ndlp->kref),
 			 ndlp);
@@ -4471,8 +4455,8 @@ lpfc_mbx_cmpl_fc_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 			 __func__, ndlp->nlp_DID, ndlp->nlp_rpi,
 			 ndlp->nlp_state);
 
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
-	ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
+	clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 
@@ -4506,7 +4490,7 @@ lpfc_register_remote_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-			      "rport add:       did:x%x flg:x%x type x%x",
+			      "rport add:       did:x%x flg:x%lx type x%x",
 			      ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_type);
 
 	/* Don't add the remote port if unloading. */
@@ -4574,7 +4558,7 @@ lpfc_unregister_remote_port(struct lpfc_nodelist *ndlp)
 		return;
 
 	lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-		"rport delete:    did:x%x flg:x%x type x%x",
+		"rport delete:    did:x%x flg:x%lx type x%x",
 		ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_type);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
@@ -4690,7 +4674,7 @@ lpfc_nlp_unreg_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		lpfc_printf_vlog(vport, KERN_INFO,
 				 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
 				 "0999 %s Not regd: ndlp x%px rport x%px DID "
-				 "x%x FLG x%x XPT x%x\n",
+				 "x%x FLG x%lx XPT x%x\n",
 				  __func__, ndlp, ndlp->rport, ndlp->nlp_DID,
 				  ndlp->nlp_flag, ndlp->fc4_xpt_flags);
 		return;
@@ -4706,7 +4690,7 @@ lpfc_nlp_unreg_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	} else if (!ndlp->rport) {
 		lpfc_printf_vlog(vport, KERN_INFO,
 				 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
-				 "1999 %s NDLP in devloss x%px DID x%x FLG x%x"
+				 "1999 %s NDLP in devloss x%px DID x%x FLG x%lx"
 				 " XPT x%x refcnt %u\n",
 				 __func__, ndlp, ndlp->nlp_DID, ndlp->nlp_flag,
 				 ndlp->fc4_xpt_flags,
@@ -4751,7 +4735,7 @@ lpfc_handle_adisc_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		ndlp->nlp_type |= NLP_FC_NODE;
 		fallthrough;
 	case NLP_STE_MAPPED_NODE:
-		ndlp->nlp_flag &= ~NLP_NODEV_REMOVE;
+		clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		lpfc_nlp_reg_node(vport, ndlp);
 		break;
 
@@ -4762,7 +4746,7 @@ lpfc_handle_adisc_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * backend, attempt it now
 	 */
 	case NLP_STE_NPR_NODE:
-		ndlp->nlp_flag &= ~NLP_RCV_PLOGI;
+		clear_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag);
 		fallthrough;
 	default:
 		lpfc_nlp_unreg_node(vport, ndlp);
@@ -4783,13 +4767,13 @@ lpfc_nlp_state_cleanup(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	}
 
 	if (new_state == NLP_STE_UNMAPPED_NODE) {
-		ndlp->nlp_flag &= ~NLP_NODEV_REMOVE;
+		clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		ndlp->nlp_type |= NLP_FC_NODE;
 	}
 	if (new_state == NLP_STE_MAPPED_NODE)
-		ndlp->nlp_flag &= ~NLP_NODEV_REMOVE;
+		clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 	if (new_state == NLP_STE_NPR_NODE)
-		ndlp->nlp_flag &= ~NLP_RCV_PLOGI;
+		clear_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag);
 
 	/* Reg/Unreg for FCP and NVME Transport interface */
 	if ((old_state == NLP_STE_MAPPED_NODE ||
@@ -4797,7 +4781,7 @@ lpfc_nlp_state_cleanup(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		/* For nodes marked for ADISC, Handle unreg in ADISC cmpl
 		 * if linkup. In linkdown do unreg_node
 		 */
-		if (!(ndlp->nlp_flag & NLP_NPR_ADISC) ||
+		if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag) ||
 		    !lpfc_is_link_up(vport->phba))
 			lpfc_nlp_unreg_node(vport, ndlp);
 	}
@@ -4817,9 +4801,7 @@ lpfc_nlp_state_cleanup(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	    (!ndlp->rport ||
 	     ndlp->rport->scsi_target_id == -1 ||
 	     ndlp->rport->scsi_target_id >= LPFC_MAX_TARGET)) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_TGT_NO_SCSIID;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_TGT_NO_SCSIID, &ndlp->nlp_flag);
 		lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	}
 }
@@ -4851,7 +4833,7 @@ lpfc_nlp_set_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		   int state)
 {
 	int  old_state = ndlp->nlp_state;
-	int node_dropped = ndlp->nlp_flag & NLP_DROPPED;
+	bool node_dropped = test_bit(NLP_DROPPED, &ndlp->nlp_flag);
 	char name1[16], name2[16];
 	unsigned long iflags;
 
@@ -4867,7 +4849,7 @@ lpfc_nlp_set_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	if (node_dropped && old_state == NLP_STE_UNUSED_NODE &&
 	    state != NLP_STE_UNUSED_NODE) {
-		ndlp->nlp_flag &= ~NLP_DROPPED;
+		clear_bit(NLP_DROPPED, &ndlp->nlp_flag);
 		lpfc_nlp_get(ndlp);
 	}
 
@@ -4875,7 +4857,7 @@ lpfc_nlp_set_state(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	    state != NLP_STE_NPR_NODE)
 		lpfc_cancel_retry_delay_tmo(vport, ndlp);
 	if (old_state == NLP_STE_UNMAPPED_NODE) {
-		ndlp->nlp_flag &= ~NLP_TGT_NO_SCSIID;
+		clear_bit(NLP_TGT_NO_SCSIID, &ndlp->nlp_flag);
 		ndlp->nlp_type &= ~NLP_FC_NODE;
 	}
 
@@ -4972,14 +4954,8 @@ lpfc_drop_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	 * reference from lpfc_nlp_init.  If set, don't drop it again and
 	 * introduce an imbalance.
 	 */
-	spin_lock_irq(&ndlp->lock);
-	if (!(ndlp->nlp_flag & NLP_DROPPED)) {
-		ndlp->nlp_flag |= NLP_DROPPED;
-		spin_unlock_irq(&ndlp->lock);
+	if (!test_and_set_bit(NLP_DROPPED, &ndlp->nlp_flag))
 		lpfc_nlp_put(ndlp);
-		return;
-	}
-	spin_unlock_irq(&ndlp->lock);
 }
 
 /*
@@ -5094,9 +5070,9 @@ lpfc_check_sli_ndlp(struct lpfc_hba *phba,
 	} else if (pring->ringno == LPFC_FCP_RING) {
 		/* Skip match check if waiting to relogin to FCP target */
 		if ((ndlp->nlp_type & NLP_FCP_TARGET) &&
-		    (ndlp->nlp_flag & NLP_DELAY_TMO)) {
+		    test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag))
 			return 0;
-		}
+
 		if (ulp_context == ndlp->nlp_rpi)
 			return 1;
 	}
@@ -5166,7 +5142,7 @@ lpfc_no_rpi(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 	 * Everything that matches on txcmplq will be returned
 	 * by firmware with a no rpi error.
 	 */
-	if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
+	if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag)) {
 		if (phba->sli_rev != LPFC_SLI_REV4)
 			lpfc_sli3_dequeue_nport_iocbs(phba, ndlp, &completions);
 		else
@@ -5200,29 +5176,19 @@ lpfc_nlp_logo_unreg(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	lpfc_issue_els_logo(vport, ndlp, 0);
 
 	/* Check to see if there are any deferred events to process */
-	if ((ndlp->nlp_flag & NLP_UNREG_INP) &&
-	    (ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING)) {
+	if (test_bit(NLP_UNREG_INP, &ndlp->nlp_flag) &&
+	    ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "1434 UNREG cmpl deferred logo x%x "
 				 "on NPort x%x Data: x%x x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_defer_did, ndlp);
 
-		ndlp->nlp_flag &= ~NLP_UNREG_INP;
+		clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 		ndlp->nlp_defer_did = NLP_EVT_NOTHING_PENDING;
 		lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
 	} else {
-		/* NLP_RELEASE_RPI is only set for SLI4 ports. */
-		if (ndlp->nlp_flag & NLP_RELEASE_RPI) {
-			lpfc_sli4_free_rpi(vport->phba, ndlp->nlp_rpi);
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
-			ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
-			spin_unlock_irq(&ndlp->lock);
-		}
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_UNREG_INP;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 	}
 
 	/* The node has an outstanding reference for the unreg. Now
@@ -5242,8 +5208,6 @@ static void
 lpfc_set_unreg_login_mbx_cmpl(struct lpfc_hba *phba, struct lpfc_vport *vport,
 	struct lpfc_nodelist *ndlp, LPFC_MBOXQ_t *mbox)
 {
-	unsigned long iflags;
-
 	/* Driver always gets a reference on the mailbox job
 	 * in support of async jobs.
 	 */
@@ -5251,9 +5215,8 @@ lpfc_set_unreg_login_mbx_cmpl(struct lpfc_hba *phba, struct lpfc_vport *vport,
 	if (!mbox->ctx_ndlp)
 		return;
 
-	if (ndlp->nlp_flag & NLP_ISSUE_LOGO) {
+	if (test_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag)) {
 		mbox->mbox_cmpl = lpfc_nlp_logo_unreg;
-
 	} else if (phba->sli_rev == LPFC_SLI_REV4 &&
 		   !test_bit(FC_UNLOADING, &vport->load_flag) &&
 		    (bf_get(lpfc_sli_intf_if_type, &phba->sli4_hba.sli_intf) >=
@@ -5261,13 +5224,6 @@ lpfc_set_unreg_login_mbx_cmpl(struct lpfc_hba *phba, struct lpfc_vport *vport,
 		    (kref_read(&ndlp->kref) > 0)) {
 		mbox->mbox_cmpl = lpfc_sli4_unreg_rpi_cmpl_clr;
 	} else {
-		if (test_bit(FC_UNLOADING, &vport->load_flag)) {
-			if (phba->sli_rev == LPFC_SLI_REV4) {
-				spin_lock_irqsave(&ndlp->lock, iflags);
-				ndlp->nlp_flag |= NLP_RELEASE_RPI;
-				spin_unlock_irqrestore(&ndlp->lock, iflags);
-			}
-		}
 		mbox->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
 	}
 }
@@ -5289,13 +5245,13 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	int rc, acc_plogi = 1;
 	uint16_t rpi;
 
-	if (ndlp->nlp_flag & NLP_RPI_REGISTERED ||
-	    ndlp->nlp_flag & NLP_REG_LOGIN_SEND) {
-		if (ndlp->nlp_flag & NLP_REG_LOGIN_SEND)
+	if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag) ||
+	    test_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag)) {
+		if (test_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag))
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_NODE | LOG_DISCOVERY,
 					 "3366 RPI x%x needs to be "
-					 "unregistered nlp_flag x%x "
+					 "unregistered nlp_flag x%lx "
 					 "did x%x\n",
 					 ndlp->nlp_rpi, ndlp->nlp_flag,
 					 ndlp->nlp_DID);
@@ -5303,11 +5259,11 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		/* If there is already an UNREG in progress for this ndlp,
 		 * no need to queue up another one.
 		 */
-		if (ndlp->nlp_flag & NLP_UNREG_INP) {
+		if (test_bit(NLP_UNREG_INP, &ndlp->nlp_flag)) {
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_NODE | LOG_DISCOVERY,
 					 "1436 unreg_rpi SKIP UNREG x%x on "
-					 "NPort x%x deferred x%x  flg x%x "
+					 "NPort x%x deferred x%x flg x%lx "
 					 "Data: x%px\n",
 					 ndlp->nlp_rpi, ndlp->nlp_DID,
 					 ndlp->nlp_defer_did,
@@ -5330,27 +5286,24 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 				return 1;
 			}
 
+			/* Accept PLOGIs after unreg_rpi_cmpl. */
 			if (mbox->mbox_cmpl == lpfc_sli4_unreg_rpi_cmpl_clr)
-				/*
-				 * accept PLOGIs after unreg_rpi_cmpl
-				 */
 				acc_plogi = 0;
-			if (((ndlp->nlp_DID & Fabric_DID_MASK) !=
-			    Fabric_DID_MASK) &&
-			    (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag)))
-				ndlp->nlp_flag |= NLP_UNREG_INP;
+
+			if (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag))
+				set_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_NODE | LOG_DISCOVERY,
 					 "1433 unreg_rpi UNREG x%x on "
-					 "NPort x%x deferred flg x%x "
+					 "NPort x%x deferred flg x%lx "
 					 "Data:x%px\n",
 					 ndlp->nlp_rpi, ndlp->nlp_DID,
 					 ndlp->nlp_flag, ndlp);
 
 			rc = lpfc_sli_issue_mbox(phba, mbox, MBX_NOWAIT);
 			if (rc == MBX_NOT_FINISHED) {
-				ndlp->nlp_flag &= ~NLP_UNREG_INP;
+				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 				mempool_free(mbox, phba->mbox_mem_pool);
 				acc_plogi = 1;
 				lpfc_nlp_put(ndlp);
@@ -5360,7 +5313,7 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 					 LOG_NODE | LOG_DISCOVERY,
 					 "1444 Failed to allocate mempool "
 					 "unreg_rpi UNREG x%x, "
-					 "DID x%x, flag x%x, "
+					 "DID x%x, flag x%lx, "
 					 "ndlp x%px\n",
 					 ndlp->nlp_rpi, ndlp->nlp_DID,
 					 ndlp->nlp_flag, ndlp);
@@ -5370,7 +5323,7 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 			 * not unloading.
 			 */
 			if (!test_bit(FC_UNLOADING, &vport->load_flag)) {
-				ndlp->nlp_flag &= ~NLP_UNREG_INP;
+				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 				lpfc_issue_els_logo(vport, ndlp, 0);
 				ndlp->nlp_prev_state = ndlp->nlp_state;
 				lpfc_nlp_set_state(vport, ndlp,
@@ -5383,13 +5336,13 @@ lpfc_unreg_rpi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 out:
 		if (phba->sli_rev != LPFC_SLI_REV4)
 			ndlp->nlp_rpi = 0;
-		ndlp->nlp_flag &= ~NLP_RPI_REGISTERED;
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
+		clear_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 		if (acc_plogi)
-			ndlp->nlp_flag &= ~NLP_LOGO_ACC;
+			clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 		return 1;
 	}
-	ndlp->nlp_flag &= ~NLP_LOGO_ACC;
+	clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	return 0;
 }
 
@@ -5417,7 +5370,7 @@ lpfc_unreg_hba_rpis(struct lpfc_hba *phba)
 	for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
 		spin_lock_irqsave(&vports[i]->fc_nodes_list_lock, iflags);
 		list_for_each_entry(ndlp, &vports[i]->fc_nodes, nlp_listp) {
-			if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
+			if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag)) {
 				/* The mempool_alloc might sleep */
 				spin_unlock_irqrestore(&vports[i]->fc_nodes_list_lock,
 						       iflags);
@@ -5505,7 +5458,7 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	/* Cleanup node for NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
 			 "0900 Cleanup node for NPort x%x "
-			 "Data: x%x x%x x%x\n",
+			 "Data: x%lx x%x x%x\n",
 			 ndlp->nlp_DID, ndlp->nlp_flag,
 			 ndlp->nlp_state, ndlp->nlp_rpi);
 	lpfc_dequeue_node(vport, ndlp);
@@ -5550,9 +5503,7 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 
 	lpfc_els_abort(phba, ndlp);
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 
 	ndlp->nlp_last_elscmd = 0;
 	del_timer_sync(&ndlp->nlp_delayfunc);
@@ -5561,10 +5512,6 @@ lpfc_cleanup_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	list_del_init(&ndlp->dev_loss_evt.evt_listp);
 	list_del_init(&ndlp->recovery_evt.evt_listp);
 	lpfc_cleanup_vports_rrqs(vport, ndlp);
-
-	if (phba->sli_rev == LPFC_SLI_REV4)
-		ndlp->nlp_flag |= NLP_RELEASE_RPI;
-
 	return 0;
 }
 
@@ -5639,7 +5586,7 @@ __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 				 );
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE_VERBOSE,
 					 "0929 FIND node DID "
-					 "Data: x%px x%x x%x x%x x%x x%px\n",
+					 "Data: x%px x%x x%lx x%x x%x x%px\n",
 					 ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, data1, ndlp->nlp_rpi,
 					 ndlp->active_rrqs_xri_bitmap);
@@ -5692,7 +5639,7 @@ lpfc_findnode_mapped(struct lpfc_vport *vport)
 					       iflags);
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE_VERBOSE,
 					 "2025 FIND node DID MAPPED "
-					 "Data: x%px x%x x%x x%x x%px\n",
+					 "Data: x%px x%x x%lx x%x x%px\n",
 					 ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, data1,
 					 ndlp->active_rrqs_xri_bitmap);
@@ -5726,13 +5673,11 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "6453 Setup New Node 2B_DISC x%x "
-				 "Data:x%x x%x x%lx\n",
+				 "Data:x%lx x%x x%lx\n",
 				 ndlp->nlp_DID, ndlp->nlp_flag,
 				 ndlp->nlp_state, vport->fc_flag);
 
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		return ndlp;
 	}
 
@@ -5751,7 +5696,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "6455 Setup RSCN Node 2B_DISC x%x "
-					 "Data:x%x x%x x%lx\n",
+					 "Data:x%lx x%x x%lx\n",
 					 ndlp->nlp_DID, ndlp->nlp_flag,
 					 ndlp->nlp_state, vport->fc_flag);
 
@@ -5769,13 +5714,11 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 							NLP_EVT_DEVICE_RECOVERY);
 			}
 
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 		} else {
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 					 "6456 Skip Setup RSCN Node x%x "
-					 "Data:x%x x%x x%lx\n",
+					 "Data:x%lx x%x x%lx\n",
 					 ndlp->nlp_DID, ndlp->nlp_flag,
 					 ndlp->nlp_state, vport->fc_flag);
 			ndlp = NULL;
@@ -5783,7 +5726,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 	} else {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "6457 Setup Active Node 2B_DISC x%x "
-				 "Data:x%x x%x x%lx\n",
+				 "Data:x%lx x%x x%lx\n",
 				 ndlp->nlp_DID, ndlp->nlp_flag,
 				 ndlp->nlp_state, vport->fc_flag);
 
@@ -5794,7 +5737,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 		if (ndlp->nlp_state == NLP_STE_ADISC_ISSUE ||
 		    ndlp->nlp_state == NLP_STE_PLOGI_ISSUE ||
 		    (!vport->phba->nvmet_support &&
-		     ndlp->nlp_flag & NLP_RCV_PLOGI))
+		     test_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag)))
 			return NULL;
 
 		if (vport->phba->nvmet_support)
@@ -5804,10 +5747,7 @@ lpfc_setup_disc_node(struct lpfc_vport *vport, uint32_t did)
 		 * allows for rediscovery
 		 */
 		lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NPR_2B_DISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	}
 	return ndlp;
 }
@@ -6178,7 +6118,7 @@ lpfc_disc_timeout_handler(struct lpfc_vport *vport)
 				/* Clean up the ndlp on Fabric connections */
 				lpfc_drop_node(vport, ndlp);
 
-			} else if (!(ndlp->nlp_flag & NLP_NPR_ADISC)) {
+			} else if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 				/* Fail outstanding IO now since device
 				 * is marked for PLOGI.
 				 */
@@ -6391,11 +6331,11 @@ lpfc_mbx_cmpl_fdmi_reg_login(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 
 	if (phba->sli_rev < LPFC_SLI_REV4)
 		ndlp->nlp_rpi = mb->un.varWords[0];
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 	ndlp->nlp_type |= NLP_FABRIC;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_UNMAPPED_NODE);
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE | LOG_DISCOVERY,
-			 "0004 rpi:%x DID:%x flg:%x %d x%px\n",
+			 "0004 rpi:%x DID:%x flg:%lx %d x%px\n",
 			 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag,
 			 kref_read(&ndlp->kref),
 			 ndlp);
@@ -6445,7 +6385,7 @@ __lpfc_find_node(struct lpfc_vport *vport, node_filter filter, void *param)
 		if (filter(ndlp, param)) {
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE_VERBOSE,
 					 "3185 FIND node filter %ps DID "
-					 "ndlp x%px did x%x flg x%x st x%x "
+					 "ndlp x%px did x%x flg x%lx st x%x "
 					 "xri x%x type x%x rpi x%x\n",
 					 filter, ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, ndlp->nlp_state,
@@ -6580,9 +6520,10 @@ lpfc_nlp_init(struct lpfc_vport *vport, uint32_t did)
 	INIT_LIST_HEAD(&ndlp->nlp_listp);
 	if (vport->phba->sli_rev == LPFC_SLI_REV4) {
 		ndlp->nlp_rpi = rpi;
-		lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE | LOG_DISCOVERY,
-				 "0007 Init New ndlp x%px, rpi:x%x DID:%x "
-				 "flg:x%x refcnt:%d\n",
+		lpfc_printf_vlog(vport, KERN_INFO,
+				 LOG_ELS | LOG_NODE | LOG_DISCOVERY,
+				 "0007 Init New ndlp x%px, rpi:x%x DID:x%x "
+				 "flg:x%lx refcnt:%d\n",
 				 ndlp, ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_flag, kref_read(&ndlp->kref));
 
@@ -6614,7 +6555,7 @@ lpfc_nlp_release(struct kref *kref)
 	struct lpfc_vport *vport = ndlp->vport;
 
 	lpfc_debugfs_disc_trc(ndlp->vport, LPFC_DISC_TRC_NODE,
-		"node release:    did:x%x flg:x%x type:x%x",
+		"node release:    did:x%x flg:x%lx type:x%x",
 		ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_type);
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
@@ -6626,19 +6567,12 @@ lpfc_nlp_release(struct kref *kref)
 	lpfc_cancel_retry_delay_tmo(vport, ndlp);
 	lpfc_cleanup_node(vport, ndlp);
 
-	/* Not all ELS transactions have registered the RPI with the port.
-	 * In these cases the rpi usage is temporary and the node is
-	 * released when the WQE is completed.  Catch this case to free the
-	 * RPI to the pool.  Because this node is in the release path, a lock
-	 * is unnecessary.  All references are gone and the node has been
-	 * dequeued.
+	/* All nodes are initialized with an RPI that needs to be released
+	 * now. All references are gone and the node has been dequeued.
 	 */
-	if (ndlp->nlp_flag & NLP_RELEASE_RPI) {
-		if (ndlp->nlp_rpi != LPFC_RPI_ALLOC_ERROR &&
-		    !(ndlp->nlp_flag & (NLP_RPI_REGISTERED | NLP_UNREG_INP))) {
-			lpfc_sli4_free_rpi(vport->phba, ndlp->nlp_rpi);
-			ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
-		}
+	if (vport->phba->sli_rev == LPFC_SLI_REV4) {
+		lpfc_sli4_free_rpi(vport->phba, ndlp->nlp_rpi);
+		ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
 	}
 
 	/* The node is not freed back to memory, it is released to a pool so
@@ -6667,7 +6601,7 @@ lpfc_nlp_get(struct lpfc_nodelist *ndlp)
 
 	if (ndlp) {
 		lpfc_debugfs_disc_trc(ndlp->vport, LPFC_DISC_TRC_NODE,
-			"node get:        did:x%x flg:x%x refcnt:x%x",
+			"node get:        did:x%x flg:x%lx refcnt:x%x",
 			ndlp->nlp_DID, ndlp->nlp_flag,
 			kref_read(&ndlp->kref));
 
@@ -6699,7 +6633,7 @@ lpfc_nlp_put(struct lpfc_nodelist *ndlp)
 {
 	if (ndlp) {
 		lpfc_debugfs_disc_trc(ndlp->vport, LPFC_DISC_TRC_NODE,
-				"node put:        did:x%x flg:x%x refcnt:x%x",
+				"node put:        did:x%x flg:x%lx refcnt:x%x",
 				ndlp->nlp_DID, ndlp->nlp_flag,
 				kref_read(&ndlp->kref));
 	} else {
@@ -6752,11 +6686,12 @@ lpfc_fcf_inuse(struct lpfc_hba *phba)
 				spin_unlock_irqrestore(&vports[i]->fc_nodes_list_lock,
 						       iflags);
 				goto out;
-			} else if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
+			} else if (test_bit(NLP_RPI_REGISTERED,
+					    &ndlp->nlp_flag)) {
 				ret = 1;
 				lpfc_printf_log(phba, KERN_INFO,
 						LOG_NODE | LOG_DISCOVERY,
-						"2624 RPI %x DID %x flag %x "
+						"2624 RPI %x DID %x flag %lx "
 						"still logged in\n",
 						ndlp->nlp_rpi, ndlp->nlp_DID,
 						ndlp->nlp_flag);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 50c761991191..3ddcaa864f07 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3092,7 +3092,8 @@ lpfc_cleanup(struct lpfc_vport *vport)
 				lpfc_printf_vlog(ndlp->vport, KERN_ERR,
 						 LOG_DISCOVERY,
 						 "0282 did:x%x ndlp:x%px "
-						 "refcnt:%d xflags x%x nflag x%x\n",
+						 "refcnt:%d xflags x%x "
+						 "nflag x%lx\n",
 						 ndlp->nlp_DID, (void *)ndlp,
 						 kref_read(&ndlp->kref),
 						 ndlp->fc4_xpt_flags,
@@ -3379,7 +3380,7 @@ lpfc_block_mgmt_io(struct lpfc_hba *phba, int mbx_action)
 }
 
 /**
- * lpfc_sli4_node_prep - Assign RPIs for active nodes.
+ * lpfc_sli4_node_rpi_restore - Recover assigned RPIs for active nodes.
  * @phba: pointer to lpfc hba data structure.
  *
  * Allocate RPIs for all active remote nodes. This is needed whenever
@@ -3387,7 +3388,7 @@ lpfc_block_mgmt_io(struct lpfc_hba *phba, int mbx_action)
  * is to fixup the temporary rpi assignments.
  **/
 void
-lpfc_sli4_node_prep(struct lpfc_hba *phba)
+lpfc_sli4_node_rpi_restore(struct lpfc_hba *phba)
 {
 	struct lpfc_nodelist  *ndlp, *next_ndlp;
 	struct lpfc_vport **vports;
@@ -3397,10 +3398,10 @@ lpfc_sli4_node_prep(struct lpfc_hba *phba)
 		return;
 
 	vports = lpfc_create_vport_work_array(phba);
-	if (vports == NULL)
+	if (!vports)
 		return;
 
-	for (i = 0; i <= phba->max_vports && vports[i] != NULL; i++) {
+	for (i = 0; i <= phba->max_vports && vports[i]; i++) {
 		if (test_bit(FC_UNLOADING, &vports[i]->load_flag))
 			continue;
 
@@ -3409,14 +3410,20 @@ lpfc_sli4_node_prep(struct lpfc_hba *phba)
 					 nlp_listp) {
 			rpi = lpfc_sli4_alloc_rpi(phba);
 			if (rpi == LPFC_RPI_ALLOC_ERROR) {
-				/* TODO print log? */
+				lpfc_printf_vlog(ndlp->vport, KERN_INFO,
+						 LOG_NODE | LOG_DISCOVERY,
+						 "0099 RPI alloc error for "
+						 "ndlp x%px DID:x%06x "
+						 "flg:x%lx\n",
+						 ndlp, ndlp->nlp_DID,
+						 ndlp->nlp_flag);
 				continue;
 			}
 			ndlp->nlp_rpi = rpi;
 			lpfc_printf_vlog(ndlp->vport, KERN_INFO,
 					 LOG_NODE | LOG_DISCOVERY,
 					 "0009 Assign RPI x%x to ndlp x%px "
-					 "DID:x%06x flg:x%x\n",
+					 "DID:x%06x flg:x%lx\n",
 					 ndlp->nlp_rpi, ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag);
 		}
@@ -3820,35 +3827,12 @@ lpfc_offline_prep(struct lpfc_hba *phba, int mbx_action)
 						 &vports[i]->fc_nodes,
 						 nlp_listp) {
 
-				spin_lock_irq(&ndlp->lock);
-				ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-				spin_unlock_irq(&ndlp->lock);
-
+				clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 				if (offline || hba_pci_err) {
-					spin_lock_irq(&ndlp->lock);
-					ndlp->nlp_flag &= ~(NLP_UNREG_INP |
-							    NLP_RPI_REGISTERED);
-					spin_unlock_irq(&ndlp->lock);
-					if (phba->sli_rev == LPFC_SLI_REV4)
-						lpfc_sli_rpi_release(vports[i],
-								     ndlp);
-				} else {
-					lpfc_unreg_rpi(vports[i], ndlp);
-				}
-				/*
-				 * Whenever an SLI4 port goes offline, free the
-				 * RPI. Get a new RPI when the adapter port
-				 * comes back online.
-				 */
-				if (phba->sli_rev == LPFC_SLI_REV4) {
-					lpfc_printf_vlog(vports[i], KERN_INFO,
-						 LOG_NODE | LOG_DISCOVERY,
-						 "0011 Free RPI x%x on "
-						 "ndlp: x%px did x%x\n",
-						 ndlp->nlp_rpi, ndlp,
-						 ndlp->nlp_DID);
-					lpfc_sli4_free_rpi(phba, ndlp->nlp_rpi);
-					ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
+					clear_bit(NLP_UNREG_INP,
+						  &ndlp->nlp_flag);
+					clear_bit(NLP_RPI_REGISTERED,
+						  &ndlp->nlp_flag);
 				}
 
 				if (ndlp->nlp_type & NLP_FABRIC) {
@@ -6925,9 +6909,7 @@ lpfc_sli4_async_fip_evt(struct lpfc_hba *phba,
 			 */
 			mod_timer(&ndlp->nlp_delayfunc,
 				  jiffies + msecs_to_jiffies(1000));
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_DELAY_TMO;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 			ndlp->nlp_last_elscmd = ELS_CMD_FDISC;
 			vport->port_state = LPFC_FDISC;
 		} else {
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 4574716c8764..4d88cfe71cae 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -65,7 +65,7 @@ lpfc_check_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		 struct lpfc_name *nn, struct lpfc_name *pn)
 {
 	/* First, we MUST have a RPI registered */
-	if (!(ndlp->nlp_flag & NLP_RPI_REGISTERED))
+	if (!test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag))
 		return 0;
 
 	/* Compare the ADISC rsp WWNN / WWPN matches our internal node
@@ -239,7 +239,7 @@ lpfc_els_abort(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 	/* Abort outstanding I/O on NPort <nlp_DID> */
 	lpfc_printf_vlog(ndlp->vport, KERN_INFO, LOG_DISCOVERY,
 			 "2819 Abort outstanding I/O on NPort x%x "
-			 "Data: x%x x%x x%x\n",
+			 "Data: x%lx x%x x%x\n",
 			 ndlp->nlp_DID, ndlp->nlp_flag, ndlp->nlp_state,
 			 ndlp->nlp_rpi);
 	/* Clean up all fabric IOs first.*/
@@ -340,7 +340,7 @@ lpfc_defer_plogi_acc(struct lpfc_hba *phba, LPFC_MBOXQ_t *login_mbox)
 
 	/* Now process the REG_RPI cmpl */
 	lpfc_mbx_cmpl_reg_login(phba, login_mbox);
-	ndlp->nlp_flag &= ~NLP_ACC_REGLOGIN;
+	clear_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag);
 	kfree(save_iocb);
 }
 
@@ -404,7 +404,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	/* PLOGI chkparm OK */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-			 "0114 PLOGI chkparm OK Data: x%x x%x x%x "
+			 "0114 PLOGI chkparm OK Data: x%x x%x x%lx "
 			 "x%x x%x x%lx\n",
 			 ndlp->nlp_DID, ndlp->nlp_state, ndlp->nlp_flag,
 			 ndlp->nlp_rpi, vport->port_state,
@@ -429,7 +429,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* if already logged in, do implicit logout */
 	switch (ndlp->nlp_state) {
 	case  NLP_STE_NPR_NODE:
-		if (!(ndlp->nlp_flag & NLP_NPR_ADISC))
+		if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag))
 			break;
 		fallthrough;
 	case  NLP_STE_REG_LOGIN_ISSUE:
@@ -449,7 +449,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			ndlp->nlp_type &= ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
 			ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
 			ndlp->nlp_nvme_info &= ~NLP_NVME_NSLER;
-			ndlp->nlp_flag &= ~NLP_FIRSTBURST;
+			clear_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
 
 			lpfc_els_rsp_acc(vport, ELS_CMD_PLOGI, cmdiocb,
 					 ndlp, NULL);
@@ -480,7 +480,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	ndlp->nlp_type &= ~(NLP_NVME_TARGET | NLP_NVME_INITIATOR);
 	ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
 	ndlp->nlp_nvme_info &= ~NLP_NVME_NSLER;
-	ndlp->nlp_flag &= ~NLP_FIRSTBURST;
+	clear_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
 
 	login_mbox = NULL;
 	link_mbox = NULL;
@@ -552,13 +552,13 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		lpfc_can_disctmo(vport);
 	}
 
-	ndlp->nlp_flag &= ~NLP_SUPPRESS_RSP;
+	clear_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag);
 	if ((phba->sli.sli_flag & LPFC_SLI_SUPPRESS_RSP) &&
 	    sp->cmn.valid_vendor_ver_level) {
 		vid = be32_to_cpu(sp->un.vv.vid);
 		flag = be32_to_cpu(sp->un.vv.flags);
 		if ((vid == LPFC_VV_EMLX_ID) && (flag & LPFC_VV_SUPPRESS_RSP))
-			ndlp->nlp_flag |= NLP_SUPPRESS_RSP;
+			set_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag);
 	}
 
 	login_mbox = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
@@ -627,10 +627,9 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			 * this ELS request. The only way to do this is
 			 * to register, then unregister the RPI.
 			 */
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= (NLP_RM_DFLT_RPI | NLP_ACC_REGLOGIN |
-					   NLP_RCV_PLOGI);
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_RM_DFLT_RPI, &ndlp->nlp_flag);
+			set_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag);
+			set_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag);
 		}
 
 		stat.un.b.lsRjtRsnCode = LSRJT_INVALID_CMD;
@@ -665,9 +664,8 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	login_mbox->ctx_u.save_iocb = save_iocb; /* For PLOGI ACC */
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= (NLP_ACC_REGLOGIN | NLP_RCV_PLOGI);
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag);
+	set_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag);
 
 	/* Start the ball rolling by issuing REG_LOGIN here */
 	rc = lpfc_sli_issue_mbox(phba, login_mbox, MBX_NOWAIT);
@@ -797,7 +795,7 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		 */
 		if (ndlp->nlp_type & (NLP_FCP_TARGET | NLP_NVME_TARGET)) {
 			if ((ndlp->nlp_state != NLP_STE_MAPPED_NODE) &&
-			    !(ndlp->nlp_flag & NLP_NPR_ADISC))
+			    !test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag))
 				lpfc_nlp_set_state(vport, ndlp,
 						   NLP_STE_MAPPED_NODE);
 		}
@@ -814,9 +812,7 @@ lpfc_rcv_padisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* 1 sec timeout */
 	mod_timer(&ndlp->nlp_delayfunc, jiffies + msecs_to_jiffies(1000));
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 	ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 	ndlp->nlp_prev_state = ndlp->nlp_state;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
@@ -835,9 +831,7 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* Only call LOGO ACC for first LOGO, this avoids sending unnecessary
 	 * PLOGIs during LOGO storms from a device.
 	 */
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	if (els_cmd == ELS_CMD_PRLO)
 		lpfc_els_rsp_acc(vport, ELS_CMD_PRLO, cmdiocb, ndlp, NULL);
 	else
@@ -890,9 +884,7 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			 */
 			mod_timer(&ndlp->nlp_delayfunc,
 				  jiffies + msecs_to_jiffies(1000));
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_DELAY_TMO;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 			ndlp->nlp_last_elscmd = ELS_CMD_FDISC;
 			vport->port_state = LPFC_FDISC;
 		} else {
@@ -915,14 +907,12 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		     ndlp->nlp_state <= NLP_STE_PRLI_ISSUE)) {
 			mod_timer(&ndlp->nlp_delayfunc,
 				  jiffies + msecs_to_jiffies(1000 * 1));
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_DELAY_TMO;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 			ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 			lpfc_printf_vlog(vport, KERN_INFO,
 					 LOG_NODE | LOG_ELS | LOG_DISCOVERY,
 					 "3204 Start nlpdelay on DID x%06x "
-					 "nflag x%x lastels x%x ref cnt %u",
+					 "nflag x%lx lastels x%x ref cnt %u",
 					 ndlp->nlp_DID, ndlp->nlp_flag,
 					 ndlp->nlp_last_elscmd,
 					 kref_read(&ndlp->kref));
@@ -935,9 +925,7 @@ lpfc_rcv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	ndlp->nlp_prev_state = ndlp->nlp_state;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 	/* The driver has to wait until the ACC completes before it continues
 	 * processing the LOGO.  The action will resume in
 	 * lpfc_cmpl_els_logo_acc routine. Since part of processing includes an
@@ -978,7 +966,7 @@ lpfc_rcv_prli_support_check(struct lpfc_vport *vport,
 out:
 	lpfc_printf_vlog(vport, KERN_WARNING, LOG_DISCOVERY,
 			 "6115 Rcv PRLI (%x) check failed: ndlp rpi %d "
-			 "state x%x flags x%x port_type: x%x "
+			 "state x%x flags x%lx port_type: x%x "
 			 "npr->initfcn: x%x npr->tgtfcn: x%x\n",
 			 cmd, ndlp->nlp_rpi, ndlp->nlp_state,
 			 ndlp->nlp_flag, vport->port_type,
@@ -1020,7 +1008,7 @@ lpfc_rcv_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			if (npr->prliType == PRLI_NVME_TYPE)
 				ndlp->nlp_type |= NLP_NVME_TARGET;
 			if (npr->writeXferRdyDis)
-				ndlp->nlp_flag |= NLP_FIRSTBURST;
+				set_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
 		}
 		if (npr->Retry && ndlp->nlp_type &
 					(NLP_FCP_INITIATOR | NLP_FCP_TARGET))
@@ -1057,7 +1045,7 @@ lpfc_rcv_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			roles |= FC_RPORT_ROLE_FCP_TARGET;
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_RPORT,
-			"rport rolechg:   role:x%x did:x%x flg:x%x",
+			"rport rolechg:   role:x%x did:x%x flg:x%lx",
 			roles, ndlp->nlp_DID, ndlp->nlp_flag);
 
 		if (vport->cfg_enable_fc4_type != LPFC_ENABLE_NVME)
@@ -1068,10 +1056,8 @@ lpfc_rcv_prli(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 static uint32_t
 lpfc_disc_set_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 {
-	if (!(ndlp->nlp_flag & NLP_RPI_REGISTERED)) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-		spin_unlock_irq(&ndlp->lock);
+	if (!test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag)) {
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 		return 0;
 	}
 
@@ -1081,16 +1067,12 @@ lpfc_disc_set_adisc(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 		    (test_bit(FC_RSCN_MODE, &vport->fc_flag) ||
 		    ((ndlp->nlp_fcp_info & NLP_FCP_2_DEVICE) &&
 		     (ndlp->nlp_type & NLP_FCP_TARGET)))) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag |= NLP_NPR_ADISC;
-			spin_unlock_irq(&ndlp->lock);
+			set_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 			return 1;
 		}
 	}
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 	lpfc_unreg_rpi(vport, ndlp);
 	return 0;
 }
@@ -1115,10 +1097,10 @@ lpfc_release_rpi(struct lpfc_hba *phba, struct lpfc_vport *vport,
 	/* If there is already an UNREG in progress for this ndlp,
 	 * no need to queue up another one.
 	 */
-	if (ndlp->nlp_flag & NLP_UNREG_INP) {
+	if (test_bit(NLP_UNREG_INP, &ndlp->nlp_flag)) {
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "1435 release_rpi SKIP UNREG x%x on "
-				 "NPort x%x deferred x%x  flg x%x "
+				 "NPort x%x deferred x%x  flg x%lx "
 				 "Data: x%px\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID,
 				 ndlp->nlp_defer_did,
@@ -1143,11 +1125,11 @@ lpfc_release_rpi(struct lpfc_hba *phba, struct lpfc_vport *vport,
 
 		if (((ndlp->nlp_DID & Fabric_DID_MASK) != Fabric_DID_MASK) &&
 		    (!test_bit(FC_OFFLINE_MODE, &vport->fc_flag)))
-			ndlp->nlp_flag |= NLP_UNREG_INP;
+			set_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 				 "1437 release_rpi UNREG x%x "
-				 "on NPort x%x flg x%x\n",
+				 "on NPort x%x flg x%lx\n",
 				 ndlp->nlp_rpi, ndlp->nlp_DID, ndlp->nlp_flag);
 
 		rc = lpfc_sli_issue_mbox(phba, pmb, MBX_NOWAIT);
@@ -1175,7 +1157,7 @@ lpfc_disc_illegal(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	}
 	lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			 "0271 Illegal State Transition: node x%x "
-			 "event x%x, state x%x Data: x%x x%x\n",
+			 "event x%x, state x%x Data: x%x x%lx\n",
 			 ndlp->nlp_DID, evt, ndlp->nlp_state, ndlp->nlp_rpi,
 			 ndlp->nlp_flag);
 	return ndlp->nlp_state;
@@ -1190,13 +1172,12 @@ lpfc_cmpl_plogi_illegal(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * working on the same NPortID, do nothing for this thread
 	 * to stop it.
 	 */
-	if (!(ndlp->nlp_flag & NLP_RCV_PLOGI)) {
+	if (!test_bit(NLP_RCV_PLOGI, &ndlp->nlp_flag))
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0272 Illegal State Transition: node x%x "
-				 "event x%x, state x%x Data: x%x x%x\n",
+				 "event x%x, state x%x Data: x%x x%lx\n",
 				  ndlp->nlp_DID, evt, ndlp->nlp_state,
 				  ndlp->nlp_rpi, ndlp->nlp_flag);
-	}
 	return ndlp->nlp_state;
 }
 
@@ -1230,9 +1211,7 @@ lpfc_rcv_logo_unused_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	struct lpfc_iocbq *cmdiocb = (struct lpfc_iocbq *) arg;
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
 
 	return ndlp->nlp_state;
@@ -1290,11 +1269,9 @@ lpfc_rcv_plogi_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			NULL);
 	} else {
 		if (lpfc_rcv_plogi(vport, ndlp, cmdiocb) &&
-		    (ndlp->nlp_flag & NLP_NPR_2B_DISC) &&
-		    (vport->num_disc_nodes)) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+		    test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag) &&
+		    vport->num_disc_nodes) {
+			clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 			/* Check if there are more PLOGIs to be sent */
 			lpfc_more_plogi(vport);
 			if (vport->num_disc_nodes == 0) {
@@ -1356,9 +1333,7 @@ lpfc_rcv_els_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	/* Put ndlp in npr state set plogi timer for 1 sec */
 	mod_timer(&ndlp->nlp_delayfunc, jiffies + msecs_to_jiffies(1000 * 1));
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_DELAY_TMO;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 	ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 	ndlp->nlp_prev_state = NLP_STE_PLOGI_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
@@ -1389,7 +1364,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 
 	ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (ndlp->nlp_flag & NLP_ACC_REGLOGIN) {
+	if (test_bit(NLP_ACC_REGLOGIN, &ndlp->nlp_flag)) {
 		/* Recovery from PLOGI collision logic */
 		return ndlp->nlp_state;
 	}
@@ -1418,7 +1393,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 		goto out;
 	/* PLOGI chkparm OK */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
-			 "0121 PLOGI chkparm OK Data: x%x x%x x%x x%x\n",
+			 "0121 PLOGI chkparm OK Data: x%x x%x x%lx x%x\n",
 			 ndlp->nlp_DID, ndlp->nlp_state,
 			 ndlp->nlp_flag, ndlp->nlp_rpi);
 	if (vport->cfg_fcp_class == 2 && (sp->cls2.classValid))
@@ -1446,14 +1421,14 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 			ed_tov = (phba->fc_edtov + 999999) / 1000000;
 		}
 
-		ndlp->nlp_flag &= ~NLP_SUPPRESS_RSP;
+		clear_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag);
 		if ((phba->sli.sli_flag & LPFC_SLI_SUPPRESS_RSP) &&
 		    sp->cmn.valid_vendor_ver_level) {
 			vid = be32_to_cpu(sp->un.vv.vid);
 			flag = be32_to_cpu(sp->un.vv.flags);
 			if ((vid == LPFC_VV_EMLX_ID) &&
 			    (flag & LPFC_VV_SUPPRESS_RSP))
-				ndlp->nlp_flag |= NLP_SUPPRESS_RSP;
+				set_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag);
 		}
 
 		/*
@@ -1476,7 +1451,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 						 LOG_TRACE_EVENT,
 						 "0133 PLOGI: no memory "
 						 "for config_link "
-						 "Data: x%x x%x x%x x%x\n",
+						 "Data: x%x x%x x%lx x%x\n",
 						 ndlp->nlp_DID, ndlp->nlp_state,
 						 ndlp->nlp_flag, ndlp->nlp_rpi);
 				goto out;
@@ -1500,7 +1475,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 	if (!mbox) {
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0018 PLOGI: no memory for reg_login "
-				 "Data: x%x x%x x%x x%x\n",
+				 "Data: x%x x%x x%lx x%x\n",
 				 ndlp->nlp_DID, ndlp->nlp_state,
 				 ndlp->nlp_flag, ndlp->nlp_rpi);
 		goto out;
@@ -1520,7 +1495,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 			mbox->mbox_cmpl = lpfc_mbx_cmpl_fdmi_reg_login;
 			break;
 		default:
-			ndlp->nlp_flag |= NLP_REG_LOGIN_SEND;
+			set_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 			mbox->mbox_cmpl = lpfc_mbx_cmpl_reg_login;
 		}
 
@@ -1535,8 +1510,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 					   NLP_STE_REG_LOGIN_ISSUE);
 			return ndlp->nlp_state;
 		}
-		if (ndlp->nlp_flag & NLP_REG_LOGIN_SEND)
-			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+		clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 		/* decrement node reference count to the failed mbox
 		 * command
 		 */
@@ -1544,7 +1518,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 		lpfc_mbox_rsrc_cleanup(phba, mbox, MBOX_THD_UNLOCKED);
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0134 PLOGI: cannot issue reg_login "
-				 "Data: x%x x%x x%x x%x\n",
+				 "Data: x%x x%x x%lx x%x\n",
 				 ndlp->nlp_DID, ndlp->nlp_state,
 				 ndlp->nlp_flag, ndlp->nlp_rpi);
 	} else {
@@ -1552,7 +1526,7 @@ lpfc_cmpl_plogi_plogi_issue(struct lpfc_vport *vport,
 
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 				 "0135 PLOGI: cannot format reg_login "
-				 "Data: x%x x%x x%x x%x\n",
+				 "Data: x%x x%x x%lx x%x\n",
 				 ndlp->nlp_DID, ndlp->nlp_state,
 				 ndlp->nlp_flag, ndlp->nlp_rpi);
 	}
@@ -1605,18 +1579,15 @@ static uint32_t
 lpfc_device_rm_plogi_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			   void *arg, uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
-	} else {
-		/* software abort outstanding PLOGI */
-		lpfc_els_abort(vport->phba, ndlp);
-
-		lpfc_drop_node(vport, ndlp);
-		return NLP_STE_FREED_NODE;
 	}
+	/* software abort outstanding PLOGI */
+	lpfc_els_abort(vport->phba, ndlp);
+
+	lpfc_drop_node(vport, ndlp);
+	return NLP_STE_FREED_NODE;
 }
 
 static uint32_t
@@ -1636,9 +1607,8 @@ lpfc_device_recov_plogi_issue(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_PLOGI_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 
 	return ndlp->nlp_state;
 }
@@ -1656,10 +1626,7 @@ lpfc_rcv_plogi_adisc_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	cmdiocb = (struct lpfc_iocbq *) arg;
 
 	if (lpfc_rcv_plogi(vport, ndlp, cmdiocb)) {
-		if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-			spin_lock_irq(&ndlp->lock);
-			ndlp->nlp_flag &= ~NLP_NPR_2B_DISC;
-			spin_unlock_irq(&ndlp->lock);
+		if (test_and_clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
 			if (vport->num_disc_nodes)
 				lpfc_more_adisc(vport);
 		}
@@ -1748,9 +1715,7 @@ lpfc_cmpl_adisc_adisc_issue(struct lpfc_vport *vport,
 		/* 1 sec timeout */
 		mod_timer(&ndlp->nlp_delayfunc,
 			  jiffies + msecs_to_jiffies(1000));
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_DELAY_TMO;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 		ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 
 		ndlp->nlp_prev_state = NLP_STE_ADISC_ISSUE;
@@ -1789,18 +1754,15 @@ static uint32_t
 lpfc_device_rm_adisc_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			   void *arg, uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
-	} else {
-		/* software abort outstanding ADISC */
-		lpfc_els_abort(vport->phba, ndlp);
-
-		lpfc_drop_node(vport, ndlp);
-		return NLP_STE_FREED_NODE;
 	}
+	/* software abort outstanding ADISC */
+	lpfc_els_abort(vport->phba, ndlp);
+
+	lpfc_drop_node(vport, ndlp);
+	return NLP_STE_FREED_NODE;
 }
 
 static uint32_t
@@ -1820,9 +1782,8 @@ lpfc_device_recov_adisc_issue(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_ADISC_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	lpfc_disc_set_adisc(vport, ndlp);
 	return ndlp->nlp_state;
 }
@@ -1856,7 +1817,7 @@ lpfc_rcv_prli_reglogin_issue(struct lpfc_vport *vport,
 		 * transition to UNMAPPED provided the RPI has completed
 		 * registration.
 		 */
-		if (ndlp->nlp_flag & NLP_RPI_REGISTERED) {
+		if (test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag)) {
 			lpfc_rcv_prli(vport, ndlp, cmdiocb);
 			lpfc_els_rsp_prli_acc(vport, cmdiocb, ndlp);
 		} else {
@@ -1895,7 +1856,7 @@ lpfc_rcv_logo_reglogin_issue(struct lpfc_vport *vport,
 	if ((mb = phba->sli.mbox_active)) {
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
 		   (ndlp == mb->ctx_ndlp)) {
-			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+			clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 			lpfc_nlp_put(ndlp);
 			mb->ctx_ndlp = NULL;
 			mb->mbox_cmpl = lpfc_sli_def_mbox_cmpl;
@@ -1906,7 +1867,7 @@ lpfc_rcv_logo_reglogin_issue(struct lpfc_vport *vport,
 	list_for_each_entry_safe(mb, nextmb, &phba->sli.mboxq, list) {
 		if ((mb->u.mb.mbxCommand == MBX_REG_LOGIN64) &&
 		   (ndlp == mb->ctx_ndlp)) {
-			ndlp->nlp_flag &= ~NLP_REG_LOGIN_SEND;
+			clear_bit(NLP_REG_LOGIN_SEND, &ndlp->nlp_flag);
 			lpfc_nlp_put(ndlp);
 			list_del(&mb->list);
 			phba->sli.mboxq_cnt--;
@@ -1976,9 +1937,7 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
 		/* Put ndlp in npr state set plogi timer for 1 sec */
 		mod_timer(&ndlp->nlp_delayfunc,
 			  jiffies + msecs_to_jiffies(1000 * 1));
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_DELAY_TMO;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
 		ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 
 		lpfc_issue_els_logo(vport, ndlp, 0);
@@ -1989,7 +1948,7 @@ lpfc_cmpl_reglogin_reglogin_issue(struct lpfc_vport *vport,
 	if (phba->sli_rev < LPFC_SLI_REV4)
 		ndlp->nlp_rpi = mb->un.varWords[0];
 
-	ndlp->nlp_flag |= NLP_RPI_REGISTERED;
+	set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
 
 	/* Only if we are not a fabric nport do we issue PRLI */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
@@ -2061,15 +2020,12 @@ lpfc_device_rm_reglogin_issue(struct lpfc_vport *vport,
 			      void *arg,
 			      uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
-	} else {
-		lpfc_drop_node(vport, ndlp);
-		return NLP_STE_FREED_NODE;
 	}
+	lpfc_drop_node(vport, ndlp);
+	return NLP_STE_FREED_NODE;
 }
 
 static uint32_t
@@ -2084,17 +2040,16 @@ lpfc_device_recov_reglogin_issue(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_REG_LOGIN_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
 
 	/* If we are a target we won't immediately transition into PRLI,
 	 * so if REG_LOGIN already completed we don't need to ignore it.
 	 */
-	if (!(ndlp->nlp_flag & NLP_RPI_REGISTERED) ||
+	if (!test_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag) ||
 	    !vport->phba->nvmet_support)
-		ndlp->nlp_flag |= NLP_IGNR_REG_CMPL;
+		set_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag);
 
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	lpfc_disc_set_adisc(vport, ndlp);
 	return ndlp->nlp_state;
 }
@@ -2228,7 +2183,8 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			if (npr->targetFunc) {
 				ndlp->nlp_type |= NLP_FCP_TARGET;
 				if (npr->writeXferRdyDis)
-					ndlp->nlp_flag |= NLP_FIRSTBURST;
+					set_bit(NLP_FIRSTBURST,
+						&ndlp->nlp_flag);
 			}
 			if (npr->Retry)
 				ndlp->nlp_fcp_info |= NLP_FCP_2_DEVICE;
@@ -2272,7 +2228,7 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 				/* Both sides support FB. The target's first
 				 * burst size is a 512 byte encoded value.
 				 */
-				ndlp->nlp_flag |= NLP_FIRSTBURST;
+				set_bit(NLP_FIRSTBURST, &ndlp->nlp_flag);
 				ndlp->nvme_fb_size = bf_get_be32(prli_fb_sz,
 								 nvpr);
 
@@ -2287,7 +2243,7 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME_DISC,
 				 "6029 NVME PRLI Cmpl w1 x%08x "
-				 "w4 x%08x w5 x%08x flag x%x, "
+				 "w4 x%08x w5 x%08x flag x%lx, "
 				 "fcp_info x%x nlp_type x%x\n",
 				 be32_to_cpu(nvpr->word1),
 				 be32_to_cpu(nvpr->word4),
@@ -2299,9 +2255,7 @@ lpfc_cmpl_prli_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	    (vport->port_type == LPFC_NPIV_PORT) &&
 	     vport->cfg_restrict_login) {
 out:
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_TARGET_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_TARGET_REMOVE, &ndlp->nlp_flag);
 		lpfc_issue_els_logo(vport, ndlp, 0);
 
 		ndlp->nlp_prev_state = NLP_STE_PRLI_ISSUE;
@@ -2353,18 +2307,15 @@ static uint32_t
 lpfc_device_rm_prli_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			  void *arg, uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
-	} else {
-		/* software abort outstanding PLOGI */
-		lpfc_els_abort(vport->phba, ndlp);
-
-		lpfc_drop_node(vport, ndlp);
-		return NLP_STE_FREED_NODE;
 	}
+	/* software abort outstanding PLOGI */
+	lpfc_els_abort(vport->phba, ndlp);
+
+	lpfc_drop_node(vport, ndlp);
+	return NLP_STE_FREED_NODE;
 }
 
 
@@ -2401,9 +2352,8 @@ lpfc_device_recov_prli_issue(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_PRLI_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	lpfc_disc_set_adisc(vport, ndlp);
 	return ndlp->nlp_state;
 }
@@ -2442,9 +2392,7 @@ lpfc_rcv_logo_logo_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	struct lpfc_iocbq *cmdiocb = (struct lpfc_iocbq *)arg;
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
 	return ndlp->nlp_state;
 }
@@ -2483,9 +2431,8 @@ lpfc_cmpl_logo_logo_issue(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	ndlp->nlp_prev_state = NLP_STE_LOGO_ISSUE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
-	spin_unlock_irq(&ndlp->lock);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	lpfc_disc_set_adisc(vport, ndlp);
 	return ndlp->nlp_state;
 }
@@ -2591,8 +2538,9 @@ lpfc_device_recov_unmap_node(struct lpfc_vport *vport,
 {
 	ndlp->nlp_prev_state = NLP_STE_UNMAPPED_NODE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
 	ndlp->nlp_fc4_type &= ~(NLP_FC4_FCP | NLP_FC4_NVME);
 	spin_unlock_irq(&ndlp->lock);
 	lpfc_disc_set_adisc(vport, ndlp);
@@ -2653,9 +2601,7 @@ lpfc_rcv_prlo_mapped_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	lpfc_sli_abort_iocb(vport, ndlp->nlp_sid, 0, LPFC_CTX_TGT);
 
 	/* Send PRLO_ACC */
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 	lpfc_els_rsp_acc(vport, ELS_CMD_PRLO, cmdiocb, ndlp, NULL);
 
 	/* Save ELS_CMD_PRLO as the last elscmd and then set to NPR.
@@ -2665,7 +2611,7 @@ lpfc_rcv_prlo_mapped_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	ndlp->nlp_prev_state = ndlp->nlp_state;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE | LOG_ELS | LOG_DISCOVERY,
-			 "3422 DID x%06x nflag x%x lastels x%x ref cnt %u\n",
+			 "3422 DID x%06x nflag x%lx lastels x%x ref cnt %u\n",
 			 ndlp->nlp_DID, ndlp->nlp_flag,
 			 ndlp->nlp_last_elscmd,
 			 kref_read(&ndlp->kref));
@@ -2685,8 +2631,9 @@ lpfc_device_recov_mapped_node(struct lpfc_vport *vport,
 
 	ndlp->nlp_prev_state = NLP_STE_MAPPED_NODE;
 	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
 	ndlp->nlp_fc4_type &= ~(NLP_FC4_FCP | NLP_FC4_NVME);
 	spin_unlock_irq(&ndlp->lock);
 	return ndlp->nlp_state;
@@ -2699,16 +2646,16 @@ lpfc_rcv_plogi_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	struct lpfc_iocbq *cmdiocb  = (struct lpfc_iocbq *) arg;
 
 	/* Ignore PLOGI if we have an outstanding LOGO */
-	if (ndlp->nlp_flag & (NLP_LOGO_SND | NLP_LOGO_ACC))
+	if (test_bit(NLP_LOGO_SND, &ndlp->nlp_flag) ||
+	    test_bit(NLP_LOGO_ACC, &ndlp->nlp_flag))
 		return ndlp->nlp_state;
 	if (lpfc_rcv_plogi(vport, ndlp, cmdiocb)) {
 		lpfc_cancel_retry_delay_tmo(vport, ndlp);
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~(NLP_NPR_ADISC | NLP_NPR_2B_DISC);
-		spin_unlock_irq(&ndlp->lock);
-	} else if (!(ndlp->nlp_flag & NLP_NPR_2B_DISC)) {
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
+		clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
+	} else if (!test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
 		/* send PLOGI immediately, move to PLOGI issue state */
-		if (!(ndlp->nlp_flag & NLP_DELAY_TMO)) {
+		if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag)) {
 			ndlp->nlp_prev_state = NLP_STE_NPR_NODE;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -2729,14 +2676,14 @@ lpfc_rcv_prli_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	stat.un.b.lsRjtRsnCodeExp = LSEXP_NOTHING_MORE;
 	lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb, ndlp, NULL);
 
-	if (!(ndlp->nlp_flag & NLP_DELAY_TMO)) {
+	if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag)) {
 		/*
 		 * ADISC nodes will be handled in regular discovery path after
 		 * receiving response from NS.
 		 *
 		 * For other nodes, Send PLOGI to trigger an implicit LOGO.
 		 */
-		if (!(ndlp->nlp_flag & NLP_NPR_ADISC)) {
+		if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 			ndlp->nlp_prev_state = NLP_STE_NPR_NODE;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -2767,15 +2714,15 @@ lpfc_rcv_padisc_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	 * or discovery in progress for this node. Starting discovery
 	 * here will affect the counting of discovery threads.
 	 */
-	if (!(ndlp->nlp_flag & NLP_DELAY_TMO) &&
-	    !(ndlp->nlp_flag & NLP_NPR_2B_DISC)) {
+	if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag) &&
+	    !test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
 		/*
 		 * ADISC nodes will be handled in regular discovery path after
 		 * receiving response from NS.
 		 *
 		 * For other nodes, Send PLOGI to trigger an implicit LOGO.
 		 */
-		if (!(ndlp->nlp_flag & NLP_NPR_ADISC)) {
+		if (!test_bit(NLP_NPR_ADISC, &ndlp->nlp_flag)) {
 			ndlp->nlp_prev_state = NLP_STE_NPR_NODE;
 			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
 			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
@@ -2790,24 +2737,18 @@ lpfc_rcv_prlo_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 {
 	struct lpfc_iocbq *cmdiocb = (struct lpfc_iocbq *) arg;
 
-	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag |= NLP_LOGO_ACC;
-	spin_unlock_irq(&ndlp->lock);
+	set_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 
 	lpfc_els_rsp_acc(vport, ELS_CMD_ACC, cmdiocb, ndlp, NULL);
 
-	if ((ndlp->nlp_flag & NLP_DELAY_TMO) == 0) {
+	if (!test_bit(NLP_DELAY_TMO, &ndlp->nlp_flag)) {
 		mod_timer(&ndlp->nlp_delayfunc,
 			  jiffies + msecs_to_jiffies(1000 * 1));
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_DELAY_TMO;
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-		spin_unlock_irq(&ndlp->lock);
+		set_bit(NLP_DELAY_TMO, &ndlp->nlp_flag);
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 		ndlp->nlp_last_elscmd = ELS_CMD_PLOGI;
 	} else {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag &= ~NLP_NPR_ADISC;
-		spin_unlock_irq(&ndlp->lock);
+		clear_bit(NLP_NPR_ADISC, &ndlp->nlp_flag);
 	}
 	return ndlp->nlp_state;
 }
@@ -2844,7 +2785,7 @@ lpfc_cmpl_prli_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (ulp_status && (ndlp->nlp_flag & NLP_NODEV_REMOVE)) {
+	if (ulp_status && test_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag)) {
 		lpfc_drop_node(vport, ndlp);
 		return NLP_STE_FREED_NODE;
 	}
@@ -2877,7 +2818,7 @@ lpfc_cmpl_adisc_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 
 	ulp_status = get_job_ulpstatus(phba, rspiocb);
 
-	if (ulp_status && (ndlp->nlp_flag & NLP_NODEV_REMOVE)) {
+	if (ulp_status && test_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag)) {
 		lpfc_drop_node(vport, ndlp);
 		return NLP_STE_FREED_NODE;
 	}
@@ -2896,12 +2837,11 @@ lpfc_cmpl_reglogin_npr_node(struct lpfc_vport *vport,
 		/* SLI4 ports have preallocated logical rpis. */
 		if (vport->phba->sli_rev < LPFC_SLI_REV4)
 			ndlp->nlp_rpi = mb->un.varWords[0];
-		ndlp->nlp_flag |= NLP_RPI_REGISTERED;
-		if (ndlp->nlp_flag & NLP_LOGO_ACC) {
+		set_bit(NLP_RPI_REGISTERED, &ndlp->nlp_flag);
+		if (test_bit(NLP_LOGO_ACC, &ndlp->nlp_flag))
 			lpfc_unreg_rpi(vport, ndlp);
-		}
 	} else {
-		if (ndlp->nlp_flag & NLP_NODEV_REMOVE) {
+		if (test_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag)) {
 			lpfc_drop_node(vport, ndlp);
 			return NLP_STE_FREED_NODE;
 		}
@@ -2913,10 +2853,8 @@ static uint32_t
 lpfc_device_rm_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			void *arg, uint32_t evt)
 {
-	if (ndlp->nlp_flag & NLP_NPR_2B_DISC) {
-		spin_lock_irq(&ndlp->lock);
-		ndlp->nlp_flag |= NLP_NODEV_REMOVE;
-		spin_unlock_irq(&ndlp->lock);
+	if (test_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag)) {
+		set_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
 		return ndlp->nlp_state;
 	}
 	lpfc_drop_node(vport, ndlp);
@@ -2932,8 +2870,9 @@ lpfc_device_recov_npr_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		return ndlp->nlp_state;
 
 	lpfc_cancel_retry_delay_tmo(vport, ndlp);
+	clear_bit(NLP_NODEV_REMOVE, &ndlp->nlp_flag);
+	clear_bit(NLP_NPR_2B_DISC, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~(NLP_NODEV_REMOVE | NLP_NPR_2B_DISC);
 	ndlp->nlp_fc4_type &= ~(NLP_FC4_FCP | NLP_FC4_NVME);
 	spin_unlock_irq(&ndlp->lock);
 	return ndlp->nlp_state;
@@ -3146,7 +3085,7 @@ lpfc_disc_state_machine(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* DSM in event <evt> on NPort <nlp_DID> in state <cur_state> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 			 "0211 DSM in event x%x on NPort x%x in "
-			 "state %d rpi x%x Data: x%x x%x\n",
+			 "state %d rpi x%x Data: x%lx x%x\n",
 			 evt, ndlp->nlp_DID, cur_state, ndlp->nlp_rpi,
 			 ndlp->nlp_flag, data1);
 
@@ -3163,12 +3102,12 @@ lpfc_disc_state_machine(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			((uint32_t)ndlp->nlp_type));
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
 			 "0212 DSM out state %d on NPort x%x "
-			 "rpi x%x Data: x%x x%x\n",
+			 "rpi x%x Data: x%lx x%x\n",
 			 rc, ndlp->nlp_DID, ndlp->nlp_rpi, ndlp->nlp_flag,
 			 data1);
 
 		lpfc_debugfs_disc_trc(vport, LPFC_DISC_TRC_DSM,
-			"DSM out:         ste:%d did:x%x flg:x%x",
+			"DSM out:         ste:%d did:x%x flg:x%lx",
 			rc, ndlp->nlp_DID, ndlp->nlp_flag);
 		/* Decrement the ndlp reference count held for this function */
 		lpfc_nlp_put(ndlp);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index fec23c723730..e9d9884830f3 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1232,7 +1232,7 @@ lpfc_nvme_prep_io_cmd(struct lpfc_vport *vport,
 
 			/* Word 5 */
 			if ((phba->cfg_nvme_enable_fb) &&
-			    (pnode->nlp_flag & NLP_FIRSTBURST)) {
+			    test_bit(NLP_FIRSTBURST, &pnode->nlp_flag)) {
 				req_len = lpfc_ncmd->nvmeCmd->payload_length;
 				if (req_len < pnode->nvme_fb_size)
 					wqe->fcp_iwrite.initial_xfer_len =
@@ -2644,14 +2644,11 @@ lpfc_nvme_unregister_port(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 				 * reference. Check if another thread has set
 				 * NLP_DROPPED.
 				 */
-				spin_lock_irq(&ndlp->lock);
-				if (!(ndlp->nlp_flag & NLP_DROPPED)) {
-					ndlp->nlp_flag |= NLP_DROPPED;
-					spin_unlock_irq(&ndlp->lock);
+				if (!test_and_set_bit(NLP_DROPPED,
+						      &ndlp->nlp_flag)) {
 					lpfc_nlp_put(ndlp);
 					return;
 				}
-				spin_unlock_irq(&ndlp->lock);
 			}
 		}
 	}
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 55c3e2c2bf8f..e6c9112a8862 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -2854,7 +2854,7 @@ lpfc_nvmet_prep_fcp_wqe(struct lpfc_hba *phba,
 			/* In template ar=1 wqes=0 sup=0 irsp=0 irsplen=0 */
 
 			if (rsp->rsplen == LPFC_NVMET_SUCCESS_LEN) {
-				if (ndlp->nlp_flag & NLP_SUPPRESS_RSP)
+				if (test_bit(NLP_SUPPRESS_RSP, &ndlp->nlp_flag))
 					bf_set(wqe_sup,
 					       &wqe->fcp_tsend.wqe_com, 1);
 			} else {
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 11c974bffa72..905026a4782c 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -4629,7 +4629,7 @@ static int lpfc_scsi_prep_cmnd_buf_s3(struct lpfc_vport *vport,
 			iocb_cmd->ulpCommand = CMD_FCP_IWRITE64_CR;
 			iocb_cmd->ulpPU = PARM_READ_CHECK;
 			if (vport->cfg_first_burst_size &&
-			    (pnode->nlp_flag & NLP_FIRSTBURST)) {
+			    test_bit(NLP_FIRSTBURST, &pnode->nlp_flag)) {
 				u32 xrdy_len;
 
 				fcpdl = scsi_bufflen(scsi_cmnd);
@@ -5829,7 +5829,7 @@ lpfc_send_taskmgmt(struct lpfc_vport *vport, struct fc_rport *rport,
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_FCP,
 			 "0702 Issue %s to TGT %d LUN %llu "
-			 "rpi x%x nlp_flag x%x Data: x%x x%x\n",
+			 "rpi x%x nlp_flag x%lx Data: x%x x%x\n",
 			 lpfc_taskmgmt_name(task_mgmt_cmd), tgt_id, lun_id,
 			 pnode->nlp_rpi, pnode->nlp_flag, iocbq->sli4_xritag,
 			 iocbq->cmd_flag);
@@ -6094,8 +6094,8 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 		lpfc_printf_vlog(vport, KERN_ERR, LOG_TRACE_EVENT,
 			"0722 Target Reset rport failure: rdata x%px\n", rdata);
 		if (pnode) {
+			clear_bit(NLP_NPR_ADISC, &pnode->nlp_flag);
 			spin_lock_irqsave(&pnode->lock, flags);
-			pnode->nlp_flag &= ~NLP_NPR_ADISC;
 			pnode->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
 			spin_unlock_irqrestore(&pnode->lock, flags);
 		}
@@ -6124,7 +6124,7 @@ lpfc_target_reset_handler(struct scsi_cmnd *cmnd)
 		    !pnode->logo_waitq) {
 			pnode->logo_waitq = &waitq;
 			pnode->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-			pnode->nlp_flag |= NLP_ISSUE_LOGO;
+			set_bit(NLP_ISSUE_LOGO, &pnode->nlp_flag);
 			pnode->save_flags |= NLP_WAIT_FOR_LOGO;
 			spin_unlock_irqrestore(&pnode->lock, flags);
 			lpfc_unreg_rpi(vport, pnode);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 4dccbaeb6328..c4acf594286e 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2842,27 +2842,6 @@ lpfc_sli_wake_mbox_wait(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmboxq)
 	return;
 }
 
-static void
-__lpfc_sli_rpi_release(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
-{
-	unsigned long iflags;
-
-	if (ndlp->nlp_flag & NLP_RELEASE_RPI) {
-		lpfc_sli4_free_rpi(vport->phba, ndlp->nlp_rpi);
-		spin_lock_irqsave(&ndlp->lock, iflags);
-		ndlp->nlp_flag &= ~NLP_RELEASE_RPI;
-		ndlp->nlp_rpi = LPFC_RPI_ALLOC_ERROR;
-		spin_unlock_irqrestore(&ndlp->lock, iflags);
-	}
-	ndlp->nlp_flag &= ~NLP_UNREG_INP;
-}
-
-void
-lpfc_sli_rpi_release(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
-{
-	__lpfc_sli_rpi_release(vport, ndlp);
-}
-
 /**
  * lpfc_sli_def_mbox_cmpl - Default mailbox completion handler
  * @phba: Pointer to HBA context object.
@@ -2932,18 +2911,18 @@ lpfc_sli_def_mbox_cmpl(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 				vport,
 				KERN_INFO, LOG_MBOX | LOG_DISCOVERY,
 				"1438 UNREG cmpl deferred mbox x%x "
-				"on NPort x%x Data: x%x x%x x%px x%lx x%x\n",
+				"on NPort x%x Data: x%lx x%x x%px x%lx x%x\n",
 				ndlp->nlp_rpi, ndlp->nlp_DID,
 				ndlp->nlp_flag, ndlp->nlp_defer_did,
 				ndlp, vport->load_flag, kref_read(&ndlp->kref));
 
-			if ((ndlp->nlp_flag & NLP_UNREG_INP) &&
-			    (ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING)) {
-				ndlp->nlp_flag &= ~NLP_UNREG_INP;
+			if (test_bit(NLP_UNREG_INP, &ndlp->nlp_flag) &&
+			    ndlp->nlp_defer_did != NLP_EVT_NOTHING_PENDING) {
+				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 				ndlp->nlp_defer_did = NLP_EVT_NOTHING_PENDING;
 				lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
 			} else {
-				__lpfc_sli_rpi_release(vport, ndlp);
+				clear_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 			}
 
 			/* The unreg_login mailbox is complete and had a
@@ -2991,6 +2970,7 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 {
 	struct lpfc_vport  *vport = pmb->vport;
 	struct lpfc_nodelist *ndlp;
+	bool unreg_inp;
 
 	ndlp = pmb->ctx_ndlp;
 	if (pmb->u.mb.mbxCommand == MBX_UNREG_LOGIN) {
@@ -3003,20 +2983,26 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 					 vport, KERN_INFO,
 					 LOG_MBOX | LOG_SLI | LOG_NODE,
 					 "0010 UNREG_LOGIN vpi:x%x "
-					 "rpi:%x DID:%x defer x%x flg x%x "
+					 "rpi:%x DID:%x defer x%x flg x%lx "
 					 "x%px\n",
 					 vport->vpi, ndlp->nlp_rpi,
 					 ndlp->nlp_DID, ndlp->nlp_defer_did,
 					 ndlp->nlp_flag,
 					 ndlp);
-				ndlp->nlp_flag &= ~NLP_LOGO_ACC;
+
+				/* Cleanup the nlp_flag now that the UNREG RPI
+				 * has completed.
+				 */
+				unreg_inp = test_and_clear_bit(NLP_UNREG_INP,
+							       &ndlp->nlp_flag);
+				clear_bit(NLP_LOGO_ACC, &ndlp->nlp_flag);
 
 				/* Check to see if there are any deferred
 				 * events to process
 				 */
-				if ((ndlp->nlp_flag & NLP_UNREG_INP) &&
-				    (ndlp->nlp_defer_did !=
-				    NLP_EVT_NOTHING_PENDING)) {
+				if (unreg_inp &&
+				    ndlp->nlp_defer_did !=
+				    NLP_EVT_NOTHING_PENDING) {
 					lpfc_printf_vlog(
 						vport, KERN_INFO,
 						LOG_MBOX | LOG_SLI | LOG_NODE,
@@ -3025,14 +3011,12 @@ lpfc_sli4_unreg_rpi_cmpl_clr(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 						"NPort x%x Data: x%x x%px\n",
 						ndlp->nlp_rpi, ndlp->nlp_DID,
 						ndlp->nlp_defer_did, ndlp);
-					ndlp->nlp_flag &= ~NLP_UNREG_INP;
 					ndlp->nlp_defer_did =
 						NLP_EVT_NOTHING_PENDING;
 					lpfc_issue_els_plogi(
 						vport, ndlp->nlp_DID, 0);
-				} else {
-					__lpfc_sli_rpi_release(vport, ndlp);
 				}
+
 				lpfc_nlp_put(ndlp);
 			}
 		}
@@ -8750,6 +8734,7 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 				lpfc_sli_config_mbox_opcode_get(
 					phba, mboxq),
 				rc, dd);
+
 	/*
 	 * Allocate all resources (xri,rpi,vpi,vfi) now.  Subsequent
 	 * calls depends on these resources to complete port setup.
@@ -8762,6 +8747,8 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 		goto out_free_mbox;
 	}
 
+	lpfc_sli4_node_rpi_restore(phba);
+
 	lpfc_set_host_data(phba, mboxq);
 
 	rc = lpfc_sli_issue_mbox(phba, mboxq, MBX_POLL);
@@ -8949,7 +8936,6 @@ lpfc_sli4_hba_setup(struct lpfc_hba *phba)
 		rc = -ENODEV;
 		goto out_free_iocblist;
 	}
-	lpfc_sli4_node_prep(phba);
 
 	if (!test_bit(HBA_FCOE_MODE, &phba->hba_flag)) {
 		if ((phba->nvmet_support == 0) || (phba->cfg_nvmet_mrq == 1)) {
@@ -14354,9 +14340,7 @@ lpfc_sli4_sp_handle_mbox_event(struct lpfc_hba *phba, struct lpfc_mcqe *mcqe)
 			 * an unsolicited PLOGI from the same NPortId from
 			 * starting another mailbox transaction.
 			 */
-			spin_lock_irqsave(&ndlp->lock, iflags);
-			ndlp->nlp_flag |= NLP_UNREG_INP;
-			spin_unlock_irqrestore(&ndlp->lock, iflags);
+			set_bit(NLP_UNREG_INP, &ndlp->nlp_flag);
 			lpfc_unreg_login(phba, vport->vpi,
 					 pmbox->un.varWords[0], pmb);
 			pmb->mbox_cmpl = lpfc_mbx_cmpl_dflt_rpi;
@@ -19105,9 +19089,9 @@ lpfc_sli4_seq_abort_rsp(struct lpfc_vport *vport,
 	 * to free ndlp when transmit completes
 	 */
 	if (ndlp->nlp_state == NLP_STE_UNUSED_NODE &&
-	    !(ndlp->nlp_flag & NLP_DROPPED) &&
+	    !test_bit(NLP_DROPPED, &ndlp->nlp_flag) &&
 	    !(ndlp->fc4_xpt_flags & (NVME_XPT_REGD | SCSI_XPT_REGD))) {
-		ndlp->nlp_flag |= NLP_DROPPED;
+		set_bit(NLP_DROPPED, &ndlp->nlp_flag);
 		lpfc_nlp_put(ndlp);
 	}
 }
@@ -21125,11 +21109,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 				/* Unregister the RPI when mailbox complete */
 				mb->mbox_flag |= LPFC_MBX_IMED_UNREG;
 				restart_loop = 1;
-				spin_unlock_irq(&phba->hbalock);
-				spin_lock(&ndlp->lock);
-				ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-				spin_unlock(&ndlp->lock);
-				spin_lock_irq(&phba->hbalock);
+				clear_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag);
 				break;
 			}
 		}
@@ -21144,9 +21124,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 			ndlp = mb->ctx_ndlp;
 			mb->ctx_ndlp = NULL;
 			if (ndlp) {
-				spin_lock(&ndlp->lock);
-				ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-				spin_unlock(&ndlp->lock);
+				clear_bit(NLP_IGNR_REG_CMPL, &ndlp->nlp_flag);
 				lpfc_nlp_put(ndlp);
 			}
 		}
@@ -21155,9 +21133,7 @@ lpfc_cleanup_pending_mbox(struct lpfc_vport *vport)
 
 	/* Release the ndlp with the cleaned-up active mailbox command */
 	if (act_mbx_ndlp) {
-		spin_lock(&act_mbx_ndlp->lock);
-		act_mbx_ndlp->nlp_flag &= ~NLP_IGNR_REG_CMPL;
-		spin_unlock(&act_mbx_ndlp->lock);
+		clear_bit(NLP_IGNR_REG_CMPL, &act_mbx_ndlp->nlp_flag);
 		lpfc_nlp_put(act_mbx_ndlp);
 	}
 }
diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index 7a4d4d8e2ad5..9e0e35763377 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -496,7 +496,7 @@ lpfc_send_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	    !ndlp->logo_waitq) {
 		ndlp->logo_waitq = &waitq;
 		ndlp->nlp_fcp_info &= ~NLP_FCP_2_DEVICE;
-		ndlp->nlp_flag |= NLP_ISSUE_LOGO;
+		set_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
 		ndlp->save_flags |= NLP_WAIT_FOR_LOGO;
 	}
 	spin_unlock_irq(&ndlp->lock);
@@ -515,8 +515,8 @@ lpfc_send_npiv_logo(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp)
 	}
 
 	/* Error - clean up node flags. */
+	clear_bit(NLP_ISSUE_LOGO, &ndlp->nlp_flag);
 	spin_lock_irq(&ndlp->lock);
-	ndlp->nlp_flag &= ~NLP_ISSUE_LOGO;
 	ndlp->save_flags &= ~NLP_WAIT_FOR_LOGO;
 	spin_unlock_irq(&ndlp->lock);
 
@@ -708,7 +708,7 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 
 			lpfc_printf_vlog(vport, KERN_INFO, LOG_VPORT | LOG_ELS,
 					 "1829 DA_ID issue status %d. "
-					 "SFlag x%x NState x%x, NFlag x%x "
+					 "SFlag x%x NState x%x, NFlag x%lx "
 					 "Rpi x%x\n",
 					 rc, ndlp->save_flags, ndlp->nlp_state,
 					 ndlp->nlp_flag, ndlp->nlp_rpi);
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 0cd6f3e14882..13b6cb1b93ac 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -2147,7 +2147,7 @@ qla24xx_get_port_database(scsi_qla_host_t *vha, u16 nport_handle,
 
 	pdb_dma = dma_map_single(&vha->hw->pdev->dev, pdb,
 	    sizeof(*pdb), DMA_FROM_DEVICE);
-	if (!pdb_dma) {
+	if (dma_mapping_error(&vha->hw->pdev->dev, pdb_dma)) {
 		ql_log(ql_log_warn, vha, 0x1116, "Failed to map dma buffer.\n");
 		return QLA_MEMORY_ALLOC_FAILED;
 	}
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index d91f54a6e752..97e9ca5a2a02 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -3420,6 +3420,8 @@ static int qla4xxx_alloc_pdu(struct iscsi_task *task, uint8_t opcode)
 		task_data->data_dma = dma_map_single(&ha->pdev->dev, task->data,
 						     task->data_count,
 						     DMA_TO_DEVICE);
+		if (dma_mapping_error(&ha->pdev->dev, task_data->data_dma))
+			return -ENOMEM;
 	}
 
 	DEBUG2(ql4_printk(KERN_INFO, ha, "%s: MaxRecvLen %u, iscsi hrd %d\n",
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 8947dab132d7..86dde3e7debb 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3388,7 +3388,7 @@ static void sd_read_block_limits_ext(struct scsi_disk *sdkp)
 
 	rcu_read_lock();
 	vpd = rcu_dereference(sdkp->device->vpd_pgb7);
-	if (vpd && vpd->len >= 2)
+	if (vpd && vpd->len >= 6)
 		sdkp->rscs = vpd->data[5] & 1;
 	rcu_read_unlock();
 }
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 7c43df252328..e26363ae7489 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -983,11 +983,20 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE) {
 			status = dspi_dma_xfer(dspi);
 		} else {
+			/*
+			 * Reinitialize the completion before transferring data
+			 * to avoid the case where it might remain in the done
+			 * state due to a spurious interrupt from a previous
+			 * transfer. This could falsely signal that the current
+			 * transfer has completed.
+			 */
+			if (dspi->irq)
+				reinit_completion(&dspi->xfer_done);
+
 			dspi_fifo_write(dspi);
 
 			if (dspi->irq) {
 				wait_for_completion(&dspi->xfer_done);
-				reinit_completion(&dspi->xfer_done);
 			} else {
 				do {
 					status = dspi_poll(dspi);
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 4f4ad6af416c..47fe50b80c22 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -1842,7 +1842,9 @@ core_scsi3_decode_spec_i_port(
 		}
 
 		kmem_cache_free(t10_pr_reg_cache, dest_pr_reg);
-		core_scsi3_lunacl_undepend_item(dest_se_deve);
+
+		if (dest_se_deve)
+			core_scsi3_lunacl_undepend_item(dest_se_deve);
 
 		if (is_local)
 			continue;
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f3af5666bb11..f9ef7d94cebd 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -728,12 +728,21 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 	return true;
 }
 
+static void notif_work_fn(struct work_struct *work)
+{
+	struct optee_ffa *optee_ffa = container_of(work, struct optee_ffa,
+						   notif_work);
+	struct optee *optee = container_of(optee_ffa, struct optee, ffa);
+
+	optee_do_bottom_half(optee->ctx);
+}
+
 static void notif_callback(int notify_id, void *cb_data)
 {
 	struct optee *optee = cb_data;
 
 	if (notify_id == optee->ffa.bottom_half_value)
-		optee_do_bottom_half(optee->ctx);
+		queue_work(optee->ffa.notif_wq, &optee->ffa.notif_work);
 	else
 		optee_notif_send(optee, notify_id);
 }
@@ -817,9 +826,11 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 	struct optee *optee = ffa_dev_get_drvdata(ffa_dev);
 	u32 bottom_half_id = optee->ffa.bottom_half_value;
 
-	if (bottom_half_id != U32_MAX)
+	if (bottom_half_id != U32_MAX) {
 		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
 							      bottom_half_id);
+		destroy_workqueue(optee->ffa.notif_wq);
+	}
 	optee_remove_common(optee);
 
 	mutex_destroy(&optee->ffa.mutex);
@@ -835,6 +846,13 @@ static int optee_ffa_async_notif_init(struct ffa_device *ffa_dev,
 	u32 notif_id = 0;
 	int rc;
 
+	INIT_WORK(&optee->ffa.notif_work, notif_work_fn);
+	optee->ffa.notif_wq = create_workqueue("optee_notification");
+	if (!optee->ffa.notif_wq) {
+		rc = -EINVAL;
+		goto err;
+	}
+
 	while (true) {
 		rc = ffa_dev->ops->notifier_ops->notify_request(ffa_dev,
 								is_per_vcpu,
@@ -851,19 +869,24 @@ static int optee_ffa_async_notif_init(struct ffa_device *ffa_dev,
 		 * notifications in that case.
 		 */
 		if (rc != -EACCES)
-			return rc;
+			goto err_wq;
 		notif_id++;
 		if (notif_id >= OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE)
-			return rc;
+			goto err_wq;
 	}
 	optee->ffa.bottom_half_value = notif_id;
 
 	rc = enable_async_notif(optee);
-	if (rc < 0) {
-		ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev,
-							      notif_id);
-		optee->ffa.bottom_half_value = U32_MAX;
-	}
+	if (rc < 0)
+		goto err_rel;
+
+	return 0;
+err_rel:
+	ffa_dev->ops->notifier_ops->notify_relinquish(ffa_dev, notif_id);
+err_wq:
+	destroy_workqueue(optee->ffa.notif_wq);
+err:
+	optee->ffa.bottom_half_value = U32_MAX;
 
 	return rc;
 }
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index dc0f355ef72a..9526087f0e68 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -165,6 +165,8 @@ struct optee_ffa {
 	/* Serializes access to @global_ids */
 	struct mutex mutex;
 	struct rhashtable global_ids;
+	struct workqueue_struct *notif_wq;
+	struct work_struct notif_work;
 };
 
 struct optee;
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 796e37a1d859..f8397ef3cf8d 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -1608,7 +1608,7 @@ UFS_UNIT_DESC_PARAM(logical_block_size, _LOGICAL_BLK_SIZE, 1);
 UFS_UNIT_DESC_PARAM(logical_block_count, _LOGICAL_BLK_COUNT, 8);
 UFS_UNIT_DESC_PARAM(erase_block_size, _ERASE_BLK_SIZE, 4);
 UFS_UNIT_DESC_PARAM(provisioning_type, _PROVISIONING_TYPE, 1);
-UFS_UNIT_DESC_PARAM(physical_memory_resourse_count, _PHY_MEM_RSRC_CNT, 8);
+UFS_UNIT_DESC_PARAM(physical_memory_resource_count, _PHY_MEM_RSRC_CNT, 8);
 UFS_UNIT_DESC_PARAM(context_capabilities, _CTX_CAPABILITIES, 2);
 UFS_UNIT_DESC_PARAM(large_unit_granularity, _LARGE_UNIT_SIZE_M1, 1);
 UFS_UNIT_DESC_PARAM(wb_buf_alloc_units, _WB_BUF_ALLOC_UNITS, 4);
@@ -1625,7 +1625,7 @@ static struct attribute *ufs_sysfs_unit_descriptor[] = {
 	&dev_attr_logical_block_count.attr,
 	&dev_attr_erase_block_size.attr,
 	&dev_attr_provisioning_type.attr,
-	&dev_attr_physical_memory_resourse_count.attr,
+	&dev_attr_physical_memory_resource_count.attr,
 	&dev_attr_context_capabilities.attr,
 	&dev_attr_large_unit_granularity.attr,
 	&dev_attr_wb_buf_alloc_units.attr,
diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
index cd138acdcce1..86860686d836 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -327,12 +327,13 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
 		ret = scnprintf(str, size,
-				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
+				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c %c",
 				cdnsp_trb_type_string(type),
 				ep_num, ep_id % 2 ? "out" : "in",
 				TRB_TO_EP_INDEX(field3), field1, field0,
 				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+				field3 & TRB_CYCLE ? 'C' : 'c',
+				field3 & TRB_ESP ? 'P' : 'p');
 		break;
 	case TRB_STOP_RING:
 		ret = scnprintf(str, size,
diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
index f317d3c84781..5cd9b898ce97 100644
--- a/drivers/usb/cdns3/cdnsp-ep0.c
+++ b/drivers/usb/cdns3/cdnsp-ep0.c
@@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct cdnsp_device *pdev,
 void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 {
 	struct usb_ctrlrequest *ctrl = &pdev->setup;
+	struct cdnsp_ep *pep;
 	int ret = -EINVAL;
 	u16 len;
 
@@ -427,10 +428,21 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 		goto out;
 	}
 
+	pep = &pdev->eps[0];
+
 	/* Restore the ep0 to Stopped/Running state. */
-	if (pdev->eps[0].ep_state & EP_HALTED) {
-		trace_cdnsp_ep0_halted("Restore to normal state");
-		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
+	if (pep->ep_state & EP_HALTED) {
+		if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_HALTED)
+			cdnsp_halt_endpoint(pdev, pep, 0);
+
+		/*
+		 * Halt Endpoint Command for SSP2 for ep0 preserve current
+		 * endpoint state and driver has to synchronize the
+		 * software endpoint state with endpoint output context
+		 * state.
+		 */
+		pep->ep_state &= ~EP_HALTED;
+		pep->ep_state |= EP_STOPPED;
 	}
 
 	/*
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index 2afa3e558f85..a91cca509db0 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -987,6 +987,12 @@ enum cdnsp_setup_dev {
 #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31, 16))
 #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
 
+/*
+ * Halt Endpoint Command TRB field.
+ * The ESP bit only exists in the SSP2 controller.
+ */
+#define TRB_ESP				BIT(9)
+
 /* Link TRB specific fields. */
 #define TRB_TC				BIT(1)
 
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index fd06cb85c4ea..0758f171f73e 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -772,7 +772,9 @@ static int cdnsp_update_port_id(struct cdnsp_device *pdev, u32 port_id)
 	}
 
 	if (port_id != old_port) {
-		cdnsp_disable_slot(pdev);
+		if (pdev->slot_id)
+			cdnsp_disable_slot(pdev);
+
 		pdev->active_port = port;
 		cdnsp_enable_slot(pdev);
 	}
@@ -2483,7 +2485,8 @@ void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev, unsigned int ep_index)
 {
 	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT) |
 			    SLOT_ID_FOR_TRB(pdev->slot_id) |
-			    EP_ID_FOR_TRB(ep_index));
+			    EP_ID_FOR_TRB(ep_index) |
+			    (!ep_index ? TRB_ESP : 0));
 }
 
 void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index fd6032874bf3..8f73bd5057a6 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -2362,6 +2362,10 @@ static void udc_suspend(struct ci_hdrc *ci)
 	 */
 	if (hw_read(ci, OP_ENDPTLISTADDR, ~0) == 0)
 		hw_write(ci, OP_ENDPTLISTADDR, ~0, ~0);
+
+	if (ci->gadget.connected &&
+	    (!ci->suspended || !device_may_wakeup(ci->dev)))
+		usb_gadget_disconnect(&ci->gadget);
 }
 
 static void udc_resume(struct ci_hdrc *ci, bool power_lost)
@@ -2372,6 +2376,9 @@ static void udc_resume(struct ci_hdrc *ci, bool power_lost)
 					OTGSC_BSVIS | OTGSC_BSVIE);
 		if (ci->vbus_active)
 			usb_gadget_vbus_disconnect(&ci->gadget);
+	} else if (ci->vbus_active && ci->driver &&
+		   !ci->gadget.connected) {
+		usb_gadget_connect(&ci->gadget);
 	}
 
 	/* Restore value 0 if it was set for power lost check */
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index da3d0e525b64..da6da5ec4237 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2336,6 +2336,9 @@ void usb_disconnect(struct usb_device **pdev)
 	usb_remove_ep_devs(&udev->ep0);
 	usb_unlock_device(udev);
 
+	if (udev->usb4_link)
+		device_link_del(udev->usb4_link);
+
 	/* Unregister the device.  The device driver is responsible
 	 * for de-configuring the device and invoking the remove-device
 	 * notifier chain (used by usbfs and possibly others).
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index c979ecd0169a..46db600fdd82 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -227,7 +227,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x046a, 0x0023), .driver_info = USB_QUIRK_RESET_RESUME },
 
 	/* Logitech HD Webcam C270 */
-	{ USB_DEVICE(0x046d, 0x0825), .driver_info = USB_QUIRK_RESET_RESUME },
+	{ USB_DEVICE(0x046d, 0x0825), .driver_info = USB_QUIRK_RESET_RESUME |
+		USB_QUIRK_NO_LPM},
 
 	/* Logitech HD Pro Webcams C920, C920-C, C922, C925e and C930e */
 	{ USB_DEVICE(0x046d, 0x082d), .driver_info = USB_QUIRK_DELAY_INIT },
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 494e21a11cd2..3bc68534dbcd 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(usb_acpi_set_power_state);
  */
 static int usb_acpi_add_usb4_devlink(struct usb_device *udev)
 {
-	const struct device_link *link;
+	struct device_link *link;
 	struct usb_port *port_dev;
 	struct usb_hub *hub;
 
@@ -188,6 +188,8 @@ static int usb_acpi_add_usb4_devlink(struct usb_device *udev)
 	dev_dbg(&port_dev->dev, "Created device link from %s to %s\n",
 		dev_name(&port_dev->child->dev), dev_name(nhi_fwnode->dev));
 
+	udev->usb4_link = link;
+
 	return 0;
 }
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7820d6815bed..f4209726f8ec 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2364,6 +2364,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	u32 reg;
 	int i;
+	int ret;
 
 	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
 		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
@@ -2382,7 +2383,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		dwc3_gadget_suspend(dwc);
+		ret = dwc3_gadget_suspend(dwc);
+		if (ret)
+			return ret;
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -2417,7 +2420,9 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			dwc3_gadget_suspend(dwc);
+			ret = dwc3_gadget_suspend(dwc);
+			if (ret)
+				return ret;
 			synchronize_irq(dwc->irq_gadget);
 		}
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 76e6000c65c7..37ae1dd3345d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4788,26 +4788,22 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	int ret;
 
 	ret = dwc3_gadget_soft_disconnect(dwc);
-	if (ret)
-		goto err;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->gadget_driver)
-		dwc3_disconnect_gadget(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	return 0;
-
-err:
 	/*
 	 * Attempt to reset the controller's state. Likely no
 	 * communication can be established until the host
 	 * performs a port reset.
 	 */
-	if (dwc->softconnect)
+	if (ret && dwc->softconnect) {
 		dwc3_gadget_soft_connect(dwc);
+		return -EAGAIN;
+	}
 
-	return ret;
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
 }
 
 int dwc3_gadget_resume(struct dwc3 *dwc)
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index d35f3a18dd13..bdc664ad6a93 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -651,6 +651,10 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
 	case DS_DISABLED:
 		return;
 	case DS_CONFIGURED:
+		spin_lock(&dbc->lock);
+		xhci_dbc_flush_requests(dbc);
+		spin_unlock(&dbc->lock);
+
 		if (dbc->driver->disconnect)
 			dbc->driver->disconnect(dbc);
 		break;
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index d719c16ea30b..2b8558005cbb 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -585,6 +585,7 @@ int dbc_tty_init(void)
 	dbc_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	dbc_tty_driver->subtype = SERIAL_TYPE_NORMAL;
 	dbc_tty_driver->init_termios = tty_std_termios;
+	dbc_tty_driver->init_termios.c_lflag &= ~ECHO;
 	dbc_tty_driver->init_termios.c_cflag =
 			B9600 | CS8 | CREAD | HUPCL | CLOCAL;
 	dbc_tty_driver->init_termios.c_ispeed = 9600;
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index f9c51e0f2e37..91178b8dbbf0 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1426,6 +1426,10 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
 	/* Periodic endpoint bInterval limit quirk */
 	if (usb_endpoint_xfer_int(&ep->desc) ||
 	    usb_endpoint_xfer_isoc(&ep->desc)) {
+		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
+		    interval >= 9) {
+			interval = 8;
+		}
 		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_7) &&
 		    udev->speed >= USB_SPEED_HIGH &&
 		    interval >= 7) {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 1b033c8ce188..234efb9731b2 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -71,12 +71,22 @@
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_XHCI		0x15ec
 #define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_XHCI		0x15f0
 
+#define PCI_DEVICE_ID_AMD_ARIEL_TYPEC_XHCI		0x13ed
+#define PCI_DEVICE_ID_AMD_ARIEL_TYPEA_XHCI		0x13ee
+#define PCI_DEVICE_ID_AMD_STARSHIP_XHCI			0x148c
+#define PCI_DEVICE_ID_AMD_FIREFLIGHT_15D4_XHCI		0x15d4
+#define PCI_DEVICE_ID_AMD_FIREFLIGHT_15D5_XHCI		0x15d5
+#define PCI_DEVICE_ID_AMD_RAVEN_15E0_XHCI		0x15e0
+#define PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI		0x15e1
+#define PCI_DEVICE_ID_AMD_RAVEN2_XHCI			0x15e5
 #define PCI_DEVICE_ID_AMD_RENOIR_XHCI			0x1639
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
 
+#define PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI		0x7316
+
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
 #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
@@ -286,6 +296,21 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_NEC)
 		xhci->quirks |= XHCI_NEC_HOST;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+	    (pdev->device == PCI_DEVICE_ID_AMD_ARIEL_TYPEC_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_ARIEL_TYPEA_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_STARSHIP_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_FIREFLIGHT_15D4_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_FIREFLIGHT_15D5_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN_15E0_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN_15E1_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_AMD_RAVEN2_XHCI))
+		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_9;
+
+	if (pdev->vendor == PCI_VENDOR_ID_ATI &&
+	    pdev->device == PCI_DEVICE_ID_ATI_NAVI10_7316_XHCI)
+		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_9;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version == 0x96)
 		xhci->quirks |= XHCI_AMD_0x96_HOST;
 
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 2379a67e34e1..3a9bdf916755 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -326,7 +326,8 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	}
 
 	usb3_hcd = xhci_get_usb3_hcd(xhci);
-	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4)
+	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
+	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
 		usb3_hcd->can_do_streams = 1;
 
 	if (xhci->shared_hcd) {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index fbc8419a5473..2ff8787f753c 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -461,9 +461,8 @@ static int xhci_abort_cmd_ring(struct xhci_hcd *xhci, unsigned long flags)
 	 * In the future we should distinguish between -ENODEV and -ETIMEDOUT
 	 * and try to recover a -ETIMEDOUT with a host controller reset.
 	 */
-	ret = xhci_handshake_check_state(xhci, &xhci->op_regs->cmd_ring,
-			CMD_RING_RUNNING, 0, 5 * 1000 * 1000,
-			XHCI_STATE_REMOVING);
+	ret = xhci_handshake(&xhci->op_regs->cmd_ring,
+			CMD_RING_RUNNING, 0, 5 * 1000 * 1000);
 	if (ret < 0) {
 		xhci_err(xhci, "Abort failed to stop command ring: %d\n", ret);
 		xhci_halt(xhci);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 799941b6ad6c..09a5a6604962 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -82,29 +82,6 @@ int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, u64 timeout_us)
 	return ret;
 }
 
-/*
- * xhci_handshake_check_state - same as xhci_handshake but takes an additional
- * exit_state parameter, and bails out with an error immediately when xhc_state
- * has exit_state flag set.
- */
-int xhci_handshake_check_state(struct xhci_hcd *xhci, void __iomem *ptr,
-		u32 mask, u32 done, int usec, unsigned int exit_state)
-{
-	u32	result;
-	int	ret;
-
-	ret = readl_poll_timeout_atomic(ptr, result,
-				(result & mask) == done ||
-				result == U32_MAX ||
-				xhci->xhc_state & exit_state,
-				1, usec);
-
-	if (result == U32_MAX || xhci->xhc_state & exit_state)
-		return -ENODEV;
-
-	return ret;
-}
-
 /*
  * Disable interrupts and begin the xHCI halting process.
  */
@@ -225,8 +202,7 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
 	if (xhci->quirks & XHCI_INTEL_HOST)
 		udelay(1000);
 
-	ret = xhci_handshake_check_state(xhci, &xhci->op_regs->command,
-				CMD_RESET, 0, timeout_us, XHCI_STATE_REMOVING);
+	ret = xhci_handshake(&xhci->op_regs->command, CMD_RESET, 0, timeout_us);
 	if (ret)
 		return ret;
 
@@ -1094,7 +1070,10 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 		xhci_dbg(xhci, "Stop HCD\n");
 		xhci_halt(xhci);
 		xhci_zero_64b_regs(xhci);
-		retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
+		if (xhci->xhc_state & XHCI_STATE_REMOVING)
+			retval = -ENODEV;
+		else
+			retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
 		spin_unlock_irq(&xhci->lock);
 		if (retval)
 			return retval;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index c4d5b90ef90a..11580495e09c 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1626,6 +1626,7 @@ struct xhci_hcd {
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 #define XHCI_ETRON_HOST	BIT_ULL(49)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_9 BIT_ULL(50)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -1846,8 +1847,6 @@ void xhci_remove_secondary_interrupter(struct usb_hcd
 /* xHCI host controller glue */
 typedef void (*xhci_get_quirks_t)(struct device *, struct xhci_hcd *);
 int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, u64 timeout_us);
-int xhci_handshake_check_state(struct xhci_hcd *xhci, void __iomem *ptr,
-		u32 mask, u32 done, int usec, unsigned int exit_state);
 void xhci_quiesce(struct xhci_hcd *xhci);
 int xhci_halt(struct xhci_hcd *xhci);
 int xhci_start(struct xhci_hcd *xhci);
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 4976a7238b28..6964f403a2d5 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -394,8 +394,7 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 	case CMDT_RSP_NAK:
 		switch (cmd) {
 		case DP_CMD_STATUS_UPDATE:
-			if (typec_altmode_exit(alt))
-				dev_err(&dp->alt->dev, "Exit Mode Failed!\n");
+			dp->state = DP_STATE_EXIT;
 			break;
 		case DP_CMD_CONFIGURE:
 			dp->data.conf = 0;
@@ -677,7 +676,7 @@ static ssize_t pin_assignment_show(struct device *dev,
 
 	assignments = get_current_pin_assignments(dp);
 
-	for (i = 0; assignments; assignments >>= 1, i++) {
+	for (i = 0; assignments && i < DP_PIN_ASSIGN_MAX; assignments >>= 1, i++) {
 		if (assignments & 1) {
 			if (i == cur)
 				len += sprintf(buf + len, "[%s] ",
diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index 68300fcd3c41..dda8cb3262e0 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -554,12 +554,6 @@ static int vf_qm_state_save(struct hisi_acc_vf_core_device *hisi_acc_vdev,
 	vf_data->vf_qm_state = QM_READY;
 	hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
 
-	ret = vf_qm_cache_wb(vf_qm);
-	if (ret) {
-		dev_err(dev, "failed to writeback QM Cache!\n");
-		return ret;
-	}
-
 	ret = qm_get_regs(vf_qm, vf_data);
 	if (ret)
 		return -EINVAL;
@@ -985,6 +979,13 @@ static int hisi_acc_vf_stop_device(struct hisi_acc_vf_core_device *hisi_acc_vdev
 		dev_err(dev, "failed to check QM INT state!\n");
 		return ret;
 	}
+
+	ret = vf_qm_cache_wb(vf_qm);
+	if (ret) {
+		dev_err(dev, "failed to writeback QM cache!\n");
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1358,6 +1359,7 @@ static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
 			struct hisi_acc_vf_core_device, core_device.vdev);
 	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
 
+	hisi_acc_vf_disable_fds(hisi_acc_vdev);
 	iounmap(vf_qm->io_base);
 	vfio_pci_core_close_device(core_vdev);
 }
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 42bd1cb7c9cd..35f765610802 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,25 +55,37 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
-static struct inode *anon_inode_make_secure_inode(
-	const char *name,
-	const struct inode *context_inode)
+/**
+ * anon_inode_make_secure_inode - allocate an anonymous inode with security context
+ * @sb:		[in]	Superblock to allocate from
+ * @name:	[in]	Name of the class of the newfile (e.g., "secretmem")
+ * @context_inode:
+ *		[in]	Optional parent inode for security inheritance
+ *
+ * The function ensures proper security initialization through the LSM hook
+ * security_inode_init_security_anon().
+ *
+ * Return:	Pointer to new inode on success, ERR_PTR on failure.
+ */
+struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
+					   const struct inode *context_inode)
 {
 	struct inode *inode;
-	const struct qstr qname = QSTR_INIT(name, strlen(name));
 	int error;
 
-	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	inode = alloc_anon_inode(sb);
 	if (IS_ERR(inode))
 		return inode;
 	inode->i_flags &= ~S_PRIVATE;
-	error =	security_inode_init_security_anon(inode, &qname, context_inode);
+	error =	security_inode_init_security_anon(inode, &QSTR(name),
+						  context_inode);
 	if (error) {
 		iput(inode);
 		return ERR_PTR(error);
 	}
 	return inode;
 }
+EXPORT_SYMBOL_GPL_FOR_MODULES(anon_inode_make_secure_inode, "kvm");
 
 static struct file *__anon_inode_getfile(const char *name,
 					 const struct file_operations *fops,
@@ -88,7 +100,8 @@ static struct file *__anon_inode_getfile(const char *name,
 		return ERR_PTR(-ENOENT);
 
 	if (make_inode) {
-		inode =	anon_inode_make_secure_inode(name, context_inode);
+		inode =	anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
+						     name, context_inode);
 		if (IS_ERR(inode)) {
 			file = ERR_CAST(inode);
 			goto err;
diff --git a/fs/bcachefs/fsck.c b/fs/bcachefs/fsck.c
index 75c8a97a6954..7b3b63ed747c 100644
--- a/fs/bcachefs/fsck.c
+++ b/fs/bcachefs/fsck.c
@@ -405,7 +405,7 @@ static int reattach_inode(struct btree_trans *trans, struct bch_inode_unpacked *
 		return ret;
 
 	struct bch_hash_info dir_hash = bch2_hash_info_init(c, &lostfound);
-	struct qstr name = (struct qstr) QSTR(name_buf);
+	struct qstr name = QSTR(name_buf);
 
 	inode->bi_dir = lostfound.bi_inum;
 
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 3c7f941dde39..ebabba296882 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -32,8 +32,6 @@
 #include <linux/sort.h>
 #include <linux/stat.h>
 
-#define QSTR(n) { { { .len = strlen(n) } }, .name = n }
-
 void bch2_btree_lost_data(struct bch_fs *c, enum btree_id btree)
 {
 	if (btree >= BTREE_ID_NR_MAX)
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index fb02c1c36004..a27f4b84fe77 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -647,8 +647,6 @@ static inline int cmp_le32(__le32 l, __le32 r)
 
 #include <linux/uuid.h>
 
-#define QSTR(n) { { { .len = strlen(n) } }, .name = n }
-
 static inline bool qstr_eq(const struct qstr l, const struct qstr r)
 {
 	return l.len == r.len && !memcmp(l.name, r.name, l.len);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index eaa991e69804..0e63603ac5c7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1912,6 +1912,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	struct extent_changeset *data_reserved = NULL;
 	unsigned long zero_start;
 	loff_t size;
+	size_t fsize = folio_size(folio);
 	vm_fault_t ret;
 	int ret2;
 	int reserved = 0;
@@ -1922,7 +1923,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	ASSERT(folio_order(folio) == 0);
 
-	reserved_space = PAGE_SIZE;
+	reserved_space = fsize;
 
 	sb_start_pagefault(inode->i_sb);
 	page_start = folio_pos(folio);
@@ -1976,7 +1977,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * We can't set the delalloc bits if there are pending ordered
 	 * extents.  Drop our locks and wait for them to finish.
 	 */
-	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, PAGE_SIZE);
+	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, fsize);
 	if (ordered) {
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
@@ -1988,11 +1989,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	if (folio->index == ((size - 1) >> PAGE_SHIFT)) {
 		reserved_space = round_up(size - page_start, fs_info->sectorsize);
-		if (reserved_space < PAGE_SIZE) {
+		if (reserved_space < fsize) {
 			end = page_start + reserved_space - 1;
 			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved, page_start,
-					PAGE_SIZE - reserved_space, true);
+					data_reserved, end + 1,
+					fsize - reserved_space, true);
 		}
 	}
 
@@ -2019,12 +2020,12 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	if (page_start + folio_size(folio) > size)
 		zero_start = offset_in_folio(folio, size);
 	else
-		zero_start = PAGE_SIZE;
+		zero_start = fsize;
 
-	if (zero_start != PAGE_SIZE)
+	if (zero_start != fsize)
 		folio_zero_range(folio, zero_start, folio_size(folio) - zero_start);
 
-	btrfs_folio_clear_checked(fs_info, folio, page_start, PAGE_SIZE);
+	btrfs_folio_clear_checked(fs_info, folio, page_start, fsize);
 	btrfs_folio_set_dirty(fs_info, folio, page_start, end + 1 - page_start);
 	btrfs_folio_set_uptodate(fs_info, folio, page_start, end + 1 - page_start);
 
@@ -2033,7 +2034,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	unlock_extent(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
 	sb_end_pagefault(inode->i_sb);
 	extent_changeset_free(data_reserved);
 	return VM_FAULT_LOCKED;
@@ -2042,7 +2043,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	folio_unlock(folio);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 out:
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
 	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
 				     reserved_space, (ret != 0));
 out_noreserve:
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 921ec3802648..f84e3f9fad84 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4734,7 +4734,6 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	int ret = 0;
 	struct btrfs_trans_handle *trans;
-	u64 last_unlink_trans;
 	struct fscrypt_name fname;
 
 	if (inode->i_size > BTRFS_EMPTY_DIR_SIZE)
@@ -4760,6 +4759,23 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 		goto out_notrans;
 	}
 
+	/*
+	 * Propagate the last_unlink_trans value of the deleted dir to its
+	 * parent directory. This is to prevent an unrecoverable log tree in the
+	 * case we do something like this:
+	 * 1) create dir foo
+	 * 2) create snapshot under dir foo
+	 * 3) delete the snapshot
+	 * 4) rmdir foo
+	 * 5) mkdir foo
+	 * 6) fsync foo or some file inside foo
+	 *
+	 * This is because we can't unlink other roots when replaying the dir
+	 * deletes for directory foo.
+	 */
+	if (BTRFS_I(inode)->last_unlink_trans >= trans->transid)
+		btrfs_record_snapshot_destroy(trans, BTRFS_I(dir));
+
 	if (unlikely(btrfs_ino(BTRFS_I(inode)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 		ret = btrfs_unlink_subvol(trans, BTRFS_I(dir), dentry);
 		goto out;
@@ -4769,27 +4785,11 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 	if (ret)
 		goto out;
 
-	last_unlink_trans = BTRFS_I(inode)->last_unlink_trans;
-
 	/* now the directory is empty */
 	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
 				 &fname.disk_name);
-	if (!ret) {
+	if (!ret)
 		btrfs_i_size_write(BTRFS_I(inode), 0);
-		/*
-		 * Propagate the last_unlink_trans value of the deleted dir to
-		 * its parent directory. This is to prevent an unrecoverable
-		 * log tree in the case we do something like this:
-		 * 1) create dir foo
-		 * 2) create snapshot under dir foo
-		 * 3) delete the snapshot
-		 * 4) rmdir foo
-		 * 5) mkdir foo
-		 * 6) fsync foo or some file inside foo
-		 */
-		if (last_unlink_trans >= trans->transid)
-			BTRFS_I(dir)->last_unlink_trans = last_unlink_trans;
-	}
 out:
 	btrfs_end_transaction(trans);
 out_notrans:
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3e3722a73239..1706f6d9b12e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -758,14 +758,14 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
 		goto out;
 	}
 
+	btrfs_record_new_subvolume(trans, BTRFS_I(dir));
+
 	ret = btrfs_create_new_inode(trans, &new_inode_args);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
-	btrfs_record_new_subvolume(trans, BTRFS_I(dir));
-
 	d_instantiate_new(dentry, new_inode_args.inode);
 	new_inode_args.inode = NULL;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9637c7cdc0cf..16b4474ded4b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -138,11 +138,14 @@ static void wait_log_commit(struct btrfs_root *root, int transid);
  * and once to do all the other items.
  */
 
-static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
+static struct btrfs_inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 {
 	unsigned int nofs_flag;
 	struct inode *inode;
 
+	/* Only meant to be called for subvolume roots and not for log roots. */
+	ASSERT(is_fstree(btrfs_root_id(root)));
+
 	/*
 	 * We're holding a transaction handle whether we are logging or
 	 * replaying a log tree, so we must make sure NOFS semantics apply
@@ -154,7 +157,10 @@ static struct inode *btrfs_iget_logging(u64 objectid, struct btrfs_root *root)
 	inode = btrfs_iget(objectid, root);
 	memalloc_nofs_restore(nofs_flag);
 
-	return inode;
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	return BTRFS_I(inode);
 }
 
 /*
@@ -610,21 +616,6 @@ static int read_alloc_one_name(struct extent_buffer *eb, void *start, int len,
 	return 0;
 }
 
-/*
- * simple helper to read an inode off the disk from a given root
- * This can only be called for subvolume roots and not for the log
- */
-static noinline struct inode *read_one_inode(struct btrfs_root *root,
-					     u64 objectid)
-{
-	struct inode *inode;
-
-	inode = btrfs_iget_logging(objectid, root);
-	if (IS_ERR(inode))
-		inode = NULL;
-	return inode;
-}
-
 /* replays a single extent in 'eb' at 'slot' with 'key' into the
  * subvolume 'root'.  path is released on entry and should be released
  * on exit.
@@ -650,7 +641,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	u64 start = key->offset;
 	u64 nbytes = 0;
 	struct btrfs_file_extent_item *item;
-	struct inode *inode = NULL;
+	struct btrfs_inode *inode = NULL;
 	unsigned long size;
 	int ret = 0;
 
@@ -674,23 +665,19 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		extent_end = ALIGN(start + size,
 				   fs_info->sectorsize);
 	} else {
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
-	inode = read_one_inode(root, key->objectid);
-	if (!inode) {
-		ret = -EIO;
-		goto out;
-	}
+	inode = btrfs_iget_logging(key->objectid, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	/*
 	 * first check to see if we already have this extent in the
 	 * file.  This must be done before the btrfs_drop_extents run
 	 * so we don't try to drop this extent.
 	 */
-	ret = btrfs_lookup_file_extent(trans, root, path,
-			btrfs_ino(BTRFS_I(inode)), start, 0);
+	ret = btrfs_lookup_file_extent(trans, root, path, btrfs_ino(inode), start, 0);
 
 	if (ret == 0 &&
 	    (found_type == BTRFS_FILE_EXTENT_REG ||
@@ -724,7 +711,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	drop_args.start = start;
 	drop_args.end = extent_end;
 	drop_args.drop_cache = true;
-	ret = btrfs_drop_extents(trans, root, BTRFS_I(inode), &drop_args);
+	ret = btrfs_drop_extents(trans, root, inode, &drop_args);
 	if (ret)
 		goto out;
 
@@ -902,16 +889,15 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			goto out;
 	}
 
-	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start,
-						extent_end - start);
+	ret = btrfs_inode_set_file_extent_range(inode, start, extent_end - start);
 	if (ret)
 		goto out;
 
 update_inode:
-	btrfs_update_inode_bytes(BTRFS_I(inode), nbytes, drop_args.bytes_found);
-	ret = btrfs_update_inode(trans, BTRFS_I(inode));
+	btrfs_update_inode_bytes(inode, nbytes, drop_args.bytes_found);
+	ret = btrfs_update_inode(trans, inode);
 out:
-	iput(inode);
+	iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -948,7 +934,7 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 				      struct btrfs_dir_item *di)
 {
 	struct btrfs_root *root = dir->root;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct fscrypt_str name;
 	struct extent_buffer *leaf;
 	struct btrfs_key location;
@@ -963,9 +949,10 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 
 	btrfs_release_path(path);
 
-	inode = read_one_inode(root, location.objectid);
-	if (!inode) {
-		ret = -EIO;
+	inode = btrfs_iget_logging(location.objectid, root);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		inode = NULL;
 		goto out;
 	}
 
@@ -973,10 +960,11 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	ret = unlink_inode_for_log_replay(trans, dir, BTRFS_I(inode), &name);
+	ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
 out:
 	kfree(name.name);
-	iput(inode);
+	if (inode)
+		iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -1087,7 +1075,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 	search_key.type = BTRFS_INODE_REF_KEY;
 	search_key.offset = parent_objectid;
 	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
-	if (ret == 0) {
+	if (ret < 0) {
+		return ret;
+	} else if (ret == 0) {
 		struct btrfs_inode_ref *victim_ref;
 		unsigned long ptr;
 		unsigned long ptr_end;
@@ -1149,7 +1139,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 		u32 item_size;
 		u32 cur_offset = 0;
 		unsigned long base;
-		struct inode *victim_parent;
+		struct btrfs_inode *victim_parent;
 
 		leaf = path->nodes[0];
 
@@ -1160,13 +1150,13 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 			struct fscrypt_str victim_name;
 
 			extref = (struct btrfs_inode_extref *)(base + cur_offset);
+			victim_name.len = btrfs_inode_extref_name_len(leaf, extref);
 
 			if (btrfs_inode_extref_parent(leaf, extref) != parent_objectid)
 				goto next;
 
 			ret = read_alloc_one_name(leaf, &extref->name,
-				 btrfs_inode_extref_name_len(leaf, extref),
-				 &victim_name);
+						  victim_name.len, &victim_name);
 			if (ret)
 				return ret;
 
@@ -1181,18 +1171,18 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				kfree(victim_name.name);
 				return ret;
 			} else if (!ret) {
-				ret = -ENOENT;
-				victim_parent = read_one_inode(root,
-						parent_objectid);
-				if (victim_parent) {
+				victim_parent = btrfs_iget_logging(parent_objectid, root);
+				if (IS_ERR(victim_parent)) {
+					ret = PTR_ERR(victim_parent);
+				} else {
 					inc_nlink(&inode->vfs_inode);
 					btrfs_release_path(path);
 
 					ret = unlink_inode_for_log_replay(trans,
-							BTRFS_I(victim_parent),
+							victim_parent,
 							inode, &victim_name);
+					iput(&victim_parent->vfs_inode);
 				}
-				iput(victim_parent);
 				kfree(victim_name.name);
 				if (ret)
 					return ret;
@@ -1326,19 +1316,18 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 			ret = !!btrfs_find_name_in_backref(log_eb, log_slot, &name);
 
 		if (!ret) {
-			struct inode *dir;
+			struct btrfs_inode *dir;
 
 			btrfs_release_path(path);
-			dir = read_one_inode(root, parent_id);
-			if (!dir) {
-				ret = -ENOENT;
+			dir = btrfs_iget_logging(parent_id, root);
+			if (IS_ERR(dir)) {
+				ret = PTR_ERR(dir);
 				kfree(name.name);
 				goto out;
 			}
-			ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir),
-						 inode, &name);
+			ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
 			kfree(name.name);
-			iput(dir);
+			iput(&dir->vfs_inode);
 			if (ret)
 				goto out;
 			goto again;
@@ -1370,8 +1359,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				  struct extent_buffer *eb, int slot,
 				  struct btrfs_key *key)
 {
-	struct inode *dir = NULL;
-	struct inode *inode = NULL;
+	struct btrfs_inode *dir = NULL;
+	struct btrfs_inode *inode = NULL;
 	unsigned long ref_ptr;
 	unsigned long ref_end;
 	struct fscrypt_str name = { 0 };
@@ -1404,15 +1393,17 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	 * copy the back ref in.  The link count fixup code will take
 	 * care of the rest
 	 */
-	dir = read_one_inode(root, parent_objectid);
-	if (!dir) {
-		ret = -ENOENT;
+	dir = btrfs_iget_logging(parent_objectid, root);
+	if (IS_ERR(dir)) {
+		ret = PTR_ERR(dir);
+		dir = NULL;
 		goto out;
 	}
 
-	inode = read_one_inode(root, inode_objectid);
-	if (!inode) {
-		ret = -EIO;
+	inode = btrfs_iget_logging(inode_objectid, root);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		inode = NULL;
 		goto out;
 	}
 
@@ -1424,11 +1415,13 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			 * parent object can change from one array
 			 * item to another.
 			 */
-			if (!dir)
-				dir = read_one_inode(root, parent_objectid);
 			if (!dir) {
-				ret = -ENOENT;
-				goto out;
+				dir = btrfs_iget_logging(parent_objectid, root);
+				if (IS_ERR(dir)) {
+					ret = PTR_ERR(dir);
+					dir = NULL;
+					goto out;
+				}
 			}
 		} else {
 			ret = ref_get_fields(eb, ref_ptr, &name, &ref_index);
@@ -1436,8 +1429,8 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		if (ret)
 			goto out;
 
-		ret = inode_in_dir(root, path, btrfs_ino(BTRFS_I(dir)),
-				   btrfs_ino(BTRFS_I(inode)), ref_index, &name);
+		ret = inode_in_dir(root, path, btrfs_ino(dir), btrfs_ino(inode),
+				   ref_index, &name);
 		if (ret < 0) {
 			goto out;
 		} else if (ret == 0) {
@@ -1448,8 +1441,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			 * overwrite any existing back reference, and we don't
 			 * want to create dangling pointers in the directory.
 			 */
-			ret = __add_inode_ref(trans, root, path, log,
-					      BTRFS_I(dir), BTRFS_I(inode),
+			ret = __add_inode_ref(trans, root, path, log, dir, inode,
 					      inode_objectid, parent_objectid,
 					      ref_index, &name);
 			if (ret) {
@@ -1459,12 +1451,11 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			}
 
 			/* insert our name */
-			ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-					     &name, 0, ref_index);
+			ret = btrfs_add_link(trans, dir, inode, &name, 0, ref_index);
 			if (ret)
 				goto out;
 
-			ret = btrfs_update_inode(trans, BTRFS_I(inode));
+			ret = btrfs_update_inode(trans, inode);
 			if (ret)
 				goto out;
 		}
@@ -1474,7 +1465,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 		kfree(name.name);
 		name.name = NULL;
 		if (log_ref_ver) {
-			iput(dir);
+			iput(&dir->vfs_inode);
 			dir = NULL;
 		}
 	}
@@ -1487,8 +1478,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	 * dir index entries exist for a name but there is no inode reference
 	 * item with the same name.
 	 */
-	ret = unlink_old_inode_refs(trans, root, path, BTRFS_I(inode), eb, slot,
-				    key);
+	ret = unlink_old_inode_refs(trans, root, path, inode, eb, slot, key);
 	if (ret)
 		goto out;
 
@@ -1497,8 +1487,10 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 	kfree(name.name);
-	iput(dir);
-	iput(inode);
+	if (dir)
+		iput(&dir->vfs_inode);
+	if (inode)
+		iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -1670,12 +1662,13 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	struct btrfs_key key;
-	struct inode *inode;
 
 	key.objectid = BTRFS_TREE_LOG_FIXUP_OBJECTID;
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = (u64)-1;
 	while (1) {
+		struct btrfs_inode *inode;
+
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 		if (ret < 0)
 			break;
@@ -1697,14 +1690,14 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 			break;
 
 		btrfs_release_path(path);
-		inode = read_one_inode(root, key.offset);
-		if (!inode) {
-			ret = -EIO;
+		inode = btrfs_iget_logging(key.offset, root);
+		if (IS_ERR(inode)) {
+			ret = PTR_ERR(inode);
 			break;
 		}
 
-		ret = fixup_inode_link_count(trans, inode);
-		iput(inode);
+		ret = fixup_inode_link_count(trans, &inode->vfs_inode);
+		iput(&inode->vfs_inode);
 		if (ret)
 			break;
 
@@ -1732,12 +1725,14 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_key key;
 	int ret = 0;
-	struct inode *inode;
+	struct btrfs_inode *inode;
+	struct inode *vfs_inode;
 
-	inode = read_one_inode(root, objectid);
-	if (!inode)
-		return -EIO;
+	inode = btrfs_iget_logging(objectid, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
+	vfs_inode = &inode->vfs_inode;
 	key.objectid = BTRFS_TREE_LOG_FIXUP_OBJECTID;
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = objectid;
@@ -1746,15 +1741,15 @@ static noinline int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 
 	btrfs_release_path(path);
 	if (ret == 0) {
-		if (!inode->i_nlink)
-			set_nlink(inode, 1);
+		if (!vfs_inode->i_nlink)
+			set_nlink(vfs_inode, 1);
 		else
-			inc_nlink(inode);
-		ret = btrfs_update_inode(trans, BTRFS_I(inode));
+			inc_nlink(vfs_inode);
+		ret = btrfs_update_inode(trans, inode);
 	} else if (ret == -EEXIST) {
 		ret = 0;
 	}
-	iput(inode);
+	iput(vfs_inode);
 
 	return ret;
 }
@@ -1770,27 +1765,26 @@ static noinline int insert_one_name(struct btrfs_trans_handle *trans,
 				    const struct fscrypt_str *name,
 				    struct btrfs_key *location)
 {
-	struct inode *inode;
-	struct inode *dir;
+	struct btrfs_inode *inode;
+	struct btrfs_inode *dir;
 	int ret;
 
-	inode = read_one_inode(root, location->objectid);
-	if (!inode)
-		return -ENOENT;
+	inode = btrfs_iget_logging(location->objectid, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
-	dir = read_one_inode(root, dirid);
-	if (!dir) {
-		iput(inode);
-		return -EIO;
+	dir = btrfs_iget_logging(dirid, root);
+	if (IS_ERR(dir)) {
+		iput(&inode->vfs_inode);
+		return PTR_ERR(dir);
 	}
 
-	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-			     1, index);
+	ret = btrfs_add_link(trans, dir, inode, name, 1, index);
 
 	/* FIXME, put inode into FIXUP list */
 
-	iput(inode);
-	iput(dir);
+	iput(&inode->vfs_inode);
+	iput(&dir->vfs_inode);
 	return ret;
 }
 
@@ -1852,16 +1846,16 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	bool index_dst_matches = false;
 	struct btrfs_key log_key;
 	struct btrfs_key search_key;
-	struct inode *dir;
+	struct btrfs_inode *dir;
 	u8 log_flags;
 	bool exists;
 	int ret;
 	bool update_size = true;
 	bool name_added = false;
 
-	dir = read_one_inode(root, key->objectid);
-	if (!dir)
-		return -EIO;
+	dir = btrfs_iget_logging(key->objectid, root);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
 
 	ret = read_alloc_one_name(eb, di + 1, btrfs_dir_name_len(eb, di), &name);
 	if (ret)
@@ -1882,9 +1876,8 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		ret = PTR_ERR(dir_dst_di);
 		goto out;
 	} else if (dir_dst_di) {
-		ret = delete_conflicting_dir_entry(trans, BTRFS_I(dir), path,
-						   dir_dst_di, &log_key,
-						   log_flags, exists);
+		ret = delete_conflicting_dir_entry(trans, dir, path, dir_dst_di,
+						   &log_key, log_flags, exists);
 		if (ret < 0)
 			goto out;
 		dir_dst_matches = (ret == 1);
@@ -1899,9 +1892,8 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		ret = PTR_ERR(index_dst_di);
 		goto out;
 	} else if (index_dst_di) {
-		ret = delete_conflicting_dir_entry(trans, BTRFS_I(dir), path,
-						   index_dst_di, &log_key,
-						   log_flags, exists);
+		ret = delete_conflicting_dir_entry(trans, dir, path, index_dst_di,
+						   &log_key, log_flags, exists);
 		if (ret < 0)
 			goto out;
 		index_dst_matches = (ret == 1);
@@ -1956,11 +1948,11 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 
 out:
 	if (!ret && update_size) {
-		btrfs_i_size_write(BTRFS_I(dir), dir->i_size + name.len * 2);
-		ret = btrfs_update_inode(trans, BTRFS_I(dir));
+		btrfs_i_size_write(dir, dir->vfs_inode.i_size + name.len * 2);
+		ret = btrfs_update_inode(trans, dir);
 	}
 	kfree(name.name);
-	iput(dir);
+	iput(&dir->vfs_inode);
 	if (!ret && name_added)
 		ret = 1;
 	return ret;
@@ -2117,16 +2109,16 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 				      struct btrfs_root *log,
 				      struct btrfs_path *path,
 				      struct btrfs_path *log_path,
-				      struct inode *dir,
+				      struct btrfs_inode *dir,
 				      struct btrfs_key *dir_key)
 {
-	struct btrfs_root *root = BTRFS_I(dir)->root;
+	struct btrfs_root *root = dir->root;
 	int ret;
 	struct extent_buffer *eb;
 	int slot;
 	struct btrfs_dir_item *di;
 	struct fscrypt_str name = { 0 };
-	struct inode *inode = NULL;
+	struct btrfs_inode *inode = NULL;
 	struct btrfs_key location;
 
 	/*
@@ -2163,9 +2155,10 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	btrfs_dir_item_key_to_cpu(eb, di, &location);
 	btrfs_release_path(path);
 	btrfs_release_path(log_path);
-	inode = read_one_inode(root, location.objectid);
-	if (!inode) {
-		ret = -EIO;
+	inode = btrfs_iget_logging(location.objectid, root);
+	if (IS_ERR(inode)) {
+		ret = PTR_ERR(inode);
+		inode = NULL;
 		goto out;
 	}
 
@@ -2173,9 +2166,8 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	inc_nlink(inode);
-	ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir), BTRFS_I(inode),
-					  &name);
+	inc_nlink(&inode->vfs_inode);
+	ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
 	/*
 	 * Unlike dir item keys, dir index keys can only have one name (entry) in
 	 * them, as there are no key collisions since each key has a unique offset
@@ -2185,7 +2177,8 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 	btrfs_release_path(log_path);
 	kfree(name.name);
-	iput(inode);
+	if (inode)
+		iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -2309,7 +2302,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 	struct btrfs_key dir_key;
 	struct btrfs_key found_key;
 	struct btrfs_path *log_path;
-	struct inode *dir;
+	struct btrfs_inode *dir;
 
 	dir_key.objectid = dirid;
 	dir_key.type = BTRFS_DIR_INDEX_KEY;
@@ -2317,14 +2310,17 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 	if (!log_path)
 		return -ENOMEM;
 
-	dir = read_one_inode(root, dirid);
-	/* it isn't an error if the inode isn't there, that can happen
-	 * because we replay the deletes before we copy in the inode item
-	 * from the log
+	dir = btrfs_iget_logging(dirid, root);
+	/*
+	 * It isn't an error if the inode isn't there, that can happen because
+	 * we replay the deletes before we copy in the inode item from the log.
 	 */
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		btrfs_free_path(log_path);
-		return 0;
+		ret = PTR_ERR(dir);
+		if (ret == -ENOENT)
+			ret = 0;
+		return ret;
 	}
 
 	range_start = 0;
@@ -2386,7 +2382,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 out:
 	btrfs_release_path(path);
 	btrfs_free_path(log_path);
-	iput(dir);
+	iput(&dir->vfs_inode);
 	return ret;
 }
 
@@ -2480,30 +2476,28 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			 */
 			if (S_ISREG(mode)) {
 				struct btrfs_drop_extents_args drop_args = { 0 };
-				struct inode *inode;
+				struct btrfs_inode *inode;
 				u64 from;
 
-				inode = read_one_inode(root, key.objectid);
-				if (!inode) {
-					ret = -EIO;
+				inode = btrfs_iget_logging(key.objectid, root);
+				if (IS_ERR(inode)) {
+					ret = PTR_ERR(inode);
 					break;
 				}
-				from = ALIGN(i_size_read(inode),
+				from = ALIGN(i_size_read(&inode->vfs_inode),
 					     root->fs_info->sectorsize);
 				drop_args.start = from;
 				drop_args.end = (u64)-1;
 				drop_args.drop_cache = true;
-				ret = btrfs_drop_extents(wc->trans, root,
-							 BTRFS_I(inode),
+				ret = btrfs_drop_extents(wc->trans, root, inode,
 							 &drop_args);
 				if (!ret) {
-					inode_sub_bytes(inode,
+					inode_sub_bytes(&inode->vfs_inode,
 							drop_args.bytes_found);
 					/* Update the inode's nbytes. */
-					ret = btrfs_update_inode(wc->trans,
-								 BTRFS_I(inode));
+					ret = btrfs_update_inode(wc->trans, inode);
 				}
-				iput(inode);
+				iput(&inode->vfs_inode);
 				if (ret)
 					break;
 			}
@@ -5485,7 +5479,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	ihold(&curr_inode->vfs_inode);
 
 	while (true) {
-		struct inode *vfs_inode;
 		struct btrfs_key key;
 		struct btrfs_key found_key;
 		u64 next_index;
@@ -5501,7 +5494,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			struct extent_buffer *leaf = path->nodes[0];
 			struct btrfs_dir_item *di;
 			struct btrfs_key di_key;
-			struct inode *di_inode;
+			struct btrfs_inode *di_inode;
 			int log_mode = LOG_INODE_EXISTS;
 			int type;
 
@@ -5528,17 +5521,16 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 
-			if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-				btrfs_add_delayed_iput(BTRFS_I(di_inode));
+			if (!need_log_inode(trans, di_inode)) {
+				btrfs_add_delayed_iput(di_inode);
 				break;
 			}
 
 			ctx->log_new_dentries = false;
 			if (type == BTRFS_FT_DIR)
 				log_mode = LOG_INODE_ALL;
-			ret = btrfs_log_inode(trans, BTRFS_I(di_inode),
-					      log_mode, ctx);
-			btrfs_add_delayed_iput(BTRFS_I(di_inode));
+			ret = btrfs_log_inode(trans, di_inode, log_mode, ctx);
+			btrfs_add_delayed_iput(di_inode);
 			if (ret)
 				goto out;
 			if (ctx->log_new_dentries) {
@@ -5580,14 +5572,13 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 		kfree(dir_elem);
 
 		btrfs_add_delayed_iput(curr_inode);
-		curr_inode = NULL;
 
-		vfs_inode = btrfs_iget_logging(ino, root);
-		if (IS_ERR(vfs_inode)) {
-			ret = PTR_ERR(vfs_inode);
+		curr_inode = btrfs_iget_logging(ino, root);
+		if (IS_ERR(curr_inode)) {
+			ret = PTR_ERR(curr_inode);
+			curr_inode = NULL;
 			break;
 		}
-		curr_inode = BTRFS_I(vfs_inode);
 	}
 out:
 	btrfs_free_path(path);
@@ -5665,7 +5656,7 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 				 struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_ino_list *ino_elem;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 
 	/*
 	 * It's rare to have a lot of conflicting inodes, in practice it is not
@@ -5756,12 +5747,12 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 	 * inode in LOG_INODE_EXISTS mode and rename operations update the log,
 	 * so that the log ends up with the new name and without the old name.
 	 */
-	if (!need_log_inode(trans, BTRFS_I(inode))) {
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+	if (!need_log_inode(trans, inode)) {
+		btrfs_add_delayed_iput(inode);
 		return 0;
 	}
 
-	btrfs_add_delayed_iput(BTRFS_I(inode));
+	btrfs_add_delayed_iput(inode);
 
 	ino_elem = kmalloc(sizeof(*ino_elem), GFP_NOFS);
 	if (!ino_elem)
@@ -5797,7 +5788,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 	 */
 	while (!list_empty(&ctx->conflict_inodes)) {
 		struct btrfs_ino_list *curr;
-		struct inode *inode;
+		struct btrfs_inode *inode;
 		u64 ino;
 		u64 parent;
 
@@ -5833,9 +5824,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 			 * dir index key range logged for the directory. So we
 			 * must make sure the deletion is recorded.
 			 */
-			ret = btrfs_log_inode(trans, BTRFS_I(inode),
-					      LOG_INODE_ALL, ctx);
-			btrfs_add_delayed_iput(BTRFS_I(inode));
+			ret = btrfs_log_inode(trans, inode, LOG_INODE_ALL, ctx);
+			btrfs_add_delayed_iput(inode);
 			if (ret)
 				break;
 			continue;
@@ -5851,8 +5841,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * it again because if some other task logged the inode after
 		 * that, we can avoid doing it again.
 		 */
-		if (!need_log_inode(trans, BTRFS_I(inode))) {
-			btrfs_add_delayed_iput(BTRFS_I(inode));
+		if (!need_log_inode(trans, inode)) {
+			btrfs_add_delayed_iput(inode);
 			continue;
 		}
 
@@ -5863,8 +5853,8 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
 		 * well because during a rename we pin the log and update the
 		 * log with the new name before we unpin it.
 		 */
-		ret = btrfs_log_inode(trans, BTRFS_I(inode), LOG_INODE_EXISTS, ctx);
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+		ret = btrfs_log_inode(trans, inode, LOG_INODE_EXISTS, ctx);
+		btrfs_add_delayed_iput(inode);
 		if (ret)
 			break;
 	}
@@ -6356,7 +6346,7 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 
 	list_for_each_entry(item, delayed_ins_list, log_list) {
 		struct btrfs_dir_item *dir_item;
-		struct inode *di_inode;
+		struct btrfs_inode *di_inode;
 		struct btrfs_key key;
 		int log_mode = LOG_INODE_EXISTS;
 
@@ -6372,8 +6362,8 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		if (!need_log_inode(trans, BTRFS_I(di_inode))) {
-			btrfs_add_delayed_iput(BTRFS_I(di_inode));
+		if (!need_log_inode(trans, di_inode)) {
+			btrfs_add_delayed_iput(di_inode);
 			continue;
 		}
 
@@ -6381,12 +6371,12 @@ static int log_new_delayed_dentries(struct btrfs_trans_handle *trans,
 			log_mode = LOG_INODE_ALL;
 
 		ctx->log_new_dentries = false;
-		ret = btrfs_log_inode(trans, BTRFS_I(di_inode), log_mode, ctx);
+		ret = btrfs_log_inode(trans, di_inode, log_mode, ctx);
 
 		if (!ret && ctx->log_new_dentries)
-			ret = log_new_dir_dentries(trans, BTRFS_I(di_inode), ctx);
+			ret = log_new_dir_dentries(trans, di_inode, ctx);
 
-		btrfs_add_delayed_iput(BTRFS_I(di_inode));
+		btrfs_add_delayed_iput(di_inode);
 
 		if (ret)
 			break;
@@ -6794,7 +6784,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 		ptr = btrfs_item_ptr_offset(leaf, slot);
 		while (cur_offset < item_size) {
 			struct btrfs_key inode_key;
-			struct inode *dir_inode;
+			struct btrfs_inode *dir_inode;
 
 			inode_key.type = BTRFS_INODE_ITEM_KEY;
 			inode_key.offset = 0;
@@ -6843,18 +6833,16 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				goto out;
 			}
 
-			if (!need_log_inode(trans, BTRFS_I(dir_inode))) {
-				btrfs_add_delayed_iput(BTRFS_I(dir_inode));
+			if (!need_log_inode(trans, dir_inode)) {
+				btrfs_add_delayed_iput(dir_inode);
 				continue;
 			}
 
 			ctx->log_new_dentries = false;
-			ret = btrfs_log_inode(trans, BTRFS_I(dir_inode),
-					      LOG_INODE_ALL, ctx);
+			ret = btrfs_log_inode(trans, dir_inode, LOG_INODE_ALL, ctx);
 			if (!ret && ctx->log_new_dentries)
-				ret = log_new_dir_dentries(trans,
-						   BTRFS_I(dir_inode), ctx);
-			btrfs_add_delayed_iput(BTRFS_I(dir_inode));
+				ret = log_new_dir_dentries(trans, dir_inode, ctx);
+			btrfs_add_delayed_iput(dir_inode);
 			if (ret)
 				goto out;
 		}
@@ -6879,7 +6867,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		struct extent_buffer *leaf;
 		int slot;
 		struct btrfs_key search_key;
-		struct inode *inode;
+		struct btrfs_inode *inode;
 		u64 ino;
 		int ret = 0;
 
@@ -6894,11 +6882,10 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		if (IS_ERR(inode))
 			return PTR_ERR(inode);
 
-		if (BTRFS_I(inode)->generation >= trans->transid &&
-		    need_log_inode(trans, BTRFS_I(inode)))
-			ret = btrfs_log_inode(trans, BTRFS_I(inode),
-					      LOG_INODE_EXISTS, ctx);
-		btrfs_add_delayed_iput(BTRFS_I(inode));
+		if (inode->generation >= trans->transid &&
+		    need_log_inode(trans, inode))
+			ret = btrfs_log_inode(trans, inode, LOG_INODE_EXISTS, ctx);
+		btrfs_add_delayed_iput(inode);
 		if (ret)
 			return ret;
 
@@ -7476,6 +7463,8 @@ void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
  * full log sync.
  * Also we don't need to worry with renames, since btrfs_rename() marks the log
  * for full commit when renaming a subvolume.
+ *
+ * Must be called before creating the subvolume entry in its parent directory.
  */
 void btrfs_record_new_subvolume(const struct btrfs_trans_handle *trans,
 				struct btrfs_inode *dir)
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index a90d7d649739..60d2cf26e837 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -407,7 +407,7 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	}
 
 	it.index = index;
-	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
+	it.name = QSTR(name);
 	if (it.name.len > EROFS_NAME_LEN)
 		return -ERANGE;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 62c7fd1168a1..654f672639b3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3986,7 +3986,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 
 		if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
 				nr_pblocks % blks_per_sec ||
-				!f2fs_valid_pinned_area(sbi, pblock)) {
+				f2fs_is_sequential_zone_area(sbi, pblock)) {
 			bool last_extent = false;
 
 			not_aligned++;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 61b715cc2e23..a435550b2839 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1762,6 +1762,7 @@ struct f2fs_sb_info {
 	unsigned int dirty_device;		/* for checkpoint data flush */
 	spinlock_t dev_lock;			/* protect dirty_device */
 	bool aligned_blksize;			/* all devices has the same logical blksize */
+	unsigned int first_seq_zone_segno;	/* first segno in sequential zone */
 
 	/* For write statistics */
 	u64 sectors_written_start;
@@ -4556,12 +4557,16 @@ F2FS_FEATURE_FUNCS(compression, COMPRESSION);
 F2FS_FEATURE_FUNCS(readonly, RO);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
-				    block_t blkaddr)
+static inline bool f2fs_zone_is_seq(struct f2fs_sb_info *sbi, int devi,
+							unsigned int zone)
 {
-	unsigned int zno = blkaddr / sbi->blocks_per_blkz;
+	return test_bit(zone, FDEV(devi).blkz_seq);
+}
 
-	return test_bit(zno, FDEV(devi).blkz_seq);
+static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
+								block_t blkaddr)
+{
+	return f2fs_zone_is_seq(sbi, devi, blkaddr / sbi->blocks_per_blkz);
 }
 #endif
 
@@ -4633,15 +4638,31 @@ static inline bool f2fs_lfs_mode(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS;
 }
 
-static inline bool f2fs_valid_pinned_area(struct f2fs_sb_info *sbi,
+static inline bool f2fs_is_sequential_zone_area(struct f2fs_sb_info *sbi,
 					  block_t blkaddr)
 {
 	if (f2fs_sb_has_blkzoned(sbi)) {
+#ifdef CONFIG_BLK_DEV_ZONED
 		int devi = f2fs_target_device_index(sbi, blkaddr);
 
-		return !bdev_is_zoned(FDEV(devi).bdev);
+		if (!bdev_is_zoned(FDEV(devi).bdev))
+			return false;
+
+		if (f2fs_is_multi_device(sbi)) {
+			if (blkaddr < FDEV(devi).start_blk ||
+				blkaddr > FDEV(devi).end_blk) {
+				f2fs_err(sbi, "Invalid block %x", blkaddr);
+				return false;
+			}
+			blkaddr -= FDEV(devi).start_blk;
+		}
+
+		return f2fs_blkz_is_seq(sbi, devi, blkaddr);
+#else
+		return false;
+#endif
 	}
-	return true;
+	return false;
 }
 
 static inline bool f2fs_low_mem_mode(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 02f438cd6bfa..d9037e74631c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1828,7 +1828,8 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 		map.m_len = sec_blks;
 next_alloc:
-		if (has_not_enough_free_secs(sbi, 0,
+		if (has_not_enough_free_secs(sbi, 0, f2fs_sb_has_blkzoned(sbi) ?
+			ZONED_PIN_SEC_REQUIRED_COUNT :
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
 			f2fs_down_write(&sbi->gc_lock);
 			stat_inc_gc_call_count(sbi, FOREGROUND);
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 2914b678bf8f..5c1eaf55e127 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -35,6 +35,7 @@
 #define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
 #define DEF_MIGRATION_WINDOW_GRANULARITY_ZONED	3
 #define BOOST_GC_MULTIPLE	5
+#define ZONED_PIN_SEC_REQUIRED_COUNT	1
 
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 449c0acbfabc..e48b5e2efea2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2719,7 +2719,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV || pinning)
 			segno = 0;
 		else
-			segno = max(first_zoned_segno(sbi), *newseg);
+			segno = max(sbi->first_seq_zone_segno, *newseg);
 		hint = GET_SEC_FROM_SEG(sbi, segno);
 	}
 #endif
@@ -2731,7 +2731,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
 		/* Write only to sequential zones */
 		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_ONLY_SEQ) {
-			hint = GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi));
+			hint = GET_SEC_FROM_SEG(sbi, sbi->first_seq_zone_segno);
 			secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
 		} else
 			secno = find_first_zero_bit(free_i->free_secmap,
@@ -2784,9 +2784,9 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 		goto out_unlock;
 	}
 
-	/* no free section in conventional zone */
+	/* no free section in conventional device or conventional zone */
 	if (new_sec && pinning &&
-		!f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
+		f2fs_is_sequential_zone_area(sbi, START_BLOCK(sbi, segno))) {
 		ret = -EAGAIN;
 		goto out_unlock;
 	}
@@ -3250,7 +3250,8 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 
 	if (f2fs_sb_has_blkzoned(sbi) && err == -EAGAIN && gc_required) {
 		f2fs_down_write(&sbi->gc_lock);
-		err = f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_blk), true, 1);
+		err = f2fs_gc_range(sbi, 0, sbi->first_seq_zone_segno - 1,
+				true, ZONED_PIN_SEC_REQUIRED_COUNT);
 		f2fs_up_write(&sbi->gc_lock);
 
 		gc_required = false;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 05a342933f98..52bb1a281935 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -992,13 +992,3 @@ static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
 	dcc->discard_wake = true;
 	wake_up_interruptible_all(&dcc->discard_wait_queue);
 }
-
-static inline unsigned int first_zoned_segno(struct f2fs_sb_info *sbi)
-{
-	int devi;
-
-	for (devi = 0; devi < sbi->s_ndevs; devi++)
-		if (bdev_is_zoned(FDEV(devi).bdev))
-			return GET_SEGNO(sbi, FDEV(devi).start_blk);
-	return 0;
-}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f0e83ea56e38..3f2c6fa3623b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4260,6 +4260,37 @@ static void f2fs_record_error_work(struct work_struct *work)
 	f2fs_record_stop_reason(sbi);
 }
 
+static inline unsigned int get_first_seq_zone_segno(struct f2fs_sb_info *sbi)
+{
+#ifdef CONFIG_BLK_DEV_ZONED
+	unsigned int zoneno, total_zones;
+	int devi;
+
+	if (!f2fs_sb_has_blkzoned(sbi))
+		return NULL_SEGNO;
+
+	for (devi = 0; devi < sbi->s_ndevs; devi++) {
+		if (!bdev_is_zoned(FDEV(devi).bdev))
+			continue;
+
+		total_zones = GET_ZONE_FROM_SEG(sbi, FDEV(devi).total_segments);
+
+		for (zoneno = 0; zoneno < total_zones; zoneno++) {
+			unsigned int segs, blks;
+
+			if (!f2fs_zone_is_seq(sbi, devi, zoneno))
+				continue;
+
+			segs = GET_SEG_FROM_SEC(sbi,
+					zoneno * sbi->secs_per_zone);
+			blks = SEGS_TO_BLKS(sbi, segs);
+			return GET_SEGNO(sbi, FDEV(devi).start_blk + blks);
+		}
+	}
+#endif
+	return NULL_SEGNO;
+}
+
 static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
@@ -4294,6 +4325,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 #endif
 
 	for (i = 0; i < max_devices; i++) {
+		if (max_devices == 1) {
+			FDEV(i).total_segments =
+				le32_to_cpu(raw_super->segment_count_main);
+			FDEV(i).start_blk = 0;
+			FDEV(i).end_blk = FDEV(i).total_segments *
+						BLKS_PER_SEG(sbi);
+		}
+
 		if (i == 0)
 			FDEV(0).bdev_file = sbi->sb->s_bdev_file;
 		else if (!RDEV(i).path[0])
@@ -4660,6 +4699,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* For write statistics */
 	sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
 
+	/* get segno of first zoned block device */
+	sbi->first_seq_zone_segno = get_first_seq_zone_segno(sbi);
+
 	/* Read accumulated write IO statistics if exists */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	if (__exist_node_summaries(sbi))
diff --git a/fs/file_table.c b/fs/file_table.c
index 18735dc8269a..cf3422edf737 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -332,9 +332,7 @@ static struct file *alloc_file(const struct path *path, int flags,
 static inline int alloc_path_pseudo(const char *name, struct inode *inode,
 				    struct vfsmount *mnt, struct path *path)
 {
-	struct qstr this = QSTR_INIT(name, strlen(name));
-
-	path->dentry = d_alloc_pseudo(mnt->mnt_sb, &this);
+	path->dentry = d_alloc_pseudo(mnt->mnt_sb, &QSTR(name));
 	if (!path->dentry)
 		return -ENOMEM;
 	path->mnt = mntget(mnt);
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 68fc8af14700..eb4270e82ef8 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -37,27 +37,6 @@
 #include "aops.h"
 
 
-void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
-			     size_t from, size_t len)
-{
-	struct buffer_head *head = folio_buffers(folio);
-	unsigned int bsize = head->b_size;
-	struct buffer_head *bh;
-	size_t to = from + len;
-	size_t start, end;
-
-	for (bh = head, start = 0; bh != head || !start;
-	     bh = bh->b_this_page, start = end) {
-		end = start + bsize;
-		if (end <= from)
-			continue;
-		if (start >= to)
-			break;
-		set_buffer_uptodate(bh);
-		gfs2_trans_add_data(ip->i_gl, bh);
-	}
-}
-
 /**
  * gfs2_get_block_noalloc - Fills in a buffer head with details about a block
  * @inode: The inode
@@ -133,11 +112,42 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 					inode->i_sb->s_blocksize,
 					BIT(BH_Dirty)|BIT(BH_Uptodate));
 		}
-		gfs2_trans_add_databufs(ip, folio, 0, folio_size(folio));
+		gfs2_trans_add_databufs(ip->i_gl, folio, 0, folio_size(folio));
 	}
 	return gfs2_write_jdata_folio(folio, wbc);
 }
 
+/**
+ * gfs2_jdata_writeback - Write jdata folios to the log
+ * @mapping: The mapping to write
+ * @wbc: The writeback control
+ *
+ * Returns: errno
+ */
+int gfs2_jdata_writeback(struct address_space *mapping, struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_sbd *sdp = GFS2_SB(mapping->host);
+	struct folio *folio = NULL;
+	int error;
+
+	BUG_ON(current->journal_info);
+	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
+		return 0;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+		if (folio_test_checked(folio)) {
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+			continue;
+		}
+		error = __gfs2_jdata_write_folio(folio, wbc);
+	}
+
+	return error;
+}
+
 /**
  * gfs2_writepages - Write a bunch of dirty pages back to disk
  * @mapping: The mapping to write
diff --git a/fs/gfs2/aops.h b/fs/gfs2/aops.h
index a10c4334d248..bf002522a782 100644
--- a/fs/gfs2/aops.h
+++ b/fs/gfs2/aops.h
@@ -9,7 +9,6 @@
 #include "incore.h"
 
 void adjust_fs_space(struct inode *inode);
-void gfs2_trans_add_databufs(struct gfs2_inode *ip, struct folio *folio,
-			     size_t from, size_t len);
+int gfs2_jdata_writeback(struct address_space *mapping, struct writeback_control *wbc);
 
 #endif /* __AOPS_DOT_H__ */
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 1795c4e8dbf6..28ad07b00348 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -988,7 +988,8 @@ static void gfs2_iomap_put_folio(struct inode *inode, loff_t pos,
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
 	if (!gfs2_is_stuffed(ip))
-		gfs2_trans_add_databufs(ip, folio, offset_in_folio(folio, pos),
+		gfs2_trans_add_databufs(ip->i_gl, folio,
+					offset_in_folio(folio, pos),
 					copied);
 
 	folio_unlock(folio);
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index aecce4bb5e1a..161fc76ed5b0 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -807,6 +807,7 @@ __acquires(&gl->gl_lockref.lock)
 	}
 
 	if (ls->ls_ops->lm_lock) {
+		set_bit(GLF_PENDING_REPLY, &gl->gl_flags);
 		spin_unlock(&gl->gl_lockref.lock);
 		ret = ls->ls_ops->lm_lock(gl, target, lck_flags);
 		spin_lock(&gl->gl_lockref.lock);
@@ -825,6 +826,7 @@ __acquires(&gl->gl_lockref.lock)
 			/* The operation will be completed asynchronously. */
 			return;
 		}
+		clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
 	}
 
 	/* Complete the operation now. */
@@ -985,16 +987,22 @@ static bool gfs2_try_evict(struct gfs2_glock *gl)
 		ip = NULL;
 	spin_unlock(&gl->gl_lockref.lock);
 	if (ip) {
-		gl->gl_no_formal_ino = ip->i_no_formal_ino;
-		set_bit(GIF_DEFERRED_DELETE, &ip->i_flags);
+		wait_on_inode(&ip->i_inode);
+		if (is_bad_inode(&ip->i_inode)) {
+			iput(&ip->i_inode);
+			ip = NULL;
+		}
+	}
+	if (ip) {
+		set_bit(GLF_DEFER_DELETE, &gl->gl_flags);
 		d_prune_aliases(&ip->i_inode);
 		iput(&ip->i_inode);
+		clear_bit(GLF_DEFER_DELETE, &gl->gl_flags);
 
 		/* If the inode was evicted, gl->gl_object will now be NULL. */
 		spin_lock(&gl->gl_lockref.lock);
 		ip = gl->gl_object;
 		if (ip) {
-			clear_bit(GIF_DEFERRED_DELETE, &ip->i_flags);
 			if (!igrab(&ip->i_inode))
 				ip = NULL;
 		}
@@ -1954,6 +1962,7 @@ void gfs2_glock_complete(struct gfs2_glock *gl, int ret)
 	struct lm_lockstruct *ls = &gl->gl_name.ln_sbd->sd_lockstruct;
 
 	spin_lock(&gl->gl_lockref.lock);
+	clear_bit(GLF_PENDING_REPLY, &gl->gl_flags);
 	gl->gl_reply = ret;
 
 	if (unlikely(test_bit(DFL_BLOCK_LOCKS, &ls->ls_recover_flags))) {
@@ -2354,6 +2363,8 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'f';
 	if (test_bit(GLF_INVALIDATE_IN_PROGRESS, gflags))
 		*p++ = 'i';
+	if (test_bit(GLF_PENDING_REPLY, gflags))
+		*p++ = 'R';
 	if (test_bit(GLF_HAVE_REPLY, gflags))
 		*p++ = 'r';
 	if (test_bit(GLF_INITIAL, gflags))
@@ -2378,6 +2389,8 @@ static const char *gflags2str(char *buf, const struct gfs2_glock *gl)
 		*p++ = 'e';
 	if (test_bit(GLF_VERIFY_DELETE, gflags))
 		*p++ = 'E';
+	if (test_bit(GLF_DEFER_DELETE, gflags))
+		*p++ = 's';
 	*p = 0;
 	return buf;
 }
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 72a0601ce65e..4b6b23c638e2 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -494,11 +494,18 @@ int gfs2_inode_refresh(struct gfs2_inode *ip)
 static int inode_go_instantiate(struct gfs2_glock *gl)
 {
 	struct gfs2_inode *ip = gl->gl_object;
+	struct gfs2_glock *io_gl;
+	int error;
 
 	if (!ip) /* no inode to populate - read it in later */
 		return 0;
 
-	return gfs2_inode_refresh(ip);
+	error = gfs2_inode_refresh(ip);
+	if (error)
+		return error;
+	io_gl = ip->i_iopen_gh.gh_gl;
+	io_gl->gl_no_formal_ino = ip->i_no_formal_ino;
+	return 0;
 }
 
 static int inode_go_held(struct gfs2_holder *gh)
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index e5535d7b4659..142f61228d15 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -330,6 +330,8 @@ enum {
 	GLF_UNLOCKED			= 16, /* Wait for glock to be unlocked */
 	GLF_TRY_TO_EVICT		= 17, /* iopen glocks only */
 	GLF_VERIFY_DELETE		= 18, /* iopen glocks only */
+	GLF_PENDING_REPLY		= 19,
+	GLF_DEFER_DELETE		= 20, /* iopen glocks only */
 };
 
 struct gfs2_glock {
@@ -376,7 +378,6 @@ enum {
 	GIF_SW_PAGED		= 3,
 	GIF_FREE_VFS_INODE      = 5,
 	GIF_GLOP_PENDING	= 6,
-	GIF_DEFERRED_DELETE	= 7,
 };
 
 struct gfs2_inode {
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 3be24285ab01..0b546024f5ef 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -439,6 +439,74 @@ static int alloc_dinode(struct gfs2_inode *ip, u32 flags, unsigned *dblocks)
 	return error;
 }
 
+static void gfs2_final_release_pages(struct gfs2_inode *ip)
+{
+	struct inode *inode = &ip->i_inode;
+	struct gfs2_glock *gl = ip->i_gl;
+
+	if (unlikely(!gl)) {
+		/* This can only happen during incomplete inode creation. */
+		BUG_ON(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
+		return;
+	}
+
+	truncate_inode_pages(gfs2_glock2aspace(gl), 0);
+	truncate_inode_pages(&inode->i_data, 0);
+
+	if (atomic_read(&gl->gl_revokes) == 0) {
+		clear_bit(GLF_LFLUSH, &gl->gl_flags);
+		clear_bit(GLF_DIRTY, &gl->gl_flags);
+	}
+}
+
+int gfs2_dinode_dealloc(struct gfs2_inode *ip)
+{
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
+	struct gfs2_rgrpd *rgd;
+	struct gfs2_holder gh;
+	int error;
+
+	if (gfs2_get_inode_blocks(&ip->i_inode) != 1) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+
+	gfs2_rindex_update(sdp);
+
+	error = gfs2_quota_hold(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANGE);
+	if (error)
+		return error;
+
+	rgd = gfs2_blk2rgrpd(sdp, ip->i_no_addr, 1);
+	if (!rgd) {
+		gfs2_consist_inode(ip);
+		error = -EIO;
+		goto out_qs;
+	}
+
+	error = gfs2_glock_nq_init(rgd->rd_gl, LM_ST_EXCLUSIVE,
+				   LM_FLAG_NODE_SCOPE, &gh);
+	if (error)
+		goto out_qs;
+
+	error = gfs2_trans_begin(sdp, RES_RG_BIT + RES_STATFS + RES_QUOTA,
+				 sdp->sd_jdesc->jd_blocks);
+	if (error)
+		goto out_rg_gunlock;
+
+	gfs2_free_di(rgd, ip);
+
+	gfs2_final_release_pages(ip);
+
+	gfs2_trans_end(sdp);
+
+out_rg_gunlock:
+	gfs2_glock_dq_uninit(&gh);
+out_qs:
+	gfs2_quota_unhold(ip);
+	return error;
+}
+
 static void gfs2_init_dir(struct buffer_head *dibh,
 			  const struct gfs2_inode *parent)
 {
@@ -629,10 +697,11 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	struct gfs2_inode *dip = GFS2_I(dir), *ip;
 	struct gfs2_sbd *sdp = GFS2_SB(&dip->i_inode);
 	struct gfs2_glock *io_gl;
-	int error;
+	int error, dealloc_error;
 	u32 aflags = 0;
 	unsigned blocks = 1;
 	struct gfs2_diradd da = { .bh = NULL, .save_loc = 1, };
+	bool xattr_initialized = false;
 
 	if (!name->len || name->len > GFS2_FNAMESIZE)
 		return -ENAMETOOLONG;
@@ -745,12 +814,13 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_inode_glops, CREATE, &ip->i_gl);
 	if (error)
-		goto fail_free_inode;
+		goto fail_dealloc_inode;
 
 	error = gfs2_glock_get(sdp, ip->i_no_addr, &gfs2_iopen_glops, CREATE, &io_gl);
 	if (error)
-		goto fail_free_inode;
+		goto fail_dealloc_inode;
 	gfs2_cancel_delete_work(io_gl);
+	io_gl->gl_no_formal_ino = ip->i_no_formal_ino;
 
 retry:
 	error = insert_inode_locked4(inode, ip->i_no_addr, iget_test, &ip->i_no_addr);
@@ -772,8 +842,10 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	if (error)
 		goto fail_gunlock3;
 
-	if (blocks > 1)
+	if (blocks > 1) {
 		gfs2_init_xattr(ip);
+		xattr_initialized = true;
+	}
 	init_dinode(dip, ip, symname);
 	gfs2_trans_end(sdp);
 
@@ -828,6 +900,18 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_glock_dq_uninit(&ip->i_iopen_gh);
 fail_gunlock2:
 	gfs2_glock_put(io_gl);
+fail_dealloc_inode:
+	set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
+	dealloc_error = 0;
+	if (ip->i_eattr)
+		dealloc_error = gfs2_ea_dealloc(ip, xattr_initialized);
+	clear_nlink(inode);
+	mark_inode_dirty(inode);
+	if (!dealloc_error)
+		dealloc_error = gfs2_dinode_dealloc(ip);
+	if (dealloc_error)
+		fs_warn(sdp, "%s: %d\n", __func__, dealloc_error);
+	ip->i_no_addr = 0;
 fail_free_inode:
 	if (ip->i_gl) {
 		gfs2_glock_put(ip->i_gl);
@@ -842,10 +926,6 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	gfs2_dir_no_add(&da);
 	gfs2_glock_dq_uninit(&d_gh);
 	if (!IS_ERR_OR_NULL(inode)) {
-		set_bit(GIF_ALLOC_FAILED, &ip->i_flags);
-		clear_nlink(inode);
-		if (ip->i_no_addr)
-			mark_inode_dirty(inode);
 		if (inode->i_state & I_NEW)
 			iget_failed(inode);
 		else
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index fd15d1c6b6fb..225b9d0038cd 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -92,6 +92,7 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned type,
 struct inode *gfs2_lookup_by_inum(struct gfs2_sbd *sdp, u64 no_addr,
 				  u64 no_formal_ino,
 				  unsigned int blktype);
+int gfs2_dinode_dealloc(struct gfs2_inode *ip);
 
 int gfs2_inode_refresh(struct gfs2_inode *ip);
 
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index f9c5089783d2..115c4ac457e9 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -31,6 +31,7 @@
 #include "dir.h"
 #include "trace_gfs2.h"
 #include "trans.h"
+#include "aops.h"
 
 static void gfs2_log_shutdown(struct gfs2_sbd *sdp);
 
@@ -131,7 +132,11 @@ __acquires(&sdp->sd_ail_lock)
 		if (!mapping)
 			continue;
 		spin_unlock(&sdp->sd_ail_lock);
-		ret = mapping->a_ops->writepages(mapping, wbc);
+		BUG_ON(GFS2_SB(mapping->host) != sdp);
+		if (gfs2_is_jdata(GFS2_I(mapping->host)))
+			ret = gfs2_jdata_writeback(mapping, wbc);
+		else
+			ret = mapping->a_ops->writepages(mapping, wbc);
 		if (need_resched()) {
 			blk_finish_plug(plug);
 			cond_resched();
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 5ecb857cf74e..3b1303f97a3b 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -44,10 +44,10 @@
 #include "xattr.h"
 #include "lops.h"
 
-enum dinode_demise {
-	SHOULD_DELETE_DINODE,
-	SHOULD_NOT_DELETE_DINODE,
-	SHOULD_DEFER_EVICTION,
+enum evict_behavior {
+	EVICT_SHOULD_DELETE,
+	EVICT_SHOULD_SKIP_DELETE,
+	EVICT_SHOULD_DEFER_DELETE,
 };
 
 /**
@@ -1175,74 +1175,6 @@ static int gfs2_show_options(struct seq_file *s, struct dentry *root)
 	return 0;
 }
 
-static void gfs2_final_release_pages(struct gfs2_inode *ip)
-{
-	struct inode *inode = &ip->i_inode;
-	struct gfs2_glock *gl = ip->i_gl;
-
-	if (unlikely(!gl)) {
-		/* This can only happen during incomplete inode creation. */
-		BUG_ON(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags));
-		return;
-	}
-
-	truncate_inode_pages(gfs2_glock2aspace(gl), 0);
-	truncate_inode_pages(&inode->i_data, 0);
-
-	if (atomic_read(&gl->gl_revokes) == 0) {
-		clear_bit(GLF_LFLUSH, &gl->gl_flags);
-		clear_bit(GLF_DIRTY, &gl->gl_flags);
-	}
-}
-
-static int gfs2_dinode_dealloc(struct gfs2_inode *ip)
-{
-	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
-	struct gfs2_rgrpd *rgd;
-	struct gfs2_holder gh;
-	int error;
-
-	if (gfs2_get_inode_blocks(&ip->i_inode) != 1) {
-		gfs2_consist_inode(ip);
-		return -EIO;
-	}
-
-	gfs2_rindex_update(sdp);
-
-	error = gfs2_quota_hold(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHANGE);
-	if (error)
-		return error;
-
-	rgd = gfs2_blk2rgrpd(sdp, ip->i_no_addr, 1);
-	if (!rgd) {
-		gfs2_consist_inode(ip);
-		error = -EIO;
-		goto out_qs;
-	}
-
-	error = gfs2_glock_nq_init(rgd->rd_gl, LM_ST_EXCLUSIVE,
-				   LM_FLAG_NODE_SCOPE, &gh);
-	if (error)
-		goto out_qs;
-
-	error = gfs2_trans_begin(sdp, RES_RG_BIT + RES_STATFS + RES_QUOTA,
-				 sdp->sd_jdesc->jd_blocks);
-	if (error)
-		goto out_rg_gunlock;
-
-	gfs2_free_di(rgd, ip);
-
-	gfs2_final_release_pages(ip);
-
-	gfs2_trans_end(sdp);
-
-out_rg_gunlock:
-	gfs2_glock_dq_uninit(&gh);
-out_qs:
-	gfs2_quota_unhold(ip);
-	return error;
-}
-
 /**
  * gfs2_glock_put_eventually
  * @gl:	The glock to put
@@ -1315,23 +1247,21 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
  *
  * Returns: the fate of the dinode
  */
-static enum dinode_demise evict_should_delete(struct inode *inode,
-					      struct gfs2_holder *gh)
+static enum evict_behavior evict_should_delete(struct inode *inode,
+					       struct gfs2_holder *gh)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct super_block *sb = inode->i_sb;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int ret;
 
-	if (unlikely(test_bit(GIF_ALLOC_FAILED, &ip->i_flags)))
-		goto should_delete;
-
-	if (test_bit(GIF_DEFERRED_DELETE, &ip->i_flags))
-		return SHOULD_DEFER_EVICTION;
+	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
+	    test_bit(GLF_DEFER_DELETE, &ip->i_iopen_gh.gh_gl->gl_flags))
+		return EVICT_SHOULD_DEFER_DELETE;
 
 	/* Deletes should never happen under memory pressure anymore.  */
 	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC))
-		return SHOULD_DEFER_EVICTION;
+		return EVICT_SHOULD_DEFER_DELETE;
 
 	/* Must not read inode block until block type has been verified */
 	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_SKIP, gh);
@@ -1339,34 +1269,33 @@ static enum dinode_demise evict_should_delete(struct inode *inode,
 		glock_clear_object(ip->i_iopen_gh.gh_gl, ip);
 		ip->i_iopen_gh.gh_flags |= GL_NOCACHE;
 		gfs2_glock_dq_uninit(&ip->i_iopen_gh);
-		return SHOULD_DEFER_EVICTION;
+		return EVICT_SHOULD_DEFER_DELETE;
 	}
 
 	if (gfs2_inode_already_deleted(ip->i_gl, ip->i_no_formal_ino))
-		return SHOULD_NOT_DELETE_DINODE;
+		return EVICT_SHOULD_SKIP_DELETE;
 	ret = gfs2_check_blk_type(sdp, ip->i_no_addr, GFS2_BLKST_UNLINKED);
 	if (ret)
-		return SHOULD_NOT_DELETE_DINODE;
+		return EVICT_SHOULD_SKIP_DELETE;
 
 	ret = gfs2_instantiate(gh);
 	if (ret)
-		return SHOULD_NOT_DELETE_DINODE;
+		return EVICT_SHOULD_SKIP_DELETE;
 
 	/*
 	 * The inode may have been recreated in the meantime.
 	 */
 	if (inode->i_nlink)
-		return SHOULD_NOT_DELETE_DINODE;
+		return EVICT_SHOULD_SKIP_DELETE;
 
-should_delete:
 	if (gfs2_holder_initialized(&ip->i_iopen_gh) &&
 	    test_bit(HIF_HOLDER, &ip->i_iopen_gh.gh_iflags)) {
 		if (!gfs2_upgrade_iopen_glock(inode)) {
 			gfs2_holder_uninit(&ip->i_iopen_gh);
-			return SHOULD_NOT_DELETE_DINODE;
+			return EVICT_SHOULD_SKIP_DELETE;
 		}
 	}
-	return SHOULD_DELETE_DINODE;
+	return EVICT_SHOULD_DELETE;
 }
 
 /**
@@ -1386,7 +1315,7 @@ static int evict_unlinked_inode(struct inode *inode)
 	}
 
 	if (ip->i_eattr) {
-		ret = gfs2_ea_dealloc(ip);
+		ret = gfs2_ea_dealloc(ip, true);
 		if (ret)
 			goto out;
 	}
@@ -1477,6 +1406,7 @@ static void gfs2_evict_inode(struct inode *inode)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
+	enum evict_behavior behavior;
 	int ret;
 
 	if (inode->i_nlink || sb_rdonly(sb) || !ip->i_no_addr)
@@ -1491,10 +1421,10 @@ static void gfs2_evict_inode(struct inode *inode)
 		goto out;
 
 	gfs2_holder_mark_uninitialized(&gh);
-	ret = evict_should_delete(inode, &gh);
-	if (ret == SHOULD_DEFER_EVICTION)
+	behavior = evict_should_delete(inode, &gh);
+	if (behavior == EVICT_SHOULD_DEFER_DELETE)
 		goto out;
-	if (ret == SHOULD_DELETE_DINODE)
+	if (behavior == EVICT_SHOULD_DELETE)
 		ret = evict_unlinked_inode(inode);
 	else
 		ret = evict_linked_inode(inode);
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index 8eae8d62a413..43de603ab347 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -53,12 +53,19 @@
 	{(1UL << GLF_DIRTY),			"y" },		\
 	{(1UL << GLF_LFLUSH),			"f" },		\
 	{(1UL << GLF_INVALIDATE_IN_PROGRESS),	"i" },		\
+	{(1UL << GLF_PENDING_REPLY),		"R" },		\
 	{(1UL << GLF_HAVE_REPLY),		"r" },		\
 	{(1UL << GLF_INITIAL),			"a" },		\
 	{(1UL << GLF_HAVE_FROZEN_REPLY),	"F" },		\
 	{(1UL << GLF_LRU),			"L" },		\
 	{(1UL << GLF_OBJECT),			"o" },		\
-	{(1UL << GLF_BLOCKING),			"b" })
+	{(1UL << GLF_BLOCKING),			"b" },		\
+	{(1UL << GLF_UNLOCKED),			"x" },		\
+	{(1UL << GLF_INSTANTIATE_NEEDED),	"n" },		\
+	{(1UL << GLF_INSTANTIATE_IN_PROG),	"N" },		\
+	{(1UL << GLF_TRY_TO_EVICT),		"e" },		\
+	{(1UL << GLF_VERIFY_DELETE),		"E" },		\
+	{(1UL << GLF_DEFER_DELETE),		"s" })
 
 #ifndef NUMPTY
 #define NUMPTY
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 192213c7359a..42cf8c5204db 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -226,6 +226,27 @@ void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 	unlock_buffer(bh);
 }
 
+void gfs2_trans_add_databufs(struct gfs2_glock *gl, struct folio *folio,
+			     size_t from, size_t len)
+{
+	struct buffer_head *head = folio_buffers(folio);
+	unsigned int bsize = head->b_size;
+	struct buffer_head *bh;
+	size_t to = from + len;
+	size_t start, end;
+
+	for (bh = head, start = 0; bh != head || !start;
+	     bh = bh->b_this_page, start = end) {
+		end = start + bsize;
+		if (end <= from)
+			continue;
+		if (start >= to)
+			break;
+		set_buffer_uptodate(bh);
+		gfs2_trans_add_data(gl, bh);
+	}
+}
+
 void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 {
 
diff --git a/fs/gfs2/trans.h b/fs/gfs2/trans.h
index f8ce5302280d..790c55f59e61 100644
--- a/fs/gfs2/trans.h
+++ b/fs/gfs2/trans.h
@@ -42,6 +42,8 @@ int gfs2_trans_begin(struct gfs2_sbd *sdp, unsigned int blocks,
 
 void gfs2_trans_end(struct gfs2_sbd *sdp);
 void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh);
+void gfs2_trans_add_databufs(struct gfs2_glock *gl, struct folio *folio,
+			     size_t from, size_t len);
 void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh);
 void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, struct gfs2_bufdata *bd);
 void gfs2_trans_remove_revoke(struct gfs2_sbd *sdp, u64 blkno, unsigned int len);
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 17ae5070a90e..df9c93de94c7 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1383,7 +1383,7 @@ static int ea_dealloc_indirect(struct gfs2_inode *ip)
 	return error;
 }
 
-static int ea_dealloc_block(struct gfs2_inode *ip)
+static int ea_dealloc_block(struct gfs2_inode *ip, bool initialized)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
 	struct gfs2_rgrpd *rgd;
@@ -1416,7 +1416,7 @@ static int ea_dealloc_block(struct gfs2_inode *ip)
 	ip->i_eattr = 0;
 	gfs2_add_inode_blocks(&ip->i_inode, -1);
 
-	if (likely(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags))) {
+	if (initialized) {
 		error = gfs2_meta_inode_buffer(ip, &dibh);
 		if (!error) {
 			gfs2_trans_add_meta(ip->i_gl, dibh);
@@ -1435,11 +1435,12 @@ static int ea_dealloc_block(struct gfs2_inode *ip)
 /**
  * gfs2_ea_dealloc - deallocate the extended attribute fork
  * @ip: the inode
+ * @initialized: xattrs have been initialized
  *
  * Returns: errno
  */
 
-int gfs2_ea_dealloc(struct gfs2_inode *ip)
+int gfs2_ea_dealloc(struct gfs2_inode *ip, bool initialized)
 {
 	int error;
 
@@ -1451,7 +1452,7 @@ int gfs2_ea_dealloc(struct gfs2_inode *ip)
 	if (error)
 		return error;
 
-	if (likely(!test_bit(GIF_ALLOC_FAILED, &ip->i_flags))) {
+	if (initialized) {
 		error = ea_foreach(ip, ea_dealloc_unstuffed, NULL);
 		if (error)
 			goto out_quota;
@@ -1463,7 +1464,7 @@ int gfs2_ea_dealloc(struct gfs2_inode *ip)
 		}
 	}
 
-	error = ea_dealloc_block(ip);
+	error = ea_dealloc_block(ip, initialized);
 
 out_quota:
 	gfs2_quota_unhold(ip);
diff --git a/fs/gfs2/xattr.h b/fs/gfs2/xattr.h
index eb12eb7e37c1..3c9788e0e137 100644
--- a/fs/gfs2/xattr.h
+++ b/fs/gfs2/xattr.h
@@ -54,7 +54,7 @@ int __gfs2_xattr_set(struct inode *inode, const char *name,
 		     const void *value, size_t size,
 		     int flags, int type);
 ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size);
-int gfs2_ea_dealloc(struct gfs2_inode *ip);
+int gfs2_ea_dealloc(struct gfs2_inode *ip, bool initialized);
 
 /* Exported to acl.c */
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 1943c8bd479b..2d9d5dfa19b8 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -928,7 +928,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		if (!inode)
 			continue;
 
-		name = (struct qstr)QSTR_INIT(kn->name, strlen(kn->name));
+		name = QSTR(kn->name);
 		parent = kernfs_get_parent(kn);
 		if (parent) {
 			p_inode = ilookup(info->sb, kernfs_ino(parent));
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index b3910dfcb56d..896d1d4219ed 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -64,6 +64,7 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
 		return;
 	}
 
+	spin_lock(&inode->i_lock);
 	i_size_write(inode, pos);
 #if IS_ENABLED(CONFIG_FSCACHE)
 	fscache_update_cookie(ctx->cache, NULL, &pos);
@@ -77,6 +78,7 @@ static void netfs_update_i_size(struct netfs_inode *ctx, struct inode *inode,
 					DIV_ROUND_UP(pos, SECTOR_SIZE),
 					inode->i_blocks + add);
 	}
+	spin_unlock(&inode->i_lock);
 }
 
 /**
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 26cf9c94deeb..8fbfaf71c154 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -14,13 +14,17 @@ static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
 	struct inode *inode = wreq->inode;
 	unsigned long long end = wreq->start + wreq->transferred;
 
-	if (!wreq->error &&
-	    i_size_read(inode) < end) {
+	if (wreq->error || end <= i_size_read(inode))
+		return;
+
+	spin_lock(&inode->i_lock);
+	if (end > i_size_read(inode)) {
 		if (wreq->netfs_ops->update_i_size)
 			wreq->netfs_ops->update_i_size(inode, end);
 		else
 			i_size_write(inode, end);
 	}
+	spin_unlock(&inode->i_lock);
 }
 
 /*
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 412d4da74227..7cb21da40a0a 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -176,9 +176,10 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
-				struct iov_iter source = subreq->io_iter;
+				struct iov_iter source;
 
-				iov_iter_revert(&source, subreq->len - source.count);
+				netfs_reset_iter(subreq);
+				source = subreq->io_iter;
 				__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 				netfs_reissue_write(stream, subreq, &source);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8f7ea4076653..bf96f7a8900c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1104,6 +1104,7 @@ static void ff_layout_reset_read(struct nfs_pgio_header *hdr)
 }
 
 static int ff_layout_async_handle_error_v4(struct rpc_task *task,
+					   u32 op_status,
 					   struct nfs4_state *state,
 					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
@@ -1114,32 +1115,42 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
 	struct nfs4_slot_table *tbl = &clp->cl_session->fc_slot_table;
 
-	switch (task->tk_status) {
-	case -NFS4ERR_BADSESSION:
-	case -NFS4ERR_BADSLOT:
-	case -NFS4ERR_BAD_HIGH_SLOT:
-	case -NFS4ERR_DEADSESSION:
-	case -NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
-	case -NFS4ERR_SEQ_FALSE_RETRY:
-	case -NFS4ERR_SEQ_MISORDERED:
+	switch (op_status) {
+	case NFS4_OK:
+	case NFS4ERR_NXIO:
+		break;
+	case NFSERR_PERM:
+		if (!task->tk_xprt)
+			break;
+		xprt_force_disconnect(task->tk_xprt);
+		goto out_retry;
+	case NFS4ERR_BADSESSION:
+	case NFS4ERR_BADSLOT:
+	case NFS4ERR_BAD_HIGH_SLOT:
+	case NFS4ERR_DEADSESSION:
+	case NFS4ERR_CONN_NOT_BOUND_TO_SESSION:
+	case NFS4ERR_SEQ_FALSE_RETRY:
+	case NFS4ERR_SEQ_MISORDERED:
 		dprintk("%s ERROR %d, Reset session. Exchangeid "
 			"flags 0x%x\n", __func__, task->tk_status,
 			clp->cl_exchange_flags);
 		nfs4_schedule_session_recovery(clp->cl_session, task->tk_status);
-		break;
-	case -NFS4ERR_DELAY:
-	case -NFS4ERR_GRACE:
+		goto out_retry;
+	case NFS4ERR_DELAY:
+		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
+		fallthrough;
+	case NFS4ERR_GRACE:
 		rpc_delay(task, FF_LAYOUT_POLL_RETRY_MAX);
-		break;
-	case -NFS4ERR_RETRY_UNCACHED_REP:
-		break;
+		goto out_retry;
+	case NFS4ERR_RETRY_UNCACHED_REP:
+		goto out_retry;
 	/* Invalidate Layout errors */
-	case -NFS4ERR_PNFS_NO_LAYOUT:
-	case -ESTALE:           /* mapped NFS4ERR_STALE */
-	case -EBADHANDLE:       /* mapped NFS4ERR_BADHANDLE */
-	case -EISDIR:           /* mapped NFS4ERR_ISDIR */
-	case -NFS4ERR_FHEXPIRED:
-	case -NFS4ERR_WRONG_TYPE:
+	case NFS4ERR_PNFS_NO_LAYOUT:
+	case NFS4ERR_STALE:
+	case NFS4ERR_BADHANDLE:
+	case NFS4ERR_ISDIR:
+	case NFS4ERR_FHEXPIRED:
+	case NFS4ERR_WRONG_TYPE:
 		dprintk("%s Invalid layout error %d\n", __func__,
 			task->tk_status);
 		/*
@@ -1152,6 +1163,11 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		pnfs_destroy_layout(NFS_I(inode));
 		rpc_wake_up(&tbl->slot_tbl_waitq);
 		goto reset;
+	default:
+		break;
+	}
+
+	switch (task->tk_status) {
 	/* RPC connection errors */
 	case -ECONNREFUSED:
 	case -EHOSTDOWN:
@@ -1167,26 +1183,56 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
 		rpc_wake_up(&tbl->slot_tbl_waitq);
-		fallthrough;
+		break;
 	default:
-		if (ff_layout_avoid_mds_available_ds(lseg))
-			return -NFS4ERR_RESET_TO_PNFS;
-reset:
-		dprintk("%s Retry through MDS. Error %d\n", __func__,
-			task->tk_status);
-		return -NFS4ERR_RESET_TO_MDS;
+		break;
 	}
+
+	if (ff_layout_avoid_mds_available_ds(lseg))
+		return -NFS4ERR_RESET_TO_PNFS;
+reset:
+	dprintk("%s Retry through MDS. Error %d\n", __func__,
+		task->tk_status);
+	return -NFS4ERR_RESET_TO_MDS;
+
+out_retry:
 	task->tk_status = 0;
 	return -EAGAIN;
 }
 
 /* Retry all errors through either pNFS or MDS except for -EJUKEBOX */
 static int ff_layout_async_handle_error_v3(struct rpc_task *task,
+					   u32 op_status,
+					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
 					   u32 idx)
 {
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
 
+	switch (op_status) {
+	case NFS_OK:
+	case NFSERR_NXIO:
+		break;
+	case NFSERR_PERM:
+		if (!task->tk_xprt)
+			break;
+		xprt_force_disconnect(task->tk_xprt);
+		goto out_retry;
+	case NFSERR_ACCES:
+	case NFSERR_BADHANDLE:
+	case NFSERR_FBIG:
+	case NFSERR_IO:
+	case NFSERR_NOSPC:
+	case NFSERR_ROFS:
+	case NFSERR_STALE:
+		goto out_reset_to_pnfs;
+	case NFSERR_JUKEBOX:
+		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
+		goto out_retry;
+	default:
+		break;
+	}
+
 	switch (task->tk_status) {
 	/* File access problems. Don't mark the device as unavailable */
 	case -EACCES:
@@ -1205,6 +1251,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 		nfs4_delete_deviceid(devid->ld, devid->nfs_client,
 				&devid->deviceid);
 	}
+out_reset_to_pnfs:
 	/* FIXME: Need to prevent infinite looping here. */
 	return -NFS4ERR_RESET_TO_PNFS;
 out_retry:
@@ -1215,6 +1262,7 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 }
 
 static int ff_layout_async_handle_error(struct rpc_task *task,
+					u32 op_status,
 					struct nfs4_state *state,
 					struct nfs_client *clp,
 					struct pnfs_layout_segment *lseg,
@@ -1233,10 +1281,11 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 
 	switch (vers) {
 	case 3:
-		return ff_layout_async_handle_error_v3(task, lseg, idx);
-	case 4:
-		return ff_layout_async_handle_error_v4(task, state, clp,
+		return ff_layout_async_handle_error_v3(task, op_status, clp,
 						       lseg, idx);
+	case 4:
+		return ff_layout_async_handle_error_v4(task, op_status, state,
+						       clp, lseg, idx);
 	default:
 		/* should never happen */
 		WARN_ON_ONCE(1);
@@ -1289,6 +1338,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 	switch (status) {
 	case NFS4ERR_DELAY:
 	case NFS4ERR_GRACE:
+	case NFS4ERR_PERM:
 		break;
 	case NFS4ERR_NXIO:
 		ff_layout_mark_ds_unreachable(lseg, idx);
@@ -1321,7 +1371,8 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 		trace_ff_layout_read_error(hdr);
 	}
 
-	err = ff_layout_async_handle_error(task, hdr->args.context->state,
+	err = ff_layout_async_handle_error(task, hdr->res.op_status,
+					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
 
@@ -1491,7 +1542,8 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 		trace_ff_layout_write_error(hdr);
 	}
 
-	err = ff_layout_async_handle_error(task, hdr->args.context->state,
+	err = ff_layout_async_handle_error(task, hdr->res.op_status,
+					   hdr->args.context->state,
 					   hdr->ds_clp, hdr->lseg,
 					   hdr->pgio_mirror_idx);
 
@@ -1537,8 +1589,9 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 		trace_ff_layout_commit_error(data);
 	}
 
-	err = ff_layout_async_handle_error(task, NULL, data->ds_clp,
-					   data->lseg, data->ds_commit_index);
+	err = ff_layout_async_handle_error(task, data->res.op_status,
+					   NULL, data->ds_clp, data->lseg,
+					   data->ds_commit_index);
 
 	trace_nfs4_pnfs_commit_ds(data, err);
 	switch (err) {
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 16607b24ab9c..8827cb00f86d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2586,15 +2586,26 @@ EXPORT_SYMBOL_GPL(nfs_net_id);
 static int nfs_net_init(struct net *net)
 {
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
+	int err;
 
 	nfs_clients_init(net);
 
 	if (!rpc_proc_register(net, &nn->rpcstats)) {
-		nfs_clients_exit(net);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_proc_rpc;
 	}
 
-	return nfs_fs_proc_net_init(net);
+	err = nfs_fs_proc_net_init(net);
+	if (err)
+		goto err_proc_nfs;
+
+	return 0;
+
+err_proc_nfs:
+	rpc_proc_unregister(net, "nfs");
+err_proc_rpc:
+	nfs_clients_exit(net);
+	return err;
 }
 
 static void nfs_net_exit(struct net *net)
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 683e09be25ad..6b888e9ff394 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2051,8 +2051,10 @@ static void nfs_layoutget_begin(struct pnfs_layout_hdr *lo)
 static void nfs_layoutget_end(struct pnfs_layout_hdr *lo)
 {
 	if (atomic_dec_and_test(&lo->plh_outstanding) &&
-	    test_and_clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags))
+	    test_and_clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags)) {
+		smp_mb__after_atomic();
 		wake_up_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN);
+	}
 }
 
 static bool pnfs_is_first_layoutget(struct pnfs_layout_hdr *lo)
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index c66655adecb2..b74637ae9085 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -743,6 +743,7 @@ struct TCP_Server_Info {
 	__le32 session_key_id; /* retrieved from negotiate response and send in session setup request */
 	struct session_key session_key;
 	unsigned long lstrp; /* when we got last response from this server */
+	unsigned long neg_start; /* when negotiate started (jiffies) */
 	struct cifs_secmech secmech; /* crypto sec mech functs, descriptors */
 #define	CIFS_NEGFLAVOR_UNENCAP	1	/* wct == 17, but no ext_sec */
 #define	CIFS_NEGFLAVOR_EXTENDED	2	/* wct == 17, ext_sec bit set */
@@ -1275,6 +1276,7 @@ struct cifs_tcon {
 	bool use_persistent:1; /* use persistent instead of durable handles */
 	bool no_lease:1;    /* Do not request leases on files or directories */
 	bool use_witness:1; /* use witness protocol */
+	bool dummy:1; /* dummy tcon used for reconnecting channels */
 	__le32 capabilities;
 	__u32 share_flags;
 	__u32 maximal_access;
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 6e938b17875f..fee7bc9848a3 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -136,6 +136,7 @@ extern int SendReceiveBlockingLock(const unsigned int xid,
 			struct smb_hdr *out_buf,
 			int *bytes_returned);
 
+void smb2_query_server_interfaces(struct work_struct *work);
 void
 cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
 				      bool all_channels);
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index d6ba55d4720d..e3d9367eaec3 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1310,6 +1310,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
+		__set_bit(NETFS_SREQ_NEED_RETRY, &rdata->subreq.flags);
 		rdata->result = -EAGAIN;
 		if (server->sign && rdata->got_bytes)
 			/* reset bytes number since we can not check a sign */
@@ -1681,6 +1682,7 @@ cifs_writev_callback(struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
+		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 		result = -EAGAIN;
 		break;
 	default:
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9275e0d1e2f6..ebc380b18da7 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -113,7 +113,7 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
 	return rc;
 }
 
-static void smb2_query_server_interfaces(struct work_struct *work)
+void smb2_query_server_interfaces(struct work_struct *work)
 {
 	int rc;
 	int xid;
@@ -677,12 +677,12 @@ server_unresponsive(struct TCP_Server_Info *server)
 	/*
 	 * If we're in the process of mounting a share or reconnecting a session
 	 * and the server abruptly shut down (e.g. socket wasn't closed, packet
-	 * had been ACK'ed but no SMB response), don't wait longer than 20s to
-	 * negotiate protocol.
+	 * had been ACK'ed but no SMB response), don't wait longer than 20s from
+	 * when negotiate actually started.
 	 */
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsInNegotiate &&
-	    time_after(jiffies, server->lstrp + 20 * HZ)) {
+	    time_after(jiffies, server->neg_start + 20 * HZ)) {
 		spin_unlock(&server->srv_lock);
 		cifs_reconnect(server, false);
 		return true;
@@ -2819,20 +2819,14 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	tcon->max_cached_dirs = ctx->max_cached_dirs;
 	tcon->nodelete = ctx->nodelete;
 	tcon->local_lease = ctx->local_lease;
-	INIT_LIST_HEAD(&tcon->pending_opens);
 	tcon->status = TID_GOOD;
 
-	INIT_DELAYED_WORK(&tcon->query_interfaces,
-			  smb2_query_server_interfaces);
 	if (ses->server->dialect >= SMB30_PROT_ID &&
 	    (ses->server->capabilities & SMB2_GLOBAL_CAP_MULTI_CHANNEL)) {
 		/* schedule query interfaces poll */
 		queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
 				   (SMB_INTERFACE_POLL_INTERVAL * HZ));
 	}
-#ifdef CONFIG_CIFS_DFS_UPCALL
-	INIT_DELAYED_WORK(&tcon->dfs_cache_work, dfs_cache_refresh);
-#endif
 	spin_lock(&cifs_tcp_ses_lock);
 	list_add(&tcon->tcon_list, &ses->tcon_list);
 	spin_unlock(&cifs_tcp_ses_lock);
@@ -4009,6 +4003,7 @@ cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses,
 
 	server->lstrp = jiffies;
 	server->tcpStatus = CifsInNegotiate;
+	server->neg_start = jiffies;
 	spin_unlock(&server->srv_lock);
 
 	rc = server->ops->negotiate(xid, ses, server);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 5122f3895dfc..57b6b191293e 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -148,6 +148,12 @@ tcon_info_alloc(bool dir_leases_enabled, enum smb3_tcon_ref_trace trace)
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	INIT_LIST_HEAD(&ret_buf->dfs_ses_list);
 #endif
+	INIT_LIST_HEAD(&ret_buf->pending_opens);
+	INIT_DELAYED_WORK(&ret_buf->query_interfaces,
+			  smb2_query_server_interfaces);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	INIT_DELAYED_WORK(&ret_buf->dfs_cache_work, dfs_cache_refresh);
+#endif
 
 	return ret_buf;
 }
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index c3feb26fcfd0..7bf3214117a9 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -263,7 +263,7 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 	/* The Mode field in the response can now include the file type as well */
 	fattr->cf_mode = wire_mode_to_posix(le32_to_cpu(info->Mode),
 					    fattr->cf_cifsattrs & ATTR_DIRECTORY);
-	fattr->cf_dtype = S_DT(le32_to_cpu(info->Mode));
+	fattr->cf_dtype = S_DT(fattr->cf_mode);
 
 	switch (fattr->cf_mode & S_IFMT) {
 	case S_IFLNK:
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index c6ae395a4692..d514f95deb7e 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -440,9 +440,9 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		free_xid(xid);
 		ses->flags &= ~CIFS_SES_FLAGS_PENDING_QUERY_INTERFACES;
 
-		/* regardless of rc value, setup polling */
-		queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
-				   (SMB_INTERFACE_POLL_INTERVAL * HZ));
+		if (!tcon->ipc && !tcon->dummy)
+			queue_delayed_work(cifsiod_wq, &tcon->query_interfaces,
+					   (SMB_INTERFACE_POLL_INTERVAL * HZ));
 
 		mutex_unlock(&ses->session_mutex);
 
@@ -4234,10 +4234,8 @@ void smb2_reconnect_server(struct work_struct *work)
 		}
 		goto done;
 	}
-
 	tcon->status = TID_GOOD;
-	tcon->retry = false;
-	tcon->need_reconnect = false;
+	tcon->dummy = true;
 
 	/* now reconnect sessions for necessary channels */
 	list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
@@ -4871,6 +4869,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
+		__set_bit(NETFS_SREQ_NEED_RETRY, &wdata->subreq.flags);
 		result = -EAGAIN;
 		break;
 	case MID_RESPONSE_MALFORMED:
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 50eeb5b86ed7..fb33458f2fc7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -349,7 +349,7 @@ struct bpf_func_state {
 
 #define MAX_CALL_FRAMES 8
 
-/* instruction history flags, used in bpf_jmp_history_entry.flags field */
+/* instruction history flags, used in bpf_insn_hist_entry.flags field */
 enum {
 	/* instruction references stack slot through PTR_TO_STACK register;
 	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES is 8)
@@ -361,18 +361,22 @@ enum {
 	INSN_F_SPI_MASK = 0x3f, /* 6 bits */
 	INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
 
-	INSN_F_STACK_ACCESS = BIT(9), /* we need 10 bits total */
+	INSN_F_STACK_ACCESS = BIT(9),
+
+	INSN_F_DST_REG_STACK = BIT(10), /* dst_reg is PTR_TO_STACK */
+	INSN_F_SRC_REG_STACK = BIT(11), /* src_reg is PTR_TO_STACK */
+	/* total 12 bits are used now. */
 };
 
 static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
 static_assert(INSN_F_SPI_MASK + 1 >= MAX_BPF_STACK / 8);
 
-struct bpf_jmp_history_entry {
+struct bpf_insn_hist_entry {
 	u32 idx;
 	/* insn idx can't be bigger than 1 million */
-	u32 prev_idx : 22;
-	/* special flags, e.g., whether insn is doing register stack spill/load */
-	u32 flags : 10;
+	u32 prev_idx : 20;
+	/* special INSN_F_xxx flags */
+	u32 flags : 12;
 	/* additional registers that need precision tracking when this
 	 * jump is backtracked, vector of six 10-bit records
 	 */
@@ -458,13 +462,14 @@ struct bpf_verifier_state {
 	 * See get_loop_entry() for more information.
 	 */
 	struct bpf_verifier_state *loop_entry;
-	/* jmp history recorded from first to last.
-	 * backtracking is using it to go from last to first.
-	 * For most states jmp_history_cnt is [0-3].
+	/* Sub-range of env->insn_hist[] corresponding to this state's
+	 * instruction history.
+	 * Backtracking is using it to go from last to first.
+	 * For most states instruction history is short, 0-3 instructions.
 	 * For loops can go up to ~40.
 	 */
-	struct bpf_jmp_history_entry *jmp_history;
-	u32 jmp_history_cnt;
+	u32 insn_hist_start;
+	u32 insn_hist_end;
 	u32 dfs_depth;
 	u32 callback_unroll_depth;
 	u32 may_goto_depth;
@@ -748,7 +753,9 @@ struct bpf_verifier_env {
 		int cur_stack;
 	} cfg;
 	struct backtrack_state bt;
-	struct bpf_jmp_history_entry *cur_hist_ent;
+	struct bpf_insn_hist_entry *insn_hist;
+	struct bpf_insn_hist_entry *cur_hist_ent;
+	u32 insn_hist_cap;
 	u32 pass_cnt; /* number of times do_check() was called */
 	u32 subprog_cnt;
 	/* number of instructions analyzed by the verifier */
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index cc668a054d09..4342b5694909 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -79,6 +79,7 @@ extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
 					       struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_indirect_target_selection(struct device *dev,
 						  struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index bff956f7b2b9..3d53a6014591 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -57,6 +57,7 @@ struct qstr {
 };
 
 #define QSTR_INIT(n,l) { { { .len = l } }, .name = n }
+#define QSTR(n) (struct qstr)QSTR_INIT(n, strlen(n))
 
 extern const struct qstr empty_name;
 extern const struct qstr slash_name;
diff --git a/include/linux/export.h b/include/linux/export.h
index 1e04dbc675c2..b40ae79b767d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -24,11 +24,17 @@
 	.long sym
 #endif
 
-#define ___EXPORT_SYMBOL(sym, license, ns)		\
+/*
+ * LLVM integrated assembler cam merge adjacent string literals (like
+ * C and GNU-as) passed to '.ascii', but not to '.asciz' and chokes on:
+ *
+ *   .asciz "MODULE_" "kvm" ;
+ */
+#define ___EXPORT_SYMBOL(sym, license, ns...)		\
 	.section ".export_symbol","a"		ASM_NL	\
 	__export_symbol_##sym:			ASM_NL	\
 		.asciz license			ASM_NL	\
-		.asciz ns			ASM_NL	\
+		.ascii ns "\0"			ASM_NL	\
 		__EXPORT_SYMBOL_REF(sym)	ASM_NL	\
 	.previous
 
@@ -70,4 +76,6 @@
 #define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", __stringify(ns))
 #define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "GPL", __stringify(ns))
 
+#define EXPORT_SYMBOL_GPL_FOR_MODULES(sym, mods) __EXPORT_SYMBOL(sym, "GPL", "module:" mods)
+
 #endif /* _LINUX_EXPORT_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b98f128c9afa..a6de8d93838d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3407,6 +3407,8 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
+struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
+					   const struct inode *context_inode);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 79974a99265f..2d3bfec568eb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1366,7 +1366,7 @@ int ata_acpi_stm(struct ata_port *ap, const struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *stm);
 unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
 				   const struct ata_acpi_gtm *gtm);
-int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm);
+int ata_acpi_cbl_pata_type(struct ata_port *ap);
 #else
 static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 {
@@ -1391,10 +1391,9 @@ static inline unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
 	return 0;
 }
 
-static inline int ata_acpi_cbl_80wire(struct ata_port *ap,
-				      const struct ata_acpi_gtm *gtm)
+static inline int ata_acpi_cbl_pata_type(struct ata_port *ap)
 {
-	return 0;
+	return ATA_CBL_PATA40;
 }
 #endif
 
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 63dd8cf3c3c2..d3561c4a080e 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -548,6 +548,12 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
 
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
 
+DEFINE_LOCK_GUARD_1(raw_spinlock_bh, raw_spinlock_t,
+		    raw_spin_lock_bh(_T->lock),
+		    raw_spin_unlock_bh(_T->lock))
+
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock_bh, _try, raw_spin_trylock_bh(_T->lock))
+
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
 		    raw_spin_lock_irqsave(_T->lock, _T->flags),
 		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
@@ -569,6 +575,13 @@ DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
 DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
 			 spin_trylock_irq(_T->lock))
 
+DEFINE_LOCK_GUARD_1(spinlock_bh, spinlock_t,
+		    spin_lock_bh(_T->lock),
+		    spin_unlock_bh(_T->lock))
+
+DEFINE_LOCK_GUARD_1_COND(spinlock_bh, _try,
+			 spin_trylock_bh(_T->lock))
+
 DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
 		    spin_lock_irqsave(_T->lock, _T->flags),
 		    spin_unlock_irqrestore(_T->lock, _T->flags),
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 672d8fc2abdb..e76e3515a1da 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -612,6 +612,7 @@ struct usb3_lpm_parameters {
  *	FIXME -- complete doc
  * @authenticated: Crypto authentication passed
  * @tunnel_mode: Connection native or tunneled over USB4
+ * @usb4_link: device link to the USB4 host interface
  * @lpm_capable: device supports LPM
  * @lpm_devinit_allow: Allow USB3 device initiated LPM, exit latency is in range
  * @usb2_hw_lpm_capable: device can perform USB2 hardware LPM
@@ -722,6 +723,7 @@ struct usb_device {
 	unsigned reset_resume:1;
 	unsigned port_is_suspended:1;
 	enum usb_link_tunnel_mode tunnel_mode;
+	struct device_link *usb4_link;
 
 	int slot_id;
 	struct usb2_lpm_parameters l1_params;
diff --git a/include/linux/usb/typec_dp.h b/include/linux/usb/typec_dp.h
index f2da264d9c14..acb0ad03bdac 100644
--- a/include/linux/usb/typec_dp.h
+++ b/include/linux/usb/typec_dp.h
@@ -57,6 +57,7 @@ enum {
 	DP_PIN_ASSIGN_D,
 	DP_PIN_ASSIGN_E,
 	DP_PIN_ASSIGN_F, /* Not supported after v1.0b */
+	DP_PIN_ASSIGN_MAX,
 };
 
 /* DisplayPort alt mode specific commands */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 39a3d750f2ff..f01477cecf39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1376,13 +1376,6 @@ static void free_func_state(struct bpf_func_state *state)
 	kfree(state);
 }
 
-static void clear_jmp_history(struct bpf_verifier_state *state)
-{
-	kfree(state->jmp_history);
-	state->jmp_history = NULL;
-	state->jmp_history_cnt = 0;
-}
-
 static void free_verifier_state(struct bpf_verifier_state *state,
 				bool free_self)
 {
@@ -1392,7 +1385,6 @@ static void free_verifier_state(struct bpf_verifier_state *state,
 		free_func_state(state->frame[i]);
 		state->frame[i] = NULL;
 	}
-	clear_jmp_history(state);
 	if (free_self)
 		kfree(state);
 }
@@ -1418,13 +1410,6 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	struct bpf_func_state *dst;
 	int i, err;
 
-	dst_state->jmp_history = copy_array(dst_state->jmp_history, src->jmp_history,
-					  src->jmp_history_cnt, sizeof(*dst_state->jmp_history),
-					  GFP_USER);
-	if (!dst_state->jmp_history)
-		return -ENOMEM;
-	dst_state->jmp_history_cnt = src->jmp_history_cnt;
-
 	/* if dst has more stack frames then src frame, free them, this is also
 	 * necessary in case of exceptional exits using bpf_throw.
 	 */
@@ -1443,6 +1428,8 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
 	dst_state->parent = src->parent;
 	dst_state->first_insn_idx = src->first_insn_idx;
 	dst_state->last_insn_idx = src->last_insn_idx;
+	dst_state->insn_hist_start = src->insn_hist_start;
+	dst_state->insn_hist_end = src->insn_hist_end;
 	dst_state->dfs_depth = src->dfs_depth;
 	dst_state->callback_unroll_depth = src->callback_unroll_depth;
 	dst_state->used_as_loop_entry = src->used_as_loop_entry;
@@ -2496,9 +2483,14 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	 * The caller state doesn't matter.
 	 * This is async callback. It starts in a fresh stack.
 	 * Initialize it similar to do_check_common().
+	 * But we do need to make sure to not clobber insn_hist, so we keep
+	 * chaining insn_hist_start/insn_hist_end indices as for a normal
+	 * child state.
 	 */
 	elem->st.branches = 1;
 	elem->st.in_sleepable = is_sleepable;
+	elem->st.insn_hist_start = env->cur_state->insn_hist_end;
+	elem->st.insn_hist_end = elem->st.insn_hist_start;
 	frame = kzalloc(sizeof(*frame), GFP_KERNEL);
 	if (!frame)
 		goto err;
@@ -3513,11 +3505,10 @@ static void linked_regs_unpack(u64 val, struct linked_regs *s)
 }
 
 /* for any branch, call, exit record the history of jmps in the given state */
-static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
-			    int insn_flags, u64 linked_regs)
+static int push_insn_history(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
+			     int insn_flags, u64 linked_regs)
 {
-	u32 cnt = cur->jmp_history_cnt;
-	struct bpf_jmp_history_entry *p;
+	struct bpf_insn_hist_entry *p;
 	size_t alloc_size;
 
 	/* combine instruction flags if we already recorded this instruction */
@@ -3537,29 +3528,32 @@ static int push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_st
 		return 0;
 	}
 
-	cnt++;
-	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
-	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
-	if (!p)
-		return -ENOMEM;
-	cur->jmp_history = p;
+	if (cur->insn_hist_end + 1 > env->insn_hist_cap) {
+		alloc_size = size_mul(cur->insn_hist_end + 1, sizeof(*p));
+		p = kvrealloc(env->insn_hist, alloc_size, GFP_USER);
+		if (!p)
+			return -ENOMEM;
+		env->insn_hist = p;
+		env->insn_hist_cap = alloc_size / sizeof(*p);
+	}
 
-	p = &cur->jmp_history[cnt - 1];
+	p = &env->insn_hist[cur->insn_hist_end];
 	p->idx = env->insn_idx;
 	p->prev_idx = env->prev_insn_idx;
 	p->flags = insn_flags;
 	p->linked_regs = linked_regs;
-	cur->jmp_history_cnt = cnt;
+
+	cur->insn_hist_end++;
 	env->cur_hist_ent = p;
 
 	return 0;
 }
 
-static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_state *st,
-						        u32 hist_end, int insn_idx)
+static struct bpf_insn_hist_entry *get_insn_hist_entry(struct bpf_verifier_env *env,
+						       u32 hist_start, u32 hist_end, int insn_idx)
 {
-	if (hist_end > 0 && st->jmp_history[hist_end - 1].idx == insn_idx)
-		return &st->jmp_history[hist_end - 1];
+	if (hist_end > hist_start && env->insn_hist[hist_end - 1].idx == insn_idx)
+		return &env->insn_hist[hist_end - 1];
 	return NULL;
 }
 
@@ -3576,25 +3570,26 @@ static struct bpf_jmp_history_entry *get_jmp_hist_entry(struct bpf_verifier_stat
  * history entry recording a jump from last instruction of parent state and
  * first instruction of given state.
  */
-static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
-			     u32 *history)
+static int get_prev_insn_idx(const struct bpf_verifier_env *env,
+			     struct bpf_verifier_state *st,
+			     int insn_idx, u32 hist_start, u32 *hist_endp)
 {
-	u32 cnt = *history;
+	u32 hist_end = *hist_endp;
+	u32 cnt = hist_end - hist_start;
 
-	if (i == st->first_insn_idx) {
+	if (insn_idx == st->first_insn_idx) {
 		if (cnt == 0)
 			return -ENOENT;
-		if (cnt == 1 && st->jmp_history[0].idx == i)
+		if (cnt == 1 && env->insn_hist[hist_start].idx == insn_idx)
 			return -ENOENT;
 	}
 
-	if (cnt && st->jmp_history[cnt - 1].idx == i) {
-		i = st->jmp_history[cnt - 1].prev_idx;
-		(*history)--;
+	if (cnt && env->insn_hist[hist_end - 1].idx == insn_idx) {
+		(*hist_endp)--;
+		return env->insn_hist[hist_end - 1].prev_idx;
 	} else {
-		i--;
+		return insn_idx - 1;
 	}
-	return i;
 }
 
 static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
@@ -3766,7 +3761,7 @@ static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
 /* If any register R in hist->linked_regs is marked as precise in bt,
  * do bt_set_frame_{reg,slot}(bt, R) for all registers in hist->linked_regs.
  */
-static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_history_entry *hist)
+static void bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_insn_hist_entry *hist)
 {
 	struct linked_regs linked_regs;
 	bool some_precise = false;
@@ -3811,7 +3806,7 @@ static bool calls_callback(struct bpf_verifier_env *env, int insn_idx);
  *   - *was* processed previously during backtracking.
  */
 static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
-			  struct bpf_jmp_history_entry *hist, struct backtrack_state *bt)
+			  struct bpf_insn_hist_entry *hist, struct backtrack_state *bt)
 {
 	const struct bpf_insn_cbs cbs = {
 		.cb_call	= disasm_kfunc_name,
@@ -4071,8 +4066,10 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			 * before it would be equally necessary to
 			 * propagate it to dreg.
 			 */
-			bt_set_reg(bt, dreg);
-			bt_set_reg(bt, sreg);
+			if (!hist || !(hist->flags & INSN_F_SRC_REG_STACK))
+				bt_set_reg(bt, sreg);
+			if (!hist || !(hist->flags & INSN_F_DST_REG_STACK))
+				bt_set_reg(bt, dreg);
 		} else if (BPF_SRC(insn->code) == BPF_K) {
 			 /* dreg <cond> K
 			  * Only dreg still needs precision before
@@ -4230,7 +4227,7 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * SCALARS, as well as any other registers and slots that contribute to
  * a tracked state of given registers/stack slots, depending on specific BPF
  * assembly instructions (see backtrack_insns() for exact instruction handling
- * logic). This backtracking relies on recorded jmp_history and is able to
+ * logic). This backtracking relies on recorded insn_hist and is able to
  * traverse entire chain of parent states. This process ends only when all the
  * necessary registers/slots and their transitive dependencies are marked as
  * precise.
@@ -4347,8 +4344,9 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
-		u32 history = st->jmp_history_cnt;
-		struct bpf_jmp_history_entry *hist;
+		u32 hist_start = st->insn_hist_start;
+		u32 hist_end = st->insn_hist_end;
+		struct bpf_insn_hist_entry *hist;
 
 		if (env->log.level & BPF_LOG_LEVEL2) {
 			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d subseq_idx %d \n",
@@ -4387,7 +4385,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				err = 0;
 				skip_first = false;
 			} else {
-				hist = get_jmp_hist_entry(st, history, i);
+				hist = get_insn_hist_entry(env, hist_start, hist_end, i);
 				err = backtrack_insn(env, i, subseq_idx, hist, bt);
 			}
 			if (err == -ENOTSUPP) {
@@ -4404,7 +4402,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				 */
 				return 0;
 			subseq_idx = i;
-			i = get_prev_insn_idx(st, i, &history);
+			i = get_prev_insn_idx(env, st, i, hist_start, &hist_end);
 			if (i == -ENOENT)
 				break;
 			if (i >= env->prog->len) {
@@ -4771,7 +4769,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	}
 
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags, 0);
+		return push_insn_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -5078,7 +5076,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 		insn_flags = 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return push_jmp_history(env, env->cur_state, insn_flags, 0);
+		return push_insn_history(env, env->cur_state, insn_flags, 0);
 	return 0;
 }
 
@@ -15419,6 +15417,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	struct bpf_reg_state *eq_branch_regs;
 	struct linked_regs linked_regs = {};
 	u8 opcode = BPF_OP(insn->code);
+	int insn_flags = 0;
 	bool is_jmp32;
 	int pred = -1;
 	int err;
@@ -15478,6 +15477,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 				insn->src_reg);
 			return -EACCES;
 		}
+
+		if (src_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_SRC_REG_STACK;
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -15489,6 +15491,14 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		__mark_reg_known(src_reg, insn->imm);
 	}
 
+	if (dst_reg->type == PTR_TO_STACK)
+		insn_flags |= INSN_F_DST_REG_STACK;
+	if (insn_flags) {
+		err = push_insn_history(env, this_branch, insn_flags, 0);
+		if (err)
+			return err;
+	}
+
 	is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 	pred = is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
 	if (pred >= 0) {
@@ -15542,7 +15552,7 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 	if (dst_reg->type == SCALAR_VALUE && dst_reg->id)
 		collect_linked_regs(this_branch, dst_reg->id, &linked_regs);
 	if (linked_regs.cnt > 1) {
-		err = push_jmp_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
+		err = push_insn_history(env, this_branch, 0, linked_regs_pack(&linked_regs));
 		if (err)
 			return err;
 	}
@@ -17984,7 +17994,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	force_new_state = env->test_state_freq || is_force_checkpoint(env, insn_idx) ||
 			  /* Avoid accumulating infinitely long jmp history */
-			  cur->jmp_history_cnt > 40;
+			  cur->insn_hist_end - cur->insn_hist_start > 40;
 
 	/* bpf progs typically have pruning point every 4 instructions
 	 * http://vger.kernel.org/bpfconf2019.html#session-1
@@ -18182,7 +18192,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			 * the current state.
 			 */
 			if (is_jmp_point(env, env->insn_idx))
-				err = err ? : push_jmp_history(env, cur, 0, 0);
+				err = err ? : push_insn_history(env, cur, 0, 0);
 			err = err ? : propagate_precision(env, &sl->state);
 			if (err)
 				return err;
@@ -18281,8 +18291,8 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 
 	cur->parent = new;
 	cur->first_insn_idx = insn_idx;
+	cur->insn_hist_start = cur->insn_hist_end;
 	cur->dfs_depth = new->dfs_depth + 1;
-	clear_jmp_history(cur);
 	new_sl->next = *explored_state(env, insn_idx);
 	*explored_state(env, insn_idx) = new_sl;
 	/* connect new state to parentage chain. Current frame needs all
@@ -18450,7 +18460,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
 
 		if (is_jmp_point(env, env->insn_idx)) {
-			err = push_jmp_history(env, state, 0, 0);
+			err = push_insn_history(env, state, 0, 0);
 			if (err)
 				return err;
 		}
@@ -22716,6 +22726,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
 	vfree(env->insn_aux_data);
+	kvfree(env->insn_hist);
 err_free_env:
 	kvfree(env);
 	return ret;
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 1a3d483548e2..ae4c9cbd1b4b 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -202,7 +202,7 @@ struct irq_domain *irq_domain_create_sim_full(struct fwnode_handle *fwnode,
 					      void *data)
 {
 	struct irq_sim_work_ctx *work_ctx __free(kfree) =
-				kmalloc(sizeof(*work_ctx), GFP_KERNEL);
+				kzalloc(sizeof(*work_ctx), GFP_KERNEL);
 
 	if (!work_ctx)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cefa831c8cb3..552464dcffe2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3076,6 +3076,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
 
+	/* Avoid NULL dereference if callback is NULL. */
+	if (WARN_ON_ONCE(!func))
+		return;
+
 	if (debug_rcu_head_queue(head)) {
 		/*
 		 * Probable double call_rcu(), so leak the callback.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d4948a862992..50531e462a4b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1303,7 +1303,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
-	if (rq->cfs.h_nr_running > 1)
+	if (rq->cfs.h_nr_queued > 1)
 		return false;
 
 	/*
@@ -5976,7 +5976,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * opportunity to pull in more work from other CPUs.
 	 */
 	if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
-		   rq->nr_running == rq->cfs.h_nr_running)) {
+		   rq->nr_running == rq->cfs.h_nr_queued)) {
 
 		p = pick_next_task_fair(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1e3bc0774efd..9815f9a0cd59 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -378,7 +378,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_running) {
+		if (rq->cfs.h_nr_queued) {
 			update_rq_clock(rq);
 			dl_server_stop(&rq->fair_server);
 		}
@@ -391,7 +391,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_running)
+		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
 	}
 
@@ -843,7 +843,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
-	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ddd4fa785264..c801dd20c63d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4058,12 +4058,12 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 {
 	percpu_down_read(&scx_cgroup_rwsem);
 
-	if (scx_cgroup_enabled && tg->scx_weight != weight) {
-		if (SCX_HAS_OP(cgroup_set_weight))
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight,
-				    tg_cgrp(tg), weight);
-		tg->scx_weight = weight;
-	}
+	if (scx_cgroup_enabled && SCX_HAS_OP(cgroup_set_weight) &&
+	    tg->scx_weight != weight)
+		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight,
+			    tg_cgrp(tg), weight);
+
+	tg->scx_weight = weight;
 
 	percpu_up_read(&scx_cgroup_rwsem);
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 443f6a9ef3f8..7280ed04c96c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2147,7 +2147,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util_cfs(cpu);
-		ns->nr_running += rq->cfs.h_nr_running;
+		ns->nr_running += rq->cfs.h_nr_queued;
 		ns->compute_capacity += capacity_of(cpu);
 
 		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
@@ -5427,7 +5427,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_running of its group cfs_rq.
+	 *     h_nr_queued of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -5511,6 +5511,7 @@ static void set_delayed(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		cfs_rq->h_nr_runnable--;
 		cfs_rq->h_nr_delayed++;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5533,6 +5534,7 @@ static void clear_delayed(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		cfs_rq->h_nr_runnable++;
 		cfs_rq->h_nr_delayed--;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5583,7 +5585,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_running of its group cfs_rq.
+	 *     h_nr_queued of its group cfs_rq.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
@@ -5985,8 +5987,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, delayed_delta, dequeue = 1;
-	long rq_h_nr_running = rq->cfs.h_nr_running;
+	long queued_delta, runnable_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -6016,7 +6018,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
 
-	task_delta = cfs_rq->h_nr_running;
+	queued_delta = cfs_rq->h_nr_queued;
+	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -6038,9 +6041,10 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		dequeue_entity(qcfs_rq, se, flags);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->h_nr_queued -= queued_delta;
+		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 
@@ -6061,18 +6065,19 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->h_nr_queued -= queued_delta;
+		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, task_delta);
+	sub_nr_running(rq, queued_delta);
 
 	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
 		dl_server_stop(&rq->fair_server);
 done:
 	/*
@@ -6091,8 +6096,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, delayed_delta;
-	long rq_h_nr_running = rq->cfs.h_nr_running;
+	long queued_delta, runnable_delta, idle_task_delta, delayed_delta;
+	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -6125,7 +6130,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		goto unthrottle_throttle;
 	}
 
-	task_delta = cfs_rq->h_nr_running;
+	queued_delta = cfs_rq->h_nr_queued;
+	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -6141,9 +6147,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->h_nr_queued += queued_delta;
+		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6159,9 +6166,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->h_nr_queued += queued_delta;
+		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6171,11 +6179,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_running && rq->cfs.h_nr_running)
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
 
 	/* At this point se is NULL and we are at root level*/
-	add_nr_running(rq, task_delta);
+	add_nr_running(rq, queued_delta);
 
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
@@ -6890,7 +6898,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
-	if (rq->cfs.h_nr_running > 1) {
+	if (rq->cfs.h_nr_queued > 1) {
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
 		u64 slice = se->slice;
 		s64 delta = slice - ran;
@@ -7033,7 +7041,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int h_nr_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
-	int rq_h_nr_running = rq->cfs.h_nr_running;
+	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	u64 slice = 0;
 
 	/*
@@ -7081,7 +7089,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running++;
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable++;
+		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
@@ -7107,7 +7117,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running++;
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable++;
+		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
@@ -7119,7 +7131,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 	}
 
-	if (!rq_h_nr_running && rq->cfs.h_nr_running) {
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
 			dl_server_update_idle_time(rq, rq->curr);
@@ -7166,19 +7178,19 @@ static void set_next_buddy(struct sched_entity *se);
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
 	bool was_sched_idle = sched_idle_rq(rq);
-	int rq_h_nr_running = rq->cfs.h_nr_running;
+	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
-	int h_nr_running = 0;
+	int h_nr_queued = 0;
 	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
-		h_nr_running = 1;
+		h_nr_queued = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
 		if (!task_sleep && !task_delayed)
 			h_nr_delayed = !!se->sched_delayed;
@@ -7195,12 +7207,14 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
-		cfs_rq->h_nr_running -= h_nr_running;
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable -= h_nr_queued;
+		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_running;
+			idle_h_nr_running = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7236,21 +7250,23 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running -= h_nr_running;
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable -= h_nr_queued;
+		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_running;
+			idle_h_nr_running = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			return 0;
 	}
 
-	sub_nr_running(rq, h_nr_running);
+	sub_nr_running(rq, h_nr_queued);
 
-	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
 		dl_server_stop(&rq->fair_server);
 
 	/* balance early to pull high priority tasks */
@@ -7297,6 +7313,11 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	return true;
 }
 
+static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
+{
+	return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
+}
+
 #ifdef CONFIG_SMP
 
 /* Working cpumask for: sched_balance_rq(), sched_balance_newidle(). */
@@ -7458,8 +7479,12 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
 		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
-	if (sync && cpu_rq(this_cpu)->nr_running == 1)
-		return this_cpu;
+	if (sync) {
+		struct rq *rq = cpu_rq(this_cpu);
+
+		if ((rq->nr_running - cfs_h_nr_delayed(rq)) == 1)
+			return this_cpu;
+	}
 
 	if (available_idle_cpu(prev_cpu))
 		return prev_cpu;
@@ -10394,7 +10419,7 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	 * When there is more than 1 task, the group_overloaded case already
 	 * takes care of cpu with reduced capacity
 	 */
-	if (rq->cfs.h_nr_running != 1)
+	if (rq->cfs.h_nr_queued != 1)
 		return false;
 
 	return check_cpu_capacity(rq, sd);
@@ -10429,7 +10454,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_load += load;
 		sgs->group_util += cpu_util_cfs(i);
 		sgs->group_runnable += cpu_runnable(rq);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_queued;
 
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
@@ -10744,7 +10769,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		sgs->group_util += cpu_util_without(i, p);
 		sgs->group_runnable += cpu_runnable_without(rq, p);
 		local = task_running_on_cpu(i, p);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_running - local;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_queued - local;
 
 		nr_running = rq->nr_running - local;
 		sgs->sum_nr_running += nr_running;
@@ -11526,7 +11551,7 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		nr_running = rq->cfs.h_nr_running;
+		nr_running = rq->cfs.h_nr_queued;
 		if (!nr_running)
 			continue;
 
@@ -11685,7 +11710,7 @@ static int need_active_balance(struct lb_env *env)
 	 * available on dst_cpu.
 	 */
 	if (env->idle &&
-	    (env->src_rq->cfs.h_nr_running == 1)) {
+	    (env->src_rq->cfs.h_nr_queued == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
 			return 1;
@@ -12428,7 +12453,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * If there's a runnable CFS task and the current CPU has reduced
 		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
-		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
+		if (rq->cfs.h_nr_queued >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
@@ -12926,11 +12951,11 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	 * have been enqueued in the meantime. Since we're not going idle,
 	 * pretend we pulled a task.
 	 */
-	if (this_rq->cfs.h_nr_running && !pulled_task)
+	if (this_rq->cfs.h_nr_queued && !pulled_task)
 		pulled_task = 1;
 
 	/* Is there a task of a high priority class? */
-	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
+	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
 		pulled_task = -1;
 
 out:
@@ -13617,7 +13642,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 				parent_cfs_rq->idle_nr_running--;
 		}
 
-		idle_task_delta = grp_cfs_rq->h_nr_running -
+		idle_task_delta = grp_cfs_rq->h_nr_queued -
 				  grp_cfs_rq->idle_h_nr_running;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
 			idle_task_delta *= -1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 171a802420a1..8189a35e53fe 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -275,7 +275,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = grq->h_nr_running
+ *     se_runnable() = grq->h_nr_queued
  *
  *   runnable_sum = se_runnable() * runnable = grq->runnable_sum
  *   runnable_avg = runnable_sum
@@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				cfs_rq->h_nr_running - cfs_rq->h_nr_delayed,
+				cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d79de755c1c2..e7f5ab21221c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -651,7 +651,8 @@ struct balance_callback {
 struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
-	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 	unsigned int		h_nr_delayed;
@@ -907,7 +908,7 @@ static inline void se_update_runnable(struct sched_entity *se)
 	if (!entity_is_task(se)) {
 		struct cfs_rq *cfs_rq = se->my_q;
 
-		se->runnable_weight = cfs_rq->h_nr_running - cfs_rq->h_nr_delayed;
+		se->runnable_weight = cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed;
 	}
 }
 
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 37655f58b855..4e4dc430614a 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -118,6 +118,8 @@ config UBSAN_UNREACHABLE
 
 config UBSAN_SIGNED_WRAP
 	bool "Perform checking for signed arithmetic wrap-around"
+	# This is very experimental so drop the next line if you really want it
+	depends on BROKEN
 	depends on !COMPILE_TEST
 	# The no_sanitize attribute was introduced in GCC with version 8.
 	depends on !CC_IS_GCC || GCC_VERSION >= 80000
diff --git a/lib/test_objagg.c b/lib/test_objagg.c
index d34df4306b87..222b39fc2629 100644
--- a/lib/test_objagg.c
+++ b/lib/test_objagg.c
@@ -899,8 +899,10 @@ static int check_expect_hints_stats(struct objagg_hints *objagg_hints,
 	int err;
 
 	stats = objagg_hints_stats_get(objagg_hints);
-	if (IS_ERR(stats))
+	if (IS_ERR(stats)) {
+		*errmsg = "objagg_hints_stats_get() failed.";
 		return PTR_ERR(stats);
+	}
 	err = __check_expect_stats(stats, expect_stats, errmsg);
 	objagg_stats_put(stats);
 	return err;
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 399552814fd0..4662f2510ae5 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -195,19 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
 	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
-	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
-	int err;
 
-	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	inode = anon_inode_make_secure_inode(secretmem_mnt->mnt_sb, anon_name, NULL);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	err = security_inode_init_security_anon(inode, &qname, NULL);
-	if (err) {
-		file = ERR_PTR(err);
-		goto err_free_inode;
-	}
-
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e06e3d270961..2646b75163d5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1078,8 +1078,18 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 			 pte_t *dst_pte, pte_t *src_pte,
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
 			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
-			 struct folio *src_folio)
+			 struct folio *src_folio,
+			 struct swap_info_struct *si, swp_entry_t entry)
 {
+	/*
+	 * Check if the folio still belongs to the target swap entry after
+	 * acquiring the lock. Folio can be freed in the swap cache while
+	 * not locked.
+	 */
+	if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
+				  entry.val != src_folio->swap.val))
+		return -EAGAIN;
+
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!pte_same(ptep_get(src_pte), orig_src_pte) ||
@@ -1096,6 +1106,25 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 	if (src_folio) {
 		folio_move_anon_rmap(src_folio, dst_vma);
 		src_folio->index = linear_page_index(dst_vma, dst_addr);
+	} else {
+		/*
+		 * Check if the swap entry is cached after acquiring the src_pte
+		 * lock. Otherwise, we might miss a newly loaded swap cache folio.
+		 *
+		 * Check swap_map directly to minimize overhead, READ_ONCE is sufficient.
+		 * We are trying to catch newly added swap cache, the only possible case is
+		 * when a folio is swapped in and out again staying in swap cache, using the
+		 * same entry before the PTE check above. The PTL is acquired and released
+		 * twice, each time after updating the swap_map's flag. So holding
+		 * the PTL here ensures we see the updated value. False positive is possible,
+		 * e.g. SWP_SYNCHRONOUS_IO swapin may set the flag without touching the
+		 * cache, or during the tiny synchronization window between swap cache and
+		 * swap_map, but it will be gone very quickly, worst result is retry jitters.
+		 */
+		if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE) {
+			double_pt_unlock(dst_ptl, src_ptl);
+			return -EAGAIN;
+		}
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
@@ -1391,7 +1420,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		}
 		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
 				orig_dst_pte, orig_src_pte,
-				dst_ptl, src_ptl, src_folio);
+				dst_ptl, src_ptl, src_folio, si, entry);
 	}
 
 out:
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index cc04e501b1c5..7888600b6a79 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3095,7 +3095,7 @@ static void clear_vm_uninitialized_flag(struct vm_struct *vm)
 	/*
 	 * Before removing VM_UNINITIALIZED,
 	 * we should make sure that vm has proper values.
-	 * Pair with smp_rmb() in show_numa_info().
+	 * Pair with smp_rmb() in vread_iter() and vmalloc_info_show().
 	 */
 	smp_wmb();
 	vm->flags &= ~VM_UNINITIALIZED;
@@ -4938,28 +4938,29 @@ bool vmalloc_dump_obj(void *object)
 #endif
 
 #ifdef CONFIG_PROC_FS
-static void show_numa_info(struct seq_file *m, struct vm_struct *v)
-{
-	if (IS_ENABLED(CONFIG_NUMA)) {
-		unsigned int nr, *counters = m->private;
-		unsigned int step = 1U << vm_area_page_order(v);
 
-		if (!counters)
-			return;
+/*
+ * Print number of pages allocated on each memory node.
+ *
+ * This function can only be called if CONFIG_NUMA is enabled
+ * and VM_UNINITIALIZED bit in v->flags is disabled.
+ */
+static void show_numa_info(struct seq_file *m, struct vm_struct *v,
+				 unsigned int *counters)
+{
+	unsigned int nr;
+	unsigned int step = 1U << vm_area_page_order(v);
 
-		if (v->flags & VM_UNINITIALIZED)
-			return;
-		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
-		smp_rmb();
+	if (!counters)
+		return;
 
-		memset(counters, 0, nr_node_ids * sizeof(unsigned int));
+	memset(counters, 0, nr_node_ids * sizeof(unsigned int));
 
-		for (nr = 0; nr < v->nr_pages; nr += step)
-			counters[page_to_nid(v->pages[nr])] += step;
-		for_each_node_state(nr, N_HIGH_MEMORY)
-			if (counters[nr])
-				seq_printf(m, " N%u=%u", nr, counters[nr]);
-	}
+	for (nr = 0; nr < v->nr_pages; nr += step)
+		counters[page_to_nid(v->pages[nr])] += step;
+	for_each_node_state(nr, N_HIGH_MEMORY)
+		if (counters[nr])
+			seq_printf(m, " N%u=%u", nr, counters[nr]);
 }
 
 static void show_purge_info(struct seq_file *m)
@@ -4987,6 +4988,10 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 	struct vmap_area *va;
 	struct vm_struct *v;
 	int i;
+	unsigned int *counters;
+
+	if (IS_ENABLED(CONFIG_NUMA))
+		counters = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
 
 	for (i = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
@@ -5003,6 +5008,11 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 			}
 
 			v = va->vm;
+			if (v->flags & VM_UNINITIALIZED)
+				continue;
+
+			/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
+			smp_rmb();
 
 			seq_printf(m, "0x%pK-0x%pK %7ld",
 				v->addr, v->addr + v->size, v->size);
@@ -5037,7 +5047,9 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 			if (is_vmalloc_addr(v->pages))
 				seq_puts(m, " vpages");
 
-			show_numa_info(m, v);
+			if (IS_ENABLED(CONFIG_NUMA))
+				show_numa_info(m, v, counters);
+
 			seq_putc(m, '\n');
 		}
 		spin_unlock(&vn->busy.lock);
@@ -5047,19 +5059,14 @@ static int vmalloc_info_show(struct seq_file *m, void *p)
 	 * As a final step, dump "unpurged" areas.
 	 */
 	show_purge_info(m);
+	if (IS_ENABLED(CONFIG_NUMA))
+		kfree(counters);
 	return 0;
 }
 
 static int __init proc_vmalloc_init(void)
 {
-	void *priv_data = NULL;
-
-	if (IS_ENABLED(CONFIG_NUMA))
-		priv_data = kmalloc(nr_node_ids * sizeof(unsigned int), GFP_KERNEL);
-
-	proc_create_single_data("vmallocinfo",
-		0400, NULL, vmalloc_info_show, priv_data);
-
+	proc_create_single("vmallocinfo", 0400, NULL, vmalloc_info_show);
 	return 0;
 }
 module_init(proc_vmalloc_init);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5c4c3d04d8b9..7fdf17351e4a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2141,40 +2141,6 @@ static u8 hci_cc_set_adv_param(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
-static u8 hci_cc_set_ext_adv_param(struct hci_dev *hdev, void *data,
-				   struct sk_buff *skb)
-{
-	struct hci_rp_le_set_ext_adv_params *rp = data;
-	struct hci_cp_le_set_ext_adv_params *cp;
-	struct adv_info *adv_instance;
-
-	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
-
-	if (rp->status)
-		return rp->status;
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS);
-	if (!cp)
-		return rp->status;
-
-	hci_dev_lock(hdev);
-	hdev->adv_addr_type = cp->own_addr_type;
-	if (!cp->handle) {
-		/* Store in hdev for instance 0 */
-		hdev->adv_tx_power = rp->tx_power;
-	} else {
-		adv_instance = hci_find_adv_instance(hdev, cp->handle);
-		if (adv_instance)
-			adv_instance->tx_power = rp->tx_power;
-	}
-	/* Update adv data as tx power is known now */
-	hci_update_adv_data(hdev, cp->handle);
-
-	hci_dev_unlock(hdev);
-
-	return rp->status;
-}
-
 static u8 hci_cc_read_rssi(struct hci_dev *hdev, void *data,
 			   struct sk_buff *skb)
 {
@@ -4155,8 +4121,6 @@ static const struct hci_cc {
 	HCI_CC(HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
 	       hci_cc_le_read_num_adv_sets,
 	       sizeof(struct hci_rp_le_read_num_supported_adv_sets)),
-	HCI_CC(HCI_OP_LE_SET_EXT_ADV_PARAMS, hci_cc_set_ext_adv_param,
-	       sizeof(struct hci_rp_le_set_ext_adv_params)),
 	HCI_CC_STATUS(HCI_OP_LE_SET_EXT_ADV_ENABLE,
 		      hci_cc_le_set_ext_adv_enable),
 	HCI_CC_STATUS(HCI_OP_LE_SET_ADV_SET_RAND_ADDR,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a00316d79dbf..79d1a6ed08b2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1205,9 +1205,126 @@ static int hci_set_adv_set_random_addr_sync(struct hci_dev *hdev, u8 instance,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
+static int
+hci_set_ext_adv_params_sync(struct hci_dev *hdev, struct adv_info *adv,
+			    const struct hci_cp_le_set_ext_adv_params *cp,
+			    struct hci_rp_le_set_ext_adv_params *rp)
+{
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS, sizeof(*cp),
+			     cp, HCI_CMD_TIMEOUT);
+
+	/* If command return a status event, skb will be set to -ENODATA */
+	if (skb == ERR_PTR(-ENODATA))
+		return 0;
+
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld",
+			   HCI_OP_LE_SET_EXT_ADV_PARAMS, PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(*rp)) {
+		bt_dev_err(hdev, "Invalid response length for 0x%4.4x: %u",
+			   HCI_OP_LE_SET_EXT_ADV_PARAMS, skb->len);
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	memcpy(rp, skb->data, sizeof(*rp));
+	kfree_skb(skb);
+
+	if (!rp->status) {
+		hdev->adv_addr_type = cp->own_addr_type;
+		if (!cp->handle) {
+			/* Store in hdev for instance 0 */
+			hdev->adv_tx_power = rp->tx_power;
+		} else if (adv) {
+			adv->tx_power = rp->tx_power;
+		}
+	}
+
+	return rp->status;
+}
+
+static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
+		    HCI_MAX_EXT_AD_LENGTH);
+	u8 len;
+	struct adv_info *adv = NULL;
+	int err;
+
+	if (instance) {
+		adv = hci_find_adv_instance(hdev, instance);
+		if (!adv || !adv->adv_data_changed)
+			return 0;
+	}
+
+	len = eir_create_adv_data(hdev, instance, pdu->data,
+				  HCI_MAX_EXT_AD_LENGTH);
+
+	pdu->length = len;
+	pdu->handle = adv ? adv->handle : instance;
+	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
+	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
+
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
+				    struct_size(pdu, data, len), pdu,
+				    HCI_CMD_TIMEOUT);
+	if (err)
+		return err;
+
+	/* Update data if the command succeed */
+	if (adv) {
+		adv->adv_data_changed = false;
+	} else {
+		memcpy(hdev->adv_data, pdu->data, len);
+		hdev->adv_data_len = len;
+	}
+
+	return 0;
+}
+
+static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	struct hci_cp_le_set_adv_data cp;
+	u8 len;
+
+	memset(&cp, 0, sizeof(cp));
+
+	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
+
+	/* There's nothing to do if the data hasn't changed */
+	if (hdev->adv_data_len == len &&
+	    memcmp(cp.data, hdev->adv_data, len) == 0)
+		return 0;
+
+	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
+	hdev->adv_data_len = len;
+
+	cp.length = len;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
+
+int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
+{
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return 0;
+
+	if (ext_adv_capable(hdev))
+		return hci_set_ext_adv_data_sync(hdev, instance);
+
+	return hci_set_adv_data_sync(hdev, instance);
+}
+
 int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
+	struct hci_rp_le_set_ext_adv_params rp;
 	bool connectable;
 	u32 flags;
 	bdaddr_t random_addr;
@@ -1314,8 +1431,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		cp.secondary_phy = HCI_ADV_PHY_1M;
 	}
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = hci_set_ext_adv_params_sync(hdev, adv, &cp, &rp);
+	if (err)
+		return err;
+
+	/* Update adv data as tx power is known now */
+	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
 	if (err)
 		return err;
 
@@ -1832,79 +1953,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
 
-static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
-		    HCI_MAX_EXT_AD_LENGTH);
-	u8 len;
-	struct adv_info *adv = NULL;
-	int err;
-
-	if (instance) {
-		adv = hci_find_adv_instance(hdev, instance);
-		if (!adv || !adv->adv_data_changed)
-			return 0;
-	}
-
-	len = eir_create_adv_data(hdev, instance, pdu->data,
-				  HCI_MAX_EXT_AD_LENGTH);
-
-	pdu->length = len;
-	pdu->handle = adv ? adv->handle : instance;
-	pdu->operation = LE_SET_ADV_DATA_OP_COMPLETE;
-	pdu->frag_pref = LE_SET_ADV_DATA_NO_FRAG;
-
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_DATA,
-				    struct_size(pdu, data, len), pdu,
-				    HCI_CMD_TIMEOUT);
-	if (err)
-		return err;
-
-	/* Update data if the command succeed */
-	if (adv) {
-		adv->adv_data_changed = false;
-	} else {
-		memcpy(hdev->adv_data, pdu->data, len);
-		hdev->adv_data_len = len;
-	}
-
-	return 0;
-}
-
-static int hci_set_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	struct hci_cp_le_set_adv_data cp;
-	u8 len;
-
-	memset(&cp, 0, sizeof(cp));
-
-	len = eir_create_adv_data(hdev, instance, cp.data, sizeof(cp.data));
-
-	/* There's nothing to do if the data hasn't changed */
-	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0)
-		return 0;
-
-	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
-	hdev->adv_data_len = len;
-
-	cp.length = len;
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
-}
-
-int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
-{
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
-		return 0;
-
-	if (ext_adv_capable(hdev))
-		return hci_set_ext_adv_data_sync(hdev, instance);
-
-	return hci_set_adv_data_sync(hdev, instance);
-}
-
 int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 				   bool force)
 {
@@ -1980,13 +2028,10 @@ static int hci_clear_adv_sets_sync(struct hci_dev *hdev, struct sock *sk)
 static int hci_clear_adv_sync(struct hci_dev *hdev, struct sock *sk, bool force)
 {
 	struct adv_info *adv, *n;
-	int err = 0;
 
 	if (ext_adv_capable(hdev))
 		/* Remove all existing sets */
-		err = hci_clear_adv_sets_sync(hdev, sk);
-	if (ext_adv_capable(hdev))
-		return err;
+		return hci_clear_adv_sets_sync(hdev, sk);
 
 	/* This is safe as long as there is no command send while the lock is
 	 * held.
@@ -2014,13 +2059,11 @@ static int hci_clear_adv_sync(struct hci_dev *hdev, struct sock *sk, bool force)
 static int hci_remove_adv_sync(struct hci_dev *hdev, u8 instance,
 			       struct sock *sk)
 {
-	int err = 0;
+	int err;
 
 	/* If we use extended advertising, instance has to be removed first. */
 	if (ext_adv_capable(hdev))
-		err = hci_remove_ext_adv_instance_sync(hdev, instance, sk);
-	if (ext_adv_capable(hdev))
-		return err;
+		return hci_remove_ext_adv_instance_sync(hdev, instance, sk);
 
 	/* This is safe as long as there is no command send while the lock is
 	 * held.
@@ -2119,16 +2162,13 @@ int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type)
 int hci_disable_advertising_sync(struct hci_dev *hdev)
 {
 	u8 enable = 0x00;
-	int err = 0;
 
 	/* If controller is not advertising we are done. */
 	if (!hci_dev_test_flag(hdev, HCI_LE_ADV))
 		return 0;
 
 	if (ext_adv_capable(hdev))
-		err = hci_disable_ext_adv_instance_sync(hdev, 0x00);
-	if (ext_adv_capable(hdev))
-		return err;
+		return hci_disable_ext_adv_instance_sync(hdev, 0x00);
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
 				     sizeof(enable), &enable, HCI_CMD_TIMEOUT);
@@ -2491,6 +2531,10 @@ static int hci_pause_advertising_sync(struct hci_dev *hdev)
 	int err;
 	int old_state;
 
+	/* If controller is not advertising we are done. */
+	if (!hci_dev_test_flag(hdev, HCI_LE_ADV))
+		return 0;
+
 	/* If already been paused there is nothing to do. */
 	if (hdev->advertising_paused)
 		return 0;
@@ -6251,6 +6295,7 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 						struct hci_conn *conn)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
+	struct hci_rp_le_set_ext_adv_params rp;
 	int err;
 	bdaddr_t random_addr;
 	u8 own_addr_type;
@@ -6292,8 +6337,12 @@ static int hci_le_ext_directed_advertising_sync(struct hci_dev *hdev,
 	if (err)
 		return err;
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_PARAMS,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = hci_set_ext_adv_params_sync(hdev, NULL, &cp, &rp);
+	if (err)
+		return err;
+
+	/* Update adv data as tx power is known now */
+	err = hci_set_ext_adv_data_sync(hdev, cp.handle);
 	if (err)
 		return err;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7664e7ba372c..ade93532db34 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1073,7 +1073,8 @@ static int mesh_send_done_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_mesh_tx *mesh_tx;
 
 	hci_dev_clear_flag(hdev, HCI_MESH_SENDING);
-	hci_disable_advertising_sync(hdev);
+	if (list_empty(&hdev->adv_instances))
+		hci_disable_advertising_sync(hdev);
 	mesh_tx = mgmt_mesh_next(hdev, NULL);
 
 	if (mesh_tx)
@@ -2146,6 +2147,9 @@ static int set_mesh_sync(struct hci_dev *hdev, void *data)
 	else
 		hci_dev_clear_flag(hdev, HCI_MESH);
 
+	hdev->le_scan_interval = __le16_to_cpu(cp->period);
+	hdev->le_scan_window = __le16_to_cpu(cp->window);
+
 	len -= sizeof(*cp);
 
 	/* If filters don't fit, forward all adv pkts */
@@ -2160,6 +2164,7 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_set_mesh *cp = data;
 	struct mgmt_pending_cmd *cmd;
+	__u16 period, window;
 	int err = 0;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -2173,6 +2178,23 @@ static int set_mesh(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
 				       MGMT_STATUS_INVALID_PARAMS);
 
+	/* Keep allowed ranges in sync with set_scan_params() */
+	period = __le16_to_cpu(cp->period);
+
+	if (period < 0x0004 || period > 0x4000)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	window = __le16_to_cpu(cp->window);
+
+	if (window < 0x0004 || window > 0x4000)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	if (window > period)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_MESH_RECEIVER, hdev, data, len);
@@ -6536,6 +6558,7 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
+	/* Keep allowed ranges in sync with set_mesh() */
 	interval = __le16_to_cpu(cp->interval);
 
 	if (interval < 0x0004 || interval > 0x4000)
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 8e1fbdd3bff1..8e1d00efa62e 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4481,6 +4481,10 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		if (!multicast &&
 		    !ether_addr_equal(sdata->dev->dev_addr, hdr->addr1))
 			return false;
+		/* reject invalid/our STA address */
+		if (!is_valid_ether_addr(hdr->addr2) ||
+		    ether_addr_equal(sdata->dev->dev_addr, hdr->addr2))
+			return false;
 		if (!rx->sta) {
 			int rate_idx;
 			if (status->encoding != RX_ENC_LEGACY)
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index fee772b4637c..a7054546f52d 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -497,22 +497,15 @@ void rose_rt_device_down(struct net_device *dev)
 			t         = rose_node;
 			rose_node = rose_node->next;
 
-			for (i = 0; i < t->count; i++) {
+			for (i = t->count - 1; i >= 0; i--) {
 				if (t->neighbour[i] != s)
 					continue;
 
 				t->count--;
 
-				switch (i) {
-				case 0:
-					t->neighbour[0] = t->neighbour[1];
-					fallthrough;
-				case 1:
-					t->neighbour[1] = t->neighbour[2];
-					break;
-				case 2:
-					break;
-				}
+				memmove(&t->neighbour[i], &t->neighbour[i + 1],
+					sizeof(t->neighbour[0]) *
+						(t->count - i));
 			}
 
 			if (t->count <= 0)
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 518f52f65a49..26378eac1bd0 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -779,15 +779,12 @@ static u32 qdisc_alloc_handle(struct net_device *dev)
 
 void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 {
-	bool qdisc_is_offloaded = sch->flags & TCQ_F_OFFLOADED;
 	const struct Qdisc_class_ops *cops;
 	unsigned long cl;
 	u32 parentid;
 	bool notify;
 	int drops;
 
-	if (n == 0 && len == 0)
-		return;
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
@@ -796,17 +793,8 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 
 		if (sch->flags & TCQ_F_NOPARENT)
 			break;
-		/* Notify parent qdisc only if child qdisc becomes empty.
-		 *
-		 * If child was empty even before update then backlog
-		 * counter is screwed and we skip notification because
-		 * parent class is already passive.
-		 *
-		 * If the original child was offloaded then it is allowed
-		 * to be seem as empty, so the parent is notified anyway.
-		 */
-		notify = !sch->q.qlen && !WARN_ON_ONCE(!n &&
-						       !qdisc_is_offloaded);
+		/* Notify parent qdisc only if child qdisc becomes empty. */
+		notify = !sch->q.qlen;
 		/* TODO: perform the search on a per txq basis */
 		sch = qdisc_lookup_rcu(qdisc_dev(sch), TC_H_MAJ(parentid));
 		if (sch == NULL) {
@@ -815,6 +803,9 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 		}
 		cops = sch->ops->cl_ops;
 		if (notify && cops->qlen_notify) {
+			/* Note that qlen_notify must be idempotent as it may get called
+			 * multiple times.
+			 */
 			cl = cops->find(sch, parentid);
 			cops->qlen_notify(sch, cl);
 		}
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 7ce3721c06ca..eadc00410ebc 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -630,7 +630,7 @@ static int __rpc_rmpipe(struct inode *dir, struct dentry *dentry)
 static struct dentry *__rpc_lookup_create_exclusive(struct dentry *parent,
 					  const char *name)
 {
-	struct qstr q = QSTR_INIT(name, strlen(name));
+	struct qstr q = QSTR(name);
 	struct dentry *dentry = d_hash_and_lookup(parent, &q);
 	if (!dentry) {
 		dentry = d_alloc(parent, &q);
@@ -1190,8 +1190,7 @@ static const struct rpc_filelist files[] = {
 struct dentry *rpc_d_lookup_sb(const struct super_block *sb,
 			       const unsigned char *dir_name)
 {
-	struct qstr dir = QSTR_INIT(dir_name, strlen(dir_name));
-	return d_hash_and_lookup(sb->s_root, &dir);
+	return d_hash_and_lookup(sb->s_root, &QSTR(dir_name));
 }
 EXPORT_SYMBOL_GPL(rpc_d_lookup_sb);
 
@@ -1300,11 +1299,9 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 	struct dentry *gssd_dentry;
 	struct dentry *clnt_dentry = NULL;
 	struct dentry *pipe_dentry = NULL;
-	struct qstr q = QSTR_INIT(files[RPCAUTH_gssd].name,
-				  strlen(files[RPCAUTH_gssd].name));
 
 	/* We should never get this far if "gssd" doesn't exist */
-	gssd_dentry = d_hash_and_lookup(root, &q);
+	gssd_dentry = d_hash_and_lookup(root, &QSTR(files[RPCAUTH_gssd].name));
 	if (!gssd_dentry)
 		return ERR_PTR(-ENOENT);
 
@@ -1314,9 +1311,8 @@ rpc_gssd_dummy_populate(struct dentry *root, struct rpc_pipe *pipe_data)
 		goto out;
 	}
 
-	q.name = gssd_dummy_clnt_dir[0].name;
-	q.len = strlen(gssd_dummy_clnt_dir[0].name);
-	clnt_dentry = d_hash_and_lookup(gssd_dentry, &q);
+	clnt_dentry = d_hash_and_lookup(gssd_dentry,
+					&QSTR(gssd_dummy_clnt_dir[0].name));
 	if (!clnt_dentry) {
 		__rpc_depopulate(gssd_dentry, gssd_dummy_clnt_dir, 0, 1);
 		pipe_dentry = ERR_PTR(-ENOENT);
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index b370070194fa..7eccd6708d66 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -119,6 +119,8 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
 			   u16 proto,
 			   struct vmci_handle handle)
 {
+	memset(pkt, 0, sizeof(*pkt));
+
 	/* We register the stream control handler as an any cid handle so we
 	 * must always send from a source address of VMADDR_CID_ANY
 	 */
@@ -131,8 +133,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
 	pkt->type = type;
 	pkt->src_port = src->svm_port;
 	pkt->dst_port = dst->svm_port;
-	memset(&pkt->proto, 0, sizeof(pkt->proto));
-	memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));
 
 	switch (pkt->type) {
 	case VMCI_TRANSPORT_PACKET_TYPE_INVALID:
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 88850405ded9..f36332e64c4d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1884,11 +1884,17 @@ static int security_compute_sid(u32 ssid,
 			goto out_unlock;
 	}
 	/* Obtain the sid for the context. */
-	rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
-	if (rc == -ESTALE) {
-		rcu_read_unlock();
-		context_destroy(&newcontext);
-		goto retry;
+	if (context_cmp(scontext, &newcontext))
+		*out_sid = ssid;
+	else if (context_cmp(tcontext, &newcontext))
+		*out_sid = tsid;
+	else {
+		rc = sidtab_context_to_sid(sidtab, &newcontext, out_sid);
+		if (rc == -ESTALE) {
+			rcu_read_unlock();
+			context_destroy(&newcontext);
+			goto retry;
+		}
 	}
 out_unlock:
 	rcu_read_unlock();
diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 74db11525003..5a083eecaa6b 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -703,6 +703,9 @@ static int snd_sb16_dma_control_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	unsigned char nval, oval;
 	int change;
 	
+	if (chip->mode & (SB_MODE_PLAYBACK | SB_MODE_CAPTURE))
+		return -EBUSY;
+
 	nval = ucontrol->value.enumerated.item[0];
 	if (nval > 2)
 		return -EINVAL;
@@ -711,6 +714,10 @@ static int snd_sb16_dma_control_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	change = nval != oval;
 	snd_sb16_set_dma_mode(chip, nval);
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	if (change) {
+		snd_dma_disable(chip->dma8);
+		snd_dma_disable(chip->dma16);
+	}
 	return change;
 }
 
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b27966f82c8b..723cb7bc1285 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -451,6 +451,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 17 D7VEK"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 17 D7VF"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
@@ -514,6 +521,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16z-n000"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Victus by HP Gaming Laptop 15-fb2xxx"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index 4326555aac03..e8fbe8a399f6 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -14,6 +14,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <sound/pcm.h>
@@ -23,6 +24,11 @@
 
 #include "tas2764.h"
 
+enum tas2764_devid {
+	DEVID_TAS2764  = 0,
+	DEVID_SN012776 = 1
+};
+
 struct tas2764_priv {
 	struct snd_soc_component *component;
 	struct gpio_desc *reset_gpio;
@@ -30,7 +36,8 @@ struct tas2764_priv {
 	struct regmap *regmap;
 	struct device *dev;
 	int irq;
-	
+	enum tas2764_devid devid;
+
 	int v_sense_slot;
 	int i_sense_slot;
 
@@ -525,10 +532,18 @@ static struct snd_soc_dai_driver tas2764_dai_driver[] = {
 	},
 };
 
+static uint8_t sn012776_bop_presets[] = {
+	0x01, 0x32, 0x02, 0x22, 0x83, 0x2d, 0x80, 0x02, 0x06,
+	0x32, 0x46, 0x30, 0x02, 0x06, 0x38, 0x40, 0x30, 0x02,
+	0x06, 0x3e, 0x37, 0x30, 0xff, 0xe6
+};
+
+static const struct regmap_config tas2764_i2c_regmap;
+
 static int tas2764_codec_probe(struct snd_soc_component *component)
 {
 	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	int ret;
+	int ret, i;
 
 	tas2764->component = component;
 
@@ -538,6 +553,7 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	}
 
 	tas2764_reset(tas2764);
+	regmap_reinit_cache(tas2764->regmap, &tas2764_i2c_regmap);
 
 	if (tas2764->irq) {
 		ret = snd_soc_component_write(tas2764->component, TAS2764_INT_MASK0, 0x00);
@@ -577,6 +593,27 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
+	switch (tas2764->devid) {
+	case DEVID_SN012776:
+		ret = snd_soc_component_update_bits(component, TAS2764_PWR_CTRL,
+					TAS2764_PWR_CTRL_BOP_SRC,
+					TAS2764_PWR_CTRL_BOP_SRC);
+		if (ret < 0)
+			return ret;
+
+		for (i = 0; i < ARRAY_SIZE(sn012776_bop_presets); i++) {
+			ret = snd_soc_component_write(component,
+						TAS2764_BOP_CFG0 + i,
+						sn012776_bop_presets[i]);
+
+			if (ret < 0)
+				return ret;
+		}
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
@@ -708,6 +745,8 @@ static int tas2764_i2c_probe(struct i2c_client *client)
 	if (!tas2764)
 		return -ENOMEM;
 
+	tas2764->devid = (enum tas2764_devid)of_device_get_match_data(&client->dev);
+
 	tas2764->dev = &client->dev;
 	tas2764->irq = client->irq;
 	i2c_set_clientdata(client, tas2764);
@@ -744,7 +783,8 @@ MODULE_DEVICE_TABLE(i2c, tas2764_i2c_id);
 
 #if defined(CONFIG_OF)
 static const struct of_device_id tas2764_of_match[] = {
-	{ .compatible = "ti,tas2764" },
+	{ .compatible = "ti,tas2764",  .data = (void *)DEVID_TAS2764 },
+	{ .compatible = "ti,sn012776", .data = (void *)DEVID_SN012776 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tas2764_of_match);
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 9490f2686e38..69c0f91cb423 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -29,6 +29,7 @@
 #define TAS2764_PWR_CTRL_ACTIVE		0x0
 #define TAS2764_PWR_CTRL_MUTE		BIT(0)
 #define TAS2764_PWR_CTRL_SHUTDOWN	BIT(1)
+#define TAS2764_PWR_CTRL_BOP_SRC	BIT(7)
 
 #define TAS2764_VSENSE_POWER_EN		3
 #define TAS2764_ISENSE_POWER_EN		4
@@ -116,4 +117,6 @@
 #define TAS2764_INT_CLK_CFG             TAS2764_REG(0x0, 0x5c)
 #define TAS2764_INT_CLK_CFG_IRQZ_CLR    BIT(2)
 
+#define TAS2764_BOP_CFG0                TAS2764_REG(0X0, 0x1d)
+
 #endif /* __TAS2764__ */
diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
index e975c4331a7c..2019550a1b69 100644
--- a/tools/testing/kunit/qemu_configs/sparc.py
+++ b/tools/testing/kunit/qemu_configs/sparc.py
@@ -2,8 +2,11 @@ from ..qemu_config import QemuArchParams
 
 QEMU_ARCH = QemuArchParams(linux_arch='sparc',
 			   kconfig='''
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y''',
+CONFIG_KUNIT_FAULT_TEST=n
+CONFIG_SPARC32=y
+CONFIG_SERIAL_SUNZILOG=y
+CONFIG_SERIAL_SUNZILOG_CONSOLE=y
+''',
 			   qemu_arch='sparc',
 			   kernel_path='arch/sparc/boot/zImage',
 			   kernel_command_line='console=ttyS0 mem=256M',
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 06f252733660..a81c22d52007 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1748,6 +1748,7 @@ FIXTURE_VARIANT(iommufd_dirty_tracking)
 
 FIXTURE_SETUP(iommufd_dirty_tracking)
 {
+	size_t mmap_buffer_size;
 	unsigned long size;
 	int mmap_flags;
 	void *vrc;
@@ -1762,22 +1763,33 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 	self->fd = open("/dev/iommu", O_RDWR);
 	ASSERT_NE(-1, self->fd);
 
-	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, variant->buffer_size);
-	if (rc || !self->buffer) {
-		SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
-			   variant->buffer_size, rc);
-	}
-
 	mmap_flags = MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED;
+	mmap_buffer_size = variant->buffer_size;
 	if (variant->hugepages) {
 		/*
 		 * MAP_POPULATE will cause the kernel to fail mmap if THPs are
 		 * not available.
 		 */
 		mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
+
+		/*
+		 * Allocation must be aligned to the HUGEPAGE_SIZE, because the
+		 * following mmap() will automatically align the length to be a
+		 * multiple of the underlying huge page size. Failing to do the
+		 * same at this allocation will result in a memory overwrite by
+		 * the mmap().
+		 */
+		if (mmap_buffer_size < HUGEPAGE_SIZE)
+			mmap_buffer_size = HUGEPAGE_SIZE;
+	}
+
+	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, mmap_buffer_size);
+	if (rc || !self->buffer) {
+		SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
+			   mmap_buffer_size, rc);
 	}
 	assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
-	vrc = mmap(self->buffer, variant->buffer_size, PROT_READ | PROT_WRITE,
+	vrc = mmap(self->buffer, mmap_buffer_size, PROT_READ | PROT_WRITE,
 		   mmap_flags, -1, 0);
 	assert(vrc == self->buffer);
 
@@ -1806,8 +1818,8 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 
 FIXTURE_TEARDOWN(iommufd_dirty_tracking)
 {
-	munmap(self->buffer, variant->buffer_size);
-	munmap(self->bitmap, DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE));
+	free(self->buffer);
+	free(self->bitmap);
 	teardown_iommufd(self->fd, _metadata);
 }
 

