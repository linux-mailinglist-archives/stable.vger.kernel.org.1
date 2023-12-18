Return-Path: <stable+bounces-7525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3833B8172EE
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F3E1C24F68
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A2F3D579;
	Mon, 18 Dec 2023 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XDZbZ2Uc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2BF3D566;
	Mon, 18 Dec 2023 14:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5D6C433C8;
	Mon, 18 Dec 2023 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908702;
	bh=lN2/wRv5yKhkdZL4a3cRbn0Di7Ywm3MQdINyP37rVWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XDZbZ2UcbIFocopvjd9giwWZoIK/jFH47/JrgYRlNo9dlDOxqbu+4wmZsZB/44qMi
	 IcILL0SSlWwKxHj3YO2v8G+DQSBPOtTC5xUg791IlLzBoNe5W4WbLYZfR7bvGtFzP8
	 bh10PV8kELJ8dGBZLG4ja4yLFclRbb4FR3YH003E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 17/40] cred: switch to using atomic_long_t
Date: Mon, 18 Dec 2023 14:52:12 +0100
Message-ID: <20231218135043.326595248@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135042.748715259@linuxfoundation.org>
References: <20231218135042.748715259@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit f8fa5d76925991976b3e7076f9d1052515ec1fca upstream.

There are multiple ways to grab references to credentials, and the only
protection we have against overflowing it is the memory required to do
so.

