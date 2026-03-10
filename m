Return-Path: <stable+bounces-223746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJgpINSOr2kragIAu9opvQ
	(envelope-from <stable+bounces-223746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:24:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202C3244C01
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60230317D3A0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A183B95E3;
	Tue, 10 Mar 2026 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ixI1woUG"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9843399007;
	Tue, 10 Mar 2026 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112876; cv=none; b=DYlNnMU5v9JGzsr0TWlKkdtIT/C2WNNQ3MkXY/WPdY1dnLFArFPva+W+zjPNMfb1iOAfF6O4P3Py2QgnKWfsDWlZlBoG2wTp7thUL3DP9Y9Ib76RqzRoq9t4VdIcAGer0/+q5k+mFiWJj2eSQfGQSn6GPKdbr6r2XLvzfzjT/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112876; c=relaxed/simple;
	bh=FKWCa7KvkqcFm/L3Gue8UPFLyQnFbaSJbPinN6lpzBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Juw683owuZUqtLivln38qINdqsCrTx7P9OpN7lUe+scl4SEFq99fCdG4ZPp1tHtT6yJwMxb/4TqMXo26pe4UPfRgGuf+l7BpYG6vgpaCVCxrGPZBGxJTIn4QER0zDXyH2d3opL/snVzHTkU3DwcMsCuZvMy+CoqR4l6KTnGVSuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ixI1woUG; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TT+M/HNYlJSQX27HOtuYm2otltrl3F+s0X9BiZbUIzc=;
	b=ixI1woUGB7ctC3EgDtiIAVXDQtMwKnAm6gqjEcu7Ioth6mixa7zzjeYU4cmcrR0mR18bNy8h5
	5nViuN/Xfbli6I4fMQTda7HIJzjMdDsiCUSXnOVb/xk+/dR+/rXDufXhWuvtusN+MT0rkLw8hMj
	lKjtF9p/nZ4Uip8uiGMHUyY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fVJtY2xXbzmV8y;
	Tue, 10 Mar 2026 11:16:05 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id E197640565;
	Tue, 10 Mar 2026 11:21:00 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 11:20:59 +0800
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
 L <sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, Chengwen
 Feng <fengchengwen@huawei.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>, Yanteng Si
	<si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>, Kai Huang
	<kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Huth
	<thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>, Kevin Loughlin
	<kevinloughlin@google.com>, Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin
 Li <xin@zytor.com>, "Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta
	<sohil.mehta@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Robin
 Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>, Besar
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>, Wei Huang <wei.huang2@amd.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
	<linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v5 2/2] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
Date: Tue, 10 Mar 2026 11:20:49 +0800
Message-ID: <20260310032049.25387-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260310032049.25387-1-fengchengwen@huawei.com>
References: <20260310032049.25387-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 202C3244C01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223746-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[61];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,pcisig.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

pcie_tph_get_cpu_st() is broken on ARM64:
1. pcie_tph_get_cpu_st() passes cpu_uid to the PCI ACPI DSM method.
   cpu_uid should be the ACPI Processor UID [1].
2. In BNXT, pcie_tph_get_cpu_st() is passed a cpu_uid obtained via
   cpumask_first(irq->cpu_mask) - the logical CPU ID of a CPU core,
   generated and managed by kernel (e.g., [0,255] for a system  with 256
   logical CPU cores).
3. On ARM64 platforms, ACPI assigns Processor UID to cores listed in the
   MADT table, and this UID may not match the kernel's logical CPU ID.
   When this occurs, the mismatch results in the wrong CPU steer-tag.
4. On AMD x86 the logical CPU ID is identical to the ACPI Processor UID
   so the mismatch is not seen.

Resolution:
1. Implement acpi_get_cpu_acpi_id() for x86, which replaces
   cpu_acpi_id(). All ACPI platforms now have an implementation.
2. Use acpi_get_cpu_acpi_id() in pcie_tph_get_cpu_st() to translate from
   logical CPU ID to ACPI Processor UID needed for the DSM call.
3. Rename pcie_tpu_get_cpu_st() parameter from cpu_uid to cpu to
   reflect that it is a logical CPU_ID.

[1] According to ECN_TPH-ST_Revision_20200924
    (https://members.pcisig.com/wg/PCI-SIG/document/15470), the input
    is defined as: "If the target is a processor, then this field
    represents the ACPI Processor UID of the processor as specified in
    the MADT. If the target is a processor container, then this field
    represents the ACPI Processor UID of the processor container as
    specified in the PPTT."

Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 Documentation/PCI/tph.rst    |  4 ++--
 arch/x86/include/asm/acpi.h  |  2 ++
 arch/x86/include/asm/cpu.h   |  1 -
 arch/x86/include/asm/smp.h   |  1 -
 arch/x86/kernel/cpu/common.c | 12 ++++++++++++
 arch/x86/xen/enlighten_hvm.c |  4 ++--
 drivers/pci/tph.c            | 11 ++++++-----
 include/linux/pci-tph.h      |  4 ++--
 8 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
index e8993be64fd6..b6cf22b9bd90 100644
--- a/Documentation/PCI/tph.rst
+++ b/Documentation/PCI/tph.rst
@@ -79,10 +79,10 @@ To retrieve a Steering Tag for a target memory associated with a specific
 CPU, use the following function::
 
   int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type type,
-                          unsigned int cpu_uid, u16 *tag);
+                          unsigned int cpu, u16 *tag);
 
 The `type` argument is used to specify the memory type, either volatile
