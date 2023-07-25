Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1FD761327
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjGYLI0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjGYLIC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA32D56
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53FB76166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63103C433C7;
        Tue, 25 Jul 2023 11:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283194;
        bh=9r87TTasgyEeK4LxTmRM9tBC44ah+8MdYKpezQD3LPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXCBuGprrKG5ISqBmmfBuSv7wwnJgP/mzmf9v3JEQRuivNB0/sqrg2emQNLnQSXll
         5sXZmcXRYjN32EVuFx8Kq7CyvrHQHh70/4K9JYmQRgnxE0OsrhRxnll+LjGQeXSzES
         cR3NRFjrOTgmIeHYU7SGW8oaHA2V2aS4QFLspXtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, mykolal@fb.com, luizcap@amazon.com, Eduard Zingerman" 
        <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.1 173/183] bpf: aggressively forget precise markings during state checkpointing
Date:   Tue, 25 Jul 2023 12:46:41 +0200
Message-ID: <20230725104513.973558731@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2813,6 +2813,31 @@ static void mark_all_scalars_precise(str
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
@@ -2891,6 +2916,14 @@ static void mark_all_scalars_precise(str
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
@@ -12296,6 +12329,10 @@ next:
 	env->prev_jmps_processed = env->jmps_processed;
 	env->prev_insn_processed = env->insn_processed;
 
+	/* forget precise markings we inherited, see __mark_chain_precision */
+	if (env->bpf_capable)
+		mark_all_scalars_imprecise(env, cur);
+
 	/* add new state to the head of linked list */
 	new = &new_sl->state;
 	err = copy_verifier_state(new, cur);


