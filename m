Return-Path: <stable+bounces-102514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D86E9EF40E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE84177898
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B3E2236FC;
	Thu, 12 Dec 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WUgamRmY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5446A21CFEA;
	Thu, 12 Dec 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021507; cv=none; b=jScje1P3lJV1Qy+b96ZUMgulcHodzNLLeNJjawjCSsfRKuKA+AVzZcwWhJHKKdFkpiUNl+2o/57N3CST3eb2fCjp1TRtMJ4jMg2iUr1MyCuSVDIpVWlCLrCdOOFPePv7G1OjjltTy87idLqNtpy49k9oeiWnuGyEfn7EjNX0krA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021507; c=relaxed/simple;
	bh=k1Uw/UfOmAarwFaDgzHOtLH9ovykdEFZOxTqcMOcsaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ub7rUcFPN3uFf3xA3eH0JUv1crqsD+Fyo+FePWQwNumpwiSd1aQyHKeCgXookoCLr6LKPnYTnev8X2KMN+Kt/RbKYTYIxZqCP8EQ9QBV6Gtsi9OLPnUT9XpLUVIpigqN1Z4jIftbb/2y/yKbQQlDKkR2KcbiZnKtLd8yxJYJodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WUgamRmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D63C4CECE;
	Thu, 12 Dec 2024 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021505;
	bh=k1Uw/UfOmAarwFaDgzHOtLH9ovykdEFZOxTqcMOcsaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUgamRmY3tIILQg8Ew9SdtxsMfMF9h7B7iGJeLkrtLbcXTTw/ElY4YTzKNpe2Ee8h
	 XHKzPtezpgmixp0ttJJB0iIeCvKhSLycxkppTyT/p6JcRWiASHAmdZs12OkSydmcSt
	 nL3deZNxYAA0xAErAjojguwtwJqx6oomkeHOzs5A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lonial Con <kongln9170@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Bin Lan <bin.lan.cn@windriver.com>
Subject: [PATCH 6.1 757/772] bpf: Fix helper writes to read-only maps
Date: Thu, 12 Dec 2024 16:01:42 +0100
Message-ID: <20241212144421.217823679@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 32556ce93bc45c730829083cb60f95a2728ea48b upstream.

Lonial found an issue that despite user- and BPF-side frozen BPF map
(like in case of .rodata), it was still possible to write into it from
a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT}
as arguments.

In check_func_arg() when the argument is as mentioned, the meta->raw_mode
is never set. Later, check_helper_mem_access(), under the case of
PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
subsequent call to check_map_access_type() and given the BPF map is
read-only it succeeds.

The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM_UNINIT
when results are written into them as opposed to read out of them. The
latter indicates that it's okay to pass a pointer to uninitialized memory
as the memory is written to anyway.

However, ARG_PTR_TO_{LONG,INT} is a special case of ARG_PTR_TO_FIXED_SIZE_MEM
just with additional alignment requirement. So it is better to just get
rid of the ARG_PTR_TO_{LONG,INT} special cases altogether and reuse the
fixed size memory types. For this, add MEM_ALIGNED to additionally ensure
alignment given these helpers write directly into the args via *<ptr> = val.
The .arg*_size has been initialized reflecting the actual sizeof(*<ptr>).

MEM_ALIGNED can only be used in combination with MEM_FIXED_SIZE annotated
argument types, since in !MEM_FIXED_SIZE cases the verifier does not know
the buffer size a priori and therefore cannot blindly write *<ptr> = val.

Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Link: https://lore.kernel.org/r/20240913191754.13290-3-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ Resolve merge conflict in include/linux/bpf.h and merge conflict in
  kernel/bpf/verifier.c.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bpf.h      |    7 +++++--
 kernel/bpf/helpers.c     |    6 ++++--
 kernel/bpf/syscall.c     |    3 ++-
 kernel/bpf/verifier.c    |   41 +++++------------------------------------
 kernel/trace/bpf_trace.c |    6 ++++--
 net/core/filter.c        |    6 ++++--
 6 files changed, 24 insertions(+), 45 deletions(-)

