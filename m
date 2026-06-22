Return-Path: <stable+bounces-267653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ObIvErsGOWptlgcAu9opvQ
	(envelope-from <stable+bounces-267653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:56:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F29DD6AE775
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:56:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KvMImQN0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267653-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267653-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F0D4300ADAD
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2B39B49C;
	Mon, 22 Jun 2026 09:55:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCAF366DD3
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122155; cv=none; b=iz1xGNPPQLW+K9TpNdj4z5if1TxvLSH5dO/gKKAKDiURZUPVdFHrIUePN+W1LgriA9Sn3KJDMhcOpMxDdfF9yPyNDjDpb5bCoKE9xKYZ33WRMSRAppp7bYQzW8bm3VBBbu4NFZzCqzLweefYdvnBh7EncjsOpLbK6azEdSDK3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122155; c=relaxed/simple;
	bh=tdw9BKnhlfs1hOuS0064f0FIQwurMVqgdKJvTg8GRT0=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=S4tUtqGu084bfTWsT3ijDc3cH6HziX7IvbVlQ74kdzPW5tSMU0Yp9//lRN0xusw9kbdt39VTchyyqADQuBCauXSgMlep9hQ5EelEHmOxgbVfUurdOA3gBKlbDXESTiYNogJH9ob3qdF3OpjqprTLI2z/EiHkpJHuK/knpP17bbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvMImQN0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6C81F00A3A;
	Mon, 22 Jun 2026 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122151;
	bh=oUarCL74jjopAtia6/YDTb4QJ1hK+Ig+Cki1T5HCopg=;
	h=Date:From:To:Cc:Subject:References;
	b=KvMImQN0jmYiw36DrYI5z1aZvoWQyfVqvt8YXUOoMP3fLOBY9pewhlcAWiBNAlfg3
	 4fr67Ybm+f4H28TH/n2MQuRqhBkV8S1LYznwSuE+11HJZJtguHHwdFsFta9HvRSdGq
	 r1aP+qd7jGlH1Clw7h7w7hcWEekbPs4uG6WHJvU3+ArSJWTnyLHY4T8Di6ZUlubX9C
	 iQHPxNcn/eWyuNDggMbWgJGoniunDdgkFuIN8dHLcUeUcr34IJhD1xUDsO4XGUJynA
	 Bq/md/shasD2FHzCtCnksN97W0wP4G+2SyriHg1N8PkDYAmEAKTfBmUVspD3qDsi8W
	 voSiQ16QcQQwg==
Date: Mon, 22 Jun 2026 11:55:49 +0200
Message-ID: <20260622094802.103952799@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v6.1.y 1/5] debugobjects,locking: Annotate
 debug_object_fill_pool() wait type violation
References: <20260622094345.511524619@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:longman@redhat.com,m:bigeasy@linutronix.de,m:vbabka@suse.cz,m:zhengqi.arch@bytedance.com,m:peterz@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267653-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.cz:email,bytedance.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F29DD6AE775

From: Peter Zijlstra <peterz@infradead.org>

commit 0cce06ba859a515bd06224085d3addb870608b6d upstream.

There is an explicit wait-type violation in debug_object_fill_pool()
for PREEMPT_RT=n kernels which allows them to more easily fill the
object pool and reduce the chance of allocation failures.

Lockdep's wait-type checks are designed to check the PREEMPT_RT
locking rules even for PREEMPT_RT=n kernels and object to this, so
create a lockdep annotation to allow this to stand.

Specifically, create a 'lock' type that overrides the inner wait-type
while it is held -- allowing one to temporarily raise it, such that
the violation is hidden.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Qi Zheng <zhengqi.arch@bytedance.com>
Link: https://lkml.kernel.org/r/20230429100614.GA1489784@hirez.programming.kicks-ass.net
Signed-off-by: Thomas Gleixner <tglx@kernel.org>

---
 include/linux/lockdep.h       |   14 ++++++++++++++
 include/linux/lockdep_types.h |    1 +
 kernel/locking/lockdep.c      |   28 +++++++++++++++++++++-------
 lib/debugobjects.c            |   15 +++++++++++++--
 4 files changed, 49 insertions(+), 9 deletions(-)

