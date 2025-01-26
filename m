Return-Path: <stable+bounces-110766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD3A1CC8B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638933A4408
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DFC1F940B;
	Sun, 26 Jan 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1I+fK7S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E9D18C034;
	Sun, 26 Jan 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904122; cv=none; b=egIsPooMgKPUba7awbsTCgK3WfDlKAaxcjTxTfAAs24/PhqxnKqkl9Xr5tz7RBP4YVuAhZ4pkQ9QWJNa2+FPhBfwpLINt5vqj/j9BRFuZ9YAFPjRmYdZxE49dFCAUCB6zNXEY63CVLIGAk5GynFH/p3ZN7AnNLkKVEGfpjVW+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904122; c=relaxed/simple;
	bh=PPZjovQTI3gvY5YeF+kJwOLNsWm0YgE+R7WV0iHGE4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B8hfn3y6xMXAqb7KT7jaenTpW/TUpetwdkzALcHaIQztVOHqfXSRXWdjrNfJf975+s/XekpsJfXDHx2XZI3jVcmHFNmoPSumOL96x36dqnup1dFReCfsaWKH9YbqgwFIz6BHDJlTxoAy1xuaI19epIS1Ml3gzzJinrkxKYB0RWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1I+fK7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0C4C4CED3;
	Sun, 26 Jan 2025 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904122;
	bh=PPZjovQTI3gvY5YeF+kJwOLNsWm0YgE+R7WV0iHGE4M=;
	h=From:To:Cc:Subject:Date:From;
	b=V1I+fK7SUOlAwC7H4ZH99gtwJNKUDSQwrXw5itjKwlColp3N3H280CGuL4s1kqtH2
	 YyV/PV8OpZPfq5c4bzjUbvvrr6keIEQ3cM6Jxnb7ogD4cxVGMyS+yq4vfqjaR4W3rW
	 x+cLA5r+zEl+p8oLcMihhUBjf6nQL4kRvDEOlOIIPJUzg39ipY1mE17sB5hjEfoS3w
	 BDTZL7MRujSEzMuea6ffEmo/CUDGIAEO1A/sHn4AnQZh6EQrC92FLuVtSpc26oIyqM
	 LeakK4nsPtOQwMw6GjnZmTxVnRNQmDMntNuHPw76tQdLepSkCN0PVjrdCVPqsiuaeE
	 LufKHLSrcVhWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Woodhouse <dwmw@amazon.co.uk>,
	Ingo Molnar <mingo@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hbathini@linux.ibm.com,
	sourabhjain@linux.ibm.com,
	tzimmermann@suse.de,
	steve.wahl@hpe.com,
	david.kaplan@amd.com,
	ltao@redhat.com
Subject: [PATCH AUTOSEL 6.6 1/9] x86/kexec: Allocate PGD for x86_64 transition page tables separately
Date: Sun, 26 Jan 2025 10:08:29 -0500
Message-Id: <20250126150839.962669-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: David Woodhouse <dwmw@amazon.co.uk>

[ Upstream commit 4b5bc2ec9a239bce261ffeafdd63571134102323 ]

Now that the following fix:

  d0ceea662d45 ("x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables")

stops kernel_ident_mapping_init() from scribbling over the end of a
4KiB PGD by assuming the following 4KiB will be a userspace PGD,
there's no good reason for the kexec PGD to be part of a single
8KiB allocation with the control_code_page.

( It's not clear that that was the reason for x86_64 kexec doing it that
  way in the first place either; there were no comments to that effect and
  it seems to have been the case even before PTI came along. It looks like
  it was just a happy accident which prevented memory corruption on kexec. )

Either way, it definitely isn't needed now. Just allocate the PGD
separately on x86_64, like i386 already does.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205153343.3275139-6-dwmw2@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kexec.h       | 18 +++++++++---
 arch/x86/kernel/machine_kexec_64.c | 45 ++++++++++++++++--------------
 2 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index c9f6a6c5de3cf..d54dd7084a3e1 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -16,6 +16,7 @@
 # define PAGES_NR		4
 #endif
 
+# define KEXEC_CONTROL_PAGE_SIZE	4096
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
 #ifndef __ASSEMBLY__
@@ -44,7 +45,6 @@ struct kimage;
 /* Maximum address we can use for the control code buffer */
 # define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
 
-# define KEXEC_CONTROL_PAGE_SIZE	4096
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_386
@@ -59,9 +59,6 @@ struct kimage;
 /* Maximum address we can use for the control pages */
 # define KEXEC_CONTROL_MEMORY_LIMIT     (MAXMEM-1)
 
-/* Allocate one page for the pdp and the second for the code */
-# define KEXEC_CONTROL_PAGE_SIZE  (4096UL + 4096UL)
-
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
 #endif
