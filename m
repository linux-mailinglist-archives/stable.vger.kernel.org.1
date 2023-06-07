Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6299725E52
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbjFGMO1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238985AbjFGMOZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB91BD4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DB4D63E15
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 12:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42416C433A0;
        Wed,  7 Jun 2023 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686140063;
        bh=T/yV9pOmen0JVp6gBh1EfFJakjWOMN/zbDmC0kNSr3w=;
        h=Subject:To:Cc:From:Date:From;
        b=vugjrNOJF7ff0nIwgIXd8FFIqVRPG38BRbD/DWk7W24jPNEJhaxcSAo16KfSCSqs6
         iXbqDUEPWpXy4+kluWpETBzExM2IqYcd+LEH8lccd9nD7AvF/ufJBfxxF3R79KA79y
         ofbmN+NKaMEsXH0DPTjJZA37Hmrifl/AIShUwdho=
Subject: FAILED: patch "[PATCH] riscv: perf: Fix callchain parse error with kernel tracepoint" failed to apply to 5.15-stable tree
To:     ism.hong@gmail.com, palmer@rivosinc.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 07 Jun 2023 14:14:20 +0200
Message-ID: <2023060720-marina-oasis-235c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9a7e8ec0d4cc64870ea449b4fce5779b77496cbb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060720-marina-oasis-235c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9a7e8ec0d4cc64870ea449b4fce5779b77496cbb Mon Sep 17 00:00:00 2001
From: Ism Hong <ism.hong@gmail.com>
Date: Thu, 1 Jun 2023 17:53:55 +0800
Subject: [PATCH] riscv: perf: Fix callchain parse error with kernel tracepoint
 events

For RISC-V, when tracing with tracepoint events, the IP and status are
set to 0, preventing the perf code parsing the callchain and resolving
the symbols correctly.

 ./ply 'tracepoint:kmem/kmem_cache_alloc { @[stack]=count(); }'
 @:
 { <STACKID4294967282> }: 1

The fix is to implement perf_arch_fetch_caller_regs for riscv, which
fills several necessary registers used for callchain unwinding,
including epc, sp, s0 and status. It's similar to commit b3eac0265bf6
("arm: perf: Fix callchain parse error with kernel tracepoint events")
and commit 5b09a094f2fb ("arm64: perf: Fix callchain parse error with
kernel tracepoint events").

With this patch, callchain can be parsed correctly as:

 ./ply 'tracepoint:kmem/kmem_cache_alloc { @[stack]=count(); }'
 @:
 {
         __traceiter_kmem_cache_alloc+68
         __traceiter_kmem_cache_alloc+68
         kmem_cache_alloc+354
         __sigqueue_alloc+94
         __send_signal_locked+646
         send_signal_locked+154
         do_send_sig_info+84
         __kill_pgrp_info+130
         kill_pgrp+60
         isig+150
         n_tty_receive_signal_char+36
         n_tty_receive_buf_standard+2214
         n_tty_receive_buf_common+280
         n_tty_receive_buf2+26
         tty_ldisc_receive_buf+34
         tty_port_default_receive_buf+62
         flush_to_ldisc+158
         process_one_work+458
         worker_thread+138
         kthread+178
         riscv_cpufeature_patch_func+832
  }: 1

Signed-off-by: Ism Hong <ism.hong@gmail.com>
Link: https://lore.kernel.org/r/20230601095355.1168910-1-ism.hong@gmail.com
Fixes: 178e9fc47aae ("perf: riscv: preliminary RISC-V support")
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
index d42c901f9a97..665bbc9b2f84 100644
--- a/arch/riscv/include/asm/perf_event.h
+++ b/arch/riscv/include/asm/perf_event.h
@@ -10,4 +10,11 @@
 
 #include <linux/perf_event.h>
 #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
+
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+	(regs)->epc = (__ip); \
+	(regs)->s0 = (unsigned long) __builtin_frame_address(0); \
+	(regs)->sp = current_stack_pointer; \
+	(regs)->status = SR_PP; \
+}
 #endif /* _ASM_RISCV_PERF_EVENT_H */

