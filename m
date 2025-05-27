Return-Path: <stable+bounces-147514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A949CAC57FD
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67C54C013E
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC80627FD49;
	Tue, 27 May 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jCErAcxm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5F86347;
	Tue, 27 May 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367576; cv=none; b=copyIYZ5BKmIfgK7BG4JZVZZd3IpR9El35LfpYThIMnpuG4rvo+XPhkI2Q3Cr8bExcRns4DMXel9HVzng0jYHXpXtfam2U5lx0q76qCp9kKOWoYvfyNURkOGg0J8FTLFHFPKOdw2LayerdYrqd+SBk+2FrptGnDDtzDysCZ3EFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367576; c=relaxed/simple;
	bh=qqDxljNpEDnVKlfrrB1VLICmNurUj5BqCK1cev0vxGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT5eyvivmM2Ecoa0vepVlYvlYlgX50f6tFOlYKzE8SoIt5VGDLO/blboLNHXWF2stxWofLnobfNii3joH1qa0l1SDzZekztKh3OnEBxrbyyCmfWRAa2jSjqYRCWv6o6ALM128vI7UiaLGcfB7mXqWkYtzV5X82vBCMYREnm3A28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jCErAcxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DA1C4CEE9;
	Tue, 27 May 2025 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367576;
	bh=qqDxljNpEDnVKlfrrB1VLICmNurUj5BqCK1cev0vxGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCErAcxm3hW6GqI54w4igycFtFghIQJNv03jx4DfpC3dpF/fDume33n/nUUF6bbj2
	 t8XqY9DkGRrDZ3Ie8epXEY+W4TKeDrDQsfM1zA3s4yOkMVj4ELxcnQ85H8aiZOykxa
	 Qvm5V8Y1+c92RUdouol+JWpw09/WZ4pxkw7fQhKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amery Hung <ameryhung@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 431/783] bpf: Make every prog keep a copy of ctx_arg_info
Date: Tue, 27 May 2025 18:23:48 +0200
Message-ID: <20250527162530.674916339@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 432051806f614ca512da401b80257b95b2a2241e ]

Currently, ctx_arg_info is read-only in the view of the verifier since
it is shared among programs of the same attach type. Make each program
have their own copy of ctx_arg_info so that we can use it to store
program specific information.

In the next patch where we support acquiring a referenced kptr through a
struct_ops argument tagged with "__ref", ctx_arg_info->ref_obj_id will
be used to store the unique reference object id of the argument. This
avoids creating a requirement in the verifier that "__ref" tagged
arguments must be the first set of references acquired [0].

[0] https://lore.kernel.org/bpf/20241220195619.2022866-2-amery.hung@gmail.com/

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20250217190640.1748177-2-ameryhung@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h   |  7 +++++--
 kernel/bpf/bpf_iter.c | 13 ++++++-------
 kernel/bpf/syscall.c  |  1 +
 kernel/bpf/verifier.c | 22 ++++++++++++----------
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3f50e29d6392..f4df39e8c7357 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1507,7 +1507,7 @@ struct bpf_prog_aux {
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
 	struct btf *attach_btf;
-	const struct bpf_ctx_arg_aux *ctx_arg_info;
+	struct bpf_ctx_arg_aux *ctx_arg_info;
 	void __percpu *priv_stack_ptr;
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog becomes visible */
 	struct bpf_prog *dst_prog;
@@ -1945,6 +1945,9 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 
 #endif
 
+int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
+			       const struct bpf_ctx_arg_aux *info, u32 cnt);
+
 #if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
 int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 				    int cgroup_atype);
@@ -2546,7 +2549,7 @@ struct bpf_iter__bpf_map_elem {
 
 int bpf_iter_reg_target(const struct bpf_iter_reg *reg_info);
 void bpf_iter_unreg_target(const struct bpf_iter_reg *reg_info);
-bool bpf_iter_prog_supported(struct bpf_prog *prog);
+int bpf_iter_prog_supported(struct bpf_prog *prog);
 const struct bpf_func_proto *
 bpf_iter_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 int bpf_iter_link_attach(const union bpf_attr *attr, bpfptr_t uattr, struct bpf_prog *prog);
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 106735145948b..380e9a7cac75d 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -335,7 +335,7 @@ static void cache_btf_id(struct bpf_iter_target_info *tinfo,
 	tinfo->btf_id = prog->aux->attach_btf_id;
 }
 
-bool bpf_iter_prog_supported(struct bpf_prog *prog)
+int bpf_iter_prog_supported(struct bpf_prog *prog)
 {
 	const char *attach_fname = prog->aux->attach_func_name;
 	struct bpf_iter_target_info *tinfo = NULL, *iter;
@@ -344,7 +344,7 @@ bool bpf_iter_prog_supported(struct bpf_prog *prog)
 	int prefix_len = strlen(prefix);
 
 	if (strncmp(attach_fname, prefix, prefix_len))
-		return false;
+		return -EINVAL;
 
 	mutex_lock(&targets_mutex);
 	list_for_each_entry(iter, &targets, list) {
@@ -360,12 +360,11 @@ bool bpf_iter_prog_supported(struct bpf_prog *prog)
 	}
 	mutex_unlock(&targets_mutex);
 
-	if (tinfo) {
-		prog->aux->ctx_arg_info_size = tinfo->reg_info->ctx_arg_info_size;
-		prog->aux->ctx_arg_info = tinfo->reg_info->ctx_arg_info;
-	}
+	if (!tinfo)
+		return -EINVAL;
 
-	return tinfo != NULL;
+	return bpf_prog_ctx_arg_info_init(prog, tinfo->reg_info->ctx_arg_info,
+					  tinfo->reg_info->ctx_arg_info_size);
 }
 
 const struct bpf_func_proto *
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8c42c094f0d1e..32a8d5fd98612 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2314,6 +2314,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 	kvfree(prog->aux->jited_linfo);
 	kvfree(prog->aux->linfo);
 	kfree(prog->aux->kfunc_tab);
+	kfree(prog->aux->ctx_arg_info);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0752e8e556389..4392436ba7511 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22429,6 +22429,15 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		env->peak_states, env->longest_mark_read_walk);
 }
 
+int bpf_prog_ctx_arg_info_init(struct bpf_prog *prog,
+			       const struct bpf_ctx_arg_aux *info, u32 cnt)
+{
+	prog->aux->ctx_arg_info = kmemdup_array(info, cnt, sizeof(*info), GFP_KERNEL);
+	prog->aux->ctx_arg_info_size = cnt;
+
+	return prog->aux->ctx_arg_info ? 0 : -ENOMEM;
+}
+
 static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
@@ -22509,17 +22518,12 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EACCES;
 	}
 
-	/* btf_ctx_access() used this to provide argument type info */
-	prog->aux->ctx_arg_info =
-		st_ops_desc->arg_info[member_idx].info;
-	prog->aux->ctx_arg_info_size =
-		st_ops_desc->arg_info[member_idx].cnt;
-
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
 
-	return 0;
+	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
+					  st_ops_desc->arg_info[member_idx].cnt);
 }
 #define SECURITY_PREFIX "security_"
 
@@ -22996,9 +23000,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		prog->aux->attach_btf_trace = true;
 		return 0;
 	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
-		if (!bpf_iter_prog_supported(prog))
-			return -EINVAL;
-		return 0;
+		return bpf_iter_prog_supported(prog);
 	}
 
 	if (prog->type == BPF_PROG_TYPE_LSM) {
-- 
2.39.5




