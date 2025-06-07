Return-Path: <stable+bounces-151845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6CAD0E14
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAD716D1F6
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3C91E1E04;
	Sat,  7 Jun 2025 15:23:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB91DB122
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749309789; cv=none; b=PbBNTsmDmtipxbh3OrYrrbx+BhvwP0+L7wenZWawbsKjqHsqHVkQuPKDJU5whblGuGFD0HxDovGAEN5G4j2ibbNXWDuGPBlKV1FulRJzoi/MCTRtHkepyau9LpRnNcyA7NVq3Mw5HPGEbm2W/eKEzuMiKdSHM2jFqsHuFwcmkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749309789; c=relaxed/simple;
	bh=1yq5IZSIXOliYNvA0OnPw99IGodUu/dpfQAnEjP52yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tNtVkkokWApUQctPLgh1fgeXjDPoftlyTOJijsacn3oMthEh3w9vUUaU4EsHZS9F0fbXjS2QZoCLQ4sI5DK+NRQFc+Ur7ImpoGQ1/uvPZY0CkmGwzzomTTbHPCLqww33A7MGKo6jFc25c+ZLNhYkoBj/Ft3xucaBpwYJxjbW7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bF24f6JFlzYQvTh
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DD38A1A0ECC
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 23:22:57 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycNKWURof5hIOg--.36463S8;
	Sat, 07 Jun 2025 23:22:55 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: stable@vger.kernel.org
Cc: james.morse@arm.com,
	catalin.marinas@arm.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	xukuohai@huawei.com,
	pulehui@huawei.com
Subject: [PATCH 5.10 06/14] arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre BHB
Date: Sat,  7 Jun 2025 15:25:13 +0000
Message-Id: <20250607152521.2828291-7-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607152521.2828291-1-pulehui@huaweicloud.com>
References: <20250607152521.2828291-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3ycNKWURof5hIOg--.36463S8
X-Coremail-Antispam: 1UD129KBjvJXoW3uw1rAr1UZrW3Jr1fZFW7twb_yoWkWw45pF
	Z8GF1xur4DuF1SqrW7J3Z8KFy5C3s5XrZ3AFWjkrsav3WDKFyfJrs8Ka4vgFsYvrWrXayD
	C3WDKw1Fgw4xArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1l_M7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit e403e8538359d8580cbee1976ff71813e947101e ]

The code for detecting CPUs that are vulnerable to Spectre BHB was
based on a hardcoded list of CPU IDs that were known to be affected.
Unfortunately, the list mostly only contained the IDs of standard ARM
cores. The IDs for many cores that are minor variants of the standard
ARM cores (like many Qualcomm Kyro CPUs) weren't listed. This led the
code to assume that those variants were not affected.

Flip the code on its head and instead assume that a core is vulnerable
if it doesn't have CSV2_3 but is unrecognized as being safe. This
involves creating a "Spectre BHB safe" list.

As of right now, the only CPU IDs added to the "Spectre BHB safe" list
are ARM Cortex A35, A53, A55, A510, and A520. This list was created by
looking for cores that weren't listed in ARM's list [1] as per review
feedback on v2 of this patch [2]. Additionally Brahma A53 is added as
per mailing list feedback [3].

NOTE: this patch will not actually _mitigate_ anyone, it will simply
cause them to report themselves as vulnerable. If any cores in the
system are reported as vulnerable but not mitigated then the whole
system will be reported as vulnerable though the system will attempt
to mitigate with the information it has about the known cores.

[1] https://developer.arm.com/Arm%20Security%20Center/Spectre-BHB
[2] https://lore.kernel.org/r/20241219175128.GA25477@willie-the-truck
[3] https://lore.kernel.org/r/18dbd7d1-a46c-4112-a425-320c99f67a8d@broadcom.com

Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Reviewed-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20250107120555.v4.2.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Conflicts:
	arch/arm64/kernel/proton-pack.c
[The conflicts were mainly due to LTS commit e192c8baa69a
differ from mainline commit 558c303c9734]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/include/asm/spectre.h |   1 -
 arch/arm64/kernel/proton-pack.c  | 171 ++++++++++++++++---------------
 2 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index 9c8ed2c4629d..86e1ef6fc170 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -33,7 +33,6 @@ void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
 bool is_spectre_bhb_fw_mitigated(void);
-u8 spectre_bhb_loop_affected(int scope);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
 #endif	/* __ASM_SPECTRE_H */
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 95b8d76670c8..e7c85f6ea75a 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -853,53 +853,70 @@ enum mitigation_state arm64_get_spectre_bhb_state(void)
  * This must be called with SCOPE_LOCAL_CPU for each type of CPU, before any
  * SCOPE_SYSTEM call will give the right answer.
  */
-u8 spectre_bhb_loop_affected(int scope)
+static bool is_spectre_bhb_safe(int scope)
+{
+	static const struct midr_range spectre_bhb_safe_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A520),
+		MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
+		{},
+	};
+	static bool all_safe = true;
+
+	if (scope != SCOPE_LOCAL_CPU)
+		return all_safe;
+
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_safe_list))
+		return true;
+
+	all_safe = false;
+
+	return false;
+}
+
+static u8 spectre_bhb_loop_affected(void)
 {
 	u8 k = 0;
-	static u8 max_bhb_k;
-
-	if (scope == SCOPE_LOCAL_CPU) {
-		static const struct midr_range spectre_bhb_k32_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k24_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
-			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
-			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k11_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_AMPERE1),
-			{},
-		};
-		static const struct midr_range spectre_bhb_k8_list[] = {
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-			MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-			{},
-		};
-
-		if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
-			k = 32;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
-			k = 24;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
-			k = 11;
-		else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
-			k =  8;
-
-		max_bhb_k = max(max_bhb_k, k);
-	} else {
-		k = max_bhb_k;
-	}
+
+	static const struct midr_range spectre_bhb_k32_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k24_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k11_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		{},
+	};
+	static const struct midr_range spectre_bhb_k8_list[] = {
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		{},
+	};
+
+	if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
+		k = 32;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_list))
+		k = 24;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_list))
+		k = 11;
+	else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_list))
+		k =  8;
 
 	return k;
 }
