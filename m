Return-Path: <stable+bounces-56131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84FD91CDC7
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25F5B214E5
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FFC82862;
	Sat, 29 Jun 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNFNUoaL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D78288C
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674056; cv=none; b=uXPjmzs8tWD9i3jQi2iuxKBH63y298bDstcgQ6CdLTI2DNmTL4ptLAV39Pmw4dQe+bu7imWmDxvuFoIqdHLTSE0gEDUBqe+5Q6yVsDlDWymQHOeWQ5OhWF/d/M1Fq4E33rFaJaHsxphFslzbZK6aLSZVqnNt1UZUPcL248EJRP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674056; c=relaxed/simple;
	bh=XCaqEkyqhrf49VkrqTIXne0Szk/TzuG/ecJG2bD4CmU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LqIC5urLd1fhUPb02MhRD6FRy+wArr2d1rLhVxkSKkapw+xR9+QrmIYjgHAMroGXVRhshfN8cISbUPldZYxwbGdIsVse1pqnfSsNSifQ/igXIV6+xDJUaChlPuglocat4E9WDkpjmxmcrGdfuszDb03/gCqjYurbcThYRWws+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNFNUoaL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63a988bdec8so25102887b3.2
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719674054; x=1720278854; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRZt2tX2o9GEcZGVR8tJFeb1QnVQ4zrsmKhstuIsDTo=;
        b=CNFNUoaLgS4MbZp8bTACwRaGrXFjmboOjMUJZTiIj87GzF0P7IKez2x2tZX4LCmx32
         G2MGDpZ0ejI69hHwxRfOhqmCgnSxDWMZM++AknKIqGYUP/ZoGJ/S1syFRfeaTpuub55i
         fPxMCoxMKKW3IpQRgoOeviIyIYsA2xOjFuCa88tgKXimh8bPkfV0krvHZNh8s5zP0Kg5
         vvOByWNv1A+oaRNVmPY9rOG6hjUoI+aVycJKGOUOg2my7MpLRdHiyOoAzbbVoDYwNvnC
         ZulnsD/BMxDEkZtCIcm118Swen1oIQ98gg73+xoon6y94j9boh5/0j8mL0znyYcMtViu
         BddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719674054; x=1720278854;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRZt2tX2o9GEcZGVR8tJFeb1QnVQ4zrsmKhstuIsDTo=;
        b=Zn35yJRSIyCzedh+x+ZlrreJK0z4qyzQiAJWQuBxvQWozrHnQktikFt/IV0gDqxXPv
         9KTtuZg6w8HPFNam0NKAVG3hU69mztGveQRFG7BLHCCM6/MON89Phw2rqNUDNjNOfOAV
         lbeQREwbyhR6Qf+a7Fg1cAiFk0Z4VfRePvJJVPZqTAM5L8pmgps6+iWFFMM6XOInyNj2
         UFCk1lAixqSYC1qgPbim1PEtJ4mHnGn7MLwHhgjI0xe1hCEvy/H86zhmYb9GACt2NEQk
         /sR5XoUVZnyLOILTYHy/X3kBCBvDhJvLZ1MWQIHRVNHizQLaleNWO5LEEap4i7Kg3XLz
         GxDQ==
X-Gm-Message-State: AOJu0YwhHNBkDpmxUunxyHA0Gae2L8hKbC4hEbgbF9y82YOdvZz1El6N
	hJ2K8KqH68fXd6NFZIRHhu2gBkvkMrI0LAEzYNA1y+GkKZZXbrw4HsVSgvPK0EciSYNF+SJBNNr
	Iv3ygzuqMpAQ/wVQG3ewIjP65d9IIyU8QDieIeyJXjjDNyavWcPKZ0zsqfNKM+fa9d72vsM0IIy
	porpeUMCRsp2FanBzfp5jl5Q==
X-Google-Smtp-Source: AGHT+IGhe421QiwSVsSVWbTkqalkEw4s5KL4q5w5sVRX681CZFR/kUyIuwT1CrG3VS1iVcWGaueEEREc
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:39a:b0:62a:564d:aed1 with SMTP id
 00721157ae682-64c777cc22dmr76207b3.8.1719674053632; Sat, 29 Jun 2024 08:14:13
 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:14:01 +0200
