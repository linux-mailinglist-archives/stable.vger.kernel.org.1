Return-Path: <stable+bounces-94394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DDB9D3D0A
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A135D1F23EFB
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FA1AC447;
	Wed, 20 Nov 2024 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QldUUh87"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D31AAE31;
	Wed, 20 Nov 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111566; cv=none; b=FXJPZvltXSk+AiETHiGV+/DeiizyDqumafGZPpR9pb0BqJ0H6FFVI8Vg3lUvrHTvXXA1F1IDUB07rUj/LDTWRhb/xwqWSPKeAYRufX0Tu4CLpV75mPCs4eL1Dy7XdvTmH6NIK30Uh1EA5ZQUVk6x0THz6X12CX6hvIDxEMHLnGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111566; c=relaxed/simple;
	bh=gH4XVQaIJldKy7qk/dQ4j4jz+UhF9Fbtf8B8y4YDpSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pU3PI8e6m8lRggvbNSnfD+y7THxC1COvUvzi/1L9+aQVqYsZSy+xfG5+1pS4LYNceOBSOvVfMvqeIo2y5CwWBKnRiW1uLB8D8DXW2uzitggolBXKcoQa9h+Rxn5WJG2taW/g4dX1d4y5E9ljltwxKHObMXmRoo6kvSAKAJeRl34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QldUUh87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B398C4CECE;
	Wed, 20 Nov 2024 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111566;
	bh=gH4XVQaIJldKy7qk/dQ4j4jz+UhF9Fbtf8B8y4YDpSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QldUUh87NWzC2nrgBUhKr2b07JFxLQxwkcmWCdWPBIhtYkfmyukmYwwIg4FbZM7JD
	 2wsgV1M5Y4b62VqK118Hyed0dZkW1G6BMIIKpkehOQhYnE6r4MSmMrZ+0rZ5YyHaSk
	 xtEch9VMrfAJmz9TLWBx6bGUaj9j5hkdB/Cdts/qf4Dho+0QHglq/VrLAM0rCUN/X+
	 pYGhI42hRv11vkyORzv9hDwa6fk+JxIVNBniT886yqltS1BsKWCczYZler/9KIywxS
	 EBON2kjbUlMM3sMvpDpevcpnZcwNo6OxalQz3qGX56z9INWsxJ+De4rdP3WO3V9prZ
	 SUdIf0XnnUU2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	tglx@linutronix.de,
	wangliupu@loongson.cn,
	zhangtianyang@loongson.cn,
	jiaxun.yang@flygoat.com,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 03/10] LoongArch: For all possible CPUs setup logical-physical CPU mapping
Date: Wed, 20 Nov 2024 09:05:28 -0500
Message-ID: <20241120140556.1768511-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140556.1768511-1-sashal@kernel.org>
References: <20241120140556.1768511-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.9
Content-Transfer-Encoding: 8bit

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit a6654a40a852a4ca18aacced4cf5ca87997818d7 ]

In order to support ACPI-based physical CPU hotplug, we suppose for all
"possible" CPUs cpu_logical_map() can work. Because some drivers want to
use cpu_logical_map() for all "possible" CPUs, while currently we only
setup logical-physical mapping for "present" CPUs. This lack of mapping
also causes cpu_to_node() cannot work for hot-added CPUs.

All "possible" CPUs are listed in MADT, and the "present" subset is
marked as ACPI_MADT_ENABLED. To setup logical-physical CPU mapping for
all possible CPUs and keep present CPUs continuous in cpu_present_mask,
we parse MADT twice. The first pass handles CPUs with ACPI_MADT_ENABLED
and the second pass handles CPUs without ACPI_MADT_ENABLED.

The global flag (cpu_enumerated) is removed because acpi_map_cpu() calls
cpu_number_map() rather than set_processor_mask() now.

Reported-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/acpi.c | 81 +++++++++++++++++++++++-------------
 arch/loongarch/kernel/smp.c  |  3 +-
 2 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 929a497c987e8..de9e34414e614 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -57,48 +57,48 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 		return ioremap_cache(phys, size);
 }
 
-static int cpu_enumerated = 0;
-
 #ifdef CONFIG_SMP
