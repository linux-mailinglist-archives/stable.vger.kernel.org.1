Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1A7551E4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjGPUBW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGPUBV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:01:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B31B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC63D60EAA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9D5C433C7;
        Sun, 16 Jul 2023 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537678;
        bh=H5HLAUCXGDfH49OhfK0ycls68fvWiFWBLxFk9QGJXqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7zzr1NgiWS9mlXCTAcKQRaY0/EztzZw0//0znnj0lFutsULkxER3bxe/G7nDRnpf
         JR8Q4OCTdqNi51a47L2jFE6K8VDaLfXardNjPIWzmelWviJio73RTQfz3Ob58jXQ9l
         sCNhlwYZhzqIVLJQuOUiOFP492eV/NHkeI8uBP1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 144/800] bpf: Make bpf_refcount_acquire fallible for non-owning refs
Date:   Sun, 16 Jul 2023 21:39:57 +0200
Message-ID: <20230716194952.440138072@linuxfoundation.org>
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

[ Upstream commit 7793fc3babe9fea908e57f7c187ea819f9fd7e95 ]

This patch fixes an incorrect assumption made in the original
bpf_refcount series [0], specifically that the BPF program calling
bpf_refcount_acquire on some node can always guarantee that the node is
alive. In that series, the patch adding failure behavior to rbtree_add
and list_push_{front, back} breaks this assumption for non-owning
references.

Consider the following program:

  n = bpf_kptr_xchg(&mapval, NULL);
  /* skip error checking */

  bpf_spin_lock(&l);
  if(bpf_rbtree_add(&t, &n->rb, less)) {
    bpf_refcount_acquire(n);
    /* Failed to add, do something else with the node */
  }
  bpf_spin_unlock(&l);

It's incorrect to assume that bpf_refcount_acquire will always succeed in this
scenario. bpf_refcount_acquire is being called in a critical section
here, but the lock being held is associated with rbtree t, which isn't
necessarily the lock associated with the tree that the node is already
in. So after bpf_rbtree_add fails to add the node and calls bpf_obj_drop
in it, the program has no ownership of the node's lifetime. Therefore
the node's refcount can be decr'd to 0 at any time after the failing
rbtree_add. If this happens before the refcount_acquire above, the node
might be free'd, and regardless refcount_acquire will be incrementing a
0 refcount.

Later patches in the series exercise this scenario, resulting in the
expected complaint from the kernel (without this patch's changes):

  refcount_t: addition on 0; use-after-free.
  WARNING: CPU: 1 PID: 207 at lib/refcount.c:25 refcount_warn_saturate+0xbc/0x110
  Modules linked in: bpf_testmod(O)
  CPU: 1 PID: 207 Comm: test_progs Tainted: G           O       6.3.0-rc7-02231-g723de1a718a2-dirty #371
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
  RIP: 0010:refcount_warn_saturate+0xbc/0x110
  Code: 6f 64 f6 02 01 e8 84 a3 5c ff 0f 0b eb 9d 80 3d 5e 64 f6 02 00 75 94 48 c7 c7 e0 13 d2 82 c6 05 4e 64 f6 02 01 e8 64 a3 5c ff <0f> 0b e9 7a ff ff ff 80 3d 38 64 f6 02 00 0f 85 6d ff ff ff 48 c7
  RSP: 0018:ffff88810b9179b0 EFLAGS: 00010082
  RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
  RDX: 0000000000000202 RSI: 0000000000000008 RDI: ffffffff857c3680
  RBP: ffff88810027d3c0 R08: ffffffff8125f2a4 R09: ffff88810b9176e7
  R10: ffffed1021722edc R11: 746e756f63666572 R12: ffff88810027d388
  R13: ffff88810027d3c0 R14: ffffc900005fe030 R15: ffffc900005fe048
  FS:  00007fee0584a700(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00005634a96f6c58 CR3: 0000000108ce9002 CR4: 0000000000770ee0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
   <TASK>
   bpf_refcount_acquire_impl+0xb5/0xc0

  (rest of output snipped)

The patch addresses this by changing bpf_refcount_acquire_impl to use
refcount_inc_not_zero instead of refcount_inc and marking
bpf_refcount_acquire KF_RET_NULL.

For owning references, though, we know the above scenario is not possible
and thus that bpf_refcount_acquire will always succeed. Some verifier
bookkeeping is added to track "is input owning ref?" for bpf_refcount_acquire
calls and return false from is_kfunc_ret_null for bpf_refcount_acquire on
owning refs despite it being marked KF_RET_NULL.

Existing selftests using bpf_refcount_acquire are modified where
necessary to NULL-check its return value.

  [0]: https://lore.kernel.org/bpf/20230415201811.343116-1-davemarchevsky@fb.com/

Fixes: d2dcc67df910 ("bpf: Migrate bpf_rbtree_add and bpf_list_push_{front,back} to possibly fail")
Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Link: https://lore.kernel.org/r/20230602022647.1571784-5-davemarchevsky@fb.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c                          |  8 ++++--
 kernel/bpf/verifier.c                         | 26 +++++++++++++------
 .../selftests/bpf/progs/refcounted_kptr.c     |  2 ++
 .../bpf/progs/refcounted_kptr_fail.c          |  4 ++-
 4 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 27b9f78195b2c..f12565ba136b0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1926,8 +1926,12 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta
 	 * bpf_refcount type so that it is emitted in vmlinux BTF
 	 */
 	ref = (struct bpf_refcount *)(p__refcounted_kptr + meta->record->refcount_off);
+	if (!refcount_inc_not_zero((refcount_t *)ref))
+		return NULL;
 
-	refcount_inc((refcount_t *)ref);
+	/* Verifier strips KF_RET_NULL if input is owned ref, see is_kfunc_ret_null
+	 * in verifier.c
+	 */
 	return (void *)p__refcounted_kptr;
 }
 
@@ -2325,7 +2329,7 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
 #endif
 BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_push_front_impl)
 BTF_ID_FLAGS(func, bpf_list_push_back_impl)
 BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 405f29079a8cb..8e4ccbc0ae604 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -292,16 +292,19 @@ struct bpf_kfunc_call_arg_meta {
 		bool found;
 	} arg_constant;
 
-	/* arg_btf and arg_btf_id are used by kfunc-specific handling,
+	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
 	 * generally to pass info about user-defined local kptr types to later
 	 * verification logic
 	 *   bpf_obj_drop
 	 *     Record the local kptr type to be drop'd
 	 *   bpf_refcount_acquire (via KF_ARG_PTR_TO_REFCOUNTED_KPTR arg type)
-	 *     Record the local kptr type to be refcount_incr'd
+	 *     Record the local kptr type to be refcount_incr'd and use
+	 *     arg_owning_ref to determine whether refcount_acquire should be
+	 *     fallible
 	 */
 	struct btf *arg_btf;
 	u32 arg_btf_id;
+	bool arg_owning_ref;
 
 	struct {
 		struct btf_field *field;
@@ -9497,11 +9500,6 @@ static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ACQUIRE;
 }
 
-static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
-{
-	return meta->kfunc_flags & KF_RET_NULL;
-}
-
 static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_RELEASE;
@@ -9809,6 +9807,16 @@ BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 
+static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
+{
+	if (meta->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
+	    meta->arg_owning_ref) {
+		return false;
+	}
+
+	return meta->kfunc_flags & KF_RET_NULL;
+}
+
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_lock];
@@ -10669,10 +10677,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			meta->subprogno = reg->subprogno;
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
-			if (!type_is_ptr_alloc_obj(reg->type) && !type_is_non_owning_ref(reg->type)) {
+			if (!type_is_ptr_alloc_obj(reg->type)) {
 				verbose(env, "arg#%d is neither owning or non-owning ref\n", i);
 				return -EINVAL;
 			}
+			if (!type_is_non_owning_ref(reg->type))
+				meta->arg_owning_ref = true;
 
 			rec = reg_btf_record(reg);
 			if (!rec) {
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
index 1d348a225140d..a3da610b1e6b0 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
@@ -375,6 +375,8 @@ long rbtree_refcounted_node_ref_escapes(void *ctx)
 	bpf_rbtree_add(&aroot, &n->node, less_a);
 	m = bpf_refcount_acquire(n);
 	bpf_spin_unlock(&alock);
+	if (!m)
+		return 2;
 
 	m->key = 2;
 	bpf_obj_drop(m);
diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index efcb308f80adf..0b09e5c915b15 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=3 alloc_insn=21")
+__failure __msg("Unreleased reference id=4 alloc_insn=21")
 long rbtree_refcounted_node_ref_escapes(void *ctx)
 {
 	struct node_acquire *n, *m;
@@ -43,6 +43,8 @@ long rbtree_refcounted_node_ref_escapes(void *ctx)
 	/* m becomes an owning ref but is never drop'd or added to a tree */
 	m = bpf_refcount_acquire(n);
 	bpf_spin_unlock(&glock);
+	if (!m)
+		return 2;
 
 	m->key = 2;
 	return 0;
-- 
2.39.2



