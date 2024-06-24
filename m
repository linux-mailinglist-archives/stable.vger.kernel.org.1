Return-Path: <stable+bounces-55063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10542915485
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE561F22F1B
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679B19E7F2;
	Mon, 24 Jun 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S/lvouoA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7519E7EC
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247321; cv=none; b=EEg3qIKnJ7+dWjFd+xLF4qTiXzWgiN7EZX/P2gAlQHsyh3eLgnF4sCdC1+qGNvHWyuFI3hoR781y0elP48jx2LaHiLM9q7JrYmHZZQYTQ5yGEnVUGDDvmXjSHBvuHPuLQOrKXb0RKBkSckhCWW1DuSX3UHY6cyG6EKKdN2ls0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247321; c=relaxed/simple;
	bh=crDGzoUHwIve+f2/L6LkwaHLqu33hOKV+g9t7oIpX2Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CMuy6AdWJWFEVy++SnrSGlLvw1VvhVof5+OYc0FIzpLIPhvLJ4BOkl1KdgllfXPSGr17rFJbkHrB75ZXVnzkgxzEI0PYZHJh0Tiw/VlCGENZr4NswWxf2lb+uPtneLUaJjkdrsO0E/N+4PbbF8Do1fmTeCq7iqWxkxH/weLcQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S/lvouoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29C5C2BBFC;
	Mon, 24 Jun 2024 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247321;
	bh=crDGzoUHwIve+f2/L6LkwaHLqu33hOKV+g9t7oIpX2Y=;
	h=Subject:To:Cc:From:Date:From;
	b=S/lvouoAa/ww6vQv537f6etx3dsW0dC7BQ/TC17Ec3rPABedYjXgnwMXd2+DRza0s
	 PWCdBo6CmId1wMuvXFfxBOd6bBsAKMtQgXanD60Sz1LzQP/4ZYIKS+i+TQuzUBau+D
	 +jonGl4PIbUvjgVrTiqqC3o4GL+bBC4LqqUEiFfE=
Subject: FAILED: patch "[PATCH] efi/x86: Free EFI memory map only when installing a new one." failed to apply to 5.15-stable tree
To: ardb@kernel.org,Ashish.Kalra@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:40:50 +0200
Message-ID: <2024062448-overspend-lucid-de35@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 75dde792d6f6c2d0af50278bd374bf0c512fe196
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062448-overspend-lucid-de35@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

75dde792d6f6 ("efi/x86: Free EFI memory map only when installing a new one.")
d85e3e349407 ("efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures")
fdc6d38d64a2 ("efi: memmap: Move manipulation routines into x86 arch tree")
1df4d1724baa ("drivers: fix typo in firmware/efi/memmap.c")
db01ea882bf6 ("efi: Correct comment on efi_memmap_alloc")
3ecc68349bba ("memblock: rename memblock_free to memblock_phys_free")
fa27717110ae ("memblock: drop memblock_free_early_nid() and memblock_free_early()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75dde792d6f6c2d0af50278bd374bf0c512fe196 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 10 Jun 2024 16:02:13 +0200
Subject: [PATCH] efi/x86: Free EFI memory map only when installing a new one.

The logic in __efi_memmap_init() is shared between two different
execution flows:
- mapping the EFI memory map early or late into the kernel VA space, so
  that its entries can be accessed;
- the x86 specific cloning of the EFI memory map in order to insert new
  entries that are created as a result of making a memory reservation
  via a call to efi_mem_reserve().

In the former case, the underlying memory containing the kernel's view
of the EFI memory map (which may be heavily modified by the kernel
itself on x86) is not modified at all, and the only thing that changes
is the virtual mapping of this memory, which is different between early
and late boot.

In the latter case, an entirely new allocation is created that carries a
new, updated version of the kernel's view of the EFI memory map. When
installing this new version, the old version will no longer be
referenced, and if the memory was allocated by the kernel, it will leak
unless it gets freed.

The logic that implements this freeing currently lives on the code path
that is shared between these two use cases, but it should only apply to
the latter. So move it to the correct spot.

While at it, drop the dummy definition for non-x86 architectures, as
that is no longer needed.

Cc: <stable@vger.kernel.org>
Fixes: f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")
Tested-by: Ashish Kalra <Ashish.Kalra@amd.com>
Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 1dc600fa3ba5..481096177500 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -401,7 +401,6 @@ extern int __init efi_memmap_alloc(unsigned int num_entries,
 				   struct efi_memory_map_data *data);
 extern void __efi_memmap_free(u64 phys, unsigned long size,
 			      unsigned long flags);
-#define __efi_memmap_free __efi_memmap_free
 
 extern int __init efi_memmap_install(struct efi_memory_map_data *data);
 extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 4ef20b49eb5e..6ed1935504b9 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -92,12 +92,22 @@ int __init efi_memmap_alloc(unsigned int num_entries,
  */
 int __init efi_memmap_install(struct efi_memory_map_data *data)
 {
+	unsigned long size = efi.memmap.desc_size * efi.memmap.nr_map;
+	unsigned long flags = efi.memmap.flags;
+	u64 phys = efi.memmap.phys_map;
+	int ret;
+
 	efi_memmap_unmap();
 
 	if (efi_enabled(EFI_PARAVIRT))
 		return 0;
 
-	return __efi_memmap_init(data);
+	ret = __efi_memmap_init(data);
+	if (ret)
+		return ret;
+
+	__efi_memmap_free(phys, size, flags);
+	return 0;
 }
 
 /**
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 3365944f7965..34109fd86c55 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -15,10 +15,6 @@
 #include <asm/early_ioremap.h>
 #include <asm/efi.h>
 
-#ifndef __efi_memmap_free
-#define __efi_memmap_free(phys, size, flags) do { } while (0)
-#endif
-
 /**
  * __efi_memmap_init - Common code for mapping the EFI memory map
  * @data: EFI memory map data
@@ -51,11 +47,6 @@ int __init __efi_memmap_init(struct efi_memory_map_data *data)
 		return -ENOMEM;
 	}
 
-	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
-		__efi_memmap_free(efi.memmap.phys_map,
-				  efi.memmap.desc_size * efi.memmap.nr_map,
-				  efi.memmap.flags);
-
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;


