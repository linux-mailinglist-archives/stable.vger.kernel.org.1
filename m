Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841056FA7F1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbjEHKgY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbjEHKf5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:35:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE95242F0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FA86273F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52A8C433EF;
        Mon,  8 May 2023 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542128;
        bh=v4hLS/0hofZrhe6YpggfWPhrrV/S7WthunQSInhs/wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v8y+pTOHtbIJSTNNU5QTdizMdbaRdC4WuTliBVPH8QgqMz+40bXD9hQzt3/575ior
         YkKxRJHoVovqt61TRewV4kZJ7/BWADrPLFbB01Kpp0QMgS9c2V12Kwl00/TUbzPjRa
         9NT0axvi0Jye7C+etnKx+FmHxA25gTGjMJdJVtY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 335/663] bpf: Add callback validation to kfunc verifier logic
Date:   Mon,  8 May 2023 11:42:41 +0200
Message-Id: <20230508094439.043343397@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dave Marchevsky <davemarchevsky@fb.com>

[ Upstream commit 5d92ddc3de1b44a82108af68ed71f638ca20509a ]

Some BPF helpers take a callback function which the helper calls. For
each helper that takes such a callback, there's a special call to
__check_func_call with a callback-state-setting callback that sets up
verifier bpf_func_state for the callback's frame.

kfuncs don't have any of this infrastructure yet, so let's add it in
this patch, following existing helper pattern as much as possible. To
validate functionality of this added plumbing, this patch adds
callback handling for the bpf_rbtree_add kfunc and hopes to lay
groundwork for future graph datastructure callbacks.

In the "general plumbing" category we have:

  * check_kfunc_call doing callback verification right before clearing
    CALLER_SAVED_REGS, exactly like check_helper_call
  * recognition of func_ptr BTF types in kfunc args as
    KF_ARG_PTR_TO_CALLBACK + propagation of subprogno for this arg type

In the "rbtree_add / graph datastructure-specific plumbing" category:

  * Since bpf_rbtree_add must be called while the spin_lock associated
    with the tree is held, don't complain when callback's func_state
    doesn't unlock it by frame exit
  * Mark rbtree_add callback's args with ref_set_non_owning
    to prevent rbtree api functions from being called in the callback.
    Semantically this makes sense, as less() takes no ownership of its
    args when determining which comes first.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Link: https://lore.kernel.org/r/20230214004017.2534011-5-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: f6a6a5a97628 ("bpf: Fix struct_meta lookup for bpf_obj_free_fields kfunc call")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 134 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3bb38cb9c604f..3fa2b177ab624 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -191,6 +191,7 @@ struct bpf_verifier_stack_elem {
 static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
+static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
 
@@ -1609,6 +1610,16 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 	reg->type &= ~PTR_MAYBE_NULL;
 }
 
