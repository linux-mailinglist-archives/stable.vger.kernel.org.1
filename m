Return-Path: <stable+bounces-88436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4FD9B25FB
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711DF1F212CB
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5973D18FC80;
	Mon, 28 Oct 2024 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L39Bja6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744E18DF68;
	Mon, 28 Oct 2024 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097328; cv=none; b=Ohgc3jDSqPX5JRAmjgx2Rb8h+TXayfH2ileS3iSJGuwFgak9fs/jPJ4eyvXezC8St51PJpS1bHwWXw9JuiucDxvc7U2GZpHcSosccmujW/lvImKC1rj0TRqoMdAHlD1Y/G9qQqmhW2JgLSYR1RtRV/ueX9Cc6dTj557ap5iAqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097328; c=relaxed/simple;
	bh=W/6yL0fLRQ5nEZxES9bonZfFbACvY1tPS77roY2YKjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrVmBtewSC626QbO/8is6tUZHYju9qLn1VZH33O08l6Rg2AOUrFYQkYTvIUCyqEYTvKnfr82B0wGZhcloSMevCqnOe2gEqLy4kmi9EA60Lu+KgTzByIn7byOZd9KO9oN20zvLMPVxWDTO4iqjluDsvlj8e3rVGZH+rYoPzbYNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L39Bja6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA594C4CEC3;
	Mon, 28 Oct 2024 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097328;
	bh=W/6yL0fLRQ5nEZxES9bonZfFbACvY1tPS77roY2YKjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L39Bja6BvWY8OQxxo6W8pHYWgbO0OQQ3p5J10oEobecmV12GFFUT19B0ieJHG3PS2
	 iN5jTW8mV4Hoy2vZ3Wx8TZUWNFSkC1LR6GwBgMOapj1iEiHUfmRuWdMI1yd7jmY/KC
	 xK8zeBlgumzfDYswynXaXSMkMal7KKslDlfmlZb8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 082/137] LoongArch: Add support to clone a time namespace
Date: Mon, 28 Oct 2024 07:25:19 +0100
Message-ID: <20241028062301.026740824@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit aa5e65dc0818bbf676bf06927368ec46867778fd ]

We can see that "Time namespaces are not supported" on LoongArch:

(1) clone3 test
  # cd tools/testing/selftests/clone3 && make && ./clone3
  ...
  # Time namespaces are not supported
  ok 18 # SKIP Skipping clone3() with CLONE_NEWTIME
  # Totals: pass:17 fail:0 xfail:0 xpass:0 skip:1 error:0

(2) timens test
  # cd tools/testing/selftests/timens && make && ./timens
  ...
  1..0 # SKIP Time namespaces are not supported

On LoongArch the current kernel does not support CONFIG_TIME_NS which
depends on GENERIC_VDSO_TIME_NS, select GENERIC_VDSO_TIME_NS to enable
CONFIG_TIME_NS to build kernel/time/namespace.c.

Additionally, it needs to define some arch-dependent functions for the
timens, such as __arch_get_timens_vdso_data(), arch_get_vdso_data() and
vdso_join_timens().

At the same time, modify the layout of vvar to use one page size for
generic vdso data, expand another page size for timens vdso data and
assign LOONGARCH_VDSO_DATA_SIZE (maybe exceeds a page size if expand in
the future) for loongarch vdso data, at last add the callback function
vvar_fault() and modify stack_top().

With this patch under CONFIG_TIME_NS:

(1) clone3 test
  # cd tools/testing/selftests/clone3 && make && ./clone3
  ...
  ok 18 [739] Result (0) matches expectation (0)
  # Totals: pass:18 fail:0 xfail:0 xpass:0 skip:0 error:0

(2) timens test
  # cd tools/testing/selftests/timens && make && ./timens
  ...
  # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Stable-dep-of: 134475a9ab84 ("LoongArch: Don't crash in stack_top() for tasks without vDSO")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/include/asm/page.h             |  1 +
 .../loongarch/include/asm/vdso/gettimeofday.h |  9 +-
 arch/loongarch/include/asm/vdso/vdso.h        | 32 +++++-
 arch/loongarch/kernel/process.c               |  2 +-
 arch/loongarch/kernel/vdso.c                  | 98 ++++++++++++++++---
 arch/loongarch/vdso/vgetcpu.c                 |  2 +-
 7 files changed, 121 insertions(+), 24 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index fa3171f563274..f4ba3638b76a8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -78,6 +78,7 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index 53f284a961823..bbac81dd73788 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -81,6 +81,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
 
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+#define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
 #ifdef CONFIG_FLATMEM
 
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
index 7b2cd37641e2a..89e6b222c2f2d 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -91,9 +91,16 @@ static inline bool loongarch_vdso_hres_capable(void)
 
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return get_vdso_data();
+	return (const struct vdso_data *)get_vdso_data();
 }
 
