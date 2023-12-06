Return-Path: <stable+bounces-4790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F0806472
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 02:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D1128166B
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 01:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F84431;
	Wed,  6 Dec 2023 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+4YMDzx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03717DB
	for <stable@vger.kernel.org>; Wed,  6 Dec 2023 01:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E109C433C7;
	Wed,  6 Dec 2023 01:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701827731;
	bh=XplUz52PVtPLqenCuiP070I9f3WGAbiIV7pE6xo4Ovc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+4YMDzxii/2PI81EAlllSy6zxjtyJmHmAY7sDJh8e5oQAbdldsViFCBMQEFXprob
	 lCAw0mLvdTosdERK8AYAI5n2GUsPaw606fUgxq8EwBGe537vNQ9ZLnuTqPa7qvQJmn
	 sZ5EvnHaZGer1AzG++x1bDNtLXdst4AuItQN3dxwgg+MBkSMlTTs9WEGetpr9j3SFT
	 ldSF1QSgsSwfIs71UVS6elLVvFdBhkQbgkYaxinNo5I922+nOtqDs5tALFafrj/yp7
	 wDO4KD6nmH41ep1Ucw8as3p2sFBsvNflV9ekYu/rHgE1Ws7syKDY1e7/mtAKHfUV5T
	 vOh0+JVpJfrxw==
From: mhiramat@kernel.org
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	kernel test robot <lkp@intel.com>,
	JP Kobryn <inwardvessel@gmail.com>
Subject: [PATCH 6.1.y] rethook: Use __rcu pointer for rethook::handler
Date: Wed,  6 Dec 2023 10:55:26 +0900
Message-ID: <20231206015526.39044-1-mhiramat@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <2023120321-emboss-bunion-bf59@gregkh>
References: <2023120321-emboss-bunion-bf59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since the rethook::handler is an RCU-maganged pointer so that it will
notice readers the rethook is stopped (unregistered) or not, it should
be an __rcu pointer and use appropriate functions to be accessed. This
will use appropriate memory barrier when accessing it. OTOH,
rethook::data is never changed, so we don't need to check it in
get_kretprobe().

NOTE: To avoid sparse warning, rethook::handler is defined by a raw
function pointer type with __rcu instead of rethook_handler_t.

Link: https://lore.kernel.org/all/170126066201.398836.837498688669005979.stgit@devnote2/

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311241808.rv9ceuAh-lkp@intel.com/
Tested-by: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
(cherry picked from commit a1461f1fd6cfdc4b8917c9d4a91e92605d1f28dc)
---
 include/linux/kprobes.h |  6 ++----
 include/linux/rethook.h |  7 ++++++-
 kernel/trace/rethook.c  | 23 ++++++++++++++---------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 85a64cb95d75..38a774287bde 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -202,10 +202,8 @@ extern int arch_trampoline_kprobe(struct kprobe *p);
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
-		"Kretprobe is accessed from instance under preemptive context");
-
-	return (struct kretprobe *)READ_ONCE(ri->node.rethook->data);
+	/* rethook::data is non-changed field, so that you can access it freely. */
+	return (struct kretprobe *)ri->node.rethook->data;
 }
 static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_instance *ri)
 {
diff --git a/include/linux/rethook.h b/include/linux/rethook.h
index bdbe6717f45a..a00963f33bc1 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -29,7 +29,12 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, struct pt_regs
  */
 struct rethook {
 	void			*data;
-	rethook_handler_t	handler;
+	/*
+	 * To avoid sparse warnings, this uses a raw function pointer with
+	 * __rcu, instead of rethook_handler_t. But this must be same as
+	 * rethook_handler_t.
+	 */
+	void (__rcu *handler) (struct rethook_node *, void *, struct pt_regs *);
 	struct freelist_head	pool;
 	refcount_t		ref;
 	struct rcu_head		rcu;
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 468006cce7ca..3686626b52c5 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -63,7 +63,7 @@ static void rethook_free_rcu(struct rcu_head *head)
  */
 void rethook_stop(struct rethook *rh)
 {
-	WRITE_ONCE(rh->handler, NULL);
+	rcu_assign_pointer(rh->handler, NULL);
 }
 
 /**
@@ -78,11 +78,17 @@ void rethook_stop(struct rethook *rh)
  */
 void rethook_free(struct rethook *rh)
 {
-	WRITE_ONCE(rh->handler, NULL);
+	rethook_stop(rh);
 
 	call_rcu(&rh->rcu, rethook_free_rcu);
 }
 
+static inline rethook_handler_t rethook_get_handler(struct rethook *rh)
+{
+	return (rethook_handler_t)rcu_dereference_check(rh->handler,
+							rcu_read_lock_any_held());
+}
+
 /**
  * rethook_alloc() - Allocate struct rethook.
  * @data: a data to pass the @handler when hooking the return.
@@ -102,7 +108,7 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler)
 	}
 
 	rh->data = data;
-	rh->handler = handler;
+	rcu_assign_pointer(rh->handler, handler);
 	rh->pool.head = NULL;
 	refcount_set(&rh->ref, 1);
 
@@ -142,9 +148,10 @@ static void free_rethook_node_rcu(struct rcu_head *head)
  */
 void rethook_recycle(struct rethook_node *node)
 {
-	lockdep_assert_preemption_disabled();
+	rethook_handler_t handler;
 
-	if (likely(READ_ONCE(node->rethook->handler)))
+	handler = rethook_get_handler(node->rethook);
+	if (likely(handler))
 		freelist_add(&node->freelist, &node->rethook->pool);
 	else
 		call_rcu(&node->rcu, free_rethook_node_rcu);
@@ -160,11 +167,9 @@ NOKPROBE_SYMBOL(rethook_recycle);
  */
 struct rethook_node *rethook_try_get(struct rethook *rh)
 {
-	rethook_handler_t handler = READ_ONCE(rh->handler);
+	rethook_handler_t handler = rethook_get_handler(rh);
 	struct freelist_node *fn;
 
-	lockdep_assert_preemption_disabled();
-
 	/* Check whether @rh is going to be freed. */
 	if (unlikely(!handler))
 		return NULL;
@@ -312,7 +317,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		rhn = container_of(first, struct rethook_node, llist);
 		if (WARN_ON_ONCE(rhn->frame != frame))
 			break;
-		handler = READ_ONCE(rhn->rethook->handler);
+		handler = rethook_get_handler(rhn->rethook);
 		if (handler)
 			handler(rhn, rhn->rethook->data, regs);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog


