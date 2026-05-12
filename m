Return-Path: <stable+bounces-245583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKaJDs8uA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:44:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655152185D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B372D30EC2F4
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB0F39A4C4;
	Tue, 12 May 2026 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLtjYXHB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA0439A4BA
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592047; cv=none; b=QAaBlTyOC1P70ehctbr3gV5rDoXAXrxpOCiwHQS5ZqnMUyIqvLeFlu2d/wmi5BP+2B8RPX7HKT1ANVtSZiU6pkHGj/Hjx1QNveZ6JuHvzIIC/19snm5nXzIwAaXjXuvgLVisl0KDqW/AFzK3L3oEgjfKQdhDJCn8kDKXNzHiqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592047; c=relaxed/simple;
	bh=ZRxCVULbD5KBN/Ze8CYtTMT4HTLTy/KBVHej6aUFj2A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kair5LW1sooUj3pS5HUDqbxWyLEFw7mGQ4xFakWwJzsOsHVCoFYkoKO6Q6JnPtht68xiwM0D0u2GbZpADMTE3GiX2I+NXbhEKNTCpr5OCrqpqNb0NFbDSq0GFY168MhaJzA3/d8HTsN7uDwtItkHFdlQnGb1sVOiiObEZ5v12vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLtjYXHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6525C2BCB0;
	Tue, 12 May 2026 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778592047;
	bh=ZRxCVULbD5KBN/Ze8CYtTMT4HTLTy/KBVHej6aUFj2A=;
	h=Subject:To:Cc:From:Date:From;
	b=cLtjYXHB1YQo4MeVxswaPmp9lEM9kRF61rRbO0baOOywdi6XNP4sKcVhN4LGajX/+
	 KKoJ1XQb1fGWwmpqFHwCFR02U3ODq3DsaTKFcUGA/mDrT22QkbHFqLfpPvZJYJDL99
	 e15Bl+CpeEkk34L0UnB9tygEQGMy+nCeytA7V710=
Subject: FAILED: patch "[PATCH] rseq: Reenable performance optimizations conditionally" failed to apply to 7.0-stable tree
To: tglx@kernel.org,dvyukov@google.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:20:52 +0200
Message-ID: <2026051252-broiler-boxy-1628@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2655152185D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245583-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,infradead.org:email,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 99428157dcf32fdac97355aa1cc1364dbc9e073c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051252-broiler-boxy-1628@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99428157dcf32fdac97355aa1cc1364dbc9e073c Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@kernel.org>
Date: Sun, 26 Apr 2026 10:01:56 +0200
Subject: [PATCH] rseq: Reenable performance optimizations conditionally

Due to the incompatibility with TCMalloc the RSEQ optimizations and
extended features (time slice extensions) have been disabled and made
run-time conditional.

The original RSEQ implementation, which TCMalloc depends on, registers a 32
byte region (ORIG_RSEG_SIZE). This region has a 32 byte alignment
requirement.

The extension safe newer variant exposes the kernel RSEQ feature size via
getauxval(AT_RSEQ_FEATURE_SIZE) and the alignment requirement via
getauxval(AT_RSEQ_ALIGN). The alignment requirement is that the registered
RSEQ region is aligned to the next power of two of the feature size. The
kernel currently has a feature size of 33 bytes, which means the alignment
requirement is 64 bytes.

The TCMalloc RSEQ region is embedded into a cache line aligned data
structure starting at offset 32 bytes so that bytes 28-31 and the
cpu_id_start field at bytes 32-35 form a 64-bit little endian pointer with
the top-most bit (63 set) to check whether the kernel has overwritten
cpu_id_start with an actual CPU id value, which is guaranteed to not have
the top most bit set.

As this is part of their performance tuned magic, it's a pretty safe
assumption, that TCMalloc won't use a larger RSEQ size.