+#ifdef CONFIG_TIME_NS
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
+{
+	return (const struct vdso_data *)(get_vdso_data() + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE);
+}
+#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
index 3b55d32a0619c..5a12309d9fb55 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -16,10 +16,33 @@ struct vdso_pcpu_data {
 
 struct loongarch_vdso_data {
 	struct vdso_pcpu_data pdata[NR_CPUS];
-	struct vdso_data data[CS_BASES]; /* Arch-independent data */
 };
 
-#define VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct loongarch_vdso_data))
+/*
+ * The layout of vvar:
+ *
+ *                      high
+ * +---------------------+--------------------------+
+ * | loongarch vdso data | LOONGARCH_VDSO_DATA_SIZE |
+ * +---------------------+--------------------------+
+ * |  time-ns vdso data  |        PAGE_SIZE         |
+ * +---------------------+--------------------------+
+ * |  generic vdso data  |        PAGE_SIZE         |
+ * +---------------------+--------------------------+
+ *                      low
+ */
+#define LOONGARCH_VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct loongarch_vdso_data))
+#define LOONGARCH_VDSO_DATA_PAGES (LOONGARCH_VDSO_DATA_SIZE >> PAGE_SHIFT)
+
+enum vvar_pages {
+	VVAR_GENERIC_PAGE_OFFSET,
+	VVAR_TIMENS_PAGE_OFFSET,
+	VVAR_LOONGARCH_PAGES_START,
+	VVAR_LOONGARCH_PAGES_END = VVAR_LOONGARCH_PAGES_START + LOONGARCH_VDSO_DATA_PAGES - 1,
+	VVAR_NR_PAGES,
+};
+
+#define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
 
 static inline unsigned long get_vdso_base(void)
 {
@@ -34,10 +57,9 @@ static inline unsigned long get_vdso_base(void)
 	return addr;
 }
 
-static inline const struct vdso_data *get_vdso_data(void)
+static inline unsigned long get_vdso_data(void)
 {
-	return (const struct vdso_data *)(get_vdso_base()
-			- VDSO_DATA_SIZE + SMP_CACHE_BYTES * NR_CPUS);
+	return get_vdso_base() - VVAR_SIZE;
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 1259bc3129790..51176e5ecee59 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -273,7 +273,7 @@ unsigned long stack_top(void)
 
 	/* Space for the VDSO & data page */
 	top -= PAGE_ALIGN(current->thread.vdso->size);
-	top -= PAGE_SIZE;
+	top -= VVAR_SIZE;
 
 	/* Space to randomize the VDSO base */
 	if (current->flags & PF_RANDOMIZE)
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 8c9826062652e..59aa9dd466e84 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/time_namespace.h>
 #include <linux/timekeeper_internal.h>
 
 #include <asm/page.h>
@@ -26,12 +27,17 @@ extern char vdso_start[], vdso_end[];
 
 /* Kernel-provided data used by the VDSO. */
 static union {
-	u8 page[VDSO_DATA_SIZE];
+	u8 page[PAGE_SIZE];
+	struct vdso_data data[CS_BASES];
+} generic_vdso_data __page_aligned_data;
+
+static union {
+	u8 page[LOONGARCH_VDSO_DATA_SIZE];
 	struct loongarch_vdso_data vdata;
 } loongarch_vdso_data __page_aligned_data;
 
 static struct page *vdso_pages[] = { NULL };
-struct vdso_data *vdso_data = loongarch_vdso_data.vdata.data;
+struct vdso_data *vdso_data = generic_vdso_data.data;
 struct vdso_pcpu_data *vdso_pdata = loongarch_vdso_data.vdata.pdata;
 
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
@@ -41,6 +47,43 @@ static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struc
 	return 0;
 }
 
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
+			     struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	unsigned long pfn;
+	struct page *timens_page = find_timens_vvar_page(vma);
+
+	switch (vmf->pgoff) {
+	case VVAR_GENERIC_PAGE_OFFSET:
+		if (!timens_page)
+			pfn = sym_to_pfn(vdso_data);
+		else
+			pfn = page_to_pfn(timens_page);
+		break;
+#ifdef CONFIG_TIME_NS
+	case VVAR_TIMENS_PAGE_OFFSET:
+		/*
+		 * If a task belongs to a time namespace then a namespace specific
+		 * VVAR is mapped with the VVAR_GENERIC_PAGE_OFFSET and the real
+		 * VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (!timens_page)
+			return VM_FAULT_SIGBUS;
+		else
+			pfn = sym_to_pfn(vdso_data);
+		break;
+#endif /* CONFIG_TIME_NS */
+	case VVAR_LOONGARCH_PAGES_START ... VVAR_LOONGARCH_PAGES_END:
+		pfn = sym_to_pfn(&loongarch_vdso_data) + vmf->pgoff - VVAR_LOONGARCH_PAGES_START;
+		break;
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
+}
+
 struct loongarch_vdso_info vdso_info = {
 	.vdso = vdso_start,
 	.size = PAGE_SIZE,
@@ -51,6 +94,7 @@ struct loongarch_vdso_info vdso_info = {
 	},
 	.data_mapping = {
 		.name = "[vvar]",
+		.fault = vvar_fault,
 	},
 	.offset_sigreturn = vdso_offset_sigreturn,
 };
@@ -73,6 +117,37 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_TIME_NS
+struct vdso_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_data *)(vvar_page);
+}
+
+/*
+ * The vvar mapping contains data for a specific time namespace, so when a
+ * task changes namespace we must unmap its vvar data for the old namespace.
+ * Subsequent faults will map in data for the new namespace.
+ *
+ * For more details see timens_setup_vdso_data().
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	VMA_ITERATOR(vmi, mm, 0);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma_is_special_mapping(vma, &vdso_info.data_mapping))
+			zap_vma_pages(vma);
+	}
+	mmap_read_unlock(mm);
+
+	return 0;
+}
+#endif
+
 static unsigned long vdso_base(void)
 {
 	unsigned long base = STACK_TOP;
@@ -88,7 +163,7 @@ static unsigned long vdso_base(void)
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	int ret;
-	unsigned long vvar_size, size, data_addr, vdso_addr;
+	unsigned long size, data_addr, vdso_addr;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct loongarch_vdso_info *info = current->thread.vdso;
@@ -100,32 +175,23 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 * Determine total area size. This includes the VDSO data itself
 	 * and the data pages.
 	 */
