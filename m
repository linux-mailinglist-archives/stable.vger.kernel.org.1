Return-Path: <stable+bounces-89547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707C9B9C89
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 04:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428AC1C2167F
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66049659;
	Sat,  2 Nov 2024 03:36:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F263C3C;
	Sat,  2 Nov 2024 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730518609; cv=none; b=UvK/Lmj+ETAzMEY1byX9oMfQk0S8BjBRGGM4CckRIwnQffbf1TXYi1KBL30eUYphjl6LyZDyWXYQsdp+NQjH+imaqdnJ1+dkh/9tUA4IjAlCgtR5kzPlOMdOn6PgoRHy09XBC9/k1y2vcs/xqU2QSNv0+OWn9cPhqIoD19JDFyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730518609; c=relaxed/simple;
	bh=z7J2UcHSJYJwMGO1ve6dJe4n/NLLb3+32f+ayIMNZxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abAAkketefJFHvSKU/j7Lak+NwXlO21yGHotYZA+2fzgj5JSRgRDV0UIqLjivWBjG2dquaMGqmw2gIWUnMOfSqaWQkvBFnZe0NhrooCN+ZWtIXr/Se1T3rEwgj8IZhTAdnuI1SkQr5dvOm3yqhzz+jK1CQKSFu/wetgb/fKz+ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74880C4CEC3;
	Sat,  2 Nov 2024 03:36:46 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1.y] LoongArch: Fix build errors due to backported TIMENS
Date: Sat,  2 Nov 2024 11:36:16 +0800
Message-ID: <20241102033616.3517188-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit eb3710efffce1dcff83761db4615f91d93aabfcb ("LoongArch: Add support
to clone a time namespace") backports the TIMENS support for LoongArch
(corresponding upstream commit aa5e65dc0818bbf676bf06927368ec46867778fd)
but causes build errors:

  CC      arch/loongarch/kernel/vdso.o
arch/loongarch/kernel/vdso.c: In function ‘vvar_fault’:
arch/loongarch/kernel/vdso.c:54:36: error: implicit declaration of
function ‘find_timens_vvar_page’ [-Werror=implicit-function-declaration]
   54 |         struct page *timens_page = find_timens_vvar_page(vma);
      |                                    ^~~~~~~~~~~~~~~~~~~~~
arch/loongarch/kernel/vdso.c:54:36: warning: initialization of ‘struct
page *’ from ‘int’ makes pointer from integer without a cast
[-Wint-conversion]
arch/loongarch/kernel/vdso.c: In function ‘vdso_join_timens’:
arch/loongarch/kernel/vdso.c:143:25: error: implicit declaration of
function ‘zap_vma_pages’; did you mean ‘zap_vma_ptes’?
[-Werror=implicit-function-declaration]
  143 |                         zap_vma_pages(vma);
      |                         ^~~~~~~~~~~~~
      |                         zap_vma_ptes
cc1: some warnings being treated as errors

Because in 6.1.y we should define find_timens_vvar_page() by ourselves
and use zap_page_range() instead of zap_vma_pages(), so fix it.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/vdso.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 59aa9dd466e8..64eb5386e7b2 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -40,6 +40,8 @@ static struct page *vdso_pages[] = { NULL };
 struct vdso_data *vdso_data = generic_vdso_data.data;
 struct vdso_pcpu_data *vdso_pdata = loongarch_vdso_data.vdata.pdata;
 
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma);
+
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)(new_vma->vm_start);
@@ -139,13 +141,37 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 
 	mmap_read_lock(mm);
 	for_each_vma(vmi, vma) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
 		if (vma_is_special_mapping(vma, &vdso_info.data_mapping))
-			zap_vma_pages(vma);
+			zap_page_range(vma, vma->vm_start, size);
 	}
 	mmap_read_unlock(mm);
 
 	return 0;
 }
+
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_mm == current->mm))
+		return current->nsproxy->time_ns->vvar_page;
+
+	/*
+	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
+	 * through interfaces like /proc/$pid/mem or
+	 * process_vm_{readv,writev}() as long as there's no .access()
+	 * in special_mapping_vmops.
+	 * For more details check_vma_flags() and __access_remote_vm()
+	 */
+	WARN(1, "vvar_page accessed remotely");
+
+	return NULL;
+}
+#else
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	return NULL;
+}
 #endif
 
 static unsigned long vdso_base(void)
-- 
2.43.5


