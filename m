Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83C57CABF2
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjJPOrt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjJPOrs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:47:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB552B4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:47:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D851C433C7;
        Mon, 16 Oct 2023 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467664;
        bh=34wtwRPGKzKN8HfO5lu25lbtyl48QQm4K8aenixk9PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wDpWZFZCgi3J8tk4+SEbKn87tOavf5SOJJbLOBfPyMn8KCDJ/l2yvqqC6A6mqULcq
         674MupsCdzmXju9jWxDK9IN85kyAy75JJriyGl9W7K6PmVn8pfn5ddPAi00CYRtWol
         V2qrg+w6wdK10I9e8CI0pGF0/G5ZhlyrZoWtQMBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 066/191] riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values
Date:   Mon, 16 Oct 2023 10:40:51 +0200
Message-ID: <20231016084016.945165178@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 7112cd26e606c7ba51f9cc5c1905f06039f6f379 ]

The RISC-V BPF uses a5 for BPF return values, which are zero-extended,
whereas the RISC-V ABI uses a0 which is sign-extended. In other words,
a5 and a0 can differ, and are used in different context.

The BPF trampoline are used for both BPF programs, and regular kernel
functions.

Make sure that the RISC-V BPF trampoline saves, and restores both a0
and a5.

Fixes: 49b5e77ae3e2 ("riscv, bpf: Add bpf trampoline support for RV64")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20231004120706.52848-3-bjorn@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 3a3631bae05c1..3b4cb713e3684 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -757,8 +757,10 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	if (ret)
 		return ret;
 
-	if (save_ret)
-		emit_sd(RV_REG_FP, -retval_off, regmap[BPF_REG_0], ctx);
+	if (save_ret) {
+		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
+		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
+	}
 
 	/* update branch with beqz */
 	if (ctx->insns) {
@@ -844,7 +846,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
 	if (save_ret) {
-		stack_size += 8;
+		stack_size += 16; /* Save both A5 (BPF R0) and A0 */
 		retval_off = stack_size;
 	}
 
@@ -931,6 +933,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		if (ret)
 			goto out;
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
+		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
 		im->ip_after_call = ctx->insns + ctx->ninsns;
 		/* 2 nops reserved for auipc+jalr pair */
 		emit(rv_nop(), ctx);
@@ -962,8 +965,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_args(nregs, args_off, ctx);
 
-	if (save_ret)
+	if (save_ret) {
 		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
+		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
+	}
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
 
-- 
2.40.1



