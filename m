Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA557CA2DB
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJPI4D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjJPI4C (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:56:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F33AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:56:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF1EC433C8;
        Mon, 16 Oct 2023 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446560;
        bh=4j6/dOw+GhtGLCLv5W9DTwaNwa42m05eK+U4JXyGBCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYJw9ICQpemdg4FRvcvfrK12peVIpAw9UPoOgHaeBhlil6/dQB/496s0bJtm7nxEc
         sexkM7fXvdmlaJS+x3VFKHUvzROzQvGpNMJyp5aroDZ9j1yXfeQdSUkY0EikK+4hk3
         +TVpWsIKY8Bi65T3kV7GtFrMi6VfdJs0aXXUimmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pu Lehui <pulehui@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 051/131] riscv, bpf: Factor out emit_call for kernel and bpf context
Date:   Mon, 16 Oct 2023 10:40:34 +0200
Message-ID: <20231016084001.340606193@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pu Lehui <pulehui@huawei.com>

[ Upstream commit 0fd1fd0104954380477353aea29c347e85dff16d ]

The current emit_call function is not suitable for kernel function call as
it store return value to bpf R0 register. We can separate it out for common
use. Meanwhile, simplify judgment logic, that is, fixed function address
can use jal or auipc+jalr, while the unfixed can use only auipc+jalr.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/bpf/20230215135205.1411105-3-pulehui@huaweicloud.com
Stable-dep-of: 2f1b0d3d7331 ("riscv, bpf: Sign-extend return values")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/net/bpf_jit_comp64.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index f2417ac54edd6..69ebab81d9352 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -428,12 +428,12 @@ static void emit_sext_32_rd(u8 *rd, struct rv_jit_context *ctx)
 	*rd = RV_REG_T2;
 }
 
-static int emit_jump_and_link(u8 rd, s64 rvoff, bool force_jalr,
+static int emit_jump_and_link(u8 rd, s64 rvoff, bool fixed_addr,
 			      struct rv_jit_context *ctx)
 {
 	s64 upper, lower;
 
-	if (rvoff && is_21b_int(rvoff) && !force_jalr) {
+	if (rvoff && fixed_addr && is_21b_int(rvoff)) {
 		emit(rv_jal(rd, rvoff >> 1), ctx);
 		return 0;
 	} else if (in_auipc_jalr_range(rvoff)) {
@@ -454,24 +454,17 @@ static bool is_signed_bpf_cond(u8 cond)
 		cond == BPF_JSGE || cond == BPF_JSLE;
 }
 
-static int emit_call(bool fixed, u64 addr, struct rv_jit_context *ctx)
+static int emit_call(u64 addr, bool fixed_addr, struct rv_jit_context *ctx)
 {
 	s64 off = 0;
 	u64 ip;
-	u8 rd;
-	int ret;
 
 	if (addr && ctx->insns) {
 		ip = (u64)(long)(ctx->insns + ctx->ninsns);
 		off = addr - ip;
 	}
 
-	ret = emit_jump_and_link(RV_REG_RA, off, !fixed, ctx);
-	if (ret)
-		return ret;
-	rd = bpf_to_rv_reg(BPF_REG_0, ctx);
-	emit_mv(rd, RV_REG_A0, ctx);
-	return 0;
+	return emit_jump_and_link(RV_REG_RA, off, fixed_addr, ctx);
 }
 
 static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
@@ -913,7 +906,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	/* JUMP off */
 	case BPF_JMP | BPF_JA:
 		rvoff = rv_offset(i, off, ctx);
-		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, false, ctx);
+		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, true, ctx);
 		if (ret)
 			return ret;
 		break;
@@ -1032,17 +1025,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	/* function call */
 	case BPF_JMP | BPF_CALL:
 	{
-		bool fixed;
+		bool fixed_addr;
 		u64 addr;
 
 		mark_call(ctx);
-		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass, &addr,
-					    &fixed);
+		ret = bpf_jit_get_func_addr(ctx->prog, insn, extra_pass,
+					    &addr, &fixed_addr);
 		if (ret < 0)
 			return ret;
-		ret = emit_call(fixed, addr, ctx);
+
+		ret = emit_call(addr, fixed_addr, ctx);
 		if (ret)
 			return ret;
+
+		emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
 		break;
 	}
 	/* tail call */
@@ -1057,7 +1053,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			break;
 
 		rvoff = epilogue_offset(ctx);
-		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, false, ctx);
+		ret = emit_jump_and_link(RV_REG_ZERO, rvoff, true, ctx);
 		if (ret)
 			return ret;
 		break;
-- 
2.40.1



