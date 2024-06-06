Return-Path: <stable+bounces-49031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E98FEB93
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47E4B2266F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5776B19A288;
	Thu,  6 Jun 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RTYJ9pZq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1482B196DA0;
	Thu,  6 Jun 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683267; cv=none; b=AeyyW9VyV/hQ9y0BAiZ1Vj4UFlXsmIIpAjUxE+EaooKyZVkFLddlseVzAAuGrVb1mDWG4fIBFKz8wjPES1JUXYegc7VYGwSeRIsJ/mO24/U9et00G/iNB1zsmhcaV94zv5f+FPtWGXCpZ1IAh+qpSQhmfW1RTZwWD1UKHD7c32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683267; c=relaxed/simple;
	bh=QZiT9B6CooDEgbN5PER0Pd0/wtTEm5YiplHulolPYtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQoQAJhcJr0Fn5K/1EP+nfIlVOZBrIX9jgDymyyxVlrNU6Ka8CjXIpD2P3x3cqAj3+jYWxxATGOnYuxQTa5THmVIaqyLzJo7zs5D78pcqpOSoSw9BlrKL8XnbaZ3y3sqXMir2gMvhnVkRk6pI/KVrQ2OoxRdJop5vms315My60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RTYJ9pZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69DCC32781;
	Thu,  6 Jun 2024 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683267;
	bh=QZiT9B6CooDEgbN5PER0Pd0/wtTEm5YiplHulolPYtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTYJ9pZqKsxqCt9LNfmBrWWe4CsV1zbZ7kawqkycA2ERvYi9xpUxZ63saYyg2mjqL
	 Wx695Q06ByR2SFQIviSxVBnkFo3IkxvRAHxqchGmRvuUZNM97rGn5I4IZMqFG3VNB7
	 /+B4JF35DHf1qtrUW8VHS8XrhZ1lgOFxaTjHrJlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liam Wisehart <liamwisehart@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 211/744] bpf: Fix verifier assumptions about socket->sk
Date: Thu,  6 Jun 2024 15:58:03 +0200
Message-ID: <20240606131739.159640735@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit 0db63c0b86e981a1e97d2596d64ceceba1a5470e ]

The verifier assumes that 'sk' field in 'struct socket' is valid
and non-NULL when 'socket' pointer itself is trusted and non-NULL.
That may not be the case when socket was just created and
passed to LSM socket_accept hook.
Fix this verifier assumption and adjust tests.

Reported-by: Liam Wisehart <liamwisehart@meta.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20240427002544.68803-1-alexei.starovoitov@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c                         | 23 +++++++++++++++----
 .../bpf/progs/bench_local_storage_create.c    |  5 ++--
 .../selftests/bpf/progs/local_storage.c       | 20 ++++++++--------
 .../testing/selftests/bpf/progs/lsm_cgroup.c  |  8 +++++--
 4 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 105fa54a492ab..1385d01a21e4f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2539,6 +2539,8 @@ static void mark_btf_ld_reg(struct bpf_verifier_env *env,
 	regs[regno].type = PTR_TO_BTF_ID | flag;
 	regs[regno].btf = btf;
 	regs[regno].btf_id = btf_id;
+	if (type_may_be_null(flag))
+		regs[regno].id = ++env->id_gen;
 }
 
 #define DEF_NOT_SUBREG	(0)
@@ -5373,8 +5375,6 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 				rcu_safe_kptr(kptr_field) && in_rcu_cs(env) ?
 				PTR_MAYBE_NULL | MEM_RCU :
 				PTR_MAYBE_NULL | PTR_UNTRUSTED);
