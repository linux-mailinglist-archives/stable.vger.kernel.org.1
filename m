Return-Path: <stable+bounces-142250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FECAAE9C6
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A664985DD2
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCA1202C2B;
	Wed,  7 May 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cnylGMm2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A81C84D7;
	Wed,  7 May 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643675; cv=none; b=d40vXoxAGkd8386zcW4Mvc1rn59BY5HYcTQtcS+r1PEASpG7O/3YMCQtF7rPiiLpk+ZYyEf4+BbgdYXhrNw7IPuYvpZDsucEeXVUpMWnEk6ZJuXjFUxYq8SeWzk6OVaLwgNeNBsE4b27i3mZNufkSnakzHgAgfb4rDQ0OqT2xU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643675; c=relaxed/simple;
	bh=62Z7ClMJG+mguJvzk5WK0qVFQkn/EUrPzh3fppBsf8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDePKXAZHGQSolWqc+lquyIPpQUu7DwrYuA3PSeaeNdzcRVXZU4F2e6vK4d/rXYQTm2ifLLHdu8sVbNtUDFD17heeDhu92eCZMVj6aZsEHX7v4QTXfXc+/hGSuqWCaVGU/c4KS2HzsUqu9a44nIQXIKO1HvIsdsvLEdR3Gl2cH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cnylGMm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022CAC4CEE2;
	Wed,  7 May 2025 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643675;
	bh=62Z7ClMJG+mguJvzk5WK0qVFQkn/EUrPzh3fppBsf8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnylGMm2a5cIbPADTrPuMwClsHr3ViQE0fIcDz1PgFmtk7XjeWZgaDTjQKejL8Mgw
	 XPYUTmNBhVqWeR8FwScN/RJx6iMuCUHU3l+zLahpbnMoVkfCAF3o7Y/ECJbXuMih0i
	 uuOdZM+IyvVuY1dzUl4hFkOhBjqYI9mJGuqwuC2k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Hagberg <ehagberg@janestreet.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Ingo Molnar <mingo@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 79/97] Revert "x86/kexec: Allocate PGD for x86_64 transition page tables separately"
Date: Wed,  7 May 2025 20:39:54 +0200
Message-ID: <20250507183810.160807716@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183806.987408728@linuxfoundation.org>
References: <20250507183806.987408728@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 6821918f451942aa79759f29677a22f2d4ff4cbe which is
commit 4b5bc2ec9a239bce261ffeafdd63571134102323 upstream.

The patch it relies on is not in the 6.1.y tree, and has been reported
to cause problems, so let's revert it for now.

Reported-by: Eric Hagberg <ehagberg@janestreet.com>
Link: https://lore.kernel.org/r/CAAH4uRBxJ_XvYjCpgYXHqrKSNj6x9pA7X6NBPNTekeQ90DQSJA@mail.gmail.com
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kexec.h       |   18 +++-----------
 arch/x86/kernel/machine_kexec_64.c |   45 +++++++++++++++++--------------------
 2 files changed, 25 insertions(+), 38 deletions(-)

--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -16,7 +16,6 @@
 # define PAGES_NR		4
 #endif
 
-# define KEXEC_CONTROL_PAGE_SIZE	4096
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
 #ifndef __ASSEMBLY__
@@ -45,6 +44,7 @@ struct kimage;
 /* Maximum address we can use for the control code buffer */
 # define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
 
+# define KEXEC_CONTROL_PAGE_SIZE	4096
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_386
@@ -59,6 +59,9 @@ struct kimage;
 /* Maximum address we can use for the control pages */
 # define KEXEC_CONTROL_MEMORY_LIMIT     (MAXMEM-1)
 
+/* Allocate one page for the pdp and the second for the code */
+# define KEXEC_CONTROL_PAGE_SIZE  (4096UL + 4096UL)
+
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
 #endif
