Return-Path: <stable+bounces-245584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD2bCqksA2pe1QEAu9opvQ
	(envelope-from <stable+bounces-245584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:35:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C50E25214DA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0B59310F44F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425F439A4BD;
	Tue, 12 May 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ovyjnp+g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0053B2749D6
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592052; cv=none; b=RahUUxQuwyIQVIbX3aoJ0LDNCeqGtvm9sYdDNHJwy/k1IrhfltREXtyh+FDr2uZHSpjrG5u9SkS+2axv+2pE3X7t35AbI6aFGxOu3hPKX40gkRUczZIu7Aq2x7AV5Obt86El2VhWeBlbnDtyE1B2AE+w7tIxGDH3LyK57eR4t8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592052; c=relaxed/simple;
	bh=CZB5cWozIYmfoKgefLdty3Zxu5rI8sr1Nwuss1B1sBg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jbwLp914IT9tsZVsHb4u5rWBKcDIfeKyjjXksgMs+HS22DRnSxjwQKhcPZf/o2Gh8YDBTEroHXN7LP6Ckr8Q+/j0iYMFMF6yE3FAGT3G9ES7/2ZKiEE8cSiTm+Gj+tshayhkkGmm5ikvpKOVPpuBvLA25ywG2f0zkdejm680Bok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ovyjnp+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5496AC2BCB0;
	Tue, 12 May 2026 13:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778592051;
	bh=CZB5cWozIYmfoKgefLdty3Zxu5rI8sr1Nwuss1B1sBg=;
	h=Subject:To:Cc:From:Date:From;
	b=ovyjnp+gkHT5+Qn5DZF0f+WM0xh/l9RIsk0WML+wdN0ZnxsvWKYq2VqMg7nLFlQGg
	 39ztcDy6DcIdFMfN2BzLaZjm1f2BELHqVQnpyN4GGmaLAxAvrMBXPlrc1UgiN0ojnc
	 5sRMbcBmvahi44aH+zmMShqWmw5+k2jYPWjz78iY=
Subject: FAILED: patch "[PATCH] rseq: Revert to historical performance killing behaviour" failed to apply to 7.0-stable tree
To: tglx@kernel.org,dvyukov@google.com,mathias@mongodb.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:20:56 +0200
Message-ID: <2026051256-posture-repost-4c65@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C50E25214DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245584-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,infradead.org:email]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x b9eac6a9d93c952c4b7775a24d5c7a1bbf4c3c00
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051256-posture-repost-4c65@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b9eac6a9d93c952c4b7775a24d5c7a1bbf4c3c00 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@kernel.org>
Date: Sat, 25 Apr 2026 00:47:54 +0200
Subject: [PATCH] rseq: Revert to historical performance killing behaviour

The recent RSEQ optimization work broke the TCMalloc abuse of the RSEQ ABI
as it not longer unconditionally updates the CPU, node, mm_cid fields,
which are documented as read only for user space. Due to the observed
behavior of the kernel it was possible for TCMalloc to overwrite the
cpu_id_start field for their own purposes and rely on the kernel to update
it unconditionally after each context switch and before signal delivery.

The RSEQ ABI only guarantees that these fields are updated when the data
changes, i.e. the task is migrated or the MMCID of the task changes due to
switching from or to per CPU ownership mode.

The optimization work eliminated the unconditional updates and reduced them
to the documented ABI guarantees, which results in a massive performance
win for syscall, scheduling heavy work loads, which in turn breaks the
TCMalloc expectations.

There have been several options discussed to restore the TCMalloc
functionality while preserving the optimization benefits. They all end up
in a series of hard to maintain workarounds, which in the worst case
introduce overhead for everyone, e.g. in the scheduler.

The requirements of TCMalloc and the optimization work are diametral and
the required work arounds are a maintainence burden. They end up as fragile
constructs, which are blocking further optimization work and are pretty
much guaranteed to cause more subtle issues down the road.

The optimization work heavily depends on the generic entry code, which is
not used by all architectures yet. So the rework preserved the original
mechanism moslty unmodified to keep the support for architectures, which
handle rseq in their own exit to user space loop. That code is currently
optimized out by the compiler on architectures which use the generic entry
code.

This allows to revert back to the original behaviour by replacing the
compile time constant conditions with a runtime condition where required,
which disables the optimization and the dependend time slice extension
feature until the run-time condition can be enabled in the RSEQ
registration code on a per task basis again.

The following changes are required to restore the original behavior, which
makes TCMalloc work again:

  1) Replace the compile time constant conditionals with runtime
     conditionals where appropriate to prevent the compiler from optimizing
     the legacy mode out

  2) Enforce unconditional update of IDs on context switch for the
     non-optimized v1 mode

  3) Enforce update of IDs in the pre signal delivery path for the
     non-optimized v1 mode

  4) Enforce update of IDs in the membarrier(RSEQ) IPI for the
     non-optimized v1 mode

  5) Make time slice and future extensions depend on optimized v2 mode

This brings back the full performance problems, but preserves the v2
optimization code and for generic entry code using architectures also the
TIF_RSEQ optimization which avoids a full evaluation of the exit to user
mode loop in many cases.

Fixes: 566d8015f7ee ("rseq: Avoid CPU/MM CID updates when no event pending")
Reported-by: Mathias Stearn <mathias@mongodb.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Closes: https://lore.kernel.org/CAHnCjA25b+nO2n5CeifknSKHssJpPrjnf+dtr7UgzRw4Zgu=oA@mail.gmail.com
Link: https://patch.msgid.link/20260428224427.517051752%40kernel.org
Cc: stable@vger.kernel.org

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index f446909551df..7ef79b25e714 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -9,6 +9,11 @@
 
 void __rseq_handle_slowpath(struct pt_regs *regs);
 
+static __always_inline bool rseq_v2(struct task_struct *t)
+{
+	return IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY) && likely(t->rseq.event.has_rseq > 1);
+}
+
 /* Invoked from resume_user_mode_work() */
 static inline void rseq_handle_slowpath(struct pt_regs *regs)
 {
@@ -16,8 +21,7 @@ static inline void rseq_handle_slowpath(struct pt_regs *regs)
 		if (current->rseq.event.slowpath)
 			__rseq_handle_slowpath(regs);
 	} else {
-		/* '&' is intentional to spare one conditional branch */
-		if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
+		if (current->rseq.event.sched_switch && current->rseq.event.has_rseq)
 			__rseq_handle_slowpath(regs);
 	}
 }
