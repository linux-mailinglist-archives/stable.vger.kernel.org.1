Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6278BA7A
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 23:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjH1V4a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 17:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjH1V4F (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 17:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F410C;
        Mon, 28 Aug 2023 14:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 699B061935;
        Mon, 28 Aug 2023 21:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7126C433C7;
        Mon, 28 Aug 2023 21:55:58 +0000 (UTC)
Date:   Mon, 28 Aug 2023 23:55:55 +0200
From:   Helge Deller <deller@gmx.de>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-parisc@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Vidra.Jonas@seznam.cz, Sam James <sam@gentoo.org>,
        John David Anglin <dave.anglin@bell.net>
Subject: [STABLE] stable backport request for 6.1 for io_uring
Message-ID: <ZO0X64s72JpFJnRM@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        HEXHASH_WORD,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Greg, Hello Jens, Hello stable team,

would you please accept some backports to v6.1-stable for io_uring()?
io_uring() fails on parisc because of some missing upstream patches.
Since 6.1 is currently used in debian and gentoo as main kernel we
face some build errors due to the missing patches.

Here are the 3 steps I'm asking for (for kernel 6.1-stable only, the others are OK):

1) cherry-pick this upstream commit:
	commit 567b35159e76997e95b643b9a8a5d9d2198f2522
	Author: John David Anglin <dave@parisc-linux.org>
	Date:   Sun Feb 26 18:03:33 2023 +0000
	parisc: Cleanup mmap implementation regarding color alignment

2) cherry-pick this upstream commit:
	commit b5d89408b9fb21258f7c371d6d48a674f60f7181
	Author: Helge Deller <deller@gmx.de>
	Date:   Fri Jun 30 12:36:09 2023 +0200
	parisc: sys_parisc: parisc_personality() is called from asm code

3) apply the patch below as manual backport:
I think this is the least invasive change and I wasn't able to otherwise
simply pull in the upstream patches without touching code I don't want
to touch (and keep life easier for Jens if he wants to backport other
patches later).

Thanks!
Helge


From: Helge Deller <deller@gmx.de>
Date: Mon, 28 Aug 2023 23:07:49 +0200
Subject: [PATCH] io_uring/parisc: Adjust pgoff in io_uring mmap() for parisc

Vidra Jonas reported issues on parisc with libuv which then triggers
build errors with cmake. Debugging shows that those issues stem from
io_uring().

I was not able to easily pull in upstream commits directly, so here
is IMHO the least invasive manual backport of the following upstream
commits to fix the cache aliasing issues on parisc on kernel 6.1
with io_uring:

56675f8b9f9b ("io_uring/parisc: Adjust pgoff in io_uring mmap() for parisc")
32832a407a71 ("io_uring: Fix io_uring mmap() by using architecture-provided get_unmapped_area()")
d808459b2e31 ("io_uring: Adjust mapping wrt architecture aliasing requirements")

With this patch kernel 6.1 has all relevant mmap changes and is
identical to kernel 6.5 with regard to mmap() in io_uring.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: Vidra.Jonas@seznam.cz
Link: https://lore.kernel.org/linux-parisc/520.NvTX.6mXZpmfh4Ju.1awpAS@seznam.cz/
Cc: Sam James <sam@gentoo.org>
Cc: John David Anglin <dave.anglin@bell.net>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ed8e9deae284..b0e47fe1eb4b 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -72,6 +72,7 @@
 #include <linux/io_uring.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <asm/shmparam.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
@@ -3110,6 +3111,49 @@ static __cold int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
 
+static unsigned long io_uring_mmu_get_unmapped_area(struct file *filp,
+			unsigned long addr, unsigned long len,
+			unsigned long pgoff, unsigned long flags)
+{
+	void *ptr;
+
+	/*
+	 * Do not allow to map to user-provided address to avoid breaking the
+	 * aliasing rules. Userspace is not able to guess the offset address of
+	 * kernel kmalloc()ed memory area.
+	 */
+	if (addr)
+		return -EINVAL;
+
+	ptr = io_uring_validate_mmap_request(filp, pgoff, len);
+	if (IS_ERR(ptr))
+		return -ENOMEM;
+
+	/*
+	 * Some architectures have strong cache aliasing requirements.
+	 * For such architectures we need a coherent mapping which aliases
+	 * kernel memory *and* userspace memory. To achieve that:
+	 * - use a NULL file pointer to reference physical memory, and
+	 * - use the kernel virtual address of the shared io_uring context
+	 *   (instead of the userspace-provided address, which has to be 0UL
+	 *   anyway).
+	 * - use the same pgoff which the get_unmapped_area() uses to
+	 *   calculate the page colouring.
+	 * For architectures without such aliasing requirements, the
+	 * architecture will return any suitable mapping because addr is 0.
+	 */
+	filp = NULL;
+	flags |= MAP_SHARED;
+	pgoff = 0;	/* has been translated to ptr above */
+#ifdef SHM_COLOUR
+	addr = (uintptr_t) ptr;
+	pgoff = addr >> PAGE_SHIFT;
+#else
+	addr = 0UL;
+#endif
+	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+}
+
 #else /* !CONFIG_MMU */
 
 static int io_uring_mmap(struct file *file, struct vm_area_struct *vma)
@@ -3324,6 +3368,8 @@ static const struct file_operations io_uring_fops = {
 #ifndef CONFIG_MMU
 	.get_unmapped_area = io_uring_nommu_get_unmapped_area,
 	.mmap_capabilities = io_uring_nommu_mmap_capabilities,
+#else
+	.get_unmapped_area = io_uring_mmu_get_unmapped_area,
 #endif
 	.poll		= io_uring_poll,
 #ifdef CONFIG_PROC_FS
