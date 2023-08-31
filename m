Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A578EBAD
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbjHaLM2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345978AbjHaLMY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:12:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880210EB
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39F91B82257
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECEFC433CB;
        Thu, 31 Aug 2023 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480324;
        bh=rYPyeNBZZRcYRM4Xf79FDUB13xWXaN3ZM6ZeHi9NGE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKQDxUtskGuIe4/LPn2xskp9hEfjhINhKEcINFPQjTw/xJf4OMNfSOyaUccwFZ3jI
         1ou94WUKPbPtUW1xWbiYtaDgOQFbamx1giUQEyJJyKHYwIPFqJGHYB19nShEjGQQvW
         5u2KpqDn7GKIoXo+CbzsehdZhS2oti4MLvjj+MU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Borislav Petkov <bp@suse.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 06/10] lockdep: fix static memory detection even more
Date:   Thu, 31 Aug 2023 13:10:46 +0200
Message-ID: <20230831110831.303801551@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
References: <20230831110831.079963475@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 0a6b58c5cd0dfd7961e725212f0fc8dfc5d96195 upstream.

On the parisc architecture, lockdep reports for all static objects which
are in the __initdata section (e.g. "setup_done" in devtmpfs,
"kthreadd_done" in init/main.c) this warning:

	INFO: trying to register non-static key.

The warning itself is wrong, because those objects are in the __initdata
section, but the section itself is on parisc outside of range from
_stext to _end, which is why the static_obj() functions returns a wrong
answer.

While fixing this issue, I noticed that the whole existing check can
be simplified a lot.
Instead of checking against the _stext and _end symbols (which include
code areas too) just check for the .data and .bss segments (since we check a
data object). This can be done with the existing is_kernel_core_data()
macro.

In addition objects in the __initdata section can be checked with
init_section_contains(), and is_kernel_rodata() allows keys to be in the
_ro_after_init section.

This partly reverts and simplifies commit bac59d18c701 ("x86/setup: Fix static
memory detection").

Link: https://lkml.kernel.org/r/ZNqrLRaOi/3wPAdp@p100
Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/sections.h |   18 ------------------
 kernel/locking/lockdep.c        |   36 ++++++++++++++----------------------
 2 files changed, 14 insertions(+), 40 deletions(-)

--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_SECTIONS_H
 #define _ASM_X86_SECTIONS_H
 
-#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
-
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
 
@@ -18,20 +16,4 @@ extern char __end_of_kernel_reserve[];
 
 extern unsigned long _brk_start, _brk_end;
 
-static inline bool arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	/*
-	 * If _brk_start has not been cleared, brk allocation is incomplete,
-	 * and we can not make assumptions about its use.
-	 */
-	if (_brk_start)
-		return 0;
-
-	/*
-	 * After brk allocation is complete, space between _brk_end and _end
-	 * is available for allocation.
-	 */
-	return addr >= _brk_end && addr < (unsigned long)&_end;
-}
-
 #endif	/* _ASM_X86_SECTIONS_H */
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -817,34 +817,26 @@ static int very_verbose(struct lock_clas
  * Is this the address of a static object:
  */
 #ifdef __KERNEL__
-/*
- * Check if an address is part of freed initmem. After initmem is freed,
- * memory can be allocated from it, and such allocations would then have
- * addresses within the range [_stext, _end].
- */
-#ifndef arch_is_kernel_initmem_freed
-static int arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	if (system_state < SYSTEM_FREEING_INITMEM)
-		return 0;
-
-	return init_section_contains((void *)addr, 1);
-}
-#endif
-
 static int static_obj(const void *obj)
 {
-	unsigned long start = (unsigned long) &_stext,
-		      end   = (unsigned long) &_end,
-		      addr  = (unsigned long) obj;
+	unsigned long addr = (unsigned long) obj;
 
-	if (arch_is_kernel_initmem_freed(addr))
-		return 0;
+	if (is_kernel_core_data(addr))
+		return 1;
+
+	/*
+	 * keys are allowed in the __ro_after_init section.
+	 */
+	if (is_kernel_rodata(addr))
+		return 1;
 
 	/*
-	 * static variable?
+	 * in initdata section and used during bootup only?
+	 * NOTE: On some platforms the initdata section is
+	 * outside of the _stext ... _end range.
 	 */
-	if ((addr >= start) && (addr < end))
+	if (system_state < SYSTEM_FREEING_INITMEM &&
+		init_section_contains((void *)addr, 1))
 		return 1;
 
 	/*