-static int set_processor_mask(u32 id, u32 flags)
+static int set_processor_mask(u32 id, u32 pass)
 {
-	int nr_cpus;
-	int cpu, cpuid = id;
-
-	if (!cpu_enumerated)
-		nr_cpus = NR_CPUS;
-	else
-		nr_cpus = nr_cpu_ids;
+	int cpu = -1, cpuid = id;
 
-	if (num_processors >= nr_cpus) {
+	if (num_processors >= NR_CPUS) {
 		pr_warn(PREFIX "nr_cpus limit of %i reached."
-			" processor 0x%x ignored.\n", nr_cpus, cpuid);
+			" processor 0x%x ignored.\n", NR_CPUS, cpuid);
 
 		return -ENODEV;
 
 	}
+
 	if (cpuid == loongson_sysconf.boot_cpu_id)
 		cpu = 0;
-	else
-		cpu = find_first_zero_bit(cpumask_bits(cpu_present_mask), NR_CPUS);
-
-	if (!cpu_enumerated)
-		set_cpu_possible(cpu, true);
 
-	if (flags & ACPI_MADT_ENABLED) {
+	switch (pass) {
+	case 1: /* Pass 1 handle enabled processors */
+		if (cpu < 0)
+			cpu = find_first_zero_bit(cpumask_bits(cpu_present_mask), NR_CPUS);
 		num_processors++;
 		set_cpu_present(cpu, true);
-		__cpu_number_map[cpuid] = cpu;
-		__cpu_logical_map[cpu] = cpuid;
-	} else
+		break;
+	case 2: /* Pass 2 handle disabled processors */
+		if (cpu < 0)
+			cpu = find_first_zero_bit(cpumask_bits(cpu_possible_mask), NR_CPUS);
 		disabled_cpus++;
+		break;
+	default:
+		return cpu;
+	}
+
+	set_cpu_possible(cpu, true);
+	__cpu_number_map[cpuid] = cpu;
+	__cpu_logical_map[cpu] = cpuid;
 
 	return cpu;
 }
 #endif
 
 static int __init
-acpi_parse_processor(union acpi_subtable_headers *header, const unsigned long end)
+acpi_parse_p1_processor(union acpi_subtable_headers *header, const unsigned long end)
 {
 	struct acpi_madt_core_pic *processor = NULL;
 
@@ -109,12 +109,29 @@ acpi_parse_processor(union acpi_subtable_headers *header, const unsigned long en
 	acpi_table_print_madt_entry(&header->common);
 #ifdef CONFIG_SMP
 	acpi_core_pic[processor->core_id] = *processor;
-	set_processor_mask(processor->core_id, processor->flags);
+	if (processor->flags & ACPI_MADT_ENABLED)
+		set_processor_mask(processor->core_id, 1);
 #endif
 
 	return 0;
 }
 
+static int __init
+acpi_parse_p2_processor(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_core_pic *processor = NULL;
+
+	processor = (struct acpi_madt_core_pic *)header;
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
+#ifdef CONFIG_SMP
+	if (!(processor->flags & ACPI_MADT_ENABLED))
+		set_processor_mask(processor->core_id, 2);
+#endif
+
+	return 0;
+}
 static int __init
 acpi_parse_eio_master(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -142,12 +159,14 @@ static void __init acpi_process_madt(void)
 	}
 #endif
 	acpi_table_parse_madt(ACPI_MADT_TYPE_CORE_PIC,
-			acpi_parse_processor, MAX_CORE_PIC);
+			acpi_parse_p1_processor, MAX_CORE_PIC);
+
+	acpi_table_parse_madt(ACPI_MADT_TYPE_CORE_PIC,
+			acpi_parse_p2_processor, MAX_CORE_PIC);
 
 	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
 			acpi_parse_eio_master, MAX_IO_PICS);
 
-	cpu_enumerated = 1;
 	loongson_sysconf.nr_cpus = num_processors;
 }
 
@@ -306,6 +325,10 @@ static int __ref acpi_map_cpu2node(acpi_handle handle, int cpu, int physid)
 	int nid;
 
 	nid = acpi_get_node(handle);
+
+	if (nid != NUMA_NO_NODE)
+		nid = early_cpu_to_node(cpu);
+
 	if (nid != NUMA_NO_NODE) {
 		set_cpuid_to_node(physid, nid);
 		node_set(nid, numa_nodes_parsed);
@@ -320,12 +343,14 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu
 {
 	int cpu;
 
-	cpu = set_processor_mask(physid, ACPI_MADT_ENABLED);
-	if (cpu < 0) {
+	cpu = cpu_number_map(physid);
+	if (cpu < 0 || cpu >= nr_cpu_ids) {
 		pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
-		return cpu;
+		return -ERANGE;
 	}
 
+	num_processors++;
+	set_cpu_present(cpu, true);
 	acpi_map_cpu2node(handle, cpu, physid);
 
 	*pcpu = cpu;
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ca405ab86aaef..bb49478f3543a 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -325,11 +325,11 @@ void __init loongson_prepare_cpus(unsigned int max_cpus)
 	int i = 0;
 
 	parse_acpi_topology();
+	cpu_data[0].global_id = cpu_logical_map(0);
 
 	for (i = 0; i < loongson_sysconf.nr_cpus; i++) {
 		set_cpu_present(i, true);
 		csr_mail_send(0, __cpu_logical_map[i], 0);
-		cpu_data[i].global_id = __cpu_logical_map[i];
 	}
 
 	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
@@ -374,6 +374,7 @@ void loongson_init_secondary(void)
 		     cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
 	cpu_data[cpu].core = pptt_enabled ? cpu_data[cpu].core :
 		     cpu_logical_map(cpu) % loongson_sysconf.cores_per_package;
+	cpu_data[cpu].global_id = cpu_logical_map(cpu);
 }
 
 void loongson_smp_finish(void)
-- 
2.43.0


