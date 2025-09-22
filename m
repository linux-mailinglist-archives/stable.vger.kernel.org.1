Return-Path: <stable+bounces-181324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2811B93095
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178C61650BD
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56B22F291B;
	Mon, 22 Sep 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eaksCnbu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609462F0C5C;
	Mon, 22 Sep 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570254; cv=none; b=RLmOms95eiwE0B3uJhlv6PKJaWJN7zfelWiHWbGCyEcmjtmJhlmhozSSRhngVzDjXz8YkOW6BCzpkIxjVHlkQc2FcIVdSwDgRc/vuqFWIGxaq/qdIRIGvMcmCfK4Iz7avKysYfYBYsh5ruaRgmMPJRagDtgygw450RcC4rvMvpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570254; c=relaxed/simple;
	bh=/kn5cfA+gDwjgiImUxJWomrG0AElGgZV7+L7wsxTHRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPkHGUWRu4xpzGTCUir4KtjVERqvZdS33ftj87VvkCO5iAINsPNTz5O3YWw29JmxGecK+Vap3Lqo83oOnIdAV+4UIqndfj+BDh87h2obVvmZR5GYenSyTXVbYRW+D9gOUzZrnthaWWd4/tepKFdDB22DCg08UgdnuIoh65Wg9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eaksCnbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC840C4CEF0;
	Mon, 22 Sep 2025 19:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570254;
	bh=/kn5cfA+gDwjgiImUxJWomrG0AElGgZV7+L7wsxTHRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaksCnbuI3d1VH69ZoluSfc12nFawqyG3yqBp4fpouXtbTg8bi0qdyLUmeH0NqXQQ
	 Ovb9JC5Zqxx4B2q5ZAsjZmJKahrMxPCaXLwLhM/uPvongEi5T2ifi8FeOcL4ZIieDM
	 RLIIJtV6fpypHdn4hREXxOR4zOIY5++ecJX+QCu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.16 077/149] LoongArch: KVM: Fix VM migration failure with PTW enabled
Date: Mon, 22 Sep 2025 21:29:37 +0200
Message-ID: <20250922192414.827196616@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bibo Mao <maobibo@loongson.cn>

commit f58c9aa1065f73d243904b267c71f6a9d1e9f90e upstream.

With PTW disabled system, bit _PAGE_DIRTY is a HW bit for page writing.
However with PTW enabled system, bit _PAGE_WRITE is also a "HW bit" for
page writing, because hardware synchronizes _PAGE_WRITE to _PAGE_DIRTY
automatically. Previously, _PAGE_WRITE is treated as a SW bit to record
the page writeable attribute for the fast page fault handling in the
secondary MMU, however with PTW enabled machine, this bit is used by HW
already (so setting it will silence the TLB modify exception).

Here define KVM_PAGE_WRITEABLE with the SW bit _PAGE_MODIFIED, so that
it can work on both PTW disabled and enabled machines. And for HW write
bits, both _PAGE_DIRTY and _PAGE_WRITE are set or clear together.

Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/kvm_mmu.h |   20 ++++++++++++++++----
 arch/loongarch/kvm/mmu.c             |    8 ++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

--- a/arch/loongarch/include/asm/kvm_mmu.h
+++ b/arch/loongarch/include/asm/kvm_mmu.h
@@ -16,6 +16,13 @@
  */
 #define KVM_MMU_CACHE_MIN_PAGES	(CONFIG_PGTABLE_LEVELS - 1)
 
+/*
+ * _PAGE_MODIFIED is a SW pte bit, it records page ever written on host
+ * kernel, on secondary MMU it records the page writeable attribute, in
+ * order for fast path handling.
+ */
+#define KVM_PAGE_WRITEABLE	_PAGE_MODIFIED
+
 #define _KVM_FLUSH_PGTABLE	0x1
 #define _KVM_HAS_PGMASK		0x2
 #define kvm_pfn_pte(pfn, prot)	(((pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
@@ -52,10 +59,10 @@ static inline void kvm_set_pte(kvm_pte_t
 	WRITE_ONCE(*ptep, val);
 }
 
-static inline int kvm_pte_write(kvm_pte_t pte) { return pte & _PAGE_WRITE; }
-static inline int kvm_pte_dirty(kvm_pte_t pte) { return pte & _PAGE_DIRTY; }
 static inline int kvm_pte_young(kvm_pte_t pte) { return pte & _PAGE_ACCESSED; }
 static inline int kvm_pte_huge(kvm_pte_t pte) { return pte & _PAGE_HUGE; }
+static inline int kvm_pte_dirty(kvm_pte_t pte) { return pte & __WRITEABLE; }
+static inline int kvm_pte_writeable(kvm_pte_t pte) { return pte & KVM_PAGE_WRITEABLE; }
 
 static inline kvm_pte_t kvm_pte_mkyoung(kvm_pte_t pte)
 {
@@ -69,12 +76,12 @@ static inline kvm_pte_t kvm_pte_mkold(kv
 
 static inline kvm_pte_t kvm_pte_mkdirty(kvm_pte_t pte)
 {
-	return pte | _PAGE_DIRTY;
+	return pte | __WRITEABLE;
 }
 
 static inline kvm_pte_t kvm_pte_mkclean(kvm_pte_t pte)
 {
-	return pte & ~_PAGE_DIRTY;
+	return pte & ~__WRITEABLE;
 }
 
 static inline kvm_pte_t kvm_pte_mkhuge(kvm_pte_t pte)
@@ -87,6 +94,11 @@ static inline kvm_pte_t kvm_pte_mksmall(
 	return pte & ~_PAGE_HUGE;
 }
 
+static inline kvm_pte_t kvm_pte_mkwriteable(kvm_pte_t pte)
+{
+	return pte | KVM_PAGE_WRITEABLE;
+}
+
 static inline int kvm_need_flush(kvm_ptw_ctx *ctx)
 {
 	return ctx->flag & _KVM_FLUSH_PGTABLE;
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -569,7 +569,7 @@ static int kvm_map_page_fast(struct kvm_
 	/* Track access to pages marked old */
 	new = kvm_pte_mkyoung(*ptep);
 	if (write && !kvm_pte_dirty(new)) {
-		if (!kvm_pte_write(new)) {
+		if (!kvm_pte_writeable(new)) {
 			ret = -EFAULT;
 			goto out;
 		}
@@ -856,9 +856,9 @@ retry:
 		prot_bits |= _CACHE_SUC;
 
 	if (writeable) {
-		prot_bits |= _PAGE_WRITE;
+		prot_bits = kvm_pte_mkwriteable(prot_bits);
 		if (write)
-			prot_bits |= __WRITEABLE;
+			prot_bits = kvm_pte_mkdirty(prot_bits);
 	}
 
 	/* Disable dirty logging on HugePages */
@@ -904,7 +904,7 @@ retry:
 	kvm_release_faultin_page(kvm, page, false, writeable);
 	spin_unlock(&kvm->mmu_lock);
 
-	if (prot_bits & _PAGE_DIRTY)
+	if (kvm_pte_dirty(prot_bits))
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
 
 out:



