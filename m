Return-Path: <stable+bounces-55062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED9A915484
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E921F21988
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A919E7F0;
	Mon, 24 Jun 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KuItX4Nz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DF19E7EC
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247318; cv=none; b=SaWJwpCEF6JkoVt3QoxMtEF8s4kLejep3wE0zFFdvFJr2M3FBYsQJnM23L8njR0UYnK9YdQInLqiSw4kH19wu/iFYxNy7Em4HR9LxIGVZ2OAM9W5aLrEKIsWF+VaaIfQtPug83L1fkrTcSrL5IhfkaLGu1WCzLCdAaaE01bOXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247318; c=relaxed/simple;
	bh=zLhoIUUYnGwqwhNBTfHYrb+Tpg8bN+jbcRqnasfoWlM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S8rGIUTrQ56r4zNchs2SqnQXT1RmSdOBK3BhD0NXXJSKKTPIKKipSKG/nYrL+Ykv+zLAkYZ9BmZ8o3alUE4PhhfrITQ86njBsULC2QR6DMeOqRbkVUm+PIFo/+QQRd7d+fEZZ3UhoXNYE82YM3o7HypMv9n+2cGCBF/Qkyr2XW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KuItX4Nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B68C2BBFC;
	Mon, 24 Jun 2024 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719247318;
	bh=zLhoIUUYnGwqwhNBTfHYrb+Tpg8bN+jbcRqnasfoWlM=;
	h=Subject:To:Cc:From:Date:From;
	b=KuItX4NzUdswA1Fmm2s4AJmW1PRpomKs0AMEGo3Rr4V7KITX51oTMvdwPqXockCmR
	 gpQV9YJL/sGvVK3ymiHlrsDbqEXnoOE4JSelhBoczwtfLoPmRalfL0aLmTKvopegoH
	 5O88bsLCXd6fM/LsKoXYM7qYS/4R2O0XH12V9sIA=
Subject: FAILED: patch "[PATCH] efi/x86: Free EFI memory map only when installing a new one." failed to apply to 6.1-stable tree
To: ardb@kernel.org,Ashish.Kalra@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:40:43 +0200
Message-ID: <2024062442-bonfire-detonator-1b17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 75dde792d6f6c2d0af50278bd374bf0c512fe196
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062442-bonfire-detonator-1b17@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

75dde792d6f6 ("efi/x86: Free EFI memory map only when installing a new one.")
d85e3e349407 ("efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on all architectures")
fdc6d38d64a2 ("efi: memmap: Move manipulation routines into x86 arch tree")

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


