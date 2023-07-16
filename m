Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A022F755192
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGPT6B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjGPT57 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75AB1B4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6745460EB6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E422C433C7;
        Sun, 16 Jul 2023 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537476;
        bh=1ybmBIp9TzYmKb+75ByHtuF00H9MYRsoXQOiKlsfnKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUaKiVD/NbM9eNG27Wc4te5epyZfJE6LQf7P9s+OXewJNci6PcbPyXTliaQJplvLk
         9YnXuddljmcXQ3OFRUZTI+uzbwdtY3lYk1nEDFuhMmORGosPxstLSJKQFqjgcJLnQa
         5IOvKqKA1W0j5DAScR7my2fMdiANRk2VWHYrZP2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 109/800] bpf: improve precision backtrack logging
Date:   Sun, 16 Jul 2023 21:39:22 +0200
Message-ID: <20230716194951.645266655@linuxfoundation.org>
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

[ Upstream commit d9439c21a9e4769bfd83a03ab39056164d44ac31 ]

Add helper to format register and stack masks in more human-readable
format. Adjust logging a bit during backtrack propagation and especially
during forcing precision fallback logic to make it clearer what's going
on (with log_level=2, of course), and also start reporting affected
frame depth. This is in preparation for having more than one active
frame later when precision propagation between subprog calls is added.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230505043317.3629845-5-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: f655badf2a8f ("bpf: fix propagate_precision() logic for inner frames")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h                  |  13 ++-
 kernel/bpf/verifier.c                         |  72 ++++++++++--
 .../testing/selftests/bpf/verifier/precise.c  | 106 +++++++++---------
 3 files changed, 128 insertions(+), 63 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 33f541366f4e7..5b11a3b0fec0b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -18,8 +18,11 @@
  * that converting umax_value to int cannot overflow.
  */
 #define BPF_MAX_VAR_SIZ	(1 << 29)
-/* size of type_str_buf in bpf_verifier. */
-#define TYPE_STR_BUF_LEN 128
+/* size of tmp_str_buf in bpf_verifier.
+ * we need at least 306 bytes to fit full stack mask representation
+ * (in the "-8,-16,...,-512" form)
+ */
+#define TMP_STR_BUF_LEN 320
 
 /* Liveness marks, used for registers and spilled-regs (in stack slots).
  * Read marks propagate upwards until they find a write mark; they record that
@@ -620,8 +623,10 @@ struct bpf_verifier_env {
 	/* Same as scratched_regs but for stack slots */
 	u64 scratched_stack_slots;
 	u64 prev_log_pos, prev_insn_print_pos;
-	/* buffer used in reg_type_str() to generate reg_type string */
-	char type_str_buf[TYPE_STR_BUF_LEN];
+	/* buffer used to generate temporary string representations,
+	 * e.g., in reg_type_str() to generate reg_type string
+	 */
+	char tmp_str_buf[TMP_STR_BUF_LEN];
 };
 
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index acd0780f9b907..9260006c13823 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -604,9 +604,9 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		 type & PTR_TRUSTED ? "trusted_" : ""
 	);
 
-	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
+	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
-	return env->type_str_buf;
+	return env->tmp_str_buf;
 }
 
 static char slot_type_char[] = {
@@ -3266,6 +3266,45 @@ static inline bool bt_is_slot_set(struct backtrack_state *bt, u32 slot)
 	return bt->stack_masks[bt->frame] & (1ull << slot);
 }
 
