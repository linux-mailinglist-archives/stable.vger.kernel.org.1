Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED967551B7
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjGPT7f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGPT7b (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:59:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D46F7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B373E60EB7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C355EC433C8;
        Sun, 16 Jul 2023 19:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537566;
        bh=bde5g+jU4mT/i86Qc0/a26/velf9+EOhqAYj7kOKevw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhkKI1rI1/HhUkhxN0hfnSN3eDFTeUGgqJgBQNKUZJIQSJNOIjSux0ZSjP6pFvICP
         Ml83/FjXQFzpyIavWdEtRjdK2Z5mwByNbFi4VyF7t+Pg0dlrIoK0u4CsAMJP+o23Mt
         H4s4yT7uutPUeSngkq9PiXfu0PDwqEOhq68Uv0Rc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 141/800] bpf: Remove anonymous union in bpf_kfunc_call_arg_meta
Date:   Sun, 16 Jul 2023 21:39:54 +0200
Message-ID: <20230716194952.372172992@linuxfoundation.org>
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

From: Dave Marchevsky <davemarchevsky@fb.com>

[ Upstream commit 4d585f48ee6b38c54c075b151c5efd2ff65f8ffd ]

For kfuncs like bpf_obj_drop and bpf_refcount_acquire - which take
user-defined types as input - the verifier needs to track the specific
type passed in when checking a particular kfunc call. This requires
tracking (btf, btf_id) tuple. In commit 7c50b1cb76ac
("bpf: Add bpf_refcount_acquire kfunc") I added an anonymous union with
inner structs named after the specific kfuncs tracking this information,
with the goal of making it more obvious which kfunc this data was being
tracked / expected to be tracked on behalf of.

In a recent series adding a new user of this tuple, Alexei mentioned
that he didn't like this union usage as it doesn't really help with
readability or bug-proofing ([0]). In an offline convo we agreed to
have the tuple be fields (arg_btf, arg_btf_id), with comments in
bpf_kfunc_call_arg_meta definition enumerating the uses of the fields by
kfunc-specific handling logic. Such a pattern is used by struct
bpf_reg_state without trouble.

Accordingly, this patch removes the anonymous union in favor of arg_btf
and arg_btf_id fields and comment enumerating their current uses. The
patch also removes struct btf_and_id, which was only being used by the
removed union's inner structs.

This is a mechanical change, existing linked_list and rbtree tests will
validate that correct (btf, btf_id) are being passed.

  [0]: https://lore.kernel.org/bpf/20230505021707.vlyiwy57vwxglbka@dhcp-172-26-102-232.dhcp.thefacebook.com

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Link: https://lore.kernel.org/r/20230510213047.1633612-1-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 2140a6e3422d ("bpf: Set kptr_struct_meta for node param to list and rbtree insert funcs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fb0aee90ccfaa..4b3d0ead703f4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -273,11 +273,6 @@ struct bpf_call_arg_meta {
 	struct btf_field *kptr_field;
 };
 
-struct btf_and_id {
-	struct btf *btf;
-	u32 btf_id;
-};
-
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -296,10 +291,18 @@ struct bpf_kfunc_call_arg_meta {
 		u64 value;
 		bool found;
 	} arg_constant;
-	union {
-		struct btf_and_id arg_obj_drop;
-		struct btf_and_id arg_refcount_acquire;
-	};
+
+	/* arg_btf and arg_btf_id are used by kfunc-specific handling,
+	 * generally to pass info about user-defined local kptr types to later
+	 * verification logic
+	 *   bpf_obj_drop
+	 *     Record the local kptr type to be drop'd
+	 *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
+	 *     Record the local kptr type to be refcount_incr'd
+	 */
+	struct btf *arg_btf;
+	u32 arg_btf_id;
+
 	struct {
 		struct btf_field *field;
 	} arg_list_head;
@@ -10493,8 +10496,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			}
 			if (meta->btf == btf_vmlinux &&
 			    meta->func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
-				meta->arg_obj_drop.btf = reg->btf;
-				meta->arg_obj_drop.btf_id = reg->btf_id;
+				meta->arg_btf = reg->btf;
+				meta->arg_btf_id = reg->btf_id;
 			}
 			break;
 		case KF_ARG_PTR_TO_DYNPTR:
@@ -10683,8 +10686,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "bpf_refcount_acquire calls are disabled for now\n");
 				return -EINVAL;
 			}
-			meta->arg_refcount_acquire.btf = reg->btf;
-			meta->arg_refcount_acquire.btf_id = reg->btf_id;
+			meta->arg_btf = reg->btf;
+			meta->arg_btf_id = reg->btf_id;
 			break;
 		}
 	}
@@ -10916,12 +10919,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			} else if (meta.func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl]) {
 				mark_reg_known_zero(env, regs, BPF_REG_0);
 				regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC;
-				regs[BPF_REG_0].btf = meta.arg_refcount_acquire.btf;
-				regs[BPF_REG_0].btf_id = meta.arg_refcount_acquire.btf_id;
+				regs[BPF_REG_0].btf = meta.arg_btf;
+				regs[BPF_REG_0].btf_id = meta.arg_btf_id;
 
 				insn_aux->kptr_struct_meta =
-					btf_find_struct_meta(meta.arg_refcount_acquire.btf,
-							     meta.arg_refcount_acquire.btf_id);
+					btf_find_struct_meta(meta.arg_btf,
+							     meta.arg_btf_id);
 			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front] ||
 				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field = meta.arg_list_head.field;
@@ -11051,8 +11054,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
 			if (meta.func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
 				insn_aux->kptr_struct_meta =
-					btf_find_struct_meta(meta.arg_obj_drop.btf,
-							     meta.arg_obj_drop.btf_id);
+					btf_find_struct_meta(meta.arg_btf,
+							     meta.arg_btf_id);
 			}
 		}
 	}
-- 
2.39.2



