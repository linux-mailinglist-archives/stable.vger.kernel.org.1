Return-Path: <stable+bounces-69436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CCC95625E
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A993FB20AD2
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0FC8801;
	Mon, 19 Aug 2024 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="My8Tr8zL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F149644;
	Mon, 19 Aug 2024 04:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040762; cv=none; b=VfOYHsEcR0aD484pj5n10xR4AklToE6dZaF8QI8lO+tqXEOWCcGzA7XUqAjfZzQ81t4cOh0MGt1+kH4whkoAO/G5SB5OjuyOMdYf2lz6zD/Akc8IFUOLiMwBbY6EQ/opH8d+gCArpq9xc1M+1S/CGAVK422g1t469IUfxXJYoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040762; c=relaxed/simple;
	bh=J5p2Ydb4/fh05SfRX8pLBuUfeAOB6SvK89K8XK7PUkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/JhsqeRiIRc2eh/JSxMQBjRQqbDgTTWMpGR2qkKpLZIuyscKqOn2iaGt9tIYmW83kgsKBajMSYceOahqOQ+JyVTLftnZbYQ3CboqMgLfMjoPY52Md1daXRLH7EV8ZntuECqOI/ZTYgxoE4H8sQrt8Kb++69Mh61K8DCQjpcv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=My8Tr8zL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9748AC32782;
	Mon, 19 Aug 2024 04:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040761;
	bh=J5p2Ydb4/fh05SfRX8pLBuUfeAOB6SvK89K8XK7PUkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=My8Tr8zL210VmfhxaR4S6oS742g83SqgJ+1M+8S6dO2OzGEniv9rZiWIlPeEgzBrc
	 OP9e3e6+eN8r4pUAAdKVkTCALrr955dWRJ07OdeDWeIyESkVymMj28ecdB/aloLQ8b
	 BMzSiNFex37XThzsU/BrCXG5MZH5JrGKxL3FrzOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.320
Date: Mon, 19 Aug 2024 06:12:29 +0200
Message-ID: <2024081929-engaged-previous-3640@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024081929-scoreless-cedar-6ad7@gregkh>
References: <2024081929-scoreless-cedar-6ad7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 5329e3e00e04..eab3b0cf0dbe 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -61,7 +61,25 @@ stable kernels.
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
 | ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
+| ARM            | Cortex-A76      | #3324349        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A77      | #3324348        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X1C      | #3324346        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
+| ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
+| ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
+| ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
+| ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
+| ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
+| ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/Documentation/hwmon/hwmon-kernel-api.txt b/Documentation/hwmon/hwmon-kernel-api.txt
index eb7a78aebb38..8bdefb41be30 100644
--- a/Documentation/hwmon/hwmon-kernel-api.txt
+++ b/Documentation/hwmon/hwmon-kernel-api.txt
@@ -299,17 +299,25 @@ functions is used.
 The header file linux/hwmon-sysfs.h provides a number of useful macros to
 declare and use hardware monitoring sysfs attributes.
 
-In many cases, you can use the exsting define DEVICE_ATTR to declare such
-attributes. This is feasible if an attribute has no additional context. However,
-in many cases there will be additional information such as a sensor index which
-will need to be passed to the sysfs attribute handling function.
+In many cases, you can use the exsting define DEVICE_ATTR or its variants
+DEVICE_ATTR_{RW,RO,WO} to declare such attributes. This is feasible if an
+attribute has no additional context. However, in many cases there will be
+additional information such as a sensor index which will need to be passed
+to the sysfs attribute handling function.
 
 SENSOR_DEVICE_ATTR and SENSOR_DEVICE_ATTR_2 can be used to define attributes
 which need such additional context information. SENSOR_DEVICE_ATTR requires
 one additional argument, SENSOR_DEVICE_ATTR_2 requires two.
 
-SENSOR_DEVICE_ATTR defines a struct sensor_device_attribute variable.
-This structure has the following fields.
+Simplified variants of SENSOR_DEVICE_ATTR and SENSOR_DEVICE_ATTR_2 are available
+and should be used if standard attribute permissions and function names are
+feasible. Standard permissions are 0644 for SENSOR_DEVICE_ATTR[_2]_RW,
+0444 for SENSOR_DEVICE_ATTR[_2]_RO, and 0200 for SENSOR_DEVICE_ATTR[_2]_WO.
+Standard functions, similar to DEVICE_ATTR_{RW,RO,WO}, have _show and _store
+appended to the provided function name.
+
+SENSOR_DEVICE_ATTR and its variants define a struct sensor_device_attribute
+variable. This structure has the following fields.
 
 struct sensor_device_attribute {
 	struct device_attribute dev_attr;
@@ -320,8 +328,8 @@ You can use to_sensor_dev_attr to get the pointer to this structure from the
 attribute read or write function. Its parameter is the device to which the
 attribute is attached.
 
-SENSOR_DEVICE_ATTR_2 defines a struct sensor_device_attribute_2 variable,
-which is defined as follows.
+SENSOR_DEVICE_ATTR_2 and its variants define a struct sensor_device_attribute_2
+variable, which is defined as follows.
 
 struct sensor_device_attribute_2 {
 	struct device_attribute dev_attr;
diff --git a/Makefile b/Makefile
index 65697b49d500..eff48a05be02 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 319
+SUBLEVEL = 320
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e16f0d45b47a..15c7a2b6e491 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -531,6 +531,44 @@ config ARM64_ERRATUM_1742098
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_3194386
+	bool "Cortex-*/Neoverse-*: workaround for MSR SSBS not self-synchronizing"
+	default y
+	help
+	  This option adds the workaround for the following errata:
+
+	  * ARM Cortex-A76 erratum 3324349
+	  * ARM Cortex-A77 erratum 3324348
+	  * ARM Cortex-A78 erratum 3324344
+	  * ARM Cortex-A78C erratum 3324346
+	  * ARM Cortex-A78C erratum 3324347
+	  * ARM Cortex-A710 erratam 3324338
+	  * ARM Cortex-A720 erratum 3456091
+	  * ARM Cortex-A725 erratum 3456106
+	  * ARM Cortex-X1 erratum 3324344
+	  * ARM Cortex-X1C erratum 3324346
+	  * ARM Cortex-X2 erratum 3324338
+	  * ARM Cortex-X3 erratum 3324335
+	  * ARM Cortex-X4 erratum 3194386
+	  * ARM Cortex-X925 erratum 3324334
+	  * ARM Neoverse-N1 erratum 3324349
+	  * ARM Neoverse N2 erratum 3324339
+	  * ARM Neoverse-V1 erratum 3324341
+	  * ARM Neoverse V2 erratum 3324336
+	  * ARM Neoverse-V3 erratum 3312417
+
+	  On affected cores "MSR SSBS, #0" instructions may not affect
+	  subsequent speculative instructions, which may permit unexepected
+	  speculative store bypassing.
+
+	  Work around this problem by placing a Speculation Barrier (SB) or
+	  Instruction Synchronization Barrier (ISB) after kernel changes to
+	  SSBS. The presence of the SSBS special-purpose register is hidden
+	  from hwcaps and EL0 reads of ID_AA64PFR1_EL1, such that userspace
+	  will use the PR_SPEC_STORE_BYPASS prctl to change SSBS.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index f6931f8d36f6..ab870b904396 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -649,8 +649,8 @@
 			<0>, <24000000>,
 			<24000000>, <24000000>,
 			<15000000>, <15000000>,
-			<100000000>, <100000000>,
-			<100000000>, <100000000>,
+			<300000000>, <100000000>,
+			<400000000>, <100000000>,
 			<50000000>, <100000000>,
 			<100000000>, <100000000>,
 			<50000000>, <50000000>,
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index fc3d26c954a4..efabe6c476aa 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -133,6 +133,19 @@
 	hint	#22
 	.endm
 
+/*
+ * Speculation barrier
+ */
+	.macro	sb
+alternative_if_not ARM64_HAS_SB
+	dsb	nsh
+	isb
+alternative_else
+	SB_BARRIER_INSN
+	nop
+alternative_endif
+	.endm
+
 /*
  * Sanitise a 64-bit bounded index wrt speculation, returning zero if out
  * of bounds.
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 822a9192c551..f66bb04fdf2d 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -34,6 +34,10 @@
 #define psb_csync()	asm volatile("hint #17" : : : "memory")
 #define csdb()		asm volatile("hint #20" : : : "memory")
 
+#define spec_bar()	asm volatile(ALTERNATIVE("dsb nsh\nisb\n",		\
+						 SB_BARRIER_INSN"nop\n",	\
+						 ARM64_HAS_SB))
+
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
 #define wmb()		dsb(st)
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 61fd28522d74..3588caa7e2f7 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -56,7 +56,9 @@
 #define ARM64_WORKAROUND_1542419		35
 #define ARM64_SPECTRE_BHB			36
 #define ARM64_WORKAROUND_1742098		37
+#define ARM64_HAS_SB				38
+#define ARM64_WORKAROUND_SPECULATIVE_SSBS	39
 
-#define ARM64_NCAPS				38
+#define ARM64_NCAPS				40
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 50368f962213..f8be4d7ecde2 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -89,6 +89,14 @@
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
+#define ARM_CPU_PART_CORTEX_X1C		0xD4C
+#define ARM_CPU_PART_CORTEX_X3		0xD4E
+#define ARM_CPU_PART_NEOVERSE_V2	0xD4F
+#define ARM_CPU_PART_CORTEX_A720	0xD81
+#define ARM_CPU_PART_CORTEX_X4		0xD82
+#define ARM_CPU_PART_NEOVERSE_V3	0xD84
+#define ARM_CPU_PART_CORTEX_X925	0xD85
+#define ARM_CPU_PART_CORTEX_A725	0xD87
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -125,6 +133,14 @@
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
 #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
+#define MIDR_CORTEX_X1C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1C)
+#define MIDR_CORTEX_X3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X3)
+#define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
+#define MIDR_CORTEX_A720 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720)
+#define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
+#define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
+#define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
+#define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 0a8342de5796..8f015c20f3e0 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -97,6 +97,11 @@
 #define SET_PSTATE_SSBS(x) __emit_inst(0xd5000000 | REG_PSTATE_SSBS_IMM | \
 				       (!!x)<<8 | 0x1f)
 
+#define __SYS_BARRIER_INSN(CRm, op2, Rt) \
+	__emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
+
+#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
+
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
 #define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
 #define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
@@ -528,6 +533,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64isar1 */
+#define ID_AA64ISAR1_SB_SHIFT		36
 #define ID_AA64ISAR1_LRCPC_SHIFT	20
 #define ID_AA64ISAR1_FCMA_SHIFT		16
 #define ID_AA64ISAR1_JSCVT_SHIFT	12
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e66b0fca99c2..3c3bf4171f3b 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -46,8 +46,7 @@ static inline void set_fs(mm_segment_t fs)
 	 * Prevent a mispredicted conditional call to set_fs from forwarding
 	 * the wrong address limit to access_ok under speculation.
 	 */
-	dsb(nsh);
-	isb();
+	spec_bar();
 
 	/* On user-mode return, check fs is correct */
 	set_thread_flag(TIF_FSCHECK);
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 2bcd6e4f3474..7784f7cba16c 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -49,5 +49,6 @@
 #define HWCAP_ILRCPC		(1 << 26)
 #define HWCAP_FLAGM		(1 << 27)
 #define HWCAP_SSBS		(1 << 28)
+#define HWCAP_SB		(1 << 29)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 7edb587fec55..e87f8d60075d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -344,6 +344,19 @@ void arm64_set_ssbd_mitigation(bool state)
 			asm volatile(SET_PSTATE_SSBS(0));
 		else
 			asm volatile(SET_PSTATE_SSBS(1));
+
+		/*
+		 * SSBS is self-synchronizing and is intended to affect
+		 * subsequent speculative instructions, but some CPUs can
+		 * speculate with a stale value of SSBS.
+		 *
+		 * Mitigate this with an unconditional speculation barrier, as
+		 * CPUs could mis-speculate branches and bypass a conditional
+		 * barrier.
+		 */
+		if (IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386))
+			spec_bar();
+
 		return;
 	}
 
@@ -694,6 +707,29 @@ static struct midr_range broken_aarch32_aes[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_ERRATUM_3194386
+static const struct midr_range erratum_spec_ssbs_list[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	{}
+};
+#endif
 
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
@@ -903,6 +939,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		CAP_MIDR_RANGE_LIST(broken_aarch32_aes),
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 	},
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_3194386
+	{
+		.desc = "SSBS not fully self-synchronizing",
+		.capability = ARM64_WORKAROUND_SPECULATIVE_SSBS,
+		ERRATA_MIDR_RANGE_LIST(erratum_spec_ssbs_list),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d7e73a7963d1..451de5b28215 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -144,6 +144,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_LRCPC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_FCMA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_JSCVT_SHIFT, 4, 0),
@@ -273,6 +274,30 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_mvfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPROUND_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPSHVEC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPSQRT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPDIVIDE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPTRAP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPDP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPSP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_SIMD_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
+static const struct arm64_ftr_bits ftr_mvfr1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDFMAC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_FPHP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDHP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDSP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDINT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDLS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_FPDNAN_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_FPFTZ_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_mvfr2[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),		/* FPMisc */
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),		/* SIMDMisc */
@@ -288,10 +313,10 @@ static const struct arm64_ftr_bits ftr_dczid[] = {
 
 static const struct arm64_ftr_bits ftr_id_isar5[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_RDM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_CRC32_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA2_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA1_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_AES_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_CRC32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA1_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_AES_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SEVL_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
@@ -331,7 +356,7 @@ static const struct arm64_ftr_bits ftr_zcr[] = {
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
  * 0. Covers the following 32bit registers:
- * id_isar[0-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
+ * id_isar[1-3], id_mmfr[1-3]
  */
 static const struct arm64_ftr_bits ftr_generic_32bits[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
@@ -386,8 +411,8 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),
 
 	/* Op1 = 0, CRn = 0, CRm = 3 */
-	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_generic_32bits),
-	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_generic_32bits),
+	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_mvfr0),
+	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_mvfr1),
 	ARM64_FTR_REG(SYS_MVFR2_EL1, ftr_mvfr2),
 
 	/* Op1 = 0, CRn = 0, CRm = 4 */
@@ -826,20 +851,42 @@ feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 	return val >= entry->min_field_value;
 }
 
-static bool
-has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
+static u64
+read_scoped_sysreg(const struct arm64_cpu_capabilities *entry, int scope)
 {
-	u64 val;
-
 	WARN_ON(scope == SCOPE_LOCAL_CPU && preemptible());
 	if (scope == SCOPE_SYSTEM)
-		val = read_sanitised_ftr_reg(entry->sys_reg);
+		return read_sanitised_ftr_reg(entry->sys_reg);
 	else
-		val = __read_sysreg_by_encoding(entry->sys_reg);
+		return __read_sysreg_by_encoding(entry->sys_reg);
+}
+
+static bool
+has_user_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	int mask;
+	struct arm64_ftr_reg *regp;
+	u64 val = read_scoped_sysreg(entry, scope);
+
+	regp = get_arm64_ftr_reg(entry->sys_reg);
+	if (!regp)
+		return false;
+
+	mask = cpuid_feature_extract_unsigned_field(regp->user_mask,
+						    entry->field_pos);
+	if (!mask)
+		return false;
 
 	return feature_matches(val, entry);
 }
 
+static bool
+has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	u64 val = read_scoped_sysreg(entry, scope);
+	return feature_matches(val, entry);
+}
+
 static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	bool has_sre;
@@ -1155,6 +1202,17 @@ static void cpu_enable_ssbs(const struct arm64_cpu_capabilities *__unused)
 }
 #endif /* CONFIG_ARM64_SSBD */
 
+static void user_feature_fixup(void)
+{
+	if (cpus_have_cap(ARM64_WORKAROUND_SPECULATIVE_SSBS)) {
+		struct arm64_ftr_reg *regp;
+
+		regp = get_arm64_ftr_reg(SYS_ID_AA64PFR1_EL1);
+		if (regp)
+			regp->user_mask &= ~GENMASK(7, 4); /* SSBS */
+	}
+}
+
 static void elf_hwcap_fixup(void)
 {
 #ifdef CONFIG_ARM64_ERRATUM_1742098
@@ -1361,12 +1419,21 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_ssbs,
 	},
 #endif
+	{
+		.desc = "Speculation barrier (SB)",
+		.capability = ARM64_HAS_SB,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.field_pos = ID_AA64ISAR1_SB_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 1,
+	},
 	{},
 };
 
-
 #define HWCAP_CPUID_MATCH(reg, field, s, min_value)		\
-		.matches = has_cpuid_feature,			\
+		.matches = has_user_cpuid_feature,		\
 		.sys_reg = reg,					\
 		.field_pos = field,				\
 		.sign = s,					\
@@ -1415,6 +1482,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FCMA_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_FCMA),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_LRCPC),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_ILRCPC),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SB),
 	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_AT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, HWCAP_SVE),
@@ -1809,6 +1877,7 @@ void __init setup_cpu_features(void)
 
 	setup_system_capabilities();
 	mark_const_caps_ready();
+	user_feature_fixup();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0()) {
@@ -1842,7 +1911,7 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
 
 /*
  * We emulate only the following system register space.
- * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 4 - 7]
+ * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 2 - 7]
  * See Table C5-6 System instruction encodings for System register accesses,
  * ARMv8 ARM(ARM DDI 0487A.f) for more details.
  */
@@ -1852,7 +1921,7 @@ static inline bool __attribute_const__ is_emulated(u32 id)
 		sys_reg_CRn(id) == 0x0 &&
 		sys_reg_Op1(id) == 0x0 &&
 		(sys_reg_CRm(id) == 0 ||
-		 ((sys_reg_CRm(id) >= 4) && (sys_reg_CRm(id) <= 7))));
+		 ((sys_reg_CRm(id) >= 2) && (sys_reg_CRm(id) <= 7))));
 }
 
 /*
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 36bd58d8ca11..9d013e7106a9 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -82,6 +82,7 @@ static const char *const hwcap_str[] = {
 	"ilrcpc",
 	"flagm",
 	"ssbs",
+	"sb",
 	NULL
 };
 
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 65f63a457130..52dec92614e8 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -181,6 +181,15 @@ int __init amiga_parse_bootinfo(const struct bi_record *record)
 			dev->slotsize = be16_to_cpu(cd->cd_SlotSize);
 			dev->boardaddr = be32_to_cpu(cd->cd_BoardAddr);
 			dev->boardsize = be32_to_cpu(cd->cd_BoardSize);
+
+			/* CS-LAB Warp 1260 workaround */
+			if (be16_to_cpu(dev->rom.er_Manufacturer) == ZORRO_MANUF(ZORRO_PROD_CSLAB_WARP_1260) &&
+			    dev->rom.er_Product == ZORRO_PROD(ZORRO_PROD_CSLAB_WARP_1260)) {
+
+				/* turn off all interrupts */
+				pr_info("Warp 1260 card detected: applying interrupt storm workaround\n");
+				*(uint32_t *)(dev->boardaddr + 0x1000) = 0xfff;
+			}
 		} else
 			pr_warn("amiga_parse_bootinfo: too many AutoConfig devices\n");
 #endif /* CONFIG_ZORRO */
diff --git a/arch/m68k/atari/ataints.c b/arch/m68k/atari/ataints.c
index 56f02ea2c248..715d1e0d973e 100644
--- a/arch/m68k/atari/ataints.c
+++ b/arch/m68k/atari/ataints.c
@@ -302,11 +302,7 @@ void __init atari_init_IRQ(void)
 
 	if (ATARIHW_PRESENT(SCU)) {
 		/* init the SCU if present */
-		tt_scu.sys_mask = 0x10;		/* enable VBL (for the cursor) and
-									 * disable HSYNC interrupts (who
-									 * needs them?)  MFP and SCC are
-									 * enabled in VME mask
-									 */
+		tt_scu.sys_mask = 0x0;		/* disable all interrupts */
 		tt_scu.vme_mask = 0x60;		/* enable MFP and SCC ints */
 	} else {
 		/* If no SCU and no Hades, the HSYNC interrupt needs to be
diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index 38e1d7acc44d..1f996713ce87 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -33,7 +33,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 		x = tmp;
 		break;
 	default:
-		tmp = __invalid_xchg_size(x, ptr, size);
+		x = __invalid_xchg_size(x, ptr, size);
 		break;
 	}
 
diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 890e51b159e0..11a3d5120e2b 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -232,6 +232,10 @@ GCR_ACCESSOR_RO(32, 0x0d0, gic_status)
 GCR_ACCESSOR_RO(32, 0x0f0, cpc_status)
 #define CM_GCR_CPC_STATUS_EX			BIT(0)
 
+/* GCR_ACCESS - Controls core/IOCU access to GCRs */
+GCR_ACCESSOR_RW(32, 0x120, access_cm3)
+#define CM_GCR_ACCESS_ACCESSEN			GENMASK(7, 0)
+
 /* GCR_L2_CONFIG - Indicates L2 cache configuration when Config5.L2C=1 */
 GCR_ACCESSOR_RW(32, 0x130, l2_config)
 #define CM_GCR_L2_CONFIG_BYPASS			BIT(20)
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 03f1026ad148..1861b20e978d 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -233,7 +233,10 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	write_gcr_co_reset_ext_base(CM_GCR_Cx_RESET_EXT_BASE_UEB);
 
 	/* Ensure the core can access the GCRs */
-	set_gcr_access(1 << core);
+	if (mips_cm_revision() < CM_REV_CM3)
+		set_gcr_access(1 << core);
+	else
+		set_gcr_access_cm3(1 << core);
 
 	if (mips_cpc_present()) {
 		/* Reset the core */
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
old mode 100755
new mode 100644
diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 27f1e6415036..8f84e6502776 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -133,32 +133,21 @@ int print_insn_powerpc (unsigned long insn, unsigned long memaddr)
   bool insn_is_short;
   ppc_cpu_t dialect;
 
-  dialect = PPC_OPCODE_PPC | PPC_OPCODE_COMMON
-            | PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_ALTIVEC;
+  dialect = PPC_OPCODE_PPC | PPC_OPCODE_COMMON;
 
-  if (cpu_has_feature(CPU_FTRS_POWER5))
-    dialect |= PPC_OPCODE_POWER5;
+  if (IS_ENABLED(CONFIG_PPC64))
+    dialect |= PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_CELL |
+	PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7 | PPC_OPCODE_POWER8 |
+	PPC_OPCODE_POWER9;
 
-  if (cpu_has_feature(CPU_FTRS_CELL))
-    dialect |= (PPC_OPCODE_CELL | PPC_OPCODE_ALTIVEC);
+  if (cpu_has_feature(CPU_FTR_TM))
+    dialect |= PPC_OPCODE_HTM;
 
-  if (cpu_has_feature(CPU_FTRS_POWER6))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_ALTIVEC);
+  if (cpu_has_feature(CPU_FTR_ALTIVEC))
+    dialect |= PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2;
 
-  if (cpu_has_feature(CPU_FTRS_POWER7))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
-                | PPC_OPCODE_ALTIVEC | PPC_OPCODE_VSX);
-
-  if (cpu_has_feature(CPU_FTRS_POWER8))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
-		| PPC_OPCODE_POWER8 | PPC_OPCODE_HTM
-		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2 | PPC_OPCODE_VSX);
-
-  if (cpu_has_feature(CPU_FTRS_POWER9))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
-		| PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9 | PPC_OPCODE_HTM
-		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
-		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3);
+  if (cpu_has_feature(CPU_FTR_VSX))
+    dialect |= PPC_OPCODE_VSX | PPC_OPCODE_VSX3;
 
   /* Get the major opcode of the insn.  */
   opcode = NULL;
diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index a67abebd4359..1b86d02a8455 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -247,6 +247,7 @@ void prom_sun4v_guest_soft_state(void);
 int prom_ihandle2path(int handle, char *buffer, int bufsize);
 
 /* Client interface level routines. */
+void prom_cif_init(void *cif_handler);
 void p1275_cmd_direct(unsigned long *);
 
 #endif /* !(__SPARC64_OPLIB_H) */
diff --git a/arch/sparc/prom/init_64.c b/arch/sparc/prom/init_64.c
index 103aa9104318..f7b8a1a865b8 100644
--- a/arch/sparc/prom/init_64.c
+++ b/arch/sparc/prom/init_64.c
@@ -26,9 +26,6 @@ phandle prom_chosen_node;
  * routines in the prom library.
  * It gets passed the pointer to the PROM vector.
  */
-
-extern void prom_cif_init(void *);
-
 void __init prom_init(void *cif_handler)
 {
 	phandle node;
diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index 889aa602f8d8..51c3f984bbf7 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -49,7 +49,7 @@ void p1275_cmd_direct(unsigned long *args)
 	local_irq_restore(flags);
 }
 
-void prom_cif_init(void *cif_handler, void *cif_stack)
+void prom_cif_init(void *cif_handler)
 {
 	p1275buf.prom_cif_handler = (void (*)(long *))cif_handler;
 }
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 49b3ea1c1ea1..87cca5622885 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -75,7 +75,7 @@ static struct pt_cap_desc {
 	PT_CAP(psb_periods,		1, CPUID_EBX, 0xffff0000),
 };
 
-static u32 pt_cap_get(enum pt_capabilities cap)
+u32 intel_pt_validate_hw_cap(enum pt_capabilities cap)
 {
 	struct pt_cap_desc *cd = &pt_caps[cap];
 	u32 c = pt_pmu.caps[cd->leaf * PT_CPUID_REGS_NUM + cd->reg];
@@ -83,6 +83,7 @@ static u32 pt_cap_get(enum pt_capabilities cap)
 
 	return (c & cd->mask) >> shift;
 }
