Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164946FA7F2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbjEHKg0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjEHKgC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:36:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6FE23A28
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 547756278C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41097C433D2;
        Mon,  8 May 2023 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542131;
        bh=dg+8CeYvd6hQL7IzaKL8FyjywyUcwL6Lw/qFOADmxks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S4aCbzNp2s0AVruKAnSfdoUjEv/mGPnYkqIuyClzuI5is54nha3BXqXCmFV4PRkpm
         6Rwf2+e8BNlpIEIugNgKPS5XD0/EnTFGyQR7GOCNkU+tsTaNOMAoysKeztY9Qh1GBK
         S2RnUZ/LdwBXeiG2/26rT1zKWy3DtF2Ebn1qKsTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 336/663] bpf: factor out fetching basic kfunc metadata
Date:   Mon,  8 May 2023 11:42:42 +0200
Message-Id: <20230508094439.072636232@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

[ Upstream commit 07236eab7a3139da97aef9f5f21f403be82a82ea ]

Factor out logic to fetch basic kfunc metadata based on struct bpf_insn.
This is not exactly short or trivial code to just copy/paste and this
information is sometimes necessary in other parts of the verifier logic.
Subsequent patches will rely on this to determine if an instruction is
a kfunc call to iterator next method.

No functional changes intended, including that verbose() warning
behavior when kfunc is not allowed for a particular program type.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20230308184121.1165081-2-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: f6a6a5a97628 ("bpf: Fix struct_meta lookup for bpf_obj_free_fields kfunc call")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 92 +++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3fa2b177ab624..6db3589f0e7cc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9627,24 +9627,21 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 	return 0;
 }
 
-static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			    int *insn_idx_p)
+static int fetch_kfunc_meta(struct bpf_verifier_env *env,
+			    struct bpf_insn *insn,
+			    struct bpf_kfunc_call_arg_meta *meta,
+			    const char **kfunc_name)
 {
-	const struct btf_type *t, *func, *func_proto, *ptr_type;
-	u32 i, nargs, func_id, ptr_type_id, release_ref_obj_id;
-	struct bpf_reg_state *regs = cur_regs(env);
-	const char *func_name, *ptr_type_name;
-	bool sleepable, rcu_lock, rcu_unlock;
-	struct bpf_kfunc_call_arg_meta meta;
-	int err, insn_idx = *insn_idx_p;
-	const struct btf_param *args;
-	const struct btf_type *ret_t;
+	const struct btf_type *func, *func_proto;
+	u32 func_id, *kfunc_flags;
+	const char *func_name;
 	struct btf *desc_btf;
-	u32 *kfunc_flags;
 
-	/* skip for now, but return error when we find this in fixup_kfunc_call */
+	if (kfunc_name)
+		*kfunc_name = NULL;
+
 	if (!insn->imm)
-		return 0;
+		return -EINVAL;
 
 	desc_btf = find_kfunc_desc_btf(env, insn->off);
 	if (IS_ERR(desc_btf))
@@ -9653,22 +9650,51 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	func_id = insn->imm;
 	func = btf_type_by_id(desc_btf, func_id);
 	func_name = btf_name_by_offset(desc_btf, func->name_off);
+	if (kfunc_name)
+		*kfunc_name = func_name;
 	func_proto = btf_type_by_id(desc_btf, func->type);
 
 	kfunc_flags = btf_kfunc_id_set_contains(desc_btf, resolve_prog_type(env->prog), func_id);
 	if (!kfunc_flags) {
-		verbose(env, "calling kernel function %s is not allowed\n",
-			func_name);
 		return -EACCES;
 	}
 
-	/* Prepare kfunc call metadata */
-	memset(&meta, 0, sizeof(meta));
-	meta.btf = desc_btf;
-	meta.func_id = func_id;
-	meta.kfunc_flags = *kfunc_flags;
-	meta.func_proto = func_proto;
-	meta.func_name = func_name;
+	memset(meta, 0, sizeof(*meta));
+	meta->btf = desc_btf;
+	meta->func_id = func_id;
+	meta->kfunc_flags = *kfunc_flags;
+	meta->func_proto = func_proto;
+	meta->func_name = func_name;
+
+	return 0;
+}
+
+static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			    int *insn_idx_p)
+{
+	const struct btf_type *t, *ptr_type;
+	u32 i, nargs, ptr_type_id, release_ref_obj_id;
+	struct bpf_reg_state *regs = cur_regs(env);
+	const char *func_name, *ptr_type_name;
+	bool sleepable, rcu_lock, rcu_unlock;
+	struct bpf_kfunc_call_arg_meta meta;
+	struct bpf_insn_aux_data *insn_aux;
+	int err, insn_idx = *insn_idx_p;
+	const struct btf_param *args;
+	const struct btf_type *ret_t;
+	struct btf *desc_btf;
+
+	/* skip for now, but return error when we find this in fixup_kfunc_call */
+	if (!insn->imm)
+		return 0;
+
+	err = fetch_kfunc_meta(env, insn, &meta, &func_name);
+	if (err == -EACCES && func_name)
+		verbose(env, "calling kernel function %s is not allowed\n", func_name);
+	if (err)
+		return err;
+	desc_btf = meta.btf;
+	insn_aux = &env->insn_aux_data[insn_idx];
 
 	if (is_kfunc_destructive(&meta) && !capable(CAP_SYS_BOOT)) {
 		verbose(env, "destructive kfunc calls require CAP_SYS_BOOT capability\n");
@@ -9725,7 +9751,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
-				func_name, func_id);
+				func_name, meta.func_id);
 			return err;
 		}
 	}
