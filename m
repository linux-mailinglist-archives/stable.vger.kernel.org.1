Return-Path: <stable+bounces-244159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL7KDs/8+WkqFwMAu9opvQ
	(envelope-from <stable+bounces-244159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:21:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 812194CF48A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F093308FBE0
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB60848096D;
	Tue,  5 May 2026 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eAiCaoH2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4hI/nGU"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3948034F;
	Tue,  5 May 2026 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990418; cv=none; b=jqq5g8c7jJIAQGpUUjPF86/t66HaKxirwfd+0Iqv0vs8nfzG1YZidOV4KYBBk5BeO3S032YXcvs1CVIu4iHm7dWvh6LCO44xawlFTYYSRCVziF1xGHgolDl1zg1PdRBy5N1zEFJRm9eObGoAOqUvgCGFRiFLVPwWuvkrfCH/C9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990418; c=relaxed/simple;
	bh=Jpcl+3X0pBXaY9MHORZe9DBrNqZ1puS3+3z32RI3V80=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N0+MrFsRRcbAVVj+u/1LQ+4AZ62LiCvtnVwibfuW5h74kbzDQp/xFD8NkuzynzH5Oo4rzFB8Ee9IEJ9vqWaGdAJ7YV1+fvBgAOOd3EnccdcyAG791Ut68adbscPlvvZ8fDBMvIEZ1PEYdyypHfPFbJKYvY0FrSW2VLz5SoPnZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eAiCaoH2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4hI/nGU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 May 2026 14:13:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777990414;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9W3Truj98tNy/OtAL5KkOz2Jda9UAQfOaIjgF8tak8w=;
	b=eAiCaoH20+X3xHFKFMsI7/NxZVe2gKykKyjNkiSVp5uQhPA4ZmEer5Zvza0GhUR3/bo1sA
	TdjgDML57PpOtVxDtlvnpsjp/0Vmp/F/reibPai+7ohgZ5cMtZtaSMpiPAxjAtMbHuxRAB
	got0ZkdpStS9tcnfjh34mvKTHP/mDiO7rUx6SQ0y2jhHVtDRbXu8DOuNoBUP5MaNaULKcc
	lZu+C4ZIfdQriVU0nMzT2Bs//MHx+HQ/+9YW4RU8+eX35fEmiOI7rCTA2FcmpbMgDEU/V9
	bUkkqJyMFqaPE/FXzdU1IKDCP1AT6m357AIdzhXxVNql+AV6mrTzB8aoFPf6Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777990414;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9W3Truj98tNy/OtAL5KkOz2Jda9UAQfOaIjgF8tak8w=;
	b=h4hI/nGUnX1OGr6Cg9XvgB3fCGvJbEDVBBMbv2nSsMc8/5QaX2rF9P6mF/ICldsZt38yvs
	sBwocjNQYmCj+3Cw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] rseq: Reenable performance optimizations conditionally
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260428224427.927160119@kernel.org>
References: <20260428224427.927160119@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177799041329.424702.14993578066662888969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 812194CF48A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244159-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,msgid.link:url,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     22a92dbd6083581c6b8b8a3fa90f9f96ea91af44
Gitweb:        https://git.kernel.org/tip/22a92dbd6083581c6b8b8a3fa90f9f96ea9=
1af44
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sun, 26 Apr 2026 10:01:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 May 2026 16:03:11 +02:00

rseq: Reenable performance optimizations conditionally

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
---
 Documentation/userspace-api/rseq.rst |  94 ++++++++++++++++-
 kernel/rseq.c                        | 144 +++++++++++++++-----------
 2 files changed, 178 insertions(+), 60 deletions(-)

diff --git a/Documentation/userspace-api/rseq.rst b/Documentation/userspace-a=
pi/rseq.rst
index 3cd27a3..8549a6c 100644
--- a/Documentation/userspace-api/rseq.rst
+++ b/Documentation/userspace-api/rseq.rst
@@ -24,6 +24,97 @@ Quick access to CPU number, node ID
 Allows to implement per CPU data efficiently. Documentation is in code and
 selftests. :(
=20
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
=20
@@ -37,7 +128,8 @@ The prerequisites for this functionality are:
=20
     * Enabled at boot time (default is enabled)
=20
-    * A rseq userspace pointer has been registered for the thread
+    * A rseq userspace pointer has been registered for the thread in
+      optimized V2 mode
=20
 The thread has to enable the functionality via prctl(2)::
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index aa25753..6ff6264 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -413,70 +413,23 @@ efault:
 /* The original rseq structure size (including padding) is 32 bytes. */
 #define ORIG_RSEQ_SIZE		32
=20
-/*
- * sys_rseq - setup restartable sequences for caller thread.
- */
-SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags,=
 u32, sig)