-or persistent, of the target memory. The `cpu_uid` argument specifies the
+or persistent, of the target memory. The `cpu` argument specifies the
 CPU where the memory is associated to.
 
 After the ST value is retrieved, the device driver can use the following
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index a03aa6f999d1..b968369715c1 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -157,6 +157,8 @@ static inline bool acpi_has_cpu_in_madt(void)
 	return !!acpi_lapic;
 }
 
+u32 acpi_get_cpu_acpi_id(unsigned int cpu);
+
 #define ACPI_HAVE_ARCH_SET_ROOT_POINTER
 static __always_inline void acpi_arch_set_root_pointer(u64 addr)
 {
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index ad235dda1ded..57a0786dfd75 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -11,7 +11,6 @@
 
 #ifndef CONFIG_SMP
 #define cpu_physical_id(cpu)			boot_cpu_physical_apicid
-#define cpu_acpi_id(cpu)			0
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 84951572ab81..05d1d479b4cf 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -130,7 +130,6 @@ __visible void smp_call_function_interrupt(struct pt_regs *regs);
 __visible void smp_call_function_single_interrupt(struct pt_regs *r);
 
 #define cpu_physical_id(cpu)	per_cpu(x86_cpu_to_apicid, cpu)
-#define cpu_acpi_id(cpu)	per_cpu(x86_cpu_to_acpiid, cpu)
 
 /*
  * This function is needed by all SMP systems. It must _always_ be valid
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261cae40c..93f4f3283c81 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -29,6 +29,7 @@
 #include <linux/utsname.h>
 #include <linux/efi.h>
 
+#include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
 #include <asm/cpuid/api.h>
@@ -57,6 +58,7 @@
 #include <asm/asm.h>
 #include <asm/bugs.h>
 #include <asm/cpu.h>
+#include <asm/smp.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/cacheinfo.h>
@@ -2643,3 +2645,13 @@ void __init arch_cpu_finalize_init(void)
 	 */
 	mem_encrypt_init();
 }
+
+u32 acpi_get_cpu_acpi_id(unsigned int cpu)
+{
+#ifndef CONFIG_SMP
+	return 0;
+#else
+	return per_cpu(x86_cpu_to_acpiid, cpu);
+#endif
+}
+EXPORT_SYMBOL_GPL(acpi_get_cpu_acpi_id);
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index fe57ff85d004..0a5cde7865b2 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -161,8 +161,8 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 	 */
 	xen_uninit_lock_cpu(cpu);
 
-	if (cpu_acpi_id(cpu) != CPU_ACPIID_INVALID)
-		per_cpu(xen_vcpu_id, cpu) = cpu_acpi_id(cpu);
+	if (acpi_get_cpu_acpi_id(cpu) != CPU_ACPIID_INVALID)
+		per_cpu(xen_vcpu_id, cpu) = acpi_get_cpu_acpi_id(cpu);
 	else
 		per_cpu(xen_vcpu_id, cpu) = cpu;
 	xen_vcpu_setup(cpu);
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index ca4f97be7538..c1bd60637b5a 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -236,18 +236,19 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
  * with a specific CPU
  * @pdev: PCI device
  * @mem_type: target memory type (volatile or persistent RAM)
- * @cpu_uid: associated CPU id
+ * @cpu: associated CPU id
  * @tag: Steering Tag to be returned
  *
  * Return the Steering Tag for a target memory that is associated with a
- * specific CPU as indicated by cpu_uid.
+ * specific CPU as indicated by cpu.
  *
  * Return: 0 if success, otherwise negative value (-errno)
  */
 int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
-			unsigned int cpu_uid, u16 *tag)
+			unsigned int cpu, u16 *tag)
 {
 #ifdef CONFIG_ACPI
+	u32 cpu_uid = acpi_get_cpu_acpi_id(cpu);
 	struct pci_dev *rp;
 	acpi_handle rp_acpi_handle;
 	union st_info info;
@@ -265,9 +266,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
 
 	*tag = tph_extract_tag(mem_type, pdev->tph_req_type, &info);
 
-	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu_uid=%d, tag=%#04x\n",
+	pci_dbg(pdev, "get steering tag: mem_type=%s, cpu=%d, tag=%#04x\n",
 		(mem_type == TPH_MEM_TYPE_VM) ? "volatile" : "persistent",
-		cpu_uid, *tag);
+		cpu, *tag);
 
 	return 0;
 #else
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index ba28140ce670..be68cd17f2f8 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -25,7 +25,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
 int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			enum tph_mem_type mem_type,
-			unsigned int cpu_uid, u16 *tag);
+			unsigned int cpu, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
@@ -36,7 +36,7 @@ static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 { return -EINVAL; }
 static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
 				      enum tph_mem_type mem_type,
-				      unsigned int cpu_uid, u16 *tag)
+				      unsigned int cpu, u16 *tag)
 { return -EINVAL; }
 static inline void pcie_disable_tph(struct pci_dev *pdev) { }
 static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
-- 
2.17.1


