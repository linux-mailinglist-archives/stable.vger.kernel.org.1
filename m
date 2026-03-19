Return-Path: <stable+bounces-227217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGbbELKeu2nolwIAu9opvQ
	(envelope-from <stable+bounces-227217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:58:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D90962C6FDF
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82528318C316
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 06:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE8D39A7FB;
	Thu, 19 Mar 2026 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TpkbNgrX"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268DF392C40;
	Thu, 19 Mar 2026 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903474; cv=none; b=D0XWIlJILYIZAbiy7gkzWzOqlS7ub0fWH8KE3/7wu9T4w6awchfNnbjxhfLinZsuPIXJ6/KEOuHuTwQ8o1ycw671ga7zRdrH4bjHf4wn7hZ2HPezIfeVGyUNyA8F1eKqnI3Zox3Xsd+SffKB28DnHgT81ho55qP/x/Mw6L08fL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903474; c=relaxed/simple;
	bh=qRMoR/4CVZ9PWhOYyCreIi0zuejMfud4YxtvrSe9kmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OP4nkY1A5OCx1763TvDvYSG2YX+1wi7TmzuM8e31BNPI/qMfKi66h+N9PQrS4VBYlvC5fuA2pVWg4AS5G5COpEQkZAJF7NFF+gdrjpxrCPAYCpuRZrsmk/paruE/61hbgHCrNNm2WUWPheAiEsAKc4lk03cUQyEoibSs6vdZlBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TpkbNgrX; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=exD33k43BuQzAEL6nsjKEJKqL7EfNu0IQKwl4k+YbJg=;
	b=TpkbNgrXuFHMaoSxLqV9Sehh2jyBNhzuFTjk04digWx+iZ4u7r0ZO97pTwpdiOPz3O6n3lNJ/
	4V3t97Mi4HDOAvKqXG7pd8g0EWINQftSU1qn9BC94Y+G026NOS1ZPVoH/xNOselntlRacsW/mDN
	uHBm/USFU8RvNhGQhD/mcZg=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fbxFK6mMMz1K9Ct;
	Thu, 19 Mar 2026 14:51:49 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7856240561;
	Thu, 19 Mar 2026 14:57:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 14:57:47 +0800
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
	<liuyonglong@huawei.com>, <fengchengwen@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>, <linux-acpi@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v9 3/7] riscv/acpi: Add acpi_get_cpu_uid() implementation and update users
Date: Thu, 19 Mar 2026 14:57:31 +0800
Message-ID: <20260319065735.45954-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260319065735.45954-1-fengchengwen@huawei.com>
References: <20260319065735.45954-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227217-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_GT_50(0.00)[70];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: D90962C6FDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add arch-specific acpi_get_cpu_uid() for riscv:
- Declare acpi_get_cpu_uid() in arch/riscv/include/asm/acpi.h
- Implement acpi_get_cpu_uid() with input parameter validation
- Switch rhct.c and arch/riscv/kernel/acpi_numa.c to use
  acpi_get_cpu_uid() instead of get_acpi_id_for_cpu()

This aligns riscv with the unified ACPI CPU UID interface, improving
input validation and consistency across ACPI-enabled platforms.

Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 arch/riscv/include/asm/acpi.h |  1 +
 arch/riscv/kernel/acpi.c      | 16 ++++++++++++++++
 arch/riscv/kernel/acpi_numa.c |  9 ++++++---
 drivers/acpi/riscv/rhct.c     |  7 ++++++-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..f3520cc85af3 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -65,6 +65,7 @@ static inline u32 get_acpi_id_for_cpu(int cpu)
 {
 	return acpi_cpu_get_madt_rintc(cpu)->uid;
 }
+int acpi_get_cpu_uid(unsigned int cpu, u32 *uid);
 
 int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 71698ee11621..322ea92aa39f 100644
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
+	if (!rintc)
+		return -ENODEV;
+
+	*uid = rintc->uid;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
index 130769e3a99c..6a2d4289f806 100644
--- a/arch/riscv/kernel/acpi_numa.c
+++ b/arch/riscv/kernel/acpi_numa.c
@@ -37,11 +37,14 @@ static int __init acpi_numa_get_nid(unsigned int cpu)
 
 static inline int get_cpu_for_acpi_id(u32 uid)
 {
-	int cpu;
+	u32 cpu_uid;
+	int ret;
 
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
-		if (uid == get_acpi_id_for_cpu(cpu))
+	for (int cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		ret = acpi_get_cpu_uid(cpu, &cpu_uid);
+		if (ret == 0 && uid == cpu_uid)
 			return cpu;
+	}
 
 	return -EINVAL;
 }
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
-- 
2.17.1


