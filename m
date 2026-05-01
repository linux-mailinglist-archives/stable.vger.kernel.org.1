Return-Path: <stable+bounces-242510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCtOHIMC9WnAHAIAu9opvQ
	(envelope-from <stable+bounces-242510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:44:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1774AF4AF
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C9F330474CB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBBE423A63;
	Fri,  1 May 2026 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HRJ4wfnn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QrhrnyNB"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9B421EE8;
	Fri,  1 May 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664422; cv=none; b=Xgsgg8FU2bQsDSURN07mxY8Yaj7fFZthkLl9oYGORFGJA2Vsf5+ojevispjM4/zN2EwDJ9T+CMS0Zlfv2aeMZwvpzvXf7rqL0fbHZblrDt/ksCpIZUrHLASi7awMns4Hlws1NUlQEV4jbWBCmtQoTpUejlqVLgRT34F5ACFmBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664422; c=relaxed/simple;
	bh=XtGZamR9uh+SHveEBL/nRc/nWI1I/tb6zWpDGPyoleM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QOr4+CYgts7efp1Au6JOY+h1oq/OssoG4hzK1URsUjURQDpIRGB8tcZRpvHF2Gt541+RfDtnb3M/j6EefOFYBpNere85xmJK4KH+P8UBGjWbP/iSwYeXO7u2a2YEbbRvE1uWLEQu/q9OSgqlFs3EoJhehFzGVXL0YkgZGOk00+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRJ4wfnn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QrhrnyNB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 May 2026 19:40:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777664416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=e2Sh1IIyhEybOvSbiznUq4a0l7xjIS3wmHKgYYvvBYc=;
	b=HRJ4wfnnsfFmT4kbM/iSXKqneAmZppifr4d6ixmXGQPqs+jUko3rw44GZ+xE+0JcT3aKfn
	tnEbeX6nQYpuTKte585sle7/wz8TH5QIJWt2QVYWMAZLJt4qgngQsJC9ZHP1/fgAy3IBNA
	3vZb3Vzl+fUeThaj2UugI2y8Xd8FBTkZ+gwSD28S7nXljVwhm05jomQYbLdI1Wbbn87KZo
	r88sQi8b7W44LZgT1Ej01ZgDuR7n6IQV3nBqaGvrFUImD6yUbeyK6nwfIUqFuud4x6/l0Z
	tJGH+nX/4h9z75w5Gfb2Gu4plkBUGqF9ak/cuQqh5hoMNZtXitMfRfJ6iKoLMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777664416;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=e2Sh1IIyhEybOvSbiznUq4a0l7xjIS3wmHKgYYvvBYc=;
	b=QrhrnyNB1vd3BuNEq8PNNwcLP1LAn8FyY+oGrKvCe79v/3faBNUCHn8LgB9TXxnJWiE7bl
	d2iSIXOmNrVekQDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] rseq: Revert to historical performance killing behaviour
Cc: Mathias Stearn <mathias@mongodb.com>, Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177766441489.3521451.12104866450441690349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CD1774AF4AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242510-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,msgid.link:url,infradead.org:email,mongodb.com:email,vger.kernel.org:replyto]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a510a7f3e9f3956dcb712b7806c11463f70de771
Gitweb:        https://git.kernel.org/tip/a510a7f3e9f3956dcb712b7806c11463f70=
de771
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sat, 25 Apr 2026 00:47:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 May 2026 21:32:21 +02:00

rseq: Revert to historical performance killing behaviour

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
Closes: https://lore.kernel.org/CAHnCjA25b+nO2n5CeifknSKHssJpPrjnf+dtr7UgzRw4=
Zgu=3DoA@mail.gmail.com
Link: https://patch.msgid.link/20260428224427.517051752%40kernel.org
Cc: stable@vger.kernel.org
---
 include/linux/rseq.h       | 34 ++++++++++++++++++++-----------
 include/linux/rseq_entry.h | 39 ++++++++++++++++++++++++++----------
 include/linux/rseq_types.h |  9 +++++++-
 kernel/rseq.c              | 40 ++++++++++++++++++++++++++++++-------
 kernel/sched/membarrier.c  | 11 +++++++++-
 5 files changed, 103 insertions(+), 30 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index f446909..46eb32f 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -9,6 +9,11 @@
=20
 void __rseq_handle_slowpath(struct pt_regs *regs);
