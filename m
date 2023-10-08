Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482A37BCC60
	for <lists+stable@lfdr.de>; Sun,  8 Oct 2023 07:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344388AbjJHFaS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 8 Oct 2023 01:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344363AbjJHFaR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Oct 2023 01:30:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F111B6
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 22:30:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF919C433C7;
        Sun,  8 Oct 2023 05:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696743016;
        bh=U5SKE8rwthfqOqciiv4lkM4rR+WeqK4vqSiHWTld+ec=;
        h=Subject:To:Cc:From:Date:From;
        b=H482XNiubjndrytVeVTeh/HXSwYvp58WgptNTA6gAbCy0Y8w1LcDPTJ/MZv3d/yYx
         D3hkP8eg8GDNjExv9IkPDIDOf8Shdlff9BYKOlWdr0iFQ+5ePA59z8cMzlReXNXyQa
         M5Sub388rt35wBYkLk6Ej6aBDXWsTo/SMs6Yicgw=
Subject: FAILED: patch "[PATCH] parisc: Restore __ldcw_align for PA-RISC 2.0 processors" failed to apply to 5.4-stable tree
To:     dave@parisc-linux.org, dave.anglin@bell.net, deller@gmx.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 08 Oct 2023 07:30:06 +0200
Message-ID: <2023100806-award-delirium-71f7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 914988e099fc658436fbd7b8f240160c352b6552
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100806-award-delirium-71f7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

914988e099fc ("parisc: Restore __ldcw_align for PA-RISC 2.0 processors")
15e64ef6520e ("parisc: Add lightweight spinlock checks")
4aae683f1327 ("tracing: Refactor TRACE_IRQFLAGS_SUPPORT in Kconfig")
113616ec5b64 ("hexagon: select ARCH_WANT_LD_ORPHAN_WARN")
63703f37aa09 ("mm: generalize ZONE_[DMA|DMA32]")
ca6e51d592d2 ("arm64/Kconfig: introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE")
91024b3ce247 ("mm: generalize ARCH_ENABLE_MEMORY_[HOTPLUG|HOTREMOVE]")
c2280be81de4 ("mm: generalize ARCH_HAS_CACHE_LINE_SIZE")
7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
18107f8a2df6 ("arm64: Support execute-only permissions with Enhanced PAN")
07fb6dc327f1 ("arm64/mm: Drop redundant ARCH_WANT_HUGE_PMD_SHARE")
591fd30eee47 ("Merge branch 'work.elf-compat' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 914988e099fc658436fbd7b8f240160c352b6552 Mon Sep 17 00:00:00 2001
From: John David Anglin <dave@parisc-linux.org>
Date: Tue, 19 Sep 2023 17:51:40 +0000
Subject: [PATCH] parisc: Restore __ldcw_align for PA-RISC 2.0 processors

Back in 2005, Kyle McMartin removed the 16-byte alignment for
ldcw semaphores on PA 2.0 machines (CONFIG_PA20). This broke
spinlocks on pre PA8800 processors. The main symptom was random
faults in mmap'd memory (e.g., gcc compilations, etc).

Unfortunately, the errata for this ldcw change is lost.

The issue is the 16-byte alignment required for ldcw semaphore
instructions can only be reduced to natural alignment when the
ldcw operation can be handled coherently in cache. Only PA8800
and PA8900 processors actually support doing the operation in
cache.

Aligning the spinlock dynamically adds two integer instructions
to each spinlock.

Tested on rp3440, c8000 and a500.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Link: https://lore.kernel.org/linux-parisc/6b332788-2227-127f-ba6d-55e99ecf4ed8@bell.net/T/#t
Link: https://lore.kernel.org/linux-parisc/20050609050702.GB4641@roadwarrior.mcmartin.ca/
Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/arch/parisc/include/asm/ldcw.h b/arch/parisc/include/asm/ldcw.h
index 6d28b5514699..ee9e071859b2 100644
--- a/arch/parisc/include/asm/ldcw.h
+++ b/arch/parisc/include/asm/ldcw.h
@@ -2,39 +2,42 @@
 #ifndef __PARISC_LDCW_H
 #define __PARISC_LDCW_H
 
-#ifndef CONFIG_PA20
 /* Because kmalloc only guarantees 8-byte alignment for kmalloc'd data,
    and GCC only guarantees 8-byte alignment for stack locals, we can't
    be assured of 16-byte alignment for atomic lock data even if we
    specify "__attribute ((aligned(16)))" in the type declaration.  So,
    we use a struct containing an array of four ints for the atomic lock
    type and dynamically select the 16-byte aligned int from the array
-   for the semaphore.  */
+   for the semaphore. */
+
+/* From: "Jim Hull" <jim.hull of hp.com>
+   I've attached a summary of the change, but basically, for PA 2.0, as
+   long as the ",CO" (coherent operation) completer is implemented, then the
+   16-byte alignment requirement for ldcw and ldcd is relaxed, and instead
+   they only require "natural" alignment (4-byte for ldcw, 8-byte for
+   ldcd).
+
+   Although the cache control hint is accepted by all PA 2.0 processors,
+   it is only implemented on PA8800/PA8900 CPUs. Prior PA8X00 CPUs still
+   require 16-byte alignment. If the address is unaligned, the operation
+   of the instruction is undefined. The ldcw instruction does not generate
+   unaligned data reference traps so misaligned accesses are not detected.
+   This hid the problem for years. So, restore the 16-byte alignment dropped
+   by Kyle McMartin in "Remove __ldcw_align for PA-RISC 2.0 processors". */
 
 #define __PA_LDCW_ALIGNMENT	16
-#define __PA_LDCW_ALIGN_ORDER	4
 #define __ldcw_align(a) ({					\
 	unsigned long __ret = (unsigned long) &(a)->lock[0];	\
 	__ret = (__ret + __PA_LDCW_ALIGNMENT - 1)		\
 		& ~(__PA_LDCW_ALIGNMENT - 1);			\
 	(volatile unsigned int *) __ret;			\
 })
-#define __LDCW	"ldcw"
 
-#else /*CONFIG_PA20*/
-/* From: "Jim Hull" <jim.hull of hp.com>
-   I've attached a summary of the change, but basically, for PA 2.0, as
-   long as the ",CO" (coherent operation) completer is specified, then the
-   16-byte alignment requirement for ldcw and ldcd is relaxed, and instead
-   they only require "natural" alignment (4-byte for ldcw, 8-byte for
-   ldcd). */
-
-#define __PA_LDCW_ALIGNMENT	4
-#define __PA_LDCW_ALIGN_ORDER	2
-#define __ldcw_align(a) (&(a)->slock)
+#ifdef CONFIG_PA20
 #define __LDCW	"ldcw,co"
-
-#endif /*!CONFIG_PA20*/
+#else
+#define __LDCW	"ldcw"
+#endif
 
 /* LDCW, the only atomic read-write operation PA-RISC has. *sigh*.
    We don't explicitly expose that "*a" may be written as reload
diff --git a/arch/parisc/include/asm/spinlock_types.h b/arch/parisc/include/asm/spinlock_types.h
index efd06a897c6a..7b986b09dba8 100644
--- a/arch/parisc/include/asm/spinlock_types.h
+++ b/arch/parisc/include/asm/spinlock_types.h
@@ -9,15 +9,10 @@
 #ifndef __ASSEMBLY__
 
 typedef struct {
-#ifdef CONFIG_PA20
-	volatile unsigned int slock;
-# define __ARCH_SPIN_LOCK_UNLOCKED { __ARCH_SPIN_LOCK_UNLOCKED_VAL }
-#else
 	volatile unsigned int lock[4];
 # define __ARCH_SPIN_LOCK_UNLOCKED	\
 	{ { __ARCH_SPIN_LOCK_UNLOCKED_VAL, __ARCH_SPIN_LOCK_UNLOCKED_VAL, \
 	    __ARCH_SPIN_LOCK_UNLOCKED_VAL, __ARCH_SPIN_LOCK_UNLOCKED_VAL } }
-#endif
 } arch_spinlock_t;
 
 

