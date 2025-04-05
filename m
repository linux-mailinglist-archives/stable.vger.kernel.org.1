Return-Path: <stable+bounces-128378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE4A7C8B5
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 12:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C723B0000
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 10:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A91A4E98;
	Sat,  5 Apr 2025 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="GbwZv5Eb"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184E2E62A0;
	Sat,  5 Apr 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743848315; cv=none; b=APMa34UHbBuaZAgLcNG5GIBVIKJ4JIFSUyEn0GlyZLAvUndqG9HAgKtlv8uHz6VwKqEphtEHa0HPlbxKz/yET5JHgaIJEzmzZvawHg/wqF/WwTzDsnYEEMpoq8jRM4sp/oB376XIQu3V0FTfVGZvebr0Da3NpiDub6bPBKZxHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743848315; c=relaxed/simple;
	bh=IypuKgTLxyWMiKMncuEE745MxIy60JBJBCOJ3LDQkR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mqfK4CNPmGrBjUuN5NbPXmrHTOUGVX+Fsb2vj3fPOEaBwHZ9eKseZf6cb3IhlWg6sGhForUO1qkFF+dZyqa+NzaxjRAJYuWUb7O4g18bvFXM6ml7+STxZoC2IxkHuQYtlwOjbTAlqoxwzOXSzjRmvMWHMId02GgBjcc35F3vDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=GbwZv5Eb; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743848311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+FF1j3m2nFZN9HdZH57mTig2YFbN5qGWD9iMio6Um34=;
	b=GbwZv5Eb+YNsDGz7nSouL617GazWZMeG9Tb1eyVbz33xg3/7/IMisVL5C2tsNT/fr10s5n
	h2QXpLCpM7RxiqxQ0Ffp2vHDNKG8LcCGGJWwPCabYhpdf5SRDSR3f9kRT4vZvubS98fPc9
	xRq5EudfmqmzHaPv+V+yMQLQG6vSJvZxSLbIHYXitMlxVBxD70qsz4tbXh/Iw15ce05SXl
	C4+sblNpCZxdmzNWupHtTf+wMo59iwcRnaXD4aZ28EHy/1BmbmR9lep7QIkVDjWmAXNme0
	hpOK5Gt2zEcwBh8/dMHiVVtSaEAq8WXxPTpWySzXHhDgLdBKJlDcOTjGDF5t4Q==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Sat, 05 Apr 2025 17:18:24 +0700
Subject: [PATCH v2] x86/e820: Fix handling of subpage regions when
 calculating nosave ranges
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250405-fix-e820-nosave-v2-1-d40dbe457c95@qtmlabs.xyz>
X-B4-Tracking: v=1; b=H4sIAG8D8WcC/x2MQQqAIBAAvxJ7bsEkQ/tKdDBbay8aChKIf086D
 sxMhUyJKcM6VEhUOHMMHeQ4gLttuAj57AxSSCVmodDzi6SlwBCzLYReucNoZY1dJujVk6gr/3H
 bW/sA8JeBK2EAAAA=
X-Change-ID: 20250405-fix-e820-nosave-f5cb985a9a61
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
 Roberto Ricci <io@r-ricci.it>, 
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, stable@vger.kernel.org
X-Spamd-Bar: /

The current implementation of e820__register_nosave_regions suffers from
multiple serious issues:
 - The end of last region is tracked by PFN, causing it to find holes
   that aren't there if two consecutive subpage regions are present
 - The nosave PFN ranges derived from holes are rounded out (instead of
   rounded in, which makes it inconsistent with how explicitly reserved
   regions are handled), which may cause us to erroneously mark some
   kernel memory as nosave

Fix this by:
 - Treating reserved regions as if they were holes, to ensure consistent
   handling
 - Tracking the end of the last RAM region by address instead of pages
 - Rounding in (instead of out) the nosave PFN ranges so we never mark
   any kernel memory as nosave

Fixes: e5540f875404 ("x86/boot/e820: Consolidate 'struct e820_entry *entry' local variable names")
Link: https://lore.kernel.org/all/Z_BDbwmFV6wxDPV1@desktop0a/
Tested-by: Roberto Ricci <io@r-ricci.it>
Reported-by: Roberto Ricci <io@r-ricci.it>
Closes: https://lore.kernel.org/all/Z4WFjBVHpndct7br@desktop0a/
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: stable@vger.kernel.org
---
The issue of the kernel failing to resume from hibernation after
kexec_load() is used is likely due to kexec-tools passing in a different
e820 memory map from the one provided by system firmware, causing the
e820 consistency check to fail. That issue is not addressed in this
patch and will need to be fixed in kexec-tools instead.

Changes in v2:
 - Updated author details
 - Rewrote commit message

Link to v1: https://lore.kernel.org/lkml/20250405-fix-e820-nosave-v1-1-162633199548@qtmlabs.xyz/

P.S. Does anybody know how to move b4 (https://b4.docs.kernel.org/)
state between machines?
---
 arch/x86/kernel/e820.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 57120f0749cc3c23844eeb36820705687e08bbf7..656ed7abd28de180b842a8d7993e9708f9f17026 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -753,22 +753,21 @@ void __init e820__memory_setup_extended(u64 phys_addr, u32 data_len)
 void __init e820__register_nosave_regions(unsigned long limit_pfn)
 {
 	int i;
-	unsigned long pfn = 0;
+	u64 last_addr = 0;
 
 	for (i = 0; i < e820_table->nr_entries; i++) {
 		struct e820_entry *entry = &e820_table->entries[i];
 
-		if (pfn < PFN_UP(entry->addr))
-			register_nosave_region(pfn, PFN_UP(entry->addr));
-
-		pfn = PFN_DOWN(entry->addr + entry->size);
-
 		if (entry->type != E820_TYPE_RAM)
-			register_nosave_region(PFN_UP(entry->addr), pfn);
+			continue;
 
-		if (pfn >= limit_pfn)
-			break;
+		if (last_addr < entry->addr)
+			register_nosave_region(PFN_UP(last_addr), PFN_DOWN(entry->addr));
+
+		last_addr = entry->addr + entry->size;
 	}
+
+	register_nosave_region(PFN_UP(last_addr), limit_pfn);
 }
 
 #ifdef CONFIG_ACPI

---
base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963
change-id: 20250405-fix-e820-nosave-f5cb985a9a61

Best regards,
-- 
Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>