In-Reply-To: <20240629151357.866803-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024062455-glazing-flask-cf0c@gregkh> <20240629151357.866803-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3292; i=ardb@kernel.org;
 h=from:subject; bh=DAo9E+DXOjgwYU8AZDEk4N+5V6j7weMbtrOg0HUXhKM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1BZZfLqiVMZ6SfTG41Mju47/rzEMer7xY93b9oyrncV
 W839V350FHKwiDGwSArpsgiMPvvu52nJ0rVOs+ShZnDygQyhIGLUwAmErCCkeF20fMmqYCNX1rV
 tr4pq7E5NMvw2ub73mt03+S/fGe5dmE1wx/+wt+W0tPfL03ReC3Jujkk+tuGskOP9I4+iunLVX+ +RI0ZAA==
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240629151357.866803-9-ardb+git@google.com>
Subject: [PATCH 5.10.y 4/5] efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on
 all architectures
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit d85e3e34940788578eeffd94e8b7e1d28e7278e9 upstream ]

Currently, the EFI_PARAVIRT flag is only used by Xen dom0 boot on x86,
even though other architectures also support pseudo-EFI boot, where the
core kernel is invoked directly and provided with a set of data tables
that resemble the ones constructed by the EFI stub, which never actually
runs in that case.

Let's fix this inconsistency, and always set this flag when booting dom0
via the EFI boot path. Note that Xen on x86 does not provide the EFI
memory map in this case, whereas other architectures do, so move the
associated EFI_PARAVIRT check into the x86 platform code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c      | 8 +++++---
 arch/x86/platform/efi/memmap.c   | 3 +++
 drivers/firmware/efi/fdtparams.c | 4 ++++
 drivers/firmware/efi/memmap.c    | 3 ---
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 8a26e705cb06..41229bcbe0d9 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -234,9 +234,11 @@ int __init efi_memblock_x86_reserve_range(void)
 	data.desc_size		= e->efi_memdesc_size;
 	data.desc_version	= e->efi_memdesc_version;
 
-	rv = efi_memmap_init_early(&data);
-	if (rv)
-		return rv;
+	if (!efi_enabled(EFI_PARAVIRT)) {
+		rv = efi_memmap_init_early(&data);
+		if (rv)
+			return rv;
+	}
 
 	if (add_efi_memmap || do_efi_soft_reserve())
 		do_add_efi_memmap();
diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 620af26b55c0..241464b6dd03 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -94,6 +94,9 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
 {
 	efi_memmap_unmap();
 
+	if (efi_enabled(EFI_PARAVIRT))
+		return 0;
+
 	return __efi_memmap_init(data);
 }
 
diff --git a/drivers/firmware/efi/fdtparams.c b/drivers/firmware/efi/fdtparams.c
index e901f8564ca0..0ec83ba58097 100644
--- a/drivers/firmware/efi/fdtparams.c
+++ b/drivers/firmware/efi/fdtparams.c
@@ -30,11 +30,13 @@ static __initconst const char name[][22] = {
 
 static __initconst const struct {
 	const char	path[17];
+	u8		paravirt;
 	const char	params[PARAMCOUNT][26];
 } dt_params[] = {
 	{
 #ifdef CONFIG_XEN    //  <-------17------>
 		.path = "/hypervisor/uefi",
+		.paravirt = 1,
 		.params = {
 			[SYSTAB] = "xen,uefi-system-table",
 			[MMBASE] = "xen,uefi-mmap-start",
@@ -121,6 +123,8 @@ u64 __init efi_get_fdt_params(struct efi_memory_map_data *mm)
 			pr_err("Can't find property '%s' in DT!\n", pname);
 			return 0;
 		}
+		if (dt_params[i].paravirt)
+			set_bit(EFI_PARAVIRT, &efi.flags);
 		return systab;
 	}
 notfound:
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index e6256c48284e..a1180461a445 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -39,9 +39,6 @@ int __init __efi_memmap_init(struct efi_memory_map_data *data)
 	struct efi_memory_map map;
 	phys_addr_t phys_map;
 
-	if (efi_enabled(EFI_PARAVIRT))
-		return 0;
-
 	phys_map = data->phys_map;
 
 	if (data->flags & EFI_MEMMAP_LATE)
-- 
2.45.2.803.g4e1b14247a-goog


