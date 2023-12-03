Return-Path: <stable+bounces-3737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E458023E1
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16C11C20856
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1D8DDC9;
	Sun,  3 Dec 2023 12:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n4FEhxSs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDC3D79
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 12:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964ABC433C8;
	Sun,  3 Dec 2023 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701607953;
	bh=rW6Yl+/KFTxGeIzC/83+ZtSU3XaxlDXvtdyRZZxHlPM=;
	h=Subject:To:Cc:From:Date:From;
	b=n4FEhxSsht0W8O+Qk8ynntBpQIZMC2rlqSsJ5Zot9xjwOJnxsvaUJIhb0RX8jseDV
	 Dm6fnyEjVKZ7sOIMgmozlF839mHhClLCRDpmJ0JS0gCbzKcsnq63deDgcULJtuWiUl
	 UKIi+ypzKRGkhBYCN7Hqak0LgCk6eTDSzCRQ3HSY=
Subject: FAILED: patch "[PATCH] rethook: Use __rcu pointer for rethook::handler" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org,inwardvessel@gmail.com,lkp@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 13:52:21 +0100
Message-ID: <2023120321-emboss-bunion-bf59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a1461f1fd6cfdc4b8917c9d4a91e92605d1f28dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120321-emboss-bunion-bf59@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a1461f1fd6cf ("rethook: Use __rcu pointer for rethook::handler")
4bbd93455659 ("kprobes: kretprobe scalability improvement")
8865aea0471c ("kernel: kprobes: Use struct_size()")
195b9cb5b288 ("fprobe: Ensure running fprobe_exit_handler() finished before calling rethook_free()")
5f81018753df ("fprobe: Release rethook after the ftrace_ops is unregistered")
76d0de5729c0 ("fprobe: Pass entry_data to handlers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a1461f1fd6cfdc4b8917c9d4a91e92605d1f28dc Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 1 Dec 2023 14:53:56 +0900
Subject: [PATCH] rethook: Use __rcu pointer for rethook::handler

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

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 64672bace560..0ff44d6633e3 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -197,10 +197,8 @@ extern int arch_trampoline_kprobe(struct kprobe *p);
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
index ce69b2b7bc35..ba60962805f6 100644
--- a/include/linux/rethook.h
+++ b/include/linux/rethook.h
@@ -28,7 +28,12 @@ typedef void (*rethook_handler_t) (struct rethook_node *, void *, unsigned long,
  */
 struct rethook {
 	void			*data;
-	rethook_handler_t	handler;
+	/*
+	 * To avoid sparse warnings, this uses a raw function pointer with
+	 * __rcu, instead of rethook_handler_t. But this must be same as
+	 * rethook_handler_t.
+	 */
+	void (__rcu *handler) (struct rethook_node *, void *, unsigned long, struct pt_regs *);
 	struct objpool_head	pool;
 	struct rcu_head		rcu;
 };
diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 6fd7d4ecbbc6..fa03094e9e69 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -48,7 +48,7 @@ static void rethook_free_rcu(struct rcu_head *head)
  */
 void rethook_stop(struct rethook *rh)
 {
-	WRITE_ONCE(rh->handler, NULL);
+	rcu_assign_pointer(rh->handler, NULL);
 }
 
 /**
@@ -63,7 +63,7 @@ void rethook_stop(struct rethook *rh)
  */
 void rethook_free(struct rethook *rh)
 {
-	WRITE_ONCE(rh->handler, NULL);
+	rethook_stop(rh);
 
 	call_rcu(&rh->rcu, rethook_free_rcu);
 }
@@ -82,6 +82,12 @@ static int rethook_fini_pool(struct objpool_head *head, void *context)
 	return 0;
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
@@ -107,7 +113,7 @@ struct rethook *rethook_alloc(void *data, rethook_handler_t handler,
 		return ERR_PTR(-ENOMEM);
 
 	rh->data = data;
-	rh->handler = handler;
+	rcu_assign_pointer(rh->handler, handler);
 
 	/* initialize the objpool for rethook nodes */
 	if (objpool_init(&rh->pool, num, size, GFP_KERNEL, rh,
@@ -135,9 +141,10 @@ static void free_rethook_node_rcu(struct rcu_head *head)
  */
 void rethook_recycle(struct rethook_node *node)
 {
-	lockdep_assert_preemption_disabled();
+	rethook_handler_t handler;
 
-	if (likely(READ_ONCE(node->rethook->handler)))
+	handler = rethook_get_handler(node->rethook);
+	if (likely(handler))
 		objpool_push(node, &node->rethook->pool);
 	else
 		call_rcu(&node->rcu, free_rethook_node_rcu);
@@ -153,9 +160,7 @@ NOKPROBE_SYMBOL(rethook_recycle);
  */
 struct rethook_node *rethook_try_get(struct rethook *rh)
 {
-	rethook_handler_t handler = READ_ONCE(rh->handler);
-
-	lockdep_assert_preemption_disabled();
+	rethook_handler_t handler = rethook_get_handler(rh);
 
 	/* Check whether @rh is going to be freed. */
 	if (unlikely(!handler))
@@ -300,7 +305,7 @@ unsigned long rethook_trampoline_handler(struct pt_regs *regs,
 		rhn = container_of(first, struct rethook_node, llist);
 		if (WARN_ON_ONCE(rhn->frame != frame))
 			break;
-		handler = READ_ONCE(rhn->rethook->handler);
+		handler = rethook_get_handler(rhn->rethook);
 		if (handler)
 			handler(rhn, rhn->rethook->data,
 				correct_ret_addr, regs);


