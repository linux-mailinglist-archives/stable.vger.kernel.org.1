Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545AD78AAF3
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjH1K0c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjH1K0D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:26:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9D124
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:25:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 912196301F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B42CC433C8;
        Mon, 28 Aug 2023 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218355;
        bh=OuP7usjN01nD5FMZQ+FArYInrfWUtyaMB40L6N9aKds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wjV0hxhkUDlbEwaHiihkuW8Zvo0gsnt/NHt7u9/5c00hkd4GXhG5cwAywHDzhirnf
         oCAlUtN/99OKNW/hJxSgBuWbr1JATxVybHDhL1x8UQ7geCeqv3HEqRzLad4L8tBuv3
         KSZrVkohQLawgtTy0rvDq4jtXuUtFmSipuDKG6Ls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/129] powerpc: Move page table dump files in a dedicated subdirectory
Date:   Mon, 28 Aug 2023 12:12:03 +0200
Message-ID: <20230828101154.158524758@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit e66c3209c7fd17209ccc4cbbee8b1b1bd5c438dd ]

This patch moves the files related to page table dump in a
dedicated subdirectory.

The purpose is to clean a bit arch/powerpc/mm by regrouping
multiple files handling a dedicated function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: Shorten the file names while we're at it]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Stable-dep-of: 66b2ca086210 ("powerpc/64s/radix: Fix soft dirty tracking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Kconfig.debug                             |  4 ----
 arch/powerpc/mm/Makefile                               | 10 +---------
 .../mm/{dump_linuxpagetables-8xx.c => ptdump/8xx.c}    |  2 +-
 arch/powerpc/mm/ptdump/Makefile                        |  9 +++++++++
 arch/powerpc/mm/{dump_bats.c => ptdump/bats.c}         |  0
 .../book3s64.c}                                        |  2 +-
 .../{dump_hashpagetable.c => ptdump/hashpagetable.c}   |  0
 .../mm/{dump_linuxpagetables.c => ptdump/ptdump.c}     |  2 +-
 .../mm/{dump_linuxpagetables.h => ptdump/ptdump.h}     |  0
 arch/powerpc/mm/{dump_sr.c => ptdump/segment_regs.c}   |  0
 .../shared.c}                                          |  2 +-
 11 files changed, 14 insertions(+), 17 deletions(-)
 rename arch/powerpc/mm/{dump_linuxpagetables-8xx.c => ptdump/8xx.c} (97%)
 create mode 100644 arch/powerpc/mm/ptdump/Makefile
 rename arch/powerpc/mm/{dump_bats.c => ptdump/bats.c} (100%)
 rename arch/powerpc/mm/{dump_linuxpagetables-book3s64.c => ptdump/book3s64.c} (98%)
 rename arch/powerpc/mm/{dump_hashpagetable.c => ptdump/hashpagetable.c} (100%)
 rename arch/powerpc/mm/{dump_linuxpagetables.c => ptdump/ptdump.c} (99%)
 rename arch/powerpc/mm/{dump_linuxpagetables.h => ptdump/ptdump.h} (100%)
 rename arch/powerpc/mm/{dump_sr.c => ptdump/segment_regs.c} (100%)
 rename arch/powerpc/mm/{dump_linuxpagetables-generic.c => ptdump/shared.c} (97%)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 923b3b794d13f..1f54bb93b5cc7 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -368,10 +368,6 @@ config PPC_PTDUMP
 
 	  If you are unsure, say N.
 
-config PPC_HTDUMP
-	def_bool y
-	depends on PPC_PTDUMP && PPC_BOOK3S_64
-
 config PPC_FAST_ENDIAN_SWITCH
 	bool "Deprecated fast endian-switch syscall"
         depends on DEBUG_KERNEL && PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 8ace67f002752..d4648a1e6e6c1 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -42,13 +42,5 @@ obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
 obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
-obj-$(CONFIG_PPC_PTDUMP)	+= dump_linuxpagetables.o
-ifdef CONFIG_PPC_PTDUMP
-obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
-obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
-obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_bats.o dump_sr.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= dump_linuxpagetables-book3s64.o
-endif
-obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
+obj-$(CONFIG_PPC_PTDUMP)	+= ptdump/
 obj-$(CONFIG_PPC_MEM_KEYS)	+= pkeys.o
