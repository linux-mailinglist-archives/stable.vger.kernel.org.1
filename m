Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7175073E9E6
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjFZSlS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjFZSlR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11009CC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8823D60F45
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC0AC433C0;
        Mon, 26 Jun 2023 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804874;
        bh=A7R/cC/4bnd3PSBE18dGWU4Va1blHu3yDAuhMMXiHHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7NgqqYeJOlCycAn6ezlNzgS4XC6GEtZXamOzsxBgRU4qsZV/oyvu3V6v/IJuskZf
         o2SakGgaZVzawv16yaDYDgWTZIT0qqGxIl+vZAWlBXWCDKFygPS69QHyqWvn2N/80w
         iYnQH0mH0+b+f03wqfiPZZOL714xLH4xqlXcE0IU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 43/96] bpf: track immediate values written to stack by BPF_ST instruction
Date:   Mon, 26 Jun 2023 20:11:58 +0200
Message-ID: <20230626180748.733855427@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit ecdf985d7615356b78241fdb159c091830ed0380 ]

For aligned stack writes using BPF_ST instruction track stored values
in a same way BPF_STX is handled, e.g. make sure that the following
commands produce similar verifier knowledge:

  fp[-8] = 42;             r1 = 42;
                       fp[-8] = r1;

This covers two cases:
 - non-null values written to stack are stored as spill of fake
   registers;
 - null values written to stack are stored as STACK_ZERO marks.

Previously both cases above used STACK_MISC marks instead.

Some verifier test cases relied on the old logic to obtain STACK_MISC
marks for some stack values. These test cases are updated in the same
commit to avoid failures during bisect.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20230214232030.1502829-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 713274f1f2c8 ("bpf: Fix verifier id tracking of scalars on spill")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c                         |  18 ++-
 .../bpf/verifier/bounds_mix_sign_unsign.c     | 110 ++++++++++--------
 2 files changed, 80 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 27fd331aefe57..9d7a6bf5f7c1f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2659,6 +2659,11 @@ static void save_register_state(struct bpf_func_state *state,
 		scrub_spilled_slot(&state->stack[spi].slot_type[i - 1]);
 }
 
+static bool is_bpf_st_mem(struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_ST && BPF_MODE(insn->code) == BPF_MEM;
+}
+
 /* check_stack_{read,write}_fixed_off functions track spill/fill of registers,
  * stack boundary and alignment are checked in check_mem_access()
  */
@@ -2670,8 +2675,9 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 {
 	struct bpf_func_state *cur; /* state of the current function */
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
-	u32 dst_reg = env->prog->insnsi[insn_idx].dst_reg;
+	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg = NULL;
+	u32 dst_reg = insn->dst_reg;
 
 	err = grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
 	if (err)
@@ -2719,6 +2725,13 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 				return err;
 		}
 		save_register_state(state, spi, reg, size);
+	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
+		   insn->imm != 0 && env->bpf_capable) {
+		struct bpf_reg_state fake_reg = {};
+
+		__mark_reg_known(&fake_reg, (u32)insn->imm);
+		fake_reg.type = SCALAR_VALUE;
+		save_register_state(state, spi, &fake_reg, size);
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
@@ -2753,7 +2766,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 			state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 
 		/* when we zero initialize stack slots mark them as such */
-		if (reg && register_is_null(reg)) {
+		if ((reg && register_is_null(reg)) ||
+		    (!reg && is_bpf_st_mem(insn) && insn->imm == 0)) {
 			/* backtracking doesn't work for STACK_ZERO yet. */
 			err = mark_chain_precision(env, value_regno);
 			if (err)
diff --git a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
index c2aa6f26738b4..bf82b923c5fe5 100644
--- a/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
+++ b/tools/testing/selftests/bpf/verifier/bounds_mix_sign_unsign.c
@@ -1,13 +1,14 @@
 {
 	"bounds checks mixing signed and unsigned, positive bounds",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 2),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 3),
@@ -17,20 +18,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
@@ -40,20 +42,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 2",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
@@ -65,20 +68,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 3",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 4),
@@ -89,20 +93,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 4",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 1),
 	BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
@@ -112,19 +117,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.result = ACCEPT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 5",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 5),
@@ -135,17 +141,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 6",
 	.insns = {
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_1),
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_9),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -512),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_6, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_4, BPF_REG_6, 5),
@@ -163,13 +172,14 @@
 {
 	"bounds checks mixing signed and unsigned, variant 7",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 1024 * 1024 * 1024),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, 3),
@@ -179,19 +189,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.result = ACCEPT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 8",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
@@ -203,20 +214,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 9",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 10),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_LD_IMM64(BPF_REG_2, -9223372036854775808ULL),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
@@ -228,19 +240,20 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.result = ACCEPT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 10",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 0),
 	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_1, 2),
@@ -252,20 +265,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 11",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -278,20 +292,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 12",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 9),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -6),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -303,20 +318,21 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 13",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 6),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, 2),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -331,7 +347,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
@@ -340,13 +356,14 @@
 	.insns = {
 	BPF_LDX_MEM(BPF_W, BPF_REG_9, BPF_REG_1,
 		    offsetof(struct __sk_buff, mark)),
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 8),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 7),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -1),
 	BPF_MOV64_IMM(BPF_REG_8, 2),
@@ -360,20 +377,21 @@
 	BPF_JMP_REG(BPF_JGT, BPF_REG_1, BPF_REG_2, -3),
 	BPF_JMP_IMM(BPF_JA, 0, 0, -7),
 	},
-	.fixup_map_hash_8b = { 4 },
+	.fixup_map_hash_8b = { 6 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
 {
 	"bounds checks mixing signed and unsigned, variant 15",
 	.insns = {
+	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 4),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, -8),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3),
 	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
 	BPF_MOV64_IMM(BPF_REG_2, -6),
 	BPF_JMP_REG(BPF_JGE, BPF_REG_2, BPF_REG_1, 2),
@@ -387,7 +405,7 @@
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_8b = { 3 },
+	.fixup_map_hash_8b = { 5 },
 	.errstr = "unbounded min value",
 	.result = REJECT,
 },
-- 
2.39.2



