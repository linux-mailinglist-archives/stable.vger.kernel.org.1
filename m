Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6228F779D5D
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 07:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjHLFy5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 01:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjHLFy5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 01:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA202D44
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 22:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA684640C5
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 05:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6121C433C8;
        Sat, 12 Aug 2023 05:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691819694;
        bh=Cu+EUZUwGMppZ5OzzZi5fKIZQoKKxnG0FoTCItIOBtA=;
        h=Subject:To:Cc:From:Date:From;
        b=VGcNxuKpu8nDzt2+dSCh7l4BgvEQVCi76o+9HhZhOggm2tXdGSpN+8Gd3z5N6sOwq
         fOfdVe38jl2wYIIFpo4NIBGLjci/9C4XJqwotugFna83w3j8pk4WykHzXmdzElWtae
         vS8wnJTbBzuVuCpRk44flRoxhEHn5bnCHR2EYdIg=
Subject: FAILED: patch "[PATCH] riscv,mmio: Fix readX()-to-delay() ordering" failed to apply to 4.19-stable tree
To:     parri.andrea@gmail.com, palmer@rivosinc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 07:54:42 +0200
Message-ID: <2023081242-take-crabgrass-6e98@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 4eb2eb1b4c0eb07793c240744843498564a67b83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081242-take-crabgrass-6e98@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

4eb2eb1b4c0e ("riscv,mmio: Fix readX()-to-delay() ordering")
0c3ac28931d5 ("riscv: separate MMIO functions into their own header file")
b012980d1c6e ("riscv/mmiowb: Hook up mmwiob() implementation to asm-generic code")
3d8dfe75ef69 ("Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4eb2eb1b4c0eb07793c240744843498564a67b83 Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Thu, 3 Aug 2023 06:27:38 +0200
Subject: [PATCH] riscv,mmio: Fix readX()-to-delay() ordering

Section 2.1 of the Platform Specification [1] states:

  Unless otherwise specified by a given I/O device, I/O devices are on
  ordering channel 0 (i.e., they are point-to-point strongly ordered).

which is not sufficient to guarantee that a readX() by a hart completes
before a subsequent delay() on the same hart (cf. memory-barriers.txt,
"Kernel I/O barrier effects").

Set the I(nput) bit in __io_ar() to restore the ordering, align inline
comments.

[1] https://github.com/riscv/riscv-platform-specs

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Link: https://lore.kernel.org/r/20230803042738.5937-1-parri.andrea@gmail.com
Fixes: fab957c11efe ("RISC-V: Atomic and Locking Code")
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index aff6c33ab0c0..4c58ee7f95ec 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -101,9 +101,9 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * Relaxed I/O memory access primitives. These follow the Device memory
  * ordering rules but do not guarantee any ordering relative to Normal memory
  * accesses.  These are defined to order the indicated access (either a read or
- * write) with all other I/O memory accesses. Since the platform specification
- * defines that all I/O regions are strongly ordered on channel 2, no explicit
- * fences are required to enforce this ordering.
+ * write) with all other I/O memory accesses to the same peripheral. Since the
+ * platform specification defines that all I/O regions are strongly ordered on
+ * channel 0, no explicit fences are required to enforce this ordering.
  */
 /* FIXME: These are now the same as asm-generic */
 #define __io_rbr()		do {} while (0)
@@ -125,14 +125,14 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #endif
 
 /*
- * I/O memory access primitives. Reads are ordered relative to any
- * following Normal memory access. Writes are ordered relative to any prior
- * Normal memory access.  The memory barriers here are necessary as RISC-V
+ * I/O memory access primitives.  Reads are ordered relative to any following
+ * Normal memory read and delay() loop.  Writes are ordered relative to any
+ * prior Normal memory write.  The memory barriers here are necessary as RISC-V
  * doesn't define any ordering between the memory space and the I/O space.
  */
 #define __io_br()	do {} while (0)
-#define __io_ar(v)	__asm__ __volatile__ ("fence i,r" : : : "memory")
-#define __io_bw()	__asm__ __volatile__ ("fence w,o" : : : "memory")
+#define __io_ar(v)	({ __asm__ __volatile__ ("fence i,ir" : : : "memory"); })
+#define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); })
 #define __io_aw()	mmiowb_set_pending()
 
 #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })

