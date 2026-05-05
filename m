Return-Path: <stable+bounces-244163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKZyD2n9+WkqFwMAu9opvQ
	(envelope-from <stable+bounces-244163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:23:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF2F4CF54D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05C68310D6CC
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C619E481640;
	Tue,  5 May 2026 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rI27orrw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+KXCgtD+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A2480356;
	Tue,  5 May 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990425; cv=none; b=LUsl7zNpRKCc+iA/aXHa3wGxrQEsgqIP9n+QNLDA65cpszSQhnKQt7fXR+nTnVMbLrOxNKVCxWjzFDCWzV82aYYf+MAQ1kotn5ylId7e1yancPXu+oOzUyvdngZPAYTWdzagWDTbfg7+rB49AOUAvqO9NhEK8n+lWpSBgZWWVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990425; c=relaxed/simple;
	bh=83DT755YA8zeuSJHceBhqMMl5uHcpnpn5V+IkmVBQNs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=anxRLH/oBBo8H3VnzkBt6EDenEYlh0cJ/pVPg+UaCI3qyILrgbUZERkxvZzWfcFgr/HMDsSCmHvBFVyO/zIlgPtoiAFP6emXRW11rNitkzvJJ2ytrr7F2ke2xIhsIvYdy8VDGDEyU1S7GZF0I8hQkjRCdN55hAWdQ2+yNyAJ20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rI27orrw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+KXCgtD+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 May 2026 14:13:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777990419;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+6Vcb7SErYlGqQQ6xGWJ/6r+OF447wV7j9fxNjAac4=;
	b=rI27orrwEs1Pn2kzOoadbdAqeJl/RHjHBOPamWazxJXjR3MMF6mEdUE3DsbQgLypzIiUWE
	ogyB90Y+5zijanzFDZwkaxUCveExLNWDhqHDIN9AMPS45cKkFxrcx4111FX37QMbhEb1H5
	vWLgoH3jT/gjl/WkHdxw1VI4IFg7X6vUtIGyr8QToVIn4/Oc5FMt51R1IX6c0UA5mBk3Qh
	q+QPqmwZbphXNu1dhUeW/t1XPq/PM5kYKYjS3j/B15dvU27hDGZrQSq05t3IdntbskvPYj
	mkmKTuh6MN/34KN1A+o9tkBRcOm/qKrHLdFLx2JvPZg19vXJGhnEQOSZGPLh8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777990419;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+6Vcb7SErYlGqQQ6xGWJ/6r+OF447wV7j9fxNjAac4=;
	b=+KXCgtD+y3iH2PIZFo5PlO0dzFZoUaX6nZw2xjbC63Hsu7rJ/th0W+33ac1yy3WzIKUvMi
	HgfJJ9p4kvYyA7Dw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] selftests/rseq: Make registration flexible for
 legacy and optimized mode
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260428224427.677889423@kernel.org>
References: <20260428224427.677889423@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177799041734.424702.13696299768376681320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CAF2F4CF54D
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
	TAGGED_FROM(0.00)[bounces-244163-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[msgid.link:server fail,linutronix.de:server fail,vger.kernel.org:server fail,infradead.org:server fail,sea.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:dkim,infradead.org:email]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d97cb2ef0b221b068e90b6058aa97faa0626bdab
Gitweb:        https://git.kernel.org/tip/d97cb2ef0b221b068e90b6058aa97faa062=
6bdab
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sun, 26 Apr 2026 18:13:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 May 2026 16:03:11 +02:00

selftests/rseq: Make registration flexible for legacy and optimized mode

rseq_register_current_thread() either uses the glibc registered RSEQ region
or registers it's own region with the legacy size of 32 bytes.

That worked so far, but becomes a problem when the kernel implements a
distinction between legacy and performance optimized behavior based on the
registration size as that does not allow to test both modes with the self
test suite.

Add two arguments to the function. One to enforce that the registration is
not using libc provided mode and one to tell the registration to use the
legacy size and not the kernel advertised size.

Rename it and make the original one a inline wrapper which preserves the
existing behavior.

Fixes: 566d8015f7ee ("rseq: Avoid CPU/MM CID updates when no event pending")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.677889423%40kernel.org
Cc: stable@vger.kernel.org
---
 tools/testing/selftests/rseq/rseq-abi.h |  7 +++-
 tools/testing/selftests/rseq/rseq.c     | 39 +++++++++++-------------
 tools/testing/selftests/rseq/rseq.h     |  8 ++++-
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftest=
s/rseq/rseq-abi.h
index ecef315..5f4ea21 100644
--- a/tools/testing/selftests/rseq/rseq-abi.h
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -192,9 +192,14 @@ struct rseq_abi {
 	struct rseq_abi_slice_ctrl slice_ctrl;
=20
 	/*
+	 * Place holder to push the size above 32 bytes.
+	 */
+	__u8 __reserved;
+
+	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
 	char end[];
-} __attribute__((aligned(4 * sizeof(__u64))));
+} __attribute__((aligned(256)));
=20
 #endif /* _RSEQ_ABI_H */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rs=
