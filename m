Return-Path: <stable+bounces-137722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD98AA14E3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077F7984CF3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AD92522B4;
	Tue, 29 Apr 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D1FIy5dO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F652522A8;
	Tue, 29 Apr 2025 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946931; cv=none; b=eZJBn7ZaCMR6a2oWecSjpN+pSzMhDP5+LnFUuktNAU1i5nu2GX1ukWXEqgOJ3xsgLkBmNz8UzTR81NoZcJtUcZJnP97bHAbsTsT+0dBTnnJleF2O8De4+n6XOpVsV22CjOujHvAc961e/YFGpUz3CzQmsyloJOvsh2CLqwnpjh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946931; c=relaxed/simple;
	bh=eJQGIT/41MSTHtppLjhWaLlc7lJGEYvNte1EnTpba9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzDvJr/sYzDz1Rv0X5W4ky5nZxzRzIBDieXxLpv0Uw3tR4NBJQtpM/9SRE63FjwpWsMcISBS09rgxM9XgThr2py4pCgyciosfVTYwjphtHNsY0yTFaQ6Fdm8EnKOozHuzxmkVEujfOiPAx62gbaSBmMD7jQOMMozwFnnwPpTk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D1FIy5dO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236EEC4CEE3;
	Tue, 29 Apr 2025 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946930;
	bh=eJQGIT/41MSTHtppLjhWaLlc7lJGEYvNte1EnTpba9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1FIy5dOo3r2jWA9XANw+mOHoUmUzb0wsvaCWhyBEPOZLdeZe9bbDRXXtbHry5Xb0
	 LTT+0EYJAhID5SyI7YBogy9e5c0h5O3JVgIYb5CSZ+9fFABrYYdN1u4XIHMrNst6Jm
	 NviZZabvATyKhXfravR3MntkXamttlzFt0MFiI8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roberto Ricci <io@r-ricci.it>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Ingo Molnar <mingo@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 5.10 098/286] x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()
Date: Tue, 29 Apr 2025 18:40:02 +0200
Message-ID: <20250429161111.886272162@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

commit f2f29da9f0d4367f6ff35e0d9d021257bb53e273 upstream.

While debugging kexec/hibernation hangs and crashes, it turned out that
the current implementation of e820__register_nosave_regions() suffers from
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

These bugs appear to have been introduced about ~18 years ago with the very
first version of e820_mark_nosave_regions(), and its flawed assumptions were
carried forward uninterrupted through various waves of rewrites and renames.

[ mingo: Added Git archeology details, for kicks and giggles. ]

Fixes: e8eff5ac294e ("[PATCH] Make swsusp avoid memory holes and reserved memory regions on x86_64")
Reported-by: Roberto Ricci <io@r-ricci.it>
Tested-by: Roberto Ricci <io@r-ricci.it>
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Len Brown <len.brown@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz
Closes: https://lore.kernel.org/all/Z4WFjBVHpndct7br@desktop0a/
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/e820.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -753,22 +753,21 @@ void __init e820__memory_setup_extended(
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
 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
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



