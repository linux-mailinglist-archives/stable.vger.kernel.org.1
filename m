Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1E8726DCF
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjFGUpb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjFGUpT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4695E106
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2557264647
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38384C433EF;
        Wed,  7 Jun 2023 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170713;
        bh=IDowwYMG4utyLSWdFHM4/mzJo1mH8B/Z44JIle9Izv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkbWV8kbIOc/sLAs5zyOqT03duD6ZOQPlSaWNdaOQ92mgJ9L8sHItUPxLJsrxDhMs
         l4gMyLUpALJX/zgOZKJrK3xxcNyyq0vUck7qJg/h1A0uziha370Jv2tvQNI1de4mtE
         E92Hv+psk+LWZZZqX495NyOUHFdwrjwU2r/AUJYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ism Hong <ism.hong@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.1 182/225] riscv: perf: Fix callchain parse error with kernel tracepoint events
Date:   Wed,  7 Jun 2023 22:16:15 +0200
Message-ID: <20230607200920.343016050@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ism Hong <ism.hong@gmail.com>

commit 9a7e8ec0d4cc64870ea449b4fce5779b77496cbb upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/perf_event.h |    7 +++++++
 1 file changed, 7 insertions(+)

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