diff --git a/arch/powerpc/mm/dump_linuxpagetables-8xx.c b/arch/powerpc/mm/ptdump/8xx.c
similarity index 97%
rename from arch/powerpc/mm/dump_linuxpagetables-8xx.c
rename to arch/powerpc/mm/ptdump/8xx.c
index 33f52a97975b4..80b4f73f7fdc2 100644
--- a/arch/powerpc/mm/dump_linuxpagetables-8xx.c
+++ b/arch/powerpc/mm/ptdump/8xx.c
@@ -7,7 +7,7 @@
 #include <linux/kernel.h>
 #include <asm/pgtable.h>
 
-#include "dump_linuxpagetables.h"
+#include "ptdump.h"
 
 static const struct flag_info flag_array[] = {
 	{
diff --git a/arch/powerpc/mm/ptdump/Makefile b/arch/powerpc/mm/ptdump/Makefile
new file mode 100644
index 0000000000000..712762be3cb11
--- /dev/null
+++ b/arch/powerpc/mm/ptdump/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y	+= ptdump.o
+
+obj-$(CONFIG_4xx)		+= shared.o
+obj-$(CONFIG_PPC_8xx)		+= 8xx.o
+obj-$(CONFIG_PPC_BOOK3E_MMU)	+= shared.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= shared.o bats.o segment_regs.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= book3s64.o hashpagetable.o
diff --git a/arch/powerpc/mm/dump_bats.c b/arch/powerpc/mm/ptdump/bats.c
similarity index 100%
rename from arch/powerpc/mm/dump_bats.c
rename to arch/powerpc/mm/ptdump/bats.c
diff --git a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c b/arch/powerpc/mm/ptdump/book3s64.c
similarity index 98%
rename from arch/powerpc/mm/dump_linuxpagetables-book3s64.c
rename to arch/powerpc/mm/ptdump/book3s64.c
index a637e612b2055..0bce5b85d0112 100644
--- a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
+++ b/arch/powerpc/mm/ptdump/book3s64.c
@@ -7,7 +7,7 @@
 #include <linux/kernel.h>
 #include <asm/pgtable.h>
 
-#include "dump_linuxpagetables.h"
+#include "ptdump.h"
 
 static const struct flag_info flag_array[] = {
 	{
diff --git a/arch/powerpc/mm/dump_hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
similarity index 100%
rename from arch/powerpc/mm/dump_hashpagetable.c
rename to arch/powerpc/mm/ptdump/hashpagetable.c
diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/ptdump/ptdump.c
similarity index 99%
rename from arch/powerpc/mm/dump_linuxpagetables.c
rename to arch/powerpc/mm/ptdump/ptdump.c
index 6aa41669ac1ae..76be98988578d 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -28,7 +28,7 @@
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
-#include "dump_linuxpagetables.h"
+#include "ptdump.h"
 
 #ifdef CONFIG_PPC32
 #define KERN_VIRT_START	0
diff --git a/arch/powerpc/mm/dump_linuxpagetables.h b/arch/powerpc/mm/ptdump/ptdump.h
similarity index 100%
rename from arch/powerpc/mm/dump_linuxpagetables.h
rename to arch/powerpc/mm/ptdump/ptdump.h
diff --git a/arch/powerpc/mm/dump_sr.c b/arch/powerpc/mm/ptdump/segment_regs.c
similarity index 100%
rename from arch/powerpc/mm/dump_sr.c
rename to arch/powerpc/mm/ptdump/segment_regs.c
diff --git a/arch/powerpc/mm/dump_linuxpagetables-generic.c b/arch/powerpc/mm/ptdump/shared.c
similarity index 97%
rename from arch/powerpc/mm/dump_linuxpagetables-generic.c
rename to arch/powerpc/mm/ptdump/shared.c
index fed6923bcb46e..1cda3d91c6c26 100644
--- a/arch/powerpc/mm/dump_linuxpagetables-generic.c
+++ b/arch/powerpc/mm/ptdump/shared.c
@@ -7,7 +7,7 @@
 #include <linux/kernel.h>
 #include <asm/pgtable.h>
 
-#include "dump_linuxpagetables.h"
+#include "ptdump.h"
 
 static const struct flag_info flag_array[] = {
 	{
-- 
2.40.1