eq/rseq.c
index a736727..be0d0a9 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -56,6 +56,7 @@ ptrdiff_t rseq_offset;
  * unsuccessful.
  */
 unsigned int rseq_size =3D -1U;
+static unsigned int rseq_alloc_size;
=20
 /* Flags used during rseq registration.  */
 unsigned int rseq_flags;
@@ -115,29 +116,17 @@ bool rseq_available(void)
 	}
 }
=20
-/* The rseq areas need to be at least 32 bytes. */
-static
-unsigned int get_rseq_min_alloc_size(void)
-{
-	unsigned int alloc_size =3D rseq_size;
-
-	if (alloc_size < ORIG_RSEQ_ALLOC_SIZE)
-		alloc_size =3D ORIG_RSEQ_ALLOC_SIZE;
-	return alloc_size;
-}
-
 /*
  * Return the feature size supported by the kernel.
  *
  * Depending on the value returned by getauxval(AT_RSEQ_FEATURE_SIZE):
  *
- * 0:   Return ORIG_RSEQ_FEATURE_SIZE (20)
+ *   0: Return ORIG_RSEQ_FEATURE_SIZE (20)
  * > 0: Return the value from getauxval(AT_RSEQ_FEATURE_SIZE).
  *
  * It should never return a value below ORIG_RSEQ_FEATURE_SIZE.
  */
-static
-unsigned int get_rseq_kernel_feature_size(void)
+static unsigned int get_rseq_kernel_feature_size(void)
 {
 	unsigned long auxv_rseq_feature_size, auxv_rseq_align;
=20
@@ -152,15 +141,24 @@ unsigned int get_rseq_kernel_feature_size(void)
 		return ORIG_RSEQ_FEATURE_SIZE;
 }
=20
-int rseq_register_current_thread(void)
+int __rseq_register_current_thread(bool nolibc, bool legacy)
 {
+	unsigned int size;
 	int rc;
=20
 	if (!rseq_ownership) {
 		/* Treat libc's ownership as a successful registration. */
-		return 0;
+		return nolibc ? -EBUSY : 0;
 	}
-	rc =3D sys_rseq(&__rseq.abi, get_rseq_min_alloc_size(), 0, RSEQ_SIG);
+
+	/* The minimal allocation size is 32, which is the legacy allocation size */
+	size =3D get_rseq_kernel_feature_size();
+	if (legacy || size < ORIG_RSEQ_ALLOC_SIZE)
+		rseq_alloc_size =3D ORIG_RSEQ_ALLOC_SIZE;
+	else
+		rseq_alloc_size =3D size;
+
+	rc =3D sys_rseq(&__rseq.abi, rseq_alloc_size, 0, RSEQ_SIG);
 	if (rc) {
 		/*
 		 * After at least one thread has registered successfully
@@ -179,9 +177,8 @@ int rseq_register_current_thread(void)
 	 * The first thread to register sets the rseq_size to mimic the libc
 	 * behavior.
 	 */
-	if (RSEQ_READ_ONCE(rseq_size) =3D=3D 0) {
-		RSEQ_WRITE_ONCE(rseq_size, get_rseq_kernel_feature_size());
-	}
+	if (RSEQ_READ_ONCE(rseq_size) =3D=3D 0)
+		RSEQ_WRITE_ONCE(rseq_size, size);
=20
 	return 0;
 }
@@ -194,7 +191,7 @@ int rseq_unregister_current_thread(void)
 		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
 	}
-	rc =3D sys_rseq(&__rseq.abi, get_rseq_min_alloc_size(), RSEQ_ABI_FLAG_UNREG=
ISTER, RSEQ_SIG);
+	rc =3D sys_rseq(&__rseq.abi, rseq_alloc_size, RSEQ_ABI_FLAG_UNREGISTER, RSE=
Q_SIG);
 	if (rc)
 		return -1;
 	return 0;
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rs=
eq/rseq.h
index f51a5fd..c62ebb9 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -8,6 +8,7 @@
 #ifndef RSEQ_H
 #define RSEQ_H
=20
+#include <assert.h>
 #include <stdint.h>
 #include <stdbool.h>
 #include <pthread.h>
@@ -142,7 +143,12 @@ static inline struct rseq_abi *rseq_get_abi(void)
  * succeed. A restartable sequence executed from a non-registered
  * thread will always fail.
  */
-int rseq_register_current_thread(void);
+int __rseq_register_current_thread(bool nolibc, bool legacy);
+
+static inline int rseq_register_current_thread(void)
+{
+	return __rseq_register_current_thread(false, false);
+}
=20
 /*
  * Unregister rseq for current thread.

