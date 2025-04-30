Return-Path: <stable+bounces-139110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058AEAA4516
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E644C7317
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD982144A2;
	Wed, 30 Apr 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LFueS9t3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656C6AD3
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001217; cv=none; b=RbncVOA+Hkv+JNRnZfmSZ8gqjEruYkk7kT8qU3iBYJ3pRfi7KrXYAb+Qy/xlMD3X7o7I7sFCN3Ecpr/oMMYtwJTmQRLASpfjGqtnQgQ6Glb7FeYFIv2GreXrn/DSQWqNGqShguRiJT7Whun6msUQhXZp4AmsLtMfzYVDWuRWRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001217; c=relaxed/simple;
	bh=oQSDywId2VUIdmFW9Udj9zv+BNNyslpwP6lVza5/Mh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vi2YqeNaI3b9KTo1PTQZHV5QOEcVCR6nxpKPBvwzKV/jyA1v/mDOdkhqH8mPu0Us9EuB8Oa5/9bsRySOvMoYtKkC4In1Sc+RcPaSC3S6jPkgLU0CDPINLNpROnhv6/uGu1e+YsQLNzs6U5PidmVO2TevSaD5gSA0/a3kr6EXGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LFueS9t3; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso380478f8f.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001213; x=1746606013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8yc32q7/jOlHpOgnFEHDVT0jCxdHqVEC6+gb8yllSE=;
        b=LFueS9t3wTzH4eznLNKtcboG/SJ/nF4otsixyi4qVaOoC6kaIdN8rcFCDiMZb582+9
         50cIJgFDyWf/CwrOsxsQw0DfJkdLhKg0gsUWJLDEGrmlXkeAnR4UteGzdpemIxjuLLij
         puwWSzLoFfA+bUviUdWudZ/1LeNZ/ZDtgDuzfYnFyD+mBXQMZ0lOcvLM/qksfmpPNQMt
         J517q2kpHxzrh6X08s9nt6n5ZdAFky7Ik1QxamNevSkmJR+aYnje/9sak3yzG5oQ8i3M
         QfEphaZCRKSHOKTBxY+grTQ4nJkECk9h2VKoo5s29px3pH26wyFYdOWy4Upz7EinKhUP
         KCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001213; x=1746606013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8yc32q7/jOlHpOgnFEHDVT0jCxdHqVEC6+gb8yllSE=;
        b=vfI2UP+f8WwV2TJ3Gh4NYkz1R1DHrjbLh5q8pg86PMqco0HhU0yjTZMsFuMU7u4ftW
         5PBP738VxOi+il0QPCVao3ZIv6BwKZGLwT5ZqUB7UMJaYXghJwdmvmNOULc6V0yzRbxn
         VbjgIoE5Dxf2ycbXuxFLUboWzqc4IMzmyJQ89xEHg7mWE1sv/BhuaXqEBiUXNPAgY4Gl
         3lSnE+E1zKSDb+89VVg15JA6HymCupLMhPFz2JcKAYrizc5uediareD1E5CvC+YYDIuS
         rJzNa7OyNqJASc5zVfPKjZogclRSyvkpeBoh3pSk/qodqg62h5FrsLBzKcbLexrWjba+
         nU1w==
X-Gm-Message-State: AOJu0Yz29+c3RHPFPiWX2lPJk4TkmJzN1JonwmaBAs3VyO3nZlPiO/SJ
	StUuzQHvqp8nEzxBixvhC8+nkP5R6cCzrArZCibuInk9+vR4AY3E8Ujw4kcc64rr+1WZMdANdrN
	t89sGcw==
X-Gm-Gg: ASbGncuC2R0uhJsBzrNejOASUdOCBooxk9tLrBwq5qGbhconlLNFwJSkgYO4QW3x/uH
	jKS7El+RinNXhR02OXLubYNHE4eAd9JgcvA4YkDH1eVBgP68cFivE+I7/F2U5H1+EzmFD05PZVN
	JHG++zxUUruJm80ERCsyBh5r8kAuhN/CDuzPknEF2IwTAyXza12lRP00MNK7T2zk2A0w0JOQE8f
	I78/ZJ614GADv2yyyXBHkWZpu2xO4ZHHXNZ13F5d1XiCUxlbk8/2SFo7rk5KUHDqAIyE+sm7hYl
	1Thh8Qa7tfrGF2LHJYBiFm4kJpko3Q1jMmZASNr80hc=
X-Google-Smtp-Source: AGHT+IFnnHyhaferBc3MIOyQx+EU5UM1vxxIv84mzGsWEw5tDk7w5LlW8NSWGsUb+qBEUBvtQHdtzA==
X-Received: by 2002:a05:6000:2a3:b0:3a0:7afd:cbfd with SMTP id ffacd0b85a97d-3a08fb459d3mr1498332f8f.7.1746001213275;
        Wed, 30 Apr 2025 01:20:13 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22db4d74c93sm116046485ad.11.2025.04.30.01.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:12 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 03/10] bpf: track changes_pkt_data property for global functions
Date: Wed, 30 Apr 2025 16:19:45 +0800
Message-ID: <20250430081955.49927-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430081955.49927-1-shung-hsi.yu@suse.com>
References: <20250430081955.49927-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

commit 51081a3f25c742da5a659d7fc6fd77ebfdd555be upstream.

