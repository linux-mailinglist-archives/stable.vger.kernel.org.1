Return-Path: <stable+bounces-196515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C527DC7AB3A
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 698304E242B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930392D8DAF;
	Fri, 21 Nov 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E6wX8z01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB22D1F64
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741062; cv=none; b=MvNwERxIYkWvhkS0rLup+sm8BaBwOe7Rly3vky4Wnw+nZoJ5ET3cTie6rcSL/SayB2XLXWkwtTPojMRVnEhqNcO4dLkQ9C65fdgxUWfEOhrWNFAfboIoFswBzRgDl9PRd+ANeYc2q9mc1wdUDihPZUnJ1Pg35QUhdo9BrU1vPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741062; c=relaxed/simple;
	bh=1AFIw0g5N17VidVJkGVfLzwOa+RMmAWZuX9Dthc5/nM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fmsDzAp4jZhOIXCADGNvOixFVtLK6NH2asq/IiqvV9XC0xLvqXwyMR4UhgPtOhkjYBNQhFx6DjHHIFfJCi04abotuE+R8He9f2Q6/pPNKLRngsbO+z77COimhfiGxkMuAOOfFeSxqHB/VYpjEf00QF7wZU8MkQI9n3vAVovOHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E6wX8z01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A38C4CEF1;
	Fri, 21 Nov 2025 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763741060;
	bh=1AFIw0g5N17VidVJkGVfLzwOa+RMmAWZuX9Dthc5/nM=;
	h=Subject:To:Cc:From:Date:From;
	b=E6wX8z01OdVwNygcqDacysDPP4hWI1Qm45wg0/HJPtR8Pzdx8zsMVzKUvH/DqrX+9
	 j5hTPFFlp3M0IeYlDTY4qEs4ftLUx4j6crPN0eaLiikOn7JyCu0Pd3GXilmR3PCTtw
	 OWysWWeWC3mZ782T2v/mDnWw5UMq4lpZAmcPVx1Y=
Subject: FAILED: patch "[PATCH] kho: warn and fail on metadata or preserved memory in scratch" failed to apply to 6.17-stable tree
To: pasha.tatashin@soleen.com,akpm@linux-foundation.org,brauner@kernel.org,corbet@lwn.net,dmatlack@google.com,graf@amazon.com,jgg@ziepe.ca,masahiroy@kernel.org,ojeda@kernel.org,pratyush@kernel.org,rdunlap@infradead.org,rppt@kernel.org,skhawaja@google.com,stable@vger.kernel.org,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 21 Nov 2025 17:04:17 +0100
Message-ID: <2025112117-pursuant-varmint-6bbc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x e38f65d317df1fd2dcafe614d9c537475ecf9992
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112117-pursuant-varmint-6bbc@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e38f65d317df1fd2dcafe614d9c537475ecf9992 Mon Sep 17 00:00:00 2001
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 20:08:50 -0400
Subject: [PATCH] kho: warn and fail on metadata or preserved memory in scratch
 area

Patch series "KHO: kfence + KHO memory corruption fix", v3.

This series fixes a memory corruption bug in KHO that occurs when KFENCE
is enabled.

The root cause is that KHO metadata, allocated via kzalloc(), can be
randomly serviced by kfence_alloc().  When a kernel boots via KHO, the
early memblock allocator is restricted to a "scratch area".  This forces
the KFENCE pool to be allocated within this scratch area, creating a
conflict.  If KHO metadata is subsequently placed in this pool, it gets
corrupted during the next kexec operation.

Google is using KHO and have had obscure crashes due to this memory
corruption, with stacks all over the place.  I would prefer this fix to be
properly backported to stable so we can also automatically consume it once
we switch to the upstream KHO.

Patch 1/3 introduces a debug-only feature (CONFIG_KEXEC_HANDOVER_DEBUG)
that adds checks to detect and fail any operation that attempts to place
KHO metadata or preserved memory within the scratch area.  This serves as
a validation and diagnostic tool to confirm the problem without affecting
production builds.

Patch 2/3 Increases bitmap to PAGE_SIZE, so buddy allocator can be used.

Patch 3/3 Provides the fix by modifying KHO to allocate its metadata
directly from the buddy allocator instead of slab.  This bypasses the
KFENCE interception entirely.


This patch (of 3):

It is invalid for KHO metadata or preserved memory regions to be located
within the KHO scratch area, as this area is overwritten when the next
kernel is loaded, and used early in boot by the next kernel.  This can
lead to memory corruption.

Add checks to kho_preserve_* and KHO's internal metadata allocators
(xa_load_or_alloc, new_chunk) to verify that the physical address of the
memory does not overlap with any defined scratch region.  If an overlap is
detected, the operation will fail and a WARN_ON is triggered.  To avoid
performance overhead in production kernels, these checks are enabled only
when CONFIG_KEXEC_HANDOVER_DEBUG is selected.

[rppt@kernel.org: fix KEXEC_HANDOVER_DEBUG Kconfig dependency]
  Link: https://lkml.kernel.org/r/aQHUyyFtiNZhx8jo@kernel.org
[pasha.tatashin@soleen.com: build fix]
  Link: https://lkml.kernel.org/r/CA+CK2bBnorfsTymKtv4rKvqGBHs=y=MjEMMRg_tE-RME6n-zUw@mail.gmail.com
Link: https://lkml.kernel.org/r/20251021000852.2924827-1-pasha.tatashin@soleen.com
Link: https://lkml.kernel.org/r/20251021000852.2924827-2-pasha.tatashin@soleen.com
Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Mike Rapoport <rppt@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 422270d64820..54e581072617 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -109,6 +109,15 @@ config KEXEC_HANDOVER
 	  to keep data or state alive across the kexec. For this to work,
 	  both source and target kernels need to have this option enabled.
 
