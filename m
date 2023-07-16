Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE5A7551D1
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGPUAb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGPUAa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97075EE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708FB60EBF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECD4C433C7;
        Sun, 16 Jul 2023 20:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537624;
        bh=GSGTPXpgDhOBh+tKmFL6tz3IFmmkU76XJhz7gRjsEeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRoAQivCjVPBfVmyg7ZVYbA/Vd3ZHP+qYBI8oQsyT0eRTKTO/HTl7PP6e/ANepys/
         Nfo5B9mNrT8bM1y8Ka2c1/0OikNsjc2RdcbqtRYy07eqB03NFXV8yntz531gNoD6MS
         ABlTg7h1OjDoy1VTA2xZOkY6w07oycCum2/JIPbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 163/800] bpf: Verify scalar ids mapping in regsafe() using check_ids()
Date:   Sun, 16 Jul 2023 21:40:16 +0200
Message-ID: <20230716194952.896525878@linuxfoundation.org>
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

[ Upstream commit 1ffc85d9298e0ca0137ba65c93a786143fe167b8 ]

Make sure that the following unsafe example is rejected by verifier:

1: r9 = ... some pointer with range X ...
2: r6 = ... unbound scalar ID=a ...
3: r7 = ... unbound scalar ID=b ...
4: if (r6 > r7) goto +1
5: r6 = r7
6: if (r6 > X) goto ...
--- checkpoint ---
7: r9 += r7
8: *(u64 *)r9 = Y

This example is unsafe because not all execution paths verify r7 range.
Because of the jump at (4) the verifier would arrive at (6) in two states:
I.  r6{.id=b}, r7{.id=b} via path 1-6;
II. r6{.id=a}, r7{.id=b} via path 1-4, 6.

Currently regsafe() does not call check_ids() for scalar registers,
thus from POV of regsafe() states (I) and (II) are identical. If the
path 1-6 is taken by verifier first, and checkpoint is created at (6)
the path [1-4, 6] would be considered safe.

Changes in this commit:
- check_ids() is modified to disallow mapping multiple old_id to the
  same cur_id.
- check_scalar_ids() is added, unlike check_ids() it treats ID zero as
  a unique scalar ID.
- check_scalar_ids() needs to generate temporary unique IDs, field
  'tmp_id_gen' is added to bpf_verifier_env::idmap_scratch to
  facilitate this.
- regsafe() is updated to:
  - use check_scalar_ids() for precise scalar registers.
  - compare scalar registers using memcmp only for explore_alu_limits
    branch. This simplifies control flow for scalar case, and has no
    measurable performance impact.
- check_alu_op() is updated to avoid generating bpf_reg_state::id for
  constant scalar values when processing BPF_MOV. ID is needed to
  propagate range information for identical values, but there is
  nothing to propagate for constants.

Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230613153824.3324830-4-eddyz87@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf_verifier.h | 17 ++++---
 kernel/bpf/verifier.c        | 91 +++++++++++++++++++++++++++---------
 2 files changed, 79 insertions(+), 29 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 22fb13c738a9a..f70f9ac884d24 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -313,11 +313,6 @@ struct bpf_idx_pair {
 	u32 idx;
 };
 
-struct bpf_id_pair {
-	u32 old;
-	u32 cur;
-};
-
 #define MAX_CALL_FRAMES 8
 /* Maximum number of register states that can exist at once */
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)
@@ -557,6 +552,16 @@ struct backtrack_state {
 	u64 stack_masks[MAX_CALL_FRAMES];
 };
 
+struct bpf_id_pair {
+	u32 old;
+	u32 cur;
+};
+
+struct bpf_idmap {
+	u32 tmp_id_gen;
+	struct bpf_id_pair map[BPF_ID_MAP_SIZE];
+};
+
 struct bpf_idset {
 	u32 count;
 	u32 ids[BPF_ID_MAP_SIZE];
@@ -594,7 +599,7 @@ struct bpf_verifier_env {
 	struct bpf_verifier_log log;
 	struct bpf_subprog_info subprog_info[BPF_MAX_SUBPROGS + 1];
 	union {
-		struct bpf_id_pair idmap_scratch[BPF_ID_MAP_SIZE];
+		struct bpf_idmap idmap_scratch;
 		struct bpf_idset idset_scratch;
 	};
 	struct {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 70056b7d5960c..30fabae47a07b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12718,12 +12718,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		if (BPF_SRC(insn->code) == BPF_X) {
 			struct bpf_reg_state *src_reg = regs + insn->src_reg;
 			struct bpf_reg_state *dst_reg = regs + insn->dst_reg;
+			bool need_id = src_reg->type == SCALAR_VALUE && !src_reg->id &&
+				       !tnum_is_const(src_reg->var_off);
 
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
 				/* case: R1 = R2
 				 * copy register state to dest reg
 				 */
-				if (src_reg->type == SCALAR_VALUE && !src_reg->id)
+				if (need_id)
 					/* Assign src and dst registers the same ID
 					 * that will be used by find_equal_scalars()
 					 * to propagate min/max range.
@@ -12742,7 +12744,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				} else if (src_reg->type == SCALAR_VALUE) {
 					bool is_src_reg_u32 = src_reg->umax_value <= U32_MAX;
 
-					if (is_src_reg_u32 && !src_reg->id)
+					if (is_src_reg_u32 && need_id)
 						src_reg->id = ++env->id_gen;
 					copy_register_state(dst_reg, src_reg);
 					/* Make sure ID is cleared if src_reg is not in u32 range otherwise
@@ -14898,8 +14900,9 @@ static bool range_within(struct bpf_reg_state *old,
  * So we look through our idmap to see if this old id has been seen before.  If
  * so, we require the new id to match; otherwise, we add the id pair to the map.
  */
-static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *idmap)
+static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 {
+	struct bpf_id_pair *map = idmap->map;
 	unsigned int i;
 
 	/* either both IDs should be set or both should be zero */
@@ -14910,20 +14913,34 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_id_pair *idmap)
 		return true;
 
 	for (i = 0; i < BPF_ID_MAP_SIZE; i++) {
-		if (!idmap[i].old) {
+		if (!map[i].old) {
 			/* Reached an empty slot; haven't seen this id before */
-			idmap[i].old = old_id;
-			idmap[i].cur = cur_id;
+			map[i].old = old_id;
+			map[i].cur = cur_id;
 			return true;
 		}
-		if (idmap[i].old == old_id)
-			return idmap[i].cur == cur_id;
+		if (map[i].old == old_id)
+			return map[i].cur == cur_id;
+		if (map[i].cur == cur_id)
+			return false;
 	}
 	/* We ran out of idmap slots, which should be impossible */
 	WARN_ON_ONCE(1);
 	return false;
 }
 
+/* Similar to check_ids(), but allocate a unique temporary ID
+ * for 'old_id' or 'cur_id' of zero.
+ * This makes pairs like '0 vs unique ID', 'unique ID vs 0' valid.
+ */
+static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
+{
+	old_id = old_id ? old_id : ++idmap->tmp_id_gen;
+	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
+
+	return check_ids(old_id, cur_id, idmap);
+}
+
 static void clean_func_state(struct bpf_verifier_env *env,
 			     struct bpf_func_state *st)
 {
@@ -15022,7 +15039,7 @@ static void clean_live_states(struct bpf_verifier_env *env, int insn,
 
 static bool regs_exact(const struct bpf_reg_state *rold,
 		       const struct bpf_reg_state *rcur,
-		       struct bpf_id_pair *idmap)
+		       struct bpf_idmap *idmap)
 {
 	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
 	       check_ids(rold->id, rcur->id, idmap) &&
@@ -15031,7 +15048,7 @@ static bool regs_exact(const struct bpf_reg_state *rold,
 
 /* Returns true if (rold safe implies rcur safe) */
 static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
-		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
+		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
 {
 	if (!(rold->live & REG_LIVE_READ))
 		/* explored state didn't use this */
@@ -15068,15 +15085,42 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 
 	switch (base_type(rold->type)) {
 	case SCALAR_VALUE:
-		if (regs_exact(rold, rcur, idmap))
-			return true;
-		if (env->explore_alu_limits)
-			return false;
+		if (env->explore_alu_limits) {
+			/* explore_alu_limits disables tnum_in() and range_within()
+			 * logic and requires everything to be strict
+			 */
+			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
+			       check_scalar_ids(rold->id, rcur->id, idmap);
+		}
 		if (!rold->precise)
 			return true;
-		/* new val must satisfy old val knowledge */
+		/* Why check_ids() for scalar registers?
+		 *
+		 * Consider the following BPF code:
+		 *   1: r6 = ... unbound scalar, ID=a ...
+		 *   2: r7 = ... unbound scalar, ID=b ...
+		 *   3: if (r6 > r7) goto +1
+		 *   4: r6 = r7
+		 *   5: if (r6 > X) goto ...
+		 *   6: ... memory operation using r7 ...
+		 *
+		 * First verification path is [1-6]:
+		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r7;
+		 * - at (5) r6 would be marked <= X, find_equal_scalars() would also mark
+		 *   r7 <= X, because r6 and r7 share same id.
+		 * Next verification path is [1-4, 6].
+		 *
+		 * Instruction (6) would be reached in two states:
+		 *   I.  r6{.id=b}, r7{.id=b} via path 1-6;
+		 *   II. r6{.id=a}, r7{.id=b} via path 1-4, 6.
+		 *
+		 * Use check_ids() to distinguish these states.
+		 * ---
+		 * Also verify that new value satisfies old value range knowledge.
+		 */
 		return range_within(rold, rcur) &&
-		       tnum_in(rold->var_off, rcur->var_off);
+		       tnum_in(rold->var_off, rcur->var_off) &&
+		       check_scalar_ids(rold->id, rcur->id, idmap);
 	case PTR_TO_MAP_KEY:
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
@@ -15122,7 +15166,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 }
 
 static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
-		      struct bpf_func_state *cur, struct bpf_id_pair *idmap)
+		      struct bpf_func_state *cur, struct bpf_idmap *idmap)
 {
 	int i, spi;
 
@@ -15225,7 +15269,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 }
 
 static bool refsafe(struct bpf_func_state *old, struct bpf_func_state *cur,
-		    struct bpf_id_pair *idmap)
+		    struct bpf_idmap *idmap)
 {
 	int i;
 
@@ -15273,13 +15317,13 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (!regsafe(env, &old->regs[i], &cur->regs[i],
-			     env->idmap_scratch))
+			     &env->idmap_scratch))
 			return false;
 
-	if (!stacksafe(env, old, cur, env->idmap_scratch))
+	if (!stacksafe(env, old, cur, &env->idmap_scratch))
 		return false;
 
-	if (!refsafe(old, cur, env->idmap_scratch))
+	if (!refsafe(old, cur, &env->idmap_scratch))
 		return false;
 
 	return true;
@@ -15294,7 +15338,8 @@ static bool states_equal(struct bpf_verifier_env *env,
 	if (old->curframe != cur->curframe)
 		return false;
 
-	memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
+	env->idmap_scratch.tmp_id_gen = env->id_gen;
+	memset(&env->idmap_scratch.map, 0, sizeof(env->idmap_scratch.map));
 
 	/* Verification state from speculative execution simulation
 	 * must never prune a non-speculative execution one.
@@ -15312,7 +15357,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 		return false;
 
 	if (old->active_lock.id &&
-	    !check_ids(old->active_lock.id, cur->active_lock.id, env->idmap_scratch))
+	    !check_ids(old->active_lock.id, cur->active_lock.id, &env->idmap_scratch))
 		return false;
 
 	if (old->active_rcu_lock != cur->active_rcu_lock)
-- 
2.39.2



