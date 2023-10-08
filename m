Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECDB7BCD18
	for <lists+stable@lfdr.de>; Sun,  8 Oct 2023 09:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjJHHzP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 8 Oct 2023 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344503AbjJHHzO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Oct 2023 03:55:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F7CF
        for <stable@vger.kernel.org>; Sun,  8 Oct 2023 00:55:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985B9C433C8;
        Sun,  8 Oct 2023 07:55:10 +0000 (UTC)
Date:   Sun, 8 Oct 2023 09:55:07 +0200
From:   Helge Deller <deller@gmx.de>
To:     gregkh@linuxfoundation.org
Cc:     dave@parisc-linux.org, dave.anglin@bell.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] parisc: Restore __ldcw_align for PA-RISC
 2.0 processors" failed to apply to 6.1-stable tree
Message-ID: <ZSJgW3xJ1xj0RwhB@p100>
References: <2023100802-occupant-unsalted-d02b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100802-occupant-unsalted-d02b@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

* gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>:
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Hi Greg,

below is the manually adjusted patch which applies cleanly to kernel
4.14-stable and up to kernel 6.1-stable.
(commit 914988e099fc658436fbd7b8f240160c352b6552 upstream.)

Thanks!
Helge


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
index 3eb4bfc1fb36..5ed52819e956 100644
--- a/arch/parisc/include/asm/ldcw.h
+++ b/arch/parisc/include/asm/ldcw.h
@@ -2,14 +2,28 @@
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
 #define __PA_LDCW_ALIGN_ORDER	4
@@ -19,22 +33,12 @@
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
index 42979c5704dc..82d2384c3f22 100644
--- a/arch/parisc/include/asm/spinlock_types.h
+++ b/arch/parisc/include/asm/spinlock_types.h
@@ -3,13 +3,8 @@
 #define __ASM_SPINLOCK_TYPES_H
 
 typedef struct {
-#ifdef CONFIG_PA20
-	volatile unsigned int slock;
-# define __ARCH_SPIN_LOCK_UNLOCKED { 1 }
-#else
 	volatile unsigned int lock[4];
 # define __ARCH_SPIN_LOCK_UNLOCKED	{ { 1, 1, 1, 1 } }
-#endif
 } arch_spinlock_t;
 
 typedef struct {
