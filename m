Return-Path: <stable+bounces-57534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BAC925CE2
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA781F24ABF
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7767C18E74A;
	Wed,  3 Jul 2024 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WnIutxzb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383917DA3A;
	Wed,  3 Jul 2024 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005171; cv=none; b=g4CorkOVlfut+Exv9C3PkbW7BtwGbqZn2PU9z9yOaYltl4W8Fbk3/IVNS00xGEBLcgFqqKdsmWgNrkS0TFEqJzKUJtPdmWW1f8y5xt0wE2RyhJW9xYGe3rX9ffEvJlq0bYT6C6BZXQi/gLGnfqFIwN2dnvi8EE44tBlbh1aqJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005171; c=relaxed/simple;
	bh=a2SNwAk6Kez8sexZPHCaYpQr/1qrK3JG6wfPJLtZAOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsU3EosBcn5eOhdEKVQuDi1oeZoIxT01BT1Qqyaj298RCXlWFAOXQHIiJMFHo0q+hjccENp5OFjsmyX1BKueh3P+uhrIFR7Avmp6K0FivWEGxJjUEcyxVDy8gGomA1PJuo2Gjq7aZD2VtO7V8M0oVO4qe3sgh81fPTFYoh3yyoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WnIutxzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7F0C32781;
	Wed,  3 Jul 2024 11:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005171;
	bh=a2SNwAk6Kez8sexZPHCaYpQr/1qrK3JG6wfPJLtZAOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WnIutxzbBOY9amqE1GhSxu/hMUp85BfsvRWhz4Mpyc44FsaZqXgLumHtABKDp3H/D
	 bMCcK4MGJCeyNs2bvnc5lNSuqrrVFd7DJOtBPavX2Hy5zAmlsMIxnVLXbxCdaQflB/
	 PpWU9eDxdaMONxWepyDJfIMMhFUb7Vpm7I8kvG/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.10 284/290] efi: memmap: Move manipulation routines into x86 arch tree
Date: Wed,  3 Jul 2024 12:41:05 +0200
Message-ID: <20240703102914.877551561@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit fdc6d38d64a20c542b1867ebeb8dd03b98829336 upstream ]

The EFI memory map is a description of the memory layout as provided by
the firmware, and only x86 manipulates it in various different ways for
its own memory bookkeeping. So let's move the memmap routines that are
only used by x86 into the x86 arch tree.

[ardb: minor tweaks for linux-5.10.y backport]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/efi.h     |   12 ++
 arch/x86/platform/efi/Makefile |    3 
 arch/x86/platform/efi/memmap.c |  236 ++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/memmap.c  |  240 +----------------------------------------
 include/linux/efi.h            |   10 -
 5 files changed, 261 insertions(+), 240 deletions(-)
 create mode 100644 arch/x86/platform/efi/memmap.c

--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -382,4 +382,16 @@ static inline void efi_fake_memmap_early
 }
 #endif
 
