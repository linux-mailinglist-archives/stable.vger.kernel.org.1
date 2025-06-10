Return-Path: <stable+bounces-152308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA861AD3B8E
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A05D7ADDC7
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA50202C5A;
	Tue, 10 Jun 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy6vglmW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E0158A09
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566753; cv=none; b=R5AeRt3m5C1jUsoOxLeFaIe6jlo37ptlvSM+r9D+f70IMtwJcLJCvhSSVrbVOFsulJr8/N6SkA9oj/icIOxniH4BlmRPTyil6EWO8DF4vajOTULvRGfUXHrALynk/IaqRVCWqS1bX5yVLC2vpYN8e+F9GtOBPdnz10h5MOlxMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566753; c=relaxed/simple;
	bh=rD6sD7n6++2IHPnMuJx3W/WMAPI3/m68QLXekeDe6q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7hx9osxjnGg4tIt09yNt9CJrXYBM7A1HZ7zVKyU8D7VYYaGGYHcj1cMXnbDlJLXdLrenMMIqsasrPsGgoxg5zUO5wDdhHMTKXc1bHOnOhhVNqwN4fp7ZdW4Cu0TsUSx9duQmZ1Y5AV82zwMSxCchTRimUI/V8bQvo1Zs4WWniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy6vglmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E25FC4CEEF;
	Tue, 10 Jun 2025 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749566752;
	bh=rD6sD7n6++2IHPnMuJx3W/WMAPI3/m68QLXekeDe6q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yy6vglmWcX52d5A/vVTcBho/C1nf0jFxIflynaww6oKyXEI3Ibg85YxuMWrsjMzUE
	 sD76x2v7iEvWpINcjymVpJZG1nCgLVaKAVJz/8KDsCZx1+czXeNFwNdpLk4q2lpLC6
	 2k6L1TZFwJiUOGdAi6Abjy4IaxlJ8nS/tHTGYISK2oqDcF1ZNFsBn8nKMdYFYjpF7J
	 jAvkIecW46Eie+p0A9WjRP1k/vuEXPJc0JKcF/XZfbV/CjrHr4ZCSymic+kzqnlHPJ
	 wnuZD8F6Ewx7ApJpPct0kcCgNIavV4YObMh/KbmjrNe7K6Ru1fOlOvl7UWJEaFiZsq
	 BsO2lmyNhOBfg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Hao Luo <haoluo@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH stable linux-5.10.y v1 7/8] bpf: Add MEM_RDONLY for helper args that are pointers to rdonly mem.
Date: Tue, 10 Jun 2025 14:44:02 +0000
Message-ID: <20250610144407.95865-8-puranjay@kernel.org>
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

commit 216e3cd2f28dbbf1fe86848e0e29e6693b9f0a20 upstream.

Some helper functions may modify its arguments, for example,
bpf_d_path, bpf_get_stack etc. Previously, their argument types
were marked as ARG_PTR_TO_MEM, which is compatible with read-only
mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate,
but technically incorrect, to modify a read-only memory by passing
it into one of such helper functions.

