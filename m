Return-Path: <stable+bounces-244158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIl0EVH7+WkYFwMAu9opvQ
	(envelope-from <stable+bounces-244158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:14:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7E74CF311
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 480E33022BA5
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395DA480944;
	Tue,  5 May 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onvN3uVO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8kC7pB2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E8480320;
	Tue,  5 May 2026 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777990417; cv=none; b=A/Doldr3RI1M9ny3zxlea6thi5NM9g8k+zYLfbm366vI0UN8Yq+HTgxq3FjKLt43VpRBipbfhwuKbdP8loul/sIJWgpdzNKXSpxowB6JvF6pNIY4MOaNGrVzDzeKZtt/gNzY9WQdyLvl1ffaixH8t0yrQ3P2Xfi4BxauBQiMjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777990417; c=relaxed/simple;
	bh=4+UBGHQD5GLST1CI304RQ3xrEEeKPiR3kddn9KHI9Fc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jomxn4PCJZ5zIl9T4UNRhhZxlAhHU7guzBdWSiD9iGjoEj4fp6tU5xTNndZyMw9ZwF5yd+/NrkpxissnqpNupzeBNTB2zjwe9NK0ZmZ9/bzVTd5AHVPpGhME+WK8dcQDZAV/tRx03kSAtSi3IJSZ/J+fL/TVOYrt6je2szn9ef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onvN3uVO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8kC7pB2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 May 2026 14:13:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777990413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGhZ7iCAAV17y4QCzMGWI56+3o2uWUbPd9DKPlvdp+g=;
	b=onvN3uVOCsH5yZiJBhvxow/8Z8ocXDoMNaUCnwEOTQS8kq2TEfADau2ADk9D/BWDR2LFnc
	VN89Pfg3S8+eTb4k2wdsvhPkRRQoJva2MKToQTuiBaDHM+uqvsW/wt1TJH3n+zCEVF1+6H
	fA1c3et8QE2MmhX2dCrIuzbpQ+/uPCZALsnkPjMiz4+TPvEGZV0SLcvjVA7zy3tXi15IAM
	7cOfVi3epuDAdpxXtc+wsVwVvSkOkne0Y1jBouA4YPZw95ACAekXY8PBSj5kAhihHWts0p
	3Zkd240NIs23xSDnWXdZZUdLGM/dZwe9Assd9EfzotjtZCaGxGMC6quhZCQm9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777990413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGhZ7iCAAV17y4QCzMGWI56+3o2uWUbPd9DKPlvdp+g=;
	b=v8kC7pB28bnlGB/GXG6SjyYC1mnY5EKHKPjI78gRZ+em8U9PKWzfz17x8NNWSPwgy1cqTJ
	ehnNbk5cPrje24DQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] selftests/rseq: Expand for optimized RSEQ ABI v2
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260428224428.009121296@kernel.org>
References: <20260428224428.009121296@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177799041196.424702.17838337725402284946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8F7E74CF311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244158-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,run_param_test.sh:url]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e5adc76278565ee3b5a5863b830231e37b83b3bc
Gitweb:        https://git.kernel.org/tip/e5adc76278565ee3b5a5863b830231e37b8=
3b3bc
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sat, 25 Apr 2026 14:48:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 May 2026 16:03:12 +02:00

selftests/rseq: Expand for optimized RSEQ ABI v2

Update the selftests so they are executed for legacy (32 bytes RSEQ region)
and optimized RSEQ ABI v2 mode.

Fixes: d6200245c75e ("rseq: Allow registering RSEQ with slice extension")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224428.009121296%40kernel.org
Cc: stable@vger.kernel.org
---
 tools/testing/selftests/rseq/Makefile              | 11 ++--
 tools/testing/selftests/rseq/check_optimized.c     | 17 ++++++-
 tools/testing/selftests/rseq/param_test.c          | 25 +++++---
 tools/testing/selftests/rseq/run_param_test.sh     | 39 +++++++++++++-
 tools/testing/selftests/rseq/run_timeslice_test.sh | 14 +++++-
 tools/testing/selftests/rseq/slice_test.c          |  2 +-
 6 files changed, 95 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/check_optimized.c
 create mode 100644 tools/testing/selftests/rseq/run_timeslice_test.sh

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/=
rseq/Makefile
index 0293a2f..50d69e2 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -15,7 +15,7 @@ LDLIBS +=3D -lpthread -ldl
 OVERRIDE_TARGETS =3D 1
=20
 TEST_GEN_PROGS =3D basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_=
test \
-		 param_test_benchmark param_test_mm_cid_benchmark slice_test
+		 param_test_benchmark param_test_mm_cid_benchmark
=20
 TEST_GEN_PROGS_EXTENDED =3D librseq.so \
 	param_test \
