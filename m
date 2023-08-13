Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8153177ABC9
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjHMVZp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjHMVZo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E16910F5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5B1A62947
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF67BC433C7;
        Sun, 13 Aug 2023 21:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961945;
        bh=Voc/z56ludH7cMbTRV4Gn8QSgPht4EgCGug6G1acmEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfPWAuU2c9dBjLVaP7EBz7FQ+2ub8n3qkdctaRGKnWG/3/Y7Q1QIcbUct5+W1WjH/
         GAFMqMuJrnck3rbRwfG3+oRaWDbEmjsdQToFsQ8OADEpsOllHXYnuBtZiWZrv9T5P7
         74rVX8EnjRZaOZNEBL2tJxThy2mL6l4EmBR4lWlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.4 028/206] io_uring/parisc: Adjust pgoff in io_uring mmap() for parisc
Date:   Sun, 13 Aug 2023 23:16:38 +0200
Message-ID: <20230813211725.807909427@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Helge Deller <deller@gmx.de>

commit 56675f8b9f9b15b024b8e3145fa289b004916ab7 upstream.

The changes from commit 32832a407a71 ("io_uring: Fix io_uring mmap() by
using architecture-provided get_unmapped_area()") to the parisc
implementation of get_unmapped_area() broke glibc's locale-gen
executable when running on parisc.

This patch reverts those architecture-specific changes, and instead
adjusts in io_uring_mmu_get_unmapped_area() the pgoff offset which is
then given to parisc's get_unmapped_area() function.  This is much
cleaner than the previous approach, and we still will get a coherent
addresss.

This patch has no effect on other architectures (SHM_COLOUR is only
defined on parisc), and the liburing testcase stil passes on parisc.

Cc: stable@vger.kernel.org # 6.4
Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Fixes: 32832a407a71 ("io_uring: Fix io_uring mmap() by using architecture-provided get_unmapped_area()")
Fixes: d808459b2e31 ("io_uring: Adjust mapping wrt architecture aliasing requirements")
Link: https://lore.kernel.org/r/ZNEyGV0jyI8kOOfz@p100
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/sys_parisc.c |   15 +++++----------
 io_uring/io_uring.c             |    3 +++
 2 files changed, 8 insertions(+), 10 deletions(-)

--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -26,17 +26,12 @@
 #include <linux/compat.h>
 
 /*
- * Construct an artificial page offset for the mapping based on the virtual
+ * Construct an artificial page offset for the mapping based on the physical
  * address of the kernel file mapping variable.
- * If filp is zero the calculated pgoff value aliases the memory of the given
- * address. This is useful for io_uring where the mapping shall alias a kernel
- * address and a userspace adress where both the kernel and the userspace
- * access the same memory region.
  */
-#define GET_FILP_PGOFF(filp, addr)		\
-	((filp ? (((unsigned long) filp->f_mapping) >> 8)	\
-		 & ((SHM_COLOUR-1) >> PAGE_SHIFT) : 0UL)	\
-	  + (addr >> PAGE_SHIFT))
+#define GET_FILP_PGOFF(filp)		\
+	(filp ? (((unsigned long) filp->f_mapping) >> 8)	\
+		 & ((SHM_COLOUR-1) >> PAGE_SHIFT) : 0UL)
 
 static unsigned long shared_align_offset(unsigned long filp_pgoff,
 					 unsigned long pgoff)
@@ -116,7 +111,7 @@ static unsigned long arch_get_unmapped_a
 	do_color_align = 0;
 	if (filp || (flags & MAP_SHARED))
 		do_color_align = 1;
-	filp_pgoff = GET_FILP_PGOFF(filp, addr);
+	filp_pgoff = GET_FILP_PGOFF(filp);
 
 	if (flags & MAP_FIXED) {
 		/* Even MAP_FIXED mappings must reside within TASK_SIZE */
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3466,6 +3466,8 @@ static unsigned long io_uring_mmu_get_un
 	 * - use the kernel virtual address of the shared io_uring context
 	 *   (instead of the userspace-provided address, which has to be 0UL
 	 *   anyway).
+	 * - use the same pgoff which the get_unmapped_area() uses to
+	 *   calculate the page colouring.
 	 * For architectures without such aliasing requirements, the
 	 * architecture will return any suitable mapping because addr is 0.
 	 */
@@ -3474,6 +3476,7 @@ static unsigned long io_uring_mmu_get_un
 	pgoff = 0;	/* has been translated to ptr above */
 #ifdef SHM_COLOUR
 	addr = (uintptr_t) ptr;
+	pgoff = addr >> PAGE_SHIFT;
 #else
 	addr = 0UL;
 #endif


