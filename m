Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E575F68E
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGXMml (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGXMmk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 08:42:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D61B8
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:42:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-993a37b79e2so696268566b.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690202557; x=1690807357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7boIelHsP3P49HF7QYAFfHrfd18axPzxdFc22Fj5lNo=;
        b=H534mtacJMyhPkJdqcZIsPtfZ40gHtluZfpoOMzTE1cBp2gIi+XcN5P7+rb5JCrofU
         zc6oRVKYoCoxi9e11TqE6Xs+syer6CH9COKvC4y55EX/d0SrTWD6t74ImB7AK3l5fOzd
         6kaGFW3ZCIlEi2fbep46IddJviYPdkP93QLGTGgk3dmz9L3B1/9haAJhRt7/NCo7hVpk
         f+Yr8oopkbr/sE7dIxagBA2TsYWF8KD3wYs5NPnljo4hqIFbCQkRQyXVdtabwXKijNKA
         6nacvJ2hSIWzYeMV19SIRMPBWIgBVOwzq9kI3CeYqiFyWkUvfT31FmwCANq0O0lP9YYP
         2tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690202557; x=1690807357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7boIelHsP3P49HF7QYAFfHrfd18axPzxdFc22Fj5lNo=;
        b=d8CXMGhAXuR6rvIirY+jbe8Z+2N6me3oTl0YHkUeZa1dODpmWdAGvcsUMJ6eAU4Lx9
         AmWbR+viCUICV7L+76uVE12vPIF5CF124K8ap8S2BQ2W49JqWf8nDp+FzURS6uyO+Lcz
         AoJOhCMa9aX0KJR7bjtVag9eJ9DzTbsYiVEDe5nXWU4vCnb4SVGrowhZERi9AiM/71Ch
         rVhEc1bWpwPbN2naU9z9DPzCJIQH3QC3eiCZP6dOIBJl+8mWdN46SZZMBsUT3JKesKHv
         BM8U+jfLifSjyOrdqsbovx0AbuQbH5gTO/BCb6CgQaXBHhEsJhAtiED0nQTVGbF8yDrb
         6PSw==
X-Gm-Message-State: ABy/qLaN98RzBi1zFJHAdc6FUZaXwblu8Dn78BbwMQIZzmlb+B0+DtkK
        JYDpNHtY0R1Rpc8ASP5f89vWDlGq2vE=
X-Google-Smtp-Source: APBJJlFCgu4Z/Oa2tkMC2TSDPFFGHiLPmpzJLsw6adBMJaCDGN7fE+eI3I5b7V4SLHIknxGY2BZFRg==
X-Received: by 2002:a17:907:784f:b0:99b:445d:45d3 with SMTP id lb15-20020a170907784f00b0099b445d45d3mr8977020ejc.67.1690202557170;
        Mon, 24 Jul 2023 05:42:37 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709062b0600b0099297782aa9sm6628490ejg.49.2023.07.24.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 05:42:36 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     stable@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.1.y v2 3/6] bpf: aggressively forget precise markings during state checkpointing
Date:   Mon, 24 Jul 2023 15:42:20 +0300
Message-ID: <20230724124223.1176479-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724124223.1176479-1-eddyz87@gmail.com>
References: <20230724124223.1176479-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
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