@@ -146,6 +143,19 @@ struct kimage_arch {
 };
 #else
 struct kimage_arch {
+	/*
+	 * This is a kimage control page, as it must not overlap with either
+	 * source or destination address ranges.
+	 */
+	pgd_t *pgd;
+	/*
+	 * The virtual mapping of the control code page itself is used only
+	 * during the transition, while the current kernel's pages are all
+	 * in place. Thus the intermediate page table pages used to map it
+	 * are not control pages, but instead just normal pages obtained
+	 * with get_zeroed_page(). And have to be tracked (below) so that
+	 * they can be freed.
+	 */
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 2fa12d1dc6760..8509d809a9f1b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -149,7 +149,8 @@ static void free_transition_pgtable(struct kimage *image)
 	image->arch.pte = NULL;
 }
 
-static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
+static int init_transition_pgtable(struct kimage *image, pgd_t *pgd,
+				   unsigned long control_page)
 {
 	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
 	unsigned long vaddr, paddr;
@@ -160,7 +161,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	pte_t *pte;
 
 	vaddr = (unsigned long)relocate_kernel;
-	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
+	paddr = control_page;
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
 		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
@@ -219,7 +220,7 @@ static void *alloc_pgt_page(void *data)
 	return p;
 }
 
-static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
+static int init_pgtable(struct kimage *image, unsigned long control_page)
 {
 	struct x86_mapping_info info = {
 		.alloc_pgt_page	= alloc_pgt_page,
@@ -228,12 +229,12 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		.kernpg_flag	= _KERNPG_TABLE_NOENC,
 	};
 	unsigned long mstart, mend;
-	pgd_t *level4p;
 	int result;
 	int i;
 
-	level4p = (pgd_t *)__va(start_pgtable);
-	clear_page(level4p);
+	image->arch.pgd = alloc_pgt_page(image);
+	if (!image->arch.pgd)
+		return -ENOMEM;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		info.page_flag   |= _PAGE_ENC;
@@ -247,8 +248,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
 
-		result = kernel_ident_mapping_init(&info,
-						 level4p, mstart, mend);
+		result = kernel_ident_mapping_init(&info, image->arch.pgd,
+						   mstart, mend);
 		if (result)
 			return result;
 	}
@@ -263,8 +264,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 		mstart = image->segment[i].mem;
 		mend   = mstart + image->segment[i].memsz;
 
-		result = kernel_ident_mapping_init(&info,
-						 level4p, mstart, mend);
+		result = kernel_ident_mapping_init(&info, image->arch.pgd,
+						   mstart, mend);
 
 		if (result)
 			return result;
@@ -274,15 +275,19 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
 	 * not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, level4p);
+	result = map_efi_systab(&info, image->arch.pgd);
 	if (result)
 		return result;
 
-	result = map_acpi_tables(&info, level4p);
+	result = map_acpi_tables(&info, image->arch.pgd);
 	if (result)
 		return result;
 
-	return init_transition_pgtable(image, level4p);
+	/*
+	 * This must be last because the intermediate page table pages it
+	 * allocates will not be control pages and may overlap the image.
+	 */
+	return init_transition_pgtable(image, image->arch.pgd, control_page);
 }
 
 static void load_segments(void)
@@ -299,14 +304,14 @@ static void load_segments(void)
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long start_pgtable;
+	unsigned long control_page;
 	int result;
 
 	/* Calculate the offsets */
-	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	control_page = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 
 	/* Setup the identity mapped 64bit page table */
-	result = init_pgtable(image, start_pgtable);
+	result = init_pgtable(image, control_page);
 	if (result)
 		return result;
 
@@ -360,13 +365,12 @@ void machine_kexec(struct kimage *image)
 #endif
 	}
 
-	control_page = page_address(image->control_code_page) + PAGE_SIZE;
+	control_page = page_address(image->control_code_page);
 	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-	page_list[PA_TABLE_PAGE] =
-	  (unsigned long)__pa(page_address(image->control_code_page));
+	page_list[PA_TABLE_PAGE] = (unsigned long)__pa(image->arch.pgd);
 
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
@@ -574,8 +578,7 @@ static void kexec_mark_crashkres(bool protect)
 
 	/* Don't touch the control code page used in crash_kexec().*/
 	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
-	/* Control code page is located in the 2nd page. */
-	kexec_mark_range(crashk_res.start, control + PAGE_SIZE - 1, protect);
+	kexec_mark_range(crashk_res.start, control - 1, protect);
 	control += KEXEC_CONTROL_PAGE_SIZE;
 	kexec_mark_range(control, crashk_res.end, protect);
 }
-- 
2.39.5