+/* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
+static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
+{
+	DECLARE_BITMAP(mask, 64);
+	bool first = true;
+	int i, n;
+
+	buf[0] = '\0';
+
+	bitmap_from_u64(mask, reg_mask);
+	for_each_set_bit(i, mask, 32) {
+		n = snprintf(buf, buf_sz, "%sr%d", first ? "" : ",", i);
+		first = false;
+		buf += n;
+		buf_sz -= n;
+		if (buf_sz < 0)
+			break;
+	}
+}
+/* format stack slots bitmask, e.g., "-8,-24,-40" for 0x15 mask */
+static void fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask)
+{
+	DECLARE_BITMAP(mask, 64);
+	bool first = true;
+	int i, n;
+
+	buf[0] = '\0';
+
+	bitmap_from_u64(mask, stack_mask);
+	for_each_set_bit(i, mask, 64) {
+		n = snprintf(buf, buf_sz, "%s%d", first ? "" : ",", -(i + 1) * 8);
+		first = false;
+		buf += n;
+		buf_sz -= n;
+		if (buf_sz < 0)
+			break;
+	}
+}
+
 /* For given verifier state backtrack_insn() is called from the last insn to
  * the first insn. Its purpose is to compute a bitmask of registers and
  * stack slots that needs precision in the parent verifier state.
@@ -3289,7 +3328,11 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
 	if (insn->code == 0)
 		return 0;
 	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "regs=%x stack=%llx before ", bt_reg_mask(bt), bt_stack_mask(bt));
+		fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_reg_mask(bt));
+		verbose(env, "mark_precise: frame%d: regs=%s ",
+			bt->frame, env->tmp_str_buf);
+		fmt_stack_mask(env->tmp_str_buf, TMP_STR_BUF_LEN, bt_stack_mask(bt));
+		verbose(env, "stack=%s before ", env->tmp_str_buf);
 		verbose(env, "%d: ", idx);
 		print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 	}
@@ -3489,6 +3532,11 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg;
 	int i, j;
 
+	if (env->log.level & BPF_LOG_LEVEL2) {
+		verbose(env, "mark_precise: frame%d: falling back to forcing all scalars precise\n",
+			st->curframe);
+	}
+
 	/* big hammer: mark all scalars precise in this path.
 	 * pop_stack may still get !precise scalars.
 	 * We also skip current state and go straight to first parent state,
@@ -3500,17 +3548,25 @@ static void mark_all_scalars_precise(struct bpf_verifier_env *env,
 			func = st->frame[i];
 			for (j = 0; j < BPF_REG_FP; j++) {
 				reg = &func->regs[j];
-				if (reg->type != SCALAR_VALUE)
+				if (reg->type != SCALAR_VALUE || reg->precise)
 					continue;
 				reg->precise = true;
+				if (env->log.level & BPF_LOG_LEVEL2) {
+					verbose(env, "force_precise: frame%d: forcing r%d to be precise\n",
+						i, j);
+				}
 			}
 			for (j = 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
 				if (!is_spilled_reg(&func->stack[j]))
 					continue;
 				reg = &func->stack[j].spilled_ptr;
-				if (reg->type != SCALAR_VALUE)
+				if (reg->type != SCALAR_VALUE || reg->precise)
 					continue;
 				reg->precise = true;
+				if (env->log.level & BPF_LOG_LEVEL2) {
+					verbose(env, "force_precise: frame%d: forcing fp%d to be precise\n",
+						i, -(j + 1) * 8);
+				}
 			}
 		}
 	}
@@ -3674,8 +3730,10 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 		DECLARE_BITMAP(mask, 64);
 		u32 history = st->jmp_history_cnt;
 
-		if (env->log.level & BPF_LOG_LEVEL2)
-			verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
+		if (env->log.level & BPF_LOG_LEVEL2) {
+			verbose(env, "mark_precise: frame%d: last_idx %d first_idx %d\n",
+				bt->frame, last_idx, first_idx);
+		}
 
 		if (last_idx < 0) {
 			/* we are at the entry into subprog, which
diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
index 6c03a7d805f9d..86cb0722792f0 100644
--- a/tools/testing/selftests/bpf/verifier/precise.c
+++ b/tools/testing/selftests/bpf/verifier/precise.c
@@ -38,25 +38,24 @@
 	.fixup_map_array_48b = { 1 },
 	.result = VERBOSE_ACCEPT,
 	.errstr =
-	"26: (85) call bpf_probe_read_kernel#113\
-	last_idx 26 first_idx 20\
-	regs=4 stack=0 before 25\
-	regs=4 stack=0 before 24\
-	regs=4 stack=0 before 23\
-	regs=4 stack=0 before 22\
-	regs=4 stack=0 before 20\
-	parent didn't have regs=4 stack=0 marks\
-	last_idx 19 first_idx 10\
-	regs=4 stack=0 before 19\
-	regs=200 stack=0 before 18\
-	regs=300 stack=0 before 17\
-	regs=201 stack=0 before 15\
-	regs=201 stack=0 before 14\
-	regs=200 stack=0 before 13\
-	regs=200 stack=0 before 12\
-	regs=200 stack=0 before 11\
-	regs=200 stack=0 before 10\
-	parent already had regs=0 stack=0 marks",
+	"mark_precise: frame0: last_idx 26 first_idx 20\
+	mark_precise: frame0: regs=r2 stack= before 25\
+	mark_precise: frame0: regs=r2 stack= before 24\
+	mark_precise: frame0: regs=r2 stack= before 23\
+	mark_precise: frame0: regs=r2 stack= before 22\
+	mark_precise: frame0: regs=r2 stack= before 20\
+	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: last_idx 19 first_idx 10\
+	mark_precise: frame0: regs=r2 stack= before 19\
+	mark_precise: frame0: regs=r9 stack= before 18\
+	mark_precise: frame0: regs=r8,r9 stack= before 17\
+	mark_precise: frame0: regs=r0,r9 stack= before 15\
+	mark_precise: frame0: regs=r0,r9 stack= before 14\
+	mark_precise: frame0: regs=r9 stack= before 13\
+	mark_precise: frame0: regs=r9 stack= before 12\
+	mark_precise: frame0: regs=r9 stack= before 11\
+	mark_precise: frame0: regs=r9 stack= before 10\
+	parent already had regs=0 stack=0 marks:",
 },
 {
 	"precise: test 2",
@@ -100,20 +99,20 @@
 	.flags = BPF_F_TEST_STATE_FREQ,
 	.errstr =
 	"26: (85) call bpf_probe_read_kernel#113\
-	last_idx 26 first_idx 22\
-	regs=4 stack=0 before 25\
-	regs=4 stack=0 before 24\
-	regs=4 stack=0 before 23\
-	regs=4 stack=0 before 22\
-	parent didn't have regs=4 stack=0 marks\
-	last_idx 20 first_idx 20\
-	regs=4 stack=0 before 20\
-	parent didn't have regs=4 stack=0 marks\
-	last_idx 19 first_idx 17\
-	regs=4 stack=0 before 19\
-	regs=200 stack=0 before 18\
-	regs=300 stack=0 before 17\
-	parent already had regs=0 stack=0 marks",
+	mark_precise: frame0: last_idx 26 first_idx 22\
+	mark_precise: frame0: regs=r2 stack= before 25\
+	mark_precise: frame0: regs=r2 stack= before 24\
+	mark_precise: frame0: regs=r2 stack= before 23\
+	mark_precise: frame0: regs=r2 stack= before 22\
+	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: last_idx 20 first_idx 20\
+	mark_precise: frame0: regs=r2 stack= before 20\
+	parent didn't have regs=4 stack=0 marks:\
+	mark_precise: frame0: last_idx 19 first_idx 17\
+	mark_precise: frame0: regs=r2 stack= before 19\
+	mark_precise: frame0: regs=r9 stack= before 18\
+	mark_precise: frame0: regs=r8,r9 stack= before 17\
+	parent already had regs=0 stack=0 marks:",
 },
 {
 	"precise: cross frame pruning",
@@ -153,15 +152,15 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "5: (2d) if r4 > r0 goto pc+0\
-	last_idx 5 first_idx 5\
-	parent didn't have regs=10 stack=0 marks\
-	last_idx 4 first_idx 2\
-	regs=10 stack=0 before 4\
-	regs=10 stack=0 before 3\
-	regs=0 stack=1 before 2\
-	last_idx 5 first_idx 5\
-	parent didn't have regs=1 stack=0 marks",
+	.errstr = "mark_precise: frame0: last_idx 5 first_idx 5\
+	parent didn't have regs=10 stack=0 marks:\
+	mark_precise: frame0: last_idx 4 first_idx 2\
+	mark_precise: frame0: regs=r4 stack= before 4\
+	mark_precise: frame0: regs=r4 stack= before 3\
+	mark_precise: frame0: regs= stack=-8 before 2\
+	mark_precise: frame0: falling back to forcing all scalars precise\
+	mark_precise: frame0: last_idx 5 first_idx 5\
+	parent didn't have regs=1 stack=0 marks:",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
@@ -179,16 +178,19 @@
 	},
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "last_idx 6 first_idx 6\
-	parent didn't have regs=10 stack=0 marks\
-	last_idx 5 first_idx 3\
-	regs=10 stack=0 before 5\
-	regs=10 stack=0 before 4\
-	regs=0 stack=1 before 3\
-	last_idx 6 first_idx 6\
-	parent didn't have regs=1 stack=0 marks\
-	last_idx 5 first_idx 3\
-	regs=1 stack=0 before 5",
+	.errstr = "mark_precise: frame0: last_idx 6 first_idx 6\
+	parent didn't have regs=10 stack=0 marks:\
+	mark_precise: frame0: last_idx 5 first_idx 3\
+	mark_precise: frame0: regs=r4 stack= before 5\
+	mark_precise: frame0: regs=r4 stack= before 4\
+	mark_precise: frame0: regs= stack=-8 before 3\
+	mark_precise: frame0: falling back to forcing all scalars precise\
+	force_precise: frame0: forcing r0 to be precise\
+	force_precise: frame0: forcing r0 to be precise\
+	mark_precise: frame0: last_idx 6 first_idx 6\
+	parent didn't have regs=1 stack=0 marks:\
+	mark_precise: frame0: last_idx 5 first_idx 3\
+	mark_precise: frame0: regs=r0 stack= before 5",
 	.result = VERBOSE_ACCEPT,
 	.retval = -1,
 },
-- 
2.39.2



