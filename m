Return-Path: <stable+bounces-79016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C398D61D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1A21C2231F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD31D0426;
	Wed,  2 Oct 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0nO/OJFr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503921D0173;
	Wed,  2 Oct 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876194; cv=none; b=S5kEJbIWBZsxneUU1gi3bKk0OAGFSjFBYRH5sPKXueXX4kcAybEcUcRX/p5knMrKR2T1260PYgYFOHHI56r5pYybFXMbOGwSop//iwcKQLyM5kUByAEI4kB5myK3sJb2+jgyEnU059s+OnTqYZo0d3zkUkt5cgFyEBAy1peOlno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876194; c=relaxed/simple;
	bh=7PMQ3p3cu9mmzBI9Ipku9/KbXyxzdXImXWIZ77WCRiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gk3QziFLJ7UX4fmGdGrodC/MRO/3JtcoVe9rr13TvwWYaR/ePGHz/COIodMUYcrqPd6GnIMd6gumpWkTgeurrNKkXDyb/Ndp4CigmHAKRPgu0WaP+JQL3cM+6+0FO/g9Jk30GFjx2sWwzC2vALeFaIOEZ76v/BZL/agMhTCXZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0nO/OJFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DC9C4CEC5;
	Wed,  2 Oct 2024 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876194;
	bh=7PMQ3p3cu9mmzBI9Ipku9/KbXyxzdXImXWIZ77WCRiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0nO/OJFruNQPxygabuz4LXJwT3dO8WdCdbMgVjjof40Sx71poMAPsiWuGiKNfELgA
	 JB6A33d9IP62rvNzE7xIvyHSrvILVFctxFZ7mw66Xfpd1P/C1vBzfLMT3D8HJRuDLe
	 YRkXJc9ebTU4c2dKnRQAZM0B3fleZzX4hsL+aojs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lonial Con <kongln9170@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 320/695] bpf: Fix helper writes to read-only maps
Date: Wed,  2 Oct 2024 14:55:18 +0200
Message-ID: <20241002125835.223778225@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

[ Upstream commit 32556ce93bc45c730829083cb60f95a2728ea48b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h      |  7 +++++--
 kernel/bpf/helpers.c     |  6 ++++--
 kernel/bpf/syscall.c     |  3 ++-
 kernel/bpf/verifier.c    | 41 +++++-----------------------------------
 kernel/trace/bpf_trace.c |  6 ++++--
 net/core/filter.c        |  6 ++++--
 6 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b051122f62a4f..70fa4ffc3879f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -694,6 +694,11 @@ enum bpf_type_flag {
 	/* DYNPTR points to xdp_buff */
 	DYNPTR_TYPE_XDP		= BIT(16 + BPF_BASE_TYPE_BITS),
 
+	/* Memory must be aligned on some architectures, used in combination with
+	 * MEM_FIXED_SIZE.
+	 */
+	MEM_ALIGNED		= BIT(17 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -731,8 +736,6 @@ enum bpf_arg_type {
 	ARG_ANYTHING,		/* any (initialized) argument is ok */
 	ARG_PTR_TO_SPIN_LOCK,	/* pointer to bpf_spin_lock */
 	ARG_PTR_TO_SOCK_COMMON,	/* pointer to sock_common */
-	ARG_PTR_TO_INT,		/* pointer to int */
-	ARG_PTR_TO_LONG,	/* pointer to long */
 	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
 	ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
 	ARG_PTR_TO_RINGBUF_MEM,	/* pointer to dynamically reserved ringbuf memory */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 17a757c78b488..b305b116ce125 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -538,7 +538,8 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(s64),
 };
 
 BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
@@ -566,7 +567,8 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(u64),
 };
 
 BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bf6c5f685ea22..efb7ff89fe2e2 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5952,7 +5952,8 @@ static const struct bpf_func_proto bpf_kallsyms_lookup_name_proto = {
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_LONG,
+	.arg4_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg4_size	= sizeof(u64),
 };
 
 static const struct bpf_func_proto *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 62cd315984042..e3abf560e405f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8180,16 +8180,6 @@ static bool arg_type_is_dynptr(enum bpf_arg_type type)
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
@@ -8262,16 +8252,6 @@ static const struct bpf_reg_types mem_types = {
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
 static const struct bpf_reg_types spin_lock_types = {
 	.types = {
 		PTR_TO_MAP_VALUE,
@@ -8327,8 +8307,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
 	[ARG_PTR_TO_RINGBUF_MEM]	= &ringbuf_mem_types,
-	[ARG_PTR_TO_INT]		= &int_ptr_types,
-	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
 	[ARG_PTR_TO_STACK]		= &stack_ptr_types,
@@ -8889,9 +8867,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -8916,17 +8896,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
 		err = check_reg_const_str(env, reg, regno);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251c..0b6df2c6ebe08 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1226,7 +1226,8 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_LONG,
+	.arg3_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u64),
 };
 
 BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
@@ -1242,7 +1243,8 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 	.func		= get_func_ret,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_LONG,
+	.arg2_type	= ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg2_size	= sizeof(u64),
 };
 
 BPF_CALL_1(get_func_arg_cnt, void *, ctx)
diff --git a/net/core/filter.c b/net/core/filter.c
index 78a6f746ea0ba..88588dae20267 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6346,7 +6346,8 @@ static const struct bpf_func_proto bpf_skb_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
@@ -6357,7 +6358,8 @@ static const struct bpf_func_proto bpf_xdp_check_mtu_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_ANYTHING,
-	.arg3_type      = ARG_PTR_TO_INT,
+	.arg3_type      = ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UNINIT | MEM_ALIGNED,
+	.arg3_size	= sizeof(u32),
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
 };
-- 
2.43.0




