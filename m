Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D70C78EBAF
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbjHaLMd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242224AbjHaLMb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E7DE54
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E696A63C46
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C68C433C8;
        Thu, 31 Aug 2023 11:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480333;
        bh=96ULxTedOjx8ApPsbCOdjfBbZhyPtgAZZ9cRfV7CPLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XS1uOASrsbGg7mSDifiRHgd7zIGKszor9BVrFT8GC7OXarOxWiaTMHUAe9SIXp2nt
         FLQaj9FMKR/GVTIxO43V2wVyjPIVH6WNeIPwkHd3gbogjNLKFzXYUdXgP+NYkuf5bZ
         pYuJEdZaSzzwyZno5azP3Ex3IxfWOM+8Bu+9h+hw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Vidra.Jonas@seznam.cz, Sam James <sam@gentoo.org>,
        John David Anglin <dave.anglin@bell.net>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 09/10] io_uring/parisc: Adjust pgoff in io_uring mmap() for parisc
Date:   Thu, 31 Aug 2023 13:10:49 +0200
Message-ID: <20230831110831.423681984@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
References: <20230831110831.079963475@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

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
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 io_uring/io_uring.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -72,6 +72,7 @@
 #include <linux/io_uring.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <asm/shmparam.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
@@ -3110,6 +3111,49 @@ static __cold int io_uring_mmap(struct f
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
@@ -3324,6 +3368,8 @@ static const struct file_operations io_u
 #ifndef CONFIG_MMU
 	.get_unmapped_area = io_uring_nommu_get_unmapped_area,
 	.mmap_capabilities = io_uring_nommu_mmap_capabilities,
+#else
+	.get_unmapped_area = io_uring_mmu_get_unmapped_area,
 #endif
 	.poll		= io_uring_poll,
 #ifdef CONFIG_PROC_FS


