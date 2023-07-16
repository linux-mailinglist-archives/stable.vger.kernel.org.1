Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80F87551CF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGPUA2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGPUA1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D1EE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD1C660EAA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD511C433C7;
        Sun, 16 Jul 2023 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537622;
        bh=ZxwFepWlDRQl2Oc8lPMRRVaOFFGWS5VyGj/xBTj7UvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lK5qEWOTPvkjD7Io1MO5UISQFg/QnQPALbTsiappSVQfnuM5G0+OtX6nQduutimSZ
         xDaJwHmOl8tvb5xo924OVo6waiSPNUAPiWGoOoEe65qwSUNzA4ot1IEaC8F7fipB10
         mmChzs+gUHiwzOQNyVth40GfsIagb8jXwyNUGGuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 162/800] bpf: Use scalar ids in mark_chain_precision()
Date:   Sun, 16 Jul 2023 21:40:15 +0200
Message-ID: <20230716194952.873757267@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 904e6ddf4133c52fdb9654c2cd2ad90f320d48b9 ]

Change mark_chain_precision() to track precision in situations
like below:

    r2 = unknown value
    ...
  --- state #0 ---
    ...
    r1 = r2                 // r1 and r2 now share the same ID
    ...
  --- state #1 {r1.id = A, r2.id = A} ---
    ...
    if (r2 > 10) goto exit; // find_equal_scalars() assigns range to r1
    ...
  --- state #2 {r1.id = A, r2.id = A} ---
    r3 = r10
    r3 += r1                // need to mark both r1 and r2

At the beginning of the processing of each state, ensure that if a
register with a scalar ID is marked as precise, all registers sharing
this ID are also marked as precise.

This property would be used by a follow-up change in regsafe().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230613153824.3324830-2-eddyz87@gmail.com
Stable-dep-of: 1ffc85d9298e ("bpf: Verify scalar ids mapping in regsafe() using check_ids()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h                  |  10 +-
 kernel/bpf/verifier.c                         | 115 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  |   8 +-
 3 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5b11a3b0fec0b..22fb13c738a9a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -557,6 +557,11 @@ struct backtrack_state {
 	u64 stack_masks[MAX_CALL_FRAMES];
 };
 
+struct bpf_idset {
+	u32 count;
+	u32 ids[BPF_ID_MAP_SIZE];
+};
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -588,7 +593,10 @@ struct bpf_verifier_env {
 	const struct bpf_line_info *prev_linfo;
 	struct bpf_verifier_log log;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
-	struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
+	union {
+		struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
+		struct bpf_idset idset_scratch;
+	};
 	struct {
 		int *insn_state;
 		int *insn_stack;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e4ccbc0ae604..70056b7d5960c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3603,6 +3603,96 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
 	}
 }
 
+static bool idset_contains(struct bpf_idset *s, u32 id)
+{
+	u32 i;
+
+	for (i = 0; i < s->count; ++i)
+		if (s->ids[i] == id)
+			return true;
+
+	return false;
+}
+
+static int idset_push(struct bpf_idset *s, u32 id)
+{
+	if (WARN_ON_ONCE(s->count >= ARRAY_SIZE(s->ids)))
+		return -EFAULT;
+	s->ids[s->count++] = id;
+	return 0;
+}
+
+static void idset_reset(struct bpf_idset *s)
+{
+	s->count = 0;
+}
+
+/* Collect a set of IDs for all registers currently marked as precise in env->bt.
+ * Mark all registers with these IDs as precise.
+ */
+static int mark_precise_scalar_ids(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
+{
+	struct bpf_idset *precise_ids = &env->idset_scratch;
+	struct backtrack_state *bt = &env->bt;
+	struct bpf_func_state *func;
+	struct bpf_reg_state *reg;
+	DECLARE_BITMAP(mask, 64);
+	int i, fr;
+
+	idset_reset(precise_ids);
+
+	for (fr = bt->frame; fr >= 0; fr--) {
+		func = st->frame[fr];
+
+		bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
+		for_each_set_bit(i, mask, 32) {
+			reg = &func->regs[i];
+			if (!reg->id || reg->type != SCALAR_VALUE)
+				continue;
+			if (idset_push(precise_ids, reg->id))
+				return -EFAULT;
+		}
+
+		bitmap_from_u64(mask, bt_frame_stack_mask(bt, fr));
+		for_each_set_bit(i, mask, 64) {
+			if (i >= func->allocated_stack / BPF_REG_SIZE)
+				break;
+			if (!is_spilled_scalar_reg(&func->stack[i]))
+				continue;
+			reg = &func->stack[i].spilled_ptr;
+			if (!reg->id)
+				continue;
+			if (idset_push(precise_ids, reg->id))
+				return -EFAULT;
+		}
+	}
+
+	for (fr = 0; fr <= st->curframe; ++fr) {
+		func = st->frame[fr];
+
+		for (i = BPF_REG_0; i < BPF_REG_10; ++i) {
+			reg = &func->regs[i];
+			if (!reg->id)
+				continue;
+			if (!idset_contains(precise_ids, reg->id))
+				continue;
+			bt_set_frame_reg(bt, fr, i);
+		}
+		for (i = 0; i < func->allocated_stack / BPF_REG_SIZE; ++i) {
+			if (!is_spilled_scalar_reg(&func->stack[i]))
+				continue;
+			reg = &func->stack[i].spilled_ptr;
+			if (!reg->id)
+				continue;
+			if (!idset_contains(precise_ids, reg->id))
+				continue;
+			bt_set_frame_slot(bt, fr, i);
+		}
+	}
+
+	return 0;
+}
+
 /*
  * __mark_chain_precision() backtracks BPF program instruction sequence and
  * chain of verifier states making sure that register *regno* (if regno >= 0)
@@ -3733,6 +3823,31 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 				bt->frame, last_idx, first_idx);
 		}
 
+		/* If some register with scalar ID is marked as precise,
+		 * make sure that all registers sharing this ID are also precise.
+		 * This is needed to estimate effect of find_equal_scalars().
+		 * Do this at the last instruction of each state,
+		 * bpf_reg_state::id fields are valid for these instructions.
+		 *
+		 * Allows to track precision in situation like below:
+		 *
+		 *     r2 = unknown value
+		 *     ...
+		 *   --- state #0 ---
+		 *     ...
+		 *     r1 = r2                 // r1 and r2 now share the same ID
+		 *     ...
+		 *   --- state #1 {r1.id = A, r2.id = A} ---
+		 *     ...
+		 *     if (r2 > 10) goto exit; // find_equal_scalars() assigns range to r1
+		 *     ...
+		 *   --- state #2 {r1.id = A, r2.id = A} ---
+		 *     r3 = r10
+		 *     r3 += r1                // need to mark both r1 and r2
+		 */
+		if (mark_precise_scalar_ids(env, st))
+			return -EFAULT;
+
 		if (last_idx < 0) {
 			/* we are at the entry into subprog, which
 			 * is expected for global funcs, but only if
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index a928c53432999..ac5eeea094683 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -46,7 +46,7 @@
 	mark_precise: frame0: regs=r2 stack= before 20\
 	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 10\
-	mark_precise: frame0: regs=r2 stack= before 19\
+	mark_precise: frame0: regs=r2,r9 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
 	mark_precise: frame0: regs=r8,r9 stack= before 17\
 	mark_precise: frame0: regs=r0,r9 stack= before 15\
@@ -106,10 +106,10 @@
 	mark_precise: frame0: regs=r2 stack= before 22\
 	mark_precise: frame0: parent state regs=r2 stack=:\
 	mark_precise: frame0: last_idx 20 first_idx 20\
-	mark_precise: frame0: regs=r2 stack= before 20\
-	mark_precise: frame0: parent state regs=r2 stack=:\
+	mark_precise: frame0: regs=r2,r9 stack= before 20\
+	mark_precise: frame0: parent state regs=r2,r9 stack=:\
 	mark_precise: frame0: last_idx 19 first_idx 17\
-	mark_precise: frame0: regs=r2 stack= before 19\
+	mark_precise: frame0: regs=r2,r9 stack= before 19\
 	mark_precise: frame0: regs=r9 stack= before 18\
 	mark_precise: frame0: regs=r8,r9 stack= before 17\
 	mark_precise: frame0: parent state regs= stack=:",
-- 
2.39.2



