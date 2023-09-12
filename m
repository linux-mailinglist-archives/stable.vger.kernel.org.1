Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0861E79B8DE
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjIKUwk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbjIKOjO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:39:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E8BF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:39:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF93EC433C7;
        Mon, 11 Sep 2023 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443150;
        bh=nglbuDNTGDCwOQpQV0knPtfwCQBvI5oPQeR8wx/SGVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8+PzdhdPKSbfuC/Ji/4BWi9Ak5gIz4vmdPxnALifBGUZOFcAxPahZdCAlyi8VXUT
         A7L3CQMLkuP2oALbf6NcaHe9c0vCRJwq7hOQkTPQK8WvfER6K/Dhx6iRbtjhXQh4qo
         PySDWt0VXCWDSK/65QG2UAg76ybb+LL+5r+n5msI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 238/737] bpf: Fix check_func_arg_reg_off bug for graph root/node
Date:   Mon, 11 Sep 2023 15:41:37 +0200
Message-ID: <20230911134657.257159129@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 6785b2edf48c6b1c3ea61fe3b0d2e02b8fbf90c0 ]

The commit being fixed introduced a hunk into check_func_arg_reg_off
that bypasses reg->off == 0 enforcement when offset points to a graph
node or root. This might possibly be done for treating bpf_rbtree_remove
and others as KF_RELEASE and then later check correct reg->off in helper
argument checks.

But this is not the case, those helpers are already not KF_RELEASE and
permit non-zero reg->off and verify it later to match the subobject in
BTF type.

However, this logic leads to bpf_obj_drop permitting free of register
arguments with non-zero offset when they point to a graph root or node
within them, which is not ok.

For instance:

struct foo {
	int i;
	int j;
	struct bpf_rb_node node;
};

struct foo *f = bpf_obj_new(typeof(*f));
if (!f) ...
bpf_obj_drop(f); // OK
bpf_obj_drop(&f->i); // still ok from verifier PoV
bpf_obj_drop(&f->node); // Not OK, but permitted right now

Fix this by dropping the whole part of code altogether.

Fixes: 6a3cd3318ff6 ("bpf: Migrate release_on_unlock logic to non-owning ref semantics")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20230822175140.1317749-2-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b9e4dbdfa296a..d4a6120edbb86 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7611,17 +7611,6 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 		if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
 			return 0;
 
-		if ((type_is_ptr_alloc_obj(type) || type_is_non_owning_ref(type)) && reg->off) {
-			if (reg_find_field_offset(reg, reg->off, BPF_GRAPH_NODE_OR_ROOT))
-				return __check_ptr_off_reg(env, reg, regno, true);
-
-			verbose(env, "R%d must have zero offset when passed to release func\n",
-				regno);
-			verbose(env, "No graph node or root found at R%d type:%s off:%d\n", regno,
-				btf_type_name(reg->btf, reg->btf_id), reg->off);
-			return -EINVAL;
-		}
-
 		/* Doing check_ptr_off_reg check for the offset will catch this
 		 * because fixed_off_ok is false, but checking here allows us
 		 * to give the user a better error message.
-- 
2.40.1



