Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87874755193
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGPT6D (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGPT6C (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87D7E4F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3492C60E8C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474FCC433C8;
        Sun, 16 Jul 2023 19:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537479;
        bh=RMsw39BhWJ47BiXmdu/tkx82jHjQmudhnYFYDQvTvKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZ9J+yUxhFgjJSJXAGvepRXF33eJ1J5S4M1xhWHdwj+tiBOQWb8O1XqFNybZaHMwn
         BmWFbTLrd0pRjiFdh5rgdC4T9xj7hkoVPo+x2b2d5KCY51oSvJUdThhnHaHWtv58gv
         r3N0vXn1/Be3LyOX4jAkKXRBHUYBfH4zdeR2yWLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 110/800] bpf: maintain bitmasks across all active frames in __mark_chain_precision
Date:   Sun, 16 Jul 2023 21:39:23 +0200
Message-ID: <20230716194951.667836434@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 1ef22b6865a73a8aed36d43375fe8c7b30869326 ]

Teach __mark_chain_precision logic to maintain register/stack masks
across all active frames when going from child state to parent state.
Currently this should be mostly no-op, as precision backtracking usually
bails out when encountering subprog entry/exit.

It's not very apparent from the diff due to increased indentation, but
the logic remains the same, except everything is done on specific `fr`
frame index. Calls to bt_clear_reg() and bt_clear_slot() are replaced
with frame-specific bt_clear_frame_reg() and bt_clear_frame_slot(),
where frame index is passed explicitly, instead of using current frame
number.

We also adjust logging to emit affected frame number. And we also add
better logging of human-readable register and stack slot masks, similar
to previous patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230505043317.3629845-6-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: f655badf2a8f ("bpf: fix propagate_precision() logic for inner frames")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c                         | 100 ++++++++++--------
 .../testing/selftests/bpf/verifier/precise.c  |  18 ++--
 2 files changed, 62 insertions(+), 56 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9260006c13823..bc4cf078e6277 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3694,7 +3694,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 	struct bpf_func_state *func;
 	struct bpf_reg_state *reg;
 	bool skip_first = true;
-	int i, err;
+	int i, fr, err;
 
 	if (!env->bpf_capable)
 		return 0;
@@ -3803,56 +3803,62 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		if (!st)
 			break;
 
-		func = st->frame[frame];
-		bitmap_from_u64(mask, bt_reg_mask(bt));
-		for_each_set_bit(i, mask, 32) {
-			reg = &func->regs[i];
-			if (reg->type != SCALAR_VALUE) {
-				bt_clear_reg(bt, i);
-				continue;
+		for (fr = bt->frame; fr >= 0; fr--) {
+			func = st->frame[fr];
+			bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
+			for_each_set_bit(i, mask, 32) {
+				reg = &func->regs[i];
+				if (reg->type != SCALAR_VALUE) {
+					bt_clear_frame_reg(bt, fr, i);
+					continue;
+				}
+				if (reg->precise)
+					bt_clear_frame_reg(bt, fr, i);
+				else
+					reg->precise = true;
 			}
-			if (reg->precise)
-				bt_clear_reg(bt, i);
-			else
-				reg->precise = true;
-		}
 
-		bitmap_from_u64(mask, bt_stack_mask(bt));
-		for_each_set_bit(i, mask, 64) {
-			if (i >= func->allocated_stack / BPF_REG_SIZE) {
-				/* the sequence of instructions:
-				 * 2: (bf) r3 = r10
-				 * 3: (7b) *(u64 *)(r3 -8) = r0
-				 * 4: (79) r4 = *(u64 *)(r10 -8)
-				 * doesn't contain jmps. It's backtracked
-				 * as a single block.
-				 * During backtracking insn 3 is not recognized as
-				 * stack access, so at the end of backtracking
-				 * stack slot fp-8 is still marked in stack_mask.
-				 * However the parent state may not have accessed
-				 * fp-8 and it's "unallocated" stack space.
-				 * In such case fallback to conservative.
-				 */
-				mark_all_scalars_precise(env, st);
-				bt_reset(bt);
-				return 0;
-			}
+			bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
+			for_each_set_bit(i, mask, 64) {
+				if (i >= func->allocated_stack / BPF_REG_SIZE) {
+					/* the sequence of instructions:
+					 * 2: (bf) r3 = r10
+					 * 3: (7b) *(u64 *)(r3 -8) = r0
+					 * 4: (79) r4 = *(u64 *)(r10 -8)
+					 * doesn't contain jmps. It's backtracked
+					 * as a single block.
+					 * During backtracking insn 3 is not recognized as
+					 * stack access, so at the end of backtracking
+					 * stack slot fp-8 is still marked in stack_mask.
+					 * However the parent state may not have accessed
+					 * fp-8 and it's "unallocated" stack space.
+					 * In such case fallback to conservative.
+					 */
+					mark_all_scalars_precise(env, st);
+					bt_reset(bt);
+					return 0;
+				}
 
-			if (!is_spilled_scalar_reg(&func->stack[i])) {
-				bt_clear_slot(bt, i);
-				continue;
+				if (!is_spilled_scalar_reg(&func->stack[i])) {
+					bt_clear_frame_slot(bt, fr, i);
+					continue;
+				}
+				reg = &func->stack[i].spilled_ptr;
+				if (reg->precise)
+					bt_clear_frame_slot(bt, fr, i);
+				else
+					reg->precise = true;
+			}
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+					     bt_frame_reg_mask(bt, fr));
+				verbose(env, "mark_precise: frame%d: parent state regs=%s ",
+					fr, env->tmp_str_buf);
+				fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
+					       bt_frame_stack_mask(bt, fr));
+				verbose(env, "stack=%s: ", env->tmp_str_buf);
+				print_verifier_state(env, func, true);
 			}
-			reg = &func->stack[i].spilled_ptr;
-			if (reg->precise)
-				bt_clear_slot(bt, i);
-			else
-				reg->precise = true;
-		}
-		if (env->log.level & BPF_LOG_LEVEL2) {
-			verbose(env, "parent %s regs=%x stack=%llx marks:",
-				!bt_empty(bt) ? "didn't have" : "already had",
-				bt_reg_mask(bt), bt_stack_mask(bt));
-			print_verifier_state(env, func, true);
 		}
 
 		if (bt_empty(bt))
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 86cb0722792f0..a928c53432999 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -44,7 +44,7 @@
 	mark_precise: frame0: regs=r2 stack= before 23\
 	mark_precise: frame0: regs=r2 stack= before 22\
 	mark_precise: frame0: regs=r2 stack= before 20\
-	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 10\
 	mark_precise: frame0: regs=r2 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
@@ -55,7 +55,7 @@
 	mark_precise: frame0: regs=r9 stack= before 12\
 	mark_precise: frame0: regs=r9 stack= before 11\
 	mark_precise: frame0: regs=r9 stack= before 10\
-	parent already had regs=0 stack=0 marks:",
+	mark_precise: frame0: parent state regs= stack=:",
 },
 {
 	"precise: test 2",
@@ -104,15 +104,15 @@
 	mark_precise: frame0: regs=r2 stack= before 24\
 	mark_precise: frame0: regs=r2 stack= before 23\
 	mark_precise: frame0: regs=r2 stack= before 22\
-	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
 	mark_precise: frame0: regs=r2 stack= before 20\
-	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 17\
 	mark_precise: frame0: regs=r2 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
 	mark_precise: frame0: regs=r8,r9 stack= before 17\
-	parent already had regs=0 stack=0 marks:",
+	mark_precise: frame0: parent state regs= stack=:",
 },
 {
 	"precise: cross frame pruning",
@@ -153,14 +153,14 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
 	.errstr = "mark_precise: frame0: last_idx 5 first_idx 5\
-	parent didn't have regs=10 stack=0 marks:\
+	mark_precise: frame0: parent state regs=r4 stack=:\
 	mark_precise: frame0: last_idx 4 first_idx 2\
 	mark_precise: frame0: regs=r4 stack= before 4\
 	mark_precise: frame0: regs=r4 stack= before 3\
 	mark_precise: frame0: regs= stack=-8 before 2\
 	mark_precise: frame0: falling back to forcing all scalars precise\
 	mark_precise: frame0: last_idx 5 first_idx 5\
-	parent didn't have regs=1 stack=0 marks:",
+	mark_precise: frame0: parent state regs=r0 stack=:",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
@@ -179,7 +179,7 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
 	.errstr = "mark_precise: frame0: last_idx 6 first_idx 6\
-	parent didn't have regs=10 stack=0 marks:\
+	mark_precise: frame0: parent state regs=r4 stack=:\
 	mark_precise: frame0: last_idx 5 first_idx 3\
 	mark_precise: frame0: regs=r4 stack= before 5\
 	mark_precise: frame0: regs=r4 stack= before 4\
@@ -188,7 +188,7 @@
 	force_precise: frame0: forcing r0 to be precise\
 	force_precise: frame0: forcing r0 to be precise\
 	mark_precise: frame0: last_idx 6 first_idx 6\
-	parent didn't have regs=1 stack=0 marks:\
+	mark_precise: frame0: parent state regs=r0 stack=:\
 	mark_precise: frame0: last_idx 5 first_idx 3\
 	mark_precise: frame0: regs=r0 stack= before 5",
 	.result = VERBOSE_ACCEPT,
-- 
2.39.2