@@ -143,19 +146,6 @@ struct kimage_arch {
 };
 #else
 struct kimage_arch {
-	/*
-	 * This is a kimage control page, as it must not overlap with either
-	 * source or destination address ranges.
-	 */
-	pgd_t *pgd;
-	/*
-	 * The virtual mapping of the control code page itself is used only
-	 * during the transition, while the current kernel's pages are all
-	 * in place. Thus the intermediate page table pages used to map it
-	 * are not control pages, but instead just normal pages obtained
-	 * with get_zeroed_page(). And have to be tracked (below) so that
-	 * they can be freed.
-	 */
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -149,8 +149,7 @@ static void free_transition_pgtable(stru
 	image->arch.pte = NULL;
 }
 
-static int init_transition_pgtable(struct kimage *image, pgd_t *pgd,
-				   unsigned long control_page)
+static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 {
 	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
 	unsigned long vaddr, paddr;
@@ -161,7 +160,7 @@ static int init_transition_pgtable(struc
 	pte_t *pte;
 
 	vaddr = (unsigned long)relocate_kernel;
-	paddr = control_page;
+	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
 		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
@@ -220,7 +219,7 @@ static void *alloc_pgt_page(void *data)
 	return p;
 }
 
-static int init_pgtable(struct kimage *image, unsigned long control_page)
+static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 {
 	struct x86_mapping_info info = {
 		.alloc_pgt_page	= alloc_pgt_page,
@@ -229,12 +228,12 @@ static int init_pgtable(struct kimage *i
 		.kernpg_flag	= _KERNPG_TABLE_NOENC,
 	};
 	unsigned long mstart, mend;
+	pgd_t *level4p;
 	int result;
 	int i;
 
-	image->arch.pgd = alloc_pgt_page(image);
-	if (!image->arch.pgd)
-		return -ENOMEM;
+	level4p = (pgd_t *)__va(start_pgtable);
+	clear_page(level4p);
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		info.page_flag   |= _PAGE_ENC;
@@ -248,8 +247,8 @@ static int init_pgtable(struct kimage *i
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
 
-		result = kernel_ident_mapping_init(&info, image->arch.pgd,
-						   mstart, mend);
+		result = kernel_ident_mapping_init(&info,
+						 level4p, mstart, mend);
 		if (result)
 			return result;
 	}
@@ -264,8 +263,8 @@ static int init_pgtable(struct kimage *i
 		mstart = image->segment[i].mem;
 		mend   = mstart + image->segment[i].memsz;
 
-		result = kernel_ident_mapping_init(&info, image->arch.pgd,
-						   mstart, mend);
+		result = kernel_ident_mapping_init(&info,
+						 level4p, mstart, mend);
 
 		if (result)
 			return result;
@@ -275,19 +274,15 @@ static int init_pgtable(struct kimage *i
 	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
 	 * not covered by pfn_mapped.
 	 */
-	result = map_efi_systab(&info, image->arch.pgd);
+	result = map_efi_systab(&info, level4p);
 	if (result)
 		return result;
 
-	result = map_acpi_tables(&info, image->arch.pgd);
+	result = map_acpi_tables(&info, level4p);
 	if (result)
 		return result;
 
-	/*
-	 * This must be last because the intermediate page table pages it
-	 * allocates will not be control pages and may overlap the image.
-	 */
-	return init_transition_pgtable(image, image->arch.pgd, control_page);
+	return init_transition_pgtable(image, level4p);
 }
 
 static void load_segments(void)
@@ -304,14 +299,14 @@ static void load_segments(void)
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long control_page;
+	unsigned long start_pgtable;
 	int result;
 
 	/* Calculate the offsets */
-	control_page = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 
 	/* Setup the identity mapped 64bit page table */
-	result = init_pgtable(image, control_page);
+	result = init_pgtable(image, start_pgtable);
 	if (result)
 		return result;
 
@@ -358,12 +353,13 @@ void machine_kexec(struct kimage *image)
 #endif
 	}
 
-	control_page = page_address(image->control_code_page);
+	control_page = page_address(image->control_code_page) + PAGE_SIZE;
 	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-	page_list[PA_TABLE_PAGE] = (unsigned long)__pa(image->arch.pgd);
+	page_list[PA_TABLE_PAGE] =
+	  (unsigned long)__pa(page_address(image->control_code_page));
 
 	if (image->type == KEXEC_TYPE_DEFAULT)
 		page_list[PA_SWAP_PAGE] = (page_to_pfn(image->swap_page)
@@ -582,7 +578,8 @@ static void kexec_mark_crashkres(bool pr
 
 	/* Don't touch the control code page used in crash_kexec().*/
 	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
-	kexec_mark_range(crashk_res.start, control - 1, protect);
+	/* Control code page is located in the 2nd page. */
+	kexec_mark_range(crashk_res.start, control + PAGE_SIZE - 1, protect);
 	control += KEXEC_CONTROL_PAGE_SIZE;
 	kexec_mark_range(control, crashk_res.end, protect);
 }



