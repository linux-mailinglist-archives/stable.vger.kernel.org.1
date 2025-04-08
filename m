Return-Path: <stable+bounces-131465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C336A80996
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D907A3126
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31526B947;
	Tue,  8 Apr 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLzftyPi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59A26B941;
	Tue,  8 Apr 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116471; cv=none; b=TcHelkA7cm4xjLqAStFP37l2TPqbzioNuovdbKgF8L3a6rpoXqG8KqdgCN4KL9FNHvhoBzLsT0MrbQm73Z+eKWbriomAHz1E7z4DAU5zVjbDjln93/t50EUYw0ExDm/spRU3Zci02oL6Bs7at4D1MVHi8Dte/t2OXOnfkhAgIYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116471; c=relaxed/simple;
	bh=/ZeVv8KE2B4pi5luzeZzLnhm45s8lxGUAgiHZCqna5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5KDgCi2c/0rhLh+EiWwIUjwopsbqzFsM8PGvlFMqOLwCwUTliTDjjaCefxeOWojeDAhpTWbODVHqD+2hzUcpXd/zeuAzc9/vSMJP4Li7w4KuKKNHdhGlcS15UHDanhpeSprytT1qgbmB55WZp2/2axUsU8Vjn12joGN7F7WhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLzftyPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A5EC4CEE5;
	Tue,  8 Apr 2025 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116471;
	bh=/ZeVv8KE2B4pi5luzeZzLnhm45s8lxGUAgiHZCqna5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLzftyPi9C+KW4ghQ/kDCSQ5o+Ae+v7xx45RL/7J1gjwQIAJHukxMTZ1d6k9of2AG
	 dNHesBirUKnfe8ig1iKQpAfre5VSZlhRi9F2GaXnVc+isFyaVzHuWNUEJBX3xtRk3v
	 X6DZCepKZuJhBNudaCRMKxJKZzx5Jj3QEr0yNVvc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com,
	Jiayuan Chen <mrpre@163.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 152/423] bpf: Fix array bounds error with may_goto
Date: Tue,  8 Apr 2025 12:47:58 +0200
Message-ID: <20250408104849.275968998@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <mrpre@163.com>

[ Upstream commit 6ebc5030e0c5a698f1dd9a6684cddf6ccaed64a0 ]

may_goto uses an additional 8 bytes on the stack, which causes the
interpreters[] array to go out of bounds when calculating index by
stack_size.

1. If a BPF program is rewritten, re-evaluate the stack size. For non-JIT
cases, reject loading directly.

2. For non-JIT cases, calculating interpreters[idx] may still cause
out-of-bounds array access, and just warn about it.

3. For jit_requested cases, the execution of bpf_func also needs to be
warned. So move the definition of function __bpf_prog_ret0_warn out of
the macro definition CONFIG_BPF_JIT_ALWAYS_ON.

Reported-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/0000000000000f823606139faa5d@google.com/
Fixes: 011832b97b311 ("bpf: Introduce may_goto instruction")
Signed-off-by: Jiayuan Chen <mrpre@163.com>
Link: https://lore.kernel.org/r/20250214091823.46042-2-mrpre@163.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/core.c     | 19 +++++++++++++++----
 kernel/bpf/verifier.c |  7 +++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2b9c8c168a0ba..a60a6a2ce0d7f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2290,17 +2290,18 @@ void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
 	insn->code = BPF_JMP | BPF_CALL_ARGS;
 }
 #endif
-#else
+#endif
+
 static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 					 const struct bpf_insn *insn)
 {
 	/* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
-	 * is not working properly, so warn about it!
+	 * is not working properly, or interpreter is being used when
+	 * prog->jit_requested is not 0, so warn about it!
 	 */
 	WARN_ON_ONCE(1);
 	return 0;
 }
-#endif
 
 bool bpf_prog_map_compatible(struct bpf_map *map,
 			     const struct bpf_prog *fp)
@@ -2380,8 +2381,18 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
+	u32 idx = (round_up(stack_depth, 32) / 32) - 1;
 
-	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
+	/* may_goto may cause stack size > 512, leading to idx out-of-bounds.
+	 * But for non-JITed programs, we don't need bpf_func, so no bounds
+	 * check needed.
+	 */
+	if (!fp->jit_requested &&
+	    !WARN_ON_ONCE(idx >= ARRAY_SIZE(interpreters))) {
+		fp->bpf_func = interpreters[idx];
+	} else {
+		fp->bpf_func = __bpf_prog_ret0_warn;
+	}
 #else
 	fp->bpf_func = __bpf_prog_ret0_warn;
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0cab0d0252fa..9000806ee3bae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21276,6 +21276,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
 			subprogs[cur_subprog].stack_extra = stack_depth_extra;
+
+			stack_depth = subprogs[cur_subprog].stack_depth;
+			if (stack_depth > MAX_BPF_STACK && !prog->jit_requested) {
+				verbose(env, "stack size %d(extra %d) is too large\n",
+					stack_depth, stack_depth_extra);
+				return -EINVAL;
+			}
 			cur_subprog++;
 			stack_depth = subprogs[cur_subprog].stack_depth;
 			stack_depth_extra = 0;
-- 
2.39.5




