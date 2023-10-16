Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DC27CAC0A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjJPOtC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjJPOtB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:49:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B6AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:48:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE30C433CA;
        Mon, 16 Oct 2023 14:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467738;
        bh=5HcTZh9YPUIwXaZhTSHfEsuEcP6oQz/vFXmOTfcn0zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnGTPwQBitwGPjnd/pPKIJYm3MMcR/srqjefBxPJ77eJN6j9m1AkhPHyvdhE3cav9
         cjlykNNShdANGsh+xvwSjcvDjZ+CU1SYimGPvq/7KkjScVsXh5f94kZDBcLDHCY8zM
         YmJIa2XGXtLC0oiZ7RKT0ZzNXfd2lQODv7TtYvXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 080/191] s390/bpf: Fix unwinding past the trampoline
Date:   Mon, 16 Oct 2023 10:41:05 +0200
Message-ID: <20231016084017.270485616@linuxfoundation.org>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit 5356ba1ff4f2417e1aebcf99aab35c1ea94dd6d7 ]

When functions called by the trampoline panic, the backtrace that is
printed stops at the trampoline, because the trampoline does not store
its caller's frame address (backchain) on stack; it also stores the
return address at a wrong location.

Store both the same way as is already done for the regular eBPF programs.

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20231010203512.385819-3-iii@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 9a9733e4bc801..e507692e51e71 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2066,6 +2066,7 @@ struct bpf_tramp_jit {
 				 * func_addr's original caller
 				 */
 	int stack_size;		/* Trampoline stack size */
+	int backchain_off;	/* Offset of backchain */
 	int stack_args_off;	/* Offset of stack arguments for calling
 				 * func_addr, has to be at the top
 				 */
@@ -2086,9 +2087,10 @@ struct bpf_tramp_jit {
 				 * for __bpf_prog_enter() return value and
 				 * func_addr respectively
 				 */
-	int r14_off;		/* Offset of saved %r14 */
 	int run_ctx_off;	/* Offset of struct bpf_tramp_run_ctx */
 	int tccnt_off;		/* Offset of saved tailcall counter */
+	int r14_off;		/* Offset of saved %r14, has to be at the
+				 * bottom */
 	int do_fexit;		/* do_fexit: label */
 };
 
@@ -2247,8 +2249,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 * Calculate the stack layout.
 	 */
 
-	/* Reserve STACK_FRAME_OVERHEAD bytes for the callees. */
+	/*
+	 * Allocate STACK_FRAME_OVERHEAD bytes for the callees. As the s390x
+	 * ABI requires, put our backchain at the end of the allocated memory.
+	 */
 	tjit->stack_size = STACK_FRAME_OVERHEAD;
+	tjit->backchain_off = tjit->stack_size - sizeof(u64);
 	tjit->stack_args_off = alloc_stack(tjit, nr_stack_args * sizeof(u64));
 	tjit->reg_args_off = alloc_stack(tjit, nr_reg_args * sizeof(u64));
 	tjit->ip_off = alloc_stack(tjit, sizeof(u64));
@@ -2256,10 +2262,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	tjit->bpf_args_off = alloc_stack(tjit, nr_bpf_args * sizeof(u64));
 	tjit->retval_off = alloc_stack(tjit, sizeof(u64));
 	tjit->r7_r8_off = alloc_stack(tjit, 2 * sizeof(u64));
-	tjit->r14_off = alloc_stack(tjit, sizeof(u64));
 	tjit->run_ctx_off = alloc_stack(tjit,
 					sizeof(struct bpf_tramp_run_ctx));
 	tjit->tccnt_off = alloc_stack(tjit, sizeof(u64));
+	tjit->r14_off = alloc_stack(tjit, sizeof(u64) * 2);
 	/*
 	 * In accordance with the s390x ABI, the caller has allocated
 	 * STACK_FRAME_OVERHEAD bytes for us. 8 of them contain the caller's
@@ -2268,8 +2274,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	tjit->stack_size -= STACK_FRAME_OVERHEAD - sizeof(u64);
 	tjit->orig_stack_args_off = tjit->stack_size + STACK_FRAME_OVERHEAD;
 
+	/* lgr %r1,%r15 */
+	EMIT4(0xb9040000, REG_1, REG_15);
 	/* aghi %r15,-stack_size */
 	EMIT4_IMM(0xa70b0000, REG_15, -tjit->stack_size);
+	/* stg %r1,backchain_off(%r15) */
+	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_1, REG_0, REG_15,
+		      tjit->backchain_off);
 	/* mvc tccnt_off(4,%r15),stack_size+STK_OFF_TCCNT(%r15) */
 	_EMIT6(0xd203f000 | tjit->tccnt_off,
 	       0xf000 | (tjit->stack_size + STK_OFF_TCCNT));
-- 
2.40.1