@@ -925,29 +942,13 @@ static enum mitigation_state spectre_bhb_get_cpu_fw_mitigation_state(void)
 	}
 }
 
-static bool is_spectre_bhb_fw_affected(int scope)
+static bool has_spectre_bhb_fw_mitigation(void)
 {
-	static bool system_affected;
 	enum mitigation_state fw_state;
 	bool has_smccc = arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE;
-	static const struct midr_range spectre_bhb_firmware_mitigated_list[] = {
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		{},
-	};
-	bool cpu_in_list = is_midr_in_range_list(read_cpuid_id(),
-					 spectre_bhb_firmware_mitigated_list);
-
-	if (scope != SCOPE_LOCAL_CPU)
-		return system_affected;
 
 	fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
-	if (cpu_in_list || (has_smccc && fw_state == SPECTRE_MITIGATED)) {
-		system_affected = true;
-		return true;
-	}
-
-	return false;
+	return has_smccc && fw_state == SPECTRE_MITIGATED;
 }
 
 static bool supports_ecbhb(int scope)
@@ -963,6 +964,8 @@ static bool supports_ecbhb(int scope)
 						    ID_AA64MMFR1_ECBHB_SHIFT);
 }
 
+static u8 max_bhb_k;
+
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 			     int scope)
 {
@@ -971,16 +974,18 @@ bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 	if (supports_csv2p3(scope))
 		return false;
 
-	if (supports_clearbhb(scope))
-		return true;
-
-	if (spectre_bhb_loop_affected(scope))
-		return true;
+	if (is_spectre_bhb_safe(scope))
+		return false;
 
-	if (is_spectre_bhb_fw_affected(scope))
-		return true;
+	/*
+	 * At this point the core isn't known to be "safe" so we're going to
+	 * assume it's vulnerable. We still need to update `max_bhb_k` though,
+	 * but only if we aren't mitigating with clearbhb though.
+	 */
+	if (scope == SCOPE_LOCAL_CPU && !supports_clearbhb(SCOPE_LOCAL_CPU))
+		max_bhb_k = max(max_bhb_k, spectre_bhb_loop_affected());
 
-	return false;
+	return true;
 }
 
 static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
@@ -1063,7 +1068,7 @@ static bool spectre_bhb_fw_mitigated;
 
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
-	enum mitigation_state fw_state, state = SPECTRE_VULNERABLE;
+	enum mitigation_state state = SPECTRE_VULNERABLE;
 
 	if (!is_spectre_bhb_affected(entry, SCOPE_LOCAL_CPU))
 		return;
@@ -1081,8 +1086,8 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		this_cpu_set_vectors(EL1_VECTOR_BHB_CLEAR_INSN);
 
 		state = SPECTRE_MITIGATED;
-	} else if (spectre_bhb_loop_affected(SCOPE_LOCAL_CPU)) {
-		switch (spectre_bhb_loop_affected(SCOPE_SYSTEM)) {
+	} else if (spectre_bhb_loop_affected()) {
+		switch (max_bhb_k) {
 		case 8:
 			kvm_setup_bhb_slot(__spectre_bhb_loop_k8);
 			break;
@@ -1098,15 +1103,12 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		this_cpu_set_vectors(EL1_VECTOR_BHB_LOOP);
 
 		state = SPECTRE_MITIGATED;
-	} else if (is_spectre_bhb_fw_affected(SCOPE_LOCAL_CPU)) {
-		fw_state = spectre_bhb_get_cpu_fw_mitigation_state();
-		if (fw_state == SPECTRE_MITIGATED) {
-			kvm_setup_bhb_slot(__smccc_workaround_3_smc);
-			this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
-
-			state = SPECTRE_MITIGATED;
-			spectre_bhb_fw_mitigated = true;
-		}
+	} else if (has_spectre_bhb_fw_mitigation()) {
+		kvm_setup_bhb_slot(__smccc_workaround_3_smc);
+		this_cpu_set_vectors(EL1_VECTOR_BHB_FW);
+
+		state = SPECTRE_MITIGATED;
+		spectre_bhb_fw_mitigated = true;
 	}
 
 	update_mitigation_state(&spectre_bhb_state, state);
@@ -1123,7 +1125,6 @@ void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 {
 	u8 rd;
 	u32 insn;
-	u16 loop_count = spectre_bhb_loop_affected(SCOPE_SYSTEM);
 
 	BUG_ON(nr_inst != 1); /* MOV -> MOV */
 
@@ -1132,7 +1133,7 @@ void noinstr spectre_bhb_patch_loop_iter(struct alt_instr *alt,
 
 	insn = le32_to_cpu(*origptr);
 	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
-	insn = aarch64_insn_gen_movewide(rd, loop_count, 0,
+	insn = aarch64_insn_gen_movewide(rd, max_bhb_k, 0,
 					 AARCH64_INSN_VARIANT_64BIT,
 					 AARCH64_INSN_MOVEWIDE_ZERO);
 	*updptr++ = cpu_to_le32(insn);
-- 
2.34.1