+EXPORT_SYMBOL_GPL(intel_pt_validate_hw_cap);
 
 static ssize_t pt_cap_show(struct device *cdev,
 			   struct device_attribute *attr,
@@ -92,7 +93,7 @@ static ssize_t pt_cap_show(struct device *cdev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	enum pt_capabilities cap = (long)ea->var;
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", pt_cap_get(cap));
+	return snprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(cap));
 }
 
 static struct attribute_group pt_cap_group = {
@@ -310,16 +311,16 @@ static bool pt_event_valid(struct perf_event *event)
 		return false;
 
 	if (config & RTIT_CTL_CYC_PSB) {
-		if (!pt_cap_get(PT_CAP_psb_cyc))
+		if (!intel_pt_validate_hw_cap(PT_CAP_psb_cyc))
 			return false;
 
-		allowed = pt_cap_get(PT_CAP_psb_periods);
+		allowed = intel_pt_validate_hw_cap(PT_CAP_psb_periods);
 		requested = (config & RTIT_CTL_PSB_FREQ) >>
 			RTIT_CTL_PSB_FREQ_OFFSET;
 		if (requested && (!(allowed & BIT(requested))))
 			return false;
 
-		allowed = pt_cap_get(PT_CAP_cycle_thresholds);
+		allowed = intel_pt_validate_hw_cap(PT_CAP_cycle_thresholds);
 		requested = (config & RTIT_CTL_CYC_THRESH) >>
 			RTIT_CTL_CYC_THRESH_OFFSET;
 		if (requested && (!(allowed & BIT(requested))))
@@ -334,10 +335,10 @@ static bool pt_event_valid(struct perf_event *event)
 		 * Spec says that setting mtc period bits while mtc bit in
 		 * CPUID is 0 will #GP, so better safe than sorry.
 		 */
-		if (!pt_cap_get(PT_CAP_mtc))
+		if (!intel_pt_validate_hw_cap(PT_CAP_mtc))
 			return false;
 
-		allowed = pt_cap_get(PT_CAP_mtc_periods);
+		allowed = intel_pt_validate_hw_cap(PT_CAP_mtc_periods);
 		if (!allowed)
 			return false;
 
@@ -349,11 +350,11 @@ static bool pt_event_valid(struct perf_event *event)
 	}
 
 	if (config & RTIT_CTL_PWR_EVT_EN &&
-	    !pt_cap_get(PT_CAP_power_event_trace))
+	    !intel_pt_validate_hw_cap(PT_CAP_power_event_trace))
 		return false;
 
 	if (config & RTIT_CTL_PTW) {
-		if (!pt_cap_get(PT_CAP_ptwrite))
+		if (!intel_pt_validate_hw_cap(PT_CAP_ptwrite))
 			return false;
 
 		/* FUPonPTW without PTW doesn't make sense */
@@ -545,16 +546,8 @@ static void pt_config_buffer(void *buf, unsigned int topa_idx,
 	wrmsrl(MSR_IA32_RTIT_OUTPUT_MASK, reg);
 }
 
-/*
- * Keep ToPA table-related metadata on the same page as the actual table,
- * taking up a few words from the top
- */
-
-#define TENTS_PER_PAGE (((PAGE_SIZE - 40) / sizeof(struct topa_entry)) - 1)
-
 /**
- * struct topa - page-sized ToPA table with metadata at the top
- * @table:	actual ToPA table entries, as understood by PT hardware
+ * struct topa - ToPA metadata
  * @list:	linkage to struct pt_buffer's list of tables
  * @phys:	physical address of this page
  * @offset:	offset of the first entry in this table in the buffer
@@ -562,7 +555,6 @@ static void pt_config_buffer(void *buf, unsigned int topa_idx,
  * @last:	index of the last initialized entry in this table
  */
 struct topa {
-	struct topa_entry	table[TENTS_PER_PAGE];
 	struct list_head	list;
 	u64			phys;
 	u64			offset;
@@ -570,8 +562,40 @@ struct topa {
 	int			last;
 };
 
+/*
+ * Keep ToPA table-related metadata on the same page as the actual table,
+ * taking up a few words from the top
+ */
+
+#define TENTS_PER_PAGE	\
+	((PAGE_SIZE - sizeof(struct topa)) / sizeof(struct topa_entry))
+
+/**
+ * struct topa_page - page-sized ToPA table with metadata at the top
+ * @table:	actual ToPA table entries, as understood by PT hardware
+ * @topa:	metadata
+ */
+struct topa_page {
+	struct topa_entry	table[TENTS_PER_PAGE];
+	struct topa		topa;
+};
+
+static inline struct topa_page *topa_to_page(struct topa *topa)
+{
+	return container_of(topa, struct topa_page, topa);
+}
+
+static inline struct topa_page *topa_entry_to_page(struct topa_entry *te)
+{
+	return (struct topa_page *)((unsigned long)te & PAGE_MASK);
+}
+
 /* make -1 stand for the last table entry */
-#define TOPA_ENTRY(t, i) ((i) == -1 ? &(t)->table[(t)->last] : &(t)->table[(i)])
+#define TOPA_ENTRY(t, i)				\
+	((i) == -1					\
+		? &topa_to_page(t)->table[(t)->last]	\
+		: &topa_to_page(t)->table[(i)])
+#define TOPA_ENTRY_SIZE(t, i) (sizes(TOPA_ENTRY((t), (i))->size))
 
 /**
  * topa_alloc() - allocate page-sized ToPA table
@@ -583,27 +607,27 @@ struct topa {
 static struct topa *topa_alloc(int cpu, gfp_t gfp)
 {
 	int node = cpu_to_node(cpu);
-	struct topa *topa;
+	struct topa_page *tp;
 	struct page *p;
 
 	p = alloc_pages_node(node, gfp | __GFP_ZERO, 0);
 	if (!p)
 		return NULL;
 
-	topa = page_address(p);
-	topa->last = 0;
-	topa->phys = page_to_phys(p);
+	tp = page_address(p);
+	tp->topa.last = 0;
+	tp->topa.phys = page_to_phys(p);
 
 	/*
 	 * In case of singe-entry ToPA, always put the self-referencing END
 	 * link as the 2nd entry in the table
 	 */
-	if (!pt_cap_get(PT_CAP_topa_multiple_entries)) {
-		TOPA_ENTRY(topa, 1)->base = topa->phys >> TOPA_SHIFT;
-		TOPA_ENTRY(topa, 1)->end = 1;
+	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
+		TOPA_ENTRY(&tp->topa, 1)->base = tp->topa.phys;
+		TOPA_ENTRY(&tp->topa, 1)->end = 1;
 	}
 
-	return topa;
+	return &tp->topa;
 }
 
 /**
@@ -638,7 +662,7 @@ static void topa_insert_table(struct pt_buffer *buf, struct topa *topa)
 	topa->offset = last->offset + last->size;
 	buf->last = topa;
 
-	if (!pt_cap_get(PT_CAP_topa_multiple_entries))
+	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		return;
 
 	BUG_ON(last->last != TENTS_PER_PAGE - 1);
@@ -654,7 +678,7 @@ static void topa_insert_table(struct pt_buffer *buf, struct topa *topa)
 static bool topa_table_full(struct topa *topa)
 {
 	/* single-entry ToPA is a special case */
-	if (!pt_cap_get(PT_CAP_topa_multiple_entries))
+	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		return !!topa->last;
 
 	return topa->last == TENTS_PER_PAGE - 1;
@@ -690,7 +714,8 @@ static int topa_insert_pages(struct pt_buffer *buf, gfp_t gfp)
 
 	TOPA_ENTRY(topa, -1)->base = page_to_phys(p) >> TOPA_SHIFT;
 	TOPA_ENTRY(topa, -1)->size = order;
-	if (!buf->snapshot && !pt_cap_get(PT_CAP_topa_multiple_entries)) {
+	if (!buf->snapshot &&
+	    !intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
 		TOPA_ENTRY(topa, -1)->intr = 1;
 		TOPA_ENTRY(topa, -1)->stop = 1;
 	}
@@ -712,22 +737,23 @@ static void pt_topa_dump(struct pt_buffer *buf)
 	struct topa *topa;
 
 	list_for_each_entry(topa, &buf->tables, list) {
+		struct topa_page *tp = topa_to_page(topa);
 		int i;
 
-		pr_debug("# table @%p (%016Lx), off %llx size %zx\n", topa->table,
+		pr_debug("# table @%p (%016Lx), off %llx size %zx\n", tp->table,
 			 topa->phys, topa->offset, topa->size);
 		for (i = 0; i < TENTS_PER_PAGE; i++) {
 			pr_debug("# entry @%p (%lx sz %u %c%c%c) raw=%16llx\n",
-				 &topa->table[i],
-				 (unsigned long)topa->table[i].base << TOPA_SHIFT,
-				 sizes(topa->table[i].size),
-				 topa->table[i].end ?  'E' : ' ',
-				 topa->table[i].intr ? 'I' : ' ',
-				 topa->table[i].stop ? 'S' : ' ',
-				 *(u64 *)&topa->table[i]);
-			if ((pt_cap_get(PT_CAP_topa_multiple_entries) &&
-			     topa->table[i].stop) ||
-			    topa->table[i].end)
+				 &tp->table[i],
+				 (unsigned long)tp->table[i].base << TOPA_SHIFT,
+				 sizes(tp->table[i].size),
+				 tp->table[i].end ?  'E' : ' ',
+				 tp->table[i].intr ? 'I' : ' ',
+				 tp->table[i].stop ? 'S' : ' ',
+				 *(u64 *)&tp->table[i]);
+			if ((intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) &&
+			     tp->table[i].stop) ||
+			    tp->table[i].end)
 				break;
 		}
 	}
@@ -770,7 +796,7 @@ static void pt_update_head(struct pt *pt)
 
 	/* offset of the current output region within this table */
 	for (topa_idx = 0; topa_idx < buf->cur_idx; topa_idx++)
-		base += sizes(buf->cur->table[topa_idx].size);
+		base += TOPA_ENTRY_SIZE(buf->cur, topa_idx);
 
 	if (buf->snapshot) {
 		local_set(&buf->data_size, base);
@@ -790,7 +816,7 @@ static void pt_update_head(struct pt *pt)
  */
 static void *pt_buffer_region(struct pt_buffer *buf)
 {
-	return phys_to_virt(buf->cur->table[buf->cur_idx].base << TOPA_SHIFT);
+	return phys_to_virt((phys_addr_t)TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
 }
 
 /**
@@ -799,7 +825,7 @@ static void *pt_buffer_region(struct pt_buffer *buf)
  */
 static size_t pt_buffer_region_size(struct pt_buffer *buf)
 {
-	return sizes(buf->cur->table[buf->cur_idx].size);
+	return TOPA_ENTRY_SIZE(buf->cur, buf->cur_idx);
 }
 
 /**
@@ -828,8 +854,8 @@ static void pt_handle_status(struct pt *pt)
 		 * means we are already losing data; need to let the decoder
 		 * know.
 		 */
-		if (!pt_cap_get(PT_CAP_topa_multiple_entries) ||
-		    buf->output_off == sizes(TOPA_ENTRY(buf->cur, buf->cur_idx)->size)) {
+		if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) ||
+		    buf->output_off == pt_buffer_region_size(buf)) {
 			perf_aux_output_flag(&pt->handle,
 			                     PERF_AUX_FLAG_TRUNCATED);
 			advance++;
@@ -840,7 +866,8 @@ static void pt_handle_status(struct pt *pt)
 	 * Also on single-entry ToPA implementations, interrupt will come
 	 * before the output reaches its output region's boundary.
 	 */
-	if (!pt_cap_get(PT_CAP_topa_multiple_entries) && !buf->snapshot &&
+	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries) &&
+	    !buf->snapshot &&
 	    pt_buffer_region_size(buf) - buf->output_off <= TOPA_PMI_MARGIN) {
 		void *head = pt_buffer_region(buf);
 
@@ -866,9 +893,11 @@ static void pt_handle_status(struct pt *pt)
 static void pt_read_offset(struct pt_buffer *buf)
 {
 	u64 offset, base_topa;
+	struct topa_page *tp;
 
 	rdmsrl(MSR_IA32_RTIT_OUTPUT_BASE, base_topa);
-	buf->cur = phys_to_virt(base_topa);
+	tp = phys_to_virt(base_topa);
+	buf->cur = &tp->topa;
 
 	rdmsrl(MSR_IA32_RTIT_OUTPUT_MASK, offset);
 	/* offset within current output region */
@@ -923,15 +952,14 @@ static int pt_buffer_reset_markers(struct pt_buffer *buf,
 	unsigned long idx, npages, wakeup;
 
 	/* can't stop in the middle of an output region */
-	if (buf->output_off + handle->size + 1 <
-	    sizes(TOPA_ENTRY(buf->cur, buf->cur_idx)->size)) {
+	if (buf->output_off + handle->size + 1 < pt_buffer_region_size(buf)) {
 		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
 		return -EINVAL;
 	}
 
 
 	/* single entry ToPA is handled by marking all regions STOP=1 INT=1 */
-	if (!pt_cap_get(PT_CAP_topa_multiple_entries))
+	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		return 0;
 
 	/* clear STOP and INT from current entry */
@@ -1019,6 +1047,7 @@ static void pt_buffer_setup_topa_index(struct pt_buffer *buf)
  */
 static void pt_buffer_reset_offsets(struct pt_buffer *buf, unsigned long head)
 {
+	struct topa_page *cur_tp;
 	int pg;
 
 	if (buf->snapshot)
@@ -1027,10 +1056,10 @@ static void pt_buffer_reset_offsets(struct pt_buffer *buf, unsigned long head)
 	pg = (head >> PAGE_SHIFT) & (buf->nr_pages - 1);
 	pg = pt_topa_next_entry(buf, pg);
 
-	buf->cur = (struct topa *)((unsigned long)buf->topa_index[pg] & PAGE_MASK);
-	buf->cur_idx = ((unsigned long)buf->topa_index[pg] -
-			(unsigned long)buf->cur) / sizeof(struct topa_entry);
-	buf->output_off = head & (sizes(buf->cur->table[buf->cur_idx].size) - 1);
+	cur_tp = topa_entry_to_page(buf->topa_index[pg]);
+	buf->cur = &cur_tp->topa;
+	buf->cur_idx = buf->topa_index[pg] - TOPA_ENTRY(buf->cur, 0);
+	buf->output_off = head & (pt_buffer_region_size(buf) - 1);
 
 	local64_set(&buf->head, head);
 	local_set(&buf->data_size, 0);
@@ -1082,7 +1111,7 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, unsigned long nr_pages,
 	pt_buffer_setup_topa_index(buf);
 
 	/* link last table to the first one, unless we're double buffering */
-	if (pt_cap_get(PT_CAP_topa_multiple_entries)) {
+	if (intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries)) {
 		TOPA_ENTRY(buf->last, -1)->base = buf->first->phys >> TOPA_SHIFT;
 		TOPA_ENTRY(buf->last, -1)->end = 1;
 	}
@@ -1154,7 +1183,7 @@ static int pt_addr_filters_init(struct perf_event *event)
 	struct pt_filters *filters;
 	int node = event->cpu == -1 ? -1 : cpu_to_node(event->cpu);
 
-	if (!pt_cap_get(PT_CAP_num_address_ranges))
+	if (!intel_pt_validate_hw_cap(PT_CAP_num_address_ranges))
 		return 0;
 
 	filters = kzalloc_node(sizeof(struct pt_filters), GFP_KERNEL, node);
@@ -1203,7 +1232,7 @@ static int pt_event_addr_filters_validate(struct list_head *filters)
 				return -EINVAL;
 		}
 
-		if (++range > pt_cap_get(PT_CAP_num_address_ranges))
+		if (++range > intel_pt_validate_hw_cap(PT_CAP_num_address_ranges))
 			return -EOPNOTSUPP;
 	}
 
@@ -1294,7 +1323,7 @@ void intel_pt_interrupt(void)
 			return;
 		}
 
-		pt_config_buffer(buf->cur->table, buf->cur_idx,
+		pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
 				 buf->output_off);
 		pt_config(event);
 	}
@@ -1359,7 +1388,7 @@ static void pt_event_start(struct perf_event *event, int mode)
 	WRITE_ONCE(pt->handle_nmi, 1);
 	hwc->state = 0;
 
-	pt_config_buffer(buf->cur->table, buf->cur_idx,
+	pt_config_buffer(topa_to_page(buf->cur)->table, buf->cur_idx,
 			 buf->output_off);
 	pt_config(event);
 
@@ -1509,12 +1538,12 @@ static __init int pt_init(void)
 	if (ret)
 		return ret;
 
-	if (!pt_cap_get(PT_CAP_topa_output)) {
+	if (!intel_pt_validate_hw_cap(PT_CAP_topa_output)) {
 		pr_warn("ToPA output is not supported on this CPU\n");
 		return -ENODEV;
 	}
 
-	if (!pt_cap_get(PT_CAP_topa_multiple_entries))
+	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		pt_pmu.pmu.capabilities =
 			PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_SW_DOUBLEBUF;
 
@@ -1532,7 +1561,7 @@ static __init int pt_init(void)
 	pt_pmu.pmu.addr_filters_sync     = pt_event_addr_filters_sync;
 	pt_pmu.pmu.addr_filters_validate = pt_event_addr_filters_validate;
 	pt_pmu.pmu.nr_addr_filters       =
-		pt_cap_get(PT_CAP_num_address_ranges);
+		intel_pt_validate_hw_cap(PT_CAP_num_address_ranges);
 
 	ret = perf_pmu_register(&pt_pmu.pmu, "intel_pt", -1);
 
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 0eb41d07b79a..ad4ac27f0468 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -78,34 +78,13 @@ struct topa_entry {
 	u64	rsvd2	: 1;
 	u64	size	: 4;
 	u64	rsvd3	: 2;
-	u64	base	: 36;
-	u64	rsvd4	: 16;
+	u64	base	: 40;
+	u64	rsvd4	: 12;
 };
 
-#define PT_CPUID_LEAVES		2
-#define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
-
 /* TSC to Core Crystal Clock Ratio */
 #define CPUID_TSC_LEAF		0x15
 
-enum pt_capabilities {
-	PT_CAP_max_subleaf = 0,
-	PT_CAP_cr3_filtering,
-	PT_CAP_psb_cyc,
-	PT_CAP_ip_filtering,
-	PT_CAP_mtc,
-	PT_CAP_ptwrite,
-	PT_CAP_power_event_trace,
-	PT_CAP_topa_output,
-	PT_CAP_topa_multiple_entries,
-	PT_CAP_single_range_output,
-	PT_CAP_payloads_lip,
-	PT_CAP_num_address_ranges,
-	PT_CAP_mtc_periods,
-	PT_CAP_cycle_thresholds,
-	PT_CAP_psb_periods,
-};
-
 struct pt_pmu {
 	struct pmu		pmu;
 	u32			caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index b523f51c5400..fa4b4fd2dbed 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -2,10 +2,33 @@
 #ifndef _ASM_X86_INTEL_PT_H
 #define _ASM_X86_INTEL_PT_H
 
+#define PT_CPUID_LEAVES		2
+#define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
+
+enum pt_capabilities {
+	PT_CAP_max_subleaf = 0,
+	PT_CAP_cr3_filtering,
+	PT_CAP_psb_cyc,
+	PT_CAP_ip_filtering,
+	PT_CAP_mtc,
+	PT_CAP_ptwrite,
+	PT_CAP_power_event_trace,
+	PT_CAP_topa_output,
+	PT_CAP_topa_multiple_entries,
+	PT_CAP_single_range_output,
+	PT_CAP_payloads_lip,
+	PT_CAP_num_address_ranges,
+	PT_CAP_mtc_periods,
+	PT_CAP_cycle_thresholds,
+	PT_CAP_psb_periods,
+};
+
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 void cpu_emergency_stop_pt(void);
+extern u32 intel_pt_validate_hw_cap(enum pt_capabilities cap);
 #else
 static inline void cpu_emergency_stop_pt(void) {}
+static inline u32 intel_pt_validate_hw_cap(enum pt_capabilities cap) { return 0; }
 #endif
 
 #endif /* _ASM_X86_INTEL_PT_H */
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 9a19c800fe40..1935e20c6759 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -819,7 +819,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled() || !mtrr_state.have_fixed)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index f39f3a06c26f..c4c84e1a3044 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -90,7 +90,7 @@ static int x86_of_pci_irq_enable(struct pci_dev *dev)
 
 	ret = pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 	if (!pin)
 		return 0;
 
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 622d5968c979..21105ae44ca1 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -383,14 +383,14 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			 */
 			*target_pmd = *pmd;
 
-			addr += PMD_SIZE;
+			addr = round_up(addr + 1, PMD_SIZE);
 
 		} else if (level == PTI_CLONE_PTE) {
 
 			/* Walk the page-table down to the pte level */
 			pte = pte_offset_kernel(pmd, addr);
 			if (pte_none(*pte)) {
-				addr += PAGE_SIZE;
+				addr = round_up(addr + 1, PAGE_SIZE);
 				continue;
 			}
 
@@ -410,7 +410,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			/* Clone the PTE */
 			*target_pte = *pte;
 
-			addr += PAGE_SIZE;
+			addr = round_up(addr + 1, PAGE_SIZE);
 
 		} else {
 			BUG();
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index eea5a0f3b959..63513968f561 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -223,9 +223,9 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 
 	ret = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
-	if (ret < 0) {
+	if (ret) {
 		dev_warn(&dev->dev, "Failed to read interrupt line: %d\n", ret);
-		return ret;
+		return pcibios_err_to_errno(ret);
 	}
 
 	switch (intel_mid_identify_cpu()) {
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index bacf8d988f65..d308057aec0b 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -36,10 +36,10 @@ static int xen_pcifront_enable_irq(struct pci_dev *dev)
 	u8 gsi;
 
 	rc = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
-	if (rc < 0) {
+	if (rc) {
 		dev_warn(&dev->dev, "Xen PCI: failed to read interrupt line: %d\n",
 			 rc);
-		return rc;
+		return pcibios_err_to_errno(rc);
 	}
 	/* In PV DomU the Xen PCI backend puts the PIRQ in the interrupt line.*/
 	pirq = gsi;
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index 6f37a2137a79..dfeedbd6467f 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -68,7 +68,7 @@ static int iosf_mbi_pci_read_mdr(u32 mcrx, u32 mcr, u32 *mdr)
 
 fail_read:
 	dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
-	return result;
+	return pcibios_err_to_errno(result);
 }
 
 static int iosf_mbi_pci_write_mdr(u32 mcrx, u32 mcr, u32 mdr)
@@ -97,7 +97,7 @@ static int iosf_mbi_pci_write_mdr(u32 mcrx, u32 mcr, u32 mdr)
 
 fail_write:
 	dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
-	return result;
+	return pcibios_err_to_errno(result);
 }
 
 int iosf_mbi_read(u8 port, u8 opcode, u32 offset, u32 *mdr)
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index f9b31eb6846c..8cbdc5e6863c 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -733,7 +733,7 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
 		 * immediate unmapping.
 		 */
 		map_ops[i].status = GNTST_general_error;
-		unmap[0].host_addr = map_ops[i].host_addr,
+		unmap[0].host_addr = map_ops[i].host_addr;
 		unmap[0].handle = map_ops[i].handle;
 		map_ops[i].handle = ~0;
 		if (map_ops[i].flags & GNTMAP_device_map)
@@ -743,7 +743,7 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
 
 		if (kmap_ops) {
 			kmap_ops[i].status = GNTST_general_error;
-			unmap[1].host_addr = kmap_ops[i].host_addr,
+			unmap[1].host_addr = kmap_ops[i].host_addr;
 			unmap[1].handle = kmap_ops[i].handle;
 			kmap_ops[i].handle = ~0;
 			if (kmap_ops[i].flags & GNTMAP_device_map)
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4150f8751658..a928b9da0e9a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -998,9 +998,7 @@ static bool binder_has_work(struct binder_thread *thread, bool do_proc_work)
 static bool binder_available_for_proc_work_ilocked(struct binder_thread *thread)
 {
 	return !thread->transaction_stack &&
-		binder_worklist_empty_ilocked(&thread->todo) &&
-		(thread->looper & (BINDER_LOOPER_STATE_ENTERED |
-				   BINDER_LOOPER_STATE_REGISTERED));
+		binder_worklist_empty_ilocked(&thread->todo);
 }
 
 static void binder_wakeup_poll_threads_ilocked(struct binder_proc *proc,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 838d084d852b..8d86ca28c54d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -24,6 +24,7 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
+#include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/sysfs.h>
 
@@ -1137,6 +1138,7 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
 		      struct kobj_uevent_env *env)
 {
 	struct device *dev = kobj_to_dev(kobj);
+	struct device_driver *driver;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -1165,8 +1167,12 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	if (dev->driver)
-		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+	/* Synchronize with module_remove_driver() */
+	rcu_read_lock();
+	driver = READ_ONCE(dev->driver);
+	if (driver)
+		add_uevent_var(env, "DRIVER=%s", driver->name);
+	rcu_read_unlock();
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
@@ -1236,11 +1242,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
-	/* Synchronize with really_probe() */
-	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(kset, &dev->kobj, env);
-	device_unlock(dev);
 	if (retval)
 		goto out;
 
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index d68b52cf9225..a64f70a62e28 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1057,7 +1057,11 @@ EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
  */
 void devm_free_percpu(struct device *dev, void __percpu *pdata)
 {
-	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
-			       (void *)pdata));
+	/*
+	 * Use devres_release() to prevent memory leakage as
+	 * devm_free_pages() does.
+	 */
+	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
+			       (__force void *)pdata));
 }
 EXPORT_SYMBOL_GPL(devm_free_percpu);
diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..851cc5367c04 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -7,6 +7,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/rcupdate.h>
 #include "base.h"
 
 static char *make_driver_name(struct device_driver *drv)
@@ -77,6 +78,9 @@ void module_remove_driver(struct device_driver *drv)
 	if (!drv)
 		return;
 
+	/* Synchronize with dev_uevent() */
+	synchronize_rcu();
+
 	sysfs_remove_link(&drv->p->kobj, "module");
 
 	if (drv->owner)
diff --git a/drivers/char/hw_random/amd-rng.c b/drivers/char/hw_random/amd-rng.c
index db3dd467194c..3f3fdf6ee3d5 100644
--- a/drivers/char/hw_random/amd-rng.c
+++ b/drivers/char/hw_random/amd-rng.c
@@ -142,8 +142,10 @@ static int __init mod_init(void)
 
 found:
 	err = pci_read_config_dword(pdev, 0x58, &pmbase);
-	if (err)
+	if (err) {
+		err = pcibios_err_to_errno(err);
 		goto put_dev;
+	}
 
 	pmbase &= 0x0000FF00;
 	if (pmbase == 0) {
diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 462476467bff..1d7ee22deeab 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -52,6 +52,8 @@ static int tpm_bios_measurements_open(struct inode *inode,
 	if (!err) {
 		seq = file->private_data;
 		seq->private = chip;
+	} else {
+		put_device(&chip->dev);
 	}
 
 	return err;
diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index d1bbee19ed0f..2b750f25479c 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -507,7 +507,7 @@ da8xx_cfgchip_register_usb0_clk48(struct device *dev,
 	const char * const parent_names[] = { "usb_refclkin", "pll0_auxclk" };
 	struct clk *fck_clk;
 	struct da8xx_usb0_clk48 *usb0;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	fck_clk = devm_clk_get(dev, "fck");
@@ -581,7 +581,7 @@ da8xx_cfgchip_register_usb1_clk48(struct device *dev,
 {
 	const char * const parent_names[] = { "usb0_clk48", "usb_refclkin" };
 	struct da8xx_usb1_clk48 *usb1;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb1 = devm_kzalloc(dev, sizeof(*usb1), GFP_KERNEL);
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 0ca8819acc4d..278b27298ca4 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -518,6 +518,7 @@ static void sh_cmt_set_next(struct sh_cmt_channel *ch, unsigned long delta)
 static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 {
 	struct sh_cmt_channel *ch = dev_id;
+	unsigned long flags;
 
 	/* clear flags */
 	sh_cmt_write_cmcsr(ch, sh_cmt_read_cmcsr(ch) &
@@ -548,6 +549,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 
 	ch->flags &= ~FLAG_SKIPEVENT;
 
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (ch->flags & FLAG_REPROGRAM) {
 		ch->flags &= ~FLAG_REPROGRAM;
 		sh_cmt_clock_event_program_verify(ch, 1);
@@ -560,6 +563,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 
 	ch->flags &= ~FLAG_IRQCONTEXT;
 
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
@@ -758,12 +763,18 @@ static int sh_cmt_clock_event_next(unsigned long delta,
 				   struct clock_event_device *ced)
 {
 	struct sh_cmt_channel *ch = ced_to_sh_cmt(ced);
+	unsigned long flags;
 
 	BUG_ON(!clockevent_state_oneshot(ced));
+
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (likely(ch->flags & FLAG_IRQCONTEXT))
 		ch->next_match_value = delta - 1;
 	else
-		sh_cmt_set_next(ch, delta - 1);
+		__sh_cmt_set_next(ch, delta - 1);
+
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index a5f2763d72e4..229b05cd3c9a 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1109,7 +1109,6 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 	u32 status_reg;
 	u8 *buffer = msg->buffer;
 	unsigned int i;
-	int num_transferred = 0;
 	int ret;
 
 	/* Buffer size of AUX CH is 16 bytes */
@@ -1161,7 +1160,6 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			reg = buffer[i];
 			writel(reg, dp->reg_base + ANALOGIX_DP_BUF_DATA_0 +
 			       4 * i);
-			num_transferred++;
 		}
 	}
 
@@ -1209,7 +1207,6 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			reg = readl(dp->reg_base + ANALOGIX_DP_BUF_DATA_0 +
 				    4 * i);
 			buffer[i] = (unsigned char)reg;
-			num_transferred++;
 		}
 	}
 
@@ -1226,7 +1223,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 		 (msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_NATIVE_READ)
 		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
 
-	return num_transferred > 0 ? num_transferred : -EBUSY;
+	return msg->size;
 
 aux_error:
 	/* if aux err happen, reset aux */
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 1fa74226db91..69f91662ba23 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -370,9 +370,11 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 
 static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
 {
-	if (op & ETNA_PREP_READ)
+	op &= ETNA_PREP_READ | ETNA_PREP_WRITE;
+
+	if (op == ETNA_PREP_READ)
 		return DMA_FROM_DEVICE;
-	else if (op & ETNA_PREP_WRITE)
+	else if (op == ETNA_PREP_WRITE)
 		return DMA_TO_DEVICE;
 	else
 		return DMA_BIDIRECTIONAL;
diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index 9c8446184b17..4f96cd10971f 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -404,6 +404,9 @@ static int cdv_intel_lvds_get_modes(struct drm_connector *connector)
 	if (mode_dev->panel_fixed_mode != NULL) {
 		struct drm_display_mode *mode =
 		    drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
+		if (!mode)
+			return 0;
+
 		drm_mode_probed_add(connector, mode);
 		return 1;
 	}
diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index 8baf6325c6e4..5e5b05cde0f4 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -519,6 +519,9 @@ static int psb_intel_lvds_get_modes(struct drm_connector *connector)
 	if (mode_dev->panel_fixed_mode != NULL) {
 		struct drm_display_mode *mode =
 		    drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
+		if (!mode)
+			return 0;
+
 		drm_mode_probed_add(connector, mode);
 		return 1;
 	}
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 5b0d6d8b3ab8..478d989a2369 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -2009,6 +2009,39 @@ compute_partial_view(struct drm_i915_gem_object *obj,
 	return view;
 }
 
+static void set_address_limits(struct vm_area_struct *area,
+                              struct i915_vma *vma,
+                              unsigned long *start_vaddr,
+                              unsigned long *end_vaddr)
+{
+	unsigned long vm_start, vm_end, vma_size; /* user's memory parameters */
+	long start, end; /* memory boundaries */
+
+	/*
+	 * Let's move into the ">> PAGE_SHIFT"
+	 * domain to be sure not to lose bits
+	 */
+	vm_start = area->vm_start >> PAGE_SHIFT;
+	vm_end = area->vm_end >> PAGE_SHIFT;
+	vma_size = vma->size >> PAGE_SHIFT;
+
+	/*
+	 * Calculate the memory boundaries by considering the offset
+	 * provided by the user during memory mapping and the offset
+	 * provided for the partial mapping.
+	 */
+	start = vm_start;
+	start += vma->ggtt_view.partial.offset;
+	end = start + vma_size;
+
+	start = max_t(long, start, vm_start);
+	end = min_t(long, end, vm_end);
+
+	/* Let's move back into the "<< PAGE_SHIFT" domain */
+	*start_vaddr = (unsigned long)start << PAGE_SHIFT;
+	*end_vaddr = (unsigned long)end << PAGE_SHIFT;
+}
+
 /**
  * i915_gem_fault - fault a page into the GTT
  * @vmf: fault info
@@ -2036,8 +2069,10 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct i915_ggtt *ggtt = &dev_priv->ggtt;
 	bool write = !!(vmf->flags & FAULT_FLAG_WRITE);
+	unsigned long start, end; /* memory boundaries */
 	struct i915_vma *vma;
 	pgoff_t page_offset;
+	unsigned long pfn;
 	int ret;
 
 	/* Sanity check that we allow writing into this object */
@@ -2119,12 +2154,14 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
 	if (ret)
 		goto err_unpin;
 
+	set_address_limits(area, vma, &start, &end);
+
+	pfn = (ggtt->gmadr.start + i915_ggtt_offset(vma)) >> PAGE_SHIFT;
+	pfn += (start - area->vm_start) >> PAGE_SHIFT;
+	pfn -= vma->ggtt_view.partial.offset;
+
 	/* Finally, remap it using the new GTT offset */
-	ret = remap_io_mapping(area,
-			       area->vm_start + (vma->ggtt_view.partial.offset << PAGE_SHIFT),
-			       (ggtt->gmadr.start + vma->node.start) >> PAGE_SHIFT,
-			       min_t(u64, vma->size, area->vm_end - area->vm_start),
-			       &ggtt->iomap);
+	ret = remap_io_mapping(area, start, pfn, end - start, &ggtt->iomap);
 	if (ret)
 		goto err_fence;
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_i2c.c b/drivers/gpu/drm/mgag200/mgag200_i2c.c
index 77d1c4771786..0919021168e1 100644
--- a/drivers/gpu/drm/mgag200/mgag200_i2c.c
+++ b/drivers/gpu/drm/mgag200/mgag200_i2c.c
@@ -133,7 +133,7 @@ struct mga_i2c_chan *mgag200_i2c_create(struct drm_device *dev)
 	i2c->adapter.algo_data = &i2c->bit;
 
 	i2c->bit.udelay = 10;
-	i2c->bit.timeout = 2;
+	i2c->bit.timeout = usecs_to_jiffies(2200);
 	i2c->bit.data = i2c;
 	i2c->bit.setsda		= mga_gpio_setsda;
 	i2c->bit.setscl		= mga_gpio_setscl;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index 9f1b9d289bec..5318c949e891 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -100,7 +100,7 @@ static int vmw_overlay_send_put(struct vmw_private *dev_priv,
 {
 	struct vmw_escape_video_flush *flush;
 	size_t fifo_size;
-	bool have_so = (dev_priv->active_display_unit == vmw_du_screen_object);
+	bool have_so = (dev_priv->active_display_unit != vmw_du_legacy);
 	int i, num_items;
 	SVGAGuestPtr ptr;
 
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 2db2665dcd4d..6406520f3915 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1785,7 +1785,7 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
 		data->pwm[CONTROL][index] &= ~0xE0;
 		data->pwm[CONTROL][index] |= (7 << 5);
 
-		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
+		i2c_smbus_write_byte_data(client, PWM_REG(index),
 					  data->pwm[INPUT][index]);
 
 		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 6df28fe0577d..14c34a2d36af 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -251,7 +251,7 @@ static struct max6697_data *max6697_update_device(struct device *dev)
 	return ret;
 }
 
-static ssize_t show_temp_input(struct device *dev,
+static ssize_t temp_input_show(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
@@ -267,8 +267,8 @@ static ssize_t show_temp_input(struct device *dev,
 	return sprintf(buf, "%d\n", temp * 125);
 }
 
-static ssize_t show_temp(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int index = to_sensor_dev_attr_2(devattr)->index;
@@ -284,7 +284,7 @@ static ssize_t show_temp(struct device *dev,
 	return sprintf(buf, "%d\n", temp * 1000);
 }
 
-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int index = to_sensor_dev_attr(attr)->index;
@@ -299,9 +299,9 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", (data->alarms >> index) & 0x1);
 }
 
-static ssize_t set_temp(struct device *dev,
-			struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int index = to_sensor_dev_attr_2(devattr)->index;
@@ -314,6 +314,7 @@ static ssize_t set_temp(struct device *dev,
 		return ret;
 
 	mutex_lock(&data->update_lock);
+	temp = clamp_val(temp, -1000000, 1000000);	/* prevent underflow */
 	temp = DIV_ROUND_CLOSEST(temp, 1000) + data->temp_offset;
 	temp = clamp_val(temp, 0, data->type == max6581 ? 255 : 127);
 	data->temp[nr][index] = temp;
@@ -326,79 +327,63 @@ static ssize_t set_temp(struct device *dev,
 	return ret < 0 ? ret : count;
 }
 
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input, NULL, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input, NULL, 3);
-static SENSOR_DEVICE_ATTR_2(temp4_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    3, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp4_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    3, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp_input, NULL, 4);
-static SENSOR_DEVICE_ATTR_2(temp5_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    4, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp5_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    4, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp_input, NULL, 5);
-static SENSOR_DEVICE_ATTR_2(temp6_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    5, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp6_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    5, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp_input, NULL, 6);
-static SENSOR_DEVICE_ATTR_2(temp7_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    6, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp7_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    6, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp_input, NULL, 7);
-static SENSOR_DEVICE_ATTR_2(temp8_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    7, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp8_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    7, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 22);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL, 18);
-static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_alarm, NULL, 19);
-static SENSOR_DEVICE_ATTR(temp6_max_alarm, S_IRUGO, show_alarm, NULL, 20);
-static SENSOR_DEVICE_ATTR(temp7_max_alarm, S_IRUGO, show_alarm, NULL, 21);
-static SENSOR_DEVICE_ATTR(temp8_max_alarm, S_IRUGO, show_alarm, NULL, 23);
-
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 14);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp4_crit_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(temp5_crit_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp6_crit_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp7_crit_alarm, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(temp8_crit_alarm, S_IRUGO, show_alarm, NULL, 15);
-
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_fault, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_fault, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_fault, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, 1, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_crit, temp, 1, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp_input, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, 2, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_crit, temp, 2, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp_input, 3);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_max, temp, 3, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_crit, temp, 3, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp5_input, temp_input, 4);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_max, temp, 4, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_crit, temp, 4, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp6_input, temp_input, 5);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_max, temp, 5, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_crit, temp, 5, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp7_input, temp_input, 6);
+static SENSOR_DEVICE_ATTR_2_RW(temp7_max, temp, 6, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp7_crit, temp, 6, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp8_input, temp_input, 7);
+static SENSOR_DEVICE_ATTR_2_RW(temp8_max, temp, 7, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp8_crit, temp, 7, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 22);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, alarm, 18);
+static SENSOR_DEVICE_ATTR_RO(temp5_max_alarm, alarm, 19);
+static SENSOR_DEVICE_ATTR_RO(temp6_max_alarm, alarm, 20);
+static SENSOR_DEVICE_ATTR_RO(temp7_max_alarm, alarm, 21);
+static SENSOR_DEVICE_ATTR_RO(temp8_max_alarm, alarm, 23);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 15);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(temp4_crit_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(temp5_crit_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp6_crit_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(temp7_crit_alarm, alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(temp8_crit_alarm, alarm, 14);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_fault, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_fault, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_fault, alarm, 7);
 
 static DEVICE_ATTR(dummy, 0, NULL, NULL);
 
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 5a1dd7f13bac..0e9c2943194c 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -42,6 +42,7 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	struct i2c_client *client = i2c_verify_client(dev);
 	struct alert_data *data = addrp;
 	struct i2c_driver *driver;
+	int ret;
 
 	if (!client || client->addr != data->addr)
 		return 0;
@@ -55,16 +56,47 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	device_lock(dev);
 	if (client->dev.driver) {
 		driver = to_i2c_driver(client->dev.driver);
-		if (driver->alert)
+		if (driver->alert) {
+			/* Stop iterating after we find the device */
 			driver->alert(client, data->type, data->data);
-		else
+			ret = -EBUSY;
+		} else {
 			dev_warn(&client->dev, "no driver alert()!\n");
-	} else
+			ret = -EOPNOTSUPP;
+		}
+	} else {
 		dev_dbg(&client->dev, "alert with no driver\n");
+		ret = -ENODEV;
+	}
+	device_unlock(dev);
+
+	return ret;
+}
+
+/* Same as above, but call back all drivers with alert handler */
+
+static int smbus_do_alert_force(struct device *dev, void *addrp)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	struct alert_data *data = addrp;
+	struct i2c_driver *driver;
+
+	if (!client || (client->flags & I2C_CLIENT_TEN))
+		return 0;
+
+	/*
+	 * Drivers should either disable alerts, or provide at least
+	 * a minimal handler. Lock so the driver won't change.
+	 */
+	device_lock(dev);
+	if (client->dev.driver) {
+		driver = to_i2c_driver(client->dev.driver);
+		if (driver->alert)
+			driver->alert(client, data->type, data->data);
+	}
 	device_unlock(dev);
 
-	/* Stop iterating after we find the device */
-	return -EBUSY;
+	return 0;
 }
 
 /*
@@ -75,7 +107,7 @@ static irqreturn_t smbus_alert(int irq, void *d)
 {
 	struct i2c_smbus_alert *alert = d;
 	struct i2c_client *ara;
-	unsigned short prev_addr = 0;	/* Not a valid address */
+	unsigned short prev_addr = I2C_CLIENT_END; /* Not a valid address */
 
 	ara = alert->ara;
 
@@ -99,17 +131,28 @@ static irqreturn_t smbus_alert(int irq, void *d)
 		data.addr = status >> 1;
 		data.type = I2C_PROTOCOL_SMBUS_ALERT;
 
-		if (data.addr == prev_addr) {
-			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
-				"0x%02x, skipping\n", data.addr);
-			break;
-		}
 		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
 			data.addr, data.data);
 
 		/* Notify driver for the device which issued the alert */
-		device_for_each_child(&ara->adapter->dev, &data,
-				      smbus_do_alert);
+		status = device_for_each_child(&ara->adapter->dev, &data,
+					       smbus_do_alert);
+		/*
+		 * If we read the same address more than once, and the alert
+		 * was not handled by a driver, it won't do any good to repeat
+		 * the loop because it will never terminate. Try again, this
+		 * time calling the alert handlers of all devices connected to
+		 * the bus, and abort the loop afterwards. If this helps, we
+		 * are all set. If it doesn't, there is nothing else we can do,
+		 * so we might as well abort the loop.
+		 * Note: This assumes that a driver with alert handler handles
+		 * the alert properly and clears it if necessary.
+		 */
+		if (data.addr == prev_addr && status != -EBUSY) {
+			device_for_each_child(&ara->adapter->dev, &data,
+					      smbus_do_alert_force);
+			break;
+		}
 		prev_addr = data.addr;
 	}
 
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 57aec656ab7f..84fa7b727a2b 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -369,8 +369,10 @@ EXPORT_SYMBOL(iw_cm_disconnect);
  *
  * Clean up all resources associated with the connection and release
  * the initial reference taken by iw_create_cm_id.
+ *
+ * Returns true if and only if the last cm_id_priv reference has been dropped.
  */
-static void destroy_cm_id(struct iw_cm_id *cm_id)
+static bool destroy_cm_id(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	unsigned long flags;
@@ -438,7 +440,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
 	}
 
-	(void)iwcm_deref_id(cm_id_priv);
+	return iwcm_deref_id(cm_id_priv);
 }
 
 /*
@@ -449,7 +451,8 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
  */
 void iw_destroy_cm_id(struct iw_cm_id *cm_id)
 {
-	destroy_cm_id(cm_id);
+	if (!destroy_cm_id(cm_id))
+		flush_workqueue(iwcm_wq);
 }
 EXPORT_SYMBOL(iw_destroy_cm_id);
 
@@ -1022,7 +1025,7 @@ static void cm_work_handler(struct work_struct *_work)
 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
 			ret = process_event(cm_id_priv, &levent);
 			if (ret)
-				destroy_cm_id(&cm_id_priv->id);
+				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
 		} else
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e365fa8251c1..e2c93a50fe76 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2112,7 +2112,7 @@ static int bnxt_re_build_send_wqe(struct bnxt_re_qp *qp,
 		break;
 	case IB_WR_SEND_WITH_IMM:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_IMM;
-		wqe->send.imm_data = wr->ex.imm_data;
+		wqe->send.imm_data = be32_to_cpu(wr->ex.imm_data);
 		break;
 	case IB_WR_SEND_WITH_INV:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV;
@@ -2142,7 +2142,7 @@ static int bnxt_re_build_rdma_wqe(const struct ib_send_wr *wr,
 		break;
 	case IB_WR_RDMA_WRITE_WITH_IMM:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_RDMA_WRITE_WITH_IMM;
-		wqe->rdma.imm_data = wr->ex.imm_data;
+		wqe->rdma.imm_data = be32_to_cpu(wr->ex.imm_data);
 		break;
 	case IB_WR_RDMA_READ:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_RDMA_READ;
@@ -3110,7 +3110,7 @@ static void bnxt_re_process_res_shadow_qp_wc(struct bnxt_re_qp *qp,
 	wc->byte_len = orig_cqe->length;
 	wc->qp = &qp1_qp->ib_qp;
 
-	wc->ex.imm_data = orig_cqe->immdata;
+	wc->ex.imm_data = cpu_to_be32(le32_to_cpu(orig_cqe->immdata));
 	wc->src_qp = orig_cqe->src_qp;
 	memcpy(wc->smac, orig_cqe->smac, ETH_ALEN);
 	if (bnxt_re_is_vlan_pkt(orig_cqe, &vlan_id, &sl)) {
@@ -3231,7 +3231,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				continue;
 			}
 			wc->qp = &qp->ib_qp;
-			wc->ex.imm_data = cqe->immdata;
+			wc->ex.imm_data = cpu_to_be32(le32_to_cpu(cqe->immdata));
 			wc->src_qp = cqe->src_qp;
 			memcpy(wc->smac, cqe->smac, ETH_ALEN);
 			wc->port_num = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 72352ca80ace..d0b24e961511 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -145,7 +145,7 @@ struct bnxt_qplib_swqe {
 		/* Send, with imm, inval key */
 		struct {
 			union {
-				__be32	imm_data;
+				u32	imm_data;
 				u32	inv_key;
 			};
 			u32		q_key;
@@ -163,7 +163,7 @@ struct bnxt_qplib_swqe {
 		/* RDMA write, with imm, read */
 		struct {
 			union {
-				__be32	imm_data;
+				u32	imm_data;
 				u32	inv_key;
 			};
 			u64		remote_va;
@@ -349,7 +349,7 @@ struct bnxt_qplib_cqe {
 	u32				length;
 	u64				wr_id;
 	union {
-		__be32			immdata;
+		__le32			immdata;
 		u32			invrkey;
 	};
 	u64				qp_handle;
diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index baab9afa9174..f2d975c2659d 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -832,7 +832,7 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 
 int mlx4_ib_init_alias_guid_service(struct mlx4_ib_dev *dev)
 {
-	char alias_wq_name[15];
+	char alias_wq_name[22];
 	int ret = 0;
 	int i, j;
 	union ib_gid gid;
diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index 418b9312fb2d..a034cb3fa7ca 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -2158,7 +2158,7 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 				       struct mlx4_ib_demux_ctx *ctx,
 				       int port)
 {
-	char name[12];
+	char name[21];
 	int ret = 0;
 	int i;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 4008ab2da052..aa57a9cb5388 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -390,7 +390,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	int			solicited;
 	u16			pkey;
 	u32			qp_num;
-	int			ack_req;
+	int			ack_req = 0;
 
 	/* length from start of bth to end of icrc */
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
@@ -426,8 +426,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
 					 qp->attr.dest_qp_num;
 
-	ack_req = ((pkt->mask & RXE_END_MASK) ||
-		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
+	if (qp_type(qp) != IB_QPT_UD && qp_type(qp) != IB_QPT_UC)
+		ack_req = ((pkt->mask & RXE_END_MASK) ||
+			   (qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
 	if (ack_req)
 		qp->req.noack_pkts = 0;
 
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index cb0314acdfbd..c02be5bf4baf 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1270,6 +1270,8 @@ static int __maybe_unused elan_suspend(struct device *dev)
 	}
 
 err:
+	if (ret)
+		enable_irq(client->irq);
 	mutex_unlock(&data->sysfs_mutex);
 	return ret;
 }
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index c98358be0bc8..19cf1239c7d3 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -75,6 +75,20 @@ struct mbigen_device {
 	void __iomem		*base;
 };
 
+static inline unsigned int get_mbigen_node_offset(unsigned int nid)
+{
+	unsigned int offset = nid * MBIGEN_NODE_OFFSET;
+
+	/*
+	 * To avoid touched clear register in unexpected way, we need to directly
+	 * skip clear register when access to more than 10 mbigen nodes.
+	 */
+	if (nid >= (REG_MBIGEN_CLEAR_OFFSET / MBIGEN_NODE_OFFSET))
+		offset += MBIGEN_NODE_OFFSET;
+
+	return offset;
+}
+
 static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
@@ -83,8 +97,7 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin = hwirq % IRQS_PER_MBIGEN_NODE;
 
-	return pin * 4 + nid * MBIGEN_NODE_OFFSET
-			+ REG_MBIGEN_VEC_OFFSET;
+	return pin * 4 + get_mbigen_node_offset(nid) + REG_MBIGEN_VEC_OFFSET;
 }
 
 static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
@@ -99,8 +112,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 	*mask = 1 << (irq_ofst % 32);
 	ofst = irq_ofst / 32 * 4;
 
-	*addr = ofst + nid * MBIGEN_NODE_OFFSET
-		+ REG_MBIGEN_TYPE_OFFSET;
+	*addr = ofst + get_mbigen_node_offset(nid) + REG_MBIGEN_TYPE_OFFSET;
 }
 
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index 60b3a4aabe6b..9010d5ca3cd5 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -1945,7 +1945,7 @@ hfcmulti_dtmf(struct hfc_multi *hc)
 static void
 hfcmulti_tx(struct hfc_multi *hc, int ch)
 {
-	int i, ii, temp, len = 0;
+	int i, ii, temp, tmp_len, len = 0;
 	int Zspace, z1, z2; /* must be int for calculation */
 	int Fspace, f1, f2;
 	u_char *d;
@@ -2166,14 +2166,15 @@ hfcmulti_tx(struct hfc_multi *hc, int ch)
 		HFC_wait_nodebug(hc);
 	}
 
+	tmp_len = (*sp)->len;
 	dev_kfree_skb(*sp);
 	/* check for next frame */
 	if (bch && get_next_bframe(bch)) {
-		len = (*sp)->len;
+		len = tmp_len;
 		goto next_frame;
 	}
 	if (dch && get_next_dframe(dch)) {
-		len = (*sp)->len;
+		len = tmp_len;
 		goto next_frame;
 	}
 
diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index ec4c957c36b6..8738fc01523f 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -125,9 +125,9 @@ int led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trig)
 			flags);
 		cancel_work_sync(&led_cdev->set_brightness_work);
 		led_stop_software_blink(led_cdev);
+		device_remove_groups(led_cdev->dev, led_cdev->trigger->groups);
 		if (led_cdev->trigger->deactivate)
 			led_cdev->trigger->deactivate(led_cdev);
-		device_remove_groups(led_cdev->dev, led_cdev->trigger->groups);
 		led_cdev->trigger = NULL;
 		led_cdev->trigger_data = NULL;
 		led_cdev->activated = false;
diff --git a/drivers/leds/leds-ss4200.c b/drivers/leds/leds-ss4200.c
index a9db8674cd02..0e19fceb3769 100644
--- a/drivers/leds/leds-ss4200.c
+++ b/drivers/leds/leds-ss4200.c
@@ -368,8 +368,10 @@ static int ich7_lpc_probe(struct pci_dev *dev,
 
 	nas_gpio_pci_dev = dev;
 	status = pci_read_config_dword(dev, PMBASE, &g_pm_io_base);
-	if (status)
+	if (status) {
+		status = pcibios_err_to_errno(status);
 		goto out;
+	}
 	g_pm_io_base &= 0x00000ff80;
 
 	status = pci_read_config_dword(dev, GPIO_CTRL, &gc);
@@ -381,8 +383,9 @@ static int ich7_lpc_probe(struct pci_dev *dev,
 	}
 
 	status = pci_read_config_dword(dev, GPIO_BASE, &nas_gpio_io_base);
-	if (0 > status) {
+	if (status) {
 		dev_info(&dev->dev, "Unable to read GPIOBASE.\n");
+		status = pcibios_err_to_errno(status);
 		goto out;
 	}
 	dev_dbg(&dev->dev, ": GPIOBASE = 0x%08x\n", nas_gpio_io_base);
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index a0d87ed9da69..63e99762a165 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -549,7 +549,7 @@ g4fan_exit( void )
 	platform_driver_unregister( &therm_of_driver );
 
 	if( x.of_dev )
-		of_device_unregister( x.of_dev );
+		of_platform_device_destroy(&x.of_dev->dev, NULL);
 }
 
 module_init(g4fan_init);
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4e125c84be49..0adcc67c1a12 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5818,7 +5818,9 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	safepos = conf->reshape_safe;
 	sector_div(safepos, data_disks);
 	if (mddev->reshape_backwards) {
-		BUG_ON(writepos < reshape_sectors);
+		if (WARN_ON(writepos < reshape_sectors))
+			return MaxSector;
+
 		writepos -= reshape_sectors;
 		readpos += reshape_sectors;
 		safepos += reshape_sectors;
@@ -5836,14 +5838,18 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	 * to set 'stripe_addr' which is where we will write to.
 	 */
 	if (mddev->reshape_backwards) {
-		BUG_ON(conf->reshape_progress == 0);
+		if (WARN_ON(conf->reshape_progress == 0))
+			return MaxSector;
+
 		stripe_addr = writepos;
-		BUG_ON((mddev->dev_sectors &
-			~((sector_t)reshape_sectors - 1))
-		       - reshape_sectors - stripe_addr
-		       != sector_nr);
+		if (WARN_ON((mddev->dev_sectors &
+		    ~((sector_t)reshape_sectors - 1)) -
+		    reshape_sectors - stripe_addr != sector_nr))
+			return MaxSector;
 	} else {
-		BUG_ON(writepos != sector_nr + reshape_sectors);
+		if (WARN_ON(writepos != sector_nr + reshape_sectors))
+			return MaxSector;
+
 		stripe_addr = sector_nr;
 	}
 
diff --git a/drivers/media/pci/saa7134/saa7134-dvb.c b/drivers/media/pci/saa7134/saa7134-dvb.c
index 3025d38ddb2b..d710c00b4dc9 100644
--- a/drivers/media/pci/saa7134/saa7134-dvb.c
+++ b/drivers/media/pci/saa7134/saa7134-dvb.c
@@ -475,7 +475,9 @@ static int philips_europa_tuner_sleep(struct dvb_frontend *fe)
 	/* switch the board to analog mode */
 	if (fe->ops.i2c_gate_ctrl)
 		fe->ops.i2c_gate_ctrl(fe, 1);
-	i2c_transfer(&dev->i2c_adap, &analog_msg, 1);
+	if (i2c_transfer(&dev->i2c_adap, &analog_msg, 1) != 1)
+		return -EIO;
+
 	return 0;
 }
 
@@ -1027,7 +1029,9 @@ static int md8800_set_voltage2(struct dvb_frontend *fe,
 	else
 		wbuf[1] = rbuf & 0xef;
 	msg[0].len = 2;
-	i2c_transfer(&dev->i2c_adap, msg, 1);
+	if (i2c_transfer(&dev->i2c_adap, msg, 1) != 1)
+		return -EIO;
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 177a1bf2b8e0..b156146676a3 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1096,6 +1096,7 @@ static int vdec_close(struct file *file)
 {
 	struct venus_inst *inst = to_inst(file);
 
+	cancel_work_sync(&inst->delayed_process_work);
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
 	vdec_ctrl_deinit(inst);
diff --git a/drivers/media/platform/vsp1/vsp1_histo.c b/drivers/media/platform/vsp1/vsp1_histo.c
index 5e15c8ff88d9..d1942163e650 100644
--- a/drivers/media/platform/vsp1/vsp1_histo.c
+++ b/drivers/media/platform/vsp1/vsp1_histo.c
@@ -36,9 +36,8 @@ struct vsp1_histogram_buffer *
 vsp1_histogram_buffer_get(struct vsp1_histogram *histo)
 {
 	struct vsp1_histogram_buffer *buf = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&histo->irqlock, flags);
+	spin_lock(&histo->irqlock);
 
 	if (list_empty(&histo->irqqueue))
 		goto done;
@@ -49,7 +48,7 @@ vsp1_histogram_buffer_get(struct vsp1_histogram *histo)
 	histo->readout = true;
 
 done:
-	spin_unlock_irqrestore(&histo->irqlock, flags);
+	spin_unlock(&histo->irqlock);
 	return buf;
 }
 
@@ -58,7 +57,6 @@ void vsp1_histogram_buffer_complete(struct vsp1_histogram *histo,
 				    size_t size)
 {
 	struct vsp1_pipeline *pipe = histo->entity.pipe;
-	unsigned long flags;
 
 	/*
 	 * The pipeline pointer is guaranteed to be valid as this function is
@@ -70,10 +68,10 @@ void vsp1_histogram_buffer_complete(struct vsp1_histogram *histo,
 	vb2_set_plane_payload(&buf->buf.vb2_buf, 0, size);
 	vb2_buffer_done(&buf->buf.vb2_buf, VB2_BUF_STATE_DONE);
 
-	spin_lock_irqsave(&histo->irqlock, flags);
+	spin_lock(&histo->irqlock);
 	histo->readout = false;
 	wake_up(&histo->wait_queue);
-	spin_unlock_irqrestore(&histo->irqlock, flags);
+	spin_unlock(&histo->irqlock);
 }
 
 /* -----------------------------------------------------------------------------
@@ -124,11 +122,10 @@ static void histo_buffer_queue(struct vb2_buffer *vb)
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct vsp1_histogram *histo = vb2_get_drv_priv(vb->vb2_queue);
 	struct vsp1_histogram_buffer *buf = to_vsp1_histogram_buffer(vbuf);
-	unsigned long flags;
 
-	spin_lock_irqsave(&histo->irqlock, flags);
+	spin_lock_irq(&histo->irqlock);
 	list_add_tail(&buf->queue, &histo->irqqueue);
-	spin_unlock_irqrestore(&histo->irqlock, flags);
+	spin_unlock_irq(&histo->irqlock);
 }
 
 static int histo_start_streaming(struct vb2_queue *vq, unsigned int count)
@@ -140,9 +137,8 @@ static void histo_stop_streaming(struct vb2_queue *vq)
 {
 	struct vsp1_histogram *histo = vb2_get_drv_priv(vq);
 	struct vsp1_histogram_buffer *buffer;
-	unsigned long flags;
 
-	spin_lock_irqsave(&histo->irqlock, flags);
+	spin_lock_irq(&histo->irqlock);
 
 	/* Remove all buffers from the IRQ queue. */
 	list_for_each_entry(buffer, &histo->irqqueue, queue)
@@ -152,7 +148,7 @@ static void histo_stop_streaming(struct vb2_queue *vq)
 	/* Wait for the buffer being read out (if any) to complete. */
 	wait_event_lock_irq(histo->wait_queue, !histo->readout, histo->irqlock);
 
-	spin_unlock_irqrestore(&histo->irqlock, flags);
+	spin_unlock_irq(&histo->irqlock);
 }
 
 static const struct vb2_ops histo_video_queue_qops = {
diff --git a/drivers/media/platform/vsp1/vsp1_pipe.h b/drivers/media/platform/vsp1/vsp1_pipe.h
index ae646c9ef337..15daf35bda21 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.h
+++ b/drivers/media/platform/vsp1/vsp1_pipe.h
@@ -73,7 +73,7 @@ struct vsp1_partition_window {
  * @wpf: The WPF partition window configuration
  */
 struct vsp1_partition {
-	struct vsp1_partition_window rpf;
+	struct vsp1_partition_window rpf[VSP1_MAX_RPF];
 	struct vsp1_partition_window uds_sink;
 	struct vsp1_partition_window uds_source;
 	struct vsp1_partition_window sru;
diff --git a/drivers/media/platform/vsp1/vsp1_rpf.c b/drivers/media/platform/vsp1/vsp1_rpf.c
index abaf4dde3802..a61b86861c64 100644
--- a/drivers/media/platform/vsp1/vsp1_rpf.c
+++ b/drivers/media/platform/vsp1/vsp1_rpf.c
@@ -270,8 +270,8 @@ static void rpf_configure_partition(struct vsp1_entity *entity,
 	 * 'width' need to be adjusted.
 	 */
 	if (pipe->partitions > 1) {
-		crop.width = pipe->partition->rpf.width;
-		crop.left += pipe->partition->rpf.left;
+		crop.width = pipe->partition->rpf[rpf->entity.index].width;
+		crop.left += pipe->partition->rpf[rpf->entity.index].left;
 	}
 
 	if (pipe->interlaced) {
@@ -326,7 +326,9 @@ static void rpf_partition(struct vsp1_entity *entity,
 			  unsigned int partition_idx,
 			  struct vsp1_partition_window *window)
 {
-	partition->rpf = *window;
+	struct vsp1_rwpf *rpf = to_rwpf(&entity->subdev);
+
+	partition->rpf[rpf->entity.index] = *window;
 }
 
 static const struct vsp1_entity_operations rpf_entity_ops = {
diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 99bb7380ee0e..c78e1a4a10ec 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1126,10 +1126,7 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 
 	memcpy(ictx->usb_tx_buf, &ir_proto_packet, sizeof(ir_proto_packet));
 
-	if (!mutex_is_locked(&ictx->lock)) {
-		unlock = true;
-		mutex_lock(&ictx->lock);
-	}
+	unlock = mutex_trylock(&ictx->lock);
 
 	retval = send_packet(ictx);
 	if (retval)
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 84b1339c2c6e..72d0d8c36336 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -997,26 +997,56 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 	return value;
 }
 
-static int __uvc_ctrl_get(struct uvc_video_chain *chain,
-	struct uvc_control *ctrl, struct uvc_control_mapping *mapping,
-	s32 *value)
+static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
+			       struct uvc_control *ctrl)
 {
+	u8 *data;
 	int ret;
 
-	if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) == 0)
-		return -EACCES;
+	if (ctrl->loaded)
+		return 0;
 
-	if (!ctrl->loaded) {
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
-				chain->dev->intfnum, ctrl->info.selector,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
-				ctrl->info.size);
-		if (ret < 0)
-			return ret;
+	data = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT);
 
+	if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) == 0) {
+		memset(data, 0, ctrl->info.size);
 		ctrl->loaded = 1;
+
+		return 0;
 	}
 
+	if (ctrl->entity->get_cur)
+		ret = ctrl->entity->get_cur(chain->dev, ctrl->entity,
+					    ctrl->info.selector, data,
+					    ctrl->info.size);
+	else
+		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR,
+				     ctrl->entity->id, chain->dev->intfnum,
+				     ctrl->info.selector, data,
+				     ctrl->info.size);
+
+	if (ret < 0)
+		return ret;
+
+	ctrl->loaded = 1;
+
+	return ret;
+}
+
+static int __uvc_ctrl_get(struct uvc_video_chain *chain,
+			  struct uvc_control *ctrl,
+			  struct uvc_control_mapping *mapping,
+			  s32 *value)
+{
+	int ret;
+
+	if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) == 0)
+		return -EACCES;
+
+	ret = __uvc_ctrl_load_cur(chain, ctrl);
+	if (ret < 0)
+		return ret;
+
 	*value = __uvc_ctrl_get_value(mapping,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
@@ -1670,21 +1700,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	 * needs to be loaded from the device to perform the read-modify-write
 	 * operation.
 	 */
-	if (!ctrl->loaded && (ctrl->info.size * 8) != mapping->size) {
-		if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) == 0) {
-			memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
-				0, ctrl->info.size);
-		} else {
-			ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR,
-				ctrl->entity->id, chain->dev->intfnum,
-				ctrl->info.selector,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
-				ctrl->info.size);
-			if (ret < 0)
-				return ret;
-		}
-
-		ctrl->loaded = 1;
+	if ((ctrl->info.size * 8) != mapping->size) {
+		ret = __uvc_ctrl_load_cur(chain, ctrl);
+		if (ret < 0)
+			return ret;
 	}
 
 	/* Backup the current value in case we need to rollback later. */
@@ -1723,9 +1742,19 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 	if (data == NULL)
 		return -ENOMEM;
 
-	ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id, dev->intfnum,
-			     info->selector, data, 1);
-	if (!ret)
+	if (ctrl->entity->get_info)
+		ret = ctrl->entity->get_info(dev, ctrl->entity,
+					     ctrl->info.selector, data);
+	else
+		ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id,
+				     dev->intfnum, info->selector, data, 1);
+
+	if (!ret) {
+		info->flags &= ~(UVC_CTRL_FLAG_GET_CUR |
+				 UVC_CTRL_FLAG_SET_CUR |
+				 UVC_CTRL_FLAG_AUTO_UPDATE |
+				 UVC_CTRL_FLAG_ASYNCHRONOUS);
+
 		info->flags |= (data[0] & UVC_CONTROL_CAP_GET ?
 				UVC_CTRL_FLAG_GET_CUR : 0)
 			    |  (data[0] & UVC_CONTROL_CAP_SET ?
@@ -1734,6 +1763,7 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 				UVC_CTRL_FLAG_AUTO_UPDATE : 0)
 			    |  (data[0] & UVC_CONTROL_CAP_ASYNCHRONOUS ?
 				UVC_CTRL_FLAG_ASYNCHRONOUS : 0);
+	}
 
 	kfree(data);
 	return ret;
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index c57bc62251bb..3f0796141545 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -212,13 +212,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 		/* Compute a bandwidth estimation by multiplying the frame
 		 * size by the number of video frames per second, divide the
 		 * result by the number of USB frames (or micro-frames for
-		 * high-speed devices) per second and add the UVC header size
-		 * (assumed to be 12 bytes long).
+		 * high- and super-speed devices) per second and add the UVC
+		 * header size (assumed to be 12 bytes long).
 		 */
 		bandwidth = frame->wWidth * frame->wHeight / 8 * format->bpp;
 		bandwidth *= 10000000 / interval + 1;
 		bandwidth /= 1000;
-		if (stream->dev->udev->speed == USB_SPEED_HIGH)
+		if (stream->dev->udev->speed >= USB_SPEED_HIGH)
 			bandwidth /= 8;
 		bandwidth += 12;
 
@@ -473,6 +473,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	ktime_t time;
 	u16 host_sof;
 	u16 dev_sof;
+	u32 dev_stc;
 
 	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
 	case UVC_STREAM_PTS | UVC_STREAM_SCR:
@@ -517,6 +518,34 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	if (dev_sof == stream->clock.last_sof)
 		return;
 
+	dev_stc = get_unaligned_le32(&data[header_size - 6]);
+
+	/*
+	 * STC (Source Time Clock) is the clock used by the camera. The UVC 1.5
+	 * standard states that it "must be captured when the first video data
+	 * of a video frame is put on the USB bus". This is generally understood
+	 * as requiring devices to clear the payload header's SCR bit before
+	 * the first packet containing video data.
+	 *
+	 * Most vendors follow that interpretation, but some (namely SunplusIT
+	 * on some devices) always set the `UVC_STREAM_SCR` bit, fill the SCR
+	 * field with 0's,and expect that the driver only processes the SCR if
+	 * there is data in the packet.
+	 *
+	 * Ignore all the hardware timestamp information if we haven't received
+	 * any data for this frame yet, the packet contains no data, and both
+	 * STC and SOF are zero. This heuristics should be safe on compliant
+	 * devices. This should be safe with compliant devices, as in the very
+	 * unlikely case where a UVC 1.1 device would send timing information
+	 * only before the first packet containing data, and both STC and SOF
+	 * happen to be zero for a particular frame, we would only miss one
+	 * clock sample from many and the clock recovery algorithm wouldn't
+	 * suffer from this condition.
+	 */
+	if (buf && buf->bytesused == 0 && len == header_size &&
+	    dev_stc == 0 && dev_sof == 0)
+		return;
+
 	stream->clock.last_sof = dev_sof;
 
 	host_sof = usb_get_current_frame_number(stream->dev->udev);
@@ -554,7 +583,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	spin_lock_irqsave(&stream->clock.lock, flags);
 
 	sample = &stream->clock.samples[stream->clock.head];
-	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
+	sample->dev_stc = dev_stc;
 	sample->dev_sof = dev_sof;
 	sample->host_sof = host_sof;
 	sample->host_time = time;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index e8b06164b27a..4df3b014dd40 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -345,6 +345,11 @@ struct uvc_entity {
 	u8 bNrInPins;
 	u8 *baSourceID;
 
+	int (*get_info)(struct uvc_device *dev, struct uvc_entity *entity,
+			u8 cs, u8 *caps);
+	int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
+		       u8 cs, void *data, u16 size);
+
 	unsigned int ncontrols;
 	struct uvc_control *controls;
 };
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 446713dbee27..269eeccb963b 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -246,8 +246,7 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 		break;
 	}
 
-	tll = devm_kzalloc(dev, sizeof(*tll) + sizeof(tll->ch_clk[nch]),
-			   GFP_KERNEL);
+	tll = devm_kzalloc(dev, struct_size(tll, ch_clk, nch), GFP_KERNEL);
 	if (!tll) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);
diff --git a/drivers/mtd/tests/Makefile b/drivers/mtd/tests/Makefile
index 5de0378f90db..7dae831ee8b6 100644
--- a/drivers/mtd/tests/Makefile
+++ b/drivers/mtd/tests/Makefile
@@ -1,19 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_MTD_TESTS) += mtd_oobtest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_pagetest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_readtest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_speedtest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_stresstest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_subpagetest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_torturetest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_nandecctest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_nandbiterrs.o
+obj-$(CONFIG_MTD_TESTS) += mtd_oobtest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_pagetest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_readtest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_speedtest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_stresstest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_subpagetest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_torturetest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_nandecctest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_nandbiterrs.o mtd_test.o
 
-mtd_oobtest-objs := oobtest.o mtd_test.o
-mtd_pagetest-objs := pagetest.o mtd_test.o
-mtd_readtest-objs := readtest.o mtd_test.o
-mtd_speedtest-objs := speedtest.o mtd_test.o
-mtd_stresstest-objs := stresstest.o mtd_test.o
-mtd_subpagetest-objs := subpagetest.o mtd_test.o
-mtd_torturetest-objs := torturetest.o mtd_test.o
-mtd_nandbiterrs-objs := nandbiterrs.o mtd_test.o
+mtd_oobtest-objs := oobtest.o
+mtd_pagetest-objs := pagetest.o
+mtd_readtest-objs := readtest.o
+mtd_speedtest-objs := speedtest.o
+mtd_stresstest-objs := stresstest.o
+mtd_subpagetest-objs := subpagetest.o
+mtd_torturetest-objs := torturetest.o
+mtd_nandbiterrs-objs := nandbiterrs.o
diff --git a/drivers/mtd/tests/mtd_test.c b/drivers/mtd/tests/mtd_test.c
index c84250beffdc..f391e0300cdc 100644
--- a/drivers/mtd/tests/mtd_test.c
+++ b/drivers/mtd/tests/mtd_test.c
@@ -25,6 +25,7 @@ int mtdtest_erase_eraseblock(struct mtd_info *mtd, unsigned int ebnum)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtdtest_erase_eraseblock);
 
 static int is_block_bad(struct mtd_info *mtd, unsigned int ebnum)
 {
@@ -57,6 +58,7 @@ int mtdtest_scan_for_bad_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtdtest_scan_for_bad_eraseblocks);
 
 int mtdtest_erase_good_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 				unsigned int eb, int ebcnt)
@@ -75,6 +77,7 @@ int mtdtest_erase_good_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtdtest_erase_good_eraseblocks);
 
 int mtdtest_read(struct mtd_info *mtd, loff_t addr, size_t size, void *buf)
 {
@@ -92,6 +95,7 @@ int mtdtest_read(struct mtd_info *mtd, loff_t addr, size_t size, void *buf)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mtdtest_read);
 
 int mtdtest_write(struct mtd_info *mtd, loff_t addr, size_t size,
 		const void *buf)
@@ -107,3 +111,8 @@ int mtdtest_write(struct mtd_info *mtd, loff_t addr, size_t size,
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mtdtest_write);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MTD function test helpers");
+MODULE_AUTHOR("Akinobu Mita");
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index fa6ff75459c6..655b87716586 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -1573,6 +1573,7 @@ int self_check_eba(struct ubi_device *ubi, struct ubi_attach_info *ai_fastmap,
 					  GFP_KERNEL);
 		if (!fm_eba[i]) {
 			ret = -ENOMEM;
+			kfree(scan_eba[i]);
 			goto out_free;
 		}
 
@@ -1608,7 +1609,7 @@ int self_check_eba(struct ubi_device *ubi, struct ubi_attach_info *ai_fastmap,
 	}
 
 out_free:
-	for (i = 0; i < num_volumes; i++) {
+	while (--i >= 0) {
 		if (!ubi->volumes[i])
 			continue;
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 79b36f1c50ae..f0c0da85ba4f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -774,13 +774,10 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
 	return bestslave;
 }
 
+/* must be called in RCU critical section or with RTNL held */
 static bool bond_should_notify_peers(struct bonding *bond)
 {
-	struct slave *slave;
-
-	rcu_read_lock();
-	slave = rcu_dereference(bond->curr_active_slave);
-	rcu_read_unlock();
+	struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
 
 	if (!slave || !bond->send_peer_notif ||
 	    !netif_carrier_ok(bond->dev) ||
diff --git a/drivers/net/ethernet/brocade/bna/bna_types.h b/drivers/net/ethernet/brocade/bna/bna_types.h
index c438d032e8bf..1af883c849ad 100644
--- a/drivers/net/ethernet/brocade/bna/bna_types.h
+++ b/drivers/net/ethernet/brocade/bna/bna_types.h
@@ -418,7 +418,7 @@ struct bna_ib {
 /* Tx object */
 
 /* Tx datapath control structure */
-#define BNA_Q_NAME_SIZE		16
+#define BNA_Q_NAME_SIZE		(IFNAMSIZ + 6)
 struct bna_tcb {
 	/* Fast path */
 	void			**sw_qpt;
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index 1e25c3b5f563..9773901ea690 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1543,8 +1543,9 @@ bnad_tx_msix_register(struct bnad *bnad, struct bnad_tx_info *tx_info,
 
 	for (i = 0; i < num_txqs; i++) {
 		vector_num = tx_info->tcb[i]->intr_vector;
-		sprintf(tx_info->tcb[i]->name, "%s TXQ %d", bnad->netdev->name,
-				tx_id + tx_info->tcb[i]->id);
+		snprintf(tx_info->tcb[i]->name, BNA_Q_NAME_SIZE, "%s TXQ %d",
+			 bnad->netdev->name,
+			 tx_id + tx_info->tcb[i]->id);
 		err = request_irq(bnad->msix_table[vector_num].vector,
 				  (irq_handler_t)bnad_msix_tx, 0,
 				  tx_info->tcb[i]->name,
@@ -1594,9 +1595,9 @@ bnad_rx_msix_register(struct bnad *bnad, struct bnad_rx_info *rx_info,
 
 	for (i = 0; i < num_rxps; i++) {
 		vector_num = rx_info->rx_ctrl[i].ccb->intr_vector;
-		sprintf(rx_info->rx_ctrl[i].ccb->name, "%s CQ %d",
-			bnad->netdev->name,
-			rx_id + rx_info->rx_ctrl[i].ccb->id);
+		snprintf(rx_info->rx_ctrl[i].ccb->name, BNA_Q_NAME_SIZE,
+			 "%s CQ %d", bnad->netdev->name,
+			 rx_id + rx_info->rx_ctrl[i].ccb->id);
 		err = request_irq(bnad->msix_table[vector_num].vector,
 				  (irq_handler_t)bnad_msix_rx, 0,
 				  rx_info->rx_ctrl[i].ccb->name,
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 35593b41e6c1..29ef84b7c9cc 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -223,8 +223,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define PKT_MINBUF_SIZE		64
 
 /* FEC receive acceleration */
-#define FEC_RACC_IPDIS		(1 << 1)
-#define FEC_RACC_PRODIS		(1 << 2)
+#define FEC_RACC_IPDIS		BIT(1)
+#define FEC_RACC_PRODIS		BIT(2)
 #define FEC_RACC_SHIFT16	BIT(7)
 #define FEC_RACC_OPTIONS	(FEC_RACC_IPDIS | FEC_RACC_PRODIS)
 
@@ -253,8 +253,23 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_MMFR_TA		(2 << 16)
 #define FEC_MMFR_DATA(v)	(v & 0xffff)
 /* FEC ECR bits definition */
-#define FEC_ECR_MAGICEN		(1 << 2)
-#define FEC_ECR_SLEEP		(1 << 3)
+#define FEC_ECR_RESET           BIT(0)
+#define FEC_ECR_ETHEREN         BIT(1)
+#define FEC_ECR_MAGICEN         BIT(2)
+#define FEC_ECR_SLEEP           BIT(3)
+#define FEC_ECR_EN1588          BIT(4)
+#define FEC_ECR_BYTESWP         BIT(8)
+/* FEC RCR bits definition */
+#define FEC_RCR_LOOP            BIT(0)
+#define FEC_RCR_HALFDPX         BIT(1)
+#define FEC_RCR_MII             BIT(2)
+#define FEC_RCR_PROMISC         BIT(3)
+#define FEC_RCR_BC_REJ          BIT(4)
+#define FEC_RCR_FLOWCTL         BIT(5)
+#define FEC_RCR_RMII            BIT(8)
+#define FEC_RCR_10BASET         BIT(9)
+/* TX WMARK bits */
+#define FEC_TXWMRK_STRFWD       BIT(8)
 
 #define FEC_MII_TIMEOUT		30000 /* us */
 
@@ -950,7 +965,7 @@ fec_restart(struct net_device *ndev)
 	u32 val;
 	u32 temp_mac[2];
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
-	u32 ecntl = 0x2; /* ETHEREN */
+	u32 ecntl = FEC_ECR_ETHEREN;
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
@@ -1026,18 +1041,18 @@ fec_restart(struct net_device *ndev)
 		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
 			rcntl |= (1 << 6);
 		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
-			rcntl |= (1 << 8);
+			rcntl |= FEC_RCR_RMII;
 		else
-			rcntl &= ~(1 << 8);
+			rcntl &= ~FEC_RCR_RMII;
 
 		/* 1G, 100M or 10M */
 		if (ndev->phydev) {
 			if (ndev->phydev->speed == SPEED_1000)
 				ecntl |= (1 << 5);
 			else if (ndev->phydev->speed == SPEED_100)
-				rcntl &= ~(1 << 9);
+				rcntl &= ~FEC_RCR_10BASET;
 			else
-				rcntl |= (1 << 9);
+				rcntl |= FEC_RCR_10BASET;
 		}
 	} else {
 #ifdef FEC_MIIGSK_ENR
@@ -1096,13 +1111,13 @@ fec_restart(struct net_device *ndev)
 
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
-		ecntl |= (1 << 8);
+		ecntl |= FEC_ECR_BYTESWP;
 		/* enable ENET store and forward mode */
-		writel(1 << 8, fep->hwp + FEC_X_WMRK);
+		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
-		ecntl |= (1 << 4);
+		ecntl |= FEC_ECR_EN1588;
 
 #ifndef CONFIG_M5272
 	/* Enable the MIB statistic event counters */
@@ -1149,7 +1164,7 @@ static void
 fec_stop(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
+	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
 	u32 val;
 
 	/* We cannot expect a graceful transmit stop without link !!! */
@@ -1168,7 +1183,7 @@ fec_stop(struct net_device *ndev)
 		if (fep->quirks & FEC_QUIRK_HAS_AVB) {
 			writel(0, fep->hwp + FEC_ECNTRL);
 		} else {
-			writel(1, fep->hwp + FEC_ECNTRL);
+			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
 			udelay(10);
 		}
 		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
@@ -1184,11 +1199,16 @@ fec_stop(struct net_device *ndev)
 	/* We have to keep ENET enabled to have MII interrupt stay working */
 	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
 		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
-		writel(2, fep->hwp + FEC_ECNTRL);
+		writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
 		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
-}
 
+	if (fep->bufdesc_ex) {
+		val = readl(fep->hwp + FEC_ECNTRL);
+		val |= FEC_ECR_EN1588;
+		writel(val, fep->hwp + FEC_ECNTRL);
+	}
+}
 
 static void
 fec_timeout(struct net_device *ndev)
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index abf0b6cddf20..a5d693f51d2b 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -635,6 +635,9 @@ void fec_ptp_stop(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	if (fep->pps_enable)
+		fec_ptp_enable_pps(fep, 0);
+
 	cancel_delayed_work_sync(&fep->time_keep);
 	if (fep->ptp_clock)
 		ptp_clock_unregister(fep->ptp_clock);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f8d00263d901..72a6f22ee423 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -7,16 +7,16 @@
 
 #define ICE_PF_RESET_WAIT_COUNT	200
 
-#define ICE_NIC_FLX_ENTRY(hw, mdid, idx) \
-	wr32((hw), GLFLXP_RXDID_FLX_WRD_##idx(ICE_RXDID_FLEX_NIC), \
+#define ICE_PROG_FLEX_ENTRY(hw, rxdid, mdid, idx) \
+	wr32((hw), GLFLXP_RXDID_FLX_WRD_##idx(rxdid), \
 	     ((ICE_RX_OPC_MDID << \
 	       GLFLXP_RXDID_FLX_WRD_##idx##_RXDID_OPCODE_S) & \
 	      GLFLXP_RXDID_FLX_WRD_##idx##_RXDID_OPCODE_M) | \
 	     (((mdid) << GLFLXP_RXDID_FLX_WRD_##idx##_PROT_MDID_S) & \
 	      GLFLXP_RXDID_FLX_WRD_##idx##_PROT_MDID_M))
 
-#define ICE_NIC_FLX_FLG_ENTRY(hw, flg_0, flg_1, flg_2, flg_3, idx) \
-	wr32((hw), GLFLXP_RXDID_FLAGS(ICE_RXDID_FLEX_NIC, idx), \
+#define ICE_PROG_FLG_ENTRY(hw, rxdid, flg_0, flg_1, flg_2, flg_3, idx) \
+	wr32((hw), GLFLXP_RXDID_FLAGS(rxdid, idx), \
 	     (((flg_0) << GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_S) & \
 	      GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_M) | \
 	     (((flg_1) << GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_1_S) & \
@@ -290,30 +290,85 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 }
 
 /**
- * ice_init_flex_parser - initialize rx flex parser
+ * ice_init_flex_flags
  * @hw: pointer to the hardware structure
+ * @prof_id: Rx Descriptor Builder profile ID
  *
- * Function to initialize flex descriptors
+ * Function to initialize Rx flex flags
  */
-static void ice_init_flex_parser(struct ice_hw *hw)
+static void ice_init_flex_flags(struct ice_hw *hw, enum ice_rxdid prof_id)
 {
 	u8 idx = 0;
 
-	ICE_NIC_FLX_ENTRY(hw, ICE_RX_MDID_HASH_LOW, 0);
-	ICE_NIC_FLX_ENTRY(hw, ICE_RX_MDID_HASH_HIGH, 1);
-	ICE_NIC_FLX_ENTRY(hw, ICE_RX_MDID_FLOW_ID_LOWER, 2);
-	ICE_NIC_FLX_ENTRY(hw, ICE_RX_MDID_FLOW_ID_HIGH, 3);
-	ICE_NIC_FLX_FLG_ENTRY(hw, ICE_RXFLG_PKT_FRG, ICE_RXFLG_UDP_GRE,
-			      ICE_RXFLG_PKT_DSI, ICE_RXFLG_FIN, idx++);
-	ICE_NIC_FLX_FLG_ENTRY(hw, ICE_RXFLG_SYN, ICE_RXFLG_RST,
-			      ICE_RXFLG_PKT_DSI, ICE_RXFLG_PKT_DSI, idx++);
-	ICE_NIC_FLX_FLG_ENTRY(hw, ICE_RXFLG_PKT_DSI, ICE_RXFLG_PKT_DSI,
-			      ICE_RXFLG_EVLAN_x8100, ICE_RXFLG_EVLAN_x9100,
-			      idx++);
-	ICE_NIC_FLX_FLG_ENTRY(hw, ICE_RXFLG_VLAN_x8100, ICE_RXFLG_TNL_VLAN,
-			      ICE_RXFLG_TNL_MAC, ICE_RXFLG_TNL0, idx++);
-	ICE_NIC_FLX_FLG_ENTRY(hw, ICE_RXFLG_TNL1, ICE_RXFLG_TNL2,
-			      ICE_RXFLG_PKT_DSI, ICE_RXFLG_PKT_DSI, idx);
+	/* Flex-flag fields (0-2) are programmed with FLG64 bits with layout:
+	 * flexiflags0[5:0] - TCP flags, is_packet_fragmented, is_packet_UDP_GRE
+	 * flexiflags1[3:0] - Not used for flag programming
+	 * flexiflags2[7:0] - Tunnel and VLAN types
+	 * 2 invalid fields in last index
+	 */
+	switch (prof_id) {
+	/* Rx flex flags are currently programmed for the NIC profiles only.
+	 * Different flag bit programming configurations can be added per
+	 * profile as needed.
+	 */
+	case ICE_RXDID_FLEX_NIC:
+	case ICE_RXDID_FLEX_NIC_2:
+		ICE_PROG_FLG_ENTRY(hw, prof_id, ICE_RXFLG_PKT_FRG,
+				   ICE_RXFLG_UDP_GRE, ICE_RXFLG_PKT_DSI,
+				   ICE_RXFLG_FIN, idx++);
+		/* flex flag 1 is not used for flexi-flag programming, skipping
+		 * these four FLG64 bits.
+		 */
+		ICE_PROG_FLG_ENTRY(hw, prof_id, ICE_RXFLG_SYN, ICE_RXFLG_RST,
+				   ICE_RXFLG_PKT_DSI, ICE_RXFLG_PKT_DSI, idx++);
+		ICE_PROG_FLG_ENTRY(hw, prof_id, ICE_RXFLG_PKT_DSI,
+				   ICE_RXFLG_PKT_DSI, ICE_RXFLG_EVLAN_x8100,
+				   ICE_RXFLG_EVLAN_x9100, idx++);
+		ICE_PROG_FLG_ENTRY(hw, prof_id, ICE_RXFLG_VLAN_x8100,
+				   ICE_RXFLG_TNL_VLAN, ICE_RXFLG_TNL_MAC,
+				   ICE_RXFLG_TNL0, idx++);
+		ICE_PROG_FLG_ENTRY(hw, prof_id, ICE_RXFLG_TNL1, ICE_RXFLG_TNL2,
+				   ICE_RXFLG_PKT_DSI, ICE_RXFLG_PKT_DSI, idx);
+		break;
+
+	default:
+		ice_debug(hw, ICE_DBG_INIT,
+			  "Flag programming for profile ID %d not supported\n",
+			  prof_id);
+	}
+}
+
+/**
+ * ice_init_flex_flds
+ * @hw: pointer to the hardware structure
+ * @prof_id: Rx Descriptor Builder profile ID
+ *
+ * Function to initialize flex descriptors
+ */
+static void ice_init_flex_flds(struct ice_hw *hw, enum ice_rxdid prof_id)
+{
+	enum ice_flex_rx_mdid mdid;
+
+	switch (prof_id) {
+	case ICE_RXDID_FLEX_NIC:
+	case ICE_RXDID_FLEX_NIC_2:
+		ICE_PROG_FLEX_ENTRY(hw, prof_id, ICE_RX_MDID_HASH_LOW, 0);
+		ICE_PROG_FLEX_ENTRY(hw, prof_id, ICE_RX_MDID_HASH_HIGH, 1);
+		ICE_PROG_FLEX_ENTRY(hw, prof_id, ICE_RX_MDID_FLOW_ID_LOWER, 2);
+
+		mdid = (prof_id == ICE_RXDID_FLEX_NIC_2) ?
+			ICE_RX_MDID_SRC_VSI : ICE_RX_MDID_FLOW_ID_HIGH;
+
+		ICE_PROG_FLEX_ENTRY(hw, prof_id, mdid, 3);
+
+		ice_init_flex_flags(hw, prof_id);
+		break;
+
+	default:
+		ice_debug(hw, ICE_DBG_INIT,
+			  "Field init for profile ID %d not supported\n",
+			  prof_id);
+	}
 }
 
 /**
@@ -494,7 +549,8 @@ enum ice_status ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_fltr_mgmt_struct;
 
-	ice_init_flex_parser(hw);
+	ice_init_flex_flds(hw, ICE_RXDID_FLEX_NIC);
+	ice_init_flex_flds(hw, ICE_RXDID_FLEX_NIC_2);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 068dbc740b76..94504023d86e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -188,23 +188,25 @@ struct ice_32b_rx_flex_desc_nic {
  * with a specific metadata (profile 7 reserved for HW)
  */
 enum ice_rxdid {
-	ICE_RXDID_START			= 0,
-	ICE_RXDID_LEGACY_0		= ICE_RXDID_START,
-	ICE_RXDID_LEGACY_1,
-	ICE_RXDID_FLX_START,
-	ICE_RXDID_FLEX_NIC		= ICE_RXDID_FLX_START,
-	ICE_RXDID_FLX_LAST		= 63,
-	ICE_RXDID_LAST			= ICE_RXDID_FLX_LAST
+	ICE_RXDID_LEGACY_0		= 0,
+	ICE_RXDID_LEGACY_1		= 1,
+	ICE_RXDID_FLEX_NIC		= 2,
+	ICE_RXDID_FLEX_NIC_2		= 6,
+	ICE_RXDID_HW			= 7,
+	ICE_RXDID_LAST			= 63,
 };
 
 /* Receive Flex Descriptor Rx opcode values */
 #define ICE_RX_OPC_MDID		0x01
 
 /* Receive Descriptor MDID values */
-#define ICE_RX_MDID_FLOW_ID_LOWER	5
-#define ICE_RX_MDID_FLOW_ID_HIGH	6
-#define ICE_RX_MDID_HASH_LOW		56
-#define ICE_RX_MDID_HASH_HIGH		57
+enum ice_flex_rx_mdid {
+	ICE_RX_MDID_FLOW_ID_LOWER	= 5,
+	ICE_RX_MDID_FLOW_ID_HIGH,
+	ICE_RX_MDID_SRC_VSI		= 19,
+	ICE_RX_MDID_HASH_LOW		= 56,
+	ICE_RX_MDID_HASH_HIGH,
+};
 
 /* Rx Flag64 packet flag bits */
 enum ice_rx_flg64_bits {
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index be9aa368639f..dcfbe64c82bb 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -727,6 +727,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				/* rtnl_lock already held
 				 * we might sleep in __netpoll_cleanup()
 				 */
+				nt->enabled = false;
 				spin_unlock_irqrestore(&target_list_lock, flags);
 
 				__netpoll_cleanup(&nt->np);
@@ -734,7 +735,6 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				spin_lock_irqsave(&target_list_lock, flags);
 				dev_put(nt->np.dev);
 				nt->np.dev = NULL;
-				nt->enabled = false;
 				stopped = true;
 				netconsole_target_put(nt);
 				goto restart;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 3c65549a8688..881240d93956 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -241,6 +241,7 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			break;
 		default:
 			/* not ip - do not know what to do */
+			kfree_skb(skbn);
 			goto skip;
 		}
 
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index a0e5d066ac45..1f11c56ccd5c 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -178,6 +178,7 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 	__le16 res;
 	int rc = 0;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(netdev, "Only internal phy supported\n");
@@ -188,11 +189,17 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	if (loc == MII_BMSR) {
 		u8 value;
 
-		sr_read_reg(dev, SR_NSR, &value);
+		err = sr_read_reg(dev, SR_NSR, &value);
+		if (err < 0)
+			return err;
+
 		if (value & NSR_LINKST)
 			rc = 1;
 	}
-	sr_share_read_word(dev, 1, loc, &res);
+	err = sr_share_read_word(dev, 1, loc, &res);
+	if (err < 0)
+		return err;
+
 	if (rc == 1)
 		res = le16_to_cpu(res) | BMSR_LSTATUS;
 	else
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index d532decc1538..071dee3c3ded 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -2638,7 +2638,6 @@ wlc_lcnphy_tx_iqlo_cal(struct brcms_phy *pi,
 
 	struct lcnphy_txgains cal_gains, temp_gains;
 	u16 hash;
-	u8 band_idx;
 	int j;
 	u16 ncorr_override[5];
 	u16 syst_coeffs[] = { 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
@@ -2670,6 +2669,9 @@ wlc_lcnphy_tx_iqlo_cal(struct brcms_phy *pi,
 	u16 *values_to_save;
 	struct brcms_phy_lcnphy *pi_lcn = pi->u.pi_lcnphy;
 
+	if (WARN_ON(CHSPEC_IS5G(pi->radio_chanspec)))
+		return;
+
 	values_to_save = kmalloc_array(20, sizeof(u16), GFP_ATOMIC);
 	if (NULL == values_to_save)
 		return;
@@ -2733,20 +2735,18 @@ wlc_lcnphy_tx_iqlo_cal(struct brcms_phy *pi,
 	hash = (target_gains->gm_gain << 8) |
 	       (target_gains->pga_gain << 4) | (target_gains->pad_gain);
 
-	band_idx = (CHSPEC_IS5G(pi->radio_chanspec) ? 1 : 0);
-
 	cal_gains = *target_gains;
 	memset(ncorr_override, 0, sizeof(ncorr_override));
-	for (j = 0; j < iqcal_gainparams_numgains_lcnphy[band_idx]; j++) {
-		if (hash == tbl_iqcal_gainparams_lcnphy[band_idx][j][0]) {
+	for (j = 0; j < iqcal_gainparams_numgains_lcnphy[0]; j++) {
+		if (hash == tbl_iqcal_gainparams_lcnphy[0][j][0]) {
 			cal_gains.gm_gain =
-				tbl_iqcal_gainparams_lcnphy[band_idx][j][1];
+				tbl_iqcal_gainparams_lcnphy[0][j][1];
 			cal_gains.pga_gain =
-				tbl_iqcal_gainparams_lcnphy[band_idx][j][2];
+				tbl_iqcal_gainparams_lcnphy[0][j][2];
 			cal_gains.pad_gain =
-				tbl_iqcal_gainparams_lcnphy[band_idx][j][3];
+				tbl_iqcal_gainparams_lcnphy[0][j][3];
 			memcpy(ncorr_override,
-			       &tbl_iqcal_gainparams_lcnphy[band_idx][j][3],
+			       &tbl_iqcal_gainparams_lcnphy[0][j][3],
 			       sizeof(ncorr_override));
 			break;
 		}
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 1f660fce5ad0..52e186f945b0 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -934,6 +934,8 @@ mwifiex_init_new_priv_params(struct mwifiex_private *priv,
 		return -EOPNOTSUPP;
 	}
 
+	priv->bss_num = mwifiex_get_unused_bss_num(adapter, priv->bss_type);
+
 	spin_lock_irqsave(&adapter->main_proc_lock, flags);
 	adapter->main_locked = false;
 	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 163497ef48fd..a243c066d923 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2481,6 +2481,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_NO_APST;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 10 hours on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index 5484a46dafda..465acebd6438 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -109,8 +109,7 @@ int parport_daisy_init(struct parport *port)
 	    ((num_ports = num_mux_ports(port)) == 2 || num_ports == 4)) {
 		/* Leave original as port zero. */
 		port->muxport = 0;
-		printk(KERN_INFO
-			"%s: 1st (default) port of %d-way multiplexor\n",
+		pr_info("%s: 1st (default) port of %d-way multiplexor\n",
 			port->name, num_ports);
 		for (i = 1; i < num_ports; i++) {
 			/* Clone the port. */
@@ -123,8 +122,7 @@ int parport_daisy_init(struct parport *port)
 				continue;
 			}
 
-			printk(KERN_INFO
-				"%s: %d%s port of %d-way multiplexor on %s\n",
+			pr_info("%s: %d%s port of %d-way multiplexor on %s\n",
 				extra->name, i + 1, th[i + 1], num_ports,
 				port->name);
 
diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index f12b9da69255..d0d36c29ae56 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -329,7 +329,7 @@ int parport_negotiate (struct parport *port, int mode)
 #ifndef CONFIG_PARPORT_1284
 	if (mode == IEEE1284_MODE_COMPAT)
 		return 0;
-	printk (KERN_ERR "parport: IEEE1284 not supported in this kernel\n");
+	pr_err("parport: IEEE1284 not supported in this kernel\n");
 	return -1;
 #else
 	int m = mode & ~IEEE1284_ADDR;
@@ -694,7 +694,7 @@ ssize_t parport_write (struct parport *port, const void *buffer, size_t len)
 ssize_t parport_read (struct parport *port, void *buffer, size_t len)
 {
 #ifndef CONFIG_PARPORT_1284
-	printk (KERN_ERR "parport: IEEE1284 not supported in this kernel\n");
+	pr_err("parport: IEEE1284 not supported in this kernel\n");
 	return -ENODEV;
 #else
 	int mode = port->physport->ieee1284.mode;
diff --git a/drivers/parport/ieee1284_ops.c b/drivers/parport/ieee1284_ops.c
index 75daa16f38b7..58ec484c7305 100644
--- a/drivers/parport/ieee1284_ops.c
+++ b/drivers/parport/ieee1284_ops.c
@@ -599,8 +599,7 @@ size_t parport_ieee1284_ecp_read_data (struct parport *port,
 			DPRINTK (KERN_DEBUG "ECP read timed out at 45\n");
 
 			if (command)
-				printk (KERN_WARNING
-					"%s: command ignored (%02x)\n",
+				pr_warn("%s: command ignored (%02x)\n",
 					port->name, byte);
 
 			break;
diff --git a/drivers/parport/parport_amiga.c b/drivers/parport/parport_amiga.c
index 9c68f2aec4ff..75779725f638 100644
--- a/drivers/parport/parport_amiga.c
+++ b/drivers/parport/parport_amiga.c
@@ -211,7 +211,7 @@ static int __init amiga_parallel_probe(struct platform_device *pdev)
 	if (err)
 		goto out_irq;
 
-	printk(KERN_INFO "%s: Amiga built-in port using irq\n", p->name);
+	pr_info("%s: Amiga built-in port using irq\n", p->name);
 	/* XXX: set operating mode */
 	parport_announce_port(p);
 
diff --git a/drivers/parport/parport_atari.c b/drivers/parport/parport_atari.c
index 9fbf6ccd54de..2f8c7f6617d7 100644
--- a/drivers/parport/parport_atari.c
+++ b/drivers/parport/parport_atari.c
@@ -199,7 +199,7 @@ static int __init parport_atari_init(void)
 		}
 
 		this_port = p;
-		printk(KERN_INFO "%s: Atari built-in port using irq\n", p->name);
+		pr_info("%s: Atari built-in port using irq\n", p->name);
 		parport_announce_port (p);
 
 		return 0;
diff --git a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
index e9b52e4a4648..755207ca155f 100644
--- a/drivers/parport/parport_cs.c
+++ b/drivers/parport/parport_cs.c
@@ -142,10 +142,8 @@ static int parport_config(struct pcmcia_device *link)
 			      link->irq, PARPORT_DMA_NONE,
 			      &link->dev, IRQF_SHARED);
     if (p == NULL) {
-	printk(KERN_NOTICE "parport_cs: parport_pc_probe_port() at "
-	       "0x%3x, irq %u failed\n",
-	       (unsigned int) link->resource[0]->start,
-	       link->irq);
+	    pr_notice("parport_cs: parport_pc_probe_port() at 0x%3x, irq %u failed\n",
+		      (unsigned int)link->resource[0]->start, link->irq);
 	goto failed;
     }
 
diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index 190c0a7a1c52..467bc0ab95ec 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -287,7 +287,7 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 	p->size = (p->modes & PARPORT_MODE_EPP)?8:3;
 	p->private_data = priv;
 
-	printk(KERN_INFO "%s: PC-style at 0x%lx", p->name, p->base);
+	pr_info("%s: PC-style at 0x%lx", p->name, p->base);
 	p->irq = irq;
 	if (p->irq == PARPORT_IRQ_AUTO) {
 		p->irq = PARPORT_IRQ_NONE;
@@ -304,12 +304,16 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 		p->dma = PARPORT_DMA_NONE;
 
 	pr_cont(" [");
-#define printmode(x) {if(p->modes&PARPORT_MODE_##x){pr_cont("%s%s",f?",":"",#x);f++;}}
+#define printmode(x)							\
+do {									\
+	if (p->modes & PARPORT_MODE_##x)				\
+		pr_cont("%s%s", f++ ? "," : "", #x);			\
+} while (0)
 	{
 		int f = 0;
 		printmode(PCSPP);
 		printmode(TRISTATE);
-		printmode(COMPAT)
+		printmode(COMPAT);
 		printmode(EPP);
 //		printmode(ECP);
 //		printmode(DMA);
@@ -320,8 +324,7 @@ struct parport *parport_gsc_probe_port(unsigned long base,
 	if (p->irq != PARPORT_IRQ_NONE) {
 		if (request_irq (p->irq, parport_irq_handler,
 				 0, p->name, p)) {
-			printk (KERN_WARNING "%s: irq %d in use, "
-				"resorting to polled operation\n",
+			pr_warn("%s: irq %d in use, resorting to polled operation\n",
 				p->name, p->irq);
 			p->irq = PARPORT_IRQ_NONE;
 			p->dma = PARPORT_DMA_NONE;
@@ -352,7 +355,7 @@ static int __init parport_init_chip(struct parisc_device *dev)
 	unsigned long port;
 
 	if (!dev->irq) {
-		printk(KERN_WARNING "IRQ not found for parallel device at 0x%llx\n",
+		pr_warn("IRQ not found for parallel device at 0x%llx\n",
 			(unsigned long long)dev->hpa.start);
 		return -ENODEV;
 	}
diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index 62873070f988..c92523b6a3cb 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -1348,9 +1348,8 @@ static unsigned int parport_ip32_fwp_wait_interrupt(struct parport *p)
 			ecr = parport_ip32_read_econtrol(p);
 			if ((ecr & ECR_F_EMPTY) && !(ecr & ECR_SERVINTR)
 			    && !lost_interrupt) {
-				printk(KERN_WARNING PPIP32
-				       "%s: lost interrupt in %s\n",
-				       p->name, __func__);
+				pr_warn(PPIP32 "%s: lost interrupt in %s\n",
+					p->name, __func__);
 				lost_interrupt = 1;
 			}
 		}
@@ -1654,8 +1653,8 @@ static size_t parport_ip32_compat_write_data(struct parport *p,
 				       DSR_nBUSY | DSR_nFAULT)) {
 		/* Avoid to flood the logs */
 		if (ready_before)
-			printk(KERN_INFO PPIP32 "%s: not ready in %s\n",
-			       p->name, __func__);
+			pr_info(PPIP32 "%s: not ready in %s\n",
+				p->name, __func__);
 		ready_before = 0;
 		goto stop;
 	}
@@ -1735,8 +1734,8 @@ static size_t parport_ip32_ecp_write_data(struct parport *p,
 				       DSR_nBUSY | DSR_nFAULT)) {
 		/* Avoid to flood the logs */
 		if (ready_before)
-			printk(KERN_INFO PPIP32 "%s: not ready in %s\n",
-			       p->name, __func__);
+			pr_info(PPIP32 "%s: not ready in %s\n",
+				p->name, __func__);
 		ready_before = 0;
 		goto stop;
 	}
@@ -2075,8 +2074,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 	p->modes |= PARPORT_MODE_TRISTATE;
 
 	if (!parport_ip32_fifo_supported(p)) {
-		printk(KERN_WARNING PPIP32
-		       "%s: error: FIFO disabled\n", p->name);
+		pr_warn(PPIP32 "%s: error: FIFO disabled\n", p->name);
 		/* Disable hardware modes depending on a working FIFO. */
 		features &= ~PARPORT_IP32_ENABLE_SPP;
 		features &= ~PARPORT_IP32_ENABLE_ECP;
@@ -2088,8 +2086,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 	if (features & PARPORT_IP32_ENABLE_IRQ) {
 		int irq = MACEISA_PARALLEL_IRQ;
 		if (request_irq(irq, parport_ip32_interrupt, 0, p->name, p)) {
-			printk(KERN_WARNING PPIP32
-			       "%s: error: IRQ disabled\n", p->name);
+			pr_warn(PPIP32 "%s: error: IRQ disabled\n", p->name);
 			/* DMA cannot work without interrupts. */
 			features &= ~PARPORT_IP32_ENABLE_DMA;
 		} else {
@@ -2102,8 +2099,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 	/* Allocate DMA resources */
 	if (features & PARPORT_IP32_ENABLE_DMA) {
 		if (parport_ip32_dma_register())
-			printk(KERN_WARNING PPIP32
-			       "%s: error: DMA disabled\n", p->name);
+			pr_warn(PPIP32 "%s: error: DMA disabled\n", p->name);
 		else {
 			pr_probe(p, "DMA support enabled\n");
 			p->dma = 0; /* arbitrary value != PARPORT_DMA_NONE */
@@ -2145,8 +2141,7 @@ static __init struct parport *parport_ip32_probe_port(void)
 	parport_ip32_dump_state(p, "end init", 0);
 
 	/* Print out what we found */
-	printk(KERN_INFO "%s: SGI IP32 at 0x%lx (0x%lx)",
-	       p->name, p->base, p->base_hi);
+	pr_info("%s: SGI IP32 at 0x%lx (0x%lx)", p->name, p->base, p->base_hi);
 	if (p->irq != PARPORT_IRQ_NONE)
 		printk(", irq %d", p->irq);
 	printk(" [");
diff --git a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
index 7f4be0e484c7..378b6bce3ae7 100644
--- a/drivers/parport/parport_mfc3.c
+++ b/drivers/parport/parport_mfc3.c
@@ -324,7 +324,7 @@ static int __init parport_mfc3_init(void)
 		p->dev = &z->dev;
 
 		this_port[pias++] = p;
-		printk(KERN_INFO "%s: Multiface III port using irq\n", p->name);
+		pr_info("%s: Multiface III port using irq\n", p->name);
 		/* XXX: set operating mode */
 
 		p->private_data = (void *)piabase;
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index c34ad5dd62e3..ad2acafb6850 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -981,28 +981,24 @@ static void show_parconfig_smsc37c669(int io, int key)
 	outb(0xaa, io);
 
 	if (verbose_probing) {
-		printk(KERN_INFO
-			"SMSC 37c669 LPT Config: cr_1=0x%02x, 4=0x%02x, "
-			"A=0x%2x, 23=0x%02x, 26=0x%02x, 27=0x%02x\n",
+		pr_info("SMSC 37c669 LPT Config: cr_1=0x%02x, 4=0x%02x, A=0x%2x, 23=0x%02x, 26=0x%02x, 27=0x%02x\n",
 			cr1, cr4, cra, cr23, cr26, cr27);
 
 		/* The documentation calls DMA and IRQ-Lines by letters, so
 		   the board maker can/will wire them
 		   appropriately/randomly...  G=reserved H=IDE-irq, */
-		printk(KERN_INFO
-	"SMSC LPT Config: io=0x%04x, irq=%c, dma=%c, fifo threshold=%d\n",
-				cr23 * 4,
-				(cr27 & 0x0f) ? 'A' - 1 + (cr27 & 0x0f) : '-',
-				(cr26 & 0x0f) ? 'A' - 1 + (cr26 & 0x0f) : '-',
-				cra & 0x0f);
-		printk(KERN_INFO "SMSC LPT Config: enabled=%s power=%s\n",
-		       (cr23 * 4 >= 0x100) ? "yes" : "no",
-		       (cr1 & 4) ? "yes" : "no");
-		printk(KERN_INFO
-			"SMSC LPT Config: Port mode=%s, EPP version =%s\n",
-				(cr1 & 0x08) ? "Standard mode only (SPP)"
-					      : modes[cr4 & 0x03],
-				(cr4 & 0x40) ? "1.7" : "1.9");
+		pr_info("SMSC LPT Config: io=0x%04x, irq=%c, dma=%c, fifo threshold=%d\n",
+			cr23 * 4,
+			(cr27 & 0x0f) ? 'A' - 1 + (cr27 & 0x0f) : '-',
+			(cr26 & 0x0f) ? 'A' - 1 + (cr26 & 0x0f) : '-',
+			cra & 0x0f);
+		pr_info("SMSC LPT Config: enabled=%s power=%s\n",
+			(cr23 * 4 >= 0x100) ? "yes" : "no",
+			(cr1 & 4) ? "yes" : "no");
+		pr_info("SMSC LPT Config: Port mode=%s, EPP version =%s\n",
+			(cr1 & 0x08) ? "Standard mode only (SPP)"
+			: modes[cr4 & 0x03],
+			(cr4 & 0x40) ? "1.7" : "1.9");
 	}
 
 	/* Heuristics !  BIOS setup for this mainboard device limits
@@ -1012,7 +1008,7 @@ static void show_parconfig_smsc37c669(int io, int key)
 	if (cr23 * 4 >= 0x100) { /* if active */
 		s = find_free_superio();
 		if (s == NULL)
-			printk(KERN_INFO "Super-IO: too many chips!\n");
+			pr_info("Super-IO: too many chips!\n");
 		else {
 			int d;
 			switch (cr23 * 4) {
@@ -1077,26 +1073,24 @@ static void show_parconfig_winbond(int io, int key)
 	outb(0xaa, io);
 
 	if (verbose_probing) {
-		printk(KERN_INFO
-    "Winbond LPT Config: cr_30=%02x 60,61=%02x%02x 70=%02x 74=%02x, f0=%02x\n",
-					cr30, cr60, cr61, cr70, cr74, crf0);
-		printk(KERN_INFO "Winbond LPT Config: active=%s, io=0x%02x%02x irq=%d, ",
-		       (cr30 & 0x01) ? "yes" : "no", cr60, cr61, cr70 & 0x0f);
+		pr_info("Winbond LPT Config: cr_30=%02x 60,61=%02x%02x 70=%02x 74=%02x, f0=%02x\n",
+			cr30, cr60, cr61, cr70, cr74, crf0);
+		pr_info("Winbond LPT Config: active=%s, io=0x%02x%02x irq=%d, ",
+			(cr30 & 0x01) ? "yes" : "no", cr60, cr61, cr70 & 0x0f);
 		if ((cr74 & 0x07) > 3)
 			pr_cont("dma=none\n");
 		else
 			pr_cont("dma=%d\n", cr74 & 0x07);
-		printk(KERN_INFO
-		    "Winbond LPT Config: irqtype=%s, ECP fifo threshold=%d\n",
-					irqtypes[crf0>>7], (crf0>>3)&0x0f);
-		printk(KERN_INFO "Winbond LPT Config: Port mode=%s\n",
-					modes[crf0 & 0x07]);
+		pr_info("Winbond LPT Config: irqtype=%s, ECP fifo threshold=%d\n",
+			irqtypes[crf0 >> 7], (crf0 >> 3) & 0x0f);
+		pr_info("Winbond LPT Config: Port mode=%s\n",
+			modes[crf0 & 0x07]);
 	}
 
 	if (cr30 & 0x01) { /* the settings can be interrogated later ... */
 		s = find_free_superio();
 		if (s == NULL)
-			printk(KERN_INFO "Super-IO: too many chips!\n");
+			pr_info("Super-IO: too many chips!\n");
 		else {
 			s->io = (cr60 << 8) | cr61;
 			s->irq = cr70 & 0x0f;
@@ -1150,9 +1144,8 @@ static void decode_winbond(int efer, int key, int devid, int devrev, int oldid)
 		progif = 0;
 
 	if (verbose_probing)
-		printk(KERN_INFO "Winbond chip at EFER=0x%x key=0x%02x "
-		       "devid=%02x devrev=%02x oldid=%02x type=%s\n",
-		       efer, key, devid, devrev, oldid, type);
+		pr_info("Winbond chip at EFER=0x%x key=0x%02x devid=%02x devrev=%02x oldid=%02x type=%s\n",
+			efer, key, devid, devrev, oldid, type);
 
 	if (progif == 2)
 		show_parconfig_winbond(efer, key);
@@ -1183,9 +1176,8 @@ static void decode_smsc(int efer, int key, int devid, int devrev)
 		type = "37c666GT";
 
 	if (verbose_probing)
-		printk(KERN_INFO "SMSC chip at EFER=0x%x "
-		       "key=0x%02x devid=%02x devrev=%02x type=%s\n",
-		       efer, key, devid, devrev, type);
+		pr_info("SMSC chip at EFER=0x%x key=0x%02x devid=%02x devrev=%02x type=%s\n",
+			efer, key, devid, devrev, type);
 
 	if (func)
 		func(efer, key);
@@ -1357,7 +1349,7 @@ static void detect_and_report_it87(void)
 	dev |= inb(0x2f);
 	if (dev == 0x8712 || dev == 0x8705 || dev == 0x8715 ||
 	    dev == 0x8716 || dev == 0x8718 || dev == 0x8726) {
-		printk(KERN_INFO "IT%04X SuperIO detected.\n", dev);
+		pr_info("IT%04X SuperIO detected\n", dev);
 		outb(0x07, 0x2E);	/* Parallel Port */
 		outb(0x03, 0x2F);
 		outb(0xF0, 0x2E);	/* BOOT 0x80 off */
@@ -1444,8 +1436,8 @@ static int parport_SPP_supported(struct parport *pb)
 	if (user_specified)
 		/* That didn't work, but the user thinks there's a
 		 * port here. */
-		printk(KERN_INFO "parport 0x%lx (WARNING): CTR: "
-			"wrote 0x%02x, read 0x%02x\n", pb->base, w, r);
+		pr_info("parport 0x%lx (WARNING): CTR: wrote 0x%02x, read 0x%02x\n",
+			pb->base, w, r);
 
 	/* Try the data register.  The data lines aren't tri-stated at
 	 * this stage, so we expect back what we wrote. */
@@ -1463,10 +1455,9 @@ static int parport_SPP_supported(struct parport *pb)
 	if (user_specified) {
 		/* Didn't work, but the user is convinced this is the
 		 * place. */
-		printk(KERN_INFO "parport 0x%lx (WARNING): DATA: "
-			"wrote 0x%02x, read 0x%02x\n", pb->base, w, r);
-		printk(KERN_INFO "parport 0x%lx: You gave this address, "
-			"but there is probably no parallel port there!\n",
+		pr_info("parport 0x%lx (WARNING): DATA: wrote 0x%02x, read 0x%02x\n",
+			pb->base, w, r);
+		pr_info("parport 0x%lx: You gave this address, but there is probably no parallel port there!\n",
 			pb->base);
 	}
 
@@ -1641,7 +1632,7 @@ static int parport_ECP_supported(struct parport *pb)
 
 	if (i <= priv->fifo_depth) {
 		if (verbose_probing)
-			printk(KERN_INFO "0x%lx: readIntrThreshold is %d\n",
+			pr_info("0x%lx: readIntrThreshold is %d\n",
 				pb->base, i);
 	} else
 		/* Number of bytes we can read if we get an interrupt. */
@@ -1656,18 +1647,15 @@ static int parport_ECP_supported(struct parport *pb)
 	switch (pword) {
 	case 0:
 		pword = 2;
-		printk(KERN_WARNING "0x%lx: Unsupported pword size!\n",
-			pb->base);
+		pr_warn("0x%lx: Unsupported pword size!\n", pb->base);
 		break;
 	case 2:
 		pword = 4;
-		printk(KERN_WARNING "0x%lx: Unsupported pword size!\n",
-			pb->base);
+		pr_warn("0x%lx: Unsupported pword size!\n", pb->base);
 		break;
 	default:
-		printk(KERN_WARNING "0x%lx: Unknown implementation ID\n",
-			pb->base);
-		/* Assume 1 */
+		pr_warn("0x%lx: Unknown implementation ID\n", pb->base);
+		/* Fall through - Assume 1 */
 	case 1:
 		pword = 1;
 	}
@@ -2106,9 +2094,9 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 
 	p->size = (p->modes & PARPORT_MODE_EPP) ? 8 : 3;
 
-	printk(KERN_INFO "%s: PC-style at 0x%lx", p->name, p->base);
+	pr_info("%s: PC-style at 0x%lx", p->name, p->base);
 	if (p->base_hi && priv->ecr)
-		printk(KERN_CONT " (0x%lx)", p->base_hi);
+		pr_cont(" (0x%lx)", p->base_hi);
 	if (p->irq == PARPORT_IRQ_AUTO) {
 		p->irq = PARPORT_IRQ_NONE;
 		parport_irq_probe(p);
@@ -2119,7 +2107,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 		p->irq = PARPORT_IRQ_NONE;
 	}
 	if (p->irq != PARPORT_IRQ_NONE) {
-		printk(KERN_CONT ", irq %d", p->irq);
+		pr_cont(", irq %d", p->irq);
 		priv->ctr_writable |= 0x10;
 
 		if (p->dma == PARPORT_DMA_AUTO) {
@@ -2143,41 +2131,39 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 		/* p->ops->ecp_read_data = parport_pc_ecp_read_block_pio; */
 #endif /* IEEE 1284 support */
 		if (p->dma != PARPORT_DMA_NONE) {
-			printk(KERN_CONT ", dma %d", p->dma);
+			pr_cont(", dma %d", p->dma);
 			p->modes |= PARPORT_MODE_DMA;
 		} else
-			printk(KERN_CONT ", using FIFO");
+			pr_cont(", using FIFO");
 	} else
 		/* We can't use the DMA channel after all. */
 		p->dma = PARPORT_DMA_NONE;
 #endif /* Allowed to use FIFO/DMA */
 
-	printk(KERN_CONT " [");
+	pr_cont(" [");
 
-#define printmode(x) \
-	{\
-		if (p->modes & PARPORT_MODE_##x) {\
-			printk(KERN_CONT "%s%s", f ? "," : "", #x);\
-			f++;\
-		} \
-	}
+#define printmode(x)							\
+do {									\
+	if (p->modes & PARPORT_MODE_##x)				\
+		pr_cont("%s%s", f++ ? "," : "", #x);			\
+} while (0)
 
 	{
 		int f = 0;
 		printmode(PCSPP);
 		printmode(TRISTATE);
-		printmode(COMPAT)
+		printmode(COMPAT);
 		printmode(EPP);
 		printmode(ECP);
 		printmode(DMA);
 	}
 #undef printmode
 #ifndef CONFIG_PARPORT_1284
-	printk(KERN_CONT "(,...)");
+	pr_cont("(,...)");
 #endif /* CONFIG_PARPORT_1284 */
-	printk(KERN_CONT "]\n");
+	pr_cont("]\n");
 	if (probedirq != PARPORT_IRQ_NONE)
-		printk(KERN_INFO "%s: irq %d detected\n", p->name, probedirq);
+		pr_info("%s: irq %d detected\n", p->name, probedirq);
 
 	/* If No ECP release the ports grabbed above. */
 	if (ECR_res && (p->modes & PARPORT_MODE_ECP) == 0) {
@@ -2192,8 +2178,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 	if (p->irq != PARPORT_IRQ_NONE) {
 		if (request_irq(p->irq, parport_irq_handler,
 				 irqflags, p->name, p)) {
-			printk(KERN_WARNING "%s: irq %d in use, "
-				"resorting to polled operation\n",
+			pr_warn("%s: irq %d in use, resorting to polled operation\n",
 				p->name, p->irq);
 			p->irq = PARPORT_IRQ_NONE;
 			p->dma = PARPORT_DMA_NONE;
@@ -2203,8 +2188,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 #ifdef HAS_DMA
 		if (p->dma != PARPORT_DMA_NONE) {
 			if (request_dma(p->dma, p->name)) {
-				printk(KERN_WARNING "%s: dma %d in use, "
-					"resorting to PIO operation\n",
+				pr_warn("%s: dma %d in use, resorting to PIO operation\n",
 					p->name, p->dma);
 				p->dma = PARPORT_DMA_NONE;
 			} else {
@@ -2214,9 +2198,7 @@ struct parport *parport_pc_probe_port(unsigned long int base,
 						       &priv->dma_handle,
 						       GFP_KERNEL);
 				if (!priv->dma_buf) {
-					printk(KERN_WARNING "%s: "
-						"cannot get buffer for DMA, "
-						"resorting to PIO operation\n",
+					pr_warn("%s: cannot get buffer for DMA, resorting to PIO operation\n",
 						p->name);
 					free_dma(p->dma);
 					p->dma = PARPORT_DMA_NONE;
@@ -2329,7 +2311,7 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 		}
 	}
 	if (i >= 5) {
-		printk(KERN_INFO "parport_pc: cannot find ITE8872 INTA\n");
+		pr_info("parport_pc: cannot find ITE8872 INTA\n");
 		return 0;
 	}
 
@@ -2338,29 +2320,28 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 
 	switch (type) {
 	case 0x2:
-		printk(KERN_INFO "parport_pc: ITE8871 found (1P)\n");
+		pr_info("parport_pc: ITE8871 found (1P)\n");
 		ite8872set = 0x64200000;
 		break;
 	case 0xa:
-		printk(KERN_INFO "parport_pc: ITE8875 found (1P)\n");
+		pr_info("parport_pc: ITE8875 found (1P)\n");
 		ite8872set = 0x64200000;
 		break;
 	case 0xe:
-		printk(KERN_INFO "parport_pc: ITE8872 found (2S1P)\n");
+		pr_info("parport_pc: ITE8872 found (2S1P)\n");
 		ite8872set = 0x64e00000;
 		break;
 	case 0x6:
-		printk(KERN_INFO "parport_pc: ITE8873 found (1S)\n");
+		pr_info("parport_pc: ITE8873 found (1S)\n");
 		release_region(inta_addr[i], 32);
 		return 0;
 	case 0x8:
-		printk(KERN_INFO "parport_pc: ITE8874 found (2S)\n");
+		pr_info("parport_pc: ITE8874 found (2S)\n");
 		release_region(inta_addr[i], 32);
 		return 0;
 	default:
-		printk(KERN_INFO "parport_pc: unknown ITE887x\n");
-		printk(KERN_INFO "parport_pc: please mail 'lspci -nvv' "
-			"output to Rich.Liu@ite.com.tw\n");
+		pr_info("parport_pc: unknown ITE887x\n");
+		pr_info("parport_pc: please mail 'lspci -nvv' output to Rich.Liu@ite.com.tw\n");
 		release_region(inta_addr[i], 32);
 		return 0;
 	}
@@ -2395,9 +2376,8 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	release_region(inta_addr[i], 32);
 	if (parport_pc_probe_port(ite8872_lpt, ite8872_lpthi,
 				   irq, PARPORT_DMA_NONE, &pdev->dev, 0)) {
-		printk(KERN_INFO
-			"parport_pc: ITE 8872 parallel port: io=0x%X",
-								ite8872_lpt);
+		pr_info("parport_pc: ITE 8872 parallel port: io=0x%X",
+			ite8872_lpt);
 		if (irq != PARPORT_IRQ_NONE)
 			pr_cont(", irq=%d", irq);
 		pr_cont("\n");
@@ -2524,7 +2504,7 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	pci_write_config_byte(pdev, via->via_pci_superio_config_reg, tmp);
 
 	if (siofunc == VIA_FUNCTION_PARPORT_DISABLE) {
-		printk(KERN_INFO "parport_pc: VIA parallel port disabled in BIOS\n");
+		pr_info("parport_pc: VIA parallel port disabled in BIOS\n");
 		return 0;
 	}
 
@@ -2557,9 +2537,8 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	case 0x278:
 		port2 = 0x678; break;
 	default:
-		printk(KERN_INFO
-			"parport_pc: Weird VIA parport base 0x%X, ignoring\n",
-									port1);
+		pr_info("parport_pc: Weird VIA parport base 0x%X, ignoring\n",
+			port1);
 		return 0;
 	}
 
@@ -2578,8 +2557,7 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 
 	/* finally, do the probe with values obtained */
 	if (parport_pc_probe_port(port1, port2, irq, dma, &pdev->dev, 0)) {
-		printk(KERN_INFO
-			"parport_pc: VIA parallel port: io=0x%X", port1);
+		pr_info("parport_pc: VIA parallel port: io=0x%X", port1);
 		if (irq != PARPORT_IRQ_NONE)
 			pr_cont(", irq=%d", irq);
 		if (dma != PARPORT_DMA_NONE)
@@ -2588,7 +2566,7 @@ static int sio_via_probe(struct pci_dev *pdev, int autoirq, int autodma,
 		return 1;
 	}
 
-	printk(KERN_WARNING "parport_pc: Strange, can't probe VIA parallel port: io=0x%X, irq=%d, dma=%d\n",
+	pr_warn("parport_pc: Strange, can't probe VIA parallel port: io=0x%X, irq=%d, dma=%d\n",
 		port1, irq, dma);
 	return 0;
 }
@@ -3131,7 +3109,7 @@ static int __init parport_parse_param(const char *s, int *val,
 		if (ep != s)
 			*val = r;
 		else {
-			printk(KERN_ERR "parport: bad specifier `%s'\n", s);
+			pr_err("parport: bad specifier `%s'\n", s);
 			return -1;
 		}
 	}
@@ -3221,10 +3199,7 @@ static int __init parse_parport_params(void)
 				irqval[0] = val;
 				break;
 			default:
-				printk(KERN_WARNING
-					"parport_pc: irq specified "
-					"without base address.  Use 'io=' "
-					"to specify one\n");
+				pr_warn("parport_pc: irq specified without base address.  Use 'io=' to specify one\n");
 			}
 
 		if (dma[0] && !parport_parse_dma(dma[0], &val))
@@ -3234,10 +3209,7 @@ static int __init parse_parport_params(void)
 				dmaval[0] = val;
 				break;
 			default:
-				printk(KERN_WARNING
-					"parport_pc: dma specified "
-					"without base address.  Use 'io=' "
-					"to specify one\n");
+				pr_warn("parport_pc: dma specified without base address.  Use 'io=' to specify one\n");
 			}
 	}
 	return 0;
@@ -3276,12 +3248,12 @@ static int __init parport_setup(char *str)
 
 	val = simple_strtoul(str, &endptr, 0);
 	if (endptr == str) {
-		printk(KERN_WARNING "parport=%s not understood\n", str);
+		pr_warn("parport=%s not understood\n", str);
 		return 1;
 	}
 
 	if (parport_setup_ptr == PARPORT_PC_MAX_PORTS) {
-		printk(KERN_ERR "parport=%s ignored, too many ports\n", str);
+		pr_err("parport=%s ignored, too many ports\n", str);
 		return 1;
 	}
 
diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 8de329546b82..77671b7ad421 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -313,7 +313,7 @@ static int bpp_probe(struct platform_device *op)
 	value_tcr &= ~P_TCR_DIR;
 	sbus_writeb(value_tcr, &regs->p_tcr);
 
-	printk(KERN_INFO "%s: sunbpp at 0x%lx\n", p->name, p->base);
+	pr_info("%s: sunbpp at 0x%lx\n", p->name, p->base);
 
 	dev_set_drvdata(&op->dev, p);
 
diff --git a/drivers/parport/probe.c b/drivers/parport/probe.c
index e035174ba205..650206c71875 100644
--- a/drivers/parport/probe.c
+++ b/drivers/parport/probe.c
@@ -38,7 +38,7 @@ static void pretty_print(struct parport *port, int device)
 {
 	struct parport_device_info *info = &port->probe_info[device + 1];
 
-	printk(KERN_INFO "%s", port->name);
+	pr_info("%s", port->name);
 
 	if (device >= 0)
 		printk (" (addr %d)", device);
@@ -58,7 +58,7 @@ static void parse_data(struct parport *port, int device, char *str)
 	struct parport_device_info *info = &port->probe_info[device + 1];
 
 	if (!txt) {
-		printk(KERN_WARNING "%s probe: memory squeeze\n", port->name);
+		pr_warn("%s probe: memory squeeze\n", port->name);
 		return;
 	}
 	strcpy(txt, str);
@@ -98,7 +98,8 @@ static void parse_data(struct parport *port, int device, char *str)
 						goto rock_on;
 					}
 				}
-				printk(KERN_WARNING "%s probe: warning, class '%s' not understood.\n", port->name, sep);
+				pr_warn("%s probe: warning, class '%s' not understood\n",
+					port->name, sep);
 				info->class = PARPORT_CLASS_OTHER;
 			} else if (!strcmp(p, "CMD") ||
 				   !strcmp(p, "COMMAND SET")) {
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 48804049d697..595e23e6859b 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -51,12 +51,12 @@ static int do_active_device(struct ctl_table *table, int write,
 	
 	for (dev = port->devices; dev ; dev = dev->next) {
 		if(dev == port->cad) {
-			len += sprintf(buffer, "%s\n", dev->name);
+			len += snprintf(buffer, sizeof(buffer), "%s\n", dev->name);
 		}
 	}
 
 	if(!len) {
-		len += sprintf(buffer, "%s\n", "none");
+		len += snprintf(buffer, sizeof(buffer), "%s\n", "none");
 	}
 
 	if (len > *lenp)
@@ -87,19 +87,19 @@ static int do_autoprobe(struct ctl_table *table, int write,
 	}
 	
 	if ((str = info->class_name) != NULL)
-		len += sprintf (buffer + len, "CLASS:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "CLASS:%s;\n", str);
 
 	if ((str = info->model) != NULL)
-		len += sprintf (buffer + len, "MODEL:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "MODEL:%s;\n", str);
 
 	if ((str = info->mfr) != NULL)
-		len += sprintf (buffer + len, "MANUFACTURER:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "MANUFACTURER:%s;\n", str);
 
 	if ((str = info->description) != NULL)
-		len += sprintf (buffer + len, "DESCRIPTION:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "DESCRIPTION:%s;\n", str);
 
 	if ((str = info->cmdset) != NULL)
-		len += sprintf (buffer + len, "COMMAND SET:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "COMMAND SET:%s;\n", str);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 				 size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[64];
 	int len = 0;
 
 	if (*ppos) {
@@ -128,7 +128,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += sprintf (buffer, "%lu\t%lu\n", port->base, port->base_hi);
+	len += snprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -156,7 +156,7 @@ static int do_hardware_irq(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += sprintf (buffer, "%d\n", port->irq);
+	len += snprintf (buffer, sizeof(buffer), "%d\n", port->irq);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -184,7 +184,7 @@ static int do_hardware_dma(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += sprintf (buffer, "%d\n", port->dma);
+	len += snprintf (buffer, sizeof(buffer), "%d\n", port->dma);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -213,7 +213,11 @@ static int do_hardware_modes(struct ctl_table *table, int write,
 		return -EACCES;
 
 	{
-#define printmode(x) {if(port->modes&PARPORT_MODE_##x){len+=sprintf(buffer+len,"%s%s",f?",":"",#x);f++;}}
+#define printmode(x)							\
+do {									\
+	if (port->modes & PARPORT_MODE_##x)				\
+		len += snprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
+} while (0)
 		int f = 0;
 		printmode(PCSPP);
 		printmode(TRISTATE);
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 15c81cffd2de..fc2930fb9bee 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -555,8 +555,8 @@ void parport_announce_port(struct parport *port)
 #endif
 
 	if (!port->dev)
-		printk(KERN_WARNING "%s: fix this legacy no-device port driver!\n",
-		       port->name);
+		pr_warn("%s: fix this legacy no-device port driver!\n",
+			port->name);
 
 	parport_proc_register(port);
 	mutex_lock(&registration_lock);
@@ -728,7 +728,8 @@ parport_register_device(struct parport *port, const char *name,
 
 	if (flags & PARPORT_DEV_LURK) {
 		if (!pf || !kf) {
-			printk(KERN_INFO "%s: refused to register lurking device (%s) without callbacks\n", port->name, name);
+			pr_info("%s: refused to register lurking device (%s) without callbacks\n",
+				port->name, name);
 			return NULL;
 		}
 	}
@@ -997,7 +998,7 @@ void parport_unregister_device(struct pardevice *dev)
 
 #ifdef PARPORT_PARANOID
 	if (!dev) {
-		printk(KERN_ERR "parport_unregister_device: passed NULL\n");
+		pr_err("%s: passed NULL\n", __func__);
 		return;
 	}
 #endif
@@ -1138,8 +1139,7 @@ int parport_claim(struct pardevice *dev)
 	unsigned long flags;
 
 	if (port->cad == dev) {
-		printk(KERN_INFO "%s: %s already owner\n",
-		       dev->port->name,dev->name);
+		pr_info("%s: %s already owner\n", dev->port->name, dev->name);
 		return 0;
 	}
 
@@ -1159,9 +1159,8 @@ int parport_claim(struct pardevice *dev)
 			 * I think we'll actually deadlock rather than
 			 * get here, but just in case..
 			 */
-			printk(KERN_WARNING
-			       "%s: %s released port when preempted!\n",
-			       port->name, oldcad->name);
+			pr_warn("%s: %s released port when preempted!\n",
+				port->name, oldcad->name);
 			if (port->cad)
 				goto blocked;
 		}
@@ -1321,8 +1320,8 @@ void parport_release(struct pardevice *dev)
 	write_lock_irqsave(&port->cad_lock, flags);
 	if (port->cad != dev) {
 		write_unlock_irqrestore(&port->cad_lock, flags);
-		printk(KERN_WARNING "%s: %s tried to release parport when not owner\n",
-		       port->name, dev->name);
+		pr_warn("%s: %s tried to release parport when not owner\n",
+			port->name, dev->name);
 		return;
 	}
 
@@ -1362,7 +1361,8 @@ void parport_release(struct pardevice *dev)
 			if (dev->port->cad) /* racy but no matter */
 				return;
 		} else {
-			printk(KERN_ERR "%s: don't know how to wake %s\n", port->name, pd->name);
+			pr_err("%s: don't know how to wake %s\n",
+			       port->name, pd->name);
 		}
 	}
 
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f5f201bfc814..8adffefbee97 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -650,8 +650,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 		   PCI_CAPABILITY_LIST) {
 		/* ROM BARs are unimplemented */
 		*val = 0;
-	} else if (where >= PCI_INTERRUPT_LINE && where + size <=
-		   PCI_INTERRUPT_PIN) {
+	} else if ((where >= PCI_INTERRUPT_LINE && where + size <= PCI_INTERRUPT_PIN) ||
+		   (where >= PCI_INTERRUPT_PIN && where + size <= PCI_MIN_GNT)) {
 		/*
 		 * Interrupt Line and Interrupt PIN are hard-wired to zero
 		 * because this front-end only supports message-signaled
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index b047437605cb..6ab7ca0b9bf9 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -84,7 +84,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
-								     "mgmt-sticky");
+								"mgmt-sticky");
 	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
 		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
 			dev_err(dev, "missing mgmt-sticky reset property in node\n");
@@ -120,11 +120,11 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	if (rockchip->is_rc) {
-		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
-		if (IS_ERR(rockchip->ep_gpio)) {
-			dev_err(dev, "missing ep-gpios property in node\n");
-			return PTR_ERR(rockchip->ep_gpio);
-		}
+		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
+							    GPIOD_OUT_LOW);
+		if (IS_ERR(rockchip->ep_gpio))
+			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
+					     "failed to get ep GPIO\n");
 	}
 
 	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 87c8190de622..7f866c3f036f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -774,6 +774,8 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 static resource_size_t calculate_iosize(resource_size_t size,
 		resource_size_t min_size,
 		resource_size_t size1,
+		resource_size_t add_size,
+		resource_size_t children_add_size,
 		resource_size_t old_size,
 		resource_size_t align)
 {
@@ -786,15 +788,18 @@ static resource_size_t calculate_iosize(resource_size_t size,
 #if defined(CONFIG_ISA) || defined(CONFIG_EISA)
 	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
-	size = ALIGN(size + size1, align);
+	size = size + size1;
 	if (size < old_size)
 		size = old_size;
+
+	size = ALIGN(max(size, add_size) + children_add_size, align);
 	return size;
 }
 
 static resource_size_t calculate_memsize(resource_size_t size,
 		resource_size_t min_size,
-		resource_size_t size1,
+		resource_size_t add_size,
+		resource_size_t children_add_size,
 		resource_size_t old_size,
 		resource_size_t align)
 {
@@ -802,10 +807,9 @@ static resource_size_t calculate_memsize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
-	if (size < old_size)
-		size = old_size;
-	size = ALIGN(size + size1, align);
-	return size;
+
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
@@ -893,12 +897,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		}
 	}
 
-	size0 = calculate_iosize(size, min_size, size1,
+	size0 = calculate_iosize(size, min_size, size1, 0, 0,
 			resource_size(b_res), min_align);
-	if (children_add_size > add_size)
-		add_size = children_add_size;
-	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
-		calculate_iosize(size, min_size, add_size + size1,
+	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
+		calculate_iosize(size, min_size, size1, add_size, children_add_size,
 			resource_size(b_res), min_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
@@ -1042,12 +1044,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	min_align = calculate_mem_align(aligns, max_order);
 	min_align = max(min_align, window_alignment(bus, b_res->flags));
-	size0 = calculate_memsize(size, min_size, 0, resource_size(b_res), min_align);
+	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
 	add_align = max(min_align, add_align);
-	if (children_add_size > add_size)
-		add_size = children_add_size;
-	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
-		calculate_memsize(size, min_size, add_size,
+	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
+		calculate_memsize(size, min_size, add_size, children_add_size,
 				resource_size(b_res), add_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 97b1fa3a5e78..8c52bfac1cc2 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1992,6 +1992,14 @@ pinctrl_init_controller(struct pinctrl_desc *pctldesc, struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static void pinctrl_uninit_controller(struct pinctrl_dev *pctldev, struct pinctrl_desc *pctldesc)
+{
+	pinctrl_free_pindescs(pctldev, pctldesc->pins,
+			      pctldesc->npins);
+	mutex_destroy(&pctldev->mutex);
+	kfree(pctldev);
+}
+
 static int pinctrl_claim_hogs(struct pinctrl_dev *pctldev)
 {
 	pctldev->p = create_pinctrl(pctldev->dev, pctldev);
@@ -2072,8 +2080,10 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
 		return pctldev;
 
 	error = pinctrl_enable(pctldev);
-	if (error)
+	if (error) {
+		pinctrl_uninit_controller(pctldev, pctldesc);
 		return ERR_PTR(error);
+	}
 
 	return pctldev;
 
diff --git a/drivers/pinctrl/freescale/pinctrl-mxs.c b/drivers/pinctrl/freescale/pinctrl-mxs.c
index a612e46ca51c..c48b6fb5e8fe 100644
--- a/drivers/pinctrl/freescale/pinctrl-mxs.c
+++ b/drivers/pinctrl/freescale/pinctrl-mxs.c
@@ -405,8 +405,8 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	int ret;
 	u32 val;
 
-	child = of_get_next_child(np, NULL);
-	if (!child) {
+	val = of_get_child_count(np);
+	if (val == 0) {
 		dev_err(&pdev->dev, "no group is defined\n");
 		return -ENOENT;
 	}
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 4143cafbf7e7..3699843e9a6e 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1311,7 +1311,6 @@ static void pcs_irq_free(struct pcs_device *pcs)
 static void pcs_free_resources(struct pcs_device *pcs)
 {
 	pcs_irq_free(pcs);
-	pinctrl_unregister(pcs->pctl);
 
 #if IS_BUILTIN(CONFIG_PINCTRL_SINGLE)
 	if (pcs->missing_nr_pinctrl_cells)
@@ -1864,7 +1863,7 @@ static int pcs_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto free;
 
-	ret = pinctrl_register_and_init(&pcs->desc, pcs->dev, pcs, &pcs->pctl);
+	ret = devm_pinctrl_register_and_init(pcs->dev, &pcs->desc, pcs, &pcs->pctl);
 	if (ret) {
 		dev_err(pcs->dev, "could not register single pinctrl driver\n");
 		goto free;
@@ -1897,8 +1896,10 @@ static int pcs_probe(struct platform_device *pdev)
 
 	dev_info(pcs->dev, "%i pins, size %u\n", pcs->desc.npins, pcs->size);
 
-	return pinctrl_enable(pcs->pctl);
+	if (pinctrl_enable(pcs->pctl))
+		goto free;
 
+	return 0;
 free:
 	pcs_free_resources(pcs);
 
diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index 4eda888b4d04..e86b765141a6 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -881,7 +881,7 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 	iod->desc.name = dev_name(dev);
 	iod->desc.owner = THIS_MODULE;
 
-	ret = pinctrl_register_and_init(&iod->desc, dev, iod, &iod->pctl);
+	ret = devm_pinctrl_register_and_init(dev, &iod->desc, iod, &iod->pctl);
 	if (ret) {
 		dev_err(dev, "Failed to register pinctrl\n");
 		goto exit_out;
@@ -889,7 +889,11 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iod);
 
-	return pinctrl_enable(iod->pctl);
+	ret = pinctrl_enable(iod->pctl);
+	if (ret)
+		goto exit_out;
+
+	return 0;
 
 exit_out:
 	of_node_put(np);
@@ -906,12 +910,6 @@ static int ti_iodelay_remove(struct platform_device *pdev)
 {
 	struct ti_iodelay_device *iod = platform_get_drvdata(pdev);
 
-	if (!iod)
-		return 0;
-
-	if (iod->pctl)
-		pinctrl_unregister(iod->pctl);
-
 	ti_iodelay_pinconf_deinit_dev(iod);
 
 	/* Expect other allocations to be freed by devm */
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index c62ee8e610a0..5aed088371a7 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -292,6 +292,7 @@ static int ec_read_version_supported(struct cros_ec_dev *ec)
 	if (!msg)
 		return 0;
 
+	msg->version = 1;
 	msg->command = EC_CMD_GET_CMD_VERSIONS + ec->cmd_offset;
 	msg->outsize = sizeof(*params);
 	msg->insize = sizeof(*response);
diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index 98128374d710..7e8cb7d550da 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -164,6 +164,9 @@ static int __init loongson_hwmon_init(void)
 		goto fail_hwmon_device_register;
 	}
 
+	if (!csr_temp_enable && !loongson_chiptemp[0])
+		return -ENODEV;
+
 	nr_packages = loongson_sysconf.nr_cpus /
 		loongson_sysconf.cores_per_package;
 
diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 84106a9836c8..f6644afcbe86 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -175,18 +175,18 @@ static inline int axp288_charger_set_cv(struct axp288_chrg_info *info, int cv)
 	u8 reg_val;
 	int ret;
 
-	if (cv <= CV_4100MV) {
-		reg_val = CHRG_CCCV_CV_4100MV;
-		cv = CV_4100MV;
-	} else if (cv <= CV_4150MV) {
-		reg_val = CHRG_CCCV_CV_4150MV;
-		cv = CV_4150MV;
-	} else if (cv <= CV_4200MV) {
+	if (cv >= CV_4350MV) {
+		reg_val = CHRG_CCCV_CV_4350MV;
+		cv = CV_4350MV;
+	} else if (cv >= CV_4200MV) {
 		reg_val = CHRG_CCCV_CV_4200MV;
 		cv = CV_4200MV;
+	} else if (cv >= CV_4150MV) {
+		reg_val = CHRG_CCCV_CV_4150MV;
+		cv = CV_4150MV;
 	} else {
-		reg_val = CHRG_CCCV_CV_4350MV;
-		cv = CV_4350MV;
+		reg_val = CHRG_CCCV_CV_4100MV;
+		cv = CV_4100MV;
 	}
 
 	reg_val = reg_val << CHRG_CCCV_CV_BIT_POS;
@@ -378,8 +378,8 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
 			dev_warn(&info->pdev->dev, "set charge current failed\n");
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		scaled_val = min(val->intval, info->max_cv);
-		scaled_val = DIV_ROUND_CLOSEST(scaled_val, 1000);
+		scaled_val = DIV_ROUND_CLOSEST(val->intval, 1000);
+		scaled_val = min(scaled_val, info->max_cv);
 		ret = axp288_charger_set_cv(info, scaled_val);
 		if (ret < 0)
 			dev_warn(&info->pdev->dev, "set charge voltage failed\n");
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index ee7197b8e4ef..5325e804ca24 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -451,8 +451,9 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	enabled = pwm->state.enabled;
 
-	if (enabled && !state->enabled) {
-		stm32_pwm_disable(priv, pwm->hwpwm);
+	if (!state->enabled) {
+		if (enabled)
+			stm32_pwm_disable(priv, pwm->hwpwm);
 		return 0;
 	}
 
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 54c07fd3f204..7597f09a3455 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -289,6 +289,11 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		struct resource res;
 
 		node = of_parse_phandle(np, "memory-region", a);
+		if (!node)
+			continue;
+		/* Not map vdevbuffer, vdevring region */
+		if (!strncmp(node->name, "vdev", strlen("vdev")))
+			continue;
 		err = of_address_to_resource(node, 0, &res);
 		if (err) {
 			dev_err(dev, "unable to resolve memory region\n");
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 8545f0da57fe..245220c77188 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -601,11 +601,10 @@ static int cmos_nvram_read(void *priv, unsigned int off, void *val,
 			   size_t count)
 {
 	unsigned char *buf = val;
-	int	retval;
 
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		if (off < 128)
 			*buf++ = CMOS_READ(off);
 		else if (can_bank2)
@@ -615,7 +614,7 @@ static int cmos_nvram_read(void *priv, unsigned int off, void *val,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 static int cmos_nvram_write(void *priv, unsigned int off, void *val,
@@ -623,7 +622,6 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 {
 	struct cmos_rtc	*cmos = priv;
 	unsigned char	*buf = val;
-	int		retval;
 
 	/* NOTE:  on at least PCs and Ataris, the boot firmware uses a
 	 * checksum on part of the NVRAM data.  That's currently ignored
@@ -632,7 +630,7 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 	 */
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		/* don't trash RTC registers */
 		if (off == cmos->day_alrm
 				|| off == cmos->mon_alrm
@@ -647,7 +645,7 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 /*----------------------------------------------------------------*/
diff --git a/drivers/s390/char/sclp_sd.c b/drivers/s390/char/sclp_sd.c
index 1e244f78f192..64581433c334 100644
--- a/drivers/s390/char/sclp_sd.c
+++ b/drivers/s390/char/sclp_sd.c
@@ -319,8 +319,14 @@ static int sclp_sd_store_data(struct sclp_sd_data *result, u8 di)
 			  &esize);
 	if (rc) {
 		/* Cancel running request if interrupted */
-		if (rc == -ERESTARTSYS)
-			sclp_sd_sync(page, SD_EQ_HALT, di, 0, 0, NULL, NULL);
+		if (rc == -ERESTARTSYS) {
+			if (sclp_sd_sync(page, SD_EQ_HALT, di, 0, 0, NULL, NULL)) {
+				pr_warn("Could not stop Store Data request - leaking at least %zu bytes\n",
+					(size_t)dsize * PAGE_SIZE);
+				data = NULL;
+				asce = 0;
+			}
+		}
 		vfree(data);
 		goto out;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 430dfe3d5416..10b763738064 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -302,7 +302,7 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 		    "request_sg_cnt=%x reply_sg_cnt=%x.\n",
 		    bsg_job->request_payload.sg_cnt,
 		    bsg_job->reply_payload.sg_cnt);
-		rval = -EPERM;
+		rval = -ENOBUFS;
 		goto done;
 	}
 
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index 516fccdbcebd..7b53a6f104f5 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -161,7 +161,7 @@ qla24xx_disable_vp(scsi_qla_host_t *vha)
 	atomic_set(&vha->loop_state, LOOP_DOWN);
 	atomic_set(&vha->loop_down_timer, LOOP_DOWN_TIME);
 	list_for_each_entry(fcport, &vha->vp_fcports, list)
-		fcport->logout_on_delete = 0;
+		fcport->logout_on_delete = 1;
 
 	qla2x00_mark_all_devices_lost(vha, 0);
 
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 35762d29b04b..fb42d9ff9bb1 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -30,7 +30,10 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 		return 0;
 	}
 
-	if (!vha->nvme_local_port && qla_nvme_register_hba(vha))
+	if (qla_nvme_register_hba(vha))
+		return 0;
+
+	if (!vha->nvme_local_port)
 		return 0;
 
 	if (!(fcport->nvme_prli_service_param &
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 5426bfe522d2..2f7d7b680eea 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3592,11 +3592,16 @@ static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
 			min_sleep_time_us =
 				MIN_DELAY_BEFORE_DME_CMDS_US - delta;
 		else
-			return; /* no more delay required */
+			min_sleep_time_us = 0; /* no more delay required */
 	}
 
-	/* allow sleep for extra 50us if needed */
-	usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	if (min_sleep_time_us > 0) {
+		/* allow sleep for extra 50us if needed */
+		usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	}
+
+	/* update the last_dme_cmd_tstamp */
+	hba->last_dme_cmd_tstamp = ktime_get();
 }
 
 /**
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 51670976faa3..695034e076c5 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,6 +3,7 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2018 NXP Semiconductors
 
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -54,6 +55,7 @@
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
+#define CFGR1_PINCFG	(BIT(24)|BIT(25))
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
@@ -65,8 +67,6 @@
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
 
-static int clkdivs[] = {1, 2, 4, 8, 16, 32, 64, 128};
-
 struct lpspi_config {
 	u8 bpw;
 	u8 chip_select;
@@ -78,7 +78,9 @@ struct lpspi_config {
 struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
-	struct clk *clk;
+	struct clk *clk_ipg;
+	struct clk *clk_per;
+	bool is_slave;
 
 	void *rx_buf;
 	const void *tx_buf;
@@ -86,11 +88,14 @@ struct fsl_lpspi_data {
 	void (*rx)(struct fsl_lpspi_data *);
 
 	u32 remain;
+	u8 watermark;
 	u8 txfifosize;
 	u8 rxfifosize;
 
 	struct lpspi_config config;
 	struct completion xfer_done;
+
+	bool slave_aborted;
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
@@ -137,18 +142,32 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *fsl_lpspi,
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
 
-static int lpspi_prepare_xfer_hardware(struct spi_master *master)
+static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
+	int ret;
+
+	ret = clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret)
+		return ret;
 
-	return clk_prepare_enable(fsl_lpspi->clk);
+	ret = clk_prepare_enable(fsl_lpspi->clk_per);
+	if (ret) {
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
+		return ret;
+	}
+
+	return 0;
 }
 
-static int lpspi_unprepare_xfer_hardware(struct spi_master *master)
+static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
 
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
 
 	return 0;
 }
@@ -203,21 +222,22 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
 	u32 temp = 0;
 
 	temp |= fsl_lpspi->config.bpw - 1;
-	temp |= fsl_lpspi->config.prescale << 27;
 	temp |= (fsl_lpspi->config.mode & 0x3) << 30;
-	temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
-
-	/*
-	 * Set TCR_CONT will keep SS asserted after current transfer.
-	 * For the first transfer, clear TCR_CONTC to assert SS.
-	 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
-	 */
-	temp |= TCR_CONT;
-	if (is_first_xfer)
-		temp &= ~TCR_CONTC;
-	else
-		temp |= TCR_CONTC;
-
+	if (!fsl_lpspi->is_slave) {
+		temp |= fsl_lpspi->config.prescale << 27;
+		temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
+
+		/*
+		 * Set TCR_CONT will keep SS asserted after current transfer.
+		 * For the first transfer, clear TCR_CONTC to assert SS.
+		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
+		 */
+		temp |= TCR_CONT;
+		if (is_first_xfer)
+			temp &= ~TCR_CONTC;
+		else
+			temp |= TCR_CONTC;
+	}
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
 
 	dev_dbg(fsl_lpspi->dev, "TCR=0x%x\n", temp);
@@ -227,7 +247,7 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp;
 
-	temp = fsl_lpspi->txfifosize >> 1 | (fsl_lpspi->rxfifosize >> 1) << 16;
+	temp = fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;
 
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
 
@@ -237,23 +257,32 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config = fsl_lpspi->config;
-	unsigned int perclk_rate, scldiv;
+	unsigned int perclk_rate, scldiv, div;
 	u8 prescale;
 
-	perclk_rate = clk_get_rate(fsl_lpspi->clk);
+	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
+
+	if (config.speed_hz > perclk_rate / 2) {
+		dev_err(fsl_lpspi->dev,
+		      "per-clk should be at least two times of transfer speed");
+		return -EINVAL;
+	}
+
+	div = DIV_ROUND_UP(perclk_rate, config.speed_hz);
+
 	for (prescale = 0; prescale < 8; prescale++) {
-		scldiv = perclk_rate /
-			 (clkdivs[prescale] * config.speed_hz) - 2;
+		scldiv = div / (1 << prescale) - 2;
 		if (scldiv < 256) {
 			fsl_lpspi->config.prescale = prescale;
 			break;
 		}
 	}
 
-	if (prescale == 8 && scldiv >= 256)
+	if (scldiv >= 256)
 		return -EINVAL;
 
-	writel(scldiv, fsl_lpspi->base + IMX7ULP_CCR);
+	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
+					fsl_lpspi->base + IMX7ULP_CCR);
 
 	dev_dbg(fsl_lpspi->dev, "perclk=%d, speed=%d, prescale =%d, scldiv=%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);
@@ -270,13 +299,18 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
 	writel(0, fsl_lpspi->base + IMX7ULP_CR);
 
-	ret = fsl_lpspi_set_bitrate(fsl_lpspi);
-	if (ret)
-		return ret;
+	if (!fsl_lpspi->is_slave) {
+		ret = fsl_lpspi_set_bitrate(fsl_lpspi);
+		if (ret)
+			return ret;
+	}
 
 	fsl_lpspi_set_watermark(fsl_lpspi);
 
-	temp = CFGR1_PCSCFG | CFGR1_MASTER;
+	if (!fsl_lpspi->is_slave)
+		temp = CFGR1_MASTER;
+	else
+		temp = CFGR1_PINCFG;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
 		temp |= CFGR1_PCSPOL;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
@@ -288,10 +322,11 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 	return 0;
 }
 
-static void fsl_lpspi_setup_transfer(struct spi_device *spi,
+static int fsl_lpspi_setup_transfer(struct spi_device *spi,
 				     struct spi_transfer *t)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(spi->master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(spi->controller);
 
 	fsl_lpspi->config.mode = spi->mode;
 	fsl_lpspi->config.bpw = t ? t->bits_per_word : spi->bits_per_word;
@@ -315,14 +350,51 @@ static void fsl_lpspi_setup_transfer(struct spi_device *spi,
 		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
 	}
 
-	fsl_lpspi_config(fsl_lpspi);
+	if (t->len <= fsl_lpspi->txfifosize)
+		fsl_lpspi->watermark = t->len;
+	else
+		fsl_lpspi->watermark = fsl_lpspi->txfifosize;
+
+	return fsl_lpspi_config(fsl_lpspi);
 }
 
-static int fsl_lpspi_transfer_one(struct spi_master *master,
+static int fsl_lpspi_slave_abort(struct spi_controller *controller)
+{
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
+
+	fsl_lpspi->slave_aborted = true;
+	complete(&fsl_lpspi->xfer_done);
+	return 0;
+}
+
+static int fsl_lpspi_wait_for_completion(struct spi_controller *controller)
+{
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
+
+	if (fsl_lpspi->is_slave) {
+		if (wait_for_completion_interruptible(&fsl_lpspi->xfer_done) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev, "interrupted\n");
+			return -EINTR;
+		}
+	} else {
+		if (!wait_for_completion_timeout(&fsl_lpspi->xfer_done, HZ)) {
+			dev_dbg(fsl_lpspi->dev, "wait for completion timeout\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
 	int ret;
 
 	fsl_lpspi->tx_buf = t->tx_buf;
@@ -330,13 +402,13 @@ static int fsl_lpspi_transfer_one(struct spi_master *master,
 	fsl_lpspi->remain = t->len;
 
 	reinit_completion(&fsl_lpspi->xfer_done);
+	fsl_lpspi->slave_aborted = false;
+
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
 
-	ret = wait_for_completion_timeout(&fsl_lpspi->xfer_done, HZ);
-	if (!ret) {
-		dev_dbg(fsl_lpspi->dev, "wait for completion timeout\n");
-		return -ETIMEDOUT;
-	}
+	ret = fsl_lpspi_wait_for_completion(controller);
+	if (ret)
+		return ret;
 
 	ret = fsl_lpspi_txfifo_empty(fsl_lpspi);
 	if (ret)
@@ -347,10 +419,11 @@ static int fsl_lpspi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
-static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
+static int fsl_lpspi_transfer_one_msg(struct spi_controller *controller,
 				      struct spi_message *msg)
 {
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
 	struct spi_device *spi = msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer = true;
@@ -361,12 +434,15 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
 	msg->actual_length = 0;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		fsl_lpspi_setup_transfer(spi, xfer);
+		ret = fsl_lpspi_setup_transfer(spi, xfer);
+		if (ret < 0)
+			goto complete;
+
 		fsl_lpspi_set_cmd(fsl_lpspi, is_first_xfer);
 
 		is_first_xfer = false;
 
-		ret = fsl_lpspi_transfer_one(master, spi, xfer);
+		ret = fsl_lpspi_transfer_one(controller, spi, xfer);
 		if (ret < 0)
 			goto complete;
 
@@ -374,13 +450,15 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
 	}
 
 complete:
-	/* de-assert SS, then finalize current message */
-	temp = readl(fsl_lpspi->base + IMX7ULP_TCR);
-	temp &= ~TCR_CONTC;
-	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+	if (!fsl_lpspi->is_slave) {
+		/* de-assert SS, then finalize current message */
+		temp = readl(fsl_lpspi->base + IMX7ULP_TCR);
+		temp &= ~TCR_CONTC;
+		writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+	}
 
 	msg->status = ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(controller);
 
 	return ret;
 }
@@ -410,30 +488,39 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
 	struct fsl_lpspi_data *fsl_lpspi;
-	struct spi_master *master;
+	struct spi_controller *controller;
 	struct resource *res;
 	int ret, irq;
 	u32 temp;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_lpspi_data));
-	if (!master)
+	if (of_property_read_bool((&pdev->dev)->of_node, "spi-slave"))
+		controller = spi_alloc_slave(&pdev->dev,
+					sizeof(struct fsl_lpspi_data));
+	else
+		controller = spi_alloc_master(&pdev->dev,
+					sizeof(struct fsl_lpspi_data));
+
+	if (!controller)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, controller);
 
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
-	master->bus_num = pdev->id;
+	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
+	controller->bus_num = pdev->id;
 
-	fsl_lpspi = spi_master_get_devdata(master);
+	fsl_lpspi = spi_controller_get_devdata(controller);
 	fsl_lpspi->dev = &pdev->dev;
-
-	master->transfer_one_message = fsl_lpspi_transfer_one_msg;
-	master->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
-	master->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
-	master->dev.of_node = pdev->dev.of_node;
-	master->bus_num = pdev->id;
+	fsl_lpspi->is_slave = of_property_read_bool((&pdev->dev)->of_node,
+						    "spi-slave");
+
+	controller->transfer_one_message = fsl_lpspi_transfer_one_msg;
+	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
+	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
+	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->dev.of_node = pdev->dev.of_node;
+	controller->bus_num = pdev->id;
+	controller->slave_abort = fsl_lpspi_slave_abort;
 
 	init_completion(&fsl_lpspi->xfer_done);
 
@@ -441,60 +528,78 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(fsl_lpspi->base)) {
 		ret = PTR_ERR(fsl_lpspi->base);
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_master_put;
+		goto out_controller_put;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, 0,
 			       dev_name(&pdev->dev), fsl_lpspi);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
-		goto out_master_put;
+		goto out_controller_put;
+	}
+
+	fsl_lpspi->clk_per = devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(fsl_lpspi->clk_per)) {
+		ret = PTR_ERR(fsl_lpspi->clk_per);
+		goto out_controller_put;
 	}
 
-	fsl_lpspi->clk = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(fsl_lpspi->clk)) {
-		ret = PTR_ERR(fsl_lpspi->clk);
-		goto out_master_put;
+	fsl_lpspi->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fsl_lpspi->clk_ipg)) {
+		ret = PTR_ERR(fsl_lpspi->clk_ipg);
+		goto out_controller_put;
+	}
+
+	ret = clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"can't enable lpspi ipg clock, ret=%d\n", ret);
+		goto out_controller_put;
 	}
 
-	ret = clk_prepare_enable(fsl_lpspi->clk);
+	ret = clk_prepare_enable(fsl_lpspi->clk_per);
 	if (ret) {
-		dev_err(&pdev->dev, "can't enable lpspi clock, ret=%d\n", ret);
-		goto out_master_put;
+		dev_err(&pdev->dev,
+			"can't enable lpspi per clock, ret=%d\n", ret);
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
+		goto out_controller_put;
 	}
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
 	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
 
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
 
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_master error.\n");
-		goto out_master_put;
+		dev_err(&pdev->dev, "spi_register_controller error.\n");
+		goto out_controller_put;
 	}
 
 	return 0;
 
-out_master_put:
-	spi_master_put(master);
+out_controller_put:
+	spi_controller_put(controller);
 
 	return ret;
 }
 
 static int fsl_lpspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct spi_controller *controller = platform_get_drvdata(pdev);
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
 
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
 
 	return 0;
 }
@@ -509,6 +614,6 @@ static struct platform_driver fsl_lpspi_driver = {
 };
 module_platform_driver(fsl_lpspi_driver);
 
-MODULE_DESCRIPTION("LPSPI Master Controller driver");
+MODULE_DESCRIPTION("LPSPI Controller driver");
 MODULE_AUTHOR("Gao Pan <pandy.gao@nxp.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index eb1b95522c8f..148ae2882a63 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -857,6 +857,14 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	if (!(uport->flags & UPF_FIXED_PORT)) {
+		unsigned int uartclk = new_info->baud_base * 16;
+		/* check needs to be done here before other settings made */
+		if (uartclk == 0) {
+			retval = -EINVAL;
+			goto exit;
+		}
+	}
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index e51e223d0dc7..b0866e7de7c2 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -99,12 +99,10 @@ int usb_ep_enable(struct usb_ep *ep)
 		goto out;
 
 	/* UDC drivers can't handle endpoints with maxpacket size 0 */
-	if (usb_endpoint_maxp(ep->desc) == 0) {
-		/*
-		 * We should log an error message here, but we can't call
-		 * dev_err() because there's no way to find the gadget
-		 * given only ep.
-		 */
+	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
+		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
+			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
+
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/usb/serial/usb_debug.c b/drivers/usb/serial/usb_debug.c
index aaf4813e4971..406cb326e812 100644
--- a/drivers/usb/serial/usb_debug.c
+++ b/drivers/usb/serial/usb_debug.c
@@ -69,6 +69,11 @@ static void usb_debug_process_read_urb(struct urb *urb)
 	usb_serial_generic_process_read_urb(urb);
 }
 
+static void usb_debug_init_termios(struct tty_struct *tty)
+{
+	tty->termios.c_lflag &= ~(ECHO | ECHONL);
+}
+
 static struct usb_serial_driver debug_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
@@ -78,6 +83,7 @@ static struct usb_serial_driver debug_device = {
 	.num_ports =		1,
 	.bulk_out_size =	USB_DEBUG_MAX_PACKET_SIZE,
 	.break_ctl =		usb_debug_break_ctl,
+	.init_termios =		usb_debug_init_termios,
 	.process_read_urb =	usb_debug_process_read_urb,
 };
 
@@ -89,6 +95,7 @@ static struct usb_serial_driver dbc_device = {
 	.id_table =		dbc_id_table,
 	.num_ports =		1,
 	.break_ctl =		usb_debug_break_ctl,
+	.init_termios =		usb_debug_init_termios,
 	.process_read_urb =	usb_debug_process_read_urb,
 };
 
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 202dc76f7beb..b774fc4aef04 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -751,6 +751,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	 *
 	 */
 	if (usb_pipedevice(urb->pipe) == 0) {
+		struct usb_device *old;
 		__u8 type = usb_pipetype(urb->pipe);
 		struct usb_ctrlrequest *ctrlreq =
 			(struct usb_ctrlrequest *) urb->setup_packet;
@@ -761,14 +762,15 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 			goto no_need_xmit;
 		}
 
+		old = vdev->udev;
 		switch (ctrlreq->bRequest) {
 		case USB_REQ_SET_ADDRESS:
 			/* set_address may come when a device is reset */
 			dev_info(dev, "SetAddress Request (%d) to port %d\n",
 				 ctrlreq->wValue, vdev->rhport);
 
-			usb_put_dev(vdev->udev);
 			vdev->udev = usb_get_dev(urb->dev);
+			usb_put_dev(old);
 
 			spin_lock(&vdev->ud.lock);
 			vdev->ud.status = VDEV_ST_USED;
@@ -787,8 +789,8 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 				usbip_dbg_vhci_hc(
 					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
 
-			usb_put_dev(vdev->udev);
 			vdev->udev = usb_get_dev(urb->dev);
+			usb_put_dev(old);
 			goto out;
 
 		default:
@@ -1095,6 +1097,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 static void vhci_device_reset(struct usbip_device *ud)
 {
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
+	struct usb_device *old = vdev->udev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ud->lock, flags);
@@ -1102,8 +1105,8 @@ static void vhci_device_reset(struct usbip_device *ud)
 	vdev->speed  = 0;
 	vdev->devid  = 0;
 
-	usb_put_dev(vdev->udev);
 	vdev->udev = NULL;
+	usb_put_dev(old);
 
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index b623e9f3b4c4..88f577579259 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -787,6 +787,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
diff --git a/fs/exec.c b/fs/exec.c
index 7ada94402ec9..fb9430fb3f04 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1528,6 +1528,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	unsigned int mode;
 	kuid_t uid;
 	kgid_t gid;
+	int err;
 
 	/*
 	 * Since this can be called multiple times (via prepare_binprm),
@@ -1552,12 +1553,17 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
 
-	/* reload atomically mode/uid/gid now that lock held */
+	/* Atomically reload and check mode/uid/gid now that lock held. */
 	mode = inode->i_mode;
 	uid = inode->i_uid;
 	gid = inode->i_gid;
+	err = inode_permission(inode, MAY_EXEC);
 	inode_unlock(inode);
 
+	/* Did the exec bit vanish out from under us? Give up. */
+	if (err)
+		return;
+
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
 	if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
 		 !kgid_has_mapping(bprm->cred->user_ns, gid))
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5af5ad53e0ad..5dcc3cad5c7d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1850,8 +1850,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	if (max >= ac->ac_g_ex.fe_len && ac->ac_g_ex.fe_len == sbi->s_stripe) {
 		ext4_fsblk_t start;
 
-		start = ext4_group_first_block_no(ac->ac_sb, e4b->bd_group) +
-			ex.fe_start;
+		start = ext4_grp_offs_to_block(ac->ac_sb, &ex);
 		/* use do_div to get remainder (would be 64-bit modulo) */
 		if (do_div(start, sbi->s_stripe) == 0) {
 			ac->ac_found++;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d4441e481642..8594feea2d93 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -134,10 +134,11 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 
 		return bh;
 	}
-	if (!bh && (type == INDEX || type == DIRENT_HTREE)) {
+	/* The first directory block must not be a hole. */
+	if (!bh && (type == INDEX || type == DIRENT_HTREE || block == 0)) {
 		ext4_error_inode(inode, func, line, block,
-				 "Directory hole found for htree %s block",
-				 (type == INDEX) ? "index" : "leaf");
+				 "Directory hole found for htree %s block %u",
+				 (type == INDEX) ? "index" : "leaf", block);
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 	if (!bh)
@@ -1997,6 +1998,52 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	return 0;
 }
 
+static bool ext4_check_dx_root(struct inode *dir, struct dx_root *root)
+{
+	struct fake_dirent *fde;
+	const char *error_msg;
+	unsigned int rlen;
+	unsigned int blocksize = dir->i_sb->s_blocksize;
+	char *blockend = (char *)root + dir->i_sb->s_blocksize;
+
+	fde = &root->dot;
+	if (unlikely(fde->name_len != 1)) {
+		error_msg = "invalid name_len for '.'";
+		goto corrupted;
+	}
+	if (unlikely(strncmp(root->dot_name, ".", fde->name_len))) {
+		error_msg = "invalid name for '.'";
+		goto corrupted;
+	}
+	rlen = ext4_rec_len_from_disk(fde->rec_len, blocksize);
+	if (unlikely((char *)fde + rlen >= blockend)) {
+		error_msg = "invalid rec_len for '.'";
+		goto corrupted;
+	}
+
+	fde = &root->dotdot;
+	if (unlikely(fde->name_len != 2)) {
+		error_msg = "invalid name_len for '..'";
+		goto corrupted;
+	}
+	if (unlikely(strncmp(root->dotdot_name, "..", fde->name_len))) {
+		error_msg = "invalid name for '..'";
+		goto corrupted;
+	}
+	rlen = ext4_rec_len_from_disk(fde->rec_len, blocksize);
+	if (unlikely((char *)fde + rlen >= blockend)) {
+		error_msg = "invalid rec_len for '..'";
+		goto corrupted;
+	}
+
+	return true;
+
+corrupted:
+	EXT4_ERROR_INODE(dir, "Corrupt dir, %s, running e2fsck is recommended",
+			 error_msg);
+	return false;
+}
+
 /*
  * This converts a one block unindexed directory to a 3 block indexed
  * directory, and adds the dentry to the indexed directory.
@@ -2031,17 +2078,17 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 		brelse(bh);
 		return retval;
 	}
+
 	root = (struct dx_root *) bh->b_data;
+	if (!ext4_check_dx_root(dir, root)) {
+		brelse(bh);
+		return -EFSCORRUPTED;
+	}
 
 	/* The 0th block becomes the root, move the dirents out */
 	fde = &root->dotdot;
 	de = (struct ext4_dir_entry_2 *)((char *)fde +
 		ext4_rec_len_from_disk(fde->rec_len, blocksize));
-	if ((char *) de >= (((char *) root) + blocksize)) {
-		EXT4_ERROR_INODE(dir, "invalid rec_len for '..'");
-		brelse(bh);
-		return -EFSCORRUPTED;
-	}
 	len = ((char *) root) + (blocksize - csum_size) - (char *) de;
 
 	/* Allocate new block for the 0th block's dirents */
@@ -2804,10 +2851,7 @@ bool ext4_empty_dir(struct inode *inode)
 		EXT4_ERROR_INODE(inode, "invalid size");
 		return true;
 	}
-	/* The first directory block must not be a hole,
-	 * so treat it as DIRENT_HTREE
-	 */
-	bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
+	bh = ext4_read_dirblock(inode, 0, EITHER);
 	if (IS_ERR(bh))
 		return true;
 
@@ -3379,10 +3423,7 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 		struct ext4_dir_entry_2 *de;
 		unsigned int offset;
 
-		/* The first directory block must not be a hole, so
-		 * treat it as DIRENT_HTREE
-		 */
-		bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
+		bh = ext4_read_dirblock(inode, 0, EITHER);
 		if (IS_ERR(bh)) {
 			*retval = PTR_ERR(bh);
 			return NULL;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index dc42a8fba0d2..e9299f769dbf 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1420,6 +1420,12 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 			goto out;
 
 		memcpy(bh->b_data, buf, csize);
+		/*
+		 * Zero out block tail to avoid writing uninitialized memory
+		 * to disk.
+		 */
+		if (csize < blocksize)
+			memset(bh->b_data + csize, 0, blocksize - csize);
 		set_buffer_uptodate(bh);
 		ext4_handle_dirty_metadata(handle, ea_inode, bh);
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 15ff5d9b8c05..c3563fcaae5c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -25,6 +25,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (is_inode_flag_set(inode, FI_NEW_INODE))
 		return;
 
+	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+		return;
+
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
diff --git a/fs/file.c b/fs/file.c
index f5ba0e6f1a4c..dab2d6bfb7cb 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -879,6 +879,7 @@ __releases(&files->file_lock)
 	 * tables and this condition does not arise without those.
 	 */
 	fdt = files_fdtable(files);
+	fd = array_index_nospec(fd, fdt->max_fds);
 	tofree = fdt->fd[fd];
 	if (!tofree && fd_is_open(fd, fdt))
 		goto Ebusy;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index ee2ea5532e69..c58792cab2be 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -199,6 +199,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
 	HFS_I(inode)->fs_blocks = 0;
+	HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		HFS_SB(sb)->folder_count++;
@@ -274,6 +275,8 @@ void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 	for (count = 0, i = 0; i < 3; i++)
 		count += be16_to_cpu(ext[i].count);
 	HFS_I(inode)->first_blocks = count;
+	HFS_I(inode)->cached_start = 0;
+	HFS_I(inode)->cached_blocks = 0;
 
 	inode->i_size = HFS_I(inode)->phys_size = log_size;
 	HFS_I(inode)->fs_blocks = (log_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..901e83d65d20 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -25,19 +25,8 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 	fd->key = ptr + tree->max_key_len + 2;
 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
-	switch (tree->cnid) {
-	case HFSPLUS_CAT_CNID:
-		mutex_lock_nested(&tree->tree_lock, CATALOG_BTREE_MUTEX);
-		break;
-	case HFSPLUS_EXT_CNID:
-		mutex_lock_nested(&tree->tree_lock, EXTENTS_BTREE_MUTEX);
-		break;
-	case HFSPLUS_ATTR_CNID:
-		mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
-		break;
-	default:
-		BUG();
-	}
+	mutex_lock_nested(&tree->tree_lock,
+			hfsplus_btree_lock_class(tree));
 	return 0;
 }
 
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 7054a542689f..c95a2f0ed4a7 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -430,7 +430,8 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		hfsplus_free_extents(sb, ext_entry, total_blocks - start,
 				     total_blocks);
 		total_blocks = start;
-		mutex_lock(&fd.tree->tree_lock);
+		mutex_lock_nested(&fd.tree->tree_lock,
+			hfsplus_btree_lock_class(fd.tree));
 	} while (total_blocks > blocks);
 	hfs_find_exit(&fd);
 
@@ -592,7 +593,8 @@ void hfsplus_file_truncate(struct inode *inode)
 					     alloc_cnt, alloc_cnt - blk_cnt);
 			hfsplus_dump_extent(hip->first_extents);
 			hip->first_blocks = blk_cnt;
-			mutex_lock(&fd.tree->tree_lock);
+			mutex_lock_nested(&fd.tree->tree_lock,
+				hfsplus_btree_lock_class(fd.tree));
 			break;
 		}
 		res = __hfsplus_ext_cache_extent(&fd, inode, alloc_cnt);
@@ -606,7 +608,8 @@ void hfsplus_file_truncate(struct inode *inode)
 		hfsplus_free_extents(sb, hip->cached_extents,
 				     alloc_cnt - start, alloc_cnt - blk_cnt);
 		hfsplus_dump_extent(hip->cached_extents);
-		mutex_lock(&fd.tree->tree_lock);
+		mutex_lock_nested(&fd.tree->tree_lock,
+				hfsplus_btree_lock_class(fd.tree));
 		if (blk_cnt > start) {
 			hip->extent_state |= HFSPLUS_EXT_DIRTY;
 			break;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index db2e1c750199..e9b13f771990 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -537,6 +537,27 @@ int hfsplus_read_wrapper(struct super_block *sb);
 #define __hfsp_mt2ut(t)		(be32_to_cpu(t) - 2082844800U)
 #define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
 
+static inline enum hfsplus_btree_mutex_classes
+hfsplus_btree_lock_class(struct hfs_btree *tree)
+{
+	enum hfsplus_btree_mutex_classes class;
+
+	switch (tree->cnid) {
+	case HFSPLUS_CAT_CNID:
+		class = CATALOG_BTREE_MUTEX;
+		break;
+	case HFSPLUS_EXT_CNID:
+		class = EXTENTS_BTREE_MUTEX;
+		break;
+	case HFSPLUS_ATTR_CNID:
+		class = ATTR_BTREE_MUTEX;
+		break;
+	default:
+		BUG();
+	}
+	return class;
+}
+
 /* compatibility */
 #define hfsp_mt2ut(t)		(struct timespec){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 629928b19e48..08cff80f8c29 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -430,6 +430,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		jbd_lock_bh_state(bh_in);
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 00800c8c6f07..9893cb6b8a75 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -305,7 +305,7 @@ int diSync(struct inode *ipimap)
 int diRead(struct inode *ip)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
-	int iagno, ino, extno, rc;
+	int iagno, ino, extno, rc, agno;
 	struct inode *ipimap;
 	struct dinode *dp;
 	struct iag *iagp;
@@ -354,8 +354,11 @@ int diRead(struct inode *ip)
 
 	/* get the ag for the iag */
 	agstart = le64_to_cpu(iagp->agstart);
+	agno = BLKTOAG(agstart, JFS_SBI(ip->i_sb));
 
 	release_metapage(mp);
+	if (agno >= MAXAG || agno < 0)
+		return -EIO;
 
 	rel_inode = (ino & (INOSPERPAGE - 1));
 	pageno = blkno >> sbi->l2nbperpage;
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 677ff78d54fb..eb195c33c9a9 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -51,12 +51,21 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 
 	bh = nilfs_grab_buffer(inode, btnc, blocknr, BIT(BH_NILFS_Node));
 	if (unlikely(!bh))
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (unlikely(buffer_mapped(bh) || buffer_uptodate(bh) ||
 		     buffer_dirty(bh))) {
-		brelse(bh);
-		BUG();
+		/*
+		 * The block buffer at the specified new address was already
+		 * in use.  This can happen if it is a virtual block number
+		 * and has been reallocated due to corruption of the bitmap
+		 * used to manage its allocation state (if not, the buffer
+		 * clearing of an abandoned b-tree node is missing somewhere).
+		 */
+		nilfs_error(inode->i_sb,
+			    "state inconsistency probably due to duplicate use of b-tree node block address %llu (ino=%lu)",
+			    (unsigned long long)blocknr, inode->i_ino);
+		goto failed;
 	}
 	memset(bh->b_data, 0, i_blocksize(inode));
 	bh->b_bdev = inode->i_sb->s_bdev;
@@ -67,6 +76,12 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
 	return bh;
+
+failed:
+	unlock_page(bh->b_page);
+	put_page(bh->b_page);
+	brelse(bh);
+	return ERR_PTR(-EIO);
 }
 
 int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
@@ -224,8 +239,8 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 	}
 
 	nbh = nilfs_btnode_create_block(btnc, newkey);
-	if (!nbh)
-		return -ENOMEM;
+	if (IS_ERR(nbh))
+		return PTR_ERR(nbh);
 
 	BUG_ON(nbh == obh);
 	ctxt->newbh = nbh;
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 4905b7cd7bf3..a426e4e2acda 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -63,8 +63,8 @@ static int nilfs_btree_get_new_block(const struct nilfs_bmap *btree,
 	struct buffer_head *bh;
 
 	bh = nilfs_btnode_create_block(btnc, ptr);
-	if (!bh)
-		return -ENOMEM;
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
 
 	set_buffer_nilfs_volatile(bh);
 	*bhp = bh;
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 23b24ec79527..3c4272762779 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -134,14 +134,9 @@ static void nilfs_segctor_do_flush(struct nilfs_sc_info *, int);
 static void nilfs_segctor_do_immediate_flush(struct nilfs_sc_info *);
 static void nilfs_dispose_list(struct the_nilfs *, struct list_head *, int);
 
-#define nilfs_cnt32_gt(a, b)   \
-	(typecheck(__u32, a) && typecheck(__u32, b) && \
-	 ((__s32)(b) - (__s32)(a) < 0))
 #define nilfs_cnt32_ge(a, b)   \
 	(typecheck(__u32, a) && typecheck(__u32, b) && \
-	 ((__s32)(a) - (__s32)(b) >= 0))
-#define nilfs_cnt32_lt(a, b)  nilfs_cnt32_gt(b, a)
-#define nilfs_cnt32_le(a, b)  nilfs_cnt32_ge(b, a)
+	 ((__s32)((a) - (b)) >= 0))
 
 static int nilfs_prepare_segment_lock(struct super_block *sb,
 				      struct nilfs_transaction_info *ti)
diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 0dc98bbad9c4..ac45f25bf40c 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -22,6 +22,7 @@
 #include "udfdecl.h"
 
 #include <linux/bitops.h>
+#include <linux/overflow.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
@@ -133,7 +134,6 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct buffer_head *bh = NULL;
-	struct udf_part_map *partmap;
 	unsigned long block;
 	unsigned long block_group;
 	unsigned long bit;
@@ -142,19 +142,9 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 	unsigned long overflow;
 
 	mutex_lock(&sbi->s_alloc_mutex);
-	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
-	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
-		udf_debug("%u < %d || %u + %u > %u\n",
-			  bloc->logicalBlockNum, 0,
-			  bloc->logicalBlockNum, count,
-			  partmap->s_partition_len);
-		goto error_return;
-	}
-
+	/* We make sure this cannot overflow when mounting the filesystem */
 	block = bloc->logicalBlockNum + offset +
 		(sizeof(struct spaceBitmapDesc) << 3);
-
 	do {
 		overflow = 0;
 		block_group = block >> (sb->s_blocksize_bits + 3);
@@ -375,7 +365,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 				  uint32_t count)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
-	struct udf_part_map *partmap;
 	uint32_t start, end;
 	uint32_t elen;
 	struct kernel_lb_addr eloc;
@@ -384,16 +373,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 	struct udf_inode_info *iinfo;
 
 	mutex_lock(&sbi->s_alloc_mutex);
-	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
-	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
-		udf_debug("%u < %d || %u + %u > %u\n",
-			  bloc->logicalBlockNum, 0,
-			  bloc->logicalBlockNum, count,
-			  partmap->s_partition_len);
-		goto error_return;
-	}
-
 	iinfo = UDF_I(table);
 	udf_add_free_space(sb, sbi->s_partition, count);
 
@@ -668,6 +647,17 @@ void udf_free_blocks(struct super_block *sb, struct inode *inode,
 {
 	uint16_t partition = bloc->partitionReferenceNum;
 	struct udf_part_map *map = &UDF_SB(sb)->s_partmaps[partition];
+	uint32_t blk;
+
+	if (check_add_overflow(bloc->logicalBlockNum, offset, &blk) ||
+	    check_add_overflow(blk, count, &blk) ||
+	    bloc->logicalBlockNum + count > map->s_partition_len) {
+		udf_debug("Invalid request to free blocks: (%d, %u), off %u, "
+			  "len %u, partition len %u\n",
+			  partition, bloc->logicalBlockNum, offset, count,
+			  map->s_partition_len);
+		return;
+	}
 
 	if (map->s_partition_flags & UDF_PART_FLAG_UNALLOC_BITMAP) {
 		udf_bitmap_free_blocks(sb, map->s_uspace.s_bitmap,
diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index 1c7b89ae6bdc..473897bbd898 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -33,10 +33,28 @@ struct sensor_device_attribute{
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
 	  .index = _index }
 
+#define SENSOR_ATTR_RO(_name, _func, _index)			\
+	SENSOR_ATTR(_name, 0444, _func##_show, NULL, _index)
+
+#define SENSOR_ATTR_RW(_name, _func, _index)			\
+	SENSOR_ATTR(_name, 0644, _func##_show, _func##_store, _index)
+
+#define SENSOR_ATTR_WO(_name, _func, _index)			\
+	SENSOR_ATTR(_name, 0200, NULL, _func##_store, _index)
+
 #define SENSOR_DEVICE_ATTR(_name, _mode, _show, _store, _index)	\
 struct sensor_device_attribute sensor_dev_attr_##_name		\
 	= SENSOR_ATTR(_name, _mode, _show, _store, _index)
 
+#define SENSOR_DEVICE_ATTR_RO(_name, _func, _index)		\
+	SENSOR_DEVICE_ATTR(_name, 0444, _func##_show, NULL, _index)
+
+#define SENSOR_DEVICE_ATTR_RW(_name, _func, _index)		\
+	SENSOR_DEVICE_ATTR(_name, 0644, _func##_show, _func##_store, _index)
+
+#define SENSOR_DEVICE_ATTR_WO(_name, _func, _index)		\
+	SENSOR_DEVICE_ATTR(_name, 0200, NULL, _func##_store, _index)
+
 struct sensor_device_attribute_2 {
 	struct device_attribute dev_attr;
 	u8 index;
@@ -50,8 +68,29 @@ struct sensor_device_attribute_2 {
 	  .index = _index,					\
 	  .nr = _nr }
 
+#define SENSOR_ATTR_2_RO(_name, _func, _nr, _index)		\
+	SENSOR_ATTR_2(_name, 0444, _func##_show, NULL, _nr, _index)
+
+#define SENSOR_ATTR_2_RW(_name, _func, _nr, _index)		\
+	SENSOR_ATTR_2(_name, 0644, _func##_show, _func##_store, _nr, _index)
+
+#define SENSOR_ATTR_2_WO(_name, _func, _nr, _index)		\
+	SENSOR_ATTR_2(_name, 0200, NULL, _func##_store, _nr, _index)
+
 #define SENSOR_DEVICE_ATTR_2(_name,_mode,_show,_store,_nr,_index)	\
 struct sensor_device_attribute_2 sensor_dev_attr_##_name		\
 	= SENSOR_ATTR_2(_name, _mode, _show, _store, _nr, _index)
 
+#define SENSOR_DEVICE_ATTR_2_RO(_name, _func, _nr, _index)		\
+	SENSOR_DEVICE_ATTR_2(_name, 0444, _func##_show, NULL,		\
+			     _nr, _index)
+
+#define SENSOR_DEVICE_ATTR_2_RW(_name, _func, _nr, _index)		\
+	SENSOR_DEVICE_ATTR_2(_name, 0644, _func##_show, _func##_store,	\
+			     _nr, _index)
+
+#define SENSOR_DEVICE_ATTR_2_WO(_name, _func, _nr, _index)		\
+	SENSOR_DEVICE_ATTR_2(_name, 0200, NULL, _func##_store,		\
+			     _nr, _index)
+
 #endif /* _LINUX_HWMON_SYSFS_H */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 3ac7b92b35b9..91193284710f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2136,6 +2136,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index f4077379420f..f0f7b348fe5e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -560,7 +560,6 @@ do {									\
 struct perf_event;
 
 DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
-DECLARE_PER_CPU(int, bpf_kprobe_override);
 
 extern int  perf_trace_init(struct perf_event *event);
 extern void perf_trace_destroy(struct perf_event *event);
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 4a0f51c2b3b9..9eb7d7de590f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -12,6 +12,7 @@
 #include <linux/rhashtable.h>
 #include <net/netfilter/nf_flow_table.h>
 #include <net/netlink.h>
+#include <net/netns/generic.h>
 
 #define NFT_JUMP_STACK_SIZE	16
 
@@ -636,10 +637,16 @@ static inline struct nft_expr *nft_set_ext_expr(const struct nft_set_ext *ext)
 	return nft_set_ext(ext, NFT_SET_EXT_EXPR);
 }
 
-static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+static inline bool __nft_set_elem_expired(const struct nft_set_ext *ext,
+					  u64 tstamp)
 {
 	return nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION) &&
-	       time_is_before_eq_jiffies64(*nft_set_ext_expiration(ext));
+	       time_after_eq64(tstamp, *nft_set_ext_expiration(ext));
+}
+
+static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+{
+	return __nft_set_elem_expired(ext, get_jiffies_64());
 }
 
 static inline struct nft_set_ext *nft_set_elem_ext(const struct nft_set *set,
@@ -1423,11 +1430,21 @@ struct nftables_pernet {
 	struct list_head	module_list;
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
+	u64			tstamp;
 	unsigned int		base_seq;
 	u8			validate_state;
 	unsigned int		gc_seq;
 };
 
+extern unsigned int nf_tables_net_id;
+
+static inline u64 nft_net_tstamp(const struct net *net)
+{
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return nft_net->tstamp;
+}
+
 int nf_msecs_to_jiffies64(const struct nlattr *nla, u64 *result);
 __be64 nf_jiffies64_to_msecs(u64 input);
 
diff --git a/include/uapi/linux/zorro_ids.h b/include/uapi/linux/zorro_ids.h
index 6e574d7b7d79..393f2ee9c042 100644
--- a/include/uapi/linux/zorro_ids.h
+++ b/include/uapi/linux/zorro_ids.h
@@ -449,6 +449,9 @@
 #define  ZORRO_PROD_VMC_ISDN_BLASTER_Z2				ZORRO_ID(VMC, 0x01, 0)
 #define  ZORRO_PROD_VMC_HYPERCOM_4				ZORRO_ID(VMC, 0x02, 0)
 
+#define ZORRO_MANUF_CSLAB					0x1400
+#define  ZORRO_PROD_CSLAB_WARP_1260				ZORRO_ID(CSLAB, 0x65, 0)
+
 #define ZORRO_MANUF_INFORMATION					0x157C
 #define  ZORRO_PROD_INFORMATION_ISDN_ENGINE_I			ZORRO_ID(INFORMATION, 0x64, 0)
 
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index acc8e13b823b..bfce77a0daac 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -192,7 +192,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
  */
 static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
 {
-	kdb_printf("\r%s", kdb_prompt_str);
+	kdb_printf("\r%s", prompt);
 	if (cp > buffer)
 		kdb_printf("%.*s", (int)(cp - buffer), buffer);
 }
@@ -368,7 +368,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			if (i >= dtab_count)
 				kdb_printf("...");
 			kdb_printf("\n");
-			kdb_printf(kdb_prompt_str);
+			kdb_printf("%s",  kdb_prompt_str);
 			kdb_printf("%s", buffer);
 			if (cp != lastchar)
 				kdb_position_cursor(kdb_prompt_str, buffer, cp);
@@ -459,8 +459,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
 {
 	if (prompt && kdb_prompt_str != prompt)
-		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
-	kdb_printf(kdb_prompt_str);
+		strscpy(kdb_prompt_str, prompt, CMD_BUFLEN);
+	kdb_printf("%s", kdb_prompt_str);
 	kdb_nextline = 1;	/* Prompt and input resets line number */
 	return kdb_read(buffer, bufsize);
 }
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d2a92ddaac4d..34edceed643d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -97,8 +97,8 @@ void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
 {
 	struct dma_devres match_data = { size, vaddr, dma_handle };
 
-	dma_free_coherent(dev, size, vaddr, dma_handle);
 	WARN_ON(devres_destroy(dev, dmam_release, dmam_match, &match_data));
+	dma_free_coherent(dev, size, vaddr, dma_handle);
 }
 EXPORT_SYMBOL(dmam_free_coherent);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c7651c30eaab..4f1b0fc2e74d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5730,6 +5730,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			return -EINVAL;
 
 		nr_pages = vma_size / PAGE_SIZE;
+		if (nr_pages > INT_MAX)
+			return -ENOMEM;
 
 		mutex_lock(&event->mmap_mutex);
 		ret = -EINVAL;
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 8fc0ddc38cb6..a99713a883e9 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -121,7 +121,7 @@ static inline unsigned long perf_data_size(struct ring_buffer *rb)
 
 static inline unsigned long perf_aux_size(struct ring_buffer *rb)
 {
-	return rb->aux_nr_pages << PAGE_SHIFT;
+	return (unsigned long)rb->aux_nr_pages << PAGE_SHIFT;
 }
 
 #define __DEFINE_OUTPUT_COPY_BODY(advance_buf, memcpy_func, ...)	\
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index e1110a7bd3e6..58aba0a3484d 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -686,17 +686,16 @@ static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
-		time_maxerror = txc->maxerror;
+		time_maxerror = clamp(txc->maxerror, (__kernel_long_t)0, (__kernel_long_t)NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_ESTERROR)
-		time_esterror = txc->esterror;
+		time_esterror = clamp(txc->esterror, (__kernel_long_t)0, (__kernel_long_t)NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_TIMECONST) {
-		time_constant = txc->constant;
+		time_constant = clamp(txc->constant, (__kernel_long_t)0, (__kernel_long_t)MAXTC);
 		if (!(time_status & STA_NANO))
 			time_constant += 4;
-		time_constant = min(time_constant, (long)MAXTC);
-		time_constant = max(time_constant, 0l);
+		time_constant = clamp(time_constant, (long)0, (long)MAXTC);
 	}
 
 	if (txc->modes & ADJ_TAI &&
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index aa2094d5dd27..e1ce02931b38 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -948,6 +948,30 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 	bc = tick_broadcast_device.evtdev;
 
 	if (bc && broadcast_needs_cpu(bc, deadcpu)) {
+		/*
+		 * If the broadcast force bit of the current CPU is set,
+		 * then the current CPU has not yet reprogrammed the local
+		 * timer device to avoid a ping-pong race. See
+		 * ___tick_broadcast_oneshot_control().
+		 *
+		 * If the broadcast device is hrtimer based then
+		 * programming the broadcast event below does not have any
+		 * effect because the local clockevent device is not
+		 * running and not programmed because the broadcast event
+		 * is not earlier than the pending event of the local clock
+		 * event device. As a consequence all CPUs waiting for a
+		 * broadcast event are stuck forever.
+		 *
+		 * Detect this condition and reprogram the cpu local timer
+		 * device to avoid the starvation.
+		 */
+		if (tick_check_broadcast_expired()) {
+			struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+
+			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
+			tick_program_event(td->evtdev->next_event, 1);
+		}
+
 		/* This moves the broadcast assignment to this CPU: */
 		clockevents_program_event(bc, bc->next_event, 1);
 	}
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 33c463967bb3..208cfe24c547 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -454,7 +454,7 @@ static struct tracing_map_elt *get_free_elt(struct tracing_map *map)
 	struct tracing_map_elt *elt = NULL;
 	int idx;
 
-	idx = atomic_inc_return(&map->next_elt);
+	idx = atomic_fetch_add_unless(&map->next_elt, 1, map->max_elts);
 	if (idx < map->max_elts) {
 		elt = *(TRACING_MAP_ELT(map->elts, idx));
 		if (map->ops && map->ops->elt_init)
@@ -699,7 +699,7 @@ void tracing_map_clear(struct tracing_map *map)
 {
 	unsigned int i;
 
-	atomic_set(&map->next_elt, -1);
+	atomic_set(&map->next_elt, 0);
 	atomic64_set(&map->hits, 0);
 	atomic64_set(&map->drops, 0);
 
@@ -783,7 +783,7 @@ struct tracing_map *tracing_map_create(unsigned int map_bits,
 
 	map->map_bits = map_bits;
 	map->max_elts = (1 << map_bits);
-	atomic_set(&map->next_elt, -1);
+	atomic_set(&map->next_elt, 0);
 
 	map->map_size = (1 << (map_bits + 1));
 	map->ops = ops;
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index f8e460b4a59d..4f0aeeb8cd0c 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -91,11 +91,15 @@ static bool watchdog_check_timestamp(void)
 	__this_cpu_write(last_timestamp, now);
 	return true;
 }
-#else
-static inline bool watchdog_check_timestamp(void)
+
+static void watchdog_init_timestamp(void)
 {
-	return true;
+	__this_cpu_write(nmi_rearmed, 0);
+	__this_cpu_write(last_timestamp, ktime_get_mono_fast_ns());
 }
+#else
+static inline bool watchdog_check_timestamp(void) { return true; }
+static inline void watchdog_init_timestamp(void) { }
 #endif
 
 static struct perf_event_attr wd_hw_attr = {
@@ -195,6 +199,7 @@ void hardlockup_detector_perf_enable(void)
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
+	watchdog_init_timestamp();
 	perf_event_enable(this_cpu_read(watchdog_ev));
 }
 
diff --git a/lib/decompress_bunzip2.c b/lib/decompress_bunzip2.c
index 7c4932eed748..b16236747b55 100644
--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -232,7 +232,8 @@ static int INIT get_next_block(struct bunzip_data *bd)
 	   RUNB) */
 	symCount = symTotal+2;
 	for (j = 0; j < groupCount; j++) {
-		unsigned char length[MAX_SYMBOLS], temp[MAX_HUFCODE_BITS+1];
+		unsigned char length[MAX_SYMBOLS];
+		unsigned short temp[MAX_HUFCODE_BITS+1];
 		int	minLen,	maxLen, pp;
 		/* Read Huffman code lengths for each symbol.  They're
 		   stored in a way similar to mtf; record a starting
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 26d21339bef2..eda78da3c023 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -430,8 +430,23 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
 		len = strlen(env->envp[i]) + 1;
 
 		if (i != env->envp_idx - 1) {
+			/* @env->envp[] contains pointers to @env->buf[]
+			 * with @env->buflen chars, and we are removing
+			 * variable MODALIAS here pointed by @env->envp[i]
+			 * with length @len as shown below:
+			 *
+			 * 0               @env->buf[]      @env->buflen
+			 * ---------------------------------------------
+			 * ^             ^              ^              ^
+			 * |             |->   @len   <-| target block |
+			 * @env->envp[0] @env->envp[i]  @env->envp[i + 1]
+			 *
+			 * so the "target block" indicated above is moved
+			 * backward by @len, and its right size is
+			 * @env->buflen - (@env->envp[i + 1] - @env->envp[0]).
+			 */
 			memmove(env->envp[i], env->envp[i + 1],
-				env->buflen - len);
+				env->buflen - (env->envp[i + 1] - env->envp[0]));
 
 			for (j = i; j < env->envp_idx - 1; j++)
 				env->envp[j] = env->envp[j + 1] - len;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 078f1461e074..ed19e580144a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -432,13 +432,20 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 	else
 		bg_thresh = (bg_ratio * available_memory) / PAGE_SIZE;
 
-	if (bg_thresh >= thresh)
-		bg_thresh = thresh / 2;
 	tsk = current;
 	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
 		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
 		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
 	}
+	/*
+	 * Dirty throttling logic assumes the limits in page units fit into
+	 * 32-bits. This gives 16TB dirty limits max which is hopefully enough.
+	 */
+	if (thresh > UINT_MAX)
+		thresh = UINT_MAX;
+	/* This makes sure bg_thresh is within 32-bits as well */
+	if (bg_thresh >= thresh)
+		bg_thresh = thresh / 2;
 	dtc->thresh = thresh;
 	dtc->bg_thresh = bg_thresh;
 
@@ -488,7 +495,11 @@ static unsigned long node_dirty_limit(struct pglist_data *pgdat)
 	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk))
 		dirty += dirty / 4;
 
-	return dirty;
+	/*
+	 * Dirty throttling logic assumes the limits in page units fit into
+	 * 32-bits. This gives 16TB dirty limits max which is hopefully enough.
+	 */
+	return min_t(unsigned long, dirty, UINT_MAX);
 }
 
 /**
@@ -527,10 +538,17 @@ int dirty_background_bytes_handler(struct ctl_table *table, int write,
 		loff_t *ppos)
 {
 	int ret;
+	unsigned long old_bytes = dirty_background_bytes;
 
 	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret == 0 && write)
+	if (ret == 0 && write) {
+		if (DIV_ROUND_UP(dirty_background_bytes, PAGE_SIZE) >
+								UINT_MAX) {
+			dirty_background_bytes = old_bytes;
+			return -ERANGE;
+		}
 		dirty_background_ratio = 0;
+	}
 	return ret;
 }
 
@@ -558,6 +576,10 @@ int dirty_bytes_handler(struct ctl_table *table, int write,
 
 	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_bytes != old_bytes) {
+		if (DIV_ROUND_UP(vm_dirty_bytes, PAGE_SIZE) > UINT_MAX) {
+			vm_dirty_bytes = old_bytes;
+			return -ERANGE;
+		}
 		writeback_set_ratelimit();
 		vm_dirty_ratio = 0;
 	}
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3f9b2b4a62ff..ca225c132523 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7055,6 +7055,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	bt_cb(skb)->l2cap.psm = psm;
 
 	if (!chan->ops->recv(chan, skb)) {
+		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
 	}
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index e38e641e98d5..320be467b785 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -135,9 +135,9 @@ static void linkwatch_schedule_work(int urgent)
 	 * override the existing timer.
 	 */
 	if (test_bit(LW_URGENT, &linkwatch_flags))
-		mod_delayed_work(system_wq, &linkwatch_work, 0);
+		mod_delayed_work(system_unbound_wq, &linkwatch_work, 0);
 	else
-		schedule_delayed_work(&linkwatch_work, delay);
+		queue_delayed_work(system_unbound_wq, &linkwatch_work, delay);
 }
 
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3c5401dafdee..437960825ec2 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1273,18 +1273,15 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 		src = ip_hdr(skb)->saddr;
 	else {
 		struct fib_result res;
-		struct flowi4 fl4;
-		struct iphdr *iph;
-
-		iph = ip_hdr(skb);
-
-		memset(&fl4, 0, sizeof(fl4));
-		fl4.daddr = iph->daddr;
-		fl4.saddr = iph->saddr;
-		fl4.flowi4_tos = RT_TOS(iph->tos);
-		fl4.flowi4_oif = rt->dst.dev->ifindex;
-		fl4.flowi4_iif = skb->dev->ifindex;
-		fl4.flowi4_mark = skb->mark;
+		struct iphdr *iph = ip_hdr(skb);
+		struct flowi4 fl4 = {
+			.daddr = iph->daddr,
+			.saddr = iph->saddr,
+			.flowi4_tos = iph->tos & IPTOS_RT_MASK,
+			.flowi4_oif = rt->dst.dev->ifindex,
+			.flowi4_iif = skb->dev->ifindex,
+			.flowi4_mark = skb->mark,
+		};
 
 		rcu_read_lock();
 		if (fib_lookup(dev_net(rt->dst.dev), &fl4, &res, 0) == 0)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index cadc424c1a71..9058d59acd0a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1768,7 +1768,8 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 							    master, &dst,
 							    scores, hiscore_idx);
 
-			if (scores[hiscore_idx].ifa)
+			if (scores[hiscore_idx].ifa &&
+			    scores[hiscore_idx].scopedist >= 0)
 				goto out;
 		}
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a640deb9ab14..0961596bb085 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -223,6 +223,7 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 		return NULL;
 	memset(ndopts, 0, sizeof(*ndopts));
 	while (opt_len) {
+		bool unknown = false;
 		int l;
 		if (opt_len < sizeof(struct nd_opt_hdr))
 			return NULL;
@@ -258,22 +259,23 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 			break;
 #endif
 		default:
-			if (ndisc_is_useropt(dev, nd_opt)) {
-				ndopts->nd_useropts_end = nd_opt;
-				if (!ndopts->nd_useropts)
-					ndopts->nd_useropts = nd_opt;
-			} else {
-				/*
-				 * Unknown options must be silently ignored,
-				 * to accommodate future extension to the
-				 * protocol.
-				 */
-				ND_PRINTK(2, notice,
-					  "%s: ignored unsupported option; type=%d, len=%d\n",
-					  __func__,
-					  nd_opt->nd_opt_type,
-					  nd_opt->nd_opt_len);
-			}
+			unknown = true;
+		}
+		if (ndisc_is_useropt(dev, nd_opt)) {
+			ndopts->nd_useropts_end = nd_opt;
+			if (!ndopts->nd_useropts)
+				ndopts->nd_useropts = nd_opt;
+		} else if (unknown) {
+			/*
+			 * Unknown options must be silently ignored,
+			 * to accommodate future extension to the
+			 * protocol.
+			 */
+			ND_PRINTK(2, notice,
+				  "%s: ignored unsupported option; type=%d, len=%d\n",
+				  __func__,
+				  nd_opt->nd_opt_type,
+				  nd_opt->nd_opt_len);
 		}
 next_opt:
 		opt_len -= l;
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 1ff2860dd3ff..50725e2198f4 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -456,8 +456,8 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 	struct iucv_sock *iucv = iucv_sk(sk);
 	struct iucv_path *path = iucv->path;
 
-	if (iucv->path) {
-		iucv->path = NULL;
+	/* Whoever resets the path pointer, must sever and free it. */
+	if (xchg(&iucv->path, NULL)) {
 		if (with_user_data) {
 			low_nmcpy(user_data, iucv->src_name);
 			high_nmcpy(user_data, iucv->dst_name);
diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
index 18e2e489d0e5..5005469c1732 100644
--- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
@@ -123,7 +123,7 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	if (sctph->source != cp->vport || payload_csum ||
 	    skb->ip_summed == CHECKSUM_PARTIAL) {
 		sctph->source = cp->vport;
-		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+		if (!skb_is_gso(skb))
 			sctp_nat_csum(skb, sctph, sctphoff);
 	} else {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -172,7 +172,7 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	    (skb->ip_summed == CHECKSUM_PARTIAL &&
 	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
 		sctph->dest = cp->dport;
-		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+		if (!skb_is_gso(skb))
 			sctp_nat_csum(skb, sctph, sctphoff);
 	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 83e8566ec3f0..bcb72ad2c178 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3106,7 +3106,8 @@ static int ctnetlink_del_expect(struct net *net, struct sock *ctnl,
 
 		if (cda[CTA_EXPECT_ID]) {
 			__be32 id = nla_get_be32(cda[CTA_EXPECT_ID]);
-			if (ntohl(id) != (u32)(unsigned long)exp) {
+
+			if (id != nf_expect_get_id(exp)) {
 				nf_ct_expect_put(exp);
 				return -ENOENT;
 			}
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f2611406af14..a033c9baf58a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2698,6 +2698,15 @@ static void nf_tables_rule_release(const struct nft_ctx *ctx,
 	nf_tables_rule_destroy(ctx, rule);
 }
 
+/** nft_chain_validate - loop detection and hook validation
+ *
+ * @ctx: context containing call depth and base chain
+ * @chain: chain to validate
+ *
+ * Walk through the rules of the given chain and chase all jumps/gotos
+ * and set lookups until either the jump limit is hit or all reachable
+ * chains have been validated.
+ */
 int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 {
 	struct nft_expr *expr, *last;
@@ -2716,6 +2725,9 @@ int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 			if (!expr->ops->validate)
 				continue;
 
+			/* This may call nft_chain_validate() recursively,
+			 * callers that do so must increment ctx->level.
+			 */
 			err = expr->ops->validate(ctx, expr, &data);
 			if (err < 0)
 				return err;
@@ -4523,8 +4535,10 @@ static int nf_tables_getsetelem(struct net *net, struct sock *nlsk,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_get_set_elem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
+		}
 	}
 
 	return err;
@@ -4902,8 +4916,10 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_add_set_elem(&ctx, set, attr, nlh->nlmsg_flags);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			return err;
+		}
 	}
 
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
@@ -5103,9 +5119,10 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_del_setelem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
-
+		}
 		set->ndeact++;
 	}
 	return err;
@@ -7360,6 +7377,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	bool genid_ok;
 
 	mutex_lock(&nft_net->commit_mutex);
+	nft_net->tstamp = get_jiffies_64();
 
 	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
@@ -7412,106 +7430,6 @@ int nft_chain_validate_hooks(const struct nft_chain *chain,
 }
 EXPORT_SYMBOL_GPL(nft_chain_validate_hooks);
 
-/*
- * Loop detection - walk through the ruleset beginning at the destination chain
- * of a new jump until either the source chain is reached (loop) or all
- * reachable chains have been traversed.
- *
- * The loop check is performed whenever a new jump verdict is added to an
- * expression or verdict map or a verdict map is bound to a new chain.
- */
-
-static int nf_tables_check_loops(const struct nft_ctx *ctx,
-				 const struct nft_chain *chain);
-
-static int nf_tables_loop_check_setelem(const struct nft_ctx *ctx,
-					struct nft_set *set,
-					const struct nft_set_iter *iter,
-					struct nft_set_elem *elem)
-{
-	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
-	const struct nft_data *data;
-
-	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
-	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
-		return 0;
-
-	data = nft_set_ext_data(ext);
-	switch (data->verdict.code) {
-	case NFT_JUMP:
-	case NFT_GOTO:
-		return nf_tables_check_loops(ctx, data->verdict.chain);
-	default:
-		return 0;
-	}
-}
-
-static int nf_tables_check_loops(const struct nft_ctx *ctx,
-				 const struct nft_chain *chain)
-{
-	const struct nft_rule *rule;
-	const struct nft_expr *expr, *last;
-	struct nft_set *set;
-	struct nft_set_binding *binding;
-	struct nft_set_iter iter;
-
-	if (ctx->chain == chain)
-		return -ELOOP;
-
-	list_for_each_entry(rule, &chain->rules, list) {
-		nft_rule_for_each_expr(expr, last, rule) {
-			struct nft_immediate_expr *priv;
-			const struct nft_data *data;
-			int err;
-
-			if (strcmp(expr->ops->type->name, "immediate"))
-				continue;
-
-			priv = nft_expr_priv(expr);
-			if (priv->dreg != NFT_REG_VERDICT)
-				continue;
-
-			data = &priv->data;
-			switch (data->verdict.code) {
-			case NFT_JUMP:
-			case NFT_GOTO:
-				err = nf_tables_check_loops(ctx,
-							data->verdict.chain);
-				if (err < 0)
-					return err;
-			default:
-				break;
-			}
-		}
-	}
-
-	list_for_each_entry(set, &ctx->table->sets, list) {
-		if (!nft_is_active_next(ctx->net, set))
-			continue;
-		if (!(set->flags & NFT_SET_MAP) ||
-		    set->dtype != NFT_DATA_VERDICT)
-			continue;
-
-		list_for_each_entry(binding, &set->bindings, list) {
-			if (!(binding->flags & NFT_SET_MAP) ||
-			    binding->chain != chain)
-				continue;
-
-			iter.genmask	= nft_genmask_next(ctx->net);
-			iter.skip 	= 0;
-			iter.count	= 0;
-			iter.err	= 0;
-			iter.fn		= nf_tables_loop_check_setelem;
-
-			set->ops->walk(ctx, set, &iter);
-			if (iter.err < 0)
-				return iter.err;
-		}
-	}
-
-	return 0;
-}
-
 /**
  *	nft_parse_u32_check - fetch u32 attribute and check for maximum value
  *
@@ -7647,7 +7565,7 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 		if (data != NULL &&
 		    (data->verdict.code == NFT_GOTO ||
 		     data->verdict.code == NFT_JUMP)) {
-			err = nf_tables_check_loops(ctx, data->verdict.chain);
+			err = nft_chain_validate(ctx, data->verdict.chain);
 			if (err < 0)
 				return err;
 		}
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 5e562e7cd470..8e249e98aeea 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -41,6 +41,7 @@ struct nft_rhash_cmp_arg {
 	const struct nft_set		*set;
 	const u32			*key;
 	u8				genmask;
+	u64				tstamp;
 };
 
 static inline u32 nft_rhash_key(const void *data, u32 len, u32 seed)
@@ -67,7 +68,7 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 		return 1;
 	if (nft_set_elem_is_dead(&he->ext))
 		return 1;
-	if (nft_set_elem_expired(&he->ext))
+	if (__nft_set_elem_expired(&he->ext, x->tstamp))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
 		return 1;
@@ -91,6 +92,7 @@ static bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup_fast(&priv->ht, &arg, nft_rhash_params);
@@ -109,6 +111,7 @@ static void *nft_rhash_get(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup_fast(&priv->ht, &arg, nft_rhash_params);
@@ -132,6 +135,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 		.genmask = NFT_GENMASK_ANY,
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup_fast(&priv->ht, &arg, nft_rhash_params);
@@ -175,6 +179,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 	struct nft_rhash_elem *prev;
 
@@ -217,6 +222,7 @@ static void *nft_rhash_deactivate(const struct net *net,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 
 	rcu_read_lock();
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index caddacc1d446..f5bec0e37c0d 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -318,6 +318,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d, err;
 
 	/* Descend the tree to search for an existing element greater than the
@@ -365,7 +366,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		/* perform garbage collection to avoid bogus overlap reports
 		 * but skip new elements in this transaction.
 		 */
-		if (nft_set_elem_expired(&rbe->ext) &&
+		if (__nft_set_elem_expired(&rbe->ext, tstamp) &&
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			err = nft_rbtree_gc_elem(set, priv, rbe);
 			if (err < 0)
@@ -540,6 +541,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 	const struct rb_node *parent = priv->root.rb_node;
 	struct nft_rbtree_elem *rbe, *this = elem->priv;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	while (parent != NULL) {
@@ -560,7 +562,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 				   nft_rbtree_interval_end(this)) {
 				parent = parent->rb_right;
 				continue;
-			} else if (nft_set_elem_expired(&rbe->ext)) {
+			} else if (__nft_set_elem_expired(&rbe->ext, tstamp)) {
 				break;
 			} else if (!nft_set_elem_active(&rbe->ext, genmask)) {
 				parent = parent->rb_left;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4ddc60c7509f..b285a6e1a766 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -499,6 +499,61 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+{
+	u8 *skb_orig_data = skb->data;
+	int skb_orig_len = skb->len;
+	struct vlan_hdr vhdr, *vh;
+	unsigned int header_len;
+
+	if (!dev)
+		return 0;
+
+	/* In the SOCK_DGRAM scenario, skb data starts at the network
+	 * protocol, which is after the VLAN headers. The outer VLAN
+	 * header is at the hard_header_len offset in non-variable
+	 * length link layer headers. If it's a VLAN device, the
+	 * min_header_len should be used to exclude the VLAN header
+	 * size.
+	 */
+	if (dev->min_header_len == dev->hard_header_len)
+		header_len = dev->hard_header_len;
+	else if (is_vlan_dev(dev))
+		header_len = dev->min_header_len;
+	else
+		return 0;
+
+	skb_push(skb, skb->data - skb_mac_header(skb));
+	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
+	if (skb_orig_data != skb->data) {
+		skb->data = skb_orig_data;
+		skb->len = skb_orig_len;
+	}
+	if (unlikely(!vh))
+		return 0;
+
+	return ntohs(vh->h_vlan_TCI);
+}
+
+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
+{
+	__be16 proto = skb->protocol;
+
+	if (unlikely(eth_type_vlan(proto))) {
+		u8 *skb_orig_data = skb->data;
+		int skb_orig_len = skb->len;
+
+		skb_push(skb, skb->data - skb_mac_header(skb));
+		proto = __vlan_get_protocol(skb, proto, NULL);
+		if (skb_orig_data != skb->data) {
+			skb->data = skb_orig_data;
+			skb->len = skb_orig_len;
+		}
+	}
+
+	return proto;
+}
+
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
 	del_timer_sync(&pkc->retire_blk_timer);
@@ -974,10 +1029,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
 static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 			struct tpacket3_hdr *ppd)
 {
+	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
+
 	if (skb_vlan_tag_present(pkc->skb)) {
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2344,6 +2405,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2373,7 +2438,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3412,7 +3478,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_ts_and_drops(msg, sk, skb);
@@ -3467,6 +3534,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
+			struct net_device *dev;
+
+			rcu_read_lock();
+			dev = dev_get_by_index_rcu(sock_net(sk), sll->sll_ifindex);
+			if (dev) {
+				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
+				aux.tp_vlan_tpid = ntohs(skb->protocol);
+				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+			} else {
+				aux.tp_vlan_tci = 0;
+				aux.tp_vlan_tpid = 0;
+			}
+			rcu_read_unlock();
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 4d421407d6fc..6c19cc805abc 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -656,21 +656,31 @@ int smc_conn_create(struct smc_sock *smc, bool is_smcd, int srv_first_contact,
 	return rc ? rc : local_contact;
 }
 
-/* convert the RMB size into the compressed notation - minimum 16K.
+#define SMCD_DMBE_SIZES		6 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
+#define SMCR_RMBE_SIZES		5 /* 0 -> 16KB, 1 -> 32KB, .. 5 -> 512KB */
+
+/* convert the RMB size into the compressed notation (minimum 16K, see
+ * SMCD/R_DMBE_SIZES.
  * In contrast to plain ilog2, this rounds towards the next power of 2,
  * so the socket application gets at least its desired sndbuf / rcvbuf size.
  */
-static u8 smc_compress_bufsize(int size)
+static u8 smc_compress_bufsize(int size, bool is_smcd, bool is_rmb)
 {
 	u8 compressed;
 
 	if (size <= SMC_BUF_MIN_SIZE)
 		return 0;
 
-	size = (size - 1) >> 14;
-	compressed = ilog2(size) + 1;
-	if (compressed >= SMC_RMBE_SIZES)
-		compressed = SMC_RMBE_SIZES - 1;
+	size = (size - 1) >> 14;  /* convert to 16K multiple */
+	compressed = min_t(u8, ilog2(size) + 1,
+			   is_smcd ? SMCD_DMBE_SIZES : SMCR_RMBE_SIZES);
+
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
+	if (!is_smcd && is_rmb)
+		/* RMBs are backed by & limited to max size of scatterlists */
+		compressed = min_t(u8, compressed, ilog2((SG_MAX_SINGLE_ALLOC * PAGE_SIZE) >> 14));
+#endif
+
 	return compressed;
 }
 
@@ -771,17 +781,12 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
 	return buf_desc;
 }
 
-#define SMCD_DMBE_SIZES		6 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
-
 static struct smc_buf_desc *smcd_new_buf_create(struct smc_link_group *lgr,
 						bool is_dmb, int bufsize)
 {
 	struct smc_buf_desc *buf_desc;
 	int rc;
 
-	if (smc_compress_bufsize(bufsize) > SMCD_DMBE_SIZES)
-		return ERR_PTR(-EAGAIN);
-
 	/* try to alloc a new DMB */
 	buf_desc = kzalloc(sizeof(*buf_desc), GFP_KERNEL);
 	if (!buf_desc)
@@ -825,9 +830,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		/* use socket send buffer size (w/o overhead) as start value */
 		sk_buf_size = smc->sk.sk_sndbuf / 2;
 
-	for (bufsize_short = smc_compress_bufsize(sk_buf_size);
+	for (bufsize_short = smc_compress_bufsize(sk_buf_size, is_smcd, is_rmb);
 	     bufsize_short >= 0; bufsize_short--) {
-
 		if (is_rmb) {
 			lock = &lgr->rmbs_lock;
 			buf_list = &lgr->rmbs[bufsize_short];
@@ -836,8 +840,6 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 			buf_list = &lgr->sndbufs[bufsize_short];
 		}
 		bufsize = smc_uncompress_bufsize(bufsize_short);
-		if ((1 << get_order(bufsize)) > SG_MAX_SINGLE_ALLOC)
-			continue;
 
 		/* check for reusable slot in the link group */
 		buf_desc = smc_buf_get_slot(bufsize_short, lock, buf_list);
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 9af919364a00..92d88aa62085 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -349,8 +349,10 @@ static void rpc_make_runnable(struct workqueue_struct *wq,
 	if (RPC_IS_ASYNC(task)) {
 		INIT_WORK(&task->u.tk_work, rpc_async_schedule);
 		queue_work(wq, &task->u.tk_work);
-	} else
+	} else {
+		smp_mb__after_atomic();
 		wake_up_bit(&task->tk_runstate, RPC_TASK_QUEUED);
+	}
 }
 
 /*
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 1d6235479706..796309b50bb6 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -127,8 +127,11 @@ static int tipc_udp_addr2str(struct tipc_media_addr *a, char *buf, int size)
 		snprintf(buf, size, "%pI4:%u", &ua->ipv4, ntohs(ua->port));
 	else if (ntohs(ua->proto) == ETH_P_IPV6)
 		snprintf(buf, size, "%pI6:%u", &ua->ipv6, ntohs(ua->port));
-	else
+	else {
 		pr_err("Invalid UDP media address\n");
+		return 1;
+	}
+
 	return 0;
 }
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 15f28203445c..ebd8449f2fcf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3383,10 +3383,7 @@ static void get_key_callback(void *c, struct key_params *params)
 	struct nlattr *key;
 	struct get_key_cookie *cookie = c;
 
-	if ((params->key &&
-	     nla_put(cookie->msg, NL80211_ATTR_KEY_DATA,
-		     params->key_len, params->key)) ||
-	    (params->seq &&
+	if ((params->seq &&
 	     nla_put(cookie->msg, NL80211_ATTR_KEY_SEQ,
 		     params->seq_len, params->seq)) ||
 	    (params->cipher &&
@@ -3398,10 +3395,7 @@ static void get_key_callback(void *c, struct key_params *params)
 	if (!key)
 		goto nla_put_failure;
 
-	if ((params->key &&
-	     nla_put(cookie->msg, NL80211_KEY_DATA,
-		     params->key_len, params->key)) ||
-	    (params->seq &&
+	if ((params->seq &&
 	     nla_put(cookie->msg, NL80211_KEY_SEQ,
 		     params->seq_len, params->seq)) ||
 	    (params->cipher &&
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 82bf1339c28e..7886f26043ed 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1206,7 +1206,7 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 		 2048, /*  1.000000... */
 	};
 	u32 rates_160M[3] = { 960777777, 907400000, 816666666 };
-	u32 rates_969[3] =  { 480388888, 453700000, 408333333 };
+	u32 rates_996[3] =  { 480388888, 453700000, 408333333 };
 	u32 rates_484[3] =  { 229411111, 216666666, 195000000 };
 	u32 rates_242[3] =  { 114711111, 108333333,  97500000 };
 	u32 rates_106[3] =  {  40000000,  37777777,  34000000 };
@@ -1226,12 +1226,14 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	if (WARN_ON_ONCE(rate->nss < 1 || rate->nss > 8))
 		return 0;
 
-	if (rate->bw == RATE_INFO_BW_160)
+	if (rate->bw == RATE_INFO_BW_160 ||
+	    (rate->bw == RATE_INFO_BW_HE_RU &&
+	     rate->he_ru_alloc == NL80211_RATE_INFO_HE_RU_ALLOC_2x996))
 		result = rates_160M[rate->he_gi];
 	else if (rate->bw == RATE_INFO_BW_80 ||
 		 (rate->bw == RATE_INFO_BW_HE_RU &&
 		  rate->he_ru_alloc == NL80211_RATE_INFO_HE_RU_ALLOC_996))
-		result = rates_969[rate->he_gi];
+		result = rates_996[rate->he_gi];
 	else if (rate->bw == RATE_INFO_BW_40 ||
 		 (rate->bw == RATE_INFO_BW_HE_RU &&
 		  rate->he_ru_alloc == NL80211_RATE_INFO_HE_RU_ALLOC_484))
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
index f5c119495254..e05020116b37 100755
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ b/scripts/gcc-x86_32-has-stack-protector.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m32 -O0 -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
index 75e4e22b986a..f680bb01aeeb 100755
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ b/scripts/gcc-x86_64-has-stack-protector.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 8970d4b3b42c..cff8714cde2e 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -300,12 +300,14 @@ static void line6_data_received(struct urb *urb)
 {
 	struct usb_line6 *line6 = (struct usb_line6 *)urb->context;
 	struct midi_buffer *mb = &line6->line6midi->midibuf_in;
+	unsigned long flags;
 	int done;
 
 	if (urb->status == -ESHUTDOWN)
 		return;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+		spin_lock_irqsave(&line6->line6midi->lock, flags);
 		done =
 			line6_midibuf_write(mb, urb->transfer_buffer, urb->actual_length);
 
@@ -314,12 +316,15 @@ static void line6_data_received(struct urb *urb)
 			dev_dbg(line6->ifcdev, "%d %d buffer overflow - message skipped\n",
 				done, urb->actual_length);
 		}
+		spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 
 		for (;;) {
+			spin_lock_irqsave(&line6->line6midi->lock, flags);
 			done =
 				line6_midibuf_read(mb, line6->buffer_message,
 						   LINE6_MIDI_MESSAGE_MAXLEN,
 						   LINE6_MIDIBUF_READ_RX);
+			spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 
 			if (done <= 0)
 				break;
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 3f20438a1b56..5af66dc5c80b 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -250,8 +250,8 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
 		SNDRV_CHMAP_FR,		/* right front */
 		SNDRV_CHMAP_FC,		/* center front */
 		SNDRV_CHMAP_LFE,	/* LFE */
-		SNDRV_CHMAP_SL,		/* left surround */
-		SNDRV_CHMAP_SR,		/* right surround */
+		SNDRV_CHMAP_RL,		/* left surround */
+		SNDRV_CHMAP_RR,		/* right surround */
 		SNDRV_CHMAP_FLC,	/* left of center */
 		SNDRV_CHMAP_FRC,	/* right of center */
 		SNDRV_CHMAP_RC,		/* surround */
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 305ded17e741..8c952e1b0f23 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -105,19 +105,19 @@ let rf-lf = rfe-lf | rfi-lf
  * within one of the lock's critical sections returns False.
  *)
 
-(* rfi for RU events: an RU may read from the last po-previous UL *)
-let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
-
-(* rfe for RU events: an RU may read from an external UL or the initial write *)
-let all-possible-rfe-ru =
-	let possible-rfe-ru r =
+(*
+ * rf for RU events: an RU may read from an external UL or the initial write,
+ * or from the last po-previous UL
+ *)
+let all-possible-rf-ru =
+	let possible-rf-ru r =
 		let pair-to-relation p = p ++ 0
-		in map pair-to-relation (((UL | IW) * {r}) & loc & ext)
-	in map possible-rfe-ru RU
+		in map pair-to-relation ((((UL | IW) * {r}) & loc & ext) |
+			(((UL * {r}) & po-loc) \ ([UL] ; po-loc ; [LKW] ; po-loc)))
+	in map possible-rf-ru RU
 
 (* Generate all rf relations for RU events *)
-with rfe-ru from cross(all-possible-rfe-ru)
-let rf-ru = rfe-ru | rfi-ru
+with rf-ru from cross(all-possible-rf-ru)
 
 (* Final rf relation *)
 let rf = rf | rf-lf | rf-ru
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 66e11e6bb719..a9a10cba8957 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -256,7 +256,7 @@ sort__sym_cmp(struct hist_entry *left, struct hist_entry *right)
 	 * comparing symbol address alone is not enough since it's a
 	 * relative address within a dso.
 	 */
-	if (!hists__has(left->hists, dso) || hists__has(right->hists, dso)) {
+	if (!hists__has(left->hists, dso)) {
 		ret = sort__dso_cmp(left, right);
 		if (ret != 0)
 			return ret;
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index a7fc91bb9119..b9deed81656b 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -395,7 +395,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 				}
 			}
 
-			s->bytes_recvd += recv;
+			if (recv > 0)
+				s->bytes_recvd += recv;
 
 			if (data_test) {
 				int j;
diff --git a/tools/testing/selftests/net/forwarding/devlink_lib.sh b/tools/testing/selftests/net/forwarding/devlink_lib.sh
index 5ab1e5f43022..ea708b6c1e00 100644
--- a/tools/testing/selftests/net/forwarding/devlink_lib.sh
+++ b/tools/testing/selftests/net/forwarding/devlink_lib.sh
@@ -105,4 +105,6 @@ devlink_reload()
 	still_pending=$(devlink resource show "$DEVLINK_DEV" | \
 			grep -c "size_new")
 	check_err $still_pending "Failed reload - There are still unset sizes"
+
+	udevadm settle
 }
diff --git a/tools/testing/selftests/sigaltstack/current_stack_pointer.h b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
index ea9bdf3a90b1..09da8f1011ce 100644
--- a/tools/testing/selftests/sigaltstack/current_stack_pointer.h
+++ b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
@@ -8,7 +8,7 @@ register unsigned long sp asm("sp");
 register unsigned long sp asm("esp");
 #elif __loongarch64
 register unsigned long sp asm("$sp");
-#elif __ppc__
+#elif __powerpc__
 register unsigned long sp asm("r1");
 #elif __s390x__
 register unsigned long sp asm("%15");