@@ -9737,14 +9763,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		err = ref_convert_owning_non_owning(env, release_ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d conversion of owning ref to non-owning failed\n",
-				func_name, func_id);
+				func_name, meta.func_id);
 			return err;
 		}
 
 		err = release_reference(env, release_ref_obj_id);
 		if (err) {
 			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
-				func_name, func_id);
+				func_name, meta.func_id);
 			return err;
 		}
 	}
@@ -9754,7 +9780,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					set_rbtree_add_callback_state);
 		if (err) {
 			verbose(env, "kfunc %s#%d failed callback verification\n",
-				func_name, func_id);
+				func_name, meta.func_id);
 			return err;
 		}
 	}
@@ -9763,7 +9789,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		mark_reg_not_init(env, regs, caller_saved[i]);
 
 	/* Check return type */
-	t = btf_type_skip_modifiers(desc_btf, func_proto->type, NULL);
+	t = btf_type_skip_modifiers(desc_btf, meta.func_proto->type, NULL);
 
 	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
 		/* Only exception is bpf_obj_new_impl */
@@ -9812,11 +9838,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				regs[BPF_REG_0].btf = ret_btf;
 				regs[BPF_REG_0].btf_id = ret_btf_id;
 
-				env->insn_aux_data[insn_idx].obj_new_size = ret_t->size;
-				env->insn_aux_data[insn_idx].kptr_struct_meta =
+				insn_aux->obj_new_size = ret_t->size;
+				insn_aux->kptr_struct_meta =
 					btf_find_struct_meta(ret_btf, ret_btf_id);
 			} else if (meta.func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
-				env->insn_aux_data[insn_idx].kptr_struct_meta =
+				insn_aux->kptr_struct_meta =
 					btf_find_struct_meta(meta.arg_obj_drop.btf,
 							     meta.arg_obj_drop.btf_id);
 			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front] ||
@@ -9898,8 +9924,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			regs[BPF_REG_0].id = ++env->id_gen;
 	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
 
-	nargs = btf_type_vlen(func_proto);
-	args = (const struct btf_param *)(func_proto + 1);
+	nargs = btf_type_vlen(meta.func_proto);
+	args = (const struct btf_param *)(meta.func_proto + 1);
 	for (i = 0; i < nargs; i++) {
 		u32 regno = i + 1;
 
-- 
2.39.2



