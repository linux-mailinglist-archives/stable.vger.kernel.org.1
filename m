Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BEE7CAC9C
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjJPO4c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjJPO4a (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:56:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F964E3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:56:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5749CC433C9;
        Mon, 16 Oct 2023 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468187;
        bh=X+NSZ6BDVkYsFYBh6oyNxQSAGdMYv8jaUj4VHriCXhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYm9ooVSo4fCdaOGETeGpQNR6599Te/PYpInSXuItaAUJQiio/IPYUoa3UsMiMTxK
         pQ5PdUMApAbdr3L86ZAgSRl6i0xknpQvuZC8EzdEhYocXKzRl3CJP3BgusQhAqaTLj
         EZC0wCeNLIXgN1w95BsDRm6QrUs8qgpsMCJVOMQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guo Ren <guoren@kernel.org>,
        Jiexun Wang <wangjiexun@tinylab.org>,
        Samuel Holland <samuel@sholland.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.5 172/191] RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
Date:   Mon, 16 Oct 2023 10:42:37 +0200
Message-ID: <20231016084019.390188715@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiexun Wang <wangjiexun@tinylab.org>

commit 07a27665754bf649b5de8e55c655e4d6837406be upstream.

If configuration options SOFTIRQ_ON_OWN_STACK and PREEMPT_RT
are enabled simultaneously under RISC-V architecture,
it will result in a compilation failure:

arch/riscv/kernel/irq.c:64:6: error: redefinition of 'do_softirq_own_stack'
   64 | void do_softirq_own_stack(void)
      |      ^~~~~~~~~~~~~~~~~~~~
In file included from ./arch/riscv/include/generated/asm/softirq_stack.h:1,
                 from arch/riscv/kernel/irq.c:15:
./include/asm-generic/softirq_stack.h:8:20: note: previous definition of 'do_softirq_own_stack' was here
    8 | static inline void do_softirq_own_stack(void)
      |                    ^~~~~~~~~~~~~~~~~~~~

After changing CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK to CONFIG_SOFTIRQ_ON_OWN_STACK,
compilation can be successful.

Fixes: dd69d07a5a6c ("riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK")
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Jiexun Wang <wangjiexun@tinylab.org>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Link: https://lore.kernel.org/r/20230913052940.374686-1-wangjiexun@tinylab.org
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index a8efa053c4a5..9cc0a7669271 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -60,7 +60,7 @@ static void init_irq_stacks(void)
 }
 #endif /* CONFIG_VMAP_STACK */
 
-#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
+#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void)
 {
 #ifdef CONFIG_IRQ_STACKS
@@ -92,7 +92,7 @@ void do_softirq_own_stack(void)
 #endif
 		__do_softirq();
 }
-#endif /* CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK */
+#endif /* CONFIG_SOFTIRQ_ON_OWN_STACK */
 
 #else
 static void init_irq_stacks(void) {}
-- 
2.42.0



