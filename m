Return-Path: <stable+bounces-83332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A619B998402
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 12:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F801F279B3
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 10:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5D1C0DC2;
	Thu, 10 Oct 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJPlCMaT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F747A60;
	Thu, 10 Oct 2024 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556880; cv=none; b=ncmHSauBGuckrvGt7q5QKVBtkz8f4QWQxKATihvAcazSnE6jFixjRwF49KgFlI0hQxfoFUldJFICBAOM7GFakNR8SFYOre55HayGc9FC4LeQtRqLqX/CeWmZDnoq0Dee7wU5gwPRFq3oi4Gbw3IAjD/2OC3F2HruT79onyHSCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556880; c=relaxed/simple;
	bh=bQ46tCZCNxIZoKUQZUNhp3PvGodpKdpDX6iMdpvw3go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxHwieeRtyFUbukyZNeHLCtLTBWpwJfm2MKiqf2r0e1mGdCi1PaTO6g2AHG2+TeBcuC8WMQBq86Dtb7V7ZOPW/riXivifTnXug81wNk9inC6nPi0Zt+puunzsd3iVzVaY8Rd3pbzXxxZmppG+vfapVwHpSVJ+y0yzgo9p3RyK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJPlCMaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CD6C4CEC5;
	Thu, 10 Oct 2024 10:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728556879;
	bh=bQ46tCZCNxIZoKUQZUNhp3PvGodpKdpDX6iMdpvw3go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJPlCMaTDzRO0/J7/G2eq1AN/C4f9Ti5sGe1lVrtCpj8TIruK3892qIpxItJ6L9hY
	 kfX+eyZO0YOV5+XwRmq8Gy9nVSlgXA0MFAGl8ObsTi69wxs56e1wBf/AxDTJA2I/vu
	 rboK/HggHvaxOEAo8ysx2YME9VYyW8NDwBaBK+Pc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.10.14
Date: Thu, 10 Oct 2024 12:40:53 +0200
Message-ID: <2024101048-banister-armored-542e@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024101047-unclothed-armadillo-6520@gregkh>
References: <2024101047-unclothed-armadillo-6520@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index cad6c3dc1f9c..d0c1acfcad40 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -763,3 +763,25 @@ Date:		November 2023
 Contact:	"Chao Yu" <chao@kernel.org>
 Description:	It controls to enable/disable IO aware feature for background discard.
 		By default, the value is 1 which indicates IO aware is on.
+
+What:		/sys/fs/f2fs/<disk>/blkzone_alloc_policy
+Date:		July 2024
+Contact:	"Yuanhong Liao" <liaoyuanhong@vivo.com>
+Description:	The zone UFS we are currently using consists of two parts:
+		conventional zones and sequential zones. It can be used to control which part
+		to prioritize for writes, with a default value of 0.
+
+		========================  =========================================
+		value					  description
+		blkzone_alloc_policy = 0  Prioritize writing to sequential zones
+		blkzone_alloc_policy = 1  Only allow writing to sequential zones
+		blkzone_alloc_policy = 2  Prioritize writing to conventional zones
+		========================  =========================================
+
+What:		/sys/fs/f2fs/<disk>/migration_window_granularity
+Date:		September 2024
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Controls migration window granularity of garbage collection on large
+		section. it can control the scanning window granularity for GC migration
+		in a unit of segment, while migration_granularity controls the number
+		of segments which can be migrated at the same turn.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c82446cef8e2..2c8e062eb2ce 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4791,6 +4791,16 @@
 	printk.time=	Show timing data prefixed to each printk message line
 			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
 
+	proc_mem.force_override= [KNL]
+			Format: {always | ptrace | never}
+			Traditionally /proc/pid/mem allows memory permissions to be
+			overridden without restrictions. This option may be set to
+			restrict that. Can be one of:
+			- 'always': traditional behavior always allows mem overrides.
+			- 'ptrace': only allow mem overrides for active ptracers.
+			- 'never':  never allow mem overrides.
+			If not specified, default is the CONFIG_PROC_MEM_* choice.
+
 	processor.max_cstate=	[HW,ACPI]
 			Limit processor to maximum C-state
 			max_cstate=9 overrides any DMI blacklist limit.
diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 39c52385f11f..8cd4f365044b 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -146,6 +146,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A715     | #2645198        | ARM64_ERRATUM_2645198       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A715     | #3456084        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
@@ -186,6 +188,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N3     | #3456111        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #1619801        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
@@ -289,3 +293,5 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Microsoft      | Azure Cobalt 100| #2253138        | ARM64_ERRATUM_2253138       |
 +----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #3324339        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
index bbe89ea9590c..e95c21628281 100644
--- a/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
@@ -34,6 +34,7 @@ properties:
       and length of the AXI DMA controller IO space, unless
       axistream-connected is specified, in which case the reg
       attribute of the node referenced by it is used.
+    minItems: 1
     maxItems: 2
 
   interrupts:
@@ -181,7 +182,7 @@ examples:
         clock-names = "s_axi_lite_clk", "axis_clk", "ref_clk", "mgt_clk";
         clocks = <&axi_clk>, <&axi_clk>, <&pl_enet_ref_clk>, <&mgt_clk>;
         phy-mode = "mii";
-        reg = <0x00 0x40000000 0x00 0x40000>;
+        reg = <0x40000000 0x40000>;
         xlnx,rxcsum = <0x2>;
         xlnx,rxmem = <0x800>;
         xlnx,txcsum = <0x2>;
diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 70c4fb9d4e5c..d68f37f5b1f8 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -98,7 +98,7 @@ unsigned_int                        num_rx_queues
 unsigned_int                        real_num_rx_queues      -                   read_mostly         get_rps_cpu
 struct_bpf_prog*                    xdp_prog                -                   read_mostly         netif_elide_gro()
 unsigned_long                       gro_flush_timeout       -                   read_mostly         napi_complete_done
-int                                 napi_defer_hard_irqs    -                   read_mostly         napi_complete_done
+u32                                 napi_defer_hard_irqs    -                   read_mostly         napi_complete_done
 unsigned_int                        gro_max_size            -                   read_mostly         skb_gro_receive
 unsigned_int                        gro_ipv4_max_size       -                   read_mostly         skb_gro_receive
 rx_handler_func_t*                  rx_handler              read_mostly         -                   __netif_receive_skb_core
diff --git a/Makefile b/Makefile
index 93731d0b1a04..0ba45bdf4a3b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 10
-SUBLEVEL = 13
+SUBLEVEL = 14
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/crypto/aes-ce-glue.c b/arch/arm/crypto/aes-ce-glue.c
index b668c97663ec..f5b66f4cf45d 100644
--- a/arch/arm/crypto/aes-ce-glue.c
+++ b/arch/arm/crypto/aes-ce-glue.c
@@ -711,7 +711,7 @@ static int __init aes_init(void)
 		algname = aes_algs[i].base.cra_name + 2;
 		drvname = aes_algs[i].base.cra_driver_name + 2;
 		basename = aes_algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create_compat(aes_algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto unregister_simds;
diff --git a/arch/arm/crypto/aes-neonbs-glue.c b/arch/arm/crypto/aes-neonbs-glue.c
index f00f042ef357..0ca94b90bc4e 100644
--- a/arch/arm/crypto/aes-neonbs-glue.c
+++ b/arch/arm/crypto/aes-neonbs-glue.c
@@ -539,7 +539,7 @@ static int __init aes_init(void)
 		algname = aes_algs[i].base.cra_name + 2;
 		drvname = aes_algs[i].base.cra_driver_name + 2;
 		basename = aes_algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create_compat(aes_algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto unregister_simds;
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cd9772b1fd95..43d79f87fa18 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -195,7 +195,8 @@ config ARM64
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
-		if $(cc-option,-fpatchable-function-entry=2)
+		if (GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS || \
+		    CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS)
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
 		if DYNAMIC_FTRACE_WITH_ARGS && DYNAMIC_FTRACE_WITH_CALL_OPS
 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
@@ -268,12 +269,10 @@ config CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS
 	def_bool CC_IS_CLANG
 	# https://github.com/ClangBuiltLinux/linux/issues/1507
 	depends on AS_IS_GNU || (AS_IS_LLVM && (LD_IS_LLD || LD_VERSION >= 23600))
-	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
 config GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS
 	def_bool CC_IS_GCC
 	depends on $(cc-option,-fpatchable-function-entry=2)
-	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
 
 config 64BIT
 	def_bool y
@@ -1079,6 +1078,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Cortex-A78C erratum 3324346
 	  * ARM Cortex-A78C erratum 3324347
 	  * ARM Cortex-A710 erratam 3324338
+	  * ARM Cortex-A715 errartum 3456084
 	  * ARM Cortex-A720 erratum 3456091
 	  * ARM Cortex-A725 erratum 3456106
 	  * ARM Cortex-X1 erratum 3324344
@@ -1089,6 +1089,7 @@ config ARM64_ERRATUM_3194386
 	  * ARM Cortex-X925 erratum 3324334
 	  * ARM Neoverse-N1 erratum 3324349
 	  * ARM Neoverse N2 erratum 3324339
+	  * ARM Neoverse-N3 erratum 3456111
 	  * ARM Neoverse-V1 erratum 3324341
 	  * ARM Neoverse V2 erratum 3324336
 	  * ARM Neoverse-V3 erratum 3312417
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 5a7dfeb8e8eb..488f8e751349 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -94,6 +94,7 @@
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
+#define ARM_CPU_PART_NEOVERSE_N3	0xD8E
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -176,6 +177,7 @@
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
+#define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 36b8e97bf49e..545ce446791a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1364,11 +1364,6 @@ bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 		sign_extend64(__val, id##_##fld##_WIDTH - 1);		\
 	})
 
-#define expand_field_sign(id, fld, val)					\
-	(id##_##fld##_SIGNED ?						\
-	 __expand_field_sign_signed(id, fld, val) :			\
-	 __expand_field_sign_unsigned(id, fld, val))
-
 #define get_idreg_field_unsigned(kvm, id, fld)				\
 	({								\
 		u64 __val = IDREG((kvm), SYS_##id);			\
@@ -1384,20 +1379,26 @@ bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 #define get_idreg_field_enum(kvm, id, fld)				\
 	get_idreg_field_unsigned(kvm, id, fld)
 
-#define get_idreg_field(kvm, id, fld)					\
+#define kvm_cmp_feat_signed(kvm, id, fld, op, limit)			\
+	(get_idreg_field_signed((kvm), id, fld) op __expand_field_sign_signed(id, fld, limit))
+
+#define kvm_cmp_feat_unsigned(kvm, id, fld, op, limit)			\
+	(get_idreg_field_unsigned((kvm), id, fld) op __expand_field_sign_unsigned(id, fld, limit))
+
+#define kvm_cmp_feat(kvm, id, fld, op, limit)				\
 	(id##_##fld##_SIGNED ?						\
-	 get_idreg_field_signed(kvm, id, fld) :				\
-	 get_idreg_field_unsigned(kvm, id, fld))
+	 kvm_cmp_feat_signed(kvm, id, fld, op, limit) :			\
+	 kvm_cmp_feat_unsigned(kvm, id, fld, op, limit))
 
 #define kvm_has_feat(kvm, id, fld, limit)				\
-	(get_idreg_field((kvm), id, fld) >= expand_field_sign(id, fld, limit))
+	kvm_cmp_feat(kvm, id, fld, >=, limit)
 
 #define kvm_has_feat_enum(kvm, id, fld, val)				\
-	(get_idreg_field_unsigned((kvm), id, fld) == __expand_field_sign_unsigned(id, fld, val))
+	kvm_cmp_feat_unsigned(kvm, id, fld, ==, val)
 
 #define kvm_has_feat_range(kvm, id, fld, min, max)			\
-	(get_idreg_field((kvm), id, fld) >= expand_field_sign(id, fld, min) && \
-	 get_idreg_field((kvm), id, fld) <= expand_field_sign(id, fld, max))
+	(kvm_cmp_feat(kvm, id, fld, >=, min) &&				\
+	kvm_cmp_feat(kvm, id, fld, <=, max))
 
 /* Check for a given level of PAuth support */
 #define kvm_has_pauth(k, l)						\
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index dfefbdf4073a..a78f247029ae 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -439,6 +439,7 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
@@ -447,8 +448,10 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N3),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 5139a28130c0..0f7b484cb2ff 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -42,14 +42,16 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 		 * the temporary mappings we use during restore.
 		 */
 		__set_pte(dst_ptep, pte_mkwrite_novma(pte));
-	} else if ((debug_pagealloc_enabled() ||
-		   is_kfence_address((void *)addr)) && !pte_none(pte)) {
+	} else if (!pte_none(pte)) {
 		/*
 		 * debug_pagealloc will removed the PTE_VALID bit if
 		 * the page isn't in use by the resume kernel. It may have
 		 * been in use by the original kernel, in which case we need
 		 * to put it back in our copy to do the restore.
 		 *
+		 * Other cases include kfence / vmalloc / memfd_secret which
+		 * may call `set_direct_map_invalid_noflush()`.
+		 *
 		 * Before marking this entry valid, check the pfn should
 		 * be mapped.
 		 */
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index b4252c357c8e..75b366407a60 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -96,7 +96,6 @@ CONFIG_ZPOOL=y
 CONFIG_ZSWAP=y
 CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
 CONFIG_ZBUD=y
-CONFIG_Z3FOLD=y
 CONFIG_ZSMALLOC=m
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/arch/parisc/include/asm/mman.h b/arch/parisc/include/asm/mman.h
index 47c5a1991d10..89b6beeda0b8 100644
--- a/arch/parisc/include/asm/mman.h
+++ b/arch/parisc/include/asm/mman.h
@@ -11,4 +11,18 @@ static inline bool arch_memory_deny_write_exec_supported(void)
 }
 #define arch_memory_deny_write_exec_supported arch_memory_deny_write_exec_supported
 
+static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
+{
+	/*
+	 * The stack on parisc grows upwards, so if userspace requests memory
+	 * for a stack, mark it with VM_GROWSUP so that the stack expansion in
+	 * the fault handler will work.
+	 */
+	if (flags & MAP_STACK)
+		return VM_GROWSUP;
+
+	return 0;
+}
+#define arch_calc_vm_flag_bits(flags) arch_calc_vm_flag_bits(flags)
+
 #endif /* __ASM_MMAN_H__ */
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index ab23e61a6f01..ea57bcc21dc5 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -1051,8 +1051,7 @@ ENTRY_CFI(intr_save)		/* for os_hpmc */
 	STREG           %r16, PT_ISR(%r29)
 	STREG           %r17, PT_IOR(%r29)
 
-#if 0 && defined(CONFIG_64BIT)
-	/* Revisit when we have 64-bit code above 4Gb */
+#if defined(CONFIG_64BIT)
 	b,n		intr_save2
 
 skip_save_ior:
@@ -1060,8 +1059,7 @@ skip_save_ior:
 	 * need to adjust iasq/iaoq here in the same way we adjusted isr/ior
 	 * above.
 	 */
-	extrd,u,*	%r8,PSW_W_BIT,1,%r1
-	cmpib,COND(=),n	1,%r1,intr_save2
+	bb,COND(>=),n	%r8,PSW_W_BIT,intr_save2
 	LDREG		PT_IASQ0(%r29), %r16
 	LDREG		PT_IAOQ0(%r29), %r17
 	/* adjust iasq/iaoq */
diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 1f51aa9c8230..0fa81bf1466b 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -243,10 +243,10 @@ linux_gateway_entry:
 
 #ifdef CONFIG_64BIT
 	ldil	L%sys_call_table, %r1
-	or,=	%r2,%r2,%r2
-	addil	L%(sys_call_table64-sys_call_table), %r1
+	or,ev	%r2,%r2,%r2
+	ldil	L%sys_call_table64, %r1
 	ldo	R%sys_call_table(%r1), %r19
-	or,=	%r2,%r2,%r2
+	or,ev	%r2,%r2,%r2
 	ldo	R%sys_call_table64(%r1), %r19
 #else
 	load32	sys_call_table, %r19
@@ -379,10 +379,10 @@ tracesys_next:
 	extrd,u	%r19,63,1,%r2			/* W hidden in bottom bit */
 
 	ldil	L%sys_call_table, %r1
-	or,=	%r2,%r2,%r2
-	addil	L%(sys_call_table64-sys_call_table), %r1
+	or,ev	%r2,%r2,%r2
+	ldil	L%sys_call_table64, %r1
 	ldo	R%sys_call_table(%r1), %r19
-	or,=	%r2,%r2,%r2
+	or,ev	%r2,%r2,%r2
 	ldo	R%sys_call_table64(%r1), %r19
 #else
 	load32	sys_call_table, %r19
@@ -1327,6 +1327,8 @@ ENTRY(sys_call_table)
 END(sys_call_table)
 
 #ifdef CONFIG_64BIT
+#undef __SYSCALL_WITH_COMPAT
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 	.align 8
 ENTRY(sys_call_table64)
 #include <asm/syscall_table_64.h>    /* 64-bit syscalls */
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 544a65fda77b..d39284489aa2 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -81,7 +81,6 @@ CONFIG_MODULE_SIG_SHA512=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_Z3FOLD=y
 CONFIG_ZSMALLOC=y
 # CONFIG_SLAB_MERGE_DEFAULT is not set
 CONFIG_SLAB_FREELIST_RANDOM=y
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index a585c8e538ff..939daf6b695e 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -111,6 +111,21 @@ extern struct vdso_arch_data *vdso_data;
 	addi	\ptr, \ptr, (_vdso_datapage - 999b)@l
 .endm
 
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+
+.macro get_realdatapage ptr scratch
+	get_datapage \ptr
+#ifdef CONFIG_TIME_NS
+	lwz	\scratch, VDSO_CLOCKMODE_OFFSET(\ptr)
+	xoris	\scratch, \scratch, VDSO_CLOCKMODE_TIMENS@h
+	xori	\scratch, \scratch, VDSO_CLOCKMODE_TIMENS@l
+	cntlzw	\scratch, \scratch
+	rlwinm	\scratch, \scratch, PAGE_SHIFT - 5, 1 << PAGE_SHIFT
+	add	\ptr, \ptr, \scratch
+#endif
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f029755f9e69..0c5c0fbf6241 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -346,6 +346,8 @@ int main(void)
 #else
 	OFFSET(CFG_SYSCALL_MAP32, vdso_arch_data, syscall_map);
 #endif
+	OFFSET(VDSO_CLOCKMODE_OFFSET, vdso_arch_data, data[0].clock_mode);
+	DEFINE(VDSO_CLOCKMODE_TIMENS, VDSO_CLOCKMODE_TIMENS);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
diff --git a/arch/powerpc/kernel/vdso/cacheflush.S b/arch/powerpc/kernel/vdso/cacheflush.S
index 0085ae464dac..3b2479bd2f9a 100644
--- a/arch/powerpc/kernel/vdso/cacheflush.S
+++ b/arch/powerpc/kernel/vdso/cacheflush.S
@@ -30,7 +30,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 #ifdef CONFIG_PPC64
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10
+	get_realdatapage	r10, r11
 	mtlr	r12
   .cfi_restore	lr
 #endif
diff --git a/arch/powerpc/kernel/vdso/datapage.S b/arch/powerpc/kernel/vdso/datapage.S
index db8e167f0166..2b19b6201a33 100644
--- a/arch/powerpc/kernel/vdso/datapage.S
+++ b/arch/powerpc/kernel/vdso/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr.	r4,r3
-	get_datapage	r3
+	get_realdatapage	r3, r11
 	mtlr	r12
 #ifdef __powerpc64__
 	addi	r3,r3,CFG_SYSCALL_MAP64
@@ -52,7 +52,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3
+	get_realdatapage	r3, r11
 #ifndef __powerpc64__
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
 #endif
diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 47f8eabd1bee..9873b916b237 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -334,23 +334,6 @@ int handle_dlpar_errorlog(struct pseries_hp_errorlog *hp_elog)
 {
 	int rc;
 
-	/* pseries error logs are in BE format, convert to cpu type */
-	switch (hp_elog->id_type) {
-	case PSERIES_HP_ELOG_ID_DRC_COUNT:
-		hp_elog->_drc_u.drc_count =
-				be32_to_cpu(hp_elog->_drc_u.drc_count);
-		break;
-	case PSERIES_HP_ELOG_ID_DRC_INDEX:
-		hp_elog->_drc_u.drc_index =
-				be32_to_cpu(hp_elog->_drc_u.drc_index);
-		break;
-	case PSERIES_HP_ELOG_ID_DRC_IC:
-		hp_elog->_drc_u.ic.count =
-				be32_to_cpu(hp_elog->_drc_u.ic.count);
-		hp_elog->_drc_u.ic.index =
-				be32_to_cpu(hp_elog->_drc_u.ic.index);
-	}
-
 	switch (hp_elog->resource) {
 	case PSERIES_HP_ELOG_RESOURCE_MEM:
 		rc = dlpar_memory(hp_elog);
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index e62835a12d73..6838a0fcda29 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -757,7 +757,7 @@ int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 	u32 drc_index;
 	int rc;
 
-	drc_index = hp_elog->_drc_u.drc_index;
+	drc_index = be32_to_cpu(hp_elog->_drc_u.drc_index);
 
 	lock_device_hotplug();
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 3fe3ddb30c04..38dc4f7c9296 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -817,16 +817,16 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	case PSERIES_HP_ELOG_ACTION_ADD:
 		switch (hp_elog->id_type) {
 		case PSERIES_HP_ELOG_ID_DRC_COUNT:
-			count = hp_elog->_drc_u.drc_count;
+			count = be32_to_cpu(hp_elog->_drc_u.drc_count);
 			rc = dlpar_memory_add_by_count(count);
 			break;
 		case PSERIES_HP_ELOG_ID_DRC_INDEX:
-			drc_index = hp_elog->_drc_u.drc_index;
+			drc_index = be32_to_cpu(hp_elog->_drc_u.drc_index);
 			rc = dlpar_memory_add_by_index(drc_index);
 			break;
 		case PSERIES_HP_ELOG_ID_DRC_IC:
-			count = hp_elog->_drc_u.ic.count;
-			drc_index = hp_elog->_drc_u.ic.index;
+			count = be32_to_cpu(hp_elog->_drc_u.ic.count);
+			drc_index = be32_to_cpu(hp_elog->_drc_u.ic.index);
 			rc = dlpar_memory_add_by_ic(count, drc_index);
 			break;
 		default:
@@ -838,16 +838,16 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 	case PSERIES_HP_ELOG_ACTION_REMOVE:
 		switch (hp_elog->id_type) {
 		case PSERIES_HP_ELOG_ID_DRC_COUNT:
-			count = hp_elog->_drc_u.drc_count;
+			count = be32_to_cpu(hp_elog->_drc_u.drc_count);
 			rc = dlpar_memory_remove_by_count(count);
 			break;
 		case PSERIES_HP_ELOG_ID_DRC_INDEX:
-			drc_index = hp_elog->_drc_u.drc_index;
+			drc_index = be32_to_cpu(hp_elog->_drc_u.drc_index);
 			rc = dlpar_memory_remove_by_index(drc_index);
 			break;
 		case PSERIES_HP_ELOG_ID_DRC_IC:
-			count = hp_elog->_drc_u.ic.count;
-			drc_index = hp_elog->_drc_u.ic.index;
+			count = be32_to_cpu(hp_elog->_drc_u.ic.count);
+			drc_index = be32_to_cpu(hp_elog->_drc_u.ic.index);
 			rc = dlpar_memory_remove_by_ic(count, drc_index);
 			break;
 		default:
diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
index 3c290b9ed01b..0f1d45f32e4a 100644
--- a/arch/powerpc/platforms/pseries/pmem.c
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -121,7 +121,7 @@ int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
 		return -EINVAL;
 	}
 
-	drc_index = hp_elog->_drc_u.drc_index;
+	drc_index = be32_to_cpu(hp_elog->_drc_u.drc_index);
 
 	lock_device_hotplug();
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 006232b67b46..7d521a318840 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -312,6 +312,11 @@ config GENERIC_HWEIGHT
 config FIX_EARLYCON_MEM
 	def_bool MMU
 
+config ILLEGAL_POINTER_VALUE
+	hex
+	default 0 if 32BIT
+	default 0xdead000000000000 if 64BIT
+
 config PGTABLE_LEVELS
 	int
 	default 5 if 64BIT
@@ -710,8 +715,7 @@ config IRQ_STACKS
 config THREAD_SIZE_ORDER
 	int "Kernel stack size (in power-of-two numbers of page size)" if VMAP_STACK && EXPERT
 	range 0 4
-	default 1 if 32BIT && !KASAN
-	default 3 if 64BIT && KASAN
+	default 1 if 32BIT
 	default 2
 	help
 	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 5d473343634b..eec9d4394f5b 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -12,7 +12,12 @@
 #include <linux/const.h>
 
 /* thread information allocation */
-#define THREAD_SIZE_ORDER	CONFIG_THREAD_SIZE_ORDER
+#ifdef CONFIG_KASAN
+#define KASAN_STACK_ORDER	1
+#else
+#define KASAN_STACK_ORDER	0
+#endif
+#define THREAD_SIZE_ORDER	(CONFIG_THREAD_SIZE_ORDER + KASAN_STACK_ORDER)
 #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
 
 /*
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 0ffb072be956..0bbec1c75cd0 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -592,22 +592,22 @@ SYM_TYPED_FUNC_START(sha256_transform_rorx)
 	leaq	K256+0*32(%rip), INP		## reuse INP as scratch reg
 	vpaddd	(INP, SRND), X0, XFER
 	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
-	FOUR_ROUNDS_AND_SCHED	_XFER + 0*32
+	FOUR_ROUNDS_AND_SCHED	(_XFER + 0*32)
 
 	leaq	K256+1*32(%rip), INP
 	vpaddd	(INP, SRND), X0, XFER
 	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
-	FOUR_ROUNDS_AND_SCHED	_XFER + 1*32
+	FOUR_ROUNDS_AND_SCHED	(_XFER + 1*32)
 
 	leaq	K256+2*32(%rip), INP
 	vpaddd	(INP, SRND), X0, XFER
 	vmovdqa XFER, 2*32+_XFER(%rsp, SRND)
-	FOUR_ROUNDS_AND_SCHED	_XFER + 2*32
+	FOUR_ROUNDS_AND_SCHED	(_XFER + 2*32)
 
 	leaq	K256+3*32(%rip), INP
 	vpaddd	(INP, SRND), X0, XFER
 	vmovdqa XFER, 3*32+_XFER(%rsp, SRND)
-	FOUR_ROUNDS_AND_SCHED	_XFER + 3*32
+	FOUR_ROUNDS_AND_SCHED	(_XFER + 3*32)
 
 	add	$4*32, SRND
 	cmp	$3*4*32, SRND
@@ -618,12 +618,12 @@ SYM_TYPED_FUNC_START(sha256_transform_rorx)
 	leaq	K256+0*32(%rip), INP
 	vpaddd	(INP, SRND), X0, XFER
 	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
-	DO_4ROUNDS	_XFER + 0*32
+	DO_4ROUNDS	(_XFER + 0*32)
 
 	leaq	K256+1*32(%rip), INP
 	vpaddd	(INP, SRND), X1, XFER
 	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
-	DO_4ROUNDS	_XFER + 1*32
+	DO_4ROUNDS	(_XFER + 1*32)
 	add	$2*32, SRND
 
 	vmovdqa	X2, X0
@@ -651,8 +651,8 @@ SYM_TYPED_FUNC_START(sha256_transform_rorx)
 	xor	SRND, SRND
 .align 16
 .Lloop3:
-	DO_4ROUNDS	 _XFER + 0*32 + 16
-	DO_4ROUNDS	 _XFER + 1*32 + 16
+	DO_4ROUNDS	(_XFER + 0*32 + 16)
+	DO_4ROUNDS	(_XFER + 1*32 + 16)
 	add	$2*32, SRND
 	cmp	$4*4*32, SRND
 	jb	.Lloop3
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 83d12dd3f831..d77a97056844 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -41,6 +41,8 @@
 #include <asm/desc.h>
 #include <asm/ldt.h>
 #include <asm/unwind.h>
+#include <asm/uprobes.h>
+#include <asm/ibt.h>
 
 #include "perf_event.h"
 
@@ -2814,6 +2816,46 @@ static unsigned long get_segment_base(unsigned int segment)
 	return get_desc_base(desc);
 }
 
+#ifdef CONFIG_UPROBES
+/*
+ * Heuristic-based check if uprobe is installed at the function entry.
+ *
+ * Under assumption of user code being compiled with frame pointers,
+ * `push %rbp/%ebp` is a good indicator that we indeed are.
+ *
+ * Similarly, `endbr64` (assuming 64-bit mode) is also a common pattern.
+ * If we get this wrong, captured stack trace might have one extra bogus
+ * entry, but the rest of stack trace will still be meaningful.
+ */
+static bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	struct arch_uprobe *auprobe;
+
+	if (!current->utask)
+		return false;
+
+	auprobe = current->utask->auprobe;
+	if (!auprobe)
+		return false;
+
+	/* push %rbp/%ebp */
+	if (auprobe->insn[0] == 0x55)
+		return true;
+
+	/* endbr64 (64-bit only) */
+	if (user_64bit_mode(regs) && is_endbr(*(u32 *)auprobe->insn))
+		return true;
+
+	return false;
+}
+
+#else
+static bool is_uprobe_at_func_entry(struct pt_regs *regs)
+{
+	return false;
+}
+#endif /* CONFIG_UPROBES */
+
 #ifdef CONFIG_IA32_EMULATION
 
 #include <linux/compat.h>
@@ -2825,6 +2867,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	unsigned long ss_base, cs_base;
 	struct stack_frame_ia32 frame;
 	const struct stack_frame_ia32 __user *fp;
+	u32 ret_addr;
 
 	if (user_64bit_mode(regs))
 		return 0;
@@ -2834,6 +2877,12 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
+
+	/* see perf_callchain_user() below for why we do this */
+	if (is_uprobe_at_func_entry(regs) &&
+	    !get_user(ret_addr, (const u32 __user *)regs->sp))
+		perf_callchain_store(entry, ret_addr);
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
@@ -2862,6 +2911,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 {
 	struct stack_frame frame;
 	const struct stack_frame __user *fp;
+	unsigned long ret_addr;
 
 	if (perf_guest_state()) {
 		/* TODO: We don't support guest os callchain now */
@@ -2885,6 +2935,19 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 		return;
 
 	pagefault_disable();
+
+	/*
+	 * If we are called from uprobe handler, and we are indeed at the very
+	 * entry to user function (which is normally a `push %rbp` instruction,
+	 * under assumption of application being compiled with frame pointers),
+	 * we should read return address from *regs->sp before proceeding
+	 * to follow frame pointers, otherwise we'll skip immediate caller
+	 * as %rbp is not yet setup.
+	 */
+	if (is_uprobe_at_func_entry(regs) &&
+	    !get_user(ret_addr, (const unsigned long __user *)regs->sp))
+		perf_callchain_store(entry, ret_addr);
+
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9327eb00e96d..be2045a18e69 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -345,20 +345,12 @@ extern struct apic *apic;
  * APIC drivers are probed based on how they are listed in the .apicdrivers
  * section. So the order is important and enforced by the ordering
  * of different apic driver files in the Makefile.
- *
- * For the files having two apic drivers, we use apic_drivers()
- * to enforce the order with in them.
  */
 #define apic_driver(sym)					\
 	static const struct apic *__apicdrivers_##sym __used		\
 	__aligned(sizeof(struct apic *))			\
 	__section(".apicdrivers") = { &sym }
 
-#define apic_drivers(sym1, sym2)					\
-	static struct apic *__apicdrivers_##sym1##sym2[2] __used	\
-	__aligned(sizeof(struct apic *))				\
-	__section(".apicdrivers") = { &sym1, &sym2 }
-
 extern struct apic *__apicdrivers[], *__apicdrivers_end[];
 
 /*
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 611fa41711af..eccc75bc9c4f 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -29,7 +29,7 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 unsigned long fpu__get_fpstate_size(void);
 
-extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size, u32 pkru);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 2fc7bc3863ff..7c488ff0c764 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -82,7 +82,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
 					 struct pt_regs *regs,
 					 unsigned long *args)
 {
-	memcpy(args, &regs->bx, 6 * sizeof(args[0]));
+	args[0] = regs->bx;
+	args[1] = regs->cx;
+	args[2] = regs->dx;
+	args[3] = regs->si;
+	args[4] = regs->di;
+	args[5] = regs->bp;
 }
 
 static inline int syscall_get_arch(struct task_struct *task)
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index f37ad3392fec..e0308d8c4e6c 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -8,129 +8,25 @@
  * Martin Bligh, Andi Kleen, James Bottomley, John Stultz, and
  * James Cleverdon.
  */
-#include <linux/cpumask.h>
 #include <linux/export.h>
-#include <linux/acpi.h>
 
-#include <asm/jailhouse_para.h>
 #include <asm/apic.h>
 
 #include "local.h"
 
-static struct apic apic_physflat;
-static struct apic apic_flat;
-
-struct apic *apic __ro_after_init = &apic_flat;
-EXPORT_SYMBOL_GPL(apic);
-
-static int flat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
-{
-	return 1;
-}
-
-static void _flat_send_IPI_mask(unsigned long mask, int vector)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__default_send_IPI_dest_field(mask, vector, APIC_DEST_LOGICAL);
-	local_irq_restore(flags);
-}
-
-static void flat_send_IPI_mask(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask = cpumask_bits(cpumask)[0];
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static void
-flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
-{
-	unsigned long mask = cpumask_bits(cpumask)[0];
-	int cpu = smp_processor_id();
-
-	if (cpu < BITS_PER_LONG)
-		__clear_bit(cpu, &mask);
-
-	_flat_send_IPI_mask(mask, vector);
-}
-
-static u32 flat_get_apic_id(u32 x)
+static u32 physflat_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
 
-static int flat_probe(void)
+static int physflat_probe(void)
 {
 	return 1;
 }
 
-static struct apic apic_flat __ro_after_init = {
-	.name				= "flat",
-	.probe				= flat_probe,
-	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
-
-	.dest_mode_logical		= true,
-
-	.disable_esr			= 0,
-
-	.init_apic_ldr			= default_init_apic_ldr,
-	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-
-	.max_apic_id			= 0xFE,
-	.get_apic_id			= flat_get_apic_id,
-
-	.calc_dest_apicid		= apic_flat_calc_apicid,
-
-	.send_IPI			= default_send_IPI_single,
-	.send_IPI_mask			= flat_send_IPI_mask,
-	.send_IPI_mask_allbutself	= flat_send_IPI_mask_allbutself,
-	.send_IPI_allbutself		= default_send_IPI_allbutself,
-	.send_IPI_all			= default_send_IPI_all,
-	.send_IPI_self			= default_send_IPI_self,
-	.nmi_to_offline_cpu		= true,
-
-	.read				= native_apic_mem_read,
-	.write				= native_apic_mem_write,
-	.eoi				= native_apic_mem_eoi,
-	.icr_read			= native_apic_icr_read,
-	.icr_write			= native_apic_icr_write,
-	.wait_icr_idle			= apic_mem_wait_icr_idle,
-	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
-};
-
-/*
- * Physflat mode is used when there are more than 8 CPUs on a system.
- * We cannot use logical delivery in this case because the mask
- * overflows, so use physical mode.
- */
 static int physflat_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
-#ifdef CONFIG_ACPI
-	/*
-	 * Quirk: some x86_64 machines can only use physical APIC mode
-	 * regardless of how many processors are present (x86_64 ES7000
-	 * is an example).
-	 */
-	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID &&
-		(acpi_gbl_FADT.flags & ACPI_FADT_APIC_PHYSICAL)) {
-		printk(KERN_DEBUG "system APIC only can use physical flat");
-		return 1;
-	}
-
-	if (!strncmp(oem_id, "IBM", 3) && !strncmp(oem_table_id, "EXA", 3)) {
-		printk(KERN_DEBUG "IBM Summit detected, will use apic physical");
-		return 1;
-	}
-#endif
-
-	return 0;
-}
-
-static int physflat_probe(void)
-{
-	return apic == &apic_physflat || num_possible_cpus() > 8 || jailhouse_paravirt();
+	return 1;
 }
 
 static struct apic apic_physflat __ro_after_init = {
@@ -146,7 +42,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
-	.get_apic_id			= flat_get_apic_id,
+	.get_apic_id			= physflat_get_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
@@ -166,8 +62,7 @@ static struct apic apic_physflat __ro_after_init = {
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
 	.safe_wait_icr_idle		= apic_mem_wait_icr_idle_timeout,
 };
+apic_driver(apic_physflat);
 
-/*
- * We need to check for physflat first, so this order is important.
- */
-apic_drivers(apic_physflat, apic_flat);
+struct apic *apic __ro_after_init = &apic_physflat;
+EXPORT_SYMBOL_GPL(apic);
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 477b740b2f26..d1ec1dcb637a 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -352,27 +352,26 @@ static void ioapic_mask_entry(int apic, int pin)
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static int __add_pin_to_irq_node(struct mp_chip_data *data,
-				 int node, int apic, int pin)
+static bool add_pin_to_irq_node(struct mp_chip_data *data, int node, int apic, int pin)
 {
 	struct irq_pin_list *entry;
 
-	/* don't allow duplicates */
-	for_each_irq_pin(entry, data->irq_2_pin)
+	/* Don't allow duplicates */
+	for_each_irq_pin(entry, data->irq_2_pin) {
 		if (entry->apic == apic && entry->pin == pin)
-			return 0;
+			return true;
+	}
 
 	entry = kzalloc_node(sizeof(struct irq_pin_list), GFP_ATOMIC, node);
 	if (!entry) {
-		pr_err("can not alloc irq_pin_list (%d,%d,%d)\n",
-		       node, apic, pin);
-		return -ENOMEM;
+		pr_err("Cannot allocate irq_pin_list (%d,%d,%d)\n", node, apic, pin);
+		return false;
 	}
+
 	entry->apic = apic;
 	entry->pin = pin;
 	list_add_tail(&entry->list, &data->irq_2_pin);
-
-	return 0;
+	return true;
 }
 
 static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
@@ -387,13 +386,6 @@ static void __remove_pin_from_irq(struct mp_chip_data *data, int apic, int pin)
 		}
 }
 
-static void add_pin_to_irq_node(struct mp_chip_data *data,
-				int node, int apic, int pin)
-{
-	if (__add_pin_to_irq_node(data, node, apic, pin))
-		panic("IO-APIC: failed to add irq-pin. Can not proceed\n");
-}
-
 /*
  * Reroute an IRQ to a different pin.
  */
@@ -1002,8 +994,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 	if (irq_data && irq_data->parent_data) {
 		if (!mp_check_pin_attr(irq, info))
 			return -EBUSY;
-		if (__add_pin_to_irq_node(irq_data->chip_data, node, ioapic,
-					  info->ioapic.pin))
+		if (!add_pin_to_irq_node(irq_data->chip_data, node, ioapic, info->ioapic.pin))
 			return -ENOMEM;
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
@@ -3017,10 +3008,8 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -ENOMEM;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, info);
-	if (ret < 0) {
-		kfree(data);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_data;
 
 	INIT_LIST_HEAD(&data->irq_2_pin);
 	irq_data->hwirq = info->ioapic.pin;
@@ -3029,7 +3018,10 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 	irq_data->chip_data = data;
 	mp_irqdomain_get_attr(mp_pin_to_gsi(ioapic, pin), data, info);
 
-	add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin);
+	if (!add_pin_to_irq_node(data, ioapic_alloc_attr_node(info), ioapic, pin)) {
+		ret = -ENOMEM;
+		goto free_irqs;
+	}
 
 	mp_preconfigure_entry(data);
 	mp_register_handler(virq, data->is_level);
@@ -3044,6 +3036,12 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		    ioapic, mpc_ioapic_id(ioapic), pin, virq,
 		    data->is_level, data->active_low);
 	return 0;
+
+free_irqs:
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+free_data:
+	kfree(data);
+	return ret;
 }
 
 void mp_irqdomain_free(struct irq_domain *domain, unsigned int virq,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b6f927f6c567..47c84503ad9b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2545,10 +2545,9 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (cpu_mitigations_off())
-		return;
-
-	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
+	    cpu_mitigations_off() ||
+	    srso_cmd == SRSO_CMD_OFF) {
 		if (boot_cpu_has(X86_FEATURE_SBPB))
 			x86_pred_cmd = PRED_CMD_SBPB;
 		return;
@@ -2579,11 +2578,6 @@ static void __init srso_select_mitigation(void)
 	}
 
 	switch (srso_cmd) {
-	case SRSO_CMD_OFF:
-		if (boot_cpu_has(X86_FEATURE_SBPB))
-			x86_pred_cmd = PRED_CMD_SBPB;
-		return;
-
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
 			srso_mitigation = SRSO_MITIGATION_MICROCODE;
@@ -2637,6 +2631,8 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
                 }
 		break;
+	default:
+		break;
 	}
 
 out:
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..be307c9ef263 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1165,8 +1165,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 
 	VULNWL_INTEL(INTEL_CORE_YONAH,		NO_SSB),
 
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | MSBDS_ONLY),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT_D,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 247f2225aa9f..2b3b9e140dd4 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -156,7 +156,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 	return !err;
 }
 
-static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
+static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
 	if (use_xsave())
 		return xsave_to_user_sigframe(buf);
@@ -185,7 +185,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  * For [f]xsave state, update the SW reserved fields in the [f]xsave frame
  * indicating the absence/presence of the extended state to the user.
  */
-bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
+bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size, u32 pkru)
 {
 	struct task_struct *tsk = current;
 	struct fpstate *fpstate = tsk->thread.fpu.fpstate;
@@ -228,7 +228,7 @@ bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 		fpregs_restore_userregs();
 
 	pagefault_disable();
-	ret = copy_fpregs_to_sigframe(buf_fx);
+	ret = copy_fpregs_to_sigframe(buf_fx, pkru);
 	pagefault_enable();
 	fpregs_unlock();
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index cc0f7f70b17b..9c9ac606893e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
 
 #ifdef CONFIG_ACPI
 /*
@@ -87,6 +88,8 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
 
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -102,6 +105,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	if (!mstart)
 		return 0;
 
+	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart = efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)kaddr;
+
+		mend = mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 31b6f5dddfc2..1f1e8e0ac5a3 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -84,6 +84,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
+	u32 pkru = read_pkru();
 
 	/* redzone */
 	if (!ia32_frame)
@@ -139,7 +140,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	}
 
 	/* save i387 and extended state */
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru))
 		return (void __user *)-1L;
 
 	return (void __user *)sp;
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 8a94053c5444..ee9453891901 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -260,13 +260,13 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-	if (restore_signal_shadow_stack())
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
-	if (restore_altstack(&frame->uc.uc_stack))
+	if (restore_signal_shadow_stack())
 		goto badframe;
 
 	return regs->ax;
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..a204a332c71f 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_leaf(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 690ca99dfaca..5a6098a3db57 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2076,7 +2076,7 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 			      struct ioc_now *now)
 {
 	struct ioc_gq *iocg;
-	u64 dur, usage_pct, nr_cycles;
+	u64 dur, usage_pct, nr_cycles, nr_cycles_shift;
 
 	/* if no debtor, reset the cycle */
 	if (!nr_debtors) {
@@ -2138,10 +2138,12 @@ static void ioc_forgive_debts(struct ioc *ioc, u64 usage_us_sum, int nr_debtors,
 		old_debt = iocg->abs_vdebt;
 		old_delay = iocg->delay;
 
+		nr_cycles_shift = min_t(u64, nr_cycles, BITS_PER_LONG - 1);
 		if (iocg->abs_vdebt)
-			iocg->abs_vdebt = iocg->abs_vdebt >> nr_cycles ?: 1;
+			iocg->abs_vdebt = iocg->abs_vdebt >> nr_cycles_shift ?: 1;
+
 		if (iocg->delay)
-			iocg->delay = iocg->delay >> nr_cycles ?: 1;
+			iocg->delay = iocg->delay >> nr_cycles_shift ?: 1;
 
 		iocg_kick_waitq(iocg, true, now);
 
diff --git a/block/ioctl.c b/block/ioctl.c
index d570e1695896..4515d4679eef 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -126,7 +126,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 		return -EINVAL;
 
 	filemap_invalidate_lock(bdev->bd_mapping);
-	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
+	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (err)
 		goto fail;
 
@@ -163,7 +163,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
 static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 		void __user *argp)
 {
-	uint64_t start, len;
+	uint64_t start, len, end;
 	uint64_t range[2];
 	int err;
 
@@ -178,11 +178,12 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
 	len = range[1];
 	if ((start & 511) || (len & 511))
 		return -EINVAL;
-	if (start + len > bdev_nr_bytes(bdev))
+	if (check_add_overflow(start, len, &end) ||
+	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
 	filemap_invalidate_lock(bdev->bd_mapping);
-	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
+	err = truncate_bdev_range(bdev, mode, start, end - 1);
 	if (!err)
 		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
 						GFP_KERNEL);
diff --git a/crypto/simd.c b/crypto/simd.c
index edaa479a1ec5..d109866641a2 100644
--- a/crypto/simd.c
+++ b/crypto/simd.c
@@ -136,27 +136,19 @@ static int simd_skcipher_init(struct crypto_skcipher *tfm)
 	return 0;
 }
 
-struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
+struct simd_skcipher_alg *simd_skcipher_create_compat(struct skcipher_alg *ialg,
+						      const char *algname,
 						      const char *drvname,
 						      const char *basename)
 {
 	struct simd_skcipher_alg *salg;
-	struct crypto_skcipher *tfm;
-	struct skcipher_alg *ialg;
 	struct skcipher_alg *alg;
 	int err;
 
-	tfm = crypto_alloc_skcipher(basename, CRYPTO_ALG_INTERNAL,
-				    CRYPTO_ALG_INTERNAL | CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return ERR_CAST(tfm);
-
-	ialg = crypto_skcipher_alg(tfm);
-
 	salg = kzalloc(sizeof(*salg), GFP_KERNEL);
 	if (!salg) {
 		salg = ERR_PTR(-ENOMEM);
-		goto out_put_tfm;
+		goto out;
 	}
 
 	salg->ialg_name = basename;
@@ -195,30 +187,16 @@ struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
 	if (err)
 		goto out_free_salg;
 
-out_put_tfm:
-	crypto_free_skcipher(tfm);
+out:
 	return salg;
 
 out_free_salg:
 	kfree(salg);
 	salg = ERR_PTR(err);
-	goto out_put_tfm;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(simd_skcipher_create_compat);
 
-struct simd_skcipher_alg *simd_skcipher_create(const char *algname,
-					       const char *basename)
-{
-	char drvname[CRYPTO_MAX_ALG_NAME];
-
-	if (snprintf(drvname, CRYPTO_MAX_ALG_NAME, "simd-%s", basename) >=
-	    CRYPTO_MAX_ALG_NAME)
-		return ERR_PTR(-ENAMETOOLONG);
-
-	return simd_skcipher_create_compat(algname, drvname, basename);
-}
-EXPORT_SYMBOL_GPL(simd_skcipher_create);
-
 void simd_skcipher_free(struct simd_skcipher_alg *salg)
 {
 	crypto_unregister_skcipher(&salg->alg);
@@ -246,7 +224,7 @@ int simd_register_skciphers_compat(struct skcipher_alg *algs, int count,
 		algname = algs[i].base.cra_name + 2;
 		drvname = algs[i].base.cra_driver_name + 2;
 		basename = algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create_compat(algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto err_unregister;
@@ -383,27 +361,19 @@ static int simd_aead_init(struct crypto_aead *tfm)
 	return 0;
 }
 
-struct simd_aead_alg *simd_aead_create_compat(const char *algname,
-					      const char *drvname,
-					      const char *basename)
+static struct simd_aead_alg *simd_aead_create_compat(struct aead_alg *ialg,
+						     const char *algname,
+						     const char *drvname,
+						     const char *basename)
 {
 	struct simd_aead_alg *salg;
-	struct crypto_aead *tfm;
-	struct aead_alg *ialg;
 	struct aead_alg *alg;
 	int err;
 
-	tfm = crypto_alloc_aead(basename, CRYPTO_ALG_INTERNAL,
-				CRYPTO_ALG_INTERNAL | CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return ERR_CAST(tfm);
-
-	ialg = crypto_aead_alg(tfm);
-
 	salg = kzalloc(sizeof(*salg), GFP_KERNEL);
 	if (!salg) {
 		salg = ERR_PTR(-ENOMEM);
-		goto out_put_tfm;
+		goto out;
 	}
 
 	salg->ialg_name = basename;
@@ -442,36 +412,20 @@ struct simd_aead_alg *simd_aead_create_compat(const char *algname,
 	if (err)
 		goto out_free_salg;
 
-out_put_tfm:
-	crypto_free_aead(tfm);
+out:
 	return salg;
 
 out_free_salg:
 	kfree(salg);
 	salg = ERR_PTR(err);
-	goto out_put_tfm;
-}
-EXPORT_SYMBOL_GPL(simd_aead_create_compat);
-
-struct simd_aead_alg *simd_aead_create(const char *algname,
-				       const char *basename)
-{
-	char drvname[CRYPTO_MAX_ALG_NAME];
-
-	if (snprintf(drvname, CRYPTO_MAX_ALG_NAME, "simd-%s", basename) >=
-	    CRYPTO_MAX_ALG_NAME)
-		return ERR_PTR(-ENAMETOOLONG);
-
-	return simd_aead_create_compat(algname, drvname, basename);
+	goto out;
 }
-EXPORT_SYMBOL_GPL(simd_aead_create);
 
-void simd_aead_free(struct simd_aead_alg *salg)
+static void simd_aead_free(struct simd_aead_alg *salg)
 {
 	crypto_unregister_aead(&salg->alg);
 	kfree(salg);
 }
-EXPORT_SYMBOL_GPL(simd_aead_free);
 
 int simd_register_aeads_compat(struct aead_alg *algs, int count,
 			       struct simd_aead_alg **simd_algs)
@@ -493,7 +447,7 @@ int simd_register_aeads_compat(struct aead_alg *algs, int count,
 		algname = algs[i].base.cra_name + 2;
 		drvname = algs[i].base.cra_driver_name + 2;
 		basename = algs[i].base.cra_driver_name;
-		simd = simd_aead_create_compat(algname, drvname, basename);
+		simd = simd_aead_create_compat(algs + i, algname, drvname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto err_unregister;
diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 1457300828bf..ef717802a3c8 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -58,6 +58,10 @@ static struct {
 	{ IVPU_HW_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
 };
 
+/* Production fw_names from the table above */
+MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
+
 static int ivpu_fw_request(struct ivpu_device *vdev)
 {
 	int ret = -ENOENT;
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index bd1ad07f0290..e84509b19f94 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -132,8 +132,10 @@ static void exit_round_robin(unsigned int tsk_index)
 {
 	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
 
-	cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
-	tsk_in_cpu[tsk_index] = -1;
+	if (tsk_in_cpu[tsk_index] != -1) {
+		cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
+		tsk_in_cpu[tsk_index] = -1;
+	}
 }
 
 static unsigned int idle_pct = 5; /* percentage */
diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 2b84ac093698..8dbab6932049 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 08196fa17080..82b1fa2d201f 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -437,6 +437,9 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 
 		if (info->connection_node) {
 			second_desc = info->connection_node->object;
+			if (second_desc == NULL) {
+				break;
+			}
 			if (!(second_desc->common.flags & AOPOBJ_DATA_VALID)) {
 				status =
 				    acpi_ds_get_buffer_arguments(second_desc);
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 422c074ed289..28582adfc0ac 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -25,6 +25,8 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state);
 static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 						       *parser_state);
 
+static void acpi_ps_free_field_list(union acpi_parse_object *start);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ps_get_next_package_length
@@ -683,6 +685,39 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 	return_PTR(field);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ps_free_field_list
+ *
+ * PARAMETERS:  start               - First Op in field list
+ *
+ * RETURN:      None.
+ *
+ * DESCRIPTION: Free all Op objects inside a field list.
+ *
+ ******************************************************************************/
+
+static void acpi_ps_free_field_list(union acpi_parse_object *start)
+{
+	union acpi_parse_object *cur = start;
+	union acpi_parse_object *next;
+	union acpi_parse_object *arg;
+
+	while (cur) {
+		next = cur->common.next;
+
+		/* AML_INT_CONNECTION_OP can have a single argument */
+
+		arg = acpi_ps_get_arg(cur, 0);
+		if (arg) {
+			acpi_ps_free_op(arg);
+		}
+
+		acpi_ps_free_op(cur);
+		cur = next;
+	}
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ps_get_next_arg
@@ -751,6 +786,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			while (parser_state->aml < parser_state->pkg_end) {
 				field = acpi_ps_get_next_field(parser_state);
 				if (!field) {
+					if (arg) {
+						acpi_ps_free_field_list(arg);
+					}
+
 					return_ACPI_STATUS(AE_NO_MEMORY);
 				}
 
@@ -820,6 +859,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_NOT_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}
 		} else {
 			/* Single complex argument, nothing returned */
 
@@ -854,6 +897,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_POSSIBLE_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}
 
 			if (arg->common.aml_opcode == AML_INT_METHODCALL_OP) {
 
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 8b8be0c90709..d64e2713aae4 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -63,7 +63,7 @@ static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
 		seg = bridge->domain_nr;
 
 	bus = pbus->number;
-	*sbdf = (seg << 24) | (bus << 16) | dport_dev->devfn;
+	*sbdf = (seg << 24) | (bus << 16) | (dport_dev->devfn << 8);
 
 	return 0;
 }
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 44ca989f1646..916cdf44be89 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -703,28 +703,35 @@ static LIST_HEAD(acpi_battery_list);
 static LIST_HEAD(battery_hook_list);
 static DEFINE_MUTEX(hook_mutex);
 
-static void __battery_hook_unregister(struct acpi_battery_hook *hook, int lock)
+static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
 {
 	struct acpi_battery *battery;
+
 	/*
 	 * In order to remove a hook, we first need to
 	 * de-register all the batteries that are registered.
 	 */
-	if (lock)
-		mutex_lock(&hook_mutex);
 	list_for_each_entry(battery, &acpi_battery_list, list) {
 		if (!hook->remove_battery(battery->bat, hook))
 			power_supply_changed(battery->bat);
 	}
-	list_del(&hook->list);
-	if (lock)
-		mutex_unlock(&hook_mutex);
+	list_del_init(&hook->list);
+
 	pr_info("extension unregistered: %s\n", hook->name);
 }
 
 void battery_hook_unregister(struct acpi_battery_hook *hook)
 {
-	__battery_hook_unregister(hook, 1);
+	mutex_lock(&hook_mutex);
+	/*
+	 * Ignore already unregistered battery hooks. This might happen
+	 * if a battery hook was previously unloaded due to an error when
+	 * adding a new battery.
+	 */
+	if (!list_empty(&hook->list))
+		battery_hook_unregister_unlocked(hook);
+
+	mutex_unlock(&hook_mutex);
 }
 EXPORT_SYMBOL_GPL(battery_hook_unregister);
 
@@ -733,7 +740,6 @@ void battery_hook_register(struct acpi_battery_hook *hook)
 	struct acpi_battery *battery;
 
 	mutex_lock(&hook_mutex);
-	INIT_LIST_HEAD(&hook->list);
 	list_add(&hook->list, &battery_hook_list);
 	/*
 	 * Now that the driver is registered, we need
@@ -750,7 +756,7 @@ void battery_hook_register(struct acpi_battery_hook *hook)
 			 * hooks.
 			 */
 			pr_err("extension failed to load: %s", hook->name);
-			__battery_hook_unregister(hook, 0);
+			battery_hook_unregister_unlocked(hook);
 			goto end;
 		}
 
@@ -789,7 +795,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
 			 */
 			pr_err("error in extension, unloading: %s",
 					hook_node->name);
-			__battery_hook_unregister(hook_node, 0);
+			battery_hook_unregister_unlocked(hook_node);
 		}
 	}
 	mutex_unlock(&hook_mutex);
@@ -822,7 +828,7 @@ static void __exit battery_hook_exit(void)
 	 * need to remove the hooks.
 	 */
 	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
-		__battery_hook_unregister(hook, 1);
+		battery_hook_unregister(hook);
 	}
 	mutex_destroy(&hook_mutex);
 }
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2a588e4ed4af..6a048d44fbcf 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -103,6 +103,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 				(cpc)->cpc_entry.reg.space_id ==	\
 				ACPI_ADR_SPACE_PLATFORM_COMM)
 
+/* Check if a CPC register is in FFH */
+#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&		\
+				(cpc)->cpc_entry.reg.space_id ==	\
+				ACPI_ADR_SPACE_FIXED_HARDWARE)
+
 /* Check if a CPC register is in SystemMemory */
 #define CPC_IN_SYSTEM_MEMORY(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&	\
 				(cpc)->cpc_entry.reg.space_id ==	\
@@ -1519,9 +1524,12 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 		/* after writing CPC, transfer the ownership of PCC to platform */
 		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
 		up_write(&pcc_ss_data->pcc_lock);
+	} else if (osc_cpc_flexible_adr_space_confirmed &&
+		   CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg)) {
+		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
 	} else {
 		ret = -ENOTSUPP;
-		pr_debug("_CPC in PCC is not supported\n");
+		pr_debug("_CPC in PCC and _CPC in FFH are not supported\n");
 	}
 
 	return ret;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 38d2f6e6b12b..25399f6dde7e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -783,6 +783,9 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	unsigned long tmp;
 	int ret = 0;
 
+	if (t->rdata)
+		memset(t->rdata, 0, t->rlen);
+
 	/* start transaction */
 	spin_lock_irqsave(&ec->lock, tmp);
 	/* Enable GPE for command processing (IBF=0/OBF=1) */
@@ -819,8 +822,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 
 	if (!ec || (!t) || (t->wlen && !t->wdata) || (t->rlen && !t->rdata))
 		return -EINVAL;
-	if (t->rdata)
-		memset(t->rdata, 0, t->rlen);
 
 	mutex_lock(&ec->mutex);
 	if (ec->global_lock) {
@@ -847,7 +848,7 @@ static int acpi_ec_burst_enable(struct acpi_ec *ec)
 				.wdata = NULL, .rdata = &d,
 				.wlen = 0, .rlen = 1};
 
-	return acpi_ec_transaction(ec, &t);
+	return acpi_ec_transaction_unlocked(ec, &t);
 }
 
 static int acpi_ec_burst_disable(struct acpi_ec *ec)
@@ -857,7 +858,7 @@ static int acpi_ec_burst_disable(struct acpi_ec *ec)
 				.wlen = 0, .rlen = 0};
 
 	return (acpi_ec_read_status(ec) & ACPI_EC_FLAG_BURST) ?
-				acpi_ec_transaction(ec, &t) : 0;
+				acpi_ec_transaction_unlocked(ec, &t) : 0;
 }
 
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
@@ -873,6 +874,19 @@ static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
 	return result;
 }
 
+static int acpi_ec_read_unlocked(struct acpi_ec *ec, u8 address, u8 *data)
+{
+	int result;
+	u8 d;
+	struct transaction t = {.command = ACPI_EC_COMMAND_READ,
+				.wdata = &address, .rdata = &d,
+				.wlen = 1, .rlen = 1};
+
+	result = acpi_ec_transaction_unlocked(ec, &t);
+	*data = d;
+	return result;
+}
+
 static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 {
 	u8 wdata[2] = { address, data };
@@ -883,6 +897,16 @@ static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 	return acpi_ec_transaction(ec, &t);
 }
 
+static int acpi_ec_write_unlocked(struct acpi_ec *ec, u8 address, u8 data)
+{
+	u8 wdata[2] = { address, data };
+	struct transaction t = {.command = ACPI_EC_COMMAND_WRITE,
+				.wdata = wdata, .rdata = NULL,
+				.wlen = 2, .rlen = 0};
+
+	return acpi_ec_transaction_unlocked(ec, &t);
+}
+
 int ec_read(u8 addr, u8 *val)
 {
 	int err;
@@ -1323,6 +1347,7 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	struct acpi_ec *ec = handler_context;
 	int result = 0, i, bytes = bits / 8;
 	u8 *value = (u8 *)value64;
+	u32 glk;
 
 	if ((address > 0xFF) || !value || !handler_context)
 		return AE_BAD_PARAMETER;
@@ -1330,13 +1355,25 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (function != ACPI_READ && function != ACPI_WRITE)
 		return AE_BAD_PARAMETER;
 
+	mutex_lock(&ec->mutex);
+
+	if (ec->global_lock) {
+		acpi_status status;
+
+		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
+		if (ACPI_FAILURE(status)) {
+			result = -ENODEV;
+			goto unlock;
+		}
+	}
+
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);
 
 	for (i = 0; i < bytes; ++i, ++address, ++value) {
 		result = (function == ACPI_READ) ?
-			acpi_ec_read(ec, address, value) :
-			acpi_ec_write(ec, address, *value);
+			acpi_ec_read_unlocked(ec, address, value) :
+			acpi_ec_write_unlocked(ec, address, *value);
 		if (result < 0)
 			break;
 	}
@@ -1344,6 +1381,12 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
 
+	if (ec->global_lock)
+		acpi_release_global_lock(glk);
+
+unlock:
+	mutex_unlock(&ec->mutex);
+
 	switch (result) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index cb2aacbb9335..3d74ebe9dbd8 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
+	{
+		/* Asus Vivobook X1704VAP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "X1704VAP"),
+		},
+	},
 	{
 		/* Asus ExpertBook B1402CBA */
 		.matches = {
@@ -504,17 +511,24 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
 		},
 	},
 	{
-		/* Asus Vivobook E1504GA */
+		/* Asus ExpertBook B2502CVA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "E1504GA"),
+			DMI_MATCH(DMI_BOARD_NAME, "B2502CVA"),
 		},
 	},
 	{
-		/* Asus Vivobook E1504GAB */
+		/* Asus Vivobook Go E1404GA* */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "E1504GAB"),
+			DMI_MATCH(DMI_BOARD_NAME, "E1404GA"),
+		},
+	},
+	{
+		/* Asus Vivobook E1504GA* */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "E1504GA"),
 		},
 	},
 	{
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 75a5f559402f..b05064578293 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -254,6 +254,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "PCG-FRV35"),
 		},
 	},
+	{
+	 .callback = video_detect_force_vendor,
+	 /* Panasonic Toughbook CF-18 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Matsushita Electric Industrial"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "CF-18"),
+		},
+	},
 
 	/*
 	 * Toshiba models with Transflective display, these need to use
@@ -836,6 +844,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	 * controller board in their ACPI tables (and may even have one), but
 	 * which need native backlight control nevertheless.
 	 */
+	{
+	 /* https://github.com/zabbly/linux/issues/26 */
+	 .callback = video_detect_force_native,
+	 /* Dell OptiPlex 5480 AIO */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 5480 AIO"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=2303936 */
 	 .callback = video_detect_force_native,
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 549ff24a9823..4edddf6bcc15 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -46,10 +46,11 @@
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
 
-/* Seagate Barracuda ATA IV Family drives in UDMA mode 5
- * can overrun their FIFOs when used with the CSB5 */
-
-static const char *csb_bad_ata100[] = {
+/*
+ * Seagate Barracuda ATA IV Family drives in UDMA mode 5
+ * can overrun their FIFOs when used with the CSB5.
+ */
+static const char * const csb_bad_ata100[] = {
 	"ST320011A",
 	"ST340016A",
 	"ST360021A",
@@ -163,10 +164,11 @@ static unsigned int serverworks_osb4_filter(struct ata_device *adev, unsigned in
  *	@adev: ATA device
  *	@mask: Mask of proposed modes
  *
- *	Check the blacklist and disable UDMA5 if matched
+ *	Check the list of devices with broken UDMA5 and
+ *	disable UDMA5 if matched.
  */
-
-static unsigned int serverworks_csb_filter(struct ata_device *adev, unsigned int mask)
+static unsigned int serverworks_csb_filter(struct ata_device *adev,
+					   unsigned int mask)
 {
 	const char *p;
 	char model_num[ATA_ID_PROD_LEN + 1];
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index cc77c0248284..df095659bae0 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -128,7 +128,7 @@ static const struct pci_device_id sil_pci_tbl[] = {
 static const struct sil_drivelist {
 	const char *product;
 	unsigned int quirk;
-} sil_blacklist [] = {
+} sil_quirks[] = {
 	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
@@ -600,8 +600,8 @@ static void sil_thaw(struct ata_port *ap)
  *	list, and apply the fixups to only the specific
  *	devices/hosts/firmwares that need it.
  *
- *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
- *	The Maxtor quirk is in the blacklist, but I'm keeping the original
+ *	20040111 - Seagate drives affected by the Mod15Write bug are quirked
+ *	The Maxtor quirk is in sil_quirks, but I'm keeping the original
  *	pessimistic fix for the following reasons...
  *	- There seems to be less info on it, only one device gleaned off the
  *	Windows	driver, maybe only one is affected.  More info would be greatly
@@ -620,9 +620,9 @@ static void sil_dev_config(struct ata_device *dev)
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
-	for (n = 0; sil_blacklist[n].product; n++)
-		if (!strcmp(sil_blacklist[n].product, model_num)) {
-			quirks = sil_blacklist[n].quirk;
+	for (n = 0; sil_quirks[n].product; n++)
+		if (!strcmp(sil_quirks[n].product, model_num)) {
+			quirks = sil_quirks[n].quirk;
 			break;
 		}
 
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index cc9077b588d7..d1f4ddc57645 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -361,6 +361,7 @@ ata_rw_frameinit(struct frame *f)
 	}
 
 	ah->cmdstat = ATA_CMD_PIO_READ | writebit | extbit;
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 }
 
@@ -401,6 +402,8 @@ aoecmd_ata_rw(struct aoedev *d)
 		__skb_queue_head_init(&queue);
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
+	} else {
+		dev_put(f->t->ifp->nd);
 	}
 	return 1;
 }
@@ -483,10 +486,13 @@ resend(struct aoedev *d, struct frame *f)
 	memcpy(h->dst, t->addr, sizeof h->dst);
 	memcpy(h->src, t->ifp->nd->dev_addr, sizeof h->src);
 
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 	skb = skb_clone(skb, GFP_ATOMIC);
-	if (skb == NULL)
+	if (skb == NULL) {
+		dev_put(t->ifp->nd);
 		return;
+	}
 	f->sent = ktime_get();
 	__skb_queue_head_init(&queue);
 	__skb_queue_tail(&queue, skb);
@@ -617,6 +623,8 @@ probe(struct aoetgt *t)
 		__skb_queue_head_init(&queue);
 		__skb_queue_tail(&queue, skb);
 		aoenet_xmit(&queue);
+	} else {
+		dev_put(f->t->ifp->nd);
 	}
 }
 
@@ -1395,6 +1403,7 @@ aoecmd_ata_id(struct aoedev *d)
 	ah->cmdstat = ATA_CMD_ID_ATA;
 	ah->lba3 = 0xa0;
 
+	dev_hold(t->ifp->nd);
 	skb->dev = t->ifp->nd;
 
 	d->rttavg = RTTAVG_INIT;
@@ -1404,6 +1413,8 @@ aoecmd_ata_id(struct aoedev *d)
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (skb)
 		f->sent = ktime_get();
+	else
+		dev_put(t->ifp->nd);
 
 	return skb;
 }
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1153721bc7c2..41cfcf9efcfc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -211,13 +211,10 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	if (lo->lo_state == Lo_bound)
 		blk_mq_freeze_queue(lo->lo_queue);
 	lo->use_dio = use_dio;
-	if (use_dio) {
-		blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, lo->lo_queue);
+	if (use_dio)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
-	} else {
-		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, lo->lo_queue);
+	else
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
-	}
 	if (lo->lo_state == Lo_bound)
 		blk_mq_unfreeze_queue(lo->lo_queue);
 }
@@ -2059,14 +2056,6 @@ static int loop_add(int i)
 	}
 	lo->lo_queue = lo->lo_disk->queue;
 
-	/*
-	 * By default, we do buffer IO, so it doesn't make sense to enable
-	 * merge because the I/O submitted to backing file is handled page by
-	 * page. For directio mode, merge does help to dispatch bigger request
-	 * to underlayer disk. We will enable merge once directio is enabled.
-	 */
-	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, lo->lo_queue);
-
 	/*
 	 * Disable partition scanning by default. The in-kernel partition
 	 * scanning can be requested individually per-device during its
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 85b7f2bb4259..07cd308f7abf 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -92,7 +92,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 		} else {
 			ret = devm_request_irq(dev, cfg->irq_bt,
 					       btmrvl_wake_irq_bt,
-					       0, "bt_wake", card);
+					       IRQF_NO_AUTOEN, "bt_wake", card);
 			if (ret) {
 				dev_err(dev,
 					"Failed to request irq_bt %d (%d)\n",
@@ -101,7 +101,6 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 
 			/* Configure wakeup (enabled by default) */
 			device_init_wakeup(dev, true);
-			disable_irq(cfg->irq_bt);
 		}
 	}
 
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index bfcb41a57655..78b5d44558d7 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1296,6 +1296,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 			btrealtek_set_flag(hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP);
 
 		if (btrtl_dev->project_id == CHIP_ID_8852A ||
+		    btrtl_dev->project_id == CHIP_ID_8852B ||
 		    btrtl_dev->project_id == CHIP_ID_8852C)
 			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c41b86608ba8..dd7d9b7fd1c4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -539,6 +539,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 2720cbc40e0a..b98d7226d0ae 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1665,7 +1665,7 @@ static int __alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (ret < 0)
 		return ret;
 
-	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_update_bits(pll->clkr.regmap, PLL_L_VAL(pll), LUCID_EVO_PLL_L_VAL_MASK,  l);
 	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
 
 	/* Latch the PLL input */
diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index bb82abeed88f..4acde937114a 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -263,6 +263,8 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
 		cmd_state = 0;
 	}
 
+	cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
+
 	if (c->last_sent_aggr_state != cmd_state) {
 		cmd.addr = c->res_addr;
 		cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);
diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index 2103e22ca3dd..425dbd62c2c1 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -849,6 +849,7 @@ static struct clk_branch disp_cc_mdss_dp_link1_intf_clk = {
 				&disp_cc_mdss_dp_link1_div_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -884,6 +885,7 @@ static struct clk_branch disp_cc_mdss_dp_link_intf_clk = {
 				&disp_cc_mdss_dp_link_div_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1009,6 +1011,7 @@ static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
 				&disp_cc_mdss_mdp_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
index 5261bfc92b3d..71ab56adab7c 100644
--- a/drivers/clk/qcom/gcc-sc8180x.c
+++ b/drivers/clk/qcom/gcc-sc8180x.c
@@ -142,6 +142,23 @@ static struct clk_alpha_pll gpll7 = {
 	},
 };
 
+static struct clk_alpha_pll gpll9 = {
+	.offset = 0x1c000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TRION],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(9),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gpll9",
+			.parent_data = &(const struct clk_parent_data) {
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_trion_ops,
+		},
+	},
+};
+
 static const struct parent_map gcc_parent_map_0[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
@@ -241,7 +258,7 @@ static const struct parent_map gcc_parent_map_7[] = {
 static const struct clk_parent_data gcc_parents_7[] = {
 	{ .fw_name = "bi_tcxo", },
 	{ .hw = &gpll0.clkr.hw },
-	{ .name = "gppl9" },
+	{ .hw = &gpll9.clkr.hw },
 	{ .hw = &gpll4.clkr.hw },
 	{ .hw = &gpll0_out_even.clkr.hw },
 };
@@ -260,28 +277,6 @@ static const struct clk_parent_data gcc_parents_8[] = {
 	{ .hw = &gpll0_out_even.clkr.hw },
 };
 
-static const struct freq_tbl ftbl_gcc_cpuss_ahb_clk_src[] = {
-	F(19200000, P_BI_TCXO, 1, 0, 0),
-	F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
-	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
-	.cmd_rcgr = 0x48014,
-	.mnd_width = 0,
-	.hid_width = 5,
-	.parent_map = gcc_parent_map_0,
-	.freq_tbl = ftbl_gcc_cpuss_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gcc_cpuss_ahb_clk_src",
-		.parent_data = gcc_parents_0,
-		.num_parents = ARRAY_SIZE(gcc_parents_0),
-		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_emac_ptp_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),
@@ -916,7 +911,7 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	F(25000000, P_GPLL0_OUT_MAIN, 12, 1, 2),
 	F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
 	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
-	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	F(202000000, P_GPLL9_OUT_MAIN, 4, 0, 0),
 	{ }
 };
 
@@ -939,9 +934,8 @@ static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
 	F(400000, P_BI_TCXO, 12, 1, 4),
 	F(9600000, P_BI_TCXO, 2, 0, 0),
 	F(19200000, P_BI_TCXO, 1, 0, 0),
-	F(37500000, P_GPLL0_OUT_MAIN, 16, 0, 0),
 	F(50000000, P_GPLL0_OUT_MAIN, 12, 0, 0),
-	F(75000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
 	{ }
 };
 
@@ -1599,25 +1593,6 @@ static struct clk_branch gcc_cfg_noc_usb3_sec_axi_clk = {
 	},
 };
 
-/* For CPUSS functionality the AHB clock needs to be left enabled */
-static struct clk_branch gcc_cpuss_ahb_clk = {
-	.halt_reg = 0x48000,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x52004,
-		.enable_mask = BIT(21),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_cpuss_ahb_clk",
-			.parent_hws = (const struct clk_hw *[]){
-				      &gcc_cpuss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_cpuss_rbcpr_clk = {
 	.halt_reg = 0x48008,
 	.halt_check = BRANCH_HALT,
@@ -3150,25 +3125,6 @@ static struct clk_branch gcc_sdcc4_apps_clk = {
 	},
 };
 
-/* For CPUSS functionality the SYS NOC clock needs to be left enabled */
-static struct clk_branch gcc_sys_noc_cpuss_ahb_clk = {
-	.halt_reg = 0x4819c,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x52004,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_sys_noc_cpuss_ahb_clk",
-			.parent_hws = (const struct clk_hw *[]){
-				      &gcc_cpuss_ahb_clk_src.clkr.hw
-			},
-			.num_parents = 1,
-			.flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_tsif_ahb_clk = {
 	.halt_reg = 0x36004,
 	.halt_check = BRANCH_HALT,
@@ -4284,8 +4240,6 @@ static struct clk_regmap *gcc_sc8180x_clocks[] = {
 	[GCC_CFG_NOC_USB3_MP_AXI_CLK] = &gcc_cfg_noc_usb3_mp_axi_clk.clkr,
 	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
 	[GCC_CFG_NOC_USB3_SEC_AXI_CLK] = &gcc_cfg_noc_usb3_sec_axi_clk.clkr,
-	[GCC_CPUSS_AHB_CLK] = &gcc_cpuss_ahb_clk.clkr,
-	[GCC_CPUSS_AHB_CLK_SRC] = &gcc_cpuss_ahb_clk_src.clkr,
 	[GCC_CPUSS_RBCPR_CLK] = &gcc_cpuss_rbcpr_clk.clkr,
 	[GCC_DDRSS_GPU_AXI_CLK] = &gcc_ddrss_gpu_axi_clk.clkr,
 	[GCC_DISP_HF_AXI_CLK] = &gcc_disp_hf_axi_clk.clkr,
@@ -4422,7 +4376,6 @@ static struct clk_regmap *gcc_sc8180x_clocks[] = {
 	[GCC_SDCC4_AHB_CLK] = &gcc_sdcc4_ahb_clk.clkr,
 	[GCC_SDCC4_APPS_CLK] = &gcc_sdcc4_apps_clk.clkr,
 	[GCC_SDCC4_APPS_CLK_SRC] = &gcc_sdcc4_apps_clk_src.clkr,
-	[GCC_SYS_NOC_CPUSS_AHB_CLK] = &gcc_sys_noc_cpuss_ahb_clk.clkr,
 	[GCC_TSIF_AHB_CLK] = &gcc_tsif_ahb_clk.clkr,
 	[GCC_TSIF_INACTIVITY_TIMERS_CLK] = &gcc_tsif_inactivity_timers_clk.clkr,
 	[GCC_TSIF_REF_CLK] = &gcc_tsif_ref_clk.clkr,
@@ -4511,6 +4464,7 @@ static struct clk_regmap *gcc_sc8180x_clocks[] = {
 	[GPLL1] = &gpll1.clkr,
 	[GPLL4] = &gpll4.clkr,
 	[GPLL7] = &gpll7.clkr,
+	[GPLL9] = &gpll9.clkr,
 };
 
 static const struct qcom_reset_map gcc_sc8180x_resets[] = {
diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index e630bfa2d0c1..e71b7b7cb514 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -3226,7 +3226,7 @@ static struct gdsc pcie_0_gdsc = {
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc pcie_1_gdsc = {
@@ -3234,7 +3234,7 @@ static struct gdsc pcie_1_gdsc = {
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc pcie_2_gdsc = {
@@ -3242,7 +3242,7 @@ static struct gdsc pcie_2_gdsc = {
 	.pd = {
 		.name = "pcie_2_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc ufs_card_gdsc = {
diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index e86c58bc5e48..827f574e99b2 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -2974,7 +2974,7 @@ static struct gdsc pcie_0_gdsc = {
 	.pd = {
 		.name = "pcie_0_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc pcie_1_gdsc = {
@@ -2982,7 +2982,7 @@ static struct gdsc pcie_1_gdsc = {
 	.pd = {
 		.name = "pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc ufs_phy_gdsc = {
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 73d2cbdc716b..2fa7253c73b2 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -450,12 +450,13 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
 				    struct rockchip_clk_branch *list,
 				    unsigned int nr_clk)
 {
-	struct clk *clk = NULL;
+	struct clk *clk;
 	unsigned int idx;
 	unsigned long flags;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		flags = list->flags;
+		clk = NULL;
 
 		/* catch simple muxes */
 		switch (list->branch_type) {
diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index f7d7427a558b..87387d4cbf48 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -20,7 +20,7 @@
 #define CLKS_NR_TOP			(CLK_GOUT_FSYS_USB30DRD + 1)
 #define CLKS_NR_CORE			(CLK_GOUT_TREX_P_CORE_PCLK_P_CORE + 1)
 #define CLKS_NR_PERI			(CLK_GOUT_WDT1_PCLK + 1)
-#define CLKS_NR_FSYS			(CLK_GOUT_MMC_SDIO_SDCLKIN + 1)
+#define CLKS_NR_FSYS			(CLK_MOUT_FSYS_USB30DRD_USER + 1)
 
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c31914a9876f..b694e474acec 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1622,7 +1622,7 @@ static void intel_pstate_notify_work(struct work_struct *work)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 }
 
-static DEFINE_SPINLOCK(hwp_notify_lock);
+static DEFINE_RAW_SPINLOCK(hwp_notify_lock);
 static cpumask_t hwp_intr_enable_mask;
 
 void notify_hwp_interrupt(void)
@@ -1638,7 +1638,7 @@ void notify_hwp_interrupt(void)
 	if (!(value & 0x01))
 		return;
 
-	spin_lock_irqsave(&hwp_notify_lock, flags);
+	raw_spin_lock_irqsave(&hwp_notify_lock, flags);
 
 	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
 		goto ack_intr;
@@ -1646,13 +1646,13 @@ void notify_hwp_interrupt(void)
 	schedule_delayed_work(&all_cpu_data[this_cpu]->hwp_notify_work,
 			      msecs_to_jiffies(10));
 
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 
 	return;
 
 ack_intr:
 	wrmsrl_safe(MSR_HWP_STATUS, 0);
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 }
 
 static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
@@ -1665,9 +1665,9 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
-	spin_lock_irq(&hwp_notify_lock);
+	raw_spin_lock_irq(&hwp_notify_lock);
 	cancel_work = cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask);
-	spin_unlock_irq(&hwp_notify_lock);
+	raw_spin_unlock_irq(&hwp_notify_lock);
 
 	if (cancel_work)
 		cancel_delayed_work_sync(&cpudata->hwp_notify_work);
@@ -1677,10 +1677,10 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 {
 	/* Enable HWP notification interrupt for guaranteed performance change */
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
-		spin_lock_irq(&hwp_notify_lock);
+		raw_spin_lock_irq(&hwp_notify_lock);
 		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
 		cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
-		spin_unlock_irq(&hwp_notify_lock);
+		raw_spin_unlock_irq(&hwp_notify_lock);
 
 		/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 568acd0aee3f..c974f95cd126 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -225,7 +225,7 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 	dma_addr_t curr_sgl_dma = 0;
 	struct acc_hw_sge *curr_hw_sge;
 	struct scatterlist *sg;
-	int sg_n;
+	int sg_n, ret;
 
 	if (!dev || !sgl || !pool || !hw_sgl_dma || index >= pool->count)
 		return ERR_PTR(-EINVAL);
@@ -240,14 +240,15 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 
 	if (sg_n_mapped > pool->sge_nr) {
 		dev_err(dev, "the number of entries in input scatterlist is bigger than SGL pool setting.\n");
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto err_unmap;
 	}
 
 	curr_hw_sgl = acc_get_sgl(pool, index, &curr_sgl_dma);
 	if (IS_ERR(curr_hw_sgl)) {
 		dev_err(dev, "Get SGL error!\n");
-		dma_unmap_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto err_unmap;
 	}
 	curr_hw_sgl->entry_length_in_sgl = cpu_to_le16(pool->sge_nr);
 	curr_hw_sge = curr_hw_sgl->sge_entries;
@@ -262,6 +263,11 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 	*hw_sgl_dma = curr_sgl_dma;
 
 	return curr_hw_sgl;
+
+err_unmap:
+	dma_unmap_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(hisi_acc_sg_buf_map_to_hw_sgl);
 
diff --git a/drivers/crypto/marvell/Kconfig b/drivers/crypto/marvell/Kconfig
index a48591af12d0..78217577aa54 100644
--- a/drivers/crypto/marvell/Kconfig
+++ b/drivers/crypto/marvell/Kconfig
@@ -28,6 +28,7 @@ config CRYPTO_DEV_OCTEONTX_CPT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH
 	select CRYPTO_AEAD
+	select CRYPTO_AUTHENC
 	select CRYPTO_DEV_MARVELL
 	help
 		This driver allows you to utilize the Marvell Cryptographic
@@ -47,6 +48,7 @@ config CRYPTO_DEV_OCTEONTX2_CPT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH
 	select CRYPTO_AEAD
+	select CRYPTO_AUTHENC
 	select NET_DEVLINK
 	help
 		This driver allows you to utilize the Marvell Cryptographic
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
index 3c5d577d8f0d..0a1b85ad0057 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
@@ -17,7 +17,6 @@
 #include <crypto/sha2.h>
 #include <crypto/xts.h>
 #include <crypto/scatterwalk.h>
-#include <linux/rtnetlink.h>
 #include <linux/sort.h>
 #include <linux/module.h>
 #include "otx_cptvf.h"
@@ -66,6 +65,8 @@ static struct cpt_device_table ae_devices = {
 	.count = ATOMIC_INIT(0)
 };
 
+static struct otx_cpt_sdesc *alloc_sdesc(struct crypto_shash *alg);
+
 static inline int get_se_device(struct pci_dev **pdev, int *cpu_num)
 {
 	int count, ret = 0;
@@ -509,44 +510,61 @@ static int cpt_aead_init(struct crypto_aead *tfm, u8 cipher_type, u8 mac_type)
 	ctx->cipher_type = cipher_type;
 	ctx->mac_type = mac_type;
 
+	switch (ctx->mac_type) {
+	case OTX_CPT_SHA1:
+		ctx->hashalg = crypto_alloc_shash("sha1", 0, 0);
+		break;
+
+	case OTX_CPT_SHA256:
+		ctx->hashalg = crypto_alloc_shash("sha256", 0, 0);
+		break;
+
+	case OTX_CPT_SHA384:
+		ctx->hashalg = crypto_alloc_shash("sha384", 0, 0);
+		break;
+
+	case OTX_CPT_SHA512:
+		ctx->hashalg = crypto_alloc_shash("sha512", 0, 0);
+		break;
+	}
+
+	if (IS_ERR(ctx->hashalg))
+		return PTR_ERR(ctx->hashalg);
+
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct otx_cpt_req_ctx));
+
+	if (!ctx->hashalg)
+		return 0;
+
 	/*
 	 * When selected cipher is NULL we use HMAC opcode instead of
 	 * FLEXICRYPTO opcode therefore we don't need to use HASH algorithms
 	 * for calculating ipad and opad
 	 */
 	if (ctx->cipher_type != OTX_CPT_CIPHER_NULL) {
-		switch (ctx->mac_type) {
-		case OTX_CPT_SHA1:
-			ctx->hashalg = crypto_alloc_shash("sha1", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
-
-		case OTX_CPT_SHA256:
-			ctx->hashalg = crypto_alloc_shash("sha256", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		int ss = crypto_shash_statesize(ctx->hashalg);
 
-		case OTX_CPT_SHA384:
-			ctx->hashalg = crypto_alloc_shash("sha384", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->ipad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->ipad) {
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
+		}
 
-		case OTX_CPT_SHA512:
-			ctx->hashalg = crypto_alloc_shash("sha512", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->opad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->opad) {
+			kfree(ctx->ipad);
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
 		}
 	}
 
-	crypto_aead_set_reqsize_dma(tfm, sizeof(struct otx_cpt_req_ctx));
+	ctx->sdesc = alloc_sdesc(ctx->hashalg);
+	if (!ctx->sdesc) {
+		kfree(ctx->opad);
+		kfree(ctx->ipad);
+		crypto_free_shash(ctx->hashalg);
+		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -602,8 +620,7 @@ static void otx_cpt_aead_exit(struct crypto_aead *tfm)
 
 	kfree(ctx->ipad);
 	kfree(ctx->opad);
-	if (ctx->hashalg)
-		crypto_free_shash(ctx->hashalg);
+	crypto_free_shash(ctx->hashalg);
 	kfree(ctx->sdesc);
 }
 
@@ -699,7 +716,7 @@ static inline void swap_data64(void *buf, u32 len)
 		*dst = cpu_to_be64p(src);
 }
 
-static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
+static int swap_pad(u8 mac_type, u8 *pad)
 {
 	struct sha512_state *sha512;
 	struct sha256_state *sha256;
@@ -707,22 +724,19 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 
 	switch (mac_type) {
 	case OTX_CPT_SHA1:
-		sha1 = (struct sha1_state *) in_pad;
+		sha1 = (struct sha1_state *)pad;
 		swap_data32(sha1->state, SHA1_DIGEST_SIZE);
-		memcpy(out_pad, &sha1->state, SHA1_DIGEST_SIZE);
 		break;
 
 	case OTX_CPT_SHA256:
-		sha256 = (struct sha256_state *) in_pad;
+		sha256 = (struct sha256_state *)pad;
 		swap_data32(sha256->state, SHA256_DIGEST_SIZE);
-		memcpy(out_pad, &sha256->state, SHA256_DIGEST_SIZE);
 		break;
 
 	case OTX_CPT_SHA384:
 	case OTX_CPT_SHA512:
-		sha512 = (struct sha512_state *) in_pad;
+		sha512 = (struct sha512_state *)pad;
 		swap_data64(sha512->state, SHA512_DIGEST_SIZE);
-		memcpy(out_pad, &sha512->state, SHA512_DIGEST_SIZE);
 		break;
 
 	default:
@@ -732,55 +746,53 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 	return 0;
 }
 
-static int aead_hmac_init(struct crypto_aead *cipher)
+static int aead_hmac_init(struct crypto_aead *cipher,
+			  struct crypto_authenc_keys *keys)
 {
 	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	int state_size = crypto_shash_statesize(ctx->hashalg);
 	int ds = crypto_shash_digestsize(ctx->hashalg);
 	int bs = crypto_shash_blocksize(ctx->hashalg);
-	int authkeylen = ctx->auth_key_len;
+	int authkeylen = keys->authkeylen;
 	u8 *ipad = NULL, *opad = NULL;
-	int ret = 0, icount = 0;
+	int icount = 0;
+	int ret;
 
-	ctx->sdesc = alloc_sdesc(ctx->hashalg);
-	if (!ctx->sdesc)
-		return -ENOMEM;
+	if (authkeylen > bs) {
+		ret = crypto_shash_digest(&ctx->sdesc->shash, keys->authkey,
+					  authkeylen, ctx->key);
+		if (ret)
+			return ret;
+		authkeylen = ds;
+	} else
+		memcpy(ctx->key, keys->authkey, authkeylen);
 
-	ctx->ipad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	ctx->enc_key_len = keys->enckeylen;
+	ctx->auth_key_len = authkeylen;
 
-	ctx->opad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	if (ctx->cipher_type == OTX_CPT_CIPHER_NULL)
+		return keys->enckeylen ? -EINVAL : 0;
 
-	ipad = kzalloc(state_size, GFP_KERNEL);
-	if (!ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
+	switch (keys->enckeylen) {
+	case AES_KEYSIZE_128:
+		ctx->key_type = OTX_CPT_AES_128_BIT;
+		break;
+	case AES_KEYSIZE_192:
+		ctx->key_type = OTX_CPT_AES_192_BIT;
+		break;
+	case AES_KEYSIZE_256:
+		ctx->key_type = OTX_CPT_AES_256_BIT;
+		break;
+	default:
+		/* Invalid key length */
+		return -EINVAL;
 	}
 
-	opad = kzalloc(state_size, GFP_KERNEL);
-	if (!opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	memcpy(ctx->key + authkeylen, keys->enckey, keys->enckeylen);
 
-	if (authkeylen > bs) {
-		ret = crypto_shash_digest(&ctx->sdesc->shash, ctx->key,
-					  authkeylen, ipad);
-		if (ret)
-			goto calc_fail;
-
-		authkeylen = ds;
-	} else {
-		memcpy(ipad, ctx->key, authkeylen);
-	}
+	ipad = ctx->ipad;
+	opad = ctx->opad;
 
+	memcpy(ipad, ctx->key, authkeylen);
 	memset(ipad + authkeylen, 0, bs - authkeylen);
 	memcpy(opad, ipad, bs);
 
@@ -798,7 +810,7 @@ static int aead_hmac_init(struct crypto_aead *cipher)
 	crypto_shash_init(&ctx->sdesc->shash);
 	crypto_shash_update(&ctx->sdesc->shash, ipad, bs);
 	crypto_shash_export(&ctx->sdesc->shash, ipad);
-	ret = copy_pad(ctx->mac_type, ctx->ipad, ipad);
+	ret = swap_pad(ctx->mac_type, ipad);
 	if (ret)
 		goto calc_fail;
 
@@ -806,25 +818,9 @@ static int aead_hmac_init(struct crypto_aead *cipher)
 	crypto_shash_init(&ctx->sdesc->shash);
 	crypto_shash_update(&ctx->sdesc->shash, opad, bs);
 	crypto_shash_export(&ctx->sdesc->shash, opad);
-	ret = copy_pad(ctx->mac_type, ctx->opad, opad);
-	if (ret)
-		goto calc_fail;
-
-	kfree(ipad);
-	kfree(opad);
-
-	return 0;
+	ret = swap_pad(ctx->mac_type, opad);
 
 calc_fail:
-	kfree(ctx->ipad);
-	ctx->ipad = NULL;
-	kfree(ctx->opad);
-	ctx->opad = NULL;
-	kfree(ipad);
-	kfree(opad);
-	kfree(ctx->sdesc);
-	ctx->sdesc = NULL;
-
 	return ret;
 }
 
@@ -832,57 +828,15 @@ static int otx_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
 					   const unsigned char *key,
 					   unsigned int keylen)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	int enckeylen = 0, authkeylen = 0;
-	struct rtattr *rta = (void *)key;
-	int status = -EINVAL;
-
-	if (!RTA_OK(rta, keylen))
-		goto badkey;
-
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		goto badkey;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		goto badkey;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (keylen < enckeylen)
-		goto badkey;
+	struct crypto_authenc_keys authenc_keys;
+	int status;
 
-	if (keylen > OTX_CPT_MAX_KEY_SIZE)
-		goto badkey;
-
-	authkeylen = keylen - enckeylen;
-	memcpy(ctx->key, key, keylen);
-
-	switch (enckeylen) {
-	case AES_KEYSIZE_128:
-		ctx->key_type = OTX_CPT_AES_128_BIT;
-		break;
-	case AES_KEYSIZE_192:
-		ctx->key_type = OTX_CPT_AES_192_BIT;
-		break;
-	case AES_KEYSIZE_256:
-		ctx->key_type = OTX_CPT_AES_256_BIT;
-		break;
-	default:
-		/* Invalid key length */
-		goto badkey;
-	}
-
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = authkeylen;
-
-	status = aead_hmac_init(cipher);
+	status = crypto_authenc_extractkeys(&authenc_keys, key, keylen);
 	if (status)
 		goto badkey;
 
-	return 0;
+	status = aead_hmac_init(cipher, &authenc_keys);
+
 badkey:
 	return status;
 }
@@ -891,36 +845,7 @@ static int otx_cpt_aead_ecb_null_sha_setkey(struct crypto_aead *cipher,
 					    const unsigned char *key,
 					    unsigned int keylen)
 {
-	struct otx_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	struct rtattr *rta = (void *)key;
-	int enckeylen = 0;
-
-	if (!RTA_OK(rta, keylen))
-		goto badkey;
-
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		goto badkey;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		goto badkey;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (enckeylen != 0)
-		goto badkey;
-
-	if (keylen > OTX_CPT_MAX_KEY_SIZE)
-		goto badkey;
-
-	memcpy(ctx->key, key, keylen);
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = keylen;
-	return 0;
-badkey:
-	return -EINVAL;
+	return otx_cpt_aead_cbc_aes_sha_setkey(cipher, key, keylen);
 }
 
 static int otx_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
index 1604fc58dc13..5aa56f20f888 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
@@ -11,7 +11,6 @@
 #include <crypto/xts.h>
 #include <crypto/gcm.h>
 #include <crypto/scatterwalk.h>
-#include <linux/rtnetlink.h>
 #include <linux/sort.h>
 #include <linux/module.h>
 #include "otx2_cptvf.h"
@@ -55,6 +54,8 @@ static struct cpt_device_table se_devices = {
 	.count = ATOMIC_INIT(0)
 };
 
+static struct otx2_cpt_sdesc *alloc_sdesc(struct crypto_shash *alg);
+
 static inline int get_se_device(struct pci_dev **pdev, int *cpu_num)
 {
 	int count;
@@ -598,40 +599,56 @@ static int cpt_aead_init(struct crypto_aead *atfm, u8 cipher_type, u8 mac_type)
 	ctx->cipher_type = cipher_type;
 	ctx->mac_type = mac_type;
 
+	switch (ctx->mac_type) {
+	case OTX2_CPT_SHA1:
+		ctx->hashalg = crypto_alloc_shash("sha1", 0, 0);
+		break;
+
+	case OTX2_CPT_SHA256:
+		ctx->hashalg = crypto_alloc_shash("sha256", 0, 0);
+		break;
+
+	case OTX2_CPT_SHA384:
+		ctx->hashalg = crypto_alloc_shash("sha384", 0, 0);
+		break;
+
+	case OTX2_CPT_SHA512:
+		ctx->hashalg = crypto_alloc_shash("sha512", 0, 0);
+		break;
+	}
+
+	if (IS_ERR(ctx->hashalg))
+		return PTR_ERR(ctx->hashalg);
+
+	if (ctx->hashalg) {
+		ctx->sdesc = alloc_sdesc(ctx->hashalg);
+		if (!ctx->sdesc) {
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
+		}
+	}
+
 	/*
 	 * When selected cipher is NULL we use HMAC opcode instead of
 	 * FLEXICRYPTO opcode therefore we don't need to use HASH algorithms
 	 * for calculating ipad and opad
 	 */
-	if (ctx->cipher_type != OTX2_CPT_CIPHER_NULL) {
-		switch (ctx->mac_type) {
-		case OTX2_CPT_SHA1:
-			ctx->hashalg = crypto_alloc_shash("sha1", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
-
-		case OTX2_CPT_SHA256:
-			ctx->hashalg = crypto_alloc_shash("sha256", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+	if (ctx->cipher_type != OTX2_CPT_CIPHER_NULL && ctx->hashalg) {
+		int ss = crypto_shash_statesize(ctx->hashalg);
 
-		case OTX2_CPT_SHA384:
-			ctx->hashalg = crypto_alloc_shash("sha384", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->ipad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->ipad) {
+			kfree(ctx->sdesc);
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
+		}
 
-		case OTX2_CPT_SHA512:
-			ctx->hashalg = crypto_alloc_shash("sha512", 0,
-							  CRYPTO_ALG_ASYNC);
-			if (IS_ERR(ctx->hashalg))
-				return PTR_ERR(ctx->hashalg);
-			break;
+		ctx->opad = kzalloc(ss, GFP_KERNEL);
+		if (!ctx->opad) {
+			kfree(ctx->ipad);
+			kfree(ctx->sdesc);
+			crypto_free_shash(ctx->hashalg);
+			return -ENOMEM;
 		}
 	}
 	switch (ctx->cipher_type) {
@@ -713,8 +730,7 @@ static void otx2_cpt_aead_exit(struct crypto_aead *tfm)
 
 	kfree(ctx->ipad);
 	kfree(ctx->opad);
-	if (ctx->hashalg)
-		crypto_free_shash(ctx->hashalg);
+	crypto_free_shash(ctx->hashalg);
 	kfree(ctx->sdesc);
 
 	if (ctx->fbk_cipher) {
@@ -788,7 +804,7 @@ static inline void swap_data64(void *buf, u32 len)
 		cpu_to_be64s(src);
 }
 
-static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
+static int swap_pad(u8 mac_type, u8 *pad)
 {
 	struct sha512_state *sha512;
 	struct sha256_state *sha256;
@@ -796,22 +812,19 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 
 	switch (mac_type) {
 	case OTX2_CPT_SHA1:
-		sha1 = (struct sha1_state *) in_pad;
+		sha1 = (struct sha1_state *)pad;
 		swap_data32(sha1->state, SHA1_DIGEST_SIZE);
-		memcpy(out_pad, &sha1->state, SHA1_DIGEST_SIZE);
 		break;
 
 	case OTX2_CPT_SHA256:
-		sha256 = (struct sha256_state *) in_pad;
+		sha256 = (struct sha256_state *)pad;
 		swap_data32(sha256->state, SHA256_DIGEST_SIZE);
-		memcpy(out_pad, &sha256->state, SHA256_DIGEST_SIZE);
 		break;
 
 	case OTX2_CPT_SHA384:
 	case OTX2_CPT_SHA512:
-		sha512 = (struct sha512_state *) in_pad;
+		sha512 = (struct sha512_state *)pad;
 		swap_data64(sha512->state, SHA512_DIGEST_SIZE);
-		memcpy(out_pad, &sha512->state, SHA512_DIGEST_SIZE);
 		break;
 
 	default:
@@ -821,55 +834,54 @@ static int copy_pad(u8 mac_type, u8 *out_pad, u8 *in_pad)
 	return 0;
 }
 
-static int aead_hmac_init(struct crypto_aead *cipher)
+static int aead_hmac_init(struct crypto_aead *cipher,
+			  struct crypto_authenc_keys *keys)
 {
 	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	int state_size = crypto_shash_statesize(ctx->hashalg);
 	int ds = crypto_shash_digestsize(ctx->hashalg);
 	int bs = crypto_shash_blocksize(ctx->hashalg);
-	int authkeylen = ctx->auth_key_len;
+	int authkeylen = keys->authkeylen;
 	u8 *ipad = NULL, *opad = NULL;
-	int ret = 0, icount = 0;
+	int icount = 0;
+	int ret;
 
-	ctx->sdesc = alloc_sdesc(ctx->hashalg);
-	if (!ctx->sdesc)
-		return -ENOMEM;
+	if (authkeylen > bs) {
+		ret = crypto_shash_digest(&ctx->sdesc->shash, keys->authkey,
+					  authkeylen, ctx->key);
+		if (ret)
+			goto calc_fail;
 
-	ctx->ipad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+		authkeylen = ds;
+	} else
+		memcpy(ctx->key, keys->authkey, authkeylen);
 
-	ctx->opad = kzalloc(bs, GFP_KERNEL);
-	if (!ctx->opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	ctx->enc_key_len = keys->enckeylen;
+	ctx->auth_key_len = authkeylen;
 
-	ipad = kzalloc(state_size, GFP_KERNEL);
-	if (!ipad) {
-		ret = -ENOMEM;
-		goto calc_fail;
-	}
+	if (ctx->cipher_type == OTX2_CPT_CIPHER_NULL)
+		return keys->enckeylen ? -EINVAL : 0;
 
-	opad = kzalloc(state_size, GFP_KERNEL);
-	if (!opad) {
-		ret = -ENOMEM;
-		goto calc_fail;
+	switch (keys->enckeylen) {
+	case AES_KEYSIZE_128:
+		ctx->key_type = OTX2_CPT_AES_128_BIT;
+		break;
+	case AES_KEYSIZE_192:
+		ctx->key_type = OTX2_CPT_AES_192_BIT;
+		break;
+	case AES_KEYSIZE_256:
+		ctx->key_type = OTX2_CPT_AES_256_BIT;
+		break;
+	default:
+		/* Invalid key length */
+		return -EINVAL;
 	}
 
-	if (authkeylen > bs) {
-		ret = crypto_shash_digest(&ctx->sdesc->shash, ctx->key,
-					  authkeylen, ipad);
-		if (ret)
-			goto calc_fail;
+	memcpy(ctx->key + authkeylen, keys->enckey, keys->enckeylen);
 
-		authkeylen = ds;
-	} else {
-		memcpy(ipad, ctx->key, authkeylen);
-	}
+	ipad = ctx->ipad;
+	opad = ctx->opad;
 
+	memcpy(ipad, ctx->key, authkeylen);
 	memset(ipad + authkeylen, 0, bs - authkeylen);
 	memcpy(opad, ipad, bs);
 
@@ -887,7 +899,7 @@ static int aead_hmac_init(struct crypto_aead *cipher)
 	crypto_shash_init(&ctx->sdesc->shash);
 	crypto_shash_update(&ctx->sdesc->shash, ipad, bs);
 	crypto_shash_export(&ctx->sdesc->shash, ipad);
-	ret = copy_pad(ctx->mac_type, ctx->ipad, ipad);
+	ret = swap_pad(ctx->mac_type, ipad);
 	if (ret)
 		goto calc_fail;
 
@@ -895,25 +907,9 @@ static int aead_hmac_init(struct crypto_aead *cipher)
 	crypto_shash_init(&ctx->sdesc->shash);
 	crypto_shash_update(&ctx->sdesc->shash, opad, bs);
 	crypto_shash_export(&ctx->sdesc->shash, opad);
-	ret = copy_pad(ctx->mac_type, ctx->opad, opad);
-	if (ret)
-		goto calc_fail;
-
-	kfree(ipad);
-	kfree(opad);
-
-	return 0;
+	ret = swap_pad(ctx->mac_type, opad);
 
 calc_fail:
-	kfree(ctx->ipad);
-	ctx->ipad = NULL;
-	kfree(ctx->opad);
-	ctx->opad = NULL;
-	kfree(ipad);
-	kfree(opad);
-	kfree(ctx->sdesc);
-	ctx->sdesc = NULL;
-
 	return ret;
 }
 
@@ -921,87 +917,17 @@ static int otx2_cpt_aead_cbc_aes_sha_setkey(struct crypto_aead *cipher,
 					    const unsigned char *key,
 					    unsigned int keylen)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	int enckeylen = 0, authkeylen = 0;
-	struct rtattr *rta = (void *)key;
-
-	if (!RTA_OK(rta, keylen))
-		return -EINVAL;
+	struct crypto_authenc_keys authenc_keys;
 
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		return -EINVAL;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		return -EINVAL;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (keylen < enckeylen)
-		return -EINVAL;
-
-	if (keylen > OTX2_CPT_MAX_KEY_SIZE)
-		return -EINVAL;
-
-	authkeylen = keylen - enckeylen;
-	memcpy(ctx->key, key, keylen);
-
-	switch (enckeylen) {
-	case AES_KEYSIZE_128:
-		ctx->key_type = OTX2_CPT_AES_128_BIT;
-		break;
-	case AES_KEYSIZE_192:
-		ctx->key_type = OTX2_CPT_AES_192_BIT;
-		break;
-	case AES_KEYSIZE_256:
-		ctx->key_type = OTX2_CPT_AES_256_BIT;
-		break;
-	default:
-		/* Invalid key length */
-		return -EINVAL;
-	}
-
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = authkeylen;
-
-	return aead_hmac_init(cipher);
+	return crypto_authenc_extractkeys(&authenc_keys, key, keylen) ?:
+	       aead_hmac_init(cipher, &authenc_keys);
 }
 
 static int otx2_cpt_aead_ecb_null_sha_setkey(struct crypto_aead *cipher,
 					     const unsigned char *key,
 					     unsigned int keylen)
 {
-	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(cipher);
-	struct crypto_authenc_key_param *param;
-	struct rtattr *rta = (void *)key;
-	int enckeylen = 0;
-
-	if (!RTA_OK(rta, keylen))
-		return -EINVAL;
-
-	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
-		return -EINVAL;
-
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
-		return -EINVAL;
-
-	param = RTA_DATA(rta);
-	enckeylen = be32_to_cpu(param->enckeylen);
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
-	if (enckeylen != 0)
-		return -EINVAL;
-
-	if (keylen > OTX2_CPT_MAX_KEY_SIZE)
-		return -EINVAL;
-
-	memcpy(ctx->key, key, keylen);
-	ctx->enc_key_len = enckeylen;
-	ctx->auth_key_len = keylen;
-
-	return 0;
+	return otx2_cpt_aead_cbc_aes_sha_setkey(cipher, key, keylen);
 }
 
 static int otx2_cpt_aead_gcm_aes_setkey(struct crypto_aead *cipher,
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 02a07d3d0d40..a3df782fa687 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -67,9 +67,11 @@ static bool sysfb_unregister(void)
 void sysfb_disable(struct device *dev)
 {
 	struct screen_info *si = &screen_info;
+	struct device *parent;
 
 	mutex_lock(&disable_lock);
-	if (!dev || dev == sysfb_parent_dev(si)) {
+	parent = sysfb_parent_dev(si);
+	if (!dev || !parent || dev == parent) {
 		sysfb_unregister();
 		disabled = true;
 	}
diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index c1590d3aa9cb..c3a1dc344961 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -24,12 +24,6 @@
 #define MSG_RING	BIT(1)
 #define TAG_SZ		32
 
-static inline struct tegra_bpmp *
-mbox_client_to_bpmp(struct mbox_client *client)
-{
-	return container_of(client, struct tegra_bpmp, mbox.client);
-}
-
 static inline const struct tegra_bpmp_ops *
 channel_to_ops(struct tegra_bpmp_channel *channel)
 {
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 1d0175d6350b..0ecfa7de5ce2 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -289,7 +289,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
  * serve as EDMA event triggers.
  */
 
-static void gpio_irq_disable(struct irq_data *d)
+static void gpio_irq_mask(struct irq_data *d)
 {
 	struct davinci_gpio_regs __iomem *g = irq2regs(d);
 	uintptr_t mask = (uintptr_t)irq_data_get_irq_handler_data(d);
@@ -298,7 +298,7 @@ static void gpio_irq_disable(struct irq_data *d)
 	writel_relaxed(mask, &g->clr_rising);
 }
 
-static void gpio_irq_enable(struct irq_data *d)
+static void gpio_irq_unmask(struct irq_data *d)
 {
 	struct davinci_gpio_regs __iomem *g = irq2regs(d);
 	uintptr_t mask = (uintptr_t)irq_data_get_irq_handler_data(d);
@@ -324,8 +324,8 @@ static int gpio_irq_type(struct irq_data *d, unsigned trigger)
 
 static struct irq_chip gpio_irqchip = {
 	.name		= "GPIO",
-	.irq_enable	= gpio_irq_enable,
-	.irq_disable	= gpio_irq_disable,
+	.irq_unmask	= gpio_irq_unmask,
+	.irq_mask	= gpio_irq_mask,
 	.irq_set_type	= gpio_irq_type,
 	.flags		= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_SKIP_SET_WAKE,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 9baee7c246b6..a513819b7231 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -80,6 +80,9 @@ static void aca_banks_release(struct aca_banks *banks)
 {
 	struct aca_bank_node *node, *tmp;
 
+	if (list_empty(&banks->list))
+		return;
+
 	list_for_each_entry_safe(node, tmp, &banks->list, node) {
 		list_del(&node->node);
 		kvfree(node);
@@ -562,9 +565,13 @@ static void aca_error_fini(struct aca_error *aerr)
 	struct aca_bank_error *bank_error, *tmp;
 
 	mutex_lock(&aerr->lock);
+	if (list_empty(&aerr->list))
+		goto out_unlock;
+
 	list_for_each_entry_safe(bank_error, tmp, &aerr->list, node)
 		aca_bank_error_remove(aerr, bank_error);
 
+out_unlock:
 	mutex_destroy(&aerr->lock);
 }
 
@@ -680,6 +687,9 @@ static void aca_manager_fini(struct aca_handle_manager *mgr)
 {
 	struct aca_handle *handle, *tmp;
 
+	if (list_empty(&mgr->list))
+		return;
+
 	list_for_each_entry_safe(handle, tmp, &mgr->list, node)
 		amdgpu_aca_remove_handle(handle);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index e3738d417245..26ecca3e8e90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -360,15 +360,15 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 	return r;
 }
 
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj)
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
 {
-	struct amdgpu_bo *bo = (struct amdgpu_bo *) mem_obj;
+	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
-	amdgpu_bo_reserve(bo, true);
-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unpin(bo);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&(bo));
+	amdgpu_bo_reserve(*bo, true);
+	amdgpu_bo_kunmap(*bo);
+	amdgpu_bo_unpin(*bo);
+	amdgpu_bo_unreserve(*bo);
+	amdgpu_bo_unref(bo);
 }
 
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 1de021ebdd46..ee16d8a9ba55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -233,7 +233,7 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct amdgpu_bo *bo,
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
 				void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool mqd_gfx9);
-void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void *mem_obj);
+void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
 int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 				void **mem_obj);
 void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 7dc102f0bc1d..0c8975ac5af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1018,8 +1018,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		if (clock_type == COMPUTE_ENGINE_PLL_PARAM) {
 			args.v3.ulClockParams = cpu_to_le32((clock_type << 24) | clock);
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-				sizeof(args));
+			if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+			    index, (uint32_t *)&args, sizeof(args)))
+				return -EINVAL;
 
 			dividers->post_div = args.v3.ucPostDiv;
 			dividers->enable_post_div = (args.v3.ucCntlFlag &
@@ -1039,8 +1040,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 			if (strobe_mode)
 				args.v5.ucInputFlag = ATOM_PLL_INPUT_FLAG_PLL_STROBE_MODE_EN;
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-				sizeof(args));
+			if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+			    index, (uint32_t *)&args, sizeof(args)))
+				return -EINVAL;
 
 			dividers->post_div = args.v5.ucPostDiv;
 			dividers->enable_post_div = (args.v5.ucCntlFlag &
@@ -1058,8 +1060,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		/* fusion */
 		args.v4.ulClock = cpu_to_le32(clock);	/* 10 khz */
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		dividers->post_divider = dividers->post_div = args.v4.ucPostDiv;
 		dividers->real_clock = le32_to_cpu(args.v4.ulClock);
@@ -1070,8 +1073,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		args.v6_in.ulClock.ulComputeClockFlag = clock_type;
 		args.v6_in.ulClock.ulClockFreq = cpu_to_le32(clock);	/* 10 khz */
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		dividers->whole_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDiv);
 		dividers->frac_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDivFrac);
@@ -1113,8 +1117,9 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 			if (strobe_mode)
 				args.ucInputFlag |= MPLL_INPUT_FLAG_STROBE_MODE_EN;
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-				sizeof(args));
+			if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+			    index, (uint32_t *)&args, sizeof(args)))
+				return -EINVAL;
 
 			mpll_param->clkfrac = le16_to_cpu(args.ulFbDiv.usFbDivFrac);
 			mpll_param->clkf = le16_to_cpu(args.ulFbDiv.usFbDiv);
@@ -1211,8 +1216,9 @@ int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
 		args.v2.ucVoltageMode = 0;
 		args.v2.usVoltageLevel = 0;
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		*voltage = le16_to_cpu(args.v2.usVoltageLevel);
 		break;
@@ -1221,8 +1227,9 @@ int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
 		args.v3.ucVoltageMode = ATOM_GET_VOLTAGE_LEVEL;
 		args.v3.usVoltageLevel = cpu_to_le16(voltage_id);
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		*voltage = le16_to_cpu(args.v3.usVoltageLevel);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 6dfdff58bffd..78b3c067fea7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -263,6 +263,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			if (size < sizeof(struct drm_amdgpu_bo_list_in))
 				goto free_partial_kdata;
 
+			/* Only a single BO list is allowed to simplify handling. */
+			if (p->bo_list)
+				ret = -EINVAL;
+
 			ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
 			if (ret)
 				goto free_partial_kdata;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e92bdc9a39d3..1935b211b527 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -816,8 +816,11 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	int r;
 
 	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
-		if (!amdgpu_persistent_edc_harvesting_supported(adev))
-			amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
+		if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
+			r = amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
+			if (r)
+				return r;
+		}
 
 		r = amdgpu_ras_block_late_init(adev, ras_block);
 		if (r)
@@ -961,7 +964,10 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 		pr_err("critical bug! too many kiq readers\n");
 		goto failed_unlock;
 	}
-	amdgpu_ring_alloc(ring, 32);
+	r = amdgpu_ring_alloc(ring, 32);
+	if (r)
+		goto failed_unlock;
+
 	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 	if (r)
@@ -1027,7 +1033,10 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
+	r = amdgpu_ring_alloc(ring, 32);
+	if (r)
+		goto failed_unlock;
+
 	amdgpu_ring_emit_wreg(ring, reg, v);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 	if (r)
@@ -1063,6 +1072,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 
 failed_undo:
 	amdgpu_ring_undo(ring);
+failed_unlock:
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_write:
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 977cde6d1362..6d4e774b6ced 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -43,6 +43,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amd_pcie.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
@@ -778,6 +779,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				    ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_READ_MMR_REG: {
+		int ret = 0;
 		unsigned int n, alloc_size;
 		uint32_t *regs;
 		unsigned int se_num = (info->read_mmr_reg.instance >>
@@ -787,24 +789,37 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				   AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SH_INDEX_MASK;
 
+		if (!down_read_trylock(&adev->reset_domain->sem))
+			return -ENOENT;
+
 		/* set full masks if the userspace set all bits
 		 * in the bitfields
 		 */
-		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
+		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK) {
 			se_num = 0xffffffff;
-		else if (se_num >= AMDGPU_GFX_MAX_SE)
-			return -EINVAL;
-		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK)
+		} else if (se_num >= AMDGPU_GFX_MAX_SE) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK) {
 			sh_num = 0xffffffff;
-		else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE)
-			return -EINVAL;
+		} else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-		if (info->read_mmr_reg.count > 128)
-			return -EINVAL;
+		if (info->read_mmr_reg.count > 128) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
-		if (!regs)
-			return -ENOMEM;
+		if (!regs) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
 		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
 
 		amdgpu_gfx_off_ctrl(adev, false);
@@ -816,13 +831,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					      info->read_mmr_reg.dword_offset + i);
 				kfree(regs);
 				amdgpu_gfx_off_ctrl(adev, true);
-				return -EFAULT;
+				ret = -EFAULT;
+				goto out;
 			}
 		}
 		amdgpu_gfx_off_ctrl(adev, true);
 		n = copy_to_user(out, regs, min(size, alloc_size));
 		kfree(regs);
-		return n ? -EFAULT : 0;
+		ret = (n ? -EFAULT : 0);
+out:
+		up_read(&adev->reset_domain->sem);
+		return ret;
 	}
 	case AMDGPU_INFO_DEV_INFO: {
 		struct drm_amdgpu_info_device *dev_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 90138bc5f03d..32775260556f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -180,6 +180,6 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
 
 #define for_each_xcp(xcp_mgr, xcp, i)                            \
 	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
-	     xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
+	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 536287ddd2ec..6204336750c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8897,7 +8897,9 @@ static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 4ba8eb45ac17..6b5cd0dcd25f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4497,6 +4497,8 @@ static int gfx_v11_0_soft_reset(void *handle)
 	int r, i, j, k;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	gfx_v11_0_set_safe_mode(adev, 0);
+
 	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CMP_BUSY_INT_ENABLE, 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, CNTX_BUSY_INT_ENABLE, 0);
@@ -4504,8 +4506,6 @@ static int gfx_v11_0_soft_reset(void *handle)
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 0);
 	WREG32_SOC15(GC, 0, regCP_INT_CNTL, tmp);
 
-	gfx_v11_0_set_safe_mode(adev, 0);
-
 	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
@@ -5792,7 +5792,9 @@ static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, regSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3c8c5abf35ab..d8d3d2c93d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1172,6 +1172,10 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
+	/* https://bbs.openkylin.top/t/topic/171497 */
+	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
+	/* HP 705G4 DM with R5 2400G */
+	{ 0x1002, 0x15dd, 0x103c, 0x8464, 0xd6 },
 	{ 0, 0, 0, 0, 0 },
 };
 
@@ -2473,7 +2477,7 @@ static void gfx_v9_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE, enable ? 1 : 0);
-	if(adev->gfx.num_gfx_rings)
+	if (adev->gfx.num_gfx_rings)
 		tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE, enable ? 1 : 0);
 
 	WREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0, tmp);
@@ -5697,7 +5701,9 @@ static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
 	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
 	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
 	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 }
 
 static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
@@ -5768,17 +5774,59 @@ static void gfx_v9_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
 	}
 }
 
+static u32 gfx_v9_0_get_cpc_int_cntl(struct amdgpu_device *adev,
+				     int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *source,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
 		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
 			       PRIV_REG_INT_ENABLE,
 			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v9_0_get_cpc_int_cntl(adev, i + 1, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f5b9f443cfdd..2564a003526a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2824,21 +2824,63 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 	}
 }
 
+static u32 gfx_v9_4_3_get_cpc_int_cntl(struct amdgpu_device *adev,
+				     int xcc_id, int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static int gfx_v9_4_3_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *source,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
 {
-	int i, num_xcc;
+	u32 mec_int_cntl_reg, mec_int_cntl;
+	int i, j, k, num_xcc;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		for (i = 0; i < num_xcc; i++)
+		for (i = 0; i < num_xcc; i++) {
 			WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), CP_INT_CNTL_RING0,
-				PRIV_REG_INT_ENABLE,
-				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					      PRIV_REG_INT_ENABLE,
+					      state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+			for (j = 0; j < adev->gfx.mec.num_mec; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					/* MECs start at 1 */
+					mec_int_cntl_reg = gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);
+
+					if (mec_int_cntl_reg) {
+						mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, i);
+						mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+									     PRIV_REG_INT_ENABLE,
+									     state == AMDGPU_IRQ_STATE_ENABLE ?
+									     1 : 0);
+						WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, i);
+					}
+				}
+			}
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index fdf171ad4a3c..4f260adce8c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -423,7 +423,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 
 err_create_queue:
 	if (wptr_bo)
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&wptr_bo);
 err_wptr_map_gart:
 err_bind_process:
 err_pdd:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index afc57df421cd..3343079f28c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -863,7 +863,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 kfd_doorbell_error:
 	kfd_gtt_sa_fini(kfd);
 kfd_gtt_sa_init_error:
-	amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 alloc_gtt_mem_failure:
 	dev_err(kfd_device,
 		"device %x:%x NOT added due to errors\n",
@@ -881,7 +881,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&kfd->doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd->adev, kfd->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
 	}
 
 	kfree(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c08b6ee25289..dbef9eac2694 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2633,7 +2633,7 @@ static void deallocate_hiq_sdma_mqd(struct kfd_node *dev,
 {
 	WARN(!mqd, "No hiq sdma mqd trunk to free");
 
-	amdgpu_amdkfd_free_gtt_mem(dev->adev, mqd->gtt_mem);
+	amdgpu_amdkfd_free_gtt_mem(dev->adev, &mqd->gtt_mem);
 }
 
 void device_queue_manager_uninit(struct device_queue_manager *dqm)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 78dde62fb04a..c282f5253c44 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -414,25 +414,9 @@ static void event_interrupt_wq_v9(struct kfd_node *dev,
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
-		uint32_t node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
-		uint32_t vmid_type = SOC15_VMID_TYPE_FROM_IH_ENTRY(ih_ring_entry);
-		int hub_inst = 0;
 		struct kfd_hsa_memory_exception_data exception_data;
 
-		/* gfxhub */
-		if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
-			hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev->adev,
-				node_id);
-			if (hub_inst < 0)
-				hub_inst = 0;
-		}
-
-		/* mmhub */
-		if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
-			hub_inst = node_id / 4;
-
-		if (amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev,
-					hub_inst, vmid_type)) {
+		if (source_id == SOC15_INTSRC_VMC_UTCL2_POISON) {
 			event_interrupt_poison_consumption_v9(dev, pasid, client_id);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 8746a61a852d..d501fd2222dc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -223,7 +223,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
 	      struct kfd_mem_obj *mqd_mem_obj)
 {
 	if (mqd_mem_obj->gtt_mem) {
-		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, mqd_mem_obj->gtt_mem);
+		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, &mqd_mem_obj->gtt_mem);
 		kfree(mqd_mem_obj);
 	} else {
 		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 451bb058cc62..66150ea8e64d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1048,7 +1048,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 		if (pdd->dev->kfd->shared_resources.enable_mes)
 			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
-						   pdd->proc_ctx_bo);
+						   &pdd->proc_ctx_bo);
 		/*
 		 * before destroying pdd, make sure to report availability
 		 * for auto suspend
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index a5bdc3258ae5..db2b71f7226f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -201,9 +201,9 @@ static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
 	}
 
 	if (dev->kfd->shared_resources.enable_mes) {
-		amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->gang_ctx_bo);
+		amdgpu_amdkfd_free_gtt_mem(dev->adev, &pqn->q->gang_ctx_bo);
 		if (pqn->q->wptr_bo)
-			amdgpu_amdkfd_free_gtt_mem(dev->adev, pqn->q->wptr_bo);
+			amdgpu_amdkfd_free_gtt_mem(dev->adev, (void **)&pqn->q->wptr_bo);
 	}
 }
 
@@ -984,6 +984,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		pr_debug("Queue id %d was restored successfully\n", queue_id);
 
 	kfree(q_data);
+	kfree(q_extra_data);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
index 10138676f27f..e5c0205f2618 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -29,6 +29,7 @@
 #define SOC15_INTSRC_CP_BAD_OPCODE	183
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG	239
 #define SOC15_INTSRC_VMC_FAULT		0
+#define SOC15_INTSRC_VMC_UTCL2_POISON	1
 #define SOC15_INTSRC_SDMA_TRAP		224
 #define SOC15_INTSRC_SDMA_ECC		220
 #define SOC21_INTSRC_SDMA_TRAP		49
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3541d154cc8d..83f4ff9e848d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -758,6 +758,12 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		return;
 	}
 
+	/* Skip DMUB HPD IRQ in suspend/resume. We will probe them later. */
+	if (notify->type == DMUB_NOTIFICATION_HPD && adev->in_suspend) {
+		DRM_INFO("Skip DMUB HPD IRQ callback in suspend/resume\n");
+		return;
+	}
+
 	link_index = notify->link_index;
 	link = adev->dm.dc->links[link_index];
 	dev = adev->dm.ddev;
@@ -4170,7 +4176,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 		int spread = caps.max_input_signal - caps.min_input_signal;
 
 		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
-		    caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||
+		    caps.min_input_signal < 0 ||
 		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
 		    spread < AMDGPU_DM_MIN_SPREAD) {
 			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
@@ -6389,12 +6395,21 @@ create_stream_for_sink(struct drm_connector *connector,
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
 	    stream->signal == SIGNAL_TYPE_EDP) {
+		const struct dc_edid_caps *edid_caps;
+		unsigned int disable_colorimetry = 0;
+
+		if (aconnector->dc_sink) {
+			edid_caps = &aconnector->dc_sink->edid_caps;
+			disable_colorimetry = edid_caps->panel_patch.disable_colorimetry;
+		}
+
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
 		//
 		stream->use_vsc_sdp_for_colorimetry = stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
-						      stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED;
+						      stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED &&
+						      !disable_colorimetry;
 
 		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
@@ -6951,6 +6966,9 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
+	if (!dm_state)
+		return NULL;
+
 	do {
 		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
@@ -8963,7 +8981,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		if (acrtc)
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
 
-		if (!acrtc->wb_enabled)
+		if (!acrtc || !acrtc->wb_enabled)
 			continue;
 
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
@@ -9362,9 +9380,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
 
-			hdcp_update_display(
-				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
-				new_con_state->hdcp_content_type, enable_encryption);
+			if (aconnector->dc_link)
+				hdcp_update_display(
+					adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
+					new_con_state->hdcp_content_type, enable_encryption);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 2c36f3d00ca2..3c074120456e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -72,6 +72,10 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.remove_sink_ext_caps = true;
 		break;
+	case drm_edid_encode_panel_id('S', 'D', 'C', 0x4154):
+		DRM_DEBUG_DRIVER("Disabling VSC on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.disable_colorimetry = true;
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 9a6207731416..71695597b7e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1264,9 +1264,6 @@ static bool is_dsc_need_re_compute(
 		}
 	}
 
-	if (new_stream_on_link_num == 0)
-		return false;
-
 	if (new_stream_on_link_num == 0)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 7d47acdd11d5..fe7a99aee47d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1285,7 +1285,8 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 	    adev->dm.dc->caps.color.dpp.gamma_corr)
 		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
 
-	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
+	if (afb)
+		attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
 
 	if (crtc_state->stream) {
 		mutex_lock(&adev->dm.dc_lock);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index da237f718dbd..daeb80abf435 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3970,7 +3970,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
-		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
+		if (top_pipe_to_program &&
+		    top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
 				top_pipe_to_program->stream_res.tg,
 				CRTC_STATE_VACTIVE);
@@ -5210,7 +5211,8 @@ void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const
 	if (allow == dc->idle_optimizations_allowed)
 		return;
 
-	if (dc->hwss.apply_idle_power_optimizations && dc->hwss.apply_idle_power_optimizations(dc, allow))
+	if (dc->hwss.apply_idle_power_optimizations && dc->clk_mgr != NULL &&
+	    dc->hwss.apply_idle_power_optimizations(dc, allow))
 		dc->idle_optimizations_allowed = allow;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 786b56e96a81..58f6155fecc5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3134,6 +3134,8 @@ static bool are_stream_backends_same(
 bool dc_is_stream_unchanged(
 	struct dc_stream_state *old_stream, struct dc_stream_state *stream)
 {
+	if (!old_stream || !stream)
+		return false;
 
 	if (!are_stream_backends_same(old_stream, stream))
 		return false;
@@ -3662,8 +3664,10 @@ static bool planes_changed_for_existing_stream(struct dc_state *context,
 		}
 	}
 
-	if (!stream_status)
+	if (!stream_status) {
 		ASSERT(0);
+		return false;
+	}
 
 	for (i = 0; i < set_count; i++)
 		if (set[i].stream == stream)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 0f66d00ef80f..1d17d6497fec 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -178,6 +178,7 @@ struct dc_panel_patch {
 	unsigned int skip_avmute;
 	unsigned int mst_start_top_delay;
 	unsigned int remove_sink_ext_caps;
+	unsigned int disable_colorimetry;
 };
 
 struct dc_edid_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 0b49362f71b0..eaed5d1c398a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -591,6 +591,8 @@ bool cm_helper_translate_curve_to_degamma_hw_format(
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS)
+				return false;
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index b8327237ed44..0433f6b5dac7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -177,6 +177,8 @@ bool cm3_helper_translate_curve_to_hw_format(
 				i += increment) {
 			if (j == hw_points)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS)
+				return false;
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
@@ -335,6 +337,8 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS)
+				return false;
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 0fc9f3e3ffae..f603486af6e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -78,7 +78,7 @@ static void calculate_ttu_cursor(struct display_mode_lib *mode_lib,
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 618f4b682ab1..9f28e4d3c664 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -53,7 +53,7 @@ static void calculate_ttu_cursor(
 
 static unsigned int get_bytes_per_element(enum source_format_class source_format, bool is_chroma)
 {
-	unsigned int ret_val = 0;
+	unsigned int ret_val = 1;
 
 	if (source_format == dm_444_16) {
 		if (!is_chroma)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index ebcf5ece209a..bf8c89fe95a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -871,8 +871,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 	 * for VBLANK: (VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 	 * and the max of (VBLANK blanking time, MALL region)).
 	 */
-	if (stretched_drr_us < (1 / (double)drr_timing->min_refresh_in_uhz) * 1000000 * 1000000 &&
-			subvp_active_us - prefetch_us - stretched_drr_us - max_vblank_mallregion > 0)
+	if (drr_timing &&
+	    stretched_drr_us < (1 / (double)drr_timing->min_refresh_in_uhz) * 1000000 * 1000000 &&
+	    subvp_active_us - prefetch_us - stretched_drr_us - max_vblank_mallregion > 0)
 		schedulable = true;
 
 	return schedulable;
@@ -937,7 +938,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 		if (!subvp_pipe && pipe_mall_type == SUBVP_MAIN)
 			subvp_pipe = pipe;
 	}
-	if (found) {
+	if (found && subvp_pipe) {
 		phantom_stream = dc_state_get_paired_subvp_stream(context, subvp_pipe->stream);
 		main_timing = &subvp_pipe->stream->timing;
 		phantom_timing = &phantom_stream->timing;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
index c4c52173ef22..11c904ae2958 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
@@ -303,7 +303,6 @@ void build_unoptimized_policy_settings(enum dml_project_id project, struct dml_m
 	if (project == dml_project_dcn35 ||
 		project == dml_project_dcn351) {
 		policy->DCCProgrammingAssumesScanDirectionUnknownFinal = false;
-		policy->EnhancedPrefetchScheduleAccelerationFinal = 0;
 		policy->AllowForPStateChangeOrStutterInVBlankFinal = dml_prefetch_support_uclk_fclk_and_stutter_if_possible; /*new*/
 		policy->UseOnlyMaxPrefetchModes = 1;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index edff6b447680..d5dbfb33f93d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -828,7 +828,9 @@ static void get_scaler_data_for_plane(const struct dc_plane_state *in, struct dc
 	memcpy(out, &temp_pipe->plane_res.scl_data, sizeof(*out));
 }
 
-static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_stream_state *in)
+static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location,
+					 const struct dc_stream_state *in,
+					 const struct soc_bounding_box_st *soc)
 {
 	dml_uint_t width, height;
 
@@ -845,7 +847,7 @@ static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned
 	out->CursorBPP[location] = dml_cur_32bit;
 	out->CursorWidth[location] = 256;
 
-	out->GPUVMMinPageSizeKBytes[location] = 256;
+	out->GPUVMMinPageSizeKBytes[location] = soc->gpuvm_min_page_size_kbytes;
 
 	out->ViewportWidth[location] = width;
 	out->ViewportHeight[location] = height;
@@ -882,7 +884,9 @@ static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned
 	out->ScalerEnabled[location] = false;
 }
 
-static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out, unsigned int location, const struct dc_plane_state *in, struct dc_state *context)
+static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out, unsigned int location,
+						    const struct dc_plane_state *in, struct dc_state *context,
+						    const struct soc_bounding_box_st *soc)
 {
 	struct scaler_data *scaler_data = kzalloc(sizeof(*scaler_data), GFP_KERNEL);
 	if (!scaler_data)
@@ -893,7 +897,7 @@ static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out
 	out->CursorBPP[location] = dml_cur_32bit;
 	out->CursorWidth[location] = 256;
 
-	out->GPUVMMinPageSizeKBytes[location] = 256;
+	out->GPUVMMinPageSizeKBytes[location] = soc->gpuvm_min_page_size_kbytes;
 
 	out->ViewportWidth[location] = scaler_data->viewport.width;
 	out->ViewportHeight[location] = scaler_data->viewport.height;
@@ -1174,7 +1178,8 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 			disp_cfg_plane_location = dml_dispcfg->num_surfaces++;
 
 			populate_dummy_dml_surface_cfg(&dml_dispcfg->surface, disp_cfg_plane_location, context->streams[i]);
-			populate_dummy_dml_plane_cfg(&dml_dispcfg->plane, disp_cfg_plane_location, context->streams[i]);
+			populate_dummy_dml_plane_cfg(&dml_dispcfg->plane, disp_cfg_plane_location,
+						     context->streams[i], &dml2->v20.dml_core_ctx.soc);
 
 			dml_dispcfg->plane.BlendingAndTiming[disp_cfg_plane_location] = disp_cfg_stream_location;
 
@@ -1190,7 +1195,10 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 				ASSERT(disp_cfg_plane_location >= 0 && disp_cfg_plane_location <= __DML2_WRAPPER_MAX_STREAMS_PLANES__);
 
 				populate_dml_surface_cfg_from_plane_state(dml2->v20.dml_core_ctx.project, &dml_dispcfg->surface, disp_cfg_plane_location, context->stream_status[i].plane_states[j]);
-				populate_dml_plane_cfg_from_plane_state(&dml_dispcfg->plane, disp_cfg_plane_location, context->stream_status[i].plane_states[j], context);
+				populate_dml_plane_cfg_from_plane_state(
+					&dml_dispcfg->plane, disp_cfg_plane_location,
+					context->stream_status[i].plane_states[j], context,
+					&dml2->v20.dml_core_ctx.soc);
 
 				if (stream_mall_type == SUBVP_MAIN) {
 					dml_dispcfg->plane.UseMALLForPStateChange[disp_cfg_plane_location] = dml_use_mall_pstate_change_sub_viewport;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index e9e9f80a02a7..542d669bf5e3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -2020,13 +2020,20 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 	 * as well.
 	 */
 	for (i = 0; i < num_pipes; i++) {
-		pipe_ctx[i]->stream_res.tg->funcs->set_drr(
-			pipe_ctx[i]->stream_res.tg, &params);
-
-		if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
-			pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
-					pipe_ctx[i]->stream_res.tg,
-					event_triggers, num_frames);
+		/* dc_state_destruct() might null the stream resources, so fetch tg
+		 * here first to avoid a race condition. The lifetime of the pointee
+		 * itself (the timing_generator object) is not a problem here.
+		 */
+		struct timing_generator *tg = pipe_ctx[i]->stream_res.tg;
+
+		if ((tg != NULL) && tg->funcs) {
+			if (tg->funcs->set_drr)
+				tg->funcs->set_drr(tg, &params);
+			if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
+				if (tg->funcs->set_static_screen_control)
+					tg->funcs->set_static_screen_control(
+						tg, event_triggers, num_frames);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 7d833fa6dd77..58e8b7482f4f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1040,7 +1040,8 @@ bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	/*
 	 * if above if is not executed then 'params' equal to 0 and set in bypass
 	 */
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
 
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 05c5d4f04e1b..0f72a54e92af 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -626,7 +626,7 @@ void dcn30_init_hw(struct dc *dc)
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 	// Initialize the dccg
@@ -787,11 +787,12 @@ void dcn30_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
 	//if softmax is enabled then hardmax will be set by a different call
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 5fc377f51f56..c050acc4ff06 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -581,7 +581,9 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
 		}
 	}
 
-	mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+	if (mpc->funcs->set_output_gamma)
+		mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
+
 	return ret;
 }
 
@@ -752,7 +754,7 @@ void dcn32_init_hw(struct dc *dc)
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
 
-	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
 	// Initialize the dccg
@@ -931,10 +933,11 @@ void dcn32_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
index e1257404357b..cec68c5dba13 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.c
@@ -28,6 +28,8 @@
 #include "dccg.h"
 #include "clk_mgr.h"
 
+#define DC_LOGGER link->ctx->logger
+
 void set_hpo_dp_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size)
 {
@@ -108,6 +110,11 @@ void enable_hpo_dp_link_output(struct dc_link *link,
 		enum clock_source_id clock_source,
 		const struct dc_link_settings *link_settings)
 {
+	if (!link_res->hpo_dp_link_enc) {
+		DC_LOG_ERROR("%s: invalid hpo_dp_link_enc\n", __func__);
+		return;
+	}
+
 	if (link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating)
 		link->dc->res_pool->dccg->funcs->set_symclk32_le_root_clock_gating(
 				link->dc->res_pool->dccg,
@@ -124,6 +131,11 @@ void disable_hpo_dp_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal)
 {
+	if (!link_res->hpo_dp_link_enc) {
+		DC_LOG_ERROR("%s: invalid hpo_dp_link_enc\n", __func__);
+		return;
+	}
+
 		link_res->hpo_dp_link_enc->funcs->link_disable(link_res->hpo_dp_link_enc);
 		link_res->hpo_dp_link_enc->funcs->disable_link_phy(
 				link_res->hpo_dp_link_enc, signal);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 72df9bdfb23f..608491f860b2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -385,7 +385,7 @@ static void link_destruct(struct dc_link *link)
 	if (link->panel_cntl)
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
-	if (link->link_enc) {
+	if (link->link_enc && !link->is_dig_mapping_flexible) {
 		/* Update link encoder resource tracking variables. These are used for
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 6b380e037e3f..c0d1b41eb900 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2033,6 +2033,7 @@ bool dcn20_fast_validate_bw(
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -2057,7 +2058,7 @@ bool dcn20_fast_validate_bw(
 	if (vlevel > context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	/*initialize pipe_just_split_from to invalid idx*/
 	for (i = 0; i < MAX_PIPES; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 070a4efb308b..1aeede348bd3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -1005,8 +1005,10 @@ static struct pipe_ctx *dcn201_acquire_free_pipe_for_layer(
 	struct pipe_ctx *head_pipe = resource_get_otg_master_for_stream(res_ctx, opp_head_pipe->stream);
 	struct pipe_ctx *idle_pipe = resource_find_free_secondary_pipe_legacy(res_ctx, pool, head_pipe);
 
-	if (!head_pipe)
+	if (!head_pipe) {
 		ASSERT(0);
+		return NULL;
+	}
 
 	if (!idle_pipe)
 		return NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 8663cbc3d1cf..347e6aaea582 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -774,6 +774,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -816,7 +817,7 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 			goto validate_fail;
 	}
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index d84c8e0e5c2f..55fbe86383c0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1714,6 +1714,9 @@ void dcn32_add_phantom_pipes(struct dc *dc, struct dc_state *context,
 	// be a valid candidate for SubVP (i.e. has a plane, stream, doesn't
 	// already have phantom pipe assigned, etc.) by previous checks.
 	phantom_stream = dcn32_enable_phantom_stream(dc, context, pipes, pipe_cnt, index);
+	if (!phantom_stream)
+		return;
+
 	dcn32_enable_phantom_plane(dc, context, phantom_stream, index);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -2664,8 +2667,10 @@ static struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 	struct resource_context *old_ctx = &stream->ctx->dc->current_state->res_ctx;
 	int head_index;
 
-	if (!head_pipe)
+	if (!head_pipe) {
 		ASSERT(0);
+		return NULL;
+	}
 
 	/*
 	 * Modified from dcn20_acquire_idle_pipe_for_layer
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 5794b64507bf..56a225752580 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1185,6 +1185,8 @@ static int init_overdrive_limits(struct pp_hwmgr *hwmgr,
 	fw_info = smu_atom_get_data_table(hwmgr->adev,
 			 GetIndexIntoMasterTable(DATA, FirmwareInfo),
 			 &size, &frev, &crev);
+	PP_ASSERT_WITH_CODE(fw_info != NULL,
+			    "Missing firmware info!", return -EINVAL);
 
 	if ((fw_info->ucTableFormatRevision == 1)
 	    && (le16_to_cpu(fw_info->usStructureSize) >= sizeof(ATOM_FIRMWARE_INFO_V1_4)))
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 106292d6ed26..9e9b2f3f106c 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -543,7 +543,7 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 					&state->fb_damage_clips,
 					val,
 					-1,
-					sizeof(struct drm_rect),
+					sizeof(struct drm_mode_rect),
 					&replaced);
 		return ret;
 	} else if (property == plane->scaling_filter_property) {
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index cf2efb44722c..1d122d4de70e 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -100,8 +100,9 @@ void __drm_puts_coredump(struct drm_printer *p, const char *str)
 			copy = iterator->remain;
 
 		/* Copy out the bit of the string that we need */
-		memcpy(iterator->data,
-			str + (iterator->start - iterator->offset), copy);
+		if (iterator->data)
+			memcpy(iterator->data,
+			       str + (iterator->start - iterator->offset), copy);
 
 		iterator->offset = iterator->start + copy;
 		iterator->remain -= copy;
@@ -110,7 +111,8 @@ void __drm_puts_coredump(struct drm_printer *p, const char *str)
 
 		len = min_t(ssize_t, strlen(str), iterator->remain);
 
-		memcpy(iterator->data + pos, str, len);
+		if (iterator->data)
+			memcpy(iterator->data + pos, str, len);
 
 		iterator->offset += len;
 		iterator->remain -= len;
@@ -140,8 +142,9 @@ void __drm_printfn_coredump(struct drm_printer *p, struct va_format *vaf)
 	if ((iterator->offset >= iterator->start) && (len < iterator->remain)) {
 		ssize_t pos = iterator->offset - iterator->start;
 
-		snprintf(((char *) iterator->data) + pos,
-			iterator->remain, "%pV", vaf);
+		if (iterator->data)
+			snprintf(((char *) iterator->data) + pos,
+				 iterator->remain, "%pV", vaf);
 
 		iterator->offset += len;
 		iterator->remain -= len;
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 6bff169fa8d4..f92c46297ec4 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -908,7 +908,7 @@ intel_ddi_main_link_aux_domain(struct intel_digital_port *dig_port,
 	 * instead of a specific AUX_IO_<port> reference without powering up any
 	 * extra wells.
 	 */
-	if (intel_encoder_can_psr(&dig_port->base))
+	if (intel_psr_needs_aux_io_power(&dig_port->base, crtc_state))
 		return intel_display_power_aux_io_domain(i915, dig_port->aux_ch);
 	else if (DISPLAY_VER(i915) < 14 &&
 		 (intel_crtc_has_dp_encoder(crtc_state) ||
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index a7d91ca1d8ba..bd3ce34fb6a6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3944,6 +3944,9 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *connector
 			 drm_dp_is_branch(intel_dp->dpcd));
 	intel_init_dpcd_quirks(intel_dp, &intel_dp->desc.ident);
 
+	intel_dp->colorimetry_support =
+		intel_dp_get_colorimetry_status(intel_dp);
+
 	/*
 	 * Read the eDP display control registers.
 	 *
@@ -4057,6 +4060,9 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
 
 		intel_init_dpcd_quirks(intel_dp, &intel_dp->desc.ident);
 
+		intel_dp->colorimetry_support =
+			intel_dp_get_colorimetry_status(intel_dp);
+
 		intel_dp_update_sink_caps(intel_dp);
 	}
 
@@ -6774,9 +6780,6 @@ intel_dp_init_connector(struct intel_digital_port *dig_port,
 				    "HDCP init failed, skipping.\n");
 	}
 
-	intel_dp->colorimetry_support =
-		intel_dp_get_colorimetry_status(intel_dp);
-
 	intel_dp->frl.is_trained = false;
 	intel_dp->frl.trained_rate_gbps = 0;
 
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 7173ffc7c66c..857f776e5550 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -201,6 +201,25 @@ bool intel_encoder_can_psr(struct intel_encoder *encoder)
 		return false;
 }
 
+bool intel_psr_needs_aux_io_power(struct intel_encoder *encoder,
+				  const struct intel_crtc_state *crtc_state)
+{
+	/*
+	 * For PSR/PR modes only eDP requires the AUX IO power to be enabled whenever
+	 * the output is enabled. For non-eDP outputs the main link is always
+	 * on, hence it doesn't require the HW initiated AUX wake-up signaling used
+	 * for eDP.
+	 *
+	 * TODO:
+	 * - Consider leaving AUX IO disabled for eDP / PR as well, in case
+	 *   the ALPM with main-link off mode is not enabled.
+	 * - Leave AUX IO enabled for DP / PR, once support for ALPM with
+	 *   main-link off mode is added for it and this mode gets enabled.
+	 */
+	return intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP) &&
+	       intel_encoder_can_psr(encoder);
+}
+
 static bool psr_global_enabled(struct intel_dp *intel_dp)
 {
 	struct intel_connector *connector = intel_dp->attached_connector;
diff --git a/drivers/gpu/drm/i915/display/intel_psr.h b/drivers/gpu/drm/i915/display/intel_psr.h
index d483c85870e1..e719f548e160 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.h
+++ b/drivers/gpu/drm/i915/display/intel_psr.h
@@ -25,6 +25,8 @@ struct intel_plane_state;
 				    (intel_dp)->psr.source_panel_replay_support)
 
 bool intel_encoder_can_psr(struct intel_encoder *encoder);
+bool intel_psr_needs_aux_io_power(struct intel_encoder *encoder,
+				  const struct intel_crtc_state *crtc_state);
 void intel_psr_init_dpcd(struct intel_dp *intel_dp);
 void intel_psr_enable_sink(struct intel_dp *intel_dp,
 			   const struct intel_crtc_state *crtc_state);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 5c72462d1f57..b22e2019768f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -1131,7 +1131,7 @@ static vm_fault_t vm_fault_ttm(struct vm_fault *vmf)
 		GEM_WARN_ON(!i915_ttm_cpu_maps_iomem(bo->resource));
 	}
 
-	if (wakeref & CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND)
+	if (wakeref && CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND != 0)
 		intel_wakeref_auto(&to_i915(obj->base.dev)->runtime_pm.userfault_wakeref,
 				   msecs_to_jiffies_timeout(CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND));
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 2b62d6475918..6068026f044d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -523,8 +523,10 @@ static int ovl_adaptor_comp_init(struct device *dev, struct component_match **ma
 		}
 
 		comp_pdev = of_find_device_by_node(node);
-		if (!comp_pdev)
+		if (!comp_pdev) {
+			of_node_put(node);
 			return -EPROBE_DEFER;
+		}
 
 		priv->ovl_adaptor_comp[id] = &comp_pdev->dev;
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index d5d9361e11aa..8e8f55225e1e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1079,6 +1079,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	adreno_gpu->chip_id = config->chip_id;
 
 	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
+	gpu->pdev = pdev;
 
 	/* Only handle the core clock when GMU is not in use (or is absent). */
 	if (adreno_has_gmu_wrapper(adreno_gpu) ||
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index cd185b9636d2..56b6de049bd7 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -929,7 +929,6 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	if (IS_ERR(gpu->gpu_cx))
 		gpu->gpu_cx = NULL;
 
-	gpu->pdev = pdev;
 	platform_set_drvdata(pdev, &gpu->adreno_smmu);
 
 	msm_devfreq_init(gpu);
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 6598c9c08ba1..d3eac4817d76 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -695,6 +695,10 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
 	soc = soc_device_match(omapdrm_soc_devices);
 	priv->omaprev = soc ? (uintptr_t)soc->data : 0;
 	priv->wq = alloc_ordered_workqueue("omapdrm", 0);
+	if (!priv->wq) {
+		ret = -ENOMEM;
+		goto err_alloc_workqueue;
+	}
 
 	mutex_init(&priv->list_lock);
 	INIT_LIST_HEAD(&priv->obj_list);
@@ -753,6 +757,7 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
 	drm_mode_config_cleanup(ddev);
 	omap_gem_deinit(ddev);
 	destroy_workqueue(priv->wq);
+err_alloc_workqueue:
 	omap_disconnect_pipelines(ddev);
 	drm_dev_put(ddev);
 	return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index cc6e13a97783..ce8e8a93d707 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1251,9 +1251,17 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 		goto err_cleanup;
 	}
 
+	/* drm_gpuvm_bo_obtain_prealloc() will call drm_gpuvm_bo_put() on our
+	 * pre-allocated BO if the <BO,VM> association exists. Given we
+	 * only have one ref on preallocated_vm_bo, drm_gpuvm_bo_destroy() will
+	 * be called immediately, and we have to hold the VM resv lock when
+	 * calling this function.
+	 */
+	dma_resv_lock(panthor_vm_resv(vm), NULL);
 	mutex_lock(&bo->gpuva_list_lock);
 	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
 	mutex_unlock(&bo->gpuva_list_lock);
+	dma_resv_unlock(panthor_vm_resv(vm));
 
 	/* If the a vm_bo for this <VM,BO> combination exists, it already
 	 * retains a pin ref, and we can release the one we took earlier.
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 12b272a912f8..4d1d5a342a4a 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1103,7 +1103,13 @@ cs_slot_sync_queue_state_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs
 			list_move_tail(&group->wait_node,
 				       &group->ptdev->scheduler->groups.waiting);
 		}
-		group->blocked_queues |= BIT(cs_id);
+
+		/* The queue is only blocked if there's no deferred operation
+		 * pending, which can be checked through the scoreboard status.
+		 */
+		if (!cs_iface->output->status_scoreboards)
+			group->blocked_queues |= BIT(cs_id);
+
 		queue->syncwait.gpu_va = cs_iface->output->status_wait_sync_ptr;
 		queue->syncwait.ref = cs_iface->output->status_wait_sync_value;
 		status_wait_cond = cs_iface->output->status_wait & CS_STATUS_WAIT_SYNC_COND_MASK;
@@ -2046,6 +2052,7 @@ static void
 tick_ctx_cleanup(struct panthor_scheduler *sched,
 		 struct panthor_sched_tick_ctx *ctx)
 {
+	struct panthor_device *ptdev = sched->ptdev;
 	struct panthor_group *group, *tmp;
 	u32 i;
 
@@ -2054,7 +2061,7 @@ tick_ctx_cleanup(struct panthor_scheduler *sched,
 			/* If everything went fine, we should only have groups
 			 * to be terminated in the old_groups lists.
 			 */
-			drm_WARN_ON(&group->ptdev->base, !ctx->csg_upd_failed_mask &&
+			drm_WARN_ON(&ptdev->base, !ctx->csg_upd_failed_mask &&
 				    group_can_run(group));
 
 			if (!group_can_run(group)) {
@@ -2077,7 +2084,7 @@ tick_ctx_cleanup(struct panthor_scheduler *sched,
 		/* If everything went fine, the groups to schedule lists should
 		 * be empty.
 		 */
-		drm_WARN_ON(&group->ptdev->base,
+		drm_WARN_ON(&ptdev->base,
 			    !ctx->csg_upd_failed_mask && !list_empty(&ctx->groups[i]));
 
 		list_for_each_entry_safe(group, tmp, &ctx->groups[i], run_node) {
@@ -3242,6 +3249,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	return 0;
 }
 
+static struct panthor_group *group_from_handle(struct panthor_group_pool *pool,
+					       u32 group_handle)
+{
+	struct panthor_group *group;
+
+	xa_lock(&pool->xa);
+	group = group_get(xa_load(&pool->xa, group_handle));
+	xa_unlock(&pool->xa);
+
+	return group;
+}
+
 int panthor_group_get_state(struct panthor_file *pfile,
 			    struct drm_panthor_group_get_state *get_state)
 {
@@ -3253,7 +3272,7 @@ int panthor_group_get_state(struct panthor_file *pfile,
 	if (get_state->pad)
 		return -EINVAL;
 
-	group = group_get(xa_load(&gpool->xa, get_state->group_handle));
+	group = group_from_handle(gpool, get_state->group_handle);
 	if (!group)
 		return -EINVAL;
 
@@ -3384,7 +3403,7 @@ panthor_job_create(struct panthor_file *pfile,
 	job->call_info.latest_flush = qsubmit->latest_flush;
 	INIT_LIST_HEAD(&job->node);
 
-	job->group = group_get(xa_load(&gpool->xa, group_handle));
+	job->group = group_from_handle(gpool, group_handle);
 	if (!job->group) {
 		ret = -EINVAL;
 		goto err_put_job;
@@ -3424,13 +3443,8 @@ void panthor_job_update_resvs(struct drm_exec *exec, struct drm_sched_job *sched
 {
 	struct panthor_job *job = container_of(sched_job, struct panthor_job, base);
 
-	/* Still not sure why we want USAGE_WRITE for external objects, since I
-	 * was assuming this would be handled through explicit syncs being imported
-	 * to external BOs with DMA_BUF_IOCTL_IMPORT_SYNC_FILE, but other drivers
-	 * seem to pass DMA_RESV_USAGE_WRITE, so there must be a good reason.
-	 */
 	panthor_vm_update_resvs(job->group->vm, exec, &sched_job->s_fence->finished,
-				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_WRITE);
+				DMA_RESV_USAGE_BOOKKEEP, DMA_RESV_USAGE_BOOKKEEP);
 }
 
 void panthor_sched_unplug(struct panthor_device *ptdev)
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 0b1e19345f43..bfd42e3e161e 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1016,45 +1016,65 @@ static int r100_cp_init_microcode(struct radeon_device *rdev)
 
 	DRM_DEBUG_KMS("\n");
 
-	if ((rdev->family == CHIP_R100) || (rdev->family == CHIP_RV100) ||
-	    (rdev->family == CHIP_RV200) || (rdev->family == CHIP_RS100) ||
-	    (rdev->family == CHIP_RS200)) {
+	switch (rdev->family) {
+	case CHIP_R100:
+	case CHIP_RV100:
+	case CHIP_RV200:
+	case CHIP_RS100:
+	case CHIP_RS200:
 		DRM_INFO("Loading R100 Microcode\n");
 		fw_name = FIRMWARE_R100;
-	} else if ((rdev->family == CHIP_R200) ||
-		   (rdev->family == CHIP_RV250) ||
-		   (rdev->family == CHIP_RV280) ||
-		   (rdev->family == CHIP_RS300)) {
+		break;
+
+	case CHIP_R200:
+	case CHIP_RV250:
+	case CHIP_RV280:
+	case CHIP_RS300:
 		DRM_INFO("Loading R200 Microcode\n");
 		fw_name = FIRMWARE_R200;
-	} else if ((rdev->family == CHIP_R300) ||
-		   (rdev->family == CHIP_R350) ||
-		   (rdev->family == CHIP_RV350) ||
-		   (rdev->family == CHIP_RV380) ||
-		   (rdev->family == CHIP_RS400) ||
-		   (rdev->family == CHIP_RS480)) {
+		break;
+
+	case CHIP_R300:
+	case CHIP_R350:
+	case CHIP_RV350:
+	case CHIP_RV380:
+	case CHIP_RS400:
+	case CHIP_RS480:
 		DRM_INFO("Loading R300 Microcode\n");
 		fw_name = FIRMWARE_R300;
-	} else if ((rdev->family == CHIP_R420) ||
-		   (rdev->family == CHIP_R423) ||
-		   (rdev->family == CHIP_RV410)) {
+		break;
+
+	case CHIP_R420:
+	case CHIP_R423:
+	case CHIP_RV410:
 		DRM_INFO("Loading R400 Microcode\n");
 		fw_name = FIRMWARE_R420;
-	} else if ((rdev->family == CHIP_RS690) ||
-		   (rdev->family == CHIP_RS740)) {
+		break;
+
+	case CHIP_RS690:
+	case CHIP_RS740:
 		DRM_INFO("Loading RS690/RS740 Microcode\n");
 		fw_name = FIRMWARE_RS690;
-	} else if (rdev->family == CHIP_RS600) {
+		break;
+
+	case CHIP_RS600:
 		DRM_INFO("Loading RS600 Microcode\n");
 		fw_name = FIRMWARE_RS600;
-	} else if ((rdev->family == CHIP_RV515) ||
-		   (rdev->family == CHIP_R520) ||
-		   (rdev->family == CHIP_RV530) ||
-		   (rdev->family == CHIP_R580) ||
-		   (rdev->family == CHIP_RV560) ||
-		   (rdev->family == CHIP_RV570)) {
+		break;
+
+	case CHIP_RV515:
+	case CHIP_R520:
+	case CHIP_RV530:
+	case CHIP_R580:
+	case CHIP_RV560:
+	case CHIP_RV570:
 		DRM_INFO("Loading R500 Microcode\n");
 		fw_name = FIRMWARE_R520;
+		break;
+
+	default:
+		DRM_ERROR("Unsupported Radeon family %u\n", rdev->family);
+		return -EINVAL;
 	}
 
 	err = request_firmware(&rdev->me_fw, fw_name, rdev->dev);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 4a9c6ea7f15d..f161f40d8ce4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1583,6 +1583,10 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
 	VOP_AFBC_SET(vop, enable, s->enable_afbc);
 	vop_cfg_done(vop);
 
+	/* Ack the DMA transfer of the previous frame (RK3066). */
+	if (VOP_HAS_REG(vop, common, dma_stop))
+		VOP_REG_SET(vop, common, dma_stop, 0);
+
 	spin_unlock(&vop->reg_lock);
 
 	/*
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index b33e5bdc26be..0cf512cc1614 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -122,6 +122,7 @@ struct vop_common {
 	struct vop_reg lut_buffer_index;
 	struct vop_reg gate_en;
 	struct vop_reg mmu_en;
+	struct vop_reg dma_stop;
 	struct vop_reg out_mode;
 	struct vop_reg standby;
 };
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index b9ee02061d5b..e2c6ba26f437 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -466,6 +466,7 @@ static const struct vop_output rk3066_output = {
 };
 
 static const struct vop_common rk3066_common = {
+	.dma_stop = VOP_REG(RK3066_SYS_CTRL0, 0x1, 0),
 	.standby = VOP_REG(RK3066_SYS_CTRL0, 0x1, 1),
 	.out_mode = VOP_REG(RK3066_DSP_CTRL0, 0xf, 0),
 	.cfg_done = VOP_REG(RK3066_REG_CFG_DONE, 0x1, 0),
@@ -514,6 +515,7 @@ static const struct vop_data rk3066_vop = {
 	.output = &rk3066_output,
 	.win = rk3066_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3066_vop_win_data),
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.max_output = { 1920, 1080 },
 };
 
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 58c8161289fe..a75eede8bf8d 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -133,8 +133,10 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 {
 	WARN_ON(!num_sched_list || !sched_list);
 
+	spin_lock(&entity->rq_lock);
 	entity->sched_list = sched_list;
 	entity->num_sched_list = num_sched_list;
+	spin_unlock(&entity->rq_lock);
 }
 EXPORT_SYMBOL(drm_sched_entity_modify_sched);
 
@@ -380,7 +382,7 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 		container_of(cb, struct drm_sched_entity, cb);
 
 	drm_sched_entity_clear_dep(f, cb);
-	drm_sched_wakeup(entity->rq->sched, entity);
+	drm_sched_wakeup(entity->rq->sched);
 }
 
 /**
@@ -597,6 +599,9 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 
 	/* first job wakes up scheduler */
 	if (first) {
+		struct drm_gpu_scheduler *sched;
+		struct drm_sched_rq *rq;
+
 		/* Add the entity to the run queue */
 		spin_lock(&entity->rq_lock);
 		if (entity->stopped) {
@@ -606,13 +611,16 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 			return;
 		}
 
-		drm_sched_rq_add_entity(entity->rq, entity);
+		rq = entity->rq;
+		sched = rq->sched;
+
+		drm_sched_rq_add_entity(rq, entity);
 		spin_unlock(&entity->rq_lock);
 
 		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
 			drm_sched_rq_update_fifo(entity, submit_ts);
 
-		drm_sched_wakeup(entity->rq->sched, entity);
+		drm_sched_wakeup(sched);
 	}
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7e90c9f95611..a124d5e77b5e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1022,15 +1022,12 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
 /**
  * drm_sched_wakeup - Wake up the scheduler if it is ready to queue
  * @sched: scheduler instance
- * @entity: the scheduler entity
  *
  * Wake up the scheduler if we can queue jobs.
  */
-void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
-		      struct drm_sched_entity *entity)
+void drm_sched_wakeup(struct drm_gpu_scheduler *sched)
 {
-	if (drm_sched_can_queue(sched, entity))
-		drm_sched_run_job_queue(sched);
+	drm_sched_run_job_queue(sched);
 }
 
 /**
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 4d2db079ad4f..e1232f74dfa5 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -25,6 +25,7 @@
 #include <drm/drm_module.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_managed.h>
 
 #include "ltdc.h"
 
@@ -75,7 +76,7 @@ static int drv_load(struct drm_device *ddev)
 
 	DRM_DEBUG("%s\n", __func__);
 
-	ldev = devm_kzalloc(ddev->dev, sizeof(*ldev), GFP_KERNEL);
+	ldev = drmm_kzalloc(ddev, sizeof(*ldev), GFP_KERNEL);
 	if (!ldev)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5aec1e58c968..0832b749b66e 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -36,6 +36,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_managed.h>
 
 #include <video/videomode.h>
 
@@ -1199,7 +1200,6 @@ static void ltdc_crtc_atomic_print_state(struct drm_printer *p,
 }
 
 static const struct drm_crtc_funcs ltdc_crtc_funcs = {
-	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
@@ -1212,7 +1212,6 @@ static const struct drm_crtc_funcs ltdc_crtc_funcs = {
 };
 
 static const struct drm_crtc_funcs ltdc_crtc_with_crc_support_funcs = {
-	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
@@ -1514,6 +1513,9 @@ static void ltdc_plane_atomic_disable(struct drm_plane *plane,
 	/* Disable layer */
 	regmap_write_bits(ldev->regmap, LTDC_L1CR + lofs, LXCR_LEN | LXCR_CLUTEN |  LXCR_HMEN, 0);
 
+	/* Reset the layer transparency to hide any related background color */
+	regmap_write_bits(ldev->regmap, LTDC_L1CACR + lofs, LXCACR_CONSTA, 0x00);
+
 	/* Commit shadow registers = update plane at next vblank */
 	if (ldev->caps.plane_reg_shadow)
 		regmap_write_bits(ldev->regmap, LTDC_L1RCR + lofs,
@@ -1545,7 +1547,6 @@ static void ltdc_plane_atomic_print_state(struct drm_printer *p,
 static const struct drm_plane_funcs ltdc_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = drm_plane_cleanup,
 	.reset = drm_atomic_helper_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
@@ -1572,7 +1573,6 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 	const u64 *modifiers = ltdc_format_modifiers;
 	u32 lofs = index * LAY_OFS;
 	u32 val;
-	int ret;
 
 	/* Allocate the biggest size according to supported color formats */
 	formats = devm_kzalloc(dev, (ldev->caps.pix_fmt_nb +
@@ -1615,14 +1615,10 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 		}
 	}
 
-	plane = devm_kzalloc(dev, sizeof(*plane), GFP_KERNEL);
-	if (!plane)
-		return NULL;
-
-	ret = drm_universal_plane_init(ddev, plane, possible_crtcs,
-				       &ltdc_plane_funcs, formats, nb_fmt,
-				       modifiers, type, NULL);
-	if (ret < 0)
+	plane = drmm_universal_plane_alloc(ddev, struct drm_plane, dev,
+					   possible_crtcs, &ltdc_plane_funcs, formats,
+					   nb_fmt, modifiers, type, NULL);
+	if (IS_ERR(plane))
 		return NULL;
 
 	if (ldev->caps.ycbcr_input) {
@@ -1645,15 +1641,6 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
 	return plane;
 }
 
-static void ltdc_plane_destroy_all(struct drm_device *ddev)
-{
-	struct drm_plane *plane, *plane_temp;
-
-	list_for_each_entry_safe(plane, plane_temp,
-				 &ddev->mode_config.plane_list, head)
-		drm_plane_cleanup(plane);
-}
-
 static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 {
 	struct ltdc_device *ldev = ddev->dev_private;
@@ -1679,14 +1666,14 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 
 	/* Init CRTC according to its hardware features */
 	if (ldev->caps.crc)
-		ret = drm_crtc_init_with_planes(ddev, crtc, primary, NULL,
-						&ltdc_crtc_with_crc_support_funcs, NULL);
+		ret = drmm_crtc_init_with_planes(ddev, crtc, primary, NULL,
+						 &ltdc_crtc_with_crc_support_funcs, NULL);
 	else
-		ret = drm_crtc_init_with_planes(ddev, crtc, primary, NULL,
-						&ltdc_crtc_funcs, NULL);
+		ret = drmm_crtc_init_with_planes(ddev, crtc, primary, NULL,
+						 &ltdc_crtc_funcs, NULL);
 	if (ret) {
 		DRM_ERROR("Can not initialize CRTC\n");
-		goto cleanup;
+		return ret;
 	}
 
 	drm_crtc_helper_add(crtc, &ltdc_crtc_helper_funcs);
@@ -1700,9 +1687,8 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 	for (i = 1; i < ldev->caps.nb_layers; i++) {
 		overlay = ltdc_plane_create(ddev, DRM_PLANE_TYPE_OVERLAY, i);
 		if (!overlay) {
-			ret = -ENOMEM;
 			DRM_ERROR("Can not create overlay plane %d\n", i);
-			goto cleanup;
+			return -ENOMEM;
 		}
 		if (ldev->caps.dynamic_zorder)
 			drm_plane_create_zpos_property(overlay, i, 0, ldev->caps.nb_layers - 1);
@@ -1715,10 +1701,6 @@ static int ltdc_crtc_init(struct drm_device *ddev, struct drm_crtc *crtc)
 	}
 
 	return 0;
-
-cleanup:
-	ltdc_plane_destroy_all(ddev);
-	return ret;
 }
 
 static void ltdc_encoder_disable(struct drm_encoder *encoder)
@@ -1778,23 +1760,19 @@ static int ltdc_encoder_init(struct drm_device *ddev, struct drm_bridge *bridge)
 	struct drm_encoder *encoder;
 	int ret;
 
-	encoder = devm_kzalloc(ddev->dev, sizeof(*encoder), GFP_KERNEL);
-	if (!encoder)
-		return -ENOMEM;
+	encoder = drmm_simple_encoder_alloc(ddev, struct drm_encoder, dev,
+					    DRM_MODE_ENCODER_DPI);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
 
 	encoder->possible_crtcs = CRTC_MASK;
 	encoder->possible_clones = 0;	/* No cloning support */
 
-	drm_simple_encoder_init(ddev, encoder, DRM_MODE_ENCODER_DPI);
-
 	drm_encoder_helper_add(encoder, &ltdc_encoder_helper_funcs);
 
 	ret = drm_bridge_attach(encoder, bridge, NULL, 0);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			drm_encoder_cleanup(encoder);
+	if (ret)
 		return ret;
-	}
 
 	DRM_DEBUG_DRIVER("Bridge encoder:%d created\n", encoder->base.id);
 
@@ -1964,8 +1942,7 @@ int ltdc_load(struct drm_device *ddev)
 			goto err;
 
 		if (panel) {
-			bridge = drm_panel_bridge_add_typed(panel,
-							    DRM_MODE_CONNECTOR_DPI);
+			bridge = drmm_panel_bridge_add(ddev, panel);
 			if (IS_ERR(bridge)) {
 				DRM_ERROR("panel-bridge endpoint %d\n", i);
 				ret = PTR_ERR(bridge);
@@ -2047,7 +2024,7 @@ int ltdc_load(struct drm_device *ddev)
 		}
 	}
 
-	crtc = devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
+	crtc = drmm_kzalloc(ddev, sizeof(*crtc), GFP_KERNEL);
 	if (!crtc) {
 		DRM_ERROR("Failed to allocate crtc\n");
 		ret = -ENOMEM;
@@ -2074,9 +2051,6 @@ int ltdc_load(struct drm_device *ddev)
 
 	return 0;
 err:
-	for (i = 0; i < nb_endpoints; i++)
-		drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
-
 	clk_disable_unprepare(ldev->pixel_clk);
 
 	return ret;
@@ -2084,16 +2058,8 @@ int ltdc_load(struct drm_device *ddev)
 
 void ltdc_unload(struct drm_device *ddev)
 {
-	struct device *dev = ddev->dev;
-	int nb_endpoints, i;
-
 	DRM_DEBUG_DRIVER("\n");
 
-	nb_endpoints = of_graph_get_endpoint_count(dev->of_node);
-
-	for (i = 0; i < nb_endpoints; i++)
-		drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
-
 	pm_runtime_disable(ddev->dev);
 }
 
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 4cdfabbf4964..d310e95aa662 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -671,6 +671,9 @@ v3d_get_cpu_reset_performance_params(struct drm_file *file_priv,
 	if (reset.nperfmons > V3D_MAX_PERFMONS)
 		return -EINVAL;
 
+	if (reset.nperfmons > V3D_MAX_PERFMONS)
+		return -EINVAL;
+
 	job->job_type = V3D_CPU_JOB_TYPE_RESET_PERFORMANCE_QUERY;
 
 	job->performance_query.queries = kvmalloc_array(reset.count,
@@ -755,6 +758,9 @@ v3d_get_cpu_copy_performance_query_params(struct drm_file *file_priv,
 	if (copy.nperfmons > V3D_MAX_PERFMONS)
 		return -EINVAL;
 
+	if (copy.nperfmons > V3D_MAX_PERFMONS)
+		return -EINVAL;
+
 	job->job_type = V3D_CPU_JOB_TYPE_COPY_PERFORMANCE_QUERY;
 
 	job->performance_query.queries = kvmalloc_array(copy.count,
diff --git a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
index b3d3c065dd9d..2f935771658e 100644
--- a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
+++ b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
@@ -39,10 +39,14 @@ bool intel_hdcp_gsc_check_status(struct xe_device *xe)
 {
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
 	struct xe_gt *gt = tile->media_gt;
+	struct xe_gsc *gsc = &gt->uc.gsc;
 	bool ret = true;
 
-	if (!xe_uc_fw_is_enabled(&gt->uc.gsc.fw))
+	if (!gsc && !xe_uc_fw_is_enabled(&gsc->fw)) {
+		drm_dbg_kms(&xe->drm,
+			    "GSC Components not ready for HDCP2.x\n");
 		return false;
+	}
 
 	xe_pm_runtime_get(xe);
 	if (xe_force_wake_get(gt_to_fw(gt), XE_FW_GSC)) {
@@ -52,7 +56,7 @@ bool intel_hdcp_gsc_check_status(struct xe_device *xe)
 		goto out;
 	}
 
-	if (!xe_gsc_proxy_init_done(&gt->uc.gsc))
+	if (!xe_gsc_proxy_init_done(gsc))
 		ret = false;
 
 	xe_force_wake_put(gt_to_fw(gt), XE_FW_GSC);
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index f5e3012eff20..97506bf9f5e0 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -653,8 +653,8 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 	tt_has_data = ttm && (ttm_tt_is_populated(ttm) ||
 			      (ttm->page_flags & TTM_TT_FLAG_SWAPPED));
 
-	move_lacks_source = handle_system_ccs ? (!bo->ccs_cleared)  :
-						(!mem_type_is_vram(old_mem_type) && !tt_has_data);
+	move_lacks_source = !old_mem || (handle_system_ccs ? (!bo->ccs_cleared) :
+					 (!mem_type_is_vram(old_mem_type) && !tt_has_data));
 
 	needs_clear = (ttm && ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC) ||
 		(!ttm && ttm_bo->type == ttm_bo_type_device);
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index a1cbdafbff75..599bf7f9e8c5 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -231,6 +231,9 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
 	if (xe->unordered_wq)
 		destroy_workqueue(xe->unordered_wq);
 
+	if (xe->destroy_wq)
+		destroy_workqueue(xe->destroy_wq);
+
 	ttm_device_fini(&xe->ttm);
 }
 
@@ -293,8 +296,9 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq", 0);
 	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
 	xe->unordered_wq = alloc_workqueue("xe-unordered-wq", 0, 0);
+	xe->destroy_wq = alloc_workqueue("xe-destroy-wq", 0, 0);
 	if (!xe->ordered_wq || !xe->unordered_wq ||
-	    !xe->preempt_fence_wq) {
+	    !xe->preempt_fence_wq || !xe->destroy_wq) {
 		/*
 		 * Cleanup done in xe_device_destroy via
 		 * drmm_add_action_or_reset register above
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 2e62450d86e1..f671300e0c9b 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -376,6 +376,9 @@ struct xe_device {
 	/** @unordered_wq: used to serialize unordered work, mostly display */
 	struct workqueue_struct *unordered_wq;
 
+	/** @destroy_wq: used to serialize user destroy work, like queue */
+	struct workqueue_struct *destroy_wq;
+
 	/** @tiles: device tiles */
 	struct xe_tile tiles[XE_MAX_TILES_PER_DEVICE];
 
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.c b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
index e4ad1d6ce1d5..7f24e58cc992 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
@@ -90,6 +90,11 @@ void xe_sched_submission_stop(struct xe_gpu_scheduler *sched)
 	cancel_work_sync(&sched->work_process_msg);
 }
 
+void xe_sched_submission_resume_tdr(struct xe_gpu_scheduler *sched)
+{
+	drm_sched_resume_timeout(&sched->base, sched->base.timeout);
+}
+
 void xe_sched_add_msg(struct xe_gpu_scheduler *sched,
 		      struct xe_sched_msg *msg)
 {
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
index 10c6bb9c9386..6aac7fe68673 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
@@ -22,6 +22,8 @@ void xe_sched_fini(struct xe_gpu_scheduler *sched);
 void xe_sched_submission_start(struct xe_gpu_scheduler *sched);
 void xe_sched_submission_stop(struct xe_gpu_scheduler *sched);
 
+void xe_sched_submission_resume_tdr(struct xe_gpu_scheduler *sched);
+
 void xe_sched_add_msg(struct xe_gpu_scheduler *sched,
 		      struct xe_sched_msg *msg);
 
diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index 67e8efcaa93f..d924fdd8f6f9 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -307,7 +307,7 @@ static bool get_pagefault(struct pf_queue *pf_queue, struct pagefault *pf)
 			PFD_VIRTUAL_ADDR_LO_SHIFT;
 
 		pf_queue->tail = (pf_queue->tail + PF_MSG_LEN_DW) %
-			PF_QUEUE_NUM_DW;
+			pf_queue->num_dw;
 		ret = true;
 	}
 	spin_unlock_irq(&pf_queue->lock);
@@ -319,7 +319,8 @@ static bool pf_queue_full(struct pf_queue *pf_queue)
 {
 	lockdep_assert_held(&pf_queue->lock);
 
-	return CIRC_SPACE(pf_queue->head, pf_queue->tail, PF_QUEUE_NUM_DW) <=
+	return CIRC_SPACE(pf_queue->head, pf_queue->tail,
+			  pf_queue->num_dw) <=
 		PF_MSG_LEN_DW;
 }
 
@@ -332,22 +333,23 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
 	u32 asid;
 	bool full;
 
-	/*
-	 * The below logic doesn't work unless PF_QUEUE_NUM_DW % PF_MSG_LEN_DW == 0
-	 */
-	BUILD_BUG_ON(PF_QUEUE_NUM_DW % PF_MSG_LEN_DW);
-
 	if (unlikely(len != PF_MSG_LEN_DW))
 		return -EPROTO;
 
 	asid = FIELD_GET(PFD_ASID, msg[1]);
 	pf_queue = gt->usm.pf_queue + (asid % NUM_PF_QUEUE);
 
+	/*
+	 * The below logic doesn't work unless PF_QUEUE_NUM_DW % PF_MSG_LEN_DW == 0
+	 */
+	xe_gt_assert(gt, !(pf_queue->num_dw % PF_MSG_LEN_DW));
+
 	spin_lock_irqsave(&pf_queue->lock, flags);
 	full = pf_queue_full(pf_queue);
 	if (!full) {
 		memcpy(pf_queue->data + pf_queue->head, msg, len * sizeof(u32));
-		pf_queue->head = (pf_queue->head + len) % PF_QUEUE_NUM_DW;
+		pf_queue->head = (pf_queue->head + len) %
+			pf_queue->num_dw;
 		queue_work(gt->usm.pf_wq, &pf_queue->worker);
 	} else {
 		drm_warn(&xe->drm, "PF Queue full, shouldn't be possible");
@@ -414,18 +416,47 @@ static void pagefault_fini(void *arg)
 	destroy_workqueue(gt->usm.pf_wq);
 }
 
+static int xe_alloc_pf_queue(struct xe_gt *gt, struct pf_queue *pf_queue)
+{
+	struct xe_device *xe = gt_to_xe(gt);
+	xe_dss_mask_t all_dss;
+	int num_dss, num_eus;
+
+	bitmap_or(all_dss, gt->fuse_topo.g_dss_mask, gt->fuse_topo.c_dss_mask,
+		  XE_MAX_DSS_FUSE_BITS);
+
+	num_dss = bitmap_weight(all_dss, XE_MAX_DSS_FUSE_BITS);
+	num_eus = bitmap_weight(gt->fuse_topo.eu_mask_per_dss,
+				XE_MAX_EU_FUSE_BITS) * num_dss;
+
+	/* user can issue separate page faults per EU and per CS */
+	pf_queue->num_dw =
+		(num_eus + XE_NUM_HW_ENGINES) * PF_MSG_LEN_DW;
+
+	pf_queue->gt = gt;
+	pf_queue->data = devm_kcalloc(xe->drm.dev, pf_queue->num_dw,
+				      sizeof(u32), GFP_KERNEL);
+	if (!pf_queue->data)
+		return -ENOMEM;
+
+	spin_lock_init(&pf_queue->lock);
+	INIT_WORK(&pf_queue->worker, pf_queue_work_func);
+
+	return 0;
+}
+
 int xe_gt_pagefault_init(struct xe_gt *gt)
 {
 	struct xe_device *xe = gt_to_xe(gt);
-	int i;
+	int i, ret = 0;
 
 	if (!xe->info.has_usm)
 		return 0;
 
 	for (i = 0; i < NUM_PF_QUEUE; ++i) {
-		gt->usm.pf_queue[i].gt = gt;
-		spin_lock_init(&gt->usm.pf_queue[i].lock);
-		INIT_WORK(&gt->usm.pf_queue[i].worker, pf_queue_work_func);
+		ret = xe_alloc_pf_queue(gt, &gt->usm.pf_queue[i]);
+		if (ret)
+			return ret;
 	}
 	for (i = 0; i < NUM_ACC_QUEUE; ++i) {
 		gt->usm.acc_queue[i].gt = gt;
diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
index cfdc761ff7f4..2dbea50cd8f9 100644
--- a/drivers/gpu/drm/xe/xe_gt_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_types.h
@@ -229,9 +229,14 @@ struct xe_gt {
 		struct pf_queue {
 			/** @usm.pf_queue.gt: back pointer to GT */
 			struct xe_gt *gt;
-#define PF_QUEUE_NUM_DW	128
 			/** @usm.pf_queue.data: data in the page fault queue */
-			u32 data[PF_QUEUE_NUM_DW];
+			u32 *data;
+			/**
+			 * @usm.pf_queue.num_dw: number of DWORDS in the page
+			 * fault queue. Dynamically calculated based on the number
+			 * of compute resources available.
+			 */
+			u32 num_dw;
 			/**
 			 * @usm.pf_queue.tail: tail pointer in DWs for page fault queue,
 			 * moved by worker which processes faults (consumer).
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index 23382ced4ea7..69f8b6fdaeae 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -897,7 +897,7 @@ static void xe_guc_pc_fini(struct drm_device *drm, void *arg)
 	struct xe_guc_pc *pc = arg;
 
 	XE_WARN_ON(xe_force_wake_get(gt_to_fw(pc_to_gt(pc)), XE_FORCEWAKE_ALL));
-	XE_WARN_ON(xe_guc_pc_gucrc_disable(pc));
+	xe_guc_pc_gucrc_disable(pc);
 	XE_WARN_ON(xe_guc_pc_stop(pc));
 	xe_force_wake_put(gt_to_fw(pc_to_gt(pc)), XE_FORCEWAKE_ALL);
 }
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 0a496612c810..a0f829948803 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -233,10 +233,26 @@ static struct workqueue_struct *get_submit_wq(struct xe_guc *guc)
 }
 #endif
 
+static void xe_guc_submit_fini(struct xe_guc *guc)
+{
+	struct xe_device *xe = guc_to_xe(guc);
+	struct xe_gt *gt = guc_to_gt(guc);
+	int ret;
+
+	ret = wait_event_timeout(guc->submission_state.fini_wq,
+				 xa_empty(&guc->submission_state.exec_queue_lookup),
+				 HZ * 5);
+
+	drain_workqueue(xe->destroy_wq);
+
+	xe_gt_assert(gt, ret);
+}
+
 static void guc_submit_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc *guc = arg;
 
+	xe_guc_submit_fini(guc);
 	xa_destroy(&guc->submission_state.exec_queue_lookup);
 	free_submit_wq(guc);
 }
@@ -251,7 +267,6 @@ static void primelockdep(struct xe_guc *guc)
 	fs_reclaim_acquire(GFP_KERNEL);
 
 	mutex_lock(&guc->submission_state.lock);
-	might_lock(&guc->submission_state.suspend.lock);
 	mutex_unlock(&guc->submission_state.lock);
 
 	fs_reclaim_release(GFP_KERNEL);
@@ -279,8 +294,7 @@ int xe_guc_submit_init(struct xe_guc *guc)
 
 	xa_init(&guc->submission_state.exec_queue_lookup);
 
-	spin_lock_init(&guc->submission_state.suspend.lock);
-	guc->submission_state.suspend.context = dma_fence_context_alloc(1);
+	init_waitqueue_head(&guc->submission_state.fini_wq);
 
 	primelockdep(guc);
 
@@ -298,6 +312,9 @@ static void __release_guc_id(struct xe_guc *guc, struct xe_exec_queue *q, u32 xa
 
 	xe_guc_id_mgr_release_locked(&guc->submission_state.idm,
 				     q->guc->id, q->width);
+
+	if (xa_empty(&guc->submission_state.exec_queue_lookup))
+		wake_up(&guc->submission_state.fini_wq);
 }
 
 static int alloc_guc_id(struct xe_guc *guc, struct xe_exec_queue *q)
@@ -1029,13 +1046,16 @@ static void __guc_exec_queue_fini_async(struct work_struct *w)
 
 static void guc_exec_queue_fini_async(struct xe_exec_queue *q)
 {
+	struct xe_guc *guc = exec_queue_to_guc(q);
+	struct xe_device *xe = guc_to_xe(guc);
+
 	INIT_WORK(&q->guc->fini_async, __guc_exec_queue_fini_async);
 
 	/* We must block on kernel engines so slabs are empty on driver unload */
 	if (q->flags & EXEC_QUEUE_FLAG_PERMANENT)
 		__guc_exec_queue_fini_async(&q->guc->fini_async);
 	else
-		queue_work(system_wq, &q->guc->fini_async);
+		queue_work(xe->destroy_wq, &q->guc->fini_async);
 }
 
 static void __guc_exec_queue_fini(struct xe_guc *guc, struct xe_exec_queue *q)
@@ -1500,6 +1520,7 @@ static void guc_exec_queue_start(struct xe_exec_queue *q)
 	}
 
 	xe_sched_submission_start(sched);
+	xe_sched_submission_resume_tdr(sched);
 }
 
 int xe_guc_submit_start(struct xe_guc *guc)
diff --git a/drivers/gpu/drm/xe/xe_guc_types.h b/drivers/gpu/drm/xe/xe_guc_types.h
index 82bd93f7867d..69046f698271 100644
--- a/drivers/gpu/drm/xe/xe_guc_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_types.h
@@ -72,15 +72,6 @@ struct xe_guc {
 		atomic_t stopped;
 		/** @submission_state.lock: protects submission state */
 		struct mutex lock;
-		/** @submission_state.suspend: suspend fence state */
-		struct {
-			/** @submission_state.suspend.lock: suspend fences lock */
-			spinlock_t lock;
-			/** @submission_state.suspend.context: suspend fences context */
-			u64 context;
-			/** @submission_state.suspend.seqno: suspend fences seqno */
-			u32 seqno;
-		} suspend;
 #ifdef CONFIG_PROVE_LOCKING
 #define NUM_SUBMIT_WQ	256
 		/** @submission_state.submit_wq_pool: submission ordered workqueues pool */
@@ -90,6 +81,8 @@ struct xe_guc {
 #endif
 		/** @submission_state.enabled: submission is enabled */
 		bool enabled;
+		/** @submission_state.fini_wq: submit fini wait queue */
+		wait_queue_head_t fini_wq;
 	} submission_state;
 	/** @hwconfig: Hardware config state */
 	struct {
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index f326dbb1cecd..99824e19a376 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -868,6 +868,8 @@ static int xe_pci_resume(struct device *dev)
 	if (err)
 		return err;
 
+	pci_restore_state(pdev);
+
 	err = pci_enable_device(pdev);
 	if (err)
 		return err;
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 781c5aa29859..06104a4e0fdc 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -417,24 +417,8 @@
 #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W	0x0401
 #define USB_DEVICE_ID_HP_X2		0x074d
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
-#define I2C_DEVICE_ID_HP_ENVY_X360_15	0x2d05
-#define I2C_DEVICE_ID_HP_ENVY_X360_15T_DR100	0x29CF
-#define I2C_DEVICE_ID_HP_ENVY_X360_EU0009NV	0x2CF9
-#define I2C_DEVICE_ID_HP_SPECTRE_X360_15	0x2817
-#define I2C_DEVICE_ID_HP_SPECTRE_X360_13_AW0020NG  0x29DF
-#define I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN 0x2BC8
-#define I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN 0x2C82
-#define I2C_DEVICE_ID_ASUS_UX3402_TOUCHSCREEN 0x2F2C
-#define I2C_DEVICE_ID_ASUS_UX6404_TOUCHSCREEN 0x4116
 #define USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN	0x2544
 #define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN	0x2706
-#define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN	0x261A
-#define I2C_DEVICE_ID_SURFACE_GO2_TOUCHSCREEN	0x2A1C
-#define I2C_DEVICE_ID_LENOVO_YOGA_C630_TOUCHSCREEN	0x279F
-#define I2C_DEVICE_ID_HP_SPECTRE_X360_13T_AW100	0x29F5
-#define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1	0x2BED
-#define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2	0x2BEE
-#define I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG		0x2D02
 #define I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM	0x2F81
 
 #define USB_VENDOR_ID_ELECOM		0x056e
@@ -810,6 +794,7 @@
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
 #define USB_DEVICE_ID_LENOVO_X1_TAB3	0x60b5
 #define USB_DEVICE_ID_LENOVO_X12_TAB	0x60fe
+#define USB_DEVICE_ID_LENOVO_X12_TAB2	0x61ae
 #define USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E	0x600e
 #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D	0x608d
 #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019	0x6019
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c9094a4f281e..fda9dce3da99 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -373,14 +373,6 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD),
 	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_UX3402_TOUCHSCREEN),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_UX6404_TOUCHSCREEN),
-	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN),
@@ -391,32 +383,13 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UGEE, USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_PRO_SW),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15T_DR100),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_EU0009NV),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_15),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_13_AW0020NG),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_GO2_TOUCHSCREEN),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_LENOVO_YOGA_C630_TOUCHSCREEN),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_13T_AW100),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2),
-	  HID_BATTERY_QUIRK_IGNORE },
-	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG),
-	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	/*
+	 * Elan I2C-HID touchscreens seem to all report a non present battery,
+	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C-HID devices.
+	 */
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 99812c0f830b..c4a6908bbe54 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2113,6 +2113,12 @@ static const struct hid_device_id mt_devices[] = {
 			   USB_VENDOR_ID_LENOVO,
 			   USB_DEVICE_ID_LENOVO_X12_TAB) },
 
+	/* Lenovo X12 TAB Gen 2 */
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			   USB_VENDOR_ID_LENOVO,
+			   USB_DEVICE_ID_LENOVO_X12_TAB2) },
+
 	/* Logitech devices */
 	{ .driver_data = MT_CLS_NSMU,
 		HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_MULTITOUCH_WIN_8,
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 632eaf9e11a6..2f8a9d3f1e86 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -105,6 +105,7 @@ struct i2c_hid {
 
 	wait_queue_head_t	wait;		/* For waiting the interrupt */
 
+	struct mutex		cmd_lock;	/* protects cmdbuf and rawbuf */
 	struct mutex		reset_lock;
 
 	struct i2chid_ops	*ops;
@@ -220,6 +221,8 @@ static int i2c_hid_xfer(struct i2c_hid *ihid,
 static int i2c_hid_read_register(struct i2c_hid *ihid, __le16 reg,
 				 void *buf, size_t len)
 {
+	guard(mutex)(&ihid->cmd_lock);
+
 	*(__le16 *)ihid->cmdbuf = reg;
 
 	return i2c_hid_xfer(ihid, ihid->cmdbuf, sizeof(__le16), buf, len);
@@ -252,6 +255,8 @@ static int i2c_hid_get_report(struct i2c_hid *ihid,
 
 	i2c_hid_dbg(ihid, "%s\n", __func__);
 
+	guard(mutex)(&ihid->cmd_lock);
+
 	/* Command register goes first */
 	*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
 	length += sizeof(__le16);
@@ -342,6 +347,8 @@ static int i2c_hid_set_or_send_report(struct i2c_hid *ihid,
 	if (!do_set && le16_to_cpu(ihid->hdesc.wMaxOutputLength) == 0)
 		return -ENOSYS;
 
+	guard(mutex)(&ihid->cmd_lock);
+
 	if (do_set) {
 		/* Command register goes first */
 		*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
@@ -384,6 +391,8 @@ static int i2c_hid_set_power_command(struct i2c_hid *ihid, int power_state)
 {
 	size_t length;
 
+	guard(mutex)(&ihid->cmd_lock);
+
 	/* SET_POWER uses command register */
 	*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
 	length = sizeof(__le16);
@@ -440,25 +449,27 @@ static int i2c_hid_start_hwreset(struct i2c_hid *ihid)
 	if (ret)
 		return ret;
 
-	/* Prepare reset command. Command register goes first. */
-	*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
-	length += sizeof(__le16);
-	/* Next is RESET command itself */
-	length += i2c_hid_encode_command(ihid->cmdbuf + length,
-					 I2C_HID_OPCODE_RESET, 0, 0);
+	scoped_guard(mutex, &ihid->cmd_lock) {
+		/* Prepare reset command. Command register goes first. */
+		*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
+		length += sizeof(__le16);
+		/* Next is RESET command itself */
+		length += i2c_hid_encode_command(ihid->cmdbuf + length,
+						 I2C_HID_OPCODE_RESET, 0, 0);
 
-	set_bit(I2C_HID_RESET_PENDING, &ihid->flags);
+		set_bit(I2C_HID_RESET_PENDING, &ihid->flags);
 
-	ret = i2c_hid_xfer(ihid, ihid->cmdbuf, length, NULL, 0);
-	if (ret) {
-		dev_err(&ihid->client->dev,
-			"failed to reset device: %d\n", ret);
-		goto err_clear_reset;
-	}
+		ret = i2c_hid_xfer(ihid, ihid->cmdbuf, length, NULL, 0);
+		if (ret) {
+			dev_err(&ihid->client->dev,
+				"failed to reset device: %d\n", ret);
+			break;
+		}
 
-	return 0;
+		return 0;
+	}
 
-err_clear_reset:
+	/* Clean up if sending reset command failed */
 	clear_bit(I2C_HID_RESET_PENDING, &ihid->flags);
 	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
 	return ret;
@@ -1200,6 +1211,7 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	ihid->is_panel_follower = drm_is_panel_follower(&client->dev);
 
 	init_waitqueue_head(&ihid->wait);
+	mutex_init(&ihid->cmd_lock);
 	mutex_init(&ihid->reset_lock);
 	INIT_WORK(&ihid->panel_follower_prepare_work, ihid_core_panel_prepare_work);
 
diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 9aa4dcf4a6f3..096f1daa8f2b 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1269,6 +1269,7 @@ static const char * const asus_msi_boards[] = {
 	"EX-B760M-V5 D4",
 	"EX-H510M-V3",
 	"EX-H610M-V3 D4",
+	"G15CF",
 	"PRIME A620M-A",
 	"PRIME B560-PLUS",
 	"PRIME B560-PLUS AC-HES",
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index e8a688d04aee..edda6a70907b 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -441,6 +441,7 @@ int i2c_dw_set_sda_hold(struct dw_i2c_dev *dev)
 
 void __i2c_dw_disable(struct dw_i2c_dev *dev)
 {
+	struct i2c_timings *t = &dev->timings;
 	unsigned int raw_intr_stats;
 	unsigned int enable;
 	int timeout = 100;
@@ -453,6 +454,19 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 
 	abort_needed = raw_intr_stats & DW_IC_INTR_MST_ON_HOLD;
 	if (abort_needed) {
+		if (!(enable & DW_IC_ENABLE_ENABLE)) {
+			regmap_write(dev->map, DW_IC_ENABLE, DW_IC_ENABLE_ENABLE);
+			/*
+			 * Wait 10 times the signaling period of the highest I2C
+			 * transfer supported by the driver (for 400KHz this is
+			 * 25us) to ensure the I2C ENABLE bit is already set
+			 * as described in the DesignWare I2C databook.
+			 */
+			fsleep(DIV_ROUND_CLOSEST_ULL(10 * MICRO, t->bus_freq_hz));
+			/* Set ENABLE bit before setting ABORT */
+			enable |= DW_IC_ENABLE_ENABLE;
+		}
+
 		regmap_write(dev->map, DW_IC_ENABLE, enable | DW_IC_ENABLE_ABORT);
 		ret = regmap_read_poll_timeout(dev->map, DW_IC_ENABLE, enable,
 					       !(enable & DW_IC_ENABLE_ABORT), 10,
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index e9606c00b8d1..e45daedad967 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -109,6 +109,7 @@
 						 DW_IC_INTR_RX_UNDER | \
 						 DW_IC_INTR_RD_REQ)
 
+#define DW_IC_ENABLE_ENABLE			BIT(0)
 #define DW_IC_ENABLE_ABORT			BIT(1)
 
 #define DW_IC_STATUS_ACTIVITY			BIT(0)
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index c7e56002809a..7b260a3617f6 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -253,6 +253,34 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	__i2c_dw_write_intr_mask(dev, DW_IC_INTR_MASTER_MASK);
 }
 
+/*
+ * This function waits for the controller to be idle before disabling I2C
+ * When the controller is not in the IDLE state, the MST_ACTIVITY bit
+ * (IC_STATUS[5]) is set.
+ *
+ * Values:
+ * 0x1 (ACTIVE): Controller not idle
+ * 0x0 (IDLE): Controller is idle
+ *
+ * The function is called after completing the current transfer.
+ *
+ * Returns:
+ * False when the controller is in the IDLE state.
+ * True when the controller is in the ACTIVE state.
+ */
+static bool i2c_dw_is_controller_active(struct dw_i2c_dev *dev)
+{
+	u32 status;
+
+	regmap_read(dev->map, DW_IC_STATUS, &status);
+	if (!(status & DW_IC_STATUS_MASTER_ACTIVITY))
+		return false;
+
+	return regmap_read_poll_timeout(dev->map, DW_IC_STATUS, status,
+				       !(status & DW_IC_STATUS_MASTER_ACTIVITY),
+				       1100, 20000) != 0;
+}
+
 static int i2c_dw_check_stopbit(struct dw_i2c_dev *dev)
 {
 	u32 val;
@@ -788,6 +816,16 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		goto done;
 	}
 
+	/*
+	 * This happens rarely (~1:500) and is hard to reproduce. Debug trace
+	 * showed that IC_STATUS had value of 0x23 when STOP_DET occurred,
+	 * if disable IC_ENABLE.ENABLE immediately that can result in
+	 * IC_RAW_INTR_STAT.MASTER_ON_HOLD holding SCL low. Check if
+	 * controller is still ACTIVE before disabling I2C.
+	 */
+	if (i2c_dw_is_controller_active(dev))
+		dev_err(dev->dev, "controller active\n");
+
 	/*
 	 * We must disable the adapter before returning and signaling the end
 	 * of the current transfer. Otherwise the hardware might continue
diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 06e836e3e877..4c9050a4d58e 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -818,15 +818,13 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	init_completion(&gi2c->done);
 	spin_lock_init(&gi2c->lock);
 	platform_set_drvdata(pdev, gi2c);
-	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, 0,
+	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, IRQF_NO_AUTOEN,
 			       dev_name(dev), gi2c);
 	if (ret) {
 		dev_err(dev, "Request_irq failed:%d: err:%d\n",
 			gi2c->irq, ret);
 		return ret;
 	}
-	/* Disable the interrupt so that the system can enter low-power mode */
-	disable_irq(gi2c->irq);
 	i2c_set_adapdata(&gi2c->adap, gi2c);
 	gi2c->adap.dev.parent = dev;
 	gi2c->adap.dev.of_node = dev->of_node;
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index cfee2d9c09de..0174ead99de6 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -2395,7 +2395,7 @@ static int __maybe_unused stm32f7_i2c_runtime_suspend(struct device *dev)
 	struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
 	if (!stm32f7_i2c_is_slave_registered(i2c_dev))
-		clk_disable_unprepare(i2c_dev->clk);
+		clk_disable(i2c_dev->clk);
 
 	return 0;
 }
@@ -2406,9 +2406,9 @@ static int __maybe_unused stm32f7_i2c_runtime_resume(struct device *dev)
 	int ret;
 
 	if (!stm32f7_i2c_is_slave_registered(i2c_dev)) {
-		ret = clk_prepare_enable(i2c_dev->clk);
+		ret = clk_enable(i2c_dev->clk);
 		if (ret) {
-			dev_err(dev, "failed to prepare_enable clock\n");
+			dev_err(dev, "failed to enable clock\n");
 			return ret;
 		}
 	}
diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index 4eccbcd0fbfc..bbb9062669e4 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -550,12 +550,13 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
 	device_property_read_u32(&pdev->dev, "socionext,pclk-rate",
 				 &i2c->pclkrate);
 
-	pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
+	pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(pclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
 				     "failed to get and enable clock\n");
 
-	i2c->pclkrate = clk_get_rate(pclk);
+	if (pclk)
+		i2c->pclkrate = clk_get_rate(pclk);
 
 	if (i2c->pclkrate < SYNQUACER_I2C_MIN_CLK_RATE ||
 	    i2c->pclkrate > SYNQUACER_I2C_MAX_CLK_RATE)
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 71391b590ada..1d68177241a6 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -772,14 +772,17 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 			goto out;
 		}
 
-		xiic_fill_tx_fifo(i2c);
-
-		/* current message sent and there is space in the fifo */
-		if (!xiic_tx_space(i2c) && xiic_tx_fifo_space(i2c) >= 2) {
+		if (xiic_tx_space(i2c)) {
+			xiic_fill_tx_fifo(i2c);
+		} else {
+			/* current message fully written */
 			dev_dbg(i2c->adap.dev.parent,
 				"%s end of message sent, nmsgs: %d\n",
 				__func__, i2c->nmsgs);
-			if (i2c->nmsgs > 1) {
+			/* Don't move onto the next message until the TX FIFO empties,
+			 * to ensure that a NAK is not missed.
+			 */
+			if (i2c->nmsgs > 1 && (pend & XIIC_INTR_TX_EMPTY_MASK)) {
 				i2c->nmsgs--;
 				i2c->tx_msg++;
 				xfer_more = 1;
@@ -790,11 +793,7 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
 					"%s Got TX IRQ but no more to do...\n",
 					__func__);
 			}
-		} else if (!xiic_tx_space(i2c) && (i2c->nmsgs == 1))
-			/* current frame is sent and is last,
-			 * make sure to disable tx half
-			 */
-			xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
+		}
 	}
 
 	if (pend & XIIC_INTR_BNB_MASK) {
@@ -844,23 +843,11 @@ static int xiic_bus_busy(struct xiic_i2c *i2c)
 	return (sr & XIIC_SR_BUS_BUSY_MASK) ? -EBUSY : 0;
 }
 
-static int xiic_busy(struct xiic_i2c *i2c)
+static int xiic_wait_not_busy(struct xiic_i2c *i2c)
 {
 	int tries = 3;
 	int err;
 
-	if (i2c->tx_msg || i2c->rx_msg)
-		return -EBUSY;
-
-	/* In single master mode bus can only be busy, when in use by this
-	 * driver. If the register indicates bus being busy for some reason we
-	 * should ignore it, since bus will never be released and i2c will be
-	 * stuck forever.
-	 */
-	if (i2c->singlemaster) {
-		return 0;
-	}
-
 	/* for instance if previous transfer was terminated due to TX error
 	 * it might be that the bus is on it's way to become available
 	 * give it at most 3 ms to wake
@@ -1104,9 +1091,35 @@ static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num)
 
 	mutex_lock(&i2c->lock);
 
-	ret = xiic_busy(i2c);
-	if (ret)
+	if (i2c->tx_msg || i2c->rx_msg) {
+		dev_err(i2c->adap.dev.parent,
+			"cannot start a transfer while busy\n");
+		ret = -EBUSY;
 		goto out;
+	}
+
+	/* In single master mode bus can only be busy, when in use by this
+	 * driver. If the register indicates bus being busy for some reason we
+	 * should ignore it, since bus will never be released and i2c will be
+	 * stuck forever.
+	 */
+	if (!i2c->singlemaster) {
+		ret = xiic_wait_not_busy(i2c);
+		if (ret) {
+			/* If the bus is stuck in a busy state, such as due to spurious low
+			 * pulses on the bus causing a false start condition to be detected,
+			 * then try to recover by re-initializing the controller and check
+			 * again if the bus is still busy.
+			 */
+			dev_warn(i2c->adap.dev.parent, "I2C bus busy timeout, reinitializing\n");
+			ret = xiic_reinit(i2c);
+			if (ret)
+				goto out;
+			ret = xiic_wait_not_busy(i2c);
+			if (ret)
+				goto out;
+		}
+	}
 
 	i2c->tx_msg = msgs;
 	i2c->rx_msg = NULL;
@@ -1164,10 +1177,8 @@ static int xiic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		return err;
 
 	err = xiic_start_xfer(i2c, msgs, num);
-	if (err < 0) {
-		dev_err(adap->dev.parent, "Error xiic_start_xfer\n");
+	if (err < 0)
 		goto out;
-	}
 
 	err = wait_for_completion_timeout(&i2c->completion, XIIC_XFER_TIMEOUT);
 	mutex_lock(&i2c->lock);
@@ -1326,8 +1337,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	return 0;
 
 err_pm_disable:
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 
 	return ret;
 }
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 7e7b15440832..43da2c211655 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -915,6 +915,27 @@ int i2c_dev_irq_from_resources(const struct resource *resources,
 	return 0;
 }
 
+/*
+ * Serialize device instantiation in case it can be instantiated explicitly
+ * and by auto-detection
+ */
+static int i2c_lock_addr(struct i2c_adapter *adap, unsigned short addr,
+			 unsigned short flags)
+{
+	if (!(flags & I2C_CLIENT_TEN) &&
+	    test_and_set_bit(addr, adap->addrs_in_instantiation))
+		return -EBUSY;
+
+	return 0;
+}
+
+static void i2c_unlock_addr(struct i2c_adapter *adap, unsigned short addr,
+			    unsigned short flags)
+{
+	if (!(flags & I2C_CLIENT_TEN))
+		clear_bit(addr, adap->addrs_in_instantiation);
+}
+
 /**
  * i2c_new_client_device - instantiate an i2c device
  * @adap: the adapter managing the device
@@ -962,6 +983,10 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 		goto out_err_silent;
 	}
 
+	status = i2c_lock_addr(adap, client->addr, client->flags);
+	if (status)
+		goto out_err_silent;
+
 	/* Check for address business */
 	status = i2c_check_addr_busy(adap, i2c_encode_flags_to_addr(client));
 	if (status)
@@ -993,6 +1018,8 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	dev_dbg(&adap->dev, "client [%s] registered with bus id %s\n",
 		client->name, dev_name(&client->dev));
 
+	i2c_unlock_addr(adap, client->addr, client->flags);
+
 	return client;
 
 out_remove_swnode:
@@ -1004,6 +1031,7 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	dev_err(&adap->dev,
 		"Failed to register i2c client %s at 0x%02x (%d)\n",
 		client->name, client->addr, status);
+	i2c_unlock_addr(adap, client->addr, client->flags);
 out_err_silent:
 	if (need_put)
 		put_device(&client->dev);
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index f0362509319e..1e500d9e6d2e 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1750,6 +1750,7 @@ static void svc_i3c_master_remove(struct platform_device *pdev)
 {
 	struct svc_i3c_master *master = platform_get_drvdata(pdev);
 
+	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index ccbebe5b66cd..e78de8a971c7 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -692,22 +692,8 @@ static int ak8975_start_read_axis(struct ak8975_data *data,
 	if (ret < 0)
 		return ret;
 
-	/* This will be executed only for non-interrupt based waiting case */
-	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
-		ret = i2c_smbus_read_byte_data(client,
-					       data->def->ctrl_regs[ST2]);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST2\n");
-			return ret;
-		}
-		if (ret & (data->def->ctrl_masks[ST2_DERR] |
-			   data->def->ctrl_masks[ST2_HOFL])) {
-			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
+	/* Return with zero if the data is ready. */
+	return !data->def->ctrl_regs[ST1_DRDY];
 }
 
 /* Retrieve raw flux value for one of the x, y, or z axis.  */
@@ -734,6 +720,20 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	if (ret < 0)
 		goto exit;
 
+	/* Read out ST2 for release lock on measurment data. */
+	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error in reading ST2\n");
+		goto exit;
+	}
+
+	if (ret & (data->def->ctrl_masks[ST2_DERR] |
+		   data->def->ctrl_masks[ST2_HOFL])) {
+		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	mutex_unlock(&data->lock);
 
 	pm_runtime_mark_last_busy(&data->client->dev);
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 221fa2c552ae..1549f361a473 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -52,7 +52,6 @@
  */
 enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
 
-
 enum bmp380_odr {
 	BMP380_ODR_200HZ,
 	BMP380_ODR_100HZ,
@@ -181,18 +180,19 @@ static int bmp280_read_calib(struct bmp280_data *data)
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	int ret;
 
-
 	/* Read temperature and pressure calibration values. */
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
-			       data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
+			       data->bmp280_cal_buf,
+			       sizeof(data->bmp280_cal_buf));
 	if (ret < 0) {
 		dev_err(data->dev,
-			"failed to read temperature and pressure calibration parameters\n");
+			"failed to read calibration parameters\n");
 		return ret;
 	}
 
-	/* Toss the temperature and pressure calibration data into the entropy pool */
-	add_device_randomness(data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
+	/* Toss calibration data into the entropy pool */
+	add_device_randomness(data->bmp280_cal_buf,
+			      sizeof(data->bmp280_cal_buf));
 
 	/* Parse temperature calibration values. */
 	calib->T1 = le16_to_cpu(data->bmp280_cal_buf[T1]);
@@ -223,7 +223,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 	/* Load shared calibration params with bmp280 first */
 	ret = bmp280_read_calib(data);
 	if  (ret < 0) {
-		dev_err(dev, "failed to read common bmp280 calibration parameters\n");
+		dev_err(dev, "failed to read calibration parameters\n");
 		return ret;
 	}
 
@@ -235,14 +235,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 	 * Humidity data is only available on BME280.
 	 */
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &tmp);
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H1 comp value\n");
 		return ret;
 	}
 	calib->H1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
 			       &data->le16, sizeof(data->le16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H2 comp value\n");
@@ -250,14 +250,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 	}
 	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H3 comp value\n");
 		return ret;
 	}
 	calib->H3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
 			       &data->be16, sizeof(data->be16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H4 comp value\n");
@@ -266,15 +266,15 @@ static int bme280_read_calib(struct bmp280_data *data)
 	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
 				  (be16_to_cpu(data->be16) & 0xf), 11);
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
 			       &data->le16, sizeof(data->le16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
+	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H6 comp value\n");
 		return ret;
@@ -283,13 +283,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	return 0;
 }
+
 /*
  * Returns humidity in percent, resolution is 0.01 percent. Output value of
  * "47445" represents 47445/1024 = 46.333 %RH.
  *
  * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
  */
-static u32 bmp280_compensate_humidity(struct bmp280_data *data,
+static u32 bme280_compensate_humidity(struct bmp280_data *data,
 				      s32 adc_humidity)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
@@ -305,7 +306,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 	var = clamp_val(var, 0, 419430400);
 
 	return var >> 12;
-};
+}
 
 /*
  * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
@@ -429,7 +430,7 @@ static int bmp280_read_press(struct bmp280_data *data,
 	return IIO_VAL_FRACTIONAL;
 }
 
-static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
+static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_humidity;
 	s32 adc_humidity;
@@ -440,7 +441,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
 			       &data->be16, sizeof(data->be16));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read humidity\n");
@@ -453,7 +454,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 		dev_err(data->dev, "reading humidity skipped\n");
 		return -EIO;
 	}
-	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
+	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
 
 	*val = comp_humidity * 1000 / 1024;
 
@@ -537,8 +538,8 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
-					       int val)
+static int bme280_write_oversampling_ratio_humid(struct bmp280_data *data,
+						 int val)
 {
 	const int *avail = data->chip_info->oversampling_humid_avail;
 	const int n = data->chip_info->num_oversampling_humid_avail;
@@ -563,7 +564,7 @@ static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
 }
 
 static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
-					       int val)
+						int val)
 {
 	const int *avail = data->chip_info->oversampling_temp_avail;
 	const int n = data->chip_info->num_oversampling_temp_avail;
@@ -588,7 +589,7 @@ static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
 }
 
 static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
-					       int val)
+						 int val)
 {
 	const int *avail = data->chip_info->oversampling_press_avail;
 	const int n = data->chip_info->num_oversampling_press_avail;
@@ -681,7 +682,7 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&data->lock);
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = bmp280_write_oversampling_ratio_humid(data, val);
+			ret = bme280_write_oversampling_ratio_humid(data, val);
 			break;
 		case IIO_PRESSURE:
 			ret = bmp280_write_oversampling_ratio_press(data, val);
@@ -772,13 +773,12 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
-				 BMP280_OSRS_TEMP_MASK |
-				 BMP280_OSRS_PRESS_MASK |
-				 BMP280_MODE_MASK,
-				 osrs | BMP280_MODE_NORMAL);
+				BMP280_OSRS_TEMP_MASK |
+				BMP280_OSRS_PRESS_MASK |
+				BMP280_MODE_MASK,
+				osrs | BMP280_MODE_NORMAL);
 	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to write ctrl_meas register\n");
+		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
 	}
 
@@ -786,8 +786,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				 BMP280_FILTER_MASK,
 				 BMP280_FILTER_4X);
 	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to write config register\n");
+		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
 
@@ -833,16 +832,15 @@ EXPORT_SYMBOL_NS(bmp280_chip_info, IIO_BMP280);
 
 static int bme280_chip_config(struct bmp280_data *data)
 {
-	u8 osrs = FIELD_PREP(BMP280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
+	u8 osrs = FIELD_PREP(BME280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
 	int ret;
 
 	/*
 	 * Oversampling of humidity must be set before oversampling of
 	 * temperature/pressure is set to become effective.
 	 */
-	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
-				  BMP280_OSRS_HUMIDITY_MASK, osrs);
-
+	ret = regmap_update_bits(data->regmap, BME280_REG_CTRL_HUMIDITY,
+				 BME280_OSRS_HUMIDITY_MASK, osrs);
 	if (ret < 0)
 		return ret;
 
@@ -855,7 +853,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
 	.chip_id = bme280_chip_ids,
 	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
-	.regmap_config = &bmp280_regmap_config,
+	.regmap_config = &bme280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = 3,
@@ -870,12 +868,12 @@ const struct bmp280_chip_info bme280_chip_info = {
 
 	.oversampling_humid_avail = bmp280_oversampling_avail,
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
-	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
+	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
-	.read_humid = bmp280_read_humid,
+	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
 };
 EXPORT_SYMBOL_NS(bme280_chip_info, IIO_BMP280);
@@ -926,8 +924,8 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
 }
 
 /*
- * Returns temperature in Celsius degrees, resolution is 0.01º C. Output value of
- * "5123" equals 51.2º C. t_fine carries fine temperature as global value.
+ * Returns temperature in Celsius degrees, resolution is 0.01º C. Output value
+ * of "5123" equals 51.2º C. t_fine carries fine temperature as global value.
  *
  * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
  * https://github.com/BoschSensortec/BMP3-Sensor-API.
@@ -1069,7 +1067,8 @@ static int bmp380_read_calib(struct bmp280_data *data)
 
 	/* Read temperature and pressure calibration data */
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START,
-			       data->bmp380_cal_buf, sizeof(data->bmp380_cal_buf));
+			       data->bmp380_cal_buf,
+			       sizeof(data->bmp380_cal_buf));
 	if (ret) {
 		dev_err(data->dev,
 			"failed to read temperature calibration parameters\n");
@@ -1077,7 +1076,8 @@ static int bmp380_read_calib(struct bmp280_data *data)
 	}
 
 	/* Toss the temperature calibration data into the entropy pool */
-	add_device_randomness(data->bmp380_cal_buf, sizeof(data->bmp380_cal_buf));
+	add_device_randomness(data->bmp380_cal_buf,
+			      sizeof(data->bmp380_cal_buf));
 
 	/* Parse calibration values */
 	calib->T1 = get_unaligned_le16(&data->bmp380_cal_buf[BMP380_T1]);
@@ -1159,7 +1159,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 	/* Configure output data rate */
 	ret = regmap_update_bits_check(data->regmap, BMP380_REG_ODR,
-				       BMP380_ODRS_MASK, data->sampling_freq, &aux);
+				       BMP380_ODRS_MASK, data->sampling_freq,
+				       &aux);
 	if (ret) {
 		dev_err(data->dev, "failed to write ODR selection register\n");
 		return ret;
@@ -1178,12 +1179,13 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 	if (change) {
 		/*
-		 * The configurations errors are detected on the fly during a measurement
-		 * cycle. If the sampling frequency is too low, it's faster to reset
-		 * the measurement loop than wait until the next measurement is due.
+		 * The configurations errors are detected on the fly during a
+		 * measurement cycle. If the sampling frequency is too low, it's
+		 * faster to reset the measurement loop than wait until the next
+		 * measurement is due.
 		 *
-		 * Resets sensor measurement loop toggling between sleep and normal
-		 * operating modes.
+		 * Resets sensor measurement loop toggling between sleep and
+		 * normal operating modes.
 		 */
 		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
 					BMP380_MODE_MASK,
@@ -1201,22 +1203,22 @@ static int bmp380_chip_config(struct bmp280_data *data)
 			return ret;
 		}
 		/*
-		 * Waits for measurement before checking configuration error flag.
-		 * Selected longest measure time indicated in section 3.9.1
-		 * in the datasheet.
+		 * Waits for measurement before checking configuration error
+		 * flag. Selected longest measurement time, calculated from
+		 * formula in datasheet section 3.9.2 with an offset of ~+15%
+		 * as it seen as well in table 3.9.1.
 		 */
-		msleep(80);
+		msleep(150);
 
 		/* Check config error flag */
 		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
 		if (ret) {
-			dev_err(data->dev,
-				"failed to read error register\n");
+			dev_err(data->dev, "failed to read error register\n");
 			return ret;
 		}
 		if (tmp & BMP380_ERR_CONF_MASK) {
 			dev_warn(data->dev,
-				"sensor flagged configuration as incompatible\n");
+				 "sensor flagged configuration as incompatible\n");
 			return -EINVAL;
 		}
 	}
@@ -1317,9 +1319,11 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 	}
 
 	/* Start NVM operation sequence */
-	ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_NVM_OP_SEQ_0);
+	ret = regmap_write(data->regmap, BMP580_REG_CMD,
+			   BMP580_CMD_NVM_OP_SEQ_0);
 	if (ret) {
-		dev_err(data->dev, "failed to send nvm operation's first sequence\n");
+		dev_err(data->dev,
+			"failed to send nvm operation's first sequence\n");
 		return ret;
 	}
 	if (is_write) {
@@ -1327,7 +1331,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		ret = regmap_write(data->regmap, BMP580_REG_CMD,
 				   BMP580_CMD_NVM_WRITE_SEQ_1);
 		if (ret) {
-			dev_err(data->dev, "failed to send nvm write sequence\n");
+			dev_err(data->dev,
+				"failed to send nvm write sequence\n");
 			return ret;
 		}
 		/* Datasheet says on 4.8.1.2 it takes approximately 10ms */
@@ -1338,7 +1343,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		ret = regmap_write(data->regmap, BMP580_REG_CMD,
 				   BMP580_CMD_NVM_READ_SEQ_1);
 		if (ret) {
-			dev_err(data->dev, "failed to send nvm read sequence\n");
+			dev_err(data->dev,
+				"failed to send nvm read sequence\n");
 			return ret;
 		}
 		/* Datasheet says on 4.8.1.1 it takes approximately 200us */
@@ -1501,8 +1507,8 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 		if (ret)
 			goto exit;
 
-		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
-				       sizeof(data->le16));
+		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB,
+				       &data->le16, sizeof(data->le16));
 		if (ret) {
 			dev_err(data->dev, "error reading nvm data regs\n");
 			goto exit;
@@ -1546,7 +1552,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 	while (bytes >= sizeof(*buf)) {
 		addr = bmp580_nvmem_addrs[offset / sizeof(*buf)];
 
-		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR, BMP580_NVM_PROG_EN |
+		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
+				   BMP580_NVM_PROG_EN |
 				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
 		if (ret) {
 			dev_err(data->dev, "error writing nvm address\n");
@@ -1554,8 +1561,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 		}
 		data->le16 = cpu_to_le16(*buf++);
 
-		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
-					sizeof(data->le16));
+		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB,
+					&data->le16, sizeof(data->le16));
 		if (ret) {
 			dev_err(data->dev, "error writing LSB NVM data regs\n");
 			goto exit;
@@ -1662,7 +1669,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 		  BMP580_OSR_PRESS_EN;
 
 	ret = regmap_update_bits_check(data->regmap, BMP580_REG_OSR_CONFIG,
-				       BMP580_OSR_TEMP_MASK | BMP580_OSR_PRESS_MASK |
+				       BMP580_OSR_TEMP_MASK |
+				       BMP580_OSR_PRESS_MASK |
 				       BMP580_OSR_PRESS_EN,
 				       reg_val, &aux);
 	if (ret) {
@@ -1713,7 +1721,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 		 */
 		ret = regmap_read(data->regmap, BMP580_REG_EFF_OSR, &tmp);
 		if (ret) {
-			dev_err(data->dev, "error reading effective OSR register\n");
+			dev_err(data->dev,
+				"error reading effective OSR register\n");
 			return ret;
 		}
 		if (!(tmp & BMP580_EFF_OSR_VALID_ODR)) {
@@ -1848,7 +1857,8 @@ static int bmp180_read_calib(struct bmp280_data *data)
 	}
 
 	/* Toss the calibration data into the entropy pool */
-	add_device_randomness(data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
+	add_device_randomness(data->bmp180_cal_buf,
+			      sizeof(data->bmp180_cal_buf));
 
 	calib->AC1 = be16_to_cpu(data->bmp180_cal_buf[AC1]);
 	calib->AC2 = be16_to_cpu(data->bmp180_cal_buf[AC2]);
@@ -1963,8 +1973,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 	return p + ((x1 + x2 + 3791) >> 4);
 }
 
-static int bmp180_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_press;
 	s32 adc_press;
@@ -2241,6 +2250,7 @@ static int bmp280_runtime_resume(struct device *dev)
 	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
 	if (ret)
 		return ret;
+
 	usleep_range(data->start_up_time, data->start_up_time + 100);
 	return data->chip_info->chip_config(data);
 }
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index 3ee56720428c..d27d68edd906 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -41,11 +41,23 @@ const struct regmap_config bmp180_regmap_config = {
 };
 EXPORT_SYMBOL_NS(bmp180_regmap_config, IIO_BMP280);
 
+static bool bme280_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP280_REG_CONFIG:
+	case BME280_REG_CTRL_HUMIDITY:
+	case BMP280_REG_CTRL_MEAS:
+	case BMP280_REG_RESET:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case BMP280_REG_CONFIG:
-	case BMP280_REG_CTRL_HUMIDITY:
 	case BMP280_REG_CTRL_MEAS:
 	case BMP280_REG_RESET:
 		return true;
@@ -57,8 +69,6 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case BMP280_REG_HUMIDITY_LSB:
-	case BMP280_REG_HUMIDITY_MSB:
 	case BMP280_REG_TEMP_XLSB:
 	case BMP280_REG_TEMP_LSB:
 	case BMP280_REG_TEMP_MSB:
@@ -72,6 +82,23 @@ static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool bme280_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BME280_REG_HUMIDITY_LSB:
+	case BME280_REG_HUMIDITY_MSB:
+	case BMP280_REG_TEMP_XLSB:
+	case BMP280_REG_TEMP_LSB:
+	case BMP280_REG_TEMP_MSB:
+	case BMP280_REG_PRESS_XLSB:
+	case BMP280_REG_PRESS_LSB:
+	case BMP280_REG_PRESS_MSB:
+	case BMP280_REG_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
 static bool bmp380_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -167,7 +194,7 @@ const struct regmap_config bmp280_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-	.max_register = BMP280_REG_HUMIDITY_LSB,
+	.max_register = BMP280_REG_TEMP_XLSB,
 	.cache_type = REGCACHE_RBTREE,
 
 	.writeable_reg = bmp280_is_writeable_reg,
@@ -175,6 +202,18 @@ const struct regmap_config bmp280_regmap_config = {
 };
 EXPORT_SYMBOL_NS(bmp280_regmap_config, IIO_BMP280);
 
+const struct regmap_config bme280_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BME280_REG_HUMIDITY_LSB,
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = bme280_is_writeable_reg,
+	.volatile_reg = bme280_is_volatile_reg,
+};
+EXPORT_SYMBOL_NS(bme280_regmap_config, IIO_BMP280);
+
 const struct regmap_config bmp380_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 4e19ea0b4d39..62b4e58104cf 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -13,7 +13,7 @@
 #include "bmp280.h"
 
 static int bmp280_regmap_spi_write(void *context, const void *data,
-                                   size_t count)
+				   size_t count)
 {
 	struct spi_device *spi = to_spi_device(context);
 	u8 buf[2];
@@ -29,7 +29,7 @@ static int bmp280_regmap_spi_write(void *context, const void *data,
 }
 
 static int bmp280_regmap_spi_read(void *context, const void *reg,
-                                  size_t reg_size, void *val, size_t val_size)
+				  size_t reg_size, void *val, size_t val_size)
 {
 	struct spi_device *spi = to_spi_device(context);
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 5812a344ed8e..a651cb800993 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -192,8 +192,6 @@
 #define BMP380_PRESS_SKIPPED		0x800000
 
 /* BMP280 specific registers */
-#define BMP280_REG_HUMIDITY_LSB		0xFE
-#define BMP280_REG_HUMIDITY_MSB		0xFD
 #define BMP280_REG_TEMP_XLSB		0xFC
 #define BMP280_REG_TEMP_LSB		0xFB
 #define BMP280_REG_TEMP_MSB		0xFA
@@ -207,15 +205,6 @@
 #define BMP280_REG_CONFIG		0xF5
 #define BMP280_REG_CTRL_MEAS		0xF4
 #define BMP280_REG_STATUS		0xF3
-#define BMP280_REG_CTRL_HUMIDITY	0xF2
-
-/* Due to non linear mapping, and data sizes we can't do a bulk read */
-#define BMP280_REG_COMP_H1		0xA1
-#define BMP280_REG_COMP_H2		0xE1
-#define BMP280_REG_COMP_H3		0xE3
-#define BMP280_REG_COMP_H4		0xE4
-#define BMP280_REG_COMP_H5		0xE5
-#define BMP280_REG_COMP_H6		0xE7
 
 #define BMP280_REG_COMP_TEMP_START	0x88
 #define BMP280_COMP_TEMP_REG_COUNT	6
@@ -223,8 +212,6 @@
 #define BMP280_REG_COMP_PRESS_START	0x8E
 #define BMP280_COMP_PRESS_REG_COUNT	18
 
-#define BMP280_COMP_H5_MASK		GENMASK(15, 4)
-
 #define BMP280_CONTIGUOUS_CALIB_REGS	(BMP280_COMP_TEMP_REG_COUNT + \
 					 BMP280_COMP_PRESS_REG_COUNT)
 
@@ -235,14 +222,6 @@
 #define BMP280_FILTER_8X		3
 #define BMP280_FILTER_16X		4
 
-#define BMP280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
-#define BMP280_OSRS_HUMIDITY_SKIP	0
-#define BMP280_OSRS_HUMIDITY_1X		1
-#define BMP280_OSRS_HUMIDITY_2X		2
-#define BMP280_OSRS_HUMIDITY_4X		3
-#define BMP280_OSRS_HUMIDITY_8X		4
-#define BMP280_OSRS_HUMIDITY_16X	5
-
 #define BMP280_OSRS_TEMP_MASK		GENMASK(7, 5)
 #define BMP280_OSRS_TEMP_SKIP		0
 #define BMP280_OSRS_TEMP_1X		1
@@ -264,6 +243,30 @@
 #define BMP280_MODE_FORCED		1
 #define BMP280_MODE_NORMAL		3
 
+/* BME280 specific registers */
+#define BME280_REG_HUMIDITY_LSB		0xFE
+#define BME280_REG_HUMIDITY_MSB		0xFD
+
+#define BME280_REG_CTRL_HUMIDITY	0xF2
+
+/* Due to non linear mapping, and data sizes we can't do a bulk read */
+#define BME280_REG_COMP_H1		0xA1
+#define BME280_REG_COMP_H2		0xE1
+#define BME280_REG_COMP_H3		0xE3
+#define BME280_REG_COMP_H4		0xE4
+#define BME280_REG_COMP_H5		0xE5
+#define BME280_REG_COMP_H6		0xE7
+
+#define BME280_COMP_H5_MASK		GENMASK(15, 4)
+
+#define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
+#define BME280_OSRS_HUMIDITY_SKIP	0
+#define BME280_OSRS_HUMIDITY_1X		1
+#define BME280_OSRS_HUMIDITY_2X		2
+#define BME280_OSRS_HUMIDITY_4X		3
+#define BME280_OSRS_HUMIDITY_8X		4
+#define BME280_OSRS_HUMIDITY_16X	5
+
 /* BMP180 specific registers */
 #define BMP180_REG_OUT_XLSB		0xF8
 #define BMP180_REG_OUT_LSB		0xF7
@@ -467,6 +470,7 @@ extern const struct bmp280_chip_info bmp580_chip_info;
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
+extern const struct regmap_config bme280_regmap_config;
 extern const struct regmap_config bmp380_regmap_config;
 extern const struct regmap_config bmp580_regmap_config;
 
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 2a411357640e..f2a2ce800443 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -383,7 +383,7 @@ static int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem
 
 	create_req->length = umem->length;
 	create_req->offset_in_page = ib_umem_dma_offset(umem, page_sz);
-	create_req->gdma_page_type = order_base_2(page_sz) - PAGE_SHIFT;
+	create_req->gdma_page_type = order_base_2(page_sz) - MANA_PAGE_SHIFT;
 	create_req->page_count = num_pages_total;
 
 	ibdev_dbg(&dev->ib_dev, "size_dma_region %lu num_pages_total %lu\n",
@@ -511,13 +511,13 @@ int mana_ib_mmap(struct ib_ucontext *ibcontext, struct vm_area_struct *vma)
 	      PAGE_SHIFT;
 	prot = pgprot_writecombine(vma->vm_page_prot);
 
-	ret = rdma_user_mmap_io(ibcontext, vma, pfn, gc->db_page_size, prot,
+	ret = rdma_user_mmap_io(ibcontext, vma, pfn, PAGE_SIZE, prot,
 				NULL);
 	if (ret)
 		ibdev_dbg(ibdev, "can't rdma_user_mmap_io ret %d\n", ret);
 	else
-		ibdev_dbg(ibdev, "mapped I/O pfn 0x%llx page_size %u, ret %d\n",
-			  pfn, gc->db_page_size, ret);
+		ibdev_dbg(ibdev, "mapped I/O pfn 0x%llx page_size %lu, ret %d\n",
+			  pfn, PAGE_SIZE, ret);
 
 	return ret;
 }
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index 8996e00cd63a..922d3ab998f3 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -391,10 +391,17 @@ static int adp5589_gpio_get_value(struct gpio_chip *chip, unsigned off)
 	struct adp5589_kpad *kpad = gpiochip_get_data(chip);
 	unsigned int bank = kpad->var->bank(kpad->gpiomap[off]);
 	unsigned int bit = kpad->var->bit(kpad->gpiomap[off]);
+	int val;
 
-	return !!(adp5589_read(kpad->client,
-			       kpad->var->reg(ADP5589_GPI_STATUS_A) + bank) &
-			       bit);
+	mutex_lock(&kpad->gpio_lock);
+	if (kpad->dir[bank] & bit)
+		val = kpad->dat_out[bank];
+	else
+		val = adp5589_read(kpad->client,
+				   kpad->var->reg(ADP5589_GPI_STATUS_A) + bank);
+	mutex_unlock(&kpad->gpio_lock);
+
+	return !!(val & bit);
 }
 
 static void adp5589_gpio_set_value(struct gpio_chip *chip,
@@ -936,10 +943,9 @@ static int adp5589_keypad_add(struct adp5589_kpad *kpad, unsigned int revid)
 
 static void adp5589_clear_config(void *data)
 {
-	struct i2c_client *client = data;
-	struct adp5589_kpad *kpad = i2c_get_clientdata(client);
+	struct adp5589_kpad *kpad = data;
 
-	adp5589_write(client, kpad->var->reg(ADP5589_GENERAL_CFG), 0);
+	adp5589_write(kpad->client, kpad->var->reg(ADP5589_GENERAL_CFG), 0);
 }
 
 static int adp5589_probe(struct i2c_client *client)
@@ -983,7 +989,7 @@ static int adp5589_probe(struct i2c_client *client)
 	}
 
 	error = devm_add_action_or_reset(&client->dev, adp5589_clear_config,
-					 client);
+					 kpad);
 	if (error)
 		return error;
 
@@ -1010,8 +1016,6 @@ static int adp5589_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
-	i2c_set_clientdata(client, kpad);
-
 	dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f456bcf1890b..a5425519fecb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1000,7 +1000,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
-				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R);
+				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2S |
+				    STRTAB_STE_2_S2R);
 		used_bits[3] |= cpu_to_le64(STRTAB_STE_3_S2TTB_MASK);
 	}
 
@@ -1172,8 +1173,8 @@ static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
 {
 	size_t size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
 
-	l1_desc->l2ptr = dmam_alloc_coherent(smmu->dev, size,
-					     &l1_desc->l2ptr_dma, GFP_KERNEL);
+	l1_desc->l2ptr = dma_alloc_coherent(smmu->dev, size,
+					    &l1_desc->l2ptr_dma, GFP_KERNEL);
 	if (!l1_desc->l2ptr) {
 		dev_warn(smmu->dev,
 			 "failed to allocate context descriptor table\n");
@@ -1372,17 +1373,17 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 		cd_table->num_l1_ents = DIV_ROUND_UP(max_contexts,
 						  CTXDESC_L2_ENTRIES);
 
-		cd_table->l1_desc = devm_kcalloc(smmu->dev, cd_table->num_l1_ents,
-					      sizeof(*cd_table->l1_desc),
-					      GFP_KERNEL);
+		cd_table->l1_desc = kcalloc(cd_table->num_l1_ents,
+					    sizeof(*cd_table->l1_desc),
+					    GFP_KERNEL);
 		if (!cd_table->l1_desc)
 			return -ENOMEM;
 
 		l1size = cd_table->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	}
 
-	cd_table->cdtab = dmam_alloc_coherent(smmu->dev, l1size, &cd_table->cdtab_dma,
-					   GFP_KERNEL);
+	cd_table->cdtab = dma_alloc_coherent(smmu->dev, l1size,
+					     &cd_table->cdtab_dma, GFP_KERNEL);
 	if (!cd_table->cdtab) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
 		ret = -ENOMEM;
@@ -1393,7 +1394,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 
 err_free_l1:
 	if (cd_table->l1_desc) {
-		devm_kfree(smmu->dev, cd_table->l1_desc);
+		kfree(cd_table->l1_desc);
 		cd_table->l1_desc = NULL;
 	}
 	return ret;
@@ -1413,21 +1414,18 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 			if (!cd_table->l1_desc[i].l2ptr)
 				continue;
 
-			dmam_free_coherent(smmu->dev, size,
-					   cd_table->l1_desc[i].l2ptr,
-					   cd_table->l1_desc[i].l2ptr_dma);
+			dma_free_coherent(smmu->dev, size,
+					  cd_table->l1_desc[i].l2ptr,
+					  cd_table->l1_desc[i].l2ptr_dma);
 		}
-		devm_kfree(smmu->dev, cd_table->l1_desc);
-		cd_table->l1_desc = NULL;
+		kfree(cd_table->l1_desc);
 
 		l1size = cd_table->num_l1_ents * (CTXDESC_L1_DESC_DWORDS << 3);
 	} else {
 		l1size = cd_table->num_l1_ents * (CTXDESC_CD_DWORDS << 3);
 	}
 
-	dmam_free_coherent(smmu->dev, l1size, cd_table->cdtab, cd_table->cdtab_dma);
-	cd_table->cdtab_dma = 0;
-	cd_table->cdtab = NULL;
+	dma_free_coherent(smmu->dev, l1size, cd_table->cdtab, cd_table->cdtab_dma);
 }
 
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd)
@@ -1629,6 +1627,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 		STRTAB_STE_2_S2ENDI |
 #endif
 		STRTAB_STE_2_S2PTW |
+		(master->stall_enabled ? STRTAB_STE_2_S2S : 0) |
 		STRTAB_STE_2_S2R);
 
 	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s2_cfg.vttbr &
@@ -1722,10 +1721,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
 
-	/* Stage-2 is always pinned at the moment */
-	if (evt[1] & EVTQ_1_S2)
-		return -EFAULT;
-
 	if (!(evt[1] & EVTQ_1_STALL))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1242a086c9f9..d9c2f763eaba 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -264,6 +264,7 @@ struct arm_smmu_ste {
 #define STRTAB_STE_2_S2AA64		(1UL << 51)
 #define STRTAB_STE_2_S2ENDI		(1UL << 52)
 #define STRTAB_STE_2_S2PTW		(1UL << 54)
+#define STRTAB_STE_2_S2S		(1UL << 57)
 #define STRTAB_STE_2_S2R		(1UL << 58)
 
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 1c8d3141cb55..01e157d89a16 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1204,9 +1204,7 @@ static void free_iommu(struct intel_iommu *iommu)
  */
 static inline void reclaim_free_desc(struct q_inval *qi)
 {
-	while (qi->desc_status[qi->free_tail] == QI_DONE ||
-	       qi->desc_status[qi->free_tail] == QI_ABORT) {
-		qi->desc_status[qi->free_tail] = QI_FREE;
+	while (qi->desc_status[qi->free_tail] == QI_FREE && qi->free_tail != qi->free_head) {
 		qi->free_tail = (qi->free_tail + 1) % QI_LENGTH;
 		qi->free_cnt++;
 	}
@@ -1463,8 +1461,16 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		raw_spin_lock(&qi->q_lock);
 	}
 
-	for (i = 0; i < count; i++)
-		qi->desc_status[(index + i) % QI_LENGTH] = QI_DONE;
+	/*
+	 * The reclaim code can free descriptors from multiple submissions
+	 * starting from the tail of the queue. When count == 0, the
+	 * status of the standalone wait descriptor at the tail of the queue
+	 * must be set to QI_FREE to allow the reclaim code to proceed.
+	 * It is also possible that descriptors from one of the previous
+	 * submissions has to be reclaimed by a subsequent submission.
+	 */
+	for (i = 0; i <= count; i++)
+		qi->desc_status[(index + i) % QI_LENGTH] = QI_FREE;
 
 	reclaim_free_desc(qi);
 	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e9bea0305c26..eed67326976d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1462,10 +1462,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 * entry for first-level or pass-through translation modes should
 	 * be programmed with a domain id different from those used for
 	 * second-level or nested translation. We reserve a domain id for
-	 * this purpose.
+	 * this purpose. This domain id is also used for identity domain
+	 * in legacy mode.
 	 */
-	if (sm_supported(iommu))
-		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
+	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index aabcdf756581..57dd3530f68d 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -261,9 +261,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	else
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
 /*
@@ -490,9 +488,7 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 
 	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 
 	return 0;
 }
@@ -569,9 +565,7 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
 	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
 /**
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 3b8842c4a340..8d4d1cbb1d4c 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -25,6 +25,7 @@ config ARM_MHU_V2
 
 config ARM_MHU_V3
 	tristate "ARM MHUv3 Mailbox"
+	depends on ARM64 || COMPILE_TEST
 	depends on HAS_IOMEM || COMPILE_TEST
 	depends on OF
 	help
diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
index fbfd0202047c..ea12fb8d2401 100644
--- a/drivers/mailbox/bcm2835-mailbox.c
+++ b/drivers/mailbox/bcm2835-mailbox.c
@@ -145,7 +145,8 @@ static int bcm2835_mbox_probe(struct platform_device *pdev)
 	spin_lock_init(&mbox->lock);
 
 	ret = devm_request_irq(dev, irq_of_parse_and_map(dev->of_node, 0),
-			       bcm2835_mbox_irq, 0, dev_name(dev), mbox);
+			       bcm2835_mbox_irq, IRQF_NO_SUSPEND, dev_name(dev),
+			       mbox);
 	if (ret) {
 		dev_err(dev, "Failed to register a mailbox IRQ handler: %d\n",
 			ret);
diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index 8ffad059e898..4d966cb2ed03 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -159,7 +159,7 @@ static const struct of_device_id rockchip_mbox_of_match[] = {
 	{ .compatible = "rockchip,rk3368-mailbox", .data = &rk3368_drv_data},
 	{ },
 };
-MODULE_DEVICE_TABLE(of, rockchp_mbox_of_match);
+MODULE_DEVICE_TABLE(of, rockchip_mbox_of_match);
 
 static int rockchip_mbox_probe(struct platform_device *pdev)
 {
diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 358f1fe42975..ceb713e49402 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2602,13 +2602,6 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	if (WARN_ON(q->supports_requests && q->min_queued_buffers))
 		return -EINVAL;
 
-	/*
-	 * The minimum requirement is 2: one buffer is used
-	 * by the hardware while the other is being processed by userspace.
-	 */
-	if (q->min_reqbufs_allocation < 2)
-		q->min_reqbufs_allocation = 2;
-
 	/*
 	 * If the driver needs 'min_queued_buffers' in the queue before
 	 * calling start_streaming() then the minimum requirement is
diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
index 09331cf95c62..d557f3b3de3d 100644
--- a/drivers/media/i2c/ar0521.c
+++ b/drivers/media/i2c/ar0521.c
@@ -844,7 +844,8 @@ static int ar0521_power_off(struct device *dev)
 	clk_disable_unprepare(sensor->extclk);
 
 	if (sensor->reset_gpio)
-		gpiod_set_value(sensor->reset_gpio, 1); /* assert RESET signal */
+		/* assert RESET signal */
+		gpiod_set_value_cansleep(sensor->reset_gpio, 1);
 
 	for (i = ARRAY_SIZE(ar0521_supply_names) - 1; i >= 0; i--) {
 		if (sensor->supplies[i])
@@ -878,7 +879,7 @@ static int ar0521_power_on(struct device *dev)
 
 	if (sensor->reset_gpio)
 		/* deassert RESET signal */
-		gpiod_set_value(sensor->reset_gpio, 0);
+		gpiod_set_value_cansleep(sensor->reset_gpio, 0);
 	usleep_range(4500, 5000); /* min 45000 clocks */
 
 	for (cnt = 0; cnt < ARRAY_SIZE(initial_regs); cnt++) {
diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 990d74214cc2..54a1de53d497 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -997,7 +997,7 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 
 	/* Request optional reset pin */
 	imx335->reset_gpio = devm_gpiod_get_optional(imx335->dev, "reset",
-						     GPIOD_OUT_LOW);
+						     GPIOD_OUT_HIGH);
 	if (IS_ERR(imx335->reset_gpio)) {
 		dev_err(imx335->dev, "failed to get reset gpio %ld\n",
 			PTR_ERR(imx335->reset_gpio));
@@ -1110,8 +1110,7 @@ static int imx335_power_on(struct device *dev)
 
 	usleep_range(500, 550); /* Tlow */
 
-	/* Set XCLR */
-	gpiod_set_value_cansleep(imx335->reset_gpio, 1);
+	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
 
 	ret = clk_prepare_enable(imx335->inclk);
 	if (ret) {
@@ -1124,7 +1123,7 @@ static int imx335_power_on(struct device *dev)
 	return 0;
 
 error_reset:
-	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
+	gpiod_set_value_cansleep(imx335->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(imx335_supply_name), imx335->supplies);
 
 	return ret;
@@ -1141,7 +1140,7 @@ static int imx335_power_off(struct device *dev)
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct imx335 *imx335 = to_imx335(sd);
 
-	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
+	gpiod_set_value_cansleep(imx335->reset_gpio, 1);
 	clk_disable_unprepare(imx335->inclk);
 	regulator_bulk_disable(ARRAY_SIZE(imx335_supply_name), imx335->supplies);
 
diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 3641911bc73f..5b5127f8953f 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -972,12 +972,10 @@ static int ov5675_set_stream(struct v4l2_subdev *sd, int enable)
 
 static int ov5675_power_off(struct device *dev)
 {
-	/* 512 xvclk cycles after the last SCCB transation or MIPI frame end */
-	u32 delay_us = DIV_ROUND_UP(512, OV5675_XVCLK_19_2 / 1000 / 1000);
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov5675 *ov5675 = to_ov5675(sd);
 
-	usleep_range(delay_us, delay_us * 2);
+	usleep_range(90, 100);
 
 	clk_disable_unprepare(ov5675->xvclk);
 	gpiod_set_value_cansleep(ov5675->reset_gpio, 1);
@@ -988,7 +986,6 @@ static int ov5675_power_off(struct device *dev)
 
 static int ov5675_power_on(struct device *dev)
 {
-	u32 delay_us = DIV_ROUND_UP(8192, OV5675_XVCLK_19_2 / 1000 / 1000);
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct ov5675 *ov5675 = to_ov5675(sd);
 	int ret;
@@ -1014,8 +1011,11 @@ static int ov5675_power_on(struct device *dev)
 
 	gpiod_set_value_cansleep(ov5675->reset_gpio, 0);
 
-	/* 8192 xvclk cycles prior to the first SCCB transation */
-	usleep_range(delay_us, delay_us * 2);
+	/* Worst case quiesence gap is 1.365 milliseconds @ 6MHz XVCLK
+	 * Add an additional threshold grace period to ensure reset
+	 * completion before initiating our first I2C transaction.
+	 */
+	usleep_range(1500, 1600);
 
 	return 0;
 }
diff --git a/drivers/media/platform/qcom/camss/camss-video.c b/drivers/media/platform/qcom/camss/camss-video.c
index 54cd82f74115..19202ce98700 100644
--- a/drivers/media/platform/qcom/camss/camss-video.c
+++ b/drivers/media/platform/qcom/camss/camss-video.c
@@ -557,12 +557,6 @@ static void video_stop_streaming(struct vb2_queue *q)
 
 		ret = v4l2_subdev_call(subdev, video, s_stream, 0);
 
-		if (entity->use_count > 1) {
-			/* Don't stop if other instances of the pipeline are still running */
-			dev_dbg(video->camss->dev, "Video pipeline still used, don't stop streaming.\n");
-			return;
-		}
-
 		if (ret) {
 			dev_err(video->camss->dev, "Video pipeline stop failed: %d\n", ret);
 			return;
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index c90a28fa8891..f80c895b6b95 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1985,6 +1985,8 @@ static int camss_probe(struct platform_device *pdev)
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
 
+	pm_runtime_enable(dev);
+
 	num_subdevs = camss_of_parse_ports(camss);
 	if (num_subdevs < 0) {
 		ret = num_subdevs;
@@ -2021,8 +2023,6 @@ static int camss_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_runtime_enable(dev);
-
 	return 0;
 
 err_register_subdevs:
@@ -2030,6 +2030,7 @@ static int camss_probe(struct platform_device *pdev)
 err_v4l2_device_unregister:
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
+	pm_runtime_disable(dev);
 err_genpd_cleanup:
 	camss_genpd_cleanup(camss);
 
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index ce206b709754..fd6cb85e1b1e 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -426,6 +426,7 @@ static void venus_remove(struct platform_device *pdev)
 	struct device *dev = core->dev;
 	int ret;
 
+	cancel_delayed_work_sync(&core->work);
 	ret = pm_runtime_get_sync(dev);
 	WARN_ON(ret < 0);
 
diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
index 097a3a08ef7d..dbb26c7b2f8d 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
@@ -39,6 +39,10 @@ static const struct media_entity_operations sun4i_csi_video_entity_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
 
+static const struct media_entity_operations sun4i_csi_subdev_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static int sun4i_csi_notify_bound(struct v4l2_async_notifier *notifier,
 				  struct v4l2_subdev *subdev,
 				  struct v4l2_async_connection *asd)
@@ -214,6 +218,7 @@ static int sun4i_csi_probe(struct platform_device *pdev)
 	subdev->internal_ops = &sun4i_csi_subdev_internal_ops;
 	subdev->flags = V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
 	subdev->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	subdev->entity.ops = &sun4i_csi_subdev_entity_ops;
 	subdev->owner = THIS_MODULE;
 	snprintf(subdev->name, sizeof(subdev->name), "sun4i-csi-0");
 	v4l2_set_subdevdata(subdev, csi);
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 57d9ae12fcfe..33d67d251719 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -35,11 +35,6 @@ struct tegra186_emc {
 	struct icc_provider provider;
 };
 
-static inline struct tegra186_emc *to_tegra186_emc(struct icc_provider *provider)
-{
-	return container_of(provider, struct tegra186_emc, provider);
-}
-
 /*
  * debugfs interface
  *
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index dfdc039d92a6..01aacdcda260 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -65,15 +65,6 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	if (!data)
 		return 0;
 
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_validate_bittiming(&bt, extack);
-		if (err)
-			return err;
-	}
-
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 		u32 tdc_flags = cm->flags & CAN_CTRLMODE_TDC_MASK;
@@ -114,6 +105,15 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
+	if (data[IFLA_CAN_BITTIMING]) {
+		struct can_bittiming bt;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
+		err = can_validate_bittiming(&bt, extack);
+		if (err)
+			return err;
+	}
+
 	if (is_can_fd) {
 		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
 			return -EOPNOTSUPP;
@@ -195,48 +195,6 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		/* Do not allow changing bittiming while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-
-		/* Calculate bittiming parameters based on
-		 * bittiming_const if set, otherwise pass bitrate
-		 * directly via do_set_bitrate(). Bail out if neither
-		 * is given.
-		 */
-		if (!priv->bittiming_const && !priv->do_set_bittiming &&
-		    !priv->bitrate_const)
-			return -EOPNOTSUPP;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_get_bittiming(dev, &bt,
-					priv->bittiming_const,
-					priv->bitrate_const,
-					priv->bitrate_const_cnt,
-					extack);
-		if (err)
-			return err;
-
-		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "arbitration bitrate %u bps surpasses transceiver capabilities of %u bps",
-					   bt.bitrate, priv->bitrate_max);
-			return -EINVAL;
-		}
-
-		memcpy(&priv->bittiming, &bt, sizeof(bt));
-
-		if (priv->do_set_bittiming) {
-			/* Finally, set the bit-timing registers */
-			err = priv->do_set_bittiming(dev);
-			if (err)
-				return err;
-		}
-	}
-
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm;
 		u32 ctrlstatic;
@@ -284,6 +242,48 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_TDC_MASK;
 	}
 
+	if (data[IFLA_CAN_BITTIMING]) {
+		struct can_bittiming bt;
+
+		/* Do not allow changing bittiming while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		/* Calculate bittiming parameters based on
+		 * bittiming_const if set, otherwise pass bitrate
+		 * directly via do_set_bitrate(). Bail out if neither
+		 * is given.
+		 */
+		if (!priv->bittiming_const && !priv->do_set_bittiming &&
+		    !priv->bitrate_const)
+			return -EOPNOTSUPP;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
+		err = can_get_bittiming(dev, &bt,
+					priv->bittiming_const,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt,
+					extack);
+		if (err)
+			return err;
+
+		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "arbitration bitrate %u bps surpasses transceiver capabilities of %u bps",
+					   bt.bitrate, priv->bitrate_max);
+			return -EINVAL;
+		}
+
+		memcpy(&priv->bittiming, &bt, sizeof(bt));
+
+		if (priv->do_set_bittiming) {
+			/* Finally, set the bit-timing registers */
+			err = priv->do_set_bittiming(dev);
+			if (err)
+				return err;
+		}
+	}
+
 	if (data[IFLA_CAN_RESTART_MS]) {
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index a2606ee3b0a5..cfc413caf93f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -266,7 +266,7 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 		const int rx_stat_cnt = ARRAY_SIZE(aq_ethtool_queue_rx_stat_names);
 		const int tx_stat_cnt = ARRAY_SIZE(aq_ethtool_queue_tx_stat_names);
 		char tc_string[8];
-		int tc;
+		unsigned int tc;
 
 		memset(tc_string, 0, sizeof(tc_string));
 		memcpy(p, aq_ethtool_stat_names,
@@ -275,7 +275,7 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 
 		for (tc = 0; tc < cfg->tcs; tc++) {
 			if (cfg->is_qos)
-				snprintf(tc_string, 8, "TC%d ", tc);
+				snprintf(tc_string, 8, "TC%u ", tc);
 
 			for (i = 0; i < cfg->vecs; i++) {
 				for (si = 0; si < rx_stat_cnt; si++) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 79c09c1cdf93..0032c4ebd7e1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4146,7 +4146,7 @@ static void bnxt_get_pkgver(struct net_device *dev)
 
 	if (!bnxt_get_pkginfo(dev, buf, sizeof(buf))) {
 		len = strlen(bp->fw_ver_str);
-		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len - 1,
+		snprintf(bp->fw_ver_str + len, FW_VER_STR_LEN - len,
 			 "/pkg %s", buf);
 	}
 }
diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index a19cb2a786fd..1cca0425d493 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -691,10 +691,19 @@ struct fec_enet_private {
 	/* XDP BPF Program */
 	struct bpf_prog *xdp_prog;
 
+	struct {
+		int pps_enable;
+		u64 ns_sys, ns_phc;
+		u32 at_corr;
+		u8 at_inc_corr;
+	} ptp_saved_state;
+
 	u64 ethtool_stats[];
 };
 
 void fec_ptp_init(struct platform_device *pdev, int irq_idx);
+void fec_ptp_restore_state(struct fec_enet_private *fep);
+void fec_ptp_save_state(struct fec_enet_private *fep);
 void fec_ptp_stop(struct platform_device *pdev);
 void fec_ptp_start_cyclecounter(struct net_device *ndev);
 int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fb19295529a2..8004f12352b6 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1077,6 +1077,8 @@ fec_restart(struct net_device *ndev)
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
 	u32 ecntl = FEC_ECR_ETHEREN;
 
+	fec_ptp_save_state(fep);
+
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
 	 * instead of reset MAC itself.
@@ -1244,8 +1246,10 @@ fec_restart(struct net_device *ndev)
 	writel(ecntl, fep->hwp + FEC_ECNTRL);
 	fec_enet_active_rxring(ndev);
 
-	if (fep->bufdesc_ex)
+	if (fep->bufdesc_ex) {
 		fec_ptp_start_cyclecounter(ndev);
+		fec_ptp_restore_state(fep);
+	}
 
 	/* Enable interrupts we wish to service */
 	if (fep->link)
@@ -1336,6 +1340,8 @@ fec_stop(struct net_device *ndev)
 			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
 	}
 
+	fec_ptp_save_state(fep);
+
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
 	 * instead of reset MAC itself.
@@ -1366,6 +1372,9 @@ fec_stop(struct net_device *ndev)
 		val = readl(fep->hwp + FEC_ECNTRL);
 		val |= FEC_ECR_EN1588;
 		writel(val, fep->hwp + FEC_ECNTRL);
+
+		fec_ptp_start_cyclecounter(ndev);
+		fec_ptp_restore_state(fep);
 	}
 }
 
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 2e4f3e1782a2..5e8fac50f945 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -770,6 +770,56 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	schedule_delayed_work(&fep->time_keep, HZ);
 }
 
+void fec_ptp_save_state(struct fec_enet_private *fep)
+{
+	unsigned long flags;
+	u32 atime_inc_corr;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+	fep->ptp_saved_state.pps_enable = fep->pps_enable;
+
+	fep->ptp_saved_state.ns_phc = timecounter_read(&fep->tc);
+	fep->ptp_saved_state.ns_sys = ktime_get_ns();
+
+	fep->ptp_saved_state.at_corr = readl(fep->hwp + FEC_ATIME_CORR);
+	atime_inc_corr = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_CORR_MASK;
+	fep->ptp_saved_state.at_inc_corr = (u8)(atime_inc_corr >> FEC_T_INC_CORR_OFFSET);
+
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+}
+
+/* Restore PTP functionality after a reset */
+void fec_ptp_restore_state(struct fec_enet_private *fep)
+{
+	u32 atime_inc = readl(fep->hwp + FEC_ATIME_INC) & FEC_T_INC_MASK;
+	unsigned long flags;
+	u32 counter;
+	u64 ns;
+
+	spin_lock_irqsave(&fep->tmreg_lock, flags);
+
+	/* Reset turned it off, so adjust our status flag */
+	fep->pps_enable = 0;
+
+	writel(fep->ptp_saved_state.at_corr, fep->hwp + FEC_ATIME_CORR);
+	atime_inc |= ((u32)fep->ptp_saved_state.at_inc_corr) << FEC_T_INC_CORR_OFFSET;
+	writel(atime_inc, fep->hwp + FEC_ATIME_INC);
+
+	ns = ktime_get_ns() - fep->ptp_saved_state.ns_sys + fep->ptp_saved_state.ns_phc;
+	counter = ns & fep->cc.mask;
+	writel(counter, fep->hwp + FEC_ATIME);
+	timecounter_init(&fep->tc, &fep->cc, ns);
+
+	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+
+	/* Restart PPS if needed */
+	if (fep->ptp_saved_state.pps_enable) {
+		/* Re-enable PPS */
+		fec_ptp_enable_pps(fep, 1);
+	}
+}
+
 void fec_ptp_stop(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index b91e7a06b97f..beb815e5289b 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -947,6 +947,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	priv->tx_coalesce_timer.function = tx_done;
 
 	priv->map = syscon_node_to_regmap(arg.np);
+	of_node_put(arg.np);
 	if (IS_ERR(priv->map)) {
 		dev_warn(d, "no syscon hisilicon,hip04-ppe\n");
 		ret = PTR_ERR(priv->map);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index f75668c47935..616a2768e504 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -933,6 +933,7 @@ static int hns_mac_get_info(struct hns_mac_cb *mac_cb)
 			mac_cb->cpld_ctrl = NULL;
 		} else {
 			syscon = syscon_node_to_regmap(cpld_args.np);
+			of_node_put(cpld_args.np);
 			if (IS_ERR_OR_NULL(syscon)) {
 				dev_dbg(mac_cb->dev, "no cpld-syscon found!\n");
 				mac_cb->cpld_ctrl = NULL;
diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index ed73707176c1..8a047145f0c5 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -575,6 +575,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
 						MDIO_SC_RESET_ST;
 				}
 			}
+			of_node_put(reg_args.np);
 		} else {
 			dev_warn(&pdev->dev, "find syscon ret = %#x\n", ret);
 			mdio_dev->subctrl_vbase = NULL;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3cd161c6672b..e23eedc791d6 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6671,8 +6671,10 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 		if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
 			/* enable wakeup by the PHY */
 			retval = e1000_init_phy_wakeup(adapter, wufc);
-			if (retval)
-				return retval;
+			if (retval) {
+				e_err("Failed to enable wakeup\n");
+				goto skip_phy_configurations;
+			}
 		} else {
 			/* enable wakeup by the MAC */
 			ew32(WUFC, wufc);
@@ -6693,8 +6695,10 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 			 * or broadcast.
 			 */
 			retval = e1000_enable_ulp_lpt_lp(hw, !runtime);
-			if (retval)
-				return retval;
+			if (retval) {
+				e_err("Failed to enable ULP\n");
+				goto skip_phy_configurations;
+			}
 		}
 	}
 
@@ -6726,6 +6730,7 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 		hw->phy.ops.release(hw);
 	}
 
+skip_phy_configurations:
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
 	 */
@@ -6968,15 +6973,13 @@ static int e1000e_pm_suspend(struct device *dev)
 	e1000e_pm_freeze(dev);
 
 	rc = __e1000_shutdown(pdev, false);
-	if (rc) {
-		e1000e_pm_thaw(dev);
-	} else {
+	if (!rc) {
 		/* Introduce S0ix implementation */
 		if (adapter->flags2 & FLAG2_ENABLE_S0IX_FLOWS)
 			e1000e_s0ix_entry_flow(adapter);
 	}
 
-	return rc;
+	return 0;
 }
 
 static int e1000e_pm_resume(struct device *dev)
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index ecf8f5d60292..6ca13c5dcb14 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -28,9 +28,8 @@ ice_sched_add_root_node(struct ice_port_info *pi,
 	if (!root)
 		return -ENOMEM;
 
-	/* coverity[suspicious_sizeof] */
 	root->children = devm_kcalloc(ice_hw_to_dev(hw), hw->max_children[0],
-				      sizeof(*root), GFP_KERNEL);
+				      sizeof(*root->children), GFP_KERNEL);
 	if (!root->children) {
 		devm_kfree(ice_hw_to_dev(hw), root);
 		return -ENOMEM;
@@ -186,10 +185,9 @@ ice_sched_add_node(struct ice_port_info *pi, u8 layer,
 	if (!node)
 		return -ENOMEM;
 	if (hw->max_children[layer]) {
-		/* coverity[suspicious_sizeof] */
 		node->children = devm_kcalloc(ice_hw_to_dev(hw),
 					      hw->max_children[layer],
-					      sizeof(*node), GFP_KERNEL);
+					      sizeof(*node->children), GFP_KERNEL);
 		if (!node->children) {
 			devm_kfree(ice_hw_to_dev(hw), node);
 			return -ENOMEM;
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 0b9982804370..57e3dabf3a80 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -482,7 +482,9 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	unsigned long flags;
 	u32 byte_offset;
 
-	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
+	if (skb_put_padto(skb, ETH_ZLEN))
+		return NETDEV_TX_OK;
+	len = skb->len;
 
 	if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) || ch->skb[ch->dma.desc]) {
 		netdev_err(dev, "tx ring full\n");
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index e809f91c08fb..9e02e4367bec 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1088,7 +1088,7 @@ struct mvpp2 {
 	unsigned int max_port_rxqs;
 
 	/* Workqueue to gather hardware statistics */
-	char queue_name[30];
+	char queue_name[31];
 	struct workqueue_struct *stats_queue;
 
 	/* Debugfs root entry */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index d4239e3b3c88..11f724ad90db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -23,6 +23,9 @@ struct mlx5e_tir_builder *mlx5e_tir_builder_alloc(bool modify)
 	struct mlx5e_tir_builder *builder;
 
 	builder = kvzalloc(sizeof(*builder), GFP_KERNEL);
+	if (!builder)
+		return NULL;
+
 	builder->modify = modify;
 
 	return builder;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 3d274599015b..ca92e518be76 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -67,7 +67,6 @@ static void mlx5e_ipsec_handle_sw_limits(struct work_struct *_work)
 		return;
 
 	spin_lock_bh(&x->lock);
-	xfrm_state_check_expire(x);
 	if (x->km.state == XFRM_STATE_EXPIRED) {
 		sa_entry->attrs.drop = true;
 		spin_unlock_bh(&x->lock);
@@ -75,6 +74,13 @@ static void mlx5e_ipsec_handle_sw_limits(struct work_struct *_work)
 		mlx5e_accel_ipsec_fs_modify(sa_entry);
 		return;
 	}
+
+	if (x->km.state != XFRM_STATE_VALID) {
+		spin_unlock_bh(&x->lock);
+		return;
+	}
+
+	xfrm_state_check_expire(x);
 	spin_unlock_bh(&x->lock);
 
 	queue_delayed_work(sa_entry->ipsec->wq, &dwork->dwork,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index b09e9abd39f3..f8c7912abe0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -642,7 +642,6 @@ mlx5e_sq_xmit_mpwqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	return;
 
 err_unmap:
-	mlx5e_dma_unmap_wqe_err(sq, 1);
 	sq->stats->dropped++;
 	dev_kfree_skb_any(skb);
 	mlx5e_tx_flush(sq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index d0b595ba6110..432c98f2626d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -24,6 +24,11 @@
 	pci_write_config_dword((dev)->pdev, (dev)->vsc_addr + (offset), (val))
 #define VSC_MAX_RETRIES 2048
 
+/* Reading VSC registers can take relatively long time.
+ * Yield the cpu every 128 registers read.
+ */
+#define VSC_GW_READ_BLOCK_COUNT 128
+
 enum {
 	VSC_CTRL_OFFSET = 0x4,
 	VSC_COUNTER_OFFSET = 0x8,
@@ -273,6 +278,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 {
 	unsigned int next_read_addr = 0;
 	unsigned int read_addr = 0;
+	unsigned int count = 0;
 
 	while (read_addr < length) {
 		if (mlx5_vsc_gw_read_fast(dev, read_addr, &next_read_addr,
@@ -280,6 +286,10 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
 			return read_addr;
 
 		read_addr = next_read_addr;
+		if (++count == VSC_GW_READ_BLOCK_COUNT) {
+			cond_resched();
+			count = 0;
+		}
 	}
 	return length;
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index f3f5fb420468..70427643f777 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -45,8 +45,12 @@ void sparx5_ifh_parse(u32 *ifh, struct frame_info *info)
 	fwd = (fwd >> 5);
 	info->src_port = FIELD_GET(GENMASK(7, 1), fwd);
 
+	/*
+	 * Bit 270-271 are occasionally unexpectedly set by the hardware,
+	 * clear bits before extracting timestamp
+	 */
 	info->timestamp =
-		((u64)xtr_hdr[2] << 24) |
+		((u64)(xtr_hdr[2] & GENMASK(5, 0)) << 24) |
 		((u64)xtr_hdr[3] << 16) |
 		((u64)xtr_hdr[4] <<  8) |
 		((u64)xtr_hdr[5] <<  0);
diff --git a/drivers/net/ethernet/microsoft/Kconfig b/drivers/net/ethernet/microsoft/Kconfig
index 286f0d5697a1..901fbffbf718 100644
--- a/drivers/net/ethernet/microsoft/Kconfig
+++ b/drivers/net/ethernet/microsoft/Kconfig
@@ -18,7 +18,7 @@ if NET_VENDOR_MICROSOFT
 config MICROSOFT_MANA
 	tristate "Microsoft Azure Network Adapter (MANA) support"
 	depends on PCI_MSI
-	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN && ARM64_4K_PAGES)
+	depends on X86_64 || (ARM64 && !CPU_BIG_ENDIAN)
 	depends on PCI_HYPERV
 	select AUXILIARY_BUS
 	select PAGE_POOL
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 1332db9a08eb..e1d70d21e207 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -182,7 +182,7 @@ int mana_gd_alloc_memory(struct gdma_context *gc, unsigned int length,
 	dma_addr_t dma_handle;
 	void *buf;
 
-	if (length < PAGE_SIZE || !is_power_of_2(length))
+	if (length < MANA_PAGE_SIZE || !is_power_of_2(length))
 		return -EINVAL;
 
 	gmi->dev = gc->dev;
@@ -717,7 +717,7 @@ EXPORT_SYMBOL_NS(mana_gd_destroy_dma_region, NET_MANA);
 static int mana_gd_create_dma_region(struct gdma_dev *gd,
 				     struct gdma_mem_info *gmi)
 {
-	unsigned int num_page = gmi->length / PAGE_SIZE;
+	unsigned int num_page = gmi->length / MANA_PAGE_SIZE;
 	struct gdma_create_dma_region_req *req = NULL;
 	struct gdma_create_dma_region_resp resp = {};
 	struct gdma_context *gc = gd->gdma_context;
@@ -727,10 +727,10 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 	int err;
 	int i;
 
-	if (length < PAGE_SIZE || !is_power_of_2(length))
+	if (length < MANA_PAGE_SIZE || !is_power_of_2(length))
 		return -EINVAL;
 
-	if (offset_in_page(gmi->virt_addr) != 0)
+	if (!MANA_PAGE_ALIGNED(gmi->virt_addr))
 		return -EINVAL;
 
 	hwc = gc->hwc.driver_data;
@@ -751,7 +751,7 @@ static int mana_gd_create_dma_region(struct gdma_dev *gd,
 	req->page_addr_list_len = num_page;
 
 	for (i = 0; i < num_page; i++)
-		req->page_addr_list[i] = gmi->dma_handle +  i * PAGE_SIZE;
+		req->page_addr_list[i] = gmi->dma_handle +  i * MANA_PAGE_SIZE;
 
 	err = mana_gd_send_request(gc, req_msg_size, req, sizeof(resp), &resp);
 	if (err)
diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 0a868679d342..a00f915c5188 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -368,12 +368,12 @@ static int mana_hwc_create_cq(struct hw_channel_context *hwc, u16 q_depth,
 	int err;
 
 	eq_size = roundup_pow_of_two(GDMA_EQE_SIZE * q_depth);
-	if (eq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		eq_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (eq_size < MANA_MIN_QSIZE)
+		eq_size = MANA_MIN_QSIZE;
 
 	cq_size = roundup_pow_of_two(GDMA_CQE_SIZE * q_depth);
-	if (cq_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		cq_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (cq_size < MANA_MIN_QSIZE)
+		cq_size = MANA_MIN_QSIZE;
 
 	hwc_cq = kzalloc(sizeof(*hwc_cq), GFP_KERNEL);
 	if (!hwc_cq)
@@ -435,7 +435,7 @@ static int mana_hwc_alloc_dma_buf(struct hw_channel_context *hwc, u16 q_depth,
 
 	dma_buf->num_reqs = q_depth;
 
-	buf_size = PAGE_ALIGN(q_depth * max_msg_size);
+	buf_size = MANA_PAGE_ALIGN(q_depth * max_msg_size);
 
 	gmi = &dma_buf->mem_info;
 	err = mana_gd_alloc_memory(gc, buf_size, gmi);
@@ -503,8 +503,8 @@ static int mana_hwc_create_wq(struct hw_channel_context *hwc,
 	else
 		queue_size = roundup_pow_of_two(GDMA_MAX_SQE_SIZE * q_depth);
 
-	if (queue_size < MINIMUM_SUPPORTED_PAGE_SIZE)
-		queue_size = MINIMUM_SUPPORTED_PAGE_SIZE;
+	if (queue_size < MANA_MIN_QSIZE)
+		queue_size = MANA_MIN_QSIZE;
 
 	hwc_wq = kzalloc(sizeof(*hwc_wq), GFP_KERNEL);
 	if (!hwc_wq)
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index bb77327bfa81..a637556dcfae 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1901,10 +1901,10 @@ static int mana_create_txq(struct mana_port_context *apc,
 	 *  to prevent overflow.
 	 */
 	txq_size = MAX_SEND_BUFFERS_PER_QUEUE * 32;
-	BUILD_BUG_ON(!PAGE_ALIGNED(txq_size));
+	BUILD_BUG_ON(!MANA_PAGE_ALIGNED(txq_size));
 
 	cq_size = MAX_SEND_BUFFERS_PER_QUEUE * COMP_ENTRY_SIZE;
-	cq_size = PAGE_ALIGN(cq_size);
+	cq_size = MANA_PAGE_ALIGN(cq_size);
 
 	gc = gd->gdma_context;
 
@@ -2203,8 +2203,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 	if (err)
 		goto out;
 
-	rq_size = PAGE_ALIGN(rq_size);
-	cq_size = PAGE_ALIGN(cq_size);
+	rq_size = MANA_PAGE_ALIGN(rq_size);
+	cq_size = MANA_PAGE_ALIGN(cq_size);
 
 	/* Create RQ */
 	memset(&spec, 0, sizeof(spec));
diff --git a/drivers/net/ethernet/microsoft/mana/shm_channel.c b/drivers/net/ethernet/microsoft/mana/shm_channel.c
index 5553af9c8085..0f1679ebad96 100644
--- a/drivers/net/ethernet/microsoft/mana/shm_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/shm_channel.c
@@ -6,6 +6,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 
+#include <net/mana/gdma.h>
 #include <net/mana/shm_channel.h>
 
 #define PAGE_FRAME_L48_WIDTH_BYTES 6
@@ -155,8 +156,8 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 		return err;
 	}
 
-	if (!PAGE_ALIGNED(eq_addr) || !PAGE_ALIGNED(cq_addr) ||
-	    !PAGE_ALIGNED(rq_addr) || !PAGE_ALIGNED(sq_addr))
+	if (!MANA_PAGE_ALIGNED(eq_addr) || !MANA_PAGE_ALIGNED(cq_addr) ||
+	    !MANA_PAGE_ALIGNED(rq_addr) || !MANA_PAGE_ALIGNED(sq_addr))
 		return -EINVAL;
 
 	if ((eq_msix_index & VECTOR_MASK) != eq_msix_index)
@@ -183,7 +184,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* EQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(eq_addr);
+	frame_addr = MANA_PFN(eq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -191,7 +192,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* CQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(cq_addr);
+	frame_addr = MANA_PFN(cq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -199,7 +200,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* RQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(rq_addr);
+	frame_addr = MANA_PFN(rq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
@@ -207,7 +208,7 @@ int mana_smc_setup_hwc(struct shm_channel *sc, bool reset_vf, u64 eq_addr,
 
 	/* SQ addr: low 48 bits of frame address */
 	shmem = (u64 *)ptr;
-	frame_addr = PHYS_PFN(sq_addr);
+	frame_addr = MANA_PFN(sq_addr);
 	*shmem = frame_addr & PAGE_FRAME_L48_MASK;
 	all_addr_h4bits |= (frame_addr >> PAGE_FRAME_L48_WIDTH_BITS) <<
 		(frame_addr_seq++ * PAGE_FRAME_H4_WIDTH_BITS);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 182ba0a8b095..6e0929af0f72 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -821,14 +821,13 @@ nfp_net_prepare_vector(struct nfp_net *nn, struct nfp_net_r_vector *r_vec,
 
 	snprintf(r_vec->name, sizeof(r_vec->name),
 		 "%s-rxtx-%d", nfp_net_name(nn), idx);
-	err = request_irq(r_vec->irq_vector, r_vec->handler, 0, r_vec->name,
-			  r_vec);
+	err = request_irq(r_vec->irq_vector, r_vec->handler, IRQF_NO_AUTOEN,
+			  r_vec->name, r_vec);
 	if (err) {
 		nfp_net_napi_del(&nn->dp, r_vec);
 		nn_err(nn, "Error requesting IRQ %d\n", r_vec->irq_vector);
 		return err;
 	}
-	disable_irq(r_vec->irq_vector);
 
 	irq_set_affinity_hint(r_vec->irq_vector, &r_vec->affinity_mask);
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b6e89fc5a4ae..f5396aafe9ab 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -576,7 +576,34 @@ struct rtl8169_counters {
 	__le64	rx_broadcast;
 	__le32	rx_multicast;
 	__le16	tx_aborted;
-	__le16	tx_underun;
+	__le16	tx_underrun;
+	/* new since RTL8125 */
+	__le64 tx_octets;
+	__le64 rx_octets;
+	__le64 rx_multicast64;
+	__le64 tx_unicast64;
+	__le64 tx_broadcast64;
+	__le64 tx_multicast64;
+	__le32 tx_pause_on;
+	__le32 tx_pause_off;
+	__le32 tx_pause_all;
+	__le32 tx_deferred;
+	__le32 tx_late_collision;
+	__le32 tx_all_collision;
+	__le32 tx_aborted32;
+	__le32 align_errors32;
+	__le32 rx_frame_too_long;
+	__le32 rx_runt;
+	__le32 rx_pause_on;
+	__le32 rx_pause_off;
+	__le32 rx_pause_all;
+	__le32 rx_unknown_opcode;
+	__le32 rx_mac_error;
+	__le32 tx_underrun32;
+	__le32 rx_mac_missed;
+	__le32 rx_tcam_dropped;
+	__le32 tdu;
+	__le32 rdu;
 };
 
 struct rtl8169_tc_offsets {
@@ -1841,7 +1868,7 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
 	data[9] = le64_to_cpu(counters->rx_broadcast);
 	data[10] = le32_to_cpu(counters->rx_multicast);
 	data[11] = le16_to_cpu(counters->tx_aborted);
-	data[12] = le16_to_cpu(counters->tx_underun);
+	data[12] = le16_to_cpu(counters->tx_underrun);
 }
 
 static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 8e2049ed6015..c79d70899493 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac4.h"
@@ -475,7 +476,7 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,
 				    u8 index, u32 data)
 {
 	void __iomem *ioaddr = (void __iomem *)dev->base_addr;
-	int i, timeout = 10;
+	int ret;
 	u32 val;
 
 	if (index >= hw->num_vlan)
@@ -491,16 +492,15 @@ static int dwmac4_write_vlan_filter(struct net_device *dev,
 
 	writel(val, ioaddr + GMAC_VLAN_TAG);
 
-	for (i = 0; i < timeout; i++) {
-		val = readl(ioaddr + GMAC_VLAN_TAG);
-		if (!(val & GMAC_VLAN_TAG_CTRL_OB))
-			return 0;
-		udelay(1);
+	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
+				 !(val & GMAC_VLAN_TAG_CTRL_OB),
+				 1000, 500000);
+	if (ret) {
+		netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
+		return -EBUSY;
 	}
 
-	netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
-
-	return -EBUSY;
+	return 0;
 }
 
 static int dwmac4_add_hw_vlan_rx_fltr(struct net_device *dev,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 996f2bcd07a2..308ef4241768 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -396,6 +396,7 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
 			return ret;
 
 		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
+		return 0;
 	}
 
 	/* Final adjustments for HW */
diff --git a/drivers/net/ieee802154/Kconfig b/drivers/net/ieee802154/Kconfig
index 95da876c5613..1075e24b11de 100644
--- a/drivers/net/ieee802154/Kconfig
+++ b/drivers/net/ieee802154/Kconfig
@@ -101,6 +101,7 @@ config IEEE802154_CA8210_DEBUGFS
 
 config IEEE802154_MCR20A
 	tristate "MCR20A transceiver driver"
+	select REGMAP_SPI
 	depends on IEEE802154_DRIVERS && MAC802154
 	depends on SPI
 	help
diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 433fb5839203..020d392a98b6 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -1302,16 +1302,13 @@ mcr20a_probe(struct spi_device *spi)
 		irq_type = IRQF_TRIGGER_FALLING;
 
 	ret = devm_request_irq(&spi->dev, spi->irq, mcr20a_irq_isr,
-			       irq_type, dev_name(&spi->dev), lp);
+			       irq_type | IRQF_NO_AUTOEN, dev_name(&spi->dev), lp);
 	if (ret) {
 		dev_err(&spi->dev, "could not request_irq for mcr20a\n");
 		ret = -ENODEV;
 		goto free_dev;
 	}
 
-	/* disable_irq by default and wait for starting hardware */
-	disable_irq(spi->irq);
-
 	ret = ieee802154_register_hw(hw);
 	if (ret) {
 		dev_crit(&spi->dev, "ieee802154_register_hw failed\n");
diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
index 19c75886f070..5f5cd3596cb8 100644
--- a/drivers/net/pcs/pcs-xpcs-wx.c
+++ b/drivers/net/pcs/pcs-xpcs-wx.c
@@ -109,7 +109,7 @@ static void txgbe_pma_config_1g(struct dw_xpcs *xpcs)
 	txgbe_write_pma(xpcs, TXGBE_DFE_TAP_CTL0, 0);
 	val = txgbe_read_pma(xpcs, TXGBE_RX_GEN_CTL3);
 	val = u16_replace_bits(val, 0x4, TXGBE_RX_GEN_CTL3_LOS_TRSHLD0);
-	txgbe_write_pma(xpcs, TXGBE_RX_EQ_ATTN_CTL, val);
+	txgbe_write_pma(xpcs, TXGBE_RX_GEN_CTL3, val);
 
 	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL0, 0x20);
 	txgbe_write_pma(xpcs, TXGBE_MPLLA_CTL3, 0x46);
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index c4236564c1cd..8495b111a524 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -342,14 +342,19 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 		if (mdio_phy_id_is_c45(mii_data->phy_id)) {
 			prtad = mdio_phy_id_prtad(mii_data->phy_id);
 			devad = mdio_phy_id_devad(mii_data->phy_id);
-			mii_data->val_out = mdiobus_c45_read(
-				phydev->mdio.bus, prtad, devad,
-				mii_data->reg_num);
+			ret = mdiobus_c45_read(phydev->mdio.bus, prtad, devad,
+					       mii_data->reg_num);
+
 		} else {
-			mii_data->val_out = mdiobus_read(
-				phydev->mdio.bus, mii_data->phy_id,
-				mii_data->reg_num);
+			ret = mdiobus_read(phydev->mdio.bus, mii_data->phy_id,
+					   mii_data->reg_num);
 		}
+
+		if (ret < 0)
+			return ret;
+
+		mii_data->val_out = ret;
+
 		return 0;
 
 	case SIOCSMIIREG:
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index eb9acfcaeb09..9d2656afba66 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2269,7 +2269,7 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 	if (!pchb)
 		goto out_rcu;
 
-	spin_lock(&pchb->downl);
+	spin_lock_bh(&pchb->downl);
 	if (!pchb->chan) {
 		/* channel got unregistered */
 		kfree_skb(skb);
@@ -2281,7 +2281,7 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 		kfree_skb(skb);
 
 outl:
-	spin_unlock(&pchb->downl);
+	spin_unlock_bh(&pchb->downl);
 out_rcu:
 	rcu_read_unlock();
 
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 3a252ac5dd28..159841a5c3ab 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -628,7 +628,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
 		eth_zero_addr(eth->h_dest);
 		eth->h_proto = skb->protocol;
 
+		rcu_read_lock_bh();
 		dev_queue_xmit_nit(skb, vrf_dev);
+		rcu_read_unlock_bh();
 
 		skb_pull(skb, ETH_HLEN);
 	}
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index aabde24d8763..88c7a7289d06 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2697,7 +2697,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 		if (unlikely(push_reason !=
 			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
+			ab->soc_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 3cdc4c51d6df..f8767496fa54 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2702,7 +2702,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
 		if (push_reason !=
 		    HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION) {
 			dev_kfree_skb_any(msdu);
-			ab->soc_stats.hal_reo_error[dp->reo_dst_ring[ring_id].ring_id]++;
+			ab->soc_stats.hal_reo_error[ring_id]++;
 			continue;
 		}
 
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index bf3da631c69f..51abc470125b 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1325,11 +1325,11 @@ void ath9k_get_et_stats(struct ieee80211_hw *hw,
 	struct ath_softc *sc = hw->priv;
 	int i = 0;
 
-	data[i++] = (sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_pkts_all +
+	data[i++] = ((u64)sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BK)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VI)].tx_pkts_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VO)].tx_pkts_all);
-	data[i++] = (sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_bytes_all +
+	data[i++] = ((u64)sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BE)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_BK)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VI)].tx_bytes_all +
 		     sc->debug.stats.txstats[PR_QNUM(IEEE80211_AC_VO)].tx_bytes_all);
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 0c7841f95228..a3733c9b484e 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -716,8 +716,7 @@ static void ath9k_hif_usb_rx_cb(struct urb *urb)
 	}
 
 resubmit:
-	skb_reset_tail_pointer(skb);
-	skb_trim(skb, 0);
+	__skb_set_length(skb, 0);
 
 	usb_anchor_urb(urb, &hif_dev->rx_submitted);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
@@ -754,8 +753,7 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
 	case -ESHUTDOWN:
 		goto free_skb;
 	default:
-		skb_reset_tail_pointer(skb);
-		skb_trim(skb, 0);
+		__skb_set_length(skb, 0);
 
 		goto resubmit;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index ba9e656037a2..9b3d3405fb83 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -356,6 +356,11 @@ int iwl_acpi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc)
 	}
 
 	mcc_val = wifi_pkg->package.elements[1].integer.value;
+	if (mcc_val != BIOS_MCC_CHINA) {
+		ret = -EINVAL;
+		IWL_DEBUG_RADIO(fwrt, "ACPI WRDD is supported only for CN\n");
+		goto out_free;
+	}
 
 	mcc[0] = (mcc_val >> 8) & 0xff;
 	mcc[1] = mcc_val & 0xff;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 6684506f4fc4..6cf237850ea0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -1132,6 +1132,19 @@ struct iwl_umac_scan_abort {
 	__le32 flags;
 } __packed; /* SCAN_ABORT_CMD_UMAC_API_S_VER_1 */
 
+/**
+ * enum iwl_umac_scan_abort_status
+ *
+ * @IWL_UMAC_SCAN_ABORT_STATUS_SUCCESS: scan was successfully aborted
+ * @IWL_UMAC_SCAN_ABORT_STATUS_IN_PROGRESS: scan abort is in progress
+ * @IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND: nothing to abort
+ */
+enum iwl_umac_scan_abort_status {
+	IWL_UMAC_SCAN_ABORT_STATUS_SUCCESS = 0,
+	IWL_UMAC_SCAN_ABORT_STATUS_IN_PROGRESS,
+	IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND,
+};
+
 /**
  * struct iwl_umac_scan_complete
  * @uid: scan id, &enum iwl_umac_scan_uid_offsets
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 633c9ad9af84..ecf482647617 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -45,6 +45,8 @@
 #define IWL_WTAS_ENABLE_IEC_MSK	0x4
 #define IWL_WTAS_USA_UHB_MSK		BIT(16)
 
+#define BIOS_MCC_CHINA 0x434e
+
 /*
  * The profile for revision 2 is a superset of revision 1, which is in
  * turn a superset of revision 0.  So we can store all revisions
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index fb982d4fe851..2cf878f237ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -638,7 +638,7 @@ int iwl_uefi_get_mcc(struct iwl_fw_runtime *fwrt, char *mcc)
 		goto out;
 	}
 
-	if (data->mcc != UEFI_MCC_CHINA) {
+	if (data->mcc != BIOS_MCC_CHINA) {
 		ret = -EINVAL;
 		IWL_DEBUG_RADIO(fwrt, "UEFI WRDD is supported only for CN\n");
 		goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 1f8884ca8997..e0ef981cd8f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -149,8 +149,6 @@ struct uefi_cnv_var_splc {
 	u32 default_pwr_limit;
 } __packed;
 
-#define UEFI_MCC_CHINA 0x434e
-
 /* struct uefi_cnv_var_wrdd - WRDD table as defined in UEFI
  * @revision: the revision of the table
  * @mcc: country identifier as defined in ISO/IEC 3166-1 Alpha 2 code
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 83551d962a46..6673a4e467c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -834,20 +834,10 @@ void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 	if (ieee80211_is_mgmt(hdr->frame_control))
 		sta = NULL;
 
-	/* If there is no sta, and it's not offchannel - send through AP */
+	/* this shouldn't even happen: just drop */
 	if (!sta && info->control.vif->type == NL80211_IFTYPE_STATION &&
-	    !offchannel) {
-		struct iwl_mvm_vif *mvmvif =
-			iwl_mvm_vif_from_mac80211(info->control.vif);
-		u8 ap_sta_id = READ_ONCE(mvmvif->deflink.ap_sta_id);
-
-		if (ap_sta_id < mvm->fw->ucode_capa.num_stations) {
-			/* mac80211 holds rcu read lock */
-			sta = rcu_dereference(mvm->fw_id_to_mac_id[ap_sta_id]);
-			if (IS_ERR_OR_NULL(sta))
-				goto drop;
-		}
-	}
+	    !offchannel)
+		goto drop;
 
 	if (tmp_sta && !sta && link_id != IEEE80211_LINK_UNSPECIFIED &&
 	    !ieee80211_is_probe_resp(hdr->frame_control)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 8a38fc4b0b0f..455f5f417506 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -144,7 +144,7 @@ static void iwl_mvm_mld_update_sta_key(struct ieee80211_hw *hw,
 	if (sta != data->sta || key->link_id >= 0)
 		return;
 
-	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, sizeof(cmd), &cmd);
+	err = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
 
 	if (err)
 		data->err = err;
@@ -162,8 +162,8 @@ int iwl_mvm_mld_update_sta_keys(struct iwl_mvm *mvm,
 		.new_sta_mask = new_sta_mask,
 	};
 
-	ieee80211_iter_keys_rcu(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
-				&data);
+	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_mld_update_sta_key,
+			    &data);
 	return data.err;
 }
 
@@ -402,7 +402,7 @@ void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
 	if (!sec_key_ver)
 		return;
 
-	ieee80211_iter_keys_rcu(mvm->hw, vif,
-				iwl_mvm_sec_key_remove_ap_iter,
-				(void *)(uintptr_t)link_id);
+	ieee80211_iter_keys(mvm->hw, vif,
+			    iwl_mvm_sec_key_remove_ap_iter,
+			    (void *)(uintptr_t)link_id);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index d7c276237c74..d8a3d47f5c07 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3313,13 +3313,23 @@ void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
 		       mvm->scan_start);
 }
 
-static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
+static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type, bool *wait)
 {
-	struct iwl_umac_scan_abort cmd = {};
+	struct iwl_umac_scan_abort abort_cmd = {};
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
+		.len = { sizeof(abort_cmd), },
+		.data = { &abort_cmd, },
+		.flags = CMD_SEND_IN_RFKILL,
+	};
+
 	int uid, ret;
+	u32 status = IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND;
 
 	lockdep_assert_held(&mvm->mutex);
 
+	*wait = true;
+
 	/* We should always get a valid index here, because we already
 	 * checked that this type of scan was running in the generic
 	 * code.
@@ -3328,17 +3338,28 @@ static int iwl_mvm_umac_scan_abort(struct iwl_mvm *mvm, int type)
 	if (WARN_ON_ONCE(uid < 0))
 		return uid;
 
-	cmd.uid = cpu_to_le32(uid);
+	abort_cmd.uid = cpu_to_le32(uid);
 
 	IWL_DEBUG_SCAN(mvm, "Sending scan abort, uid %u\n", uid);
 
-	ret = iwl_mvm_send_cmd_pdu(mvm,
-				   WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_ABORT_UMAC),
-				   CMD_SEND_IN_RFKILL, sizeof(cmd), &cmd);
+	ret = iwl_mvm_send_cmd_status(mvm, &cmd, &status);
+
+	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d, status=%u\n", ret, status);
 	if (!ret)
 		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
 
-	IWL_DEBUG_SCAN(mvm, "Scan abort: ret=%d\n", ret);
+	/* Handle the case that the FW is no longer familiar with the scan that
+	 * is to be stopped. In such a case, it is expected that the scan
+	 * complete notification was already received but not yet processed.
+	 * In such a case, there is no need to wait for a scan complete
+	 * notification and the flow should continue similar to the case that
+	 * the scan was really aborted.
+	 */
+	if (status == IWL_UMAC_SCAN_ABORT_STATUS_NOT_FOUND) {
+		mvm->scan_uid_status[uid] = type << IWL_MVM_SCAN_STOPPING_SHIFT;
+		*wait = false;
+	}
+
 	return ret;
 }
 
@@ -3348,6 +3369,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 	static const u16 scan_done_notif[] = { SCAN_COMPLETE_UMAC,
 					      SCAN_OFFLOAD_COMPLETE, };
 	int ret;
+	bool wait = true;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -3359,7 +3381,7 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 	IWL_DEBUG_SCAN(mvm, "Preparing to stop scan, type %x\n", type);
 
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN))
-		ret = iwl_mvm_umac_scan_abort(mvm, type);
+		ret = iwl_mvm_umac_scan_abort(mvm, type, &wait);
 	else
 		ret = iwl_mvm_lmac_scan_abort(mvm);
 
@@ -3367,6 +3389,10 @@ static int iwl_mvm_scan_stop_wait(struct iwl_mvm *mvm, int type)
 		IWL_DEBUG_SCAN(mvm, "couldn't stop scan type %d\n", type);
 		iwl_remove_notification(&mvm->notif_wait, &wait_scan_done);
 		return ret;
+	} else if (!wait) {
+		IWL_DEBUG_SCAN(mvm, "no need to wait for scan type %d\n", type);
+		iwl_remove_notification(&mvm->notif_wait, &wait_scan_done);
+		return 0;
 	}
 
 	return iwl_wait_notification(&mvm->notif_wait, &wait_scan_done,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1d695ece93e9..51c12d70e8c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1195,6 +1195,9 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	bool is_ampdu = false;
 	int hdrlen;
 
+	if (WARN_ON_ONCE(!sta))
+		return -1;
+
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	fc = hdr->frame_control;
 	hdrlen = ieee80211_hdrlen(fc);
@@ -1202,9 +1205,6 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (IWL_MVM_NON_TRANSMITTING_AP && ieee80211_is_probe_resp(fc))
 		return -1;
 
-	if (WARN_ON_ONCE(!mvmsta))
-		return -1;
-
 	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
@@ -1335,7 +1335,7 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 		       struct ieee80211_sta *sta)
 {
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_sta *mvmsta;
 	struct ieee80211_tx_info info;
 	struct sk_buff_head mpdus_skbs;
 	struct ieee80211_vif *vif;
@@ -1344,9 +1344,11 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct sk_buff *orig_skb = skb;
 	const u8 *addr3;
 
-	if (WARN_ON_ONCE(!mvmsta))
+	if (WARN_ON_ONCE(!sta))
 		return -1;
 
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
 	if (WARN_ON_ONCE(mvmsta->deflink.sta_id == IWL_MVM_INVALID_STA))
 		return -1;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 3adc447b715f..5b072120e3f2 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -1587,7 +1587,7 @@ struct host_cmd_ds_802_11_scan_rsp {
 
 struct host_cmd_ds_802_11_scan_ext {
 	u32   reserved;
-	u8    tlv_buffer[1];
+	u8    tlv_buffer[];
 } __packed;
 
 struct mwifiex_ie_types_bss_mode {
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 0326b121747c..17ce84f5207e 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -2530,8 +2530,7 @@ int mwifiex_ret_802_11_scan_ext(struct mwifiex_private *priv,
 	ext_scan_resp = &resp->params.ext_scan;
 
 	tlv = (void *)ext_scan_resp->tlv_buffer;
-	buf_left = le16_to_cpu(resp->size) - (sizeof(*ext_scan_resp) + S_DS_GEN
-					      - 1);
+	buf_left = le16_to_cpu(resp->size) - (sizeof(*ext_scan_resp) + S_DS_GEN);
 
 	while (buf_left >= sizeof(struct mwifiex_ie_types_header)) {
 		type = le16_to_cpu(tlv->type);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 7bc3b4cd3592..6bef96e3d2a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -400,6 +400,7 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
 
 	hw->max_tx_fragments = 4;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 8008ce3fa6c7..387d47e9fcd3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1537,12 +1537,14 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		set_bit(MT76_RESET, &phy2->mt76->state);
 		cancel_delayed_work_sync(&phy2->mt76->mac_work);
 	}
+
+	mutex_lock(&dev->mt76.mutex);
+
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	mt76_for_each_q_rx(&dev->mt76, i)
 		napi_disable(&dev->mt76.napi[i]);
 	napi_disable(&dev->mt76.tx_napi);
 
-	mutex_lock(&dev->mt76.mutex);
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
 		mtk_wed_device_stop(&dev->mt76.mmio.wed);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index eea41b29f096..3b2dcb410e0f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1577,6 +1577,12 @@ mt7915_twt_teardown_request(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static int
+mt7915_set_frag_threshold(struct ieee80211_hw *hw, u32 val)
+{
+	return 0;
+}
+
 static int
 mt7915_set_radar_background(struct ieee80211_hw *hw,
 			    struct cfg80211_chan_def *chandef)
@@ -1707,6 +1713,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.sta_set_decap_offload = mt7915_sta_set_decap_offload,
 	.add_twt_setup = mt7915_mac_add_twt_setup,
 	.twt_teardown_request = mt7915_twt_teardown_request,
+	.set_frag_threshold = mt7915_set_frag_threshold,
 	CFG80211_TESTMODE_CMD(mt76_testmode_cmd)
 	CFG80211_TESTMODE_DUMP(mt76_testmode_dump)
 #ifdef CONFIG_MAC80211_DEBUGFS
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9599adf104b1..758249b20c22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -690,13 +690,17 @@ int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)params->sta->drv_priv;
 	struct mt7915_vif *mvif = msta->vif;
+	int ret;
 
+	mt76_worker_disable(&dev->mt76.tx_worker);
 	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
+	ret = mt76_connac_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
+				     MCU_EXT_CMD(STA_REC_UPDATE),
+				     enable, true);
+	mt76_worker_enable(&dev->mt76.tx_worker);
 
-	return mt76_connac_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
-				      MCU_EXT_CMD(STA_REC_UPDATE),
-				      enable, true);
+	return ret;
 }
 
 int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 22838ede03cd..02b0d698413b 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -12,6 +12,7 @@ if RTW88
 
 config RTW88_CORE
 	tristate
+	select WANT_DEV_COREDUMP
 
 config RTW88_PCI
 	tristate
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 112bdd95fc6e..504660ee3cba 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3888,16 +3888,22 @@ struct rtw89_txpwr_conf {
 	const void *data;
 };
 
+static inline bool rtw89_txpwr_entcpy(void *entry, const void *cursor, u8 size,
+				      const struct rtw89_txpwr_conf *conf)
+{
+	u8 valid_size = min(size, conf->ent_sz);
+
+	memcpy(entry, cursor, valid_size);
+	return true;
+}
+
 #define rtw89_txpwr_conf_valid(conf) (!!(conf)->data)
 
 #define rtw89_for_each_in_txpwr_conf(entry, cursor, conf) \
-	for (typecheck(const void *, cursor), (cursor) = (conf)->data, \
-	     memcpy(&(entry), cursor, \
-		    min_t(u8, sizeof(entry), (conf)->ent_sz)); \
+	for (typecheck(const void *, cursor), (cursor) = (conf)->data; \
 	     (cursor) < (conf)->data + (conf)->num_ents * (conf)->ent_sz; \
-	     (cursor) += (conf)->ent_sz, \
-	     memcpy(&(entry), cursor, \
-		    min_t(u8, sizeof(entry), (conf)->ent_sz)))
+	     (cursor) += (conf)->ent_sz) \
+		if (rtw89_txpwr_entcpy(&(entry), cursor, sizeof(entry), conf))
 
 struct rtw89_txpwr_byrate_data {
 	struct rtw89_txpwr_conf conf;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1ec97250e88e..4fae0bd566f6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -126,7 +126,9 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->rtwdev = rtwdev;
 	rtwvif->roc.state = RTW89_ROC_IDLE;
 	rtwvif->offchan = false;
-	list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif))
+		list_add_tail(&rtwvif->list, &rtwdev->rtwvifs_list);
+
 	INIT_WORK(&rtwvif->update_beacon_work, rtw89_core_update_beacon_work);
 	INIT_DELAYED_WORK(&rtwvif->roc.roc_work, rtw89_roc_work);
 	rtw89_leave_ps_mode(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a82b4c56a6f4..f7c6b019b5be 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -352,8 +352,8 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 		csi_mode = RTW89_RA_RPT_MODE_HT;
 		ra_mask |= ((u64)sta->deflink.ht_cap.mcs.rx_mask[3] << 48) |
 			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[2] << 36) |
-			   (sta->deflink.ht_cap.mcs.rx_mask[1] << 24) |
-			   (sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[1] << 24) |
+			   ((u64)sta->deflink.ht_cap.mcs.rx_mask[0] << 12);
 		high_rate_masks = rtw89_ra_mask_ht_rates;
 		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			stbc_en = 1;
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index e2ed4565025d..d4ee9078a4f4 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -14,6 +14,24 @@
 #define rtw89_for_each_rtwvif(rtwdev, rtwvif)				       \
 	list_for_each_entry(rtwvif, &(rtwdev)->rtwvifs_list, list)
 
+/* Before adding rtwvif to list, we need to check if it already exist, beacase
+ * in some case such as SER L2 happen during WoWLAN flow, calling reconfig
+ * twice cause the list to be added twice.
+ */
+static inline bool rtw89_rtwvif_in_list(struct rtw89_dev *rtwdev,
+					struct rtw89_vif *new)
+{
+	struct rtw89_vif *rtwvif;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		if (rtwvif == new)
+			return true;
+
+	return false;
+}
+
 /* The result of negative dividend and positive divisor is undefined, but it
  * should be one case of round-down or round-up. So, make it round-down if the
  * result is round-up.
diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index 26ca719fa0de..5dcb9a84a12e 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -823,17 +823,17 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, pc_ack_irq, NULL, bam_dmux_pc_ack_irq,
 					IRQF_ONESHOT, NULL, dmux);
 	if (ret)
-		return ret;
+		goto err_disable_pm;
 
 	ret = devm_request_threaded_irq(dev, dmux->pc_irq, NULL, bam_dmux_pc_irq,
 					IRQF_ONESHOT, NULL, dmux);
 	if (ret)
-		return ret;
+		goto err_disable_pm;
 
 	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
 				    &dmux->pc_state);
 	if (ret)
-		return ret;
+		goto err_disable_pm;
 
 	/* Check if remote finished initialization before us */
 	if (dmux->pc_state) {
@@ -844,6 +844,11 @@ static int bam_dmux_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_disable_pm:
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	return ret;
 }
 
 static void bam_dmux_remove(struct platform_device *pdev)
diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index ff96f22648ef..45ddce35f6d2 100644
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -95,7 +95,7 @@ static u32 xenvif_new_hash(struct xenvif *vif, const u8 *data,
 
 static void xenvif_flush_hash(struct xenvif *vif)
 {
-	struct xenvif_hash_cache_entry *entry;
+	struct xenvif_hash_cache_entry *entry, *n;
 	unsigned long flags;
 
 	if (xenvif_hash_cache_size == 0)
@@ -103,8 +103,7 @@ static void xenvif_flush_hash(struct xenvif *vif)
 
 	spin_lock_irqsave(&vif->hash.cache.lock, flags);
 
-	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link,
-				lockdep_is_held(&vif->hash.cache.lock)) {
+	list_for_each_entry_safe(entry, n, &vif->hash.cache.list, link) {
 		list_del_rcu(&entry->link);
 		vif->hash.cache.count--;
 		kfree_rcu(entry, rcu);
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 6f7e7a8fa5ae..ed5167f942d8 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -20,6 +20,28 @@ key_serial_t nvme_keyring_id(void)
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_id);
 
+static bool nvme_tls_psk_revoked(struct key *psk)
+{
+	return test_bit(KEY_FLAG_REVOKED, &psk->flags) ||
+		test_bit(KEY_FLAG_INVALIDATED, &psk->flags);
+}
+
+struct key *nvme_tls_key_lookup(key_serial_t key_id)
+{
+	struct key *key = key_lookup(key_id);
+
+	if (IS_ERR(key)) {
+		pr_err("key id %08x not found\n", key_id);
+		return key;
+	}
+	if (nvme_tls_psk_revoked(key)) {
+		pr_err("key id %08x revoked\n", key_id);
+		return ERR_PTR(-EKEYREVOKED);
+	}
+	return key;
+}
+EXPORT_SYMBOL_GPL(nvme_tls_key_lookup);
+
 static void nvme_tls_psk_describe(const struct key *key, struct seq_file *m)
 {
 	seq_puts(m, key->description);
@@ -36,14 +58,12 @@ static bool nvme_tls_psk_match(const struct key *key,
 		pr_debug("%s: no key description\n", __func__);
 		return false;
 	}
-	match_len = strlen(key->description);
-	pr_debug("%s: id %s len %zd\n", __func__, key->description, match_len);
-
 	if (!match_data->raw_data) {
 		pr_debug("%s: no match data\n", __func__);
 		return false;
 	}
 	match_id = match_data->raw_data;
+	match_len = strlen(match_id);
 	pr_debug("%s: match '%s' '%s' len %zd\n",
 		 __func__, match_id, key->description, match_len);
 	return !memcmp(key->description, match_id, match_len);
@@ -71,7 +91,7 @@ static struct key_type nvme_tls_psk_key_type = {
 
 static struct key *nvme_tls_psk_lookup(struct key *keyring,
 		const char *hostnqn, const char *subnqn,
-		int hmac, bool generated)
+		u8 hmac, u8 psk_ver, bool generated)
 {
 	char *identity;
 	size_t identity_len = (NVMF_NQN_SIZE) * 2 + 11;
@@ -82,8 +102,8 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	if (!identity)
 		return ERR_PTR(-ENOMEM);
 
-	snprintf(identity, identity_len, "NVMe0%c%02d %s %s",
-		 generated ? 'G' : 'R', hmac, hostnqn, subnqn);
+	snprintf(identity, identity_len, "NVMe%u%c%02u %s %s",
+		 psk_ver, generated ? 'G' : 'R', hmac, hostnqn, subnqn);
 
 	if (!keyring)
 		keyring = nvme_keyring;
@@ -107,21 +127,38 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 /*
  * NVMe PSK priority list
  *
- * 'Retained' PSKs (ie 'generated == false')
- * should be preferred to 'generated' PSKs,
- * and SHA-384 should be preferred to SHA-256.
+ * 'Retained' PSKs (ie 'generated == false') should be preferred to 'generated'
+ * PSKs, PSKs with hash (psk_ver 1) should be preferred to PSKs without hash
+ * (psk_ver 0), and SHA-384 should be preferred to SHA-256.
  */
 static struct nvme_tls_psk_priority_list {
 	bool generated;
+	u8 psk_ver;
 	enum nvme_tcp_tls_cipher cipher;
 } nvme_tls_psk_prio[] = {
 	{ .generated = false,
+	  .psk_ver = 1,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = false,
+	  .psk_ver = 1,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+	{ .generated = false,
+	  .psk_ver = 0,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
 	{ .generated = false,
+	  .psk_ver = 0,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+	{ .generated = true,
+	  .psk_ver = 1,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = true,
+	  .psk_ver = 1,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
 	{ .generated = true,
+	  .psk_ver = 0,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
 	{ .generated = true,
+	  .psk_ver = 0,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
 };
 
@@ -137,10 +174,11 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 
 	for (prio = 0; prio < ARRAY_SIZE(nvme_tls_psk_prio); prio++) {
 		bool generated = nvme_tls_psk_prio[prio].generated;
+		u8 ver = nvme_tls_psk_prio[prio].psk_ver;
 		enum nvme_tcp_tls_cipher cipher = nvme_tls_psk_prio[prio].cipher;
 
 		tls_key = nvme_tls_psk_lookup(keyring, hostnqn, subnqn,
-					      cipher, generated);
+					      cipher, ver, generated);
 		if (!IS_ERR(tls_key)) {
 			tls_key_id = tls_key->serial;
 			key_put(tls_key);
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index b309c8be720f..e6bb73c16887 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -42,6 +42,7 @@ config NVME_HWMON
 
 config NVME_FABRICS
 	select NVME_CORE
+	select NVME_KEYRING if NVME_TCP_TLS
 	tristate
 
 config NVME_RDMA
@@ -95,7 +96,6 @@ config NVME_TCP
 config NVME_TCP_TLS
 	bool "NVMe over Fabrics TCP TLS encryption support"
 	depends on NVME_TCP
-	select NVME_KEYRING
 	select NET_HANDSHAKE
 	select KEYS
 	help
@@ -110,6 +110,7 @@ config NVME_HOST_AUTH
 	bool "NVMe over Fabrics In-Band Authentication in host side"
 	depends on NVME_CORE
 	select NVME_AUTH
+	select NVME_KEYRING if NVME_TCP_TLS
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication in
 	  host side.
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5569cf4183b2..415ede9886c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4587,7 +4587,6 @@ static void nvme_free_ctrl(struct device *dev)
 
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
-	key_put(ctrl->tls_key);
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
 	cleanup_srcu_struct(&ctrl->srcu);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index b5a4b5fd573e..3e3db6a6524e 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -650,7 +650,7 @@ static struct key *nvmf_parse_key(int key_id)
 		return ERR_PTR(-EINVAL);
 	}
 
-	key = key_lookup(key_id);
+	key = nvme_tls_key_lookup(key_id);
 	if (IS_ERR(key))
 		pr_err("key id %08x not found\n", key_id);
 	else
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ff1769172778..cde1cb906dbf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -375,7 +375,7 @@ struct nvme_ctrl {
 	struct nvme_dhchap_key *ctrl_key;
 	u16 transaction;
 #endif
-	struct key *tls_key;
+	key_serial_t tls_pskid;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 3c55f7edd181..5b1dee8a66ef 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -671,9 +671,9 @@ static ssize_t tls_key_show(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	if (!ctrl->tls_key)
+	if (!ctrl->tls_pskid)
 		return 0;
-	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
+	return sysfs_emit(buf, "%08x", ctrl->tls_pskid);
 }
 static DEVICE_ATTR_RO(tls_key);
 #endif
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b5e4327fe83..8c79af3ed1f2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -165,6 +165,7 @@ struct nvme_tcp_queue {
 
 	bool			hdr_digest;
 	bool			data_digest;
+	bool			tls_enabled;
 	struct ahash_request	*rcv_hash;
 	struct ahash_request	*snd_hash;
 	__le32			exp_ddgst;
@@ -213,7 +214,21 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
-static inline bool nvme_tcp_tls(struct nvme_ctrl *ctrl)
+/*
+ * Check if the queue is TLS encrypted
+ */
+static inline bool nvme_tcp_queue_tls(struct nvme_tcp_queue *queue)
+{
+	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		return 0;
+
+	return queue->tls_enabled;
+}
+
+/*
+ * Check if TLS is configured for the controller.
+ */
+static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
 {
 	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
 		return 0;
@@ -368,7 +383,7 @@ static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
 
 static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
 {
-	return !nvme_tcp_tls(&queue->ctrl->ctrl) &&
+	return !nvme_tcp_queue_tls(queue) &&
 		nvme_tcp_queue_has_pending(queue);
 }
 
@@ -1427,7 +1442,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
-	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
+	if (nvme_tcp_queue_tls(queue)) {
 		msg.msg_control = cbuf;
 		msg.msg_controllen = sizeof(cbuf);
 	}
@@ -1439,7 +1454,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
-	if (nvme_tcp_tls(&queue->ctrl->ctrl)) {
+	if (nvme_tcp_queue_tls(queue)) {
 		ctype = tls_get_record_type(queue->sock->sk,
 					    (struct cmsghdr *)cbuf);
 		if (ctype != TLS_RECORD_TYPE_DATA) {
@@ -1581,13 +1596,16 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		goto out_complete;
 	}
 
-	tls_key = key_lookup(pskid);
+	tls_key = nvme_tls_key_lookup(pskid);
 	if (IS_ERR(tls_key)) {
 		dev_warn(ctrl->ctrl.device, "queue %d: Invalid key %x\n",
 			 qid, pskid);
 		queue->tls_err = -ENOKEY;
 	} else {
-		ctrl->ctrl.tls_key = tls_key;
+		queue->tls_enabled = true;
+		if (qid == 0)
+			ctrl->ctrl.tls_pskid = key_serial(tls_key);
+		key_put(tls_key);
 		queue->tls_err = 0;
 	}
 
@@ -1768,7 +1786,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	/* If PSKs are configured try to start TLS */
-	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && pskid) {
+	if (nvme_tcp_tls_configured(nctrl) && pskid) {
 		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
 		if (ret)
 			goto err_init_connect;
@@ -1829,6 +1847,8 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		__nvme_tcp_stop_queue(queue);
+	/* Stopping the queue will disable TLS */
+	queue->tls_enabled = false;
 	mutex_unlock(&queue->queue_lock);
 }
 
@@ -1925,16 +1945,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	int ret;
 	key_serial_t pskid = 0;
 
-	if (nvme_tcp_tls(ctrl)) {
+	if (nvme_tcp_tls_configured(ctrl)) {
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
-		else
+		else {
 			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
 						      ctrl->opts->host->nqn,
 						      ctrl->opts->subsysnqn);
-		if (!pskid) {
-			dev_err(ctrl->device, "no valid PSK found\n");
-			return -ENOKEY;
+			if (!pskid) {
+				dev_err(ctrl->device, "no valid PSK found\n");
+				return -ENOKEY;
+			}
 		}
 	}
 
@@ -1957,13 +1978,14 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
 
-	if (nvme_tcp_tls(ctrl) && !ctrl->tls_key) {
+	if (nvme_tcp_tls_configured(ctrl) && !ctrl->tls_pskid) {
 		dev_err(ctrl->device, "no PSK negotiated\n");
 		return -ENOKEY;
 	}
+
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_tcp_alloc_queue(ctrl, i,
-				key_serial(ctrl->tls_key));
+				ctrl->tls_pskid);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -2144,6 +2166,11 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_unquiesce_admin_queue(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
+	if (ctrl->tls_pskid) {
+		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
+			ctrl->tls_pskid);
+		ctrl->tls_pskid = 0;
+	}
 }
 
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
diff --git a/drivers/of/address.c b/drivers/of/address.c
index d669ce25b5f9..7e59283a4472 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -8,6 +8,7 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/sizes.h>
@@ -1061,7 +1062,11 @@ static int __of_address_to_resource(struct device_node *dev, int index, int bar_
 	if (of_mmio_is_nonposted(dev))
 		flags |= IORESOURCE_MEM_NONPOSTED;
 
+	if (overflows_type(taddr, r->start))
+		return -EOVERFLOW;
 	r->start = taddr;
+	if (overflows_type(taddr + size - 1, r->end))
+		return -EOVERFLOW;
 	r->end = taddr + size - 1;
 	r->flags = flags;
 	r->name = name ? name : dev->full_name;
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 8fd63100ba8f..36351ad6115e 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -357,8 +357,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	addr = of_get_property(device, "reg", &addr_len);
 
 	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
-	if (addr_len > (3 * sizeof(__be32)))
-		addr_len = 3 * sizeof(__be32);
+	if (addr_len > sizeof(addr_buf))
+		addr_len = sizeof(addr_buf);
 	if (addr)
 		memcpy(addr_buf, addr, addr_len);
 
@@ -716,8 +716,7 @@ struct irq_domain *of_msi_map_get_device_domain(struct device *dev, u32 id,
  * @np: device node for @dev
  * @token: bus type for this domain
  *
- * Parse the msi-parent property (both the simple and the complex
- * versions), and returns the corresponding MSI domain.
+ * Parse the msi-parent property and returns the corresponding MSI domain.
  *
  * Returns: the MSI domain for this device (or NULL on failure).
  */
@@ -725,33 +724,14 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 				     struct device_node *np,
 				     enum irq_domain_bus_token token)
 {
-	struct device_node *msi_np;
+	struct of_phandle_iterator it;
 	struct irq_domain *d;
+	int err;
 
-	/* Check for a single msi-parent property */
-	msi_np = of_parse_phandle(np, "msi-parent", 0);
-	if (msi_np && !of_property_read_bool(msi_np, "#msi-cells")) {
-		d = irq_find_matching_host(msi_np, token);
-		if (!d)
-			of_node_put(msi_np);
-		return d;
-	}
-
-	if (token == DOMAIN_BUS_PLATFORM_MSI) {
-		/* Check for the complex msi-parent version */
-		struct of_phandle_args args;
-		int index = 0;
-
-		while (!of_parse_phandle_with_args(np, "msi-parent",
-						   "#msi-cells",
-						   index, &args)) {
-			d = irq_find_matching_host(args.np, token);
-			if (d)
-				return d;
-
-			of_node_put(args.np);
-			index++;
-		}
+	of_for_each_phandle(&it, err, np, "msi-parent", "#msi-cells", 0) {
+		d = irq_find_matching_host(it.node, token);
+		if (d)
+			return d;
 	}
 
 	return NULL;
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9100d82bfabc..3569050f9cf3 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -41,7 +41,7 @@
 
 /*
  * Cache if the event is allowed to trace Context information.
- * This allows us to perform the check, i.e, perfmon_capable(),
+ * This allows us to perform the check, i.e, perf_allow_kernel(),
  * in the context of the event owner, once, during the event_init().
  */
 #define SPE_PMU_HW_FLAGS_CX			0x00001
@@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
 
 static void set_spe_event_has_cx(struct perf_event *event)
 {
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
 		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
 }
 
@@ -745,9 +745,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
-	if (!perfmon_capable() &&
-	    (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)))
-		return -EACCES;
+	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
+		return perf_allow_kernel(&event->attr);
 
 	return 0;
 }
diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 04487ad7fba0..93c8e0fdb589 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -22,13 +22,13 @@ static int pmu_legacy_ctr_get_idx(struct perf_event *event)
 	struct perf_event_attr *attr = &event->attr;
 
 	if (event->attr.type != PERF_TYPE_HARDWARE)
-		return -EOPNOTSUPP;
+		return -ENOENT;
 	if (attr->config == PERF_COUNT_HW_CPU_CYCLES)
 		return RISCV_PMU_LEGACY_CYCLE;
 	else if (attr->config == PERF_COUNT_HW_INSTRUCTIONS)
 		return RISCV_PMU_LEGACY_INSTRET;
 	else
-		return -EOPNOTSUPP;
+		return -ENOENT;
 }
 
 /* For legacy config & counter index are same */
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 765bda7924f7..1a8fd76f14b7 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -305,7 +305,7 @@ static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 			  ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
 	} else if (ret.error == SBI_ERR_NOT_SUPPORTED) {
 		/* This event cannot be monitored by any counter */
-		edata->event_idx = -EINVAL;
+		edata->event_idx = -ENOENT;
 	}
 }
 
@@ -539,7 +539,7 @@ static int pmu_sbi_event_map(struct perf_event *event, u64 *econfig)
 		}
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -ENOENT;
 		break;
 	}
 
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 4ed9c7fd2b62..9d18dfca6a67 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1774,6 +1774,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 
 	/* "event_list" sysfs to list events supported by the block */
 	attr = &pmc->block[blk_num].attr_event_list;
+	sysfs_attr_init(&attr->dev_attr.attr);
 	attr->dev_attr.attr.mode = 0444;
 	attr->dev_attr.show = mlxbf_pmc_event_list_show;
 	attr->nr = blk_num;
@@ -1787,6 +1788,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 	if (strstr(pmc->block_name[blk_num], "l3cache") ||
 	    ((pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE))) {
 		attr = &pmc->block[blk_num].attr_enable;
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_enable_show;
 		attr->dev_attr.store = mlxbf_pmc_enable_store;
@@ -1814,6 +1816,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 	/* "eventX" and "counterX" sysfs to program and read counter values */
 	for (j = 0; j < pmc->block[blk_num].counters; ++j) {
 		attr = &pmc->block[blk_num].attr_counter[j];
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_counter_show;
 		attr->dev_attr.store = mlxbf_pmc_counter_store;
@@ -1826,6 +1829,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 		attr = NULL;
 
 		attr = &pmc->block[blk_num].attr_event[j];
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_event_show;
 		attr->dev_attr.store = mlxbf_pmc_event_store;
@@ -1861,6 +1865,7 @@ static int mlxbf_pmc_init_perftype_reg(struct device *dev, unsigned int blk_num)
 	while (count > 0) {
 		--count;
 		attr = &pmc->block[blk_num].attr_event[count];
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_counter_show;
 		attr->dev_attr.store = mlxbf_pmc_counter_store;
diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 48870ca52b41..7cde5733b9ca 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -37,6 +37,14 @@ static const struct dmi_system_id fwbug_list[] = {
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
+	{
+		.ident = "ASUS TUF Gaming A14",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
+		},
+		.driver_data = &quirk_no_sps_bug,
+	},
 	{}
 };
 
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 713c0d1fa85f..857cc8697942 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -316,7 +316,9 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
 		return NULL;
 
-	pkg_id = topology_physical_package_id(cpu);
+	pkg_id = topology_logical_package_id(cpu);
+	if (pkg_id >= topology_max_packages())
+		return NULL;
 
 	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
 	if (bus_number < 0)
diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index e0bbd6a14a89..bd9f95404c7c 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -43,6 +43,8 @@ struct lenovo_ymc_private {
 };
 
 static const struct key_entry lenovo_ymc_keymap[] = {
+	/* Ignore the uninitialized state */
+	{ KE_IGNORE, 0x00 },
 	/* Laptop */
 	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
 	/* Tablet */
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index f74af0a689f2..0a39f68c641d 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -840,6 +840,21 @@ static const struct ts_dmi_data rwc_nanote_p8_data = {
 	.properties = rwc_nanote_p8_props,
 };
 
+static const struct property_entry rwc_nanote_next_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 5),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 5),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1785),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1145),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-rwc-nanote-next.fw"),
+	{ }
+};
+
+static const struct ts_dmi_data rwc_nanote_next_data = {
+	.acpi_name = "MSSL1680:00",
+	.properties = rwc_nanote_next_props,
+};
+
 static const struct property_entry schneider_sct101ctm_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1715),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
@@ -1589,6 +1604,17 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_SKU, "0001")
 		},
 	},
+	{
+		/* RWC NANOTE NEXT */
+		.driver_data = (void *)&rwc_nanote_next_data,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_BOARD_NAME, "To be filled by O.E.M."),
+			DMI_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+			/* Above matches are too generic, add bios-version match */
+			DMI_MATCH(DMI_BIOS_VERSION, "S8A70R100-V005"),
+		},
+	},
 	{
 		/* Schneider SCT101CTM */
 		.driver_data = (void *)&schneider_sct101ctm_data,
diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 919ef4471229..2d62715359d8 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -390,8 +390,9 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 	for (i = 0; i < pdev_count; i++) {
 		pdevs[i] = platform_device_register_full(&dev_info->pdev_info[i]);
 		if (IS_ERR(pdevs[i])) {
+			ret = PTR_ERR(pdevs[i]);
 			x86_android_tablet_remove(pdev);
-			return PTR_ERR(pdevs[i]);
+			return ret;
 		}
 	}
 
@@ -443,8 +444,9 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 								  PLATFORM_DEVID_AUTO,
 								  &pdata, sizeof(pdata));
 		if (IS_ERR(pdevs[pdev_count])) {
+			ret = PTR_ERR(pdevs[pdev_count]);
 			x86_android_tablet_remove(pdev);
-			return PTR_ERR(pdevs[pdev_count]);
+			return ret;
 		}
 		pdev_count++;
 	}
diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index eb0e55c69dfe..2549c348c882 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -670,7 +670,7 @@ static const struct software_node *ktd2026_node_group[] = {
  * is controlled by the "pwm_soc_lpss_2" PWM output.
  */
 #define XIAOMI_MIPAD2_LED_PERIOD_NS		19200
-#define XIAOMI_MIPAD2_LED_DEFAULT_DUTY		 6000 /* From Android kernel */
+#define XIAOMI_MIPAD2_LED_MAX_DUTY_NS		 6000 /* From Android kernel */
 
 static struct pwm_device *xiaomi_mipad2_led_pwm;
 
@@ -679,7 +679,7 @@ static int xiaomi_mipad2_brightness_set(struct led_classdev *led_cdev,
 {
 	struct pwm_state state = {
 		.period = XIAOMI_MIPAD2_LED_PERIOD_NS,
-		.duty_cycle = val,
+		.duty_cycle = XIAOMI_MIPAD2_LED_MAX_DUTY_NS * val / LED_FULL,
 		/* Always set PWM enabled to avoid the pin floating */
 		.enabled = true,
 	};
@@ -701,11 +701,11 @@ static int __init xiaomi_mipad2_init(struct device *dev)
 		return -ENOMEM;
 
 	led_cdev->name = "mipad2:white:touch-buttons-backlight";
-	led_cdev->max_brightness = XIAOMI_MIPAD2_LED_PERIOD_NS;
-	/* "input-events" trigger uses blink_brightness */
-	led_cdev->blink_brightness = XIAOMI_MIPAD2_LED_DEFAULT_DUTY;
+	led_cdev->max_brightness = LED_FULL;
 	led_cdev->default_trigger = "input-events";
 	led_cdev->brightness_set_blocking = xiaomi_mipad2_brightness_set;
+	/* Turn LED off during suspend */
+	led_cdev->flags = LED_CORE_SUSPENDRESUME;
 
 	ret = devm_led_classdev_register(dev, led_cdev);
 	if (ret)
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 0ab6008e863e..4134a8344d2d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1694,7 +1694,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	genpd_lock(genpd);
 
 	genpd_set_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
 	if (gd)
@@ -1703,6 +1702,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
 	genpd_unlock(genpd);
+	dev_pm_domain_set(dev, &genpd->domain);
  out:
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1759,12 +1759,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 		genpd->gd->max_off_time_changed = true;
 
 	genpd_clear_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
 
 	genpd_unlock(genpd);
 
+	dev_pm_domain_set(dev, NULL);
+
 	if (genpd->detach_dev)
 		genpd->detach_dev(genpd, dev);
 
diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 0f2944dc9355..a04713f191a1 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -62,9 +62,6 @@ static int brcmstb_restart_handler(struct notifier_block *this,
 		return NOTIFY_DONE;
 	}
 
-	while (1)
-		;
-
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index c97893d4c25e..6465b5e4a387 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -299,7 +299,8 @@ static const struct hwmon_channel_info * const power_supply_hwmon_info[] = {
 			   HWMON_T_INPUT     |
 			   HWMON_T_MAX       |
 			   HWMON_T_MIN       |
-			   HWMON_T_MIN_ALARM,
+			   HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM,
 
 			   HWMON_T_LABEL     |
 			   HWMON_T_INPUT     |
diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 39a47540c590..2992fd4eca64 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -194,6 +194,10 @@ static void k3_r5_rproc_mbox_callback(struct mbox_client *client, void *data)
 	const char *name = kproc->rproc->name;
 	u32 msg = omap_mbox_message(data);
 
+	/* Do not forward message from a detached core */
+	if (kproc->rproc->state == RPROC_DETACHED)
+		return;
+
 	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
 
 	switch (msg) {
@@ -229,6 +233,10 @@ static void k3_r5_rproc_kick(struct rproc *rproc, int vqid)
 	mbox_msg_t msg = (mbox_msg_t)vqid;
 	int ret;
 
+	/* Do not forward message to a detached core */
+	if (kproc->rproc->state == RPROC_DETACHED)
+		return;
+
 	/* send the index of the triggered virtqueue in the mailbox payload */
 	ret = mbox_send_message(kproc->mbox, (void *)msg);
 	if (ret < 0)
@@ -399,12 +407,9 @@ static int k3_r5_rproc_request_mbox(struct rproc *rproc)
 	client->knows_txdone = false;
 
 	kproc->mbox = mbox_request_channel(client, 0);
-	if (IS_ERR(kproc->mbox)) {
-		ret = -EBUSY;
-		dev_err(dev, "mbox_request_channel failed: %ld\n",
-			PTR_ERR(kproc->mbox));
-		return ret;
-	}
+	if (IS_ERR(kproc->mbox))
+		return dev_err_probe(dev, PTR_ERR(kproc->mbox),
+				     "mbox_request_channel failed\n");
 
 	/*
 	 * Ping the remote processor, this is only for sanity-sake for now;
@@ -464,8 +469,6 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 			ret);
 		return ret;
 	}
-	core->released_from_reset = true;
-	wake_up_interruptible(&cluster->core_transition);
 
 	/*
 	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
@@ -552,10 +555,6 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 	u32 boot_addr;
 	int ret;
 
-	ret = k3_r5_rproc_request_mbox(rproc);
-	if (ret)
-		return ret;
-
 	boot_addr = rproc->bootaddr;
 	/* TODO: add boot_addr sanity checking */
 	dev_dbg(dev, "booting R5F core using boot addr = 0x%x\n", boot_addr);
@@ -564,7 +563,7 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 	core = kproc->core;
 	ret = ti_sci_proc_set_config(core->tsp, boot_addr, 0, 0);
 	if (ret)
-		goto put_mbox;
+		return ret;
 
 	/* unhalt/run all applicable cores */
 	if (cluster->mode == CLUSTER_MODE_LOCKSTEP) {
@@ -580,13 +579,15 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
 			dev_err(dev, "%s: can not start core 1 before core 0\n",
 				__func__);
-			ret = -EPERM;
-			goto put_mbox;
+			return -EPERM;
 		}
 
 		ret = k3_r5_core_run(core);
 		if (ret)
-			goto put_mbox;
+			return ret;
+
+		core->released_from_reset = true;
+		wake_up_interruptible(&cluster->core_transition);
 	}
 
 	return 0;
@@ -596,8 +597,6 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 		if (k3_r5_core_halt(core))
 			dev_warn(core->dev, "core halt back failed\n");
 	}
-put_mbox:
-	mbox_free_channel(kproc->mbox);
 	return ret;
 }
 
@@ -658,8 +657,6 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 			goto out;
 	}
 
-	mbox_free_channel(kproc->mbox);
-
 	return 0;
 
 unroll_core_halt:
@@ -674,42 +671,22 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 /*
  * Attach to a running R5F remote processor (IPC-only mode)
  *
- * The R5F attach callback only needs to request the mailbox, the remote
- * processor is already booted, so there is no need to issue any TI-SCI
- * commands to boot the R5F cores in IPC-only mode. This callback is invoked
- * only in IPC-only mode.
+ * The R5F attach callback is a NOP. The remote processor is already booted, and
+ * all required resources have been acquired during probe routine, so there is
+ * no need to issue any TI-SCI commands to boot the R5F cores in IPC-only mode.
+ * This callback is invoked only in IPC-only mode and exists because
+ * rproc_validate() checks for its existence.
  */
-static int k3_r5_rproc_attach(struct rproc *rproc)
-{
-	struct k3_r5_rproc *kproc = rproc->priv;
-	struct device *dev = kproc->dev;
-	int ret;
-
-	ret = k3_r5_rproc_request_mbox(rproc);
-	if (ret)
-		return ret;
-
-	dev_info(dev, "R5F core initialized in IPC-only mode\n");
-	return 0;
-}
+static int k3_r5_rproc_attach(struct rproc *rproc) { return 0; }
 
 /*
  * Detach from a running R5F remote processor (IPC-only mode)
  *
- * The R5F detach callback performs the opposite operation to attach callback
- * and only needs to release the mailbox, the R5F cores are not stopped and
- * will be left in booted state in IPC-only mode. This callback is invoked
- * only in IPC-only mode.
+ * The R5F detach callback is a NOP. The R5F cores are not stopped and will be
+ * left in booted state in IPC-only mode. This callback is invoked only in
+ * IPC-only mode and exists for sanity sake.
  */
-static int k3_r5_rproc_detach(struct rproc *rproc)
-{
-	struct k3_r5_rproc *kproc = rproc->priv;
-	struct device *dev = kproc->dev;
-
-	mbox_free_channel(kproc->mbox);
-	dev_info(dev, "R5F core deinitialized in IPC-only mode\n");
-	return 0;
-}
+static int k3_r5_rproc_detach(struct rproc *rproc) { return 0; }
 
 /*
  * This function implements the .get_loaded_rsc_table() callback and is used
@@ -1278,6 +1255,10 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 		kproc->rproc = rproc;
 		core->rproc = rproc;
 
+		ret = k3_r5_rproc_request_mbox(rproc);
+		if (ret)
+			return ret;
+
 		ret = k3_r5_rproc_configure_mode(kproc);
 		if (ret < 0)
 			goto err_config;
@@ -1332,7 +1313,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 			dev_err(dev,
 				"Timed out waiting for %s core to power up!\n",
 				rproc->name);
-			return ret;
+			goto err_powerup;
 		}
 	}
 
@@ -1348,6 +1329,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 		}
 	}
 
+err_powerup:
 	rproc_del(rproc);
 err_add:
 	k3_r5_reserved_mem_exit(kproc);
@@ -1395,6 +1377,8 @@ static void k3_r5_cluster_rproc_exit(void *data)
 			}
 		}
 
+		mbox_free_channel(kproc->mbox);
+
 		rproc_del(rproc);
 
 		k3_r5_reserved_mem_exit(kproc);
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index f93bee96e362..993c0878fb66 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -368,6 +368,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
 		return ret;
 
 	rtc->gpbr = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
 	rtc->gpbr_offset = args.args[0];
 	if (IS_ERR(rtc->gpbr)) {
 		dev_err(&pdev->dev, "failed to retrieve gpbr regmap, aborting.\n");
diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 00e245173320..4fcb73b727aa 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -1807,8 +1807,11 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 				return;
 			case PHASE_MSGIN:
 				len = 1;
+				tmp = 0xff;
 				data = &tmp;
 				NCR5380_transfer_pio(instance, &phase, &len, &data, 0);
+				if (tmp == 0xff)
+					break;
 				ncmd->message = tmp;
 
 				switch (tmp) {
@@ -1996,6 +1999,7 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
 				break;
 			case PHASE_STATIN:
 				len = 1;
+				tmp = ncmd->status;
 				data = &tmp;
 				NCR5380_transfer_pio(instance, &phase, &len, &data, 0);
 				ncmd->status = tmp;
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 7d5a155073c6..9b66fa29fb05 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -2029,8 +2029,8 @@ struct aac_srb_reply
 };
 
 struct aac_srb_unit {
-	struct aac_srb		srb;
 	struct aac_srb_reply	srb_reply;
+	struct aac_srb		srb;
 };
 
 /*
diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 7c147d6ea8a8..e5a9c5a323f8 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -306,6 +306,14 @@ struct lpfc_stats {
 
 struct lpfc_hba;
 
+/* Data structure to keep withheld FLOGI_ACC information */
+struct lpfc_defer_flogi_acc {
+	bool flag;
+	u16 rx_id;
+	u16 ox_id;
+	struct lpfc_nodelist *ndlp;
+
+};
 
 #define LPFC_VMID_TIMER   300	/* timer interval in seconds */
 
@@ -1430,9 +1438,7 @@ struct lpfc_hba {
 	uint16_t vlan_id;
 	struct list_head fcf_conn_rec_list;
 
-	bool defer_flogi_acc_flag;
-	uint16_t defer_flogi_acc_rx_id;
-	uint16_t defer_flogi_acc_ox_id;
+	struct lpfc_defer_flogi_acc defer_flogi_acc;
 
 	spinlock_t ct_ev_lock; /* synchronize access to ct_ev_waiters */
 	struct list_head ct_ev_waiters;
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 445cb6c2e80f..9c8a6d2a2904 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -1390,7 +1390,7 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	phba->link_flag &= ~LS_EXTERNAL_LOOPBACK;
 
 	/* Check for a deferred FLOGI ACC condition */
-	if (phba->defer_flogi_acc_flag) {
+	if (phba->defer_flogi_acc.flag) {
 		/* lookup ndlp for received FLOGI */
 		ndlp = lpfc_findnode_did(vport, 0);
 		if (!ndlp)
@@ -1404,34 +1404,38 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 		if (phba->sli_rev == LPFC_SLI_REV4) {
 			bf_set(wqe_ctxt_tag,
 			       &defer_flogi_acc.wqe.xmit_els_rsp.wqe_com,
-			       phba->defer_flogi_acc_rx_id);
+			       phba->defer_flogi_acc.rx_id);
 			bf_set(wqe_rcvoxid,
 			       &defer_flogi_acc.wqe.xmit_els_rsp.wqe_com,
-			       phba->defer_flogi_acc_ox_id);
+			       phba->defer_flogi_acc.ox_id);
 		} else {
 			icmd = &defer_flogi_acc.iocb;
-			icmd->ulpContext = phba->defer_flogi_acc_rx_id;
+			icmd->ulpContext = phba->defer_flogi_acc.rx_id;
 			icmd->unsli3.rcvsli3.ox_id =
-				phba->defer_flogi_acc_ox_id;
+				phba->defer_flogi_acc.ox_id;
 		}
 
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "3354 Xmit deferred FLOGI ACC: rx_id: x%x,"
 				 " ox_id: x%x, hba_flag x%lx\n",
-				 phba->defer_flogi_acc_rx_id,
-				 phba->defer_flogi_acc_ox_id, phba->hba_flag);
+				 phba->defer_flogi_acc.rx_id,
+				 phba->defer_flogi_acc.ox_id, phba->hba_flag);
 
 		/* Send deferred FLOGI ACC */
 		lpfc_els_rsp_acc(vport, ELS_CMD_FLOGI, &defer_flogi_acc,
 				 ndlp, NULL);
 
-		phba->defer_flogi_acc_flag = false;
-		vport->fc_myDID = did;
+		phba->defer_flogi_acc.flag = false;
 
-		/* Decrement ndlp reference count to indicate the node can be
-		 * released when other references are removed.
+		/* Decrement the held ndlp that was incremented when the
+		 * deferred flogi acc flag was set.
 		 */
-		lpfc_nlp_put(ndlp);
+		if (phba->defer_flogi_acc.ndlp) {
+			lpfc_nlp_put(phba->defer_flogi_acc.ndlp);
+			phba->defer_flogi_acc.ndlp = NULL;
+		}
+
+		vport->fc_myDID = did;
 	}
 
 	return 0;
@@ -5240,9 +5244,10 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	/* ACC to LOGO completes to NPort <nlp_DID> */
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 			 "0109 ACC to LOGO completes to NPort x%x refcnt %d "
-			 "Data: x%x x%x x%x\n",
-			 ndlp->nlp_DID, kref_read(&ndlp->kref), ndlp->nlp_flag,
-			 ndlp->nlp_state, ndlp->nlp_rpi);
+			 "last els x%x Data: x%x x%x x%x\n",
+			 ndlp->nlp_DID, kref_read(&ndlp->kref),
+			 ndlp->nlp_last_elscmd, ndlp->nlp_flag, ndlp->nlp_state,
+			 ndlp->nlp_rpi);
 
 	/* This clause allows the LOGO ACC to complete and free resources
 	 * for the Fabric Domain Controller.  It does deliberately skip
@@ -5254,18 +5259,22 @@ lpfc_cmpl_els_logo_acc(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 		goto out;
 
 	if (ndlp->nlp_state == NLP_STE_NPR_NODE) {
-		/* If PLOGI is being retried, PLOGI completion will cleanup the
-		 * node. The NLP_NPR_2B_DISC flag needs to be retained to make
-		 * progress on nodes discovered from last RSCN.
-		 */
-		if ((ndlp->nlp_flag & NLP_DELAY_TMO) &&
-		    (ndlp->nlp_last_elscmd == ELS_CMD_PLOGI))
-			goto out;
-
 		if (ndlp->nlp_flag & NLP_RPI_REGISTERED)
 			lpfc_unreg_rpi(vport, ndlp);
 
+		/* If came from PRLO, then PRLO_ACC is done.
+		 * Start rediscovery now.
+		 */
+		if (ndlp->nlp_last_elscmd == ELS_CMD_PRLO) {
+			spin_lock_irq(&ndlp->lock);
+			ndlp->nlp_flag |= NLP_NPR_2B_DISC;
+			spin_unlock_irq(&ndlp->lock);
+			ndlp->nlp_prev_state = ndlp->nlp_state;
+			lpfc_nlp_set_state(vport, ndlp, NLP_STE_PLOGI_ISSUE);
+			lpfc_issue_els_plogi(vport, ndlp->nlp_DID, 0);
+		}
 	}
+
  out:
 	/*
 	 * The driver received a LOGO from the rport and has ACK'd it.
@@ -8454,9 +8463,9 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 
 	/* Defer ACC response until AFTER we issue a FLOGI */
 	if (!test_bit(HBA_FLOGI_ISSUED, &phba->hba_flag)) {
-		phba->defer_flogi_acc_rx_id = bf_get(wqe_ctxt_tag,
+		phba->defer_flogi_acc.rx_id = bf_get(wqe_ctxt_tag,
 						     &wqe->xmit_els_rsp.wqe_com);
-		phba->defer_flogi_acc_ox_id = bf_get(wqe_rcvoxid,
+		phba->defer_flogi_acc.ox_id = bf_get(wqe_rcvoxid,
 						     &wqe->xmit_els_rsp.wqe_com);
 
 		vport->fc_myDID = did;
@@ -8464,11 +8473,17 @@ lpfc_els_rcv_flogi(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 		lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
 				 "3344 Deferring FLOGI ACC: rx_id: x%x,"
 				 " ox_id: x%x, hba_flag x%lx\n",
-				 phba->defer_flogi_acc_rx_id,
-				 phba->defer_flogi_acc_ox_id, phba->hba_flag);
+				 phba->defer_flogi_acc.rx_id,
+				 phba->defer_flogi_acc.ox_id, phba->hba_flag);
 
-		phba->defer_flogi_acc_flag = true;
+		phba->defer_flogi_acc.flag = true;
 
+		/* This nlp_get is paired with nlp_puts that reset the
+		 * defer_flogi_acc.flag back to false.  We need to retain
+		 * a kref on the ndlp until the deferred FLOGI ACC is
+		 * processed or cancelled.
+		 */
+		phba->defer_flogi_acc.ndlp = lpfc_nlp_get(ndlp);
 		return 0;
 	}
 
@@ -10504,7 +10519,7 @@ lpfc_els_unsol_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 		lpfc_els_rcv_flogi(vport, elsiocb, ndlp);
 		/* retain node if our response is deferred */
-		if (phba->defer_flogi_acc_flag)
+		if (phba->defer_flogi_acc.flag)
 			break;
 		if (newnode)
 			lpfc_disc_state_machine(vport, ndlp, NULL,
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 13b08c85440f..e553fab869de 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -175,7 +175,8 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 			 ndlp->nlp_state, ndlp->fc4_xpt_flags);
 
 	/* Don't schedule a worker thread event if the vport is going down. */
-	if (test_bit(FC_UNLOADING, &vport->load_flag)) {
+	if (test_bit(FC_UNLOADING, &vport->load_flag) ||
+	    !test_bit(HBA_SETUP, &phba->hba_flag)) {
 		spin_lock_irqsave(&ndlp->lock, iflags);
 		ndlp->rport = NULL;
 
@@ -1246,7 +1247,14 @@ lpfc_linkdown(struct lpfc_hba *phba)
 	lpfc_scsi_dev_block(phba);
 	offline = pci_channel_offline(phba->pcidev);
 
-	phba->defer_flogi_acc_flag = false;
+	/* Decrement the held ndlp if there is a deferred flogi acc */
+	if (phba->defer_flogi_acc.flag) {
+		if (phba->defer_flogi_acc.ndlp) {
+			lpfc_nlp_put(phba->defer_flogi_acc.ndlp);
+			phba->defer_flogi_acc.ndlp = NULL;
+		}
+	}
+	phba->defer_flogi_acc.flag = false;
 
 	/* Clear external loopback plug detected flag */
 	phba->link_flag &= ~LS_EXTERNAL_LOOPBACK;
@@ -1368,7 +1376,7 @@ lpfc_linkup_port(struct lpfc_vport *vport)
 		(vport != phba->pport))
 		return;
 
-	if (phba->defer_flogi_acc_flag) {
+	if (phba->defer_flogi_acc.flag) {
 		clear_bit(FC_ABORT_DISCOVERY, &vport->fc_flag);
 		clear_bit(FC_RSCN_MODE, &vport->fc_flag);
 		clear_bit(FC_NLP_MORE, &vport->fc_flag);
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index f6a53446e57f..4574716c8764 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -2652,8 +2652,26 @@ lpfc_rcv_prlo_mapped_node(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 	/* flush the target */
 	lpfc_sli_abort_iocb(vport, ndlp->nlp_sid, 0, LPFC_CTX_TGT);
 
-	/* Treat like rcv logo */
-	lpfc_rcv_logo(vport, ndlp, cmdiocb, ELS_CMD_PRLO);
+	/* Send PRLO_ACC */
+	spin_lock_irq(&ndlp->lock);
+	ndlp->nlp_flag |= NLP_LOGO_ACC;
+	spin_unlock_irq(&ndlp->lock);
+	lpfc_els_rsp_acc(vport, ELS_CMD_PRLO, cmdiocb, ndlp, NULL);
+
+	/* Save ELS_CMD_PRLO as the last elscmd and then set to NPR.
+	 * lpfc_cmpl_els_logo_acc is expected to restart discovery.
+	 */
+	ndlp->nlp_last_elscmd = ELS_CMD_PRLO;
+	ndlp->nlp_prev_state = ndlp->nlp_state;
+
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE | LOG_ELS | LOG_DISCOVERY,
+			 "3422 DID x%06x nflag x%x lastels x%x ref cnt %u\n",
+			 ndlp->nlp_DID, ndlp->nlp_flag,
+			 ndlp->nlp_last_elscmd,
+			 kref_read(&ndlp->kref));
+
+	lpfc_nlp_set_state(vport, ndlp, NLP_STE_NPR_NODE);
+
 	return ndlp->nlp_state;
 }
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 9f0b59672e19..0eaede8275da 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5555,11 +5555,20 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 
 	iocb = &lpfc_cmd->cur_iocbq;
 	if (phba->sli_rev == LPFC_SLI_REV4) {
-		pring_s4 = phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring;
-		if (!pring_s4) {
+		/* if the io_wq & pring are gone, the port was reset. */
+		if (!phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq ||
+		    !phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring) {
+			lpfc_printf_vlog(vport, KERN_WARNING, LOG_FCP,
+					 "2877 SCSI Layer I/O Abort Request "
+					 "IO CMPL Status x%x ID %d LUN %llu "
+					 "HBA_SETUP %d\n", FAILED,
+					 cmnd->device->id,
+					 (u64)cmnd->device->lun,
+					 test_bit(HBA_SETUP, &phba->hba_flag));
 			ret = FAILED;
 			goto out_unlock_hba;
 		}
+		pring_s4 = phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring;
 		spin_lock(&pring_s4->ring_lock);
 	}
 	/* the command is in process of being cancelled */
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 3e55d5edd60a..c6fcaeeb5294 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4687,6 +4687,17 @@ lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
 	/* Look on all the FCP Rings for the iotag */
 	if (phba->sli_rev >= LPFC_SLI_REV4) {
 		for (i = 0; i < phba->cfg_hdw_queue; i++) {
+			if (!phba->sli4_hba.hdwq ||
+			    !phba->sli4_hba.hdwq[i].io_wq) {
+				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+						"7777 hdwq's deleted %lx "
+						"%lx %x %x\n",
+						phba->pport->load_flag,
+						phba->hba_flag,
+						phba->link_state,
+						phba->sli.sli_flag);
+				return;
+			}
 			pring = phba->sli4_hba.hdwq[i].io_wq->pring;
 
 			spin_lock_irq(&pring->ring_lock);
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 1e63cb6cd8e3..33e1eba62ca1 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -100,10 +100,12 @@ static void pm8001_map_queues(struct Scsi_Host *shost)
 	struct pm8001_hba_info *pm8001_ha = sha->lldd_ha;
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
-	if (pm8001_ha->number_of_intr > 1)
+	if (pm8001_ha->number_of_intr > 1) {
 		blk_mq_pci_map_queues(qmap, pm8001_ha->pdev, 1);
+		return;
+	}
 
-	return blk_mq_map_queues(qmap);
+	blk_mq_map_queues(qmap);
 }
 
 /*
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index c1524fb334eb..4230714e5f3a 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -5917,7 +5917,7 @@ static bool pqi_is_parity_write_stream(struct pqi_ctrl_info *ctrl_info,
 	int rc;
 	struct pqi_scsi_dev *device;
 	struct pqi_stream_data *pqi_stream_data;
-	struct pqi_scsi_dev_raid_map_data rmd;
+	struct pqi_scsi_dev_raid_map_data rmd = { 0 };
 
 	if (!ctrl_info->enable_stream_detection)
 		return false;
@@ -9428,6 +9428,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x152d, 0x8a37)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x193d, 0x0462)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x193d, 0x1104)
@@ -9456,6 +9460,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x193d, 0x110b)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x193d, 0x1110)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x193d, 0x8460)
@@ -9464,6 +9472,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x193d, 0x8461)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x193d, 0x8462)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x193d, 0xc460)
@@ -9572,6 +9584,14 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1bd4, 0x0089)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x00a1)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1f3a, 0x0104)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x19e5, 0xd227)
@@ -10164,6 +10184,110 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1137, 0x02fa)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1137, 0x02fe)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1137, 0x02ff)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1137, 0x0300)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0045)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0046)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0047)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0048)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x004a)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x004b)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x004c)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x004f)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0051)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0052)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0053)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0054)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x006b)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x006c)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x006d)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x006f)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0070)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0071)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0072)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0086)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0087)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0088)
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x0089)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 				0x1e93, 0x1000)
@@ -10248,6 +10372,10 @@ static const struct pci_device_id pqi_pci_id_table[] = {
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       0x1f51, 0x1045)
 	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
+			       0x1ff9, 0x00a3)
+	},
 	{
 		PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x028f,
 			       PCI_ANY_ID, PCI_ANY_ID)
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 0d8ce1a92168..d50bad3a2ce9 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -834,6 +834,9 @@ static int flush_buffer(struct scsi_tape *STp, int seek_next)
 	int backspace, result;
 	struct st_partstat *STps;
 
+	if (STp->ready != ST_READY)
+		return 0;
+
 	/*
 	 * If there was a bus reset, block further access
 	 * to this device.
@@ -841,8 +844,6 @@ static int flush_buffer(struct scsi_tape *STp, int seek_next)
 	if (STp->pos_unknown)
 		return (-EIO);
 
-	if (STp->ready != ST_READY)
-		return 0;
 	STps = &(STp->ps[STp->partition]);
 	if (STps->rw == ST_WRITING)	/* Writing */
 		return st_flush_write_buffer(STp);
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 2fb8d4e55c77..ef3a7226db12 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -466,6 +466,7 @@ static const struct platform_device_id bcm63xx_spi_dev_match[] = {
 	{
 	},
 };
+MODULE_DEVICE_TABLE(platform, bcm63xx_spi_dev_match);
 
 static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6348-spi", .data = &bcm6348_spi_reg_offsets },
@@ -583,13 +584,15 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		goto out_clk_disable;
 
 	/* register and we are done */
 	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		dev_err(dev, "spi register failed\n");
-		goto out_pm_disable;
+		goto out_clk_disable;
 	}
 
 	dev_info(dev, "at %pr (irq %d, FIFOs size %d)\n",
@@ -597,8 +600,6 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_pm_disable:
-	pm_runtime_disable(&pdev->dev);
 out_clk_disable:
 	clk_disable_unprepare(clk);
 out_err:
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index e5140532071d..81edf0a3ddf8 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -665,8 +665,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
 
 clk_dis_all:
 	if (!spi_controller_is_target(ctlr)) {
-		pm_runtime_set_suspended(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
 	}
 remove_ctlr:
 	spi_controller_put(ctlr);
@@ -688,8 +688,10 @@ static void cdns_spi_remove(struct platform_device *pdev)
 
 	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+	if (!spi_controller_is_target(ctlr)) {
+		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+	}
 
 	spi_unregister_controller(ctlr);
 }
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 1439883326cf..4c041ad39dc5 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1870,8 +1870,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 		spi_imx_sdma_exit(spi_imx);
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(spi_imx->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 
 	clk_disable_unprepare(spi_imx->clk_ipg);
 out_put_per:
diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index e11146932828..7cce2d2ab9ca 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -198,9 +198,16 @@ static int __maybe_unused rpcif_spi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
 
+static const struct platform_device_id rpc_if_spi_id_table[] = {
+	{ .name = "rpc-if-spi" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, rpc_if_spi_id_table);
+
 static struct platform_driver rpcif_spi_driver = {
 	.probe	= rpcif_spi_probe,
 	.remove_new = rpcif_spi_remove,
+	.id_table = rpc_if_spi_id_table,
 	.driver = {
 		.name	= "rpc-if-spi",
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 833c58c88e40..6ab416a33966 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -245,7 +245,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 	loops = msecs_to_loops(1);
 	do {
 		val = readl(regs + S3C64XX_SPI_STATUS);
-	} while (TX_FIFO_LVL(val, sdd) && loops--);
+	} while (TX_FIFO_LVL(val, sdd) && --loops);
 
 	if (loops == 0)
 		dev_warn(&sdd->pdev->dev, "Timed out flushing TX FIFO\n");
@@ -258,7 +258,7 @@ static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
 			readl(regs + S3C64XX_SPI_RX_DATA);
 		else
 			break;
-	} while (loops--);
+	} while (--loops);
 
 	if (loops == 0)
 		dev_warn(&sdd->pdev->dev, "Timed out flushing RX FIFO\n");
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 006ffacf1c56..c50f3fb49a66 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1029,20 +1029,23 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct vhost_scsi_ctx *vc,
 		/* virtio-scsi spec requires byte 0 of the lun to be 1 */
 		vq_err(vq, "Illegal virtio-scsi lun: %u\n", *vc->lunp);
 	} else {
-		struct vhost_scsi_tpg **vs_tpg, *tpg;
-
-		vs_tpg = vhost_vq_get_backend(vq);	/* validated at handler entry */
-
-		tpg = READ_ONCE(vs_tpg[*vc->target]);
-		if (unlikely(!tpg)) {
-			vq_err(vq, "Target 0x%x does not exist\n", *vc->target);
-		} else {
-			if (tpgp)
-				*tpgp = tpg;
-			ret = 0;
+		struct vhost_scsi_tpg **vs_tpg, *tpg = NULL;
+
+		if (vc->target) {
+			/* validated at handler entry */
+			vs_tpg = vhost_vq_get_backend(vq);
+			tpg = READ_ONCE(vs_tpg[*vc->target]);
+			if (unlikely(!tpg)) {
+				vq_err(vq, "Target 0x%x does not exist\n", *vc->target);
+				goto out;
+			}
 		}
-	}
 
+		if (tpgp)
+			*tpgp = tpg;
+		ret = 0;
+	}
+out:
 	return ret;
 }
 
diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 8dd82afb3452..595b8e27bea6 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -561,15 +561,10 @@ static int efifb_probe(struct platform_device *dev)
 		break;
 	}
 
-	err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
-	if (err) {
-		pr_err("efifb: cannot add sysfs attrs\n");
-		goto err_unmap;
-	}
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0) {
 		pr_err("efifb: cannot allocate colormap\n");
-		goto err_groups;
+		goto err_unmap;
 	}
 
 	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
@@ -587,8 +582,6 @@ static int efifb_probe(struct platform_device *dev)
 
 err_fb_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
-err_groups:
-	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
 err_unmap:
 	if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
 		iounmap(info->screen_base);
@@ -608,12 +601,12 @@ static void efifb_remove(struct platform_device *pdev)
 
 	/* efifb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
-	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
 }
 
 static struct platform_driver efifb_driver = {
 	.driver = {
 		.name = "efi-framebuffer",
+		.dev_groups = efifb_groups,
 	},
 	.probe = efifb_probe,
 	.remove_new = efifb_remove,
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 2ef56fa28aff..5ce02495cda6 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2403,6 +2403,7 @@ static void pxafb_remove(struct platform_device *dev)
 	info = &fbi->fb;
 
 	pxafb_overlay_exit(fbi);
+	cancel_work_sync(&fbi->task);
 	unregister_framebuffer(info);
 
 	pxafb_disable_controller(fbi);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index c3f0c45ae9a9..e0885cfeb72a 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -403,6 +403,7 @@ const struct netfs_request_ops afs_req_ops = {
 	.begin_writeback	= afs_begin_writeback,
 	.prepare_write		= afs_prepare_write,
 	.issue_write		= afs_issue_write,
+	.retry_request		= afs_retry_request,
 };
 
 static void afs_add_open_mmap(struct afs_vnode *vnode)
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 3546b087e791..428721bbe4f6 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -201,7 +201,7 @@ void afs_wait_for_operation(struct afs_operation *op)
 		}
 	}
 
-	if (op->call_responded)
+	if (op->call_responded && op->server)
 		set_bit(AFS_SERVER_FL_RESPONDING, &op->server->flags);
 
 	if (!afs_op_error(op)) {
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index a2de5c05f97c..57e327833ed1 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3179,10 +3179,14 @@ void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
 		btrfs_backref_cleanup_node(cache, node);
 	}
 
-	cache->last_trans = 0;
-
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++)
-		ASSERT(list_empty(&cache->pending[i]));
+	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
+		while (!list_empty(&cache->pending[i])) {
+			node = list_first_entry(&cache->pending[i],
+						struct btrfs_backref_node,
+						list);
+			btrfs_backref_cleanup_node(cache, node);
+		}
+	}
 	ASSERT(list_empty(&cache->pending_edge));
 	ASSERT(list_empty(&cache->useless_node));
 	ASSERT(list_empty(&cache->changed));
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3791813dc7b6..da6dff405c77 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4271,6 +4271,17 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* clear out the rbtree of defraggable inodes */
 	btrfs_cleanup_defrag_inodes(fs_info);
 
+	/*
+	 * Wait for any fixup workers to complete.
+	 * If we don't wait for them here and they are still running by the time
+	 * we call kthread_stop() against the cleaner kthread further below, we
+	 * get an use-after-free on the cleaner because the fixup worker adds an
+	 * inode to the list of delayed iputs and then attempts to wakeup the
+	 * cleaner kthread, which was already stopped and destroyed. We parked
+	 * already the cleaner, but below we run all pending delayed iputs.
+	 */
+	btrfs_flush_workqueue(fs_info->fixup_workers);
+
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
 	 * completed and created new delayed iputs. If one of the async reclaim
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f2935252b981..cb58a8796ef2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -231,70 +231,6 @@ static struct btrfs_backref_node *walk_down_backref(
 	return NULL;
 }
 
-static void update_backref_node(struct btrfs_backref_cache *cache,
-				struct btrfs_backref_node *node, u64 bytenr)
-{
-	struct rb_node *rb_node;
-	rb_erase(&node->rb_node, &cache->rb_root);
-	node->bytenr = bytenr;
-	rb_node = rb_simple_insert(&cache->rb_root, node->bytenr, &node->rb_node);
-	if (rb_node)
-		btrfs_backref_panic(cache->fs_info, bytenr, -EEXIST);
-}
-
-/*
- * update backref cache after a transaction commit
- */
-static int update_backref_cache(struct btrfs_trans_handle *trans,
-				struct btrfs_backref_cache *cache)
-{
-	struct btrfs_backref_node *node;
-	int level = 0;
-
-	if (cache->last_trans == 0) {
-		cache->last_trans = trans->transid;
-		return 0;
-	}
-
-	if (cache->last_trans == trans->transid)
-		return 0;
-
-	/*
-	 * detached nodes are used to avoid unnecessary backref
-	 * lookup. transaction commit changes the extent tree.
-	 * so the detached nodes are no longer useful.
-	 */
-	while (!list_empty(&cache->detached)) {
-		node = list_entry(cache->detached.next,
-				  struct btrfs_backref_node, list);
-		btrfs_backref_cleanup_node(cache, node);
-	}
-
-	while (!list_empty(&cache->changed)) {
-		node = list_entry(cache->changed.next,
-				  struct btrfs_backref_node, list);
-		list_del_init(&node->list);
-		BUG_ON(node->pending);
-		update_backref_node(cache, node, node->new_bytenr);
-	}
-
-	/*
-	 * some nodes can be left in the pending list if there were
-	 * errors during processing the pending nodes.
-	 */
-	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
-		list_for_each_entry(node, &cache->pending[level], list) {
-			BUG_ON(!node->pending);
-			if (node->bytenr == node->new_bytenr)
-				continue;
-			update_backref_node(cache, node, node->new_bytenr);
-		}
-	}
-
-	cache->last_trans = 0;
-	return 1;
-}
-
 static bool reloc_root_is_dead(const struct btrfs_root *root)
 {
 	/*
@@ -550,9 +486,6 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 	struct btrfs_backref_edge *new_edge;
 	struct rb_node *rb_node;
 
-	if (cache->last_trans > 0)
-		update_backref_cache(trans, cache);
-
 	rb_node = rb_simple_search(&cache->rb_root, src->commit_root->start);
 	if (rb_node) {
 		node = rb_entry(rb_node, struct btrfs_backref_node, rb_node);
@@ -922,7 +855,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
 	btrfs_grab_root(reloc_root);
 
 	/* root->reloc_root will stay until current relocation finished */
-	if (fs_info->reloc_ctl->merge_reloc_tree &&
+	if (fs_info->reloc_ctl && fs_info->reloc_ctl->merge_reloc_tree &&
 	    btrfs_root_refs(root_item) == 0) {
 		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
 		/*
@@ -3678,11 +3611,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 			break;
 		}
 restart:
-		if (update_backref_cache(trans, &rc->backref_cache)) {
-			btrfs_end_transaction(trans);
-			trans = NULL;
-			continue;
-		}
+		if (rc->backref_cache.last_trans != trans->transid)
+			btrfs_backref_release_cache(&rc->backref_cache);
+		rc->backref_cache.last_trans = trans->transid;
 
 		ret = find_next_extent(rc, path, &key);
 		if (ret < 0)
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d1a04c0c576e..474ceebe67bd 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6188,8 +6188,29 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	if (ret < 0)
 		return ret;
 
-	if (clone_root->offset + num_bytes == info.size)
+	if (clone_root->offset + num_bytes == info.size) {
+		/*
+		 * The final size of our file matches the end offset, but it may
+		 * be that its current size is larger, so we have to truncate it
+		 * to any value between the start offset of the range and the
+		 * final i_size, otherwise the clone operation is invalid
+		 * because it's unaligned and it ends before the current EOF.
+		 * We do this truncate to the final i_size when we finish
+		 * processing the inode, but it's too late by then. And here we
+		 * truncate to the start offset of the range because it's always
+		 * sector size aligned while if it were the final i_size it
+		 * would result in dirtying part of a page, filling part of a
+		 * page with zeroes and then having the clone operation at the
+		 * receiver trigger IO and wait for it due to the dirty page.
+		 */
+		if (sctx->parent_root != NULL) {
+			ret = send_truncate(sctx, sctx->cur_ino,
+					    sctx->cur_inode_gen, offset);
+			if (ret < 0)
+				return ret;
+		}
 		goto clone_data;
+	}
 
 write_data:
 	ret = send_extent_data(sctx, path, offset, num_bytes);
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f53977169db4..2b3f9935dbb4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -595,14 +595,12 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	 * write and readdir but not lookup or open).
 	 */
 	touch_atime(&file->f_path);
-	dput(dentry);
 	return true;
 
 check_failed:
 	fscache_cookie_lookup_negative(object->cookie);
 	cachefiles_unmark_inode_in_use(object, file);
 	fput(file);
-	dput(dentry);
 	if (ret == -ESTALE)
 		return cachefiles_create_file(object);
 	return false;
@@ -611,7 +609,6 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	fput(file);
 error:
 	cachefiles_do_unmark_inode_in_use(object, d_inode(dentry));
-	dput(dentry);
 	return false;
 }
 
@@ -654,7 +651,9 @@ bool cachefiles_look_up_object(struct cachefiles_object *object)
 		goto new_file;
 	}
 
-	if (!cachefiles_open_file(object, dentry))
+	ret = cachefiles_open_file(object, dentry);
+	dput(dentry);
+	if (!ret)
 		return false;
 
 	_leave(" = t [%lu]", file_inode(object->file)->i_ino);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 73b5a07bf94d..f68dd674c14d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -95,7 +95,6 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 
 	/* dirty the head */
 	spin_lock(&ci->i_ceph_lock);
-	BUG_ON(ci->i_wr_ref == 0); // caller should hold Fw reference
 	if (__ceph_have_pending_cap_snap(ci)) {
 		struct ceph_cap_snap *capsnap =
 				list_last_entry(&ci->i_cap_snaps,
@@ -469,8 +468,11 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	rreq->netfs_priv = priv;
 
 out:
-	if (ret < 0)
+	if (ret < 0) {
+		if (got)
+			ceph_put_cap_refs(ceph_inode(inode), got);
 		kfree(priv);
+	}
 
 	return ret;
 }
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c2157f6e0c69..d37e9ea57113 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6011,6 +6011,18 @@ static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
 		ceph_mdsmap_destroy(mdsc->mdsmap);
 	kfree(mdsc->sessions);
 	ceph_caps_finalize(mdsc);
+
+	if (mdsc->s_cap_auths) {
+		int i;
+
+		for (i = 0; i < mdsc->s_cap_auths_num; i++) {
+			kfree(mdsc->s_cap_auths[i].match.gids);
+			kfree(mdsc->s_cap_auths[i].match.path);
+			kfree(mdsc->s_cap_auths[i].match.fs_name);
+		}
+		kfree(mdsc->s_cap_auths);
+	}
+
 	ceph_pool_perm_destroy(mdsc);
 }
 
diff --git a/fs/dax.c b/fs/dax.c
index becb4a6920c6..c62acd2812f8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1305,11 +1305,15 @@ int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 	struct iomap_iter iter = {
 		.inode		= inode,
 		.pos		= pos,
-		.len		= len,
 		.flags		= IOMAP_WRITE | IOMAP_UNSHARE | IOMAP_DAX,
 	};
+	loff_t size = i_size_read(inode);
 	int ret;
 
+	if (pos < 0 || pos >= size)
+		return 0;
+
+	iter.len = min(len, size - pos);
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = dax_unshare_iter(&iter);
 	return ret;
diff --git a/fs/exec.c b/fs/exec.c
index 0c17e59e3767..3274525d08d2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -782,7 +782,8 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	stack_base = calc_max_stack_size(stack_base);
 
 	/* Add space for stack randomization. */
-	stack_base += (STACK_RND_MASK << PAGE_SHIFT);
+	if (current->flags & PF_RANDOMIZE)
+		stack_base += (STACK_RND_MASK << PAGE_SHIFT);
 
 	/* Make sure we didn't let the argument array grow too large. */
 	if (vma->vm_end - vma->vm_start > stack_base)
diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 0356c88252bd..ce9be95c9172 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -91,11 +91,8 @@ int exfat_load_bitmap(struct super_block *sb)
 				return -EIO;
 
 			type = exfat_get_entry_type(ep);
-			if (type == TYPE_UNUSED)
-				break;
-			if (type != TYPE_BITMAP)
-				continue;
-			if (ep->dentry.bitmap.flags == 0x0) {
+			if (type == TYPE_BITMAP &&
+			    ep->dentry.bitmap.flags == 0x0) {
 				int err;
 
 				err = exfat_allocate_bitmap(sb, ep);
@@ -103,6 +100,9 @@ int exfat_load_bitmap(struct super_block *sb)
 				return err;
 			}
 			brelse(bh);
+
+			if (type == TYPE_UNUSED)
+				return -EINVAL;
 		}
 
 		if (exfat_get_next_cluster(sb, &clu.dir))
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ff4514e4626b..b8b6b06015cd 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -279,12 +279,20 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					struct fscrypt_str de_name =
 							FSTR_INIT(de->name,
 								de->name_len);
+					u32 hash;
+					u32 minor_hash;
+
+					if (IS_CASEFOLDED(inode)) {
+						hash = EXT4_DIRENT_HASH(de);
+						minor_hash = EXT4_DIRENT_MINOR_HASH(de);
+					} else {
+						hash = 0;
+						minor_hash = 0;
+					}
 
 					/* Directory is encrypted */
 					err = fscrypt_fname_disk_to_usr(inode,
-						EXT4_DIRENT_HASH(de),
-						EXT4_DIRENT_MINOR_HASH(de),
-						&de_name, &fstr);
+						hash, minor_hash, &de_name, &fstr);
 					de_name = fstr;
 					fstr.len = save_len;
 					if (err)
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335..c64f7c1b1d90 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -957,6 +957,8 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 
 	ext4_ext_show_path(inode, path);
 
+	if (orig_path)
+		*orig_path = path;
 	return path;
 
 err:
@@ -1877,6 +1879,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
 	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
 
 	brelse(path[1].p_bh);
+	path[1].p_bh = NULL;
 	ext4_free_blocks(handle, inode, NULL, blk, 1,
 			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
 }
@@ -2103,6 +2106,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 				       ppath, newext);
 	if (err)
 		goto cleanup;
+	path = *ppath;
 	depth = ext_depth(inode);
 	eh = path[depth].p_hdr;
 
@@ -3230,6 +3234,24 @@ static int ext4_split_extent_at(handle_t *handle,
 	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
 		goto out;
 
+	/*
+	 * Update path is required because previous ext4_ext_insert_extent()
+	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
+	 * guarantees that ext4_find_extent() will not return -ENOMEM,
+	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
+	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
+	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
+	 */
+	path = ext4_find_extent(inode, ee_block, ppath,
+				flags | EXT4_EX_NOFAIL);
+	if (IS_ERR(path)) {
+		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
+				 split, PTR_ERR(path));
+		return PTR_ERR(path);
+	}
+	depth = ext_depth(inode);
+	ex = path[depth].p_ext;
+
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
 			if (split_flag & EXT4_EXT_DATA_VALID1) {
@@ -3282,12 +3304,12 @@ static int ext4_split_extent_at(handle_t *handle,
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
 out:
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 	return err;
 }
 
 /*
- * ext4_split_extents() splits an extent and mark extent which is covered
+ * ext4_split_extent() splits an extent and mark extent which is covered
  * by @map as split_flags indicates
  *
  * It may result in splitting the extent into multiple extents (up to three)
@@ -3363,7 +3385,7 @@ static int ext4_split_extent(handle_t *handle,
 			goto out;
 	}
 
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 out:
 	return err ? err : allocated;
 }
@@ -3828,14 +3850,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			struct ext4_ext_path **ppath, int flags,
 			unsigned int allocated, ext4_fsblk_t newblock)
 {
-	struct ext4_ext_path __maybe_unused *path = *ppath;
 	int ret = 0;
 	int err = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len, flags,
 		  allocated);
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 
 	/*
 	 * When writing into unwritten space, we should not fail to
@@ -3932,7 +3953,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	if (allocated > map->m_len)
 		allocated = map->m_len;
 	map->m_len = allocated;
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 out2:
 	return err ? err : allocated;
 }
@@ -5535,6 +5556,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
 	if (IS_ERR(path)) {
 		up_write(&EXT4_I(inode)->i_data_sem);
+		ret = PTR_ERR(path);
 		goto out_stop;
 	}
 
@@ -5880,7 +5902,7 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 			      int len, int unwritten, ext4_fsblk_t pblk)
 {
-	struct ext4_ext_path *path = NULL, *ppath;
+	struct ext4_ext_path *path;
 	struct ext4_extent *ex;
 	int ret;
 
@@ -5896,30 +5918,29 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 	if (le32_to_cpu(ex->ee_block) != start ||
 		ext4_ext_get_actual_len(ex) != len) {
 		/* We need to split this extent to match our extent first */
-		ppath = path;
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ret = ext4_force_split_extent_at(NULL, inode, &ppath, start, 1);
+		ret = ext4_force_split_extent_at(NULL, inode, &path, start, 1);
 		up_write(&EXT4_I(inode)->i_data_sem);
 		if (ret)
 			goto out;
-		kfree(path);
-		path = ext4_find_extent(inode, start, NULL, 0);
+
+		path = ext4_find_extent(inode, start, &path, 0);
 		if (IS_ERR(path))
-			return -1;
-		ppath = path;
+			return PTR_ERR(path);
 		ex = path[path->p_depth].p_ext;
 		WARN_ON(le32_to_cpu(ex->ee_block) != start);
+
 		if (ext4_ext_get_actual_len(ex) != len) {
 			down_write(&EXT4_I(inode)->i_data_sem);
-			ret = ext4_force_split_extent_at(NULL, inode, &ppath,
+			ret = ext4_force_split_extent_at(NULL, inode, &path,
 							 start + len, 1);
 			up_write(&EXT4_I(inode)->i_data_sem);
 			if (ret)
 				goto out;
-			kfree(path);
-			path = ext4_find_extent(inode, start, NULL, 0);
+
+			path = ext4_find_extent(inode, start, &path, 0);
 			if (IS_ERR(path))
-				return -EINVAL;
+				return PTR_ERR(path);
 			ex = path[path->p_depth].p_ext;
 		}
 	}
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..95667512010e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -339,22 +339,29 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	tid_t tid;
+	bool has_transaction = true;
+	bool is_ineligible;
 
 	if (ext4_fc_disabled(sb))
 		return;
 
-	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	if (handle && !IS_ERR(handle))
 		tid = handle->h_transaction->t_tid;
 	else {
 		read_lock(&sbi->s_journal->j_state_lock);
-		tid = sbi->s_journal->j_running_transaction ?
-				sbi->s_journal->j_running_transaction->t_tid : 0;
+		if (sbi->s_journal->j_running_transaction)
+			tid = sbi->s_journal->j_running_transaction->t_tid;
+		else
+			has_transaction = false;
 		read_unlock(&sbi->s_journal->j_state_lock);
 	}
 	spin_lock(&sbi->s_fc_lock);
-	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
+	is_ineligible = ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
+	if (has_transaction &&
+	    (!is_ineligible ||
+	     (is_ineligible && tid_gt(tid, sbi->s_fc_ineligible_tid))))
 		sbi->s_fc_ineligible_tid = tid;
+	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	spin_unlock(&sbi->s_fc_lock);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
 	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
@@ -372,7 +379,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
  */
 static int ext4_fc_track_template(
 	handle_t *handle, struct inode *inode,
-	int (*__fc_track_fn)(struct inode *, void *, bool),
+	int (*__fc_track_fn)(handle_t *handle, struct inode *, void *, bool),
 	void *args, int enqueue)
 {
 	bool update = false;
@@ -389,7 +396,7 @@ static int ext4_fc_track_template(
 		ext4_fc_reset_inode(inode);
 		ei->i_sync_tid = tid;
 	}
-	ret = __fc_track_fn(inode, args, update);
+	ret = __fc_track_fn(handle, inode, args, update);
 	mutex_unlock(&ei->i_fc_lock);
 
 	if (!enqueue)
@@ -413,7 +420,8 @@ struct __track_dentry_update_args {
 };
 
 /* __track_fn for directory entry updates. Called with ei->i_fc_lock. */
-static int __track_dentry_update(struct inode *inode, void *arg, bool update)
+static int __track_dentry_update(handle_t *handle, struct inode *inode,
+				 void *arg, bool update)
 {
 	struct ext4_fc_dentry_update *node;
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -428,14 +436,14 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 
 	if (IS_ENCRYPTED(dir)) {
 		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_ENCRYPTED_FILENAME,
-					NULL);
+					handle);
 		mutex_lock(&ei->i_fc_lock);
 		return -EOPNOTSUPP;
 	}
 
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
-		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
+		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, handle);
 		mutex_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
@@ -447,7 +455,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		node->fcd_name.name = kmalloc(dentry->d_name.len, GFP_NOFS);
 		if (!node->fcd_name.name) {
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
-			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
+			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, handle);
 			mutex_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
@@ -569,7 +577,8 @@ void ext4_fc_track_create(handle_t *handle, struct dentry *dentry)
 }
 
 /* __track_fn for inode tracking */
-static int __track_inode(struct inode *inode, void *arg, bool update)
+static int __track_inode(handle_t *handle, struct inode *inode, void *arg,
+			 bool update)
 {
 	if (update)
 		return -EEXIST;
@@ -607,7 +616,8 @@ struct __track_range_args {
 };
 
 /* __track_fn for tracking data updates */
-static int __track_range(struct inode *inode, void *arg, bool update)
+static int __track_range(handle_t *handle, struct inode *inode, void *arg,
+			 bool update)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	ext4_lblk_t oldstart;
@@ -1288,8 +1298,21 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		if (tid_geq(tid, iter->i_sync_tid))
+		if (tid_geq(tid, iter->i_sync_tid)) {
 			ext4_fc_reset_inode(&iter->vfs_inode);
+		} else if (full) {
+			/*
+			 * We are called after a full commit, inode has been
+			 * modified while the commit was running. Re-enqueue
+			 * the inode into STAGING, which will then be splice
+			 * back into MAIN. This cannot happen during
+			 * fastcommit because the journal is locked all the
+			 * time in that case (and tid doesn't increase so
+			 * tid check above isn't reliable).
+			 */
+			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_STAGING]);
+		}
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
 #if (BITS_PER_LONG < 64)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c89e434db6b7..be061bb64067 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -334,10 +334,10 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
  * Clean up the inode after DIO or DAX extending write has completed and the
  * inode size has been updated using ext4_handle_inode_extension().
  */
-static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
+static void ext4_inode_extension_cleanup(struct inode *inode, bool need_trunc)
 {
 	lockdep_assert_held_write(&inode->i_rwsem);
-	if (count < 0) {
+	if (need_trunc) {
 		ext4_truncate_failed_write(inode);
 		/*
 		 * If the truncate operation failed early, then the inode may
@@ -586,7 +586,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * writeback of delalloc blocks.
 		 */
 		WARN_ON_ONCE(ret == -EIOCBQUEUED);
-		ext4_inode_extension_cleanup(inode, ret);
+		ext4_inode_extension_cleanup(inode, ret < 0);
 	}
 
 out:
@@ -670,7 +670,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (extend) {
 		ret = ext4_handle_inode_extension(inode, offset, ret);
-		ext4_inode_extension_cleanup(inode, ret);
+		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
 	}
 out:
 	inode_unlock(inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 238e19633823..a99c5ae05dc6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5233,8 +5233,9 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 {
 	unsigned offset;
 	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
-	tid_t commit_tid = 0;
+	tid_t commit_tid;
 	int ret;
+	bool has_transaction;
 
 	offset = inode->i_size & (PAGE_SIZE - 1);
 	/*
@@ -5259,12 +5260,14 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 		folio_put(folio);
 		if (ret != -EBUSY)
 			return;
-		commit_tid = 0;
+		has_transaction = false;
 		read_lock(&journal->j_state_lock);
-		if (journal->j_committing_transaction)
+		if (journal->j_committing_transaction) {
 			commit_tid = journal->j_committing_transaction->t_tid;
+			has_transaction = true;
+		}
 		read_unlock(&journal->j_state_lock);
-		if (commit_tid)
+		if (has_transaction)
 			jbd2_log_wait_commit(journal, commit_tid);
 	}
 }
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index d98ac2af8199..a5e1492bbaaa 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -663,8 +663,8 @@ int ext4_ind_migrate(struct inode *inode)
 	if (unlikely(ret2 && !ret))
 		ret = ret2;
 errout:
-	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
 out_unlock:
 	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return ret;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 204f53b23622..c95e3e526390 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -36,7 +36,6 @@ get_ext_path(struct inode *inode, ext4_lblk_t lblock,
 		*ppath = NULL;
 		return -ENODATA;
 	}
-	*ppath = path;
 	return 0;
 }
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 1311ad0464b2..b1942a1aff9e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1526,7 +1526,7 @@ static bool ext4_match(struct inode *parent,
 }
 
 /*
- * Returns 0 if not found, -1 on failure, and 1 on success
+ * Returns 0 if not found, -EFSCORRUPTED on failure, and 1 on success
  */
 int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		    struct inode *dir, struct ext4_filename *fname,
@@ -1547,7 +1547,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 			 * a full check */
 			if (ext4_check_dir_entry(dir, NULL, de, bh, search_buf,
 						 buf_size, offset))
-				return -1;
+				return -EFSCORRUPTED;
 			*res_dir = de;
 			return 1;
 		}
@@ -1555,7 +1555,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		de_len = ext4_rec_len_from_disk(de->rec_len,
 						dir->i_sb->s_blocksize);
 		if (de_len <= 0)
-			return -1;
+			return -EFSCORRUPTED;
 		offset += de_len;
 		de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
 	}
@@ -1707,8 +1707,10 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 			goto cleanup_and_exit;
 		} else {
 			brelse(bh);
-			if (i < 0)
+			if (i < 0) {
+				ret = ERR_PTR(i);
 				goto cleanup_and_exit;
+			}
 		}
 	next:
 		if (++block >= nblocks)
@@ -1802,7 +1804,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		if (retval == 1)
 			goto success;
 		brelse(bh);
-		if (retval == -1) {
+		if (retval < 0) {
 			bh = ERR_PTR(ERR_BAD_DX_DIR);
 			goto errout;
 		}
@@ -2044,7 +2046,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 		split = count/2;
 
 	hash2 = map[split].hash;
-	continued = hash2 == map[split - 1].hash;
+	continued = split > 0 ? hash2 == map[split - 1].hash : 0;
 	dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
 			(unsigned long)dx_get_block(frame->at),
 					hash2, split, count-split));
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 0ba9837d65ca..f12ccaabf13d 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -230,8 +230,8 @@ struct ext4_new_flex_group_data {
 #define MAX_RESIZE_BG				16384
 
 /*
- * alloc_flex_gd() allocates a ext4_new_flex_group_data with size of
- * @flexbg_size.
+ * alloc_flex_gd() allocates an ext4_new_flex_group_data that satisfies the
+ * resizing from @o_group to @n_group, its size is typically @flexbg_size.
  *
  * Returns NULL on failure otherwise address of the allocated structure.
  */
@@ -239,25 +239,27 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size,
 				ext4_group_t o_group, ext4_group_t n_group)
 {
 	ext4_group_t last_group;
+	unsigned int max_resize_bg;
 	struct ext4_new_flex_group_data *flex_gd;
 
 	flex_gd = kmalloc(sizeof(*flex_gd), GFP_NOFS);
 	if (flex_gd == NULL)
 		goto out3;
 
-	if (unlikely(flexbg_size > MAX_RESIZE_BG))
-		flex_gd->resize_bg = MAX_RESIZE_BG;
-	else
-		flex_gd->resize_bg = flexbg_size;
+	max_resize_bg = umin(flexbg_size, MAX_RESIZE_BG);
+	flex_gd->resize_bg = max_resize_bg;
 
 	/* Avoid allocating large 'groups' array if not needed */
 	last_group = o_group | (flex_gd->resize_bg - 1);
 	if (n_group <= last_group)
-		flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
+		flex_gd->resize_bg = 1 << fls(n_group - o_group);
 	else if (n_group - last_group < flex_gd->resize_bg)
-		flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
+		flex_gd->resize_bg = 1 << max(fls(last_group - o_group),
 					      fls(n_group - last_group));
 
+	if (WARN_ON_ONCE(flex_gd->resize_bg > max_resize_bg))
+		flex_gd->resize_bg = max_resize_bg;
+
 	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
 					sizeof(struct ext4_new_group_data),
 					GFP_NOFS);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index edc692984404..b75f84a1e500 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5331,6 +5331,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
 
+	spin_lock_init(&sbi->s_bdev_wb_lock);
+
 	ext4_fast_commit_init(sb);
 
 	sb->s_root = NULL;
@@ -5552,7 +5554,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * Save the original bdev mapping's wb_err value which could be
 	 * used to detect the metadata async write error.
 	 */
-	spin_lock_init(&sbi->s_bdev_wb_lock);
 	errseq_check_and_advance(&sb->s_bdev->bd_mapping->wb_err,
 				 &sbi->s_bdev_wb_err);
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
@@ -5632,8 +5633,8 @@ failed_mount8: __maybe_unused
 failed_mount3:
 	/* flush s_sb_upd_work before sbi destroy */
 	flush_work(&sbi->s_sb_upd_work);
-	del_timer_sync(&sbi->s_err_report);
 	ext4_stop_mmpd(sbi);
+	del_timer_sync(&sbi->s_err_report);
 	ext4_group_desc_free(sbi);
 failed_mount:
 	if (sbi->s_chksum_driver)
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..aea9e3c405f1 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2559,6 +2559,8 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 
 		error = ext4_xattr_set_handle(handle, inode, name_index, name,
 					      value, value_len, flags);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
+					handle);
 		error2 = ext4_journal_stop(handle);
 		if (error == -ENOSPC &&
 		    ext4_should_retry_alloc(sb, &retries))
@@ -2566,7 +2568,6 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (error == 0)
 			error = error2;
 	}
-	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, NULL);
 
 	return error;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9c8acb98f4db..549361ee4850 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -134,6 +134,12 @@ typedef u32 nid_t;
 
 #define COMPRESS_EXT_NUM		16
 
+enum blkzone_allocation_policy {
+	BLKZONE_ALLOC_PRIOR_SEQ,	/* Prioritize writing to sequential zones */
+	BLKZONE_ALLOC_ONLY_SEQ,		/* Only allow writing to sequential zones */
+	BLKZONE_ALLOC_PRIOR_CONV,	/* Prioritize writing to conventional zones */
+};
+
 /*
  * An implementation of an rwsem that is explicitly unfair to readers. This
  * prevents priority inversion when a low-priority reader acquires the read lock
@@ -1295,6 +1301,7 @@ struct f2fs_gc_control {
 	bool no_bg_gc;			/* check the space and stop bg_gc */
 	bool should_migrate_blocks;	/* should migrate blocks */
 	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
+	bool one_time;			/* require one time GC in one migration unit */
 	unsigned int nr_free_secs;	/* # of free sections to do GC */
 };
 
@@ -1563,6 +1570,8 @@ struct f2fs_sb_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
 	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
+	/* For adjust the priority writing position of data in zone UFS */
+	unsigned int blkzone_alloc_policy;
 #endif
 
 	/* for node-related operations */
@@ -1689,6 +1698,8 @@ struct f2fs_sb_info {
 	unsigned int max_victim_search;
 	/* migration granularity of garbage collection, unit: segment */
 	unsigned int migration_granularity;
+	/* migration window granularity of garbage collection, unit: segment */
+	unsigned int migration_window_granularity;
 
 	/*
 	 * for stat information.
@@ -2862,13 +2873,26 @@ static inline bool is_inflight_io(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
+static inline bool is_inflight_read_io(struct f2fs_sb_info *sbi)
+{
+	return get_pages(sbi, F2FS_RD_DATA) || get_pages(sbi, F2FS_DIO_READ);
+}
+
 static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 {
+	bool zoned_gc = (type == GC_TIME &&
+			F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_BLKZONED));
+
 	if (sbi->gc_mode == GC_URGENT_HIGH)
 		return true;
 
-	if (is_inflight_io(sbi, type))
-		return false;
+	if (zoned_gc) {
+		if (is_inflight_read_io(sbi))
+			return false;
+	} else {
+		if (is_inflight_io(sbi, type))
+			return false;
+	}
 
 	if (sbi->gc_mode == GC_URGENT_MID)
 		return true;
@@ -2877,6 +2901,9 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 			(type == DISCARD_TIME || type == GC_TIME))
 		return true;
 
+	if (zoned_gc)
+		return true;
+
 	return f2fs_time_over(sbi, type);
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 448c75e80b89..e8bf72a88cac 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -81,6 +81,8 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
+		gc_control.one_time = false;
+
 		/*
 		 * [GC triggering condition]
 		 * 0. GC is not conducted currently.
@@ -116,15 +118,29 @@ static int gc_thread_func(void *data)
 			goto next;
 		}
 
-		if (has_enough_invalid_blocks(sbi))
+		if (f2fs_sb_has_blkzoned(sbi)) {
+			if (has_enough_free_blocks(sbi, LIMIT_NO_ZONED_GC)) {
+				wait_ms = gc_th->no_gc_sleep_time;
+				f2fs_up_write(&sbi->gc_lock);
+				goto next;
+			}
+			if (wait_ms == gc_th->no_gc_sleep_time)
+				wait_ms = gc_th->max_sleep_time;
+		}
+
+		if (need_to_boost_gc(sbi)) {
 			decrease_sleep_time(gc_th, &wait_ms);
-		else
+			if (f2fs_sb_has_blkzoned(sbi))
+				gc_control.one_time = true;
+		} else {
 			increase_sleep_time(gc_th, &wait_ms);
+		}
 do_gc:
 		stat_inc_gc_call_count(sbi, foreground ?
 					FOREGROUND : BACKGROUND);
 
-		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
+		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
+				gc_control.one_time;
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground)
@@ -179,9 +195,16 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
-	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
-	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
-	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+
+	if (f2fs_sb_has_blkzoned(sbi)) {
+		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
+		gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME_ZONED;
+		gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME_ZONED;
+	} else {
+		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
+		gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
+		gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
+	}
 
 	gc_th->gc_wake = false;
 
@@ -1684,31 +1707,49 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				unsigned int start_segno,
 				struct gc_inode_list *gc_list, int gc_type,
-				bool force_migrate)
+				bool force_migrate, bool one_time)
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
 	struct blk_plug plug;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + SEGS_PER_SEC(sbi);
+	unsigned int sec_end_segno;
 	int seg_freed = 0, migrated = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 	unsigned char data_type = (type == SUM_TYPE_DATA) ? DATA : NODE;
 	int submitted = 0;
 
-	if (__is_large_section(sbi))
-		end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
+	if (__is_large_section(sbi)) {
+		sec_end_segno = rounddown(end_segno, SEGS_PER_SEC(sbi));
 
-	/*
-	 * zone-capacity can be less than zone-size in zoned devices,
-	 * resulting in less than expected usable segments in the zone,
-	 * calculate the end segno in the zone which can be garbage collected
-	 */
-	if (f2fs_sb_has_blkzoned(sbi))
-		end_segno -= SEGS_PER_SEC(sbi) -
+		/*
+		 * zone-capacity can be less than zone-size in zoned devices,
+		 * resulting in less than expected usable segments in the zone,
+		 * calculate the end segno in the zone which can be garbage
+		 * collected
+		 */
+		if (f2fs_sb_has_blkzoned(sbi))
+			sec_end_segno -= SEGS_PER_SEC(sbi) -
 					f2fs_usable_segs_in_sec(sbi, segno);
 
+		if (gc_type == BG_GC || one_time) {
+			unsigned int window_granularity =
+				sbi->migration_window_granularity;
+
+			if (f2fs_sb_has_blkzoned(sbi) &&
+					!has_enough_free_blocks(sbi,
+					LIMIT_BOOST_ZONED_GC))
+				window_granularity *= BOOST_GC_MULTIPLE;
+
+			end_segno = start_segno + window_granularity;
+		}
+
+		if (end_segno > sec_end_segno)
+			end_segno = sec_end_segno;
+	}
+
 	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
 
 	/* readahead multi ssa blocks those have contiguous address */
@@ -1787,7 +1828,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		if (__is_large_section(sbi))
 			sbi->next_victim_seg[gc_type] =
-				(segno + 1 < end_segno) ? segno + 1 : NULL_SEGNO;
+				(segno + 1 < sec_end_segno) ?
+					segno + 1 : NULL_SEGNO;
 skip:
 		f2fs_put_page(sum_page, 0);
 	}
@@ -1876,7 +1918,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	}
 
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type,
-				gc_control->should_migrate_blocks);
+				gc_control->should_migrate_blocks,
+				gc_control->one_time);
 	if (seg_freed < 0)
 		goto stop;
 
@@ -1887,6 +1930,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		total_sec_freed++;
 	}
 
+	if (gc_control->one_time)
+		goto stop;
+
 	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
 
@@ -2011,8 +2057,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
-		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
-						dry_run_sections == 0);
+		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
 		if (!dry_run && get_valid_blocks(sbi, segno, true))
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index a8ea3301b815..78abeebd68b5 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -15,6 +15,11 @@
 #define DEF_GC_THREAD_MAX_SLEEP_TIME	60000
 #define DEF_GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
 
+/* GC sleep parameters for zoned deivces */
+#define DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED	10
+#define DEF_GC_THREAD_MAX_SLEEP_TIME_ZONED	20
+#define DEF_GC_THREAD_NOGC_SLEEP_TIME_ZONED	60000
+
 /* choose candidates from sections which has age of more than 7 days */
 #define DEF_GC_THREAD_AGE_THRESHOLD		(60 * 60 * 24 * 7)
 #define DEF_GC_THREAD_CANDIDATE_RATIO		20	/* select 20% oldest sections as candidates */
@@ -25,6 +30,11 @@
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
+#define LIMIT_NO_ZONED_GC	60 /* percentage over total user space of no gc for zoned devices */
+#define LIMIT_BOOST_ZONED_GC	25 /* percentage over total user space of boosted gc for zoned devices */
+#define DEF_MIGRATION_WINDOW_GRANULARITY_ZONED	3
+#define BOOST_GC_MULTIPLE	5
+
 #define DEF_GC_FAILED_PINNED_FILES	2048
 #define MAX_GC_FAILED_PINNED_FILES	USHRT_MAX
 
@@ -152,6 +162,12 @@ static inline void decrease_sleep_time(struct f2fs_gc_kthread *gc_th,
 		*wait -= min_time;
 }
 
+static inline bool has_enough_free_blocks(struct f2fs_sb_info *sbi,
+						unsigned int limit_perc)
+{
+	return free_sections(sbi) > ((sbi->total_sections * limit_perc) / 100);
+}
+
 static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 {
 	block_t user_block_count = sbi->user_block_count;
@@ -167,3 +183,10 @@ static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 		free_user_blocks(sbi) <
 			limit_free_user_blocks(invalid_user_blocks));
 }
+
+static inline bool need_to_boost_gc(struct f2fs_sb_info *sbi)
+{
+	if (f2fs_sb_has_blkzoned(sbi))
+		return !has_enough_free_blocks(sbi, LIMIT_BOOST_ZONED_GC);
+	return has_enough_invalid_blocks(sbi);
+}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 425479d76921..297cc89cbcca 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2701,22 +2701,47 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 			goto got_it;
 	}
 
+#ifdef CONFIG_BLK_DEV_ZONED
 	/*
 	 * If we format f2fs on zoned storage, let's try to get pinned sections
 	 * from beginning of the storage, which should be a conventional one.
 	 */
 	if (f2fs_sb_has_blkzoned(sbi)) {
-		segno = pinning ? 0 : max(first_zoned_segno(sbi), *newseg);
+		/* Prioritize writing to conventional zones */
+		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_PRIOR_CONV || pinning)
+			segno = 0;
+		else
+			segno = max(first_zoned_segno(sbi), *newseg);
 		hint = GET_SEC_FROM_SEG(sbi, segno);
 	}
+#endif
 
 find_other_zone:
 	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (secno >= MAIN_SECS(sbi) && f2fs_sb_has_blkzoned(sbi)) {
+		/* Write only to sequential zones */
+		if (sbi->blkzone_alloc_policy == BLKZONE_ALLOC_ONLY_SEQ) {
+			hint = GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi));
+			secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
+		} else
+			secno = find_first_zero_bit(free_i->free_secmap,
+								MAIN_SECS(sbi));
+		if (secno >= MAIN_SECS(sbi)) {
+			ret = -ENOSPC;
+			f2fs_bug_on(sbi, 1);
+			goto out_unlock;
+		}
+	}
+#endif
+
 	if (secno >= MAIN_SECS(sbi)) {
 		secno = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
 		if (secno >= MAIN_SECS(sbi)) {
 			ret = -ENOSPC;
+			f2fs_bug_on(sbi, 1);
 			goto out_unlock;
 		}
 	}
@@ -2758,10 +2783,8 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 out_unlock:
 	spin_unlock(&free_i->segmap_lock);
 
-	if (ret == -ENOSPC) {
+	if (ret == -ENOSPC)
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
-		f2fs_bug_on(sbi, 1);
-	}
 	return ret;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b4c8ac6c0859..b0932a4a8e04 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -711,6 +711,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			if (!strcmp(name, "on")) {
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 			} else if (!strcmp(name, "off")) {
+				if (f2fs_sb_has_blkzoned(sbi)) {
+					f2fs_warn(sbi, "zoned devices need bggc");
+					kfree(name);
+					return -EINVAL;
+				}
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_OFF;
 			} else if (!strcmp(name, "sync")) {
 				F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_SYNC;
@@ -3796,6 +3801,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
 	sbi->migration_granularity = SEGS_PER_SEC(sbi);
+	sbi->migration_window_granularity = f2fs_sb_has_blkzoned(sbi) ?
+		DEF_MIGRATION_WINDOW_GRANULARITY_ZONED : SEGS_PER_SEC(sbi);
 	sbi->seq_file_ra_mul = MIN_RA_MUL;
 	sbi->max_fragment_chunk = DEF_FRAGMENT_SIZE;
 	sbi->max_fragment_hole = DEF_FRAGMENT_SIZE;
@@ -4231,6 +4238,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 	sbi->aligned_blksize = true;
 #ifdef CONFIG_BLK_DEV_ZONED
 	sbi->max_open_zones = UINT_MAX;
+	sbi->blkzone_alloc_policy = BLKZONE_ALLOC_PRIOR_SEQ;
 #endif
 
 	for (i = 0; i < max_devices; i++) {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 09d3ecfaa4f1..bb0dbe7665f9 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -561,6 +561,11 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 			return -EINVAL;
 	}
 
+	if (!strcmp(a->attr.name, "migration_window_granularity")) {
+		if (t == 0 || t > SEGS_PER_SEC(sbi))
+			return -EINVAL;
+	}
+
 	if (!strcmp(a->attr.name, "gc_urgent")) {
 		if (t == 0) {
 			sbi->gc_mode = GC_NORMAL;
@@ -627,6 +632,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	}
 #endif
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (!strcmp(a->attr.name, "blkzone_alloc_policy")) {
+		if (t < BLKZONE_ALLOC_PRIOR_SEQ || t > BLKZONE_ALLOC_PRIOR_CONV)
+			return -EINVAL;
+		sbi->blkzone_alloc_policy = t;
+		return count;
+	}
+#endif
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (!strcmp(a->attr.name, "compr_written_block") ||
 		!strcmp(a->attr.name, "compr_saved_block")) {
@@ -1001,6 +1015,7 @@ F2FS_SBI_RW_ATTR(gc_pin_file_thresh, gc_pin_file_threshold);
 F2FS_SBI_RW_ATTR(gc_reclaimed_segments, gc_reclaimed_segs);
 F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
 F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
+F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
 F2FS_SBI_GENERAL_RW_ATTR(dir_level);
 #ifdef CONFIG_F2FS_IOSTAT
 F2FS_SBI_GENERAL_RW_ATTR(iostat_enable);
@@ -1033,6 +1048,7 @@ F2FS_SBI_GENERAL_RW_ATTR(warm_data_age_threshold);
 F2FS_SBI_GENERAL_RW_ATTR(last_age_weight);
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
+F2FS_SBI_GENERAL_RW_ATTR(blkzone_alloc_policy);
 #endif
 
 /* STAT_INFO ATTR */
@@ -1140,6 +1156,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(min_ssr_sections),
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(migration_granularity),
+	ATTR_LIST(migration_window_granularity),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
 	ATTR_LIST(ra_nid_pages),
@@ -1187,6 +1204,7 @@ static struct attribute *f2fs_attrs[] = {
 #endif
 #ifdef CONFIG_BLK_DEV_ZONED
 	ATTR_LIST(unusable_blocks_per_sec),
+	ATTR_LIST(blkzone_alloc_policy),
 #endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compr_written_block),
diff --git a/fs/file.c b/fs/file.c
index 655338effe9c..c2403cde40e4 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -272,59 +272,45 @@ static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
 	return test_bit(fd, fdt->open_fds);
 }
 
-static unsigned int count_open_files(struct fdtable *fdt)
-{
-	unsigned int size = fdt->max_fds;
-	unsigned int i;
-
-	/* Find the last open fd */
-	for (i = size / BITS_PER_LONG; i > 0; ) {
-		if (fdt->open_fds[--i])
-			break;
-	}
-	i = (i + 1) * BITS_PER_LONG;
-	return i;
-}
-
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
  *
- * 'max_fds' will normally already be properly aligned, but it
- * turns out that in the close_range() -> __close_range() ->
- * unshare_fd() -> dup_fd() -> sane_fdtable_size() we can end
- * up having a 'max_fds' value that isn't already aligned.
- *
- * Rather than make close_range() have to worry about this,
- * just make that BITS_PER_LONG alignment be part of a sane
- * fdtable size. Becuase that's really what it is.
+ * punch_hole is optional - when close_range() is asked to unshare
+ * and close, we don't need to copy descriptors in that range, so
+ * a smaller cloned descriptor table might suffice if the last
+ * currently opened descriptor falls into that range.
  */
-static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
+static unsigned int sane_fdtable_size(struct fdtable *fdt, struct fd_range *punch_hole)
 {
-	unsigned int count;
-
-	count = count_open_files(fdt);
-	if (max_fds < NR_OPEN_DEFAULT)
-		max_fds = NR_OPEN_DEFAULT;
-	return ALIGN(min(count, max_fds), BITS_PER_LONG);
+	unsigned int last = find_last_bit(fdt->open_fds, fdt->max_fds);
+
+	if (last == fdt->max_fds)
+		return NR_OPEN_DEFAULT;
+	if (punch_hole && punch_hole->to >= last && punch_hole->from <= last) {
+		last = find_last_bit(fdt->open_fds, punch_hole->from);
+		if (last == punch_hole->from)
+			return NR_OPEN_DEFAULT;
+	}
+	return ALIGN(last + 1, BITS_PER_LONG);
 }
 
 /*
- * Allocate a new files structure and copy contents from the
- * passed in files structure.
- * errorp will be valid only when the returned files_struct is NULL.
+ * Allocate a new descriptor table and copy contents from the passed in
+ * instance.  Returns a pointer to cloned table on success, ERR_PTR()
+ * on failure.  For 'punch_hole' see sane_fdtable_size().
  */
-struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int *errorp)
+struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_hole)
 {
 	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
 	unsigned int open_files, i;
 	struct fdtable *old_fdt, *new_fdt;
+	int error;
 
-	*errorp = -ENOMEM;
 	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
 	if (!newf)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	atomic_set(&newf->count, 1);
 
@@ -341,7 +327,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
-	open_files = sane_fdtable_size(old_fdt, max_fds);
+	open_files = sane_fdtable_size(old_fdt, punch_hole);
 
 	/*
 	 * Check whether we need to allocate a larger fd array and fd set.
@@ -354,14 +340,14 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 		new_fdt = alloc_fdtable(open_files - 1);
 		if (!new_fdt) {
-			*errorp = -ENOMEM;
+			error = -ENOMEM;
 			goto out_release;
 		}
 
 		/* beyond sysctl_nr_open; nothing to do */
 		if (unlikely(new_fdt->max_fds < open_files)) {
 			__free_fdtable(new_fdt);
-			*errorp = -EMFILE;
+			error = -EMFILE;
 			goto out_release;
 		}
 
@@ -372,7 +358,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 		 */
 		spin_lock(&oldf->file_lock);
 		old_fdt = files_fdtable(oldf);
-		open_files = sane_fdtable_size(old_fdt, max_fds);
+		open_files = sane_fdtable_size(old_fdt, punch_hole);
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
@@ -406,8 +392,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 out_release:
 	kmem_cache_free(files_cachep, newf);
-out:
-	return NULL;
+	return ERR_PTR(error);
 }
 
 static struct fdtable *close_files(struct files_struct * files)
@@ -748,37 +733,25 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	if (fd > max_fd)
 		return -EINVAL;
 
-	if (flags & CLOSE_RANGE_UNSHARE) {
-		int ret;
-		unsigned int max_unshare_fds = NR_OPEN_MAX;
+	if ((flags & CLOSE_RANGE_UNSHARE) && atomic_read(&cur_fds->count) > 1) {
+		struct fd_range range = {fd, max_fd}, *punch_hole = &range;
 
 		/*
 		 * If the caller requested all fds to be made cloexec we always
 		 * copy all of the file descriptors since they still want to
 		 * use them.
 		 */
-		if (!(flags & CLOSE_RANGE_CLOEXEC)) {
-			/*
-			 * If the requested range is greater than the current
-			 * maximum, we're closing everything so only copy all
-			 * file descriptors beneath the lowest file descriptor.
-			 */
-			rcu_read_lock();
-			if (max_fd >= last_fd(files_fdtable(cur_fds)))
-				max_unshare_fds = fd;
-			rcu_read_unlock();
-		}
-
-		ret = unshare_fd(CLONE_FILES, max_unshare_fds, &fds);
-		if (ret)
-			return ret;
+		if (flags & CLOSE_RANGE_CLOEXEC)
+			punch_hole = NULL;
 
+		fds = dup_fd(cur_fds, punch_hole);
+		if (IS_ERR(fds))
+			return PTR_ERR(fds);
 		/*
 		 * We used to share our file descriptor table, and have now
 		 * created a private one, make sure we're using it below.
 		 */
-		if (fds)
-			swap(cur_fds, fds);
+		swap(cur_fds, fds);
 	}
 
 	if (flags & CLOSE_RANGE_CLOEXEC)
diff --git a/fs/inode.c b/fs/inode.c
index 3df67672986a..aeb07c3b8f24 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -593,6 +593,7 @@ void dump_mapping(const struct address_space *mapping)
 	struct hlist_node *dentry_first;
 	struct dentry *dentry_ptr;
 	struct dentry dentry;
+	char fname[64] = {};
 	unsigned long ino;
 
 	/*
@@ -629,11 +630,14 @@ void dump_mapping(const struct address_space *mapping)
 		return;
 	}
 
+	if (strncpy_from_kernel_nofault(fname, dentry.d_name.name, 63) < 0)
+		strscpy(fname, "<invalid>");
 	/*
-	 * if dentry is corrupted, the %pd handler may still crash,
-	 * but it's unlikely that we reach here with a corrupt mapping
+	 * Even if strncpy_from_kernel_nofault() succeeded,
+	 * the fname could be unreliable
 	 */
-	pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n", a_ops, ino, &dentry);
+	pr_warn("aops:%ps ino:%lx dentry name(?):\"%s\"\n",
+		a_ops, ino, fname);
 }
 
 void clear_inode(struct inode *inode)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d46558990279..b9b035a5e779 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1226,7 +1226,15 @@ static int iomap_write_delalloc_release(struct inode *inode,
 			error = data_end;
 			goto out_unlock;
 		}
-		WARN_ON_ONCE(data_end <= start_byte);
+
+		/*
+		 * If we race with post-direct I/O invalidation of the page cache,
+		 * there might be no data left at start_byte.
+		 */
+		if (data_end == start_byte)
+			continue;
+
+		WARN_ON_ONCE(data_end < start_byte);
 		WARN_ON_ONCE(data_end > scan_end_byte);
 
 		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
@@ -1366,11 +1374,15 @@ iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 	struct iomap_iter iter = {
 		.inode		= inode,
 		.pos		= pos,
-		.len		= len,
 		.flags		= IOMAP_WRITE | IOMAP_UNSHARE,
 	};
+	loff_t size = i_size_read(inode);
 	int ret;
 
+	if (pos < 0 || pos >= size)
+		return 0;
+
+	iter.len = min(len, size - pos);
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_unshare_iter(&iter);
 	return ret;
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 951f78634adf..b3971e91e8eb 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -79,17 +79,23 @@ __releases(&journal->j_state_lock)
 		if (space_left < nblocks) {
 			int chkpt = journal->j_checkpoint_transactions != NULL;
 			tid_t tid = 0;
+			bool has_transaction = false;
 
-			if (journal->j_committing_transaction)
+			if (journal->j_committing_transaction) {
 				tid = journal->j_committing_transaction->t_tid;
+				has_transaction = true;
+			}
 			spin_unlock(&journal->j_list_lock);
 			write_unlock(&journal->j_state_lock);
 			if (chkpt) {
 				jbd2_log_do_checkpoint(journal);
-			} else if (jbd2_cleanup_journal_tail(journal) == 0) {
-				/* We were able to recover space; yay! */
+			} else if (jbd2_cleanup_journal_tail(journal) <= 0) {
+				/*
+				 * We were able to recover space or the
+				 * journal was aborted due to an error.
+				 */
 				;
-			} else if (tid) {
+			} else if (has_transaction) {
 				/*
 				 * jbd2_journal_commit_transaction() may want
 				 * to take the checkpoint_mutex if JBD2_FLUSHED
@@ -407,6 +413,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	tid_t tid = 0;
 	unsigned long nr_freed = 0;
 	unsigned long freed;
+	bool first_set = false;
 
 again:
 	spin_lock(&journal->j_list_lock);
@@ -426,8 +433,10 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	else
 		transaction = journal->j_checkpoint_transactions;
 
-	if (!first_tid)
+	if (!first_set) {
 		first_tid = transaction->t_tid;
+		first_set = true;
+	}
 	last_transaction = journal->j_checkpoint_transactions->t_cpprev;
 	next_transaction = transaction;
 	last_tid = last_transaction->t_tid;
@@ -457,7 +466,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 	spin_unlock(&journal->j_list_lock);
 	cond_resched();
 
-	if (*nr_to_scan && next_tid)
+	if (*nr_to_scan && journal->j_shrink_transaction)
 		goto again;
 out:
 	trace_jbd2_shrink_checkpoint_list(journal, first_tid, tid, last_tid,
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c8d9d85e0e87..cca73b8282d1 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -725,7 +725,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 		return -EINVAL;
 
 	write_lock(&journal->j_state_lock);
-	if (tid <= journal->j_commit_sequence) {
+	if (tid_geq(journal->j_commit_sequence, tid)) {
 		write_unlock(&journal->j_state_lock);
 		return -EALREADY;
 	}
@@ -755,9 +755,9 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
-	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0, tid);
+	jbd2_journal_unlock_updates(journal);
 	write_lock(&journal->j_state_lock);
 	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	if (fallback)
diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index 575cb2ba74fc..5f4b305030ad 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -65,7 +65,7 @@ void jfs_issue_discard(struct inode *ip, u64 blkno, u64 nblocks)
 int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 {
 	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
+	struct bmap *bmp;
 	struct super_block *sb = ipbmap->i_sb;
 	int agno, agno_end;
 	u64 start, end, minlen;
@@ -83,10 +83,15 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 	if (minlen == 0)
 		minlen = 1;
 
+	down_read(&sb->s_umount);
+	bmp = JFS_SBI(ip->i_sb)->bmap;
+
 	if (minlen > bmp->db_agsize ||
 	    start >= bmp->db_mapsize ||
-	    range->len < sb->s_blocksize)
+	    range->len < sb->s_blocksize) {
+		up_read(&sb->s_umount);
 		return -EINVAL;
+	}
 
 	if (end >= bmp->db_mapsize)
 		end = bmp->db_mapsize - 1;
@@ -100,6 +105,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 		trimmed += dbDiscardAG(ip, agno, minlen);
 		agno++;
 	}
+
+	up_read(&sb->s_umount);
 	range->len = trimmed << sb->s_blocksize_bits;
 
 	return 0;
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 0625d1c0d064..974ecf5e0d95 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2944,9 +2944,10 @@ static void dbAdjTree(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 {
 	int ti, n = 0, k, x = 0;
-	int max_size;
+	int max_size, max_idx;
 
 	max_size = is_ctl ? CTLTREESIZE : TREESIZE;
+	max_idx = is_ctl ? LPERCTL : LPERDMAP;
 
 	/* first check the root of the tree to see if there is
 	 * sufficient free space.
@@ -2978,6 +2979,8 @@ static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 		 */
 		assert(n < 4);
 	}
+	if (le32_to_cpu(tp->dmt_leafidx) >= max_idx)
+		return -ENOSPC;
 
 	/* set the return to the leftmost leaf describing sufficient
 	 * free space.
@@ -3022,7 +3025,7 @@ static int dbFindBits(u32 word, int l2nb)
 
 	/* scan the word for nb free bits at nb alignments.
 	 */
-	for (bitno = 0; mask != 0; bitno += nb, mask >>= nb) {
+	for (bitno = 0; mask != 0; bitno += nb, mask = (mask >> nb)) {
 		if ((mask & word) == mask)
 			break;
 	}
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 2999ed5d83f5..0fb05e314edf 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -434,6 +434,8 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 	int rc;
 	int quota_allocation = 0;
 
+	memset(&ea_buf->new_ea, 0, sizeof(ea_buf->new_ea));
+
 	/* When fsck.jfs clears a bad ea, it doesn't clear the size */
 	if (ji->ea.flag == 0)
 		ea_size = 0;
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 32bc88bee5d1..3c7eb43a2ec6 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -408,13 +408,17 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	folio_unlock(folio);
 
 	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
-		if (!fscache_resources_valid(&wreq->cache_resources)) {
+		if (!cache->avail) {
 			trace_netfs_folio(folio, netfs_folio_trace_cancel_copy);
 			netfs_issue_write(wreq, upload);
 			netfs_folio_written_back(folio);
 			return 0;
 		}
 		trace_netfs_folio(folio, netfs_folio_trace_store_copy);
+	} else if (!upload->avail && !cache->avail) {
+		trace_netfs_folio(folio, netfs_folio_trace_cancel_store);
+		netfs_folio_written_back(folio);
+		return 0;
 	} else if (!upload->construct) {
 		trace_netfs_folio(folio, netfs_folio_trace_store);
 	} else {
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 14ec15656320..5cae26917436 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -148,6 +148,7 @@ struct nfsd_net {
 	u32		s2s_cp_cl_id;
 	struct idr	s2s_cp_stateids;
 	spinlock_t	s2s_cp_lock;
+	atomic_t	pending_async_copies;
 
 	/*
 	 * Version information
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2e39cf2e502a..5768b2ff1d1d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -751,15 +751,6 @@ nfsd4_access(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			   &access->ac_supported);
 }
 
-static void gen_boot_verifier(nfs4_verifier *verifier, struct net *net)
-{
-	__be32 *verf = (__be32 *)verifier->data;
-
-	BUILD_BUG_ON(2*sizeof(*verf) != sizeof(verifier->data));
-
-	nfsd_copy_write_verifier(verf, net_generic(net, nfsd_net_id));
-}
-
 static __be32
 nfsd4_commit(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	     union nfsd4_op_u *u)
@@ -1288,6 +1279,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	atomic_dec(&copy->cp_nn->pending_async_copies);
 	kfree(copy->cp_src);
 	kfree(copy);
 }
@@ -1630,7 +1622,6 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 		test_bit(NFSD4_COPY_F_COMMITTED, &copy->cp_flags) ?
 			NFS_FILE_SYNC : NFS_UNSTABLE;
 	nfsd4_copy_set_sync(copy, sync);
-	gen_boot_verifier(&copy->cp_res.wr_verifier, copy->cp_clp->net);
 }
 
 static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy,
@@ -1803,9 +1794,11 @@ static __be32
 nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		union nfsd4_op_u *u)
 {
+	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd4_copy *async_copy = NULL;
 	struct nfsd4_copy *copy = &u->copy;
+	struct nfsd42_write_res *result;
 	__be32 status;
-	struct nfsd4_copy *async_copy = NULL;
 
 	/*
 	 * Currently, async COPY is not reliable. Force all COPY
@@ -1814,6 +1807,9 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 */
 	nfsd4_copy_set_sync(copy, true);
 
+	result = &copy->cp_res;
+	nfsd_copy_write_verifier((__be32 *)&result->wr_verifier.data, nn);
+
 	copy->cp_clp = cstate->clp;
 	if (nfsd4_ssc_is_inter(copy)) {
 		trace_nfsd_copy_inter(copy);
@@ -1838,12 +1834,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
-
-		status = nfserrno(-ENOMEM);
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out_err;
+		async_copy->cp_nn = nn;
+		/* Arbitrary cap on number of pending async copy operations */
+		if (atomic_inc_return(&nn->pending_async_copies) >
+				(int)rqstp->rq_pool->sp_nrthreads) {
+			atomic_dec(&nn->pending_async_copies);
+			goto out_err;
+		}
 		INIT_LIST_HEAD(&async_copy->copies);
 		refcount_set(&async_copy->refcount, 1);
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
@@ -1851,8 +1851,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			goto out_err;
 		if (!nfs4_init_copy_state(nn, copy))
 			goto out_err;
-		memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
-			sizeof(copy->cp_res.cb_stateid));
+		memcpy(&result->cb_stateid, &copy->cp_stateid.cs_stid,
+			sizeof(result->cb_stateid));
 		dup_copy_fields(copy, async_copy);
 		async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
 				async_copy, "%s", "copy thread");
@@ -1883,7 +1883,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (async_copy)
 		cleanup_async_copy(async_copy);
-	status = nfserrno(-ENOMEM);
+	status = nfserr_jukebox;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fe06779ea527..3837f4e41724 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1077,7 +1077,8 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
  * When a delegation is recalled, the filehandle is stored in the "new"
  * filter.
  * Every 30 seconds we swap the filters and clear the "new" one,
- * unless both are empty of course.
+ * unless both are empty of course.  This results in delegations for a
+ * given filehandle being blocked for between 30 and 60 seconds.
  *
  * Each filter is 256 bits.  We hash the filehandle to 32bit and use the
  * low 3 bytes as hash-table indices.
@@ -1106,9 +1107,9 @@ static int delegation_blocked(struct knfsd_fh *fh)
 		if (ktime_get_seconds() - bd->swap_time > 30) {
 			bd->entries -= bd->old_entries;
 			bd->old_entries = bd->entries;
+			bd->new = 1-bd->new;
 			memset(bd->set[bd->new], 0,
 			       sizeof(bd->set[0]));
-			bd->new = 1-bd->new;
 			bd->swap_time = ktime_get_seconds();
 		}
 		spin_unlock(&blocked_delegations_lock);
@@ -8574,6 +8575,7 @@ static int nfs4_state_create_net(struct net *net)
 	spin_lock_init(&nn->client_lock);
 	spin_lock_init(&nn->s2s_cp_lock);
 	idr_init(&nn->s2s_cp_stateids);
+	atomic_set(&nn->pending_async_copies, 0);
 
 	spin_lock_init(&nn->blocked_locks_lock);
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 0869062280cc..2ad083d71a03 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1245,14 +1245,6 @@ nfsd4_decode_putfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	return nfs_ok;
 }
 
-static __be32
-nfsd4_decode_putpubfh(struct nfsd4_compoundargs *argp, union nfsd4_op_u *p)
-{
-	if (argp->minorversion == 0)
-		return nfs_ok;
-	return nfserr_notsupp;
-}
-
 static __be32
 nfsd4_decode_read(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 {
@@ -2374,7 +2366,7 @@ static const nfsd4_dec nfsd4_dec_ops[] = {
 	[OP_OPEN_CONFIRM]	= nfsd4_decode_open_confirm,
 	[OP_OPEN_DOWNGRADE]	= nfsd4_decode_open_downgrade,
 	[OP_PUTFH]		= nfsd4_decode_putfh,
-	[OP_PUTPUBFH]		= nfsd4_decode_putpubfh,
+	[OP_PUTPUBFH]		= nfsd4_decode_noop,
 	[OP_PUTROOTFH]		= nfsd4_decode_noop,
 	[OP_READ]		= nfsd4_decode_read,
 	[OP_READDIR]		= nfsd4_decode_readdir,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 0f9b4f7b56cd..37f619ccafce 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1746,7 +1746,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
 
 			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
-					  atomic_read(&sp->sp_nrthreads));
+					  sp->sp_nrthreads);
 			if (err)
 				goto err_unlock;
 		}
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 89d7918de7b1..877f92635654 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -705,7 +705,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 
 	if (serv)
 		for (i = 0; i < serv->sv_nrpools && i < n; i++)
-			nthreads[i] = atomic_read(&serv->sv_pools[i].sp_nrthreads);
+			nthreads[i] = serv->sv_pools[i].sp_nrthreads;
 	return 0;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29b1f3613800..911e5e0a17af 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -100,6 +100,7 @@ nfserrno (int errno)
 		{ nfserr_io, -EUCLEAN },
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
+		{ nfserr_io, -EBADMSG },
 	};
 	int	i;
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index fbdd42cde1fa..2a21a7662e03 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -713,6 +713,7 @@ struct nfsd4_copy {
 	struct nfsd4_ssc_umount_item *ss_nsui;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
+	struct nfsd_net		*cp_nn;
 };
 
 static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 6be175a1ab3c..75991db2343e 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -156,9 +156,8 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
 	err = ocfs2_extent_map_get_blocks(inode, iblock, &p_blkno, &count,
 					  &ext_flags);
 	if (err) {
-		mlog(ML_ERROR, "Error %d from get_blocks(0x%p, %llu, 1, "
-		     "%llu, NULL)\n", err, inode, (unsigned long long)iblock,
-		     (unsigned long long)p_blkno);
+		mlog(ML_ERROR, "get_blocks() failed, inode: 0x%p, "
+		     "block: %llu\n", inode, (unsigned long long)iblock);
 		goto bail;
 	}
 
diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index cdb9b9bdea1f..8f714406528d 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -235,7 +235,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		if (bhs[i] == NULL) {
 			bhs[i] = sb_getblk(sb, block++);
 			if (bhs[i] == NULL) {
-				ocfs2_metadata_cache_io_unlock(ci);
 				status = -ENOMEM;
 				mlog_errno(status);
 				/* Don't forget to put previous bh! */
@@ -389,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		/* Always set the buffer in the cache, even if it was
 		 * a forced read, or read-ahead which hasn't yet
 		 * completed. */
-		ocfs2_set_buffer_uptodate(ci, bh);
+		if (bh)
+			ocfs2_set_buffer_uptodate(ci, bh);
 	}
 	ocfs2_metadata_cache_io_unlock(ci);
 
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 530fba34f6d3..1bf188b6866a 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1055,7 +1055,7 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 	if (!igrab(inode))
 		BUG();
 
-	num_running_trans = atomic_read(&(osb->journal->j_num_trans));
+	num_running_trans = atomic_read(&(journal->j_num_trans));
 	trace_ocfs2_journal_shutdown(num_running_trans);
 
 	/* Do a commit_cache here. It will flush our journal, *and*
@@ -1074,9 +1074,10 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 		osb->commit_task = NULL;
 	}
 
-	BUG_ON(atomic_read(&(osb->journal->j_num_trans)) != 0);
+	BUG_ON(atomic_read(&(journal->j_num_trans)) != 0);
 
-	if (ocfs2_mount_local(osb)) {
+	if (ocfs2_mount_local(osb) &&
+	    (journal->j_journal->j_flags & JBD2_LOADED)) {
 		jbd2_journal_lock_updates(journal->j_journal);
 		status = jbd2_journal_flush(journal->j_journal, 0);
 		jbd2_journal_unlock_updates(journal->j_journal);
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 5df34561c551..8ac42ea81a17 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -1002,6 +1002,25 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 		start = bit_off + 1;
 	}
 
+	/* clear the contiguous bits until the end boundary */
+	if (count) {
+		blkno = la_start_blk +
+			ocfs2_clusters_to_blocks(osb->sb,
+					start - count);
+
+		trace_ocfs2_sync_local_to_main_free(
+				count, start - count,
+				(unsigned long long)la_start_blk,
+				(unsigned long long)blkno);
+
+		status = ocfs2_release_clusters(handle,
+				main_bm_inode,
+				main_bm_bh, blkno,
+				count);
+		if (status < 0)
+			mlog_errno(status);
+	}
+
 bail:
 	if (status)
 		mlog_errno(status);
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 8ce462c64c51..73d3367c533b 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -692,7 +692,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	int status;
 	struct buffer_head *bh = NULL;
 	struct ocfs2_quota_recovery *rec;
-	int locked = 0;
+	int locked = 0, global_read = 0;
 
 	info->dqi_max_spc_limit = 0x7fffffffffffffffLL;
 	info->dqi_max_ino_limit = 0x7fffffffffffffffLL;
@@ -700,6 +700,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	if (!oinfo) {
 		mlog(ML_ERROR, "failed to allocate memory for ocfs2 quota"
 			       " info.");
+		status = -ENOMEM;
 		goto out_err;
 	}
 	info->dqi_priv = oinfo;
@@ -712,6 +713,7 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 	status = ocfs2_global_read_info(sb, type);
 	if (status < 0)
 		goto out_err;
+	global_read = 1;
 
 	status = ocfs2_inode_lock(lqinode, &oinfo->dqi_lqi_bh, 1);
 	if (status < 0) {
@@ -782,10 +784,12 @@ static int ocfs2_local_read_info(struct super_block *sb, int type)
 		if (locked)
 			ocfs2_inode_unlock(lqinode, 1);
 		ocfs2_release_local_quota_bitmaps(&oinfo->dqi_chunk);
+		if (global_read)
+			cancel_delayed_work_sync(&oinfo->dqi_sync_work);
 		kfree(oinfo);
 	}
 	brelse(bh);
-	return -1;
+	return status;
 }
 
 /* Write local info to quota file */
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 1f303b1adf1a..53a0961f114d 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -25,6 +25,7 @@
 #include "namei.h"
 #include "ocfs2_trace.h"
 #include "file.h"
+#include "symlink.h"
 
 #include <linux/bio.h>
 #include <linux/blkdev.h>
@@ -4155,8 +4156,9 @@ static int __ocfs2_reflink(struct dentry *old_dentry,
 	int ret;
 	struct inode *inode = d_inode(old_dentry);
 	struct buffer_head *new_bh = NULL;
+	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 
-	if (OCFS2_I(inode)->ip_flags & OCFS2_INODE_SYSTEM_FILE) {
+	if (oi->ip_flags & OCFS2_INODE_SYSTEM_FILE) {
 		ret = -EINVAL;
 		mlog_errno(ret);
 		goto out;
@@ -4182,6 +4184,26 @@ static int __ocfs2_reflink(struct dentry *old_dentry,
 		goto out_unlock;
 	}
 
+	if ((oi->ip_dyn_features & OCFS2_HAS_XATTR_FL) &&
+	    (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL)) {
+		/*
+		 * Adjust extent record count to reserve space for extended attribute.
+		 * Inline data count had been adjusted in ocfs2_duplicate_inline_data().
+		 */
+		struct ocfs2_inode_info *new_oi = OCFS2_I(new_inode);
+
+		if (!(new_oi->ip_dyn_features & OCFS2_INLINE_DATA_FL) &&
+		    !(ocfs2_inode_is_fast_symlink(new_inode))) {
+			struct ocfs2_dinode *new_di = (struct ocfs2_dinode *)new_bh->b_data;
+			struct ocfs2_dinode *old_di = (struct ocfs2_dinode *)old_bh->b_data;
+			struct ocfs2_extent_list *el = &new_di->id2.i_list;
+			int inline_size = le16_to_cpu(old_di->i_xattr_inline_size);
+
+			le16_add_cpu(&el->l_count, -(inline_size /
+					sizeof(struct ocfs2_extent_rec)));
+		}
+	}
+
 	ret = ocfs2_create_reflink_node(inode, old_bh,
 					new_inode, new_bh, preserve);
 	if (ret) {
@@ -4189,7 +4211,7 @@ static int __ocfs2_reflink(struct dentry *old_dentry,
 		goto inode_unlock;
 	}
 
-	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_HAS_XATTR_FL) {
+	if (oi->ip_dyn_features & OCFS2_HAS_XATTR_FL) {
 		ret = ocfs2_reflink_xattrs(inode, old_bh,
 					   new_inode, new_bh,
 					   preserve);
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 35c0cc2a51af..fb1140c52f07 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -6520,16 +6520,7 @@ static int ocfs2_reflink_xattr_inline(struct ocfs2_xattr_reflink *args)
 	}
 
 	new_oi = OCFS2_I(args->new_inode);
-	/*
-	 * Adjust extent record count to reserve space for extended attribute.
-	 * Inline data count had been adjusted in ocfs2_duplicate_inline_data().
-	 */
-	if (!(new_oi->ip_dyn_features & OCFS2_INLINE_DATA_FL) &&
-	    !(ocfs2_inode_is_fast_symlink(args->new_inode))) {
-		struct ocfs2_extent_list *el = &new_di->id2.i_list;
-		le16_add_cpu(&el->l_count, -(inline_size /
-					sizeof(struct ocfs2_extent_rec)));
-	}
+
 	spin_lock(&new_oi->ip_lock);
 	new_oi->ip_dyn_features |= OCFS2_HAS_XATTR_FL | OCFS2_INLINE_XATTR_FL;
 	new_di->i_dyn_features = cpu_to_le16(new_oi->ip_dyn_features);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index a5ef2005a2cc..051a802893a1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -243,8 +243,24 @@ static int ovl_verify_area(loff_t pos, loff_t pos2, loff_t len, loff_t totlen)
 	return 0;
 }
 
+static int ovl_sync_file(struct path *path)
+{
+	struct file *new_file;
+	int err;
+
+	new_file = ovl_path_open(path, O_LARGEFILE | O_RDONLY);
+	if (IS_ERR(new_file))
+		return PTR_ERR(new_file);
+
+	err = vfs_fsync(new_file, 0);
+	fput(new_file);
+
+	return err;
+}
+
 static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
-			    struct file *new_file, loff_t len)
+			    struct file *new_file, loff_t len,
+			    bool datasync)
 {
 	struct path datapath;
 	struct file *old_file;
@@ -342,7 +358,8 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 
 		len -= bytes;
 	}
-	if (!error && ovl_should_sync(ofs))
+	/* call fsync once, either now or later along with metadata */
+	if (!error && ovl_should_sync(ofs) && datasync)
 		error = vfs_fsync(new_file, 0);
 out_fput:
 	fput(old_file);
@@ -574,6 +591,7 @@ struct ovl_copy_up_ctx {
 	bool indexed;
 	bool metacopy;
 	bool metacopy_digest;
+	bool metadata_fsync;
 };
 
 static int ovl_link_up(struct ovl_copy_up_ctx *c)
@@ -634,7 +652,8 @@ static int ovl_copy_up_data(struct ovl_copy_up_ctx *c, const struct path *temp)
 	if (IS_ERR(new_file))
 		return PTR_ERR(new_file);
 
-	err = ovl_copy_up_file(ofs, c->dentry, new_file, c->stat.size);
+	err = ovl_copy_up_file(ofs, c->dentry, new_file, c->stat.size,
+			       !c->metadata_fsync);
 	fput(new_file);
 
 	return err;
@@ -701,6 +720,10 @@ static int ovl_copy_up_metadata(struct ovl_copy_up_ctx *c, struct dentry *temp)
 		err = ovl_set_attr(ofs, temp, &c->stat);
 	inode_unlock(temp->d_inode);
 
+	/* fsync metadata before moving it into upper dir */
+	if (!err && ovl_should_sync(ofs) && c->metadata_fsync)
+		err = ovl_sync_file(&upperpath);
+
 	return err;
 }
 
@@ -860,7 +883,8 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	temp = tmpfile->f_path.dentry;
 	if (!c->metacopy && c->stat.size) {
-		err = ovl_copy_up_file(ofs, c->dentry, tmpfile, c->stat.size);
+		err = ovl_copy_up_file(ofs, c->dentry, tmpfile, c->stat.size,
+				       !c->metadata_fsync);
 		if (err)
 			goto out_fput;
 	}
@@ -1135,6 +1159,17 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 	    !kgid_has_mapping(current_user_ns(), ctx.stat.gid))
 		return -EOVERFLOW;
 
+	/*
+	 * With metacopy disabled, we fsync after final metadata copyup, for
+	 * both regular files and directories to get atomic copyup semantics
+	 * on filesystems that do not use strict metadata ordering (e.g. ubifs).
+	 *
+	 * With metacopy enabled we want to avoid fsync on all meta copyup
+	 * that will hurt performance of workloads such as chown -R, so we
+	 * only fsync on data copyup as legacy behavior.
+	 */
+	ctx.metadata_fsync = !OVL_FS(dentry->d_sb)->config.metacopy &&
+			     (S_ISREG(ctx.stat.mode) || S_ISDIR(ctx.stat.mode));
 	ctx.metacopy = ovl_need_meta_copy_up(dentry, ctx.stat.mode, flags);
 
 	if (parent) {
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 4860fcc4611b..f9e3d139c07e 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -782,11 +782,6 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 {
 	struct ovl_opt_set set = ctx->set;
 
-	if (ctx->nr_data > 0 && !config->metacopy) {
-		pr_err("lower data-only dirs require metacopy support.\n");
-		return -EINVAL;
-	}
-
 	/* Workdir/index are useless in non-upper mount */
 	if (!config->upperdir) {
 		if (config->workdir) {
@@ -938,6 +933,39 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 		config->metacopy = false;
 	}
 
+	/*
+	 * Fail if we don't have trusted xattr capability and a feature was
+	 * explicitly requested that requires them.
+	 */
+	if (!config->userxattr && !capable(CAP_SYS_ADMIN)) {
+		if (set.redirect &&
+		    config->redirect_mode != OVL_REDIRECT_NOFOLLOW) {
+			pr_err("redirect_dir requires permission to access trusted xattrs\n");
+			return -EPERM;
+		}
+		if (config->metacopy && set.metacopy) {
+			pr_err("metacopy requires permission to access trusted xattrs\n");
+			return -EPERM;
+		}
+		if (config->verity_mode) {
+			pr_err("verity requires permission to access trusted xattrs\n");
+			return -EPERM;
+		}
+		if (ctx->nr_data > 0) {
+			pr_err("lower data-only dirs require permission to access trusted xattrs\n");
+			return -EPERM;
+		}
+		/*
+		 * Other xattr-dependent features should be disabled without
+		 * great disturbance to the user in ovl_make_workdir().
+		 */
+	}
+
+	if (ctx->nr_data > 0 && !config->metacopy) {
+		pr_err("lower data-only dirs require metacopy support.\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..f389c69767fa 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -85,6 +85,7 @@
 #include <linux/elf.h>
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
+#include <linux/fs_parser.h>
 #include <linux/fs_struct.h>
 #include <linux/slab.h>
 #include <linux/sched/autogroup.h>
@@ -117,6 +118,40 @@
 static u8 nlink_tid __ro_after_init;
 static u8 nlink_tgid __ro_after_init;
 
+enum proc_mem_force {
+	PROC_MEM_FORCE_ALWAYS,
+	PROC_MEM_FORCE_PTRACE,
+	PROC_MEM_FORCE_NEVER
+};
+
+static enum proc_mem_force proc_mem_force_override __ro_after_init =
+	IS_ENABLED(CONFIG_PROC_MEM_NO_FORCE) ? PROC_MEM_FORCE_NEVER :
+	IS_ENABLED(CONFIG_PROC_MEM_FORCE_PTRACE) ? PROC_MEM_FORCE_PTRACE :
+	PROC_MEM_FORCE_ALWAYS;
+
+static const struct constant_table proc_mem_force_table[] __initconst = {
+	{ "always", PROC_MEM_FORCE_ALWAYS },
+	{ "ptrace", PROC_MEM_FORCE_PTRACE },
+	{ "never", PROC_MEM_FORCE_NEVER },
+	{ }
+};
+
+static int __init early_proc_mem_force_override(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	/*
+	 * lookup_constant() defaults to proc_mem_force_override to preseve
+	 * the initial Kconfig choice in case an invalid param gets passed.
+	 */
+	proc_mem_force_override = lookup_constant(proc_mem_force_table,
+						  buf, proc_mem_force_override);
+
+	return 0;
+}
+early_param("proc_mem.force_override", early_proc_mem_force_override);
+
 struct pid_entry {
 	const char *name;
 	unsigned int len;
@@ -835,6 +870,28 @@ static int mem_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
+{
+	struct task_struct *task;
+	bool ptrace_active = false;
+
+	switch (proc_mem_force_override) {
+	case PROC_MEM_FORCE_NEVER:
+		return false;
+	case PROC_MEM_FORCE_PTRACE:
+		task = get_proc_task(file_inode(file));
+		if (task) {
+			ptrace_active =	READ_ONCE(task->ptrace) &&
+					READ_ONCE(task->mm) == mm &&
+					READ_ONCE(task->parent) == current;
+			put_task_struct(task);
+		}
+		return ptrace_active;
+	default:
+		return true;
+	}
+}
+
 static ssize_t mem_rw(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos, int write)
 {
@@ -855,7 +912,9 @@ static ssize_t mem_rw(struct file *file, char __user *buf,
 	if (!mmget_not_zero(mm))
 		goto free;
 
-	flags = FOLL_FORCE | (write ? FOLL_WRITE : 0);
+	flags = write ? FOLL_WRITE : 0;
+	if (proc_mem_foll_force(file, mm))
+		flags |= FOLL_FORCE;
 
 	while (count > 0) {
 		size_t this_len = min_t(size_t, count, PAGE_SIZE);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index dd7b462387a0..0101f8bcb4f6 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -29,8 +29,13 @@ static const struct inode_operations proc_sys_inode_operations;
 static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
-/* Support for permanently empty directories */
-static struct ctl_table sysctl_mount_point[] = { };
+/*
+ * Support for permanently empty directories.
+ * Must be non-empty to avoid sharing an address with other tables.
+ */
+static struct ctl_table sysctl_mount_point[] = {
+	{ }
+};
 
 /**
  * register_sysctl_mount_point() - registers a sysctl mount point
@@ -42,7 +47,7 @@ static struct ctl_table sysctl_mount_point[] = { };
  */
 struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
-	return register_sysctl(path, sysctl_mount_point);
+	return register_sysctl_sz(path, sysctl_mount_point, 0);
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index a1acf5bd1e3a..5955e265b395 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -313,8 +313,17 @@ cifs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct TCP_Server_Info *server = tcon->ses->server;
 	unsigned int xid;
 	int rc = 0;
+	const char *full_path;
+	void *page;
 
 	xid = get_xid();
+	page = alloc_dentry_path();
+
+	full_path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
+		goto statfs_out;
+	}
 
 	if (le32_to_cpu(tcon->fsAttrInfo.MaxPathNameComponentLength) > 0)
 		buf->f_namelen =
@@ -330,8 +339,10 @@ cifs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_ffree = 0;	/* unlimited */
 
 	if (server->ops->queryfs)
-		rc = server->ops->queryfs(xid, tcon, cifs_sb, buf);
+		rc = server->ops->queryfs(xid, tcon, full_path, cifs_sb, buf);
 
+statfs_out:
+	free_dentry_path(page);
 	free_xid(xid);
 	return rc;
 }
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 552792f28122..0ac026cec830 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -482,7 +482,7 @@ struct smb_version_operations {
 			__u16 net_fid, struct cifsInodeInfo *cifs_inode);
 	/* query remote filesystem */
 	int (*queryfs)(const unsigned int, struct cifs_tcon *,
-		       struct cifs_sb_info *, struct kstatfs *);
+		       const char *, struct cifs_sb_info *, struct kstatfs *);
 	/* send mandatory brlock to the server */
 	int (*mand_lock)(const unsigned int, struct cifsFileInfo *, __u64,
 			 __u64, __u32, int, int, bool);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 73e2e6c230b7..54579a2003ac 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -800,10 +800,6 @@ static void cifs_open_info_to_fattr(struct cifs_fattr *fattr,
 		fattr->cf_mode = S_IFREG | cifs_sb->ctx->file_mode;
 		fattr->cf_dtype = DT_REG;
 
-		/* clear write bits if ATTR_READONLY is set */
-		if (fattr->cf_cifsattrs & ATTR_READONLY)
-			fattr->cf_mode &= ~(S_IWUGO);
-
 		/*
 		 * Don't accept zero nlink from non-unix servers unless
 		 * delete is pending.  Instead mark it as unknown.
@@ -816,6 +812,10 @@ static void cifs_open_info_to_fattr(struct cifs_fattr *fattr,
 		}
 	}
 
+	/* clear write bits if ATTR_READONLY is set */
+	if (fattr->cf_cifsattrs & ATTR_READONLY)
+		fattr->cf_mode &= ~(S_IWUGO);
+
 out_reparse:
 	if (S_ISLNK(fattr->cf_mode)) {
 		if (likely(data->symlink_target))
@@ -1233,11 +1233,14 @@ static int cifs_get_fattr(struct cifs_open_info_data *data,
 				 __func__, rc);
 			goto out;
 		}
-	}
-
-	/* fill in remaining high mode bits e.g. SUID, VTX */
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL)
+	} else if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL)
+		/* fill in remaining high mode bits e.g. SUID, VTX */
 		cifs_sfu_mode(fattr, full_path, cifs_sb, xid);
+	else if (!(tcon->posix_extensions))
+		/* clear write bits if ATTR_READONLY is set */
+		if (fattr->cf_cifsattrs & ATTR_READONLY)
+			fattr->cf_mode &= ~(S_IWUGO);
+
 
 	/* check for Minshall+French symlinks */
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MF_SYMLINKS) {
diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index 48c27581ec51..ad0e0de9a165 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -320,15 +320,21 @@ static int parse_reparse_posix(struct reparse_posix_data *buf,
 	unsigned int len;
 	u64 type;
 
+	len = le16_to_cpu(buf->ReparseDataLength);
+	if (len < sizeof(buf->InodeType)) {
+		cifs_dbg(VFS, "srv returned malformed nfs buffer\n");
+		return -EIO;
+	}
+
+	len -= sizeof(buf->InodeType);
+
 	switch ((type = le64_to_cpu(buf->InodeType))) {
 	case NFS_SPECFILE_LNK:
-		len = le16_to_cpu(buf->ReparseDataLength);
 		data->symlink_target = cifs_strndup_from_utf16(buf->DataBuffer,
 							       len, true,
 							       cifs_sb->local_nls);
 		if (!data->symlink_target)
 			return -ENOMEM;
-		convert_delimiter(data->symlink_target, '/');
 		cifs_dbg(FYI, "%s: target path: %s\n",
 			 __func__, data->symlink_target);
 		break;
@@ -482,12 +488,18 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 	u32 tag = data->reparse.tag;
 
 	if (tag == IO_REPARSE_TAG_NFS && buf) {
+		if (le16_to_cpu(buf->ReparseDataLength) < sizeof(buf->InodeType))
+			return false;
 		switch (le64_to_cpu(buf->InodeType)) {
 		case NFS_SPECFILE_CHR:
+			if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8)
+				return false;
 			fattr->cf_mode |= S_IFCHR;
 			fattr->cf_rdev = reparse_nfs_mkdev(buf);
 			break;
 		case NFS_SPECFILE_BLK:
+			if (le16_to_cpu(buf->ReparseDataLength) != sizeof(buf->InodeType) + 8)
+				return false;
 			fattr->cf_mode |= S_IFBLK;
 			fattr->cf_rdev = reparse_nfs_mkdev(buf);
 			break;
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index e1f2feb56f45..8c03250d85ae 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -909,7 +909,7 @@ cifs_oplock_response(struct cifs_tcon *tcon, __u64 persistent_fid,
 
 static int
 cifs_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	     const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	int rc = -EOPNOTSUPP;
 
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 11a1c53c64e0..a6dab60e2c01 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1205,9 +1205,12 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsFileInfo *cfile;
 	struct inode *new = NULL;
+	int out_buftype[4] = {};
+	struct kvec out_iov[4] = {};
 	struct kvec in_iov[2];
 	int cmds[2];
 	int rc;
+	int i;
 
 	oparms = CIFS_OPARMS(cifs_sb, tcon, full_path,
 			     SYNCHRONIZE | DELETE |
@@ -1228,7 +1231,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cmds[1] = SMB2_OP_POSIX_QUERY_INFO;
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path, &oparms,
-				      in_iov, cmds, 2, cfile, NULL, NULL, NULL);
+				      in_iov, cmds, 2, cfile, out_iov, out_buftype, NULL);
 		if (!rc) {
 			rc = smb311_posix_get_inode_info(&new, full_path,
 							 data, sb, xid);
@@ -1237,12 +1240,29 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cmds[1] = SMB2_OP_QUERY_INFO;
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path, &oparms,
-				      in_iov, cmds, 2, cfile, NULL, NULL, NULL);
+				      in_iov, cmds, 2, cfile, out_iov, out_buftype, NULL);
 		if (!rc) {
 			rc = cifs_get_inode_info(&new, full_path,
 						 data, sb, xid, NULL);
 		}
 	}
+
+
+	/*
+	 * If CREATE was successful but SMB2_OP_SET_REPARSE failed then
+	 * remove the intermediate object created by CREATE. Otherwise
+	 * empty object stay on the server when reparse call failed.
+	 */
+	if (rc &&
+	    out_iov[0].iov_base != NULL && out_buftype[0] != CIFS_NO_BUFFER &&
+	    ((struct smb2_hdr *)out_iov[0].iov_base)->Status == STATUS_SUCCESS &&
+	    (out_iov[1].iov_base == NULL || out_buftype[1] == CIFS_NO_BUFFER ||
+	     ((struct smb2_hdr *)out_iov[1].iov_base)->Status != STATUS_SUCCESS))
+		smb2_unlink(xid, tcon, full_path, cifs_sb, NULL);
+
+	for (i = 0; i < ARRAY_SIZE(out_buftype); i++)
+		free_rsp_buf(out_buftype[i], out_iov[i].iov_base);
+
 	return rc ? ERR_PTR(rc) : new;
 }
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1d6e8eacdd74..7ea02619e673 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2816,7 +2816,7 @@ smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
 
 static int
 smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	     const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	struct smb2_query_info_rsp *rsp;
 	struct smb2_fs_full_size_info *info = NULL;
@@ -2825,7 +2825,7 @@ smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc;
 
 
-	rc = smb2_query_info_compound(xid, tcon, "",
+	rc = smb2_query_info_compound(xid, tcon, path,
 				      FILE_READ_ATTRIBUTES,
 				      FS_FULL_SIZE_INFORMATION,
 				      SMB2_O_INFO_FILESYSTEM,
@@ -2853,28 +2853,33 @@ smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 
 static int
 smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	       struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	       const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	int rc;
-	__le16 srch_path = 0; /* Null - open root of share */
+	__le16 *utf16_path = NULL;
 	u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
 	struct cifs_open_parms oparms;
 	struct cifs_fid fid;
 
 	if (!tcon->posix_extensions)
-		return smb2_queryfs(xid, tcon, cifs_sb, buf);
+		return smb2_queryfs(xid, tcon, path, cifs_sb, buf);
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
-		.path = "",
+		.path = path,
 		.desired_access = FILE_READ_ATTRIBUTES,
 		.disposition = FILE_OPEN,
 		.create_options = cifs_create_options(cifs_sb, 0),
 		.fid = &fid,
 	};
 
-	rc = SMB2_open(xid, &oparms, &srch_path, &oplock, NULL, NULL,
+	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
+	if (utf16_path == NULL)
+		return -ENOMEM;
+
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL,
 		       NULL, NULL);
+	kfree(utf16_path);
 	if (rc)
 		return rc;
 
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 7889df8112b4..cac80e7bfefc 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -39,7 +39,8 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
-	kfree(conn);
+	if (atomic_dec_and_test(&conn->refcnt))
+		kfree(conn);
 }
 
 /**
@@ -68,6 +69,7 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 		conn->um = NULL;
 	atomic_set(&conn->req_running, 0);
 	atomic_set(&conn->r_count, 0);
+	atomic_set(&conn->refcnt, 1);
 	conn->total_credits = 1;
 	conn->outstanding_credits = 0;
 
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index b93e5437793e..82343afc8d04 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -106,6 +106,7 @@ struct ksmbd_conn {
 	bool				signing_negotiated;
 	__le16				signing_algorithm;
 	bool				binding;
+	atomic_t			refcnt;
 };
 
 struct ksmbd_conn_ops {
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index e546ffa57b55..8ee86478287f 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -51,6 +51,7 @@ static struct oplock_info *alloc_opinfo(struct ksmbd_work *work,
 	init_waitqueue_head(&opinfo->oplock_brk);
 	atomic_set(&opinfo->refcount, 1);
 	atomic_set(&opinfo->breaking_cnt, 0);
+	atomic_inc(&opinfo->conn->refcnt);
 
 	return opinfo;
 }
@@ -124,6 +125,8 @@ static void free_opinfo(struct oplock_info *opinfo)
 {
 	if (opinfo->is_lease)
 		free_lease(opinfo);
+	if (opinfo->conn && atomic_dec_and_test(&opinfo->conn->refcnt))
+		kfree(opinfo->conn);
 	kfree(opinfo);
 }
 
@@ -163,9 +166,7 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 		    !atomic_inc_not_zero(&opinfo->refcount))
 			opinfo = NULL;
 		else {
-			atomic_inc(&opinfo->conn->r_count);
 			if (ksmbd_conn_releasing(opinfo->conn)) {
-				atomic_dec(&opinfo->conn->r_count);
 				atomic_dec(&opinfo->refcount);
 				opinfo = NULL;
 			}
@@ -177,26 +178,11 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 	return opinfo;
 }
 
-static void opinfo_conn_put(struct oplock_info *opinfo)
+void opinfo_put(struct oplock_info *opinfo)
 {
-	struct ksmbd_conn *conn;
-
 	if (!opinfo)
 		return;
 
-	conn = opinfo->conn;
-	/*
-	 * Checking waitqueue to dropping pending requests on
-	 * disconnection. waitqueue_active is safe because it
-	 * uses atomic operation for condition.
-	 */
-	if (!atomic_dec_return(&conn->r_count) && waitqueue_active(&conn->r_count_q))
-		wake_up(&conn->r_count_q);
-	opinfo_put(opinfo);
-}
-
-void opinfo_put(struct oplock_info *opinfo)
-{
 	if (!atomic_dec_and_test(&opinfo->refcount))
 		return;
 
@@ -1127,14 +1113,11 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 			if (!atomic_inc_not_zero(&opinfo->refcount))
 				continue;
 
-			atomic_inc(&opinfo->conn->r_count);
-			if (ksmbd_conn_releasing(opinfo->conn)) {
-				atomic_dec(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn))
 				continue;
-			}
 
 			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
-			opinfo_conn_put(opinfo);
+			opinfo_put(opinfo);
 		}
 	}
 	up_read(&p_ci->m_lock);
@@ -1167,13 +1150,10 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 			if (!atomic_inc_not_zero(&opinfo->refcount))
 				continue;
 
-			atomic_inc(&opinfo->conn->r_count);
-			if (ksmbd_conn_releasing(opinfo->conn)) {
-				atomic_dec(&opinfo->conn->r_count);
+			if (ksmbd_conn_releasing(opinfo->conn))
 				continue;
-			}
 			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE);
-			opinfo_conn_put(opinfo);
+			opinfo_put(opinfo);
 		}
 	}
 	up_read(&p_ci->m_lock);
@@ -1252,7 +1232,7 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	prev_opinfo = opinfo_get_list(ci);
 	if (!prev_opinfo ||
 	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx)) {
-		opinfo_conn_put(prev_opinfo);
+		opinfo_put(prev_opinfo);
 		goto set_lev;
 	}
 	prev_op_has_lease = prev_opinfo->is_lease;
@@ -1262,19 +1242,19 @@ int smb_grant_oplock(struct ksmbd_work *work, int req_op_level, u64 pid,
 	if (share_ret < 0 &&
 	    prev_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
 		err = share_ret;
-		opinfo_conn_put(prev_opinfo);
+		opinfo_put(prev_opinfo);
 		goto err_out;
 	}
 
 	if (prev_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    prev_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_conn_put(prev_opinfo);
+		opinfo_put(prev_opinfo);
 		goto op_break_not_needed;
 	}
 
 	list_add(&work->interim_entry, &prev_opinfo->interim_list);
 	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_conn_put(prev_opinfo);
+	opinfo_put(prev_opinfo);
 	if (err == -ENOENT)
 		goto set_lev;
 	/* Check all oplock was freed by close */
@@ -1337,14 +1317,14 @@ static void smb_break_all_write_oplock(struct ksmbd_work *work,
 		return;
 	if (brk_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
 	    brk_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
-		opinfo_conn_put(brk_opinfo);
+		opinfo_put(brk_opinfo);
 		return;
 	}
 
 	brk_opinfo->open_trunc = is_trunc;
 	list_add(&work->interim_entry, &brk_opinfo->interim_list);
 	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II);
-	opinfo_conn_put(brk_opinfo);
+	opinfo_put(brk_opinfo);
 }
 
 /**
@@ -1376,11 +1356,8 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (!atomic_inc_not_zero(&brk_op->refcount))
 			continue;
 
-		atomic_inc(&brk_op->conn->r_count);
-		if (ksmbd_conn_releasing(brk_op->conn)) {
-			atomic_dec(&brk_op->conn->r_count);
+		if (ksmbd_conn_releasing(brk_op->conn))
 			continue;
-		}
 
 		rcu_read_unlock();
 		if (brk_op->is_lease && (brk_op->o_lease->state &
@@ -1411,7 +1388,7 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 		brk_op->open_trunc = is_trunc;
 		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE);
 next:
-		opinfo_conn_put(brk_op);
+		opinfo_put(brk_op);
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 8b2e37c8716e..271a23abc82f 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -710,6 +710,8 @@ static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry) {
 		if (op->conn != conn)
 			continue;
+		if (op->conn && atomic_dec_and_test(&op->conn->refcnt))
+			kfree(op->conn);
 		op->conn = NULL;
 	}
 	up_write(&ci->m_lock);
@@ -807,6 +809,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 		if (op->conn)
 			continue;
 		op->conn = fp->conn;
+		atomic_inc(&op->conn->refcnt);
 	}
 	up_write(&ci->m_lock);
 
diff --git a/include/crypto/internal/simd.h b/include/crypto/internal/simd.h
index d2316242a988..be97b97a75dd 100644
--- a/include/crypto/internal/simd.h
+++ b/include/crypto/internal/simd.h
@@ -14,11 +14,10 @@
 struct simd_skcipher_alg;
 struct skcipher_alg;
 
-struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
+struct simd_skcipher_alg *simd_skcipher_create_compat(struct skcipher_alg *ialg,
+						      const char *algname,
 						      const char *drvname,
 						      const char *basename);
-struct simd_skcipher_alg *simd_skcipher_create(const char *algname,
-					       const char *basename);
 void simd_skcipher_free(struct simd_skcipher_alg *alg);
 
 int simd_register_skciphers_compat(struct skcipher_alg *algs, int count,
@@ -32,13 +31,6 @@ void simd_unregister_skciphers(struct skcipher_alg *algs, int count,
 struct simd_aead_alg;
 struct aead_alg;
 
-struct simd_aead_alg *simd_aead_create_compat(const char *algname,
-					      const char *drvname,
-					      const char *basename);
-struct simd_aead_alg *simd_aead_create(const char *algname,
-				       const char *basename);
-void simd_aead_free(struct simd_aead_alg *alg);
-
 int simd_register_aeads_compat(struct aead_alg *algs, int count,
 			       struct simd_aead_alg **simd_algs);
 
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 089950ad8681..8fad7d09beda 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -220,7 +220,8 @@ drm_vprintf(struct drm_printer *p, const char *fmt, va_list *va)
 
 /**
  * struct drm_print_iterator - local struct used with drm_printer_coredump
- * @data: Pointer to the devcoredump output buffer
+ * @data: Pointer to the devcoredump output buffer, can be NULL if using
+ * drm_printer_coredump to determine size of devcoredump
  * @start: The offset within the buffer to start writing
  * @remain: The number of bytes to write for this iteration
  */
@@ -265,6 +266,57 @@ struct drm_print_iterator {
  *			coredump_read, ...)
  *	}
  *
+ * The above example has a time complexity of O(N^2), where N is the size of the
+ * devcoredump. This is acceptable for small devcoredumps but scales poorly for
+ * larger ones.
+ *
+ * Another use case for drm_coredump_printer is to capture the devcoredump into
+ * a saved buffer before the dev_coredump() callback. This involves two passes:
+ * one to determine the size of the devcoredump and another to print it to a
+ * buffer. Then, in dev_coredump(), copy from the saved buffer into the
+ * devcoredump read buffer.
+ *
+ * For example::
+ *
+ *	char *devcoredump_saved_buffer;
+ *
+ *	ssize_t __coredump_print(char *buffer, ssize_t count, ...)
+ *	{
+ *		struct drm_print_iterator iter;
+ *		struct drm_printer p;
+ *
+ *		iter.data = buffer;
+ *		iter.start = 0;
+ *		iter.remain = count;
+ *
+ *		p = drm_coredump_printer(&iter);
+ *
+ *		drm_printf(p, "foo=%d\n", foo);
+ *		...
+ *		return count - iter.remain;
+ *	}
+ *
+ *	void coredump_print(...)
+ *	{
+ *		ssize_t count;
+ *
+ *		count = __coredump_print(NULL, INT_MAX, ...);
+ *		devcoredump_saved_buffer = kvmalloc(count, GFP_KERNEL);
+ *		__coredump_print(devcoredump_saved_buffer, count, ...);
+ *	}
+ *
+ *	void coredump_read(char *buffer, loff_t offset, size_t count,
+ *			   void *data, size_t datalen)
+ *	{
+ *		...
+ *		memcpy(buffer, devcoredump_saved_buffer + offset, count);
+ *		...
+ *	}
+ *
+ * The above example has a time complexity of O(N*2), where N is the size of the
+ * devcoredump. This scales better than the previous example for larger
+ * devcoredumps.
+ *
  * RETURNS:
  * The &drm_printer object
  */
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 5acc64954a88..e28bc649b5c9 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -574,7 +574,7 @@ void drm_sched_entity_modify_sched(struct drm_sched_entity *entity,
 
 void drm_sched_tdr_queue_imm(struct drm_gpu_scheduler *sched);
 void drm_sched_job_cleanup(struct drm_sched_job *job);
-void drm_sched_wakeup(struct drm_gpu_scheduler *sched, struct drm_sched_entity *entity);
+void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
 bool drm_sched_wqueue_ready(struct drm_gpu_scheduler *sched);
 void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched);
 void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
diff --git a/include/dt-bindings/clock/exynos7885.h b/include/dt-bindings/clock/exynos7885.h
index 255e3aa94323..54cfccff8508 100644
--- a/include/dt-bindings/clock/exynos7885.h
+++ b/include/dt-bindings/clock/exynos7885.h
@@ -136,12 +136,12 @@
 #define CLK_MOUT_FSYS_MMC_CARD_USER	2
 #define CLK_MOUT_FSYS_MMC_EMBD_USER	3
 #define CLK_MOUT_FSYS_MMC_SDIO_USER	4
-#define CLK_MOUT_FSYS_USB30DRD_USER	4
 #define CLK_GOUT_MMC_CARD_ACLK		5
 #define CLK_GOUT_MMC_CARD_SDCLKIN	6
 #define CLK_GOUT_MMC_EMBD_ACLK		7
 #define CLK_GOUT_MMC_EMBD_SDCLKIN	8
 #define CLK_GOUT_MMC_SDIO_ACLK		9
 #define CLK_GOUT_MMC_SDIO_SDCLKIN	10
+#define CLK_MOUT_FSYS_USB30DRD_USER	11
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_7885_H */
diff --git a/include/dt-bindings/clock/qcom,gcc-sc8180x.h b/include/dt-bindings/clock/qcom,gcc-sc8180x.h
index 90c6e021a035..2569f874fe13 100644
--- a/include/dt-bindings/clock/qcom,gcc-sc8180x.h
+++ b/include/dt-bindings/clock/qcom,gcc-sc8180x.h
@@ -248,6 +248,7 @@
 #define GCC_USB3_SEC_CLKREF_CLK					238
 #define GCC_UFS_MEM_CLKREF_EN					239
 #define GCC_UFS_CARD_CLKREF_EN					240
+#define GPLL9							241
 
 #define GCC_EMAC_BCR						0
 #define GCC_GPU_BCR						1
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20f7e98ee8af..df4f76639536 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1113,10 +1113,9 @@ static inline int parse_perf_domain(int cpu, const char *list_name,
 				    const char *cell_name,
 				    struct of_phandle_args *args)
 {
-	struct device_node *cpu_np;
 	int ret;
 
-	cpu_np = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_np __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_np)
 		return -ENODEV;
 
@@ -1124,9 +1123,6 @@ static inline int parse_perf_domain(int cpu, const char *list_name,
 					 args);
 	if (ret < 0)
 		return ret;
-
-	of_node_put(cpu_np);
-
 	return 0;
 }
 
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 2944d4aa413b..b1c5722f2b3c 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -22,7 +22,6 @@
  * as this is the granularity returned by copy_fdset().
  */
 #define NR_OPEN_DEFAULT BITS_PER_LONG
-#define NR_OPEN_MAX ~0U
 
 struct fdtable {
 	unsigned int max_fds;
@@ -106,7 +105,10 @@ struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
 int unshare_files(void);
-struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
+struct fd_range {
+	unsigned int from, to;
+};
+struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
@@ -115,8 +117,6 @@ int iterate_fd(struct files_struct *, unsigned,
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern struct file *file_close_fd(unsigned int fd);
-extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
-		      struct files_struct **new_fdp);
 
 extern struct kmem_cache *files_cachep;
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index c11624a3d9c0..ab603b79f23f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -748,6 +748,9 @@ struct i2c_adapter {
 	struct regulator *bus_regulator;
 
 	struct dentry *debugfs;
+
+	/* 7bit address space */
+	DECLARE_BITMAP(addrs_in_instantiation, 1 << 7);
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d20c6c99eb88..bf3eba0d9bdc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -354,7 +354,7 @@ struct napi_struct {
 
 	unsigned long		state;
 	int			weight;
-	int			defer_hard_irqs_count;
+	u32			defer_hard_irqs_count;
 	unsigned long		gro_bitmask;
 	int			(*poll)(struct napi_struct *, int);
 #ifdef CONFIG_NETPOLL
@@ -2089,7 +2089,7 @@ struct net_device {
 	unsigned int		real_num_rx_queues;
 	struct netdev_rx_queue	*_rx;
 	unsigned long		gro_flush_timeout;
-	int			napi_defer_hard_irqs;
+	u32			napi_defer_hard_irqs;
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
 	rx_handler_func_t __rcu	*rx_handler;
@@ -5000,6 +5000,24 @@ void netif_set_tso_max_segs(struct net_device *dev, unsigned int segs);
 void netif_inherit_tso_max(struct net_device *to,
 			   const struct net_device *from);
 
+static inline unsigned int
+netif_get_gro_max_size(const struct net_device *dev, const struct sk_buff *skb)
+{
+	/* pairs with WRITE_ONCE() in netif_set_gro(_ipv4)_max_size() */
+	return skb->protocol == htons(ETH_P_IPV6) ?
+	       READ_ONCE(dev->gro_max_size) :
+	       READ_ONCE(dev->gro_ipv4_max_size);
+}
+
+static inline unsigned int
+netif_get_gso_max_size(const struct net_device *dev, const struct sk_buff *skb)
+{
+	/* pairs with WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
+	return skb->protocol == htons(ETH_P_IPV6) ?
+	       READ_ONCE(dev->gso_max_size) :
+	       READ_ONCE(dev->gso_ipv4_max_size);
+}
+
 static inline bool netif_is_macsec(const struct net_device *dev)
 {
 	return dev->priv_flags & IFF_MACSEC;
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index e10333d78dbb..19d2b256180f 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -12,7 +12,7 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
-
+struct key *nvme_tls_key_lookup(key_serial_t key_id);
 #else
 
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
@@ -24,5 +24,9 @@ static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
 }
+static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 393fb13733b0..a7f1a3a4d1dc 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1608,13 +1608,7 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline int perf_allow_kernel(struct perf_event_attr *attr)
-{
-	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
-}
+int perf_allow_kernel(struct perf_event_attr *attr);
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 76214d7c819d..afa7bd078f8a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -637,6 +637,8 @@ struct sched_dl_entity {
 	 *
 	 * @dl_overrun tells if the task asked to be informed about runtime
 	 * overruns.
+	 *
+	 * @dl_server tells if this is a server entity.
 	 */
 	unsigned int			dl_throttled      : 1;
 	unsigned int			dl_yielded        : 1;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 23617da0e565..38a4fdf784e9 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -33,9 +33,9 @@
  * node traffic on multi-node NUMA NFS servers.
  */
 struct svc_pool {
-	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
+	unsigned int		sp_id;		/* pool id; also node id on NUMA */
 	struct lwq		sp_xprts;	/* pending transports */
-	atomic_t		sp_nrthreads;	/* # of threads in pool */
+	unsigned int		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
 
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index f46e0ca0169c..d91e32aff5a1 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -76,6 +76,8 @@ struct uprobe_task {
 	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
 
+	struct arch_uprobe              *auprobe;
+
 	struct return_instance		*return_instances;
 	unsigned int			depth;
 };
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 276ca543ef44..02a9f4dc594d 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -103,8 +103,10 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
+		if (skb_transport_offset(skb) < nh_min_len)
+			return -EINVAL;
 
-		nh_min_len = max_t(u32, nh_min_len, skb_transport_offset(skb));
+		nh_min_len = skb_transport_offset(skb);
 		p_off = nh_min_len + thlen;
 		if (!pskb_may_pull(skb, p_off))
 			return -EINVAL;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 27684135bb4d..35507588a14d 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -224,7 +224,15 @@ struct gdma_dev {
 	struct auxiliary_device *adev;
 };
 
-#define MINIMUM_SUPPORTED_PAGE_SIZE PAGE_SIZE
+/* MANA_PAGE_SIZE is the DMA unit */
+#define MANA_PAGE_SHIFT 12
+#define MANA_PAGE_SIZE BIT(MANA_PAGE_SHIFT)
+#define MANA_PAGE_ALIGN(x) ALIGN((x), MANA_PAGE_SIZE)
+#define MANA_PAGE_ALIGNED(addr) IS_ALIGNED((unsigned long)(addr), MANA_PAGE_SIZE)
+#define MANA_PFN(a) ((a) >> MANA_PAGE_SHIFT)
+
+/* Required by HW */
+#define MANA_MIN_QSIZE MANA_PAGE_SIZE
 
 #define GDMA_CQE_SIZE 64
 #define GDMA_EQE_SIZE 16
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 5927bd9d46be..f384d3aaac74 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -42,7 +42,8 @@ enum TRI_STATE {
 
 #define MAX_SEND_BUFFERS_PER_QUEUE 256
 
-#define EQ_SIZE (8 * PAGE_SIZE)
+#define EQ_SIZE (8 * MANA_PAGE_SIZE)
+
 #define LOG2_EQ_THROTTLE 3
 
 #define MAX_PORTS_IN_MANA_DEV 256
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 24ec3434d32e..102696abe8c9 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -140,6 +140,7 @@
 	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
 	/* The rest are for writeback */			\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
+	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\
 	EM(netfs_folio_trace_clear_g,		"clear-g")	\
diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index b8e071abaea5..3eba3934512e 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -132,6 +132,8 @@ static inline void cec_msg_init(struct cec_msg *msg,
  * Set the msg destination to the orig initiator and the msg initiator to the
  * orig destination. Note that msg and orig may be the same pointer, in which
  * case the change is done in place.
+ *
+ * It also zeroes the reply, timeout and flags fields.
  */
 static inline void cec_msg_set_reply_to(struct cec_msg *msg,
 					struct cec_msg *orig)
@@ -139,7 +141,9 @@ static inline void cec_msg_set_reply_to(struct cec_msg *msg,
 	/* The destination becomes the initiator and vice versa */
 	msg->msg[0] = (cec_msg_destination(orig) << 4) |
 		      cec_msg_initiator(orig);
-	msg->reply = msg->timeout = 0;
+	msg->reply = 0;
+	msg->timeout = 0;
+	msg->flags = 0;
 }
 
 /**
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 639894ed1b97..2f71d9146233 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1694,7 +1694,7 @@ enum nft_flowtable_flags {
  *
  * @NFTA_FLOWTABLE_TABLE: name of the table containing the expression (NLA_STRING)
  * @NFTA_FLOWTABLE_NAME: name of this flow table (NLA_STRING)
- * @NFTA_FLOWTABLE_HOOK: netfilter hook configuration(NLA_U32)
+ * @NFTA_FLOWTABLE_HOOK: netfilter hook configuration (NLA_NESTED)
  * @NFTA_FLOWTABLE_USE: number of references to this flow table (NLA_U32)
  * @NFTA_FLOWTABLE_HANDLE: object handle (NLA_U64)
  * @NFTA_FLOWTABLE_FLAGS: flags (NLA_U32)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index c0d8ee0c9786..ff243f6b5119 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -316,7 +316,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 			    sizeof(struct uring_cache));
 	ret |= io_futex_cache_init(ctx);
 	if (ret)
-		goto err;
+		goto free_ref;
 	init_completion(&ctx->ref_comp);
 	xa_init_flags(&ctx->personalities, XA_FLAGS_ALLOC1);
 	mutex_init(&ctx->uring_lock);
@@ -344,6 +344,9 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	io_napi_init(ctx);
 
 	return ctx;
+
+free_ref:
+	percpu_ref_exit(&ctx->refs);
 err:
 	io_alloc_cache_free(&ctx->rsrc_node_cache, kfree);
 	io_alloc_cache_free(&ctx->apoll_cache, kfree);
diff --git a/io_uring/net.c b/io_uring/net.c
index 09bb82bc209a..a70bbd4bd7cb 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1116,6 +1116,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	int ret, min_ret = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	size_t len = sr->len;
+	bool mshot_finished;
 
 	if (!(req->flags & REQ_F_POLLED) &&
 	    (sr->flags & IORING_RECVSEND_POLL_FIRST))
@@ -1170,6 +1171,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		req_set_fail(req);
 	}
 
+	mshot_finished = ret <= 0;
 	if (ret > 0)
 		ret += sr->done_io;
 	else if (sr->done_io)
@@ -1177,7 +1179,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	else
 		io_kbuf_recycle(req, issue_flags);
 
-	if (!io_recv_finish(req, &ret, kmsg, ret <= 0, issue_flags))
+	if (!io_recv_finish(req, &ret, kmsg, mshot_finished, issue_flags))
 		goto retry_multishot;
 
 	return ret;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c821713249c8..eb4b4f5b1284 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8017,6 +8017,15 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_st,
+						 struct bpf_kfunc_call_arg_meta *meta)
+{
+	int iter_frameno = meta->iter.frameno;
+	int iter_spi = meta->iter.spi;
+
+	return &cur_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+}
+
 /* process_iter_next_call() is called when verifier gets to iterator's next
  * "method" (e.g., bpf_iter_num_next() for numbers iterator) call. We'll refer
  * to it as just "iter_next()" in comments below.
@@ -8101,12 +8110,10 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
 	struct bpf_reg_state *cur_iter, *queued_iter;
-	int iter_frameno = meta->iter.frameno;
-	int iter_spi = meta->iter.spi;
 
 	BTF_TYPE_EMIT(struct bpf_iter);
 
-	cur_iter = &env->cur_state->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+	cur_iter = get_iter_from_state(cur_st, meta);
 
 	if (cur_iter->iter.state != BPF_ITER_STATE_ACTIVE &&
 	    cur_iter->iter.state != BPF_ITER_STATE_DRAINED) {
@@ -8134,7 +8141,7 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 		if (!queued_st)
 			return -ENOMEM;
 
-		queued_iter = &queued_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr;
+		queued_iter = get_iter_from_state(queued_st, meta);
 		queued_iter->iter.state = BPF_ITER_STATE_ACTIVE;
 		queued_iter->iter.depth++;
 		if (prev_st)
@@ -12675,6 +12682,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].btf = desc_btf;
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID;
 			regs[BPF_REG_0].btf_id = ptr_type_id;
+
+			if (is_iter_next_kfunc(&meta)) {
+				struct bpf_reg_state *cur_iter;
+
+				cur_iter = get_iter_from_state(env->cur_state, &meta);
+
+				if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
+					regs[BPF_REG_0].type |= MEM_RCU;
+				else
+					regs[BPF_REG_0].type |= PTR_TRUSTED;
+			}
 		}
 
 		if (is_kfunc_ret_null(&meta)) {
@@ -19933,13 +19951,46 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			/* Convert BPF_CLASS(insn->code) == BPF_ALU64 to 32-bit ALU */
 			insn->code = BPF_ALU | BPF_OP(insn->code) | BPF_SRC(insn->code);
 
-		/* Make divide-by-zero exceptions impossible. */
+		/* Make sdiv/smod divide-by-minus-one exceptions impossible. */
+		if ((insn->code == (BPF_ALU64 | BPF_MOD | BPF_K) ||
+		     insn->code == (BPF_ALU64 | BPF_DIV | BPF_K) ||
+		     insn->code == (BPF_ALU | BPF_MOD | BPF_K) ||
+		     insn->code == (BPF_ALU | BPF_DIV | BPF_K)) &&
+		    insn->off == 1 && insn->imm == -1) {
+			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
+			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
+			struct bpf_insn *patchlet;
+			struct bpf_insn chk_and_sdiv[] = {
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_NEG | BPF_K, insn->dst_reg,
+					     0, 0, 0),
+			};
+			struct bpf_insn chk_and_smod[] = {
+				BPF_MOV32_IMM(insn->dst_reg, 0),
+			};
+
+			patchlet = isdiv ? chk_and_sdiv : chk_and_smod;
+			cnt = isdiv ? ARRAY_SIZE(chk_and_sdiv) : ARRAY_SIZE(chk_and_smod);
+
+			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
+		/* Make divide-by-zero and divide-by-minus-one exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
 		    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
 			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
 			bool isdiv = BPF_OP(insn->code) == BPF_DIV;
+			bool is_sdiv = isdiv && insn->off == 1;
+			bool is_smod = !isdiv && insn->off == 1;
 			struct bpf_insn *patchlet;
 			struct bpf_insn chk_and_div[] = {
 				/* [R,W]x div 0 -> 0 */
@@ -19959,10 +20010,62 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
 				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
 			};
+			struct bpf_insn chk_and_sdiv[] = {
+				/* [R,W]x sdiv 0 -> 0
+				 * LLONG_MIN sdiv -1 -> LLONG_MIN
+				 * INT_MIN sdiv -1 -> INT_MIN
+				 */
+				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_ADD | BPF_K, BPF_REG_AX,
+					     0, 0, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JGT | BPF_K, BPF_REG_AX,
+					     0, 4, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JEQ | BPF_K, BPF_REG_AX,
+					     0, 1, 0),
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_MOV | BPF_K, insn->dst_reg,
+					     0, 0, 0),
+				/* BPF_NEG(LLONG_MIN) == -LLONG_MIN == LLONG_MIN */
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_NEG | BPF_K, insn->dst_reg,
+					     0, 0, 0),
+				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				*insn,
+			};
+			struct bpf_insn chk_and_smod[] = {
+				/* [R,W]x mod 0 -> [R,W]x */
+				/* [R,W]x mod -1 -> 0 */
+				BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
+				BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU) |
+					     BPF_ADD | BPF_K, BPF_REG_AX,
+					     0, 0, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JGT | BPF_K, BPF_REG_AX,
+					     0, 3, 1),
+				BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32) |
+					     BPF_JEQ | BPF_K, BPF_REG_AX,
+					     0, 3 + (is64 ? 0 : 1), 1),
+				BPF_MOV32_IMM(insn->dst_reg, 0),
+				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				*insn,
+				BPF_JMP_IMM(BPF_JA, 0, 0, 1),
+				BPF_MOV32_REG(insn->dst_reg, insn->dst_reg),
+			};
 
-			patchlet = isdiv ? chk_and_div : chk_and_mod;
-			cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
-				      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
+			if (is_sdiv) {
+				patchlet = chk_and_sdiv;
+				cnt = ARRAY_SIZE(chk_and_sdiv);
+			} else if (is_smod) {
+				patchlet = chk_and_smod;
+				cnt = ARRAY_SIZE(chk_and_smod) - (is64 ? 2 : 0);
+			} else {
+				patchlet = isdiv ? chk_and_div : chk_and_mod;
+				cnt = isdiv ? ARRAY_SIZE(chk_and_div) :
+					      ARRAY_SIZE(chk_and_mod) - (is64 ? 2 : 0);
+			}
 
 			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
 			if (!new_prog)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 36191add55c3..557f34dcb6d0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -264,6 +264,7 @@ static void event_function_call(struct perf_event *event, event_f func, void *da
 {
 	struct perf_event_context *ctx = event->ctx;
 	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
+	struct perf_cpu_context *cpuctx;
 	struct event_function_struct efs = {
 		.event = event,
 		.func = func,
@@ -291,22 +292,25 @@ static void event_function_call(struct perf_event *event, event_f func, void *da
 	if (!task_function_call(task, event_function, &efs))
 		return;
 
-	raw_spin_lock_irq(&ctx->lock);
+	local_irq_disable();
+	cpuctx = this_cpu_ptr(&perf_cpu_context);
+	perf_ctx_lock(cpuctx, ctx);
 	/*
 	 * Reload the task pointer, it might have been changed by
 	 * a concurrent perf_event_context_sched_out().
 	 */
 	task = ctx->task;
-	if (task == TASK_TOMBSTONE) {
-		raw_spin_unlock_irq(&ctx->lock);
-		return;
-	}
+	if (task == TASK_TOMBSTONE)
+		goto unlock;
 	if (ctx->is_active) {
-		raw_spin_unlock_irq(&ctx->lock);
+		perf_ctx_unlock(cpuctx, ctx);
+		local_irq_enable();
 		goto again;
 	}
 	func(event, NULL, ctx, data);
-	raw_spin_unlock_irq(&ctx->lock);
+unlock:
+	perf_ctx_unlock(cpuctx, ctx);
+	local_irq_enable();
 }
 
 /*
@@ -4103,7 +4107,11 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	period = perf_calculate_period(event, nsec, count);
 
 	delta = (s64)(period - hwc->sample_period);
-	delta = (delta + 7) / 8; /* low pass filter */
+	if (delta >= 0)
+		delta += 7;
+	else
+		delta -= 7;
+	delta /= 8; /* low pass filter */
 
 	sample_period = hwc->sample_period + delta;
 
@@ -13362,6 +13370,15 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
 	return &event->attr;
 }
 
+int perf_allow_kernel(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
+}
+EXPORT_SYMBOL_GPL(perf_allow_kernel);
+
 /*
  * Inherit an event from parent task to child task.
  *
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 47cdec3e1df1..3dd1f1464364 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1491,7 +1491,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	area->xol_mapping.name = "[uprobes]";
 	area->xol_mapping.pages = area->pages;
-	area->pages[0] = alloc_page(GFP_HIGHUSER);
+	area->pages[0] = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
 	if (!area->pages[0])
 		goto free_bitmap;
 	area->pages[1] = NULL;
@@ -2071,6 +2071,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 	bool need_prep = false; /* prepare return uprobe, when needed */
 
 	down_read(&uprobe->register_rwsem);
+	current->utask->auprobe = &uprobe->arch;
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
 		int rc = 0;
 
@@ -2085,6 +2086,7 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 
 		remove &= rc;
 	}
+	current->utask->auprobe = NULL;
 
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..1116946b7fba 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1770,33 +1770,30 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 		      int no_files)
 {
 	struct files_struct *oldf, *newf;
-	int error = 0;
 
 	/*
 	 * A background process may not have any files ...
 	 */
 	oldf = current->files;
 	if (!oldf)
-		goto out;
+		return 0;
 
 	if (no_files) {
 		tsk->files = NULL;
-		goto out;
+		return 0;
 	}
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
-		goto out;
+		return 0;
 	}
 
-	newf = dup_fd(oldf, NR_OPEN_MAX, &error);
-	if (!newf)
-		goto out;
+	newf = dup_fd(oldf, NULL);
+	if (IS_ERR(newf))
+		return PTR_ERR(newf);
 
 	tsk->files = newf;
-	error = 0;
-out:
-	return error;
+	return 0;
 }
 
 static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
@@ -3246,17 +3243,16 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 /*
  * Unshare file descriptor table if it is being shared
  */
-int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
-	       struct files_struct **new_fdp)
+static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
 {
 	struct files_struct *fd = current->files;
-	int error = 0;
 
 	if ((unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
-		*new_fdp = dup_fd(fd, max_fds, &error);
-		if (!*new_fdp)
-			return error;
+		fd = dup_fd(fd, NULL);
+		if (IS_ERR(fd))
+			return PTR_ERR(fd);
+		*new_fdp = fd;
 	}
 
 	return 0;
@@ -3314,7 +3310,7 @@ int ksys_unshare(unsigned long unshare_flags)
 	err = unshare_fs(unshare_flags, &new_fs);
 	if (err)
 		goto bad_unshare_out;
-	err = unshare_fd(unshare_flags, NR_OPEN_MAX, &new_fd);
+	err = unshare_fd(unshare_flags, &new_fd);
 	if (err)
 		goto bad_unshare_cleanup_fs;
 	err = unshare_userns(unshare_flags, &new_cred);
@@ -3406,7 +3402,7 @@ int unshare_files(void)
 	struct files_struct *old, *copy = NULL;
 	int error;
 
-	error = unshare_fd(CLONE_FILES, NR_OPEN_MAX, &copy);
+	error = unshare_fd(CLONE_FILES, &copy);
 	if (error || !copy)
 		return error;
 
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index c6ac0d0377d7..101572d6a908 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -159,22 +159,24 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 	if (static_key_fast_inc_not_disabled(key))
 		return true;
 
-	jump_label_lock();
-	if (atomic_read(&key->enabled) == 0) {
-		atomic_set(&key->enabled, -1);
+	guard(mutex)(&jump_label_mutex);
+	/* Try to mark it as 'enabling in progress. */
+	if (!atomic_cmpxchg(&key->enabled, 0, -1)) {
 		jump_label_update(key);
 		/*
-		 * Ensure that if the above cmpxchg loop observes our positive
-		 * value, it must also observe all the text changes.
+		 * Ensure that when static_key_fast_inc_not_disabled() or
+		 * static_key_dec_not_one() observe the positive value,
+		 * they must also observe all the text changes.
 		 */
 		atomic_set_release(&key->enabled, 1);
 	} else {
-		if (WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key))) {
-			jump_label_unlock();
+		/*
+		 * While holding the mutex this should never observe
+		 * anything else than a value >= 1 and succeed
+		 */
+		if (WARN_ON_ONCE(!static_key_fast_inc_not_disabled(key)))
 			return false;
-		}
 	}
-	jump_label_unlock();
 	return true;
 }
 
@@ -245,7 +247,7 @@ void static_key_disable(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-static bool static_key_slow_try_dec(struct static_key *key)
+static bool static_key_dec_not_one(struct static_key *key)
 {
 	int v;
 
@@ -269,6 +271,14 @@ static bool static_key_slow_try_dec(struct static_key *key)
 		 * enabled. This suggests an ordering problem on the user side.
 		 */
 		WARN_ON_ONCE(v < 0);
+
+		/*
+		 * Warn about underflow, and lie about success in an attempt to
+		 * not make things worse.
+		 */
+		if (WARN_ON_ONCE(v == 0))
+			return true;
+
 		if (v <= 1)
 			return false;
 	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
@@ -279,15 +289,27 @@ static bool static_key_slow_try_dec(struct static_key *key)
 static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 {
 	lockdep_assert_cpus_held();
+	int val;
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	guard(mutex)(&jump_label_mutex);
-	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
+	val = atomic_read(&key->enabled);
+	/*
+	 * It should be impossible to observe -1 with jump_label_mutex held,
+	 * see static_key_slow_inc_cpuslocked().
+	 */
+	if (WARN_ON_ONCE(val == -1))
+		return;
+	/*
+	 * Cannot already be 0, something went sideways.
+	 */
+	if (WARN_ON_ONCE(val == 0))
+		return;
+
+	if (atomic_dec_and_test(&key->enabled))
 		jump_label_update(key);
-	else
-		WARN_ON_ONCE(!static_key_slow_try_dec(key));
 }
 
 static void __static_key_slow_dec(struct static_key *key)
@@ -324,7 +346,7 @@ void __static_key_slow_dec_deferred(struct static_key *key,
 {
 	STATIC_KEY_CHECK_USE(key);
 
-	if (static_key_slow_try_dec(key))
+	if (static_key_dec_not_one(key))
 		return;
 
 	schedule_delayed_work(work, timeout);
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 8db4fedaaa1e..a5806baa1a2a 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -498,7 +498,7 @@ rcu_scale_writer(void *arg)
 			schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
 		wdp = &wdpp[i];
 		*wdp = ktime_get_mono_fast_ns();
-		if (gp_async) {
+		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
 retry:
 			if (!rhp)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
@@ -554,7 +554,7 @@ rcu_scale_writer(void *arg)
 			i++;
 		rcu_scale_wait_shutdown();
 	} while (!torture_must_stop());
-	if (gp_async) {
+	if (gp_async && cur_ops->async) {
 		cur_ops->gp_barrier();
 	}
 	writer_n_durations[me] = i_max + 1;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ba3440a45b6d..bc8429ada7a5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -34,6 +34,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_blkd_tasks: List of tasks blocked as readers.
  * @rtp_exit_list: List of tasks in the latter portion of do_exit().
  * @cpu: CPU number corresponding to this entry.
+ * @index: Index of this CPU in rtpcp_array of the rcu_tasks structure.
  * @rtpp: Pointer to the rcu_tasks structure.
  */
 struct rcu_tasks_percpu {
@@ -49,6 +50,7 @@ struct rcu_tasks_percpu {
 	struct list_head rtp_blkd_tasks;
 	struct list_head rtp_exit_list;
 	int cpu;
+	int index;
 	struct rcu_tasks *rtpp;
 };
 
@@ -76,6 +78,7 @@ struct rcu_tasks_percpu {
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @wait_state: Task state for synchronous grace-period waits (default TASK_UNINTERRUPTIBLE).
  * @rtpcpu: This flavor's rcu_tasks_percpu structure.
+ * @rtpcp_array: Array of pointers to rcu_tasks_percpu structure of CPUs in cpu_possible_mask.
  * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
  * @percpu_enqueue_lim: Number of per-CPU callback queues in use for enqueuing.
  * @percpu_dequeue_lim: Number of per-CPU callback queues in use for dequeuing.
@@ -110,6 +113,7 @@ struct rcu_tasks {
 	call_rcu_func_t call_func;
 	unsigned int wait_state;
 	struct rcu_tasks_percpu __percpu *rtpcpu;
+	struct rcu_tasks_percpu **rtpcp_array;
 	int percpu_enqueue_shift;
 	int percpu_enqueue_lim;
 	int percpu_dequeue_lim;
@@ -182,6 +186,8 @@ module_param(rcu_task_collapse_lim, int, 0444);
 static int rcu_task_lazy_lim __read_mostly = 32;
 module_param(rcu_task_lazy_lim, int, 0444);
 
+static int rcu_task_cpu_ids;
+
 /* RCU tasks grace-period state for debugging. */
 #define RTGS_INIT		 0
 #define RTGS_WAIT_WAIT_CBS	 1
@@ -245,6 +251,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	int cpu;
 	int lim;
 	int shift;
+	int maxcpu;
+	int index = 0;
 
 	if (rcu_task_enqueue_lim < 0) {
 		rcu_task_enqueue_lim = 1;
@@ -254,14 +262,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	}
 	lim = rcu_task_enqueue_lim;
 
-	if (lim > nr_cpu_ids)
-		lim = nr_cpu_ids;
-	shift = ilog2(nr_cpu_ids / lim);
-	if (((nr_cpu_ids - 1) >> shift) >= lim)
-		shift++;
-	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
-	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
-	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+	rtp->rtpcp_array = kcalloc(num_possible_cpus(), sizeof(struct rcu_tasks_percpu *), GFP_KERNEL);
+	BUG_ON(!rtp->rtpcp_array);
+
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
@@ -273,14 +276,29 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
 		rtpcp->cpu = cpu;
 		rtpcp->rtpp = rtp;
+		rtpcp->index = index;
+		rtp->rtpcp_array[index] = rtpcp;
+		index++;
 		if (!rtpcp->rtp_blkd_tasks.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
 		if (!rtpcp->rtp_exit_list.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+		maxcpu = cpu;
 	}
 
-	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
-			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
+	rcu_task_cpu_ids = maxcpu + 1;
+	if (lim > rcu_task_cpu_ids)
+		lim = rcu_task_cpu_ids;
+	shift = ilog2(rcu_task_cpu_ids / lim);
+	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
+		shift++;
+	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
+	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
+	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+
+	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
+			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
+			rcu_task_cb_adjust, rcu_task_cpu_ids);
 }
 
 // Compute wakeup time for lazy callback timer.
@@ -348,7 +366,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 			rtpcp->rtp_n_lock_retries = 0;
 		}
 		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
-		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
+		    READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
 			needadjust = true;  // Defer adjustment to avoid deadlock.
 	}
 	// Queuing callbacks before initialization not yet supported.
@@ -368,10 +386,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	if (unlikely(needadjust)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
-		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
+		if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
 			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
-			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
-			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
+			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
+			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
@@ -444,6 +462,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 
 	dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
 	for (cpu = 0; cpu < dequeue_limit; cpu++) {
+		if (!cpu_possible(cpu))
+			continue;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 		/* Advance and accelerate any new callbacks. */
@@ -481,7 +501,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim > 1) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
+			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(rcu_task_cpu_ids));
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
 			gpdone = false;
@@ -496,7 +516,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
 		if (rtp->percpu_dequeue_lim == 1) {
-			for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
+			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
+				if (!cpu_possible(cpu))
+					continue;
 				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 				WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
@@ -511,30 +533,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 // Advance callbacks and invoke any that are ready.
 static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu *rtpcp)
 {
-	int cpu;
-	int cpunext;
 	int cpuwq;
 	unsigned long flags;
 	int len;
+	int index;
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	struct rcu_tasks_percpu *rtpcp_next;
 
-	cpu = rtpcp->cpu;
-	cpunext = cpu * 2 + 1;
-	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-		cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
-		queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
-		cpunext++;
-		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-			cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+	index = rtpcp->index * 2 + 1;
+	if (index < num_possible_cpus()) {
+		rtpcp_next = rtp->rtpcp_array[index];
+		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
 			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+			index++;
+			if (index < num_possible_cpus()) {
+				rtpcp_next = rtp->rtpcp_array[index];
+				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
+					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+				}
+			}
 		}
 	}
 
-	if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
+	if (rcu_segcblist_empty(&rtpcp->cblist))
 		return;
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
diff --git a/kernel/resource.c b/kernel/resource.c
index b0e2b15ecb40..c66147aa2176 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -548,20 +548,62 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
 			       size_t size, unsigned long flags,
 			       unsigned long desc)
 {
-	struct resource res;
+	resource_size_t ostart, oend;
 	int type = 0; int other = 0;
-	struct resource *p;
+	struct resource *p, *dp;
+	bool is_type, covered;
+	struct resource res;
 
 	res.start = start;
 	res.end = start + size - 1;
 
 	for (p = parent->child; p ; p = p->sibling) {
-		bool is_type = (((p->flags & flags) == flags) &&
-				((desc == IORES_DESC_NONE) ||
-				 (desc == p->desc)));
-
-		if (resource_overlaps(p, &res))
-			is_type ? type++ : other++;
+		if (!resource_overlaps(p, &res))
+			continue;
+		is_type = (p->flags & flags) == flags &&
+			(desc == IORES_DESC_NONE || desc == p->desc);
+		if (is_type) {
+			type++;
+			continue;
+		}
+		/*
+		 * Continue to search in descendant resources as if the
+		 * matched descendant resources cover some ranges of 'p'.
+		 *
+		 * |------------- "CXL Window 0" ------------|
+		 * |-- "System RAM" --|
+		 *
+		 * will behave similar as the following fake resource
+		 * tree when searching "System RAM".
+		 *
+		 * |-- "System RAM" --||-- "CXL Window 0a" --|
+		 */
+		covered = false;
+		ostart = max(res.start, p->start);
+		oend = min(res.end, p->end);
+		for_each_resource(p, dp, false) {
+			if (!resource_overlaps(dp, &res))
+				continue;
+			is_type = (dp->flags & flags) == flags &&
+				(desc == IORES_DESC_NONE || desc == dp->desc);
+			if (is_type) {
+				type++;
+				/*
+				 * Range from 'ostart' to 'dp->start'
+				 * isn't covered by matched resource.
+				 */
+				if (dp->start > ostart)
+					break;
+				if (dp->end >= oend) {
+					covered = true;
+					break;
+				}
+				/* Remove covered range */
+				ostart = max(ostart, dp->end + 1);
+			}
+		}
+		if (!covered)
+			other++;
 	}
 
 	if (type == 0)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e84a3b7b7bb..0cfb5f5ee213 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6005,6 +6005,14 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 #endif
 
 	put_prev_task(rq, prev);
+
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->dl_server.
+	 */
+	if (prev->dl_server)
+		prev->dl_server = NULL;
 }
 
 /*
@@ -6035,6 +6043,13 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_next_task_idle(rq);
 		}
 
+		/*
+		 * This is a normal CFS pick, but the previous could be a DL pick.
+		 * Clear it as previous is no longer picked.
+		 */
+		if (prev->dl_server)
+			prev->dl_server = NULL;
+
 		/*
 		 * This is the fast path; it cannot be a DL server pick;
 		 * therefore even if @p == @prev, ->dl_server must be NULL.
@@ -6048,14 +6063,6 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
-	/*
-	 * We've updated @prev and no longer need the server link, clear it.
-	 * Must be done before ->pick_next_task() because that can (re)set
-	 * ->dl_server.
-	 */
-	if (prev->dl_server)
-		prev->dl_server = NULL;
-
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 507d7b8d79af..8d4a3d9de479 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -765,13 +765,14 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 }
 
 static void psi_group_change(struct psi_group *group, int cpu,
-			     unsigned int clear, unsigned int set, u64 now,
+			     unsigned int clear, unsigned int set,
 			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
 	enum psi_states s;
 	u32 state_mask;
+	u64 now;
 
 	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
@@ -786,6 +787,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 * SOME and FULL time these may have resulted in.
 	 */
 	write_seqcount_begin(&groupc->seq);
+	now = cpu_clock(cpu);
 
 	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding
@@ -899,18 +901,15 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
-	u64 now;
 
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
 
-	now = cpu_clock(cpu);
-
 	group = task_psi_group(task);
 	do {
-		psi_group_change(group, cpu, clear, set, now, true);
+		psi_group_change(group, cpu, clear, set, true);
 	} while ((group = group->parent));
 }
 
@@ -919,7 +918,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 {
 	struct psi_group *group, *common = NULL;
 	int cpu = task_cpu(prev);
-	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
 		psi_flags_change(next, 0, TSK_ONCPU);
@@ -936,7 +934,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				break;
 			}
 
-			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
+			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
 		} while ((group = group->parent));
 	}
 
@@ -974,7 +972,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		do {
 			if (group == common)
 				break;
-			psi_group_change(group, cpu, clear, set, now, wake_clock);
+			psi_group_change(group, cpu, clear, set, wake_clock);
 		} while ((group = group->parent));
 
 		/*
@@ -986,7 +984,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = group->parent)
-				psi_group_change(group, cpu, clear, set, now, wake_clock);
+				psi_group_change(group, cpu, clear, set, wake_clock);
 		}
 	}
 }
@@ -997,8 +995,8 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now, irq;
 	s64 delta;
+	u64 irq;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
@@ -1011,7 +1009,6 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	if (prev && task_psi_group(prev) == group)
 		return;
 
-	now = cpu_clock(cpu);
 	irq = irq_time_read(cpu);
 	delta = (s64)(irq - rq->psi_irq_time);
 	if (delta < 0)
@@ -1019,12 +1016,15 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
 	rq->psi_irq_time = irq;
 
 	do {
+		u64 now;
+
 		if (!group->enabled)
 			continue;
 
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
 		write_seqcount_begin(&groupc->seq);
+		now = cpu_clock(cpu);
 
 		record_times(groupc, now);
 		groupc->times[PSI_IRQ_FULL] += delta;
@@ -1223,11 +1223,9 @@ void psi_cgroup_restart(struct psi_group *group)
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
 		struct rq_flags rf;
-		u64 now;
 
 		rq_lock_irq(rq, &rf);
-		now = cpu_clock(cpu);
-		psi_group_change(group, cpu, 0, 0, now, true);
+		psi_group_change(group, cpu, 0, 0, true);
 		rq_unlock_irq(rq, &rf);
 	}
 }
diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
index 639397b5491c..5259cda486d0 100644
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -411,6 +411,17 @@ static void static_call_del_module(struct module *mod)
 
 	for (site = start; site < stop; site++) {
 		key = static_call_key(site);
+
+		/*
+		 * If the key was not updated due to a memory allocation
+		 * failure in __static_call_init() then treating key::sites
+		 * as key::mods in the code below would cause random memory
+		 * access and #GP. In that case all subsequent sites have
+		 * not been touched either, so stop iterating.
+		 */
+		if (!static_call_key_has_mods(key))
+			break;
+
 		if (key == prev_key)
 			continue;
 
@@ -442,7 +453,7 @@ static int static_call_module_notify(struct notifier_block *nb,
 	case MODULE_STATE_COMING:
 		ret = static_call_add_module(mod);
 		if (ret) {
-			WARN(1, "Failed to allocate memory for static calls");
+			pr_warn("Failed to allocate memory for static calls\n");
 			static_call_del_module(mod);
 		}
 		break;
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..3bd6071441ad 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -520,6 +520,8 @@ static void hwlat_hotplug_workfn(struct work_struct *dummy)
 	if (!hwlat_busy || hwlat_data.thread_mode != MODE_PER_CPU)
 		goto out_unlock;
 
+	if (!cpu_online(cpu))
+		goto out_unlock;
 	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
 		goto out_unlock;
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 461b4ab60b50..3e2bc029fa8c 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1953,12 +1953,8 @@ static void stop_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
-	mutex_lock(&interface_lock);
-	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+	kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
 	if (kthread) {
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
-		mutex_unlock(&interface_lock);
-
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
 		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			kthread_stop(kthread);
@@ -1972,7 +1968,6 @@ static void stop_kthread(unsigned int cpu)
 			put_task_struct(kthread);
 		}
 	} else {
-		mutex_unlock(&interface_lock);
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			/*
@@ -1994,8 +1989,12 @@ static void stop_per_cpu_kthreads(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	cpus_read_lock();
+
+	for_each_online_cpu(cpu)
 		stop_kthread(cpu);
+
+	cpus_read_unlock();
 }
 
 /*
@@ -2007,6 +2006,10 @@ static int start_kthread(unsigned int cpu)
 	void *main = osnoise_main;
 	char comm[24];
 
+	/* Do not start a new thread if it is already running */
+	if (per_cpu(per_cpu_osnoise_var, cpu).kthread)
+		return 0;
+
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
@@ -2061,11 +2064,10 @@ static int start_per_cpu_kthreads(void)
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
 			struct task_struct *kthread;
 
-			kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+			kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
 			if (!WARN_ON(!kthread))
 				kthread_stop(kthread);
 		}
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 	}
 
 	for_each_cpu(cpu, current_mask) {
@@ -2095,6 +2097,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	mutex_lock(&interface_lock);
 	cpus_read_lock();
 
+	if (!cpu_online(cpu))
+		goto out_unlock;
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
 		goto out_unlock;
 
diff --git a/lib/buildid.c b/lib/buildid.c
index 7954dd92e36c..26007cc99a38 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *build_id,
 			      const void *note_start,
 			      Elf32_Word note_size)
 {
-	Elf32_Word note_offs = 0, new_offs;
-
-	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
-		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
+	const char note_name[] = "GNU";
+	const size_t note_name_sz = sizeof(note_name);
+	u64 note_off = 0, new_off, name_sz, desc_sz;
+	const char *data;
+
+	while (note_off + sizeof(Elf32_Nhdr) < note_size &&
+	       note_off + sizeof(Elf32_Nhdr) > note_off /* overflow */) {
+		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_off);
+
+		name_sz = READ_ONCE(nhdr->n_namesz);
+		desc_sz = READ_ONCE(nhdr->n_descsz);
+
+		new_off = note_off + sizeof(Elf32_Nhdr);
+		if (check_add_overflow(new_off, ALIGN(name_sz, 4), &new_off) ||
+		    check_add_overflow(new_off, ALIGN(desc_sz, 4), &new_off) ||
+		    new_off > note_size)
+			break;
 
 		if (nhdr->n_type == BUILD_ID &&
-		    nhdr->n_namesz == sizeof("GNU") &&
-		    !strcmp((char *)(nhdr + 1), "GNU") &&
-		    nhdr->n_descsz > 0 &&
-		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
-			memcpy(build_id,
-			       note_start + note_offs +
-			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
-			       nhdr->n_descsz);
-			memset(build_id + nhdr->n_descsz, 0,
-			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
+		    name_sz == note_name_sz &&
+		    memcmp(nhdr + 1, note_name, note_name_sz) == 0 &&
+		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
+			data = note_start + note_off + ALIGN(note_name_sz, 4);
+			memcpy(build_id, data, desc_sz);
+			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
 			if (size)
-				*size = nhdr->n_descsz;
+				*size = desc_sz;
 			return 0;
 		}
-		new_offs = note_offs + sizeof(Elf32_Nhdr) +
-			ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
-		if (new_offs <= note_offs)  /* overflow */
-			break;
-		note_offs = new_offs;
+
+		note_off = new_off;
 	}
 
 	return -EINVAL;
@@ -71,20 +77,28 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
 {
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
 	Elf32_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
+
+	/*
+	 * FIXME
+	 * Neither ELF spec nor ELF loader require that program headers
+	 * start immediately after ELF header.
+	 */
+	if (ehdr->e_phoff != sizeof(Elf32_Ehdr))
+		return -EINVAL;
 
+	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf32_Phdr *)(page_addr + sizeof(Elf32_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+				    page_addr + READ_ONCE(phdr[i].p_offset),
+				    READ_ONCE(phdr[i].p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
@@ -96,20 +110,28 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
 {
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
 	Elf64_Phdr *phdr;
-	int i;
+	__u32 i, phnum;
+
+	/*
+	 * FIXME
+	 * Neither ELF spec nor ELF loader require that program headers
+	 * start immediately after ELF header.
+	 */
+	if (ehdr->e_phoff != sizeof(Elf64_Ehdr))
+		return -EINVAL;
 
+	phnum = READ_ONCE(ehdr->e_phnum);
 	/* only supports phdr that fits in one page */
-	if (ehdr->e_phnum >
-	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
+	if (phnum > (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))
 		return -EINVAL;
 
 	phdr = (Elf64_Phdr *)(page_addr + sizeof(Elf64_Ehdr));
 
-	for (i = 0; i < ehdr->e_phnum; ++i) {
+	for (i = 0; i < phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
 		    !parse_build_id(page_addr, build_id, size,
-				    page_addr + phdr[i].p_offset,
-				    phdr[i].p_filesz))
+				    page_addr + READ_ONCE(phdr[i].p_offset),
+				    READ_ONCE(phdr[i].p_filesz)))
 			return 0;
 	}
 	return -EINVAL;
@@ -138,6 +160,10 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
+	if (!PageUptodate(page)) {
+		put_page(page);
+		return -EFAULT;
+	}
 
 	ret = -EINVAL;
 	page_addr = kmap_local_page(page);
diff --git a/mm/Kconfig b/mm/Kconfig
index b4cb45255a54..baf7ce6a888c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -146,12 +146,15 @@ config ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
 	  Use the zbud allocator as the default allocator.
 
-config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
-	bool "z3fold"
-	select Z3FOLD
+config ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
+	bool "z3foldi (DEPRECATED)"
+	select Z3FOLD_DEPRECATED
 	help
 	  Use the z3fold allocator as the default allocator.
 
+	  Deprecated and scheduled for removal in a few cycles,
+	  see CONFIG_Z3FOLD_DEPRECATED.
+
 config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
 	bool "zsmalloc"
 	select ZSMALLOC
@@ -163,7 +166,7 @@ config ZSWAP_ZPOOL_DEFAULT
        string
        depends on ZSWAP
        default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
-       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
        default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
        default ""
 
@@ -177,15 +180,25 @@ config ZBUD
 	  deterministic reclaim properties that make it preferable to a higher
 	  density approach when reclaim will be used.
 
-config Z3FOLD
-	tristate "3:1 compression allocator (z3fold)"
+config Z3FOLD_DEPRECATED
+	tristate "3:1 compression allocator (z3fold) (DEPRECATED)"
 	depends on ZSWAP
 	help
+	  Deprecated and scheduled for removal in a few cycles. If you have
+	  a good reason for using Z3FOLD over ZSMALLOC, please contact
+	  linux-mm@kvack.org and the zswap maintainers.
+
 	  A special purpose allocator for storing compressed pages.
 	  It is designed to store up to three compressed pages per physical
 	  page. It is a ZBUD derivative so the simplicity and determinism are
 	  still there.
 
+config Z3FOLD
+	tristate
+	default y if Z3FOLD_DEPRECATED=y
+	default m if Z3FOLD_DEPRECATED=m
+	depends on Z3FOLD_DEPRECATED
+
 config ZSMALLOC
 	tristate
 	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1560a1546bb1..91284b7552e7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1176,6 +1176,13 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 
 	/* If the object still fits, repoison it precisely. */
 	if (ks >= new_size) {
+		/* Zero out spare memory. */
+		if (want_init_on_alloc(flags)) {
+			kasan_disable_current();
+			memset((void *)p + new_size, 0, ks - new_size);
+			kasan_enable_current();
+		}
+
 		p = kasan_krealloc((void *)p, new_size, flags);
 		return (void *)p;
 	}
diff --git a/mm/slub.c b/mm/slub.c
index be0ef60984ac..ccd770cf8f79 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -756,6 +756,50 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 	return false;
 }
 
+/*
+ * kmalloc caches has fixed sizes (mostly power of 2), and kmalloc() API
+ * family will round up the real request size to these fixed ones, so
+ * there could be an extra area than what is requested. Save the original
+ * request size in the meta data area, for better debug and sanity check.
+ */
+static inline void set_orig_size(struct kmem_cache *s,
+				void *object, unsigned int orig_size)
+{
+	void *p = kasan_reset_tag(object);
+	unsigned int kasan_meta_size;
+
+	if (!slub_debug_orig_size(s))
+		return;
+
+	/*
+	 * KASAN can save its free meta data inside of the object at offset 0.
+	 * If this meta data size is larger than 'orig_size', it will overlap
+	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
+	 * 'orig_size' to be as at least as big as KASAN's meta data.
+	 */
+	kasan_meta_size = kasan_metadata_size(s, true);
+	if (kasan_meta_size > orig_size)
+		orig_size = kasan_meta_size;
+
+	p += get_info_end(s);
+	p += sizeof(struct track) * 2;
+
+	*(unsigned int *)p = orig_size;
+}
+
+static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
+{
+	void *p = kasan_reset_tag(object);
+
+	if (!slub_debug_orig_size(s))
+		return s->object_size;
+
+	p += get_info_end(s);
+	p += sizeof(struct track) * 2;
+
+	return *(unsigned int *)p;
+}
+
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
 static DEFINE_SPINLOCK(object_map_lock);
@@ -969,50 +1013,6 @@ static void print_slab_info(const struct slab *slab)
 	       folio_flags(folio, 0));
 }
 
-/*
- * kmalloc caches has fixed sizes (mostly power of 2), and kmalloc() API
- * family will round up the real request size to these fixed ones, so
- * there could be an extra area than what is requested. Save the original
- * request size in the meta data area, for better debug and sanity check.
- */
-static inline void set_orig_size(struct kmem_cache *s,
-				void *object, unsigned int orig_size)
-{
-	void *p = kasan_reset_tag(object);
-	unsigned int kasan_meta_size;
-
-	if (!slub_debug_orig_size(s))
-		return;
-
-	/*
-	 * KASAN can save its free meta data inside of the object at offset 0.
-	 * If this meta data size is larger than 'orig_size', it will overlap
-	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
-	 * 'orig_size' to be as at least as big as KASAN's meta data.
-	 */
-	kasan_meta_size = kasan_metadata_size(s, true);
-	if (kasan_meta_size > orig_size)
-		orig_size = kasan_meta_size;
-
-	p += get_info_end(s);
-	p += sizeof(struct track) * 2;
-
-	*(unsigned int *)p = orig_size;
-}
-
-static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
-{
-	void *p = kasan_reset_tag(object);
-
-	if (!slub_debug_orig_size(s))
-		return s->object_size;
-
-	p += get_info_end(s);
-	p += sizeof(struct track) * 2;
-
-	return *(unsigned int *)p;
-}
-
 void skip_orig_size_check(struct kmem_cache *s, const void *object)
 {
 	set_orig_size(s, (void *)object, s->object_size);
@@ -1859,7 +1859,6 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
-
 #ifndef CONFIG_SLUB_TINY
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 			       void **freelist, void *nextfree)
@@ -2187,14 +2186,21 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	 */
 	if (unlikely(init)) {
 		int rsize;
-		unsigned int inuse;
+		unsigned int inuse, orig_size;
 
 		inuse = get_info_end(s);
+		orig_size = get_orig_size(s, x);
 		if (!kasan_has_integrated_init())
-			memset(kasan_reset_tag(x), 0, s->object_size);
+			memset(kasan_reset_tag(x), 0, orig_size);
 		rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : 0;
 		memset((char *)kasan_reset_tag(x) + inuse, 0,
 		       s->size - inuse - rsize);
+		/*
+		 * Restore orig_size, otherwize kmalloc redzone overwritten
+		 * would be reported
+		 */
+		set_orig_size(s, x, orig_size);
+
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
 	return !kasan_slab_free(s, x, init);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9493966cf389..a9feb323c7d2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3792,6 +3792,8 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
+		mgmt_device_connected(hdev, conn, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 59d9086db75f..f47da4aa0d70 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3707,7 +3707,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	if (!ev->status && !test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+	if (!ev->status) {
 		struct hci_cp_remote_name_req cp;
 		memset(&cp, 0, sizeof(cp));
 		bacpy(&cp.bdaddr, &conn->dst);
@@ -5325,19 +5325,16 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	/* If no side requires MITM protection; auto-accept */
+	/* If no side requires MITM protection; use JUST_CFM method */
 	if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
 	    (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
 
-		/* If we're not the initiators request authorization to
-		 * proceed from user space (mgmt_user_confirm with
-		 * confirm_hint set to 1). The exception is if neither
-		 * side had MITM or if the local IO capability is
-		 * NoInputNoOutput, in which case we do auto-accept
+		/* If we're not the initiator of request authorization and the
+		 * local IO capability is not NoInputNoOutput, use JUST_WORKS
+		 * method (mgmt_user_confirm with confirm_hint set to 1).
 		 */
 		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
-		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
-		    (loc_mitm || rem_mitm)) {
+		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT) {
 			bt_dev_dbg(hdev, "Confirming auto-accept as acceptor");
 			confirm_hint = 1;
 			goto confirm;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9988ba382b68..6544c1ed7143 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4066,17 +4066,9 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 static int l2cap_connect_req(struct l2cap_conn *conn,
 			     struct l2cap_cmd_hdr *cmd, u16 cmd_len, u8 *data)
 {
-	struct hci_dev *hdev = conn->hcon->hdev;
-	struct hci_conn *hcon = conn->hcon;
-
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	hci_dev_lock(hdev);
-	if (hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_device_connected(hdev, hcon, NULL, 0);
-	hci_dev_unlock(hdev);
-
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c383eb44d516..31cabc3e98ce 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1454,10 +1454,15 @@ static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
 
 static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
-	if (cmd->cmd_complete) {
-		u8 *status = data;
+	struct cmd_lookup *match = data;
+
+	/* dequeue cmd_sync entries using cmd as data as that is about to be
+	 * removed/freed.
+	 */
+	hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
 
-		cmd->cmd_complete(cmd, *status);
+	if (cmd->cmd_complete) {
+		cmd->cmd_complete(cmd, match->mgmt_status);
 		mgmt_pending_remove(cmd);
 
 		return;
@@ -9349,12 +9354,12 @@ void mgmt_index_added(struct hci_dev *hdev)
 void mgmt_index_removed(struct hci_dev *hdev)
 {
 	struct mgmt_ev_ext_index ev;
-	u8 status = MGMT_STATUS_INVALID_INDEX;
+	struct cmd_lookup match = { NULL, hdev, MGMT_STATUS_INVALID_INDEX };
 
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
-	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
 
 	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0,
@@ -9405,7 +9410,7 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
 void __mgmt_power_off(struct hci_dev *hdev)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	u8 status, zero_cod[] = { 0, 0, 0 };
+	u8 zero_cod[] = { 0, 0, 0 };
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
@@ -9417,11 +9422,11 @@ void __mgmt_power_off(struct hci_dev *hdev)
 	 * status responses.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		status = MGMT_STATUS_INVALID_INDEX;
+		match.mgmt_status = MGMT_STATUS_INVALID_INDEX;
 	else
-		status = MGMT_STATUS_NOT_POWERED;
+		match.mgmt_status = MGMT_STATUS_NOT_POWERED;
 
-	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
 
 	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0) {
 		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index bc37e47ad829..1a52a0bca086 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -1674,7 +1674,7 @@ int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
 	spin_lock_bh(&br->multicast_lock);
 
 	mp = br_mdb_ip_get(br, &group);
-	if (!mp) {
+	if (!mp || (!mp->ports && !mp->host_joined)) {
 		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
 		err = -ENOENT;
 		goto unlock;
diff --git a/net/core/dev.c b/net/core/dev.c
index 2b4819b610b8..d716a046eaf9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3502,7 +3502,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	if (gso_segs > READ_ONCE(dev->gso_max_segs))
 		return features & ~NETIF_F_GSO_MASK;
 
-	if (unlikely(skb->len >= READ_ONCE(dev->gso_max_size)))
+	if (unlikely(skb->len >= netif_get_gso_max_size(dev, skb)))
 		return features & ~NETIF_F_GSO_MASK;
 
 	if (!skb_shinfo(skb)->gso_type) {
@@ -3748,7 +3748,7 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 						sizeof(_tcphdr), &_tcphdr);
 			if (likely(th))
 				hdr_len += __tcp_hdrlen(th);
-		} else {
+		} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
 			struct udphdr _udphdr;
 
 			if (skb_header_pointer(skb, hdr_len,
@@ -3756,10 +3756,14 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 				hdr_len += sizeof(struct udphdr);
 		}
 
-		if (shinfo->gso_type & SKB_GSO_DODGY)
-			gso_segs = DIV_ROUND_UP(skb->len - hdr_len,
-						shinfo->gso_size);
+		if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
+			int payload = skb->len - hdr_len;
 
+			/* Malicious packet. */
+			if (payload <= 0)
+				return;
+			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
+		}
 		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
 	}
 }
diff --git a/net/core/gro.c b/net/core/gro.c
index b3b43de1a650..87708483a5f4 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -98,7 +98,6 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	unsigned int headlen = skb_headlen(skb);
 	unsigned int len = skb_gro_len(skb);
 	unsigned int delta_truesize;
-	unsigned int gro_max_size;
 	unsigned int new_truesize;
 	struct sk_buff *lp;
 	int segs;
@@ -112,12 +111,8 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	if (p->pp_recycle != skb->pp_recycle)
 		return -ETOOMANYREFS;
 
-	/* pairs with WRITE_ONCE() in netif_set_gro(_ipv4)_max_size() */
-	gro_max_size = p->protocol == htons(ETH_P_IPV6) ?
-			READ_ONCE(p->dev->gro_max_size) :
-			READ_ONCE(p->dev->gro_ipv4_max_size);
-
-	if (unlikely(p->len + len >= gro_max_size || NAPI_GRO_CB(skb)->flush))
+	if (unlikely(p->len + len >= netif_get_gro_max_size(p->dev, p) ||
+		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 15ad775ddd3c..dc0c622d453e 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -32,6 +32,7 @@
 #ifdef CONFIG_SYSFS
 static const char fmt_hex[] = "%#x\n";
 static const char fmt_dec[] = "%d\n";
+static const char fmt_uint[] = "%u\n";
 static const char fmt_ulong[] = "%lu\n";
 static const char fmt_u64[] = "%llu\n";
 
@@ -425,6 +426,9 @@ NETDEVICE_SHOW_RW(gro_flush_timeout, fmt_ulong);
 
 static int change_napi_defer_hard_irqs(struct net_device *dev, unsigned long val)
 {
+	if (val > S32_MAX)
+		return -ERANGE;
+
 	WRITE_ONCE(dev->napi_defer_hard_irqs, val);
 	return 0;
 }
@@ -438,7 +442,7 @@ static ssize_t napi_defer_hard_irqs_store(struct device *dev,
 
 	return netdev_store(dev, attr, buf, len, change_napi_defer_hard_irqs);
 }
-NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_dec);
+NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_uint);
 
 static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t len)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 05f9515d2c05..a17d7eaeb001 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -216,10 +216,12 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	rtnl_lock();
 
 	napi = napi_by_id(napi_id);
-	if (napi)
+	if (napi) {
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
-	else
-		err = -EINVAL;
+	} else {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
+		err = -ENOENT;
+	}
 
 	rtnl_unlock();
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 55bcacf67df3..e08213900409 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -626,12 +626,9 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	const struct net_device_ops *ops;
 	int err;
 
-	np->dev = ndev;
-	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
-
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
-		       np->dev_name);
+		       ndev->name);
 		err = -ENOTSUPP;
 		goto out;
 	}
@@ -649,7 +646,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 		refcount_set(&npinfo->refcnt, 1);
 
-		ops = np->dev->netdev_ops;
+		ops = ndev->netdev_ops;
 		if (ops->ndo_netpoll_setup) {
 			err = ops->ndo_netpoll_setup(ndev, npinfo);
 			if (err)
@@ -660,6 +657,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		refcount_inc(&npinfo->refcnt);
 	}
 
+	np->dev = ndev;
+	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 	npinfo->netpoll = np;
 
 	/* last thing to do is link it to the net device structure */
@@ -677,6 +676,7 @@ EXPORT_SYMBOL_GPL(__netpoll_setup);
 int netpoll_setup(struct netpoll *np)
 {
 	struct net_device *ndev = NULL;
+	bool ip_overwritten = false;
 	struct in_device *in_dev;
 	int err;
 
@@ -741,6 +741,7 @@ int netpoll_setup(struct netpoll *np)
 			}
 
 			np->local_ip.ip = ifa->ifa_local;
+			ip_overwritten = true;
 			np_info(np, "local IP %pI4\n", &np->local_ip.ip);
 		} else {
 #if IS_ENABLED(CONFIG_IPV6)
@@ -757,6 +758,7 @@ int netpoll_setup(struct netpoll *np)
 					    !!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
 						continue;
 					np->local_ip.in6 = ifp->addr;
+					ip_overwritten = true;
 					err = 0;
 					break;
 				}
@@ -787,6 +789,9 @@ int netpoll_setup(struct netpoll *np)
 	return 0;
 
 put:
+	DEBUG_NET_WARN_ON_ONCE(np->dev);
+	if (ip_overwritten)
+		memset(&np->local_ip, 0, sizeof(np->local_ip));
 	netdev_put(ndev, &np->dev_tracker);
 unlock:
 	rtnl_unlock();
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 12521a7d4048..03ef2a2af430 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1579,6 +1579,7 @@ EXPORT_SYMBOL_GPL(dsa_unregister_switch);
 void dsa_switch_shutdown(struct dsa_switch *ds)
 {
 	struct net_device *conduit, *user_dev;
+	LIST_HEAD(close_list);
 	struct dsa_port *dp;
 
 	mutex_lock(&dsa2_mutex);
@@ -1588,10 +1589,16 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 
 	rtnl_lock();
 
+	dsa_switch_for_each_cpu_port(dp, ds)
+		list_add(&dp->conduit->close_list, &close_list);
+
+	dev_close_many(&close_list, true);
+
 	dsa_switch_for_each_user_port(dp, ds) {
 		conduit = dsa_port_to_conduit(dp);
 		user_dev = dp->user;
 
+		netif_device_detach(user_dev);
 		netdev_upper_dev_unlink(conduit, user_dev);
 	}
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index d09f557eaa77..73effd2d2994 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -574,10 +574,6 @@ static int inet_set_ifa(struct net_device *dev, struct in_ifaddr *ifa)
 
 	ASSERT_RTNL();
 
-	if (!in_dev) {
-		inet_free_ifa(ifa);
-		return -ENOBUFS;
-	}
 	ipv4_devconf_setall(in_dev);
 	neigh_parms_data_state_setall(in_dev->arp_parms);
 	if (ifa->ifa_dev != in_dev) {
@@ -1184,6 +1180,8 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 
 		if (!ifa) {
 			ret = -ENOBUFS;
+			if (!in_dev)
+				break;
 			ifa = inet_alloc_ifa();
 			if (!ifa)
 				break;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 7ad2cafb9276..da540ddb7af6 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1343,7 +1343,7 @@ static void nl_fib_lookup(struct net *net, struct fib_result_nl *frn)
 	struct flowi4           fl4 = {
 		.flowi4_mark = frn->fl_mark,
 		.daddr = frn->fl_addr,
-		.flowi4_tos = frn->fl_tos,
+		.flowi4_tos = frn->fl_tos & IPTOS_RT_MASK,
 		.flowi4_scope = frn->fl_scope,
 	};
 	struct fib_table *tb;
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index ba205473522e..868ef18ad656 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -661,11 +661,11 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
-		tnl_params = (const struct iphdr *)skb->data;
-
-		if (!pskb_network_may_pull(skb, pull_len))
+		if (!pskb_may_pull(skb, pull_len))
 			goto free_skb;
 
+		tnl_params = (const struct iphdr *)skb->data;
+
 		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
 		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 6cc5743c553a..9a21175693db 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -52,8 +52,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 {
 	struct iphdr *iph;
 
+	local_bh_disable();
 	if (this_cpu_read(nf_skb_duplicated))
-		return;
+		goto out;
 	/*
 	 * Copy the skb, and route the copy. Will later return %XT_CONTINUE for
 	 * the original skb, which should continue on its way as if nothing has
@@ -61,7 +62,7 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	 */
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
-		return;
+		goto out;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	/* Avoid counting cloned packets towards the original connection. */
@@ -90,6 +91,8 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	} else {
 		kfree_skb(skb);
 	}
+out:
+	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(nf_dup_ipv4);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index da0f50255399..7874b3718bc3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -118,6 +118,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	struct tcp_sock *tp = tcp_sk(sk);
 	int ts_recent_stamp;
 
+	if (tw->tw_substate == TCP_FIN_WAIT2)
+		reuse = 0;
+
 	if (reuse == 2) {
 		/* Still does not detect *everything* that goes through
 		 * lo, since we require a loopback src or dst address
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e4ad3311e148..2308665b51c5 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -101,8 +101,14 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
 		return ERR_PTR(-EINVAL);
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __tcp4_gso_segment_list(skb, features);
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
+		struct tcphdr *th = tcp_hdr(skb);
+
+		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+			return __tcp4_gso_segment_list(skb, features);
+
+		skb->ip_summed = CHECKSUM_NONE;
+	}
 
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
 		const struct iphdr *iph = ip_hdr(skb);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 5b54f4f32b1c..fdc032fda42c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -290,8 +290,26 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		return NULL;
 	}
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
+		 /* Detect modified geometry and pass those to skb_segment. */
+		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
+			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+
+		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
+		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
+		gso_skb->csum_offset = offsetof(struct udphdr, check);
+		gso_skb->ip_summed = CHECKSUM_PARTIAL;
+
+		uh = udp_hdr(gso_skb);
+		if (is_ipv6)
+			uh->check = ~udp_v6_check(gso_skb->len,
+						  &ipv6_hdr(gso_skb)->saddr,
+						  &ipv6_hdr(gso_skb)->daddr, 0);
+		else
+			uh->check = ~udp_v4_check(gso_skb->len,
+						  ip_hdr(gso_skb)->saddr,
+						  ip_hdr(gso_skb)->daddr, 0);
+	}
 
 	skb_pull(gso_skb, sizeof(*uh));
 
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index a0a2de30be3e..0c39c77fe8a8 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -47,11 +47,12 @@ static bool nf_dup_ipv6_route(struct net *net, struct sk_buff *skb,
 void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		 const struct in6_addr *gw, int oif)
 {
+	local_bh_disable();
 	if (this_cpu_read(nf_skb_duplicated))
-		return;
+		goto out;
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
-		return;
+		goto out;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	nf_reset_ct(skb);
@@ -69,6 +70,8 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	} else {
 		kfree_skb(skb);
 	}
+out:
+	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(nf_dup_ipv6);
 
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 23971903e66d..a45bf17cb2a1 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -159,8 +159,14 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(*th)))
 		return ERR_PTR(-EINVAL);
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __tcp6_gso_segment_list(skb, features);
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
+		struct tcphdr *th = tcp_hdr(skb);
+
+		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+			return __tcp6_gso_segment_list(skb, features);
+
+		skb->ip_summed = CHECKSUM_NONE;
+	}
 
 	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
 		const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e6a7ff6ca679..db5675d24e48 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -281,7 +281,9 @@ ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct sta_info *sta;
 
-	list_for_each_entry_rcu(sta, &sdata->local->sta_list, list) {
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	list_for_each_entry(sta, &sdata->local->sta_list, list) {
 		if (sdata != sta->sdata &&
 		    !(sta->sdata->bss && sta->sdata->bss == sdata->bss))
 			continue;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1faf4d7c115f..71cc5eb35bfc 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1020,7 +1020,7 @@ static bool ieee80211_add_vht_ie(struct ieee80211_sub_if_data *sdata,
 		bool disable_mu_mimo = false;
 		struct ieee80211_sub_if_data *other;
 
-		list_for_each_entry_rcu(other, &local->interfaces, list) {
+		list_for_each_entry(other, &local->interfaces, list) {
 			if (other->vif.bss_conf.mu_mimo_owner) {
 				disable_mu_mimo = true;
 				break;
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 1c5d99975ad0..3b2bde6360bc 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -504,7 +504,7 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	 * the scan was in progress; if there was none this will
 	 * just be a no-op for the particular interface.
 	 */
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+	list_for_each_entry(sdata, &local->interfaces, list) {
 		if (ieee80211_sdata_running(sdata))
 			wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c11dbe82ae1b..d10e0c528c1b 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -751,7 +751,9 @@ static void __iterate_interfaces(struct ieee80211_local *local,
 	struct ieee80211_sub_if_data *sdata;
 	bool active_only = iter_flags & IEEE80211_IFACE_ITER_ACTIVE;
 
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+	list_for_each_entry_rcu(sdata, &local->interfaces, list,
+				lockdep_is_held(&local->iflist_mtx) ||
+				lockdep_is_held(&local->hw.wiphy->mtx)) {
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_MONITOR:
 			if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 1c0eeaa76560..a6dab3cc3ad8 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -176,6 +176,7 @@ void mac802154_scan_worker(struct work_struct *work)
 	struct ieee802154_local *local =
 		container_of(work, struct ieee802154_local, scan_work.work);
 	struct cfg802154_scan_request *scan_req;
+	enum nl802154_scan_types scan_req_type;
 	struct ieee802154_sub_if_data *sdata;
 	unsigned int scan_duration = 0;
 	struct wpan_phy *wpan_phy;
@@ -209,6 +210,7 @@ void mac802154_scan_worker(struct work_struct *work)
 	}
 
 	wpan_phy = scan_req->wpan_phy;
+	scan_req_type = scan_req->type;
 	scan_req_duration = scan_req->duration;
 
 	/* Look for the next valid chan */
@@ -246,7 +248,7 @@ void mac802154_scan_worker(struct work_struct *work)
 		goto end_scan;
 	}
 
-	if (scan_req->type == NL802154_SCAN_ACTIVE) {
+	if (scan_req_type == NL802154_SCAN_ACTIVE) {
 		ret = mac802154_transmit_beacon_req(local, sdata);
 		if (ret)
 			dev_err(&sdata->dev->dev,
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5ecf611c8820..5cf55bde366d 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1954,6 +1954,8 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
+	disable_work_sync(&ndp->work);
+
 	kfree(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 08de24658f4f..3f8197d5926e 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1058,7 +1058,7 @@ bool rxrpc_direct_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
 int rxrpc_io_thread(void *data);
 static inline void rxrpc_wake_up_io_thread(struct rxrpc_local *local)
 {
-	wake_up_process(local->io_thread);
+	wake_up_process(READ_ONCE(local->io_thread));
 }
 
 static inline bool rxrpc_protocol_error(struct sk_buff *skb, enum rxrpc_abort_reason why)
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 0300baa9afcd..07c74c77d802 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -27,11 +27,17 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 {
 	struct sk_buff_head *rx_queue;
 	struct rxrpc_local *local = rcu_dereference_sk_user_data(udp_sk);
+	struct task_struct *io_thread;
 
 	if (unlikely(!local)) {
 		kfree_skb(skb);
 		return 0;
 	}
+	io_thread = READ_ONCE(local->io_thread);
+	if (!io_thread) {
+		kfree_skb(skb);
+		return 0;
+	}
 	if (skb->tstamp == 0)
 		skb->tstamp = ktime_get_real();
 
@@ -47,7 +53,7 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 #endif
 
 	skb_queue_tail(rx_queue, skb);
-	rxrpc_wake_up_io_thread(local);
+	wake_up_process(io_thread);
 	return 0;
 }
 
@@ -565,7 +571,7 @@ int rxrpc_io_thread(void *data)
 	__set_current_state(TASK_RUNNING);
 	rxrpc_see_local(local, rxrpc_local_stop);
 	rxrpc_destroy_local(local);
-	local->io_thread = NULL;
+	WRITE_ONCE(local->io_thread, NULL);
 	rxrpc_see_local(local, rxrpc_local_stopped);
 	return 0;
 }
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 504453c688d7..f9623ace2201 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -232,7 +232,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	}
 
 	wait_for_completion(&local->io_thread_ready);
-	local->io_thread = io_thread;
+	WRITE_ONCE(local->io_thread, io_thread);
 	_leave(" = 0");
 	return 0;
 
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index b284a06b5a75..847e1cc6052e 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1952,7 +1952,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			goto unlock;
 		}
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		/* Not going to race against advance_sched(), but still */
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 	} else {
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c009383369b2..cefac9eaddc3 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8552,8 +8552,10 @@ static int sctp_listen_start(struct sock *sk, int backlog)
 	 */
 	inet_sk_set_state(sk, SCTP_SS_LISTENING);
 	if (!ep->base.bind_addr.port) {
-		if (sctp_autobind(sk))
+		if (sctp_autobind(sk)) {
+			inet_sk_set_state(sk, SCTP_SS_CLOSED);
 			return -EAGAIN;
+		}
 	} else {
 		if (sctp_get_port(sk, inet_sk(sk)->inet_num)) {
 			inet_sk_set_state(sk, SCTP_SS_CLOSED);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d9cda1e53a01..6a15b831589c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -682,7 +682,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	serv->sv_nrthreads += 1;
 	spin_unlock_bh(&serv->sv_lock);
 
-	atomic_inc(&pool->sp_nrthreads);
+	pool->sp_nrthreads += 1;
 
 	/* Protected by whatever lock the service uses when calling
 	 * svc_set_num_threads()
@@ -737,31 +737,22 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *target_pool,
 	struct svc_pool *pool;
 	unsigned int i;
 
-retry:
 	pool = target_pool;
 
-	if (pool != NULL) {
-		if (atomic_inc_not_zero(&pool->sp_nrthreads))
-			goto found_pool;
-		return NULL;
-	} else {
+	if (!pool) {
 		for (i = 0; i < serv->sv_nrpools; i++) {
 			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
-			if (atomic_inc_not_zero(&pool->sp_nrthreads))
-				goto found_pool;
+			if (pool->sp_nrthreads)
+				break;
 		}
-		return NULL;
 	}
 
-found_pool:
-	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
-	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
-	if (!atomic_dec_and_test(&pool->sp_nrthreads))
+	if (pool && pool->sp_nrthreads) {
+		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
+		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
 		return pool;
-	/* Nothing left in this pool any more */
-	clear_bit(SP_NEED_VICTIM, &pool->sp_flags);
-	clear_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
-	goto retry;
+	}
+	return NULL;
 }
 
 static int
@@ -840,7 +831,7 @@ svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 	if (!pool)
 		nrservs -= serv->sv_nrthreads;
 	else
-		nrservs -= atomic_read(&pool->sp_nrthreads);
+		nrservs -= pool->sp_nrthreads;
 
 	if (nrservs > 0)
 		return svc_start_kthreads(serv, pool, nrservs);
@@ -928,7 +919,7 @@ svc_exit_thread(struct svc_rqst *rqstp)
 
 	list_del_rcu(&rqstp->rq_all);
 
-	atomic_dec(&pool->sp_nrthreads);
+	pool->sp_nrthreads -= 1;
 
 	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads -= 1;
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 5a526ebafeb4..3c9e25f6a1d2 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -163,8 +163,12 @@ static int bearer_name_validate(const char *name,
 
 	/* return bearer name components, if necessary */
 	if (name_parts) {
-		strcpy(name_parts->media_name, media_name);
-		strcpy(name_parts->if_name, if_name);
+		if (strscpy(name_parts->media_name, media_name,
+			    TIPC_MAX_MEDIA_NAME) < 0)
+			return 0;
+		if (strscpy(name_parts->if_name, if_name,
+			    TIPC_MAX_IF_NAME) < 0)
+			return 0;
 	}
 	return 1;
 }
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e3bf14e489c5..9675ceaa5bf6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10024,7 +10024,20 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
 	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
 	if (!err) {
-		wdev->links[0].ap.chandef = chandef;
+		switch (wdev->iftype) {
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
+			wdev->links[0].ap.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_ADHOC:
+			wdev->u.ibss.chandef = chandef;
+			break;
+		case NL80211_IFTYPE_MESH_POINT:
+			wdev->u.mesh.chandef = chandef;
+			break;
+		default:
+			break;
+		}
 		wdev->cac_started = true;
 		wdev->cac_start_time = jiffies;
 		wdev->cac_time_ms = cac_time_ms;
diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index babc731bd5f6..ce2ee8d87865 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -83,8 +83,12 @@ pub struct LockedBy<T: ?Sized, U: ?Sized> {
 // SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
 unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
 
-// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
-// data it protects is `Send`.
+// SAFETY: If `T` is not `Sync`, then parallel shared access to this `LockedBy` allows you to use
+// `access_mut` to hand out `&mut T` on one thread at the time. The requirement that `T: Send` is
+// sufficient to allow that.
+//
+// If `T` is `Sync`, then the `access` method also becomes available, which allows you to obtain
+// several `&T` from several threads at once. However, this is okay as `T` is `Sync`.
 unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
 
 impl<T, U> LockedBy<T, U> {
@@ -118,7 +122,10 @@ impl<T: ?Sized, U> LockedBy<T, U> {
     ///
     /// Panics if `owner` is different from the data protected by the lock used in
     /// [`new`](LockedBy::new).
-    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
+    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
+    where
+        T: Sync,
+    {
         build_assert!(
             size_of::<U>() > 0,
             "`U` cannot be a ZST because `owner` wouldn't be unique"
@@ -127,7 +134,10 @@ pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
             panic!("mismatched owners");
         }
 
-        // SAFETY: `owner` is evidence that the owner is locked.
+        // SAFETY: `owner` is evidence that there are only shared references to the owner for the
+        // duration of 'a, so it's not possible to use `Self::access_mut` to obtain a mutable
+        // reference to the inner value that aliases with this shared reference. The type is `Sync`
+        // so there are no other requirements.
         unsafe { &*self.data.get() }
     }
 
diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 43c687e7a69d..65dd1bd12964 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -18,6 +18,7 @@ from linux import utils
 from linux import tasks
 from linux import lists
 from linux import vfs
+from linux import rbtree
 from struct import *
 
 
@@ -172,8 +173,7 @@ values of that process namespace"""
         gdb.write("{:^18} {:^15} {:>9} {} {} options\n".format(
                   "mount", "super_block", "devname", "pathname", "fstype"))
 
-        for mnt in lists.list_for_each_entry(namespace['list'],
-                                             mount_ptr_type, "mnt_list"):
+        for mnt in rbtree.rb_inorder_for_each_entry(namespace['mounts'], mount_ptr_type, "mnt_node"):
             devname = mnt['mnt_devname'].string()
             devname = devname if devname else "none"
 
diff --git a/scripts/gdb/linux/rbtree.py b/scripts/gdb/linux/rbtree.py
index fe462855eefd..fcbcc5f4153c 100644
--- a/scripts/gdb/linux/rbtree.py
+++ b/scripts/gdb/linux/rbtree.py
@@ -9,6 +9,18 @@ from linux import utils
 rb_root_type = utils.CachedType("struct rb_root")
 rb_node_type = utils.CachedType("struct rb_node")
 
+def rb_inorder_for_each(root):
+    def inorder(node):
+        if node:
+            yield from inorder(node['rb_left'])
+            yield node
+            yield from inorder(node['rb_right'])
+
+    yield from inorder(root['rb_node'])
+
+def rb_inorder_for_each_entry(root, gdbtype, member):
+    for node in rb_inorder_for_each(root):
+        yield utils.container_of(node, gdbtype, member)
 
 def rb_first(root):
     if root.type == rb_root_type.get_type():
diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 64bc87191003..98445671fe83 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -87,21 +87,22 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
             text += "\n"
 
         if constants.LX_CONFIG_TICK_ONESHOT:
-            fmts = [("  .{}      : {}", 'nohz_mode'),
-                    ("  .{}      : {} nsecs", 'last_tick'),
-                    ("  .{}   : {}", 'tick_stopped'),
-                    ("  .{}   : {}", 'idle_jiffies'),
-                    ("  .{}     : {}", 'idle_calls'),
-                    ("  .{}    : {}", 'idle_sleeps'),
-                    ("  .{} : {} nsecs", 'idle_entrytime'),
-                    ("  .{}  : {} nsecs", 'idle_waketime'),
-                    ("  .{}  : {} nsecs", 'idle_exittime'),
-                    ("  .{} : {} nsecs", 'idle_sleeptime'),
-                    ("  .{}: {} nsecs", 'iowait_sleeptime'),
-                    ("  .{}   : {}", 'last_jiffies'),
-                    ("  .{}     : {}", 'next_timer'),
-                    ("  .{}   : {} nsecs", 'idle_expires')]
-            text += "\n".join([s.format(f, ts[f]) for s, f in fmts])
+            TS_FLAG_STOPPED = 1 << 1
+            TS_FLAG_NOHZ = 1 << 4
+            text += f"  .{'nohz':15s}: {int(bool(ts['flags'] & TS_FLAG_NOHZ))}\n"
+            text += f"  .{'last_tick':15s}: {ts['last_tick']}\n"
+            text += f"  .{'tick_stopped':15s}: {int(bool(ts['flags'] & TS_FLAG_STOPPED))}\n"
+            text += f"  .{'idle_jiffies':15s}: {ts['idle_jiffies']}\n"
+            text += f"  .{'idle_calls':15s}: {ts['idle_calls']}\n"
+            text += f"  .{'idle_sleeps':15s}: {ts['idle_sleeps']}\n"
+            text += f"  .{'idle_entrytime':15s}: {ts['idle_entrytime']} nsecs\n"
+            text += f"  .{'idle_waketime':15s}: {ts['idle_waketime']} nsecs\n"
+            text += f"  .{'idle_exittime':15s}: {ts['idle_exittime']} nsecs\n"
+            text += f"  .{'idle_sleeptime':15s}: {ts['idle_sleeptime']} nsecs\n"
+            text += f"  .{'iowait_sleeptime':15s}: {ts['iowait_sleeptime']} nsecs\n"
+            text += f"  .{'last_jiffies':15s}: {ts['last_jiffies']}\n"
+            text += f"  .{'next_timer':15s}: {ts['next_timer']}\n"
+            text += f"  .{'idle_expires':15s}: {ts['idle_expires']} nsecs\n"
             text += "\njiffies: {}\n".format(jiffies)
 
         text += "\n"
diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index c6c42c0f4e5d..b7fc5aeb78cc 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1174,7 +1174,7 @@ void ConfigInfoView::clicked(const QUrl &url)
 {
 	QByteArray str = url.toEncoded();
 	const std::size_t count = str.size();
-	char *data = new char[count + 1];
+	char *data = new char[count + 2];  // '$' + '\0'
 	struct symbol **result;
 	struct menu *m = NULL;
 
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..a93c1a9b7c28 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -19,6 +19,38 @@ config SECURITY_DMESG_RESTRICT
 
 	  If you are unsure how to answer this question, answer N.
 
+choice
+	prompt "Allow /proc/pid/mem access override"
+	default PROC_MEM_ALWAYS_FORCE
+	help
+	  Traditionally /proc/pid/mem allows users to override memory
+	  permissions for users like ptrace, assuming they have ptrace
+	  capability.
+
+	  This allows people to limit that - either never override, or
+	  require actual active ptrace attachment.
+
+	  Defaults to the traditional behavior (for now)
+
+config PROC_MEM_ALWAYS_FORCE
+	bool "Traditional /proc/pid/mem behavior"
+	help
+	  This allows /proc/pid/mem accesses to override memory mapping
+	  permissions if you have ptrace access rights.
+
+config PROC_MEM_FORCE_PTRACE
+	bool "Require active ptrace() use for access override"
+	help
+	  This allows /proc/pid/mem accesses to override memory mapping
+	  permissions for active ptracers like gdb.
+
+config PROC_MEM_NO_FORCE
+	bool "Never"
+	help
+	  Never override memory mapping permissions
+
+endchoice
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 90b53500a236..aed9e3ef2c9e 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -723,10 +723,13 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 	ee->r.obj = &ee->obj;
 	ee->obj.path1 = bprm->file->f_path;
 	/* Get symlink's pathname of program. */
-	retval = -ENOENT;
 	exename.name = tomoyo_realpath_nofollow(original_name);
-	if (!exename.name)
-		goto out;
+	if (!exename.name) {
+		/* Fallback to realpath if symlink's pathname does not exist. */
+		exename.name = tomoyo_realpath_from_path(&bprm->file->f_path);
+		if (!exename.name)
+			goto out;
+	}
 	tomoyo_fill_path_info(&exename);
 retry:
 	/* Check 'aggregator' directive. */
diff --git a/sound/core/control.c b/sound/core/control.c
index 1dd2337e2930..c18a9e6539b3 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1164,10 +1164,7 @@ static int __snd_ctl_elem_info(struct snd_card *card,
 #ifdef CONFIG_SND_DEBUG
 	info->access = 0;
 #endif
-	result = snd_power_ref_and_wait(card);
-	if (!result)
-		result = kctl->info(kctl, info);
-	snd_power_unref(card);
+	result = kctl->info(kctl, info);
 	if (result >= 0) {
 		snd_BUG_ON(info->access);
 		index_offset = snd_ctl_get_ioff(kctl, &info->id);
@@ -1205,12 +1202,17 @@ static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
 static int snd_ctl_elem_info_user(struct snd_ctl_file *ctl,
 				  struct snd_ctl_elem_info __user *_info)
 {
+	struct snd_card *card = ctl->card;
 	struct snd_ctl_elem_info info;
 	int result;
 
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
+	result = snd_power_ref_and_wait(card);
+	if (result)
+		return result;
 	result = snd_ctl_elem_info(ctl, &info);
+	snd_power_unref(card);
 	if (result < 0)
 		return result;
 	/* drop internal access flags */
@@ -1254,10 +1256,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
 
 	if (!snd_ctl_skip_validation(&info))
 		fill_remaining_elem_value(control, &info, pattern);
-	ret = snd_power_ref_and_wait(card);
-	if (!ret)
-		ret = kctl->get(kctl, control);
-	snd_power_unref(card);
+	ret = kctl->get(kctl, control);
 	if (ret < 0)
 		return ret;
 	if (!snd_ctl_skip_validation(&info) &&
@@ -1282,7 +1281,11 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 	if (IS_ERR(control))
 		return PTR_ERR(no_free_ptr(control));
 
+	result = snd_power_ref_and_wait(card);
+	if (result)
+		return result;
 	result = snd_ctl_elem_read(card, control);
+	snd_power_unref(card);
 	if (result < 0)
 		return result;
 
@@ -1297,7 +1300,7 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_volatile *vd;
 	unsigned int index_offset;
-	int result;
+	int result = 0;
 
 	down_write(&card->controls_rwsem);
 	kctl = snd_ctl_find_id_locked(card, &control->id);
@@ -1315,9 +1318,8 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	}
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
-	result = snd_power_ref_and_wait(card);
 	/* validate input values */
-	if (IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION) && !result) {
+	if (IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION)) {
 		struct snd_ctl_elem_info info;
 
 		memset(&info, 0, sizeof(info));
@@ -1329,7 +1331,6 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	}
 	if (!result)
 		result = kctl->put(kctl, control);
-	snd_power_unref(card);
 	if (result < 0) {
 		up_write(&card->controls_rwsem);
 		return result;
@@ -1358,7 +1359,11 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 		return PTR_ERR(no_free_ptr(control));
 
 	card = file->card;
+	result = snd_power_ref_and_wait(card);
+	if (result < 0)
+		return result;
 	result = snd_ctl_elem_write(card, file, control);
+	snd_power_unref(card);
 	if (result < 0)
 		return result;
 
@@ -1827,7 +1832,7 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 		{SNDRV_CTL_TLV_OP_CMD,   SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND},
 	};
 	struct snd_kcontrol_volatile *vd = &kctl->vd[snd_ctl_get_ioff(kctl, id)];
-	int i, ret;
+	int i;
 
 	/* Check support of the request for this element. */
 	for (i = 0; i < ARRAY_SIZE(pairs); ++i) {
@@ -1845,11 +1850,7 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 	    vd->owner != NULL && vd->owner != file)
 		return -EPERM;
 
-	ret = snd_power_ref_and_wait(file->card);
-	if (!ret)
-		ret = kctl->tlv.c(kctl, op_flag, size, buf);
-	snd_power_unref(file->card);
-	return ret;
+	return kctl->tlv.c(kctl, op_flag, size, buf);
 }
 
 static int read_tlv_buf(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id,
@@ -1962,16 +1963,28 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	case SNDRV_CTL_IOCTL_SUBSCRIBE_EVENTS:
 		return snd_ctl_subscribe_events(ctl, ip);
 	case SNDRV_CTL_IOCTL_TLV_READ:
-		scoped_guard(rwsem_read, &ctl->card->controls_rwsem)
+		err = snd_power_ref_and_wait(card);
+		if (err < 0)
+			return err;
+		scoped_guard(rwsem_read, &card->controls_rwsem)
 			err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_READ);
+		snd_power_unref(card);
 		return err;
 	case SNDRV_CTL_IOCTL_TLV_WRITE:
-		scoped_guard(rwsem_write, &ctl->card->controls_rwsem)
+		err = snd_power_ref_and_wait(card);
+		if (err < 0)
+			return err;
+		scoped_guard(rwsem_write, &card->controls_rwsem)
 			err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_WRITE);
+		snd_power_unref(card);
 		return err;
 	case SNDRV_CTL_IOCTL_TLV_COMMAND:
-		scoped_guard(rwsem_write, &ctl->card->controls_rwsem)
+		err = snd_power_ref_and_wait(card);
+		if (err < 0)
+			return err;
+		scoped_guard(rwsem_write, &card->controls_rwsem)
 			err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_CMD);
+		snd_power_unref(card);
 		return err;
 	case SNDRV_CTL_IOCTL_POWER:
 		return -ENOPROTOOPT;
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 934bb945e702..ff0031cc7dfb 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -79,6 +79,7 @@ struct snd_ctl_elem_info32 {
 static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
 				    struct snd_ctl_elem_info32 __user *data32)
 {
+	struct snd_card *card = ctl->card;
 	struct snd_ctl_elem_info *data __free(kfree) = NULL;
 	int err;
 
@@ -95,7 +96,11 @@ static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
 	if (get_user(data->value.enumerated.item, &data32->value.enumerated.item))
 		return -EFAULT;
 
+	err = snd_power_ref_and_wait(card);
+	if (err < 0)
+		return err;
 	err = snd_ctl_elem_info(ctl, data);
+	snd_power_unref(card);
 	if (err < 0)
 		return err;
 	/* restore info to 32bit */
@@ -175,10 +180,7 @@ static int get_ctl_type(struct snd_card *card, struct snd_ctl_elem_id *id,
 	if (info == NULL)
 		return -ENOMEM;
 	info->id = *id;
-	err = snd_power_ref_and_wait(card);
-	if (!err)
-		err = kctl->info(kctl, info);
-	snd_power_unref(card);
+	err = kctl->info(kctl, info);
 	if (err >= 0) {
 		err = info->type;
 		*countp = info->count;
@@ -275,8 +277,8 @@ static int copy_ctl_value_to_user(void __user *userdata,
 	return 0;
 }
 
-static int ctl_elem_read_user(struct snd_card *card,
-			      void __user *userdata, void __user *valuep)
+static int __ctl_elem_read_user(struct snd_card *card,
+				void __user *userdata, void __user *valuep)
 {
 	struct snd_ctl_elem_value *data __free(kfree) = NULL;
 	int err, type, count;
@@ -296,8 +298,21 @@ static int ctl_elem_read_user(struct snd_card *card,
 	return copy_ctl_value_to_user(userdata, valuep, data, type, count);
 }
 
-static int ctl_elem_write_user(struct snd_ctl_file *file,
-			       void __user *userdata, void __user *valuep)
+static int ctl_elem_read_user(struct snd_card *card,
+			      void __user *userdata, void __user *valuep)
+{
+	int err;
+
+	err = snd_power_ref_and_wait(card);
+	if (err < 0)
+		return err;
+	err = __ctl_elem_read_user(card, userdata, valuep);
+	snd_power_unref(card);
+	return err;
+}
+
+static int __ctl_elem_write_user(struct snd_ctl_file *file,
+				 void __user *userdata, void __user *valuep)
 {
 	struct snd_ctl_elem_value *data __free(kfree) = NULL;
 	struct snd_card *card = file->card;
@@ -318,6 +333,20 @@ static int ctl_elem_write_user(struct snd_ctl_file *file,
 	return copy_ctl_value_to_user(userdata, valuep, data, type, count);
 }
 
+static int ctl_elem_write_user(struct snd_ctl_file *file,
+			       void __user *userdata, void __user *valuep)
+{
+	struct snd_card *card = file->card;
+	int err;
+
+	err = snd_power_ref_and_wait(card);
+	if (err < 0)
+		return err;
+	err = __ctl_elem_write_user(file, userdata, valuep);
+	snd_power_unref(card);
+	return err;
+}
+
 static int snd_ctl_elem_read_user_compat(struct snd_card *card,
 					 struct snd_ctl_elem_value32 __user *data32)
 {
diff --git a/sound/core/init.c b/sound/core/init.c
index b9b708cf980d..27e7569ace99 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -654,13 +654,19 @@ void snd_card_free(struct snd_card *card)
 }
 EXPORT_SYMBOL(snd_card_free);
 
+/* check, if the character is in the valid ASCII range */
+static inline bool safe_ascii_char(char c)
+{
+	return isascii(c) && isalnum(c);
+}
+
 /* retrieve the last word of shortname or longname */
 static const char *retrieve_id_from_card_name(const char *name)
 {
 	const char *spos = name;
 
 	while (*name) {
-		if (isspace(*name) && isalnum(name[1]))
+		if (isspace(*name) && safe_ascii_char(name[1]))
 			spos = name + 1;
 		name++;
 	}
@@ -687,12 +693,12 @@ static void copy_valid_id_string(struct snd_card *card, const char *src,
 {
 	char *id = card->id;
 
-	while (*nid && !isalnum(*nid))
+	while (*nid && !safe_ascii_char(*nid))
 		nid++;
 	if (isdigit(*nid))
 		*id++ = isalpha(*src) ? *src : 'D';
 	while (*nid && (size_t)(id - card->id) < sizeof(card->id) - 1) {
-		if (isalnum(*nid))
+		if (safe_ascii_char(*nid))
 			*id++ = *nid;
 		nid++;
 	}
@@ -787,7 +793,7 @@ static ssize_t id_store(struct device *dev, struct device_attribute *attr,
 
 	for (idx = 0; idx < copy; idx++) {
 		c = buf[idx];
-		if (!isalnum(c) && c != '_' && c != '-')
+		if (!safe_ascii_char(c) && c != '_' && c != '-')
 			return -EINVAL;
 	}
 	memcpy(buf1, buf, copy);
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 6a0508093ea6..81af725ea40e 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -901,8 +901,8 @@ static void snd_mixer_oss_slot_free(struct snd_mixer_oss_slot *chn)
 	struct slot *p = chn->private_data;
 	if (p) {
 		if (p->allocated && p->assigned) {
-			kfree_const(p->assigned->name);
-			kfree_const(p->assigned);
+			kfree(p->assigned->name);
+			kfree(p->assigned);
 		}
 		kfree(p);
 	}
diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 850544725da7..d55c3dc229c0 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -378,7 +378,7 @@ static int snd_gf1_pcm_playback_copy(struct snd_pcm_substream *substream,
 
 	bpos = get_bpos(pcmp, voice, pos, len);
 	if (bpos < 0)
-		return pos;
+		return bpos;
 	if (copy_from_iter(runtime->dma_area + bpos, len, src) != len)
 		return -EFAULT;
 	return playback_copy_ack(substream, bpos, len);
@@ -395,7 +395,7 @@ static int snd_gf1_pcm_playback_silence(struct snd_pcm_substream *substream,
 	
 	bpos = get_bpos(pcmp, voice, pos, len);
 	if (bpos < 0)
-		return pos;
+		return bpos;
 	snd_pcm_format_set_silence(runtime->format, runtime->dma_area + bpos,
 				   bytes_to_samples(runtime, count));
 	return playback_copy_ack(substream, bpos, len);
diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index d0caef299481..b68e6bfbbfba 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -708,7 +708,7 @@ static u16 HPIMSGX__init(struct hpi_message *phm,
 		phr->error = HPI_ERROR_PROCESSING_MESSAGE;
 		return phr->error;
 	}
-	if (hr.error == 0) {
+	if (hr.error == 0 && hr.u.s.adapter_index < HPI_MAX_ADAPTERS) {
 		/* the adapter was created successfully
 		   save the mapping for future use */
 		hpi_entry_points[hr.u.s.adapter_index] = entry_point_func;
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 68c883f202ca..c2d0109866e6 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -28,7 +28,7 @@
 #else
 #define AZX_DCAPS_I915_COMPONENT 0		/* NOP */
 #endif
-#define AZX_DCAPS_AMD_ALLOC_FIX	(1 << 14)	/* AMD allocation workaround */
+/* 14 unused */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
 #define AZX_DCAPS_AMD_WORKAROUND (1 << 17)	/* AMD-specific workaround */
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 9cff87dfbecb..b34d84fedcc8 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1383,7 +1383,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		struct nid_path *path;
 		hda_nid_t pin = pins[i];
 
-		if (!spec->obey_preferred_dacs) {
+		if (!spec->preferred_dacs) {
 			path = snd_hda_get_path_from_idx(codec, path_idx[i]);
 			if (path) {
 				badness += assign_out_path_ctls(codec, path);
@@ -1395,7 +1395,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		if (dacs[i]) {
 			if (is_dac_already_used(codec, dacs[i]))
 				badness += bad->shared_primary;
-		} else if (spec->obey_preferred_dacs) {
+		} else if (spec->preferred_dacs) {
 			badness += BAD_NO_PRIMARY_DAC;
 		}
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 87203b819dd4..3500108f6ba3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -40,7 +40,6 @@
 
 #ifdef CONFIG_X86
 /* for snoop control */
-#include <linux/dma-map-ops.h>
 #include <asm/set_memory.h>
 #include <asm/cpufeature.h>
 #endif
@@ -307,7 +306,7 @@ enum {
 
 /* quirks for ATI HDMI with snoop off */
 #define AZX_DCAPS_PRESET_ATI_HDMI_NS \
-	(AZX_DCAPS_PRESET_ATI_HDMI | AZX_DCAPS_AMD_ALLOC_FIX)
+	(AZX_DCAPS_PRESET_ATI_HDMI | AZX_DCAPS_SNOOP_OFF)
 
 /* quirks for AMD SB */
 #define AZX_DCAPS_PRESET_AMD_SB \
@@ -1703,13 +1702,6 @@ static void azx_check_snoop_available(struct azx *chip)
 	if (chip->driver_caps & AZX_DCAPS_SNOOP_OFF)
 		snoop = false;
 
-#ifdef CONFIG_X86
-	/* check the presence of DMA ops (i.e. IOMMU), disable snoop conditionally */
-	if ((chip->driver_caps & AZX_DCAPS_AMD_ALLOC_FIX) &&
-	    !get_dma_ops(chip->card->dev))
-		snoop = false;
-#endif
-
 	chip->snoop = snoop;
 	if (!snoop) {
 		dev_info(chip->card->dev, "Force to non-snoop mode\n");
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e851785ff058..4a2c8274c3df 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -816,6 +816,23 @@ static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
 	{}
 };
 
+/* pincfg quirk for Tuxedo Sirius;
+ * unfortunately the (PCI) SSID conflicts with System76 Pangolin pang14,
+ * which has incompatible pin setup, so we check the codec SSID (luckily
+ * different one!) and conditionally apply the quirk here
+ */
+static void cxt_fixup_sirius_top_speaker(struct hda_codec *codec,
+					 const struct hda_fixup *fix,
+					 int action)
+{
+	/* ignore for incorrectly picked-up pang14 */
+	if (codec->core.subsystem_id == 0x278212b3)
+		return;
+	/* set up the top speaker pin */
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		snd_hda_codec_set_pincfg(codec, 0x1d, 0x82170111);
+}
+
 static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_X200] = {
 		.type = HDA_FIXUP_PINS,
@@ -976,11 +993,8 @@ static const struct hda_fixup cxt_fixups[] = {
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
 	[CXT_PINCFG_TOP_SPEAKER] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x1d, 0x82170111 },
-			{ }
-		},
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_sirius_top_speaker,
 	},
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2b674691ce4b..9268f43e7779 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -583,6 +583,7 @@ static void alc_shutup_pins(struct hda_codec *codec)
 	switch (codec->core.vendor_id) {
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 	case 0x10ec0283:
 	case 0x10ec0285:
@@ -10161,6 +10162,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x88dd, "HP Pavilion 15z-ec200", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8902, "HP OMEN 16", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x890e, "HP 255 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8919, "HP Pavilion Aero Laptop 13-be0xxx", ALC287_FIXUP_HP_GPIO_LED),
@@ -10302,6 +10304,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8caf, "HP Elite mt645 G8 Mobile Thin Client", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8cbd, "HP Pavilion Aero Laptop 13-bg0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8cdd, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8cde, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
@@ -10650,6 +10653,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38d2, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38d7, "Lenovo Yoga 9 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x38df, "Y990 YG DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38f9, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38fa, "Thinkbook 16P Gen5", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
@@ -10684,6 +10688,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1854, 0x0441, "LG CQ6 AIO", ALC256_FIXUP_HEADPHONE_AMP_VOL),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
 	SND_PCI_QUIRK(0x19e5, 0x320f, "Huawei WRT-WX9 ", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x19e5, 0x3212, "Huawei KLV-WX9 ", ALC256_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1b35, 0x1235, "CZC B20", ALC269_FIXUP_CZC_B20),
 	SND_PCI_QUIRK(0x1b35, 0x1236, "CZC TMI", ALC269_FIXUP_CZC_TMI),
 	SND_PCI_QUIRK(0x1b35, 0x1237, "CZC L101", ALC269_FIXUP_CZC_L101),
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index e7d1b43471a2..713ca262a0e9 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1298,8 +1298,10 @@ static int snd_hdsp_midi_output_possible (struct hdsp *hdsp, int id)
 
 static void snd_hdsp_flush_midi_input (struct hdsp *hdsp, int id)
 {
-	while (snd_hdsp_midi_input_available (hdsp, id))
-		snd_hdsp_midi_read_byte (hdsp, id);
+	int count = 256;
+
+	while (snd_hdsp_midi_input_available(hdsp, id) && --count)
+		snd_hdsp_midi_read_byte(hdsp, id);
 }
 
 static int snd_hdsp_midi_output_write (struct hdsp_midi *hmidi)
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 267c7848974a..74215f57f4fc 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1838,8 +1838,10 @@ static inline int snd_hdspm_midi_output_possible (struct hdspm *hdspm, int id)
 
 static void snd_hdspm_flush_midi_input(struct hdspm *hdspm, int id)
 {
-	while (snd_hdspm_midi_input_available (hdspm, id))
-		snd_hdspm_midi_read_byte (hdspm, id);
+	int count = 256;
+
+	while (snd_hdspm_midi_input_available(hdspm, id) && --count)
+		snd_hdspm_midi_read_byte(hdspm, id);
 }
 
 static int snd_hdspm_midi_output_write (struct hdspm_midi *hmidi)
diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index dcc4e14b3dde..206bbb5aaab5 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -285,6 +285,9 @@ static int mchp_pdmc_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	if (!substream)
 		return -ENODEV;
 
+	if (!substream->runtime)
+		return 0; /* just for avoiding error from alsactl restore */
+
 	map = mchp_pdmc_chmap_get(substream, info);
 	if (!map)
 		return -EINVAL;
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 2169d9398984..1831d4487ba9 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -998,15 +998,19 @@ static const struct reg_sequence reg_init[] = {
 	{WSA883X_GMAMP_SUP1, 0xE2},
 };
 
-static void wsa883x_init(struct wsa883x_priv *wsa883x)
+static int wsa883x_init(struct wsa883x_priv *wsa883x)
 {
 	struct regmap *regmap = wsa883x->regmap;
-	int variant, version;
+	int variant, version, ret;
 
-	regmap_read(regmap, WSA883X_OTP_REG_0, &variant);
+	ret = regmap_read(regmap, WSA883X_OTP_REG_0, &variant);
+	if (ret)
+		return ret;
 	wsa883x->variant = variant & WSA883X_ID_MASK;
 
-	regmap_read(regmap, WSA883X_CHIP_ID0, &version);
+	ret = regmap_read(regmap, WSA883X_CHIP_ID0, &version);
+	if (ret)
+		return ret;
 	wsa883x->version = version;
 
 	switch (wsa883x->variant) {
@@ -1041,6 +1045,8 @@ static void wsa883x_init(struct wsa883x_priv *wsa883x)
 				   WSA883X_DRE_OFFSET_MASK,
 				   wsa883x->comp_offset);
 	}
+
+	return 0;
 }
 
 static int wsa883x_update_status(struct sdw_slave *slave,
@@ -1049,7 +1055,7 @@ static int wsa883x_update_status(struct sdw_slave *slave,
 	struct wsa883x_priv *wsa883x = dev_get_drvdata(&slave->dev);
 
 	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
-		wsa883x_init(wsa883x);
+		return wsa883x_init(wsa883x);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index 0e18ccabe28c..ce0d8cec375a 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -713,6 +713,7 @@ static int imx_card_probe(struct platform_device *pdev)
 
 	data->plat_data = plat_data;
 	data->card.dev = &pdev->dev;
+	data->card.owner = THIS_MODULE;
 
 	dev_set_drvdata(&pdev->dev, &data->card);
 	snd_soc_card_set_drvdata(&data->card, data);
diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index df3c2a7b64d2..8c2b4ab764bb 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -255,7 +255,11 @@ static int snd_byt_cht_cx2072x_probe(struct platform_device *pdev)
 		snprintf(codec_name, sizeof(codec_name), "i2c-%s",
 			 acpi_dev_name(adev));
 		byt_cht_cx2072x_dais[dai_index].codecs->name = codec_name;
+	} else {
+		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		return -ENOENT;
 	}
+
 	acpi_dev_put(adev);
 
 	/* override platform name, if required */
diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 08c598b7e1ee..9178bbe8d995 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -258,7 +258,11 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 		snprintf(codec_name, sizeof(codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
 		dailink[dai_index].codecs->name = codec_name;
+	} else {
+		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		return -ENOENT;
 	}
+
 	acpi_dev_put(adev);
 
 	/* override platform name, if required */
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 77b91ea4dc32..3539c9ff0fd2 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -562,7 +562,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		byt_cht_es8316_dais[dai_index].codecs->name = codec_name;
 	} else {
 		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
-		return -ENXIO;
+		return -ENOENT;
 	}
 
 	codec_dev = acpi_get_first_physical_node(adev);
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index db4a33680d94..4479825c08b5 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1693,7 +1693,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		byt_rt5640_dais[dai_index].codecs->name = byt_rt5640_codec_name;
 	} else {
 		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
-		return -ENXIO;
+		return -ENOENT;
 	}
 
 	codec_dev = acpi_get_first_physical_node(adev);
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 8514b79f389b..1f54da98aacf 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -926,7 +926,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		byt_rt5651_dais[dai_index].codecs->name = byt_rt5651_codec_name;
 	} else {
 		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
-		return -ENXIO;
+		return -ENOENT;
 	}
 
 	codec_dev = acpi_get_first_physical_node(adev);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 1da9ceee4d59..ac23a8b7cafc 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -582,7 +582,11 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		snprintf(cht_rt5645_codec_name, sizeof(cht_rt5645_codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
 		cht_dailink[dai_index].codecs->name = cht_rt5645_codec_name;
+	} else {
+		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		return -ENOENT;
 	}
+
 	/* acpi_get_first_physical_node() returns a borrowed ref, no need to deref */
 	codec_dev = acpi_get_first_physical_node(adev);
 	acpi_dev_put(adev);
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index d68e5bc755de..c6c469d51243 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -479,7 +479,11 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		snprintf(drv->codec_name, sizeof(drv->codec_name),
 			 "i2c-%s", acpi_dev_name(adev));
 		cht_dailink[dai_index].codecs->name = drv->codec_name;
+	}  else {
+		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		return -ENOENT;
 	}
+
 	acpi_dev_put(adev);
 
 	/* Use SSP0 on Bay Trail CR devices */
diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index c1fcc156a575..809532238c44 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -681,7 +681,7 @@ static int sof_es8336_probe(struct platform_device *pdev)
 			dai_links[0].codecs->dai_name = "ES8326 HiFi";
 	} else {
 		dev_err(dev, "Error cannot find '%s' dev\n", mach->id);
-		return -ENXIO;
+		return -ENOENT;
 	}
 
 	codec_dev = acpi_get_first_physical_node(adev);
diff --git a/sound/soc/intel/boards/sof_wm8804.c b/sound/soc/intel/boards/sof_wm8804.c
index 4cb0d463bf40..9c5b3f8f09f3 100644
--- a/sound/soc/intel/boards/sof_wm8804.c
+++ b/sound/soc/intel/boards/sof_wm8804.c
@@ -270,7 +270,11 @@ static int sof_wm8804_probe(struct platform_device *pdev)
 		snprintf(codec_name, sizeof(codec_name),
 			 "%s%s", "i2c-", acpi_dev_name(adev));
 		dailink[dai_index].codecs->name = codec_name;
+	} else {
+		dev_err(&pdev->dev, "Error cannot find '%s' dev\n", mach->id);
+		return -ENOENT;
 	}
+
 	acpi_dev_put(adev);
 
 	snd_soc_card_set_drvdata(card, ctx);
diff --git a/sound/usb/card.c b/sound/usb/card.c
index bdb04fa37a71..8f01a4b1fa0f 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -382,6 +382,12 @@ static const struct usb_audio_device_name usb_audio_names[] = {
 	/* Creative/Toshiba Multimedia Center SB-0500 */
 	DEVICE_NAME(0x041e, 0x3048, "Toshiba", "SB-0500"),
 
+	/* Logitech Audio Devices */
+	DEVICE_NAME(0x046d, 0x0867, "Logitech, Inc.", "Logi-MeetUp"),
+	DEVICE_NAME(0x046d, 0x0874, "Logitech, Inc.", "Logi-Tap-Audio"),
+	DEVICE_NAME(0x046d, 0x087c, "Logitech, Inc.", "Logi-Huddle"),
+	DEVICE_NAME(0x046d, 0x0898, "Logitech, Inc.", "Logi-RB-Audio"),
+	DEVICE_NAME(0x046d, 0x08d2, "Logitech, Inc.", "Logi-RBM-Audio"),
 	DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"),
 
 	DEVICE_NAME(0x05e1, 0x0408, "Syntek", "STK1160"),
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index ffd8c157a281..70de08635f54 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -507,7 +507,7 @@ static const struct line6_properties podhd_properties_table[] = {
 	[LINE6_PODHD500X] = {
 		.id = "PODHD500X",
 		.name = "POD HD500X",
-		.capabilities	= LINE6_CAP_CONTROL
+		.capabilities	= LINE6_CAP_CONTROL | LINE6_CAP_HWMON_CTL
 				| LINE6_CAP_PCM | LINE6_CAP_HWMON,
 		.altsetting = 1,
 		.ep_ctrl_r = 0x81,
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 8cc2d4937f34..197fd07e69ed 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1377,6 +1377,19 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
 
 #define get_min_max(cval, def)	get_min_max_with_quirks(cval, def, NULL)
 
+/* get the max value advertised via control API */
+static int get_max_exposed(struct usb_mixer_elem_info *cval)
+{
+	if (!cval->max_exposed) {
+		if (cval->res)
+			cval->max_exposed =
+				DIV_ROUND_UP(cval->max - cval->min, cval->res);
+		else
+			cval->max_exposed = cval->max - cval->min;
+	}
+	return cval->max_exposed;
+}
+
 /* get a feature/mixer unit info */
 static int mixer_ctl_feature_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
@@ -1389,11 +1402,8 @@ static int mixer_ctl_feature_info(struct snd_kcontrol *kcontrol,
 	else
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = cval->channels;
-	if (cval->val_type == USB_MIXER_BOOLEAN ||
-	    cval->val_type == USB_MIXER_INV_BOOLEAN) {
-		uinfo->value.integer.min = 0;
-		uinfo->value.integer.max = 1;
-	} else {
+	if (cval->val_type != USB_MIXER_BOOLEAN &&
+	    cval->val_type != USB_MIXER_INV_BOOLEAN) {
 		if (!cval->initialized) {
 			get_min_max_with_quirks(cval, 0, kcontrol);
 			if (cval->initialized && cval->dBmin >= cval->dBmax) {
@@ -1405,10 +1415,10 @@ static int mixer_ctl_feature_info(struct snd_kcontrol *kcontrol,
 					       &kcontrol->id);
 			}
 		}
-		uinfo->value.integer.min = 0;
-		uinfo->value.integer.max =
-			DIV_ROUND_UP(cval->max - cval->min, cval->res);
 	}
+
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = get_max_exposed(cval);
 	return 0;
 }
 
@@ -1449,6 +1459,7 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_info *cval = kcontrol->private_data;
+	int max_val = get_max_exposed(cval);
 	int c, cnt, val, oval, err;
 	int changed = 0;
 
@@ -1461,6 +1472,8 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 			if (err < 0)
 				return filter_error(cval, err);
 			val = ucontrol->value.integer.value[cnt];
+			if (val < 0 || val > max_val)
+				return -EINVAL;
 			val = get_abs_value(cval, val);
 			if (oval != val) {
 				snd_usb_set_cur_mix_value(cval, c + 1, cnt, val);
@@ -1474,6 +1487,8 @@ static int mixer_ctl_feature_put(struct snd_kcontrol *kcontrol,
 		if (err < 0)
 			return filter_error(cval, err);
 		val = ucontrol->value.integer.value[0];
+		if (val < 0 || val > max_val)
+			return -EINVAL;
 		val = get_abs_value(cval, val);
 		if (val != oval) {
 			snd_usb_set_cur_mix_value(cval, 0, 0, val);
@@ -2337,6 +2352,8 @@ static int mixer_ctl_procunit_put(struct snd_kcontrol *kcontrol,
 	if (err < 0)
 		return filter_error(cval, err);
 	val = ucontrol->value.integer.value[0];
+	if (val < 0 || val > get_max_exposed(cval))
+		return -EINVAL;
 	val = get_abs_value(cval, val);
 	if (val != oval) {
 		set_cur_ctl_value(cval, cval->control << 8, val);
@@ -2699,6 +2716,8 @@ static int mixer_ctl_selector_put(struct snd_kcontrol *kcontrol,
 	if (err < 0)
 		return filter_error(cval, err);
 	val = ucontrol->value.enumerated.item[0];
+	if (val < 0 || val >= cval->max) /* here cval->max = # elements */
+		return -EINVAL;
 	val = get_abs_value(cval, val);
 	if (val != oval) {
 		set_cur_ctl_value(cval, cval->control << 8, val);
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index d43895c1ae5c..167fbfcf01ac 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -88,6 +88,7 @@ struct usb_mixer_elem_info {
 	int channels;
 	int val_type;
 	int min, max, res;
+	int max_exposed; /* control API exposes the value in 0..max_exposed */
 	int dBmin, dBmax;
 	int cached;
 	int cache_val[MAX_CHANNELS];
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 212b5e6443d8..dd88da420c21 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -14,6 +14,7 @@
  *	    Przemek Rudy (prudy1@o2.pl)
  */
 
+#include <linux/bitfield.h>
 #include <linux/hid.h>
 #include <linux/init.h>
 #include <linux/math64.h>
@@ -2925,6 +2926,415 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
 	return 0;
 }
 
+/*
+ * RME Digiface USB
+ */
+
+#define RME_DIGIFACE_READ_STATUS 17
+#define RME_DIGIFACE_STATUS_REG0L 0
+#define RME_DIGIFACE_STATUS_REG0H 1
+#define RME_DIGIFACE_STATUS_REG1L 2
+#define RME_DIGIFACE_STATUS_REG1H 3
+#define RME_DIGIFACE_STATUS_REG2L 4
+#define RME_DIGIFACE_STATUS_REG2H 5
+#define RME_DIGIFACE_STATUS_REG3L 6
+#define RME_DIGIFACE_STATUS_REG3H 7
+
+#define RME_DIGIFACE_CTL_REG1 16
+#define RME_DIGIFACE_CTL_REG2 18
+
+/* Reg is overloaded, 0-7 for status halfwords or 16 or 18 for control registers */
+#define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
+#define RME_DIGIFACE_INVERT BIT(31)
+
+/* Nonconst helpers */
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+
+static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	struct usb_device *dev = chip->dev;
+	int err;
+
+	err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+			      item,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      val, mask, NULL, 0);
+	if (err < 0)
+		dev_err(&dev->dev,
+			"unable to issue control set request %d (ret = %d)",
+			item, err);
+	return err;
+}
+
+static int snd_rme_digiface_read_status(struct snd_kcontrol *kcontrol, u32 status[4])
+{
+	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
+	struct snd_usb_audio *chip = list->mixer->chip;
+	struct usb_device *dev = chip->dev;
+	__le32 buf[4];
+	int err;
+
+	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      RME_DIGIFACE_READ_STATUS,
+			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      0, 0,
+			      buf, sizeof(buf));
+	if (err < 0) {
+		dev_err(&dev->dev,
+			"unable to issue status read request (ret = %d)",
+			err);
+	} else {
+		for (int i = 0; i < ARRAY_SIZE(buf); i++)
+			status[i] = le32_to_cpu(buf[i]);
+	}
+	return err;
+}
+
+static int snd_rme_digiface_get_status_val(struct snd_kcontrol *kcontrol)
+{
+	int err;
+	u32 status[4];
+	bool invert = kcontrol->private_value & RME_DIGIFACE_INVERT;
+	u8 reg = (kcontrol->private_value >> 16) & 0xff;
+	u16 mask = kcontrol->private_value & 0xffff;
+	u16 val;
+
+	err = snd_rme_digiface_read_status(kcontrol, status);
+	if (err < 0)
+		return err;
+
+	switch (reg) {
+	/* Status register halfwords */
+	case RME_DIGIFACE_STATUS_REG0L ... RME_DIGIFACE_STATUS_REG3H:
+		break;
+	case RME_DIGIFACE_CTL_REG1: /* Control register 1, present in halfword 3L */
+		reg = RME_DIGIFACE_STATUS_REG3L;
+		break;
+	case RME_DIGIFACE_CTL_REG2: /* Control register 2, present in halfword 3H */
+		reg = RME_DIGIFACE_STATUS_REG3H;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (reg & 1)
+		val = status[reg >> 1] >> 16;
+	else
+		val = status[reg >> 1] & 0xffff;
+
+	if (invert)
+		val ^= mask;
+
+	return field_get(mask, val);
+}
+
+static int snd_rme_digiface_rate_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	int freq = snd_rme_digiface_get_status_val(kcontrol);
+
+	if (freq < 0)
+		return freq;
+	if (freq >= ARRAY_SIZE(snd_rme_rate_table))
+		return -EIO;
+
+	ucontrol->value.integer.value[0] = snd_rme_rate_table[freq];
+	return 0;
+}
+
+static int snd_rme_digiface_enum_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	int val = snd_rme_digiface_get_status_val(kcontrol);
+
+	if (val < 0)
+		return val;
+
+	ucontrol->value.enumerated.item[0] = val;
+	return 0;
+}
+
+static int snd_rme_digiface_enum_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	bool invert = kcontrol->private_value & RME_DIGIFACE_INVERT;
+	u8 reg = (kcontrol->private_value >> 16) & 0xff;
+	u16 mask = kcontrol->private_value & 0xffff;
+	u16 val = field_prep(mask, ucontrol->value.enumerated.item[0]);
+
+	if (invert)
+		val ^= mask;
+
+	return snd_rme_digiface_write_reg(kcontrol, reg, mask, val);
+}
+
+static int snd_rme_digiface_current_sync_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	int ret = snd_rme_digiface_enum_get(kcontrol, ucontrol);
+
+	/* 7 means internal for current sync */
+	if (ucontrol->value.enumerated.item[0] == 7)
+		ucontrol->value.enumerated.item[0] = 0;
+
+	return ret;
+}
+
+static int snd_rme_digiface_sync_state_get(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	u32 status[4];
+	int err;
+	bool valid, sync;
+
+	err = snd_rme_digiface_read_status(kcontrol, status);
+	if (err < 0)
+		return err;
+
+	valid = status[0] & BIT(kcontrol->private_value);
+	sync = status[0] & BIT(5 + kcontrol->private_value);
+
+	if (!valid)
+		ucontrol->value.enumerated.item[0] = SND_RME_CLOCK_NOLOCK;
+	else if (!sync)
+		ucontrol->value.enumerated.item[0] = SND_RME_CLOCK_LOCK;
+	else
+		ucontrol->value.enumerated.item[0] = SND_RME_CLOCK_SYNC;
+	return 0;
+}
+
+
+static int snd_rme_digiface_format_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const format[] = {
+		"ADAT", "S/PDIF"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(format), format);
+}
+
+
+static int snd_rme_digiface_sync_source_info(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_info *uinfo)
+{
+	static const char *const sync_sources[] = {
+		"Internal", "Input 1", "Input 2", "Input 3", "Input 4"
+	};
+
+	return snd_ctl_enum_info(uinfo, 1,
+				 ARRAY_SIZE(sync_sources), sync_sources);
+}
+
+static int snd_rme_digiface_rate_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 200000;
+	uinfo->value.integer.step = 0;
+	return 0;
+}
+
+static const struct snd_kcontrol_new snd_rme_digiface_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 0,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0H, BIT(0)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 1 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(3, 0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 2 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 1,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 2 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, BIT(13)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 2 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(7, 4)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 3 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 2,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 3 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, BIT(14)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 3 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(11, 8)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 4 Sync",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_sync_state_info,
+		.get = snd_rme_digiface_sync_state_get,
+		.private_value = 3,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 4 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, GENMASK(15, 12)) |
+			RME_DIGIFACE_INVERT,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input 4 Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1L, GENMASK(3, 0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 1 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 2 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(1)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 3 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(3)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output 4 Format",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_format_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG2, BIT(4)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Sync Source",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_rme_digiface_sync_source_info,
+		.get = snd_rme_digiface_enum_get,
+		.put = snd_rme_digiface_enum_put,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG1, GENMASK(2, 0)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Current Sync Source",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_digiface_sync_source_info,
+		.get = snd_rme_digiface_current_sync_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG0L, GENMASK(12, 10)),
+	},
+	{
+		/*
+		 * This is writeable, but it is only set by the PCM rate.
+		 * Mixer apps currently need to drive the mixer using raw USB requests,
+		 * so they can also change this that way to configure the rate for
+		 * stand-alone operation when the PCM is closed.
+		 */
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "System Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_CTL_REG1, GENMASK(6, 3)),
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Current Rate",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = snd_rme_rate_info,
+		.get = snd_rme_digiface_rate_get,
+		.private_value = RME_DIGIFACE_REGISTER(RME_DIGIFACE_STATUS_REG1H, GENMASK(7, 4)),
+	}
+};
+
+static int snd_rme_digiface_controls_create(struct usb_mixer_interface *mixer)
+{
+	int err, i;
+
+	for (i = 0; i < ARRAY_SIZE(snd_rme_digiface_controls); ++i) {
+		err = add_single_ctl_with_resume(mixer, 0,
+						 NULL,
+						 &snd_rme_digiface_controls[i],
+						 NULL);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * Pioneer DJ DJM Mixers
  *
@@ -3483,6 +3893,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x2a39, 0x3fb0): /* RME Babyface Pro FS */
 		err = snd_bbfpro_controls_create(mixer);
 		break;
+	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+		err = snd_rme_digiface_controls_create(mixer);
+		break;
 	case USB_ID(0x2b73, 0x0017): /* Pioneer DJ DJM-250MK2 */
 		err = snd_djm_controls_create(mixer, SND_DJM_250MK2_IDX);
 		break;
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index aaa6a515d0f8..24c981c9b240 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -35,10 +35,87 @@
 	.bInterfaceClass = USB_CLASS_AUDIO, \
 	.bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL
 
+/* Quirk .driver_info, followed by the definition of the quirk entry;
+ * put like QUIRK_DRIVER_INFO { ... } in each entry of the quirk table
+ */
+#define QUIRK_DRIVER_INFO \
+	.driver_info = (unsigned long)&(const struct snd_usb_audio_quirk)
+
+/*
+ * Macros for quirk data entries
+ */
+
+/* Quirk data entry for ignoring the interface */
+#define QUIRK_DATA_IGNORE(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_IGNORE_INTERFACE
+/* Quirk data entry for a standard audio interface */
+#define QUIRK_DATA_STANDARD_AUDIO(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_AUDIO_STANDARD_INTERFACE
+/* Quirk data entry for a standard MIDI interface */
+#define QUIRK_DATA_STANDARD_MIDI(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_MIDI_STANDARD_INTERFACE
+/* Quirk data entry for a standard mixer interface */
+#define QUIRK_DATA_STANDARD_MIXER(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_AUDIO_STANDARD_MIXER
+
+/* Quirk data entry for Yamaha MIDI */
+#define QUIRK_DATA_MIDI_YAMAHA(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_MIDI_YAMAHA
+/* Quirk data entry for Edirol UAxx */
+#define QUIRK_DATA_EDIROL_UAXX(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_AUDIO_EDIROL_UAXX
+/* Quirk data entry for raw bytes interface */
+#define QUIRK_DATA_RAW_BYTES(_ifno) \
+	.ifnum = (_ifno), .type = QUIRK_MIDI_RAW_BYTES
+
+/* Quirk composite array terminator */
+#define QUIRK_COMPOSITE_END	{ .ifnum = -1 }
+
+/* Quirk data entry for composite quirks;
+ * followed by the quirk array that is terminated with QUIRK_COMPOSITE_END
+ * e.g. QUIRK_DATA_COMPOSITE { { quirk1 }, { quirk2 },..., QUIRK_COMPOSITE_END }
+ */
+#define QUIRK_DATA_COMPOSITE \
+	.ifnum = QUIRK_ANY_INTERFACE, \
+	.type = QUIRK_COMPOSITE, \
+	.data = &(const struct snd_usb_audio_quirk[])
+
+/* Quirk data entry for a fixed audio endpoint;
+ * followed by audioformat definition
+ * e.g. QUIRK_DATA_AUDIOFORMAT(n) { .formats = xxx, ... }
+ */
+#define QUIRK_DATA_AUDIOFORMAT(_ifno)	    \
+	.ifnum = (_ifno),		    \
+	.type = QUIRK_AUDIO_FIXED_ENDPOINT, \
+	.data = &(const struct audioformat)
+
+/* Quirk data entry for a fixed MIDI endpoint;
+ * followed by snd_usb_midi_endpoint_info definition
+ * e.g. QUIRK_DATA_MIDI_FIXED_ENDPOINT(n) { .out_cables = x, .in_cables = y }
+ */
+#define QUIRK_DATA_MIDI_FIXED_ENDPOINT(_ifno) \
+	.ifnum = (_ifno),		      \
+	.type = QUIRK_MIDI_FIXED_ENDPOINT,    \
+	.data = &(const struct snd_usb_midi_endpoint_info)
+/* Quirk data entry for a MIDIMAN MIDI endpoint */
+#define QUIRK_DATA_MIDI_MIDIMAN(_ifno) \
+	.ifnum = (_ifno),	       \
+	.type = QUIRK_MIDI_MIDIMAN,    \
+	.data = &(const struct snd_usb_midi_endpoint_info)
+/* Quirk data entry for a EMAGIC MIDI endpoint */
+#define QUIRK_DATA_MIDI_EMAGIC(_ifno) \
+	.ifnum = (_ifno),	      \
+	.type = QUIRK_MIDI_EMAGIC,    \
+	.data = &(const struct snd_usb_midi_endpoint_info)
+
+/*
+ * Here we go... the quirk table definition begins:
+ */
+
 /* FTDI devices */
 {
 	USB_DEVICE(0x0403, 0xb8d8),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "STARR LABS", */
 		/* .product_name = "Starr Labs MIDI USB device", */
 		.ifnum = 0,
@@ -49,10 +126,8 @@
 {
 	/* Creative BT-D1 */
 	USB_DEVICE(0x041e, 0x0005),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = 1,
-		.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-		.data = &(const struct audioformat) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_AUDIOFORMAT(1) {
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 			.channels = 2,
 			.iface = 1,
@@ -87,18 +162,11 @@
  */
 {
 	USB_AUDIO_DEVICE(0x041e, 0x4095),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(2) },
 			{
-				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(3) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.fmt_bits = 16,
@@ -114,9 +182,7 @@
 					.rate_table = (unsigned int[]) { 48000 },
 				},
 			},
-			{
-				.ifnum = -1
-			},
+			QUIRK_COMPOSITE_END
 		},
 	},
 },
@@ -128,31 +194,18 @@
  */
 {
 	USB_DEVICE(0x0424, 0xb832),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Standard Microsystems Corp.",
 		.product_name = "HP Wireless Audio",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			/* Mixer */
-			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
+			{ QUIRK_DATA_IGNORE(0) },
 			/* Playback */
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
+			{ QUIRK_DATA_IGNORE(1) },
 			/* Capture */
-			{
-				.ifnum = 2,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
+			{ QUIRK_DATA_IGNORE(2) },
 			/* HID Device, .ifnum = 3 */
-			{
-				.ifnum = -1,
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -175,20 +228,18 @@
 
 #define YAMAHA_DEVICE(id, name) { \
 	USB_DEVICE(0x0499, id), \
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) { \
+	QUIRK_DRIVER_INFO { \
 		.vendor_name = "Yamaha", \
 		.product_name = name, \
-		.ifnum = QUIRK_ANY_INTERFACE, \
-		.type = QUIRK_MIDI_YAMAHA \
+		QUIRK_DATA_MIDI_YAMAHA(QUIRK_ANY_INTERFACE) \
 	} \
 }
 #define YAMAHA_INTERFACE(id, intf, name) { \
 	USB_DEVICE_VENDOR_SPEC(0x0499, id), \
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) { \
+	QUIRK_DRIVER_INFO { \
 		.vendor_name = "Yamaha", \
 		.product_name = name, \
-		.ifnum = intf, \
-		.type = QUIRK_MIDI_YAMAHA \
+		QUIRK_DATA_MIDI_YAMAHA(intf) \
 	} \
 }
 YAMAHA_DEVICE(0x1000, "UX256"),
@@ -276,135 +327,67 @@ YAMAHA_DEVICE(0x105d, NULL),
 YAMAHA_DEVICE(0x1718, "P-125"),
 {
 	USB_DEVICE(0x0499, 0x1503),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "MOX6/MOX8", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_YAMAHA
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_MIDI_YAMAHA(3) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0499, 0x1507),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "THR10", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_YAMAHA
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_MIDI_YAMAHA(3) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0499, 0x1509),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "Steinberg UR22", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_YAMAHA
-			},
-			{
-				.ifnum = 4,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_MIDI_YAMAHA(3) },
+			{ QUIRK_DATA_IGNORE(4) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0499, 0x150a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "THR5A", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_YAMAHA
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_MIDI_YAMAHA(3) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0499, 0x150c),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Yamaha", */
 		/* .product_name = "THR10C", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_YAMAHA
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_MIDI_YAMAHA(3) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -438,7 +421,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	               USB_DEVICE_ID_MATCH_INT_CLASS,
 	.idVendor = 0x0499,
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_AUTODETECT
 	}
@@ -449,16 +432,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
 {
 	USB_DEVICE(0x0582, 0x0000),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "UA-100",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 4,
 					.iface = 0,
@@ -473,9 +452,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 1,
@@ -490,106 +467,66 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0007,
 					.in_cables  = 0x0007
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-4",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x000f,
 					.in_cables  = 0x000f
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0003),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "SC-8850",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x003f,
 					.in_cables  = 0x003f
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0004),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "U-8",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0005,
 					.in_cables  = 0x0005
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -597,152 +534,92 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	/* Has ID 0x0099 when not in "Advanced Driver" mode.
 	 * The UM-2EX has only one input, but we cannot detect this. */
 	USB_DEVICE(0x0582, 0x0005),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-2",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0003,
 					.in_cables  = 0x0003
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0007),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "SC-8820",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0013,
 					.in_cables  = 0x0013
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0008),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "PC-300",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x009d when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0009),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-1",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x000b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "SK-500",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0013,
 					.in_cables  = 0x0013
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -750,31 +627,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	/* thanks to Emiliano Grilli <emillo@libero.it>
 	 * for helping researching this data */
 	USB_DEVICE(0x0582, 0x000c),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "SC-D70",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0007,
 					.in_cables  = 0x0007
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -788,35 +653,23 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * the 96kHz sample rate.
 	 */
 	USB_DEVICE(0x0582, 0x0010),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-5",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x0013 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0012),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "XV-5050",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -825,12 +678,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0015 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0014),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-880",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -839,74 +690,48 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0017 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0016),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-90",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x000f,
 					.in_cables  = 0x000f
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x001c when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x001b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "MMP-2",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x001e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x001d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "V-SYNTH",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -915,12 +740,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0024 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0023),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-550",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x003f,
 			.in_cables  = 0x003f
 		}
@@ -933,20 +756,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and no MIDI.
 	 */
 	USB_DEVICE(0x0582, 0x0025),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-20",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 1,
@@ -961,9 +777,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 2,
@@ -978,28 +792,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(3) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x0028 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0027),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-20",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1008,12 +816,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x002a when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0029),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "SD-80",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x000f,
 			.in_cables  = 0x000f
 		}
@@ -1026,39 +832,24 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * but offers only 16-bit PCM and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x002b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-700",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_EDIROL_UAXX(1) },
+			{ QUIRK_DATA_EDIROL_UAXX(2) },
+			{ QUIRK_DATA_EDIROL_UAXX(3) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x002e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x002d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "XV-2020",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1067,12 +858,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0030 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x002f),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "VariOS",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0007,
 			.in_cables  = 0x0007
 		}
@@ -1081,12 +870,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0034 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0033),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "PCR",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1098,12 +885,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * later revisions use IDs 0x0054 and 0x00a2.
 	 */
 	USB_DEVICE(0x0582, 0x0037),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "Digital Piano",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1116,39 +901,24 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x003b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "BOSS",
 		.product_name = "GS-10",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_STANDARD_MIDI(3) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x0041 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0040),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "GI-20",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1157,12 +927,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0043 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0042),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "RS-70",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1171,36 +939,24 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0049 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0047),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "UR-80", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			/* in the 96 kHz modes, only interface 1 is there */
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x004a when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0048),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "UR-80", */
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1209,35 +965,23 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x004e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x004c),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "PCR-A",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x004f when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x004d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "PCR-A",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0007
 		}
@@ -1249,76 +993,52 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * is standard compliant, but has only 16-bit PCM.
 	 */
 	USB_DEVICE(0x0582, 0x0050),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-3FX",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0052),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UM-1SX",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_STANDARD_INTERFACE
+		QUIRK_DATA_STANDARD_MIDI(0)
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0060),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "EXR Series",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_STANDARD_INTERFACE
+		QUIRK_DATA_STANDARD_MIDI(0)
 	}
 },
 {
 	/* has ID 0x0066 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0064),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "PCR-1", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x0067 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0065),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "EDIROL", */
 		/* .product_name = "PCR-1", */
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0003
 		}
@@ -1327,12 +1047,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x006e when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x006d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "FANTOM-X",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1345,39 +1063,24 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * offers only 16-bit PCM at 44.1 kHz and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0074),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-25",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_EDIROL_UAXX(0) },
+			{ QUIRK_DATA_EDIROL_UAXX(1) },
+			{ QUIRK_DATA_EDIROL_UAXX(2) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* has ID 0x0076 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0075),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "BOSS",
 		.product_name = "DR-880",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1386,12 +1089,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x007b when not in "Advanced Driver" mode */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x007a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		/* "RD" or "RD-700SX"? */
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0003
 		}
@@ -1400,12 +1101,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x0081 when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x0080),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Roland",
 		.product_name = "G-70",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1414,12 +1113,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* has ID 0x008c when not in "Advanced Driver" mode */
 	USB_DEVICE(0x0582, 0x008b),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "PC-50",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1431,56 +1128,31 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * is standard compliant, but has only 16-bit PCM and no MIDI.
 	 */
 	USB_DEVICE(0x0582, 0x00a3),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-4FX",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_EDIROL_UAXX(0) },
+			{ QUIRK_DATA_EDIROL_UAXX(1) },
+			{ QUIRK_DATA_EDIROL_UAXX(2) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* Edirol M-16DX */
 	USB_DEVICE(0x0582, 0x00c4),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
 			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -1490,37 +1162,22 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * offers only 16-bit PCM at 44.1 kHz and no MIDI.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x00e6),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "EDIROL",
 		.product_name = "UA-25EX",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_EDIROL_UAXX
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_EDIROL_UAXX(0) },
+			{ QUIRK_DATA_EDIROL_UAXX(1) },
+			{ QUIRK_DATA_EDIROL_UAXX(2) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* Edirol UM-3G */
 	USB_DEVICE_VENDOR_SPEC(0x0582, 0x0108),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = 0,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(0) {
 			.out_cables = 0x0007,
 			.in_cables  = 0x0007
 		}
@@ -1529,45 +1186,29 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* BOSS ME-25 */
 	USB_DEVICE(0x0582, 0x0113),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* only 44.1 kHz works at the moment */
 	USB_DEVICE(0x0582, 0x0120),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Roland", */
 		/* .product_name = "OCTO-CAPTURE", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 10,
 					.iface = 0,
@@ -1583,9 +1224,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 12,
 					.iface = 1,
@@ -1601,40 +1240,26 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 4,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+			{ QUIRK_DATA_IGNORE(3) },
+			{ QUIRK_DATA_IGNORE(4) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* only 44.1 kHz works at the moment */
 	USB_DEVICE(0x0582, 0x012f),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Roland", */
 		/* .product_name = "QUAD-CAPTURE", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 4,
 					.iface = 0,
@@ -1650,9 +1275,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 6,
 					.iface = 1,
@@ -1668,54 +1291,32 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 4,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+			{ QUIRK_DATA_IGNORE(3) },
+			{ QUIRK_DATA_IGNORE(4) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0582, 0x0159),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Roland", */
 		/* .product_name = "UA-22", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(2) {
 					.out_cables = 0x0001,
 					.in_cables = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -1723,19 +1324,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* UA101 and co are supported by another driver */
 {
 	USB_DEVICE(0x0582, 0x0044), /* UA-1000 high speed */
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_NODEV_INTERFACE
 	},
 },
 {
 	USB_DEVICE(0x0582, 0x007d), /* UA-101 high speed */
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_NODEV_INTERFACE
 	},
 },
 {
 	USB_DEVICE(0x0582, 0x008d), /* UA-101 full speed */
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_NODEV_INTERFACE
 	},
 },
@@ -1746,7 +1347,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	               USB_DEVICE_ID_MATCH_INT_CLASS,
 	.idVendor = 0x0582,
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_AUTODETECT
 	}
@@ -1761,12 +1362,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * compliant USB MIDI ports for external MIDI and controls.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x06f8, 0xb000),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Hercules",
 		.product_name = "DJ Console (WE)",
-		.ifnum = 4,
-		.type = QUIRK_MIDI_FIXED_ENDPOINT,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_FIXED_ENDPOINT(4) {
 			.out_cables = 0x0001,
 			.in_cables = 0x0001
 		}
@@ -1776,12 +1375,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Midiman/M-Audio devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 2x2",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN(QUIRK_ANY_INTERFACE) {
 			.out_cables = 0x0003,
 			.in_cables  = 0x0003
 		}
@@ -1789,12 +1386,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1011),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 1x1",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN(QUIRK_ANY_INTERFACE) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1802,12 +1397,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1015),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "Keystation",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN(QUIRK_ANY_INTERFACE) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1815,12 +1408,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1021),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 4x4",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN(QUIRK_ANY_INTERFACE) {
 			.out_cables = 0x000f,
 			.in_cables  = 0x000f
 		}
@@ -1833,12 +1424,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Thanks to Olaf Giesbrecht <Olaf_Giesbrecht@yahoo.de>
 	 */
 	USB_DEVICE_VER(0x0763, 0x1031, 0x0100, 0x0109),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 8x8",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN(QUIRK_ANY_INTERFACE) {
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -1846,12 +1435,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1033),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 8x8",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN(QUIRK_ANY_INTERFACE) {
 			.out_cables = 0x01ff,
 			.in_cables  = 0x01ff
 		}
@@ -1859,12 +1446,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x1041),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "MidiSport 2x4",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN(QUIRK_ANY_INTERFACE) {
 			.out_cables = 0x000f,
 			.in_cables  = 0x0003
 		}
@@ -1872,76 +1457,41 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "Quattro",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			/*
 			 * Interfaces 0-2 are "Windows-compatible", 16-bit only,
 			 * and share endpoints with the other interfaces.
 			 * Ignore them.  The other interfaces can do 24 bits,
 			 * but captured samples are big-endian (see usbaudio.c).
 			 */
-			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 4,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 5,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 6,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 7,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 8,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 9,
-				.type = QUIRK_MIDI_MIDIMAN,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
+			{ QUIRK_DATA_IGNORE(2) },
+			{ QUIRK_DATA_IGNORE(3) },
+			{ QUIRK_DATA_STANDARD_AUDIO(4) },
+			{ QUIRK_DATA_STANDARD_AUDIO(5) },
+			{ QUIRK_DATA_IGNORE(6) },
+			{ QUIRK_DATA_STANDARD_AUDIO(7) },
+			{ QUIRK_DATA_STANDARD_AUDIO(8) },
+			{
+				QUIRK_DATA_MIDI_MIDIMAN(9) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2003),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "AudioPhile",
-		.ifnum = 6,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN(6) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1949,12 +1499,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2008),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "Ozone",
-		.ifnum = 3,
-		.type = QUIRK_MIDI_MIDIMAN,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_MIDIMAN(3) {
 			.out_cables = 0x0001,
 			.in_cables  = 0x0001
 		}
@@ -1962,93 +1510,45 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x200d),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "M-Audio",
 		.product_name = "OmniStudio",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 4,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 5,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 6,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 7,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 8,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 9,
-				.type = QUIRK_MIDI_MIDIMAN,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
+			{ QUIRK_DATA_IGNORE(2) },
+			{ QUIRK_DATA_IGNORE(3) },
+			{ QUIRK_DATA_STANDARD_AUDIO(4) },
+			{ QUIRK_DATA_STANDARD_AUDIO(5) },
+			{ QUIRK_DATA_IGNORE(6) },
+			{ QUIRK_DATA_STANDARD_AUDIO(7) },
+			{ QUIRK_DATA_STANDARD_AUDIO(8) },
+			{
+				QUIRK_DATA_MIDI_MIDIMAN(9) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x0763, 0x2019),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Ozone Academic", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_MIDIMAN,
-				.data = & (const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_MIDIMAN(3) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -2058,21 +1558,14 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2030),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track C400", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(1) },
 			/* Playback */
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 2,
@@ -2096,9 +1589,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			/* Capture */
 			{
-				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(3) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 3,
@@ -2120,30 +1611,21 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x80,
 				}
 			},
-			/* MIDI */
-			{
-				.ifnum = -1 /* Interface = 4 */
-			}
+			/* MIDI: Interface = 4*/
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2031),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track C600", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(1) },
 			/* Playback */
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -2167,9 +1649,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			/* Capture */
 			{
-				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(3) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 3,
@@ -2191,29 +1671,20 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x80,
 				}
 			},
-			/* MIDI */
-			{
-				.ifnum = -1 /* Interface = 4 */
-			}
+			/* MIDI: Interface = 4 */
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2080),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track Ultra", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 1,
@@ -2235,9 +1706,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -2259,28 +1728,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			/* interface 3 (MIDI) is standard compliant */
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2081),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track Ultra 8R", */
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 1,
@@ -2302,9 +1762,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -2326,9 +1784,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			/* interface 3 (MIDI) is standard compliant */
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -2336,21 +1792,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Casio devices */
 {
 	USB_DEVICE(0x07cf, 0x6801),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Casio",
 		.product_name = "PL-40R",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_YAMAHA
+		QUIRK_DATA_MIDI_YAMAHA(0)
 	}
 },
 {
 	/* this ID is used by several devices without a product ID */
 	USB_DEVICE(0x07cf, 0x6802),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Casio",
 		.product_name = "Keyboard",
-		.ifnum = 0,
-		.type = QUIRK_MIDI_YAMAHA
+		QUIRK_DATA_MIDI_YAMAHA(0)
 	}
 },
 
@@ -2363,23 +1817,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	.idVendor = 0x07fd,
 	.idProduct = 0x0001,
 	.bDeviceSubClass = 2,
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "MOTU",
 		.product_name = "Fastlane",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_MIDI_RAW_BYTES
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_RAW_BYTES(0) },
+			{ QUIRK_DATA_IGNORE(1) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -2387,12 +1831,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Emagic devices */
 {
 	USB_DEVICE(0x086a, 0x0001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Emagic",
 		.product_name = "Unitor8",
-		.ifnum = 2,
-		.type = QUIRK_MIDI_EMAGIC,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_EMAGIC(2) {
 			.out_cables = 0x80ff,
 			.in_cables  = 0x80ff
 		}
@@ -2400,12 +1842,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x086a, 0x0002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Emagic",
 		/* .product_name = "AMT8", */
-		.ifnum = 2,
-		.type = QUIRK_MIDI_EMAGIC,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_EMAGIC(2) {
 			.out_cables = 0x80ff,
 			.in_cables  = 0x80ff
 		}
@@ -2413,12 +1853,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x086a, 0x0003),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Emagic",
 		/* .product_name = "MT4", */
-		.ifnum = 2,
-		.type = QUIRK_MIDI_EMAGIC,
-		.data = & (const struct snd_usb_midi_endpoint_info) {
+		QUIRK_DATA_MIDI_EMAGIC(2) {
 			.out_cables = 0x800f,
 			.in_cables  = 0x8003
 		}
@@ -2428,38 +1866,35 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* KORG devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0200),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "KORG, Inc.",
 		/* .product_name = "PANDORA PX5D", */
-		.ifnum = 3,
-		.type = QUIRK_MIDI_STANDARD_INTERFACE,
+		QUIRK_DATA_STANDARD_MIDI(3)
 	}
 },
 
 {
 	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0201),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "KORG, Inc.",
 		/* .product_name = "ToneLab ST", */
-		.ifnum = 3,
-		.type = QUIRK_MIDI_STANDARD_INTERFACE,
+		QUIRK_DATA_STANDARD_MIDI(3)
 	}
 },
 
 {
 	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0204),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "KORG, Inc.",
 		/* .product_name = "ToneLab EX", */
-		.ifnum = 3,
-		.type = QUIRK_MIDI_STANDARD_INTERFACE,
+		QUIRK_DATA_STANDARD_MIDI(3)
 	}
 },
 
 /* AKAI devices */
 {
 	USB_DEVICE(0x09e8, 0x0062),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "AKAI",
 		.product_name = "MPD16",
 		.ifnum = 0,
@@ -2470,89 +1905,49 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Akai MPC Element */
 	USB_DEVICE(0x09e8, 0x0021),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_MIDI_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_STANDARD_MIDI(1) },
+			QUIRK_COMPOSITE_END
 		}
 	}
-},
-
-/* Steinberg devices */
-{
-	/* Steinberg MI2 */
-	USB_DEVICE_VENDOR_SPEC(0x0a4e, 0x2040),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
+},
+
+/* Steinberg devices */
+{
+	/* Steinberg MI2 */
+	USB_DEVICE_VENDOR_SPEC(0x0a4e, 0x2040),
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
 			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(3) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* Steinberg MI4 */
 	USB_DEVICE_VENDOR_SPEC(0x0a4e, 0x4040),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = & (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(3) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -2560,34 +1955,31 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* TerraTec devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0012),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "TerraTec",
 		.product_name = "PHASE 26",
-		.ifnum = 3,
-		.type = QUIRK_MIDI_STANDARD_INTERFACE
+		QUIRK_DATA_STANDARD_MIDI(3)
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0013),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "TerraTec",
 		.product_name = "PHASE 26",
-		.ifnum = 3,
-		.type = QUIRK_MIDI_STANDARD_INTERFACE
+		QUIRK_DATA_STANDARD_MIDI(3)
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x0ccd, 0x0014),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "TerraTec",
 		.product_name = "PHASE 26",
-		.ifnum = 3,
-		.type = QUIRK_MIDI_STANDARD_INTERFACE
+		QUIRK_DATA_STANDARD_MIDI(3)
 	}
 },
 {
 	USB_DEVICE(0x0ccd, 0x0035),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Miditech",
 		.product_name = "Play'n Roll",
 		.ifnum = 0,
@@ -2602,7 +1994,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Novation EMS devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Novation",
 		.product_name = "ReMOTE Audio/XStation",
 		.ifnum = 4,
@@ -2611,7 +2003,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0002),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Novation",
 		.product_name = "Speedio",
 		.ifnum = 3,
@@ -2620,38 +2012,29 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x1235, 0x000a),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Novation", */
 		/* .product_name = "Nocturn", */
-		.ifnum = 0,
-		.type = QUIRK_MIDI_RAW_BYTES
+		QUIRK_DATA_RAW_BYTES(0)
 	}
 },
 {
 	USB_DEVICE(0x1235, 0x000e),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		/* .vendor_name = "Novation", */
 		/* .product_name = "Launchpad", */
-		.ifnum = 0,
-		.type = QUIRK_MIDI_RAW_BYTES
+		QUIRK_DATA_RAW_BYTES(0)
 	}
 },
 {
 	USB_DEVICE(0x1235, 0x0010),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Focusrite",
 		.product_name = "Saffire 6 USB",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 0,
@@ -2678,9 +2061,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 0,
@@ -2702,28 +2083,19 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_MIDI_RAW_BYTES
-			},
-			{
-				.ifnum = -1
-			}
+			{ QUIRK_DATA_RAW_BYTES(1) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE(0x1235, 0x0018),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Novation",
 		.product_name = "Twitch",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = & (const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 0,
@@ -2742,19 +2114,14 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_MIDI_RAW_BYTES
-			},
-			{
-				.ifnum = -1
-			}
+			{ QUIRK_DATA_RAW_BYTES(1) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x4661),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Novation",
 		.product_name = "ReMOTE25",
 		.ifnum = 0,
@@ -2766,25 +2133,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* VirusTI Desktop */
 	USB_DEVICE_VENDOR_SPEC(0x133e, 0x0815),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 3,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(3) {
 					.out_cables = 0x0003,
 					.in_cables  = 0x0003
 				}
 			},
-			{
-				.ifnum = 4,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+			{ QUIRK_DATA_IGNORE(4) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -2812,7 +2170,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* QinHeng devices */
 {
 	USB_DEVICE(0x1a86, 0x752d),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "QinHeng",
 		.product_name = "CH345",
 		.ifnum = 1,
@@ -2826,7 +2184,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Miditech devices */
 {
 	USB_DEVICE(0x4752, 0x0011),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Miditech",
 		.product_name = "Midistart-2",
 		.ifnum = 0,
@@ -2838,7 +2196,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* this ID used by both Miditech MidiStudio-2 and CME UF-x */
 	USB_DEVICE(0x7104, 0x2202),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.ifnum = 0,
 		.type = QUIRK_MIDI_CME
 	}
@@ -2848,20 +2206,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	/* Thanks to Clemens Ladisch <clemens@ladisch.de> */
 	USB_DEVICE(0x0dba, 0x1000),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Digidesign",
 		.product_name = "MBox",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]){
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
+		QUIRK_DATA_COMPOSITE{
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 1,
@@ -2882,9 +2233,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 1,
@@ -2905,9 +2254,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -2915,24 +2262,14 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* DIGIDESIGN MBOX 2 */
 {
 	USB_DEVICE(0x0dba, 0x3000),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Digidesign",
 		.product_name = "Mbox 2",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 2,
@@ -2950,15 +2287,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
+			{ QUIRK_DATA_IGNORE(3) },
 			{
-				.ifnum = 3,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 4,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
-				.formats = SNDRV_PCM_FMTBIT_S24_3BE,
+				QUIRK_DATA_AUDIOFORMAT(4) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 4,
 					.altsetting = 2,
@@ -2975,14 +2307,9 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
+			{ QUIRK_DATA_IGNORE(5) },
 			{
-				.ifnum = 5,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 6,
-				.type = QUIRK_MIDI_MIDIMAN,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_MIDIMAN(6) {
 					.out_ep =  0x02,
 					.out_cables = 0x0001,
 					.in_ep = 0x81,
@@ -2990,33 +2317,21 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.in_cables = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 /* DIGIDESIGN MBOX 3 */
 {
 	USB_DEVICE(0x0dba, 0x5000),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Digidesign",
 		.product_name = "Mbox 3",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_IGNORE(1) },
 			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.fmt_bits = 24,
 					.channels = 4,
@@ -3043,9 +2358,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(3) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.fmt_bits = 24,
 					.channels = 4,
@@ -3069,36 +2382,25 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 4,
-				.type = QUIRK_MIDI_FIXED_ENDPOINT,
-				.data = &(const struct snd_usb_midi_endpoint_info) {
+				QUIRK_DATA_MIDI_FIXED_ENDPOINT(4) {
 					.out_cables = 0x0001,
 					.in_cables  = 0x0001
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 {
 	/* Tascam US122 MKII - playback-only support */
 	USB_DEVICE_VENDOR_SPEC(0x0644, 0x8021),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "TASCAM",
 		.product_name = "US122 MKII",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 1,
@@ -3119,9 +2421,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3129,20 +2429,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 /* Denon DN-X1600 */
 {
 	USB_AUDIO_DEVICE(0x154e, 0x500e),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Denon",
 		.product_name = "DN-X1600",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]){
+		QUIRK_DATA_COMPOSITE{
+			{ QUIRK_DATA_IGNORE(0) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 1,
@@ -3163,9 +2456,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 2,
@@ -3185,13 +2476,8 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = 4,
-				.type = QUIRK_MIDI_STANDARD_INTERFACE,
-			},
-			{
-				.ifnum = -1
-			}
+			{ QUIRK_DATA_STANDARD_MIDI(4) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3200,17 +2486,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	USB_DEVICE(0x045e, 0x0283),
 	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Microsoft",
 		.product_name = "XboxLive Headset/Xbox Communicator",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
 			{
 				/* playback */
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 1,
 					.iface = 0,
@@ -3226,9 +2508,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				/* capture */
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 1,
 					.iface = 1,
@@ -3242,9 +2522,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_max = 16000
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3253,18 +2531,11 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 {
 	USB_DEVICE(0x200c, 0x100b),
 	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 1,
@@ -3283,9 +2554,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3298,28 +2567,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * enabled in create_standard_audio_quirk().
 	 */
 	USB_DEVICE(0x1686, 0x00dd),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				/* Playback  */
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
-			},
-			{
-				/* Capture */
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
-			},
-			{
-				/* Midi */
-				.ifnum = 3,
-				.type = QUIRK_MIDI_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			},
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) }, /* Playback  */
+			{ QUIRK_DATA_STANDARD_AUDIO(2) }, /* Capture */
+			{ QUIRK_DATA_STANDARD_MIDI(3) }, /* Midi */
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3333,18 +2586,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
 	.bInterfaceClass = USB_CLASS_AUDIO,
 	.bInterfaceSubClass = USB_SUBCLASS_MIDISTREAMING,
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_MIDI_STANDARD_INTERFACE
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_STANDARD_MIDI(QUIRK_ANY_INTERFACE)
 	}
 },
 
 /* Rane SL-1 */
 {
 	USB_DEVICE(0x13e5, 0x0001),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_AUDIO_STANDARD_INTERFACE
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_STANDARD_AUDIO(QUIRK_ANY_INTERFACE)
         }
 },
 
@@ -3360,24 +2611,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and only the 48 kHz sample rate works for the playback interface.
 	 */
 	USB_DEVICE(0x0a12, 0x1243),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
-			/* Capture */
-			{
-				.ifnum = 1,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
+			{ QUIRK_DATA_IGNORE(1) }, /* Capture */
 			/* Playback */
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 2,
@@ -3396,9 +2636,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			},
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3411,19 +2649,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * even on windows.
 	 */
 	USB_DEVICE(0x19b5, 0x0021),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
 			/* Playback */
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 1,
@@ -3442,29 +2673,20 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			},
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
 /* MOTU Microbook II */
 {
 	USB_DEVICE_VENDOR_SPEC(0x07fd, 0x0004),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "MOTU",
 		.product_name = "MicroBookII",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 6,
 					.iface = 0,
@@ -3485,9 +2707,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 8,
 					.iface = 0,
@@ -3508,9 +2728,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3522,14 +2740,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * The feedback for the output is the input.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0023),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 12,
 					.iface = 0,
@@ -3546,9 +2760,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 10,
 					.iface = 0,
@@ -3566,9 +2778,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3611,14 +2821,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * but not for DVS (Digital Vinyl Systems) like in Mixxx.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0017),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8, // outputs
 					.iface = 0,
@@ -3635,9 +2841,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8, // inputs
 					.iface = 0,
@@ -3655,9 +2859,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 48000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3668,14 +2870,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * The feedback for the output is the dummy input.
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x000e),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 0,
@@ -3692,9 +2890,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 2,
 					.iface = 0,
@@ -3712,9 +2908,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3725,14 +2919,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * PCM is 6 channels out & 4 channels in @ 44.1 fixed
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x000d),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6, //Master, Headphones & Booth
 					.iface = 0,
@@ -3749,9 +2939,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4, //2x RCA inputs (CH1 & CH2)
 					.iface = 0,
@@ -3769,9 +2957,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3783,14 +2969,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * The Feedback for the output is the input
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x001e),
-		.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 4,
 					.iface = 0,
@@ -3807,9 +2989,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 0,
@@ -3827,9 +3007,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3840,14 +3018,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * 10 channels playback & 12 channels capture @ 44.1/48/96kHz S24LE
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x000a),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 10,
 					.iface = 0,
@@ -3868,9 +3042,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 12,
 					.iface = 0,
@@ -3892,9 +3064,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3906,14 +3076,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * The Feedback for the output is the input
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0029),
-		.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 0,
@@ -3930,9 +3096,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 6,
 					.iface = 0,
@@ -3950,9 +3114,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -3970,20 +3132,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
 {
 	USB_AUDIO_DEVICE(0x534d, 0x0021),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "MacroSilicon",
 		.product_name = "MS210x",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(2) },
 			{
-				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(3) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 3,
@@ -3998,9 +3153,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_max = 48000,
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4018,20 +3171,13 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
 {
 	USB_AUDIO_DEVICE(0x534d, 0x2109),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "MacroSilicon",
 		.product_name = "MS2109",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_MIXER,
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_MIXER(2) },
 			{
-				.ifnum = 3,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(3) {
 					.formats = SNDRV_PCM_FMTBIT_S16_LE,
 					.channels = 2,
 					.iface = 3,
@@ -4046,9 +3192,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_max = 48000,
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4058,14 +3202,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * 8 channels playback & 8 channels capture @ 44.1/48/96kHz S24LE
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x08e4, 0x017f),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 0,
@@ -4084,9 +3224,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 0,
@@ -4106,9 +3244,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100, 48000, 96000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4118,14 +3254,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * 10 channels playback & 12 channels capture @ 48kHz S24LE
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x001b),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 10,
 					.iface = 0,
@@ -4144,9 +3276,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 12,
 					.iface = 0,
@@ -4164,9 +3294,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 48000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4178,14 +3306,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Capture on EP 0x86
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x08e4, 0x0163),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 0,
@@ -4205,9 +3329,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8,
 					.iface = 0,
@@ -4227,9 +3349,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 44100, 48000, 96000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4240,14 +3360,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * and 8 channels in @ 48 fixed (endpoint 0x82).
 	 */
 	USB_DEVICE_VENDOR_SPEC(0x2b73, 0x0013),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8, // outputs
 					.iface = 0,
@@ -4264,9 +3380,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					}
 			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(0) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
 					.channels = 8, // inputs
 					.iface = 0,
@@ -4284,9 +3398,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.rate_table = (unsigned int[]) { 48000 }
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4297,28 +3409,15 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 */
 	USB_DEVICE(0x1395, 0x0300),
 	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
 			// Communication
-			{
-				.ifnum = 3,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
+			{ QUIRK_DATA_STANDARD_AUDIO(3) },
 			// Recording
-			{
-				.ifnum = 4,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
+			{ QUIRK_DATA_STANDARD_AUDIO(4) },
 			// Main
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
-			{
-				.ifnum = -1
-			}
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4327,21 +3426,14 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Fiero SC-01 (firmware v1.0.0 @ 48 kHz)
 	 */
 	USB_DEVICE(0x2b53, 0x0023),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Fiero",
 		.product_name = "SC-01",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
 			/* Playback */
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4361,9 +3453,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			/* Capture */
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4382,9 +3472,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x29
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4393,21 +3481,14 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Fiero SC-01 (firmware v1.0.0 @ 96 kHz)
 	 */
 	USB_DEVICE(0x2b53, 0x0024),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Fiero",
 		.product_name = "SC-01",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
 			/* Playback */
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4427,9 +3508,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			/* Capture */
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4448,9 +3527,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x29
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4459,21 +3536,14 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * Fiero SC-01 (firmware v1.1.0)
 	 */
 	USB_DEVICE(0x2b53, 0x0031),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Fiero",
 		.product_name = "SC-01",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = &(const struct snd_usb_audio_quirk[]) {
-			{
-				.ifnum = 0,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
-			},
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(0) },
 			/* Playback */
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(1) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4494,9 +3564,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			/* Capture */
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S32_LE,
 					.channels = 2,
 					.fmt_bits = 24,
@@ -4516,9 +3584,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 					.clock = 0x29
 				}
 			},
-			{
-				.ifnum = -1
-			}
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
@@ -4527,30 +3593,187 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	 * For the standard mode, Mythware XA001AU has ID ffad:a001
 	 */
 	USB_DEVICE_VENDOR_SPEC(0xffad, 0xa001),
-	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+	QUIRK_DRIVER_INFO {
 		.vendor_name = "Mythware",
 		.product_name = "XA001AU",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]) {
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_IGNORE(0) },
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			QUIRK_COMPOSITE_END
+		}
+	}
+},
+{
+	/* Only claim interface 0 */
+	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
+		       USB_DEVICE_ID_MATCH_PRODUCT |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_NUMBER,
+	.idVendor = 0x2a39,
+	.idProduct = 0x3f8c,
+	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
+	.bInterfaceNumber = 0,
+	QUIRK_DRIVER_INFO {
+		QUIRK_DATA_COMPOSITE {
+			/*
+			 * Three modes depending on sample rate band,
+			 * with different channel counts for in/out
+			 */
+			{ QUIRK_DATA_STANDARD_MIXER(0) },
+			{
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 34, // outputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x02,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_32000 |
+						SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000,
+					.rate_min = 32000,
+					.rate_max = 48000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						32000, 44100, 48000,
+					},
+					.sync_ep = 0x81,
+					.sync_iface = 0,
+					.sync_altsetting = 1,
+					.sync_ep_idx = 0,
+					.implicit_fb = 1,
+				},
+			},
+			{
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 18, // outputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x02,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_64000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 64000,
+					.rate_max = 96000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						64000, 88200, 96000,
+					},
+					.sync_ep = 0x81,
+					.sync_iface = 0,
+					.sync_altsetting = 1,
+					.sync_ep_idx = 0,
+					.implicit_fb = 1,
+				},
+			},
 			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE,
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 10, // outputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x02,
+					.ep_idx = 1,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_KNOT |
+						SNDRV_PCM_RATE_176400 |
+						SNDRV_PCM_RATE_192000,
+					.rate_min = 128000,
+					.rate_max = 192000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						128000, 176400, 192000,
+					},
+					.sync_ep = 0x81,
+					.sync_iface = 0,
+					.sync_altsetting = 1,
+					.sync_ep_idx = 0,
+					.implicit_fb = 1,
+				},
 			},
 			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 32, // inputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_32000 |
+						SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000,
+					.rate_min = 32000,
+					.rate_max = 48000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						32000, 44100, 48000,
+					}
+				}
 			},
 			{
-				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE,
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 16, // inputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_64000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 64000,
+					.rate_max = 96000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						64000, 88200, 96000,
+					}
+				}
 			},
 			{
-				.ifnum = -1
-			}
+				QUIRK_DATA_AUDIOFORMAT(0) {
+					.formats = SNDRV_PCM_FMTBIT_S32_LE,
+					.channels = 8, // inputs
+					.fmt_bits = 24,
+					.iface = 0,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.rates = SNDRV_PCM_RATE_KNOT |
+						SNDRV_PCM_RATE_176400 |
+						SNDRV_PCM_RATE_192000,
+					.rate_min = 128000,
+					.rate_max = 192000,
+					.nr_rates = 3,
+					.rate_table = (unsigned int[]) {
+						128000, 176400, 192000,
+					}
+				}
+			},
+			QUIRK_COMPOSITE_END
 		}
 	}
 },
-
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index e7b68c67852e..f4c68eb7e07a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1389,6 +1389,27 @@ static int snd_usb_motu_m_series_boot_quirk(struct usb_device *dev)
 	return 0;
 }
 
+static int snd_usb_rme_digiface_boot_quirk(struct usb_device *dev)
+{
+	/* Disable mixer, internal clock, all outputs ADAT, 48kHz, TMS off */
+	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+			16, 0x40, 0x2410, 0x7fff, NULL, 0);
+	snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+			18, 0x40, 0x0104, 0xffff, NULL, 0);
+
+	/* Disable loopback for all inputs */
+	for (int ch = 0; ch < 32; ch++)
+		snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				22, 0x40, 0x400, ch, NULL, 0);
+
+	/* Unity gain for all outputs */
+	for (int ch = 0; ch < 34; ch++)
+		snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0),
+				21, 0x40, 0x9000, 0x100 + ch, NULL, 0);
+
+	return 0;
+}
+
 /*
  * Setup quirks
  */
@@ -1616,6 +1637,8 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 		    get_iface_desc(intf->altsetting)->bInterfaceNumber < 3)
 			return snd_usb_motu_microbookii_boot_quirk(dev);
 		break;
+	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+		return snd_usb_rme_digiface_boot_quirk(dev);
 	}
 
 	return 0;
@@ -1771,6 +1794,38 @@ static void mbox3_set_format_quirk(struct snd_usb_substream *subs,
 		dev_warn(&subs->dev->dev, "MBOX3: Couldn't set the sample rate");
 }
 
+static const int rme_digiface_rate_table[] = {
+	32000, 44100, 48000, 0,
+	64000, 88200, 96000, 0,
+	128000, 176400, 192000, 0,
+};
+
+static int rme_digiface_set_format_quirk(struct snd_usb_substream *subs)
+{
+	unsigned int cur_rate = subs->data_endpoint->cur_rate;
+	u16 val;
+	int speed_mode;
+	int id;
+
+	for (id = 0; id < ARRAY_SIZE(rme_digiface_rate_table); id++) {
+		if (rme_digiface_rate_table[id] == cur_rate)
+			break;
+	}
+
+	if (id >= ARRAY_SIZE(rme_digiface_rate_table))
+		return -EINVAL;
+
+	/* 2, 3, 4 for 1x, 2x, 4x */
+	speed_mode = (id >> 2) + 2;
+	val = (id << 3) | (speed_mode << 12);
+
+	/* Set the sample rate */
+	snd_usb_ctl_msg(subs->stream->chip->dev,
+		usb_sndctrlpipe(subs->stream->chip->dev, 0),
+		16, 0x40, val, 0x7078, NULL, 0);
+	return 0;
+}
+
 void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 			      const struct audioformat *fmt)
 {
@@ -1795,6 +1850,9 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 	case USB_ID(0x0dba, 0x5000):
 		mbox3_set_format_quirk(subs, fmt); /* Digidesign Mbox 3 */
 		break;
+	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+		rme_digiface_set_format_quirk(subs);
+		break;
 	}
 }
 
@@ -2163,6 +2221,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
 	DEVICE_FLG(0x17aa, 0x104d, /* Lenovo ThinkStation P620 Internal Speaker + Front Headset */
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
+	DEVICE_FLG(0x1852, 0x5062, /* Luxman D-08u */
+		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1852, 0x5065, /* Luxman DA-06 */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
@@ -2221,6 +2281,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x2d95, 0x8011, /* VIVO USB-C HEADSET */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 24b7d017ec2c..b7965dfff33a 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -7,7 +7,8 @@
 #include <string.h>
 #include <getopt.h>
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
+#define min(a, b)	(((a) < (b)) ? (a) : (b))
 
 typedef unsigned int u32;
 typedef unsigned long long u64;
@@ -207,12 +208,9 @@ static void raw_dump_range(struct cpuid_range *range)
 #define MAX_SUBLEAF_NUM		32
 struct cpuid_range *setup_cpuid_range(u32 input_eax)
 {
-	u32 max_func, idx_func;
-	int subleaf;
+	u32 max_func, idx_func, subleaf, max_subleaf;
+	u32 eax, ebx, ecx, edx, f = input_eax;
 	struct cpuid_range *range;
-	u32 eax, ebx, ecx, edx;
-	u32 f = input_eax;
-	int max_subleaf;
 	bool allzero;
 
 	eax = input_eax;
@@ -258,7 +256,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		 * others have to be tried (0xf)
 		 */
 		if (f == 0x7 || f == 0x14 || f == 0x17 || f == 0x18)
-			max_subleaf = (eax & 0xff) + 1;
+			max_subleaf = min((eax & 0xff) + 1, max_subleaf);
 
 		if (f == 0xb)
 			max_subleaf = 2;
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d4..0f2106218e1f 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -482,9 +482,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 		if (prog_flags[i] || json_output) {
 			NET_START_ARRAY("prog_flags", "%s ");
 			for (j = 0; prog_flags[i] && j < 32; j++) {
-				if (!(prog_flags[i] & (1 << j)))
+				if (!(prog_flags[i] & (1U << j)))
 					continue;
-				NET_DUMP_UINT_ONLY(1 << j);
+				NET_DUMP_UINT_ONLY(1U << j);
 			}
 			NET_END_ARRAY("");
 		}
@@ -493,9 +493,9 @@ static void __show_dev_tc_bpf(const struct ip_devname_ifindex *dev,
 			if (link_flags[i] || json_output) {
 				NET_START_ARRAY("link_flags", "%s ");
 				for (j = 0; link_flags[i] && j < 32; j++) {
-					if (!(link_flags[i] & (1 << j)))
+					if (!(link_flags[i] & (1U << j)))
 						continue;
-					NET_DUMP_UINT_ONLY(1 << j);
+					NET_DUMP_UINT_ONLY(1U << j);
 				}
 				NET_END_ARRAY("");
 			}
@@ -824,6 +824,9 @@ static void show_link_netfilter(void)
 		nf_link_count++;
 	}
 
+	if (!nf_link_info)
+		return;
+
 	qsort(nf_link_info, nf_link_count, sizeof(*nf_link_info), netfilter_link_compar);
 
 	for (id = 0; id < nf_link_count; id++) {
diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 3ce316cc9f97..7a00f3066a98 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -296,6 +296,13 @@ static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
 	file_name = (char *)malloc(file_size * sizeof(char));
 	path_name = (char *)malloc(path_size * sizeof(char));
 
+	if (!file_name || !path_name) {
+		free(file_name);
+		free(path_name);
+		syslog(LOG_ERR, "Can't allocate memory for file name and/or path name");
+		return HV_E_FAIL;
+	}
+
 	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
 	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
 
diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index ac212e6185b2..41ebd394b90c 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -172,7 +172,7 @@
 	_ret;                                                                \
 })
 
-#ifndef __powerpc64__
+#if !defined(__powerpc64__) && !defined(__clang__)
 /* FIXME: For 32-bit PowerPC, with newer gcc compilers (e.g. gcc 13.1.0),
  * "omit-frame-pointer" fails with __attribute__((no_stack_protector)) but
  * works with __attribute__((__optimize__("-fno-stack-protector")))
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 2e9e193179dd..45aba6287b38 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -636,7 +636,12 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 * mis-adjust symbol addresses when computing
 			 * the history counter to increment.
 			 */
-			if (he->ms.map != entry->ms.map) {
+			if (hists__has(hists, sym) && he->ms.map != entry->ms.map) {
+				if (he->ms.sym) {
+					u64 addr = he->ms.sym->start;
+					he->ms.sym = map__find_symbol(entry->ms.map, addr);
+				}
+
 				map__put(he->ms.map);
 				he->ms.map = map__get(entry->ms.map);
 			}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8477edefc299..706be5e4a076 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2270,8 +2270,12 @@ static void save_lbr_cursor_node(struct thread *thread,
 		cursor->curr = cursor->first;
 	else
 		cursor->curr = cursor->curr->next;
+
+	map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
 	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
 	       sizeof(struct callchain_cursor_node));
+	lbr_stitch->prev_lbr_cursor[idx].ms.maps = maps__get(cursor->curr->ms.maps);
+	lbr_stitch->prev_lbr_cursor[idx].ms.map = map__get(cursor->curr->ms.map);
 
 	lbr_stitch->prev_lbr_cursor[idx].valid = true;
 	cursor->pos++;
@@ -2482,6 +2486,9 @@ static bool has_stitched_lbr(struct thread *thread,
 		memcpy(&stitch_node->cursor, &lbr_stitch->prev_lbr_cursor[i],
 		       sizeof(struct callchain_cursor_node));
 
+		stitch_node->cursor.ms.maps = maps__get(lbr_stitch->prev_lbr_cursor[i].ms.maps);
+		stitch_node->cursor.ms.map = map__get(lbr_stitch->prev_lbr_cursor[i].ms.map);
+
 		if (callee)
 			list_add(&stitch_node->node, &lbr_stitch->lists);
 		else
@@ -2505,6 +2512,8 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 	if (!thread__lbr_stitch(thread)->prev_lbr_cursor)
 		goto free_lbr_stitch;
 
+	thread__lbr_stitch(thread)->prev_lbr_cursor_size = max_lbr + 1;
+
 	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->lists);
 	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->free_lists);
 
@@ -2560,8 +2569,12 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 						max_lbr, callee);
 
 		if (!stitched_lbr && !list_empty(&lbr_stitch->lists)) {
-			list_replace_init(&lbr_stitch->lists,
-					  &lbr_stitch->free_lists);
+			struct stitch_list *stitch_node;
+
+			list_for_each_entry(stitch_node, &lbr_stitch->lists, node)
+				map_symbol__exit(&stitch_node->cursor.ms);
+
+			list_splice_init(&lbr_stitch->lists, &lbr_stitch->free_lists);
 		}
 		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
 	}
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 3107f5aa8c9a..226c3167f758 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -17,7 +17,7 @@ src_feature_tests  = getenv('srctree') + '/tools/build/feature'
 
 def clang_has_option(option):
     cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
-    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
+    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
 
 if cc_is_clang:
     from sysconfig import get_config_vars
@@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
 cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-DPYTHON_PERF' ]
 if cc_is_clang:
     cflags += ["-Wno-unused-command-line-argument" ]
+    if clang_has_option("-Wno-cast-function-type-mismatch"):
+        cflags += ["-Wno-cast-function-type-mismatch" ]
 else:
     cflags += ['-Wno-cast-function-type' ]
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 87c59aa9fe38..0ffdd52d86d7 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -476,6 +476,7 @@ void thread__free_stitch_list(struct thread *thread)
 		return;
 
 	list_for_each_entry_safe(pos, tmp, &lbr_stitch->lists, node) {
+		map_symbol__exit(&pos->cursor.ms);
 		list_del_init(&pos->node);
 		free(pos);
 	}
@@ -485,6 +486,9 @@ void thread__free_stitch_list(struct thread *thread)
 		free(pos);
 	}
 
+	for (unsigned int i = 0 ; i < lbr_stitch->prev_lbr_cursor_size; i++)
+		map_symbol__exit(&lbr_stitch->prev_lbr_cursor[i].ms);
+
 	zfree(&lbr_stitch->prev_lbr_cursor);
 	free(thread__lbr_stitch(thread));
 	thread__set_lbr_stitch(thread, NULL);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 8b4a3c69bad1..6cbf6eb2812e 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -26,6 +26,7 @@ struct lbr_stitch {
 	struct list_head		free_lists;
 	struct perf_sample		prev_sample;
 	struct callchain_cursor_node	*prev_lbr_cursor;
+	unsigned int prev_lbr_cursor_size;
 };
 
 DECLARE_RC_STRUCT(thread) {
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index b8703c499d28..0e6374aac96f 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -153,7 +153,10 @@ void suspend(void)
 	if (err < 0)
 		ksft_exit_fail_msg("timerfd_settime() failed\n");
 
-	if (write(power_state_fd, "mem", strlen("mem")) != strlen("mem"))
+	system("(echo mem > /sys/power/state) 2> /dev/null");
+
+	timerfd_gettime(timerfd, &spec);
+	if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
 		ksft_exit_fail_msg("Failed to enter Suspend state\n");
 
 	close(timerfd);
diff --git a/tools/testing/selftests/devices/test_discoverable_devices.py b/tools/testing/selftests/devices/test_discoverable_devices.py
index fbae8deb593d..37a58e94e7c3 100755
--- a/tools/testing/selftests/devices/test_discoverable_devices.py
+++ b/tools/testing/selftests/devices/test_discoverable_devices.py
@@ -39,7 +39,7 @@ def find_pci_controller_dirs():
 
 
 def find_usb_controller_dirs():
-    usb_controller_sysfs_dir = "usb[\d]+"
+    usb_controller_sysfs_dir = r"usb[\d]+"
 
     dir_regex = re.compile(usb_controller_sysfs_dir)
     for d in os.scandir(sysfs_usb_devices):
@@ -69,7 +69,7 @@ def get_acpi_uid(sysfs_dev_dir):
 
 
 def get_usb_version(sysfs_dev_dir):
-    re_usb_version = re.compile("PRODUCT=.*/(\d)/.*")
+    re_usb_version = re.compile(r"PRODUCT=.*/(\d)/.*")
     with open(os.path.join(sysfs_dev_dir, "uevent")) as f:
         return int(re_usb_version.search(f.read()).group(1))
 
diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2b5ea18bde38..346328e2295c 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -17,6 +17,8 @@ TEST_PROGS += hid-tablet.sh
 TEST_PROGS += hid-usb_crash.sh
 TEST_PROGS += hid-wacom.sh
 
+TEST_FILES := run-hid-tools-tests.sh
+
 CXX ?= $(CROSS_COMPILE)g++
 
 HOSTPKG_CONFIG := pkg-config
diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index d680c00d2853..67df7b47087f 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -254,7 +254,7 @@ function cleanup_hugetlb_memory() {
   local cgroup="$1"
   if [[ "$(pgrep -f write_to_hugetlbfs)" != "" ]]; then
     echo killing write_to_hugetlbfs
-    killall -2 write_to_hugetlbfs
+    killall -2 --wait write_to_hugetlbfs
     wait_for_hugetlb_memory_to_get_depleted $cgroup
   fi
   set -e
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 09faffbc3d87..43e6d0c53fe4 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -146,6 +146,16 @@ static int sys_madvise(void *start, size_t len, int types)
 	return sret;
 }
 
+static void *sys_mremap(void *addr, size_t old_len, size_t new_len,
+	unsigned long flags, void *new_addr)
+{
+	void *sret;
+
+	errno = 0;
+	sret = (void *) syscall(__NR_mremap, addr, old_len, new_len, flags, new_addr);
+	return sret;
+}
+
 static int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
 {
 	int ret = syscall(__NR_pkey_alloc, flags, init_val);
@@ -1151,12 +1161,12 @@ static void test_seal_mremap_shrink(bool seal)
 	}
 
 	/* shrink from 4 pages to 2 pages. */
-	ret2 = mremap(ptr, size, 2 * page_size, 0, 0);
+	ret2 = sys_mremap(ptr, size, 2 * page_size, 0, 0);
 	if (seal) {
-		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
-		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 != (void *) MAP_FAILED);
 
 	}
 
@@ -1183,7 +1193,7 @@ static void test_seal_mremap_expand(bool seal)
 	}
 
 	/* expand from 2 page to 4 pages. */
-	ret2 = mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
+	ret2 = sys_mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1216,7 +1226,7 @@ static void test_seal_mremap_move(bool seal)
 	}
 
 	/* move from ptr to fixed address. */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1335,7 +1345,7 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	}
 
 	/* mremap to move and shrink to fixed address */
-	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
@@ -1366,7 +1376,7 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	}
 
 	/* mremap to move and expand to fixed address */
-	ret2 = mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
@@ -1397,7 +1407,7 @@ static void test_seal_mremap_move_fixed(bool seal)
 	}
 
 	/* mremap to move to fixed address */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1426,14 +1436,13 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 	/*
 	 * MREMAP_FIXED can move the mapping to zero address
 	 */
-	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 == 0);
-
 	}
 
 	TEST_END_CHECK();
@@ -1456,13 +1465,13 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 	}
 
 	/* mremap to move, and don't unmap src addr. */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
+		/* kernel will allocate a new address */
 		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
-
 	}
 
 	TEST_END_CHECK();
@@ -1470,7 +1479,7 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 
 static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 {
-	void *ptr;
+	void *ptr, *ptr2;
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
@@ -1485,24 +1494,30 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 	}
 
 	/*
-	 * The 0xdeaddead should not have effect on dest addr
-	 * when MREMAP_DONTUNMAP is set.
+	 * The new address is any address that not allocated.
+	 * use allocate/free to similate that.
 	 */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
-			0xdeaddead);
+	setup_single_address(size, &ptr2);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+	ret = sys_munmap(ptr2, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/*
+	 * remap to any address.
+	 */
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+			(void *) ptr2);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
-		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
-		FAIL_TEST_IF_FALSE((long)ret2 != 0xdeaddead);
-
+		/* remap success and return ptr2 */
+		FAIL_TEST_IF_FALSE(ret2 ==  ptr2);
 	}
 
 	TEST_END_CHECK();
 }
 
-
 static void test_seal_merge_and_split(void)
 {
 	void *ptr;
diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
index 6a2caba19ee1..1289d311efd7 100644
--- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
@@ -28,7 +28,7 @@ enum method {
 
 /* Global variables. */
 static const char *self;
-static char *shmaddr;
+static int *shmaddr;
 static int shmid;
 
 /*
@@ -47,15 +47,17 @@ void sig_handler(int signo)
 {
 	printf("Received %d.\n", signo);
 	if (signo == SIGINT) {
-		printf("Deleting the memory\n");
-		if (shmdt((const void *)shmaddr) != 0) {
-			perror("Detach failure");
+		if (shmaddr) {
+			printf("Deleting the memory\n");
+			if (shmdt((const void *)shmaddr) != 0) {
+				perror("Detach failure");
+				shmctl(shmid, IPC_RMID, NULL);
+				exit(4);
+			}
+
 			shmctl(shmid, IPC_RMID, NULL);
-			exit(4);
+			printf("Done deleting the memory\n");
 		}
-
-		shmctl(shmid, IPC_RMID, NULL);
-		printf("Done deleting the memory\n");
 	}
 	exit(2);
 }
@@ -211,7 +213,8 @@ int main(int argc, char **argv)
 			shmctl(shmid, IPC_RMID, NULL);
 			exit(2);
 		}
-		printf("shmaddr: %p\n", ptr);
+		shmaddr = ptr;
+		printf("shmaddr: %p\n", shmaddr);
 
 		break;
 	default:
diff --git a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
index bd9317bf5ada..dc056fec993b 100644
--- a/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/net/netfilter/conntrack_dump_flush.c
@@ -207,6 +207,7 @@ static int conntrack_data_generate_v6(struct mnl_socket *sock,
 static int count_entries(const struct nlmsghdr *nlh, void *data)
 {
 	reply_counter++;
+	return MNL_CB_OK;
 }
 
 static int conntracK_count_zone(struct mnl_socket *sock, uint16_t zone)
diff --git a/tools/testing/selftests/net/netfilter/nft_audit.sh b/tools/testing/selftests/net/netfilter/nft_audit.sh
index 902f8114bc80..87f2b4c725aa 100755
--- a/tools/testing/selftests/net/netfilter/nft_audit.sh
+++ b/tools/testing/selftests/net/netfilter/nft_audit.sh
@@ -48,12 +48,31 @@ logread_pid=$!
 trap 'kill $logread_pid; rm -f $logfile $rulefile' EXIT
 exec 3<"$logfile"
 
+lsplit='s/^\(.*\) entries=\([^ ]*\) \(.*\)$/pfx="\1"\nval="\2"\nsfx="\3"/'
+summarize_logs() {
+	sum=0
+	while read line; do
+		eval $(sed "$lsplit" <<< "$line")
+		[[ $sum -gt 0 ]] && {
+			[[ "$pfx $sfx" == "$tpfx $tsfx" ]] && {
+				let "sum += val"
+				continue
+			}
+			echo "$tpfx entries=$sum $tsfx"
+		}
+		tpfx="$pfx"
+		tsfx="$sfx"
+		sum=$val
+	done
+	echo "$tpfx entries=$sum $tsfx"
+}
+
 do_test() { # (cmd, log)
 	echo -n "testing for cmd: $1 ... "
 	cat <&3 >/dev/null
 	$1 >/dev/null || exit 1
 	sleep 0.1
-	res=$(diff -a -u <(echo "$2") - <&3)
+	res=$(diff -a -u <(echo "$2") <(summarize_logs <&3))
 	[ $? -eq 0 ] && { echo "OK"; return; }
 	echo "FAIL"
 	grep -v '^\(---\|+++\|@@\)' <<< "$res"
@@ -152,31 +171,17 @@ do_test 'nft reset rules t1 c2' \
 'table=t1 family=2 entries=3 op=nft_reset_rule'
 
 do_test 'nft reset rules table t1' \
-'table=t1 family=2 entries=3 op=nft_reset_rule
-table=t1 family=2 entries=3 op=nft_reset_rule
-table=t1 family=2 entries=3 op=nft_reset_rule'
+'table=t1 family=2 entries=9 op=nft_reset_rule'
 
 do_test 'nft reset rules t2 c3' \
-'table=t2 family=2 entries=189 op=nft_reset_rule
-table=t2 family=2 entries=188 op=nft_reset_rule
-table=t2 family=2 entries=126 op=nft_reset_rule'
+'table=t2 family=2 entries=503 op=nft_reset_rule'
 
 do_test 'nft reset rules t2' \
-'table=t2 family=2 entries=3 op=nft_reset_rule
-table=t2 family=2 entries=3 op=nft_reset_rule
-table=t2 family=2 entries=186 op=nft_reset_rule
-table=t2 family=2 entries=188 op=nft_reset_rule
-table=t2 family=2 entries=129 op=nft_reset_rule'
+'table=t2 family=2 entries=509 op=nft_reset_rule'
 
 do_test 'nft reset rules' \
-'table=t1 family=2 entries=3 op=nft_reset_rule
-table=t1 family=2 entries=3 op=nft_reset_rule
-table=t1 family=2 entries=3 op=nft_reset_rule
-table=t2 family=2 entries=3 op=nft_reset_rule
-table=t2 family=2 entries=3 op=nft_reset_rule
-table=t2 family=2 entries=180 op=nft_reset_rule
-table=t2 family=2 entries=188 op=nft_reset_rule
-table=t2 family=2 entries=135 op=nft_reset_rule'
+'table=t1 family=2 entries=9 op=nft_reset_rule
+table=t2 family=2 entries=509 op=nft_reset_rule'
 
 # resetting sets and elements
 
@@ -200,13 +205,11 @@ do_test 'nft reset counters t1' \
 'table=t1 family=2 entries=1 op=nft_reset_obj'
 
 do_test 'nft reset counters t2' \
-'table=t2 family=2 entries=342 op=nft_reset_obj
-table=t2 family=2 entries=158 op=nft_reset_obj'
+'table=t2 family=2 entries=500 op=nft_reset_obj'
 
 do_test 'nft reset counters' \
 'table=t1 family=2 entries=1 op=nft_reset_obj
-table=t2 family=2 entries=341 op=nft_reset_obj
-table=t2 family=2 entries=159 op=nft_reset_obj'
+table=t2 family=2 entries=500 op=nft_reset_obj'
 
 # resetting quotas
 
@@ -217,13 +220,11 @@ do_test 'nft reset quotas t1' \
 'table=t1 family=2 entries=1 op=nft_reset_obj'
 
 do_test 'nft reset quotas t2' \
-'table=t2 family=2 entries=315 op=nft_reset_obj
-table=t2 family=2 entries=185 op=nft_reset_obj'
+'table=t2 family=2 entries=500 op=nft_reset_obj'
 
 do_test 'nft reset quotas' \
 'table=t1 family=2 entries=1 op=nft_reset_obj
-table=t2 family=2 entries=314 op=nft_reset_obj
-table=t2 family=2 entries=186 op=nft_reset_obj'
+table=t2 family=2 entries=500 op=nft_reset_obj'
 
 # deleting rules
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 994477ee87be..4bd8360d5422 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -534,7 +534,7 @@ int expect_strzr(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (expr) {
 		ret = 1;
 		result(llen, FAIL);
@@ -553,7 +553,7 @@ int expect_strnz(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (!expr) {
 		ret = 1;
 		result(llen, FAIL);
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 4ae417372e9e..7dd5668ea8a6 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -36,6 +36,12 @@
 #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
 #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
 
+#ifdef __s390x__
+#define ELF_HASH_ENTRY ELF(Xword)
+#else
+#define ELF_HASH_ENTRY ELF(Word)
+#endif
+
 static struct vdso_info
 {
 	bool valid;
@@ -47,8 +53,8 @@ static struct vdso_info
 	/* Symbol table */
 	ELF(Sym) *symtab;
 	const char *symstrings;
-	ELF(Word) *bucket, *chain;
-	ELF(Word) nbucket, nchain;
+	ELF_HASH_ENTRY *bucket, *chain;
+	ELF_HASH_ENTRY nbucket, nchain;
 
 	/* Version table */
 	ELF(Versym) *versym;
@@ -115,7 +121,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 	/*
 	 * Fish out the useful bits of the dynamic table.
 	 */
-	ELF(Word) *hash = 0;
+	ELF_HASH_ENTRY *hash = 0;
 	vdso_info.symstrings = 0;
 	vdso_info.symtab = 0;
 	vdso_info.versym = 0;
@@ -133,7 +139,7 @@ void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 				 + vdso_info.load_offset);
 			break;
 		case DT_HASH:
-			hash = (ELF(Word) *)
+			hash = (ELF_HASH_ENTRY *)
 				((uintptr_t)dyn[i].d_un.d_ptr
 				 + vdso_info.load_offset);
 			break;
@@ -216,7 +222,8 @@ void *vdso_sym(const char *version, const char *name)
 		ELF(Sym) *sym = &vdso_info.symtab[chain];
 
 		/* Check for a defined global or weak function w/ right name. */
-		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
+		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC &&
+		    ELF64_ST_TYPE(sym->st_info) != STT_NOTYPE)
 			continue;
 		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
 		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 7b543e7f04d7..fe0b3ec48c8d 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -18,18 +18,18 @@
 #elif defined(__aarch64__)
 #define VDSO_VERSION		3
 #define VDSO_NAMES		0
-#elif defined(__powerpc__)
+#elif defined(__powerpc64__)
 #define VDSO_VERSION		1
 #define VDSO_NAMES		0
-#define VDSO_32BIT		1
-#elif defined(__powerpc64__)
+#elif defined(__powerpc__)
 #define VDSO_VERSION		1
 #define VDSO_NAMES		0
-#elif defined (__s390__)
+#define VDSO_32BIT		1
+#elif defined (__s390__) && !defined(__s390x__)
 #define VDSO_VERSION		2
 #define VDSO_NAMES		0
 #define VDSO_32BIT		1
-#elif defined (__s390X__)
+#elif defined (__s390x__)
 #define VDSO_VERSION		2
 #define VDSO_NAMES		0
 #elif defined(__mips__)
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index e691a3cf1491..cdb697ae8343 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -114,6 +114,12 @@ static void fill_function_pointers()
 	if (!vdso)
 		vdso = dlopen("linux-gate.so.1",
 			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-vdso32.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-vdso64.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
 	if (!vdso) {
 		printf("[WARN]\tfailed to find vDSO\n");
 		return;
diff --git a/tools/tracing/rtla/Makefile.rtla b/tools/tracing/rtla/Makefile.rtla
index 3ff0b8970896..cc1d6b615475 100644
--- a/tools/tracing/rtla/Makefile.rtla
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -38,7 +38,7 @@ BINDIR		:= /usr/bin
 .PHONY: install
 install: doc_install
 	@$(MKDIR) -p $(DESTDIR)$(BINDIR)
-	$(call QUIET_INSTALL,rtla)$(INSTALL) rtla -m 755 $(DESTDIR)$(BINDIR)
+	$(call QUIET_INSTALL,rtla)$(INSTALL) $(RTLA) -m 755 $(DESTDIR)$(BINDIR)
 	@$(STRIP) $(DESTDIR)$(BINDIR)/rtla
 	@test ! -f $(DESTDIR)$(BINDIR)/osnoise || $(RM) $(DESTDIR)$(BINDIR)/osnoise
 	@$(LN) rtla $(DESTDIR)$(BINDIR)/osnoise
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index de33ea5005b6..51844cb9950a 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -434,7 +434,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				osnoise_top_usage(params, "Invalid -D duration\n");
+				osnoise_top_usage(params, "Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8c16419fe22a..210b0f533534 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -459,7 +459,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
 		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
-		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
+		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
@@ -613,7 +613,7 @@ static struct timerlat_top_params
 		case 'd':
 			params->duration = parse_seconds_duration(optarg);
 			if (!params->duration)
-				timerlat_top_usage("Invalid -D duration\n");
+				timerlat_top_usage("Invalid -d duration\n");
 			break;
 		case 'e':
 			tevent = trace_event_alloc(optarg);