+static long rseq_register(struct rseq __user * rseq, u32 rseq_len, int flags=
, u32 sig)
 {
 	u32 rseqfl =3D 0;
 	u8 version =3D 1;
=20
-	if (flags & RSEQ_FLAG_UNREGISTER) {
-		if (flags & ~RSEQ_FLAG_UNREGISTER)
-			return -EINVAL;
-		/* Unregister rseq for current thread. */
-		if (current->rseq.usrptr !=3D rseq || !current->rseq.usrptr)
-			return -EINVAL;
-		if (rseq_len !=3D current->rseq.len)
-			return -EINVAL;
-		if (current->rseq.sig !=3D sig)
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
-		if (current->rseq.usrptr !=3D rseq || rseq_len !=3D current->rseq.len)
-			return -EINVAL;
-		if (current->rseq.sig !=3D sig)
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
-	    (rseq_len =3D=3D ORIG_RSEQ_SIZE && !IS_ALIGNED((unsigned long)rseq, ORI=
G_RSEQ_SIZE)) ||
-	    (rseq_len !=3D ORIG_RSEQ_SIZE && (!IS_ALIGNED((unsigned long)rseq, rseq=
_alloc_align()) ||
-					    rseq_len < offsetof(struct rseq, end))))
-		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
=20
 	/*
-	 * The version check effectivly disables time slice extensions until the
-	 * RSEQ ABI V2 registration are implemented.
+	 * Architectures, which use the generic IRQ entry code (at least) enable
+	 * registrations with a size greater than the original v1 fixed sized
+	 * @rseq_len, which has been validated already to utilize the optimized
+	 * v2 ABI mode which also enables extended RSEQ features beyond MMCID.
 	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY) && rseq_len > ORIG_RSEQ_SIZE)
+		version =3D 2;
+
 	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION) && version > 1) {
 		if (rseq_slice_extension_enabled()) {
 			rseqfl |=3D RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
@@ -524,11 +477,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, =
rseq_len, int, flags, u32
 #endif
=20
 	/*
-	 * If rseq was previously inactive, and has just been
-	 * registered, ensure the cpu_id_start and cpu_id fields
-	 * are updated before returning to user-space.
+	 * Ensure the cpu_id_start and cpu_id fields are updated before
+	 * returning to user-space.
 	 */
-	current->rseq.event.has_rseq =3D true;
+	current->rseq.event.has_rseq =3D version;
 	rseq_force_update();
 	return 0;
=20
@@ -536,6 +488,80 @@ efault:
 	return -EFAULT;
 }
=20
+static long rseq_unregister(struct rseq __user * rseq, u32 rseq_len, int fla=
gs, u32 sig)
+{
+	if (flags & ~RSEQ_FLAG_UNREGISTER)
+		return -EINVAL;
+	if (current->rseq.usrptr !=3D rseq || !current->rseq.usrptr)
+		return -EINVAL;
+	if (rseq_len !=3D current->rseq.len)
+		return -EINVAL;
+	if (current->rseq.sig !=3D sig)
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
+	if (current->rseq.usrptr !=3D rseq || rseq_len !=3D current->rseq.len)
+		return -EINVAL;
+	if (current->rseq.sig !=3D sig)
+		return -EPERM;
+	/* Already registered. */
+	return -EBUSY;
+}
+
+static bool rseq_length_valid(struct rseq __user *rseq, unsigned int rseq_le=
n)
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
+	if (rseq_len =3D=3D ORIG_RSEQ_SIZE)
+		return IS_ALIGNED((unsigned long)rseq, ORIG_RSEQ_SIZE);
+
+	return IS_ALIGNED((unsigned long)rseq, rseq_alloc_align()) &&
+		rseq_len >=3D offsetof(struct rseq, end);
+}
+
+#define RSEQ_FLAGS_SUPPORTED	(RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)
+
+/*
+ * sys_rseq - Register or unregister restartable sequences for the caller th=
read.
+ */
+SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags,=
 u32, sig)
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

