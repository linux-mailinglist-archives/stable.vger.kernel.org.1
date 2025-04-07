Return-Path: <stable+bounces-128593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E3A7E84C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 19:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B336B188FEC8
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675A921B9E1;
	Mon,  7 Apr 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xOnqdr91";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sj50TaCR"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C0217727;
	Mon,  7 Apr 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046982; cv=none; b=PWUEJD60kzDBSML1WkMrDRTa3AxzwRL1Z2tIaAQvp0YWBucqdqg55HrAIhvxZ6m7Vv5e/M6UX9gOTiM2dTVdloaR8qxa75s/pcvreXWvrVSFenPhPv7052OokuUcKWORAQpE+F78EhNA+tm9KqxB7g7PyGCpdcLUVNLMztgV5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046982; c=relaxed/simple;
	bh=Ae7s0sZ4Zx6k346VjblLIi165drnn7cUExdqbW77Dos=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QjTR8ocFkbEhE+Ag/lCY9koiu6VChcS/Hy2CyKisxHkuC6yDkYtmdp/+br6DjpWs0xNNDZRvhByw4+YAK7JBJDujDmFuPeQidpYbElEBNkIr3IclCPT9CJz6JS2zGhugiWQZO/h5ya8MZO2aUM10isg7KWx9C9/uhkO5dtcnfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xOnqdr91; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sj50TaCR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 17:29:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744046977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYJveTcpMfqH/k0+ktUtmw8ttCMVtye0N3XZidpAX3Y=;
	b=xOnqdr91qssa5q23OLcemwEDw6REShJwFYdyL0M2O2uGhO0RXZjbh6YhLuntwChcs7g9v+
	m/sdD7Pt4hOZ/unsT8TNO31dBJ83y7J4Ep3SHqqklK3uDYO8GeMlhTKx87kuGs+F2jRFzf
	V1b2bL7192YjWR8avTy5NPytcpL/6Nx3RsCb6PH+7fh++gIdHMOwVTqjDEp61XnnivwhED
	cMcNnDEjTskSZv4YghI02y6HxoLTRet7nFfbJpg4yhV6iXMh7N8ewW7rAwjMICe4omGVgH
	7XON9NPD5paezd7WRZKawKYkEKPfzVrCHz38s7fyrOoSy7HPRUmD7XbZVf90mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744046977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYJveTcpMfqH/k0+ktUtmw8ttCMVtye0N3XZidpAX3Y=;
	b=Sj50TaCRC7qjymRx3tpsBP/xoryPB35N2+K5HAYsFaqel2CWWVXZNrsu4FCTkZd+21OhN2
	hf8q/tDyCqv92vAw==
From: "tip-bot2 for Myrrh Periwinkle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/e820: Fix handling of subpage regions when
 calculating nosave ranges in e820__register_nosave_regions()
Cc: Roberto Ricci <io@r-ricci.it>,
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
 Ingo Molnar <mingo@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ard Biesheuvel <ardb@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Len Brown <len.brown@intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz>
References: <20250406-fix-e820-nosave-v3-1-f3787bc1ee1d@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174404697318.31282.6099676690393066740.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f2f29da9f0d4367f6ff35e0d9d021257bb53e273
Gitweb:        https://git.kernel.org/tip/f2f29da9f0d4367f6ff35e0d9d021257bb53e273
Author:        Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
AuthorDate:    Sun, 06 Apr 2025 11:45:22 +07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 07 Apr 2025 19:20:08 +02:00

x86/e820: Fix handling of subpage regions when calculating nosave ranges in e820__register_nosave_regions()

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
---
 arch/x86/kernel/e820.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 57120f0..9d8dd8d 100644
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

