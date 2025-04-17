Return-Path: <stable+bounces-133082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D00A91C28
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3765443706
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9C2472A7;
	Thu, 17 Apr 2025 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JbsidN9I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC80245024
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892855; cv=none; b=KXxHPNqZb2XATdHCcRj8o8diDP4RrhdRtjbpvF5mpbP/k3pN9GElJNUyzM26VtM+ppLkAA7nJJIKPmq7tlPIfqWn/P9qm+NK73xjJvEteLVch5nC/SrqP8OBJ+OloQnjdBDJF+M5HXpFSpO/oSw/p4q/2/c0744uQKnGcVQYJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892855; c=relaxed/simple;
	bh=j3Zm3FWHWVQHQHRXkwUXkmr5eEyEB0jw0oW2FaMmflA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YOlUswarb4hTNsaTGycdwlyLpGVsc7HJsvBHjCjtIxr9kJOi6xOgPlgQEPoMdg9YGYDUKNwA1GfbFlSdJoBeSk+3h5i1dS3CEyHLfYeUrRdW60nvVdpONTMvVGzyi+nV1x86bUsxJMjifIYQfJC+T6x3WhOifwmHvl6NxK/I1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JbsidN9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D011CC4CEE4;
	Thu, 17 Apr 2025 12:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744892855;
	bh=j3Zm3FWHWVQHQHRXkwUXkmr5eEyEB0jw0oW2FaMmflA=;
	h=Subject:To:Cc:From:Date:From;
	b=JbsidN9I1PVrP+ZROW3rIf56XgGwTAdO6pC+/N5WbDgNOzJb94cPjge98SecPFDK2
	 C98D/jmyO2eKS98gzqZPFP0a72Cjbis7ktEZZvOna8smqqYDs2ZCbzO9VyWlkQtGEn
	 9tAvPu2XYbmcwMM1JzJsDS9GB5an0HOVEX/H/mFA=
Subject: FAILED: patch "[PATCH] x86/e820: Fix handling of subpage regions when calculating" failed to apply to 5.4-stable tree
To: myrrhperiwinkle@qtmlabs.xyz,ardb@kernel.org,dwmw@amazon.co.uk,hpa@zytor.com,io@r-ricci.it,keescook@chromium.org,len.brown@intel.com,mingo@kernel.org,rafael.j.wysocki@intel.com,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 14:24:57 +0200
Message-ID: <2025041757-drum-wispy-ef78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f2f29da9f0d4367f6ff35e0d9d021257bb53e273
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041757-drum-wispy-ef78@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2f29da9f0d4367f6ff35e0d9d021257bb53e273 Mon Sep 17 00:00:00 2001
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Date: Sun, 6 Apr 2025 11:45:22 +0700
Subject: [PATCH] x86/e820: Fix handling of subpage regions when calculating
 nosave ranges in e820__register_nosave_regions()

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

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 57120f0749cc..9d8dd8deb2a7 100644
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


