Return-Path: <stable+bounces-224811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFWAOh9qsmnSMQAAu9opvQ
	(envelope-from <stable+bounces-224811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:24:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3626E515
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D577F300DA4F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587903AF64E;
	Thu, 12 Mar 2026 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="j8tTia/x";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="j8tTia/x"
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705E3AD52F;
	Thu, 12 Mar 2026 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773300228; cv=none; b=cNjIOqUPt5hqHTi9vrbyQeGMWAciqWv4SoqKZZ4HkEZSt74Cu7P2s9hbVujeDVL3t4Z5gznKV6lGcIvoSKRnRplHEKwN4YacNvs9IYaUfNjREVIUu2H4ZoRZEuvrlF2VPiPKzuGeiWtagwrk0JRegL9yDuQBdwwplH4Z63o6fyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773300228; c=relaxed/simple;
	bh=bXR9ul68qlOcnQkr2Ydjm20QiAUkBkOWHA143ODKK38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZpXY/syKu1a013ivpCt8DKW1aDXPfODZulXxjwB0INL70bO+tcVGpS6jgsDvWOMGRiprRuNh/MzBugEE51yFFUNEJuyLcxC4yxSN8CYC4KW52yGLbxUNwGsiWuar9JdaBOtalw6ED5+DLUFYEww/Z8jdx6HIDtExRPhBgXb1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=j8tTia/x; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=j8tTia/x; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=emV69WpU1M2zFss/hf94/6FIT7KCIgFkUPlPK9LbC5k=;
	b=j8tTia/xDFsmamQXC4xERo2SqnVDUL5uyF8l36854lADwIwF8uhGv4gi8EgWOIh1KVcCupZhN
	oo4UTdGEKneHxRKIcfRSdW19zQBfFIRRgZ5doELv/oYNecFkKbM+rJz6ds/oxOya5CDwjZ0tsSF
	8V2T+RPOx1IMmKLnvqLMiz0=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4fWfGL3JNvz1BG6P;
	Thu, 12 Mar 2026 15:22:50 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=emV69WpU1M2zFss/hf94/6FIT7KCIgFkUPlPK9LbC5k=;
	b=j8tTia/xDFsmamQXC4xERo2SqnVDUL5uyF8l36854lADwIwF8uhGv4gi8EgWOIh1KVcCupZhN
	oo4UTdGEKneHxRKIcfRSdW19zQBfFIRRgZ5doELv/oYNecFkKbM+rJz6ds/oxOya5CDwjZ0tsSF
	8V2T+RPOx1IMmKLnvqLMiz0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fWf8k1dMkzcb42;
	Thu, 12 Mar 2026 15:17:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D2B54056E;
	Thu, 12 Mar 2026 15:23:26 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Mar 2026 15:23:24 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>, Sunil V
 L <sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>, Yanteng
 Si <si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>, Kai Huang
	<kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Huth
	<thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>, Kevin Loughlin
	<kevinloughlin@google.com>, Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin
 Li <xin@zytor.com>, "Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta
	<sohil.mehta@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Robin
 Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>, Besar
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Wei Huang
	<wei.huang2@amd.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, <punit.agrawal@oss.qualcomm.com>,
	<guohanjun@huawei.com>, <suzuki.poulose@arm.com>, <ryan.roberts@arm.com>,
	<chenl311@chinatelecom.cn>, <masahiroy@kernel.org>,
	<wangyuquan1236@phytium.com.cn>, <anshuman.khandual@arm.com>,
	<heinrich.schuchardt@canonical.com>, <Eric.VanTassell@amd.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
	<linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v6 1/3] ACPI: Rename get_acpi_id_for_cpu() to acpi_get_cpu_uid() on non-x86
Date: Thu, 12 Mar 2026 15:23:14 +0800
Message-ID: <20260312072316.4806-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260312072316.4806-1-fengchengwen@huawei.com>
References: <20260312072316.4806-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224811-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[69];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 66F3626E515
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To unify the CPU ACPI ID retrieval interface across architectures,
rename the existing get_acpi_id_for_cpu() function to
acpi_get_cpu_uid() on arm64/riscv/loongarch platforms.

This is a pure rename with no functional change, preparing for a
consistent ACPI Processor UID retrieval interface across all ACPI-enabled
platforms.

Note: Move the ARM64-specific get_cpu_for_acpi_id() implementation to
      arch/arm64/kernel/acpi_numa.c to fix compilation errors from
      circular header dependencies introduced by the rename.

Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 arch/arm64/include/asm/acpi.h      | 16 +---------
 arch/arm64/kernel/acpi.c           | 16 ++++++++++
 arch/arm64/kernel/acpi_numa.c      | 15 ++++++++++
 arch/loongarch/include/asm/acpi.h  |  5 ----
 arch/loongarch/kernel/acpi.c       |  9 ++++++
 arch/riscv/include/asm/acpi.h      |  4 ---
 arch/riscv/kernel/acpi.c           | 16 ++++++++++
 arch/riscv/kernel/acpi_numa.c      |  8 +++--
 drivers/acpi/pptt.c                | 47 +++++++++++++++++++++---------
 drivers/acpi/riscv/rhct.c          |  7 ++++-
 drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++--
 include/linux/acpi.h               | 13 +++++++++
 12 files changed, 120 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index c07a58b96329..106a08556cbf 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -114,22 +114,8 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
-static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
-{
-	return	acpi_cpu_get_madt_gicc(cpu)->uid;
-}
-
-static inline int get_cpu_for_acpi_id(u32 uid)
-{
-	int cpu;
-
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
-		if (acpi_cpu_get_madt_gicc(cpu) &&
-		    uid == get_acpi_id_for_cpu(cpu))
-			return cpu;
 
-	return -EINVAL;
-}
+int get_cpu_for_acpi_id(u32 uid);
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index af90128cfed5..984a11788265 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -458,3 +458,19 @@ int acpi_unmap_cpu(int cpu)
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
+int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
+{
+	struct acpi_madt_generic_interrupt *gicc;
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	gicc = acpi_cpu_get_madt_gicc(cpu);
+	if (gicc == NULL)
+		return -ENODEV;
+
+	*uid = gicc->uid;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index 2465f291c7e1..56e2e486e49b 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -34,6 +34,21 @@ int __init acpi_numa_get_nid(unsigned int cpu)
 	return acpi_early_node_map[cpu];
 }
 
+int get_cpu_for_acpi_id(u32 uid)
+{
+	u32 cpu_uid;
+	int cpu;
+	int ret;
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		ret = acpi_get_cpu_uid(cpu, &cpu_uid);
+		if (ret == 0 && uid == cpu_uid)
+			return cpu;
+	}
+
+	return -EINVAL;
+}
+
 static int __init acpi_parse_gicc_pxm(union acpi_subtable_headers *header,
 				      const unsigned long end)
 {
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 7376840fa9f7..eda9d4d0a493 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -40,11 +40,6 @@ extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
 extern int __init parse_acpi_topology(void);
 
-static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
-{
-	return acpi_core_pic[cpu_logical_map(cpu)].processor_id;
-}
-
 #endif /* !CONFIG_ACPI */
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 1367ca759468..058f0dbe8e8f 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -385,3 +385,12 @@ int acpi_unmap_cpu(int cpu)
 EXPORT_SYMBOL(acpi_unmap_cpu);
 
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
+
+int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
+{
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+	*uid = acpi_core_pic[cpu_logical_map(cpu)].processor_id;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..26ab37c171bc 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -61,10 +61,6 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
 void acpi_init_rintc_map(void);
 struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
-static inline u32 get_acpi_id_for_cpu(int cpu)
-{
-	return acpi_cpu_get_madt_rintc(cpu)->uid;
-}
 
 int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 71698ee11621..bde810d02c4f 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -337,3 +337,19 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
 }
 
 #endif	/* CONFIG_PCI */
+
+int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
+{
+	struct acpi_madt_rintc *rintc;
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	rintc = acpi_cpu_get_madt_rintc(cpu);
+	if (rintc == NULL)
+		return -ENODEV;
+
+	*uid = rintc->uid;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
index 130769e3a99c..cd8adc9857e3 100644
--- a/arch/riscv/kernel/acpi_numa.c
+++ b/arch/riscv/kernel/acpi_numa.c
@@ -37,11 +37,15 @@ static int __init acpi_numa_get_nid(unsigned int cpu)
 
 static inline int get_cpu_for_acpi_id(u32 uid)
 {
+	u32 cpu_uid;
 	int cpu;
+	int ret;
 
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
-		if (uid == get_acpi_id_for_cpu(cpu))
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		ret = acpi_get_cpu_uid(cpu, &cpu_uid);
+		if (ret == 0 && uid == cpu_uid)
 			return cpu;
+	}
 
 	return -EINVAL;
 }
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index de5f8c018333..d034a217e85b 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -459,11 +459,14 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 {
 	struct acpi_pptt_cache *found_cache;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	u32 acpi_cpu_id;
 	struct cacheinfo *this_leaf;
 	unsigned int index = 0;
 	struct acpi_pptt_processor *cpu_node = NULL;
 
+	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
+		return;
+
 	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
 		this_leaf = this_cpu_ci->info_list + index;
 		found_cache = acpi_find_cache_node(table, acpi_cpu_id,
@@ -546,7 +549,10 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 				     unsigned int cpu, int level, int flag)
 {
 	struct acpi_pptt_processor *cpu_node;
-	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	u32 acpi_cpu_id;
+
+	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
+		return -ENOENT;
 
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (cpu_node) {
@@ -614,18 +620,22 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
  *
  * Check the node representing a CPU for a given flag.
  *
- * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
- *	   the table revision isn't new enough.
+ * Return: -ENOENT if can't get CPU's ACPI Processor UID, the PPTT doesn't
+ *	   exist, the CPU cannot be found or the table revision isn't new
+ *	   enough.
  *	   1, any passed flag set
  *	   0, flag unset
  */
 static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
 {
 	struct acpi_table_header *table;
-	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	u32 acpi_cpu_id;
 	struct acpi_pptt_processor *cpu_node = NULL;
 	int ret = -ENOENT;
 
+	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
+		return -ENOENT;
+
 	table = acpi_get_pptt();
 	if (!table)
 		return -ENOENT;
@@ -651,7 +661,8 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
  * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, return 0
  * indicating we didn't find any cache levels.
  *
- * Return: -ENOENT if no PPTT table or no PPTT processor struct found.
+ * Return: -ENOENT if no PPTT table, can't get CPU's ACPI Process UID or no PPTT
+ *	   processor struct found.
  *	   0 on success.
  */
 int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
@@ -671,7 +682,8 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
 
 	pr_debug("Cache Setup: find cache levels for CPU=%d\n", cpu);
 
-	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id))
+		return -ENOENT;
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (!cpu_node)
 		return -ENOENT;
@@ -780,8 +792,9 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
  * It may not exist in single CPU systems. In simple multi-CPU systems,
  * it may be equal to the package topology level.
  *
- * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found
- * or there is no toplogy level above the CPU..
+ * Return: -ENOENT if the PPTT doesn't exist, can't get CPU's ACPI
+ * Processor UID, the CPU cannot be found or there is no toplogy level
+ * above the CPU.
  * Otherwise returns a value which represents the package for this CPU.
  */
 
@@ -797,7 +810,8 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu)
 	if (!table)
 		return -ENOENT;
 
-	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
+		return -ENOENT;
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (!cpu_node || !cpu_node->parent)
 		return -ENOENT;
@@ -872,7 +886,8 @@ static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr,
 	cpumask_clear(cpus);
 
 	for_each_possible_cpu(cpu) {
-		acpi_id = get_acpi_id_for_cpu(cpu);
+		if (acpi_get_cpu_uid(cpu, &acpi_id) != 0)
+			continue;
 		cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
 
 		while (cpu_node) {
@@ -966,10 +981,13 @@ int find_acpi_cache_level_from_id(u32 cache_id)
 	for_each_possible_cpu(cpu) {
 		bool empty;
 		int level = 1;
-		u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+		u32 acpi_cpu_id;
 		struct acpi_pptt_cache *cache;
 		struct acpi_pptt_processor *cpu_node;
 
+		if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
+			continue;
+
 		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 		if (!cpu_node)
 			continue;
@@ -1030,10 +1048,13 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
 	for_each_possible_cpu(cpu) {
 		bool empty;
 		int level = 1;
-		u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+		u32 acpi_cpu_id;
 		struct acpi_pptt_cache *cache;
 		struct acpi_pptt_processor *cpu_node;
 
+		if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
+			continue;
+
 		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 		if (!cpu_node)
 			continue;
diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index caa2c16e1697..8f3f38c64a88 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -44,10 +44,15 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 	struct acpi_rhct_isa_string *isa_node;
 	struct acpi_table_rhct *rhct;
 	u32 *hart_info_node_offset;
-	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	u32 acpi_cpu_id;
+	int ret;
 
 	BUG_ON(acpi_disabled);
 
+	ret = acpi_get_cpu_uid(cpu, &acpi_cpu_id);
+	if (ret != 0)
+		return ret;
+
 	if (!table) {
 		rhct = acpi_get_rhct();
 		if (!rhct)
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 34430b68f602..ed72c3d1f796 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1107,15 +1107,17 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
 {
 	struct acpi_apmt_node *apmt_node;
 	int affinity_flag;
+	u32 cpu_uid;
 	int cpu;
+	int ret;
 
 	apmt_node = arm_cspmu_apmt_node(cspmu->dev);
 	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
 
 	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
 		for_each_possible_cpu(cpu) {
-			if (apmt_node->proc_affinity ==
-			    get_acpi_id_for_cpu(cpu)) {
+			ret = acpi_get_cpu_uid(cpu, &cpu_uid);
+			if (ret == 0 && apmt_node->proc_affinity == cpu_uid) {
 				cpumask_set_cpu(cpu, &cspmu->associated_cpus);
 				break;
 			}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d2f0bed7a06..035094a55f18 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -324,6 +324,19 @@ int acpi_unmap_cpu(int cpu);
 
 acpi_handle acpi_get_processor_handle(int cpu);
 
+#ifndef CONFIG_X86
+/*
+ * acpi_get_cpu_uid() - Get ACPI Processor UID of a specified CPU from MADT table
+ * @cpu: Logical CPU number (0-based)
+ * @uid: Pointer to store the ACPI Processor UID (valid only on successful return)
+ *
+ * Return: 0 on successful retrieval (the ACPI Processor ID is stored in *uid);
+ *         -EINVAL if the CPU number is invalid or out of range;
+ *         -ENODEV if the ACPI Processor UID for the specified CPU is not found.
+ */
+int acpi_get_cpu_uid(unsigned int cpu, u32 *uid);
+#endif
+
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
 #endif
-- 
2.17.1