=20
+static __always_inline bool rseq_v2(struct task_struct *t)
+{
+	return IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY) && likely(t->rseq.event.has_rse=
q > 1);
+}
+
 /* Invoked from resume_user_mode_work() */
 static inline void rseq_handle_slowpath(struct pt_regs *regs)
 {
@@ -16,8 +21,7 @@ static inline void rseq_handle_slowpath(struct pt_regs *reg=
s)
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
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs)
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
@@ -50,15 +54,22 @@ static __always_inline void rseq_sched_switch_event(struc=
t task_struct *t)
 {
 	struct rseq_event *ev =3D &t->rseq.event;
=20
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
-		bool raise =3D (ev->user_irq | ev->ids_changed) & ev->has_rseq;
+		bool raise =3D ev->user_irq | ev->ids_changed;
=20
 		if (raise) {
 			ev->sched_switch =3D true;
@@ -66,6 +77,7 @@ static __always_inline void rseq_sched_switch_event(struct =
task_struct *t)
 		}
 	} else {
 		if (ev->has_rseq) {
+			t->rseq.event.ids_changed =3D true;
 			t->rseq.event.sched_switch =3D true;
 			rseq_raise_notify_resume(t);
 		}
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index f11ebd3..934db41 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -111,6 +111,20 @@ static __always_inline void rseq_slice_clear_grant(struc=
t task_struct *t)
 	t->rseq.slice.state.granted =3D false;
 }
=20
+/*
+ * Open coded, so it can be invoked within a user access region.
+ *
+ * This clears the user space state of the time slice extensions field only =
when
+ * the task has registered the optimized RSEQ_ABI V2. Some legacy registrati=
ons,
+ * e.g. TCMalloc, have conflicting non-ABI fields in struct RSEQ, which woul=
d be
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
 	struct task_struct *curr =3D current;
@@ -230,6 +244,7 @@ static __always_inline bool rseq_slice_extension_enabled(=
void) { return false; }
 static __always_inline bool rseq_arm_slice_extension_timer(void) { return fa=
lse; }
 static __always_inline void rseq_slice_clear_grant(struct task_struct *t) { }
 static __always_inline bool rseq_grant_slice_extension(unsigned long ti_work=
, unsigned long mask) { return false; }
+#define rseq_slice_clear_user(rseq, efault) do { } while (0)
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
=20
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, =
unsigned long csaddr);
@@ -517,11 +532,9 @@ bool rseq_set_ids_get_csaddr(struct task_struct *t, stru=
ct rseq_ids *ids,
 		if (csaddr)
 			unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
=20
-		/* Open coded, so it's in the same user access region */
-		if (rseq_slice_extension_enabled()) {
-			/* Unconditionally clear it, no point in conditionals */
-			unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
-		}
+		/* RSEQ ABI V2 only operations */
+		if (rseq_v2(t))
+			rseq_slice_clear_user(rseq, efault);
 	}
=20
 	rseq_slice_clear_grant(t);
@@ -612,6 +625,14 @@ static __always_inline bool rseq_exit_user_update(struct=
 pt_regs *regs, struct t
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
 		struct rseq __user *rseq =3D t->rseq.usrptr;
 		/*
@@ -623,11 +644,9 @@ static __always_inline bool rseq_exit_user_update(struct=
 pt_regs *regs, struct t
 		scoped_user_rw_access(rseq, efault) {
 			unsafe_get_user(csaddr, &rseq->rseq_cs, efault);
=20
-			/* Open coded, so it's in the same user access region */
-			if (rseq_slice_extension_enabled()) {
-				/* Unconditionally clear it, no point in conditionals */
-				unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
-			}
+			/* RSEQ ABI V2 only operations */
+			if (rseq_v2(t))
+				rseq_slice_clear_user(rseq, efault);
 		}
=20
 		rseq_slice_clear_grant(t);
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 0b42045..a469c18 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -9,6 +9,12 @@
 #ifdef CONFIG_RSEQ
 struct rseq;
=20
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
index 586f58f..aa25753 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -253,11 +253,14 @@ efault:
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
-	const struct rseq_event evt_mask =3D { .has_rseq =3D true, .user_irq =3D tr=
ue, };
+	const struct rseq_event evt_mask =3D {
+		.has_rseq	=3D RSEQ_HAS_RSEQ_VERSION_MASK,
+		.user_irq	=3D true,
+	};
 	struct task_struct *t =3D current;
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
 		current->rseq.event.error =3D 0;
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
=20
 /*
@@ -408,6 +419,7 @@ efault:
 SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags,=
 u32, sig)
 {
 	u32 rseqfl =3D 0;
+	u8 version =3D 1;
=20
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -461,7 +473,11 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, r=
seq_len, int, flags, u32
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
=20
-	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
+	/*
+	 * The version check effectivly disables time slice extensions until the
+	 * RSEQ ABI V2 registration are implemented.
+	 */
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION) && version > 1) {
 		if (rseq_slice_extension_enabled()) {
 			rseqfl |=3D RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
 			if (flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)
@@ -484,7 +500,15 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, r=
seq_len, int, flags, u32
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
=20
 	/*
@@ -712,6 +736,8 @@ int rseq_slice_extension_prctl(unsigned long arg2, unsign=
ed long arg3)
 			return -ENOTSUPP;
 		if (!current->rseq.usrptr)
 			return -ENXIO;
+		if (!rseq_v2(current))
+			return -ENOTSUPP;
=20
 		/* No change? */
 		if (enable =3D=3D !!current->rseq.slice.state.enabled)
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 6234456..226a632 100644
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
=20
 static void ipi_sync_rq_state(void *info)