This patch tags the bpf_args compatible with immutable memory with
MEM_RDONLY flag. The arguments that don't have this flag will be
only compatible with mutable memory types, preventing the helper
from modifying a read-only memory. The bpf_args that have
MEM_RDONLY are compatible with both mutable memory and immutable
memory.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/bpf/20211217003152.48334-9-haoluo@google.com
Cc: stable@vger.kernel.org # 5.10.x
---
 include/linux/bpf.h      |  4 ++-
 kernel/bpf/cgroup.c      |  2 +-
 kernel/bpf/helpers.c     |  6 ++--
 kernel/bpf/ringbuf.c     |  2 +-
 kernel/bpf/verifier.c    | 20 +++++++++++--
 kernel/trace/bpf_trace.c | 22 +++++++-------
 net/core/filter.c        | 62 ++++++++++++++++++++--------------------
 7 files changed, 67 insertions(+), 51 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ceee5a512d25..8efa395a1bb2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -277,7 +277,9 @@ enum bpf_type_flag {
 	/* PTR may be NULL. */
 	PTR_MAYBE_NULL		= BIT(0 + BPF_BASE_TYPE_BITS),
 
-	/* MEM is read-only. */
+	/* MEM is read-only. When applied on bpf_arg, it indicates the arg is
+	 * compatible with both mutable and immutable memory.
+	 */
 	MEM_RDONLY		= BIT(1 + BPF_BASE_TYPE_BITS),
 
 	__BPF_TYPE_LAST_FLAG	= MEM_RDONLY,
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 85927c2aa343..54321df6cfac 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1738,7 +1738,7 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3e5466693615..d9d65bbaf210 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -516,7 +516,7 @@ const struct bpf_func_proto bpf_strtol_proto = {
 	.func		= bpf_strtol,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
@@ -544,7 +544,7 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.func		= bpf_strtoul,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
@@ -616,7 +616,7 @@ const struct bpf_func_proto bpf_event_output_data_proto =  {
 	.arg1_type      = ARG_PTR_TO_CTX,
 	.arg2_type      = ARG_CONST_MAP_PTR,
 	.arg3_type      = ARG_ANYTHING,
-	.arg4_type      = ARG_PTR_TO_MEM,
+	.arg4_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
 };
 
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index eac0026e2fa6..149af5a50cdd 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -483,7 +483,7 @@ const struct bpf_func_proto bpf_ringbuf_output_proto = {
 	.func		= bpf_ringbuf_output,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03e40ee02c0c..d9417244d3b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4602,7 +4602,6 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
 		PTR_TO_BUF,
-		PTR_TO_BUF | MEM_RDONLY,
 	},
 };
 
@@ -4663,6 +4662,21 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 		return -EFAULT;
 	}
 
+	/* ARG_PTR_TO_MEM + RDONLY is compatible with PTR_TO_MEM and PTR_TO_MEM + RDONLY,
+	 * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM and NOT with PTR_TO_MEM + RDONLY
+	 *
+	 * Same for MAYBE_NULL:
+	 *
+	 * ARG_PTR_TO_MEM + MAYBE_NULL is compatible with PTR_TO_MEM and PTR_TO_MEM + MAYBE_NULL,
+	 * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM but NOT with PTR_TO_MEM + MAYBE_NULL
+	 *
+	 * Therefore we fold these flags depending on the arg_type before comparison.
+	 */
+	if (arg_type & MEM_RDONLY)
+		type &= ~MEM_RDONLY;
+	if (arg_type & PTR_MAYBE_NULL)
+		type &= ~PTR_MAYBE_NULL;
+
 	for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
 		expected = compatible->types[i];
 		if (expected == NOT_INIT)
@@ -4672,14 +4686,14 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			goto found;
 	}
 
-	verbose(env, "R%d type=%s expected=", regno, reg_type_str(env, type));
+	verbose(env, "R%d type=%s expected=", regno, reg_type_str(env, reg->type));
 	for (j = 0; j + 1 < i; j++)
 		verbose(env, "%s, ", reg_type_str(env, compatible->types[j]));
 	verbose(env, "%s\n", reg_type_str(env, compatible->types[j]));
 	return -EACCES;
 
 found:
-	if (type == PTR_TO_BTF_ID) {
+	if (reg->type == PTR_TO_BTF_ID) {
 		if (!arg_btf_id) {
 			if (!compatible->btf_id) {
 				verbose(env, "verifier internal error: missing arg compatible BTF ID\n");
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6957381b139c..fc80e7a1db2a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -342,7 +342,7 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
@@ -545,7 +545,7 @@ static const struct bpf_func_proto bpf_trace_printk_proto = {
 	.func		= bpf_trace_printk,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM,
+	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE,
 };
 
@@ -754,9 +754,9 @@ static const struct bpf_func_proto bpf_seq_printf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
-	.arg4_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg4_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg5_type      = ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -771,7 +771,7 @@ static const struct bpf_func_proto bpf_seq_write_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -795,7 +795,7 @@ static const struct bpf_func_proto bpf_seq_printf_btf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &btf_seq_file_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -956,7 +956,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1247,7 +1247,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_MEM,
 	.arg2_type	= ARG_CONST_SIZE,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -1422,7 +1422,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_tp = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1640,7 +1640,7 @@ static const struct bpf_func_proto bpf_perf_event_output_proto_raw_tp = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -1694,7 +1694,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_raw_tp = {
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
diff --git a/net/core/filter.c b/net/core/filter.c
index b262cad02bad..68d2c3ae9878 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1724,7 +1724,7 @@ static const struct bpf_func_proto bpf_skb_store_bytes_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -2032,9 +2032,9 @@ static const struct bpf_func_proto bpf_csum_diff_proto = {
 	.gpl_only	= false,
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
-	.arg3_type	= ARG_PTR_TO_MEM_OR_NULL,
+	.arg3_type	= ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE_OR_ZERO,
 	.arg5_type	= ARG_ANYTHING,
 };
@@ -2581,7 +2581,7 @@ static const struct bpf_func_proto bpf_redirect_neigh_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
+	.arg2_type      = ARG_PTR_TO_MEM | PTR_MAYBE_NULL | MEM_RDONLY,
 	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -4253,7 +4253,7 @@ static const struct bpf_func_proto bpf_skb_event_output_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -4267,7 +4267,7 @@ const struct bpf_func_proto bpf_skb_output_proto = {
 	.arg1_btf_id	= &bpf_skb_output_btf_ids[0],
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -4450,7 +4450,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_key_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
@@ -4476,7 +4476,7 @@ static const struct bpf_func_proto bpf_skb_set_tunnel_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
@@ -4646,7 +4646,7 @@ static const struct bpf_func_proto bpf_xdp_event_output_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -4660,7 +4660,7 @@ const struct bpf_func_proto bpf_xdp_output_proto = {
 	.arg1_btf_id	= &bpf_xdp_output_btf_ids[0],
 	.arg2_type	= ARG_CONST_MAP_PTR,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE_OR_ZERO,
 };
 
@@ -5078,7 +5078,7 @@ static const struct bpf_func_proto bpf_sock_addr_setsockopt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -5112,7 +5112,7 @@ static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
 	.arg3_type	= ARG_ANYTHING,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -5287,7 +5287,7 @@ static const struct bpf_func_proto bpf_bind_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 };
 
@@ -5748,7 +5748,7 @@ static const struct bpf_func_proto bpf_lwt_in_push_encap_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -5758,7 +5758,7 @@ static const struct bpf_func_proto bpf_lwt_xmit_push_encap_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -5801,7 +5801,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_store_bytes_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -5889,7 +5889,7 @@ static const struct bpf_func_proto bpf_lwt_seg6_action_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
 	.arg2_type	= ARG_ANYTHING,
-	.arg3_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg4_type	= ARG_CONST_SIZE
 };
 
@@ -6136,7 +6136,7 @@ static const struct bpf_func_proto bpf_skc_lookup_tcp_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6155,7 +6155,7 @@ static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6174,7 +6174,7 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6211,7 +6211,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 	.pkt_access     = true,
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6234,7 +6234,7 @@ static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
 	.pkt_access     = true,
 	.ret_type       = RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6257,7 +6257,7 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
 	.pkt_access     = true,
 	.ret_type       = RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type      = ARG_PTR_TO_CTX,
-	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg2_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type      = ARG_CONST_SIZE,
 	.arg4_type      = ARG_ANYTHING,
 	.arg5_type      = ARG_ANYTHING,
@@ -6276,7 +6276,7 @@ static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6295,7 +6295,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6314,7 +6314,7 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 	.arg5_type	= ARG_ANYTHING,
@@ -6636,9 +6636,9 @@ static const struct bpf_func_proto bpf_tcp_check_syncookie_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -6705,9 +6705,9 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
 	.pkt_access	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
-	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg4_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg5_type	= ARG_CONST_SIZE,
 };
 
@@ -6938,7 +6938,7 @@ static const struct bpf_func_proto bpf_sock_ops_store_hdr_opt_proto = {
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_CTX,
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
 	.arg3_type	= ARG_CONST_SIZE,
 	.arg4_type	= ARG_ANYTHING,
 };
-- 
2.47.1


