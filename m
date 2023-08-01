Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4704076B7C8
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjHAOiM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjHAOhs (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 10:37:48 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144FB1BF3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:37:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFd4K1ZGbz4f4K0Q
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 22:37:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP1 (Coremail) with SMTP id cCh0CgBnwRuwGMlkGuIaOg--.36375S3;
        Tue, 01 Aug 2023 22:37:39 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     stable@vger.kernel.org, Greg KH <greg@kroah.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Luiz Capitulino <luizcap@amazon.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH 5.10 1/6] bpf: allow precision tracking for programs with subprogs
Date:   Tue,  1 Aug 2023 22:36:55 +0800
Message-Id: <20230801143700.1012887-2-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801143700.1012887-1-pulehui@huaweicloud.com>
References: <20230801143700.1012887-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBnwRuwGMlkGuIaOg--.36375S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Zry7Jw1xJFWfKr15KF4DJwb_yoWDWFy8pF
        yfGr13Cr45JF4293Z7Aw40yFWYga1kAw13JryUJryrAF15ArnIqF9rKF1FyFyUArWkZw12
        vr4qvrn8Wr1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit be2ef8161572ec1973124ebc50f56dafc2925e07 ]

Stop forcing precise=true for SCALAR registers when BPF program has any
subprograms. Current restriction means that any BPF program, as soon as
it uses subprograms, will end up not getting any of the precision
tracking benefits in reduction of number of verified states.

This patch keeps the fallback mark_all_scalars_precise() behavior if
precise marking has to cross function frames. E.g., if subprogram
requires R1 (first input arg) to be marked precise, ideally we'd need to
backtrack to the parent function and keep marking R1 and its
dependencies as precise. But right now we give up and force all the
SCALARs in any of the current and parent states to be forced to
precise=true. We can lift that restriction in the future.

But this patch fixes two issues identified when trying to enable
precision tracking for subprogs.

First, prevent "escaping" from top-most state in a global subprog. While
with entry-level BPF program we never end up requesting precision for
R1-R5 registers, because R2-R5 are not initialized (and so not readable
in correct BPF program), and R1 is PTR_TO_CTX, not SCALAR, and so is
implicitly precise. With global subprogs, though, it's different, as
global subprog a) can have up to 5 SCALAR input arguments, which might
get marked as precise=true and b) it is validated in isolation from its
main entry BPF program. b) means that we can end up exhausting parent
state chain and still not mark all registers in reg_mask as precise,
which would lead to verifier bug warning.

To handle that, we need to consider two cases. First, if the very first
state is not immediately "checkpointed" (i.e., stored in state lookup
hashtable), it will get correct first_insn_idx and last_insn_idx
instruction set during state checkpointing. As such, this case is
already handled and __mark_chain_precision() already handles that by
just doing nothing when we reach to the very first parent state.
st->parent will be NULL and we'll just stop. Perhaps some extra check
for reg_mask and stack_mask is due here, but this patch doesn't address
that issue.

More problematic second case is when global function's initial state is
immediately checkpointed before we manage to process the very first
instruction. This is happening because when there is a call to global
subprog from the main program the very first subprog's instruction is
marked as pruning point, so before we manage to process first
instruction we have to check and checkpoint state. This patch adds
a special handling for such "empty" state, which is identified by having
st->last_insn_idx set to -1. In such case, we check that we are indeed
validating global subprog, and with some sanity checking we mark input
args as precise if requested.

Note that we also initialize state->first_insn_idx with correct start
insn_idx offset. For main program zero is correct value, but for any
subprog it's quite confusing to not have first_insn_idx set. This
doesn't have any functional impact, but helps with debugging and state
printing. We also explicitly initialize state->last_insns_idx instead of
relying on is_state_visited() to do this with env->prev_insns_idx, which
will be -1 on the very first instruction. This concludes necessary
changes to handle specifically global subprog's precision tracking.

Second identified problem was missed handling of BPF helper functions
that call into subprogs (e.g., bpf_loop and few others). From precision
tracking and backtracking logic's standpoint those are effectively calls
into subprogs and should be called as BPF_PSEUDO_CALL calls.

This patch takes the least intrusive way and just checks against a short
list of current BPF helpers that do call subprogs, encapsulated in
is_callback_calling_function() function. But to prevent accidentally
forgetting to add new BPF helpers to this "list", we also do a sanity
check in __check_func_call, which has to be called for each such special
BPF helper, to validate that BPF helper is indeed recognized as
callback-calling one. This should catch any missed checks in the future.
Adding some special flags to be added in function proto definitions
seemed like an overkill in this case.

With the above changes, it's possible to remove forceful setting of
reg->precise to true in __mark_reg_unknown, which turns on precision
tracking both inside subprogs and entry progs that have subprogs. No
warnings or errors were detected across all the selftests, but also when
validating with veristat against internal Meta BPF objects and Cilium
objects. Further, in some BPF programs there are noticeable reduction in
number of states and instructions validated due to more effective
precision tracking, especially benefiting syncookie test.

