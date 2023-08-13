Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3687C77ACA5
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjHMVf0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjHMVf0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:35:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B8810DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 884C761E35
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE19C433C7;
        Sun, 13 Aug 2023 21:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962527;
        bh=8SOFQyrS2XcR+/jgWBQbvc5B3VtrT921Tk6XIbDWWY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBQcgHTrZuj91Z0UDUypE+5SVzFzWZIYXV9K8NDP1HWb7cA0UzrltZHz5/9o1H7Hd
         y9yk/+rWiNqQz5nHRyPkt3Y5c3rMFdAsARCLo6e+03Pa+r0ggTVdaRSz4LSj5xLINs
         +VajKk/QN1vfryWMlTxXQ8ULM4Ypu1mzE8kkP5Fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrea Parri <parri.andrea@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.1 022/149] riscv,mmio: Fix readX()-to-delay() ordering
Date:   Sun, 13 Aug 2023 23:17:47 +0200
Message-ID: <20230813211719.462626050@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
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

From: Andrea Parri <parri.andrea@gmail.com>

commit 4eb2eb1b4c0eb07793c240744843498564a67b83 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/mmio.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -101,9 +101,9 @@ static inline u64 __raw_readq(const vola
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
@@ -125,14 +125,14 @@ static inline u64 __raw_readq(const vola
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


