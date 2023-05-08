Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F8E6FAB83
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjEHLOM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjEHLOI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:14:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A0D36106
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:14:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01E6B62BC4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5832C433EF;
        Mon,  8 May 2023 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544446;
        bh=B+2fWWRfzEoFhTWOo/H8qb1sQiMNHL0cVJGHSM4C7To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQB2LzcjJIPEpeysowua4iBAEdT+OPUOQ6U/iBHL57dNHG5VAjFFeWChHzLtwvRBR
         T2hsS0LDBbB/DwDZ2qVmHvyh4nL8GsptkWGacqKYp4NRqclMyNIH1A+JvMKu9HGH/8
         Y9IHgfwCuAt4y83izzs5sUtgoq5N+MSwxhN28LX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 383/694] bpf: Fix struct_meta lookup for bpf_obj_free_fields kfunc call
Date:   Mon,  8 May 2023 11:43:38 +0200
Message-Id: <20230508094445.382172897@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

[ Upstream commit f6a6a5a976288e4d0d94eb1c6c9e983e8e5cdb31 ]

bpf_obj_drop_impl has a void return type. In check_kfunc_call, the "else
if" which sets insn_aux->kptr_struct_meta for bpf_obj_drop_impl is
surrounded by a larger if statement which checks btf_type_is_ptr. As a
result:

  * The bpf_obj_drop_impl-specific code will never execute
  * The btf_struct_meta input to bpf_obj_drop is always NULL
  * __bpf_obj_drop_impl will always see a NULL btf_record when called
    from BPF program, and won't call bpf_obj_free_fields
  * program-allocated kptrs which have fields that should be cleaned up
    by bpf_obj_free_fields may instead leak resources

This patch adds a btf_type_is_void branch to the larger if and moves
special handling for bpf_obj_drop_impl there, fixing the issue.

Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Link: https://lore.kernel.org/r/20230403200027.2271029-1-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 559c9137f834d..64600acbb4e76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10002,10 +10002,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				insn_aux->obj_new_size = ret_t->size;
 				insn_aux->kptr_struct_meta =
 					btf_find_struct_meta(ret_btf, ret_btf_id);
-			} else if (meta.func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
-				insn_aux->kptr_struct_meta =
-					btf_find_struct_meta(meta.arg_obj_drop.btf,
-							     meta.arg_obj_drop.btf_id);
 			} else if (meta.func_id == special_kfunc_list[KF_bpf_list_pop_front] ||
 				   meta.func_id == special_kfunc_list[KF_bpf_list_pop_back]) {
 				struct btf_field *field = meta.arg_list_head.field;
@@ -10090,7 +10086,15 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 		if (reg_may_point_to_spin_lock(&regs[BPF_REG_0]) && !regs[BPF_REG_0].id)
 			regs[BPF_REG_0].id = ++env->id_gen;
-	} /* else { add_kfunc_call() ensures it is btf_type_is_void(t) } */
+	} else if (btf_type_is_void(t)) {
+		if (meta.btf == btf_vmlinux && btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
+			if (meta.func_id == special_kfunc_list[KF_bpf_obj_drop_impl]) {
+				insn_aux->kptr_struct_meta =
+					btf_find_struct_meta(meta.arg_obj_drop.btf,
+							     meta.arg_obj_drop.btf_id);
+			}
+		}
+	}
 
 	nargs = btf_type_vlen(meta.func_proto);
 	args = (const struct btf_param *)(meta.func_proto + 1);
-- 
2.39.2



