Return-Path: <stable+bounces-56126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEC91CDBB
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE76282830
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CA682862;
	Sat, 29 Jun 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2i9Gxoc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B880043
	for <stable@vger.kernel.org>; Sat, 29 Jun 2024 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719673971; cv=none; b=HD9MkWbVaOy3MC5Yv5Rihgrt9vIpanJgOkOw9iiPqbPg170wx4efMxTtonJdCF72wnJcC+Hrz/gsfhGWiS8xNQZa9FRuaCLIfU6nKLu/ccHZJJKu0VwD9Y3l+K5QOoAamVhxVvmy3WswieS0FIQwbmXprhFORqDf7ndMohdbvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719673971; c=relaxed/simple;
	bh=ZWMSCnSFQyCo1O6rwM5UDjUHXE2Rfj/Z5EXxTB4FBXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sR8b1LhWebv7Zpnc99KD2R1uA3faJ47QKidDfI630NH9qKj8YekxWBZDudLWH6wAFjn+U/7RiBatQVU9SoLr9dNnwyhKZYKeMObNM1vWmYn4bGPnpOWk6keZLO/NEKQsvV7z7tDeb2GtE6I4uvWEv3HHJFRy/Q6l/d4kTSF4fGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2i9Gxoc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-424a775ee7fso12000745e9.0
        for <stable@vger.kernel.org>; Sat, 29 Jun 2024 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719673969; x=1720278769; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+0sRBsXMJQ7ObxHHs1JAVIl5/uyQndrp2Z8uLSF6z8=;
        b=H2i9GxocnQlHoJQyObInH43RiSRfH4UO0HRjc6r7HaY6QB6MdLU15h0MFlFLDWyZne
         F84/t8gfpZaLN5HI0zbgLsOXYDKb88GiPJK3ieL0gjpXGQF6k7BYajWBb3NyTsMEAIGQ
         Geyqp0BmSEMPvhq9IRl75rT9ElwqZm9IxLZF6ZeqsiPpfEqjBPUvPu8lTEJe+/wGjUUc
         xGhR1ZkLmlDYfgxPM3nfIH97RwR254Uq7JtCCsHAnyi04W98h/xGQzQeTxeUJ9Ye9Lp3
         T0MQUFAW4wuO5tQ/sIDWE3Iwzm+LiLWpWZLP2CnokirLdtWP7yiI9ax51Ulhw1dd0lP6
         gOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719673969; x=1720278769;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+0sRBsXMJQ7ObxHHs1JAVIl5/uyQndrp2Z8uLSF6z8=;
        b=ZlrRFngQKAvuy1qo3fVVR66Xp6GMY/XdyurDF3qRJf8Ca2h0FnYz4mP3IzE31q2f2o
         1CW7uXMOfhKIh8ZfAf9lOAQGVdcRWHw2Icp+qjwAZGEitZveFSC7D0C6capOaVrnViKJ
         4BGmdGU9jSxYVp9UY72dLnOtstYYzOkF7jZugr71y8accxVn4rs/z9qxVlCzCeUXlwkb
         6gbhas4u3eKFGO81Msiv6arKs/sy4xtIJUesm9qytiqz0eZ4wAA29w+VhgOHMQigAY/t
         4iTjCifXqEwV8RPy9gObPrqBKBC7Mouxvl6Zd8qrxRnXW3Tvi2SrPI+6kg3/Qp89+gVl
         yuAQ==
X-Gm-Message-State: AOJu0Yyhr/wDkW/9Kc3bzrjNEcCKhNK93Nj2BR0vGexEF8GTZBThRiFP
	0phG9iSFQUNQi5e+SrLCHhbxWkvgqoVfKjt5/yaOMweLqRalkb+tSwUDKmtbOSot+LyCA0X80zn
	lGgDiDRjOPCW2Wo3HfxCB1FYqAxC14moZT4ckRC0PG0JHzLOFw4+/DTrhsHEPzwC04zyJr5b0E8
	y8ufqFyexWRaVXHyNCOFqSEQ==
X-Google-Smtp-Source: AGHT+IGsSV2hggvzJ+0uRGVPUX/6rkVG7z0QTFUSmvogjkWlDwT5V51wZ0ZVy4swGu6EoyAqE+TAK8yp
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1c9f:b0:424:a573:9cac with SMTP id
 5b1f17b1804b1-4257a046cbfmr23805e9.5.1719673968595; Sat, 29 Jun 2024 08:12:48
 -0700 (PDT)
Date: Sat, 29 Jun 2024 17:12:35 +0200
In-Reply-To: <20240629151231.864706-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024062448-overspend-lucid-de35@gregkh> <20240629151231.864706-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3292; i=ardb@kernel.org;
 h=from:subject; bh=7gHe4nRb00mHTba43fSdb3Oc1IItwJf9AQLuhKUQ/aA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1BJaV90UMR6dAGj6lr3LP6arO4koK/pinUsD3g/G0we
 Ul3WVBHKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmMipqYwMy5N26uaX295+bTLJ
 /MT5e1YJ06SEF5x4eHydK+u6W4+jNRkZlm48doHLLFsv0WP9WqECU5u1xp6Zz9n3mJjsl/6yxs2 DDwA=
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240629151231.864706-9-ardb+git@google.com>
Subject: [PATCH 5.15.y 4/5] efi: xen: Set EFI_PARAVIRT for Xen dom0 boot on
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
index 147c30a81f15..da17de248387 100644
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