@@ -23,9 +23,11 @@ TEST_GEN_PROGS_EXTENDED =3D librseq.so \
 	param_test_mm_cid \
 	param_test_mm_cid_compare_twice \
 	syscall_errors_test \
-	legacy_check
+	legacy_check \
+	slice_test \
+	check_optimized
=20
-TEST_PROGS =3D run_param_test.sh run_syscall_errors_test.sh run_legacy_check=
.sh
+TEST_PROGS =3D run_param_test.sh run_syscall_errors_test.sh run_legacy_check=
.sh run_timeslice_test.sh
=20
 TEST_FILES :=3D settings
=20
@@ -66,3 +68,6 @@ $(OUTPUT)/syscall_errors_test: syscall_errors_test.c $(TEST=
_GEN_PROGS_EXTENDED)=20
=20
 $(OUTPUT)/slice_test: slice_test.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
 	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/check_optimized: check_optimized.c $(TEST_GEN_PROGS_EXTENDED) rseq=
.h rseq-*.h
+	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/check_optimized.c b/tools/testing/s=
elftests/rseq/check_optimized.c
new file mode 100644
index 0000000..a13e3f2
--- /dev/null
+++ b/tools/testing/selftests/rseq/check_optimized.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+int main(int argc, char **argv)
+{
+	if (__rseq_register_current_thread(true, false))
+		return -1;
+	return 0;
+}
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selfte=
sts/rseq/param_test.c
index 05d03e6..e1e98db 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -38,7 +38,7 @@ static int opt_modulo, verbose;
 static int opt_yield, opt_signal, opt_sleep,
 		opt_disable_rseq, opt_threads =3D 200,
 		opt_disable_mod =3D 0, opt_test =3D 's';
-
+static bool opt_rseq_legacy;
 static long long opt_reps =3D 5000;
=20
 static __thread __attribute__((tls_model("initial-exec")))
@@ -281,9 +281,12 @@ unsigned int yield_mod_cnt, nr_abort;
 	} \
 }
=20
+#define rseq_no_glibc			true
+
 #else
=20
 #define printf_verbose(fmt, ...)
+#define rseq_no_glibc			false
=20
 #endif /* BENCHMARK */
=20
@@ -481,7 +484,7 @@ void *test_percpu_spinlock_thread(void *arg)
 	long long i, reps;