-	vvar_size = VDSO_DATA_SIZE;
-	size = vvar_size + info->size;
+	size = VVAR_SIZE + info->size;
 
 	data_addr = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
 	if (IS_ERR_VALUE(data_addr)) {
 		ret = data_addr;
 		goto out;
 	}
-	vdso_addr = data_addr + VDSO_DATA_SIZE;
 
-	vma = _install_special_mapping(mm, data_addr, vvar_size,
-				       VM_READ | VM_MAYREAD,
+	vma = _install_special_mapping(mm, data_addr, VVAR_SIZE,
+				       VM_READ | VM_MAYREAD | VM_PFNMAP,
 				       &info->data_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
 	}
 
-	/* Map VDSO data page. */
-	ret = remap_pfn_range(vma, data_addr,
-			      virt_to_phys(&loongarch_vdso_data) >> PAGE_SHIFT,
-			      vvar_size, PAGE_READONLY);
-	if (ret)
-		goto out;
-
-	/* Map VDSO code page. */
+	vdso_addr = data_addr + VVAR_SIZE;
 	vma = _install_special_mapping(mm, vdso_addr, info->size,
 				       VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
 				       &info->code_mapping);
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index e02e775f53608..9e445be39763a 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -21,7 +21,7 @@ static __always_inline int read_cpu_id(void)
 
 static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
 {
-	return (struct vdso_pcpu_data *)(get_vdso_base() - VDSO_DATA_SIZE);
+	return (struct vdso_pcpu_data *)(get_vdso_data() + VVAR_LOONGARCH_PAGES_START * PAGE_SIZE);
 }
 
 extern
-- 
2.43.0