--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -475,6 +475,11 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* Memory must be aligned on some architectures, used in combination with
+	 * MEM_FIXED_SIZE.
+	 */
+	MEM_ALIGNED		= BIT(17 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -510,8 +515,6 @@ enum bpf_arg_type {
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
-	ARG_PTR_TO_INT,		/* pointer to int */
-	ARG_PTR_TO_LONG,	/* pointer to long */
 	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
 	ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
 	ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -531,7 +531,8 @@ const struct bpf_func_proto bpf_strtol_p
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(s64),
 };
 
 BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
@@ -560,7 +561,8 @@ const struct bpf_func_proto bpf_strtoul_
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(u64),
 };
 
 BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5260,7 +5260,8 @@ static const struct bpf_func_proto bpf_k
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(u64),
 };
 
 static const struct bpf_func_proto *
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5818,16 +5818,6 @@ static bool arg_type_is_dynptr(enum bpf_
 	return base_type(type) == ARG_PTR_TO_DYNPTR;
 }
 
-static int int_ptr_type_to_size(enum bpf_arg_type type)
-{
-	if (type == ARG_PTR_TO_INT)
-		return sizeof(u32);
-	else if (type == ARG_PTR_TO_LONG)
-		return sizeof(u64);
-
-	return -EINVAL;
-}
-
 static int resolve_map_arg_type(struct bpf_verifier_env *env,
 				 const struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type)
@@ -5908,16 +5898,6 @@ static const struct bpf_reg_types mem_ty
 	},
 };
 
-static const struct bpf_reg_types int_ptr_types = {
-	.types = {
-		PTR_TO_STACK,
-		PTR_TO_PACKET,
-		PTR_TO_PACKET_META,
-		PTR_TO_MAP_KEY,
-		PTR_TO_MAP_VALUE,
-	},
-};
-
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
@@ -5955,8 +5935,6 @@ static const struct bpf_reg_types *compa
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
 	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
-	[ARG_PTR_TO_INT]		= &int_ptr_types,
-	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
 	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
@@ -6303,9 +6281,11 @@ skip_type_check:
 		 */
 		meta->raw_mode = arg_type & MEM_UNINIT;
 		if (arg_type & MEM_FIXED_SIZE) {
-			err = check_helper_mem_access(env, regno,
-						      fn->arg_size[arg], false,
-						      meta);
+			err = check_helper_mem_access(env, regno, fn->arg_size[arg], false, meta);
+			if (err)
+				return err;
+			if (arg_type & MEM_ALIGNED)
+				err = check_ptr_alignment(env, reg, 0, fn->arg_size[arg], true);
 		}
 		break;
 	case ARG_CONST_SIZE:
@@ -6373,17 +6353,6 @@ skip_type_check:
 		if (err)
 			return err;
 		break;
-	case ARG_PTR_TO_INT:
-	case ARG_PTR_TO_LONG:
-	{
-		int size = int_ptr_type_to_size(arg_type);
-
-		err = check_helper_mem_access(env, regno, size, false, meta);
-		if (err)
-			return err;
-		err = check_ptr_alignment(env, reg, 0, size, true);
-		break;
-	}
 	case ARG_PTR_TO_CONST_STR:
 	{
 		struct bpf_map *map = reg->map_ptr;
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1192,7 +1192,8 @@ static const struct bpf_func_proto bpf_g
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_LONG,
+	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u64),
 };
 
 BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
@@ -1208,7 +1209,8 @@ static const struct bpf_func_proto bpf_g
 	.func		= get_func_ret,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_LONG,
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg2_size	= sizeof(u64),
 };
 
 BPF_CALL_1(get_func_arg_cnt, void *, ctx)
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6233,7 +6233,8 @@ static const struct bpf_func_proto bpf_s
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -6244,7 +6245,8 @@ static const struct bpf_func_proto bpf_x
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };



