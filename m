Return-Path: <stable+bounces-108751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148E8A12016
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F5A16289A
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ABF248BB1;
	Wed, 15 Jan 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2i5OgOWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2246248BA0;
	Wed, 15 Jan 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937686; cv=none; b=miq1oXJk8hkDYG9GmoO4LQFFjXrbEP+hry1RdgLZCgd/DsFK7ELM0ZVSjp3xDlWH2wXc9+umSLz1WNgBA4sQwruqUp0AtjojjUba+PpeBIVMa/WpGENOHYBTxgMJGX+Ej44ePribht4Q/++IKMU8b8sin0m4uIDETOXriXaL+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937686; c=relaxed/simple;
	bh=TJBUB3F74f328Lp03sA0W+qYM8O7c96bF/AOvCc28PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP0r2mjTW60/ZHIySYWmKzpiCsafnrFP/2+/IySPlXgx5KzXGdG+oyqJjUlalpzDfJ1oI/Gh3sNxbPniw/fGkZJW5MvbF0S38I/kn+vCq2rVXQ4crGPqsoOq7pxsPmYb/QBP7N1DmDVlu5+YgSKTOQ5ydCwyW9z7S38euOPTT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2i5OgOWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA497C4CEE1;
	Wed, 15 Jan 2025 10:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937685;
	bh=TJBUB3F74f328Lp03sA0W+qYM8O7c96bF/AOvCc28PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2i5OgOWVkJBWKifq1FshYod6c35rjn1j2L21831NlUFLDVEUykRRvoNuaXBlFaffV
	 5h2xbWzDkxkNTJ3i2eLM7lUWTOdx/uBiUnN/FDMZ7ASSHtA4koYsjfyQgRHvLp1bk7
	 EoyLFFo8iZK8rImsj7iOWuq1oPutig3vAk6lT51M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lonial Con <kongln9170@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	BRUNO VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 6.1 51/92] bpf: Fix overloading of MEM_UNINITs meaning
Date: Wed, 15 Jan 2025 11:37:09 +0100
Message-ID: <20250115103549.568404960@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103547.522503305@linuxfoundation.org>
References: <20250115103547.522503305@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 8ea607330a39184f51737c6ae706db7fdca7628e upstream.

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
Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   76 +++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5416,7 +5416,8 @@ mark:
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
-				   int access_size, bool zero_size_allowed,
+				   int access_size, enum bpf_access_type access_type,
+				   bool zero_size_allowed,
 				   struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
@@ -5428,7 +5429,7 @@ static int check_helper_mem_access(struc
 		return check_packet_access(env, regno, reg->off, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
-		if (meta && meta->raw_mode) {
+		if (access_type == BPF_WRITE) {
 			verbose(env, "R%d cannot write into %s\n", regno,
 				reg_type_str(env, reg->type));
 			return -EACCES;
@@ -5436,15 +5437,13 @@ static int check_helper_mem_access(struc
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
@@ -5455,7 +5454,7 @@ static int check_helper_mem_access(struc
 					       zero_size_allowed);
 	case PTR_TO_BUF:
 		if (type_is_rdonly_mem(reg->type)) {
-			if (meta && meta->raw_mode) {
+			if (access_type == BPF_WRITE) {
 				verbose(env, "R%d cannot write into %s\n", regno,
 					reg_type_str(env, reg->type));
 				return -EACCES;
@@ -5480,7 +5479,6 @@ static int check_helper_mem_access(struc
 		 * Dynamically check it now.
 		 */
 		if (!env->ops->convert_ctx_access) {
-			enum bpf_access_type atype = meta && meta->raw_mode ? BPF_WRITE : BPF_READ;
 			int offset = access_size - 1;
 
 			/* Allow zero-byte read from PTR_TO_CTX */
@@ -5488,7 +5486,7 @@ static int check_helper_mem_access(struc
 				return zero_size_allowed ? 0 : -EACCES;
 
 			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
-						atype, -1, false);
+						access_type, -1, false);
 		}
 
 		fallthrough;
@@ -5507,6 +5505,7 @@ static int check_helper_mem_access(struc
 
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg, u32 regno,
+			      enum bpf_access_type access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
@@ -5522,15 +5521,12 @@ static int check_mem_size_reg(struct bpf
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
@@ -5541,8 +5537,7 @@ static int check_mem_size_reg(struct bpf
 
 	if (reg->umin_value == 0) {
 		err = check_helper_mem_access(env, regno - 1, 0,
-					      zero_size_allowed,
-					      meta);
+				      access_type, zero_size_allowed, meta);
 		if (err)
 			return err;
 	}
@@ -5552,9 +5547,8 @@ static int check_mem_size_reg(struct bpf
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
@@ -5565,13 +5559,11 @@ int check_mem_reg(struct bpf_verifier_en
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
@@ -5581,10 +5573,8 @@ int check_mem_reg(struct bpf_verifier_en
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
@@ -5610,13 +5600,12 @@ int check_kfunc_mem_size_reg(struct bpf_
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
 
@@ -6227,9 +6216,8 @@ skip_type_check:
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
@@ -6244,9 +6232,9 @@ skip_type_check:
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
@@ -6281,7 +6269,9 @@ skip_type_check:
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
@@ -6289,10 +6279,16 @@ skip_type_check:
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
 		/* We only need to check for initialized / uninitialized helper



