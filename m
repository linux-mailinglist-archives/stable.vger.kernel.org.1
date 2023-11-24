Return-Path: <stable+bounces-1173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6817F7E5F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1BD5B216F8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22B72E621;
	Fri, 24 Nov 2023 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H8Z2lgo4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AA2E655;
	Fri, 24 Nov 2023 18:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51A0C433C7;
	Fri, 24 Nov 2023 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850741;
	bh=APtSlRBHwrjBJT0AquUU/5wIq5T+vlADgKWDAgZ6qEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8Z2lgo4Ez9sSy4itxXKmQd/snIWcZOGBow06AE02U9eI0Q1uXDY+iaOfPvvVZIx5
	 sQlkcQi4ROXantX9Oqxk7Z2BadhH3Ln6B6cf5IShqvM1QPSS9trz5XzP9IT3TXKmij
	 Sz5DcqgpMb5gh5lROsc44W88yB/Po3CY4nYmqByk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Sun <sunhao.th@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 171/491] bpf: handle ldimm64 properly in check_cfg()
Date: Fri, 24 Nov 2023 17:46:47 +0000
Message-ID: <20231124172029.607022009@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 3feb263bb516ee7e1da0acd22b15afbb9a7daa19 ]

ldimm64 instructions are 16-byte long, and so have to be handled
appropriately in check_cfg(), just like the rest of BPF verifier does.

This has implications in three places:
  - when determining next instruction for non-jump instructions;
  - when determining next instruction for callback address ldimm64
    instructions (in visit_func_call_insn());
  - when checking for unreachable instructions, where second half of
    ldimm64 is expected to be unreachable;

We take this also as an opportunity to report jump into the middle of
ldimm64. And adjust few test_verifier tests accordingly.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Hao Sun <sunhao.th@gmail.com>
Fixes: 475fb78fbf48 ("bpf: verifier (add branch/goto checks)")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231110002638.4168352-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h                           |  8 ++++--
 kernel/bpf/verifier.c                         | 27 ++++++++++++++-----
 .../testing/selftests/bpf/verifier/ld_imm64.c |  8 +++---
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 98a7d6fd10360..a8b775e9d4d1a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -890,10 +890,14 @@ bpf_ctx_record_field_size(struct bpf_insn_access_aux *aux, u32 size)
 	aux->ctx_field_size = size;
 }
 
+static bool bpf_is_ldimm64(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
+}
+
 static inline bool bpf_pseudo_func(const struct bpf_insn *insn)
 {
-	return insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
-	       insn->src_reg == BPF_PSEUDO_FUNC;
+	return bpf_is_ldimm64(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
 }
 
 struct bpf_prog_ops {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c3b6f282128bf..cb5621000993e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14563,15 +14563,16 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 				struct bpf_verifier_env *env,
 				bool visit_callee)
 {
-	int ret;
+	int ret, insn_sz;
 
-	ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
+	insn_sz = bpf_is_ldimm64(&insns[t]) ? 2 : 1;
+	ret = push_insn(t, t + insn_sz, FALLTHROUGH, env, false);
 	if (ret)
 		return ret;
 
-	mark_prune_point(env, t + 1);
+	mark_prune_point(env, t + insn_sz);
 	/* when we exit from subprog, we need to record non-linear history */
-	mark_jmp_point(env, t + 1);
+	mark_jmp_point(env, t + insn_sz);
 
 	if (visit_callee) {
 		mark_prune_point(env, t);
@@ -14593,15 +14594,17 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 static int visit_insn(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insns = env->prog->insnsi, *insn = &insns[t];
-	int ret;
+	int ret, insn_sz;
 
 	if (bpf_pseudo_func(insn))
 		return visit_func_call_insn(t, insns, env, true);
 
 	/* All non-branch instructions have a single fall-through edge. */
 	if (BPF_CLASS(insn->code) != BPF_JMP &&
-	    BPF_CLASS(insn->code) != BPF_JMP32)
-		return push_insn(t, t + 1, FALLTHROUGH, env, false);
+	    BPF_CLASS(insn->code) != BPF_JMP32) {
+		insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
+		return push_insn(t, t + insn_sz, FALLTHROUGH, env, false);
+	}
 
 	switch (BPF_OP(insn->code)) {
 	case BPF_EXIT:
@@ -14715,11 +14718,21 @@ static int check_cfg(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < insn_cnt; i++) {
+		struct bpf_insn *insn = &env->prog->insnsi[i];
+
 		if (insn_state[i] != EXPLORED) {
 			verbose(env, "unreachable insn %d\n", i);
 			ret = -EINVAL;
 			goto err_free;
 		}
+		if (bpf_is_ldimm64(insn)) {
+			if (insn_state[i + 1] != 0) {
+				verbose(env, "jump into the middle of ldimm64 insn %d\n", i);
+				ret = -EINVAL;
+				goto err_free;
+			}
+			i++; /* skip second half of ldimm64 */
+		}
 	}
 	ret = 0; /* cfg looks good */
 
diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
index f9297900cea6d..78f19c255f20b 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -9,8 +9,8 @@
 	BPF_MOV64_IMM(BPF_REG_0, 2),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid BPF_LD_IMM insn",
-	.errstr_unpriv = "R1 pointer comparison",
+	.errstr = "jump into the middle of ldimm64 insn 1",
+	.errstr_unpriv = "jump into the middle of ldimm64 insn 1",
 	.result = REJECT,
 },
 {
@@ -23,8 +23,8 @@
 	BPF_LD_IMM64(BPF_REG_0, 1),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid BPF_LD_IMM insn",
-	.errstr_unpriv = "R1 pointer comparison",
+	.errstr = "jump into the middle of ldimm64 insn 1",
+	.errstr_unpriv = "jump into the middle of ldimm64 insn 1",
 	.result = REJECT,
 },
 {
-- 
2.42.0