+extern int __init efi_memmap_alloc(unsigned int num_entries,
+				   struct efi_memory_map_data *data);
+extern void __efi_memmap_free(u64 phys, unsigned long size,
+			      unsigned long flags);
+#define __efi_memmap_free __efi_memmap_free
+
+extern int __init efi_memmap_install(struct efi_memory_map_data *data);
+extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
+					 struct range *range);
+extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
+				     void *buf, struct efi_mem_range *mem);
+
 #endif /* _ASM_X86_EFI_H */
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -3,5 +3,6 @@ OBJECT_FILES_NON_STANDARD_efi_thunk_$(BI
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
 
-obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
+obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
+				   efi_stub_$(BITS).o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
--- /dev/null
+++ b/arch/x86/platform/efi/memmap.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common EFI memory map functions.
+ */
+
+#define pr_fmt(fmt) "efi: " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/efi.h>
+#include <linux/io.h>
+#include <asm/early_ioremap.h>
+#include <asm/efi.h>
+#include <linux/memblock.h>
+#include <linux/slab.h>
+
+static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
+{
+	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
+}
+
+static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
+{
+	unsigned int order = get_order(size);
+	struct page *p = alloc_pages(GFP_KERNEL, order);
+
+	if (!p)
+		return 0;
+
+	return PFN_PHYS(page_to_pfn(p));
+}
+
+void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
+{
+	if (flags & EFI_MEMMAP_MEMBLOCK) {
+		if (slab_is_available())
+			memblock_free_late(phys, size);
+		else
+			memblock_free(phys, size);
+	} else if (flags & EFI_MEMMAP_SLAB) {
+		struct page *p = pfn_to_page(PHYS_PFN(phys));
+		unsigned int order = get_order(size);
+
+		free_pages((unsigned long) page_address(p), order);
+	}
+}
+
+/**
+ * efi_memmap_alloc - Allocate memory for the EFI memory map
+ * @num_entries: Number of entries in the allocated map.
+ * @data: efi memmap installation parameters
+ *
+ * Depending on whether mm_init() has already been invoked or not,
+ * either memblock or "normal" page allocation is used.
+ *
+ * Returns zero on success, a negative error code on failure.
+ */
+int __init efi_memmap_alloc(unsigned int num_entries,
+		struct efi_memory_map_data *data)
+{
+	/* Expect allocation parameters are zero initialized */
+	WARN_ON(data->phys_map || data->size);
+
+	data->size = num_entries * efi.memmap.desc_size;
+	data->desc_version = efi.memmap.desc_version;
+	data->desc_size = efi.memmap.desc_size;
+	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
+	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
+
+	if (slab_is_available()) {
+		data->flags |= EFI_MEMMAP_SLAB;
+		data->phys_map = __efi_memmap_alloc_late(data->size);
+	} else {
+		data->flags |= EFI_MEMMAP_MEMBLOCK;
+		data->phys_map = __efi_memmap_alloc_early(data->size);
+	}
+
+	if (!data->phys_map)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * efi_memmap_install - Install a new EFI memory map in efi.memmap
+ * @ctx: map allocation parameters (address, size, flags)
+ *
+ * Unlike efi_memmap_init_*(), this function does not allow the caller
+ * to switch from early to late mappings. It simply uses the existing
+ * mapping function and installs the new memmap.
+ *
+ * Returns zero on success, a negative error code on failure.
+ */
+int __init efi_memmap_install(struct efi_memory_map_data *data)
+{
+	efi_memmap_unmap();
+
+	return __efi_memmap_init(data);
+}
+
+/**
+ * efi_memmap_split_count - Count number of additional EFI memmap entries
+ * @md: EFI memory descriptor to split
+ * @range: Address range (start, end) to split around
+ *
+ * Returns the number of additional EFI memmap entries required to
+ * accommodate @range.
+ */
+int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
+{
+	u64 m_start, m_end;
+	u64 start, end;
+	int count = 0;
+
+	start = md->phys_addr;
+	end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+	/* modifying range */
+	m_start = range->start;
+	m_end = range->end;
+
+	if (m_start <= start) {
+		/* split into 2 parts */
+		if (start < m_end && m_end < end)
+			count++;
+	}
+
+	if (start < m_start && m_start < end) {
+		/* split into 3 parts */
+		if (m_end < end)
+			count += 2;
+		/* split into 2 parts */
+		if (end <= m_end)
+			count++;
+	}
+
+	return count;
+}
+
+/**
+ * efi_memmap_insert - Insert a memory region in an EFI memmap
+ * @old_memmap: The existing EFI memory map structure
+ * @buf: Address of buffer to store new map
+ * @mem: Memory map entry to insert
+ *
+ * It is suggested that you call efi_memmap_split_count() first
+ * to see how large @buf needs to be.
+ */
+void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
+			      struct efi_mem_range *mem)
+{
+	u64 m_start, m_end, m_attr;
+	efi_memory_desc_t *md;
+	u64 start, end;
+	void *old, *new;
+
+	/* modifying range */
+	m_start = mem->range.start;
+	m_end = mem->range.end;
+	m_attr = mem->attribute;
+
+	/*
+	 * The EFI memory map deals with regions in EFI_PAGE_SIZE
+	 * units. Ensure that the region described by 'mem' is aligned
+	 * correctly.
+	 */
+	if (!IS_ALIGNED(m_start, EFI_PAGE_SIZE) ||
+	    !IS_ALIGNED(m_end + 1, EFI_PAGE_SIZE)) {
+		WARN_ON(1);
+		return;
+	}
+
+	for (old = old_memmap->map, new = buf;
+	     old < old_memmap->map_end;
+	     old += old_memmap->desc_size, new += old_memmap->desc_size) {
+
+		/* copy original EFI memory descriptor */
+		memcpy(new, old, old_memmap->desc_size);
+		md = new;
+		start = md->phys_addr;
+		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
+
+		if (m_start <= start && end <= m_end)
+			md->attribute |= m_attr;
+
+		if (m_start <= start &&
+		    (start < m_end && m_end < end)) {
+			/* first part */
+			md->attribute |= m_attr;
+			md->num_pages = (m_end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+			/* latter part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_end + 1;
+			md->num_pages = (end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+		}
+
+		if ((start < m_start && m_start < end) && m_end < end) {
+			/* first part */
+			md->num_pages = (m_start - md->phys_addr) >>
+				EFI_PAGE_SHIFT;
+			/* middle part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->attribute |= m_attr;
+			md->phys_addr = m_start;
+			md->num_pages = (m_end - m_start + 1) >>
+				EFI_PAGE_SHIFT;
+			/* last part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_end + 1;
+			md->num_pages = (end - m_end) >>
+				EFI_PAGE_SHIFT;
+		}
+
+		if ((start < m_start && m_start < end) &&
+		    (end <= m_end)) {
+			/* first part */
+			md->num_pages = (m_start - md->phys_addr) >>
+				EFI_PAGE_SHIFT;
+			/* latter part */
+			new += old_memmap->desc_size;
+			memcpy(new, old, old_memmap->desc_size);
+			md = new;
+			md->phys_addr = m_start;
+			md->num_pages = (end - md->phys_addr + 1) >>
+				EFI_PAGE_SHIFT;
+			md->attribute |= m_attr;
+		}
+	}
+}
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -9,82 +9,15 @@
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/io.h>
-#include <asm/early_ioremap.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
 
-static phys_addr_t __init __efi_memmap_alloc_early(unsigned long size)
-{
-	return memblock_phys_alloc(size, SMP_CACHE_BYTES);
-}
-
-static phys_addr_t __init __efi_memmap_alloc_late(unsigned long size)
-{
-	unsigned int order = get_order(size);
-	struct page *p = alloc_pages(GFP_KERNEL, order);
-
-	if (!p)
-		return 0;
-
-	return PFN_PHYS(page_to_pfn(p));
-}
-
-void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
-{
-	if (flags & EFI_MEMMAP_MEMBLOCK) {
-		if (slab_is_available())
-			memblock_free_late(phys, size);
-		else
-			memblock_free(phys, size);
-	} else if (flags & EFI_MEMMAP_SLAB) {
-		struct page *p = pfn_to_page(PHYS_PFN(phys));
-		unsigned int order = get_order(size);
-
-		free_pages((unsigned long) page_address(p), order);
-	}
-}
-
-static void __init efi_memmap_free(void)
-{
-	__efi_memmap_free(efi.memmap.phys_map,
-			efi.memmap.desc_size * efi.memmap.nr_map,
-			efi.memmap.flags);
-}
-
-/**
- * efi_memmap_alloc - Allocate memory for the EFI memory map
- * @num_entries: Number of entries in the allocated map.
- * @data: efi memmap installation parameters
- *
- * Depending on whether mm_init() has already been invoked or not,
- * either memblock or "normal" page allocation is used.
- *
- * Returns zero on success, a negative error code on failure.
- */
-int __init efi_memmap_alloc(unsigned int num_entries,
-		struct efi_memory_map_data *data)
-{
-	/* Expect allocation parameters are zero initialized */
-	WARN_ON(data->phys_map || data->size);
-
-	data->size = num_entries * efi.memmap.desc_size;
-	data->desc_version = efi.memmap.desc_version;
-	data->desc_size = efi.memmap.desc_size;
-	data->flags &= ~(EFI_MEMMAP_SLAB | EFI_MEMMAP_MEMBLOCK);
-	data->flags |= efi.memmap.flags & EFI_MEMMAP_LATE;
-
-	if (slab_is_available()) {
-		data->flags |= EFI_MEMMAP_SLAB;
-		data->phys_map = __efi_memmap_alloc_late(data->size);
-	} else {
-		data->flags |= EFI_MEMMAP_MEMBLOCK;
-		data->phys_map = __efi_memmap_alloc_early(data->size);
-	}
+#include <asm/early_ioremap.h>
+#include <asm/efi.h>
 
-	if (!data->phys_map)
-		return -ENOMEM;
-	return 0;
-}
+#ifndef __efi_memmap_free
+#define __efi_memmap_free(phys, size, flags) do { } while (0)
+#endif
 
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
@@ -101,7 +34,7 @@ int __init efi_memmap_alloc(unsigned int
  *
  * Returns zero on success, a negative error code on failure.
  */
-static int __init __efi_memmap_init(struct efi_memory_map_data *data)
+int __init __efi_memmap_init(struct efi_memory_map_data *data)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
@@ -121,8 +54,10 @@ static int __init __efi_memmap_init(stru
 		return -ENOMEM;
 	}
 
-	/* NOP if data->flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB) == 0 */
-	efi_memmap_free();
+	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
+		__efi_memmap_free(efi.memmap.phys_map,
+				  efi.memmap.desc_size * efi.memmap.nr_map,
+				  efi.memmap.flags);
 
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
@@ -220,158 +155,3 @@ int __init efi_memmap_init_late(phys_add
 
 	return __efi_memmap_init(&data);
 }
-
-/**
- * efi_memmap_install - Install a new EFI memory map in efi.memmap
- * @ctx: map allocation parameters (address, size, flags)
- *
- * Unlike efi_memmap_init_*(), this function does not allow the caller
- * to switch from early to late mappings. It simply uses the existing
- * mapping function and installs the new memmap.
- *
- * Returns zero on success, a negative error code on failure.
- */
-int __init efi_memmap_install(struct efi_memory_map_data *data)
-{
-	efi_memmap_unmap();
-
-	return __efi_memmap_init(data);
-}
-
-/**
- * efi_memmap_split_count - Count number of additional EFI memmap entries
- * @md: EFI memory descriptor to split
- * @range: Address range (start, end) to split around
- *
- * Returns the number of additional EFI memmap entries required to
- * accommodate @range.
- */
-int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
-{
-	u64 m_start, m_end;
-	u64 start, end;
-	int count = 0;
-
-	start = md->phys_addr;
-	end = start + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-	/* modifying range */
-	m_start = range->start;
-	m_end = range->end;
-
-	if (m_start <= start) {
-		/* split into 2 parts */
-		if (start < m_end && m_end < end)
-			count++;
-	}
-
-	if (start < m_start && m_start < end) {
-		/* split into 3 parts */
-		if (m_end < end)
-			count += 2;
-		/* split into 2 parts */
-		if (end <= m_end)
-			count++;
-	}
-
-	return count;
-}
-
-/**
- * efi_memmap_insert - Insert a memory region in an EFI memmap
- * @old_memmap: The existing EFI memory map structure
- * @buf: Address of buffer to store new map
- * @mem: Memory map entry to insert
- *
- * It is suggested that you call efi_memmap_split_count() first
- * to see how large @buf needs to be.
- */
-void __init efi_memmap_insert(struct efi_memory_map *old_memmap, void *buf,
-			      struct efi_mem_range *mem)
-{
-	u64 m_start, m_end, m_attr;
-	efi_memory_desc_t *md;
-	u64 start, end;
-	void *old, *new;
-
-	/* modifying range */
-	m_start = mem->range.start;
-	m_end = mem->range.end;
-	m_attr = mem->attribute;
-
-	/*
-	 * The EFI memory map deals with regions in EFI_PAGE_SIZE
-	 * units. Ensure that the region described by 'mem' is aligned
-	 * correctly.
-	 */
-	if (!IS_ALIGNED(m_start, EFI_PAGE_SIZE) ||
-	    !IS_ALIGNED(m_end + 1, EFI_PAGE_SIZE)) {
-		WARN_ON(1);
-		return;
-	}
-
-	for (old = old_memmap->map, new = buf;
-	     old < old_memmap->map_end;
-	     old += old_memmap->desc_size, new += old_memmap->desc_size) {
-
-		/* copy original EFI memory descriptor */
-		memcpy(new, old, old_memmap->desc_size);
-		md = new;
-		start = md->phys_addr;
-		end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT) - 1;
-
-		if (m_start <= start && end <= m_end)
-			md->attribute |= m_attr;
-
-		if (m_start <= start &&
-		    (start < m_end && m_end < end)) {
-			/* first part */
-			md->attribute |= m_attr;
-			md->num_pages = (m_end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) && m_end < end) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* middle part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->attribute |= m_attr;
-			md->phys_addr = m_start;
-			md->num_pages = (m_end - m_start + 1) >>
-				EFI_PAGE_SHIFT;
-			/* last part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_end + 1;
-			md->num_pages = (end - m_end) >>
-				EFI_PAGE_SHIFT;
-		}
-
-		if ((start < m_start && m_start < end) &&
-		    (end <= m_end)) {
-			/* first part */
-			md->num_pages = (m_start - md->phys_addr) >>
-				EFI_PAGE_SHIFT;
-			/* latter part */
-			new += old_memmap->desc_size;
-			memcpy(new, old, old_memmap->desc_size);
-			md = new;
-			md->phys_addr = m_start;
-			md->num_pages = (end - md->phys_addr + 1) >>
-				EFI_PAGE_SHIFT;
-			md->attribute |= m_attr;
-		}
-	}
-}
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -633,18 +633,10 @@ static inline efi_status_t efi_query_var
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 
-extern int __init efi_memmap_alloc(unsigned int num_entries,
-				   struct efi_memory_map_data *data);
-extern void __efi_memmap_free(u64 phys, unsigned long size,
-			      unsigned long flags);
+extern int __init __efi_memmap_init(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_early(struct efi_memory_map_data *data);
 extern int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size);
 extern void __init efi_memmap_unmap(void);
-extern int __init efi_memmap_install(struct efi_memory_map_data *data);
-extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
-					 struct range *range);
-extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
-				     void *buf, struct efi_mem_range *mem);
 
 #ifdef CONFIG_EFI_ESRT
 extern void __init efi_esrt_init(void);



