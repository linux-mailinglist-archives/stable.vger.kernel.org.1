Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64637A819C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjITMrF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjITMrD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:47:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF63E4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:46:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6966FC433CA;
        Wed, 20 Sep 2023 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214013;
        bh=NQffnzqy9e8ri+pHRVyyRut5dgUKllk13f1iUxdfEtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzRZQiDoHaH2Cw9H66fVYEyDuwLDnqXsLjpLGgNCR9GTw8558cqif8z8vV7FHVrSn
         9gr24KqAuWCFStyhjhbjlfPP+dd5r4mW5jRYGNSd6OQdfGpn//Sbu29gOkSJteIHRQ
         8HVFOMIWcUDIlI+1ZvAY6YSxuAKUeRZnd+4Yu/Zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aaron Lu <aaron.lu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 080/110] x86/boot/compressed: Reserve more memory for page tables
Date:   Wed, 20 Sep 2023 13:32:18 +0200
Message-ID: <20230920112833.416079316@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

[ Upstream commit f530ee95b72e77b09c141c4b1a4b94d1199ffbd9 ]

The decompressor has a hard limit on the number of page tables it can
allocate. This limit is defined at compile-time and will cause boot
failure if it is reached.

The kernel is very strict and calculates the limit precisely for the
worst-case scenario based on the current configuration. However, it is
easy to forget to adjust the limit when a new use-case arises. The
worst-case scenario is rarely encountered during sanity checks.

In the case of enabling 5-level paging, a use-case was overlooked. The
limit needs to be increased by one to accommodate the additional level.
This oversight went unnoticed until Aaron attempted to run the kernel
via kexec with 5-level paging and unaccepted memory enabled.

Update wost-case calculations to include 5-level paging.

To address this issue, let's allocate some extra space for page tables.
128K should be sufficient for any use-case. The logic can be simplified
by using a single value for all kernel configurations.

[ Also add a warning, should this memory run low - by Dave Hansen. ]

Fixes: 34bbb0009f3b ("x86/boot/compressed: Enable 5-level paging during decompression stage")
Reported-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915070221.10266-1-kirill.shutemov@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/ident_map_64.c |  8 +++++
 arch/x86/include/asm/boot.h             | 45 +++++++++++++++++--------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0943b82..575d881ff86e2 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -67,6 +67,14 @@ static void *alloc_pgt_page(void *context)
 		return NULL;
 	}
 
+	/* Consumed more tables than expected? */
+	if (pages->pgt_buf_offset == BOOT_PGT_SIZE_WARN) {
+		debug_putstr("pgt_buf running low in " __FILE__ "\n");
+		debug_putstr("Need to raise BOOT_PGT_SIZE?\n");
+		debug_putaddr(pages->pgt_buf_offset);
+		debug_putaddr(pages->pgt_buf_size);
+	}
+
 	entry = pages->pgt_buf + pages->pgt_buf_offset;
 	pages->pgt_buf_offset += PAGE_SIZE;
 
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea31..215d37f7dde8a 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -40,23 +40,40 @@
 #ifdef CONFIG_X86_64
 # define BOOT_STACK_SIZE	0x4000
 
+/*
+ * Used by decompressor's startup_32() to allocate page tables for identity
+ * mapping of the 4G of RAM in 4-level paging mode:
+ * - 1 level4 table;
+ * - 1 level3 table;
+ * - 4 level2 table that maps everything with 2M pages;
+ *
+ * The additional level5 table needed for 5-level paging is allocated from
+ * trampoline_32bit memory.
+ */
 # define BOOT_INIT_PGT_SIZE	(6*4096)
-# ifdef CONFIG_RANDOMIZE_BASE
+
 /*
- * Assuming all cross the 512GB boundary:
- * 1 page for level4
- * (2+2)*4 pages for kernel, param, cmd_line, and randomized kernel
- * 2 pages for first 2M (video RAM: CONFIG_X86_VERBOSE_BOOTUP).
- * Total is 19 pages.
+ * Total number of page tables kernel_add_identity_map() can allocate,
+ * including page tables consumed by startup_32().
+ *
+ * Worst-case scenario:
+ *  - 5-level paging needs 1 level5 table;
+ *  - KASLR needs to map kernel, boot_params, cmdline and randomized kernel,
+ *    assuming all of them cross 256T boundary:
+ *    + 4*2 level4 table;
+ *    + 4*2 level3 table;
+ *    + 4*2 level2 table;
+ *  - X86_VERBOSE_BOOTUP needs to map the first 2M (video RAM):
+ *    + 1 level4 table;
+ *    + 1 level3 table;
+ *    + 1 level2 table;
+ * Total: 28 tables
+ *
+ * Add 4 spare table in case decompressor touches anything beyond what is
+ * accounted above. Warn if it happens.
  */
-#  ifdef CONFIG_X86_VERBOSE_BOOTUP
-#   define BOOT_PGT_SIZE	(19*4096)
-#  else /* !CONFIG_X86_VERBOSE_BOOTUP */
-#   define BOOT_PGT_SIZE	(17*4096)
-#  endif
-# else /* !CONFIG_RANDOMIZE_BASE */
-#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
-# endif
+# define BOOT_PGT_SIZE_WARN	(28*4096)
+# define BOOT_PGT_SIZE		(32*4096)
 
 #else /* !CONFIG_X86_64 */
 # define BOOT_STACK_SIZE	0x1000
-- 
2.40.1



