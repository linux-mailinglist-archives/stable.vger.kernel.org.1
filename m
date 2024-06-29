Return-Path: <stable+bounces-56127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D07091CDBE
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47551F228EE
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49682869;
	Sat, 29 Jun 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="26uKtn3S"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6975B05E
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673973; cv=none; b=XLRLyU2RRf0+ySOEf6NC+CLQr9phEHzbrZ5rpfjxctBJXiYcv8StyZYjkRlW0M1H3AizGTpHNoHGIRB+DEB+WDzATzPl2H4jUhjbkMDViUBucBW0CS81hmaBGcCaX2F73ylu/hogVCJJQmGJ00afgYxY3S2BObzlBMTZinMDXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673973; c=relaxed/simple;
	bh=sbq3SZyqFB4zjsbV9DD8VH05ft5TCyS6XDct7iwCBvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ucR6Rqw4ugCJj9GlMZvh9rCPJyYFGrRTMl9vWBAV9soBxVIvraoiPSYbp+3jqgg2rJay748w+xYUVKZph3pCB97HmroaOGisq6TWYvc3KPvmj81uhQ36Lb8mxIhyRMsCJhlKBF3YIHyztTaRZRxLoBnDsGBexQJJwQ9sG6yq0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=26uKtn3S; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f8a1b2969so28323467b3.3
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719673971; x=1720278771; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KiNgzgB+TBpD6Dh5mx5Rcn72v8nlEhJW8Oj8M57zyeY=;
        b=26uKtn3Sg6BgFwzawUZA89aA0QJFg+RNxRUoDzOLfTET3gDocjXz8Bgsic9clazPad
         MuLBlICxzyCE83edUFpkLRB0ytehTyl0TqDCT/FLkHKs4MqM99YR2MgyIm087YCXOGl1
         LEISZo87uWZBPC9SBxdp+AXsZ88c5ocuUKI+uZUF1ZHBmb9tvhf/aSc5CQFWmU6Cfk0q
         5N7b2H6Pip8wt20OrmJkgZhtHK+oAuH1zyLNgMb8DyYhM/XspAVBfDDHHr+dAL2jhJ/Y
         /Z37ha/YTF4xyVTApwbUEBQAjeKzTsKXHNISD7XihcF5BalAXTBhL/j2aGKO241FT9lS
         5d7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719673971; x=1720278771;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiNgzgB+TBpD6Dh5mx5Rcn72v8nlEhJW8Oj8M57zyeY=;
        b=GdxdNGad0beMhtkPQl1ddHQEXUsp7TxjnkVZS/zhGPnqdMdsoW+Xx5rXhna5lWINMD
         /j3qrijh6LW0gdNCP17e5rdYJGKn8jItSClNKxa8BUPgDl/CPnX+AJWIlFo+Wu2EUfg0
         dO4S0eLHEI5q4nT6esM2Ub1AlkFUmug6My1M2UU21LKZLtM2tLkymwmEUQWJmaWbxjCG
         /bT1ZixnGUuf/sSauG0LP/DD+w+D/2SoIwvWq0TyBXbjhbR7icoMsrUq2q2VQCMoejXO
         IBIAN3oKo+/vbGy9PDdPz893xl0c4lRWTsRNUPXMR6lJPndGWj2gJs4PMNMDOg6CG4/p
         Pq5g==
X-Gm-Message-State: AOJu0YybgRFOveE/cYwnqxEc603rMI0pX4WRNsiBuYqX5le4JUzmpxby
	3urWT/4AQEBHHGUHgX7wsZWmlmdBwVDOURKjDuH95s0ueO8xsv1SZkQ6KQqpToncSo4N4T4QUWF
	BIflUwrw5vArSmdFGaZD7oJSySlnYhL0BPYub+1mu2nYCY3oqGRDW6zA4kSTDmWIon1MWm87N0q
	Gkosz0gt1StS9jxdjLRWToAw==
X-Google-Smtp-Source: AGHT+IENBlv0TppHulhCnV9ShaP+NevdLGJgslO9hL7Gy38l7vS76n/9TifB6lApuJGhWmOUs0moN3tr
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:c0e:b0:e03:6556:9fb5 with SMTP id
 3f1490d57ef6-e036ec6958amr157681276.11.1719673971012; Sat, 29 Jun 2024
 08:12:51 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:12:36 +0200
In-Reply-To: <20240629151231.864706-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024062448-overspend-lucid-de35@gregkh> <20240629151231.864706-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4079; i=ardb@kernel.org;
 h=from:subject; bh=mol4ec9czMRk4QH+hX9+dmRRHifMYbOMbaZnymdXAsA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1BJW31+7Wxj12YVq6Q3266UMnJMe/Kh4mlpm/aWA98v
 vn6/hvvjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRK16MDLuOLb74aK5KosHv
 hrMt2pquHCG5dWwqHM/EwsvnCq18vpGR4crzd5XT/LWYvdhvrOHZfOfv//SrgdHn5bRvFLKsdcn q4QQA
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240629151231.864706-10-ardb+git@google.com>
Subject: [PATCH 5.15.y 5/5] efi/x86: Free EFI memory map only when installing
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
index 680784da359f..e7c07a182ebd 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -390,7 +390,6 @@ extern int __init efi_memmap_alloc(unsigned int num_entries,
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