This allows the kernel to declare that registrations with a size greater
than the original size of 32 bytes, which is the cases since time slice
extensions got introduced, as RSEQ ABI v2 with the following differences to
the original behaviour:

  1) Unconditional updates of the user read only fields (CPU, node, MMCID)
     are removed. Those fields are only updated on registration, task
     migration and MMCID changes.

  2) Unconditional evaluation of the criticial section pointer is
     removed. It's only evaluated when user space was interrupted and was
     scheduled out or before delivering a signal in the interrupted
     context.

  3) The read/only requirement of the ID fields is enforced. When the
     kernel detects that userspace manipulated the fields, the process is
     terminated. This ensures that multiple entities (libraries) can
     utilize RSEQ without interfering.

  4) Todays extended RSEQ feature (time slice extensions) and future
     extensions are only enabled in the v2 enabled mode.

Registrations with the original size of 32 bytes operate in backwards
compatible legacy mode without performance improvements and extended
features.

Unfortunately that also affects users of older GLIBC versions which
register the original size of 32 bytes and do not evaluate the kernel
required size in the auxiliary vector AT_RSEQ_FEATURE_SIZE.

That's the result of the lack of enforcement in the original implementation
and the unwillingness of a single entity to cooperate with the larger
ecosystem for many years.

Implement the required registration changes by restructuring the spaghetti
code and adding the size/version check. Also add documentation about the
differences of legacy and optimized RSEQ V2 mode.

Thanks to Mathieu for pointing out the ORIG_RSEQ_SIZE constraints!

Fixes: d6200245c75e ("rseq: Allow registering RSEQ with slice extension")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.927160119%40kernel.org
Cc: stable@vger.kernel.org