When processing calls to certain helpers, verifier invalidates all
packet pointers in a current state. For example, consider the
following program:

    __attribute__((__noinline__))
    long skb_pull_data(struct __sk_buff *sk, __u32 len)
    {
        return bpf_skb_pull_data(sk, len);
    }

    SEC("tc")
    int test_invalidate_checks(struct __sk_buff *sk)
    {
        int *p = (void *)(long)sk->data;
        if ((void *)(p + 1) > (void *)(long)sk->data_end) return TCX_DROP;
        skb_pull_data(sk, 0);
        *p = 42;
        return TCX_PASS;
    }

After a call to bpf_skb_pull_data() the pointer 'p' can't be used
safely. See function filter.c:bpf_helper_changes_pkt_data() for a list
of such helpers.

At the moment verifier invalidates packet pointers when processing
helper function calls, and does not traverse global sub-programs when
processing calls to global sub-programs. This means that calls to
helpers done from global sub-programs do not invalidate pointers in
the caller state. E.g. the program above is unsafe, but is not
rejected by verifier.

This commit fixes the omission by computing field
bpf_subprog_info->changes_pkt_data for each sub-program before main
verification pass.
changes_pkt_data should be set if:
- subprogram calls helper for which bpf_helper_changes_pkt_data
  returns true;
- subprogram calls a global function,
  for which bpf_subprog_info->changes_pkt_data should be set.

The verifier.c:check_cfg() pass is modified to compute this
information. The commit relies on depth first instruction traversal
done by check_cfg() and absence of recursive function calls:
- check_cfg() would eventually visit every call to subprogram S in a
  state when S is fully explored;
- when S is fully explored:
  - every direct helper call within S is explored
    (and thus changes_pkt_data is set if needed);
  - every call to subprogram S1 called by S was visited with S1 fully
    explored (and thus S inherits changes_pkt_data from S1).

The downside of such approach is that dead code elimination is not
taken into account: if a helper call inside global function is dead
because of current configuration, verifier would conservatively assume
that the call occurs for the purpose of the changes_pkt_data
computation.

Reported-by: Nick Zavaritsky <mejedi@gmail.com>
Closes: https://lore.kernel.org/bpf/0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-4-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: do not use bitfield in "struct bpf_subprog_info" because commit
406a6fa44bfb ("bpf: use bitfields for simple per-subprog bool flags") is not
present and minor context difference in check_func_call() because commit
491dd8edecbc ("bpf: Emit global subprog name in verifier logs") is not present. ]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 92919d52f7e1..32e89758176b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -573,6 +573,7 @@ struct bpf_subprog_info {
 	bool tail_call_reachable;
 	bool has_ld_abs;
 	bool is_async_cb;
+	bool changes_pkt_data;
 };
 
 struct bpf_verifier_env;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 329b66516a85..154513999e03 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9364,6 +9364,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		if (env->log.level & BPF_LOG_LEVEL)
 			verbose(env, "Func#%d is global and valid. Skipping.\n", subprog);
+		if (env->subprog_info[subprog].changes_pkt_data)
+			clear_all_pkt_pointers(env);
 		clear_caller_saved_regs(env, caller->regs);
 
 		/* All global functions return a 64-bit SCALAR_VALUE */
@@ -15114,6 +15116,29 @@ static int check_return_code(struct bpf_verifier_env *env)
 	return 0;
 }
 
+static void mark_subprog_changes_pkt_data(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *subprog;
+
+	subprog = find_containing_subprog(env, off);
+	subprog->changes_pkt_data = true;
+}
+
+/* 't' is an index of a call-site.
+ * 'w' is a callee entry point.
+ * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
+ * Rely on DFS traversal order and absence of recursive calls to guarantee that
+ * callee's change_pkt_data marks would be correct at that moment.
+ */
+static void merge_callee_effects(struct bpf_verifier_env *env, int t, int w)
+{
+	struct bpf_subprog_info *caller, *callee;
+
+	caller = find_containing_subprog(env, t);
+	callee = find_containing_subprog(env, w);
+	caller->changes_pkt_data |= callee->changes_pkt_data;
+}
+
 /* non-recursive DFS pseudo code
  * 1  procedure DFS-iterative(G,v):
  * 2      label v as discovered
@@ -15247,6 +15272,7 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 				bool visit_callee)
 {
 	int ret, insn_sz;
+	int w;
 
 	insn_sz = bpf_is_ldimm64(&insns[t]) ? 2 : 1;
 	ret = push_insn(t, t + insn_sz, FALLTHROUGH, env);
@@ -15258,8 +15284,10 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 	mark_jmp_point(env, t + insn_sz);
 
 	if (visit_callee) {
+		w = t + insns[t].imm + 1;
 		mark_prune_point(env, t);
-		ret = push_insn(t, t + insns[t].imm + 1, BRANCH, env);
+		merge_callee_effects(env, t, w);
+		ret = push_insn(t, w, BRANCH, env);
 	}
 	return ret;
 }
@@ -15311,6 +15339,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			mark_prune_point(env, t);
 			mark_jmp_point(env, t);
 		}
+		if (bpf_helper_call(insn) && bpf_helper_changes_pkt_data(insn->imm))
+			mark_subprog_changes_pkt_data(env, t);
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
-- 
2.49.0


