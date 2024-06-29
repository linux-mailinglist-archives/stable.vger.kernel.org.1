Return-Path: <stable+bounces-56130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED6A91CDC5
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6439C282D23
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D682889;
	Sat, 29 Jun 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7YtJE1j"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778505B05E
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674054; cv=none; b=ukakkMdzVYV/zxUfPRnaj7RUfQitO41XhTZYv7XiKiAYqkPpi3XNePNWiqQjMHefjGCmu9XwKUzKuZT1/rRFEAAXL6gP7UpAokj/gYRbmUNmA/NoysDIu4tir5wSS2Dao21a6PEkFrxzzbpTwwns+uAjPbwCPZABYXLsO5hvUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674054; c=relaxed/simple;
	bh=Cli4Fm6h9CrtBl/mWEvfaUimuDexrgr7E3SyEHaUjhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=e0ngpGJqs1xWWhSn95jYvajY7HSd+sH1FIAessBQrDN/8VTFPY6vqg/5FvTArsPofzOFT9MG19aa01Qnr8Lt1PkazBuo/5qTeFJ1WWGmoqv7xukEz90mSiFN1aRzSeXqC0WTr1lSSxBXQUZXrXkgye5PV3f1QBt2kUXDvYuuglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7YtJE1j; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso2673889276.2
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719674051; x=1720278851; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imDkIhT5oMXRe0SnlpiIO9gbF/3TEFN47ecKZGD++T0=;
        b=q7YtJE1jhShLfKL3UkpLIm851fRLAJO2L0gL3wOQo+oo1dd40fd2ue1V/4dUc4vHQU
         Z0k9dOd0QKV13qjPImi4JtQv4ATLVNoQLaTmBhXaU+r/QCw5eREH3QtiBpqoCybz67R/
         +iJaQdEov4ZjFKuP6+xuUAXos3+ImrV6geXywq88aQ05dl9kj7EOaJKEB+KDi9Etthh3
         5NwPeRPdISFkEe4/ysfoPvJQGb1eLea+U+wdGGtZLhXYbrtWAxrG8/DdDQdRf9kglqsB
         fEL6b99Hmac1Z8YRvwHPJ0YCDfLrW/d4yOY+WXJLvhO8j+g9seaIcg1ga5McySyAp8Yd
         na/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719674051; x=1720278851;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imDkIhT5oMXRe0SnlpiIO9gbF/3TEFN47ecKZGD++T0=;
        b=K7fxz2dtHolxBWMZTp1ZuCjKVi7V/oTQIMqOqeeV1EKvVl6bDu1bVYmRdqwKQ5l4Lv
         cEVSCi2mCJChYh55FJF5c4HGdbNpvq94MvlOl7COclWXOvMyXfVxZ/XRI3LwFhECR06R
         b2KNygNEXStEpEsSi46D6wUZerTTzFFQIyz3Q4YjIV/U7PP2nC3Sz6fT114QFQTU8A6i
         W5ZBo+Bgg4JyUfpGuAQxwSDKIJnajCoy1dIL01LTjvm9U1iV85J6thmCKDPbB1DOq+hZ
         227sbMV9kP4a524QXbQpQev0cWIrMXFxrSHmVVbm0pKipcyhl5CZUFzp39HDbCa34ibb
         w0Zg==
X-Gm-Message-State: AOJu0YyoFMgdAUjUt6UXDw/d895wqlab5eGDOsaUw3ICIFQpiIxekDXY
	rf1uDJQKhfv5UZ/xoLO/V6RoNc2MveIX/3OojklvlH83TQoQ0OIHyLvPQWV1T68BIrcRnjYxkzP
	7G40+7SpVURwj1moa9HMg81StVuJnsVjWj7rffdwLs8Cv9CtTv3LDOc92fBpcLfPsSRzGM8BUnz
	GYCNUOB8RWy6adUjmLgXp5Yw==
X-Google-Smtp-Source: AGHT+IE05sD6ZrQpaocSmyHqxDjm0nMgXZHHZWpgDw3hWbNoGgGYFu4pHsTYtScAk5s/IkLatoDZSKNx
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:18c3:b0:e03:510d:3b6e with SMTP id
 3f1490d57ef6-e036eae08f6mr4596276.3.1719674051348; Sat, 29 Jun 2024 08:14:11
 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:14:00 +0200
In-Reply-To: <20240629151357.866803-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024062455-glazing-flask-cf0c@gregkh> <20240629151357.866803-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=18239; i=ardb@kernel.org;
 h=from:subject; bh=J2oKyb8EjSPBihyJEvKgr/YX9b7Gs+itykKhkiQvjRs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1BZYdCfUsr1/bPx/pua2+cWJrSzxdmMDEq8nZbYQ7rx
 gWaP7U7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEROCTH8ZjEP1/TILF690dn/
 B3/6lsuSr8/cT/BZ73loxYfsI/FTIxn+yjfEv/oScnWrQDf3s1+hN0Kkew4aCk/TLGNbHibYtDC ICwA=
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240629151357.866803-8-ardb+git@google.com>
Subject: [PATCH 5.10.y 3/5] efi: memmap: Move manipulation routines into x86
 arch tree
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit fdc6d38d64a20c542b1867ebeb8dd03b98829336 upstream ]

The EFI memory map is a description of the memory layout as provided by
the firmware, and only x86 manipulates it in various different ways for
its own memory bookkeeping. So let's move the memmap routines that are
only used by x86 into the x86 arch tree.

[ardb: minor tweaks for linux-5.10.y backport]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h     |  12 ++
 arch/x86/platform/efi/Makefile |   3 +-
 arch/x86/platform/efi/memmap.c | 236 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/memmap.c  | 240 ++-------------------------------
 include/linux/efi.h            |  10 +-
 5 files changed, 261 insertions(+), 240 deletions(-)
 create mode 100644 arch/x86/platform/efi/memmap.c

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index bc9758ef292e..01c0410ae97a 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -382,4 +382,16 @@ static inline void efi_fake_memmap_early(void)
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
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 84b09c230cbd..196f61fdbf28 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -3,5 +3,6 @@ OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
 
-obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
+obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
+				   efi_stub_$(BITS).o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
new file mode 100644
index 000000000000..620af26b55c0
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
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 3aaf717aad05..e6256c48284e 100644
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
@@ -101,7 +34,7 @@ int __init efi_memmap_alloc(unsigned int num_entries,
  *
  * Returns zero on success, a negative error code on failure.
  */
-static int __init __efi_memmap_init(struct efi_memory_map_data *data)
+int __init __efi_memmap_init(struct efi_memory_map_data *data)
 {
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
@@ -121,8 +54,10 @@ static int __init __efi_memmap_init(struct efi_memory_map_data *data)
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
@@ -220,158 +155,3 @@ int __init efi_memmap_init_late(phys_addr_t addr, unsigned long size)
 
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
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 084990390420..2fd321da5c4b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -633,18 +633,10 @@ static inline efi_status_t efi_query_variable_store(u32 attributes,
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
-- 
2.45.2.803.g4e1b14247a-goog


