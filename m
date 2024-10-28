Return-Path: <stable+bounces-88866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A149B27D5
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E499B1C214C8
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98918E05D;
	Mon, 28 Oct 2024 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wlMquWfb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DB2AF07;
	Mon, 28 Oct 2024 06:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098299; cv=none; b=JUfN02wCMuQyb3nBmoznmXIM2RaMvv3FLpQWjy7dONxNrSxU/W2X/MKnHkp/5hJOezkgb7U4DaGSYvVYywQFk2pJ+UTCZIn9hsW/cR3Azq8iLKNWpkRoytIIXo2qtQM0OAbaUTSxDqgcAoKxatSTlfYy2liUKcJUwK+fx8jF8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098299; c=relaxed/simple;
	bh=ujOICgCXproV/aMiNei1iy6n15IB6ereRay/omMIJjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtlESFBdgRyfppBEzJR8hNKdcJd3LGlHFjhTBz4O15JRB2Cg3tpgHVnlKG9rDmy4PLiWHhc1gKtnPSR8PaPSpHYgYiQrG/8NyFQWVQQG+GwJit6rUfgbeu5zYy+jGHX8TMYQeozlT6PCalGaJWq9zJ/72RTA6vY76XQPsIT4GB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wlMquWfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C310C4CEC3;
	Mon, 28 Oct 2024 06:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098298;
	bh=ujOICgCXproV/aMiNei1iy6n15IB6ereRay/omMIJjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wlMquWfbpFrZn/l8XLyWZfXkhefCZ0psgjvJw0SCAOkl7eit8l4QfFZDPdgGpDzEL
	 4hlYrqjvPWY+zZ5O3/wxUIKbtmiKxVULioT0PTE7OrIg1wY81tT4yN9TQC703WO2Ma
	 OkwGuoGp+ZDwLivgI8ltEDJZUM9U5Kc6Xe5Wi618=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lonial Con <kongln9170@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 164/261] bpf: Fix overloading of MEM_UNINITs meaning
Date: Mon, 28 Oct 2024 07:25:06 +0100
Message-ID: <20241028062316.111440596@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 8ea607330a39184f51737c6ae706db7fdca7628e ]

Lonial reported an issue in the BPF verifier where check_mem_size_reg()
has the following code:

    if (!tnum_is_const(reg->var_off))
        /* For unprivileged variable accesses, disable raw
         * mode so that the program is required to
         * initialize all the memory that the helper could
         * just partially fill up.
         */
         meta = NULL;

This means that writes are not checked when the register containing the
size of the passed buffer has not a fixed size. Through this bug, a BPF
program can write to a map which is marked as read-only, for example,
.rodata global maps.

The problem is that MEM_UNINIT's initial meaning that "the passed buffer
to the BPF helper does not need to be initialized" which was added back
in commit 435faee1aae9 ("bpf, verifier: add ARG_PTR_TO_RAW_STACK type")
got overloaded over time with "the passed buffer is being written to".

The problem however is that checks such as the above which were added later
via 06c1c049721a ("bpf: allow helpers access to variable memory") set meta
to NULL in order force the user to always initialize the passed buffer to
the helper. Due to the current double meaning of MEM_UNINIT, this bypasses
verifier write checks to the memory (not boundary checks though) and only
assumes the latter memory is read instead.

Fix this by reverting MEM_UNINIT back to its original meaning, and having
MEM_WRITE as an annotation to BPF helpers in order to then trigger the
BPF verifier checks for writing to memory.

Some notes: check_arg_pair_ok() ensures that for ARG_CONST_SIZE{,_OR_ZERO}
we can access fn->arg_type[arg - 1] since it must contain a preceding
ARG_PTR_TO_MEM. For check_mem_reg() the meta argument can be removed
altogether since we do check both BPF_READ and BPF_WRITE. Same for the
equivalent check_kfunc_mem_size_reg().

