Return-Path: <stable+bounces-155354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006B2AE3E9F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922DC1746B9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F028124169A;
	Mon, 23 Jun 2025 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JdFaZY8X"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C7188CC9
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679671; cv=none; b=tO1+uRMO+hFGtqLco8XL+si/cxQ8S9iE4wIPrcSf4UzwEsm75FwSBPTg6CU5hg0AY/i/3uBHkOPpKAY1DxQMj9l36nI5spePU5Vvth5EEXTGdXLKjkKDddhi59Xe+mW93JyZO1ULdNAGv+w5GmIoOFLIIDppviVJ8Hy2m2CRngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679671; c=relaxed/simple;
	bh=PpEjETMTQuPvg4DIj6XdTOVoFV1DyKkHpxM5BVUenqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iB3MknTXIXqYg/ooca47MFP2KanVPsZ+TUs9FhvZAHq7V5OIuwsFGhcsXfBXmN/4M0O41JwI4AwkCdoNCVORgRDmiYI0Lurvg4Qq4T8nlmgIzcsjtQG/HyaDwjK6fezUHEmynoTKO/HIxDA67b2JX1dyw3VBQgI9tij1BAbCLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JdFaZY8X; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-747fba9f962so3021720b3a.0
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750679669; x=1751284469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy3zMEc1Ova7ES8TP6ETx98fj7ICDgpxIvmh9uqnCqo=;
        b=JdFaZY8XVkP1Iw5B7EYDijbTB1FRkhie2VL9JnajE3o9FRf19QWagQeTHtdya9Z4p1
         0U7LGx9BsOt04KCVuygpvlLOMBf3AXNNsf+s7oLOAjwZsGpty8p87/+rcxCqXpXcLVuI
         YmxJZYH5GkMJpD8PmHx+eDw373tXIgRsf2BoqEV9PdNd5rbltMWHlkwgK/jVfj7PAeVu
         X3fSov5cw1zgfDR+H6EkS/HFLL+RCfPIRfNRhfpN5kSAfJI5TGderZYvf5FHZOA7DWld
         SnJEmRuiIh9Vxb309BDqMC+m0faiGygb7oHhiKWAkfaafPPd2TwQ3TkjxnYQSJNSavQ1
         1C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679669; x=1751284469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yy3zMEc1Ova7ES8TP6ETx98fj7ICDgpxIvmh9uqnCqo=;
        b=vlYgzsSciuyAp3Do3kwtTw857HV9BJBUNy7fLFSg6TOM30dnmcBSek+NH9KyHDYUDp
         T0y4J3+y2OkskOzTeEJPjQCs/cUij7ro3uVI65VLIlTWzCXryjKNXaZN1/Vf8L5fMEZ/
         ZEy3/SmTOvRQxlr+L+ligKmLwGIiZcxZ35Yb6GbOsLineuaoMZvQx4SqBrYNxMIbLxYP
         WNyAPRhX1J8e4eOCvHcxctDoeclBt/lI8dLOFWrfRvV0GKT6z8pj3XPoPIcR/mE3Ws+n
         xR+xA31mqUs60r4ZjfacLROxhJsJPYqKyTtM4J1vXpj/ryitT8dHZEvja9naGsSWhcp/
         m/tw==
X-Gm-Message-State: AOJu0YzC5okjkMzbhp36Tj4jA/BUAjl3n8eJu+YJOHhzLAY0xOBQKB0e
	o+lT3fIFE/iML7AzzkNLuycCZmumfwOiRIV35rorW5yhH0aww9aQJJ/JeihvdKA91Q==
X-Gm-Gg: ASbGncvub3jskw/56jYYHSTxRF3bJPOs8L58psu+Vte6dLiY2WSJ2MT/9R0bPACc7i7
	Om6HfojeSohNZEMCDHpZFhFa4DZ1eQeayP7K+GUNLgT6VPbs77njhu4YqvO0WrSJGBSxE8QR7Xj
	xC7GsxwR7MqclLcLvrJrhMNpxv9OWqrzw90kofbbxb0Tp2pxUFOn0VfSa5i4THtZJzHFzPBn0kY
	gTvGcqQoytv5eEuSWbSjKkoEFY7eB4R4Ae+Uw06kiR5EgcCqOBwYe/eUo0VSbfj/5IgcZKL2q71
	TFCJ031kadOyxuO5Bidhxlk/6kk4aM2DbyL0mBj9Pe5WUNueGtmG+QlV1Edv5PVX2KsWBtvOgEU
	Ss4w50p/ilGLJdwr5nEK8fCfy6gc8V3Uy
X-Google-Smtp-Source: AGHT+IH7hJ1W3KupQSdWgm2XkIo+YEEZwoRGD0d0RhuW5T8UArlrmBm8s1CuaU1OgupCPnztp6MCMA==
X-Received: by 2002:a05:6a00:1acb:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-7490f43bce2mr17684369b3a.3.1750679669360;
        Mon, 23 Jun 2025 04:54:29 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12427b7sm6597716a12.40.2025.06.23.04.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 04:54:28 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Luiz Capitulino <luizcap@amazon.com>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH 3/4] Revert "bpf: stop setting precise in current state"
Date: Mon, 23 Jun 2025 19:54:02 +0800
Message-Id: <20250623115403.299-4-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623115403.299-1-ziqianlu@bytedance.com>
References: <20250623115403.299-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7ca3e7459f4a5795e78b14390635879f534d9741.

The backport of bpf precision tracking related changes has caused bpf
verifier to panic while loading some certain bpf prog so revert them.

Link: https://lkml.kernel.org/r/20250605070921.GA3795@bytedance/
Reported-by: Wei Wei <weiwei.danny@bytedance.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/bpf/verifier.c | 103 +++++-------------------------------------
 1 file changed, 12 insertions(+), 91 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b3cbfda41d9cf..ecd0d04ff8e61 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2028,11 +2028,8 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 
 	/* big hammer: mark all scalars precise in this path.
 	 * pop_stack may still get !precise scalars.
-	 * We also skip current state and go straight to first parent state,
-	 * because precision markings in current non-checkpointed state are
-	 * not needed. See why in the comment in __mark_chain_precision below.
 	 */
-	for (st = st->parent; st; st = st->parent) {
+	for (; st; st = st->parent)
 		for (i = 0; i <= st->curframe; i++) {
 			func = st->frame[i];
 			for (j = 0; j < BPF_REG_FP; j++) {
@@ -2050,88 +2047,8 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 				reg->precise = true;
 			}
 		}
-	}
 }
 
-/*
- * __mark_chain_precision() backtracks BPF program instruction sequence and
- * chain of verifier states making sure that register *regno* (if regno >= 0)
- * and/or stack slot *spi* (if spi >= 0) are marked as precisely tracked
- * SCALARS, as well as any other registers and slots that contribute to
- * a tracked state of given registers/stack slots, depending on specific BPF
- * assembly instructions (see backtrack_insns() for exact instruction handling
- * logic). This backtracking relies on recorded jmp_history and is able to
- * traverse entire chain of parent states. This process ends only when all the
- * necessary registers/slots and their transitive dependencies are marked as
- * precise.
- *
- * One important and subtle aspect is that precise marks *do not matter* in
- * the currently verified state (current state). It is important to understand
- * why this is the case.
- *
- * First, note that current state is the state that is not yet "checkpointed",
- * i.e., it is not yet put into env->explored_states, and it has no children
- * states as well. It's ephemeral, and can end up either a) being discarded if
- * compatible explored state is found at some point or BPF_EXIT instruction is
- * reached or b) checkpointed and put into env->explored_states, branching out
- * into one or more children states.
- *
- * In the former case, precise markings in current state are completely
- * ignored by state comparison code (see regsafe() for details). Only
- * checkpointed ("old") state precise markings are important, and if old
- * state's register/slot is precise, regsafe() assumes current state's
- * register/slot as precise and checks value ranges exactly and precisely. If
- * states turn out to be compatible, current state's necessary precise
- * markings and any required parent states' precise markings are enforced
- * after the fact with propagate_precision() logic, after the fact. But it's
- * important to realize that in this case, even after marking current state
- * registers/slots as precise, we immediately discard current state. So what
- * actually matters is any of the precise markings propagated into current
- * state's parent states, which are always checkpointed (due to b) case above).
- * As such, for scenario a) it doesn't matter if current state has precise
- * markings set or not.
- *
- * Now, for the scenario b), checkpointing and forking into child(ren)
- * state(s). Note that before current state gets to checkpointing step, any
- * processed instruction always assumes precise SCALAR register/slot
- * knowledge: if precise value or range is useful to prune jump branch, BPF
- * verifier takes this opportunity enthusiastically. Similarly, when
- * register's value is used to calculate offset or memory address, exact
- * knowledge of SCALAR range is assumed, checked, and enforced. So, similar to
- * what we mentioned above about state comparison ignoring precise markings
- * during state comparison, BPF verifier ignores and also assumes precise
- * markings *at will* during instruction verification process. But as verifier
- * assumes precision, it also propagates any precision dependencies across
- * parent states, which are not yet finalized, so can be further restricted
- * based on new knowledge gained from restrictions enforced by their children
- * states. This is so that once those parent states are finalized, i.e., when
- * they have no more active children state, state comparison logic in
- * is_state_visited() would enforce strict and precise SCALAR ranges, if
- * required for correctness.
- *
- * To build a bit more intuition, note also that once a state is checkpointed,
- * the path we took to get to that state is not important. This is crucial
- * property for state pruning. When state is checkpointed and finalized at
- * some instruction index, it can be correctly and safely used to "short
- * circuit" any *compatible* state that reaches exactly the same instruction
- * index. I.e., if we jumped to that instruction from a completely different
- * code path than original finalized state was derived from, it doesn't
- * matter, current state can be discarded because from that instruction
- * forward having a compatible state will ensure we will safely reach the
- * exit. States describe preconditions for further exploration, but completely
- * forget the history of how we got here.
- *
- * This also means that even if we needed precise SCALAR range to get to
- * finalized state, but from that point forward *that same* SCALAR register is
- * never used in a precise context (i.e., it's precise value is not needed for
- * correctness), it's correct and safe to mark such register as "imprecise"
- * (i.e., precise marking set to false). This is what we rely on when we do
- * not set precise marking in current state. If no child state requires
- * precision for any given SCALAR register, it's safe to dictate that it can
- * be imprecise. If any child state does require this register to be precise,
- * we'll mark it precise later retroactively during precise markings
- * propagation from child state to parent states.
- */
 static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
 				  int spi)
 {
@@ -2149,10 +2066,6 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 	if (!env->bpf_capable)
 		return 0;
 
-	/* Do sanity checks against current state of register and/or stack
-	 * slot, but don't set precise flag in current state, as precision
-	 * tracking in the current state is unnecessary.
-	 */
 	func = st->frame[frame];
 	if (regno >= 0) {
 		reg = &func->regs[regno];
@@ -2160,7 +2073,11 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			WARN_ONCE(1, "backtracing misuse");
 			return -EFAULT;
 		}
-		new_marks = true;
+		if (!reg->precise)
+			new_marks = true;
+		else
+			reg_mask = 0;
+		reg->precise = true;
 	}
 
 	while (spi >= 0) {
@@ -2173,7 +2090,11 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 			stack_mask = 0;
 			break;
 		}
-		new_marks = true;
+		if (!reg->precise)
+			new_marks = true;
+		else
+			stack_mask = 0;
+		reg->precise = true;
 		break;
 	}
 
@@ -9358,7 +9279,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		if (env->explore_alu_limits)
 			return false;
 		if (rcur->type == SCALAR_VALUE) {
-			if (!rold->precise)
+			if (!rold->precise && !rcur->precise)
 				return true;
 			/* new val must satisfy old val knowledge */
 			return range_within(rold, rcur) &&
-- 
2.39.5