With memory sizes only moving in one direction, let's bump the reference
count to 64-bit and move it outside the realm of feasibly overflowing.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/cred.h |    8 +++---
 kernel/cred.c        |   64 +++++++++++++++++++++++++--------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -109,7 +109,7 @@ static inline int groups_search(const st
  * same context as task->real_cred.
  */
 struct cred {
-	atomic_t	usage;
+	atomic_long_t	usage;
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	atomic_t	subscribers;	/* number of processes subscribed */
 	void		*put_addr;
@@ -227,7 +227,7 @@ static inline bool cap_ambient_invariant
  */
 static inline struct cred *get_new_cred(struct cred *cred)
 {
-	atomic_inc(&cred->usage);
+	atomic_long_inc(&cred->usage);
 	return cred;
 }
 
@@ -259,7 +259,7 @@ static inline const struct cred *get_cre
 	struct cred *nonconst_cred = (struct cred *) cred;
 	if (!cred)
 		return NULL;
-	if (!atomic_inc_not_zero(&nonconst_cred->usage))
+	if (!atomic_long_inc_not_zero(&nonconst_cred->usage))
 		return NULL;
 	validate_creds(cred);
 	nonconst_cred->non_rcu = 0;
@@ -283,7 +283,7 @@ static inline void put_cred(const struct
 
 	if (cred) {
 		validate_creds(cred);
-		if (atomic_dec_and_test(&(cred)->usage))
+		if (atomic_long_dec_and_test(&(cred)->usage))
 			__put_cred(cred);
 	}
 }
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -98,17 +98,17 @@ static void put_cred_rcu(struct rcu_head
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	if (cred->magic != CRED_MAGIC_DEAD ||
-	    atomic_read(&cred->usage) != 0 ||
+	    atomic_long_read(&cred->usage) != 0 ||
 	    read_cred_subscribers(cred) != 0)
 		panic("CRED: put_cred_rcu() sees %p with"
-		      " mag %x, put %p, usage %d, subscr %d\n",
+		      " mag %x, put %p, usage %ld, subscr %d\n",
 		      cred, cred->magic, cred->put_addr,
-		      atomic_read(&cred->usage),
+		      atomic_long_read(&cred->usage),
 		      read_cred_subscribers(cred));
 #else
-	if (atomic_read(&cred->usage) != 0)
-		panic("CRED: put_cred_rcu() sees %p with usage %d\n",
-		      cred, atomic_read(&cred->usage));
+	if (atomic_long_read(&cred->usage) != 0)
+		panic("CRED: put_cred_rcu() sees %p with usage %ld\n",
+		      cred, atomic_long_read(&cred->usage));
 #endif
 
 	security_cred_free(cred);
@@ -131,11 +131,11 @@ static void put_cred_rcu(struct rcu_head
  */
 void __put_cred(struct cred *cred)
 {
-	kdebug("__put_cred(%p{%d,%d})", cred,
-	       atomic_read(&cred->usage),
+	kdebug("__put_cred(%p{%ld,%d})", cred,
+	       atomic_long_read(&cred->usage),
 	       read_cred_subscribers(cred));
 
-	BUG_ON(atomic_read(&cred->usage) != 0);
+	BUG_ON(atomic_long_read(&cred->usage) != 0);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(cred) != 0);
 	cred->magic = CRED_MAGIC_DEAD;
@@ -158,8 +158,8 @@ void exit_creds(struct task_struct *tsk)
 {
 	struct cred *cred;
 
-	kdebug("exit_creds(%u,%p,%p,{%d,%d})", tsk->pid, tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	kdebug("exit_creds(%u,%p,%p,{%ld,%d})", tsk->pid, tsk->real_cred, tsk->cred,
+	       atomic_long_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	cred = (struct cred *) tsk->real_cred;
@@ -218,7 +218,7 @@ struct cred *cred_alloc_blank(void)
 	if (!new)
 		return NULL;
 
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	new->magic = CRED_MAGIC;
 #endif
@@ -265,7 +265,7 @@ struct cred *prepare_creds(void)
 	memcpy(new, old, sizeof(struct cred));
 
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_group_info(new->group_info);
 	get_uid(new->user);
@@ -345,8 +345,8 @@ int copy_creds(struct task_struct *p, un
 		p->real_cred = get_cred(p->cred);
 		get_cred(p->cred);
 		alter_cred_subscribers(p->cred, 2);
-		kdebug("share_creds(%p{%d,%d})",
-		       p->cred, atomic_read(&p->cred->usage),
+		kdebug("share_creds(%p{%ld,%d})",
+		       p->cred, atomic_long_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
 		atomic_inc(&p->cred->user->processes);
 		return 0;
@@ -436,8 +436,8 @@ int commit_creds(struct cred *new)
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;
 
-	kdebug("commit_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("commit_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	BUG_ON(task->cred != old);
@@ -446,7 +446,7 @@ int commit_creds(struct cred *new)
 	validate_creds(old);
 	validate_creds(new);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(atomic_long_read(&new->usage) < 1);
 
 	get_cred(new); /* we will require a ref for the subj creds too */
 
@@ -519,14 +519,14 @@ EXPORT_SYMBOL(commit_creds);
  */
 void abort_creds(struct cred *new)
 {
-	kdebug("abort_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("abort_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 #ifdef CONFIG_DEBUG_CREDENTIALS
 	BUG_ON(read_cred_subscribers(new) != 0);
 #endif
-	BUG_ON(atomic_read(&new->usage) < 1);
+	BUG_ON(atomic_long_read(&new->usage) < 1);
 	put_cred(new);
 }
 EXPORT_SYMBOL(abort_creds);
@@ -542,8 +542,8 @@ const struct cred *override_creds(const
 {
 	const struct cred *old = current->cred;
 
-	kdebug("override_creds(%p{%d,%d})", new,
-	       atomic_read(&new->usage),
+	kdebug("override_creds(%p{%ld,%d})", new,
+	       atomic_long_read(&new->usage),
 	       read_cred_subscribers(new));
 
 	validate_creds(old);
@@ -565,8 +565,8 @@ const struct cred *override_creds(const
 	rcu_assign_pointer(current->cred, new);
 	alter_cred_subscribers(old, -1);
 
-	kdebug("override_creds() = %p{%d,%d}", old,
-	       atomic_read(&old->usage),
+	kdebug("override_creds() = %p{%ld,%d}", old,
+	       atomic_long_read(&old->usage),
 	       read_cred_subscribers(old));
 	return old;
 }
@@ -583,8 +583,8 @@ void revert_creds(const struct cred *old
 {
 	const struct cred *override = current->cred;
 
-	kdebug("revert_creds(%p{%d,%d})", old,
-	       atomic_read(&old->usage),
+	kdebug("revert_creds(%p{%ld,%d})", old,
+	       atomic_long_read(&old->usage),
 	       read_cred_subscribers(old));
 
 	validate_creds(old);
@@ -698,7 +698,7 @@ struct cred *prepare_kernel_cred(struct
 
 	*new = *old;
 	new->non_rcu = 0;
-	atomic_set(&new->usage, 1);
+	atomic_long_set(&new->usage, 1);
 	set_cred_subscribers(new, 0);
 	get_uid(new->user);
 	get_user_ns(new->user_ns);
@@ -808,8 +808,8 @@ static void dump_invalid_creds(const str
 	       cred == tsk->cred ? "[eff]" : "");
 	printk(KERN_ERR "CRED: ->magic=%x, put_addr=%p\n",
 	       cred->magic, cred->put_addr);
-	printk(KERN_ERR "CRED: ->usage=%d, subscr=%d\n",
-	       atomic_read(&cred->usage),
+	printk(KERN_ERR "CRED: ->usage=%ld, subscr=%d\n",
+	       atomic_long_read(&cred->usage),
 	       read_cred_subscribers(cred));
 	printk(KERN_ERR "CRED: ->*uid = { %d,%d,%d,%d }\n",
 		from_kuid_munged(&init_user_ns, cred->uid),
@@ -881,9 +881,9 @@ EXPORT_SYMBOL(__validate_process_creds);
  */
 void validate_creds_for_do_exit(struct task_struct *tsk)
 {
-	kdebug("validate_creds_for_do_exit(%p,%p{%d,%d})",
+	kdebug("validate_creds_for_do_exit(%p,%p{%ld,%d})",
 	       tsk->real_cred, tsk->cred,
-	       atomic_read(&tsk->cred->usage),
+	       atomic_long_read(&tsk->cred->usage),
 	       read_cred_subscribers(tsk->cred));
 
 	__validate_process_creds(tsk, __FILE__, __LINE__);



