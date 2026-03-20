Return-Path: <stable+bounces-227428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJC2LA+9vGlb2gIAu9opvQ
	(envelope-from <stable+bounces-227428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:20:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D382D578B
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3BC03032617
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4153930EF95;
	Fri, 20 Mar 2026 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ypbclQg4"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E3307AC7;
	Fri, 20 Mar 2026 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976681; cv=none; b=ORQtO3+N6T4/dK01Ppd73GZtcdb8Aj+L917WSNma+FE46B2SuMXpzpas+Y3CYnjWWy+8VtU2QxnDvLZx0sD1c8oo1Av41htqwFkuErTGXXXoPypCMohl+Hn3lkPDksjE38bLXWcWOQn0azQGjnix2HL7HngU6EieznARR8oVA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976681; c=relaxed/simple;
	bh=XYhm17CwRJDrJ/8Bt5up3GMk66J2ridw/7IXlx8exkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPDtrBnDUWggDmOEh7SpQAAbYpz31MDUS76XbD8xmXUpHDhAx5X8PhUCzK4+Ohv+hx037lRfdYKSJiwfPwdu/w1aXOAn3LNNC4e14IUDhlDQr7sCambLEzIpC+RV6u7qiF+4SrsIYIRKxlkgfk2rzsxpRJXPZqIshnMGAkK362E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ypbclQg4; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/eBsZSTPYF/YtxnkPhtkEULxH4VEHo0dKDplLzt2h+U=;
	b=ypbclQg4Iukdlkqpoizb0I/F7L+DePAd+M0//lXkMgfo2Tebtl3dWlIRb5T+BpmkoHuv3dAUf
	q4obfVRqfYA+w4THr01Bmp7st54V9VWVLRFBbSiDcMjxC61DIiVgmZCmNOX7nmSXAg0dF57r5Ul
	C2JQqU6Aei7BxV0EFNUv0ls=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fcSK804FCz1K9Zv;
	Fri, 20 Mar 2026 11:11:56 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 14B0940565;
	Fri, 20 Mar 2026 11:17:56 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Mar 2026 11:17:54 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Palmer Dabbelt <palmer@dabbelt.com>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Juergen
 Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len
 Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, Mark Rutland
	<mark.rutland@arm.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Kees
 Cook <kees@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Sean
 Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, Thomas Huth <thuth@redhat.com>, Thorsten
 Blum <thorsten.blum@linux.dev>, Kevin Loughlin <kevinloughlin@google.com>,
	Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>,
	"Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta
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
	<liuyonglong@huawei.com>, <fengchengwen@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>, <linux-acpi@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v10 7/8] ACPI: PPTT: Use acpi_get_cpu_uid() and remove get_acpi_id_for_cpu()
Date: Fri, 20 Mar 2026 11:17:36 +0800
Message-ID: <20260320031737.35048-8-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260320031737.35048-1-fengchengwen@huawei.com>
References: <20260320031737.35048-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227428-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_GT_50(0.00)[60];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7D382D578B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update acpi/pptt.c to use acpi_get_cpu_uid() and remove unused
get_acpi_id_for_cpu() from arm64/loongarch/riscv, completing PPTT's
migration to the unified ACPI CPU UID interface

Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 arch/arm64/include/asm/acpi.h     |  4 ---
 arch/loongarch/include/asm/acpi.h |  5 ----
 arch/riscv/include/asm/acpi.h     |  4 ---
 drivers/acpi/pptt.c               | 50 +++++++++++++++++++++++--------
 4 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index bdb0ecf95b5c..8a54ca6ba602 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -114,10 +114,6 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
-static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
-{
-	return	acpi_cpu_get_madt_gicc(cpu)->uid;
-}
 int get_cpu_for_acpi_id(u32 uid);
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
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
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index de5f8c018333..7bd5bc1f225a 100644
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
@@ -671,7 +682,9 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
 
 	pr_debug("Cache Setup: find cache levels for CPU=%d\n", cpu);
 
-	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id))
+		return -ENOENT;
+
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (!cpu_node)
 		return -ENOENT;
@@ -780,8 +793,9 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
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
 
@@ -797,7 +811,9 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu)
 	if (!table)
 		return -ENOENT;
 
-	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
+		return -ENOENT;
+
 	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
 	if (!cpu_node || !cpu_node->parent)
 		return -ENOENT;
@@ -872,7 +888,9 @@ static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr,
 	cpumask_clear(cpus);
 
 	for_each_possible_cpu(cpu) {
-		acpi_id = get_acpi_id_for_cpu(cpu);
+		if (acpi_get_cpu_uid(cpu, &acpi_id) != 0)
+			continue;
+
 		cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
 
 		while (cpu_node) {
@@ -966,10 +984,13 @@ int find_acpi_cache_level_from_id(u32 cache_id)
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
@@ -1030,10 +1051,13 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
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
-- 
2.17.1