$ ./veristat -C -e file,prog,insns,states ~/baseline-results.csv ~/subprog-precise-results.csv  | grep -v '+0'
File                                      Program                     Total insns (A)  Total insns (B)  Total insns (DIFF)  Total states (A)  Total states (B)  Total states (DIFF)
----------------------------------------  --------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------
pyperf600_bpf_loop.bpf.linked1.o          on_event                               3966             3678       -288 (-7.26%)               306               276         -30 (-9.80%)
pyperf_global.bpf.linked1.o               on_event                               7563             7530        -33 (-0.44%)               520               517          -3 (-0.58%)
pyperf_subprogs.bpf.linked1.o             on_event                              36358            36934       +576 (+1.58%)              2499              2531         +32 (+1.28%)
setget_sockopt.bpf.linked1.o              skops_sockopt                          3965             4038        +73 (+1.84%)               343               347          +4 (+1.17%)
test_cls_redirect_subprogs.bpf.linked1.o  cls_redirect                          64965            64901        -64 (-0.10%)              4619              4612          -7 (-0.15%)
test_misc_tcp_hdr_options.bpf.linked1.o   misc_estab                             1491             1307      -184 (-12.34%)               110               100         -10 (-9.09%)
test_pkt_access.bpf.linked1.o             test_pkt_access                         354              349         -5 (-1.41%)                25                24          -1 (-4.00%)
test_sock_fields.bpf.linked1.o            egress_read_sock_fields                 435              375       -60 (-13.79%)                22                20          -2 (-9.09%)
test_sysctl_loop2.bpf.linked1.o           sysctl_tcp_mem                         1508             1501         -7 (-0.46%)                29                28          -1 (-3.45%)
test_tc_dtime.bpf.linked1.o               egress_fwdns_prio100                    468              435        -33 (-7.05%)                45                41          -4 (-8.89%)
test_tc_dtime.bpf.linked1.o               ingress_fwdns_prio100                   398              408        +10 (+2.51%)                42                39          -3 (-7.14%)
test_tc_dtime.bpf.linked1.o               ingress_fwdns_prio101                  1096              842      -254 (-23.18%)                97                73        -24 (-24.74%)
test_tcp_hdr_options.bpf.linked1.o        estab                                  2758             2408      -350 (-12.69%)               208               181        -27 (-12.98%)
test_urandom_usdt.bpf.linked1.o           urand_read_with_sema                    466              448        -18 (-3.86%)                31                28          -3 (-9.68%)
test_urandom_usdt.bpf.linked1.o           urand_read_without_sema                 466              448        -18 (-3.86%)                31                28          -3 (-9.68%)
test_urandom_usdt.bpf.linked1.o           urandlib_read_with_sema                 466              448        -18 (-3.86%)                31                28          -3 (-9.68%)
test_urandom_usdt.bpf.linked1.o           urandlib_read_without_sema              466              448        -18 (-3.86%)                31                28          -3 (-9.68%)
test_xdp_noinline.bpf.linked1.o           balancer_ingress_v6                    4302             4294         -8 (-0.19%)               257               256          -1 (-0.39%)
xdp_synproxy_kern.bpf.linked1.o           syncookie_tc                         583722           405757   -177965 (-30.49%)             35846             25735     -10111 (-28.21%)
xdp_synproxy_kern.bpf.linked1.o           syncookie_xdp                        609123           479055   -130068 (-21.35%)             35452             29145      -6307 (-17.79%)
----------------------------------------  --------------------------  ---------------  ---------------  ------------------  ----------------  ----------------  -------------------

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20221104163649.121784-4-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
Conflicts:
	kernel/bpf/verifier.c
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/verifier.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edb19ada0405..40ac67a04ab7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1359,7 +1359,7 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
-	reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;
+	reg->precise = !env->bpf_capable;
 	__mark_reg_unbounded(reg);
 }
 
@@ -2097,12 +2097,42 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		return 0;
 	if (!reg_mask && !stack_mask)
 		return 0;
+
 	for (;;) {
 		DECLARE_BITMAP(mask, 64);
 		u32 history = st->jmp_history_cnt;
 
 		if (env->log.level & BPF_LOG_LEVEL)
 			verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
+
+		if (last_idx < 0) {
+			/* we are at the entry into subprog, which
+			 * is expected for global funcs, but only if
+			 * requested precise registers are R1-R5
+			 * (which are global func's input arguments)
+			 */
+			if (st->curframe == 0 &&
+			    st->frame[0]->subprogno > 0 &&
+			    st->frame[0]->callsite == BPF_MAIN_FUNC &&
+			    stack_mask == 0 && (reg_mask & ~0x3e) == 0) {
+				bitmap_from_u64(mask, reg_mask);
+				for_each_set_bit(i, mask, 32) {
+					reg = &st->frame[0]->regs[i];
+					if (reg->type != SCALAR_VALUE) {
+						reg_mask &= ~(1u << i);
+						continue;
+					}
+					reg->precise = true;
+				}
+				return 0;
+			}
+
+			verbose(env, "BUG backtracing func entry subprog %d reg_mask %x stack_mask %llx\n",
+				st->frame[0]->subprogno, reg_mask, stack_mask);
+			WARN_ONCE(1, "verifier backtracking bug");
+			return -EFAULT;
+		}
+
 		for (i = last_idx;;) {
 			if (skip_first) {
 				err = 0;
@@ -11846,6 +11876,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 			0 /* frameno */,
 			subprog);
 
+	state->first_insn_idx = env->subprog_info[subprog].start;
+	state->last_insn_idx = -1;
+
 	regs = state->frame[state->curframe]->regs;
 	if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
 		ret = btf_prepare_func_args(env, subprog, regs);
-- 
2.25.1

