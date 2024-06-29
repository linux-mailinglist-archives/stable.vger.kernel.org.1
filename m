Return-Path: <stable+bounces-56132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5907F91CDC6
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1579F282D1D
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865148286B;
	Sat, 29 Jun 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noHCHDbm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274682869
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674058; cv=none; b=KrrfeLT5LOFxUhzRR7We3WEIdX8jOjzkWppH/E7paIwMFSfnYEplCavOrHu1q8Sra3I23EJ4K81hx2Ye3b/J++TaU0UNRypE+FhFUuxtfl13ecSc0fzmufGo1UVL8fP7zYtfoOx7V3zGLjTN9XpQIsbvALYCSO4GQLt9nSRXa/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674058; c=relaxed/simple;
	bh=R7jVlI2sYj81gYUKvAZP/4TkXuc9ZJF9BYGPreKR/IQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fPX664roiX1TFuZNJaNzKHyfvWfO49MY0wvEVzIDuGXezPXN+GFTnYQDTeqaBy2/a/cP5vGHUQla4Vbor3bXZxfNEBtCDeqo+Maj8yT5ORdZxeAkdlIGb5ATgRzvooPdPGyiNIKXbXduS1+/XutJ9P6N4KO4MVB2uaDCLAVNhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noHCHDbm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6479d38bdfaso32345997b3.0
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719674056; x=1720278856; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SR8yJy6YNzmn4nu52ab9V4UMzKI/wjLUv+e4kHA8UGc=;
        b=noHCHDbmgTbl9/zQrW5s+ckb0LgoDLwg3qp08JQMHo9fNSd9BIDSBfjFFvl5DC5TyK
         drJvUb5K/v625SGnco9vO+S7UuZKoUIS0LagMYHdCIzSpr/y2FaHXFd8AHdf2Dfs/McM
         aam3+a5xRbF7AVBew82RrtbiiN/WUElaznS+iPJXHpJoWAhBNmZhT/im2cg0ZuwBFWLa
         i0kibZHFZ6GVEs6GrUgsqhf1BZTXurcCpc1x8DI6t6xmJcpq970DrQZwWgsMEIcOz3Yr
         4YIdBBrs0FaxnTzMBmkNQ7FiMsPH74esku1FwsdGnR2m9u7KcqM7XdsfxxeRCkVjIMTL
         15/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719674056; x=1720278856;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SR8yJy6YNzmn4nu52ab9V4UMzKI/wjLUv+e4kHA8UGc=;
        b=Ci7wGmBJfMwhC/YVeCBbfWDh/uc0CILwtyK817TSKpA6whj6NRF2/2Z4fLCy4UwL9l
         Hp2q0T0AYMrzomEniDW/pgkfFAmIR4pjf2awe4P28NJ0r9cFo251YnR2HMlRhcyGNiu6
         /VY3/2bDKD6L2GtMGw+eKlrtrk+cx/T3P47eTWu0D9ifKOHBao8+n5gbPUxaKlzUIYc/
         QMqq73XaQckWwN9XexzgXqiuV3bisA0jR8UQLgrUAtHP27l0V2+9GfRWM0xHhUW/j1Vn
         IR9yQNz6DdFkhOVc99WK53w1C2BT02wIlZ46W12KWJ8yoYPL8YXWrEhzEXGJZcuDUV7F
         C/Hg==
X-Gm-Message-State: AOJu0Yz1foX19jcysqlEL2MXlsddXkytYbgVQCbcIx/ZSOAvWjLZ5Cmq
	N+G5MoNTn6qJL1VikVXtuAxaIn0TzSw6ORYmYAl90c3Z9yBCZiXpoLIwCr4pJAdrmfP+NSBcjvv
	tfSJpb5ekxx7vSZJyLedpmFL0/R4g5pmPkDL2RtS9UtYci/f5Zz/pvV8qAI546t+9eKzrG/iSxj
	5bImmOuIHcq50x4KFTWRSGow==
X-Google-Smtp-Source: AGHT+IF3jNEuASlZjJiYt+ki97hgTBT/d+lcA0ckUQiMUsWxRvN+6SY1NtUsjOVWtgZ+5ZN5Rcu3R/so
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:298e:b0:e03:54e2:4ca2 with SMTP id
 3f1490d57ef6-e036eb1b316mr3409276.4.1719674055932; Sat, 29 Jun 2024 08:14:15
 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:14:02 +0200
In-Reply-To: <20240629151357.866803-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024062455-glazing-flask-cf0c@gregkh> <20240629151357.866803-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4079; i=ardb@kernel.org;
 h=from:subject; bh=8/1AFZ0RtNic4xi7Lfu9TdbQnyG1DmT3hkAsZj5rzaw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1BZfcCe+tTBlzczFqCWxNa34sdbZn04HDJFOPzB//lT
 lN4PGtXRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIjH5GhsbMu/tL/vj8v7Al
 mt3Da+rBC087XsdUfNn7k+H2triq7skM//RO+J5dezppruaymxkrww48szrttffchyXd06qUn7D n72QAAA==
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240629151357.866803-10-ardb+git@google.com>
Subject: [PATCH 5.10.y 5/5] efi/x86: Free EFI memory map only when installing
 a new one.
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 75dde792d6f6c2d0af50278bd374bf0c512fe196 upstream ]

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
---
 arch/x86/include/asm/efi.h     |  1 -
 arch/x86/platform/efi/memmap.c | 12 +++++++++++-
 drivers/firmware/efi/memmap.c  |  9 ---------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 01c0410ae97a..7c675832712d 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -386,7 +386,6 @@ extern int __init efi_memmap_alloc(unsigned int num_entries,
 				   struct efi_memory_map_data *data);
 extern void __efi_memmap_free(u64 phys, unsigned long size,
 			      unsigned long flags);
-#define __efi_memmap_free __efi_memmap_free
 
 extern int __init efi_memmap_install(struct efi_memory_map_data *data);
 extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 241464b6dd03..872d310c426e 100644
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
index a1180461a445..77dd20f9df31 100644
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
-- 
2.45.2.803.g4e1b14247a-goog