@@ -30,9 +34,9 @@ void __rseq_signal_deliver(int sig, struct pt_regs *regs);
  */
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
 {
-	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
-		/* '&' is intentional to spare one conditional branch */
-		if (current->rseq.event.has_rseq & current->rseq.event.user_irq)
+	if (rseq_v2(current)) {
+		/* has_rseq is implied in rseq_v2() */
+		if (current->rseq.event.user_irq)
 			__rseq_signal_deliver(ksig->sig, regs);
 	} else {
 		if (current->rseq.event.has_rseq)
@@ -50,15 +54,22 @@ static __always_inline void rseq_sched_switch_event(struct task_struct *t)
 {
 	struct rseq_event *ev = &t->rseq.event;
 
-	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+	/*
+	 * Only apply the user_irq optimization for RSEQ ABI V2 registrations.
+	 * Legacy users like TCMalloc rely on the original ABI V1 behaviour
+	 * which updates IDs on every context swtich.
+	 */
+	if (rseq_v2(t)) {
 		/*
-		 * Avoid a boat load of conditionals by using simple logic
-		 * to determine whether NOTIFY_RESUME needs to be raised.
+		 * Avoid a boat load of conditionals by using simple logic to
+		 * determine whether TIF_NOTIFY_RESUME or TIF_RSEQ needs to be
+		 * raised.
 		 *
-		 * It's required when the CPU or MM CID has changed or
-		 * the entry was from user space.
+		 * It's required when the CPU or MM CID has changed or the entry
+		 * was via interrupt from user space. ev->has_rseq does not have
+		 * to be evaluated here because rseq_v2() implies has_rseq.
 		 */
-		bool raise = (ev->user_irq | ev->ids_changed) & ev->has_rseq;
+		bool raise = ev->user_irq | ev->ids_changed;
 
 		if (raise) {
 			ev->sched_switch = true;
@@ -66,6 +77,7 @@ static __always_inline void rseq_sched_switch_event(struct task_struct *t)
 		}
 	} else {
 		if (ev->has_rseq) {
+			t->rseq.event.ids_changed = true;
 			t->rseq.event.sched_switch = true;
 			rseq_raise_notify_resume(t);
 		}
@@ -161,6 +173,7 @@ static inline unsigned int rseq_alloc_align(void)
 }
 
 #else /* CONFIG_RSEQ */
+static inline bool rseq_v2(struct task_struct *t) { return false; }
 static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index f11ebd34f8b9..934db41ec782 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -111,6 +111,20 @@ static __always_inline void rseq_slice_clear_grant(struct task_struct *t)
 	t->rseq.slice.state.granted = false;
 }
 
+/*
+ * Open coded, so it can be invoked within a user access region.
+ *
+ * This clears the user space state of the time slice extensions field only when
+ * the task has registered the optimized RSEQ_ABI V2. Some legacy registrations,
+ * e.g. TCMalloc, have conflicting non-ABI fields in struct RSEQ, which would be
+ * overwritten by an unconditional write.
+ */
+#define rseq_slice_clear_user(rseq, efault)				\
+do {									\
+	if (rseq_slice_extension_enabled())				\
+		unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);	\
+} while (0)
+
 static __always_inline bool __rseq_grant_slice_extension(bool work_pending)
 {
 	struct task_struct *curr = current;
@@ -230,6 +244,7 @@ static __always_inline bool rseq_slice_extension_enabled(void) { return false; }
 static __always_inline bool rseq_arm_slice_extension_timer(void) { return false; }
 static __always_inline void rseq_slice_clear_grant(struct task_struct *t) { }
 static __always_inline bool rseq_grant_slice_extension(unsigned long ti_work, unsigned long mask) { return false; }
+#define rseq_slice_clear_user(rseq, efault) do { } while (0)
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
 
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
@@ -517,11 +532,9 @@ bool rseq_set_ids_get_csaddr(struct task_struct *t, struct rseq_ids *ids,
 		if (csaddr)
 			unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
 
-		/* Open coded, so it's in the same user access region */
-		if (rseq_slice_extension_enabled()) {
-			/* Unconditionally clear it, no point in conditionals */
-			unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
-		}
+		/* RSEQ ABI V2 only operations */
+		if (rseq_v2(t))
+			rseq_slice_clear_user(rseq, efault);
 	}
 
 	rseq_slice_clear_grant(t);
@@ -612,6 +625,14 @@ static __always_inline bool rseq_exit_user_update(struct pt_regs *regs, struct t
 	 * interrupts disabled
 	 */
 	guard(pagefault)();
+	/*
+	 * This optimization is only valid when the task registered for the
+	 * optimized RSEQ_ABI_V2 variant. Some legacy users rely on the original
+	 * RSEQ implementation behaviour which unconditionally updated the IDs.
+	 * rseq_sched_switch_event() ensures that legacy registrations always
+	 * have both sched_switch and ids_changed set, which is compatible with
+	 * the historical TIF_NOTIFY_RESUME behaviour.
+	 */
 	if (likely(!t->rseq.event.ids_changed)) {
 		struct rseq __user *rseq = t->rseq.usrptr;
 		/*
@@ -623,11 +644,9 @@ static __always_inline bool rseq_exit_user_update(struct pt_regs *regs, struct t
 		scoped_user_rw_access(rseq, efault) {
 			unsafe_get_user(csaddr, &rseq->rseq_cs, efault);
 
-			/* Open coded, so it's in the same user access region */
-			if (rseq_slice_extension_enabled()) {
-				/* Unconditionally clear it, no point in conditionals */
-				unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
-			}
+			/* RSEQ ABI V2 only operations */
+			if (rseq_v2(t))
+				rseq_slice_clear_user(rseq, efault);
 		}
 
 		rseq_slice_clear_grant(t);
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 0b42045988db..a469c1870849 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -9,6 +9,12 @@
 #ifdef CONFIG_RSEQ
 struct rseq;
 
+/*
+ * rseq_event::has_rseq contains the ABI version number so preserving it
+ * in AND operations requires a mask.
+ */
+#define RSEQ_HAS_RSEQ_VERSION_MASK	0xff
+
 /**
  * struct rseq_event - Storage for rseq related event management
  * @all:		Compound to initialize and clear the data efficiently
@@ -17,7 +23,8 @@ struct rseq;
  *			exit to user
  * @ids_changed:	Indicator that IDs need to be updated
  * @user_irq:		True on interrupt entry from user mode
- * @has_rseq:		True if the task has a rseq pointer installed
+ * @has_rseq:		Greater than 0 if the task has a rseq pointer installed.
+ *			Contains the RSEQ version number
  * @error:		Compound error code for the slow path to analyze
  * @fatal:		User space data corrupted or invalid
  * @slowpath:		Indicator that slow path processing via TIF_NOTIFY_RESUME
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 586f58f652c6..aa25753ea135 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -253,11 +253,14 @@ static bool rseq_handle_cs(struct task_struct *t, struct pt_regs *regs)
 static void rseq_slowpath_update_usr(struct pt_regs *regs)
 {
 	/*
-	 * Preserve rseq state and user_irq state. The generic entry code
-	 * clears user_irq on the way out, the non-generic entry
-	 * architectures are not having user_irq.
+	 * Preserve has_rseq and user_irq state. The generic entry code clears
+	 * user_irq on the way out, the non-generic entry architectures are not
+	 * setting user_irq.
 	 */
-	const struct rseq_event evt_mask = { .has_rseq = true, .user_irq = true, };
+	const struct rseq_event evt_mask = {
+		.has_rseq	= RSEQ_HAS_RSEQ_VERSION_MASK,
+		.user_irq	= true,
+	};
 	struct task_struct *t = current;
 	struct rseq_ids ids;
 	u32 node_id;
@@ -330,8 +333,9 @@ void __rseq_handle_slowpath(struct pt_regs *regs)
 void __rseq_signal_deliver(int sig, struct pt_regs *regs)
 {
 	rseq_stat_inc(rseq_stats.signal);
+
 	/*
-	 * Don't update IDs, they are handled on exit to user if
+	 * Don't update IDs yet, they are handled on exit to user if
 	 * necessary. The important thing is to abort a critical section of
 	 * the interrupted context as after this point the instruction
 	 * pointer in @regs points to the signal handler.
@@ -344,6 +348,13 @@ void __rseq_signal_deliver(int sig, struct pt_regs *regs)
 		current->rseq.event.error = 0;
 		force_sigsegv(sig);
 	}
+
+	/*
+	 * In legacy mode, force the update of IDs before returning to user
+	 * space to stay compatible.
+	 */
+	if (!rseq_v2(current))
+		rseq_force_update();
 }
 
 /*
@@ -408,6 +419,7 @@ static bool rseq_reset_ids(void)
 SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
 {
 	u32 rseqfl = 0;
+	u8 version = 1;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -461,7 +473,11 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
 
-	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
+	/*
+	 * The version check effectivly disables time slice extensions until the
+	 * RSEQ ABI V2 registration are implemented.
+	 */
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION) && version > 1) {
 		if (rseq_slice_extension_enabled()) {
 			rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
 			if (flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)
@@ -484,7 +500,15 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32
 		unsafe_put_user(RSEQ_CPU_ID_UNINITIALIZED, &rseq->cpu_id, efault);
 		unsafe_put_user(0U, &rseq->node_id, efault);
 		unsafe_put_user(0U, &rseq->mm_cid, efault);
-		unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+
+		/*
+		 * All fields past mm_cid are only valid for non-legacy v2
+		 * registrations.
+		 */
+		if (version > 1) {
+			if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
+				unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+		}
 	}
 
 	/*
@@ -712,6 +736,8 @@ int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
 			return -ENOTSUPP;
 		if (!current->rseq.usrptr)
 			return -ENXIO;
+		if (!rseq_v2(current))
+			return -ENOTSUPP;
 
 		/* No change? */
 		if (enable == !!current->rseq.slice.state.enabled)
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 623445603725..226a6329f3e9 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -199,7 +199,16 @@ static void ipi_rseq(void *info)
 	 * is negligible.
 	 */
 	smp_mb();
-	rseq_sched_switch_event(current);
+	/*
+	 * Legacy mode requires that IDs are written and the critical section is
+	 * evaluated. V2 optimized mode handles the critical section and IDs are
+	 * only updated if they change as a consequence of preemption after
+	 * return from this IPI.
+	 */
+	if (rseq_v2(current))
+		rseq_sched_switch_event(current);
+	else
+		rseq_force_update();
 }
 
 static void ipi_sync_rq_state(void *info)