+static void mark_reg_graph_node(struct bpf_reg_state *regs, u32 regno,
+				struct btf_field_graph_root *ds_head)
+{
+	__mark_reg_known_zero(&regs[regno]);
+	regs[regno].type = PTR_TO_BTF_ID | MEM_ALLOC;
+	regs[regno].btf = ds_head->btf;
+	regs[regno].btf_id = ds_head->value_btf_id;
+	regs[regno].off = ds_head->node_offset;
+}
+
 static bool reg_is_pkt_pointer(const struct bpf_reg_state *reg)
 {
 	return type_is_pkt_pointer(reg->type);
@@ -6771,6 +6782,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->ret_btf_id = reg->btf_id;
 		break;
 	case ARG_PTR_TO_SPIN_LOCK:
+		if (in_rbtree_lock_required_cb(env)) {
+			verbose(env, "can't spin_{lock,unlock} in rbtree cb\n");
+			return -EACCES;
+		}
 		if (meta->func_id == BPF_FUNC_spin_lock) {
 			err = process_spin_lock(env, regno, true);
 			if (err)
@@ -7354,6 +7369,8 @@ static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
 
+static bool is_callback_calling_kfunc(u32 btf_id);
+
 static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     int *insn_idx, int subprog,
 			     set_callee_state_fn set_callee_state_cb)
@@ -7408,10 +7425,18 @@ static int __check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	 * interested in validating only BPF helpers that can call subprogs as
 	 * callbacks
 	 */
-	if (set_callee_state_cb != set_callee_state && !is_callback_calling_function(insn->imm)) {
-		verbose(env, "verifier bug: helper %s#%d is not marked as callback-calling\n",
-			func_id_name(insn->imm), insn->imm);
-		return -EFAULT;
+	if (set_callee_state_cb != set_callee_state) {
+		if (bpf_pseudo_kfunc_call(insn) &&
+		    !is_callback_calling_kfunc(insn->imm)) {
+			verbose(env, "verifier bug: kfunc %s#%d not marked as callback-calling\n",
+				func_id_name(insn->imm), insn->imm);
+			return -EFAULT;
+		} else if (!bpf_pseudo_kfunc_call(insn) &&
+			   !is_callback_calling_function(insn->imm)) { /* helper */
+			verbose(env, "verifier bug: helper %s#%d not marked as callback-calling\n",
+				func_id_name(insn->imm), insn->imm);
+			return -EFAULT;
+		}
 	}
 
 	if (insn->code == (BPF_JMP | BPF_CALL) &&
@@ -7676,6 +7701,63 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
+					 struct bpf_func_state *caller,
+					 struct bpf_func_state *callee,
+					 int insn_idx)
+{
+	/* void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
+	 *                     bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b));
+	 *
+	 * 'struct bpf_rb_node *node' arg to bpf_rbtree_add is the same PTR_TO_BTF_ID w/ offset
+	 * that 'less' callback args will be receiving. However, 'node' arg was release_reference'd
+	 * by this point, so look at 'root'
+	 */
+	struct btf_field *field;
+
+	field = reg_find_field_offset(&caller->regs[BPF_REG_1], caller->regs[BPF_REG_1].off,
+				      BPF_RB_ROOT);
+	if (!field || !field->graph_root.value_btf_id)
+		return -EFAULT;
+
+	mark_reg_graph_node(callee->regs, BPF_REG_1, &field->graph_root);
+	ref_set_non_owning(env, &callee->regs[BPF_REG_1]);
+	mark_reg_graph_node(callee->regs, BPF_REG_2, &field->graph_root);
+	ref_set_non_owning(env, &callee->regs[BPF_REG_2]);
+
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_callback_fn = true;
+	callee->callback_ret_range = tnum_range(0, 1);
+	return 0;
+}
+
+static bool is_rbtree_lock_required_kfunc(u32 btf_id);
+
+/* Are we currently verifying the callback for a rbtree helper that must
+ * be called with lock held? If so, no need to complain about unreleased
+ * lock
+ */
+static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_insn *insn = env->prog->insnsi;
+	struct bpf_func_state *callee;
+	int kfunc_btf_id;
+
+	if (!state->curframe)
+		return false;
+
+	callee = state->frame[state->curframe];
+
+	if (!callee->in_callback_fn)
+		return false;
+
+	kfunc_btf_id = insn[callee->callsite].imm;
+	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
+}
+
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 {
 	struct bpf_verifier_state *state = env->cur_state;
@@ -8427,6 +8509,7 @@ struct bpf_kfunc_call_arg_meta {
 	bool r0_rdonly;
 	u32 ret_btf_id;
 	u64 r0_size;
+	u32 subprogno;
 	struct {
 		u64 value;
 		bool found;
@@ -8605,6 +8688,18 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
 }
 
+static bool is_kfunc_arg_callback(struct bpf_verifier_env *env, const struct btf *btf,
+				  const struct btf_param *arg)
+{
+	const struct btf_type *t;
+
+	t = btf_type_resolve_func_ptr(btf, arg->type, NULL);
+	if (!t)
+		return false;
+
+	return true;
+}
+
 /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
 static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 					const struct btf *btf,
@@ -8664,6 +8759,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_MEM,
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
+	KF_ARG_PTR_TO_CALLBACK,
 	KF_ARG_PTR_TO_RB_ROOT,
 	KF_ARG_PTR_TO_RB_NODE,
 };
@@ -8788,6 +8884,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		return KF_ARG_PTR_TO_BTF_ID;
 	}
 
+	if (is_kfunc_arg_callback(env, meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_CALLBACK;
+
 	if (argno + 1 < nargs && is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]))
 		arg_mem_size = true;
 
@@ -9019,6 +9118,16 @@ static bool is_bpf_graph_api_kfunc(u32 btf_id)
 	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id);
 }
 
+static bool is_callback_calling_kfunc(u32 btf_id)
+{
+	return btf_id == special_kfunc_list[KF_bpf_rbtree_add];
+}
+
+static bool is_rbtree_lock_required_kfunc(u32 btf_id)
+{
+	return is_bpf_rbtree_api_kfunc(btf_id);
+}
+
 static bool check_kfunc_is_graph_root_api(struct bpf_verifier_env *env,
 					  enum btf_field_type head_field_type,
 					  u32 kfunc_btf_id)
@@ -9351,6 +9460,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_RB_NODE:
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
+		case KF_ARG_PTR_TO_CALLBACK:
 			/* Trusted by default */
 			break;
 		default:
@@ -9502,6 +9612,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			/* Skip next '__sz' argument */
 			i++;
 			break;
+		case KF_ARG_PTR_TO_CALLBACK:
+			meta->subprogno = reg->subprogno;
+			break;
 		}
 	}
 
@@ -9636,6 +9749,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_add]) {
+		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
+					set_rbtree_add_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, func_id);
+			return err;
+		}
+	}
+
 	for (i = 0; i < CALLER_SAVED_REGS; i++)
 		mark_reg_not_init(env, regs, caller_saved[i]);
 
@@ -14501,7 +14624,8 @@ static int do_check(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
-				if (env->cur_state->active_lock.ptr) {
+				if (env->cur_state->active_lock.ptr &&
+				    !in_rbtree_lock_required_cb(env)) {
 					verbose(env, "bpf_spin_unlock is missing\n");
 					return -EINVAL;
 				}
-- 
2.39.2



