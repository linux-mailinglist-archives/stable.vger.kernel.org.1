Return-Path: <stable+bounces-128411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32644A7CCCB
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 06:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAF718927DB
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9F535D8;
	Sun,  6 Apr 2025 04:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="g4IrN4pR"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889022318;
	Sun,  6 Apr 2025 04:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743914739; cv=none; b=NhimNaFriNgKp+vYOBA8FLyCwIyHkB/WKnysnfteoHesACctbbEuvdi9rE45hkJvg3UxIwxBBXn4NYuaGnAhbQ6bP+S9kaSfBYmUUqZg0QN56JKvuK1kwtgxrYN+IPD79Wq+OPYvMqig3yXe88pGjt0yW9XXI4H8qpv+6P8nxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743914739; c=relaxed/simple;
	bh=v1IinF67iWEI3SL0lQdGyv7sKQ9mf5O9fWWyX4/ZKbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FLudeEYi4BIyJl+4BST07IgInupKXjInpY2WfltzGLaYbNRTY816//pvncemmqI/0IMg125Q3VUvmGBghFH0hV9yFiwbmVZc4dg5udQzSMWIrgec3GXRaEpEJdI/6taiGAyljC5eFzKl/GOFI9StMawhn+2uDtM8pivNB64N/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=g4IrN4pR; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1743914728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uoVhE1qlSxrJ5jASWtYn/iQM6ppYP4JEjakbYTIa38s=;
	b=g4IrN4pRoAbHougKGN/Zzb9PLjiyFjsn1QVXoL3RwZgVbuSNpLbmCqbdi+sTgLm2Q57Cv4
	MWCsa6pPoKVmnKmPYgQImvpdDNK3ePBSAkhEvQYpwGyV1R5cbQbWxLfCx0wpdtbAxrQWdz
	qAtksWUqSei/U1IzrU7iCUwAo5k21QgRAgRS01DwPNP/jKYHMOok6IWowCPxeSgAQvBsf/
	lKf6QEkz5lukPpB7p0VU+68glFTPrDOOhzkWGWPkCdE6evYfkpc5NMoXrdnpsQKKUYd6UY
	KUSjF9TzA+RzTeThg2heX3VJhsAroRt+6P8+MK/gz+1qnJ567L5l/3Tc4to9Pg==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Sun, 06 Apr 2025 11:45:22 +0700
Subject: [PATCH v3] x86/e820: Fix handling of subpage regions when
 calculating nosave ranges
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz>
X-B4-Tracking: v=1; b=H4sIAOEG8mcC/3WNwQ6CMBBEf4Xs2TWlUgVP/ofh0JZFNlGKLWlA0
 n+3cvf4JjNvNgjkmQJciw08RQ7sxgynQwF20OODkLvMIIVUohIKe16QailwdEFHwl5Z09RKN/p
 cQl5NnnJlN97bzAOH2fl1P4jyl/53RYkldpXoDFXqYht1e8+vpzbhuKwfaFNKX+FC9JmwAAAA
X-Change-ID: 20250405-fix-e820-nosave-f5cb985a9a61
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Roberto Ricci <io@r-ricci.it>, 
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
X-Spamd-Bar: /

The current implementation of e820__register_nosave_regions suffers from
multiple serious issues:
 - The end of last region is tracked by PFN, causing it to find holes
   that aren't there if two consecutive subpage regions are present
 - The nosave PFN ranges derived from holes are rounded out (instead of
   rounded in) which makes it inconsistent with how explicitly reserved
   regions are handled

Fix this by:
 - Treating reserved regions as if they were holes, to ensure consistent
   handling (rounding out nosave PFN ranges is more correct as the
   kernel does not use partial pages)
 - Tracking the end of the last RAM region by address instead of pages
   to detect holes more precisely

Cc: stable@vger.kernel.org
Fixes: e5540f875404 ("x86/boot/e820: Consolidate 'struct e820_entry *entry' local variable names")
Reported-by: Roberto Ricci <io@r-ricci.it>
Closes: https://lore.kernel.org/all/Z4WFjBVHpndct7br@desktop0a/
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
---
The issue of the kernel failing to resume from hibernation after
kexec_load() is used is likely due to kexec-tools passing in a different
e820 memory map from the one provided by system firmware, causing the
e820 consistency check to fail. That issue is not addressed in this
patch and will need to be fixed in kexec-tools instead.

Changes in v3:
- Round out nosave PFN ranges since the kernel does not use partial
  pages
- Link to v2: https://lore.kernel.org/r/20250405-fix-e820-nosave-v2-1-d40dbe457c95@qtmlabs.xyz

Changes in v2:
- Updated author details
- Rewrote commit message
- Link to v1: https://lore.kernel.org/r/20250405-fix-e820-nosave-v1-1-162633199548@qtmlabs.xyz
---
 arch/x86/kernel/e820.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 57120f0749cc3c23844eeb36820705687e08bbf7..9d8dd8deb2a702bd34b961ca4f5eba8a8d9643d0 100644
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
+			register_nosave_region(PFN_DOWN(last_addr), PFN_UP(entry->addr));
+
+		last_addr = entry->addr + entry->size;
 	}
+
+	register_nosave_region(PFN_DOWN(last_addr), limit_pfn);
 }
 
 #ifdef CONFIG_ACPI

---
base-commit: a8662bcd2ff152bfbc751cab20f33053d74d0963
change-id: 20250405-fix-e820-nosave-f5cb985a9a61

Best regards,
-- 
Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>