diff --git a/Documentation/userspace-api/rseq.rst b/Documentation/userspace-api/rseq.rst
index 3cd27a3c7c7e..8549a6c61531 100644
--- a/Documentation/userspace-api/rseq.rst
+++ b/Documentation/userspace-api/rseq.rst
@@ -24,6 +24,97 @@ Quick access to CPU number, node ID
 Allows to implement per CPU data efficiently. Documentation is in code and
 selftests. :(
 
+Optimized RSEQ V2
+-----------------
+
+On architectures which utilize the generic entry code and generic TIF bits
+the kernel supports runtime optimizations for RSEQ, which also enable
+enhanced features like scheduler time slice extensions.
+
+To enable them a task has to register the RSEQ region with at least the
+length advertised by getauxval(AT_RSEQ_FEATURE_SIZE).
+
+If existing binaries register with RSEQ_ORIG_SIZE (32 bytes), the kernel
+keeps the legacy low performance mode enabled to fulfil the expectations
+of existing users regarding the original RSEQ implementation behaviour.
+
+The following table documents the ABI and behavioral guarantees of the
+legacy and the optimized V2 mode.
+
+.. list-table:: RSEQ modes
+   :header-rows: 1
+
+   * - Nr
+     - What
+
+     - Legacy
+     - Optimized V2
+
+   * - 1
+     - The cpu_id_start, cpu_id, node_id and mm_cid fields (User mode read
+       only)
+       .. Legacy
+     - Updated by the kernel unconditionally after each context switch and
+       before signal delivery
+       .. Optimized V2
+     - Updated by the kernel if and only if they change, i.e. if the task
+       is migrated or mm_cid changes
+
+   * - 2
+     - The rseq_cs critical section field
+       .. Legacy
+     - Evaluated and handled unconditionally after each context switch and
+       before signal delivery
+       .. Optimized V2
+     - Evaluated and handled conditionally only when user space was
+       interrupted and was scheduled out or before delivering a signal in
+       the interrupted context.
+
+   * - 3
+     - Read only fields
+       .. Legacy
+     - No strict enforcement except in debug mode
+       .. Optimized V2
+     - Strict enforcement
+
+   * - 4
+     - membarrier(...RSEQ)
+       .. Legacy
+     - All running threads of the process are interrupted and the ID fields
+       are rewritten and eventually active critical sections are aborted
+       before they return to user space.  All threads which are scheduled
+       out whether voluntary or not are covered by #1/#2 above.
+       .. Optimized V2
+     - All running threads of the process are interrupted and eventually
+       active critical sections are aborted before these threads return to
+       user space. The ID fields are only updated if changed as a
+       consequence of the interrupt. All threads which are scheduled out
+       whether voluntary or not are covered by #1/#2 above.
+
+   * - 5
+     - Time slice extensions
+       .. Legacy
+     - Not supported
+       .. Optimized V2
+     - Supported
+
+The legacy mode is obviously less performant as it does unconditional
+updates and critical section checks even if not strictly required by the
+ABI contract. That can't be changed anymore as some users depend on that
+observed behavior, which in turn enables them to violate the ABI and
+overwrite the cpu_id_start field for their own purposes. This is obviously
+discouraged as it renders RSEQ incompatible with the intended usage and
+breaks the expectation of other libraries in the same application.
+
+The ABI compliant optimized v2 mode, which respects the read only fields,
+does not require unconditional updates and therefore is way more
+performant. The kernel validates the read only fields for compliance. If
+user space modifies them, the process is killed. Compliant usage allows
+multiple libraries in the same application to benefit from the RSEQ
+functionality without disturbing each other. The ABI compliant optimized v2
+mode also enables extended RSEQ features like time slice extensions.
+
+
 Scheduler time slice extensions
 -------------------------------
 
@@ -37,7 +128,8 @@ The prerequisites for this functionality are:
 
     * Enabled at boot time (default is enabled)
 
-    * A rseq userspace pointer has been registered for the thread
+    * A rseq userspace pointer has been registered for the thread in
+      optimized V2 mode
 
 The thread has to enable the functionality via prctl(2)::
 
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 101612027f6a..e75e3a5e312c 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -412,70 +412,23 @@ static bool rseq_reset_ids(void)
 /* The original rseq structure size (including padding) is 32 bytes. */
 #define ORIG_RSEQ_SIZE		32
 
-/*
- * sys_rseq - setup restartable sequences for caller thread.
- */
-SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
+static long rseq_register(struct rseq __user * rseq, u32 rseq_len, int flags, u32 sig)
 {
 	u32 rseqfl = 0;
 	u8 version = 1;
 
-	if (flags & RSEQ_FLAG_UNREGISTER) {
-		if (flags & ~RSEQ_FLAG_UNREGISTER)
-			return -EINVAL;
-		/* Unregister rseq for current thread. */
-		if (current->rseq.usrptr != rseq || !current->rseq.usrptr)
-			return -EINVAL;
-		if (rseq_len != current->rseq.len)
-			return -EINVAL;
-		if (current->rseq.sig != sig)
-			return -EPERM;
-		if (!rseq_reset_ids())
-			return -EFAULT;
-		rseq_reset(current);
-		return 0;
-	}
-
-	if (unlikely(flags & ~(RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)))
-		return -EINVAL;
-
-	if (current->rseq.usrptr) {
-		/*
-		 * If rseq is already registered, check whether
-		 * the provided address differs from the prior
-		 * one.
-		 */
-		if (current->rseq.usrptr != rseq || rseq_len != current->rseq.len)
-			return -EINVAL;
-		if (current->rseq.sig != sig)
-			return -EPERM;
-		/* Already registered. */
-		return -EBUSY;
-	}
-
-	/*
-	 * If there was no rseq previously registered, ensure the provided rseq
-	 * is properly aligned, as communcated to user-space through the ELF
-	 * auxiliary vector AT_RSEQ_ALIGN. If rseq_len is the original rseq
-	 * size, the required alignment is the original struct rseq alignment.
-	 *
-	 * The rseq_len is required to be greater or equal to the original rseq
-	 * size. In order to be valid, rseq_len is either the original rseq size,
-	 * or large enough to contain all supported fields, as communicated to
-	 * user-space through the ELF auxiliary vector AT_RSEQ_FEATURE_SIZE.
-	 */
-	if (rseq_len < ORIG_RSEQ_SIZE ||
-	    (rseq_len == ORIG_RSEQ_SIZE && !IS_ALIGNED((unsigned long)rseq, ORIG_RSEQ_SIZE)) ||
-	    (rseq_len != ORIG_RSEQ_SIZE && (!IS_ALIGNED((unsigned long)rseq, rseq_alloc_align()) ||
-					    rseq_len < offsetof(struct rseq, end))))
-		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
 
 	/*
-	 * The version check effectivly disables time slice extensions until the
-	 * RSEQ ABI V2 registration are implemented.
+	 * Architectures, which use the generic IRQ entry code (at least) enable
+	 * registrations with a size greater than the original v1 fixed sized
+	 * @rseq_len, which has been validated already to utilize the optimized
+	 * v2 ABI mode which also enables extended RSEQ features beyond MMCID.
 	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY) && rseq_len > ORIG_RSEQ_SIZE)
+		version = 2;
+
 	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION) && version > 1) {
 		if (rseq_slice_extension_enabled()) {
 			rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
@@ -523,11 +476,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32
 #endif
 
 	/*
-	 * If rseq was previously inactive, and has just been
-	 * registered, ensure the cpu_id_start and cpu_id fields
-	 * are updated before returning to user-space.
+	 * Ensure the cpu_id_start and cpu_id fields are updated before
+	 * returning to user-space.
 	 */
-	current->rseq.event.has_rseq = true;
+	current->rseq.event.has_rseq = version;
 	rseq_force_update();
 	return 0;
 
@@ -535,6 +487,80 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32
 	return -EFAULT;
 }
 
+static long rseq_unregister(struct rseq __user * rseq, u32 rseq_len, int flags, u32 sig)
+{
+	if (flags & ~RSEQ_FLAG_UNREGISTER)
+		return -EINVAL;
+	if (current->rseq.usrptr != rseq || !current->rseq.usrptr)
+		return -EINVAL;
+	if (rseq_len != current->rseq.len)
+		return -EINVAL;
+	if (current->rseq.sig != sig)
+		return -EPERM;
+	if (!rseq_reset_ids())
+		return -EFAULT;
+	rseq_reset(current);
+	return 0;
+}
+
+static long rseq_reregister(struct rseq __user * rseq, u32 rseq_len, u32 sig)
+{
+	/*
+	 * If rseq is already registered, check whether the provided address
+	 * differs from the prior one.
+	 */
+	if (current->rseq.usrptr != rseq || rseq_len != current->rseq.len)
+		return -EINVAL;
+	if (current->rseq.sig != sig)
+		return -EPERM;
+	/* Already registered. */
+	return -EBUSY;
+}
+
+static bool rseq_length_valid(struct rseq __user *rseq, unsigned int rseq_len)
+{
+	/*
+	 * Ensure the provided rseq is properly aligned, as communicated to
+	 * user-space through the ELF auxiliary vector AT_RSEQ_ALIGN. If
+	 * rseq_len is the original rseq size, the required alignment is the
+	 * original struct rseq alignment.
+	 *
+	 * In order to be valid, rseq_len is either the original rseq size, or
+	 * large enough to contain all supported fields, as communicated to
+	 * user-space through the ELF auxiliary vector AT_RSEQ_FEATURE_SIZE.
+	 */
+	if (rseq_len < ORIG_RSEQ_SIZE)
+		return false;
+
+	if (rseq_len == ORIG_RSEQ_SIZE)
+		return IS_ALIGNED((unsigned long)rseq, ORIG_RSEQ_SIZE);
+
+	return IS_ALIGNED((unsigned long)rseq, rseq_alloc_align()) &&
+		rseq_len >= offsetof(struct rseq, end);
+}
+
+#define RSEQ_FLAGS_SUPPORTED	(RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)
+
+/*
+ * sys_rseq - Register or unregister restartable sequences for the caller thread.
+ */
+SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
+{
+	if (flags & RSEQ_FLAG_UNREGISTER)
+		return rseq_unregister(rseq, rseq_len, flags, sig);
+
+	if (unlikely(flags & ~RSEQ_FLAGS_SUPPORTED))
+		return -EINVAL;
+
+	if (current->rseq.usrptr)
+		return rseq_reregister(rseq, rseq_len, sig);
+
+	if (!rseq_length_valid(rseq, rseq_len))
+		return -EINVAL;
+
+	return rseq_register(rseq, rseq_len, flags, sig);
+}
+
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
 struct slice_timer {
 	struct hrtimer	timer;