-		/* For mark_ptr_or_null_reg */
-		val_reg->id = ++env->id_gen;
 	} else if (class == BPF_STX) {
 		val_reg = reg_state(env, value_regno);
 		if (!register_is_null(val_reg) &&
@@ -5684,7 +5684,8 @@ static bool is_trusted_reg(const struct bpf_reg_state *reg)
 		return true;
 
 	/* Types listed in the reg2btf_ids are always trusted */
-	if (reg2btf_ids[base_type(reg->type)])
+	if (reg2btf_ids[base_type(reg->type)] &&
+	    !bpf_type_has_unsafe_modifiers(reg->type))
 		return true;
 
 	/* If a register is not referenced, it is trusted if it has the
@@ -6263,6 +6264,7 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
 #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
 #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_null)
 #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
+#define BTF_TYPE_SAFE_TRUSTED_OR_NULL(__type)  __PASTE(__type, __safe_trusted_or_null)
 
 /*
  * Allow list few fields as RCU trusted or full trusted.
@@ -6326,7 +6328,7 @@ BTF_TYPE_SAFE_TRUSTED(struct dentry) {
 	struct inode *d_inode;
 };
 
-BTF_TYPE_SAFE_TRUSTED(struct socket) {
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
 
@@ -6361,11 +6363,20 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct dentry));
-	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct socket));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
 
+static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
+				    struct bpf_reg_state *reg,
+				    const char *field_name, u32 btf_id)
+{
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
+
+	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
+					  "__safe_trusted_or_null");
+}
+
 static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *regs,
 				   int regno, int off, int size,
@@ -6474,6 +6485,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		 */
 		if (type_is_trusted(env, reg, field_name, btf_id)) {
 			flag |= PTR_TRUSTED;
+		} else if (type_is_trusted_or_null(env, reg, field_name, btf_id)) {
+			flag |= PTR_TRUSTED | PTR_MAYBE_NULL;
 		} else if (in_rcu_cs(env) && !type_may_be_null(reg->type)) {
 			if (type_is_rcu(env, reg, field_name, btf_id)) {
 				/* ignore __rcu tag and mark it MEM_RCU */
diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
index e4bfbba6c1936..c8ec0d0368e4a 100644
--- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
@@ -61,14 +61,15 @@ SEC("lsm.s/socket_post_create")
 int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	     int protocol, int kern)
 {
+	struct sock *sk = sock->sk;
 	struct storage *stg;
 	__u32 pid;
 
 	pid = bpf_get_current_pid_tgid() >> 32;
-	if (pid != bench_pid)
+	if (pid != bench_pid || !sk)
 		return 0;
 
-	stg = bpf_sk_storage_get(&sk_storage_map, sock->sk, NULL,
+	stg = bpf_sk_storage_get(&sk_storage_map, sk, NULL,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
 
 	if (stg)
diff --git a/tools/testing/selftests/bpf/progs/local_storage.c b/tools/testing/selftests/bpf/progs/local_storage.c
index bc8ea56671a16..3bf75f4ea690a 100644
--- a/tools/testing/selftests/bpf/progs/local_storage.c
+++ b/tools/testing/selftests/bpf/progs/local_storage.c
@@ -140,11 +140,12 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
+	struct sock *sk = sock->sk;
 
-	if (pid != monitored_pid)
+	if (pid != monitored_pid || !sk)
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0, 0);
+	storage = bpf_sk_storage_get(&sk_storage_map, sk, 0, 0);
 	if (!storage)
 		return 0;
 
@@ -155,24 +156,24 @@ int BPF_PROG(socket_bind, struct socket *sock, struct sockaddr *address,
 	/* This tests that we can associate multiple elements
 	 * with the local storage.
 	 */
-	storage = bpf_sk_storage_get(&sk_storage_map2, sock->sk, 0,
+	storage = bpf_sk_storage_get(&sk_storage_map2, sk, 0,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
-	if (bpf_sk_storage_delete(&sk_storage_map2, sock->sk))
+	if (bpf_sk_storage_delete(&sk_storage_map2, sk))
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map2, sock->sk, 0,
+	storage = bpf_sk_storage_get(&sk_storage_map2, sk, 0,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
 
-	if (bpf_sk_storage_delete(&sk_storage_map, sock->sk))
+	if (bpf_sk_storage_delete(&sk_storage_map, sk))
 		return 0;
 
 	/* Ensure that the sk_storage_map is disconnected from the storage. */
-	if (!sock->sk->sk_bpf_storage || sock->sk->sk_bpf_storage->smap)
+	if (!sk->sk_bpf_storage || sk->sk_bpf_storage->smap)
 		return 0;
 
 	sk_storage_result = 0;
@@ -185,11 +186,12 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct local_storage *storage;
+	struct sock *sk = sock->sk;
 
-	if (pid != monitored_pid)
+	if (pid != monitored_pid || !sk)
 		return 0;
 
-	storage = bpf_sk_storage_get(&sk_storage_map, sock->sk, 0,
+	storage = bpf_sk_storage_get(&sk_storage_map, sk, 0,
 				     BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
index 02c11d16b692a..d7598538aa2da 100644
--- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -103,11 +103,15 @@ static __always_inline int real_bind(struct socket *sock,
 				     int addrlen)
 {
 	struct sockaddr_ll sa = {};
+	struct sock *sk = sock->sk;
 
-	if (sock->sk->__sk_common.skc_family != AF_PACKET)
+	if (!sk)
+		return 1;
+
+	if (sk->__sk_common.skc_family != AF_PACKET)
 		return 1;
 
-	if (sock->sk->sk_kern_sock)
+	if (sk->sk_kern_sock)
 		return 1;
 
 	bpf_probe_read_kernel(&sa, sizeof(sa), address);
-- 
2.43.0




