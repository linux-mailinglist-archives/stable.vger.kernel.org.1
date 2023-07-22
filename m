Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CA575D86B
	for <lists+stable@lfdr.de>; Sat, 22 Jul 2023 02:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGVAqG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 20:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjGVAqF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 20:46:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5781FDC
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso38087901fa.1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 17:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689986762; x=1690591562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd1+SJGW/MgJ8zgIjVLIIsoUQ5i276VkgJhmWkdnL28=;
        b=jJ/lmvVYwEk+86Lg2I3fr8Lhgrwz+fcqyztn0AOR53VrHNYRzSP1QNTVZYS65juBOk
         JANlZqnySJHEn1z0P5BY4/qLqPltW9q1lowJkLGu1EnGsx/M/UG9kazke89P08HaB1I8
         CC8J1dRSVEtaSbTAz/DZ3vJjwE6O+WeOdllGQD8RrOQPyT55pGEQcfNyY+xnEhUWZZ2c
         jLhyM2h0kP8l/63usJHAs3Zyf7+gifo+Zv9Pi2DY3LYPLmwOlvG1xMQbjhZmamZvu+Gj
         oQzj8ohIdq0waY6Ovzog+gwtA/v4Xs6nIacAsby35iZlj6k5G/UrpuVZzqNGTA2Qn1DO
         OIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986762; x=1690591562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd1+SJGW/MgJ8zgIjVLIIsoUQ5i276VkgJhmWkdnL28=;
        b=bK3Lv5IAI1H5OjDqZRIhMQHLy1YaW8gIi+VF25uasueVSN1WmjfLB4/8sVFIVVfMb9
         zl8/bFngjJrR5+XCLStG+CHNRq06hlkV8trG0bWn4QF37U97aR38idVe36EFgPJ15SzX
         P3hsIb7+oL8v95FHu4IL1ViqIsgAZ2o2uUVzWnbLk5+Lp++di3z6GAu1DPc1Zyt0Upj+
         8tFq9/CRWxbEvbl90NdAarO3bH+2lhib870EkM2nyWBHm132frtm8aGs6oREqbFIIhRv
         qSwbV32tcEdDiB5nHJEdPfOlokvPL1Wf4gv7rs8oVkkN9mVI01AvBrGbF0MkjGLb6Gfm
         JuOg==
X-Gm-Message-State: ABy/qLa2A6NnWU9uk75ax9+W9UMTcvCb/IW6Tyj/HI6UZFWt+0XCSOBW
        nzrvigpk3bbb3ttvOQv9hpIO6uJM9p8=
X-Google-Smtp-Source: APBJJlE7rCg63Kyt6NVa7wva+XQoHgwUOfyiWFDYwvZPLTpzYiS3NyGYmnMCf27DC9mkh/wh594p6w==
X-Received: by 2002:a2e:94c7:0:b0:2b6:9909:79cb with SMTP id r7-20020a2e94c7000000b002b6990979cbmr2610667ljh.42.1689986761953;
        Fri, 21 Jul 2023 17:46:01 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e8002000000b002b69febf515sm1224585ljg.125.2023.07.21.17.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:46:01 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     stable@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com
Subject: [PATCH 6.1.y 3/6] bpf: aggressively forget precise markings during state checkpointing
Date:   Sat, 22 Jul 2023 03:45:11 +0300
Message-ID: <20230722004514.767618-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722004514.767618-1-eddyz87@gmail.com>
References: <20230722004514.767618-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 7a830b53c17bbadcf99f778f28aaaa4e6c41df5f ]

Exploit the property of about-to-be-checkpointed state to be able to
forget all precise markings up to that point even more aggressively. We
now clear all potentially inherited precise markings right before
checkpointing and branching off into child state. If any of children
states require precise knowledge of any SCALAR register, those will be
propagated backwards later on before this state is finalized, preserving
correctness.

There is a single selftests BPF program change, but tremendous one: 25x
reduction in number of verified instructions and states in
trace_virtqueue_add_sgs.

Cilium results are more modest, but happen across wider range of programs.

SELFTESTS RESULTS
=================

$ ./veristat -C -e file,prog,insns,states ~/imprecise-early-results.csv ~/imprecise-aggressive-results.csv | grep -v '+0'
File                 Program                  Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
-------------------  -----------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
loop6.bpf.linked1.o  trace_virtqueue_add_sgs           398057            15114   -382943 (-96.20%)              8717               336      -8381 (-96.15%)
-------------------  -----------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

CILIUM RESULTS
==============

$ ./veristat -C -e file,prog,insns,states ~/imprecise-early-results-cilium.csv ~/imprecise-aggressive-results-cilium.csv | grep -v '+0'
File           Program                           Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
-------------  --------------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
bpf_host.o     tail_handle_nat_fwd_ipv4                    23426            23221       -205 (-0.88%)              1537              1515         -22 (-1.43%)
bpf_host.o     tail_handle_nat_fwd_ipv6                    13009            12904       -105 (-0.81%)               719               708         -11 (-1.53%)
bpf_host.o     tail_nodeport_nat_ingress_ipv6               5261             5196        -65 (-1.24%)               247               243          -4 (-1.62%)
bpf_host.o     tail_nodeport_nat_ipv6_egress                3446             3406        -40 (-1.16%)               203               198          -5 (-2.46%)
bpf_lxc.o      tail_handle_nat_fwd_ipv4                    23426            23221       -205 (-0.88%)              1537              1515         -22 (-1.43%)
bpf_lxc.o      tail_handle_nat_fwd_ipv6                    13009            12904       -105 (-0.81%)               719               708         -11 (-1.53%)
bpf_lxc.o      tail_ipv4_ct_egress                          5074             4897       -177 (-3.49%)               255               248          -7 (-2.75%)
bpf_lxc.o      tail_ipv4_ct_ingress                         5100             4923       -177 (-3.47%)               255               248          -7 (-2.75%)
bpf_lxc.o      tail_ipv4_ct_ingress_policy_only             5100             4923       -177 (-3.47%)               255               248          -7 (-2.75%)
bpf_lxc.o      tail_ipv6_ct_egress                          4558             4536        -22 (-0.48%)               188               187          -1 (-0.53%)
bpf_lxc.o      tail_ipv6_ct_ingress                         4578             4556        -22 (-0.48%)               188               187          -1 (-0.53%)
bpf_lxc.o      tail_ipv6_ct_ingress_policy_only             4578             4556        -22 (-0.48%)               188               187          -1 (-0.53%)
bpf_lxc.o      tail_nodeport_nat_ingress_ipv6               5261             5196        -65 (-1.24%)               247               243          -4 (-1.62%)
bpf_overlay.o  tail_nodeport_nat_ingress_ipv6               5261             5196        -65 (-1.24%)               247               243          -4 (-1.62%)
bpf_overlay.o  tail_nodeport_nat_ipv6_egress                3482             3442        -40 (-1.15%)               204               201          -3 (-1.47%)
bpf_xdp.o      tail_nodeport_nat_egress_ipv4               17200            15619      -1581 (-9.19%)              1111              1010        -101 (-9.09%)
-------------  --------------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20221104163649.121784-6-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8dc97cd0c01c..1384bf071d95 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2813,6 +2813,31 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 	}
 }
 
+static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+	int i, j;
+
+	for (i = 0; i <= st->curframe; i++) {
+		func = st->frame[i];
+		for (j = 0; j < BPF_REG_FP; j++) {
+			reg = &func->regs[j];
+			if (reg->type != SCALAR_VALUE)
+				continue;
+			reg->precise = false;
+		}
+		for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
+			if (!is_spilled_reg(&func->stack[j]))
+				continue;
+			reg = &func->stack[j].spilled_ptr;
+			if (reg->type != SCALAR_VALUE)
+				continue;
+			reg->precise = false;
+		}
+	}
+}
+
 /*
  * __mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
@@ -2891,6 +2916,14 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
  * be imprecise. If any child state does require this register to be precise,
  * we'll mark it precise later retroactively during precise markings
  * propagation from child state to parent states.
+ *
+ * Skipping precise marking setting in current state is a mild version of
+ * relying on the above observation. But we can utilize this property even
+ * more aggressively by proactively forgetting any precise marking in the
+ * current state (which we inherited from the parent state), right before we
+ * checkpoint it and branch off into new child state. This is done by
+ * mark_all_scalars_imprecise() to hopefully get more permissive and generic
+ * finalized states which help in short circuiting more future states.
  */
 static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
 				  int spi)
@@ -12277,6 +12310,10 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	env->prev_jmps_processed = env->jmps_processed;
 	env->prev_insn_processed = env->insn_processed;
 
+	/* forget precise markings we inherited, see __mark_chain_precision */
+	if (env->bpf_capable)
+		mark_all_scalars_imprecise(env, cur);
+
 	/* add new state to the head of linked list */
 	new = &new_sl->state;
 	err = copy_verifier_state(new, cur);
-- 
2.41.0

