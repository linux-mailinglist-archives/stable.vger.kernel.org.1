Return-Path: <stable+bounces-246434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB0aI6pzA2rf5wEAu9opvQ
	(envelope-from <stable+bounces-246434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:38:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7B9527E4E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 143623214F54
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9DD2DE6E3;
	Tue, 12 May 2026 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yWbdIpJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E533EDE48;
	Tue, 12 May 2026 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609218; cv=none; b=Ra6rDNvbLirI1PgBYAwoXWr+9Bxeilbde96dH6qiV5F71T1QDrRRNQdU8zIb+lAWTv1KLq/z1JRPnijKAffNJO5QctpQFjImxAuI0gqzzkPCUeAj038KoyPvIPCzobDbQROkPVP89NYagFpPYZNyKObiZzTdI9z6dfvutTxIAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609218; c=relaxed/simple;
	bh=WiWV7xT3jihtTFWhk3rGrH8cWELLBwWrgPBCIUniBnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeufgxzbdZNigmiaLL0c5CwOrp4y48f2WoX2YPIfVOjFVkHNtD0q1h6bvSsdFZT/m9Dj1rXF+yT8Qr4SeijZHGPW07CZpqq7FzXagA2M+m+fs+nj8T1tHJcrOIU5bh2KKYHGS00MkP9xqTS484Ke2DWs3/JbWPLajVb1kOo1oJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yWbdIpJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D70C2BCB0;
	Tue, 12 May 2026 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609218;
	bh=WiWV7xT3jihtTFWhk3rGrH8cWELLBwWrgPBCIUniBnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yWbdIpJItjeAioNzULWQND0ctfO2+gRRMsW2VCi5bse3DtqA4EtEZ3AkBQSxxJCMp
	 /tixgKzL1d+8SnO+W17luhGLDehXKAaq6ppJeGznje0PC0pC10ZrUsdOlRELZejoOM
	 DxieIEQr5HOnb1dksMGOfrHTzNjhM8Tuno0Dp09M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 7.0 108/307] selftests/rseq: Validate legacy behavior
Date: Tue, 12 May 2026 19:38:23 +0200
Message-ID: <20260512173942.404727955@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC7B9527E4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246434-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,run_param_test.sh:url,librseq.so:url,infradead.org:email,run_syscall_errors_test.sh:url,msgid.link:url,run_legacy_check.sh:url]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@kernel.org>

commit fdf4eb632683bfc2840acebe62716cb468d43e10 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rseq/Makefile         |  5 +-
 tools/testing/selftests/rseq/legacy_check.c   | 65 +++++++++++++++++++
 .../selftests/rseq/run_legacy_check.sh        |  4 ++
 3 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/legacy_check.c
 create mode 100755 tools/testing/selftests/rseq/run_legacy_check.sh

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 0d1947c0d623..0293a2f17f51 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -22,9 +22,10 @@ TEST_GEN_PROGS_EXTENDED = librseq.so \
 	param_test_compare_twice \
 	param_test_mm_cid \
 	param_test_mm_cid_compare_twice \
-	syscall_errors_test
+	syscall_errors_test \
+	legacy_check
 
-TEST_PROGS = run_param_test.sh run_syscall_errors_test.sh
+TEST_PROGS = run_param_test.sh run_syscall_errors_test.sh run_legacy_check.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/rseq/legacy_check.c b/tools/testing/selftests/rseq/legacy_check.c
new file mode 100644
index 000000000000..3f7de4e28303
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
+static int cpu_id_in_sigfn = -1;
+
+static void sigfn(int sig)
+{
+	struct rseq_abi *rs = rseq_get_abi();
+
+	cpu_id_in_sigfn = rs->cpu_id_start;
+}
+
+FIXTURE_SETUP(legacy)
+{
+	int res = __rseq_register_current_thread(true, true);
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
+	struct rseq_abi *rs = rseq_get_abi();
+
+	ASSERT_NE(rs, NULL);
+
+	/* Overwrite rs::cpu_id_start */
+	rs->cpu_id_start = -1;
+	sleep(1);
+	ASSERT_NE(rs->cpu_id_start, -1);
+
+	rs->cpu_id_start = -1;
+	ASSERT_EQ(raise(SIGUSR1), 0);
+	ASSERT_NE(rs->cpu_id_start, -1);
+	ASSERT_NE(cpu_id_in_sigfn, -1);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/rseq/run_legacy_check.sh b/tools/testing/selftests/rseq/run_legacy_check.sh
new file mode 100755
index 000000000000..5577b46ea092
--- /dev/null
+++ b/tools/testing/selftests/rseq/run_legacy_check.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+GLIBC_TUNABLES="${GLIBC_TUNABLES:-}:glibc.pthread.rseq=0" ./legacy_check
-- 
2.54.0