=20
 	if (!opt_disable_rseq && thread_data->reg &&
-	    rseq_register_current_thread())
+	    __rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy))
 		abort();
 	reps =3D thread_data->reps;
 	for (i =3D 0; i < reps; i++) {
@@ -558,7 +561,7 @@ void *test_percpu_inc_thread(void *arg)
 	long long i, reps;
=20
 	if (!opt_disable_rseq && thread_data->reg &&
-	    rseq_register_current_thread())
+	    __rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy))
 		abort();
 	reps =3D thread_data->reps;
 	for (i =3D 0; i < reps; i++) {
@@ -712,7 +715,7 @@ void *test_percpu_list_thread(void *arg)
 	long long i, reps;
 	struct percpu_list *list =3D (struct percpu_list *)arg;
=20
-	if (!opt_disable_rseq && rseq_register_current_thread())
+	if (!opt_disable_rseq && __rseq_register_current_thread(rseq_no_glibc, opt_=
rseq_legacy))
 		abort();
=20
 	reps =3D opt_reps;
@@ -895,7 +898,7 @@ void *test_percpu_buffer_thread(void *arg)
 	long long i, reps;
 	struct percpu_buffer *buffer =3D (struct percpu_buffer *)arg;
=20
-	if (!opt_disable_rseq && rseq_register_current_thread())
+	if (!opt_disable_rseq && __rseq_register_current_thread(rseq_no_glibc, opt_=
rseq_legacy))
 		abort();
=20
 	reps =3D opt_reps;
@@ -1105,7 +1108,7 @@ void *test_percpu_memcpy_buffer_thread(void *arg)
 	long long i, reps;
 	struct percpu_memcpy_buffer *buffer =3D (struct percpu_memcpy_buffer *)arg;
=20
-	if (!opt_disable_rseq && rseq_register_current_thread())
+	if (!opt_disable_rseq && __rseq_register_current_thread(rseq_no_glibc, opt_=
rseq_legacy))
 		abort();
=20
 	reps =3D opt_reps;
@@ -1258,7 +1261,7 @@ void *test_membarrier_worker_thread(void *arg)
 	const int iters =3D opt_reps;
 	int i;
=20
-	if (rseq_register_current_thread()) {
+	if (__rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy)) {
 		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n=
",
 			errno, strerror(errno));
 		abort();
@@ -1323,7 +1326,7 @@ void *test_membarrier_manager_thread(void *arg)
 	intptr_t expect_a =3D 0, expect_b =3D 0;
 	int cpu_a =3D 0, cpu_b =3D 0;
=20
-	if (rseq_register_current_thread()) {
+	if (__rseq_register_current_thread(rseq_no_glibc, opt_rseq_legacy)) {
 		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n=
",
 			errno, strerror(errno));
 		abort();
@@ -1475,6 +1478,7 @@ static void show_usage(int argc, char **argv)
 	printf("	[-D M] Disable rseq for each M threads\n");
 	printf("	[-T test] Choose test: (s)pinlock, (l)ist, (b)uffer, (m)emcpy, (i)=
ncrement, membarrie(r)\n");
 	printf("	[-M] Push into buffer and memcpy buffer with memory barriers.\n");
+	printf("	[-O] Test with optimized RSEQ\n");
 	printf("	[-v] Verbose output.\n");
 	printf("	[-h] Show this help.\n");
 	printf("\n");
@@ -1602,6 +1606,9 @@ int main(int argc, char **argv)
 		case 'M':
 			opt_mo =3D RSEQ_MO_RELEASE;
 			break;
+		case 'L':
+			opt_rseq_legacy =3D true;
+			break;
 		default:
 			show_usage(argc, argv);
 			goto error;
@@ -1618,7 +1625,7 @@ int main(int argc, char **argv)
 	if (set_signal_handler())
 		goto error;
=20
-	if (!opt_disable_rseq && rseq_register_current_thread())
+	if (!opt_disable_rseq && __rseq_register_current_thread(rseq_no_glibc, opt_=
rseq_legacy))
 		goto error;
 	if (!opt_disable_rseq && !rseq_validate_cpu_id()) {
 		fprintf(stderr, "Error: cpu id getter unavailable\n");
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/s=
elftests/rseq/run_param_test.sh
index 8d31426..69a3fa0 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -34,6 +34,11 @@ REPS=3D1000
 SLOW_REPS=3D100
 NR_THREADS=3D$((6*${NR_CPUS}))
=20
+# Prevent GLIBC from registering RSEQ so the selftest can run in legacy and
+# performance optimized mode.
+GLIBC_TUNABLES=3D"${GLIBC_TUNABLES:-}:glibc.pthread.rseq=3D0"
+export GLIBC_TUNABLES
+
 function do_tests()
 {
 	local i=3D0
@@ -103,6 +108,40 @@ function inject_blocking()
 	NR_LOOPS=3D
 }
=20
+echo "Testing in legacy RSEQ mode"
+echo "Yield injection (25%)"
+inject_blocking -m 4 -y -L
+
+echo "Yield injection (50%)"
+inject_blocking -m 2 -y -L
+
+echo "Yield injection (100%)"
+inject_blocking -m 1 -y -L
+
+echo "Kill injection (25%)"
+inject_blocking -m 4 -k -L
+
+echo "Kill injection (50%)"
+inject_blocking -m 2 -k -L
+
+echo "Kill injection (100%)"
+inject_blocking -m 1 -k -L
+
+echo "Sleep injection (1ms, 25%)"
+inject_blocking -m 4 -s 1 -L
+
+echo "Sleep injection (1ms, 50%)"
+inject_blocking -m 2 -s 1 -L
+
+echo "Sleep injection (1ms, 100%)"
+inject_blocking -m 1 -s 1 -L
+
+./check_optimized || {
+    echo "Skipping optimized RSEQ mode test. Not supported";
+    exit 0
+}
+
+echo "Testing in optimized RSEQ mode"
 echo "Yield injection (25%)"
 inject_blocking -m 4 -y
=20
diff --git a/tools/testing/selftests/rseq/run_timeslice_test.sh b/tools/testi=
ng/selftests/rseq/run_timeslice_test.sh
new file mode 100644
index 0000000..551ebed
--- /dev/null
+++ b/tools/testing/selftests/rseq/run_timeslice_test.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+
+# Prevent GLIBC from registering RSEQ so the selftest can run in legacy
+# and performance optimized mode.
+GLIBC_TUNABLES=3D"${GLIBC_TUNABLES:-}:glibc.pthread.rseq=3D0"
+export GLIBC_TUNABLES
+
+./check_optimized || {
+    echo "Skipping optimized RSEQ mode test. Not supported";
+    exit 0
+}
+
+./slice_test
diff --git a/tools/testing/selftests/rseq/slice_test.c b/tools/testing/selfte=
sts/rseq/slice_test.c
index 77e668f..e402d44 100644
--- a/tools/testing/selftests/rseq/slice_test.c
+++ b/tools/testing/selftests/rseq/slice_test.c
@@ -124,7 +124,7 @@ FIXTURE_SETUP(slice_ext)
 {
 	cpu_set_t affinity;
=20
-	if (rseq_register_current_thread())
+	if (__rseq_register_current_thread(true, false))
 		SKIP(return, "RSEQ not supported\n");
=20
 	if (prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,

