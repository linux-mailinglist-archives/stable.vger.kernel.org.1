Return-Path: <stable+bounces-242508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HGZG7AB9WnAHAIAu9opvQ
	(envelope-from <stable+bounces-242508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:40:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDD14AF39C
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 433003016827
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE724219E7;
	Fri,  1 May 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T3H5TFZ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5RwPpR8K"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0004219EB;
	Fri,  1 May 2026 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664420; cv=none; b=Dv2ZJA6gCAjbuUd7JcJSB5IUOvyw4NDoaSIX8QUJuN5wvWnbB/uiZzRJ58oeh+cQOIQUyJtY7V7pYGUMGfmAbPTmmQ5uFbciMTD58HvxBkJu41AIluxJeKraoEoH4X8t0G9PUuL8DzIwoPN2L/eIvUMSnaHIFHiH4IX2TWjceaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664420; c=relaxed/simple;
	bh=34BKSK+X9ZwKJD+b5K9PcNNmKzKiDfRYRbTExHDlbeg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=f/W3Yyrpa7SUwMoxuZztvLJLOG3RG3rNsIzU33b7gt2Qj39eNXvTTyVhYSUACp3/VY91F5EbN3yLS8HcrNdkb1e7HfOVENNo2/ONqnpSztRM/eTJCZ3m+x57tUlGCyKRNzqM21Q/DLc3u9+GPDrM2/fXjS5Zbyq0GUD4LGv12NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T3H5TFZ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5RwPpR8K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 May 2026 19:40:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777664412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=onJf8wLlmacv9QVcunHR7rYH+BwREF01rmG1oTsj6B8=;
	b=T3H5TFZ8toY/Dyq+dq6cZ+/hiBJTuGclKGpuNA3wgBrCWr0YZtL58K6fB2A2HUVtpmmz7E
	0w6McRghZ5k4Jtgem07HefQWEc106YqdxZOO9hgp94sTPAqQLcCIgkKs0ZPF9TfMTapGdr
	4p/YjxAehqagXPvmXPh6HJ1DgD0ZJyvFLzy37GwOSTrZRt+59A5cdwYoQkVzImwPd0sLCB
	5s7SHj1GVDT4ci8kB8Fic6Og+EwA49V0XBUQOz3I/LDpPv9rvYOnnPnd4jebim8k6ESn/Q
	2pT7cIXS9Rqp0pNTdF3pYrLaiRTC/rgA+Pqd5mlWJubMP/hwyFEf04w9O1652A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777664412;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=onJf8wLlmacv9QVcunHR7rYH+BwREF01rmG1oTsj6B8=;
	b=5RwPpR8KZdNMw3Upv+UbaPYRpHAla4Wfz5dVywhjfbBrMvaf5kEDOtu5jYZyfDPukQHV91
	hPVJkcubF5JHshAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] selftests/rseq: Validate legacy behavior
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177766441112.3521451.15841872191300221964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DDDD14AF39C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242508-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,run_syscall_errors_test.sh:url,run_param_test.sh:url,librseq.so:url]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     4ed271901f3152f2c6b998dcd47f7ca5a7e5d7c4
Gitweb:        https://git.kernel.org/tip/4ed271901f3152f2c6b998dcd47f7ca5a7e=
5d7c4
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sun, 26 Apr 2026 17:51:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 May 2026 21:32:22 +02:00

selftests/rseq: Validate legacy behavior

The RSEQ legacy mode behavior requires that the ID fields in the rseq
region are unconditionally updated on every context switch and before
signal delivery even if not required by the ABI specification.

To ensure that this behavior is preserved for legacy users in the future,
add a test which validates that with a sleep() and a signal sent to self.

Provide a run script which prevents GLIBC from registering a RSEQ region,
so that the test can register it's own legacy sized region.

Fixes: 566d8015f7ee ("rseq: Avoid CPU/MM CID updates when no event pending")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.764705536%40kernel.org
Cc: stable@vger.kernel.org
---
 tools/testing/selftests/rseq/Makefile            |  5 +-
 tools/testing/selftests/rseq/legacy_check.c      | 65 +++++++++++++++-
 tools/testing/selftests/rseq/run_legacy_check.sh |  4 +-
 3 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/legacy_check.c
 create mode 100644 tools/testing/selftests/rseq/run_legacy_check.sh

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/=
rseq/Makefile
index 0d1947c..0293a2f 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -22,9 +22,10 @@ TEST_GEN_PROGS_EXTENDED =3D librseq.so \
 	param_test_compare_twice \
 	param_test_mm_cid \
 	param_test_mm_cid_compare_twice \
-	syscall_errors_test
+	syscall_errors_test \
+	legacy_check
=20
-TEST_PROGS =3D run_param_test.sh run_syscall_errors_test.sh
+TEST_PROGS =3D run_param_test.sh run_syscall_errors_test.sh run_legacy_check=
.sh
=20
 TEST_FILES :=3D settings
=20
diff --git a/tools/testing/selftests/rseq/legacy_check.c b/tools/testing/self=
tests/rseq/legacy_check.c
new file mode 100644
index 0000000..3f7de4e
--- /dev/null
+++ b/tools/testing/selftests/rseq/legacy_check.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <errno.h>
+#include <signal.h>
+#include <stdint.h>
+#include <unistd.h>
+
+#include "rseq.h"
+
+#include "../kselftest_harness.h"
+
+FIXTURE(legacy)
+{
+};
+
+static int cpu_id_in_sigfn =3D -1;
+
+static void sigfn(int sig)
+{
+	struct rseq_abi *rs =3D rseq_get_abi();
+
+	cpu_id_in_sigfn =3D rs->cpu_id_start;
+}
+
+FIXTURE_SETUP(legacy)
+{
+	int res =3D __rseq_register_current_thread(true, true);
+
+	switch (res) {
+	case -ENOSYS:
+		SKIP(return, "RSEQ not enabled\n");
+	case -EBUSY:
+		SKIP(return, "GLIBC owns RSEQ. Disable GLIBC RSEQ registration\n");
+	default:
+		ASSERT_EQ(res, 0);
+	}
+
+	ASSERT_NE(signal(SIGUSR1, sigfn), SIG_ERR);
+}
+
+FIXTURE_TEARDOWN(legacy)
+{
+}
+
+TEST_F(legacy, legacy_test)
+{
+	struct rseq_abi *rs =3D rseq_get_abi();
+
+	ASSERT_NE(rs, NULL);
+
+	/* Overwrite rs::cpu_id_start */
+	rs->cpu_id_start =3D -1;
+	sleep(1);
+	ASSERT_NE(rs->cpu_id_start, -1);
+
+	rs->cpu_id_start =3D -1;
+	ASSERT_EQ(raise(SIGUSR1), 0);
+	ASSERT_NE(rs->cpu_id_start, -1);
+	ASSERT_NE(cpu_id_in_sigfn, -1);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/rseq/run_legacy_check.sh b/tools/testing=
/selftests/rseq/run_legacy_check.sh
new file mode 100644
index 0000000..5577b46
--- /dev/null
+++ b/tools/testing/selftests/rseq/run_legacy_check.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+GLIBC_TUNABLES=3D"${GLIBC_TUNABLES:-}:glibc.pthread.rseq=3D0" ./legacy_check