+config KEXEC_HANDOVER_DEBUG
+	bool "Enable Kexec Handover debug checks"
+	depends on KEXEC_HANDOVER
+	help
+	  This option enables extra sanity checks for the Kexec Handover
+	  subsystem. Since, KHO performance is crucial in live update
+	  scenarios and the extra code might be adding overhead it is
+	  only optionally enabled.
+
 config CRASH_DUMP
 	bool "kernel crash dumps"
 	default ARCH_DEFAULT_CRASH_DUMP
diff --git a/kernel/Makefile b/kernel/Makefile
index df3dd8291bb6..9fe722305c9b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
 obj-$(CONFIG_KEXEC_HANDOVER) += kexec_handover.o
+obj-$(CONFIG_KEXEC_HANDOVER_DEBUG) += kexec_handover_debug.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 76f0940fb485..0bc9001e532a 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "KHO: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/cma.h>
 #include <linux/count_zeros.h>
 #include <linux/debugfs.h>
@@ -22,6 +23,7 @@
 
 #include <asm/early_ioremap.h>
 
+#include "kexec_handover_internal.h"
 /*
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
@@ -133,26 +135,26 @@ static struct kho_out kho_out = {
 
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 {
-	void *elm, *res;
+	void *res = xa_load(xa, index);
 
-	elm = xa_load(xa, index);
-	if (elm)
-		return elm;
+	if (res)
+		return res;
+
+	void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
 
-	elm = kzalloc(sz, GFP_KERNEL);
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
+		return ERR_PTR(-EINVAL);
+
 	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
 	if (xa_is_err(res))
-		res = ERR_PTR(xa_err(res));
-
-	if (res) {
-		kfree(elm);
+		return ERR_PTR(xa_err(res));
+	else if (res)
 		return res;
-	}
 
-	return elm;
+	return no_free_ptr(elm);
 }
 
 static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
@@ -345,15 +347,19 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
 static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 					  unsigned long order)
 {
-	struct khoser_mem_chunk *chunk;
+	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
 
 	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!chunk)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE)))
+		return ERR_PTR(-EINVAL);
+
 	chunk->hdr.order = order;
 	if (cur_chunk)
 		KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
-	return chunk;
+	return no_free_ptr(chunk);
 }
 
 static void kho_mem_ser_free(struct khoser_mem_chunk *first_chunk)
@@ -374,14 +380,17 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 	struct khoser_mem_chunk *chunk = NULL;
 	struct kho_mem_phys *physxa;
 	unsigned long order;
+	int err = -ENOMEM;
 
 	xa_for_each(&ser->track.orders, order, physxa) {
 		struct kho_mem_phys_bits *bits;
 		unsigned long phys;
 
 		chunk = new_chunk(chunk, order);
-		if (!chunk)
+		if (IS_ERR(chunk)) {
+			err = PTR_ERR(chunk);
 			goto err_free;
+		}
 
 		if (!first_chunk)
 			first_chunk = chunk;
@@ -391,8 +400,10 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 
 			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
 				chunk = new_chunk(chunk, order);
-				if (!chunk)
+				if (IS_ERR(chunk)) {
+					err = PTR_ERR(chunk);
 					goto err_free;
+				}
 			}
 
 			elm = &chunk->bitmaps[chunk->hdr.num_elms];
@@ -409,7 +420,7 @@ static int kho_mem_serialize(struct kho_serialization *ser)
 
 err_free:
 	kho_mem_ser_free(first_chunk);
-	return -ENOMEM;
+	return err;
 }
 
 static void __init deserialize_bitmap(unsigned int order,
@@ -465,8 +476,8 @@ static void __init kho_mem_deserialize(const void *fdt)
  * area for early allocations that happen before page allocator is
  * initialized.
  */
-static struct kho_scratch *kho_scratch;
-static unsigned int kho_scratch_cnt;
+struct kho_scratch *kho_scratch;
+unsigned int kho_scratch_cnt;
 
 /*
  * The scratch areas are scaled by default as percent of memory allocated from
@@ -752,6 +763,9 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.ser.track;
 
+	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
+		return -EINVAL;
+
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -775,6 +789,11 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 	unsigned long failed_pfn = 0;
 	int err = 0;
 
+	if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
+					nr_pages << PAGE_SHIFT))) {
+		return -EINVAL;
+	}
+
 	while (pfn < end_pfn) {
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
diff --git a/kernel/kexec_handover_debug.c b/kernel/kexec_handover_debug.c
new file mode 100644
index 000000000000..6efb696f5426
--- /dev/null
+++ b/kernel/kexec_handover_debug.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kexec_handover_debug.c - kexec handover optional debug functionality
+ * Copyright (C) 2025 Google LLC, Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define pr_fmt(fmt) "KHO: " fmt
+
+#include "kexec_handover_internal.h"
+
+bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	phys_addr_t scratch_start, scratch_end;
+	unsigned int i;
+
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		scratch_start = kho_scratch[i].addr;
+		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
+
+		if (phys < scratch_end && (phys + size) > scratch_start)
+			return true;
+	}
+
+	return false;
+}
diff --git a/kernel/kexec_handover_internal.h b/kernel/kexec_handover_internal.h
new file mode 100644
index 000000000000..3c3c7148ceed
--- /dev/null
+++ b/kernel/kexec_handover_internal.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_KEXEC_HANDOVER_INTERNAL_H
+#define LINUX_KEXEC_HANDOVER_INTERNAL_H
+
+#include <linux/kexec_handover.h>
+#include <linux/types.h>
+
+extern struct kho_scratch *kho_scratch;
+extern unsigned int kho_scratch_cnt;
+
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+bool kho_scratch_overlap(phys_addr_t phys, size_t size);
+#else
+static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
+
+#endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */


