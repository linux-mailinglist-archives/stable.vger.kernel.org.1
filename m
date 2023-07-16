Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7428D755194
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGPT6F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGPT6F (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA001B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED92760EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B377C433C7;
        Sun, 16 Jul 2023 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537482;
        bh=H30gmvDeXNKQ3/HuvKYGUYEDeeRF0EBOrRaLa2QOY9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHYaaVIhdLbzPmSeIaZjblU/rt5xAQ9/6AB+6rQCK+g5eZfhVpV4NX1Ns+nFeUeIv
         mtM2c6velOnKENdVcYuT3TTSPX0KPQh3tasaRf4yZ6ye8+E2Ls5+72Zqvy6lO5HagI
         UvjiPGzNaMfMv5IFpsMulohuqChRFM9Pwhd34lwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 111/800] bpf: fix propagate_precision() logic for inner frames
Date:   Sun, 16 Jul 2023 21:39:24 +0200
Message-ID: <20230716194951.690046778@linuxfoundation.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit f655badf2a8fc028433d9583bf86a6b473721f09 ]

Fix propagate_precision() logic to perform propagation of all necessary
registers and stack slots across all active frames *in one batch step*.

Doing this for each register/slot in each individual frame is wasteful,
but the main problem is that backtracking of instruction in any frame
except the deepest one just doesn't work. This is due to backtracking
logic relying on jump history, and available jump history always starts
(or ends, depending how you view it) in current frame. So, if
prog A (frame #0) called subprog B (frame #1) and we need to propagate
precision of, say, register R6 (callee-saved) within frame #0, we
actually don't even know where jump history that corresponds to prog
A even starts. We'd need to skip subprog part of jump history first to
be able to do this.

Luckily, with struct backtrack_state and __mark_chain_precision()
handling bitmasks tracking/propagation across all active frames at the
same time (added in previous patch), propagate_precision() can be both
fixed and sped up by setting all the necessary bits across all frames
and then performing one __mark_chain_precision() pass. This makes it
unnecessary to skip subprog parts of jump history.

We also improve logging along the way, to clearly specify which
registers' and slots' precision markings are propagated within which
frame. Each frame will have dedicated line and all registers and stack
slots from that frame will be reported in format similar to precision
backtrack regs/stack logging. E.g.:

frame 1: propagating r1,r2,r3,fp-8,fp-16
frame 0: propagating r3,r9,fp-120

Fixes: 529409ea92d5 ("bpf: propagate precision across all frames, not just the last one")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230505043317.3629845-7-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 65 +++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bc4cf078e6277..fb0aee90ccfaa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3684,8 +3684,7 @@ static void mark_all_scalars_imprecise(struct bpf_verifier_env *env, struct bpf_
  * mark_all_scalars_imprecise() to hopefully get more permissive and generic
  * finalized states which help in short circuiting more future states.
  */
-static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int regno,
-				  int spi)
+static int __mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
 	struct backtrack_state *bt = &env->bt;
 	struct bpf_verifier_state *st = env->cur_state;
@@ -3700,13 +3699,13 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		return 0;
 
 	/* set frame number from which we are starting to backtrack */
-	bt_init(bt, frame);
+	bt_init(bt, env->cur_state->curframe);
 
 	/* Do sanity checks against current state of register and/or stack
 	 * slot, but don't set precise flag in current state, as precision
 	 * tracking in the current state is unnecessary.
 	 */
-	func = st->frame[frame];
+	func = st->frame[bt->frame];
 	if (regno >= 0) {
 		reg = &func->regs[regno];
 		if (reg->type != SCALAR_VALUE) {
@@ -3716,13 +3715,6 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		bt_set_reg(bt, regno);
 	}
 
-	while (spi >= 0) {
-		if (!is_spilled_scalar_reg(&func->stack[spi]))
-			break;
-		bt_set_slot(bt, spi);
-		break;
-	}
-
 	if (bt_empty(bt))
 		return 0;
 
@@ -3872,17 +3864,15 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno)
 {
-	return __mark_chain_precision(env, env->cur_state->curframe, regno, -1);
-}
-
-static int mark_chain_precision_frame(struct bpf_verifier_env *env, int frame, int regno)
-{
-	return __mark_chain_precision(env, frame, regno, -1);
+	return __mark_chain_precision(env, regno);
 }
 
-static int mark_chain_precision_stack_frame(struct bpf_verifier_env *env, int frame, int spi)
+/* mark_chain_precision_batch() assumes that env->bt is set in the caller to
+ * desired reg and stack masks across all relevant frames
+ */
+static int mark_chain_precision_batch(struct bpf_verifier_env *env)
 {
-	return __mark_chain_precision(env, frame, -1, spi);
+	return __mark_chain_precision(env, -1);
 }
 
 static bool is_spillable_regtype(enum bpf_reg_type type)
@@ -15298,20 +15288,25 @@ static int propagate_precision(struct bpf_verifier_env *env,
 	struct bpf_reg_state *state_reg;
 	struct bpf_func_state *state;
 	int i, err = 0, fr;
+	bool first;
 
 	for (fr = old->curframe; fr >= 0; fr--) {
 		state = old->frame[fr];
 		state_reg = state->regs;
+		first = true;
 		for (i = 0; i < BPF_REG_FP; i++, state_reg++) {
 			if (state_reg->type != SCALAR_VALUE ||
 			    !state_reg->precise ||
 			    !(state_reg->live & REG_LIVE_READ))
 				continue;
-			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating r%d\n", fr, i);
-			err = mark_chain_precision_frame(env, fr, i);
-			if (err < 0)
-				return err;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "frame %d: propagating r%d", fr, i);
+				else
+					verbose(env, ",r%d", i);
+			}
+			bt_set_frame_reg(&env->bt, fr, i);
+			first = false;
 		}
 
 		for (i = 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
@@ -15322,14 +15317,24 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			    !state_reg->precise ||
 			    !(state_reg->live & REG_LIVE_READ))
 				continue;
-			if (env->log.level & BPF_LOG_LEVEL2)
-				verbose(env, "frame %d: propagating fp%d\n",
-					fr, (-i - 1) * BPF_REG_SIZE);
-			err = mark_chain_precision_stack_frame(env, fr, i);
-			if (err < 0)
-				return err;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "frame %d: propagating fp%d",
+						fr, (-i - 1) * BPF_REG_SIZE);
+				else
+					verbose(env, ",fp%d", (-i - 1) * BPF_REG_SIZE);
+			}
+			bt_set_frame_slot(&env->bt, fr, i);
+			first = false;
 		}
+		if (!first)
+			verbose(env, "\n");
 	}
+
+	err = mark_chain_precision_batch(env);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
-- 
2.39.2



