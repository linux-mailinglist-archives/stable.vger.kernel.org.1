Return-Path: <stable+bounces-152307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F769AD3B96
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40173A9A61
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4D20DD6B;
	Tue, 10 Jun 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXUHE6kW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A41C68F
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566749; cv=none; b=bws7y8SmTpjFQHsWbapP0qSZfgTo2Dtsmfa/Tb/dhClE3eZRpp2pZHCaOrxdk/7QFNJuFkN4BFZS9ckifqS65sOF2sMQbqe1aT3DllmLAyk4cAlLTS7tW/fS7mgif0mMjxPSWu7/0nBUHciwJjB1vg8XPSnZCTAjaTrttQFfEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566749; c=relaxed/simple;
	bh=bf278lodal0VZsdRrUyq7iEzj3AN9gwDaHQ8yEMnhM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6SuLqpLDaAbEd4TiBnI9cJX4LKVqfl9pDy5Zc4efsxANKYjGpY+sNmKlq9zH2bAF1XG/sptw/qdZQmuent2lFQED/hErilN/lb6bMpX0o9sVCnWN5nejbL8YEoa5IecXHej+IUvDgsn2nIW1aLAewnZOHGXw1XAZeRM/mduvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXUHE6kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3FEC4CEEF;
	Tue, 10 Jun 2025 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749566749;
	bh=bf278lodal0VZsdRrUyq7iEzj3AN9gwDaHQ8yEMnhM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXUHE6kW4IfqsslQt4/4sXSscLUQJC2ctNm8ZJYYAYK2ijZlpD4fDJ7MmQcMGRV0t
	 wkDZLzksOMlbMpMpAMlmIGazgI4uaLLY8SmZS2305yJB3oZuRKhf7EMAoUTFMGK6Dz
	 vt0K/TELcoR1l81g/gUWFZYxDGnmxHm/onHodmu3KQfywB0X8Sxh6locSkKY3ErXgq
	 O33sLMqpdTPWsTo5zTwOx9xo9UBWmCfPn8Ce9Z+ADSytu63PceMy0+x4dkb9BgsjXJ
	 jlX3Bmo/jrtuwJNMASsWL0a5nNKkU7jp+jXuWmNd7EifKQZ/UunK51/9+JZg4T6V4K
	 Q5ThYwP4tuYIw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hao Luo <haoluo@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH stable linux-5.10.y v1 6/8] bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
Date: Tue, 10 Jun 2025 14:44:01 +0000
Message-ID: <20250610144407.95865-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250610144407.95865-1-puranjay@kernel.org>
References: <20250610144407.95865-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Luo <haoluo@google.com>

commit 34d3a78c681e8e7844b43d1a2f4671a04249c821 upstream.

Tag the return type of {per, this}_cpu_ptr with RDONLY_MEM. The
returned value of this pair of helpers is kernel object, which
can not be updated by bpf programs. Previously these two helpers
return PTR_OT_MEM for kernel objects of scalar type, which allows
one to directly modify the memory. Now with RDONLY_MEM tagging,
the verifier will reject programs that write into RDONLY_MEM.

Fixes: 63d9b80dcf2c ("bpf: Introducte bpf_this_cpu_ptr()")
Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/bpf/20211217003152.48334-8-haoluo@google.com
Cc: stable@vger.kernel.org # 5.10.x
---
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 60ae9fcd9473..3e5466693615 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -653,7 +653,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 	.func		= bpf_per_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 	.arg2_type	= ARG_ANYTHING,
 };
@@ -666,7 +666,7 @@ BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
 const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
 	.func		= bpf_this_cpu_ptr,
 	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID,
+	.ret_type	= RET_PTR_TO_MEM_OR_BTF_ID | MEM_RDONLY,
 	.arg1_type	= ARG_PTR_TO_PERCPU_BTF_ID,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bc36fea0dbe8..03e40ee02c0c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4014,15 +4014,30 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 				mark_reg_unknown(env, regs, value_regno);
 			}
 		}
-	} else if (reg->type == PTR_TO_MEM) {
+	} else if (base_type(reg->type) == PTR_TO_MEM) {
+		bool rdonly_mem = type_is_rdonly_mem(reg->type);
+
+		if (type_may_be_null(reg->type)) {
+			verbose(env, "R%d invalid mem access '%s'\n", regno,
+				reg_type_str(env, reg->type));
+			return -EACCES;
+		}
+
+		if (t == BPF_WRITE && rdonly_mem) {
+			verbose(env, "R%d cannot write into %s\n",
+				regno, reg_type_str(env, reg->type));
+			return -EACCES;
+		}
+
 		if (t == BPF_WRITE && value_regno >= 0 &&
 		    is_pointer_value(env, value_regno)) {
 			verbose(env, "R%d leaks addr into mem\n", value_regno);
 			return -EACCES;
 		}
+
 		err = check_mem_region_access(env, regno, off, size,
 					      reg->mem_size, false);
-		if (!err && t == BPF_READ && value_regno >= 0)
+		if (!err && value_regno >= 0 && (t == BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
 		enum bpf_reg_type reg_type = SCALAR_VALUE;
@@ -5730,6 +5745,13 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 			regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
 			regs[BPF_REG_0].mem_size = tsize;
 		} else {
+			/* MEM_RDONLY may be carried from ret_flag, but it
+			 * doesn't apply on PTR_TO_BTF_ID. Fold it, otherwise
+			 * it will confuse the check of PTR_TO_BTF_ID in
+			 * check_mem_access().
+			 */
+			ret_flag &= ~MEM_RDONLY;
+
 			regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
 			regs[BPF_REG_0].btf_id = meta.ret_btf_id;
 		}
@@ -8387,7 +8409,7 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		mark_reg_known_zero(env, regs, insn->dst_reg);
 
 		dst_reg->type = aux->btf_var.reg_type;
-		switch (dst_reg->type) {
+		switch (base_type(dst_reg->type)) {
 		case PTR_TO_MEM:
 			dst_reg->mem_size = aux->btf_var.mem_size;
 			break;
@@ -10401,7 +10423,7 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 				tname, PTR_ERR(ret));
 			return -EINVAL;
 		}
-		aux->btf_var.reg_type = PTR_TO_MEM;
+		aux->btf_var.reg_type = PTR_TO_MEM | MEM_RDONLY;
 		aux->btf_var.mem_size = tsize;
 	} else {
 		aux->btf_var.reg_type = PTR_TO_BTF_ID;
-- 
2.47.1