Fixes: 7b3552d3f9f6 ("bpf: Reject writes for PTR_TO_MAP_KEY in check_helper_mem_access")
Fixes: 97e6d7dab1ca ("bpf: Check PTR_TO_MEM | MEM_RDONLY in check_helper_mem_access")
Fixes: 15baa55ff5b0 ("bpf/verifier: allow all functions to read user provided context")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20241021152809.33343-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 73 +++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5b8b1d0e76cf1..62efe7f0aa46f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7344,7 +7344,8 @@ static int check_stack_range_initialized(
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
-				   int access_size, bool zero_size_allowed,
+				   int access_size, enum bpf_access_type access_type,
+				   bool zero_size_allowed,
 				   struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
@@ -7356,7 +7357,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_packet_access(env, regno, reg->off, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
-		if (meta && meta->raw_mode) {
+		if (access_type == BPF_WRITE) {
 			verbose(env, "R%d cannot write into %s\n", regno,
 				reg_type_str(env, reg->type));
 			return -EACCES;
@@ -7364,15 +7365,13 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_mem_region_access(env, regno, reg->off, access_size,
 					       reg->map_ptr->key_size, false);
 	case PTR_TO_MAP_VALUE:
-		if (check_map_access_type(env, regno, reg->off, access_size,
-					  meta && meta->raw_mode ? BPF_WRITE :
-					  BPF_READ))
+		if (check_map_access_type(env, regno, reg->off, access_size, access_type))
 			return -EACCES;
 		return check_map_access(env, regno, reg->off, access_size,
 					zero_size_allowed, ACCESS_HELPER);
 	case PTR_TO_MEM:
 		if (type_is_rdonly_mem(reg->type)) {
-			if (meta && meta->raw_mode) {
+			if (access_type == BPF_WRITE) {
 				verbose(env, "R%d cannot write into %s\n", regno,
 					reg_type_str(env, reg->type));
 				return -EACCES;
@@ -7383,7 +7382,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 					       zero_size_allowed);
 	case PTR_TO_BUF:
 		if (type_is_rdonly_mem(reg->type)) {
-			if (meta && meta->raw_mode) {
+			if (access_type == BPF_WRITE) {
 				verbose(env, "R%d cannot write into %s\n", regno,
 					reg_type_str(env, reg->type));
 				return -EACCES;
@@ -7411,7 +7410,6 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		 * Dynamically check it now.
 		 */
 		if (!env->ops->convert_ctx_access) {
-			enum bpf_access_type atype = meta && meta->raw_mode ? BPF_WRITE : BPF_READ;
 			int offset = access_size - 1;
 
 			/* Allow zero-byte read from PTR_TO_CTX */
@@ -7419,7 +7417,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				return zero_size_allowed ? 0 : -EACCES;
 
 			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
-						atype, -1, false, false);
+						access_type, -1, false, false);
 		}
 
 		fallthrough;
@@ -7444,6 +7442,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
  */
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg, u32 regno,
+			      enum bpf_access_type access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
@@ -7459,15 +7458,12 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 */
 	meta->msize_max_value = reg->umax_value;
 
-	/* The register is SCALAR_VALUE; the access check
-	 * happens using its boundaries.
+	/* The register is SCALAR_VALUE; the access check happens using
+	 * its boundaries. For unprivileged variable accesses, disable
+	 * raw mode so that the program is required to initialize all
+	 * the memory that the helper could just partially fill up.
 	 */
 	if (!tnum_is_const(reg->var_off))
-		/* For unprivileged variable accesses, disable raw
-		 * mode so that the program is required to
-		 * initialize all the memory that the helper could
-		 * just partially fill up.
-		 */
 		meta = NULL;
 
 	if (reg->smin_value < 0) {
@@ -7487,9 +7483,8 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			regno);
 		return -EACCES;
 	}
-	err = check_helper_mem_access(env, regno - 1,
-				      reg->umax_value,
-				      zero_size_allowed, meta);
+	err = check_helper_mem_access(env, regno - 1, reg->umax_value,
+				      access_type, zero_size_allowed, meta);
 	if (!err)
 		err = mark_chain_precision(env, regno);
 	return err;
@@ -7500,13 +7495,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 {
 	bool may_be_null = type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
-	struct bpf_call_arg_meta meta;
 	int err;
 
 	if (register_is_null(reg))
 		return 0;
 
-	memset(&meta, 0, sizeof(meta));
 	/* Assuming that the register contains a value check if the memory
 	 * access is safe. Temporarily save and restore the register's state as
 	 * the conversion shouldn't be visible to a caller.
@@ -7516,10 +7509,8 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 		mark_ptr_not_null_reg(reg);
 	}
 
-	err = check_helper_mem_access(env, regno, mem_size, true, &meta);
-	/* Check access for BPF_WRITE */
-	meta.raw_mode = true;
-	err = err ?: check_helper_mem_access(env, regno, mem_size, true, &meta);
+	err = check_helper_mem_access(env, regno, mem_size, BPF_READ, true, NULL);
+	err = err ?: check_helper_mem_access(env, regno, mem_size, BPF_WRITE, true, NULL);
 
 	if (may_be_null)
 		*reg = saved_reg;
@@ -7545,13 +7536,12 @@ static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg
 		mark_ptr_not_null_reg(mem_reg);
 	}
 
-	err = check_mem_size_reg(env, reg, regno, true, &meta);
-	/* Check access for BPF_WRITE */
-	meta.raw_mode = true;
-	err = err ?: check_mem_size_reg(env, reg, regno, true, &meta);
+	err = check_mem_size_reg(env, reg, regno, BPF_READ, true, &meta);
+	err = err ?: check_mem_size_reg(env, reg, regno, BPF_WRITE, true, &meta);
 
 	if (may_be_null)
 		*mem_reg = saved_reg;
+
 	return err;
 }
 
@@ -8825,9 +8815,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
-		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->key_size, false,
-					      NULL);
+		err = check_helper_mem_access(env, regno, meta->map_ptr->key_size,
+					      BPF_READ, false, NULL);
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
@@ -8842,9 +8831,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
-		err = check_helper_mem_access(env, regno,
-					      meta->map_ptr->value_size, false,
-					      meta);
+		err = check_helper_mem_access(env, regno, meta->map_ptr->value_size,
+					      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+					      false, meta);
 		break;
 	case ARG_PTR_TO_PERCPU_BTF_ID:
 		if (!reg->btf_id) {
@@ -8886,7 +8875,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 */
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, regno, fn->arg_size[arg], false, meta);
+			err = check_helper_mem_access(env, regno, fn->arg_size[arg],
+						      arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+						      false, meta);
 			if (err)
 				return err;
 			if (arg_type & MEM_ALIGNED)
@@ -8894,10 +8885,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_CONST_SIZE:
-		err = check_mem_size_reg(env, reg, regno, false, meta);
+		err = check_mem_size_reg(env, reg, regno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ?
+					 BPF_WRITE : BPF_READ,
+					 false, meta);
 		break;
 	case ARG_CONST_SIZE_OR_ZERO:
-		err = check_mem_size_reg(env, reg, regno, true, meta);
+		err = check_mem_size_reg(env, reg, regno,
+					 fn->arg_type[arg - 1] & MEM_WRITE ?
+					 BPF_WRITE : BPF_READ,
+					 true, meta);
 		break;
 	case ARG_PTR_TO_DYNPTR:
 		err = process_dynptr_func(env, regno, insn_idx, arg_type, 0);
-- 
2.43.0