--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -339,6 +339,16 @@ extern void lock_unpin_lock(struct lockd
 #define lockdep_repin_lock(l,c)	lock_repin_lock(&(l)->dep_map, (c))
 #define lockdep_unpin_lock(l,c)	lock_unpin_lock(&(l)->dep_map, (c))
 
+/*
+ * Must use lock_map_aquire_try() with override maps to avoid
+ * lockdep thinking they participate in the block chain.
+ */
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map _name = {			\
+		.name = #_name "-wait-type-override",	\
+		.wait_type_inner = _wait_type,		\
+		.lock_type = LD_LOCK_WAIT_OVERRIDE, }
+
 #else /* !CONFIG_LOCKDEP */
 
 static inline void lockdep_init_task(struct task_struct *task)
@@ -427,6 +437,9 @@ extern int lockdep_is_held(const void *)
 #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 
+#define DEFINE_WAIT_OVERRIDE_MAP(_name, _wait_type)	\
+	struct lockdep_map __maybe_unused _name = {}
+
 #endif /* !LOCKDEP */
 
 enum xhlock_context_t {
@@ -552,6 +565,7 @@ do {									\
 #define rwsem_release(l, i)			lock_release(l, i)
 
 #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
+#define lock_map_acquire_try(l)			lock_acquire_exclusive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_tryread(l)		lock_acquire_shared_recursive(l, 0, 1, NULL, _THIS_IP_)
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -33,6 +33,7 @@ enum lockdep_wait_type {
 enum lockdep_lock_type {
 	LD_LOCK_NORMAL = 0,	/* normal, catch all */
 	LD_LOCK_PERCPU,		/* percpu */
+	LD_LOCK_WAIT_OVERRIDE,	/* annotation */
 	LD_LOCK_MAX,
 };
 
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2245,6 +2245,9 @@ static inline bool usage_match(struct lo
 
 static inline bool usage_skip(struct lock_list *entry, void *mask)
 {
+	if (entry->class->lock_type == LD_LOCK_NORMAL)
+		return false;
+
 	/*
 	 * Skip local_lock() for irq inversion detection.
 	 *
@@ -2271,14 +2274,16 @@ static inline bool usage_skip(struct loc
 	 * As a result, we will skip local_lock(), when we search for irq
 	 * inversion bugs.
 	 */
-	if (entry->class->lock_type == LD_LOCK_PERCPU) {
-		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
-			return false;
+	if (entry->class->lock_type == LD_LOCK_PERCPU &&
+	    DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
+		return false;
 
-		return true;
-	}
+	/*
+	 * Skip WAIT_OVERRIDE for irq inversion detection -- it's not actually
+	 * a lock and only used to override the wait_type.
+	 */
 
-	return false;
+	return true;
 }
 
 /*
@@ -4745,7 +4750,8 @@ static int check_wait_context(struct tas
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
-		u8 prev_inner = hlock_class(prev)->wait_type_inner;
+		struct lock_class *class = hlock_class(prev);
+		u8 prev_inner = class->wait_type_inner;
 
 		if (prev_inner) {
 			/*
@@ -4755,6 +4761,14 @@ static int check_wait_context(struct tas
 			 * Also due to trylocks.
 			 */
 			curr_inner = min(curr_inner, prev_inner);
+
+			/*
+			 * Allow override for annotations -- this is typically
+			 * only valid/needed for code that only exists when
+			 * CONFIG_PREEMPT_RT=n.
+			 */
+			if (unlikely(class->lock_type == LD_LOCK_WAIT_OVERRIDE))
+				curr_inner = prev_inner;
 		}
 	}
 
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -601,10 +601,21 @@ static void debug_objects_fill_pool(void
 {
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
+	 * context -- for !RT kernels we rely on the fact that spinlock_t and
+	 * raw_spinlock_t are basically the same type and this lock-type
+	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		/*
+		 * Annotate away the spinlock_t inside raw_spinlock_t warning
+		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
+		 * the preemptible() condition above.
+		 */
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
+		lock_map_release(&fill_pool_map);
+	}
 }
 
 static void


