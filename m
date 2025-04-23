Return-Path: <stable+bounces-135228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB180A97E5F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C8A17A3D8
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 05:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B02265619;
	Wed, 23 Apr 2025 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZvhJcYdX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04DEAFA
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387645; cv=none; b=UsHQdNCLcw6sWwOIuUgfT7QqhNuRsLM/xY+zEbySiiXeFJ7z84A9+7zLRLVvNErbGZkYeZBZLuAz6hsOfwk3wSIFKe8gcoJ0PVuxzMx8Q1E9DZQ4yOGsb/DVmdSBLOniYfhvM+jmXxzzcO5/8Wu5QNrFjYRg89+s8Is8oW7UBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387645; c=relaxed/simple;
	bh=kN0EU44hSigQDvs7ke7c2PCpJd1KbDnwsQAK6tk9DNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEj7ZDagmxxw3YdEcavKXsbXbKyyogxTieFHXsGGmLTmkvJdVGij1iPl9jx2Ur41Qi7LhTSaNdBEgDG7E9oZ63uuX1Lnful58IoWfaJmp7zd2cynWUq8h273r88pBK4WLf6uwDKCf/nB6ceohMvXK2BlBBDVztysq2R7auvezAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZvhJcYdX; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39c266c1389so4421103f8f.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745387641; x=1745992441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=018AIgXm4OGG5rI74/DlKTBZmrHDzQfFJRGJcAb2yFw=;
        b=ZvhJcYdXIwIzsF5m5Fp4RcFKzD9rjtpMJAHQ2m2tt1FH3BUrxw4Qjq8EMqdoqfzZrM
         GrHeUg3d/gugYh1fBwIfK4qiqV6ufc/ziuJHl+LsBEaBBUnuchwQ7CGb3iLVPeQy2+pE
         JpwumGA+aBc8aKpdGEwQWkXz4DzZ98Hm6hBbJmyAVFRJKkOxsz3aB97I6EWNiE+bhoPf
         ip0C8cfG/Uu07ApwO1f8TfUdMqQCSHtsqN8Xcuo+RqyxMcqFI7hSXVmYZUNlyD6rjzmM
         F09OhamaNWg1c7vW59LomsDICraVSqKbEJ0Irco6OKS9KvxGeVnUsG0xI/qZUYWLsnU3
         2w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387641; x=1745992441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=018AIgXm4OGG5rI74/DlKTBZmrHDzQfFJRGJcAb2yFw=;
        b=Vu+m67XRAhnsbf1IZgWirK+VH9h7cunIHdLCf2mDV9NXXoQ6+jtXQMQx1rf3Irg3hM
         VwrLwViAPeBOnwaefbC9phM5nn66UgkN6Z9sIygHEQhrQGWOWUAJr0e+sBX+6SzAzOAj
         LDxylcqk1ZGBI2m4JQNoIokpVr0FgDyva9/D4XDf1wKTwvRfFHwVueoBwsPsJ+3UYWRt
         +nf0ZnPC/+ijHcpnd7stFGoaGETcDDwnikShQ77uAERTvZOq4k1Km0aar8wqRrKIMTxt
         URy7cL5FkSAVIwVqFHj3kn5nj5PqrDBL0f4KcrB2rXa1Ex03IXPYsv22AcAKtuO5mR5S
         ocqg==
X-Gm-Message-State: AOJu0Yxr4WA1MWoy+YAX64GJ6Ql+BBlsyxVMXTpSGqMtKofZmdPEDWhg
	oG7Cra+0THvHQGROMfLLJpIpr0hRYXRoEO68OoKDgSzBXgxU//R4MW1WhR0tupUaYYfwJpWmR3O
	sJ1tVWg==
X-Gm-Gg: ASbGncuBrF2TUP26hEwqpcsSXMXQtOZ3vnG/pRb1J9vom2wtcFLo3QVnTDITCmi6hxC
	+/Z72UXUENQg9rGjNMmrLQqR1k4TyB+QkWVmp5U1KSwpkhnaTcntt+BNQLBYqxfp5SUIun1YDzH
	lPfyKMcJ8pMhOnKwalWGMFeRfeWFNXdzJuUKc7Z3zOB4YlflClc7q8GfsOdIX7VBkukT7aPND+z
	PBudvKXVxYhowXCyqq7/5Te24geH22F9LXM/fgXXnnBwnstiE/W0bmp/zCl7ghKPgNkA2XoJxQc
	z+wUkwPURPEvmW94Tjh6LZI/EOBEWgALzgjXtZnsyyW95sImaViNUAGlRub7WWPvch5DrA==
X-Google-Smtp-Source: AGHT+IH1aYSdlVLvx4Nmu29BGRJsqWzE/VU42TzBbwDm9LDrBn21D7P/p9SYwb4Y9EKNQe+Lg8oA3Q==
X-Received: by 2002:a05:6000:1448:b0:391:2db0:2961 with SMTP id ffacd0b85a97d-39efbace3d7mr14862127f8f.38.1745387641012;
        Tue, 22 Apr 2025 22:54:01 -0700 (PDT)
Received: from localhost (27-240-233-37.adsl.fetnet.net. [27.240.233.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bde206sm95809135ad.14.2025.04.22.22.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:54:00 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 2/8] bpf: track changes_pkt_data property for global functions
Date: Wed, 23 Apr 2025 13:53:23 +0800
Message-ID: <20250423055334.52791-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423055334.52791-1-shung-hsi.yu@suse.com>
References: <20250423055334.52791-1-shung-hsi.yu@suse.com>
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
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4513372c5bc8..50eeb5b86ed7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -668,6 +668,7 @@ struct bpf_subprog_info {
 	bool args_cached: 1;
 	/* true if bpf_fastcall stack region is used by functions that can't be inlined */
 	bool keep_fastcall_stack: 1;
+	bool changes_pkt_data: 1;
 
 	u8 arg_cnt;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7c1eaf03e676..fe180cf085fc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9831,6 +9831,8 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
 			subprog, sub_name);
+		if (env->subprog_info[subprog].changes_pkt_data)
+			clear_all_pkt_pointers(env);
 		/* mark global subprog for verifying after main prog */
 		subprog_aux(env, subprog)->called = true;
 		clear_caller_saved_regs(env, caller->regs);
@@ -16021,6 +16023,29 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
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
@@ -16154,6 +16179,7 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
 				bool visit_callee)
 {
 	int ret, insn_sz;
+	int w;
 
 	insn_sz = bpf_is_ldimm64(&insns[t]) ? 2 : 1;
 	ret = push_insn(t, t + insn_sz, FALLTHROUGH, env);
@@ -16165,8 +16191,10 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
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
@@ -16486,6 +16514,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			mark_prune_point(env, t);
 			mark_jmp_point(env, t);
 		}
+		if (bpf_helper_call(insn) && bpf_helper_changes_pkt_data(insn->imm))
+			mark_subprog_changes_pkt_data(env, t);
 		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
 
-- 
2.49.0


